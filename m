Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAF16768AB
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jan 2023 21:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjAUUFt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Jan 2023 15:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjAUUFs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Jan 2023 15:05:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B3E22A01
        for <linux-nfs@vger.kernel.org>; Sat, 21 Jan 2023 12:05:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D895560B20
        for <linux-nfs@vger.kernel.org>; Sat, 21 Jan 2023 20:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD34DC433D2;
        Sat, 21 Jan 2023 20:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674331546;
        bh=XWNk2VXpOdaaSKPl0GN6CQ4AbN5jCQ5wP7vDxjZZsME=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fNumdraTOZxlA1MRHWYNx7nrzehsNLJucbKH4pDzjEIHWCmMXcohi1LW8yOqsJXHS
         6h6zc++iFmhuBawWfzpCevkaUp8w6tjNDnuUV0ZZRsO1xKAF8DYJ13da9pYDNaS+FR
         yVws2DFw2Z8f/3pyJfrjRBDvZRg3T/U4ttcnN32mOpIQuK9/3k8DX1ISe/Nejx2BYz
         fnIv7EARqnMwWN9Is1sPPLgvBjaH6RHEm0aTIYgiJX1x+RSJotAeQuuZVqogBWe19+
         +OCXyzBOCH022/bdzi+lZN5hWaVvuIsW8D02poo56bWx/WeEpCNW+D5DPYDm5nLk4d
         wsQSwK/oSPfxA==
Message-ID: <80fd3e68dd5ed457bf38f4ff0a6086d568cc3cee.camel@kernel.org>
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks
 in COPY codepath
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, aglo@umich.edu
Date:   Sat, 21 Jan 2023 15:05:44 -0500
In-Reply-To: <4577f120-9191-c138-299f-eeddc3652e8b@oracle.com>
References: <20230117193831.75201-1-jlayton@kernel.org>
         <20230117193831.75201-3-jlayton@kernel.org>
         <9bff17d4-c305-1918-5079-d2e9cf291bc7@oracle.com>
         <eb5a9fa65a8c2bcc257101c96f7fbbe18a3b74ff.camel@kernel.org>
         <3ff5458c-88ab-18ab-ebfe-98ba8050fd84@oracle.com>
         <3a910faf64ab6442fd089f17a0f7834dbf24cd41.camel@kernel.org>
         <68e2bff9-bf02-4b19-3707-be88b77d8072@oracle.com>
         <4577f120-9191-c138-299f-eeddc3652e8b@oracle.com>
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

On Sat, 2023-01-21 at 11:50 -0800, dai.ngo@oracle.com wrote:
> On 1/21/23 10:56 AM, dai.ngo@oracle.com wrote:
> >=20
> > On 1/20/23 3:43 AM, Jeff Layton wrote:
> > > On Thu, 2023-01-19 at 10:38 -0800, dai.ngo@oracle.com wrote:
> > > > On 1/19/23 2:56 AM, Jeff Layton wrote:
> > > > > On Wed, 2023-01-18 at 21:05 -0800, dai.ngo@oracle.com wrote:
> > > > > > On 1/17/23 11:38 AM, Jeff Layton wrote:
> > > > > > > There are two different flavors of the nfsd4_copy struct. One=
 is
> > > > > > > embedded in the compound and is used directly in synchronous=
=20
> > > > > > > copies. The
> > > > > > > other is dynamically allocated, refcounted and tracked in the=
 client
> > > > > > > struture. For the embedded one, the cleanup just involves=20
> > > > > > > releasing any
> > > > > > > nfsd_files held on its behalf. For the async one, the cleanup=
 is=20
> > > > > > > a bit
> > > > > > > more involved, and we need to dequeue it from lists, unhash i=
t, etc.
> > > > > > >=20
> > > > > > > There is at least one potential refcount leak in this code no=
w.=20
> > > > > > > If the
> > > > > > > kthread_create call fails, then both the src and dst nfsd_fil=
es=20
> > > > > > > in the
> > > > > > > original nfsd4_copy object are leaked.
> > > > > > >=20
> > > > > > > The cleanup in this codepath is also sort of weird. In the as=
ync=20
> > > > > > > copy
> > > > > > > case, we'll have up to four nfsd_file references (src and dst=
 for=20
