Return-Path: <linux-nfs+bounces-3730-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0A5906341
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 07:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE021C22791
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 05:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F53B7E1;
	Thu, 13 Jun 2024 05:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1VJ0sff"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5B3131E33
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 05:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718255227; cv=none; b=RECF3eixfLlJMKKqlbCKc/vdrqLjVu8zqNCeGo9PRhiatdv2LXBd5b2IVWFroF5ZxHMQzAu6Ms8JVYuykd8KvM8koe+rGBqkBbjMfSRLXsYVhh4eVFVGzlFuGX8CbDHBTjB1bRYJ1JfLgsQKNMjky7jqoYaf6NyrmCuuU7LVxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718255227; c=relaxed/simple;
	bh=I/fSEgCwaXQ1JmLqmzs5nyD+/J6/JeaaClTY/1UsuUE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hARtuuz18994PhM5ZMlty5Q8cWTKQnLfMrXSvHY3fo3UM4i1NvA9MzP/l/NGvU9UygR5CURPzQl8kx77iKVUQ50TEUiyH3V5BIlj8Nq870gI221B3BAwLzXbG+PktxjgLovp7RrNttUVfWn6DFwpHaKgHixTSuGKGdY2mJqw0oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1VJ0sff; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfef5980a69so706717276.3
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 22:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718255224; x=1718860024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BREbmmDaPNq4NqcMp3Sku2uf9WgvnITc3SNlmS6RNxU=;
        b=M1VJ0sffNkxt3XfOdk508mG/Rq6k8lur8BBhhhrysfYwwAjs5aaGBVYzHXraLng2gj
         QCa2IakfdyrNGVKDmsvR2Ebz+uY1S27M90eY9nLs9WOECGmHdIE8cOllXLwUa5EzsFhN
         hG1eJxUXb9LtecQyNXQwiFXXEOzppUW2sfy4AjYloyLbMDHi9hN2J2cIJRaZy4HTJPkX
         WwxmvEYTqP/1/PQTGFPdPL8IL3QV/hIOBwVF0YmOXSUeQ0IJUozCDH9rb3HeEY2N8CEf
         y7gF6xbnijoqNG+SO5qipIinIntetIOXPcG+UY1ITVhiZMuwSlNcV5oaZitNiUMr0Cqq
         p9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718255224; x=1718860024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BREbmmDaPNq4NqcMp3Sku2uf9WgvnITc3SNlmS6RNxU=;
        b=etmqzEIN5PC7x9jsUJlMAlw+k7yS8geAy2qMVmbE7eTsX92tTcq3tbKkypW4zdgWk4
         2MzrSCITuKdpz7abNnWIQ3xHVaJcFap4oV4166ObmX8Ap2DrI6oecF8UeZ0PJ++lBzK9
         2JeFzO49TeVz3M8PAUXt1+vVn3OaEL0J9NijJNrLRJz52BuCe2hPQri7m9qVxCTokd3q
         4UN5H00Q3NTpFwm0eldA77FIYeDExZWAXqEhDw3QB9K5e/gDoNGtr6aXrqEAkvlL36Kz
         ip9EQdEi4uh03SZnwxp5IV3aXCJvdEEctDag0vLEESfz8xlYEtX7Fne3oqOykw6lQpWZ
         ZX8g==
X-Gm-Message-State: AOJu0YzWPtU53HRXhnOj/MioN5kvQTw2Ee0edQypNiCK+ppafJPh4Cfd
	mB4aSVa2hRYBkqKa5s1H3OX9OfZQzaacTUI4TR+lNutcbM9VDHOAyEPG
X-Google-Smtp-Source: AGHT+IEQgYxQNcaTkNrCQRv6MiFkQJOIwmqLWp4JvqzO/UZlIllDdaRWIalUQS8MxbhIXM6ln3msnw==
X-Received: by 2002:a25:db03:0:b0:dfe:3e59:5a94 with SMTP id 3f1490d57ef6-dfe6891fc68mr3702806276.47.1718255224024;
        Wed, 12 Jun 2024 22:07:04 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ed4527sm3079036d6.101.2024.06.12.22.07.03
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 22:07:03 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 01/11] NFSv4/pnfs: Remove redundant list check
Date: Thu, 13 Jun 2024 01:00:45 -0400
Message-ID: <20240613050055.854323-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613050055.854323-1-trond.myklebust@hammerspace.com>
References: <20240613050055.854323-1-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

pnfs_layout_free_bulk_destroy_list() already checks for whether the list
is empty or not.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index b5834728f31b..bbbb692b2a47 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -923,8 +923,6 @@ pnfs_destroy_layouts_byfsid(struct nfs_client *clp,
 	rcu_read_unlock();
 	spin_unlock(&clp->cl_lock);
 
-	if (list_empty(&layout_list))
-		return 0;
 	return pnfs_layout_free_bulk_destroy_list(&layout_list, is_recall);
 }
 
@@ -947,8 +945,6 @@ pnfs_destroy_layouts_byclid(struct nfs_client *clp,
 	rcu_read_unlock();
 	spin_unlock(&clp->cl_lock);
 
-	if (list_empty(&layout_list))
-		return 0;
 	return pnfs_layout_free_bulk_destroy_list(&layout_list, is_recall);
 }
 
-- 
2.45.2


