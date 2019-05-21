Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D70924F2B
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 14:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfEUMtO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 08:49:14 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52574 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfEUMtN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 May 2019 08:49:13 -0400
Received: by mail-it1-f195.google.com with SMTP id t184so4724034itf.2
        for <linux-nfs@vger.kernel.org>; Tue, 21 May 2019 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0106F+OIYuqVEg46cY8S9oFV/iyDhlYutv2OgfNUAlo=;
        b=Qiz7dc11EDTEqdsK5oApuPDxvOXOKwXD/jxZ+aigDpohi7I8p5j86ZUyBTusTi6bjx
         /0+RtPm+ZCfSqrKriBAILDDAM35BGuNzwMn5YkW/9uOOAMFju0OCzo5MlTuk1QrMRu+e
         +KMPoTfY1T4ZJ2ZdwHe4SEOVh+EyQ5svDseQU9apdO2zPYzLkU4SS2UqKP0tRzWfDt3y
         Sb9nQ5aKXSnqtHwCRpPHmHaKH1dI9PleROWhECRE20jSgUiM0EFUoKyvYHj9wS+3gYlQ
         dZ3v5ZmgnOfmtbIyrOUpEDiGGCX6yXvOI6F0DL+YtvkxvL0YzA2qfXh1XVe3XvQAV2gv
         T4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0106F+OIYuqVEg46cY8S9oFV/iyDhlYutv2OgfNUAlo=;
        b=N+E5EJ7/TEhfvB/mEpmk8oRP+k3mo0heUdYm7OJMtCnbnwiipM3mXSVBBZ1lKqJ+sl
         taNjR9s3y8N3aZ7Qa6brRRI/SO4f4pDrkpKmxOkx8EBV99wZCyNtavXuPzJW6iZchs9B
         4PQWEAyJLs0NA/HtOpB8GLOFVX257pODDfcWDRVaDDAss1uyIujSClXg9UsO8H0GmX+Q
         yB4sWnO0dyRj1ywEM40Htt8kHj1vosQoBrxdTc25/7eWjCC2BRYVGU898MLIS1Gtqjoa
         FBczh/d/gYG6NbGcvlqqV4DKKUtqs3q9iFerqMQzR1TEtTzyJfFSyeEn1WZbXfTSrwIF
         z3BA==
X-Gm-Message-State: APjAAAWWifz4LGi+rbS4hFZdpKM1vdCq9byhmTNqsVOQE83hNhVGPuu+
        F0FW/wcsyOWu/3hKilTABw==
X-Google-Smtp-Source: APXvYqwAUPLJa1Bm1ipJhelXn+OmKiEgUte0IAiTWVGMY2BiM80Ro7TdUld55hhJXjbVL7KhHDrPrA==
X-Received: by 2002:a02:b38e:: with SMTP id p14mr6114963jan.43.1558442952699;
        Tue, 21 May 2019 05:49:12 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id v139sm1693180itb.25.2019.05.21.05.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 05:49:11 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 1/7] mountd: Ensure we don't share cache file descriptors among processes.
Date:   Tue, 21 May 2019 08:46:55 -0400
Message-Id: <20190521124701.61849-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
References: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sharing cache descriptors without using locking can be very bad.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 utils/mountd/mountd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
index fb7bba4cd390..88a207b3a85a 100644
--- a/utils/mountd/mountd.c
+++ b/utils/mountd/mountd.c
@@ -836,8 +836,6 @@ main(int argc, char **argv)
 	if (!foreground)
 		closeall(3);
 
-	cache_open();
-
 	unregister_services();
 	if (version2()) {
 		listeners += nfs_svc_create("mountd", MOUNTPROG,
@@ -888,6 +886,9 @@ main(int argc, char **argv)
 	if (num_threads > 1)
 		fork_workers();
 
+	/* Open files now to avoid sharing descriptors among forked processes */
+	cache_open();
+
 	xlog(L_NOTICE, "Version " VERSION " starting");
 	my_svc_run();
 
-- 
2.21.0

