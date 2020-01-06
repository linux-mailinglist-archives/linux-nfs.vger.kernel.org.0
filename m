Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21072131953
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 21:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgAFU13 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 15:27:29 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42433 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgAFU12 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 15:27:28 -0500
Received: by mail-yb1-f193.google.com with SMTP id z10so15278949ybr.9
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 12:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mQqren3SabSmNoA5QVuXoLb4xDGESav0uq95Aq1SI5Y=;
        b=r9GEmoT7tgUwMjzx/w8elfinDcUY3SUpd09+xR80lql6t8xXFo95a/2xOpZjIQ7+Bm
         N8wuibZRjNBi/8oCHadlKQkNjb+cjUnisMaIKzgVXp9PE1Mfrns8s6vjlqJ8ZjnMQWjt
         swfJCvxObdfKfv3zz0f3vRBMyrRP0HBxfEZzNupnu+aiVewGTRZD0+mllJjmO1h/NOJX
         KqPGlwEpodVOpx3KE5yPTMXR4I6cVw6EDBExnAZ7i8k9UVi4ivgEVALV8zJ9DG06xPB4
         BOikBqfuYj0He60Mk6Tbv6vQzkuvjKAr2Z4SY5AsBOOPYbtb8D/16VvSEjobebs/yWrP
         4bVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mQqren3SabSmNoA5QVuXoLb4xDGESav0uq95Aq1SI5Y=;
        b=omJUBxCf13hqWCV2pmq1sgZLm68eL76bEHMJbeyYFZTISeO8Lc9BW+hGKFVg3QPE14
         ep6pcXFazYQXli1uv1ooAmKtvcRfrPnUSwJDbvgtXi80IKIiUPfzvlkV9qR5R/DNZpyT
         LD332gW458dcnMbP+eIXOs4iSRhCB0ForvyVKzY2DxFtce1jPVBSR6xDdRTrZ5LYVO2Q
         PY0CCLLki67zXWoPmTIvNQhIuBteUfAuVl6p6jMzA+9xsi5EKivDpnrl8meTuKO96dnp
         HkPiDlm0GexIiZ33lHvlXF+tANALsYMkwhUismiTQlWvdCiSgWefHhOPKpzT9hM3SqLt
         G4hA==
X-Gm-Message-State: APjAAAUPxr/IX+MKe7cIEIwflErjFesNqofoWm8iTvLhXyZGlOD9x8hE
        Wi5owE5i/JtNN/MqgyPd8Q==
X-Google-Smtp-Source: APXvYqxfoGm157gE4uAB0UzWUbOwocpYtZGmZlhR1FTcm+0lydgVezAphoFhUBKe6Ng5jjogSMcewg==
X-Received: by 2002:a25:447:: with SMTP id 68mr70281713ybe.432.1578342447766;
        Mon, 06 Jan 2020 12:27:27 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l200sm28723579ywl.106.2020.01.06.12.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:27:27 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 02/15] NFS: Revalidate the file mapping on all fatal writeback errors
Date:   Mon,  6 Jan 2020 15:25:01 -0500
Message-Id: <20200106202514.785483-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106202514.785483-2-trond.myklebust@hammerspace.com>
References: <20200106202514.785483-1-trond.myklebust@hammerspace.com>
 <20200106202514.785483-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a write or commit failed, and the mapping sees a fatal error, we
need to revalidate the contents of that mapping.

Fixes: 06c9fdf3b9f1 ("NFS: On fatal writeback errors, we need to call nfs_inode_remove_request()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/write.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index f5170bc839aa..83e6f691368c 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -256,8 +256,11 @@ static void nfs_set_pageerror(struct address_space *mapping)
 
 static void nfs_mapping_set_error(struct page *page, int error)
 {
+	struct address_space *mapping = page_file_mapping(page);
+
 	SetPageError(page);
-	mapping_set_error(page_file_mapping(page), error);
+	mapping_set_error(mapping, error);
+	nfs_set_pageerror(mapping);
 }
 
 /*
@@ -600,7 +603,6 @@ nfs_lock_and_join_requests(struct page *page)
 
 static void nfs_write_error(struct nfs_page *req, int error)
 {
-	nfs_set_pageerror(page_file_mapping(req->wb_page));
 	nfs_mapping_set_error(req->wb_page, error);
 	nfs_inode_remove_request(req);
 	nfs_end_page_writeback(req);
@@ -1006,7 +1008,6 @@ static void nfs_write_completion(struct nfs_pgio_header *hdr)
 		nfs_list_remove_request(req);
 		if (test_bit(NFS_IOHDR_ERROR, &hdr->flags) &&
 		    (hdr->good_bytes < bytes)) {
-			nfs_set_pageerror(page_file_mapping(req->wb_page));
 			nfs_mapping_set_error(req->wb_page, hdr->error);
 			goto remove_req;
 		}
-- 
2.24.1

