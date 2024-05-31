Return-Path: <linux-nfs+bounces-3498-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9778D56B1
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 02:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478E7283857
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 00:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BBE4C6D;
	Fri, 31 May 2024 00:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="YOntawLv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77376368;
	Fri, 31 May 2024 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717113641; cv=none; b=n+eOBVtYcmTjeaqnGmywE3V3AZcMl6d6xoXeOcplSBzgNVs9ouhU0gVfxAeeXlyMk3LsRdo+BRrNglv9me1TDr98dnSWbgkNZXrKXLDrkqtIk/vqLT4FdXHfu1wnTxy/m/TzJlBPqERWzTpQBJR96NB01LhH0BROxUDaWbEb9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717113641; c=relaxed/simple;
	bh=grXhQQtr9vpQiwenwMlqZFIzM4wHkpKpRwTg2CYNESI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QJcBeA3VLnYG1zhVecmZOXbF1XO/WMuxOIFXuqPZ75c2QvXf2aHZ8PTfmsf+8wlzC64FzJ+VwRc41AgW3eKJoM7dub105pRVwoSAXYoNJ+BOn93WWyv1nKUfSVTJhzGm0hxa0VMUhOTDz1dzZPcWbBgR76PkM90vrCygrFDGn8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=YOntawLv; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=vsfUdDW5lGoj7Gyyc/8nWW2POiRIc6CuyqQ3G9lMaqo=; b=YOntawLvov38kYpy
	tjmxXj4D6qFX6PSFse96I9vEvzgeDmZc2Tkc2BJxbBjlHBgYbqkEZmg6fqUOClZ1FFGLq35O1ciZk
	PEuTxrwWiFOTefQPz9YUIhNpN3sPXzOhw45ecKae+9/Zop5owIboOu5OyC3y6wnYGKCWrvRmv9TX7
	ZddR0flm03D6XNyBmlig0TQ3T6e/H6tt93JUMAWwTZGfDnF4aCfPTe9OAKROelbgEfFwtB97T/g7Z
	3WNtE7NXMPsLvoHHz6dRJHVwUjzpp8Nkqf+a0/QluK2X261TnmuvjnbuWskFgc3VXv4vj0y8SDfXR
	NGv1QZ0+3j1Sk71e6A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sCphC-003T5a-0q;
	Fri, 31 May 2024 00:00:34 +0000
From: linux@treblig.org
To: trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] NFS: remove unused struct 'mnt_fhstatus'
Date: Fri, 31 May 2024 01:00:33 +0100
Message-ID: <20240531000033.294044-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'mnt_fhstatus' has been unused since
commit 065015e5efff ("NFS: Remove unused XDR decoder functions").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 fs/nfs/mount_clnt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/nfs/mount_clnt.c b/fs/nfs/mount_clnt.c
index 68e76b626371..57c9dd700b58 100644
--- a/fs/nfs/mount_clnt.c
+++ b/fs/nfs/mount_clnt.c
@@ -128,11 +128,6 @@ struct mountres {
 	rpc_authflavor_t *auth_flavors;
 };
 
-struct mnt_fhstatus {
-	u32 status;
-	struct nfs_fh *fh;
-};
-
 /**
  * nfs_mount - Obtain an NFS file handle for the given host and path
  * @info: pointer to mount request arguments
-- 
2.45.1


