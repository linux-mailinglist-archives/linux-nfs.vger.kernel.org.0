Return-Path: <linux-nfs+bounces-8533-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140709EF450
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Dec 2024 18:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6B628D1DC
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Dec 2024 17:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A0D2144C4;
	Thu, 12 Dec 2024 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNBy8j0I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7752F44
	for <linux-nfs@vger.kernel.org>; Thu, 12 Dec 2024 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023156; cv=none; b=ZpDrXNlF7ldCdAZEunTqoEHbRP4l6D/AzGvQ4hSy8Qr0Ml5W1Qw4f6UK/XHl5h2+OExm6BPRdzMqoZKv5mkOJ80Qy/FYOs3oSMzAmi06NgWrIYWhAAv3LD717r1XeE6ylzSo+47yuWbA+UrEVc0REC4yrqkMlECdaPOKQjlry2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023156; c=relaxed/simple;
	bh=Da7ZJaBq2nwZL074DHERdwseDAEbL6/nHAHDU/RnTXs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SaC3tqSloMTQVtU9NM08d9OlUHVo7aqsFQscGaE6yCmZSHp+wm0VEBBfg/RFRxGFyV4cC8BpyNGTujuH4ABzyvJ0WHSGcu91XctVDsHp/Kij0Z3Cobz9wEwaJHTKB18JtVf6Qoz5E0RV/gPH/KMHb6r7NUV9BTFnRYPmrmaT0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNBy8j0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB42C4CECE;
	Thu, 12 Dec 2024 17:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734023156;
	bh=Da7ZJaBq2nwZL074DHERdwseDAEbL6/nHAHDU/RnTXs=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=NNBy8j0Ir8pdDncK6P5NDTPvTTu452gI7y9vh+x4+yjPMWhVMXcCilIGLap6Zw35b
	 5WGTT6nd4Ynm1Uv+0mlAKcsGgpaahLcWA0Kev9DA3jCdGbKmTvNGzR7edx+8de213n
	 jUT6EMdWT13yKO4eeRRPupAR27Zm6slnu/leeHn6xDK1D+2JhRxGrBupOy3ue7H89k
	 RydVJ21UZ7ImdJj2G8rfRyCmNdxuskW3vnwbFvfxv95Y+MFn+E/ccgz8rHiDk/2k7x
	 7/DtbGJ9Rs1QHCeMBJADWuIVT791TzodhjOs1cFtIY1f81nMdq2U3hB8j9WuUZpXhC
	 tRjN0UUNsDP2A==
Message-ID: <60f17d1c31e20ab3c18b0f28f117528326d34ec2.camel@kernel.org>
Subject: Re: [PATCH V2] mount.nfs4: Add support for nfs://-URLs
From: Jeff Layton <jlayton@kernel.org>
To: Roland Mainz <roland.mainz@nrubsig.org>, Linux NFS Mailing list
	 <linux-nfs@vger.kernel.org>
