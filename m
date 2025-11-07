Return-Path: <linux-nfs+bounces-16171-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321E5C40674
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 15:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE323AA891
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 14:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A362E6CCD;
	Fri,  7 Nov 2025 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZ/eKImN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E2532720F
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526326; cv=none; b=M4JWtbTl5eKF4Y95vdfdcGYCjgAjbTi9zw5U/WsX8e+tkNxwmcLYwRUjg+AtuNCPvg0pItSqhrMdHCkwJXbkSrk+HF8kSlNbODy/GN70LFAx3svDLKmjOgUqueJPOOOPGIP4ETKoBWC6jYRZs8C8ulvj+iHrAAbj3Fah8sFVDRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526326; c=relaxed/simple;
	bh=S9y3EsJhC1+WFDZ7FHIamQHgQ2VLeb2c/mPrJKigT18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SD4V8rDtRVdKQnNSP/Cbbcrwsg+mDtCpmgTpcyTUx2ZcCMG+GQJoG+vgfyIpeuB4xy3ErFuBdlMFiN9HEBR0FjLJ07y03RpGU30wO2FV73REOd+vS/5Nq3KYKLNdgX15Vq62WRvIU9pajD47pzAoAxti1IzQ/Wo0K8PDWmE3o/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZ/eKImN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5507C16AAE;
	Fri,  7 Nov 2025 14:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762526325;
	bh=S9y3EsJhC1+WFDZ7FHIamQHgQ2VLeb2c/mPrJKigT18=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qZ/eKImNiRl8W+ftHtmS47TMkxsvvDy2K3rrvcF2tVW2CIra7en0UGtyplhMiSeKz
	 EeCQdGDmhWZY9thrfNxF2/PktgTN1ZshS6PWESuAb/Mx8ZMXw4C0nLA1N8FIODGncl
	 SFA27fA/Xzb1JBep3H86WRoDObXStHkkYbKWU0AYdpRjejXioh1H+/kGZTH8sxeX82
	 FI1ueqqoY+mb3HJP5fHPp40lMq1gxPiosOGcV4uQdfFL/FX/CCmoggZb6xj3vlZm79
	 /lvkQk1RkyIGUyTGeiyMfMVNQocZLx+r3Y7rgi0DXKIq5q7bEtc4knmPYv/f9mc6jl
	 1JJjnKLgsfEYA==
Message-ID: <60402263-4336-42e0-acfc-7f1cab6c1742@kernel.org>
Date: Fri, 7 Nov 2025 09:38:43 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20251105192806.77093-1-cel@kernel.org>
 <20251105192806.77093-5-cel@kernel.org>
 <176242391124.634289.8771352649615589358@noble.neil.brown.name>
 <aQyfgfWu8kPfe1uA@infradead.org> <aQyn-_GSL_z3a9to@infradead.org>
 <aQzRdTcyc2nhTWqj@kernel.org>
 <e0723227-6984-4c04-be7c-c3be852a8607@kernel.org>
 <aQzwvqlD0xiYjMCW@kernel.org> <aQ3zFRizxIa-Hk6F@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aQ3zFRizxIa-Hk6F@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/25 8:24 AM, Christoph Hellwig wrote:
> On Thu, Nov 06, 2025 at 02:02:22PM -0500, Mike Snitzer wrote:
>>>> Selectively pushing the flag twiddling out to nfsd_direct_write()
>>>> ignores that we don't want to use DONTCACHE for the unaligned
>>>> prefix/suffix. Chuck and I discussed this a fair bit 1-2 days ago.
> 
> Please document why.  Because honestly it makes zero sense to do that.

There is a slow-down. But it's not like using DONTCACHE on the unaligned
ends results in a regression, technically, since this is a brand new
feature.

So for an UNSTABLE unaligned WRITE in NFSD_IO_DIRECT mode, the unaligned
ends would go through the page cache, and would not be durable until
the subsequent COMMIT. Using DONTCACHE for the end segments adds a
penalty, and no durability; but what is the value we get for that?


> But if you insist, at least write a detailed comment why you don't want
> that, so if people have to debug that odd decision in the future they
> at least know why it was taken.
> 
> The rest looks ok to me.
> 


-- 
Chuck Lever

