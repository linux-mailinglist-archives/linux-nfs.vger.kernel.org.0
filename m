Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA832995F2
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781641AbgJZSyY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:54:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35065 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781485AbgJZSyX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:54:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id 140so9394934qko.2;
        Mon, 26 Oct 2020 11:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=uqD6g+Yc2Ltv6zvOspRgs9zml+qI/nm02oprbdY0Ahs=;
        b=YYzVnud07KmBzl7A8HFjxK1cQbpXYowMAnaehNISnnma+3xgncncvzKcfc9xrh5Uza
         Xf6JNgCn+j8Rg75qEhho25Q7xCIS9Ppwcp/uwhk5HdGAw4UKwb7pxvQpIFkPOCeNR681
         EY6F8OKhHTyoOzQqmmhj6/ejPSFP6qrQuLbj7xRvQsgpgYeVxj2Gf+qRQeeUKrSxRzB3
         6+MIn0HhNSMbpQzyhbs0uRNDyNO/fv5Ea/CkequJuRggLgOXmpaR0mJZ/yd+MJ+3ur3w
         t+zzqbwW5MaRm41sc1YKi70g7rDV4Zg9++fh0yN0N2jM+sExCgQcKHO7ISdKZblehNry
         fobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=uqD6g+Yc2Ltv6zvOspRgs9zml+qI/nm02oprbdY0Ahs=;
        b=ttAYUzLpJbNWjFmIqvNvLIzYy048jLX4U8kyvLno+wnUV5oD9tJmO8ttWSZl6TjXuK
         57zlTeQJ05axwotCIJaPj3+5AuMLRPcX6WCuDQo52UvYlbXvRkUat7NtVHipqgPvTT5M
         nuJX56wXFzLpP85dVUs4sjcONRXxbx51NFpsa+IqupjEzkIOF4h1c2Gka6DySKpNb8AC
         8GMxs5SA82vPiddRCcqWCecKeGiUJ77XEPU4oH9ql9a0wkBcVS+7JmB9R97egkQQXVhs
         AmYZpYZkcdWiRbHXf3q9PPcn6yKwZU/7BMqFkEmUtalGIeOY0qH6R0hE9jxBqUiCA9EE
         izbg==
X-Gm-Message-State: AOAM532uQu8dv5Py8mPCgXTOivemHbSMLthQIuIdOVMmmvNI/bNiASij
        2EDiDo57t/bG+4OdsGPVtGi36yQpdb0=
X-Google-Smtp-Source: ABdhPJzvOSxlUtRv3TFnjf6VQ7qciMGpdcnyO97JRNI+CGGUDgh9jb2vi7QY2KHRyx41zY5EH+jYDA==
X-Received: by 2002:a37:74b:: with SMTP id 72mr19405719qkh.429.1603738461294;
        Mon, 26 Oct 2020 11:54:21 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r62sm7245249qkd.80.2020.10.26.11.54.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:54:20 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QIsJRb013628;
        Mon, 26 Oct 2020 18:54:19 GMT
Subject: [PATCH 05/20] NFSD: Invoke svc_encode_result_payload() in "read" NFSD
 encoders
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:54:19 -0400
Message-ID: <160373845951.1886.5782161983478765177.stgit@klimt.1015granger.net>
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Have the NFSD encoders annotate the boundaries of every
direct-data-placement eligible result data payload. Then change
svcrdma to use that annotation instead of the xdr->page_len
when handling Write chunks.

For NFSv4 on RDMA, that enables the ability to recognize multiple
result payloads per compound. This is a pre-requisite for supporting
multiple Write chunks per RPC transaction.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c                     |    4 ++++
 fs/nfsd/nfs4xdr.c                     |    3 +++
 fs/nfsd/nfsxdr.c                      |    4 ++++
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   24 +++++++-----------------
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 9c23b6acf234..f38cd31dbbec 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -720,6 +720,8 @@ nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
 			*p = 0;
 			rqstp->rq_res.tail[0].iov_len = 4 - (resp->len&3);
 		}
+		svc_encode_result_payload(rqstp, rqstp->rq_res.head[0].iov_len,
+					  resp->len);
 		return 1;
 	} else
 		return xdr_ressize_check(rqstp, p);
