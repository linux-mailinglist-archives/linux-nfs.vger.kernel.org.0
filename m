Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C980DD29E8
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2019 14:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387835AbfJJMrD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Oct 2019 08:47:03 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32962 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387594AbfJJMrC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Oct 2019 08:47:02 -0400
Received: by mail-io1-f67.google.com with SMTP id z19so13419252ior.0
        for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2019 05:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/NupQn80iXcPRsFgSHA/qnApzmOsUuVJ7pplKwsr+kQ=;
        b=WGuqhtGvuiuxjp6CyFeJvnGQKbi04AFXJC+hgBTbRSp97eQmDed1sowlyqRUr7rQQD
         0upxh3QnFH/5P03p7DxPxfVQ04wzBDvZ5m0ZLVkON33EDIxhwlncaI+tqdjCKWyoodpx
         6wwSLaBGkgs01+cIPOdkbPHA6XnrJbUjwp1hk9CckzqaU4H4DnXedRZZdUKjsD/RsvPf
         RoC46uoAnApqxZuDOW9AvGaZcE4ZFaN+BQwCX2hCy+gnXU0h+fRwME0dtihDeFSKmTuF
         ++2Hp5NSgRDKbnczJxkrkzRMZSICfhwoyWvGAnwlKEs4KHCqNYFJ8mNEVgnwlVt4k39h
         fJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/NupQn80iXcPRsFgSHA/qnApzmOsUuVJ7pplKwsr+kQ=;
        b=eaFSHyZsnKX872ljvE+6DdNFEMck8DZo0wQ9LeYFhZ85BXuSV18oXlZlbTzkgPamlV
         SQ+m7NQTa640ugSqNwSWUHebthommcIuf2307qTG4dC0V55RSelr0HyDzDqsBCbGvIRz
         FeB691nTiYH1w2wHWqhh+X09Rz/iwUqVsT6+or5iWwtwTcf58b2mdktavySoBD1k5+3t
         fIOI2M/SHk5nG1vnubX1Sl2PZysrLuvbPpcft/SZmRefOHxN4/4MlLBqr1h1+mQHh/1M
         pJr55K/ZY40R+FwPxGF0rxvsARgzF1iZg0K9PINjJNbzQZmynBQtl+RreLnbzFsEw9A0
         id0w==
X-Gm-Message-State: APjAAAVW6nJu/J4xIksKUxXopQ/2Y/xZIu8BoG/MuD6v34pmalIhHfz3
        O2wSWTNDHY+DKPhBOIOYS2o=
X-Google-Smtp-Source: APXvYqxbN5tUv6AyUydS+7t9WzMtbj5x5x1QIeiew+M7Cg0FDuhxqovzVbY0ioU37/OlKaygzmeAig==
X-Received: by 2002:a5d:8156:: with SMTP id f22mr10260325ioo.234.1570711621616;
        Thu, 10 Oct 2019 05:47:01 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r2sm1100930ilm.17.2019.10.10.05.47.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Oct 2019 05:47:01 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 14/20] NFSD add ca_source_server<> to COPY
Date:   Thu, 10 Oct 2019 08:46:16 -0400
Message-Id: <20191010124622.27812-15-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
References: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Decode the ca_source_server list that's sent but only use the
first one. Presence of non-zero list indicates an "inter" copy.

Signed-off-by: Andy Adamson <andros@netapp.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4xdr.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/xdr4.h    | 12 +++++-----
 2 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 533d0fc..a664c18 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -40,6 +40,7 @@
 #include <linux/utsname.h>
 #include <linux/pagemap.h>
 #include <linux/sunrpc/svcauth_gss.h>
+#include <linux/sunrpc/addr.h>
 
 #include "idmap.h"
 #include "acl.h"
@@ -1744,10 +1745,47 @@ static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp, str
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
+	struct nl4_server *ns_dummy;
+	int i, count;
 
 	status = nfsd4_decode_stateid(argp, &copy->cp_src_stateid);
 	if (status)
@@ -1762,7 +1800,32 @@ static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp, str
 	p = xdr_decode_hyper(p, &copy->cp_count);
 	p++; /* ca_consecutive: we always do consecutive copies */
 	copy->cp_synchronous = be32_to_cpup(p++);
-	/* tmp = be32_to_cpup(p); Source server list not supported */
+
+	count = be32_to_cpup(p++);
+
+	copy->cp_intra = false;
+	if (count == 0) { /* intra-server copy */
+		copy->cp_intra = true;
+		goto intra;
+	}
+
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
index f4737d6..e815a9c 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -518,11 +518,13 @@ struct nfsd42_write_res {
 
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

