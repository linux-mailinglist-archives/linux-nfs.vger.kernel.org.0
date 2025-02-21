Return-Path: <linux-nfs+bounces-10264-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C49EA3F88F
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 16:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3CA7AB074
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 15:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8985215164;
	Fri, 21 Feb 2025 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaoMHp5u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5FB21507C
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151505; cv=none; b=r+9n+cJifdnBWxYnUxEzKr+qGSHk+vh5H9tUnqs0TWOzGAiVHGqYM1tTCim9KVgnY+i/fO9LQCxip7CvaxDpPgurPcefQlcaVaSjba9gbV7f1GaWNjiOtlXQBhmN7R2F3HaC/a/ZDfcncwqCTTT+Ceqgri0aDgKe+cPrvouJtmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151505; c=relaxed/simple;
	bh=w77L+NuRdSfQ7Od4SEPxhGQNOyziiMa9SBESSwG6wfw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b0P3waUvn3e6tUTs7JcN+tZvC/1gHxZ7EYoJh3ablJJA5qMgV/xOrKzpRu3B0cc13MU4b5ygKNaO4/8M1sUQ26Z8DYRKbs8Mu81u2YQF7RRs1XivCpu22XHrDulM/jt+Mtg+zUkYVsk/3COK97p5ShuDK8N6ydI1IFHBiyJ0+Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaoMHp5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694ABC4AF10;
	Fri, 21 Feb 2025 15:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740151505;
	bh=w77L+NuRdSfQ7Od4SEPxhGQNOyziiMa9SBESSwG6wfw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SaoMHp5uIPZOx4PQwMrTLYupkt7hl82JFyN8zuNAd8YInFIYZRJzuLWTSzioASywp
	 M35/CLqLB/EkudRXOaEyoj/nHVllhGnEuHbuH6GkPbxBO8LNKlezA7hIzoXOX3JjPa
	 f0oiUJ0tlmEB4u4SwXPAf6WaszJUaOvclN+YK/YuAy+5GA5Of53YpYs7+VUu50yluM
	 auQ1fkWxPMGen5WEcAM3rYWLBbe/QPRk22sM0eHkZGnI1Zzz4SBMayRM4lOc0HF71E
	 HzAyf4mdu6oVJEjw1UvmhDjxCYI06aU2NF7wp0zfYmj9SLzZ7Z1t1ZCSCzlwWWmXQT
	 ZcYwJxmkqnNqw==
Message-ID: <b101b927807cc30ce284d6be9aca5cbb92da8f94.camel@kernel.org>
Subject: Re: nfsd: add the ability to enable use of RWF_DONTCACHE for all
 nfsd IO
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>, Olga Kornievskaia
	 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, 	axboe@kernel.dk
Date: Fri, 21 Feb 2025 10:25:03 -0500
In-Reply-To: <Z7iVdHcnGveg-gbg@kernel.org>
References: <20250220171205.12092-1-snitzer@kernel.org>
	 <ce92e5f6-d7cb-47ef-ad96-d334212a51f1@oracle.com>
	 <Z7iVdHcnGveg-gbg@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-21 at 10:02 -0500, Mike Snitzer wrote:
> On Thu, Feb 20, 2025 at 01:17:42PM -0500, Chuck Lever wrote:
> > [ Adding NFSD reviewers ... ]
> >=20
> > On 2/20/25 12:12 PM, Mike Snitzer wrote:
> > > Add nfsd 'nfsd_dontcache' modparam so that "Any data read or written
> > > by nfsd will be removed from the page cache upon completion."
> > >=20
> > > nfsd_dontcache is disabled by default.  It may be enabled with:
> > >   echo Y > /sys/module/nfsd/parameters/nfsd_dontcache
> >=20
> > A per-export setting like an export option would be nicer. Also, does
> > it make sense to make it a separate control for READ and one for WRITE?
> > My trick knee suggests caching read results is still going to add
> > significant value, but write, not so much.
>=20
> My intent was to make 6.14's DONTCACHE feature able to be tested in
> the context of nfsd in a no-frills way.  I realize adding the
> nfsd_dontcache knob skews toward too raw, lacks polish.  But I'm
> inclined to expose such course-grained opt-in knobs to encourage
> others' discovery (and answers to some of the questions you pose
> below).  I also hope to enlist all NFSD reviewers' help in
> categorizing/documenting where DONTCACHE helps/hurts. ;)
>=20
> And I agree that ultimately per-export control is needed.  I'll take
> the time to implement that, hopeful to have something more suitable in
> time for LSF.
>=20

Would it make more sense to hook DONTCACHE up to the IO_ADVISE
operation in RFC7862? IO_ADVISE4_NOREUSE sounds like it has similar
meaning? That would give the clients a way to do this on a per-open
basis.

