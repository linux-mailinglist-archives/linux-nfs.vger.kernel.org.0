Return-Path: <linux-nfs+bounces-12001-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14694ACA00A
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Jun 2025 20:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849FA7A80ED
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Jun 2025 17:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03F922F3A8;
	Sun,  1 Jun 2025 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="z6vwnKDk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDAA22D7BF
	for <linux-nfs@vger.kernel.org>; Sun,  1 Jun 2025 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748800839; cv=none; b=aiwYAZRocQxuB4SBnVTc2JOun2DVMNrYF5a4ghs4zkOCmluUtPHKQWRxCOFuZtPE8baJIBTXkrGjqoVfo9G4EM485t2R99ntaEnFZj13t+mZTf4XfknmCuzBp/7vRu9hf7VOMrCPQ9ZrirJvCg4knWwH0FDFLEyM0VLAmfZyjT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748800839; c=relaxed/simple;
	bh=tNk3qA459CytOm4w1+XB1d8I/gXcqHGGzMib41sukM0=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=P64dA13gdj11HESD33ckRbeXtBeT7QWtn1cew3ujkQgS5fOCVSykkWUDMI0Fcq3jJRprwWApuvy7XC/DBEedZi3r5RsRCoBibjkGnVhbdAesYBGQQ7zTTHv17Y0CgaihUMf1cFBJQH8Wb4LXulyxlmDwNlKdflxmZMlaKLWSM9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=z6vwnKDk; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	by smtp-o-3.desy.de (Postfix) with ESMTP id A94F811F8A2
	for <linux-nfs@vger.kernel.org>; Sun,  1 Jun 2025 20:00:26 +0200 (CEST)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
	by smtp-o-1.desy.de (Postfix) with ESMTP id D599411F744
	for <linux-nfs@vger.kernel.org>; Sun,  1 Jun 2025 20:00:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de D599411F744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1748800818; bh=yafy4lcLn07NRip6K+qwKXiB8B62PWpWEjllZGwJDdE=;
	h=Date:From:To:Subject:From;
	b=z6vwnKDkz5JnsZKKuN3FHg3gbNC3G+Q8pZ32TV71ApfZrKKSFYT/tXc57mqDHn8D5
	 6wz5JcS1A7bAuq8KJrypJMVZeainr5WR3bA7hjTjSCqdfGVqjN53VTTSlgRU4gEWCf
	 bOQ6FIZCuuHMwYVRwJYIdhGzLJGcUWFLOiyUkbyI=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id CBB9220040
	for <linux-nfs@vger.kernel.org>; Sun,  1 Jun 2025 20:00:18 +0200 (CEST)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [194.95.235.47])
	by smtp-m-1.desy.de (Postfix) with ESMTP id C3CF240044
	for <linux-nfs@vger.kernel.org>; Sun,  1 Jun 2025 20:00:18 +0200 (CEST)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
	by b1722.mx.srv.dfn.de (Postfix) with ESMTP id 1D79F160058
	for <linux-nfs@vger.kernel.org>; Sun,  1 Jun 2025 20:00:18 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 03AC480046
	for <linux-nfs@vger.kernel.org>; Sun,  1 Jun 2025 20:00:17 +0200 (CEST)
Date: Sun, 1 Jun 2025 20:00:17 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <601285843.50695650.1748800817824.JavaMail.zimbra@desy.de>
Subject: pNFS DS infinite reconnect if process get interrupted
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_50695651_2140337653.1748800817945"
X-Mailer: Zimbra 9.0.0_GA_4718 (ZimbraWebClient - FF139 (Linux)/9.0.0_GA_4737)
Thread-Index: WBtipqvBbQkuH2ZJKlrEGphuwxLwhA==
Thread-Topic: pNFS DS infinite reconnect if process get interrupted

------=_Part_50695651_2140337653.1748800817945
Date: Sun, 1 Jun 2025 20:00:17 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <601285843.50695650.1748800817824.JavaMail.zimbra@desy.de>
Subject: pNFS DS infinite reconnect if process get interrupted
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_GA_4718 (ZimbraWebClient - FF139 (Linux)/9.0.0_GA_4737)
Thread-Index: WBtipqvBbQkuH2ZJKlrEGphuwxLwhA==
Thread-Topic: pNFS DS infinite reconnect if process get interrupted

