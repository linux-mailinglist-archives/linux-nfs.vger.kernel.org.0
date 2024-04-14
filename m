Return-Path: <linux-nfs+bounces-2717-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB3D89C583
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 15:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E4F1C215BD
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B424B7CF1A;
	Mon,  8 Apr 2024 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fFlYfPIq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748C97BB15;
	Mon,  8 Apr 2024 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584646; cv=none; b=idJRMEnbuSVLECE9/XiCIeP6KnS9eUEOTGpFBXqKk4ZSGJEq6BoYLlEuL/3PE7Oq/k5sQscediIVJHU6e8LqEozDtavfafwHHmwgaBtsOCci93a+u79LkouNSj9EabfiZ450E9GIqPdBj6CPe9/1J3iqko0SbEJaDG9GTt9chTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584646; c=relaxed/simple;
	bh=Eqs17WYxR71VQxnFL7qzcqHkTrpwy27p8ypWHzYzIMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvHQCaiKctr8ZTSuoMTHkOV8+o3NbVm/isdobcqkePlnnk2Kdoo8hkunujf9EqBFrlaCzLeNJr5OSMUrdWz9UGlCxAkqv7Pv4lyPHUGhNqd/Svh5M8YIe6WTS+Ns1jkR6q/y95710Fd+2kL68g2VlN63PBZ084QnMPHUfqM+B24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fFlYfPIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD2EC433C7;
	Mon,  8 Apr 2024 13:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584644;
	bh=Eqs17WYxR71VQxnFL7qzcqHkTrpwy27p8ypWHzYzIMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fFlYfPIq0j4IhcekeqsKMhT8sHYkfEfm5iujpSSSY4Mp+LHYzIUtcCJZc/4WGXvPz
	 pd4q7SlcqeN5O6uB9km0p7Q8bid/l6bocJ8/vXQ+2PSZUfTNvg9o3in/ItpfLk0GEt
	 hI2bo9H0ZOx44/jo3SbNnZUrfv08P2aQlEns7k/E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-nfs@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.15 508/690] NFSD: Avoid clashing function prototypes
Date: Mon,  8 Apr 2024 14:56:14 +0200
Message-ID: <20240408125418.056537211@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

[ Upstream commit e78e274eb22d966258a3845acc71d3c5b8ee2ea8 ]

When built with Control Flow Integrity, function prototypes between
caller and function declaration must match. These mismatches are visible
at compile time with the new -Wcast-function-type-strict in Clang[1].

There were 97 warnings produced by NFS. For example:

fs/nfsd/nfs4xdr.c:2228:17: warning: cast from '__be32 (*)(struct nfsd4_compoundargs *, struct nfsd4_access *)' (aka 'unsigned int (*)(struct nfsd4_compoundargs *, struct nfsd4_access *)') to 'nfsd4_dec' (aka 'unsigned int (*)(struct nfsd4_compoundargs *, void *)') converts to incompatible function type [-Wcast-function-type-strict]
        [OP_ACCESS]             = (nfsd4_dec)nfsd4_decode_access,
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The enc/dec callbacks were defined as passing "void *" as the second
argument, but were being implicitly cast to a new type. Replace the
argument with union nfsd4_op_u, and perform explicit member selection
in the function body. There are no resulting binary differences.

Changes were made mechanically using the following Coccinelle script,
with minor by-hand fixes for members that didn't already match their
existing argument name:

@find@
identifier func;
type T, opsT;
identifier ops, N;
@@

 opsT ops[] = {
        [N] = (T) func,
 };

@already_void@
identifier find.func;
identifier name;
@@

 func(...,
-void
+union nfsd4_op_u
 *name)
 {
        ...
 }

@proto depends on !already_void@
identifier find.func;
type T;
identifier name;
position p;
@@

 func@p(...,
        T name
 ) {
        ...
   }

@script:python get_member@
type_name << proto.T;
member;
@@

coccinelle.member = cocci.make_ident(type_name.split("_", 1)[1].split(' ',1)[0])

@convert@
identifier find.func;
type proto.T;
identifier proto.name;
position proto.p;
identifier get_member.member;
@@

 func@p(...,
-       T name
+       union nfsd4_op_u *u
 ) {
+       T name = &u->member;
        ...
   }

@cast@
identifier find.func;
type T, opsT;
identifier ops, N;
@@

 opsT ops[] = {
        [N] =
-       (T)
        func,
 };

Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: linux-nfs@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 632 +++++++++++++++++++++++++++-------------------
 1 file changed, 377 insertions(+), 255 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c2457a9ac00aa..30e085f1e4797 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -770,16 +770,18 @@ nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_cb_sec *cbs)
 
 static __be32
 nfsd4_decode_access(struct nfsd4_compoundargs *argp,
-		    struct nfsd4_access *access)
+		    union nfsd4_op_u *u)
 {
+	struct nfsd4_access *access = &u->access;
 	if (xdr_stream_decode_u32(argp->xdr, &access->ac_req_access) < 0)
 		return nfserr_bad_xdr;
 	return nfs_ok;
 }
 
 static __be32
-nfsd4_decode_close(struct nfsd4_compoundargs *argp, struct nfsd4_close *close)
+nfsd4_decode_close(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_close *close = &u->close;
 	if (xdr_stream_decode_u32(argp->xdr, &close->cl_seqid) < 0)
 		return nfserr_bad_xdr;
 	return nfsd4_decode_stateid4(argp, &close->cl_stateid);
@@ -787,8 +789,9 @@ nfsd4_decode_close(struct nfsd4_compoundargs *argp, struct nfsd4_close *close)
 
 
 static __be32
-nfsd4_decode_commit(struct nfsd4_compoundargs *argp, struct nfsd4_commit *commit)
+nfsd4_decode_commit(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_commit *commit = &u->commit;
 	if (xdr_stream_decode_u64(argp->xdr, &commit->co_offset) < 0)
 		return nfserr_bad_xdr;
 	if (xdr_stream_decode_u32(argp->xdr, &commit->co_count) < 0)
@@ -798,8 +801,9 @@ nfsd4_decode_commit(struct nfsd4_compoundargs *argp, struct nfsd4_commit *commit
 }
 
 static __be32
-nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create)
+nfsd4_decode_create(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_create *create = &u->create;
 	__be32 *p, status;
 
 	memset(create, 0, sizeof(*create));
@@ -844,22 +848,25 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create
 }
 
 static inline __be32
-nfsd4_decode_delegreturn(struct nfsd4_compoundargs *argp, struct nfsd4_delegreturn *dr)
+nfsd4_decode_delegreturn(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_delegreturn *dr = &u->delegreturn;
 	return nfsd4_decode_stateid4(argp, &dr->dr_stateid);
 }
 
 static inline __be32
-nfsd4_decode_getattr(struct nfsd4_compoundargs *argp, struct nfsd4_getattr *getattr)
+nfsd4_decode_getattr(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_getattr *getattr = &u->getattr;
 	memset(getattr, 0, sizeof(*getattr));
 	return nfsd4_decode_bitmap4(argp, getattr->ga_bmval,
 				    ARRAY_SIZE(getattr->ga_bmval));
 }
 
 static __be32
-nfsd4_decode_link(struct nfsd4_compoundargs *argp, struct nfsd4_link *link)
+nfsd4_decode_link(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_link *link = &u->link;
 	memset(link, 0, sizeof(*link));
 	return nfsd4_decode_component4(argp, &link->li_name, &link->li_namelen);
 }
@@ -907,8 +914,9 @@ nfsd4_decode_locker4(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 }
 
 static __be32
-nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
+nfsd4_decode_lock(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_lock *lock = &u->lock;
 	memset(lock, 0, sizeof(*lock));
 	if (xdr_stream_decode_u32(argp->xdr, &lock->lk_type) < 0)
 		return nfserr_bad_xdr;
@@ -924,8 +932,9 @@ nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 }
 
 static __be32
-nfsd4_decode_lockt(struct nfsd4_compoundargs *argp, struct nfsd4_lockt *lockt)
+nfsd4_decode_lockt(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_lockt *lockt = &u->lockt;
 	memset(lockt, 0, sizeof(*lockt));
 	if (xdr_stream_decode_u32(argp->xdr, &lockt->lt_type) < 0)
 		return nfserr_bad_xdr;
@@ -940,8 +949,9 @@ nfsd4_decode_lockt(struct nfsd4_compoundargs *argp, struct nfsd4_lockt *lockt)
 }
 
 static __be32
-nfsd4_decode_locku(struct nfsd4_compoundargs *argp, struct nfsd4_locku *locku)
+nfsd4_decode_locku(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_locku *locku = &u->locku;
 	__be32 status;
 
 	if (xdr_stream_decode_u32(argp->xdr, &locku->lu_type) < 0)
@@ -962,8 +972,9 @@ nfsd4_decode_locku(struct nfsd4_compoundargs *argp, struct nfsd4_locku *locku)
 }
 
 static __be32
-nfsd4_decode_lookup(struct nfsd4_compoundargs *argp, struct nfsd4_lookup *lookup)
+nfsd4_decode_lookup(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_lookup *lookup = &u->lookup;
 	return nfsd4_decode_component4(argp, &lookup->lo_name, &lookup->lo_len);
 }
 
@@ -1143,8 +1154,9 @@ nfsd4_decode_open_claim4(struct nfsd4_compoundargs *argp,
 }
 
 static __be32
-nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
+nfsd4_decode_open(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_open *open = &u->open;
 	__be32 status;
 	u32 dummy;
 
@@ -1171,8 +1183,10 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 }
 
 static __be32
-nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_open_confirm *open_conf)
+nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp,
+			  union nfsd4_op_u *u)
 {
+	struct nfsd4_open_confirm *open_conf = &u->open_confirm;
 	__be32 status;
 
 	if (argp->minorversion >= 1)
@@ -1190,8 +1204,10 @@ nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_open_con
 }
 
 static __be32
