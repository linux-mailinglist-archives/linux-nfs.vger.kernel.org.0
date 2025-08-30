Return-Path: <linux-nfs+bounces-13957-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D011B3CE43
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Aug 2025 19:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B953BD241
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Aug 2025 17:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7072D29B7;
	Sat, 30 Aug 2025 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNl0xy6Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397EB274668
	for <linux-nfs@vger.kernel.org>; Sat, 30 Aug 2025 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756575534; cv=none; b=QW2QDddUyuGnmRNobIbePEk1EIf+LauNjWiOvLgjPYb1B6YY+sW1XYG1WgPxshrOubFxh2OksSI8ylqEo5eMK2jSpADG3qedvRvyJwQqBJxPm/dhFG59e/UAPgmBgfahOVNKxOPvH5xz+xvmywVhY2yEkhFiNLFSjUwXgeyC0+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756575534; c=relaxed/simple;
	bh=iv4do4bddqZ9KbsQl0Ahnua/OIenrRG/Fa8lq2YH84c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7Cr2BV8mhnKOfCWPkM18qYoYWLpmtP5x5ex9zjHkGP/hcdxrtb9p6txv2qIPv96bwm/IrvC2dgb+pPhECPlTKPitlXrqhpKPEqx8joRbS07QjXXif2ixL7GDGI3rFWKp8yjTlM4S2kxIHqQVtfkm6uz3SbIl+OIK3VLyGhabiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNl0xy6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0E4C4CEEB;
	Sat, 30 Aug 2025 17:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756575533;
	bh=iv4do4bddqZ9KbsQl0Ahnua/OIenrRG/Fa8lq2YH84c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNl0xy6QFvcQljeeBsHJ66V1pGCECFII7MiClmCv5pSJnYUVd+eoIlCHg/9whDiWL
	 1OkIY9tXePH2EioVu2AkpD0vlpCfyyd1Edw5iTrxj+H23CzFxqHntoA2ywxreK9cwX
	 MXFrLzBtCgD3bG2+hLdd7hUATHzn/vBxhzN0cMtWX9RfJpTlGDDm6T8vmC6jqspHEs
	 uOPlLH7ENcYT/OEBbyQ4bSn7vdoI+YIE/6WgM2K3LFJb+TaJwSK46baWPboxFruK71
	 WyB+iYgNqUytUChxclUe5e0vcDqTId8Ct7w1o1XHKxrmCDGKxPoGbsfHXwdmF+g9Zu
	 KpxPZjCp53f4A==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH 0/2] some progress on rpcrdma bug [was: Re: [PATCH v8 5/7] NFSD: issue READs using O_DIRECT even if IO is misaligned]
Date: Sat, 30 Aug 2025 13:38:50 -0400
Message-ID: <20250830173852.26953-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <aLClcl08x4JJ1UJu@kernel.org>
References: <aLClcl08x4JJ1UJu@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chuck,

[just including context from thread in cover-letter for these 2 RFC patches]

On Thu, Aug 28, 2025 at 02:52:34PM -0400, Mike Snitzer wrote:
> On Thu, Aug 28, 2025 at 10:53:49AM -0400, Chuck Lever wrote:
> > On 8/28/25 4:09 AM, Mike Snitzer wrote:
> > > On Wed, Aug 27, 2025 at 09:57:39PM -0400, Chuck Lever wrote:
> > >>>
<snip>
> > >>>> - When the I/O is complete, adjust the offset in the first bvec entry
> > >>>>   forward by setting a non-zero page offset, and adjust the returned
> > >>>>   count downward to match the requested byte count from the client
> > >>>
> > >>> Tried it long ago, such bvec manipulation only works when not using
> > >>> RDMA.  When the memory is remote, twiddling a local bvec isn't going
> > >>> to ensure the correct pages have the correct data upon return to the
> > >>> client.
> > >>>
> > >>> RDMA is why the pages must be used in-place, and RDMA is also why
> > >>> the extra page needed by this patch (for use as throwaway front-pad
> > >>> for expanded misaligned DIO READ) must either be allocated _or_
> > >>> hopefully it can be from rq_pages (after the end of the client
> > >>> requested READ payload).
<snip>

> > >> There's nothing I can think of in the RDMA or RPC/RDMA protocols that
> > >> mandates that the first page offset must always be zero. Moving data
> > >> at one address on the server to an entirely different address and
> > >> alignment on the client is exactly what RDMA is supposed to do.
> > >>
> > >> It sounds like an implementation omission because the server's upper
> > >> layers have never needed it before now. If TCP already handles it, I'm
> > >> guessing it's going to be straightforward to fix.
> > > 
> > > I never said that first page offset must be zero.  I said that I
> > > already did what you suggested and it didn't work with RDMA.  This is
> > > recall of too many months ago now, but: the client will see the
> > > correct READ payload _except_ IIRC it is offset by whatever front-pad
> > > was added to expand the misaligned DIO; no matter whether
> > > rqstp->rq_bvec updated when IO completes.
> > > 
> > > But I'll revisit it again.
> > 
> > For the record, this email thread is the very first time I've heard that
> > you tried the simple approach and that it worked with TCP and not with
> > RDMA. I wish I had known that a while ago.
> 
> Likewise, but the story is all in the patch header and the code tells
> the story too. Hence your finding it with closer review (thanks for
> that BTW!). I agree something is off so I'm happy to work it further.
> 
> I have iterated on quite a few aspects to this patch 5. Christoph had
> suggestion for using memmove in nfsd_complete_misaligned_read_dio.
> You had the feedback that required ensuring the lightest touch
> relative to branching so that buffered IO mode remain as fast as
> possible.
> 
> Looking forward to tackling this RDMA-specific weirdness now.

Hopeful these 2 patches more clearly demonstrate what I'm finding
needed when using RDMA with my NFSD misaligned DIO READ patch.

These patches build ontop of my v8 patchset. I've included quite a lot
of context for the data mismatch seen by the NFS client, etc in the
patch headers.

If I'm understanding you correctly, next step is to look closer at the
rpcrdma code that would skip the throwaway front-pad page from being
mapped to the start of the RDMA READ payload returned to the NFS
client?

Such important adjustment code would need to know that the rq_bvec[]
that reflects the READ payload doesn't include a bvec that points to
the first page of rqstp->rq_pages (pointed to by rqstp->rq_next_page
on entry to nfsd_iter_read) -- so it must skip past that memory in
the READ payload's RDMA memory returned to NFS client?

Thanks,
Mike

Mike Snitzer (2):
  NFSD: fix misaligned DIO READ to not use a start_extra_page, exposes rpcrdma bug?
  NFSD: use /end/ of rq_pages for front_pad page, simpler workaround for rpcrdma bug

 fs/nfsd/vfs.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

-- 
2.44.0


