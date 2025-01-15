Return-Path: <linux-nfs+bounces-9259-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761FFA12C95
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 21:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4CD16603C
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 20:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFEF1D9320;
	Wed, 15 Jan 2025 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+yLQ50K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA9D1D95A2
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973000; cv=none; b=ulOqDR/xOEyfQA/AKqhtIj83u4HhTTxIoySojvI9vcev1Ui1ZEXvNp+VRsSozpQPMx9z6hhcqyHsY526910G4xBms1MOOACYKOgEGhhgzVO9CJFCGeZLiEssW3SHi8h6mqwMC4bCrRizrmHLs5LfsWpL7kIUEo9RAoDDAGs9rwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973000; c=relaxed/simple;
	bh=aKlE/uab/3R8C3BPeGxr8V73nq7hA/zceATf6X2HUSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGRfnbKqZDieqN4v/KYyRi9uVD5KtXkU5fUpCq72O0f5lv7YDMYGlPLWHhWUYGKhpkUwbczbwnVyM26QriRSqPzKzUsexpg5lUrJEwub0QgG5upT4ezsHSis/lz9JvUumGNIYPgN8sUvbZhIbI7abummRfCMP+93VGMuzOcghT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+yLQ50K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BE3C4CEE1;
	Wed, 15 Jan 2025 20:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736973000;
	bh=aKlE/uab/3R8C3BPeGxr8V73nq7hA/zceATf6X2HUSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+yLQ50KtptfSyZe/FRSwPAPlZtroW0b4lj2ePy9VosMJHl/wq7zNFKoQLYOIhSIB
	 hImvwJW4Zhnf7zpvQIUAcA7Zngp1uKHAjqClMUhLvwObhnoikXstFparPUPxB9Bxst
	 Atqdg30RqRa4g511C6W4H8IMftIvd8zU8gGL6axIFj7EQr0UL0mVLYPCtUISIdrkyq
	 KpWPQwqOmw952agysy/Qc9qSPFN4t721DAj/xmR0b0I4C9iEFBBlr40wUNG0lMNNw1
	 tqoEuFd4PGejjOse03CasGWZfZ159fPSPq1rGQtAU3bbkOmskeKjAPZvLT4Uy02wa4
	 7sj2gibukdMUA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v3 4/7] rpcctl: Fix flake8 ambiguous-variable-name error
Date: Wed, 15 Jan 2025 15:29:53 -0500
Message-ID: <20250115202957.113352-5-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250115202957.113352-1-anna@kernel.org>
References: <20250115202957.113352-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 tools/rpcctl/rpcctl.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index c6e73aad8bb9..435f4be6623a 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -37,7 +37,7 @@ def read_info_file(path):
     res = collections.defaultdict(int)
     try:
         with open(path) as info:
-            lines = [l.split("=", 1) for l in info if "=" in l]
+            lines = [line.split("=", 1) for line in info if "=" in line]
             res.update({key: int(val.strip()) for (key, val) in lines})
     finally:
         return res
-- 
2.48.1


