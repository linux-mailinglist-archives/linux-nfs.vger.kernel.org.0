Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744AD269760
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Sep 2020 23:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgINVFN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Sep 2020 17:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgINVFJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Sep 2020 17:05:09 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17119C06174A
        for <linux-nfs@vger.kernel.org>; Mon, 14 Sep 2020 14:05:08 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id j2so1677382ioj.7
        for <linux-nfs@vger.kernel.org>; Mon, 14 Sep 2020 14:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0nMpJFd+2Kdqf7SuiuZEkUcCzcE7XnMWFUAV8vqCbTo=;
        b=mu2BkvCoBhnlhxDAqWy2H056P4Qf11b6Co1E2Y33ePOrbc0U7CWrz9hHtnXjE6rUdT
         2lmTUWeUiWtFqEQjodcoThWUjs2pLevP/T1h9bVSUZc30EOvBFSuuiqtL5lkka/G4LvE
         /XT1Dqp62IrqdSPNngER3u3gcGPuk7uDE2T0y4oQlD4PU4x4feHsX2dODnB1tZwdnVv4
         YDBb2gKg9b1Bt9STbm4DAg1ZmeyWxiNCXJkCRSHWuTfBtbXc6GPzAiol8rJa+cxCmg1M
         H29xXcG/JGOHDlceNkNwYGhEhJVYf44UQ1v5KThhGzebda7rMRestBItT38iRKi9bXrX
         jddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0nMpJFd+2Kdqf7SuiuZEkUcCzcE7XnMWFUAV8vqCbTo=;
        b=uhEbY+SZOxLp+yNI405V8gTkN/1o4T6wIq1h/howbbf7+RqxcIhhPa/0w1smM7ElyR
         fHf6bwPgEB15D3CQIowO8+qzq8okpsO5Q3hL6h3AB0s1JGjh7BqgoCSfrYPAyXvfI/fK
         tbGn/Qg0X8PIxdsxASfC0/rPGWVOKCgqmpltvaDAt41o5I2JTTxQ+GjGSsAC/cVy1pYw
         VQuR+Ulpgt6dmVYKong2iL8QX0pKPWAnlhnMKHy2NaeCx5VyVIzlAhdmVyy0yE8BBmTV
         3mwQ6vjb+TK9JJdOh84RIn01mwNB5zbP1zla7EISD6kyoEexaXKw80xnbBVYcX4UJvut
         K1RQ==
X-Gm-Message-State: AOAM533trABTlgxOhAdzmsYf0aqxkMO/KeFs+2wPI7cIydvPN+ljkDWK
        62JwyaMOfrzCoQ44Is1EOG8=
X-Google-Smtp-Source: ABdhPJyHoFdFgj0CoHFARwzI5ftwlHc21AiNRX/XJHU0rY3D8JR0d/62Z7MuJfUvyUmq0QzxHaAYGg==
X-Received: by 2002:a05:6638:d4e:: with SMTP id d14mr14802232jak.107.1600117507376;
        Mon, 14 Sep 2020 14:05:07 -0700 (PDT)
Received: from Olgas-MBP-286.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id v14sm6529869iol.17.2020.09.14.14.05.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Sep 2020 14:05:06 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4: make cache consistency bitmask dynamic
Date:   Mon, 14 Sep 2020 17:05:08 -0400
Message-Id: <20200914210508.7701-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Client uses static bitmask for GETATTR on CLOSE/WRITE/DELEGRETURN
and ignores the fact that it might have some attributes marked
invalid in its cache. Compared to v3 where all attributes are
retrieved in postop attributes, v4's cache is frequently out of
sync and leads to standalone GETATTRs being sent to the server.

Instead, in addition to the minimum cache consistency attributes
also check cache_validity and adjust the GETATTR request accordingly.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c       | 45 ++++++++++++++++++++++++++++++++++++++---
 include/linux/nfs_xdr.h |  6 +++---
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6e95c85fe395..d7434a3697d9 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -107,6 +107,9 @@ static int nfs41_test_stateid(struct nfs_server *, nfs4_stateid *,
 static int nfs41_free_stateid(struct nfs_server *, const nfs4_stateid *,
 		const struct cred *, bool);
 #endif
+static void nfs4_bitmask_adjust(__u32 *bitmask, struct inode *inode,
+		struct nfs_server *server,
+		struct nfs4_label *label);
 
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 static inline struct nfs4_label *
@@ -3632,9 +3635,10 @@ static void nfs4_close_prepare(struct rpc_task *task, void *data)
 
 	if (calldata->arg.fmode == 0 || calldata->arg.fmode == FMODE_READ) {
 		/* Close-to-open cache consistency revalidation */
-		if (!nfs4_have_delegation(inode, FMODE_READ))
+		if (!nfs4_have_delegation(inode, FMODE_READ)) {
 			calldata->arg.bitmask = NFS_SERVER(inode)->cache_consistency_bitmask;
-		else
+			nfs4_bitmask_adjust(calldata->arg.bitmask, inode, NFS_SERVER(inode), NULL);
+		} else
 			calldata->arg.bitmask = NULL;
 	}
 
@@ -5360,6 +5364,38 @@ bool nfs4_write_need_cache_consistency_data(struct nfs_pgio_header *hdr)
 	return nfs4_have_delegation(hdr->inode, FMODE_READ) == 0;
 }
 
