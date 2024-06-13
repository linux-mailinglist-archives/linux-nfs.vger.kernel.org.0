Return-Path: <linux-nfs+bounces-3739-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB23090634A
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 07:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6E41C228DA
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 05:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4384113667F;
	Thu, 13 Jun 2024 05:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTwH3o++"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD846136678
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 05:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718255234; cv=none; b=fyUETEpthi5pny81WpEfvbaHbkqnZOmkZYjnnWEsYzth/YgwEtZ1ReN6AziMpDN8EvB9WutFA2jKcSdIEwsjS3lNWmHWdlLvgae0l18rMBdDumrDg793rYrfaqMKMIpHx+mam6Ugh5zHSqJJA88uU/vmTk1V/ZqGDIQHWza88mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718255234; c=relaxed/simple;
	bh=5FZhCCJQZGcQdkRuePEMKsfwZUFzXZGeLyF3v6GzOlY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjtYoUY5EJfe5q8soBfnqAMbwbby7hb0F7C1OskiQ21lNi56VRgOgxRN77C/OuDmDx9ncRuYjgQhRUSetp7vmFdIs6QHIw+jkKlmx2RzEUHQQQ8eAQHjRq/YSw00I+gykU5+fOOHnsrC3w60xXXCUP54X9BOiE54rUhR3ExLvwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTwH3o++; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-62cecde1db9so6698147b3.2
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 22:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718255231; x=1718860031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjtiytHHeZfurrH0JqFSXJ6hkoUtVs2kenFI3vJOeVU=;
        b=VTwH3o++F+7nO5VV2xTgNkgx53UgU0NF0a8cDq3aBsuhE+yKI8ZwZctPoYWAz3JK5y
         tLqZM5FbsqcC+hXCKsQEm0jMg23eaEgo/GfeKVmG64F7PcVMkYMn0w0fVDiBiNP2iG48
         dZKdtRKA5MoAp2pnAjLLYy5VYTPUxVIdWqo9gjjncRtHa6WeIYaZwKGGxTRl9e6pszaL
         ROBVjZiTBcs8qE4Y1fIQkaIB9sij5UVpn2YarYPWIN2zc85hwJbLY1zAIggyofYdf6MA
         uaX0jCqpFNJTZKuAAyrWoAFawYwiD0VI7OM2hO6kqjJC+tc6BQCsKl6qBaTOQGQcRxUM
         wCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718255231; x=1718860031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjtiytHHeZfurrH0JqFSXJ6hkoUtVs2kenFI3vJOeVU=;
        b=UPwzmEGpDLeCUf7zlA4xp/GguulOoldKinj7p5P9f65pl2w19MbY4lJb/eAGn8P2ms
         EdeJ4BA6AfSST/7WitD//lEpQpovItG9OkroW4zFdyNMn5RhMbdIwnR0j3a5UiyYtu0I
         jOR4l1NFCJ63Nzhas5zcRrMd9U2FlJ9/jU3zTMdI/SVGM0gHeO8oqXIk2lV9zFGed1KI
         iDulwVjrigHWb4KLI1uHdjpjpb995jwun15WxT0n6EhRNLWV3pQxE+Y5C9/gtv6bbqHj
         IMFzoj6Q31WZo/a9RdBD2sfs9NXDBmlFMIIiwE1PbLdK56JpkHZ4iSQaHD3C3g9cCdyQ
         i+Xg==
X-Gm-Message-State: AOJu0YyZYzhA8Kjqem3h7LDFaWU0pofq+Wki8ZTNH2fUWB3f0C3aZSFI
	oxQCMi6e7EDhNoEP3v4QZqiK9fqMFo1J2rFACwZcjlyqMM2jbkvHuqGf
X-Google-Smtp-Source: AGHT+IG6RYd0OWZP1nBJbe2q/6OWAgiUaGocZV9YZ24D2UxkrVWIB+HoSJ4NLc+PD6/U24l8162wWw==
X-Received: by 2002:a81:c24f:0:b0:627:e1f9:a147 with SMTP id 00721157ae682-62fbb7f65b1mr40877037b3.5.1718255231269;
        Wed, 12 Jun 2024 22:07:11 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ed4527sm3079036d6.101.2024.06.12.22.07.10
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 22:07:10 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 10/11] NFSv4/pNFS: Remove redundant call to unhash the layout
Date: Thu, 13 Jun 2024 01:00:54 -0400
Message-ID: <20240613050055.854323-11-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613050055.854323-10-trond.myklebust@hammerspace.com>
References: <20240613050055.854323-1-trond.myklebust@hammerspace.com>
 <20240613050055.854323-2-trond.myklebust@hammerspace.com>
 <20240613050055.854323-3-trond.myklebust@hammerspace.com>
 <20240613050055.854323-4-trond.myklebust@hammerspace.com>
 <20240613050055.854323-5-trond.myklebust@hammerspace.com>
 <20240613050055.854323-6-trond.myklebust@hammerspace.com>
 <20240613050055.854323-7-trond.myklebust@hammerspace.com>
 <20240613050055.854323-8-trond.myklebust@hammerspace.com>
 <20240613050055.854323-9-trond.myklebust@hammerspace.com>
 <20240613050055.854323-10-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The layout will be automatically unhashed on final release of the
reference count.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index c482088cb485..31df5fae7acb 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -858,8 +858,6 @@ pnfs_layout_bulk_destroy_byserver_locked(struct nfs_client *clp,
 			break;
 		inode = pnfs_grab_inode_layout_hdr(lo);
 		if (inode != NULL) {
-			if (test_and_clear_bit(NFS_LAYOUT_HASHED, &lo->plh_flags))
-				list_del_rcu(&lo->plh_layouts);
 			if (pnfs_layout_add_bulk_destroy_list(inode,
 						layout_list))
 				continue;
-- 
2.45.2


