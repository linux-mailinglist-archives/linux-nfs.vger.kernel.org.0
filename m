Return-Path: <linux-nfs+bounces-1030-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB9F82AAEA
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 10:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D93728AC9C
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 09:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A51310962;
	Thu, 11 Jan 2024 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ws7Be4KD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED910785;
	Thu, 11 Jan 2024 09:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD14C433C7;
	Thu, 11 Jan 2024 09:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704965453;
	bh=fIwKddEdRd2iqyN2NzN5eSjY5GafL8H5ChP4IrV/UpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ws7Be4KDSZUuO78BIyu9u0SErZBMCOXxRHHrOY9TngvJS8KF6QpfJ5oDhL1QviNCX
	 GXBzOzp5us7etIWyMoD7KPNa4bQF6bhwtIvL7VAk+8pCQ7iNr86RaIL61bUOz1tpUn
	 lFohj5ltcjFiO3bLUHO3uYFWGtK5RqJW1KiNNcB0=
Date: Thu, 11 Jan 2024 10:30:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: email200202 <email200202@yahoo.com>
Cc: regressions@lists.linux.dev, kernel@gentoo.org, stable@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [REGRESSION] After kernel upgrade 6.1.70 to 6.1.71, the computer
 hangs during shutdown
Message-ID: <2024011127-excluding-bodacious-1950@gregkh>
References: <58ac38ae-4d64-4a53-81e0-35785961c41c.ref@yahoo.com>
 <58ac38ae-4d64-4a53-81e0-35785961c41c@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58ac38ae-4d64-4a53-81e0-35785961c41c@yahoo.com>

On Thu, Jan 11, 2024 at 07:20:02PM +1100, email200202 wrote:
> Reverting the following 3 commits fixed the problem in kernel 6.1.71:
> 
> f9a01938e07910224d4a2fd00583725d686c3f38
> bb4f791cb2de1140d0fbcedfe9e791ff364021d7
> 03d68ffc48b94cc1e15bbf3b4f16f1e1e4fa286a

When sending us git ids, please show the full context so we have a hint
as to what they are.  For this, it should be:

f9a01938e079 ("NFSD: fix possible oops when nfsd/pool_stats is closed.")
bb4f791cb2de ("nfsd: call nfsd_last_thread() before final nfsd_put()")
03d68ffc48b9 ("nfsd: separate nfsd_last_thread() from nfsd_put()")

Do you also have these issues in the latest 6.6.y release?  6.7?

thanks,

greg k-h

