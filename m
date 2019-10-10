Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6BBD29E9
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2019 14:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387872AbfJJMrF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Oct 2019 08:47:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45174 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387594AbfJJMrE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Oct 2019 08:47:04 -0400
Received: by mail-io1-f68.google.com with SMTP id c25so13233047iot.12
        for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2019 05:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=07aZGDA+cLPH1KOOSyLBLamAyYdD/WVZ9jB6KzMf93c=;
        b=eqq6WxCuB4K7scUE/4K6UQZlOmciLYR9pPagH0hZma8hY5n7GgLEVr4zhAnbOyXXar
         yoKCrfXea+CE2SK1Qix3XVTOXV5lrDktCfHIfGr9zWRa/flXPdQcZJfhpncSMqL+oWxm
         QVT/Lq/O/xG/ciLiW7mkd9JMvGqWwH86D58phqJze95LE59O16EsWPeB8eECvnjC/LsF
         j6gj6Ba88RIWO+xi37iG9JUqEZfLNh9m9vqXsG29AuLbQlwWOUuFlZz0iwbEKJjejKp4
         njA/LhjRBhLhigLkwvFtfOmwWhCz/7w6nDSsFo9tzWUZvOWoW/NeZdRd6d8OfO7mpZgZ
         BHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=07aZGDA+cLPH1KOOSyLBLamAyYdD/WVZ9jB6KzMf93c=;
        b=VWMCgvgbMvKEKk6vP18C0qezyCmTsWkZy1NS1+7Gx0k/lkqhSuPGFZXEd2O8FC4e7F
         fTbg14g/+/nGKpym9epMFdUh58qLT5Jryi5lsio/jvy0tblMWZy1TzMZMZfaOk0Q3PBI
         wM7e3ClJ/5AOvidxSleEcCq37ZrqyRVQSh+uBZX/k2Ndah/EaEnD1dnB5U4GMYCeW3Cr
         +p+fOtj2CURIhpyTwYmnB9/c85uiF710xHBHeJi6p8eqJE1EPXvI0gEyUEJQphtRXPYX
         HSPEJhJpMHvsg5ITLKGgNYnIb2+Z5O0UUWeA0ZdnXLxdr5BHiQO3VFVT3TrPr/8eB8ju
         0V9Q==
X-Gm-Message-State: APjAAAVbAdqVfkvTiXE7w9aGr0LSjCs3WjzceXULMs8yCyXdeAI9bH9c
        0o3s9CgFxOHURxuQiYIA2kc=
X-Google-Smtp-Source: APXvYqwFrsizpwo3prAUcZ7c2ep0M/G1ti7lXv9IlKrbLXL07v+MHUjZtLzt+sMKkN9lInHmbl4NWA==
X-Received: by 2002:a5d:9ecc:: with SMTP id a12mr1498035ioe.195.1570711622787;
        Thu, 10 Oct 2019 05:47:02 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r2sm1100930ilm.17.2019.10.10.05.47.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Oct 2019 05:47:02 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 15/20] NFSD COPY_NOTIFY xdr
Date:   Thu, 10 Oct 2019 08:46:17 -0400
Message-Id: <20191010124622.27812-16-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
References: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4proc.c | 28 +++++++++++++++++
 fs/nfsd/nfs4xdr.c  | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/xdr4.h     | 13 ++++++++
 3 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4e3e77b..7fa694d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1338,6 +1338,13 @@ struct nfsd4_copy *
 }
 
 static __be32
+nfsd4_copy_notify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+		  union nfsd4_op_u *u)
+{
+	return nfserr_notsupp;
+}
+
+static __be32
 nfsd4_fallocate(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		struct nfsd4_fallocate *fallocate, int flags)
 {
@@ -2290,6 +2297,21 @@ static inline u32 nfsd4_offload_status_rsize(struct svc_rqst *rqstp,
 		1 /* osr_complete<1> optional 0 for now */) * sizeof(__be32);
 }
 
+static inline u32 nfsd4_copy_notify_rsize(struct svc_rqst *rqstp,
+					struct nfsd4_op *op)
+{
+	return (op_encode_hdr_size +
+		3 /* cnr_lease_time */ +
+		1 /* We support one cnr_source_server */ +
+		1 /* cnr_stateid seq */ +
+		op_encode_stateid_maxsz /* cnr_stateid */ +
+		1 /* num cnr_source_server*/ +
+		1 /* nl4_type */ +
+		1 /* nl4 size */ +
+		XDR_QUADLEN(NFS4_OPAQUE_LIMIT) /*nl4_loc + nl4_loc_sz */)
+		* sizeof(__be32);
+}
+
 #ifdef CONFIG_NFSD_PNFS
 static inline u32 nfsd4_getdeviceinfo_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 {
@@ -2714,6 +2736,12 @@ static inline u32 nfsd4_seek_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 		.op_name = "OP_OFFLOAD_CANCEL",
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
+	[OP_COPY_NOTIFY] = {
+		.op_func = nfsd4_copy_notify,
+		.op_flags = OP_MODIFIES_SOMETHING,
+		.op_name = "OP_COPY_NOTIFY",
+		.op_rsize_bop = nfsd4_copy_notify_rsize,
+	},
 };
 
 /**
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a664c18..a7b8b81 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1838,6 +1838,18 @@ static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
 }
 
 static __be32
+nfsd4_decode_copy_notify(struct nfsd4_compoundargs *argp,
+			 struct nfsd4_copy_notify *cn)
+{
+	int status;
+
+	status = nfsd4_decode_stateid(argp, &cn->cpn_src_stateid);
+	if (status)
+		return status;
+	return nfsd4_decode_nl4_server(argp, &cn->cpn_dst);
+}
+
+static __be32
 nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *seek)
 {
 	DECODE_HEAD;
@@ -1938,7 +1950,7 @@ static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
 	/* new operations for NFSv4.2 */
 	[OP_ALLOCATE]		= (nfsd4_dec)nfsd4_decode_fallocate,
 	[OP_COPY]		= (nfsd4_dec)nfsd4_decode_copy,
