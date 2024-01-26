Return-Path: <linux-nfs+bounces-1477-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA5683DDB2
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 16:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75448B2235C
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6BC1CFB9;
	Fri, 26 Jan 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="BMf3FeF8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9E1CFB6
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283644; cv=none; b=ATBmHkcnt3j+ZQe9DRpcy2Q1PMWs0nhv6YE/7OqBczXzNqfQ+HIll1aeh0LenpN2Auf4ADS/7XxiLEDOulLF/QBd5sxWCLvwRpkkcF12uXUMCX/825xhO5kBCHFeQ0bXIE7Xk5WtVv2qC8hzx6pJedYQrNiFzFGFa2iKHnuYfYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283644; c=relaxed/simple;
	bh=oPo2HSHbqQg92hg+sIJI4A54+JArwH/DlZtupCaGy64=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCAeZqmc52rr+YjvIKuYQl2jYjaBcVUWIsEV1SzijyzCXaeqJ0CidjWZOsVUjTnO4Ttu0WSxf9bNp6SH5YFRSEJrugk2hvsRRJ0I78/Mkd8a9PemOWwAKelzWsh8iUFWe4/cwVKzo35LXYOnnFdhPogpNW3VZZ3gR4k5GsFx+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=BMf3FeF8; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbe344a6cf4so873043276.0
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 07:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706283642; x=1706888442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IiehwB2G+Nt2uBxPih15JoYIXyWwYzVUYGRXkPDnck=;
        b=BMf3FeF8BIRTF8cC9Xi/RKcJMH0Ccr3borivlUMdk7slHVMqsA9MRom/t7chJkSBMn
         UqsPzuFGTlm+HeLc/veSLGdo4JOvIDaXaawQQ9nV1twwl79yjJdfH1O7+xyse5rbMZb+
         tdam0a5lU1Ruc8GAqm8emLhEGbBzjvVo6gvspKZmxYuIkQbuCensNguV+oMEzzcJ9bl5
         i8rmlGH8CIheBpz+sYXw8SyK6pr+y9zncWMhH+ncvRG5mjr2PhfxvD5wcGeG+8QD5JB1
         boEuI7vj5b1WxOBGB1Hl0kLeKeYxQYY0uTUt41v/knxbEHrb2sXiihBEEsUFQEJwTa6N
         /4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283642; x=1706888442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IiehwB2G+Nt2uBxPih15JoYIXyWwYzVUYGRXkPDnck=;
        b=qMZJdQX9GF+hAMjJbU71NQsjJY1ZCYp2dxi1uFIcdWmRL7nBbajmqjqDK9z+rqa+RN
         CdLyDsO7dMl2fKSAmiIoFrn8X5Y0mhZpec8E7BY/hZ4ikIc29uP4gSAogLc2yDobf1mz
         X2v+uZZuD9TEbe2Y/XoBc8OqiY6lyu3VhZs4EmKC3kqV8Izjnmki1IjfSjrAAu1O2opr
         PZO1HC/bEJFFOJ5d3/Wv96sRMxq+1Chd3Ch4KWnVZjmhgd5tv0mbPO851Z/g3nItsCUC
         BNZSBEzUjbIrMPpVLo47srcOXK2H+ImIS0xFHHOb3ZjpINylV/ZY7EWv/Vp4vpjBFaVJ
         yeHA==
X-Gm-Message-State: AOJu0Ywwj7HxeD30dnVPIgBHH5UPpFICbnA1UyKCsCzU0aoPB9ARS3Z9
	DfX6ohsoW0WVtGE9CBdmMAkUq99ZJCGdg/ru/eOH9Nw3/nE0evROiJpATsLlcFH2TafqTjUNIeU
	N
X-Google-Smtp-Source: AGHT+IFarNr7Fk2rEromuik2neFZrPKx8pkWY4h9O5dOduaJ4P+k8LGNH0k8iu/cZOigYf7I98aehA==
X-Received: by 2002:a25:ae8f:0:b0:dc2:4771:1521 with SMTP id b15-20020a25ae8f000000b00dc247711521mr18358ybj.111.1706283642538;
        Fri, 26 Jan 2024 07:40:42 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t4-20020a25c304000000b00dc24f777255sm461252ybf.0.2024.01.26.07.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:40:40 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 05/10] sunrpc: use the struct net as the svc proc private
Date: Fri, 26 Jan 2024 10:39:44 -0500
Message-ID: <85b93734ad64521b5543c4d0bf55d03f1983e6a9.1706283433.git.josef@toxicpanda.com>
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

nfsd is the only thing using this helper, and it doesn't use the private
currently.  When we switch to per-network namespace stats we will need
the struct net * in order to get to the nfsd_net.  Use the net as the
proc private so we can utilize this when we make the switch over.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/sunrpc/stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
index 65fc1297c6df..383860cb1d5b 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -314,7 +314,7 @@ EXPORT_SYMBOL_GPL(rpc_proc_unregister);
 struct proc_dir_entry *
 svc_proc_register(struct net *net, struct svc_stat *statp, const struct proc_ops *proc_ops)
 {
-	return do_register(net, statp->program->pg_name, statp, proc_ops);
+	return do_register(net, statp->program->pg_name, net, proc_ops);
 }
 EXPORT_SYMBOL_GPL(svc_proc_register);
 
-- 
2.43.0


