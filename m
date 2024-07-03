Return-Path: <linux-nfs+bounces-4594-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0DF926486
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 17:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069DE28E2D9
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA39717DA23;
	Wed,  3 Jul 2024 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jT0upB7a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E9817BB1F
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019512; cv=none; b=KaCpqeC0Azoj7yr9Ff2t19ETduaWx3ElTn5FudZrPNcsuXTlZt4sULGmDzgZnKEipIhwKeB2BQP+FCGVQPMZqBYSIHFnsA8w7I/wKXrJP0nNaaEUiBUjXC4A8IQc703n6FiX+HHoLOlY03/OOXTCKEZyYoA0JkrWXvBTNcTf3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019512; c=relaxed/simple;
	bh=xAZ9w2mpL/pwgf60fpSD3rtvrzIEULXXErstpTmWRIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/ltlKLLXq8ejtH2TYn1WqDPSvfDiWMLGc6m1xRlPCO3aIeXadDJZ5pBZpiyRey22s32YutfUzCKMBtybSRTXzSmoHXO3bXQDfSJgBEII8k022+uUXO79af2hxTjdFS/uQh29XU+ppBMfW86s7+GbeaYwXcYQbSwWSFrW9iDh8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jT0upB7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793FDC2BD10;
	Wed,  3 Jul 2024 15:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720019512;
	bh=xAZ9w2mpL/pwgf60fpSD3rtvrzIEULXXErstpTmWRIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jT0upB7aM7rY9k+36DlCLTR3bC9PGoaWzuiGJBW8T9wqeXfUTRBG9vpQORRzapd/V
	 S4WECOR5SwOm5S+laTdakQm3Uus+zKswuTnwjW9zb4Ufy81NPlr9hPchH1iiZM4ECL
	 fNQXm3/RQ0e+DBnH4Zr+UwVxtQu6uaf3LV2bwoPpUhxBcJTZbuSOuvloNRvC1Gj9qG
	 zxfHfYMJ+bNoQrml4QEYWvkw7kkkgVLv3b0SIV1R+VPeHByIXIBNpzHB3rhlbYcH56
	 OGszCcZsXpFSuC711hWDHMmhE1dYXk1E2HD9iHsOPSBExZcicLd/j9GEsEhM59RGZh
	 Q0rq+qF4wpgbg==
Date: Wed, 3 Jul 2024 11:11:51 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZoVqN7J6vbl0BzIl@kernel.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
 <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
 <ZoTb-OiUB5z4N8Jy@infradead.org>
 <ZoURUoz1ZBTZ2sr_@kernel.org>
 <ZoVdP-S01NOyZqlQ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVdP-S01NOyZqlQ@infradead.org>

On Wed, Jul 03, 2024 at 07:16:31AM -0700, Christoph Hellwig wrote:
> On Wed, Jul 03, 2024 at 04:52:34AM -0400, Mike Snitzer wrote:
> > Ultimately I simply wanted to keep momentum up, I'm sure you can
> > relate to having a vision for phasing changes in without missing a
> > cycle.  But happy to just continue working it into the 6.12
> > development window.
> 
> It just feels really rushed to have something with cross-subsystem
> communication going in past -rc6 in a US holiday week.  Sometimes
> not rushing things too much will lead to much better results.

Yes, I knew it to be very tight given the holiday.  I should've just
yielded to the reality of the calendar and there being some extra
changes needed (remove "fake" svc_rqst in fs/nfsd/localio.c -- I was
hopeful that could be done incrementally after merge but I digress).

Will welcome any help you might offer to optimize localio as much as
possible (doesn't need to be in near-term, whenever you might have
time to look).  Its current approach to use synchronous buffered
read_iter and write_iter, with active waiting, should be improved.

But Dave's idea to go full RMW to be page aligned will complicate a
forecasted NFS roadmap item to allow for: "do-not-cache capabilities,
so that the NFS server can turn off the buffer caching of files on
clients (force O_DIRECT-like writing/reading)".  But even that seems a
catch-22 given the NFS client doesn't enforce DIO alignment.

