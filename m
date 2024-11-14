Return-Path: <linux-nfs+bounces-7958-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1779C819A
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 05:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB29F2845A5
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 04:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA091E764D;
	Thu, 14 Nov 2024 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeL2zmlh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969DA1E909D
	for <linux-nfs@vger.kernel.org>; Thu, 14 Nov 2024 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556803; cv=none; b=ntVnPeZm+2LbngEJPLBJhXBip1PTdn6nsJ5gkjXuQg4tGoSx4fu26ey/7a1rHfeg3H9DjmdZP5o+v2jVjVC6Jk/T+Q/+xlMoJdZbK8gc81EbkqpuWu+dca8wTHaiN4/VW+9jdYnetKXC2ixuceJ/C6XmNZR9UysPeF2AemvgOo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556803; c=relaxed/simple;
	bh=aLEZ2ZQJfuSiphNZJzZeGdxPt5oB5U2q09rbIDQg5w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U58GfV5ohNI8QkTexyWdixlliO+7G+O2IpHWYZ41TLAatr/XYnNYbtPbUoZC4x5gJ+k1PbRQZggdwrRyznHIwZXLe3f0TS/dCXYbfpJWSHfhLHCmryR5WYXJL8DBstlVNLM7QvJ6CX2KxTCnvqkp++BC4GuNF0leYlMpp7nwvJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeL2zmlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D735AC4CED0;
	Thu, 14 Nov 2024 04:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731556803;
	bh=aLEZ2ZQJfuSiphNZJzZeGdxPt5oB5U2q09rbIDQg5w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MeL2zmlh/q8j9CJ9n6ia/bCEcvmJWt0Yipdgi/KCbo+YIO/JwCSesMckWf/McyWZ1
	 Ddg4ZiRp5PQKBoydg2X+10+pCrdAMCSIfqHL5cTnMaFRcor9lLsi/nLyuibA5Mri3O
	 klDsQnZhQZHBCfK3MYGgZejdMATKfoOWH8/BaFdlRVQtOPs+34NwH/g01lHh2fSvOe
	 4VIfzSR5+qKh2QgmYRx1otKTJVonfIFXQ6BzWrT+h5RcY+Vz2dnULWF4lXrs2V9QV5
	 PNSioa1kNpYnwybO42ueqB8pd1XaVwk+08AutY9Y6MkzHMUTKQZ5qlHEOFT1efeXwJ
	 2DVWzUe2AgSPg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH v2 07/15] nfsd: update percpu_ref to manage references on nfsd_net
Date: Wed, 13 Nov 2024 22:59:44 -0500
Message-ID: <20241114035952.13889-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241114035952.13889-1-snitzer@kernel.org>
References: <20241114035952.13889-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Holding a reference on nfsd_net is what is required, it was never
actually about ensuring nn->nfsd_serv available.

Move waiting for outstanding percpu references from
nfsd_destroy_serv() to nfsd_shutdown_net().

By moving it later it will be possible to invalidate localio clients
during nfsd_file_cache_shutdown_net() via __nfsd_file_cache_purge().

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/nfssvc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 49e2f32102ab5..6ca5540424266 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -436,6 +436,10 @@ static void nfsd_shutdown_net(struct net *net)
 
 	if (!nn->nfsd_net_up)
 		return;
+
+	percpu_ref_kill_and_confirm(&nn->nfsd_serv_ref, nfsd_serv_done);
+	wait_for_completion(&nn->nfsd_serv_confirm_done);
+
 	nfsd_export_flush(net);
 	nfs4_state_shutdown_net(net);
 	nfsd_reply_cache_shutdown(nn);
@@ -444,7 +448,10 @@ static void nfsd_shutdown_net(struct net *net)
 		lockd_down(net);
 		nn->lockd_up = false;
 	}
+
+	wait_for_completion(&nn->nfsd_serv_free_done);
 	percpu_ref_exit(&nn->nfsd_serv_ref);
+
 	nn->nfsd_net_up = false;
 	nfsd_shutdown_generic();
 }
@@ -526,11 +533,6 @@ void nfsd_destroy_serv(struct net *net)
 
 	lockdep_assert_held(&nfsd_mutex);
 
-	percpu_ref_kill_and_confirm(&nn->nfsd_serv_ref, nfsd_serv_done);
-	wait_for_completion(&nn->nfsd_serv_confirm_done);
-	wait_for_completion(&nn->nfsd_serv_free_done);
-	/* percpu_ref_exit is called in nfsd_shutdown_net */
-
 	spin_lock(&nfsd_notifier_lock);
 	nn->nfsd_serv = NULL;
 	spin_unlock(&nfsd_notifier_lock);
-- 
2.44.0


