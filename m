Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3055E664B41
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 19:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239343AbjAJSkh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 13:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239568AbjAJSkH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 13:40:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBDCA703F
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 10:34:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35184B81902
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 18:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777DDC433F1;
        Tue, 10 Jan 2023 18:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673375674;
        bh=n7qLatYfoK7NcumjlFltWyeNBhy3pnV3riM26A/HbUc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oHmM/7d++18XJZUx4XfOb6WTx9vQldGgT9gnByiYQHaQwAeR7iElMNfnlg9w5Q0PO
         DbGtI7yg/xrqpvKkX2UNLmiYg2MoOhkrsa77ALCT4pwdTETKg1Aye4k+Xi2oj05mBV
         vowrk0j63Q/NTVBB86bWI4D9IjWG8UW7SfkhXlP21ofB0zH7d6YHaOVxY7RvvdjOsS
         /m9978V32vQg8n8jDk9ylTiUAf+BZFnulQzqm2/2tHiikuQpKm1Mb8Y04kj5zu4lF0
         7UPgWGJRNFeTP7LhHJc6ckIBNCzn9AN7ZQH3FDG3k1wpQzg4/7xLAZHmDANOPgiruA
         19AZAmGTbpb8Q==
Message-ID: <5e34288720627d2a09ae53986780b2d293a54eea.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Dai Ngo <dai.ngo@oracle.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 10 Jan 2023 13:34:33 -0500
In-Reply-To: <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
         <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
         <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
         <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
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

On Tue, 2023-01-10 at 18:17 +0000, Chuck Lever III wrote:
>=20
> > On Jan 10, 2023, at 12:33 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> >=20
> >=20
> > On 1/10/23 2:30 AM, Jeff Layton wrote:
> > > On Mon, 2023-01-09 at 22:48 -0800, Dai Ngo wrote:
> > > > Currently nfsd4_state_shrinker_worker can be schduled multiple time=
s
> > > > from nfsd4_state_shrinker_count when memory is low. This causes
> > > > the WARN_ON_ONCE in __queue_delayed_work to trigger.
> > > >=20
> > > > This patch allows only one instance of nfsd4_state_shrinker_worker
> > > > at a time using the nfsd_shrinker_active flag, protected by the
> > > > client_lock.
> > > >=20
> > > > Replace mod_delayed_work with queue_delayed_work since we
> > > > don't expect to modify the delay of any pending work.
> > > >=20
> > > > Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low m=
emory condition")
> > > > Reported-by: Mike Galbraith <efault@gmx.de>
> > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > ---
> > > >  fs/nfsd/netns.h     |  1 +
> > > >  fs/nfsd/nfs4state.c | 16 ++++++++++++++--
> > > >  2 files changed, 15 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > > > index 8c854ba3285b..801d70926442 100644
> > > > --- a/fs/nfsd/netns.h
> > > > +++ b/fs/nfsd/netns.h
> > > > @@ -196,6 +196,7 @@ struct nfsd_net {
> > > >  	atomic_t		nfsd_courtesy_clients;
> > > >  	struct shrinker		nfsd_client_shrinker;
> > > >  	struct delayed_work	nfsd_shrinker_work;
> > > > +	bool			nfsd_shrinker_active;
> > > >  };
> > > >    /* Simple check to find out if a given net was properly initiali=
zed */
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index ee56c9466304..e00551af6a11 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -4407,11 +4407,20 @@ nfsd4_state_shrinker_count(struct shrinker =
*shrink, struct shrink_control *sc)
> > > >  	struct nfsd_net *nn =3D container_of(shrink,
> > > >  			struct nfsd_net, nfsd_client_shrinker);
> > > >  +	spin_lock(&nn->client_lock);
> > > > +	if (nn->nfsd_shrinker_active) {
> > > > +		spin_unlock(&nn->client_lock);
> > > > +		return 0;
> > > > +	}
> > > Is this extra machinery really necessary? The bool and spinlock don't
> > > seem to be needed. Typically there is no issue with calling
> > > queued_delayed_work when the work is already queued. It just returns
> > > false in that case without doing anything.
> >=20
> > When there are multiple calls to mod_delayed_work/queue_delayed_work
> > we hit the WARN_ON_ONCE's in __queue_delayed_work and __queue_work if
> > the work is queued but not execute yet.
>=20
> The delay argument of zero is interesting. If it's set to a value
> greater than zero, do you still see a problem?
>=20

It should be safe to call it with a delay of 0. If it's always queued
with a delay of 0 though (and it seems to be), you could save a little
space by using a struct work_struct instead.

Also, I'm not sure if this is related, but where do you cancel the
nfsd_shrinker_work before tearing down the struct nfsd_net? I'm not sure
that would explains the problem Mike reported, but I think that needs to
be addressed.

>=20
> > This problem was reported by Mike. I initially tried with only the
> > bool but that was not enough that was why the spinlock was added.
> > Mike verified that the patch fixed the problem.
> >=20
> > -Dai
> >=20
> > >=20
> > > >  	count =3D atomic_read(&nn->nfsd_courtesy_clients);
> > > >  	if (!count)
> > > >  		count =3D atomic_long_read(&num_delegations);
> > > > -	if (count)
> > > > -		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
> > > > +	if (count) {
> > > > +		nn->nfsd_shrinker_active =3D true;
> > > > +		spin_unlock(&nn->client_lock);
> > > > +		queue_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
> > > > +	} else
> > > > +		spin_unlock(&nn->client_lock);
> > > >  	return (unsigned long)count;
> > > >  }
> > > >  @@ -6239,6 +6248,9 @@ nfsd4_state_shrinker_worker(struct work_stru=
ct *work)
> > > >    	courtesy_client_reaper(nn);
> > > >  	deleg_reaper(nn);
> > > > +	spin_lock(&nn->client_lock);
> > > > +	nn->nfsd_shrinker_active =3D 0;
> > > > +	spin_unlock(&nn->client_lock);
> > > >  }
> > > >    static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nf=
s4_stid *stp)
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
