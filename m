Return-Path: <linux-nfs+bounces-4559-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC4D924637
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 19:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F3E2B269B4
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 17:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6081BD005;
	Tue,  2 Jul 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="bcv9T56D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D961C0043
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941539; cv=none; b=tqqTib7p2B/PEHOk7HSnbhMCKacP0XUd5wL/9OEbDTcK916C6SqViFA5BYlmEmXjUhbFn4bJ1BQtpfIS6QIErCdE2ZT74EDoR8Ozb18PhZhWa8cEk5SuaemETYSd+508cjqR0RMDpLatK8fyaGD5cRF+VGlr9RXsZ/sgjuSXtUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941539; c=relaxed/simple;
	bh=yvzVAQJCOvaSALW4Xy4PSORMPNHH80fMk5hw5VwZA3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0o5HxOJLbHbozFtiA42+m0gwkR18iSDIzb4xGgPoA7GUAc9ymL8I06T+HV9pZwXHiqtwMKmi7oAj30vJPwOuuDY30TSyVujr3iw+/OuaN+RXQddhN9AegxocoftQGu3dGiccH1eImKtZfhjVLJJSCFC/XT43LQ0+pvUbuqZMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=bcv9T56D; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=yvzVAQJCOvaS
	ALW4Xy4PSORMPNHH80fMk5hw5VwZA3s=; h=in-reply-to:from:references:cc:to:
	subject:date; d=aixigo.com; b=bcv9T56DB3DQJLmHFBkp4UMY0Kj269YWGeQLU3/N
	8ZNO4Fg0iD4f1yJXe64yX4s/isQpXAQ0wYXl2FZ1ZWu89D91UZj6ZlzxwaEoWRwyGou1FA
	bN1s7I0uR9IAMrCg0cbQfrX21PkObBnCRsiKxRwr4F487Zyo84+pq98iBwgKc=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id f578876d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Jul 2024 19:25:31 +0200 (CEST)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2+deb12u2) with ESMTPS id 462HPUeW006652
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 2 Jul 2024 19:25:30 +0200
Message-ID: <88734306-3076-422a-9884-47f76756fcc9@aixigo.com>
Date: Tue, 2 Jul 2024 19:25:30 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: nfsd becomes a zombie
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Calum Mackay <calum.mackay@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <4eeb2367-c869-4960-869b-c23ef824e044@oracle.com>
 <661a6c9a-81d6-46fd-87ec-274100b12189@aixigo.com>
 <ZnGfEDvQB1FRGVQK@tissot.1015granger.net>
 <668b479b-3a51-4287-b9d7-44d6dfa4eaf4@aixigo.com>
 <27922D49-743D-4FC2-86C6-6926FE52537D@oracle.com>
From: Harald Dunkel <harald.dunkel@aixigo.com>
Content-Language: en-US
In-Reply-To: <27922D49-743D-4FC2-86C6-6926FE52537D@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 1.0.5 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

Hi folks,

my NAS ran into this problem again. NFS got stuck somehow, and
the nfsd couldn't be killed :-(.

dmesg:
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000749c823f xid 5bf8d3d0
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000ce307050 xid 3b4fbd9f
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000f7f9161e xid 0a26635c
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000007c978512 xid 384cbf0c
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000dc3c09f6 xid 53cc0e3e
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000d1675728 xid 129006af
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000047159b90 xid 0c06b6e0
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000008b3b3ac xid 641bb0da
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000009eb832dc xid 005fcc99
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000042dcce88 xid b3cf5de4
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000b66bbd6f xid d4f06b56
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000b5e5e5a3 xid c032dbba
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000e123efc9 xid 99fa75d9
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000ca43f6f0 xid e38d5b74
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000ad683927 xid 277cde8c
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000e8e01f09 xid 641df4a4
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000006223d195 xid 3dba2d2a
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000b73943aa xid a688e47f
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000004cd80e49 xid 64e688ca
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000ef92587f xid 70bf2e44
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000a5ff94a6 xid c0f7a668
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000fd9a0890 xid 0df7d2c7
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000c42ddaac xid 800e710e
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000f43275cf xid 8b05e704
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000009a1d5dcf xid 3c2ba924
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000007cad732d xid e73a0429
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000008e7d297f xid 075a98e5
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000ed964446 xid 8bb8e568
[Tue Jul  2 17:20:19 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000b14782f0 xid 4c4ae7c5
[Tue Jul  2 17:23:28 2024] INFO: task nfsd:3037 blocked for more than 120 seconds.
[Tue Jul  2 17:23:28 2024]       Not tainted 6.1.0-21-amd64 #1 Debian 6.1.90-1
[Tue Jul  2 17:23:28 2024] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Tue Jul  2 17:23:28 2024] task:nfsd            state:D stack:0     pid:3037  ppid:2      flags:0x00004000
[Tue Jul  2 17:23:28 2024] Call Trace:
[Tue Jul  2 17:23:28 2024]  <TASK>
[Tue Jul  2 17:23:28 2024]  __schedule+0x34d/0x9e0
[Tue Jul  2 17:23:28 2024]  schedule+0x5a/0xd0
[Tue Jul  2 17:23:28 2024]  schedule_timeout+0x118/0x150
[Tue Jul  2 17:23:28 2024]  wait_for_completion+0x86/0x160
[Tue Jul  2 17:23:28 2024]  __flush_workqueue+0x152/0x420
[Tue Jul  2 17:23:28 2024]  nfsd4_destroy_session+0x1b6/0x250 [nfsd]
[Tue Jul  2 17:23:28 2024]  nfsd4_proc_compound+0x355/0x660 [nfsd]
[Tue Jul  2 17:23:28 2024]  nfsd_dispatch+0x1a1/0x2b0 [nfsd]
[Tue Jul  2 17:23:28 2024]  svc_process_common+0x289/0x5e0 [sunrpc]
[Tue Jul  2 17:23:28 2024]  ? svc_recv+0x4e5/0x890 [sunrpc]
[Tue Jul  2 17:23:28 2024]  ? nfsd_svc+0x360/0x360 [nfsd]
[Tue Jul  2 17:23:28 2024]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
[Tue Jul  2 17:23:28 2024]  svc_process+0xad/0x100 [sunrpc]
[Tue Jul  2 17:23:28 2024]  nfsd+0xd5/0x190 [nfsd]
[Tue Jul  2 17:23:28 2024]  kthread+0xda/0x100
[Tue Jul  2 17:23:28 2024]  ? kthread_complete_and_exit+0x20/0x20
[Tue Jul  2 17:23:28 2024]  ret_from_fork+0x22/0x30
[Tue Jul  2 17:23:28 2024]  </TASK>
[Tue Jul  2 17:23:28 2024] INFO: task nfsd:3038 blocked for more than 120 seconds.
[Tue Jul  2 17:23:28 2024]       Not tainted 6.1.0-21-amd64 #1 Debian 6.1.90-1
[Tue Jul  2 17:23:28 2024] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.


