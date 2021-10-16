Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB467430576
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbhJPWtV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:49:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235339AbhJPWtU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:49:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9497960E96;
        Sat, 16 Oct 2021 22:47:11 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 08/14] SUNRPC: Report short RPC messages via a tracepoint
Date:   Sat, 16 Oct 2021 18:47:10 -0400
Message-Id:  <163442443046.1001.10047809524619807215.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
References:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1571; h=from:subject:message-id; bh=m//k5VGbiNPeh1XS53xg/ybpQ/JP3i63NgF9vkl+OZQ=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha1ZuknFfRHZM/lSZPjkaHYpoa2z2LMlUdEAp+hB2 UK6uIaWJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtWbgAKCRAzarMzb2Z/lzjmEA COCAqOinZ2iHqLk9vqhFqnf8zxLlktXwIkLY+SZTmAHSOthD47cTTzTmw8VouEC2xy8R1x0nfP0p5b jm2N3X66pOJYbDYZAYzc4Pl6YWtojH7xRWl2OyKgTx90CXLaTn0KjTcmBgOt7SkrAKqci/Hyjgxqr1 ojv6swAZXJVt5+Xxt+oOaRUExNWqFkSvWLccnNwxQXoqkWjFF1kCR5Ax+VqtMX8h+QyPv1tBqIpN/i v9ozbQqUfpeJ9wRfUgKuC0eJHatYJNSg8PXy8PpypG76h/hUW6OJGUqieYstmvXoMCRSMSz5YIjF2w Fod4agPmjYE0bNaLZlADyNAg6OavEuOsJY0zlHwGG3dcZZOR6XKo5blnXgbshvSEkjQ0T9y0DBQdDa cahPe/0fQ1a+7Bx/o8qc+VNGITruoZRYfz0ZOSBTnjjAzzt0a6eMvxjAyNgZYshTWLmvBsw6pHAJqA LN9EynLNqoyyTpFwEuXLYReHLQJ+TdDB7p97L5qNP0tISf113aNnJJa7jVGkMLzpswMCm+0BPFpB/n Vln1gJJr29hvvkEvW311Owg50zl9nFS9lfHgliTdD6EMRiDplw0lUQyuzLKHrvowDZL9MCfLbDJDdn 9UemBLfF++hFTI8tNZekwdsb806kBYFlT4Aw5n8QgCVuPpjKEHjGnyn1hXKA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Replace a dprintk call site. The new tracepoint can be left enabled
persistently to capture problems.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   23 +++++++++++++++++++++++
 net/sunrpc/svc.c              |    3 +--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 23b0964e0425..3cfdd0ef6600 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1642,6 +1642,29 @@ TRACE_EVENT(svc_process,
 	)
 );
 
+TRACE_EVENT(svc_decode_len_err,
+	TP_PROTO(
+		const struct svc_rqst *rqst,
+		const struct kvec *argv
+	),
+
+	TP_ARGS(rqst, argv),
+
+	TP_STRUCT__entry(
+		__field(size_t, len)
+		__string(addr, rqst->rq_xprt ?
+			 rqst->rq_xprt->xpt_remotebuf : "(null)")
+	),
+
+	TP_fast_assign(
+		__entry->len = argv->iov_len;
+		__assign_str(addr, rqst->rq_xprt ?
+			     rqst->rq_xprt->xpt_remotebuf : "(null)");
+	),
+
+	TP_printk("addr=%s len=%zu", __get_str(addr), __entry->len)
+);
+
 DECLARE_EVENT_CLASS(svc_rqst_event,
 
 	TP_PROTO(
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 5cfbda94e759..3d95faffe43b 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1379,8 +1379,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	return 0;
 
 err_short_len:
-	svc_printk(rqstp, "short len %zd, dropping request\n",
-			argv->iov_len);
+	trace_svc_decode_len_err(rqstp, argv);
 	goto close_xprt;
 
 err_bad_rpc:

