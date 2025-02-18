Return-Path: <linux-nfs+bounces-10171-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B300FA3A179
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 16:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D49188305A
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 15:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86BC26D5D8;
	Tue, 18 Feb 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb2jmZpB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C6A26D5CC
	for <linux-nfs@vger.kernel.org>; Tue, 18 Feb 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893183; cv=none; b=OSq9eohk6E5cYSqgORxtISSOmIrg5FLh6bWBntf9srqdu+LeBoRMnmNRaj3+74oihnsrc9aW7aqU8NOp1uJJYgCgcQZRgzGIsh16nPjv3R4KdhTWxG+mKUCS5NKmDHD3qnPGsuW5Y93L5CBIfkJEaCNk1BNGLc90B5z0/fi8lfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893183; c=relaxed/simple;
	bh=K0kbCsQ5aFEWuQlRov3HGKilBt63WoBIbVoqgj8bdvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqDOPgVOD/ZRsF1POvwZLDQbdZC4c8vicC2yvAp+EuI8c6um2eUTA68kDKf7zLRsEQFAUPuP546mWW3XouFBQPnddmFTKc3z3Pg6+V/CGlJHqrDnhTGs/W4wMsnVNzeh7HIfr6HzycA9QMNrer2TnTxFE9y9K1Ek9TDsjdKFHQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nb2jmZpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD60C4CEEA;
	Tue, 18 Feb 2025 15:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893183;
	bh=K0kbCsQ5aFEWuQlRov3HGKilBt63WoBIbVoqgj8bdvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nb2jmZpB1MQiw95CY370h2oIkFlmtm5MMFBfKcmr8P2jm0/cezwBP5/3ThZ+/VInd
	 6UN5lGO7F8U61uZO50rejbkUgB51vr3HcuedqrzHf96A1jbwB9g8QbNfp/n4nULnfD
	 xW7tDdUXPPypMqT0k56ZM4t2S0aiUKxd0mLQl6bQyRopi7A7MzhGaBt5sgOpaNevd2
	 fmsTK7PD2b9UEVXrfaNwMKgNjTnbtJF1Fw9dLZ2yfXFcwKDYzkDqF5dxD6rlBePtKJ
	 p97FSuaygrDHK/rW/ZdBy7+YVQEr/zlo9Yce7kYG6lf/ySdeE6yb3gGyOWz1BzA9vI
	 FuoiM0G/Euwyw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH v2 3/7] nfsd: filecache: use nfsd_file_dispose_list() in nfsd_file_close_inode_sync()
Date: Tue, 18 Feb 2025 10:39:33 -0500
Message-ID: <20250218153937.6125-4-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250218153937.6125-1-cel@kernel.org>
References: <20250218153937.6125-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

nfsd_file_close_inode_sync() contains an exact copy of
nfsd_file_dispose_list().

This patch removes that copy and calls nfsd_file_dispose_list()
instead.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2933cba1e5f4..143b5993a437 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -672,17 +672,12 @@ nfsd_file_close_inode(struct inode *inode)
 void
 nfsd_file_close_inode_sync(struct inode *inode)
 {
-	struct nfsd_file *nf;
 	LIST_HEAD(dispose);
 
 	trace_nfsd_file_close(inode);
 
 	nfsd_file_queue_for_close(inode, &dispose);
-	while (!list_empty(&dispose)) {
-		nf = list_first_entry(&dispose, struct nfsd_file, nf_gc);
-		list_del_init(&nf->nf_gc);
-		nfsd_file_free(nf);
-	}
+	nfsd_file_dispose_list(&dispose);
 }
 
 static int
-- 
2.47.0