+static void nfs4_bitmask_adjust(__u32 *bitmask, struct inode *inode,
+				struct nfs_server *server,
+				struct nfs4_label *label)
+{
+
+	unsigned long cache_validity = READ_ONCE(NFS_I(inode)->cache_validity);
+
+	if ((cache_validity & NFS_INO_INVALID_DATA) ||
+		(cache_validity & NFS_INO_REVAL_PAGECACHE) ||
+		(cache_validity & NFS_INO_REVAL_FORCED) ||
+		(cache_validity & NFS_INO_INVALID_OTHER))
+		nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, label), inode);
+
+	if (cache_validity & NFS_INO_INVALID_ATIME)
+		bitmask[1] |= FATTR4_WORD1_TIME_ACCESS;
+	if (cache_validity & NFS_INO_INVALID_ACCESS)
+		bitmask[0] |= FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER |
+				FATTR4_WORD1_OWNER_GROUP;
+	if (cache_validity & NFS_INO_INVALID_ACL)
+		bitmask[0] |= FATTR4_WORD0_ACL;
+	if (cache_validity & NFS_INO_INVALID_LABEL)
+		bitmask[2] |= FATTR4_WORD2_SECURITY_LABEL;
+	if (cache_validity & NFS_INO_INVALID_CTIME)
+		bitmask[0] |= FATTR4_WORD0_CHANGE;
+	if (cache_validity & NFS_INO_INVALID_MTIME)
+		bitmask[1] |= FATTR4_WORD1_TIME_MODIFY;
+	if (cache_validity & NFS_INO_INVALID_SIZE)
+		bitmask[0] |= FATTR4_WORD0_SIZE;
+	if (cache_validity & NFS_INO_INVALID_BLOCKS)
+		bitmask[1] |= FATTR4_WORD1_SPACE_USED;
+}
+
 static void nfs4_proc_write_setup(struct nfs_pgio_header *hdr,
 				  struct rpc_message *msg,
 				  struct rpc_clnt **clnt)
@@ -5369,8 +5405,10 @@ static void nfs4_proc_write_setup(struct nfs_pgio_header *hdr,
 	if (!nfs4_write_need_cache_consistency_data(hdr)) {
 		hdr->args.bitmask = NULL;
 		hdr->res.fattr = NULL;
-	} else
+	} else {
 		hdr->args.bitmask = server->cache_consistency_bitmask;
+		nfs4_bitmask_adjust(hdr->args.bitmask, hdr->inode, server, NULL);
+	}
 
 	if (!hdr->pgio_done_cb)
 		hdr->pgio_done_cb = nfs4_write_done_cb;
@@ -6406,6 +6444,7 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 	data->args.fhandle = &data->fh;
 	data->args.stateid = &data->stateid;
 	data->args.bitmask = server->cache_consistency_bitmask;
+	nfs4_bitmask_adjust(data->args.bitmask, inode, server, NULL);
 	nfs_copy_fh(&data->fh, NFS_FH(inode));
 	nfs4_stateid_copy(&data->stateid, stateid);
 	data->res.fattr = &data->fattr;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 9408f3252c8e..bafbf6695796 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -525,7 +525,7 @@ struct nfs_closeargs {
 	struct nfs_seqid *	seqid;
 	fmode_t			fmode;
 	u32			share_access;
-	const u32 *		bitmask;
+	u32 *			bitmask;
 	struct nfs4_layoutreturn_args *lr_args;
 };
 
@@ -608,7 +608,7 @@ struct nfs4_delegreturnargs {
 	struct nfs4_sequence_args	seq_args;
 	const struct nfs_fh *fhandle;
 	const nfs4_stateid *stateid;
-	const u32 * bitmask;
+	u32 * bitmask;
 	struct nfs4_layoutreturn_args *lr_args;
 };
 
@@ -648,7 +648,7 @@ struct nfs_pgio_args {
 	union {
 		unsigned int		replen;			/* used by read */
 		struct {
-			const u32 *		bitmask;	/* used by write */
+			u32 *			bitmask;	/* used by write */
 			enum nfs3_stable_how	stable;		/* used by write */
 		};
 	};
-- 
2.18.1

