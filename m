Return-Path: <linux-nfs+bounces-18702-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD2AEQdWg2mJlQMAu9opvQ
	(envelope-from <linux-nfs+bounces-18702-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 15:21:59 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E72ADE7012
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 15:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 681A730090BD
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 14:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDAE410D1A;
	Wed,  4 Feb 2026 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rotrR1zf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7B3410D1B
	for <linux-nfs@vger.kernel.org>; Wed,  4 Feb 2026 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214913; cv=none; b=BoEu2i4lTYPd4cKleakhCmcDQIaqftOIb06tCQ6LR822nKpTocFCzeVoLOZqCIm98ePhaEvEd0luCh7/juzRAhKM1UUrlFZRtwVqdahNw9zW5sNAWRdl3OozTH5TCa2XYApw2VqlbVbeO+t13v379up3sj3/HuJSvveIYdoUUD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214913; c=relaxed/simple;
	bh=t7qPyTT7TBvkw5HOjnR2+/m8avD83zCZ3UqUNrx1Zs8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RxcQb0mpNdr9Ms7RZkDmhohhR7iOHPuXnBfNOZO6sgH/V/CfT2iswDIW+pvrWz1GMohGUZtq0NL8LF0EdY0pR5C/rzYHcFNo/pYJPqeH0ImuoEaeWHc8YoXykfXo+3IZkmJntqK/mUrSHfomoexzaJonyYf2nlW+wrPG2O3Hngo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rotrR1zf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66815C4CEF7;
	Wed,  4 Feb 2026 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770214913;
	bh=t7qPyTT7TBvkw5HOjnR2+/m8avD83zCZ3UqUNrx1Zs8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rotrR1zfxHvh7KiWj69ZB7IPzs77gLQL56udwdFaFHk3vjaWW4tNRHOjmYnCJne+7
	 ePhTX8fOljL8bsWKarToM8r22h5v3+0EZVNFPDFrLjc/JCB5lugd9WWGnJ4W6aXXXi
	 H0TyODYq4Auhvp10JAti/dslj+Oo3drMm0qEIcq71AbbaNYvr+dbNx2qlb6/EMroCi
	 WNhiK4sv4Y/hRtV0kML5zzzYWG/eoG26XfNVw5JgBVTQwpcPWkGlE3wDPd3pi8gUqU
	 rlNwA6pG3mk+YHvg/ofNcPhFgmP52QKckCzlwTHa+1HZneQdoTo+uSd1e8HLFJQWwn
	 doqMpC7iTQciA==
Message-ID: <2edec478ce219943dfced2884f646687c7117892.camel@kernel.org>
Subject: Re: [PATCH v3 2/2] nfsdctl/rpc.nfsd: Add support for passing
 encrypted filehandle key
From: Jeff Layton <jlayton@kernel.org>
To: Benjamin Coddington <bcodding@hammerspace.com>, Steve Dickson
	 <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 NeilBrown	 <neil@brown.name>
Date: Wed, 04 Feb 2026 09:21:51 -0500
In-Reply-To: <1b3bdf869fe4075689fd29fe3fdb669ae3ea920c.1770051230.git.bcodding@hammerspace.com>
References: <cover.1770051230.git.bcodding@hammerspace.com>
	 <1b3bdf869fe4075689fd29fe3fdb669ae3ea920c.1770051230.git.bcodding@hammerspace.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18702-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,libnfsconf.la:url,hammerspace.com:email]
X-Rspamd-Queue-Id: E72ADE7012
X-Rspamd-Action: no action

