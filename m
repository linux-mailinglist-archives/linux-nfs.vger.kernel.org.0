Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D43B42C8
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 23:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391618AbfIPVOI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 17:14:08 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45110 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391553AbfIPVOI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 17:14:08 -0400
Received: by mail-io1-f65.google.com with SMTP id f12so2369190iog.12
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 14:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gxw4egQCQ9TVeNqggHC+3R7BB/vNpgZgy5w9tRLKXgk=;
        b=X3E8XE7hwfgTsXRyb4bVokQr0mkv5xZxJeWQSVXPJx/Y2VRCiTNwsg12nVH8cKg/rY
         Fxgf5zgePy9DAWQ8mPz8ehQrKTjJ2/vqbNzHSGnuRLZnlW2bC2ERhpAxtL4TkvdnHLhx
         6ooS3d4vCxxi3MBgY/GsNaPpRv7IKz/Fjq1od2e8O+z4doua2mGn/o0665F5g5Uld/1g
         zfPZ9SRJrf3vaVH372sI2/c6y6SaBlgCEUSuWr+EJyq9D4dLzFGXeap8M6RNF2jf1qV6
         sQYlt6k6rb23WZTCvSrAeUFVBrj5M5psm1XIou9HkspFzSA7Z6HVpMhrRNYYkWoQ6O2t
         Q9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gxw4egQCQ9TVeNqggHC+3R7BB/vNpgZgy5w9tRLKXgk=;
        b=qLk4qYjScv9tvxxEHc920HMWXuK9CF5cDaMaaJ2ZjVu6YvIB7JxNvMSLXlCBVkVXEs
         CMi4mxt7R29ifG0HA39svEN7/a6Th53Ow5LjWlcR+WKiupC87wTeod002++ow09pU1EZ
         gLjDR7SQf1KRl0wtvGQkWjIBheqePe2IpRabkgwTw7hW/0wP+gCc+Atv0faYkR2CCdzP
         X/c2ouNynNrqglfsSRo95uvu/KM5bEBTcwXaqGIzeXBoKlKwWVuoYZOLJv14a7OnHp7d
         U26NCwBMn1eHcz52iQ1PR8ZK4YBXgw/zxh5oMCuxmVAARKi8FY6GhE/C4Gd1HSlecGvL
         jMWA==
X-Gm-Message-State: APjAAAUJh53Friu4KDEdezs6BvTNnqaW0mpoQ+Z/Fs9NSpJX/0f9UUrx
        QuTFnem+nkxyLmnyxDflX2KLTQl8
X-Google-Smtp-Source: APXvYqzKCNOCFMImv9Sd4eXu2TXMdMVgZ00paKyGHEKMWjAZhu2eOUART1l8/D3+9SDjP8pR7P3TaA==
X-Received: by 2002:a5e:8902:: with SMTP id k2mr382986ioj.49.1568668447434;
        Mon, 16 Sep 2019 14:14:07 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l186sm71853ioa.54.2019.09.16.14.14.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 14:14:06 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 12/19] NFSD add ca_source_server<> to COPY
Date:   Mon, 16 Sep 2019 17:13:46 -0400
Message-Id: <20190916211353.18802-13-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
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
index c1fc264..3eccc81 100644
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

