Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8BAE2246
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2019 20:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbfJWSCZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 14:02:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43028 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732839AbfJWSCZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 14:02:25 -0400
Received: by mail-io1-f67.google.com with SMTP id c11so16970931iom.10
        for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2019 11:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=v3jN7VHkCMHPSK6eBc5fcRyTydL45Y+MTK8LLWOLIRM=;
        b=SAO0PHiOiro5fiK2vjNCigouB7GBVkkgzt7tLCWSv8WLYsN8iIpkJ1dxrwNaQbYKBx
         fCiqmEaSQImKx0KGdvrxp0eyTWv4IZCFtcUQsmg74UTmk6iIwLoTLhSwpca15DAaN4er
         exM0qDEN4RSTGCNqsSm0i1Gn7DXfBnal3nIDmz2gs71o8c1hFSaTK8bhgePOHNYp18Hk
         el41LuxW4MrOxIYg1QIVAIDYxY7PeHVqB3cAUKA/C2XfQHwFNJ45vdWyGkIc7ABq8V9K
         DrgpydwA11BjyEYgRxTDU+AC1l7r9BrA33SuN54ImKP00c7pQVDF7OaO95S5Tg0LyQ7g
         o2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=v3jN7VHkCMHPSK6eBc5fcRyTydL45Y+MTK8LLWOLIRM=;
        b=jlFTs37OvobMjBx9OYJxXFbULDMmyy8amAMMdQDWhTj7LMzLWVws9jAqMD1lmJ8Pg+
         BqAv6qVUU/+HC1fMcrP2ii6P/qTKc9hn5A3U6X/bM4QQsatuaDy9GErzDb0Z7WECSfId
         iParXndum2mLOGK1nq/88zN+q7EKl76ShiIS73mB45ZaSKG44tBuWJ3ndIHoNUyUvHLE
         8YZKZ5CnqZCv/fSn5fkCXcQbbDHcMq43dJJHEVEuceL32byO/rzaJNRjtjU/7Iblfvwd
         ilzmxhbta3xuyCCl+qGiLq67MKei+k4XBnzeoSlKnMwEop5JoGhZ0zrBH/KbPvn7T/dc
         MjaA==
X-Gm-Message-State: APjAAAWoLY5wnUjMVcIkLfxLgf3LNe2OLkNIW3fn8J1JxluoWLp4aIJz
        maTmtPrgumvsfMhTosXdejirbODR
X-Google-Smtp-Source: APXvYqwOKvvrzRpzKrAqh+md1xlW3XYIeOWvIsGcq6SScWkRYWM8ba73wQU/l7ESa5sZTceJtCtFlQ==
X-Received: by 2002:a5d:8886:: with SMTP id d6mr4742625ioo.301.1571853744738;
        Wed, 23 Oct 2019 11:02:24 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c6sm3794790iof.58.2019.10.23.11.02.24
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 11:02:24 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x9NI2NCD012956
        for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2019 18:02:23 GMT
Subject: [PATCH RFC 1/2] NFS: Introduce trace events triggered by page
 writeback errors
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 23 Oct 2019 14:02:23 -0400
Message-ID: <20191023180223.6450.21722.stgit@manet.1015granger.net>
In-Reply-To: <20191023180049.6450.65440.stgit@manet.1015granger.net>
References: <20191023180049.6450.65440.stgit@manet.1015granger.net>
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
index 361cc10..336f01e 100644
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
index 52cab65..2178771 100644
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

