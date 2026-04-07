Return-Path: <linux-nfs+bounces-20717-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLl+BQFh1Wk85gcAu9opvQ
	(envelope-from <linux-nfs+bounces-20717-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 21:54:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 670313B41B5
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 21:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA7893001CD1
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 19:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F53035AC2F;
	Tue,  7 Apr 2026 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5CMzUI6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3BA34B669
	for <linux-nfs@vger.kernel.org>; Tue,  7 Apr 2026 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591484; cv=none; b=eBUdGRrOu4t8YXvoOU0HxinvNQetn/hPN86cUNDor1dzc1hXFvJkdFHOwCDM+1hWhEyRBqcYI4JIyG2NlMSmgYQzWurWPyeuhRZTcOoniJwq/AoNzJ4zy4ABTkSq/nD/X2AkEOe/AG4BhdKMK9q27H6bz+j8EkIFFuDh6E7C/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591484; c=relaxed/simple;
	bh=jF+dvC9/Bf9gqz2e5K9Hw8USL10XFvJV0PzK2as4dfY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hYJShjIhCfhqWLeZisQIp6U+PC4DMUtjjnYIopQ7R78U+nj0q3t9WzCtVCWO7qlAcSjvr537ImuhLIpA48bun8fEs9XEuCetNk+YeCoSJ6iecIJF5Cg8GO2iKWIXQaMu+egYy5TI0PjenUGoz27GVF6ojbKXC2oAQ8A76I7MZx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5CMzUI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FD5C116C6;
	Tue,  7 Apr 2026 19:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775591483;
	bh=jF+dvC9/Bf9gqz2e5K9Hw8USL10XFvJV0PzK2as4dfY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=G5CMzUI6vMlZCYw+6w3s9pQDwLZlQhy/nBgsmpRffLIknuLaKkXnMsK6YDR13Gyka
	 eFqPGJ8yWIo73jflXX6IqNf3K6MXbUvsJ0/QltmRYhH8LorMmg+U1L5yNX1+beoOcD
	 uqdShJw2bFtNSkD2faLn8SMkmqIhaWRoIva9Pc+/7y1ZHVyKe7hF9bYGiDeya8RmAU
	 Jv4oAXie++eeHJIpOdj7kgzlvchm6gcvKUSlBzN1QWRaBhALsfgLe1LHiuvl33+iD5
	 RUX0gFWe0ZBhEdpCJ1Yce4dVIv9YoeNvBihrSc/3mnW/0K5VJIgb4V1/OPZ6pQE7yH
	 v0So+iJVRtRCA==
Message-ID: <1949725ad3cebae2f38aa7cceed218f974b9f8a4.camel@kernel.org>
Subject: Re: [PATCH v2] exportfs: release NFSv4 state when last client is
 unexported
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neilb@ownmail.net>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date: Tue, 07 Apr 2026 15:51:20 -0400
In-Reply-To: <20260406172653.1962-1-cel@kernel.org>
References: <20260406172653.1962-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20717-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,makefile.in:url]
X-Rspamd-Queue-Id: 670313B41B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-04-06 at 13:26 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> When exportfs -u removes the last client for a given export path,
> NFSv4 state (opens, locks, delegations) acquired through that
> export may still hold the underlying filesystem busy, preventing
> unmount.
>=20
> After removing an export entry, check whether any active exports
> remain for the same path across all client types.  If none remain,
> send NFSD_CMD_UNLOCK_EXPORT to the kernel via generic netlink,
> which revokes the associated NFSv4 state and closes cached file
> handles.
>=20
> This uses a new shared helper, nfsd_nl_cmd_str(), in
> support/nfs/nfsdnl.c that handles the netlink socket setup, message
> construction, and ACK handling for simple nfsd commands carrying
> a single string attribute.  The helper is conditionally compiled
> when libnl3 is available (gated by the existing nfsdctl configure
> option).
>=20
> Also update the local nfsd_netlink.h copy with the
> NFSD_CMD_UNLOCK_IP, NFSD_CMD_UNLOCK_FILESYSTEM, and
> NFSD_CMD_UNLOCK_EXPORT command and attribute definitions.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  configure.ac                   |   2 +
>  support/include/nfsd_netlink.h |  24 +++++++
>  support/include/nfsdnl.h       |  34 +++++++++
>  support/nfs/Makefile.am        |   7 ++
>  support/nfs/nfsdnl.c           | 124 +++++++++++++++++++++++++++++++++
>  utils/exportfs/exportfs.c      |  65 ++++++++++++++++-
>  utils/exportfs/exportfs.man    |  17 +++++
>  7 files changed, 271 insertions(+), 2 deletions(-)
>  create mode 100644 support/include/nfsdnl.h
>  create mode 100644 support/nfs/nfsdnl.c
>=20
> diff --git a/configure.ac b/configure.ac
> index 115c611fa5e3..8ca06fd62b47 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -256,6 +256,8 @@ PKG_CHECK_MODULES(LIBNL3, libnl-3.0 >=3D 3.1)
>  PKG_CHECK_MODULES(LIBNLGENL3, libnl-genl-3.0 >=3D 3.1)
> =20
>  AC_CHECK_HEADERS(linux/nfsd_netlink.h)
> +AC_DEFINE([HAVE_NFSD_NETLINK], 1,
> +	  [Define to 1 if nfsd generic netlink support is available])
> =20
>  # ensure we have the expkey attributes
>  AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/nfsd_netlink.h>]],
> diff --git a/support/include/nfsd_netlink.h b/support/include/nfsd_netlin=
k.h
> index 2d708d24cbd2..a6a831866be8 100644
> --- a/support/include/nfsd_netlink.h
> +++ b/support/include/nfsd_netlink.h
> @@ -128,6 +128,27 @@ enum {
>  	NFSD_A_POOL_MODE_MAX =3D (__NFSD_A_POOL_MODE_MAX - 1)
>  };
> =20
> +enum {
> +	NFSD_A_UNLOCK_IP_ADDRESS =3D 1,
> +
> +	__NFSD_A_UNLOCK_IP_MAX,
> +	NFSD_A_UNLOCK_IP_MAX =3D (__NFSD_A_UNLOCK_IP_MAX - 1)
> +};
> +
> +enum {
> +	NFSD_A_UNLOCK_FILESYSTEM_PATH =3D 1,
> +
> +	__NFSD_A_UNLOCK_FILESYSTEM_MAX,
> +	NFSD_A_UNLOCK_FILESYSTEM_MAX =3D (__NFSD_A_UNLOCK_FILESYSTEM_MAX - 1)
> +};
> +
> +enum {
> +	NFSD_A_UNLOCK_EXPORT_PATH =3D 1,
> +
> +	__NFSD_A_UNLOCK_EXPORT_MAX,
> +	NFSD_A_UNLOCK_EXPORT_MAX =3D (__NFSD_A_UNLOCK_EXPORT_MAX - 1)
> +};
> +
>  enum {
>  	NFSD_A_FSLOCATION_HOST =3D 1,
>  	NFSD_A_FSLOCATION_PATH,
> @@ -229,6 +250,9 @@ enum {
>  	NFSD_CMD_EXPKEY_GET_REQS,
>  	NFSD_CMD_EXPKEY_SET_REQS,
>  	NFSD_CMD_CACHE_FLUSH,
> +	NFSD_CMD_UNLOCK_IP,
> +	NFSD_CMD_UNLOCK_FILESYSTEM,
> +	NFSD_CMD_UNLOCK_EXPORT,
> =20
>  	__NFSD_CMD_MAX,
>  	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> diff --git a/support/include/nfsdnl.h b/support/include/nfsdnl.h
> new file mode 100644
> index 000000000000..352801e5cc43
> --- /dev/null
> +++ b/support/include/nfsdnl.h
> @@ -0,0 +1,34 @@
> +/*
> + * Helper for sending nfsd generic netlink commands.
> + *
> + * Used by both nfsdctl and exportfs.
> + */
> +
> +#ifndef NFS_UTILS_NFSDNL_H
> +#define NFS_UTILS_NFSDNL_H
> +
> +#ifdef HAVE_NFSD_NETLINK
> +
> +/**
> + * nfsd_nl_cmd_str - send an nfsd netlink command carrying a string attr=
ibute
> + * @cmd:   NFSD_CMD_* command number
> + * @attr:  NFSD_A_* attribute number
> + * @value: NUL-terminated string value for the attribute
> + *
> + * Opens a genetlink connection, resolves the "nfsd" family, sends a
> + * single "do" command with one string attribute, waits for the ACK,
> + * and cleans up.
> + *
> + * Returns 0 on success or a negative errno on failure.
> + */
> +int nfsd_nl_cmd_str(int cmd, int attr, const char *value);
> +
> +#else
> +
> +static inline int nfsd_nl_cmd_str(int cmd, int attr, const char *value)
> +{
> +	return -ENOSYS;
> +}
> +
> +#endif /* HAVE_NFSD_NETLINK */
> +#endif /* NFS_UTILS_NFSDNL_H */
> diff --git a/support/nfs/Makefile.am b/support/nfs/Makefile.am
> index 5bfd71a9c8da..64ad5d075b9e 100644
> --- a/support/nfs/Makefile.am
> +++ b/support/nfs/Makefile.am
> @@ -11,6 +11,13 @@ libnfs_la_SOURCES =3D exports.c rmtab.c xio.c rpcmisc.=
c rpcdispatch.c \
>  libnfs_la_LIBADD =3D libnfsconf.la -luuid
>  libnfs_la_CPPFLAGS =3D $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/suppor=
t/reexport
> =20
> +if CONFIG_NFSDCTL
> +libnfs_la_SOURCES +=3D nfsdnl.c
> +libnfs_la_CPPFLAGS +=3D $(LIBNL3_CFLAGS) $(LIBNLGENL3_CFLAGS) \
> +		      -I$(top_srcdir)/utils/nfsdctl
> +libnfs_la_LIBADD +=3D $(LIBNL3_LIBS) $(LIBNLGENL3_LIBS)
> +endif
> +
>  libnfsconf_la_SOURCES =3D conffile.c xlog.c
> =20
>  MAINTAINERCLEANFILES =3D Makefile.in
> diff --git a/support/nfs/nfsdnl.c b/support/nfs/nfsdnl.c
> new file mode 100644
> index 000000000000..ece0b57afd4b
> --- /dev/null
> +++ b/support/nfs/nfsdnl.c
> @@ -0,0 +1,124 @@
> +/*
> + * nfsdnl.c -- send nfsd generic netlink commands
> + *
> + * Helper shared by nfsdctl and exportfs.
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <errno.h>
> +#include <string.h>
> +
> +#include <netlink/genl/genl.h>
> +#include <netlink/genl/ctrl.h>
> +#include <netlink/msg.h>
> +#include <netlink/attr.h>
> +
> +#include "xlog.h"
> +#include "nfsdnl.h"
> +
> +#ifdef USE_SYSTEM_NFSD_NETLINK_H
> +#include <linux/nfsd_netlink.h>
> +#else
> +#include "nfsd_netlink.h"
> +#endif
> +
> +#define NFSDNL_BUFSIZE	(4096)
> +
> +static int error_handler(struct sockaddr_nl *nla, struct nlmsgerr *err,
> +			 void *arg)
> +{
> +	int *ret =3D arg;
> +	*ret =3D err->error;
> +	return NL_STOP;
> +}
> +
> +static int finish_handler(struct nl_msg *msg, void *arg)
> +{
> +	int *ret =3D arg;
> +	*ret =3D 0;
> +	return NL_SKIP;
> +}
> +
> +static int ack_handler(struct nl_msg *msg __attribute__((unused)),
> +		       void *arg)
> +{
> +	int *ret =3D arg;
> +	*ret =3D 0;
> +	return NL_STOP;
> +}
> +
> +/**
> + * nfsd_nl_cmd_str - send an nfsd netlink command carrying a string attr=
ibute
> + * @cmd:   NFSD_CMD_* command number
> + * @attr:  NFSD_A_* attribute number
> + * @value: NUL-terminated string value for the attribute
> + *
> + * Returns 0 on success or a negative errno on failure.
> + */
> +int nfsd_nl_cmd_str(int cmd, int attr, const char *value)
> +{
> +	struct genlmsghdr *ghdr;
> +	struct nl_sock *sock;
> +	struct nl_msg *msg;
> +	struct nl_cb *cb;
> +	int family;
> +	int ret;
> +
> +	sock =3D nl_socket_alloc();
> +	if (!sock)
> +		return -ENOMEM;
> +	if (genl_connect(sock)) {
> +		ret =3D -ECONNREFUSED;
> +		goto out_sock;
> +	}
> +	nl_socket_set_buffer_size(sock, NFSDNL_BUFSIZE, NFSDNL_BUFSIZE);
> +
> +	family =3D genl_ctrl_resolve(sock, NFSD_FAMILY_NAME);
> +	if (family < 0) {
> +		ret =3D family;
> +		goto out_sock;
> +	}
> +
> +	msg =3D nlmsg_alloc();
> +	if (!msg) {
> +		ret =3D -ENOMEM;
> +		goto out_sock;
> +	}
> +	if (!genlmsg_put(msg, 0, 0, family, 0, 0, 0, 0)) {
> +		ret =3D -ENOMEM;
> +		goto out_msg;
> +	}
> +
> +	ghdr =3D nlmsg_data(nlmsg_hdr(msg));
> +	ghdr->cmd =3D (__u8)cmd;
> +	nla_put_string(msg, attr, value);
> +
> +	cb =3D nl_cb_alloc(NL_CB_CUSTOM);
> +	if (!cb) {
> +		ret =3D -ENOMEM;
> +		goto out_msg;
> +	}
> +
> +	ret =3D nl_send_auto(sock, msg);
> +	if (ret < 0)
> +		goto out_cb;
> +
> +	ret =3D 1;
> +	nl_cb_err(cb, NL_CB_CUSTOM, error_handler, &ret);
> +	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, finish_handler, &ret);
> +	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_handler, &ret);
> +
> +	while (ret > 0)
> +		nl_recvmsgs(sock, cb);
> +
> +out_cb:
> +	nl_cb_put(cb);
> +out_msg:
> +	nlmsg_free(msg);
> +out_sock:
> +	nl_socket_free(sock);
> +	return ret;
> +}
> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> index 93f0bcd7ad56..768d2db7ea8f 100644
> --- a/utils/exportfs/exportfs.c
> +++ b/utils/exportfs/exportfs.c
> @@ -39,6 +39,15 @@
>  #include "xlog.h"
>  #include "conffile.h"
>  #include "reexport.h"
> +#include "nfsdnl.h"
> +
> +#ifdef HAVE_NFSD_NETLINK
> +#ifdef USE_SYSTEM_NFSD_NETLINK_H
> +#include <linux/nfsd_netlink.h>
> +#else
> +#include "nfsd_netlink.h"
> +#endif
> +#endif
> =20
>  #include <netlink/genl/genl.h>
>  #include <netlink/genl/ctrl.h>
> @@ -63,6 +72,7 @@ static void release_lockfile(void);
> =20
>  static const char *lockfile =3D EXP_LOCKFILE;
>  static int _lockfd =3D -1;
> +static int f_unexport_all;
> =20
>  /*
>   * If we aren't careful, changes made by exportfs can be lost
> @@ -246,7 +256,8 @@ main(int argc, char **argv)
>  	 * don't care about what should be exported, as that
>  	 * may require DNS lookups..
>  	 */
> -	if (! ( !f_export && f_all)) {
> +	f_unexport_all =3D !f_export && f_all;
> +	if (!f_unexport_all) {
>  		/* note: xtab_*_read does not update entries if they already exist,
>  		 * so this will not lose new options
>  		 */
> @@ -380,6 +391,26 @@ exportfs(char *arg, char *options, int verbose)
>  		xlog(L_ERROR, "Invalid export syntax: %s", arg);
>  }
> =20
> +/*
> + * Check whether any active export remains for the given path across
> + * all client types.  Returns true if at least one export still has
> + * m_xtabent set.
> + */
> +static int
> +path_still_exported(const char *path, size_t nlen)
> +{
> +	nfs_export *exp;
> +	int i;
> +
> +	for (i =3D 0; i < MCL_MAXTYPES; i++)
> +		for (exp =3D exportlist[i].p_head; exp; exp =3D exp->m_next)
> +			if (exp->m_xtabent &&
> +			    strlen(exp->m_export.e_path) =3D=3D nlen &&
> +			    strncmp(path, exp->m_export.e_path, nlen) =3D=3D 0)
> +				return 1;
> +	return 0;
> +}
> +
>  static void
>  unexportfs_parsed(char *hname, char *path, int verbose)
>  {
> @@ -434,9 +465,39 @@ unexportfs_parsed(char *hname, char *path, int verbo=
se)
>  		exp->m_mayexport =3D 0;
>  		success =3D 1;
>  	}
> -	if (!success)
> +	if (!success) {
>  		xlog(L_ERROR, "Could not find '%s:%s' to unexport.", hname, path);
> +		goto out;
> +	}
> =20
> +	/*
> +	 * If no exports remain for this path, ask the kernel to
> +	 * revoke any NFSv4 state and close cached file handles
> +	 * associated with exports of this path.  This enables the
> +	 * underlying filesystem to be unmounted.
> +	 *
> +	 * Skip this during "exportfs -ua" -- that is a shutdown
> +	 * operation.  Clients should wait for nfsd to restart and
> +	 * reclaim state through the grace period rather than
> +	 * receiving NFS4ERR_ADMIN_REVOKED.
> +	 */
> +#ifdef HAVE_NFSD_NETLINK

I don't think you need this #ifdef. With the latest exportfs changes,
netlink support is pretty much required to build.

> +	if (!f_unexport_all && !path_still_exported(path, nlen)) {
> +		char pathbuf[NFS_MAXPATHLEN + 1];
> +		int ret;
> +
> +		memcpy(pathbuf, path, nlen);
> +		pathbuf[nlen] =3D '\0';
> +		ret =3D nfsd_nl_cmd_str(NFSD_CMD_UNLOCK_EXPORT,
> +				      NFSD_A_UNLOCK_EXPORT_PATH,
> +				      pathbuf);
> +		if (ret && ret !=3D -ENOSYS)
> +			xlog(L_WARNING,
> +			     "Failed to release state for %s: %s",
> +			     pathbuf, strerror(-ret));
> +	}
> +#endif
> +out:
>  	nfs_freeaddrinfo(ai);
>  }
> =20
> diff --git a/utils/exportfs/exportfs.man b/utils/exportfs/exportfs.man
> index 3737ee81ab27..b5e0c63a63f2 100644
> --- a/utils/exportfs/exportfs.man
> +++ b/utils/exportfs/exportfs.man
> @@ -256,6 +256,23 @@ pair. This deletes the specified entry from
>  .I /var/lib/nfs/etab
>  and removes the corresponding kernel entry (if any).
>  .PP
> +When the last client for a given export path is unexported,
> +.B exportfs
> +signals the kernel to revoke NFSv4 state (opens, locks, and
> +delegations) and release cached state for that path.
> +Without this revocation, retained state would prevent the
> +underlying filesystem from being unmounted.
> +Affected clients receive
> +.B NFS4ERR_ADMIN_REVOKED
> +errors for operations that use revoked state.
> +.PP
> +.B "exportfs \-ua"
> +does not revoke NFSv4 state, however.
> +If
> +.B nfsd
> +is then restarted, clients may reclaim state during the
> +grace period.
> +.PP
>  .SS Dumping the Export Table
>  Invoking
>  .B exportfs

The rest looks good.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

