Return-Path: <linux-nfs+bounces-6418-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4630297735F
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 23:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C109FB21357
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 21:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157901C2314;
	Thu, 12 Sep 2024 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVnMfy2m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07586F30B;
	Thu, 12 Sep 2024 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726175472; cv=none; b=LktLq+SznQVmT0R0XSjfU4ZpT6di61Q93Pjkiw0zaX0mV+hmEXPv9vF8NZXUNkK/mEi4hdUBKbVKlb9huXZRSq7NuJ6Lx+o+BNevEWxuG+ckb2jzqu69yC6aJw3gT3A9wfu+TDXlDdnV77qaDI5HmaRfE/2s6DmcobpPbnJMSS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726175472; c=relaxed/simple;
	bh=2As3YcV87aGciE6ArbRCpb0o3izQVEQHoUfMUN6G7Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6DVuJsThDoViOjQVyMwygBudbzb8XfttppyL9HjPRBAzFbdP3fLjVEJ53j+yDMSDYxTiq9/PknmQjoznd5fv2XUtAHqGtWP+xhdIlt4fn46pyZxBMDv08TZLmnc4cNDMpFyIgRYuHSNp9cMIlADARikXD+Svao464hOP9bLdf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVnMfy2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56243C4CEC3;
	Thu, 12 Sep 2024 21:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726175471;
	bh=2As3YcV87aGciE6ArbRCpb0o3izQVEQHoUfMUN6G7Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DVnMfy2mgG2YxnUfZh4QeORAVB0r2IvKnjuj+/IA0IwpJy926rbj3fKHsAgN/aKAu
	 MhToU7PM3AaakLY1Oj0gW9q6V6S3w0vfrAS0dMnqPLXirYCMsKc4KJulvCbBOwc5v+
	 3B5ZT0XWAV/ZogFUb+xqA9ZMH/cUH7w+za47qZHkhYxpeV/UuuH02JVplDUnG4FkXu
	 kLnJVZu4b1hb7Fw2lDQgf/C7g7AQXaLORS0v5RuBDpYNSdjdORlV5GCzJBL1j6M4Ck
	 meAx8Wsardw92fgW1z+Ob6S8gu2xIz+DHIQ1Njj2sMqmYYp0XXPc6nTHnraKQmeVRf
	 2Ma3b5pZY4pdQ==
Received: by pali.im (Postfix)
	id C6DCF5E9; Thu, 12 Sep 2024 23:11:06 +0200 (CEST)
Date: Thu, 12 Sep 2024 23:11:06 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] nfs: Fix mounting NFS3 AUTH_NULL exports
Message-ID: <20240912211106.2osqf5voyyjlran7@pali>
References: <20240912130220.17032-1-pali@kernel.org>
 <eb6a1739-6086-4ebd-a5dc-03bedc3a12a6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb6a1739-6086-4ebd-a5dc-03bedc3a12a6@oracle.com>
User-Agent: NeoMutt/20180716

On Thursday 12 September 2024 17:06:07 Anna Schumaker wrote:
> Hi Pali,
> 
> On 9/12/24 9:02 AM, Pali Rohár wrote:
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
> 
> Why fix this on the client instead of fixing the server to announce AUTH_NULL
> if this is what the user has configured?

This can be a next step. Without this client workaround it is not
possible to connect with Linux client to existing/running servers.

> Anna
> 
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

