Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28EA7AC0CA
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2019 21:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392530AbfIFTqr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 15:46:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34835 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392364AbfIFTqr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 15:46:47 -0400
Received: by mail-io1-f67.google.com with SMTP id f4so14694148ion.2
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 12:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XL+yl/IdkZ6v8a9Bn/wwa3yKd1v2tHt/DxTYczYrYOw=;
        b=pNTTzHJwCgWlHmiE8DHFzPkm27VvVifOfwJ4a7Tl+PxqbMW4+NeQlz60pOytkXqq02
         NMAVMJBk77Y5QS1jY4AnbAGd3JSNNL72r0H0U7b7TTb+0ydqmW2XNLt5H+irRDGxLt1W
         gtJ8cBjeaW6XnlIv+8ndQstrfvjbGNwxP3aJRAM0BKWRe1eyDJWRd2hTH5l5k8To7iMI
         RabdqTxRKAMfM/NzOR3EsbHfudRtk7RLtZl+5I/fGKoxBYhDlPIpDL3uijqxFK17IVps
         D5sAGElTES8jnsxBMMK8NwhIVPZcV50eMZUtyBiJShzTTFmy4oADgoLYK0D8pvPmFpaH
         ZGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XL+yl/IdkZ6v8a9Bn/wwa3yKd1v2tHt/DxTYczYrYOw=;
        b=Sn09VmMHG/SP9hls3Vne91Fgr5CwOeW6tY9HxfsOW4Q1tlqH+yzF7Lagzdhyu4X8j5
         LW3PcpFl3llXKczygUxJZYSJj28I5HbOlH9G3MTPQv3hcW5xgvRnk3scGBkwsHDemsol
         8p7sjbl5dt0WvXn/hFrLYkq0V2Xbnmyh1aLwdjL6ARaCjMS9YfK4YRy0BnKJ5l9IclQu
         ufmi8ndS3byjiYlXZ2R1XfyEj4i5ZH8SejkgOgVnhrB/Fpy9dTG/4G5mpZN544VszVIm
         aQVM3UNbgj2YXl4HtQi3rk52H/oZiSuai7GIArIIFY1nq+0qi90QDGQNupaJNLOstmW5
         IvpA==
X-Gm-Message-State: APjAAAXpPAGiLM5PHuiEZ4UvQ3pBZqbF36WpwXgPGYd5N1rQsgjOM1QF
        bhe6KNLihei+u6WZ/6eeDZM=
X-Google-Smtp-Source: APXvYqw65dprFjRsWkUyZmzMTp7eMnTLxVkYQGpNxVYlUr7fnoAXPugDy/eCFVr+LZ7sbcHK+qT/0A==
X-Received: by 2002:a02:9a12:: with SMTP id b18mr11639326jal.70.1567799206567;
        Fri, 06 Sep 2019 12:46:46 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id i14sm5118085ioi.47.2019.09.06.12.46.45
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 12:46:46 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 12/19] NFSD add ca_source_server<> to COPY
Date:   Fri,  6 Sep 2019 15:46:24 -0400
Message-Id: <20190906194631.3216-13-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
References: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Decode the ca_source_server list that's sent but only use the
first one. Presence of non-zero list indicates an "inter" copy.

Signed-off-by: Andy Adamson <andros@netapp.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4xdr.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/xdr4.h    | 12 ++++++-----
 2 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 4428118..4059a09 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -40,6 +40,7 @@
 #include <linux/utsname.h>
 #include <linux/pagemap.h>
 #include <linux/sunrpc/svcauth_gss.h>
+#include <linux/sunrpc/addr.h>
 
 #include "idmap.h"
 #include "acl.h"
@@ -1732,11 +1733,47 @@ static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp, str
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
@@ -1751,8 +1788,31 @@ static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp, str
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
index d64c870..dedc316 100644
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
1.8.3.1

