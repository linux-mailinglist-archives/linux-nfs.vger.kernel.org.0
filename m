Return-Path: <linux-nfs+bounces-6367-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 530EF973810
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 14:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C837286D9B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 12:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7729C191F97;
	Tue, 10 Sep 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvLSN6hB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C1A1917FA
	for <linux-nfs@vger.kernel.org>; Tue, 10 Sep 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725972726; cv=none; b=q1fThDkcrOw1exriiE64KtZ9Ns0ua0JZQDAXB6OzzOhFd+6c7vELYhIB09DVPd1DgVuAXXpOCdEXXuQBhHyOfDfCsiZ3oKN5jOcWzJRvq/9Y4VLnf6+LkHonQKymzdNzHh7V0/FzgWGFc2MHxp/C4wHNCKmU49PPfzlVQmUXCfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725972726; c=relaxed/simple;
	bh=jPKCZgr92hVekWicb7VW8tZKTVP+SkPDo/iNZFbGal8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LTA2oBzpa7SMacZKQ9qjt+RS/zXs/AtSt7WH3eIZllMAypd+4d1UW6Xmmm/eEj+SR8+Nh8lxKdtQaTWdIpyxLRKGgaMzD7G4uS7x/Xekprn3yD9wFO8cymtsZqGUwUBJsDWyBk5qIoapuJ0MbmUb2hD1ETTyPCnKwbGQNkI07K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvLSN6hB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B53EC4CEC6;
	Tue, 10 Sep 2024 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725972725;
	bh=jPKCZgr92hVekWicb7VW8tZKTVP+SkPDo/iNZFbGal8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rvLSN6hBE5CxQLsZUDwaVWZc5bub1zK2Xa0XOytwMelsmunq3Tjxgcj+BA/ngtCLc
	 udzx4ijRlbP4nx0yLrSbyKQs9QapIUni+IXguUAqrtxeyOSJttdJtxMvlUEeHLcXKl
	 vIOBIs8jiYq1y7O5hpMxMpLCde6CVknDM5jDTI0t/uSXHAHW71porppezXuHe6qenA
	 /fceHlzOgmk92FCCC0VfVkvRbPWMFGALhlUyVUAHm42GjNo1AkBEkpV/zUo01DQRRe
	 jwJZL3jU+YGX20ZIqN473e9tZ+e467w4qV4LSmtpUQMPyaBrigxXpUeeuZkfS7n55S
	 DbaFra+GEZprA==
Message-ID: <8e02bafe8027b060b38d38ebbd3092d2beb35206.camel@kernel.org>
Subject: Re: [PATCH] nfsd: fix delegation_blocked() to block correctly for
 at least 30 seconds
From: Jeff Layton <jlayton@kernel.org>
To: Tom Talpey <tom@talpey.com>, Olga Kornievskaia <okorniev@redhat.com>, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@suse.de>, Dai Ngo <Dai.Ngo@oracle.com>, 
	linux-nfs@vger.kernel.org
Date: Tue, 10 Sep 2024 08:52:04 -0400
In-Reply-To: <727023c4-416d-43ba-a82a-3fbd0a831f49@talpey.com>
References: <172585839640.4433.13337900639103448371@noble.neil.brown.name>
	 <adadfa97e30bc4d827df194814e4e05aa26b8266.camel@kernel.org>
	 <CACSpFtBYpQpAKVOmHLPUOr5LvoYq0-ea_NFMctqhMYSamUL_ZQ@mail.gmail.com>
	 <Zt8IOQUF/VEkCPgO@tissot.1015granger.net>
	 <CACSpFtCD-yBiO3Oe9m8k9q6Wug6MqgNQmjoT9K8DRAmc3bGLfg@mail.gmail.com>
	 <727023c4-416d-43ba-a82a-3fbd0a831f49@talpey.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-10 at 08:32 -0400, Tom Talpey wrote:
