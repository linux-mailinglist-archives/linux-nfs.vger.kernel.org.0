Return-Path: <linux-nfs+bounces-9251-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB83A12C71
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 21:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B8B3A5BFE
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9971D90AD;
	Wed, 15 Jan 2025 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsFw2J6t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173B41D9320
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972440; cv=none; b=YwzaYdQ+Ony/JBhW9qukdni7qBP2piBMMYY1DjRcM7qN6R/kOAjqkQO0YfzK1y8DYQYGSVcaQ5uDu4KAYisZ8u7lZtLLaOE/UhfIUsfuHHICdbRKtNuEeCIBss6lkLEfPZ5B2F0OPN94cR9elSkjSc87LjRJDmeOoTPANaHBzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972440; c=relaxed/simple;
	bh=aKlE/uab/3R8C3BPeGxr8V73nq7hA/zceATf6X2HUSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwqWDdcCbhlLqH+tVjgvyrWT7O/sT6GB5tf9KIpOSSFtpmyJ9ka0AXIbcV12Ukw6Cmu2azSrP0wWT0BTjyf+sVKQFYMa0PX3ITKFOJU/i2rLY/4384sPRsCAFMPqTekovoTprg/JZ2wSTVREB3clsgHES1isYiJKhd5YuvuqpcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsFw2J6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BACFC4CEE2;
	Wed, 15 Jan 2025 20:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736972439;
	bh=aKlE/uab/3R8C3BPeGxr8V73nq7hA/zceATf6X2HUSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZsFw2J6t88eK4ZvLMukHkIh/MTaDUn8HTJboH5HZcySCW4sxLS8psS8yZOw0hmjbm
	 RqoHUyhmON/t7Q1RsR4F8bQXtuf5XJF7pBsVM2VBSohg+V/UV/GqZw0W3TjFA8DWtp
	 wNK2EQ77fZGz70Cu1eS1RajqaleecdBSKRedCNrCl45ISshgCAcM98bY/IhKcMbnHy
	 d8ipAdWSaX7LnK9ojMkKOb/eReQyxpXiPnUZWJmL7j/kKhw0BccJSPnkn1+rSpvISD
	 LQVJ7sWzMynIncwuHlBlhUU9HO+QPLs4SR0lbYcjtN0R07f7RQBmxpw8ryFc/VPzlS
	 BZkTSUNvBW5/w==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v2 5/8] rpcctl: Fix flake8 ambiguous-variable-name error
Date: Wed, 15 Jan 2025 15:20:32 -0500
Message-ID: <20250115202035.112122-6-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250115202035.112122-1-anna@kernel.org>
References: <20250115202035.112122-1-anna@kernel.org>
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


