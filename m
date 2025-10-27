Return-Path: <linux-nfs+bounces-15670-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14403C0E051
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45AB405255
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1862D8760;
	Mon, 27 Oct 2025 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeHGMWtO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A569296BDC
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571661; cv=none; b=NrSlRGnC2POMu0nx+p7JbzmDI6JAWAbcb3aQ0IEF+ZS5behz/lrTaJ8cChwCVLLIMr7QEWdUi6Iy3Unqz/N0XTgIboYFnQeC6Ux7kqPu+IQWgNHECHlB1CtaZMpE4Szfkg2WPzXkRNDYHy08uCFkyJiV2AdwUm5xJireyL9vXAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571661; c=relaxed/simple;
	bh=qT9xbWAYJaXyx8sGN3amUTEjSy1FYoxHOz8TgMZNWF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xa3hBh7mJMuft3fXDSzukvDSgjHFZB8CjrlXeGOng4x9E2TM7q/zvwbVcB+1CV7yZVLmuYF1PxNVW5AArBjnGirviD45EtdvFqqtNma+0ld9qJvDKa+v7emKq8S+T4YtRhtvj48JtfFnR3eUq5VHGGMJmWFiiFRX99di6fmhCNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeHGMWtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF923C4CEF1;
	Mon, 27 Oct 2025 13:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761571660;
	bh=qT9xbWAYJaXyx8sGN3amUTEjSy1FYoxHOz8TgMZNWF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GeHGMWtOeWuyI71rsGWX5zXIeaRvRGjCcSx2yRTm8qrvXPyzSXgZXX5EYQbfCdbP5
	 +6K3YIqvPsfWNm3ZCvKPBlxjmFdMVuRKIbrTVR0B8VL7Ni2euB2fs+D9wYpsAb+8aR
	 gAioQNLDDDSAddGLAKnFNhG36IFI5w9Xnp8xKIWd2FANCN9YJ8m2irLF8dKLqztpEy
	 gvhLv3rH+3cVqhU5WhU+Gupvbhw8PheamV5SSRqSRdDtcbu3nK1wThP5fWQkJpb2bE
	 P3UuWGn8OL6FK7zJnWd1lgeBqDo9SFFUpoV8QcwjtsD3uuYaaWL5T6GlH+BmSlk5b4
	 W/GlgUuRq/+Pw==
Message-ID: <d56f3b5c-2628-4714-8e77-7e904c169e90@kernel.org>
Date: Mon, 27 Oct 2025 09:27:38 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
To: Christoph Hellwig <hch@infradead.org>
Cc: Mike Snitzer <snitzer@kernel.org>, NeilBrown <neil@brown.name>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-15-cel@kernel.org> <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aP8pfpm6jb-Hj92B@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aP8pfpm6jb-Hj92B@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 4:12 AM, Christoph Hellwig wrote:
> On Fri, Oct 24, 2025 at 03:34:00PM -0400, Chuck Lever wrote:
>> This looks like an xfs-specific fix. I'm reluctant to apply a fix for
>> a specific file system implementation in what's supposed to be generic
>> code.
> 
> It's not a fix, it is a performance optimization.
> 
>> If (IOCB_DIRECT | IOCB_DSYNC | IOCB_SYNC) /is/ correct for all file
>> systems, then it needs an explanatory code comment, which I'm not yet
>> qualified to write. I don't see any textual material in previous
>> incarnations of this code that might help get me started.
> 
> IOCB_SYNC always needs IOCB_DSYNC as I explained three times now,

It wasn't clear to me until now that:

a. The reason to add SYNC in this case was only for DSYNC

b. Even after an IOCB_DIRECT write returns, there is more work to be
done.

So I stand corrected.


> including a detailed analsys of all users (We really need to rename
> IOCB_SYNC to __IOCB_SYNC to match __O_SYNC to make this more obvious
> I guess..)  I still don't understand why we need sync behavior and
> forced stable writes at all, though.
> 


-- 
Chuck Lever

