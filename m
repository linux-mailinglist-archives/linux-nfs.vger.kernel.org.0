Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EAF7DBE21
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 17:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjJ3QlK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 12:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjJ3QlJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 12:41:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC3ABD
        for <linux-nfs@vger.kernel.org>; Mon, 30 Oct 2023 09:41:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFC2C433C7;
        Mon, 30 Oct 2023 16:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698684067;
        bh=WKZZaIA0O3NzIRbz25462/IKKK0FNXvKJ65MNHzVeeY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EU9cdLnIFqb/rbjBEV4FPK9zdW/pvZFKQxNoGA89FBHFOOh1Rqq0ZzJahmCk2m3Ni
         vw4K/9UIRBBSrwPpbs+pXrbwi8Wxo2y7SYe+XzqID+gOKgPX/fSQyIDDcE+v1B2E5G
         2wm9v+9OfVi7EtEVMr9+aFppUUC2vuGSydN1szhRZIg2kVonBtinBC+NRyO391u7lo
         LzbMBhr67fcylkui0Y2IDE6i3tFf29eVduISpDfFVSFG4wzjjZDFo2D3guHUH5IJP3
         KyBSwUCnBn/3yXan+miII/x7Ji5EKC0o2HTSPQffmzHA1x1cFjxU1efNRYNYps/ftq
         x85EW/UF7fc1w==
Message-ID: <7988380f001810c24d105e9989fc1fae17241bbd.camel@kernel.org>
Subject: Re: [PATCH 1/5] nfsd: call nfsd_last_thread() before final
 nfsd_put()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date:   Mon, 30 Oct 2023 12:41:05 -0400
In-Reply-To: <ZT/RPxpps2UcjzSh@tissot.1015granger.net>
References: <20231030011247.9794-1-neilb@suse.de>
         <20231030011247.9794-2-neilb@suse.de>
         <eb7fe40bc430891519a038434d41fb9ca6557526.camel@kernel.org>
         <ZT/RPxpps2UcjzSh@tissot.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-10-30 at 11:52 -0400, Chuck Lever wrote:
> On Mon, Oct 30, 2023 at 09:15:17AM -0400, Jeff Layton wrote:
> > On Mon, 2023-10-30 at 12:08 +1100, NeilBrown wrote:
> > > If write_ports_addfd or write_ports_addxprt fail, they call nfsD_put(=
)
> > > without calling nfsd_last_thread().  This leaves nn->nfsd_serv pointi=
ng
> > > to a structure that has been freed.
> > >=20
> > > So export nfsd_last_thread() and call it when the nfsd_serv is about =
to
> > > be destroy.
> > >=20
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/nfsd/nfsctl.c | 9 +++++++--
> > >  fs/nfsd/nfsd.h   | 1 +
> > >  fs/nfsd/nfssvc.c | 2 +-
> > >  3 files changed, 9 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index 739ed5bf71cd..79efb1075f38 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -705,8 +705,10 @@ static ssize_t __write_ports_addfd(char *buf, st=
ruct net *net, const struct cred
> > > =20
> > >  	err =3D svc_addsock(nn->nfsd_serv, net, fd, buf, SIMPLE_TRANSACTION=
_LIMIT, cred);
> > > =20
> > > -	if (err >=3D 0 &&
> > > -	    !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> > > +	if (err < 0 && !nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
> > > +		nfsd_last_thread(net);
> > > +	else if (err >=3D 0 &&
> > > +		 !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> > >  		svc_get(nn->nfsd_serv);
> > > =20
> > >  	nfsd_put(net);
> > > @@ -757,6 +759,9 @@ static ssize_t __write_ports_addxprt(char *buf, s=
truct net *net, const struct cr
> > >  		svc_xprt_put(xprt);
> > >  	}
> > >  out_err:
> > > +	if (!nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
> > > +		nfsd_last_thread(net);
> > > +
> > >  	nfsd_put(net);
> > >  	return err;
> > >  }
> > > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > index f5ff42f41ee7..3286ffacbc56 100644
> > > --- a/fs/nfsd/nfsd.h
> > > +++ b/fs/nfsd/nfsd.h
> > > @@ -155,6 +155,7 @@ int nfsd_vers(struct nfsd_net *nn, int vers, enum=
 vers_op change);
> > >  int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum ve=
rs_op change);
> > >  void nfsd_reset_versions(struct nfsd_net *nn);
> > >  int nfsd_create_serv(struct net *net);
> > > +void nfsd_last_thread(struct net *net);
> > > =20
> > >  extern int nfsd_max_blksize;
> > > =20
> > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > index d6122bb2d167..6c968c02cc29 100644
> > > --- a/fs/nfsd/nfssvc.c
> > > +++ b/fs/nfsd/nfssvc.c
> > > @@ -542,7 +542,7 @@ static struct notifier_block nfsd_inet6addr_notif=
ier =3D {
> > >  /* Only used under nfsd_mutex, so this atomic may be overkill: */
> > >  static atomic_t nfsd_notifier_refcount =3D ATOMIC_INIT(0);
> > > =20
> > > -static void nfsd_last_thread(struct net *net)
> > > +void nfsd_last_thread(struct net *net)
> > >  {
> > >  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > >  	struct svc_serv *serv =3D nn->nfsd_serv;
> >=20
> > This patch should fix the problem that I was seeing with write_ports,
>=20
> Then let's add
>=20
> Fixes: ec52361df99b ("SUNRPC: stop using ->sv_nrthreads as a refcount")
>=20
> to this one, since it addresses a crasher seen in the wild.
>=20
>=20

Sounds good.

> > but it won't fix the hinky error cleanup in nfsd_svc. It looks like tha=
t
> > does get fixed in patch #4 though, so I'm not too concerned.
>=20
> Does that fix also need to be backported?
>=20

I think so, but we might want to split that out into a more targeted
patch and apply it ahead of the rest of the series. Our QA folks seem to
be able to hit the problem somehow, so it's likely to be triggered by
people in the field too.

--=20
Jeff Layton <jlayton@kernel.org>
