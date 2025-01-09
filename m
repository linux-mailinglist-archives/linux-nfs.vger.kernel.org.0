Return-Path: <linux-nfs+bounces-9017-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 244D4A07917
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 15:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3F13A1288
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 14:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ACD21A455;
	Thu,  9 Jan 2025 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBK9y5/x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612B221A44E
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432681; cv=none; b=TcDt3Qg4aaN4aZrP64J8s53S93Y866dMAYrAm9HJJpfQDQ40vFHo8O1Pmrn2WRXi5gu2gybKngAkeamE0fQTxePCarFj5RB4nNelhrWaY0m8MVjCts1g2AwxHPBySZnRHwg9ebup4AoCUGufTwK4Uu1p37f3buyAXR0sF5TSIio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432681; c=relaxed/simple;
	bh=IcfMc+NIRIpXO7LEmmMSS3mPx1hloPaIFnF0mLA70jY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NsZDVOqUaa/uewm5Pq47yRkiihbZX3jI+m/Tc9mQi6L+KfF76QP80iB4cyXrUYdP4VsVmvuEnKlGUURjL1WNHzMR/cTAPMFGvI2xBR7tMKez9yz4OIa/FhXJCVv/PlPphuwsRwkgNmko3fWZc8p3/FJzVT4UrFjmAC3Hg+6/PLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBK9y5/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428D2C4CED3;
	Thu,  9 Jan 2025 14:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736432680;
	bh=IcfMc+NIRIpXO7LEmmMSS3mPx1hloPaIFnF0mLA70jY=;
	h=From:To:Cc:Subject:Date:From;
	b=OBK9y5/xoyKlzd8Mo7lsFedMYKnLtzYZpJqIbAnLaOk+3wQ7L3hJwwOPKGkM61fnW
	 ZB8ea2JAvaK4Y/khPMf7JvBJktCmuZtmdgQh3P2rs61VxyJHMdicRaIbBb4pLYVqCy
	 RHfWgPAqdtOJf/nRDjCh0QasoSpDqUVXNyvrDnT03krCe4Wr78epDfoyrdXJB1tHvX
	 Of8mEqPJ/uJJVxj0LpS46/qP0RmXQPgUMwx3e4BcJSqQca2nmtDot8+QNpsi3FFF2B
	 Jk2IxZ5+ev9bydFinspRY6V5FSe6tEOU0zB5xDCBKc1yPLgMg3Sw45X5UvnQauNYna
	 9Dr9bx/ZPDxPw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH v1] nfsd: drop the lock during filecache LRU scans
Date: Thu,  9 Jan 2025 09:24:37 -0500
Message-ID: <20250109142438.18689-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

Under a high NFSv3 load with lots of different file being accessed,
the LRU list of garbage-collectable files can become quite long.

Asking list_lru_scan() to scan the whole list can result in a long
period during which a spinlock is held, blocking the addition and
removal of LRU items.

So ask list_lru_scan() to scan only a few entries at a time, and
repeat until the scan is complete.

Fixes: edead3a55804 ("NFSD: Fix the filecache LRU shrinker")
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 14 ++++++++++----
 fs/nfsd/filecache.h |  6 ++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

Updated version of Neil's patch to break up filecache LRU scans.
This can be backported to LTS kernels -- a Fixes tag has been
proposed.

Subsequent work can replace the list_lru mechanism. That would
be more substantial and thus more challenging to backport.

There are two concerns here:

 - The number of items in the LRU can now change while this loop is
   operating. We might need a "if (!ret) break;" or some other exit
   condition to prevent an infinite loop.

 - The list_lru_walk() always starts at the tail of the LRU, rather
   than picking up where it left off. So it might only visit the
   same handful of items on the list repeatedly, reintroducing the
   bug fixed by edead3a55804.


diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index a1cdba42c4fa..fcd751cb7c76 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -541,13 +541,19 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 static void
 nfsd_file_gc(void)
 {
+	unsigned long remaining = list_lru_count(&nfsd_file_lru);
 	LIST_HEAD(dispose);
 	unsigned long ret;
 
-	ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
-			    &dispose, list_lru_count(&nfsd_file_lru));
-	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
-	nfsd_file_dispose_list_delayed(&dispose);
+	while (remaining > 0) {
+		unsigned long num_to_scan = min(remaining, NFSD_FILE_GC_BATCH);
+
+		ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
+				    &dispose, num_to_scan);
+		trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
+		nfsd_file_dispose_list_delayed(&dispose);
+		remaining -= num_to_scan;
+	}
 }
 
 static void
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index d5db6b34ba30..463bd60b98b4 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -3,6 +3,12 @@
 
 #include <linux/fsnotify_backend.h>
 
+/*
+ * Limit the time that the list_lru_one lock is held during
+ * an LRU scan.
+ */
+#define NFSD_FILE_GC_BATCH	(32UL)
+
 /*
  * This is the fsnotify_mark container that nfsd attaches to the files that it
  * is holding open. Note that we have a separate refcount here aside from the
-- 
2.47.0


