Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538A52BB722
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgKTUei (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbgKTUei (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:34:38 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80468C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:34:36 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id k4so10158718qko.13
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0WdT8NesIVghmR04DBd7FdxBy0Ejv1mbV+HUQlkIjhI=;
        b=cguG11VDRwvoYkysxEJyNgn95fhTAg8cbAbqNKQGZQEkUUC1DRzGnFO2/0JWB44xHd
         LYZz07lecHTnv2iU2sMAYH9jXVaHUEU+u3IP3B8CWyDZqdikp+e9pglUqFyodMlcpqE/
         54GefFMxZRug5d6XiZZsY0Ydi9nkb+A5TnaCl0JgSvmb8o8xh5vlbuwsjnwzUC+KOI6T
         s1J5npJYfNquA/4pXZemoSDye9mamIX4dOKAygnGof7jm36LsHvQIUZlzFt333uJMzd2
         SiUtgAcjOEVG017CiuTlLwkBnOQSRYkig9EUoc01wVr+8GouH7VUvsQxR/x6mfzcSHS7
         +pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=0WdT8NesIVghmR04DBd7FdxBy0Ejv1mbV+HUQlkIjhI=;
        b=LXfALOMo4bXO6Wm3x0YfRbRSNtvQG0Teii6kCfVmilDrx4nXmWZmDZf0jZ49Fj0TS2
         38LMdh+m6moyzwJCmtc5hAD17uXT46GFQ5DxkEaFizn1wjHzc08qvpu0AN+6UFQeIzPE
         eblsaEk+MZ6fIWbPNu0u/D5OArC/egpBoi2TjfKqPPvk7C41C8j1IquTCXKg8zyanZdO
         fzLY51iRtw6Wu5LwxJnU8wGW2VhV+U2NQcamKGG60cpBkg3zF5avcULefaCeA3bY2mtN
         pxt7g9KiHG3GoEuiAlpgRE1ixRm4V7uffL1/5T+t8n0GRPF7P4miBKywHHJvAMR5nJZY
         s/OQ==
X-Gm-Message-State: AOAM533rojzEfPO9f3qpO23fdOvU+Wp7IT32BpWRblTygKA2RTuxdz9F
        4UOb6x+ATW21Bsx7Ae9igo2hpSGB/WM=
X-Google-Smtp-Source: ABdhPJxVFc+3BeRak3m3EefB2Ox9JHoylaiQQ1xafdWnjZf5JFNKp9V7wn3Wv+xtBDfB+ImDRJd8Mg==
X-Received: by 2002:ae9:ed81:: with SMTP id c123mr11591753qkg.349.1605904475495;
        Fri, 20 Nov 2020 12:34:35 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d16sm2836389qkc.58.2020.11.20.12.34.34
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:34:34 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKYXP4029229
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:34:33 GMT
Subject: [PATCH v2 009/118] NFSD: Replace READ* macros in
 nfsd4_decode_commit()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:34:33 -0500
Message-ID: <160590447378.1340.4613012762069336535.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c          |   12 +++++-------
 include/linux/sunrpc/xdr.h |   21 +++++++++++++++++++++
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 06028e4f1b5d..d4b98bd8a859 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -567,13 +567,11 @@ nfsd4_decode_close(struct nfsd4_compoundargs *argp, struct nfsd4_close *close)
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
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &commit->co_count) < 0)
+		return nfserr_bad_xdr;
+	return nfs_ok;
 }
 
 static __be32
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 8f458addfcf0..22b00104bc1a 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -576,6 +576,27 @@ xdr_stream_decode_u32(struct xdr_stream *xdr, __u32 *ptr)
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


