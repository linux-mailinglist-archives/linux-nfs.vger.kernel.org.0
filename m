Return-Path: <linux-nfs+bounces-9752-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5492A21F58
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 15:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B6C1880227
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 14:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6983D1A08DB;
	Wed, 29 Jan 2025 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dx5V6ags"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4116342049;
	Wed, 29 Jan 2025 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738161552; cv=none; b=ceNCrHG5qnVNR6+OC3e2qDvNR0UT3PipK4mD8W5Yft7qtAtxryH4iFZsH0ccPVUYkPAAr5UOXXGyw3FGowQshbYbqBAAoLwssmu2QWUH81zRGQ+zlf/Om3ZEste+4A54KQE3mmOjh6GSRzvf/m9NuaXFmiVpK0CIFt6RfZzGffA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738161552; c=relaxed/simple;
	bh=8oSoujiQvWMZRWE4d+kFdjQtEAuSGGAHWGMoHqRjvnY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ulw2g0huU86isY4jjKM+/yqYgeqPLXL18dzZhHaQbKqBVMO//VzxnaLkjLBFb3bS8v97ZM7D1QObdiiPQ9JRdsALcl5PVgX+NSNymi4ToFWQFhwwhgB839tV/20jRN7G/CtV2jWsLut5mHMz3UjBL+KfwczW1r4hr3qJ80G8LY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dx5V6ags; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB80C4CED1;
	Wed, 29 Jan 2025 14:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738161551;
	bh=8oSoujiQvWMZRWE4d+kFdjQtEAuSGGAHWGMoHqRjvnY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dx5V6agsyZ/cesol9Y3gaLGQj3FOyTpLtfwPrcPPkOAmqO1VkVwVTmGf3K+Eyn58Y
	 j4brYJ0BiaRYb9pwzzlFIWPENGsplfqEV3tvodRTiLLhOer7awjHZqNgmA5iroudmv
	 6UKI30R/Yp2XaQArWzMnhy4zSY6CpOpXio/jxAeXL6NY9n0ZdvvIKnvx14JggxeV+c
	 BeBsEWkXFNmWF+/8nWh/Gq3p7I/YdC9BxcP16CI5n/Q7PjjZiJQG2jtVFfZO1QehEQ
	 VbYUpgkvUMMG+3tDhOyED0j7ndsk9doO9bLDPr4keYY+5JUleDAgvuw8AwvVuHFWuS
	 Xsdqf3g/M8rwQ==
Message-ID: <e7bac9378168056a7000959cd920e8c703b0c7fe.camel@kernel.org>
Subject: Re: [PATCH v2 0/7] nfsd: CB_SEQUENCE error handling fixes and
 cleanups
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, Kinglong
 Mee <kinglongmee@gmail.com>, Trond Myklebust	 <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 29 Jan 2025 09:39:09 -0500
In-Reply-To: <2f2c7a8b-d44b-4f41-99db-f3401108198c@oracle.com>
References: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
	 <2f2c7a8b-d44b-4f41-99db-f3401108198c@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-29 at 09:22 -0500, Chuck Lever wrote:
> On 1/29/25 8:39 AM, Jeff Layton wrote:
> > While looking over the CB_SEQUENCE error handling, I discovered that
> > callbacks don't hold a reference to a session, and the
> > clp->cl_cb_session could easily change between request and response.
> > If that happens at an inopportune time, there could be UAFs or weird
> > slot/sequence handling problems.
> >=20
> > This series changes the nfsd4_session to be RCU-freed, and then adds a
> > new method of session refcounting that is compatible with the old.
> > nfsd4_callback RPCs will now hold a lightweight reference to the sessio=
n
> > in addition to the slot. Then, all of the callback handling is switched
> > to use that session instead of dereferencing clp->cb_cb_session.
> > I've also reworked the error handling in nfsd4_cb_sequence_done()
> > based on review comments, and lifted the v4.0 handing out of that
> > function.
> >=20
> > This passes pynfs, nfstests, and fstests for me, but I'm not sure how
> > much any of that stresses the backchannel's error handling.
> >=20
> > These should probably go in via Chuck's tree, but the last patch touche=
s
> > some NFS cnd sunrpc client code, so it'd be good to have R-b's or A-b's
> > from Trond and/or Anna on that one.
>=20
> A few initial reactions as I get to know this new revision.
>=20
> - I have no objection to 7/7, but it does seem a bit out of place in
>    this series. Maybe hold it back and send it separately after this
>    series goes in?
>=20
> - The fact that the session can be replaced while a callback operation
>    is pending suggests that, IIUC, decode_cb_sequence() sanity checking
>    will fail in such cases, and it's not because of a bug in the client's
>    callback server. Or maybe I'm overthinking it - that is exactly what
>    you are trying to prevent?
>=20

That's the best-case scenario, but callbacks can run at any time. If
this happens at the wrong time this could crash or cause more subtle
problems than just a spurious ESERVERFAULT. IOW, we could pass
decode_cb_sequence(), then the pointer changes and then
nfsd4_cb_sequence_done() ends up working with a different session.

> - In 1/7, the kdoc comment for "get" should enumerate the return values
>    and their meanings.
>=20

Ack

> - cb_session_changed =3D> nfsd4_cb_session_changed.
>=20

Ack

> - I'm still not convinced it's wise to bump the slot number in the
>    ESERVERFAULT case.
>=20

It's debatable for sure. The client _did_ respond with NFS4_OK in this
case, but it is a bit sketchy since something else didn't match. I'm
fine with removing that seq bump if you prefer.

> - IMO the cb_sequence_done rework should rename "need_restart" to
>    "need_requeue" or just "requeue" -- there is a call to
>    rpc_restart_call_prepare() here that is a little confusing and
>    could do with some disambiguation.
>=20

Good point. I'll change that too.

Thanks for the review!

>=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > Changes in v2:
> > - make nfsd4_session be RCU-freed
> > - change code to keep reference to session over callback RPCs
> > - rework error handling in nfsd4_cb_sequence_done()
> > - move NFSv4.0 handling out of nfsd4_cb_sequence_done()
> > - Link to v1: https://lore.kernel.org/r/20250123-nfsd-6-14-v1-0-c1137a4=
fa2ae@kernel.org
> >=20
> > ---
> > Jeff Layton (7):
> >        nfsd: add routines to get/put session references for callbacks
> >        nfsd: make clp->cl_cb_session be an RCU managed pointer
> >        nfsd: add a cb_ses pointer to nfsd4_callback and use it instead =
of clp->cb_cb_session
> >        nfsd: overhaul CB_SEQUENCE error handling
> >        nfsd: remove unneeded forward declaration of nfsd4_mark_cb_fault=
()
> >        nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()
> >        sunrpc: make rpc_restart_call() and rpc_restart_call_prepare() v=
oid return
> >=20
> >   fs/nfs/nfs4proc.c           |  12 ++-
> >   fs/nfsd/nfs4callback.c      | 212 ++++++++++++++++++++++++++++++++---=
---------
> >   fs/nfsd/nfs4state.c         |  43 ++++++++-
> >   fs/nfsd/state.h             |   6 +-
> >   fs/nfsd/trace.h             |   6 +-
> >   include/linux/sunrpc/clnt.h |   4 +-
> >   net/sunrpc/clnt.c           |   7 +-
> >   7 files changed, 210 insertions(+), 80 deletions(-)
> > ---
> > base-commit: a05af3c6103b703d1d38d8180b3ebbe0a03c2f07
> > change-id: 20250123-nfsd-6-14-b0797e385dc0
> >=20
> > Best regards,
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

