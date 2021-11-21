Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD28458632
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Nov 2021 20:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhKUT4g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Nov 2021 14:56:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhKUT4f (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 21 Nov 2021 14:56:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3745C60C4A
        for <linux-nfs@vger.kernel.org>; Sun, 21 Nov 2021 19:53:30 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: Fix sparse warning
Date:   Sun, 21 Nov 2021 14:53:28 -0500
Message-Id:  <163752440294.1250.3869779017871620568.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=854; h=from:subject:message-id; bh=tO9afuXoYZpzUKNhYdNu+f36tAbywigUGH7kMEnZU6w=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhmqOz6T+3yWEiXzDePF+W2tBrK4YksqudpsfrnDwy 4Bz4GnqJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYZqjswAKCRAzarMzb2Z/lwIUEA C435LWuTBzkOJYH74ExWM9i6OxOiL1gDzD/A4iWjF8Ts/zkr9fTa8y5PTrwIQEiZimt6mV9gKDvWXE hFQC7y4Fj96Hzv7Ha+2sY/nRX3QzbJSnuKfMrX//zfmGHmk0ksQ3rHnjRtlLv2CevqHW7BNAk1SDkT X7nsK0lgur+XwiXXikWx7jGLXIUNXt0dv1o7EFIGF9f874beRcTLPRcoESd4L0I4IuM7+Z6vV3Obpp wfvUuWKBObSyKZhGhrEz7IH/5apsc6tCg09Ub+0NTtt5FuwbmRe9ts7ZTxzuwrSr9nx1p5HLsyOHE+ wiHw53Uyzic9CmSOzIqupk9ENfZMnGrAecrwZ2l/UqG7BRgD49P4bwhOqlmxvkMd9sNbvvjW07QDDn kh49zDlXc+CPul0NhsLegINw/A0TaJCW7UfzyH3fU0z1P0vMbIhOO5U3C9R+/ZdQcRJxIPWd6hcOok jsupltVePUkkq+VGiCCTzJ4jjPgARtVA9zUshyFfFcckcg+jvwGxkUg73x6PG5te9qxvI6Ymfe1zeE /rhVIDWmT7U12XvXtiBls1YVFAAkK/rdTdv64XyPKER9pgfGziUQSmvQNzc/J7wV5cxsjY+KyzLc2h l+kDrdVc9qeFAvFu6iMV5GpaonKvgZhFWRu7FLDGjqZv01UuxecvO4rgjSCQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

/home/cel/src/linux/linux/fs/nfsd/nfs4proc.c:1539:24: warning: incorrect type in assignment (different base types)
/home/cel/src/linux/linux/fs/nfsd/nfs4proc.c:1539:24:    expected restricted __be32 [usertype] status
/home/cel/src/linux/linux/fs/nfsd/nfs4proc.c:1539:24:    got int

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a36261f89bdf..a6dc5e18c498 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1514,7 +1514,7 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
 	u64 bytes_total = copy->cp_count;
 	u64 src_pos = copy->cp_src_pos;
 	u64 dst_pos = copy->cp_dst_pos;
-	__be32 status;
+	int status;
 
 	/* See RFC 7862 p.67: */
 	if (bytes_total == 0)

