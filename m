Return-Path: <linux-nfs+bounces-22245-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bQUiOu5wIGoR3gAAu9opvQ
	(envelope-from <linux-nfs+bounces-22245-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 20:22:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A65E63A840
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 20:22:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bWdlqPYv;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22245-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22245-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3592E300515E
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 18:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6333F1673;
	Wed,  3 Jun 2026 18:21:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831063E4C98;
	Wed,  3 Jun 2026 18:21:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510865; cv=none; b=ag40N+M6UUVfY6DjnDI7txH1leMamekZakVRSS38lvfqE76VbclWrObwgIQiEegGSjny6Ohlw2he7U9y6xtg4uH4juKDz6R+7C+ja84OJ0CbP1L6hfaFISILLQD3peuZMHRFbNSr7txMFPpko4krDh0OxoD92u1wOmtQQDo7BZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510865; c=relaxed/simple;
	bh=nfKN3c0YEtecX8jr2QSCf5hcXjb/0TozwizsEuf0a9c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=B3PxdrEztMmxUnZkCjefTcM/G4Is/qSfSXtDGmjyx6hebjpL1341PpJkFrtZa/I6wZwEsKVD40f8RQD6Od1YY6CqV7jOWOvNpsyyVSdnQX7ssFplxk0hnWWrPAVhX2JJSSrxnw+dxXIOhk8VqjM3dRH4Vu3hA4RInLutBgNJgyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWdlqPYv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578FD1F00898;
	Wed,  3 Jun 2026 18:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780510861;
	bh=K6JcxvnSKG/tM4cNqQK5jfhnLiDr61zsN0ZBnJHt6ZE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=bWdlqPYvWNvm+TotL4IauF1BL267CVW8iiph6X/pq6XUZIZAFeC5MOsH6THvB+ZwZ
	 2036WvLID+OI0iE55UkboPFeabF8KMUp2mxii63wjcEUvsfcQIQVJLTzkTZjC9SavB
	 TxTMhfBSJpZo9/JuScDP6U8I8qoNvPDZx7ia5fcHmZbshqM6kxk5dUfrTs/LcW316A
	 mSqB3hDWqTlGkttOODGB+8QnzZAvxLmCA/KbAVTT3REsnK3Dsx9zgHiV5dAYS9/6Hg
	 fgXDf3ZMMqoflTwHaB1v9m04C/kXvxlVean2SvPrAhBCNYXracFpwcECVbt+FBxw7v
	 pYwXxZM5VEKvw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4B112F4006D;
	Wed,  3 Jun 2026 14:20:59 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 03 Jun 2026 14:20:59 -0400
X-ME-Sender: <xms:i3AgarRhdfG2fwKi28IMwT7IavPYuRVsPlJOsNSAmx0eG98_mwrwHg>
    <xme:i3AganklQUo8gsUi4LboTH4yOqANHbYH4Bgd9ddOZZR_F2XiUxKlh1D1s5HunFdrS
    6TC3jKRatE0tQgnRou7F5WgIfbmD5yvUuziZ5GHa1k5BKYO7887vMn1>
X-ME-Proxy-Cause: dmFkZTEOGYun0mj1E3fk2MPqfEWNxCunbRbsKHf9A6ll5bLDs9/hEgn4WCpr1gmajvnCDx
    mLT7p0SExi8wKYSFqJkaqMXldoW1l8T96GslX7yVHNDTiN5SsEyvexptHJQXsaUGsja25V
    +8mP47htqDOO7BRqY7MvdUNOR1lDdZLijIlHiyDS+0du1gn8U1Oo0F5VGzFJBi+UKU7Uy/
    q5txjGKa5MQWFNS/8BRWsJgFWJWRAej5ufaqIOsSSqMsyEPRzxfxXi5bq6HyBQv/k7jzH7
    tMqKaKaxy1DaO2lw8ioj4BQ+6kExofTa+UKpNFTEay2h+zWcabQ5lXDtxQlDlyTR3At+JO
    Qs/JOrCX5UHC64zL+JaC2QE9y5ip6I2OTOm58TusPLcND48YkVsSZKOZ7lMUw4hUl5iMrp
    m7MdDGgFz3cvZpQ9TRe+dX4m/xdMnzBZEuk/6/KXh9BAmwvENu5kiNB29SSNsgntP9pZpc
    9/RlWafX6/vceHrCrveBq5Ld8hNrpDG2mMsD2uCYT2Ds0Qazi76IkBN1SxIdSFRCHnbk3D
    9KZUJUVyfYqnOqUy3HmP5ufIU7tAI5J8oGncscOocl4Rxlv17zy/HAkgyzj0vThIiYtrH7
    IMHcYrDVSvMfDQB3WRA3GNPxsH2PwWPt4aq34VPHOVBf18WTxeRzT8L5Ob3Q
X-ME-Proxy: <xmx:i3Agas0OvinXZmyB3VQW_n2HAOeVk6j4yrhAGyebwAauqtUyqlrLzg>
    <xmx:i3AgagfHmsOABsw8vY0d8CUt32ZaHxQY9Mvw-EFPEUquiLac8dEB9g>
    <xmx:i3AgatZFKrTagyiOd4PhRsHhGdWJKf_cMZ7YB0VNK9o13U2zkgzXQA>
    <xmx:i3AgalV-PuI2PdZ7yJ2n9SrMelxqa-6oOeLFMG5-9OVTRaR0ifUhYg>
    <xmx:i3AgagQuJYX-ezfgzt47oVTj_6xm6hh70uu9mul_2Tk3NkFTNhK5RZHR>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1F522780070; Wed,  3 Jun 2026 14:20:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1VAgNH1MNFs
Date: Wed, 03 Jun 2026 11:20:37 -0700
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Lorenzo Bianconi" <lorenzo@kernel.org>,
 "Anna Schumaker" <anna.schumaker@oracle.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Mike Snitzer" <snitzer@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Chris Mason" <clm@meta.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Trond Myklebust" <trond.myklebust@hammerspace.com>
Message-Id: <0d16e520-3e78-4b2b-b624-4376a1f0e075@app.fastmail.com>
In-Reply-To: <fc86e230bf1962840c9b045680600f67378f7126.camel@kernel.org>
References: <20260602-nfsd-testing-v2-0-e4ea62e3cd5c@kernel.org>
 <20260602-nfsd-testing-v2-8-e4ea62e3cd5c@kernel.org>
 <efb19b50-6535-480d-9630-37f53a8de3cd@app.fastmail.com>
 <fc86e230bf1962840c9b045680600f67378f7126.camel@kernel.org>
Subject: Re: [PATCH v2 8/9] nfsd: hold net namespace reference for delayed-dispose
 nfsd_files
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:lorenzo@kernel.org,m:anna.schumaker@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:snitzer@kernel.org,m:viro@zeniv.linux.org.uk,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trond.myklebust@hammerspace.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22245-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A65E63A840



On Wed, Jun 3, 2026, at 10:50 AM, Jeff Layton wrote:
> On Wed, 2026-06-03 at 10:33 -0700, Chuck Lever wrote:
>>=20
>> On Tue, Jun 2, 2026, at 9:23 AM, Jeff Layton wrote:
>> > Take a net-namespace reference in nfsd_file_dispose_list_delayed()
>> > (get_net) and release it in nfsd_file_free() (put_net), so that
>> > nf_net is always valid for files that the GC or shrinker has isolat=
ed
>> > from the hash table and LRU -- which __nfsd_file_cache_purge() cann=
ot
>> > see.
>> >=20
>> > Without this, nf_net can dangle for in-flight files whose net names=
pace
>> > is torn down concurrently, causing a use-after-free when
>> > nfsd_file_dispose_list_delayed() calls net_generic(nf->nf_net, ...).
>> >=20
>> > Only files entering the delayed-dispose path need the net reference;
>> > files freed synchronously (non-GC stateful opens, purge, direct put)
>> > are always freed while the net namespace is still alive, so they sk=
ip
>> > get_net()/put_net() entirely.  A new NFSD_FILE_NET_HELD flag tracks
>> > whether a given nfsd_file holds a net reference.
>> >=20
>> > Because nfsd_file_free() may now call put_net(nf->nf_net), the old
>> > nfsd_file_put_local() pattern of returning nf->nf_net after
>> > nfsd_file_put() is unsafe -- put_net() could theoretically drop the
>> > last net namespace reference, leaving the returned pointer stale.
>> > Fix this by moving the nfsd_net_put() call into nfsd_file_put_local=
()
>> > itself, before the nfsd_file_put() that may trigger nfsd_file_free(=
).
>> > The function now returns void and the caller no longer needs to han=
dle
>> > the net reference.
>> >=20
>> > Fixes: 43fd953fa7e2 ("nfsd: simplify the delayed disposal list code=
")
>> > Assisted-by: Claude:claude-opus-4-6
>> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> > ---
>> >  fs/nfsd/filecache.c        | 34 ++++++++++++++++++++++++++--------
>> >  fs/nfsd/filecache.h        |  3 ++-
>> >  fs/nfsd/localio.c          |  4 ++--
>> >  include/linux/nfslocalio.h |  9 ++-------
>> >  4 files changed, 32 insertions(+), 18 deletions(-)
>> >=20
>> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> > index 03f01a0beced..957fe57be063 100644
>> > --- a/fs/nfsd/filecache.c
>> > +++ b/fs/nfsd/filecache.c
>> > @@ -295,6 +295,9 @@ nfsd_file_free(struct nfsd_file *nf)
>> >  	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
>> >  		return;
>> >=20
>> > +	if (test_bit(NFSD_FILE_NET_HELD, &nf->nf_flags))
>> > +		put_net(nf->nf_net);
>> > +
>> >  	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
>> >  }
>> >=20
>> > @@ -375,24 +378,28 @@ nfsd_file_put(struct nfsd_file *nf)
>> >  }
>> >=20
>> >  /**
>> > - * nfsd_file_put_local - put nfsd_file reference and arm nfsd_net_=
put in caller
>> > + * nfsd_file_put_local - put nfsd_file reference and release nfsd_=
net ref
>> >   * @pnf: nfsd_file of which to put the reference
>> >   *
>> > - * First save the associated net to return to caller, then put
>> > - * the reference of the nfsd_file.
>> > + * Drops both the nfsd_file reference and the associated nfsd_net
>> > + * reference.  The nfsd_net ref is released before the file ref so
>> > + * that put_net() inside nfsd_file_free() cannot drop the last net
>> > + * namespace reference while the caller still needs it.
>> >   */
>> > -struct net *
>> > +void
>> >  nfsd_file_put_local(struct nfsd_file __rcu **pnf)
>> >  {
>> >  	struct nfsd_file *nf;
>> > -	struct net *net =3D NULL;
>> >=20
>> >  	nf =3D unrcu_pointer(xchg(pnf, NULL));
>> >  	if (nf) {
>> > -		net =3D nf->nf_net;
>> > +		struct net *net =3D nf->nf_net;
>> > +
>> > +		rcu_read_lock();
>> > +		nfsd_net_put(net);
>> > +		rcu_read_unlock();
>> >  		nfsd_file_put(nf);
>> >  	}
>> > -	return net;
>> >  }
>> >=20
>> >  /**
>> > @@ -433,9 +440,20 @@ nfsd_file_dispose_list_delayed(struct list_hea=
d *dispose)
>> >  	while (!list_empty(dispose)) {
>> >  		struct nfsd_file *nf =3D list_first_entry(dispose,
>> >  						struct nfsd_file, nf_gc);
>> > -		struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
>> > +		struct nfsd_net *nn;
>> >  		struct svc_serv *serv;
>> >=20
>> > +		/*
>> > +		 * Pin the net namespace so nf_net stays valid while the
>> > +		 * file sits on the per-net dispose list.  Callers (the GC
>> > +		 * worker, shrinker, and fsnotify callbacks) always run
>> > +		 * before nfsd_net_exit(), so nf_net is still live here.
>> > +		 * The matching put_net() is in nfsd_file_free().
>> > +		 */
>> > +		get_net(nf->nf_net);
>> > +		set_bit(NFSD_FILE_NET_HELD, &nf->nf_flags);
>> > +
>> > +		nn =3D net_generic(nf->nf_net, nfsd_net_id);
>> >  		spin_lock(&nn->fcache_dispose_lock);
>> >  		list_move_tail(&nf->nf_gc, &nn->fcache_dispose_list);
>> >  		spin_unlock(&nn->fcache_dispose_lock);
>> > diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
>> > index 683b6437cacc..7ae3c0ea0a2a 100644
>> > --- a/fs/nfsd/filecache.h
>> > +++ b/fs/nfsd/filecache.h
>> > @@ -45,6 +45,7 @@ struct nfsd_file {
>> >  #define NFSD_FILE_REFERENCED	(2)
>> >  #define NFSD_FILE_GC		(3)
>> >  #define NFSD_FILE_RECENT	(4)
>> > +#define NFSD_FILE_NET_HELD	(5)
>> >  	unsigned long		nf_flags;
>> >  	refcount_t		nf_ref;
>> >  	unsigned char		nf_may;
>> > @@ -66,7 +67,7 @@ void nfsd_file_cache_shutdown(void);
>> >  int nfsd_file_cache_start_net(struct net *net);
>> >  void nfsd_file_cache_shutdown_net(struct net *net);
>> >  void nfsd_file_put(struct nfsd_file *nf);
>> > -struct net *nfsd_file_put_local(struct nfsd_file __rcu **nf);
>> > +void nfsd_file_put_local(struct nfsd_file __rcu **nf);
>> >  struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
>> >  struct file *nfsd_file_file(struct nfsd_file *nf);
>> >  void nfsd_file_close_inode_sync(struct inode *inode);
>> > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
>> > index c3eb0557b3e1..e3295bae75a4 100644
>> > --- a/fs/nfsd/localio.c
>> > +++ b/fs/nfsd/localio.c
>> > @@ -40,8 +40,8 @@
>> >   * avoid all the NFS overhead with reads, writes and commits.
>> >   *
>> >   * On successful return, returned nfsd_file will have its nf_net m=
ember
>> > - * set. Caller (NFS client) is responsible for calling nfsd_net_pu=
t and
>> > - * nfsd_file_put (via nfs_to_nfsd_file_put_local).
>> > + * set. Caller (NFS client) is responsible for calling nfsd_file_p=
ut
>> > + * (via nfs_to_nfsd_file_put_local), which also releases the nfsd_=
net=20
>> > ref.
>> >   */
>> >  static struct nfsd_file *
>> >  nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
>> > diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
>> > index 3d91043254e6..7267a69092d1 100644
>> > --- a/include/linux/nfslocalio.h
>> > +++ b/include/linux/nfslocalio.h
>> > @@ -62,7 +62,7 @@ struct nfsd_localio_operations {
>> >  						const struct nfs_fh *,
>> >  						struct nfsd_file __rcu **pnf,
>> >  						const fmode_t);
>> > -	struct net *(*nfsd_file_put_local)(struct nfsd_file __rcu **);
>> > +	void (*nfsd_file_put_local)(struct nfsd_file __rcu **);
>> >  	struct file *(*nfsd_file_file)(struct nfsd_file *);
>> >  	void (*nfsd_file_dio_alignment)(struct nfsd_file *,
>> >  					u32 *, u32 *, u32 *);
>> > @@ -96,12 +96,7 @@ static inline void nfs_to_nfsd_file_put_local(st=
ruct=20
>> > nfsd_file __rcu **localio)
>> >  	 * must prevent nfsd shutdown from completing as nfs_close_local_=
fh()
>> >  	 * does by blocking the nfs_uuid from being finally put.
>> >  	 */
>> > -	struct net *net;
>> > -
>> > -	net =3D nfs_to->nfsd_file_put_local(localio);
>> > -
>> > -	if (net)
>> > -		nfs_to_nfsd_net_put(net);
>> > +	nfs_to->nfsd_file_put_local(localio);
>> >  }
>> >=20
>> >  #else   /* CONFIG_NFS_LOCALIO */
>> >=20
>> > --=20
>> > 2.54.0
>>=20
>> It seems that all of the LLM reviewers have difficulty with this patc=
h.
>> This is a consolidated review of the issue from Claude and Codex:
>>=20
>> > The reordering in nfsd_file_put_local() -- nfsd_net_put() before
>> > nfsd_file_put() -- introduces a shutdown race.
>> >=20
>> > The nfsd_net_ref percpu refcount is taken only by LOCALIO
>> > (nfsd_open_local_fh() and nfs_open_local_fh()). The drain wait in
>> > nfsd_shutdown_net() (wait_for_completion(&nn->nfsd_net_free_done))
>> > is what holds off percpu_ref_exit() and nfsd_shutdown_generic() --
>> > and through the latter, nfsd_file_cache_shutdown(), which runs
>> > rcu_barrier() and then destroys nfsd_file_slab, nfsd_file_mark_slab,
>> > the fsnotify groups, and the rhltable.
>> >=20
>> > Per-I/O references are not covered by the nfs_uuid handshake. Each
>> > pgio call takes its own nfsd_file ref plus a paired nfsd_net ref
>> > (fs/nfs/pagelist.c, nfs_local_open_fh), stores it in iocb->localio,
>> > and releases it at completion through nfsd_file_put_local(). An
>> > iocb is not on nfs_uuid->files, so nfs_localio_invalidate_clients()
>> > does not wait for it; only the drain wait does. Meanwhile
>> > __nfsd_file_cache_purge() has already unhashed the nfsd_file but
>> > cannot free it (the iocb ref keeps refcount elevated in
>> > nfsd_file_cond_queue()).
>> >=20
>> > So with one I/O in flight when the server is stopped: the shutdown
>> > thread parks at the drain wait; the I/O completion thread enters
>> > nfsd_file_put_local() and drops the last nfsd_net ref, which runs
>> > complete() before nfsd_file_put() has executed. The shutdown thread
>> > then proceeds through nfsd_file_cache_shutdown() concurrently with
>> > the final nfsd_file_free(): the call_rcu() is queued after the
>> > rcu_barrier(), so nfsd_file_slab_free() does kmem_cache_free() into
>> > a destroyed cache, and nfsd_file_mark_put() runs against a destroyed
>> > fsnotify group. kmem_cache_destroy() also fires "objects remaining"
>> > because the nfsd_file is still allocated.
>> >=20
>> > The old ordering was the mechanism that prevented this: the caller
>> > held its paired nfsd_net ref across nfsd_file_put(), and percpu_ref
>> > guarantees the release callback runs only after every ref is
>> > dropped, so global teardown strictly followed the file free and the
>> > rcu_barrier() flushed its call_rcu().
>> >=20
>> > The hazard the commit message cites for the reorder cannot occur on
>> > this path: NFSD_FILE_NET_HELD is set only in
>> > nfsd_file_dispose_list_delayed(), reachable only through
>> > refcount_dec_if_one() in nfsd_file_lru_cb(), i.e. at refcount =3D=3D=
 1.
