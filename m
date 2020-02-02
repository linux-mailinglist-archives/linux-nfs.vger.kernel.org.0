Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97DB814FFDE
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Feb 2020 23:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgBBW4K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Feb 2020 17:56:10 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37122 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgBBW4K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Feb 2020 17:56:10 -0500
Received: by mail-yw1-f68.google.com with SMTP id l5so11952325ywd.4
        for <linux-nfs@vger.kernel.org>; Sun, 02 Feb 2020 14:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aKCdiCvf1CCHY7Wz5wj2AxA/hIzhbB4Gaz8M9nQKtTs=;
        b=LzkfmkYUhNa7kpQ+d9SqUE7PkBWbV5siaQELkviYXiq5/UufpvC3mEwVvDoacqU9En
         IYdmsmeTEiIn4gci/E3kQ9t8RQVBZa8e/2Dhyi1+eaBFlBDX9wcC1O1gDGjFosqPosC0
         vlpc7Bf8r8iC0KXHO2npx/+omZrMli/IB4Bpz5UD9crO6bHA6WYf2RsLTxse4xQ6Vvp4
         nBqiTpi1Wk59k59DG0AMsXm3D9NtsuaTyIamX056Fpzv/oJ2MbPhmGA09BnnUIni/Ym5
         JUGqHq/BKxugMjwQz8W2P3SRaL2svxkDCUuspvcihD/VCmO5RS5KYnhD78CAvYXqybdF
         Altg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aKCdiCvf1CCHY7Wz5wj2AxA/hIzhbB4Gaz8M9nQKtTs=;
        b=q3HA6hzqDBzPwoBUU6C07KPM+4zupWyFqN8wzfB5Xh2JwmnwcxaCJyvb9xDqMfYwDF
         3X4JZXzAK1r/w1bfgWDChBANZDM6hh657CL/8DP5rZbM9MGCwQ0UnsN5PSdts7XrLkXN
         7xHtS5fSbcAlfUKcLmS+93DZupZfob9IwMjvGb+j24IjzpoHLYXgaqxtY1vc+iWUHubX
         I9AwfAJb0ijbRIBbbPqb7nki4703u2k0eFM5FWoJLkLO9YmqNWpYAhKVYAnMicCWN614
         B8zit6sGLagDStk1QLZlquXdgGyoR23Pb92s0mnWtUVs+n1ch10VPMLuyuAU113o4sHv
         uNIw==
X-Gm-Message-State: APjAAAWVEyfGibtHJhlalvid0O+V0lv/CvJ8vIPwfQnKaaH/cvaRF51B
        NmZMuwER4DOzOlaNLPPsJw==
X-Google-Smtp-Source: APXvYqxnPjn/Lvrw5Rgrv8UxyUZUupb3zqeuPZKtDg03vbxdlDhaVoTp14zUV3+FSXwyv/pazUMfog==
X-Received: by 2002:a25:b989:: with SMTP id r9mr15966116ybg.366.1580684167678;
        Sun, 02 Feb 2020 14:56:07 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u136sm7185529ywf.101.2020.02.02.14.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:56:07 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] NFS: Fix memory leaks and corruption in readdir
Date:   Sun,  2 Feb 2020 17:53:53 -0500
Message-Id: <20200202225356.995080-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200202225356.995080-1-trond.myklebust@hammerspace.com>
References: <20200202225356.995080-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs_readdir_xdr_to_array() must not exit without having initialised
the array, so that the page cache deletion routines can safely
call nfs_readdir_clear_array().
Furthermore, we should ensure that if we exit nfs_readdir_filler()
with an error, we free up any page contents to prevent a leak
if we try to fill the page again.

Fixes: 11de3b11e08c ("NFS: Fix a memory leak in nfs_readdir")
Cc: stable@vger.kernel.org # v2.6.37+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 76404f53cf21..ba0d55930e8a 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -163,6 +163,17 @@ typedef struct {
 	bool eof;
 } nfs_readdir_descriptor_t;
 
+static
+void nfs_readdir_init_array(struct page *page)
+{
+	struct nfs_cache_array *array;
+
+	array = kmap_atomic(page);
+	memset(array, 0, sizeof(struct nfs_cache_array));
+	array->eof_index = -1;
+	kunmap_atomic(array);
+}
+
 /*
  * we are freeing strings created by nfs_add_to_readdir_array()
  */
@@ -175,6 +186,7 @@ void nfs_readdir_clear_array(struct page *page)
 	array = kmap_atomic(page);
 	for (i = 0; i < array->size; i++)
 		kfree(array->array[i].string.name);
+	array->size = 0;
 	kunmap_atomic(array);
 }
 
@@ -613,6 +625,8 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 	int status = -ENOMEM;
 	unsigned int array_size = ARRAY_SIZE(pages);
 
+	nfs_readdir_init_array(page);
+
 	entry.prev_cookie = 0;
 	entry.cookie = desc->last_cookie;
 	entry.eof = 0;
@@ -629,8 +643,6 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 	}
 
 	array = kmap(page);
-	memset(array, 0, sizeof(struct nfs_cache_array));
-	array->eof_index = -1;
 
 	status = nfs_readdir_alloc_pages(pages, array_size);
 	if (status < 0)
@@ -685,6 +697,7 @@ int nfs_readdir_filler(void *data, struct page* page)
 	unlock_page(page);
 	return 0;
  error:
+	nfs_readdir_clear_array(page);
 	unlock_page(page);
 	return ret;
 }
-- 
2.24.1