-nfsd4_decode_open_downgrade(struct nfsd4_compoundargs *argp, struct nfsd4_open_downgrade *open_down)
+nfsd4_decode_open_downgrade(struct nfsd4_compoundargs *argp,
+			    union nfsd4_op_u *u)
 {
+	struct nfsd4_open_downgrade *open_down = &u->open_downgrade;
 	__be32 status;
 
 	memset(open_down, 0, sizeof(*open_down));
@@ -1209,8 +1225,9 @@ nfsd4_decode_open_downgrade(struct nfsd4_compoundargs *argp, struct nfsd4_open_d
 }
 
 static __be32
-nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, struct nfsd4_putfh *putfh)
+nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_putfh *putfh = &u->putfh;
 	__be32 *p;
 
 	if (xdr_stream_decode_u32(argp->xdr, &putfh->pf_fhlen) < 0)
@@ -1229,7 +1246,7 @@ nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, struct nfsd4_putfh *putfh)
 }
 
 static __be32
-nfsd4_decode_putpubfh(struct nfsd4_compoundargs *argp, void *p)
+nfsd4_decode_putpubfh(struct nfsd4_compoundargs *argp, union nfsd4_op_u *p)
 {
 	if (argp->minorversion == 0)
 		return nfs_ok;
@@ -1237,8 +1254,9 @@ nfsd4_decode_putpubfh(struct nfsd4_compoundargs *argp, void *p)
 }
 
 static __be32
-nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *read)
+nfsd4_decode_read(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_read *read = &u->read;
 	__be32 status;
 
 	memset(read, 0, sizeof(*read));
@@ -1254,8 +1272,9 @@ nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *read)
 }
 
 static __be32
-nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, struct nfsd4_readdir *readdir)
+nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_readdir *readdir = &u->readdir;
 	__be32 status;
 
 	memset(readdir, 0, sizeof(*readdir));
@@ -1276,15 +1295,17 @@ nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, struct nfsd4_readdir *read
 }
 
 static __be32
-nfsd4_decode_remove(struct nfsd4_compoundargs *argp, struct nfsd4_remove *remove)
+nfsd4_decode_remove(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_remove *remove = &u->remove;
 	memset(&remove->rm_cinfo, 0, sizeof(remove->rm_cinfo));
 	return nfsd4_decode_component4(argp, &remove->rm_name, &remove->rm_namelen);
 }
 
 static __be32
-nfsd4_decode_rename(struct nfsd4_compoundargs *argp, struct nfsd4_rename *rename)
+nfsd4_decode_rename(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_rename *rename = &u->rename;
 	__be32 status;
 
 	memset(rename, 0, sizeof(*rename));
@@ -1295,22 +1316,25 @@ nfsd4_decode_rename(struct nfsd4_compoundargs *argp, struct nfsd4_rename *rename
 }
 
 static __be32
-nfsd4_decode_renew(struct nfsd4_compoundargs *argp, clientid_t *clientid)
+nfsd4_decode_renew(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	clientid_t *clientid = &u->renew;
 	return nfsd4_decode_clientid4(argp, clientid);
 }
 
 static __be32
 nfsd4_decode_secinfo(struct nfsd4_compoundargs *argp,
-		     struct nfsd4_secinfo *secinfo)
+		     union nfsd4_op_u *u)
 {
+	struct nfsd4_secinfo *secinfo = &u->secinfo;
 	secinfo->si_exp = NULL;
 	return nfsd4_decode_component4(argp, &secinfo->si_name, &secinfo->si_namelen);
 }
 
 static __be32
-nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *setattr)
+nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_setattr *setattr = &u->setattr;
 	__be32 status;
 
 	memset(setattr, 0, sizeof(*setattr));
@@ -1324,8 +1348,9 @@ nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *seta
 }
 
 static __be32
-nfsd4_decode_setclientid(struct nfsd4_compoundargs *argp, struct nfsd4_setclientid *setclientid)
+nfsd4_decode_setclientid(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_setclientid *setclientid = &u->setclientid;
 	__be32 *p, status;
 
 	memset(setclientid, 0, sizeof(*setclientid));
@@ -1367,8 +1392,10 @@ nfsd4_decode_setclientid(struct nfsd4_compoundargs *argp, struct nfsd4_setclient
 }
 
 static __be32
-nfsd4_decode_setclientid_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_setclientid_confirm *scd_c)
+nfsd4_decode_setclientid_confirm(struct nfsd4_compoundargs *argp,
+				 union nfsd4_op_u *u)
 {
+	struct nfsd4_setclientid_confirm *scd_c = &u->setclientid_confirm;
 	__be32 status;
 
 	if (argp->minorversion >= 1)
@@ -1382,8 +1409,9 @@ nfsd4_decode_setclientid_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_s
 
 /* Also used for NVERIFY */
 static __be32
-nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify)
+nfsd4_decode_verify(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_verify *verify = &u->verify;
 	__be32 *p, status;
 
 	memset(verify, 0, sizeof(*verify));
@@ -1409,8 +1437,9 @@ nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify
 }
 
 static __be32
-nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
+nfsd4_decode_write(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_write *write = &u->write;
 	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &write->wr_stateid);
@@ -1434,8 +1463,10 @@ nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
 }
 
 static __be32
-nfsd4_decode_release_lockowner(struct nfsd4_compoundargs *argp, struct nfsd4_release_lockowner *rlockowner)
+nfsd4_decode_release_lockowner(struct nfsd4_compoundargs *argp,
+			       union nfsd4_op_u *u)
 {
+	struct nfsd4_release_lockowner *rlockowner = &u->release_lockowner;
 	__be32 status;
 
 	if (argp->minorversion >= 1)
@@ -1452,16 +1483,20 @@ nfsd4_decode_release_lockowner(struct nfsd4_compoundargs *argp, struct nfsd4_rel
 	return nfs_ok;
 }
 
-static __be32 nfsd4_decode_backchannel_ctl(struct nfsd4_compoundargs *argp, struct nfsd4_backchannel_ctl *bc)
+static __be32 nfsd4_decode_backchannel_ctl(struct nfsd4_compoundargs *argp,
+					   union nfsd4_op_u *u)
 {
+	struct nfsd4_backchannel_ctl *bc = &u->backchannel_ctl;
 	memset(bc, 0, sizeof(*bc));
 	if (xdr_stream_decode_u32(argp->xdr, &bc->bc_cb_program) < 0)
 		return nfserr_bad_xdr;
 	return nfsd4_decode_cb_sec(argp, &bc->bc_cb_sec);
 }
 
-static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundargs *argp, struct nfsd4_bind_conn_to_session *bcts)
+static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundargs *argp,
+						union nfsd4_op_u *u)
 {
+	struct nfsd4_bind_conn_to_session *bcts = &u->bind_conn_to_session;
 	u32 use_conn_in_rdma_mode;
 	__be32 status;
 
@@ -1603,8 +1638,9 @@ nfsd4_decode_nfs_impl_id4(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
-			 struct nfsd4_exchange_id *exid)
+			 union nfsd4_op_u *u)
 {
+	struct nfsd4_exchange_id *exid = &u->exchange_id;
 	__be32 status;
 
 	memset(exid, 0, sizeof(*exid));
@@ -1656,8 +1692,9 @@ nfsd4_decode_channel_attrs4(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
-			    struct nfsd4_create_session *sess)
+			    union nfsd4_op_u *u)
 {
+	struct nfsd4_create_session *sess = &u->create_session;
 	__be32 status;
 
 	memset(sess, 0, sizeof(*sess));
@@ -1681,23 +1718,26 @@ nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_destroy_session(struct nfsd4_compoundargs *argp,
-			     struct nfsd4_destroy_session *destroy_session)
+			     union nfsd4_op_u *u)
 {
+	struct nfsd4_destroy_session *destroy_session = &u->destroy_session;
 	return nfsd4_decode_sessionid4(argp, &destroy_session->sessionid);
 }
 
 static __be32
 nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
