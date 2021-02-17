Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86B831DC02
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Feb 2021 16:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhBQPOl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Feb 2021 10:14:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233607AbhBQPNY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 17 Feb 2021 10:13:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADA8864E2F;
        Wed, 17 Feb 2021 15:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613574755;
        bh=mtTuNVskXk7QNy1XVyxM1ZIRXGU7Je6BMpoMwrx1RTM=;
        h=From:To:Cc:Subject:Date:From;
        b=DjCHo9hIoViSNzp3f8T/GUIiu52Oa+bnS1++tLkU1zhDbCR27QAU/K5GyrwMUawoT
         BhMEgRp10v2XdPoEZ29uZpaB9mPsmtxwnH2CdBzKfAlT6znUJuSt6Iu3n56dz7tzwg
         Cvtzkx5Y+ZnKnMvdauvMXExRMXrgNVj4cQcN0GaBHKxHVNoLCJgeOXpLA31fr1Qh9w
         Q88aGJMNAiW0LcDD9roHnX5wHUzqqBDIAf1x4itsDnOrNt2KyokbiNj7uV5pNQezaj
         dZylcNKutrtKnLTk3bdzBLuJjs3vjwMPvdOGv9SAHge8YpEtu2FXCZZkh10sDsC13z
         hkmnyi++3GeZA==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Support the '-owrite=' option in /proc/self/mounts and mountinfo
Date:   Wed, 17 Feb 2021 10:12:33 -0500
Message-Id: <20210217151233.366499-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 4034102010f0..bd22c9338600 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -511,6 +511,13 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 		seq_puts(m, ",local_lock=flock");
 	else
 		seq_puts(m, ",local_lock=posix");
+
+	if (nfss->flags & NFS_MOUNT_WRITE_EAGER) {
+		if (nfss->flags & NFS_MOUNT_WRITE_WAIT)
+			seq_puts(m, ",write=wait");
+		else
+			seq_puts(m, ",write=eager");
+	}
 }
 
 /*
-- 
2.29.2

