Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05819482C64
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Jan 2022 18:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiABRfj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Jan 2022 12:35:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55418 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiABRfh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Jan 2022 12:35:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60A8160DFA
        for <linux-nfs@vger.kernel.org>; Sun,  2 Jan 2022 17:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C01AC36AE7;
        Sun,  2 Jan 2022 17:35:36 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@kernel.org
Subject: [PATCH 04/10] NFSD: De-duplicate net_generic(SVC_NET(rqstp), nfsd_net_id)
Date:   Sun,  2 Jan 2022 12:35:35 -0500
Message-Id:  <164114493550.7344.5237073787095407875.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164114486506.7344.16096063573748374893.stgit@bazille.1015granger.net>
References:  <164114486506.7344.16096063573748374893.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608; h=from:subject:message-id; bh=lWDSDxoEGHYRkWq/xAEWykttlyoIVyK7Eorrovr3zxo=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh0eJnzI4d8AcJ9pPhAldd37s4wTDCwgx+JwHtU/f+ Xj3tPzGJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYdHiZwAKCRAzarMzb2Z/lxmUD/ 9YMSyXiAwQO7gAhS9fk3QP31Z8p4L7l7Q2vhi0/oMF/+NsdO5/hNr9oMYpTmu4UxIE+GQuBjYorgGn FByWzQn6Cocm/qrxcUIhLCFd3HA4kCXzSo/D7ZGcB3iGKOw+LcLE09uzSx5iFNMd+6I47e63LBFg6y ZzkWv2fvW20C+n6N4c2Xg2iYS+gJKuTMsO2H3SnuD4luOCFoaZ/sa1yHIw9fEruufZob7Jby1yauni Y/EidCRof/wzdgov5FA2+HXioIlZahv6T/DksuNTSmQJxLAJGsJGVXo/OgacobrNaWFk1ee15Y9tJV zRuf4rRZ91RNUIv59Q32WBrn9aiprQ2kj7QBkLcGNt+7npKxnN5AY8gtp9UxeLQfZ6ambhnrKoCLG4 sMfzRGpCNmA2v3bxuRvKEjV44HqN90CYTHv2dUmLq35lfVghxyiHW3A4U+ssS/qtsYdKXmpA1wxbw4 zAAXBqp2OyxnrgFyFzJaqR3iiNgy6EbNmzEFGQtfpMy+ReC0a//FEe0FyGVPEbjJ8S4EmtfbzXtc92 kfDlVQtvRpG77wCQ38bfuOZkwptl1rVLY1cWvnZ39cMcjSGTacCJWtFAoZGNbc8PnXssG5cTxlfXq5 wKiwJZEz5IryppTgEmwIwxsakyMHABzX3fHU2MVloOiIZeaE1KCZwBV7KCoA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since this pointer is used repeatedly, move it to a stack variable.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 8f0ac710fd1a..2e473d2f47e5 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -954,6 +954,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 				unsigned long *cnt, int stable,
 				__be32 *verf)
 {
+	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct file		*file = nf->nf_file;
 	struct super_block	*sb = file_inode(file)->i_sb;
 	struct svc_export	*exp;
@@ -998,13 +999,10 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	iov_iter_kvec(&iter, WRITE, vec, vlen, *cnt);
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
-		nfsd_copy_boot_verifier(verf,
-				net_generic(SVC_NET(rqstp),
-				nfsd_net_id));
+		nfsd_copy_boot_verifier(verf, nn);
 	host_err = vfs_iter_write(file, &iter, &pos, flags);
 	if (host_err < 0) {
-		nfsd_reset_boot_verifier(net_generic(SVC_NET(rqstp),
-					 nfsd_net_id));
+		nfsd_reset_boot_verifier(nn);
 		goto out_nfserr;
 	}
 	*cnt = host_err;
@@ -1017,8 +1015,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	if (stable && use_wgather) {
 		host_err = wait_for_concurrent_writes(file);
 		if (host_err < 0)
-			nfsd_reset_boot_verifier(net_generic(SVC_NET(rqstp),
-						 nfsd_net_id));
+			nfsd_reset_boot_verifier(nn);
 	}
 
 out_nfserr:

