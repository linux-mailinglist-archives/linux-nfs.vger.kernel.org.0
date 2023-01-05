Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A7F65EEAE
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 15:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjAEOZa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 09:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjAEOZE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 09:25:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A185472C
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 06:25:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99FBAB81AD2
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 14:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AE6C433EF;
        Thu,  5 Jan 2023 14:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672928700;
        bh=bRP3WLNL15zjJe22ZnC+JBjuEmn6qr/myG6KUOz3dY0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=A2c6xY6SZMNVHiRu7OTacZffe+CSjcOJldafmdhjBxZxDKMHSUkB6yhnx+v/SyVOh
         22kU2+cSH2D7cMPaFvXoPtw9gbRz67yJZ2hMoaGykkI+o6hnvym03veynwM33TgkkB
         iqgbJdr3JC2LtXH7yOVcjpnTwWST6w0JJSezyLjLck0+HHms7AmVXdw+n4L9IfVuPT
         uTCPZN+yM3dm10XKyoE7qoMpC0RYr6u01ufYGrl2/AoFX0ARNbn4ejtfSRL7becDgj
         SN3/Ph3coeY9NRVYwsGxhTtaCAiG7uoQTrJ8G/kbqwhpBwfskqxX/N/URaTZnfiy7H
         yv1EgpIFyagHA==
Message-ID: <a74fd0c40c0253418124fef0b9e98d08a42b69c9.camel@kernel.org>
Subject: Re: [PATCH v2] nfsd: fix handling of cached open files in
 nfsd4_open codepath
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Stanislav Saner <ssaner@redhat.com>
Date:   Thu, 05 Jan 2023 09:24:58 -0500
In-Reply-To: <EC37F3C6-6CBB-4FA0-8C22-45220D4732FC@oracle.com>
References: <20230105112318.14496-1-jlayton@kernel.org>
         <EC37F3C6-6CBB-4FA0-8C22-45220D4732FC@oracle.com>
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

