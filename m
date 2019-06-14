Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6AD46881
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2019 22:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfFNUA7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jun 2019 16:00:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36250 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfFNUA7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jun 2019 16:00:59 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so8463320ioh.3
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2019 13:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zi+IwbtumV5UCUL+b2Yo7pz3+p+fyC4kJRneYtlgiV4=;
        b=U+2nBTFQP7QR59mFZAiqYHoeOgDPdfzhHOO/psDk3ayrXas+BqGs5aX/E0yZameZak
         l5TQJtrvwZKnKtIL8rBaDn0iwM8gjmLX+DctfJa5fN5lbjoDnFpDB4qe8z8nFab+MI/i
         Ic1aCbEsHt5B24elrXlasY3mi2WWeUu4NhsI60tkkNsvARRqSKJwbzj8GzP2VCoEBr7X
         JhOPPW+MVhpNvPLJZ0FULbMTYJ0k2j9pCEZjXfyZXRwcEQTi4r7+TohqIVUlnn9UiQKr
         j7gDvWU8xb++ZoGRARqY9dk1o/4ExNmTG7bWkUMkGUeXr1LzKTzx93ceWDLFz5ZVNxj8
         imJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zi+IwbtumV5UCUL+b2Yo7pz3+p+fyC4kJRneYtlgiV4=;
        b=nTaimrMA7KutEEF0LU3E66K/DnGDtjuvUP6T6Itc83ctb/X7cDykYUfjZ64xQ+wTdq
         fgM9dlp+UdS1HL89ve4Lft+FdgGAuCDSOKxIfD1KAjvhogt9gCnRawmHotO5nOZF8hTg
         CQy1w7VyTkvvOooNsfOY9P7sqtgQEFSVUeTZ2VT8gCob74YwZN1WyWGuYshoGnK5N96s
         XjVVxYQjV37kCZllfHx9ez278k3gZgh8BCpbP9d2WAYpbXou5PNRXqvP0vynJTFpG5Ky
         +DXHz+oBgIFSlVPIZ2Gl+mLze/DEmESPi0zswqJ2p7B3KFP72WApoUn8YJXgXLWar/8v
         DlVQ==
X-Gm-Message-State: APjAAAUhut21Ib8r6aIpWWX8kd7euaY6Z5q0vkshKS0T6jfYyHLAyalW
        20Lo7nhATQqbuNfh6eHHt4OuNKPXfFk=
X-Google-Smtp-Source: APXvYqzeEH8K+UP93wdK8d/18rHND+zhVUoS4IgyP7O/dvBon9s6COIJ7Nk1CnmRTIx2GDGmbzt4ag==
X-Received: by 2002:a02:457:: with SMTP id 84mr65119332jab.99.1560542458035;
        Fri, 14 Jun 2019 13:00:58 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id p4sm6528115iod.68.2019.06.14.13.00.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 13:00:57 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/8] NFSD add ca_source_server<> to COPY
Date:   Fri, 14 Jun 2019 16:00:48 -0400
Message-Id: <20190614200054.12394-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190614200054.12394-1-olga.kornievskaia@gmail.com>
References: <20190614200054.12394-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Decode the ca_source_server list that's sent but only use the
first one. Presence of non-zero list indicates an "inter" copy.

Signed-off-by: Andy Adamson <andros@netapp.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4xdr.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/xdr4.h    | 12 +++++----
 2 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 52c4f6d..15f53bb 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -40,6 +40,7 @@
 #include <linux/utsname.h>
 #include <linux/pagemap.h>
 #include <linux/sunrpc/svcauth_gss.h>
+#include <linux/sunrpc/addr.h>
 
 #include "idmap.h"
 #include "acl.h"
@@ -1744,11 +1745,58 @@ static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp, str
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
+	case NL4_NAME:
+	case NL4_URL:
+		READ_BUF(4);
+		ns->u.nl4_str_sz = be32_to_cpup(p++);
+		if (ns->u.nl4_str_sz > NFS4_OPAQUE_LIMIT)
+			goto xdr_error;
+
+		READ_BUF(ns->u.nl4_str_sz);
+		COPYMEM(ns->u.nl4_str,
+			ns->u.nl4_str_sz);
+		break;
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
@@ -1763,8 +1811,31 @@ static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp, str
 	p = xdr_decode_hyper(p, &copy->cp_count);
 	p++; /* ca_consecutive: we always do consecutive copies */
 	copy->cp_synchronous = be32_to_cpup(p++);
-	tmp = be32_to_cpup(p); /* Source server list not supported */
+	count = be32_to_cpup(p++);
 
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
index feeb6d4..513c9ff 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -516,11 +516,13 @@ struct nfsd42_write_res {
 
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

