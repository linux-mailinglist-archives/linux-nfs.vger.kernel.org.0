Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A97A22D075
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 22:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfE1Udm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 16:33:42 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54348 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbfE1Udl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 16:33:41 -0400
Received: by mail-it1-f194.google.com with SMTP id h20so6578105itk.4
        for <linux-nfs@vger.kernel.org>; Tue, 28 May 2019 13:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y/jOtEZptS2HutHiuHWWaXrtl1adLnn5zu2gxhvRHbc=;
        b=UP92vuAsjrwP1Ze2QJ/WWRRGV54b13RYUXblvLcm44HeIIRj4ffegqnnn98Toaveae
         07H88pyV87xlp6GOGZrlDEdbug7/1bNPQ2OJhT6KaEkQvUQjWfeXaYTg66Su4YFASCiU
         1fzh80+5XyHsCi3/NL1SROpytUEZ3Cj2Bw8ydn27vsQ2kWBOFJHHXNhXfzed9jbJZfsn
         hw4Vjh1QqE6kLZsIxivXZXp8+3RvERT+AQP6k8vsKszHtqMkZ6ISVaf4B6b9ubHFbxRB
         E1qLvZpjOpzuyIGYkderzuORR/lvyf5eW902z4+MQ602Y/wNJys+cKf59yM6lg/6v0cq
         hrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/jOtEZptS2HutHiuHWWaXrtl1adLnn5zu2gxhvRHbc=;
        b=Ao2P+74SvUoUXH7rdWhwR5IVwIVOpXqzI94x5mdFW5j+xVTIkmBk5HBW9RZHFinZ+G
         /BBiO3Guse45Sm9G/m6vqmUa7azqv7K0W/VMbddsUIbOYCnw2OUReyfh/rxqj6NO4a4b
         4CgHv1ovScyhpw+/B+6lnxRJ/hLG2pORn7bHAlZzvw2TpCioAKDrqc8jCwTF55AlNhK3
         Hf9xftEc0qhbQA34AUgypOuWljVEcjT03gODdJuyf1K2KItK609sKCeR9fGwQNgeKPd+
         B6oYl5WuxRZ/C3Os7bB772eVO5cZ7ug4P33eOgptMwheLExQXDswu9f7M87RJBpNIsFd
         AjWQ==
X-Gm-Message-State: APjAAAX6qeLoZVcw3s18TjQwh5I8rbGL0AZqJlDaEwQb+wXz5AjycwWE
        eo9Jw21p8P2TXzATjAHSe15v5j4=
X-Google-Smtp-Source: APXvYqxpPnn6D1aFZRpIGdr8jQTLgFBwrKlZb8Ojj5Xcsd46tsttpo7rt9jO8Fck0WAF6veDjuoFVg==
X-Received: by 2002:a02:9143:: with SMTP id b3mr2002667jag.12.1559075620732;
        Tue, 28 May 2019 13:33:40 -0700 (PDT)
Received: from localhost.localdomain (50-124-247-140.alma.mi.frontiernet.net. [50.124.247.140])
        by smtp.gmail.com with ESMTPSA id i141sm53089ite.20.2019.05.28.13.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 13:33:40 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 11/11] Fix up symlinked mount path resolution when "[exports] rootdir" is set
Date:   Tue, 28 May 2019 16:31:22 -0400
Message-Id: <20190528203122.11401-12-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528203122.11401-11-trond.myklebust@hammerspace.com>
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
 <20190528203122.11401-2-trond.myklebust@hammerspace.com>
 <20190528203122.11401-3-trond.myklebust@hammerspace.com>
 <20190528203122.11401-4-trond.myklebust@hammerspace.com>
 <20190528203122.11401-5-trond.myklebust@hammerspace.com>
 <20190528203122.11401-6-trond.myklebust@hammerspace.com>
 <20190528203122.11401-7-trond.myklebust@hammerspace.com>
 <20190528203122.11401-8-trond.myklebust@hammerspace.com>
 <20190528203122.11401-9-trond.myklebust@hammerspace.com>
 <20190528203122.11401-10-trond.myklebust@hammerspace.com>
 <20190528203122.11401-11-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 utils/mountd/mountd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
index f062cac28be4..33571ecbd401 100644
--- a/utils/mountd/mountd.c
+++ b/utils/mountd/mountd.c
@@ -272,7 +272,7 @@ mount_umnt_1_svc(struct svc_req *rqstp, dirpath *argp, void *UNUSED(resp))
 	if (*p == '\0')
 		p = "/";
 
-	if (realpath(p, rpath) != NULL) {
+	if (nfsd_realpath(p, rpath) != NULL) {
 		rpath[sizeof (rpath) - 1] = '\0';
 		p = rpath;
 	}
@@ -363,7 +363,7 @@ mount_pathconf_2_svc(struct svc_req *rqstp, dirpath *path, ppathcnf *res)
 	auth_reload();
 
 	/* Resolve symlinks */
-	if (realpath(p, rpath) != NULL) {
+	if (nfsd_realpath(p, rpath) != NULL) {
 		rpath[sizeof (rpath) - 1] = '\0';
 		p = rpath;
 	}
@@ -473,7 +473,7 @@ get_rootfh(struct svc_req *rqstp, dirpath *path, nfs_export **expret,
 	auth_reload();
 
 	/* Resolve symlinks */
-	if (realpath(p, rpath) != NULL) {
+	if (nfsd_realpath(p, rpath) != NULL) {
 		rpath[sizeof (rpath) - 1] = '\0';
 		p = rpath;
 	}
-- 
2.21.0

