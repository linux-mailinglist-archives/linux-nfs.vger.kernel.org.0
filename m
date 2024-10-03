Return-Path: <linux-nfs+bounces-6827-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB0098F697
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 20:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18BDAB22C6C
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 18:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567C61ABEAB;
	Thu,  3 Oct 2024 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iafuo+Dt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303861ABEA6
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981730; cv=none; b=KNQZEA/e5Zt5Whct7YrFDSCeydW4wKQR48OHjH875HvWZBN4yhsa91APanty0VlkAJ5NlLf2oRyVGcvyRzYnMkvYggccZ6xU/Acr3PE4f+pt4krIxeYlOTC/TvMzBKKNmgPi+jxjTX65QzlAlZMR0yl+vla9BGF8Ycot7XXhlg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981730; c=relaxed/simple;
	bh=Bk6ELu4MeGgeda4QU7tKlTn/kVW80wjJBNqAYlXaxgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjDxUtJeIyAzQKWL7QggKiL44489/zoo+pAu3pw6Sbbqx2ciyMWTxZY9kd3Kz+F1AM/jjZNc7ZEhXxL5cKMgefq5jVAI+yGf7ICTBILYPefLuJw+3hlgfwnjJWc3DYCkxck6tUqQwmcjN0gLMZzLjw+6Eg5zcJTbe+Qw5fTYC4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iafuo+Dt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0882EC4CEC5;
	Thu,  3 Oct 2024 18:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727981729;
	bh=Bk6ELu4MeGgeda4QU7tKlTn/kVW80wjJBNqAYlXaxgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iafuo+Dt+avuyOf30PhN8wfz2/TFyJ/JCSUT28IPFJEyVRJw6NFsQIreDV93cJzqY
	 PRVD4Py4wf2/QurS5Ptq6MRviu162fSR1YENERG4ffaxNwjqeK5cf1TxKgtysS5sJw
	 oP6vTG67668rWVOjeyFAO3Lyfyf31lNUCIHrXI5w39ovD+TO5TQcLKkZwKLRftiwPn
	 MfuFY8dv5Pmjpl7FdsrOq6xDGjhbhDzIYP4fzCWEv+jyd6dxfJo7bhmzj22b0p5LCl
	 6JfXSHQlNViDMhnib/PbLfRoYx3I4hvFTTdSwAbXIry+S9Dk9UcumotfRr++5mTdgu
	 frKg38heMXHUg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 02/16] xdrgen: Track constant values
Date: Thu,  3 Oct 2024 14:54:32 -0400
Message-ID: <20241003185446.82984-3-cel@kernel.org>
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

In order to compute the numeric on-the-wire width of XDR types,
xdrgen needs to keep track of the numeric value of constants that
are defined in the input specification so it can perform
calculations with those values.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/xdr_ast.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index 68f09945f2c4..b7df45f47707 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -19,6 +19,8 @@ public_apis = []
 structs = set()
 pass_by_reference = set()
 
+constants = {}
+
 
 @dataclass
 class _XdrAst(ast_utils.Ast):
@@ -156,6 +158,10 @@ class _XdrConstant(_XdrAst):
     name: str
     value: str
 
+    def __post_init__(self):
+        if self.value not in constants:
+            constants[self.name] = int(self.value, 0)
+
 
 @dataclass
 class _XdrEnumerator(_XdrAst):
@@ -164,6 +170,10 @@ class _XdrEnumerator(_XdrAst):
     name: str
     value: str
 
+    def __post_init__(self):
+        if self.value not in constants:
+            constants[self.name] = int(self.value, 0)
+
 
 @dataclass
 class _XdrEnum(_XdrAst):
-- 
2.46.2


