Return-Path: <linux-nfs+bounces-16353-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85636C59332
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 18:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96EB44A2658
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 17:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFFE35C1A0;
	Thu, 13 Nov 2025 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b="XBRz00m3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8526C2FA0DF;
	Thu, 13 Nov 2025 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763054202; cv=none; b=FAqf3rMt2DC/QhxsMRhxCRQKCPaFxjMVSQjqsm5IPedeM80R8PitJOvwSjOkprWPXaEJFkzowBTU0TNqGGb+QARjMda1dMCskMxPeh/KjQq/0SNF8DyNJh5ws7KezR5xacKI5I6/qGpOFqfZNL6ky3SHECMrP3EZRbSwLBszb8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763054202; c=relaxed/simple;
	bh=5qrpoOpRzcWRlp0mIHXVmHORzQhXRgX0ULMAdSAPXls=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZY42t0LzSmT5BShqCH4PDEI95Dls7xtKK67brHdNTPtDnJ89EO5JlnacAvkrJ47i+1MbI+Ec3Zc3g0s4yVaRV1hY3YTyNfU2X+BaMfF88QhLFOOfD/Ub75nNJEKk7Eor7o2AJuK/2kIJiNhMnzf5jwkPTOyZkpv/ZtHI28FUEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com; spf=pass smtp.mailfrom=tylerwross.com; dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b=XBRz00m3; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tylerwross.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tylerwross.com;
	s=protonmail; t=1763054181; x=1763313381;
	bh=WyAGC1w9hjUAC1tHk1ST8O5OokhSUtPxX7tlZ+9NcIk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XBRz00m3kUgYVHd600kywH6Y53jolrOztaR9+/OKgIsiaQQgn1shnJdOB2fSXaA1T
	 sNSLc2LDyTDiNFVQmbDqdvaIYA3OeHATFVOfqUGFYHryzyC5m62ncUTGgbZ7iRe4KF
	 LCE/y2fC6q0GUILH+uoro/2mRqmZVpm+VyDRTtYbpRp9SPU0QKOpWAc7iJ45QUvVdH
	 dkK74axwz516YqWTwNoCJADeDRuaYiLzseG7sDdRg94ebkoj18kutHR616M8042wLc
	 eiSrqkXrzeRVBejE41BGCsPMAmJGab5filzdTWY4yWSEKApuUor4LnNS2o6bhGPJej
	 2COwV3WTH9LPw==
Date: Thu, 13 Nov 2025 17:16:18 +0000
To: "1120598@bugs.debian.org" <1120598@bugs.debian.org>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Scott Mayhew <smayhew@redhat.com>, Steve Dickson <steved@redhat.com>, Salvatore Bonaccorso <carnil@debian.org>
From: "Tyler W. Ross" <TWR@tylerwross.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5 NFSv4 client using SHA2
Message-ID: <c8-cRKuS2KXjk19lBwOGLCt21IbVv7HsS-V-ihDmhQ1Uae_LHNm83T0dOKvbYqsf4AeP5T8PR_xdiKLj5-Nvec-QVTLqIC4NGuU2FA0hN5U=@tylerwross.com>
In-Reply-To: <8d873978-2df6-4b79-891d-f0fd78485551@oracle.com>
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net> <aRVl8yGqTkyaWxPM@eldamar.lan> <8d873978-2df6-4b79-891d-f0fd78485551@oracle.com>
Feedback-ID: 101639484:user:proton
X-Pm-Message-ID: 42789f88a753c0b5e258f93d710b47a811499867
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks, Chunk.

Suggested trace-cmd report from the client follows. Last 3 lines appear sal=
ient, but I've included the full report just in case.

cpus=3D4
              ls-969   [003] .....   270.318649: nfs_getattr_enter:    file=
id=3D00:2d:262146 fhandle=3D0xad8c294c version=3D31 cache_validity=3D0x0 ()
              ls-969   [003] .....   270.318651: nfs_getattr_exit:     erro=
