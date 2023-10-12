Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCFC7C7A59
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 01:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443053AbjJLXWd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Oct 2023 19:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443006AbjJLXWc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Oct 2023 19:22:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83952A9;
        Thu, 12 Oct 2023 16:22:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 91C3D21220;
        Thu, 12 Oct 2023 23:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697152948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7jh/n4J9VYawVOoGC8PbIeXicDNe+C9ekZxTBgsYjvc=;
        b=Pr9hxM+ccVHAs+7Umz3gtcSLk/JZ5K1eXXXGh4olGRJiDNjUzu5UVjGs6uOF5kgp0z/hFL
        f7qWCLCu0qw8vI+BSHiaFRcnHcagQWZFGwdwAf6VSjrtnTtlTyDCL9vkBF2DM+Cxvx5Heu
        LV4lY4/TKb06MWMUZ2GA9jWqHO1mA0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697152948;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7jh/n4J9VYawVOoGC8PbIeXicDNe+C9ekZxTBgsYjvc=;
        b=cCop0C063lQCg5MOVE+kD2sOtSyjZ/nVxg4M913Jpd6dXb9xDNw6x7mj6Sb6SRRWO/wr0n
        XHme6PmNNBi/gqCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B692139ED;
        Thu, 12 Oct 2023 23:22:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F5gGMLF/KGUlCwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 12 Oct 2023 23:22:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH RFC] nfsd: new Kconfig option for legacy client tracking