-			  struct nfsd4_free_stateid *free_stateid)
+			  union nfsd4_op_u *u)
 {
+	struct nfsd4_free_stateid *free_stateid = &u->free_stateid;
 	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
 }
 
 #ifdef CONFIG_NFSD_PNFS
 static __be32
 nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
-		struct nfsd4_getdeviceinfo *gdev)
+		union nfsd4_op_u *u)
 {
+	struct nfsd4_getdeviceinfo *gdev = &u->getdeviceinfo;
 	__be32 status;
 
 	memset(gdev, 0, sizeof(*gdev));
@@ -1717,8 +1757,9 @@ nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_layoutcommit(struct nfsd4_compoundargs *argp,
-			  struct nfsd4_layoutcommit *lcp)
+			  union nfsd4_op_u *u)
 {
+	struct nfsd4_layoutcommit *lcp = &u->layoutcommit;
 	__be32 *p, status;
 
 	memset(lcp, 0, sizeof(*lcp));
@@ -1753,8 +1794,9 @@ nfsd4_decode_layoutcommit(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_layoutget(struct nfsd4_compoundargs *argp,
-		struct nfsd4_layoutget *lgp)
+		union nfsd4_op_u *u)
 {
+	struct nfsd4_layoutget *lgp = &u->layoutget;
 	__be32 status;
 
 	memset(lgp, 0, sizeof(*lgp));
@@ -1781,8 +1823,9 @@ nfsd4_decode_layoutget(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_layoutreturn(struct nfsd4_compoundargs *argp,
-		struct nfsd4_layoutreturn *lrp)
+		union nfsd4_op_u *u)
 {
+	struct nfsd4_layoutreturn *lrp = &u->layoutreturn;
 	memset(lrp, 0, sizeof(*lrp));
 	if (xdr_stream_decode_bool(argp->xdr, &lrp->lr_reclaim) < 0)
 		return nfserr_bad_xdr;
@@ -1795,8 +1838,9 @@ nfsd4_decode_layoutreturn(struct nfsd4_compoundargs *argp,
 #endif /* CONFIG_NFSD_PNFS */
 
 static __be32 nfsd4_decode_secinfo_no_name(struct nfsd4_compoundargs *argp,
-					   struct nfsd4_secinfo_no_name *sin)
+					   union nfsd4_op_u *u)
 {
+	struct nfsd4_secinfo_no_name *sin = &u->secinfo_no_name;
 	if (xdr_stream_decode_u32(argp->xdr, &sin->sin_style) < 0)
 		return nfserr_bad_xdr;
 
@@ -1806,8 +1850,9 @@ static __be32 nfsd4_decode_secinfo_no_name(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
-		      struct nfsd4_sequence *seq)
+		      union nfsd4_op_u *u)
 {
+	struct nfsd4_sequence *seq = &u->sequence;
 	__be32 *p, status;
 
 	status = nfsd4_decode_sessionid4(argp, &seq->sessionid);
@@ -1826,8 +1871,10 @@ nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
 }
 
 static __be32
-nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, struct nfsd4_test_stateid *test_stateid)
+nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp,
+			  union nfsd4_op_u *u)
 {
+	struct nfsd4_test_stateid *test_stateid = &u->test_stateid;
 	struct nfsd4_test_stateid_id *stateid;
 	__be32 status;
 	u32 i;
@@ -1852,14 +1899,16 @@ nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, struct nfsd4_test_sta
 }
 
 static __be32 nfsd4_decode_destroy_clientid(struct nfsd4_compoundargs *argp,
-					    struct nfsd4_destroy_clientid *dc)
+					    union nfsd4_op_u *u)
 {
+	struct nfsd4_destroy_clientid *dc = &u->destroy_clientid;
 	return nfsd4_decode_clientid4(argp, &dc->clientid);
 }
 
 static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp,
-					    struct nfsd4_reclaim_complete *rc)
+					    union nfsd4_op_u *u)
 {
+	struct nfsd4_reclaim_complete *rc = &u->reclaim_complete;
 	if (xdr_stream_decode_bool(argp->xdr, &rc->rca_one_fs) < 0)
 		return nfserr_bad_xdr;
 	return nfs_ok;
@@ -1867,8 +1916,9 @@ static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
-		       struct nfsd4_fallocate *fallocate)
+		       union nfsd4_op_u *u)
 {
+	struct nfsd4_fallocate *fallocate = &u->allocate;
 	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &fallocate->falloc_stateid);
@@ -1924,8 +1974,9 @@ static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
 }
 
 static __be32
-nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
+nfsd4_decode_copy(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_copy *copy = &u->copy;
 	u32 consecutive, i, count, sync;
 	struct nl4_server *ns_dummy;
 	__be32 status;
@@ -1982,8 +2033,9 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 
 static __be32
 nfsd4_decode_copy_notify(struct nfsd4_compoundargs *argp,
-			 struct nfsd4_copy_notify *cn)
+			 union nfsd4_op_u *u)
 {
+	struct nfsd4_copy_notify *cn = &u->copy_notify;
 	__be32 status;
 
 	memset(cn, 0, sizeof(*cn));
@@ -2002,16 +2054,18 @@ nfsd4_decode_copy_notify(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_offload_status(struct nfsd4_compoundargs *argp,
-			    struct nfsd4_offload_status *os)
+			    union nfsd4_op_u *u)
 {
+	struct nfsd4_offload_status *os = &u->offload_status;
 	os->count = 0;
 	os->status = 0;
 	return nfsd4_decode_stateid4(argp, &os->stateid);
 }
 
 static __be32
-nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *seek)
+nfsd4_decode_seek(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_seek *seek = &u->seek;
 	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &seek->seek_stateid);
@@ -2028,8 +2082,9 @@ nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *seek)
 }
 
 static __be32
-nfsd4_decode_clone(struct nfsd4_compoundargs *argp, struct nfsd4_clone *clone)
+nfsd4_decode_clone(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
+	struct nfsd4_clone *clone = &u->clone;
 	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &clone->cl_src_stateid);
