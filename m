Return-Path: <linux-nfs+bounces-8502-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 638C29EB0CA
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 13:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E45188C22A
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 12:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C6B1A2846;
	Tue, 10 Dec 2024 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYlGvb59"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FCA1A0B13
	for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733833763; cv=none; b=alI7Cuz/ku2s9V6BYBjYqe9eysrEtkmaKDtZ7nckvfar3+duPWzFUGATgEpfBs5HUJNYuKixBvg4Y72NrYp64uZay/9TKRX9euE3oRm0DIZkMyGiREjGW2miGVNHwsiFMfdNk4YjpiO8/MOjNXOUEY2I8xThfE6U2oAofnQhn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733833763; c=relaxed/simple;
	bh=RWY9ZEWOp3oR2vtwAUiYbbQagFhwVDzJC/w5DJ/1RCY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GnE0h1dBgUocLStDYMvmQoG0JgbNBMrV9QYDkWpqU67qeLW3Zc78wEqCcZ9mc4Lha7KEIfwvTNoFHg94iP5AMyZAD/0cMVjqy7HB+V+hnwzlTLv50bo0WWQ2Rp1URNbUi3CDaP625a0lBUeowZw7wQjYrZFqDr8aAcepGV9JdTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYlGvb59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E6BC4CED6;
	Tue, 10 Dec 2024 12:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733833763;
	bh=RWY9ZEWOp3oR2vtwAUiYbbQagFhwVDzJC/w5DJ/1RCY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=oYlGvb59ANxUS0e+p5sSJ9uplhO625fNgHREl5vpDCTqG8oWDg98b+BwgszbVWhNO
	 lybXw4CD0yxndsHfNedcj4+d5sb2txtxumXeVoSG4bgnm4ptBN191x46GuMvZRPlEN
	 D7oJSMQS/R/m0CcvG2+RulX6vxXn5B4y4H6QVdyGZZfOYZksFrmDsTUyYMEd+Q+C3U
	 VWDLwIbXXMNiz7i5hqD0w54dfHo8v6+hyYMugrYdxNm9TB+ZzMxjnPZW/PKMDXz5IG
	 y8+/pU5J184cjUVgIP43b3qogHLvSUezKXoSZNdVtziB7MJ+IuQmnAM0mwd7IG+o+J
	 Vb1DZItpSzlkQ==
Message-ID: <c152bd8f69185a3c1efd7b22a748f890049ad02c.camel@kernel.org>
Subject: Re: [PATCH 2/2] sunrpc: remove all connection limit configuration
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date: Tue, 10 Dec 2024 07:29:21 -0500
In-Reply-To: <6803341d-5071-46f2-971a-b1699572d833@oracle.com>
References: <20241209004310.728309-1-neilb@suse.de>
	 <20241209004310.728309-3-neilb@suse.de>
	 <6803341d-5071-46f2-971a-b1699572d833@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-09 at 12:27 -0500, Chuck Lever wrote:
