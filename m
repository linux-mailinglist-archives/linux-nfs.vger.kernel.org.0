Return-Path: <linux-nfs+bounces-4944-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0810E931F38
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 05:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3F91F21C4E
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 03:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235B67EF;
	Tue, 16 Jul 2024 03:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JvDeYmnN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hEr0DLRJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IEDLrtNA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HzDgF2ld"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7399AD53
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jul 2024 03:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721100088; cv=none; b=ZHwmv8o9IJDw9UHWjiBvFE50nLBR4pQT5thkScDehxxKYnNkMZZa6jj+s/3VsvJbkYzJ+/VgmJWqjFkmucu3jy7hVEMAKWxCvJ4BOMh1zKar2WyVpGIhoRSLGIRbTOv77yll27mzbwU6chZzEwRv9HF2UUMpfpFQvgIjPSMyHPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721100088; c=relaxed/simple;
	bh=EjhXnyP6hl6bJExy6HkGua19JdkzpH1AavMr/GNJJJg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jlQy0UR+iRI72pZiVi4Mp5a6W+NhmPOqzyHd3mxiHk8LRI+Xw1ITG5d6UHUuP5Wh2tGJKkTzt+SXIyCaE2ryCCkgWjhBIlZptKpCQ4O5954HdCKinPZNo2uU5A0rzcBC2DIsc9styMQi9BPIIBBqrL8hXfIouDJGCYY2iRfbgcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JvDeYmnN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hEr0DLRJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IEDLrtNA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HzDgF2ld; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBFE31F855;
	Tue, 16 Jul 2024 03:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721100084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DuPKtzdDNRPIQR9eFsGwH+bsGpmBoCyPdVr7yBboLdI=;
	b=JvDeYmnN8J60e3x9bwIam5XUJiJ+QmeRIS6YErht0S6UaAnZ8Pf7RFDl0LEQcK9GM7O+t4
	rz5UNIDgZ9GGkqE2Ny1+pMQjaXSxn/uzOnlYq1PXU+48kJ42XZQAdmnLktCsKZ71UaQne8
	OGXfXpznjLtu5FD04LsSYRzgfZ1vQVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721100084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DuPKtzdDNRPIQR9eFsGwH+bsGpmBoCyPdVr7yBboLdI=;
	b=hEr0DLRJygISvUwtSFJ1IiQpmHVO2nL121XNl7eeIMqR43+1HxQBMh0v4Ij5Ln8OmuDl6e
	hSd61VYMyIePoTAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IEDLrtNA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HzDgF2ld
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721100083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DuPKtzdDNRPIQR9eFsGwH+bsGpmBoCyPdVr7yBboLdI=;
	b=IEDLrtNAJEVZTp98ipOHz6zAUvPKiJVHI4W9JFJvV38F26ApiO7cKVQM5xDj2SQOWT++zs
	M6sw4nxoLrvmzsTd3eK5mOq5D10gvLtlNDl6lUlM91+Z+tq2AAgob1Jx0iJV0CVUdbPefP
	kPDdJgxe0uWi+MM0N28vSZCH6DVJRtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721100083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DuPKtzdDNRPIQR9eFsGwH+bsGpmBoCyPdVr7yBboLdI=;
	b=HzDgF2ldtPPYqlfLdF33KzAYi1odX6Q4thlA3O2iHy4jgzQj8424Cb8RXRrMo4e4X1I3b2
	oVquXYvMRgrsyhAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2421A13808;
	Tue, 16 Jul 2024 03:21:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ObvLMjDnlWY2OAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 16 Jul 2024 03:21:20 +0000
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
 Re: [PATCH 13/14] nfsd: introduce concept of a maximum number of threads.
In-reply-to: <f12bdd8dde21de4473d38fada67b60ef5883e8dc.camel@kernel.org>
References: <>, <f12bdd8dde21de4473d38fada67b60ef5883e8dc.camel@kernel.org>
Date: Tue, 16 Jul 2024 13:21:13 +1000
Message-id: <172110007383.15471.14744199179662433209@noble.neil.brown.name>
X-Rspamd-Queue-Id: CBFE31F855
X-Spam-Flag: NO
X-Spam-Score: -0.51
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.51 / 50.00];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spamd-Bar: /

