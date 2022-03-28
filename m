Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4794E992D
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Mar 2022 16:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242715AbiC1OSV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Mar 2022 10:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241390AbiC1OSU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Mar 2022 10:18:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C851329B7
        for <linux-nfs@vger.kernel.org>; Mon, 28 Mar 2022 07:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0336BB81120
        for <linux-nfs@vger.kernel.org>; Mon, 28 Mar 2022 14:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEEBC340EC
        for <linux-nfs@vger.kernel.org>; Mon, 28 Mar 2022 14:16:36 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSD: Prevent lock/unlock imbalance in do_nfsd_create()
Date:   Mon, 28 Mar 2022 10:16:35 -0400
Message-Id:  <164847698961.23692.1790666748697443088.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.35.0
User-Agent: StGit/1.5.dev1+g8516920
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; h=from:subject:message-id; bh=T18xumqUqcDTHTPi4BHNTmgztGMQot9JjnzoeNb6rtE=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBiQcM936FdIeggNg+cbwIULrdxwSyKorRFXDLAchHu OBE7NoGJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYkHDPQAKCRAzarMzb2Z/l5+0EA C02FNuN4Z5lBmdakO2MlsQcx8quHwNCLhRtHE6wgwcpi6RkcVPFQGIU3wHm/9CQQPhkfLhYOPTPw3+ 0qwV39dy0MxPp44MSyJ3HpaX0fE+lIzqWq/QER0nf7+f7E2ck0Pu+/pRn62bumf+J+7Eq2051B2bTI pzRZtXycsDG6/Zr6v8oeN6mSgnLsGjXcxp4cQS0OZ4PzVwgHoRrOM77zPp9mHY69WU39ILGwyHHvzB Gw+yOLndfWOdd/k5EncbZaJ2kHn02w+DKi8cLkk2Cq24o/uxUmugYocv5FBMGb0lMhsIddHjH4zcCd OmvgtI0k2+NYAD4+JHDvlIq8a/kS/HwvEZFVE9E/bYy0o9K83eheVqv0qn9S/5DwJWDnaN/+AVEtoS JrTnxGqBYGuPARth63Gp6fiycLoVFr6zyvJegfET7KrJKwINUNKQFqd6V8hgprJt32o/XO6iw0myWV W/7jhdsjc3uztQo8C2vsdfgmkbZzdoM3TfPxDDNQSTDbSHq/xDnKfaXhuMuHvG6Wy7M6H1TMhuQuBn z6Qu6yiLcHqgXNkXgqPkpynMPrFsu/UwYDzj9PUPsqaLJf3le3JUAhvFEsuj7ZDXdBjeCtQwEP7Jtu x4iDv9Xtg3hWcOJb6Kuzh4jbuhu5kN4d2X09zMJ0ypVf9KkD6/+sxAuViXKA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The "out" label invokes fh_unlock() and fh_drop_write(). However, at
the top of do_nfsd_create(), we haven't yet invoked fh_want_write()
or fh_lock_nested().

The "!flen" check is unnecessary because lookup_one_common() already
does that check. See commit 12391d07230e ("nfsd: remove redundant
zero-length check from create")

Cc: <stable@vger.kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 166eb0ba3e71..f54da591a5bf 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1389,24 +1389,20 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	int		host_err;
 	__u32		v_mtime=0, v_atime=0;
 
-	err = nfserr_perm;
-	if (!flen)
-		goto out;
-	err = nfserr_exist;
 	if (isdotent(fname, flen))
-		goto out;
+		return nfserr_exist;
 	if (!(iap->ia_valid & ATTR_MODE))
 		iap->ia_mode = 0;
 	err = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_EXEC);
 	if (err)
-		goto out;
+		return err;
 
 	dentry = fhp->fh_dentry;
 	dirp = d_inode(dentry);
 
 	host_err = fh_want_write(fhp);
 	if (host_err)
-		goto out_nfserr;
+		return nfserrno(host_err);
 
 	fh_lock_nested(fhp, I_MUTEX_PARENT);
 

