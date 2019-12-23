Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86C6129839
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2019 16:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfLWP2g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Dec 2019 10:28:36 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:47097 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfLWP2g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Dec 2019 10:28:36 -0500
Received: by mail-yw1-f66.google.com with SMTP id u139so7170707ywf.13
        for <linux-nfs@vger.kernel.org>; Mon, 23 Dec 2019 07:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=D4MFfx4MRc6PEgOrVL9+aKGce5wogpXJh2qY+trArWE=;
        b=AAwnr1YyhzO48OJt0OeZVjV6AF7jXwE7mQcsrg0WFlVLwXiTXXWVROf0nNdqJmel7W
         Z5hUIrdt+tpcD4LDKRajfGCJjqWc9GPsoFqG4l0APNnuuo6Ke1c3mVz6ivYILAccmqYk
         bHKlxiTiekVeD0wwr+bKvBJlbMjznEBMkSx+BXysWjmZJueN6fu9S8XaUmecoj+nbOO9
         cAUUq4/90VNYmlwBXDdrcGz1j8JE0x6fcxCM8wGBzxy8VRGgF3ILlQeuMWZ/BUxS97wp
         xczzKhNq/Kbke7mcr6d03Lqd+Z/SP2T+ixxXBaVDKyJIGtkka1RuA5C/tUpzSAKpSC45
         95vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=D4MFfx4MRc6PEgOrVL9+aKGce5wogpXJh2qY+trArWE=;
        b=lCUkonGpj19pZ823TVA8xKAXX2UTJb65/vU6V65xmnizU/tFHE9PYDMDE7Su7d7yys
         IeEgmpiZ0JH2hwMFQse8y76V+pv5YyVd+kX5Hb459jKNHU9lfDdgB1/picNS2Q1vrs5p
         aKfP9Pdx+QA5EJsG3FQNEb9X0vyz03PdvVN6L3QGC1I+tO57bx/Sz68ycXYaghutyHqM
         5Y65T2HqYNcvQrPCk+NVztlt72WIM9BC3Q1YNP5wOVkUnUjozqN/vr5Y8K63XYCTkAm/
         DOVDc0mFdajsJf8IDI3IYEBSpdCAuT0DRd68t3lp+ZKvTJEbpLXbrzhBD6xXgBoazU2+
         GZxQ==
X-Gm-Message-State: APjAAAUIeZ9uSM2Aqgk5MPS8sXGCFXrxrL51x1ycRLKc4DPYWRHb3g4a
        jN6SVETepfzMZBDLG05+m4I=
X-Google-Smtp-Source: APXvYqyI6wuPsB1lpOPdZ7qr7pAj4OrwSLI3x6QJ0fKLrcxQIuMwC8QTN3bSUHYBJFIMmJF9QLuiSg==
X-Received: by 2002:a81:50c3:: with SMTP id e186mr21667538ywb.160.1577114914919;
        Mon, 23 Dec 2019 07:28:34 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w142sm8105165ywa.87.2019.12.23.07.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 07:28:34 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xBNFSX2N008880;
        Mon, 23 Dec 2019 15:28:33 GMT
Subject: [PATCH v1 2/4] NFS: Introduce trace events triggered by page
 writeback errors
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Dec 2019 10:28:33 -0500
Message-ID: <20191223152833.17724.93664.stgit@manet.1015granger.net>
In-Reply-To: <20191223152539.17724.52438.stgit@manet.1015granger.net>
References: <20191223152539.17724.52438.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Try to capture the reason for the writeback path tagging an error on
a page.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfstrace.h |   45 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/write.c    |    3 +++
 2 files changed, 48 insertions(+)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index f64a33d2a1d1..4d6eb1703943 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -989,6 +989,51 @@
 		)
 );
 
+DECLARE_EVENT_CLASS(nfs_page_error_class,
+		TP_PROTO(
+			const struct nfs_page *req,
+			int error
+		),
+
+		TP_ARGS(req, error),
+
+		TP_STRUCT__entry(
+			__field(const void *, req)
+			__field(pgoff_t, index)
+			__field(unsigned int, offset)
+			__field(unsigned int, pgbase)
+			__field(unsigned int, bytes)
+			__field(int, error)
+		),
+
+		TP_fast_assign(
+			__entry->req = req;
+			__entry->index = req->wb_index;
+			__entry->offset = req->wb_offset;
+			__entry->pgbase = req->wb_pgbase;
+			__entry->bytes = req->wb_bytes;
+			__entry->error = error;
+		),
+
+		TP_printk(
+			"req=%p index=%lu offset=%u pgbase=%u bytes=%u error=%d",
+			__entry->req, __entry->index, __entry->offset,
+			__entry->pgbase, __entry->bytes, __entry->error
+		)
+);
+
+#define DEFINE_NFS_PAGEERR_EVENT(name) \
+	DEFINE_EVENT(nfs_page_error_class, name, \
+			TP_PROTO( \
+				const struct nfs_page *req, \
+				int error \
+			), \
+			TP_ARGS(req, error))
+
+DEFINE_NFS_PAGEERR_EVENT(nfs_write_error);
+DEFINE_NFS_PAGEERR_EVENT(nfs_comp_error);
+DEFINE_NFS_PAGEERR_EVENT(nfs_commit_error);
+
 TRACE_EVENT(nfs_initiate_commit,
 		TP_PROTO(
 			const struct nfs_commit_data *data
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 52cab65f91cf..21787711e352 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -593,6 +593,7 @@ static void nfs_end_page_writeback(struct nfs_page *req)
 static void nfs_write_error(struct nfs_page *req, int error)
 {
 	nfs_set_pageerror(page_file_mapping(req->wb_page));
+	trace_nfs_write_error(req, error);
 	nfs_mapping_set_error(req->wb_page, error);
 	nfs_inode_remove_request(req);
 	nfs_end_page_writeback(req);
@@ -999,6 +1000,7 @@ static void nfs_write_completion(struct nfs_pgio_header *hdr)
 		if (test_bit(NFS_IOHDR_ERROR, &hdr->flags) &&
 		    (hdr->good_bytes < bytes)) {
 			nfs_set_pageerror(page_file_mapping(req->wb_page));
+			trace_nfs_comp_error(req, hdr->error);
 			nfs_mapping_set_error(req->wb_page, hdr->error);
 			goto remove_req;
 		}
@@ -1847,6 +1849,7 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 			(long long)req_offset(req));
 		if (status < 0) {
 			if (req->wb_page) {
+				trace_nfs_commit_error(req, status);
 				nfs_mapping_set_error(req->wb_page, status);
 				nfs_inode_remove_request(req);
 			}

