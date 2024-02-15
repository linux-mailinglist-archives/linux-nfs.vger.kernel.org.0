Return-Path: <linux-nfs+bounces-1981-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EC88570D2
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 23:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D8F1C22639
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 22:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DEF2F30;
	Thu, 15 Feb 2024 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwJs2X+t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF6B13B2BF
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037739; cv=none; b=lMbwNuvQS0LeJJQFfP6Dz6CUO8fiopYnRkoo8XoezPINuCLlxCdPXCSmzIp11YBW5m3eZqauSVJyy5zTMTk3BQQ/IjoY4eJklHeMVl6UvtxaFFWI3Mz+QYgB+OI/YceupsIGVeEBguykadB8kjKlki7YA3o7xlH3pz21/8G3zsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037739; c=relaxed/simple;
	bh=QLeyHs3xueE6EjPGnnRWIhs2QexL6hddi0ZMopmicXI=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pm/sfhgWn8Jyvz6H8rKs6BMeZIav0Noj77d2xlpqSqlaO+w3QFjdDFNJNpnVyVMrDgWG3BjC88twW9FK9PVMvc8+uA/rNolrkJn3Zs80Z/9a747BjoVxA1ntWrg9XlegDwWJk3J/4uszIzRPz/+ZH+UROn9vT25rm7umZoaRblQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwJs2X+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A87C433F1
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 22:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708037739;
	bh=QLeyHs3xueE6EjPGnnRWIhs2QexL6hddi0ZMopmicXI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=iwJs2X+tBKLugjFBvxI6fy7U6oGx2wgKrvPnrViAO2BSQDmFoMdByko8hs168m3jW
	 0xncv38Fxs4AfgT50C/pzFpcaUQmbcCklXOcz01v9QbPKwJSlU8sfEj4xDp4eWfEVV
	 8mfjqPvewcxvNv+liF9hQ7MFGSd+Eot7X0kzJJtE5iqFMZaM9vwhv35uD7+RfS0yhL
	 QnwDIJV2Ioa4gnh83vIZIo43XuECyF3BhAZnS2D2wmUNsLBWS/ic50T5N7yaLQ++Uo
	 Or6a8MMo2LW6qo/bAK/eUPaTge7gh/vd+8HKnil0SsgLH7MPYggtpAigCi1s0fM3Ne
	 KS9UoBADvW28Q==
Subject: [PATCH v2 2/2] nfsd: don't take fi_lock in nfsd_break_deleg_cb()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 15 Feb 2024 17:55:38 -0500
Message-ID: 
 <170803773812.10525.7715180641100284609.stgit@manet.1015granger.net>
In-Reply-To: 
 <170803741752.10525.14867593238471365383.stgit@manet.1015granger.net>
References: 
 <170803741752.10525.14867593238471365383.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: NeilBrown <neilb@suse.de>

[ Upstream commit 5ea9a7c5fe4149f165f0e3b624fe08df02b6c301 ]

A recent change to check_for_locks() changed it to take ->flc_lock while
holding ->fi_lock.  This creates a lock inversion (reported by lockdep)
because there is a case where ->fi_lock is taken while holding
->flc_lock.

->flc_lock is held across ->fl_lmops callbacks, and
nfsd_break_deleg_cb() is one of those and does take ->fi_lock.  However
it doesn't need to.

Prior to v4.17-rc1~110^2~22 ("nfsd: create a separate lease for each
delegation") nfsd_break_deleg_cb() would walk the ->fi_delegations list
and so needed the lock.  Since then it doesn't walk the list and doesn't
need the lock.

Two actions are performed under the lock.  One is to call
nfsd_break_one_deleg which calls nfsd4_run_cb().  These doesn't act on
the nfs4_file at all, so don't need the lock.

The other is to set ->fi_had_conflict which is in the nfs4_file.
This field is only ever set here (except when initialised to false)
so there is no possible problem will multiple threads racing when
setting it.

The field is tested twice in nfs4_set_delegation().  The first test does
not hold a lock and is documented as an opportunistic optimisation, so
it doesn't impose any need to hold ->fi_lock while setting
->fi_had_conflict.

The second test in nfs4_set_delegation() *is* make under ->fi_lock, so
removing the locking when ->fi_had_conflict is set could make a change.
The change could only be interesting if ->fi_had_conflict tested as
false even though nfsd_break_one_deleg() ran before ->fi_lock was
unlocked.  i.e. while hash_delegation_locked() was running.
As hash_delegation_lock() doesn't interact in any way with nfs4_run_cb()
there can be no importance to this interaction.

So this patch removes the locking from nfsd_break_one_deleg() and moves
the final test on ->fi_had_conflict out of the locked region to make it
clear that locking isn't important to the test.  It is still tested
*after* vfs_setlease() has succeeded.  This might be significant and as
vfs_setlease() takes ->flc_lock, and nfsd_break_one_deleg() is called
under ->flc_lock this "after" is a true ordering provided by a spinlock.

Fixes: edcf9725150e ("nfsd: fix RELEASE_LOCKOWNER")
Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 0443fe4e29e1..b3f6dda930d8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4908,10 +4908,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
 	 */
 	fl->fl_break_time = 0;
 
-	spin_lock(&fp->fi_lock);
 	fp->fi_had_conflict = true;
 	nfsd_break_one_deleg(dp);
-	spin_unlock(&fp->fi_lock);
 	return false;
 }
 
@@ -5499,12 +5497,13 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (status)
 		goto out_unlock;
 
+	status = -EAGAIN;
+	if (fp->fi_had_conflict)
+		goto out_unlock;
+
 	spin_lock(&state_lock);
 	spin_lock(&fp->fi_lock);
-	if (fp->fi_had_conflict)
-		status = -EAGAIN;
-	else
-		status = hash_delegation_locked(dp, fp);
+	status = hash_delegation_locked(dp, fp);
 	spin_unlock(&fp->fi_lock);
 	spin_unlock(&state_lock);
 



