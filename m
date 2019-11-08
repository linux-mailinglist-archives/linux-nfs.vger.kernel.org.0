Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1CEF5905
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2019 22:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfKHVC2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Nov 2019 16:02:28 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37643 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfKHVC2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Nov 2019 16:02:28 -0500
Received: by mail-yb1-f193.google.com with SMTP id q7so271237ybk.4
        for <linux-nfs@vger.kernel.org>; Fri, 08 Nov 2019 13:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z8ebJKohpb1s42CAw3G5otQLMnl5+nXFKve/m40i4Zc=;
        b=AsM6tvjqHXIWSExDWPRDmO5iTab7iaqhKOsSy4lr6JveVWHMHJYlDpa0ngyFQ0LalA
         qE9RH5w0+VqleGWu1Hh1/qs7dK0gshsuf4J6SbdUGjIUDerDTOngw7IoRWFsM9o08fTJ
         FceZRFizemMQu32fEfjzmX9WRg2BXZhCHWUH/2wsvUkALuDX68GxqKJn3227GJzbfvqJ
         0w1EFCEX2xuVBNtklmxR39bnSlHWBXhBLmMp75m66R/SI3XaqDOvIYdGQwTNWpyO8NUf
         h+AWRP7Xw3VolALEPyjkpTK4PdZ3KbL9LIZg5vaLPhxpOzbFNzNqsPn2lMrjaqwjdLIe
         cP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Z8ebJKohpb1s42CAw3G5otQLMnl5+nXFKve/m40i4Zc=;
        b=N12WC/TG5p8fNKP0MsvIAIc3cghK8vT0tT2cruLVOFc/Ifve2xhA0dsB/xTJf/W+F4
         99Xz+zaUTq2Qm8Bpit0k6B09FI92hOxzlURrLnNpQ8ZXqF1I6PpqiK3IBKavQSQ4T5aD
         gm1iauPYRUqjoFp1xFDyMEYkGY37wRjkutgY/KzeDU+7D8Qc/YtlAqiXQhFHzNVgDhdu
         9di8r48HXdZ4jVSlP93U8wHdj+qTMjsjMYlgc5ij+6EU9NqXxYXwsAYk1X1fyeCx50jG
         pQrJAuGtc76SYQ+aGPLZHCrbQwQmEyEPS7AL0aI2/aaYLHEXfORSwhefLN+3kekvSPe6
         6M1g==
X-Gm-Message-State: APjAAAU84Prb9amOZqP5TSyts5jb8fL9evrpLpdYFO4YESbnKLfnTJRo
        Lo51a+IZamcxQpAG6NNhMO5kD3QL
X-Google-Smtp-Source: APXvYqycGWcmeX+AeB8+zeoOrznt8NdEaNzPG9JhTwX6vvHE2svioAWmzUerQWn3kpkwCwmmLyPBQQ==
X-Received: by 2002:a25:ca07:: with SMTP id a7mr10872148ybg.340.1573246946597;
        Fri, 08 Nov 2019 13:02:26 -0800 (PST)
Received: from localhost.localdomain (c-68-42-68-242.hsd1.mi.comcast.net. [68.42.68.242])
        by smtp.gmail.com with ESMTPSA id p126sm1904033ywc.16.2019.11.08.13.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 13:02:25 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 1/2] NFS: Add FATTR4_WORD1_SPACE_USED to the cache_consistency_bitmask
Date:   Fri,  8 Nov 2019 16:02:23 -0500
Message-Id: <20191108210224.33645-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Changing a sparse file could have an effect not only on the file size,
but also on the number of blocks used by the file in the underlying
filesystem. Let's update the SPACE_USED attribute whenever we update
SIZE to be as accurate as possible.

This patch fixes xfstests generic/568, which tests that fallocating an
unaligned range allocates all blocks touched by that range. Without this
patch, `stat` reports 0 bytes used immediately after the fallocate.
Adding a `sleep 5` to the test also catches the update, but it's better
to just do it when we know something has changed.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ac9063c06205..00a1f3ec7f22 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3775,7 +3775,7 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 
 		memcpy(server->cache_consistency_bitmask, res.attr_bitmask, sizeof(server->cache_consistency_bitmask));
 		server->cache_consistency_bitmask[0] &= FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE;
-		server->cache_consistency_bitmask[1] &= FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY;
+		server->cache_consistency_bitmask[1] &= FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY|FATTR4_WORD1_SPACE_USED;
 		server->cache_consistency_bitmask[2] = 0;
 
 		/* Avoid a regression due to buggy server */
-- 
2.24.0

