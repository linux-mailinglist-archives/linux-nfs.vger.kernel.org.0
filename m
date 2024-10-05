Return-Path: <linux-nfs+bounces-6882-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B54B69917A3
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 17:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07BD1C21294
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F793156256;
	Sat,  5 Oct 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQHy39fD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCF4156230;
	Sat,  5 Oct 2024 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728141309; cv=none; b=RQbGB8qK5Xd9tt1XEn+I8IlokRdaD9AKXlzY57D8MpKuplmwMATykoj/DlEupIx4EHdp1/5ZFXF+Q+jp60ImAASwlABwo8somBFs997L1uzzVLbvl4HyIkL5QamCHkBvGZJ6uUsUBnw4Wnfh37BbmVaVWBCJdP88tK9sM9tZ+KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728141309; c=relaxed/simple;
	bh=zAX1tBTPbKZuceMnCR5NDHHWYehnmwWoEK3dYsgje/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMWui5JWNgYbQYakxv0w/fZtMXnUAi4FRAQNuUQr6d8ZOsJ2mk6REj+53/6vBJEkX0b5MubSuL/u5Zl2D4BpNCqOGZ0F5Zx2GuCl7B7B5u5t0ZjH9Eh0Zz3yeCxRirgo521khNAoxA5JgPRKsnDu4p2BqKeW0WlzuGEH1l3hFJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQHy39fD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C12C4CEC2;
	Sat,  5 Oct 2024 15:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728141308;
	bh=zAX1tBTPbKZuceMnCR5NDHHWYehnmwWoEK3dYsgje/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQHy39fDvWyBTZYO16JtDpkE8o6Uqh7jRiFO2wSSbRuhtEzvbJS7hl1M1COsF0Ae7
	 AKHCeNbPE5tqTKJRSACYObVNAf6ZlfVbPzraQ/oaVmzLZ7BoZL1Pi2zcum30pJ5SqV
	 DOKhE3evTIv6KlrmaioAkpvLqHq22rt9iyWPqtzFKYtlMj7og7FA97DSAy99NtvVLB
	 Kk74Y3jW/+6ealdBsf+EoP2l3ZxXhJgzqj9FZAzB+lPNibkt1doorbzTEdv12Ob3es
	 L8ShZzB7ZTEDkSCs4hUyGWYTZykINM09wGVxkSOFNI8zGIwqubly6q0LfVI3uRa79v
	 0jyLgf/K4I8Sg==
Received: by pali.im (Postfix)
	id 6C708648; Sat,  5 Oct 2024 17:15:02 +0200 (CEST)
Date: Sat, 5 Oct 2024 17:15:02 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] nfs: Fix mounting NFS3 AUTH_NULL exports
Message-ID: <20241005151502.faykeqi2yqprvufo@pali>
References: <20240912130220.17032-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240912130220.17032-1-pali@kernel.org>
User-Agent: NeoMutt/20180716

On Thursday 12 September 2024 15:02:15 Pali Rohár wrote:
> Linux NFS3 kernel client currently has broken support for NFS3
> AUTH_NULL-only exports and also broken mount option -o sec=none
> (which explicitly specifies that mount should use AUTH_NULL).
> 
> For AUTH_NULL-only server exports, Linux NFS3 kernel client mounts such
> export with AUTH_UNIX authentication which results in unusable mount
> point (any operation on it fails with error because server rejects
> AUTH_UNIX authentication).
> 
> Half of the problem is with MNTv3 servers, as some of them (e.g. Linux
> one) never announce AUTH_NULL authentication for any export. Linux MNTv3
> server does not announce it even when the export has the only AUTH_NULL
> auth method allowed, instead it announce AUTH_UNIX (even when AUTH_UNIX
> is disabled for that export in Linux NFS3 knfsd server). So MNTv3 server
> for AUTH_NONE-only exports instruct Linux NFS3 kernel client to use
> AUTH_UNIX and then NFS3 server refuse access to files with AUTH_UNIX.
> 
> Main problem on the client side is that mount option -o sec=none for
> NFS3 client is not processed and Linux NFS kernel client always skips
> AUTH_NULL (even when server announce it, and also even when user
> specifies -o sec=none on mount command line).
> 
> This patch series address these issues in NFS3 client code.
> 
> Add a workaround for buggy MNTv3 servers which do not announce AUTH_NULL,
> by trying AUTH_NULL authentication as an absolutely last chance when
> everything else fails. And honors user choice of AUTH_NULL if user
> explicitly specified -o sec=none as mount option.
> 
> AUTH_NULL authentication is useful for read-only exports, including
> public exports. As authentication for these types of exports do not have
> to be required.
> 
> Patch series was tested with AUTH_NULL-only, AUTH_UNIX-only and combined
> AUTH_NULL+AUTH_UNIX exports from Linux knfsd NFS3 server + default Linux
> MNTv3 userspace server. And also tested with exports from modified MNTv3
> server to properly return AUTH_NULL support in response list.
> 
> Patch series is based on the latest upstream tag v6.11-rc7.
> 
> Pali Rohár (5):
>   nfs: Fix support for NFS3 mount with -o sec=none from Linux MNTv3
>     server
>   nfs: Propagate AUTH_NULL/AUTH_UNIX PATHCONF NFS3ERR_ACCESS failures
>   nfs: Try to use AUTH_NULL for NFS3 mount when no -o sec was given
>   nfs: Fix -o sec=none output in /proc/mounts
>   nfs: Remove duplicate debug message 'using auth flavor'
> 
>  fs/nfs/client.c | 14 ++++++++++-
>  fs/nfs/super.c  | 64 +++++++++++++++++++++++++++++++++++++++----------
>  2 files changed, 65 insertions(+), 13 deletions(-)
> 
> -- 
> 2.20.1
> 

Hello, month ago I have sent these fixes for NFS3 client AUTH_NULL
support. Are there any issues with them?

