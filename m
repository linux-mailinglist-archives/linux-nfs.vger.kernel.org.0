Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4159918C7
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Aug 2019 20:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfHRSVa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Aug 2019 14:21:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42557 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfHRSV3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Aug 2019 14:21:29 -0400
Received: by mail-io1-f68.google.com with SMTP id e20so16077446iob.9
        for <linux-nfs@vger.kernel.org>; Sun, 18 Aug 2019 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hI8quDQfqo7QshB/JzcwEIxS4+AfSdU9ezcYaUtQ1cE=;
        b=L5EuGrabKeEwVOVqtRpZGm4kYCkALUGPiqL0GALzY0wuu5UlVCQAiZspJMjS6ZmHRI
         XVP9rzpzuE46k9zDBAwFTbrGLC6PGx6apWvAB8EqUIKb6ddto3uXQ09aLJ3jAJT/4oKS
         qjxJ2tvXbZLxggN3bBtdEo+Lt9CeLSumG7skSDw+jRvSr4YUzvdq2t43EdpKY4RgInAP
         EU6qZIZWjTaza7ACs7G01saGEcyZ6rWYGmdCbsCPgyVZsQcP5yCuw0cO3WXq/TtuCL5w
         tzgWVUy/Wg2wwmi8ScGz69w2U74HaFLgCKmkoOEWVX/IURYv1LSbQN25jCLHrDwkV7Zs
         ookA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hI8quDQfqo7QshB/JzcwEIxS4+AfSdU9ezcYaUtQ1cE=;
        b=YpERpKpPKTTh9PFvkCt4NGWsFpuCRppzuPc1gxVU/96BiCUD7cXL83xPJNuL2KobRj
         S+wC4agYS1F8xOQQjakssnV43bpCws5oZhuNWsoimHPtJ1qVTeebsfavgvxAEUHIbEUu
         k6/XeQsusA1xvEylgxTbQsmJD1vOGqqbScKoA3rnNVFEzWhv/JIQLO0smUTmgdzXkTA7
         IQ4yqiucJnxjjtu09LSXrKdhvYDFsKn+eDUopEx2vAs6zCamFfuO1ZI6d2hqln/SJhqn
         cY+0leIbhBMmuOpz37besLvJBLDpRJccvpE7hjOYtLq57kG254XexFIImnB+Qju3e5Mj
         8NGQ==
X-Gm-Message-State: APjAAAUjsqId93rv5DwDZ9j8gPInpMD4dZf7ATr2x57NN0ZDC/YszW9o
        x0bQFPJoB5IxgzQTKDGSiQ==
X-Google-Smtp-Source: APXvYqzcKp0y9pGqKEsPu4P+kF3OtIffI9pOfbY/o7s7GxsC6yoZ9PtO9s/4ClE+2OpKA8P6avkBeQ==
X-Received: by 2002:a6b:4a08:: with SMTP id w8mr10761675iob.246.1566152488783;
        Sun, 18 Aug 2019 11:21:28 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id n22sm10317844iob.37.2019.08.18.11.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:21:28 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 15/16] nfsd: Fix up some unused variable warnings
Date:   Sun, 18 Aug 2019 14:18:58 -0400
Message-Id: <20190818181859.8458-16-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818181859.8458-15-trond.myklebust@hammerspace.com>
References: <20190818181859.8458-1-trond.myklebust@hammerspace.com>
 <20190818181859.8458-2-trond.myklebust@hammerspace.com>
 <20190818181859.8458-3-trond.myklebust@hammerspace.com>
 <20190818181859.8458-4-trond.myklebust@hammerspace.com>
 <20190818181859.8458-5-trond.myklebust@hammerspace.com>
 <20190818181859.8458-6-trond.myklebust@hammerspace.com>
 <20190818181859.8458-7-trond.myklebust@hammerspace.com>
 <20190818181859.8458-8-trond.myklebust@hammerspace.com>
 <20190818181859.8458-9-trond.myklebust@hammerspace.com>
 <20190818181859.8458-10-trond.myklebust@hammerspace.com>
 <20190818181859.8458-11-trond.myklebust@hammerspace.com>
 <20190818181859.8458-12-trond.myklebust@hammerspace.com>
 <20190818181859.8458-13-trond.myklebust@hammerspace.com>
 <20190818181859.8458-14-trond.myklebust@hammerspace.com>
 <20190818181859.8458-15-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs4xdr.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7b03bcca0dfe..e08d890a1915 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1419,7 +1419,6 @@ nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 			    struct nfsd4_create_session *sess)
 {
 	DECODE_HEAD;
-	u32 dummy;
 
 	READ_BUF(16);
 	COPYMEM(&sess->clientid, 8);
@@ -1428,7 +1427,7 @@ nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 
 	/* Fore channel attrs */
 	READ_BUF(28);
-	dummy = be32_to_cpup(p++); /* headerpadsz is always 0 */
+	p++; /* headerpadsz is always 0 */
 	sess->fore_channel.maxreq_sz = be32_to_cpup(p++);
 	sess->fore_channel.maxresp_sz = be32_to_cpup(p++);
 	sess->fore_channel.maxresp_cached = be32_to_cpup(p++);
@@ -1445,7 +1444,7 @@ nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 
 	/* Back channel attrs */
 	READ_BUF(28);
-	dummy = be32_to_cpup(p++); /* headerpadsz is always 0 */
+	p++; /* headerpadsz is always 0 */
 	sess->back_channel.maxreq_sz = be32_to_cpup(p++);
 	sess->back_channel.maxresp_sz = be32_to_cpup(p++);
 	sess->back_channel.maxresp_cached = be32_to_cpup(p++);
@@ -1737,7 +1736,6 @@ static __be32
 nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 {
 	DECODE_HEAD;
-	unsigned int tmp;
 
 	status = nfsd4_decode_stateid(argp, &copy->cp_src_stateid);
 	if (status)
@@ -1752,7 +1750,7 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 	p = xdr_decode_hyper(p, &copy->cp_count);
 	p++; /* ca_consecutive: we always do consecutive copies */
 	copy->cp_synchronous = be32_to_cpup(p++);
-	tmp = be32_to_cpup(p); /* Source server list not supported */
+	/* tmp = be32_to_cpup(p); Source server list not supported */
 
 	DECODE_TAIL;
 }
@@ -3218,9 +3216,8 @@ nfsd4_encode_create(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_
 	if (!p)
 		return nfserr_resource;
 	encode_cinfo(p, &create->cr_cinfo);
-	nfserr = nfsd4_encode_bitmap(xdr, create->cr_bmval[0],
+	return nfsd4_encode_bitmap(xdr, create->cr_bmval[0],
 			create->cr_bmval[1], create->cr_bmval[2]);
-	return 0;
 }
 
 static __be32
-- 
2.21.0

