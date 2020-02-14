Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDEF15F44F
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 19:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgBNPuH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 10:50:07 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33279 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730359AbgBNPuG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 10:50:06 -0500
Received: by mail-yb1-f193.google.com with SMTP id b6so4973590ybr.0;
        Fri, 14 Feb 2020 07:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jwD0yJAXKb6aNGl1dFtvN1rJFxGMRVHOHNoorWVyGAc=;
        b=V37hCgX9nes1YzhwO6Z/or5d0Yo4egTb21I173GJXMVjmlAkFsAW16uMvaKfvs9txI
         /i9vxqOchC3llvzabnDkfP7yrFxkN1tPLiGUE+HKhaDqwcWiQkUGH1YmZTd+2CRz8gzk
         bQ8+X+Fs4MBqn1U3Ve7BBCg97jpoHDkC1o0LyGlZ8fOlZ+PpCUQ8QzLAq9CC1AseIGb0
         N1P2fJfQZwwP3Je3boexOKJO6Iq36ETOibXaRVj1Cliu3yQV0Bs2tuDxASyJRi4F34Db
         p1TRO0d0Ds5UXx/1S+rT4xRXG3XYjZCFcsG+7X4qIzF9P2KCaV/IsJaHyazGavbnaLNz
         ZbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=jwD0yJAXKb6aNGl1dFtvN1rJFxGMRVHOHNoorWVyGAc=;
        b=PaDX/RCqlaW0xXRAAx27PWUpfBGNgx4qXcqB0Qvd7by+rpipzHBVc9XFezkFaU6mx1
         H2Z7rw5DCashJPprzX5gcBqpeE8aYhwq1caVM4qYlEnBHXwp+HwiLT8OtWfWl02qs/9/
         H2hQCKnk4bDM1gErLF06i5lt1FfER7Zd7ziGAjzMiJeKZ6nKg+5kPUw3gI+2eBYwLUY5
         AsL75/BHXjpjlQKHVaDgaPOfb4dRXgIrUf2LBzctMkmaZ83/a4ds+g2lDpXZ4mhQO8yf
         A51DLo7/cWcS/U0ZVpzIGAbHTs6WPr/xpX5bgR70nV3G6XJShVm9gFYA5305Bncvqsw/
         IFgA==
X-Gm-Message-State: APjAAAVHBqWpNK1Tsf2PIylYgwOHKB2YZRpALBSOwEpJ1XQrxfos+rCe
        Stourj56IkxKeqXDDXj6ThLjJZRw
X-Google-Smtp-Source: APXvYqxZv2gV+4bJllDK70UW7Zt5C9H2eYKWzwoo/Qk4hRCg1n1AQ8f8aNlpwogctxku36TekO9FRQ==
X-Received: by 2002:a25:80c5:: with SMTP id c5mr3100155ybm.364.1581695404940;
        Fri, 14 Feb 2020 07:50:04 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r64sm2657589ywg.84.2020.02.14.07.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 07:50:04 -0800 (PST)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01EFo3Ml029168;
        Fri, 14 Feb 2020 15:50:03 GMT
Subject: [PATCH RFC 4/9] NFSD: Invoke svc_encode_read_payload in "read" NFSD
 encoders
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 14 Feb 2020 10:50:03 -0500
Message-ID: <20200214155003.3848.37713.stgit@klimt.1015granger.net>
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
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   15 +++------------
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index aae514d40b64..8c272efbc94e 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -712,6 +712,8 @@ void fill_post_wcc(struct svc_fh *fhp)
 			*p = 0;
 			rqstp->rq_res.tail[0].iov_len = 4 - (resp->len&3);
 		}
+		svc_encode_read_payload(rqstp, rqstp->rq_res.head[0].iov_len,
+					resp->len);
 		return 1;
 	} else
 		return xdr_ressize_check(rqstp, p);
@@ -737,6 +739,8 @@ void fill_post_wcc(struct svc_fh *fhp)
 			*p = 0;
 			rqstp->rq_res.tail[0].iov_len = 4 - (resp->count & 3);
 		}
+		svc_encode_read_payload(rqstp, rqstp->rq_res.head[0].iov_len,
+					resp->count);
 		return 1;
 	} else
 		return xdr_ressize_check(rqstp, p);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 262f9fc76e4e..a8d3f8f035a0 100644
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
@@ -3713,6 +3715,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
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
@@ -462,6 +462,8 @@ __be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *f
 		*p = 0;
 		rqstp->rq_res.tail[0].iov_len = 4 - (resp->len&3);
 	}
+	svc_encode_read_payload(rqstp, rqstp->rq_res.head[0].iov_len,
+				resp->len);
 	return 1;
 }
 
@@ -482,6 +484,8 @@ __be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *f
 		*p = 0;
 		rqstp->rq_res.tail[0].iov_len = 4 - (resp->count&3);
 	}
+	svc_encode_read_payload(rqstp, rqstp->rq_res.head[0].iov_len,
+				resp->count);
 	return 1;
 }
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 8ea21ca351e2..40b4843be869 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -875,18 +875,9 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 
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
 		svc_rdma_xdr_encode_write_list(rdma_resp, wr_lst, ret);

