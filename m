Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92D5F15F462
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 19:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgBNPt5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 10:49:57 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41737 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730276AbgBNPt4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 10:49:56 -0500
Received: by mail-yb1-f195.google.com with SMTP id j11so4949569ybt.8;
        Fri, 14 Feb 2020 07:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OArWSvRlQC6nv37i8m+YGKW30FGPFbQtp+/YdSZuH2k=;
        b=X9HeBIgqkvbSmwKpQmJFMtHX8YDTP7182yUj43/dQOc+4vJ0DFvyS8hgMSWeVV8KVE
         HBr2C2y6WPVu0N3gkMH3B2FKrE36ZhQjkjFVOAp7NUvRSHSrM0wcxaIGvl4BqWRiUgki
         y0YuUFd/pUv9/vLvlau+3Q4/bisAx1zJrvTj6mCLhELJ+uKl1bUWqE+/QLaQA8PBOcdD
         DzPsjnJkqBXOsphfJarOBj4eCHGA+jH5dyTdKIICGmXNT5y9a2HkcO1mCCVp0SApKrfi
         TFFyA+jGLvT8lYsT/eTobOgRagwj7VPMeAXb4PRyTf1s85oUv4HhoZTHsnBvk5Uz54F/
         b2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=OArWSvRlQC6nv37i8m+YGKW30FGPFbQtp+/YdSZuH2k=;
        b=gtyf1qxChzHknuAmo6HeEYdQ/46yNUNpN8iOPCDKvy5ERRy5CN9OQlji2K07vkRXrm
         7LKBjzKI84uhi9RgUjAxv7gObDo58aKX2hZqW3wHBqsacgC1KUxBfZm+64JIdCGJ8UZw
         r2Op2cvcLLNXHJZRvnpl3h3hKqHr+Eg5bP5/y+vKXs80NXrOIQ8Zye3MiSNpnkK5gaBo
         rScyn6t77Jz3ca19+Pqkd/7keGyMOtjPuUhk6HR6+xlnwrh5os2JKemEOQp/3M2guLr5
         TvLUnvx2tzuCSmq3eHcQD8v+ho6Da3PZP1tJpXPZLLivSAoj1sNwbq6g1sD+ELoWNgot
         TCIQ==
X-Gm-Message-State: APjAAAX0jjWr1IYVqdtsvzXa06C1ja8YlA0VX6dbnE5i3Sn4iMmNzbwX
        PggaUDOwEU+54/M0yGE0WmM9r6yF
X-Google-Smtp-Source: APXvYqygAUi6rlnyTjyzIsPG0nXZZ3xVGVAZpSrvpS8M0xAMG3vB3dx0db6wFkGYEPVBELdntuUprA==
X-Received: by 2002:a05:6902:6c1:: with SMTP id m1mr3442569ybt.491.1581695394204;
        Fri, 14 Feb 2020 07:49:54 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s3sm2788345ywf.22.2020.02.14.07.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 07:49:53 -0800 (PST)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01EFnqRC029153;
        Fri, 14 Feb 2020 15:49:52 GMT
Subject: [PATCH RFC 2/9] NFSD: Clean up nfsd4_encode_readv
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 14 Feb 2020 10:49:52 -0500
Message-ID: <20200214154952.3848.15021.stgit@klimt.1015granger.net>
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

