Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501501C1C1C
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgEARlG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729572AbgEARlG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:41:06 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4ADC061A0C;
        Fri,  1 May 2020 10:41:06 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k12so8516789qtm.4;
        Fri, 01 May 2020 10:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=wLc9kaJEBy8MqiGvCdXWsNnTsIFMmf1FjET+I7edc2s=;
        b=U7guWbLg4XKUumPeRDF/L+sqnG016ACBmSCO/vUfrRsx6rvyktJkkjcaq0QMn0AlMb
         RGeZkmeDHTXPtwj8Xh61HauxyPuO4dyhARVcZLabV0PtiLvpRzP9SGYpYKe2Fifjxzw9
         ImYjXqaIF4DqmpVswbdyCMhVw8nJnuDHvLb1AtJRGVbVJVpdrHH6430d9mr2NSIHwm+M
         iQffj+uyXevZKX5WptG04Zy6A+HrXKlEfa2OaHgk+y9y/dheSKwhPpjKAxrMQhiC1xHF
         ZLPZkrZ61HDfcCBA67ASK4rI2T7T1czESRBFN9FWGgW5f9Mfj1ZMexfagyhOWrki2Z+l
         ICKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=wLc9kaJEBy8MqiGvCdXWsNnTsIFMmf1FjET+I7edc2s=;
        b=StsYAUHbYZIlbyAi9+Ms4hF/0lRmNgztX+Gf/AyPnCIIlB2qsrPobda/Rk5XibUn5P
         7GETQcj95tpQptW1CJcob0nYKL0fhoKGLt0wJd/p3Snullm9Ed+gG3ISN1KRiOkOXVw9
         bGgcEBtBjnBgXWqjA2Jq9sRlfH4+qTg7ryx2Oh8qW2JZYUivCRC+PK1MXQRJC3ooIHMY
         zf3jNV96xNcKl746dSc/KueyjfStvl789mc7TW8nlx1wsDRNMUko1RFHXcdcAibD3kqk
         0vwBlVquQCIp5PrmWq0i+Slu0Jx1wrLcrjkauZCbQTcx48Joca2HQkjBJ2stHZOzrsWB
         zUYQ==
X-Gm-Message-State: AGi0PubCH+6vnfJuBmvrw9M6MgjyLWhPN0z8/VZgjLnVN9EGdf1UkGBI
        IMjEf6s129krXaI28w67rqXCQ7kE
X-Google-Smtp-Source: APiQypIgmsRVmypDzFdEuz4JjVI2UqThj9m0b2jdaue2mjj4PJmTny+XLenPkAY2uC7Qic/LQt6qOA==
X-Received: by 2002:ac8:37ac:: with SMTP id d41mr4998999qtc.288.1588354865433;
        Fri, 01 May 2020 10:41:05 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d123sm1014337qkb.28.2020.05.01.10.41.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:41:04 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041Hf33A026783;
        Fri, 1 May 2020 17:41:03 GMT
Subject: [PATCH v1 7/7] svcrdma: Rename tracepoints that record header
 decoding errors
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:41:03 -0400
Message-ID: <20200501174103.3899.45497.stgit@klimt.1015granger.net>
In-Reply-To: <20200501173903.3899.31567.stgit@klimt.1015granger.net>
References: <20200501173903.3899.31567.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
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
index 3390dd12a8dc..6b8ab7a51744 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1363,7 +1363,7 @@ TRACE_EVENT(svcrdma_decode_rqst,
 		show_rpcrdma_proc(__entry->proc), __entry->hdrlen)
 );
 
-TRACE_EVENT(svcrdma_decode_short,
+TRACE_EVENT(svcrdma_decode_short_err,
 	TP_PROTO(
 		unsigned int hdrlen
 	),
@@ -1407,7 +1407,8 @@ DECLARE_EVENT_CLASS(svcrdma_badreq_event,
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
 

