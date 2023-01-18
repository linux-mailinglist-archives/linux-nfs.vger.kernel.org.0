Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC92167270F
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 19:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjARSfH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 13:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjARSez (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 13:34:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FEC2B0A7
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 10:34:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5544B6199D
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 18:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD23C433D2;
        Wed, 18 Jan 2023 18:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674066893;
        bh=DzZj7XgnehiBUxLpCixSTcyFqtQYBHyicelua4OktZ4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FZwdzl+T9YPTFP9hK9D88sUfmLhLuPq4s29wma8PhFyg19XQnTkYiGNfz1xoEpK3n
         W6vzaLET9ADvdAQZjFp5zGzCj6/duXTm9+toUqUzgzb0geFKnbCoDm3FtnQNcyPv+J
         7zDxwQjC100vuXBYhhKl5kSGA5xNShyRLF9/0OcGPXo7M64FJfO53vs9Hd/2DtBare
         og3qkoxoRdobdOpNjnO4NDVl2A6AjWSFdxWKciGEIOh3+lAL3Nrtd7hHZU2U0E6z9A
         xLX6eZ3rZ1hRy6xO3BnRG/+y7UUA4yhIE2hj0TJC0OwFVW8ls0W0kxtaQO44viSyVQ
         QBReAi9jx476w==
Message-ID: <db820750b4fbd70df555d73ac1104e7b76cb12f7.camel@kernel.org>
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks
 in COPY codepath
From:   Jeff Layton <jlayton@kernel.org>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        dai.ngo@oracle.com
Date:   Wed, 18 Jan 2023 13:34:51 -0500
In-Reply-To: <CAN-5tyEvXo+xijgk+Wbrrvy=O3BwdOB9MHdsQCXvsM_CyemaRg@mail.gmail.com>
References: <20230117193831.75201-1-jlayton@kernel.org>
         <20230117193831.75201-3-jlayton@kernel.org>
         <CAN-5tyHA6JgqnEorEqz1b3CLdbXWhT6hNZKXzgfZy3Fr_TdW7Q@mail.gmail.com>
         <1fc9af5a2c2a79c5befa4510c714f97e26b13ed5.camel@kernel.org>
         <CAN-5tyHKS9o3KDV3zUmzjiOjSxyC1rNe77Tc8c7RHmoXE6s_RQ@mail.gmail.com>
         <cb4b8c379a07d9ecccd202b2a85e80ba6d5e5a26.camel@kernel.org>
         <CAN-5tyFLOZDS2W9UGMxZDo1Zi9RvuCXon3Xsd1yEyMtxyd3GeQ@mail.gmail.com>
         <CAN-5tyEvXo+xijgk+Wbrrvy=O3BwdOB9MHdsQCXvsM_CyemaRg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-01-18 at 13:16 -0500, Olga Kornievskaia wrote:
> On Wed, Jan 18, 2023 at 12:07 PM Olga Kornievskaia <aglo@umich.edu> wrote=
:
> >=20
> > On Wed, Jan 18, 2023 at 11:57 AM Jeff Layton <jlayton@kernel.org> wrote=
:
> > >=20
> > > On Wed, 2023-01-18 at 11:29 -0500, Olga Kornievskaia wrote:
> > > > On Wed, Jan 18, 2023 at 10:27 AM Jeff Layton <jlayton@kernel.org> w=
rote:
> > > > >=20
> > > > > On Wed, 2023-01-18 at 09:42 -0500, Olga Kornievskaia wrote:
> > > > > > On Tue, Jan 17, 2023 at 2:38 PM Jeff Layton <jlayton@kernel.org=
> wrote:
> > > > > > >=20
> > > > > > > There are two different flavors of the nfsd4_copy struct. One=
 is
> > > > > > > embedded in the compound and is used directly in synchronous =
copies. The
> > > > > > > other is dynamically allocated, refcounted and tracked in the=
 client
> > > > > > > struture. For the embedded one, the cleanup just involves rel=
easing any
> > > > > > > nfsd_files held on its behalf. For the async one, the cleanup=
 is a bit
> > > > > > > more involved, and we need to dequeue it from lists, unhash i=
t, etc.
> > > > > > >=20
> > > > > > > There is at least one potential refcount leak in this code no=
w. If the
> > > > > > > kthread_create call fails, then both the src and dst nfsd_fil=
es in the
> > > > > > > original nfsd4_copy object are leaked.
> > > > > >=20
> > > > > > I don't believe that's true. If kthread_create thread fails we =
call
> > > > > > cleanup_async_copy() that does a put on the file descriptors.
> > > > > >=20
> > > > >=20
> > > > > You mean this?
> > > > >=20
> > > > > out_err:
> > > > >         if (async_copy)
> > > > >                 cleanup_async_copy(async_copy);
> > > > >=20
> > > > > That puts the references that were taken in dup_copy_fields, but =
the
> > > > > original (embedded) nfsd4_copy also holds references and those ar=
e not
> > > > > being put in this codepath.
> > > >=20
> > > > Can you please point out where do we take a reference on the origin=
al copy?
> > > >=20
> > >=20
> > > In the case of an inter-server copy, nf_dst is set in
> > > nfsd4_setup_inter_ssc. For intraserver copy, both pointers are set vi=
a
> > > the call to nfsd4_verify_copy. Both functions call
> > > nfs4_preprocess_stateid_op, which returns a reference to the nfsd_fil=
e
> > > in the second to last arg.
> >=20
> > Ah. Thank you. I didn't know that nfs4_preprocess_stateid_op() takes a
> > reference on it's 5th argument. I think I was previously looking at
> > nfsd4_read() function which calls nfs4_preprocess_stateid_op() and
> > gets back read->rd_nf but it never does a put on it when it returns.
> > However, I now looked at other functions that call
> > nfs4_preproess_stateid_op() such as nfsd4_fallocate() and I see that
> > it does a put.
>=20
> So is there a refcount leak in the nfsd4_read() then since it doesn't
> do a put? Or the internals obscure and that even though it calls the
> same function and passes that parameter no refcount was increased. Is
> it based on the "WR_STATE, RD_STATE" parameter.
>=20

I don't think so. The put is done just below there, in
nfsd4_read_release:

        if (u->read.rd_nf)
                nfsd_file_put(u->read.rd_nf);

That said, I am hunting a refcount overput with nfsd_files that I've not
been able to nail down yet (which is why I've been auditing the
nfsd_file refcounting). If you see anything that looks hinky, please do
point it out.

> I see that
> nfsd4_write() does do a put. For copy, we call the src_fd with
> RD_STATE and dst_fd with WR_STATE. If I were to follow the logic of
> nfsd4_read/nfsd4_write, the the copy doesn't need to do a put for src
> but will need it for the dst. The proposed patch does it for both.
>=20

That'd be wrong. READs have to hold a ref to the open file while the
reply is being marshalled. A WRITE can release it once the data has been
written to the file. Maybe that's worth a comment.

Note that I just sent a patch to the list to add a comment that
(hopefully) makes it clear that nfs4_preprocess_stateid_op returns a
reference in that field.

FWIW, it wouldn't be safe for it to do anything else. Returning a
pointer to a refcounted object without taking a reference would be very
problematic.

> So I'm still confused if this patch is the correct solution.
>=20

Fair enough. I'm not sure I understand the pushback, as the result seems
clearer to me. If you want to propose an alternate fix, I'm happy to
take a look.

> > >=20
> > > > > > > The cleanup in this codepath is also sort of weird. In the as=
ync copy
> > > > > > > case, we'll have up to four nfsd_file references (src and dst=
 for both
> > > > > > > flavors of copy structure).
> > > > > >=20
> > > > > > That's not true. There is a careful distinction between intra -=
- which
> > > > > > had 2 valid file pointers and does a get on both as they both p=
oint to
> > > > > > something that's opened on this server--- but inter -- only doe=
s a get
> > > > > > on the dst file descriptor, the src doesn't exit. And yes I rea=
lize
> > > > > > the code checks for nfs_src being null which it should be but i=
t makes
> > > > > > the code less clear and at some point somebody might want to de=
cide to
> > > > > > really do a put on it.
> > > > > >=20
> > > > >=20
> > > > > This is part of the problem here. We have a nfsd4_copy structure,=
 and
