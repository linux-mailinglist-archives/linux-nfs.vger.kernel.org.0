Return-Path: <linux-nfs+bounces-13090-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A4FB06969
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 00:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D2656502F
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 22:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCF1288C09;
	Tue, 15 Jul 2025 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gpqsz4JU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EC417BA1
	for <linux-nfs@vger.kernel.org>; Tue, 15 Jul 2025 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752619973; cv=none; b=K2ELhfzXcbP17zxoJVklUgK2qxRp+8fwTJEHc6XJf1rcV8QpzNsKds/cKXIAPL5P7HzxzjZaIt9Js4T1iy6j6qq5dUeuv5EnkA7ebboIvnDYPdRKOwYRHHmclDfGKoXemLYVaFY9lv4hh0PsqbHHGGFGSMn/dGamKQYHLLMXl8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752619973; c=relaxed/simple;
	bh=acELB+5SJs4Lu61cI82nuY6XcoHBUDvyN6vJoVeSLPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAcDwbhUqIB6psMkpQSpcZhnR4DwjgfXESTivJo6+FX2RsZoW1P88TGjN1IOEL/9yskqUpLawl651a6Upqpzxhx9vX/ocf7qypPj1TUrB/GjkUbgxbknNCvu0sU7zGAnadTS9b/H2wPtvWBCDoCYtjj54StK9bfeEQIBENXu/qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gpqsz4JU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E53C4CEE3;
	Tue, 15 Jul 2025 22:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752619972;
	bh=acELB+5SJs4Lu61cI82nuY6XcoHBUDvyN6vJoVeSLPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gpqsz4JUlj+C6voUARkq5ED21YnCBZwpPg6fyF5FcXWkr9ZXaJaPXBniMuyakLcBZ
	 OERfyenp+B49fZzDjcz97wv8uJnF2d+ypHJt/AZj84emsTi1gZSZj0hH92+8qn3XBe
	 Vn+igqF6eyPj7WFJH9A37HhaewcYEs2Qbo4/CI2C7OGVKMjnXdci6IbyW/BwKR5W95
	 bdda2OATCi1FrAZfnLWbDKAHTx/rh88INS229mNcVxLsszPmVQoRsaW9KBB155oqXS
	 +4Uc1ewbDZRDNPhV4M42ZQbVc9P9PFsAq5WZR9dZa51J7qwZ5Bg4IZucbHy2ROmQro
	 JRph3dTVUs6Ow==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: NeilBrown <neil@brown.name>,
	Mike Snitzer <snitzer@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] Fix localio hangs
Date: Tue, 15 Jul 2025 15:52:47 -0700
Message-ID: <cover.1752618161.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aG0pJXVtApZ9C5vy@kernel.org>
References: <aG0pJXVtApZ9C5vy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The following patch series fixes a series of issues with the current
localio code, as reported in the link
https://lore.kernel.org/linux-nfs/aG0pJXVtApZ9C5vy@kernel.org/

Trond Myklebust (3):
  NFS/localio: nfs_close_local_fh() fix check for file closed
  NFS/localio: nfs_uuid_put() fix the wait for file unlink events
  NFS/localio: nfs_uuid_put() fix the wake up after unlinking the file

 fs/nfs_common/nfslocalio.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

-- 
2.50.1


