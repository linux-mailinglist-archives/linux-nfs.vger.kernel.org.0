Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E362418510
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Sep 2021 00:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhIYXAS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 25 Sep 2021 19:00:18 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:36486
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230078AbhIYXAS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 25 Sep 2021 19:00:18 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CC33D40186;
        Sat, 25 Sep 2021 22:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632610721;
        bh=yUov5c28I0sE0mYEPq2ZwDrAU1S9Y8zUPwsyk26CH2E=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=q39KU5X/fhlaezBmBn+Gbay2fd5+AoAQ/SikK2/JV+XStyNOG08iYuU8gshZ0L5ex
         k/BX79gfVZxc0kr6YJipYLWfOXiJ8ghd9rLIu+Sw60oFWoQ+pKUzZ3gkHkXc7U2paE
         vRL384cMbBH2thLqC6KwJmBH2nOD540XhrX9x/NGU+CrzpVhv+GXxEin9+kuqyAG3f
         ULp/onRXXuAIkIaPmvWtZXd9nGm9Gn8Ut9be3acLkqoeJMjvfMnMQxrN227XAEcjM/
         kBtLoEJ0R41WHhfIrrxq7WBmg4gMacsNam2yOqcW/+QyXddWXTHI3hIUhll801gw9H
         vC4DZ9p8h+C8w==
From:   Colin King <colin.king@canonical.com>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFSD: Initialize pointer ni with NULL and not plain integer 0
Date:   Sat, 25 Sep 2021 23:58:41 +0100
Message-Id: <20210925225841.184101-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer ni is being initialized with plain integer zero. Fix
this by initializing with NULL.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/nfsd/nfs4proc.c  | 2 +-
 fs/nfsd/nfs4state.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3f7e59ec4e32..3dc40c1d32bc 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1178,7 +1178,7 @@ extern void nfs_sb_deactive(struct super_block *sb);
 static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 		struct nfsd4_ssc_umount_item **retwork, struct vfsmount **ss_mnt)
 {
-	struct nfsd4_ssc_umount_item *ni = 0;
+	struct nfsd4_ssc_umount_item *ni = NULL;
 	struct nfsd4_ssc_umount_item *work = NULL;
 	struct nfsd4_ssc_umount_item *tmp;
 	DEFINE_WAIT(wait);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8b7e9b28c109..bfad94c70b84 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5541,7 +5541,7 @@ static void nfsd4_ssc_shutdown_umount(struct nfsd_net *nn)
 static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
 {
 	bool do_wakeup = false;
-	struct nfsd4_ssc_umount_item *ni = 0;
+	struct nfsd4_ssc_umount_item *ni = NULL;
 	struct nfsd4_ssc_umount_item *tmp;
 
 	spin_lock(&nn->nfsd_ssc_lock);
-- 
2.32.0

