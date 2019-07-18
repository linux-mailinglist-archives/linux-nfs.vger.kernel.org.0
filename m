Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C526D4E6
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2019 21:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391429AbfGRTms (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Jul 2019 15:42:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33955 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbfGRTms (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Jul 2019 15:42:48 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so53532477iot.1
        for <linux-nfs@vger.kernel.org>; Thu, 18 Jul 2019 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8EK2BN7EF3ryTIByj8S+QvddRWxtTWc6a0W7edIyZM=;
        b=TlgLiDV+a/jZggWwpAg87xtoSviaVTXz/Sx2aaG4XP3BFJuuE78lFBcZQn7+Z571ca
         dvYlDL5ygsZU1osnuvAEO3U4gMZEGs5oF35aL4kojyL7iC48RvT23r8tqSmoeolFo3ta
         sZRCsWtskyjekqXkmI+V2bc33sQ/H3RJqhmcROGEvN6yH2g8LOEb2qVwrGeFefejDKhw
         +A1wdpNdicw726iu5xnt9xr6RqQpGt/1C1AeN7jYjBD98QNZzXcYApRvje4IgN58jtk+
         fM2FUOYZLEMnPmbF2HnsJgHtzieEcsxstAgXaWcem9Dwf93sfGFOYTClCOYuAmLA7sXn
         M9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8EK2BN7EF3ryTIByj8S+QvddRWxtTWc6a0W7edIyZM=;
        b=fU3GMEEtQLjoboWeNzDdfMHAsW9Fx1l7jb/2yoH4Jfs3l4l63RjCyeTgNItOsvX1eD
         2l36zYGEbo9wiZGMg4usT3EDiJt7ne3MrtN6t8G/0+Op1IcWYrQYXXHF9NNqj5peUbFY
         84n4RpiQ4KBGmcos2NTJEjhvRPuvS/4YYVMn6zHmGPNeengdrucvrq1q0CT7MklI4ppz
         ayYebO7KRdmvOWBZI5UKeth6kqF1q58Rqr81o9hrBt8jCycxOoUEkpwSa4MlPtVyMWAJ
         iL0nEr/Lv5QU0OVX00oqNNGLD0v2knkqlK7mwPbxp7Eo5hbKvh34gxC0xXswp3o2oI2k
         QpKg==
X-Gm-Message-State: APjAAAUDLF0RHGwghnUaw1o6kjQ+NvtPKNpT378hdhxWc7NqxbapocEr
        Otiep6AjZphEprx47zjAYNZL0dg=
X-Google-Smtp-Source: APXvYqwVc7zt1ZmTi/bDmo3aLTXH9jq49b8UO/PfY0BqDox4G9dKX2hk7cjuZ++Fy6Y5JWrUZSMMhQ==
X-Received: by 2002:a6b:fd10:: with SMTP id c16mr42546452ioi.217.1563478967034;
        Thu, 18 Jul 2019 12:42:47 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l5sm52325003ioq.83.2019.07.18.12.42.46
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 12:42:46 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] pnfs: Fix a problem where we gratuitously start doing I/O through the MDS
Date:   Thu, 18 Jul 2019 15:40:39 -0400
Message-Id: <20190718194039.119185-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the client has to stop in pnfs_update_layout() to wait for another
layoutget to complete, it currently exits and defaults to I/O through
the MDS if the layoutget was successful.

Fixes: d03360aaf5cc ("pNFS: Ensure we return the error if someone kills...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v4.20+
---
 fs/nfs/pnfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 5b9145c62fd9..758917463700 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1890,7 +1890,7 @@ pnfs_update_layout(struct inode *ino,
 		spin_unlock(&ino->i_lock);
 		lseg = ERR_PTR(wait_var_event_killable(&lo->plh_outstanding,
 					!atomic_read(&lo->plh_outstanding)));
-		if (IS_ERR(lseg) || !list_empty(&lo->plh_segs))
+		if (IS_ERR(lseg))
 			goto out_put_layout_hdr;
 		pnfs_put_layout_hdr(lo);
 		goto lookup_again;
-- 
2.21.0

