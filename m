Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA3343297B
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 00:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhJRWFi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Oct 2021 18:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRWFi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Oct 2021 18:05:38 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2DAC06161C
        for <linux-nfs@vger.kernel.org>; Mon, 18 Oct 2021 15:03:26 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w8so16632869qts.4
        for <linux-nfs@vger.kernel.org>; Mon, 18 Oct 2021 15:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OeqkSPVKL2Pa1TJvnwXeHsBGMcNXWR+t0t6C3TtJ4GE=;
        b=klmOeKS8rQ1Pcx7EqvTn3QN2b4rElTVgqxg3YbM6yRkusL3g5uiazX7v9sLW/n0DhA
         G46TD+JQKc9dWvabycWotXF1UQeUfU04P2sduagVh/e4a6WuagkdVVrzhxi1an0ia7Pu
         PX1iybqCqzB2XK40MbfnDOYaSTB1cP32+gdsL+GDtld23Vvi/i9CzoRJXeHp4qxJDe8+
         b0h3XCotGWOPYoPYdR+IuUd6Zaz6R+IQ4Fn4rCuxHL1WiYR/XcQIuqLCh91bsruPfk5I
         fsaB8wuqPDyvxUS72VSSdtB4oPpmsjnz+k8S83IIh5bG7+lOLcaeQ4T4Bt8R8UlHCIbK
         fu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OeqkSPVKL2Pa1TJvnwXeHsBGMcNXWR+t0t6C3TtJ4GE=;
        b=W4WGfRMH0tUOvcrdMCCS1Gbd6Ipsy9+rul1crcq0zNIt2chg5GNhmjDXOvucaw/7gd
         QLcDVEadoKiidoezY1Ul/i3uDXtwjXVBqzDuqdxVkg/5prXijhRcS+tXppo8vDyv537i
         3RsIcL4LynlAWTsTBsBN1dT9HegIweKezWr0TsSuorfwbrzVQue0TGpfJqh1T8he3WzO
         afbtD+EtetizoPfg6zrSA/llM5fbi42ZMpDXPhyU1L/8QUwmnf1sf0f8VqYjEinEvjdB
         es8wYLd0J8+SmY/ub1r2v5v0rKeVKXk8yW0rTQJf0+2fi3+qaEoaqTRurToioI88jrKl
         gAuw==
X-Gm-Message-State: AOAM533Fu6livfALi8Vkn/gijlJjkzDCa5kVX0Gj80mMWitrOAjij7ua
        QG0/DCavSfjDqSSuosl43DXjZkIb5vF4kA2H
X-Google-Smtp-Source: ABdhPJzj87zdcon3D/kmtNsHH3ZJAO2SEf10h/y6QFyTBQaDGlhFoBYdeANSznxSKimJIh1vlkVXVg==
X-Received: by 2002:a05:622a:204:: with SMTP id b4mr32567394qtx.89.1634594605658;
        Mon, 18 Oct 2021 15:03:25 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:e54f:15fc:f79a:2b96])
        by smtp.gmail.com with ESMTPSA id az14sm3352640qkb.125.2021.10.18.15.03.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 15:03:25 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/7] NFSv4.2 add tracepoint to COPY
Date:   Mon, 18 Oct 2021 18:03:10 -0400
Message-Id: <20211018220314.85115-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
References: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
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
 fs/nfs/nfs4trace.h | 101 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

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
index ba338ee4a82b..4beb59d78ff3 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2540,6 +2540,107 @@ DECLARE_EVENT_CLASS(nfs4_sparse_event,
 DEFINE_NFS4_SPARSE_EVENT(nfs4_fallocate);
 DEFINE_NFS4_SPARSE_EVENT(nfs4_deallocate);
 
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
+			__entry->error = error < 0 ? -error : 0;
+			__entry->src_stateid_seq =
+				be32_to_cpu(args->src_stateid.seqid);
+			__entry->src_stateid_hash =
+				nfs_stateid_hash(&args->src_stateid);
+			__entry->dst_stateid_seq =
+				be32_to_cpu(args->dst_stateid.seqid);
+			__entry->dst_stateid_hash =
+				nfs_stateid_hash(&args->dst_stateid);
+			__entry->res_stateid_seq = error < 0 ? 0 :
+				be32_to_cpu(res->write_res.stateid.seqid);
+			__entry->res_stateid_hash = error < 0 ? 0 :
+				nfs_stateid_hash(&res->write_res.stateid);
+			__entry->res_count = error < 0 ? 0 :
+				res->write_res.count;
+			__entry->res_sync = error < 0 ? 0 :
+				res->synchronous;
+			__entry->res_cons = error < 0 ? 0 :
+				res->consecutive;
+			__entry->intra = nss ? 0 : 1;
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
+			show_nfsv4_errors(__entry->error),
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
+
 #endif /* CONFIG_NFS_V4_1 */
 
 #endif /* _TRACE_NFS4_H */
-- 
2.27.0