@@ -2154,8 +2209,9 @@ nfsd4_decode_xattr_name(struct nfsd4_compoundargs *argp, char **namep)
  */
 static __be32
 nfsd4_decode_getxattr(struct nfsd4_compoundargs *argp,
-		      struct nfsd4_getxattr *getxattr)
+		      union nfsd4_op_u *u)
 {
+	struct nfsd4_getxattr *getxattr = &u->getxattr;
 	__be32 status;
 	u32 maxcount;
 
@@ -2173,8 +2229,9 @@ nfsd4_decode_getxattr(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
-		      struct nfsd4_setxattr *setxattr)
+		      union nfsd4_op_u *u)
 {
+	struct nfsd4_setxattr *setxattr = &u->setxattr;
 	u32 flags, maxcount, size;
 	__be32 status;
 
@@ -2214,8 +2271,9 @@ nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_listxattrs(struct nfsd4_compoundargs *argp,
-			struct nfsd4_listxattrs *listxattrs)
+			union nfsd4_op_u *u)
 {
+	struct nfsd4_listxattrs *listxattrs = &u->listxattrs;
 	u32 maxcount;
 
 	memset(listxattrs, 0, sizeof(*listxattrs));
@@ -2245,113 +2303,114 @@ nfsd4_decode_listxattrs(struct nfsd4_compoundargs *argp,
 
 static __be32
 nfsd4_decode_removexattr(struct nfsd4_compoundargs *argp,
-			 struct nfsd4_removexattr *removexattr)
+			 union nfsd4_op_u *u)
 {
+	struct nfsd4_removexattr *removexattr = &u->removexattr;
 	memset(removexattr, 0, sizeof(*removexattr));
 	return nfsd4_decode_xattr_name(argp, &removexattr->rmxa_name);
 }
 
 static __be32
-nfsd4_decode_noop(struct nfsd4_compoundargs *argp, void *p)
+nfsd4_decode_noop(struct nfsd4_compoundargs *argp, union nfsd4_op_u *p)
 {
 	return nfs_ok;
 }
 
 static __be32
-nfsd4_decode_notsupp(struct nfsd4_compoundargs *argp, void *p)
+nfsd4_decode_notsupp(struct nfsd4_compoundargs *argp, union nfsd4_op_u *p)
 {
 	return nfserr_notsupp;
 }
 
-typedef __be32(*nfsd4_dec)(struct nfsd4_compoundargs *argp, void *);
+typedef __be32(*nfsd4_dec)(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u);
 
 static const nfsd4_dec nfsd4_dec_ops[] = {
-	[OP_ACCESS]		= (nfsd4_dec)nfsd4_decode_access,
-	[OP_CLOSE]		= (nfsd4_dec)nfsd4_decode_close,
-	[OP_COMMIT]		= (nfsd4_dec)nfsd4_decode_commit,
-	[OP_CREATE]		= (nfsd4_dec)nfsd4_decode_create,
-	[OP_DELEGPURGE]		= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_DELEGRETURN]	= (nfsd4_dec)nfsd4_decode_delegreturn,
-	[OP_GETATTR]		= (nfsd4_dec)nfsd4_decode_getattr,
-	[OP_GETFH]		= (nfsd4_dec)nfsd4_decode_noop,
-	[OP_LINK]		= (nfsd4_dec)nfsd4_decode_link,
-	[OP_LOCK]		= (nfsd4_dec)nfsd4_decode_lock,
-	[OP_LOCKT]		= (nfsd4_dec)nfsd4_decode_lockt,
-	[OP_LOCKU]		= (nfsd4_dec)nfsd4_decode_locku,
-	[OP_LOOKUP]		= (nfsd4_dec)nfsd4_decode_lookup,
-	[OP_LOOKUPP]		= (nfsd4_dec)nfsd4_decode_noop,
-	[OP_NVERIFY]		= (nfsd4_dec)nfsd4_decode_verify,
-	[OP_OPEN]		= (nfsd4_dec)nfsd4_decode_open,
-	[OP_OPENATTR]		= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_OPEN_CONFIRM]	= (nfsd4_dec)nfsd4_decode_open_confirm,
-	[OP_OPEN_DOWNGRADE]	= (nfsd4_dec)nfsd4_decode_open_downgrade,
-	[OP_PUTFH]		= (nfsd4_dec)nfsd4_decode_putfh,
-	[OP_PUTPUBFH]		= (nfsd4_dec)nfsd4_decode_putpubfh,
-	[OP_PUTROOTFH]		= (nfsd4_dec)nfsd4_decode_noop,
-	[OP_READ]		= (nfsd4_dec)nfsd4_decode_read,
-	[OP_READDIR]		= (nfsd4_dec)nfsd4_decode_readdir,
-	[OP_READLINK]		= (nfsd4_dec)nfsd4_decode_noop,
-	[OP_REMOVE]		= (nfsd4_dec)nfsd4_decode_remove,
-	[OP_RENAME]		= (nfsd4_dec)nfsd4_decode_rename,
-	[OP_RENEW]		= (nfsd4_dec)nfsd4_decode_renew,
-	[OP_RESTOREFH]		= (nfsd4_dec)nfsd4_decode_noop,
-	[OP_SAVEFH]		= (nfsd4_dec)nfsd4_decode_noop,
-	[OP_SECINFO]		= (nfsd4_dec)nfsd4_decode_secinfo,
-	[OP_SETATTR]		= (nfsd4_dec)nfsd4_decode_setattr,
-	[OP_SETCLIENTID]	= (nfsd4_dec)nfsd4_decode_setclientid,
-	[OP_SETCLIENTID_CONFIRM] = (nfsd4_dec)nfsd4_decode_setclientid_confirm,
-	[OP_VERIFY]		= (nfsd4_dec)nfsd4_decode_verify,
-	[OP_WRITE]		= (nfsd4_dec)nfsd4_decode_write,
-	[OP_RELEASE_LOCKOWNER]	= (nfsd4_dec)nfsd4_decode_release_lockowner,
+	[OP_ACCESS]		= nfsd4_decode_access,
+	[OP_CLOSE]		= nfsd4_decode_close,
+	[OP_COMMIT]		= nfsd4_decode_commit,
+	[OP_CREATE]		= nfsd4_decode_create,
+	[OP_DELEGPURGE]		= nfsd4_decode_notsupp,
+	[OP_DELEGRETURN]	= nfsd4_decode_delegreturn,
+	[OP_GETATTR]		= nfsd4_decode_getattr,
+	[OP_GETFH]		= nfsd4_decode_noop,
+	[OP_LINK]		= nfsd4_decode_link,
+	[OP_LOCK]		= nfsd4_decode_lock,
+	[OP_LOCKT]		= nfsd4_decode_lockt,
+	[OP_LOCKU]		= nfsd4_decode_locku,
+	[OP_LOOKUP]		= nfsd4_decode_lookup,
+	[OP_LOOKUPP]		= nfsd4_decode_noop,
+	[OP_NVERIFY]		= nfsd4_decode_verify,
+	[OP_OPEN]		= nfsd4_decode_open,
+	[OP_OPENATTR]		= nfsd4_decode_notsupp,
+	[OP_OPEN_CONFIRM]	= nfsd4_decode_open_confirm,
+	[OP_OPEN_DOWNGRADE]	= nfsd4_decode_open_downgrade,
+	[OP_PUTFH]		= nfsd4_decode_putfh,
+	[OP_PUTPUBFH]		= nfsd4_decode_putpubfh,
+	[OP_PUTROOTFH]		= nfsd4_decode_noop,
+	[OP_READ]		= nfsd4_decode_read,
+	[OP_READDIR]		= nfsd4_decode_readdir,
+	[OP_READLINK]		= nfsd4_decode_noop,
+	[OP_REMOVE]		= nfsd4_decode_remove,
+	[OP_RENAME]		= nfsd4_decode_rename,
+	[OP_RENEW]		= nfsd4_decode_renew,
+	[OP_RESTOREFH]		= nfsd4_decode_noop,
+	[OP_SAVEFH]		= nfsd4_decode_noop,
+	[OP_SECINFO]		= nfsd4_decode_secinfo,
+	[OP_SETATTR]		= nfsd4_decode_setattr,
+	[OP_SETCLIENTID]	= nfsd4_decode_setclientid,
+	[OP_SETCLIENTID_CONFIRM] = nfsd4_decode_setclientid_confirm,
+	[OP_VERIFY]		= nfsd4_decode_verify,
+	[OP_WRITE]		= nfsd4_decode_write,
+	[OP_RELEASE_LOCKOWNER]	= nfsd4_decode_release_lockowner,
 
 	/* new operations for NFSv4.1 */
-	[OP_BACKCHANNEL_CTL]	= (nfsd4_dec)nfsd4_decode_backchannel_ctl,
-	[OP_BIND_CONN_TO_SESSION]= (nfsd4_dec)nfsd4_decode_bind_conn_to_session,
-	[OP_EXCHANGE_ID]	= (nfsd4_dec)nfsd4_decode_exchange_id,
-	[OP_CREATE_SESSION]	= (nfsd4_dec)nfsd4_decode_create_session,
-	[OP_DESTROY_SESSION]	= (nfsd4_dec)nfsd4_decode_destroy_session,
-	[OP_FREE_STATEID]	= (nfsd4_dec)nfsd4_decode_free_stateid,
-	[OP_GET_DIR_DELEGATION]	= (nfsd4_dec)nfsd4_decode_notsupp,
+	[OP_BACKCHANNEL_CTL]	= nfsd4_decode_backchannel_ctl,
+	[OP_BIND_CONN_TO_SESSION] = nfsd4_decode_bind_conn_to_session,
+	[OP_EXCHANGE_ID]	= nfsd4_decode_exchange_id,
+	[OP_CREATE_SESSION]	= nfsd4_decode_create_session,
+	[OP_DESTROY_SESSION]	= nfsd4_decode_destroy_session,
+	[OP_FREE_STATEID]	= nfsd4_decode_free_stateid,
+	[OP_GET_DIR_DELEGATION]	= nfsd4_decode_notsupp,
 #ifdef CONFIG_NFSD_PNFS
-	[OP_GETDEVICEINFO]	= (nfsd4_dec)nfsd4_decode_getdeviceinfo,
-	[OP_GETDEVICELIST]	= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_LAYOUTCOMMIT]	= (nfsd4_dec)nfsd4_decode_layoutcommit,
-	[OP_LAYOUTGET]		= (nfsd4_dec)nfsd4_decode_layoutget,
-	[OP_LAYOUTRETURN]	= (nfsd4_dec)nfsd4_decode_layoutreturn,
+	[OP_GETDEVICEINFO]	= nfsd4_decode_getdeviceinfo,
+	[OP_GETDEVICELIST]	= nfsd4_decode_notsupp,
+	[OP_LAYOUTCOMMIT]	= nfsd4_decode_layoutcommit,
+	[OP_LAYOUTGET]		= nfsd4_decode_layoutget,
+	[OP_LAYOUTRETURN]	= nfsd4_decode_layoutreturn,
 #else
