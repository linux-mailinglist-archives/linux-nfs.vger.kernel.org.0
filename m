Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D83658C9CD
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Aug 2022 15:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243021AbiHHNxS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Aug 2022 09:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbiHHNxR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Aug 2022 09:53:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC082DF7
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 06:53:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 730F8B80E9C
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 13:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22040C433D6
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 13:53:14 +0000 (UTC)
Subject: [PATCH v3 7/7] NFSD: Make nfsd4_rename() wait before returning
 NFS4ERR_DELAY
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 08 Aug 2022 09:53:13 -0400
Message-ID: <165996679309.2637.3603452117215357392.stgit@manet.1015granger.net>
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

nfsd_rename() can kick off a CB_RECALL (via
vfs_rename() -> leases_conflict()) if a delegation is present.
Before returning NFS4ERR_DELAY, give the client holding that
delegation a chance to return it and then retry the nfsd_rename()
again, once.

Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=354
Tested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |   32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5b18a71f1043..ed3c6ef875c3 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1056,17 +1056,33 @@ nfsd4_rename(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 {
 	struct nfsd4_rename *rename = &u->rename;
 	__be32 status;
+	int retries;
 
 	if (opens_in_grace(SVC_NET(rqstp)))
 		return nfserr_grace;
-	status = nfsd_rename(rqstp, &cstate->save_fh, rename->rn_sname,
-			     rename->rn_snamelen, &cstate->current_fh,
-			     rename->rn_tname, rename->rn_tnamelen);
-	if (status)
-		return status;
-	set_change_info(&rename->rn_sinfo, &cstate->current_fh);
-	set_change_info(&rename->rn_tinfo, &cstate->save_fh);
-	return nfs_ok;
+
+	retries = 1;
+	do {
+		status = nfsd_rename(rqstp, &cstate->save_fh, rename->rn_sname,
+				     rename->rn_snamelen, &cstate->current_fh,
+				     rename->rn_tname, rename->rn_tnamelen);
+		if (status == nfs_ok) {
+			set_change_info(&rename->rn_sinfo, &cstate->current_fh);
+			set_change_info(&rename->rn_tinfo, &cstate->save_fh);
+			break;
+		}
+		if (status != nfserr_jukebox)
+			break;
+		if (!retries--)
+			break;
+		if (!nfsd4_wait_for_delegreturn(rqstp, &cstate->current_fh))
+			break;
+
+		fh_clear_pre_post_attrs(&cstate->save_fh);
+		fh_clear_pre_post_attrs(&cstate->current_fh);
+	} while (1);
+
+	return status;
 }
 
 static __be32


