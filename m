Return-Path: <linux-nfs+bounces-14996-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A38BBEFFD
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Oct 2025 20:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA4EE4F0DC6
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Oct 2025 18:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FAA2D6E66;
	Mon,  6 Oct 2025 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czLNqq8n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6B4264F9C
	for <linux-nfs@vger.kernel.org>; Mon,  6 Oct 2025 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775909; cv=none; b=CYoOTapj37IJxsusqRcLD0XB1/+GkhRPJBIUEMvUncwfFIc0hDjxEmsYFKE14edLwXVup75GY5epqt+9ybxfpS6zYxe5HQ4CMQD29Vq3hJZKc56TzHYBORhB8vAIW3hThE9OCCGCJ4pRFbtCxw4Nrp+sTjkQYC8RnDVM7CF4pFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775909; c=relaxed/simple;
	bh=mAnP4OcX9pPe1Amn7xI3cutBdUZzYzhfwMDgOPpCfJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OBIwnt/PYG8MX1MlDB5vAt+dQI+Vk6krsE7zDfbHHhFJQvh8FM+2U1U9Huzgeqo+cSoM9I7w8y24qqYTlsjERANrp7+Q/Hs8Iyyt/UT0enz3cJMPFQ58qsEceosX/8vmplTiJyc5vniRdw+VIC80uRTM7/M1WmdvaGx9nIc9/kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czLNqq8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AF9C4CEF5;
	Mon,  6 Oct 2025 18:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759775909;
	bh=mAnP4OcX9pPe1Amn7xI3cutBdUZzYzhfwMDgOPpCfJQ=;
	h=From:To:Cc:Subject:Date:From;
	b=czLNqq8nLYYJNeXiww+qzNHdAvW47lkE+6F3qsl83phYm9WQ7YB0Xm8nj+Zu3XXhe
	 l62Qh9/io0I4iVpJ5wFxx50uO0l5TACMzRtSrg1UQYy911mOhxXqdrItVVTXPYZ/8x
	 Um2UHYL7f/iejgsogs6Iny1HN+nOXzoNm3ri6WOnBLT5VsUJMUQdaRih15T+SgMkBJ
	 HvLOt3Wjl5iH1EzSOEiF33n/tMRTRUYmoqDBRu2dNb3wxwgcFleF0edcQ2VekhgN+7
	 DUGpC9wdR7qSthedYXs7+ixcpRX7sXjry1dol6dclwiKak4bOABvOrIbZ/nynIR5SM
	 kpqrgBPXFT7sA==
From: Trond Myklebust <trondmy@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] Add missing exports for rpc_gss_getcred + authdes_getucred
Date: Mon,  6 Oct 2025 14:38:27 -0400
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


