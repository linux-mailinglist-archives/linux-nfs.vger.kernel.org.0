Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81203B4F5D
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Jun 2021 18:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhFZQC6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Jun 2021 12:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFZQC5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Jun 2021 12:02:57 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44147C061574
        for <linux-nfs@vger.kernel.org>; Sat, 26 Jun 2021 09:00:34 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id j184so22533456qkd.6
        for <linux-nfs@vger.kernel.org>; Sat, 26 Jun 2021 09:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HLUYZsZzrZ3h/Ru080tS2qgUNHhWDl5eUAcDVUG7NsE=;
        b=VpDGFZGL7mLdMnJv+F2UhxYbKg0E2Li1Lhsh7l+XHWzmDZ3BlQZ9nln/Tflh8ohOah
         QzsadGEC0LpesgxCb7yj97eZI7NJVm6xwDWHXKhd4RpMk6Bpoe7NGun7mNJupXya9+W8
         pA6ggY+MA6jJcGMKCrlROIBBGm8sPlELz26OsOe+wqn+MDmst3rlA0nwbeh7i3N9BJbf
         hRc7l0cs8hMCcZ4VABuASD5yQgKM1DTvwYFe3tw4JHtRTlCbGaXcQSGaOpK6Oiofirq+
         dtwh3VtZonui+rUEMvDrKIIh2VETC9upRHLVZawjkmF/emdoRnPvoGqCY8EWCefqHX98
         5J8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HLUYZsZzrZ3h/Ru080tS2qgUNHhWDl5eUAcDVUG7NsE=;
        b=HH9eqa3FC+aJXt3M/cxkgzGDLT/20SldOdOuBp+hI1BJTexZ3MiYZSelM3DXxnuxLO
         Z0ldUTXJDG4sxK+X0dP/o+dmScXgiSNB5ZYBLkK4Nkcj/MigBxuh+7JTcLWmqSXqq6ZL
         SW4z1exECPjc0aX0p2HUT7apvF3m09EX4gGpncD33EWE0lM/CbnxcpdQPj74V7lenKcF
         Er1Pe+E1iV6/yxkdePr4aAWu5cOhYe31ETFaAgkn08a6hfrK/MWAspG0s3Eprty/nEaT
         AUan7thqeTh88u1PLUFXLfwoVyzu9beBRTREPFOqdOFqDw0XuW4LCQ6Xvru4/UbP6hy1
         DQ8g==
X-Gm-Message-State: AOAM533xwDB4Cake7hlZ9FFX9Cz0bdn2lhC5KbD6WCKu64x4sNHcmzPk
        XGt86+QFXtEUH+NdH4NfmLiB9Pq8U5pE
X-Google-Smtp-Source: ABdhPJxb3a81eW41WUMkoP1rwpubAYA/Hqchwkdbwy8hI9rJzy8hhDO8CChTEg5qW0VqYjQ8/tGvGw==
X-Received: by 2002:a37:b6c1:: with SMTP id g184mr16760514qkf.270.1624723233001;
        Sat, 26 Jun 2021 09:00:33 -0700 (PDT)
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id 145sm379417qkf.65.2021.06.26.09.00.32
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 09:00:32 -0700 (PDT)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: setlease should return EAGAIN if locks are not available
Date:   Sat, 26 Jun 2021 12:00:31 -0400
Message-Id: <20210626160031.323153-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Instead of returning ENOLCK when we can't hand out a lease, we should be
returning EAGAIN.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 35df44ef2c35..e4efb7bccd7e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7452,13 +7452,13 @@ static int nfs4_add_lease(struct file *file, long arg, struct file_lock **lease,
 
 	/* No delegation, no lease */
 	if (!nfs4_have_delegation(inode, type))
-		return -ENOLCK;
+		return -EAGAIN;
 	ret = generic_setlease(file, arg, lease, priv);
 	if (ret || nfs4_have_delegation(inode, type))
 		return ret;
 	/* We raced with a delegation return */
 	nfs4_delete_lease(file, priv);
-	return -ENOLCK;
+	return -EAGAIN;
 }
 
 int nfs4_proc_setlease(struct file *file, long arg, struct file_lock **lease,
-- 
2.31.1

