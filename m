Return-Path: <linux-nfs+bounces-7318-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16029A5A4A
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 08:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290AF1F2309A
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 06:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D95119415E;
	Mon, 21 Oct 2024 06:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEpUjQsH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC044194AD9
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 06:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729492026; cv=none; b=VHq7/1jOC3iZ61VfhBX2yyc47R6sBjvmeoWrPMdmnWbyD77tiT7rjHAz5WWcxdRHrkSNtVXrD5SagB9A/k4jBcQ0TAW0nJm2BtIjUZpqCbCkJxk6NP8ciABKX/7HUKvAL6YgXtmsixhRm/BfL0y+myLXXorNEzP4zV6Y+96JCu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729492026; c=relaxed/simple;
	bh=xYY5YGB+VJd1TwKFSTNabxWKmnrOD5/gS12jed8vjgo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aJ6Uk890C0M2RzbqdJ1TYSLxCx/MICZTIMheYMfB0U2k6Kko2Pa0WnKQlM3BNUN7JemeuzfWzqR4cHSDr11QsTNel+Vlca0pYa/Cyomop1zRi4PWIlzxafVtLYH3f3yl8027iZuQBQpCrbFDHSJ3OOSCm8r2u+FBQE2Ix3FP7rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEpUjQsH; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e297c8f8c86so3907559276.2
        for <linux-nfs@vger.kernel.org>; Sun, 20 Oct 2024 23:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729492023; x=1730096823; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WGhLesrP+Unk60rbICACMmkPL3sJKTMp4F+KSbEJrxI=;
        b=mEpUjQsH1T6RMojqV4IZzo2W6p9l6e3ikD5xcZTx5mg7uEXe4cjvdxDVByMBbvBJ5t
         4qeMo+uBvdSFQ5rVSN5i70nHQrE0QxvJ7EtdB/PCNPxr2BhpLBOcF5PGMljWuRT4lyaO
         8aD11pS3Zqfcwa5OOlq79ne3q4ngsMnLmUMyBmsOhSgGuhxKG8hqL43NrPncVWXY3UVE
         gA/pkKiefxWqRCVqh/3htus1GdW9hGbWwPdlsG5ecp2c/oHpjdcNgSobYzXF6NKnuYKc
         ZdV3kCljfxw5zShZSLQ9i+w9vbJ1tvOKb9snAfWThfODUZa5cxqE4tQF+ot7EmA3TlK1
         17QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729492023; x=1730096823;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGhLesrP+Unk60rbICACMmkPL3sJKTMp4F+KSbEJrxI=;
        b=W1Olo3lX2CLBL7ivdsT4hu9+xyRU3w7jtb/5KBQjnwKP5h/cMR8CjAfPL5NsFC2E3O
         93u1/pjZuZ/VqN7C2eVQujRadfujZARZ0wfO9yFDgAJOWqBCoP3Wkff1yTkBpDgWzU5/
         lFQNKz5OZXNuqoy5jrw6PWp8p3A+5NUnxOHNCNNKH1d6vKHXIkDPY0V9mB6bBGshU9C+
         WHm7orHIE79KPCT4kMzWZK9OzulJDU3lJDFKeJsYEYIEiB3OekYHViLSoOzEoZHLPu1o
         nupLp+lCUURSWTbjhVj+JdMZJ7EQ0gliQA3vK2Q5cNYCbMpphAocNDqnbxDJWm0lVOnX
         gMQw==
X-Gm-Message-State: AOJu0YzbL3256EuQIO0ltFLDlTHSL+HjwopDyKD1auz4GKZPDre8NPpb
	EOr3DW9UjUe2nCgTgu7FyEB+7rY//MLin/6Y6+9AlLPeRQDlNDfnlPVXWNSKYdC3MxMCQP+756I
	8XZ/aKafULz0FjrloAXbzvmExxh+sE1yb
X-Google-Smtp-Source: AGHT+IGKRayb1NJRXX/nMyM9Ek70QQve6IE7AE3cHP8B/oqs76PlLQY2Oe+KwHo7ZoUgqyxYVLimX0uPJ+pbAZPr7KY=
X-Received: by 2002:a05:690c:4907:b0:6e5:de2d:39e0 with SMTP id
 00721157ae682-6e5de2d5659mr63239957b3.42.1729492023442; Sun, 20 Oct 2024
 23:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bharath SM <bharathsm.hsk@gmail.com>
Date: Mon, 21 Oct 2024 11:56:52 +0530
Message-ID: <CAGypqWyVW+W-mm51HUsGO2WT76YckFT_uwr4tySsEE8gwHGxVA@mail.gmail.com>
Subject: NFS Client crash during migration scenario
To: linux-nfs@vger.kernel.org, kolga@netapp.com, 
	trond.myklebust@hammerspace.com, chuck.lever@oracle.com, 
	Shyam Prasad N <nspmangalore@gmail.com>, Bharath S M <bharathsm@microsoft.com>, 
	Steve French <smfrench@gmail.com>, bill.baker@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We are working on a prototype of NFS v4.1 server migration and during
