Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB5AC122CF2
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2019 14:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLQNdg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Dec 2019 08:33:36 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40278 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfLQNdf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Dec 2019 08:33:35 -0500
Received: by mail-pj1-f68.google.com with SMTP id s35so4595723pjb.7;
        Tue, 17 Dec 2019 05:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=44FjkOn/XLQ+zFbEeie+qKzDhgYPpksuKEmuM6SY0/I=;
        b=KEu6GFBqmNG75zG+7przID6KXw0HQFuiUppkDgzIlWE2qT3An6oQ1vSrurEma9+Gb0
         ipZtrAmgrDptjpW0ECWaTJ+RLq45ng9p24QjN8P17nScRfQZZhWD8CHztIWpuvV4CxHM
         QtPvvhFy/jd8MHFXStxNJ47HVUq2nrK3SbY1elm0enS0BVvYKGTaQy3C2S9YwnrznQHk
         LhZenTNkPIxi/1hOWb/dHM0l2Sb2Du+s8lqpLx+A9k9xuZtTwbw+VKFe2hpaiJ1eJCCg
         8ws9qjAFfaAPpaKATNpzVG4KA1q9IZ4uNaGuA+qX2tCI5zp3nzdWc1nN21l6RxV0p6AF
         xwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=44FjkOn/XLQ+zFbEeie+qKzDhgYPpksuKEmuM6SY0/I=;
        b=snpVa/RSJAqebgn1Fdq5tZlWVUUY0IMvhKHqqTteyN0innCWjvFiiKauH/NSpGFQGa
         iluC+5zY2miDhxHbgCQxTFt4E8xcsO6p23y9S4DIPN4x6SGoGridAQrxHyxqVQWMcTZH
         X1mpHCHfSu/THJn7joeYQmFR0vX0rsVUpTFLurZvbx0XBYm7AUh6UbRACk+f4Bbp6gYG
         DesD7wWVy2rD5iYv2cIbqKZV5w/5mOTaLYqrZDcBDHytBmm9/Xyi91hZgMx6E230j1dS
         j9cT09NKiYeEszXoA8myE1bB+gVr6uqQuSCKGbqJblc40FnYi3Cw1/PnKO4agX/rAr8/
         kl9Q==
X-Gm-Message-State: APjAAAWdjbQQD/YKatBp+Gu79eOJkhN0Rfc4bU3uvIXfxT2yqIicIIRt
        j34HZex6JHw6tQCMYEut+WY=
X-Google-Smtp-Source: APXvYqwmroYp//z/XHkQUr6PxhbEQKH1be7LwohqimmimSV+Vml4gldj7Xb9tUuBFkW3WeBWY3y2uQ==
X-Received: by 2002:a17:902:724b:: with SMTP id c11mr22367771pll.177.1576589615158;
        Tue, 17 Dec 2019 05:33:35 -0800 (PST)
Received: from oslab.tsinghua.edu.cn ([166.111.139.172])
        by smtp.gmail.com with ESMTPSA id d13sm3367619pjx.21.2019.12.17.05.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 05:33:34 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: nfs: fix a possible sleep-in-atomic-context bug in _pnfs_grab_empty_layout()
Date:   Tue, 17 Dec 2019 21:33:19 +0800
Message-Id: <20191217133319.11861-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The filesystem may sleep while holding a spinlock.
The function call path (from bottom to top) in Linux 4.19 is:

fs/nfs/pnfs.c, 2052: 
	pnfs_find_alloc_layout(GFP_KERNEL) in _pnfs_grab_empty_layout
fs/nfs/pnfs.c, 2051: 
	spin_lock in _pnfs_grab_empty_layout

pnfs_find_alloc_layout(GFP_KERNEL) can sleep at runtime.

To fix this possible bug, GFP_KERNEL is replaced with GFP_ATOMIC for
pnfs_find_alloc_layout().

This bug is found by a static analysis tool STCheck written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/nfs/pnfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index cec3070ab577..cfbe170f0651 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2138,7 +2138,7 @@ _pnfs_grab_empty_layout(struct inode *ino, struct nfs_open_context *ctx)
 	struct pnfs_layout_hdr *lo;
 
 	spin_lock(&ino->i_lock);
-	lo = pnfs_find_alloc_layout(ino, ctx, GFP_KERNEL);
+	lo = pnfs_find_alloc_layout(ino, ctx, GFP_ATOMIC);
 	if (!lo)
 		goto out_unlock;
 	if (!test_bit(NFS_LAYOUT_INVALID_STID, &lo->plh_flags))
-- 
2.17.1

