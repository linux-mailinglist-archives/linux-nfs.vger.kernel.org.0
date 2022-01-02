Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10858482C63
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Jan 2022 18:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiABRfc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Jan 2022 12:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiABRfb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Jan 2022 12:35:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2A5C061761
        for <linux-nfs@vger.kernel.org>; Sun,  2 Jan 2022 09:35:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D435660F4A
        for <linux-nfs@vger.kernel.org>; Sun,  2 Jan 2022 17:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDC9C36AE7;
        Sun,  2 Jan 2022 17:35:30 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@kernel.org
Subject: [PATCH 03/10] NFSD: Clean up nfsd_vfs_write()
Date:   Sun,  2 Jan 2022 12:35:29 -0500
Message-Id:  <164114492897.7344.10040354999721400314.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164114486506.7344.16096063573748374893.stgit@bazille.1015granger.net>
References:  <164114486506.7344.16096063573748374893.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388; h=from:subject:message-id; bh=NBVC2eO5FqQKDoca52ydPEQ0qo+FwjzdPT3gSFMuH88=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh0eJhmsj+NxAECk41JR9W/GSMi8gMp/b5E0jjSP5p oa0MngqJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYdHiYQAKCRAzarMzb2Z/lyd+EA C7Eet4WWhnylYSDF5PwZIBvqQt0q5sL55FY8MqVLXw3QGSMcrhcw+YS6J+NboQi1zeyvApb7cM5xDq DdOkkFykzK3/w4xPwdHXOel8yjJP3mFshykOrIt1txfYfJ4NO9Dkm9I0OVuh+uWeUEvAkTzERtrNPm ZvQ9JFAhPHSoZ8T9kmj9MUjSXhzAx2uVdd1In0179o/dbo61qjN5wzusYwuxSojgH8W7ZP/gdPnlvN Mrtt1IxOriObPrIlAT265HE22t5bOIlYpqBzcS84srAHBalWir9LHuw/Jqwv7Vtyel6xuu16aB3aB1 m+jfyOF8a2rKF4B9qHMWXuhebZ2svLkeDNYUaX3Zv8uaP9QzhcTb3+wg8F/7+0SbXiVd3NPfL2SnUK XQ+uf/EBScyf+Z2e5GMFTIVxZzV9lh8IMvplMlFt9QahVYCl85a+KOgUpbkzmrktwSp3R8GCsGraie EBthD2heQFxlRZJIMbnNkgvAp7drtHB1/v5AoQxUHT9qRb0W+7iOjjbFFjslH/8Tn7LlVevMpjDOpv TzUcc10WhbND7I5fLYJnuRKurtxv6xDPHRS5mF6kGuqED92yp/Xh+NkYCIqYXTVgyy34iKhfJIOX28 C39Zo2RVlu1m/njG3AP/NGM315qigeAJGmjR6y5yPfHhMxsscC3TNPK4mY5A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The RWF_SYNC and !RWF_SYNC arms are now exactly alike except that
the RWF_SYNC arm resets the boot verifier twice in a row. Fix that
redundancy and de-duplicate the code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |   21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 316ed702d518..8f0ac710fd1a 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -997,22 +997,11 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 
 	iov_iter_kvec(&iter, WRITE, vec, vlen, *cnt);
 	since = READ_ONCE(file->f_wb_err);
-	if (flags & RWF_SYNC) {
-		if (verf)
-			nfsd_copy_boot_verifier(verf,
-					net_generic(SVC_NET(rqstp),
-					nfsd_net_id));
-		host_err = vfs_iter_write(file, &iter, &pos, flags);
-		if (host_err < 0)
-			nfsd_reset_boot_verifier(net_generic(SVC_NET(rqstp),
-						 nfsd_net_id));
-	} else {
-		if (verf)
-			nfsd_copy_boot_verifier(verf,
-					net_generic(SVC_NET(rqstp),
-					nfsd_net_id));
-		host_err = vfs_iter_write(file, &iter, &pos, flags);
-	}
+	if (verf)
+		nfsd_copy_boot_verifier(verf,
+				net_generic(SVC_NET(rqstp),
+				nfsd_net_id));
+	host_err = vfs_iter_write(file, &iter, &pos, flags);
 	if (host_err < 0) {
 		nfsd_reset_boot_verifier(net_generic(SVC_NET(rqstp),
 					 nfsd_net_id));

