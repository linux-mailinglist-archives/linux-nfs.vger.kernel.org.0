Return-Path: <linux-nfs+bounces-7099-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0890B99AC82
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 21:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5741C267C5
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 19:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183C21CF7DB;
	Fri, 11 Oct 2024 19:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcY/q/YL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1851CDA1C;
	Fri, 11 Oct 2024 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728674107; cv=none; b=i0uECTxHLmOJs71YtQ9BSfwKhGlc646EcstmIGGvqe3k5bjVQAT+Qy1YpkQLne5Pyfqhq1P2oD4BvrlM1HkBm0PWWpHDDVQsmEBELbzkbsLsta555V868o1slrOTi8XV5BmzUv+ccOagl515WqZv2sSoK4SEvOmR8rgo5ueb+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728674107; c=relaxed/simple;
	bh=U5lPd1713QUMa2WXj+womlWaAQCvoGUh16DrNpT4ND0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K+w42mAmt0rGjqMwGcZXWYtcYEbQocwgckng4QIz7gUKwJmKUdzzahqsWnN/1dcUkUDqb944HI3Wu/6R/oS3THXW0mLV+56S+vkO1BNWZiJ/Q5h5HQV/JzBEiORjOKbIvW18qzMFuPNoMzsKhwNR0Var6sf5VXwA9XOan64l3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcY/q/YL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52784C4CEC3;
	Fri, 11 Oct 2024 19:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728674106;
	bh=U5lPd1713QUMa2WXj+womlWaAQCvoGUh16DrNpT4ND0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=DcY/q/YLrxHHSbXbaQxVYQpzgTggCsEv0Bo2ZTOfpftYz5ulTj1+Xd4Zk5/8jik8r
	 Y4iZ1kXKz8oz2OM/AspIra1v4DK8VwCCHq0TRebicN7D78mRD51JHiH/ASrinwUOdV
	 v9IAsO+woKGrGd24truVdSwBPgX5ouSWBoVQVgR0Fkz9yPVKS4XfwK0tBhUzzXaslD
	 z5UE6ryn3Pkitb8i2OUOM2HM2tQwhDCQQaoNGpYXATexoT53RLUNv3w0D9O8/WDL5i
	 jAX9bSr/iGYY7BpZIULTdgm/slPg9t4ssIYovi75vU6IMQaVNSGVN3SmgsM3tIXjM6
	 TYSqwNGBDs7Xg==
Message-ID: <4b57fe6d7b4a922a575c8c9dde1f0f11e8c3fc0e.camel@kernel.org>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_set_doit
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, syzbot
 <syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com>, Dai Ngo
 <dai.ngo@oracle.com>, Olga Kornievskaia <kolga@netapp.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, netdev
 <netdev@vger.kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>, Tom
 Talpey <tom@talpey.com>
Date: Fri, 11 Oct 2024 15:15:04 -0400
In-Reply-To: <2E11BA19-A7FD-44F9-8616-F40D40392AA4@oracle.com>
References: <0000000000004385ec06198753f8@google.com>
	 <000000000000b5ba900620fec99b@google.com>
	 <172524227511.4433.7227683124049217481@noble.neil.brown.name>
	 <ZthtZ4omOnFnhXXr@tissot.1015granger.net>
	 <f37c0b837fd947362eb9d5bf7873347fbc5aa567.camel@kernel.org>
	 <2E11BA19-A7FD-44F9-8616-F40D40392AA4@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-11 at 18:18 +0000, Chuck Lever III wrote:
>=20
> > On Oct 9, 2024, at 4:26=E2=80=AFPM, Jeff Layton <jlayton@kernel.org> wr=
ote:
> >=20
> > On Wed, 2024-09-04 at 10:23 -0400, Chuck Lever wrote:
> > > On Mon, Sep 02, 2024 at 11:57:55AM +1000, NeilBrown wrote:
> > > > On Sun, 01 Sep 2024, syzbot wrote:
> > > > > syzbot has found a reproducer for the following issue on:
> > > >=20
> > > > I had a poke around using the provided disk image and kernel for
> > > > exploring.
> > > >=20
> > > > I think the problem is demonstrated by this stack :
> > > >=20
> > > > [<0>] rpc_wait_bit_killable+0x1b/0x160
> > > > [<0>] __rpc_execute+0x723/0x1460
> > > > [<0>] rpc_execute+0x1ec/0x3f0
> > > > [<0>] rpc_run_task+0x562/0x6c0
> > > > [<0>] rpc_call_sync+0x197/0x2e0
> > > > [<0>] rpcb_register+0x36b/0x670
> > > > [<0>] svc_unregister+0x208/0x730
> > > > [<0>] svc_bind+0x1bb/0x1e0
> > > > [<0>] nfsd_create_serv+0x3f0/0x760
> > > > [<0>] nfsd_nl_listener_set_doit+0x135/0x1a90
> > > > [<0>] genl_rcv_msg+0xb16/0xec0
> > > > [<0>] netlink_rcv_skb+0x1e5/0x430
> > > >=20
> > > > No rpcbind is running on this host so that "svc_unregister" takes a
> > > > long time.  Maybe not forever but if a few of these get queued up a=
ll
> > > > blocking some other thread, then maybe that pushed it over the limi=
t.
> > > >=20
> > > > The fact that rpcbind is not running might not be relevant as the t=
est
> > > > messes up the network.  "ping 127.0.0.1" stops working.
> > > >=20
> > > > So this bug comes down to "we try to contact rpcbind while holding =
a
> > > > mutex and if that gets no response and no error, then we can hold t=
he
> > > > mutex for a long time".
> > > >=20
> > > > Are we surprised? Do we want to fix this?  Any suggestions how?
> > >=20
> > > In the past, we've tried to address "hanging upcall" issues where
> > > the kernel part of an administrative command needs a user space
> > > service that isn't working or present. (eg mount needing a running
> > > gssd)
> > >=20
> > > If NFSD is using the kernel RPC client for the upcall, then maybe
> > > adding the RPC_TASK_SOFTCONN flag might turn the hang into an
> > > immediate failure.
> > >=20
> > > IMO this should be addressed.
> > >=20
> > >=20
> >=20
> > I sent a patch that does the above, but now I'm wondering if we ought
> > to take another approach. The listener array can be pretty long. What
> > if we instead were to just drop and reacquire the mutex in the loop at
> > strategic points? Then we wouldn't squat on the mutex for so long.=20
> >=20
> > Something like this maybe? It's ugly but it might prevent hung task
> > warnings, and listener setup isn't a fastpath anyway.
> >=20
> >=20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 3adbc05ebaac..5de01fb4c557 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -2042,7 +2042,9 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb=
, struct genl_info *info)
> >=20
> >                set_bit(XPT_CLOSE, &xprt->xpt_flags);
> >                spin_unlock_bh(&serv->sv_lock);
> >=20
> >                svc_xprt_close(xprt);
> > +
> > +               /* ensure we don't squat on the mutex for too long */
> > +               mutex_unlock(&nfsd_mutex);
> > +               mutex_lock(&nfsd_mutex);
> >                spin_lock_bh(&serv->sv_lock);
> >        }
> >=20
> > @@ -2082,6 +2084,10 @@ int nfsd_nl_listener_set_doit(struct sk_buff *sk=
b, struct genl_info *info)
> >                /* always save the latest error */
> >                if (ret < 0)
> >                        err =3D ret;
> > +
> > +               /* ensure we don't squat on the mutex for too long */
> > +               mutex_unlock(&nfsd_mutex);
> > +               mutex_lock(&nfsd_mutex);
> >        }
> >=20
> >        if (!serv->sv_nrthreads && list_empty(&nn->nfsd_serv->sv_permsoc=
ks))
>=20
> I had a look at the rpcb upcall code a couple of weeks ago.
> I'm not convinced that setting SOFTCONN in all cases will
> help but unfortunately the reasons for my skepticism have
> all but leaked out of my head.
>=20
> Releasing and re-acquiring the mutex is often a sign of
> a deeper problem.

It might look that way, but in this case we're iterating over the list
in the netlink call. There's no reason we need to hold the nfsd_mutex
over that entire process. Probably we can reduce the scope a bit
further and make this look a little less sketchy. I'll send a revised
patch.

>
> I think you're in the right vicinity
> but I'd like to better understand the actual cause of
> the delay. The listener list shouldn't be all that long,
> but maybe it has a unintentional loop in it?
>=20

I don't think that's possible given that this is in a netlink request,
but I'm no expert there.

> I wish we had a reproducer for these issues.

The old interface only allowed one listener to be set at a time. The
new one allows a list, and I don't think it's bounded in any way. You
could send down hundreds of listeners at once, and if they all end up
hanging for a little while trying to talk to rpcbind, then that could
easily cause the hung task warning.

--=20
Jeff Layton <jlayton@kernel.org>

