Return-Path: <linux-nfs+bounces-13797-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7C1B2DF3F
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 16:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 214C1B629A6
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 14:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CA32BE65E;
	Wed, 20 Aug 2025 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSTsuTXc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F293529E10C
	for <linux-nfs@vger.kernel.org>; Wed, 20 Aug 2025 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699937; cv=none; b=E4Fxih3XJjKOA39uOKcLb4PE8iCX1Xs5zj3izFYNlg7q10LWKekpHpIxUpBNhF1ZObDryKu6CcHPuCcBj/Ac6T5STXhH+/i5DBfPxiPXfp+H3cNy1kGrKbFDP45IsZo5QuOeGmxOcSzX/Kn3SaDN1Ts3Cbty4suhffoyT0k+qms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699937; c=relaxed/simple;
	bh=JdPkS4spkmaaAGHNqbyjETt3/rx/v38MvX5yx7dwXT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wlm/xuKBiNXfHTOH3F/stKkE1lFtADOm+h9gZaG/qh6qHW//oTNjrqrZtkaVGHUgmRcOA+iWXmioRPoTBbCSV/Zy4wEZwDYMIFl9IhFckRL6hbjU2pkdYnSQcIpxD5DbfyPuAd0cQy8lRR9uN5M889fnkBwzOBNOXVwEumNGPn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSTsuTXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DDBC4CEE7;
	Wed, 20 Aug 2025 14:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755699936;
	bh=JdPkS4spkmaaAGHNqbyjETt3/rx/v38MvX5yx7dwXT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oSTsuTXcgr6aDPHkC9C0mA/DSizk8UTJ6N7XmP12pjrAwxRKVG3AbqFQ31e51gAJE
	 eWFwr3oxgy2L9FFhByEmo0/qrQPTyTpG63cv3SVf+CAqT+817vTJ8KBI6evedee1OS
	 s3TTjvrWf/nD5SWoLfywHf/USEv3R3COKyL5BHgUzGu109tYMjV/MWoouZJq7xgpLg
	 euzcCHkKS5N/vutDdg54JBIvk3NDANaqOhTLMimnt7QbVXiPf8KvdCs2bnnQjnZxlH
	 WIa1r7MAbZc2XKj/nlT2Hx3l0IceQ9aPmNc1OMJO6eMEoz5LC2qHVPW3eojxq4EgZy
	 18mR3Mqim6eaA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 2/2] NFSD: Reduce DRC bucket size
Date: Wed, 20 Aug 2025 10:25:32 -0400
Message-ID: <20250820142532.89623-3-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250820142532.89623-1-cel@kernel.org>
References: <20250820142532.89623-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The common case is that a DRC lookup will not find the XID in the
bucket. Reduce the amount of pointer chasing during the lookup by
keeping fewer entries in each hash bucket.

Changing the bucket size constant forces the size of the DRC hash
table to increase, and the height of each bucket r-b tree to be
reduced.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 6c06cf24b5c7..053223e2a4fa 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -27,7 +27,7 @@
  * cache size, the idea being that when the cache is at its maximum number
  * of entries, then this should be the average number of entries per bucket.
  */
-#define TARGET_BUCKET_SIZE	64
+#define TARGET_BUCKET_SIZE	8
 
 struct nfsd_drc_bucket {
 	struct rb_root rb_head;
-- 
2.50.0