>> > A file with an outstanding LOCALIO reference has refcount >=3D 2, so
>> > a file whose final put arrives via nfsd_file_put_local() never has
>> > NET_HELD set and its nfsd_file_free() never calls put_net().
>> >=20
>> > Suggest keeping the void API but restoring the put order:
>> >=20
>> >       nf =3D unrcu_pointer(xchg(pnf, NULL));
>> >       if (nf) {
>> >               struct net *net =3D nf->nf_net;
>> >=20
>> >               nfsd_file_put(nf);
>> >               rcu_read_lock();
>> >               nfsd_net_put(net);
>> >               rcu_read_unlock();
>> >       }
>> >=20
>> > with the kdoc comment and the commit message paragraph about the
>> > old ordering being unsafe adjusted to match.
>>=20
>
>
> I had claude review this and it says:
>
> =E2=97=8F This is the same concern I just addressed for the previous p=
atch's=20
> Finding 3, restated as a
>   critical bug. The answer is the same: this is a false positive.
>
>   The reviewer's scenario requires:
>
>   1. The global shrinker unhashes and isolates an nfsd_file onto a=20
> local dispose list
>   2. The net namespace teardown completes and struct net is freed
>   3. The shrinker resumes and calls get_net() on freed memory

That rebuttal answers a different finding. The three-step scenario it
refutes is the one sashiko raised against the get_net() placement in
nfsd_file_dispose_list_delayed(). The review quoted above is about
the put order in nfsd_file_put_local() and does not involve struct
net's refcount at any step. Two new issues appear with 8/9:

