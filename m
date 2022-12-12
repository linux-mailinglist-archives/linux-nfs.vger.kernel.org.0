Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF57F64A752
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 19:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiLLSmH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 13:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiLLSl2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 13:41:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A36B18E15
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 10:39:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62C00611D0
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 18:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5F8C433D2;
        Mon, 12 Dec 2022 18:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670870337;
        bh=/iUVQbo5sdZgGh37YBax4Cu9+rAN5OHSwdROi7VopG4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=J1VJ+aQku/uhMJG24WxT7lNgEefJzmygFO+dmrKU7FTMRPSJv0rhIzRv237x7j2Oh
         0HBKh54YXmycmda6DWnRF1/ttoffC/RViz90mNej3rPibyaCtGdPosjFhur6hTSPJc
         qcJxNzv25y6Sj+iNa8Rf3hZ2rAsowajz/zRzHvC7I0lCTrXXRhzW4Liwq/qF4XzKt5
         YHZyi/OlnGtLp9LNVAaWS22w+XThtHguq5OgWy34x5guFp8nNbN9PNMoSclO7g1WfD
         qiVVs90VCeNdbcFpYjAOTU3r1+NSC94ExmzhJra/oHD6/t5IS/0jqCXJotUzdEne7q
         0VtKn+w6CG5vA==
Message-ID: <6200943464679d51de50a05ab2ca1cc0c91d8685.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Dai Ngo <dai.ngo@oracle.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        "hdthky0@gmail.com" <hdthky0@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>
Date:   Mon, 12 Dec 2022 13:38:55 -0500
In-Reply-To: <6D5F96AA-A8A7-4E19-A566-959F19A3CB0A@oracle.com>
References: <1670786549-27041-1-git-send-email-dai.ngo@oracle.com>
         <7f68cb23445820b4a1c12b74dce0954f537ae5e2.camel@kernel.org>
         <56b0cb4f-dfe9-6892-7fef-1a2965cf1d99@oracle.com>
         <0ab8efccae708faa092a56c6935c33564814bfed.camel@kernel.org>
         <Y5czwRabTFiwah2b@kroah.com>
         <a47cc610af621e95ba359388e93d988f1ef5b17f.camel@kernel.org>
         <Y5dha1Hcgolctt0K@kroah.com>
         <7365935036c192bfc64cda41cb9ccb297e3eb86f.camel@kernel.org>
         <6D5F96AA-A8A7-4E19-A566-959F19A3CB0A@oracle.com>
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

