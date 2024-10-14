Return-Path: <linux-nfs+bounces-7173-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B84299D881
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 22:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE09AB21AE6
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 20:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE571D0E3E;
	Mon, 14 Oct 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQTh7aVw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ED81D12E6
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939039; cv=none; b=NrsVfNepPCNNN7Bk8IPK0zHX/ENTHbVxBAmcDYpRMkm1OdLa4kn0l4cf2SEuXeluX95sucRNUpf25aNSl5bwbBBcu6+N+YSs9MnuVJmHQuuwbxiYMjS8mFAkYdaWl49K6/liFf+rhoyWzmBBtj5VolHpQJXsEyDKy26sUVpfqWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939039; c=relaxed/simple;
	bh=tuVwvWYjGCe9syHnueguTd0UO7Q1suqSdTrGQi78y0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QZEt7gcwErSGPLg/3YebvJ9yTlUHQ4G6QTBgF3SrhUcgHpeab9bfeanAsG8+aLc8s+FNCmRVUbccCD8mAeFSDpjlKxQDfo8MnBvubnSdJHkVjk8ZbPqiUwQuVrKf17ruGt7/6bVTQM2y2PHjwoEDEHmQUmtZWLCfyhuzGAl3uvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQTh7aVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2A4C4CED0;
	Mon, 14 Oct 2024 20:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728939039;
	bh=tuVwvWYjGCe9syHnueguTd0UO7Q1suqSdTrGQi78y0U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BQTh7aVwzZSTq2Oqob5oP20aYIfSbD69qfeBe25+nu9Pnu5DS4AFbEKRfawwjFJAL
	 uGKMGXMM4BK3Y/lggMlHseAYH34P0mXfs2oAkqWgLln2Bd7hUO12PcNny5FEk093g0
	 b8stWP0URkBsscEokUwDVlIymbVqEOCkq5KaTgtca63CrNi0ojY/jliAz2OXtwwJIo
	 K/kAfUssh9+5xmYro20WLnl6+zgtFxyKB8R6ibdBdJsS+aXtZSQ6cUrrMndawgnFw3
	 IjxGYPf1VWB+tTFZvZqqlfKDfC8rKyLDR7FXCGP1aYC36oT16r7Wk/UxgybRHJ//sP
	 F6lKBPQjHyo5A==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 14 Oct 2024 16:50:25 -0400
Subject: [PATCH pynfs v2 5/7] nfs4.1: default to minorversion 2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-cb_getattr-v2-5-3782e0d7c598@kernel.org>
References: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
In-Reply-To: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=tuVwvWYjGCe9syHnueguTd0UO7Q1suqSdTrGQi78y0U=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnDYQcpDip5vbMtewA0dp5wSostjjiqN9k5Q66F
 /Z42GR6FE6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZw2EHAAKCRAADmhBGVaC
 Fd8uD/9rED/36+nqh5O34rBrLe5EeY8bGG2GhPOpEjDZp9p+hh8W7jZXA+wYJoXQYaIECvKFcgA
 Oz6S9eMDxFR26B8DRknHgzhg7/EYWzuZlrFIzw0+mu/IhjRTcEjD2PWAiDPTaF4o/gChqgO3BFl
 oTxkYmFoQNxQfmunmiZhAZ2v90+bDKRSsDLqcRu7J6YY4XVZIdN/KH+FS9yf5ltUJMsLR9ZCYj0
 HFB45H32XVdWjPKylY/QpVIjyGMTsVBpBfPi4RBd0tWmYbf65n+pIiBc0+XJgfIRTkxeVJSVzsC
 WKsV61pTwdpLCXWVfVDM6UapD6QvSNxXEHB+eZW9gb3sp1q9HFHyoAuyEw8GZ4qO/1sp9DAu8pP
 9PwhQneCBA7MR4huPD+7bVP3ma3RWghaamPMNobYnsNrFf0LpQUVQ1LLJ6gghpIaPFgvnCNrSJm
 kUKUok3BrjY3RMj7ZXM+ENoVxP/ddEZ5fJ8aDfYdOB1UWaIm7Gl7kBIQzkopuxQGlPpzcbJIdK4
 CC3+IsNqBjcqaLko3wcK2qZLf5FlOpXqEiLQHkkmhCRlMTCAfNOTfKfRyKS7Nmiaw2/d+tjXmpY
 VTnipv28ABseJDzBGy5GZ12gJwE9/PTakmKDi5fPOCE0yuFceZiVK60ukGuQlo2U1nyft7Km2zz
 uXynCVnT0MW0vaA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Minorversion 2 consists of all optional features, so we can safely just
default to that in pynfs's 4.1 NFS4Client.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/nfs4client.py | 2 +-
 nfs4.1/testserver.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
index 941cf4000a5f0da254cd826a1d41e37f652e7714..f4fabcc11be1328f47d6d738f78586b3e8541296 100644
--- a/nfs4.1/nfs4client.py
+++ b/nfs4.1/nfs4client.py
@@ -27,7 +27,7 @@ op4 = nfs_ops.NFS4ops()
 SHOW_TRAFFIC = 0
 
 class NFS4Client(rpc.Client, rpc.Server):
-    def __init__(self, host=b'localhost', port=2049, minorversion=1, ctrl_proc=16, summary=None, secure=False):
+    def __init__(self, host=b'localhost', port=2049, minorversion=2, ctrl_proc=16, summary=None, secure=False):
         rpc.Client.__init__(self, 100003, 4)
         self.prog = 0x40000000
         self.versions = [1] # List of supported versions of prog
diff --git a/nfs4.1/testserver.py b/nfs4.1/testserver.py
index 085f0072388ad8a4b477073641ae16268532bc6a..0970c64efe34dcec1e5457b7025faf0cb139670c 100755
--- a/nfs4.1/testserver.py
+++ b/nfs4.1/testserver.py
@@ -74,7 +74,7 @@ def scan_options(p):
                  help="Store test results in xml format [%default]")
     p.add_option("--debug_fail", action="store_true", default=False,
                  help="Force some checks to fail")
-    p.add_option("--minorversion", type="int", default=1,
+    p.add_option("--minorversion", type="int", default=2,
                  metavar="MINORVERSION", help="Choose NFSv4 minor version")
 
     g = OptionGroup(p, "Security flavor options",

-- 
2.47.0


