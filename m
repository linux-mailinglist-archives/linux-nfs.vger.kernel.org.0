Return-Path: <linux-nfs+bounces-8431-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B79019E8831
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 23:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9631884BF5
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 22:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446FB14D2B9;
	Sun,  8 Dec 2024 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VDUM6LtZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EsJVLS/x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VDUM6LtZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EsJVLS/x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8160D1DA23
	for <linux-nfs@vger.kernel.org>; Sun,  8 Dec 2024 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733695957; cv=none; b=WeEmLKzZezlaHEWVGPPmqBb3KcyknVntD+8/mn7xR6w+zfUYFuIyrtAN4yZpOJhGRscFnF4CSTQW4N6tquvQlQqyUv4Vkd0GJOTqhOydQK0nv+YPnEMr8r9pGhRJlIgO33BGF549JjlSDkzL27ip5DypCuaoLUoz1s9NVpFfWfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733695957; c=relaxed/simple;
	bh=7tERamT7zAYgDucUotjc4szyBYlRNfR0WamHf1QSIew=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JrLFm7BYzra+NQ0CKH0KPTzuUnfYRMbbvxDq7j1B7ZtG4Un2dqRpuXS85X7cXbi/a79z35za5/kARlLl4y9Npd4Uf9+XUxDEBMG7CD+APalG9EHQamqJbB8xXY/H7rmQLx6KiowvUMIY6g3bTVqOrw830T/XLVcpF/uybE5dcmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VDUM6LtZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EsJVLS/x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VDUM6LtZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EsJVLS/x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7EAE21F37E;
	Sun,  8 Dec 2024 22:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733695948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5ePuxf95RCvwXIPoEqZbrQzFWAe6nvuzqMnMSQ68nI=;
	b=VDUM6LtZ5lRWIZADoQMCPY0T9bNwZiyE6tBl3CQ7lEetzzdOI2hsmjEobrxMQj5f10m3GU
	B2bujZffgKumnxxgT4sxYeL0276JNipnIm+BzO6pJhFpQguX336HGP7jzMEWRimHbXeMSV
	63WV8RAwWIedyZCxZeGeGjWT5m6e9kk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733695948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5ePuxf95RCvwXIPoEqZbrQzFWAe6nvuzqMnMSQ68nI=;
	b=EsJVLS/xEmbAyJz3IbJYoqzjRyuv5JdmcOWvMyB8I4CmTaaVTLcikAo7aCnpBzYbrOJ1Fd
	eEP+nIU2BKnn2HCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VDUM6LtZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="EsJVLS/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733695948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5ePuxf95RCvwXIPoEqZbrQzFWAe6nvuzqMnMSQ68nI=;
	b=VDUM6LtZ5lRWIZADoQMCPY0T9bNwZiyE6tBl3CQ7lEetzzdOI2hsmjEobrxMQj5f10m3GU
	B2bujZffgKumnxxgT4sxYeL0276JNipnIm+BzO6pJhFpQguX336HGP7jzMEWRimHbXeMSV
	63WV8RAwWIedyZCxZeGeGjWT5m6e9kk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733695948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5ePuxf95RCvwXIPoEqZbrQzFWAe6nvuzqMnMSQ68nI=;
	b=EsJVLS/xEmbAyJz3IbJYoqzjRyuv5JdmcOWvMyB8I4CmTaaVTLcikAo7aCnpBzYbrOJ1Fd
	eEP+nIU2BKnn2HCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46DC8133D1;
	Sun,  8 Dec 2024 22:12:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vpe5OsoZVmcTeQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 08 Dec 2024 22:12:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Roland Mainz" <roland.mainz@nrubsig.org>
Cc: "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
In-reply-to:
 <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
References:
 <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
Date: Mon, 09 Dec 2024 09:12:23 +1100
Message-id: <173369594365.1734440.14357278787243353853@noble.neil.brown.name>
X-Rspamd-Queue-Id: 7EAE21F37E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Fri, 06 Dec 2024, Roland Mainz wrote:
> Hi!
>=20

As Chunk is pointing out some possibe justifications for this change, I
decided to have a look at the code.

You email program has messed up all the spaces.  If you can't find a way
to configure your mail client to be sensible, attaching the patch as a
text file is acceptable.
This makes the patch very hard to read, so I haven't done a thorough
job.

The urlparser code that you have borrowed from elsewhere looks a bit
clumsy.  I think an '@' can only mean "username was given" if it appear
in the hostname part, not after a following '/'.  But that isn't
checked.  And we don't want user names for NFS urls.
I think it would be better to write a parser from scratch which we can
review and fix.  It isn't that hard.

See more below.

