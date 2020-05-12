Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE47E1D00AA
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbgELVWv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731270AbgELVWu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:22:50 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C995C061A0C;
        Tue, 12 May 2020 14:22:49 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f13so14669802qkh.2;
        Tue, 12 May 2020 14:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ETA1f6UFmjBQn0duK0wp3dkMLZQ+ZPmkQmCOTXOeD+c=;
        b=oQL1vrBmHwazTeMCsCOGOPwvlF5CXJmHGpwcrq2+8cTjISrtJeSO8DrKaHiZSoLC0S
         KBCMWPTb+NCP0Wn9eobqhW8RxUI+KwcP8bIPTHu5Cb2OgSwaWSudxLvQ4lMy5fYVwZdL
         ZMX962DD/9OMCdtJL4DcnxTLOzHr7GnGo6GKo+DU1RDYwXtEkTGyndyLF0QuaEVpqtI5
         APuacGHcLOxmS6MUV35T5UU4WjFAm8Xzx71I+6jyxdm20j3sxlNYPcN0IZ3UrY/gTtd4
         Ad3a8nzP+2UgCXoGG12P4lNnB0ja0+TsPgdRoe3aFPo7vXZ4a/D528d15nWD9rhUp6nX
         0slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ETA1f6UFmjBQn0duK0wp3dkMLZQ+ZPmkQmCOTXOeD+c=;
        b=C/sTliLhFMh66mLeppLFmMbm+phPntRHTgtuWq25WQlt5int6WIA5bgq55YHcdm4EK
         EJXp0pmzQO42TVFN5KxU8H0Hec8PNUjAGS5DLWk5UsmXmimWzXUP6mn+fHriEzwufm3B
         wvgB4w+ky1qM75OVD0+ckuXtINb1q/XrEULDkr7tUlEPPuxwBcQ/E7uQ8dfWXLiIU6DN
         PcKdF4XattbwM3uQFrYRjEl89mlOg1/VFVyQqTw10RLMxvWNfzJCqGSzHeGSrsj0UFwF
         0r6kMoi9g9uz2GRW6tGXxNch3Z9DIJFTGgixWBmoe7W9y1ZFC4QzGNg7sFXrO/MyhQ+1
         LrYg==
X-Gm-Message-State: AGi0PuYQqwCQaUfEr+WUErdc1P7Mk6AN/uv4PfdGf4Lw36BhXw4KhNnx
        U8kUXdBP9PfWCLTBu2g+J9rWJL2l
X-Google-Smtp-Source: APiQypI8+lOgbwZm4zSRMvOTfPABkzuXYTWeM9ewF2vv/ceIY3ALSSplf0cHJWDcv1IIifa/2f2jDQ==
X-Received: by 2002:a37:c96:: with SMTP id 144mr21363791qkm.138.1589318568349;
        Tue, 12 May 2020 14:22:48 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u56sm5257206qtb.91.2020.05.12.14.22.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:22:47 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLMl2n009898;
        Tue, 12 May 2020 21:22:47 GMT
Subject: [PATCH v2 08/29] svcrdma: Rename tracepoints that record header
 decoding errors
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:22:47 -0400
Message-ID: <20200512212247.5826.42055.stgit@klimt.1015granger.net>
In-Reply-To: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
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
 

