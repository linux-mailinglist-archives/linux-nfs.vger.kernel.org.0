Return-Path: <linux-nfs+bounces-18079-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF889D3913F
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Jan 2026 22:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 525923014A1E
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Jan 2026 21:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D22428851E;
	Sat, 17 Jan 2026 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Wr0gaasW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K95BFPZ3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C927E7F0
	for <linux-nfs@vger.kernel.org>; Sat, 17 Jan 2026 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768686807; cv=none; b=WSDy522YAVpmdrR1Ef7uQCcPzzHSt6OnSWthhIupxRk0lqS0h/ZJ38LYvip+/lwbvrMdmsGU0McYl4NCf2AFuVPNp1MOgegO7f/v+tEvC8FqjB7qeUCaQ8EmC9ApsBAJhPOrWrZhW1VjHxY9hRcVHj8Uc19Et0p3YwzVbVgMeqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768686807; c=relaxed/simple;
	bh=yB+wIJkyb8TJNDjhSRA7IVZ3/Z3VTZLbscPvvhDU/dw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Cm22+cXzXmMyz506qfMbDHoPlvlvucxDYr+SDd4E/Ezz0WxKPZ+P+VaIywkE0RyQplVIPjFyHMAWRZQu9xUuHLU4A+f6w7ShHqjiecdXV63CS36bKLt0SAoM9tfiNMCrpjI6uSOQGTY/h4yhR4KZxwzJe8ql50kZIRQcUwgC9Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Wr0gaasW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K95BFPZ3; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F5651400220;
	Sat, 17 Jan 2026 16:53:23 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 17 Jan 2026 16:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768686803; x=1768773203; bh=pNttIx7APmDArlzFM5U5wr1pTUHXvEGY0jV
	x84xW1Ws=; b=Wr0gaasWaTH375+RKA7FuXPStHhKz4TYG0RbyhT9+bGxw79HEnn
	/SqdpJKogs1B+CKFNEKJptZjeJhWJSQdvFyM65OPSpyxqe8P5hMG2S1oerylkT7s
	dQ9cbuaDPdVEXfxshSshK0iBI2YWipXXvzABGSXJN4oTvDj2tts1gS4U0YaEefMz
	g+Z6uKITlzFlnAj9WJkGy21ARTsngvwPqcU1hE6Vr2j9HX28sazt3FYYT756HCGh
	P+dH35xw4QwsqR0h5ceEg+44xZPdu25gpUp11QosYT9d1K2xf1qRBCKcYw8XykGe
	sh42UjPkg4yb/7tRtQFFJ2Ag23AE/Y5p1Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768686803; x=
	1768773203; bh=pNttIx7APmDArlzFM5U5wr1pTUHXvEGY0jVx84xW1Ws=; b=K
	95BFPZ3nFw0+65JOrQ7DK0tGPc09D1f2VIhmDN6wO121vvdT4Ew9Ock3v49iObYg
	jvoocihG3FJNZhIviIbnsa4MZtwH7g7piYrbRAQUEQHbpb0nnHE9/hGBDOLpuUpe
	m4Fl0wdNcjjBmSldZGS46BGyLziOLk5DKpchEkDMSDUZJLb4plWd1VtMlzWwgN+F
	bQREWkPLNLmXznmIdsrIeD7N4EUx/v9sUU4xCIxcbt1C+MvraQx3hcW6ls4NIKDn
	vTZmdRQ53iq14ALX/AQehFsAWwFrGuumBuil40L9GGPkxTWeFDeuWcPLPfse61Uq
	Uo6tk+uk1NXFYfgh5/Mjw==
X-ME-Sender: <xms:0wRsaV_zPMQHpV6NgYBSaeXTxaIlG__s4tHDUnohPNcuq87hVedwbw>
    <xme:0wRsaQngWykN-Ed9X7kKie-WCOaAWhXWJzmgmLCC95zsIzwXXSBnaHgTyZnRjMK75
    JLmAD8z-StlnoJzG_J458Ae_SJsboF41TBBLdKzzG195NKF>
X-ME-Received: <xmr:0wRsabUMxSAjia6lHyzL2Ok8lxg89-3Zl-EoEcwmHzUkOdw1XxTUJlJAcoZ6n_6-ePckJyrAsbCzZTfa4ud2AOVkhOkuR2VhAdGlTeF-73uN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedvleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    ephefgudejgfelhfehkeefteefueffgeejgfelgeffvdelhfekleevleeifffgvddunecu
    ffhomhgrihhnpegtohhnfhdrmhgrnhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhnfh
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghvvggusehrvggu
    hhgrthdrtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtg
    homhdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegstghougguihhngheshhgrmhhmvghrshhprggtvgdrtghomh