r=3D0 (OK) fileid=3D00:2d:262146 fhandle=3D0xad8c294c type=3D4 (DIR) versio=
n=3D31 size=3D4096 cache_validity=3D0x0 () nfs_flags=3D0x0 ()
              ls-969   [003] .....   270.318654: nfs_revalidate_inode_enter=
: fileid=3D00:2d:262146 fhandle=3D0xad8c294c version=3D31 cache_validity=3D=
0x0 ()
              ls-969   [003] .....   270.318658: rpc_task_begin:       task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3D0x4=
 status=3D0 action=3D0x0
              ls-969   [003] .....   270.318658: rpc_task_run_action:  task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Drpc_prepare_task
              ls-969   [003] .....   270.318660: nfs4_setup_sequence:  sess=
ion=3D0x5988ad3c slot_nr=3D0 seq_nr=3D24 highest_used_slotid=3D0
              ls-969   [003] .....   270.318661: rpc_task_run_action:  task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_start
              ls-969   [003] .....   270.318661: rpc_request:          task=
:00000006@00000005 nfsv4 GETATTR (sync)
              ls-969   [003] .....   270.318662: rpc_task_run_action:  task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_reserve
              ls-969   [003] .....   270.318663: xprt_reserve:         task=
:00000006@00000005 xid=3D0x79569c7a
              ls-969   [003] .....   270.318663: rpc_task_run_action:  task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_reserveresult
              ls-969   [003] .....   270.318663: rpc_task_run_action:  task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_refresh
        rpc.gssd-613   [001] .....   270.318690: rpcgss_upcall_msg:    msg=
=3D'mech=3Dkrb5 uid=3D591200003 enctypes=3D20,19,18,17'
        rpc.gssd-970   [002] .....   270.326582: rpcgss_context:       win_=
size=3D128 expiry=3D4316009978 now=3D4294959728 timeout=3D84201 acceptor=3D=
nfs@nfssrv.ipa.twrlab.net
              ls-969   [003] ...1.   270.326598: rpcgss_ctx_init:      cred=
=3D0xffff8895c5989900 service=3Dintegrity principal=3D'(null)'
              ls-969   [003] .....   270.326600: rpcgss_upcall_result: for =
uid 591200003, result=3D0
              ls-969   [003] .....   270.326601: rpc_task_run_action:  task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_refreshresult
              ls-969   [003] .....   270.326601: rpc_task_run_action:  task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_allocate
              ls-969   [003] .....   270.326603: rpc_buf_alloc:        task=
:00000006@00000005 callsize=3D1844 recvsize=3D2704 status=3D0
              ls-969   [003] .....   270.326603: rpc_task_run_action:  task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_encode
              ls-969   [003] .....   270.326604: rpcgss_seqno:         task=
:00000006@00000005 xid=3D0x79569c7a seqno=3D1
              ls-969   [003] .....   270.326611: rpc_task_run_action:  task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x1c status=3D0 action=3Dcall_transmit
              ls-969   [003] ...1.   270.326611: xprt_reserve_xprt:    task=
:00000006@00000005 snd_task:00000006
              ls-969   [003] .....   270.326612: rpcgss_need_reencode: task=
:00000006@00000005 xid=3D0x79569c7a rq_seqno=3D1 seq_xmit=3D0 reencode unne=
eded
              ls-969   [003] .....   270.326612: rpc_xdr_sendto:       task=
:00000006@00000005 head=3D[0xffff8895c29fe008,260] page=3D0(0) tail=3D[(nil=
),0] len=3D260
              ls-969   [003] .....   270.326627: xprt_transmit:        task=
:00000006@00000005 xid=3D0x79569c7a seqno=3D1 status=3D0
              ls-969   [003] ...1.   270.326628: xprt_release_xprt:    task=
:00000006@00000005 snd_task:ffffffff
              ls-969   [003] .....   270.326629: rpc_task_run_action:  task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x14 status=3D0 action=3Dcall_transmit_status
              ls-969   [003] ...2.   270.326629: rpc_task_sleep:       task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x14 status=3D0 timeout=3D0 queue=3Dxprt_pending
              ls-969   [003] .....   270.326630: rpc_task_sync_sleep:  task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3D0x16 status=3D0 action=3Dcall_status
          <idle>-0     [001] ..s2.   270.326754: xs_data_ready:        peer=
