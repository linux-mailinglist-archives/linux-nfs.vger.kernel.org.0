Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478FC38933D
	for <lists+linux-nfs@lfdr.de>; Wed, 19 May 2021 18:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354662AbhESQIB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 May 2021 12:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241402AbhESQIA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 May 2021 12:08:00 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64231C06175F
        for <linux-nfs@vger.kernel.org>; Wed, 19 May 2021 09:06:38 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id i19so3981584qtw.9
        for <linux-nfs@vger.kernel.org>; Wed, 19 May 2021 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ABQSCOiAx8sP7bI/fYWSDYSKdYlbSgdJ7avJl4yXd1k=;
        b=RyegpgjhjKExhErX1ratoYdxjJaSLLgjzAPpyxRfRmkC6VGJ2lF10jezBGyd3InD6Z
         QZD8rnZn8dZTSuL4uwRh0fS3ztK+EoosOcUozUu6zv83KjzFCfG8qa9GBh5LFbvCaxGJ
         DpF5+EUUeKATtoh/RXv9ulqFFXuzyoiIDdcMOaAAVslpvRWK6T6VEO7Zy4aTabAmgV8Q
         BZc6h581j9ZUzFHAN9ry/K0OFbMDQhYTwUfcpe9lT41DyHFMmzkGFFHTnsaboKWF2Of8
         cpntyjhtNUhCBeo8zy8iLgYEuysvts7cCy9J3GSTaw6KOvmPHbMw+gx887SPgahRkIoh
         Sm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ABQSCOiAx8sP7bI/fYWSDYSKdYlbSgdJ7avJl4yXd1k=;
        b=g5cxustHQFePOlSHNN873Paso8tT3I4bUXHudfpYPVvG2EgU2AF+oeoqE6gYPDhP5b
         +HrOBSdhoGq2NOA3kyS5furkmeKZxaaCWFfLD4kONv6nlUU8S1BIHD0D32VLQPvaE/T9
         vk7phCDe/UI5nDrW5PyNadTRssQxUjO+8otcz7rkMUjpBwuAi5rkXEYdEFDBP54Iu46B
         bZj2rJkZWUZmqm+ioo5Kz0cA04HU1+Y8Y+i1S6+O/gof4THV8/s1+cEOxQDPrcFTst3C
         Ue6jPFSxTRz53e49cjP3YmiEv+CSzzhmmaxtq6qZ8xRPt3hw5URzvy7cA7AckHHWLjZY
         W6MA==
X-Gm-Message-State: AOAM531XtSMMeYs4RJGL/Ohn4erD5BK057kmOKIJplRcD3Mj8NeKBTPm
        sxQRgNr0qFuXqTNTHwTw0Rw=
X-Google-Smtp-Source: ABdhPJwYMAGcRMq0GLvwcPUFUzV0H3T1UIlkZi1E5MMKBFOPd9DLTE/JNwl5V65ohISo28ctxuENUA==
X-Received: by 2002:a05:622a:11c3:: with SMTP id n3mr111359qtk.211.1621440397338;
        Wed, 19 May 2021 09:06:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id e128sm58287qkd.127.2021.05.19.09.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 09:06:36 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH] NFSv4: Fix a NULL pointer dereference in pnfs_mark_matching_lsegs_return()
Date:   Wed, 19 May 2021 12:06:35 -0400
Message-Id: <20210519160635.333057-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Commit de144ff4234f changes _pnfs_return_layout() to call
pnfs_mark_matching_lsegs_return() passing NULL as the struct
pnfs_layout_range argument. Unfortunately,
pnfs_mark_matching_lsegs_return() doesn't check if we have a value here
before dereferencing it, causing an oops.

I'm able to hit this crash consistently when running connectathon basic
tests on NFS v4.1/v4.2 against Ontap.

Fixes: de144ff4234f ("NFSv4: Don't discard segments marked for return in _pnfs_return_layout()")
Cc: stable@vger.kernel.org
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/pnfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 03e0b34c4a64..6d720afb7b70 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2484,12 +2484,12 @@ pnfs_mark_matching_lsegs_return(struct pnfs_layout_hdr *lo,
 			set_bit(NFS_LSEG_LAYOUTRETURN, &lseg->pls_flags);
 		}
 
-	if (remaining) {
+	if (remaining && return_range) {
 		pnfs_set_plh_return_info(lo, return_range->iomode, seq);
 		return -EBUSY;
 	}
 
-	if (!list_empty(&lo->plh_return_segs)) {
+	if (return_range && !list_empty(&lo->plh_return_segs)) {
 		pnfs_set_plh_return_info(lo, return_range->iomode, seq);
 		return 0;
 	}
-- 
2.29.2

