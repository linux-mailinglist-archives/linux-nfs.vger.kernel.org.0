Return-Path: <linux-nfs+bounces-3984-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8D690D29F
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 15:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1781C22627
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 13:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CA31AD4A6;
	Tue, 18 Jun 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UsDmM2os"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB68A15A865;
	Tue, 18 Jun 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716837; cv=none; b=gOtjy1cHuI2HSPSW/Ds6owiadrtH3A0xZN/H5puS+bHo6As/nKpFz91RI4wvHljZkusXDxuCFjAqp1Ds1kCUdXoaIAR6AlDG8d1/7PQ++TgZY5eQDtdrP0Cb+eqFQ918/f/RKWB+OYArd+HjH91rZuuVp51f3eaDro1TqKG3Ep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716837; c=relaxed/simple;
	bh=61BwRk89uR5plh9l2a5RQwsm9MayEiqWRgxh2NOv49Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozWWukpHMHombUDMIBDBqU1p9oftd9Zb5foUyzvPDS5mLalE+ZqUoBI9lzp8Vc0Nz8tWWWM3kgriM0DSqJJMdiL81ScA5bv1L4zUF6/4KalsFbrirFF3W/YWvm+lB87QQAexzx4kK2N+1pQBu0SCENKbFm4Xc0NWfr2WBgEG3xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UsDmM2os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665C6C32786;
	Tue, 18 Jun 2024 13:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716836;
	bh=61BwRk89uR5plh9l2a5RQwsm9MayEiqWRgxh2NOv49Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsDmM2osT+d7VuifZ/TT7eLnnLIHo6BqBKBglIJd8JArkqrnzak7bX2gBbXNDU3Ex
	 XLfCKJi85er4C3rZkIkr0LJxNCyNWh3fSvTf2xWBfdqjlz0PK5iSxeg1SJLICdrbsD
	 mZowFazR+lKf4S7/B3RM/bS7XE4gB2E0ozYRe2mo=
Date: Tue, 18 Jun 2024 14:42:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	linux-stable <stable@vger.kernel.org>
Subject: Re: Fwd: [GIT PULL 5.10.y] NFSD filecache fixes
Message-ID: <2024061849-impure-identical-ea0e@gregkh>
References: <ZnCO88W37FXg5CV6@tissot.1015granger.net>
 <C268A974-80EA-4F44-A78D-460D881A00C5@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C268A974-80EA-4F44-A78D-460D881A00C5@oracle.com>

On Mon, Jun 17, 2024 at 07:38:30PM +0000, Chuck Lever III wrote:
> Resend: Corrected email address for stable
> 
> 
> > Begin forwarded message:
> > 
> > From: Chuck Lever <chuck.lever@oracle.com>
> > Subject: [GIT PULL 5.10.y] NFSD filecache fixes
> > Date: June 17, 2024 at 3:30:59 PM EDT
> > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
> > Cc: linux-nfs@vger.kernel.org, stable@tissot.1015granger.net
> > 
> > Hi Greg, Sasha-
> > 
> > Here is a backport of nearly every NFSD patch from v5.11 until
> > v6.3, plus subsequent fixes, onto LTS v5.10.219. This addresses
> > the many NFSD filecache-related scalability problems in v5.10's
> > NFSD. This also contains fixes for issues found in the v5.15
> > NFSD backport over the past several months.
> > 
> > I've run this kernel through the usual upstream CI testing for
> > NFSD, and it seems solid.
> > 
> > In lieu of sending an mbox containing all of these patches, here's
> > a pull request that gives you the co-ordinates for the full series
> > enabling you to handle the merge however you prefer.

Sasha queued these all up, and I've pushed out a -rc release with _just_
these commits in it, so that it is easier to test and track regressions
for :)

thanks,

greg k-h