=3D[10.108.2.102]:2049
   kworker/u16:0-12    [001] ...1.   270.326762: xprt_lookup_rqst:     peer=
=3D[10.108.2.102]:2049 xid=3D0x79569c7a status=3D0
   kworker/u16:0-12    [001] ...2.   270.326764: rpc_task_wakeup:      task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3D0x6 status=3D0 timeout=3D15000 queue=3Dxprt_pending
   kworker/u16:0-12    [001] .....   270.326768: xs_stream_read_request: pe=
er=3D[10.108.2.102]:2049 xid=3D0x79569c7a copied=3D384 reclen=3D384 offset=
=3D384
   kworker/u16:0-12    [001] .....   270.326769: xs_stream_read_data:  peer=
=3D[10.108.2.102]:2049 err=3D-11 total=3D388
              ls-969   [003] .....   270.326775: rpc_task_sync_wake:   task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D0 action=3Dcall_status
              ls-969   [003] .....   270.326775: rpc_task_run_action:  task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D0 action=3Dxprt_timer
              ls-969   [003] .....   270.326775: rpc_task_run_action:  task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D0 action=3Dcall_status
              ls-969   [003] .....   270.326775: rpc_task_run_action:  task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D0 action=3Dcall_decode
              ls-969   [003] .....   270.326776: rpc_xdr_recvfrom:     task=
:00000006@00000005 head=3D[0xffff8895c29fe73c,2704] page=3D0(0) tail=3D[(ni=
l),0] len=3D384
              ls-969   [003] .....   270.326785: nfs4_map_name_to_uid: erro=
r=3D0 (OK) id=3D591200000 name=3Dadmin@ipa.twrlab.net
              ls-969   [003] .....   270.326786: nfs4_map_group_to_gid: err=
or=3D0 (OK) id=3D591200004 name=3Ddomainusers@ipa.twrlab.net
              ls-969   [003] .....   270.326787: rpc_task_run_action:  task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D0 action=3Drpc_exit_task
              ls-969   [003] .....   270.326787: rpc_task_end:         task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D0 action=3Drpc_exit_task
              ls-969   [003] .....   270.326788: rpc_stats_latency:    task=
:00000006@00000005 xid=3D0x79569c7a nfsv4 GETATTR backlog=3D7956 rtt=3D149 =
execute=3D8131 xprt_id=3D1
              ls-969   [003] .....   270.326789: rpc_task_call_done:   task=
:00000006@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D0 action=3Dnfs41_call_sync_done
              ls-969   [003] .....   270.326789: nfs4_sequence_done:   erro=
r=3D0 (OK) session=3D0x5988ad3c slot_nr=3D0 seq_nr=3D24 highest_slotid=3D63=
 target_highest_slotid=3D63 status_flags=3D0x0 ()
              ls-969   [003] ...1.   270.326791: xprt_release_xprt:    task=
:00000006@00000005 snd_task:ffffffff
              ls-969   [003] .....   270.326793: nfs4_getattr:         erro=
r=3D0 (OK) fileid=3D00:2d:262146 fhandle=3D0xad8c294c valid=3DTYPE|MODE|NLI=
NK|OWNER|GROUP|RDEV|SIZE|FSID|FILEID|ATIME|MTIME|CTIME|CHANGE|BTIME|0x40020=
0
              ls-969   [003] ...1.   270.326795: nfs_refresh_inode_enter: f=
ileid=3D00:2d:262146 fhandle=3D0xad8c294c version=3D31 cache_validity=3D0x0=
 ()
              ls-969   [003] ...1.   270.326797: nfs_set_cache_invalid: err=
or=3D0 (OK) fileid=3D00:2d:262146 fhandle=3D0xad8c294c type=3D4 (DIR) versi=
on=3D31 size=3D4096 cache_validity=3D0x0 () nfs_flags=3D0x0 ()
              ls-969   [003] ...1.   270.326797: nfs_refresh_inode_exit: er=