Dear NFS fellows,

From time to time, we observe pNFS hangs in an infinite reconnect loop to D=
S.

We have pNFS deployment that uses the flexfiles layout and ~1000 tightly
coupled data servers over nfsv4.1. The user's applications run on HPC clust=
er
with RHEL9, 5.14.0-503.38.1.el9_5.x86_64. When applications take longer
that the specified time slot and get killed by the batch system (slurm). So=
me
of those killed applications hang and batch systems mark such nodes as 'dea=
d'
and take them out of the scheduling, thus we get hundreds of CPUS disabled.

Despite the fact that it's hard to reproduce (it takes 1-2 days to trigger =
the issue),
here is my analysis of what happens based on network capture, ftraces, and =
kernel
source (RHEL and upstream 6.15).

When applications get killed (SIGTERM) while nfs client performs a connecti=
on
to DS, client ends in an infinite loop of connect-disconnect (DS runs
on port 24009):

tcpdump:

1 0.000000000 13a.b.c =E2=86=92 13x.y.z TCP 76 759 =E2=86=92 24009 [SYN] Se=
q=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SACK_PERM=3D1 TSval=3D715791705 TSecr=
=3D0 WS=3D128=20
2 0.000023143 13x.y.z =E2=86=92 13a.b.c TCP 76 24009 =E2=86=92 759 [SYN, AC=
K] Seq=3D0 Ack=3D1 Win=3D31856 Len=3D0 MSS=3D1460 SACK_PERM=3D1 TSval=3D194=
8502509 TSecr=3D715791705 WS=3D128=20
3 0.000071151 13a.b.c =E2=86=92 13x.y.z TCP 68 759 =E2=86=92 24009 [ACK] Se=
q=3D1 Ack=3D1 Win=3D32128 Len=3D0 TSval=3D715791705 TSecr=3D1948502509
4 0.000224823 13a.b.c =E2=86=92 13x.y.z TCP 68 759 =E2=86=92 24009 [FIN, AC=
K] Seq=3D1 Ack=3D1 Win=3D32128 Len=3D0 TSval=3D715791706 TSecr=3D1948502509
5 0.000348922 13x.y.z =E2=86=92 13a.b.c TCP 68 24009 =E2=86=92 759 [FIN, AC=
K] Seq=3D1 Ack=3D2 Win=3D31872 Len=3D0 TSval=3D1948502509 TSecr=3D715791706
6 0.000394673 13a.b.c =E2=86=92 13x.y.z TCP 68 759 =E2=86=92 24009 [ACK] Se=
q=3D2 Ack=3D2 Win=3D32128 Len=3D0 TSval=3D715791706 TSecr=3D1948502509


ftrace:

27943 [008] ....... 2419533.462117: xprt_create: peer=3D[13x.y.z]:24009 sta=
te=3DBOUND
           <...>-1227943 [008] ....... 2419533.462164: rpc_clnt_new: client=
=3D00000349 peer=3D[13x.y.z]:24009 program=3Dnfs server=3D13x.y.z xprtsec=
=3Dnone flags=3DDISCRTRY|INFINITE_SLOTS|NO_RETRANS_TIMEOUT
           <...>-1227943 [008] ....... 2419533.462165: rpc_task_begin: task=
:00000001@00000349 flags=3DNULLCREDS|DYNAMIC|SOFT|SOFTCONN|CRED_NOREF runst=
ate=3DACTIVE status=3D0 action=3D0x0
           <...>-1227943 [008] ....... 2419533.462165: rpc_task_run_action:=
 task:00000001@00000349 flags=3DNULLCREDS|DYNAMIC|SOFT|SOFTCONN|CRED_NOREF =
runstate=3DRUNNING|ACTIVE status=3D0 action=3Drpc_prepare_task [sunrpc]
           <...>-1227943 [008] ....... 2419533.462165: rpc_task_run_action:=
 task:00000001@00000349 flags=3DNULLCREDS|DYNAMIC|SOFT|SOFTCONN|CRED_NOREF =
runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_start [sunrpc]
           <...>-1227943 [008] ....... 2419533.462165: rpc_request: task:00=
