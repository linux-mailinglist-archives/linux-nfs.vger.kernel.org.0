Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE254455C6
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Nov 2021 15:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhKDPAC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Nov 2021 11:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhKDPAC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Nov 2021 11:00:02 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0256DC061714
        for <linux-nfs@vger.kernel.org>; Thu,  4 Nov 2021 07:57:24 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id l19so6506833ilk.0
        for <linux-nfs@vger.kernel.org>; Thu, 04 Nov 2021 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mNr5CYTHWJ4RFnVTFiYYlmXsAzABz7rwUHM1bbulcQo=;
        b=J1hlMh2lrEKjOI4JsvcRTbTFxftrhFMJHQnRBE/JWdJ+9kVLeSXLVL1yW68vipq939
         acUSqeKP1tNGSpS7a2FeC14RfpYhmXwJMndhOn3d/GKkCxlX8NeZ0u2tuByW0kFFdIHE
         ae+/3dtlVNqQ8ppAoXEgmdH32bqLd4YbXOnq+X0RZ2Hw4Bk5RM7u7Cb1iQ/tV9BGhTQP
         lAxvZEm+jTmq2Rf1TJkHD1tlQ5ZH+SltylOgbLN6LufK1SwqZD+4B/BY0iypCq1WUkgw
         ud5z5xmk5+ZHNDDngaboXDB5jw97+sh7xtTa9ZnNgqEBePw9tjQwseaHrBJn3mQyLPEk
         FQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mNr5CYTHWJ4RFnVTFiYYlmXsAzABz7rwUHM1bbulcQo=;
        b=6dEvtvYHrrWedkmluAaiHPufnGJZbZzeDmcFRyw3a9DDScZubJ4YYzg5EsZQE1uWYr
         TpwTSXNtrXAm6Xk2ZrqnBLKWQijSajyAhvIzlwsug8pw/jSTw8mQYcxjbBVDIOcYaRdS
         PKbxDLJ8U2U2Hx7Z3UXnKHUB7OK8/3jSSGHk5I8jlqnfMWlEXVRo/BR2nfgo2g6my8hl
         Ih0syAUEruxqy+ROrsjmGCv5o2TT5/qDJOJJ+vjQ7aD26V23Nwwd5mzy3YkYx7durFha
         P6oeTV7zpOJjmGZ+07KxgNLyElPTR9lOsIKAG6iklZR5WSeyJ0EOsuW+9sMlaLANhicy
         C49A==
X-Gm-Message-State: AOAM531Jh+HVYwfkVzI6Lq2ftvXIucckb78TqAuVskb6IpNIM6aCNgA4
        l9XJjgYgC3x3JphDkpY0WL6tISyOJVwIHA==
X-Google-Smtp-Source: ABdhPJxDIHzcZGcECD4vm/BCm84OhKU2ZJ3drho285kXbM6O/oJus/mFTfoNRd9giPlpjhNcJqPF0g==
X-Received: by 2002:a05:6e02:1bec:: with SMTP id y12mr2382712ilv.74.1636037843455;
        Thu, 04 Nov 2021 07:57:23 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:886c:a169:fafb:e7cf])
        by smtp.gmail.com with ESMTPSA id c12sm3007157ils.31.2021.11.04.07.57.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Nov 2021 07:57:20 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        chuck.level@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/7] NFSv4.2 add tracepoint to COPY
Date:   Thu,  4 Nov 2021 10:57:10 -0400
Message-Id: <20211104145714.57942-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211104145714.57942-1-olga.kornievskaia@gmail.com>
References: <20211104145714.57942-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add a tracepoint to the COPY operation.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c |   1 +
 fs/nfs/nfs4trace.h | 107 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index c36824888601..a072cdaf7bdc 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -367,6 +367,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 
 	status = nfs4_call_sync(dst_server->client, dst_server, &msg,
 				&args->seq_args, &res->seq_res, 0);
+	trace_nfs4_copy(src_inode, dst_inode, args, res, nss, status);
 	if (status == -ENOTSUPP)
 		dst_server->caps &= ~NFS_CAP_COPY;
 	if (status)
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index a88464238b88..bdccaec504d8 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2183,6 +2183,113 @@ DECLARE_EVENT_CLASS(nfs4_sparse_event,
 			TP_ARGS(inode, args, error))
 DEFINE_NFS4_SPARSE_EVENT(nfs4_fallocate);
 DEFINE_NFS4_SPARSE_EVENT(nfs4_deallocate);
