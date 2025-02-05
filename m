Return-Path: <linux-nfs+bounces-9880-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39986A28E47
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 15:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C8116899E
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 14:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709781537AC;
	Wed,  5 Feb 2025 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzrnztJ6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F8115198D;
	Wed,  5 Feb 2025 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764670; cv=none; b=BMqXZE71pYjsh0U1dnnhG/nxnrR0vF/Kj/8EempbL74chx8jQUZMlduq72/A3lNxLai/uEmEmfSXoxWnbFR1PI7TXvlQnvdQOtDXkjHyfrUxCtfct1lWwL2podSqNXgC4jqFyL9AbQnSzwv1eyjlDVbBFXaqyFGe/pwXJ5z9JiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764670; c=relaxed/simple;
	bh=MkBrW83E83JxBCXrhFthWYfVkvOxdS1yoeVlbf0Rmpo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mn9lKkjspW0W3OJ5OphQQKlTuIyvAkpe4OwKvIa8uWtVf0yJ7srWmHvN3niGEq8ugF9ME3C3P5+5W/MPBkVS1lPLYTF1BcTqoJRCmBnOMn6imZAhyLyWYe2qTC67NtE/kOezO8LPJZzIHVLJAfcp4eaCBefY8uvUN5uYGCOQpMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzrnztJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150FCC4CED1;
	Wed,  5 Feb 2025 14:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738764670;
	bh=MkBrW83E83JxBCXrhFthWYfVkvOxdS1yoeVlbf0Rmpo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=uzrnztJ6wVL4IFcAqlwATtZc1rxSoYPwnpX42GwlzzaYWInOXGiNCyKBQsbftt0In
	 hvdhUFhgBb8rZutvamDxr9Xx6d+c8FXi6tEaqQZGeAvQRCmyKXJ1XqFuCFxMD2XJlJ
	 TG/qWiL/wtQkkBnI4mt/kOCWJpq4HazDpdOJXK5/fRjmhdtyoMKnV1FFbz3Q4vg0mb
	 EclE5jlfD5KYm6Fdo9vlExlx9iSegZ/jRVA6UFPeWCfWBTowo4V6OEvcDLTbYNg8BN
	 ngedUOcIiGF9RACnYdaNPC4PWaJmvV2YiK6L7T2o7lEyct30nCMOO1qZuB+Nt6um/c
	 6xD+AFC5DCiDw==
Message-ID: <2f98596d5403080ac3d2757482207d84ce1502a9.camel@kernel.org>
Subject: Re: [RESEND PATCH][next] fs: nfs: acl: Avoid
 -Wflex-array-member-not-at-end warning
From: Jeff Layton <jlayton@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Chuck Lever	
 <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga Kornievskaia	
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>,  Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
 <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Date: Wed, 05 Feb 2025 09:11:08 -0500
In-Reply-To: <Z6GDiLZo5u4CqxBr@kspp>
References: <Z6GDiLZo5u4CqxBr@kspp>
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

On Tue, 2025-02-04 at 13:33 +1030, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
>=20
> So, in order to avoid ending up with a flexible-array member in the
> middle of other structs, we use the `struct_group_tagged()` helper
> to create a new tagged `struct posix_acl_hdr`. This structure
> groups together all the members of the flexible `struct posix_acl`
> except the flexible array.
>=20
> As a result, the array is effectively separated from the rest of the
> members without modifying the memory layout of the flexible structure.
> We then change the type of the middle struct member currently causing
> trouble from `struct posix_acl` to `struct posix_acl_hdr`.
>=20
> We also want to ensure that when new members need to be added to the
> flexible structure, they are always included within the newly created
> tagged struct. For this, we use `static_assert()`. This ensures that the
> memory layout for both the flexible structure and the new tagged struct
> is the same after any changes.
>=20
> This approach avoids having to implement `struct posix_acl_hdr` as a
> completely separate structure, thus preventing having to maintain two
> independent but basically identical structures, closing the door to
> potential bugs in the future.
>=20
> We also use `container_of()` whenever we need to retrieve a pointer to
> the flexible structure, through which we can access the flexible-array
> member, if necessary.
>=20
> So, with these changes, fix the following warning:
>=20
> fs/nfs_common/nfsacl.c:45:26: warning: structure containing a flexible ar=
ray member is not at the end of another structure [-Wflex-array-member-not-=
at-end]
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/nfs_common/nfsacl.c    |  8 +++++---
>  include/linux/posix_acl.h | 11 ++++++++---
>  2 files changed, 13 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
> index ea382b75b26c..e2eaac14fd8e 100644
> --- a/fs/nfs_common/nfsacl.c
> +++ b/fs/nfs_common/nfsacl.c
> @@ -42,7 +42,7 @@ struct nfsacl_encode_desc {
>  };
> =20
>  struct nfsacl_simple_acl {
> -	struct posix_acl acl;
> +	struct posix_acl_hdr acl;
>  	struct posix_acl_entry ace[4];
>  };
> =20
> @@ -112,7 +112,8 @@ int nfsacl_encode(struct xdr_buf *buf, unsigned int b=
ase, struct inode *inode,
>  	    xdr_encode_word(buf, base, entries))
>  		return -EINVAL;
>  	if (encode_entries && acl && acl->a_count =3D=3D 3) {
> -		struct posix_acl *acl2 =3D &aclbuf.acl;
> +		struct posix_acl *acl2 =3D
> +			container_of(&aclbuf.acl, struct posix_acl, hdr);
> =20
>  		/* Avoid the use of posix_acl_alloc().  nfsacl_encode() is
>  		 * invoked in contexts where a memory allocation failure is
> @@ -177,7 +178,8 @@ bool nfs_stream_encode_acl(struct xdr_stream *xdr, st=
ruct inode *inode,
>  		return false;
> =20
>  	if (encode_entries && acl && acl->a_count =3D=3D 3) {
> -		struct posix_acl *acl2 =3D &aclbuf.acl;
> +		struct posix_acl *acl2 =3D
> +			container_of(&aclbuf.acl, struct posix_acl, hdr);
> =20
>  		/* Avoid the use of posix_acl_alloc().  nfsacl_encode() is
>  		 * invoked in contexts where a memory allocation failure is
> diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
> index e2d47eb1a7f3..62d497763e25 100644
> --- a/include/linux/posix_acl.h
> +++ b/include/linux/posix_acl.h
> @@ -27,11 +27,16 @@ struct posix_acl_entry {
>  };
> =20
>  struct posix_acl {
> -	refcount_t		a_refcount;
> -	unsigned int		a_count;
> -	struct rcu_head		a_rcu;
> +	/* New members MUST be added within the struct_group() macro below. */
> +	struct_group_tagged(posix_acl_hdr, hdr,
> +		refcount_t		a_refcount;
> +		unsigned int		a_count;
> +		struct rcu_head		a_rcu;
> +	);
>  	struct posix_acl_entry	a_entries[] __counted_by(a_count);
>  };
> +static_assert(offsetof(struct posix_acl, a_entries) =3D=3D sizeof(struct=
 posix_acl_hdr),
> +	      "struct member likely outside of struct_group_tagged()");
> =20
>  #define FOREACH_ACL_ENTRY(pa, acl, pe) \
>  	for(pa=3D(acl)->a_entries, pe=3Dpa+(acl)->a_count; pa<pe; pa++)

Acked-by: Jeff Layton <jlayton@kernel.org>

