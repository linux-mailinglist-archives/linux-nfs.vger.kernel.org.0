Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F076B43297C
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 00:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhJRWFk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Oct 2021 18:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRWFj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Oct 2021 18:05:39 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEC1C06161C
        for <linux-nfs@vger.kernel.org>; Mon, 18 Oct 2021 15:03:27 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id i1so16622403qtr.6
        for <linux-nfs@vger.kernel.org>; Mon, 18 Oct 2021 15:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9vx7h7NPDb6cNSja6T8imttLb+0tH+B3APuPoqor3iE=;
        b=nNOhsJciAYROwEcTGLW4lOzeiIenwBZshk6jwhOzNPpits8gsQmyBUi14ovSnsCrSe
         EbHpa990IgdqLfUB7pRVoCd7B9EvBjL83YzkItoa3Ca758puqwMDQMSMyizZ+xE4ck43
         Y5nbPEWexb/mqUrM2UVv74XMwhF5BC/FUKfja7Y/+gI5hm7wiWZWY1YIXEW4aIoI/RPO
         NUofY7v5Vrcg5Ux4gr8PIvaKSja6bHbzV4KCveIoxJ3+HVT/wrfyMFcGpiREOqzYCUgE
         Zg8nY9nJUMf10h75jDO5Lm5yHn2jICTy8wow3dJ8wiqFsxHiRf/gPAco0LVdsz0xDlmH
         wWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9vx7h7NPDb6cNSja6T8imttLb+0tH+B3APuPoqor3iE=;
        b=EUs4BpkPfq0OzRxdPReTmBfrXDJHKqKYxjO0++hAUmj4Szy3igLdcXHIMko6Fb9tFA
         uISSC66yHbFlDwaK2FwRd4n/xhKzV/9nghs5wrKMUkdcMeJv0PmvS/7oqLJZCMWqM5VJ
         pnZzcD3v6Dk1GRjkBMiDNx2UI3uNX1+jZKKEst3vaWiriismpuB6137Xr7VeVXGScuFF
         CwjeJY3iaVY2VwZdJIS/L7HPh5Y8eVKvka1rJKnKm5KT0tt/os9rRX796FbAJdukyoSN
         Q4otAMLM8PhH6jDwB+mS9hgjCf3CDl1+78FkOuYK7pI1ky4HPf5ZgkbEEQoReXAAFLcO
         Hg0w==
X-Gm-Message-State: AOAM532FmQqaOCpu7uFnyfL3UCksYSVeoDBSWnzah9BzAPzNT8SjgWyW
        ZjZ7doSccFc1DskBS2QVr4h0tIaNjJWhjCVD
X-Google-Smtp-Source: ABdhPJzlwXtLPv47IHFBAH23NUOmlKliS5aajZ88ZY3aadQWgrXBPj1Wxx1yY8cn/YmtE758pHPpPw==
X-Received: by 2002:a05:622a:1014:: with SMTP id d20mr33567092qte.152.1634594606748;
        Mon, 18 Oct 2021 15:03:26 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:e54f:15fc:f79a:2b96])
        by smtp.gmail.com with ESMTPSA id az14sm3352640qkb.125.2021.10.18.15.03.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 15:03:26 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/7] NFSv4.2 add tracepoint to CLONE
Date:   Mon, 18 Oct 2021 18:03:11 -0400
Message-Id: <20211018220314.85115-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
References: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add a tracepoint to the CLONE operation.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c |  1 +
 fs/nfs/nfs4trace.h | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index a072cdaf7bdc..d3d9ea71702f 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1077,6 +1077,7 @@ static int _nfs42_proc_clone(struct rpc_message *msg, struct file *src_f,
 
 	status = nfs4_call_sync(server->client, server, msg,
 				&args.seq_args, &res.seq_res, 0);
+	trace_nfs4_clone(src_inode, dst_inode, &args, status);
 	if (status == 0) {
 		nfs42_copy_dest_done(dst_inode, dst_offset, count);
 		status = nfs_post_op_update_inode(dst_inode, res.dst_fattr);
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 4beb59d78ff3..cc6537a20ebe 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2641,6 +2641,79 @@ TRACE_EVENT(nfs4_copy,
 		)
 );
 
+TRACE_EVENT(nfs4_clone,
+		TP_PROTO(
+			const struct inode *src_inode,
+			const struct inode *dst_inode,
+			const struct nfs42_clone_args *args,
+			int error
+		),
+
+		TP_ARGS(src_inode, dst_inode, args, error),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, error)
+			__field(u32, src_fhandle)
+			__field(u32, src_fileid)
+			__field(u32, dst_fhandle)
+			__field(u32, dst_fileid)
+			__field(dev_t, src_dev)
+			__field(dev_t, dst_dev)
+			__field(loff_t, src_offset)
+			__field(loff_t, dst_offset)
+			__field(int, src_stateid_seq)
+			__field(u32, src_stateid_hash)
+			__field(int, dst_stateid_seq)
+			__field(u32, dst_stateid_hash)
+			__field(loff_t, len)
+		),
+
+		TP_fast_assign(
+			const struct nfs_inode *src_nfsi = NFS_I(src_inode);
+			const struct nfs_inode *dst_nfsi = NFS_I(dst_inode);
+
+			__entry->src_fileid = src_nfsi->fileid;
+			__entry->src_dev = src_inode->i_sb->s_dev;
+			__entry->src_fhandle = nfs_fhandle_hash(args->src_fh);
+			__entry->src_offset = args->src_offset;
+			__entry->dst_fileid = dst_nfsi->fileid;
+			__entry->dst_dev = dst_inode->i_sb->s_dev;
+			__entry->dst_fhandle = nfs_fhandle_hash(args->dst_fh);
+			__entry->dst_offset = args->dst_offset;
+			__entry->len = args->count;
+			__entry->error = error < 0 ? -error : 0;
+			__entry->src_stateid_seq =
+				be32_to_cpu(args->src_stateid.seqid);
+			__entry->src_stateid_hash =
+				nfs_stateid_hash(&args->src_stateid);
+			__entry->dst_stateid_seq =
+				be32_to_cpu(args->dst_stateid.seqid);
+			__entry->dst_stateid_hash =
+				nfs_stateid_hash(&args->dst_stateid);
+		),
+
+		TP_printk(
+			"error=%ld (%s) src_fileid=%02x:%02x:%llu "
+			"src_fhandle=0x%08x dst_fileid=%02x:%02x:%llu "
+			"dst_fhandle=0x%08x src_stateid=%d:0x%08x "
+			"dst_stateid=%d:0x%08x src_offset=%llu "
+			"dst_offset=%llu len=%llu",
+			-__entry->error,
+			show_nfsv4_errors(__entry->error),
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
+			__entry->len
+		)
+);
+
 #endif /* CONFIG_NFS_V4_1 */
 
 #endif /* _TRACE_NFS4_H */
-- 
2.27.0

