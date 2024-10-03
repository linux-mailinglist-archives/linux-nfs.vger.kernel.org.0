Return-Path: <linux-nfs+bounces-6811-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A17D98F205
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 17:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14B71F21B1D
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 15:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F96F1A00F4;
	Thu,  3 Oct 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pb6UjcRL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA7F16F0F0
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967719; cv=none; b=OGk3SkFY2A87aJGakAwm1dmWTD6PVr9E4nEHKnPIaj+DqncsWoRvAN6Z/tpK7Z3eY/Nb7bbR2NGPX8cBy1QXXTQsR9hXp/Gx96eCDtimUv0Sz76wyGLTLzlO+0Q1RskUTnEz2E+mBIAIc7fAJVL16aNLW3nZlZqt1+eM29GttRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967719; c=relaxed/simple;
	bh=Bk6ELu4MeGgeda4QU7tKlTn/kVW80wjJBNqAYlXaxgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZgSwTSezgE+RZWojGHKSSEzAHJcv5Dkjvxrrnegj+h71sOQiLD6HoDpC/v4qfurR7BIEDzGhZwIcVRLAU5/pG54UG+XxIbwkx1wFx0uKwwSdPwy4Hy5p1ZpiUJnZ+ctqgFn4wKdAdbUCz/glYJB+SG1NVLdQm74d6TS7kECd5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pb6UjcRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42EDC4CECF;
	Thu,  3 Oct 2024 15:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727967718;
	bh=Bk6ELu4MeGgeda4QU7tKlTn/kVW80wjJBNqAYlXaxgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pb6UjcRLJlJ9RBiRVslMPJXKkVxx18AAT//dWzcbOvbMwxfqDrITc5c2LecRVSuIG
	 p0Rp7aSyfKIE1Xw4OkJvwk5AN8SIS8p3pFqzFAxda6n45eSGsLR97n2VFj/wItDW5z
	 V1JmY/y714gz1RAK1RIyAS1ZUNUuGYhO9jg4uJFvV9nMQFFLdWZRk6JUUcMgdgW6sO
	 GLRRnHy4VtK0rEkzewmbJxCeSJg9bU1jU/hBhUG14bArU86Pmi4IOu+KDMKthKUU+y
	 a94r62MBmS47Tf/7XN+obaFTyR/3QQmne/w3Fz/LPoiZ5oKy7lm0+AnQMSEU96gKiu
	 2+XipPUQsrz1w==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 02/16] xdrgen: Track constant values
Date: Thu,  3 Oct 2024 11:01:44 -0400
Message-ID: <20241003150151.81951-3-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003150151.81951-1-cel@kernel.org>
References: <20241003150151.81951-1-cel@kernel.org>
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


