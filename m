Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA71364A838
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 20:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiLLTqO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 14:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiLLTqN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 14:46:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3232311465
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 11:46:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B795E611E8
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 19:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A768C433D2;
        Mon, 12 Dec 2022 19:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670874371;
        bh=3C7UzmsyD2ebyoHWAIvC49hx5RsupDLt97/GyXQfZY8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=H8x3FEiQNdlA+lQOVsn8z/ts/y27KYSmdPqKVwkakC41nBJf+Pb51mrMU4tKqcuPI
         YsZekUXF6UaQpPCA0JzkSWHHRiiR2Pk3d5y/ej18dFVX3szrdZAP4g/wN6fi94bP2L
         0nR5oEliUoRrUc6h0iAnLSHVmyS+GXLfVz7MM4fWvOnZAEJKI8AI5hWAn1nMYI2vbo
         JMbRogAJwKpOlEXJ+1efE39YGyy6PTw0PwqqwgJGEF3ciZDXhhZHVqHUngMMorQ5w+
         ZzB1bkvCU9onnPim4KvDl6tJiiF0avhxSNB4w1aO/FD9WueidKoNwOKoF3TN9HV3Rl
         6yvx164urgSPA==
Message-ID: <aefea8e45e99ba948acf4c5744793b6ad674a66c.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Dai Ngo <dai.ngo@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        "hdthky0@gmail.com" <hdthky0@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>
Date:   Mon, 12 Dec 2022 14:46:09 -0500
In-Reply-To: <4CAE538E-9F0B-4B44-956E-C6498A37A83A@oracle.com>
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

On Mon, 2022-12-12 at 19:28 +0000, Chuck Lever III wrote:
>=20
> > On Dec 12, 2022, at 2:16 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> >=20
> >=20
> > On 12/12/22 10:38 AM, Jeff Layton wrote:
> > > On Mon, 2022-12-12 at 18:16 +0000, Chuck Lever III wrote:
> > > > > On Dec 12, 2022, at 12:44 PM, Jeff Layton <jlayton@kernel.org> wr=
ote:
> > > > >=20
> > > > > On Mon, 2022-12-12 at 18:14 +0100, Greg KH wrote:
> > > > > > On Mon, Dec 12, 2022 at 09:31:19AM -0500, Jeff Layton wrote:
> > > > > > > On Mon, 2022-12-12 at 14:59 +0100, Greg KH wrote:
> > > > > > > > On Mon, Dec 12, 2022 at 08:40:31AM -0500, Jeff Layton wrote=
:
> > > > > > > > > On Mon, 2022-12-12 at 05:34 -0800, dai.ngo@oracle.com wro=
te:
> > > > > > > > > > On 12/12/22 4:22 AM, Jeff Layton wrote:
> > > > > > > > > > > On Sun, 2022-12-11 at 11:22 -0800, Dai Ngo wrote:
> > > > > > > > > > > > Problem caused by source's vfsmount being unmounted=
 but remains
