Return-Path: <linux-nfs+bounces-1073-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066D682CAD9
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 10:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176831C20F91
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 09:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E88A2A;
	Sat, 13 Jan 2024 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YNOZKOCM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396815AF;
	Sat, 13 Jan 2024 09:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383D2C433F1;
	Sat, 13 Jan 2024 09:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705138512;
	bh=jsC9Wf7ZzFG3HpxBHVjWQd3WccXs8kP4hZWKUih+SEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YNOZKOCMToNAZu3t9PObCdasz9xmFsBdpRyR4/w832DQZSuBaWuBoUNtuZeN88JKq
	 AtCdNRWRYZrXUev7N3jWRBs0zhmb0iUyFVYhWVUVETeonrA1WANOHJ+fww16dR/efT
	 7lUYcfEJGaaQ3hHHcB5pizms5Vw8cHSYWHgdoGBs=
Date: Sat, 13 Jan 2024 10:35:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: email200202 <email200202@yahoo.com>, regressions@lists.linux.dev,
	kernel@gentoo.org, stable@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [REGRESSION] After kernel upgrade 6.1.70 to 6.1.71, the computer
 hangs during shutdown
Message-ID: <2024011353-spookily-gliding-5fc6@gregkh>
References: <58ac38ae-4d64-4a53-81e0-35785961c41c.ref@yahoo.com>
 <58ac38ae-4d64-4a53-81e0-35785961c41c@yahoo.com>
 <2024011127-excluding-bodacious-1950@gregkh>
 <e341cb408b5663d8c91b8fa57b41bb984be43448.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e341cb408b5663d8c91b8fa57b41bb984be43448.camel@kernel.org>

On Thu, Jan 11, 2024 at 12:26:39PM -0500, Jeff Layton wrote:
> On Thu, 2024-01-11 at 10:30 +0100, Greg KH wrote:
> > On Thu, Jan 11, 2024 at 07:20:02PM +1100, email200202 wrote:
> > > Reverting the following 3 commits fixed the problem in kernel 6.1.71:
> > > 
> > > f9a01938e07910224d4a2fd00583725d686c3f38
> > > bb4f791cb2de1140d0fbcedfe9e791ff364021d7
> > > 03d68ffc48b94cc1e15bbf3b4f16f1e1e4fa286a
> > 
> > When sending us git ids, please show the full context so we have a hint
> > as to what they are.  For this, it should be:
> > 
> > f9a01938e079 ("NFSD: fix possible oops when nfsd/pool_stats is closed.")
> > bb4f791cb2de ("nfsd: call nfsd_last_thread() before final nfsd_put()")
> > 03d68ffc48b9 ("nfsd: separate nfsd_last_thread() from nfsd_put()")
> > 
> > Do you also have these issues in the latest 6.6.y release?  6.7?
> > 
> > 
> 
> I wasn't able to reproduce the exact same bug as the reporter, but I did
> see a different panic due to the above patches. Some of those fixes
> aren't appropriate without pulling in earlier commits, but I think it's
> probably best to just drop these two:
> 
> bb4f791cb2de ("nfsd: call nfsd_last_thread() before final nfsd_put()")
> 03d68ffc48b9 ("nfsd: separate nfsd_last_thread() from nfsd_put()")
> 
> Greg, does that sound OK?

Sure, can you send reverts for them, or do you need me to make them?

thanks,

greg k-h

