Return-Path: <linux-nfs+bounces-8992-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA3EA06749
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 22:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2A6D7A316F
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9108D20468F;
	Wed,  8 Jan 2025 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4E6FvOt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D79F20468E
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372250; cv=none; b=vDTkCcqQ3dycoXA72VNsbb3nbpYTcs9SLbpgitNunGP3St/etg6HqdrOovMrlagRJAT57Lc33Uv2aoUbEF98+A5Ti50MW5IwFdaUBswEGFiDf7o8E+BoN7/yWYJwSAWt1RaJbSQKb+gbC2++hlagA3QNOPTOTIVjp7ZFjbp0goI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372250; c=relaxed/simple;
	bh=2yKbHVaOHdTZCHip3sx7Ve6r7fgYiMdZZZ4shSizyj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvG3EUeOJeCdJUN0WplLPRH5DdCjGbDT8ZQITNgnLVS18yDQNxYVGf2ydquxBc3L1VdHBNp0iwfnC5c6j1wl0YwUR8nl0HW/aTTh8wE3iSNPK/wWOIMPkU4KDrGewjxB8j1aZtWcXwfIU/QnWZv04in7kR/JHoNqPdLBmMLiMbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4E6FvOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C09C4CEE2;
	Wed,  8 Jan 2025 21:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736372249;
	bh=2yKbHVaOHdTZCHip3sx7Ve6r7fgYiMdZZZ4shSizyj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H4E6FvOtE1zy4mOgEH5RLY6j024aW6uP+SZp9ke7poyNLyiULx6OXQmJKsuSIVT+9
	 mftDt9j4q0xHqlMCs5JE/nqnu4i/4NLMVLZ/R7qWcHPjPOZo5+ICfZlkf7cpnljMjb
	 A3hgdvFfqguv/EX3sVwxurGZ00HAofBuGbe14tm3q4ItYrzap43PXZPqSqaAL0gQJY
	 lGyFT8E4KFzQ6QsMhogoM7xQNZMTOzgIFNJ0/rZXb2/+N/L/4feTSRhfV1xDHZoWgp
	 8EGEuwzT7Q6GibWnyyiTWtxCviI+in3teBBLWp4PUrBida8X6jwP6xRRRAXTrKUcVx
	 TM1ZwjJ8CN+fw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH NFS-UTILS 04/10] rpcctl: Fix flake8 ambiguous-variable-name error
Date: Wed,  8 Jan 2025 16:37:20 -0500
Message-ID: <20250108213726.260664-5-anna@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108213726.260664-1-anna@kernel.org>
References: <20250108213726.260664-1-anna@kernel.org>
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
2.47.1


