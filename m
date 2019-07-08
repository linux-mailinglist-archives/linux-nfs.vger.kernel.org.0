Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF6326293F
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 21:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390460AbfGHTXx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 15:23:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40111 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbfGHTXx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jul 2019 15:23:53 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so29634901iom.7
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2019 12:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zi+IwbtumV5UCUL+b2Yo7pz3+p+fyC4kJRneYtlgiV4=;
        b=cn0zYQRv7ITo0ZWtqwZb4PoVyAuBzN2wdS8oZWizk14kOVEdExid6t1IxBlOJhGNVG
         5QjvGA/SMzZCqxe08fO7ztuihOo1jdwp6y3N+HJ8zRNLWEGlS6mbx/F3FltWrNRmaAMh
         AzJjS0WVJtOQvJmG6jUnbfsfchZYyWyQyswmSRq66sVFbPdWMnPe7WBCVLnCuNBtgJzd
         pAwne/d96wCeKdyj8HzXtFMzddBfdb7iWBWxP+9K3KlvpV1vKSHJ6WWywmgc769uICHD
         0uof1OC8B8cMORkzsBkXIKblHYtA7c7f0g+75xfyiJljv2s85nw0zPOb3z9t96TC42T9
         35Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zi+IwbtumV5UCUL+b2Yo7pz3+p+fyC4kJRneYtlgiV4=;
        b=jNhYAQSy2Jegu8jlgbq33J45gAm+oI/1X1b7TyjzkrD3C0gQyBbU6ie5IbpahwcZwk
         yc/00XBIq4+k+bl9RV1/NkQXNCHZB27ZezwzEh12i0WKgoL/eJNK13LWeuKGu2MsU03M
         CcPvcPenitvrtjZQwLhdEApI1dJGa2HUdDgvxzj7e3jFTYq+MbJ0Z17CuxHyEkCaoFdi
         kCJtwEssmEV1K/etDy090VbpQ13lo5QTw8JAuVv3Jf8Cspm5TpRjayMXYApywYogmfqI
         n0OvoSQCIQ17IJONsmGOM8zgknELwZBzTVK5SQCWQRXw98qYuqodQOsymZ81EoIZ+svF
         BNFA==
X-Gm-Message-State: APjAAAWjT/h53uwO3xciGT70zuu/bX30iSbcXfHoxcFR8LRQL9ptyE8X
        iPZlw1MjxSWmaiRmlcIZpH0=
X-Google-Smtp-Source: APXvYqy93vcofDZTumreSXjH2ju3+tQMN5oTXYn90qqXxzOe9lKVKy0lddjEGJfoKlNzff3EDut0kg==
X-Received: by 2002:a6b:8bd1:: with SMTP id n200mr21751916iod.134.1562613832619;
        Mon, 08 Jul 2019 12:23:52 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id v3sm9212841iom.53.2019.07.08.12.23.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 12:23:52 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 2/8] NFSD add ca_source_server<> to COPY
Date:   Mon,  8 Jul 2019 15:23:46 -0400
Message-Id: <20190708192352.12614-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
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

