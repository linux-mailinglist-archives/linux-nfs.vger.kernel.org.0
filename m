Return-Path: <linux-nfs+bounces-6835-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0AB98F69E
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 20:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282A01C20B51
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 18:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B736EB4A;
	Thu,  3 Oct 2024 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEPrtnA6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1986A33F
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981811; cv=none; b=tA1bt/LlYAX/nam03rMig+KarjcFqcKBje7VicLr3sLfXQ0o5A/4t234p+yzmfH+nxhdLnxKX16/viZtVcU3EeU6vk7ckvLCqQU0qmeFXsSPAbnTR361HINMMNSsOWFpX6qppxxfxKGWV+zsKL4sfdhAn9RclMPHZsDSfseLF3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981811; c=relaxed/simple;
	bh=VlkWZ5yxXxxeF3BNsOuwrIwljypf4ALEdO+nPNEhZV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEBwbgeSqaxbClaOTDLTBUxbXew3XtReNghFvwKZ9AiuVWUTOfrJPj+dBz8/vvxxflttUiF9ySYF2Hd8/nSuQirm1k7XfgSnS2Krd0FJYfU4NYJ0pkDxrYhmIVmZ2X7YwAcYsbWz12jnG2k9gM9okw0NSgaiudU8gSkCAV+Ss6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEPrtnA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89415C4CEC5;
	Thu,  3 Oct 2024 18:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727981811;
	bh=VlkWZ5yxXxxeF3BNsOuwrIwljypf4ALEdO+nPNEhZV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bEPrtnA6HF+c0TGS8yeJbvbSgQB6kXIwRInA9h+rw3pxDYe3U5U5do4CUDt2W+Uuy
	 Bjph0DGU3OvhR0777welzz0MIDUUgkmw77hvjLdFE5uCkQVihKN1pbYSIaAiPOGeWY
	 bB4F5vKHokKxO/DHxTCed0+rGYsVANJkN9xZ18nY5O5hWfLk2NMEzWwDuzzHyYbzkw
	 qtmLTU7jD6hG9QYZ25wU3YdBs94ZBkPw1lkdkEEN1N7wyC76r2gHI2YQo1co1Rw3Yl
	 qHCmH5DjSJQzdNb5DA7U+dh9JVIKJqMEsXGFUEcucujzoj2yX4+kT0AkQOjUD3B81N
	 YZUTy3NkWqorg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 10/16] xdrgen: XDR width for optional_data type
Date: Thu,  3 Oct 2024 14:54:40 -0400
Message-ID: <20241003185446.82984-11-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003185446.82984-1-cel@kernel.org>
References: <20241003185446.82984-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/xdr_ast.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index cb89d5d9987c..f2ef78654e36 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -245,9 +245,19 @@ class _XdrOptionalData(_XdrDeclaration):
     spec: _XdrTypeSpecifier
     template: str = "optional_data"
 
+    def max_width(self) -> int:
+        """Return width of type in XDR_UNITS"""
+        return 1
+
+    def symbolic_width(self) -> List:
+        """Return list containing XDR width of type's components"""
+        return ["XDR_bool"]
+
     def __post_init__(self):
         structs.add(self.name)
         pass_by_reference.add(self.name)
+        max_widths[self.name] = self.max_width()
+        symbolic_widths[self.name] = self.symbolic_width()
 
 
 @dataclass
-- 
2.46.2


