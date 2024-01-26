Return-Path: <linux-nfs+bounces-1510-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A19F83E43E
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 22:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FEB9B21158
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 21:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0E52869B;
	Fri, 26 Jan 2024 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="B3nvaNg9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B7B286A2
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305761; cv=none; b=btwC7NTAW+Tu67qQjM6a/xgkrRi5aq1071radotEWQV9TiBLqq2pMuLiloaKPScAT0rm2KnzIxmBLNRGomDheu4gFuRUZiRF8+OCE3VEvAjAYopfoKMdibB++6ggm6zwdtHPtYDKRIw8sNMNKT4IhXlunXqq+8U0dg7e+f8J4CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305761; c=relaxed/simple;
	bh=m6usMMU4SsCAiMNYKoY60eWob9Gg+hDffEWVP5OlIVY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpM9/0mn4FvhmQa44uIaVpsnNfOuXLmB+O5whAiMiLbraHtV3Cu74BLP3r+FSjvyuhX1uC+xGm3Uqz1lhCyoypdoEKqqWJs0rxLzcBv8GFL+0ihgOMgeVIEKp6NxFSOnLF+rOqFkRHMbmHwF9/8z0Qh+Ly7xcKfcI1vMW1HhYvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=B3nvaNg9; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-602c714bdbeso6929617b3.1
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 13:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706305759; x=1706910559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDg1b+F23rzIo+igDPGNcCIFA/5NGxHBaWGHP7JzJvk=;
        b=B3nvaNg9Ost3vqfEaEFa7TKGW1AkAlMNYWIi9xhVFaPKHwyinnLl5Hy3qM+955EhI+
         MQ9SgjjqdlibhgD+rRftUc1rxO2fGbg/CXBk4PvWFTXpGetrr1N5InHhWG18guu8cL4N
         7GdoMYkkzXzuIlXqPnBEaZDjPfa8xr22aoDs+dgtre8z9oBK1LDGHcADfUlEHpLJx0cb
         WpUlQ9lB41TF0HDRGs6bKj+QGLcRBLhX/jmZKXyo7ZSpaMCQRxGZuICmgUaWbTq2lrUk
         ddOjJJo7V3PipmI48OxrQxJ2TkdcdHOoCXD4OTa6wWWuqk87PokBK2zyr44UFbfnEgl3
         ScrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706305759; x=1706910559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDg1b+F23rzIo+igDPGNcCIFA/5NGxHBaWGHP7JzJvk=;
        b=NTthUu3XNtnSUv53cFbW+st+PmQ4909zMtdQhZgm2CxPR2mi7Ev+vYt8o21YGZ/tFn
         apHhVAWe9hQyZ9WNjXweM22hXQiIXVdrD0i98H57Vh3KTHM1KNI/bs2+O4uMfKGbjBLM
         D9X8jchXYGcMmgCEwPN5ZDOqojoFGYQEYnXwlraM9NqHp85CkbPRzD2l4pl+XYGUqqc5
         ptvNYwRbdGCXGDeiTUxr9xzj84TFtyEKehGSy2J/lKeO0IJL/0LrmRI8cCjsPDvV0wF5
         KhBL/0SgZgm5laYM6rfWO6r2uTwDoNJR/KCCXN+AgJDGT6wZfG5MIUTEbWryxf+vgMse
         93Ow==
X-Gm-Message-State: AOJu0Yy+0eyiCm1GmOxFDOF89T2UkW6jmSR+TEfeTryNhe0RHa2s5yOQ
	cnRDQZyknTuGLwrtZjrvpz4FleVntyCmA89D9aAf4KPnQydmHVqjLO8ER0lxNiw=
X-Google-Smtp-Source: AGHT+IGFBcPIwY+K6IQ9VOBnuU0jYAlok8zHfQlulzI2Urw3aa7gjojE9X5MZupuBFJkS5KTT7IVnw==
X-Received: by 2002:a81:9955:0:b0:5ff:83b9:c7bc with SMTP id q82-20020a819955000000b005ff83b9c7bcmr1189481ywg.29.1706305758809;
        Fri, 26 Jan 2024 13:49:18 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i74-20020a816d4d000000b005ff9deadf0fsm655593ywc.94.2024.01.26.13.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 13:49:18 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 1/3] sunrpc: add a struct rpc_stats arg to rpc_create_args
Date: Fri, 26 Jan 2024 16:49:00 -0500
Message-ID: <6ffd8bf0366610573bdc786871feca78817b3234.1706305686.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706305686.git.josef@toxicpanda.com>
References: <cover.1706305686.git.josef@toxicpanda.com>
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
 net/sunrpc/clnt.c           | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

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


