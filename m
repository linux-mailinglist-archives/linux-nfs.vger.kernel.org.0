Return-Path: <linux-nfs+bounces-4771-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE7192D245
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 15:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053AC285367
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 13:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200C0192B8C;
	Wed, 10 Jul 2024 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSQWagAe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE349192B85;
	Wed, 10 Jul 2024 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616790; cv=none; b=N8BNSgWkoRWJkwbFtwJNWWUszGso0OLPSSTt1lGI/2W9fJ6/eOX9IT+VOOc8oMa+H2gym1onx1XpNyu/3sUfTYDJrB+D28RW9Qw1Asq6qZj5QKwNHP5iZG6HS3KqGMbBxBIQJg0n7swzzfQXFTzDC9HKVw3/vcziOnHa0U7guvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616790; c=relaxed/simple;
	bh=FUxA06jnYH/Ta9/O5/4vWWJfqdKwCRgE/6sEUrbzx0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aald31II/ShHsiiH+ULQ35bwf5MA2KMGeLniZeKBHVsyxqtTkehlCKfDWaodcCKT3PyGnyYGyAFesAt7AxaqltAbZGRLgoVPWGUW0rZt4qt78iHuPCfztcAAX3UJDVaYQfh/b7F9FyRNQWExel0bihWxUUIdHXBA3qoZqZ7W8Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSQWagAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47CFC4AF07;
	Wed, 10 Jul 2024 13:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720616789;
	bh=FUxA06jnYH/Ta9/O5/4vWWJfqdKwCRgE/6sEUrbzx0Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aSQWagAezpfg067CjPDE6qh/y3FHoi2nACWNpkcm6gRgefureBscFJH+7yaqUtCMT
	 cm/8ELgE+OrW9393BZckZR4YFWD17NbQhstCU3nhpHBKP8uclKWckhr3xNobOCffZG
	 vgs4bKQgzq52TOo92oqTGCLcwO/xOYVhuJWA9F10H/kvFRF1AcWbFpbu4jTT4QfLaf
	 0Us0+s9Zg7l/Pj/xymYA0z0npsYfFcVXCtWYMZSQMHUWAK9oRzVx7b1A9CVmT3klsP
	 Tu5eneCyUHMPrH9bbwWRCqbviNbg1FVHOOIxXG8DK7jW4D/MzL5sDwLswMDt/kBrUw
	 392OZG6apMaiw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 10 Jul 2024 09:05:32 -0400
Subject: [PATCH 2/3] nfsd: fix refcount leak when file is unhashed after
 being found
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-nfsd-next-v1-2-21fca616ac53@kernel.org>
References: <20240710-nfsd-next-v1-0-21fca616ac53@kernel.org>
In-Reply-To: <20240710-nfsd-next-v1-0-21fca616ac53@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Youzhong Yang <youzhong@gmail.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=793; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=FUxA06jnYH/Ta9/O5/4vWWJfqdKwCRgE/6sEUrbzx0Y=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmjodSSqy31DazLB7kcwt5g9Zn14B9Sa2xZPP1S
 8B6QGsUKhmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZo6HUgAKCRAADmhBGVaC
 Ff+QD/4pgQoUcQ5URJp42KQNCS6YiIjHhHqdh0VgjoTYwSZPGnTMtJ9r2n5I0VLcZIS2iNpqi1N
 xnOq5Do/ief8/UovblADiihQg7M8ajd2jNnAzOMWOHmSaZOoBtppSnzXcxwB4p5k9suSppb+ukE
 eSMihRw5XCQq6KPQnQq8Z9nEPEHjHLg5FCuBXi38I31+uQem2xTO0VifSqFXFSUIhYBEcYFO3Zb
 bXWkq81hE/rWcxM/7CZ7Jo1IdCv9SpSBIl3bd0Zc0TSPvZ/OuKtHPRdM/GdM9fQMSq6es+DOgAC
 G0ER4W6s3HLl3UREjYjkxTPeqAJJiD7XUH4GuMZmGr3nBP3V/6cpaB8wlu5pD3zFPV3/6jK/Omt
 bpZCM34UqOvOzr/CeykZEejr5fQ6AYSUUknDkL1hPFaCnlrBRwBKw5PMclLNRZwhZaUPt+0/68x
 vr4Brv3n+2IAnPdjxYki9sqSgKDkDHHNulCTqcioQJr6XvUqHbdFJieR4Ke+65lFZ4PX0ZTQe82
 Khk7lgk30Xdg694aSBUF0IfCNKAKHDqDHxk3dw2eBIaeKOEMOybM0AqDaz0dpSplRrj4N/HJ+/R
 OdRTL04HA8PrzB/vh5KCm2G4g7HSsgNEeLDJ2SUBvkJ15R7E2gy5TbYn3THVHqTpsMopS/1m8gZ
 XoEGgedfi8FmyIw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

If we wait_for_construction and find that the file is no longer hashed,
and we're going to retry the open, the old nfsd_file reference is
currently leaked. Put the reference before retrying.

Fixes: c6593366c0bf ("nfsd: don't kill nfsd_files because of lease break error")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 4fb5e8546831..52063f2cf0df 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1056,6 +1056,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			status = nfserr_jukebox;
 			goto construction_err;
 		}
+		nfsd_file_put(nf);
 		open_retry = false;
 		fh_put(fhp);
 		goto retry;

-- 
2.45.2


