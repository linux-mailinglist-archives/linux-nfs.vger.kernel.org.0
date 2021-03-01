Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBBC328224
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbhCAPSM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:18:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237084AbhCAPRx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:17:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D45AC64E04
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:17:37 +0000 (UTC)
Subject: [PATCH v1 23/42] NFSD: Update the NFSv2 stat encoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:17:37 -0500
Message-ID: <161461185712.8508.3276231253261055719.stgit@klimt.1015granger.net>
In-Reply-To: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsproc.c |   10 +++++-----
 fs/nfsd/nfsxdr.c  |   19 ++++++++++++++++---
 fs/nfsd/xdr.h     |    2 +-
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index a8d5449dd0e9..59080e6793b9 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -736,7 +736,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	[NFSPROC_REMOVE] = {
 		.pc_func = nfsd_proc_remove,
 		.pc_decode = nfssvc_decode_diropargs,
-		.pc_encode = nfssvc_encode_stat,
+		.pc_encode = nfssvc_encode_statres,
 		.pc_argsize = sizeof(struct nfsd_diropargs),
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
@@ -746,7 +746,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	[NFSPROC_RENAME] = {
 		.pc_func = nfsd_proc_rename,
 		.pc_decode = nfssvc_decode_renameargs,
-		.pc_encode = nfssvc_encode_stat,
+		.pc_encode = nfssvc_encode_statres,
 		.pc_argsize = sizeof(struct nfsd_renameargs),
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
@@ -756,7 +756,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	[NFSPROC_LINK] = {
 		.pc_func = nfsd_proc_link,
 		.pc_decode = nfssvc_decode_linkargs,
-		.pc_encode = nfssvc_encode_stat,
+		.pc_encode = nfssvc_encode_statres,
 		.pc_argsize = sizeof(struct nfsd_linkargs),
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
@@ -766,7 +766,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	[NFSPROC_SYMLINK] = {
 		.pc_func = nfsd_proc_symlink,
 		.pc_decode = nfssvc_decode_symlinkargs,
-		.pc_encode = nfssvc_encode_stat,
+		.pc_encode = nfssvc_encode_statres,
 		.pc_argsize = sizeof(struct nfsd_symlinkargs),
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
@@ -787,7 +787,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	[NFSPROC_RMDIR] = {
 		.pc_func = nfsd_proc_rmdir,
 		.pc_decode = nfssvc_decode_diropargs,
-		.pc_encode = nfssvc_encode_stat,
+		.pc_encode = nfssvc_encode_statres,
 		.pc_argsize = sizeof(struct nfsd_diropargs),
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 5d79ef6a0c7f..10cd120044b3 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -26,6 +26,19 @@ static u32	nfs_ftypes[] = {
  * Basic NFSv2 data types (RFC 1094 Section 2.3)
  */
 
+static bool
+svcxdr_encode_stat(struct xdr_stream *xdr, __be32 status)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, sizeof(status));
+	if (!p)
+		return false;
+	*p = status;
+
+	return true;
+}
+
 /**
  * svcxdr_decode_fhandle - Decode an NFSv2 file handle
  * @xdr: XDR stream positioned at an encoded NFSv2 FH
@@ -390,12 +403,12 @@ nfssvc_decode_readdirargs(struct svc_rqst *rqstp, __be32 *p)
  */
 
 int
-nfssvc_encode_stat(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_encode_statres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_stat *resp = rqstp->rq_resp;
 
-	*p++ = resp->status;
-	return xdr_ressize_check(rqstp, p);
+	return svcxdr_encode_stat(xdr, resp->status);
 }
 
 int
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 3018b52b6d5e..a74ffcf8b9c6 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -147,7 +147,7 @@ int nfssvc_decode_renameargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_linkargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_symlinkargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_readdirargs(struct svc_rqst *, __be32 *);
-int nfssvc_encode_stat(struct svc_rqst *, __be32 *);
+int nfssvc_encode_statres(struct svc_rqst *, __be32 *);
 int nfssvc_encode_attrstat(struct svc_rqst *, __be32 *);
 int nfssvc_encode_diropres(struct svc_rqst *, __be32 *);
 int nfssvc_encode_readlinkres(struct svc_rqst *, __be32 *);


