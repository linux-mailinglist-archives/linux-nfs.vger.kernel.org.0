Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9CCDB36B
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 19:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503076AbfJQRiD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 13:38:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34321 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503069AbfJQRiD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Oct 2019 13:38:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id 3so4836992qta.1
        for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2019 10:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EQCVmpQbShd7J6XF10Iggjgzbj/k5R7KYRToocgx48E=;
        b=B+KFLXGLr4dE2i2pMfBMdfrNrrAJJWh/mFKHhvSoRlwJnQN59LSYfTd0miJlko4Mbf
         PYXpWLpYRE+sYF146iFnnGNiC/eCMvQMQ9Oy9yyJm9PKKuugNfOkyBRc6o6HDWD4Fx0y
         2iDzyb9PBvWiKkjjXGM4OJX0erTaoFDJO3loMei5hxuRzxkb3neeFaQxAmXZy6Qlq4Lb
         RAvhgXk32Yn81wuuaZK0T5alQNuIdaCMrJCd6Xo9LEuEElZKQWhjdwd9odaf4D65NcWi
         H9l9y4FDLx6Z0PP8dZ+TOJtiNnG28BVtpZN1sv4sysKy5eUCME2PZ6U9Lusj6H+/km7Z
         1Gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EQCVmpQbShd7J6XF10Iggjgzbj/k5R7KYRToocgx48E=;
        b=BDjj/6vEwMxDGsjtOUz0i+Rm2N9NWBkoJCXKyaPsHNy+/sQbNVCONBr5AlJk1fomjo
         Fc5yU1QOrhYhe0E1UxdSqUbyRsADcETzSLK0pubIFdA+53QJAuAEcdpfVf2NIAUbq2Il
         x9viMFSibOcuEjSLw1FNmhXFk4xXyH9IMkGFHSiJXp0xbRqAYiWYWN6iovJeUr81sMiG
         sxXCNiYv1tp3j6HKgpG+tSYCVoWauxtrufKb9GAkmznUfNuD5yArJ8VGXSctO9KMxa4s
         NmUBJchVUKsg7iTlPXJz+CriCGcQl5V4BAYycOrl9QkmmxjhemkuGzTvV24QO2N2tpzM
         S/Fg==
X-Gm-Message-State: APjAAAVOlw9G0ByuIxTiLmYkZx/j/UgiaJu+UBbooCI4gt+/5kNCbd9N
        HP6zDBMd1KBtxy4IyWnYkaPBe0s=
X-Google-Smtp-Source: APXvYqwxn+zo/8NYNs7RtFU2HA26j7WIH3wBDSqZFhnmx+uCwkdnfV4clD81nunyrfQMPLUPcLm+Jg==
X-Received: by 2002:a05:6214:30f:: with SMTP id i15mr5134146qvu.213.1571333881338;
        Thu, 17 Oct 2019 10:38:01 -0700 (PDT)
Received: from localhost.localdomain ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id l185sm1768610qkd.20.2019.10.17.10.38.00
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 10:38:00 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/5] pNFS: nfs3_set_ds_client should set NFS_CS_NOPING
Date:   Thu, 17 Oct 2019 13:35:46 -0400
Message-Id: <20191017173548.105111-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017173548.105111-2-trond.myklebust@hammerspace.com>
References: <20191017173548.105111-1-trond.myklebust@hammerspace.com>
 <20191017173548.105111-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Connecting to the DS is a non-interactive, asynchronous task, so there is
no reason to fire up an extra RPC null ping in order to ensure that the
server is up.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs3client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index 178dc102442f..793fa4273edb 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -108,6 +108,8 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
 	if (mds_srv->flags & NFS_MOUNT_NORESVPORT)
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
 
+	__set_bit(NFS_CS_NOPING, &cl_init.init_flags);
+
 	/* Use the MDS nfs_client cl_ipaddr. */
 	nfs_init_timeout_values(&ds_timeout, ds_proto, ds_timeo, ds_retrans);
 	clp = nfs_get_client(&cl_init);
-- 
2.21.0

