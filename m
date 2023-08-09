Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B0A7764CB
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Aug 2023 18:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjHIQPa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Aug 2023 12:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHIQP3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Aug 2023 12:15:29 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A643C3
        for <linux-nfs@vger.kernel.org>; Wed,  9 Aug 2023 09:15:29 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76af2cb7404so3620585a.0
        for <linux-nfs@vger.kernel.org>; Wed, 09 Aug 2023 09:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691597728; x=1692202528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gT7wtNe9cLvPlRssfppADRLldoXf3AYMpNL92GpsTpU=;
        b=n8QWsYzi4rblIYWypn9CT5qR3Tf505aqIaAHcwYtQoEoMepv1LmdPBS7LHnspvbDxt
         oYLjqRZp+dKwzBEeq3EZG05WoFIbnsvLx8PE0vzoFycM+CLGSRZfFI2iCIWE+ZJKzDLF
         74HXpdoxdQ3nQQltNLfAMrfJCYmw3bXbpwixA+3WEp2UJDzH9w1YoJnQ7gjy6A9X5BGI
         VVPwelhQ3FLMVpK0vyIwEDr6fOtei0U9aLRJuW5lSfHlJk1q6OYeEHzMocMBYmjIJPJb
         CNaTUWcD1l9IKMVOC+bjHy409EJLhHoo+WlT1o3I6Mk9JIDLFrgI5LdtJNXcM2SRJc5X
         0pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691597728; x=1692202528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gT7wtNe9cLvPlRssfppADRLldoXf3AYMpNL92GpsTpU=;
        b=Lgt9e+9lTCgFLymp2jjRIhaX2DE8JdWUTKqeELfZ7HpMbONprBFvKPKfH1Ji+ahrLp
         ULycV9bpGBnWN+dqM1rEOVAXQM0gKcxI9/Tgg/hGKo1FztLeJ/8wiAylR0tWLKXtaEnz
         hUeD//8CmHcLgxyYDSNTD3Qu6fvn2qeHgto+/7iDC03AN3QWTDZaEk99RRvHIPKyI65A
         jPPbYg6PgCp1v5jYErWnJokvb3xBpFvkkZK3W1sPa7eeVrBKLHthk5Mjxg2JJIOR92pK
         edIWzoI8/mjqr/k50SUbQ3Qpx1Yi06rW5q4JrJxPZaSJa3V0LeyP13JIb9IhJvkCtIQi
         hz6w==
X-Gm-Message-State: AOJu0YyLSVAZGnHajW1GpVE04UONLbSHF87NCDoal0/s4ai2m5uOytGg
        LzggNnZCWS9pUPflE/kGAUvhC+89YqMK
X-Google-Smtp-Source: AGHT+IFpfQALyK3e0IFL3n/mRP6pLx2E+8pqt+ZOM4cfkdwiEiqNc3Rm9RjmWaA57UJBGI4shQat5Q==
X-Received: by 2002:a05:620a:45ab:b0:76c:c68e:8f46 with SMTP id bp43-20020a05620a45ab00b0076cc68e8f46mr4181504qkb.40.1691597727970;
        Wed, 09 Aug 2023 09:15:27 -0700 (PDT)
Received: from localhost.localdomain (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id y3-20020a37e303000000b0075b2af4a076sm4075223qki.16.2023.08.09.09.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:15:27 -0700 (PDT)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>
Subject: [PATCH 1/2] NFS: Fix a use after free in nfs_direct_join_group()
Date:   Wed,  9 Aug 2023 12:09:00 -0400
Message-ID: <20230809160901.26679-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.41.0
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

Be more careful when tearing down the subrequests of an O_DIRECT write
as part of a retransmission.

Reported-by: Chris Mason <clm@fb.com>
Fixes: ed5d588fe47f ("NFS: Try to join page groups before an O_DIRECT retransmission")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 9a18c5a69ace..aaffaaa336cc 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -472,20 +472,26 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
 	return result;
 }
 
-static void
-nfs_direct_join_group(struct list_head *list, struct inode *inode)
+static void nfs_direct_join_group(struct list_head *list, struct inode *inode)
 {
-	struct nfs_page *req, *next;
+	struct nfs_page *req, *subreq;
 
 	list_for_each_entry(req, list, wb_list) {
-		if (req->wb_head != req || req->wb_this_page == req)
+		if (req->wb_head != req)
 			continue;
-		for (next = req->wb_this_page;
-				next != req->wb_head;
-				next = next->wb_this_page) {
-			nfs_list_remove_request(next);
-			nfs_release_request(next);
-		}
+		subreq = req->wb_this_page;
+		if (subreq == req)
+			continue;
+		do {
+			/*
+			 * Remove subrequests from this list before freeing
+			 * them in the call to nfs_join_page_group().
+			 */
+			if (!list_empty(&subreq->wb_list)) {
+				nfs_list_remove_request(subreq);
+				nfs_release_request(subreq);
+			}
+		} while ((subreq = subreq->wb_this_page) != req);
 		nfs_join_page_group(req, inode);
 	}
 }
-- 
2.41.0

