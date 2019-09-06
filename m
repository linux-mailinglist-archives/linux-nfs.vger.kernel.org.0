Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD73AC0CD
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2019 21:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393172AbfIFTqu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 15:46:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42974 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392364AbfIFTqu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 15:46:50 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so15380321iod.9
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 12:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K/AuVBYq4w5K9xS+7EFoEvr1FMTN2qGliNQcl3JnTRQ=;
        b=RYfv86vAv80mi/fQv2+kbz9+PF+mvqQYQZtEiM836X/s+JIY4rXtGlvlimvsrIUjhQ
         nAOXMkv62PdWil7V4zf+DF99d4FaBC7xaa4B7OX5vAi/l3SwmlNeTdtYhWmYH8lbSwO2
         iWYfuZB1d6u3RlNEahaKi6YkkycYAeeRXF0XW6KUgxFa9erEEflr3pCU9w03tDqdd1KS
         5bb24Foccf3jRz0j4WYXePrc7i/pALOCcnagnrXgT328tbGGIhkeR8nhJ17naouFHutk
         C0qHEyZUT/LLWAyww1neRUmNziTavypnmufBo73tVlfey30mWaaMpfeDxis6c2hZ91/m
         XmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K/AuVBYq4w5K9xS+7EFoEvr1FMTN2qGliNQcl3JnTRQ=;
        b=LSwUVewgvkYTHYS8mCesQnSXcTWmrDjvAf8UhkOSDlIqedeXfhnqetkhnKWPfLKj54
         M0FIo6PEsxl/wUsKhnNTnRR3A98qei3cQPPaab78Oi8csb5U2yUWDIq2jOHbXXRps3r8
         yQ/K21bzmvLfy9ehR/15ZxW9E8DMuxOXDep5rFX2ShAKM13oW2cnMhIN20Xhafi8RBNd
         Pbfw2KcvvFTYisfzf93ttid7iqIYn9LRZoh5fjQJb5Y0inyvV4vqt6zp47pPqaMqbpSb
         o/+SK8Hpxhu2YIkv++4fxTLvjO1OHcbb/ydHkwribIe/dHfkml1xo/e5m6I3iFTSFzUN
         TKSw==
X-Gm-Message-State: APjAAAUsa+380Dn8bXQcMYiQakirHSQOeSE3/DV0dYod2kgpAvzIrfQn
        5pPsWWzkT4fCYjPyDtY82N0=
X-Google-Smtp-Source: APXvYqy+GksA7Dg2ck8ujilT7FuiJYgK1uFkvSylrDFdDqdZ2hHvaMaWRhv2ndfWwW8wn4pAC7lfQw==
X-Received: by 2002:a02:7f8a:: with SMTP id r132mr11893101jac.46.1567799208980;
        Fri, 06 Sep 2019 12:46:48 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id i14sm5118085ioi.47.2019.09.06.12.46.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 12:46:48 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 14/19] NFSD COPY_NOTIFY xdr
Date:   Fri,  6 Sep 2019 15:46:26 -0400
Message-Id: <20190906194631.3216-15-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
References: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
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
index 38f15f6..3a2805d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1347,6 +1347,13 @@ struct nfsd4_copy *
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
@@ -2299,6 +2306,21 @@ static inline u32 nfsd4_offload_status_rsize(struct svc_rqst *rqstp,
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
@@ -2723,6 +2745,12 @@ static inline u32 nfsd4_seek_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
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
index 4059a09..81cf049 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1824,6 +1824,18 @@ static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
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
@@ -1924,7 +1936,7 @@ static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
 	/* new operations for NFSv4.2 */
 	[OP_ALLOCATE]		= (nfsd4_dec)nfsd4_decode_fallocate,
 	[OP_COPY]		= (nfsd4_dec)nfsd4_decode_copy,
-	[OP_COPY_NOTIFY]	= (nfsd4_dec)nfsd4_decode_notsupp,
+	[OP_COPY_NOTIFY]	= (nfsd4_dec)nfsd4_decode_copy_notify,
 	[OP_DEALLOCATE]		= (nfsd4_dec)nfsd4_decode_fallocate,
 	[OP_IO_ADVISE]		= (nfsd4_dec)nfsd4_decode_notsupp,
 	[OP_LAYOUTERROR]	= (nfsd4_dec)nfsd4_decode_notsupp,
@@ -4313,6 +4325,46 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
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
@@ -4346,6 +4398,40 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
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
@@ -4442,7 +4528,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	/* NFSv4.2 operations */
 	[OP_ALLOCATE]		= (nfsd4_enc)nfsd4_encode_noop,
 	[OP_COPY]		= (nfsd4_enc)nfsd4_encode_copy,
-	[OP_COPY_NOTIFY]	= (nfsd4_enc)nfsd4_encode_noop,
+	[OP_COPY_NOTIFY]	= (nfsd4_enc)nfsd4_encode_copy_notify,
 	[OP_DEALLOCATE]		= (nfsd4_enc)nfsd4_encode_noop,
 	[OP_IO_ADVISE]		= (nfsd4_enc)nfsd4_encode_noop,
 	[OP_LAYOUTERROR]	= (nfsd4_enc)nfsd4_encode_noop,
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index dedc316..c497032 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -571,6 +571,18 @@ struct nfsd4_offload_status {
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
@@ -630,6 +642,7 @@ struct nfsd4_op {
 		struct nfsd4_clone		clone;
 		struct nfsd4_copy		copy;
 		struct nfsd4_offload_status	offload_status;
+		struct nfsd4_copy_notify	copy_notify;
 		struct nfsd4_seek		seek;
 	} u;
 	struct nfs4_replay *			replay;
-- 
1.8.3.1

