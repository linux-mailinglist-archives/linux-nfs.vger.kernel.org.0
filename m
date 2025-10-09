Return-Path: <linux-nfs+bounces-15082-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FBCBC8AFB
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 13:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0D51A6019E
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 11:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF9E24634F;
	Thu,  9 Oct 2025 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="gbFGywhM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A882D876C
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007917; cv=none; b=VnCxoDXMzuoiVHW5VZkKTKTl5uf1C05K5B74m+qST1MQphzMGtzr+Bxf43LK/GYcns1vMk3jorznkGjDqQj5XUtx1OiMF3OASnp2nP+HFRyebLX0imzxFZkpsNZgbfpwvN2S2LOKYTAlWIGa7zMX7eyrRMmnZxHX+EgPRSTUpvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007917; c=relaxed/simple;
	bh=9sUYd0lZ4pMnziOYqVz7uhSVGlkmxAbmoJmqOKkNleQ=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=hjLymSSW9fkKV1ny0jEOlv9r/U0+CQZVf07z9fiUKrjajPkgRQTQ9HQBwcanAQJiDwmR6BH8oBgFIo9nqaWBiqwQ4hPcQO8z0OYKX3Uc1Mv2B8bW5RV4Jg5k1wcFi+pHjPgq4aWnZUJZOKzZ2/8A7JEBwi2rTuuqydQFIlJI89E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=gbFGywhM; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [IPv6:2001:638:700:1038::1:9b])
	by smtp-o-3.desy.de (Postfix) with ESMTP id 86CDE11F926
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 12:57:19 +0200 (CEST)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
	by smtp-o-2.desy.de (Postfix) with ESMTP id DD1DF13F647
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 12:57:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de DD1DF13F647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1760007431; bh=m+TxiddGd7vSqYTFrGw5ym0ERZvCDrwPNBvERDqfTfQ=;
	h=Date:From:To:Subject:From;
	b=gbFGywhMAbVJnNbkGv/Rvkx4hOGBe+ZYuetTXO5nR723TvAiBiF4M/lsjjbJhKS3S
	 cj4Ij2xatikKMv8HDRkRTcq0GL3oblJIuCjV13KbQXm0COQnUp/hdUFkeMtkz3c2Pd
	 5nl83mZvV7ag9Psf3yRZ7WJWAgmgoYuArAj7j12I=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id D26C720056
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 12:57:11 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [IPv6:2001:638:d:c301:acdc:1979:2:e7])
	by smtp-m-2.desy.de (Postfix) with ESMTP id CAFD916003F
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 12:57:11 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [131.169.56.83])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id 47A98320093
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 12:57:11 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 19D7820044
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 12:57:11 +0200 (CEST)
Date: Thu, 9 Oct 2025 12:57:11 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1050158977.25165493.1760007431022.JavaMail.zimbra@desy.de>
Subject: Blocking stat calls during (p)NFS write
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_25165494_177293694.1760007431029"
X-Mailer: Zimbra 10.1.10_GA_4785 (ZimbraWebClient - FF143 (Linux)/10.1.10_GA_4785)
Thread-Index: R20qYTEhaGg4t2HbXBErNbJgfEDfHg==
Thread-Topic: Blocking stat calls during (p)NFS write

------=_Part_25165494_177293694.1760007431029
Date: Thu, 9 Oct 2025 12:57:11 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1050158977.25165493.1760007431022.JavaMail.zimbra@desy.de>
Subject: Blocking stat calls during (p)NFS write
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.1.10_GA_4785 (ZimbraWebClient - FF143 (Linux)/10.1.10_GA_4785)
Thread-Index: R20qYTEhaGg4t2HbXBErNbJgfEDfHg==
Thread-Topic: Blocking stat calls during (p)NFS write


Dear NFS fellows,

