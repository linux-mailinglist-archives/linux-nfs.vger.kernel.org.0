Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC3EE12EBAA
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2020 23:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgABWJ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Jan 2020 17:09:59 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45512 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgABWJ7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Jan 2020 17:09:59 -0500
Received: by mail-yb1-f193.google.com with SMTP id y67so8248424yba.12
        for <linux-nfs@vger.kernel.org>; Thu, 02 Jan 2020 14:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rWf4fk1jVxeEBXQG/lJHz/ZyAUspHCQxaV1/N8RU+To=;
        b=Thcz8U7Ifi6SVkRe0BHXZQewfcdMknwnuwcSKN9rJG7AQmJ78ApaJCoqcejmku6Ibl
         3feors4e83u0uyQccAlYPR/i3atuOxPU/ApCQoxuEEvIjQw+JX1ZAgf8VEMsw+k4vLwu
         cML2pqe0rSzMoR/1+6qxZPD6GdoqzIM+MT8IcjHW3u+awEIq/ssCl6tgV3bN3uu4U9Nu
         zqUWlbo1yx9+7Qtx7GBq0bsSHK0JervushpfjIafFXcqruE4SxyN5IcFIT7xTIZdqpgV
         bIfkRkTctrPT2HO80pkBnvFRLRUjQ5be73mcSN6PNWnSUwBUhUfUF3XIiO8BPjzoJHdp
         LdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rWf4fk1jVxeEBXQG/lJHz/ZyAUspHCQxaV1/N8RU+To=;
        b=unxfhgsOuAoWlQjthNKQ6x3TSK9de4DNSUcA2oX80ZrIxGggSNmmGsqzq0RugCxnQn
         X/9/gV5ks+6duOECFTiXGpqnnNC7SpAC18NaxezBgQLONS1n+E6DNqSg1r+istWLON1H
         nW9jXAoe5d58f+nGuDe5Lztba5Ra08VcYX3XEzlvQiQ/mFBEf+HXOSyF90p+L5oGsTOU
         N8HVjP0ySY/OV74esBzy2Z79vHx9WlkM1ypS2bUTMq7w5aEeXgTMDhaAHFEH8uVYRc/l
         Y6vqaqNIa1OmtiwhwT9hL2wqzdfFguJdk/otUlzgYjvnrDJRG2JrQXcRylWACW2TilPY
         5y/A==
X-Gm-Message-State: APjAAAUMD6bLiy9ivAWyZRRFM3bLsfRtQXcbCNLkOKHkKpobZ7th243o
        KJ7fVO68iOvVRMsMdFiPxDw=
X-Google-Smtp-Source: APXvYqyq+xV4Rxd1FVhKTAfxa4xMvoRZDkUpV2Nm4UgXOchYDlfySAcmdJVAGu4CoDWD2cD6KZvJyA==
X-Received: by 2002:a25:768b:: with SMTP id r133mr60964084ybc.262.1578002998163;
        Thu, 02 Jan 2020 14:09:58 -0800 (PST)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id t142sm23177745ywf.53.2020.01.02.14.09.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 02 Jan 2020 14:09:57 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSv4 fix acl retrieval over krb5i/krb5p mounts
Date:   Thu,  2 Jan 2020 17:09:54 -0500
Message-Id: <20200102220954.11763-1-olga.kornievskaia@gmail.com>
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

v2: needs +1 page.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 76d3716..543e81b 100644
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
+	npages = DIV_ROUND_UP(buflen, PAGE_SIZE) + 1;
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

