Return-Path: <linux-nfs+bounces-2867-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA80B8A7E39
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 10:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBAC31C21476
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 08:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1894E7E763;
	Wed, 17 Apr 2024 08:28:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 7CEA371745;
	Wed, 17 Apr 2024 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342526; cv=none; b=SHGavc3skHPn5jli5hQgD300Gy3b5bHbFC/AvgWtSr+JctZ8CoTM3bT8eZbXGS99f2fnPfDzSjYImV6PLvimWbeC/G15qk7exakMWZGSjjY9IoDowawUXbUYMUbY1gWqc/9dpHGLWCy0fNsfNkg8vMHv9y2ltDjvSOehqngh2Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342526; c=relaxed/simple;
	bh=iXTes1T3zb5s+wDOvBmCsD1VNFBqg7mCpl3R6vpiuIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ktiOAv1rMxsftEpoPCKrNnwXlRl4GXN1RTulFhuDqBDvPh9zWAITGBPXWF0YiY9PDDFHKC7bzXQVUS6ua5uoexUQfwU7qaooKCcYXEU830sQfS5p8gAtVkMxHcyi8A2CZAViqrnZUq9CB3ceg/NG9rBBpP02/Vm4lftwVQdy1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id E528B606187A1;
	Wed, 17 Apr 2024 16:28:28 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li kunyu <kunyu@nfschina.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?lockd:=20host:=20Remove=20unnecessary=20stateme?= =?UTF-8?q?nts=EF=BC=87host=20=3D=20NULL;=EF=BC=87?=
Date: Wed, 17 Apr 2024 16:28:07 +0800
Message-Id: <20240417082807.14178-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In 'nlm_alloc_host', the host has already been assigned a value of NULL
when defined, so 'host=NULL;' Can be deleted.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 fs/lockd/host.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/lockd/host.c b/fs/lockd/host.c
index 127a728fcbc81..c115168017845 100644
--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -117,7 +117,6 @@ static struct nlm_host *nlm_alloc_host(struct nlm_lookup_host_info *ni,
 	if (nsm != NULL)
 		refcount_inc(&nsm->sm_count);
 	else {
-		host = NULL;
 		nsm = nsm_get_handle(ni->net, ni->sap, ni->salen,
 					ni->hostname, ni->hostname_len);
 		if (unlikely(nsm == NULL)) {
-- 
2.18.2