ror=3D0 (OK) fileid=3D00:2d:262146 fhandle=3D0xad8c294c type=3D4 (DIR) vers=
ion=3D31 size=3D4096 cache_validity=3D0x0 () nfs_flags=3D0x0 ()
              ls-969   [003] .....   270.326798: nfs_revalidate_inode_exit:=
 error=3D0 (OK) fileid=3D00:2d:262146 fhandle=3D0xad8c294c type=3D4 (DIR) v=
ersion=3D31 size=3D4096 cache_validity=3D0x0 () nfs_flags=3D0x0 ()
              ls-969   [003] .....   270.326799: nfs_access_enter:     file=
id=3D00:2d:262146 fhandle=3D0xad8c294c version=3D31 cache_validity=3D0x0 ()
              ls-969   [003] .....   270.326801: rpc_task_begin:       task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3D0x4=
 status=3D0 action=3D0x0
              ls-969   [003] .....   270.326801: rpc_task_run_action:  task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Drpc_prepare_task
              ls-969   [003] .....   270.326801: nfs4_setup_sequence:  sess=
ion=3D0x5988ad3c slot_nr=3D0 seq_nr=3D25 highest_used_slotid=3D0
              ls-969   [003] .....   270.326802: rpc_task_run_action:  task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_start
              ls-969   [003] .....   270.326802: rpc_request:          task=
:00000007@00000005 nfsv4 ACCESS (sync)
              ls-969   [003] .....   270.326802: rpc_task_run_action:  task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_reserve
              ls-969   [003] .....   270.326803: xprt_reserve:         task=
:00000007@00000005 xid=3D0x7a569c7a
              ls-969   [003] .....   270.326803: rpc_task_run_action:  task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_reserveresult
              ls-969   [003] .....   270.326803: rpc_task_run_action:  task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_refresh
              ls-969   [003] .....   270.326804: rpc_task_run_action:  task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_refreshresult
              ls-969   [003] .....   270.326804: rpc_task_run_action:  task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_allocate
              ls-969   [003] .....   270.326804: rpc_buf_alloc:        task=
:00000007@00000005 callsize=3D1836 recvsize=3D2712 status=3D0
              ls-969   [003] .....   270.326804: rpc_task_run_action:  task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_encode
              ls-969   [003] .....   270.326805: rpcgss_seqno:         task=
:00000007@00000005 xid=3D0x7a569c7a seqno=3D2
              ls-969   [003] .....   270.326807: rpc_task_run_action:  task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x1c status=3D0 action=3Dcall_transmit
              ls-969   [003] ...1.   270.326807: xprt_reserve_xprt:    task=
:00000007@00000005 snd_task:00000007
              ls-969   [003] .....   270.326808: rpcgss_need_reencode: task=
:00000007@00000005 xid=3D0x7a569c7a rq_seqno=3D2 seq_xmit=3D1 reencode unne=
eded
              ls-969   [003] .....   270.326808: rpc_xdr_sendto:       task=
:00000007@00000005 head=3D[0xffff8895c29fe008,268] page=3D0(0) tail=3D[(nil=
),0] len=3D268
              ls-969   [003] .....   270.326816: xprt_transmit:        task=
:00000007@00000005 xid=3D0x7a569c7a seqno=3D2 status=3D0
              ls-969   [003] ...1.   270.326817: xprt_release_xprt:    task=
:00000007@00000005 snd_task:ffffffff
              ls-969   [003] .....   270.326817: rpc_task_run_action:  task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x14 status=3D0 action=3Dcall_transmit_status
              ls-969   [003] ...2.   270.326817: rpc_task_sleep:       task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x14 status=3D0 timeout=3D0 queue=3Dxprt_pending
              ls-969   [003] .....   270.326817: rpc_task_sync_sleep:  task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3D0x16 status=3D0 action=3Dcall_status
          <idle>-0     [001] ..s2.   270.326882: xs_data_ready:        peer=
=3D[10.108.2.102]:2049
   kworker/u16:0-12    [001] ...1.   270.326885: xprt_lookup_rqst:     peer=
