Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3C07C4922
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 07:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjJKFQT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Oct 2023 01:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjJKFQS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Oct 2023 01:16:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6F698
        for <linux-nfs@vger.kernel.org>; Tue, 10 Oct 2023 22:16:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6D22421847;
        Wed, 11 Oct 2023 05:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697001375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LL7tWXUl7A3RdvdqOHiqksj0Bp6yAXgIslcHvnRez98=;
        b=iZc+FzWRu9jEM2SVav498qBP4q28g2d5sKfhHk0csAEr9GTHvz1891MJV0GlZTroKqxnv/
        14Jwty3pHt3TpwsxxoSUqIpsRqVcJ4nBuY29ifvY4oRR6Zm8m5n2WMyhgZqcCm8xkbTM+2
        sDe7eQCsMt/XOHYWLEzR2SSnUOuojuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697001375;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LL7tWXUl7A3RdvdqOHiqksj0Bp6yAXgIslcHvnRez98=;
        b=5GW+ZeT81ahjpSc6qR0EMZfrbuKFn64rhQ9c0FSlm8doWcil5Q1XE8TUwX7RqOLpiP5evl
        HWspVRgToZkkJCBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 315BB13586;
        Wed, 11 Oct 2023 05:16:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4zOONZ0vJmWCQgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 11 Oct 2023 05:16:13 +0000
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: [PATCH 2/3] export: add EACCES to the list of known path_lookup_error() errors.
Date:   Wed, 11 Oct 2023 15:58:01 +1100
Message-ID: <20231011051131.24667-3-neilb@suse.de>
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

If a 'stat' results in EACCES (for root), then it is likely a permanent
problem.  One possible cause is a 'fuser' filesystem which only gives
any access to the user which mounted it.

So it is reasonable for EACCES to be a "path lookup error"

Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/export/cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/support/export/cache.c b/support/export/cache.c
index e4595020f43f..5307f6c8d872 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -77,6 +77,7 @@ static bool path_lookup_error(int err)
 	case ENAMETOOLONG:
 	case ENOENT:
 	case ENOTDIR:
+	case EACCES:
 		return 1;
 	}
 	return 0;
-- 
2.42.0