-	[OP_GETDEVICEINFO]	= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_GETDEVICELIST]	= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_LAYOUTCOMMIT]	= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_LAYOUTGET]		= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_LAYOUTRETURN]	= (nfsd4_dec)nfsd4_decode_notsupp,
+	[OP_GETDEVICEINFO]	= nfsd4_decode_notsupp,
+	[OP_GETDEVICELIST]	= nfsd4_decode_notsupp,
+	[OP_LAYOUTCOMMIT]	= nfsd4_decode_notsupp,
+	[OP_LAYOUTGET]		= nfsd4_decode_notsupp,
+	[OP_LAYOUTRETURN]	= nfsd4_decode_notsupp,
 #endif
-	[OP_SECINFO_NO_NAME]	= (nfsd4_dec)nfsd4_decode_secinfo_no_name,
-	[OP_SEQUENCE]		= (nfsd4_dec)nfsd4_decode_sequence,
-	[OP_SET_SSV]		= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_TEST_STATEID]	= (nfsd4_dec)nfsd4_decode_test_stateid,
-	[OP_WANT_DELEGATION]	= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_DESTROY_CLIENTID]	= (nfsd4_dec)nfsd4_decode_destroy_clientid,
-	[OP_RECLAIM_COMPLETE]	= (nfsd4_dec)nfsd4_decode_reclaim_complete,
+	[OP_SECINFO_NO_NAME]	= nfsd4_decode_secinfo_no_name,
+	[OP_SEQUENCE]		= nfsd4_decode_sequence,
+	[OP_SET_SSV]		= nfsd4_decode_notsupp,
+	[OP_TEST_STATEID]	= nfsd4_decode_test_stateid,
+	[OP_WANT_DELEGATION]	= nfsd4_decode_notsupp,
+	[OP_DESTROY_CLIENTID]	= nfsd4_decode_destroy_clientid,
+	[OP_RECLAIM_COMPLETE]	= nfsd4_decode_reclaim_complete,
 
 	/* new operations for NFSv4.2 */
-	[OP_ALLOCATE]		= (nfsd4_dec)nfsd4_decode_fallocate,
-	[OP_COPY]		= (nfsd4_dec)nfsd4_decode_copy,
-	[OP_COPY_NOTIFY]	= (nfsd4_dec)nfsd4_decode_copy_notify,
-	[OP_DEALLOCATE]		= (nfsd4_dec)nfsd4_decode_fallocate,
-	[OP_IO_ADVISE]		= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_LAYOUTERROR]	= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_LAYOUTSTATS]	= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_OFFLOAD_CANCEL]	= (nfsd4_dec)nfsd4_decode_offload_status,
-	[OP_OFFLOAD_STATUS]	= (nfsd4_dec)nfsd4_decode_offload_status,
-	[OP_READ_PLUS]		= (nfsd4_dec)nfsd4_decode_read,
-	[OP_SEEK]		= (nfsd4_dec)nfsd4_decode_seek,
-	[OP_WRITE_SAME]		= (nfsd4_dec)nfsd4_decode_notsupp,
-	[OP_CLONE]		= (nfsd4_dec)nfsd4_decode_clone,
+	[OP_ALLOCATE]		= nfsd4_decode_fallocate,
+	[OP_COPY]		= nfsd4_decode_copy,
+	[OP_COPY_NOTIFY]	= nfsd4_decode_copy_notify,
+	[OP_DEALLOCATE]		= nfsd4_decode_fallocate,
+	[OP_IO_ADVISE]		= nfsd4_decode_notsupp,
+	[OP_LAYOUTERROR]	= nfsd4_decode_notsupp,
+	[OP_LAYOUTSTATS]	= nfsd4_decode_notsupp,
+	[OP_OFFLOAD_CANCEL]	= nfsd4_decode_offload_status,
+	[OP_OFFLOAD_STATUS]	= nfsd4_decode_offload_status,
+	[OP_READ_PLUS]		= nfsd4_decode_read,
+	[OP_SEEK]		= nfsd4_decode_seek,
+	[OP_WRITE_SAME]		= nfsd4_decode_notsupp,
+	[OP_CLONE]		= nfsd4_decode_clone,
 	/* RFC 8276 extended atributes operations */
-	[OP_GETXATTR]		= (nfsd4_dec)nfsd4_decode_getxattr,
-	[OP_SETXATTR]		= (nfsd4_dec)nfsd4_decode_setxattr,
-	[OP_LISTXATTRS]		= (nfsd4_dec)nfsd4_decode_listxattrs,
-	[OP_REMOVEXATTR]	= (nfsd4_dec)nfsd4_decode_removexattr,
+	[OP_GETXATTR]		= nfsd4_decode_getxattr,
+	[OP_SETXATTR]		= nfsd4_decode_setxattr,
+	[OP_LISTXATTRS]		= nfsd4_decode_listxattrs,
+	[OP_REMOVEXATTR]	= nfsd4_decode_removexattr,
 };
 
 static inline bool
@@ -3644,8 +3703,10 @@ nfsd4_encode_stateid(struct xdr_stream *xdr, stateid_t *sid)
 }
 
 static __be32
