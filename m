Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96D8353666
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Apr 2021 06:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhDDESN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 4 Apr 2021 00:18:13 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:60302 "EHLO
        mail-m971.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhDDESN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 4 Apr 2021 00:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GTZ63
        5FhsIolWa5xfzkuX6g6mFZFNSJFEuNqHGSB0iU=; b=RnRISEtP5Ucnjwca7zT0B
        T/JeTvYFOWTAYGiB2lK7gr41wDWyDDPw13EZa2bnX/xujFsyhKLrxHdUtrLTKX6s
        Ht/3oUzOBuDqetwZCo3G6brLoOOhENAjMui9QovMp5EWkEPtVsaEr6b8mKrDOqom
        1wdJSsKxl0JEYNcVgCw/Wk=
Received: from localhost.localdomain (unknown [182.138.164.207])
        by smtp1 (Coremail) with SMTP id GdxpCgA3+1zpPWlgbiehBA--.295S4;
        Sun, 04 Apr 2021 12:18:00 +0800 (CST)
From:   Zhen Zhao <zp_8483@163.com>
To:     trond.myklebust@hammerspace.com
Cc:     linux-nfs@vger.kernel.org, Zhen Zhao <zp_8483@163.com>
Subject: [PATCH v1] NFS: Fix typo in comments of nfs_start_io_direct
Date:   Sun,  4 Apr 2021 00:17:23 -0400
Message-Id: <20210404041723.43441-1-zp_8483@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgA3+1zpPWlgbiehBA--.295S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrGFW5KFW7JFyxtr13ZFyrZwb_yoWxWrX_ur
        Z7GF4kW3y5Wr4SyanxAFZaqFZa93y0gr4rGw45tF4rtry5JFZrAr4DJrWfAr1UW3y3Gr9x
        Ga4vgry5KFZrWjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRjjgDUUUUU==
X-Originating-IP: [182.138.164.207]
X-CM-SenderInfo: h2sbmkiyt6il2tof0z/xtbByhhq4V0CQjeocwAAso
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This fixes the typo in comments of nfs_start_io_direct.

Signed-off-by: Zhen Zhao <zp_8483@163.com>
---
 fs/nfs/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/io.c b/fs/nfs/io.c
index 5088fda9b453..b5551ed8f648 100644
--- a/fs/nfs/io.c
+++ b/fs/nfs/io.c
@@ -104,7 +104,7 @@ static void nfs_block_buffered(struct nfs_inode *nfsi, struct inode *inode)
 }
 
 /**
- * nfs_end_io_direct - declare the file is being used for direct i/o
+ * nfs_start_io_direct - declare the file is being used for direct i/o
  * @inode: file inode
  *
  * Declare that a direct I/O operation is about to start, and ensure
-- 
2.27.0

