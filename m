Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23F46076DA
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Oct 2022 14:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJUMYB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Oct 2022 08:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJUMYA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Oct 2022 08:24:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570DF132258
        for <linux-nfs@vger.kernel.org>; Fri, 21 Oct 2022 05:23:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A1B6E21FA6;
        Fri, 21 Oct 2022 12:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666355037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=W7sGysXuTWvdYu2hT9y4eGhEIx0EIX5/uMDrorU+zGM=;
        b=C9ykRMFBaNBQPui56UHCpwv7YW0TffFuIIL/rz+7MoB+bowFM0Nj0t9WCYmAn0jAuigh8n
        JCFZhUTINwxq8UYB6d5hRO+09BLvBQZji4HKScq8bORTKkDqZbjgEzmvh1ByHqXAkQ5Cl3
        j4VJxcaBL9a4c6+ECDU4NoenZ7avUZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666355037;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=W7sGysXuTWvdYu2hT9y4eGhEIx0EIX5/uMDrorU+zGM=;
        b=OhP8pZ1KNWeih2k15TgINkRWp2zsr5/ptGgqhPN2X2/8GI7uJo5mBhvxR77L6ERlCfR3MY
        LFMWO0pXDK5JLwDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D6FB13A0E;
        Fri, 21 Oct 2022 12:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NsM4HV2PUmOEXQAAMHmgww
        (envelope-from <ddiss@suse.de>); Fri, 21 Oct 2022 12:23:57 +0000
From:   David Disseldorp <ddiss@suse.de>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de, David Disseldorp <ddiss@suse.de>
Subject: [PATCH] exportfs: use pr_debug for unreachable debug statements
Date:   Fri, 21 Oct 2022 14:24:14 +0200
Message-Id: <20221021122414.20555-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

expfs.c has a bunch of dprintk statements which are unusable due to:
 #define dprintk(fmt, args...) do{}while(0)
Use pr_debug so that they can be enabled dynamically.
Also make some minor changes to the debug statements to fix some
incorrect types, and remove __func__ which can be handled by dynamic
debug separately.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 fs/exportfs/expfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index c648a493faf23..3204bd33e4e8a 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -18,7 +18,7 @@
 #include <linux/sched.h>
 #include <linux/cred.h>
 
-#define dprintk(fmt, args...) do{}while(0)
+#define dprintk(fmt, args...) pr_debug(fmt, ##args)
 
 
 static int get_name(const struct path *path, char *name, struct dentry *child);
@@ -132,8 +132,8 @@ static struct dentry *reconnect_one(struct vfsmount *mnt,
 	inode_unlock(dentry->d_inode);
 
 	if (IS_ERR(parent)) {
-		dprintk("%s: get_parent of %ld failed, err %d\n",
-			__func__, dentry->d_inode->i_ino, PTR_ERR(parent));
+		dprintk("get_parent of %lu failed, err %ld\n",
+			dentry->d_inode->i_ino, PTR_ERR(parent));
 		return parent;
 	}
 
@@ -147,7 +147,7 @@ static struct dentry *reconnect_one(struct vfsmount *mnt,
 	dprintk("%s: found name: %s\n", __func__, nbuf);
 	tmp = lookup_one_unlocked(mnt_user_ns(mnt), nbuf, parent, strlen(nbuf));
 	if (IS_ERR(tmp)) {
-		dprintk("%s: lookup failed: %d\n", __func__, PTR_ERR(tmp));
+		dprintk("lookup failed: %ld\n", PTR_ERR(tmp));
 		err = PTR_ERR(tmp);
 		goto out_err;
 	}
-- 
2.35.3

