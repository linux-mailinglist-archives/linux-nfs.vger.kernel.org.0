Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DA71DCFD1
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgEUOeM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgEUOeM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:34:12 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053FDC061A0E;
        Thu, 21 May 2020 07:34:12 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id f4so7614418iov.11;
        Thu, 21 May 2020 07:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=TV42Sou8aMygUuJA03fyTdblg9o3Ei8GWJ1p5HoMi9k=;
        b=dVs6U2xKBP8cKEJEQyAEuBCFaprcqMxTM7TdmpoUMnMdcWptukopeadHVfIOzvpcir
         BnQrePhXEC/LlphW9UWs0z3V37HCD39NAOWYi+IE9HAnNReOlodL1IaV0/NZOxqQki2N
         YDLCD+HpbOvhjjlJhCimUSQFJOqnyyawXT6IcLHfPK7tPccb5rh1bWxSrYYgtILxz+rc
         M5ItTtXhAKuvqJ43XWWHSkpwu7jTSCA48KNTjREo3ZAOu/tpB8/Xxg42mSoQLqXuaHL5
         IYn4yO/ymOaAoXBfBlAROZMadhgfShHJAzg/iUm2hDnn59U2UPmsrDocAUbylnizE0BD
         7rAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=TV42Sou8aMygUuJA03fyTdblg9o3Ei8GWJ1p5HoMi9k=;
        b=AzfFDrJTyEThOpAPU3+3FTnVnb5arD52wFXpZtIQzMxOBHt+AfQOTv5RqBKLAwQYT6
         i+1XeE2zSD/MVC4si7vvsBwV5GnYw6DF/RkAKupj2K4FyjrZFBShG7EohR+JcgwdnnW+
         oLivIJs8i/5ZEtZPr1qSBlr+NDgPvNivrM0T6n4ru38r0DPVtTq8t4q0J3Jkr7f0Wtag
         rBf09ZN9NXbOIauECr/n5d6Ve/vyjgLeyvR6Kz+GSD2XTCmwik1rvuvG25Aw25KOtDfy
         fN59DPJeEBodCjzZ1wYDTrAgwFoVT8QhknovOwARC8CafmxzsQEmk1IEkk8Fgij4rH9E
         CwFg==
X-Gm-Message-State: AOAM5335p1nuEerPn/3JoSqMjjo4Gf1Y/NH8EMtzUf924uKmZzelOKAz
        XxVLby8/U624hlGMM73ltcZ1dCkR
X-Google-Smtp-Source: ABdhPJwNPUQkdJqCQ9BdKkaou9LrcnhQKcsXB6yq9XLpSRFd56NC6j5kktaojPw0zbI5KhG5n9DMNA==
X-Received: by 2002:a5d:9d8b:: with SMTP id 11mr7977733ion.169.1590071651160;
        Thu, 21 May 2020 07:34:11 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j15sm2959731ilk.0.2020.05.21.07.34.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:34:10 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEY96f000818;
        Thu, 21 May 2020 14:34:09 GMT
Subject: [PATCH v3 05/32] svcrdma: trace undersized Write chunks
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:34:09 -0400
Message-ID: <20200521143409.3557.86163.stgit@klimt.1015granger.net>
In-Reply-To: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
References: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Replace a dprintk call site.

This is the last remaining dprintk call site in svc_rdma_rw.c, so
remove dprintk infrastructure as well.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h    |   32 ++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_rw.c |    7 ++-----
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index d6da6b8d521d..c046b198072a 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1665,6 +1665,38 @@ TRACE_EVENT(svcrdma_page_overrun_err,
 	)
 );
 
+TRACE_EVENT(svcrdma_small_wrch_err,
+	TP_PROTO(
+		const struct svcxprt_rdma *rdma,
+		unsigned int remaining,
+		unsigned int seg_no,
+		unsigned int num_segs
+	),
+
+	TP_ARGS(rdma, remaining, seg_no, num_segs),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, remaining)
+		__field(unsigned int, seg_no)
+		__field(unsigned int, num_segs)
+		__string(device, rdma->sc_cm_id->device->name)
+		__string(addr, rdma->sc_xprt.xpt_remotebuf)
+	),
+
+	TP_fast_assign(
+		__entry->remaining = remaining;
+		__entry->seg_no = seg_no;
+		__entry->num_segs = num_segs;
+		__assign_str(device, rdma->sc_cm_id->device->name);
+		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
+	),
+
+	TP_printk("addr=%s device=%s remaining=%u seg_no=%u num_segs=%u",
+		__get_str(addr), __get_str(device), __entry->remaining,
+		__entry->seg_no, __entry->num_segs
+	)
+);
+
 TRACE_EVENT(svcrdma_send_pullup,
 	TP_PROTO(
 		unsigned int len
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 17098a11d2ad..5eb35309ecef 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -9,13 +9,10 @@
 
 #include <linux/sunrpc/rpc_rdma.h>
 #include <linux/sunrpc/svc_rdma.h>
-#include <linux/sunrpc/debug.h>
 
 #include "xprt_rdma.h"
 #include <trace/events/rpcrdma.h>
 
-#define RPCDBG_FACILITY	RPCDBG_SVCXPRT
-
 static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc);
 static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc);
 
@@ -484,8 +481,8 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 	return 0;
 
 out_overflow:
-	dprintk("svcrdma: inadequate space in Write chunk (%u)\n",
-		info->wi_nsegs);
+	trace_svcrdma_small_wrch_err(rdma, remaining, info->wi_seg_no,
+				     info->wi_nsegs);
 	return -E2BIG;
 }
 

