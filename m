Return-Path: <linux-nfs+bounces-2126-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADF286D66D
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Feb 2024 22:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D401B22406
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Feb 2024 21:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5062E6D523;
	Thu, 29 Feb 2024 21:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1wmwJa1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5126D521;
	Thu, 29 Feb 2024 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243730; cv=none; b=GiFyo/zukBIaWOfF+mGvMdtiJj2bbDSDufkWup+lPWLsy8uVwKWuCB6BEQFRBZBqPXpobr7v86koyNa5pOdvZu6LQUvLytAa2+ZiAQ1A2mGwfMkSxiYfmEogwy0L/HV9e4ykhTMGPdTJsVfCG5k+5xZ/CQqvP0oLjvPxR0SiE+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243730; c=relaxed/simple;
	bh=QXwImBHkQU4oBCMDlASAtoeObYm8w7DXrTIbSDNAt40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UzS09ioPX3CBBCHhen+Np8WArYZ4m4uTVNkuLiRvKFPHNgtRzJw4jb2bp7NKERQ02/Wjejp8zbsWcI3exGSofzBUTJk6zAHrE20GnjN1DAmYIJvf5WTgPrcBhRzyKBQC+jMlj7seDDLva8YS8BnneyzK4MPlv5YgyK52u8PS0qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1wmwJa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEC8C433C7;
	Thu, 29 Feb 2024 21:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709243729;
	bh=QXwImBHkQU4oBCMDlASAtoeObYm8w7DXrTIbSDNAt40=;
	h=From:Date:Subject:To:Cc:From;
	b=k1wmwJa15FhdfrnwodWdq/GkznfkCJ39jCfh2Gh0+PduWbc8Fr+MQT8hyv/uwO5Dc
	 EwRyj0x63X3NcW3pzqf7I7qLkpwnGfM3HWrVnJs64WBRSMYdWXcgIHrK871ETYrIV4
	 kqIllaLvUAXuBTcxoYr4+D7IkmUKFbqLdL8FNfnW3pb1AqINLhLh+vQUxEZjuRCEHD
	 qb3CjuLCabAaRRRioC7RydS4LXHQ+eYSVdR2NCArTF8ZWsPqODlRJrrYvA7aFcVhAx
	 x/ZH02Fq44gCPV6ivv3AvsrUfFSWaLySfsfgJHs5VTuhXmA4PieCwZF/BtjG8mugvn
	 UBZtqOpFfjHew==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 Feb 2024 16:55:26 -0500
Subject: [PATCH RFC] nfsd: return NFS4ERR_DELAY on contention for v4.0
 replay_owner rp_mutex
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-rp_mutex-v1-1-47deb9e4d32d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAE394GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyNL3aKC+NzSktQK3RQjg1RjY0PLVGNDUyWg8oKi1LTMCrBR0UpBbs5
 KsbW1AHYo3VZfAAAA
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4484; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=QXwImBHkQU4oBCMDlASAtoeObYm8w7DXrTIbSDNAt40=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl4P1Q440J9i93kJmvdFmdQ3HdXV5UpvE4Cp8fd
 o8U9xOHkfKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZeD9UAAKCRAADmhBGVaC
 FTwcD/4wVDSH4NxzwIUI/ZD+cyBy+I6YFEUZaIlDCvWVXSpenQZq/ZiH+wiiQZRceeXscP0K+aa
 /6b9lnD1+PkgupDYAWCe4EMyd94Qpdfka42ZeKXDVwmeh//pk2ARmkichihJD+AQ4ZtIJDNYl/V
 vOjPXV9CwqVHgnRyc3XI8O+v42i0s5G2j72QTufhQLW+i14mRl1JB/AKLnthvV4hEHnk+5tKBY5
 z/KjBEz7nkBWq5HqCqUpKqgG4PLwmKNm6vZ00/5z4byC5r7wpAEd2FJk2gdThoZsAZtyDZ4b38U
 9dOR5pK654/vAyFuelvtJxD5NE71FNX3PkBKmSi+Z0L/z3miAMR8V+/EGqicMFaKqcx3f0FeL3U
 NonNZ803fxYPglRq+k0u+DLwnVql1XCJZ3JBLFMq4+loHhqg4pm8zQOu2jkCz5IUhay6imX0gTU
 Us5sCLMoDGaT1KW4xprllM4+KeAs39yQ7JgqJPlls4KRcGIeSy8YZhh4EzyENuFBbaXfh/1pHzo
 xXwPrwu0dRkbvB/WAE6rnS72LP8+I6MNfFj2NzgGly9+W2ItUr8JTeBmodgssu2hZBLE9gLrUgT
 uC+Z/s4oJvcUxsepjtD0ivyWilkF5f30atJugJq0Ke/9FoPHN0HdpL81H5k02u2eXwbb34B2u5s
 EmEEtX9+qhFRHEw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