@@ -746,6 +748,8 @@ nfs3svc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
 			*p = 0;
 			rqstp->rq_res.tail[0].iov_len = 4 - (resp->count & 3);
 		}
+		svc_encode_result_payload(rqstp, rqstp->rq_res.head[0].iov_len,
+					  resp->count);
 		return 1;
 	} else
 		return xdr_ressize_check(rqstp, p);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7e24fb3ca36e..e56f0385022c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3777,6 +3777,8 @@ static __be32 nfsd4_encode_splice_read(
 		buf->page_len = 0;
 		return nfserr;
 	}
+	svc_encode_result_payload(read->rd_rqstp, buf->head[0].iov_len,
+				  maxcount);
 
 	*(p++) = htonl(eof);
 	*(p++) = htonl(maxcount);
@@ -3921,6 +3923,7 @@ nfsd4_encode_readlink(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd
 		xdr_truncate_encode(xdr, length_offset);
 		return nfserr;
 	}
+	svc_encode_result_payload(readlink->rl_rqstp, length_offset, maxcount);
 
 	wire_count = htonl(maxcount);
 	write_bytes_to_xdr_buf(xdr->buf, length_offset, &wire_count, 4);
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 8a288c8fcd57..a23ea58a098e 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -483,6 +483,8 @@ nfssvc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
 		*p = 0;
 		rqstp->rq_res.tail[0].iov_len = 4 - (resp->len&3);
 	}
+	svc_encode_result_payload(rqstp, rqstp->rq_res.head[0].iov_len,
+				  resp->len);
 	return 1;
 }
 
@@ -507,6 +509,8 @@ nfssvc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
 		*p = 0;
 		rqstp->rq_res.tail[0].iov_len = 4 - (resp->count&3);
 	}
+	svc_encode_result_payload(rqstp, rqstp->rq_res.head[0].iov_len,
+				  resp->count);
 	return 1;
 }
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index c8411b4f3492..d6436c13d5c4 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -448,7 +448,6 @@ static ssize_t svc_rdma_encode_write_chunk(__be32 *src,
  * svc_rdma_encode_write_list - Encode RPC Reply's Write chunk list
  * @rctxt: Reply context with information about the RPC Call
  * @sctxt: Send context for the RPC Reply
- * @length: size in bytes of the payload in the first Write chunk
  *
  * The client provides a Write chunk list in the Call message. Fill
  * in the segments in the first Write chunk in the Reply's transport
@@ -465,12 +464,12 @@ static ssize_t svc_rdma_encode_write_chunk(__be32 *src,
  */
 static ssize_t
 svc_rdma_encode_write_list(const struct svc_rdma_recv_ctxt *rctxt,
-			   struct svc_rdma_send_ctxt *sctxt,
-			   unsigned int length)
+			   struct svc_rdma_send_ctxt *sctxt)
 {
 	ssize_t len, ret;
 
-	ret = svc_rdma_encode_write_chunk(rctxt->rc_write_list, sctxt, length);
+	ret = svc_rdma_encode_write_chunk(rctxt->rc_write_list, sctxt,
+					  rctxt->rc_read_payload_length);
 	if (ret < 0)
 		return ret;
 	len = ret;
@@ -923,21 +922,12 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 		goto err0;
 	if (wr_lst) {
 		/* XXX: Presume the client sent only one Write chunk */
-		unsigned long offset;
-		unsigned int length;
-
-		if (rctxt->rc_read_payload_length) {
-			offset = rctxt->rc_read_payload_offset;
-			length = rctxt->rc_read_payload_length;
-		} else {
-			offset = xdr->head[0].iov_len;
-			length = xdr->page_len;
-		}
-		ret = svc_rdma_send_write_chunk(rdma, wr_lst, xdr, offset,
-						length);
+		ret = svc_rdma_send_write_chunk(rdma, wr_lst, xdr,
+						rctxt->rc_read_payload_offset,
+						rctxt->rc_read_payload_length);
 		if (ret < 0)
 			goto err2;
-		if (svc_rdma_encode_write_list(rctxt, sctxt, length) < 0)
+		if (svc_rdma_encode_write_list(rctxt, sctxt) < 0)
 			goto err0;
 	} else {
 		if (xdr_stream_encode_item_absent(&sctxt->sc_stream) < 0)


