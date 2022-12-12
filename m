Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF4864A96E
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 22:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiLLVSy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 16:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiLLVSS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 16:18:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AD912AEB
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 13:17:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02D3C61234
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 21:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6689C433EF;
        Mon, 12 Dec 2022 21:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670879846;
        bh=LifCIcr5HmX1521Ud1bs3b3GfrEguM9zoGxHz7uLoQM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sqmADY+yvQSlyKU+aaxFYSfjA7yvWG84pW2yFCJaCWvbRJ/2MnL0voRH28oHqL+uG
         1SmKB4Cu/WgP7DexF5kFXCCwV5vsO2d4xr3s54kj6V8MOjsbDpEqQJ9TDgAU5F3CR2
         0ZuV/ABXE5yIk9T3e5nuaDIM/UY9U1VeZCD054FLw6eCq4AH7Wc4dv8wnBIc11D0VH
         MsBoC0q+9T7XLNpdIL4F7fw1dNegASBTK2o8v0O599CYEAgJJVJsqrRsgyMdud5vpz
         L5VguSaEQ1ycpQVOavoYsW+Y40S7ibwHdZ9aPeGMeL3tihF14cyQYECkP+ghq0T7KD
         Wjf4nWLyNRvSQ==
Message-ID: <7f79ec3b87fc9c3a07c2af4ae23d1a7f696279fa.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, Chuck Lever III <chuck.lever@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        "hdthky0@gmail.com" <hdthky0@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>
Date:   Mon, 12 Dec 2022 16:17:24 -0500
In-Reply-To: <d8e08b16-bf99-2d0e-e666-982aa585aa5d@oracle.com>
References: <1670786549-27041-1-git-send-email-dai.ngo@oracle.com>
         <7f68cb23445820b4a1c12b74dce0954f537ae5e2.camel@kernel.org>
         <56b0cb4f-dfe9-6892-7fef-1a2965cf1d99@oracle.com>
         <0ab8efccae708faa092a56c6935c33564814bfed.camel@kernel.org>
         <Y5czwRabTFiwah2b@kroah.com>
         <a47cc610af621e95ba359388e93d988f1ef5b17f.camel@kernel.org>
         <Y5dha1Hcgolctt0K@kroah.com>
         <7365935036c192bfc64cda41cb9ccb297e3eb86f.camel@kernel.org>
         <6D5F96AA-A8A7-4E19-A566-959F19A3CB0A@oracle.com>
         <6200943464679d51de50a05ab2ca1cc0c91d8685.camel@kernel.org>
         <a895cb89-f8f3-a2e1-1958-cf9379ecdcd5@oracle.com>
         <4CAE538E-9F0B-4B44-956E-C6498A37A83A@oracle.com>
         <aefea8e45e99ba948acf4c5744793b6ad674a66c.camel@kernel.org>
         <1EAC1016-CB25-4695-A035-5DA2AA5EF58A@oracle.com>
         <d8e08b16-bf99-2d0e-e666-982aa585aa5d@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-12-12 at 11:59 -0800, dai.ngo@oracle.com wrote:
> On 12/12/22 11:48 AM, Chuck Lever III wrote:
> >=20
> > > On Dec 12, 2022, at 2:46 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > >=20
> > > On Mon, 2022-12-12 at 19:28 +0000, Chuck Lever III wrote:
> > > > > On Dec 12, 2022, at 2:16 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> > > > >=20
> > > > >=20
> > > > > On 12/12/22 10:38 AM, Jeff Layton wrote:
> > > > > > On Mon, 2022-12-12 at 18:16 +0000, Chuck Lever III wrote:
> > > > > > > > On Dec 12, 2022, at 12:44 PM, Jeff Layton <jlayton@kernel.o=
rg> wrote:
> > > > > > > >=20
> > > > > > > > On Mon, 2022-12-12 at 18:14 +0100, Greg KH wrote:
> > > > > > > > > On Mon, Dec 12, 2022 at 09:31:19AM -0500, Jeff Layton wro=
te:
> > > > > > > > > > On Mon, 2022-12-12 at 14:59 +0100, Greg KH wrote:
> > > > > > > > > > > On Mon, Dec 12, 2022 at 08:40:31AM -0500, Jeff Layton=
 wrote:
> > > > > > > > > > > > On Mon, 2022-12-12 at 05:34 -0800, dai.ngo@oracle.c=
om wrote:
> > > > > > > > > > > > > On 12/12/22 4:22 AM, Jeff Layton wrote:
> > > > > > > > > > > > > > On Sun, 2022-12-11 at 11:22 -0800, Dai Ngo wrot=
e:
> > > > > > > > > > > > > > > Problem caused by source's vfsmount being unm=
ounted but remains
> > > > > > > > > > > > > > > on the delayed unmount list. This happens whe=
n nfs42_ssc_open()
> > > > > > > > > > > > > > > return errors.
> > > > > > > > > > > > > > > Fixed by removing nfsd4_interssc_connect(), l=
eave the vfsmount
> > > > > > > > > > > > > > > for the laundromat to unmount when idle time =
expires.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Reported-by: Xingyuan Mo <hdthky0@gmail.com>
> > > > > > > > > > > > > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > > fs/nfsd/nfs4proc.c | 23 +++++++--------------=
--
> > > > > > > > > > > > > > > 1 file changed, 7 insertions(+), 16 deletions=
(-)
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs=
4proc.c
> > > > > > > > > > > > > > > index 8beb2bc4c328..756e42cf0d01 100644
> > > > > > > > > > > > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > > > > > > > > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > > > > > > > > > > > @@ -1463,13 +1463,6 @@ nfsd4_interssc_connect=
(struct nl4_server *nss, struct svc_rqst *rqstp,
> > > > > > > > > > > > > > > 	return status;
> > > > > > > > > > > > > > > }
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > -static void
> > > > > > > > > > > > > > > -nfsd4_interssc_disconnect(struct vfsmount *s=
s_mnt)
> > > > > > > > > > > > > > > -{
> > > > > > > > > > > > > > > -	nfs_do_sb_deactive(ss_mnt->mnt_sb);
> > > > > > > > > > > > > > > -	mntput(ss_mnt);
> > > > > > > > > > > > > > > -}
> > > > > > > > > > > > > > > -
> > > > > > > > > > > > > > > /*
> > > > > > > > > > > > > > >   * Verify COPY destination stateid.
> > > > > > > > > > > > > > >   *
> > > > > > > > > > > > > > > @@ -1572,11 +1565,6 @@ nfsd4_cleanup_inter_ss=
c(struct vfsmount *ss_mnt, struct file *filp,
> > > > > > > > > > > > > > > {
> > > > > > > > > > > > > > > }
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > -static void
> > > > > > > > > > > > > > > -nfsd4_interssc_disconnect(struct vfsmount *s=
s_mnt)
> > > > > > > > > > > > > > > -{
> > > > > > > > > > > > > > > -}
> > > > > > > > > > > > > > > -
> > > > > > > > > > > > > > > static struct file *nfs42_ssc_open(struct vfs=
mount *ss_mnt,
> > > > > > > > > > > > > > > 				   struct nfs_fh *src_fh,
> > > > > > > > > > > > > > > 				   nfs4_stateid *stateid)
> > > > > > > > > > > > > > > @@ -1762,7 +1750,8 @@ static int nfsd4_do_asy=
nc_copy(void *data)
> > > > > > > > > > > > > > > 		struct file *filp;
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > 		filp =3D nfs42_ssc_open(copy->ss_mnt, &copy=
->c_fh,
> > > > > > > > > > > > > > > -				      &copy->stateid);
> > > > > > > > > > > > > > > +					&copy->stateid);
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > 		if (IS_ERR(filp)) {
> > > > > > > > > > > > > > > 			switch (PTR_ERR(filp)) {
> > > > > > > > > > > > > > > 			case -EBADF:
> > > > > > > > > > > > > > > @@ -1771,7 +1760,7 @@ static int nfsd4_do_asy=
nc_copy(void *data)
> > > > > > > > > > > > > > > 			default:
> > > > > > > > > > > > > > > 				nfserr =3D nfserr_offload_denied;
> > > > > > > > > > > > > > > 			}
> > > > > > > > > > > > > > > -			nfsd4_interssc_disconnect(copy->ss_mnt);
> > > > > > > > > > > > > > > +			/* ss_mnt will be unmounted by the laundr=
omat */
> > > > > > > > > > > > > > > 			goto do_callback;
> > > > > > > > > > > > > > > 		}
> > > > > > > > > > > > > > > 		nfserr =3D nfsd4_do_copy(copy, filp, copy->=
nf_dst->nf_file,
> > > > > > > > > > > > > > > @@ -1852,8 +1841,10 @@ nfsd4_copy(struct svc_=
rqst *rqstp, struct nfsd4_compound_state *cstate,
> > > > > > > > > > > > > > > 	if (async_copy)
> > > > > > > > > > > > > > > 		cleanup_async_copy(async_copy);
> > > > > > > > > > > > > > > 	status =3D nfserrno(-ENOMEM);
> > > > > > > > > > > > > > > -	if (nfsd4_ssc_is_inter(copy))
> > > > > > > > > > > > > > > -		nfsd4_interssc_disconnect(copy->ss_mnt);
> > > > > > > > > > > > > > > +	/*
> > > > > > > > > > > > > > > +	 * source's vfsmount of inter-copy will be =
unmounted
> > > > > > > > > > > > > > > +	 * by the laundromat
> > > > > > > > > > > > > > > +	 */
> > > > > > > > > > > > > > > 	goto out;
> > > > > > > > > > > > > > > }
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > This looks reasonable at first glance, but I ha=
ve some concerns with the
> > > > > > > > > > > > > > refcounting around ss_mnt elsewhere in this cod=
e. nfsd4_ssc_setup_dul
> > > > > > > > > > > > > > looks for an existing connection and bumps the =
ni->nsui_refcnt if it
> > > > > > > > > > > > > > finds one.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > But then later, nfsd4_cleanup_inter_ssc has a c=
ouple of cases where it
> > > > > > > > > > > > > > just does a bare mntput:
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > >         if (!nn) {
> > > > > > > > > > > > > >                 mntput(ss_mnt);
> > > > > > > > > > > > > >                 return;
> > > > > > > > > > > > > >         }
> > > > > > > > > > > > > > ...
> > > > > > > > > > > > > >         if (!found) {
> > > > > > > > > > > > > >                 mntput(ss_mnt);
> > > > > > > > > > > > > >                 return;
> > > > > > > > > > > > > >         }
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > The first one looks bogus. Can net_generic retu=
rn NULL? If so how, and
> > > > > > > > > > > > > > why is it not a problem elsewhere in the kernel=
?
> > > > > > > > > > > > > it looks like net_generic can not fail, no where =
else check for NULL
> > > > > > > > > > > > > so I will remove this check.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > > For the second case, if the ni is no longer on =
the list, where did the
> > > > > > > > > > > > > > extra ss_mnt reference come from? Maybe that sh=
ould be a WARN_ON or
> > > > > > > > > > > > > > BUG_ON?
> > > > > > > > > > > > > if ni is not found on the list then it's a bug so=
mewhere so I will add
> > > > > > > > > > > > > a BUG_ON on this.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > Probably better to just WARN_ON and let any referen=
ces leak in that
> > > > > > > > > > > > case. A BUG_ON implies a panic in some environments=
, and it's best to
> > > > > > > > > > > > avoid that unless there really is no choice.
> > > > > > > > > > > WARN_ON also causes machines to boot that have panic_=
on_warn enabled.
> > > > > > > > > > > Why not just handle the error and keep going?  Why pa=
nic at all?
> > > > > > > > > > >=20
> > > > > > > > > > Who the hell sets panic_on_warn (outside of testing env=
ironments)?
> > > > > > > > > All cloud providers and anyone else that wants to "kill t=
he system that
> > > > > > > > > had a problem and have it reboot fast" in order to keep t=
hings working
> > > > > > > > > overall.
> > > > > > > > >=20
> > > > > > > > If that's the case, then this situation would probably be o=
ne where a
> > > > > > > > cloud provider would want to crash it and come back. NFS gr=
ace periods
> > > > > > > > can suck though.
> > > > > > > >=20
> > > > > > > > > > I'm
> > > > > > > > > > suggesting a WARN_ON because not finding an entry at th=
is point
> > > > > > > > > > represents a bug that we'd want reported.
> > > > > > > > > Your call, but we are generally discouraging adding new W=
ARN_ON() for
> > > > > > > > > anything that userspace could ever trigger.  And if users=
pace can't
> > > > > > > > > trigger it, then it's a normal type of error that you nee=
d to handle
> > > > > > > > > anyway, right?
> > > > > > > > >=20
> > > > > > > > > Anyway, your call, just letting you know.
> > > > > > > > >=20
> > > > > > > > Understood.
> > > > > > > >=20
> > > > > > > > > > The caller should hold a reference to the object that h=
olds a vfsmount
> > > > > > > > > > reference. It relies on that vfsmount to do a copy. If =
it's gone at this
> > > > > > > > > > point where we're releasing that reference, then we're =
looking at a
> > > > > > > > > > refcounting bug of some sort.
> > > > > > > > > refcounting in the nfsd code, or outside of that?
> > > > > > > > >=20
> > > > > > > > It'd be in the nfsd code, but might affect the vfsmount ref=
count. Inter-
> > > > > > > > server copy is quite the tenuous house of cards. ;)
> > > > > > > >=20
> > > > > > > > > > I would expect anyone who sets panic_on_warn to _desire=
_ a panic in this
> > > > > > > > > > situation. After all, they asked for it. Presumably the=
y want it to do
> > > > > > > > > > some coredump analysis or something?
> > > > > > > > > >=20
> > > > > > > > > > It is debatable whether the stack trace at this point w=
ould be helpful
> > > > > > > > > > though, so you might consider a pr_warn or something le=
ss log-spammy.
> > > > > > > > > If you can recover from it, then yeah, pr_warn() is usual=
ly best.
> > > > > > > > >=20
> > > > > > > > It does look like Dai went with pr_warn on his v2 patch.
> > > > > > > >=20
> > > > > > > > We'd "recover" by leaking a vfsmount reference. The immedia=
te crash
> > > > > > > > would be avoided, but it might make for interesting "fun" l=
ater when you
> > > > > > > > went to try and unmount the thing.
> > > > > > > This is a red flag for me. If the leak prevents the system fr=
om
> > > > > > > shutting down reliably, then we need to do something more tha=
n
> > > > > > > a pr_warn(), I would think.
> > > > > > >=20
> > > > > > Sorry, I should correct myself.
> > > > > >=20
> > > > > > We wouldn't (necessarily) leak a vfsmount reference. If the ent=
ry was no
> > > > > > longer on the list, then presumably it has already been cleaned=
 up and
