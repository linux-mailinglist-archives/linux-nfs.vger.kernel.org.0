Return-Path: <linux-nfs+bounces-10998-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7649AA7A361
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Apr 2025 15:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3156B173B74
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Apr 2025 13:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2186724E001;
	Thu,  3 Apr 2025 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="hWFGt5o6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB41C861F
	for <linux-nfs@vger.kernel.org>; Thu,  3 Apr 2025 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743685683; cv=none; b=Hv+4/TzQEMrtscUKmr7ZuqFhG3J8Ydyl3irRhqJgN95i7kJ83UcUf9kdGzuTxzvgfEeO+7YPlLzA5NdSSYjoFVwq3aIHCoYPAGs6LbueNAUAOtitEHLLRFjPSGrJO24dLOxKkPEeoY2b4FtAANKlAotz4FCXWuwFcTa2S3qLS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743685683; c=relaxed/simple;
	bh=7cOvKA9ogAoS1Minj6RxuOdHHkuRqf7dNFaAY0ei/lA=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=qhAFE0EwO6M9Ep4g9SguvMIiG7wcls4nk4pAq7swvszCiO0OCkhkCsfp3AsYdlBnChi1qLptBrGGusVN0SajDGoQhkVCjXU96nmRjWKYZ96g7SFogg+FM/GsYD7/Sc3kv8xwqgAGZOS15q0NWETNzOtCIHoucipe3j7rEE6WrC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=hWFGt5o6; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [IPv6:2001:638:700:1038::1:9a])
	by smtp-o-3.desy.de (Postfix) with ESMTP id AAA9F11F882
	for <linux-nfs@vger.kernel.org>; Thu,  3 Apr 2025 15:01:22 +0200 (CEST)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 3BEAC11F744
	for <linux-nfs@vger.kernel.org>; Thu,  3 Apr 2025 15:01:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 3BEAC11F744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1743685275; bh=IA1OSZbjnoq1tIuuQhpDHMjMtuHIzrmOnBSYsUyQYZI=;
	h=Date:From:To:Subject:From;
	b=hWFGt5o6d8OvNOq2bW6EfFdTybt/gnekyJm+muKkg2XYwFXmMlELMywtr9U3QNChw
	 J4QIs7DzkaxII5kvXWxLu/hbd5QvAjEjV8M0LFPkv5AkNYYL/invJCDMeSWlRTpe4u
	 3o0JNsAwSM30MSOnK9kO0sozKNlnIstwJNkLdHc4=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 30DFB120043
	for <linux-nfs@vger.kernel.org>; Thu,  3 Apr 2025 15:01:15 +0200 (CEST)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [194.95.235.47])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 29C8D40044
	for <linux-nfs@vger.kernel.org>; Thu,  3 Apr 2025 15:01:15 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by b1722.mx.srv.dfn.de (Postfix) with ESMTP id 9198F160058
	for <linux-nfs@vger.kernel.org>; Thu,  3 Apr 2025 15:01:14 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 7956720044
	for <linux-nfs@vger.kernel.org>; Thu,  3 Apr 2025 15:01:14 +0200 (CEST)
Date: Thu, 3 Apr 2025 15:01:14 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1976198229.23396586.1743685274389.JavaMail.zimbra@desy.de>
Subject: NFS client low performance in concurrent environment.
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_23396587_575441006.1743685274433"
X-Mailer: Zimbra 9.0.0_GA_4718 (ZimbraWebClient - FF137 (Linux)/9.0.0_GA_4737)
Thread-Index: cMHoeguRmpNPiBbNd8nM1Wga53JB5g==
Thread-Topic: NFS client low performance in concurrent environment.

------=_Part_23396587_575441006.1743685274433
Date: Thu, 3 Apr 2025 15:01:14 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1976198229.23396586.1743685274389.JavaMail.zimbra@desy.de>
Subject: NFS client low performance in concurrent environment.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4718 (ZimbraWebClient - FF137 (Linux)/9.0.0_GA_4737)
Thread-Index: cMHoeguRmpNPiBbNd8nM1Wga53JB5g==
Thread-Topic: NFS client low performance in concurrent environment.


Dear NFS fellows,

As part of research, we have adopted a well-known in the HPC community, IOR[1],
to support libnfs[2]. After running a bunch of tests, our observation is that the
multiple clients in userspace have a higher throughput than the in-kernel
client (or server).

In the test below, nfs server runs on RHEL9 with kernel 5.14.0-503.23.1.el9_5.x86_64
exporting /mnt. The results are in operations per second, thus, higher numbers are better.

The client is an 80-core single host, running RHEL9 with kernel 5.14.0-427.26.1.el9_4.x86_64.
We used NFSv3 in the test to eliminate NFSv4's open/close overhead on zero-byte files.


