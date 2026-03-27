Return-Path: <linux-nfs+bounces-20472-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJTcM+K8xmnoNwUAu9opvQ
	(envelope-from <linux-nfs+bounces-20472-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 18:22:42 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB397348402
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 18:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 669023072F4A
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 17:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FCD36654E;
	Fri, 27 Mar 2026 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3cd+Jfu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BB336607A;
	Fri, 27 Mar 2026 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630798; cv=none; b=mpjw2Iy+8jzRrexIUEYBqd8WVcFaWQBKayAzjJQVoibL4YDDKP/cqgDAtDobH1gQ+7Au65NRio+y2A5xL4VQXA0ri9zuVXgAs4X/FNoA9jccULYqJ+pMQ6+GvjpAlHemeiC+NaYfc45zXmSCvbqAQBoKbBrT/yExNMi26ctobeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630798; c=relaxed/simple;
	bh=Pgl9weifZgjiuOYjyF+eYc8AILkVW0yNLy2wFRrF/fM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hbr9f6NBjV8hX+TWi5Yo6MyZkyWaAlfwWGg98Iz/UnLzsJA3m4LH7GlhDEbGgJ9/NCbio7nRbvCLejuPV4y+mLBsKhv+YV/bxMA/WgSmrjfDt1KX85ngt7agmwhVQUO+2WujmwqqqbXtn8c2H2GxoRikh3gGes8k+qKmjC1ygco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3cd+Jfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E8BC19423;
	Fri, 27 Mar 2026 16:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774630798;
	bh=Pgl9weifZgjiuOYjyF+eYc8AILkVW0yNLy2wFRrF/fM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=m3cd+JfupNCqxor91XQwc5L0HEKdQnejF9QUAtOXeTQLmF53ohrssKy7mLKyvTwvp
	 hqr6e8HS0+Xgn4/Is58RheeobGBFmFH5uLsHN0UrFzLwVKpRt4vM9DW8RNPlwoVLlE
	 9gFYVg2aap7SfW+4jC7OljEXuiH5DKD0WpIQH2LmD12XZuO3/uun1RbUt6Iw5Ki6z8
	 tCdvZE7ISPUQAw40rhnlC5zY3aHnaKwun3J2eugbQMrJDsSNEIgCdf2UFeKqXn/f0j
	 +oabnAFUJF3GwrA5trzY+cESiXIFq/cnuwcf5f1KGBuQZoNp8Uv5swHuaOBoqWR9qu
	 J0pg8J8WCd+Iw==
Message-ID: <80b423c66dba84b46be1084307d2c66b935065bc.camel@kernel.org>
Subject: Re: [PATCH v2 2/2] nfs: update inode ctime after removexattr
 operation
From: Jeff Layton <jlayton@kernel.org>
To: Olga Kornievskaia <aglo@umich.edu>, Thomas Haynes <loghyr@gmail.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 27 Mar 2026 12:59:54 -0400
In-Reply-To: <CAN-5tyFsEUcSUycb4JjxH5v754SefwOH=zt24KtxEC_Ow4OjMw@mail.gmail.com>
References: <20260324-nfs-7-1-v2-0-d110da3c0036@kernel.org>
	 <20260324-nfs-7-1-v2-2-d110da3c0036@kernel.org>
	 <CAN-5tyFpsuE9+5ZvAASwvTYKtcN5jNpAxi8ejde90e-vpUzFKg@mail.gmail.com>
	 <284ca17e74af8c4f5942b2952f2bf75490dd17c0.camel@kernel.org>
	 <CAN-5tyFsEUcSUycb4JjxH5v754SefwOH=zt24KtxEC_Ow4OjMw@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[umich.edu,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20472-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[umich.edu:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB397348402
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-03-27 at 12:20 -0400, Olga Kornievskaia wrote:
> On Fri, Mar 27, 2026 at 11:50=E2=80=AFAM Jeff Layton <jlayton@kernel.org>=
 wrote:
> >=20
> > On Fri, 2026-03-27 at 11:11 -0400, Olga Kornievskaia wrote:
> > > On Tue, Mar 24, 2026 at 1:32=E2=80=AFPM Jeff Layton <jlayton@kernel.o=
rg> wrote:
> > > >=20
> > > > xfstest generic/728 fails with delegated timestamps. The client doe=
s a
> > > > removexattr and then a stat to test the ctime, which doesn't change=
. The
> > > > stat() doesn't trigger a GETATTR because of the delegated timestamp=
s, so
> > > > it relies on the cached ctime, which is wrong.
> > > >=20
> > > > The setxattr compound has a trailing GETATTR, which ensures that it=
s
> > > > ctime gets updated. Follow the same strategy with removexattr.
> > >=20
> > > This approach relies on the fact that the server the serves delegated
> > > attributes would update change_attr on operations which might now
> > > necessarily happen (ie, linux server does not update change_attribute
> > > on writes or clone). I propose an alternative fix for the failing
> > > generic/728.
> > >=20
> > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > index 7b3ca68fb4bb..ede1835a45b3 100644
> > > --- a/fs/nfs/nfs42proc.c
> > > +++ b/fs/nfs/nfs42proc.c
> > > @@ -1389,7 +1389,13 @@ static int _nfs42_proc_removexattr(struct inod=
e
> > > *inode, const char *name)
> > >             &res.seq_res, 1);
> > >         trace_nfs4_removexattr(inode, name, ret);
> > >         if (!ret)
> > > -               nfs4_update_changeattr(inode, &res.cinfo, timestamp, =
0);
> > > +               if (nfs_have_delegated_attributes(inode)) {
> > > +                       nfs_update_delegated_mtime(inode);
> > > +                       spin_lock(&inode->i_lock);
> > > +                       nfs_set_cache_invalid(inode, NFS_INO_INVALID_=
BLOCKS);
> > > +                       spin_unlock(&inode->i_lock);
> > > +               } else
> > > +                       nfs4_update_changeattr(inode, &res.cinfo, tim=
estamp, 0);
> > >=20
> > >         return ret;
> > >  }
> > >=20
> >=20
> > What's the advantage of doing it this way?
> >=20
> > You just sent a REMOVEXATTR operation to the server that will change
> > the mtime there. The server has the most up-to-date version of the
> > mtime and ctime at that point.
>=20
> In presence of delegated attributes, Is the server required to update
> its mtime/ctime on an operation? As I mentioned, the linux server does
> not update its ctime/mtime for WRITE, CLONE, COPY.
>=20
> Is possible that
> some implementations might be different and also do not update the
> ctime/mtime on REMOVEXATTR?
>=20
> Therefore I was suggesting that the patch
> relies on the fact that it would receive an updated value. Of course
> perhaps all implementations are done the same as the linux server and
> my point is moot. I didn't see anything in the spec that clarifies
> what the server supposed to do (and client rely on).
>=20

(cc'ing Tom)

That is a very good point.

My interpretation was that delegated timestamps generally covered
writes, but SETATTR style operations that do anything beyond only
changing the mtime can't be cached.

We probably need some delstid spec clarification: for what operations
is the server required to disable timestamp updates when a write
delegation is outstanding?

In the case of nfsd, we disable timestamp updates for WRITE/COPY/CLONE
but not SETATTR/SETXATTR/REMOVEXATTR.

How does the Hammerspace anvil behave? Does it disable c/mtime updates
for writes when there is an outstanding timestamp delegation like we're
doing in nfsd? If so, does it do the same for
SETATTR/SETXATTR/REMOVEXATTR operations as well?



> > It's certainly possible that the REMOVEXATTR is the only change that
> > occurred. With what I'm proposing, we don't even need to do a SETATTR
> > at all if nothing else changed. With your version, you would.
> >=20
> > > >=20
> > > > Fixes: 3e1f02123fba ("NFSv4.2: add client side XDR handling for ext=
ended attributes")
> > > > Reported-by: Olga Kornievskaia <aglo@umich.edu>
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  fs/nfs/nfs42proc.c      | 18 ++++++++++++++++--
> > > >  fs/nfs/nfs42xdr.c       | 10 ++++++++--
> > > >  include/linux/nfs_xdr.h |  3 +++
> > > >  3 files changed, 27 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > > index 7b3ca68fb4bb3bee293f8621e5ed5fa596f5da3f..7e5c1172fc11c9d5a55=
b3621977ac83bb98f7c20 100644
> > > > --- a/fs/nfs/nfs42proc.c
> > > > +++ b/fs/nfs/nfs42proc.c
> > > > @@ -1372,11 +1372,15 @@ int nfs42_proc_clone(struct file *src_f, st=
ruct file *dst_f,
> > > >  static int _nfs42_proc_removexattr(struct inode *inode, const char=
 *name)
> > > >  {
> > > >         struct nfs_server *server =3D NFS_SERVER(inode);
> > > > +       __u32 bitmask[NFS_BITMASK_SZ];
> > > >         struct nfs42_removexattrargs args =3D {
> > > >                 .fh =3D NFS_FH(inode),
> > > > +               .bitmask =3D bitmask,
> > > >                 .xattr_name =3D name,
> > > >         };
> > > > -       struct nfs42_removexattrres res;
> > > > +       struct nfs42_removexattrres res =3D {
> > > > +               .server =3D server,
> > > > +       };
> > > >         struct rpc_message msg =3D {
> > > >                 .rpc_proc =3D &nfs4_procedures[NFSPROC4_CLNT_REMOVE=
XATTR],
> > > >                 .rpc_argp =3D &args,
> > > > @@ -1385,12 +1389,22 @@ static int _nfs42_proc_removexattr(struct i=
node *inode, const char *name)
> > > >         int ret;
> > > >         unsigned long timestamp =3D jiffies;
> > > >=20
> > > > +       res.fattr =3D nfs_alloc_fattr();
> > > > +       if (!res.fattr)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       nfs4_bitmask_set(bitmask, server->cache_consistency_bitmask=
,
> > > > +                        inode, NFS_INO_INVALID_CHANGE);
> > > > +
> > > >         ret =3D nfs4_call_sync(server->client, server, &msg, &args.=
seq_args,
> > > >             &res.seq_res, 1);
> > > >         trace_nfs4_removexattr(inode, name, ret);
> > > > -       if (!ret)
> > > > +       if (!ret) {
> > > >                 nfs4_update_changeattr(inode, &res.cinfo, timestamp=
, 0);
> > > > +               ret =3D nfs_post_op_update_inode(inode, res.fattr);
> > > > +       }
> > > >=20
> > > > +       kfree(res.fattr);
> > > >         return ret;
> > > >  }
> > > >=20
> > > > diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> > > > index 5c7452ce6e8ac94bd24bc3a33d4479d458a29907..ec105c62f721cfe01bf=
c60f5981396958084d627 100644
> > > > --- a/fs/nfs/nfs42xdr.c
> > > > +++ b/fs/nfs/nfs42xdr.c
> > > > @@ -263,11 +263,13 @@
> > > >  #define NFS4_enc_removexattr_sz                (compound_encode_hd=
r_maxsz + \
> > > >                                          encode_sequence_maxsz + \
> > > >                                          encode_putfh_maxsz + \
> > > > -                                        encode_removexattr_maxsz)
> > > > +                                        encode_removexattr_maxsz +=
 \
> > > > +                                        encode_getattr_maxsz)
> > > >  #define NFS4_dec_removexattr_sz                (compound_decode_hd=
r_maxsz + \
> > > >                                          decode_sequence_maxsz + \
> > > >                                          decode_putfh_maxsz + \
> > > > -                                        decode_removexattr_maxsz)
> > > > +                                        decode_removexattr_maxsz +=
 \
> > > > +                                        decode_getattr_maxsz)
> > > >=20
> > > >  /*
> > > >   * These values specify the maximum amount of data that is not
> > > > @@ -869,6 +871,7 @@ static void nfs4_xdr_enc_removexattr(struct rpc=
_rqst *req,
> > > >         encode_sequence(xdr, &args->seq_args, &hdr);
> > > >         encode_putfh(xdr, args->fh, &hdr);
> > > >         encode_removexattr(xdr, args->xattr_name, &hdr);
> > > > +       encode_getfattr(xdr, args->bitmask, &hdr);
> > > >         encode_nops(&hdr);
> > > >  }
> > > >=20
> > > > @@ -1818,6 +1821,9 @@ static int nfs4_xdr_dec_removexattr(struct rp=
c_rqst *req,
> > > >                 goto out;
> > > >=20
> > > >         status =3D decode_removexattr(xdr, &res->cinfo);
> > > > +       if (status)
> > > > +               goto out;
> > > > +       status =3D decode_getfattr(xdr, res->fattr, res->server);
> > > >  out:
> > > >         return status;
> > > >  }
> > > > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> > > > index ff1f12aa73d27b6fd874baf7019dd03195fc36e5..fcbd21b5685f46136a2=
10c8e11c20a54d6ed9dad 100644
> > > > --- a/include/linux/nfs_xdr.h
> > > > +++ b/include/linux/nfs_xdr.h
> > > > @@ -1611,12 +1611,15 @@ struct nfs42_listxattrsres {
> > > >  struct nfs42_removexattrargs {
> > > >         struct nfs4_sequence_args       seq_args;
> > > >         struct nfs_fh                   *fh;
> > > > +       const u32                       *bitmask;
> > > >         const char                      *xattr_name;
> > > >  };
> > > >=20
> > > >  struct nfs42_removexattrres {
> > > >         struct nfs4_sequence_res        seq_res;
> > > >         struct nfs4_change_info         cinfo;
> > > > +       struct nfs_fattr                *fattr;
> > > > +       const struct nfs_server         *server;
> > > >  };
> > > >=20
> > > >  #endif /* CONFIG_NFS_V4_2 */
> > > >=20
> > > > --
> > > > 2.53.0
> > > >=20
> >=20
> > --
> > Jeff Layton <jlayton@kernel.org>

--=20
Jeff Layton <jlayton@kernel.org>

