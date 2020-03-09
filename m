Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4AE17E233
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2020 15:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgCIOGY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Mar 2020 10:06:24 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33775 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgCIOGY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Mar 2020 10:06:24 -0400
Received: by mail-yw1-f66.google.com with SMTP id j186so10251999ywe.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Mar 2020 07:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=FZWx7LB7DG4fckJT3E1InpPdRDjbwEBSewZDzTywUcE=;
        b=T4joHODdukDn5sD0hVvu5NypmM7TGNRPwE8MZdISe+D4OitgG6NVK0AMbuRuOAmz5D
         q/lUqo3fz3z62VjFRMMmK1Uu5mOZCxhxwpvOWDYSRJnL0R9Gdqjx6E5NxbCZPBFGjUmE
         6l8FHUOVspPQNPurOJJ9AJyyKuwKDvow/ZigNsOTIwiVYjHg/jpZ9o0Aq3xcoePv+oDw
         mLejPVlD22BAKp4gmSK0XK8L2ZKJTV4WAsQLiIvBVIxFLv3T/rDUG1Va6qhIdnQUAeua
         tE+aVWZf5t+Xq10HNmh7S5x2ujKDU/RO4x4ckf9an75Q/Y8IkdwAS8HvB1/6qE67bg83
         koww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=FZWx7LB7DG4fckJT3E1InpPdRDjbwEBSewZDzTywUcE=;
        b=pfDQ0+lhifylRC+Ho/6rXPgk/sjCcDFOJnE8ELtjJuK1S32n0+GtjLk802lHDfIDeW
         FoYt1O5E++c8beMjc2Jfs0Q2Q8KSf1T8QCONQHRlNepfMb8bRm/xVzVV6xqZd32ShDD7
         yTjFCgLmE4GTiivzvQ4VOttRZKFRLeu65keDU6UViJaDb1/LKbhWM6mOgO3byxU4g57H
         ncdc1MTnlSSAZ6vVq48JXrN1f1/s1pJuzWV9m/qrTjXi3vrBT1QHxmYnaXZLjArHJWPH
         3WsHBUosaPU3iO8JvBX1Jc15WQy5N9fZhIhzDfRd/ZLlLpx4lUTyC78Eu9rMw2ONY3gY
         yzIQ==
X-Gm-Message-State: ANhLgQ0D4RPQodiBKz5fRuIiy6zHPPtVFAfmpO1nnFJHYw0/nS8Vp92W
        MKxqKGd27io6ew7hSlLSxNBbdJ7l2r0=
X-Google-Smtp-Source: ADFU+vvLeig804v8b0I0DEzNsKkXWqpUEN5Bx8xCTIQjZyNDYfxehP7NB5j3feTvdR8QOYwv57T0hw==
X-Received: by 2002:a81:5806:: with SMTP id m6mr17226054ywb.69.1583762781052;
        Mon, 09 Mar 2020 07:06:21 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q188sm9086912ywb.70.2020.03.09.07.06.19
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2020 07:06:19 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 029E6IhP007533
        for <linux-nfs@vger.kernel.org>; Mon, 9 Mar 2020 14:06:18 GMT
Subject: [PATCH v2 1/3] sunrpc: Fix gss_unwrap_resp_integ() again
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 09 Mar 2020 10:06:18 -0400
Message-ID: <20200309140618.2637.48251.stgit@manet.1015granger.net>
In-Reply-To: <20200309140301.2637.9696.stgit@manet.1015granger.net>
References: <20200309140301.2637.9696.stgit@manet.1015granger.net>
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
based on the size of the received message. base + len is then
supposed to be off the end of the message but still within the
actual buffer.

In fact, the length of the tail is set by the upper layer when the
Call is encoded so that the end of the tail is actually the end of
the allocated buffer itself. This causes the logic above to set
mic->data to point past the end of the receive buffer.

The "mic->data = head" arm of this if statement is no less fragile.

As near as I can tell, this has been a problem forever. I'm not sure
that minimizing au_rslack recently changed this pathology much.

So instead, let's use a more straightforward approach: kmalloc a
separate buffer to linearize the checksum. This is similar to
how gss_validate() currently works.

Coming back to this code, I had some trouble understanding what
was going on. So I've cleaned up the variable naming and added
a few comments that point back to the XDR definition in RFC 2203
to help guide future spelunkers, including myself.

As an added clean up, the functionality that was in
xdr_buf_read_mic() is folded directly into gss_unwrap_resp_integ(),
as that is its only caller.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
---
 net/sunrpc/auth_gss/auth_gss.c |   79 ++++++++++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 19 deletions(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 24ca861815b1..fa991f4fe53a 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1934,35 +1934,71 @@ static int gss_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
 	return 0;
 }
 
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
 static int
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
 
-	if (xdr_buf_subsegment(rcv_buf, &integ_buf, data_offset, integ_len))
+	/*
+	 * The xdr_stream now points to the beginning of the
+	 * upper layer payload, to be passed below to
+	 * rpcauth_unwrap_resp_decode(). The checksum, which
+	 * follows the upper layer payload in @rcv_buf, is
+	 * located and parsed without updating the xdr_stream.
+	 */
+
+	/* opaque checksum<>; */
+	offset += len;
+	if (xdr_decode_word(rcv_buf, offset, &len))
+		goto unwrap_failed;
+	offset += sizeof(__be32);
+	if (len > GSS_VERF_SLACK << 2)
 		goto unwrap_failed;
-	if (xdr_buf_read_mic(rcv_buf, &mic, mic_offset))
+	if (offset + len > rcv_buf->len)
 		goto unwrap_failed;
-	maj_stat = gss_verify_mic(ctx->gc_gss_ctx, &integ_buf, &mic);
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
@@ -1970,16 +2006,21 @@ static int gss_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
 
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
 
 static int

