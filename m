Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AACC515F449
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 19:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394813AbgBNSUN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 13:20:13 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37121 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbgBNPuL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 10:50:11 -0500
Received: by mail-yw1-f66.google.com with SMTP id l5so4451764ywd.4;
        Fri, 14 Feb 2020 07:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jr8hTaKS8MrCYauE49IsR6qQ2XT9e1L6kQQ5nLMAksA=;
        b=bSjN8hkzZjErTsGxrTF6XrgH/YSuO7ZMhFtxqrT7PZb1lR4kSFS0Bw+N00Z96ma/EX
         kBx8zdPxgIU7PRnzZamc4q9zVdlMZeNoCWoo09kGJPCV1MnHRTCZro8KPsWgZnmSV5Dv
         SB0ZMlYrqE+WF8VGOihllrMpNiycwZKKKDTkPILAzcorJqDsAqBs3kwLTqzvjMfPGry6
         TR86EzDBMIr+Wkx14vSfYoDGPQrUt3hUiQQ0wNVW2Av3/9uvWL9/Na3VNBVc0CiKJ0Mt
         n1PaPSgEWveSMGYi61D8fewJSUbv4bWtQlrPE9HLGMzRUDCy5xudSvR/mF3mosnQ0yHx
         mnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=jr8hTaKS8MrCYauE49IsR6qQ2XT9e1L6kQQ5nLMAksA=;
        b=derL+jgjpliDCfaF6U3TOzJz7AGgw5feJoL4Zu5Uzol2a3dVbtKlRcfjvHdWDlRTFN
         C4JmkGGfojRa86rBp4in2579F4Ppykdlc3Q9Ytkpv5xwd80oJLv66vyMBH3vwMd1PeH/
         CYHgeOZR426Mzu+feJkBks6l7EsZVbTDfby2Ujc3cSd0zhnRRmnxNocRBT17Xmp/5VKR
         fYaSIDcRBJXnSJYmVAjDB1WQjyY09wpf4XEcu4FRfz2EUZEDiMF1sYSyO8K9wBNFASBh
         YRdA1AE/uLPy6BCrHeE/jms7TNZ26mmX6NqDY3Rv/can0wLrKdFoxJ8DyiwdbhVarx2c
         4jjw==
X-Gm-Message-State: APjAAAXToSwaGzTtgPSmhnNXGJD21NCO4Cq418RpPPQ1YclLzOLlgbnH
        WfIzL3OHu7c2XVY60tNK2FKuH2Ux
X-Google-Smtp-Source: APXvYqw4JMw99kpxsD07PE+Ap6VM8t7P6R3KqTxt6h2eXglty/7anuENT1znT4NywsVj7VQv04VCQw==
X-Received: by 2002:a81:6389:: with SMTP id x131mr2809045ywb.270.1581695410150;
        Fri, 14 Feb 2020 07:50:10 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d66sm2574758ywc.16.2020.02.14.07.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 07:50:09 -0800 (PST)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01EFo8jo029171;
        Fri, 14 Feb 2020 15:50:08 GMT
Subject: [PATCH RFC 5/9] svcrdma: Add trace point to examine client-provided
 write segment
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 14 Feb 2020 10:50:08 -0500
Message-ID: <20200214155008.3848.6982.stgit@klimt.1015granger.net>
In-Reply-To: <20200214151427.3848.49739.stgit@klimt.1015granger.net>
References: <20200214151427.3848.49739.stgit@klimt.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure clients send large enough Write chunks.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h          |    7 ++++---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   12 +++++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 6f0d3e8ce95c..773f6d9fd800 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1507,7 +1507,7 @@
 );
 
 #define DEFINE_SEGMENT_EVENT(name)					\
-		DEFINE_EVENT(svcrdma_segment_event, svcrdma_encode_##name,\
+		DEFINE_EVENT(svcrdma_segment_event, svcrdma_##name,\
 				TP_PROTO(				\
 					u32 handle,			\
 					u32 length,			\
@@ -1515,8 +1515,9 @@
 				),					\
 				TP_ARGS(handle, length, offset))
 
-DEFINE_SEGMENT_EVENT(rseg);
-DEFINE_SEGMENT_EVENT(wseg);
+DEFINE_SEGMENT_EVENT(decode_wseg);
+DEFINE_SEGMENT_EVENT(encode_rseg);
+DEFINE_SEGMENT_EVENT(encode_wseg);
 
 DECLARE_EVENT_CLASS(svcrdma_chunk_event,
 	TP_PROTO(
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 71127d898562..2f16c0625226 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -420,13 +420,19 @@ static __be32 *xdr_check_write_chunk(__be32 *p, const __be32 *end,
 
 	segcount = be32_to_cpup(p++);
 	for (i = 0; i < segcount; i++) {
-		p++;	/* handle */
-		if (be32_to_cpup(p++) > maxlen)
+		u32 handle, length;
+		u64 offset;
+
+		handle = be32_to_cpup(p++);
+		length = be32_to_cpup(p++);
+		if (length > maxlen)
 			return NULL;
-		p += 2;	/* offset */
+		p = xdr_decode_hyper(p, &offset);
 
 		if (p > end)
 			return NULL;
+
+		trace_svcrdma_decode_wseg(handle, length, offset);
 	}
 
 	return p;

