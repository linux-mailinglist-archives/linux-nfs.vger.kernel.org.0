Return-Path: <linux-nfs+bounces-11789-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EC9ABAF27
	for <lists+linux-nfs@lfdr.de>; Sun, 18 May 2025 11:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9163BC127
	for <lists+linux-nfs@lfdr.de>; Sun, 18 May 2025 09:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734A6205E25;
	Sun, 18 May 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5gEip4Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD68610B;
	Sun, 18 May 2025 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747562259; cv=none; b=bxIXM7iuZ03gyiylhGyuw5jSWDW5+wVjXrCAaAYGfrvYII4vGSu0QZ1ryQDizyXhPUNKshQ/3R6Tw/xY7BrTJVi6UHnVKVVSP6Uid3wnef7ZNcj1MKkMeyovwW87Shw242Rf3QGXp8BAkIxkkbfxEveQVezUOcWBWGch6Hnbq5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747562259; c=relaxed/simple;
	bh=2guWlEnLnYfsa0rYUzzORZ1RYR7+Gd6K7S86SE5kPD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXVrSZ4Ekjmsnxk9PLHW1bQv3TR/H/emys8+jMDofTCRNITfs6n8u6xtFxzfTACctlrWetNKT5fDLKDMMaOtIXxhIZev7sgZVoNRXwTO4xO0WFtWxUiBxeC3SWYaMAKyb9bdRaCTNrQWKiuS3T7fkmRmAAjY2AVjih1F9DydmjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5gEip4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF9FC4CEE7;
	Sun, 18 May 2025 09:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747562258;
	bh=2guWlEnLnYfsa0rYUzzORZ1RYR7+Gd6K7S86SE5kPD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5gEip4YURXxog4NPbjwAAvEP2x61+SOC4BREK8aa1NQe7RMnNK4nT82eP1MpC7TW
	 EY03+r6T64AxoDBmjhbBBPPH4bUdzvq5wJBTyrlxNbLwJlnSLDtc/5GuSL3jPKmU3p
	 5Zn7oSOWEBf79cct6/YikCrQtjpyIRbH/4ryT7Cp7gLO93Gtfmcsfp4MiG3oMghtO9
	 y2MN0QZUhZoaS22caNuJS2dPaq8Vhvkna6Qsh8XntwPiEHCHbn68Rcg8bm0gUninmI
	 Ahmn5S1/8Kz9J1ht8KeFb4C+yhOyyh81tWrY0pzYusED2prXnIEqn/+cms0hQV4Hun
	 B4iAHJrwjOYKA==
Received: by pali.im (Postfix)
	id 5BC0DE90; Sun, 18 May 2025 11:57:35 +0200 (CEST)
Date: Sun, 18 May 2025 11:57:35 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] nfs: Fix mounting NFS3 AUTH_NULL exports
Message-ID: <20250518095735.2wgtvjvzedliqeyv@pali>
References: <20240912130220.17032-1-pali@kernel.org>
 <20241222164018.id3ul7ucaxsrdkyq@pali>
 <20250418180313.h4jxi2rfxsmroumf@pali>
 <20250504084840.4n47y4zhqjqsk6bu@pali>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250504084840.4n47y4zhqjqsk6bu@pali>
User-Agent: NeoMutt/20180716

PING?

On Sunday 04 May 2025 10:48:40 Pali Rohár wrote:
> PING?
> 
> On Friday 18 April 2025 20:03:13 Pali Rohár wrote:
> > PING?
> > 
> > On Sunday 22 December 2024 17:40:18 Pali Rohár wrote:
> > > PING? If there is no objection, could you include series into -next?
> > > 
> > > On Thursday 12 September 2024 15:02:15 Pali Rohár wrote:
> > > > Linux NFS3 kernel client currently has broken support for NFS3
> > > > AUTH_NULL-only exports and also broken mount option -o sec=none
> > > > (which explicitly specifies that mount should use AUTH_NULL).
> > > > 
> > > > For AUTH_NULL-only server exports, Linux NFS3 kernel client mounts such
> > > > export with AUTH_UNIX authentication which results in unusable mount
> > > > point (any operation on it fails with error because server rejects
> > > > AUTH_UNIX authentication).
> > > > 
> > > > Half of the problem is with MNTv3 servers, as some of them (e.g. Linux
> > > > one) never announce AUTH_NULL authentication for any export. Linux MNTv3
> > > > server does not announce it even when the export has the only AUTH_NULL
> > > > auth method allowed, instead it announce AUTH_UNIX (even when AUTH_UNIX
> > > > is disabled for that export in Linux NFS3 knfsd server). So MNTv3 server
> > > > for AUTH_NONE-only exports instruct Linux NFS3 kernel client to use
> > > > AUTH_UNIX and then NFS3 server refuse access to files with AUTH_UNIX.
> > > > 
> > > > Main problem on the client side is that mount option -o sec=none for
> > > > NFS3 client is not processed and Linux NFS kernel client always skips
> > > > AUTH_NULL (even when server announce it, and also even when user
> > > > specifies -o sec=none on mount command line).
> > > > 
> > > > This patch series address these issues in NFS3 client code.
> > > > 
> > > > Add a workaround for buggy MNTv3 servers which do not announce AUTH_NULL,
> > > > by trying AUTH_NULL authentication as an absolutely last chance when
> > > > everything else fails. And honors user choice of AUTH_NULL if user
> > > > explicitly specified -o sec=none as mount option.
> > > > 
> > > > AUTH_NULL authentication is useful for read-only exports, including
> > > > public exports. As authentication for these types of exports do not have
> > > > to be required.
> > > > 
> > > > Patch series was tested with AUTH_NULL-only, AUTH_UNIX-only and combined
> > > > AUTH_NULL+AUTH_UNIX exports from Linux knfsd NFS3 server + default Linux
> > > > MNTv3 userspace server. And also tested with exports from modified MNTv3
> > > > server to properly return AUTH_NULL support in response list.
> > > > 
> > > > Patch series is based on the latest upstream tag v6.11-rc7.
> > > > 
> > > > Pali Rohár (5):
> > > >   nfs: Fix support for NFS3 mount with -o sec=none from Linux MNTv3
> > > >     server
> > > >   nfs: Propagate AUTH_NULL/AUTH_UNIX PATHCONF NFS3ERR_ACCESS failures
> > > >   nfs: Try to use AUTH_NULL for NFS3 mount when no -o sec was given
> > > >   nfs: Fix -o sec=none output in /proc/mounts
> > > >   nfs: Remove duplicate debug message 'using auth flavor'
> > > > 
> > > >  fs/nfs/client.c | 14 ++++++++++-
> > > >  fs/nfs/super.c  | 64 +++++++++++++++++++++++++++++++++++++++----------
> > > >  2 files changed, 65 insertions(+), 13 deletions(-)
> > > > 
> > > > -- 
> > > > 2.20.1
> > > > 