X-ME-Proxy: <xmx:0wRsaVExzi-CYSB3QVjeyMRFAu3EMJhIB9cTKXapjxmFm4ejVfnGAA>
    <xmx:0wRsaXeC24R5jqGS2hB3GOroSHkwOBE7EWXl3xm4uxei_uhUahYH5A>
    <xmx:0wRsaWLQXURkWlbwRMuHx-zYSCp9Vzhy_W6R_ypj1KTQELwvLjuXvQ>
    <xmx:0wRsacENu9FLXR15hC8vFHujCjhDP2EN74TPJWh2l5FsmBtvOi2uww>
    <xmx:0wRsafEUjsB6OLCwdtSRI4vBoEf5lJCsopAkNCPfI7RwUM4VMJI_fk17>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Jan 2026 16:53:21 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: "Steve Dickson" <steved@redhat.com>,
 "Benjamin Coddington" <bcodding@hammerspace.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v1 1/2] nfsdctl/rpc.nfsd: Add support for passing
 encrypted filehandle key
In-reply-to: =?utf-8?q?=3C90fad47b2b34117ae30373569a5e5a87ef63cec7=2E1768586?=
 =?utf-8?q?942=2Egit=2Ebcodding=40hammerspace=2Ecom=3E?=
References: <cover.1768586942.git.bcodding@hammerspace.com>, =?utf-8?q?=3C90?=
 =?utf-8?q?fad47b2b34117ae30373569a5e5a87ef63cec7=2E1768586942=2Egit=2Ebcodd?=
 =?utf-8?q?ing=40hammerspace=2Ecom=3E?=
Date: Sun, 18 Jan 2026 08:53:17 +1100
Message-id: <176868679725.16766.14739276568986177664@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 17 Jan 2026, Benjamin Coddington wrote:
> If fh-key-file=3D<path> is set in nfs.conf, the "nfsdctl autostart" command

... is set in THE NFSD SECTION OF nfs.conf


> will hash the contents of the file with libuuid's uuid_generate_sha1 and
> send the first 16 bytes into the kernel via NFSD_CMD_FH_KEY_SET.

This patch adds no code that uses uuid_generate_sha1(), and doesn't
provide any code for hash_fh_key_file()...

>=20
> If fh-key-file=3D<path> is set in nfs.conf, rpc.nfsd will also hash the
> contents of the file with libuuid's uuid_generate_sha1 and write the
> resulting uuid into nfsdfs's ./fh_key_file entry.
>=20
> A compatible kernel can use this key to sign filehandles.
>=20
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  configure.ac                 |  4 +-
>  nfs.conf                     |  1 +
>  support/include/nfslib.h     |  2 +
>  support/nfs/Makefile.am      |  4 +-
>  systemd/nfs.conf.man         |  1 +
>  utils/nfsd/nfsd.c            | 16 ++++++-
>  utils/nfsd/nfssvc.c          | 26 +++++++++++
>  utils/nfsd/nfssvc.h          |  1 +
>  utils/nfsdctl/nfsd_netlink.h |  2 +
>  utils/nfsdctl/nfsdctl.c      | 86 +++++++++++++++++++++++++++++++++++-
>  10 files changed, 137 insertions(+), 6 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index 33866e869666..db027ddbd995 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -265,9 +265,9 @@ AC_ARG_ENABLE(nfsdctl,
>  		AC_CHECK_DECLS([NFSD_A_SERVER_MIN_THREADS], , ,
>  			       [#include <linux/nfsd_netlink.h>])
> =20
> -		# ensure we have the pool-mode commands
> +		# ensure we have the fh-key commands
>  		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/nfsd_netlink.h>]],
> -				                   [[int foo =3D NFSD_CMD_POOL_MODE_GET;]])],
> +				                   [[int foo =3D NFSD_CMD_FH_KEY_SET;]])],
>  				   [AC_DEFINE([USE_SYSTEM_NFSD_NETLINK_H], 1,
>  					      ["Use system's linux/nfsd_netlink.h"])])
>  		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/lockd_netlink.h>]],
> diff --git a/nfs.conf b/nfs.conf
> index 3cca68c3530d..39068c19d7df 100644
> --- a/nfs.conf
> +++ b/nfs.conf
> @@ -76,6 +76,7 @@
>  # vers4.2=3Dy
>  rdma=3Dy
>  rdma-port=3D20049
> +# fh-key-file=3D/etc/nfs_fh.key
> =20
>  [statd]
>  # debug=3D0
> diff --git a/support/include/nfslib.h b/support/include/nfslib.h
> index eff2a486307f..c8601a156cba 100644
> --- a/support/include/nfslib.h
> +++ b/support/include/nfslib.h
> @@ -22,6 +22,7 @@
>  #include <paths.h>
>  #include <rpcsvc/nfs_prot.h>
>  #include <nfs/nfs.h>
> +#include <uuid/uuid.h>
>  #include "xlog.h"
> =20
>  #ifndef _PATH_EXPORTS
> @@ -132,6 +133,7 @@ struct rmtabent *	fgetrmtabent(FILE *fp, int log, long =
*pos);
>  void			fputrmtabent(FILE *fp, struct rmtabent *xep, long *pos);
>  void			fendrmtabent(FILE *fp);
>  void			frewindrmtabent(FILE *fp);
> +int				hash_fh_key_file(const char *fh_key_file, uuid_t hash);
> =20
>  _Bool state_setup_basedir(const char *, const char *);
>  int setup_state_path_names(const char *, const char *, const char *, const=
 char *, struct state_paths *);
