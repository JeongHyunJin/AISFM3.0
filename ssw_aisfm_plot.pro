;+
; NAME:
;     ssw_aisfm_plot.pro
;
;
; Syntax:  ssw_aisfm_plot, fpath, /SSW, /DirectGraphic, /PrintHeader
;
;
; PURPOSE:
;     Visualizations of the AI-generated Solar Farside Magnetograms 
;     (AISFMs). This example shows how to plot the AISFMs using the
;     Interface Description Language (IDL).
;     (https://www.l3harrisgeospatial.com/Software-Technology/IDL)
;     If you are installing the SolarSoftWare for the first time, 
;     choose the secchi and aia packages.
;     (https://www.lmsal.com/solarsoft/)
;
;
; Arguments:
;     Filename = Scalar string containing the name (and directory)
;                of the AISFM file (including extension) to be read.
;              
;                
; Keywords:
;     /SSW - if set, read the AISFM using the READ_SDO function of 
;            the SolarSoftWare.
;
;     /DirectGraphic - if set, show the AISFM using the IDL Direct
;                      Graphics.
;             (https://www.l3harrisgeospatial.com/docs/intro.html)
;     
;     /PrintHeader - if set, print header information of the AISFM.
;     
;     
; Written:
;     Hyun-Jin Jeong, KHU, 10 May 2022. 
;     
;_________________________________________________________________________


PRO SSW_AISFM_PLOT, Filename, SSW=SSW, DirectGraphic=DirectGraphic, PrintHeader=PrintHeader


;_________________________________________________________________________
; Read the AISFM file.
    
    IF NOT KEYWORD_SET(Filename) THEN BEGIN
        Filename = "./Sample_AISFMs/aisfm_v3_stereo_b_20110305_120403.fits"
    ENDIF
    
    IF NOT KEYWORD_SET(SSW) THEN BEGIN

        AISFM_Data = READFITS(Filename, AISFM_Header)
        WCS = FITSHEAD2WCS(AISFM_Header)
  
        NAXIS1 = LONG(WCS.NAXIS[0])
        NAXIS2 = LONG(WCS.NAXIS[1])
        CDELT1 = FLOAT(WCS.CDELT[0])
        CDELT2 = FLOAT(WCS.CDELT[1])
        CRPIX1 = FLOAT(WCS.CRPIX[0])
        CRPIX2 = FLOAT(WCS.CRPIX[1])
        CRVAL1 = FLOAT(WCS.CRVAL[0])
        CRVAL2 = FLOAT(WCS.CRVAL[1])
        
        AISFM_date =  SXPAR(AISFM_Header, 'T_OBS')
        Title_tag = 'AISFM' + ' [ ' + AISFM_date + ' ]'
      
    ENDIF ELSE BEGIN
        
        READ_SDO, Filename, AISFM_Header, AISFM_Data

        NAXIS1 = LONG(AISFM_Header.NAXIS1)
        NAXIS2 = LONG(AISFM_Header.NAXIS2)
        CDELT1 = FLOAT(AISFM_Header.CDELT1)
        CDELT2 = FLOAT(AISFM_Header.CDELT2)
        CRPIX1 = FLOAT(AISFM_Header.CRPIX1)
        CRPIX2 = FLOAT(AISFM_Header.CRPIX2)
        CRVAL1 = FLOAT(AISFM_Header.CRVAL1)
        CRVAL2 = FLOAT(AISFM_Header.CRVAL2)
        
        AISFM_date = AISFM_Header.T_OBS
        Title_tag = 'AISFM' + ' [' + AISFM_date + ']'
        
    ENDELSE
    
    SolarX = (FINDGEN(NAXIS1) + 1 - CRPIX1) * CDELT1 + CRVAL1
    SolarY = (FINDGEN(NAXIS2) + 1 - CRPIX2) * CDELT2 + CRVAL2
    
  
;_________________________________________________________________________
; Create a window and display the AISFM.

    LOADCT, 0
    
    IF NOT KEYWORD_SET(DirectGraphic) THEN BEGIN
      
        win = WINDOW(DIMENSIONS=[512, 512], TITLE = Title_tag)

        im = IMAGE(AISFM_Data, SolarX, SolarY, $
                   MAX_VALUE = 100, $
                   MIN_VALUE = -100, $
                   XTITLE='Solar-X [arcsec]', $
                   YTITLE='Solar-Y [arcsec]', $
                   AXIS_STYLE = 2, /CURRENT)
                   
    ENDIF ELSE BEGIN
        
        byte_image = BYTSCL(AISFM_Data, -100, 100)
        
        WINDOW, 0, XSIZE = 512, YSIZE = 512, TITLE= Title_tag
        
        TV, REBIN(byte_image, [512, 512]), /device
        
    ENDELSE


;_________________________________________________________________________
; Print the header information of the AISFM.
    
    IF KEYWORD_SET(PrintHeader) THEN BEGIN
        IF NOT KEYWORD_SET(SSW) THEN BEGIN
            PRINT, AISFM_Header
        ENDIF ELSE BEGIN
            HELP, AISFM_Header
        ENDELSE
    ENDIF
    
;_________________________________________________________________________    

END