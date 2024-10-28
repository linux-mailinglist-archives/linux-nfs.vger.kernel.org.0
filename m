Return-Path: <linux-nfs+bounces-7524-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D536D9B2C12
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 10:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135571C21FF2
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 09:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405EE1D0E38;
	Mon, 28 Oct 2024 09:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5ts1+se"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097A1D0BA3;
	Mon, 28 Oct 2024 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109302; cv=none; b=MAZxQ7Nr1vs1LksKnaAhRGHy6bbAKxnANA8U2CeX8oPOWzbSR8fnEdOtQCIKnkvwHDnEHc3lDgl4M7CLzo1REbFZLVgnzsrnu0gYtjCM2zBCFMWnQKZfnhZHvaY5EV9Kk8JtqWFDqXz8EpNugg+Xz5fXS6vqOdkf8lvQUMMGHpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109302; c=relaxed/simple;
	bh=amORD4RMTEf7bWApzZm/4zs9Mo3EkYO1PmZXMDW6IeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggvL2GxdoBx7X1d80xd5o41lAtqk5dGoa8fPsT3/zkqcajMFG5NZKUN8K3g8cDCAFQi8yH1kyQURAcTKinKe5XsHVnQCtvnTVqc5OLd5a9J89I+EJmeAD5Ozt7b+Wy8PH0n5Hv6gyPvrX1fko03vY9shJOiLZFzUtq501zMjhOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5ts1+se; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEFFC4CEC3;
	Mon, 28 Oct 2024 09:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730109301;
	bh=amORD4RMTEf7bWApzZm/4zs9Mo3EkYO1PmZXMDW6IeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j5ts1+se/GWiAIDF5X5wFHbeqknjsi7oQRNzA8tAUTTJwGhf72XTjf3BOqWWNHcdq
	 o+lpyu37H6OjNRmScVpLTRnjo48hjudJ/7wfUr9JlBOr11UQtV0H7g98yXia0bngpU
	 QrZetOWY2f/K3Imh9HmU4JY8YOMu7Whp/DIC04TwWPgpY3Th5xd6I+nkHp2qIhlUcd
	 w6DwHGmPUIvdaIR4XpfMb+lkBgCD//1hDoFv99pEMhkXdKmEFxaHk+HbwotSk1Zmvu
	 rirEyUHWLSex2Qw1/N52qJsoJpuQFaqAg6VqUNVg2h6n9eaWP10hKeQnctEajmkumy
	 zbrG938Qcz8NQ==
Received: by pali.im (Postfix)
	id 4464BA58; Mon, 28 Oct 2024 10:54:54 +0100 (CET)
Date: Mon, 28 Oct 2024 10:54:54 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] nfs: Fix mounting NFS3 AUTH_NULL exports
Message-ID: <20241028095454.igieglqw4cdgx3nt@pali>
References: <20240912130220.17032-1-pali@kernel.org>
 <20241005151502.faykeqi2yqprvufo@pali>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241005151502.faykeqi2yqprvufo@pali>
User-Agent: NeoMutt/20180716

On Saturday 05 October 2024 17:15:02 Pali Rohár wrote:
> On Thursday 12 September 2024 15:02:15 Pali Rohár wrote:
> > Linux NFS3 kernel client currently has broken support for NFS3
> > AUTH_NULL-only exports and also broken mount option -o sec=none
> > (which explicitly specifies that mount should use AUTH_NULL).
> > 
> > For AUTH_NULL-only server exports, Linux NFS3 kernel client mounts such
> > export with AUTH_UNIX authentication which results in unusable mount
> > point (any operation on it fails with error because server rejects
> > AUTH_UNIX authentication).
> > 
> > Half of the problem is with MNTv3 servers, as some of them (e.g. Linux
> > one) never announce AUTH_NULL authentication for any export. Linux MNTv3
> > server does not announce it even when the export has the only AUTH_NULL
> > auth method allowed, instead it announce AUTH_UNIX (even when AUTH_UNIX
> > is disabled for that export in Linux NFS3 knfsd server). So MNTv3 server
> > for AUTH_NONE-only exports instruct Linux NFS3 kernel client to use
> > AUTH_UNIX and then NFS3 server refuse access to files with AUTH_UNIX.
> > 
> > Main problem on the client side is that mount option -o sec=none for
> > NFS3 client is not processed and Linux NFS kernel client always skips
> > AUTH_NULL (even when server announce it, and also even when user
> > specifies -o sec=none on mount command line).
> > 
> > This patch series address these issues in NFS3 client code.
> > 
> > Add a workaround for buggy MNTv3 servers which do not announce AUTH_NULL,
> > by trying AUTH_NULL authentication as an absolutely last chance when
> > everything else fails. And honors user choice of AUTH_NULL if user
> > explicitly specified -o sec=none as mount option.
> > 
> > AUTH_NULL authentication is useful for read-only exports, including
> > public exports. As authentication for these types of exports do not have
> > to be required.
> > 
> > Patch series was tested with AUTH_NULL-only, AUTH_UNIX-only and combined
> > AUTH_NULL+AUTH_UNIX exports from Linux knfsd NFS3 server + default Linux
> > MNTv3 userspace server. And also tested with exports from modified MNTv3
> > server to properly return AUTH_NULL support in response list.
> > 
> > Patch series is based on the latest upstream tag v6.11-rc7.
> > 
> > Pali Rohár (5):
> >   nfs: Fix support for NFS3 mount with -o sec=none from Linux MNTv3
> >     server
> >   nfs: Propagate AUTH_NULL/AUTH_UNIX PATHCONF NFS3ERR_ACCESS failures
> >   nfs: Try to use AUTH_NULL for NFS3 mount when no -o sec was given
> >   nfs: Fix -o sec=none output in /proc/mounts
> >   nfs: Remove duplicate debug message 'using auth flavor'
> > 
> >  fs/nfs/client.c | 14 ++++++++++-
> >  fs/nfs/super.c  | 64 +++++++++++++++++++++++++++++++++++++++----------
> >  2 files changed, 65 insertions(+), 13 deletions(-)
> > 
> > -- 
> > 2.20.1
> > 
> 
> Hello, month ago I have sent these fixes for NFS3 client AUTH_NULL
> support. Are there any issues with them?

Hello, as there are not any objections, could you prepare these fixes for -next tree?

