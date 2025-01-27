Return-Path: <linux-nfs+bounces-9704-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B388A20023
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 22:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7B51884CD2
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 21:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F481DA11B;
	Mon, 27 Jan 2025 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZCUCM5o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D191DA10C
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738014659; cv=none; b=YJ2PTlTYYStPnH6Rpxb6pzB2YNdYWXwjt8/mBgsOSh5bNlLjEvAoFyekK9IT+CeVesu//FCnhNuAmKJJj8oiJ7bDttL/tr9Xk8fK6blDL4rgkol4t87+LJi0CC7EdByVD0Kt89EBnc5Ez6jaEHlNR7nRadaNPathFvfvwac6PG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738014659; c=relaxed/simple;
	bh=asilNL2lRfAngpwyYb/PV3k14Z6xGn8aioEZKMBH3ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hjil0MKkxD6CZ+ZTTBWi3A31GNfbulqDXQOlMG+9LWhs1ocysQzIekTHiFoG+7NtmTVRsmIuaiS/2PQCeNx176DuQjPWdqbOd3TEvmkqY5zyzuHJf8lkr0Ni3Ok3KA67rbpG72b8u6nSpFBk0h4Jq/Zpbc/UxfWMYgBq05fYk4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZCUCM5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F404C4CEE0;
	Mon, 27 Jan 2025 21:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738014658;
	bh=asilNL2lRfAngpwyYb/PV3k14Z6xGn8aioEZKMBH3ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZCUCM5oLkeWDXlWKrH39d7c6NNHw87+R+iHk4bTdfTfQMXYAPSh/PFduWW9xiw3S
	 hrm+3Zf2SpnaK9aaZpZFFYOQMpfV7lJJZZW4SsHE56XWtM6n7HOS4ukQKd4O4+WOPF
	 dX1CYBJaIIo/+52Bwbj2AhoEw3KBcDqhFLtGQe2ZAith9MnX9Ira3Y5vuJUpRp72Zr
	 tAiRddy+WnHJWJNmswt1dyN+erwvSWHWzpLp76N7HXtTEN4iz+RxwsfLGsKobuBM26
	 v4ThVvwW3Jc4RXDynM5knA371pHOiKDdJlX7UqFhXd5jqEWj7HNZ6TjKBvyrclRQwI
	 MvxGW3Mbh466Q==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v2 2/4] rpcctl: Add support for the xprtsec sysfs attribute
Date: Mon, 27 Jan 2025 16:50:54 -0500
Message-ID: <20250127215056.352658-3-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127215056.352658-1-anna@kernel.org>
References: <20250127215056.352658-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

This was recently added to the Linux kernel, so running rpcctl on
kernels that don't have this attribute will print out "unknown" in its
place instead.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 tools/rpcctl/rpcctl.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 654b2f60a894..ce22e424b804 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -20,13 +20,13 @@ if not sunrpc.is_dir():
     sys.exit(1)
 
 
-def read_sysfs_file(path):
+def read_sysfs_file(path, *, missing="enoent"):
     """Read a sysfs file."""
     try:
         with open(path, 'r') as f:
             return f.readline().strip()
     except FileNotFoundError:
-        return "(enoent)"
+        return f"({missing})"
 
 
 def write_sysfs_file(path, input):
@@ -58,6 +58,7 @@ class Xprt:
         self.info = read_info_file(path / "xprt_info")
         self.dstaddr = read_sysfs_file(path / "dstaddr")
         self.srcaddr = read_sysfs_file(path / "srcaddr")
+        self.xprtsec = read_sysfs_file(path / "xprtsec", missing="unknown")
         self.read_state()
 
     def __lt__(self, rhs):
@@ -67,7 +68,8 @@ class Xprt:
     def _xprt(self):
         main = ", main" if self.info.get("main_xprt") else ""
         return f"{self.name}: {self.type}, {self.dstaddr}, " \
-               f"port {self.info['dst_port']}, state <{self.state}>{main}"
+               f"port {self.info['dst_port']}, sec {self.xprtsec}, " \
+               f"state <{self.state}>{main}"
 
     def _src_reqs(self):
         return f"	Source: {self.srcaddr}, port {self.info['src_port']}, " \
-- 
2.48.1


