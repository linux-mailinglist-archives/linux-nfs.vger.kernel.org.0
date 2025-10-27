Return-Path: <linux-nfs+bounces-15680-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 759FBC0E3A4
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A7BA4F82C5
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEF3277035;
	Mon, 27 Oct 2025 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDAedwAW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885F325B30D
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573396; cv=none; b=cHcQaFEsIgv3FKbekAhnDcYxcHKqR5IAPi3EAxhjumMOH8+0cWblBl0ySmB1jK4sJFNhN8iosldlBO9MMRDV3k70uNtE6SwfyM7GDMS8/a/iyXDRLMRrVHlkOlET0HoqVO42kydRSDtfhj/0/M4MRyVwmA8x/eAl04Hgjc6wiJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573396; c=relaxed/simple;
	bh=Bx1UFeOMiZCUjMH4kalB1AhOHc2R5H92ofrC+AfnaIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1+QxuCQvpUk6zgVoNZYO7e0zBmAn2ZCXaxd03OUCerf2CcwZck19TUWhE/rYfzENDxvxKYT0Y6Fkd5fK1e7EfqQlMoI47yqD8YIUP0WspBsaKutUNkjTrxg4ox7jJtyOxrJm8VuZRorOFviBCfxQAR1hE8QZ6SQIJgKdEQ895A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDAedwAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4018C4CEFF;
	Mon, 27 Oct 2025 13:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761573396;
	bh=Bx1UFeOMiZCUjMH4kalB1AhOHc2R5H92ofrC+AfnaIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDAedwAWDTx/wvEMFBjzoA4SLJPXoxIn6w70yR59chntRU5/IvDlM1HWPH9UutSEp
	 Hlb+Y3ECl0Wfslu5i3pW0AjI/VZ3/R+hiKEpf1YSxy1vfTppwsbHQp2/0oeZGluOeX
	 L6X2Zt65PJ7NnnwiwqBw8/zJT4M0AERx0HaOtdXah53toVt3pzcjYVPgPtTx0C+dWu
	 Dnj/DFjSNReX/IlhSTBMKFZVkA705QS7sFnKRaElxoWkH4pMnvWwI/d6Mr/iMq3G0C
	 NTixxNkwNL3yTUy+R6vck0IpE3neZEFZ2q5cS47HnMRESGXAqkWq0dd90gUxHf1DGy
	 TCX+nplAZziuA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 2/3] xdrgen: Make the xdrgen script location-independent
Date: Mon, 27 Oct 2025 09:56:32 -0400
Message-ID: <20251027135633.9573-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027135633.9573-1-cel@kernel.org>
References: <20251027135633.9573-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The @pythondir@ placeholder is meant for build-time substitution,
such as with autoconf. autoconf is not used in the kernel. Let's
replace that mechanism with one that better enables the xdrgen
script to be run from any directory.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/xdrgen | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/net/sunrpc/xdrgen/xdrgen b/tools/net/sunrpc/xdrgen/xdrgen
index 43762be39252..3afd0547d67c 100755
--- a/tools/net/sunrpc/xdrgen/xdrgen
+++ b/tools/net/sunrpc/xdrgen/xdrgen
@@ -10,8 +10,13 @@ __license__ = "GPL-2.0 only"
 __version__ = "0.2"
 
 import sys
+from pathlib import Path
 import argparse
 
+_XDRGEN_DIR = Path(__file__).resolve().parent
+if str(_XDRGEN_DIR) not in sys.path:
+    sys.path.insert(0, str(_XDRGEN_DIR))
+
 from subcmds import definitions
 from subcmds import declarations
 from subcmds import lint
-- 
2.51.0