On Tue, 16 Jul 2024, Jeff Layton wrote:
> On Mon, 2024-07-15 at 17:14 +1000, NeilBrown wrote:
> > A future patch will allow the number of threads in each nfsd pool to
> > vary dynamically.
> > The lower bound will be the number explicit requested via
> > /proc/fs/nfsd/threads or /proc/fs/nfsd/pool_threads
> >=20
> > The upper bound can be set in each net-namespace by writing
> > /proc/fs/nfsd/max_threads.=C2=A0 This upper bound applies across all pool=
s,
> > there is no per-pool upper limit.
> >=20
> > If no upper bound is set, then one is calculated.=C2=A0 A global upper li=
mit
> > is chosen based on amount of memory.=C2=A0 This limit only affects dynamic
> > changes. Static configuration can always over-ride it.
> >=20
> > We track how many threads are configured in each net namespace, with the
> > max or the min.=C2=A0 We also track how many net namespaces have nfsd
> > configured with only a min, not a max.
> >=20
> > The difference between the calculated max and the total allocation is
> > available to be shared among those namespaces which don't have a maximum
> > configured.=C2=A0 Within a namespace, the available share is distributed
> > equally across all pools.
> >=20
> > In the common case there is one namespace and one pool.=C2=A0 A small num=
ber
> > of threads are configured as a minimum and no maximum is set.=C2=A0 In th=
is
> > case the effective maximum will be directly based on total memory.
> > Approximately 8 per gigabyte.
> >=20
>=20
>=20
> Some of this may come across as bikeshedding, but I'd probably prefer
> that this work a bit differently:
>=20
> 1/ I don't think we should enable this universally -- at least not
> initially. What I'd prefer to see is a new pool_mode for the dynamic
> threadpools (maybe call it "dynamic"). That gives us a clear opt-in
> mechanism. Later once we're convinced it's safe, we can make "dynamic"
> the default instead of "global".
>=20
> 2/ Rather than specifying a max_threads value separately, why not allow
> the old threads/pool_threads interface to set the max and just have a
> reasonable minimum setting (like the current default of 8). Since we're
> growing the threadpool dynamically, I don't see why we need to have a
> real configurable minimum.
>=20
> 3/ the dynamic pool-mode should probably be layered on top of the
> pernode pool mode. IOW, in a NUMA configuration, we should split the
> threads across NUMA nodes.

Maybe we should start by discussing the goal.  What do we want
configuration to look like when we finish?

I think we want it to be transparent.  Sysadmin does nothing, and it all
works perfectly.  Or as close to that as we can get.

So I think the "nproc" option to rpc.nfsd should eventually be ignored
except for whether it is zero or non-zero.  If it is non-zero we start 1
thread on each NUMA node and let that grow with limits imposed primarily
by memory pressure.

We should probably change

#define SVC_POOL_DEFAULT	SVC_POOL_GLOBAL

to

#define SVC_POOL_DEFAULT	SVC_POOL_AUTO

about 10 years ago, but failing that, maybe change it tomorrow?

I'm not sure how
    /proc/fs/nfsd/{threads,pool_threads}
should be handled.  Like you I don't think it is really useful to have
a configured minimum but I don't want them to be imposed as a maximum
because I want servers with the current default (of 8) to be able to
start more new threads if necessary without needing a config change.
Maybe that outcome can be delayed until rpc.nfsd is updated?

I don't really like the idea of a dynamic pool mode.  I want the pool to
*always* be dynamic.

Thanks,
NeilBrown

