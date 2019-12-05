Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72C6A1139FB
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Dec 2019 03:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfLECid (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Dec 2019 21:38:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49550 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728132AbfLECid (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Dec 2019 21:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575513512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BCTQ7ZxusuehcB+2g4HccxG22jFlBmHYycwrA/Qj+r8=;
        b=aric+c5URmKmr+o/W/YybBmkCAJwz4GntHXBPjiQRR+JwJWFv7KVFOw1BC8XjeuOUR05gO
        wIDTCad10EtL8DvaJnoDN9EH3ka4VeAhTBi/6NuThB0/6RsTt9uOqthYFAL/gpNt6Cug8T
        GvgMOM+QzlvzmoNEqFst8AaAaCT5YsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-mpRHaOJxNb66VUL2dnuOiw-1; Wed, 04 Dec 2019 21:38:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBD4018543A0;
        Thu,  5 Dec 2019 02:38:28 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-120-226.rdu2.redhat.com [10.10.120.226])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A60745C1B5;
        Thu,  5 Dec 2019 02:38:28 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id BA31512023A; Wed,  4 Dec 2019 21:38:26 -0500 (EST)
Date:   Wed, 4 Dec 2019 21:38:26 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] NFSD: allow inter server COPY to have a STALE
 source server fh
Message-ID: <20191205023826.GA43279@pick.fieldses.org>
References: <20191204080039.ixjqetefkzzlldyt@kili.mountain>
 <CAN-5tyEG3C_Ebdr6dpMJ+gQ1pEAMNqbTv76dKu=KK9rspREr1A@mail.gmail.com>
 <20191204220435.GG40361@pick.fieldses.org>
MIME-Version: 1.0
In-Reply-To: <20191204220435.GG40361@pick.fieldses.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: mpRHaOJxNb66VUL2dnuOiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 04, 2019 at 05:04:35PM -0500, J. Bruce Fields wrote:
> On Wed, Dec 04, 2019 at 03:11:01PM -0500, Olga Kornievskaia wrote:
> > On Wed, Dec 4, 2019 at 3:00 AM Dan Carpenter <dan.carpenter@oracle.com>=
 wrote:
> > >
> > > Hello Olga Kornievskaia,
> > >
> > > This is a semi-automatic email about new static checker warnings.
> > >
> > > The patch 4e48f1cccab3: "NFSD: allow inter server COPY to have a
> > > STALE source server fh" from Oct 7, 2019, leads to the following
> > > Smatch complaint:
> > >
> > >     fs/nfsd/nfs4proc.c:2371 nfsd4_proc_compound()
> > >      error: we previously assumed 'current_fh->fh_export' could be nu=
ll (see line 2325)
> > >
> > > fs/nfsd/nfs4proc.c
> > >   2324                          }
> > >   2325                  } else if (current_fh->fh_export &&
> > >                                    ^^^^^^^^^^^^^^^^^^^^^
> > > The patch adds a check for NULL
> > >
> > >   2326                             current_fh->fh_export->ex_fslocs.m=
igrated &&
> > >   2327                            !(op->opdesc->op_flags & ALLOWED_ON=
_ABSENT_FS)) {
> > >   2328                          op->status =3D nfserr_moved;
> > >   2329                          goto encode_op;
> > >   2330                  }
> > >   2331
> > >   2332                  fh_clear_wcc(current_fh);
> > >   2333
> > >   2334                  /* If op is non-idempotent */
> > >   2335                  if (op->opdesc->op_flags & OP_MODIFIES_SOMETH=
ING) {
> > >   2336                          /*
> > >   2337                           * Don't execute this op if we couldn=
't encode a
> > >   2338                           * succesful reply:
> > >   2339                           */
> > >   2340                          u32 plen =3D op->opdesc->op_rsize_bop=
(rqstp, op);
> > >   2341                          /*
> > >   2342                           * Plus if there's another operation,=
 make sure
> > >   2343                           * we'll have space to at least encod=
e an error:
> > >   2344                           */
> > >   2345                          if (resp->opcnt < args->opcnt)
> > >   2346                                  plen +=3D COMPOUND_ERR_SLACK_=
SPACE;
> > >   2347                          op->status =3D nfsd4_check_resp_size(=
resp, plen);
> > >   2348                  }
> > >   2349
> > >   2350                  if (op->status)
> > >   2351                          goto encode_op;
> > >   2352
> > >   2353                  if (op->opdesc->op_get_currentstateid)
> > >   2354                          op->opdesc->op_get_currentstateid(cst=
ate, &op->u);
> > >   2355                  op->status =3D op->opdesc->op_func(rqstp, cst=
ate, &op->u);
> > >   2356
> > >   2357                  /* Only from SEQUENCE */
> > >   2358                  if (cstate->status =3D=3D nfserr_replay_cache=
) {
> > >   2359                          dprintk("%s NFS4.1 replay from cache\=
n", __func__);
> > >   2360                          status =3D op->status;
> > >   2361                          goto out;
> > >   2362                  }
> > >   2363                  if (!op->status) {
> > >   2364                          if (op->opdesc->op_set_currentstateid=
)
> > >   2365                                  op->opdesc->op_set_currentsta=
teid(cstate, &op->u);
> > >   2366
> > >   2367                          if (op->opdesc->op_flags & OP_CLEAR_S=
TATEID)
> > >   2368                                  clear_current_stateid(cstate)=
;
> > >   2369
> > >   2370                          if (need_wrongsec_check(rqstp))
> > >   2371                                  op->status =3D check_nfsd_acc=
ess(current_fh->fh_export, rqstp);
> > >                                                                      =
  ^^^^^^^^^^^^^^^^^^^^^
> > > Is it required here as well?
> >=20
> > Bruce, correct me if I'm wrong but I think we are ok here. Because for
> > the COPY operation for which the current_fh->fh_export can be null,
> > need_wrongsec_check() would be false.
>=20
> Honestly.... I've spent a few minutes thinking about it, but haven't
> been able to come up either with an example where this will attempt a
> NULL dereference, or a convincing argument that it never will.
>=20
> I'll think about it some more and I'll figure it out.  But I worry that
> the the logic is fragile.

Seems like a compound like this should trigger a NULL dereference:

=09PUTFH(foreign filehandle)
=09GETATTR
=09SAVEFH
=09COPY

First, check_if_stalefh_allowed sets no_verify on the first (PUTFH) op.
Then op_func =3D nfsd4_putfh runs and leaves current_fh->fh_export NULL.
need_wrongsec_check returns true, since this PUTFH has OP_IS_PUTFH_LIKE
set and GETATTR does not have OP_HANDLES_WRONGSEC set.

Haven't actually tested that, maybe I'm missing something.

So, stuff we could do:

=09- add an extra check of fh_export or something here.
=09- make check_if_stalefh_allowed more careful--it'd be easy for
=09  it to spot that a compound like the above is going to fail.
=09- double-check that we don't assume the filehandle is verified
=09  elsewhere in nfsd_compound.
=09- ?

> One other thing I noticed: in the no_verify case, we're depending on
> fh_verify returning a stale error on a foreign filehandle.  But I don't
> think we can count on it.  It might, by coincidence, turn out that
> fh_verify returns some other error, and then a legitimate COPY could
> fail for no reason.

Also nervous about cases like the above where we'll be passing the
foreign filehandle into GETATTR and counting on fh_verify failing in a
useful way.  I mean, maybe the client gets what it deserves for sending
an obviously nonsensical compound, but still it'd probably be better to
catch that earlier.

--b.

