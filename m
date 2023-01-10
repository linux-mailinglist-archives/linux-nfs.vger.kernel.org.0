Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1DC664C70
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 20:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjAJT1g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 14:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjAJT1O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 14:27:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FD5BC87
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 11:27:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51D4D618CB
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 19:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AADC433D2;
        Tue, 10 Jan 2023 19:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673378831;
        bh=HS+JdhWn1+sFmY9XHEbuifclIxJpbRORs9/uNxFY9fk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=C8Aw6ljFis4/6yTy/ZtwHWW4YNAfohFXMQfyAfeRlSEYPvoYfAeH+SH39C8sQTwUG
         7kU/wVhl+OAetZ2ZeI0DYG4YICvwCMg1rVOXGJVBH+HlDc+dHCzRdiRrRo0uqXRmph
         0vaZ2bOLjSL5WGfY+Pwv3ii27Frg6Kk4lqt6Mr+kNO//kdyGgj/LEx7CK1dlRgfFoS
         tISTcmVlROyEmGztMGrPGsLHktHwchRxnC9xEfIcwAw7YW8L3/F4OMFhbFwN/ZrLbf
         WEl7VJ3STA3F8Rheosgw7NhQkBWnrV0lG1ikesfSajs0gdOE5eHZoKee3PU8Se7hn+
         T2Yu29qMbG/wg==
Message-ID: <23b53334e827603d382b1c21d01c096f11f6d122.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, Chuck Lever III <chuck.lever@oracle.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 10 Jan 2023 14:27:09 -0500
In-Reply-To: <81ba97c7-659b-7fb3-5a78-d9a6e14c7933@oracle.com>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
         <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
         <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
         <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
         <a6a0b2cc-1bc0-3884-8675-f90051454f94@oracle.com>
         <EA9249DE-AB97-4919-9FC9-880D90D726B6@oracle.com>
         <81ba97c7-659b-7fb3-5a78-d9a6e14c7933@oracle.com>
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

On Tue, 2023-01-10 at 11:07 -0800, dai.ngo@oracle.com wrote:
> On 1/10/23 10:53 AM, Chuck Lever III wrote:
> >=20
> > > On Jan 10, 2023, at 1:46 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> > >=20
> > >=20
> > > On 1/10/23 10:17 AM, Chuck Lever III wrote:
> > > > > On Jan 10, 2023, at 12:33 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> > > > >=20
> > > > >=20
> > > > > On 1/10/23 2:30 AM, Jeff Layton wrote:
> > > > > > On Mon, 2023-01-09 at 22:48 -0800, Dai Ngo wrote:
> > > > > > > Currently nfsd4_state_shrinker_worker can be schduled multipl=
e times
> > > > > > > from nfsd4_state_shrinker_count when memory is low. This caus=
es
> > > > > > > the WARN_ON_ONCE in __queue_delayed_work to trigger.
> > > > > > >=20
> > > > > > > This patch allows only one instance of nfsd4_state_shrinker_w=
orker
> > > > > > > at a time using the nfsd_shrinker_active flag, protected by t=
he
> > > > > > > client_lock.
> > > > > > >=20
> > > > > > > Replace mod_delayed_work with queue_delayed_work since we
> > > > > > > don't expect to modify the delay of any pending work.
> > > > > > >=20
> > > > > > > Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to=
 low memory condition")
> > > > > > > Reported-by: Mike Galbraith <efault@gmx.de>
> > > > > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > > > > ---
> > > > > > >   fs/nfsd/netns.h     |  1 +
> > > > > > >   fs/nfsd/nfs4state.c | 16 ++++++++++++++--
> > > > > > >   2 files changed, 15 insertions(+), 2 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > > > > > > index 8c854ba3285b..801d70926442 100644
> > > > > > > --- a/fs/nfsd/netns.h
> > > > > > > +++ b/fs/nfsd/netns.h
> > > > > > > @@ -196,6 +196,7 @@ struct nfsd_net {
> > > > > > >   	atomic_t		nfsd_courtesy_clients;
> > > > > > >   	struct shrinker		nfsd_client_shrinker;
> > > > > > >   	struct delayed_work	nfsd_shrinker_work;
> > > > > > > +	bool			nfsd_shrinker_active;
> > > > > > >   };
> > > > > > >     /* Simple check to find out if a given net was properly i=
nitialized */
> > > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > > index ee56c9466304..e00551af6a11 100644
> > > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > > @@ -4407,11 +4407,20 @@ nfsd4_state_shrinker_count(struct shr=
inker *shrink, struct shrink_control *sc)
> > > > > > >   	struct nfsd_net *nn =3D container_of(shrink,
> > > > > > >   			struct nfsd_net, nfsd_client_shrinker);
> > > > > > >   +	spin_lock(&nn->client_lock);
> > > > > > > +	if (nn->nfsd_shrinker_active) {
> > > > > > > +		spin_unlock(&nn->client_lock);
> > > > > > > +		return 0;
> > > > > > > +	}
> > > > > > Is this extra machinery really necessary? The bool and spinlock=
 don't
