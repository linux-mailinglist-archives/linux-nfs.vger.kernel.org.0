Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7064443297E
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 00:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhJRWFm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Oct 2021 18:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbhJRWFl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Oct 2021 18:05:41 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC48C06161C
        for <linux-nfs@vger.kernel.org>; Mon, 18 Oct 2021 15:03:29 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id b12so16646921qtq.3
        for <linux-nfs@vger.kernel.org>; Mon, 18 Oct 2021 15:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/jnForQvzDFnZb2d3tK1EegceeQkkvIbZQo5846/nxQ=;
        b=eSr72Ccbl617PzjB5CyUXgMepMii2Cn1qH4Hjp8I7dGfSdm9RfTX5gW6KmYGyzcuhP
         BwHMN/lrEnPlnurf8z3TeqEfJXV/qMDD4UoZSRum9ygCLsk5jGlNHz7iu9lTAPJtz83Z
         MsOv8GFC0xEtonTutqfp2I8d56V1yLfowxcMo1RbYEQwtXrWTMGVMZAJIinKocMjcRLY
         g9/1jilE+Xu1DrqDhaI/FUsv6kZ1OHMRGTshdl3mZ/OuPVtEVu50DO8bvBZrIuBqa33j
         lHsD5B5g3Tw+n+f6pPEHst5HwxJRaUfjOGnj++CoZvUeG9cQGNLCGw4b8KyueRWwEwaY
         TJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/jnForQvzDFnZb2d3tK1EegceeQkkvIbZQo5846/nxQ=;
        b=5QGR/+alTKoVY9RaPVeOBXvnaxXJ71YE2WIM98C0B70kcwn0BLrbpSiGpTSGDmoKsy
         jI9xR0gZ2Usfu4R+rLERfe3V0NP3FiaV9QzVNiBT32SiGYay1fPbV5qlCx+OrzHzRUDa
         ApIr8Cp4mZn4A5+6QWAYs7EplpdMIhAdYnFoJ4YJUvfGl31dr6Cm+AB+o0qaN3mrUggf
         p45PFWQ9qcp/0kAloOdOzQdBpTDKbQC6fCQL/HLfPkJ+fqQVgEb4yPzFpOosTmBhcjF8
         bypDGKmKGBFe9Lqk1LOXZFF12JrvbkAepO+MqgOwx4zmP7E3K7Nl4UwYEFUBRakgJT1F
         JN2g==
X-Gm-Message-State: AOAM530vZ4ZumU77RDts8c73tkGs2TkrDlH6xsLmF6ejB+rzOSLuoOyL
        CC2yA4pFCN8DKKN3z1fsrnfG203Sy9Vw8y7A
X-Google-Smtp-Source: ABdhPJzoLLSjHYvSswCambXOBGMPkoijzKC7Ilxx51r9azpV3wBDxIJarBStu9q9OU4dMQVJkLKcCg==
X-Received: by 2002:ac8:1e95:: with SMTP id c21mr33150058qtm.412.1634594608849;
        Mon, 18 Oct 2021 15:03:28 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:e54f:15fc:f79a:2b96])
        by smtp.gmail.com with ESMTPSA id az14sm3352640qkb.125.2021.10.18.15.03.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 15:03:28 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 6/7] NFSv4.2 add tracepoint to COPY_NOTIFY
Date:   Mon, 18 Oct 2021 18:03:13 -0400
Message-Id: <20211018220314.85115-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
References: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add a tracepoint to COPY_NOTIFY operation.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c |  1 +
 fs/nfs/nfs4trace.h | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index d3d9ea71702f..7c7399b10050 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -603,6 +603,7 @@ static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
 
 	status = nfs4_call_sync(src_server->client, src_server, &msg,
 				&args->cna_seq_args, &res->cnr_seq_res, 0);
+	trace_nfs4_copy_notify(file_inode(src), args, res, status);
 	if (status == -ENOTSUPP)
 		src_server->caps &= ~NFS_CAP_COPY_NOTIFY;
 
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 33f52d486528..2741e12746b2 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2764,6 +2764,56 @@ TRACE_EVENT(nfs4_cb_offload,
 		)
 );
 
+TRACE_EVENT(nfs4_copy_notify,
+		TP_PROTO(
+			const struct inode *inode,
+			const struct nfs42_copy_notify_args *args,
+			const struct nfs42_copy_notify_res *res,
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
+			__field(int, res_stateid_seq)
+			__field(u32, res_stateid_hash)
+		),
+
+		TP_fast_assign(
+			const struct nfs_inode *nfsi = NFS_I(inode);
+
+			__entry->fileid = nfsi->fileid;
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fhandle = nfs_fhandle_hash(args->cna_src_fh);
+			__entry->error = error < 0 ? -error : 0;
+			__entry->stateid_seq =
+				be32_to_cpu(args->cna_src_stateid.seqid);
+			__entry->stateid_hash =
+				nfs_stateid_hash(&args->cna_src_stateid);
+			__entry->res_stateid_seq = error < 0 ? 0 :
+				be32_to_cpu(res->cnr_stateid.seqid);
+			__entry->res_stateid_hash = error < 0 ? 0 :
+				nfs_stateid_hash(&res->cnr_stateid);
+		),
+
+		TP_printk(
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"stateid=%d:0x%08x res_stateid=%d:0x%08x",
+			-__entry->error,
+			show_nfsv4_errors(__entry->error),
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle,
+			__entry->stateid_seq, __entry->stateid_hash,
+			__entry->res_stateid_seq, __entry->res_stateid_hash
+		)
+);
 #endif /* CONFIG_NFS_V4_1 */
 
 #endif /* _TRACE_NFS4_H */
-- 
2.27.0

