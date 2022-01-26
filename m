Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F7249C006
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 01:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbiAZAOp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 19:14:45 -0500
Received: from mta-202a.oxsus-vadesecure.net ([51.81.232.240]:44537 "EHLO
        nmtao202.oxsus-vadesecure.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232124AbiAZAOo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 19:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; bh=GwwZTIQ9wswcFEeUmNnAJEqvsFRZV319ZAEwFT
 eWBXA=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1643156082;
 x=1643760882; b=Qr0XNuIPKQSQ1RHgCsBykvrfVmaJ0b1rLd7NtQDemoTv+CdHwtqwuQG
 C7pntOYucuF4Ob+orPvtM6oISt7673yaYWW2ngIMqfnEmmI8DrUCt7pvfd+2UhRktYDfNL4
 1Gw/ZZnZuSxXIWUPDsBgWoL3Vyu1UCotqGW+OdESZrEmYiwWmg0BplMtNjmkTsARHQCHoDv
 NGivdHqn8BAiwHm2NJgUAHs7yTSpQT8qvLvhTNQ4VY16Gh97gQqwaBPcZZz46mtQvV4h7kO
 xYoDLX1EpZaJ3I1zXxKiFlbKnXjSq0azi0UgSw0FDttIxgbiqd9AsBBhWmyen1fsVy5lhc5
 5RA==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.oxsus-vadesecure.net ESMTP oxsus2nmtao02p with ngmta
 id 141a7bf2-16cda9c042a37204; Wed, 26 Jan 2022 00:14:42 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Bruce Fields'" <bfields@redhat.com>,
        "'NeilBrown'" <neilb@suse.de>
Cc:     "'Petr Vorel'" <pvorel@suse.cz>,
        "'Linux NFS Mailing List'" <linux-nfs@vger.kernel.org>,
        "'Yong Sun'" <yosun@suse.com>
References: <YLY9pKu38lEWaXxE@pevik> <YLZS1iMJR59n4hue@pick.fieldses.org> <164248153844.24166.16775550865302060652@noble.neil.brown.name> <CAPL3RVE8+zYOLotpUQ6QWFy5rYS8o1NV6XbKE4-D6XpVSoYw3w@mail.gmail.com>
In-Reply-To: <CAPL3RVE8+zYOLotpUQ6QWFy5rYS8o1NV6XbKE4-D6XpVSoYw3w@mail.gmail.com>
Subject: RE: pynfs: [NFS 4.0] SEC7, LOCK24 test failures
Date:   Tue, 25 Jan 2022 16:14:42 -0800
Message-ID: <0b8e01d81249$b7c4f300$274ed900$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQI9qwG/Gn+aGzx22KdRvijo3WxbYgIwI6tiAZArGOQBpS72xKt+Dldw
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Yes, I believe I wrote this test to recreate a condition we saw in the =
wild. There is no guarantee the client doesn't send LOCK with an OPEN =
stateid and requesting new lock owner when you already have a LOCK =
stateid for that lock owner. This test case forces that condition.

It looks like we were having troubles with FREE_STATEID racing with =
LOCK. A LOCK following a FREE_STATEID MUST use the OPEN stateid and ask =
for a new lock owner (since the LOCK stateid was freed), but if the LOCK =
wins the race, the old LOCK stateid still exists, so we get an LOCK with =
OPEN stateid requesting new lock owner where the STATEID will already =
exist.

Now maybe there's a different way to resolve the race, but if the LOCK =
truly arrives before Ganesha even sees the FREE_STATEID then it has no =
knowledge that would allow it to delay the LOCK request. Before we made =
changes to allow this I believe we replied with an error that broke =
things client side.

Here's a Ganesha patch trying to resolve the race and creating the =
condition that LOCK24 was then written to test:

https://github.com/nfs-ganesha/nfs-ganesha/commit/7d0fb8e9328c40fcfae03ac=
950a854f56689bb44

Of course the client may have changed to eliminate the race...

If need be, just change this from an "all" test to a "ganesha" test.

Frank

> -----Original Message-----
> From: Bruce Fields [mailto:bfields@redhat.com]
> Sent: Tuesday, January 25, 2022 2:47 PM
> To: NeilBrown <neilb@suse.de>
> Cc: Petr Vorel <pvorel@suse.cz>; Linux NFS Mailing List <linux-
> nfs@vger.kernel.org>; Yong Sun <yosun@suse.com>; Frank S. Filz
> <ffilzlnx@mindspring.com>
> Subject: Re: pynfs: [NFS 4.0] SEC7, LOCK24 test failures
>=20
> Frank added this test in 4299316fb357, and I don't really understand =
his
> description, but it *sounds* like he really wanted it to do the =
new-lockowner
> case.  Frank?
>=20
> --b.
>=20
> On Tue, Jan 18, 2022 at 12:01 AM NeilBrown <neilb@suse.de> wrote:
> >
> > On Wed, 02 Jun 2021, J. Bruce Fields wrote:
> > > On Tue, Jun 01, 2021 at 04:01:08PM +0200, Petr Vorel wrote:
> > >
> > > > LOCK24   st_lock.testOpenUpgradeLock                             =
 : FAILURE
> > > >            OP_LOCK should return NFS4_OK, instead got
> > > >            NFS4ERR_BAD_SEQID
> > >
> > > I suspect the server's actually OK here, but I need to look more
> > > closely.
> > >
> > I agree.
> > I think this patch fixes the test.
> >
> > NeilBrown
> >
> > From: NeilBrown <neilb@suse.de>
> > Date: Tue, 18 Jan 2022 15:50:37 +1100
> > Subject: [PATCH] Fix NFSv4.0 LOCK24 test
> >
> > Only the first lock request for a given open-owner can use =
lock_file.
> > Subsequent lock request must use relock_file.
> >
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  nfs4.0/servertests/st_lock.py | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/nfs4.0/servertests/st_lock.py
> > b/nfs4.0/servertests/st_lock.py index 468672403ffe..db08fbeedac4
> > 100644
> > --- a/nfs4.0/servertests/st_lock.py
> > +++ b/nfs4.0/servertests/st_lock.py
> > @@ -886,6 +886,7 @@ class open_sequence:
> >          self.client =3D client
> >          self.owner =3D owner
> >          self.lockowner =3D lockowner
> > +        self.lockseq =3D 0
> >      def open(self, access):
> >          self.fh, self.stateid =3D =
self.client.create_confirm(self.owner,
> >                                                 access=3Daccess, @@
> > -899,15 +900,21 @@ class open_sequence:
> >      def close(self):
> >          self.client.close_file(self.owner, self.fh, self.stateid)
> >      def lock(self, type):
> > -        res =3D self.client.lock_file(self.owner, self.fh, =
self.stateid,
> > -                    type=3Dtype, lockowner=3Dself.lockowner)
> > +        if self.lockseq =3D=3D 0:
> > +            res =3D self.client.lock_file(self.owner, self.fh, =
self.stateid,
> > +                                        type=3Dtype, =
lockowner=3Dself.lockowner)
> > +        else:
> > +            res =3D self.client.relock_file(self.lockseq, self.fh, =
self.lockstateid,
> > +                                        type=3Dtype)
> >          check(res)
> >          if res.status =3D=3D NFS4_OK:
> >              self.lockstateid =3D res.lockid
> > +            self.lockseq =3D self.lockseq + 1
> >      def unlock(self):
> >          res =3D self.client.unlock_file(1, self.fh, =
self.lockstateid)
> >          if res.status =3D=3D NFS4_OK:
> >              self.lockstateid =3D res.lockid
> > +            self.lockseq =3D self.lockseq + 1
> >
> >  def testOpenUpgradeLock(t, env):
> >      """Try open, lock, open, downgrade, close
> > --
> > 2.34.1
> >

