Return-Path: <linux-nfs+bounces-4941-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA1C931E82
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 03:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29822B21B53
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 01:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0479629A0;
	Tue, 16 Jul 2024 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="odaxx5Y6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m+rOQDLV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HS1Ohs22";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0mRa1X2y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F2B17C2
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jul 2024 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721093630; cv=none; b=cwI3vJCHe9XcEAF86OkGwyXdJz/SqGGdzaLAjW+SMujzRnIISCbG48ZWoiKYUwL60h4++VxZK460uQot/eIgl2pjWdibmqkpjvcM5h03E9NDOxO8lAs4YhiG1hDF2vx44ATwg4j2yKotuuNMql6aWctaAtqfDvCVvvY0jz36wGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721093630; c=relaxed/simple;
	bh=4rSSH7ZYlFBCCMaOMKZT6Mi8Dbl/dIrb/ps1Aex2SIw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=mTpu4tpDe5iiYMcGM+3bksd6G0Nt3hK+olqvwCC16WNf0aYztLKo3VfcIYx3OJe7vebGXJU9bWRYf/d/xLnyxX2cP3CX8dLSa1Vnidil/THL2bHcaoXPqaAp/K3aRyze+7JFCyZfS2ETQvF9L8Z/05Jovvvnlkk/e+fGaze4bGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=odaxx5Y6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m+rOQDLV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HS1Ohs22; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0mRa1X2y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2558F1F838;
	Tue, 16 Jul 2024 01:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721093627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHDMYDUPlF3LmG2bUCmu+T9ulHsAh2IcfAtPRw22ag8=;
	b=odaxx5Y6tfqB2CIE17AmryQJ6ebo+kWQVbMzKX8xZ1tinZLjcOPw8MYz0Rh8BQSaCQ+rKg
	c3VyvY7dkzsJFiRPlywiHZK9aEq8q39eSdzf7frY6TK8H7S5UGyR46eJMs9iQU+V10uDqE
	CXvIRpURVM0k1yQHoeQILXkxXDP6w5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721093627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHDMYDUPlF3LmG2bUCmu+T9ulHsAh2IcfAtPRw22ag8=;
	b=m+rOQDLV/smqX61KjNKz6iysdJ6SsP5nN/swFuVFKkSqPTlnVkRIOpn8Lo30svG0R22qAO
	achU0U0ykK7MJnAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HS1Ohs22;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0mRa1X2y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721093626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHDMYDUPlF3LmG2bUCmu+T9ulHsAh2IcfAtPRw22ag8=;
	b=HS1Ohs226B4Y+qvrqizyfWkD7rwm/dWnsV+AOGpoMc/qHWzpun4GOYJY8iSN7+y812lEU6
	ns203t8XA6a22PqdoRsiBDNM3s18bOo79Nr+1l1a0Rjbb+lPTXBfbJZ8LmcCrRGsRDbFlF
	vunCworBeaidrLTIQCnrVgPOnVZENw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721093626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHDMYDUPlF3LmG2bUCmu+T9ulHsAh2IcfAtPRw22ag8=;
	b=0mRa1X2y6Mj1j8kjABQNbFLeNS8/yyb83uDNWsEMOjmr36bA4Y6kbzLaxbsWDnjej3BHJw
	aO7Eg2S6rF0T12Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B401A13808;
	Tue, 16 Jul 2024 01:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1jW7GffNlWbfHwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 16 Jul 2024 01:33:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Steve Dickson" <steved@redhat.com>
Subject:
 Re: [PATCH 05/14] sunrpc: change sp_nrthreads from atomic_t to unsigned int.
In-reply-to: <cf8d0e7e1ddaa4d8e1923be8274ff0679713e471.camel@kernel.org>
References: <>, <cf8d0e7e1ddaa4d8e1923be8274ff0679713e471.camel@kernel.org>
Date: Tue, 16 Jul 2024 11:33:40 +1000
Message-id: <172109362034.15471.7453960747189036602@noble.neil.brown.name>
X-Rspamd-Queue-Id: 2558F1F838
X-Spam-Flag: NO
X-Spam-Score: -0.51
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.51 / 50.00];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spamd-Bar: /

