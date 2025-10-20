Return-Path: <linux-nfs+bounces-15421-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1F7BF2EA4
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 20:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6DD44E5A19
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 18:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1E918871F;
	Mon, 20 Oct 2025 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7qP59sG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280E328DB3
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984695; cv=none; b=Hk3rdhoGpECgK0CiZsrFAtORJ+xh9cMYzCIgp9shxJNDS/MUGNj9mN4mNZBxUbjAA6YJ7y9DhjTVaJErt/LuQLYLj8y16bL989M92+EL8Ws92hJmA7eN7cyL/odL38T3yrfF0qfNA5uV4IJMRDhRy/9LZgnWSXQdXGBitskbpuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984695; c=relaxed/simple;
	bh=jAKYPkuoC24rzFT0ZNf3yc+fF5Vq8Dg9z7NDk4O0PPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWUMviwmg27KpJVppqjiy4wt/Q7+xPRQx9Fta/bae+p3baKLcS3exm88j8IVQQqBdWqf27JNIyXQi+R0xsDVN+2UOMx656mb7uIosiLrvHrm7+sNdhwBoSK4CyHJX2eqYxicNRP98xps4ycwR2RapkJqaQNa4M+fPpf+S7KbLEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7qP59sG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA61C113D0;
	Mon, 20 Oct 2025 18:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760984693;
	bh=jAKYPkuoC24rzFT0ZNf3yc+fF5Vq8Dg9z7NDk4O0PPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M7qP59sG8Va8NKtrw73HlFNVudj17R497kvHLOy2ew/nNxKQW1pcQ+7oDdJN5zvvA
	 mXTIjuDVr/pijMxi402eZJbE4aW9LKxz6LHuf8bhhL7R2K7bKEBNEaOpatPQM4/VXo
	 eIu8enu3i0gvmGxHdpWDohh5/D+lRYgadVQA23IEcrgBta0Ml/aMqOKfOuGaKrT9ng
	 Aj0kY4OkKrMkj5msLSOwn8o2mrgQeAPO00iDDbx6LeJ/KrjBrSW7bSKuQvt2ErEVd9
	 FwGQL5A/FyjpGfgi8bIVK5NfkClfAFDOY+bThuItHCRQ3owiHCMWRXuxQGkKSMR3qd
	 vRvLfpXp+gh3g==
Date: Mon, 20 Oct 2025 14:24:52 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Yongcheng Yang <yoyang@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [Bug report] xfstests generic/323 over NFS hit BUG: KASAN:
 slab-use-after-free in nfs_local_call_read on 6.18.0-rc1
Message-ID: <aPZ-dIObXH8Z06la@kernel.org>
References: <aPSvi5Yr2lGOh5Jh@dell-per750-06-vm-07.rhts.eng.pek2.redhat.com>
 <ed50690c04699c820873642ea38a01eec53d21af.camel@kernel.org>
 <aPURMSaH1rXQJkdj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPURMSaH1rXQJkdj@kernel.org>

On Sun, Oct 19, 2025 at 12:26:25PM -0400, Mike Snitzer wrote:
> On Sun, Oct 19, 2025 at 11:18:57AM -0400, Trond Myklebust wrote:
> > On Sun, 2025-10-19 at 17:29 +0800, Yongcheng Yang wrote:
> > > Hi All,
> > > 
> > > There is a new nfs slab-use-after-free issue since 6.18.0-rc1.
> > > It appears to be reliably reproducible on my side when running
> > > xfstests
> > > generic/323 over NFSv4.2 in *debug* kernel mode:
> > 
> > Thanks for the report! I think I see the problem.
> > 
> > Mike,
> > 
> > When you iterate over the iocb in nfs_local_call_read(), you're calling
> > nfs_local_pgio_done(), nfs_local_read_done() and
> > nfs_local_pgio_release() multiple times.
> 
> I purposely made nfs_local_pgio_done() safe to call multiple times.
> 
> And nfs_local_{read,write}_done() and nfs_local_pgio_release()
> _should_ only be called once.
> 
> >  * You're calling nfs_local_read_aio_complete() and
> >    nfs_local_read_aio_complete_work() once for each and every
> >    asynchronous call.
> 
> There is only the possibility of a single async call for the single
> aligned DIO.
> 
> For any given pgio entering LOCALIO, it may be split into 3 pieces:
> The misaligned head and tail are first handled sync and only then the
> aligned middle async (or possibly sync if underlying device imposes
> sync, e.g. ramdisk).
> 
> >  * You're calling nfs_local_pgio_done() for each synchronous call.
> 
> Yes, which is safe.  It just updates status, deals with partial
> completion.
> 
> >  * In addition, if there is a synchronous call at the very end of the
> >    iteration, so that status != -EIOCBQUEUED, then you're also calling
> >    nfs_local_read_done() one extra time, and then calling
> >    nfs_local_pgio_release().
> 
> It isn't in addition, its only for the last piece of IO (be it sync or
> async).
> 
> > The same thing appears to be happening in nfs_local_call_write().
> 
> I fully acknolwdge this isn't an easy audit.  And there could be
> something wrong.  But I'm not seeing it.  Obviously this BUG report
> puts onus on me to figure it out...
> 
> BUT, I have used this code extensively on non-debug and had no issues.
> Is it at all possible KASAN is triggering a false-positive!?

I haven't been able to reproduce this (NFS LOCALIO and KASAN is
enabled):

[root@snitzer xfstests-dev]# cat local.config
export TEST_DIR="/mnt/share1"
export TEST_DEV="10.200.111.104:/share1"
export SCRATCH_MNT="/mnt/scratch"
export SCRATCH_DEV="10.200.111.104:/"
export TEST_FS_MOUNT_OPTS="-overs=4.2,sec=sys,acl,nconnect=5"

[root@snitzer xfstests-dev]# ./check -nfs generic/323
FSTYP         -- nfs
PLATFORM      -- Linux/x86_64 snitzer 6.12.53.1.hs.snitm+ #75 SMP PREEMPT_DYNAMIC Fri Oct 17 03:55:21 UTC 2025
MKFS_OPTIONS  -- 10.200.111.104:/
MOUNT_OPTIONS -- 10.200.111.104:/ /mnt/scratch

generic/323        121s
Ran: generic/323
Passed all 1 tests

My kernel is 6.12-stable based, but includes all NFS and NFSD changes
through 6.18-rc1 (and also most of chuck's nfsd-testing), see:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=kernel-6.12.53/main

Please provide your .config (off-list is fine!) and I'll see if I'm
somehow missing something.

(I suppose it could be that by test system is too slow...)

Thanks,
Mike

