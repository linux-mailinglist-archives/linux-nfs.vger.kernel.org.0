Return-Path: <linux-nfs+bounces-13936-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 665B7B3A2B3
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 16:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF9E1882D22
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 14:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1715E97;
	Thu, 28 Aug 2025 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="AdFdykfR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10951EF363
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392714; cv=none; b=q+yUTec0GDmLn5CIVOcu48uxTL3/+BSwO+xgjv+8ycfebAYjDUC/py8LQdpj8DAlhJS/z1856LnG/yRKtBtg/APNrKrZZ1vkgAYHCyIduckRUSTa8F1VBanR2J2upacZp8Z4SFesgfHp0075SXYXTZhB5YwNjZWgeDAaS/iXbdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392714; c=relaxed/simple;
	bh=u87s/oprEOrm7otOERC5hdW4wgaUKfGsb8BNZeLkLmk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=isQ3h4CJT7oh85APUOyPc5FZVW8Y4NigL6AH7+dBD4dZL5DIuTwzUblW9jnOim3YuUdeZvg1UmPpIFM67CEvEkF7d8Xp/f9Po0x2xmPVT47gRhdUxdTCPtGKsSov2/ZTrdirFZjiH0QZTTdQD5KxqJoBbrVQJNcTHnXrPrThrbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=AdFdykfR; arc=none smtp.client-ip=131.169.56.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 70C8911F749
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 16:51:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 70C8911F749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1756392710; bh=VjbyU8EWbmPnk6ZFz/oSvjso90xT7Jnc/KjODpqk+nI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=AdFdykfR4BNcI/cuL8yF1CgPQqAvI6Q8dlDT8XF/+O96lBA2kQvdigX+CEONJ0i4F
	 bWc1u+jxSwsapM3xIw9FOFKzRaPX4/W3Ks7whKXYhwrZgXEj1u/tROBUs/3w2hQejk
	 uiXvvFtsWG15teUiOl8eUxAbdmhoPV5SZAxadiko=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 6525920056;
	Thu, 28 Aug 2025 16:51:50 +0200 (CEST)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [IPv6:2001:638:d:c303:acdc:1979:2:e7])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 58A2016003F;
	Thu, 28 Aug 2025 16:51:50 +0200 (CEST)
Received: from smtp-intra-3.desy.de (smtp-intra-3.desy.de [131.169.56.69])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id 21C3C100033;
	Thu, 28 Aug 2025 16:51:48 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-3.desy.de (Postfix) with ESMTP id E11601A0041;
	Thu, 28 Aug 2025 16:51:47 +0200 (CEST)
Date: Thu, 28 Aug 2025 16:51:47 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: trondmy <trondmy@kernel.org>, anna schumaker <anna.schumaker@oracle.com>, 
	linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1771643153.4661155.1756392707644.JavaMail.zimbra@desy.de>
In-Reply-To: <aLBp5eajfo00ew7D@stanley.mountain>
References: <20250828133843.1057488-1-tigran.mkrtchyan@desy.de> <aLBp5eajfo00ew7D@stanley.mountain>
Subject: Re: [PATCH] flexfiles/pNFS: fix NULL checks on result of
 ff_layout_choose_ds_for_read
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_4661156_979920268.1756392707867"
X-Mailer: Zimbra 10.1.10_GA_4785 (ZimbraWebClient - FF142 (Linux)/10.1.10_GA_4785)
Thread-Topic: flexfiles/pNFS: fix NULL checks on result of ff_layout_choose_ds_for_read
Thread-Index: SEexOz54Q1EMCu4sd4kvG5X3uekcHQ==

------=_Part_4661156_979920268.1756392707867
Date: Thu, 28 Aug 2025 16:51:47 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: trondmy <trondmy@kernel.org>, anna schumaker <anna.schumaker@oracle.com>, 
	linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1771643153.4661155.1756392707644.JavaMail.zimbra@desy.de>