> ----
>=20
> Below (and also available at https://nrubsig.kpaste.net/b37) is a
> patch which adds support for nfs://-URLs in mount.nfs4, as alternative
> to the traditional hostname:/path+-o port=3D<tcp-port> notation.
>=20
> * Main advantages are:
> - Single-line notation with the familiar URL syntax, which includes
> hostname, path *AND* TCP port number (last one is a common generator
> of *PAIN* with ISPs) in ONE string
> - Support for non-ASCII mount points, e.g. paths with CJKV (Chinese,
> Japanese, ...) characters, which is typically a big problem if you try
> to transfer such mount point information across email/chat/clipboard
> etc., which tends to mangle such characters to death (e.g.
> transliteration, adding of ZWSP or just '?').
> - URL parameters are supported, providing support for future extensions
>=20
> * Notes:
> - Similar support for nfs://-URLs exists in other NFSv4.*
> implementations, including Illumos, Windows ms-nfs41-client,
> sahlberg/libnfs, ...
> - This is NOT about WebNFS, this is only to use an URL representation
> to make the life of admins a LOT easier
> - Only absolute paths are supported
> - This feature will not be provided for NFSv3
>=20
> ---- snip ----
> From e7b5a3ac981727e4585288bd66d1a9b2dea045dc Mon Sep 17 00:00:00 2001
> From: Roland Mainz <roland.mainz@nrubsig.org>
> Date: Fri, 6 Dec 2024 10:58:48 +0100
> Subject: [PATCH] mount.nfs4: Add support for nfs://-URLs
>=20
> Add support for RFC 2224-style nfs://-URLs as alternative to the
> traditional hostname:/path+-o port=3D<tcp-port> notation,
> providing standardised, extensible, single-string, crossplatform,
> portable, Character-Encoding independent (e.g. mount point with
> Japanese, Chinese, French etc. characters) and ASCII-compatible
> descriptions of NFSv4 server resources (exports).
>=20
> Reviewed-by: Martin Wege <martin.l.wege@gmail.com>
> Signed-off-by: Cedric Blancher <cedric.blancher@gmail.com>
> ---
>  utils/mount/Makefile.am  |   3 +-
>  utils/mount/nfs4mount.c  |  69 +++++++-
>  utils/mount/nfsmount.c   |  93 ++++++++--
>  utils/mount/parse_dev.c  |  67 ++++++--
>  utils/mount/stropts.c    |  96 ++++++++++-
>  utils/mount/urlparser1.c | 358 +++++++++++++++++++++++++++++++++++++++
>  utils/mount/urlparser1.h |  60 +++++++
>  utils/mount/utils.c      | 155 +++++++++++++++++
>  utils/mount/utils.h      |  23 +++
>  9 files changed, 887 insertions(+), 37 deletions(-)
>  create mode 100644 utils/mount/urlparser1.c
>  create mode 100644 utils/mount/urlparser1.h
>=20
> diff --git a/utils/mount/Makefile.am b/utils/mount/Makefile.am
> index 83a8ee1c..0e4cab3e 100644
> --- a/utils/mount/Makefile.am
> +++ b/utils/mount/Makefile.am
> @@ -13,7 +13,8 @@ sbin_PROGRAMS =3D mount.nfs
>  EXTRA_DIST =3D nfsmount.conf $(man8_MANS) $(man5_MANS)
>  mount_common =3D error.c network.c token.c \
>       parse_opt.c parse_dev.c \
> -     nfsmount.c nfs4mount.c stropts.c\
> +     nfsmount.c nfs4mount.c \
> +     urlparser1.c urlparser1.h stropts.c \
>       mount_constants.h error.h network.h token.h \
>       parse_opt.h parse_dev.h \
>       nfs4_mount.h stropts.h version.h \
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
>=20
>  #if defined(VAR_LOCK_DIR)
>  #define DEFAULT_DIR VAR_LOCK_DIR
> @@ -182,7 +184,7 @@ int nfs4mount(const char *spec, const char *node, int f=
lags,
>   int num_flavour =3D 0;
>   int ip_addr_in_opts =3D 0;
>=20
> - char *hostname, *dirname, *old_opts;
> + char *hostname, *dirname, *mb_dirname =3D NULL, *old_opts;
>   char new_opts[1024];
>   char *opt, *opteq;
>   char *s;
> @@ -192,15 +194,66 @@ int nfs4mount(const char *spec, const char
> *node, int flags,
>   int retry;
>   int retval =3D EX_FAIL;
>   time_t timeout, t;
> + int nfs_port =3D NFS_PORT;
> + parsed_nfs_url pnu;

Please don't use typedef for structs.  This should be "
   struct  parsed_nfs_url


> +
> + (void)memset(&pnu, 0, sizeof(parsed_nfs_url));

  memset(&pnu, 0, sizeof(pnu))

is preferred.

>=20
>   if (strlen(spec) >=3D sizeof(hostdir)) {
>   nfs_error(_("%s: excessively long host:dir argument\n"),
>   progname);
>   goto fail;
>   }
> - strcpy(hostdir, spec);
> - if (parse_devname(hostdir, &hostname, &dirname))
> - goto fail;
> +
> + /*
> + * Support nfs://-URLS per RFC 2224 ("NFS URL
> + * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> + * including custom port (nfs://hostname@port/path/...)
> + * and URL parameter (e.g. nfs://.../?param1=3Dval1&param2=3Dval2
> + * support

Please mention RFC7532 as ell.

Also the port should be separated by a ':', not '@'


> + */
> + if (is_spec_nfs_url(spec)) {
> + if (!mount_parse_nfs_url(spec, &pnu)) {
> + goto fail;
> + }

is_spec_nfs_url() is (almost) always followed by mount_parse_nfs_url().
I think it would be best to combine the two.

> +
> + /*
> + * |pnu.uctx->path| is in UTF-8, but we need the data
> + * in the current local locale's encoding, as mount(2)
> + * does not have something like a |MS_UTF8_SPEC| flag
> + * to indicate that the input path is in UTF-8,
> + * independently of the current locale
> + */

I don't understand this comment at all.
mount(2) doesn't care about locale (as far as I know).  The "source" is
simply a string of bytes that it is up to the filesystem to interpret.
NFS will always interpret it as utf8.  So no conversion is needed.

> + hostname =3D pnu.uctx->hostport.hostname;
> + dirname =3D mb_dirname =3D utf8str2mbstr(pnu.uctx->path);
> +
> + (void)snprintf(hostdir, sizeof(hostdir), "%s:/%s",
> + hostname, dirname);
> + spec =3D hostdir;
> +
> + if (pnu.uctx->hostport.port !=3D -1) {
> + nfs_port =3D pnu.uctx->hostport.port;
> + }
> +
> + /*
> + * Values added here based on URL parameters
> + * should be added the front of the list of options,
> + * so users can override the nfs://-URL given default.
> + *
> + * FIXME: We do not do that here for |MS_RDONLY|!
> + */
> + if (pnu.mount_params.read_only !=3D TRIS_BOOL_NOT_SET) {
> + if (pnu.mount_params.read_only)
> + flags |=3D MS_RDONLY;
> + else
> + flags &=3D ~MS_RDONLY;
> + }
> +        } else {
> + (void)strcpy(hostdir, spec);

I'm not paying much attention to the "parameter" code.  I think more
justification is needed before we can consider it.

> +
> + if (parse_devname(hostdir, &hostname, &dirname))
> + goto fail;
> + }
>=20
>   if (fill_ipv4_sockaddr(hostname, &server_addr))
>   goto fail;
> @@ -247,7 +300,7 @@ int nfs4mount(const char *spec, const char *node, int f=
lags,
>   /*
>   * NFSv4 specifies that the default port should be 2049
>   */
> - server_addr.sin_port =3D htons(NFS_PORT);
> + server_addr.sin_port =3D htons(nfs_port);
>=20
>   /* parse options */
>=20
> @@ -474,8 +527,14 @@ int nfs4mount(const char *spec, const char *node,
> int flags,
>   }
>   }
>=20
> + mount_free_parse_nfs_url(&pnu);
> + free(mb_dirname);
> +
>   return EX_SUCCESS;
>=20
>  fail:
> + mount_free_parse_nfs_url(&pnu);
> + free(mb_dirname);
> +
>   return retval;
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
>=20
>  #ifdef HAVE_RPCSVC_NFS_PROT_H
>  #include <rpcsvc/nfs_prot.h>
> @@ -493,7 +495,7 @@ nfsmount(const char *spec, const char *node, int flags,
>   char **extra_opts, int fake, int running_bg)
>  {
>   char hostdir[1024];
> - char *hostname, *dirname, *old_opts, *mounthost =3D NULL;
> + char *hostname, *dirname, *mb_dirname =3D NULL, *old_opts, *mounthost =3D=
 NULL;
>   char new_opts[1024], cbuf[1024];
>   static struct nfs_mount_data data;
>   int val;
> @@ -521,29 +523,79 @@ nfsmount(const char *spec, const char *node, int flag=
s,
>   time_t t;
>   time_t prevt;
>   time_t timeout;
> + int nfsurl_port =3D -1;
> + parsed_nfs_url pnu;
> +
> + (void)memset(&pnu, 0, sizeof(parsed_nfs_url));
>=20
>   if (strlen(spec) >=3D sizeof(hostdir)) {
>   nfs_error(_("%s: excessively long host:dir argument"),
>   progname);
>   goto fail;
>   }
> - strcpy(hostdir, spec);
> - if ((s =3D strchr(hostdir, ':'))) {
> - hostname =3D hostdir;
> - dirname =3D s + 1;
> - *s =3D '\0';
> - /* Ignore all but first hostname in replicated mounts
> -    until they can be fully supported. (mack@sgi.com) */
> - if ((s =3D strchr(hostdir, ','))) {
> +
> + /*
> + * Support nfs://-URLS per RFC 2224 ("NFS URL
> + * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> + * including custom port (nfs://hostname@port/path/...)
> + * and URL parameter (e.g. nfs://.../?param1=3Dval1&param2=3Dval2
> + * support
> + */
> + if (is_spec_nfs_url(spec)) {
> + if (!mount_parse_nfs_url(spec, &pnu)) {
> + goto fail;
> + }
> +
> + /*
> + * |pnu.uctx->path| is in UTF-8, but we need the data
> + * in the current local locale's encoding, as mount(2)
> + * does not have something like a |MS_UTF8_SPEC| flag
> + * to indicate that the input path is in UTF-8,
> + * independently of the current locale
> + */
> + hostname =3D pnu.uctx->hostport.hostname;
> + dirname =3D mb_dirname =3D utf8str2mbstr(pnu.uctx->path);
> +
> + (void)snprintf(hostdir, sizeof(hostdir), "%s:/%s",
> + hostname, dirname);
> + spec =3D hostdir;
> +
> + if (pnu.uctx->hostport.port !=3D -1) {
> + nfsurl_port =3D pnu.uctx->hostport.port;
> + }
> +
> + /*
> + * Values added here based on URL parameters
> + * should be added the front of the list of options,
> + * so users can override the nfs://-URL given default.
> + *
> + * FIXME: We do not do that here for |MS_RDONLY|!
> + */
> + if (pnu.mount_params.read_only !=3D TRIS_BOOL_NOT_SET) {
> + if (pnu.mount_params.read_only)
> + flags |=3D MS_RDONLY;
> + else
> + flags &=3D ~MS_RDONLY;
> + }
> +        } else {
> + (void)strcpy(hostdir, spec);
> + if ((s =3D strchr(hostdir, ':'))) {
> + hostname =3D hostdir;
> + dirname =3D s + 1;
>   *s =3D '\0';
> - nfs_error(_("%s: warning: "
> -   "multiple hostnames not supported"),
> + /* Ignore all but first hostname in replicated mounts
> +    until they can be fully supported. (mack@sgi.com) */
> + if ((s =3D strchr(hostdir, ','))) {
> + *s =3D '\0';
> + nfs_error(_("%s: warning: "
> + "multiple hostnames not supported"),
>   progname);
> - }
> - } else {
> - nfs_error(_("%s: directory to mount not in host:dir format"),
> + }
> + } else {
> + nfs_error(_("%s: directory to mount not in host:dir format"),
>   progname);
> - goto fail;
> + goto fail;
> + }
>   }
>=20
>   if (!nfs_gethostbyname(hostname, nfs_saddr))
> @@ -579,6 +631,14 @@ nfsmount(const char *spec, const char *node, int flags,
>   memset(nfs_pmap, 0, sizeof(*nfs_pmap));
>   nfs_pmap->pm_prog =3D NFS_PROGRAM;
>=20
> + if (nfsurl_port !=3D -1) {
> + /*
> + * Set custom TCP port defined by a nfs://-URL here,
> + * so $ mount -o port ... # can be used to override
> + */
> + nfs_pmap->pm_port =3D nfsurl_port;
> + }
> +
>   /* parse options */
>   new_opts[0] =3D 0;
>   if (!parse_options(old_opts, &data, &bg, &retry, &mnt_server, &nfs_server,
> @@ -863,10 +923,13 @@ noauth_flavors:
>   }
>   }
>=20
> + mount_free_parse_nfs_url(&pnu);
> +
>   return EX_SUCCESS;
>=20
>   /* abort */
>   fail:
> + mount_free_parse_nfs_url(&pnu);
>   if (fsock !=3D -1)
>   close(fsock);
>   return retval;
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
>=20
>  #ifndef NFS_MAXHOSTNAME
>  #define NFS_MAXHOSTNAME (255)
> @@ -179,17 +181,62 @@ static int nfs_parse_square_bracket(const char *dev,
>  }
>=20
>  /*
> - * RFC 2224 says an NFS client must grok "public file handles" to
> - * support NFS URLs.  Linux doesn't do that yet.  Print a somewhat
> - * helpful error message in this case instead of pressing forward
> - * with the mount request and failing with a cryptic error message
> - * later.
> + * Support nfs://-URLS per RFC 2224 ("NFS URL
> + * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> + * including port support (nfs://hostname@port/path/...)

Note that the above example is a "public" address.  We don't support
those in Linux - only the root.  So you need to match

    nfs://hostname:port//path....

i.e.  a double slash at the start of the path.  I don't think your code
does that.

>   */
> -static int nfs_parse_nfs_url(__attribute__((unused)) const char *dev,
> -      __attribute__((unused)) char **hostname,
> -      __attribute__((unused)) char **pathname)
> +static int nfs_parse_nfs_url(const char *dev,
> +      char **out_hostname,
> +      char **out_pathname)
>  {
> - nfs_error(_("%s: NFS URLs are not supported"), progname);
> + parsed_nfs_url pnu;
> +
> + if (out_hostname)
> + *out_hostname =3D NULL;
> + if (out_pathname)
> + *out_pathname =3D NULL;
> +
> + /*
> + * Support nfs://-URLS per RFC 2224 ("NFS URL
> + * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> + * including custom port (nfs://hostname@port/path/...)
> + * and URL parameter (e.g. nfs://.../?param1=3Dval1&param2=3Dval2
> + * support
> + */
> + if (!mount_parse_nfs_url(dev, &pnu)) {
> + goto fail;
> + }
> +
> + if (pnu.uctx->hostport.port !=3D -1) {
> + /* NOP here, unless we switch from hostname to hostport */
> + }
> +
> + if (out_hostname)
> + *out_hostname =3D strdup(pnu.uctx->hostport.hostname);
> + if (out_pathname)
> + *out_pathname =3D utf8str2mbstr(pnu.uctx->path);
> +
> + if (((out_hostname)?(*out_hostname =3D=3D NULL):0) ||
> + ((out_pathname)?(*out_pathname =3D=3D NULL):0)) {
> + nfs_error(_("%s: out of memory"),
> + progname);
> + goto fail;
> + }
> +
> + mount_free_parse_nfs_url(&pnu);
> +
> + return 1;
> +
> +fail:
> + mount_free_parse_nfs_url(&pnu);
> + if (out_hostname) {
> + free(*out_hostname);
> + *out_hostname =3D NULL;
> + }
> + if (out_pathname) {
> + free(*out_pathname);
> + *out_pathname =3D NULL;
> + }
>   return 0;
>  }
>=20
> @@ -223,7 +270,7 @@ int nfs_parse_devname(const char *devname,
>   return nfs_pdn_nomem_err();
>   if (*dev =3D=3D '[')
>   result =3D nfs_parse_square_bracket(dev, hostname, pathname);
> - else if (strncmp(dev, "nfs://", 6) =3D=3D 0)
> + else if (is_spec_nfs_url(dev))
>   result =3D nfs_parse_nfs_url(dev, hostname, pathname);
>   else
>   result =3D nfs_parse_simple_hostname(dev, hostname, pathname);
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
>=20
>  #ifndef NFS_PROGRAM
>  #define NFS_PROGRAM (100003)
> @@ -643,24 +645,106 @@ static int nfs_sys_mount(struct nfsmount_info
> *mi, struct mount_options *opts)
>  {
>   char *options =3D NULL;
>   int result;
> + int nfs_port =3D 2049;
>=20
>   if (mi->fake)
>   return 1;
>=20
> - if (po_join(opts, &options) =3D=3D PO_FAILED) {
> - errno =3D EIO;
> - return 0;
> - }
> + /*
> + * Support nfs://-URLS per RFC 2224 ("NFS URL
> + * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> + * including custom port (nfs://hostname@port/path/...)
> + * and URL parameter (e.g. nfs://.../?param1=3Dval1&param2=3Dval2
> + * support
> + */
> + if (is_spec_nfs_url(mi->spec)) {
> + parsed_nfs_url pnu;
> + char *mb_path;
> + char mount_source[1024];
> +
> + if (!mount_parse_nfs_url(mi->spec, &pnu)) {
> + result =3D 1;
> + errno =3D EINVAL;
> + goto done;
> + }
> +
> + /*
> + * |pnu.uctx->path| is in UTF-8, but we need the data
> + * in the current local locale's encoding, as mount(2)
> + * does not have something like a |MS_UTF8_SPEC| flag
> + * to indicate that the input path is in UTF-8,
> + * independently of the current locale
> + */
> + mb_path =3D utf8str2mbstr(pnu.uctx->path);
> + if (!mb_path) {
> + nfs_error(_("%s: Could not convert path to local encoding."),
> + progname);
> + mount_free_parse_nfs_url(&pnu);
> + result =3D 1;
> + errno =3D EINVAL;
> + goto done;
> + }
> +
> + (void)snprintf(mount_source, sizeof(mount_source),
> + "%s:/%s",
> + pnu.uctx->hostport.hostname,
> + mb_path);
> + free(mb_path);
> +
> + if (pnu.uctx->hostport.port !=3D -1) {
> + nfs_port =3D pnu.uctx->hostport.port;
> + }
>=20
> - result =3D mount(mi->spec, mi->node, mi->type,
> + /*
> + * Insert "port=3D" option with the value from the nfs://
> + * URL at the beginning of the list of options, so
> + * users can override it with $ mount.nfs4 -o port=3D #,
> + * e.g.
> + * $ mount.nfs4 -o port=3D1234 nfs://10.49.202.230:400//bigdisk /mnt4 #
> + * should use port 1234, and not port 400 as specified
> + * in the URL.
> + */
> + char portoptbuf[5+32+1];
> + (void)snprintf(portoptbuf, sizeof(portoptbuf), "port=3D%d", nfs_port);
> + (void)po_insert(opts, portoptbuf);
> +
> + if (pnu.mount_params.read_only !=3D TRIS_BOOL_NOT_SET) {
> + if (pnu.mount_params.read_only)
> + mi->flags |=3D MS_RDONLY;
> + else
> + mi->flags &=3D ~MS_RDONLY;
> + }
> +
> + mount_free_parse_nfs_url(&pnu);
> +
> + if (po_join(opts, &options) =3D=3D PO_FAILED) {
> + errno =3D EIO;
> + result =3D 1;
> + goto done;
> + }
> +
> + result =3D mount(mount_source, mi->node, mi->type,
> + mi->flags & ~(MS_USER|MS_USERS), options);
> + free(options);
> + } else {
> + if (po_join(opts, &options) =3D=3D PO_FAILED) {
> + errno =3D EIO;
> + result =3D 1;
> + goto done;
> + }
> +
> + result =3D mount(mi->spec, mi->node, mi->type,
>   mi->flags & ~(MS_USER|MS_USERS), options);
> - free(options);
> + free(options);
> + }
>=20
>   if (verbose && result) {
>   int save =3D errno;
>   nfs_error(_("%s: mount(2): %s"), progname, strerror(save));
>   errno =3D save;
>   }
> +
> +done:
>   return !result;
>  }
>=20
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
> + * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
> + * of this software and associated documentation files (the
> "Software"), to deal
> + * in the Software without restriction, including without limitation the r=
ights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> included in all
> + * copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
 THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS IN THE
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
> + url_parser_context c;
> +
> + /* Private data */
> + char *parameter_string_buff;
> +} url_parser_context_private;
> +
> +#define MAX_URL_PARAMETERS 256
> +
> +/*
> + * Original extended regular expression:
> + *
> + * "^"
> + * "(.+?)" // scheme
> + * "://" // '://'
> + * "(" // login
> + * "(?:"
> + * "(.+?)" // user (optional)
> + * "(?::(.+))?" // password (optional)
> + * "@"
> + * ")?"
> + * "(" // hostport
> + * "(.+?)" // host
> + * "(?::([[:digit:]]+))?" // port (optional)
> + * ")"
> + * ")"
> + * "(?:/(.*?))?" // path (optional)
> + * "(?:\?(.*?))?" // URL parameters (optional)
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
> +#define DBG_PUTS(str, fp) fputws(L"" str, (fp))
> +#define DBG_PUTC(c, fp) fputwc(btowc(c), (fp))
> +#define DBG_PRINTF(fp, fmt, ...) fwprintf((fp), L"" fmt, __VA_ARGS__)
> +#else
> +#define DBG_PUTS(str, fp) fputs((str), (fp))
> +#define DBG_PUTC(c, fp) fputc((c), (fp))
> +#define DBG_PRINTF(fp, fmt, ...) fprintf((fp), fmt, __VA_ARGS__)
> +#endif /* DBG_USE_WIDECHAR */
> +
> +static
> +void urldecodestr(char *outbuff, const char *buffer, size_t len)
> +{
> + size_t i, j;
> +
> + for (i =3D j =3D 0 ; i < len ; ) {
> + switch (buffer[i]) {
> + case '%':
> + if ((i + 2) < len) {
> + if (isxdigit((int)buffer[i+1]) && isxdigit((int)buffer[i+2])) {

You don't need 2 "if"s here.

 if (i+2 < len && isxdigit(buffer[i+1]) && isxdigit(buffer[i+2])) {

> + const char hexstr[3] =3D {
> + buffer[i+1],
> + buffer[i+2],
> + '\0'
> + };
> + outbuff[j++] =3D (unsigned char)strtol(hexstr, NULL, 16);
> + i +=3D 3;
> + } else {
> + /* invalid hex digit */
> + outbuff[j++] =3D buffer[i];
> + i++;
> + }
> + } else {
> + /* incomplete hex digit */
> + outbuff[j++] =3D buffer[i];
> + i++;
> + }
> + break;
> + case '+':
> + outbuff[j++] =3D ' ';
> + i++;
> + break;
> + default:
> + outbuff[j++] =3D buffer[i++];
> + break;
> + }
> + }
> +
> + outbuff[j] =3D '\0';
> +}
> +
> +url_parser_context *url_parser_create_context(const char *in_url,
> unsigned int flags)
> +{
> + url_parser_context_private *uctx;
> + char *s;
> + size_t in_url_len;
> + size_t context_len;
> +
> + /* |flags| is for future extensions */
> + (void)flags;
> +
> + if (!in_url)
> + return NULL;
> +
> + in_url_len =3D strlen(in_url);
> +
> + context_len =3D sizeof(url_parser_context_private) +
> + ((in_url_len+1)*6) +
> + (sizeof(url_parser_name_value)*MAX_URL_PARAMETERS)+sizeof(void*);
> + uctx =3D malloc(context_len);
> + if (!uctx)
> + return NULL;
> +
> + s =3D (void *)(uctx+1);
> + uctx->c.in_url =3D s; s+=3D in_url_len+1;
> + (void)strcpy(uctx->c.in_url, in_url);
> + uctx->c.scheme =3D s; s+=3D in_url_len+1;
> + uctx->c.login.username =3D s; s+=3D in_url_len+1;
> + uctx->c.hostport.hostname =3D s; s+=3D in_url_len+1;
> + uctx->c.path =3D s; s+=3D in_url_len+1;
> + uctx->c.hostport.port =3D -1;
> + uctx->c.num_parameters =3D -1;
> + uctx->c.parameters =3D (void *)s; s+=3D
> (sizeof(url_parser_name_value)*MAX_URL_PARAMETERS)+sizeof(void*);
> + uctx->parameter_string_buff =3D s; s+=3D in_url_len+1;
> +
> + return &uctx->c;
> +}
> +
> +int url_parser_parse(url_parser_context *ctx)
> +{
> + url_parser_context_private *uctx =3D (url_parser_context_private *)ctx;
> +
> + D((void)DBG_PRINTF(stderr, "## parser in_url=3D'%s'\n", uctx->c.in_url));
> +
> + char *s;
> + const char *urlstr =3D uctx->c.in_url;
> + size_t slen;
> +
> + s =3D strstr(urlstr, "://");
> + if (!s) {
> + D((void)DBG_PUTS("url_parser: Not an URL\n", stderr));
> + return -1;
> + }
> +
> + slen =3D s-urlstr;
> + (void)memcpy(uctx->c.scheme, urlstr, slen);
> + uctx->c.scheme[slen] =3D '\0';
> + urlstr +=3D slen + 3;
> +
> + D((void)DBG_PRINTF(stdout, "scheme=3D'%s', rest=3D'%s'\n",
> uctx->c.scheme, urlstr));
> +
> + s =3D strstr(urlstr, "@");
> + if (s) {
> + /* URL has user/password */

This need to check the '@' is after a '/'.

> + slen =3D s-urlstr;
> + urldecodestr(uctx->c.login.username, urlstr, slen);
> + urlstr +=3D slen + 1;
> +
> + s =3D strstr(uctx->c.login.username, ":");
> + if (s) {
> + /* found passwd */
> + uctx->c.login.passwd =3D s+1;
> + *s =3D '\0';
> + }
> + else {
> + uctx->c.login.passwd =3D NULL;
> + }
> +
> + /* catch password-only URLs */
> + if (uctx->c.login.username[0] =3D=3D '\0')
> + uctx->c.login.username =3D NULL;
> + }
> + else {
> + uctx->c.login.username =3D NULL;
> + uctx->c.login.passwd =3D NULL;
> + }
> +
> + D((void)DBG_PRINTF(stdout, "login=3D'%s', passwd=3D'%s', rest=3D'%s'\n",
> + DBGNULLSTR(uctx->c.login.username),
> + DBGNULLSTR(uctx->c.login.passwd),
> + DBGNULLSTR(urlstr)));
> +
> + char *raw_parameters;
> +
> + uctx->c.num_parameters =3D 0;
> + raw_parameters =3D strstr(urlstr, "?");
> + /* Do we have a non-empty parameter string ? */
> + if (raw_parameters && (raw_parameters[1] !=3D '\0')) {
> + *raw_parameters++ =3D '\0';
> + D((void)DBG_PRINTF(stdout, "raw parameters =3D '%s'\n", raw_parameters));
> +
> + char *ps =3D raw_parameters;
> + char *pv; /* parameter value */
> + char *na; /* next '&' */
> + char *pb =3D uctx->parameter_string_buff;
> + char *pname;
> + char *pvalue;
> + ssize_t pi;
> +
> + for (pi =3D 0; pi < MAX_URL_PARAMETERS ; pi++) {
> + pname =3D ps;
> +
> + /*
> + * Handle parameters without value,
> + * e.g. "path?name1&name2=3Dvalue2"
> + */
> + na =3D strstr(ps, "&");
> + pv =3D strstr(ps, "=3D");
> + if (pv && (na?(na > pv):true)) {
> + *pv++ =3D '\0';
> + pvalue =3D pv;
> + ps =3D pv;
> + }
> + else {
> + pvalue =3D NULL;
> + }
> +
> + if (na) {
> + *na++ =3D '\0';
> + }
> +
> + /* URLDecode parameter name */
> + urldecodestr(pb, pname, strlen(pname));
> + uctx->c.parameters[pi].name =3D pb;
> + pb +=3D strlen(uctx->c.parameters[pi].name)+1;
> +
> + /* URLDecode parameter value */
> + if (pvalue) {
> + urldecodestr(pb, pvalue, strlen(pvalue));
> + uctx->c.parameters[pi].value =3D pb;
> + pb +=3D strlen(uctx->c.parameters[pi].value)+1;
> + }
> + else {
> + uctx->c.parameters[pi].value =3D NULL;
> + }
> +
> + /* Next '&' ? */
> + if (!na)
> + break;
> +
> + ps =3D na;
> + }
> +
> + uctx->c.num_parameters =3D pi+1;
> + }
> +
> + s =3D strstr(urlstr, "/");
> + if (s) {
> + /* URL has hostport */
> + slen =3D s-urlstr;
> + urldecodestr(uctx->c.hostport.hostname, urlstr, slen);
> + urlstr +=3D slen + 1;
> +
> + /*
> + * check for addresses within '[' and ']', like
> + * IPv6 addresses
> + */
> + s =3D uctx->c.hostport.hostname;
> + if (s[0] =3D=3D '[')
> + s =3D strstr(s, "]");
> +
> + if (s =3D=3D NULL) {
> + D((void)DBG_PUTS("url_parser: Unmatched '[' in hostname\n", stderr));
> + return -1;
> + }
> +
> + s =3D strstr(s, ":");
> + if (s) {
> + /* found port number */
> + uctx->c.hostport.port =3D atoi(s+1);
> + *s =3D '\0';
> + }
> + }
> + else {
> + (void)strcpy(uctx->c.hostport.hostname, urlstr);
> + uctx->c.path =3D NULL;
> + urlstr =3D NULL;
> + }
> +
> + D(
> + (void)DBG_PRINTF(stdout,
> + "hostport=3D'%s', port=3D%d, rest=3D'%s', num_parameters=3D%d\n",
> + DBGNULLSTR(uctx->c.hostport.hostname),
> + uctx->c.hostport.port,
> + DBGNULLSTR(urlstr),
> + (int)uctx->c.num_parameters);
> + );
> +
> +
> + D(
> + ssize_t dpi;
> + for (dpi =3D 0 ; dpi < uctx->c.num_parameters ; dpi++) {
> + (void)DBG_PRINTF(stdout,
> + "param[%d]: name=3D'%s'/value=3D'%s'\n",
> + (int)dpi,
> + uctx->c.parameters[dpi].name,
> + DBGNULLSTR(uctx->c.parameters[dpi].value));
> + }
> + );
> +
> + if (!urlstr) {
> + goto done;
> + }
> +
> + urldecodestr(uctx->c.path, urlstr, strlen(urlstr));
> + D((void)DBG_PRINTF(stdout, "path=3D'%s'\n", uctx->c.path));
> +
> +done:
> + return 0;
> +}
> +
> +void url_parser_free_context(url_parser_context *c)
> +{
> + free(c);
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
> + * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
> + * of this software and associated documentation files (the
> "Software"), to deal
> + * in the Software without restriction, including without limitation the r=
ights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> included in all
> + * copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
 THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS IN THE
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
> + char *name;
> + char *value;
> +} url_parser_name_value;
> +
> +typedef struct _url_parser_context {
> + char *in_url;
> +
> + char *scheme;
> + struct {
> + char *username;
> + char *passwd;
> + } login;
> + struct {
> + char *hostname;
> + signed int port;
> + } hostport;
> + char *path;
> +
> + ssize_t num_parameters;
> + url_parser_name_value *parameters;
> +} url_parser_context;
> +
> +/* Prototypes */
> +url_parser_context *url_parser_create_context(const char *in_url,
> unsigned int flags);
> +int url_parser_parse(url_parser_context *uctx);
> +void url_parser_free_context(url_parser_context *c);
> +
> +#endif /* !__URLPARSER1_H__ */
> diff --git a/utils/mount/utils.c b/utils/mount/utils.c
> index b7562a47..2d4cfa5a 100644
> --- a/utils/mount/utils.c
> +++ b/utils/mount/utils.c
> @@ -28,6 +28,7 @@
>  #include <unistd.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <iconv.h>
>=20
>  #include "sockaddr.h"
>  #include "nfs_mount.h"
> @@ -173,3 +174,157 @@ int nfs_umount23(const char *devname, char *string)
>   free(dirname);
>   return result;
>  }
> +
> +/* Convert UTF-8 string to multibyte string in the current locale */
> +char *utf8str2mbstr(const char *utf8_str)
> +{
> + iconv_t cd;
> +
> + cd =3D iconv_open("UTF-8", "");
> + if (cd =3D=3D (iconv_t)-1) {
> + perror("utf8str2mbstr: iconv_open failed");
> + return NULL;
> + }
> +
> + size_t inbytesleft =3D strlen(utf8_str);
> + char *inbuf =3D (char *)utf8_str;
> + size_t outbytesleft =3D inbytesleft*4+1;
> + char *outbuf =3D malloc(outbytesleft);
> + char *outbuf_orig =3D outbuf;
> +
> + if (!outbuf) {
> + perror("utf8str2mbstr: out of memory");
> + (void)iconv_close(cd);
> + return NULL;
> + }
> +
> + int ret =3D iconv(cd, &inbuf, &inbytesleft, &outbuf, &outbytesleft);
> + if (ret =3D=3D -1) {
> + perror("utf8str2mbstr: iconv() failed");
> + free(outbuf_orig);
> + (void)iconv_close(cd);
> + return NULL;
> + }
> +
> + *outbuf =3D '\0';
> +
> + (void)iconv_close(cd);
> + return outbuf_orig;
> +}
> +
> +/* fixme: We should use |bool|! */
> +int is_spec_nfs_url(const char *spec)
> +{
> + return (!strncmp(spec, "nfs://", 6));

Ugh.  I personally hate this !strcmp style.
It looks like is testing for "not" something, but it isn't.
I MUCH prefer
   strncmp(spec, "nfs://", 6) =3D=3D 0

The "=3D=3D" makes it clear that it is testing for equality.


> +}
> +
> +int mount_parse_nfs_url(const char *spec, parsed_nfs_url *pnu)
> +{
> + int result =3D 1;
> + url_parser_context *uctx =3D NULL;
> +
> + (void)memset(pnu, 0, sizeof(parsed_nfs_url));
> + pnu->mount_params.read_only =3D TRIS_BOOL_NOT_SET;
> +
> + uctx =3D url_parser_create_context(spec, 0);
> + if (!uctx) {
> + nfs_error(_("%s: out of memory"),
> + progname);
> + result =3D 1;
> + goto done;
> + }
> +
> + if (url_parser_parse(uctx) < 0) {
> + nfs_error(_("%s: Error parsing nfs://-URL."),
> + progname);
> + result =3D 1;
> + goto done;
> + }
> + if (uctx->login.username || uctx->login.passwd) {
> + nfs_error(_("%s: Username/Password are not defined for nfs://-URL."),
> + progname);
> + result =3D 1;
> + goto done;
> + }
> + if (!uctx->path) {
> + nfs_error(_("%s: Path missing in nfs://-URL."),
> + progname);
> + result =3D 1;
> + goto done;
> + }
> + if (uctx->path[0] !=3D '/') {
> + nfs_error(_("%s: Relative nfs://-URLs are not supported."),
> + progname);
> + result =3D 1;
> + goto done;
> + }
> +
> + if (uctx->num_parameters > 0) {
> + int pi;
> + const char *pname;
> + const char *pvalue;
> +
> + /*
> + * Values added here based on URL parameters
> + * should be added the front of the list of options,
> + * so users can override the nfs://-URL given default.
> + */
> + for (pi =3D 0; pi < uctx->num_parameters ; pi++) {
> + pname =3D uctx->parameters[pi].name;
> + pvalue =3D uctx->parameters[pi].value;
> +
> + if (!strcmp(pname, "rw")) {
> + if ((pvalue =3D=3D NULL) || (!strcmp(pvalue, "1"))) {
> + pnu->mount_params.read_only =3D TRIS_BOOL_FALSE;
> + }
> + else if (!strcmp(pvalue, "0")) {
> + pnu->mount_params.read_only =3D TRIS_BOOL_TRUE;
> + }
> + else {
> + nfs_error(_("%s: Unsupported nfs://-URL "
> + "parameter '%s' value '%s'."),
> + progname, pname, pvalue);
> + result =3D 1;
> + goto done;
> + }
> + }
> + else if (!strcmp(pname, "ro")) {
> + if ((pvalue =3D=3D NULL) || (!strcmp(pvalue, "1"))) {
> + pnu->mount_params.read_only =3D TRIS_BOOL_TRUE;
> + }
> + else if (!strcmp(pvalue, "0")) {
> + pnu->mount_params.read_only =3D TRIS_BOOL_FALSE;
> + }
> + else {
> + nfs_error(_("%s: Unsupported nfs://-URL "
> + "parameter '%s' value '%s'."),
> + progname, pname, pvalue);
> + result =3D 1;
> + goto done;
> + }
> + }
> + else {
> + nfs_error(_("%s: Unsupported nfs://-URL "
> + "parameter '%s'."),
> + progname, pname);
> + result =3D 1;
> + goto done;
> + }
> + }
> + }
> +
> + result =3D 0;
> +done:
> + if (result !=3D 0) {
> + url_parser_free_context(uctx);
> + return 0;
> + }
> +
> + pnu->uctx =3D uctx;
> + return 1;
> +}
> +
> +void mount_free_parse_nfs_url(parsed_nfs_url *pnu)
> +{
> + url_parser_free_context(pnu->uctx);
> +}
> diff --git a/utils/mount/utils.h b/utils/mount/utils.h
> index 224918ae..465c0a5e 100644
> --- a/utils/mount/utils.h
> +++ b/utils/mount/utils.h
> @@ -24,13 +24,36 @@
>  #define _NFS_UTILS_MOUNT_UTILS_H
>=20
>  #include "parse_opt.h"
> +#include "urlparser1.h"
>=20
> +/* Boolean with three states: { not_set, false, true */
> +typedef signed char tristate_bool;
> +#define TRIS_BOOL_NOT_SET (-1)
> +#define TRIS_BOOL_TRUE (1)
> +#define TRIS_BOOL_FALSE (0)
> +
> +#define TRIS_BOOL_GET_VAL(tsb, tsb_default) \
> + (((tsb)!=3DTRIS_BOOL_NOT_SET)?(tsb):(tsb_default))
> +
> +typedef struct _parsed_nfs_url {
> + url_parser_context *uctx;
> + struct {
> + tristate_bool read_only;
> + } mount_params;
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
>=20
>  int nfs_umount23(const char *devname, char *string);
>=20
> +int mount_parse_nfs_url(const char *spec, parsed_nfs_url *pnu);
> +void mount_free_parse_nfs_url(parsed_nfs_url *pnu);
> +
>  #endif /* !_NFS_UTILS_MOUNT_UTILS_H */
> --=20
> 2.30.2
> ---- snip ----
>=20
> ----
>=20
> Bye,
> Roland
> --=20
>   __ .  . __
>  (o.\ \/ /.o) roland.mainz@nrubsig.org
>   \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
>   /O /=3D=3D\ O\  TEL +49 641 3992797
>  (;O/ \/ \O;)
>=20


NeilBrown

