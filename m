Return-Path: <linux-nfs+bounces-17888-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCD3D210C7
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 20:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87B0D3029D19
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 19:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826D32C08D0;
	Wed, 14 Jan 2026 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cK1KQ8Lx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF0823184F;
	Wed, 14 Jan 2026 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768419229; cv=none; b=Jts/uEVnQqmJsZZBfKtTwiXYS6jaKNuLPCZUcT8UZc2iGpGdJYtz+B9r0xDfmAZZvpPI6BZNUXeKPRNMtFXWWrM03I2kbtExoEm3M02YkeAFYJRK304g7QCtaMDAM1h93TXiv8TygKBVIyF9oZWKpQk7x2Z3DQkp7x7OxH3sgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768419229; c=relaxed/simple;
	bh=xY3iIzPhtaiF+EsMrQLvAloewetnMcqRE6PH9WSOtVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRbgKpo9V4emIVe7r1cqL9NAN5qDqamWl+6x6pOV1JYJstcEHKQNPHein/s7Ts08PWa+W/8oL4OTNxkPmPsThF7PHboQLn6ysKKCgXoC8yK4eFYZzQQiQrcZlCHvb7yO0kcXcJkQFTEBIvjMXg0B/uITW/LmCO/ZCWPhD93eJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cK1KQ8Lx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F113EC4CEF7;
	Wed, 14 Jan 2026 19:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768419228;
	bh=xY3iIzPhtaiF+EsMrQLvAloewetnMcqRE6PH9WSOtVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cK1KQ8LxDz6aSiavo1+WwokRwj434qzgFfG60IpQW4EDTFcqnY7doUiRI9qOaEupj
	 857aKtHZ/03RPlw6rIG77FxR2BpQBVEyVchKGeoh2DyEXaFeEdkbJUKheLYcmygygc
	 nNDvkx2owsr2xK0rgRLKeXzIKx5QkUCX9eqFMp9l48TPa2VJu9hcGvFgPMue0P5nM9
	 Hm5YDZkB1EF0GnDKdAtuuycghKA8Y80v23YjuF32QFXL1jl0RUFg+R5gbn59sS1ao8
	 KrzqnvXTFsQVY4cG+pzRuEy3tXUGJCPAgR9MJ3C5z/R2j0Z3AEzzVtx6D3m42op83e
	 I7gOcANJWRZNg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Ben Coddington <bcodding@hammerspace.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] nfsd/sunrpc: fix up some layering violations
Date: Wed, 14 Jan 2026 14:33:44 -0500
Message-ID: <176841919290.418760.6153318776379161550.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113-rq_private-v1-0-88ed308364e6@kernel.org>
References: <20260113-rq_private-v1-0-88ed308364e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 13 Jan 2026 13:37:38 -0500, Jeff Layton wrote:
> The rq_lease_breaker and rq_cachetype fields are only used by nfsd.
> These patches shrink struct svc_rqst slightly and makes the layering
> between the two a little cleaner. In the case of rq_lease_breaker, I
> think this also gives us a little more type safety.
> 
> 

Applied to nfsd-testing, thanks!

[1/2] nfsd/sunrpc: add svc_rqst->rq_private pointer and remove rq_lease_breaker
      commit: 2f9a5cd51d92cd95270edfa45c11ddfce1f8e169
[2/2] nfsd/sunrpc: move rq_cachetype into struct nfsd_thread_local_info
      commit: a5428a9e04ffc2b7907cd976202d9fc28c7455f1

--
Chuck Lever


