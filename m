Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A31D72CE70
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 20:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfE1SVD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 14:21:03 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36182 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfE1SVC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 14:21:02 -0400
Received: by mail-it1-f194.google.com with SMTP id e184so5513589ite.1;
        Tue, 28 May 2019 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=DuGm7Y8gW91gv6AuiLt2GdkmCz1p6fKJf4IyLcPAavM=;
        b=iXS6FAHYbpthazRI+rDMbtBCsC2AFlq/b5nY7bQa5os9MEc5bWcFNIassiS7A5avlK
         +oEHffKncbwNz7K/q7/kVtqQSEFOx5eaoclI6WmDwTX9xX7CwIgTqazz8bPQ1raaD/AX
         MyDw8dQXnSLdpIHLrt8i0a1gQbCJCU8a/yrZyQo1fG8yPhDFsOYqduDdXGbMPWERQTzt
         9x6ZqPMQytNr6KIbJJNLDWinTZNMGvrw4SkfKLgCAt8fTxy9naikWuqitPtAQhbkzRja
         W4H/4j3w9oqKt5sRRN9ZClQNLkwSmtvB+crcU1ynfA3fQyMk/NVgNQ6E/YTFk/BFNgof
         5d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=DuGm7Y8gW91gv6AuiLt2GdkmCz1p6fKJf4IyLcPAavM=;
        b=NOG91hOTdTGe4K2V/VPR5kYFb4JQxWrTDmJ9L7C9kfUC2jNObcmV5/TA7l5W0eHFDi
         YgRUWFBBqpNIW/r84Pp/W9spXKOAwpfthQJ9Dnc7VfZt89cTaLpBSvblXmHuVckoMPsF
         S9OrQ96op9G1nn74YUoJDqJgivaSCl+HAUju3WW8b+flb19vV30yAD9OoJFK8QNs2q2n
         b9QgaIAa9gaamGYf/vyfD8NlU1mNCpyI/xOGFVU5NELqqjiSqu/tYfNg/DcVEfzo/W9m
         c2IrECPQ0pNpOvK5Kga/Tb3rfPEIH7efLgmhZVXFagJTonE6Inm8FDDgGvjGCOZrS8vx
         g7HQ==
X-Gm-Message-State: APjAAAXzqJ5GU/653i+in1yfLQtHr7WowAtNO3pv+1Ar7fmsu1d9OiFC
        iAiK+rFw/nZmmXPnVpMmOGRQg8Hq
X-Google-Smtp-Source: APXvYqxVTx6qZDfRAEOi0SziG5VIx5P350vVDq6hnm2ndrX3DxtnsEtlZAts+w2j3gwXm9/tqmqH/w==
X-Received: by 2002:a02:ce50:: with SMTP id y16mr4961341jar.75.1559067661973;
        Tue, 28 May 2019 11:21:01 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m67sm1514510itc.22.2019.05.28.11.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:21:01 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x4SIL08D014519;
        Tue, 28 May 2019 18:21:00 GMT
Subject: [PATCH RFC 02/12] xprtrdma: Replace use of xdr_stream_pos in
 rpcrdma_marshal_req
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 28 May 2019 14:21:00 -0400
Message-ID: <20190528182100.19012.59793.stgit@manet.1015granger.net>
In-Reply-To: <20190528181018.19012.61210.stgit@manet.1015granger.net>
References: <20190528181018.19012.61210.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a latent bug. xdr_stream_pos works by subtracting
xdr_stream::nwords from xdr_buf::len. But xdr_stream::nwords is not
initialized by xdr_init_encode().

It works today only because all fields in rpcrdma_req::rl_stream
are initialized to zero by rpcrdma_req_create, making the
subtraction in xdr_stream_pos always a no-op.

I found this issue via code inspection. It was introduced by commit
39f4cd9e9982 ("xprtrdma: Harden chunk list encoding against send
buffer overflow"), but the code has changed enough since then that
this fix can't be automatically applied to stable.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 85115a2..608b9ac 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -867,9 +867,9 @@ static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
 	if (ret)
 		goto out_err;
 
-	trace_xprtrdma_marshal(rqst, xdr_stream_pos(xdr), rtype, wtype);
+	trace_xprtrdma_marshal(rqst, req->rl_hdrbuf.len, rtype, wtype);
 
-	ret = rpcrdma_prepare_send_sges(r_xprt, req, xdr_stream_pos(xdr),
+	ret = rpcrdma_prepare_send_sges(r_xprt, req, req->rl_hdrbuf.len,
 					&rqst->rq_snd_buf, rtype);
 	if (ret)
 		goto out_err;

