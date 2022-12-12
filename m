Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562A664A618
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 18:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiLLRoM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 12:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLLRoL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 12:44:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9F113E25
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 09:44:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C46A6117C
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 17:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE494C433F0;
        Mon, 12 Dec 2022 17:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670867049;
        bh=99BGHsKbqcOS+FUvty/QIdpIalMMGuuumpI8LvJ8ySU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cwvhfEZnsX+mde3u7JgVQTTzQcuysTIlg3Xdc9cfgqAACyaTJAlV2TPm9nRIw+iiO
         UIA5NEHiiz01lBMDzWtdaDiVjQMWs/X5o0+IsWvcBLdoKCVooy3XDPz/xydRNs3t24
         z9NZm/+sbKNmM585C5XwsQB7VG4PUlC56KLQWqK2H1Dx6DKPUgFWBaSHHGhnxHfFlo
         DE3+8oYY4rf8LN5VWauFvIA9cpL6x/iJXRLDkdIGi52Qr+AN8TdeUwX2I4snna6w8X
         1vm70ssCqaWeCSW/WU6fQBXbREdflYOZJOrlr68UERrWUbDwphzeT4y+D2waN3b6RS
         CtdSy76zsOiMA==
Message-ID: <7365935036c192bfc64cda41cb9ccb297e3eb86f.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
From:   Jeff Layton <jlayton@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dai.ngo@oracle.com, chuck.lever@oracle.com, kolga@netapp.com,
        hdthky0@gmail.com, linux-nfs@vger.kernel.org, security@kernel.org
Date:   Mon, 12 Dec 2022 12:44:07 -0500
In-Reply-To: <Y5dha1Hcgolctt0K@kroah.com>
References: <1670786549-27041-1-git-send-email-dai.ngo@oracle.com>
         <7f68cb23445820b4a1c12b74dce0954f537ae5e2.camel@kernel.org>
         <56b0cb4f-dfe9-6892-7fef-1a2965cf1d99@oracle.com>
         <0ab8efccae708faa092a56c6935c33564814bfed.camel@kernel.org>
         <Y5czwRabTFiwah2b@kroah.com>
         <a47cc610af621e95ba359388e93d988f1ef5b17f.camel@kernel.org>
         <Y5dha1Hcgolctt0K@kroah.com>
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

