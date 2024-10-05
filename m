Return-Path: <linux-nfs+bounces-6890-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3520499198F
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 20:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97EE1F22164
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 18:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1769D15C14C;
	Sat,  5 Oct 2024 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTZpUnB7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44BA15B555;
	Sat,  5 Oct 2024 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728153259; cv=none; b=fwe8qxa0mN9gUsarL8Wx+QctYkXRA30sHNtydUI8K9/bmI6XXOGKmdwrumvDou/F29YZ6sb4kCMa0GokcMVaU1X+62V77Jl4luSY5S0K/M5fD7CQXArTmFHpRlErXoB0kQt0oAh69Fl28C/WtqKhETRHkrLcCZXgalu6Raqd0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728153259; c=relaxed/simple;
	bh=71PfD3F1IRPLkyDvB62PCToEtPnNfTdJ5369Hk/Hr1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anks+VHMcWzBNIxPO6T4s4jvU3IVk7383/6aV8CPwKJCM+yG0qJRcvM2SmdsptdRWk69oIKNyHDM4DANPexr/5nxc3stg+x3b6Oqw0PcYg8WL+dCEaCsRpFEpZhwZE3KzPkNWpveeew7inydlCP7FK/ckJHsmTfZI8+NGNW2jVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTZpUnB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7397EC4CEC2;
	Sat,  5 Oct 2024 18:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728153258;
	bh=71PfD3F1IRPLkyDvB62PCToEtPnNfTdJ5369Hk/Hr1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HTZpUnB7kt+E+/GIz6nJfCPf5tTxvMnaZXnYnqrJoZoz+XRdxzlfv99ifphcWuOo6
	 jOeg24pIGTARxHO9jUndsWunzG3xOEJgj98bUY/u9bFEQDfkq6p3w+23Ymay3CRJll
	 zelJ3YDg00eItZfOO64ZjQGlR7Uue66b5uC5nFvKpB9uaBYVl58g4tYzpks6ltoOtT
	 rD0dDGZN8colaZXYmyZTYO2wORn8kGxZEQXdqcPBfrzkf5FKzzEgLIrxAZ5dN+WoF0
	 KDBMpM4MrU7ukzvTRI6kTi8ImA2hQv9+Eys+UijuZXujpnJetbLrtODumJJ8ep0Ieb
	 qBHz+QUoZfg7A==
Received: by pali.im (Postfix)
	id DC391648; Sat,  5 Oct 2024 20:34:12 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nfsd: Fill NFSv4.1 server implementation fields in OP_EXCHANGE_ID response
Date: Sat,  5 Oct 2024 20:33:49 +0200
Message-Id: <20241005183349.21845-1-pali@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240912220919.23449-1-pali@kernel.org>
References: <20240912220919.23449-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

NFSv4.1 OP_EXCHANGE_ID response from server may contain server
implementation details (domain, name and build time) in optional
nfs_impl_id4 field. Currently nfsd does not fill this field.

Send these information in NFSv4.1 OP_EXCHANGE_ID response. Fill them with
the same values as what is Linux NFSv4.1 client doing. Domain is hardcoded
to "kernel.org", name is composed in the same way as "uname -srvm" output
and build time is hardcoded to zeros.

NFSv4.1 client and server implementation fields are useful for statistic
purposes or for identifying type of clients and servers.

Signed-off-by: Pali Rohár <pali@kernel.org>

---
Changes in v2:
* Prepare string arguments in nfsd4_exchange_id() instead of in nfsd4_encode_server_impl_id()
* Use nfsd4_encode_*() functions for encoding instead of raw encoders
* Rename nfsd4_encode_nfs_impl_id4() to nfsd4_encode_server_impl_id()
* Remove Kconfig build option for nii_domain
* Remove runtime module option send_implementation_id
---
 fs/nfsd/nfs4proc.c  |  1 +
 fs/nfsd/nfs4state.c | 28 ++++++++++++++++++++++++++++
 fs/nfsd/nfs4xdr.c   | 27 +++++++++++++++++++++++++--
 fs/nfsd/xdr4.h      |  2 ++
 4 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0f67f4a7b8b2..19ffb4f966d0 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3447,6 +3447,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	/* NFSv4.1 operations */
 	[OP_EXCHANGE_ID] = {
 		.op_func = nfsd4_exchange_id,
+		.op_release = nfsd4_exchange_id_release,
 		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP
 				| OP_MODIFIES_SOMETHING,
 		.op_name = "OP_EXCHANGE_ID",
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a366fb1c1b9b..68b38bc41828 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3475,6 +3475,13 @@ static __be32 copy_impl_id(struct nfs4_client *clp,
 	return 0;
 }
 
+void
+nfsd4_exchange_id_release(union nfsd4_op_u *u)
+{
+	struct nfsd4_exchange_id *exid = &u->exchange_id;
+	kfree(exid->server_impl_name);
+}
+
 __be32
 nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
@@ -3495,6 +3502,12 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		__func__, rqstp, exid, exid->clname.len, exid->clname.data,
 		addr_str, exid->flags, exid->spa_how);
 
