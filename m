Return-Path: <linux-nfs+bounces-3736-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FF3906347
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 07:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0E81F2355E
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 05:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613EA132105;
	Thu, 13 Jun 2024 05:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPmrd0QC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC83913665A
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 05:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718255231; cv=none; b=g+ewEc8HDyK6bZ9UY1jBY0TjwyD52foS+y/4tVdhCuQ32iFxeKz7TW3IWha3fgzZ+9j8Aq5NO4fNj3hXuzNKfhdROJrXBKV8ouo8KsX5oAKwrRAaZI8sAfc8jcwb8HuJQ99WJ9P+bfpn62UDh0UUFSq/bLzqUpP/GQbqP+fN2S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718255231; c=relaxed/simple;
	bh=1EIiKsj88/HIuhpKyPwdj6LpSobgwewSKk2VrkXHeMY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPzxviGrbkjzP/+W2PK0rtovMWaVgHcs3IhMmznOcY42hNocwy5JGVSjcc9pbBnhuPAhX3f0s1JqFdc23BpdPIIl/jxhgVx/ZaLZKE1Id5SMNln/SJbUgvemsMCB9LMXLjN78ia34uBuFZnfttvKsb2akPs8moUyuCz0yXuv0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPmrd0QC; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6afbf9c9bc0so3632606d6.3
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 22:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718255229; x=1718860029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMuo2SFpnJUwQ5H78MYK/+ITRASzfZD05ziEoGSxRnc=;
        b=hPmrd0QC8cEnm/SzYmdV5kaVeSbpVWtEFQCL2OhJHGonNakmtj8Pt7PiXO7v+hY5ZJ
         UdDnEqHemwysPkMxodh6gPEZIpegElOY2PT4VtLFZHrVB6UR0dCtnRxnFOnGjH0ESGws
         D88Z0s7yKGqDjP/3lM0l6TX6K3gyNvb5WWGggnZRvdk0JfHxkkPvReWm7G6Bo/xqbIdB
         D+z/3ePH6Kt/7lqsGNNtWr4H2fdMUuQRnfIB7BN+Lau2Ub3+fD4RARaVGvnO4LqUEiTE
         iaNHsNDnUIyfZQAueQEwdy2/CZfw+976x2fEjlRNuP/X1bvIp92QkRmZVfJenuXC5p7i
         ihxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718255229; x=1718860029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMuo2SFpnJUwQ5H78MYK/+ITRASzfZD05ziEoGSxRnc=;
        b=lp+FlpEBS/MOf07fXNqOhpzbVeAKUCpeqKiK9rxM+Wix171huHTiJDlTjJYJ8N5+4a
         Ziqz/ACIz5XxNsKkWRi5IKuwPrCLJLI6jLaA4mZoxwJNZK1NEhoeNYwiqXrI2+zdTHKg
         wTfqS4J446PFzAsy8iSOCivZAqYsGbnGjlGZMp0jCpC34GSE2Mf/a2bOg/p87ySecl/K
         Zdbjh5pG74hWIUWuK8cbiTe2h9CG4dDEStv6wos433AL1RpUxM6KSXUPHyX/of/b3qBi
         SZwvldJO/IoZb/P/0+I+BAVdt5GcFu9GqpVCXuYd5A9tOOUqLQYFdkBvXykrmob3++Re
         iV9g==
X-Gm-Message-State: AOJu0YzVdeHwHOwSvIx9slIZILylShQUiuR8dOdp1Z1LgXysiFOitq8y
	UPPa82NSzfxZTH3H7HHZijhr2AobZ0m0sq1CjtRwrt37Cy0BI6U/aT6F
X-Google-Smtp-Source: AGHT+IHsE97LGR1k9rkhfopXcYoGmDOqq/47xLIm+YbcWPv52/28rrnJoCAIRUwnKdJ4SqKjBUa8/A==
X-Received: by 2002:a05:6214:4a08:b0:6b0:6a26:9083 with SMTP id 6a1803df08f44-6b1a7225bc8mr47603236d6.40.1718255228557;
        Wed, 12 Jun 2024 22:07:08 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ed4527sm3079036d6.101.2024.06.12.22.07.07
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 22:07:08 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 07/11] NFSv4/pNFS: Handle server reboots in pnfs_poc_release()
Date: Thu, 13 Jun 2024 01:00:51 -0400
Message-ID: <20240613050055.854323-8-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613050055.854323-7-trond.myklebust@hammerspace.com>
References: <20240613050055.854323-1-trond.myklebust@hammerspace.com>
 <20240613050055.854323-2-trond.myklebust@hammerspace.com>
 <20240613050055.854323-3-trond.myklebust@hammerspace.com>
 <20240613050055.854323-4-trond.myklebust@hammerspace.com>
 <20240613050055.854323-5-trond.myklebust@hammerspace.com>
 <20240613050055.854323-6-trond.myklebust@hammerspace.com>
 <20240613050055.854323-7-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the server reboots, then handle it by deferring the layout return.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index a79ae47b3842..c8b1be1810e2 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1586,8 +1586,7 @@ int pnfs_roc_done(struct rpc_task *task, struct nfs4_layoutreturn_args **argpp,
 }
 
 void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
-		struct nfs4_layoutreturn_res *res,
-		int ret)
+		      struct nfs4_layoutreturn_res *res, int ret)
 {
 	struct pnfs_layout_hdr *lo = args->layout;
 	struct inode *inode = args->inode;
@@ -1595,6 +1594,9 @@ void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
 	struct nfs4_xdr_opaque_data *ld_private = args->ld_private;
 
 	switch (ret) {
+	case -NFS4ERR_BADSESSION:
+	case -NFS4ERR_DEADSESSION:
+	case -NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
 	case -NFS4ERR_NOMATCHING_LAYOUT:
 		spin_lock(&inode->i_lock);
 		pnfs_layoutreturn_retry_later_locked(lo, &args->stateid,
-- 
2.45.2