Date: Thu, 12 Dec 2024 12:05:55 -0500
In-Reply-To: <20241210122846.821199-1-roland.mainz@nrubsig.org>
References: <20241210122846.821199-1-roland.mainz@nrubsig.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-10 at 07:28 -0500, Roland Mainz wrote:
> Add support for RFC 2224-style nfs://-URLs as alternative to the
> traditional hostname:/path+-o port=3D<tcp-port> notation,
> providing standardised, extensible, single-string, crossplatform,
> portable, Character-Encoding independent (e.g. mount point with
> Japanese, Chinese, French etc. characters) and ASCII-compatible
> descriptions of NFSv4 server resources (exports).
>=20
> Reviewed-by: Martin Wege <martin.l.wege@gmail.com>
> Signed-off-by: Marvin Wenzel <marvin.wenzel@rovema.de>
> Signed-off-by: Cedric Blancher <cedric.blancher@gmail.com>
> ---
>  utils/mount/Makefile.am  |   3 +-
>  utils/mount/mount.c      |   3 +
>  utils/mount/nfs4mount.c  |  69 +++++++-
>  utils/mount/nfsmount.c   |  93 ++++++++--
>  utils/mount/parse_dev.c  |  67 ++++++--
>  utils/mount/stropts.c    |  96 ++++++++++-
>  utils/mount/urlparser1.c | 358 +++++++++++++++++++++++++++++++++++++++
>  utils/mount/urlparser1.h |  60 +++++++
>  utils/mount/utils.c      | 155 +++++++++++++++++
>  utils/mount/utils.h      |  23 +++
>  10 files changed, 890 insertions(+), 37 deletions(-)
>  create mode 100644 utils/mount/urlparser1.c
>  create mode 100644 utils/mount/urlparser1.h
>=20
> diff --git a/utils/mount/Makefile.am b/utils/mount/Makefile.am
> index 83a8ee1c..0e4cab3e 100644
> --- a/utils/mount/Makefile.am
> +++ b/utils/mount/Makefile.am
> @@ -13,7 +13,8 @@ sbin_PROGRAMS	=3D mount.nfs
>  EXTRA_DIST =3D nfsmount.conf $(man8_MANS) $(man5_MANS)
>  mount_common =3D error.c network.c token.c \
>  		    parse_opt.c parse_dev.c \
> -		    nfsmount.c nfs4mount.c stropts.c\
> +		    nfsmount.c nfs4mount.c \
> +		    urlparser1.c urlparser1.h stropts.c \
>  		    mount_constants.h error.h network.h token.h \
>  		    parse_opt.h parse_dev.h \
>  		    nfs4_mount.h stropts.h version.h \
> diff --git a/utils/mount/mount.c b/utils/mount/mount.c
> index b98f9e00..2ce6209d 100644
> --- a/utils/mount/mount.c
> +++ b/utils/mount/mount.c
> @@ -29,6 +29,7 @@
>  #include <string.h>
>  #include <errno.h>
>  #include <fcntl.h>
> +#include <locale.h>
>  #include <sys/mount.h>
>  #include <getopt.h>
>  #include <mntent.h>
> @@ -386,6 +387,8 @@ int main(int argc, char *argv[])
>  	char *extra_opts =3D NULL, *mount_opts =3D NULL;
>  	uid_t uid =3D getuid();
> =20
> +	(void)setlocale(LC_ALL, "");
> +
>  	progname =3D basename(argv[0]);
> =20
>  	nfs_mount_data_version =3D discover_nfs_mount_data_version(&string);
> diff --git a/utils/mount/nfs4mount.c b/utils/mount/nfs4mount.c
> index 0fe142a7..8e4fbf30 100644
> --- a/utils/mount/nfs4mount.c
> +++ b/utils/mount/nfs4mount.c
> @@ -50,8 +50,10 @@
>  #include "mount_constants.h"
>  #include "nfs4_mount.h"
>  #include "nfs_mount.h"
> +#include "urlparser1.h"
>  #include "error.h"
>  #include "network.h"
> +#include "utils.h"
> =20
>  #if defined(VAR_LOCK_DIR)
>  #define DEFAULT_DIR VAR_LOCK_DIR
> @@ -182,7 +184,7 @@ int nfs4mount(const char *spec, const char *node, int=
 flags,
>  	int num_flavour =3D 0;
>  	int ip_addr_in_opts =3D 0;
> =20
> -	char *hostname, *dirname, *old_opts;
> +	char *hostname, *dirname, *mb_dirname =3D NULL, *old_opts;
>  	char new_opts[1024];
>  	char *opt, *opteq;
>  	char *s;
> @@ -192,15 +194,66 @@ int nfs4mount(const char *spec, const char *node, i=
nt flags,
>  	int retry;
>  	int retval =3D EX_FAIL;
>  	time_t timeout, t;
> +	int nfs_port =3D NFS_PORT;
> +	parsed_nfs_url pnu;
> +
> +	(void)memset(&pnu, 0, sizeof(parsed_nfs_url));
> =20
>  	if (strlen(spec) >=3D sizeof(hostdir)) {
>  		nfs_error(_("%s: excessively long host:dir argument\n"),
>  				progname);
>  		goto fail;
>  	}
> -	strcpy(hostdir, spec);
> -	if (parse_devname(hostdir, &hostname, &dirname))
> -		goto fail;
> +
> +	/*
> +	 * Support nfs://-URLS per RFC 2224 ("NFS URL
> +	 * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> +	 * including custom port (nfs://hostname@port/path/...)
> +	 * and URL parameter (e.g. nfs://.../?param1=3Dval1&param2=3Dval2

This part seems ill-advised:

While 2224 does define an nfs:// URL, I don't recall seeing anything
about parameters being passed in the above fashion. Where are these
parameters defined? Are they just mount options?

If so, while we do strive to mirror option names with (e.g.) BSD or
Solaris, it's not always possible and different operating systems have
mount options that are not recognized by others.

Is there a plan to deal with that? If not, then maybe it'd be best to
leave mount option handling out of this for now.

> +	 * support
> +	 */
> +	if (is_spec_nfs_url(spec)) {
> +		if (!mount_parse_nfs_url(spec, &pnu)) {
> +			goto fail;
> +		}
> +
> +		/*
> +		 * |pnu.uctx->path| is in UTF-8, but we need the data
> +		 * in the current local locale's encoding, as mount(2)
> +		 * does not have something like a |MS_UTF8_SPEC| flag
> +		 * to indicate that the input path is in UTF-8,
> +		 * independently of the current locale
> +		 */
> +		hostname =3D pnu.uctx->hostport.hostname;
> +		dirname =3D mb_dirname =3D utf8str2mbstr(pnu.uctx->path);
> +
> +		(void)snprintf(hostdir, sizeof(hostdir), "%s:/%s",
> +			hostname, dirname);
> +		spec =3D hostdir;
> +
> +		if (pnu.uctx->hostport.port !=3D -1) {
> +			nfs_port =3D pnu.uctx->hostport.port;
> +		}
> +
> +		/*
> +		 * Values added here based on URL parameters
> +		 * should be added the front of the list of options,
> +		 * so users can override the nfs://-URL given default.
> +		 *
> +		 * FIXME: We do not do that here for |MS_RDONLY|!
> +		 */
> +		if (pnu.mount_params.read_only !=3D TRIS_BOOL_NOT_SET) {
> +			if (pnu.mount_params.read_only)
> +				flags |=3D MS_RDONLY;
> +			else
> +				flags &=3D ~MS_RDONLY;
> +		}
> +        } else {
> +		(void)strcpy(hostdir, spec);
> +
> +		if (parse_devname(hostdir, &hostname, &dirname))
> +			goto fail;
> +	}
> =20
>  	if (fill_ipv4_sockaddr(hostname, &server_addr))
>  		goto fail;
> @@ -247,7 +300,7 @@ int nfs4mount(const char *spec, const char *node, int=
 flags,
>  	/*
>  	 * NFSv4 specifies that the default port should be 2049
>  	 */
> -	server_addr.sin_port =3D htons(NFS_PORT);
> +	server_addr.sin_port =3D htons(nfs_port);
> =20
>  	/* parse options */
> =20
> @@ -474,8 +527,14 @@ int nfs4mount(const char *spec, const char *node, in=
t flags,
>  		}
>  	}
> =20
> +	mount_free_parse_nfs_url(&pnu);
> +	free(mb_dirname);
> +
>  	return EX_SUCCESS;
> =20
>  fail:
> +	mount_free_parse_nfs_url(&pnu);
> +	free(mb_dirname);
> +
>  	return retval;
>  }
> diff --git a/utils/mount/nfsmount.c b/utils/mount/nfsmount.c
> index a1c92fe8..e61d718a 100644
> --- a/utils/mount/nfsmount.c
> +++ b/utils/mount/nfsmount.c
> @@ -63,11 +63,13 @@
>  #include "xcommon.h"
>  #include "mount.h"
>  #include "nfs_mount.h"
> +#include "urlparser1.h"
>  #include "mount_constants.h"
>  #include "nls.h"
>  #include "error.h"
>  #include "network.h"
>  #include "version.h"
> +#include "utils.h"
> =20
>  #ifdef HAVE_RPCSVC_NFS_PROT_H
>  #include <rpcsvc/nfs_prot.h>
> @@ -493,7 +495,7 @@ nfsmount(const char *spec, const char *node, int flag=
s,
>  	 char **extra_opts, int fake, int running_bg)
>  {
>  	char hostdir[1024];
> -	char *hostname, *dirname, *old_opts, *mounthost =3D NULL;
> +	char *hostname, *dirname, *mb_dirname =3D NULL, *old_opts, *mounthost =
=3D NULL;
>  	char new_opts[1024], cbuf[1024];
>  	static struct nfs_mount_data data;
>  	int val;
> @@ -521,29 +523,79 @@ nfsmount(const char *spec, const char *node, int fl=
ags,
>  	time_t t;
>  	time_t prevt;
>  	time_t timeout;
> +	int nfsurl_port =3D -1;
> +	parsed_nfs_url pnu;
> +
> +	(void)memset(&pnu, 0, sizeof(parsed_nfs_url));
> =20
>  	if (strlen(spec) >=3D sizeof(hostdir)) {
>  		nfs_error(_("%s: excessively long host:dir argument"),
>  				progname);
>  		goto fail;
>  	}
> -	strcpy(hostdir, spec);
> -	if ((s =3D strchr(hostdir, ':'))) {
> -		hostname =3D hostdir;
> -		dirname =3D s + 1;
> -		*s =3D '\0';
> -		/* Ignore all but first hostname in replicated mounts
> -		   until they can be fully supported. (mack@sgi.com) */
> -		if ((s =3D strchr(hostdir, ','))) {
> +
> +	/*
> +	 * Support nfs://-URLS per RFC 2224 ("NFS URL
> +	 * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> +	 * including custom port (nfs://hostname@port/path/...)
> +	 * and URL parameter (e.g. nfs://.../?param1=3Dval1&param2=3Dval2
> +	 * support
> +	 */
> +	if (is_spec_nfs_url(spec)) {
> +		if (!mount_parse_nfs_url(spec, &pnu)) {
> +			goto fail;
> +		}
> +
> +		/*
> +		 * |pnu.uctx->path| is in UTF-8, but we need the data
> +		 * in the current local locale's encoding, as mount(2)
> +		 * does not have something like a |MS_UTF8_SPEC| flag
> +		 * to indicate that the input path is in UTF-8,
> +		 * independently of the current locale
> +		 */
> +		hostname =3D pnu.uctx->hostport.hostname;
> +		dirname =3D mb_dirname =3D utf8str2mbstr(pnu.uctx->path);
> +
> +		(void)snprintf(hostdir, sizeof(hostdir), "%s:/%s",
> +			hostname, dirname);
> +		spec =3D hostdir;
> +
> +		if (pnu.uctx->hostport.port !=3D -1) {
> +			nfsurl_port =3D pnu.uctx->hostport.port;
> +		}
> +
> +		/*
> +		 * Values added here based on URL parameters
> +		 * should be added the front of the list of options,
> +		 * so users can override the nfs://-URL given default.
> +		 *
> +		 * FIXME: We do not do that here for |MS_RDONLY|!
> +		 */
> +		if (pnu.mount_params.read_only !=3D TRIS_BOOL_NOT_SET) {
> +			if (pnu.mount_params.read_only)
> +				flags |=3D MS_RDONLY;
> +			else
> +				flags &=3D ~MS_RDONLY;
> +		}
> +        } else {
> +		(void)strcpy(hostdir, spec);
> +		if ((s =3D strchr(hostdir, ':'))) {
> +			hostname =3D hostdir;
> +			dirname =3D s + 1;
>  			*s =3D '\0';
> -			nfs_error(_("%s: warning: "
> -				  "multiple hostnames not supported"),
> +			/* Ignore all but first hostname in replicated mounts
> +			   until they can be fully supported. (mack@sgi.com) */
> +			if ((s =3D strchr(hostdir, ','))) {
> +				*s =3D '\0';
> +				nfs_error(_("%s: warning: "
> +					"multiple hostnames not supported"),
>  					progname);
> -		}
> -	} else {
> -		nfs_error(_("%s: directory to mount not in host:dir format"),
> +			}
> +		} else {
> +			nfs_error(_("%s: directory to mount not in host:dir format"),
>  				progname);
> -		goto fail;
> +			goto fail;
> +		}
>  	}
> =20
>  	if (!nfs_gethostbyname(hostname, nfs_saddr))
> @@ -579,6 +631,14 @@ nfsmount(const char *spec, const char *node, int fla=
gs,
>  	memset(nfs_pmap, 0, sizeof(*nfs_pmap));
>  	nfs_pmap->pm_prog =3D NFS_PROGRAM;
> =20
> +	if (nfsurl_port !=3D -1) {
> +		/*
> +		 * Set custom TCP port defined by a nfs://-URL here,
> +		 * so $ mount -o port ... # can be used to override
> +		 */
> +		nfs_pmap->pm_port =3D nfsurl_port;
> +	}
> +
>  	/* parse options */
>  	new_opts[0] =3D 0;
>  	if (!parse_options(old_opts, &data, &bg, &retry, &mnt_server, &nfs_serv=
er,
> @@ -863,10 +923,13 @@ noauth_flavors:
>  		}
>  	}
> =20
> +	mount_free_parse_nfs_url(&pnu);
> +
>  	return EX_SUCCESS;
> =20
>  	/* abort */
>   fail:
> +	mount_free_parse_nfs_url(&pnu);
>  	if (fsock !=3D -1)
>  		close(fsock);
>  	return retval;
> diff --git a/utils/mount/parse_dev.c b/utils/mount/parse_dev.c
> index 2ade5d5d..d9f8cf59 100644
> --- a/utils/mount/parse_dev.c
> +++ b/utils/mount/parse_dev.c
> @@ -27,6 +27,8 @@
>  #include "xcommon.h"
>  #include "nls.h"
>  #include "parse_dev.h"
> +#include "urlparser1.h"
> +#include "utils.h"
> =20
>  #ifndef NFS_MAXHOSTNAME
>  #define NFS_MAXHOSTNAME		(255)
> @@ -179,17 +181,62 @@ static int nfs_parse_square_bracket(const char *dev=
,
>  }
> =20
>  /*
> - * RFC 2224 says an NFS client must grok "public file handles" to
> - * support NFS URLs.  Linux doesn't do that yet.  Print a somewhat
> - * helpful error message in this case instead of pressing forward
> - * with the mount request and failing with a cryptic error message
> - * later.
> + * Support nfs://-URLS per RFC 2224 ("NFS URL
> + * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> + * including port support (nfs://hostname@port/path/...)
>   */
> -static int nfs_parse_nfs_url(__attribute__((unused)) const char *dev,
> -			     __attribute__((unused)) char **hostname,
> -			     __attribute__((unused)) char **pathname)
> +static int nfs_parse_nfs_url(const char *dev,
> +			     char **out_hostname,
> +			     char **out_pathname)
>  {
> -	nfs_error(_("%s: NFS URLs are not supported"), progname);
> +	parsed_nfs_url pnu;
> +
> +	if (out_hostname)
> +		*out_hostname =3D NULL;
> +	if (out_pathname)
> +		*out_pathname =3D NULL;
> +
> +	/*
> +	 * Support nfs://-URLS per RFC 2224 ("NFS URL
> +	 * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> +	 * including custom port (nfs://hostname@port/path/...)
> +	 * and URL parameter (e.g. nfs://.../?param1=3Dval1&param2=3Dval2
> +	 * support
> +	 */
> +	if (!mount_parse_nfs_url(dev, &pnu)) {
> +		goto fail;
> +	}
> +
> +	if (pnu.uctx->hostport.port !=3D -1) {
> +		/* NOP here, unless we switch from hostname to hostport */
> +	}
> +
> +	if (out_hostname)
> +		*out_hostname =3D strdup(pnu.uctx->hostport.hostname);
> +	if (out_pathname)
> +		*out_pathname =3D utf8str2mbstr(pnu.uctx->path);
> +
> +	if (((out_hostname)?(*out_hostname =3D=3D NULL):0) ||
> +		((out_pathname)?(*out_pathname =3D=3D NULL):0)) {
> +		nfs_error(_("%s: out of memory"),
> +			progname);
> +		goto fail;
> +	}
> +
> +	mount_free_parse_nfs_url(&pnu);
> +
> +	return 1;
> +
> +fail:
> +	mount_free_parse_nfs_url(&pnu);
> +	if (out_hostname) {
> +		free(*out_hostname);
> +		*out_hostname =3D NULL;
> +	}
> +	if (out_pathname) {
> +		free(*out_pathname);
> +		*out_pathname =3D NULL;
> +	}
>  	return 0;
>  }
> =20
> @@ -223,7 +270,7 @@ int nfs_parse_devname(const char *devname,
>  		return nfs_pdn_nomem_err();
>  	if (*dev =3D=3D '[')
>  		result =3D nfs_parse_square_bracket(dev, hostname, pathname);
> -	else if (strncmp(dev, "nfs://", 6) =3D=3D 0)
> +	else if (is_spec_nfs_url(dev))
>  		result =3D nfs_parse_nfs_url(dev, hostname, pathname);
>  	else
>  		result =3D nfs_parse_simple_hostname(dev, hostname, pathname);
> diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
> index 23f0a8c0..ad92ab78 100644
> --- a/utils/mount/stropts.c
> +++ b/utils/mount/stropts.c
> @@ -42,6 +42,7 @@
>  #include "nls.h"
>  #include "nfsrpc.h"
>  #include "mount_constants.h"
> +#include "urlparser1.h"
>  #include "stropts.h"
>  #include "error.h"
>  #include "network.h"
> @@ -50,6 +51,7 @@
>  #include "parse_dev.h"
>  #include "conffile.h"
>  #include "misc.h"
> +#include "utils.h"
> =20
>  #ifndef NFS_PROGRAM
>  #define NFS_PROGRAM	(100003)
> @@ -643,24 +645,106 @@ static int nfs_sys_mount(struct nfsmount_info *mi,=
 struct mount_options *opts)
>  {
>  	char *options =3D NULL;
>  	int result;
> +	int nfs_port =3D 2049;
> =20
>  	if (mi->fake)
>  		return 1;
> =20
> -	if (po_join(opts, &options) =3D=3D PO_FAILED) {
> -		errno =3D EIO;
> -		return 0;
> -	}
> +	/*
> +	 * Support nfs://-URLS per RFC 2224 ("NFS URL
> +	 * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> +	 * including custom port (nfs://hostname@port/path/...)
> +	 * and URL parameter (e.g. nfs://.../?param1=3Dval1&param2=3Dval2
> +	 * support
> +	 */
> +	if (is_spec_nfs_url(mi->spec)) {
> +		parsed_nfs_url pnu;
> +		char *mb_path;
> +		char mount_source[1024];
> +
> +		if (!mount_parse_nfs_url(mi->spec, &pnu)) {
> +			result =3D 1;
> +			errno =3D EINVAL;
> +			goto done;
> +		}
> +
> +		/*
> +		 * |pnu.uctx->path| is in UTF-8, but we need the data
> +		 * in the current local locale's encoding, as mount(2)
> +		 * does not have something like a |MS_UTF8_SPEC| flag
> +		 * to indicate that the input path is in UTF-8,
> +		 * independently of the current locale
> +		 */
> +		mb_path =3D utf8str2mbstr(pnu.uctx->path);
> +		if (!mb_path) {
> +			nfs_error(_("%s: Could not convert path to local encoding."),
> +				progname);
> +			mount_free_parse_nfs_url(&pnu);
> +			result =3D 1;
> +			errno =3D EINVAL;
> +			goto done;
> +		}
> +
> +		(void)snprintf(mount_source, sizeof(mount_source),
> +			"%s:/%s",
> +			pnu.uctx->hostport.hostname,
> +			mb_path);
> +		free(mb_path);
> +
> +		if (pnu.uctx->hostport.port !=3D -1) {
> +			nfs_port =3D pnu.uctx->hostport.port;
> +		}
> =20
> -	result =3D mount(mi->spec, mi->node, mi->type,
> +		/*
> +		 * Insert "port=3D" option with the value from the nfs://
> +		 * URL at the beginning of the list of options, so
> +		 * users can override it with $ mount.nfs4 -o port=3D #,
> +		 * e.g.
> +		 * $ mount.nfs4 -o port=3D1234 nfs://10.49.202.230:400//bigdisk /mnt4 =
#
> +		 * should use port 1234, and not port 400 as specified
> +		 * in the URL.
> +		 */
> +		char portoptbuf[5+32+1];
> +		(void)snprintf(portoptbuf, sizeof(portoptbuf), "port=3D%d", nfs_port);
> +		(void)po_insert(opts, portoptbuf);
> +
> +		if (pnu.mount_params.read_only !=3D TRIS_BOOL_NOT_SET) {
> +			if (pnu.mount_params.read_only)
> +				mi->flags |=3D MS_RDONLY;
> +			else
> +				mi->flags &=3D ~MS_RDONLY;
> +		}
> +
> +		mount_free_parse_nfs_url(&pnu);
> +
> +		if (po_join(opts, &options) =3D=3D PO_FAILED) {
> +			errno =3D EIO;
> +			result =3D 1;
> +			goto done;
> +		}
> +
> +		result =3D mount(mount_source, mi->node, mi->type,
> +			mi->flags & ~(MS_USER|MS_USERS), options);
> +		free(options);
> +	} else {
> +		if (po_join(opts, &options) =3D=3D PO_FAILED) {
> +			errno =3D EIO;
> +			result =3D 1;
> +			goto done;
> +		}
> +
> +		result =3D mount(mi->spec, mi->node, mi->type,
>  			mi->flags & ~(MS_USER|MS_USERS), options);
> -	free(options);
> +		free(options);
> +	}
> =20
>  	if (verbose && result) {
>  		int save =3D errno;
>  		nfs_error(_("%s: mount(2): %s"), progname, strerror(save));
>  		errno =3D save;
>  	}
> +
> +done:
>  	return !result;
>  }
> =20
> diff --git a/utils/mount/urlparser1.c b/utils/mount/urlparser1.c
> new file mode 100644
> index 00000000..d4c6f339
> --- /dev/null
> +++ b/utils/mount/urlparser1.c
> @@ -0,0 +1,358 @@
> +/*
> + * MIT License
> + *
> + * Copyright (c) 2024 Roland Mainz <roland.mainz@nrubsig.org>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in all
> + * copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHE=
R
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN THE
> + * SOFTWARE.
> + */
> +
> +/* urlparser1.c - simple URL parser */
> +
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <ctype.h>
> +#include <stdio.h>
> +
> +#ifdef DBG_USE_WIDECHAR
> +#include <wchar.h>
> +#include <locale.h>
> +#include <io.h>
> +#include <fcntl.h>
> +#endif /* DBG_USE_WIDECHAR */
> +
> +#include "urlparser1.h"
> +
> +typedef struct _url_parser_context_private {
> +	url_parser_context c;
> +
> +	/* Private data */
> +	char *parameter_string_buff;
> +} url_parser_context_private;
> +
> +#define MAX_URL_PARAMETERS 256
> +
> +/*
> + * Original extended regular expression:
> + *
> + * "^"
> + * "(.+?)"				// scheme
> + * "://"				// '://'
> + * "("					// login
> + *	"(?:"
> + *	"(.+?)"				// user (optional)
> + *		"(?::(.+))?"		// password (optional)
> + *		"@"
> + *	")?"
> + *	"("				// hostport
> + *		"(.+?)"			// host
> + *		"(?::([[:digit:]]+))?"	// port (optional)
> + *	")"
> + * ")"
> + * "(?:/(.*?))?"			// path (optional)
> + * "(?:\?(.*?))?"			// URL parameters (optional)
> + * "$"
> + */
> +
> +#define DBGNULLSTR(s) (((s)!=3DNULL)?(s):"<NULL>")
> +#if 0 || defined(TEST_URLPARSER)
> +#define D(x) x
> +#else
> +#define D(x)
> +#endif
> +
> +#ifdef DBG_USE_WIDECHAR
> +/*
> + * Use wide-char APIs on WIN32, otherwise we cannot output
> + * Japanese/Chinese/etc correctly
> + */
> +#define DBG_PUTS(str, fp)		fputws(L"" str, (fp))
> +#define DBG_PUTC(c, fp)			fputwc(btowc(c), (fp))
> +#define DBG_PRINTF(fp, fmt, ...)	fwprintf((fp), L"" fmt, __VA_ARGS__)
> +#else
> +#define DBG_PUTS(str, fp)		fputs((str), (fp))
> +#define DBG_PUTC(c, fp)			fputc((c), (fp))
> +#define DBG_PRINTF(fp, fmt, ...)	fprintf((fp), fmt, __VA_ARGS__)
> +#endif /* DBG_USE_WIDECHAR */
> +
> +static
> +void urldecodestr(char *outbuff, const char *buffer, size_t len)
> +{
> +	size_t i, j;
> +
> +	for (i =3D j =3D 0 ; i < len ; ) {
> +		switch (buffer[i]) {
> +			case '%':
> +				if ((i + 2) < len) {
> +					if (isxdigit((int)buffer[i+1]) && isxdigit((int)buffer[i+2])) {
> +						const char hexstr[3] =3D {
> +							buffer[i+1],
> +							buffer[i+2],
> +							'\0'
> +						};
> +						outbuff[j++] =3D (unsigned char)strtol(hexstr, NULL, 16);
> +						i +=3D 3;
> +					} else {
> +						/* invalid hex digit */
> +						outbuff[j++] =3D buffer[i];
> +						i++;
> +					}
> +				} else {
> +					/* incomplete hex digit */
> +					outbuff[j++] =3D buffer[i];
> +					i++;
> +				}
> +				break;
> +			case '+':
> +				outbuff[j++] =3D ' ';
> +				i++;
> +				break;
> +			default:
> +				outbuff[j++] =3D buffer[i++];
> +				break;
> +		}
> +	}
> +
> +	outbuff[j] =3D '\0';
> +}
> +
> +url_parser_context *url_parser_create_context(const char *in_url, unsign=
ed int flags)
> +{
> +	url_parser_context_private *uctx;
> +	char *s;
> +	size_t in_url_len;
> +	size_t context_len;
> +
> +	/* |flags| is for future extensions */
> +	(void)flags;
> +
> +	if (!in_url)
> +		return NULL;
> +
> +	in_url_len =3D strlen(in_url);
> +
> +	context_len =3D sizeof(url_parser_context_private) +
> +		((in_url_len+1)*6) +
> +		(sizeof(url_parser_name_value)*MAX_URL_PARAMETERS)+sizeof(void*);
> +	uctx =3D malloc(context_len);
> +	if (!uctx)
> +		return NULL;
> +
> +	s =3D (void *)(uctx+1);
> +	uctx->c.in_url =3D s;		s+=3D in_url_len+1;
> +	(void)strcpy(uctx->c.in_url, in_url);
> +	uctx->c.scheme =3D s;		s+=3D in_url_len+1;
> +	uctx->c.login.username =3D s;	s+=3D in_url_len+1;
> +	uctx->c.hostport.hostname =3D s;	s+=3D in_url_len+1;
> +	uctx->c.path =3D s;		s+=3D in_url_len+1;
> +	uctx->c.hostport.port =3D -1;
> +	uctx->c.num_parameters =3D -1;
> +	uctx->c.parameters =3D (void *)s;		s+=3D (sizeof(url_parser_name_value)=
*MAX_URL_PARAMETERS)+sizeof(void*);
> +	uctx->parameter_string_buff =3D s;	s+=3D in_url_len+1;
> +
> +	return &uctx->c;
> +}
> +
> +int url_parser_parse(url_parser_context *ctx)
> +{
> +	url_parser_context_private *uctx =3D (url_parser_context_private *)ctx;
> +
> +	D((void)DBG_PRINTF(stderr, "## parser in_url=3D'%s'\n", uctx->c.in_url)=
);
> +
> +	char *s;
> +	const char *urlstr =3D uctx->c.in_url;
> +	size_t slen;
> +
> +	s =3D strstr(urlstr, "://");
> +	if (!s) {
> +		D((void)DBG_PUTS("url_parser: Not an URL\n", stderr));
> +		return -1;
> +	}
> +
> +	slen =3D s-urlstr;
> +	(void)memcpy(uctx->c.scheme, urlstr, slen);
> +	uctx->c.scheme[slen] =3D '\0';
> +	urlstr +=3D slen + 3;
> +
> +	D((void)DBG_PRINTF(stdout, "scheme=3D'%s', rest=3D'%s'\n", uctx->c.sche=
me, urlstr));
> +
> +	s =3D strstr(urlstr, "@");
> +	if (s) {
> +		/* URL has user/password */
> +		slen =3D s-urlstr;
> +		urldecodestr(uctx->c.login.username, urlstr, slen);
> +		urlstr +=3D slen + 1;
> +
> +		s =3D strstr(uctx->c.login.username, ":");
> +		if (s) {
> +			/* found passwd */
> +			uctx->c.login.passwd =3D s+1;
> +			*s =3D '\0';
> +		}
> +		else {
> +			uctx->c.login.passwd =3D NULL;
> +		}
> +
> +		/* catch password-only URLs */
> +		if (uctx->c.login.username[0] =3D=3D '\0')
> +			uctx->c.login.username =3D NULL;
> +	}
> +	else {
> +		uctx->c.login.username =3D NULL;
> +		uctx->c.login.passwd =3D NULL;
> +	}
> +
> +	D((void)DBG_PRINTF(stdout, "login=3D'%s', passwd=3D'%s', rest=3D'%s'\n"=
,
> +		DBGNULLSTR(uctx->c.login.username),
> +		DBGNULLSTR(uctx->c.login.passwd),
> +		DBGNULLSTR(urlstr)));
> +
> +	char *raw_parameters;
> +
> +	uctx->c.num_parameters =3D 0;
> +	raw_parameters =3D strstr(urlstr, "?");
> +	/* Do we have a non-empty parameter string ? */
> +	if (raw_parameters && (raw_parameters[1] !=3D '\0')) {
> +		*raw_parameters++ =3D '\0';
> +		D((void)DBG_PRINTF(stdout, "raw parameters =3D '%s'\n", raw_parameters=
));
> +
> +		char *ps =3D raw_parameters;
> +		char *pv; /* parameter value */
> +		char *na; /* next '&' */
> +		char *pb =3D uctx->parameter_string_buff;
> +		char *pname;
> +		char *pvalue;
> +		ssize_t pi;
> +
> +		for (pi =3D 0; pi < MAX_URL_PARAMETERS ; pi++) {
> +			pname =3D ps;
> +
> +			/*
> +			 * Handle parameters without value,
> +			 * e.g. "path?name1&name2=3Dvalue2"
> +			 */
> +			na =3D strstr(ps, "&");
> +			pv =3D strstr(ps, "=3D");
> +			if (pv && (na?(na > pv):true)) {
> +				*pv++ =3D '\0';
> +				pvalue =3D pv;
> +				ps =3D pv;
> +			}
> +			else {
> +				pvalue =3D NULL;
> +			}
> +
> +			if (na) {
> +				*na++ =3D '\0';
> +			}
> +
> +			/* URLDecode parameter name */
> +			urldecodestr(pb, pname, strlen(pname));
> +			uctx->c.parameters[pi].name =3D pb;
> +			pb +=3D strlen(uctx->c.parameters[pi].name)+1;
> +
> +			/* URLDecode parameter value */
> +			if (pvalue) {
> +				urldecodestr(pb, pvalue, strlen(pvalue));
> +				uctx->c.parameters[pi].value =3D pb;
> +				pb +=3D strlen(uctx->c.parameters[pi].value)+1;
> +			}
> +			else {
> +				uctx->c.parameters[pi].value =3D NULL;
> +			}
> +
> +			/* Next '&' ? */
> +			if (!na)
> +				break;
> +
> +			ps =3D na;
> +		}
> +
> +		uctx->c.num_parameters =3D pi+1;
> +	}
> +
> +	s =3D strstr(urlstr, "/");
> +	if (s) {
> +		/* URL has hostport */
> +		slen =3D s-urlstr;
> +		urldecodestr(uctx->c.hostport.hostname, urlstr, slen);
> +		urlstr +=3D slen + 1;
> +
> +		/*
> +		 * check for addresses within '[' and ']', like
> +		 * IPv6 addresses
> +		 */
> +		s =3D uctx->c.hostport.hostname;
> +		if (s[0] =3D=3D '[')
> +			s =3D strstr(s, "]");
> +
> +		if (s =3D=3D NULL) {
> +			D((void)DBG_PUTS("url_parser: Unmatched '[' in hostname\n", stderr));
> +			return -1;
> +		}
> +
> +		s =3D strstr(s, ":");
> +		if (s) {
> +			/* found port number */
> +			uctx->c.hostport.port =3D atoi(s+1);
> +			*s =3D '\0';
> +		}
> +	}
> +	else {
> +		(void)strcpy(uctx->c.hostport.hostname, urlstr);
> +		uctx->c.path =3D NULL;
> +		urlstr =3D NULL;
> +	}
> +
> +	D(
> +		(void)DBG_PRINTF(stdout,
> +			"hostport=3D'%s', port=3D%d, rest=3D'%s', num_parameters=3D%d\n",
> +			DBGNULLSTR(uctx->c.hostport.hostname),
> +			uctx->c.hostport.port,
> +			DBGNULLSTR(urlstr),
> +			(int)uctx->c.num_parameters);
> +	);
> +
> +
> +	D(
> +		ssize_t dpi;
> +		for (dpi =3D 0 ; dpi < uctx->c.num_parameters ; dpi++) {
> +			(void)DBG_PRINTF(stdout,
> +				"param[%d]: name=3D'%s'/value=3D'%s'\n",
> +				(int)dpi,
> +				uctx->c.parameters[dpi].name,
> +				DBGNULLSTR(uctx->c.parameters[dpi].value));
> +		}
> +	);
> +
> +	if (!urlstr) {
> +		goto done;
> +	}
> +
> +	urldecodestr(uctx->c.path, urlstr, strlen(urlstr));
> +	D((void)DBG_PRINTF(stdout, "path=3D'%s'\n", uctx->c.path));
> +
> +done:
> +	return 0;
> +}
> +
> +void url_parser_free_context(url_parser_context *c)
> +{
> +	free(c);
> +}
> diff --git a/utils/mount/urlparser1.h b/utils/mount/urlparser1.h
> new file mode 100644
> index 00000000..515eea9d
> --- /dev/null
> +++ b/utils/mount/urlparser1.h
> @@ -0,0 +1,60 @@
> +/*
> + * MIT License
> + *
> + * Copyright (c) 2024 Roland Mainz <roland.mainz@nrubsig.org>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in all
> + * copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHE=
R
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN THE
> + * SOFTWARE.
> + */
> +
> +/* urlparser1.h - header for simple URL parser */
> +
> +#ifndef __URLPARSER1_H__
> +#define __URLPARSER1_H__ 1
> +
> +#include <stdlib.h>
> +
> +typedef struct _url_parser_name_value {
> +	char *name;
> +	char *value;
> +} url_parser_name_value;
> +
> +typedef struct _url_parser_context {
> +	char *in_url;
> +
> +	char *scheme;
> +	struct {
> +		char *username;
> +		char *passwd;
> +	} login;
> +	struct {
> +		char *hostname;
> +		signed int port;
> +	} hostport;
> +	char *path;
> +
> +	ssize_t num_parameters;
> +	url_parser_name_value *parameters;
> +} url_parser_context;
> +
> +/* Prototypes */
> +url_parser_context *url_parser_create_context(const char *in_url, unsign=
ed int flags);
> +int url_parser_parse(url_parser_context *uctx);
> +void url_parser_free_context(url_parser_context *c);
> +
> +#endif /* !__URLPARSER1_H__ */
> diff --git a/utils/mount/utils.c b/utils/mount/utils.c
> index b7562a47..3d55e997 100644
> --- a/utils/mount/utils.c
> +++ b/utils/mount/utils.c
> @@ -28,6 +28,7 @@
>  #include <unistd.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <iconv.h>
> =20
>  #include "sockaddr.h"
>  #include "nfs_mount.h"
> @@ -173,3 +174,157 @@ int nfs_umount23(const char *devname, char *string)
>  	free(dirname);
>  	return result;
>  }
> +
> +/* Convert UTF-8 string to multibyte string in the current locale */
> +char *utf8str2mbstr(const char *utf8_str)
> +{
> +	iconv_t cd;
> +
> +	cd =3D iconv_open("", "UTF-8");
> +	if (cd =3D=3D (iconv_t)-1) {
> +		perror("utf8str2mbstr: iconv_open failed");
> +		return NULL;
> +	}
> +
> +	size_t inbytesleft =3D strlen(utf8_str);
> +	char *inbuf =3D (char *)utf8_str;
> +	size_t outbytesleft =3D inbytesleft*4+1;
> +	char *outbuf =3D malloc(outbytesleft);
> +	char *outbuf_orig =3D outbuf;
> +
> +	if (!outbuf) {
> +		perror("utf8str2mbstr: out of memory");
> +		(void)iconv_close(cd);
> +		return NULL;
> +	}
> +
> +	int ret =3D iconv(cd, &inbuf, &inbytesleft, &outbuf, &outbytesleft);
> +	if (ret =3D=3D -1) {
> +		perror("utf8str2mbstr: iconv() failed");
> +		free(outbuf_orig);
> +		(void)iconv_close(cd);
> +		return NULL;
> +	}
> +
> +	*outbuf =3D '\0';
> +
> +	(void)iconv_close(cd);
> +	return outbuf_orig;
> +}
> +
> +/* fixme: We should use |bool|! */
> +int is_spec_nfs_url(const char *spec)
> +{
> +	return (!strncmp(spec, "nfs://", 6));
> +}
> +
> +int mount_parse_nfs_url(const char *spec, parsed_nfs_url *pnu)
> +{
> +	int result =3D 1;
> +	url_parser_context *uctx =3D NULL;
> +
> +	(void)memset(pnu, 0, sizeof(parsed_nfs_url));
> +	pnu->mount_params.read_only =3D TRIS_BOOL_NOT_SET;
> +
> +	uctx =3D url_parser_create_context(spec, 0);
> +	if (!uctx) {
> +		nfs_error(_("%s: out of memory"),
> +			progname);
> +		result =3D 1;
> +		goto done;
> +	}
> +
> +	if (url_parser_parse(uctx) < 0) {
> +		nfs_error(_("%s: Error parsing nfs://-URL."),
> +			progname);
> +		result =3D 1;
> +		goto done;
> +	}
> +	if (uctx->login.username || uctx->login.passwd) {
> +		nfs_error(_("%s: Username/Password are not defined for nfs://-URL."),
> +			progname);
> +		result =3D 1;
> +		goto done;
> +	}
> +	if (!uctx->path) {
> +		nfs_error(_("%s: Path missing in nfs://-URL."),
> +			progname);
> +		result =3D 1;
> +		goto done;
> +	}
> +	if (uctx->path[0] !=3D '/') {
> +		nfs_error(_("%s: Relative nfs://-URLs are not supported."),
> +			progname);
> +		result =3D 1;
> +		goto done;
> +	}
> +
> +	if (uctx->num_parameters > 0) {
> +		int pi;
> +		const char *pname;
> +		const char *pvalue;
> +
> +		/*
> +		 * Values added here based on URL parameters
> +		 * should be added the front of the list of options,
> +		 * so users can override the nfs://-URL given default.
> +		 */
> +		for (pi =3D 0; pi < uctx->num_parameters ; pi++) {
> +			pname =3D uctx->parameters[pi].name;
> +			pvalue =3D uctx->parameters[pi].value;
> +
> +			if (!strcmp(pname, "rw")) {
> +				if ((pvalue =3D=3D NULL) || (!strcmp(pvalue, "1"))) {
> +					pnu->mount_params.read_only =3D TRIS_BOOL_FALSE;
> +				}
> +				else if (!strcmp(pvalue, "0")) {
> +					pnu->mount_params.read_only =3D TRIS_BOOL_TRUE;
> +				}
> +				else {
> +					nfs_error(_("%s: Unsupported nfs://-URL "
> +						"parameter '%s' value '%s'."),
> +						progname, pname, pvalue);
> +					result =3D 1;
> +					goto done;
> +				}
> +			}
> +			else if (!strcmp(pname, "ro")) {
> +				if ((pvalue =3D=3D NULL) || (!strcmp(pvalue, "1"))) {
> +					pnu->mount_params.read_only =3D TRIS_BOOL_TRUE;
> +				}
> +				else if (!strcmp(pvalue, "0")) {
> +					pnu->mount_params.read_only =3D TRIS_BOOL_FALSE;
> +				}
> +				else {
> +					nfs_error(_("%s: Unsupported nfs://-URL "
> +						"parameter '%s' value '%s'."),
> +						progname, pname, pvalue);
> +					result =3D 1;
> +					goto done;
> +				}
> +			}
> +			else {
> +				nfs_error(_("%s: Unsupported nfs://-URL "
> +						"parameter '%s'."),
> +					progname, pname);
> +				result =3D 1;
> +				goto done;
> +			}
> +		}
> +	}
> +
> +	result =3D 0;
> +done:
> +	if (result !=3D 0) {
> +		url_parser_free_context(uctx);
> +		return 0;
> +	}
> +
> +	pnu->uctx =3D uctx;
> +	return 1;
> +}
> +
> +void mount_free_parse_nfs_url(parsed_nfs_url *pnu)
> +{
> +	url_parser_free_context(pnu->uctx);
> +}
> diff --git a/utils/mount/utils.h b/utils/mount/utils.h
> index 224918ae..465c0a5e 100644
> --- a/utils/mount/utils.h
> +++ b/utils/mount/utils.h
> @@ -24,13 +24,36 @@
>  #define _NFS_UTILS_MOUNT_UTILS_H
> =20
>  #include "parse_opt.h"
> +#include "urlparser1.h"
> =20
> +/* Boolean with three states: { not_set, false, true */
> +typedef signed char tristate_bool;
> +#define TRIS_BOOL_NOT_SET (-1)
> +#define TRIS_BOOL_TRUE (1)
> +#define TRIS_BOOL_FALSE (0)
> +
> +#define TRIS_BOOL_GET_VAL(tsb, tsb_default) \
> +	(((tsb)!=3DTRIS_BOOL_NOT_SET)?(tsb):(tsb_default))
> +
> +typedef struct _parsed_nfs_url {
> +	url_parser_context *uctx;
> +	struct {
> +		tristate_bool read_only;
> +	} mount_params;
> +} parsed_nfs_url;
> +
> +/* Prototypes */
>  int discover_nfs_mount_data_version(int *string_ver);
>  void print_one(char *spec, char *node, char *type, char *opts);
>  void mount_usage(void);
>  void umount_usage(void);
>  int chk_mountpoint(const char *mount_point);
> +char *utf8str2mbstr(const char *utf8_str);
> +int is_spec_nfs_url(const char *spec);
> =20
>  int nfs_umount23(const char *devname, char *string);
> =20
> +int mount_parse_nfs_url(const char *spec, parsed_nfs_url *pnu);
> +void mount_free_parse_nfs_url(parsed_nfs_url *pnu);
> +
>  #endif	/* !_NFS_UTILS_MOUNT_UTILS_H */

--=20
Jeff Layton <jlayton@kernel.org>

