Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53352664C28
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 20:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbjAJTQ6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 14:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239825AbjAJTQu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 14:16:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735372F785
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 11:16:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C4AA6188F
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 19:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C9DC433D2;
        Tue, 10 Jan 2023 19:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673378207;
        bh=a/7QDtL12v4vY3wbfYDT1QmaZtpbKiYzk8o7gFiRi8U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Kq/JKHHySud0V7v/j/Y9pKpqQtDi7cMCvePm1O7coOmWnMfrBkNJO7Kzh5HGbrbwo
         lVp+hxv17vWkQ4b2AugbYNp2rv5xSleNN7fYZCVV9qBcBpShi0C9h2OHZdlPKqt2fC
         QsCOS20miAQp/+S9bxX1p2lve11RGc0HSiv9kKinxY2DG0WPlg0tnjxf9VwHms7aWg
         a2BK7mLRdunde4iTnQX656/3qe1UIqjeNm47EsvmmCS4zTe1TLgiOyPzhpb9Xn/EMS
         BDjdnIsV8sUs6uV8Wuz8l6oW7A6Uq8B3xSh7pdqik2damrcB23qqGzi+4JKZpsAtGk
         aUSh+CG2RhS9A==
Message-ID: <a0e3962470a97ebf4b8e0e707299c3ef794b9729.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Dai Ngo <dai.ngo@oracle.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 10 Jan 2023 14:16:45 -0500
In-Reply-To: <EA9249DE-AB97-4919-9FC9-880D90D726B6@oracle.com>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
         <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
         <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
         <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
         <a6a0b2cc-1bc0-3884-8675-f90051454f94@oracle.com>
         <EA9249DE-AB97-4919-9FC9-880D90D726B6@oracle.com>
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

On Tue, 2023-01-10 at 18:53 +0000, Chuck Lever III wrote:
>=20
> > On Jan 10, 2023, at 1:46 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> >=20
> >=20
> > On 1/10/23 10:17 AM, Chuck Lever III wrote:
> > >=20
> > > > On Jan 10, 2023, at 12:33 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> > > >=20
> > > >=20
> > > > On 1/10/23 2:30 AM, Jeff Layton wrote:
> > > > > On Mon, 2023-01-09 at 22:48 -0800, Dai Ngo wrote:
> > > > > > Currently nfsd4_state_shrinker_worker can be schduled multiple =
times
> > > > > > from nfsd4_state_shrinker_count when memory is low. This causes
> > > > > > the WARN_ON_ONCE in __queue_delayed_work to trigger.
> > > > > >=20
> > > > > > This patch allows only one instance of nfsd4_state_shrinker_wor=
ker
> > > > > > at a time using the nfsd_shrinker_active flag, protected by the
> > > > > > client_lock.
> > > > > >=20
> > > > > > Replace mod_delayed_work with queue_delayed_work since we
> > > > > > don't expect to modify the delay of any pending work.
> > > > > >=20
> > > > > > Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to l=
ow memory condition")
> > > > > > Reported-by: Mike Galbraith <efault@gmx.de>
> > > > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > > > ---
> > > > > >  fs/nfsd/netns.h     |  1 +
> > > > > >  fs/nfsd/nfs4state.c | 16 ++++++++++++++--
> > > > > >  2 files changed, 15 insertions(+), 2 deletions(-)
> > > > > >=20
> > > > > > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > > > > > index 8c854ba3285b..801d70926442 100644
> > > > > > --- a/fs/nfsd/netns.h
> > > > > > +++ b/fs/nfsd/netns.h
> > > > > > @@ -196,6 +196,7 @@ struct nfsd_net {
> > > > > >  	atomic_t		nfsd_courtesy_clients;
> > > > > >  	struct shrinker		nfsd_client_shrinker;
> > > > > >  	struct delayed_work	nfsd_shrinker_work;
> > > > > > +	bool			nfsd_shrinker_active;
> > > > > >  };
> > > > > >    /* Simple check to find out if a given net was properly init=
ialized */
> > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > index ee56c9466304..e00551af6a11 100644
> > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > @@ -4407,11 +4407,20 @@ nfsd4_state_shrinker_count(struct shrin=
ker *shrink, struct shrink_control *sc)
> > > > > >  	struct nfsd_net *nn =3D container_of(shrink,
> > > > > >  			struct nfsd_net, nfsd_client_shrinker);
> > > > > >  +	spin_lock(&nn->client_lock);
> > > > > > +	if (nn->nfsd_shrinker_active) {
> > > > > > +		spin_unlock(&nn->client_lock);
> > > > > > +		return 0;
> > > > > > +	}
> > > > > Is this extra machinery really necessary? The bool and spinlock d=
on't
> > > > > seem to be needed. Typically there is no issue with calling
> > > > > queued_delayed_work when the work is already queued. It just retu=
rns
> > > > > false in that case without doing anything.
> > > > When there are multiple calls to mod_delayed_work/queue_delayed_wor=
k
> > > > we hit the WARN_ON_ONCE's in __queue_delayed_work and __queue_work =
if
> > > > the work is queued but not execute yet.
> > > The delay argument of zero is interesting. If it's set to a value
> > > greater than zero, do you still see a problem?
> >=20
> > I tried and tried but could not reproduce the problem that Mike
> > reported. I guess my VMs don't have fast enough cpus to make it
> > happen.
>=20
> I'd prefer not to guess... it sounds like we don't have a clear
> root cause on this one yet.
>=20
> I think I agree with Jeff: a spinlock shouldn't be required to
> make queuing work safe via this API.
>=20
>=20
> > As Jeff mentioned, delay 0 should be safe and we want to run
> > the shrinker as soon as possible when memory is low.
>=20
> I suggested that because the !delay code paths seem to lead
> directly to the WARN_ONs in queue_work(). <shrug>
>=20
>=20


