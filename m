Return-Path: <linux-nfs+bounces-20819-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIh/DvFs3GnVQgkAu9opvQ
	(envelope-from <linux-nfs+bounces-20819-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 06:11:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C643E72C4
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 06:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C47F3016CBA
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 04:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD52237F72B;
	Mon, 13 Apr 2026 04:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MJYuXo1b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D714737F013
	for <linux-nfs@vger.kernel.org>; Mon, 13 Apr 2026 04:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053252; cv=pass; b=PDPpMV2bjRHBcMGijTW/haPjY6Lob2hQ9QQEX71s4aarbe+iyPXmNFQFDfDKURIIljp/oCtgKfyKomPPBv6POmNp5iHwgAc7jefl1gR9aS/6RiMCm+a/fhkZ3b+zUb2DgvSO9Z/BLK2rbXu5pn2VJDC6Nwj3CnI1IxFlwXQn/lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053252; c=relaxed/simple;
	bh=jSzJCHRcxR6zBhUblOil0mJJCTa/vzlzE3FJT2TR5tw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NcBPbehwli20LudPr/cnGYKQHXbsWR7ET5RU8irnfPTSOXVVaNk9evJTUKqkgyURICljeIUg2oIkRBvmLxLEcQ2RZEgTFRHIJOUliUlsxoLvlqSxwAw0xyHQ0yGfLLf7URtESGo7ZKyXXmILKsN60Lqm6ru0CFL+A477+elZyi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MJYuXo1b; arc=pass smtp.client-ip=209.85.161.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-6830f4f34c9so2035866eaf.3
        for <linux-nfs@vger.kernel.org>; Sun, 12 Apr 2026 21:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053243; x=1776658043;
        h=to:subject:message-id:date:from:mime-version:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSzJCHRcxR6zBhUblOil0mJJCTa/vzlzE3FJT2TR5tw=;
        b=sdn4tw76RWC0xCTS+SCUobtW/hQE/3/f84oF78sdtvdJFBvytKraR6Pps5hqam4UPt
         5nTm9GATjKWq/uFiw9e8L1IjH/YGPZStv0vShS45euGbRX+COKh8drCKzdWyfxx8fzIO
         Nwt7guxTYCx6w4LHWW04tuqN2aPigGngebsBRWULUIr7v2onb9u8ft3cvDEjzHCwpOMZ
         /aul9RIIzU6o5gyiGlkHnIFiROFLXMELd5lYOvqrj1VlK+Y2k72NoD5ft9nV7oGGYJlR
         qpvTPghmf63SVp/+C2RiilF3e29/Hk1aLQvgd1tM6s3AFt0dV8Vf/cuqcTTq+S/9jg1a
         Cakg==
X-Gm-Message-State: AOJu0YykID7Dcsscm5AHNAqiXOLGWFVceSNPhqqj0VGmbaZIjaASHX1R
	OoPd35NZnQtCjNSLJg/FePuhKXTT6E95/xaShE800lJ95Wf6huXqCfRTJ4yhb6JfAhfr5syFrS4
	jIYqKAA1d1EJoIi0HDPepj+vguzD9LmYqr2nI3TF62krpckFTmoXfbFSjVStuzqAoYva3Bdeoau
	yAEHa4Nff669cMqdO0Gm8U1P3M69+NK17bPJZzlouB+I2ao1Z6k4nGMPwFcy4+c+c6n67Q8IxBF
	kBXci4AVJewx1s=
X-Gm-Gg: AeBDies9ns+E41YOVPDjFGHhbVB3jPzZa214GBOlj/LLeUruOpuiXTMrNNG3x6jh+ts
	Omk4kACz1kb/alGU9EJMhlbKn/kjpVIIoUcjrKSd3V93jP0hsomm2RGBLrgN5vhoeuUeHIjK4fN
	NaL+5OFC3pZf0O0dzP29VqCdJjpPV9/7gL0fbals50JETopa1EwwUn4lOLoe/933oF0/R5mLec5
	R/jIusd8pIuEM2AHBr7FtaALd3BDVa3S9itZvOV8jlriMgMLm8VwtEI0SKj2jKv0ocJ3ZuEe3rr
	TJMbvCYTThK0HGhJ9z9v/Ghw5Ikxp0DSpLgpr0n0MhX/RbGF+sBG583FoHzFamfYaJ86QhRYgss
	EXsecQcELOGqZSstXueuCjoH1ZIjhQJOJwBVkF2ZspxNAFa1/8cPMs//N0gETp8V7yuS222PYkD
	pJqL1I+NYtadoZHQWE3tKrQtwvuXUtjsvxuMro05UGzk1aPXFDuhkyZ3gj
X-Received: by 2002:a05:6820:2e8c:b0:67d:e0fe:8434 with SMTP id 006d021491bc7-68be671f6d2mr4101157eaf.27.1776053243519;
        Sun, 12 Apr 2026 21:07:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-423dda062b3sm1172023fac.9.2026.04.12.21.07.22
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2026 21:07:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-686e8d94970so6839869eaf.1
        for <linux-nfs@vger.kernel.org>; Sun, 12 Apr 2026 21:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776053242; cv=none;
        d=google.com; s=arc-20240605;
        b=gjq9ef6dAbaWRp6Pr2TYV/++lNFLhg+mcoyJMPrv9Dl+8No68r/lF+J0VDNIgdq8ge
         B5+fG4X1J5oxDTlj6q8Ev7ruevHuAl7/aUxxidrzYplm/AyLjHgw5caIz4oS7bGdCxu9
         UwbsfxK3+VpUa9ALHapdaPbd0ouIoEidM6UnvXnf+k+NCo6K665FM3SqI8b3R+7czVUf
         MTDBMt5v0ktEpQ8f2grqrQ5E0PzVn0XlGFFiSmM0tWyg/xkWpVppM9H/rfJYfIoyQJRv
         mdJkG9dDpFSLwBaKhK+stNpsMYFvFLV6pKjvWbmLAdDFeNixcM99phEqy+gLQsA22y8c
         jCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=jSzJCHRcxR6zBhUblOil0mJJCTa/vzlzE3FJT2TR5tw=;
        fh=Mys3y4MwsHRytUQMpdfGBn3oGRYLcLloxNwkFYMYMmg=;
        b=ZeWQVD7ijgJ8wb0bkcnOnmQGcqIIqrvniktmXedxhxaZT6McFu/bRMAMHUFsTr4YEb
         KN4/XeVTHd/gsfo7zmAaN2BFdcWueEfIaWiV4UfFovIH9Pii6FGDda/a4y+WJTqDjjpQ
         AOVUjlXjO81+w/1HfxVCnXS5ajzhlyxWTTChNVS9uCRnWgQ7NXv4TwZ6qIgu8/CLn/+A
         bHd/SMQ6HYTjrEPtrXD4otC3Fab5lGkqJWbt0vger+S4wzwu4nTGk0WwBSZLGNKY7kYg
         +kTVzUKX9BUH7L9GzZ/+UrUz8meTATDIbLkq7VQgK6da6+NPDQj6l18wCFT8rMJf4nwG
         QMFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776053242; x=1776658042; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jSzJCHRcxR6zBhUblOil0mJJCTa/vzlzE3FJT2TR5tw=;
        b=MJYuXo1bLj67u/uyujhrNAWsVEIZIupdrVRQMbbfJEDfNh1q8fuk7XGG2QSEvXlj9T
         lqJu52ooROoAg82gC5eeHKfc9TfeJwREHTRF4aYIRQ8noyr++QbddDOLwg28CrON+LrW
         lp9fy9YveHE3PcULjQ3IQ4kma4EfAhJjFl1Ao=
X-Received: by 2002:a05:6820:2207:b0:684:e5db:c3c with SMTP id 006d021491bc7-68be89e9310mr6216134eaf.53.1776053241832;
        Sun, 12 Apr 2026 21:07:21 -0700 (PDT)
X-Received: by 2002:a05:6820:2207:b0:684:e5db:c3c with SMTP id
 006d021491bc7-68be89e9310mr6216129eaf.53.1776053241352; Sun, 12 Apr 2026
 21:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sunil Bhargo <sunil.bhargo@broadcom.com>
Date: Mon, 13 Apr 2026 09:37:04 +0530
X-Gm-Features: AQROBzCo14yzi1jB6UzH9oBzYr16fWaUa9nE4t1ws-8RS9e4wremoplQiT3Zum8
Message-ID: <CABKB_79e89d3Yq8YpT2iQT8=kH3Eyz4pA1rY6_=eRTHvaG-KLA@mail.gmail.com>
Subject: PNFS block layouts
To: linux-nfs@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000994d6b064f4f9ee4"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/alternative,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	RCPT_COUNT_ONE(0.00)[1];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_FROM(0.00)[bounces-20819-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunil.bhargo@broadcom.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim]
X-Rspamd-Queue-Id: 95C643E72C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000994d6b064f4f9ee4
Content-Type: multipart/alternative; boundary="0000000000008e03b8064f4f9eee"

--0000000000008e03b8064f4f9eee
Content-Type: text/plain; charset="UTF-8"

Hi,

I hope this is the proper forum for NFS PNFS related questions, if not can
you please point to the proper mailing list.

I have couple of questions regarding PNFS block layouts:-

1) Is there any limitation in Linux client regarding number of segments in
layoutget that it can handle for block layouts? By segments I mean any
limit on number of entries in blo_extents on client side

