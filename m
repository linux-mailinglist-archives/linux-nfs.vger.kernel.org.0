Return-Path: <linux-nfs+bounces-11332-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDAAA9FA18
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 22:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D1C07AB4E0
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 20:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BABE296D3B;
	Mon, 28 Apr 2025 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTYYIrsd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBD929614D
	for <linux-nfs@vger.kernel.org>; Mon, 28 Apr 2025 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745870550; cv=none; b=eH6GiEwe41fSEEdoDqVp/HNEzcSfGbMyHljQXwXQcfWQk0559JZ0NyGhIW+rjnX4XJMYKs3Albvm4UOSKsISeZLCP/0H9lOOIMHKvg6HNGv3QSmJa03QYZXlTeY9vA0Uq6Cblox0YWI5ZpgKTYHHhEe7nhYOomhtdMjHhi5NOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745870550; c=relaxed/simple;
	bh=TRHjfoVVbTzwvQiyIBOWCgSgYYz89iEicR2LGZsStAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+DcvGkvc4tM4GjfzI76mSfif3A+/kjTwzQMt/bltUIE7tTl76ry3RZi7NHpoVyuLs84SwEePNWdWu6j8S4dFyb36FoUb6dtf8OKgB9sMWecdhRmIN1LmBUBbxgZpbVS7VkRwpzS+mhU1TrmsIGD9A9BcrOuvYkStB4brwJ2OaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTYYIrsd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745870547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lr2u5Wrgfxw8d3Spm0msHMYSV0gDc4y6YXqDnDCvPLo=;
	b=bTYYIrsdvfK9jU/8wVhRCt3nakhjB6BxeljjrNeKiLk20lHNwpkU5cIKz5KQMO1dPCZUe+
	kDnzPmLZnPek/HV26StLFxM/TxVZ9KgaKc51+8GNgNqjk9k4OzWvWnh0zOeE0LPNbBa74I
	zhz61ANach2JyBAE39p9JOShiANZ14s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-JUxUF9lOMjekSkXbExC_OA-1; Mon,
 28 Apr 2025 16:02:24 -0400
X-MC-Unique: JUxUF9lOMjekSkXbExC_OA-1
X-Mimecast-MFC-AGG-ID: JUxUF9lOMjekSkXbExC_OA_1745870542
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 688271800876;
	Mon, 28 Apr 2025 20:02:22 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.65.122])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8B3D19560AA;
	Mon, 28 Apr 2025 20:02:21 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 167CF3447D7; Mon, 28 Apr 2025 16:02:20 -0400 (EDT)
Date: Mon, 28 Apr 2025 16:02:20 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Eric Biggers <ebiggers@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Jeff Layton <jlayton@kernel.org>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: use SHA-256 library API instead of crypto_shash API
Message-ID: <aA_ezENy3YmMUzsU@aion>
References: <20250428193658.861896-1-ebiggers@kernel.org>
 <7150babe-3700-4297-a058-f96514424e8b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7150babe-3700-4297-a058-f96514424e8b@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, 28 Apr 2025, Chuck Lever wrote:

> On 4/28/25 3:36 PM, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > This user of SHA-256 does not support any other algorithm, so the
> > crypto_shash abstraction provides no value.  Just use the SHA-256
> > library API instead, which is much simpler and easier to use.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  fs/nfsd/Kconfig       |  2 +-
> >  fs/nfsd/nfs4recover.c | 57 ++++++++-----------------------------------
> >  2 files changed, 11 insertions(+), 48 deletions(-)
> > 
> > diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> > index 731a88f6313eb..879e0b104d1c8 100644
> > --- a/fs/nfsd/Kconfig
> > +++ b/fs/nfsd/Kconfig
> > @@ -75,12 +75,12 @@ config NFSD_V4
> >  	bool "NFS server support for NFS version 4"
> >  	depends on NFSD && PROC_FS
> >  	select FS_POSIX_ACL
> >  	select RPCSEC_GSS_KRB5
> >  	select CRYPTO
> > +	select CRYPTO_LIB_SHA256
> >  	select CRYPTO_MD5
> > -	select CRYPTO_SHA256
> >  	select GRACE_PERIOD
> >  	select NFS_V4_2_SSC_HELPER if NFS_V4_2
> >  	help
> >  	  This option enables support in your system's NFS server for
> >  	  version 4 of the NFS protocol (RFC 3530).
> > diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> > index acde3edab7336..c3840793261be 100644
> > --- a/fs/nfsd/nfs4recover.c
> > +++ b/fs/nfsd/nfs4recover.c
> > @@ -31,10 +31,11 @@
> >  *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> >  *
> >  */
> >  
> >  #include <crypto/hash.h>
> > +#include <crypto/sha2.h>
> >  #include <linux/file.h>
> >  #include <linux/slab.h>
> >  #include <linux/namei.h>
> >  #include <linux/sched.h>
> >  #include <linux/fs.h>
> > @@ -735,11 +736,10 @@ static const struct nfsd4_client_tracking_ops nfsd4_legacy_tracking_ops = {
> >  struct cld_net {
> >  	struct rpc_pipe		*cn_pipe;
> >  	spinlock_t		 cn_lock;
> >  	struct list_head	 cn_list;
> >  	unsigned int		 cn_xid;
> > -	struct crypto_shash	*cn_tfm;
> >  #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
> >  	bool			 cn_has_legacy;
> >  #endif
> >  };
> >  
> > @@ -1061,12 +1061,10 @@ nfsd4_remove_cld_pipe(struct net *net)
> >  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> >  	struct cld_net *cn = nn->cld_net;
> >  
> >  	nfsd4_cld_unregister_net(net, cn->cn_pipe);
> >  	rpc_destroy_pipe_data(cn->cn_pipe);
> > -	if (cn->cn_tfm)
> > -		crypto_free_shash(cn->cn_tfm);
> >  	kfree(nn->cld_net);
> >  	nn->cld_net = NULL;
> >  }
> >  
> >  static struct cld_upcall *
> > @@ -1156,12 +1154,10 @@ nfsd4_cld_create_v2(struct nfs4_client *clp)
> >  	int ret;
> >  	struct cld_upcall *cup;
> >  	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
> >  	struct cld_net *cn = nn->cld_net;
> >  	struct cld_msg_v2 *cmsg;
> > -	struct crypto_shash *tfm = cn->cn_tfm;
> > -	struct xdr_netobj cksum;
> >  	char *principal = NULL;
> >  
> >  	/* Don't upcall if it's already stored */
> >  	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
> >  		return;
> > @@ -1180,36 +1176,22 @@ nfsd4_cld_create_v2(struct nfs4_client *clp)
> >  	if (clp->cl_cred.cr_raw_principal)
> >  		principal = clp->cl_cred.cr_raw_principal;
> >  	else if (clp->cl_cred.cr_principal)
> >  		principal = clp->cl_cred.cr_principal;
> >  	if (principal) {
> > -		cksum.len = crypto_shash_digestsize(tfm);
> > -		cksum.data = kmalloc(cksum.len, GFP_KERNEL);
> > -		if (cksum.data == NULL) {
> > -			ret = -ENOMEM;
> > -			goto out;
> > -		}
> > -		ret = crypto_shash_tfm_digest(tfm, principal, strlen(principal),
> > -					      cksum.data);
> > -		if (ret) {
> > -			kfree(cksum.data);
> > -			goto out;
> > -		}
> > -		cmsg->cm_u.cm_clntinfo.cc_princhash.cp_len = cksum.len;
> > -		memcpy(cmsg->cm_u.cm_clntinfo.cc_princhash.cp_data,
> > -		       cksum.data, cksum.len);
> > -		kfree(cksum.data);
> > +		sha256(principal, strlen(principal),
> > +		       cmsg->cm_u.cm_clntinfo.cc_princhash.cp_data);
> > +		cmsg->cm_u.cm_clntinfo.cc_princhash.cp_len = SHA256_DIGEST_SIZE;
> >  	} else
> >  		cmsg->cm_u.cm_clntinfo.cc_princhash.cp_len = 0;
> >  
> >  	ret = cld_pipe_upcall(cn->cn_pipe, cmsg, nn);
> >  	if (!ret) {
> >  		ret = cmsg->cm_status;
> >  		set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
> >  	}
> >  
> > -out:
> >  	free_cld_upcall(cup);
> >  out_err:
> >  	if (ret)
> >  		pr_err("NFSD: Unable to create client record on stable storage: %d\n",
> >  				ret);
> > @@ -1347,13 +1329,10 @@ static int
> >  nfsd4_cld_check_v2(struct nfs4_client *clp)
> >  {
> >  	struct nfs4_client_reclaim *crp;
> >  	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
> >  	struct cld_net *cn = nn->cld_net;
> > -	int status;
> > -	struct crypto_shash *tfm = cn->cn_tfm;
> > -	struct xdr_netobj cksum;
> >  	char *principal = NULL;
> >  
> >  	/* did we already find that this client is stable? */
> >  	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
> >  		return 0;
> > @@ -1365,10 +1344,11 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
> >  
> >  #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
> >  	if (cn->cn_has_legacy) {
> >  		struct xdr_netobj name;
> >  		char dname[HEXDIR_LEN];
> > +		int status;
> >  
> >  		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
> >  		if (status)
> >  			return -ENOENT;
> >  
> > @@ -1387,32 +1367,22 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
> >  	}
> >  #endif
> >  	return -ENOENT;
> >  found:
> >  	if (crp->cr_princhash.len) {
> > +		u8 digest[SHA256_DIGEST_SIZE];
> > +
> >  		if (clp->cl_cred.cr_raw_principal)
> >  			principal = clp->cl_cred.cr_raw_principal;
> >  		else if (clp->cl_cred.cr_principal)
> >  			principal = clp->cl_cred.cr_principal;
> >  		if (principal == NULL)
> >  			return -ENOENT;
> > -		cksum.len = crypto_shash_digestsize(tfm);
> > -		cksum.data = kmalloc(cksum.len, GFP_KERNEL);
> > -		if (cksum.data == NULL)
> > -			return -ENOENT;
> > -		status = crypto_shash_tfm_digest(tfm, principal,
> > -						 strlen(principal), cksum.data);
> > -		if (status) {
> > -			kfree(cksum.data);
> > +		sha256(principal, strlen(principal), digest);
> > +		if (memcmp(crp->cr_princhash.data, digest,
> > +				crp->cr_princhash.len))
> >  			return -ENOENT;
> > -		}
> > -		if (memcmp(crp->cr_princhash.data, cksum.data,
> > -				crp->cr_princhash.len)) {
> > -			kfree(cksum.data);
> > -			return -ENOENT;
> > -		}
> > -		kfree(cksum.data);
> >  	}
> >  	crp->cr_clp = clp;
> >  	return 0;
> >  }
> >  
> > @@ -1588,11 +1558,10 @@ nfsd4_cld_tracking_init(struct net *net)
> >  {
> >  	int status;
> >  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> >  	bool running;
> >  	int retries = 10;
> > -	struct crypto_shash *tfm;
> >  
> >  	status = nfs4_cld_state_init(net);
> >  	if (status)
> >  		return status;
> >  
> > @@ -1613,16 +1582,10 @@ nfsd4_cld_tracking_init(struct net *net)
> >  
> >  	if (!running) {
> >  		status = -ETIMEDOUT;
> >  		goto err_remove;
> >  	}
> > -	tfm = crypto_alloc_shash("sha256", 0, 0);
> > -	if (IS_ERR(tfm)) {
> > -		status = PTR_ERR(tfm);
> > -		goto err_remove;
> > -	}
> > -	nn->cld_net->cn_tfm = tfm;
> >  
> >  	status = nfsd4_cld_get_version(nn);
> >  	if (status == -EOPNOTSUPP)
> >  		pr_warn("NFSD: nfsdcld GetVersion upcall failed. Please upgrade nfsdcld.\n");
> >  
> > 
> > base-commit: 33035b665157558254b3c21c3f049fd728e72368
> 
> Make sense to me. Scott, can I get an R-b: from you?

Reviewed-by: Scott Mayhew <smayhew@redhat.com>

-Scott
> 
> -- 
> Chuck Lever
> 