/var/log/kern.log:
2024-06-28T10:40:40.273493+02:00 nasl006b kernel: [959982.169372] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000d1675728 xid 372e06af
2024-06-28T10:40:40.273507+02:00 nasl006b kernel: [959982.169374] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000506887ca xid 5be3c4d4
2024-06-28T10:40:40.273508+02:00 nasl006b kernel: [959982.169379] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000b5e5e5a3 xid e5d0daba
2024-06-28T10:40:40.273509+02:00 nasl006b kernel: [959982.169423] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000b66bbd6f xid 69696b56
2024-06-28T10:40:40.273509+02:00 nasl006b kernel: [959982.169498] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000008b3b3ac xid 89b9afda
2024-06-28T10:40:40.273510+02:00 nasl006b kernel: [959982.169504] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000a5ff94a6 xid e595a668
2024-06-28T10:40:40.273512+02:00 nasl006b kernel: [959982.169529] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000f7f9161e xid 2fc4625c
2024-06-28T10:40:40.273513+02:00 nasl006b kernel: [959982.169659] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000b73943aa xid cb26e47f
2024-06-28T10:40:40.273514+02:00 nasl006b kernel: [959982.169691] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000009a1d5dcf xid 61c9a824
2024-06-28T10:40:40.273514+02:00 nasl006b kernel: [959982.169697] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000749c823f xid 8096d3d0
2024-06-28T10:40:40.944609+02:00 nasl006b kernel: [959983.506736] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000190b801c xid bdd1dcd0
2024-06-28T10:40:40.948612+02:00 nasl006b kernel: [959983.512235] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000042dcce88 xid d76d5de4
2024-06-28T10:40:40.952617+02:00 nasl006b kernel: [959983.514349] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000007cad732d xid 0bd90329
2024-06-28T10:40:40.952623+02:00 nasl006b kernel: [959983.514564] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000004cd80e49 xid 898488ca
2024-06-28T10:40:40.952624+02:00 nasl006b kernel: [959983.514951] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000abccd646 xid d0d28401
2024-06-28T10:40:40.952624+02:00 nasl006b kernel: [959983.515009] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000ef92587f xid 955d2e44
2024-06-28T10:40:40.952625+02:00 nasl006b kernel: [959983.515060] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000ed964446 xid b056e568
2024-07-02T17:20:23.113792+02:00 nasl006b kernel: [1329564.790305] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000b14782f0 xid 4c4ae7c5
2024-07-02T17:23:32.268700+02:00 nasl006b kernel: [1329753.944957]  nfsd_dispatch+0x1a1/0x2b0 [nfsd]
2024-07-02T17:23:32.300740+02:00 nasl006b kernel: [1329753.969482]  svc_process_common+0x289/0x5e0 [sunrpc]
2024-07-02T17:23:32.300757+02:00 nasl006b kernel: [1329753.969919]  nfsd+0xd5/0x190 [nfsd]
2024-07-02T17:23:32.364636+02:00 nasl006b kernel: [1329754.041100]  ? nfsd_svc+0x360/0x360 [nfsd]
2024-07-02T17:23:32.419012+02:00 nasl006b kernel: [1329754.088290]  svc_process+0xad/0x100 [sunrpc]
2024-07-02T17:23:32.419020+02:00 nasl006b kernel: [1329754.088337]  ret_from_fork+0x22/0x30
2024-07-02T17:23:32.443744+02:00 nasl006b kernel: [1329754.111842]  svc_process+0xad/0x100 [sunrpc]
2024-07-02T17:23:32.443749+02:00 nasl006b kernel: [1329754.111882]  ? kthread_complete_and_exit+0x20/0x20
2024-07-02T17:23:32.488628+02:00 nasl006b kernel: [1329754.161331]  ? kthread_complete_and_exit+0x20/0x20


Regards
Harri

