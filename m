Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12CF2B1DF6
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgKMPDJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMPDJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:03:09 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71106C0617A7
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:09 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id 3so6863686qtx.3
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5qrQIaG2kw45GfYKwMRbhtb9V77nVaAXqbpvG9DjnfU=;
        b=imYIgrmTU+6GRPEr/s1C/+8+pLn3lWRbj/2SwBcdOelL5VzQBw72vtkNffOivxjdfM
         iPgie572q05pdtc7Vhjf9qN4sEuz1tPwBPk78ZR3FABAXklPkWjK0ccFpG+MbuFqnNRL
         GuBuWun/DPxwgXF1snCl1eQ/kElqYjGHAm3XK2XExWIKMZnfw8rOpDP86euN6wruk2q8
         ulZ7VB9Txjrd2VnIK3k2mkbZA2M7iAtnPf7WH9W4+0AMqq1PuQnry4KMIPSWMKIBuDHj
         RiEYuqVuxUlu3yejH5covUAJYPVZ4/Qdoxhf55NQHENpuGVqPTWTfJJvJ9/lZhOxqLes
         2dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=5qrQIaG2kw45GfYKwMRbhtb9V77nVaAXqbpvG9DjnfU=;
        b=n5A7CuTyG1UjfAGEQCoSaBmRh1+grxdTHtiD7n60ym8ulwWZkmhJNuceIx2vtqbUCA
         N+d03ORa0ABv3lynNHQHZz+keO9K16/cYhW+kHr5IhWTz6vNOZ1WqkUaUO+JVdSoMC5Z
         yx5r9TIGqIKJU0bm/3qajRCh7oXqjbSCoMbzyFoveyUPSIyW9Fk8pC8/FErs1KvjqjrQ
         geAg48UwSP3KgTKKHO3xKtkiKxj7MSvCDazgFB876Ow3nIjNwGJUe08vEmjxnfsFj3LL
         lshkc9TK4JI2fPnrWFSnsTxELHQsG7xBObWzhYcxGxMPmKcfYfbZXLVEEwPQ4tT/FQEz
         UlIw==
X-Gm-Message-State: AOAM530rcyWcBi6IZRk9+8VPcV8NU3k/KJ8CxoP3mrlTWGMBkokGWmRC
        6XZBbIe2zLDG6TxTGkarla1esyvyLyE=
X-Google-Smtp-Source: ABdhPJyrRWgK5xt9qM32tiRchNqi+/ZaxSYlpMnS+M+A0WZNFScAV4t8pGzs6qptk6sMtihUPmO16g==
X-Received: by 2002:ac8:594f:: with SMTP id 15mr2319839qtz.347.1605279787520;
        Fri, 13 Nov 2020 07:03:07 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i4sm6625933qtw.22.2020.11.13.07.03.06
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:03:06 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF35hW032661
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:03:05 GMT
Subject: [PATCH v1 08/61] NFSD: Replace READ* macros in nfsd4_decode_commit()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:03:05 -0500
Message-ID: <160527978567.6186.7268734548095467052.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c          |   14 +++++++-------
 include/linux/sunrpc/xdr.h |   21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b04407d492bb..2c69bf10d556 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -571,13 +571,13 @@ nfsd4_decode_close(struct nfsd4_compoundargs *argp, struct nfsd4_close *close)
 static __be32
 nfsd4_decode_commit(struct nfsd4_compoundargs *argp, struct nfsd4_commit *commit)
 {
-	DECODE_HEAD;
-
-	READ_BUF(12);
-	p = xdr_decode_hyper(p, &commit->co_offset);
-	commit->co_count = be32_to_cpup(p++);
-
-	DECODE_TAIL;
+	if (xdr_stream_decode_u64(argp->xdr, &commit->co_offset) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u32(argp->xdr, &commit->co_count) < 0)
+		goto xdr_error;
+	return nfs_ok;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 579beeb0dac2..0bee0a6dfc07 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -575,6 +575,27 @@ xdr_stream_decode_u32(struct xdr_stream *xdr, __u32 *ptr)
 	return 0;
 }
 
+/**
+ * xdr_stream_decode_u64 - Decode a 64-bit integer
+ * @xdr: pointer to xdr_stream
+ * @ptr: location to store 64-bit integer
+ *
+ * Return values:
+ *   %0 on success
+ *   %-EBADMSG on XDR buffer overflow
+ */
+static inline ssize_t
+xdr_stream_decode_u64(struct xdr_stream *xdr, __u64 *ptr)
+{
+	const size_t count = sizeof(*ptr);
+	__be32 *p = xdr_inline_decode(xdr, count);
+
+	if (unlikely(!p))
+		return -EBADMSG;
+	xdr_decode_hyper(p, ptr);
+	return 0;
+}
+
 /**
  * xdr_stream_decode_opaque_fixed - Decode fixed length opaque xdr data
  * @xdr: pointer to xdr_stream


