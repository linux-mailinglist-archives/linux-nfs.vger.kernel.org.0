Return-Path: <linux-nfs+bounces-13376-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44371B183D2
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 16:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C72F1895923
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 14:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDA02472B7;
	Fri,  1 Aug 2025 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6w/bqQt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0F921ABAD
	for <linux-nfs@vger.kernel.org>; Fri,  1 Aug 2025 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058784; cv=none; b=tHDEZ77ml1IDa3/oG3ZXf8Cas3XZSDUM4QYlK3fdzRjcx2KnWSqNcZcbvc7V53Ja5Unym6w2gsygNLVhzBTkSc3JTMobI1HxWmsodt60pvrHjpVm0vPnmbh88HHEj2xV3bSD52xXB0NGvIOTyAfCs5Qp1dOmECetiL/x1qfHz5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058784; c=relaxed/simple;
	bh=pCwMMXbm2qKGPqW6XX5+rn5CpmxZPH0BQETYW7Yvad0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FGdMtCIk6weZcs1rcuc85cF0pBrIpKzq0YVhV/Szg5I4tJsruB5OcVT1tTveEwiVBuB9nY4zCiocrOhbSguqH6XmeBLcTnNJIpmYeHE0GLtHLivd1WO17FywW6avr5MC0kvwGfreeslYD5XztWdWBbonkNrIKHLjTY1Ek+m75EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6w/bqQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CBAC4CEE7;
	Fri,  1 Aug 2025 14:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754058783;
	bh=pCwMMXbm2qKGPqW6XX5+rn5CpmxZPH0BQETYW7Yvad0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=G6w/bqQt8Nm5LWsk7sXcfTdhy+BB3KYTCxi3/fMWk5/MTGxVxwQZwUHG/0aSMOw8n
	 ZqIn6VBmj2jE29/PHmiuWH0ATZWCSW6sDkx556mRQv0NFyP3X9xE7vazYFGE25lENa
	 VHMqrLjV0883vNB976zxmDefZ6Vn3jG0EW8EsvevhIiWnnsEPlq8TbyJB+ej8yyj29
	 nuGcVrrcVRfFn/sZp7QgbVMpbaQ80IehgzGhXuxOIjelcoi60mVLqCwr3HJ045Z9kP
	 Y2kdPpEoYHbne+OyttcXrfq4Mt7H9MxOBoJaki0PjeDRoAknbHHXTZ8oR57aSbCr5f
	 /yY/WbTE84rYw==
Message-ID: <2006e3616903dd0f6db5653675d5741289e7e06b.camel@kernel.org>
Subject: Re: [PATCH v2 4/4] NFSD: handle unaligned DIO for NFS reexport
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, hch@lst.de
Date: Fri, 01 Aug 2025 10:33:02 -0400
In-Reply-To: <f430725a-600c-44da-8062-1b45b17537ce@oracle.com>
References: <20250731194448.88816-1-snitzer@kernel.org>
	 <20250731194448.88816-5-snitzer@kernel.org>
	 <b5e2e433e70189b4ed05417f8bdb2ff98a82881e.camel@kernel.org>
	 <aIvf7VqSeNE3Ma1m@kernel.org> <aIvkm_O4ff3vIKAM@kernel.org>
	 <f430725a-600c-44da-8062-1b45b17537ce@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-01 at 10:07 -0400, Chuck Lever wrote:
> On 7/31/25 5:48 PM, Mike Snitzer wrote:
> > On Thu, Jul 31, 2025 at 05:28:13PM -0400, Mike Snitzer wrote:
> > > On Thu, Jul 31, 2025 at 04:58:00PM -0400, Jeff Layton wrote:
> > > > On Thu, 2025-07-31 at 15:44 -0400, Mike Snitzer wrote:
> > > > > NFS doesn't have any DIO alignment constraints but it doesn't sup=
port
> > > > > STATX_DIOALIGN, so update NFSD such that it doesn't disable the u=
se of
> > > > > NFSD_IO_DIRECT if it is reexporting NFS.
> > > > >=20
> > > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > > ---
> > > > >  fs/nfs/export.c          |  3 ++-
> > > > >  fs/nfsd/filecache.c      | 11 +++++++++++
> > > > >  include/linux/exportfs.h | 13 +++++++++++++
> > > > >  3 files changed, 26 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> > > > > index e9c233b6fd209..2cae75ba6b35d 100644
> > > > > --- a/fs/nfs/export.c
> > > > > +++ b/fs/nfs/export.c
> > > > > @@ -155,5 +155,6 @@ const struct export_operations nfs_export_ops=
 =3D {
> > > > >  		 EXPORT_OP_REMOTE_FS		|
> > > > >  		 EXPORT_OP_NOATOMIC_ATTR	|
> > > > >  		 EXPORT_OP_FLUSH_ON_CLOSE	|
> > > > > -		 EXPORT_OP_NOLOCKS,
> > > > > +		 EXPORT_OP_NOLOCKS		|
> > > > > +		 EXPORT_OP_NO_DIOALIGN_NEEDED,
> > > > >  };
> > > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > > index 5601e839a72da..ea489dd44fd9a 100644
> > > > > --- a/fs/nfsd/filecache.c
> > > > > +++ b/fs/nfsd/filecache.c
> > > > > @@ -1066,6 +1066,17 @@ nfsd_file_getattr(const struct svc_fh *fhp=
, struct nfsd_file *nf)
> > > > >  	     nfsd_io_cache_write !=3D NFSD_IO_DIRECT))
> > > > >  		return nfs_ok;
> > > > > =20
> > > > > +	if (exportfs_handles_unaligned_dio(nf->nf_file->f_path.mnt->mnt=
_sb->s_export_op)) {
> > > > > +		/* Underlying filesystem doesn't support STATX_DIOALIGN
> > > > > +		 * but it can handle all unaligned DIO, so establish
> > > > > +		 * DIO alignment that is accommodating.
> > > > > +		 */
> > > > > +		nf->nf_dio_mem_align =3D 4;
> > > > > +		nf->nf_dio_offset_align =3D PAGE_SIZE;
> > > > > +		nf->nf_dio_read_offset_align =3D nf->nf_dio_offset_align;
> > > > > +		return nfs_ok;
> > > > > +	}
> > > > > +
> > > > >  	status =3D fh_getattr(fhp, &stat);
> > > > >  	if (status !=3D nfs_ok)
> > > > >  		return status;
> > > > > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > > > > index 9369a607224c1..626b8486dd985 100644
> > > > > --- a/include/linux/exportfs.h
> > > > > +++ b/include/linux/exportfs.h
> > > > > @@ -247,6 +247,7 @@ struct export_operations {
> > > > >  						*/
> > > > >  #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data =
on close */
> > > > >  #define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
> > > > > +#define EXPORT_OP_NO_DIOALIGN_NEEDED	(0x80) /* fs can handle una=
ligned DIO */
> > > > >  	unsigned long	flags;
> > > > >  };
> > > > > =20
> > > > > @@ -262,6 +263,18 @@ exportfs_cannot_lock(const struct export_ope=
rations *export_ops)
> > > > >  	return export_ops->flags & EXPORT_OP_NOLOCKS;
> > > > >  }
> > > > > =20
> > > > > +/**
> > > > > + * exportfs_handles_unaligned_dio() - check if export can handle=
 unaligned DIO
> > > > > + * @export_ops:	the nfs export operations to check
> > > > > + *
> > > > > + * Returns true if the export can handle unaligned DIO.
> > > > > + */
> > > > > +static inline bool
> > > > > +exportfs_handles_unaligned_dio(const struct export_operations *e=
xport_ops)
> > > > > +{
> > > > > +	return export_ops->flags & EXPORT_OP_NO_DIOALIGN_NEEDED;
> > > > > +}
> > > > > +
> > > > >  extern int exportfs_encode_inode_fh(struct inode *inode, struct =
fid *fid,
> > > > >  				    int *max_len, struct inode *parent,
> > > > >  				    int flags);
> > > >=20
> > > >=20
> > > > Would it not be simpler (better?) to add support for STATX_DIOALIGN=
 to
> > > > NFS, and just have it report '1' for both values?
> > >=20
> > > I suppose adding NFS support for STATX_DIOALIGN, that doesn't actuall=
y
> > > go over the wire, does make sense.
> > >=20
> > > But I wouldn't think setting them to 1 valid.  Pretty sure they need
> > > to be a power-of-2 (since they are used as masks passed to
> > > iov_iter_is_aligned).
> > >=20
> > > In addition, we want to make sure NFS's default DIO alignment (which
> > > isn't informed by actual DIO alignment advertised by NFSD's underlyin=
g
> > > filesystem and hardware, e.g. XFS and NVMe) is able to be compatible
> > > with both finer (512b) and coarser (4096b) grained DIO alignment.
> > > Only way to achieve that would be to skew toward the coarse-grained
> > > end of the spectrum, right?
> > >=20
> > > More conservative but more likely to work with everything.
> >=20
> > Thinking/looking further: I really do prefer the approach I took in
> > this patch (over the suggestion to implement STATX_DIOALIGN for NFS).
> >=20
> > Otherwise NFS would forced to needlessly issue an RPC via fh_getattr()
> > even though we're talking about NFS faking its STATX_DIOALIGN response
> > (so it doesn't need to do the work to do a full-blown GETATTR).
> >=20
> > This would be wasteful for the NFS reexport usecase.
>=20
> Jeff's point is that applications (and in particular, user space NFS
> servers) will use statx() to discover these values. The NFS client has
> to implement STATX_DIOALIGN.
>
> I don't buy the idea that using vfs_getattr() to call into the NFS
> client is wasteful here. Isn't this done once when the nfsd_file
> is opened? And, since these are emulated values that are not fetched
> via the NFS protocol, wouldn't that mean the NFS client could respond
> without sending an RPC?
>=20
> I prefer to not add the exception processing to NFSD if, in the medium
> to long run, the NFS client has to get support for DIOALIGN anyway.
>=20

I too think this would be a better approach. We have other exportable
filesystems that have no DIO alignment restrictions too (Ceph comes to
mind, but there are others). It would be nice if they "just worked" and
didn't have to do special EXPORT_* flag shenanigans.

--=20
Jeff Layton <jlayton@kernel.org>

