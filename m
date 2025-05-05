Return-Path: <linux-nfs+bounces-11435-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828AFAA945F
	for <lists+linux-nfs@lfdr.de>; Mon,  5 May 2025 15:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D86D3B4342
	for <lists+linux-nfs@lfdr.de>; Mon,  5 May 2025 13:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F233B2561D9;
	Mon,  5 May 2025 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSrt6zQ6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2512561C2
	for <linux-nfs@vger.kernel.org>; Mon,  5 May 2025 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451384; cv=none; b=r3HCXN9PA6JvsFipvKNzZ9usF9gwG7shibc0Wn5Luin4Im2ZQQ/nyLC+UWDw/HZlVTlemO2cUxwILvNRsTl9nfvjTkwZrvkzgY2LenW/OLiFZUp/1Qp4g6UUWd4EglOBQfUtGcy1vU4+/MAYfB9NkGCEHDRvfphnUtqf4wse2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451384; c=relaxed/simple;
	bh=JFyEdLgxqE+qpVbo5O2OQwg+PWY+eBhlF50CC+1YsTo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=THRtQQzAR3kZaCiJ2kEgfHuuGOM20iaazYuwUbqsyNwQOtu3nOjb57AVj/GdZmkw0ZdK++NQ4hQtFJcFldsxk8Z/5Z8E61JI3gl8xwaXzgxCAhNXdeZAxnqDjLsxyFntwEf78XejBZb3WMN7+B6b0rscgHdh94zBDqaNPT4ykmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSrt6zQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC395C4CEE4;
	Mon,  5 May 2025 13:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746451384;
	bh=JFyEdLgxqE+qpVbo5O2OQwg+PWY+eBhlF50CC+1YsTo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mSrt6zQ6gJ1RXeblL3vtJR5LACFY3+6MJ1EwDKfDmvxzwfi9eya3zgtmyxkASeKoH
	 Jk/pi6NW+Z4FvYDqt3QPDKXyZjjm0luvrYFJ1/kZs8OQY5Hy1miC4d52Er7WPgT292
	 GG471Zog5mV4GIeA4Uf0YtB9LPlpvFcRrwWlU9f4549nWwdyXYvjQyWPH1rh1ZROY7
	 CQvg40BGXiZg7NTD1xGW35olhNcdBzYEjU4HHWMzPeUGNXqdjOi3/HLs+1MJOdC1+M
	 uguyS7QyZ8nETpDdCAZPQzldG68GpQbt7ZH+V96FECa/rujoKkFQD4ulyDeelArBCF
	 gL9W7s/fRBe/w==
Message-ID: <67a837dbebdbc6bb457998b1f61358970f31a4ed.camel@kernel.org>
Subject: Re: [PATCH] NFSv4.2: fix setattr caching of
 TIME_[MODIFY|ACCESS]_SET when timestamps are delegated
From: Jeff Layton <jlayton@kernel.org>
To: sagi@grimberg.me, linux-nfs@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
	 <Anna.Schumaker@netapp.com>, Thomas Haynes <loghyr@gmail.com>
Date: Mon, 05 May 2025 09:23:02 -0400
In-Reply-To: <20250425124919.1727838-1-sagi@grimberg.me>
References: <20250425124919.1727838-1-sagi@grimberg.me>
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

