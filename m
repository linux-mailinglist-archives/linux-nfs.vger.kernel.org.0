Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90AF517D566
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Mar 2020 19:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCHSPI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Mar 2020 14:15:08 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35313 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgCHSPI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Mar 2020 14:15:08 -0400
Received: by mail-yw1-f67.google.com with SMTP id d79so6787971ywd.2
        for <linux-nfs@vger.kernel.org>; Sun, 08 Mar 2020 11:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=OIQhBIpGgYNYMTZ3v+MEyBMC2pCpDFlmDOogQqb44uU=;
        b=vJ1wdv31Qk4qJipwmz5EUK0wC0g9CEZqWPRhFukJRR+fANsh1hOEc/BYJklYRg2ugr
         OHxtNhLEBj7H+EOkGDAOC+fgKgrR9qtvwFbQd+coJVSYIt+Jzpvtlm01P4tpNDyZFSgt
         Nddm+QDnAF1Pps+sNJLdxvmwvsiVo5UA/Ne8ddZRGet3ARsHxDS/7/D8OPucqOKqcVWq
         1BA2PpvHZAcyxxV/2QOYNarWx7XjkVngb19N2iSibUH51NAdtVwmj6slQa78BLXuKULY
         i60S2CVnFR3GXIRd71IRkg4dKcGCwFJiiF3NFIxAUTlgt5nNAGHb1o1mB8IktkV9+p2G
         Y3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=OIQhBIpGgYNYMTZ3v+MEyBMC2pCpDFlmDOogQqb44uU=;
        b=TYbs6Z7Ofii/1p9/arxS2AJYR9s3m3N5es7t9YFmMTCajuLOgYNLwdKyJMaVqSaZhd
         CiBEWeUomW2UL+bMVRKaGvfrR8TL4DFhwztJi6n8vRuXDnHc59fD0QoZCUQzzkcjddNN
         xVhpP4xTR+20M+mT9eMNcf5pp5GXpEk96riTJV51hnf3EV7KA4jEn3v5LaXNe6t0Bzrd
         CQCnowry3v05JEBVkiV3Avx9PIFyfM1x42LNNeerb+VofYQfwoWRw1HI3xwKyUD2Z1/r
         lYRIBmYJK0YFZMrBvK7OFSkQzTho09r4UlX7kc8fGFxfBhmE199IlqCbKzlW/vQ/4Ooq
         mKkw==
X-Gm-Message-State: ANhLgQ2yNXFeG1nHM/y/ee4O22CJiej0VMgBK+qkHB1bryCLS8v59dbp
        0yhrgua6M8/cwrClVsbIG4Q=
X-Google-Smtp-Source: ADFU+vvoU7OFAmGke7t8bF3jQNV+dunwnrKmq32s8nuheHWz9AEUzAu9wGSoOYgB27dMQByKq3ob+w==
X-Received: by 2002:a25:5b08:: with SMTP id p8mr15321800ybb.446.1583691306917;
        Sun, 08 Mar 2020 11:15:06 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y189sm16371648ywe.21.2020.03.08.11.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2020 11:15:06 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 028IF3uu004526;
        Sun, 8 Mar 2020 18:15:03 GMT
Subject: [PATCH v1 1/2] sunrpc: Fix gss_unwrap_integ_resp() again
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     bcodding@redhat.com
Date:   Sun, 08 Mar 2020 14:15:03 -0400
Message-ID: <20200308181503.14148.29579.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

xdr_buf_read_mic() tries to find unused contiguous space in a
received xdr_buf in order to linearize the checksum for the call
to gss_verify_mic. However, the corner cases in this code are
numerous and we seem to keep missing them. I've just hit yet
another buffer overrun related to it.

This overrun is at the end of xdr_buf_read_mic():

1284         if (buf->tail[0].iov_len != 0)
1285                 mic->data = buf->tail[0].iov_base + buf->tail[0].iov_len;
1286         else
1287                 mic->data = buf->head[0].iov_base + buf->head[0].iov_len;
1288         __read_bytes_from_xdr_buf(&subbuf, mic->data, mic->len);
1289         return 0;

This logic assumes the transport has set the length of the tail
based on the size of the incoming message. base + len is then
supposed to be off the end of the message.

In fact, the length of the tail is set by the upper layer before
the receive so that the end of the tail is actually the end of the
allocated buffer itself. This causes the logic above to set
mic->data to point past the end of the receive buffer.

The "mic->data = head" arm of this if statement is no less fragile.

Instead, let's use a more straightforward approach: kmalloc a
separate buffer to linearize the checksum.

As near as I can tell, this has been a problem forever. I'm not sure
that minimizing au_rslack recently changed this pathology much.

I had some trouble, coming back to this code, understanding what
was going on. So I've cleaned up the variable naming and added
a few comments that point back to the XDR definition in RFC 2203
to help guide future spelunkers, including myself.

As an added clean up, the functionality that was in
xdr_buf_read_mic() is folded directly into gss_unwrap_integ_resp(),
as that is its only caller, and now the code that sets rslack will
be right next to the code that uses that extra space.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/auth_gss.c |   83 ++++++++++++++++++++++++++++++----------
 1 file changed, 62 insertions(+), 21 deletions(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 24ca861815b1..782f2b1f1274 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1934,35 +1934,71 @@ static int gss_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
 	return 0;
 }
 
