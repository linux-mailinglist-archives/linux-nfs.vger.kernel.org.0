Return-Path: <linux-nfs+bounces-16681-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D55C7E2FF
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 16:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DC9D4E2C21
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 15:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B96A2D3218;
	Sun, 23 Nov 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNywabYX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266E229E10B
	for <linux-nfs@vger.kernel.org>; Sun, 23 Nov 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763913388; cv=none; b=VR+wOAy3V20EG5sNo7EpOuwP5J0YMuwqF+a3f1lxj7c0c/w0+Wpob1kLUB+vLMWdbAt/xIqDtF91EPxNhZevfCnFMZjQLlJT+h8RTEpiLcbRTGD8AkrwAh6WLgvU4ofDZyASIckRFaOivjSPpxfRzUHGW5NKJ2VYHQkTSjM+KsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763913388; c=relaxed/simple;
	bh=nPKmF6QGr6o6RUbbxJQ/jZPOSlCz35S/2O645qTAnc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onwByCuwmWFA8wg+QqWJ0Y3J0aajJqPhLRH8A9hz1PcuoO1C/fDBwbyoj3vQRzGkl9MOh3Szc3AjVW4AHOwEmSoS/6off0FQzQ2BPTyY89XlBPbNa6L+bC2Oxe1baq0p2fPtKI209rgxQIPdY+KhUG0lihHe5mbAuLnN6xTD+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNywabYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7536AC16AAE;
	Sun, 23 Nov 2025 15:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763913387;
	bh=nPKmF6QGr6o6RUbbxJQ/jZPOSlCz35S/2O645qTAnc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NNywabYXSLEeuE/HAc7ViTF+z0FXeaNevt9No8pOX8E51bAyZPX//X+Qm3buEcavK
	 DKsl+fE3z5BzR9qaEXErJ0q5um2RKWDD/ZSPdZUsVEYdP3X+hlHxk8SKuKlix4WhFA
	 n1bABPslhEtKp5bdD0CRYaa9TEQkUQvlGetyQCwV4Oo5d/kUs5hvz/DH0QeNjy5jXa
	 WNjWILNpBuOPhsSJDTIBo2eUjwKLDSEbCnxT9rdMuiIai1j2DMzWvm1diP5M4ARVX2
	 na6KNY+hL2DWcdhxWBmq2efkdu+c7mLenzbX1ZX0Qs411ieHpseV9NxPYEDGoB6sMo
	 +GQ14awrfyYbA==
From: Chuck Lever <cel@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 01/10] Add helper to report unsupported protocol features
Date: Sun, 23 Nov 2025 10:56:09 -0500
Message-ID: <20251123155623.514129-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251123155623.514129-1-cel@kernel.org>
References: <20251123155623.514129-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

In some cases, specifications permit a server to not implement
a feature (or part of a feature) being tested. That should not
count as a test failure. The helper added here can be used to
indicate that the test did not pass or fail, but that the server
under test does not support the tested feature.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.1/server41tests/environment.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/nfs4.1/server41tests/environment.py b/nfs4.1/server41tests/environment.py
index 48284e029634..2914cd7ddb1e 100644
--- a/nfs4.1/server41tests/environment.py
+++ b/nfs4.1/server41tests/environment.py
@@ -277,6 +277,9 @@ debug_fail = False
 def fail(msg):
     raise testmod.FailureException(msg)
 
+def unsupported(msg):
+    raise testmod.UnsupportedException(msg)
+
 def check(res, stat=NFS4_OK, msg=None, warnlist=[]):
 
     if type(stat) is str:
-- 
2.51.1


