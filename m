Return-Path: <linux-nfs+bounces-7889-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AE99C4B51
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 01:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1941F23A4B
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 00:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC8D203705;
	Tue, 12 Nov 2024 00:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AeEjT/UT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mYRGwoHP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AeEjT/UT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mYRGwoHP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C4D2036FF;
	Tue, 12 Nov 2024 00:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731372889; cv=none; b=bUbA5mV+JXaQSkvi3Yspke7WoUDq1/ydkMLQNPdjfy2gjI9xGTud1ISQJM1Al9+5IFp7GmLHLHZJ8EhAFkEu+uUCdLyOdnesp4RfetxS9++vzovZ+QvlUC1rxmkL6dox57P5Cp1jyL4a04YfY4oSTNgiDMOsEy7vuvcDz5tLG/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731372889; c=relaxed/simple;
	bh=osYS7EHpOGzx+Piy2UyLOZRqyNpn3o6M9JFpIHROG6Q=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=GNdd4XEzwdQlqRHFamDFc+bqp5FBvMiW+ne2n9LO6GqrLM5fJiVtSvuuO3IzkYfK1o/wE7h7UCNXd/STeC7lEXPrF9fO3Y6u9oBmJPvyOgmhN3bF7dilkZIJ24vOAIsFOMGAXX+TYXgPXimts8Mczq0A3yDZBBdj8bVhDKeBNdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AeEjT/UT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mYRGwoHP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AeEjT/UT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mYRGwoHP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AADA0218E3;
	Tue, 12 Nov 2024 00:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731372885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6F14NsDRsdWANMJTniCkYEkYqBsNKRnJkZ86hgHyOGE=;
	b=AeEjT/UTQ/1bX/cci5TioFWmprxr538nM/DFd6eDY5xMKRnZcDZzYkBTno1zkXwAGvapmt
	BXTfx6QAcHn35LvZ1pmaKbeNg2hV3yHL8LWz+0NBJsXlZ9x1gL1iwjRoU5sx//OxPoRiM6
	SLncuQbAb4Wj/6Cj7KdQ4tF4ITMXftE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731372885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6F14NsDRsdWANMJTniCkYEkYqBsNKRnJkZ86hgHyOGE=;
	b=mYRGwoHP4RDALRYfsZ8s91XePpI7OiVqZjv5f2Rs8hXXpVK4Ovv/xeCtoREl48q+RzFdDm
	/ZQPFCzmazlgzLAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="AeEjT/UT";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mYRGwoHP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731372885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6F14NsDRsdWANMJTniCkYEkYqBsNKRnJkZ86hgHyOGE=;
	b=AeEjT/UTQ/1bX/cci5TioFWmprxr538nM/DFd6eDY5xMKRnZcDZzYkBTno1zkXwAGvapmt
	BXTfx6QAcHn35LvZ1pmaKbeNg2hV3yHL8LWz+0NBJsXlZ9x1gL1iwjRoU5sx//OxPoRiM6
	SLncuQbAb4Wj/6Cj7KdQ4tF4ITMXftE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731372885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6F14NsDRsdWANMJTniCkYEkYqBsNKRnJkZ86hgHyOGE=;
	b=mYRGwoHP4RDALRYfsZ8s91XePpI7OiVqZjv5f2Rs8hXXpVK4Ovv/xeCtoREl48q+RzFdDm
	/ZQPFCzmazlgzLAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A8E713301;
	Tue, 12 Nov 2024 00:54:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V0LcDFCnMmcQEgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 12 Nov 2024 00:54:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Kuniyuki Iwashima" <kuniyu@amazon.com>
Cc: Dai.Ngo@oracle.com, anna@kernel.org, chuck.lever@oracle.com,
 davem@davemloft.net, ebiederm@xmission.com, edumazet@google.com,
 horms@kernel.org, jlayton@kernel.org, kuba@kernel.org, kuniyu@amazon.com,
 linux-nfs@vger.kernel.org, liujian56@huawei.com, netdev@vger.kernel.org,
 okorniev@redhat.com, pabeni@redhat.com, tom@talpey.com, trondmy@kernel.org
Subject: Re: [PATCH net v3] sunrpc: fix one UAF issue caused by sunrpc kernel
 tcp socket
