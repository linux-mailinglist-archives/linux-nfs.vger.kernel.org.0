Return-Path: <linux-nfs+bounces-7225-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E18B19A240B
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 15:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DB01C22725
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 13:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CA11DD864;
	Thu, 17 Oct 2024 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssARHWCk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F81DE3AA
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172198; cv=none; b=fLuOLyqggi1KiiCsZPcRiOFVIivoYOyxYCvxmWKzOLgCALgGVhmfw9FRNFGcLuK8PDyBYJeuG0+/V+W6S/EB/wU0JdWPTgTXvKdSCnJa4gywv2d8H/GQH8faOETZni9OhyE+9Jk0ItiUnE22RFlxHebOSqeJq4RedscI8k0Coxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172198; c=relaxed/simple;
	bh=gfObLMjWgDs33nfvlJo8fHcPSyaAUdV/b7Igyo2Quxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LonuJHNuXBhM+htXCKkP9MIJ57jf06SHweZgMzZ8XlMpjaSBr2iN8ZsteXx6LYu9+QZaHxaEYiQeUCR8BuDN6V0F8/BC9Rg1X+ak8iCBqTzVIm3zEWQltWUd3VOVwLRGt30TLLmx+9A8fnfm3fNLSxL5JkCp6eo98Z5UKm1nml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssARHWCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DD5C4CEC5;
	Thu, 17 Oct 2024 13:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729172198;
	bh=gfObLMjWgDs33nfvlJo8fHcPSyaAUdV/b7Igyo2Quxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ssARHWCkmhPoI0gMKRr8xVRF0lANHIgZ/elCNrDcceiTORvkSRFBkJzbw9Sj6l0RZ
	 Gk7xDnMrfIzaeR8mJycFG5QojJVr+frq7A7pkMwzyJ2wnsL2rTXxNA1h30Mhe6O7OJ
	 BBetTNjMn8Y8Qp51CCAtP6D5NMVZaocFJrxHXRn1xfkjKfsAi9rO5pGcrHOptLJlL3
	 dVDUXlFYJMOpxLOW2bs9OyugeHsHH4yod3LS83zOIq+XMvHlaoiv1t0aGn6LFyyu0b
	 pBxooFec886pgM2RWgEgWnco0qIf1FULCykCaytIOvYSh4V9GmxNslaMjABpGRq2nR
	 S34mHXj/fRFKg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 2/5] lockd: Remove unnecessary memset()
Date: Thu, 17 Oct 2024 09:36:28 -0400
Message-ID: <20241017133631.213274-3-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017133631.213274-1-cel@kernel.org>
References: <20241017133631.213274-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Since commit 103cc1fafee4 ("SUNRPC: Parametrize how much of argsize
should be zeroed") (and possibly long before that, even) all of the
memory underlying rqstp->rq_argp is zeroed already. There's no need
for the memset() in nlm4svc_decode_shareargs().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/xdr4.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 3d28b9c3ed15..60466b8bac58 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -268,7 +268,6 @@ nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_lock	*lock = &argp->lock;
 
-	memset(lock, 0, sizeof(*lock));
 	locks_init_lock(&lock->fl);
 	lock->svid = ~(u32)0;
 
-- 
2.46.2


