Return-Path: <linux-nfs+bounces-15424-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9E2BF34D9
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 21:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE8718C348A
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 19:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E0D3321DE;
	Mon, 20 Oct 2025 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJco0ZYB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817472627F9
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990325; cv=none; b=kfzhWR9MRa2F5x6pzCxVxoyFL0VIu6SkJEx4gDy0WuaxbGAof6+D+wAm9qPx1m8VCJI6mHXlfhlyLxvCuBfDVcAWHdtQiWngkd/7feebj8BaTpLZWEv5kr++ipjCKRyeyw7rt3s9AaPgfCZ/MfEeeCM6F3d092/Lz7LJKNxHP28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990325; c=relaxed/simple;
	bh=udlGeaoKl+ryJ3Bi0pcNRWu48ay5rTXNn0gATUMdxhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8xTPoJ6aOiM3aGR5nJAST1V+N/uIz3c9cGa+J8GMPKwqlEzTTSktYmucpdVsHxCH0im3BEU12UuyGS3KrS+MuSQFA3LuQJ4XIpkDJhakDxHbXoJ6aWXqEaq6XxOKuRBcUBBEjfgusvws6YEjjkoNycwd0tlAdULPyPoREYxHxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJco0ZYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B63C113D0;
	Mon, 20 Oct 2025 19:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760990325;
	bh=udlGeaoKl+ryJ3Bi0pcNRWu48ay5rTXNn0gATUMdxhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJco0ZYB55s98q+brIGKJd6Zt3zHCnD7pOvbjR1boKEaBQqE6eph+s1PvLgH2aAxF
	 R9BWlZ42r/usNytMUhjgjhFwFlHPinZLCmME1Om7JIoR/96xODnhceWYGxzDHV8nqr
	 2b3qN4A/ZTeYjVk0ulYFsjR6EBK1OR3L7dcR99miZln58bmuG72frS7tW21buISnrF
	 SdMrYr7YxKNyEco6xbozvVYTRbYV9J/pUfr7B/qDy+jEU7o8HaoPC87i3zs2g3wM24
	 gAAeuKTbnm7KCV/8whRRRz2sio445zPGytFdXby7JMCFM4WO7Zrca4OSddGpxXeBJR
	 /tdn6olFMvRqA==
Date: Mon, 20 Oct 2025 15:58:43 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jonathan Curley <jcurley@purestorage.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/9] NFSv4/flexfiles: Add support for striped
 layouts
Message-ID: <aPaUc8jzDWu7bhn_@kernel.org>
References: <20250924162050.634451-1-jcurley@purestorage.com>
 <aO-dE5-Rou92f9BU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO-dE5-Rou92f9BU@kernel.org>

FYI, I really don't think your flexfiles striped changes have anything
to do with the reported mtls client mount issue.  Sorry for the noise.

Mike


On Wed, Oct 15, 2025 at 09:09:39AM -0400, Mike Snitzer wrote:
> Hi Jon,
> 
> I got a report that TLS no longer works with flexfiles. For context, I
> made TLS possible with flexfiles with commit 04a15263662a
> ("pnfs/flexfiles: connect to NFSv3 DS using TLS if MDS connection uses
> TLS").
> 
> If I revert your flexfiles striped patchset then TLS works with
> flexfiles again.
> 
> I haven't looked closely to try to find the issue yet, but I wanted
> to let you (and others) know about this regression.
> 
> Mike
> 
> On Wed, Sep 24, 2025 at 04:20:41PM +0000, Jonathan Curley wrote:
> > This patch series introduces support for striped layouts:
> > 
> > The first 2 patches are simple preparation changes. There should be
> > no logical impact to the code.
> > 
> > The 3rd patch refactors the nfs4_ff_layout_mirror struct to have an
> > array of a new nfs4_ff_layout_ds_stripe type. The
> > nfs4_ff_layout_ds_stripe has all the contents of ff_data_server4 per
> > the flexfile rfc. I called it ds_stripe because ds was already taken
> > by the deviceid side of the code.
> > 
> > The patches 4-8 update various paths to be dss_id aware. Most of this
> > consists of either adding a new parameter to the function or adding a
> > loop. Depending on which is appropriate.
> > 
> > The final patch 9 updates the layout creation path to populate the
> > array and turns the feature on.
> > 
> > v1:
> >  - Fixes function parameter 'dss_id' not described in
> >    'nfs4_ff_layout_prepare_ds'
> > 
> > v2:
> >  - Fixes layout stat error reporting path for commit to properly
> >    calculate dss_id.
> > 
> > v3:
> >  - Fixes do_div dividend to be u64.
> > 
> > v4:
> >  - Use regular division operators for u32 commit path math.
> >  - Fix mirror null check in ff_rw_layout_has_available_ds.
> > 
> > Jonathan Curley (9):
> >   NFSv4/flexfiles: Remove cred local variable dependency
> >   NFSv4/flexfiles: Use ds_commit_idx when marking a write commit
> >   NFSv4/flexfiles: Add data structure support for striped layouts
> >   NFSv4/flexfiles: Update low level helper functions to be DS stripe
> >     aware.
> >   NFSv4/flexfiles: Read path updates for striped layouts
> >   NFSv4/flexfiles: Commit path updates for striped layouts
> >   NFSv4/flexfiles: Write path updates for striped layouts
> >   NFSv4/flexfiles: Update layout stats & error paths for striped layouts
> >   NFSv4/flexfiles: Add support for striped layouts
> > 
> >  fs/nfs/flexfilelayout/flexfilelayout.c    | 778 +++++++++++++++-------
> >  fs/nfs/flexfilelayout/flexfilelayout.h    |  64 +-
> >  fs/nfs/flexfilelayout/flexfilelayoutdev.c | 105 +--
> >  fs/nfs/write.c                            |   2 +-
> >  4 files changed, 635 insertions(+), 314 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 
> > 
> 