On Thu, 2023-01-05 at 14:02 +0000, Chuck Lever III wrote:
>=20
> > On Jan 5, 2023, at 6:23 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > Commit fb70bf124b05 ("NFSD: Instantiate a struct file when creating a
> > regular NFSv4 file") added the ability to cache an open fd over a
> > compound. There are a couple of problems with the way this currently
> > works:
> >=20
> > It's racy, as a newly-created nfsd_file can end up with its PENDING bit
> > cleared while the nf is hashed, and the nf_file pointer is still zeroed
> > out. Other tasks can find it in this state and they expect to see a
> > valid nf_file, and can oops if nf_file is NULL.
> >=20
> > Also, there is no guarantee that we'll end up creating a new nfsd_file
> > if one is already in the hash. If an extant entry is in the hash with a
> > valid nf_file, nfs4_get_vfs_file will clobber its nf_file pointer with
> > the value of op_file and the old nf_file will leak.
> >=20
> > Fix both issues by changing nfsd_file_acquire to take an optional file
> > pointer. If one is present when this is called, we'll take a new
> > reference to it instead of trying to open the file. If the nfsd_file
> > already has a valid nf_file, we'll just ignore the optional file and
> > pass the nfsd_file back as-is.
> >=20
> > Also rework the tracepoints a bit to allow for a cached open variant,
> > and don't try to avoid counting acquisitions in the case where we
> > already have a cached open file.
> >=20
> > Cc: Trond Myklebust <trondmy@hammerspace.com>
> > Reported-by: Stanislav Saner <ssaner@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/filecache.c | 49 ++++++++++++++----------------------------
> > fs/nfsd/filecache.h |  5 ++---
> > fs/nfsd/nfs4proc.c  |  2 +-
> > fs/nfsd/nfs4state.c | 20 ++++++-----------
> > fs/nfsd/trace.h     | 52 ++++++++++++---------------------------------
> > 5 files changed, 38 insertions(+), 90 deletions(-)
> >=20
> > v2: rebased directly onto current master branch to fix up some
> >    contextual conflicts
>=20
> Hi Jeff-
>=20
> The basic race is that nf_file must be filled in before the PENDING
> bit is cleared. Got it.
>=20

That, and the fact that the nf_file pointer can be clobbered,
potentially leading to struct file leaks.

> Seems like -rc fodder, and needs a Fixes: tag.
>=20
> However, I'd prefer to keep the synopses of nfsd_file_acquire() and
> nfsd_file_acquire_gc() identical. nfs4_get_vfs_file() is the one
> spot that needs this special behavior, so it should continue to
> call nfsd_file_create(), or something like it. How about one of:
>=20
> nfsd_file_acquire2
> nfsd_file_acquire_create
> nfsd_file_acquire_cached
>=20
>=20

Ok, that's reasonable. I can respin it that way and will rebase onto
your current for-rc branch.


> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 45b2c9e3f636..6674a86e1917 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -1071,8 +1071,8 @@ nfsd_file_is_cached(struct inode *inode)
> >=20
> > static __be32
> > nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > -		     unsigned int may_flags, struct nfsd_file **pnf,
> > -		     bool open, bool want_gc)
> > +		     unsigned int may_flags, struct file *file,
> > +		     struct nfsd_file **pnf, bool want_gc)
> > {
> > 	struct nfsd_file_lookup_key key =3D {
> > 		.type	=3D NFSD_FILE_KEY_FULL,
> > @@ -1147,8 +1147,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
> > 	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may=
_flags));
> > out:
> > 	if (status =3D=3D nfs_ok) {
> > -		if (open)
> > -			this_cpu_inc(nfsd_file_acquisitions);
> > +		this_cpu_inc(nfsd_file_acquisitions);
> > 		*pnf =3D nf;
> > 	} else {
> > 		if (refcount_dec_and_test(&nf->nf_ref))
> > @@ -1158,20 +1157,23 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
> >=20
> > out_status:
> > 	put_cred(key.cred);
> > -	if (open)
> > -		trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
> > +	trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
> > 	return status;
> >=20
> > open_file:
> > 	trace_nfsd_file_alloc(nf);
> > 	nf->nf_mark =3D nfsd_file_mark_find_or_create(nf, key.inode);
> > 	if (nf->nf_mark) {
> > -		if (open) {
> > +		if (file) {
> > +			get_file(file);
> > +			nf->nf_file =3D file;
> > +			status =3D nfs_ok;
> > +			trace_nfsd_file_open_cached(nf, status);
> > +		} else {
> > 			status =3D nfsd_open_verified(rqstp, fhp, may_flags,
> > 						    &nf->nf_file);
> > 			trace_nfsd_file_open(nf, status);
> > -		} else
> > -			status =3D nfs_ok;
> > +		}
> > 	} else
> > 		status =3D nfserr_jukebox;
> > 	/*
> > @@ -1207,7 +1209,7 @@ __be32
> > nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > 		     unsigned int may_flags, struct nfsd_file **pnf)
> > {
> > -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, true);
> > +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, true);
> > }
> >=20
> > /**
> > @@ -1215,6 +1217,7 @@ nfsd_file_acquire_gc(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
> >  * @rqstp: the RPC transaction being executed
> >  * @fhp: the NFS filehandle of the file to be opened
> >  * @may_flags: NFSD_MAY_ settings for the file
> > + * @file: cached, already-open file (may be NULL)
> >  * @pnf: OUT: new or found "struct nfsd_file" object
> >  *
> >  * The nfsd_file_object returned by this API is reference-counted
> > @@ -1226,30 +1229,10 @@ nfsd_file_acquire_gc(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
> >  */
> > __be32
> > nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > -		  unsigned int may_flags, struct nfsd_file **pnf)
> > -{
> > -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, false);
> > -}
> > -
> > -/**
> > - * nfsd_file_create - Get a struct nfsd_file, do not open
> > - * @rqstp: the RPC transaction being executed
> > - * @fhp: the NFS filehandle of the file just created
> > - * @may_flags: NFSD_MAY_ settings for the file
> > - * @pnf: OUT: new or found "struct nfsd_file" object
> > - *
> > - * The nfsd_file_object returned by this API is reference-counted
> > - * but not garbage-collected. The object is released immediately
> > - * one RCU grace period after the final nfsd_file_put().
> > - *
> > - * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
> > - * network byte order is returned.
> > - */
> > -__be32
> > -nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > -		 unsigned int may_flags, struct nfsd_file **pnf)
> > +		  unsigned int may_flags, struct file *file,
> > +		  struct nfsd_file **pnf)
> > {
> > -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, false, false)=
;
> > +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, file, pnf, false);
> > }
> >=20
> > /*
> > diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> > index b7efb2c3ddb1..ef0083cd4ea9 100644
> > --- a/fs/nfsd/filecache.h
> > +++ b/fs/nfsd/filecache.h
> > @@ -59,8 +59,7 @@ bool nfsd_file_is_cached(struct inode *inode);
> > __be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > 		  unsigned int may_flags, struct nfsd_file **nfp);
> > __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > -		  unsigned int may_flags, struct nfsd_file **nfp);
> > -__be32 nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > -		  unsigned int may_flags, struct nfsd_file **nfp);
> > +		  unsigned int may_flags, struct file *file,
> > +		  struct nfsd_file **nfp);
> > int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
> > #endif /* _FS_NFSD_FILECACHE_H */
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index bd880d55f565..6b09cdd4b067 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -735,7 +735,7 @@ nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> > 	__be32 status;
> >=20
> > 	status =3D nfsd_file_acquire(rqstp, &cstate->current_fh, NFSD_MAY_WRIT=
E |
> > -				   NFSD_MAY_NOT_BREAK_LEASE, &nf);
> > +				   NFSD_MAY_NOT_BREAK_LEASE, NULL, &nf);
> > 	if (status !=3D nfs_ok)
> > 		return status;
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 7b2ee535ade8..b68238024e49 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5262,18 +5262,10 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst=
 *rqstp, struct nfs4_file *fp,
