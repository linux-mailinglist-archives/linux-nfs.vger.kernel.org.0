Return-Path: <linux-nfs+bounces-11539-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF50AAD191
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 01:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975013BF967
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 23:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8392221B182;
	Tue,  6 May 2025 23:32:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF81946DF;
	Tue,  6 May 2025 23:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746574329; cv=none; b=qaEKvjcoCioD4TWVAXDKb+iKV27h/fWiamJ97sgFVAjGXrZ8izPdtr01X2xFtxLudp68/knyyf1SnhJJ83qJpnz7Ji6CflUFbl9sntnJIy5BoxkhPZ8y8VIxwdIScKlozemo0FTKcAks1Rx9F0rJoKtBMJhg+jGU+NzOW42feA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746574329; c=relaxed/simple;
	bh=EjYpyGTdyfHof6vjooW7NmR45Eqt6Kg37CzQ3jVtnY4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hyUYzMhw+aUY3BpozgXz4Vmcj4dGIJoKt6N5575iv8kvAM+pws0XaBybGCs33v/tXuVfDhtD8fWooypfQAC32AaiwJ9NxuFySD6U50bpUVDGWniIcHt/NvYDkplqju/SZr8jn2fFFjZxkeIytzG+VQRvpD0jUwJCG7k3vVkhnuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uCRlU-00FkjU-PZ;
	Tue, 06 May 2025 23:31:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] NFSD: Avoid multiple -Wflex-array-member-not-at-end
 warnings
In-reply-to: <aBp37ZXBJM09yAXp@kspp>
References: <aBp37ZXBJM09yAXp@kspp>
Date: Wed, 07 May 2025 09:31:56 +1000
Message-id: <174657431631.3924073.6654014165534485350@noble.neil.brown.name>

On Wed, 07 May 2025, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
>=20
> Move the conflicting declaration to the end of the corresponding
> structures. Notice that `struct knfsd_fh` is a flexible structure --a
> structure that contains a flexible-array member.

I don't really like this solution.

struct knfsd_fh has a fixed size determined by NFS4_FHSIZE.
The fact that fh_fsid is "flexible" doesn't mean it is unlimited in
size.  So moving it to the end of other structures is silencing a
warning but leaving the code as potentially confusing.

Maybe just make it
    u32 fh_fsid[4]; /* in practice the size varies but is always
                     * limited by fh_raw above
                     */

There are places was [0] [1] and [2] are explictly indexed, so size
needs to be atleast 3 else we invite warnings.  But maybe other memcpy
etc will trigger warnings anyway??
Maybe
    u32 fh_fsid[NFS4_FHSIZE/4-1];
That will always fit in the available space and we never use anywhere
close to that size.

I'd really rather use [] and have some way to tell the compiler that we
have the size under control and it doesn't need to worry.

Thanks,
NeilBrown


