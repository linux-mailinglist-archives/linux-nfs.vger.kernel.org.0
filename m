Return-Path: <linux-nfs+bounces-9433-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC26AA182FB
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 18:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA736160410
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 17:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2881F4726;
	Tue, 21 Jan 2025 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scL9rjrB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785521509BF
	for <linux-nfs@vger.kernel.org>; Tue, 21 Jan 2025 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737480885; cv=none; b=kXApiyc6+2UAveSLraRW4aEwCy46GctIAsxBwRDiUF8xNkXdpwIl/wQasPfr8CAalbL/OSnC0bYW7czil0eyoHN5FUBNG0vAiqXvPQ9osI+YBj/sVhkaAgu/XFZl2hUeCPusM/I35iKt3RdJv4vChjHc8xWwmYfpvCHP0MZI+ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737480885; c=relaxed/simple;
	bh=u1QuwL0IQn4TcUhKSM7Tp+N19EaWFbQZStkMCStE0lU=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=lZQrsDdLXcq6SpLchTjt1V+lp1CuOAEDL4fgmcVCUfWr1e6qnjNTwCsJg73tUMCqZCvZ74CU8jCbCli6wqmmgRKeCnq6Vf0cUtIxws+o6UYE10RMWog+h9aSTbza7W6v7YLtFXHuaI/BnlX5eAqm4YGoqkYpRlheBD2Zz1sdL18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scL9rjrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CDEC4CEDF;
	Tue, 21 Jan 2025 17:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737480883;
	bh=u1QuwL0IQn4TcUhKSM7Tp+N19EaWFbQZStkMCStE0lU=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=scL9rjrBe5/EaGkKpogHGPwWFkCKEOig9v6T0MzRZV1tBBt/QocI++TK83BNVW8J1
	 hgt7jLRJ+TKmqRWbRMh7z98389SEHY2SJ+9LtHM0kqC+fNqQLY6ZYkRysVMORGX8jU
	 0lNyvrSds3pWcKqCH9rhvl6+FBokTMgxXjQSndpIg0TBMZw1LI64tl53D2k8Umq13C
	 xsaV/Zc4J+dU0wAz2joRm3D68ZSDZGAzzNLxPG0a+v1UvL7h28Mrjl85/rZ8ReXSBs
	 E/cH3YUClrPNWLpmHvrwGCaSjVyVp3eGk45Vj6Yh1IgYnLrEuvRw9GvlIqtY+XBzYX
	 9GG9gjHdrxkyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3D76A380AA75;
	Tue, 21 Jan 2025 17:35:08 +0000 (UTC)
From: Jeff Layton via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 21 Jan 2025 17:35:14 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: cel@kernel.org, trondmy@kernel.org, carnil@debian.org, anna@kernel.org, 
 linux-nfs@vger.kernel.org, herzog@phys.ethz.ch, harald.dunkel@aixigo.com, 
 chuck.lever@oracle.com, jlayton@kernel.org, 
 baptiste.pellegrin@ac-grenoble.fr, benoit.gschwind@minesparis.psl.eu
Message-ID: <20250121-b219710c10-7af78b1a3afc@bugzilla.kernel.org>
In-Reply-To: <20250121-b219710c7-773af1987926@bugzilla.kernel.org>
References: <20250121-b219710c7-773af1987926@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Jeff Layton writes via Kernel.org Bugzilla:

(In reply to Chuck Lever from comment #7)
> The trace captures I've reviewed suggest that a callback session is in use,
> so I would say the NFS minor version is 1 or higher. Perhaps it's not the
> RPC_SIGNALLED test above that is the problem, but the one later in
> nfsd4_cb_sequence_done().


Ok, good. Knowing that it's not v4.0 allows us to rule out some codepaths.
There are a couple of other cases where we goto need_restart:

The NFS4ERR_BADSESSION case does this, and also if it doesn't get a reply at all (case 1).
There is also this that looks a little sketchy:

------------8<-------------------
        trace_nfsd_cb_free_slot(task, cb);
        nfsd41_cb_release_slot(cb);

        if (RPC_SIGNALLED(task))
                goto need_restart;
out:
        return ret;
retry_nowait:
        if (rpc_restart_call_prepare(task))
                ret = false;
        goto out;
need_restart:
        if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
                trace_nfsd_cb_restart(clp, cb);
                task->tk_status = 0;
                cb->cb_need_restart = true;
        }
        return false;
------------8<-------------------

Probably now the same bug, but it looks like if RPC_SIGNALLED returns true, then it'll restart the RPC after releasing the slot. It seems like that could break the reply cache handling, as the restarted call could be on a different slot. I'll look at patching that, at least, though I'm not sure it's related to the hang.

More notes. The only way RPC_TASK_SIGNALLED gets set is:

   nfsd4_process_cb_update()
      rpc_shutdown_client()
          rpc_killall_tasks()

That gets called if:

        if (clp->cl_flags & NFSD4_CLIENT_CB_FLAG_MASK)
                nfsd4_process_cb_update(cb);

Which means that NFSD4_CLIENT_CB_UPDATE was probably set? NFSD4_CLIENT_CB_KILL seems less likely since that would nerf the cb_need_restart handling.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c10
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