-nfsd4_encode_access(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_access *access)
+nfsd4_encode_access(struct nfsd4_compoundres *resp, __be32 nfserr,
+		    union nfsd4_op_u *u)
 {
+	struct nfsd4_access *access = &u->access;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -3657,8 +3718,10 @@ nfsd4_encode_access(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_
 	return 0;
 }
 
-static __be32 nfsd4_encode_bind_conn_to_session(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_bind_conn_to_session *bcts)
+static __be32 nfsd4_encode_bind_conn_to_session(struct nfsd4_compoundres *resp, __be32 nfserr,
+						union nfsd4_op_u *u)
 {
+	struct nfsd4_bind_conn_to_session *bcts = &u->bind_conn_to_session;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -3674,8 +3737,10 @@ static __be32 nfsd4_encode_bind_conn_to_session(struct nfsd4_compoundres *resp,
 }
 
 static __be32
-nfsd4_encode_close(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_close *close)
+nfsd4_encode_close(struct nfsd4_compoundres *resp, __be32 nfserr,
+		   union nfsd4_op_u *u)
 {
+	struct nfsd4_close *close = &u->close;
 	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_encode_stateid(xdr, &close->cl_stateid);
@@ -3683,8 +3748,10 @@ nfsd4_encode_close(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_c
 
 
 static __be32
-nfsd4_encode_commit(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_commit *commit)
+nfsd4_encode_commit(struct nfsd4_compoundres *resp, __be32 nfserr,
+		    union nfsd4_op_u *u)
 {
+	struct nfsd4_commit *commit = &u->commit;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -3697,8 +3764,10 @@ nfsd4_encode_commit(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_
 }
 
 static __be32
-nfsd4_encode_create(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_create *create)
+nfsd4_encode_create(struct nfsd4_compoundres *resp, __be32 nfserr,
+		    union nfsd4_op_u *u)
 {
+	struct nfsd4_create *create = &u->create;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -3711,8 +3780,10 @@ nfsd4_encode_create(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_
 }
 
 static __be32
-nfsd4_encode_getattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_getattr *getattr)
+nfsd4_encode_getattr(struct nfsd4_compoundres *resp, __be32 nfserr,
+		     union nfsd4_op_u *u)
 {
+	struct nfsd4_getattr *getattr = &u->getattr;
 	struct svc_fh *fhp = getattr->ga_fhp;
 	struct xdr_stream *xdr = resp->xdr;
 
@@ -3721,8 +3792,10 @@ nfsd4_encode_getattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4
 }
 
 static __be32
-nfsd4_encode_getfh(struct nfsd4_compoundres *resp, __be32 nfserr, struct svc_fh **fhpp)
+nfsd4_encode_getfh(struct nfsd4_compoundres *resp, __be32 nfserr,
+		   union nfsd4_op_u *u)
 {
+	struct svc_fh **fhpp = &u->getfh;
 	struct xdr_stream *xdr = resp->xdr;
 	struct svc_fh *fhp = *fhpp;
 	unsigned int len;
@@ -3776,8 +3849,10 @@ nfsd4_encode_lock_denied(struct xdr_stream *xdr, struct nfsd4_lock_denied *ld)
 }
 
 static __be32
-nfsd4_encode_lock(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_lock *lock)
+nfsd4_encode_lock(struct nfsd4_compoundres *resp, __be32 nfserr,
+		  union nfsd4_op_u *u)
 {
+	struct nfsd4_lock *lock = &u->lock;
 	struct xdr_stream *xdr = resp->xdr;
 
 	if (!nfserr)
@@ -3789,8 +3864,10 @@ nfsd4_encode_lock(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_lo
 }
 
 static __be32
-nfsd4_encode_lockt(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_lockt *lockt)
+nfsd4_encode_lockt(struct nfsd4_compoundres *resp, __be32 nfserr,
+		   union nfsd4_op_u *u)
 {
+	struct nfsd4_lockt *lockt = &u->lockt;
 	struct xdr_stream *xdr = resp->xdr;
 
 	if (nfserr == nfserr_denied)
@@ -3799,8 +3876,10 @@ nfsd4_encode_lockt(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_l
 }
 
 static __be32
-nfsd4_encode_locku(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_locku *locku)
+nfsd4_encode_locku(struct nfsd4_compoundres *resp, __be32 nfserr,
+		   union nfsd4_op_u *u)
 {
+	struct nfsd4_locku *locku = &u->locku;
 	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_encode_stateid(xdr, &locku->lu_stateid);
@@ -3808,8 +3887,10 @@ nfsd4_encode_locku(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_l
 
 
 static __be32
-nfsd4_encode_link(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_link *link)
+nfsd4_encode_link(struct nfsd4_compoundres *resp, __be32 nfserr,
+		  union nfsd4_op_u *u)
 {
+	struct nfsd4_link *link = &u->link;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -3822,8 +3903,10 @@ nfsd4_encode_link(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_li
 
 
 static __be32
-nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_open *open)
+nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
+		  union nfsd4_op_u *u)
 {
+	struct nfsd4_open *open = &u->open;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -3916,16 +3999,20 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_op
 }
 
 static __be32
-nfsd4_encode_open_confirm(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_open_confirm *oc)
+nfsd4_encode_open_confirm(struct nfsd4_compoundres *resp, __be32 nfserr,
+			  union nfsd4_op_u *u)
 {
+	struct nfsd4_open_confirm *oc = &u->open_confirm;
 	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_encode_stateid(xdr, &oc->oc_resp_stateid);
 }
 
 static __be32
-nfsd4_encode_open_downgrade(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_open_downgrade *od)
+nfsd4_encode_open_downgrade(struct nfsd4_compoundres *resp, __be32 nfserr,
+			    union nfsd4_op_u *u)
 {
+	struct nfsd4_open_downgrade *od = &u->open_downgrade;
 	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_encode_stateid(xdr, &od->od_stateid);
@@ -4024,8 +4111,9 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 
 static __be32
 nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
-		  struct nfsd4_read *read)
+		  union nfsd4_op_u *u)
 {
+	struct nfsd4_read *read = &u->read;
 	bool splice_ok = test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags);
 	unsigned long maxcount;
 	struct xdr_stream *xdr = resp->xdr;
@@ -4066,8 +4154,10 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 }
 
 static __be32
-nfsd4_encode_readlink(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_readlink *readlink)
+nfsd4_encode_readlink(struct nfsd4_compoundres *resp, __be32 nfserr,
+		      union nfsd4_op_u *u)
 {
+	struct nfsd4_readlink *readlink = &u->readlink;
 	__be32 *p, *maxcount_p, zero = xdr_zero;
 	struct xdr_stream *xdr = resp->xdr;
 	int length_offset = xdr->buf->len;
@@ -4111,8 +4201,10 @@ nfsd4_encode_readlink(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd
 }
 
 static __be32
-nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_readdir *readdir)
+nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr,
+		     union nfsd4_op_u *u)
 {
+	struct nfsd4_readdir *readdir = &u->readdir;
 	int maxcount;
 	int bytes_left;
 	loff_t offset;
@@ -4202,8 +4294,10 @@ nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4
 }
 
 static __be32
-nfsd4_encode_remove(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_remove *remove)
+nfsd4_encode_remove(struct nfsd4_compoundres *resp, __be32 nfserr,
+		    union nfsd4_op_u *u)
 {
+	struct nfsd4_remove *remove = &u->remove;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4215,8 +4309,10 @@ nfsd4_encode_remove(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_
 }
 
 static __be32
-nfsd4_encode_rename(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_rename *rename)
+nfsd4_encode_rename(struct nfsd4_compoundres *resp, __be32 nfserr,
+		    union nfsd4_op_u *u)
 {
+	struct nfsd4_rename *rename = &u->rename;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4298,8 +4394,9 @@ nfsd4_do_encode_secinfo(struct xdr_stream *xdr, struct svc_export *exp)
 
 static __be32
 nfsd4_encode_secinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
-		     struct nfsd4_secinfo *secinfo)
+		     union nfsd4_op_u *u)
 {
+	struct nfsd4_secinfo *secinfo = &u->secinfo;
 	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_do_encode_secinfo(xdr, secinfo->si_exp);
@@ -4307,8 +4404,9 @@ nfsd4_encode_secinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_secinfo_no_name(struct nfsd4_compoundres *resp, __be32 nfserr,
-		     struct nfsd4_secinfo_no_name *secinfo)
+		     union nfsd4_op_u *u)
 {
+	struct nfsd4_secinfo_no_name *secinfo = &u->secinfo_no_name;
 	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_do_encode_secinfo(xdr, secinfo->sin_exp);
@@ -4319,8 +4417,10 @@ nfsd4_encode_secinfo_no_name(struct nfsd4_compoundres *resp, __be32 nfserr,
  * regardless of the error status.
  */
 static __be32
-nfsd4_encode_setattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_setattr *setattr)
+nfsd4_encode_setattr(struct nfsd4_compoundres *resp, __be32 nfserr,
+		     union nfsd4_op_u *u)
 {
+	struct nfsd4_setattr *setattr = &u->setattr;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4343,8 +4443,10 @@ nfsd4_encode_setattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4
 }
 
 static __be32
-nfsd4_encode_setclientid(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_setclientid *scd)
+nfsd4_encode_setclientid(struct nfsd4_compoundres *resp, __be32 nfserr,
+			 union nfsd4_op_u *u)
 {
+	struct nfsd4_setclientid *scd = &u->setclientid;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4367,8 +4469,10 @@ nfsd4_encode_setclientid(struct nfsd4_compoundres *resp, __be32 nfserr, struct n
 }
 
 static __be32
-nfsd4_encode_write(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_write *write)
+nfsd4_encode_write(struct nfsd4_compoundres *resp, __be32 nfserr,
+		   union nfsd4_op_u *u)
 {
+	struct nfsd4_write *write = &u->write;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4384,8 +4488,9 @@ nfsd4_encode_write(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_w
 
 static __be32
 nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
-			 struct nfsd4_exchange_id *exid)
+			 union nfsd4_op_u *u)
 {
+	struct nfsd4_exchange_id *exid = &u->exchange_id;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 	char *major_id;
@@ -4462,8 +4567,9 @@ nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_create_session(struct nfsd4_compoundres *resp, __be32 nfserr,
-			    struct nfsd4_create_session *sess)
+			    union nfsd4_op_u *u)
 {
+	struct nfsd4_create_session *sess = &u->create_session;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4515,8 +4621,9 @@ nfsd4_encode_create_session(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
-		      struct nfsd4_sequence *seq)
+		      union nfsd4_op_u *u)
 {
+	struct nfsd4_sequence *seq = &u->sequence;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4538,8 +4645,9 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_test_stateid(struct nfsd4_compoundres *resp, __be32 nfserr,
-			  struct nfsd4_test_stateid *test_stateid)
+			  union nfsd4_op_u *u)
 {
+	struct nfsd4_test_stateid *test_stateid = &u->test_stateid;
 	struct xdr_stream *xdr = resp->xdr;
 	struct nfsd4_test_stateid_id *stateid, *next;
 	__be32 *p;
@@ -4559,8 +4667,9 @@ nfsd4_encode_test_stateid(struct nfsd4_compoundres *resp, __be32 nfserr,
 #ifdef CONFIG_NFSD_PNFS
 static __be32
 nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
-		struct nfsd4_getdeviceinfo *gdev)
+		union nfsd4_op_u *u)
 {
+	struct nfsd4_getdeviceinfo *gdev = &u->getdeviceinfo;
 	struct xdr_stream *xdr = resp->xdr;
 	const struct nfsd4_layout_ops *ops;
 	u32 starting_len = xdr->buf->len, needed_len;
@@ -4612,8 +4721,9 @@ nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_layoutget(struct nfsd4_compoundres *resp, __be32 nfserr,
-		struct nfsd4_layoutget *lgp)
+		union nfsd4_op_u *u)
 {
+	struct nfsd4_layoutget *lgp = &u->layoutget;
 	struct xdr_stream *xdr = resp->xdr;
 	const struct nfsd4_layout_ops *ops;
 	__be32 *p;
@@ -4639,8 +4749,9 @@ nfsd4_encode_layoutget(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_layoutcommit(struct nfsd4_compoundres *resp, __be32 nfserr,
-			  struct nfsd4_layoutcommit *lcp)
+			  union nfsd4_op_u *u)
 {
+	struct nfsd4_layoutcommit *lcp = &u->layoutcommit;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4660,8 +4771,9 @@ nfsd4_encode_layoutcommit(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_layoutreturn(struct nfsd4_compoundres *resp, __be32 nfserr,
-		struct nfsd4_layoutreturn *lrp)
+		union nfsd4_op_u *u)
 {
+	struct nfsd4_layoutreturn *lrp = &u->layoutreturn;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4746,8 +4858,9 @@ nfsd42_encode_nl4_server(struct nfsd4_compoundres *resp, struct nl4_server *ns)
 
 static __be32
 nfsd4_encode_copy(struct nfsd4_compoundres *resp, __be32 nfserr,
-		  struct nfsd4_copy *copy)
+		  union nfsd4_op_u *u)
 {
+	struct nfsd4_copy *copy = &u->copy;
 	__be32 *p;
 
 	nfserr = nfsd42_encode_write_res(resp, &copy->cp_res,
@@ -4763,8 +4876,9 @@ nfsd4_encode_copy(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
-			    struct nfsd4_offload_status *os)
+			    union nfsd4_op_u *u)
 {
+	struct nfsd4_offload_status *os = &u->offload_status;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4814,8 +4928,9 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 
 static __be32
 nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
-		       struct nfsd4_read *read)
+		       union nfsd4_op_u *u)
 {
+	struct nfsd4_read *read = &u->read;
 	struct file *file = read->rd_nf->nf_file;
 	struct xdr_stream *xdr = resp->xdr;
 	int starting_len = xdr->buf->len;
@@ -4851,8 +4966,9 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_copy_notify(struct nfsd4_compoundres *resp, __be32 nfserr,
-			 struct nfsd4_copy_notify *cn)
+			 union nfsd4_op_u *u)
 {
+	struct nfsd4_copy_notify *cn = &u->copy_notify;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -4886,8 +5002,9 @@ nfsd4_encode_copy_notify(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_seek(struct nfsd4_compoundres *resp, __be32 nfserr,
-		  struct nfsd4_seek *seek)
+		  union nfsd4_op_u *u)
 {
+	struct nfsd4_seek *seek = &u->seek;
 	__be32 *p;
 
 	p = xdr_reserve_space(resp->xdr, 4 + 8);
@@ -4898,7 +5015,8 @@ nfsd4_encode_seek(struct nfsd4_compoundres *resp, __be32 nfserr,
 }
 
 static __be32
-nfsd4_encode_noop(struct nfsd4_compoundres *resp, __be32 nfserr, void *p)
+nfsd4_encode_noop(struct nfsd4_compoundres *resp, __be32 nfserr,
+		  union nfsd4_op_u *p)
 {
 	return nfserr;
 }
@@ -4949,8 +5067,9 @@ nfsd4_vbuf_to_stream(struct xdr_stream *xdr, char *buf, u32 buflen)
 
 static __be32
 nfsd4_encode_getxattr(struct nfsd4_compoundres *resp, __be32 nfserr,
-		      struct nfsd4_getxattr *getxattr)
+		      union nfsd4_op_u *u)
 {
+	struct nfsd4_getxattr *getxattr = &u->getxattr;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p, err;
 
@@ -4973,8 +5092,9 @@ nfsd4_encode_getxattr(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_setxattr(struct nfsd4_compoundres *resp, __be32 nfserr,
-		      struct nfsd4_setxattr *setxattr)
+		      union nfsd4_op_u *u)
 {
+	struct nfsd4_setxattr *setxattr = &u->setxattr;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -5014,8 +5134,9 @@ nfsd4_listxattr_validate_cookie(struct nfsd4_listxattrs *listxattrs,
 
 static __be32
 nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
-			struct nfsd4_listxattrs *listxattrs)
+			union nfsd4_op_u *u)
 {
+	struct nfsd4_listxattrs *listxattrs = &u->listxattrs;
 	struct xdr_stream *xdr = resp->xdr;
 	u32 cookie_offset, count_offset, eof;
 	u32 left, xdrleft, slen, count;
@@ -5125,8 +5246,9 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_removexattr(struct nfsd4_compoundres *resp, __be32 nfserr,
-			 struct nfsd4_removexattr *removexattr)
+			 union nfsd4_op_u *u)
 {
+	struct nfsd4_removexattr *removexattr = &u->removexattr;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
@@ -5138,7 +5260,7 @@ nfsd4_encode_removexattr(struct nfsd4_compoundres *resp, __be32 nfserr,
 	return 0;
 }
 
-typedef __be32(* nfsd4_enc)(struct nfsd4_compoundres *, __be32, void *);
+typedef __be32(*nfsd4_enc)(struct nfsd4_compoundres *, __be32, union nfsd4_op_u *u);
 
 /*
  * Note: nfsd4_enc_ops vector is shared for v4.0 and v4.1
@@ -5146,93 +5268,93 @@ typedef __be32(* nfsd4_enc)(struct nfsd4_compoundres *, __be32, void *);
  * done in the decoding phase.
  */
 static const nfsd4_enc nfsd4_enc_ops[] = {
-	[OP_ACCESS]		= (nfsd4_enc)nfsd4_encode_access,
-	[OP_CLOSE]		= (nfsd4_enc)nfsd4_encode_close,
-	[OP_COMMIT]		= (nfsd4_enc)nfsd4_encode_commit,
-	[OP_CREATE]		= (nfsd4_enc)nfsd4_encode_create,
-	[OP_DELEGPURGE]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_DELEGRETURN]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_GETATTR]		= (nfsd4_enc)nfsd4_encode_getattr,
-	[OP_GETFH]		= (nfsd4_enc)nfsd4_encode_getfh,
-	[OP_LINK]		= (nfsd4_enc)nfsd4_encode_link,
-	[OP_LOCK]		= (nfsd4_enc)nfsd4_encode_lock,
-	[OP_LOCKT]		= (nfsd4_enc)nfsd4_encode_lockt,
-	[OP_LOCKU]		= (nfsd4_enc)nfsd4_encode_locku,
-	[OP_LOOKUP]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_LOOKUPP]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_NVERIFY]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_OPEN]		= (nfsd4_enc)nfsd4_encode_open,
-	[OP_OPENATTR]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_OPEN_CONFIRM]	= (nfsd4_enc)nfsd4_encode_open_confirm,
-	[OP_OPEN_DOWNGRADE]	= (nfsd4_enc)nfsd4_encode_open_downgrade,
-	[OP_PUTFH]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_PUTPUBFH]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_PUTROOTFH]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_READ]		= (nfsd4_enc)nfsd4_encode_read,
-	[OP_READDIR]		= (nfsd4_enc)nfsd4_encode_readdir,
-	[OP_READLINK]		= (nfsd4_enc)nfsd4_encode_readlink,
-	[OP_REMOVE]		= (nfsd4_enc)nfsd4_encode_remove,
-	[OP_RENAME]		= (nfsd4_enc)nfsd4_encode_rename,
-	[OP_RENEW]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_RESTOREFH]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_SAVEFH]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_SECINFO]		= (nfsd4_enc)nfsd4_encode_secinfo,
-	[OP_SETATTR]		= (nfsd4_enc)nfsd4_encode_setattr,
-	[OP_SETCLIENTID]	= (nfsd4_enc)nfsd4_encode_setclientid,
-	[OP_SETCLIENTID_CONFIRM] = (nfsd4_enc)nfsd4_encode_noop,
-	[OP_VERIFY]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_WRITE]		= (nfsd4_enc)nfsd4_encode_write,
-	[OP_RELEASE_LOCKOWNER]	= (nfsd4_enc)nfsd4_encode_noop,
+	[OP_ACCESS]		= nfsd4_encode_access,
+	[OP_CLOSE]		= nfsd4_encode_close,
+	[OP_COMMIT]		= nfsd4_encode_commit,
+	[OP_CREATE]		= nfsd4_encode_create,
+	[OP_DELEGPURGE]		= nfsd4_encode_noop,
+	[OP_DELEGRETURN]	= nfsd4_encode_noop,
+	[OP_GETATTR]		= nfsd4_encode_getattr,
+	[OP_GETFH]		= nfsd4_encode_getfh,
+	[OP_LINK]		= nfsd4_encode_link,
+	[OP_LOCK]		= nfsd4_encode_lock,
+	[OP_LOCKT]		= nfsd4_encode_lockt,
+	[OP_LOCKU]		= nfsd4_encode_locku,
+	[OP_LOOKUP]		= nfsd4_encode_noop,
+	[OP_LOOKUPP]		= nfsd4_encode_noop,
+	[OP_NVERIFY]		= nfsd4_encode_noop,
+	[OP_OPEN]		= nfsd4_encode_open,
+	[OP_OPENATTR]		= nfsd4_encode_noop,
+	[OP_OPEN_CONFIRM]	= nfsd4_encode_open_confirm,
+	[OP_OPEN_DOWNGRADE]	= nfsd4_encode_open_downgrade,
+	[OP_PUTFH]		= nfsd4_encode_noop,
+	[OP_PUTPUBFH]		= nfsd4_encode_noop,
+	[OP_PUTROOTFH]		= nfsd4_encode_noop,
+	[OP_READ]		= nfsd4_encode_read,
+	[OP_READDIR]		= nfsd4_encode_readdir,
+	[OP_READLINK]		= nfsd4_encode_readlink,
+	[OP_REMOVE]		= nfsd4_encode_remove,
+	[OP_RENAME]		= nfsd4_encode_rename,
+	[OP_RENEW]		= nfsd4_encode_noop,
+	[OP_RESTOREFH]		= nfsd4_encode_noop,
+	[OP_SAVEFH]		= nfsd4_encode_noop,
+	[OP_SECINFO]		= nfsd4_encode_secinfo,
+	[OP_SETATTR]		= nfsd4_encode_setattr,
+	[OP_SETCLIENTID]	= nfsd4_encode_setclientid,
+	[OP_SETCLIENTID_CONFIRM] = nfsd4_encode_noop,
+	[OP_VERIFY]		= nfsd4_encode_noop,
+	[OP_WRITE]		= nfsd4_encode_write,
+	[OP_RELEASE_LOCKOWNER]	= nfsd4_encode_noop,
 
 	/* NFSv4.1 operations */
-	[OP_BACKCHANNEL_CTL]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_BIND_CONN_TO_SESSION] = (nfsd4_enc)nfsd4_encode_bind_conn_to_session,
-	[OP_EXCHANGE_ID]	= (nfsd4_enc)nfsd4_encode_exchange_id,
-	[OP_CREATE_SESSION]	= (nfsd4_enc)nfsd4_encode_create_session,
-	[OP_DESTROY_SESSION]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_FREE_STATEID]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_GET_DIR_DELEGATION]	= (nfsd4_enc)nfsd4_encode_noop,
+	[OP_BACKCHANNEL_CTL]	= nfsd4_encode_noop,
+	[OP_BIND_CONN_TO_SESSION] = nfsd4_encode_bind_conn_to_session,
+	[OP_EXCHANGE_ID]	= nfsd4_encode_exchange_id,
+	[OP_CREATE_SESSION]	= nfsd4_encode_create_session,
+	[OP_DESTROY_SESSION]	= nfsd4_encode_noop,
+	[OP_FREE_STATEID]	= nfsd4_encode_noop,
+	[OP_GET_DIR_DELEGATION]	= nfsd4_encode_noop,
 #ifdef CONFIG_NFSD_PNFS
