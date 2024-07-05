Return-Path: <linux-nfs+bounces-4662-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9E5928DAA
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 20:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B675C1F22DC6
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 18:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD6813AD37;
	Fri,  5 Jul 2024 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZjI54CX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265ED81E
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jul 2024 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720205951; cv=none; b=uDH40asN4FzA8IGXfCI7dYYjypq7lnUU907s5jxXauCZ3SJFxZufN8GnGLUVwetZjETvwbcf/I44+DxORQPG5HbY7xw8NFF0rwlPPfx5nmL6xOoNSTKo3+KpdQ83pSW5v8CkJygiwbHz3u61f0xFU/R8hsIE3gayzUh/pY2fems=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720205951; c=relaxed/simple;
	bh=Z/FuEGVK9IpXZP6bHQbgiyeTbOiWlc2rHUTh3juZVSA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QcBL2tLognSO2TgkzM7Xqclw+lgr2KfglvraKIEWDrdcCZhQzPEY42RDsPxFdFvwhoIhl/vQL670kzbsW82oqNyiFmhxHopNvxwN1c++ksoO6asqtgdfXBFp+6W36imitC6h22PcHgOvjOm4ajjxB9rDPoi2u+GpYAJFsuPaofo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZjI54CX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0900C116B1;
	Fri,  5 Jul 2024 18:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720205950;
	bh=Z/FuEGVK9IpXZP6bHQbgiyeTbOiWlc2rHUTh3juZVSA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=uZjI54CXOBVIWm4aFMNRoZztNdSf8BZys7TnixTBOQQY0AmwG1czjxZthHnv6bilu
	 RoCIY6eu+SFoGeW5IIKdQrBhgSRnYV99bM2/TJfawldRa8rvVo/lqwBv/20s5Gm7LF
	 qPkG1tRcH8Y4MxnFssBhEmnpVK/h9URnaxaKh2ULJvZjbMIYzDouL1PxhuqV6qbRSJ
	 vroGZLEtGKn2hAh8TItTARCWzcwip2axHnPTO/Qug8qYsx+cJBfhXjA7T0NIhAjMQl
	 N2eMowlnlN3eNzSQQ/MefCdiBKu1Wx/3QvyjA14o5SKx1Dj4aK7suke5TC4cLTbscO
	 grLUVj5rMBZQQ==
Message-ID: <3e01e99ba82d0135c11f5c9414b28652c5eb26b0.camel@kernel.org>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever III <chuck.lever@oracle.com>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>, Anna Schumaker <anna@kernel.org>, Trond
 Myklebust <trondmy@hammerspace.com>, Neil Brown <neilb@suse.de>, Dave
 Chinner <david@fromorbit.com>
Date: Fri, 05 Jul 2024 14:59:08 -0400
In-Reply-To: <ZogFBqv0z7Rnh4_p@kernel.org>
References: <ZoVrqp-EpkPAhTGs@infradead.org>
	 <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>
	 <ZoVv4IVNC2dP1EaM@kernel.org>
	 <4486ee80a487c174ec88c7e12705d99e22ae812a.camel@kernel.org>
	 <ZoY6e-BmRJFLkziG@infradead.org> <ZobqkgBeQaPwq7ly@kernel.org>
	 <ZoeCFwzmGiQT4V0a@infradead.org>
	 <57C1CB2B-3B46-48F3-A095-417845001C3E@oracle.com>
	 <ZogAEqYvJaYLVyKj@kernel.org> <ZogAtVfeqXv3jgAv@infradead.org>
	 <ZogFBqv0z7Rnh4_p@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-05 at 10:36 -0400, Mike Snitzer wrote:
> On Fri, Jul 05, 2024 at 07:18:29AM -0700, Christoph Hellwig wrote:
> > On Fri, Jul 05, 2024 at 10:15:46AM -0400, Mike Snitzer wrote:
> > > NFSv3 is needed because NFSv3 is used to initiate IO to NFSv3
> > > knfsd on
> > > the same host.
> >=20
> > That doesn't really bring is any further.=C2=A0 Why is it required?
> >=20
> > I think we'll just need to stop this discussion until we have
> > reasonable
> > documentation of the use cases and assumptions, because without
> > that
> > we'll get hund up in dead loops.
>=20
> It _really_ isn't material to the core capability that localio
> provides.
> localio supporting NFSv3 is beneficial for NFSv3 users (NFSv3 in
> containers).
>=20
> Hammerspace needs localio to work with NFSv3 to assist with its "data
> movers" that run on the host (using nfs and nfsd).
>=20
> Please just remove yourself from the conversation if you cannot make
> sense of this.=C2=A0 If you'd like to be involved, put the work in to
> understand the code and be professional.

I disagree wholeheartedly with this statement. Christoph has raised a
very valid point. You have _not_ articulated why v3 access is important
here.

I'm aware of why it is (at least to HS), and I think there are other
valid reasons to keep v3 in the mix (as Neil has pointed out). But,
that info should be in the cover letter and changelogs. Not everyone
has insight into this, and tbqh, my understanding could be wrong.

Let's do please try to keep the discussion civil.
--=20
Jeff Layton <jlayton@kernel.org>