=3D[10.108.2.102]:2049 xid=3D0x7a569c7a status=3D0
   kworker/u16:0-12    [001] ...2.   270.326885: rpc_task_wakeup:      task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3D0x6 status=3D0 timeout=3D15000 queue=3Dxprt_pending
   kworker/u16:0-12    [001] .....   270.326888: xs_stream_read_request: pe=
er=3D[10.108.2.102]:2049 xid=3D0x7a569c7a copied=3D260 reclen=3D260 offset=
=3D260
   kworker/u16:0-12    [001] .....   270.326888: xs_stream_read_data:  peer=
=3D[10.108.2.102]:2049 err=3D-11 total=3D264
              ls-969   [003] .....   270.326895: rpc_task_sync_wake:   task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D0 action=3Dcall_status
              ls-969   [003] .....   270.326895: rpc_task_run_action:  task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D0 action=3Dxprt_timer
              ls-969   [003] .....   270.326895: rpc_task_run_action:  task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D0 action=3Dcall_status
              ls-969   [003] .....   270.326895: rpc_task_run_action:  task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D0 action=3Dcall_decode
              ls-969   [003] .....   270.326895: rpc_xdr_recvfrom:     task=
:00000007@00000005 head=3D[0xffff8895c29fe734,2712] page=3D0(0) tail=3D[(ni=
l),0] len=3D260
              ls-969   [003] .....   270.326898: rpc_task_run_action:  task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D0 action=3Drpc_exit_task
              ls-969   [003] .....   270.326898: rpc_task_end:         task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D0 action=3Drpc_exit_task
              ls-969   [003] .....   270.326899: rpc_stats_latency:    task=
:00000007@00000005 xid=3D0x7a569c7a nfsv4 ACCESS backlog=3D7 rtt=3D76 execu=
te=3D98 xprt_id=3D1
              ls-969   [003] .....   270.326899: rpc_task_call_done:   task=
:00000007@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D0 action=3Dnfs41_call_sync_done
              ls-969   [003] .....   270.326899: nfs4_sequence_done:   erro=
r=3D0 (OK) session=3D0x5988ad3c slot_nr=3D0 seq_nr=3D25 highest_slotid=3D63=
 target_highest_slotid=3D63 status_flags=3D0x0 ()
              ls-969   [003] ...1.   270.326900: xprt_release_xprt:    task=
:00000007@00000005 snd_task:ffffffff
              ls-969   [003] ...1.   270.326901: nfs_refresh_inode_enter: f=
ileid=3D00:2d:262146 fhandle=3D0xad8c294c version=3D31 cache_validity=3D0x0=
 ()
              ls-969   [003] ...1.   270.326901: nfs_set_cache_invalid: err=
or=3D0 (OK) fileid=3D00:2d:262146 fhandle=3D0xad8c294c type=3D4 (DIR) versi=
on=3D31 size=3D4096 cache_validity=3D0x0 () nfs_flags=3D0x0 ()
              ls-969   [003] ...1.   270.326901: nfs_refresh_inode_exit: er=
ror=3D0 (OK) fileid=3D00:2d:262146 fhandle=3D0xad8c294c type=3D4 (DIR) vers=
ion=3D31 size=3D4096 cache_validity=3D0x0 () nfs_flags=3D0x0 ()
              ls-969   [003] .....   270.326902: nfs4_access:          erro=
r=3D0 (OK) fileid=3D00:2d:262146 fhandle=3D0xad8c294c
              ls-969   [003] .....   270.326903: nfs_access_exit:      erro=
r=3D0 (OK) fileid=3D00:2d:262146 fhandle=3D0xad8c294c type=3D4 (DIR) versio=
n=3D31 size=3D4096 cache_validity=3D0x0 () nfs_flags=3D0x4 (ACL_LRU_SET) ma=
sk=3D0x24 permitted=3D0x7
              ls-969   [003] .....   270.326907: nfs_getattr_enter:    file=
