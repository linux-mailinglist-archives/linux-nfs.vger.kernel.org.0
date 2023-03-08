Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBABF6B0510
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Mar 2023 11:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjCHKyf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Mar 2023 05:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjCHKy2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Mar 2023 05:54:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C32EB95C2
        for <linux-nfs@vger.kernel.org>; Wed,  8 Mar 2023 02:54:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AFA1B81C15
        for <linux-nfs@vger.kernel.org>; Wed,  8 Mar 2023 10:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15C6C433D2;
        Wed,  8 Mar 2023 10:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678272863;
        bh=/ClF1sdB6+fOk1a76mAFsROylcQswCtBLkK5DGYuESg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jNhH5Q4NIo57wCiBdgrM3Ibx9kqwooMu4uKFptL/L+Y5VtJBB5CDGXh5eRtBknrWy
         dnyr5P532sMaUH/38lYtFlkBnS9oqd+7jhtYd05N2r6ymC25p88xPTN0Opp42cDeLS
         1XrsuCtZHeidbHDWG5XbgCwXOEdHzO0NTl05bXAXNOCSqO/XFfoLkM/o9UuFG8hrPM
         wJr8tnR/nFQd+autB7VumjsW108L1xEYzI3xm8Qph+JTy26i8ixPvmOkBAKpzz5I9l
         b3BRLVoVWwycjsA6/muR8VcGQtvlYX9bOvh5vL6VHdiXa0zgL7Fka3O/T8Tq1NkCcp
         7OTRIk8MUdtuQ==