On Mon, 2022-12-12 at 18:16 +0000, Chuck Lever III wrote:
>=20
> > On Dec 12, 2022, at 12:44 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Mon, 2022-12-12 at 18:14 +0100, Greg KH wrote:
> > > On Mon, Dec 12, 2022 at 09:31:19AM -0500, Jeff Layton wrote:
> > > > On Mon, 2022-12-12 at 14:59 +0100, Greg KH wrote:
> > > > > On Mon, Dec 12, 2022 at 08:40:31AM -0500, Jeff Layton wrote:
> > > > > > On Mon, 2022-12-12 at 05:34 -0800, dai.ngo@oracle.com wrote:
> > > > > > > On 12/12/22 4:22 AM, Jeff Layton wrote:
> > > > > > > > On Sun, 2022-12-11 at 11:22 -0800, Dai Ngo wrote:
> > > > > > > > > Problem caused by source's vfsmount being unmounted but r=
emains
> > > > > > > > > on the delayed unmount list. This happens when nfs42_ssc_=
open()
> > > > > > > > > return errors.
> > > > > > > > > Fixed by removing nfsd4_interssc_connect(), leave the vfs=
mount
> > > > > > > > > for the laundromat to unmount when idle time expires.
> > > > > > > > >=20
> > > > > > > > > Reported-by: Xingyuan Mo <hdthky0@gmail.com>
> > > > > > > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > > > > > > ---
> > > > > > > > >  fs/nfsd/nfs4proc.c | 23 +++++++----------------
> > > > > > > > >  1 file changed, 7 insertions(+), 16 deletions(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > > > > > > index 8beb2bc4c328..756e42cf0d01 100644
> > > > > > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > > > > > @@ -1463,13 +1463,6 @@ nfsd4_interssc_connect(struct nl4_=
server *nss, struct svc_rqst *rqstp,
> > > > > > > > >  	return status;
> > > > > > > > >  }
> > > > > > > > >=20
> > > > > > > > > -static void
> > > > > > > > > -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
> > > > > > > > > -{
> > > > > > > > > -	nfs_do_sb_deactive(ss_mnt->mnt_sb);
> > > > > > > > > -	mntput(ss_mnt);
> > > > > > > > > -}
> > > > > > > > > -
> > > > > > > > >  /*
> > > > > > > > >   * Verify COPY destination stateid.
> > > > > > > > >   *
> > > > > > > > > @@ -1572,11 +1565,6 @@ nfsd4_cleanup_inter_ssc(struct vfs=
mount *ss_mnt, struct file *filp,
> > > > > > > > >  {
> > > > > > > > >  }
> > > > > > > > >=20
> > > > > > > > > -static void
> > > > > > > > > -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
> > > > > > > > > -{
> > > > > > > > > -}
> > > > > > > > > -
> > > > > > > > >  static struct file *nfs42_ssc_open(struct vfsmount *ss_m=
nt,
> > > > > > > > >  				   struct nfs_fh *src_fh,
> > > > > > > > >  				   nfs4_stateid *stateid)
> > > > > > > > > @@ -1762,7 +1750,8 @@ static int nfsd4_do_async_copy(void=
 *data)
> > > > > > > > >  		struct file *filp;
> > > > > > > > >=20
> > > > > > > > >  		filp =3D nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
> > > > > > > > > -				      &copy->stateid);
> > > > > > > > > +					&copy->stateid);
> > > > > > > > > +
> > > > > > > > >  		if (IS_ERR(filp)) {
> > > > > > > > >  			switch (PTR_ERR(filp)) {
> > > > > > > > >  			case -EBADF:
> > > > > > > > > @@ -1771,7 +1760,7 @@ static int nfsd4_do_async_copy(void=
 *data)
> > > > > > > > >  			default:
> > > > > > > > >  				nfserr =3D nfserr_offload_denied;
> > > > > > > > >  			}
> > > > > > > > > -			nfsd4_interssc_disconnect(copy->ss_mnt);
> > > > > > > > > +			/* ss_mnt will be unmounted by the laundromat */
> > > > > > > > >  			goto do_callback;
> > > > > > > > >  		}
> > > > > > > > >  		nfserr =3D nfsd4_do_copy(copy, filp, copy->nf_dst->nf_=
file,
> > > > > > > > > @@ -1852,8 +1841,10 @@ nfsd4_copy(struct svc_rqst *rqstp,=
 struct nfsd4_compound_state *cstate,
> > > > > > > > >  	if (async_copy)
> > > > > > > > >  		cleanup_async_copy(async_copy);
> > > > > > > > >  	status =3D nfserrno(-ENOMEM);
> > > > > > > > > -	if (nfsd4_ssc_is_inter(copy))
> > > > > > > > > -		nfsd4_interssc_disconnect(copy->ss_mnt);
> > > > > > > > > +	/*
> > > > > > > > > +	 * source's vfsmount of inter-copy will be unmounted
> > > > > > > > > +	 * by the laundromat
> > > > > > > > > +	 */
> > > > > > > > >  	goto out;
> > > > > > > > >  }
> > > > > > > > >=20
> > > > > > > > This looks reasonable at first glance, but I have some conc=
erns with the
> > > > > > > > refcounting around ss_mnt elsewhere in this code. nfsd4_ssc=
_setup_dul
> > > > > > > > looks for an existing connection and bumps the ni->nsui_ref=
cnt if it
> > > > > > > > finds one.
> > > > > > > >=20
> > > > > > > > But then later, nfsd4_cleanup_inter_ssc has a couple of cas=
es where it
> > > > > > > > just does a bare mntput:
> > > > > > > >=20
> > > > > > > >         if (!nn) {
> > > > > > > >                 mntput(ss_mnt);
> > > > > > > >                 return;
> > > > > > > >         }
> > > > > > > > ...
> > > > > > > >         if (!found) {
> > > > > > > >                 mntput(ss_mnt);
> > > > > > > >                 return;
> > > > > > > >         }
> > > > > > > >=20
> > > > > > > > The first one looks bogus. Can net_generic return NULL? If =
so how, and
> > > > > > > > why is it not a problem elsewhere in the kernel?
> > > > > > >=20
> > > > > > > it looks like net_generic can not fail, no where else check f=
or NULL
> > > > > > > so I will remove this check.
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > For the second case, if the ni is no longer on the list, wh=
ere did the
> > > > > > > > extra ss_mnt reference come from? Maybe that should be a WA=
RN_ON or
> > > > > > > > BUG_ON?
> > > > > > >=20
> > > > > > > if ni is not found on the list then it's a bug somewhere so I=
 will add
> > > > > > > a BUG_ON on this.
> > > > > > >=20
> > > > > >=20
> > > > > > Probably better to just WARN_ON and let any references leak in =
that
> > > > > > case. A BUG_ON implies a panic in some environments, and it's b=
est to
> > > > > > avoid that unless there really is no choice.
> > > > >=20
> > > > > WARN_ON also causes machines to boot that have panic_on_warn enab=
led.
> > > > > Why not just handle the error and keep going?  Why panic at all?
> > > > >=20
> > > >=20
> > > > Who the hell sets panic_on_warn (outside of testing environments)?
> > >=20
> > > All cloud providers and anyone else that wants to "kill the system th=
at
> > > had a problem and have it reboot fast" in order to keep things workin=
g
> > > overall.
> > >=20
> >=20
> > If that's the case, then this situation would probably be one where a
> > cloud provider would want to crash it and come back. NFS grace periods
> > can suck though.
> >=20
> > > > I'm
> > > > suggesting a WARN_ON because not finding an entry at this point
> > > > represents a bug that we'd want reported.
> > >=20
> > > Your call, but we are generally discouraging adding new WARN_ON() for
> > > anything that userspace could ever trigger.  And if userspace can't
> > > trigger it, then it's a normal type of error that you need to handle
> > > anyway, right?
> > >=20
> > > Anyway, your call, just letting you know.
> > >=20
> >=20
> > Understood.
> >=20
> > > > The caller should hold a reference to the object that holds a vfsmo=
unt
> > > > reference. It relies on that vfsmount to do a copy. If it's gone at=
 this
> > > > point where we're releasing that reference, then we're looking at a
> > > > refcounting bug of some sort.
> > >=20
> > > refcounting in the nfsd code, or outside of that?
> > >=20
> >=20
> > It'd be in the nfsd code, but might affect the vfsmount refcount. Inter=
-
> > server copy is quite the tenuous house of cards. ;)
> >=20
> > > > I would expect anyone who sets panic_on_warn to _desire_ a panic in=
 this