-	[OP_COPY_NOTIFY]	= (nfsd4_dec)nfsd4_decode_notsupp,
+	[OP_COPY_NOTIFY]	= (nfsd4_dec)nfsd4_decode_copy_notify,
 	[OP_DEALLOCATE]		= (nfsd4_dec)nfsd4_decode_fallocate,
 	[OP_IO_ADVISE]		= (nfsd4_dec)nfsd4_decode_notsupp,
 	[OP_LAYOUTERROR]	= (nfsd4_dec)nfsd4_decode_notsupp,
@@ -4318,6 +4330,46 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 }
 
 static __be32
+nfsd42_encode_nl4_server(struct nfsd4_compoundres *resp, struct nl4_server *ns)
+{
+	struct xdr_stream *xdr = &resp->xdr;
+	struct nfs42_netaddr *addr;
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, 4);
+	*p++ = cpu_to_be32(ns->nl4_type);
+
+	switch (ns->nl4_type) {
+	case NL4_NETADDR:
+		addr = &ns->u.nl4_addr;
+
+		/* netid_len, netid, uaddr_len, uaddr (port included
+		 * in RPCBIND_MAXUADDRLEN)
+		 */
+		p = xdr_reserve_space(xdr,
+			4 /* netid len */ +
+			(XDR_QUADLEN(addr->netid_len) * 4) +
+			4 /* uaddr len */ +
+			(XDR_QUADLEN(addr->addr_len) * 4));
+		if (!p)
+			return nfserr_resource;
+
+		*p++ = cpu_to_be32(addr->netid_len);
+		p = xdr_encode_opaque_fixed(p, addr->netid,
+					    addr->netid_len);
+		*p++ = cpu_to_be32(addr->addr_len);
+		p = xdr_encode_opaque_fixed(p, addr->addr,
+					addr->addr_len);
+		break;
+	default:
+		WARN_ON_ONCE(ns->nl4_type != NL4_NETADDR);
+		return nfserr_inval;
+	}
+
+	return 0;
+}
+
+static __be32
 nfsd4_encode_copy(struct nfsd4_compoundres *resp, __be32 nfserr,
 		  struct nfsd4_copy *copy)
 {
@@ -4351,6 +4403,40 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 }
 
 static __be32
+nfsd4_encode_copy_notify(struct nfsd4_compoundres *resp, __be32 nfserr,
+			 struct nfsd4_copy_notify *cn)
+{
+	struct xdr_stream *xdr = &resp->xdr;
+	__be32 *p;
+
+	if (nfserr)
+		return nfserr;
+
+	/* 8 sec, 4 nsec */
+	p = xdr_reserve_space(xdr, 12);
+	if (!p)
+		return nfserr_resource;
+
+	/* cnr_lease_time */
+	p = xdr_encode_hyper(p, cn->cpn_sec);
+	*p++ = cpu_to_be32(cn->cpn_nsec);
+
+	/* cnr_stateid */
+	nfserr = nfsd4_encode_stateid(xdr, &cn->cpn_cnr_stateid);
+	if (nfserr)
+		return nfserr;
+
+	/* cnr_src.nl_nsvr */
+	p = xdr_reserve_space(xdr, 4);
+	if (!p)
+		return nfserr_resource;
+
+	*p++ = cpu_to_be32(1);
+
+	return nfsd42_encode_nl4_server(resp, &cn->cpn_src);
+}
+
+static __be32
 nfsd4_encode_seek(struct nfsd4_compoundres *resp, __be32 nfserr,
 		  struct nfsd4_seek *seek)
 {
@@ -4447,7 +4533,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	/* NFSv4.2 operations */
 	[OP_ALLOCATE]		= (nfsd4_enc)nfsd4_encode_noop,
 	[OP_COPY]		= (nfsd4_enc)nfsd4_encode_copy,
-	[OP_COPY_NOTIFY]	= (nfsd4_enc)nfsd4_encode_noop,
+	[OP_COPY_NOTIFY]	= (nfsd4_enc)nfsd4_encode_copy_notify,
 	[OP_DEALLOCATE]		= (nfsd4_enc)nfsd4_encode_noop,
 	[OP_IO_ADVISE]		= (nfsd4_enc)nfsd4_encode_noop,
 	[OP_LAYOUTERROR]	= (nfsd4_enc)nfsd4_encode_noop,
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index e815a9c..8231fe0 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -570,6 +570,18 @@ struct nfsd4_offload_status {
 	u32		status;
 };
 
+struct nfsd4_copy_notify {
+	/* request */
+	stateid_t		cpn_src_stateid;
+	struct nl4_server	cpn_dst;
+
+	/* response */
+	stateid_t		cpn_cnr_stateid;
+	u64			cpn_sec;
+	u32			cpn_nsec;
+	struct nl4_server	cpn_src;
+};
+
 struct nfsd4_op {
 	int					opnum;
 	const struct nfsd4_operation *		opdesc;
@@ -629,6 +641,7 @@ struct nfsd4_op {
 		struct nfsd4_clone		clone;
 		struct nfsd4_copy		copy;
 		struct nfsd4_offload_status	offload_status;
+		struct nfsd4_copy_notify	copy_notify;
 		struct nfsd4_seek		seek;
 	} u;
 	struct nfs4_replay *			replay;
-- 
1.8.3.1