>=20
> Fix the following warnings:
>=20
> fs/nfsd/nfsfh.h:79:33: warning: structure containing a flexible array membe=
r is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/state.h:763:33: warning: structure containing a flexible array memb=
er is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/state.h:669:33: warning: structure containing a flexible array memb=
er is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/state.h:549:33: warning: structure containing a flexible array memb=
er is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/xdr4.h:705:33: warning: structure containing a flexible array membe=
r is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/xdr4.h:678:33: warning: structure containing a flexible array membe=
r is not at the end of another structure [-Wflex-array-member-not-at-end]
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/nfsd/nfsfh.h |  4 +++-
>  fs/nfsd/state.h | 12 +++++++++---
>  fs/nfsd/xdr4.h  |  8 ++++++--
>  3 files changed, 18 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 5103c2f4d225..bbee43674a2a 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -76,7 +76,6 @@ static inline ino_t u32_to_ino_t(__u32 uino)
>   * pre_mtime/post_version will be used to support wcc_attr's in NFSv3.
>   */
>  typedef struct svc_fh {
> -	struct knfsd_fh		fh_handle;	/* FH data */
>  	int			fh_maxsize;	/* max size for fh_handle */
>  	struct dentry *		fh_dentry;	/* validated dentry */
>  	struct svc_export *	fh_export;	/* export pointer */
> @@ -107,6 +106,9 @@ typedef struct svc_fh {
>  	/* Post-op attributes saved in fh_fill_post_attrs() */
>  	struct kstat		fh_post_attr;	/* full attrs after operation */
>  	u64			fh_post_change; /* nfsv4 change; see above */
> +
> +	/* Must be last -ends in a flexible-array member. */
> +	struct knfsd_fh		fh_handle;	/* FH data */
>  } svc_fh;
>  #define NFSD4_FH_FOREIGN (1<<0)
>  #define SET_FH_FLAG(c, f) ((c)->fh_flags |=3D (f))
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 1995bca158b8..ffd3fd8c34a0 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -546,9 +546,11 @@ struct nfs4_replay {
>  	__be32			rp_status;
>  	unsigned int		rp_buflen;
>  	char			*rp_buf;
> -	struct knfsd_fh		rp_openfh;
>  	int			rp_locked;
>  	char			rp_ibuf[NFSD4_REPLAY_ISIZE];
> +
> +	/* Must be last -ends in a flexible-array member. */
> +	struct knfsd_fh		rp_openfh;
>  };
> =20
>  struct nfs4_stateowner;
> @@ -666,12 +668,14 @@ struct nfs4_file {
>  	u32			fi_share_deny;
>  	struct nfsd_file	*fi_deleg_file;
>  	int			fi_delegees;
> -	struct knfsd_fh		fi_fhandle;
>  	bool			fi_had_conflict;
>  #ifdef CONFIG_NFSD_PNFS
>  	struct list_head	fi_lo_states;
>  	atomic_t		fi_lo_recalls;
>  #endif
> +
> +	/* Must be last -ends in a flexible-array member. */
> +	struct knfsd_fh		fi_fhandle;
>  };
> =20
>  /*
> @@ -760,9 +764,11 @@ struct nfsd4_blocked_lock {
>  	struct list_head	nbl_lru;
>  	time64_t		nbl_time;
>  	struct file_lock	nbl_lock;
> -	struct knfsd_fh		nbl_fh;
>  	struct nfsd4_callback	nbl_cb;
>  	struct kref		nbl_kref;
> +
> +	/* Must be last -ends in a flexible-array member. */
> +	struct knfsd_fh		nbl_fh;
>  };
> =20
>  struct nfsd4_compound_state;
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index aa2a356da784..e453ea5ebab6 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -675,11 +675,13 @@ struct nfsd4_cb_offload {
>  	struct nfsd42_write_res	co_res;
>  	__be32			co_nfserr;
>  	unsigned int		co_retries;
> -	struct knfsd_fh		co_fh;
> =20
>  	struct nfs4_sessionid	co_referring_sessionid;
>  	u32			co_referring_slotid;
>  	u32			co_referring_seqno;
> +
> +	/* Must be last -ends in a flexible-array member. */
> +	struct knfsd_fh		co_fh;
>  };
> =20
>  struct nfsd4_copy {
> @@ -702,7 +704,6 @@ struct nfsd4_copy {
>  	/* response */
>  	__be32			nfserr;
>  	struct nfsd42_write_res	cp_res;
> -	struct knfsd_fh		fh;
> =20
>  	/* offload callback */
>  	struct nfsd4_cb_offload	cp_cb_offload;
> @@ -723,6 +724,9 @@ struct nfsd4_copy {
>  	struct nfs_fh		c_fh;
>  	nfs4_stateid		stateid;
>  	struct nfsd_net		*cp_nn;
> +
> +	/* Must be last -ends in a flexible-array member. */
> +	struct knfsd_fh		fh;
>  };
> =20
>  static inline void nfsd4_copy_set_sync(struct nfsd4_copy *copy, bool sync)
> --=20
> 2.43.0
>=20
>=20