000001@00000349 nfsv4 NULL (sync)
           <...>-1227943 [008] ....... 2419533.462166: rpc_task_run_action:=
 task:00000001@00000349 flags=3DNULLCREDS|DYNAMIC|SOFT|SOFTCONN|CRED_NOREF =
runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_reserve [sunrpc]
           <...>-1227943 [008] ....... 2419533.462166: xprt_reserve: task:0=
0000001@00000349 xid=3D0xd88c82e6
           <...>-1227943 [008] ....... 2419533.462166: rpc_task_run_action:=
 task:00000001@00000349 flags=3DNULLCREDS|DYNAMIC|SOFT|SOFTCONN|CRED_NOREF =
runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_reserveresult [sunrpc]
           <...>-1227943 [008] ....... 2419533.462167: rpc_task_run_action:=
 task:00000001@00000349 flags=3DNULLCREDS|DYNAMIC|SOFT|SOFTCONN|CRED_NOREF =
runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_refresh [sunrpc]
           <...>-1227943 [008] ....... 2419533.462167: rpc_task_run_action:=
 task:00000001@00000349 flags=3DNULLCREDS|DYNAMIC|SOFT|SOFTCONN|CRED_NOREF =
runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_refreshresult [sunrpc]
           <...>-1227943 [008] ....... 2419533.462167: rpc_task_run_action:=
 task:00000001@00000349 flags=3DNULLCREDS|DYNAMIC|SOFT|SOFTCONN|CRED_NOREF =
runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_allocate [sunrpc]
           <...>-1227943 [008] ....... 2419533.462167: rpc_buf_alloc: task:=
00000001@00000349 callsize=3D56 recvsize=3D32 status=3D0
           <...>-1227943 [008] ....... 2419533.462167: rpc_task_run_action:=
 task:00000001@00000349 flags=3DNULLCREDS|DYNAMIC|SOFT|SOFTCONN|CRED_NOREF =
runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_encode [sunrpc]
           <...>-1227943 [008] ....... 2419533.462168: rpc_task_run_action:=
 task:00000001@00000349 flags=3DNULLCREDS|DYNAMIC|SOFT|SOFTCONN|CRED_NOREF =
runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D0 action=3Dcall_conn=
ect [sunrpc]
           <...>-1227943 [008] ....1.. 2419533.462168: xprt_reserve_xprt: t=
ask:00000001@00000349 snd_task:00000001
           <...>-1227943 [008] ....... 2419533.462169: xprt_connect: peer=
=3D[13x.y.z]:24009 state=3DLOCKED|BOUND
           <...>-1227943 [008] ....1.. 2419533.462169: rpc_task_sleep: task=
:00000001@00000349 flags=3DNULLCREDS|DYNAMIC|SOFT|SOFTCONN|CRED_NOREF runst=
ate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D0 timeout=3D0 queue=3Dxpr=
t_pending
           <...>-1227943 [008] ....... 2419533.462170: rpc_task_sync_sleep:=
 task:00000001@00000349 flags=3DNULLCREDS|DYNAMIC|SOFT|SOFTCONN|CRED_NOREF =
runstate=3DQUEUED|ACTIVE|NEED_XMIT|NEED_RECV status=3D0 action=3Dcall_conne=
ct_status [sunrpc]
           <...>-1227943 [008] ....... 2419533.462172: rpc_task_signalled: =
task:00000001@00000349 flags=3DNULLCREDS|DYNAMIC|SOFT|SOFTCONN|CRED_NOREF r=
unstate=3DQUEUED|ACTIVE|NEED_XMIT|NEED_RECV status=3D0 action=3Dcall_connec=
t_status [sunrpc]
           <...>-1227943 [008] ....1.. 2419533.462172: rpc_task_wakeup: tas=
k:00000001@00000349 flags=3DNULLCREDS|DYNAMIC|SOFT|SOFTCONN|CRED_NOREF runs=
tate=3DQUEUED|ACTIVE|NEED_XMIT|NEED_RECV|SIGNALLED status=3D0 timeout=3D600=
00 queue=3Dxprt_pending
           <...>-1227943 [008] ....... 2419533.462173: rpc_task_sync_wake: =
