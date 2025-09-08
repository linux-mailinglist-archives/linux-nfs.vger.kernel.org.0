Return-Path: <linux-nfs+bounces-14124-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C6FB491AF
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 16:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728361BC101A
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 14:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABE330DECE;
	Mon,  8 Sep 2025 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GecvrKCr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F530DD32;
	Mon,  8 Sep 2025 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342173; cv=none; b=l0T4A0z62KDwSUOpC1zcLTGL+oQzXjyorNH5p4P/lQFVfgsg6VKzIBc97fPkfo6WgA7Lqs5xKk0DR4fI9ujVSfeJicw47xWxgaiA3uxGGOFtQaSMQ4KTzbJfSvoDv9Vo4bF94NCAYCrsUHqsnnOLdPDZ1QzWGAIC5JBd9NsSCVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342173; c=relaxed/simple;
	bh=IcHaFmYPIwn2IjYx1XVFrnQPvNfMRP5HLn1n+kgrdik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZe9r0Xz4tBuL0Am1h4GD1T/wjU/01rL2nPqI0dJDLWxD9K61He6ONzqMu/7JbnwI65HKnDxtLIXGtyvlEJv+vIg1iZdi4jtlkDFehGxLza/tYB5Gp5OEo73SGk87ibtOl/0LGFQWoB1BgRhVyjlERZJXPL3Aa3ef28yk6MfVjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GecvrKCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477EBC4CEF1;
	Mon,  8 Sep 2025 14:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757342173;
	bh=IcHaFmYPIwn2IjYx1XVFrnQPvNfMRP5HLn1n+kgrdik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GecvrKCr0Tmzm3aYoURkGXvH2U3BtKdFTgwWqy9WfYm4IVOoAIC4EfbbknwlNOnYi
	 Q4OzJ98IWggOFXkRv0GcKU/uyqbieDWZKtu1M2m8RRw2pqYcYv3zct9IlUCjOvb3pt
	 TNfxQPpuyU5LR5BU3r325hBrlRUTg7ydJejFs2o1spim6PStF50EacJQApCykaZwTQ
	 eHqWOxFGITzHTm2/HlnOGNjUw2ZqkyZfoEYCyS9kdm7yzDHrhQPyE4T3LMvSHYkBZ1
	 p7jfNANvURMfsz/X/9nMNpygL251zNhuOHWX6qQ8NEUcSdheN3DM4lxxKy7ExcOr7V
	 MqzUMVkDyG5Nw==
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-crypto@vger.kernel.org,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH] SUNRPC: Make RPCSEC_GSS_KRB5 select CRYPTO instead of depending on it
Date: Mon,  8 Sep 2025 10:36:04 -0400
Message-ID: <175734214897.12169.10475464910212519496.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250906230019.94569-1-ebiggers@kernel.org>
References: <20250906230019.94569-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Sat, 06 Sep 2025 16:00:19 -0700, Eric Biggers wrote:
> Make RPCSEC_GSS_KRB5 select CRYPTO instead of depending on it.  This
> unblocks the eventual removal of the selection of CRYPTO from NFSD_V4,
> which will no longer be needed by nfsd itself due to switching to the
> crypto library functions.  But NFSD_V4 selects RPCSEC_GSS_KRB5, which
> still needs CRYPTO.  It makes more sense for RPCSEC_GSS_KRB5 to select
> CRYPTO itself, like most other kconfig options that need CRYPTO do.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] SUNRPC: Make RPCSEC_GSS_KRB5 select CRYPTO instead of depending on it
      commit: b3560ad8e52b87cdbd858ec279429276695c1e48

--
Chuck Lever


