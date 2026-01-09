Return-Path: <linux-nfs+bounces-17696-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 113BED0B3C4
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 17:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B50A73078EC3
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 16:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C79D364050;
	Fri,  9 Jan 2026 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMy/u7lL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AF0364049
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975711; cv=none; b=lbOFd0uI2Xp4RjKFwHVdwvBzKrw2TXaGOhMmKAlxV72E8/c+7oMSy/mZl7WlMzjMHANV/rmGPS+56VdbK7x+SaajjAlghofxtaYUZBEi2hxi0lTmKxew8mSN/MWKz7VtVmmyjAsqQJAnb1Pqu+NuhEgjfA3JI+F22qlkCgLr3RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975711; c=relaxed/simple;
	bh=5og/3+bq9wkial29STvLF31nFFG4mpuU9xbq5Re6qD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WW67EdtZ43gf12coCgQ14Pl+Wj1moLXOnFPD/hkek2kKWWWLGOSIAnH6I4P2prcZM9bxMYMfsVxEDMk2f80I8aHQORijKzYIyv5iwuH6388K7JqD83zM4LR5ZAyPUYYCZYStEEOk9cVM3/dZFIjWt+CgfXJ/QrKHFX5ExqthVE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMy/u7lL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E408C19424;
	Fri,  9 Jan 2026 16:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767975710;
	bh=5og/3+bq9wkial29STvLF31nFFG4mpuU9xbq5Re6qD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMy/u7lLph1+4pMvLhIRufYK12X2+7M6kQTJ1MA6AqcpofJgXN0kX6231rBr7Mgup
	 nINSrDB3yTbKeF14vPXu8LozuTC3cEgmDg8rWvbsJ6zKT28HXYQFlk0u9YSbqHnBya
	 ppxqZPAVyhtuC9HmYkCaZ4WAkNkTVe2k7zqRIhGjmUdpc0e084jLCDWB+x3h3dJbIm
	 kozOUNCAX5CZFXuezjEIop52BW9vO9QQsEKs5IF9FhesAldaAxjvrdJvKU3f6BPvj8
	 Blm1gtTUxVm0e29WxRCNw0366xdGLjXNV4E7+6bSoZLPuVEMr6+QtTlSepBxhl6XEj
	 HZ8SJsC5nyr9g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 02/13] NFSD: Add a Kconfig setting to enable support for NFSv4 POSIX ACLs
Date: Fri,  9 Jan 2026 11:21:31 -0500
Message-ID: <20260109162143.4186112-3-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109162143.4186112-1-cel@kernel.org>
References: <20260109162143.4186112-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

A new IETF draft extends NFSv4.2 with POSIX ACL attributes:

  https://www.ietf.org/archive/id/draft-ietf-nfsv4-posix-acls-00.txt

This draft has not yet been ratified. A build-time configuration
option allows developers and distributors to decide whether to
expose this experimental protocol extension to NFSv4 clients. The
option is disabled by default to prevent unintended deployment of
potentially unstable protocol features in production environments.

This approach mirrors the existing NFSD_V4_DELEG_TIMESTAMPS option,
which gates another experimental NFSv4 extension based on an
unratified IETF draft.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/Kconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 0b5c1a0bf1cf..4fd6e818565e 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -186,3 +186,22 @@ config NFSD_V4_DELEG_TIMESTAMPS
 	  draft-ietf-nfsv4-delstid-08 "Extending the Opening of Files". This
 	  is currently an experimental feature and is therefore left disabled
 	  by default.
+
+config NFSD_V4_POSIX_ACLS
+	bool "Support NFSv4 POSIX draft ACLs"
+	depends on NFSD_V4
+	default n
+	help
+	  Include experimental support for POSIX Access Control Lists
+	  (ACLs) in NFSv4 as specified in the IETF draft
+	  draft-ietf-nfsv4-posix-acls. This protocol extension enables
+	  NFSv4 clients to retrieve and modify POSIX ACLs on exported
+	  filesystems that support them.
+
+	  This feature is based on an unratified IETF draft
+	  specification that may change in ways that impact
+	  interoperability with existing clients. Enable only for
+	  testing environments or when interoperability with specific
+	  clients that implement this draft is required.
+
+	  If unsure, say N.
-- 
2.52.0


