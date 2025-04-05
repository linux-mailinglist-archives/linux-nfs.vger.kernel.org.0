Return-Path: <linux-nfs+bounces-11007-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C62A7CA8D
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Apr 2025 19:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE6027A76E5
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Apr 2025 17:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C22815746F;
	Sat,  5 Apr 2025 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="D8qrMgU+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304EF170A26
	for <linux-nfs@vger.kernel.org>; Sat,  5 Apr 2025 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743873066; cv=none; b=X7Z0Oyg8mxf6Q15w1f5Q2fiiT3t7tpGaiJ4hzExrog+8Yw9gpq13L/+o6+h1MPuBACVM/pVjqiDCJ4rrRWTnB94keN2GUfAIEeGouk8HjZf6OapAbZ1qG9/xEM8iaUjNdXq9G+pugFVdy9Avor/2ZbkGdeOTvkZOfPrDTi/7Zuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743873066; c=relaxed/simple;
	bh=N/+3pqZW3kjN5/HO5l+yxL59tZaajd0zJfKxIlDkQVY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Djqw0XG5M385gXsU799F38i1YAv8qDI8HDwh3k7IorXLhFaa0VFVL+ioALfDQ8Mrm1qFmpp93yafrk/S7gJjrntobSiBEoQqsISVOQ6cPfWCFzyItcgx11/hlSbXbKsxBpwrPm5Rc8mOAYGUhdkobU1fhJqes9M5jeYWIT1/MfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=D8qrMgU+; arc=none smtp.client-ip=131.169.56.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
	by smtp-o-1.desy.de (Postfix) with ESMTP id B10AA11F744
	for <linux-nfs@vger.kernel.org>; Sat,  5 Apr 2025 19:10:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de B10AA11F744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1743873053; bh=SxN/NyuDq5VUzXIUyyiBkbQW8KUFm0r3424RyWPWYN4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=D8qrMgU+i3Q1NM4yLdFzUz6dFJCfdC6EqtiMIhsl7P8LBfqIL8THiUihtJls2tnjT
	 s5+SkZj6MA5deK9bRgHI1xN5gLn+3l/W9eODaI8850Q6ZyXl2xFRhNFdMPHzpXBvcQ
	 +rLTI8outswkGrHxgTKHdROmSQ//noPgfW6DciO4=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 9B49C20040;
	Sat,  5 Apr 2025 19:10:53 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [194.95.233.47])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 922C116003F;
	Sat,  5 Apr 2025 19:10:53 +0200 (CEST)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id 9294232007F;
	Sat,  5 Apr 2025 19:10:52 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 07C5580046;
	Sat,  5 Apr 2025 19:10:52 +0200 (CEST)
Date: Sat, 5 Apr 2025 19:10:51 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: NeilBrown <neil@brown.name>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1266597584.24052706.1743873051468.JavaMail.zimbra@desy.de>
In-Reply-To: <174373648629.9342.17081599824511256253@noble.neil.brown.name>
References: <1976198229.23396586.1743685274389.JavaMail.zimbra@desy.de> <174373648629.9342.17081599824511256253@noble.neil.brown.name>
Subject: Re: NFS client low performance in concurrent environment.
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_24052707_526459292.1743873051932"
X-Mailer: Zimbra 9.0.0_GA_4718 (ZimbraWebClient - FF137 (Linux)/9.0.0_GA_4737)
Thread-Topic: NFS client low performance in concurrent environment.
Thread-Index: 3xtmo+/9rUHV0ejSzmMRQLUCtlNk6g==

------=_Part_24052707_526459292.1743873051932
Date: Sat, 5 Apr 2025 19:10:51 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: NeilBrown <neil@brown.name>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1266597584.24052706.1743873051468.JavaMail.zimbra@desy.de>
In-Reply-To: <174373648629.9342.17081599824511256253@noble.neil.brown.name>
References: <1976198229.23396586.1743685274389.JavaMail.zimbra@desy.de> <174373648629.9342.17081599824511256253@noble.neil.brown.name>
Subject: Re: NFS client low performance in concurrent environment.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4718 (ZimbraWebClient - FF137 (Linux)/9.0.0_GA_4737)
Thread-Topic: NFS client low performance in concurrent environment.
Thread-Index: 3xtmo+/9rUHV0ejSzmMRQLUCtlNk6g==