-static int
+/*
+ * RFC 2203, Section 5.3.2.2
+ *
+ *	struct rpc_gss_integ_data {
+ *		opaque databody_integ<>;
+ *		opaque checksum<>;
+ *	};
+ *
+ *	struct rpc_gss_data_t {
+ *		unsigned int seq_num;
+ *		proc_req_arg_t arg;
+ *	};
+ */
+static noinline_for_stack int
 gss_unwrap_resp_integ(struct rpc_task *task, struct rpc_cred *cred,
 		      struct gss_cl_ctx *ctx, struct rpc_rqst *rqstp,
 		      struct xdr_stream *xdr)
 {
-	struct xdr_buf integ_buf, *rcv_buf = &rqstp->rq_rcv_buf;
-	u32 data_offset, mic_offset, integ_len, maj_stat;
+	struct xdr_buf gss_data, *rcv_buf = &rqstp->rq_rcv_buf;
 	struct rpc_auth *auth = cred->cr_auth;
+	u32 len, offset, seqno, maj_stat;
 	struct xdr_netobj mic;
-	__be32 *p;
+	int ret;
 
-	p = xdr_inline_decode(xdr, 2 * sizeof(*p));
-	if (unlikely(!p))
+	ret = -EIO;
+	mic.data = NULL;
+
+	/* opaque databody_integ<>; */
+	if (xdr_stream_decode_u32(xdr, &len))
 		goto unwrap_failed;
-	integ_len = be32_to_cpup(p++);
-	if (integ_len & 3)
+	if (len & 3)
 		goto unwrap_failed;
-	data_offset = (u8 *)(p) - (u8 *)rcv_buf->head[0].iov_base;
-	mic_offset = integ_len + data_offset;
-	if (mic_offset > rcv_buf->len)
+	offset = rcv_buf->len - xdr_stream_remaining(xdr);
+	if (xdr_stream_decode_u32(xdr, &seqno))
 		goto unwrap_failed;
-	if (be32_to_cpup(p) != rqstp->rq_seqno)
+	if (seqno != rqstp->rq_seqno)
 		goto bad_seqno;
+	if (xdr_buf_subsegment(rcv_buf, &gss_data, offset, len))
+		goto unwrap_failed;
+
+	/*
+	 * The xdr_stream now points to the beginning of the
+	 * upper layer payload, to be passed below to
+	 * rpcauth_unwrap_resp_decode(). The checksum, which
+	 * follows the upper layer payload in @rcv_buf, is
+	 * located and parsed without updating the xdr_stream.
+	 */
 
-	if (xdr_buf_subsegment(rcv_buf, &integ_buf, data_offset, integ_len))
+	/* opaque checksum<>; */
+	offset += len;
+	if (xdr_decode_word(rcv_buf, offset, &len))
 		goto unwrap_failed;
-	if (xdr_buf_read_mic(rcv_buf, &mic, mic_offset))
+	offset += sizeof(__be32);
+	if (len > GSS_VERF_SLACK << 2)
 		goto unwrap_failed;
-	maj_stat = gss_verify_mic(ctx->gc_gss_ctx, &integ_buf, &mic);
+	if (offset + len > rcv_buf->len)
+		goto unwrap_failed;
+	mic.len = len;
+	mic.data = kmalloc(len, GFP_NOFS);
+	if (!mic.data)
+		goto unwrap_failed;
+	if (read_bytes_from_xdr_buf(rcv_buf, offset, mic.data, mic.len))
+		goto unwrap_failed;
+
+	maj_stat = gss_verify_mic(ctx->gc_gss_ctx, &gss_data, &mic);
 	if (maj_stat == GSS_S_CONTEXT_EXPIRED)
 		clear_bit(RPCAUTH_CRED_UPTODATE, &cred->cr_flags);
 	if (maj_stat != GSS_S_COMPLETE)
@@ -1970,19 +2006,24 @@ static int gss_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
 
 	auth->au_rslack = auth->au_verfsize + 2 + 1 + XDR_QUADLEN(mic.len);
 	auth->au_ralign = auth->au_verfsize + 2;
-	return 0;
+	ret = 0;
+
+out:
+	kfree(mic.data);
+	return ret;
+
 unwrap_failed:
 	trace_rpcgss_unwrap_failed(task);
-	return -EIO;
+	goto out;
 bad_seqno:
-	trace_rpcgss_bad_seqno(task, rqstp->rq_seqno, be32_to_cpup(p));
-	return -EIO;
+	trace_rpcgss_bad_seqno(task, rqstp->rq_seqno, seqno);
+	goto out;
 bad_mic:
 	trace_rpcgss_verify_mic(task, maj_stat);
-	return -EIO;
+	goto out;
 }
 
-static int
+static noinline_for_stack int
 gss_unwrap_resp_priv(struct rpc_task *task, struct rpc_cred *cred,
 		     struct gss_cl_ctx *ctx, struct rpc_rqst *rqstp,
 		     struct xdr_stream *xdr)

