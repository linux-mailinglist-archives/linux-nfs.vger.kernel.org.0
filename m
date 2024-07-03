Return-Path: <linux-nfs+bounces-4587-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F3A9255E4
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 10:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7365E1C20CF5
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 08:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622D713AA39;
	Wed,  3 Jul 2024 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXSOpesf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC0B31A89
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719996756; cv=none; b=q5+FStgLjZLEMZZ58EHQ1eNp+HQcjMxOWBO433FkSetWpIV6b2T6pmZSvNIcu/J61pVxXD0Uiy8vugKpmsjRq7/zIn6N890mAVc5Aso2ZAxmBULbwDG0igUvN0GLLlpZTx+UUMBbQkOVD2OBJpdWBC5rOwBBg2w0JLGh2gPfSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719996756; c=relaxed/simple;
	bh=dSGXWsZvj9phGtk4W1e/pMfjlX2M78IPXhIIT64anlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEYJDTx20Jn9/QKcYBoHIF6tCzF7c4r0cbUMKz3BqNIqQxMCJ+iOzNS9v0GvtexFEj8srt/ULrKOc0Lka59xuEWePWObLWhBXPyzzr2wkzCs7MXBPs+cUOZdHgHU1XIiPalTNEw2op5g3tjOH8hy1yWrBC9I25LuWosjpTtdTFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXSOpesf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851FBC2BD10;
	Wed,  3 Jul 2024 08:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719996755;
	bh=dSGXWsZvj9phGtk4W1e/pMfjlX2M78IPXhIIT64anlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tXSOpesf4nShp0El4zoGlWiz0qjEPw5CKvt8mduZkqViBLYYoXXN9kdxMCQpW1jfF
	 +3CmboNTlYAIi6jZFZDwwh4ZWa/MC1A0koNLNT59fPJZvi3WZQQ19UbCt1Dqa4pqz0
	 4CmyCxI9h8iq8hL2zSwTSxBGgwWsJ6KrmEJj+v/V5EoxGNU2s+FGU8sglHipjbqpH4
	 EMElIH2HfkH5Xl+mogV84+8lkRfaOh0Jr0ETIwscrXk3aywPX9MYN+egnwGHKESYsm
	 f+wfhkidMbrGcffw5RoHDL5i9WwlVpTQ6YEyjzRscUyP5hCFh5Bjft2Is5YCiI8qLz
	 zUk3nNf4nsquw==
Date: Wed, 3 Jul 2024 04:52:34 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZoURUoz1ZBTZ2sr_@kernel.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
 <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
 <ZoTb-OiUB5z4N8Jy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoTb-OiUB5z4N8Jy@infradead.org>

On Tue, Jul 02, 2024 at 10:04:56PM -0700, Christoph Hellwig wrote:
> On Tue, Jul 02, 2024 at 06:06:09PM +0000, Chuck Lever III wrote:
> > To make it official, for v11 of this series:
> > 
> >   Nacked-by: Chuck Lever <chuck.lever@oracle.com>
> 
> We've also not even looked into tackling the whole memory reclaim
> recursion problem that have historically made local loopback
> network file system an unsupported configuration.  We've have an
> ongoing discussion on the XFS list that really needs to to fsdevel
> and mm to make any progress first.  I see absolutely not chance to
> solved that in this merge window.  I'm also a bit surprised and
> shocked by the rush here.

linux-nfs and linu-xfs both received those emails, there isn't some
secret game here:
https://marc.info/?l=linux-nfs&m=171976530216518&w=2
https://marc.info/?l=linux-xfs&m=171976530416523&w=2

I pivoted away from that (after Dave's helpful response) and back to
what I provided in most every revision of this patchset (with
different header and code revisions), most recent being patch 18 of
this v11 series: https://marc.info/?l=linux-nfs&m=171993773109538&w=2

And if spending the past 2 months discussing and developing in the
open is rushing things, I clearly need to slow down...

If only I had reason to think others were considering merging these
changes: https://marc.info/?l=linux-nfs&m=171942776105165&w=2

Ultimately I simply wanted to keep momentum up, I'm sure you can
relate to having a vision for phasing changes in without missing a
cycle.  But happy to just continue working it into the 6.12
development window.

I'll be sure to cc linux-fsdevel on future revision(s).

