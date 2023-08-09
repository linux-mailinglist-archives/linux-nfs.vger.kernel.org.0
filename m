Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B807764CC
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Aug 2023 18:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHIQPc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Aug 2023 12:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjHIQPb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Aug 2023 12:15:31 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1628E10D4
        for <linux-nfs@vger.kernel.org>; Wed,  9 Aug 2023 09:15:30 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7653bd3ff2fso3079985a.3
        for <linux-nfs@vger.kernel.org>; Wed, 09 Aug 2023 09:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691597729; x=1692202529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3fttE8Ka5FbAuwos3r7+GvavRagrx9NXFQXtO4C8VM=;
        b=drOZ6TCGfwObQp/c04AqPIZr6Tw/Uu//V6THTIqxuenN6Z47Pd4kVVzXg9hplexMsF
         ZCrGxm2RzetA7I7cf95vrTcqKZoqAw10P/PYk733E2trSJONM+yj4uHZBQBOJCsrGlHM
         WBNNxLRoPF1mG7zepYq4IEJgx2mVcAWgdB+YXgeYYjSG1E3jXrhYeh6gEz//B9lbXZDu
         +WY2g5dEBwI/zbIm/DOwkrVv7jtQr2f4tj/yYhyokXMBuohvzjJs56upmQWgLQ26GQ1z
         NEh+rYs0PSUHoxD22ECtV+G+yWCbb8MUpFyM+Sq8s156o0mG34Rn1/5Q96vFhEKZwLHn
         tuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691597729; x=1692202529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3fttE8Ka5FbAuwos3r7+GvavRagrx9NXFQXtO4C8VM=;
        b=g5xZ3CGpG2XY4AY2J6NeYzl1Jj4H1ojFUK8q6vZ5CN5YFzqTZsBJ/l1kAZXWQ7LMAf
         lLvPvsP/JOY0YKf1AqYIFUyh542qfyT3wN5fvSnxI+2CeBN86s+zGDvvEMicNjQ+nobe
         qz72GzJTbu2pJXXKq3Ij9XbmmUmLQl6aMpiR2FYlbtfRT22U0Jw3bK/Qsg/rA0hZnrxo
         7oSF5cpwqbnCkgZ3D+9XGVN60pf77mS5H8V/uaQ3iT9HkmwYuRR0Bb5pPFR73oDcf/al
         N+B1i+ng/tJtZZ4RfFIMV411WCUekE+mdBW2OLVBpowa3LA1RtHD7QQmVqRoGPt0jIgE
         lNnQ==
X-Gm-Message-State: AOJu0YzIrfuLJpao5W61F/A04k9apWRU7hy7k+rVwma0CBdOfhV350jV
        dEbB25je61V0GshoFOd3Cux3PtsQvsxu
X-Google-Smtp-Source: AGHT+IEhApmjBS/BBRoFLOs/hihGzBElb73CQ79jgP1ygdGLgQcbQlWBbZdWArHjPYUifZ4ojAgEXA==
X-Received: by 2002:a37:ac01:0:b0:76c:9ac2:3f22 with SMTP id e1-20020a37ac01000000b0076c9ac23f22mr3348686qkm.68.1691597728965;
        Wed, 09 Aug 2023 09:15:28 -0700 (PDT)
Received: from localhost.localdomain (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id y3-20020a37e303000000b0075b2af4a076sm4075223qki.16.2023.08.09.09.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:15:28 -0700 (PDT)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>
Subject: [PATCH 2/2] NFS: Fix a potential data corruption
Date:   Wed,  9 Aug 2023 12:09:01 -0400
Message-ID: <20230809160901.26679-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809160901.26679-1-trond.myklebust@hammerspace.com>
References: <20230809160901.26679-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We must ensure that the subrequests are joined back into the head before
we can retransmit a request. If the head was not on the commit lists,
because the server wrote it synchronously, we still need to add it back
to the retransmission list.
Add a call that mirrors the effect of nfs_cancel_remove_inode() for
O_DIRECT.

Fixes: ed5d588fe47f ("NFS: Try to join page groups before an O_DIRECT retransmission")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index aaffaaa336cc..9b6bfc7905f6 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -472,13 +472,30 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
 	return result;
 }
 
+static void nfs_direct_add_page_head(struct list_head *list,
+				     struct nfs_page *req)
+{
+	struct nfs_page *head = req->wb_head;
+
+	if (!list_empty(&head->wb_list) || !nfs_lock_request(head))
+		return;
+	if (!list_empty(&head->wb_list)) {
+		nfs_unlock_request(head);
+		return;
+	}
+	list_add(&head->wb_list, list);
+	kref_get(&head->wb_kref);
+}
+
 static void nfs_direct_join_group(struct list_head *list, struct inode *inode)
 {
 	struct nfs_page *req, *subreq;
 
 	list_for_each_entry(req, list, wb_list) {
-		if (req->wb_head != req)
+		if (req->wb_head != req) {
+			nfs_direct_add_page_head(&req->wb_list, req);
 			continue;
+		}
 		subreq = req->wb_this_page;
 		if (subreq == req)
 			continue;
-- 
2.41.0