On Fri, 2025-04-25 at 15:49 +0300, Sagi Grimberg wrote:
> nfs_setattr will flush all pending writes before updating a file time
> attributes. However when the client holds delegated timestamps, it can
> update its timestamps locally as it is the authority for the file
> times attributes. The client will later set the file attributes by
> adding a setattr to the delegreturn compound updating the server time
> attributes.
>=20
> Fix nfs_setattr to avoid flushing pending writes when the file time
> attributes are delegated and the mtime/atime are set to a fixed
> timestamp (ATTR_[MODIFY|ACCESS]_SET. Also, when sending the setattr
> procedure over the wire, we need to clear the correct attribute bits
> from the bitmask.
>=20
> I was able to measure a noticable speedup when measuring untar performanc=
e.
> Test: $ time tar xzf ~/dir.tgz
> Baseline: 1m13.072s
> Patched: 0m49.038s
>=20
> Which is more than 30% latency improvement.
>=20

(cc'ing Tom since he was the spec author for the timestamp delegation)

Nice!

> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Tested this on a vm in my laptop against chuck nfsd-testing which
> grants write delegs for write-only opens, plus another small modparam
> that also adds a space_limit to the delegation.
>=20
>  fs/nfs/inode.c    | 49 +++++++++++++++++++++++++++++++++++++++++++----
>  fs/nfs/nfs4proc.c |  8 ++++----
>  2 files changed, 49 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 119e447758b9..6472b95bfd88 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -633,6 +633,34 @@ nfs_fattr_fixup_delegated(struct inode *inode, struc=
t nfs_fattr *fattr)
>  	}
>  }
> =20
> +static void nfs_set_timestamps_to_ts(struct inode *inode, struct iattr *=
attr)
> +{
> +	unsigned int cache_flags =3D 0;
> +
> +	if (attr->ia_valid & ATTR_MTIME_SET) {
> +		struct timespec64 ctime =3D inode_get_ctime(inode);
> +		struct timespec64 mtime =3D inode_get_mtime(inode);
> +		struct timespec64 now;
> +		int updated =3D 0;
> +
> +		now =3D inode_set_ctime_current(inode);
> +		if (!timespec64_equal(&now, &ctime))
> +			updated |=3D S_CTIME;
> +
> +		inode_set_mtime_to_ts(inode, attr->ia_mtime);
> +		if (!timespec64_equal(&now, &mtime))
> +			updated |=3D S_MTIME;
> +
> +		inode_maybe_inc_iversion(inode, updated);
> +		cache_flags |=3D NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME;
> +	}
> +	if (attr->ia_valid & ATTR_ATIME_SET) {
> +		inode_set_atime_to_ts(inode, attr->ia_atime);
> +		cache_flags |=3D NFS_INO_INVALID_ATIME;
> +	}
> +	NFS_I(inode)->cache_validity &=3D ~cache_flags;
> +}
> +
>  static void nfs_update_timestamps(struct inode *inode, unsigned int ia_v=
alid)
>  {
>  	enum file_time_flags time_flags =3D 0;
> @@ -701,14 +729,27 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry =
*dentry,
> =20
>  	if (nfs_have_delegated_mtime(inode) && attr->ia_valid & ATTR_MTIME) {
>  		spin_lock(&inode->i_lock);
> -		nfs_update_timestamps(inode, attr->ia_valid);
> +		if (attr->ia_valid & ATTR_MTIME_SET) {

Is this also a bugfix? Is ATTR_MTIME_SET being handled correctly in the
existing code?

> +			nfs_set_timestamps_to_ts(inode, attr);
> +			attr->ia_valid &=3D ~(ATTR_MTIME|ATTR_MTIME_SET|
> +						ATTR_ATIME|ATTR_ATIME_SET);

It might look a little cleaner to move the ia_valid changes into
nfs_set_timestamps_to_ts().


> +		} else {
> +			nfs_update_timestamps(inode, attr->ia_valid);
> +			attr->ia_valid &=3D ~(ATTR_MTIME|ATTR_ATIME);
> +		}
>  		spin_unlock(&inode->i_lock);
> -		attr->ia_valid &=3D ~(ATTR_MTIME | ATTR_ATIME);
>  	} else if (nfs_have_delegated_atime(inode) &&
>  		   attr->ia_valid & ATTR_ATIME &&
>  		   !(attr->ia_valid & ATTR_MTIME)) {
> -		nfs_update_delegated_atime(inode);
> -		attr->ia_valid &=3D ~ATTR_ATIME;
> +		if (attr->ia_valid & ATTR_ATIME_SET) {
> +			spin_lock(&inode->i_lock);
> +			nfs_set_timestamps_to_ts(inode, attr);
> +			spin_unlock(&inode->i_lock);
> +			attr->ia_valid &=3D ~(ATTR_ATIME|ATTR_ATIME_SET);
> +		} else {
> +			nfs_update_delegated_atime(inode);
> +			attr->ia_valid &=3D ~ATTR_ATIME;
> +		}
>  	}
> =20
>  	/* Optimization: if the end result is no change, don't RPC */
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 970f28dbf253..c501a0d5da90 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -325,14 +325,14 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, con=
st __u32 *src,
> =20
>  	if (nfs_have_delegated_mtime(inode)) {
>  		if (!(cache_validity & NFS_INO_INVALID_ATIME))
> -			dst[1] &=3D ~FATTR4_WORD1_TIME_ACCESS;
> +			dst[1] &=3D ~(FATTR4_WORD1_TIME_ACCESS|FATTR4_WORD1_TIME_ACCESS_SET);
>  		if (!(cache_validity & NFS_INO_INVALID_MTIME))
> -			dst[1] &=3D ~FATTR4_WORD1_TIME_MODIFY;
> +			dst[1] &=3D ~(FATTR4_WORD1_TIME_MODIFY|FATTR4_WORD1_TIME_MODIFY_SET);
>  		if (!(cache_validity & NFS_INO_INVALID_CTIME))
> -			dst[1] &=3D ~FATTR4_WORD1_TIME_METADATA;
> +			dst[1] &=3D ~(FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY_SET=
);
>  	} else if (nfs_have_delegated_atime(inode)) {
>  		if (!(cache_validity & NFS_INO_INVALID_ATIME))
> -			dst[1] &=3D ~FATTR4_WORD1_TIME_ACCESS;
> +			dst[1] &=3D ~(FATTR4_WORD1_TIME_ACCESS|FATTR4_WORD1_TIME_ACCESS_SET);
>  	}
>  }
> =20

FWIW, we've been chasing some problems with the git regression
testsuite when attribute delegation is enabled. It would be interesting
to test this patch to see if it changes that behavior.

Otherwise, this seems like a reasonable thing to do, and I do like the
potential performance improvement!

Reviewed-by: Jeff Layton <jlayton@kernel.org>

