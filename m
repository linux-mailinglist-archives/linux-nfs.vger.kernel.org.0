Return-Path: <linux-nfs+bounces-20217-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMINHaQiuGk8ZgEAu9opvQ
	(envelope-from <linux-nfs+bounces-20217-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:32:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5261F29C722
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3570E3067363
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586A23AB275;
	Mon, 16 Mar 2026 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqZn9YSf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344613AA51F
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674783; cv=none; b=M8s9SShbaUkWSiZefdUixdufGz9a9aUhq89qVD483YhCNeQsU4z4uzjcmfVnLdneeaAwj67WunrPY2iWuwl5NyxctY14RClUxyt4IOdYhdocetxHbSwK7v8G172K5fx+uCn38VJ372IVCwB1hxnt7AUZ7w/VGwaZfxjBC96jzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674783; c=relaxed/simple;
	bh=Bl+Sg2962bEREg5EQCtoUQN5xkeoaglS8FD+ZN/gPU0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SjnxLCLTZ1V5KwZ3q1P8WygRVpu73TiclgPwXiJiQENIsJs0dtYahK5BLHtRCnfUnBfsKT73O1iRxh1APe/EuqgVLQs68XItwsI/XoZplp7mWrTDnWe+G0q96JUssfhLiFvVdk5T5YAhHVfMpPkfmU8QUiNSCOFKBRZJIGF74uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqZn9YSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B2FC19425;
	Mon, 16 Mar 2026 15:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674783;
	bh=Bl+Sg2962bEREg5EQCtoUQN5xkeoaglS8FD+ZN/gPU0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jqZn9YSfEtv5Ob7yt5J/Opa3rATgFn74pFvNJIBilMoCPffOhiEb4GZmXS5bBEJR6
	 kmiShy0RN/l6fR/9lrNr+9aJi85TkVzwxxhuOSCnPtZ6XV+ZOtDCNAXyyChb4mB/My
	 ZY+zclGAoh4AfAuDhKq3hzBxERUrrAPuKdddu69KjvUkBtxyWsYzvNzELCZLXI/gsD
	 6wHlLADabhYQ3QDtZbx1Da0sGwFHNOop6TvDl2pX1C6SWiOhGqP/GKf9+idwIX35fh
	 3wMgQp+0KAhJukz5ut+wKlGWujeWEOnoWjOO8tp80rgYO0jyIHzY9OX203lY+tXI2/
	 fqMCUJB4cCuig==
Message-ID: <827711a4da6eb44e71dd855904313c49a25939a7.camel@kernel.org>
Subject: Re: [PATCH nfs-utils 17/17] mountd/exportd/exportfs: add
 --no-netlink option to disable netlink
From: Jeff Layton <jlayton@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Date: Mon, 16 Mar 2026 11:26:19 -0400
In-Reply-To: <20260316-exportd-netlink-v1-17-9a408a0b389d@kernel.org>
References: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
	 <20260316-exportd-netlink-v1-17-9a408a0b389d@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20217-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5261F29C722
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-03-16 at 11:16 -0400, Jeff Layton wrote:
> Add a --no-netlink command-line option (short: -L) and no-netlink=3D
> config file setting that disables netlink support, forcing the use of
> /proc interfaces instead.
>=20
> For mountd and exportd, the setting lives in their respective [mountd]
> and [exportd] sections of nfs.conf. For exportfs, it's in the
> [exportfs] section.

Correction: exportfs doesn't have a section. It will look for the
setting in the mountd and exportd sections. I'll fix up the commit log
in my tree.

>=20
> This is useful for debugging, testing the /proc fallback path, or
> working around kernel netlink issues.
> ---
>  support/export/cache.c       |  3 ++-
>  support/export/cache_flush.c |  4 ++-
>  utils/exportd/exportd.c      | 10 ++++++--
>  utils/exportd/exportd.man    | 12 +++++++--
>  utils/exportfs/exportfs.c    | 13 +++++++++-
>  utils/exportfs/exportfs.man  | 58 ++++++++++++++++++++++++++++++++++++++=
------
>  utils/mountd/mountd.c        |  9 ++++++-
>  utils/mountd/mountd.man      |  9 +++++++
>  8 files changed, 102 insertions(+), 16 deletions(-)
>=20
> diff --git a/support/export/cache.c b/support/export/cache.c
> index 5a2c5760cb5410845971ba831a9ae779d17a6d87..2f128d7db7bd63d86530f0c40=
03af58327db2c70 100644
> --- a/support/export/cache.c
> +++ b/support/export/cache.c
> @@ -111,6 +111,7 @@ static bool path_lookup_error(int err)
> =20
>  extern int use_ipaddr;
>  extern int manage_gids;
> +extern int no_netlink;
> =20
>  static void auth_unix_ip(int f)
>  {
> @@ -3064,7 +3065,7 @@ void cache_open(void)
>  {
>  	int i;
> =20
> -	if (cache_nfsd_nl_open() =3D=3D 0) {
> +	if (!no_netlink && cache_nfsd_nl_open() =3D=3D 0) {
>  		if (cache_sunrpc_nl_open() =3D=3D 0) {
>  			/*
>  			 * Check for pending requests, in case any
> diff --git a/support/export/cache_flush.c b/support/export/cache_flush.c
> index 7d7f12b212967e5b3d1a2357de07bc3ba5f0b674..ed7b964f9d5372f4accba2125=
4ee9c5f40ffd44d 100644
> --- a/support/export/cache_flush.c
> +++ b/support/export/cache_flush.c
> @@ -20,6 +20,8 @@
>  #include "nfslib.h"
>  #include "xlog.h"
> =20
> +extern int no_netlink;
> +
>  #include <netlink/genl/genl.h>
>  #include <netlink/genl/ctrl.h>
>  #include <netlink/msg.h>
> @@ -155,7 +157,7 @@ static void cache_proc_flush(void)
>  void
>  cache_flush(void)
>  {
> -	if (cache_nl_flush() =3D=3D 0) {
> +	if (!no_netlink && cache_nl_flush() =3D=3D 0) {
>  		xlog(D_NETLINK, "cache flush via netlink succeeded");
>  		return;
>  	}
> diff --git a/utils/exportd/exportd.c b/utils/exportd/exportd.c
> index a2e370ac506f56d0feab306bd252c32ef58ba009..a08aaaccbc2f2ec8504c53bbf=
07daf1ac2be0c32 100644
> --- a/utils/exportd/exportd.c
> +++ b/utils/exportd/exportd.c
> @@ -32,6 +32,7 @@ static int num_threads =3D 1;
>  #define MAX_THREADS 64
> =20
>  int manage_gids;
> +int no_netlink;
>  int use_ipaddr =3D -1;
> =20
>  static struct option longopts[] =3D
> @@ -40,13 +41,14 @@ static struct option longopts[] =3D
>  	{ "debug", 1, 0, 'd' },
>  	{ "help", 0, 0, 'h' },
>  	{ "manage-gids", 0, 0, 'g' },
> +	{ "no-netlink", 0, 0, 'L' },
>  	{ "num-threads", 1, 0, 't' },
>  	{ "log-auth", 0, 0, 'l' },
>  	{ "cache-use-ipaddr", 0, 0, 'i' },
>  	{ "ttl", 0, 0, 'T' },
>  	{ NULL, 0, 0, 0 }
>  };
> -static char shortopts[] =3D "d:fghs:t:liT:";
> +static char shortopts[] =3D "d:fghs:t:liLT:";
> =20
>  /*
>   * Signal handlers.
> @@ -109,7 +111,7 @@ usage(const char *prog, int n)
>  		"Usage: %s [-f|--foreground] [-h|--help] [-d kind|--debug kind]\n"
>  "	[-g|--manage-gids] [-l|--log-auth] [-i|--cache-use-ipaddr] [-T|--ttl t=
tl]\n"
>  "	[-s|--state-directory-path path]\n"
> -"	[-t num|--num-threads=3Dnum]\n", prog);
> +"	[-t num|--num-threads=3Dnum] [-L|--no-netlink]\n", prog);
>  	exit(n);
>  }
> =20
> @@ -124,6 +126,7 @@ read_exportd_conf(char *progname, char **argv)
>  	xlog_set_debug(progname);
> =20
>  	manage_gids =3D conf_get_bool("exportd", "manage-gids", manage_gids);
> +	no_netlink =3D conf_get_bool("exportd", "no-netlink", no_netlink);
>  	num_threads =3D conf_get_num("exportd", "threads", num_threads);
>  	if (conf_get_bool("mountd", "cache-use-ipaddr", 0))
>  		use_ipaddr =3D 2;
> @@ -171,6 +174,9 @@ main(int argc, char **argv)
>  		case 'g':
>  			manage_gids =3D 1;
>  			break;
> +		case 'L':
> +			no_netlink =3D 1;
> +			break;
>  		case 'h':
>  			usage(progname, 0);
>  			break;
> diff --git a/utils/exportd/exportd.man b/utils/exportd/exportd.man
> index fae434b5f03bfb5a252f1e5c6d7fc8fc2a3f5567..d024868c6471c60f6804f4273=
17a2627cbddb0af 100644
> --- a/utils/exportd/exportd.man
> +++ b/utils/exportd/exportd.man
> @@ -106,6 +106,13 @@ the server. Note that the 'primary' group id is not =
affected so a
>  .B newgroup
>  command on the client will still be effective.  This function requires
>  a Linux Kernel with version at least 2.6.21.
> +.TP
> +.B \-L " or " \-\-no-netlink
> +Disable the use of netlink for kernel communication and force the use
> +of the legacy
> +.I /proc/net/rpc
> +interfaces instead.  This can be useful for debugging or working around
> +kernel netlink issues.
>  .SH CONFIGURATION FILE
>  Many of the options that can be set on the command line can also be
>  controlled through values set in the
> @@ -120,8 +127,9 @@ Values recognized in the
>  section include=20
>  .B cache\-use\-ipaddr ,
>  .BR ttl ,
> -.BR manage-gids ", and"
> -.B debug=20
> +.BR manage-gids ,
> +.BR no\-netlink ", and"
> +.B debug
>  which each have the same effect as the option with the same name.
>  .SH FILES
>  .TP 2.5i
> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> index 04753fa169f97c6b07893613197739ff36e0d09b..9eedb750e316a2ef42bb541d4=
df4925deeee4874 100644
> --- a/utils/exportfs/exportfs.c
> +++ b/utils/exportfs/exportfs.c
> @@ -49,6 +49,8 @@
>  #include "sunrpc_netlink.h"
>  #endif
> =20
> +int no_netlink;
> +
>  static void	export_all(int verbose);
>  static void	exportfs(char *arg, char *options, int verbose);
>  static void	unexportfs(char *arg, int verbose);
> @@ -109,8 +111,11 @@ read_exportfs_conf(char **argv)
>  	xlog_set_debug("exportfs");
> =20
>  	/* NOTE: following uses "mountd" section of nfs.conf !!!! */
> +	no_netlink =3D conf_get_bool("mountd", "no-netlink", no_netlink);
>  	s =3D conf_get_str("mountd", "state-directory-path");
>  	/* Also look in the exportd section */
> +	if (!no_netlink)
> +		no_netlink =3D conf_get_bool("exportd", "no-netlink", no_netlink);
>  	if (s =3D=3D NULL)
>  		s =3D conf_get_str("exportd", "state-directory-path");
>  	if (s && !state_setup_basedir(argv[0], s))
> @@ -145,7 +150,7 @@ main(int argc, char **argv)
> =20
>  	nfsd_path_init();
> =20
> -	while ((c =3D getopt(argc, argv, "ad:fhio:ruvs")) !=3D EOF) {
> +	while ((c =3D getopt(argc, argv, "ad:fhiLo:ruvs")) !=3D EOF) {
>  		switch(c) {
>  		case 'a':
>  			f_all =3D 1;
> @@ -162,6 +167,9 @@ main(int argc, char **argv)
>  		case 'i':
>  			f_ignore =3D 1;
>  			break;
> +		case 'L':
> +			no_netlink =3D 1;
> +			break;
>  		case 'o':
>  			options =3D optarg;
>  			break;
> @@ -500,6 +508,8 @@ static int can_test(void)
>  	size_t bufsiz =3D sizeof(buf);
> =20
>  	/* Try netlink first: resolve sunrpc genl family */
> +	if (no_netlink)
> +		goto try_proc;
>  	sock =3D nl_socket_alloc();
>  	if (sock) {
>  		if (genl_connect(sock) =3D=3D 0) {
> @@ -513,6 +523,7 @@ static int can_test(void)
>  	}
> =20
>  	/* Fallback: /proc probe */
> +try_proc:
>  	fd =3D open("/proc/net/rpc/auth.unix.ip/channel", O_WRONLY);
>  	if (fd < 0)
>  		return 0;
> diff --git a/utils/exportfs/exportfs.man b/utils/exportfs/exportfs.man
> index af0e5571cef83d4f3de6915608b4871690a8853a..3737ee81ab275aa65e942ec16=
02f33a7abbfc80e 100644
> --- a/utils/exportfs/exportfs.man
> +++ b/utils/exportfs/exportfs.man
> @@ -53,14 +53,41 @@ by using the
>  command.
>  .PP
>  .B exportfs
> -does not give any information to the kernel directly, but provides it
> -only to
> -.B rpc.mountd
> -through the
> +does not communicate with the kernel directly.
> +It writes export information to
>  .I /var/lib/nfs/etab
> -file.
> +and relies on its partner programs
> +.B rpc.mountd
> +and
> +.B nfsv4.exportd
> +to manage kernel communication.
> +These daemons work in one of two modes: a netlink mode and a
> +.I /proc
> +mode.
> +.PP
> +In the netlink mode, available on sufficiently recent kernels,
>  .B rpc.mountd
> -then manages kernel requests for information about exports, as needed.
> +(or
> +.BR nfsv4.exportd )
> +communicates with the kernel via generic netlink sockets.
> +The kernel sends multicast notifications when cache entries need to be
> +resolved, and the daemon responds with the appropriate export
> +information.
> +Cache flushing (via
> +.BR "exportfs \-f" )
> +is also performed over netlink.
> +This mode can be disabled with the
> +.B \-L
> +option.
> +.PP
> +In the
> +.I /proc
> +mode, used when netlink is unavailable,
> +.B rpc.mountd
> +manages kernel requests for information about exports
> +via the
> +.I /proc/net/rpc
> +channel files.
>  .SH OPTIONS
>  .TP
>  .B \-d kind " or " \-\-debug kind
> @@ -123,6 +150,12 @@ options.
>  .TP
>  .B -s
>  Display the current export list suitable for /etc/exports.
> +.TP
> +.B -L
> +Disable the use of netlink for kernel communication and force the use
> +of the legacy
> +.I /proc
> +interfaces for cache flushing and export validation.
> =20
>  .SH CONFIGURATION FILE
>  The
> @@ -142,11 +175,20 @@ When a list is given, the members should be comma-s=
eparated.
>  .B exportfs
>  will also recognize the
>  .B state-directory-path
> -value from both the=20
> +and
> +.B no\-netlink
> +values from both the
>  .B [mountd]
>  section and the
>  .B [exportd]
> -section
> +section.
> +When
> +.B no\-netlink
> +is set,
> +.B exportfs
> +will skip the netlink probe and use the legacy
> +.I /proc
> +interfaces for cache flushing and export validation
> =20
>  .SH DISCUSSION
>  .SS Exporting Directories
> diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
> index 6e6777cd1daa0227f3ff81f826c1cbc8627b4a8a..92d8c4690efc48fcfa12d9618=
cac9172c4752f4f 100644
> --- a/utils/mountd/mountd.c
> +++ b/utils/mountd/mountd.c
> @@ -41,6 +41,7 @@ static struct nfs_fh_len *get_rootfh(struct svc_req *, =
dirpath *, nfs_export **,
> =20
>  int reverse_resolve =3D 0;
>  int manage_gids;
> +int no_netlink;
>  int apply_root_cred;
>  int use_ipaddr =3D -1;
> =20
> @@ -72,6 +73,7 @@ static struct option longopts[] =3D
>  	{ "num-threads", 1, 0, 't' },
>  	{ "reverse-lookup", 0, 0, 'r' },
>  	{ "manage-gids", 0, 0, 'g' },
> +	{ "no-netlink", 0, 0, 'L' },
>  	{ "no-udp", 0, 0, 'u' },
>  	{ "log-auth", 0, 0, 'l'},
>  	{ "cache-use-ipaddr", 0, 0, 'i'},
> @@ -667,6 +669,7 @@ read_mountd_conf(char **argv)
> =20
>  	xlog_set_debug("mountd");
>  	manage_gids =3D conf_get_bool("mountd", "manage-gids", manage_gids);
> +	no_netlink =3D conf_get_bool("mountd", "no-netlink", no_netlink);
>  	descriptors =3D conf_get_num("mountd", "descriptors", descriptors);
>  	port =3D conf_get_num("mountd", "port", port);
>  	num_threads =3D conf_get_num("mountd", "threads", num_threads);
> @@ -734,6 +737,9 @@ main(int argc, char **argv)
>  		case 'g':
>  			manage_gids =3D 1;
>  			break;
> +		case 'L':
> +			no_netlink =3D 1;
> +			break;
>  		case 'o':
>  			descriptors =3D atoi(optarg);
>  			if (descriptors <=3D 0) {
> @@ -951,6 +957,7 @@ usage(const char *prog, int n)
>  "	[-N version|--no-nfs-version version] [-n|--no-tcp]\n"
>  "	[-H prog |--ha-callout prog] [-r |--reverse-lookup]\n"
>  "	[-s|--state-directory-path path] [-g|--manage-gids]\n"
> -"	[-t num|--num-threads=3Dnum] [-u|--no-udp]\n", prog);
> +"	[-t num|--num-threads=3Dnum] [-u|--no-udp]\n"
> +"	[-L|--no-netlink]\n", prog);
>  	exit(n);
>  }
> diff --git a/utils/mountd/mountd.man b/utils/mountd/mountd.man
> index 2fa396c3288f37b1afa247b54a6166ca4f1b5e06..8bec38db131d9f70d1e04a000=
133023cca955fe1 100644
> --- a/utils/mountd/mountd.man
> +++ b/utils/mountd/mountd.man
> @@ -284,6 +284,14 @@ the server. Note that the 'primary' group id is not =
affected so a
>  command on the client will still be effective.  This function requires
>  a Linux Kernel with version at least 2.6.21.
> =20
> +.TP
> +.B \-L " or " \-\-no-netlink
> +Disable the use of netlink for kernel communication and force the use
> +of the legacy
> +.I /proc/net/rpc
> +interfaces instead.  This can be useful for debugging or working around
> +kernel netlink issues.
> +
>  .SH CONFIGURATION FILE
>  Many of the options that can be set on the command line can also be
>  controlled through values set in the
> @@ -297,6 +305,7 @@ Values recognized in the
>  .B [mountd]
>  section include
>  .BR manage-gids ,
> +.BR no\-netlink ,
>  .BR cache\-use\-ipaddr ,
>  .BR descriptors ,
>  .BR port ,

--=20
Jeff Layton <jlayton@kernel.org>

