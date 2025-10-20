Return-Path: <linux-nfs+bounces-15419-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB36BF2D80
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 20:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF0A423228
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 18:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED8A2C0F7A;
	Mon, 20 Oct 2025 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="Aah9i52M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98532C0F7F
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983218; cv=none; b=oUBuHajQP2LyhyHSrJ9bIkJsAysF4cqGh+9Ge9hb0AJVH/S4if3YWRNguvPyohjOql9M6CS4CVnPrlIvb65MWxzhEKp2/J+mdvIMs0MnZ9mOHJqRkOgqH3nYBztjWnIJ2/fBDPjFK/jRf8i5N4MK5GJJNj8yW6lOx5BloKAGOeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983218; c=relaxed/simple;
	bh=JSEhntGZPRORcwVtx9zTmPcfFjUk/EBm0a5XmA59JU8=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=MUm092zD9IdakXtsXLzrAlpdry/6nnBc9ugEjUj/6+cpGadOvbPfb8uRfVaTStU/AWT7pv8jlJwy5mce1Sayp6FEio1LOsDdlTNRxe1+jKuowYV1TiMgTIIG2IgfO5WMLbb4NgmWAGdoWD1MvKZkWgFzd2oCGCghjx9Vi3KLWag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=Aah9i52M; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [IPv6:2001:638:700:1038::1:9b])
	by smtp-o-3.desy.de (Postfix) with ESMTP id 07F6311F833
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 19:54:46 +0200 (CEST)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 7D85713F647
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 19:54:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 7D85713F647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1760982878; bh=EPT+yESiiyiyGYUzO/HvEzns2/0POux9DtTb56JTB8w=;
	h=Date:From:To:Subject:From;
	b=Aah9i52M1H3a9uWB1JDAUhR8xeZWmW7lZeUrgs461dlw9Btz+QM7pJjVSZOQwQKtW
	 XuyvtolZ3kZDZjAPPGkN4+bdnq+OFcstVbpa7qp+HuDc2RaLOZiA4zXBqmcbBZcEWZ
	 mV5QRZjKxTW+i7MCWaaCEKxFWPS9u5eeIfiB6F/A=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 746BB20056
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 19:54:38 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [194.95.233.47])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 6C98416003F
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 19:54:38 +0200 (CEST)
Received: from smtp-intra-3.desy.de (smtp-intra-3.desy.de [131.169.56.69])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id EAB85320093
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 19:54:37 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-3.desy.de (Postfix) with ESMTP id CE3C21A0048
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 19:54:37 +0200 (CEST)
Date: Mon, 20 Oct 2025 19:54:37 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <707767179.31268962.1760982877695.JavaMail.zimbra@desy.de>
Subject: internal error code leakage into user space
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_31268963_793322388.1760982877742"
X-Mailer: Zimbra 10.1.10_GA_4785 (ZimbraWebClient - FF143 (Linux)/10.1.10_GA_4785)
Thread-Index: 5RhIDJgur5ByhiZjSIOLkN6C/rlSIw==
Thread-Topic: internal error code leakage into user space

------=_Part_31268963_793322388.1760982877742
Date: Mon, 20 Oct 2025 19:54:37 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <707767179.31268962.1760982877695.JavaMail.zimbra@desy.de>
Subject: internal error code leakage into user space
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.1.10_GA_4785 (ZimbraWebClient - FF143 (Linux)/10.1.10_GA_4785)
Thread-Index: 5RhIDJgur5ByhiZjSIOLkN6C/rlSIw==
Thread-Topic: internal error code leakage into user space


Hi NFS-people,

In f06bedfa62d5 I update updated the client to breaks the retry loop when application is interrupted.
Lately we have noticed, that on unmount during write, client leaks internal error code to the application,
for example:

`dd: failed to open 'file.1': Unknown error 512`

I think nfs4_map_errors function should map ERESTARTSYS to something that user-space is aware of. What should
be the appropriate error code, EIO? This is the fix that I am thinking of:


diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 411776718494..031881172a4b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -197,6 +197,7 @@ static int nfs4_map_errors(int err)
                return -ENOTSYNC;
        case -ENETDOWN:
        case -ENETUNREACH:
+       case -ERESTARTSYS:
                break;
        default:
                dprintk("%s could not handle NFSv4 error %d\n",


Best regards,
  Tigran.
------=_Part_31268963_793322388.1760982877742
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
MBwGCSqGSIb3DQEJBTEPFw0yNTEwMjAxNzU0MzdaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIC+7cDsOZiaEIadP74wJ8OWyGOM4
+t964NfZry7yyoppMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICAAXHwKB9ofcI3ga9vNDO+W9P+QyNYgqzJOL5Hbb6
oKQ8n0E11V2MnfiU+mKF3oZCsBqODBlxuo05ouDFuvZNl/26C/gdGhBGlVIKTHRIOCeBqkCuURO7
U9Ipt1wkFjGRWggtAbhl+waUTe8Y8LRhpj5Ioj8DfM7a4vUmqdRfJxUSi8oLWPPygxyS/WnOPGUl
TwXfbxKrD0d55dSgax++YYb0MxtbXZsZEtx1kRPuEQz6IsQt6lUoIrCNyjJRkE5WUtUL4loUwmII
qlmchVUwqMd6oSutuMUEvkfWto788L3AfqwTVM8Jl63AZkZnAhM06YXLyyiGFhSk18PMZpXhIPf7
/giGjT8cH2b7pGj9ukY9DaCFk/yK2is9nLAsMUTBVOIKgmG95rDN0lYl6kzObJ60fCahwIF35BqN
vgX8OqkiO6LGIl8dsqSMza/MGwMfyNCIXPMt6IYs2t/EydT7hAHE7Vc0ijo2MoN6iSr+XAr29mAN
PlKngGGFmZywU0vBfwW6diJLIj44oSbnIjCR9RlC87mJ6icZoAaPVu1yEaLLUnAZWuJ/JbSh90aJ
co0T0sfBXDO14H6SpwKeCiJyj7Fz8lmt9dnjSMDQ/iEzYwRtdadWmrxTnuKwyAFdTOusYfBy7xxC
8UKHFNM4HJLNcb0S1Bb484HgqYKHOBZ4WeMDAAAAAAAA
------=_Part_31268963_793322388.1760982877742--

