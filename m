Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 080CDB42CB
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 23:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391664AbfIPVOK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 17:14:10 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40977 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391594AbfIPVOK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 17:14:10 -0400
Received: by mail-io1-f65.google.com with SMTP id r26so2428198ioh.8
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 14:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hjAJTKN2Wr909eRk4xvtUyAslhnEEJ+P1ZIFM0yaDRI=;
        b=vgeS23BurDTFBecbxcL1JBbghsCYZzqkVvqZuDoEJuW/boP0xOXyNwkoEGArNi2AHJ
         610H0IcNYi1AsM8nXq+/2XE8/fQArw+1td1orzhWIDIjeK3hpZNSZTWISFHccXcv7KDr
         rM4rQNESlC/R5YhcHZuCqQLKCIgke+qx8eZWNvcIFu9lZtFvQOzAcLZaqmx/LiS+287H
         pIm6RpcNs+hQta8dFBYhkMXf88Ttv80sAc/7ltAdA2OMiZ3jMx4eoc4nyyme6jaHo9kZ
         +IDA9mm1UyvB6YSmNHGHhpv2wxOQDcYXzJiyt6RFHINTiSrmZIdOD4/4Cv6bj4ADjRk+
         6d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hjAJTKN2Wr909eRk4xvtUyAslhnEEJ+P1ZIFM0yaDRI=;
        b=E9QAUmb9P2lnH3CxmMneVkVCmdcTMmMbHIUzGe99J1FE0RSAGi7GhD1Umy1SXhwnzW
         Vntu9sLPX6Gbb/0qNpU137MTmOFi9Zn/1+fZaW1ZoUwC8im5nU9yeFrVX8Ai8mcd8UAD
         vu7nrqI9OnNzJHfD7eC3RskJpFK+uqGpiOLisxuUBdNag8zoZz0TV3YkpT2QzNPVQlHQ
         4uaZm85/MFHLnQr2RmJ26dhot3EjoxN9XeJwmTbLsTdsT/lajXNJIoIz/8x0Zmb5WHaT
         kw2Qpter0H+UXni1KIY/3+eoo6bpueLRHAWoLE+y30oSeDwNB1b800mcy6EcLL50nUhD
         LIcQ==
X-Gm-Message-State: APjAAAXB+2PoXgMfMWxYhEqzL2uRcFva0NYBtr7r3lVKNlz9smxjQXuR
        agE2qum2P0s5mkOXATxy2u8=
X-Google-Smtp-Source: APXvYqy0OPTRvg3NKHK1S22pg0achUvVKRbPL0uaYb9kHDR7Xu3nScxQYwSLacrkkDOsAKvbYP7oTQ==
X-Received: by 2002:a5d:964f:: with SMTP id d15mr376587ios.230.1568668449244;
        Mon, 16 Sep 2019 14:14:09 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l186sm71853ioa.54.2019.09.16.14.14.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 14:14:08 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 14/19] NFSD COPY_NOTIFY xdr
Date:   Mon, 16 Sep 2019 17:13:48 -0400
Message-Id: <20190916211353.18802-15-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
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
index 6c0d216..05519a2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1339,6 +1339,13 @@ struct nfsd4_copy *
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
@@ -2291,6 +2298,21 @@ static inline u32 nfsd4_offload_status_rsize(struct svc_rqst *rqstp,
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
@@ -2715,6 +2737,12 @@ static inline u32 nfsd4_seek_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
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
index 3eccc81..ab6ca65 100644
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
@@ -4323,6 +4335,46 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
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
@@ -4356,6 +4408,40 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
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
@@ -4452,7 +4538,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
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

