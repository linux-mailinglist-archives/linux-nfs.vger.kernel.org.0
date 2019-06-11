Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE963D57C
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 20:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407079AbfFKS1W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 14:27:22 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39263 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406804AbfFKS1V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 14:27:21 -0400
Received: by mail-it1-f193.google.com with SMTP id j204so6372518ite.4
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jun 2019 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ALlSwKx47PAkBIuYQSOTzntZen30W3HZ6oSQbt2Hs0Y=;
        b=vJmZC+A0DvBXo8NM8NL0VGpP73wGutKis6toCbH/hX4cYZRGmgOAb2PFOaSf8aFVYz
         i4irkifRtWcRoRQGmf7g7do2ivBpwms/gKGLYhVRN/txdEWaejHizhoM98lccCf6/t1J
         hPRAGTSKA0DJYu8rKEXrI6rktuYRQPsqR/pIiMByZbHAYKC1a2IpAtD5Pxag+HvGk3gl
         QSk6CYae/zDsgZI5X1t/b4WwhKz+PZCa7yeXWX/3vnZetBzctt+6FI/fqNeWPu39bU9h
         2dHo0xvWVSSkkyuUVPdZJCPRnpk/EoONKvwqtd8DqXz4K3IfDVuwc72ev3DmHhDfSXBo
         L69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ALlSwKx47PAkBIuYQSOTzntZen30W3HZ6oSQbt2Hs0Y=;
        b=F5gw1MB9S5euDqIpDJKrcuD8pdugG9R+jKyrjwLVdKnEhy0iHVV6JOaSj4EJuK/jUq
         ZZKRy08w1R/YDx4Q3+OgqJzVWHNeMBHE7qSen61uzIeQWj7BymOdzpLW6Hdc/qwzGMqG
         YAZKbR9l1U2duktUp31u2XArRHM5a7m6EiVr0pl2rnGuU+8uJ/X/Z1QYkMTH4vA6YOuZ
         bCEmmhw4Z0NdQnFYaaZUvkTX7+E18g6FfKKSKIjI6r72ms+qxkhWK2kJ0Zmpzt5BtRTE
         ljy7q0PUcyeI0pV/TD3EMLKOyPKrJ4Mt61mODWyVqa1rLQdPN/JKpl5v8zT7csBbNeVF
         jJIQ==
X-Gm-Message-State: APjAAAV6vWCEM1M1LJY8MV5gobyT2qhRgEdR08UnlCRRwrJ0LTyOJAZU
        FWtcLaXWf5W+kvyegxXErVi1mPA=
X-Google-Smtp-Source: APXvYqymk3nga7qAtGhqeaM0okbkud8FYLlRUD3RtLG18fWDP2YukiuK5O/gsmbCCvoiUvUcGpmwSg==
X-Received: by 2002:a24:ee47:: with SMTP id b68mr18514017iti.36.1560277640501;
        Tue, 11 Jun 2019 11:27:20 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q9sm4789830iot.80.2019.06.11.11.27.19
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 11:27:20 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFS: Fix up ftrace logging of nfs_inode flags
Date:   Tue, 11 Jun 2019 14:25:10 -0400
Message-Id: <20190611182511.120074-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611182511.120074-2-trond.myklebust@hammerspace.com>
References: <20190611182511.120074-1-trond.myklebust@hammerspace.com>
 <20190611182511.120074-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Also print out the layoutstats and O_DIRECT flag settings.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfstrace.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index c40aad6ef3ff..864ae1c11bd2 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -40,12 +40,14 @@
 
 #define nfs_show_nfsi_flags(v) \
 	__print_flags(v, "|", \
-			{ 1 << NFS_INO_ADVISE_RDPLUS, "ADVISE_RDPLUS" }, \
-			{ 1 << NFS_INO_STALE, "STALE" }, \
-			{ 1 << NFS_INO_INVALIDATING, "INVALIDATING" }, \
-			{ 1 << NFS_INO_FSCACHE, "FSCACHE" }, \
-			{ 1 << NFS_INO_LAYOUTCOMMIT, "NEED_LAYOUTCOMMIT" }, \
-			{ 1 << NFS_INO_LAYOUTCOMMITTING, "LAYOUTCOMMIT" })
+			{ BIT(NFS_INO_ADVISE_RDPLUS), "ADVISE_RDPLUS" }, \
+			{ BIT(NFS_INO_STALE), "STALE" }, \
+			{ BIT(NFS_INO_INVALIDATING), "INVALIDATING" }, \
+			{ BIT(NFS_INO_FSCACHE), "FSCACHE" }, \
+			{ BIT(NFS_INO_LAYOUTCOMMIT), "NEED_LAYOUTCOMMIT" }, \
+			{ BIT(NFS_INO_LAYOUTCOMMITTING), "LAYOUTCOMMIT" }, \
+			{ BIT(NFS_INO_LAYOUTSTATS), "LAYOUTSTATS" }, \
+			{ BIT(NFS_INO_ODIRECT), "O_DIRECT" })
 
 DECLARE_EVENT_CLASS(nfs_inode_event,
 		TP_PROTO(
-- 
2.21.0

