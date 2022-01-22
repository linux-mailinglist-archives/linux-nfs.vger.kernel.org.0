Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D99496D30
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jan 2022 19:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiAVSCt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Jan 2022 13:02:49 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55040 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiAVSCt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Jan 2022 13:02:49 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1157E212C3;
        Sat, 22 Jan 2022 18:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642874568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=x/iRK/6ait1kDszIJ2+GRbg0pxnRpd9qDO+Fw2J+D7o=;
        b=INtje3TRrJ6K5ek2ZZYsKjAODMlV360co4/sSSbwYv5kA57FEQ5Pu9AYdc3Q1i0FQQYj0h
        SXrFVZLfGPyzCXrhndE7W53k/0Q+C61Z0RiHbIGEcSw5X/Hp6oPZ2bnM1tpJ7+1wlFSdiO
        6o8GndH5wQ32azEeqEZeMaTg8i6fbvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642874568;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=x/iRK/6ait1kDszIJ2+GRbg0pxnRpd9qDO+Fw2J+D7o=;
        b=IWYqeedx73NyYs7iLUj6A3zetzgphcyt677z8B8CeMmNkxVLCN5z8Di68C69pJ8rNaz1SD
        jzdYUcBZMJgrDGAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7DED13AFD;
        Sat, 22 Jan 2022 18:02:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kXrHKsdG7GFheQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Sat, 22 Jan 2022 18:02:47 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Steve Dickson <steved@redhat.com>,
        Yongcheng Yang <yongcheng.yang@gmail.com>
Subject: [PATCH 1/1] utils: Fix left debug info
Date:   Sat, 22 Jan 2022 19:02:43 +0100
Message-Id: <20220122180243.19355-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Patch for 497ffdf8 ('manpage: remove the no longer supported value
"vers2"') [1] didn't contain printf in exportfs.c (looks like debugging
info) and errno handling in stropts.c (maybe work on other patch) which
were applied. Thus removing it.

[1] https://lore.kernel.org/linux-nfs/20220117031356.13361-1-yoyang@redhat.com/raw

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 utils/exportfs/exportfs.c | 2 --
 utils/mount/stropts.c     | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index c247425b..6ba615d1 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -307,14 +307,12 @@ static int exportfs_generic(char *arg, char *options, int verbose)
 {
 	char *path;
 
-printf("exportfs_generic: arg '%s'\n", arg);
 	if ((path = strchr(arg, ':')) != NULL)
 		*path++ = '\0';
 
 	if (!path || *path != '/')
 		return 1;
 
-printf("exportfs_generic: path '%s'\n", path);
 	exportfs_parsed(arg, path, options, verbose);
 	return 0;
 }
diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
index 3ca69862..3c4e218a 100644
--- a/utils/mount/stropts.c
+++ b/utils/mount/stropts.c
@@ -973,8 +973,7 @@ fall_back:
 	if ((result = nfs_try_mount_v3v2(mi, FALSE)))
 		return result;
 
-	if (errno != EBUSY)
-		errno = olderrno;
+	errno = olderrno;
 	return result;
 }
 
-- 
2.34.1

