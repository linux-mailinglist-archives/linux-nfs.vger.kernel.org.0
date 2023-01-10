Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8B5664BA9
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 19:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbjAJSxA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 13:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238435AbjAJSwf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 13:52:35 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184A7E98
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 10:47:33 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-150b06cb1aeso13055563fac.11
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 10:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xDj1tRIYypE2pPjCV5CMdaYn7oma6cXmkgdATiHjTxA=;
        b=PwqG2e9SqTI6yL61bw5m1vkoKQg/6V56M2jxRtdNJyoEL7G6YQv4IlY2gnJm5aca+I
         wG9WzO/gw7tat9n4Sv+xcArkTlW26XOw2mece1rsuHTMV4OK8uhHB6p7YbqUDUGUe0q1
         U/Py48RIqMGoOB/nRwiLPWTRQeE1WxKMTFiTRkL6qnXeNj/reXl4KIYJPwD+iPFeIGx1
         o/2rWUg/Dj/9lfP1Pjfqo8IIhs9rKF645uDL9xCHPbsynzF/NOqxaJte+yulvB1mOcf4
         kJmkIUjUrGMLV1Ou0PcUXOPJuHIs8Sqa/q40sf28BRW5MV7Yw/cCItcjexREWhEniT83
         V40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDj1tRIYypE2pPjCV5CMdaYn7oma6cXmkgdATiHjTxA=;
        b=UfTrLqsUVqXyJcoaCXH+WbnNwaxY4IvFBQUj1bS/exOheFqhbKj7mSOiByuJQ3oWd/
         VVhdE7QWCoik5vzvQb9bKqM0AKQZbxhv5knFXyR3oje+1wcJ7tXg7ajP6rbHXMRaOAvo
         FGobKBd3BdS2zQlrm5cCRVIFMBX+03qf9Xj2CPuNv7O3EPy9oj5gSBgaYcV2b+xVhEmm
         AwJsG32o9EnAKixxxvLHBrgaCluKxJLlkYCfZBr1olrt4p3LI29UPHPc99y2NiJRmxQs
         Ab99icL4CyACVJRc/YgB9kvFr4ZjXQgEQNUDHrC4t0akjLrnl9cBi0yI9JFPBkIYPvHQ
         uSGQ==
X-Gm-Message-State: AFqh2kr2zg6V6UHJJz/Hr0KssvlY+TRRkH0DNNKXEraO3BhCloJyXXgg
        x1GCxauiK0WEyaYtj8KQp4pmLpcFW4I=
X-Google-Smtp-Source: AMrXdXs/reVKdMg3HtSzi/0VRDGDsUv89dB/CkPysisJXn19FPFzqe5himE2GmPZEyFwtqT7tRhjDA==
X-Received: by 2002:a05:6870:4b4f:b0:14b:b6e2:c203 with SMTP id ls15-20020a0568704b4f00b0014bb6e2c203mr36804672oab.15.1673376451325;
        Tue, 10 Jan 2023 10:47:31 -0800 (PST)
Received: from localhost.localdomain (cpe-24-28-172-218.elp.res.rr.com. [24.28.172.218])
        by smtp.gmail.com with ESMTPSA id c6-20020a056870c08600b0014be94a12d0sm6168848oad.44.2023.01.10.10.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 10:47:30 -0800 (PST)
From:   Jorge Mora <jmora1300@gmail.com>
X-Google-Original-From: Jorge Mora <mora@netapp.com>
To:     linux-nfs@vger.kernel.org
Cc:     chuck.lever@oracle.com, jlayton@redhat.com
Subject: [PATCH v1] NFSD: add IO_ADVISE operation
Date:   Tue, 10 Jan 2023 11:47:26 -0700
Message-Id: <20230110184726.13380-1-mora@netapp.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If multiple bits are set, select just one using a predetermined
order of precedence. If there are no bits which correspond to
any of the advice values (POSIX_FADV_*), the server simply
replies with NFS4ERR_UNION_NOTSUPP.

