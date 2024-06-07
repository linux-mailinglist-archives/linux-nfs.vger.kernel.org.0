Return-Path: <linux-nfs+bounces-3594-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 356A9900681
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493241C22AF0
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51820196D87;
	Fri,  7 Jun 2024 14:27:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E2C194A7D
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770425; cv=none; b=DK2kl0fI0Tq46lnNKaMK22pURpdzMPMi9gpWYJE033g5Kb1QrNbenhnwMEmtKJlrIBiBglTHi95Zqy41i4/rtq3uysK+1YwQ2Ew38pdD5ZQ+LteQgBn7cBMBWDADetNAGPPnIqh7RONS93CrOE4WRs1uOMfBjko/HFztpjZEJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770425; c=relaxed/simple;
	bh=3yeXpgjflLNWr7DJcLC+Bll0/2QlKYVwAP82MUzpMk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjnIk/c+8eliUFzVucrTuRjph1+XrL4KrSfV6BljrupRthb/Lmjtf8B83SL9bXt70GGSMbB7ODalpWSdkAyz9wtYMkrFYJmWyjEZ8GinVJDDToKJoMrRFhjdLJsKYMoo5IqMZkKGwaXfepl6Wx2cwjuSO/KsanyVGVR8t7bFJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-df4d5d0b8d0so2145008276.2
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770422; x=1718375222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jj1QH7sw/Kw1P84SGIZlEFUNbm1ML7/DtljafjAq3Og=;
        b=sjetYUYPWb1zcgJdYpLQgxLqnD5Gq8yioJKSUN7+gsX4d3cHaAKtcWRRnqoSLOgCoS
         4OKl0aZ9IWzTw9jc/9VAeGoJoV3FArV8udpvu9034J+iTBTZWPqWHUh4QfToAcwWEzyD
         hszvSLp6/36UdUthNUjYBG2ZdZAQrWRvMx9xj61Lk38kF23BjeZ5GnNd0GbvqjxWN17X
         lgy3PLZSHKiw7NYborptghFKmvgsFm+apw0xC0iL8Hn+H5AQEHyok5wh9ItKrxy3HjCZ
         hfHvTRHtbJLdjC0IINjk/JvsdXNyeAcvzqXoicOnEvNU6vZBDLeeSjpXX3cGyMNO0Tar
         csOA==
X-Gm-Message-State: AOJu0YyV3863F2Ne2GMNZhqKQvb1wXNcf0u6vsTLBlyUwL+CtllqtKNh
	SLgCM+ukKx4E8Pafen3O3in+vKKMjuVDu0d3zg+iePV5xggQHoWkTaz4mr+GhcmI/ry1yT85/kf
	LYa3C+A==
X-Google-Smtp-Source: AGHT+IGL9PPQTXWqtYM072iTD2t34YzLHz7Z1YubXPL+Aut6N55x0VGcyecIuGXoQlNVH7TFJnfSeA==
X-Received: by 2002:a05:6902:a92:b0:dfb:30e:25b5 with SMTP id 3f1490d57ef6-dfb030e2ef8mr1522324276.25.1717770422152;
        Fri, 07 Jun 2024 07:27:02 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4404a8ee860sm3937491cf.94.2024.06.07.07.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:01 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 09/29] NFS: Manage boot verifier correctly in the case of localio
Date: Fri,  7 Jun 2024 10:26:26 -0400
Message-ID: <20240607142646.20924-10-snitzer@kernel.org>
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

If there is a localio error, we want to manage the boot verifier in
a similar fashion to how it is done on the server.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/client.c           | 3 +++
 include/linux/nfs_fs_sb.h | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index de77848ae654..dd3278dcfca8 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -178,6 +178,9 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_max_connect = cl_init->max_connect ? cl_init->max_connect : 1;
 	clp->cl_net = get_net(cl_init->net);
 
+	seqlock_init(&clp->cl_boot_lock);
+	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
+
 	clp->cl_principal = "*";
 	clp->cl_xprtsec = cl_init->xprtsec;
 	return clp;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 92de074e63b9..82a6f66fe1d0 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -125,6 +125,10 @@ struct nfs_client {
 	struct net		*cl_net;
 	struct list_head	pending_cb_stateids;
 	struct rcu_head		rcu;
+
+	/* localio */
+	struct timespec64	cl_nfssvc_boot;
+	seqlock_t		cl_boot_lock;
 };
 
 /*
-- 
2.44.0