+
+TRACE_EVENT(nfs4_copy,
+		TP_PROTO(
+			const struct inode *src_inode,
+			const struct inode *dst_inode,
+			const struct nfs42_copy_args *args,
+			const struct nfs42_copy_res *res,
+			const struct nl4_server *nss,
+			int error
+		),
+
+		TP_ARGS(src_inode, dst_inode, args, res, nss, error),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, error)
+			__field(u32, src_fhandle)
+			__field(u32, src_fileid)
+			__field(u32, dst_fhandle)
+			__field(u32, dst_fileid)
+			__field(dev_t, src_dev)
+			__field(dev_t, dst_dev)
+			__field(int, src_stateid_seq)
+			__field(u32, src_stateid_hash)
+			__field(int, dst_stateid_seq)
+			__field(u32, dst_stateid_hash)
+			__field(loff_t, src_offset)
+			__field(loff_t, dst_offset)
+			__field(bool, sync)
+			__field(loff_t, len)
+			__field(int, res_stateid_seq)
+			__field(u32, res_stateid_hash)
+			__field(loff_t, res_count)
+			__field(bool, res_sync)
+			__field(bool, res_cons)
+			__field(bool, intra)
+		),
+
+		TP_fast_assign(
+			const struct nfs_inode *src_nfsi = NFS_I(src_inode);
+			const struct nfs_inode *dst_nfsi = NFS_I(dst_inode);
+
+			__entry->src_fileid = src_nfsi->fileid;
+			__entry->src_dev = src_inode->i_sb->s_dev;
+			__entry->src_fhandle = nfs_fhandle_hash(args->src_fh);
+			__entry->src_offset = args->src_pos;
+			__entry->dst_fileid = dst_nfsi->fileid;
+			__entry->dst_dev = dst_inode->i_sb->s_dev;
+			__entry->dst_fhandle = nfs_fhandle_hash(args->dst_fh);
+			__entry->dst_offset = args->dst_pos;
+			__entry->len = args->count;
+			__entry->sync = args->sync;
+			__entry->src_stateid_seq =
+				be32_to_cpu(args->src_stateid.seqid);
+			__entry->src_stateid_hash =
+				nfs_stateid_hash(&args->src_stateid);
+			__entry->dst_stateid_seq =
+				be32_to_cpu(args->dst_stateid.seqid);
+			__entry->dst_stateid_hash =
+				nfs_stateid_hash(&args->dst_stateid);
+			__entry->intra = nss ? 0 : 1;
+			if (error) {
+				__entry->error = -error;
+				__entry->res_stateid_seq = 0;
+				__entry->res_stateid_hash = 0;
+				__entry->res_count = 0;
+				__entry->res_sync = 0;
+				__entry->res_cons = 0;
+			} else {
+				__entry->error = 0;
+				__entry->res_stateid_seq =
+					be32_to_cpu(res->write_res.stateid.seqid);
+				__entry->res_stateid_hash =
+					nfs_stateid_hash(&res->write_res.stateid);
+				__entry->res_count = res->write_res.count;
+				__entry->res_sync = res->synchronous;
+				__entry->res_cons = res->consecutive;
+			}
+		),
+
+		TP_printk(
+			"error=%ld (%s) intra=%d src_fileid=%02x:%02x:%llu "
+			"src_fhandle=0x%08x dst_fileid=%02x:%02x:%llu "
+			"dst_fhandle=0x%08x src_stateid=%d:0x%08x "
+			"dst_stateid=%d:0x%08x src_offset=%llu dst_offset=%llu "
+			"len=%llu sync=%d cb_stateid=%d:0x%08x res_sync=%d "
+			"res_cons=%d res_count=%llu",
+			-__entry->error,
+			show_nfs4_status(__entry->error),
+			__entry->intra,
+			MAJOR(__entry->src_dev), MINOR(__entry->src_dev),
+			(unsigned long long)__entry->src_fileid,
+			__entry->src_fhandle,
+			MAJOR(__entry->dst_dev), MINOR(__entry->dst_dev),
+			(unsigned long long)__entry->dst_fileid,
+			__entry->dst_fhandle,
+			__entry->src_stateid_seq, __entry->src_stateid_hash,
+			__entry->dst_stateid_seq, __entry->dst_stateid_hash,
+			__entry->src_offset,
+			__entry->dst_offset,
+			__entry->len,
+			__entry->sync,
+			__entry->res_stateid_seq, __entry->res_stateid_hash,
+			__entry->res_sync,
+			__entry->res_cons,
+			__entry->res_count
+		)
+);
 #endif /* CONFIG_NFS_V4_2 */
 
 #endif /* CONFIG_NFS_V4_1 */
-- 
2.27.0