Hi NeilBrown,

The behavior you describe in the patch series matches our observations.
I briefly went through the patches. Unfortunately, my kernel skills are
not so strong that I can follow changes. Obviously, it's up to the filesystem
implementation to handle parallel creations or require a high-level locking
to ensure integrity. This is what the FS_PAR_DIR_UPDATE flag is doing, right?

From the comments on the thread, I got the impression that the implementation is overcomplicated.
I can build and test the changes. However, the series won't be accepted as-is.

Best regards,
   Tigran.

----- Original Message -----
> From: "NeilBrown" <neil@brown.name>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Friday, 4 April, 2025 05:14:46
> Subject: Re: NFS client low performance in concurrent environment.

> On Fri, 04 Apr 2025, Mkrtchyan, Tigran wrote:
>> Dear NFS fellows,
>> 
>> As part of research, we have adopted a well-known in the HPC community, IOR[1],
>> to support libnfs[2]. After running a bunch of tests, our observation is that
>> the
>> multiple clients in userspace have a higher throughput than the in-kernel
>> client (or server).
>> 
>> In the test below, nfs server runs on RHEL9 with kernel
>> 5.14.0-503.23.1.el9_5.x86_64
>> exporting /mnt. The results are in operations per second, thus, higher numbers
>> are better.
>> 
>> The client is an 80-core single host, running RHEL9 with kernel
>> 5.14.0-427.26.1.el9_4.x86_64.
>> We used NFSv3 in the test to eliminate NFSv4's open/close overhead on zero-byte
>> files.
>> 
>> 
>> TEST 1: libnfs
>> ```
>> $ mpirun -n 128 --map-by :OVERSUBSCRIBE  ./mdtest  -a LIBNFS
>> --libnfs.url='nfs://lab008/mnt/?uid=0&gid=0&version=3' -w 0 -I 128 -i 10 -z 0
>> -b 0 -F -d /test
>> -- started at 04/03/2025 14:39:30 --
>> 
>> mdtest-4.1.0+dev was launched with 128 total task(s) on 1 node(s)
>> Command line used: ./mdtest '-a' 'LIBNFS'
>> '--libnfs.url=nfs://lab008/mnt/version=3' '-w' '0' '-I' '128' '-i' '10' '-z'
>> '0' '-b' '0' '-F' '-d' '/test'
>> Nodemap:
>> 11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
>> Path                : /test
>> FS                  : 38.2 GiB   Used FS: 41.3%   Inodes: 2.4 Mi   Used Inodes:
>> 5.8%
>> 128 tasks, 16384 files
>> 
>> SUMMARY rate (in ops/sec): (of 10 iterations)
>>    Operation                     Max            Min           Mean        Std Dev
>>    ---------                     ---            ---           ----        -------
>>    File creation                7147.432       6789.531       6996.044
>>    132.149
>>    File stat                   97175.603      57844.142      91063.340
>>    12000.718
>>    File read                   97004.685      48234.620      89099.077
>>    14715.699
>>    File removal                25172.919      23405.880      24424.384
>>    577.264
>>    Tree creation                2375.031        555.537       1982.139
>>    561.013
>>    Tree removal                   99.443         95.475         97.632
>>    1.266
>> -- finished at 04/03/2025 14:40:05 --
>> ```
>> 
>> 
>> TEST 2: in-kernel client
>> ```
>> $ mpirun -n 128 --map-by :OVERSUBSCRIBE  ./mdtest  -w 0 -I 128 -i 10 -z 0 -b 0
>> -F -d /mnt/test
>> -- started at 04/03/2025 14:36:09 --
>> 
>> mdtest-4.1.0+dev was launched with 128 total task(s) on 1 node(s)
>> Nodemap:
>> 11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
>> Path                : /mnt/test
>> FS                  : 38.2 GiB   Used FS: 41.3%   Inodes: 2.4 Mi   Used Inodes:
>> 5.8%
>> 128 tasks, 16384 files
>> 
>> SUMMARY rate (in ops/sec): (of 10 iterations)
>>    Operation                     Max            Min           Mean        Std Dev
>>    ---------                     ---            ---           ----        -------
>>    File creation                2301.914       2046.406       2203.859
>>    88.793
>>    File stat                  101396.240      77386.014      91270.677
>>    6229.657
>>    File read                   43631.081      36858.229      40800.066
>>    2534.255
>>    File removal                 3102.328       2647.649       2840.170
>>    153.959
>>    Tree creation                2142.137        253.739       1710.416
>>    620.293
>>    Tree removal                   42.922         25.670         36.604
>>    4.820
>> -- finished at 04/03/2025 14:38:28 --
>> ```
>> 
>> 
>> Obviously, the kernel client shares the TCP connection. So, either (a) this is
>> an expected behavior;
>> (b) client thread starvation; and (c) server thread starvation. The last option
>> is unlikely, as we
>> first observed the behavior with the dCache NFS server implementation before
>> falling back to
>> the linux kernel nfsd.
> 
> If you think "kernel client share the TCP connection" then it would be
> worth adding the "nconnect=8" option to see if that makes a difference.
> 
> If all these file operations are happening in the one directory then the
> problem is probably contention on the directory lock.  The Linux VFS
> holds an exclusive lock on the directory while creating or removing any
> files in that directory.  If you can shard the operations over multiple
> directories you can ease the contention.
> 
> I am working on removing the dependency on the directory lock, but I
> don't have a patch for you to try - unless you are happy to work on a
> three-year old kernel
> There is a patch set here:
>   https://lore.kernel.org/all/166147828344.25420.13834885828450967910.stgit@noble.brown/
> which should work on a kernel of that time.
> 
> NeilBrown
> 
>> 
>> Best regards,
>>    Tigran.
>> 
>> 
>> [1]: https://github.com/hpc/ior
>> [2]: https://github.com/sahlberg/libnfs
>> 
>> -----------------------------
>> DESY-IT, Scientific Computing

