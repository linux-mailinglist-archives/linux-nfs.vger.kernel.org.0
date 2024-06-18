Return-Path: <linux-nfs+bounces-3982-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D73A90D022
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 15:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301451C23A2A
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 13:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E6713AD1D;
	Tue, 18 Jun 2024 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OiV8Fscj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96CF16B3A6;
	Tue, 18 Jun 2024 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715292; cv=none; b=H0k1d6ymuhwYvYyXM/ZUa2q1WOjbca1T1sPiurr7ReF317KsL4GObVDkMDSWpEWXqArBxqyPNgBM/l86/JVQyFDmUd77ogHWJOpsiApX8ThelwT2tzI30jSw4PWQqv2WZEv8cAmV/EcKNOtxNF9So1jGCklKCCkEftrmrwSQP+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715292; c=relaxed/simple;
	bh=PxL14fNgeZTGRMIzkefR3YqL1hqd0YjoPTJxsMGYROE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+Dy/+cL9HhekZbXMZV2etwwJgrh7RVa2uMq40RU5h9k0K5PJv3e1UMeybWR73rAixTFWjkROgTE5e98Ri8a5xwYMaoxIdmvBSTP1g0OItQk2ab1oQKYEEOrnMM5DO1jdwGf3ZhQcRtoVQLGyUkXaKKRq+RQIplUCPWe1IbF5TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OiV8Fscj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBFFC3277B;
	Tue, 18 Jun 2024 12:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715292;
	bh=PxL14fNgeZTGRMIzkefR3YqL1hqd0YjoPTJxsMGYROE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OiV8FscjUA92SNPnrMIVXia3VZAkOckWrjU2hgvYPgxXg/mWnyylDgki/7d9tUsfY
	 obD776BE++3a00Dqkl6Cu2I8YlsRQc5ipY3+YUrH3VfsxbCdg/ggWFaaaBnuhtngDX
	 kvxTaJ3qolFu7ysgvzhOOFtNt9mXMppe5fIFVOC0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	Ricardo Ribalda <ribalda@chromium.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 242/770] nfsd: Fix typo "accesible"
Date: Tue, 18 Jun 2024 14:31:35 +0200
Message-ID: <20240618123416.618719530@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Ribalda <ribalda@chromium.org>

[ Upstream commit 34a624931b8c12b435b5009edc5897e4630107bc ]

Trivial fix.

Cc: linux-nfs@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index d6cff5fbe705b..5fa38ad9e7e3f 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -99,7 +99,7 @@ config NFSD_BLOCKLAYOUT
 	help
 	  This option enables support for the exporting pNFS block layouts
 	  in the kernel's NFS server. The pNFS block layout enables NFS
-	  clients to directly perform I/O to block devices accesible to both
+	  clients to directly perform I/O to block devices accessible to both
 	  the server and the clients.  See RFC 5663 for more details.
 
 	  If unsure, say N.
@@ -113,7 +113,7 @@ config NFSD_SCSILAYOUT
 	help
 	  This option enables support for the exporting pNFS SCSI layouts
 	  in the kernel's NFS server. The pNFS SCSI layout enables NFS
-	  clients to directly perform I/O to SCSI devices accesible to both
+	  clients to directly perform I/O to SCSI devices accessible to both
 	  the server and the clients.  See draft-ietf-nfsv4-scsi-layout for
 	  more details.
 
@@ -127,7 +127,7 @@ config NFSD_FLEXFILELAYOUT
 	  This option enables support for the exporting pNFS Flex File
 	  layouts in the kernel's NFS server. The pNFS Flex File  layout
 	  enables NFS clients to directly perform I/O to NFSv3 devices
-	  accesible to both the server and the clients.  See
+	  accessible to both the server and the clients.  See
 	  draft-ietf-nfsv4-flex-files for more details.
 
 	  Warning, this server implements the bare minimum functionality
-- 
2.43.0