> > > > > > > > > > > > on the delayed unmount list. This happens when nfs4=
2_ssc_open()
> > > > > > > > > > > > return errors.
> > > > > > > > > > > > Fixed by removing nfsd4_interssc_connect(), leave t=
he vfsmount
> > > > > > > > > > > > for the laundromat to unmount when idle time expire=
s.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Reported-by: Xingyuan Mo <hdthky0@gmail.com>
> > > > > > > > > > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  fs/nfsd/nfs4proc.c | 23 +++++++----------------
> > > > > > > > > > > >  1 file changed, 7 insertions(+), 16 deletions(-)
> > > > > > > > > > > >=20
> > > > > > > > > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.=
c
> > > > > > > > > > > > index 8beb2bc4c328..756e42cf0d01 100644
> > > > > > > > > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > > > > > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > > > > > > > > @@ -1463,13 +1463,6 @@ nfsd4_interssc_connect(struc=
t nl4_server *nss, struct svc_rqst *rqstp,
> > > > > > > > > > > >  	return status;
> > > > > > > > > > > >  }
> > > > > > > > > > > >=20
> > > > > > > > > > > > -static void
> > > > > > > > > > > > -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
> > > > > > > > > > > > -{
> > > > > > > > > > > > -	nfs_do_sb_deactive(ss_mnt->mnt_sb);
> > > > > > > > > > > > -	mntput(ss_mnt);
> > > > > > > > > > > > -}
> > > > > > > > > > > > -
> > > > > > > > > > > >  /*
> > > > > > > > > > > >   * Verify COPY destination stateid.
> > > > > > > > > > > >   *
> > > > > > > > > > > > @@ -1572,11 +1565,6 @@ nfsd4_cleanup_inter_ssc(stru=
ct vfsmount *ss_mnt, struct file *filp,
> > > > > > > > > > > >  {
> > > > > > > > > > > >  }
> > > > > > > > > > > >=20
> > > > > > > > > > > > -static void
> > > > > > > > > > > > -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
> > > > > > > > > > > > -{
> > > > > > > > > > > > -}
> > > > > > > > > > > > -
> > > > > > > > > > > >  static struct file *nfs42_ssc_open(struct vfsmount=
 *ss_mnt,
> > > > > > > > > > > >  				   struct nfs_fh *src_fh,
> > > > > > > > > > > >  				   nfs4_stateid *stateid)
> > > > > > > > > > > > @@ -1762,7 +1750,8 @@ static int nfsd4_do_async_cop=
y(void *data)
> > > > > > > > > > > >  		struct file *filp;
> > > > > > > > > > > >=20
> > > > > > > > > > > >  		filp =3D nfs42_ssc_open(copy->ss_mnt, &copy->c_f=
h,
> > > > > > > > > > > > -				      &copy->stateid);
> > > > > > > > > > > > +					&copy->stateid);
> > > > > > > > > > > > +
> > > > > > > > > > > >  		if (IS_ERR(filp)) {
> > > > > > > > > > > >  			switch (PTR_ERR(filp)) {
> > > > > > > > > > > >  			case -EBADF:
> > > > > > > > > > > > @@ -1771,7 +1760,7 @@ static int nfsd4_do_async_cop=
y(void *data)
> > > > > > > > > > > >  			default:
> > > > > > > > > > > >  				nfserr =3D nfserr_offload_denied;
> > > > > > > > > > > >  			}
> > > > > > > > > > > > -			nfsd4_interssc_disconnect(copy->ss_mnt);
> > > > > > > > > > > > +			/* ss_mnt will be unmounted by the laundromat *=
/
> > > > > > > > > > > >  			goto do_callback;
> > > > > > > > > > > >  		}
> > > > > > > > > > > >  		nfserr =3D nfsd4_do_copy(copy, filp, copy->nf_ds=
t->nf_file,
> > > > > > > > > > > > @@ -1852,8 +1841,10 @@ nfsd4_copy(struct svc_rqst *=
rqstp, struct nfsd4_compound_state *cstate,
> > > > > > > > > > > >  	if (async_copy)
> > > > > > > > > > > >  		cleanup_async_copy(async_copy);
> > > > > > > > > > > >  	status =3D nfserrno(-ENOMEM);
> > > > > > > > > > > > -	if (nfsd4_ssc_is_inter(copy))
> > > > > > > > > > > > -		nfsd4_interssc_disconnect(copy->ss_mnt);
> > > > > > > > > > > > +	/*
> > > > > > > > > > > > +	 * source's vfsmount of inter-copy will be unmoun=
ted
> > > > > > > > > > > > +	 * by the laundromat
> > > > > > > > > > > > +	 */
> > > > > > > > > > > >  	goto out;
> > > > > > > > > > > >  }
> > > > > > > > > > > >=20
> > > > > > > > > > > This looks reasonable at first glance, but I have som=
e concerns with the
> > > > > > > > > > > refcounting around ss_mnt elsewhere in this code. nfs=
d4_ssc_setup_dul
> > > > > > > > > > > looks for an existing connection and bumps the ni->ns=
ui_refcnt if it
> > > > > > > > > > > finds one.
> > > > > > > > > > >=20
> > > > > > > > > > > But then later, nfsd4_cleanup_inter_ssc has a couple =
of cases where it
> > > > > > > > > > > just does a bare mntput:
> > > > > > > > > > >=20
> > > > > > > > > > >         if (!nn) {
> > > > > > > > > > >                 mntput(ss_mnt);
> > > > > > > > > > >                 return;
> > > > > > > > > > >         }
> > > > > > > > > > > ...
> > > > > > > > > > >         if (!found) {
> > > > > > > > > > >                 mntput(ss_mnt);
> > > > > > > > > > >                 return;
> > > > > > > > > > >         }
> > > > > > > > > > >=20
> > > > > > > > > > > The first one looks bogus. Can net_generic return NUL=
L? If so how, and
> > > > > > > > > > > why is it not a problem elsewhere in the kernel?
> > > > > > > > > > it looks like net_generic can not fail, no where else c=
heck for NULL
> > > > > > > > > > so I will remove this check.
> > > > > > > > > >=20
> > > > > > > > > > > For the second case, if the ni is no longer on the li=
st, where did the
> > > > > > > > > > > extra ss_mnt reference come from? Maybe that should b=
e a WARN_ON or
> > > > > > > > > > > BUG_ON?
> > > > > > > > > > if ni is not found on the list then it's a bug somewher=
e so I will add
> > > > > > > > > > a BUG_ON on this.
> > > > > > > > > >=20
> > > > > > > > > Probably better to just WARN_ON and let any references le=
ak in that
> > > > > > > > > case. A BUG_ON implies a panic in some environments, and =
it's best to
> > > > > > > > > avoid that unless there really is no choice.
> > > > > > > > WARN_ON also causes machines to boot that have panic_on_war=
n enabled.
> > > > > > > > Why not just handle the error and keep going?  Why panic at=
 all?
