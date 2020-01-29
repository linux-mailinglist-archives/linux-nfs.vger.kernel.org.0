Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 480F714CDFA
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2020 17:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgA2QJs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jan 2020 11:09:48 -0500
Received: from mail-yw1-f47.google.com ([209.85.161.47]:36259 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgA2QJs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jan 2020 11:09:48 -0500
Received: by mail-yw1-f47.google.com with SMTP id n184so80900ywc.3
        for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2020 08:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WkKvIfJrTQeGZW7yCw+WL84e1ZK0VONjBHhyJOTwwMc=;
        b=MXWailiGENaEtGej4aV6KDeGxeRbk8UtJLGFd32zq9rCSP+hjkpspDcXaj1dpfY2q9
         Kym6Y0x594hBb4JEMaqolSEDUoVL2lEwfppoCrBEcPOpKP9rD78FIn6S7JhPdbQ0nX8w
         6JBlRz7aeI+FKwfpXewSFzF8+m50NVB8iY3l1eeVYnBUT9a4CPxf8k6Uro85TfvDSNH3
         aNFBCBIvvUqWwBJP/jZJNF1/m/UsI63JlG4wP4zgNsrTysdPau6q1qxFGCa1Vk4b1IdF
         voxTei0wuIOmg3f9yoLkthgDD42O3DJyMPCHOPxpQyaOX0/PI6f4AuU00NSjBgzeasWk
         DztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=WkKvIfJrTQeGZW7yCw+WL84e1ZK0VONjBHhyJOTwwMc=;
        b=qpx6+LvpdVKZ94MYRb+46Q6+MRC50K4o6ZVBfkCH5mBLh1iI7tSK1Jg04MboRErXKE
         ZFOoDOFsG29Jw0yQ5CS9bLqO+lbgvc9kTmbQ4v7HtcIK7winxaDsHNs45nbbcLfMtQXd
         KwFBpmhKBEMscsIjZJ03IB5zCW7UpHvakf78AVqczw+WK+13Eu6oDJPR76n77NvwWQWP
         GmuGvW8ETCuVWywzsNYuHc9XFcYNCxT9Wqt3Ub/6nwNt+K33KqKJAYEM5+Zo+tNHaRjb
         AyeRIdQ0EPCkRWnLN/QUVcyfRnSB1i1nAjjHdjpF9kgQzKx0/xWAE82irVIIyLGiaqQF
         N71A==
X-Gm-Message-State: APjAAAWxwt2sP7AH6IVGTg0UvmyYtrkDR3p4L3NV7kZXu2cO2MCm3q/c
        oTYX+uz2LbkEqOOe8xNV46E=
X-Google-Smtp-Source: APXvYqyzkNQ1RKmfKV97FjhVlUgkMwiIomofroHWIpya1zqPF8wOADMT5yJ+ggpOfw6YnEzBoyuZvw==
X-Received: by 2002:a81:2e16:: with SMTP id u22mr20761128ywu.422.1580314187429;
        Wed, 29 Jan 2020 08:09:47 -0800 (PST)
Received: from bazille.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m138sm1109683ywd.56.2020.01.29.08.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 08:09:47 -0800 (PST)
Subject: [PATCH RFC 4/8] svcrdma: RDMA transport support for automated
 padding of xdr_buf::pages
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 29 Jan 2020 11:09:46 -0500
Message-ID: <20200129160946.3024.22245.stgit@bazille.1015granger.net>
In-Reply-To: <20200129155516.3024.56575.stgit@bazille.1015granger.net>
References: <20200129155516.3024.56575.stgit@bazille.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


---
 net/sunrpc/xprtrdma/svc_rdma_rw.c     |   13 +++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   27 +++++++++++++++++++--------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 467d40a1dffa..a7fb886ea136 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -14,6 +14,8 @@
 #include "xprt_rdma.h"
 #include <trace/events/rpcrdma.h>
 
+static const __be32 xdr_padding = xdr_zero;
+
 static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc);
 static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc);
 
@@ -559,6 +561,9 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma, __be32 *rp_ch,
 {
 	struct svc_rdma_write_info *info;
 	int consumed, ret;
+	struct kvec pad = {
+		.iov_base = (void *)&xdr_padding,
+	};
 
 	info = svc_rdma_write_info_alloc(rdma, rp_ch);
 	if (!info)
@@ -577,6 +582,14 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma, __be32 *rp_ch,
 		if (ret < 0)
 			goto out_err;
 		consumed += xdr->page_len;
+
+		if (xdr->page_pad) {
+			pad.iov_len = xdr->page_pad;
+			ret = svc_rdma_send_xdr_kvec(info, &pad);
+			if (ret < 0)
+				goto out_err;
+			consumed += pad.iov_len;
+		}
 	}
 
 	if (xdr->tail[0].iov_len) {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 33f817519964..d0f9acfe60a6 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -112,6 +112,8 @@
 #include "xprt_rdma.h"
 #include <trace/events/rpcrdma.h>
 
+static const __be32 xdr_padding = xdr_zero;
+
 static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc);
 
 static inline struct svc_rdma_send_ctxt *
@@ -320,11 +322,6 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct ib_send_wr *wr)
 	return ret;
 }
 
-static u32 xdr_padsize(u32 len)
-{
-	return (len & 3) ? (4 - (len & 3)) : 0;
-}
-
 /* Returns length of transport header, in bytes.
  */
 static unsigned int svc_rdma_reply_hdr_len(__be32 *rdma_resp)
@@ -561,6 +558,8 @@ static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
 					   remaining);
 			pageoff = 0;
 		}
+		if (xdr->page_pad)
+			++elements;
 	}
 
 	/* xdr->tail */
@@ -593,7 +592,7 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
 	if (wr_lst) {
 		u32 xdrpad;
 
-		xdrpad = xdr_padsize(xdr->page_len);
+		xdrpad = xdr_pad_size(xdr->page_len);
 		if (taillen && xdrpad) {
 			tailbase += xdrpad;
 			taillen -= xdrpad;
@@ -614,12 +613,16 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
 			dst += len;
 			pageoff = 0;
 		}
+		if (xdr->page_pad) {
+			memcpy(dst, &xdr_padding, xdr->page_pad);
+			dst += xdr->page_pad;
+		}
 	}
 
 	if (taillen)
 		memcpy(dst, tailbase, taillen);
 
-	ctxt->sc_sges[0].length += xdr->len;
+	ctxt->sc_sges[0].length += xdr_buf_msglen(xdr);
 	ib_dma_sync_single_for_device(rdma->sc_pd->device,
 				      ctxt->sc_sges[0].addr,
 				      ctxt->sc_sges[0].length,
@@ -668,7 +671,7 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	if (wr_lst) {
 		base = xdr->tail[0].iov_base;
 		len = xdr->tail[0].iov_len;
-		xdr_pad = xdr_padsize(xdr->page_len);
+		xdr_pad = xdr_pad_size(xdr->page_len);
 
 		if (len && xdr_pad) {
 			base += xdr_pad;
@@ -693,6 +696,14 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 		remaining -= len;
 		page_off = 0;
 	}
+	if (xdr->page_pad) {
+		++ctxt->sc_cur_sge_no;
+		ret = svc_rdma_dma_map_buf(rdma, ctxt,
+					   (unsigned char *)&xdr_padding,
+					   xdr->page_pad);
+		if (ret < 0)
+			return ret;
+	}
 
 	base = xdr->tail[0].iov_base;
 	len = xdr->tail[0].iov_len;

