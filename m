Return-Path: <linux-nfs+bounces-11355-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96B2AA1AAE
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 20:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7CA1BC1180
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 18:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA7F25333E;
	Tue, 29 Apr 2025 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUc08dWA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B934D252905
	for <linux-nfs@vger.kernel.org>; Tue, 29 Apr 2025 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745951598; cv=none; b=UxCAbZQy0jQrVf/cA9SbaSX+exdZrqHmCvTSL66L8OtWSIWySx0Y+SCYMIMykJyraLzGFJJr4zPliku51UWfw1roIp41UlvsFi3rOS3+7ICX7YnHfFzrww0iDnM+Pe3a2wWx4J5Lv2QZuPeKb2vb7dOmhnTtdKPEN71t5gp1vUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745951598; c=relaxed/simple;
	bh=WdWuGZkEEAyol5ALrodIZL486YDvl2S9CnjuObpiOPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ux2lrP9WXS4OsFLnnDgaKqswF9GY2UN3SfLXD06wZqwpI4uaKqtrenIwcoOMvo4SjPsv/wIEAaplpTOuLo6+z7ZqEpe5zh8gUb4mogFG6SlxPhRgtqcFWrTQ9O8rkLBSrjBpTUusKuosl9C7kF1HxpxdlV0PgUmHEkJ8fpDbdbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUc08dWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026EDC4CEEF;
	Tue, 29 Apr 2025 18:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745951598;
	bh=WdWuGZkEEAyol5ALrodIZL486YDvl2S9CnjuObpiOPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FUc08dWAEdJl+PaLN84SwAGqKmmZZpvF8n/+2udUjsbjuWPPQgkwVYYT+PAMLvhLb
	 VPo40BZZquJMSWKG3KiftPxL5BlOaNLjiMaTBSPhAdtww5Qt1LsR9tOWd0AKN/nznq
	 RMwPWy2KSOTJiyNals7ZUqxKMlgPtFaTfA2xU/Y9BGnmBYgcUunxmweMXETV/gnh5v
	 aewKyDZQcYhUn3b9T/IN1eQ8lASQiGDetk/HU8PM8cI8PVUcc/13VlWBwUxfC6gQAP
	 o3ur+iyPB6f/e9hmZSyGFRn3d0yt7fuu5V7PqkHNliChsmxfc9nn+IsPVVfNRJ6ZJl
	 0eNYfl2pA82nA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH v3 2/4] rpcctl: Add support for the xprtsec sysfs attribute
Date: Tue, 29 Apr 2025 14:33:13 -0400
Message-ID: <20250429183315.254059-3-anna@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429183315.254059-1-anna@kernel.org>
References: <20250429183315.254059-1-anna@kernel.org>
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
2.49.0