>=20
>=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> > =C2=A0fs/nfsd/netns.h=C2=A0 |=C2=A0 6 +++++
> > =C2=A0fs/nfsd/nfsctl.c | 45 +++++++++++++++++++++++++++++++++++
> > =C2=A0fs/nfsd/nfsd.h=C2=A0=C2=A0 |=C2=A0 4 ++++
> > =C2=A0fs/nfsd/nfssvc.c | 61 +++++++++++++++++++++++++++++++++++++++++++++=
+++
> > =C2=A0fs/nfsd/trace.h=C2=A0 | 19 +++++++++++++++
> > =C2=A05 files changed, 135 insertions(+)
> >=20
> > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > index 0d2ac15a5003..329484696a42 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -133,6 +133,12 @@ struct nfsd_net {
> > =C2=A0	 */
> > =C2=A0	unsigned int max_connections;
> > =C2=A0
> > +	/*
> > +	 * Maximum number of threads to auto-adjust up to.=C2=A0 If 0 then a
> > +	 * share of nfsd_max_threads will be used.
> > +	 */
> > +	unsigned int max_threads;
> > +
> > =C2=A0	u32 clientid_base;
> > =C2=A0	u32 clientid_counter;
> > =C2=A0	u32 clverifier_counter;
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index d85b6d1fa31f..37e9936567e9 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -48,6 +48,7 @@ enum {
> > =C2=A0	NFSD_Ports,
> > =C2=A0	NFSD_MaxBlkSize,
> > =C2=A0	NFSD_MaxConnections,
> > +	NFSD_MaxThreads,
> > =C2=A0	NFSD_Filecache,
> > =C2=A0	NFSD_Leasetime,
> > =C2=A0	NFSD_Gracetime,
> > @@ -68,6 +69,7 @@ static ssize_t write_versions(struct file *file, char *=
buf, size_t size);
> > =C2=A0static ssize_t write_ports(struct file *file, char *buf, size_t siz=
e);
> > =C2=A0static ssize_t write_maxblksize(struct file *file, char *buf, size_=
t size);
> > =C2=A0static ssize_t write_maxconn(struct file *file, char *buf, size_t s=
ize);
> > +static ssize_t write_maxthreads(struct file *file, char *buf, size_t siz=
e);
> > =C2=A0#ifdef CONFIG_NFSD_V4
> > =C2=A0static ssize_t write_leasetime(struct file *file, char *buf, size_t=
 size);
> > =C2=A0static ssize_t write_gracetime(struct file *file, char *buf, size_t=
 size);
> > @@ -87,6 +89,7 @@ static ssize_t (*const write_op[])(struct file *, char =
*, size_t) =3D {
> > =C2=A0	[NFSD_Ports] =3D write_ports,
> > =C2=A0	[NFSD_MaxBlkSize] =3D write_maxblksize,
> > =C2=A0	[NFSD_MaxConnections] =3D write_maxconn,
> > +	[NFSD_MaxThreads] =3D write_maxthreads,
> > =C2=A0#ifdef CONFIG_NFSD_V4
> > =C2=A0	[NFSD_Leasetime] =3D write_leasetime,
> > =C2=A0	[NFSD_Gracetime] =3D write_gracetime,
> > @@ -939,6 +942,47 @@ static ssize_t write_maxconn(struct file *file, char=
 *buf, size_t size)
> > =C2=A0	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", maxconn);
> > =C2=A0}
> > =C2=A0
> > +/*
> > + * write_maxthreads - Set or report the current max number threads
> > + *
> > + * Input:
> > + *			buf:		ignored
> > + *			size:		zero
> > + * OR
> > + *
> > + * Input:
> > + *			buf:		C string containing an unsigned
> > + *					integer value representing the new
> > + *					max number of threads
> > + *			size:		non-zero length of C string in @buf
> > + * Output:
> > + *	On success:	passed-in buffer filled with '\n'-terminated C string
> > + *			containing numeric value of max_threads setting
> > + *			for this net namespace;
> > + *			return code is the size in bytes of the string
> > + *	On error:	return code is zero or a negative errno value
> > + */
> > +static ssize_t write_maxthreads(struct file *file, char *buf, size_t siz=
e)
> > +{
> > +	char *mesg =3D buf;
> > +	struct nfsd_net *nn =3D net_generic(netns(file), nfsd_net_id);
> > +	unsigned int maxthreads =3D nn->max_threads;
> > +
> > +	if (size > 0) {
> > +		int rv =3D get_uint(&mesg, &maxthreads);
> > +
> > +		if (rv)
> > +			return rv;
> > +		trace_nfsd_ctl_maxthreads(netns(file), maxthreads);
> > +		mutex_lock(&nfsd_mutex);
> > +		nn->max_threads =3D maxthreads;
> > +		nfsd_update_nets();
> > +		mutex_unlock(&nfsd_mutex);
> > +	}
> > +
> > +	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", maxthreads);
> > +}
> > +
> > =C2=A0#ifdef CONFIG_NFSD_V4
> > =C2=A0static ssize_t __nfsd4_write_time(struct file *file, char *buf, siz=
e_t size,
> > =C2=A0				=C2=A0 time64_t *time, struct nfsd_net *nn)
> > @@ -1372,6 +1416,7 @@ static int nfsd_fill_super(struct super_block *sb, =
struct fs_context *fc)
> > =C2=A0		[NFSD_Ports] =3D {"portlist", &transaction_ops, S_IWUSR|S_IRUGO},
> > =C2=A0		[NFSD_MaxBlkSize] =3D {"max_block_size", &transaction_ops, S_IWUS=
R|S_IRUGO},
> > =C2=A0		[NFSD_MaxConnections] =3D {"max_connections", &transaction_ops, S=
_IWUSR|S_IRUGO},
> > +		[NFSD_MaxThreads] =3D {"max_threads", &transaction_ops, S_IWUSR|S_IRUG=
O},
> > =C2=A0		[NFSD_Filecache] =3D {"filecache", &nfsd_file_cache_stats_fops, S=
_IRUGO},
> > =C2=A0#ifdef CONFIG_NFSD_V4
> > =C2=A0		[NFSD_Leasetime] =3D {"nfsv4leasetime", &transaction_ops, S_IWUSR=
|S_IRUSR},
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index e4c643255dc9..6874c2de670b 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -156,6 +156,10 @@ int nfsd_create_serv(struct net *net);
> > =C2=A0void nfsd_destroy_serv(struct net *net);
> > =C2=A0
> > =C2=A0extern int nfsd_max_blksize;
> > +void nfsd_update_nets(void);
> > +extern unsigned int	nfsd_max_threads;
> > +extern unsigned long	nfsd_net_used;
> > +extern unsigned int	nfsd_net_cnt;
> > =C2=A0
> > =C2=A0static inline int nfsd_v4client(struct svc_rqst *rq)
> > =C2=A0{
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index b005b2e2e6ad..75d78c17756f 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -80,6 +80,21 @@ DEFINE_SPINLOCK(nfsd_drc_lock);
> > =C2=A0unsigned long	nfsd_drc_max_mem;
> > =C2=A0unsigned long	nfsd_drc_slotsize_sum;
> > =C2=A0
> > +/*
> > + * nfsd_max_threads is auto-configured based on available ram.
> > + * Each network namespace can configure a minimum number of threads
> > + * and optionally a maximum.
> > + * nfsd_net_used is the number of the max or min from each net namespace.
> > + * nfsd_new_cnt is the number of net namespaces with a configured minimum
> > + *=C2=A0=C2=A0=C2=A0 but no configured maximum.
> > + * When nfsd_max_threads exceeds nfsd_net_used, the different is divided
> > + * by nfsd_net_cnt and this number gives the excess above the configured=
 minimum
> > + * for all net namespaces without a configured maximum.
> > + */
> > +unsigned int	nfsd_max_threads;
> > +unsigned long	nfsd_net_used;
> > +unsigned int	nfsd_net_cnt;
> > +
> > =C2=A0#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> > =C2=A0static const struct svc_version *nfsd_acl_version[] =3D {
> > =C2=A0# if defined(CONFIG_NFSD_V2_ACL)
> > @@ -130,6 +145,47 @@ struct svc_program		nfsd_program =3D {
> > =C2=A0	.pg_rpcbind_set		=3D nfsd_rpcbind_set,
> > =C2=A0};
> > =C2=A0
> > +void nfsd_update_nets(void)
> > +{
> > +	struct net *net;
> > +
> > +	if (nfsd_max_threads =3D=3D 0) {
> > +		nfsd_max_threads =3D (nr_free_buffer_pages() >> 7) /
> > +			(NFSSVC_MAXBLKSIZE >> PAGE_SHIFT);
> > +	}
> > +	nfsd_net_used =3D 0;
> > +	nfsd_net_cnt =3D 0;
> > +	down_read(&net_rwsem);
> > +	for_each_net(net) {
> > +		struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > +
> > +		if (!nn->nfsd_serv)
> > +			continue;
> > +		if (nn->max_threads > 0) {
> > +			nfsd_net_used +=3D nn->max_threads;
> > +		} else {
> > +			nfsd_net_used +=3D nn->nfsd_serv->sv_nrthreads;
> > +			nfsd_net_cnt +=3D 1;
> > +		}
> > +	}
> > +	up_read(&net_rwsem);
> > +}
> > +
> > +static inline int nfsd_max_pool_threads(struct svc_pool *p, struct nfsd_=
net *nn)
> > +{
> > +	int svthreads =3D nn->nfsd_serv->sv_nrthreads;
> > +
> > +	if (nn->max_threads > 0)
> > +		return nn->max_threads;
> > +	if (nfsd_net_cnt =3D=3D 0 || svthreads =3D=3D 0)
> > +		return 0;
> > +	if (nfsd_max_threads < nfsd_net_cnt)
> > +		return p->sp_nrthreads;
> > +	/* Share nfsd_max_threads among all net, then among pools in this net. =
*/
> > +	return p->sp_nrthreads +
> > +		nfsd_max_threads / nfsd_net_cnt * p->sp_nrthreads / svthreads;
> > +}
> > +
> > =C2=A0bool nfsd_support_version(int vers)
> > =C2=A0{
> > =C2=A0	if (vers >=3D NFSD_MINVERS && vers <=3D NFSD_MAXVERS)
> > @@ -474,6 +530,7 @@ void nfsd_destroy_serv(struct net *net)
> > =C2=A0	spin_lock(&nfsd_notifier_lock);
> > =C2=A0	nn->nfsd_serv =3D NULL;
> > =C2=A0	spin_unlock(&nfsd_notifier_lock);
> > +	nfsd_update_nets();
> > =C2=A0
> > =C2=A0	/* check if the notifier still has clients */
> > =C2=A0	if (atomic_dec_return(&nfsd_notifier_refcount) =3D=3D 0) {
> > @@ -614,6 +671,8 @@ int nfsd_create_serv(struct net *net)
> > =C2=A0	nn->nfsd_serv =3D serv;
> > =C2=A0	spin_unlock(&nfsd_notifier_lock);
> > =C2=A0
> > +	nfsd_update_nets();
> > +
> > =C2=A0	set_max_drc();
> > =C2=A0	/* check if the notifier is already set */
> > =C2=A0	if (atomic_inc_return(&nfsd_notifier_refcount) =3D=3D 1) {
> > @@ -720,6 +779,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct n=
et *net)
> > =C2=A0			goto out;
> > =C2=A0	}
> > =C2=A0out:
> > +	nfsd_update_nets();
> > =C2=A0	return err;
> > =C2=A0}
> > =C2=A0
> > @@ -759,6 +819,7 @@ nfsd_svc(int n, int *nthreads, struct net *net, const=
 struct cred *cred, const c
> > =C2=A0	error =3D nfsd_set_nrthreads(n, nthreads, net);
> > =C2=A0	if (error)
> > =C2=A0		goto out_put;
> > +	nfsd_update_nets();
> > =C2=A0	error =3D serv->sv_nrthreads;
> > =C2=A0out_put:
> > =C2=A0	if (serv->sv_nrthreads =3D=3D 0)
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index 77bbd23aa150..92b888e178e8 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -2054,6 +2054,25 @@ TRACE_EVENT(nfsd_ctl_maxconn,
> > =C2=A0	)
> > =C2=A0);
> > =C2=A0
> > +TRACE_EVENT(nfsd_ctl_maxthreads,
> > +	TP_PROTO(
> > +		const struct net *net,
> > +		int maxthreads
> > +	),
> > +	TP_ARGS(net, maxthreads),
> > +	TP_STRUCT__entry(
> > +		__field(unsigned int, netns_ino)
> > +		__field(int, maxthreads)
> > +	),
> > +	TP_fast_assign(
> > +		__entry->netns_ino =3D net->ns.inum;
> > +		__entry->maxthreads =3D maxthreads
> > +	),
> > +	TP_printk("maxthreads=3D%d",
> > +		__entry->maxthreads
> > +	)
> > +);
> > +
> > =C2=A0TRACE_EVENT(nfsd_ctl_time,
> > =C2=A0	TP_PROTO(
> > =C2=A0		const struct net *net,
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20


