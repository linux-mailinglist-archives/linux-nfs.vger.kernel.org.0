Return-Path: <linux-nfs+bounces-7107-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3278899ADEF
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 23:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2EE41F22658
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 21:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26181D0B97;
	Fri, 11 Oct 2024 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="opIH1Vb3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="flmATDgj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y1IldBT5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xYfkUAV4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC721BB6BB;
	Fri, 11 Oct 2024 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728680932; cv=none; b=q4zteHuuBKW6iJ5MLeL+5gi1+NrTuoWMXQzWs1/TXUfB3eDcerp97yp4zTPNgA85KY9OfY+fKsMn8yrnkR8qw6PLCs/Nz1tXtbDAU3Qn+jcPBIOjlgKO+ktajKUbGgx8Te+f773iwO4VCQ3yMZ1Q1recR0NMo17WoOpxX/1eYM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728680932; c=relaxed/simple;
	bh=gfaL84yf9IN+IqX7Lt3xuv6s+nG6oRUxCDj4zwWG4s4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=mXoTT+w9P+Ty3Ksgd/s8DDdu3TyHbAvVxaCANdOCvpKea01gMo65Awm7lFZGiPGB5QRCsboPQKk9p9cCw8f74lsdZdfL7Wn/bLg7niBrhvD+qIRa7DOqOA1ZHoc1NP824TmK5TemZqL3zbADURQ+DHdrUSuzWw0RUUr2PcDVc4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=opIH1Vb3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=flmATDgj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y1IldBT5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xYfkUAV4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0539E1F8BD;
	Fri, 11 Oct 2024 21:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728680929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgwhKhpOTNmjWyWP42xyfqfCSC2/dTJZg3hfHNgs23g=;
	b=opIH1Vb35htEx3ZFLN4X98kSYokcipk8O2nMFKsQ84KOSqUmAC1rYtt2fVy7eMF+ZBBJaE
	phwp8HWbMo4JLNba5tteQpXm5XLX5++ks+Dl+3uQNXwNqJulKc9zQQyzJbMp1ODGv99Pdm
	DqS9IVPtAe8EFrqcjNfBlr646T1T0U4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728680929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgwhKhpOTNmjWyWP42xyfqfCSC2/dTJZg3hfHNgs23g=;
	b=flmATDgjJGT/hzbRzRMbzzitJwab3VPlrxRufexf+ATImBq44hIvkwh21KWz+oDJ9vtmDZ
	SYOqALjeaHCfJqBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728680928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgwhKhpOTNmjWyWP42xyfqfCSC2/dTJZg3hfHNgs23g=;
	b=y1IldBT5vMjSKNBIVUMirMR2JTHCyx/n/s8HcyesKtacVEPkzNxyA1yU1OCwixsmlV7OQP
	oxqlaaDVhAL4AHg2FfXBdDNeclGfmjv2hPBPj9m8pj7i2qXXwHT8xF28yRz9vLBp2JFcaq
	c6VR15FaAvUWNWKW/q3DTa4ChrouWc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728680928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgwhKhpOTNmjWyWP42xyfqfCSC2/dTJZg3hfHNgs23g=;
	b=xYfkUAV4+K5LzUVtfClPjw3P7eebHEYeX95mp8oIDXkF4OycFkUr1TnmE2j8qMoAIvhXuh
	nC2m4d5tUt/6WWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37FEC136E0;
	Fri, 11 Oct 2024 21:08:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ide+N9uTCWeVCAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 11 Oct 2024 21:08:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "syzbot" <syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com>,
 "Dai Ngo" <dai.ngo@oracle.com>, "Olga Kornievskaia" <kolga@netapp.com>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, "netdev" <netdev@vger.kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_set_doit
