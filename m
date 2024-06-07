Return-Path: <linux-nfs+bounces-3599-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EBC90068C
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80112B28F85
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267581991D2;
	Fri,  7 Jun 2024 14:27:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE124196DA7
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770432; cv=none; b=FZk1kc3o5bRRgeAXRX0bZxNrs2stpi6Iw85TSCfI6TZPXsEbe/80uc0wjVOqnnPXygk6Hw5xk9dSpyjEfimbYpBCUKlroa82BfLDmtkIDEcjJ3YIyj9/MXQAyP+0p0eCR2zD36pM75jFHrQv6fw9YHIhlhf+jNZ952d0qY4BJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770432; c=relaxed/simple;
	bh=4CmKlsX0grbPftATwEorynbm1ti+vOQnjoYOI8s3g2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJdkx902DjRKaEzXrDU02k0YOGxg7WM8HlgjDsX9qC+/Qy02UrltNYEtL4+0PAP6S4HdZEL0M1Vr822qNkzh2+T5b5hWKsZyqJSV6lUnbF0dPRSre0mieH/YWn+BkFH+hW+PGk9XdpVHon7QkICyWHt4Nl3BxqZB9SZCKm+arVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f95be3d4c4so261846a34.3
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770429; x=1718375229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hp1mOTFo7NjTD4NvtGmhOAOHOVqghMCE1ClzSjK2tAY=;
        b=gSZRlHId55E+TP4ZCKnmSNZLcIFhaWzULb/ykdow7J92YjzQannahUkqUEY7hj4B+h
         KR3BicKjTyUI03CK+YWRB3CZIGmGWLnPED1WCahueqPvklmGbbUCT9SoAOiNr/sRid3x
         X//ckiBJuhfVcx7ZCnEaRWlv4g2JVUgRhlFWiX4E1bmKXXsAyP4HsCBer+8nhnHtHjp7
         9noKAGbMfB44Nlt0v7h2UU6T1uN8BB6npEFrxMpkJucdYojcYht6k/dwsIjfwDj2y3kP
         ggauF1Z8o2KbAwGaRNuy2ALmm85V4f0tXH+8XV9v5gbXcmtoxPbtb5g6IRVunl2+R/3E
         C5Eg==
X-Gm-Message-State: AOJu0Yxs63g6z7GqosKiaLMVP5IxuTDlqp2wCyCGuMsaeKXRoPu0Haug
	4dXfEDxC82nRYGQBo2C35Jd7JH2fzvyQykh3oY0sapFFQS7bLQN4UoQB8Ig7iFRKNbaSHfvA3F1
	nRMarnA==
X-Google-Smtp-Source: AGHT+IGvvnNmKIyQqYX4ltOi1YkvkOZrsSGiFJnuC8DQTcnqFLDn7nj7fvVrNGxlvjWCjORffI55cw==
X-Received: by 2002:a05:6830:14d4:b0:6f0:e7da:6637 with SMTP id 46e09a7af769-6f9572fbb04mr2655936a34.31.1717770429580;
        Fri, 07 Jun 2024 07:27:09 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79532813a2dsm171665485a.20.2024.06.07.07.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:09 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 14/29] NFS: Add tracepoints for nfs_local_enable and nfs_local_disable
Date: Fri,  7 Jun 2024 10:26:31 -0400
Message-ID: <20240607142646.20924-15-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607142646.20924-1-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Allow tracing of when local I/O begins and ends.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c  |  5 ++---
 fs/nfs/nfstrace.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 5c69eb0fe7b6..5939ca2216be 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -195,7 +195,6 @@ nfs_local_put_lookup_ctx(void)
 		spin_unlock(&ctx->lock);
 		if (fn)
 			symbol_put(nfsd_open_local_fh);
-		dprintk("destroy lookup context\n");
 	}
 }
 
@@ -206,8 +205,8 @@ void
 nfs_local_enable(struct nfs_client *clp)
 {
 	if (nfs_local_get_lookup_ctx()) {
-		dprintk("enabled local i/o\n");
 		set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
+		trace_nfs_local_enable(clp);
 	}
 }
 EXPORT_SYMBOL_GPL(nfs_local_enable);
@@ -219,7 +218,7 @@ void
 nfs_local_disable(struct nfs_client *clp)
 {
 	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
-		dprintk("disabled local i/o\n");
+		trace_nfs_local_disable(clp);
 		nfs_local_put_lookup_ctx();
 	}
 }
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 45d4086cdeb1..95a2c19a9172 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1710,6 +1710,38 @@ TRACE_EVENT(nfs_local_open_fh,
 		)
 );
 
+DECLARE_EVENT_CLASS(nfs_local_client_event,
+		TP_PROTO(
+			const struct nfs_client *clp
+		),
+
+		TP_ARGS(clp),
+
+		TP_STRUCT__entry(
+			__field(unsigned int, protocol)
+			__string(server, clp->cl_hostname)
+		),
+
+		TP_fast_assign(
+			__entry->protocol = clp->rpc_ops->version;
+			__assign_str(server);
+		),
+
+		TP_printk(
+			"server=%s NFSv%u", __get_str(server), __entry->protocol
+		)
+);
+
+#define DEFINE_NFS_LOCAL_CLIENT_EVENT(name) \
+	DEFINE_EVENT(nfs_local_client_event, name, \
+			TP_PROTO( \
+				const struct nfs_client *clp \
+			), \
+			TP_ARGS(clp))
+
+DEFINE_NFS_LOCAL_CLIENT_EVENT(nfs_local_enable);
+DEFINE_NFS_LOCAL_CLIENT_EVENT(nfs_local_disable);
+
 DECLARE_EVENT_CLASS(nfs_xdr_event,
 		TP_PROTO(
 			const struct xdr_stream *xdr,
-- 
2.44.0


