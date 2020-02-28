Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 108B9172D5C
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 01:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgB1Abv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Feb 2020 19:31:51 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37177 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgB1Abv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Feb 2020 19:31:51 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so514081pjb.2;
        Thu, 27 Feb 2020 16:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=N/lInLYnOgUImPT8Z29KJToYDgSjQqFLZT3k4njOq6s=;
        b=e+tkr6AeyNSchz2ivIcKwIOiwlh0FO7WNBIjrowGuGBn36zX/Ui6jCz9eCOczN3cFT
         MiifoKujLhxv4KWrAE3CwsS2lgoktkzkgFiV8fb+WeyP4Dl2XIQxmE7k5lqxraSMaydi
         9KWBd7cTfVQLwQ5+IwGrIRZiPXPgVWxaZXmBo68UdxOCMUF8rCm74BT5p696/TfB/dVd
         L0uBRQFjxReRAsLOzJ073S7Kdf84qQOyROFkK4dh5VJ8GLZV9ufXOqMFWgJNBMVBpj7B
         643thaGEfOCEiJiiL+OUkFs5qvTua3IEjJ/AjpQNCsSe5ChhAatf+sJTt/wystyZoU1Z
         +Kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=N/lInLYnOgUImPT8Z29KJToYDgSjQqFLZT3k4njOq6s=;
        b=aJyky/aVG5JGUPq3c3oRu2MYEJCNSSlbULNWcyBmz3GoIYY627BoudZ+jY3KyT9w9R
         CyjjBXos+L2n1BC81bvXlV3SkL9AazrEzudBrMW285ft6dg9kg9D24T0rR6akoZuvaND
         1DpXvVx7cMp7iSbS+VUU2ZahBwfkB6s1cXyTBhfOawq3mQK/dXxJpYztg5Aoxrpkw62n
         Bz7u9Zk0MwsWP+K9vKuNMJ4cdPZf+YL+ydYJ8GanfW6qN9V7p4TW26u33EdVgY5msGk0
         8sV7cfHACfpbmbX9zvODTQt/ceKqQolZBv1vwQG06XgbqbQu1e7EzH6Tds+JcI43y3C5
         CWhQ==
X-Gm-Message-State: APjAAAVDcD4Kd+QTiwk7au0Os0x7WRwDrQqWSxxCnJZ6BBA9mWG57FMg
        MVg93sQrKPu0+EIguijtZUnq97blo4A=
X-Google-Smtp-Source: APXvYqwaRaZJeJDo2Bq5MUDzCqf1ituslF8EFxhf54VhxDPPGcdPSc4BGl96Ln5VQI89grfkUSqCcA==
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr1456088ply.68.1582849910016;
        Thu, 27 Feb 2020 16:31:50 -0800 (PST)
Received: from seurat29.1015granger.net (ip-184-250-247-225.sanjca.spcsdns.net. [184.250.247.225])
        by smtp.gmail.com with ESMTPSA id 64sm8412413pfd.48.2020.02.27.16.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:31:49 -0800 (PST)
Subject: [PATCH v1 12/16] svcrdma: Rename svcrdma_encode trace points in
 send routines
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 27 Feb 2020 19:31:48 -0500
Message-ID: <158284990838.38468.938564136257260647.stgit@seurat29.1015granger.net>
In-Reply-To: <158284930886.38468.17045380766660946827.stgit@seurat29.1015granger.net>
References: <158284930886.38468.17045380766660946827.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These trace points are misnamed:

	trace_svcrdma_encode_wseg
	trace_svcrdma_encode_write
	trace_svcrdma_encode_reply
	trace_svcrdma_encode_rseg
	trace_svcrdma_encode_read
	trace_svcrdma_encode_pzr