id=3D00:2d:262146 fhandle=3D0xad8c294c version=3D31 cache_validity=3D0x0 ()
              ls-969   [003] .....   270.326908: nfs_getattr_exit:     erro=
r=3D0 (OK) fileid=3D00:2d:262146 fhandle=3D0xad8c294c type=3D4 (DIR) versio=
n=3D31 size=3D4096 cache_validity=3D0x0 () nfs_flags=3D0x4 (ACL_LRU_SET)
              ls-969   [003] .....   270.326928: nfs_readdir_cache_fill: fi=
leid=3D00:2d:262146 fhandle=3D0xad8c294c version=3D31 cookie=3D000000000000=
0000:0x0 cache_index=3D0 dtsize=3D4096
              ls-969   [003] .....   270.326931: rpc_task_begin:       task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3D0x4=
 status=3D0 action=3D0x0
              ls-969   [003] .....   270.326931: rpc_task_run_action:  task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Drpc_prepare_task
              ls-969   [003] .....   270.326931: nfs4_setup_sequence:  sess=
ion=3D0x5988ad3c slot_nr=3D0 seq_nr=3D26 highest_used_slotid=3D0
              ls-969   [003] .....   270.326931: rpc_task_run_action:  task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_start
              ls-969   [003] .....   270.326932: rpc_request:          task=
:00000008@00000005 nfsv4 READDIR (sync)
              ls-969   [003] .....   270.326932: rpc_task_run_action:  task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_reserve
              ls-969   [003] .....   270.326932: xprt_reserve:         task=
:00000008@00000005 xid=3D0x7b569c7a
              ls-969   [003] .....   270.326932: rpc_task_run_action:  task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_reserveresult
              ls-969   [003] .....   270.326932: rpc_task_run_action:  task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_refresh
              ls-969   [003] .....   270.326933: rpc_task_run_action:  task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_refreshresult
              ls-969   [003] .....   270.326933: rpc_task_run_action:  task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_allocate
              ls-969   [003] .....   270.326933: rpc_buf_alloc:        task=
:00000008@00000005 callsize=3D3932 recvsize=3D176 status=3D0
              ls-969   [003] .....   270.326933: rpc_task_run_action:  task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x4 status=3D0 action=3Dcall_encode
              ls-969   [003] .....   270.326934: rpcgss_seqno:         task=
:00000008@00000005 xid=3D0x7b569c7a seqno=3D3
              ls-969   [003] .....   270.326936: rpc_xdr_reply_pages:  task=
:00000008@00000005 head=3D[0xffff8895c29fef64,140] page=3D4008(88) tail=3D[=
0xffff8895c29feff0,36] len=3D0
              ls-969   [003] .....   270.326937: rpc_task_run_action:  task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|NORTO|CRED_NOREF runstate=3DRUN=
NING|0x1c status=3D0 action=3Dcall_transmit
              ls-969   [003] ...1.   270.326937: xprt_reserve_xprt:    task=
:00000008@00000005 snd_task:00000008
              ls-969   [003] .....   270.326937: rpcgss_need_reencode: task=
:00000008@00000005 xid=3D0x7b569c7a rq_seqno=3D3 seq_xmit=3D2 reencode unne=
eded
              ls-969   [003] .....   270.326938: rpc_xdr_sendto:       task=
:00000008@00000005 head=3D[0xffff8895c29fe008,284] page=3D0(0) tail=3D[(nil=
),0] len=3D284
              ls-969   [003] .....   270.326946: xprt_transmit:        task=
:00000008@00000005 xid=3D0x7b569c7a seqno=3D3 status=3D0
              ls-969   [003] ...1.   270.326947: xprt_release_xprt:    task=
:00000008@00000005 snd_task:ffffffff
              ls-969   [003] .....   270.326947: rpc_task_run_action:  task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x14 status=3D0 action=3Dcall_transmit_status
              ls-969   [003] ...2.   270.326947: rpc_task_sleep:       task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x14 status=3D0 timeout=3D0 queue=3Dxprt_pending
              ls-969   [003] .....   270.326947: rpc_task_sync_sleep:  task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3D0x16 status=3D0 action=3Dcall_status
          <idle>-0     [001] ..s2.   270.327040: xs_data_ready:        peer=