> On 9/9/2024 11:02 AM, Olga Kornievskaia wrote:
> > On Mon, Sep 9, 2024 at 10:38=E2=80=AFAM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> > >=20
> > > On Mon, Sep 09, 2024 at 10:17:42AM -0400, Olga Kornievskaia wrote:
> > > > On Mon, Sep 9, 2024 at 8:24=E2=80=AFAM Jeff Layton <jlayton@kernel.=
org> wrote:
> > > > >=20
> > > > > On Mon, 2024-09-09 at 15:06 +1000, NeilBrown wrote:
> > > > > > The pair of bloom filtered used by delegation_blocked() was int=
ended to
> > > > > > block delegations on given filehandles for between 30 and 60 se=
conds.  A
> > > > > > new filehandle would be recorded in the "new" bit set.  That wo=
uld then
> > > > > > be switch to the "old" bit set between 0 and 30 seconds later, =
and it
> > > > > > would remain as the "old" bit set for 30 seconds.
> > > > > >=20
> > > > >=20
> > > > > Since we're on the subject...
> > > > >=20
> > > > > 60s seems like an awfully long time to block delegations on an in=
ode.
> > > > > Recalls generally don't take more than a few seconds when things =
are
> > > > > functioning properly.
> > > > >=20
> > > > > Should we swap the bloom filters more often?
> > > >=20
> > > > I was also thinking that perhaps we can do 15-30s perhaps? Another
> > > > thought was should this be a configurable value (with some
> > > > non-negotiable min and max)?
> > >=20
> > > If it needs to be configurable, then we haven't done our jobs as
> > > system architects. Temporarily blocking delegation ought to be
> > > effective without human intervention IMHO.
> > >=20
> > > At least let's get some specific usage scenarios that demonstrate a
> > > palpable need for enabling an admin to adjust this behavior (ie, a
> > > need that is not simply an implementation bug), then design for
> > > those specific cases.
> > >=20
> > > Does NFSD have metrics in this area, for example?
> > >=20
> > > Generally speaking, though, I'm not opposed to finessing the behavior
> > > of the Bloom filter. I'd like to apply the patch below for v6.12,
> >=20
> > 100% agreed that we need this patch to go in now. The configuration
> > was just a thought for after which I should have stated explicitly. I
> > guess I'm not a big fan of hard coded numbers in the code and naively
> > thinking that it's always better to have a config over a hardcoded
> > value.
>=20
> No constant is ever correct in networking, especially timeouts. So yes,
> it should be adjustable. But even then, choosing a number here is
> fundamentally difficult.
>=20
> Delegations can block for perfectly valid long periods, right? Say it
> takes a long time to flush a write delegation, or if the network is
> partitioned to the (other) client being recalled. 30 seconds to data
> corruption is quite the guillotine.
>=20

I don't think this is danger of data corruption here. The bloom filter
is there to keep the server from handing out a new delegation too
quickly after having to recall one. Allowing no delegations for 30-60s
seems a bit too cautious, IMO.=20

Ideally it seems like we'd want this to be some function of the delay
between the server issuing the CB_RECALL, and the client doing the
DELEGRETURN.

That value is obviously highly variable, but it would be an interesting
statistic to collect, and might help inform what the bloom filter delay
should be.

> > > preserving the Cc: stable, but handle the behavioral finessing via
> > > a subsequent patch targeting v6.13 so that can be appropriately
> > > reviewed and tested. Ja?
> > >=20
> > > BTW, nice catch!
> > >=20
> > >=20
> > > > > > Unfortunately the code intended to clear the old bit set once i=
t reached
> > > > > > 30 seconds old, preparing it to be the next new bit set, instea=
d cleared
> > > > > > the *new* bit set before switching it to be the old bit set.  T=
his means
> > > > > > that the "old" bit set is always empty and delegations are bloc=
ked
> > > > > > between 0 and 30 seconds.
> > > > > >=20
> > > > > > This patch updates bd->new before clearing the set with that in=
dex,
> > > > > > instead of afterwards.
> > > > > >=20
> > > > > > Reported-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Fixes: 6282cd565553 ("NFSD: Don't hand out delegations for 30 s=
econds after recalling them.")
> > > > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > > > ---
> > > > > >   fs/nfsd/nfs4state.c | 5 +++--
> > > > > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > > > > >=20
> > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > index 4313addbe756..6f18c1a7af2e 100644
> > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > @@ -1078,7 +1078,8 @@ static void nfs4_free_deleg(struct nfs4_s=
tid *stid)
> > > > > >    * When a delegation is recalled, the filehandle is stored in=
 the "new"
> > > > > >    * filter.
> > > > > >    * Every 30 seconds we swap the filters and clear the "new" o=
ne,
> > > > > > - * unless both are empty of course.
> > > > > > + * unless both are empty of course.  This results in delegatio=
ns for a
> > > > > > + * given filehandle being blocked for between 30 and 60 second=
s.
> > > > > >    *
> > > > > >    * Each filter is 256 bits.  We hash the filehandle to 32bit =
and use the
> > > > > >    * low 3 bytes as hash-table indices.
> > > > > > @@ -1107,9 +1108,9 @@ static int delegation_blocked(struct knfs=
d_fh *fh)
> > > > > >                if (ktime_get_seconds() - bd->swap_time > 30) {
> > > > > >                        bd->entries -=3D bd->old_entries;
> > > > > >                        bd->old_entries =3D bd->entries;
> > > > > > +                     bd->new =3D 1-bd->new;
> > > > > >                        memset(bd->set[bd->new], 0,
> > > > > >                               sizeof(bd->set[0]));
> > > > > > -                     bd->new =3D 1-bd->new;
> > > > > >                        bd->swap_time =3D ktime_get_seconds();
> > > > > >                }
> > > > > >                spin_unlock(&blocked_delegations_lock);
> > > > >=20
> > > > > --
> > > > > Jeff Layton <jlayton@kernel.org>
> > > > >=20
> > > >=20
> > >=20
> > > --
> > > Chuck Lever
> > >=20
> >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

