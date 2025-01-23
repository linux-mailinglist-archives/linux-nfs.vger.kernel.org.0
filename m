Return-Path: <linux-nfs+bounces-9555-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39698A1AB48
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 21:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C49188B4A5
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 20:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89791F91C2;
	Thu, 23 Jan 2025 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKwobMj/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAE71F8F0E;
	Thu, 23 Jan 2025 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663942; cv=none; b=PKw1cqHoR6jI1+N0ou6V6Wkz4mGRdBl1gwuuekRKcyU7xsNi3CoKf5Incn9PbP0JuD/8xJQpXvfN86ZHqP4d+nozadSrei13Ngc4jQuiD+ve0tMPCZofONd23k9LD+m7C1kQbjsPf8E1Z8QeRfA/JYbyWsrTlithTIzDxbYm1eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663942; c=relaxed/simple;
	bh=DebSb08fG76qmhQ3qTemQVVI8mheHD+q10MhrBLIiro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kl290rChHQhy4Q7raFsBcqTiX4nF6kSMLcbNmpdu3lRl6J6CIN6/2xzOXGGgy8ImwAk9j8Kw66iGecgqXejDPfUSQ2RtXZHGMQPq6Om6iPi0waKdZQzQ0MX4jMP4PFY4V/DCjEglrwQkpv3blyqTedawXsIME+snCwAq1UQz8I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKwobMj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE50C4CED3;
	Thu, 23 Jan 2025 20:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737663942;
	bh=DebSb08fG76qmhQ3qTemQVVI8mheHD+q10MhrBLIiro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uKwobMj/93W9bVbJQMAMKlVwo9EQlY2lfiaC3tIY6YgCFOZcvyKSxcj88PZplbbLl
	 FlCSq1Ltir+yrOwmbZeH8VH6NtBuho+qrMBAYE2jyVsQljWmLvRRgP+B8uaQePFRT5
	 XXqL+snS6AcHdSISnHuabSxf/szK1yuJ6DPNHNd+faeoUUtmiLUuNNszZnMTdaPBCx
	 cdsn7WF+zWxB66IxuoShnQlZUkUPuWMmxMcYgG3cU3Xl5PRvOwqa3eeMrJsDEG2gjM
	 Q5yiA7yc1nZGJC9DtB20L8VYuwtUkK8RVRwEzXZI8axoalPzrh+NtUPiNqm93pUAFU
	 yNS6BquWEFbnA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 23 Jan 2025 15:25:21 -0500
Subject: [PATCH 4/8] nfsd: fix default case in nfsd4_cb_sequence_done()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-nfsd-6-14-v1-4-c1137a4fa2ae@kernel.org>
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
In-Reply-To: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Kinglong Mee <kinglongmee@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=DebSb08fG76qmhQ3qTemQVVI8mheHD+q10MhrBLIiro=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnkqW8pItdisC8f1sI3ny9wi8ta9jOo2I4071Kl
 gul8d8oGU+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5KlvAAKCRAADmhBGVaC
 FUbKD/9FZQyT1HyoqD1X+/TpBj9G/7slda3K3mK6SQW6Ss9tREhOmidW5mzpjWrOPh6Jaohuap/
 nXffGPNA6O3eaI57DKv3aHZPS0N0+EC7IVcXu4BlDfKgj3Yv6PubUVqdEMvxu0U420X5WMawwZB
 vCHgicnVL33utQAJifKQim3nmay48VqF9buLW5BDblLcCYot4TDxCs1CQ1MuCCJkAL28YsFQWei
 jd9tRSKYke1DxGKzCWbHXynb8x0qedRfhv05+pKtwN4ydvBfx2gq9OFocf9QW0Bj2sVuwNbdFEN
 P8H+b/LPLtz3rHeFoBkfq8sjeITtoA+KKEsfyrDLCZoTYlnZFV9pA7zf8dUGPKUzwiUu7o5N1Sx
 +7/POAgb5x0nhFv6p+LZIRSn433t6pSnnJ1S2u8zDRx+7+/LwjqhCFQP2NnXs+yk/tizA5zTcII
 LsdkskPRzlOVzBk04vpfU/mKZi1KASl5fKtKB9UX8IksRbieBSyBbN5aiSqxYk5Syer4tU+6x8p
 ixJtJ1rZMgoceftDyEql5GNXis/jT/clcv6UQoggIFGasr/OgPOJ3TubeQIOKNOhmBqe0jJXu89
 HCQO/Kb7C17h5IDlvpUnITWuMAnRV/TJ3jGpD+sUv+RO9INj6SmjLH2lAUlCgK5hURRsPlGyJOc
 1l86GRmJiV2f8jw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

If the switch hits the default: case, then it's likely that the client
sent an unexpected error. In that case, CB_COMPOUND reply processing
should stop. Ensure that the function returns false in that case.

Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() for processing more cb errors")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index c26ccb9485b95499fc908833a384d741e966a8db..dcd1c16ca5e6cc1928cae74b89ff4b36912503df 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1399,6 +1399,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		rpc_delay(task, 2 * HZ);
 		return false;
 	default:
+		ret = false;
 		nfsd4_mark_cb_fault(cb->cb_clp);
 	}
 	trace_nfsd_cb_free_slot(task, cb);

-- 
2.48.1


