Return-Path: <linux-nfs+bounces-1414-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FE783CCE3
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E416C1F22DAE
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 19:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D67135A66;
	Thu, 25 Jan 2024 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="aCTIuBOI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD9813541E
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212423; cv=none; b=YuBQBw8clF7XI+oA0t4K5mEMGEXXzOhkhl43Up6C158W7vvpWV5i4Vgj0thBSyBC4OYtHGPZ656U4BNTk7zyW5XqbagE4YkRsuTXx+QPkd4FHUqWLWDptkZSCdyQvQ+99k8rTnY7xztkSSqcnxje7BS2FGqu2TTemzFmUBqjugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212423; c=relaxed/simple;
	bh=DK5JO52DT0dw2uiHgctXjiifyDwEk2mR2WAVlrMnokk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjQGyJoAmEEpT7kxsRTJ0VMTwXYDqHjYYpgn//u/6xYnazQ3UnjQg950PzRaEDt5Txhb047Jz6JblLMjrWRxveleuUpkX+RQSEwcsCyEqCkbQZp/YIAHteB4cFtczYwdW5FsSdJBaDEIpPlT5S/yF4qmG6L3vPY+ghCLyZopzKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=aCTIuBOI; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ff7a8b5e61so63178237b3.2
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 11:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706212420; x=1706817220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTIRqRIe5iARQFVR6OdQoP/uZDt3nDN1SfyB1LDrOKI=;
        b=aCTIuBOIygUkRv7x80ptomLilWgVap2t5nXp42nKjjA9G8okcWo0cRNdjG+gbxplrU
         eR/4VwTu3GpB/z3yioPdoXc7vaDEVbt4AUBn14awTZF7Hra/7YuTCRoNAvIdMznimDew
         GeEA1T0wi86O8s2yMTBvN9H3SEFYa1xdEE9G9jEwvQRfLmjW0km5wOoScVMO9eUuhxua
         N0kdFf8Pnio5jcVLGUXxVD0SA9hkci10CH1zJ08rv7kS83/AMNVQO9cTUrwPzLjoFAY7
         Kx337ZV9QQYA6qKG0kTdqbRPZQAeAeuBgsbQMjT90Im/y1VXyxbbT58u+sMOBakXYSzq
         bcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212420; x=1706817220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTIRqRIe5iARQFVR6OdQoP/uZDt3nDN1SfyB1LDrOKI=;
        b=xRZXrbR117dOPtEcGe81FQGZrrY9hIdiouxCmRwxYegy1Mw4Rp0NanH4lDz4QfPZbX
         aEXESEh3B+TTZsuSYLBivqKwyT3JBkFKWIynR/FwUFh4Stsd4XdUNDBB98g54sj+18pk
         VqjAwqkWmGq/3AdkxO3kd7kvrKy4KyYxbLLYBZ70SBQFhD77Y3OcEKXalRi4YkJXP/JA
         LTXMz6eHaqHGcGhXKm0K4oLaVtlthNHmPn/T/iTrpY2difli6Uwd117ryoRoVzlVxM3L
         02UtL6lZVrLCbius19FV8IYaaktmLbfPxQUxY0UOX2hSUzFrXDsAVaSZFCcYLmSt46pi
         4YVA==
X-Gm-Message-State: AOJu0YyCkRSta7RflPkzcJjsm/2IUWd82rZTVwIgAGnxBcUDfEm/lCjF
	mNjcneU+xomB706D1h9sxd6B4gs+HCAyiVQlWXF8DdH2oRKZ8N161VHVNoAeK1oL0Kt03uyDcbk
	p
X-Google-Smtp-Source: AGHT+IGFaSNMCjDnMNm9PPSeVZz4AY6+MWwarcn2HyZndbnmqXqr1fG75vcQ036i0xi8L5RLrxbKow==
X-Received: by 2002:a0d:d448:0:b0:600:255e:9320 with SMTP id w69-20020a0dd448000000b00600255e9320mr375564ywd.21.1706212420620;
        Thu, 25 Jan 2024 11:53:40 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id cd8-20020a05690c088800b005ffd0571b06sm856606ywb.4.2024.01.25.11.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:53:40 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 04/13] sunrpc: remove ->pg_stats from svc_program
Date: Thu, 25 Jan 2024 14:53:14 -0500
Message-ID: <aca46330221db9bf04a690f93fea92fefae8eaf3.1706212208.git.josef@toxicpanda.com>
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
index 2a1447fa5ef2..9745ac61d83d 100644
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