In-reply-to: <2E11BA19-A7FD-44F9-8616-F40D40392AA4@oracle.com>
References: <>, <2E11BA19-A7FD-44F9-8616-F40D40392AA4@oracle.com>
Date: Sat, 12 Oct 2024 08:08:41 +1100
Message-id: <172868092131.34603.3179327692157650453@noble.neil.brown.name>
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[d1e76d963f757db40f91];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 12 Oct 2024, Chuck Lever III wrote:
>=20
>=20
> > On Oct 9, 2024, at 4:26=E2=80=AFPM, Jeff Layton <jlayton@kernel.org> wrot=
e:
> >=20
> > On Wed, 2024-09-04 at 10:23 -0400, Chuck Lever wrote:
> >> On Mon, Sep 02, 2024 at 11:57:55AM +1000, NeilBrown wrote:
> >>> On Sun, 01 Sep 2024, syzbot wrote:
> >>>> syzbot has found a reproducer for the following issue on:
> >>>=20
> >>> I had a poke around using the provided disk image and kernel for
> >>> exploring.
> >>>=20
> >>> I think the problem is demonstrated by this stack :
> >>>=20
> >>> [<0>] rpc_wait_bit_killable+0x1b/0x160
> >>> [<0>] __rpc_execute+0x723/0x1460
> >>> [<0>] rpc_execute+0x1ec/0x3f0
> >>> [<0>] rpc_run_task+0x562/0x6c0
> >>> [<0>] rpc_call_sync+0x197/0x2e0
> >>> [<0>] rpcb_register+0x36b/0x670
> >>> [<0>] svc_unregister+0x208/0x730
> >>> [<0>] svc_bind+0x1bb/0x1e0
> >>> [<0>] nfsd_create_serv+0x3f0/0x760
> >>> [<0>] nfsd_nl_listener_set_doit+0x135/0x1a90
> >>> [<0>] genl_rcv_msg+0xb16/0xec0
> >>> [<0>] netlink_rcv_skb+0x1e5/0x430
> >>>=20
> >>> No rpcbind is running on this host so that "svc_unregister" takes a
> >>> long time.  Maybe not forever but if a few of these get queued up all
> >>> blocking some other thread, then maybe that pushed it over the limit.
> >>>=20
> >>> The fact that rpcbind is not running might not be relevant as the test
> >>> messes up the network.  "ping 127.0.0.1" stops working.
> >>>=20
> >>> So this bug comes down to "we try to contact rpcbind while holding a
> >>> mutex and if that gets no response and no error, then we can hold the
> >>> mutex for a long time".
> >>>=20
> >>> Are we surprised? Do we want to fix this?  Any suggestions how?
> >>=20
> >> In the past, we've tried to address "hanging upcall" issues where
> >> the kernel part of an administrative command needs a user space
> >> service that isn't working or present. (eg mount needing a running
> >> gssd)
> >>=20
> >> If NFSD is using the kernel RPC client for the upcall, then maybe
> >> adding the RPC_TASK_SOFTCONN flag might turn the hang into an
> >> immediate failure.
> >>=20
> >> IMO this should be addressed.
> >>=20
> >>=20
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
> > @@ -2042,7 +2042,9 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, =
struct genl_info *info)
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
> > @@ -2082,6 +2084,10 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb,=
 struct genl_info *info)
> >                /* always save the latest error */
> >                if (ret < 0)
> >                        err =3D ret;
> > +
> > +               /* ensure we don't squat on the mutex for too long */
> > +               mutex_unlock(&nfsd_mutex);
> > +               mutex_lock(&nfsd_mutex);
> >        }
> >=20
> >        if (!serv->sv_nrthreads && list_empty(&nn->nfsd_serv->sv_permsocks=
))
>=20
> I had a look at the rpcb upcall code a couple of weeks ago.
> I'm not convinced that setting SOFTCONN in all cases will
> help but unfortunately the reasons for my skepticism have
> all but leaked out of my head.
>=20
> Releasing and re-acquiring the mutex is often a sign of
> a deeper problem. I think you're in the right vicinity
> but I'd like to better understand the actual cause of
> the delay. The listener list shouldn't be all that long,
> but maybe it has a unintentional loop in it?

I think it is wrong to register with rpcbind while holding a mutex.
Registering with rpcbind doesn't need to by synchronous does it?  Could
we punt that to a workqueue?
Do we need to get a failure status back somehow??
wait_for_completion_killable() somewhere??

>=20
> I wish we had a reproducer for these issues.

We do I think.  I downloaded the provided kernel and root image and ran
the reproduced supplied (or maybe an earlier version) and it triggered
quite easily.

NeilBrown

>=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20