We have noticed that when data is written into a large file, a stat call on that file blocks.
This is quite simple to reproduce. Open two terminals, in one copy a 4GB file into NFS NFS-mounted
directory, in another window run `stat /path/to/file`.

By looking at the perf output, I can see:

stat  301583 [007] 265242.393512:      sched:sched_wake_idle_without_ipi: cpu=2
        ffffffffb5e0cfa0 call_function_single_prep_ipi+0x90 ([kernel.kallsyms])
        ffffffffb5e0cfa0 call_function_single_prep_ipi+0x90 ([kernel.kallsyms])
        ffffffffb5ef176b __smp_call_single_queue+0xdb ([kernel.kallsyms])
        ffffffffb5ef1866 generic_exec_single+0x36 ([kernel.kallsyms])
        ffffffffb5ef1bf2 smp_call_function_single_async+0x22 ([kernel.kallsyms])
        ffffffffb5ec97f4 update_process_times+0xa4 ([kernel.kallsyms])
        ffffffffb5ee279f tick_nohz_handler+0x8f ([kernel.kallsyms])
        ffffffffb5eca7c0 __hrtimer_run_queues+0x110 ([kernel.kallsyms])
        ffffffffb5ecb62c hrtimer_interrupt+0xfc ([kernel.kallsyms])
        ffffffffb5d5deb5 __sysvec_apic_timer_interrupt+0x55 ([kernel.kallsyms])
        ffffffffb6f6364c sysvec_apic_timer_interrupt+0x6c ([kernel.kallsyms])
        ffffffffb5a0160a asm_sysvec_apic_timer_interrupt+0x1a ([kernel.kallsyms])
        ffffffffb5e07b8f finish_task_switch.isra.0+0x9f ([kernel.kallsyms])
        ffffffffb6f6ad91 __schedule+0x301 ([kernel.kallsyms])
        ffffffffb6f6b277 schedule+0x27 ([kernel.kallsyms])
        ffffffffb6f6b326 io_schedule+0x46 ([kernel.kallsyms])
        ffffffffb608fddf folio_wait_bit+0xef ([kernel.kallsyms])
        ffffffffb609c95e folio_wait_writeback+0x2e ([kernel.kallsyms])
        ffffffffb608f0ff __filemap_fdatawait_range+0x7f ([kernel.kallsyms])
        ffffffffb6091bc8 filemap_write_and_wait_range+0xc8 ([kernel.kallsyms])
        ffffffffc1fc5cc7 nfs_getattr+0x567 ([kernel.kallsyms])
        ffffffffb61eb3fe vfs_getattr_nosec+0xbe ([kernel.kallsyms])
        ffffffffb61eb673 vfs_statx+0xa3 ([kernel.kallsyms])
        ffffffffb61ec363 do_statx+0x63 ([kernel.kallsyms])
        ffffffffb61ec5c0 __x64_sys_statx+0x90 ([kernel.kallsyms])
        ffffffffb6f5e5ae do_syscall_64+0x7e ([kernel.kallsyms])
        ffffffffb5a0012f entry_SYSCALL_64_after_hwframe+0x76 ([kernel.kallsyms])
            7f17c3b1fb6e statx+0xe (/usr/lib64/libc.so.6)
            55b6106f684f main+0x45f (/usr/bin/stat)
            7f17c3a3a5b5 __libc_start_call_main+0x75 (/usr/lib64/libc.so.6)
            7f17c3a3a668 __libc_start_main@@GLIBC_2.34+0x88 (/usr/lib64/libc.so.6)
            55b6106f6bb5 _start+0x25 (/usr/bin/stat)


So I assume that blocking comes from inode invalidation in inode.c#nfs_getattr call:

1003         /* Flush out writes to the server in order to update c/mtime/version.  */
1004         if ((request_mask & (STATX_CTIME | STATX_MTIME | STATX_CHANGE_COOKIE)) &&
1005             S_ISREG(inode->i_mode)) {
1006                 if (nfs_have_delegated_mtime(inode))
1007                         filemap_fdatawrite(inode->i_mapping);
1008                 else
1009                         filemap_write_and_wait(inode->i_mapping);
1010         }


