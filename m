Return-Path: <linux-nfs+bounces-17600-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B97ED03B86
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 16:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACBFE30DD8B1
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9033546524A;
	Thu,  8 Jan 2026 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WtBzGRd4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6685C461DC9;
	Thu,  8 Jan 2026 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875621; cv=none; b=DOyGX9dGIObFwRNBbCcBsr5w4pKLeIDl5d37rlf785gNgcK7O0kVrgCJIuz8wFiT59BQ0kEuOv6VcJ6gnYzbDblzR/GQ6HJhzRMPP39gyQ0B1VKkiMGyfJ3e/ZHJAyX6MDE0LpTdhMTg6qKvDQqRyVHW75t1t9QusCTOx7zhbhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875621; c=relaxed/simple;
	bh=cJFaIr4HGB3WP3VVwcBCTmnx7s1FJJHpbeS1/rfSLpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tx+Dav6rriS1/VrmD6p12tU4yuof4J71K7SmXlyuGakFXtdgD/BQ+g5tL7NMfzvzcezqBoPG1/18EKHMBMJ0f2Ub7abxpOaZ4yaAWNsAMRHhlyfkq2k1bwA9NVFBRoWkrM8jvSbf27zHaiui7S7R/ud25n3e115E0IicNh++/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WtBzGRd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5091C116C6;
	Thu,  8 Jan 2026 12:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767875621;
	bh=cJFaIr4HGB3WP3VVwcBCTmnx7s1FJJHpbeS1/rfSLpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WtBzGRd4GkpAfxa0Ap64aeGxR6W3E95s+gm86vHz5c9Ded+kZCwFgqtyKhuOhglwg
	 4IUO8llzJxZXXRWB12Ve+Z65OmOteDKaJ354a1V6uLxA7VIHwyJne1I5aJ8uYkM9i1
	 W5zwQSOd2VuqUAkKIHxLVDVD6THFrzQGZW6LlMv8=
Date: Thu, 8 Jan 2026 13:33:38 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chuck Lever <cel@kernel.org>
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 6.6.y 1/4] nfsd: convert to new timestamp accessors
Message-ID: <2026010810-obsessed-superior-9b56@gregkh>
References: <20260103193854.2954342-1-cel@kernel.org>
 <20260103193854.2954342-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260103193854.2954342-2-cel@kernel.org>

On Sat, Jan 03, 2026 at 02:38:51PM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> [ Upstream commit 335a7be84b526861f3deb4fdd5d5c2a48cf1feef ]
> 
> [ cel: adjust to the 6.6.y version of fs/nfsd/blocklayout.c ]
> Stable-dep-of: 24d92de9186e ("nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---

Is this really commit 11fec9b9fb04 ("nfsd: convert to new timestamp
accessors")?  if so, what happened to the original authorship and other
signed-off-by lines?

thanks,

greg k-h