/// struct pnfs_block_layout4 {


 /// pnfs_block_extent4 blo_extents<>;


/// /* extents which make up this /// layout. */

 /// }; ///



2) I see that the Linux server recalls(RECALLCONFLICT) the layouts for
clients if there are more than one client requesting for iomode of
even READ for an overlapping range ? Any reason why iomode of READ should
result in conflict ?

Any pointers would be helpful.

Thanks,
Sunil Bhargo

--0000000000008e03b8064f4f9eee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I hope this is the proper forum for=
 NFS PNFS related questions, if not can you please point to the proper mail=
ing list.</div><div>=C2=A0</div><div><div style=3D"color:rgb(13,13,16)">I h=
ave couple of questions regarding PNFS block layouts:-</div><div style=3D"c=
olor:rgb(239,234,231)"><br></div><div style=3D"color:rgb(13,13,16)">1) Is t=
here any limitation in Linux=C2=A0client regarding number of segments in la=
youtget that it can handle for block layouts? By segments I mean any limit =
on=C2=A0number of entries in blo_extents on client side=C2=A0</div><div sty=
le=3D"color:rgb(239,234,231)"><br></div><div style=3D"color:rgb(13,13,16)">=
<pre style=3D"color:rgb(0,0,0);font-size:1em;margin-top:0px;margin-bottom:0=
px">/// struct pnfs_block_layout4 {</pre><pre style=3D"color:rgb(226,221,21=
5);font-size:1em;margin-top:0px;margin-bottom:0px"><br></pre><pre style=3D"=
color:rgb(0,0,0);font-size:1em;margin-top:0px;margin-bottom:0px"><span styl=
e=3D"font-size:1em;font-family:YahooProductSans-VF,HelveticaNeue-Regular,He=
lvetica">=C2=A0/// pnfs_block_extent4 blo_extents&lt;&gt;;</span></pre><pre=
 style=3D"color:rgb(226,221,215);font-size:1em;margin-top:0px;margin-bottom=