our testing we are noticing the following crashes with NFS clients
during the movement of traffic from Server-1 to Server-2.
Tested on Ubuntu distro with 5.15, 6.5 and 6.8 Linux kernel versions
and observed following crashes while accessing invalid xprt
structures. Can you please take a look at the issue and my findings so
far and suggest next steps?
Also please let me know if you would need additional information.

1.  Crash call stack:

Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253541] RIP:
0010:xprt_reserve+0x3c/0xd0 [sunrpc]
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253601] Code: bf b8 00 00
00 00 c7 47 04 00 00 00 00 4c 8b af a8 00 00 00 74 0d 5b 41 5c 41 5d
41 5e 5d c3 cc cc cc cc c7 47 04 f5 ff ff ff <49> 8b 85 08 04 00 00 49
89 fc f6 c4 02 75 28 49 8b
45 08 4c 89 e6
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253603] RSP:
0018:ff5d77a18d147b58 EFLAGS: 00010246
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253606] RAX:
0000000000000000 RBX: ff1ef854fc4b0000 RCX: 0000000000000000
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253607] RDX:
0000000000000000 RSI: 0000000000000000 RDI: ff1ef854d2191d00
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253608] RBP:
ff5d77a18d147b78 R08: ff1ef854d2191d30 R09: ffffffff8fa071a0
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253609] R10:
ff1ef854d2191d00 R11: 0000000000000076 R12: ff1ef854d2191d00
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253611] R13:
0000000000000000 R14: 0000000000000000 R15: ffffffffc0d2e5e0
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253613] FS:
0000000000000000(0000) GS:ff1ef8586fc40000(0000)
knlGS:0000000000000000
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253615] CS:  0010 DS: 0000
ES: 0000 CR0: 0000000080050033
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253617] CR2:
0000000000000408 CR3: 00000003ce43a005 CR4: 0000000000371ee0
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253618] DR0:
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253619] DR3:
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253620] Call Trace:
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253621]  <TASK>
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253623]  ? show_regs+0x6a/0x80
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253628]  ? __die+0x25/0x70
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253630]  ?
page_fault_oops+0x79/0x180
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253634]  ?
do_user_addr_fault+0x320/0x660
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253636]  ? vsnprintf+0x37d/0x55=
0
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253640]  ? exc_page_fault+0x74/=
0x160
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253644]  ?
asm_exc_page_fault+0x27/0x30
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253648]  ?
__pfx_call_reserve+0x10/0x10 [sunrpc]
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253688]  ?
xprt_reserve+0x3c/0xd0 [sunrpc]
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253730]
call_reserve+0x1d/0x30 [sunrpc]
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253773]
__rpc_execute+0xc1/0x2e0 [sunrpc]
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253830]
rpc_execute+0xbb/0xf0 [sunrpc]
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253885]
rpc_run_task+0x12e/0x190 [sunrpc]
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253926]
rpc_call_sync+0x51/0xb0 [sunrpc]
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253968]
_nfs4_proc_create_session+0x17a/0x370 [nfsv4]
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254020]  ? vprintk_default+0x1d=
/0x30
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254024]  ? vprintk+0x3c/0x70
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254026]  ? _printk+0x58/0x80
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254029]
nfs4_proc_create_session+0x67/0x130 [nfsv4]
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254065]  ?
nfs4_proc_create_session+0x67/0x130 [nfsv4]
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254100]  ?
__pfx_nfs4_test_session_trunk+0x10/0x10 [nfsv4]
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254133]
nfs4_reset_session+0xb2/0x1a0 [nfsv4]
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254170]
nfs4_state_manager+0x3cc/0x950 [nfsv4]
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254206]  ?
kernel_sigaction+0x79/0x110
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254209]  ?
__pfx_nfs4_run_state_manager+0x10/0x10 [nfsv4]
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254244]
nfs4_run_state_manager+0x64/0x170 [nfsv4]
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254280]  ?
__pfx_nfs4_run_state_manager+0x10/0x10 [nfsv4]
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254314]  kthread+0xd6/0x100
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254317]  ? __pfx_kthread+0x10/0=
x10
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254320]  ret_from_fork+0x3c/0x6=
0
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254325]  ? __pfx_kthread+0x10/0=
x10
Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254328]  ret_from_fork_asm

I looked at this crash and noticed following:

During NFS migration, when traffic starts going to server 2, we do see
BAD SESSION errors and the reason for the bad session is that the
client sends an old session ID to server-2 for some of the requests
even though the same session has been destroyed in server-1 along with
its client ID just few 100's milliseconds back. (Not sure if there is
some caching playing a role here or if session draining is not
happening cleanly).
Crash is happening on the client because, in response to a BAD SESSION
error from the server, the client tries to attempt the session
recovery and fails to get the transport for a rpc request, resulting
in a crash. (accessing already freed up structures?)