If a client sends a bitmap mask with multiple words, ignore all
but the first word in the bitmap. The response is always the
same first word of the bitmap mask given in the request.

Signed-off-by: Jorge Mora <mora@netapp.com>
---
 fs/nfsd/nfs4proc.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfs4xdr.c  | 27 +++++++++++++++++++--
 fs/nfsd/xdr4.h     | 11 +++++++++
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8beb2bc4c328..65179a3946f5 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -35,6 +35,7 @@
 #include <linux/fs_struct.h>
 #include <linux/file.h>
 #include <linux/falloc.h>
+#include <linux/fadvise.h>
 #include <linux/slab.h>
 #include <linux/kthread.h>
 #include <linux/namei.h>
@@ -1995,6 +1996,53 @@ nfsd4_deallocate(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			       FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
 }
 
+static __be32
+nfsd4_io_advise(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+		union nfsd4_op_u *u)
+{
+	struct nfsd4_io_advise *io_advise = &u->io_advise;
+	struct nfsd_file *nf;
+	__be32 status;
+	int advice;
+	int ret;
+
+	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
+					    &io_advise->stateid,
+					    RD_STATE, &nf, NULL);
+	if (status) {
+		dprintk("NFSD: %s: couldn't process stateid!\n", __func__);
+		return status;
+	}
+
+	/*
+	 * If multiple bits are set, select just one using the following
+	 * order of precedence
+	 */
+	if (io_advise->hints & NFS_IO_ADVISE4_NORMAL)
+		advice = POSIX_FADV_NORMAL;
+	else if (io_advise->hints & NFS_IO_ADVISE4_RANDOM)
+		advice = POSIX_FADV_RANDOM;
+	else if (io_advise->hints & NFS_IO_ADVISE4_SEQUENTIAL)
+		advice = POSIX_FADV_SEQUENTIAL;
+	else if (io_advise->hints & NFS_IO_ADVISE4_WILLNEED)
+		advice = POSIX_FADV_WILLNEED;
+	else if (io_advise->hints & NFS_IO_ADVISE4_DONTNEED)
+		advice = POSIX_FADV_DONTNEED;
+	else if (io_advise->hints & NFS_IO_ADVISE4_NOREUSE)
+		advice = POSIX_FADV_NOREUSE;
+	else {
+		status = nfserr_union_notsupp;
+		goto out;
+	}
+
+	ret = vfs_fadvise(nf->nf_file, io_advise->offset, io_advise->count, advice);
+	if (ret < 0)
+		status = nfserrno(ret);
+out:
+	nfsd_file_put(nf);
+	return status;
+}
+
 static __be32
 nfsd4_seek(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	   union nfsd4_op_u *u)
