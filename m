Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1599A677FCE
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jan 2023 16:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjAWPcu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Jan 2023 10:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjAWPct (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Jan 2023 10:32:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5C146B3
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 07:32:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4118EB80CA9
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 15:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C3CC433D2;
        Mon, 23 Jan 2023 15:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674487961;
        bh=n0ctPfFi7WKDOOpf1r18nyCHSvbSU9vHGsN6cpMOrYE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ugqKWEYGFmjFi9oz6M18NGoFR/FjvnMoSue0XvPI9q8oTLRp7W0/ZgOBgHrDCV0KD
         6banRRyhCbVpQUaH06peRQ5c33zjju8rqWbSA8DQSBuu/95QpEdcHkZS4bri1KWwM6
         HWJGuij3Cihcxy6GujFgeXNX7+jKNRaTVnIWu7Xtpb8Rb3jBjWOxS6ZKf7TCbeB5uU
         TB9olQdGd3tKPMObkpTLgLT4cnRV1NVfbUwYYp+9e8x7rrhW3QtclrxGutcDHjKR5e
         OPd0Ey6ybRH5k4CAtAJAA+7i+qHW6+Z/x21Gz0c6b15PUxdHrYD2MYJ0d4O0Q4jXDX
         qHElF5XRhA7oQ==
Message-ID: <0d93f859badc3e6afe48b153d458f51481b533a6.camel@kernel.org>
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks
 in COPY codepath
From:   Jeff Layton <jlayton@kernel.org>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 23 Jan 2023 10:32:40 -0500
In-Reply-To: <CAN-5tyGOF4eg4WpMzh2kWa=UszC9oQGbKXNeKWOU3hpS5KSHNw@mail.gmail.com>
References: <20230117193831.75201-1-jlayton@kernel.org>
         <20230117193831.75201-3-jlayton@kernel.org>
         <9bff17d4-c305-1918-5079-d2e9cf291bc7@oracle.com>
         <eb5a9fa65a8c2bcc257101c96f7fbbe18a3b74ff.camel@kernel.org>
         <3ff5458c-88ab-18ab-ebfe-98ba8050fd84@oracle.com>
         <3a910faf64ab6442fd089f17a0f7834dbf24cd41.camel@kernel.org>
         <68e2bff9-bf02-4b19-3707-be88b77d8072@oracle.com>
         <4577f120-9191-c138-299f-eeddc3652e8b@oracle.com>
         <80fd3e68dd5ed457bf38f4ff0a6086d568cc3cee.camel@kernel.org>
         <D14F7839-3E42-4592-BF11-4A19905D5AA4@oracle.com>
         <f52f1cbf-aed4-b0f3-2066-9aa67e2a6003@oracle.com>
         <71DC929D-D10B-4721-8327-301A7E65312F@oracle.com>
         <CAN-5tyGOF4eg4WpMzh2kWa=UszC9oQGbKXNeKWOU3hpS5KSHNw@mail.gmail.com>
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

On Mon, 2023-01-23 at 10:22 -0500, Olga Kornievskaia wrote:
> On Sun, Jan 22, 2023 at 11:46 AM Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
> >=20
> >=20
> >=20
> > > On Jan 21, 2023, at 4:28 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> > >=20
> > >=20
> > > On 1/21/23 12:12 PM, Chuck Lever III wrote:
> > > >=20
> > > > > On Jan 21, 2023, at 3:05 PM, Jeff Layton <jlayton@kernel.org> wro=
te:
> > > > >=20
> > > > > On Sat, 2023-01-21 at 11:50 -0800, dai.ngo@oracle.com wrote:
> > > > > > On 1/21/23 10:56 AM, dai.ngo@oracle.com wrote:
> > > > > > > On 1/20/23 3:43 AM, Jeff Layton wrote:
> > > > > > > > On Thu, 2023-01-19 at 10:38 -0800, dai.ngo@oracle.com wrote=
:
> > > > > > > > > On 1/19/23 2:56 AM, Jeff Layton wrote:
> > > > > > > > > > On Wed, 2023-01-18 at 21:05 -0800, dai.ngo@oracle.com w=
rote:
> > > > > > > > > > > On 1/17/23 11:38 AM, Jeff Layton wrote:
> > > > > > > > > > > > There are two different flavors of the nfsd4_copy s=
truct. One is
> > > > > > > > > > > > embedded in the compound and is used directly in sy=
nchronous
> > > > > > > > > > > > copies. The
> > > > > > > > > > > > other is dynamically allocated, refcounted and trac=
ked in the client
> > > > > > > > > > > > struture. For the embedded one, the cleanup just in=
volves
> > > > > > > > > > > > releasing any
> > > > > > > > > > > > nfsd_files held on its behalf. For the async one, t=
he cleanup is
> > > > > > > > > > > > a bit
> > > > > > > > > > > > more involved, and we need to dequeue it from lists=
, unhash it, etc.
> > > > > > > > > > > >=20
> > > > > > > > > > > > There is at least one potential refcount leak in th=
is code now.
> > > > > > > > > > > > If the
> > > > > > > > > > > > kthread_create call fails, then both the src and ds=
t nfsd_files
> > > > > > > > > > > > in the
> > > > > > > > > > > > original nfsd4_copy object are leaked.
> > > > > > > > > > > >=20
> > > > > > > > > > > > The cleanup in this codepath is also sort of weird.=
 In the async
> > > > > > > > > > > > copy
> > > > > > > > > > > > case, we'll have up to four nfsd_file references (s=
rc and dst for
> > > > > > > > > > > > both
> > > > > > > > > > > > flavors of copy structure). They are both put at th=
e end of
> > > > > > > > > > > > nfsd4_do_async_copy, even though the ones held on b=
ehalf of the
> > > > > > > > > > > > embedded
> > > > > > > > > > > > one outlive that structure.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Change it so that we always clean up the nfsd_file =
refs held by the
> > > > > > > > > > > > embedded copy structure before nfsd4_copy returns. =
Rework
> > > > > > > > > > > > cleanup_async_copy to handle both inter and intra c=
opies. Eliminate
> > > > > > > > > > > > nfsd4_cleanup_intra_ssc since it now becomes a no-o=
p.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > > > > > ---
> > > > > > > > > > > >     fs/nfsd/nfs4proc.c | 23 ++++++++++-------------
> > > > > > > > > > > >     1 file changed, 10 insertions(+), 13 deletions(=
-)
> > > > > > > > > > > >=20
> > > > > > > > > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.=
c
> > > > > > > > > > > > index 37a9cc8ae7ae..62b9d6c1b18b 100644
> > > > > > > > > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > > > > > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > > > > > > > > @@ -1512,7 +1512,6 @@ nfsd4_cleanup_inter_ssc(struc=
t
> > > > > > > > > > > > nfsd4_ssc_umount_item *nsui, struct file *filp,
> > > > > > > > > > > >         long timeout =3D msecs_to_jiffies(nfsd4_ssc=
_umount_timeout);
> > > > > > > > > > > >             nfs42_ssc_close(filp);
> > > > > > > > > > > > -    nfsd_file_put(dst);
> > > > > > > > > > > I think we still need this, in addition to release_co=
py_files called
> > > > > > > > > > > from cleanup_async_copy. For async inter-copy, there =
are 2 reference
> > > > > > > > > > > count added to the destination file, one from nfsd4_s=
etup_inter_ssc
> > > > > > > > > > > and the other one from dup_copy_fields. The above nfs=
d_file_put is
> > > > > > > > > > > for
> > > > > > > > > > > the count added by dup_copy_fields.
> > > > > > > > > > >=20
> > > > > > > > > > With this patch, the references held by the original co=
py structure
> > > > > > > > > > are
> > > > > > > > > > put by the call to release_copy_files at the end of nfs=
d4_copy. That
> > > > > > > > > > means that the kthread task is only responsible for put=
ting the
> > > > > > > > > > references held by the (kmalloc'ed) async_copy structur=
e. So, I think
> > > > > > > > > > this gets the nfsd_file refcounting right.
> > > > > > > > > Yes, I see. One refcount is decremented by release_copy_f=
iles at end
> > > > > > > > > of nfsd4_copy and another is decremented by release_copy_=
files in
> > > > > > > > > cleanup_async_copy.
> > > > > > > > >=20
> > > > > > > > > > > >         fput(filp);
> > > > > > > > > > > >             spin_lock(&nn->nfsd_ssc_lock);
> > > > > > > > > > > > @@ -1562,13 +1561,6 @@ nfsd4_setup_intra_ssc(struct=
 svc_rqst *rqstp,
> > > > > > > > > > > >                      &copy->nf_dst);
> > > > > > > > > > > >     }
> > > > > > > > > > > >     -static void
> > > > > > > > > > > > -nfsd4_cleanup_intra_ssc(struct nfsd_file *src, str=
uct nfsd_file
> > > > > > > > > > > > *dst)
> > > > > > > > > > > > -{
> > > > > > > > > > > > -    nfsd_file_put(src);
> > > > > > > > > > > > -    nfsd_file_put(dst);
> > > > > > > > > > > > -}
> > > > > > > > > > > > -
> > > > > > > > > > > >     static void nfsd4_cb_offload_release(struct nfs=
d4_callback *cb)
> > > > > > > > > > > >     {
> > > > > > > > > > > >         struct nfsd4_cb_offload *cbo =3D
> > > > > > > > > > > > @@ -1683,12 +1675,18 @@ static void dup_copy_fields=
(struct
> > > > > > > > > > > > nfsd4_copy *src, struct nfsd4_copy *dst)
> > > > > > > > > > > >         dst->ss_nsui =3D src->ss_nsui;
> > > > > > > > > > > >     }
> > > > > > > > > > > >     +static void release_copy_files(struct nfsd4_co=
py *copy)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +    if (copy->nf_src)
> > > > > > > > > > > > +        nfsd_file_put(copy->nf_src);
> > > > > > > > > > > > +    if (copy->nf_dst)
> > > > > > > > > > > > +        nfsd_file_put(copy->nf_dst);
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > >     static void cleanup_async_copy(struct nfsd4_cop=
y *copy)
> > > > > > > > > > > >     {
> > > > > > > > > > > >         nfs4_free_copy_state(copy);
> > > > > > > > > > > > -    nfsd_file_put(copy->nf_dst);
> > > > > > > > > > > > -    if (!nfsd4_ssc_is_inter(copy))
> > > > > > > > > > > > -        nfsd_file_put(copy->nf_src);
> > > > > > > > > > > > +    release_copy_files(copy);
> > > > > > > > > > > >         spin_lock(&copy->cp_clp->async_lock);
> > > > > > > > > > > >         list_del(&copy->copies);
> > > > > > > > > > > > spin_unlock(&copy->cp_clp->async_lock);
> > > > > > > > > > > > @@ -1748,7 +1746,6 @@ static int nfsd4_do_async_cop=
y(void *data)
> > > > > > > > > > > >         } else {
> > > > > > > > > > > >             nfserr =3D nfsd4_do_copy(copy, copy->nf=
_src->nf_file,
> > > > > > > > > > > >                            copy->nf_dst->nf_file, f=
alse);
> > > > > > > > > > > > -        nfsd4_cleanup_intra_ssc(copy->nf_src, copy=
->nf_dst);
> > > > > > > > > > > >         }
> > > > > > > > > > > >         do_callback:
> > > > > > > > > > > > @@ -1811,9 +1808,9 @@ nfsd4_copy(struct svc_rqst *r=
qstp, struct
> > > > > > > > > > > > nfsd4_compound_state *cstate,
> > > > > > > > > > > >         } else {
> > > > > > > > > > > >             status =3D nfsd4_do_copy(copy, copy->nf=
_src->nf_file,
> > > > > > > > > > > >                            copy->nf_dst->nf_file, t=
rue);
> > > > > > > > > > > > -        nfsd4_cleanup_intra_ssc(copy->nf_src, copy=
->nf_dst);
> > > > > > > > > > > >         }
> > > > > > > > > > > >     out:
> > > > > > > > > > > > +    release_copy_files(copy);
> > > > > > > > > > > >         return status;
> > > > > > > > > > > >     out_err:
> > > > > > > > > > > This is unrelated to the reference count issue.
> > > > > > > > > > >=20
> > > > > > > > > > > Here if this is an inter-copy then we need to decreme=
nt the reference
> > > > > > > > > > > count of the nfsd4_ssc_umount_item so that the vfsmou=
nt can be
> > > > > > > > > > > unmounted
> > > > > > > > > > > later.
> > > > > > > > > > >=20
> > > > > > > > > > Oh, I think I see what you mean. Maybe something like t=
he (untested)
> > > > > > > > > > patch below on top of the original patch would fix that=
?
> > > > > > > > > >=20
> > > > > > > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > > > > > > > index c9057462b973..7475c593553c 100644
> > > > > > > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > > > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > > > > > > @@ -1511,8 +1511,10 @@ nfsd4_cleanup_inter_ssc(struct
> > > > > > > > > > nfsd4_ssc_umount_item *nsui, struct file *filp,
> > > > > > > > > >           struct nfsd_net *nn =3D net_generic(dst->nf_n=
et, nfsd_net_id);
> > > > > > > > > >           long timeout =3D msecs_to_jiffies(nfsd4_ssc_u=
mount_timeout);
> > > > > > > > > >    -       nfs42_ssc_close(filp);
> > > > > > > > > > -       fput(filp);
> > > > > > > > > > +       if (filp) {
> > > > > > > > > > +               nfs42_ssc_close(filp);
> > > > > > > > > > +               fput(filp);
> > > > > > > > > > +       }
> > > > > > > > > >              spin_lock(&nn->nfsd_ssc_lo
> > > > > > > > > >           list_del(&nsui->nsui_list);
> > > > > > > > > > @@ -1813,8 +1815,13 @@ nfsd4_copy(struct svc_rqst *rqst=
p, struct
> > > > > > > > > > nfsd4_compound_state *cstate,
> > > > > > > > > >           release_copy_files(copy);
> > > > > > > > > >           return status;
> > > > > > > > > >    out_err:
> > > > > > > > > > -       if (async_copy)
> > > > > > > > > > +       if (async_copy) {
> > > > > > > > > >                   cleanup_async_copy(async_copy);
> > > > > > > > > > +               if (nfsd4_ssc_is_inter(async_copy))
> > > > > > > > > We don't need to call nfsd4_cleanup_inter_ssc since the t=
hread
> > > > > > > > > nfsd4_do_async_copy has not started yet so the file is no=
t opened.
> > > > > > > > > We just need to do refcount_dec(&copy->ss_nsui->nsui_refc=
nt), unless
> > > > > > > > > you want to change nfsd4_cleanup_inter_ssc to detect this=
 error
> > > > > > > > > condition and only decrement the reference count.
> > > > > > > > >=20
> > > > > > > > Oh yeah, and this would break anyway since the nsui_list he=
ad is not
> > > > > > > > being initialized. Dai, would you mind spinning up a patch =
for this
> > > > > > > > since you're more familiar with the cleanup here?
> > > > > > > Will do. My patch will only fix the unmount issue. Your patch=
 does
> > > > > > > the clean up potential nfsd_file refcount leaks in COPY codep=
ath.
> > > > > > Or do you want me to merge your patch and mine into one?
> > > > > >=20
> > > > > It probably is best to merge them, since backporters will probabl=
y want
> > > > > both patches anyway.
> > > > Unless these two changes are somehow interdependent, I'd like to ke=
ep
> > > > them separate. They address two separate issues, yes?
> > >=20
> > > Yes.
> > >=20
> > > >=20
> > > > And -- narrow fixes need to go to nfsd-fixes, but clean-ups can wai=
t
> > > > for nfsd-next. I'd rather not mix the two types of change.
> > >=20
> > > Ok. Can we do this:
> > >=20
> > > 1. Jeff's patch goes to nfsd-fixes since it has the fix for missing
> > > reference count.
> >=20
> > To make sure I haven't lost track of anything:
> >=20
> > The patch you refer to here is this one:
> >=20
> > https://lore.kernel.org/linux-nfs/20230117193831.75201-3-jlayton@kernel=
.org/
> >=20
> > Correct?
> >=20
> > (I was waiting for Jeff and Olga to come to consensus, and I think
> > they have, so I can apply it to nfsd-fixes now).
>=20
> Sorry folks but I got a bit lost in the thread. I thought Dai pointed
> out that we can't remove the put from the nfsd4_cleanup_inter_ssc()
> because that's the put for the copied structure and not the original
> file references which is what Jeff's patch is trying to address.
>=20

...and then I replied:

With this patch, the references held by the original copy structure are
put by the call to release_copy_files at the end of nfsd4_copy. That
means that the kthread task is only responsible for putting the
references held by the (kmalloc'ed) async_copy structure. So, I think
this gets the nfsd_file refcounting right.


>=20
> > > 2. My fix for the cleanup of allocated memory goes to nfsd-fixes.
> >=20
> > And this one hasn't been posted yet, right? Or did I miss it?
> >=20
> >=20
> > > 3. I will do the optimization Jeff proposed about list_head and
> > > nfsd4_compound in a separate patch that goes into nfsd-next.
> >=20
> > That should be fine.
> >=20
> >=20
> > > -Dai
> > >=20
> > > > > Just make yourself the patch author and keep my S-o-b line.
> > > > >=20
> > > > > > I think we need a bit more cleanup in addition to your patch. W=
hen
> > > > > > kmalloc(sizeof(*async_copy->cp_src), ..) or nfs4_init_copy_stat=
e
> > > > > > fails, the async_copy is not initialized yet so calling cleanup=
_async_copy
> > > > > > can be a problem.
> > > > > >=20
> > > > > Yeah.
> > > > >=20
> > > > > It may even be best to ensure that the list_head and such are ful=
ly
> > > > > initialized for both allocated and embedded struct nfsd4_copy's. =
You
> > > > > might shave off a few cpu cycles by not doing that, but it makes =
things
> > > > > more fragile.
> > > > >=20
> > > > > Even better, we really ought to split a lot of the fields in nfsd=
4_copy
> > > > > into a different structure (maybe nfsd4_async_copy). Trimming dow=
n
> > > > > struct nfsd4_copy would cut down the size of nfsd4_compound as we=
ll
> > > > > since it has a union that contains it. I was planning on doing th=
at
> > > > > eventually, but if you want to take that on, then that would be f=
ine
> > > > > too.
> > > > >=20
> > > > > --
> > > > > Jeff Layton <jlayton@kernel.org>
> > > > --
> > > > Chuck Lever
> >=20
> > --
> > Chuck Lever
> >=20
> >=20
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
