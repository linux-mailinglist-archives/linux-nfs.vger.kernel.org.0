Return-Path: <linux-nfs+bounces-1074-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22C882CAE1
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 10:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3241C20FCB
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 09:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2CBA48;
	Sat, 13 Jan 2024 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MNrEedWW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B017A3F;
	Sat, 13 Jan 2024 09:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E29C433F1;
	Sat, 13 Jan 2024 09:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705138779;
	bh=Zfxdud4rAsFy9TpMi/AUgz2Y98SIwOTtypCcxU+DC/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNrEedWWayvccZ8/9GVIgrUDo2sTxO3jljGB2Gzbh+psqqz1JEdc8fpV8t4if+cbU
	 S03YGIDKBWsCWisL42Hy0f5HkNG+rha3UqZSP5/DNlJ7xva1zdHblbt+KiFNKquDEA
	 ybV1Aa7dm6Jv5T+3oOX6yodNIMAohFRCTu55tZVw=
Date: Sat, 13 Jan 2024 10:39:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: email200202 <email200202@yahoo.com>, regressions@lists.linux.dev,
	kernel@gentoo.org, stable@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [REGRESSION] After kernel upgrade 6.1.70 to 6.1.71, the computer
 hangs during shutdown
Message-ID: <2024011327-probably-dilation-f801@gregkh>
References: <58ac38ae-4d64-4a53-81e0-35785961c41c.ref@yahoo.com>
 <58ac38ae-4d64-4a53-81e0-35785961c41c@yahoo.com>
 <2024011127-excluding-bodacious-1950@gregkh>
 <e341cb408b5663d8c91b8fa57b41bb984be43448.camel@kernel.org>
 <2024011353-spookily-gliding-5fc6@gregkh>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024011353-spookily-gliding-5fc6@gregkh>

On Sat, Jan 13, 2024 at 10:35:09AM +0100, Greg KH wrote:
> On Thu, Jan 11, 2024 at 12:26:39PM -0500, Jeff Layton wrote:
> > On Thu, 2024-01-11 at 10:30 +0100, Greg KH wrote:
> > > On Thu, Jan 11, 2024 at 07:20:02PM +1100, email200202 wrote:
> > > > Reverting the following 3 commits fixed the problem in kernel 6.1.71:
> > > > 
> > > > f9a01938e07910224d4a2fd00583725d686c3f38
> > > > bb4f791cb2de1140d0fbcedfe9e791ff364021d7
> > > > 03d68ffc48b94cc1e15bbf3b4f16f1e1e4fa286a
> > > 
> > > When sending us git ids, please show the full context so we have a hint
> > > as to what they are.  For this, it should be:
> > > 
> > > f9a01938e079 ("NFSD: fix possible oops when nfsd/pool_stats is closed.")
> > > bb4f791cb2de ("nfsd: call nfsd_last_thread() before final nfsd_put()")
> > > 03d68ffc48b9 ("nfsd: separate nfsd_last_thread() from nfsd_put()")
> > > 
> > > Do you also have these issues in the latest 6.6.y release?  6.7?
> > > 
> > > 
> > 
> > I wasn't able to reproduce the exact same bug as the reporter, but I did
> > see a different panic due to the above patches. Some of those fixes
> > aren't appropriate without pulling in earlier commits, but I think it's
> > probably best to just drop these two:
> > 
> > bb4f791cb2de ("nfsd: call nfsd_last_thread() before final nfsd_put()")
> > 03d68ffc48b9 ("nfsd: separate nfsd_last_thread() from nfsd_put()")
> > 
> > Greg, does that sound OK?
> 
> Sure, can you send reverts for them, or do you need me to make them?

Nevermind, I made them, thanks.

greg k-h

