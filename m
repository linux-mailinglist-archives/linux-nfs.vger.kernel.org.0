Return-Path: <linux-nfs+bounces-1484-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D050E83DDDE
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 16:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EEC288826
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4806A1D6A4;
	Fri, 26 Jan 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="d6GDwO1K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75181D697
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283858; cv=none; b=sYJTuJ61ikdVIWilBgppeR9LzvTmAKS3blxfiyaAbgoc54D8bCjNBNGlRJWujxd2Pl+0Ox8H7hfhksmIxvAjtVpofMml8GMHyilC0xJSo1B9cFG9KPUAx+NXDBrEfp0b5QzVidY9marNnPvhLbNIFkhov9jMKf7qu1KrT570VkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283858; c=relaxed/simple;
	bh=BqIK57GIa16QrlYmc+J5NJ1hTtuWen/iHq9iXCjlXxo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qreHeBBOG2ZPWAnNwMbPvUyBBb2G09eMN6D69GzWPYJ6wSWQAsqpCDeIfokoCRzMWHCPHlkgce6n3faMXMgYRAPPRaVHMQQLYOQeGJbDRoEJsunYlFul6KSwhy5ex8CT3XOLA3kUAGgYDeWAWYrkQATDl2oQLrUtk2+NFZ9Tk2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=d6GDwO1K; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-602d222c078so4528067b3.0
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 07:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706283856; x=1706888656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hyRY1P1IhywJGt2LJ0HW1TDW87f//AJSkNUh4WBQJY=;
        b=d6GDwO1KJOEYnqL3DhJcokMi6yXgZ4l3ANSKO7BlMfOtB4HabSdcVoMkFwuTuExMSX
         5znOE9cjBWafyltX4gcmvjFFe9Oouu91IrahTeaisEEW0SlJTmFu+pnZ85OWWaxDfYxW
         JO5NtvO56xSv2/xkaGnB9c+GOCWjplW/+cJIZFuyqkIQhAW0yUo6DEu5Y0K1UG93+kqJ
         hPPJMzMIcTW+Y3eaI1wKM0t/q8XI43upjqRAX7LJh0rM3XNrHgtBKwsVl2NRNd5dvxnv
         Aa1aRD7P/usIsQtKmzIoFi8SsMgW9Yev7m5b0rQ7XU00zOJU9AFHg/hK55BxutUwl5bN
         TpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283856; x=1706888656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hyRY1P1IhywJGt2LJ0HW1TDW87f//AJSkNUh4WBQJY=;
        b=In9QF/v68vbfYSKn/Rt2e87s0Xqhwm3rgMtwaoaK4IdwhVcWocfItSe1mJj+LA/WGE
         vyhtIBkEbOwsU9UsS0WyTp7gN4kDwuGdK/HHdvgsdc+fAD28ZeEpBex837tV0GSfEnB0
         CUnZKT9/0gHnrn64zz8rldWYxl+glfPe0hnm0Rc+tdem2KcDDgZXheaRs5Y5MufOzmnY
         598zjqDVkqPWSiu8xOi6SbF1fUVXCad36I+R8f4E11q+vGq7Mo4onDd6t2/bb+jMlDga
         oXMU6zAwm99tX47RNVfvTVloLFnu+4ANCoO8Uwj5dWUuk4BPLuqI1HyDijJbh2jvU5c7
         NfgQ==
X-Gm-Message-State: AOJu0YyON3ypJ26xnodxOEgaL4rD93kZM9SevLYwO2ULmXN0lAkoqT3Y
	g4rDcTdM4Zr7zrPw6MbqySQy7pcPVhddmbjzlKhMX5O97ebDtXvATgSXNHDecNo=
X-Google-Smtp-Source: AGHT+IHe2zLokdpOqBmyX4cV5tUQjt1yTM7GfBO9zSryWlhbV0fE3I3tYPso/2fLLtlpWRBMeJ/8Fg==
X-Received: by 2002:a0d:df51:0:b0:602:d398:517b with SMTP id i78-20020a0ddf51000000b00602d398517bmr466866ywe.2.1706283855890;
        Fri, 26 Jan 2024 07:44:15 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id hd10-20020a05690c488a00b005ff88cbbc93sm163355ywb.111.2024.01.26.07.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:44:13 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/3] sunrpc: add a struct rpc_stats arg to rpc_create_args
Date: Fri, 26 Jan 2024 10:43:32 -0500
Message-ID: <da4f379b1877f04072412829397f1fd57e680a44.1706283674.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706283674.git.josef@toxicpanda.com>
References: <cover.1706283674.git.josef@toxicpanda.com>
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