1. Put order in nfsd_file_put_local()
 =20
The question is narrow: after an I/O completion thread executes
nfsd_net_put() -- dropping the last nfsd_net_ref and running
complete(&nn->nfsd_net_free_done) -- what prevents nfsd_shutdown_net()
from continuing through percpu_ref_exit() and nfsd_shutdown_generic()
into nfsd_file_cache_shutdown() before that same thread executes the
nfsd_file_put() on the next line?

In the current code the answer is the ref itself: the caller holds it
across nfsd_file_put(), and percpu_ref runs the release callback only
after every ref drops, so global teardown strictly follows the file
free and the rcu_barrier() in nfsd_file_cache_shutdown() flushes the
call_rcu() that nfsd_file_free() queued. The patch removes that
ordering and installs nothing in its place.

The nfs_uuid handshake does not cover this path: each pgio holds its
own nfsd_file + nfsd_net ref pair (fs/nfs/pagelist.c, stored in
iocb->localio), released at I/O completion through
nfsd_file_put_local(), and an iocb is not on nfs_uuid->files. The
purge has already unhashed the file but cannot free it
(nfsd_file_cond_queue() sees the elevated refcount), so the
completion thread's put is the final one and its nfsd_file_free()
races kmem_cache_destroy(nfsd_file_slab).

