Return-Path: <linux-nfs+bounces-17023-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0022CB31BB
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 15:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D20E3079A0F
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 14:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D5F225A5B;
	Wed, 10 Dec 2025 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXEBgVpb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC6213D503
	for <linux-nfs@vger.kernel.org>; Wed, 10 Dec 2025 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765375467; cv=none; b=eKQ4gHZ+Dk2ldNG5+XhsA/dJcnZoiB3Mee7RbVU4Stu5gr7G1mkxjLxqCIhT0MkvgSRa9mOOXt/+6R/EMBsnbHD6GX44+2OhCqhRh9xPqub/a7Kq5BdY7nZyc+yhxd97uLXZkiKyFOu1uT+rLZtgxFqk2+5PuQh/8+S+fKrtuCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765375467; c=relaxed/simple;
	bh=smF6sbjFnkEXdE1Nsj+BJeuHnZI3dRfmK1ikjB5aV9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UJQxexszpO0mYBrosxXKv/S1MOwo5hEuJfQtqWYe8JHtu9FU+VNTLk8mo4GSaiTb0dXo03g6zFQ7bELbVSEbHEsbu7qKFw6pOl0qW1gNeK7A5Ly8k6jdMAX4bb8gSxa1K3qJSOj4BL2aqnA2C+mkaQOqXTl12YDNqNBFBF1YcEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXEBgVpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98D2C4CEF1;
	Wed, 10 Dec 2025 14:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765375467;
	bh=smF6sbjFnkEXdE1Nsj+BJeuHnZI3dRfmK1ikjB5aV9E=;
	h=From:To:Cc:Subject:Date:From;
	b=uXEBgVpbvSTwN8Q82FD4B4E3ZOd+APHL9wMQtGWSdGArLxPwzBuWNcpzB843XZsAB
	 J61fzfrW6EsE7OMEJe1WGIonOJCNio9Gi5mw3tmIrJtGuMECDQ7PN8PcgBv+kK5jDE
	 TOc0kgX/hOaXfQFamy5whEH4R2PwEasUcOjHz48I7ztYi88JAkGChLksW/+DVNbGyq
	 ViFMCpU6CafXfDMXo2kguysWx9gRvG0XMeP7ls8y0OPGgRqdQxxLGmuiKn1lSrdn7h
	 JVAFfgXQtiVxBoFseVNC9UwufY1VeZJV8MEFxE718F72vQ3NOgOA8dSdcp60WaPEq3
	 O6yHYHMQI2seg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] xdrgen: Emit the program number definition
Date: Wed, 10 Dec 2025 09:04:24 -0500
Message-ID: <20251210140424.343186-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

"xdrgen definitions" was not providing a definition of a symbolic
constant for the RPC program number being defined.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/generators/program.py                | 3 +++
 .../sunrpc/xdrgen/templates/C/program/definition/program.j2  | 5 +++++
 2 files changed, 8 insertions(+)
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/definition/program.j2

diff --git a/tools/net/sunrpc/xdrgen/generators/program.py b/tools/net/sunrpc/xdrgen/generators/program.py
index ac3cf1694b68..decb092ef02c 100644
--- a/tools/net/sunrpc/xdrgen/generators/program.py
+++ b/tools/net/sunrpc/xdrgen/generators/program.py
@@ -127,6 +127,9 @@ class XdrProgramGenerator(SourceGenerator):
         for version in node.versions:
             emit_version_definitions(self.environment, program, version)
 
+        template = self.environment.get_template("definition/program.j2")
+        print(template.render(name=raw_name, value=node.number))
+
     def emit_declaration(self, node: _RpcProgram) -> None:
         """Emit a declaration pair for each of an RPC programs's procedures"""
         raw_name = node.name
diff --git a/tools/net/sunrpc/xdrgen/templates/C/program/definition/program.j2 b/tools/net/sunrpc/xdrgen/templates/C/program/definition/program.j2
new file mode 100644
index 000000000000..320663ffc37f
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/program/definition/program.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+#ifndef {{ name }}
+#define {{ name }} ({{ value }})
+#endif
-- 
2.52.0


