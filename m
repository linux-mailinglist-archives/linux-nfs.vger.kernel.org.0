Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6683D57D
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 20:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406910AbfFKS1X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 14:27:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43423 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407075AbfFKS1W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 14:27:22 -0400
Received: by mail-io1-f68.google.com with SMTP id k20so10722465ios.10
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jun 2019 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jnJfHc433JUSUzdy8Ofjg6zHCGsQ8SqWzcQXIx3do5w=;
        b=eRwLQJXQzdkCU51LKCNwMQnzonBP8SwvHza0WXfQy8qqamkz0P3IJoom4wDGjnAYtr
         cxLINz8cyICSyuo5HF8DkpGBSNAzWGZDStf19/I9FW8GXvX/1FmXzaIv8ZIl7Wr44M1b
         y4uWvtlJFfWNGQMykMTUvKZmu99CSadhUrUTAKkVK6HiaaKHTvFmp8OL4OdCrw6xAHMv
         Un8altPCGvNSofjt3t7VeIQpoeCPq6hx0pUzxtStDJ131RVCfQyE4V5ldBsQuN/XPYl7
         DSR/vmONBKuzVyCUuQKPaph+tpBW+/eAMT9vJhbyvTqxjVxAtpunE0yGfGz6DFE6N8XA
         ba8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jnJfHc433JUSUzdy8Ofjg6zHCGsQ8SqWzcQXIx3do5w=;
        b=pwMYhJ5iqYeQZtNhZa4VVGNGJzx5gOvg18G1MUhhNI01GXopxBoByIezVVvvehkbRg
         V4uQKgh4daZxJ5FN6pa/XP/ql7sBqnLsuaAQGO1krA17mZd63aSRM9QMFZOTdUYjbiJZ
         cHTHax9GAp56j1mgD3f10n1/lAdeCqn4POQhKBHz/3b7x4gJxHBfpsX08YnLjz4Fz6aA
         4o5DrU2ByXOorh+4w6KTSaNN0wyz9rZ/aiFFFNG62p8EPmN9soC++e00gAvTixJuB1u0
         8H1OjnwmSPxo4SROinmnHR+4wD5aStQ5++QPMW9P0QAekr1B7AVYaEVuDamUgz1rFA0O
         DwfQ==
X-Gm-Message-State: APjAAAV6Qbauod2T/oq5lQEdpCwUKpLp8fgpV5O3k6MsoSTG3MmA/tS7
        CoENRUUwxM9bgqcB7K2NIURbgXo=
X-Google-Smtp-Source: APXvYqxsZ44plEpzqV0ik1yPtYLjbJ4ZQTu6oc2I74ZlIpJQXfgLmIDx8aedwFdQQjfLwM/ZiLN95Q==
X-Received: by 2002:a6b:8b51:: with SMTP id n78mr51314530iod.192.1560277641128;
        Tue, 11 Jun 2019 11:27:21 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q9sm4789830iot.80.2019.06.11.11.27.20
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 11:27:20 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFS: Add deferred cache invalidation for close-to-open consistency violations
Date:   Tue, 11 Jun 2019 14:25:11 -0400
Message-Id: <20190611182511.120074-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611182511.120074-3-trond.myklebust@hammerspace.com>
References: <20190611182511.120074-1-trond.myklebust@hammerspace.com>
 <20190611182511.120074-2-trond.myklebust@hammerspace.com>
 <20190611182511.120074-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the client detects that close-to-open cache consistency has been