> > > > > depending on what has been done to it, you need to call different
> > > > > methods to clean it up. That seems like a real antipattern to me.
> > > >=20
> > > > But they call different methods because different things need to be
> > > > done there and it makes it clear what needs to be for what type of
> > > > copy.
> > > >=20
> > >=20
> > >=20
> > > I sure as hell had a hard time dissecting how all of that was suppose=
d
> > > to work. There is clear bug here, and I think this patch makes the
> > > result clearer and more robust in the face of changes.
> > >=20
> > > There are actually 4 different cases here: sync vs. async, alongside
> > > intra vs. interserver copy. These are all overloaded onto a nfsd4_cop=
y
> > > structure, seemingly for no good reason.
> > >=20
> > > The cleanup, in particular seems quite fragile to me, and there is a
> > > dearth of defensive coding measures. If you subtly call the "wrong"
> > > cleanup function at the wrong point in time, then things may go awry.
> > >=20
> > > I'll leave it up to Chuck to make the final determination, but I see
> > > this patch as an improvement.
> > >=20
> > > > > > > They are both put at the end of
> > > > > > > nfsd4_do_async_copy, even though the ones held on behalf of t=
he embedded
> > > > > > > one outlive that structure.
> > > > > > >=20
> > > > > > > Change it so that we always clean up the nfsd_file refs held =
by the
> > > > > > > embedded copy structure before nfsd4_copy returns. Rework
> > > > > > > cleanup_async_copy to handle both inter and intra copies. Eli=
minate
> > > > > > > nfsd4_cleanup_intra_ssc since it now becomes a no-op.
> > > > > >=20
> > > > > > I feel by combining the cleanup for both it obscures a very imp=
ortant
> > > > > > destication that src filehandle doesn't exist for inter.
> > > > >=20
> > > > > If the src filehandle doesn't exist, then the pointer to it will =
be
> > > > > NULL. I don't see what we gain by keeping these two distinct, oth=
er than
> > > > > avoiding a NULL pointer check.
> > > >=20
> > > > My reason would be for code clarity because different things are
> > > > supposed to happen for intra and inter. Difference of opinion it
> > > > seems.
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > ---
> > > > > > >  fs/nfsd/nfs4proc.c | 23 ++++++++++-------------
> > > > > > >  1 file changed, 10 insertions(+), 13 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > > > > index 37a9cc8ae7ae..62b9d6c1b18b 100644
> > > > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > > > @@ -1512,7 +1512,6 @@ nfsd4_cleanup_inter_ssc(struct nfsd4_ss=
c_umount_item *nsui, struct file *filp,
> > > > > > >         long timeout =3D msecs_to_jiffies(nfsd4_ssc_umount_ti=
meout);
> > > > > > >=20
> > > > > > >         nfs42_ssc_close(filp);
> > > > > > > -       nfsd_file_put(dst);
> > > > > > >         fput(filp);
> > > > > > >=20
> > > > > > >         spin_lock(&nn->nfsd_ssc_lock);
> > > > > > > @@ -1562,13 +1561,6 @@ nfsd4_setup_intra_ssc(struct svc_rqst =
*rqstp,
> > > > > > >                                  &copy->nf_dst);
> > > > > > >  }
> > > > > > >=20
> > > > > > > -static void
> > > > > > > -nfsd4_cleanup_intra_ssc(struct nfsd_file *src, struct nfsd_f=
ile *dst)
> > > > > > > -{
> > > > > > > -       nfsd_file_put(src);
> > > > > > > -       nfsd_file_put(dst);
> > > > > > > -}
> > > > > > > -
> > > > > > >  static void nfsd4_cb_offload_release(struct nfsd4_callback *=
cb)
> > > > > > >  {
> > > > > > >         struct nfsd4_cb_offload *cbo =3D
> > > > > > > @@ -1683,12 +1675,18 @@ static void dup_copy_fields(struct nf=
sd4_copy *src, struct nfsd4_copy *dst)
> > > > > > >         dst->ss_nsui =3D src->ss_nsui;
> > > > > > >  }
> > > > > > >=20
> > > > > > > +static void release_copy_files(struct nfsd4_copy *copy)
> > > > > > > +{
> > > > > > > +       if (copy->nf_src)
> > > > > > > +               nfsd_file_put(copy->nf_src);
> > > > > > > +       if (copy->nf_dst)
> > > > > > > +               nfsd_file_put(copy->nf_dst);
> > > > > > > +}
> > > > > > > +
> > > > > > >  static void cleanup_async_copy(struct nfsd4_copy *copy)
> > > > > > >  {
> > > > > > >         nfs4_free_copy_state(copy);
> > > > > > > -       nfsd_file_put(copy->nf_dst);
> > > > > > > -       if (!nfsd4_ssc_is_inter(copy))
> > > > > > > -               nfsd_file_put(copy->nf_src);
> > > > > > > +       release_copy_files(copy);
> > > > > > >         spin_lock(&copy->cp_clp->async_lock);
> > > > > > >         list_del(&copy->copies);
> > > > > > >         spin_unlock(&copy->cp_clp->async_lock);
> > > > > > > @@ -1748,7 +1746,6 @@ static int nfsd4_do_async_copy(void *da=
ta)
> > > > > > >         } else {
> > > > > > >                 nfserr =3D nfsd4_do_copy(copy, copy->nf_src->=
nf_file,
> > > > > > >                                        copy->nf_dst->nf_file,=
 false);
> > > > > > > -               nfsd4_cleanup_intra_ssc(copy->nf_src, copy->n=
f_dst);
> > > > > > >         }
> > > > > > >=20
> > > > > > >  do_callback:
> > > > > > > @@ -1811,9 +1808,9 @@ nfsd4_copy(struct svc_rqst *rqstp, stru=
ct nfsd4_compound_state *cstate,
> > > > > > >         } else {
> > > > > > >                 status =3D nfsd4_do_copy(copy, copy->nf_src->=
nf_file,
> > > > > > >                                        copy->nf_dst->nf_file,=
 true);
> > > > > > > -               nfsd4_cleanup_intra_ssc(copy->nf_src, copy->n=
f_dst);
> > > > > > >         }
> > > > > > >  out:
> > > > > > > +       release_copy_files(copy);
> > > > > > >         return status;
> > > > > > >  out_err:
> > > > > > >         if (async_copy)
> > > > > > > --
> > > > > > > 2.39.0
> > > > > > >=20
> > > > >=20
> > > > > --
> > > > > Jeff Layton <jlayton@kernel.org>
> > >=20
> > > --
> > > Jeff Layton <jlayton@kernel.org>

--=20
Jeff Layton <jlayton@kernel.org>
