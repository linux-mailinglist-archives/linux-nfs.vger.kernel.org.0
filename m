Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F955854CE
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jul 2022 19:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiG2RzQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Jul 2022 13:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238394AbiG2RzP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Jul 2022 13:55:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573B2120B0
        for <linux-nfs@vger.kernel.org>; Fri, 29 Jul 2022 10:55:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03D65B828CE
        for <linux-nfs@vger.kernel.org>; Fri, 29 Jul 2022 17:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577FBC433D6;
        Fri, 29 Jul 2022 17:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659117311;
        bh=Rk3gajciYl1vpWc7YfxmS0jasOMI/H08oaE1yqZeVIw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UDwHytD7SpMOrZjV3Dme31he5UQ8S0YsGBQ9lVCpFsELv6kFkKBvrByMKWtdl34P2
         AzSmtM12qVXwFkYqYCwetqin6/uY2P7qMYyMVIopjJTRxNbso5WIYN+OL4XJYhqD7D
         pZEuE+/VhMb4XraFxpgiCFhrasGQMcI+w1YiyjTeAbmlAv1QwH0cKla51qBBT0GZ2R
         4Z9Rj3JLOdH0ncoQpmoUKoQ9vBD7ev8ceB8uuCwfvmoID+kPB1mD0SwpdoWEujb581
         uqEGMbRe0lVwoVSpo4WPs1NAmoFk1Pnz0tJVehXFuO5asDCB4jaCqD2ZVpi3AcWPf5
         4L18VV8EPVvLw==
Message-ID: <abb6f3fb336c3039a7c7a298c1d4722a731911ad.camel@kernel.org>
Subject: Re: [PATCH 3/3] nfsd: eliminate the NFSD_FILE_BREAK_* flags
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Date:   Fri, 29 Jul 2022 13:55:09 -0400
In-Reply-To: <84AC7FA4-9DED-4435-8504-310F6F41C130@oracle.com>
References: <20220729164715.75702-1-jlayton@kernel.org>
         <20220729164715.75702-3-jlayton@kernel.org>
         <5B5182C2-2B5D-4863-A6A4-8F3A6098A9AC@oracle.com>
         <de316707b0bb7e73d16acf717253367578e7f05d.camel@kernel.org>
         <84AC7FA4-9DED-4435-8504-310F6F41C130@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-07-29 at 17:46 +0000, Chuck Lever III wrote:
>=20
> > On Jul 29, 2022, at 1:34 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Fri, 2022-07-29 at 17:21 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Jul 29, 2022, at 12:47 PM, Jeff Layton <jlayton@kernel.org> wrot=
e:
> > > >=20
> > > > We had a report from the spring Bake-a-thon of data corruption in s=
ome
> > > > nfstest_interop tests. Looking at the traces showed the NFS server
> > > > allowing a v3 WRITE to proceed while a read delegation was still
> > > > outstanding.
> > > >=20
> > > > Currently, we only set NFSD_FILE_BREAK_* flags if
> > > > NFSD_MAY_NOT_BREAK_LEASE was set when we call nfsd_file_alloc.
> > > > NFSD_MAY_NOT_BREAK_LEASE was intended to be set when finding files =
for
> > > > COMMIT ops, where we need a writeable filehandle but don't need to
> > > > break read leases.
> > > >=20
> > > > It doesn't make any sense to consult that flag when allocating a fi=
le
> > > > since the file may be used on subsequent calls where we do want to =
break
> > > > the lease (and the usage of it here seems to be reverse from what i=
t
> > > > should be anyway).
> > > >=20
> > > > Also, after calling nfsd_open_break_lease, we don't want to clear t=
he
> > > > BREAK_* bits. A lease could end up being set on it later (more than
> > > > once) and we need to be able to break those leases as well.
> > > >=20
> > > > This means that the NFSD_FILE_BREAK_* flags now just mirror
> > > > NFSD_MAY_{READ,WRITE} flags, so there's no need for them at all. Ju=
st
> > > > drop those flags and unconditionally call nfsd_open_break_lease eve=
ry
> > > > time.
> > > >=20
> > > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2107360
> > > > Fixes: 65294c1f2c5e (nfsd: add a new struct file caching facility t=
o nfsd)
> > > > Reported-by: Olga Kornieskaia <kolga@netapp.com>
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > >=20
> > > I'm going to go out on a limb and predict this will conflict
> > > heavily with the filecache overhaul patches I have queued for
> > > next. :-)
> > >=20
> > > Do you believe this is something that urgently needs to be
> > > backported to stable kernels, or can it be rebased on top of
> > > the filecache overhaul work?
> > >=20
> > >=20
> >=20
> > I based this on top of your for-next branch and I think the filecache i=
s
> > already in there.
> >=20
> > It's a pretty nasty bug that we probably will want backported, so it
> > might make sense to respin this on top of mainline and put it in ahead
> > of the filecache overhaul.
>=20
> I am a generally a proponent of enabling fix backports.
>=20
> I encourage you to test the respin on 5.19 and 5.18 at least
> because the moment that patch hits upstream, Sasha and Greg
> will pull it into stable. I don't relish the idea of having
> to fix the fix, if you catch my drift.
>=20
> And perhaps when you repost, the fix should be reordered
> before the patches that add the tracepoints.
>=20

That all sounds good. I'll do that in a bit, and will send a v2.

