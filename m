Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392112FF3E9
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 20:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbhAUTLV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 14:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbhAUTLQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 14:11:16 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36279C06178C
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 11:10:32 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id y187so2444566wmd.3
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 11:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aMNz2gH7UxNlIMpRE6csGbkc/7AWCgBaNO5YjK32HnI=;
        b=G5L82w8qKLcm5WCQ5V3dwfM/sP0hRi3mZ92EYFe2texEKcR/80zQ0aTxApNIo5WT9/
         fAw0kfBrsV1YGeggTn+uOcYxdkJiF862EYkloFGClgLCgvq0ohjxrC5PpURLhPqVKwlV
         viRJLGpzkuUoKCqkFIA+FGeVcV2oPO4qtfdjNdmTEZUTuoaM/GrbW6ksmIx3u6W+H/Bp
         ZY235qTfPe2V3GW8TSRnrKSBvf/LTHn+SnfFGwf9Z+A7qsw+hEx249XvUGukByAqjIlf
         qNnGkCrJofRfg31GVdW5PLbUs2zYgut8lcXkL+KPNMHf+rlkIS8WzBUpsRYys33d/Gd9
         G1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMNz2gH7UxNlIMpRE6csGbkc/7AWCgBaNO5YjK32HnI=;
        b=k2p7JpzgH+hf1cFs/rDvGAEOBSWoEsGQTbNpu89FYaGOmpwM840qTEQ6HOF3cZRJ/d
         z4Y372/WQ7C6vYHDMuwlL8BvE8c2dBykdnlJJGDNVsAAa0rUePCEViSQxGPAN7Rk4MUZ
         niTfhVEwidackDmoJF7So/1Pu/R0E6SdM2zoZrnFvKaufu3X1+c4IKn6sVk54xLzJRSk
         b9gT2u5mFfjRPDapL+rbAUDoPuvsajgLRKSq4UydvIaTQo6OpkcKriPXuamwiduOozVw
         trD3G61V2FwnIA8Az+1hw0gZtqtkQjK8EHrwmWsRq29j7Nw5cr+QkiuKIKp6MPMRLe1h
         Ok5A==
X-Gm-Message-State: AOAM531UtmcjWK1F1Qji2GYzyIfcfjbFpOZnegLYUCcll5XWn67K4EK4
        xoWRPLr3GAFg6rgXbWm1kTC0VWnpydFgwxCJ
X-Google-Smtp-Source: ABdhPJzNbC/71ZWGR4TBblA3VVx3rrGpFf3gQ1ZD/HBCS7yqAbSWCqrdy3dlr0uCmN/Ywkq8h+WEsA==
X-Received: by 2002:a1c:808d:: with SMTP id b135mr690931wmd.157.1611256230667;
        Thu, 21 Jan 2021 11:10:30 -0800 (PST)
Received: from jupiter.home.aloni.org ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id d30sm11160353wrc.92.2021.01.21.11.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 11:10:29 -0800 (PST)
From:   Dan Aloni <dan@kernelim.com>
To:     linux-nfs@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: [PATCH v1 5/5] nfs: Increase NFS_MAX_CONNECTIONS
Date:   Thu, 21 Jan 2021 21:10:20 +0200
Message-Id: <20210121191020.3144948-6-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121191020.3144948-1-dan@kernelim.com>
References: <20210121191020.3144948-1-dan@kernelim.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This matches it with the new RPC_MAX_PORTS value.

Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 fs/nfs/fs_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 3d41ba61b26d..38682c99e684 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -28,7 +28,7 @@
 #define NFS_DEFAULT_VERSION 2
 #endif
 
-#define NFS_MAX_CONNECTIONS 16
+#define NFS_MAX_CONNECTIONS RPC_MAX_PORTS
 
 enum nfs_param {
 	Opt_ac,
-- 
2.26.2

