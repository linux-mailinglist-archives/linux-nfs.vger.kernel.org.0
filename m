Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28CAE11376C
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2019 23:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfLDWEn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Dec 2019 17:04:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22113 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727989AbfLDWEm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Dec 2019 17:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575497080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m55CO8CBAIKx9SguUpvW29A4gHb3+8QmzZduPO/m46M=;
        b=iPUgG/1lJTGX97LrYs3M0NpOiIb3HOzMFsu5Td8m8HJmRCvE7UGoR+PWA0iOE4oyFSAlGJ
        FpW3oVSMV1swWoPclrHEnMSK79Y09EZWHG3dKjIE65P7n7QwkZdy2fPW4TGwNH/JOaESCu
        KnTT+cAiDDEWp+kW9Xw0FmtSwRpdBfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-SwhPSyx1MjGxMZmEPOUoHg-1; Wed, 04 Dec 2019 17:04:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A9A2100550E;
        Wed,  4 Dec 2019 22:04:36 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-116-114.phx2.redhat.com [10.3.116.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A19B5D6AE;
        Wed,  4 Dec 2019 22:04:36 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 1C46A12023A; Wed,  4 Dec 2019 17:04:35 -0500 (EST)
Date:   Wed, 4 Dec 2019 17:04:35 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] NFSD: allow inter server COPY to have a STALE
 source server fh
Message-ID: <20191204220435.GG40361@pick.fieldses.org>
References: <20191204080039.ixjqetefkzzlldyt@kili.mountain>
 <CAN-5tyEG3C_Ebdr6dpMJ+gQ1pEAMNqbTv76dKu=KK9rspREr1A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAN-5tyEG3C_Ebdr6dpMJ+gQ1pEAMNqbTv76dKu=KK9rspREr1A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: SwhPSyx1MjGxMZmEPOUoHg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 04, 2019 at 03:11:01PM -0500, Olga Kornievskaia wrote:
> On Wed, Dec 4, 2019 at 3:00 AM Dan Carpenter <dan.carpenter@oracle.com> w=
rote:
> >
> > Hello Olga Kornievskaia,
> >
> > This is a semi-automatic email about new static checker warnings.
> >
> > The patch 4e48f1cccab3: "NFSD: allow inter server COPY to have a
> > STALE source server fh" from Oct 7, 2019, leads to the following
> > Smatch complaint:
> >
> >     fs/nfsd/nfs4proc.c:2371 nfsd4_proc_compound()
> >      error: we previously assumed 'current_fh->fh_export' could be null=
 (see line 2325)
> >
> > fs/nfsd/nfs4proc.c
> >   2324                          }
> >   2325                  } else if (current_fh->fh_export &&
> >                                    ^^^^^^^^^^^^^^^^^^^^^
> > The patch adds a check for NULL
> >
> >   2326                             current_fh->fh_export->ex_fslocs.mig=
rated &&
> >   2327                            !(op->opdesc->op_flags & ALLOWED_ON_A=
BSENT_FS)) {
> >   2328                          op->status =3D nfserr_moved;
> >   2329                          goto encode_op;
> >   2330                  }
> >   2331
> >   2332                  fh_clear_wcc(current_fh);
> >   2333
> >   2334                  /* If op is non-idempotent */
> >   2335                  if (op->opdesc->op_flags & OP_MODIFIES_SOMETHIN=
G) {
> >   2336                          /*
> >   2337                           * Don't execute this op if we couldn't=
 encode a
> >   2338                           * succesful reply:
> >   2339                           */
> >   2340                          u32 plen =3D op->opdesc->op_rsize_bop(r=
qstp, op);
> >   2341                          /*
> >   2342                           * Plus if there's another operation, m=
ake sure
> >   2343                           * we'll have space to at least encode =
an error:
> >   2344                           */
> >   2345                          if (resp->opcnt < args->opcnt)
> >   2346                                  plen +=3D COMPOUND_ERR_SLACK_SP=
ACE;
> >   2347                          op->status =3D nfsd4_check_resp_size(re=
sp, plen);
> >   2348                  }
> >   2349
> >   2350                  if (op->status)
> >   2351                          goto encode_op;
> >   2352
> >   2353                  if (op->opdesc->op_get_currentstateid)
> >   2354                          op->opdesc->op_get_currentstateid(cstat=
e, &op->u);
> >   2355                  op->status =3D op->opdesc->op_func(rqstp, cstat=
e, &op->u);
> >   2356
> >   2357                  /* Only from SEQUENCE */
> >   2358                  if (cstate->status =3D=3D nfserr_replay_cache) =
{
> >   2359                          dprintk("%s NFS4.1 replay from cache\n"=
, __func__);
> >   2360                          status =3D op->status;
> >   2361                          goto out;
> >   2362                  }
> >   2363                  if (!op->status) {
> >   2364                          if (op->opdesc->op_set_currentstateid)
> >   2365                                  op->opdesc->op_set_currentstate=
id(cstate, &op->u);
> >   2366
> >   2367                          if (op->opdesc->op_flags & OP_CLEAR_STA=
TEID)
> >   2368                                  clear_current_stateid(cstate);
> >   2369
> >   2370                          if (need_wrongsec_check(rqstp))
> >   2371                                  op->status =3D check_nfsd_acces=
s(current_fh->fh_export, rqstp);
> >                                                                        =
^^^^^^^^^^^^^^^^^^^^^
> > Is it required here as well?
>=20
> Bruce, correct me if I'm wrong but I think we are ok here. Because for
> the COPY operation for which the current_fh->fh_export can be null,
> need_wrongsec_check() would be false.

Honestly.... I've spent a few minutes thinking about it, but haven't
been able to come up either with an example where this will attempt a
NULL dereference, or a convincing argument that it never will.

I'll think about it some more and I'll figure it out.  But I worry that
the the logic is fragile.

One other thing I noticed: in the no_verify case, we're depending on
fh_verify returning a stale error on a foreign filehandle.  But I don't
think we can count on it.  It might, by coincidence, turn out that
fh_verify returns some other error, and then a legitimate COPY could
fail for no reason.

--b.

