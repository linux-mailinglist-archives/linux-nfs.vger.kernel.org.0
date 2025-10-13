Return-Path: <linux-nfs+bounces-15175-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2E6BD29C7
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 12:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1114F341A6D
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 10:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B3B302746;
	Mon, 13 Oct 2025 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYr6Vd18"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAD8302CB5
	for <linux-nfs@vger.kernel.org>; Mon, 13 Oct 2025 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352439; cv=none; b=lqfWwxQYjZvEc7p8GQZznK8RV7BAIMUfWApIH3eA70rFX0QpLD0EgTTTmB0s+aSml0YsWRfITIIw7yQhEDHn72S4b0VJMH754lZ/+6CYz6mvB2d51Y66K97uXRNoZ3AnJmJjWA2GTG5LcDxPmpsBmBxn0hQQ+Obv3Z7IwCWznww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352439; c=relaxed/simple;
	bh=gA8bxpzXimzb54QzB2Y7mbFZjhMeRaVdNxwhzfiamcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ln6ileADBjQvRHZgBSvMtv2Nbau7xhZjqnf7djHXYWIguMuSr6ZQUTq6FeHOQ7X4l1Ug+ICAJ8IMXudEj35IzUvHXVdpOLyTs9hxMuTuceZmjntfywSad8IreAKuDssHb6G0bhzlEJDC7i7RqWbrfN2ovlHOCxbJqQL6d0p5dq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYr6Vd18; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760352425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QdhIzPNclHC5KxVipZI/m9MoIOqoEgSAZQcCWFA6mvM=;
	b=RYr6Vd18sd4f/w6vwAOmLvl0v/LcSRQEgfFLAtQHbzBOMruhdDBtPa5MAaE8/0StLVOfH3
	7afRe/ABTBa69lj3p6gIxGCpR14EjsWIT1LbEJcQnSszjZuJRFcbAA7yRi2QB9nAbe9UZ3
	Sy7NHxYuYyraq2CFiioSgsEEa2RU7Wk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-DWM-IO-2P4mVBgX2LZtp4w-1; Mon,
 13 Oct 2025 06:47:02 -0400
X-MC-Unique: DWM-IO-2P4mVBgX2LZtp4w-1
X-Mimecast-MFC-AGG-ID: DWM-IO-2P4mVBgX2LZtp4w_1760352421
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB5941800372;
	Mon, 13 Oct 2025 10:47:00 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AB6E180141C;
	Mon, 13 Oct 2025 10:47:00 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 586194B1B7D; Mon, 13 Oct 2025 06:46:58 -0400 (EDT)
Date: Mon, 13 Oct 2025 06:46:58 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Use MD5 library instead of crypto_shash
Message-ID: <aOzYoh6hgXRGvTWV@aion>
References: <20251011185225.155625-1-ebiggers@kernel.org>
 <5f405581-e7e2-4e77-8044-0496db85aa27@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f405581-e7e2-4e77-8044-0496db85aa27@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sun, 12 Oct 2025, Chuck Lever wrote:

> On 10/11/25 2:52 PM, Eric Biggers wrote:
> > Update NFSD's support for "legacy client tracking" (which uses MD5) to
> > use the MD5 library instead of crypto_shash.  This has several benefits:
> > 
> > - Simpler code.  Notably, much of the error-handling code is no longer
> >   needed, since the library functions can't fail.
> > 
> > - Improved performance due to reduced overhead.  A microbenchmark of
> >   nfs4_make_rec_clidname() shows a speedup from 1455 cycles to 425.
> > 
> > - The MD5 code can now safely be built as a loadable module when nfsd is
> >   built as a loadable module.  (Previously, nfsd forced the MD5 code to
> >   built-in, presumably to work around the unreliablity of the name-based
> >   loading.)  Thus, select MD5 from the tristate option NFSD if
> >   NFSD_LEGACY_CLIENT_TRACKING, instead of from the bool option NFSD_V4.
> > 
> > To preserve the existing behavior of legacy client tracking support
> > being disabled when the kernel is booted with "fips=1", make
> > nfsd4_legacy_tracking_init() return an error if fips_enabled.  I don't
> > know if this is truly needed, but it preserves the existing behavior.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> 
> No objection, but let's cross our t's and dot our i's. Scott, when you
> have recovered from bake-a-thon, can you have a look at this one?
> 
> Thanks!

Looks fine to me.

Reviewed-by: Scott Mayhew <smayhew@redhat.com>

I agree with Jeff - it would be nice to just remove the legacy tracking.
I'm guessing it's still used in smaller/embedded setups?  RHEL and Fedora
haven't had it enabled for years.  Looking at a few other distros... it's
not enabled in OpenSUSE Leap or Tumbleweed.  It's not enabled in Debian
Sid (but it is enabled in Trixie).

