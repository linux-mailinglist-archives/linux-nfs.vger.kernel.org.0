Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3013D4455C7
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Nov 2021 15:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhKDPAD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Nov 2021 11:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhKDPAD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Nov 2021 11:00:03 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54635C061714
        for <linux-nfs@vger.kernel.org>; Thu,  4 Nov 2021 07:57:25 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id s14so6433558ilv.10
        for <linux-nfs@vger.kernel.org>; Thu, 04 Nov 2021 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pwZZda3fnrEzoQoUgBAuIW6Jl+466RRYUR0Wt7GVS+4=;
        b=VEQ4OAw6D2cMWl+GUbRlcla3lZfp2KwPZ5AO+UFMWt2OlSoWSo0OTqBmwOyuXXHOK6
         GSSBugv6JnzkpP2RMlGSGsKOBPVTZE4x41wXq2NrAmDsH3BJOSaB0pNfHQg46Z0ojVxZ
         33VulTdhgqyuxF5XREo0sDzYRLwDno87vlve2skmTcdlbC5YEDvF+o3rZHdBTYttKSEX
         ZqS155UPNKUoy5e5xMYQtHxqY/jqHkye6LoSQlzPCohOf1QQYCg5k4fYC4QBlaQnqPC2
         X0cci+NGM1QXUROe7NMi2lKlmZneeTqmxukCCc86OZyCx+ymvWUGoXt7FHR/4sl7Dth3
         gOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pwZZda3fnrEzoQoUgBAuIW6Jl+466RRYUR0Wt7GVS+4=;
        b=KKjWPrY70gRGyPtar9iRAIGvZtlcZWW6O89wVVbHWvi9KNX3Dn6Grrcr0nmDvBlSKD
         +uWHTudD1xz75iL1cV+C+bOV9UG4rKNoobvoRTdRU9WAsnfcCG3JZ5+gKX6M8GxkF7HS
         aQ56sWfRz4aY3dq4MQK5ute/nnw6LegjjxW2qPOuHXr27enSQY9XUlhRoYWFhz+rQG+P
         b0s81tlpkmsMAWE7sonYuTtVqlOLQgbXeYsat1zZVM1ZeASM6mJH3edD5SDsUKbtPM5O
         nRw9TIgwAWJ0oF3KSJ/p5ylgb9U01tyTswZ/2w4h8cU72tTgu/iBaZfUUP2e2R/TPIWr
         e6Xw==
X-Gm-Message-State: AOAM533yDBEhPMMXVXZ+MlU9xDlIWQL6gRP/3GbyTQE2gH32OISzk/P8
        6Gdtn+s4gcd9LTjZmguWNko=
X-Google-Smtp-Source: ABdhPJx3C73o8wKIumsMvFSgh/4hQDVQves7l1JIG1S4Ezd0q70GjTRTMxzVAG2rWinpS4c50G2w7Q==
X-Received: by 2002:a92:d341:: with SMTP id a1mr28772510ilh.59.1636037844813;
        Thu, 04 Nov 2021 07:57:24 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:886c:a169:fafb:e7cf])
        by smtp.gmail.com with ESMTPSA id c12sm3007157ils.31.2021.11.04.07.57.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Nov 2021 07:57:24 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        chuck.level@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/7] NFSv4.2 add tracepoint to CLONE
Date:   Thu,  4 Nov 2021 10:57:11 -0400
Message-Id: <20211104145714.57942-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211104145714.57942-1-olga.kornievskaia@gmail.com>
References: <20211104145714.57942-1-olga.kornievskaia@gmail.com>
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
index bdccaec504d8..af7e59aa9265 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2290,6 +2290,79 @@ TRACE_EVENT(nfs4_copy,
 			__entry->res_count
 		)
 );
+
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
+			show_nfs4_status(__entry->error),
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
 #endif /* CONFIG_NFS_V4_2 */
 
 #endif /* CONFIG_NFS_V4_1 */
-- 
2.27.0

