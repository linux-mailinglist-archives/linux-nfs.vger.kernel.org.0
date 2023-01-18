Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B6F672143
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 16:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjARP2R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 10:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjARP1g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 10:27:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6094A46148
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 07:27:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C309AB81C66
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 15:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CCAC433F0;
        Wed, 18 Jan 2023 15:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674055648;
        bh=CHAebm7oqq2hIfOeCe/qKXaxnhyVaFWOJoilZOpsWNo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VAFEKYldLQlJEbFibs6DpoI+wx5+yKgD41Xhtncws4sbFfuYnnAK7c9+Y77eDXbIP
         M8lI8SjFggOpkG6zVRneSr7FySRqBElt9BcLKtdTo7LGK+gY1c7GqQe5P6m1xSlvL4
         cQlvpPbzeVVXR95A+jAVKEQK5B70pXdefd2MutTAiAp9VG9xFr2Fombj3UWMEO3/W5
         APoIb6p5+n4/ISmNAGwRzggswF1TrfDrKFake+7+5j2BopG7/9nkmN4nPd1ReFSNLg
         G3FE7X+7oCOpYD4+cllhtr34nPQsZJDsEboSvgHkH9+L5+CnMpiUBRAXZk/rIth4Xh
         iMA9te2OSrtPQ==
Message-ID: <1fc9af5a2c2a79c5befa4510c714f97e26b13ed5.camel@kernel.org>
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks
 in COPY codepath
From:   Jeff Layton <jlayton@kernel.org>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        dai.ngo@oracle.com
Date:   Wed, 18 Jan 2023 10:27:26 -0500
In-Reply-To: <CAN-5tyHA6JgqnEorEqz1b3CLdbXWhT6hNZKXzgfZy3Fr_TdW7Q@mail.gmail.com>
References: <20230117193831.75201-1-jlayton@kernel.org>
         <20230117193831.75201-3-jlayton@kernel.org>
         <CAN-5tyHA6JgqnEorEqz1b3CLdbXWhT6hNZKXzgfZy3Fr_TdW7Q@mail.gmail.com>
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

On Wed, 2023-01-18 at 09:42 -0500, Olga Kornievskaia wrote:
> On Tue, Jan 17, 2023 at 2:38 PM Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > There are two different flavors of the nfsd4_copy struct. One is
> > embedded in the compound and is used directly in synchronous copies. Th=
e
> > other is dynamically allocated, refcounted and tracked in the client
> > struture. For the embedded one, the cleanup just involves releasing any
> > nfsd_files held on its behalf. For the async one, the cleanup is a bit
> > more involved, and we need to dequeue it from lists, unhash it, etc.
> >=20
> > There is at least one potential refcount leak in this code now. If the
> > kthread_create call fails, then both the src and dst nfsd_files in the
> > original nfsd4_copy object are leaked.
>=20
> I don't believe that's true. If kthread_create thread fails we call
> cleanup_async_copy() that does a put on the file descriptors.
>=20

You mean this?

out_err:
        if (async_copy)
                cleanup_async_copy(async_copy);

That puts the references that were taken in dup_copy_fields, but the
original (embedded) nfsd4_copy also holds references and those are not
being put in this codepath.

> > The cleanup in this codepath is also sort of weird. In the async copy
> > case, we'll have up to four nfsd_file references (src and dst for both
> > flavors of copy structure).
>=20
> That's not true. There is a careful distinction between intra -- which
> had 2 valid file pointers and does a get on both as they both point to
> something that's opened on this server--- but inter -- only does a get
> on the dst file descriptor, the src doesn't exit. And yes I realize
> the code checks for nfs_src being null which it should be but it makes
> the code less clear and at some point somebody might want to decide to
> really do a put on it.
>=20

This is part of the problem here. We have a nfsd4_copy structure, and
depending on what has been done to it, you need to call different
methods to clean it up. That seems like a real antipattern to me.


> > They are both put at the end of
> > nfsd4_do_async_copy, even though the ones held on behalf of the embedde=
d
> > one outlive that structure.
> >=20
> > Change it so that we always clean up the nfsd_file refs held by the
> > embedded copy structure before nfsd4_copy returns. Rework
> > cleanup_async_copy to handle both inter and intra copies. Eliminate
> > nfsd4_cleanup_intra_ssc since it now becomes a no-op.
>=20
> I feel by combining the cleanup for both it obscures a very important
> destication that src filehandle doesn't exist for inter.

If the src filehandle doesn't exist, then the pointer to it will be
NULL. I don't see what we gain by keeping these two distinct, other than
avoiding a NULL pointer check.

>=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/nfs4proc.c | 23 ++++++++++-------------
> >  1 file changed, 10 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 37a9cc8ae7ae..62b9d6c1b18b 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1512,7 +1512,6 @@ nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_i=
tem *nsui, struct file *filp,
> >         long timeout =3D msecs_to_jiffies(nfsd4_ssc_umount_timeout);
> >=20
> >         nfs42_ssc_close(filp);
> > -       nfsd_file_put(dst);
> >         fput(filp);
> >=20
> >         spin_lock(&nn->nfsd_ssc_lock);
> > @@ -1562,13 +1561,6 @@ nfsd4_setup_intra_ssc(struct svc_rqst *rqstp,
> >                                  &copy->nf_dst);
> >  }
> >=20
> > -static void
> > -nfsd4_cleanup_intra_ssc(struct nfsd_file *src, struct nfsd_file *dst)
> > -{
> > -       nfsd_file_put(src);
> > -       nfsd_file_put(dst);
> > -}
> > -
> >  static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
> >  {
> >         struct nfsd4_cb_offload *cbo =3D
> > @@ -1683,12 +1675,18 @@ static void dup_copy_fields(struct nfsd4_copy *=
src, struct nfsd4_copy *dst)
> >         dst->ss_nsui =3D src->ss_nsui;
> >  }
> >=20
> > +static void release_copy_files(struct nfsd4_copy *copy)
> > +{
> > +       if (copy->nf_src)
> > +               nfsd_file_put(copy->nf_src);
> > +       if (copy->nf_dst)
> > +               nfsd_file_put(copy->nf_dst);
> > +}
> > +
> >  static void cleanup_async_copy(struct nfsd4_copy *copy)
> >  {
> >         nfs4_free_copy_state(copy);
> > -       nfsd_file_put(copy->nf_dst);
> > -       if (!nfsd4_ssc_is_inter(copy))
> > -               nfsd_file_put(copy->nf_src);
> > +       release_copy_files(copy);
> >         spin_lock(&copy->cp_clp->async_lock);
> >         list_del(&copy->copies);
> >         spin_unlock(&copy->cp_clp->async_lock);
> > @@ -1748,7 +1746,6 @@ static int nfsd4_do_async_copy(void *data)
> >         } else {
> >                 nfserr =3D nfsd4_do_copy(copy, copy->nf_src->nf_file,
> >                                        copy->nf_dst->nf_file, false);
> > -               nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
> >         }
> >=20
> >  do_callback:
> > @@ -1811,9 +1808,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> >         } else {
> >                 status =3D nfsd4_do_copy(copy, copy->nf_src->nf_file,
> >                                        copy->nf_dst->nf_file, true);
> > -               nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
> >         }
> >  out:
> > +       release_copy_files(copy);
> >         return status;
> >  out_err:
> >         if (async_copy)
> > --
> > 2.39.0
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
