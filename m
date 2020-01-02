Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1FB312EA8E
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2020 20:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgABThD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Jan 2020 14:37:03 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46738 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgABThD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Jan 2020 14:37:03 -0500
Received: by mail-yw1-f68.google.com with SMTP id u139so17619111ywf.13
        for <linux-nfs@vger.kernel.org>; Thu, 02 Jan 2020 11:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A9PUcgLn0FkoyMksrGzcqyGmTu3D2Stu9WLG5SdK6vQ=;
        b=FmxNHBkShb2s9VosZQG+OancIP2H+Winchmuun+7Z1iKv/Ae/U1uhpOCk7FR7paKiP
         h7/l87hP+CcLkKqogOpRAERovw+bro2Wmv+h737HWHmJdNO9EZCU7q3wN2+oaDVjyphM
         5rCnlI/gdYBL5k+3SVwEPW5F1eiIdJ6ph3FumLwp+QL94g7XOjueXNEug9k27ZmoxeDD
         nIWvcIQzZeuOc078Zx9uTUGxHuaS8Wuqi44eXeyTkjdn21HFw9JKREdokFhgRbrTjIIN
         jaeA5oPV/dJ4wk+6pHmGwuknnmRr2vfCwACmv/TEuiZqSkQ8GAJCkFrsXwcosPIkm0gp
         dslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A9PUcgLn0FkoyMksrGzcqyGmTu3D2Stu9WLG5SdK6vQ=;
        b=cTT2vHvjjEFIJUpcDf2+xZsq5kG+ETXNwbnXouNqrj8/K5k5i6uo/19khUW50yfpEI
         9t3+DoUzoXparJ5iukyQn15KVtysN23/KkeAGrdzTXpqANZD0EOR2w5FMLE8ZkEO4kCV
         N1DU7MeaVi1XvnDKXUYwAzia5nYkOtqUJExMrWgxjaF5MQQq3aB3nlZqVOzCZTo3kwj8
         72P+Ob2XZNOSXV50ZEyMDDHC6ETGXAJru1xyNuM2Twz2biE558MYkAngbkAvPgPNNtFA
         pSaJBz3cjrNzvrSl5M3LMrG+ToKcFEb2JOjK2JEN/f8entVBYfzTIjFzHGD+3umzTr5b
         X5xA==
X-Gm-Message-State: APjAAAWWwkbPPtJWn5acbpHjElv0oCsWJQomq3ZhDpBttDrsas8penY/
        rHZ3f0QXsmmyb9IeJef1a0g=
X-Google-Smtp-Source: APXvYqyxf/Mqxr+yBHF7KGsRouVvJM/aO3MzJ3KIcsLe7/OFjJ5Wi3iIrq+RUXbk8ggdIdvMS/6C9g==
X-Received: by 2002:a81:84c6:: with SMTP id u189mr63664482ywf.439.1577993821983;
        Thu, 02 Jan 2020 11:37:01 -0800 (PST)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id d134sm22601943ywe.39.2020.01.02.11.37.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 02 Jan 2020 11:37:01 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4 fix acl retrieval over krb5i/krb5p mounts
Date:   Thu,  2 Jan 2020 14:36:59 -0500
Message-Id: <20200102193659.11220-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

For the krb5i and krb5p mount, it was problematic to truncate the
received ACL to the provided buffer because an integrity check
could not be preformed.

Instead, provide enough pages to accommodate the largest buffer
bounded by the largest RPC receive buffer size.

Note: I don't think it's possible for the ACL to be truncated now.
Thus NFS4_ACL_TRUNC flag and related code could be possibly
removed but since I'm unsure, I'm leaving it.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 76d3716..19c3d54 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5582,10 +5582,9 @@ static void nfs4_write_cached_acl(struct inode *inode, struct page **pages, size
  */
 static ssize_t __nfs4_get_acl_uncached(struct inode *inode, void *buf, size_t buflen)
 {
-	struct page *pages[NFS4ACL_MAXPAGES + 1] = {NULL, };
+	struct page **pages;
 	struct nfs_getaclargs args = {
 		.fh = NFS_FH(inode),
-		.acl_pages = pages,
 		.acl_len = buflen,
 	};
 	struct nfs_getaclres res = {
@@ -5596,11 +5595,19 @@ static ssize_t __nfs4_get_acl_uncached(struct inode *inode, void *buf, size_t bu
 		.rpc_argp = &args,
 		.rpc_resp = &res,
 	};
-	unsigned int npages = DIV_ROUND_UP(buflen, PAGE_SIZE) + 1;
+	unsigned int npages;
 	int ret = -ENOMEM, i;
+	struct nfs_server *server = NFS_SERVER(inode);
 
-	if (npages > ARRAY_SIZE(pages))
-		return -ERANGE;
+	if (buflen == 0)
+		buflen = server->rsize;
+
+	npages = DIV_ROUND_UP(buflen, PAGE_SIZE);
+	pages = kmalloc_array(npages, sizeof(struct page *), GFP_NOFS);
+	if (!pages)
+		return -ENOMEM;
+
+	args.acl_pages = pages;
 
 	for (i = 0; i < npages; i++) {
 		pages[i] = alloc_page(GFP_KERNEL);
@@ -5646,6 +5653,7 @@ static ssize_t __nfs4_get_acl_uncached(struct inode *inode, void *buf, size_t bu
 			__free_page(pages[i]);
 	if (res.acl_scratch)
 		__free_page(res.acl_scratch);
+	kfree(pages);
 	return ret;
 }
 
-- 
1.8.3.1