> > > > > > the vfsmount reference put.
> > > > > I think the issue here is not vfsmount reference count. The issue=
 is that
> > > > > we could not find a nfsd4_ssc_umount_item on the list that matche=
s the
> > > > > vfsmount ss_mnt. So the question is what should we do in this cas=
e?
> > > > >=20
> > > > > Prior to this patch, when we hit this scenario we just go ahead a=
nd
> > > > > unmount the ss_mnt there since it won't be unmounted by the laund=
romat
> > > > > (it's not on the delayed unmount list).
> > > > >=20
> > > > > With this patch, we don't even unmount the ss_mnt, we just do a p=
r_warn.
> > > > >=20
> > > > > I'd prefer to go back to the previous code to do the unmount and =
also
> > > > > do a pr_warn.
> > > > >=20
> > > > > > It's still a bug though since we _should_ still have a referenc=
e to the
> > > > > > nfsd4_ssc_umount_item at this point. So this is really just a p=
otential
> > > > > > use-after-free.
> > > > > The ss_mnt still might have a reference on the nfsd4_ssc_umount_i=
tem
> > > > > but we just can't find it on the list. Even though the possibilit=
y for
> > > > > this to happen is from slim to none, we still have to check for i=
t.
> > > > >=20
> > > > > > FWIW, the object handling here is somewhat weird as the copy op=
eration
> > > > > > holds a reference to the nfsd4_ssc_umount_item but passes aroun=
d a
> > > > > > pointer to the vfsmount
> > > > > >=20
> > > > > > I have to wonder if it'd be cleaner to have nfsd4_setup_inter_s=
sc pass
> > > > > > back a pointer to the nfsd4_ssc_umount_item, so you could pass =
that to
> > > > > > nfsd4_cleanup_inter_ssc and skip searching for it again at clea=
nup time.
> > > > > Yes, I think returning a pointer to the nfsd4_ssc_umount_item app=
roach
> > > > > would be better.  We won't have to deal with the situation where =
we can't
> > > > > find an item on the list (even though it almost never happen).
> > > > >=20
> > > > > Can we do this enhancement after fixing this use-after-free probl=
em, in
> > > > > a separate patch series?
> > > ^^^
> > > I think that'd be best.
> > >=20
> > > > Is there a reason not fix it correctly now?
> > > >=20
> > > > I'd rather not merge a fix that leaves the possibility of a leak.
> > > We're going to need to backport this to earlier kernels and it'll nee=
d
> > > to go in soon. I think it'd be to take a minimal fix for the reported
> > > crash, and then Dai can have some time to do a larger cleanup.
> > Backporting is important, of course.
> >=20
> > What I was hearing was that the simple fix couldn't be done without
> > introducing a leak or UAF.
>=20
> No, this is not true. This fix is independent of the enhancement
> suggested by Jeff to deal with the way the vfsmount is passed around
> to avoid the condition where the ni item is not found on the list.
>=20
> -Dai

Yep. Dai's patch should fix the reported bug. It just took me a bit to
figure that out because of the unconventional way that the reference to
the nsui is handled. That can and should be addressed in later patches.
--=20
Jeff Layton <jlayton@kernel.org>