> > However, to add any such administrative control, I'd like to see some
> > performance numbers. I think we need to enumerate the cases (I/O types)
> > that are most interesting to examine: small memory NFS servers; lots of
> > small unaligned I/O; server-side CPU per byte; storage interrupt rates;
> > any others?
> >=20
> > And let's see some user/admin documentation (eg when should this settin=
g
> > be enabled? when would it be contra-indicated?)
> >=20
> > The same arguments that applied to Cedric's request to make maximum RPC
> > size a tunable setting apply here. Do we want to carry a manual setting
> > for this mechanism for a long time, or do we expect that the setting ca=
n
> > become automatic/uninteresting after a period of experimentation?
> >=20
> > * It might be argued that putting these experimental tunables under /sy=
s
> >   eliminates the support longevity question, since there aren't strict
> >   rules about removing files under /sys.

Isn't /sys covered by the same ABI guarantees? I know debugfs isn't,
but I'm not sure about /sys.

>=20
> Right, I do think a sysfs knob (that defaults to disabled, requires
> user opt-in) is a pretty useful and benign means to expose
> experimental functionality.
>=20
> And I agree with all you said needed above, I haven't had the time to
> focus on DONTCACHE since ~Decemeber, I just picked up my old patches
> from that time and decided to send the NFSD one since DONTCACHE has
> been merged for 6.14.
>=20
>
> =20
> > > FOP_DONTCACHE must be advertised as supported by the underlying
> > > filesystem (e.g. XFS), otherwise if/when 'nfsd_dontcache' is enabled
> > > all IO will fail with -EOPNOTSUPP.
> >=20
> > It would be better all around if NFSD simply ignored the setting in the
> > cases where the underlying file system doesn't implement DONTCACHE.
>=20
> I'll work on making it so.
>=20
> >=20
> >=20
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  fs/nfsd/vfs.c | 17 ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > index 29cb7b812d71..d7e49004e93d 100644
> > > --- a/fs/nfsd/vfs.c
> > > +++ b/fs/nfsd/vfs.c
> > > @@ -955,6 +955,11 @@ nfsd_open_verified(struct svc_fh *fhp, int may_f=
lags, struct file **filp)
> > >  	return __nfsd_open(fhp, S_IFREG, may_flags, filp);
> > >  }
> > > =20
> > > +static bool nfsd_dontcache __read_mostly =3D false;
> > > +module_param(nfsd_dontcache, bool, 0644);
> > > +MODULE_PARM_DESC(nfsd_dontcache,
> > > +		 "Any data read or written by nfsd will be removed from the page c=
ache upon completion.");
> > > +
> > >  /*
> > >   * Grab and keep cached pages associated with a file in the svc_rqst
> > >   * so that they can be passed to the network sendmsg routines
> > > @@ -1084,6 +1089,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, s=
truct svc_fh *fhp,
> > >  	loff_t ppos =3D offset;
> > >  	struct page *page;
> > >  	ssize_t host_err;
> > > +	rwf_t flags =3D 0;
> > > =20
> > >  	v =3D 0;
> > >  	total =3D *count;
> > > @@ -1097,9 +1103,12 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, =
struct svc_fh *fhp,
> > >  	}
> > >  	WARN_ON_ONCE(v > ARRAY_SIZE(rqstp->rq_vec));
> > > =20
> > > +	if (nfsd_dontcache)
> > > +		flags |=3D RWF_DONTCACHE;
> > > +
> > >  	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
> > >  	iov_iter_kvec(&iter, ITER_DEST, rqstp->rq_vec, v, *count);
> > > -	host_err =3D vfs_iter_read(file, &iter, &ppos, 0);
> > > +	host_err =3D vfs_iter_read(file, &iter, &ppos, flags);
> > >  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_=
err);
> > >  }
> > > =20
> > > @@ -1186,6 +1195,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct s=
vc_fh *fhp, struct nfsd_file *nf,
> > >  	if (stable && !fhp->fh_use_wgather)
> > >  		flags |=3D RWF_SYNC;
> > > =20
> > > +	if (nfsd_dontcache)
> > > +		flags |=3D RWF_DONTCACHE;
> > > +
> > >  	iov_iter_kvec(&iter, ITER_SOURCE, vec, vlen, *cnt);
> > >  	since =3D READ_ONCE(file->f_wb_err);
> > >  	if (verf)
> > > @@ -1237,6 +1249,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct s=
vc_fh *fhp, struct nfsd_file *nf,
> > >   */
> > >  bool nfsd_read_splice_ok(struct svc_rqst *rqstp)
> > >  {
> > > +	if (nfsd_dontcache) /* force the use of vfs_iter_read for reads */
> > > +		return false;
> > > +
> >=20
> > Urgh.
>=20
> Heh, yeah, bypassing splice was needed given dontcache hooks off vfs_iter=
_read.
>=20
> > So I've been mulling over simply removing the splice read path.
> >=20
> >  - Less code, less complexity, smaller test matrix
> >=20
> >  - How much of a performance loss would result?
> >=20
> >  - Would such a change make it easier to pass whole folios from
> >    the file system directly to the network layer?
>=20
> Good to know.
>=20

--=20
Jeff Layton <jlayton@kernel.org>

