Return-Path: <linux-nfs+bounces-11890-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0050AC2D41
	for <lists+linux-nfs@lfdr.de>; Sat, 24 May 2025 05:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4845F1BA243F
	for <lists+linux-nfs@lfdr.de>; Sat, 24 May 2025 03:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D883C465;
	Sat, 24 May 2025 03:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7Ry1FTl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF317BBF
	for <linux-nfs@vger.kernel.org>; Sat, 24 May 2025 03:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748058812; cv=none; b=Tt2BYAv9w99APnQIvznQPzBe1JcvKPQG1jgHgCJakVFq0vuNNapz2r2w0ymPOkh/OHKCCYb7ggt3ym8HW/8RjO01rQ58xlJmPQ9iqIqsOQE3spgqfDlgBKqaIWNizqkzSay1DHXSR4/pAVFm7TH5vDpp32b4aKFTFoXyiNC50zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748058812; c=relaxed/simple;
	bh=ZP02bdh7J2LLqurUMOR486Lc6BLKbK2jJgbCR63UQ20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqRILk/HfNC840bX+Zbr/pSRa72niMKFVXT1byH1dm1vk8DhdT1lv7wpEjqg8/7HuEPXHSk0HC6Ri3Fis2Pk9nOp2BaVVUCu+veKqccGuL9abzWYOk2H/2TMiVDRG/uFNvv2mpZk61L1B6D8DLwGUb3IYxntAem7b84sppHkZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7Ry1FTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108D9C4CEE4;
	Sat, 24 May 2025 03:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748058811;
	bh=ZP02bdh7J2LLqurUMOR486Lc6BLKbK2jJgbCR63UQ20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7Ry1FTl8wWNOnnrrPVTDOSRmXKm80PQQWWJVGshaL3WNFIup9RoNadX4R1mKgk+5
	 8Q/521x4ZVaC6sBAIFjgf9VqF9i51ioU1tOZgy1x1ahU679EhLE+inyqmtZClUvoTR
	 4N4jwWOI4n2x+wsDAymNbybal2z6rroqWQ56ptJM+ATfMwOVF5E6HhqWLC2nAbPC7S
	 ZJEMCSuUkBSxvch/F+INhjmT3o4I6kBIr+7muH1GbDR640YNe+g6iwellbRhlwPfKB
	 D/hmV6YXhA+j2U19khw5r228BXH2QIY0/zdzwLFyBTXpZ4tWaXAQtFXDr7dg2ovk1n
	 oly9RKxPKEaCw==
Date: Fri, 23 May 2025 23:53:29 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, steved@redhat.com
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	linux-nfs@vger.kernel.org
Subject: Re: unable to run NFSD in container if "options sunrpc
 pool_mode=pernode"
Message-ID: <aDFCuXj2JBQuv-Yd@kernel.org>
References: <aDC-ftnzhJAlwqwh@kernel.org>
 <f93f70ce429f2dd6d11f6900808fc4ab737f765f.camel@kernel.org>
 <aDD0VxdSk0O6LdFG@kernel.org>
 <6bb9e9cce27e2a222bf55e272d690aab8f0eef13.camel@kernel.org>
 <aDEAJzELBTH0CqHI@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDEAJzELBTH0CqHI@kernel.org>

On Fri, May 23, 2025 at 07:09:27PM -0400, Mike Snitzer wrote:
> On Fri, May 23, 2025 at 06:40:45PM -0400, Jeff Layton wrote:
> > On Fri, 2025-05-23 at 18:19 -0400, Mike Snitzer wrote:
> > > On Fri, May 23, 2025 at 02:40:17PM -0400, Jeff Layton wrote:
> > > > On Fri, 2025-05-23 at 14:29 -0400, Mike Snitzer wrote:
> > > > > I don't know if $SUBJECT ever worked... but with latest 6.15 or
> > > > > nfsd-testing if I just use pool_mode=global then all is fine.
> > > > > 
> > > > > If pool_mode=pernode then mounting the container's NFSv3 export fails.
> > > > > 
> > > > > I haven't started to dig into code yet but pool_mode=pernode works
> > > > > perfectly fine if NFSD isn't running in a container.
> > > > > 
> > 
> > Oops, I went and looked and nfsd isn't running in a container on these
> > boxes. There are some other containerized apps running on the box, but
> > nfsd isn't running in a container.
> 
> OK.
> 
> > > I'm using nfs-utils-2.8.2.  I don't see any nfsd threads running if I
> > > use "options sunrpc pool_mode=pernode".
> > > 
> > 
> > I'll have a look soon, but if you figure it out in the meantime, let us
> > know.
> 
> Will do.
> 
> Just the latest info I have, with sunrpc's pool_mode=pernode dd hangs
> with this stack trace:

Turns out this pool_mode=pernode issue is a regression caused by the
very recent nfs-utils 2.8.2 (I rebuilt EL10's nfs-utils package,
because why not upgrade to the latest!?).

If I use EL9.5's latest nfs-utils-2.5.4-37.el8.x86_64 then sunrpc's
pool_mode=pernode works fine.

And this issue doesn't have anything to do with running in a container
(it seemed to be container related purely because I happened to be
seeing the issue with an EL9.5 container that had the EL10-based
nfs-utils 2.8.2 installed).

Steved, unfortunately I'm not sure what the problem is with the newer
nfs-utils and setting "options sunrpc pool_mode=pernode"

Mike

