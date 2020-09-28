Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A2327B2B9
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 19:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgI1RJJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 13:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgI1RJJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Sep 2020 13:09:09 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C6FC0613CE
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:08 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q5so1655722qkc.2
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vsk3YKUWdJNQh0SwkHg3iCY5GwulbWbB4Blb5l9ofqI=;
        b=lXuXhl17oFZdc+n6afs9cy9fRqpjKR5GYLLf18UUqxt1lg//Aw8Ya+tMS55Y9zKal/
         KTB5Aro8sPgHhOnzMqKUAH1wOSEwZrU48e1rpLJpu5vq4MQTmpFPVyBExQ8fjfAo8ukx
         HojtF56W3p8x0e5IJHU2cFOSYVW+SHgEqJSZa5hS1xxX8gED+9+y9KSAuEnULRvqeNvb
         G1wX0Xw/vX81nCNqv35PEoMdgGTsbLC5zPkjgCNwL/5cO9h7cRyKWFtbw2cPViQK+JnV
         lCeJVn4OaovZjAk5ebBqi8vKV01TNocgoVaIzD3LCCjny46rbTbsBpCGs7Qb11Ubr/P/
         3K2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Vsk3YKUWdJNQh0SwkHg3iCY5GwulbWbB4Blb5l9ofqI=;
        b=Kr8zILDkFTT9s+0Ogzczgm6gNgC3QPxx/HCdXj2khYR0Nfl4bRuKZtoTf/Z1GFNUfX
         PUEZkeKPdSYksgPbTGjQr1/CI9ygLsAO49guiotTHFum5pajd3uE8WffttQldA4RDDbR
         jxAWbIE6uLACtEmsXMZdfOhWmlIh401NF6LIE7J0BbClF8XrYS3zcn8LgQkZN3jHYm6C
         f/dT+/a3wuEB1m8qho4+IHsLnUUmw+nXbkB6fyde9mIZufb/CWsuqCbSU4RK/Y0/ZJek
         Hkn+2ixIuEdleffqxp2q9TuWUZagr40Q2UBCzWG6+03Ia5qOAjQuXXx+MPYAlER8Kzmz
         ItPQ==
X-Gm-Message-State: AOAM53244pjDBLYKKMG8yjhubZfncap9g+0UL7NQVPxvBFEcSdZMxuOS
        LdILGHVZ7HmBkXiFWD8JK3k=
X-Google-Smtp-Source: ABdhPJyUW6btLTl+7Af+6R7e16WGrBdKIfHqETcosCynIXSvxtDdOb3scYLng+VuxKonJ2S+cUmadA==
X-Received: by 2002:a37:a250:: with SMTP id l77mr394880qke.219.1601312948083;
        Mon, 28 Sep 2020 10:09:08 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id k20sm2011631qtb.34.2020.09.28.10.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:09:07 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 4/5] NFSD: Return both a hole and a data segment
Date:   Mon, 28 Sep 2020 13:09:00 -0400
Message-Id: <20200928170901.707554-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928170901.707554-1-Anna.Schumaker@Netapp.com>
References: <20200928170901.707554-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

But only one of each right now. We'll expand on this in the next patch.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v5: If we've already encoded a segment, then return a short read if
    later segments return an error for some reason.
---
 fs/nfsd/nfs4xdr.c | 56 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e633e1290c78..7ed9181a69d4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4603,7 +4603,7 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
 static __be32
 nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 			    struct nfsd4_read *read,
-			    unsigned long maxcount,  u32 *eof)
+			    unsigned long *maxcount, u32 *eof)
 {
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file = read->rd_nf->nf_file;
@@ -4614,20 +4614,20 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	__be64 tmp64;
 
 	if (hole_pos > read->rd_offset)
-		maxcount = min_t(unsigned long, maxcount, hole_pos - read->rd_offset);
-	maxcount = min_t(unsigned long, maxcount, (xdr->buf->buflen - xdr->buf->len));
+		*maxcount = min_t(unsigned long, *maxcount, hole_pos - read->rd_offset);
+	*maxcount = min_t(unsigned long, *maxcount, (xdr->buf->buflen - xdr->buf->len));
 
 	/* Content type, offset, byte count */
 	p = xdr_reserve_space(xdr, 4 + 8 + 4);
 	if (!p)
 		return nfserr_resource;
 
-	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, maxcount);
+	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxcount);
 	if (read->rd_vlen < 0)
 		return nfserr_resource;
 
 	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
