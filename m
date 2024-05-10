Return-Path: <linux-nfs+bounces-3237-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6958C2A53
	for <lists+linux-nfs@lfdr.de>; Fri, 10 May 2024 21:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BA70B20D31
	for <lists+linux-nfs@lfdr.de>; Fri, 10 May 2024 19:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE7E3CF4F;
	Fri, 10 May 2024 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVGp0uJS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5095DD2EE
	for <linux-nfs@vger.kernel.org>; Fri, 10 May 2024 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368067; cv=none; b=WhXUGNpbGByUdei2xi36uP845Vctp7lUFCsTMll8/P76NXYqiqpk/jRsgWq4u2tz4ajmpzjUPlhiNzLfmcanRCzJMs7Fy/QEdk6Fg5wbJkHrDihkSAnA4N+ox6etBScS0dBN5xbaKVvduKmSlNTr/wrmo3fc+hpsVvamXTVCCkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368067; c=relaxed/simple;
	bh=Idz9EUcNrTcrA6v684C1hNp0fQs4IBQZ04F0J7jWBY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NvlDA+0jnzd2+RcJDbse8ZwLu+fQK7f4AND9FQnVSgG67tNXhw1stWZrD1niEyGhfsIEiRy/rLi7YaCEEo/MjwL9DmDtABwkuRsc9oAG80CFrFeMERjqjM+zT1TOXICVMIJjBK8AHKjgclPHoHSI4jrneVH1e/CKIH3RRssV4aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVGp0uJS; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36c2cf463e3so2186935ab.3
        for <linux-nfs@vger.kernel.org>; Fri, 10 May 2024 12:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715368065; x=1715972865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ngWqr8yPsOSWM8fdf9DC2QY45XW0u3YC32ZOQwSNZc=;
        b=bVGp0uJSNl/uy/6YVnQwAElZxJd79IfyxEEE7P7HnzXQIe/vyITUnRNr7HV282gZSm
         OwN2Rk+yRByU7nTwXJHlOznCEau6o3HOnKyWqpFGZZDUEb9WlFuQZIQ8Jb7QSZfqvvhG
         Ko5aQs+HAenaZSe7nGqqyyOjz5CForLhULMg0tjN3RJn6wABp4jc8/kIACQXYZhPPY/K
         w/t/zGD6YqchRm6E9axnRrg6gQHNgfh2xnsDgxK6+x6uFsxsW3GPwzT0UmqomQhGEBZd
         fY5ZsA9/0WaOtxAo0J5eWiNuC3+ZUOlYkEzUFW361vECNnY9IY71ggIFeD1Ow4QPY/2t
         Jmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715368065; x=1715972865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ngWqr8yPsOSWM8fdf9DC2QY45XW0u3YC32ZOQwSNZc=;
        b=grXRE6kYKXavZtyA5lthVh8O1iqDqjnMzAzb/CnSA+HjFBrIhSZKLE88bT1wRKMJgJ
         /BMvfZlY4hcFN79M4/2lq4Tkg2gDft9cWA99ZYtOZKAr5Jrvf+UrtLMZZ2qzhrHiaYLf
         SRlRCTBCaA0MUkqrgCVTzmsudxYiS8/QzROfBVLGrrfxOq+1BAmHbQyJTfhREBkNaaOp
         9sbPHwBi21dOrqWhy4qJg8vgUWMKkwgjlhMCKm+4iT0oMR5umUYBgOQY70x5qJvZ+fpg
         DqCu38kgyKNb027UeuIkbH/ED8F09Z0u6oqme2iDjgNGwMG8z24IwmI0F6j/G7fTgvFm
         YQAQ==
X-Gm-Message-State: AOJu0Yx9oB7Z3Dl1cCIf5XpvxihzsbP/lNgRROSDq6qeCho5hhBCGeVp
	/Yt4HKzJIhqt2H7kZFV+J2KF6me7uAyTp2R9qmjtbSRdWihe1mju
X-Google-Smtp-Source: AGHT+IEsNvXENQe9Qf9JequohHWqNRneLkGCLcEYw59qtG3pfZizXtxhVxd3N+9sQxp++qQYrFMWrw==
X-Received: by 2002:a5e:8704:0:b0:7de:e495:42bf with SMTP id ca18e2360f4ac-7e1b51f3e6amr385837339f.1.1715368065352;
        Fri, 10 May 2024 12:07:45 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:fde6:20d6:f34d:66d3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489371410c6sm1097008173.64.2024.05.10.12.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:07:44 -0700 (PDT)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: trond.myklebust@hammerspace.com,
	anna.schumaker@netapp.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] pNFS: rework pnfs_generic_pg_check_layout to check IO range
Date: Fri, 10 May 2024 15:07:43 -0400
Message-Id: <20240510190743.52605-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

