Return-Path: <linux-nfs+bounces-17389-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C45B5CEC6FC
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 19:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E6ED30081B0
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 18:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA822BE642;
	Wed, 31 Dec 2025 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXRzXMRZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7136922D78A;
	Wed, 31 Dec 2025 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767204523; cv=none; b=HY9gs2AherBAW8cu0QowsJiVOGJNWvPL/MmeYCdYzrWRjUdYev1K7zF5RjyaB4q53S99fTk880veP+msTLSvAgFnpKoPdOPerzdDhvKWKsK0tFL2L2+W1wMvTAblb37l7qpV/PjhlUnUSBdeGRbaJEcuMuKNjTYXck/BRfLc/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767204523; c=relaxed/simple;
	bh=mwbxQNvGxRTHRVzB5ZMBcRDAtwwSrGVatTUIlqrdbgs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mZf1+fhfGeQfO33Qs2cM5shNfnCF9wDLzkcwH8CXkXsKnQ0NZ/0fxiryiUTOUfe6AdP1Adu+/RLX0DLsMRKLuf6ztdPmTjXBPyIlqIUwClNpETHQyrblEpL6hvvBFyWI1iTCkK1T+YaDuwNWqi789itDlfvrRNdbGrtcTWTZ76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXRzXMRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C65C113D0;
	Wed, 31 Dec 2025 18:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767204522;
	bh=mwbxQNvGxRTHRVzB5ZMBcRDAtwwSrGVatTUIlqrdbgs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IXRzXMRZihHiRmdcXg27boPkq5atYDD4lQggb7xgVJEzsjIcdsHFQgRmuLT2L5ER8
	 1DGRPcgPsT+1Y2XXHKIArZjcTLRLJUr6u9mp+p2SVZx8UJXk2lUGL12hdb++KzK/gd
	 6tXItWMLjhhiR6AQOP+Lns3tEAj/Ac0kQNIOd38QeTC933IicVQBtRKV92fSX60xSN
	 gapFSS+dycquun+I6s6ZYyJz8xVhlWVWp68AGDj/5TR1jGYUzCUGz7XJ8JnVKapiw0
	 ++FL/Mf0K4JHOvjxoIf45PEpNnZ3qNDHBYQMSOXaHFtQNQ2Rqb1QAUWAfqg6kGbF+b
	 0Mru++aPEelwg==
Message-ID: <de47c214bf6c85735db8e74d630e05b4e9bbf767.camel@kernel.org>
Subject: Re: [PATCH] [RFC] NFSv4.1: slot table draining + memory reclaim can
 deadlock state manager creation
