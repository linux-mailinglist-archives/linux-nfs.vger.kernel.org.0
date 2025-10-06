Return-Path: <linux-nfs+bounces-15000-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EE4BBF05E
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Oct 2025 20:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33A7A34AEA1
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Oct 2025 18:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72432D94B3;
	Mon,  6 Oct 2025 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwGysOG6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C7B2D9498
	for <linux-nfs@vger.kernel.org>; Mon,  6 Oct 2025 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776743; cv=none; b=bdOdQH2ClcfXbV4DY8+YDfJ1S3ekmexXig9pn32Gu8wQhzku45qHu0+MgaM11eQ3OD3Lu1/uyMNswg0RoIgD4B99OWJvV/yn4PFMIx/9qb7XlgHJVms+tBTHsPxu5s+kfuLGZbrtmxMj1C8xsQdfgi8sZ9LfFxLl3pOiwE9huHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776743; c=relaxed/simple;
	bh=mAnP4OcX9pPe1Amn7xI3cutBdUZzYzhfwMDgOPpCfJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ogDOeRE7FhlTj+Lj+ApuACSvoy8SZ0dVA5HGIbpiHb+rB8wKlw6dyuBTExX2PQOOyu7MMFLKw4uhYGrhjSx3y1pyXS+OY2vnGJUb1QempsrQaeMIwq2HFHn2ibqI+cU13K8tMaeCLidnsHOPmoltjzC/KUl1UW6CslOm6+e+KFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwGysOG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDC7C116B1;
	Mon,  6 Oct 2025 18:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759776743;
	bh=mAnP4OcX9pPe1Amn7xI3cutBdUZzYzhfwMDgOPpCfJQ=;
	h=From:To:Cc:Subject:Date:From;
	b=qwGysOG6qFxckadmFAS/MbVAZaoGPzn+pcZoK/qzm2ZSJyx4Ps8wKCCJ/d1WqjxCr
	 1EKvIcI4uffqm/euaAxScMsKYTzUIqAZPmsoQXtyRx6wQUfE2ne65Iz+4CW+ObbrCF
	 HF+4jhE4S4vKWsElTkV27IqnshcNPSV+UUqdptPwk0ZbNa2+oI6eLXG+nYzrao7Idm
	 PpUfzfUDlJyJ6H7AfZpLx+s/m/3gfDG6MpXoA/P6UbZPlPl9PEr2AVTaB6yS01/Xa2
	 6ogV/23x5qiQsUZ617xYKq0kfjLLqun93CiA796GsmPZJpFbh7jGLqUArEZQhw1aBH
	 pfgZN3JnhUYsQ==
From: Trond Myklebust <trondmy@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org,
	Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Subject: [PATCH] Add missing exports for rpc_gss_getcred + authdes_getucred
Date: Mon,  6 Oct 2025 14:52:21 -0400
Message-ID: <7a1ece728aaa225a92d4d639e3f7797ae7bfb9ac.1759775772.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Both functions are listed as part of the official API in the libtirpc
manpages. However they are not listed as being exported, and therefore
do not turn up in the shared library.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 src/libtirpc.map    | 5 +++++
 src/libtirpc.map.in | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/src/libtirpc.map b/src/libtirpc.map
index 479b4ff044b5..0d0f2f4cdf75 100644
--- a/src/libtirpc.map
+++ b/src/libtirpc.map
@@ -295,6 +295,11 @@ TIRPC_0.3.3 {
     svc_max_pollfd;
 } TIRPC_0.3.2;
 
+TIRPC_1.3.7 {
+    authdes_getucred;
+    rpc_gss_getcred;
+} TIRPC_0.3.3;
+
 TIRPC_PRIVATE {
   global:
     __libc_clntudp_bufcreate;
diff --git a/src/libtirpc.map.in b/src/libtirpc.map.in
index 6cf563b443b1..6c0b9b2e8bac 100644
--- a/src/libtirpc.map.in
+++ b/src/libtirpc.map.in
@@ -295,6 +295,11 @@ TIRPC_0.3.3 {
     svc_max_pollfd;
 } TIRPC_0.3.2;
 
+TIRPC_1.3.7 {
+    authdes_getucred;
+    rpc_gss_getcred;
+} TIRPC_0.3.3;
+
 TIRPC_PRIVATE {
   global:
     __libc_clntudp_bufcreate;
-- 
2.51.0


