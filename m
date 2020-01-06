Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C93BC131983
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 21:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgAFUlt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 15:41:49 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43306 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgAFUlt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 15:41:49 -0500
Received: by mail-yw1-f66.google.com with SMTP id v126so22432769ywc.10
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 12:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wGKLTZMxUHOF+/ibDQFnumnXJ6MknJqMAGpza9xgVW0=;
        b=evgDcEmXa5wXV1NyboOhQtRit37ODbj6PLqbdXc5ZfbEDuU1v+TVmmhpBV20McDUmS
         /CoIEnsHTVA/rmwyTGUHjGKewVugRou38ErpP1m60kYvvlhsf28aMAehPCBWsu7vebUk
         7peHFJDmAw7+q7TrEc9dBHwfBwJNYyyPQc4TvNIxjSBze45+ZhPm1PpGs57ANOCEiiYp
         CK5kjIt+efjgH7R2HI3LUwB1OnAA1+VDzZ5w7RFlqidcJYvJgv7qNuaHmK+kyZ4awukT
         AImZfy4bprx3QIg3Tm/kHsUseoSEUaBN8C3VXoPmTpvSZUh/lR0oKvLppk4gQQScdISS
         rxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wGKLTZMxUHOF+/ibDQFnumnXJ6MknJqMAGpza9xgVW0=;
        b=nx1eCVxhWtmNVk2kH37wfmIOUOFUFXBMW6tZE9+y/d9H2PGCqi4hRI+Mie56khSZYC
         Qi7SNPINwNDKDYE14UeMFgFYWZER7UdszaipdF3Z34x/ODam/aJ4IdgdK9JAZd9xaMqV
         eGOcbxMUNhBEaeAkKu9GLBJK0/3OE3+tSOFb04ZlmTlqoh5BFATEtpBzFFLD3AF4ObSa
         I3fNLwW7NjqfmBo2eWlOCY6YzP0DiA1FwMdQwO+jySEZaYM/78dEhEIE5hJKMq1NV9MQ
         vbv8QYO6FlY157huVb3uRAZ/Ukjqo5Kx07SvGGHZf2jmaicbNpul4L2YoKIRGsNnzH66
         QYZQ==
X-Gm-Message-State: APjAAAU1Y4a5FyVWQ5Yr5Qbkjp6z6Y9Yi/sTsFVKBaOHSqCGBju6gG2F
        jVrhnZwlP9wF3j3aGIhiEywcffEQ0A==
X-Google-Smtp-Source: APXvYqzzd2dOJomUEZI8APX6zv4BNk2DY3P1Xv6ZGOR/qNLE0PzGX2pFbqHN8HTdKGW4RGqeWHNQUg==
X-Received: by 2002:a81:a546:: with SMTP id v6mr78471593ywg.511.1578343307805;
        Mon, 06 Jan 2020 12:41:47 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id 207sm28082405ywq.100.2020.01.06.12.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:41:47 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFS: Trust cached access if we've already revalidated the inode once
Date:   Mon,  6 Jan 2020 15:39:36 -0500
Message-Id: <20200106203937.785805-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106203937.785805-1-trond.myklebust@hammerspace.com>
References: <20200106203937.785805-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If we've already revalidated the inode once then don't distrust the
access cache unless the NFS_INO_INVALID_ACCESS flag is actually set.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 372c16b3042c..9405eeadc3f3 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2312,11 +2312,11 @@ static int nfs_access_get_cached(struct inode *inode, const struct cred *cred, s
 		/* Found an entry, is our attribute cache valid? */
 		if (!nfs_check_cache_invalid(inode, NFS_INO_INVALID_ACCESS))
 			break;
+		if (!retry)
+			break;
 		err = -ECHILD;
 		if (!may_block)
 			goto out;
-		if (!retry)
-			goto out_zap;
 		spin_unlock(&inode->i_lock);
 		err = __nfs_revalidate_inode(NFS_SERVER(inode), inode);
 		if (err)
-- 
2.24.1