From: Trond Myklebust <trondmy@kernel.org>
To: Wang Zhaolong <wangzhaolong@huaweicloud.com>, anna@kernel.org, 
	kolga@netapp.com
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	lilingfeng3@huawei.com, zhangjian496@huawei.com
Date: Wed, 31 Dec 2025 13:08:41 -0500
In-Reply-To: <20251230071744.9762-1-wangzhaolong@huaweicloud.com>
References: <20251230071744.9762-1-wangzhaolong@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-30 at 15:17 +0800, Wang Zhaolong wrote:
> Hi all,
>=20
> I=E2=80=99d like to start an RFC discussion about a hung-task/deadlock th=
at
> we hit in
> production-like testing on NFSv4.1 clients under server outage +
> memory
> pressure. The system becomes stuck even after the server/network is
> restored.
>=20
> The scenario is:
>=20
> - NFSv4.1 client running heavy multi-threaded buffered I/O (fio-style
> workload)
> - server outage (restart/power-off) and/or network blackhole
> - client under significant memory pressure / reclaim activity
> (observed in the
> =C2=A0 traces below)
>=20
> The observed behavior is a deadlock cycle involving:
>=20
> - v4.1 session slot table =E2=80=9Cdraining=E2=80=9D (NFS4_SLOT_TBL_DRAIN=
ING)
> - state manager thread creation via kthread_run()
> - kthreadd entering direct reclaim and getting stuck in NFS
> commit/writeback paths
> - non-privileged RPC tasks sleeping on slot table waitq due to
> draining
>=20
> Below is the call-chain I reconstructed from traces (three key
> participants):
>=20
> P1: sunrpc worker 1 (error handling triggers session recovery and
> tries to startstate manager)
> rpc_exit_task
> =C2=A0 nfs_writeback_done
> =C2=A0=C2=A0=C2=A0 nfs4_write_done
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfs4_sequence_done
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfs41_sequence_process
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // status error, g=
oto session_recover
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(NFS4_SLOT_=
TBL_DRAINING, &session-
> >fc_slot_table.slot_tbl_state)=C2=A0 <1>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfs4_schedule_sess=
ion_recovery
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfs4_s=
chedule_state_manager
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 kthread_run=C2=A0 // - Create a state manager thread to
> release the draining slots
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 kthread_create_on_node
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __kthread_create_on_node
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_for_completion(&done);=C2=
=A0=C2=A0 <2> wait for <3>
>=20
> P2: kthreadd (thread creation triggers reclaim; reclaim hits NFS
> folios and blocks in commit wait)
> kthreadd
> =C2=A0kernel_thread
> =C2=A0 kernel_clone
> =C2=A0=C2=A0 copy_process
> =C2=A0=C2=A0=C2=A0 dup_task_struct
> =C2=A0=C2=A0=C2=A0=C2=A0 alloc_thread_stack_node
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __vmalloc_node_range
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __vmalloc_area_node
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm_area_alloc_pages
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 alloc_pages_bulk_array_m=
empolicy
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __alloc_pages_bulk
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __alloc_page=
s
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __perf=
orm_reclaim
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
try_to_free_pages
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 do_try_to_free_pages
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 shrink_zones
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 shrink_node
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 shrink_node_memcgs
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shrink_lruvec
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shrink_inactive_list
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shrink_folio_list
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filemap_release_folio
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfs_release_folio
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfs_wb_folio
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio PG=
_private !PG_writeback !PG_dirty
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf=
s_commit_inode(inode, FLUSH_SYNC);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 __nfs_commit_inode
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 nfs_generic_commit_list
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 nfs_commit_list
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 nfs_initiate_commit
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 rpc_run_task=C2=A0 // Async task
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 wait_on_commit=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 <3> wait for <4>
>=20
> P3: sunrpc worker 2 (non-privileged tasks are blocked by draining)
> __rpc_execute
> =C2=A0 nfs4_setup_sequence
> =C2=A0=C2=A0=C2=A0 // if (nfs4_slot_tbl_draining(tbl) && !args->sa_privil=
eged) goto
> sleep
> =C2=A0=C2=A0=C2=A0 rpc_sleep_on(&tbl->slot_tbl_waitq, task, NULL);=C2=A0=
=C2=A0=C2=A0 <4>=C2=A0 blocked
> by <1>
>=20
> This forms a deadlock:
>=20
> - <1> enables draining; non-privileged requests then block at <4>
> - recovery path attempts to create the state manager thread, but
> =C2=A0 blocks at <2> waiting for kthreadd
> - kthreadd is blocked at <3> waiting for commit progress /
> completion,
> =C2=A0 but commit/RPC progress is impeded because requests are stuck
> behind draining at <4>
> - once in this state, restoring the server/network does not resolve
> the deadlock
>=20
> I suspect this deadlock became possible after the following mainline
> change that
> freezes the session table immediately on NFS4ERR_BADSESSION (and
> similar error paths):
>=20
> c907e72f58ed ("NFSv4.1: freeze the session table upon receiving
> NFS4ERR_BADSESSION")
>=20
> It sets NFS4_SLOT_TBL_DRAINING before the recovery thread runs:
>=20
> Questions:
>=20
> 1. Has anyone else observed a similar deadlock involving slot table
> draining + memory
> =C2=A0=C2=A0 reclaim? It looks like a similar issue might have been repor=
ted
> before =E2=80=94 see
> =C2=A0=C2=A0 SUSE Bugzilla #1211527. [1]
> 2. Is it intended that kthreadd (or other critical kernel threads)
> may block in
> =C2=A0=C2=A0 nfs_commit_inode(FLUSH_SYNC) as part of reclaim?
> 3. Is there an established way to ensure recovery threads can always
> be created even
> =C2=A0=C2=A0 under severe memory pressure (e.g., reserve resources, GFP f=
lags,
> or moving state
> =C2=A0=C2=A0 manager creation out of contexts that can trigger reclaim)?
>=20
> I wrote a local patch purely as a discussion starter. I realize this
> approach is likely
> not the right solution upstream; I=E2=80=99m sharing it only to help reas=
on
> about where the
> cycle can be broken. I can post the patch if people think it=E2=80=99s us=
eful
> for the discussion.

I think we need to treat nfs_release_folio() as being different from
nfs_wb_folio() altogether. There are too many different ways in which
waiting on I/O can cause deadlocks, including waiting on the writeback
to complete. My suggestion is therefore that we just make this simple,
and see it as a hint that we should kick off either writeback or a
commit, but not that we should be waiting for it to complete.
So how about the following?

8<------------------------------------------------------------------
From 3533434037066b610d50e7bd36f3525ace296928 Mon Sep 17 00:00:00 2001
Message-ID: <3533434037066b610d50e7bd36f3525ace296928.1767204181.git.trond.=
myklebust@hammerspace.com>
From: Trond Myklebust <trond.myklebust@hammerspace.com>
Date: Wed, 31 Dec 2025 11:42:31 -0500
Subject: [PATCH] NFS: Fix a deadlock involving nfs_release_folio()

Wang Zhaolong reports a deadlock involving NFSv4.1 state recovery
waiting on kthreadd, which is attempting to reclaim memory by calling
nfs_release_folio(). The latter cannot make progress due to state
recovery being needed.

It seems that the only safe thing to do here is to kick off a writeback
of the folio, without waiting for completion, or else kicking off an
asynchronous commit.

Reported-by: Wang Zhaolong <wangzhaolong@huaweicloud.com>
Fixes: 96780ca55e3c ("NFS: fix up nfs_release_folio() to try to release the=
 page")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c          |  3 ++-
 fs/nfs/nfstrace.h      |  3 +++
 fs/nfs/write.c         | 32 ++++++++++++++++++++++++++++++++
 include/linux/nfs_fs.h |  1 +
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index d020aab40c64..d1c138a416cf 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -511,7 +511,8 @@ static bool nfs_release_folio(struct folio *folio, gfp_=
t gfp)
 		if ((current_gfp_context(gfp) & GFP_KERNEL) !=3D GFP_KERNEL ||
 		    current_is_kswapd() || current_is_kcompactd())
 			return false;
-		if (nfs_wb_folio(folio->mapping->host, folio) < 0)
+		if (nfs_wb_folio_reclaim(folio->mapping->host, folio) < 0 ||
+		    folio_test_private(folio))
 			return false;
 	}
 	return nfs_fscache_release_folio(folio, gfp);
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 6ce55e8e6b67..9f9ce4a565ea 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1062,6 +1062,9 @@ DECLARE_EVENT_CLASS(nfs_folio_event_done,
 DEFINE_NFS_FOLIO_EVENT(nfs_aop_readpage);
 DEFINE_NFS_FOLIO_EVENT_DONE(nfs_aop_readpage_done);
=20
+DEFINE_NFS_FOLIO_EVENT(nfs_writeback_folio_reclaim);
+DEFINE_NFS_FOLIO_EVENT_DONE(nfs_writeback_folio_reclaim_done);
+
 DEFINE_NFS_FOLIO_EVENT(nfs_writeback_folio);
 DEFINE_NFS_FOLIO_EVENT_DONE(nfs_writeback_folio_done);
=20
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 336c510f3750..5de9ec6c72a2 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2024,6 +2024,38 @@ int nfs_wb_folio_cancel(struct inode *inode, struct =
folio *folio)
 	return ret;
 }
=20
+/**
+ * nfs_wb_folio_reclaim - Write back all requests on one page
+ * @inode: pointer to page
+ * @folio: pointer to folio
+ *
+ * Assumes that the folio has been locked by the caller
+ */
+int nfs_wb_folio_reclaim(struct inode *inode, struct folio *folio)
+{
+	loff_t range_start =3D folio_pos(folio);
+	size_t len =3D folio_size(folio);
+	struct writeback_control wbc =3D {
+		.sync_mode =3D WB_SYNC_ALL,
+		.nr_to_write =3D 0,
+		.range_start =3D range_start,
+		.range_end =3D range_start + len - 1,
+		.for_sync =3D 1,
+	};
+	int ret;
+
+	if (folio_test_writeback(folio))
+		return -EBUSY;
+	if (folio_clear_dirty_for_io(folio)) {
+		trace_nfs_writeback_folio_reclaim(inode, range_start, len);
+		ret =3D nfs_writepage_locked(folio, &wbc);
+		trace_nfs_writeback_folio_reclaim_done(inode, range_start, len,
+						       ret);
+	} else
+		nfs_commit_inode(inode, 0);
+	return ret;
+}
+
 /**
  * nfs_wb_folio - Write back all requests on one page
  * @inode: pointer to page
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index a6624edb7226..8dd79a3f3d66 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -637,6 +637,7 @@ extern int  nfs_update_folio(struct file *file, struct =
folio *folio,
 extern int nfs_sync_inode(struct inode *inode);
 extern int nfs_wb_all(struct inode *inode);
 extern int nfs_wb_folio(struct inode *inode, struct folio *folio);
+extern int nfs_wb_folio_reclaim(struct inode *inode, struct folio *folio);
 int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio);
 extern int  nfs_commit_inode(struct inode *, int);
 extern struct nfs_commit_data *nfs_commitdata_alloc(void);
--=20
2.52.0


