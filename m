Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6477E4455C4
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Nov 2021 15:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhKDO76 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Nov 2021 10:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhKDO74 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Nov 2021 10:59:56 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB9BC061203
        for <linux-nfs@vger.kernel.org>; Thu,  4 Nov 2021 07:57:18 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id j28so6455345ila.1
        for <linux-nfs@vger.kernel.org>; Thu, 04 Nov 2021 07:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LcrfP4jJovoaVITSQqrtRb2Q9mKmVoN3WERKBdDo+UA=;
        b=OmO7/zxX+e1vEEXp4gmRLo/MHh1COWip/K/euMIzYbNRvLakMD/BCuDHp+xz4dHCGs
         MwAtIOD6r+hUIlvKjeefYeRjey7hOJ3d1AYxbSizN+n0I4xaf2CAqKDAFbYpmved/4QP
         qzlh8f3nznefJn+MOsQ8qNbQeO6DMH/1U6FeGfaEnQIocEwxDMZVpWbRqaR3t31eu225
         VCTW/8ZWZtq107rgnhcTTqFiLFJsx6OfJtmd0Dn7QR9FTuKMiipiNLaC46Osx1NvTLqA
         1OieWJAeADDdSQ2qEfTZWQhopJr89YTu+vORC85MOsIR8VGyFZOzjUBJb7uE8Y4m2Mfl
         2sfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LcrfP4jJovoaVITSQqrtRb2Q9mKmVoN3WERKBdDo+UA=;
        b=FY4bqlhzqiJSdsTXIeJnUD5jEHLhxaOQJFpK9d/opV+fR1qI6onVZ8REbEGa+vZpL8
         uegAoRtqV/XA+tbtP74+vkq1CPHFZ0lgXsQCq5lXxyoWUiqa84m3l9Ljz5wfHVV8P+Nm
         zv+WXfLaz8joNJfpiX3lc5sOsyI8VKHwYd0RhW+5c4+cjFCIGJFbjCqDOo/I+D6JJeyC
         LCCcPX9tnR1tCEgsTXFlfKDjSPh804uBfM2U+LgpTV4IIn4BBlAgvtSNPaBnrwS/fCRY
         JC1qrxN+ZJUcE246I2Fn55ewtbzJ4pDmS/ao9OIe0X+Wu/55CEqiSNnCkogjjQO9wJOh
         MNEA==
X-Gm-Message-State: AOAM533INDv130q6W7xIvhOc8CneLkfxoV3j9pAoS2t649oAgRLXNL5y
        iK5gTACfSK5c3ydN5qouZDE=
X-Google-Smtp-Source: ABdhPJzAuqQ+11l9+tk2runW3N4sk0hJlCRy006Eh1AK0afzDmZW03Cgk9WuNmc3jhgV3fAfTy4avQ==
X-Received: by 2002:a92:1e11:: with SMTP id e17mr34830758ile.196.1636037838118;
        Thu, 04 Nov 2021 07:57:18 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:886c:a169:fafb:e7cf])
        by smtp.gmail.com with ESMTPSA id c12sm3007157ils.31.2021.11.04.07.57.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Nov 2021 07:57:17 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        chuck.level@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/7] NFSv4.2 add tracepoint to SEEK
Date:   Thu,  4 Nov 2021 10:57:08 -0400
Message-Id: <20211104145714.57942-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211104145714.57942-1-olga.kornievskaia@gmail.com>
References: <20211104145714.57942-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add a tracepoint to the SEEK operation.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c |  1 +
 fs/nfs/nfs4trace.h | 74 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index a24349512ffe..87c0dcb8823b 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -678,6 +678,7 @@ static loff_t _nfs42_proc_llseek(struct file *filep,
 
 	status = nfs4_call_sync(server->client, server, &msg,
 				&args.seq_args, &res.seq_res, 0);
+	trace_nfs4_llseek(inode, &args, &res, status);
 	if (status == -ENOTSUPP)
 		server->caps &= ~NFS_CAP_SEEK;
 	if (status)
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 18f149f72160..823ac436a1da 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2054,6 +2054,80 @@ TRACE_EVENT(ff_layout_commit_error,
 		)
 );
 
+TRACE_DEFINE_ENUM(NFS4_CONTENT_DATA);
+TRACE_DEFINE_ENUM(NFS4_CONTENT_HOLE);
+
+#define show_llseek_mode(what)			\
+	__print_symbolic(what,			\
+		{ NFS4_CONTENT_DATA, "DATA" },		\
+		{ NFS4_CONTENT_HOLE, "HOLE" })
+
+#ifdef CONFIG_NFS_V4_2
+TRACE_EVENT(nfs4_llseek,
+		TP_PROTO(
+			const struct inode *inode,
+			const struct nfs42_seek_args *args,
+			const struct nfs42_seek_res *res,
+			int error
+		),
+
+		TP_ARGS(inode, args, res, error),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, error)
+			__field(u32, fhandle)
+			__field(u32, fileid)
+			__field(dev_t, dev)
+			__field(int, stateid_seq)
+			__field(u32, stateid_hash)
+			__field(loff_t, offset_s)
+			__field(u32, what)
+			__field(loff_t, offset_r)
+			__field(u32, eof)
+		),
+
+		TP_fast_assign(
+			const struct nfs_inode *nfsi = NFS_I(inode);
+			const struct nfs_fh *fh = args->sa_fh;
+
+			__entry->fileid = nfsi->fileid;
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fhandle = nfs_fhandle_hash(fh);
+			__entry->offset_s = args->sa_offset;
+			__entry->stateid_seq =
+				be32_to_cpu(args->sa_stateid.seqid);
+			__entry->stateid_hash =
+				nfs_stateid_hash(&args->sa_stateid);
+			__entry->what = args->sa_what;
+			if (error) {
+				__entry->error = -error;
+				__entry->offset_r = 0;
+				__entry->eof = 0;
+			} else {
+				__entry->error = 0;
+				__entry->offset_r = res->sr_offset;
+				__entry->eof = res->sr_eof;
+			}
+		),
+
+		TP_printk(
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"stateid=%d:0x%08x offset_s=%llu what=%s "
+			"offset_r=%llu eof=%u",
+			-__entry->error,
+			show_nfs4_status(__entry->error),
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle,
+			__entry->stateid_seq, __entry->stateid_hash,
+			__entry->offset_s,
+			show_llseek_mode(__entry->what),
+			__entry->offset_r,
+			__entry->eof
+		)
+);
+
+#endif /* CONFIG_NFS_V4_2 */
 
 #endif /* CONFIG_NFS_V4_1 */
 
-- 
2.27.0

