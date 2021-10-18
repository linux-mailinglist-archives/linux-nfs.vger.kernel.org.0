Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB1D432979
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 00:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhJRWFg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Oct 2021 18:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRWFf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Oct 2021 18:05:35 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4318EC06161C
        for <linux-nfs@vger.kernel.org>; Mon, 18 Oct 2021 15:03:24 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id z24so16597794qtv.9
        for <linux-nfs@vger.kernel.org>; Mon, 18 Oct 2021 15:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nVoS5w1IrXH+haMLOz031DTVO/ebBe9DItCLtnwvfWM=;
        b=B1ccfEeOe9hKmmZFHvA+nslOGPbsBz5Kuf1eAYJWIm16vrx0SwXjETPOpzw3aza0Bh
         otKtQThseGU0ABwbctFb06JPHtn6S06CZTfQG0fmbfA03IuLCdgRxOkgypDY3Qrg9rhJ
         cR8w2ghBWdE+qORpV9Wi/QWtwxW+B04dUIUzzPQmIn2Qx3agw1xZ5Ug3VCcIkKT2dfAB
         vPwOjbSVdaPh189f1daPw2XsN3fJfoH0vqte6UcnrTjuJE9dZfc61LVKMg15xW4Enbdo
         490m2N2ljk0JXm1FVGrBcrYyAseYq7dkmb2MvgyQozm/1QLXD9//jJ0lpf16HlJkdcdu
         BCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nVoS5w1IrXH+haMLOz031DTVO/ebBe9DItCLtnwvfWM=;
        b=V3X8bIyWrUqze+nPQdq8KGlUTWXnmKSQTwTanDft9zU58JRlPzDGAWykSH8avAZZ4u
         5dGhAKG6ghjtrXq1DB7h6x1V+gfmuz14dD3UJ2nfySkg4XAcT7foZdysUtBe+UHFi4+m
         yZIMukqVDhi7h1K39vJh7T/OPF9533UHYKmHf3KOK0B4iFVKTv/HPwIBYqE73Ce5JkV9
         f1ZEBF3oHV1MRz1qzH4QwObY04A0JKVYqjUDc+Enqg8lm96YX1AYhGd+xs21ZEaCmbQU
         GnJ2g7XCp2ppA6PBg0ref03nv0iQnjMd6TbAoXQXjqrd0jRFB6XQNFRTBLf2BpNlXYep
         JoYw==
X-Gm-Message-State: AOAM531vbP4TnyQzZuQNOh6WErKY7J3ZJM5kf/Pj8b2asn/4S0qp3uyY
        WPjkTQxHVG1Rl8OnVC7+Pyk=
X-Google-Smtp-Source: ABdhPJxE7pNCwfxDwVYkBUZDehkFfp1avyeo8Pjkl9ysSjnT/eLGFCsdpfzUuJHNmeZzjdcc+alCFw==
X-Received: by 2002:a05:622a:1301:: with SMTP id v1mr31947195qtk.233.1634594603425;
        Mon, 18 Oct 2021 15:03:23 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:e54f:15fc:f79a:2b96])
        by smtp.gmail.com with ESMTPSA id az14sm3352640qkb.125.2021.10.18.15.03.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 15:03:23 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/7] NFSv4.2 add tracepoint to SEEK
Date:   Mon, 18 Oct 2021 18:03:08 -0400
Message-Id: <20211018220314.85115-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
References: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
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
 fs/nfs/nfs4trace.h | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

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
index 7a2567aa2b86..81dcbfca7f74 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2417,6 +2417,71 @@ TRACE_EVENT(ff_layout_commit_error,
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
+			__entry->error = error < 0 ? -error : 0;
+			__entry->stateid_seq =
+				be32_to_cpu(args->sa_stateid.seqid);
+			__entry->stateid_hash =
+				nfs_stateid_hash(&args->sa_stateid);
+			__entry->what = args->sa_what;
+			__entry->offset_r = error < 0 ? 0 : res->sr_offset;
+			__entry->eof = error < 0 ? 0 : res->sr_eof;
+		),
+
+		TP_printk(
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"stateid=%d:0x%08x offset_s=%llu what=%s "
+			"offset_r=%llu eof=%u",
+			-__entry->error,
+			show_nfsv4_errors(__entry->error),
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
 
 #endif /* CONFIG_NFS_V4_1 */
 
-- 
2.27.0

