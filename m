Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E43C7EB9CD
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfJaWnK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:10 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38262 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJaWnK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:10 -0400
Received: by mail-yb1-f195.google.com with SMTP id w6so1529642ybj.5
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wffmvJOuCjzexwiA9Y47Ehh0DUr7m1PyECllZf2CLXs=;
        b=Rezvl+z5g9RsrKkdX0aP/qJYj3rGaxbOTitT6BkKJUllnOkXEDEUcBIa6bpL/0dxIA
         Z5mPNrYVR68BH5onyRmGO1x+VMwQLwcNRNQkHT2UFybr+Bfzu5YSBxdeUwsqswTrQ+mW
         dZwRz2tTEALPBzaCRAaWiOpwNOENd35fk11b/76Jqgdx8aA0Dz9zqVA9qDtXchsLUuOu
         SmhQYCT97ZdxNbiCNoif424IfX2SYWFLd+G7zZEJjB7W2dM+PbVVnVVvoUvjsxG+CFxz
         EZJVwjaN7Fr3ByuJ77AJyWtASPvyTX9xqxaqFKtdPAlmSVOQglRNOmzXvlxCQcQGxX1s
         UG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wffmvJOuCjzexwiA9Y47Ehh0DUr7m1PyECllZf2CLXs=;
        b=UBTX/ljxddfsnoIxpNaynLN11iaLuxl/N+EV1egpzhkODHPTHfkQpKfkzMivijkENJ
         sgZwWm08zsTpjqSeFAe6G6M99xy6jG+kAkGfkEjBlR7efbfuNqh0XjoO9unam+qgD5L+
         yjJQ7fzt3k0xrEx3b57ODNR9F6tWBYSIXHulQGh++e7QCERlSidnlCVeOyPHtdCO66bu
         czUdqWZRpcxc8oUNrnOZgUoZHtM3/jDzkcUP1/J+Necnu2YyhE1zr1jnwTT6GFf+s/Wq
         mFZHChZJGW3hcuu4qYn4X2p0B/biV7QavX+7mEy44oZB7sItXh/gY/VvC+u5Ge2xQJrR
         pshw==
X-Gm-Message-State: APjAAAVL0Plrbed7P0Ss5IIwiZPFXyTM6goQS0q6+PWBAVBMjoAE36Kl
        RiNhc3g/vKVVa9muMxVep3FBLY0=
X-Google-Smtp-Source: APXvYqz8f5ryy59RcyQXewajrc6Tt1pnWjS7aUjcO7NA7P1oVThDJo1KdZSr0ZTjB8UGCWJLObQwWQ==
X-Received: by 2002:a25:4643:: with SMTP id t64mr6714427yba.498.1572561787432;
        Thu, 31 Oct 2019 15:43:07 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.06
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:06 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 04/20] NFSv4: nfs4_callback_getattr() should ignore revoked delegations
Date:   Thu, 31 Oct 2019 18:40:35 -0400
Message-Id: <20191031224051.8923-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031224051.8923-4-trond.myklebust@hammerspace.com>
References: <20191031224051.8923-1-trond.myklebust@hammerspace.com>
 <20191031224051.8923-2-trond.myklebust@hammerspace.com>
 <20191031224051.8923-3-trond.myklebust@hammerspace.com>
 <20191031224051.8923-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the delegation has been revoked, ignore it.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/callback_proc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index db3e7771e597..cd4c6bc81cae 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -26,7 +26,6 @@ __be32 nfs4_callback_getattr(void *argp, void *resp,
 	struct cb_getattrargs *args = argp;
 	struct cb_getattrres *res = resp;
 	struct nfs_delegation *delegation;
-	struct nfs_inode *nfsi;
 	struct inode *inode;
 
 	res->status = htonl(NFS4ERR_OP_NOT_IN_SESSION);
@@ -47,9 +46,8 @@ __be32 nfs4_callback_getattr(void *argp, void *resp,
 				-ntohl(res->status));
 		goto out;
 	}
-	nfsi = NFS_I(inode);
 	rcu_read_lock();
-	delegation = rcu_dereference(nfsi->delegation);
+	delegation = nfs4_get_valid_delegation(inode);
 	if (delegation == NULL || (delegation->type & FMODE_WRITE) == 0)
 		goto out_iput;
 	res->size = i_size_read(inode);
-- 
2.23.0