violated, and that the file or directory has been changed on the
server, then do a cache invalidation when we're done working with
the file.
The reason we don't do an immediate cache invalidation is that we
want to avoid performance problems due to false positives. Also,
note that we cannot guarantee cache consistency in this situation
even if we do invalidate the cache.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c           |  4 ++++
 fs/nfs/inode.c         | 15 +++++++++++----
 include/linux/nfs_fs.h |  2 ++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 57b6a45576ad..bd1f9555447b 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -80,6 +80,10 @@ static struct nfs_open_dir_context *alloc_nfs_open_dir_context(struct inode *dir
 		ctx->dup_cookie = 0;
 		ctx->cred = get_cred(cred);
 		spin_lock(&dir->i_lock);
+		if (list_empty(&nfsi->open_files) &&
+		    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
+			nfsi->cache_validity |= NFS_INO_INVALID_DATA |
+				NFS_INO_REVAL_FORCED;
 		list_add(&ctx->list, &nfsi->open_files);
 		spin_unlock(&dir->i_lock);
 		return ctx;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 0b4a1a974411..8274d021d46a 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -208,7 +208,7 @@ static void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 	}
 
 	if (inode->i_mapping->nrpages == 0)
-		flags &= ~NFS_INO_INVALID_DATA;
+		flags &= ~(NFS_INO_INVALID_DATA|NFS_INO_DATA_INVAL_DEFER);
 	nfsi->cache_validity |= flags;
 	if (flags & NFS_INO_INVALID_DATA)
 		nfs_fscache_invalidate(inode);
@@ -652,7 +652,8 @@ static int nfs_vmtruncate(struct inode * inode, loff_t offset)
 	i_size_write(inode, offset);
 	/* Optimisation */
 	if (offset == 0)
-		NFS_I(inode)->cache_validity &= ~NFS_INO_INVALID_DATA;
+		NFS_I(inode)->cache_validity &= ~(NFS_INO_INVALID_DATA |
+				NFS_INO_DATA_INVAL_DEFER);
 	NFS_I(inode)->cache_validity &= ~NFS_INO_INVALID_SIZE;
 
 	spin_unlock(&inode->i_lock);
@@ -1032,6 +1033,10 @@ void nfs_inode_attach_open_context(struct nfs_open_context *ctx)
 	struct nfs_inode *nfsi = NFS_I(inode);
 
 	spin_lock(&inode->i_lock);
+	if (list_empty(&nfsi->open_files) &&
+	    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
+		nfsi->cache_validity |= NFS_INO_INVALID_DATA |
+			NFS_INO_REVAL_FORCED;
 	list_add_tail_rcu(&ctx->list, &nfsi->open_files);
 	spin_unlock(&inode->i_lock);
 }
@@ -1312,7 +1317,8 @@ int nfs_revalidate_mapping(struct inode *inode,
 
 	set_bit(NFS_INO_INVALIDATING, bitlock);
 	smp_wmb();
-	nfsi->cache_validity &= ~NFS_INO_INVALID_DATA;
+	nfsi->cache_validity &= ~(NFS_INO_INVALID_DATA|
+			NFS_INO_DATA_INVAL_DEFER);
 	spin_unlock(&inode->i_lock);
 	trace_nfs_invalidate_mapping_enter(inode);
 	ret = nfs_invalidate_mapping(inode, mapping);
@@ -1870,7 +1876,8 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 				dprintk("NFS: change_attr change on server for file %s/%ld\n",
 						inode->i_sb->s_id,
 						inode->i_ino);
-			}
+			} else if (!have_delegation)
+				nfsi->cache_validity |= NFS_INO_DATA_INVAL_DEFER;
 			inode_set_iversion_raw(inode, fattr->change_attr);
 			attr_changed = true;
 		}
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index d363d5765cdf..0a11712a80e3 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -223,6 +223,8 @@ struct nfs4_copy_state {
 #define NFS_INO_INVALID_MTIME	BIT(10)		/* cached mtime is invalid */
 #define NFS_INO_INVALID_SIZE	BIT(11)		/* cached size is invalid */
 #define NFS_INO_INVALID_OTHER	BIT(12)		/* other attrs are invalid */
+#define NFS_INO_DATA_INVAL_DEFER	\
+				BIT(13)		/* Deferred cache invalidation */
 
 #define NFS_INO_INVALID_ATTR	(NFS_INO_INVALID_CHANGE \
 		| NFS_INO_INVALID_CTIME \
-- 
2.21.0