On Tue, 16 Jul 2024, Jeff Layton wrote:
> On Mon, 2024-07-15 at 17:14 +1000, NeilBrown wrote:
> > sp_nrthreads is only ever accessed under the service mutex
> > =C2=A0 nlmsvc_mutex nfs_callback_mutex nfsd_mutex
> > so these is no need for it to be an atomic_t.
> >=20
> > The fact that all code using it is single-threaded means that we can
> > simplify svc_pool_victim and remove the temporary elevation of
> > sp_nrthreads.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> > =C2=A0fs/nfsd/nfsctl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0fs/nfsd/nfssvc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0include/linux/sunrpc/svc.h |=C2=A0 4 ++--
> > =C2=A0net/sunrpc/svc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 31 +++++++++++--------------------
> > =C2=A04 files changed, 15 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 5b0f2e0d7ccf..d85b6d1fa31f 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1769,7 +1769,7 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, s=
truct genl_info *info)
> > =C2=A0			struct svc_pool *sp =3D &nn->nfsd_serv->sv_pools[i];
> > =C2=A0
> > =C2=A0			err =3D nla_put_u32(skb, NFSD_A_SERVER_THREADS,
> > -					=C2=A0 atomic_read(&sp->sp_nrthreads));
> > +					=C2=A0 sp->sp_nrthreads);
> > =C2=A0			if (err)
> > =C2=A0				goto err_unlock;
> > =C2=A0		}
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 4438cdcd4873..7377422a34df 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -641,7 +641,7 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct n=
et *net)
> > =C2=A0
> > =C2=A0	if (serv)
> > =C2=A0		for (i =3D 0; i < serv->sv_nrpools && i < n; i++)
> > -			nthreads[i] =3D atomic_read(&serv->sv_pools[i].sp_nrthreads);
> > +			nthreads[i] =3D serv->sv_pools[i].sp_nrthreads;
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index e4fa25fafa97..99e9345d829e 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -33,9 +33,9 @@
> > =C2=A0 * node traffic on multi-node NUMA NFS servers.
> > =C2=A0 */
> > =C2=A0struct svc_pool {
> > -	unsigned int		sp_id;	=C2=A0=C2=A0=C2=A0=C2=A0	/* pool id; also node id =
on NUMA */
> > +	unsigned int		sp_id;		/* pool id; also node id on NUMA */
> > =C2=A0	struct lwq		sp_xprts;	/* pending transports */
> > -	atomic_t		sp_nrthreads;	/* # of threads in pool */
> > +	unsigned int		sp_nrthreads;	/* # of threads in pool */
> > =C2=A0	struct list_head	sp_all_threads;	/* all server threads */
> > =C2=A0	struct llist_head	sp_idle_threads; /* idle server threads */
> > =C2=A0
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index 072ad115ae3d..0d8588bc693c 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -725,7 +725,7 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_=
pool *pool, int node)
> > =C2=A0	serv->sv_nrthreads +=3D 1;
> > =C2=A0	spin_unlock_bh(&serv->sv_lock);
> > =C2=A0
> > -	atomic_inc(&pool->sp_nrthreads);
> > +	pool->sp_nrthreads +=3D 1;
> > =C2=A0
> > =C2=A0	/* Protected by whatever lock the service uses when calling
> > =C2=A0	 * svc_set_num_threads()
> > @@ -780,31 +780,22 @@ svc_pool_victim(struct svc_serv *serv, struct svc_p=
ool *target_pool,
> > =C2=A0	struct svc_pool *pool;
> > =C2=A0	unsigned int i;
> > =C2=A0
> > -retry:
> > =C2=A0	pool =3D target_pool;
> > =C2=A0
> > -	if (pool !=3D NULL) {
> > -		if (atomic_inc_not_zero(&pool->sp_nrthreads))
> > -			goto found_pool;
> > -		return NULL;
> > -	} else {
> > +	if (!pool) {
> > =C2=A0		for (i =3D 0; i < serv->sv_nrpools; i++) {
> > =C2=A0			pool =3D &serv->sv_pools[--(*state) % serv->sv_nrpools];
> > -			if (atomic_inc_not_zero(&pool->sp_nrthreads))
> > -				goto found_pool;
> > +			if (pool->sp_nrthreads)
> > +				break;
> > =C2=A0		}
> > -		return NULL;
> > =C2=A0	}
> > =C2=A0
> > -found_pool:
> > -	set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
> > -	set_bit(SP_NEED_VICTIM, &pool->sp_flags);
> > -	if (!atomic_dec_and_test(&pool->sp_nrthreads))
> > +	if (pool && pool->sp_nrthreads) {
> > +		set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
> > +		set_bit(SP_NEED_VICTIM, &pool->sp_flags);
> > =C2=A0		return pool;
> > -	/* Nothing left in this pool any more */
> > -	clear_bit(SP_NEED_VICTIM, &pool->sp_flags);
> > -	clear_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
> > -	goto retry;
> > +	}
> > +	return NULL;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int
> > @@ -883,7 +874,7 @@ svc_set_num_threads(struct svc_serv *serv, struct svc=
_pool *pool, int nrservs)
> > =C2=A0	if (!pool)
> > =C2=A0		nrservs -=3D serv->sv_nrthreads;
> > =C2=A0	else
> > -		nrservs -=3D atomic_read(&pool->sp_nrthreads);
> > +		nrservs -=3D pool->sp_nrthreads;
> > =C2=A0
> > =C2=A0	if (nrservs > 0)
> > =C2=A0		return svc_start_kthreads(serv, pool, nrservs);
> > @@ -953,7 +944,7 @@ svc_exit_thread(struct svc_rqst *rqstp)
> > =C2=A0
> > =C2=A0	list_del_rcu(&rqstp->rq_all);
> > =C2=A0
> > -	atomic_dec(&pool->sp_nrthreads);
> > +	pool->sp_nrthreads -=3D 1;
> > =C2=A0
> > =C2=A0	spin_lock_bh(&serv->sv_lock);
> > =C2=A0	serv->sv_nrthreads -=3D 1;
>=20
> I don't think svc_exit_thread is called with the nfsd_mutex held, so if
> several threads were exiting at the same time, they could race here.

This is subtle and deserves explanation in the commit.
svc_exit_thread() is called in a thread *after* svc_thread_should_stop()
has returned true.  That means RQ_VICTIM is set and most likely
SP_NEED_VICTIM was set

SP_NEED_VICTIM is set in svc_pool_victim() which is called from
svc_stop_kthreads() which requires that the mutex is held.
svc_stop_kthreads() waits for SP_VICTIM_REMAINS to be cleared which is
the last thing that svc_exit_thread() does.
So when svc_exit_thread() is called, the mutex is held by some other
thread that is calling svc_set_num_threads().

This is also why the list_del_rcu() in svc_exit_thread() is safe.

The case there svc_exit_thread() is called but SP_NEED_VICTIM wasn't set
(only RQ_VICTIM) is in the ETIMEDOUT case of nfsd(), in which case
nfsd() ensures that the mutex is held.

This was why
 [PATCH 07/14] Change unshare_fs_struct() to never fail.
was needed.  If that fails in the current code, svc_exit_thread() can be
called without the mutex - which is already a theoretical problem for
the list_del_rcu().

Thanks,
NeilBrown

