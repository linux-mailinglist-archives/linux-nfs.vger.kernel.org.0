Return-Path: <linux-nfs+bounces-17619-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF44D04213
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 17:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E7DF34AE47A
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 15:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBD250096F;
	Thu,  8 Jan 2026 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o92+nerY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB2422127B;
	Thu,  8 Jan 2026 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886031; cv=none; b=DkkeVRQdvdfET/hZ+B4JtktXir7rMVGJ7Ndya0C18oJHCF3eMyCYPfAn1iq9ISdIZs55RgT3KG1cEPhRpYKq1nu5VcucbPoF8mgHsUGz6W+Y1VSPExuxscG1/spqxIEDu9JVGwEQkvUs7ctyUX632S7MvhNe7/4se4JgnZT2GqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886031; c=relaxed/simple;
	bh=4+GIdESyTpcoiGh3FY5yXiJkQq4EfGozENLDb8ueXlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lj43zMe2wbK45ks8zIJyZVAHRKgrvS646lsZEgTofMuKK3XxHM7rjCA9uwISA5kAA3tvwkY3vq3WOSqt+7f+IuIl0j1X1cpdKjidr9bz1DRlDunkmDb0WNdpOHLDTllB8/bS3X9AtlBjyiwDc/rW8wIb+sTXt7Qjnkhvej27jxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o92+nerY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D369EC116C6;
	Thu,  8 Jan 2026 15:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767886030;
	bh=4+GIdESyTpcoiGh3FY5yXiJkQq4EfGozENLDb8ueXlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o92+nerYl7oPMCLXKEQ0JQGv4ifrjFlRgiHeUrClTKC27Wp4RDb05cDMih6kueYiH
	 wyH45kTm4zY6zokaKrdeyBCbxO9fmN5AxS79Ou2Ja3tBqCRqgUH4Hq/F6RVMCxnhkV
	 SU/qPcMvPeQnjjifjGq9NhXJvXPbZX8eSEjOGKSw=
Date: Thu, 8 Jan 2026 16:27:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chuck Lever <cel@kernel.org>
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 6.6.y 1/4] nfsd: convert to new timestamp accessors
Message-ID: <2026010856-getaway-ungodly-4551@gregkh>
References: <20260103193854.2954342-1-cel@kernel.org>
 <20260103193854.2954342-2-cel@kernel.org>
 <2026010808-subwoofer-diabetic-e54e@gregkh>
 <ff54b6fb-6c82-4994-b9ff-715f9645d75c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff54b6fb-6c82-4994-b9ff-715f9645d75c@kernel.org>

On Thu, Jan 08, 2026 at 09:25:57AM -0500, Chuck Lever wrote:
> On 1/8/26 6:03 AM, Greg Kroah-Hartman wrote:
> > On Sat, Jan 03, 2026 at 02:38:51PM -0500, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> [ Upstream commit 335a7be84b526861f3deb4fdd5d5c2a48cf1feef ]
> > 
> > I don't see this git id anywhere in Linus's tree, are you sure it is
> > correct?
> > 
> > thanks,
> > 
> > greg k-h
> 
> If I start from the current upstream master, I find this instead:
> 
> commit 11fec9b9fb04fd1b3330a3b91ab9dcfa81ad5ad3
> Author:     Jeff Layton <jlayton@kernel.org>
> AuthorDate: Wed Oct 4 14:52:37 2023 -0400
> Commit:     Christian Brauner <brauner@kernel.org>
> CommitDate: Wed Oct 18 14:08:24 2023 +0200
> 
>     nfsd: convert to new timestamp accessors
> 
>     Convert to using the new inode timestamp accessor functions.
> 
>     Signed-off-by: Jeff Layton <jlayton@kernel.org>
>     Link:
> https://lore.kernel.org/r/20231004185347.80880-50-jlayton@kernel.org
>     Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> I picked up 335a7be84b526861f3deb4fdd5d5c2a48cf1feef from an
> nfsd-related tag by mistake. Do you want to drop this series and I can
> rework it properly?

Now dropped, please rework, thanks!

greg k-h

