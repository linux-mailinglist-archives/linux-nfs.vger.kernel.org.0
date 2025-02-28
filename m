Return-Path: <linux-nfs+bounces-10391-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73228A4A159
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2025 19:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733BB1735A0
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2025 18:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EB81F4CBF;
	Fri, 28 Feb 2025 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="nwq0LkQ3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCBD1F0995
	for <linux-nfs@vger.kernel.org>; Fri, 28 Feb 2025 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740766966; cv=none; b=LjEr7hGbTx9jB+8XdYX8x9Wep8KZ72SGPP6lA4wKlXywvC6v1o+qaUyXV4+yJL0sGYMSsUAprkinlZX1iARBUu3eHiOyR2mlnTcCQ5pp/XDqk6OAfgCZqTKyoCFAv8oTDP3yf2OaSXNbFM3KiyUo3q3n4zXmYilHB9vZ+GKYGFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740766966; c=relaxed/simple;
	bh=Wy3dyARGgrrTrpIuLxmuGw+cg/ABRhvBD3c/WpFFtn0=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=BqjM6JwTzB6TmCQfbUexGE5A1Zl1GTq87gR/1My2+b/alLk1qtY5tgeuatmCE1LLpptOxrHFB1+Wc8OaVJ3zIdvWa2abItkuCc05H6B5qzzafp73MBcflLw6W9XntZB+vKEPOuCBZTk29NjoiRKdIOgs7ulaEmhWR6cvYg+DffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=nwq0LkQ3; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	by smtp-o-3.desy.de (Postfix) with ESMTP id C343311F8FA
	for <linux-nfs@vger.kernel.org>; Fri, 28 Feb 2025 19:13:51 +0100 (CET)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-2.desy.de (Postfix) with ESMTP id ADDA613F647
	for <linux-nfs@vger.kernel.org>; Fri, 28 Feb 2025 19:13:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de ADDA613F647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1740766423; bh=u6UNwY/YjLpQ2FUv/AMxFGh0RX1pCY766l/OKjJaE8E=;
	h=Date:From:To:Cc:Subject:From;
	b=nwq0LkQ3kr+6Rm258N4h7mzZg6W09YBUEsJ/KiYPEJT9vLZugBI/CvKEjTsreYxIe
	 mFP2cHYNRanLl+vHWULwYzvCAit+VvUgOKwGXpWYQGZMvlTAKubveC5ipjru7n+EZm
	 985ytHsJgXLiIxZms9C370SSn1zFvgBAwaPPxTlQ=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id A1023120043;
	Fri, 28 Feb 2025 19:13:43 +0100 (CET)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [IPv6:2001:638:d:c303:acdc:1979:2:e7])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 9567040044;
	Fri, 28 Feb 2025 19:13:43 +0100 (CET)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id C0D46104AF0;
	Fri, 28 Feb 2025 19:13:42 +0100 (CET)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 3E3F120044;
	Fri, 28 Feb 2025 19:13:42 +0100 (CET)
Date: Fri, 28 Feb 2025 19:13:42 +0100 (CET)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Cc: trondmy <trondmy@kernel.org>, Olga Kornievskaia <aglo@umich.edu>
Message-ID: <319477679.6763859.1740766422175.JavaMail.zimbra@desy.de>
Subject: Unexpected low pNFS IO performance with parallel workload
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_6763860_1500231424.1740766422188"
X-Mailer: Zimbra 9.0.0_GA_4718 (ZimbraWebClient - FF135 (Linux)/9.0.0_GA_4737)
Thread-Index: 3jnUn1Ic/xPZuCyLK5LAF+5KLWH+jA==
Thread-Topic: Unexpected low pNFS IO performance with parallel workload

------=_Part_6763860_1500231424.1740766422188
Date: Fri, 28 Feb 2025 19:13:42 +0100 (CET)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Cc: trondmy <trondmy@kernel.org>, Olga Kornievskaia <aglo@umich.edu>
Message-ID: <319477679.6763859.1740766422175.JavaMail.zimbra@desy.de>
Subject: Unexpected low pNFS IO performance with parallel workload
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4718 (ZimbraWebClient - FF135 (Linux)/9.0.0_GA_4737)
Thread-Index: 3jnUn1Ic/xPZuCyLK5LAF+5KLWH+jA==
Thread-Topic: Unexpected low pNFS IO performance with parallel workload