One of the WARNs in that Mike hit was this:

        WARN_ON_ONCE(timer->function !=3D delayed_work_timer_fn);

nfsd isn't doing anything exotic with that function pointer, so that
really looks like something got corrupted. Given that this is happening
under low-memory conditions, then I have to wonder if we're just ending
up with a workqueue job that remained on the queue after the nfsd_net
got freed and recycled.

I'd start with a patch like this (note, untested):

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2f4a2449b314..86da6663806e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8158,6 +8158,7 @@ nfs4_state_shutdown_net(struct net *net)
        struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
=20
        unregister_shrinker(&nn->nfsd_client_shrinker);
+       cancel_delayed_work_sync(&nn->nfsd_shrinker_work);
        cancel_delayed_work_sync(&nn->laundromat_work);
        locks_end_grace(&nn->nfsd4_manager);


Either way, I think longer nfsd_shrinker_work ought to be converted to a
normal work_struct since you don't ever use the delay.

> > -Dai
> >=20
> > >=20
> > >=20
> > > > This problem was reported by Mike. I initially tried with only the
> > > > bool but that was not enough that was why the spinlock was added.
> > > > Mike verified that the patch fixed the problem.
> > > >=20
> > > > -Dai
> > > >=20
> > > > > >  	count =3D atomic_read(&nn->nfsd_courtesy_clients);
> > > > > >  	if (!count)
> > > > > >  		count =3D atomic_long_read(&num_delegations);
> > > > > > -	if (count)
> > > > > > -		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
> > > > > > +	if (count) {
> > > > > > +		nn->nfsd_shrinker_active =3D true;
> > > > > > +		spin_unlock(&nn->client_lock);
> > > > > > +		queue_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
> > > > > > +	} else
> > > > > > +		spin_unlock(&nn->client_lock);
> > > > > >  	return (unsigned long)count;
> > > > > >  }
> > > > > >  @@ -6239,6 +6248,9 @@ nfsd4_state_shrinker_worker(struct work_=
struct *work)
> > > > > >    	courtesy_client_reaper(nn);
> > > > > >  	deleg_reaper(nn);
> > > > > > +	spin_lock(&nn->client_lock);
> > > > > > +	nn->nfsd_shrinker_active =3D 0;
> > > > > > +	spin_unlock(&nn->client_lock);
> > > > > >  }
> > > > > >    static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struc=
t nfs4_stid *stp)
> > > --
> > > Chuck Lever
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
