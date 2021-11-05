Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050D1446740
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Nov 2021 17:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhKEQsT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Nov 2021 12:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232930AbhKEQsT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 5 Nov 2021 12:48:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CFF2610A8;
        Fri,  5 Nov 2021 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636130739;
        bh=VJlv6OgsCRlGMEQ8GqH++YjUx1BlID7ZjiCLK2/GkvU=;
        h=From:To:Cc:Subject:Date:From;
        b=sQfU9vUdz6zDcMjaOxQp6oXRAivuJO6Lq+BS8VC/7N+TKOskUK52EVxuzy49QIbUw
         aQi1NrXIRxS3MJa4IWW3rmqUfCtz1IPOk91nnBz1IbkDVNkcHROGQgi9DJRqR7sXVx
         f90yh9Epd4N7DeigLNeOof81qN3PSYUZ/dSX4YreItGAm3+cpyZwM6yPmix8D8qxVE
         Dvz/pvbRqNmvD3YnX7UyHHSMqqJjRdCo/mYvbQfJmqNBGpiKyUqBcUJAk93iAP+9VB
         uZQ3hQ3ZWonkDM84ZZ/3y0fExDk/we74qCzdGu7m5QfjanVyeSR+JGs2ids/DLZUM1
         QwowX8UXoQo1A==
From:   trondmy@kernel.org
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Don't trace an uninitialised value
Date:   Fri,  5 Nov 2021 12:38:52 -0400
Message-Id: <20211105163852.214665-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If fhandle is NULL or fattr is NULL, then 'error' is uninitialised.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 8de99f426183..731d31015b6a 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1798,7 +1798,7 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 	}
 	nfs_set_verifier(dentry, dir_verifier);
 out:
-	trace_nfs_lookup_exit(dir, dentry, flags, error);
+	trace_nfs_lookup_exit(dir, dentry, flags, PTR_ERR_OR_ZERO(res));
 	nfs_free_fattr(fattr);
 	nfs_free_fhandle(fhandle);
 	return res;
-- 
2.33.1