> > > > > > seem to be needed. Typically there is no issue with calling
> > > > > > queued_delayed_work when the work is already queued. It just re=
turns
> > > > > > false in that case without doing anything.
> > > > > When there are multiple calls to mod_delayed_work/queue_delayed_w=
ork
> > > > > we hit the WARN_ON_ONCE's in __queue_delayed_work and __queue_wor=
k if
> > > > > the work is queued but not execute yet.
> > > > The delay argument of zero is interesting. If it's set to a value
> > > > greater than zero, do you still see a problem?
> > > I tried and tried but could not reproduce the problem that Mike
> > > reported. I guess my VMs don't have fast enough cpus to make it
> > > happen.
> > I'd prefer not to guess... it sounds like we don't have a clear
> > root cause on this one yet.
>=20
> Yes, we do, as I explained in above. The reason I could not reproduce
> it because my system is not fast enough to get multiple calls to
> nfsd4_state_shrinker_count simultaneously.
>=20
> >=20
> > I think I agree with Jeff: a spinlock shouldn't be required to
> > make queuing work safe via this API.
> >=20
> >=20
> > > As Jeff mentioned, delay 0 should be safe and we want to run
> > > the shrinker as soon as possible when memory is low.
> > I suggested that because the !delay code paths seem to lead
> > directly to the WARN_ONs in queue_work(). <shrug>
>=20
> If we use 0 delay then we need the spinlock, as proven by Mike's test.
> If we use delay !=3D 0 then it may work without the spinlock, we will
> Mike to retest it.
>=20
> You and Jeff decide what the delay is and I will make the change
> and retest.
>=20

I don't think this is the issue either. It's more likely that this is
just changing the timing such that it didn't happen. Looking at the
traces that Mike posted, it really looks like the delayed_work is
corrupt.

> >=20
> >=20
> > > -Dai
> > >=20
> > > >=20
> > > > > This problem was reported by Mike. I initially tried with only th=
e
> > > > > bool but that was not enough that was why the spinlock was added.
> > > > > Mike verified that the patch fixed the problem.
> > > > >=20
> > > > > -Dai
> > > > >=20
> > > > > > >   	count =3D atomic_read(&nn->nfsd_courtesy_clients);
> > > > > > >   	if (!count)
> > > > > > >   		count =3D atomic_long_read(&num_delegations);
> > > > > > > -	if (count)
> > > > > > > -		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
> > > > > > > +	if (count) {
> > > > > > > +		nn->nfsd_shrinker_active =3D true;
> > > > > > > +		spin_unlock(&nn->client_lock);
> > > > > > > +		queue_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0)=
;
> > > > > > > +	} else
> > > > > > > +		spin_unlock(&nn->client_lock);
> > > > > > >   	return (unsigned long)count;
> > > > > > >   }
> > > > > > >   @@ -6239,6 +6248,9 @@ nfsd4_state_shrinker_worker(struct wo=
rk_struct *work)
> > > > > > >     	courtesy_client_reaper(nn);
> > > > > > >   	deleg_reaper(nn);
> > > > > > > +	spin_lock(&nn->client_lock);
> > > > > > > +	nn->nfsd_shrinker_active =3D 0;
> > > > > > > +	spin_unlock(&nn->client_lock);
> > > > > > >   }
> > > > > > >     static inline __be32 nfs4_check_fh(struct svc_fh *fhp, st=
ruct nfs4_stid *stp)
> > > > --
> > > > Chuck Lever
> > --
> > Chuck Lever
> >=20
> >=20
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
