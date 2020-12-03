Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFB32CDF9F
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 21:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgLCUTd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 15:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgLCUTc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 15:19:32 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783C2C061A4F
        for <linux-nfs@vger.kernel.org>; Thu,  3 Dec 2020 12:18:46 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id n132so3427354qke.1
        for <linux-nfs@vger.kernel.org>; Thu, 03 Dec 2020 12:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VpbzW1tJjXNLaoKcxIkBvS9VSfhDnefWLuqJQFG1IaQ=;
        b=W+s96HL43gfE/BdEiVnEe7Y+Kh2Z2lHe0s0rOsGG/vc3xJ0AjnYNIL0orDRUh29om2
         f4Xw2VBnnM3ZuD3wiJzfGcUibOhJFqZW0qq5ZZLQnRzLLKHlrHHofU82bVSYuynJeOd+
         AsN1AJKKM7aPWncZU3Xx5bAzskJ04JZJYdwNmGFjp1Ns6kiKBVJyQsolSZYbBqgpEKgP
         j9U2v+YWCbxX/DjF+ZhAlIFdyDWH9AThA7KLG9pND+78ODe1T8LWqEV2otlSMvx4MRJY
         lsQdH7czMUeYMsb14mhgPbSBiMuyqj+xbnB7fMaVs34Utm4jN/LSBGWbFV1UzHD3UwKi
         8n8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VpbzW1tJjXNLaoKcxIkBvS9VSfhDnefWLuqJQFG1IaQ=;
        b=aB8tskonMc4YCNKAk1N9Fv0A3uOF59AIPW0byowZ7zEnQIdY/rDNpbbxkCTLxZj1gc
         at+wBdSZh1HZBAOOGnxKwqzwBOgX/LPvMd7Wj4aFmRvEEilVu2qsgIn0Ib/N0kEp/WnD
         4ib26QbFhLKvVSi4G6xB+W6apJToha6E4A0tjU7KP3qSMc9hxAiszYqlvXfmiOJQ+OmL
         xU99BX7ByREy/DU2BftCjDjwWJ27Qoz8a93Vp1h+VUflj0sU/u+VA3WkGECVNXm70SqL
         jMoBCFazOOiXnIpd8E12e2UF0+cB2kEChTTBalBQufiTk2NzMMMb/4qDuVrm7cvAMUrB
         IDjA==
X-Gm-Message-State: AOAM533cknPpVEtEXK3xGV2JLmKoZusiOwAMIYmeUC2s6I1zpdmqb3fd
        Zd/sgMZ1RTbteRbksDVg02LGOAZw/jc=
X-Google-Smtp-Source: ABdhPJybVxmZLbXk9DY2ORHjwGbQFh0OjLwVqo//nRluu7kJv796m0vUnIq4zIJfy6zTywAFW6wGnw==
X-Received: by 2002:a05:620a:94d:: with SMTP id w13mr4489799qkw.194.1607026725466;
        Thu, 03 Dec 2020 12:18:45 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id q20sm2194530qtn.80.2020.12.03.12.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 12:18:44 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 2/3] NFS: Allocate a scratch page for READ_PLUS
Date:   Thu,  3 Dec 2020 15:18:40 -0500
Message-Id: <20201203201841.103294-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
References: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We might need this to better handle shifting around data in the reply
buffer.

Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c       |  2 ++
 fs/nfs/read.c           | 13 +++++++++++--
 include/linux/nfs_xdr.h |  1 +
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 8432bd6b95f0..ef095a5f86f7 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1297,6 +1297,8 @@ static int nfs4_xdr_dec_read_plus(struct rpc_rqst *rqstp,
 	struct compound_hdr hdr;
 	int status;
 
+	xdr_set_scratch_buffer(xdr, page_address(res->scratch), PAGE_SIZE);
+
 	status = decode_compound_hdr(xdr, &hdr);
 	if (status)
 		goto out;
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index eb854f1f86e2..012deb5a136f 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -37,15 +37,24 @@ static struct kmem_cache *nfs_rdata_cachep;
 
 static struct nfs_pgio_header *nfs_readhdr_alloc(void)
 {
-	struct nfs_pgio_header *p = kmem_cache_zalloc(nfs_rdata_cachep, GFP_KERNEL);
+	struct nfs_pgio_header *p;
+	struct page *page;
 
-	if (p)
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+
+	p = kmem_cache_zalloc(nfs_rdata_cachep, GFP_KERNEL);
+	if (p) {
 		p->rw_mode = FMODE_READ;
+		p->res.scratch = page;
+	}
 	return p;
 }
 
 static void nfs_readhdr_free(struct nfs_pgio_header *rhdr)
 {
+	__free_page(rhdr->res.scratch);
 	kmem_cache_free(nfs_rdata_cachep, rhdr);
 }
 
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index d63cb862d58e..e0a1c97f11a9 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -659,6 +659,7 @@ struct nfs_pgio_res {
 	struct nfs_fattr *	fattr;
 	__u64			count;
 	__u32			op_status;
+	struct page *		scratch;
 	union {
 		struct {
 			unsigned int		replen;		/* used by read */
-- 
2.29.2

