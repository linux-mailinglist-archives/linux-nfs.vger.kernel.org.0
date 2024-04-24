Return-Path: <linux-nfs+bounces-2971-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A938AFD44
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 02:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603011C219DD
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 00:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9902D800;
	Wed, 24 Apr 2024 00:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAvrWj+d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7497D7EF
	for <linux-nfs@vger.kernel.org>; Wed, 24 Apr 2024 00:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713918003; cv=none; b=reLVL54BrrEXeTcXPgz8IE6WzKCyRU9UteyjfbARS1cSy+tJUQ90Y+rzXmVV3ho0ZwnKUj/9/TYFp0hZjQNnI1DbndEmOzPdLpLg/W/TNoleoU95lpCptFC9NeB5buIg7qkMi/8R43znW23/m5GiaINO46SuqppIPRQez5VPIEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713918003; c=relaxed/simple;
	bh=KnRYrWXlVBWfQWyKXqm5lpx4+zHTJxEgtvHtVVFYoDU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBo8GamGMKrF5L/60ISrt6PHZgRmUgPStY8Qj9FM2XRyy8SgpPA9zXMKRq6g8RTqh44UzkPMVebRNR9BLw9XakieR3aQRFSa4CfAuqrQ/B3YTNg+LXUida54woET63ALe9+jrfluaayAUuEkYbFYhyr8F0+H2Nht7Fi+2okCPgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAvrWj+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B516FC116B1;
	Wed, 24 Apr 2024 00:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713918003;
	bh=KnRYrWXlVBWfQWyKXqm5lpx4+zHTJxEgtvHtVVFYoDU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MAvrWj+d0a5bWmDeQ8fpfvfFKa8m2DehQV+4LfnhLnlFxPy52zdf/YgBF9mZri7Oc
	 Dp8WxFwRlghkgH122Xlome7aC2rF1MmxGwZ2nG2EjlgvDnx6rHRalV0EmJz2n4JrBi
	 RdjR+DS01pO+XAkioCDHryPk9bF76alqtFUG97wVvqzXC/yAqpeNWTp6ZXCx1z0TYk
	 6fZJlf5ZFUuvIn1F1sykv14RCS7GLwZ7v49oD+jd33Kvpm/6lAFMV8twX2cPt9cOgT
	 IvpgjcEpEPhYt5/yu9uUwpyLHPP9u+kMHjnR3bk+S51mb3spIy8JKA7St/BmibXd2a
	 9vp+1NZbq9l1Q==
Subject: [PATCH 1/2] Revert "NFSD: Reschedule CB operations when backchannel
 rpc_clnt is shut down"
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>
Date: Tue, 23 Apr 2024 20:20:01 -0400
Message-ID: 
 <171391800174.101038.3614787261244381619.stgit@klimt.1015granger.net>
In-Reply-To: 
 <171391782806.101038.14694256680827795210.stgit@klimt.1015granger.net>
References: 
 <171391782806.101038.14694256680827795210.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

The reverted commit attempted to enable NFSD to retransmit pending
callback operations if an NFS client disconnects, but
unintentionally introduces a hazardous behavior regression if the
client becomes permanently unreachable while callback operations are
still pending.

A disconnect can occur due to network partition or if the NFS server
needs to force the NFS client to retransmit (for example, if a GSS
window under-run occurs).

Reverting the commit will make NFSD behave the same as it did in
v6.8 and before. Pending callback operations are permanently lost if
the client connection is terminated before the client receives them.

For some callback operations, this loss is not harmful.

However, for CB_RECALL, the loss means a delegation might be revoked
unnecessarily. For CB_OFFLOAD, pending COPY operations will never
complete unless the NFS client subsequently sends an OFFLOAD_STATUS
operation, which the Linux NFS client does not currently implement.

These issues still need to be addressed somehow.

Reported-by: Dai Ngo <dai.ngo@oracle.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218735
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |   20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index e440f72b9d4e..d153af81f406 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -986,14 +986,6 @@ static bool nfsd4_queue_cb(struct nfsd4_callback *cb)
 	return queue_delayed_work(callback_wq, &cb->cb_work, 0);
 }
 
-static void nfsd4_queue_cb_delayed(struct nfsd4_callback *cb,
-				   unsigned long msecs)
-{
-	trace_nfsd_cb_queue(cb->cb_clp, cb);
-	queue_delayed_work(callback_wq, &cb->cb_work,
-			   msecs_to_jiffies(msecs));
-}
-
 static void nfsd41_cb_inflight_begin(struct nfs4_client *clp)
 {
 	atomic_inc(&clp->cl_cb_inflight);
@@ -1502,16 +1494,8 @@ nfsd4_run_cb_work(struct work_struct *work)
 
 	clnt = clp->cl_cb_client;
 	if (!clnt) {
-		if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags))
-			nfsd41_destroy_cb(cb);
-		else {
-			/*
-			 * XXX: Ideally, we could wait for the client to
-			 *	reconnect, but I haven't figured out how
-			 *	to do that yet.
-			 */
-			nfsd4_queue_cb_delayed(cb, 25);
-		}
+		/* Callback channel broken, or client killed; give up: */
+		nfsd41_destroy_cb(cb);
 		return;
 	}
 