-			    resp->rqstp->rq_vec, read->rd_vlen, &maxcount, eof);
+			    resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
 	if (nfserr)
 		return nfserr;
 
@@ -4635,7 +4635,7 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
 	tmp64 = cpu_to_be64(read->rd_offset);
 	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
-	tmp = htonl(maxcount);
+	tmp = htonl(*maxcount);
 	write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
 	return nfs_ok;
 }
@@ -4643,11 +4643,19 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 static __be32
 nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
 			    struct nfsd4_read *read,
-			    unsigned long maxcount, u32 *eof)
+			    unsigned long *maxcount, u32 *eof)
 {
 	struct file *file = read->rd_nf->nf_file;
+	loff_t data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
+	unsigned long count;
 	__be32 *p;
 
+	if (data_pos == -ENXIO)
+		data_pos = i_size_read(file_inode(file));
+	else if (data_pos <= read->rd_offset)
+		return nfserr_resource;
+	count = data_pos - read->rd_offset;
+
 	/* Content type, offset, byte count */
 	p = xdr_reserve_space(&resp->xdr, 4 + 8 + 8);
 	if (!p)
@@ -4655,9 +4663,10 @@ nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
 
 	*p++ = htonl(NFS4_CONTENT_HOLE);
 	 p   = xdr_encode_hyper(p, read->rd_offset);
-	 p   = xdr_encode_hyper(p, maxcount);
+	 p   = xdr_encode_hyper(p, count);
 
-	*eof = (read->rd_offset + maxcount) >= i_size_read(file_inode(file));
+	*eof = (read->rd_offset + count) >= i_size_read(file_inode(file));
+	*maxcount = min_t(unsigned long, count, *maxcount);
 	return nfs_ok;
 }
 
@@ -4665,7 +4674,7 @@ static __be32
 nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 		       struct nfsd4_read *read)
 {
-	unsigned long maxcount;
+	unsigned long maxcount, count;
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file;
 	int starting_len = xdr->buf->len;
@@ -4688,6 +4697,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	maxcount = min_t(unsigned long, maxcount,
 			 (xdr->buf->buflen - xdr->buf->len));
 	maxcount = min_t(unsigned long, maxcount, read->rd_length);
+	count    = maxcount;
 
 	eof = read->rd_offset >= i_size_read(file_inode(file));
 	if (eof)
@@ -4696,24 +4706,38 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
 	if (pos == -ENXIO)
 		pos = i_size_read(file_inode(file));
+	else if (pos < 0)
+		pos = read->rd_offset;
 
-	if (pos > read->rd_offset) {
-		maxcount = pos - read->rd_offset;
-		nfserr = nfsd4_encode_read_plus_hole(resp, read, maxcount, &eof);
+	if (pos == read->rd_offset) {
+		maxcount = count;
+		nfserr = nfsd4_encode_read_plus_data(resp, read, &maxcount, &eof);
+		if (nfserr)
+			goto out;
+		count -= maxcount;
+		read->rd_offset += maxcount;
 		segments++;
-	} else {
-		nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
+	}
+
+	if (count > 0 && !eof) {
+		maxcount = count;
+		nfserr = nfsd4_encode_read_plus_hole(resp, read, &maxcount, &eof);
+		if (nfserr)
+			goto out;
+		count -= maxcount;
+		read->rd_offset += maxcount;
 		segments++;
 	}
 
 out:
-	if (nfserr)
+	if (nfserr && segments == 0)
 		xdr_truncate_encode(xdr, starting_len);
 	else {
 		tmp = htonl(eof);
 		write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
 		tmp = htonl(segments);
 		write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
+		nfserr = nfs_ok;
 	}
 
 	return nfserr;
-- 
2.28.0

