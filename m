Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D27B4AC339
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Sep 2019 01:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393157AbfIFXg2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 19:36:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41033 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393113AbfIFXg2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 19:36:28 -0400
Received: by mail-io1-f67.google.com with SMTP id r26so16549450ioh.8
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 16:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ad9FP05nklWlsmsRHyzx7ZbPycps00lZWwtDV1vHy48=;
        b=boy51dEkxUyYM2h3EsmjYONVASnFZ9eUUm7QGt7jyvn9K+qHG+JsVIc7og1KQUA6Ua
         yn80TeeBczq50gFtXGYWAVl8aRu/OGU4lc9DPvciWiLYICeEGXF4wW4/pfYhdLoTB1Px
         NNAZdCATQkZTGllMqA/xKH3Sil3VPd+KddjQogchKU6ZVomuLE8KyzU8qDJtqs4OT8j8
         PvEzL/CC8Ddb3m/5QkG7ZXVedTG9u9LZr44q1Y5nNBkM40ePom8OMK9SoPVJJNII9CbS
         ruAgYvvlUN8yGF3nmpgAZPKqrbuOyG0Jip+ZQXMFPBTelAm7YV77ymECURh2O7qLirYt
         LyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ad9FP05nklWlsmsRHyzx7ZbPycps00lZWwtDV1vHy48=;
        b=gOxW4Z1LG2gZurrM2/rsP0cF16XvBYtSJDpNCgKZT15og++6SxmxkMGVC+9itTYxq6
         cp333k3hAOQd/flx8HX0YYMAgpw3AhLV27G6JPBUCrPO3zUT144s0kKkggnrGktdJPYj
         udkHq8cBnW84b5YvMA7JnTqb/NiJtGhm/+fX9OTA4Aey+zGwOrw5xEapmh2f73Amd8H7
         5i6adhkE3gozh3DYbw8Z9N3DYB3xes/LB1M+p1Gm74egM69IeoXKOKjam9Lrbd4dywaa
         bZBzSmINfoLyFBbE1OPlBb8ztDJBB1eeSzCWykhhcrW6bRGLr0xPjk8U8mB/JTWmF8sR
         pTQQ==
X-Gm-Message-State: APjAAAXC0pvL/0w6x9C0MxSMt06tUSxvLIjg4qBR7A7FKp2z4oTx+XSL
        XO+Z/1OLj90VmbRV+np/Gig=
X-Google-Smtp-Source: APXvYqz7McHxtbBIfavuSElOVzp0K/HJgE7P+dsqz5KSSXYQ9MR1dA24cqwjKaeoUu77Poc5Cni9tw==
X-Received: by 2002:a6b:7207:: with SMTP id n7mr1773710ioc.86.1567812986874;
        Fri, 06 Sep 2019 16:36:26 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r138sm10439360iod.59.2019.09.06.16.36.26
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 16:36:26 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 14/21] NFSD add ca_source_server<> to COPY
Date:   Fri,  6 Sep 2019 19:36:04 -0400
Message-Id: <20190906233611.4031-15-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
References: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Decode the ca_source_server list that's sent but only use the
first one. Presence of non-zero list indicates an "inter" copy.

Signed-off-by: Andy Adamson <andros@netapp.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4xdr.c | 64 +++++++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/xdr4.h    | 12 +++++----
 2 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 442811809f3d..4059a099f16d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -40,6 +40,7 @@
 #include <linux/utsname.h>
 #include <linux/pagemap.h>
 #include <linux/sunrpc/svcauth_gss.h>
+#include <linux/sunrpc/addr.h>
 
 #include "idmap.h"
 #include "acl.h"
@@ -1732,11 +1733,47 @@ nfsd4_decode_clone(struct nfsd4_compoundargs *argp, struct nfsd4_clone *clone)
 	DECODE_TAIL;
 }
 
+static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
+				      struct nl4_server *ns)
+{
+	DECODE_HEAD;
+	struct nfs42_netaddr *naddr;
+
+	READ_BUF(4);
+	ns->nl4_type = be32_to_cpup(p++);
+
+	/* currently support for 1 inter-server source server */
+	switch (ns->nl4_type) {
+	case NL4_NETADDR:
+		naddr = &ns->u.nl4_addr;
+
+		READ_BUF(4);
+		naddr->netid_len = be32_to_cpup(p++);
+		if (naddr->netid_len > RPCBIND_MAXNETIDLEN)
+			goto xdr_error;
+
+		READ_BUF(naddr->netid_len + 4); /* 4 for uaddr len */
+		COPYMEM(naddr->netid, naddr->netid_len);
+
+		naddr->addr_len = be32_to_cpup(p++);
+		if (naddr->addr_len > RPCBIND_MAXUADDRLEN)
+			goto xdr_error;
+
+		READ_BUF(naddr->addr_len);
+		COPYMEM(naddr->addr, naddr->addr_len);
+		break;
+	default:
+		goto xdr_error;
+	}
+	DECODE_TAIL;
+}
+
 static __be32
 nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 {
 	DECODE_HEAD;
-	unsigned int tmp;
+	struct nl4_server *ns_dummy;
+	int i, count;
 
 	status = nfsd4_decode_stateid(argp, &copy->cp_src_stateid);
 	if (status)
@@ -1751,8 +1788,31 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 	p = xdr_decode_hyper(p, &copy->cp_count);
 	p++; /* ca_consecutive: we always do consecutive copies */
 	copy->cp_synchronous = be32_to_cpup(p++);
-	tmp = be32_to_cpup(p); /* Source server list not supported */
+	count = be32_to_cpup(p++);
+
+	copy->cp_intra = false;
+	if (count == 0) { /* intra-server copy */
+		copy->cp_intra = true;
+		goto intra;
+	}
 
+	/* decode all the supplied server addresses but use first */
+	status = nfsd4_decode_nl4_server(argp, &copy->cp_src);
+	if (status)
+		return status;
+
+	ns_dummy = kmalloc(sizeof(struct nl4_server), GFP_KERNEL);
+	if (ns_dummy == NULL)
+		return nfserrno(-ENOMEM);
+	for (i = 0; i < count - 1; i++) {
+		status = nfsd4_decode_nl4_server(argp, ns_dummy);
+		if (status) {
+			kfree(ns_dummy);
+			return status;
+		}
+	}
+	kfree(ns_dummy);
+intra:
 	DECODE_TAIL;
 }
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index d64c870f998a..dedc3162ff5c 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -519,11 +519,13 @@ struct nfsd42_write_res {
 
 struct nfsd4_copy {
 	/* request */
-	stateid_t	cp_src_stateid;
-	stateid_t	cp_dst_stateid;
-	u64		cp_src_pos;
-	u64		cp_dst_pos;
-	u64		cp_count;
+	stateid_t		cp_src_stateid;
+	stateid_t		cp_dst_stateid;
+	u64			cp_src_pos;
+	u64			cp_dst_pos;
+	u64			cp_count;
+	struct nl4_server	cp_src;
+	bool			cp_intra;
 
 	/* both */
 	bool		cp_synchronous;
-- 
2.18.1

