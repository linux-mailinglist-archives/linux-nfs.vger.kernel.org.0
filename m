Return-Path: <linux-nfs+bounces-4607-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4BC9268CB
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 21:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E861B1F23F02
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 19:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7007183075;
	Wed,  3 Jul 2024 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0hodHOG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831EA178367
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033447; cv=none; b=nuqFRoV+Bsn3ZqkchWAJ/AbIfVE7bvuvO7L2KUcbd7MaLTlQpoFaKZO/iaJ6h0Vrzo/f8uQy0mLQ88ef4qaqHVQ9SCwstAD5nejq5tzX6s00ypVRFZfsC7Pa1WckGwvZv4oPfx3DPHBYzYY1Jw0YjpQulZSs9G+W4/lrSJ40bos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033447; c=relaxed/simple;
	bh=ZpM4dmzzMzO36Dx3BjAzWHqcuCtd2tR8JJ3ClLOl11o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1V1zZJB0TkS4XhYHBjgvXxN8o11NfTZ76SZPg0yWdk7TnsLyp9aox3YYgfvOL9FzU8IPKqkh455vC1Z2LhZM5m1jIb4k8NIaUdp6QN2h5MLx2ek1wd/g8eqhvCG6xna5iwEPD5nCvqLCPJwVwDK0KU7560nL+6D2UXGFBQmz30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0hodHOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D912EC2BD10;
	Wed,  3 Jul 2024 19:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720033447;
	bh=ZpM4dmzzMzO36Dx3BjAzWHqcuCtd2tR8JJ3ClLOl11o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0hodHOGCKUPhztm45gSI0J6bDmtMpabT1CbchnNTmFQJbl3q1EihkQbB2lYtKgV9
	 EIO/Jx8x9nvndI/fp7Nj9P/7FsAE1Y3a/5YkB3be6jOXlRiVa0uxZG6+NAiY6z5jvC
	 XGeF+SdaNroEl/85er9TJ7anccr0H5m4rfb46iwsYAI7S4p7qvQbztjXIPRu/8Ar5S
	 gMpcSfPc2Sno3t8o/IJema0lJjAWIGve9rePZi8Xms+vQ+k4DTFp/DGbzyU6qWeLHf
	 D7Zer6H8qOdQzSaw2ZZZLkaIdMHyiQsocyEhz/tfCzy6Ldcok9sTv4hrXo0zSixoLQ
	 4z7lXTsBdQBrg==
Date: Wed, 3 Jul 2024 15:04:05 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZoWgpTJkiPOmJi1L@kernel.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
 <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
 <ZoTb-OiUB5z4N8Jy@infradead.org>
 <ZoURUoz1ZBTZ2sr_@kernel.org>
 <ZoVdP-S01NOyZqlQ@infradead.org>
 <ZoVqN7J6vbl0BzIl@kernel.org>
 <ZoVrqp-EpkPAhTGs@infradead.org>
 <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>
 <ZoVv4IVNC2dP1EaM@kernel.org>
 <F5BE7C26-9E43-4514-9E5E-2B6F7B32569D@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F5BE7C26-9E43-4514-9E5E-2B6F7B32569D@oracle.com>

On Wed, Jul 03, 2024 at 05:19:06PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 3, 2024, at 11:36 AM, Mike Snitzer <snitzer@kernel.org> wrote:
> > 
> > On Wed, Jul 03, 2024 at 03:24:18PM +0000, Chuck Lever III wrote:
> > 
> >> IMO the design document should, as part of the problem statement,
> >> explain why a pNFS-only solution is not workable.
> > 
> > Sure, I can add that.
> > 
> > I explained the NFSv3 requirement when we discussed at LSF.
> 
> You explained it to me in a private conversation, although
> there was a lot of "I don't know yet" in that discussion.

Those "I don't know yet" were in response to you asking why a pNFS
layout (like the block layout) is not possible to achieve localio.

The answer to that is: someone(s) could try that, but there is no
interest from me or my employer to resort to using block layout with
centralized mapping of which client and DS are local so that the pNFS
MDS could handout such pNFS block layouts.

That added MDS complexity can be avoided if the client and server have
autonomy to negotiate more performant access without a centralized
arbiter (hence the "localio" handshake).

> It needs to be (re)explained in a public forum because
> reviewers keep bringing this question up.

Sure.

> I hope to see more than just "NFSv3 is in the mix". There
> needs to be some explanation of why it is necessary to
> support NFSv3 without the use of pNFS flexfile.

Loaded question there, not sure why you're leading with it being
invalid to decouple localio (leveraging client and server locality)
from pNFS.

NFS can realize benefits from localio being completely decoupled from
flexfiles and pNFS.  There are clear benefits with container use-cases
that don't use pNFS at all.

Just so happens that flexfiles ushers in the use of NFSv3.  Once the
client gets a flexfiles layout that points to an NFSv3 DS: the client
IO is issued in terms of NFSv3.  If the client happens to be on the
same host as the server then using localio is a win.

