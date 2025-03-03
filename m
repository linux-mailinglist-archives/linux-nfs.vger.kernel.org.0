Return-Path: <linux-nfs+bounces-10427-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29B9A4CA70
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 18:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0815E3BE426
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 17:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4560920FA85;
	Mon,  3 Mar 2025 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="NM3zDDct"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83CE258A
	for <linux-nfs@vger.kernel.org>; Mon,  3 Mar 2025 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023118; cv=none; b=gV1dqZpFqQ3zizGA/1foo4GfLCMTWPpqex+Y0Q/UAljt+Uxwpfh15pmQ73TPQX2BhzAw90rKU4XbReFKWAJPunglo6J7IHMKK0e3zZfWt+/q5XUCLbH8PrzFuJvZz3MsL32zlC3nvasmUtvPXcy1yi0yP/U88vO8kx5/4Y/74FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023118; c=relaxed/simple;
	bh=Ag+SHTMgaLqWQDc7uQXxboHInvRTGNGbxk5ZvKHjOU8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=RwLcxwYpLXxw6+Ve7nva7kwXFVwuxTkxsYb8rkPaYLTQPhAR7bcUaOB3uVMm2CBS1mJufut7CsJ56ZmY09HJKY7oMhn9JfL0bGPbnhX8NGf6Jx0dg09HdzE6nZaZvPAfd/81ozxfDVEUFa+x9XQ/HGZtr44YpFHeT+4i1QzLgbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=NM3zDDct; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 4650613F647
	for <linux-nfs@vger.kernel.org>; Mon,  3 Mar 2025 18:31:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 4650613F647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1741023107; bh=QJql9XOllg4i+hKdXQ5ZLHxSHVDI8Eg+vMdz/Wttin0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NM3zDDct2QW787t0/EBtklpN8VqeT34qvB8cybzWP1wBqpjlkz5vzK3iQU/4IlHRv
	 zQJ89RfYux2kf4BpORCuax8c5XVbkJ/FxIRanT+2QSUi3eh8TZc9H9p7B8zsG7dxb8
	 t6rSuX5+4xQCiBaJgX/LLAzdreCjCSm5UmEOyRDE=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 3D04220040;
	Mon,  3 Mar 2025 18:31:47 +0100 (CET)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [IPv6:2001:638:d:c302:acdc:1979:2:e7])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 2D9A116003F;
	Mon,  3 Mar 2025 18:31:47 +0100 (CET)
Received: from smtp-intra-3.desy.de (smtp-intra-3.desy.de [IPv6:2001:638:700:1038::1:45])
	by b1722.mx.srv.dfn.de (Postfix) with ESMTP id 44A66160058;
	Mon,  3 Mar 2025 18:31:46 +0100 (CET)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-3.desy.de (Postfix) with ESMTP id B83021A0041;
	Mon,  3 Mar 2025 18:31:45 +0100 (CET)
Date: Mon, 3 Mar 2025 18:31:45 +0100 (CET)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Cc: trondmy <trondmy@kernel.org>, Olga Kornievskaia <aglo@umich.edu>
Message-ID: <732824542.7754132.1741023105596.JavaMail.zimbra@desy.de>
In-Reply-To: <319477679.6763859.1740766422175.JavaMail.zimbra@desy.de>
References: <319477679.6763859.1740766422175.JavaMail.zimbra@desy.de>
Subject: Re: Unexpected low pNFS IO performance with parallel workload
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_7754133_1481183073.1741023105685"
X-Mailer: Zimbra 9.0.0_GA_4718 (ZimbraWebClient - FF135 (Linux)/9.0.0_GA_4737)
Thread-Topic: Unexpected low pNFS IO performance with parallel workload
Thread-Index: 3jnUn1Ic/xPZuCyLK5LAF+5KLWH+jEoXJGCP

------=_Part_7754133_1481183073.1741023105685
Date: Mon, 3 Mar 2025 18:31:45 +0100 (CET)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Cc: trondmy <trondmy@kernel.org>, Olga Kornievskaia <aglo@umich.edu>
Message-ID: <732824542.7754132.1741023105596.JavaMail.zimbra@desy.de>
In-Reply-To: <319477679.6763859.1740766422175.JavaMail.zimbra@desy.de>
References: <319477679.6763859.1740766422175.JavaMail.zimbra@desy.de>
Subject: Re: Unexpected low pNFS IO performance with parallel workload
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4718 (ZimbraWebClient - FF135 (Linux)/9.0.0_GA_4737)
Thread-Topic: Unexpected low pNFS IO performance with parallel workload
Thread-Index: 3jnUn1Ic/xPZuCyLK5LAF+5KLWH+jEoXJGCP



I was able to reproduce low throughput with the fio command. The examples below read 200GB from multiple files.
The --offset=98% is there just to read a small portion of a file, as our files are 33GB each. In 'case 1', the data is read from a single
file, and when it reaches EOF, it switches to the next one. In 'case 2', all files are opened in advance, and data is read round-robin through
all files.

