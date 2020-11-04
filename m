Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98642A69A5
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 17:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbgKDQ1J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 11:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgKDQ1J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 11:27:09 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2366AC0613D3
        for <linux-nfs@vger.kernel.org>; Wed,  4 Nov 2020 08:27:09 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 11so233638qkd.5
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 08:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=d4SBKQY4D3SrCP5hjy6CzKLVkGZfG5JmNrqa2naVuXg=;
        b=ZGdxe8CO4I9std1kg2XmPfD0kVU1rgdXYrIYkg5HyResRYNkmIEBPJH0HvdkwBxPit
         MGuF3AhoiqY3GiMswMLqOpXxNtiW2eUbPLK1FZUSZ8zjXr5R01wraCl85FYXWy/Kvd8T
         HfQa4znxVYSuESy4mi9juViPBN+5+Gu97BscR55mlSXiFZlgOeNQQKhejn1WtjETFC42
         7w7vpAm79cpDJdwx+DH0P4l+6btXxUB34ORA9CKoAU0w7ZFyr9xbrZ8GlnIboNyB9zE/
         e1ddXzymyhAQF2Z0HKECkNecfSZfftxM7JGfSbBSlL4scdNvFQOPsl7CbJ/8P6rhyxy3
         tfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d4SBKQY4D3SrCP5hjy6CzKLVkGZfG5JmNrqa2naVuXg=;
        b=dKztAJp8+2BXEu/h5NargafUj7c2w5pafDKnul63fVbBClgxKZmTB2ETya4+C0i8AK
         rzG1cC3zACGAbA2M864gj60X0ijz73uB7ZKgbhfipDIYw87+eD3jgb+B5BZc9ShBXFdn
         q7+Rx0wZyPLOUKRtHEOYZ2skp5OEdobmTrzeVJGji5z7Qy2AIfhiUONFnoz22bvUEkAi
         idTcLSwUa9V1qhQsj5ca+zWkbVN9x+T6tRtNcWAk1Ltc9GTGk7bFPjJUVd0CKaf9Dyp+
         KfRiLxVxeSXhAx9t9dGfQ5AncjkFRJvmWeFc6mVUOCeBqAxmVeQdzSUlAbIJI0EQj03i
         3VWQ==
X-Gm-Message-State: AOAM533xa9e3uwHpzpTfGPaqC7tvJ9FfX/iTYB0ACMrZVBc/6PhzyFsx
        Tbupt5/m3gBe7+bBYtDTLKVe3Rp1c4I4
X-Google-Smtp-Source: ABdhPJxYGXHnE2IQ6j5Azfaduj2Ze4C2lAkT4JvwJQyR7yhqSafqISPxLmBUuIn7fYM88egMX4iorQ==
X-Received: by 2002:ae9:ee15:: with SMTP id i21mr24394904qkg.76.1604507228067;
        Wed, 04 Nov 2020 08:27:08 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id g78sm2896924qke.88.2020.11.04.08.27.06
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:27:07 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 06/17] NFS: Remove unnecessary kmap in nfs_readdir_xdr_to_array()
Date:   Wed,  4 Nov 2020 11:16:27 -0500
Message-Id: <20201104161638.300324-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104161638.300324-6-trond.myklebust@hammerspace.com>
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
 <20201104161638.300324-2-trond.myklebust@hammerspace.com>
 <20201104161638.300324-3-trond.myklebust@hammerspace.com>
 <20201104161638.300324-4-trond.myklebust@hammerspace.com>
 <20201104161638.300324-5-trond.myklebust@hammerspace.com>
 <20201104161638.300324-6-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The kmapped pointer is only used once per loop to check if we need to
exit.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index f7248145c333..e8b0fcc1bc9e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -759,7 +759,6 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 	struct page *pages[NFS_MAX_READDIR_PAGES];
 	struct nfs_entry entry;
 	struct file	*file = desc->file;
-	struct nfs_cache_array *array;
 	int status = -ENOMEM;
 	unsigned int array_size = ARRAY_SIZE(pages);
 
@@ -778,11 +777,9 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 		goto out;
 	}
 
-	array = kmap(page);
-
 	status = nfs_readdir_alloc_pages(pages, array_size);
 	if (status < 0)
-		goto out_release_array;
+		goto out_release_label;
 	do {
 		unsigned int pglen;
 		status = nfs_readdir_xdr_filler(pages, desc, &entry, file, inode);
@@ -797,11 +794,10 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 		}
 
 		status = nfs_readdir_page_filler(desc, &entry, pages, page, pglen);
-	} while (!status && !nfs_readdir_array_is_full(array));
+	} while (!status && nfs_readdir_page_needs_filling(page));
 
 	nfs_readdir_free_pages(pages, array_size);
-out_release_array:
-	kunmap(page);
+out_release_label:
 	nfs4_label_free(entry.label);
 out:
 	nfs_free_fattr(entry.fattr);
-- 
2.28.0

