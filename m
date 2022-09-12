Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D235B62A5
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 23:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiILVWu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 17:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiILVWt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 17:22:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF0D2AC65
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 14:22:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC98DB80C9E
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 21:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DC7C433B5
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 21:22:45 +0000 (UTC)
Subject: [PATCH v1 03/12] NFSD: Reduce amount of struct nfsd4_compoundargs
 that needs clearing
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 12 Sep 2022 17:22:44 -0400
Message-ID: <166301776455.89884.7317763064097755855.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <166301759113.89884.7985359396842428444.stgit@oracle-102.nfsv4.dev>
References: <166301759113.89884.7985359396842428444.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Have SunRPC clear everything except for the iops array. Then have
each NFSv4 XDR decoder clear it's own argument before decoding.

Now individual operations may have a large argument struct while not
penalizing the vast majority of operations with a small struct.

And, clearing the argument structure occurs as the argument fields
are initialized, enabling the CPU to do write combining on that
memory. In some cases, clearing is not even necessary because all
of the fields in the argument structure are initialized by the
decoder.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    2 +-
 fs/nfsd/nfs4xdr.c  |   61 +++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 66a99827c7aa..bb22f53c7ba9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3596,7 +3596,7 @@ static const struct svc_procedure nfsd_procedures4[2] = {
 		.pc_decode = nfs4svc_decode_compoundargs,
 		.pc_encode = nfs4svc_encode_compoundres,
 		.pc_argsize = sizeof(struct nfsd4_compoundargs),
-		.pc_argzero = sizeof(struct nfsd4_compoundargs),
+		.pc_argzero = offsetof(struct nfsd4_compoundargs, iops),
 		.pc_ressize = sizeof(struct nfsd4_compoundres),
 		.pc_release = nfsd4_release_compoundargs,
 		.pc_cachetype = RC_NOCACHE,
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 30d4897e62ab..49afc0e5b04c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -793,6 +793,7 @@ nfsd4_decode_commit(struct nfsd4_compoundargs *argp, struct nfsd4_commit *commit
 		return nfserr_bad_xdr;
 	if (xdr_stream_decode_u32(argp->xdr, &commit->co_count) < 0)
 		return nfserr_bad_xdr;
+	memset(&commit->co_verf, 0, sizeof(commit->co_verf));
 	return nfs_ok;
 }
 
@@ -801,6 +802,7 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create
 {
 	__be32 *p, status;
 
+	memset(create, 0, sizeof(*create));
 	if (xdr_stream_decode_u32(argp->xdr, &create->cr_type) < 0)
 		return nfserr_bad_xdr;
 	switch (create->cr_type) {
@@ -850,6 +852,7 @@ nfsd4_decode_delegreturn(struct nfsd4_compoundargs *argp, struct nfsd4_delegretu
 static inline __be32
 nfsd4_decode_getattr(struct nfsd4_compoundargs *argp, struct nfsd4_getattr *getattr)
 {
+	memset(getattr, 0, sizeof(*getattr));
 	return nfsd4_decode_bitmap4(argp, getattr->ga_bmval,
 				    ARRAY_SIZE(getattr->ga_bmval));
 }
@@ -857,6 +860,7 @@ nfsd4_decode_getattr(struct nfsd4_compoundargs *argp, struct nfsd4_getattr *geta
 static __be32
 nfsd4_decode_link(struct nfsd4_compoundargs *argp, struct nfsd4_link *link)
 {
+	memset(link, 0, sizeof(*link));
 	return nfsd4_decode_component4(argp, &link->li_name, &link->li_namelen);
 }
 
@@ -905,6 +909,7 @@ nfsd4_decode_locker4(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 static __be32
 nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 {
+	memset(lock, 0, sizeof(*lock));
 	if (xdr_stream_decode_u32(argp->xdr, &lock->lk_type) < 0)
 		return nfserr_bad_xdr;
 	if ((lock->lk_type < NFS4_READ_LT) || (lock->lk_type > NFS4_WRITEW_LT))
@@ -921,6 +926,7 @@ nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 static __be32
 nfsd4_decode_lockt(struct nfsd4_compoundargs *argp, struct nfsd4_lockt *lockt)
 {
+	memset(lockt, 0, sizeof(*lockt));
 	if (xdr_stream_decode_u32(argp->xdr, &lockt->lt_type) < 0)
 		return nfserr_bad_xdr;
 	if ((lockt->lt_type < NFS4_READ_LT) || (lockt->lt_type > NFS4_WRITEW_LT))
@@ -1142,11 +1148,8 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 	__be32 status;
 	u32 dummy;
 
-	memset(open->op_bmval, 0, sizeof(open->op_bmval));
-	open->op_iattr.ia_valid = 0;
-	open->op_openowner = NULL;
+	memset(open, 0, sizeof(*open));
 
-	open->op_xdr_error = 0;
 	if (xdr_stream_decode_u32(argp->xdr, &open->op_seqid) < 0)
 		return nfserr_bad_xdr;
 	/* deleg_want is ignored */
@@ -1181,6 +1184,8 @@ nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_open_con
 	if (xdr_stream_decode_u32(argp->xdr, &open_conf->oc_seqid) < 0)
 		return nfserr_bad_xdr;
 
+	memset(&open_conf->oc_resp_stateid, 0,
+	       sizeof(open_conf->oc_resp_stateid));
 	return nfs_ok;
 }
 
@@ -1189,6 +1194,7 @@ nfsd4_decode_open_downgrade(struct nfsd4_compoundargs *argp, struct nfsd4_open_d
 {
 	__be32 status;
 
+	memset(open_down, 0, sizeof(*open_down));
 	status = nfsd4_decode_stateid4(argp, &open_down->od_stateid);
 	if (status)
 		return status;
@@ -1218,6 +1224,7 @@ nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, struct nfsd4_putfh *putfh)
 	if (!putfh->pf_fhval)
 		return nfserr_jukebox;
 
+	putfh->no_verify = false;
 	return nfs_ok;
 }
 
@@ -1234,6 +1241,7 @@ nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *read)
 {
 	__be32 status;
 
+	memset(read, 0, sizeof(*read));
 	status = nfsd4_decode_stateid4(argp, &read->rd_stateid);
 	if (status)
 		return status;
@@ -1250,6 +1258,7 @@ nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, struct nfsd4_readdir *read
 {
 	__be32 status;
 
+	memset(readdir, 0, sizeof(*readdir));
 	if (xdr_stream_decode_u64(argp->xdr, &readdir->rd_cookie) < 0)
 		return nfserr_bad_xdr;
 	status = nfsd4_decode_verifier4(argp, &readdir->rd_verf);
@@ -1269,6 +1278,7 @@ nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, struct nfsd4_readdir *read
 static __be32
 nfsd4_decode_remove(struct nfsd4_compoundargs *argp, struct nfsd4_remove *remove)
 {
+	memset(&remove->rm_cinfo, 0, sizeof(remove->rm_cinfo));
 	return nfsd4_decode_component4(argp, &remove->rm_name, &remove->rm_namelen);
 }
 
@@ -1277,6 +1287,7 @@ nfsd4_decode_rename(struct nfsd4_compoundargs *argp, struct nfsd4_rename *rename
 {
 	__be32 status;
 
+	memset(rename, 0, sizeof(*rename));
 	status = nfsd4_decode_component4(argp, &rename->rn_sname, &rename->rn_snamelen);
 	if (status)
 		return status;
@@ -1293,6 +1304,7 @@ static __be32
 nfsd4_decode_secinfo(struct nfsd4_compoundargs *argp,
 		     struct nfsd4_secinfo *secinfo)
 {
+	secinfo->si_exp = NULL;
 	return nfsd4_decode_component4(argp, &secinfo->si_name, &secinfo->si_namelen);
 }
 
@@ -1301,6 +1313,7 @@ nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *seta
 {
 	__be32 status;
 
+	memset(setattr, 0, sizeof(*setattr));
 	status = nfsd4_decode_stateid4(argp, &setattr->sa_stateid);
 	if (status)
 		return status;
@@ -1315,6 +1328,8 @@ nfsd4_decode_setclientid(struct nfsd4_compoundargs *argp, struct nfsd4_setclient
 {
 	__be32 *p, status;
 
+	memset(setclientid, 0, sizeof(*setclientid));
+
 	if (argp->minorversion >= 1)
 		return nfserr_notsupp;
 
@@ -1371,6 +1386,8 @@ nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify
 {
 	__be32 *p, status;
 
+	memset(verify, 0, sizeof(*verify));
+
 	status = nfsd4_decode_bitmap4(argp, verify->ve_bmval,
 				      ARRAY_SIZE(verify->ve_bmval));
 	if (status)
@@ -1410,6 +1427,9 @@ nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
 	if (!xdr_stream_subsegment(argp->xdr, &write->wr_payload, write->wr_buflen))
 		return nfserr_bad_xdr;
 
+	write->wr_bytes_written = 0;
+	write->wr_how_written = 0;
+	memset(&write->wr_verifier, 0, sizeof(write->wr_verifier));
 	return nfs_ok;
 }
 
@@ -1434,6 +1454,7 @@ nfsd4_decode_release_lockowner(struct nfsd4_compoundargs *argp, struct nfsd4_rel
 
 static __be32 nfsd4_decode_backchannel_ctl(struct nfsd4_compoundargs *argp, struct nfsd4_backchannel_ctl *bc)
 {
+	memset(bc, 0, sizeof(*bc));
 	if (xdr_stream_decode_u32(argp->xdr, &bc->bc_cb_program) < 0)
 		return nfserr_bad_xdr;
 	return nfsd4_decode_cb_sec(argp, &bc->bc_cb_sec);
@@ -1444,6 +1465,7 @@ static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundargs *argp,
 	u32 use_conn_in_rdma_mode;
 	__be32 status;
 
+	memset(bcts, 0, sizeof(*bcts));
 	status = nfsd4_decode_sessionid4(argp, &bcts->sessionid);
 	if (status)
 		return status;
@@ -1585,6 +1607,7 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 {
 	__be32 status;
 
+	memset(exid, 0, sizeof(*exid));
 	status = nfsd4_decode_verifier4(argp, &exid->verifier);
 	if (status)
 		return status;
@@ -1637,6 +1660,7 @@ nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 {
 	__be32 status;
 
+	memset(sess, 0, sizeof(*sess));
 	status = nfsd4_decode_clientid4(argp, &sess->clientid);
 	if (status)
 		return status;
@@ -1652,11 +1676,7 @@ nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 		return status;
 	if (xdr_stream_decode_u32(argp->xdr, &sess->callback_prog) < 0)
 		return nfserr_bad_xdr;
-	status = nfsd4_decode_cb_sec(argp, &sess->cb_sec);
-	if (status)
-		return status;
-
-	return nfs_ok;
+	return nfsd4_decode_cb_sec(argp, &sess->cb_sec);
 }
 
 static __be32
@@ -1680,6 +1700,7 @@ nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
 {
 	__be32 status;
 
+	memset(gdev, 0, sizeof(*gdev));
 	status = nfsd4_decode_deviceid4(argp, &gdev->gd_devid);
 	if (status)
 		return status;
@@ -1700,6 +1721,7 @@ nfsd4_decode_layoutcommit(struct nfsd4_compoundargs *argp,
 {
 	__be32 *p, status;
 
+	memset(lcp, 0, sizeof(*lcp));
 	if (xdr_stream_decode_u64(argp->xdr, &lcp->lc_seg.offset) < 0)
 		return nfserr_bad_xdr;
 	if (xdr_stream_decode_u64(argp->xdr, &lcp->lc_seg.length) < 0)
@@ -1735,6 +1757,7 @@ nfsd4_decode_layoutget(struct nfsd4_compoundargs *argp,
 {
 	__be32 status;
 
+	memset(lgp, 0, sizeof(*lgp));
 	if (xdr_stream_decode_u32(argp->xdr, &lgp->lg_signal) < 0)
 		return nfserr_bad_xdr;
 	if (xdr_stream_decode_u32(argp->xdr, &lgp->lg_layout_type) < 0)
@@ -1760,6 +1783,7 @@ static __be32
 nfsd4_decode_layoutreturn(struct nfsd4_compoundargs *argp,
 		struct nfsd4_layoutreturn *lrp)
 {
+	memset(lrp, 0, sizeof(*lrp));
 	if (xdr_stream_decode_bool(argp->xdr, &lrp->lr_reclaim) < 0)
 		return nfserr_bad_xdr;
 	if (xdr_stream_decode_u32(argp->xdr, &lrp->lr_layout_type) < 0)
@@ -1775,6 +1799,8 @@ static __be32 nfsd4_decode_secinfo_no_name(struct nfsd4_compoundargs *argp,
 {
 	if (xdr_stream_decode_u32(argp->xdr, &sin->sin_style) < 0)
 		return nfserr_bad_xdr;
+
+	sin->sin_exp = NULL;
 	return nfs_ok;
 }
 
@@ -1795,6 +1821,7 @@ nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
 	seq->maxslots = be32_to_cpup(p++);
 	seq->cachethis = be32_to_cpup(p);
 
+	seq->status_flags = 0;
 	return nfs_ok;
 }
 
@@ -1805,6 +1832,7 @@ nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, struct nfsd4_test_sta
 	__be32 status;
 	u32 i;
 
+	memset(test_stateid, 0, sizeof(*test_stateid));
 	if (xdr_stream_decode_u32(argp->xdr, &test_stateid->ts_num_ids) < 0)
 		return nfserr_bad_xdr;
 
@@ -1902,6 +1930,7 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 	struct nl4_server *ns_dummy;
 	__be32 status;
 
+	memset(copy, 0, sizeof(*copy));
 	status = nfsd4_decode_stateid4(argp, &copy->cp_src_stateid);
 	if (status)
 		return status;
@@ -1957,6 +1986,7 @@ nfsd4_decode_copy_notify(struct nfsd4_compoundargs *argp,
 {
 	__be32 status;
 
+	memset(cn, 0, sizeof(*cn));
 	cn->cpn_src = svcxdr_tmpalloc(argp, sizeof(*cn->cpn_src));
 	if (cn->cpn_src == NULL)
 		return nfserr_jukebox;
@@ -1974,6 +2004,8 @@ static __be32
 nfsd4_decode_offload_status(struct nfsd4_compoundargs *argp,
 			    struct nfsd4_offload_status *os)
 {
+	os->count = 0;
+	os->status = 0;
 	return nfsd4_decode_stateid4(argp, &os->stateid);
 }
 
@@ -1990,6 +2022,8 @@ nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *seek)
 	if (xdr_stream_decode_u32(argp->xdr, &seek->seek_whence) < 0)
 		return nfserr_bad_xdr;
 
+	seek->seek_eof = 0;
+	seek->seek_pos = 0;
 	return nfs_ok;
 }
 
@@ -2125,6 +2159,7 @@ nfsd4_decode_getxattr(struct nfsd4_compoundargs *argp,
 	__be32 status;
 	u32 maxcount;
 
+	memset(getxattr, 0, sizeof(*getxattr));
 	status = nfsd4_decode_xattr_name(argp, &getxattr->getxa_name);
 	if (status)
 		return status;
@@ -2133,8 +2168,7 @@ nfsd4_decode_getxattr(struct nfsd4_compoundargs *argp,
 	maxcount = min_t(u32, XATTR_SIZE_MAX, maxcount);
 
 	getxattr->getxa_len = maxcount;
-
-	return status;
+	return nfs_ok;
 }
 
 static __be32
@@ -2144,6 +2178,8 @@ nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
 	u32 flags, maxcount, size;
 	__be32 status;
 
+	memset(setxattr, 0, sizeof(*setxattr));
+
 	if (xdr_stream_decode_u32(argp->xdr, &flags) < 0)
 		return nfserr_bad_xdr;
 
@@ -2182,6 +2218,8 @@ nfsd4_decode_listxattrs(struct nfsd4_compoundargs *argp,
 {
 	u32 maxcount;
 
+	memset(listxattrs, 0, sizeof(*listxattrs));
+
 	if (xdr_stream_decode_u64(argp->xdr, &listxattrs->lsxa_cookie) < 0)
 		return nfserr_bad_xdr;
 
@@ -2209,6 +2247,7 @@ static __be32
 nfsd4_decode_removexattr(struct nfsd4_compoundargs *argp,
 			 struct nfsd4_removexattr *removexattr)
 {
+	memset(removexattr, 0, sizeof(*removexattr));
 	return nfsd4_decode_xattr_name(argp, &removexattr->rmxa_name);
 }
 