All callers of pnfs_generic_pg_check_layout() also want to do a call to
check that the layout's range covers the IO range. Merge the functionality
of the pnfs_generic_pg_check_range() into that of
pnfs_generic_pg_check_layout().

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/filelayout/filelayout.c         |  4 ++--
 fs/nfs/flexfilelayout/flexfilelayout.c | 12 ++---------
 fs/nfs/pnfs.c                          | 29 ++++++++------------------
 fs/nfs/pnfs.h                          |  3 +--
 4 files changed, 14 insertions(+), 34 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 85d2dc9bc212..29d84dc66ca3 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -867,7 +867,7 @@ static void
 filelayout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 			struct nfs_page *req)
 {
-	pnfs_generic_pg_check_layout(pgio);
+	pnfs_generic_pg_check_layout(pgio, req);
 	if (!pgio->pg_lseg) {
 		pgio->pg_lseg = fl_pnfs_update_layout(pgio->pg_inode,
 						      nfs_req_openctx(req),
@@ -891,7 +891,7 @@ static void
 filelayout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 			 struct nfs_page *req)
 {
-	pnfs_generic_pg_check_layout(pgio);
+	pnfs_generic_pg_check_layout(pgio, req);
 	if (!pgio->pg_lseg) {
 		pgio->pg_lseg = fl_pnfs_update_layout(pgio->pg_inode,
 						      nfs_req_openctx(req),
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 3e724cb7ef01..24188af56d5b 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -822,14 +822,6 @@ ff_layout_pg_get_read(struct nfs_pageio_descriptor *pgio,
 	}
 }
 
-static void
-ff_layout_pg_check_layout(struct nfs_pageio_descriptor *pgio,
-			  struct nfs_page *req)
-{
-	pnfs_generic_pg_check_layout(pgio);
-	pnfs_generic_pg_check_range(pgio, req);
-}
-
 static void
 ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 			struct nfs_page *req)
@@ -840,7 +832,7 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 	u32 ds_idx;
 
 retry:
-	ff_layout_pg_check_layout(pgio, req);
+	pnfs_generic_pg_check_layout(pgio, req);
 	/* Use full layout for now */
 	if (!pgio->pg_lseg) {
 		ff_layout_pg_get_read(pgio, req, false);
@@ -895,7 +887,7 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 	u32 i;
 
 retry:
-	ff_layout_pg_check_layout(pgio, req);
+	pnfs_generic_pg_check_layout(pgio, req);
 	if (!pgio->pg_lseg) {
 		pgio->pg_lseg =
 			pnfs_update_layout(pgio->pg_inode, nfs_req_openctx(req),
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index a5cc6199127f..b5834728f31b 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2705,38 +2705,28 @@ pnfs_layout_return_unused_byclid(struct nfs_client *clp,
 			&range);
 }
 
+/* Check if we have we have a valid layout but if there isn't an intersection
+ * between the request and the pgio->pg_lseg, put this pgio->pg_lseg away.
+ */
 void
-pnfs_generic_pg_check_layout(struct nfs_pageio_descriptor *pgio)
+pnfs_generic_pg_check_layout(struct nfs_pageio_descriptor *pgio,
+			     struct nfs_page *req)
 {
 	if (pgio->pg_lseg == NULL ||
-	    test_bit(NFS_LSEG_VALID, &pgio->pg_lseg->pls_flags))
+	    (test_bit(NFS_LSEG_VALID, &pgio->pg_lseg->pls_flags) &&
+	    pnfs_lseg_request_intersecting(pgio->pg_lseg, req)))
 		return;
 	pnfs_put_lseg(pgio->pg_lseg);
 	pgio->pg_lseg = NULL;
 }
 EXPORT_SYMBOL_GPL(pnfs_generic_pg_check_layout);
 
-/*
- * Check for any intersection between the request and the pgio->pg_lseg,
- * and if none, put this pgio->pg_lseg away.
- */
-void
-pnfs_generic_pg_check_range(struct nfs_pageio_descriptor *pgio, struct nfs_page *req)
-{
-	if (pgio->pg_lseg && !pnfs_lseg_request_intersecting(pgio->pg_lseg, req)) {
-		pnfs_put_lseg(pgio->pg_lseg);
-		pgio->pg_lseg = NULL;
-	}
-}
-EXPORT_SYMBOL_GPL(pnfs_generic_pg_check_range);
-
 void
 pnfs_generic_pg_init_read(struct nfs_pageio_descriptor *pgio, struct nfs_page *req)
 {
 	u64 rd_size;
 
-	pnfs_generic_pg_check_layout(pgio);
-	pnfs_generic_pg_check_range(pgio, req);
+	pnfs_generic_pg_check_layout(pgio, req);
 	if (pgio->pg_lseg == NULL) {
 		if (pgio->pg_dreq == NULL)
 			rd_size = i_size_read(pgio->pg_inode) - req_offset(req);
@@ -2766,8 +2756,7 @@ void
 pnfs_generic_pg_init_write(struct nfs_pageio_descriptor *pgio,
 			   struct nfs_page *req, u64 wb_size)
 {
-	pnfs_generic_pg_check_layout(pgio);
-	pnfs_generic_pg_check_range(pgio, req);
+	pnfs_generic_pg_check_layout(pgio, req);
 	if (pgio->pg_lseg == NULL) {
 		pgio->pg_lseg =
 			pnfs_update_layout(pgio->pg_inode, nfs_req_openctx(req),
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index db57a85500ee..fa5beeaaf5da 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -257,8 +257,7 @@ void pnfs_put_lseg(struct pnfs_layout_segment *lseg);
 
 void set_pnfs_layoutdriver(struct nfs_server *, const struct nfs_fh *, struct nfs_fsinfo *);
 void unset_pnfs_layoutdriver(struct nfs_server *);
-void pnfs_generic_pg_check_layout(struct nfs_pageio_descriptor *pgio);
-void pnfs_generic_pg_check_range(struct nfs_pageio_descriptor *pgio, struct nfs_page *req);
+void pnfs_generic_pg_check_layout(struct nfs_pageio_descriptor *pgio, struct nfs_page *req);
 void pnfs_generic_pg_init_read(struct nfs_pageio_descriptor *, struct nfs_page *);
 int pnfs_generic_pg_readpages(struct nfs_pageio_descriptor *desc);
 void pnfs_generic_pg_init_write(struct nfs_pageio_descriptor *pgio,
-- 
2.39.1


