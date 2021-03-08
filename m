Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A60330D02
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Mar 2021 13:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhCHMCX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Mar 2021 07:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhCHMCL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Mar 2021 07:02:11 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ED4C06174A
        for <linux-nfs@vger.kernel.org>; Mon,  8 Mar 2021 04:02:11 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso2989499pjb.4
        for <linux-nfs@vger.kernel.org>; Mon, 08 Mar 2021 04:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pr0V1TZ4IZMgNZxMT8Kj2zpm8fKy0452pYLDI1HhhVc=;
        b=Zt1bCYIz4rKuFaVK69L2KHDQxHNzacVJp/Ts+vuRjsUHX3hfIC7wHZb8Nn6LY776st
         toYnAmy/pQ2dKCDnzvuDxFx5JWvC7x3VK7rxsCSkYUxkNhUbghqUmzTN8KH8Ki8P98qF
         0WwfnXUse8xTMJ5YhxAczy8ZwhmUFAE5qm63hiL/PQPLBW2QMqGOXJHTn3kSyXnWF7IR
         tjgCdnDxgGmYrM0x+Tj89Ini4Vb6betnMeCLmJItI48Nde8WRNpVHR6Wo2n972iSxhsc
         uYyBImbr/ni/odth/M1j3T9y9RIoSZN6ZkY3FThFDG+GR4ZCbBgjhhY0QibTU+fdOA3Q
         MmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pr0V1TZ4IZMgNZxMT8Kj2zpm8fKy0452pYLDI1HhhVc=;
        b=YN1qCrvwH1n2bu1EjQIL2V/Jv+nfFlf9c37ypbmbgdWxwk/RiuOm1IvNEHc/lJonfc
         YuS9rBlNJ6y1R+npfhTl0jvTHCN6fuKc3mcm4HofsTXqdY8kV/GC+f8P2L+roJye/USV
         PcMK5qJhOxhh2GqWi4yg/Xd0TAYc2VXqIusc3//QR93ObLgQ8GL+xhSKrm9Q5Ritqw//
         GndSPYuUNwPXHwk/mszMmzOo37O0aETbqOkW3VyZb+4kySTvEcKHFu2mB+WowY0umd3y
         /UG6IRBvTit9obFFd0FeBIIqjbpfRgyQOOhBtyB+Xiu1NQey5eeryPHL4OFqTSS0QDCP
         EL/A==
X-Gm-Message-State: AOAM530xVyjydkzmu6HYMQetbEzSsePkocgiA9w1m99ngJ+EJf1v9xP4
        FtTS4xKTFIO2pV5mWLorRN74HOGbqoLpnA==
X-Google-Smtp-Source: ABdhPJyvOlX0ClSE5QISEfN3QNvOBaSwNAS8uoMTEvLIgi6+9RC1nkVTrI6J1nlEb8VppojYhSfR/A==
X-Received: by 2002:a17:90a:2c4b:: with SMTP id p11mr25580140pjm.75.1615204930553;
        Mon, 08 Mar 2021 04:02:10 -0800 (PST)
Received: from localhost.localdomain ([103.51.75.230])
        by smtp.gmail.com with ESMTPSA id j20sm11292690pjn.27.2021.03.08.04.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 04:02:10 -0800 (PST)
From:   Kenneth D'souza <kennethdsouza94@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, Kenneth D'souza <kennethdsouza94@gmail.com>
Subject: [PATCH] nfsdclnts: Ignore SIGPIPE signal
Date:   Mon,  8 Mar 2021 17:31:57 +0530
Message-Id: <20210308120157.36053-1-kennethdsouza94@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fixes (RhBug: 1868828)

Signed-off-by: Kenneth D'souza <kennethdsouza94@gmail.com>
---
 tools/nfsdclnts/nfsdclnts.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/nfsdclnts/nfsdclnts.py b/tools/nfsdclnts/nfsdclnts.py
index 5e7e03c2..b7280f2c 100755
--- a/tools/nfsdclnts/nfsdclnts.py
+++ b/tools/nfsdclnts/nfsdclnts.py
@@ -223,6 +223,7 @@ def nfsd4_show():
 
     global verbose
     verbose = False
+    signal.signal(signal.SIGPIPE, signal.SIG_DFL)
     if args.verbose:
         verbose = True
 
-- 
2.29.2

