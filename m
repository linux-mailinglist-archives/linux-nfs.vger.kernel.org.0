Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEACE2736
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2019 01:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404604AbfJWX6P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 19:58:15 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:36014 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404433AbfJWX6P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 19:58:15 -0400
Received: by mail-il1-f193.google.com with SMTP id s75so10887479ilc.3
        for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2019 16:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tn1GwUnFN+9fNysXf8S2SeglI6pzUZKhCexEJ7h+6JM=;
        b=jFWMUQO4iG6BAeP2LghwOjIOfJkOO5UdcdPwbZxVi7wOjGZwVIlVZqKMxGm4ZqwTDB
         RDGu7hC9VEV/C79cfTN4KB+tS0rZjP0vfnxgjbKAVz0QPaSHbeoVOBY1+5SCenj6rcRT
         Xy5LcWzKQS6gCXkZfRrzFLMD/rW509XWKDmWwLm4Qxm81SrkfZLYAdpvEwBx4bQSEpOU
         q8GBD1GPrGR2vu7MsyQlBKeQXVIJoMCupYpya7MT4IMihZe0QB40/YxOmpWbsvEmyH2X
         +F79JB4WU4eB2YIt2Md/0FlBYSVtoygHpQ420Jt/eGmP80ljRNrHP3AYTL62bMLlj7bL
         o6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tn1GwUnFN+9fNysXf8S2SeglI6pzUZKhCexEJ7h+6JM=;
        b=TkROl1cl/wNoPOxOQwozMrLcDp5h9uMJYtLWW/5uxGC3GDWCHxkbzoPXtuWmtqgzXm
         vmNXeH2QuSdmbYYtjWcKXnFR/E8HtiiSnS5xLs6S69JxvCq6MhAUHYL/mu5IIYoPeXcR
         D0Mij45GZ+NUunIAounylJfV7AcINJ+d6siBnMjLohipLL4GPGcytrnwTkXP8f4K6UnO
         pCX4z2jJ9v1rEOIzoRAuf8EOShk0P94Qqq+Mf5RLiXSdt8997px2OH/3PdTH0+umqhdw
         vfks9HpqouizgCeLnYNHg/qUZxuM/7MLV5PaC8Tyo4MbGeHnlxW0GoQBk0JT39IzSK8t
         TtoA==
X-Gm-Message-State: APjAAAUgoMNPkwmKv3cUp4rQcS5JcFeUY0nQZO8xmraV/iINOR1XXPx6
        4Mbt+GskcNrXWyUrxFb5fVlGCjQ=
X-Google-Smtp-Source: APXvYqyXMIOU0pL/xD2PrcnVkIyoy04qp08VWhXRc4V3+lVvuJz4VS7R+5SXkeZzjH5AZS6itmo60g==
X-Received: by 2002:a92:9f85:: with SMTP id z5mr22275395ilk.214.1571875091984;
        Wed, 23 Oct 2019 16:58:11 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id z18sm2405409iob.47.2019.10.23.16.58.11
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:58:11 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 03/14] NFSv4: nfs4_callback_getattr() should ignore revoked delegations
Date:   Wed, 23 Oct 2019 19:55:49 -0400
Message-Id: <20191023235600.10880-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023235600.10880-3-trond.myklebust@hammerspace.com>
References: <20191023235600.10880-1-trond.myklebust@hammerspace.com>
 <20191023235600.10880-2-trond.myklebust@hammerspace.com>
 <20191023235600.10880-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the delegation has been revoked, ignore it.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/callback_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index db3e7771e597..58a77c41ff36 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -50,7 +50,7 @@ __be32 nfs4_callback_getattr(void *argp, void *resp,
 	nfsi = NFS_I(inode);
 	rcu_read_lock();
 	delegation = rcu_dereference(nfsi->delegation);
-	if (delegation == NULL || (delegation->type & FMODE_WRITE) == 0)
+	if (!nfs4_is_valid_delegation(delegation, FMODE_WRITE))
 		goto out_iput;
 	res->size = i_size_read(inode);
 	res->change_attr = delegation->change_attr;
-- 
2.21.0