@@ -3096,6 +3144,12 @@ static u32 nfsd4_layoutreturn_rsize(const struct svc_rqst *rqstp,
 #endif /* CONFIG_NFSD_PNFS */
 
 
+static u32 nfsd4_io_advise_rsize(const struct svc_rqst *rqstp,
+				 const struct nfsd4_op *op)
+{
+	return (op_encode_hdr_size + 2) * sizeof(__be32);
+}
+
 static u32 nfsd4_seek_rsize(const struct svc_rqst *rqstp,
 			    const struct nfsd4_op *op)
 {
@@ -3479,6 +3533,11 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_name = "OP_DEALLOCATE",
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
+	[OP_IO_ADVISE] = {
+		.op_func = nfsd4_io_advise,
+		.op_name = "OP_IO_ADVISE",
+		.op_rsize_bop = nfsd4_io_advise_rsize,
+	},
 	[OP_CLONE] = {
 		.op_func = nfsd4_clone,
 		.op_flags = OP_MODIFIES_SOMETHING,
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index bcfeb1a922c0..8814c24047ff 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1882,6 +1882,22 @@ nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_decode_io_advise(struct nfsd4_compoundargs *argp,
+		       struct nfsd4_io_advise *io_advise)
+{
+	__be32 status;
+
+	status = nfsd4_decode_stateid4(argp, &io_advise->stateid);
+	if (status)
+		return status;
+	if (xdr_stream_decode_u64(argp->xdr, &io_advise->offset) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &io_advise->count) < 0)
+		return nfserr_bad_xdr;
+	return nfsd4_decode_bitmap4(argp, &io_advise->hints, 1);
+}
+
 static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
 				      struct nl4_server *ns)
 {
@@ -2338,7 +2354,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
 	[OP_COPY]		= (nfsd4_dec)nfsd4_decode_copy,
 	[OP_COPY_NOTIFY]	= (nfsd4_dec)nfsd4_decode_copy_notify,
 	[OP_DEALLOCATE]		= (nfsd4_dec)nfsd4_decode_fallocate,
-	[OP_IO_ADVISE]		= (nfsd4_dec)nfsd4_decode_notsupp,
+	[OP_IO_ADVISE]		= (nfsd4_dec)nfsd4_decode_io_advise,
 	[OP_LAYOUTERROR]	= (nfsd4_dec)nfsd4_decode_notsupp,
 	[OP_LAYOUTSTATS]	= (nfsd4_dec)nfsd4_decode_notsupp,
 	[OP_OFFLOAD_CANCEL]	= (nfsd4_dec)nfsd4_decode_offload_status,
@@ -4948,6 +4964,13 @@ nfsd4_encode_copy_notify(struct nfsd4_compoundres *resp, __be32 nfserr,
 	return nfserr;
 }
 
+static __be32
+nfsd4_encode_io_advise(struct nfsd4_compoundres *resp, __be32 nfserr,
+		       struct nfsd4_io_advise *io_advise)
+{
+	return nfsd4_encode_bitmap(resp->xdr, io_advise->hints, 0, 0);
+}
+
 static __be32
 nfsd4_encode_seek(struct nfsd4_compoundres *resp, __be32 nfserr,
 		  struct nfsd4_seek *seek)
@@ -5282,7 +5305,7 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
 	[OP_COPY]		= (nfsd4_enc)nfsd4_encode_copy,
 	[OP_COPY_NOTIFY]	= (nfsd4_enc)nfsd4_encode_copy_notify,
 	[OP_DEALLOCATE]		= (nfsd4_enc)nfsd4_encode_noop,
-	[OP_IO_ADVISE]		= (nfsd4_enc)nfsd4_encode_noop,
+	[OP_IO_ADVISE]		= (nfsd4_enc)nfsd4_encode_io_advise,
 	[OP_LAYOUTERROR]	= (nfsd4_enc)nfsd4_encode_noop,
 	[OP_LAYOUTSTATS]	= (nfsd4_enc)nfsd4_encode_noop,
 	[OP_OFFLOAD_CANCEL]	= (nfsd4_enc)nfsd4_encode_noop,
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 0eb00105d845..9b8ba4d6e3ab 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -518,6 +518,16 @@ struct nfsd4_fallocate {
 	u64		falloc_length;
 };
 
+struct nfsd4_io_advise {
+	/* request */
+	stateid_t	stateid;
+	loff_t		offset;
+	u64		count;
+
+	/* both */
+	u32		hints;
+};
+
 struct nfsd4_clone {
 	/* request */
 	stateid_t	cl_src_stateid;
@@ -688,6 +698,7 @@ struct nfsd4_op {
 		/* NFSv4.2 */
 		struct nfsd4_fallocate		allocate;
 		struct nfsd4_fallocate		deallocate;
+		struct nfsd4_io_advise		io_advise;
 		struct nfsd4_clone		clone;
 		struct nfsd4_copy		copy;
 		struct nfsd4_offload_status	offload_status;
-- 
2.31.1