Because they actually trace posting on the Send Queue. Let's rename
them so that I can add trace points in the chunk list encoders that
actually do trace chunk list encoding events.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h    |   14 +++++++++-----
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   13 +++++++------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 814b73bd2cc7..74b68547eefb 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1479,7 +1479,9 @@ DECLARE_EVENT_CLASS(svcrdma_segment_event,
 
 DEFINE_SEGMENT_EVENT(decode_wseg);
 DEFINE_SEGMENT_EVENT(encode_rseg);
+DEFINE_SEGMENT_EVENT(send_rseg);
 DEFINE_SEGMENT_EVENT(encode_wseg);
+DEFINE_SEGMENT_EVENT(send_wseg);
 
 DECLARE_EVENT_CLASS(svcrdma_chunk_event,
 	TP_PROTO(
@@ -1502,17 +1504,19 @@ DECLARE_EVENT_CLASS(svcrdma_chunk_event,
 );
 
 #define DEFINE_CHUNK_EVENT(name)					\
-		DEFINE_EVENT(svcrdma_chunk_event, svcrdma_encode_##name,\
+		DEFINE_EVENT(svcrdma_chunk_event, svcrdma_##name,	\
 				TP_PROTO(				\
 					u32 length			\
 				),					\
 				TP_ARGS(length))
 
-DEFINE_CHUNK_EVENT(pzr);
-DEFINE_CHUNK_EVENT(write);
-DEFINE_CHUNK_EVENT(reply);
+DEFINE_CHUNK_EVENT(send_pzr);
+DEFINE_CHUNK_EVENT(encode_write_chunk);
+DEFINE_CHUNK_EVENT(send_write_chunk);
+DEFINE_CHUNK_EVENT(encode_read_chunk);
+DEFINE_CHUNK_EVENT(send_reply_chunk);
 
-TRACE_EVENT(svcrdma_encode_read,
+TRACE_EVENT(svcrdma_send_read_chunk,
 	TP_PROTO(
 		u32 length,
 		u32 position
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 9d854755d78d..a0e83a94beeb 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -439,7 +439,8 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 		if (ret < 0)
 			goto out_initerr;
 
-		trace_svcrdma_encode_wseg(seg_handle, write_len, seg_offset);
+		trace_svcrdma_send_wseg(seg_handle, write_len, seg_offset);
+
 		list_add(&ctxt->rw_list, &cc->cc_rwctxts);
 		cc->cc_sqecount += ret;
 		if (write_len == seg_length - info->wi_seg_off) {
@@ -534,7 +535,7 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
 	if (ret < 0)
 		goto out_err;
 
-	trace_svcrdma_encode_write(xdr->page_len);
+	trace_svcrdma_send_write_chunk(xdr->page_len);
 	return length;
 
 out_err:
@@ -594,7 +595,7 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 	if (ret < 0)
 		goto out_err;
 
-	trace_svcrdma_encode_reply(consumed);
+	trace_svcrdma_send_reply_chunk(consumed);
 	return consumed;
 
 out_err:
@@ -697,7 +698,7 @@ static int svc_rdma_build_read_chunk(struct svc_rqst *rqstp,
 		if (ret < 0)
 			break;
 
-		trace_svcrdma_encode_rseg(rs_handle, rs_length, rs_offset);
+		trace_svcrdma_send_rseg(rs_handle, rs_length, rs_offset);
 		info->ri_chunklen += rs_length;
 	}
 
@@ -728,7 +729,7 @@ static int svc_rdma_build_normal_read_chunk(struct svc_rqst *rqstp,
 	if (ret < 0)
 		goto out;
 
-	trace_svcrdma_encode_read(info->ri_chunklen, info->ri_position);
+	trace_svcrdma_send_read_chunk(info->ri_chunklen, info->ri_position);
 
 	head->rc_hdr_count = 0;
 
@@ -784,7 +785,7 @@ static int svc_rdma_build_pz_read_chunk(struct svc_rqst *rqstp,
 	if (ret < 0)
 		goto out;
 
-	trace_svcrdma_encode_pzr(info->ri_chunklen);
+	trace_svcrdma_send_pzr(info->ri_chunklen);
 
 	head->rc_arg.len += info->ri_chunklen;
 	head->rc_arg.buflen += info->ri_chunklen;

