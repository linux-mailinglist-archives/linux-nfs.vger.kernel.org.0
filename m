Return-Path: <linux-nfs+bounces-13141-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B6AB09925
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 03:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB6FA64DAC
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 01:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0722A188A0C;
	Fri, 18 Jul 2025 01:28:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C1117A2E1
	for <linux-nfs@vger.kernel.org>; Fri, 18 Jul 2025 01:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752802121; cv=none; b=Wno8bQW+S4Z1OwuOLECAl78ucVHePFg2HWfro+6q9GRAWs3s1nw5vafeOdC0+oTgK+DOF3UiDBcElAjvhz62G2PQAUKhb7puTKT4gCWRwEFz49j7o88Hor58ZPZifnAOsvN9Q3MduPAh+fm0UYzHJNSCzJm82PmHiXRbE9d93qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752802121; c=relaxed/simple;
	bh=rAXYFzdl23LV6+K3T8NDY8LtI7oI7HUB9lj9pe0dZgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6QGv2ry2z4gu6pE6pvBE9mYbLGQbvgGqstQamPsjAtwwYQgrAbfOtdiyvQwAwNSZpZFHQjNgED2cGj4PNz1p1TQp17ATnhtlIoIYTEu1U26rawgS8KoBGUxQ+6tFLhhWKkUfWIFR9wEHFQkFaraDnBUue0QotIdhhm2EBqmQ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ucZts-002QCL-T6;
	Fri, 18 Jul 2025 01:28:38 +0000
From: NeilBrown <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] nfsd: discard nfsd_file_get_local()
Date: Fri, 18 Jul 2025 11:26:15 +1000
Message-ID: <20250718012831.2187613-3-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250718012831.2187613-1-neil@brown.name>
References: <20250718012831.2187613-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This interface was deprecated by

Commit e6f7e1487ab5 ("nfs_localio: simplify interface to nfsd for getting nfsd_file")

and is now unused. So let's remove it.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/filecache.c        | 21 ---------------------
 fs/nfsd/filecache.h        |  1 -
 fs/nfsd/localio.c          |  1 -
 include/linux/nfslocalio.h |  1 -
 4 files changed, 24 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index e108b6c705b4..fed80d5d60e7 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -391,27 +391,6 @@ nfsd_file_put_local(struct nfsd_file __rcu **pnf)
 	return net;
 }
 
-/**
- * nfsd_file_get_local - get nfsd_file reference and reference to net
- * @nf: nfsd_file of which to put the reference
- *
- * Get reference to both the nfsd_file and nf->nf_net.
- */
-struct nfsd_file *
-nfsd_file_get_local(struct nfsd_file *nf)
-{
-	struct net *net = nf->nf_net;
-
-	if (nfsd_net_try_get(net)) {
-		nf = nfsd_file_get(nf);
-		if (!nf)
-			nfsd_net_put(net);
-	} else {
-		nf = NULL;
-	}
-	return nf;
-}
-
 /**
  * nfsd_file_file - get the backing file of an nfsd_file
  * @nf: nfsd_file of which to access the backing file.
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 722b26c71e45..24ddf60e8434 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -63,7 +63,6 @@ int nfsd_file_cache_start_net(struct net *net);
 void nfsd_file_cache_shutdown_net(struct net *net);
 void nfsd_file_put(struct nfsd_file *nf);
 struct net *nfsd_file_put_local(struct nfsd_file __rcu **nf);
-struct nfsd_file *nfsd_file_get_local(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 struct file *nfsd_file_file(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 519bbdedcb11..bcb2258f9309 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -122,7 +122,6 @@ static const struct nfsd_localio_operations nfsd_localio_ops = {
 	.nfsd_net_put  = nfsd_net_put,
 	.nfsd_open_local_fh = nfsd_open_local_fh,
 	.nfsd_file_put_local = nfsd_file_put_local,
-	.nfsd_file_get_local = nfsd_file_get_local,
 	.nfsd_file_file = nfsd_file_file,
 };
 
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 5c7c92659e73..59ea90bd136b 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -63,7 +63,6 @@ struct nfsd_localio_operations {
 						struct nfsd_file __rcu **pnf,
 						const fmode_t);
 	struct net *(*nfsd_file_put_local)(struct nfsd_file __rcu **);
-	struct nfsd_file *(*nfsd_file_get_local)(struct nfsd_file *);
 	struct file *(*nfsd_file_file)(struct nfsd_file *);
 } ____cacheline_aligned;
 
-- 
2.49.0