On Mon, 2022-12-12 at 18:14 +0100, Greg KH wrote:
> On Mon, Dec 12, 2022 at 09:31:19AM -0500, Jeff Layton wrote:
> > On Mon, 2022-12-12 at 14:59 +0100, Greg KH wrote:
> > > On Mon, Dec 12, 2022 at 08:40:31AM -0500, Jeff Layton wrote:
> > > > On Mon, 2022-12-12 at 05:34 -0800, dai.ngo@oracle.com wrote:
> > > > > On 12/12/22 4:22 AM, Jeff Layton wrote:
> > > > > > On Sun, 2022-12-11 at 11:22 -0800, Dai Ngo wrote:
> > > > > > > Problem caused by source's vfsmount being unmounted but remai=
ns
> > > > > > > on the delayed unmount list. This happens when nfs42_ssc_open=
()
> > > > > > > return errors.
> > > > > > > Fixed by removing nfsd4_interssc_connect(), leave the vfsmoun=
t
> > > > > > > for the laundromat to unmount when idle time expires.
> > > > > > >=20
> > > > > > > Reported-by: Xingyuan Mo <hdthky0@gmail.com>
> > > > > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > > > > ---
> > > > > > >   fs/nfsd/nfs4proc.c | 23 +++++++----------------
> > > > > > >   1 file changed, 7 insertions(+), 16 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > > > > index 8beb2bc4c328..756e42cf0d01 100644
> > > > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > > > @@ -1463,13 +1463,6 @@ nfsd4_interssc_connect(struct nl4_serv=
er *nss, struct svc_rqst *rqstp,
> > > > > > >   	return status;
> > > > > > >   }
> > > > > > >  =20
> > > > > > > -static void
> > > > > > > -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
> > > > > > > -{
> > > > > > > -	nfs_do_sb_deactive(ss_mnt->mnt_sb);
> > > > > > > -	mntput(ss_mnt);
> > > > > > > -}
> > > > > > > -
> > > > > > >   /*
> > > > > > >    * Verify COPY destination stateid.
> > > > > > >    *
> > > > > > > @@ -1572,11 +1565,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmoun=
t *ss_mnt, struct file *filp,
> > > > > > >   {
> > > > > > >   }
> > > > > > >  =20
> > > > > > > -static void
> > > > > > > -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
> > > > > > > -{
> > > > > > > -}
> > > > > > > -
> > > > > > >   static struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
> > > > > > >   				   struct nfs_fh *src_fh,
> > > > > > >   				   nfs4_stateid *stateid)
> > > > > > > @@ -1762,7 +1750,8 @@ static int nfsd4_do_async_copy(void *da=
ta)
> > > > > > >   		struct file *filp;
> > > > > > >  =20
> > > > > > >   		filp =3D nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
> > > > > > > -				      &copy->stateid);
> > > > > > > +					&copy->stateid);
> > > > > > > +
> > > > > > >   		if (IS_ERR(filp)) {
> > > > > > >   			switch (PTR_ERR(filp)) {
> > > > > > >   			case -EBADF:
> > > > > > > @@ -1771,7 +1760,7 @@ static int nfsd4_do_async_copy(void *da=
ta)
> > > > > > >   			default:
> > > > > > >   				nfserr =3D nfserr_offload_denied;
> > > > > > >   			}
> > > > > > > -			nfsd4_interssc_disconnect(copy->ss_mnt);
> > > > > > > +			/* ss_mnt will be unmounted by the laundromat */
> > > > > > >   			goto do_callback;
> > > > > > >   		}
> > > > > > >   		nfserr =3D nfsd4_do_copy(copy, filp, copy->nf_dst->nf_fil=
e,
> > > > > > > @@ -1852,8 +1841,10 @@ nfsd4_copy(struct svc_rqst *rqstp, str=
uct nfsd4_compound_state *cstate,
> > > > > > >   	if (async_copy)
> > > > > > >   		cleanup_async_copy(async_copy);
> > > > > > >   	status =3D nfserrno(-ENOMEM);
> > > > > > > -	if (nfsd4_ssc_is_inter(copy))
> > > > > > > -		nfsd4_interssc_disconnect(copy->ss_mnt);
> > > > > > > +	/*
> > > > > > > +	 * source's vfsmount of inter-copy will be unmounted
> > > > > > > +	 * by the laundromat
> > > > > > > +	 */
> > > > > > >   	goto out;
> > > > > > >   }
> > > > > > >  =20
> > > > > > This looks reasonable at first glance, but I have some concerns=
 with the
> > > > > > refcounting around ss_mnt elsewhere in this code.=A0nfsd4_ssc_s=
etup_dul
> > > > > > looks for an existing connection and bumps the ni->nsui_refcnt =
if it
> > > > > > finds one.
> > > > > >=20
> > > > > > But then later, nfsd4_cleanup_inter_ssc has a couple of cases w=
here it
> > > > > > just does a bare mntput:
> > > > > >=20
> > > > > >          if (!nn) {
> > > > > >                  mntput(ss_mnt);
> > > > > >                  return;
> > > > > >          }
> > > > > > ...
> > > > > >          if (!found) {
> > > > > >                  mntput(ss_mnt);
> > > > > >                  return;
> > > > > >          }
> > > > > >=20
> > > > > > The first one looks bogus. Can net_generic return NULL? If so h=
ow, and
> > > > > > why is it not a problem elsewhere in the kernel?
> > > > >=20
> > > > > it looks like net_generic can not fail, no where else check for N=
ULL
> > > > > so I will remove this check.
> > > > >=20
> > > > > >=20
> > > > > > For the second case, if the ni is no longer on the list, where =
did the
> > > > > > extra ss_mnt reference come from? Maybe that should be a WARN_O=
N or
> > > > > > BUG_ON?
> > > > >=20
> > > > > if ni is not found on the list then it's a bug somewhere so I wil=
l add
> > > > > a BUG_ON on this.
> > > > >=20
> > > >=20
> > > > Probably better to just WARN_ON and let any references leak in that
> > > > case. A BUG_ON implies a panic in some environments, and it's best =
to
> > > > avoid that unless there really is no choice.
> > >=20
> > > WARN_ON also causes machines to boot that have panic_on_warn enabled.
> > > Why not just handle the error and keep going?  Why panic at all?
> > >=20
> >=20
> > Who the hell sets panic_on_warn (outside of testing environments)?
>=20
> All cloud providers and anyone else that wants to "kill the system that
> had a problem and have it reboot fast" in order to keep things working
> overall.
>=20

If that's the case, then this situation would probably be one where a
cloud provider would want to crash it and come back. NFS grace periods
can suck though.

> > I'm
> > suggesting a WARN_ON because not finding an entry at this point
> > represents a bug that we'd want reported.
>=20
> Your call, but we are generally discouraging adding new WARN_ON() for
> anything that userspace could ever trigger.  And if userspace can't
> trigger it, then it's a normal type of error that you need to handle
> anyway, right?
>=20
> Anyway, your call, just letting you know.
>=20

Understood.

> > The caller should hold a reference to the object that holds a vfsmount
> > reference. It relies on that vfsmount to do a copy. If it's gone at thi=
s
> > point where we're releasing that reference, then we're looking at a
> > refcounting bug of some sort.
>=20
> refcounting in the nfsd code, or outside of that?
>=20

It'd be in the nfsd code, but might affect the vfsmount refcount. Inter-
server copy is quite the tenuous house of cards. ;)

> > I would expect anyone who sets panic_on_warn to _desire_ a panic in thi=
s
> > situation. After all, they asked for it. Presumably they want it to do
> > some coredump analysis or something?
> >=20
> > It is debatable whether the stack trace at this point would be helpful
> > though, so you might consider a pr_warn or something less log-spammy.
>=20
> If you can recover from it, then yeah, pr_warn() is usually best.
>=20

It does look like Dai went with pr_warn on his v2 patch.

We'd "recover" by leaking a vfsmount reference. The immediate crash
would be avoided, but it might make for interesting "fun" later when you
went to try and unmount the thing.

Hopefully, we're just being paranoid here and this situation never
happens.

--=20
Jeff Layton <jlayton@kernel.org>
