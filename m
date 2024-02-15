Return-Path: <linux-nfs+bounces-1971-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7C8856E36
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 21:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C79FB26FAB
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 20:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D560213AA29;
	Thu, 15 Feb 2024 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="FmIraQSP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127ED13A892
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027065; cv=none; b=PWXNgJVTagtVF15frDCcsPqZbNCnIuzs5tSfKkUI82PkKbbKqblzHv4EBfAVIUlFk1N3wfzauyqRPJBBXginRXpS6Z6YgW+bsM33+HiyJo2TjojvXav/b7JAdCD63ZQTY0ObF9Udexz63M/vOj28nq2h8tfkNLL61GxUheDw5D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027065; c=relaxed/simple;
	bh=/BG2joKruibPBzczgBI4YKClFnmxq9ARTjeFZrlK4p4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pv35rOrf7ascX13XMj4GtYbmYxq4eTrl003vMxxjibqBbN9/b+Kdy9pKwK+LvEvAUhU+tNh8966GdCNLWPDKScVflX9s7OvvUGILAXjKDCBpdzo9BsWlzEcm9abTpVdhXshpMo541XhOtkj1dp0MEvNRDhwfsSXXh0Qg+ehphXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=FmIraQSP; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so1310367276.2
        for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 11:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1708027063; x=1708631863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtC6yc5Kmgw9GmQ2/1irwG8BWnRopJmQdaxwEYN2g+w=;
        b=FmIraQSPP9bHanIQAO3IJM9C8ulg3ZeC0hrWM453nQBbiQDf6JA5BEYSmcVnVZwF4e
         4uwG5L3uMBg7Y6sQsy2Wq5qOYfMA13/4GMXUtQ23cOSL4Av0SES81sl7+z/XTkdlsvuD
         OVnXx4PEkocJKSL7Gr8wIA0t96ZLHPMDMzT4xhzuMUra7FQhoki4IbTsAdQWSMC0iFmK
         r0P89lt77EcOPbYxzQH4h8q73bTcYFtEKN3gDP2QVSIzHjxdHWECYphyMqwyLarsFAVm
         PsH/m31vOthw+LS1why69Tq1oq7WtNXZsM0swdR41vvSxwacz6Jdq0W9FlIes0nBD+yR
         D+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708027063; x=1708631863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtC6yc5Kmgw9GmQ2/1irwG8BWnRopJmQdaxwEYN2g+w=;
        b=GWCwPkG4Yo2p8PF26N//gM41SWZQB2ZDX2CY8ilnReZr5T09rE5D90z6vYF+Y1qhzu
         b4pSb2oswONvGmN41N6mUJwmaHdrM+vgmYCJzG3oCvMYcWdS83NU2eXgvIOwkjB6VKdY
         BkUlIBb3fqgz3T1bWDsChlXrFBDiR9Cyh9NGCEGAfAa0VwAOyYW7k6zRSpjE3iCsMck1
         xBh+6J2MxtL4WGvM+cJOZIW/ukTG67nbv2cmG/P9cs0vYIqSnljza6f704LrYcfAiyae
         5bVczm5ag73g1oR6uBqBRQG6u7TC7whf2roPdedtFCcjbsBYfb2MWn8io4wmD13r/X67
         YcOw==
X-Forwarded-Encrypted: i=1; AJvYcCU6qeXr40nH8Y928DvnkYz1burtSWqcHlBHWuEcDDmz5/mBvccoBrLchy2mz7NHmS/Ltqbhyh0+lfVWhvG5EfQcq6ECD4CRGeJC
X-Gm-Message-State: AOJu0YyFPwNdRLbZOz65kTNhu4JRNpeSr+qz9Qba431Val8JqYFzm8XD
	T85VEuqSyHN4N7Cn0oPDczzxvR4niEaq4xLECba19y0Q41ZRGdm8MoyWbU4hwK42h3MqB8njmq0
	3
X-Google-Smtp-Source: AGHT+IFBNyJeejZh5kRYYjLYNtRvwdXIo+Z/aatlYNHYwaWYqzL3qbbi15q4EU0u6mutdL0bBdhOiA==
X-Received: by 2002:a25:ce92:0:b0:dcc:323e:e1a4 with SMTP id x140-20020a25ce92000000b00dcc323ee1a4mr3054080ybe.6.1708027063079;
        Thu, 15 Feb 2024 11:57:43 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x83-20020a253156000000b00dc727104273sm18887ybx.34.2024.02.15.11.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 11:57:42 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 1/3] sunrpc: add a struct rpc_stats arg to rpc_create_args
Date: Thu, 15 Feb 2024 14:57:30 -0500
Message-ID: <bbeafb16b3822975e63c751280630d1f8c12b63e.1708026931.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708026931.git.josef@toxicpanda.com>
References: <cover.1708026931.git.josef@toxicpanda.com>
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
 include/linux/sunrpc/clnt.h | 1 +
 net/sunrpc/clnt.c           | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

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
index cda0935a68c9..28f3749f6dc6 100644
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
@@ -691,6 +691,7 @@ struct rpc_clnt *rpc_clone_client(struct rpc_clnt *clnt)
 		.version	= clnt->cl_vers,
 		.authflavor	= clnt->cl_auth->au_flavor,
 		.cred		= clnt->cl_cred,
+		.stats		= clnt->cl_stats,
 	};
 	return __rpc_clone_client(&args, clnt);
 }
@@ -713,6 +714,7 @@ rpc_clone_client_set_auth(struct rpc_clnt *clnt, rpc_authflavor_t flavor)
 		.version	= clnt->cl_vers,
 		.authflavor	= flavor,
 		.cred		= clnt->cl_cred,
+		.stats		= clnt->cl_stats,
 	};
 	return __rpc_clone_client(&args, clnt);
 }
@@ -1068,6 +1070,7 @@ struct rpc_clnt *rpc_bind_new_program(struct rpc_clnt *old,
 		.version	= vers,
 		.authflavor	= old->cl_auth->au_flavor,
 		.cred		= old->cl_cred,
+		.stats		= old->cl_stats,
 	};
 	struct rpc_clnt *clnt;
 	int err;
-- 
2.43.0


