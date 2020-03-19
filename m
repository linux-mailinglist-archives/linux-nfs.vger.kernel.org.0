Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3598F18BADF
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 16:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCSPUm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 11:20:42 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43716 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgCSPUm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Mar 2020 11:20:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id l13so2077713qtv.10;
        Thu, 19 Mar 2020 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OkrrehG9xo9jvtaQ6siMXgY5KHjfnEpiFk4fD6yvyD8=;
        b=GGgAJxVrfLoQCNtOptRaBbgsKkS0kgKSsfEgGev3l3U25wVzW5Rz1eP4w6ZBCBGKyz
         x7RupbF3KETUPYUUFer7xM1P4sO0ZqfZJivXXCitR5cMKZLbKtgFdfIwVbfu8DdJy6/6
         PbmYck4uhHIJ6ywBAWXkbcnmxZpUnIZHqvNhe//3A4D5HP8Dc2E6D+rsPiQl4kmJd9kV
         RlUqX7ILmE3TdTvgyHKrsCL2C+wicYURIAafcd6Agd6svNMFOUPEWGN34RzqVHKkzN6K
         TsA8fg215LReRLIeSAx2dfIPlx1SFI8MFKET92LsaUiNf754Uc2UMNLCD8XvL8ff56jZ
         2Vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=OkrrehG9xo9jvtaQ6siMXgY5KHjfnEpiFk4fD6yvyD8=;
        b=LkGu6rJBeZM10SOTiVdvlbiZR6x5niAxkuEQ/LEvZWn0kuOMh5iPmyCyfGC4cjeJuC
         Cq0Vm17cS0+uGdaJdOJSIZJi9JaPRUlN8XujPQseEcpeX8Vbcfn3TNGHqxczNF1bNDtF
         phq3yOyPn2YHGNGZkHGCODByOBNxTT6JjlgQDacuGYgfJAbBQU93WqvrgEY5vkjwKMRk
         WDrOBp4SVh4hVYtKUPH5KZdsz191ElN6Re+s9uOBzTQtt+UXUtTfu2mKJch7C6nZoaIk
         SF52yBjs1DhEtn3JPsfp81vMuDHxX+HBosG22C28fTOqc5uLgQae0QA4OvXvDeNvmWxp
         d58A==
X-Gm-Message-State: ANhLgQ1r5kCCm/bH1zD4Zj0PSs+KsDeO/bVal3oLGwVnhahZiNimo3W4
        VtGxDlJtTy9aC1whLs9pW4g5tG+NE5M=
X-Google-Smtp-Source: ADFU+vtyS+IrHxPmV2hKwQWswW8oGhgAsSPHufmaQBvnuL3VwV9sBdNT2+kTivPlNVf2BPnkcj5McA==
X-Received: by 2002:ac8:3141:: with SMTP id h1mr3509780qtb.108.1584631240889;
        Thu, 19 Mar 2020 08:20:40 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g6sm1668807qtd.85.2020.03.19.08.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:20:40 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 02JFKdvl011154;
        Thu, 19 Mar 2020 15:20:39 GMT
Subject: [PATCH RFC 03/11] NFSD: Invoke svc_encode_read_payload in "read"
 NFSD encoders
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 19 Mar 2020 11:20:39 -0400
Message-ID: <20200319152039.16298.94469.stgit@klimt.1015granger.net>
In-Reply-To: <20200319150136.16298.68813.stgit@klimt.1015granger.net>
References: <20200319150136.16298.68813.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Have the NFSD encoders annotate the boundaries of every
direct-data-placement eligible READ data payload. Then change
svcrdma to use that annotation instead of the xdr->page_len
when handling Write chunks.

For NFSv4 on RDMA, that enables the ability to recognize multiple
READ payloads per compound. Next step is to support multiple Write
chunks.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c                     |    4 ++++
 fs/nfsd/nfs4xdr.c                     |    3 +++
 fs/nfsd/nfsxdr.c                      |    4 ++++
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   24 +++++++-----------------
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index aae514d40b64..8c272efbc94e 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -712,6 +712,8 @@ nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
 			*p = 0;
 			rqstp->rq_res.tail[0].iov_len = 4 - (resp->len&3);
 		}
+		svc_encode_read_payload(rqstp, rqstp->rq_res.head[0].iov_len,
+					resp->len);
 		return 1;
 	} else
 		return xdr_ressize_check(rqstp, p);
@@ -737,6 +739,8 @@ nfs3svc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
 			*p = 0;
 			rqstp->rq_res.tail[0].iov_len = 4 - (resp->count & 3);
 		}
+		svc_encode_read_payload(rqstp, rqstp->rq_res.head[0].iov_len,
+					resp->count);
 		return 1;
 	} else
 		return xdr_ressize_check(rqstp, p);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 996ac01ee977..9c2cfddcc29c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3547,6 +3547,8 @@ static __be32 nfsd4_encode_splice_read(
 		buf->page_len = 0;
 		return nfserr;
 	}
+	svc_encode_read_payload(read->rd_rqstp, buf->head[0].iov_len,
+				maxcount);
 
 	*(p++) = htonl(eof);
 	*(p++) = htonl(maxcount);
@@ -3713,6 +3715,7 @@ nfsd4_encode_readlink(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd
 		xdr_truncate_encode(xdr, length_offset);
 		return nfserr;
 	}
+	svc_encode_read_payload(readlink->rl_rqstp, length_offset, maxcount);
 
 	wire_count = htonl(maxcount);
 	write_bytes_to_xdr_buf(xdr->buf, length_offset, &wire_count, 4);
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index b51fe515f06f..98ea417042a6 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -462,6 +462,8 @@ nfssvc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
 		*p = 0;
 		rqstp->rq_res.tail[0].iov_len = 4 - (resp->len&3);
 	}
+	svc_encode_read_payload(rqstp, rqstp->rq_res.head[0].iov_len,
+				resp->len);
 	return 1;
 }
 
@@ -482,6 +484,8 @@ nfssvc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
 		*p = 0;
 		rqstp->rq_res.tail[0].iov_len = 4 - (resp->count&3);
 	}
+	svc_encode_read_payload(rqstp, rqstp->rq_res.head[0].iov_len,
+				resp->count);
 	return 1;
 }
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 90cba3058f04..0e6372a13018 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -445,7 +445,6 @@ static ssize_t svc_rdma_encode_write_chunk(__be32 *src,
  * svc_rdma_encode_write_list - Encode RPC Reply's Write chunk list
  * @rctxt: Reply context with information about the RPC Call
  * @sctxt: Send context for the RPC Reply
- * @length: size in bytes of the payload in the first Write chunk
  *
  * The client provides a Write chunk list in the Call message. Fill
  * in the segments in the first Write chunk in the Reply's transport
@@ -462,12 +461,12 @@ static ssize_t svc_rdma_encode_write_chunk(__be32 *src,
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
@@ -890,21 +889,12 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
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