In-Reply-To: <aLBp5eajfo00ew7D@stanley.mountain>
References: <20250828133843.1057488-1-tigran.mkrtchyan@desy.de> <aLBp5eajfo00ew7D@stanley.mountain>
Subject: Re: [PATCH] flexfiles/pNFS: fix NULL checks on result of
 ff_layout_choose_ds_for_read
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.1.10_GA_4785 (ZimbraWebClient - FF142 (Linux)/10.1.10_GA_4785)
Thread-Topic: flexfiles/pNFS: fix NULL checks on result of ff_layout_choose_ds_for_read
Thread-Index: SEexOz54Q1EMCu4sd4kvG5X3uekcHQ==



----- Original Message -----
> From: "Dan Carpenter" <dan.carpenter@linaro.org>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> Cc: "trondmy" <trondmy@kernel.org>, "anna schumaker" <anna.schumaker@oracle.com>, "linux-nfs"
> <linux-nfs@vger.kernel.org>
> Sent: Thursday, 28 August, 2025 16:38:29
> Subject: Re: [PATCH] flexfiles/pNFS: fix NULL checks on result of ff_layout_choose_ds_for_read

> On Thu, Aug 28, 2025 at 03:38:43PM +0200, Tigran Mkrtchyan wrote:
>> Recent commit f06bedfa62d5 ("pNFS/flexfiles: don't attempt pnfs on fatal DS
>> errors") has changed the error return type of ff_layout_choose_ds_for_read()
>> from
>> NULL to an error pointer. However, not all code paths have been updated
>> to match the change. Thus, some non-NULL checks will accept error pointers
>> as a valid return value.
>> 
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Fixes: f06bedfa62d5 ("pNFS/flexfiles: don't attempt pnfs on fatal DS errors")
>> Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
>> ---
> 
> This is still not complete.
> 
>  1073  static void ff_layout_resend_pnfs_read(struct nfs_pgio_header *hdr)
>  1074  {
>  1075          u32 idx = hdr->pgio_mirror_idx + 1;
>  1076          u32 new_idx = 0;
>  1077
>  1078          if (ff_layout_choose_any_ds_for_read(hdr->lseg, idx, &new_idx))
>                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This should be:
> 
>	struct nfs4_pnfs_ds *ds;
> 
>	ds = ff_layout_choose_any_ds_for_read(hdr->lseg, idx, &new_idx);
>	if (IS_ERR(ds))
>		pnfs_error_mark_layout_for_return(hdr->inode, hdr->lseg);
>	else
>		ff_layout_send_layouterror(hdr->lseg);


Yeah, makes sense. Thanks!

Tigran.
> 
>  1079                  ff_layout_send_layouterror(hdr->lseg);
>  1080          else
>  1081                  pnfs_error_mark_layout_for_return(hdr->inode, hdr->lseg);
>  1082          pnfs_read_resend_pnfs(hdr, new_idx);
>  1083  }
> 
> Also the continue in ff_layout_choose_ds_for_read() still needs to be
> fixed as I mentioned earlier.
> 
> regards,
> dan carpenter

------=_Part_4661156_979920268.1756392707867
Content-Type: application/pkcs7-signature; name=smime.p7s; smime-type=signed-data
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCAMIIH
XzCCBUegAwIBAgIQGrSZ0tLzGu9JoeeaXGroSzANBgkqhkiG9w0BAQwFADBVMQswCQYDVQQGEwJO
TDEZMBcGA1UEChMQR0VBTlQgVmVyZW5pZ2luZzErMCkGA1UEAxMiR0VBTlQgVENTIEF1dGhlbnRp
Y2F0aW9uIFJTQSBDQSA0QjAeFw0yNDEyMDQwOTQzMjZaFw0yNjAxMDMwOTQzMjZaMIGpMRMwEQYK
CZImiZPyLGQBGRMDb3JnMRYwFAYKCZImiZPyLGQBGRMGdGVyZW5hMRMwEQYKCZImiZPyLGQBGRMD
dGNzMQswCQYDVQQGEwJERTEuMCwGA1UEChMlRGV1dHNjaGVzIEVsZWt0cm9uZW4tU3luY2hyb3Ry
b24gREVTWTEoMCYGA1UEAwwfVGlncmFuIE1rcnRjaHlhbiB0aWdyYW5AZGVzeS5kZTCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBAKZ1aJleygPW8bRzYJ3VfXwfY2TxAF0QUuTk/6Bqu8Bi
UQjIgmBQ1hCzz8DVdJ8saw7p5/c1JDmVHqm2DJPwXLROKACiDdSHPf+N8PFZvxHxOqFNPeO/oJhO
jHXG1c/tL8ElfiUlMtEZYtoS60/VUz3A/4FIWP2A5s/UIOSZyCcKz3AUcAanHGEJVS8oWKQj7pNX
yjojvX4aPHzsKP+c+c/5wq08/aziRXLCekhKk+VdS8lhlS/3AL1G0VSWKj5/pOpz4ozmv44GEw9z
FAsPWuTcLXqCX993BOoWAyQDcygAsb0nQQMzx+4wlSGsI31/gKOE5ZOJ3SErWDswgzxWm8Xht/Kl
ymDHPXi8P0ohQjJrQRpJXVwD/tXDwSSbWP9jnVbtqpvLLBkNrSy6elW19nkE1ObpSPcn+be5hs1P
59Y+GPudytAQ3MOoFoNd7kxpVQoM6cdQjRHdyIDbavZrdxr33s7uqSbcI/PE8W5M0iPNnd4ip4kH
UIOdpsjk7b7kEdO4Jf9dDrz/fduAEaW+AUTfb+G42LiftUBXkANa50nOseW3tocadYOTySufN9or
IwvcQ/1uemVd83On7k8bWevfU159x28aidxv8liqJXrrT28tp/QxtGtDXjo9jdkWi/5d/9XfqQgN
IT7KH42fc3ZlaL3pLuJwEQWVtFnWUTRJAgMBAAGjggHUMIIB0DAfBgNVHSMEGDAWgBQQMuoC4vzP
6lYlVIfDmPXog9bFJDAOBgNVHQ8BAf8EBAMCBaAwCQYDVR0TBAIwADAdBgNVHSUEFjAUBggrBgEF
BQcDAgYIKwYBBQUHAwQwRQYDVR0gBD4wPDAMBgoqhkiG90wFAgIFMA0GCyqGSIb3TAUCAwMDMA0G
CyqGSIb3TAUCAwECMA4GDCsGAQQBgcRaAgMCAjBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8vY3Js
LmVudGVycHJpc2Uuc2VjdGlnby5jb20vR0VBTlRUQ1NBdXRoZW50aWNhdGlvblJTQUNBNEIuY3Js
MIGRBggrBgEFBQcBAQSBhDCBgTBPBggrBgEFBQcwAoZDaHR0cDovL2NydC5lbnRlcnByaXNlLnNl
Y3RpZ28uY29tL0dFQU5UVENTQXV0aGVudGljYXRpb25SU0FDQTRCLmNydDAuBggrBgEFBQcwAYYi
aHR0cDovL29jc3AuZW50ZXJwcmlzZS5zZWN0aWdvLmNvbTAjBgNVHREEHDAagRh0aWdyYW4ubWty
dGNoeWFuQGRlc3kuZGUwHQYDVR0OBBYEFMmhx6vILo+tVVV6rojJTwL+t2eGMA0GCSqGSIb3DQEB
DAUAA4ICAQARKKJEO1G3lIe+AA+E3pl5mNYs/+XgswX1316JYDRzBnfVweMR6IaOT7yrP+Mwhx3v
yiM8VeSVFtfyLlV6FaHAxNFo5Z19L++g/FWWAg0Wz13aFaEm0+KEp8RkB/Mh3EbSukZxUqmWCgrx
zmx+I5zlX8pLxNgrxcc1WW5l7Y7y2sci++W6wE/L7rgMuznqiBLw/qwnkXAeQrw2PIllAGwRqrwa
37kPa+naT1P0HskuBFHQSmMihB5HQl6+2Rs9M5RMW3/IlUQAqkhZQGBXmiWDivjPFKXJQnCmhQmh
76sOcSOScfzYI5xOD+ZGdBRRufkUxaXJ2G//IgkK2R8mqrFEXxBFaBMc0uMBJHKNv+FO7H6VPOe9
BD9FwfLiqWvGwKJrF11Bk/QSfWh+zCJ8JHPAi6irwQO4Xf+0xhPsxb+jBfKK3I84YMf6zsDkdDzH
lkNPhDh4xhYhEAk+L228pjTEmnbb2QVv52grZ0dbITuN+Hz2ypvLfaS8p06lrht45COlkmuIUVqp
bsc3kRt610qwXSjYcc8zeCQI0Rqnnq+0UN5T0KU7JSzUho6vaTSUG57uc7b3DkIW2Z9VpXX5xKb/
vfl++jC5JzKrbCeS+QOStpXwwaH62IUHwdfWfkvpzb8EFALEmCvu8nlT9NaqYlB/xogMH6oHBm+Y
nxmRQxWROAAAMYIDZTCCA2ECAQEwaTBVMQswCQYDVQQGEwJOTDEZMBcGA1UEChMQR0VBTlQgVmVy
ZW5pZ2luZzErMCkGA1UEAxMiR0VBTlQgVENTIEF1dGhlbnRpY2F0aW9uIFJTQSBDQSA0QgIQGrSZ
0tLzGu9JoeeaXGroSzANBglghkgBZQMEAgEFAKCBzjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yNTA4MjgxNDUxNDdaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIFNqFs7zzcBpJivY5O4Q7Q+eIugx
/1ILLHglJD4shg+VMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICACtvLPXtFq14EQ4uumA0o6mx8ynJ0pYJ1P+eTZHO
i1hKwTBGULWClzC+ZO08BdrXmnA+08EkXbGkqP4/JUnYNBG5IFZpRDFLjirr9KNlFD2i5b6K4rKE
OpDgrBYgDDhakQEUtabGVi0P5pU8jMwrJVkl8FrxiHqvNRr8iue+EkWhmPlir8jXZDH+X1mS5Ge/
65kG2B8tZ2QPASLsKbyhYthkXw1e9MdqCifeYpKAtNiUHqBLZpX9Qewhp0z5Tb0eRBvOSQAyRtdJ
634iSCnwETGVYx1dJu8OZdk5frivvHDVAveb7VGLTc6+mVOYD7p0fug0qCaYc5OgHkxwiJ+/2WlY
Z08XXqzR1YuHfPvHcEDCm9sWY7pNjcqrwzlGsX2Vm/N80c8Em05lTym4x7c6K/41Wbh4b6P+5vRR
KmrfKCK1ukdLru/a1qDV9BHNcpdA7CMg5zHWLLTI//KtL7H+31SUFW5jmdGJZTbUfCj93ZifEpWJ
ARyCAV7ixu2FVWOwUxa2z8TGYZvkKqUPiAQFn0WwLzOhQvBDgD99ffqKpKl/sRE6S2yEgryypQkY
NNxB5+3stuzlWQA+IGjVdyWU2VPk/bD4Xkx7JXyRIkLSpp5cfu0e/mLB7r9xqZp82dUEzhc0jZpl
jMqm48baofyRXWl3k/xfCAv313Ix5ZZFi5uaAAAAAAAA
------=_Part_4661156_979920268.1756392707867--