task:00000001@00000349 flags=3DNULLCREDS|DYNAMIC|SOFT|SOFTCONN|CRED_NOREF r=
unstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV|SIGNALLED status=3D0 action=3D=
call_connect_status [sunrpc]
           <...>-1227943 [008] ....... 2419533.462173: rpc_task_run_action:=
 task:00000001@00000349 flags=3DNULLCREDS|DYNAMIC|SOFT|SOFTCONN|CRED_NOREF =
runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV|SIGNALLED status=3D-512 actio=
n=3Drpc_exit_task [sunrpc]
           <...>-1227943 [008] ....... 2419533.462173: rpc_task_end: task:0=
0000001@00000349 flags=3DNULLCREDS|DYNAMIC|SOFT|SOFTCONN|CRED_NOREF runstat=
e=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV|SIGNALLED status=3D-512 action=3Dcal=
l_connect_status [sunrpc]
           <...>-1227943 [008] ....... 2419533.462173: rpc_stats_latency: t=
ask:00000001@00000349 xid=3D0xd88c82e6 nfsv4 NULL backlog=3D0 rtt=3D0 execu=
te=3D8
           <...>-1227943 [008] ....... 2419533.462173: rpc_task_call_done: =
task:00000001@00000349 flags=3DNULLCREDS|DYNAMIC|SOFT|SOFTCONN|CRED_NOREF r=
unstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV|SIGNALLED status=3D-512 action=
=3Drpc_default_callback [sunrpc]
           <...>-1227943 [008] ....1.. 2419533.462174: xprt_release_xprt: t=
ask:00000001@00000349 snd_task:ffffffff
           <...>-1227943 [008] ....... 2419533.462175: rpc_clnt_shutdown: c=
lient=3D00000349
           <...>-1227943 [008] ....... 2419533.462179: rpc_clnt_release: cl=
ient=3D00000349


My assumption is that flexfilelayoutdev#nfs4_ff_layout_prepare_ds gets an e=
rror on nfs4_pnfs_ds_connect with status ERESTARTSYS,
which is set by rpc_signal_task, but the error is propagated as fatal (for =
example, by checking with nfs_error_is_fatal). Thus,
it was treated as a transient error and retried.

Does it sound like a reasonable analysis? How can we prove that? How can we=
 fix that?

Best regards,
   Tigran.
------=_Part_50695651_2140337653.1748800817945
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
MBwGCSqGSIb3DQEJBTEPFw0yNTA2MDExODAwMThaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIDixWff00agt3jaAF4zPn5Z8H8up
KKNxnWTgwzWce0F5MDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICAEcVH+aTmWdORce/R2B2mJCMa/orrXOZPIPwyIDe
AlOO8wo8R/z1t7Iy8g3KsyeBqTGCZ7EmSA2KtKV00xIs7FirjgAqaQQo0RCaS8EY7qAnxdF68xvq
dGP8WDh95DlzDNv+uemGq+4VfvCyaR171ydBWmNguD7ri9OTfZ9BZhUUztzvIyn15UY6LLNZW3X7
UtZsjusIaAzQSz/rCuZT+oKTWatb9mlu4DJ9rdjGvtJVa3v8VSnGzRj2hmBbW8rWUVtueqYloGJb
cjdLPWIPV4FnAgFyAHt+Z4hxsQnbJmHL/NzgopIzyMOuPwyJdYmjJ7/ecTW7NJryjpiw5YQldwdB
ZhK8pN5RyQtbkerSaMMCtlDEzQafIUaMTHKXCx87JiNDcXKlym9sLKD0IJwyVByv1v5SkdN6NVCH
9+QywYTEmsK04UmCA+CnIBqnujm9m/a9ctd4MDN+mm+6g6VdIa27FMUzFlMqGGag7eKU13ryRsbN
mq0ZIJDjev/mu/dIs0HZIUO9aT7cQsclBFwmb1GXO6jy4A3LQ8ApZw9Va42m+3g0QpnEl4kr7PHX
bSwWs9p2RbQNxhf2hmbe36azUUnVdQL8i5dxPZEC25UFbXfo/h+ht7cUuKEDWseskxvKHru2x/3c
aIJUUrSx1joolotsvO2ZuREGWkZi4xjlBipiAAAAAAAA
------=_Part_50695651_2140337653.1748800817945--

