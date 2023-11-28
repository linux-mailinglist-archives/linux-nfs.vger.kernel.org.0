Return-Path: <linux-nfs+bounces-139-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59B87FC8E4
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 22:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908042825E7
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 21:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52D4481A9;
	Tue, 28 Nov 2023 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+PFWgt9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C582644390;
	Tue, 28 Nov 2023 21:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D236C433C8;
	Tue, 28 Nov 2023 21:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701208773;
	bh=huEW+29D3P6aPuKlMt45c6MMSHnwwncCdqop2pk2aa4=;
	h=Subject:From:To:Cc:Date:From;
	b=j+PFWgt9xYuvBN7Ytuk2eUZKpPJaWS66KXTKbdfdbBw1jyD16qVc7Ea8OoH4EMZvW
	 qMDaSREVxAxw5sojE6QieZdDNKbVa/6pDlsrWvC81jeW6QCIxG1KIIYHt0tA0gQik2
	 UD0uCmS++CDhgPUvoyirHt++N8/vVYofVaHgas+/ktGfZADvJPFYiD0bKjvIrddokl
	 VWFAD7ESxc1byyP2UC12/isZ2q5CFIzAgUCjRtbZ1tSWh4d0AyRL5h/CKDTIcH/S/i
	 uG4oueJb4Pj6BOoeoQ9U1qII6h7SpAf6CVLHzJoZJukF0iolJiZObvJAdqvS+L8/2U
	 FrgKtGD5h8Mpg==
Subject: [PATCH 0/8] nfsd fixes for 6.5.y
From: Chuck Lever <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Tue, 28 Nov 2023 16:59:32 -0500
Message-ID: 
 <170120874713.1515.13712791731008720729.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Backport of upstream fixes to NFSD's duplicate reply cache. These 
have been hand-applied and tested with the same reproducer as was 
used to create the upstream fixes.

---

Chuck Lever (8):
      NFSD: Refactor nfsd_reply_cache_free_locked()
      NFSD: Rename nfsd_reply_cache_alloc()
      NFSD: Replace nfsd_prune_bucket()
      NFSD: Refactor the duplicate reply cache shrinker
      NFSD: Remove svc_rqst::rq_cacherep
      NFSD: Rename struct svc_cacherep
      NFSD: Fix "start of NFS reply" pointer passed to nfsd_cache_update()
      NFSD: Fix checksum mismatches in the duplicate reply cache


 fs/nfsd/cache.h            |   8 +-
 fs/nfsd/nfscache.c         | 266 ++++++++++++++++++++++++-------------
 fs/nfsd/nfssvc.c           |  20 ++-
 fs/nfsd/trace.h            |  26 +++-
 include/linux/sunrpc/svc.h |   1 -
 5 files changed, 218 insertions(+), 103 deletions(-)

--
Chuck Lever