> On 12/8/24 7:41 PM, NeilBrown wrote:
> > Now that the connection limit only apply to unconfirmed connections,
> > there is no need to configure it.  So remove all the configuration and
> > fix the number of unconfirmed connections as always 64 - which is
> > now given a name: XPT_MAX_TMP_CONN
> >=20
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >   fs/lockd/svc.c                  |  8 -------
> >   fs/nfsd/netns.h                 |  6 -----
> >   fs/nfsd/nfsctl.c                | 42 --------------------------------=
-
> >   fs/nfsd/nfssvc.c                |  5 ----
> >   include/linux/sunrpc/svc.h      |  4 ----
> >   include/linux/sunrpc/svc_xprt.h |  6 +++++
> >   net/sunrpc/svc_xprt.c           |  8 +------
> >   7 files changed, 7 insertions(+), 72 deletions(-)
> >=20
> > diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> > index 4ec22c2f2ea3..7ded57ec3a60 100644
> > --- a/fs/lockd/svc.c
> > +++ b/fs/lockd/svc.c
> > @@ -70,9 +70,6 @@ static unsigned long		nlm_grace_period;
> >   unsigned long			nlm_timeout =3D LOCKD_DFLT_TIMEO;
> >   static int			nlm_udpport, nlm_tcpport;
> >  =20
> > -/* RLIM_NOFILE defaults to 1024. That seems like a reasonable default =
here. */
> > -static unsigned int		nlm_max_connections =3D 1024;
> > -
> >   /*
> >    * Constants needed for the sysctl interface.
> >    */
> > @@ -136,9 +133,6 @@ lockd(void *vrqstp)
> >   	 * NFS mount or NFS daemon has gone away.
> >   	 */
> >   	while (!svc_thread_should_stop(rqstp)) {
> > -		/* update sv_maxconn if it has changed */
> > -		rqstp->rq_server->sv_maxconn =3D nlm_max_connections;
> > -
> >   		nlmsvc_retry_blocked(rqstp);
> >   		svc_recv(rqstp);
> >   	}
> > @@ -340,7 +334,6 @@ static int lockd_get(void)
> >   		return -ENOMEM;
> >   	}
> >  =20
> > -	serv->sv_maxconn =3D nlm_max_connections;
> >   	error =3D svc_set_num_threads(serv, NULL, 1);
> >   	if (error < 0) {
> >   		svc_destroy(&serv);
> > @@ -542,7 +535,6 @@ module_param_call(nlm_udpport, param_set_port, para=
m_get_int,
> >   module_param_call(nlm_tcpport, param_set_port, param_get_int,
> >   		  &nlm_tcpport, 0644);
> >   module_param(nsm_use_hostnames, bool, 0644);
> > -module_param(nlm_max_connections, uint, 0644);
>=20
> We've discussed deprecation and removal of items from /proc/fs/nfsd
> before, but removing a module parameter seems like it needs to be
> handled with the usual deprecation schedule?
>=20

Yeah, that could break someone on an upgrade. What we should probably
do is keep the knob around, but just make it not do anything now, and
throw a pr_warn message or something if someone tries to set it.
Eventually in a year or two, we should be able to remove it.


> >   static int lockd_init_net(struct net *net)
> >   {
> > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > index a05a45bb1978..4a07b8d0837b 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -128,12 +128,6 @@ struct nfsd_net {
> >   	seqlock_t writeverf_lock;
> >   	unsigned char writeverf[8];
> >  =20
> > -	/*
> > -	 * Max number of non-validated connections this nfsd container
> > -	 * will allow.  Defaults to '0' gets mapped to 64.
> > -	 */
> > -	unsigned int max_connections;
> > -
> >   	u32 clientid_base;
> >   	u32 clientid_counter;
> >   	u32 clverifier_counter;
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 3adbc05ebaac..95ea4393305b 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -48,7 +48,6 @@ enum {
> >   	NFSD_Versions,
> >   	NFSD_Ports,
> >   	NFSD_MaxBlkSize,
> > -	NFSD_MaxConnections,
> >   	NFSD_Filecache,
> >   	NFSD_Leasetime,
> >   	NFSD_Gracetime,
> > @@ -68,7 +67,6 @@ static ssize_t write_pool_threads(struct file *file, =
char *buf, size_t size);
> >   static ssize_t write_versions(struct file *file, char *buf, size_t si=
ze);
> >   static ssize_t write_ports(struct file *file, char *buf, size_t size)=
;
> >   static ssize_t write_maxblksize(struct file *file, char *buf, size_t =
size);
> > -static ssize_t write_maxconn(struct file *file, char *buf, size_t size=
);
> >   #ifdef CONFIG_NFSD_V4
> >   static ssize_t write_leasetime(struct file *file, char *buf, size_t s=
ize);
> >   static ssize_t write_gracetime(struct file *file, char *buf, size_t s=
ize);
> > @@ -87,7 +85,6 @@ static ssize_t (*const write_op[])(struct file *, cha=
r *, size_t) =3D {
> >   	[NFSD_Versions] =3D write_versions,
> >   	[NFSD_Ports] =3D write_ports,
> >   	[NFSD_MaxBlkSize] =3D write_maxblksize,
> > -	[NFSD_MaxConnections] =3D write_maxconn,
> >   #ifdef CONFIG_NFSD_V4
> >   	[NFSD_Leasetime] =3D write_leasetime,
> >   	[NFSD_Gracetime] =3D write_gracetime,
> > @@ -902,44 +899,6 @@ static ssize_t write_maxblksize(struct file *file,=
 char *buf, size_t size)
> >   							nfsd_max_blksize);
> >   }
> >  =20
> > -/*
> > - * write_maxconn - Set or report the current max number of connections
> > - *
> > - * Input:
> > - *			buf:		ignored
> > - *			size:		zero
> > - * OR
> > - *
> > - * Input:
> > - *			buf:		C string containing an unsigned
> > - *					integer value representing the new
> > - *					number of max connections
> > - *			size:		non-zero length of C string in @buf
> > - * Output:
> > - *	On success:	passed-in buffer filled with '\n'-terminated C string
> > - *			containing numeric value of max_connections setting
> > - *			for this net namespace;
> > - *			return code is the size in bytes of the string
> > - *	On error:	return code is zero or a negative errno value
> > - */
> > -static ssize_t write_maxconn(struct file *file, char *buf, size_t size=
)
> > -{
> > -	char *mesg =3D buf;
> > -	struct nfsd_net *nn =3D net_generic(netns(file), nfsd_net_id);
> > -	unsigned int maxconn =3D nn->max_connections;
> > -
> > -	if (size > 0) {
> > -		int rv =3D get_uint(&mesg, &maxconn);
> > -
> > -		if (rv)
> > -			return rv;
> > -		trace_nfsd_ctl_maxconn(netns(file), maxconn);
> > -		nn->max_connections =3D maxconn;
> > -	}
> > -
> > -	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", maxconn);
> > -}
> > -
> >   #ifdef CONFIG_NFSD_V4
> >   static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_=
t size,
> >   				  time64_t *time, struct nfsd_net *nn)
> > @@ -1372,7 +1331,6 @@ static int nfsd_fill_super(struct super_block *sb=
, struct fs_context *fc)
> >   		[NFSD_Versions] =3D {"versions", &transaction_ops, S_IWUSR|S_IRUSR}=
,
> >   		[NFSD_Ports] =3D {"portlist", &transaction_ops, S_IWUSR|S_IRUGO},
> >   		[NFSD_MaxBlkSize] =3D {"max_block_size", &transaction_ops, S_IWUSR|=
S_IRUGO},
> > -		[NFSD_MaxConnections] =3D {"max_connections", &transaction_ops, S_IW=
USR|S_IRUGO},
> >   		[NFSD_Filecache] =3D {"filecache", &nfsd_file_cache_stats_fops, S_I=
RUGO},
> >   #ifdef CONFIG_NFSD_V4
> >   		[NFSD_Leasetime] =3D {"nfsv4leasetime", &transaction_ops, S_IWUSR|S=
_IRUSR},
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 49e2f32102ab..b77097de5936 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -668,7 +668,6 @@ int nfsd_create_serv(struct net *net)
> >   	if (serv =3D=3D NULL)
> >   		return -ENOMEM;
> >  =20
> > -	serv->sv_maxconn =3D nn->max_connections;
> >   	error =3D svc_bind(serv, net);
> >   	if (error < 0) {
> >   		svc_destroy(&serv);
> > @@ -954,11 +953,7 @@ nfsd(void *vrqstp)
> >   	 * The main request loop
> >   	 */
> >   	while (!svc_thread_should_stop(rqstp)) {
> > -		/* Update sv_maxconn if it has changed */
> > -		rqstp->rq_server->sv_maxconn =3D nn->max_connections;
> > -
> >   		svc_recv(rqstp);
> > -
> >   		nfsd_file_net_dispose(nn);
> >   	}
> >  =20
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index 617ebfff2f30..9d288a673705 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -72,10 +72,6 @@ struct svc_serv {
> >   	spinlock_t		sv_lock;
> >   	unsigned int		sv_nprogs;	/* Number of sv_programs */
> >   	unsigned int		sv_nrthreads;	/* # of server threads */
> > -	unsigned int		sv_maxconn;	/* max connections allowed or
> > -						 * '0' causing max to be based
> > -						 * on number of threads. */
> > -
> >   	unsigned int		sv_max_payload;	/* datagram payload size */
> >   	unsigned int		sv_max_mesg;	/* max_payload + 1 page for overheads */
> >   	unsigned int		sv_xdrsize;	/* XDR buffer size */
> > diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc=
_xprt.h
> > index 35929a7727c7..114051ad985a 100644
> > --- a/include/linux/sunrpc/svc_xprt.h
> > +++ b/include/linux/sunrpc/svc_xprt.h
> > @@ -105,6 +105,12 @@ enum {
> >   				 */
> >   };
> >  =20
> > +/*
> > + * Maximum number of "tmp" connections - those without XPT_PEER_VALID =
-
> > + * permitted on any service.
> > + */
> > +#define XPT_MAX_TMP_CONN	64
> > +
> >   static inline void svc_xprt_set_valid(struct svc_xprt *xpt)
> >   {
> >   	if (test_bit(XPT_TEMP, &xpt->xpt_flags) &&
> > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > index ff5b8bb8a88f..070bdeb50496 100644
> > --- a/net/sunrpc/svc_xprt.c
> > +++ b/net/sunrpc/svc_xprt.c
> > @@ -619,16 +619,10 @@ int svc_port_is_privileged(struct sockaddr *sin)
> >    * The only somewhat efficient mechanism would be if drop old
> >    * connections from the same IP first. But right now we don't even
> >    * record the client IP in svc_sock.
> > - *
> > - * single-threaded services that expect a lot of clients will probably
> > - * need to set sv_maxconn to override the default value which is based
> > - * on the number of threads
> >    */
> >   static void svc_check_conn_limits(struct svc_serv *serv)
> >   {
> > -	unsigned int limit =3D serv->sv_maxconn ? serv->sv_maxconn : 64;
> > -
> > -	if (serv->sv_tmpcnt > limit) {
> > +	if (serv->sv_tmpcnt > XPT_MAX_TMP_CONN) {
> >   		struct svc_xprt *xprt =3D NULL, *xprti;
> >   		spin_lock_bh(&serv->sv_lock);
> >   		if (!list_empty(&serv->sv_tempsocks)) {
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

