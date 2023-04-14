Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6966E25FE
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Apr 2023 16:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjDNOmL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Apr 2023 10:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjDNOmI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Apr 2023 10:42:08 -0400
Received: from mta-101a.earthlink-vadesecure.net (mta-101a.earthlink-vadesecure.net [51.81.61.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC43BB92
        for <linux-nfs@vger.kernel.org>; Fri, 14 Apr 2023 07:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; bh=LIlB5aFX/8xXscr9HPR04GLRxb4jF+bQR7WP/S
 gFCR4=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1681483286;
 x=1682088086; b=HmxyyzUmBgn5giTV85AhGhqvxWQjUknJpDPZJZQdR1hsvvXiVeOOlm8
 MzxAaMFcqMKVCXjBu1VEs/8XK4ZhtpHwHgohyRoUYwk50R8Ni8q131W0khjdqWd4rybdnaK
 269GtZDY8XgfrWgGwWeT4p635iDpNyeHqGqA4AqpKXIMrRJsRfJAxBHyI7GUe8gQi6wP1Ut
 IBNTG25nf60rYXGWsQprXkw8v4H4RcUS5OPkaiPkN2uhh7d6b2NnBD8DQ/lRJpKiqYrFcNW
 Z76+R0OSuV7eVQux5UYmyIG5EPI8TdnHKYfH0+i1CMsxmu/5CNGgHmjb/6JGXiIBdikqGrL
 gwA==
Received: from FRANKSTHINKPAD ([174.174.49.201])
 by smtp.earthlink-vadesecure.net ESMTP vsel1nmtao01p with ngmta
 id fc8596b1-1755d423bc3f6a11; Fri, 14 Apr 2023 14:41:26 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Calum Mackay'" <calum.mackay@oracle.com>,
        "'Jeff Layton'" <jlayton@kernel.org>
Cc:     <bfields@fieldses.org>, <linux-nfs@vger.kernel.org>,
        "'Frank Filz'" <ffilz@redhat.com>
References: <20230313112401.20488-1-jlayton@kernel.org> <20230313112401.20488-6-jlayton@kernel.org> <05c001d955dc$dc7e6fa0$957b4ee0$@mindspring.com> <c82e4b32-5df7-20c3-d0a8-4a30b9ae4482@oracle.com>
In-Reply-To: <c82e4b32-5df7-20c3-d0a8-4a30b9ae4482@oracle.com>
Subject: RE: [pynfs PATCH v2 5/5] LOCK24: fix the lock_seqid in second lock request
Date:   Fri, 14 Apr 2023 07:41:25 -0700
Message-ID: <082c01d96edf$311da8d0$9358fa70$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIOChUlYc/UeF2748/fISU/E8FFiQF2dM0fAnHwFpkDi12hUK6GC4hw
Content-Language: en-us
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> -----Original Message-----
> From: Calum Mackay [mailto:calum.mackay@oracle.com]
> Sent: Thursday, April 13, 2023 11:35 AM
> To: Frank Filz <ffilzlnx@mindspring.com>; 'Jeff Layton' =
<jlayton@kernel.org>
> Cc: Calum Mackay <calum.mackay@oracle.com>; bfields@fieldses.org; =
linux-
> nfs@vger.kernel.org; 'Frank Filz' <ffilz@redhat.com>
> Subject: Re: [pynfs PATCH v2 5/5] LOCK24: fix the lock_seqid in second =
lock
> request
>=20
> Now that I have some repo space (thank you Trond), I am putting things
> together=E2=80=A6
>=20
> On 13/03/2023 6:51 pm, Frank Filz wrote:
> > Looks good to me, tested against Ganesha and the updated patch =
passes.
>=20
> Frank, may I add your Tested-by:, for 5/5 please?

Yes, definitely.

Frank

Tested-by: Frank Filz <ffilzlnx@mindspring.com>
>=20
> cheers,
> calum.
>=20
>=20
> >
> > Frank
> >
> >> -----Original Message-----
> >> From: Jeff Layton [mailto:jlayton@kernel.org]
> >> Sent: Monday, March 13, 2023 4:24 AM
> >> To: calum.mackay@oracle.com
> >> Cc: bfields@fieldses.org; ffilzlnx@mindspring.com;
> > linux-nfs@vger.kernel.org;
> >> Frank Filz <ffilz@redhat.com>
> >> Subject: [pynfs PATCH v2 5/5] LOCK24: fix the lock_seqid in second
> >> lock
> > request
> >>
> >> This test currently fails against Linux nfsd, but I think it's the
> >> test
> > that's wrong. It
> >> basically does:
> >>
> >> open for read
> >> read lock
> >> unlock
> >> open upgrade
> >> write lock
> >>
> >> The write lock above is sent with a lock_seqid of 0, which is =
wrong.
> >> RFC7530/16.10.5 says:
> >>
> >>     o  In the case in which the state has been created and the [new
> >>        lockowner] boolean is true, the server rejects the request =
with the
> >>        error NFS4ERR_BAD_SEQID.  The only exception is where there =
is a
> >>        retransmission of a previous request in which the boolean =
was
> >>        true.  In this case, the lock_seqid will match the original
> >>        request, and the response will reflect the final case, =
below.
> >>
> >> Since the above is not a retransmission, knfsd is correct to reject
> >> this
> > call. This
> >> patch fixes the open_sequence object to track the lock seqid and =
set
> >> it
> > correctly
> >> in the LOCK request.
> >>
> >> With this, LOCK24 passes against knfsd.
> >>
> >> Cc: Frank Filz <ffilz@redhat.com>
> >> Fixes: 4299316fb357 (Add LOCK24 test case to test open
> >> uprgade/downgrade
> >> scenario)
> >> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >> ---
> >>   nfs4.0/servertests/st_lock.py | 6 +++++-
> >>   1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/nfs4.0/servertests/st_lock.py
> >> b/nfs4.0/servertests/st_lock.py
> > index
> >> 468672403ffe..9d650ab017b9 100644
> >> --- a/nfs4.0/servertests/st_lock.py
> >> +++ b/nfs4.0/servertests/st_lock.py
> >> @@ -886,6 +886,7 @@ class open_sequence:
> >>           self.client =3D client
> >>           self.owner =3D owner
> >>           self.lockowner =3D lockowner
> >> +        self.lockseqid =3D 0
> >>       def open(self, access):
> >>           self.fh, self.stateid =3D =
self.client.create_confirm(self.owner,
> >>   						access=3Daccess,
> >> @@ -900,14 +901,17 @@ class open_sequence:
> >>           self.client.close_file(self.owner, self.fh, self.stateid)
> >>       def lock(self, type):
> >>           res =3D self.client.lock_file(self.owner, self.fh, =
self.stateid,
> >> -                    type=3Dtype, lockowner=3Dself.lockowner)
> >> +                                    type=3Dtype, =
lockowner=3Dself.lockowner,
> >> +                                    lockseqid=3Dself.lockseqid)
> >>           check(res)
> >>           if res.status =3D=3D NFS4_OK:
> >>               self.lockstateid =3D res.lockid
> >> +            self.lockseqid +=3D 1
> >>       def unlock(self):
> >>           res =3D self.client.unlock_file(1, self.fh, =
self.lockstateid)
> >>           if res.status =3D=3D NFS4_OK:
> >>               self.lockstateid =3D res.lockid
> >> +            self.lockseqid +=3D 1
> >>
> >>   def testOpenUpgradeLock(t, env):
> >>       """Try open, lock, open, downgrade, close
> >> --
> >> 2.39.2
> >