-Scott
> 
> 
> > ---
> >  fs/nfsd/Kconfig       |  3 +-
> >  fs/nfsd/nfs4recover.c | 82 ++++++++-----------------------------------
> >  2 files changed, 16 insertions(+), 69 deletions(-)
> > 
> > diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> > index e134dce45e350..380a4caa33a73 100644
> > --- a/fs/nfsd/Kconfig
> > +++ b/fs/nfsd/Kconfig
> > @@ -3,10 +3,11 @@ config NFSD
> >  	tristate "NFS server support"
> >  	depends on INET
> >  	depends on FILE_LOCKING
> >  	depends on FSNOTIFY
> >  	select CRC32
> > +	select CRYPTO_LIB_MD5 if NFSD_LEGACY_CLIENT_TRACKING
> >  	select CRYPTO_LIB_SHA256 if NFSD_V4
> >  	select LOCKD
> >  	select SUNRPC
> >  	select EXPORTFS
> >  	select NFS_COMMON
> > @@ -75,12 +76,10 @@ config NFSD_V3_ACL
> >  config NFSD_V4
> >  	bool "NFS server support for NFS version 4"
> >  	depends on NFSD && PROC_FS
> >  	select FS_POSIX_ACL
> >  	select RPCSEC_GSS_KRB5
> > -	select CRYPTO
> > -	select CRYPTO_MD5
> >  	select GRACE_PERIOD
> >  	select NFS_V4_2_SSC_HELPER if NFS_V4_2
> >  	help
> >  	  This option enables support in your system's NFS server for
> >  	  version 4 of the NFS protocol (RFC 3530).
> > diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> > index e2b9472e5c78c..dbc0aecef95e3 100644
> > --- a/fs/nfsd/nfs4recover.c
> > +++ b/fs/nfsd/nfs4recover.c
> > @@ -30,13 +30,14 @@
> >  *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
> >  *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> >  *
> >  */
> >  
> > -#include <crypto/hash.h>
> > +#include <crypto/md5.h>
> >  #include <crypto/sha2.h>
> >  #include <linux/file.h>
> > +#include <linux/fips.h>
> >  #include <linux/slab.h>
> >  #include <linux/namei.h>
> >  #include <linux/sched.h>
> >  #include <linux/fs.h>
> >  #include <linux/module.h>
> > @@ -90,61 +91,22 @@ static void
> >  nfs4_reset_creds(const struct cred *original)
> >  {
> >  	put_cred(revert_creds(original));
> >  }
> >  
> > -static int
> > +static void
> >  nfs4_make_rec_clidname(char dname[HEXDIR_LEN], const struct xdr_netobj *clname)
> >  {
> >  	u8 digest[MD5_DIGEST_SIZE];
> > -	struct crypto_shash *tfm;
> > -	int status;
> >  
> >  	dprintk("NFSD: nfs4_make_rec_clidname for %.*s\n",
> >  			clname->len, clname->data);
> > -	tfm = crypto_alloc_shash("md5", 0, 0);
> > -	if (IS_ERR(tfm)) {
> > -		status = PTR_ERR(tfm);
> > -		goto out_no_tfm;
> > -	}
> >  
> > -	status = crypto_shash_tfm_digest(tfm, clname->data, clname->len,
> > -					 digest);
> > -	if (status)
> > -		goto out;
> > +	md5(clname->data, clname->len, digest);
> >  
> >  	static_assert(HEXDIR_LEN == 2 * MD5_DIGEST_SIZE + 1);
> >  	sprintf(dname, "%*phN", MD5_DIGEST_SIZE, digest);
> > -
> > -	status = 0;
> > -out:
> > -	crypto_free_shash(tfm);
> > -out_no_tfm:
> > -	return status;
> > -}
> > -
> > -/*
> > - * If we had an error generating the recdir name for the legacy tracker
> > - * then warn the admin. If the error doesn't appear to be transient,
> > - * then disable recovery tracking.
> > - */
> > -static void
> > -legacy_recdir_name_error(struct nfs4_client *clp, int error)
> > -{
> > -	printk(KERN_ERR "NFSD: unable to generate recoverydir "
> > -			"name (%d).\n", error);
> > -
> > -	/*
> > -	 * if the algorithm just doesn't exist, then disable the recovery
> > -	 * tracker altogether. The crypto libs will generally return this if
> > -	 * FIPS is enabled as well.
> > -	 */
> > -	if (error == -ENOENT) {
> > -		printk(KERN_ERR "NFSD: disabling legacy clientid tracking. "
> > -			"Reboot recovery will not function correctly!\n");
> > -		nfsd4_client_tracking_exit(clp->net);
> > -	}
> >  }
> >  
> >  static void
> >  __nfsd4_create_reclaim_record_grace(struct nfs4_client *clp,
> >  		const char *dname, int len, struct nfsd_net *nn)
> > @@ -180,13 +142,11 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
> >  	if (test_and_set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
> >  		return;
> >  	if (!nn->rec_file)
> >  		return;
> >  
> > -	status = nfs4_make_rec_clidname(dname, &clp->cl_name);
> > -	if (status)
> > -		return legacy_recdir_name_error(clp, status);
> > +	nfs4_make_rec_clidname(dname, &clp->cl_name);
> >  
> >  	status = nfs4_save_creds(&original_cred);
> >  	if (status < 0)
> >  		return;
> >  
> > @@ -374,13 +334,11 @@ nfsd4_remove_clid_dir(struct nfs4_client *clp)
> >  	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
> >  
> >  	if (!nn->rec_file || !test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
> >  		return;
> >  
> > -	status = nfs4_make_rec_clidname(dname, &clp->cl_name);
> > -	if (status)
> > -		return legacy_recdir_name_error(clp, status);
> > +	nfs4_make_rec_clidname(dname, &clp->cl_name);
> >  
> >  	status = mnt_want_write_file(nn->rec_file);
> >  	if (status)
> >  		goto out;
> >  	clear_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
> > @@ -601,10 +559,15 @@ nfsd4_legacy_tracking_init(struct net *net)
> >  	if (net != &init_net) {
> >  		pr_warn("NFSD: attempt to initialize legacy client tracking in a container ignored.\n");
> >  		return -EINVAL;
> >  	}
> >  
> > +	if (fips_enabled) {
> > +		pr_warn("NFSD: legacy client tracking is disabled due to FIPS\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	status = nfs4_legacy_state_init(net);
> >  	if (status)
> >  		return status;
> >  
> >  	status = nfsd4_load_reboot_recovery_data(net);
> > @@ -657,25 +620,20 @@ nfs4_recoverydir(void)
> >  }
> >  
> >  static int
> >  nfsd4_check_legacy_client(struct nfs4_client *clp)
> >  {
> > -	int status;
> >  	char dname[HEXDIR_LEN];
> >  	struct nfs4_client_reclaim *crp;
> >  	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
> >  	struct xdr_netobj name;
> >  
> >  	/* did we already find that this client is stable? */
> >  	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
> >  		return 0;
> >  
> > -	status = nfs4_make_rec_clidname(dname, &clp->cl_name);
> > -	if (status) {
> > -		legacy_recdir_name_error(clp, status);
> > -		return status;
> > -	}
> > +	nfs4_make_rec_clidname(dname, &clp->cl_name);
> >  
> >  	/* look for it in the reclaim hashtable otherwise */
> >  	name.data = kmemdup(dname, HEXDIR_LEN, GFP_KERNEL);
> >  	if (!name.data) {
> >  		dprintk("%s: failed to allocate memory for name.data!\n",
> > @@ -1264,17 +1222,14 @@ nfsd4_cld_check(struct nfs4_client *clp)
> >  	if (crp)
> >  		goto found;
> >  
> >  #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
> >  	if (nn->cld_net->cn_has_legacy) {
> > -		int status;
> >  		char dname[HEXDIR_LEN];
> >  		struct xdr_netobj name;
> >  
> > -		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
> > -		if (status)
> > -			return -ENOENT;
> > +		nfs4_make_rec_clidname(dname, &clp->cl_name);
> >  
> >  		name.data = kmemdup(dname, HEXDIR_LEN, GFP_KERNEL);
> >  		if (!name.data) {
> >  			dprintk("%s: failed to allocate memory for name.data!\n",
> >  				__func__);
> > @@ -1315,15 +1270,12 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
> >  
> >  #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
> >  	if (cn->cn_has_legacy) {
> >  		struct xdr_netobj name;
> >  		char dname[HEXDIR_LEN];
> > -		int status;
> >  
> > -		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
> > -		if (status)
> > -			return -ENOENT;
> > +		nfs4_make_rec_clidname(dname, &clp->cl_name);
> >  
> >  		name.data = kmemdup(dname, HEXDIR_LEN, GFP_KERNEL);
> >  		if (!name.data) {
> >  			dprintk("%s: failed to allocate memory for name.data\n",
> >  					__func__);
> > @@ -1692,15 +1644,11 @@ nfsd4_cltrack_legacy_recdir(const struct xdr_netobj *name)
> >  		/* just return nothing if output will be truncated */
> >  		kfree(result);
> >  		return NULL;
> >  	}
> >  
> > -	copied = nfs4_make_rec_clidname(result + copied, name);
> > -	if (copied) {
> > -		kfree(result);
> > -		return NULL;
> > -	}
> > +	nfs4_make_rec_clidname(result + copied, name);
> >  
> >  	return result;
> >  }
> >  
> >  static char *
> > 
> > base-commit: 0739473694c4878513031006829f1030ec850bc2
> 
> 
> -- 
> Chuck Lever
> 


