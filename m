Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F383482C65
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Jan 2022 18:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiABRfo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Jan 2022 12:35:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55460 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiABRfo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Jan 2022 12:35:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E06C260DFA
        for <linux-nfs@vger.kernel.org>; Sun,  2 Jan 2022 17:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E18C36AEB;
        Sun,  2 Jan 2022 17:35:43 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@kernel.org
Subject: [PATCH 05/10] NFSD: De-duplicate net_generic(nf->nf_net, nfsd_net_id)
Date:   Sun,  2 Jan 2022 12:35:42 -0500
Message-Id:  <164114494203.7344.12014047636933166371.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164114486506.7344.16096063573748374893.stgit@bazille.1015granger.net>
References:  <164114486506.7344.16096063573748374893.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1739; h=from:subject:message-id; bh=ShtcDRBKl8FeXeqtZoEO54xcdk1v/9DgeJ6iwUdqEBA=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh0eJu+RS0HqnSqFq9Ff3KKT3F9QoVRUQv5F2T9hhl Hqo50TmJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYdHibgAKCRAzarMzb2Z/l3AtD/ 0ZzeB4k3EUl2ozNgxrYhOuWO7WBxkNAKThanBD6MEecRPLIuAXR/8nx96JX9/uH2UnF9Pw7mtoXMIl U1yFGqnobTAy08qYtKsmW59BqtlNiSFnI9BRkUiBJj7HdSs5AbEtuHJ5P2a+lshdCruV0j/7fkAvRq L9REDH8nTfNkx12UUFh1sgKwdlZpg+tdcPa6pernQvxg3OAa4hUi4QWdS7XsymFU98LFx20HoBjm/9 zeW16tvAo0tkj68WiCTP7g9WKQe+Q8qTiyyxc48j7x1swbZb+AKCRgM60adcfbr4LWZuvLr2uKGPFk 24dz204KDL3fKvYzTa1B0TDiushcFbeVRAqa0M3c4u5kx3UJYiW5pwW1Nc5yS5WSi26QQv3BIeYy+Y pg8lpZamCBlAyTXrd+W9NFWnZnGEwXW4l6fEr+cFPQQoP6+Z26YFVeE0kiDhW3VXJFAyUy3fpbNGCa 055u3wsJqSFR9xrwuw6lP9N5v2zmDJdBd1YfgzWjZObXjbsOpl2NjaIcXuY4+AD8x8v/eTFO8lO4+S Qj8Xi3OE/MB8t3fSb+RNAEbPZ+ayqj9HCg8ZzG7GUSxRqNkbOZEMBJLCAG/7U/2p17HutqzYP/6X5A AUucFLCYFfAJ7vhOfQ2k81xJS0/GGokOBkWrn9MfGSTll3S1WJydaCUtgJFQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since this pointer is used repeatedly, move it to a stack variable.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2e473d2f47e5..c22511decc4c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1103,6 +1103,7 @@ __be32
 nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
                loff_t offset, unsigned long count, __be32 *verf)
 {
+	struct nfsd_net		*nn;
 	struct nfsd_file	*nf;
 	loff_t			end = LLONG_MAX;
 	__be32			err = nfserr_inval;
@@ -1119,6 +1120,7 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			NFSD_MAY_WRITE|NFSD_MAY_NOT_BREAK_LEASE, &nf);
 	if (err)
 		goto out;
+	nn = net_generic(nf->nf_net, nfsd_net_id);
 	if (EX_ISSYNC(fhp->fh_export)) {
 		errseq_t since = READ_ONCE(nf->nf_file->f_wb_err);
 		int err2;
@@ -1126,8 +1128,7 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		err2 = vfs_fsync_range(nf->nf_file, offset, end, 0);
 		switch (err2) {
 		case 0:
-			nfsd_copy_boot_verifier(verf, net_generic(nf->nf_net,
-						nfsd_net_id));
+			nfsd_copy_boot_verifier(verf, nn);
 			err2 = filemap_check_wb_err(nf->nf_file->f_mapping,
 						    since);
 			break;
@@ -1135,13 +1136,11 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			err = nfserr_notsupp;
 			break;
 		default:
-			nfsd_reset_boot_verifier(net_generic(nf->nf_net,
-						 nfsd_net_id));
+			nfsd_reset_boot_verifier(nn);
 		}
 		err = nfserrno(err2);
 	} else
-		nfsd_copy_boot_verifier(verf, net_generic(nf->nf_net,
-					nfsd_net_id));
+		nfsd_copy_boot_verifier(verf, nn);
 
 	nfsd_file_put(nf);
 out:

