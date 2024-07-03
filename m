Return-Path: <linux-nfs+bounces-4602-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DAB9264FB
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 17:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BA81C20D9C
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D04917DE09;
	Wed,  3 Jul 2024 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hM+rFoiC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BDD17BB3E
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021033; cv=none; b=EzCM1PSCEzyXIYYr1alB4tnFRP8UO8+/29qttvOststd5xHXOHi+J9vFt0JpQyTXC2mnQfU8vonk4+yKbAYBnWZ1hPMBAR/rdyDfJvbHVpv46xBHuPzQycgtksrtBc41l9oNkzNHQelrXhuB5NPwBw10+8Pz58u8dsGblzoyP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021033; c=relaxed/simple;
	bh=yP4QHf1IfNW793gRJm0JyEmYgU7nMo8m2YY1cSebkTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jr4j15gsdfcgDiRz80GaerX9pf34/Ox4pgNBioM/OEr77i722+LRq2HZ/hO6WvWyVSp42ahfdbLMMfU3nVaL5Jkl5DhHcN2TNbJmht6qcdNVewd0RvM+nc8X6xB/hbFSE2w9yIRDPkulmA7HhIcSfcCOjQbzUKnUxzPKSNkeBC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hM+rFoiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8FFC2BD10;
	Wed,  3 Jul 2024 15:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720021032;
	bh=yP4QHf1IfNW793gRJm0JyEmYgU7nMo8m2YY1cSebkTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hM+rFoiCu2hDJLwFSxX9nQXWzKuvKKyI50B1pW5+ZSlnu2iYd4XEe0+52g0gDwIY3
	 zLotHjc/T0TTXiKTb00OOLMYNJ9Dz3PzC+pJZFXZK01rJLX+8/vJDXoS1nZM2EmuXG
	 vLkY1a0rPKaV0oaTfSLLjd0gn5bT4dqx/qQDoI0FCcNA8PLZueoV38d5AYC4T6Dy2L
	 P6mZ+lhszVuUFjcNR8CBCQ9OpUODmHqT5Ai0GzycGdUkZl8GzdZxS0V9qqd2fNhyNK
	 TZBfrHdmB/ss0fsVsKUdSQcvAGh892PE9WgQEw9zEuUVVUOhyTp2MudOq0O7YuBsLw
	 bEC2PoTqOn34Q==
Date: Wed, 3 Jul 2024 11:37:11 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZoVwJ93D5sWtfm0N@kernel.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
 <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
 <ZoTb-OiUB5z4N8Jy@infradead.org>
 <ZoURUoz1ZBTZ2sr_@kernel.org>
 <665DF70C-9D13-491E-872B-FE859A1B8694@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <665DF70C-9D13-491E-872B-FE859A1B8694@oracle.com>

On Wed, Jul 03, 2024 at 03:26:30PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 3, 2024, at 4:52 AM, Mike Snitzer <snitzer@kernel.org> wrote:
> > 
> > And if spending the past 2 months discussing and developing in the
> > open is rushing things, I clearly need to slow down...
> > 
> > If only I had reason to think others were considering merging these
> > changes: https://marc.info/?l=linux-nfs&m=171942776105165&w=2
> 
> There is no mention of a particular kernel release in that
> email, nor is there a promise that we could hit the v6.11
> merge window.
> 
> In particular, I was asking how the series should be split
> up, since it modifies two separately maintained subsystems.
> 
> I apologize for not asking this more clearly.

No problem, I just got ahead of myself.  Not your fault.