move_to_close_lru() is currently called with ->st_mutex and .rp_mutex held.
This can lead to a deadlock as move_to_close_lru() waits for sc_count to
drop to 2, and some threads holding a reference might be waiting for either
mutex.  These references will never be dropped so sc_count will never
reach 2.

There have been a couple of attempted fixes (see [1] and [2]), but both
were problematic for different reasons.

This patch attempts to break the impasse by simply not waiting for the
rp_mutex. If it's contended then we just have it return NFS4ERR_DELAY.
This will likely cause parallel opens by the same openowner to be even
slower on NFSv4.0, but it should break the deadlock.

One way to address the performance impact might be to allow the wait for
the mutex to time out after a period of time (30ms would be the same as
NFSD_DELEGRETURN_TIMEOUT). We'd need to add a mutex_lock_timeout
function in order for that to work.

Chuck also suggested that we may be able to utilize the svc_defer
mechanism instead of returning NFS4ERR_DELAY in this situation, but I'm
not quite sure how feasible that is.

[1]: https://lore.kernel.org/lkml/4dd1fe21e11344e5969bb112e954affb@jd.com/T/
[2]: https://lore.kernel.org/linux-nfs/170546328406.23031.11217818844350800811@noble.neil.brown.name/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index aee12adf0598..4b667eeb06c8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4658,13 +4658,16 @@ static void init_nfs4_replay(struct nfs4_replay *rp)
 	mutex_init(&rp->rp_mutex);
 }
 
-static void nfsd4_cstate_assign_replay(struct nfsd4_compound_state *cstate,
+static __be32 nfsd4_cstate_assign_replay(struct nfsd4_compound_state *cstate,
 		struct nfs4_stateowner *so)
 {
 	if (!nfsd4_has_session(cstate)) {
-		mutex_lock(&so->so_replay.rp_mutex);
+		WARN_ON_ONCE(cstate->replay_owner);
+		if (!mutex_trylock(&so->so_replay.rp_mutex))
+			return nfserr_jukebox;
 		cstate->replay_owner = nfs4_get_stateowner(so);
 	}
+	return nfs_ok;
 }
 
 void nfsd4_cstate_clear_replay(struct nfsd4_compound_state *cstate)
@@ -5332,15 +5335,17 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 	strhashval = ownerstr_hashval(&open->op_owner);
 	oo = find_openstateowner_str(strhashval, open, clp);
 	open->op_openowner = oo;
-	if (!oo) {
+	if (!oo)
 		goto new_owner;
-	}
 	if (!(oo->oo_flags & NFS4_OO_CONFIRMED)) {
 		/* Replace unconfirmed owners without checking for replay. */
 		release_openowner(oo);
 		open->op_openowner = NULL;
 		goto new_owner;
 	}
+	status = nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
+	if (status)
+		return status;
 	status = nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid);
 	if (status)
 		return status;
@@ -5350,6 +5355,9 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 	if (oo == NULL)
 		return nfserr_jukebox;
 	open->op_openowner = oo;
+	status = nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
+	if (status)
+		return status;
 alloc_stateid:
 	open->op_stp = nfs4_alloc_open_stateid(clp);
 	if (!open->op_stp)
@@ -6121,12 +6129,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 void nfsd4_cleanup_open_state(struct nfsd4_compound_state *cstate,
 			      struct nfsd4_open *open)
 {
-	if (open->op_openowner) {
-		struct nfs4_stateowner *so = &open->op_openowner->oo_owner;
-
-		nfsd4_cstate_assign_replay(cstate, so);
-		nfs4_put_stateowner(so);
-	}
+	if (open->op_openowner)
+		nfs4_put_stateowner(&open->op_openowner->oo_owner);
 	if (open->op_file)
 		kmem_cache_free(file_slab, open->op_file);
 	if (open->op_stp)
@@ -7193,9 +7197,9 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
 	if (status)
 		return status;
 	stp = openlockstateid(s);
-	nfsd4_cstate_assign_replay(cstate, stp->st_stateowner);
-
-	status = nfs4_seqid_op_checks(cstate, stateid, seqid, stp);
+	status = nfsd4_cstate_assign_replay(cstate, stp->st_stateowner);
+	if (!status)
+		status = nfs4_seqid_op_checks(cstate, stateid, seqid, stp);
 	if (!status)
 		*stpp = stp;
 	else

---
base-commit: 2eb3d14898b97bdc0596d184cbf829b5a81cd639
change-id: 20240229-rp_mutex-d20e3319e315

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


