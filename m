Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485C17C4921
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 07:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjJKFQP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Oct 2023 01:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjJKFQO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Oct 2023 01:16:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D414D94
        for <linux-nfs@vger.kernel.org>; Tue, 10 Oct 2023 22:16:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9330921847;
        Wed, 11 Oct 2023 05:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697001370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h98sz0lTI/sP+BC22XaGvvxMxAkk0s2cI0+X8eHPRIw=;
        b=0m4oMdFxfIxGkJ/kkRLB5GemvkrPaSZKmGsXumVgwcWp+cX5lsrlbS1QweRBx40TZYQLlO
        8aP9d9pndT97lFMOWEP0ifMdVU6oqcsouieEGlTw3z7AOJc7DaYkmttzxe+0/V6XYhWmxE
        s2LNp8VeQ/6li0JDTDIH8+Y8QiC3mdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697001370;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h98sz0lTI/sP+BC22XaGvvxMxAkk0s2cI0+X8eHPRIw=;
        b=bkFcE2dKLEvvVbhq2ei8nF8LdQfFpBwb63NxHsFOT7jWyWI12rtemDrf73yasLyzmPUReD
        xDRY27n3zCaBRWAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5540713586;
        Wed, 11 Oct 2023 05:16:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Nw+dApkvJmVzQgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 11 Oct 2023 05:16:09 +0000
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: [PATCH 1/3] export: fix handling of error from match_fsid()
Date:   Wed, 11 Oct 2023 15:58:00 +1100
Message-ID: <20231011051131.24667-2-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011051131.24667-1-neilb@suse.de>
References: <20231011051131.24667-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If match_fsid() returns -1 we shouldn't assume that the path definitely
doesn't match the fsid, though it might not.
This is a similar situation to where an export is expected to be a mount
point, but is found not to be one.  So it can be handled the same way,
by setting 'dev_missing'.
This will only have an effect is no other path matched the fsid, which
is what we want.

The current code results in nothing being exported and any export point,
or any mount point beneath a crossmnt export point fail a 'stat'
request, which is too harsh.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/export/cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 19bbba556060..e4595020f43f 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -858,7 +858,8 @@ static void nfsd_fh(int f)
 			case 0:
 				continue;
 			case -1:
-				goto out;
+				dev_missing ++;
+				continue;
 			}
 			if (is_ipaddr_client(dom)
 					&& !ipaddr_client_matches(exp, ai))
-- 
2.42.0