TEST 1: libnfs
```
$ mpirun -n 128 --map-by :OVERSUBSCRIBE  ./mdtest  -a LIBNFS --libnfs.url='nfs://lab008/mnt/?uid=0&gid=0&version=3' -w 0 -I 128 -i 10 -z 0 -b 0 -F -d /test
-- started at 04/03/2025 14:39:30 --

mdtest-4.1.0+dev was launched with 128 total task(s) on 1 node(s)
Command line used: ./mdtest '-a' 'LIBNFS' '--libnfs.url=nfs://lab008/mnt/version=3' '-w' '0' '-I' '128' '-i' '10' '-z' '0' '-b' '0' '-F' '-d' '/test'
Nodemap: 11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
Path                : /test
FS                  : 38.2 GiB   Used FS: 41.3%   Inodes: 2.4 Mi   Used Inodes: 5.8%
128 tasks, 16384 files

SUMMARY rate (in ops/sec): (of 10 iterations)
   Operation                     Max            Min           Mean        Std Dev
   ---------                     ---            ---           ----        -------
   File creation                7147.432       6789.531       6996.044        132.149
   File stat                   97175.603      57844.142      91063.340      12000.718
   File read                   97004.685      48234.620      89099.077      14715.699
   File removal                25172.919      23405.880      24424.384        577.264
   Tree creation                2375.031        555.537       1982.139        561.013
   Tree removal                   99.443         95.475         97.632          1.266
-- finished at 04/03/2025 14:40:05 --
```


TEST 2: in-kernel client
```
$ mpirun -n 128 --map-by :OVERSUBSCRIBE  ./mdtest  -w 0 -I 128 -i 10 -z 0 -b 0 -F -d /mnt/test
-- started at 04/03/2025 14:36:09 --

mdtest-4.1.0+dev was launched with 128 total task(s) on 1 node(s)
Nodemap: 11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
Path                : /mnt/test
FS                  : 38.2 GiB   Used FS: 41.3%   Inodes: 2.4 Mi   Used Inodes: 5.8%
128 tasks, 16384 files

SUMMARY rate (in ops/sec): (of 10 iterations)
   Operation                     Max            Min           Mean        Std Dev
   ---------                     ---            ---           ----        -------
   File creation                2301.914       2046.406       2203.859         88.793
   File stat                  101396.240      77386.014      91270.677       6229.657
   File read                   43631.081      36858.229      40800.066       2534.255
   File removal                 3102.328       2647.649       2840.170        153.959
   Tree creation                2142.137        253.739       1710.416        620.293
   Tree removal                   42.922         25.670         36.604          4.820
-- finished at 04/03/2025 14:38:28 --
```


Obviously, the kernel client shares the TCP connection. So, either (a) this is an expected behavior;
(b) client thread starvation; and (c) server thread starvation. The last option is unlikely, as we
first observed the behavior with the dCache NFS server implementation before falling back to
the linux kernel nfsd.

Best regards,
   Tigran.


[1]: https://github.com/hpc/ior
[2]: https://github.com/sahlberg/libnfs

-----------------------------
DESY-IT, Scientific Computing

------=_Part_23396587_575441006.1743685274433
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
MBwGCSqGSIb3DQEJBTEPFw0yNTA0MDMxMzAxMTRaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIAVChcus2fiAHMXXg2wduPpWl40i
KbINOdPpsg2QPB+UMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICACyLbmKmvDqiL+qUX8QWVcHsrVk4DVE+k2XKyhRS
YgxmgiWt14z4gIDSP00+xTGoPeHTxsTLSSecg70lH1CY7KdJfJpOWY5gciub4wudNCWFr4jPR8kg
W/McobleehPZ4I7uDIqr+UIOUaIqRJMMRbx8IX8Efpnvrgn6X9EGVoChjVlbtgrxP32XtmkASflC
ZPqY+SvTTOvWWkAqJR9MbSm+zH15+JpVUpfPSxHBCt+w4Uo+XPDLhmLqsHtwU/MIQCWsMlNJn4UT
XX1vYe+Nour08IeiVg3Y4sUw+Yy/b28x6j7TJXk0aDiIXkcFay/XcIKPVklUbQdM3tiZwIbpb5W6
07P/Ta4aiuVjimbyvn964R1qj2OFlMxFlU/yazuqsJ4iOVWPlRQ0MyiOdeBSvyU2dvMo6RJMZX8J
1OusJKOI3S3n2aJlo42QTs2ptx5tJt7bbYNW3rNu0hN/KcgH0lxHuMXAw3QGqnOaQdznBHthqm9H
6ZRMQPerE9FLH+ewNGteSeGmsCjNLx+c3DO8kVhrrCBOs/eeMY4QYMrmp1e0VwbUuz1B71Ux5Knz
OQdxrGZFhscYgrst/0IORAMMv8NQAEl6cAVoA8f4/M8m+cXgX+LEIN94kvitOEYdH7yozrPe8BJf
TfWv1BiXIMTCHHV1lCixyBtlJSgVc9CDAO7KAAAAAAAA
------=_Part_23396587_575441006.1743685274433--

