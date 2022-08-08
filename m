Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B30E58C9CC
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Aug 2022 15:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243012AbiHHNxK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Aug 2022 09:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbiHHNxJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Aug 2022 09:53:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65CF2DF7
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 06:53:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 757E660B59
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 13:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0F5C433D6
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 13:53:07 +0000 (UTC)
Subject: [PATCH v3 6/7] NFSD: Make nfsd4_setattr() wait before returning
 NFS4ERR_DELAY
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 08 Aug 2022 09:53:06 -0400
Message-ID: <165996678693.2637.18109478792874390277.stgit@manet.1015granger.net>
In-Reply-To: <165996657035.2637.4745479232455341597.stgit@manet.1015granger.net>
References: <165996657035.2637.4745479232455341597.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd_setattr() can kick off a CB_RECALL (via
notify_change() -> break_lease()) if a delegation is present. Before
returning NFS4ERR_DELAY, give the client holding that delegation a
chance to return it and then retry the nfsd_setattr() again, once.

Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=354
Tested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 14f07d3d6c48..5b18a71f1043 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1142,7 +1142,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 {
 	struct nfsd4_setattr *setattr = &u->setattr;
 	__be32 status = nfs_ok;
-	int err;
+	int err, retries;
 
 	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
 		status = nfs4_preprocess_stateid_op(rqstp, cstate,
@@ -1173,8 +1173,21 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				&setattr->sa_label);
 	if (status)
 		goto out;
-	status = nfsd_setattr(rqstp, &cstate->current_fh, &setattr->sa_iattr,
-				0, (time64_t)0);
+
+	retries = 1;
+	do {
+		status = nfsd_setattr(rqstp, &cstate->current_fh,
+				      &setattr->sa_iattr, 0, (time64_t)0);
+		if (status != nfserr_jukebox)
+			break;
+		if (!retries--)
+			break;
+		if (!nfsd4_wait_for_delegreturn(rqstp, &cstate->current_fh))
+			break;
+
+		fh_clear_pre_post_attrs(&cstate->current_fh);
+	} while (1);
+
 out:
 	fh_drop_write(&cstate->current_fh);
 	return status;