+	exid->server_impl_name = kasprintf(GFP_KERNEL, "%s %s %s %s",
+					   utsname()->sysname, utsname()->release,
+					   utsname()->version, utsname()->machine);
+	if (!exid->server_impl_name)
+		return nfserr_jukebox;
+
 	if (exid->flags & ~EXCHGID4_FLAG_MASK_A)
 		return nfserr_inval;
 
@@ -3632,6 +3645,21 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	exid->seqid = conf->cl_cs_slot.sl_seqid + 1;
 	nfsd4_set_ex_flags(conf, exid);
 
+	exid->nii_domain.len = sizeof("kernel.org")-1;
+	exid->nii_domain.data = "kernel.org";
+
+	/* Note that RFC 8881 places no length limit on
+	 * nii_name, but this implementation permits no
+	 * more than NFS4_OPAQUE_LIMIT bytes */
+	exid->nii_name.len = strlen(exid->server_impl_name);
+	if (exid->nii_name.len > NFS4_OPAQUE_LIMIT)
+		exid->nii_name.len = NFS4_OPAQUE_LIMIT;
+	exid->nii_name.data = exid->server_impl_name;
+
+	/* just send zeros - the date is in nii_name */
+	exid->nii_time.tv_sec = 0;
+	exid->nii_time.tv_nsec = 0;
+
 	dprintk("nfsd4_exchange_id seqid %d flags %x\n",
 		conf->cl_cs_slot.sl_seqid, conf->cl_exchange_flags);
 	status = nfs_ok;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b45ea5757652..85334f4483eb 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4833,6 +4833,28 @@ nfsd4_encode_server_owner4(struct xdr_stream *xdr, struct svc_rqst *rqstp)
 	return nfsd4_encode_opaque(xdr, nn->nfsd_name, strlen(nn->nfsd_name));
 }
 
+static __be32
+nfsd4_encode_nfs_impl_id4(struct xdr_stream *xdr, struct nfsd4_exchange_id *exid)
+{
+	__be32 status;
+
+	/* array count = 1 */
+	if (xdr_stream_encode_u32(xdr, 1) != XDR_UNIT)
+		return nfserr_resource;
+	/* nii_domain */
+	status = nfsd4_encode_opaque(xdr, exid->nii_domain.data,
+				     exid->nii_domain.len);
+	if (status != nfs_ok)
+		return status;
+	/* nii_name */
+	status = nfsd4_encode_opaque(xdr, exid->nii_name.data,
+				     exid->nii_name.len);
+	if (status != nfs_ok)
+		return status;
+	/* nii_time */
+	return nfsd4_encode_nfstime4(xdr, &exid->nii_time);
+}
+
 static __be32
 nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
 			 union nfsd4_op_u *u)
@@ -4867,8 +4889,9 @@ nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
 	if (nfserr != nfs_ok)
 		return nfserr;
 	/* eir_server_impl_id<1> */
-	if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
-		return nfserr_resource;
+	nfserr = nfsd4_encode_nfs_impl_id4(xdr, exid);
+	if (nfserr != nfs_ok)
+		return nfserr;
 
 	return nfs_ok;
 }
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index fbdd42cde1fa..891861e8bb0c 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -567,6 +567,7 @@ struct nfsd4_exchange_id {
 	struct xdr_netobj nii_domain;
 	struct xdr_netobj nii_name;
 	struct timespec64 nii_time;
+	char *		server_impl_name;
 };
 
 struct nfsd4_sequence {
@@ -929,6 +930,7 @@ extern __be32 nfsd4_setclientid(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *, union nfsd4_op_u *u);
 extern __be32 nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *, union nfsd4_op_u *u);
+void nfsd4_exchange_id_release(union nfsd4_op_u *u);
 extern __be32 nfsd4_exchange_id(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *, union nfsd4_op_u *u);
 extern __be32 nfsd4_backchannel_ctl(struct svc_rqst *,
-- 
2.20.1