> > 	if (!fp->fi_fds[oflag]) {
> > 		spin_unlock(&fp->fi_lock);
> >=20
> > -		if (!open->op_filp) {
> > -			status =3D nfsd_file_acquire(rqstp, cur_fh, access, &nf);
> > -			if (status !=3D nfs_ok)
> > -				goto out_put_access;
> > -		} else {
> > -			status =3D nfsd_file_create(rqstp, cur_fh, access, &nf);
> > -			if (status !=3D nfs_ok)
> > -				goto out_put_access;
> > -			nf->nf_file =3D open->op_filp;
> > -			open->op_filp =3D NULL;
> > -			trace_nfsd_file_create(rqstp, access, nf);
> > -		}
> > +		status =3D nfsd_file_acquire(rqstp, cur_fh, access,
> > +					   open->op_filp, &nf);
> > +		if (status !=3D nfs_ok)
> > +			goto out_put_access;
> >=20
> > 		spin_lock(&fp->fi_lock);
> > 		if (!fp->fi_fds[oflag]) {
> > @@ -6472,7 +6464,7 @@ nfs4_check_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp, struct nfs4_stid *s,
> > 			goto out;
> > 		}
> > 	} else {
> > -		status =3D nfsd_file_acquire(rqstp, fhp, acc, &nf);
> > +		status =3D nfsd_file_acquire(rqstp, fhp, acc, NULL, &nf);
> > 		if (status)
> > 			return status;
> > 	}
> > @@ -7644,7 +7636,7 @@ static __be32 nfsd_test_lock(struct svc_rqst *rqs=
tp, struct svc_fh *fhp, struct
> > 	struct inode *inode;
> > 	__be32 err;
> >=20
> > -	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
> > +	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, NULL, &nf);
> > 	if (err)
> > 		return err;
> > 	inode =3D fhp->fh_dentry->d_inode;
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index c852ae8eaf37..7c6cbc37c8c9 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -981,43 +981,6 @@ TRACE_EVENT(nfsd_file_acquire,
> > 	)
> > );
> >=20
> > -TRACE_EVENT(nfsd_file_create,
> > -	TP_PROTO(
> > -		const struct svc_rqst *rqstp,
> > -		unsigned int may_flags,
> > -		const struct nfsd_file *nf
> > -	),
> > -
> > -	TP_ARGS(rqstp, may_flags, nf),
> > -
> > -	TP_STRUCT__entry(
> > -		__field(const void *, nf_inode)
> > -		__field(const void *, nf_file)
> > -		__field(unsigned long, may_flags)
> > -		__field(unsigned long, nf_flags)
> > -		__field(unsigned long, nf_may)
> > -		__field(unsigned int, nf_ref)
> > -		__field(u32, xid)
> > -	),
> > -
> > -	TP_fast_assign(
> > -		__entry->nf_inode =3D nf->nf_inode;
> > -		__entry->nf_file =3D nf->nf_file;
> > -		__entry->may_flags =3D may_flags;
> > -		__entry->nf_flags =3D nf->nf_flags;
> > -		__entry->nf_may =3D nf->nf_may;
> > -		__entry->nf_ref =3D refcount_read(&nf->nf_ref);
> > -		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
> > -	),
> > -
> > -	TP_printk("xid=3D0x%x inode=3D%p may_flags=3D%s ref=3D%u nf_flags=3D%=
s nf_may=3D%s nf_file=3D%p",
> > -		__entry->xid, __entry->nf_inode,
> > -		show_nfsd_may_flags(__entry->may_flags),
> > -		__entry->nf_ref, show_nf_flags(__entry->nf_flags),
> > -		show_nfsd_may_flags(__entry->nf_may), __entry->nf_file
> > -	)
> > -);
> > -
> > TRACE_EVENT(nfsd_file_insert_err,
> > 	TP_PROTO(
> > 		const struct svc_rqst *rqstp,
> > @@ -1079,8 +1042,8 @@ TRACE_EVENT(nfsd_file_cons_err,
> > 	)
> > );
> >=20
> > -TRACE_EVENT(nfsd_file_open,
> > -	TP_PROTO(struct nfsd_file *nf, __be32 status),
> > +DECLARE_EVENT_CLASS(nfsd_file_open_class,
> > +	TP_PROTO(const struct nfsd_file *nf, __be32 status),
> > 	TP_ARGS(nf, status),
> > 	TP_STRUCT__entry(
> > 		__field(void *, nf_inode)	/* cannot be dereferenced */
> > @@ -1104,6 +1067,17 @@ TRACE_EVENT(nfsd_file_open,
> > 		__entry->nf_file)
> > )
> >=20
> > +#define DEFINE_NFSD_FILE_OPEN_EVENT(name)					\
> > +DEFINE_EVENT(nfsd_file_open_class, name,					\
> > +	TP_PROTO(							\
> > +		const struct nfsd_file *nf,				\
> > +		__be32 status						\
> > +	),								\
> > +	TP_ARGS(nf, status))
> > +
> > +DEFINE_NFSD_FILE_OPEN_EVENT(nfsd_file_open);
> > +DEFINE_NFSD_FILE_OPEN_EVENT(nfsd_file_open_cached);
> > +
> > TRACE_EVENT(nfsd_file_is_cached,
> > 	TP_PROTO(
> > 		const struct inode *inode,
> > --=20
> > 2.39.0
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
