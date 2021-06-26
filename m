Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154213B4F60
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Jun 2021 18:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhFZQH6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Jun 2021 12:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFZQHz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Jun 2021 12:07:55 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD715C061574
        for <linux-nfs@vger.kernel.org>; Sat, 26 Jun 2021 09:05:31 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id bj15so22468979qkb.11
        for <linux-nfs@vger.kernel.org>; Sat, 26 Jun 2021 09:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zIWT1S4kh6PPa3DRlxLlpt/vATak1O4EQDwysGUmM7w=;
        b=D5EhZBcOJ58qy4GAok324sVwYXH6GlWUSJWm47D0L4xqwRaiKrZLiLHvnqAmfNP3tu
         eXI3ghtlD0cAiPsC+23Ovaj7PEFTTDi53nrgfwYMvT927XpfdehFGIuzKmDhWSdwjKwL
         5FbGhamwOHJC325ce3Os4G0HscUP8I1npVh+99pZK2Kki9dk6DkmurmIbC0xD6o1pgFW
         s80zV7Dui26XAAtybwGCTkeXyAxIdAcgF2/e0VMy+pSNdXUrheO/UwheZ0ffognHR39n
         EjvPCnvFEk4zCwAMhpOkoOb44L5HHG2lvi5zJGUh5WN4sGasRFTysGkcepmaTqB+YrF8
         zJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zIWT1S4kh6PPa3DRlxLlpt/vATak1O4EQDwysGUmM7w=;
        b=YKyyeq6f6BxmZJiM2xtzOBiVm2DX8mXj7WmcuYhvfNskSAJx8pUaBT/JUrMKxWLMhz
         UMjSR0fuxI0Jv/W5d+avhd/eBY0FJbO0eNWu21wkHzByjPZ5mu5mdP8FZlBcyTzQmSXG
         TLbGVuiSeM3DMpPcrGdhwJRfquu4RpQBWheuFS5UzSPYijIkBUOIgW//T2YD3I/QVmG5
         a5Zce2v/pPZl8S2ZGYmu2R33vMlOFAQdegt2T276mOXRvRiPYX8fScEBFo/w3xI7sw4M
         1duxNaiq9MqKNP2QMlbygRbnhIDR4WQ+S7yooD/52RlYikKU2TcGKJIX84pEQIL4zzRc
         Vbmw==
X-Gm-Message-State: AOAM533NTlVZAfYtwwmiHwCOtHSHTQ62it8EC02ZrTwhA0rPBZp38bja
        yBHLIXf1fhr4l7sv+z9S6m6J9PdNuLBR
X-Google-Smtp-Source: ABdhPJx1Sa6sdpfW/DZ+4GRVF/M0fl8NUlmZ62xZeoKUw/aKZBgwmn0DxC9qAmD7y9pTD/uRZAfgzA==
X-Received: by 2002:a05:620a:136a:: with SMTP id d10mr16612493qkl.422.1624723530483;
        Sat, 26 Jun 2021 09:05:30 -0700 (PDT)
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id 202sm5797624qki.83.2021.06.26.09.05.29
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 09:05:29 -0700 (PDT)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFS: Avoid duplicate resets of attribute cache timeouts
Date:   Sat, 26 Jun 2021 12:05:26 -0400
Message-Id: <20210626160526.323332-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210626160526.323332-3-trond.myklebust@hammerspace.com>
References: <20210626160526.323332-1-trond.myklebust@hammerspace.com>
 <20210626160526.323332-2-trond.myklebust@hammerspace.com>
 <20210626160526.323332-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We know that the attributes changed on the server if and only if the
change attribute is different. Otherwise, we're just refreshing our
cache with values that were already known to be stale.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b05414d5f5c7..4ced82dfe52d 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2059,13 +2059,13 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 					| NFS_INO_INVALID_OTHER;
 				if (S_ISDIR(inode->i_mode))
 					nfs_force_lookup_revalidate(inode);
+				attr_changed = true;
 				dprintk("NFS: change_attr change on server for file %s/%ld\n",
 						inode->i_sb->s_id,
 						inode->i_ino);
 			} else if (!have_delegation)
 				nfsi->cache_validity |= NFS_INO_DATA_INVAL_DEFER;
 			inode_set_iversion_raw(inode, fattr->change_attr);
-			attr_changed = true;
 		}
 	} else {
 		nfsi->cache_validity |=
@@ -2098,7 +2098,6 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 				i_size_write(inode, new_isize);
 				if (!have_writers)
 					invalid |= NFS_INO_INVALID_DATA;
-				attr_changed = true;
 			}
 			dprintk("NFS: isize change on server for file %s/%ld "
 					"(%Ld to %Ld)\n",
@@ -2130,7 +2129,6 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			inode->i_mode = newmode;
 			invalid |= NFS_INO_INVALID_ACCESS
 				| NFS_INO_INVALID_ACL;
-			attr_changed = true;
 		}
 	} else if (fattr_supported & NFS_ATTR_FATTR_MODE)
 		nfsi->cache_validity |=
@@ -2141,7 +2139,6 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			invalid |= NFS_INO_INVALID_ACCESS
 				| NFS_INO_INVALID_ACL;
 			inode->i_uid = fattr->uid;
-			attr_changed = true;
 		}
 	} else if (fattr_supported & NFS_ATTR_FATTR_OWNER)
 		nfsi->cache_validity |=
@@ -2152,7 +2149,6 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			invalid |= NFS_INO_INVALID_ACCESS
 				| NFS_INO_INVALID_ACL;
 			inode->i_gid = fattr->gid;
-			attr_changed = true;
 		}
 	} else if (fattr_supported & NFS_ATTR_FATTR_GROUP)
 		nfsi->cache_validity |=
@@ -2163,7 +2159,6 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			if (S_ISDIR(inode->i_mode))
 				invalid |= NFS_INO_INVALID_DATA;
 			set_nlink(inode, fattr->nlink);
-			attr_changed = true;
 		}
 	} else if (fattr_supported & NFS_ATTR_FATTR_NLINK)
 		nfsi->cache_validity |=
-- 
2.31.1

