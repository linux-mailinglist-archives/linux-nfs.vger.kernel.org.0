Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2496E1E9188
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgE3N2y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgE3N2x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:28:53 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974C3C03E969;
        Sat, 30 May 2020 06:28:53 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p5so4093155ile.6;
        Sat, 30 May 2020 06:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ETA1f6UFmjBQn0duK0wp3dkMLZQ+ZPmkQmCOTXOeD+c=;
        b=m9Johg5ZWo+hp3d5+0StDwBRNgPd51HGmQy8MZaJgVQsSB7UIYckzI9TPPbOYBsZwz
         QQzh4/RSAWNUyzyzbJkZf7HGdIhY1huq99o5zpFkyNzOq6GBN4Q9v+KZNiZUqUpKq5GP
         Sokim5fiaj2F304kYR8msVxd//FAicoEzXu8Vza7PMNyqcjsaEUfRPVX09sM2CVYE6PY
         vo+shqJpMVDz/7n/cy/Jfy6t29s/+StB/7ebjwhqFUa6+NeyTlVeIUpV+0vTcECSZoiE
         BTzIysaGx7x25+Zc29/pXotUku1xON5eQyFKObCeaihxs7DxjrwsrV1AVevL0h+E0AKO
         gCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ETA1f6UFmjBQn0duK0wp3dkMLZQ+ZPmkQmCOTXOeD+c=;
        b=E77EO6oH1iFOHUERt+Uj4V7SWBq30k6+nEFCd0xqa7DnQPxgmcE7J84NU4fXwwGsgb
         Sw7KFlAwtROj3afbulTgyQFZBzlKlaE+7IKysPTe0cOedbfoc54dLj9c1CnejxYGYreF
         1mP9tsT1T5BQegNLS8BvlSdWzUEK0zQW84Hs48EQ0ZqovdIqo+6N8wE+FhGHCJJ8I6UM
         0DNjkKMmuTxFp3oi8THk8S9ICwBz0WtNGzRO7ICHtQxu7Rqut2gu5LKsXvqTh2xGUB15
         Bwq8Nqwp9jiSAYxql/hw2dX9clvOptwsCR58PF5nM86BvVXCuVpOHESHB0S+wO2GcSuT
         McFw==
X-Gm-Message-State: AOAM532ZAUBKlpKTwM7fcTLQ1e+lk9j8S25/RNvTK9CCpMhT39Oq7R0y
        1ZIf5/4bZNK8EN7Yb+TJxczkf0h2
X-Google-Smtp-Source: ABdhPJzA051cDfeF4+3MbLQkWEWcIEkRim1FSGxtVnStawVuTibAaV9j9KRKn/obOjTPsz9cESP5fA==
X-Received: by 2002:a05:6e02:49:: with SMTP id i9mr12418152ilr.236.1590845332859;
        Sat, 30 May 2020 06:28:52 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g15sm2348058ilq.39.2020.05.30.06.28.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:28:52 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDSpJe001411;
        Sat, 30 May 2020 13:28:51 GMT
Subject: [PATCH v4 09/33] svcrdma: Rename tracepoints that record header
 decoding errors
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:28:51 -0400
Message-ID: <20200530132851.10117.22428.stgit@klimt.1015granger.net>
In-Reply-To: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
References: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Use a consistent naming convention so that these trace
points can be enabled quickly via a glob.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h          |    5 +++--
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   10 +++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index c046b198072a..53b24c8c7860 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1355,7 +1355,7 @@ TRACE_EVENT(svcrdma_decode_rqst,
 		show_rpcrdma_proc(__entry->proc), __entry->hdrlen)
 );
 
-TRACE_EVENT(svcrdma_decode_short,
+TRACE_EVENT(svcrdma_decode_short_err,
 	TP_PROTO(
 		unsigned int hdrlen
 	),
@@ -1399,7 +1399,8 @@ DECLARE_EVENT_CLASS(svcrdma_badreq_event,
 );
 
 #define DEFINE_BADREQ_EVENT(name)					\
-		DEFINE_EVENT(svcrdma_badreq_event, svcrdma_decode_##name,\
+		DEFINE_EVENT(svcrdma_badreq_event,			\
+			     svcrdma_decode_##name##_err,		\
 				TP_PROTO(				\
 					__be32 *p			\
 				),					\
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index eee7c6478b30..e426fedb9524 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -665,23 +665,23 @@ static int svc_rdma_xdr_decode_req(struct xdr_buf *rq_arg,
 	return hdr_len;
 
 out_short:
-	trace_svcrdma_decode_short(rq_arg->len);
+	trace_svcrdma_decode_short_err(rq_arg->len);
 	return -EINVAL;
 
 out_version:
-	trace_svcrdma_decode_badvers(rdma_argp);
+	trace_svcrdma_decode_badvers_err(rdma_argp);
 	return -EPROTONOSUPPORT;
 
 out_drop:
-	trace_svcrdma_decode_drop(rdma_argp);
+	trace_svcrdma_decode_drop_err(rdma_argp);
 	return 0;
 
 out_proc:
-	trace_svcrdma_decode_badproc(rdma_argp);
+	trace_svcrdma_decode_badproc_err(rdma_argp);
 	return -EINVAL;
 
 out_inval:
-	trace_svcrdma_decode_parse(rdma_argp);
+	trace_svcrdma_decode_parse_err(rdma_argp);
 	return -EINVAL;
 }
 

