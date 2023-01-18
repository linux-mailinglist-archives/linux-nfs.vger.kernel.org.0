Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29F467257A
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 18:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjARRtQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 12:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjARRtP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 12:49:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972CD37F18
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 09:49:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3630361921
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 17:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42291C433D2;
        Wed, 18 Jan 2023 17:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674064153;
        bh=l1K/NzcrIYDLYX9BEFmqGEn7GyzX12VSsnmeSy+oNUw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=urAX5eTar6xWEaQ4U89RBtLSxLda88AMO9i56S9C6/26hRj4/Ma6rzxM0zq3hS7LL
         9I9ehBiDNsmxrAOYHnRJ/gHxWjEpLeCetTfptU7SiYU4z6vJNfeHvfTwVWfKF57mYm
         aL8KkGFoOUU39vd88GLX4GJN23MnF5LNDreZXR1vl3FSx8caUx5sIPs+WxzLktWfae
         jdmcCIqwQdb+64+Oo4W6Gfb9uMd7NUC3QtB3MAWmmnB9/FZ4FjmeE1xRdTgMHF198+
         4aZD6/MGTNzzvW+6F36tkd5vkywiKrRHAnzHTWijMMrDsUEf6maz2JtulqvqhWseJ9
         Z4a27dziO6dQA==
Message-ID: <944bf7f3e6956989933d07aabd4a632de2ec4667.camel@kernel.org>
Subject: Re: [PATCH 1/6] nfsd: don't take nfsd4_copy ref for
 OP_OFFLOAD_STATUS
From:   Jeff Layton <jlayton@kernel.org>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Date:   Wed, 18 Jan 2023 12:49:11 -0500
In-Reply-To: <CAN-5tyHgYpGBaJYB932VAqyMGSMikexA=0uKTzROtP9nw=Nu-w@mail.gmail.com>
References: <20230118173139.71846-1-jlayton@kernel.org>
         <20230118173139.71846-2-jlayton@kernel.org>
         <CAN-5tyHgYpGBaJYB932VAqyMGSMikexA=0uKTzROtP9nw=Nu-w@mail.gmail.com>
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

On Wed, 2023-01-18 at 12:43 -0500, Olga Kornievskaia wrote:
> On Wed, Jan 18, 2023 at 12:35 PM Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > We're not doing any blocking operations for OP_OFFLOAD_STATUS, so takin=
g
> > and putting a reference is a waste of effort. Take the client lock,
> > search for the copy and fetch the wr_bytes_written field and return.
> >=20
> > Also, make find_async_copy a static function.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/nfs4proc.c | 35 ++++++++++++++++++++++++-----------
> >  fs/nfsd/state.h    |  2 --
> >  2 files changed, 24 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 62b9d6c1b18b..731c2b22f163 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1823,23 +1823,34 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> >         goto out;
> >  }
> >=20
> > -struct nfsd4_copy *
> > -find_async_copy(struct nfs4_client *clp, stateid_t *stateid)
> > +static struct nfsd4_copy *
> > +find_async_copy_locked(struct nfs4_client *clp, stateid_t *stateid)
> >  {
> >         struct nfsd4_copy *copy;
> >=20
> > -       spin_lock(&clp->async_lock);
> > +       lockdep_assert_held(&clp->async_lock);
> > +
> >         list_for_each_entry(copy, &clp->async_copies, copies) {
> >                 if (memcmp(&copy->cp_stateid.cs_stid, stateid, NFS4_STA=
TEID_SIZE))
> >                         continue;
> > -               refcount_inc(&copy->refcount);
>=20
> If we don't take a refcount on the copy, this copy could be removed
> between the time we found it in the list of copies and when we then
> look inside to check the amount written so far. This would lead to a
> null (or bad) pointer dereference?
>=20

No. The existing code finds this object, takes a reference to it,
fetches a single integer out of it and then puts the reference. This
patch just has it avoid the reference altogether and fetch the value
while we still hold the spinlock. This should be completely safe
(assuming the locking around the existing list handling is correct,
which it does seem to be).


> > -               spin_unlock(&clp->async_lock);
> >                 return copy;
> >         }
> > -       spin_unlock(&clp->async_lock);
> >         return NULL;
> >  }
> >=20
> > +static struct nfsd4_copy *
> > +find_async_copy(struct nfs4_client *clp, stateid_t *stateid)
> > +{
> > +       struct nfsd4_copy *copy;
> > +
> > +       spin_lock(&clp->async_lock);
> > +       copy =3D find_async_copy_locked(clp, stateid);
> > +       if (copy)
> > +               refcount_inc(&copy->refcount);
> > +       spin_unlock(&clp->async_lock);
> > +       return copy;
> > +}
> > +
> >  static __be32
> >  nfsd4_offload_cancel(struct svc_rqst *rqstp,
> >                      struct nfsd4_compound_state *cstate,
> > @@ -1924,22 +1935,24 @@ nfsd4_fallocate(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> >         nfsd_file_put(nf);
> >         return status;
> >  }
> > +
> >  static __be32
> >  nfsd4_offload_status(struct svc_rqst *rqstp,
> >                      struct nfsd4_compound_state *cstate,
> >                      union nfsd4_op_u *u)
> >  {
> >         struct nfsd4_offload_status *os =3D &u->offload_status;
> > -       __be32 status =3D 0;
> > +       __be32 status =3D nfs_ok;
> >         struct nfsd4_copy *copy;
> >         struct nfs4_client *clp =3D cstate->clp;
> >=20
> > -       copy =3D find_async_copy(clp, &os->stateid);
> > -       if (copy) {
> > +       spin_lock(&clp->async_lock);
> > +       copy =3D find_async_copy_locked(clp, &os->stateid);
> > +       if (copy)
> >                 os->count =3D copy->cp_res.wr_bytes_written;
> > -               nfs4_put_copy(copy);
> > -       } else
> > +       else
> >                 status =3D nfserr_bad_stateid;
> > +       spin_unlock(&clp->async_lock);
> >=20
> >         return status;
> >  }
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index e94634d30591..d49d3060ed4f 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -705,8 +705,6 @@ extern struct nfs4_client_reclaim *nfs4_client_to_r=
eclaim(struct xdr_netobj name
> >  extern bool nfs4_has_reclaimed_state(struct xdr_netobj name, struct nf=
sd_net *nn);
> >=20
> >  void put_nfs4_file(struct nfs4_file *fi);
> > -extern struct nfsd4_copy *
> > -find_async_copy(struct nfs4_client *clp, stateid_t *staetid);
> >  extern void nfs4_put_cpntf_state(struct nfsd_net *nn,
> >                                  struct nfs4_cpntf_state *cps);
> >  extern __be32 manage_cpntf_state(struct nfsd_net *nn, stateid_t *st,
> > --
> > 2.39.0
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
