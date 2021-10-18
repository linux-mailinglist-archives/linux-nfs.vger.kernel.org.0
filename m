Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735A743297A
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 00:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhJRWFh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Oct 2021 18:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRWFh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Oct 2021 18:05:37 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734E7C06161C
        for <linux-nfs@vger.kernel.org>; Mon, 18 Oct 2021 15:03:25 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id w2so16683966qtn.0
        for <linux-nfs@vger.kernel.org>; Mon, 18 Oct 2021 15:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cogJl55oH07jqSg9ApgLWtmllTmSQaA7OXtfg1PRhgk=;
        b=mlrayVnA0rWKrEDsmBWsfyxitNHuv0o+y1Z076dv1a7GX71j2b+9Tkp4LtOqmYmSe/
         ALLQo/HLRtpI/UwGh9c0lV7rpbgezZDwRqdFzSQ4IDWx7um6/DMSwa3uki/rdh12TEzR
         mAh/oO4n+xBbZT1S7gMCU53cTYzFpcMX+466VmoBAs3SuSgW1cZWkIy7HlPaWdLChqfY
         2u4gc7/HYMQX3TvhSotxIHntyPm7skWHvFsh4JKUA09Xwa1SiCZYGeXs7uiid7cn7Q4N
         62FUAT21BW5Tltkcwmf/GHLLZ0DO44DRaCW+6OETp3xkFsKk76SkRGVsPob9YVvWbasZ
         GDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cogJl55oH07jqSg9ApgLWtmllTmSQaA7OXtfg1PRhgk=;
        b=U7Z7X/RGAXA3/tnezPuSbYxfwV3O3OAkGf5ruFyGo1u8T1o4DqsfZ0RVhQkoBXrQLj
         e8i72MNPqFxl6PJJC/sZ0GNSMGQPQGZlBomwnxZUOWowxEdrMffEm8nnlvBxY/fHpIha
         4X3Q3Ubz7oPe8nZOEWifs7kNioMfkrBIB86P1UAWUHBE6nCE6S13f9kp9hwIBPY6e0bz
         CLQcJR752keMHJcxhaYb8Sq8RN3EbySAb5mOYFDTgxRhjbtuLqR3FYlNS9JrQo9wN9un
         ydu+2NsSQY9kF0bwqTTFBWNM+T+pYGZMbLUXLRYIlfQybe14AJJXP2niquu2xY1nEdwm
         1TvQ==
X-Gm-Message-State: AOAM531RExtYJn8yIelVOkbcMy4t3Vb5JVbnYAsMzm5IbYwhR5ah4QZA
        pmERNwTCrW2D85QRrtO2KoU=
X-Google-Smtp-Source: ABdhPJyMHcyiiecOUTSgtRkCPcA40RmYcOnetoKSbQzJlRHr5FjlGkJYhc+2UIKf0N8Tr5uWUdzeVQ==
X-Received: by 2002:ac8:4b57:: with SMTP id e23mr31714070qts.328.1634594604627;
        Mon, 18 Oct 2021 15:03:24 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:e54f:15fc:f79a:2b96])
        by smtp.gmail.com with ESMTPSA id az14sm3352640qkb.125.2021.10.18.15.03.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 15:03:24 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/7] NFSv4.2 add tracepoints to FALLOCATE and DEALLOCATE
Date:   Mon, 18 Oct 2021 18:03:09 -0400
Message-Id: <20211018220314.85115-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
References: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add a tracepoint to the FALLOCATE/DEALLOCATE operations.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c |  4 ++++
 fs/nfs/nfs4trace.h | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 87c0dcb8823b..c36824888601 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -83,6 +83,10 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 		status = nfs_post_op_update_inode_force_wcc(inode,
 							    res.falloc_fattr);
 
+	if (msg->rpc_proc == &nfs4_procedures[NFSPROC4_CLNT_ALLOCATE])
+		trace_nfs4_fallocate(inode, &args, status);
+	else
+		trace_nfs4_deallocate(inode, &args, status);
 	kfree(res.falloc_fattr);
 	return status;
 }
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 81dcbfca7f74..ba338ee4a82b 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2483,6 +2483,63 @@ TRACE_EVENT(nfs4_llseek,
 		)
 );
 
+DECLARE_EVENT_CLASS(nfs4_sparse_event,
+		TP_PROTO(
+			const struct inode *inode,
+			const struct nfs42_falloc_args *args,
+			int error
+		),
+
+		TP_ARGS(inode, args, error),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, error)
+			__field(loff_t, offset)
+			__field(loff_t, len)
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(int, stateid_seq)
+			__field(u32, stateid_hash)
+		),
+
+		TP_fast_assign(
+			__entry->error = error < 0 ? -error : 0;
+			__entry->offset = args->falloc_offset;
+			__entry->len = args->falloc_length;
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = NFS_FILEID(inode);
+			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
+			__entry->stateid_seq =
+				be32_to_cpu(args->falloc_stateid.seqid);
+			__entry->stateid_hash =
+				nfs_stateid_hash(&args->falloc_stateid);
+		),
+
+		TP_printk(
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"stateid=%d:0x%08x offset=%llu len=%llu",
+			-__entry->error,
+			show_nfsv4_errors(__entry->error),
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle,
+			__entry->stateid_seq, __entry->stateid_hash,
+			(long long)__entry->offset,
+			(long long)__entry->len
+		)
+);
+#define DEFINE_NFS4_SPARSE_EVENT(name) \
+	DEFINE_EVENT(nfs4_sparse_event, name, \
+			TP_PROTO( \
+				const struct inode *inode, \
+				const struct nfs42_falloc_args *args, \
+				int error \
+			), \
+			TP_ARGS(inode, args, error))
+DEFINE_NFS4_SPARSE_EVENT(nfs4_fallocate);
+DEFINE_NFS4_SPARSE_EVENT(nfs4_deallocate);
+
 #endif /* CONFIG_NFS_V4_1 */
 
 #endif /* _TRACE_NFS4_H */
-- 
2.27.0