The packets look as follows:

No.     Time           Rpc Time   Source                Destination           Protocol Info
     16 21.114244808              10.1.0.71       10.1.0.34         NFS      V4 Call (Reply In 18) OPEN DH: 0xf359c2c5/f42.iso | LAYOUTGET
     18 21.158017758   0.043772950 10.1.0.34         10.1.0.71       NFS      V4 Reply (Call In 16) OPEN StateID: 0x7ca4 | LAYOUTGET
     29 42.354912088              10.1.0.71       10.1.0.34         NFS      V4 Call (Reply In 30) LAYOUTCOMMIT
     30 42.357843007   0.002930919 10.1.0.34         10.1.0.71       NFS      V4 Reply (Call In 29) LAYOUTCOMMIT
     32 42.357993362              10.1.0.71       10.1.0.34         NFS      V4 Call (Reply In 35) GETATTR FH: 0x7d6441d9
     33 42.358016100              10.1.0.71       10.1.0.34         NFS      V4 Call (Reply In 36) LAYOUTRETURN
     35 42.359324091   0.001330729 10.1.0.34         10.1.0.71       NFS      V4 Reply (Call In 32) GETATTR
     36 42.378923839   0.020907739 10.1.0.34         10.1.0.71       NFS      V4 Reply (Call In 33) LAYOUTRETURN
     38 42.379133795              10.1.0.71       10.1.0.34         NFS      V4 Call (Reply In 39) CLOSE StateID: 0x7ca4
     39 42.380213999   0.001080204 10.1.0.34         10.1.0.71       NFS      V4 Reply (Call In 38) CLOSE 

So, GETATTR is sent after LAYOUTCOMMIT.
This behavior is observed with 6.17 and RHEL kernels.


------=_Part_25165494_177293694.1760007431029
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
MBwGCSqGSIb3DQEJBTEPFw0yNTEwMDkxMDU3MTFaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEII4CxC1/2RttAlxC8s35ZcVtNNdP
G2B88n/XAtqp5EccMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICAE9bVAQLalPkN+RcdW3eegcyKqSkex+LqV/X/EGo
sxs1VmqMhBLmYZQKa8+OUUgK2vhK6fzIDOLDgN6G3htDIEnBSAtE4wm8+tfAq+r7RLhhVCC8cAJe
Bpc664DzN50PFjeGxbkBklyHDjIiAoK8PTxAgoMuTwwRBxaqJ7cvX+luTx40gn+xEvflLkiXVU6c
BiWpzMXOgI746cjqc/fgO05AyCm1PpQdsa0SjONhcxDclMYJPG6O2731AORbCGiBcy3/pExYbPU1
Aoc2KD7PZ1MBZbdYaioKfzAue43CZfy9Fw7nqgLjwr2yEkGbOyp/g34cAEgS3e/SjHMHE3N13HRg
WlrryoeqlEzoEIQkVkseXbB9kPAmgs7oDq/Z2J8HgqcNGgTz3kgpNZ+wCLFIu3iOs9JjIyCA+rNn
g6TzU8WnqkQmcd1Rmk4cKZPmG2u7kBdxoPwQfqyvpCZF36PvIUlVznA8xJg65uqXk1FP4YN/lfdG
vY937CVFvSrg4VlPTu1vBAz36MbC4ILivlB1p9W1/0OyM5urhiffbWY9HJWYJtulwoRNphrGIE9U
+bpORfgaobV2stZt86UHa9XDDXnusgCCzzYduM/KDfrPxiPKIAM2ghYq1PllWp6xHzdmPMpPOZX+
342+U/J2uKvDirtYygB4XI5xSW9rhmwIR9x0AAAAAAAA
------=_Part_25165494_177293694.1760007431029--