In-reply-to: <20231012-nfsd-cltrack-v1-1-4e2e405b2b96@kernel.org>
References: <20231012-nfsd-cltrack-v1-1-4e2e405b2b96@kernel.org>
Date:   Fri, 13 Oct 2023 10:22:21 +1100
Message-id: <169715294196.26263.8724135216623551852@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -11.10
X-Spamd-Result: default: False [-11.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[8];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 13 Oct 2023, Jeff Layton wrote:
> We've had a number of attempts at different NFSv4 client tracking
> methods over the years, but now nfsdcld has emerged as the clear winner
> since the others (recoverydir and the usermodehelper upcall) are
> problematic.
>=20
> As a prelude to eventually removing support for these client tracking
> methods, add a new Kconfig option that enables them. Mark it deprecated
> and make it default to N.

This is an excellent idea - thanks.  I haven't looked closely at the
patch, but if it builds then I suspect it is correct.

Acked-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown



>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Now that we've really settled on nfsdcld being the way forward for
> NFSv4 client tracking, put the legacy methods under a new Kconfig option
> that defaults to off.
>=20
> This should make it easier to eventually deprecate this code and remove
> it in the future (maybe in v6.10 or so)?
> ---
>  fs/nfsd/Kconfig       | 16 +++++++++
>  fs/nfsd/nfs4recover.c | 97 +++++++++++++++++++++++++++++++++--------------=
----
>  fs/nfsd/nfsctl.c      |  6 ++++
>  3 files changed, 85 insertions(+), 34 deletions(-)
>=20
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index 43b88eaf0673..2d21fbf154c6 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -158,3 +158,19 @@ config NFSD_V4_SECURITY_LABEL
> =20
>  	If you do not wish to enable fine-grained security labels SELinux or
>  	Smack policies on NFSv4 files, say N.
> +
> +config NFSD_LEGACY_CLIENT_TRACKING
> +	bool "Support legacy NFSv4 client tracking methods (deprecated)"
> +	depends on NFSD_V4
> +	default n
> +	help
> +	  The NFSv4 server needs to store a small amount of information on
> +	  stable storage in order to handle state recovery after reboot. Most
> +	  modern deployments upcall to a userland daemon for this (nfsdcld),
> +	  but older NFS servers may store information directly in a
> +	  recoverydir, or spawn a process directly using a usermodehelper
> +	  upcall.
> +
> +	  These legacy client tracking methods have proven to be probelmatic
> +	  and will be removed in the future. Say Y here if you need support
> +	  for them in the interim.
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 3509e73abe1f..2c060e0b1604 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -66,6 +66,7 @@ struct nfsd4_client_tracking_ops {
>  static const struct nfsd4_client_tracking_ops nfsd4_cld_tracking_ops;
>  static const struct nfsd4_client_tracking_ops nfsd4_cld_tracking_ops_v2;
> =20
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  /* Globals */
>  static char user_recovery_dirname[PATH_MAX] =3D "/var/lib/nfs/v4recovery";
> =20
> @@ -720,6 +721,7 @@ static const struct nfsd4_client_tracking_ops nfsd4_leg=
acy_tracking_ops =3D {
>  	.version	=3D 1,
>  	.msglen		=3D 0,
>  };
> +#endif /* CONFIG_NFSD_LEGACY_CLIENT_TRACKING */
> =20
>  /* Globals */
>  #define NFSD_PIPE_DIR		"nfsd"
> @@ -731,8 +733,10 @@ struct cld_net {
>  	spinlock_t		 cn_lock;
>  	struct list_head	 cn_list;
>  	unsigned int		 cn_xid;
> -	bool			 cn_has_legacy;
>  	struct crypto_shash	*cn_tfm;
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
> +	bool			 cn_has_legacy;
> +#endif
>  };
> =20
>  struct cld_upcall {
> @@ -793,7 +797,6 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 =
__user *cmsg,
>  	uint8_t cmd, princhashlen;
>  	struct xdr_netobj name, princhash =3D { .len =3D 0, .data =3D NULL };
>  	uint16_t namelen;
> -	struct cld_net *cn =3D nn->cld_net;
> =20
>  	if (get_user(cmd, &cmsg->cm_cmd)) {
>  		dprintk("%s: error when copying cmd from userspace", __func__);
> @@ -833,11 +836,15 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v=
2 __user *cmsg,
>  				return PTR_ERR(name.data);
>  			name.len =3D namelen;
>  		}
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  		if (name.len > 5 && memcmp(name.data, "hash:", 5) =3D=3D 0) {
> +			struct cld_net *cn =3D nn->cld_net;
> +
>  			name.len =3D name.len - 5;
>  			memmove(name.data, name.data + 5, name.len);
>  			cn->cn_has_legacy =3D true;
>  		}
> +#endif
>  		if (!nfs4_client_to_reclaim(name, princhash, nn)) {
>  			kfree(name.data);
>  			kfree(princhash.data);
> @@ -1010,7 +1017,9 @@ __nfsd4_init_cld_pipe(struct net *net)
>  	}
> =20
>  	cn->cn_pipe->dentry =3D dentry;
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  	cn->cn_has_legacy =3D false;
> +#endif
>  	nn->cld_net =3D cn;
>  	return 0;
> =20
> @@ -1282,10 +1291,6 @@ nfsd4_cld_check(struct nfs4_client *clp)
>  {
>  	struct nfs4_client_reclaim *crp;
>  	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
> -	struct cld_net *cn =3D nn->cld_net;
> -	int status;
> -	char dname[HEXDIR_LEN];
> -	struct xdr_netobj name;
> =20
>  	/* did we already find that this client is stable? */
>  	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
> @@ -1296,7 +1301,12 @@ nfsd4_cld_check(struct nfs4_client *clp)
>  	if (crp)
>  		goto found;
> =20
> -	if (cn->cn_has_legacy) {
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
> +	if (nn->cld_net->cn_has_legacy) {
> +		int status;
> +		char dname[HEXDIR_LEN];
> +		struct xdr_netobj name;
> +
>  		status =3D nfs4_make_rec_clidname(dname, &clp->cl_name);
>  		if (status)
>  			return -ENOENT;
> @@ -1314,6 +1324,7 @@ nfsd4_cld_check(struct nfs4_client *clp)
>  			goto found;
> =20
>  	}
> +#endif
>  	return -ENOENT;
>  found:
>  	crp->cr_clp =3D clp;
> @@ -1327,8 +1338,6 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
>  	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
>  	struct cld_net *cn =3D nn->cld_net;
>  	int status;
> -	char dname[HEXDIR_LEN];
> -	struct xdr_netobj name;
>  	struct crypto_shash *tfm =3D cn->cn_tfm;
>  	struct xdr_netobj cksum;
>  	char *principal =3D NULL;
> @@ -1342,7 +1351,11 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
>  	if (crp)
>  		goto found;
> =20
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  	if (cn->cn_has_legacy) {
> +		struct xdr_netobj name;
> +		char dname[HEXDIR_LEN];
> +
>  		status =3D nfs4_make_rec_clidname(dname, &clp->cl_name);
>  		if (status)
>  			return -ENOENT;
> @@ -1360,6 +1373,7 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
>  			goto found;
> =20
>  	}
> +#endif
>  	return -ENOENT;
>  found:
>  	if (crp->cr_princhash.len) {
> @@ -1663,6 +1677,7 @@ static const struct nfsd4_client_tracking_ops nfsd4_c=
ld_tracking_ops_v2 =3D {
>  	.msglen		=3D sizeof(struct cld_msg_v2),
>  };
> =20
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  /* upcall via usermodehelper */
>  static char cltrack_prog[PATH_MAX] =3D "/sbin/nfsdcltrack";
>  module_param_string(cltrack_prog, cltrack_prog, sizeof(cltrack_prog),
> @@ -2007,28 +2022,10 @@ static const struct nfsd4_client_tracking_ops nfsd4=
_umh_tracking_ops =3D {
>  	.msglen		=3D 0,
>  };
> =20
> -int
> -nfsd4_client_tracking_init(struct net *net)
> +static inline int check_for_legacy_methods(int status, struct net *net)
>  {
> -	int status;
> -	struct path path;
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> -
> -	/* just run the init if it the method is already decided */
> -	if (nn->client_tracking_ops)
> -		goto do_init;
> -
> -	/* First, try to use nfsdcld */
> -	nn->client_tracking_ops =3D &nfsd4_cld_tracking_ops;
> -	status =3D nn->client_tracking_ops->init(net);
> -	if (!status)
> -		return status;
> -	if (status !=3D -ETIMEDOUT) {
> -		nn->client_tracking_ops =3D &nfsd4_cld_tracking_ops_v0;
> -		status =3D nn->client_tracking_ops->init(net);
> -		if (!status)
> -			return status;
> -	}
> +	struct path path;
> =20
>  	/*
>  	 * Next, try the UMH upcall.
> @@ -2045,14 +2042,46 @@ nfsd4_client_tracking_init(struct net *net)
>  	nn->client_tracking_ops =3D &nfsd4_legacy_tracking_ops;
>  	status =3D kern_path(nfs4_recoverydir(), LOOKUP_FOLLOW, &path);
>  	if (!status) {
> -		status =3D d_is_dir(path.dentry);
> +		status =3D !d_is_dir(path.dentry);
>  		path_put(&path);
> -		if (!status) {
> -			status =3D -EINVAL;
> -			goto out;
> -		}
> +		if (status)
> +			return -ENOTDIR;
> +		status =3D nn->client_tracking_ops->init(net);
> +	}
> +	return status;
> +}
> +#else
> +static inline int check_for_legacy_methods(int status, struct net *net)
> +{
> +	return status;
> +}
> +#endif /* CONFIG_LEGACY_NFSD_CLIENT_TRACKING */
> +
> +int
> +nfsd4_client_tracking_init(struct net *net)
> +{
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	int status;
> +
> +	/* just run the init if it the method is already decided */
> +	if (nn->client_tracking_ops)
> +		goto do_init;
> +
> +	/* First, try to use nfsdcld */
> +	nn->client_tracking_ops =3D &nfsd4_cld_tracking_ops;
> +	status =3D nn->client_tracking_ops->init(net);
> +	if (!status)
> +		return status;
> +	if (status !=3D -ETIMEDOUT) {
> +		nn->client_tracking_ops =3D &nfsd4_cld_tracking_ops_v0;
> +		status =3D nn->client_tracking_ops->init(net);
> +		if (!status)
> +			return status;
>  	}
> =20
> +	status =3D check_for_legacy_methods(status, net);
> +	if (status)
> +		goto out;
>  do_init:
>  	status =3D nn->client_tracking_ops->init(net);
>  out:
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 7ed02fb88a36..48d1dc9cccfb 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -75,7 +75,9 @@ static ssize_t write_maxconn(struct file *file, char *buf=
, size_t size);
>  #ifdef CONFIG_NFSD_V4
>  static ssize_t write_leasetime(struct file *file, char *buf, size_t size);
>  static ssize_t write_gracetime(struct file *file, char *buf, size_t size);
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  static ssize_t write_recoverydir(struct file *file, char *buf, size_t size=
);
> +#endif
>  static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t siz=
e);
>  #endif
> =20
> @@ -92,7 +94,9 @@ static ssize_t (*const write_op[])(struct file *, char *,=
 size_t) =3D {
>  #ifdef CONFIG_NFSD_V4
>  	[NFSD_Leasetime] =3D write_leasetime,
>  	[NFSD_Gracetime] =3D write_gracetime,
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  	[NFSD_RecoveryDir] =3D write_recoverydir,
> +#endif
>  	[NFSD_V4EndGrace] =3D write_v4_end_grace,
>  #endif
>  };
> @@ -1012,6 +1016,7 @@ static ssize_t write_gracetime(struct file *file, cha=
r *buf, size_t size)
>  	return nfsd4_write_time(file, buf, size, &nn->nfsd4_grace, nn);
>  }
> =20
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  static ssize_t __write_recoverydir(struct file *file, char *buf, size_t si=
ze,
>  				   struct nfsd_net *nn)
>  {
> @@ -1072,6 +1077,7 @@ static ssize_t write_recoverydir(struct file *file, c=
har *buf, size_t size)
>  	mutex_unlock(&nfsd_mutex);
>  	return rv;
>  }
> +#endif
> =20
>  /*
>   * write_v4_end_grace - release grace period for nfsd's v4.x lock manager
>=20
> ---
> base-commit: 401644852d0b2a278811de38081be23f74b5bb04
> change-id: 20231012-nfsd-cltrack-6198814aee58
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20