=3D[10.108.2.102]:2049
   kworker/u16:0-12    [001] ...1.   270.327048: xprt_lookup_rqst:     peer=
=3D[10.108.2.102]:2049 xid=3D0x7b569c7a status=3D0
   kworker/u16:0-12    [001] ...2.   270.327050: rpc_task_wakeup:      task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3D0x6 status=3D0 timeout=3D15000 queue=3Dxprt_pending
   kworker/u16:0-12    [001] .....   270.327054: xs_stream_read_request: pe=
er=3D[10.108.2.102]:2049 xid=3D0x7b569c7a copied=3D988 reclen=3D988 offset=
=3D988
   kworker/u16:0-12    [001] .....   270.327055: xs_stream_read_data:  peer=
=3D[10.108.2.102]:2049 err=3D-11 total=3D992
              ls-969   [003] .....   270.327062: rpc_task_sync_wake:   task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D0 action=3Dcall_status
              ls-969   [003] .....   270.327062: rpc_task_run_action:  task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D0 action=3Dxprt_timer
              ls-969   [003] .....   270.327063: rpc_task_run_action:  task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D0 action=3Dcall_status
              ls-969   [003] .....   270.327063: rpc_task_run_action:  task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D0 action=3Dcall_decode
              ls-969   [003] .....   270.327063: rpc_xdr_recvfrom:     task=
:00000008@00000005 head=3D[0xffff8895c29fef64,140] page=3D4008(88) tail=3D[=
0xffff8895c29feff0,36] len=3D988
              ls-969   [003] .....   270.327067: rpc_xdr_overflow:     task=
:00000008@00000005 nfsv4 READDIR requested=3D8 p=3D0xffff8895c29fefec end=
=3D0xffff8895c29feff0 xdr=3D[0xffff8895c29fef64,140]/4008/[0xffff8895c29fef=
f0,36]/988
              ls-969   [003] .....   270.327068: rpc_task_run_action:  task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D-5 action=3Drpc_exit_task
              ls-969   [003] .....   270.327068: rpc_task_end:         task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D-5 action=3Drpc_exit_task
              ls-969   [003] .....   270.327068: rpc_stats_latency:    task=
:00000008@00000005 xid=3D0x7b569c7a nfsv4 READDIR backlog=3D7 rtt=3D110 exe=
cute=3D137 xprt_id=3D1
              ls-969   [003] .....   270.327068: rpc_task_call_done:   task=
:00000008@00000005 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=
=3DRUNNING|0x4 status=3D-5 action=3Dnfs41_call_sync_done
              ls-969   [003] .....   270.327068: nfs4_sequence_done:   erro=
r=3D0 (OK) session=3D0x5988ad3c slot_nr=3D0 seq_nr=3D26 highest_slotid=3D63=
 target_highest_slotid=3D63 status_flags=3D0x0 ()
              ls-969   [003] ...1.   270.327069: xprt_release_xprt:    task=
:00000008@00000005 snd_task:ffffffff
              ls-969   [003] ...1.   270.327070: nfs_set_cache_invalid: err=
or=3D0 (OK) fileid=3D00:2d:262146 fhandle=3D0xad8c294c type=3D4 (DIR) versi=
on=3D31 size=3D4096 cache_validity=3D0x4 (INVALID_ATIME) nfs_flags=3D0x4 (A=
CL_LRU_SET)
              ls-969   [003] .....   270.327070: nfs4_readdir:         erro=
r=3D-5 (EIO) fileid=3D00:2d:262146 fhandle=3D0xad8c294c
              ls-969   [003] .....   270.327071: nfs_readdir_cache_fill_don=
e: error=3D-5 (IO) fileid=3D00:2d:262146 fhandle=3D0xad8c294c type=3D4 (DIR=
) version=3D31 size=3D4096 cache_validity=3D0x4 (INVALID_ATIME) nfs_flags=
=3D0x4 (ACL_LRU_SET)



TWR


