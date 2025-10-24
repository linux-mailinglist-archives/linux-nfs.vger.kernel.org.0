Return-Path: <linux-nfs+bounces-15582-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EC8C06932
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 15:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43A41C083EA
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72190314B65;
	Fri, 24 Oct 2025 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3QVtV4t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914D22B8BD;
	Fri, 24 Oct 2025 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313872; cv=none; b=JMMAFrINcyIfBEj5wZirUQefoQX72JMTUsLJAyeu2QjVVCtuc7bnSPRIFgxiwGI/NZmtj9mWbc6t0NP1KlCM9oAFhiNZCRz3gweaKvGr8wGV1I9sq8d11TnZkdI7CTFHT459GuopO/wU44A465ezDFrxQ3lfExREylEwvX4QvCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313872; c=relaxed/simple;
	bh=64YvDhefSevbMcA/Sn+pHamKEm3aD8Nx62jMfpAgGuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JuVGMNP2Uj7NWx0wxRx+OdH4QJoJaHqkXg6ts1HaDyfXud9ZChP70V1GcIJzjWYLrlUTeUvLOhnvgi2O2Hd1q974+yGY5+hrlMeR7lf28q3m3pMeJoynV6Jl3P6g1vVRJxwpiCGuzSl2Z2ukzJEnqHIy/0wIPCaR2FnKzYbvEmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3QVtV4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E84C4CEF1;
	Fri, 24 Oct 2025 13:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761313871;
	bh=64YvDhefSevbMcA/Sn+pHamKEm3aD8Nx62jMfpAgGuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C3QVtV4tOhpT9QHhZ8209n13c4bcIE4R1/ZZ4h4AgrB/eK4HSZBlfdVV04vANsFhJ
	 n39UMi7pvZ7DAXAfu/1MVhKH+O3Pbr8qszWEOu9l5zqq12SFz3eITMavRr9VXqyDTJ
	 GzFE3dDuztJp5ZhtHuM0GutoaDi+iJSrjnk53bgV1xW2D92JUmsznwlhToMT6GTv/B
	 KiX+lBQrhS0z5/DrL0Eq9Rux0wgxspB6575QG9vU7x+m6nfc0gMwW1oH53e0/FXQz3
	 UIyrKzJ9ez0mgYXG9c8bXqxxn8v0P/cLddAleog+gT5HxYiWgLBXdiWlKcsKD6vdBc
	 U2oqcHu0OZ5zQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockd: don't allow locking on reexported NFSv2/3
Date: Fri, 24 Oct 2025 09:51:08 -0400
Message-ID: <176131386154.34431.8507848314830746497.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023-lockd-owner-v1-1-1d196b0183d1@kernel.org>
References: <20251023-lockd-owner-v1-1-1d196b0183d1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 23 Oct 2025 09:12:39 -0400, Jeff Layton wrote:
> Since commit 9254c8ae9b81 ("nfsd: disallow file locking and delegations
> for NFSv4 reexport"), file locking when reexporting an NFS mount via
> NFSv4 is expressly prohibited by nfsd. Do the same in lockd:
> 
> Add a new  nlmsvc_file_cannot_lock() helper that will test whether file
> locking is allowed for a given file, and return nlm_lck_denied_nolocks
> if it isn't.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] lockd: don't allow locking on reexported NFSv2/3
      commit: 49d93cbe598561458a1da11dceb2e26891d019e3

--
Chuck Lever


