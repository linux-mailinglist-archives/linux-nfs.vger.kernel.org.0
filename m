Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15EA38029F
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 05:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhENEAd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 00:00:33 -0400
Received: from mail.synology.com ([211.23.38.101]:35408 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229469AbhENEAc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 14 May 2021 00:00:32 -0400
Received: from localhost.localdomain (unknown [10.17.200.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id E3540249C33;
        Fri, 14 May 2021 11:59:20 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1620964760; bh=K7cdwnj/D7xJljx/DSyjsWJJz6s6FJtjEV6RF1pE/zo=;
        h=From:To:Cc:Subject:Date;
        b=EWbfy97JD84LsxKnUTyVbLHTN5MyjCC0NRTSmtBerI1pr7Di+JIbZaRKUyytSIVie
         jsGISseFr9jINty+NId+J421mxwYaLt6hOx8y5moN0otAptgUvFmzJRTOqj45nVJjt
         SXeb22B1Mj6qXSMGMacBF45JVhmRZvSeJ23JAB4I=
From:   Nick Huang <nickhuang@synology.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org,
        Yu Hsiang Huang <nickhuang@synology.com>,
        Bing Jing Chang <bingjingc@synology.com>,
        Robbie Ko <robbieko@synology.com>
Subject: [PATCH] nfsd: Prevent truncation of an unlinked inode from blocking access to its directory
Date:   Fri, 14 May 2021 11:58:29 +0800
Message-Id: <20210514035829.5230-1-nickhuang@synology.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Yu Hsiang Huang <nickhuang@synology.com>

Truncation of an unlinked inode may take a long time for I/O waiting, and
it doesn't have to prevent access to the directory. Thus, let truncation
occur outside the directory's mutex, just like do_unlinkat() does.

Signed-off-by: Yu Hsiang Huang <nickhuang@synology.com>
Signed-off-by: Bing Jing Chang <bingjingc@synology.com>
Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/nfsd/vfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 15adf1f6ab21..39948f130712 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1859,6 +1859,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 {
 	struct dentry	*dentry, *rdentry;
 	struct inode	*dirp;
+	struct inode	*rinode;
 	__be32		err;
 	int		host_err;
 
@@ -1887,6 +1888,8 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 		host_err = -ENOENT;
 		goto out_drop_write;
 	}
+	rinode = d_inode(rdentry);
+	ihold(rinode);
 
 	if (!type)
 		type = d_inode(rdentry)->i_mode & S_IFMT;
@@ -1902,6 +1905,8 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	if (!host_err)
 		host_err = commit_metadata(fhp);
 	dput(rdentry);
+	fh_unlock(fhp);
+	iput(rinode);    /* truncate the inode here */
 
 out_drop_write:
 	fh_drop_write(fhp);
-- 
2.25.1

