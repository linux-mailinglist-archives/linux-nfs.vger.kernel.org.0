Return-Path: <linux-nfs+bounces-9314-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03322A13E09
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 16:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F269188D88B
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 15:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7553B22C9F5;
	Thu, 16 Jan 2025 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGV1Rr3d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5031C1DE881
	for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042179; cv=none; b=Sq+3RAZRdc34/Fiu7VhLHpbqVcTSWjVcHxG+n5EZO+rotUZfVs3gtL0uFBFMJB1HnFanGLjlE0VEN5eePGBQ0QyO/0gbAc25GYZOvjvq4pVT26bS3hEtJglra9C1QTeLzQzCp0nJvExgKanxw+ZjN0U+qMVQQJ9AchRxGzHul10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042179; c=relaxed/simple;
	bh=7mdZP+xYz2ozKyhLZC2kjuvvKP91l8E0oLFE7c+nHTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qq3ApKxva7wXetdHDUVNF/oK+hnmfvTKaMF17vp4Nvi/0HU2FbSEmd00tEfiWvm2hQDvItFB4EfZlfgob4SSOlsbtR+CUTsvwucjKwDKrtkeGHXhwC2FOZ3SssvPrt+ZQfrqWkYbHnuZt3odr8RN9Ddl4h89QPE2gWhnJm9aceg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGV1Rr3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F70AC4CEE1;
	Thu, 16 Jan 2025 15:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737042178;
	bh=7mdZP+xYz2ozKyhLZC2kjuvvKP91l8E0oLFE7c+nHTs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dGV1Rr3dgdH5wAww4gpjkgCcu0vl9jjCXGmslGUFa0jaTP/8g357HnZ8qnXNJdFkN
	 KSYoTUX78OeJmMQDF648yxC5UpoyAXdKubojxSj/n9HTnZAORjJ65POUhSOOSEIKCW
	 4t0LPg93stV0bj+bPFwzcKi/TswdsESwONT9IvryGiHSYzjk5f3qrJZ9MAdzDNcXH+
	 KDHSxesJ+zi/JZ6X4Xdz64IewEFDzcuoZu71KGeqweYchPlkeCAl5OU/gpnALoDutW
	 zu2yCoSeY0EPfHhh7a69nrmbKweWwEaCi5egyqfCcgJR+BPJ2ZDymIx/IKjd6T9bZR
	 89tYU8Xc+2rKQ==
Message-ID: <9757da07ce21d1c1275c637ae49cbe69a9c83a71.camel@kernel.org>
Subject: Re: [PATCH 1/3] llist: add ability to remove a particular entry
 from the list
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia
	 <okorniev@redhat.com>
Cc: linux-nfs@vger.kernel.org
Date: Thu, 16 Jan 2025 10:42:57 -0500
In-Reply-To: <f2c87e35-2ce4-455b-bd1b-e567123b368f@oracle.com>
References: <20250115232406.44815-1-okorniev@redhat.com>
	 <20250115232406.44815-2-okorniev@redhat.com>
	 <b469204c-adb7-4cc6-a8e9-dfd19ee331df@oracle.com>
	 <CACSpFtAgN7+7Bwa2dQckdC++QF-zP-ZBPyiphqoV2VgPatQt1g@mail.gmail.com>
	 <f2c87e35-2ce4-455b-bd1b-e567123b368f@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-16 at 10:33 -0500, Chuck Lever wrote:
