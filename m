Return-Path: <linux-nfs+bounces-16675-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A37C7DC1C
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 07:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD6B934BD9C
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 06:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CF72571D8;
	Sun, 23 Nov 2025 06:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RQIzNNcG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197BB23EA8C;
	Sun, 23 Nov 2025 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763879040; cv=none; b=t9OgQKfsfItfBIa9cCDWS5rpcSlteqKEVfqMaJCaAvY5SUIOKLMzcZPEr23zCo3Tfrto9/4y9AJVPBy2aZUX0E8ixyK2WC54aA4bmmPI1n9ylUQyUI4n9anhxcngAsOAKv2dafl1T1RfMufzT9ttSun6EQQsH1+jD/KLlHS4dGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763879040; c=relaxed/simple;
	bh=SzyBMBGL41l+GRT3PKbQK6wE8+pXjCJM7j+1yPO5XGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYMySInXkxUBUY14j1Na9NPG/sfK/NgPxlIIs3PbcAW12Q/JWoEq6o6wq1wNr4BzRNQYBzZykDSORh8R4KjW0jUv5o1e7IdspLDtbwUzcpEx/ca+F1aAq+cRiTPaoclVwFUAo+M9oigJgs7pMP8X7swVo4W9Tnxlz7VGQAj15/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RQIzNNcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E143C116B1;
	Sun, 23 Nov 2025 06:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763879039;
	bh=SzyBMBGL41l+GRT3PKbQK6wE8+pXjCJM7j+1yPO5XGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQIzNNcGiJcBugzj3bgJKApwiyWQ5oxgr6jFwUqKK4RnJuFQ4l5HFGluXKiUbncT8
	 m4V8kvjyUw/j4RGbUQ3bs4fr8NHRNaev8+kAtuD4+a+PrNeZBTS/09qoQ7b4coeU3k
	 D4guSkruoRfeIbAHW9mN6s1FDoEhh+XknjHWRXxQ=
Date: Sun, 23 Nov 2025 07:23:55 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: "Ahmed, Aaron" <aarnahmd@amazon.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"sashal@kernel.org" <sashal@kernel.org>
Subject: Re: [REGRESSION] nfs: Large amounts of GETATTR calls after file
 renaming on v5.10.241
Message-ID: <2025112346-overbuilt-upscale-b43a@gregkh>
References: <F84F6626-B709-4083-9512-5F48FE370977@amazon.com>
 <2025112203-paddle-unweave-c0a2@gregkh>
 <8090316eab1a1b973ab81a8f3c088caa7052d89d.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8090316eab1a1b973ab81a8f3c088caa7052d89d.camel@kernel.org>

On Sat, Nov 22, 2025 at 10:43:29AM -0500, Trond Myklebust wrote:
> On Sat, 2025-11-22 at 07:56 +0100, gregkh@linuxfoundation.org wrote:
> > On Fri, Nov 21, 2025 at 06:56:31PM +0000, Ahmed, Aaron wrote:
> > > Hi,
> > > 
> > > We have had customers report a regression on kernels versions
> > > 5.10.241 and above in which file renaming causes large amounts of
> > > GETATTR calls to made due to inode revalidation. This regression
> > > was pinpointed via bisected to commit 7378c7adf31d ("NFS: Don't set
> > > NFS_INO_REVAL_PAGECACHE in the inode cache validity") which is a
> > > backport of 36a9346c2252 (“NFS: Don't set NFS_INO_REVAL_PAGECACHE
> > > in the inode cache validity”). 
> > > 
> > > We were able to reproduce It with this script:
> > > REPRO_PATH=/mnt/efs/repro
> > > do_read()
> > > {
> > >     for x in {1..50}
> > >     do
> > >         cat $1 > /dev/null
> > >     done
> > >     grep GETATTR /proc/self/mountstats
> > > }
> > > 
> > > echo foo > $REPRO_PATH/bar
> > > echo "After create, before read:"
> > > grep GETATTR /proc/self/mountstats
> > > 
> > > echo "First read:"
> > > do_read $REPRO_PATH/bar
> > > 
> > > echo "Sleeping 5s, reading again (should look the same):"
> > > sleep 5
> > > do_read $REPRO_PATH/bar
> > > 
> > > mv $REPRO_PATH/bar $REPRO_PATH/baz
> > > echo "Moved file, reading again:"
> > > do_read $REPRO_PATH/baz
> > > 
> > > echo "Immediately performing another set of reads:"
> > > do_read $REPRO_PATH/baz
> > > 
> > > echo "Cleanup, removing test file"
> > > rm $REPRO_PATH/baz
> > > which performs a few read/writes. On kernels without the regression
> > > the number of GETATTR calls remains the same while on affected
> > > kernels the amount increases after reading renamed file. 
> > > 
> > > This original commit comes from a series of patches providing
> > > attribute revalidation updates [1].  However, many of these patches
> > > are missing in v.5.10.241+. Specifically, 13c0b082b6a9 (“NFS:
> > > Replace use of NFS_INO_REVAL_PAGECACHE when checking cache
> > > validity”) seems like a prerequisite patch and would help remedy
> > > the regression.
> > 
> > Can you please send the needed backports to resolve this issue as you
> > can test and verify that this resolves the problem?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Ah... If I'm correctly reading the changelog
> in https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.10.241, it
> looks as if commit 36a9346c2252 got pulled in by the stable patch
> automation as a dependency for commit b01f21cacde9 ("NFS: Fix the
> setting of capabilities when automounting a new filesystem").
> 
> I do agree with Aaron's assessment that patch does depend on the rest
> of the series that was merged into Linux 5.13. It cannot be cherry-
> picked on its own.
> 
> However what exactly was the dependency that caused it to be pulled
> into 5.10.241 in the first place? Was that logged anywhere?
> I just checked out v5.10.241 and applied "git revert --signoff
> 36a9346c2252", and that appears to work just fine, and I don't see any
> other obvious code dependency there, so I'm curious about what
> happened.

As the commit says:
	Stable-dep-of: b01f21cacde9 ("NFS: Fix the setting of capabilities when automounting a new filesystem")



