Return-Path: <linux-nfs+bounces-1415-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBFE83CCE4
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C2A1F22C7B
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 19:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3511E1353F3;
	Thu, 25 Jan 2024 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ps+26CUh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEBF1339B2
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212424; cv=none; b=BL7ULf263rSHVu0i2LCs9G+UaErYzR+ut2Ff8nomsFHDswTh3NZN0dbSUFs8Oa388QJcq7VsVyfOWiAoAQzYgqeF0x9dP1m3gYBqHzdkCY3PM+kuFxE/57mZTmwngPkyJMdwlp7TsC4Sn1fRwpQ6fP0C7SuvQH8PdPrzeAwcDds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212424; c=relaxed/simple;
	bh=BqIK57GIa16QrlYmc+J5NJ1hTtuWen/iHq9iXCjlXxo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ba8xHD0PpAZXyaku6ser00EzCxDWAo/ZIqEx4EfdMQ5Wo0oFEJrnSd6N9iK++mDYnPMfr92Mmy5ZkX9FK2GucV6xL4mZIssKd+cZkXAOi4JBfqqbwRwzNppIpxSUxrw81bMsBM5tTsByfE5z0aarjtAeRaGY1aCfqocAyJ62bck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ps+26CUh; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5ebca94cf74so70549787b3.0
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 11:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706212421; x=1706817221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hyRY1P1IhywJGt2LJ0HW1TDW87f//AJSkNUh4WBQJY=;
        b=ps+26CUhbq7h7xmWmeZZ9LAFcXpH/Z/PG8LDKTpSPiMtorn5d56PcBiAqn1lifm1UH
         871wtBdAR3fj6SOMmxzMdS5JLcAglfeXLoZwAkq06A7P0ECQn0ygRAO7wROTIs2urKkM
         kKJYtbv3LdjFmTwYw+ak0sStsrXzGjoJPy0/f1H3BF1lza25rne+VRaLlNHIbehA35w/
         2leXPz/rYoDwXKuomiUN0XxeB59FeIWcs12A7l+tD2FEnEvKOi9eZjH0uCJhDLje3Env
         kynBLsQKcXt0tOLNIMA73GeFrGFxg0TstelLGdpno6g/ErSh/4tF2O37YOvKC69juR1k
         1j0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212421; x=1706817221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hyRY1P1IhywJGt2LJ0HW1TDW87f//AJSkNUh4WBQJY=;
        b=TvorplCpPSW5Ystm0wXZkjD9LwV1zRrN2DAVwgo+snp7/5Y3+1AmMgRVJXgOBoxiYP
         zTjJb5o79S+pokuaqr3JypFBoHzGsd/7iG+PWz7kc+fyqowFsN+OCB0RnVB8I/yr5cxn
         n97dwBu54VDh0jut0Nj4db39Y7i6XVDP8ISA4oAKuG9XXgwpRsEsDBF54WjEHqe8QxEg
         httYWTBq+WBoNnrUoi58yaKM4+roiOii0su9X+spn4E1T/84cJpfNvMeZPkwTp5ghMzA
         +Jc96AyXooLd6WV5NDpdqR1O5bD/dRO4UQPNAdfbydo8j530S1osq4dFIsbsMX6qAGyt
         mn/w==
X-Gm-Message-State: AOJu0YzEkAmHr/4uR7mq3hnQr/960Fntzvl15WBAMrGF2AduegGGQi6p
	LeiuRn3UeBNIfz6Ee0ai12oGBw6PnY46Civ34AtIHWXTAMm8iwAzN3qRaxVe/LXUJeVCzMxz565
	J
X-Google-Smtp-Source: AGHT+IGBnQ0x0mrcLh2JXW/5Ki/ILvyU19xKrXt/MKngkasuffJ5umzDyZupu6h+Nf6GN4dhtjk2oA==
X-Received: by 2002:a0d:dd0c:0:b0:5ff:913b:1d56 with SMTP id g12-20020a0ddd0c000000b005ff913b1d56mr348276ywe.6.1706212421422;
        Thu, 25 Jan 2024 11:53:41 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d13-20020a0ddb0d000000b005f900790763sm874900ywe.49.2024.01.25.11.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:53:41 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 05/13] sunrpc: add a struct rpc_stats arg to rpc_create_args
Date: Thu, 25 Jan 2024 14:53:15 -0500
Message-ID: <4cc2a7aca55ff56ac3ced32aafa861f57f59db02.1706212208.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706212207.git.josef@toxicpanda.com>
References: <cover.1706212207.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to be able to have our rpc stats handled in a per network
namespace manner, so add an option to rpc_create_args to specify a
different rpc_stats struct instead of using the one on the rpc_program.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfs/client.c             | 2 +-
 include/linux/sunrpc/clnt.h | 1 +
 net/sunrpc/clnt.c           | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 44eca51b2808..590be14f182f 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -73,7 +73,7 @@ const struct rpc_program nfs_program = {
 	.number			= NFS_PROGRAM,
 	.nrvers			= ARRAY_SIZE(nfs_version),
 	.version		= nfs_version,
-	.stats			= &nfs_rpcstat,
+	.stats                  = &nfs_rpcstat,
 	.pipe_dir_name		= NFS_PIPE_DIRNAME,
 };
 
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 5e9d1469c6fa..5321585c778f 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -139,6 +139,7 @@ struct rpc_create_args {
 	const char		*servername;
 	const char		*nodename;
 	const struct rpc_program *program;
+	struct rpc_stat		*stats;
 	u32			prognumber;	/* overrides program->number */
 	u32			version;
 	rpc_authflavor_t	authflavor;
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index cda0935a68c9..bc8c209fc0c7 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -405,7 +405,7 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
 	clnt->cl_maxproc  = version->nrprocs;
 	clnt->cl_prog     = args->prognumber ? : program->number;
 	clnt->cl_vers     = version->number;
-	clnt->cl_stats    = program->stats;
+	clnt->cl_stats    = args->stats ? : program->stats;
 	clnt->cl_metrics  = rpc_alloc_iostats(clnt);
 	rpc_init_pipe_dir_head(&clnt->cl_pipedir_objects);
 	err = -ENOMEM;
-- 
2.43.0


