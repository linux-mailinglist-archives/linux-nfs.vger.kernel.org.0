Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E5E664C7B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 20:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjAJTaj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 14:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjAJTai (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 14:30:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B5C496E7
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 11:30:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2787D618DE
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 19:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D02C433EF;
        Tue, 10 Jan 2023 19:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673379036;
        bh=PmHMLPjMXIHn4yPLQ4GrAYKob9tAJkvFeLX3StFDQH8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=caH/UPZObqP3ighaD0ALnsjX8+cTf8D89/2yfKgWGL3xFuSZWm9fO0RDmGhnYUZW+
         Mw4IOQjIaBmn+lHcUBEKl8YfTBsyqXcBLoiWgGBsrYWCCO6UIRhWMLGWQZSA0rvCCX
         nmCirehfYucw3pI2EHP4T/yLE6AyjmN3SlrTeKlSElZT7XpvOTuXFZA4wzFjd3JpqT
         izegDaFS9jxaFvdrFraVVmnNp9965jmR4DH4HbNGqLGTMv7DJRjrd08BiFhjzWVjWs
         sgTUJJ9Gkx1aMTKOX5XBS+8RCZi1rNVmwp0cPp/KTyO+NQNY0MmcxAV032lNbshpiM
         sIUS8yC36+bDQ==
Message-ID: <f0f56b451287d17426defe77aee1b1240d2a1b31.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, Chuck Lever III <chuck.lever@oracle.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 10 Jan 2023 14:30:34 -0500
In-Reply-To: <42876697-ba42-c38f-219d-f760b94e5fed@oracle.com>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
         <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
         <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
         <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
         <5e34288720627d2a09ae53986780b2d293a54eea.camel@kernel.org>
         <42876697-ba42-c38f-219d-f760b94e5fed@oracle.com>
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

On Tue, 2023-01-10 at 11:17 -0800, dai.ngo@oracle.com wrote:
> On 1/10/23 10:34 AM, Jeff Layton wrote:
> > On Tue, 2023-01-10 at 18:17 +0000, Chuck Lever III wrote:
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
> > > > > >   fs/nfsd/netns.h     |  1 +
> > > > > >   fs/nfsd/nfs4state.c | 16 ++++++++++++++--
> > > > > >   2 files changed, 15 insertions(+), 2 deletions(-)
> > > > > >=20
> > > > > > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > > > > > index 8c854ba3285b..801d70926442 100644
> > > > > > --- a/fs/nfsd/netns.h
> > > > > > +++ b/fs/nfsd/netns.h
> > > > > > @@ -196,6 +196,7 @@ struct nfsd_net {
> > > > > >   	atomic_t		nfsd_courtesy_clients;
> > > > > >   	struct shrinker		nfsd_client_shrinker;
> > > > > >   	struct delayed_work	nfsd_shrinker_work;
> > > > > > +	bool			nfsd_shrinker_active;
> > > > > >   };
> > > > > >     /* Simple check to find out if a given net was properly ini=
tialized */
> > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > index ee56c9466304..e00551af6a11 100644
> > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > @@ -4407,11 +4407,20 @@ nfsd4_state_shrinker_count(struct shrin=
ker *shrink, struct shrink_control *sc)
> > > > > >   	struct nfsd_net *nn =3D container_of(shrink,
> > > > > >   			struct nfsd_net, nfsd_client_shrinker);
> > > > > >   +	spin_lock(&nn->client_lock);
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
> > >=20
> > It should be safe to call it with a delay of 0. If it's always queued
> > with a delay of 0 though (and it seems to be), you could save a little
> > space by using a struct work_struct instead.
>=20
> Can I defer this optimization for now? I need some time to look into it.
>=20

I'd like to see it as part of the eventual patch that's merged. There's
no reason to use a delayed_work struct here at all. You always want the
shrinker work to run ASAP. It should be a simple conversion.
> >=20
> > Also, I'm not sure if this is related, but where do you cancel the
> > nfsd_shrinker_work before tearing down the struct nfsd_net? I'm not sur=
e
> > that would explains the problem Mike reported, but I think that needs t=
o
> > be addressed.
>=20
> Yes, good catch. I will add the cancelling in v2 patch.
>=20
>=20

Looking over the traces that Mike posted, I suspect this is the real
bug, particularly if the server is being restarted during this test.

> >=20
> > > > This problem was reported by Mike. I initially tried with only the
> > > > bool but that was not enough that was why the spinlock was added.
> > > > Mike verified that the patch fixed the problem.
> > > >=20
> > > > -Dai
> > > >=20
> > > > > >   	count =3D atomic_read(&nn->nfsd_courtesy_clients);
> > > > > >   	if (!count)
> > > > > >   		count =3D atomic_long_read(&num_delegations);
> > > > > > -	if (count)
> > > > > > -		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
> > > > > > +	if (count) {
> > > > > > +		nn->nfsd_shrinker_active =3D true;
> > > > > > +		spin_unlock(&nn->client_lock);
> > > > > > +		queue_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
> > > > > > +	} else
> > > > > > +		spin_unlock(&nn->client_lock);
> > > > > >   	return (unsigned long)count;
> > > > > >   }
> > > > > >   @@ -6239,6 +6248,9 @@ nfsd4_state_shrinker_worker(struct work=
_struct *work)
> > > > > >     	courtesy_client_reaper(nn);
> > > > > >   	deleg_reaper(nn);
> > > > > > +	spin_lock(&nn->client_lock);
> > > > > > +	nn->nfsd_shrinker_active =3D 0;
> > > > > > +	spin_unlock(&nn->client_lock);
> > > > > >   }
> > > > > >     static inline __be32 nfs4_check_fh(struct svc_fh *fhp, stru=
ct nfs4_stid *stp)
> > > --
> > > Chuck Lever
> > >=20
> > >=20
> > >=20

--=20
Jeff Layton <jlayton@kernel.org>
