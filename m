Return-Path: <linux-nfs+bounces-11169-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7356A93C7E
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Apr 2025 20:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4E73B970C
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Apr 2025 18:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92508214812;
	Fri, 18 Apr 2025 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbEIiR6p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659B384A3E;
	Fri, 18 Apr 2025 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744999399; cv=none; b=tR/XJMVVS8BTu8leQLsrJLCthUir+LQ1gNi1S2Wzye3iMNEN2pr8KFdtbcqrtGEaB7bK6SwzUWkiuL1AtEt+G/ejahwI5uhcVShCpj7XudO1SSC8T4ki3zQaPuASzr/Q4l3yuguFI+XBqSq1hH6h7pOaqRcuHSufOJdE5NYoFso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744999399; c=relaxed/simple;
	bh=KL6aMW4rmGcMF1ZwvBhXzs+PsXE43Bt+JO2DW2EhFVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlN5aIYrprdy3NaqBGCpPez96HmbjN86Dzn8sy3nyUGMoNhCdiprLoXIihTPYL7I4YTCrL0U5sEN19vAEoXjeU1vCXPIjL+GAm1iTGOqvOvPGbCNEnGGU6WMQ9RIwUcAbf8IKju9wKyEr9z/IMxRskBDImjXWVWD2cHBhbMiYVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbEIiR6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDB1C4CEE2;
	Fri, 18 Apr 2025 18:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744999396;
	bh=KL6aMW4rmGcMF1ZwvBhXzs+PsXE43Bt+JO2DW2EhFVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fbEIiR6pyrqTIbZbffeVgKy4fGZKBOlzd4PD9ClLdfDYlzdOSL8k53PccpObR56+L
	 z50/wnPNIk+ZEnyqzCUdduLcfh3to1wHQxxAQZOHtrkK6w9QERRMIhvQDSDiAlP3Ev
	 mW8Lz79v8gkm6U1BJWya1EoqGu05/mHq1ROH8esjBfD6JjR0pKN7PCuVOHuwWZsqhK
	 u71Bn/HUo2iFboKqhFIUdQamu9FevEL+Pgov4WpRjfo1j7lK1nc8HQAtiE3hZffDS4
	 51esmnp+hnQ94Fihf4fjlXhU/t80gUe3GVEutANVaa3sE8cfFReTeBvlL0cmjwuvdT
	 tOEIaqD8XJb7g==
Received: by pali.im (Postfix)
	id B5145721; Fri, 18 Apr 2025 20:03:13 +0200 (CEST)
Date: Fri, 18 Apr 2025 20:03:13 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] nfs: Fix mounting NFS3 AUTH_NULL exports
Message-ID: <20250418180313.h4jxi2rfxsmroumf@pali>
References: <20240912130220.17032-1-pali@kernel.org>
 <20241222164018.id3ul7ucaxsrdkyq@pali>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241222164018.id3ul7ucaxsrdkyq@pali>
User-Agent: NeoMutt/20180716

PING?

On Sunday 22 December 2024 17:40:18 Pali Rohár wrote:
> PING? If there is no objection, could you include series into -next?
> 
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