> > > > situation. After all, they asked for it. Presumably they want it to=
 do
> > > > some coredump analysis or something?
> > > >=20
> > > > It is debatable whether the stack trace at this point would be help=
ful
> > > > though, so you might consider a pr_warn or something less log-spamm=
y.
> > >=20
> > > If you can recover from it, then yeah, pr_warn() is usually best.
> > >=20
> >=20
> > It does look like Dai went with pr_warn on his v2 patch.
> >=20
> > We'd "recover" by leaking a vfsmount reference. The immediate crash
> > would be avoided, but it might make for interesting "fun" later when yo=
u
> > went to try and unmount the thing.
>=20
> This is a red flag for me. If the leak prevents the system from
> shutting down reliably, then we need to do something more than
> a pr_warn(), I would think.
>=20

Sorry, I should correct myself.

We wouldn't (necessarily) leak a vfsmount reference. If the entry was no
longer on the list, then presumably it has already been cleaned up and
the vfsmount reference put.

It's still a bug though since we _should_ still have a reference to the
nfsd4_ssc_umount_item at this point. So this is really just a potential
use-after-free.

FWIW, the object handling here is somewhat weird as the copy operation
holds a reference to the nfsd4_ssc_umount_item but passes around a
pointer to the vfsmount

I have to wonder if it'd be cleaner to have nfsd4_setup_inter_ssc pass
back a pointer to the nfsd4_ssc_umount_item, so you could pass that to
nfsd4_cleanup_inter_ssc and skip searching for it again at cleanup time.
--=20
Jeff Layton <jlayton@kernel.org>