> On 1/16/25 9:54 AM, Olga Kornievskaia wrote:
> > On Thu, Jan 16, 2025 at 9:27=E2=80=AFAM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> > >=20
> > > On 1/15/25 6:24 PM, Olga Kornievskaia wrote:
> > > > nfsd stores its network transports in a lwq (which is a lockless li=
st)
> > > > llist has no ability to remove a particular entry which nfsd needs
> > > > to remove a listener thread.
> > >=20
> > > Note that scripts/get_maintainer.pl says that the maintainer of this
> > > file is:
> > >=20
> > >     linux-kernel@vger.kernel.org
> > >=20
> > > so that address should appear on the cc: list of this series. So
> > > should the list of reviewers for NFSD that appear in MAINTAINERS.
> >=20
> > I will resend and include the mentioned list.
> >=20
> > > ISTR Neil found the same gap in the llist API. I don't think it's
> > > possible to safely remove an item from the middle of an llist. Much
> > > of the complexity of the current svc thread scheduler is due to this
> > > complication.
> > >=20
> > > I think you will need to mark the listener as dead and find some
> > > way of safely dealing with it later.
> >=20
> > A listener can only be removed if there are no active threads. This
> > code in nfsd_nl_listener_set_doit()  won't allow it which happens
> > before we are manipulating the listener:
> >          /* For now, no removing old sockets while server is running */
> >          if (serv->sv_nrthreads && !list_empty(&permsocks)) {
> >                  list_splice_init(&permsocks, &serv->sv_permsocks);
> >                  spin_unlock_bh(&serv->sv_lock);
> >                  err =3D -EBUSY;
> >                  goto out_unlock_mtx;
> >          }
>=20
> Got it.
>=20
> I'm splitting hairs, but this seems like a special case that might be
> true only for NFSD and could be abused by other API consumers.
>=20
> At the least, the opening block comment in llist.h should be updated
> to include del_entry in the locking table.
>=20
> I would be more comfortable with a solution that works in alignment with
> the current llist API, but if others are fine with this solution, then I
> won't object strenuously.
>=20
> (And to be clear, I agree that there is a bug in set_doit() that needs
> to be addressed quickly -- it's the specific fix that I'm queasy about).
>=20

Yeah, it would be good to address it quickly since you can crash the
box with this right now.

I'm not thrilled with adding the llist_del_entry() footgun either, but
it should work.

Another approach we could consider instead would be to delay queueing
all of these sockets to the lwq until after the sv_permsocks list is
settled. You could even just queue up the whole sv_permsocks list at
the end of this. If there's no work there, then there's no real harm.
That is a bit more surgery, however, since you'd have to lift
svc_xprt_received() handling out of svc_xprt_create_from_sa().

>=20
> > > > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > ---
> > > >    include/linux/llist.h | 36 ++++++++++++++++++++++++++++++++++++
> > > >    1 file changed, 36 insertions(+)
> > > >=20
> > > > diff --git a/include/linux/llist.h b/include/linux/llist.h
> > > > index 2c982ff7475a..fe6be21897d9 100644
> > > > --- a/include/linux/llist.h
> > > > +++ b/include/linux/llist.h
> > > > @@ -253,6 +253,42 @@ static inline bool __llist_add(struct llist_no=
de *new, struct llist_head *head)
> > > >        return __llist_add_batch(new, new, head);
> > > >    }
> > > >=20
> > > > +/**
> > > > + * llist_del_entry - remove a particular entry from a lock-less li=
st
> > > > + * @head: head of the list to remove the entry from
> > > > + * @entry: entry to be removed from the list
> > > > + *
> > > > + * Walk the list, find the given entry and remove it from the list=
.
>=20
> The above sentence repeats the comments in the code and the code itself.
> It visually obscures the next, much more important, sentence.
>=20
>=20
> > > > + * The caller must ensure that nothing can race in and change the
> > > > + * list while this is running.
> > > > + *
> > > > + * Returns true if the entry was found and removed.
> > > > + */
> > > > +static inline bool llist_del_entry(struct llist_head *head, struct=
 llist_node *entry)
> > > > +{
> > > > +     struct llist_node *pos;
> > > > +
> > > > +     if (!head->first)
> > > > +             return false;
>=20
> if (llist_empty()) ?
>=20
>=20
> > > > +
> > > > +     /* Is it the first entry? */
> > > > +     if (head->first =3D=3D entry) {
> > > > +             head->first =3D entry->next;
> > > > +             entry->next =3D entry;
> > > > +             return true;
>=20
> llist_del_first() or even llist_del_first_this()
>=20
> Basically I would avoid open-coding this logic and use the existing
> helpers where possible. The new code doesn't provide memory release
> semantics that would ensure the next access of the llist sees these
> updates.
>=20
>=20
> > > > +     }
> > > > +
> > > > +     /* Find it in the list */
> > > > +     llist_for_each(head->first, pos) {
> > > > +             if (pos->next =3D=3D entry) {
> > > > +                     pos->next =3D entry->next;
> > > > +                     entry->next =3D entry;
> > > > +                     return true;
> > > > +             }
> > > > +     }
> > > > +     return false;
> > > > +}
> > > > +
> > > >    /**
> > > >     * llist_del_all - delete all entries from lock-less list
> > > >     * @head:   the head of lock-less list to delete all entries
> > >=20
> > >=20
> > > --
> > > Chuck Lever
> > >=20
> >=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

