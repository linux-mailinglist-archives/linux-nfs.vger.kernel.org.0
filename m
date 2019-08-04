Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2797180B3B
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Aug 2019 16:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfHDOb4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 4 Aug 2019 10:31:56 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41239 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfHDOb4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 4 Aug 2019 10:31:56 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so158081946ioj.8
        for <linux-nfs@vger.kernel.org>; Sun, 04 Aug 2019 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ESXZh8j0YZMHjHau85UEyFHLq6ICTWZBfG1KIK833P4=;
        b=Bx37xKSt+xbEElZ7tNn/LezQOHw2KuYVj7wow2v0z20XaOYU12sUyhmeFfxjkPC6iT
         zkQVPX/aPXNtjT6WFmrIFOStAE8ZakoDLkjSJxMWvZVgaKiwGhLbWNzi2drppSVEX7nt
         BpB0w6EM6ukA8kr9RitqbWFjWvLQbdT2UXxIJmdU6VJEdcJGuBXXtur+GcB/3XRlPVrQ
         v4LscsRMhclv5tY5PiP/ZXDJXYEBNRnT3qy3Dax6tzvbZhR7Z3H3D3Tdiah0/+oUHmNq
         nmcggSRSTuUN0A1b6lSDb5PIlBauGYZ5Oi74GFTpVTlFzuT+Cm/kGGaGum5YeMcl1ye8
         /3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ESXZh8j0YZMHjHau85UEyFHLq6ICTWZBfG1KIK833P4=;
        b=cYaDzHkMi5gu8eHrthTglIbJoIOzCmEEUIhtl57tA9isU7QEnIMUo3YlQuym/aWz+Q
         1S6BcpDtnnJV+CCa12G/anP0SQ7IKrmkCk2cNnGNOYUyb/gfo0021PiK1eFb2C9EBw+B
         rL5UsT8ESPx/fbKmEbHb7hg/Mhw76+jtJVtXcbM3p/pflOquzN9HWPG2EticKXL7ZaRL
         LkAvj2OnmdSey9pFhSaSnoeuKwafJI9smdmXIVuheGKJyTzr4Hpa0y/u2jHV9Q5Ng3Fb
         6BZJVBAWNAYf69lYhuiL2JUjm3BRgcR9PEGBfJgjizA8Y83lyHUVG4pHJF1OJBp3+DWJ
         bQxQ==
X-Gm-Message-State: APjAAAWnXcJsnH42MH6AQ3vpNLoLarCynTkhImm7bOZ9efV5Qx2DEXHA
        QE8M6e/L6kGmmnH7+8SoDsHOD7A=
X-Google-Smtp-Source: APXvYqxhRXd+udu3LH55rHONt+d1meGqI4X55fKautnJliysVfQOmGlvtZZORm1k8AQXmEMw5PqbEw==
X-Received: by 2002:a02:528a:: with SMTP id d132mr141472673jab.68.1564929114929;
        Sun, 04 Aug 2019 07:31:54 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id p3sm124059196iom.7.2019.08.04.07.31.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 04 Aug 2019 07:31:54 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Cc:     Steve Dickson <steved@redhat.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH] NFS: Fix regression whereby fscache errors are appearing on 'nofsc' mounts
Date:   Sun,  4 Aug 2019 10:29:46 -0400
Message-Id: <20190804142946.113781-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

People are reporing seeing fscache errors being reported concerning
duplicate cookies even in cases where they are not setting up fscache
at all. The rule needs to be that if fscache is not enabled, then it
should have no side effects at all.

To ensure this is the case, we disable fscache completely on all superblocks
for which the 'fsc' mount option was not set. In order to avoid issues
with '-oremount', we also disable the ability to turn fscache on via
remount.

Fixes: f1fe29b4a02d ("NFS: Use i_writecount to control whether...")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=200145
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Steve Dickson <steved@redhat.com>
Cc: David Howells <dhowells@redhat.com>
---
 fs/nfs/fscache.c | 7 ++++++-
 fs/nfs/fscache.h | 2 +-
 fs/nfs/super.c   | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 53507aa96b0b..3800ab6f08fa 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -114,6 +114,10 @@ void nfs_fscache_get_super_cookie(struct super_block *sb, const char *uniq, int
 	struct rb_node **p, *parent;
 	int diff;
 
+	nfss->fscache_key = NULL;
+	nfss->fscache = NULL;
+	if (!(nfss->options & NFS_OPTION_FSCACHE))
+		return;
 	if (!uniq) {
 		uniq = "";
 		ulen = 1;
@@ -226,10 +230,11 @@ void nfs_fscache_release_super_cookie(struct super_block *sb)
 void nfs_fscache_init_inode(struct inode *inode)
 {
 	struct nfs_fscache_inode_auxdata auxdata;
+	struct nfs_server *nfss = NFS_SERVER(inode);
 	struct nfs_inode *nfsi = NFS_I(inode);
 
 	nfsi->fscache = NULL;
-	if (!S_ISREG(inode->i_mode))
+	if (!(nfss->fscache && S_ISREG(inode->i_mode)))
 		return;
 
 	memset(&auxdata, 0, sizeof(auxdata));
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 25a75e40d91d..ad041cfbf9ec 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -182,7 +182,7 @@ static inline void nfs_fscache_wait_on_invalidate(struct inode *inode)
  */
 static inline const char *nfs_server_fscache_state(struct nfs_server *server)
 {
-	if (server->fscache && (server->options & NFS_OPTION_FSCACHE))
+	if (server->fscache)
 		return "yes";
 	return "no ";
 }
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 628631e2e34f..703f595dce90 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2260,6 +2260,7 @@ nfs_compare_remount_data(struct nfs_server *nfss,
 	    data->acdirmin != nfss->acdirmin / HZ ||
 	    data->acdirmax != nfss->acdirmax / HZ ||
 	    data->timeo != (10U * nfss->client->cl_timeout->to_initval / HZ) ||
+	    (data->options & NFS_OPTION_FSCACHE) != (nfss->options & NFS_OPTION_FSCACHE) ||
 	    data->nfs_server.port != nfss->port ||
 	    data->nfs_server.addrlen != nfss->nfs_client->cl_addrlen ||
 	    !rpc_cmp_addr((struct sockaddr *)&data->nfs_server.address,
-- 
2.21.0