Snippet from trace-cmd logs:

Client ID was being released here:
   lxfilesstress-3416  [005]  5154.980981: rpc_clnt_shutdown:    client=3D0=
0000000
   lxfilesstress-3416  [005]  5154.980982: rpc_clnt_release:     client=3D0=
0000000

Just after a few ms, the same client ID is being used here for session
recovery operation after it has been freed up earlier:
20.150.9=C3=9F/I\^L;l-22349 [006]  5155.042037: rpc_request:
task:00000011@00000000 nfsv4 CREATE_SESSION (sync)
20.150.9=C3=9F/I\^L;l-22349 [006]  5155.042040: rpc_task_run_action:
task:00000011@00000000
flags=3DDYNAMIC|NO_ROUND_ROBIN|SOFT|TIMEOUT|NORTO|CRED_NOREF
runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_reserve ------> Crash
after this in call_reserve.


Client code:

void xprt_reserve(struct rpc_task *task)
{
        struct rpc_xprt *xprt =3D task->tk_xprt;
--------------------<<<<<<<<<<<<<<<< tk_xprt pointer is NULL
        task->tk_status =3D 0;
        if (task->tk_rqstp !=3D NULL)
                return;
        task->tk_status =3D -EAGAIN;
        if (!xprt_throttle_congested(xprt, task)) {
                xprt_do_reserve(xprt, task);
        }
}

tk_xprt is NULL in above function because, during session recovery rpc
request, sunrpc module tries to get xprt using
=E2=80=98rpc_task_get_first_xprt(clnt)=E2=80=99 for a given client but it t=
his
function returns NULL.

static void rpc_task_set_transport(struct rpc_task *task, struct rpc_clnt *=
clnt)
{
    if (task->tk_xprt) {
        if (!(test_bit(XPRT_OFFLINE, &task->tk_xprt->state) &&
              (task->tk_flags & RPC_TASK_MOVEABLE)))
            return;
        xprt_release(task);
        xprt_put(task->tk_xprt);
    }

    if (task->tk_flags & RPC_TASK_NO_ROUND_ROBIN)
        task->tk_xprt =3D rpc_task_get_first_xprt(clnt);
------------------------------- Returns NULL
    else
        task->tk_xprt =3D rpc_task_get_next_xprt(clnt);

}


We also noticed that, In nfs4_update_server after nfs4_set_client
call, we aren't calling nfs_init_server_rpcclient() whereas in all
other cases, after nfs4_set_clien we always called
nfs_init_server_rpcclient(). Can you please let me know if this is
expected.?


2. Another crash call stack with xprt structures being NULL just after
migration.

PID: 306169  TASK: ff4a4584198c8000  CPU: 6   COMMAND: "kworker/u16:0"
 #0 [ff5630b9cb397a10] machine_kexec at ffffffffb9e95ac2
 #1 [ff5630b9cb397a70] __crash_kexec at ffffffffb9fe022f
 #2 [ff5630b9cb397b38] panic at ffffffffb9ed62ce
 #3 [ff5630b9cb397bb8] oops_end at ffffffffb9e405a7
 #4 [ff5630b9cb397be0] page_fault_oops at ffffffffb9eaa482
 #5 [ff5630b9cb397c68] do_user_addr_fault at ffffffffb9eab090
 #6 [ff5630b9cb397cb0] exc_page_fault at ffffffffbadb1884
 #7 [ff5630b9cb397ce0] asm_exc_page_fault at ffffffffbae00bc7
    [exception RIP: xprt_release+317]
    RIP: ffffffffc0522afd  RSP: ff5630b9cb397d98  RFLAGS: 00010286
    RAX: 0000000000000045  RBX: ff4a4584198c8000  RCX: 0000000000000027
    RDX: 0000000000000000  RSI: 0000000000000001  RDI: ff4a45840a573d00
    RBP: ff5630b9cb397db8   R8: 000000007867a738   R9: 0000000000000020
    R10: 0000000000ffff10  R11: 000000000000000f  R12: ff4a45840a573d00
    R13: 0000000000000000  R14: 0000000000000000  R15: 0000000000000000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #8 [ff5630b9cb397dc0] rpc_release_resources_task at ffffffffc0533593 [sunr=
pc]
 #9 [ff5630b9cb397dd8] __rpc_execute at ffffffffc053d3ff [sunrpc]
#10 [ff5630b9cb397e38] rpc_async_schedule at ffffffffc053d830 [sunrpc]
#11 [ff5630b9cb397e58] process_one_work at ffffffffb9efd14e
#12 [ff5630b9cb397ea0] worker_thread at ffffffffb9efd3a0
#13 [ff5630b9cb397ee8] kthread at ffffffffb9f06dd6
#14 [ff5630b9cb397f28] ret_from_fork at ffffffffb9e4c62c
#15 [ff5630b9cb397f50] ret_from_fork_asm at ffffffffb9e038db


Thanks,
Bharath

