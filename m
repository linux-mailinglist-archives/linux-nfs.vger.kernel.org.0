Return-Path: <linux-nfs+bounces-6830-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5F798F699
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 20:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACD21C22B65
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 18:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9011AAE31;
	Thu,  3 Oct 2024 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxOS/zbZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73161AAE2F
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981761; cv=none; b=rRG97i16kw0X+tbqF+qfH7Ww6GOjKmBrwXlauoAdktxAaMXWX9ooaTdl3gqSnKpV0KOw51hYwWEaersaM5/y34h4ZyRCTtd6v8rw9QXp/c6oqPywxmWEWUZVXPae9FDNhCZnFJyEXnaAPmVDaHHvpGokkBPI02xxs/VzFezU/pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981761; c=relaxed/simple;
	bh=zVPNu+hait7j1cpUDsk2WqOtmmz2VyWXZW/4CWdhAEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJAv1sxN9pc0a6YZ6o19kn0t7lIkgwk+uokuDjN7UPYfbUYFqOHgQfVQITun4zkKcfJmrk/+e5zfh7mJackecgCVHFiApLnWrv+X8XyVEMNC0CeLicd/pTqVj5W5/GKt+/cFpX4TDg080ktvLAG7iOgIXBxCYHi6CHi4g+zmPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxOS/zbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931B6C4CEC5;
	Thu,  3 Oct 2024 18:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727981761;
	bh=zVPNu+hait7j1cpUDsk2WqOtmmz2VyWXZW/4CWdhAEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TxOS/zbZIkDAe+7nrh0B6vVUos2e3I2Z4AtR1bF7D3Zn6i8Zi5RCFSB+k4ICOypzE
	 fI4WX3RjtMe4pJv03ASOQPcATZRiMru34HFfOIp2TXzJhuiRTTIhbduYCATj5oV5Ks
	 M4vNxuEAEkd78c/Jhbo/U/lJnw8z1nbXQJ36x3I2FkMd5xEzT/vi72/wKY7vvZUlUs
	 qI+rw2Xk9XoUxVbncaCEdSUu9F+t+WW8cR1/wBwK0gQDuE6w9zIF5YaVl+pwq+RovH
	 NWi/SaiJD1jsX2tCa/thj/Bb475VoR2lJxk2+qFXLgTBglE+sCsgiGjoDZ7oxiHF16
	 /S0QUyaPMJFjA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 05/16] xdrgen: XDR width for fixed-length opaque
Date: Thu,  3 Oct 2024 14:54:35 -0400
Message-ID: <20241003185446.82984-6-cel@kernel.org>
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

The XDR width for a fixed-length opaque is the byte size of the
opaque rounded up to the next XDR_UNIT, divided by XDR_UNIT.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/xdr_ast.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index fbee954c7f70..9fe7fa688caa 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -21,6 +21,16 @@ pass_by_reference = set()
 
 constants = {}
 
+
+def xdr_quadlen(val: str) -> int:
+    """Return integer XDR width of an XDR type"""
+    if val in constants:
+        octets = constants[val]
+    else:
+        octets = int(val)
+    return int((octets + 3) / 4)
+
+
 symbolic_widths = {
     "void": ["XDR_void"],
     "bool": ["XDR_bool"],
@@ -117,6 +127,18 @@ class _XdrFixedLengthOpaque(_XdrDeclaration):
     size: str
     template: str = "fixed_length_opaque"
 
+    def max_width(self) -> int:
+        """Return width of type in XDR_UNITS"""
+        return xdr_quadlen(self.size)
+
+    def symbolic_width(self) -> List:
+        """Return list containing XDR width of type's components"""
+        return ["XDR_QUADLEN(" + self.size + ")"]
+
+    def __post_init__(self):
+        max_widths[self.name] = self.max_width()
+        symbolic_widths[self.name] = self.symbolic_width()
+
 
 @dataclass
 class _XdrVariableLengthOpaque(_XdrDeclaration):
-- 
2.46.2