case 1: read files sequentially
fio --name test --opendir=/pnfs/data --rw=randread:8 --bssplit=4k/25:512k --offset=98% --io_size=200G --file_service_type=sequential


case 2: open all files and select round-robin from which to read
fio --name test --opendir=/pnfs/data --rw=randread:8 --bssplit=4k/25:512k --offset=98% --io_size=200G --file_service_type=roundrobin

The case 1 takes a couple of minutes (2-3).
The case 2 takes two (2) hours.

Tigran.


----- Original Message -----
> From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> To: "linux-nfs" <linux-nfs@vger.kernel.org>
> Cc: "trondmy" <trondmy@kernel.org>, "Olga Kornievskaia" <aglo@umich.edu>
> Sent: Friday, 28 February, 2025 19:13:42
> Subject: Unexpected low pNFS IO performance with parallel workload

> Dear NFS fellows,
> 
> During HPC workloads on we notice that Linux NFS4.2/pNFS client menonstraits
> unexpected low performance.
> The application opens 55 files parallel reads the data with multiple threads.
> The server issues flexfile
> layout with tighly coupled NFSv4.1 DSes.
> 
> Oservations:
> 
> - despite 1MB rsize/wsize returned by layout, client never issues reads bigger
> that 512k (offten much smaller)
> - client always uses slot 0 on DS, and
> - reads happen sequentialy, i.e. only one in-flight READ requests
> - following reads often just read the next 512k block
> - If instead of parallel application a simple dd is called, that multiple slots
> and 1MB READs are sent
> 
> $ dd if=/pnfs/xxxx/00054.h5 of=/dev/null
> 45753381+1 records in
> 45753381+1 records out
> 23425731171 bytes (23 GB, 22 GiB) copied, 69.702 s, 336 MB/s
> 
> 
> The client has 80 cores on 2 sockets, 512BG of RAM and runs REHL 9.4
> 
> $ uname -r
> 5.14.0-427.26.1.el9_4.x86_64
> 
> $ free -g
>               total        used        free      shared  buff/cache   available
> Mem:             503          84         392           0          29         419
> 
> $ lscpu | head
> Architecture:                       x86_64
> CPU op-mode(s):                     32-bit, 64-bit
> Address sizes:                      46 bits physical, 48 bits virtual
> Byte Order:                         Little Endian
> CPU(s):                             80
> On-line CPU(s) list:                0-79
> Vendor ID:                          GenuineIntel
> BIOS Vendor ID:                     Intel(R) Corporation
> Model name:                         Intel(R) Xeon(R) CPU E5-2698 v4 @ 2.20GHz
> BIOS Model name:                    Intel(R) Xeon(R) CPU E5-2698 v4 @ 2.20GHz
> 
> The client and all DSes equiped  with 10GB/s NICs.
> 
> Any ideas where to look?
> 
> Best regards,
>    Tigran.

------=_Part_7754133_1481183073.1741023105685
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
MBwGCSqGSIb3DQEJBTEPFw0yNTAzMDMxNzMxNDZaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIFQpjbGC5ZCaQsDcurX2bvaHHv2B
gjTmcppsL65riRM2MDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICADuMbyDZIrrsem6M1PpcY3syxMyEqGGuqZrdneup
ouh9ZxEbDq7aMWo24oVbT8VsNV0k755l2wcr8BnJwD6JstMABU5VlvZabczf+wAeEE3jlEY2xCqe
z+e9ksK6GWuy5vt1FGuXZDSwhcXgL1mYfBAAzJFW5khDUHFHy1drL6yJUebLMYOYfWq5qLo05atr
ZY7yGazMzC6o1dZ+Z17W4bJtrK5adOkiKfV/eCLpeAO21MZ+aa2WRvCpO7D4ku+WXMM3rOvUbjKv
gqQH0AwKIrYjZWUAdXMvtDjd4iFcbyFBWSPeNWWm34cTTr3qEfhRpyzn7+QXixQL9qENeZcQWpNE
VGJH77kuWG6qOxoRhh6OgvxomZFbK9elZB3jxl1pW17dhbA+x/gN6zbRa2yOg5KpjzuhrnkTdHm/
i2dsOA+NEG1Wjkn+k5en6wH9nBA/+nwp/MEr1eCeWcAHbZkOrQ5Fo4lrb0Iu8agqz18zywfKOHhu
7wlnk1O7vVhMz6mR3BhrDP7VMj+kzRtxmglKahW6OaBiWl9ASn4CPpD0Xnl/NSFcHDoQr2WtS8zj
M9fro1qyRoccURAQ1SiJk4xTCyFLXudd++gVQpRmzvWtOoDWcAj9iJnleYYu4z++LAda9TVRjhdu
MiZBmlww4Kw8+Ctur/AOWhYXJEao39e/qYB4AAAAAAAA
------=_Part_7754133_1481183073.1741023105685--