> diff --git a/support/nfs/Makefile.am b/support/nfs/Makefile.am
> index 2e1577cc12df..775bccc6c5ea 100644
> --- a/support/nfs/Makefile.am
> +++ b/support/nfs/Makefile.am
> @@ -7,8 +7,8 @@ libnfs_la_SOURCES =3D exports.c rmtab.c xio.c rpcmisc.c rpc=
dispatch.c \
>  		   xcommon.c wildmat.c mydaemon.c \
>  		   rpc_socket.c getport.c \
>  		   svc_socket.c cacheio.c closeall.c nfs_mntent.c \
> -		   svc_create.c atomicio.c strlcat.c strlcpy.c
> -libnfs_la_LIBADD =3D libnfsconf.la
> +		   svc_create.c atomicio.c strlcat.c strlcpy.c fh_key_file.c
> +libnfs_la_LIBADD =3D libnfsconf.la -luuid
>  libnfs_la_CPPFLAGS =3D $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/support/=
reexport
> =20
>  libnfsconf_la_SOURCES =3D conffile.c xlog.c
> diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
> index 484de2c086db..1fb5653042d3 100644
> --- a/systemd/nfs.conf.man
> +++ b/systemd/nfs.conf.man
> @@ -176,6 +176,7 @@ Recognized values:
>  .BR vers4.1 ,
>  .BR vers4.2 ,
>  .BR rdma ,
> +.BR fh-key-file ,
> =20
>  Version and protocol values are Boolean values as described above,
>  and are also used by
> diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
> index a405649976c2..08a7eaed4906 100644
> --- a/utils/nfsd/nfsd.c
> +++ b/utils/nfsd/nfsd.c
> @@ -69,7 +69,7 @@ int
>  main(int argc, char **argv)
>  {
>  	int	count =3D NFSD_NPROC, c, i, j, error =3D 0, portnum, fd, found_one;
> -	char *p, *progname, *port, *rdma_port =3D NULL;
> +	char *p, *progname, *port, *fh_key_file, *rdma_port =3D NULL;
>  	char **haddr =3D NULL;
>  	char *scope =3D NULL;
>  	int hcounter =3D 0;
> @@ -134,6 +134,8 @@ main(int argc, char **argv)
>  		}
>  	}
> =20
> +	fh_key_file =3D conf_get_str("nfsd", "fh-key-file");
> +
>  	/* We assume the kernel will default all minor versions to 'on',
>  	 * and allow the config file to disable some.
>  	 */
> @@ -380,6 +382,18 @@ main(int argc, char **argv)
>  		goto set_threads;
>  	}
> =20
> +	if (fh_key_file) {
> +		error =3D nfssvc_setfh_key(fh_key_file);
> +		if (error) {
> +			/* Common case: key is already set */
> +			if (error !=3D -EEXIST) {
> +				xlog(L_ERROR, "Unable to set fh_key_file, error %d", error);
> +				goto out;
> +			}
> +			xlog(L_NOTICE, "fh_key_file already set");
> +		}
> +	}
> +
>  	/*
>  	 * Must set versions before the fd's so that the right versions get
>  	 * registered with rpcbind. Note that on older kernels w/o the right
> diff --git a/utils/nfsd/nfssvc.c b/utils/nfsd/nfssvc.c
> index 9650cecee986..4f3088b74285 100644
> --- a/utils/nfsd/nfssvc.c
> +++ b/utils/nfsd/nfssvc.c
> @@ -34,6 +34,7 @@
>  #define NFSD_PORTS_FILE   NFSD_FS_DIR "/portlist"
>  #define NFSD_VERS_FILE    NFSD_FS_DIR "/versions"
>  #define NFSD_THREAD_FILE  NFSD_FS_DIR "/threads"
> +#define NFSD_FH_KEY_FILE  NFSD_FS_DIR "/fh_key"
> =20
>  /*
>   * declaring a common static scratch buffer here keeps us from having to
> @@ -414,6 +415,31 @@ out:
>  	return;
>  }
> =20
> +int
> +nfssvc_setfh_key(const char *fh_key_file)
> +{
> +	char uuid_str[37];
> +	uuid_t hash;
> +	int fd, ret;
> +
> +	ret =3D hash_fh_key_file(fh_key_file, hash);
> +	if (ret)
> +		return ret;
> +
> +	uuid_unparse(hash, uuid_str);
> +
> +	fd =3D open(NFSD_FH_KEY_FILE, O_WRONLY);
> +	if (fd < 0)
> +		return fd;

return -errno ??

> +
> +	ret =3D write(fd, uuid_str, 37);
> +	close(fd);
> +	if (ret < 0)
> +		return -errno;
> +
> +	return 0;
> +}
> +
>  int
>  nfssvc_threads(const int nrservs)
>  {
> diff --git a/utils/nfsd/nfssvc.h b/utils/nfsd/nfssvc.h
> index 4d53af1a8bc3..463110cac804 100644
> --- a/utils/nfsd/nfssvc.h
> +++ b/utils/nfsd/nfssvc.h
> @@ -30,3 +30,4 @@ void	nfssvc_setvers(unsigned int ctlbits, unsigned int mi=
norvers4,
>  		       unsigned int minorvers4set, int force4dot0);
>  int	nfssvc_threads(int nrservs);
>  void	nfssvc_get_minormask(unsigned int *mask);
> +int nfssvc_setfh_key(const char *fh_key_file);
> diff --git a/utils/nfsdctl/nfsd_netlink.h b/utils/nfsdctl/nfsd_netlink.h
> index 887cbd12b695..f7e7f5576774 100644
> --- a/utils/nfsdctl/nfsd_netlink.h
> +++ b/utils/nfsdctl/nfsd_netlink.h
> @@ -34,6 +34,7 @@ enum {
>  	NFSD_A_SERVER_GRACETIME,
>  	NFSD_A_SERVER_LEASETIME,
>  	NFSD_A_SERVER_SCOPE,
> +	NFSD_A_SERVER_FH_KEY,
> =20
>  	__NFSD_A_SERVER_MAX,
>  	NFSD_A_SERVER_MAX =3D (__NFSD_A_SERVER_MAX - 1)
> @@ -88,6 +89,7 @@ enum {
>  	NFSD_CMD_LISTENER_GET,
>  	NFSD_CMD_POOL_MODE_SET,
>  	NFSD_CMD_POOL_MODE_GET,
> +	NFSD_CMD_FH_KEY_SET,
> =20
>  	__NFSD_CMD_MAX,
>  	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> index 48b3ba0b276c..efd4c1cf6d8a 100644
> --- a/utils/nfsdctl/nfsdctl.c
> +++ b/utils/nfsdctl/nfsdctl.c
> @@ -29,6 +29,7 @@
> =20
>  #include <readline/readline.h>
>  #include <readline/history.h>
> +#include <uuid/uuid.h>
> =20
>  #ifdef USE_SYSTEM_NFSD_NETLINK_H
>  #include <linux/nfsd_netlink.h>
> @@ -42,6 +43,7 @@
>  #include "lockd_netlink.h"
>  #endif
> =20
> +#include "nfslib.h"
>  #include "nfsdctl.h"
>  #include "conffile.h"
>  #include "xlog.h"
> @@ -1597,6 +1599,81 @@ static int configure_listeners(void)
>  	return ret;
>  }
> =20
> +static int fh_key_file_doit(struct nl_sock *sock, const char *fh_key_file)
> +{
> +	struct genlmsghdr *ghdr;
> +	struct nlmsghdr *nlh;
> +	struct nl_data *data;
> +	struct nl_msg *msg;
> +	struct nl_cb *cb;
> +	int ret;
> +	uuid_t hash;
> +
> +	ret =3D hash_fh_key_file(fh_key_file, hash);
> +	if (ret)
> +		return ret;
> +
> +	msg =3D netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
> +	if (!msg) {
> +		xlog(L_ERROR, "failed to allocate netlink msg");
> +		return 1;
> +	}
> +
> +	data =3D nl_data_alloc(hash, sizeof(hash));
> +	if (!data) {
> +		xlog(L_ERROR, "failed to allocate netlink data");
> +		ret =3D 1;
> +		goto out;
> +	}
> +
> +	nla_put_data(msg, NFSD_A_SERVER_FH_KEY, data);
> +	nlh =3D nlmsg_hdr(msg);
> +	ghdr =3D nlmsg_data(nlh);
> +	ghdr->cmd =3D NFSD_CMD_FH_KEY_SET;
> +	cb =3D nl_cb_alloc(NL_CB_CUSTOM);
> +	if (!cb) {
> +		xlog(L_ERROR, "failed to allocate netlink callbacks");
> +		ret =3D 1;
> +		goto out_data;
> +	}
> +
> +	ret =3D nl_send_auto(sock, msg);
> +	if (ret < 0) {
> +		xlog(L_ERROR, "send failed (%d)!", ret);
> +		goto out_cb;
> +	}
> +
> +	ret =3D 1;
> +	nl_cb_err(cb, NL_CB_CUSTOM, error_handler, &ret);
> +	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, finish_handler, &ret);
> +	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_handler, &ret);
> +	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, recv_handler, NULL);
> +
> +	while (ret > 0)
> +		nl_recvmsgs(sock, cb);
> +	if (ret < 0) {
> +		if (ret =3D=3D -EOPNOTSUPP) {
> +			xlog(L_ERROR, "Kernel does not support encrypted filehandles: %s",
> +						strerror(-ret));
> +			ret =3D 0;
> +		} else if (ret =3D=3D -EEXIST) {
> +			xlog(L_ERROR, "fh_key_file already set: %s", strerror(-ret));
> +			ret =3D 0;
> +		} else {
> +			xlog(L_ERROR, "Error setting encrypted filehandle key: %s",
> +						strerror(-ret));
> +			ret =3D 1;
> +		}
> +	}
> +out_cb:
> +	nl_cb_put(cb);
> +out_data:
> +	nl_data_free(data);
> +out:
> +	nlmsg_free(msg);
> +	return ret;
> +}
> +
>  static void autostart_usage(void)
>  {
>  	printf("Usage: %s autostart\n", taskname);
> @@ -1611,7 +1688,7 @@ static int autostart_func(struct nl_sock *sock, int a=
rgc, char ** argv)
>  	int *threads, grace, lease, idx, ret, opt, pools, minthreads;
>  	struct conf_list *thread_str;
>  	struct conf_list_node *n;
> -	char *scope, *pool_mode;
> +	char *scope, *pool_mode, *fh_key_file;
>  	bool failed_listeners =3D false;
> =20
>  	optind =3D 1;
> @@ -1683,6 +1760,13 @@ static int autostart_func(struct nl_sock *sock, int =
argc, char ** argv)
>  		threads[0] =3D DEFAULT_AUTOSTART_THREADS;
>  	}
> =20
> +	fh_key_file =3D conf_get_str("nfsd", "fh-key-file");
> +	if (fh_key_file) {
> +		ret =3D fh_key_file_doit(sock, fh_key_file);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	lease =3D conf_get_num("nfsd", "lease-time", 0);
>  	scope =3D conf_get_str("nfsd", "scope");
>  	minthreads =3D conf_get_num("nfsd", "min-threads", 0);
> --=20
> 2.50.1
>=20
>=20

I haven't reviewed the netlink parts because I don't know the API well,
but the rest seems ok, except for the missing code.

Thanks,
NeilBrown

