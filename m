Return-Path: <linux-nfs+bounces-10380-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1645A47845
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Feb 2025 09:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2663A6ACD
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Feb 2025 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8F9225403;
	Thu, 27 Feb 2025 08:52:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from schizo.vip (unknown [66.78.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4A1F16B;
	Thu, 27 Feb 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.78.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646350; cv=none; b=VrSL/xVpu2IiPAFzJw1pAEMTp79avKNckFf+1zMRLTQW+srd/Jw8m2xb1Tind7/6if+B7oSkc3GZ4kOizvS0KYXLa/N6vfjjC7bCAedpe5HQZ/G11fcrA9Ob+CsaJ+tMvbeQBSQGOXaPbjtNcl2Jxt02+LiFV6vSOT2gTnCRfas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646350; c=relaxed/simple;
	bh=ZzUBz7OEJTiPJiD8MP5wX5KOR/2FRnp+mml/fgSIUow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Emr/RAXs+SIW6hLPU4NqqQAypFeBl8984r44Il+ZQ2Rh+2nAmw68thELpRG9mN6SYlEsyGPbMr8r+dvyfDsX1JwMeOA+BihjdogI599M4JDUaZVRpxaWMI69iYFZm2XQX9HI9TG4X4OifmASja+ITmKE0hnGaqZVXpuYPuLf+Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schizo.vip; spf=none smtp.mailfrom=schizo.vip; arc=none smtp.client-ip=66.78.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schizo.vip
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schizo.vip
From: Mary Natalia <mana@schizo.vip>
To: anna@kernel.org
Cc: Mary Natalia <mana@schizo.vip>,
	Trond Myklebust <trondmy@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs/nfs/io.c: fix comment for nfs_start_io_write
Date: Thu, 27 Feb 2025 00:45:27 -0800
Message-ID: <20250227084534.1997737-2-mana@schizo.vip>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

the doc comment for nfs_start_io_write incorrectly indicates that
the function is used for preparing for buffered read operations.

---
 fs/nfs/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/io.c b/fs/nfs/io.c
index 3388faf2acb9..71befe161506 100644
--- a/fs/nfs/io.c
+++ b/fs/nfs/io.c
@@ -80,7 +80,7 @@ nfs_end_io_read(struct inode *inode)
  * nfs_start_io_write - declare the file is being used for buffered writes
  * @inode: file inode
  *
- * Declare that a buffered read operation is about to start, and ensure
+ * Declare that a buffered write operation is about to start, and ensure
  * that we block all direct I/O.
  */
 int
-- 
2.48.1

Signed-off-by: Mary Natalia <mana@schizo.vip>