-	[OP_GETDEVICEINFO]	= (nfsd4_enc)nfsd4_encode_getdeviceinfo,
-	[OP_GETDEVICELIST]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_LAYOUTCOMMIT]	= (nfsd4_enc)nfsd4_encode_layoutcommit,
-	[OP_LAYOUTGET]		= (nfsd4_enc)nfsd4_encode_layoutget,
-	[OP_LAYOUTRETURN]	= (nfsd4_enc)nfsd4_encode_layoutreturn,
+	[OP_GETDEVICEINFO]	= nfsd4_encode_getdeviceinfo,
+	[OP_GETDEVICELIST]	= nfsd4_encode_noop,
+	[OP_LAYOUTCOMMIT]	= nfsd4_encode_layoutcommit,
+	[OP_LAYOUTGET]		= nfsd4_encode_layoutget,
+	[OP_LAYOUTRETURN]	= nfsd4_encode_layoutreturn,
 #else
-	[OP_GETDEVICEINFO]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_GETDEVICELIST]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_LAYOUTCOMMIT]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_LAYOUTGET]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_LAYOUTRETURN]	= (nfsd4_enc)nfsd4_encode_noop,
+	[OP_GETDEVICEINFO]	= nfsd4_encode_noop,
+	[OP_GETDEVICELIST]	= nfsd4_encode_noop,
+	[OP_LAYOUTCOMMIT]	= nfsd4_encode_noop,
+	[OP_LAYOUTGET]		= nfsd4_encode_noop,
+	[OP_LAYOUTRETURN]	= nfsd4_encode_noop,
 #endif
