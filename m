Return-Path: <linux-nfs+bounces-8023-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC1B9CFC40
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 02:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449192880E5
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 01:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C322818FDAF;
	Sat, 16 Nov 2024 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBXcEjbY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E787161
	for <linux-nfs@vger.kernel.org>; Sat, 16 Nov 2024 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731721276; cv=none; b=B3H3VENAS7emfHUx7jXdrwd9O1aM1uNB7+uiqPSZHiGVHllH15uyKANv0GbhF1/024cfASo1eXoW5JJxP3r6TImp1Ou+hcS/p0jcK+aJq7uxA0NJylGnItMF+QjlGAcxS8TPxsRN92zoVX4vbA0ZaN9mtE/lKrRstKSLhc8odRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731721276; c=relaxed/simple;
	bh=aLEZ2ZQJfuSiphNZJzZeGdxPt5oB5U2q09rbIDQg5w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBGt+K9ujKkYXVKAKscJcb3nxXZgjQBbIbiXMn2bdMKeGlYz0Zgy+zIcs3xGab389ukU2DYDrmJuTazwXVapRStjCp9SvHLtzk/9YBTPxQ6a6z8gkDpq/MS1LZLdNnX7Dxe2dNIg24tI+1klFNDJYY1fPdzYl/Zb0gn2uKSvBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBXcEjbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10755C4CED5;
	Sat, 16 Nov 2024 01:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731721276;
	bh=aLEZ2ZQJfuSiphNZJzZeGdxPt5oB5U2q09rbIDQg5w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WBXcEjbYOaZNotkW56yQXQiYKNDOWoe09MLkNLHbbXZLWRSXPHX0WywnrIvPh8Hab
	 F6HAlHUV+WvXKXSDpOHBFh0gQ7pwFm3/sCy8Ov1QyeX8qHgk0njUkruiCQA8JU1xqJ
	 GJYdP0/hTzPvbONIN/Tyj6JMT5+UDse0OshwrUaJZ5brdaLIHzciGFUDB9qilnLUSI
	 SH3XDFxhsH4XHVXejbnHDO+uwhd+oAT+VBmejdOwWzTSj3RAA1cX1vupaCTHK75u7Y
	 875yW0Y7BprQcOQfwXrkHc1sveskoZ9qrjItt4G+oy2Bve7V1rCEez7aRzwqnc/xB/
	 viCJIxDHM5xPA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH v3 06/14] nfsd: update percpu_ref to manage references on nfsd_net
Date: Fri, 15 Nov 2024 20:40:58 -0500
Message-ID: <20241116014106.25456-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241116014106.25456-1-snitzer@kernel.org>
References: <20241116014106.25456-1-snitzer@kernel.org>
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


