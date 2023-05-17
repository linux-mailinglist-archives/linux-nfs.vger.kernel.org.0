Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F69B706E12
	for <lists+linux-nfs@lfdr.de>; Wed, 17 May 2023 18:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjEQQ0t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 May 2023 12:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjEQQ0s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 May 2023 12:26:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3137130;
        Wed, 17 May 2023 09:26:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FF0D63D9C;
        Wed, 17 May 2023 16:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83718C433D2;
        Wed, 17 May 2023 16:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684340807;
        bh=sU1C7XJg/7VvloWpwX9yx2Ma9fhNOkvoRR16fGxVrx4=;
        h=From:To:Cc:Subject:Date:From;
        b=sZJlHjmztkvkLKxHbNj52fhsNhecUqM37bGatmGQxktUqEdItN6NL5LT81V2t091h
         gPcnMFAc4lv9o6eMpujnLyfiItRFzKYUVq04zMGhsHGW8TlWs6aPW8/qBYsGTQd3bH
         Yqul0tjCKB1OEQlFvxnj6oyty7r0DvSw62ycW3nV5MfdlkgPfgzublOcRIf2hxfnup
         wO6fGalPgH4Yha0Fy6jCA5HXWHpPEpcQFbaO9ayWcfJ1QMlfeEWH4TpdoLo2N6cIn9
         XdrYaNigaP+qblqjiHbOFziGE0A/8WhqPj7v0QnQB09sTVfVptanFsFJrBRx2ONgce
         J9jFpKhWTDKag==
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Zhi Li <yieli@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: make a copy of struct iattr before calling notify_change
Date:   Wed, 17 May 2023 12:26:44 -0400
Message-Id: <20230517162645.254512-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

notify_change can modify the iattr structure. In particular it can can
end up setting ATTR_MODE when ATTR_KILL_SUID is already set, causing a
BUG() if the same iattr is passed to notify_change more than once.

Make a copy of the struct iattr before calling notify_change.

Fixes: 34b91dda7124 NFSD: Make nfsd4_setattr() wait before returning NFS4ERR_DELAY
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2207969
Reported-by: Zhi Li <yieli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/vfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c4ef24c5ffd0..ad0c5cd900b1 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -538,7 +538,9 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	inode_lock(inode);
 	for (retries = 1;;) {
-		host_err = __nfsd_setattr(dentry, iap);
+		struct iattr attrs = *iap;
+
+		host_err = __nfsd_setattr(dentry, &attrs);
 		if (host_err != -EAGAIN || !retries--)
 			break;
 		if (!nfsd_wait_for_delegreturn(rqstp, inode))
-- 
2.40.1