On Mon, 2026-02-02 at 11:59 -0500, Benjamin Coddington wrote:
> If fh-key-file=3D<path> is set in the nfsd section of nfs.conf, the "nfsd=
ctl
> autostart" command will hash the contents of the file with libuuid's
> uuid_generate_sha1 and send the first 16 bytes into the kernel on
> NFSD_A_SERVER_FH_KEY.
>=20
> A compatible kernel can use this key to sign filehandles.
>=20
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  nfs.conf                     |  1 +
>  support/include/nfslib.h     |  2 +
>  support/nfs/Makefile.am      |  4 +-
>  support/nfs/fh_key_file.c    | 79 ++++++++++++++++++++++++++++++++++++
>  systemd/nfs.conf.man         |  1 +
>  utils/nfsd/nfssvc.h          |  1 +
>  utils/nfsdctl/nfsd_netlink.h |  1 +
>  utils/nfsdctl/nfsdctl.c      | 35 ++++++++++++++--
>  8 files changed, 118 insertions(+), 6 deletions(-)
>  create mode 100644 support/nfs/fh_key_file.c
>=20
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
> @@ -132,6 +133,7 @@ struct rmtabent *	fgetrmtabent(FILE *fp, int log, lon=
g *pos);
>  void			fputrmtabent(FILE *fp, struct rmtabent *xep, long *pos);
>  void			fendrmtabent(FILE *fp);
>  void			frewindrmtabent(FILE *fp);
> +int				hash_fh_key_file(const char *fh_key_file, uuid_t hash);
> =20
>  _Bool state_setup_basedir(const char *, const char *);
>  int setup_state_path_names(const char *, const char *, const char *, con=
st char *, struct state_paths *);
> diff --git a/support/nfs/Makefile.am b/support/nfs/Makefile.am
> index 2e1577cc12df..775bccc6c5ea 100644
> --- a/support/nfs/Makefile.am
> +++ b/support/nfs/Makefile.am
> @@ -7,8 +7,8 @@ libnfs_la_SOURCES =3D exports.c rmtab.c xio.c rpcmisc.c r=
pcdispatch.c \
>  		   xcommon.c wildmat.c mydaemon.c \
>  		   rpc_socket.c getport.c \
>  		   svc_socket.c cacheio.c closeall.c nfs_mntent.c \
> -		   svc_create.c atomicio.c strlcat.c strlcpy.c
> -libnfs_la_LIBADD =3D libnfsconf.la
> +		   svc_create.c atomicio.c strlcat.c strlcpy.c fh_key_file.c
> +libnfs_la_LIBADD =3D libnfsconf.la -luuid
>  libnfs_la_CPPFLAGS =3D $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/suppor=
t/reexport
> =20
>  libnfsconf_la_SOURCES =3D conffile.c xlog.c
> diff --git a/support/nfs/fh_key_file.c b/support/nfs/fh_key_file.c
> new file mode 100644
> index 000000000000..ee26df5b70bd
> --- /dev/null
> +++ b/support/nfs/fh_key_file.c
> @@ -0,0 +1,79 @@
> +/*
> + * Copyright (c) 2025 Benjamin Coddington <bcodding@hammerspace.com>
> + * All rights reserved.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in th=
e
> + *    documentation and/or other materials provided with the distributio=
n.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
> + * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRAN=
TIES
> + * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIME=
D.
> + * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, =
BUT
> + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF =
USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF
> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <uuid/uuid.h>
> +
> +#include "nfslib.h"
> +
> +#define HASH_BLOCKSIZE  256
> +int hash_fh_key_file(const char *fh_key_file, uuid_t uuid)
> +{
> +	const char seed_s[] =3D "8fc57f1b-1a6f-482f-af92-d2e007c1ae58";
> +	FILE *sfile =3D NULL;
> +	char buf[HASH_BLOCKSIZE];
> +	size_t pos;
> +	int ret =3D 0;
> +
> +	sfile =3D fopen(fh_key_file, "r");
> +	if (!sfile) {
> +		ret =3D errno;
> +		xlog(L_ERROR, "Unable to read fh-key-file %s: %s", fh_key_file, strerr=
or(errno));
> +		goto out;
> +	}
> +
> +	uuid_parse(seed_s, uuid);
> +
> +	while (1) {
> +		size_t sread;
> +		pos =3D 0;
> +
> +		if (feof(sfile))
> +			goto finish_block;
> +
> +		sread =3D fread(buf + pos, 1, HASH_BLOCKSIZE - pos, sfile);
> +		pos +=3D sread;
> +
> +		if (pos =3D=3D HASH_BLOCKSIZE)
> +			break;
> +
> +		if (sread !=3D HASH_BLOCKSIZE) {
> +			ret =3D ferror(sfile);
> +			if (ret)
> +				goto out;
> +			goto finish_block;
> +		}
> +		uuid_generate_sha1(uuid, uuid, buf, HASH_BLOCKSIZE);
> +	}
> +finish_block:
> +	if (pos)
> +		uuid_generate_sha1(uuid, uuid, buf, pos);
> +out:
> +	if (sfile)
> +		fclose(sfile);
> +	return ret;
> +}
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
> diff --git a/utils/nfsd/nfssvc.h b/utils/nfsd/nfssvc.h
> index 4d53af1a8bc3..463110cac804 100644
> --- a/utils/nfsd/nfssvc.h
> +++ b/utils/nfsd/nfssvc.h
> @@ -30,3 +30,4 @@ void	nfssvc_setvers(unsigned int ctlbits, unsigned int =
minorvers4,
>  		       unsigned int minorvers4set, int force4dot0);
>  int	nfssvc_threads(int nrservs);
>  void	nfssvc_get_minormask(unsigned int *mask);
> +int nfssvc_setfh_key(const char *fh_key_file);
> diff --git a/utils/nfsdctl/nfsd_netlink.h b/utils/nfsdctl/nfsd_netlink.h
> index 887cbd12b695..10df6d750fa1 100644
> --- a/utils/nfsdctl/nfsd_netlink.h
> +++ b/utils/nfsdctl/nfsd_netlink.h
> @@ -34,6 +34,7 @@ enum {
>  	NFSD_A_SERVER_GRACETIME,
>  	NFSD_A_SERVER_LEASETIME,
>  	NFSD_A_SERVER_SCOPE,
> +	NFSD_A_SERVER_FH_KEY,
> =20

I forgot this file was even there!

We'll need to add MIN_THREADS to this before your value, or this won't
line up properly. I suppose if we do that too, then we can rip out the
autoconf check for that constant as well, and get rid of the #ifdefs. I
can send a v2 of the series I just sent that just does this.

You will also want to rebase this on top of those patches, so you can
better handle the case where the kernel doesn't support setting a
fh_key. I suppose you probably want to throw a hard error in that case,
since being unable to set the key could be a security issue (or cause
stale filehandles)?

>  	__NFSD_A_SERVER_MAX,
>  	NFSD_A_SERVER_MAX =3D (__NFSD_A_SERVER_MAX - 1)
> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> index 67cf27b04ca3..1d673d7bdc90 100644
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
> @@ -524,8 +526,10 @@ out:
>  }
> =20
>  static int threads_doit(struct nl_sock *sock, int cmd, int grace, int le=
ase,
> -			int pool_count, int *pool_threads, char *scope, int minthreads)
> +			int pool_count, int *pool_threads, char *scope, int minthreads,
> +			uuid_t fh_key)
>  {
> +	struct nl_data *fh_key_data =3D NULL;
>  	struct genlmsghdr *ghdr;
>  	struct nlmsghdr *nlh;
>  	struct nl_msg *msg;
> @@ -550,6 +554,15 @@ static int threads_doit(struct nl_sock *sock, int cm=
d, int grace, int lease,
>  		if (minthreads >=3D 0)
>  			nla_put_u32(msg, NFSD_A_SERVER_MIN_THREADS, minthreads);
>  #endif
> +		if (!uuid_is_null(fh_key)) {
> +			fh_key_data =3D nl_data_alloc(fh_key, sizeof(uuid_t));
> +			if (!fh_key_data) {
> +				xlog(L_ERROR, "failed to allocate netlink data");
> +				ret =3D 1;
> +				goto out;
> +			}
> +			nla_put_data(msg, NFSD_A_SERVER_FH_KEY, fh_key_data);
> +		}
>  		for (i =3D 0; i < pool_count; ++i)
>  			nla_put_u32(msg, NFSD_A_SERVER_THREADS, pool_threads[i]);
>  	}
> @@ -584,6 +597,8 @@ static int threads_doit(struct nl_sock *sock, int cmd=
, int grace, int lease,
>  out_cb:
>  	nl_cb_put(cb);
>  out:
> +	if (fh_key_data)
> +		nl_data_free(fh_key_data);
>  	nlmsg_free(msg);
>  	return ret;
>  }
> @@ -612,6 +627,7 @@ static int threads_func(struct nl_sock *sock, int arg=
c, char **argv)
>  	int *pool_threads =3D NULL;
>  	int minthreads =3D -1;
>  	int opt, pools =3D 0;
> +	uuid_t fh_key;
> =20
>  	optind =3D 1;
>  	while ((opt =3D getopt_long(argc, argv, "h", threads_options, NULL)) !=
=3D -1) {
> @@ -654,7 +670,9 @@ static int threads_func(struct nl_sock *sock, int arg=
c, char **argv)
>  			}
>  		}
>  	}
> -	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL, minthre=
ads);
> +	uuid_clear(fh_key);
> +	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL,
> +				minthreads, fh_key);
>  }
> =20
>  /*
> @@ -1611,8 +1629,9 @@ static int autostart_func(struct nl_sock *sock, int=
 argc, char ** argv)
>  	int *threads, grace, lease, idx, ret, opt, pools, minthreads;
>  	struct conf_list *thread_str;
>  	struct conf_list_node *n;
> -	char *scope, *pool_mode;
> +	char *scope, *pool_mode, *fh_key_file;
>  	bool failed_listeners =3D false;
> +	uuid_t fh_key;
> =20
>  	optind =3D 1;
>  	while ((opt =3D getopt_long(argc, argv, "h", help_only_options, NULL)) =
!=3D -1) {
> @@ -1687,12 +1706,20 @@ static int autostart_func(struct nl_sock *sock, i=
nt argc, char ** argv)
>  		threads[0] =3D DEFAULT_AUTOSTART_THREADS;
>  	}
> =20
> +	uuid_clear(fh_key);
> +	fh_key_file =3D conf_get_str("nfsd", "fh-key-file");
> +	if (fh_key_file) {
> +		ret =3D hash_fh_key_file(fh_key_file, fh_key);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	lease =3D conf_get_num("nfsd", "lease-time", 0);
>  	scope =3D conf_get_str("nfsd", "scope");
>  	minthreads =3D conf_get_num("nfsd", "min-threads", 0);
> =20
>  	ret =3D threads_doit(sock, NFSD_CMD_THREADS_SET, grace, lease, pools,
> -			   threads, scope, minthreads);
> +			   threads, scope, minthreads, fh_key);
>  out:
>  	free(threads);
>  	return ret;

--=20
Jeff Layton <jlayton@kernel.org>