> > > > > > > >=20
> > > > > > > Who the hell sets panic_on_warn (outside of testing environme=
nts)?
> > > > > > All cloud providers and anyone else that wants to "kill the sys=
tem that
> > > > > > had a problem and have it reboot fast" in order to keep things =
working
> > > > > > overall.
> > > > > >=20
> > > > > If that's the case, then this situation would probably be one whe=
re a
> > > > > cloud provider would want to crash it and come back. NFS grace pe=
riods
> > > > > can suck though.
> > > > >=20
> > > > > > > I'm
> > > > > > > suggesting a WARN_ON because not finding an entry at this poi=
nt
> > > > > > > represents a bug that we'd want reported.
> > > > > > Your call, but we are generally discouraging adding new WARN_ON=
() for
> > > > > > anything that userspace could ever trigger.  And if userspace c=
an't
> > > > > > trigger it, then it's a normal type of error that you need to h=
andle
> > > > > > anyway, right?
> > > > > >=20
> > > > > > Anyway, your call, just letting you know.
> > > > > >=20
> > > > > Understood.
> > > > >=20
> > > > > > > The caller should hold a reference to the object that holds a=
 vfsmount
> > > > > > > reference. It relies on that vfsmount to do a copy. If it's g=
one at this
> > > > > > > point where we're releasing that reference, then we're lookin=
g at a
> > > > > > > refcounting bug of some sort.
> > > > > > refcounting in the nfsd code, or outside of that?
> > > > > >=20
> > > > > It'd be in the nfsd code, but might affect the vfsmount refcount.=
 Inter-
> > > > > server copy is quite the tenuous house of cards. ;)
> > > > >=20
> > > > > > > I would expect anyone who sets panic_on_warn to _desire_ a pa=
nic in this
> > > > > > > situation. After all, they asked for it. Presumably they want=
 it to do
> > > > > > > some coredump analysis or something?
> > > > > > >=20
> > > > > > > It is debatable whether the stack trace at this point would b=
e helpful
> > > > > > > though, so you might consider a pr_warn or something less log=
-spammy.
> > > > > > If you can recover from it, then yeah, pr_warn() is usually bes=
t.
> > > > > >=20
> > > > > It does look like Dai went with pr_warn on his v2 patch.
> > > > >=20
> > > > > We'd "recover" by leaking a vfsmount reference. The immediate cra=
sh
> > > > > would be avoided, but it might make for interesting "fun" later w=
hen you
> > > > > went to try and unmount the thing.
> > > > This is a red flag for me. If the leak prevents the system from
> > > > shutting down reliably, then we need to do something more than
> > > > a pr_warn(), I would think.
> > > >=20
> > > Sorry, I should correct myself.
> > >=20
> > > We wouldn't (necessarily) leak a vfsmount reference. If the entry was=
 no
> > > longer on the list, then presumably it has already been cleaned up an=
d
> > > the vfsmount reference put.
> >=20
> > I think the issue here is not vfsmount reference count. The issue is th=
at
> > we could not find a nfsd4_ssc_umount_item on the list that matches the
> > vfsmount ss_mnt. So the question is what should we do in this case?
> >=20
> > Prior to this patch, when we hit this scenario we just go ahead and
> > unmount the ss_mnt there since it won't be unmounted by the laundromat
> > (it's not on the delayed unmount list).
> >=20
> > With this patch, we don't even unmount the ss_mnt, we just do a pr_warn=
.
> >=20
> > I'd prefer to go back to the previous code to do the unmount and also
> > do a pr_warn.
> >=20
> > > It's still a bug though since we _should_ still have a reference to t=
he
> > > nfsd4_ssc_umount_item at this point. So this is really just a potenti=
al
> > > use-after-free.
> >=20
> > The ss_mnt still might have a reference on the nfsd4_ssc_umount_item
> > but we just can't find it on the list. Even though the possibility for
> > this to happen is from slim to none, we still have to check for it.
> >=20
> > > FWIW, the object handling here is somewhat weird as the copy operatio=
n
> > > holds a reference to the nfsd4_ssc_umount_item but passes around a
> > > pointer to the vfsmount
> > >=20
> > > I have to wonder if it'd be cleaner to have nfsd4_setup_inter_ssc pas=
s
> > > back a pointer to the nfsd4_ssc_umount_item, so you could pass that t=
o
> > > nfsd4_cleanup_inter_ssc and skip searching for it again at cleanup ti=
me.
> >=20
> > Yes, I think returning a pointer to the nfsd4_ssc_umount_item approach
> > would be better.  We won't have to deal with the situation where we can=
't
> > find an item on the list (even though it almost never happen).
> >=20
> > Can we do this enhancement after fixing this use-after-free problem, in
> > a separate patch series?

^^^
I think that'd be best.

> Is there a reason not fix it correctly now?
>=20
> I'd rather not merge a fix that leaves the possibility of a leak.

We're going to need to backport this to earlier kernels and it'll need
to go in soon. I think it'd be to take a minimal fix for the reported
crash, and then Dai can have some time to do a larger cleanup.

--=20
Jeff Layton <jlayton@kernel.org>