:0px"><span style=3D"font-size:1em;font-family:YahooProductSans-VF,Helvetic=
aNeue-Regular,Helvetica"><br></span></pre><pre style=3D"color:rgb(0,0,0);fo=
nt-size:1em;margin-top:0px;margin-bottom:0px"><span style=3D"font-size:1em;=
font-family:YahooProductSans-VF,HelveticaNeue-Regular,Helvetica">/// /* ext=
ents which make up this /// layout.</span><span style=3D"font-family:YahooP=
roductSans-VF,HelveticaNeue-Regular,Helvetica;font-size:1em">=C2=A0*/</span=
></pre><pre style=3D"color:rgb(0,0,0);font-size:1em;margin-top:0px;margin-b=
ottom:0px"><span style=3D"font-family:YahooProductSans-VF,HelveticaNeue-Reg=
ular,Helvetica;font-size:1em"></span><span style=3D"font-family:YahooProduc=
tSans-VF,HelveticaNeue-Regular,Helvetica;font-size:1em">=C2=A0/// }; ///</s=
pan></pre></div><div style=3D"color:rgb(239,234,231)"><br></div><div style=
=3D"color:rgb(239,234,231)"><br></div><div style=3D"color:rgb(13,13,16)">2)=
 I see that the Linux server recalls(RECALLCONFLICT)=C2=A0the layouts for c=