>=20
> > Thoughts?
>=20
> Rebasing all that is mechanically straightforward to do.
>=20
> The only issue is that the filecache work and the first PR
> tag is already in my for-next branch. If you don't think it
> will trigger massive heartburn for Linus and Stephen, I can
> pull that stuff out now, and postpone my first PR until the
> second week of the merge window.
>=20

That may be best. I think we want to see this fix go in almost
everywhere.

>=20
> > > > ---
> > > > fs/nfsd/filecache.c | 26 +++-----------------------
> > > > fs/nfsd/filecache.h |  4 +---
> > > > fs/nfsd/trace.h     |  2 --
> > > > 3 files changed, 4 insertions(+), 28 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > index 4758c2a3fcf8..7e566ddca388 100644
> > > > --- a/fs/nfsd/filecache.c
> > > > +++ b/fs/nfsd/filecache.c
> > > > @@ -283,7 +283,7 @@ nfsd_file_mark_find_or_create(struct nfsd_file =
*nf, struct inode *inode)
> > > > }
> > > >=20
> > > > static struct nfsd_file *
> > > > -nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may=
)
> > > > +nfsd_file_alloc(struct nfsd_file_lookup_key *key)
> > > > {
> > > > 	struct nfsd_file *nf;
> > > >=20
> > > > @@ -301,12 +301,6 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *k=
ey, unsigned int may)
> > > > 		/* nf_ref is pre-incremented for hash table */
> > > > 		refcount_set(&nf->nf_ref, 2);
> > > > 		nf->nf_may =3D key->need;
> > > > -		if (may & NFSD_MAY_NOT_BREAK_LEASE) {
> > > > -			if (may & NFSD_MAY_WRITE)
> > > > -				__set_bit(NFSD_FILE_BREAK_WRITE, &nf->nf_flags);
> > > > -			if (may & NFSD_MAY_READ)
> > > > -				__set_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags);
> > > > -		}
> > > > 		nf->nf_mark =3D NULL;
> > > > 	}
> > > > 	return nf;
> > > > @@ -1090,7 +1084,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, =
struct svc_fh *fhp,
> > > > 	if (nf)
> > > > 		goto wait_for_construction;
> > > >=20
> > > > -	new =3D nfsd_file_alloc(&key, may_flags);
> > > > +	new =3D nfsd_file_alloc(&key);
> > > > 	if (!new) {
> > > > 		status =3D nfserr_jukebox;
> > > > 		goto out_status;
> > > > @@ -1130,21 +1124,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp,=
 struct svc_fh *fhp,
> > > > 	nfsd_file_lru_remove(nf);
> > > > 	this_cpu_inc(nfsd_file_cache_hits);
> > > >=20
> > > > -	if (!(may_flags & NFSD_MAY_NOT_BREAK_LEASE)) {
> > > > -		bool write =3D (may_flags & NFSD_MAY_WRITE);
> > > > -
> > > > -		if (test_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags) ||
> > > > -		    (test_bit(NFSD_FILE_BREAK_WRITE, &nf->nf_flags) && write)) {
> > > > -			status =3D nfserrno(nfsd_open_break_lease(
> > > > -					file_inode(nf->nf_file), may_flags));
> > > > -			if (status =3D=3D nfs_ok) {
> > > > -				clear_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags);
> > > > -				if (write)
> > > > -					clear_bit(NFSD_FILE_BREAK_WRITE,
> > > > -						  &nf->nf_flags);
> > > > -			}
> > > > -		}
> > > > -	}
> > > > +	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file)=
, may_flags));
> > > > out:
> > > > 	if (status =3D=3D nfs_ok) {
> > > > 		if (open)
> > > > diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> > > > index d534b76cb65b..8e8c0c47d67d 100644
> > > > --- a/fs/nfsd/filecache.h
> > > > +++ b/fs/nfsd/filecache.h
> > > > @@ -37,9 +37,7 @@ struct nfsd_file {
> > > > 	struct net		*nf_net;
> > > > #define NFSD_FILE_HASHED	(0)
> > > > #define NFSD_FILE_PENDING	(1)
> > > > -#define NFSD_FILE_BREAK_READ	(2)
> > > > -#define NFSD_FILE_BREAK_WRITE	(3)
> > > > -#define NFSD_FILE_REFERENCED	(4)
> > > > +#define NFSD_FILE_REFERENCED	(2)
> > > > 	unsigned long		nf_flags;
> > > > 	struct inode		*nf_inode;	/* don't deref */
> > > > 	refcount_t		nf_ref;
> > > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > > index e9c5d0f56977..2bd867a96eba 100644
> > > > --- a/fs/nfsd/trace.h
> > > > +++ b/fs/nfsd/trace.h
> > > > @@ -758,8 +758,6 @@ DEFINE_CLID_EVENT(confirmed_r);
> > > > 	__print_flags(val, "|",						\
> > > > 		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
> > > > 		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
> > > > -		{ 1 << NFSD_FILE_BREAK_READ,	"BREAK_READ" },		\
> > > > -		{ 1 << NFSD_FILE_BREAK_WRITE,	"BREAK_WRITE" },	\
> > > > 		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"})
> > > >=20
> > > > DECLARE_EVENT_CLASS(nfsd_file_class,
> > > > --=20
> > > > 2.37.1
> > > >=20
> > >=20
> > > --
> > > Chuck Lever
> > >=20
> > >=20
> > >=20
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
