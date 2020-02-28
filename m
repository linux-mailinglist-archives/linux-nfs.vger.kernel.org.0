Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8F8172D41
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 01:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgB1Aam (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Feb 2020 19:30:42 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55259 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgB1Aal (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Feb 2020 19:30:41 -0500
Received: by mail-pj1-f65.google.com with SMTP id dw13so503609pjb.4;
        Thu, 27 Feb 2020 16:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OArWSvRlQC6nv37i8m+YGKW30FGPFbQtp+/YdSZuH2k=;
        b=B6gmXhKj1W1BRHRQOEKxbUHpmQwJd60D7TlUa/fcZ2y3sTz4Bu0O1iKGe0Cdr7TtLO
         dcsqFkJxUL1o+oi/HJi3PAwTPIR2I0myQ7DExPp8P94f94pty7d6QpmlqwOlrsBkzcKh
         nanbB5dEsAgE4Mp1DpjXWNDC7sQGOE3mf7rnXcGBoz/oQwXWySoxfuYTr7NKUh9Dyg5A
         ux54Me3csymEMYJd9CyA/KK90l9JaJp/0lYlyyDxv0c4xOUrUNXtL+uC6nTyG7xP7Omn
         OEK9lbaAozWL3836cn72NEV5mnkQ2medo4nkXR14YdnL+swc94DpSkBnFPYNccrzBTeI
         1/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=OArWSvRlQC6nv37i8m+YGKW30FGPFbQtp+/YdSZuH2k=;
        b=Gt58Y4uvf594Uno1AGoS7ODaTQM6EbmixmweMupqY6advYLl6qnIeZde1xqqin/hM9
         CXFZdfilCCr3GgH8Yp0ugSnR8r9/BrDbKt7Bh68RSSGr19/jTu9i3fvcrg03HUrwJkjf
         U734xzZuofQo2kuoN4NN/2DtRDjQTvNxt/lU8hCxLYU6XD/zzWZIA9f6tdL0agIQ5xof
         +4zJjjYboiJL4XiZ7kC7CrM8QXarPEELjC7KYh4pTk1oK3r9CgWfIfmEsNugxCeDKs3g
         78erUMHG53H69eGhtO0bVvobtaOFcBBqnO8i955HXe18w3psUv33siG4v0dp6DggJDKr
         e0CA==
X-Gm-Message-State: APjAAAVteUxjUUfL1pUYmnGFy1zAp1w+6mhpv9E25/2Tuh2xudA8lbKG
        buSopW0qwg8T42Qh8da+NzQ=
X-Google-Smtp-Source: APXvYqzRobcgWXOxFQVSTeFG9jTk1wtm+FxzCvLqNoiITBQVA6hbh8zUJ2uAcaIP58xc5m4MS0WE8w==
X-Received: by 2002:a17:90b:315:: with SMTP id ay21mr1661647pjb.25.1582849840751;
        Thu, 27 Feb 2020 16:30:40 -0800 (PST)
Received: from seurat29.1015granger.net (ip-184-250-247-225.sanjca.spcsdns.net. [184.250.247.225])
        by smtp.gmail.com with ESMTPSA id o2sm2965295pfh.26.2020.02.27.16.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:30:40 -0800 (PST)
Subject: [PATCH v1 02/16] NFSD: Clean up nfsd4_encode_readv
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 27 Feb 2020 19:30:39 -0500
Message-ID: <158284983901.38468.38555112653975164.stgit@seurat29.1015granger.net>
In-Reply-To: <158284930886.38468.17045380766660946827.stgit@seurat29.1015granger.net>
References: <158284930886.38468.17045380766660946827.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Address some minor nits I noticed while working on this function.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 60be969d8be1..262f9fc76e4e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3591,7 +3591,6 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	__be32 nfserr;
 	__be32 tmp;
 	__be32 *p;
-	u32 zzz = 0;
 	int pad;
 
 	/*
@@ -3607,7 +3606,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	v = 0;
 	while (len) {
 		thislen = min_t(long, len, PAGE_SIZE);
-		p = xdr_reserve_space(xdr, (thislen+3)&~3);
+		p = xdr_reserve_space(xdr, thislen);
 		WARN_ON_ONCE(!p);
 		resp->rqstp->rq_vec[v].iov_base = p;
 		resp->rqstp->rq_vec[v].iov_len = thislen;
@@ -3616,7 +3615,6 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	}
 	read->rd_vlen = v;
 
-	len = maxcount;
 	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
 			    resp->rqstp->rq_vec, read->rd_vlen, &maxcount,
 			    &eof);
@@ -3625,16 +3623,17 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 		return nfserr;
 	if (svc_encode_read_payload(resp->rqstp, starting_len + 8, maxcount))
 		return nfserr_io;
-	xdr_truncate_encode(xdr, starting_len + 8 + ((maxcount+3)&~3));
+	xdr_truncate_encode(xdr, starting_len + 8 + xdr_align_size(maxcount));
 
 	tmp = htonl(eof);
 	write_bytes_to_xdr_buf(xdr->buf, starting_len    , &tmp, 4);
 	tmp = htonl(maxcount);
 	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
 
+	tmp = xdr_zero;
 	pad = (maxcount&3) ? 4 - (maxcount&3) : 0;
 	write_bytes_to_xdr_buf(xdr->buf, starting_len + 8 + maxcount,
-								&zzz, pad);
+								&tmp, pad);
 	return 0;
 
 }

