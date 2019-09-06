Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6DCAC0C8
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2019 21:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392363AbfIFTqp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 15:46:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46813 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392364AbfIFTqp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 15:46:45 -0400
Received: by mail-io1-f68.google.com with SMTP id x4so15340713iog.13
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 12:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iqb1sMJUZdYvSisERxCuRomsMh4ef2iO2SKKCvgRqNY=;
        b=gf1SQzbXY5KP0xRsp66vYlnOBb/sonhm4bSQpyz9wz0lPr4WXziT8ay4YsJkd0Ha9M
         asva1rgLKCwsQxhL4/09D4NAbHYQfCHxlt5ygi1n1uWClXAhKj8nrQQ/ARo2Go0/w8cT
         fpmN7/aaR0TrlIN9FLZZGY1uKDH5nVLqi0IW8dmZaRuCMlMBno3RhKhArpF1BYpKz70i
         XZV5dXsFvfnh36jt+f8HW/gQvMlY2JoZCHZrJsWcF4tzRMMyhJUuR31ozqSvhq6Bhat+
         uZrCM0/pV0nxRAlPRor1NO7bIqTHLWTCnQC2QKL7YeIcbKXUM47y1KSm1pDZS5rma/p/
         GbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iqb1sMJUZdYvSisERxCuRomsMh4ef2iO2SKKCvgRqNY=;
        b=lQdBldU5P1QUPxJ33i0q7+IuXPtu0B0UiM33Te7CddPfX6mFuLrabk4NjwyX2VkBm9
         cYIXdk71ou+pzaOF231isxtMppE63fDyhiznCKVZl5O4nnFEgDYoqrVHi+HMkS1dxEhq
         nCALeZnY8BM9qtjhB+hJNI6Z7z7fvhaP1izC7fFqQxfwW3sjqOUK9mYHWWa/JUa5K4yr
         XFNuJBK73mwFdYeBWKH1QxpRzCN5DZw8mDn3zofBFauI/FeDlF9s1GUaQV+8iXp6jSad
         hjXuGeVn8VpK1/nEBOiu9kIsKntaBxWv+Mu6r9ro3fiLokPUjYB04f/6Y5f7Gm/fmvQi
         8Zyg==
X-Gm-Message-State: APjAAAXxbDsUa41hTS5sg8chGGMUn6qf0GrAsUWyYt8rkXX/CJYjmNMw
        gS4TnwZ8qNhoV3zmEseVIIGtcDPBBTQ=
X-Google-Smtp-Source: APXvYqzIK4GYoTXFPGkziwj0AJdBuG4KytUffdUfDuK9PsR+imrr+KpsNMNT/7Qifpt82dVycqjWLQ==
X-Received: by 2002:a5d:8919:: with SMTP id b25mr1745048ion.123.1567799204600;
        Fri, 06 Sep 2019 12:46:44 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id i14sm5118085ioi.47.2019.09.06.12.46.43
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 12:46:44 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 10/19] NFS: replace cross device check in copy_file_range
Date:   Fri,  6 Sep 2019 15:46:22 -0400
Message-Id: <20190906194631.3216-11-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
References: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add a check to disallow cross file systems copy offload, both
files are expected to be of NFS4.2+ type.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 2af30b7..37b13cf 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -140,7 +140,7 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 	ssize_t ret;
 
 	/* Only offload copy if superblock is the same */
-	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
+	if (file_in->f_op != &nfs4_file_operations)
 		return -EXDEV;
 	if (!nfs_server_capable(file_inode(file_out), NFS_CAP_COPY))
 		return -EOPNOTSUPP;
-- 
1.8.3.1