-	[OP_SECINFO_NO_NAME]	= (nfsd4_enc)nfsd4_encode_secinfo_no_name,
-	[OP_SEQUENCE]		= (nfsd4_enc)nfsd4_encode_sequence,
-	[OP_SET_SSV]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_TEST_STATEID]	= (nfsd4_enc)nfsd4_encode_test_stateid,
-	[OP_WANT_DELEGATION]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_DESTROY_CLIENTID]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_RECLAIM_COMPLETE]	= (nfsd4_enc)nfsd4_encode_noop,
+	[OP_SECINFO_NO_NAME]	= nfsd4_encode_secinfo_no_name,
+	[OP_SEQUENCE]		= nfsd4_encode_sequence,
+	[OP_SET_SSV]		= nfsd4_encode_noop,
+	[OP_TEST_STATEID]	= nfsd4_encode_test_stateid,
+	[OP_WANT_DELEGATION]	= nfsd4_encode_noop,
+	[OP_DESTROY_CLIENTID]	= nfsd4_encode_noop,
+	[OP_RECLAIM_COMPLETE]	= nfsd4_encode_noop,
 
 	/* NFSv4.2 operations */
-	[OP_ALLOCATE]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_COPY]		= (nfsd4_enc)nfsd4_encode_copy,
-	[OP_COPY_NOTIFY]	= (nfsd4_enc)nfsd4_encode_copy_notify,
-	[OP_DEALLOCATE]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_IO_ADVISE]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_LAYOUTERROR]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_LAYOUTSTATS]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_OFFLOAD_CANCEL]	= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_OFFLOAD_STATUS]	= (nfsd4_enc)nfsd4_encode_offload_status,
-	[OP_READ_PLUS]		= (nfsd4_enc)nfsd4_encode_read_plus,
-	[OP_SEEK]		= (nfsd4_enc)nfsd4_encode_seek,
-	[OP_WRITE_SAME]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_CLONE]		= (nfsd4_enc)nfsd4_encode_noop,
+	[OP_ALLOCATE]		= nfsd4_encode_noop,
+	[OP_COPY]		= nfsd4_encode_copy,
+	[OP_COPY_NOTIFY]	= nfsd4_encode_copy_notify,
+	[OP_DEALLOCATE]		= nfsd4_encode_noop,
+	[OP_IO_ADVISE]		= nfsd4_encode_noop,
+	[OP_LAYOUTERROR]	= nfsd4_encode_noop,
+	[OP_LAYOUTSTATS]	= nfsd4_encode_noop,
+	[OP_OFFLOAD_CANCEL]	= nfsd4_encode_noop,
+	[OP_OFFLOAD_STATUS]	= nfsd4_encode_offload_status,
+	[OP_READ_PLUS]		= nfsd4_encode_read_plus,
+	[OP_SEEK]		= nfsd4_encode_seek,
+	[OP_WRITE_SAME]		= nfsd4_encode_noop,
+	[OP_CLONE]		= nfsd4_encode_noop,
 
 	/* RFC 8276 extended atributes operations */
-	[OP_GETXATTR]		= (nfsd4_enc)nfsd4_encode_getxattr,
-	[OP_SETXATTR]		= (nfsd4_enc)nfsd4_encode_setxattr,
-	[OP_LISTXATTRS]		= (nfsd4_enc)nfsd4_encode_listxattrs,
-	[OP_REMOVEXATTR]	= (nfsd4_enc)nfsd4_encode_removexattr,
+	[OP_GETXATTR]		= nfsd4_encode_getxattr,
+	[OP_SETXATTR]		= nfsd4_encode_setxattr,
+	[OP_LISTXATTRS]		= nfsd4_encode_listxattrs,
+	[OP_REMOVEXATTR]	= nfsd4_encode_removexattr,
 };
 
 /*
-- 
2.43.0