------=_Part_24052707_526459292.1743873051932
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
MBwGCSqGSIb3DQEJBTEPFw0yNTA0MDUxNzEwNTJaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIERa0E+qwj8UomZOwqP41HTEiUWL
47/84//m6T+QK1cKMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICAJHAWasqTylsDTkMC6m/XK5+XxkUZhYBadSQwjch
vtNQk5CVWMXCaUX7Ml49mpalVjacvtH+C9JgWsFGmOvqORE0ddxo4iRjiVsjrxvHoXoKqfDwwSOF
/lzImCZ5xRgTs7sx2dww5o6bnLeCkNndCOFJC5YZe5YQBkdjg3xppj0oQ4B3+S+PfdpQe1v+2vyY
lP/BOO5J4H4yj9SaLgMp1JaYVfs+imcefhfSssBOtPRD6NM+iI48pHm5qKRrENCY4ZBkrd63ReK4
ecs/xHPbSC4wSz2usc9Fe9ZxujxbNrFqh8HCEfhVf27YLDuedknR2AHx8yx7o2eJ9uC3B1CzpClh
WanNArb/1gvzAs8qfl9EGUySAcIi4KOB0bPy88pnInKwXCYIvKTBdvqWfaxfZmVEXQs2AafamnKu
uLrbdClo0uDySVNjbbbOgJ0nPRmTki+blBAP/Wc0eia8QzmJ4d1ErkrK16u+RLQitv+gkXsrIDh9
yAs41wh+VoC0m5nxXG4zsyZ69MLtRdgKn+tosBYxtPFFlj+gfXhjVzCyGq3SKQTfZM9lcham4OMB
E+OQNbE9NATonL/Uj55L8vX0fIT57klF9dvEGjUFq1FW7rKzK2/PDG+9EC3z00V21ypXRF/Ykp53
hr+Ik1QDKdXLpQnT2ecXMmGmN7nSFH4m6+NEAAAAAAAA
------=_Part_24052707_526459292.1743873051932--

