Return-Path: <linux-nfs+bounces-15152-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BA2BD0116
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 13:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8443BA193
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 11:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BE325F78F;
	Sun, 12 Oct 2025 11:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JK/BoYr/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB438235044;
	Sun, 12 Oct 2025 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760267548; cv=none; b=FeC6KlGxw1RtAWsUXKaOmPuo66SksOijm9RRsfEmzl/9uYhAoMHrsle0qx8aIRrbxWce/6/WEMLJkVxMVI8Zx18Jxyfu2D04Q1j1NBI4vilQVekT7Pb5DST6IxjjeL5KjGfaEk+UKSW3n2ul4OtrjfW63gA1v2/RnVyjVEsZT/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760267548; c=relaxed/simple;
	bh=EZaRS19u1FKtFIF159CPTOehXgeCjtHpij0XIZ0Oo+A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TjWaWOzK9VqYICsZNzooqwGD8fJWSkSjGcokmX2/L22LC2Mgs7BB97Y08LTml1eD7+axRJdTWUAEhrcMs7e0TPsgBY5xoqXjVodqocd+zP8SmrpBAC7wARwWYtgcHlbDrQg3/YM0yER/1cv3qD7NhaPSok/7+NX8xlV9F6IbTyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JK/BoYr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C716C4CEE7;
	Sun, 12 Oct 2025 11:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760267548;
	bh=EZaRS19u1FKtFIF159CPTOehXgeCjtHpij0XIZ0Oo+A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JK/BoYr/igof8FPokpFkPkw7Z3bRe0q357NJXL6x1+X/35+WbQ5KYwOl4Bf5UFwg4
	 gYflikdvcdH6tNHIvQm704A9yEPZCAqDCHi/omz8EC5SxvCZFO/4MASr9t8Chdb06e
	 Ucd3Zz72H5KYvOIByBSAiC6YakKubvOAxN+Tvoqc4dOxajs7aQGDKVeszHXd+mXLLZ
	 fvF+RpdUwlN/IXYv9dw4pkNHi7p2TkKefr7kBnqQaehWgc21yxhsRDfhhjJhC24Nq8
	 VmR+wpRVS1P2II0UblO5SGizZqLQmZiV2aY35HxWky53+jZEGVHX68YNSBKBm+Os0/
	 pydpBQBzHJ+dw==
Message-ID: <582606e8b6699aeacae8ae4dcf9f990b4c0b5210.camel@kernel.org>
Subject: Re: [PATCH] nfsd: Use MD5 library instead of crypto_shash
From: Jeff Layton <jlayton@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>, linux-nfs@vger.kernel.org, Chuck
 Lever	 <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-crypto@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Sun, 12 Oct 2025 07:12:26 -0400
In-Reply-To: <20251011185225.155625-1-ebiggers@kernel.org>
References: <20251011185225.155625-1-ebiggers@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-10-11 at 11:52 -0700, Eric Biggers wrote:
> Update NFSD's support for "legacy client tracking" (which uses MD5) to
> use the MD5 library instead of crypto_shash.  This has several benefits:
>=20
> - Simpler code.  Notably, much of the error-handling code is no longer
>   needed, since the library functions can't fail.
>=20
> - Improved performance due to reduced overhead.  A microbenchmark of
>   nfs4_make_rec_clidname() shows a speedup from 1455 cycles to 425.
>=20
> - The MD5 code can now safely be built as a loadable module when nfsd is
>   built as a loadable module.  (Previously, nfsd forced the MD5 code to
>   built-in, presumably to work around the unreliablity of the name-based
>   loading.)  Thus, select MD5 from the tristate option NFSD if
>   NFSD_LEGACY_CLIENT_TRACKING, instead of from the bool option NFSD_V4.
>=20
> To preserve the existing behavior of legacy client tracking support
> being disabled when the kernel is booted with "fips=3D1", make
> nfsd4_legacy_tracking_init() return an error if fips_enabled.  I don't
> know if this is truly needed, but it preserves the existing behavior.
>=20

FIPS is pretty draconian about algorithms, AIUI. We're not using MD5 in
a cryptographically significant way here, but the FIPS gods won't bless
a kernel that uses MD5 at all, so I think it is needed.


> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  fs/nfsd/Kconfig       |  3 +-
>  fs/nfsd/nfs4recover.c | 82 ++++++++-----------------------------------
>  2 files changed, 16 insertions(+), 69 deletions(-)
>=20
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index e134dce45e350..380a4caa33a73 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -3,10 +3,11 @@ config NFSD
>  	tristate "NFS server support"
>  	depends on INET
>  	depends on FILE_LOCKING
>  	depends on FSNOTIFY
>  	select CRC32
> +	select CRYPTO_LIB_MD5 if NFSD_LEGACY_CLIENT_TRACKING
>  	select CRYPTO_LIB_SHA256 if NFSD_V4
>  	select LOCKD
>  	select SUNRPC
>  	select EXPORTFS
>  	select NFS_COMMON
> @@ -75,12 +76,10 @@ config NFSD_V3_ACL
>  config NFSD_V4
>  	bool "NFS server support for NFS version 4"
>  	depends on NFSD && PROC_FS
>  	select FS_POSIX_ACL
>  	select RPCSEC_GSS_KRB5
> -	select CRYPTO
> -	select CRYPTO_MD5
>  	select GRACE_PERIOD
>  	select NFS_V4_2_SSC_HELPER if NFS_V4_2
>  	help
>  	  This option enables support in your system's NFS server for
>  	  version 4 of the NFS protocol (RFC 3530).
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index e2b9472e5c78c..dbc0aecef95e3 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -30,13 +30,14 @@
>  *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
>  *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>  *
>  */
> =20
> -#include <crypto/hash.h>
> +#include <crypto/md5.h>
>  #include <crypto/sha2.h>
>  #include <linux/file.h>
> +#include <linux/fips.h>
>  #include <linux/slab.h>
>  #include <linux/namei.h>
>  #include <linux/sched.h>
>  #include <linux/fs.h>
>  #include <linux/module.h>
> @@ -90,61 +91,22 @@ static void
>  nfs4_reset_creds(const struct cred *original)
>  {
>  	put_cred(revert_creds(original));
>  }
> =20
> -static int
> +static void
>  nfs4_make_rec_clidname(char dname[HEXDIR_LEN], const struct xdr_netobj *=
clname)
>  {
>  	u8 digest[MD5_DIGEST_SIZE];
> -	struct crypto_shash *tfm;
> -	int status;
> =20
>  	dprintk("NFSD: nfs4_make_rec_clidname for %.*s\n",
>  			clname->len, clname->data);
> -	tfm =3D crypto_alloc_shash("md5", 0, 0);
> -	if (IS_ERR(tfm)) {
> -		status =3D PTR_ERR(tfm);
> -		goto out_no_tfm;
> -	}
> =20
> -	status =3D crypto_shash_tfm_digest(tfm, clname->data, clname->len,
> -					 digest);
> -	if (status)
> -		goto out;
> +	md5(clname->data, clname->len, digest);
> =20
>  	static_assert(HEXDIR_LEN =3D=3D 2 * MD5_DIGEST_SIZE + 1);
>  	sprintf(dname, "%*phN", MD5_DIGEST_SIZE, digest);
> -
> -	status =3D 0;
> -out:
> -	crypto_free_shash(tfm);
> -out_no_tfm:
> -	return status;
> -}
> -
> -/*
> - * If we had an error generating the recdir name for the legacy tracker
> - * then warn the admin. If the error doesn't appear to be transient,
> - * then disable recovery tracking.
> - */
> -static void
> -legacy_recdir_name_error(struct nfs4_client *clp, int error)
> -{
> -	printk(KERN_ERR "NFSD: unable to generate recoverydir "
> -			"name (%d).\n", error);
> -
> -	/*
> -	 * if the algorithm just doesn't exist, then disable the recovery
> -	 * tracker altogether. The crypto libs will generally return this if
> -	 * FIPS is enabled as well.
> -	 */
> -	if (error =3D=3D -ENOENT) {
> -		printk(KERN_ERR "NFSD: disabling legacy clientid tracking. "
> -			"Reboot recovery will not function correctly!\n");
> -		nfsd4_client_tracking_exit(clp->net);
> -	}
>  }
> =20
>  static void
>  __nfsd4_create_reclaim_record_grace(struct nfs4_client *clp,
>  		const char *dname, int len, struct nfsd_net *nn)
> @@ -180,13 +142,11 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
>  	if (test_and_set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
>  		return;
>  	if (!nn->rec_file)
>  		return;
> =20
> -	status =3D nfs4_make_rec_clidname(dname, &clp->cl_name);
> -	if (status)
> -		return legacy_recdir_name_error(clp, status);
> +	nfs4_make_rec_clidname(dname, &clp->cl_name);
> =20
>  	status =3D nfs4_save_creds(&original_cred);
>  	if (status < 0)
>  		return;
> =20
> @@ -374,13 +334,11 @@ nfsd4_remove_clid_dir(struct nfs4_client *clp)
>  	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
> =20
>  	if (!nn->rec_file || !test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
>  		return;
> =20
> -	status =3D nfs4_make_rec_clidname(dname, &clp->cl_name);
> -	if (status)
> -		return legacy_recdir_name_error(clp, status);
> +	nfs4_make_rec_clidname(dname, &clp->cl_name);
> =20
>  	status =3D mnt_want_write_file(nn->rec_file);
>  	if (status)
>  		goto out;
>  	clear_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
> @@ -601,10 +559,15 @@ nfsd4_legacy_tracking_init(struct net *net)
>  	if (net !=3D &init_net) {
>  		pr_warn("NFSD: attempt to initialize legacy client tracking in a conta=
iner ignored.\n");
>  		return -EINVAL;
>  	}
> =20
> +	if (fips_enabled) {
> +		pr_warn("NFSD: legacy client tracking is disabled due to FIPS\n");
> +		return -EINVAL;
> +	}
> +
>  	status =3D nfs4_legacy_state_init(net);
>  	if (status)
>  		return status;
> =20
>  	status =3D nfsd4_load_reboot_recovery_data(net);
> @@ -657,25 +620,20 @@ nfs4_recoverydir(void)
>  }
> =20
>  static int
>  nfsd4_check_legacy_client(struct nfs4_client *clp)
>  {
> -	int status;
>  	char dname[HEXDIR_LEN];
>  	struct nfs4_client_reclaim *crp;
>  	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
>  	struct xdr_netobj name;
> =20
>  	/* did we already find that this client is stable? */
>  	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
>  		return 0;
> =20
> -	status =3D nfs4_make_rec_clidname(dname, &clp->cl_name);
> -	if (status) {
> -		legacy_recdir_name_error(clp, status);
> -		return status;
> -	}
> +	nfs4_make_rec_clidname(dname, &clp->cl_name);
> =20
>  	/* look for it in the reclaim hashtable otherwise */
>  	name.data =3D kmemdup(dname, HEXDIR_LEN, GFP_KERNEL);
>  	if (!name.data) {
>  		dprintk("%s: failed to allocate memory for name.data!\n",
> @@ -1264,17 +1222,14 @@ nfsd4_cld_check(struct nfs4_client *clp)
>  	if (crp)
>  		goto found;
> =20
>  #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  	if (nn->cld_net->cn_has_legacy) {
> -		int status;
>  		char dname[HEXDIR_LEN];
>  		struct xdr_netobj name;
> =20
> -		status =3D nfs4_make_rec_clidname(dname, &clp->cl_name);
> -		if (status)
> -			return -ENOENT;
> +		nfs4_make_rec_clidname(dname, &clp->cl_name);
> =20
>  		name.data =3D kmemdup(dname, HEXDIR_LEN, GFP_KERNEL);
>  		if (!name.data) {
>  			dprintk("%s: failed to allocate memory for name.data!\n",
>  				__func__);
> @@ -1315,15 +1270,12 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
> =20
>  #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  	if (cn->cn_has_legacy) {
>  		struct xdr_netobj name;
>  		char dname[HEXDIR_LEN];
> -		int status;
> =20
> -		status =3D nfs4_make_rec_clidname(dname, &clp->cl_name);
> -		if (status)
> -			return -ENOENT;
> +		nfs4_make_rec_clidname(dname, &clp->cl_name);
> =20
>  		name.data =3D kmemdup(dname, HEXDIR_LEN, GFP_KERNEL);
>  		if (!name.data) {
>  			dprintk("%s: failed to allocate memory for name.data\n",
>  					__func__);
> @@ -1692,15 +1644,11 @@ nfsd4_cltrack_legacy_recdir(const struct xdr_neto=
bj *name)
>  		/* just return nothing if output will be truncated */
>  		kfree(result);
>  		return NULL;
>  	}
> =20
> -	copied =3D nfs4_make_rec_clidname(result + copied, name);
> -	if (copied) {
> -		kfree(result);
> -		return NULL;
> -	}
> +	nfs4_make_rec_clidname(result + copied, name);
> =20
>  	return result;
>  }
> =20
>  static char *
>=20
> base-commit: 0739473694c4878513031006829f1030ec850bc2

Seems fine to me and I like the diffstat. Looking forward to eventually
removing this code altogether.

Acked-by: Jeff Layton <jlayton@kernel.org>