In-reply-to: <20241112001308.58355-1-kuniyu@amazon.com>
References: <173136915454.1734440.13584866019725922631@noble.neil.brown.name>,
 <20241112001308.58355-1-kuniyu@amazon.com>
Date: Tue, 12 Nov 2024 11:54:33 +1100
Message-id: <173137287362.1734440.10390654443609505654@noble.neil.brown.name>
X-Rspamd-Queue-Id: AADA0218E3
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Tue, 12 Nov 2024, Kuniyuki Iwashima wrote:
> From: "NeilBrown" <neilb@suse.de>
> Date: Tue, 12 Nov 2024 10:52:34 +1100
> > > diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> > > index 6f272013fd9b..d4330aaadc23 100644
> > > --- a/net/sunrpc/svcsock.c
> > > +++ b/net/sunrpc/svcsock.c
> > > @@ -1551,6 +1551,10 @@ static struct svc_xprt *svc_create_socket(struct=
 svc_serv *serv,
> > >  	newlen =3D error;
> > > =20
> > >  	if (protocol =3D=3D IPPROTO_TCP) {
> > > +		__netns_tracker_free(net, &sock->sk->ns_tracker, false);
> > > +		sock->sk->sk_net_refcnt =3D 1;
> > > +		get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
> > > +		sock_inuse_add(net, 1);
> >=20
> > This is really ugly.  These internal details of the network layer have
> > no place in sunrpc code. There must be a better way.
>=20
> I asked to do this way.  I agree this way is really ugly.  Similar
> code exists in MPTCP, SMC, CIFS, etc, so I plan to add a new API for
> this case, but this requires huge change adding a new parameter for
> ->create() prototype and the changes are not backportable.
>=20
> https://github.com/q2ven/linux/commit/bb8b8814a73b3f50c3fef5eaf8d30d8c1df43=
e7b
> https://github.com/q2ven/linux/commits/427_2
>=20
> After my series, we can use the following but cannot backport it to
> stable.
>=20
>   sock_create_net(net, family, type, protocol);
>=20
>   e.g. commit for MPTCP
>   https://github.com/q2ven/linux/commit/24a4647561272c1e67a685d8403e27eb863=
398cf
>=20
> That's why I suggested to go with the ugly way and I will clean them
> up in the next cycle.
>=20
> So, finally the sunrpc code will be much cleaner and the netns refcnt
> will be touched only in the core code.

This fact needs to be spelled out in the commit message:

   This is an ugly hack which can easily be backported to earlier
   kernels.  A proper fix which cleans up the interfaces will follow,
   but will not be so easy to backport.

or something like that.

I would still prefer if a little helper were made available so sunrpc
could just call one function rather than adding 4 cryptic lines.  But I
won't argue that too strongly.

Thanks,
NeilBrown

>=20
>=20
> >=20
> > Can we pass '0' for the kern arg to __sock_create()?  That should fix
> > the refcounting issues, but might mess up security labelling.
>=20
> This should be avoided as it's confusing for BPF programs, LSMs, and
> LOCKDEP.
>=20
>=20
> >=20
> > Can we wait for something before we call put_net() to release the net.
> >=20
> > Maybe we want to split the "kern" arg t __sock_create() and have
> > "kern" which affects labeling and "refnet" with affects refcounting the
> > net.
>=20
> This is exactly what my series does, but again, it's not backport
> friendly.
> https://github.com/q2ven/linux/commit/413e867b4aee9e9f60f3c33fb38d2004aeb29=
c40
>=20
>=20
> >=20
> > I had a quick look and very nearly every caller of __sock_create()
> > outside of net/core really does want refcount.  Many callers of
> > sock_create_kern() possibly don't.
>=20
> Actually, since sock_create_kern() is added, we no longer need to
> export __sock_create(), so I have a patch to convert them to
> sock_create_kern().
>=20
> And most of TCP socket does need refcnt, but non-TCP won't.
> Also, handshake one is exception, which uses TCP but only in init_net,
> where we need not take care of netns refcnt.
>=20
> https://github.com/q2ven/linux/commit/b56888bbbf327d57ea25a6b97275d6b9b8ad0=
43a
>=20
>=20
>=20
> >=20
> > So I really think this needs to be cleaned up in net/core, not in all
> > the different network clients in the kernel.
>=20
> Yes, will be done in the next cycle.
>=20