Message-ID: <5c211bd196a769fd8d978b7862aa571e22a8bd1c.camel@kernel.org>
Subject: Re: [PATCH] SUNRPC: return proper error from get_expiry()
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, Jerry Zhang <jerry@skydio.com>
Date:   Wed, 08 Mar 2023 05:54:21 -0500
In-Reply-To: <167825826081.8008.16276753342643583003@noble.neil.brown.name>
References: <167825826081.8008.16276753342643583003@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-03-08 at 17:51 +1100, NeilBrown wrote:
> The get_expiry() function currently returns a timestamp, and uses the
> special return value of 0 to indicate an error.
>=20
> Unfortunately this causes a problem when 0 is the correct return value.
>=20
> On a system with no RTC it is possible that the boot time will be seen
> to be "3".  When exportfs probes to see if a particular filesystem
> supports NFS export it tries to cache information with an expiry time of
> "3".  The intention is for this to be "long in the past".  Even with no
> RTC it will not be far in the future (at most a second or two) so this
> is harmless.
> But if the boot time happens to have been calculated to be "3", then
> get_expiry will fail incorrectly as it converts the number to "seconds
> since bootime" - 0.
>=20
> To avoid this problem we change get_expiry() to report the error quite
> separately from the expiry time.  The error is now the return value.
> The expiry time is reported through a by-reference parameter.
>=20
> Reported-by: Jerry Zhang <jerry@skydio.com>
> Tested-by: Jerry Zhang <jerry@skydio.com>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/export.c                  | 13 ++++++-------
>  fs/nfsd/nfs4idmap.c               |  8 ++++----
>  include/linux/sunrpc/cache.h      | 15 ++++++++-------
>  net/sunrpc/auth_gss/svcauth_gss.c | 12 ++++++------
>  net/sunrpc/svcauth_unix.c         | 12 ++++++------
>  5 files changed, 30 insertions(+), 30 deletions(-)
>=20
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 668c7527b17e..6da74aebe1fb 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -123,11 +123,11 @@ static int expkey_parse(struct cache_detail *cd, ch=
ar *mesg, int mlen)
> =20
>  	/* OK, we seem to have a valid key */
>  	key.h.flags =3D 0;
> -	key.h.expiry_time =3D get_expiry(&mesg);
> -	if (key.h.expiry_time =3D=3D 0)
> +	err =3D get_expiry(&mesg, &key.h.expiry_time);
> +	if (err)
>  		goto out;
> =20
> -	key.ek_client =3D dom;=09
> +	key.ek_client =3D dom;
>  	key.ek_fsidtype =3D fsidtype;
>  	memcpy(key.ek_fsid, buf, len);
> =20
> @@ -610,9 +610,8 @@ static int svc_export_parse(struct cache_detail *cd, =
char *mesg, int mlen)
>  	exp.ex_devid_map =3D NULL;
> =20
>  	/* expiry */
> -	err =3D -EINVAL;
> -	exp.h.expiry_time =3D get_expiry(&mesg);
> -	if (exp.h.expiry_time =3D=3D 0)
> +	err =3D get_expiry(&mesg, &exp.h.expiry_time);
> +	if (err)
>  		goto out3;
> =20
>  	/* flags */
> @@ -624,7 +623,7 @@ static int svc_export_parse(struct cache_detail *cd, =
char *mesg, int mlen)
>  		if (err || an_int < 0)
>  			goto out3;
>  		exp.ex_flags=3D an_int;
> -=09
> +
>  		/* anon uid */
>  		err =3D get_int(&mesg, &an_int);
>  		if (err)
> diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
> index 5e9809aff37e..7a806ac13e31 100644
> --- a/fs/nfsd/nfs4idmap.c
> +++ b/fs/nfsd/nfs4idmap.c
> @@ -240,8 +240,8 @@ idtoname_parse(struct cache_detail *cd, char *buf, in=
t buflen)
>  		goto out;
> =20
>  	/* expiry */
> -	ent.h.expiry_time =3D get_expiry(&buf);
> -	if (ent.h.expiry_time =3D=3D 0)
> +	error =3D get_expiry(&buf, &ent.h.expiry_time);
> +	if (error)
>  		goto out;
> =20
>  	error =3D -ENOMEM;
> @@ -408,8 +408,8 @@ nametoid_parse(struct cache_detail *cd, char *buf, in=
t buflen)
>  	memcpy(ent.name, buf1, sizeof(ent.name));
> =20
>  	/* expiry */
> -	ent.h.expiry_time =3D get_expiry(&buf);
> -	if (ent.h.expiry_time =3D=3D 0)
> +	error =3D get_expiry(&buf, &ent.h.expiry_time);
> +	if (error)
>  		goto out;
> =20
>  	/* ID */
> diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
> index ec5a555df96f..518bd28f5ab8 100644
> --- a/include/linux/sunrpc/cache.h
> +++ b/include/linux/sunrpc/cache.h
> @@ -300,17 +300,18 @@ static inline int get_time(char **bpp, time64_t *ti=
me)
>  	return 0;
>  }
> =20
> -static inline time64_t get_expiry(char **bpp)
> +static inline int get_expiry(char **bpp, time64_t *rvp)
>  {
> -	time64_t rv;
> +	int error;
>  	struct timespec64 boot;
> =20
> -	if (get_time(bpp, &rv))
> -		return 0;
> -	if (rv < 0)
> -		return 0;
> +	error =3D get_time(bpp, rvp);
> +	if (error)
> +		return error;
> +
>  	getboottime64(&boot);
> -	return rv - boot.tv_sec;
> +	(*rvp) -=3D boot.tv_sec;
> +	return 0;
>  }
> =20
>  #endif /*  _LINUX_SUNRPC_CACHE_H_ */
> diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svca=
uth_gss.c
> index acb822b23af1..bfaf584d296a 100644
> --- a/net/sunrpc/auth_gss/svcauth_gss.c
> +++ b/net/sunrpc/auth_gss/svcauth_gss.c
> @@ -258,11 +258,11 @@ static int rsi_parse(struct cache_detail *cd,
> =20
>  	rsii.h.flags =3D 0;
>  	/* expiry */
> -	expiry =3D get_expiry(&mesg);
> -	status =3D -EINVAL;
> -	if (expiry =3D=3D 0)
> +	status =3D get_expiry(&mesg, &expiry);
> +	if (status)
>  		goto out;
> =20
> +	status =3D -EINVAL;
>  	/* major/minor */
>  	len =3D qword_get(&mesg, buf, mlen);
>  	if (len <=3D 0)
> @@ -484,11 +484,11 @@ static int rsc_parse(struct cache_detail *cd,
> =20
>  	rsci.h.flags =3D 0;
>  	/* expiry */
> -	expiry =3D get_expiry(&mesg);
> -	status =3D -EINVAL;
> -	if (expiry =3D=3D 0)
> +	status =3D get_expiry(&mesg, &expiry);
> +	if (status)
>  		goto out;
> =20
> +	status =3D -EINVAL;
>  	rscp =3D rsc_lookup(cd, &rsci);
>  	if (!rscp)
>  		goto out;
> diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
> index b1efc34db6ed..9e7798a69051 100644
> --- a/net/sunrpc/svcauth_unix.c
> +++ b/net/sunrpc/svcauth_unix.c
> @@ -225,9 +225,9 @@ static int ip_map_parse(struct cache_detail *cd,
>  		return -EINVAL;
>  	}
> =20
> -	expiry =3D get_expiry(&mesg);
> -	if (expiry =3D=3D0)
> -		return -EINVAL;
> +	err =3D get_expiry(&mesg, &expiry);
> +	if (err)
> +		return err;
> =20
>  	/* domainname, or empty for NEGATIVE */
>  	len =3D qword_get(&mesg, buf, mlen);
> @@ -497,9 +497,9 @@ static int unix_gid_parse(struct cache_detail *cd,
>  	uid =3D make_kuid(current_user_ns(), id);
>  	ug.uid =3D uid;
> =20
> -	expiry =3D get_expiry(&mesg);
> -	if (expiry =3D=3D 0)
> -		return -EINVAL;
> +	err =3D get_expiry(&mesg, &expiry);
> +	if (err)
> +		return err;
> =20
>  	rv =3D get_int(&mesg, &gids);
>  	if (rv || gids < 0 || gids > 8192)

Nice cleanup. The old return value was very confusing.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
