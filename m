Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B822CDF9D
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 21:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgLCUT0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 15:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgLCUTZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 15:19:25 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9FAC061A53
        for <linux-nfs@vger.kernel.org>; Thu,  3 Dec 2020 12:18:45 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q22so3400827qkq.6
        for <linux-nfs@vger.kernel.org>; Thu, 03 Dec 2020 12:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WtxAoLGt1uk0hZ2EXOqGreitEccXumouSJeNLPddMUs=;
        b=sbnbYPQR0LzpCq8NmhQGbrp7d9/D4KmAAS0ZEm7+wjgdbs2yNjVvmm5iHSZAqgb4br
         rAFudVHszPiC2dVFPTqRk9v45NrTosyGdtj33R6wWyE0yZWJd519iJN40Y+xsFHyt+xf
         3UtFy3ENeKkV66/2aBqbPDKXabijWMf9imXSD0bDJp9A12mZ1PoCAnCEWM6YgidD2LZQ
         YXym6ixVvfD6XxYZvSqV2CqXuNsystYwMlJ5h23zUDzKMGTz+DpfGNjzTgcqc8nPE1/i
         PAFeNQVTR3QPW3WKXCUraeTl40C2cfVYiDffOrw+xdrjDP/wugD6LY5FbXL6Z+rY1/V3
         PfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WtxAoLGt1uk0hZ2EXOqGreitEccXumouSJeNLPddMUs=;
        b=ZwTyihOho58LMYlypkiznMOgp8fi5nsJ8/KCZoV6KICYkF+Ptm1dnFuFgY1LXVy9y3
         ZZkG8NUXtSCT5RMqlC1StrwHv3UQIRJQKHSX+o3g5QcPrKM8ooT8OP20NzZdlh+K7z9l
         qsOfNbzFAGLEKeAN3kIZeY4+YLRZ7ERWA3jK0/CfXhbMBwjleDxpA/fREQ+8n87RHLNx
         W6VukClP18/QrEYHkRMVUjD4pAol+UYCiMC6AHFwnB3wrNjw8BsLWGzxjvAnkx33fTFE
         +s+83prF25CrKmvo2dc4uq8l6sECtMj0kYI/GYU4gpYAwlJbIEUoW2bOy92GLri6mDFC
         sk5g==
X-Gm-Message-State: AOAM532ueM/GotiHgDBN85OF9i/yzsq30m2cjz0f9BVerhxaB+n9TvYE
        iaLTDfAy9Ws7yOWTHUeT7nlCvW88sw4=
X-Google-Smtp-Source: ABdhPJx8ucIfUFgSNFNw3bUWSQ+wBgowhS9hmRft/hASZKa13zlmj5jGeoYddwhjJzi2VC2MbhGWEA==
X-Received: by 2002:a37:ac19:: with SMTP id e25mr4681087qkm.344.1607026724516;
        Thu, 03 Dec 2020 12:18:44 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id q20sm2194530qtn.80.2020.12.03.12.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 12:18:43 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 1/3] NFS: Disable READ_PLUS by default
Date:   Thu,  3 Dec 2020 15:18:39 -0500
Message-Id: <20201203201841.103294-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
References: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We've been seeing failures with xfstests generic/091 and generic/263
when using READ_PLUS. I've made some progress on these issues, and the
tests fail later on but still don't pass. Let's disable READ_PLUS by
default until we can work out what is going on.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/Kconfig    | 9 +++++++++
 fs/nfs/nfs4proc.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 88e1763e02f3..e2a488d403a6 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -205,3 +205,12 @@ config NFS_DISABLE_UDP_SUPPORT
 	 Choose Y here to disable the use of NFS over UDP. NFS over UDP
 	 on modern networks (1Gb+) can lead to data corruption caused by
 	 fragmentation during high loads.
+
+config NFS_V4_2_READ_PLUS
+	bool "NFS: Enable support for the NFSv4.2 READ_PLUS operation"
+	depends on NFS_V4_2
+	default n
+	help
+	 This is intended for developers only. The READ_PLUS operation has
+	 been shown to have issues under specific conditions and should not
+	 be used in production.
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9e0ca9b2b210..e89468678ae1 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5309,7 +5309,7 @@ static int nfs4_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 				    nfs4_read_done_cb(task, hdr);
 }
 
-#ifdef CONFIG_NFS_V4_2
+#if defined CONFIG_NFS_V4_2 && defined CONFIG_NFS_V4_2_READ_PLUS
 static void nfs42_read_plus_support(struct nfs_server *server, struct rpc_message *msg)
 {
 	if (server->caps & NFS_CAP_READ_PLUS)
-- 
2.29.2

