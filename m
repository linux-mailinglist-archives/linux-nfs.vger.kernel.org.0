Return-Path: <linux-nfs+bounces-201-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B007FF00E
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 14:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6C00B20DE4
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 13:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338B647A45;
	Thu, 30 Nov 2023 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f6pStc0F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121B93E47A;
	Thu, 30 Nov 2023 13:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CF3C433C7;
	Thu, 30 Nov 2023 13:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701350728;
	bh=B50Myp2r8oz0ilW83tUjs4TPl/03BrY19uVzt55r0H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f6pStc0F1sdfa1tWHkWUNhb18QGGUsryuBFjcteidqrabLK3qyNf0RjiHBP0Seumv
	 GO6nhYdK1Tc2eyERnpwVs9vwl/jU+FbG5JHhswZab9DPO5Qq1eXgrU3SFZZpQvH8la
	 3V0Umi2JaiZHsWaM2pfPGPA0jY/z+jpnwO7c5zEI=
Date: Thu, 30 Nov 2023 13:25:25 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, linux-stable <stable@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/8] nfsd fixes for 6.5.y
Message-ID: <2023113013-fanning-esophagus-787f@gregkh>
References: <170120874713.1515.13712791731008720729.stgit@klimt.1015granger.net>
 <3C2A1F40-C0F3-412E-87ED-66AC1A2CA0F4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3C2A1F40-C0F3-412E-87ED-66AC1A2CA0F4@oracle.com>

On Tue, Nov 28, 2023 at 10:07:11PM +0000, Chuck Lever III wrote:
> 
> 
> > On Nov 28, 2023, at 4:59 PM, Chuck Lever <cel@kernel.org> wrote:
> > 
> > Backport of upstream fixes to NFSD's duplicate reply cache. These 
> > have been hand-applied and tested with the same reproducer as was 
> > used to create the upstream fixes.
> 
> After applying patches 1 through 6 cleanly, these applied with fuzz
> and offset but no rejection -- the same as the 6.6.y patch set.
> The context changes were due to Lorenzo's new nfsd netlink protocol.

6.5.y is now end-of-life, sorry.

greg k-h

