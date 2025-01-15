Return-Path: <linux-nfs+bounces-9258-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6A2A12C94
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 21:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B674A165E62
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 20:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B161D9587;
	Wed, 15 Jan 2025 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyTmc7Mt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227F01D9320
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973000; cv=none; b=fS2hDur1wn3edbAwaBzb9VUE4gqhombx2HgLzTZbA9D+Cj01P4tLgrUq2mwT2cMFex65E/Rf5+mG60R48KmSEwEvmojbDhSQjWtHUR9H9EOJ0hZWTaIxxJn67s24/dPv9u6mXxDXZDcvDqe6GFcQ2qWC4WBZ57LgSsLtCq1Ntwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973000; c=relaxed/simple;
	bh=1SY9npNDZCPDJOJxh0hepcXTRZ+x2s7mjFFm8rpmhwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmZD8dJ7NURDVRd9uLyF/DoT3lFrgZa9Xcd/93VaXPhFzuiioAOBRArjCCjXoWqBBEYP7MTIQTOxD2M08miGprjfT4N+CPDsm8j7VxCTGV9tz2JFtnwHzeVa9kvrYCM3+dav9wpK4n8Onqk0HR1AXNTPP9Ttl4vSf+g65JlwMKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyTmc7Mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91998C4AF09;
	Wed, 15 Jan 2025 20:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736973000;
	bh=1SY9npNDZCPDJOJxh0hepcXTRZ+x2s7mjFFm8rpmhwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dyTmc7Mtq4C3sFp01v18O/5H/g9K/RPrTUsM86fWgnkslrgoc9x8+ZirfptKrbyPH
	 5/zJYX02C3S5IUJDL/RgAx1EE4n/dlVeLy9zit+Kqp+yWPMc9TqBiu312rvL0IPSsA
	 Hw7/WiFUWsMlFMb4lZV03Vz7IGnGchtkczxFx2EP/2ok4y32ph15SptwAX5XtEDIIC
	 WcVSg3wgCuu7KBS47Naf86vk997uM2RY9bLx4JeySiihxnhV1CmglCbXrSTW6imOlH
	 UGi57K3bfjb5smL+0DDVpOABabFMOmXnySdMG6q1raFUpe5+5NHzC2Pt4Zh/SKx/19
	 fMmvtHDCtujTw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v3 3/7] rpcctl: Fix flake8 bare exception error
Date: Wed, 15 Jan 2025 15:29:52 -0500
Message-ID: <20250115202957.113352-4-anna@kernel.org>
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
index ec43d12afc41..c6e73aad8bb9 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -23,7 +23,7 @@ def read_addr_file(path):
     try:
         with open(path, 'r') as f:
             return f.readline().strip()
-    except:
+    except FileNotFoundError:
         return "(enoent)"
 
 
-- 
2.48.1


