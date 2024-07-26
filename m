Return-Path: <linux-nfs+bounces-5071-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F284B93D4B3
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 16:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211721C23B8D
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 14:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8079AD49;
	Fri, 26 Jul 2024 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhcKk4k0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38E4947E
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722002449; cv=none; b=EAv9xTIVTX+kzGeIVu/h/0iOzLJfN6DolNpkZRqk0s4Y7DYF/yqJgwhM/4SeBxUh6uZ1VNeXGc4Q0ipJ8W7FkZCLDjb41zD7cStSzPZC+fmLjzRqxHkE1f2ywC29kZH0Sa7f658xyFNfEwEK8jhrlTMZpU5YeajLjlQqhw5qk98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722002449; c=relaxed/simple;
	bh=cpn8u8gxOxZqMZVWg1yAprh0J5k167lBqpncx6b2ovs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RhqtQKQRUfiXx2X6Qk28A80oQbV6jZeXUjvPIb5V+PYeJQOHsZ38b3zp8PrVN0KfGLvVkY84v+/e9g12MYaOn3bCz831xaRpeeP940b9Amlnya10z6+UzHEMTMqObujVqpj7vO1RzBFjaLcR+2t3I5ihe3YVkeYkCyjFrmqDjGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhcKk4k0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D9BC4AF07;
	Fri, 26 Jul 2024 14:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722002449;
	bh=cpn8u8gxOxZqMZVWg1yAprh0J5k167lBqpncx6b2ovs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bhcKk4k0so2n4GBUYAYkWIViqymhJKYoLfU6agMqIMpNGjL69N1q/67vYvz7rb+sW
	 94suoS8cpV/FTemojDcXwWYYnUVxnSsp3rui1IA8fxPDO4IgICWl/S5C8uCcB8Y7hX
	 Y69dkdVMql6MyioMz12NBqldIOchUPpVCOMPPmwkmEo19Pu2OZmk95dbNDRWdBmGgB
	 9xyDOoZqnFYe6Zsx4EvyFnLS2TJUbNjgMnJiO7oeR/qfQb5I24eaLHAhbZPbE8XOd6
	 UxAGptZZiNKeffzuAkbRVrJo7P30CqqOeMc+xKQWOJ4R5BT3UERJ1zuQ1UI4flCbNh
	 7KJ/bVIURZfVw==
Message-ID: <3128788be5ddbd9ae858ea5dbf8254ad663a4d37.camel@kernel.org>
Subject: Re: [PATCH rfc 2/2] NFSD: allow client to use write delegation
 stateid for READ
From: Jeff Layton <jlayton@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>, Olga Kornievskaia <aglo@umich.edu>
Cc: Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <dai.ngo@oracle.com>, 
	linux-nfs@vger.kernel.org
Date: Fri, 26 Jul 2024 10:00:47 -0400
In-Reply-To: <683439e6-3251-4ffa-bac1-21343e05db4e@grimberg.me>
References: <20240724170138.1942307-1-sagi@grimberg.me>
	 <20240724170138.1942307-2-sagi@grimberg.me>
	 <CAN-5tyF4fjD4sGDx7CTnYWuCcOLsX3dSQpiPyLNNQAM1Hd5TJg@mail.gmail.com>
	 <683439e6-3251-4ffa-bac1-21343e05db4e@grimberg.me>
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

On Wed, 2024-07-24 at 14:47 -0700, Sagi Grimberg wrote:
>=20
>=20
>=20
> On 24/07/2024 22:29, Olga Kornievskaia wrote:
> > On Wed, Jul 24, 2024 at 1:01=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me=
>
> > wrote:
> > > Based on a patch fom Dai Ngo, allow NFSv4 client to use write
> > > delegation
> > > stateid for READ operation. Per RFC 8881 section 9.1.2. Use of
> > > the
> > > Stateid and Locking.
> > >=20
> > > In addition, for anonymous stateids, check for pending
> > > delegations by
> > > the filehandle and client_id, and if a conflict found, recall the
> > > delegation
> > > before allowing the read to take place.
> > >=20
> > > Suggested-by: Dai Ngo <dai.ngo@oracle.com>
> > > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > > ---
> > > =C2=A0 fs/nfsd/nfs4proc.c=C2=A0 | 22 +++++++++++++++++++--
> > > =C2=A0 fs/nfsd/nfs4state.c | 47
> > > +++++++++++++++++++++++++++++++++++++++++++++
> > > =C2=A0 fs/nfsd/nfs4xdr.c=C2=A0=C2=A0 |=C2=A0 9 +++++++++
> > > =C2=A0 fs/nfsd/state.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> > > =C2=A0 fs/nfsd/xdr4.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> > > =C2=A0 5 files changed, 80 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > index 7b70309ad8fb..324984ec70c6 100644
> > > --- a/fs/nfsd/nfs4proc.c
> > > +++ b/fs/nfsd/nfs4proc.c
> > > @@ -979,8 +979,24 @@ nfsd4_read(struct svc_rqst *rqstp, struct
> > > nfsd4_compound_state *cstate,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* check stateid */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D nfs4_prep=
rocess_stateid_op(rqstp, cstate,
> > > &cstate->current_fh,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 &read->rd_stateid,
> > > RD_STATE,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 &read->rd_nf, NULL);
> > > -
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 &read->rd_nf, &read-
> > > >rd_wd_stid);
> > Now I can see that this patch wants to leverage the "returned
> > stateid
> > of the nfs4_preprocess_stateid_op() but the logic in the previous
> > patch was in the way because it distinguished the copy_notify by
> > the
> > non-null passed in stateid. So I would suggest that in order to not
> > break the copy_notify and help with this functionality something
> > else
> > is sent into nfs4_proprocess_staetid_op() to allow for the stateid
> > to
> > be passed and then distinguish between copy_notify and read.
>=20
> My thinking is that instead having the generic stateid pre-processing
> be aware which proc may accept a special stateid and which may not,
> we'd want to have the call-sites enforce that...
>=20
> But I am not the expert here, and will be happy to change based on
> your preference...

I tend to agree with Sagi here. Keeping this sort of operation-specific
check in the operation-specific function makes more sense to me too.
--=20
Jeff Layton <jlayton@kernel.org>

