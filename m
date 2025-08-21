Return-Path: <linux-nfs+bounces-13863-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C241B3083E
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 23:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105391D02FFB
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 21:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898CB1AE844;
	Thu, 21 Aug 2025 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm2c6vdb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642C92C0276
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755811055; cv=none; b=JYg5hiVyZ2ezkRn1pziLAbemf3ayfkjd+UvKYqqLade/6SthB1Ea4qfUgJCPFwSlFueUON6AmxvgJaGm+FkTwQ/MksicFFesCJyixD9wOhHdOiGC7CVwK4SOYSQ/J35Kpo3UjrSqMASTw5LEeDTwAyMV1Xal2ftezLrTrh2BmE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755811055; c=relaxed/simple;
	bh=wfPHdiCADGzk5F1BAV9uGytJ6f0+gzeS2A8uyfAz2rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxKGQTPMoTv2aViRrcoUNKUvM5szcREkfccNvql0YZsB53wv9zSKNepdezrrmZOgKUfq0PdTKNgWUI0ZTTApsVjLwN4iHzJ3Z1+G8cCeMUjRKkk4T9UvEQPAuR1bSoaS+mSrPSXqWLhyFqD0yPV9aB6ytXr6wpZ9LMBostr7/0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm2c6vdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA26C4CEEB;
	Thu, 21 Aug 2025 21:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755811055;
	bh=wfPHdiCADGzk5F1BAV9uGytJ6f0+gzeS2A8uyfAz2rE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gm2c6vdbKGFD8hfVhHpbd0+SryvHM5XHZ8OAqViOu15PnQciNqXpx8rKUtPhMcyRG
	 Q57Mz5+knLqhUFr6PxgatVF5f6TAr9CWRXA+46m2085ZAjvhmWP+jksx3rDQqp13MG
	 RkAJOnskTlwY4LpY/k7o3I/HDsGYkut+8HtpUcRFwIOJKPENs4dsuD4Nw7XPu7LIXd
	 h+ZX2UwMdjkh0wIiIr9R/DvUKlWLq6M3PWUDUW9UMVkFpk+eU5+JRarG7sfWYbE3zM
	 dfYoBsVJDkxO/4CFbeeQautdJkhNo4Fljmy/Bd9yZCAOGfr2xcXL3IwpRnT2Z4XdHO
	 pbxpSEmU5wQ/A==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: Re: [PATCH v3 1/1] nfsd: nfserr_jukebox in nlm_fopen should lead to a retry
Date: Thu, 21 Aug 2025 17:17:30 -0400
Message-ID: <175581102402.10816.4101195051711071670.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250821203146.88671-1-okorniev@redhat.com>
References: <20250821203146.88671-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 21 Aug 2025 16:31:46 -0400, Olga Kornievskaia wrote:
> When v3 NLM request finds a conflicting delegation, it triggers
> a delegation recall and nfsd_open fails with EAGAIN. nfsd_open
> then translates EAGAIN into nfserr_jukebox. In nlm_fopen, instead
> of returning nlm_failed for when there is a conflicting delegation,
> drop this NLM request so that the client retries. Once delegation
> is recalled and if a local lock is claimed, a retry would lead to
> nfsd returning a nlm_lck_blocked error or a successful nlm lock.
> 
> [...]

v3 applied to nfsd-testing, thanks!

[1/1] nfsd: nfserr_jukebox in nlm_fopen should lead to a retry
      commit: e2c1565f8bbc6df4f95257dc9c889c41d619d5ff

--
Chuck Lever


