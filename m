Return-Path: <linux-nfs+bounces-17434-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D780CF11DD
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 17:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F03D83009400
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Jan 2026 16:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886B9126F0A;
	Sun,  4 Jan 2026 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8B3+1YS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A754400
	for <linux-nfs@vger.kernel.org>; Sun,  4 Jan 2026 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767543023; cv=none; b=kbm64WijHnk8ipOe7IsVrym5N5WYxP/+bd+Glli4fr/5G6xzERacrLajFDLy2+8ckpcvoHCokrKTHR/oJGSjJCpa6ozoGw2HF/Q4pIbrPOsX0JXBLQ8JIMIB/0/IumFbAhmGe2FppoL/0QMDt7S/h7nloRSfLE62uOy/8h3LVug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767543023; c=relaxed/simple;
	bh=Bg8vpKNL9w3LeQD+/RjLZxG54w4osAwq07qLKFmsm/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPXr7EaMQItt1FlB2L+2j21UDX5PjMG+dc9jH58S0YMSr1sDZWSoeAFZKiS0Lbr3R1Q40LauSEHgCZkGFOA+1OvK/IP5Gt0anG7KS55KMaQrjER0JPd7p4ZtipLQkBrRBb3GYUZLhfca7qOxmpZG4xY9Mtnw/ZCFmZ+US8Q42fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8B3+1YS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF8CC19421;
	Sun,  4 Jan 2026 16:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767543023;
	bh=Bg8vpKNL9w3LeQD+/RjLZxG54w4osAwq07qLKFmsm/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F8B3+1YSnc4zZmUmH/4J/NBbxGKzMnlecQ4+pq/DoRNCU0u52YKrktSX8bgubQC0L
	 /cFa7Jh3JzWtWGw4TDJrBi5ScKfK3UbdwqoiGbJAYAoUqW5HNtDsADbCAinVrc19P7
	 wZQmmAHtVrfwfOHacpJk1bPjeEwHhJLLze3OSBVoxoX7CAO+EofOBa615lrC5Ya438
	 EbsuD8M0PnvwVupMWhrPlokWAeHjW84OctezxZ0zhLkKJuzu46UaiCXYR4JeNcoJyV
	 2yCqH0sYrB6tpzz8SRz3RUa1FnXixr3HOpPX+Drcei2Wph1s2lTUQBVmUKuoFpY5Ju
	 4Rj+7KMXw85Gw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 01/12] NFSD: Add a Kconfig setting to enable support for NFSv4 POSIX ACLs
Date: Sun,  4 Jan 2026 11:10:11 -0500
Message-ID: <20260104161019.3404489-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104161019.3404489-1-cel@kernel.org>
References: <20260104161019.3404489-1-cel@kernel.org>
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