Dear NFS fellows,

During HPC workloads on we notice that Linux NFS4.2/pNFS client menonstraits unexpected low performance.
The application opens 55 files parallel reads the data with multiple threads. The server issues flexfile
layout with tighly coupled NFSv4.1 DSes.

Oservations:

- despite 1MB rsize/wsize returned by layout, client never issues reads bigger that 512k (offten much smaller)
- client always uses slot 0 on DS, and
- reads happen sequentialy, i.e. only one in-flight READ requests
- following reads often just read the next 512k block
- If instead of parallel application a simple dd is called, that multiple slots and 1MB READs are sent

$ dd if=/pnfs/xxxx/00054.h5 of=/dev/null
45753381+1 records in
45753381+1 records out
23425731171 bytes (23 GB, 22 GiB) copied, 69.702 s, 336 MB/s


The client has 80 cores on 2 sockets, 512BG of RAM and runs REHL 9.4

$ uname -r
5.14.0-427.26.1.el9_4.x86_64

$ free -g
               total        used        free      shared  buff/cache   available
Mem:             503          84         392           0          29         419

$ lscpu | head
Architecture:                       x86_64
CPU op-mode(s):                     32-bit, 64-bit
Address sizes:                      46 bits physical, 48 bits virtual
Byte Order:                         Little Endian
CPU(s):                             80
On-line CPU(s) list:                0-79
Vendor ID:                          GenuineIntel
BIOS Vendor ID:                     Intel(R) Corporation
Model name:                         Intel(R) Xeon(R) CPU E5-2698 v4 @ 2.20GHz
BIOS Model name:                    Intel(R) Xeon(R) CPU E5-2698 v4 @ 2.20GHz

The client and all DSes equiped  with 10GB/s NICs.

Any ideas where to look?

Best regards,
   Tigran.
------=_Part_6763860_1500231424.1740766422188
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
MBwGCSqGSIb3DQEJBTEPFw0yNTAyMjgxODEzNDJaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIFGlWpqev3uXZe3m1Djz+iwmULgr
1Js/7ufoBfxVWnGRMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICAC254dGlXCOs3OHVx2Sts7sLlzFuz8qjfXIJxVGw
PjhHVnTygCLf2HJ3sR40YO5x10r/J3ti4z8S1bfk972cI2Gn75vNwd3HBNVxX95ZgK9QPPWy1aZx
ksExKcmLAQhVPYgtC1v0BuTAGyU4WEHMBuXOtEYWfi0QKLfgnXbJz4NCcGLCqKopeao69NeQh4Ng
+rEK7k7GZwLGXPIE42i/udexHKZMXs8t2GRG/wCGp9yP0vRCLo5iLYzRnmST9KLGgmw82jFFX+wl
rxC/SVu6SdhPmDH24EXpY6yqan469+aZcNaCyfNAlNgk3paOIaag4F65GUHFD5yFrHpAMGsGjGgU
/80oucaB+k9Osie/Af9v735kDFXF3kji/blLvoEv4zkDjdJBjkmqvV1s/C85ZTdkIOUCc2uBmxWK
bmDab5fpCU/QKg6ToEUyRdSkjftVcX3ADiG7GLxakQiNJ0ThDmnhy9vBdh2K2HleDfJkQare5Gy+
PsmGIOIt9ZQP7vS+wrDNymOQNuLQgVyOz0UVKqHpCGm8kjZcUpdbik3X4r99b6VPumHD9+tYUPft
Grb1cc5cBlFHbQF0vTibwa3euCkVxjygyixwcXyBswjd5MatOke4MBE22dm2lvExaa1M1AehLT4r
DI0/e2WVqvP+bWc1bAid/76F7N/B96M5y69PAAAAAAAA
------=_Part_6763860_1500231424.1740766422188--

