Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228914E992E
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Mar 2022 16:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbiC1OSa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Mar 2022 10:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241390AbiC1OS0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Mar 2022 10:18:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0818B2C642
        for <linux-nfs@vger.kernel.org>; Mon, 28 Mar 2022 07:16:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95417B81120
        for <linux-nfs@vger.kernel.org>; Mon, 28 Mar 2022 14:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4442CC34100
        for <linux-nfs@vger.kernel.org>; Mon, 28 Mar 2022 14:16:43 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSD: Fix EXCLUSIVE paths in do_nfsd_create()
Date:   Mon, 28 Mar 2022 10:16:42 -0400
Message-Id:  <164847700195.23692.9618617591917178500.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To:  <164847698961.23692.1790666748697443088.stgit@klimt.1015granger.net>
References:  <164847698961.23692.1790666748697443088.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev1+g8516920
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=911; h=from:subject:message-id; bh=zeAfJl8tHEzXr78jToMWRW7kgIaVIf3C1I9b48KawFA=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBiQcNKdrQLSUvALd2nmPZmUJBjv0O2GNc3R5DGTYhM 7/KvBbWJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYkHDSgAKCRAzarMzb2Z/l1tmEA CeMFIXlZGdYhrH33QXfWXgPCKJSNC+wM5ZwTN6E3dBh8IRmNOK9YbDVREZt5DenurOJAgbQSZDfgIo 3I5F78z1AcTyW1Zrkx+cjHxjmAPFZ8BNAVWm5jKm/WY+3aW01KCexo4basMQDiwb4p3RCChHQztacD EWacUPDglklFcP5RfDnQ94+idYOOt8zkkBDdePPNYezaLmqtAsFV5HTZm84Gkr34MhtUntRZ1VvDuG Hr575DNt3PglzoUqdOgMRkOOtStV3+fcfy/GuUwG2KIroKsy3RzCHkI/WSut1kXEFVsgY9J5f24qT3 oqgsnRczI1KceNYv5jJobf1ia+A4l/FVowPNtvIlpDGhFC3BkFgCSJFuaBXdWGorLKFtOgXxP4IgMG v1AiXCfCVUINzlvVtF4gDRWPsIgIUlZQFRtpRT3GKYKO14cez4CMKmsLyIhI/uAD32x/CdbhE/ggZ7 6HxeeevwYQz0YXYBreA516vVeA2888XIMl1gPoQXF1tw7BWGd3YCmsboklkruoBHN8Ue98l8WF9HXD Iksj3yFlw9I3Au/zhlSP8ThkhQjscR8ev3wYu/vv69wQbp0JqtWwvKXF8NFLo8JjU9Vfx17pW5YGRB sE0FyGiy9jVW5I+EeWQQHlPCvQqoGA1SpuXorOjZibCVoSeHPrld1Mo3HM0g==
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

The "out" label already invokes fh_drop_write().

Fixes: 4a55c1017b8d ("nfsd: Push mnt_want_write() outside of i_mutex")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f54da591a5bf..9dee15431175 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1480,7 +1480,6 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		case NFS3_CREATE_GUARDED:
 			err = nfserr_exist;
 		}
-		fh_drop_write(fhp);
 		goto out;
 	}
 
@@ -1488,10 +1487,8 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		iap->ia_mode &= ~current_umask();
 
 	host_err = vfs_create(&init_user_ns, dirp, dchild, iap->ia_mode, true);
-	if (host_err < 0) {
-		fh_drop_write(fhp);
+	if (host_err < 0)
 		goto out_nfserr;
-	}
 	if (created)
 		*created = true;
 

