Return-Path: <linux-nfs+bounces-1476-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3714F83DDB0
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 16:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A402850E4
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9779E1CFB5;
	Fri, 26 Jan 2024 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="nP6Sa+EF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261021CFB6
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283641; cv=none; b=UEdbiiLtpO+3xmGb3Zfaqf/9X4bjmVMzv8s4qKfpi/WEVvCeEAXt6rkiBODYw9rYeusDKKH8ouzS9OmHukIJXHaEWz6yMhf6/wWFpZ0NhsiyZvjV959Wz4Y3y9PsQdGLxO5pJ4ZKvPBP1BW8h0bTy3mAzmIn5IbxX3owcXA6U9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283641; c=relaxed/simple;
	bh=cfGQYTEcOcYOsimoAP02J8VpT6Q0N1JoH1qCVeYrfgc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRdisF9Suhq2vLo/l1m41MAf++04GEY3WlYbCJLvZr6hgSrn0h1TOmSXjhRNsimEmLC53pJxaL0QfDgT7MzdlWa2hs55cSfPAQ1SdkVKW74L7CITwBuCOJRmRs294SrQ6DWAjIKG80tsIpO+z6LIpiLl6KoAniTa6CRFdz+i3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=nP6Sa+EF; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5ff9adbf216so3808377b3.1
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 07:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706283639; x=1706888439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2MAcHvDL6/f4i0aRHxTU11GRORw8UkogLnsw3Sqy1e0=;
        b=nP6Sa+EFSy/y0lGIoJ+2f3FIbdCdgNNFjD7abj4iwpB0vRozvdGF34/A+fksVzUL7y
         0yDDd3dVUiF/V9rNGx2K1U9h53PDQetMSfx1qMzSQ1JX8tLrZ14dS5+N1uiTdl14bOOX
         cbTj2kgw4TxsC/EA9gIhEuWUL0KEP2tvI8rmPOedQYqDtl/HTH98wUrUFA5nPo9yJYWM
         evQR3pHva+rtMqL/EpAar2V37FGfCS8aE24Rv6BDHzNno8Bjpx3tOoPUWwYPTY83EpiQ
         Q/Cx75ndtU+hxhwnBR/l0bbYyHa2VsTul0p/8ZE/LlfRPmbZjVb6avmgiwe0NoLzGyQi
         nNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283639; x=1706888439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MAcHvDL6/f4i0aRHxTU11GRORw8UkogLnsw3Sqy1e0=;
        b=rqREnZi2M9TMyBx1mRNEho8kCsbpppV3dWZ+yuidzNJjNp1+lvR3Nt6lkPaUl5X5Po
         zy9D4T1MULe/VxKoFWjcPqBAi5wvsgBIfLO1B9nItFAEEWQ4YOrRqxa49ztRFkkV+jz4
         izU1PdFvESE6hs7YzPLijqLls0MZ0kbr3iwvKfkSNdEurqc2roNmUnM+2hlzthY6rrkX
         OWzq/XTdXFPD5xeoJVpx/SVpIO28F0m6jkTMiftWN6ohFPIF8UIQ7If23CfNvye/GMny
         lNmC0Wg9Ox6iF9NDKqACB2xhBiDvjH2Hzq5DUOSrvuiLbsOpXOKDRSFyOvOsQ55zmOUY
         /pig==
X-Gm-Message-State: AOJu0YwNIOIBOSbUcbVU8DbriCYTXmbFG5vyoOUm2FjlGm/TGJWhC24u
	TwKv9ct7JZYsX7ITMXQcKVFlp6KaKrBAjARpB26onkBN1k5rTXZFQsJv0+0s7r0=
X-Google-Smtp-Source: AGHT+IEtfy72XnvA8FLZ1Sb9ZCo/XHsOL9e4mz3IMTkEI4U8Javag2z7c87kGYfzNLsLJDgHTaUtAQ==
X-Received: by 2002:a81:8d0a:0:b0:5ff:d4c1:48f9 with SMTP id d10-20020a818d0a000000b005ffd4c148f9mr1711826ywg.0.1706283639128;
        Fri, 26 Jan 2024 07:40:39 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id cp29-20020a05690c0e1d00b005ff9dac3ff0sm449925ywb.56.2024.01.26.07.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:40:36 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 04/10] sunrpc: remove ->pg_stats from svc_program
Date: Fri, 26 Jan 2024 10:39:43 -0500
Message-ID: <50a46da5d8ad5f9fc055864c17f90d6b14f4147d.1706283433.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706283433.git.josef@toxicpanda.com>
References: <cover.1706283433.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that this isn't used anywhere, remove it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfsd/nfssvc.c           | 1 -
 include/linux/sunrpc/svc.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index d640f893021a..d98a6abad990 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -127,7 +127,6 @@ struct svc_program		nfsd_program = {
 	.pg_vers		= nfsd_version,		/* version table */
 	.pg_name		= "nfsd",		/* program name */
 	.pg_class		= "nfsd",		/* authentication class */
-	.pg_stats		= &nfsd_svcstats,	/* version table */
 	.pg_authenticate	= &svc_set_client,	/* export authentication */
 	.pg_init_request	= nfsd_init_request,
 	.pg_rpcbind_set		= nfsd_rpcbind_set,
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index c8ba4f62264b..cb5950fe1435 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -339,7 +339,6 @@ struct svc_program {
 	const struct svc_version **pg_vers;	/* version array */
 	char *			pg_name;	/* service name */
 	char *			pg_class;	/* class name: services sharing authentication */
-	struct svc_stat *	pg_stats;	/* rpc statistics */
 	enum svc_auth_status	(*pg_authenticate)(struct svc_rqst *rqstp);
 	__be32			(*pg_init_request)(struct svc_rqst *,
 						   const struct svc_program *,
-- 
2.43.0