The stale-net hazard the commit message cites cannot occur on this
path: NFSD_FILE_NET_HELD is set only via refcount_dec_if_one() in
nfsd_file_lru_cb(), i.e. at refcount =3D=3D 1, and a file with an
outstanding LOCALIO reference has refcount >=3D 2. So the fix is to
keep the void API but put the file ref first, then the net ref.

2. get_net() placement in nfsd_file_dispose_list_delayed()

The rebuttal's struct-net argument does not hold for the files in
question: they are no longer on the LRU (nfsd_file_lru_cb() unhashed
and isolated them onto the worker's private list), and an nfsd_file
holds no net reference -- that absence is what this patch is fixing.

The commit message itself states the premise: the purge cannot see
these files and nf_net can dangle. With a second nfsd-serving netns
keeping nfsd_users > 0, nothing quiesces the shrinker or the
laundrette during per-net teardown (cancel_delayed_work_sync() and
shrinker_free() run only in global shutdown).

A worker preempted between isolating a file and calling
dispose_list_delayed() can resume after cleanup_net() has freed the
namespace, at which point get_net(nf->nf_net), net_generic(), and
the fcache_dispose_lock all touch freed memory. The get_net() sits
at the consuming end of the window it is meant to close. v1 took
the reference in nfsd_file_alloc(), the one place guaranteed to run
while the net is alive; the v2 plan of taking it at alloc time for
GC-capable files only would address Al's cacheline concern without
reopening the window.


As a process note, I'll note that I haven't found any non-pre-
existing issues with the other patches on this series.


--=20
Chuck Lever

