Return-Path: <linux-nfs+bounces-5538-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A4595A45E
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 20:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5192835CD
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 18:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942A81B2EF5;
	Wed, 21 Aug 2024 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHMzeECx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705AD199926
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263634; cv=none; b=Ts0TK91CiGwDF9Ygqj/H7j7cxU6etoS60e12eHN1MDT0G0NyI4bb4f2A5/3cuWgsL5nYM9hPBceUicWHKkbBZqggB0z57UQqhDaL4PkezcybchChjqEtveGrMXHUIO8ZdAJpC2Rj1+Zq8fA7+Xrj/Qkn7UIWwGO+1EO3uWWEQek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263634; c=relaxed/simple;
	bh=QQPLw3EIGYPA36/aWNW4ooZNMGb8m6xy9XH1KESc4I8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q08c7dBNlCyg/+bd/eEYbLdsdLOz7f99cukisTiTDAbJftLLl4YQYhPAAJvok96W0387X/Ha8MUaQSwCPKrU/2g3FCn2Ej/Yf8duYH1z9b0Q/XSGCiALNv1Lbij5y8lGUR+x96PStu1niCWz5TE+T7JynKYsQhHuUjNTBl60vlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHMzeECx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FF8C32781;
	Wed, 21 Aug 2024 18:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724263634;
	bh=QQPLw3EIGYPA36/aWNW4ooZNMGb8m6xy9XH1KESc4I8=;
	h=From:To:Cc:Subject:Date:From;
	b=XHMzeECxHIaCTpJ2ZvhurCfJtTLKA/cRumSGIEB1Ez7h5MmKXUMo39F+GTkLdNBPH
	 4GQtLpOeeuuQa6gL4BycfmDS4Sem41WnAdJIX2cCNMfDdWw+ww2tyK0MBAz9c/p1Mg
	 ucOo4PHoMqTmOTYaOyM7JCSAJEbJpA9KK/s79Tixtaff7wFQJdFQqS3jktJe3I2Xkd
	 RGTrax7DSH4TqQgmcVh9BLCXjjFp2MZervYrbk1BAdlK9Vc5kEGOBDQIiuYcbNqIsX
	 4nDEIgeYy+fmgG40ILR4S9+wm3wbh8jrrvv7XEi5H0gfRKv7KkVf3DVx2R8kEddGng
	 IQo8ggKqbiszw==
From: trondmy@kernel.org
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFSv4: Add missing rescheduling points in nfs_client_return_marked_delegations
Date: Wed, 21 Aug 2024 14:05:00 -0400
Message-ID: <ae213806d1188320ec55b730582705133b51dd22.1724263426.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We're seeing reports of soft lockups when iterating through the loops,
so let's add rescheduling points.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index cbbd4866b0b7..97b386032b71 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -47,6 +47,7 @@
 #include <linux/vfs.h>
 #include <linux/inet.h>
 #include <linux/in6.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <net/ipv6.h>
 #include <linux/netdevice.h>
@@ -228,6 +229,7 @@ static int __nfs_list_for_each_server(struct list_head *head,
 		ret = fn(server, data);
 		if (ret)
 			goto out;
+		cond_resched();
 		rcu_read_lock();
 	}
 	rcu_read_unlock();
-- 
2.46.0