> > > > > > > both
> > > > > > > flavors of copy structure). They are both put at the end of
> > > > > > > nfsd4_do_async_copy, even though the ones held on behalf of t=
he=20
> > > > > > > embedded
> > > > > > > one outlive that structure.
> > > > > > >=20
> > > > > > > Change it so that we always clean up the nfsd_file refs held =
by the
> > > > > > > embedded copy structure before nfsd4_copy returns. Rework
> > > > > > > cleanup_async_copy to handle both inter and intra copies. Eli=
minate
> > > > > > > nfsd4_cleanup_intra_ssc since it now becomes a no-op.
> > > > > > >=20
> > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > ---
> > > > > > > =A0=A0=A0 fs/nfsd/nfs4proc.c | 23 ++++++++++-------------
> > > > > > > =A0=A0=A0 1 file changed, 10 insertions(+), 13 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > > > > index 37a9cc8ae7ae..62b9d6c1b18b 100644
> > > > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > > > @@ -1512,7 +1512,6 @@ nfsd4_cleanup_inter_ssc(struct=20
> > > > > > > nfsd4_ssc_umount_item *nsui, struct file *filp,
> > > > > > > =A0=A0=A0=A0=A0=A0=A0 long timeout =3D msecs_to_jiffies(nfsd4=
_ssc_umount_timeout);
> > > > > > > =A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 nfs42_ssc_close(filp);
> > > > > > > -=A0=A0=A0 nfsd_file_put(dst);
> > > > > > I think we still need this, in addition to release_copy_files c=
alled
> > > > > > from cleanup_async_copy. For async inter-copy, there are 2 refe=
rence
> > > > > > count added to the destination file, one from nfsd4_setup_inter=
_ssc
> > > > > > and the other one from dup_copy_fields. The above nfsd_file_put=
 is=20
> > > > > > for
> > > > > > the count added by dup_copy_fields.
> > > > > >=20
> > > > > With this patch, the references held by the original copy structu=
re=20
> > > > > are
> > > > > put by the call to release_copy_files at the end of nfsd4_copy. T=
hat
> > > > > means that the kthread task is only responsible for putting the
> > > > > references held by the (kmalloc'ed) async_copy structure. So, I t=
hink
> > > > > this gets the nfsd_file refcounting right.
> > > > Yes, I see. One refcount is decremented by release_copy_files at en=
d
> > > > of nfsd4_copy and another is decremented by release_copy_files in
> > > > cleanup_async_copy.
> > > >=20
> > > > >=20
> > > > > > > =A0=A0=A0=A0=A0=A0=A0 fput(filp);
> > > > > > > =A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 spin_lock(&nn->nfsd_ssc_lock)=
;
> > > > > > > @@ -1562,13 +1561,6 @@ nfsd4_setup_intra_ssc(struct svc_rqst =
*rqstp,
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
&copy->nf_dst);
> > > > > > > =A0=A0=A0 }
> > > > > > > =A0=A0=A0 -static void
> > > > > > > -nfsd4_cleanup_intra_ssc(struct nfsd_file *src, struct nfsd_f=
ile=20
> > > > > > > *dst)
> > > > > > > -{
> > > > > > > -=A0=A0=A0 nfsd_file_put(src);
> > > > > > > -=A0=A0=A0 nfsd_file_put(dst);
> > > > > > > -}
> > > > > > > -
> > > > > > > =A0=A0=A0 static void nfsd4_cb_offload_release(struct nfsd4_c=
allback *cb)
> > > > > > > =A0=A0=A0 {
> > > > > > > =A0=A0=A0=A0=A0=A0=A0 struct nfsd4_cb_offload *cbo =3D
> > > > > > > @@ -1683,12 +1675,18 @@ static void dup_copy_fields(struct=
=20
> > > > > > > nfsd4_copy *src, struct nfsd4_copy *dst)
> > > > > > > =A0=A0=A0=A0=A0=A0=A0 dst->ss_nsui =3D src->ss_nsui;
> > > > > > > =A0=A0=A0 }
> > > > > > > =A0=A0=A0 +static void release_copy_files(struct nfsd4_copy *=
copy)
> > > > > > > +{
> > > > > > > +=A0=A0=A0 if (copy->nf_src)
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 nfsd_file_put(copy->nf_src);
> > > > > > > +=A0=A0=A0 if (copy->nf_dst)
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 nfsd_file_put(copy->nf_dst);
> > > > > > > +}
> > > > > > > +
> > > > > > > =A0=A0=A0 static void cleanup_async_copy(struct nfsd4_copy *c=
opy)
> > > > > > > =A0=A0=A0 {
> > > > > > > =A0=A0=A0=A0=A0=A0=A0 nfs4_free_copy_state(copy);
> > > > > > > -=A0=A0=A0 nfsd_file_put(copy->nf_dst);
> > > > > > > -=A0=A0=A0 if (!nfsd4_ssc_is_inter(copy))
> > > > > > > -=A0=A0=A0=A0=A0=A0=A0 nfsd_file_put(copy->nf_src);
> > > > > > > +=A0=A0=A0 release_copy_files(copy);
> > > > > > > =A0=A0=A0=A0=A0=A0=A0 spin_lock(&copy->cp_clp->async_lock);
> > > > > > > =A0=A0=A0=A0=A0=A0=A0 list_del(&copy->copies);
> > > > > > > spin_unlock(&copy->cp_clp->async_lock);
> > > > > > > @@ -1748,7 +1746,6 @@ static int nfsd4_do_async_copy(void *da=
ta)
> > > > > > > =A0=A0=A0=A0=A0=A0=A0 } else {
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nfserr =3D nfsd4_do_copy(co=
py, copy->nf_src->nf_file,
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 copy->nf_dst->nf_file, false);
> > > > > > > -=A0=A0=A0=A0=A0=A0=A0 nfsd4_cleanup_intra_ssc(copy->nf_src, =
copy->nf_dst);
> > > > > > > =A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > =A0=A0=A0 =A0=A0=A0 do_callback:
> > > > > > > @@ -1811,9 +1808,9 @@ nfsd4_copy(struct svc_rqst *rqstp, stru=
ct=20
> > > > > > > nfsd4_compound_state *cstate,
> > > > > > > =A0=A0=A0=A0=A0=A0=A0 } else {
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 status =3D nfsd4_do_copy(co=
py, copy->nf_src->nf_file,
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 copy->nf_dst->nf_file, true);
> > > > > > > -=A0=A0=A0=A0=A0=A0=A0 nfsd4_cleanup_intra_ssc(copy->nf_src, =
copy->nf_dst);
> > > > > > > =A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > =A0=A0=A0 out:
> > > > > > > +=A0=A0=A0 release_copy_files(copy);
> > > > > > > =A0=A0=A0=A0=A0=A0=A0 return status;
> > > > > > > =A0=A0=A0 out_err:
> > > > > > This is unrelated to the reference count issue.
> > > > > >=20
> > > > > > Here if this is an inter-copy then we need to decrement the ref=
erence
> > > > > > count of the nfsd4_ssc_umount_item so that the vfsmount can be=
=20
> > > > > > unmounted
> > > > > > later.
> > > > > >=20
> > > > > Oh, I think I see what you mean. Maybe something like the (untest=
ed)
> > > > > patch below on top of the original patch would fix that?
> > > > >=20
> > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > > index c9057462b973..7475c593553c 100644
> > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > @@ -1511,8 +1511,10 @@ nfsd4_cleanup_inter_ssc(struct=20
> > > > > nfsd4_ssc_umount_item *nsui, struct file *filp,
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 struct nfsd_net *nn =3D net_generic(d=
st->nf_net, nfsd_net_id);
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 long timeout =3D msecs_to_jiffies(nfs=
d4_ssc_umount_timeout);
> > > > > =A0=A0 -=A0=A0=A0=A0=A0=A0 nfs42_ssc_close(filp);
> > > > > -=A0=A0=A0=A0=A0=A0 fput(filp);
> > > > > +=A0=A0=A0=A0=A0=A0 if (filp) {
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nfs42_ssc_close(filp)=
;
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fput(filp);
> > > > > +=A0=A0=A0=A0=A0=A0 }
> > > > > =A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0 spin_lock(&nn->nfsd_ssc_lo
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 list_del(&nsui->nsui_list);
> > > > > @@ -1813,8 +1815,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct=
=20
> > > > > nfsd4_compound_state *cstate,
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 release_copy_files(copy);
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 return status;
> > > > > =A0=A0 out_err:
> > > > > -=A0=A0=A0=A0=A0=A0 if (async_copy)
> > > > > +=A0=A0=A0=A0=A0=A0 if (async_copy) {
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cleanup_async=
_copy(async_copy);
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (nfsd4_ssc_is_inte=
r(async_copy))
> > > > We don't need to call nfsd4_cleanup_inter_ssc since the thread
> > > > nfsd4_do_async_copy has not started yet so the file is not opened.
> > > > We just need to do refcount_dec(&copy->ss_nsui->nsui_refcnt), unles=
s
> > > > you want to change nfsd4_cleanup_inter_ssc to detect this error
> > > > condition and only decrement the reference count.
> > > >=20
> > > Oh yeah, and this would break anyway since the nsui_list head is not
> > > being initialized. Dai, would you mind spinning up a patch for this
> > > since you're more familiar with the cleanup here?
> >=20
> > Will do. My patch will only fix the unmount issue. Your patch does
> > the clean up potential nfsd_file refcount leaks in COPY codepath.
>=20
> Or do you want me to merge your patch and mine into one?
>=20

It probably is best to merge them, since backporters will probably want
both patches anyway. Just make yourself the patch author and keep my S-
o-b line.

> I think we need a bit more cleanup in addition to your patch. When
> kmalloc(sizeof(*async_copy->cp_src), ..) or nfs4_init_copy_state
> fails, the async_copy is not initialized yet so calling cleanup_async_cop=
y
> can be a problem.
>=20

Yeah.

It may even be best to ensure that the list_head and such are fully
initialized for both allocated and embedded struct nfsd4_copy's. You
might shave off a few cpu cycles by not doing that, but it makes things
more fragile.

Even better, we really ought to split a lot of the fields in nfsd4_copy
into a different structure (maybe nfsd4_async_copy). Trimming down
struct nfsd4_copy would cut down the size of nfsd4_compound as well
since it has a union that contains it. I was planning on doing that
eventually, but if you want to take that on, then that would be fine
too.

--=20
Jeff Layton <jlayton@kernel.org>
