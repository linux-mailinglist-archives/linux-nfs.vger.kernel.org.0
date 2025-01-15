Return-Path: <linux-nfs+bounces-9250-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8C0A12C70
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 21:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF81C1629B3
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 20:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47C81D90C9;
	Wed, 15 Jan 2025 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BA7Yu4N8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EA71D90AD
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972439; cv=none; b=facFHWnqwVy3l399Vm0RBMcTS6rRgbjg2nQP5Eu2n78Dn6WLQZ2QRgX6dOGaD77PlidjERDiqRVRgH2u6l+bgLw/Ynp0iazqRiI0RwtazaUc440T5kg2pRLXXszRBVXMxsEjHTkN4exTynJHdYwImWxqdM7bVBAbU+0vGMQVrhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972439; c=relaxed/simple;
	bh=1SY9npNDZCPDJOJxh0hepcXTRZ+x2s7mjFFm8rpmhwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrmcyCqcWLSrR1RWZhfJ5ADszQ9AzszpN/T4wW9JQFXK2Erfz0+3sytk3lCj+VGwIhSsssPeHAEFDHJNLEBot27+QsCpJk9Xe2j2nk3hBd8ohMfJrm5NKtgvT+IqaxM4pdqjsf5x66crRLRVYrbFCS7Evq8uEwLB40H6QfLWdz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BA7Yu4N8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAB0C4CED1;
	Wed, 15 Jan 2025 20:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736972439;
	bh=1SY9npNDZCPDJOJxh0hepcXTRZ+x2s7mjFFm8rpmhwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BA7Yu4N8LeqGRHGadK79tRyEEyiJ8WIKESZ2n9nXcw1tjLV9ABXJXtE5Wk0kTAxTN
	 fp4kirlHMn7YI8DkjmeUgFDwc6SflfWSBB2bCh5Ym/grC73FDCd7exX8wJylGIwh8X
	 Y6marGXRaaWcXIOf+6dCIRDK75uHWfsf4Q25PnvcZjGmyhpKVR0D5dnHWMPJgyZRqB
	 p13/374E9R3tlrGgDVdJwQ7tU1J/FfstNheWalLg4i/K3RjMw97h0IFzaBtzUnk2gx
	 C7ujyr9Cg2PiXIQ1eLUnVMlEgr2G97BUKbQlbzaBaiY8qqVRgOtBXS3llaAD6Zzadz
	 k1QsiggdQq58w==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v2 4/8] rpcctl: Fix flake8 bare exception error
Date: Wed, 15 Jan 2025 15:20:31 -0500
Message-ID: <20250115202035.112122-5-anna@kernel.org>
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