lients if there are more than one client requesting for iomode of even=C2=
=A0READ for an overlapping range ? Any reason why iomode of READ should res=
ult in conflict ?</div><div style=3D"color:rgb(239,234,231)"><br></div><div=
 style=3D"color:rgb(13,13,16)">Any pointers would be helpful.</div><div sty=
le=3D"color:rgb(239,234,231)"><br></div><div style=3D"color:rgb(13,13,16)">=
Thanks,</div><div style=3D"color:rgb(13,13,16)">Sunil Bhargo=C2=A0</div></d=
iv></div>

--0000000000008e03b8064f4f9eee--

--000000000000994d6b064f4f9ee4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
QxUYggR6uP5dOhUGQc3fnXmN7X0+wDXchrax2Tee4nXyaUjGv4ufq4h2b1qqIaai0bb8+QMqSCox
06T2l3AUAFhSdlQI6pofjoHDsIi0wc/FKf3txd82Q/NuVoa8aDiaVyQWMfS+u+GSJ3XpSz06liRZ
0O0Jcw7INowQOBXHKos0C3euiOLUzVAmOxFTVxtKW/EvAtMK9IGvfaPsHxzAL+a7/ltIqCkyFzWT
UuNoVMCdfuuLLsyGsf1xHEDE/igjV9ET9PQGLNsCAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZc3VuaWwuYmhhcmdvQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQU7S4JmCcsnrLTbuhWEZ3bu3j8
awIwDQYJKoZIhvcNAQELBQADggIBAJUcWWEeJcdivqW8FoSDHgfuYj+NCClU7THeLoxm4Ha8Rxu1
qe5DmB/3rHwmu1NGUIfhCDF/r2lfAOL22dt4Deap+k9qucRPqXeXlk1spW8QbcDcdfcqmHM6C7Qu
jPJSFPNto4XkCrWaJbNzNim47S79VTdfMX7HL2F+4z9gWXT8FlNH9c7xW/7bkwAbOIY3QhDVQ4xv
R7SAiyWTfh2auLnmptUYPnI3+sNY2rqFaFgdtqnLn6Ekf4cFnmq8P9PESsNoaketklaMEvuiofpx
kNKNgAJ6A9NFzIsR68AhLkInQHsEU6H7URclODVsE/S5+y8zI3ktvfbunZapkCX+GnOH5fzXxfyi
I+x0avqqLHPJCOIB7/pvgG7dY90kxEw6lzf3zL1oFcqnckVivdDKMlgH0PG0tSUoUGfGkPE/i8ds
y5trUpY8OJqWcr76goov2lQrZooC+f2xxaLtyTgkAWK3TpaM7Sd6Rqtdk05FH5jMh7e86wWrYbZT
tA6EeWELtgP/29mFAW1ShfftyvR78KOEzoeyaxVL1K/sk940y3TqUDrUt0rT4qu65wH/suwJqKtS
TU+V77vCnD6KNfqFlgTXfrFXVuUrr/8g0ZiippiXf7QWUQYJK0rwMAzlI3QEnVuMhTnvV9Rg9W8F
tt5rNqgkFnBguwzKuH3eziuOC9mTMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMSPV8MM8QAJ/ohRGWMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDWjrNB
XPCiyG9Jj5TmfdWPUTIX/Q2Im2MDeIL8ZsmdjDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA0MTMwNDA3MjJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQApK5t0CnZ6K7sn+2mhGfrYQ3GJtPrDevRzAgnoUPiG
igjOz24jh5THkFGsRdoxAkFvMpusqW6zDxUp4H2eELvwohwb+XnKXF5ANzhg5WP+ArvwUsegs6Uo
mJOqKo0Frno4FpTE2nnPSVv3KwnmMlKZDG0quRWitSljUxgb+MIP+NW8cfVsEC0hi2D/mr8w2adz
Xu4+JR7PYACNHWsK6HTOwji9fMyeKxqlQbN/KzK3L9qD5dlsc3r/UYfZs3kyHdhncsXPaTMPRPHH
GRvMFuHlOjfglonpCuAPGcfZQ6h5YXLaBmiaZm3X+bwR/6gyVHNs7BnWpBa9aPFTe5Zd1DcS
--000000000000994d6b064f4f9ee4--

