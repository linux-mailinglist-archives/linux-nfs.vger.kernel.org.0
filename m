Return-Path: <linux-nfs+bounces-7193-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 117A69A08A1
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 13:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08AEA1C2118E
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34495204F9E;
	Wed, 16 Oct 2024 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIzDdrDd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1A7206059
	for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 11:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079302; cv=none; b=Er29FIdSaTT3mrgavILnpdQGs3kJCcuAElbjAz2FT+n4CDXvp4N6ITzpD4HoXNjiiWhO/NRgfwZqdbtsN0T6xboX/YNamb6xtyGrLndEqDr+OpAem38p6jPpj8P8k2Bhu2R+NRXRYN/ywcUBKYWpjS3OS2+07kLDbL7p7IAbsrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079302; c=relaxed/simple;
	bh=qbvn7cMfkO2c4uTl7WuppgSTQF4OowjoHeHTqoTItGA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=NF3LW3iItVlVlwbULfIOC2gthe0PARbN+p0Ama+MGPbnqLS1UjQz7GQw7YRjH5eNwzWJeAYrZlU0l2s3w4fz5zWUG2ZtyDfLgbjW/K6vmK2ZxNXMD3HSgYg7jajKuMY9zVqxR/BFhiy+F2zLKnB9JApJ3A/tf66h6OKWyCKcu8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIzDdrDd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4311d972e3eso40458705e9.3
        for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 04:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729079299; x=1729684099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSNgr1NTdLrTqc2CXS2Ctb0rZHZP76JOVZbaS2bCQSQ=;
        b=lIzDdrDd5Ue4W6WdyU8p+DfpcZtcdvJLmG6RfxCqrjiS11XsMW/wiwrm8Abz6E8k8S
         rj5Sr+HnpOuHVmNe5L9xcSMtLips6f96Evz/8bWLLWTLc4WLtKDUyKBfctKJgQ67zGCL
         SC4HZM6l/8jn3EwX3XGFQ3H8oWAFqwtGE0iEqoSANe/hM3vdkkVfdkptncUZCA0nPz2j
         YVpjbp3J4Smq+smFxAkxYbBeNeKVWBtL43ZphHgaQratXeGSE7L3hypT6rcbhM5x/sEh
         /W1Dw8+g9BUxsv3k6KdcEuko+uPEkFuIONyD2mLQVKaZk9NmbIkbsVVT+k5dKpZc+LN8
         YDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729079299; x=1729684099;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uSNgr1NTdLrTqc2CXS2Ctb0rZHZP76JOVZbaS2bCQSQ=;
        b=qAE37cZrx4cLwnpPq3mYBJEOjGl874BVac3RjWTFRM2URR4n3vlGhA/BHaC7GneSVP
         eiDZ0FRhvqogIxbGPanSwrA8SSiECmJT9xnpCz9jGjhEdsu6hn7OOfIKGGKp7BJ8XAE8
         DmKVi8VZ50RDPYQo+q+BqyF+K/CHBKeoMDzIsmWfsJoVjWWpZq3GuaoByUqlDw7PNHWT
         7Esg+eHvHPQ4Q+0IzjBiVaOOltyCnkcUfctqTGgCbOlES3UtwF7ibUJ0DndD9SXDDYNF
         HR2frD6SxI2YJ9TgVXKlSAk/UGYKI+KcszCmSNxMKinF+NSY97p6xhwsUbAlnxX9tVWD
         psDg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Y378aSQHb5Ij9K5Dj5VSRHnNG8UKV4DprXAMx6qREdtDu7RjL+fJ72Xfl+hi0mjKlnAzdBT9KhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXYTBsYD8Sdhu6tBmOU8iM800FwBI7NKGaPJ+TevoRWh671mj9
	CwEzPvhIHBdaqOwwd+QVpSa4dIg5U1uGUxh+XczZf9HVuF4B6qsY
X-Google-Smtp-Source: AGHT+IH0Ufz61rrGsLzM2DBMnTNPuqutjmEPLL4DJoExm6xXpRlKzUNk39EePHSw2ktrkqKuAjbDYQ==
X-Received: by 2002:a05:600c:190f:b0:430:53f8:38bc with SMTP id 5b1f17b1804b1-431255dcb76mr115860775e9.12.1729079298559;
        Wed, 16 Oct 2024 04:48:18 -0700 (PDT)
Received: from [0.0.0.0] ([95.179.233.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc445fesm4109430f8f.113.2024.10.16.04.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 04:48:18 -0700 (PDT)
Message-ID: <f48015df-9b1b-43f4-82a1-a47664a7c994@gmail.com>
Date: Wed, 16 Oct 2024 19:48:14 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-US
To: Trond Myklebust <trondmy@hammerspace.com>,
 Chuck Lever <chuck.lever@oracle.com>
From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [RFC PATCH 1/5] SUNRPC: reserve space before encode gid
Cc: kinglongmee@gmail.com, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reserve space must be done before gid encoding.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 net/sunrpc/auth_unix.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/auth_unix.c b/net/sunrpc/auth_unix.c
index 1e091d3fa607..9ef3025682bf 100644
--- a/net/sunrpc/auth_unix.c
+++ b/net/sunrpc/auth_unix.c
@@ -113,7 +113,7 @@ unx_marshal(struct rpc_task *task, struct xdr_stream *xdr)
 	struct rpc_clnt	*clnt = task->tk_client;
 	struct rpc_cred	*cred = task->tk_rqstp->rq_cred;
 	__be32		*p, *cred_len, *gidarr_len;
-	int		i;
+	int		i, ngroups;
 	struct group_info *gi = cred->cr_cred->group_info;
 	struct user_namespace *userns = clnt->cl_cred ?
 		clnt->cl_cred->user_ns : &init_user_ns;
@@ -136,14 +136,17 @@ unx_marshal(struct rpc_task *task, struct xdr_stream *xdr)
 	*p++ = cpu_to_be32(from_kgid_munged(userns, cred->cr_cred->fsgid));
 
 	gidarr_len = p++;
-	if (gi)
-		for (i = 0; i < UNX_NGROUPS && i < gi->ngroups; i++)
+	if (gi && gi->ngroups) {
+		ngroups = min(UNX_NGROUPS, gi->ngroups);
+		p = xdr_reserve_space(xdr, ngroups * sizeof(*p));
+		if (!p)
+			goto marshal_failed;
+		for (i = 0; i < ngroups; i++)
 			*p++ = cpu_to_be32(from_kgid_munged(userns, gi->gid[i]));
+	}
+
 	*gidarr_len = cpu_to_be32(p - gidarr_len - 1);
 	*cred_len = cpu_to_be32((p - cred_len - 1) << 2);
-	p = xdr_reserve_space(xdr, (p - gidarr_len - 1) << 2);
-	if (!p)
-		goto marshal_failed;
 
 	/* Verifier */
 
-- 
2.47.0


