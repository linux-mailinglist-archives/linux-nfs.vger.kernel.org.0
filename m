Return-Path: <linux-nfs+bounces-2176-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8408709C8
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 19:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B8328B085
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 18:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366DD7869A;
	Mon,  4 Mar 2024 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RBvPix+l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IURH9rls";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RQ6sG4oq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z/kxwz9x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817762143
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577761; cv=none; b=JbN8kiz9VX0aLceZwLc4Qoq/922lmUSpZdWXqMqlBMaytw5zPY9TN6uiy8Xmb98UGtP6xc27KVDZPxwq1M2HNXFLkMQjLErnNEAkh9TjAV81xtROiB5DbWjAUXiAyHu47Iy0sIVXxpYHNUKnPhJ3iKFfixiZf+ltS8k+zoZfBes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577761; c=relaxed/simple;
	bh=6WXkHExHCRgUVDcr95pHjnW7VWH6MBj4Qvtdr0jrvDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFgWAO6h59yYAxtQXnNJhKgU0ltY/3CTCsyGZhuSI64sA7rVnAQuLEIzcnBOTLAWvSw0oQagdkhtKu5ClYJ+XyDsISqgMjZDZenOqAXHkkuuHvbtJpijRVNViweqZUQW2sHQ00x48iPyRxhPPikB7bS37nc+p+UZEQbRefRNUP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RBvPix+l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IURH9rls; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RQ6sG4oq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z/kxwz9x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46CB733C32;
	Mon,  4 Mar 2024 18:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709577757;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UenYLZ4N+1JfRnuRXGzfgnlKi3yWZzFLY58xaHLHJfg=;
	b=RBvPix+lN3CAqCxhUBz68HK140Timu7G6qK7UgGYHc+nKZa8PFfmFUutlPtxvBXpzhnG9B
	fN6dCehbq3+WpE47CLNt9/lt4G0hrIXvDezjDZbeg5JIGmsj4lmsw6csqPDlXFSfCAwtN4
	iQIkBNEN86NmvJ3gZWY+OG31EFUjFIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709577757;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UenYLZ4N+1JfRnuRXGzfgnlKi3yWZzFLY58xaHLHJfg=;
	b=IURH9rlsLZbN6g9hJ6TKyk0zu0F10brnEPJ9lmVNJMbDCcsjnIPCMjX7uW/eLJdP6ZekP0
	KOVceU7chOXTgjCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709577755;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UenYLZ4N+1JfRnuRXGzfgnlKi3yWZzFLY58xaHLHJfg=;
	b=RQ6sG4oqf+oJYkwBn2Lw3kOCxEUd4ljYsX5goxtWDwJnebSOAnUrVl4GjaZ6o5oKEOD6rg
	jRc4fo8ViOgfZvy9RS0/E8qzqzejA+5d8WRKVBvW/Eif97NJCxULe21cA8EsrLzPdqHenF
	flDsGDA3C6HFcC6l6WB6zT+/oH55jpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709577755;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UenYLZ4N+1JfRnuRXGzfgnlKi3yWZzFLY58xaHLHJfg=;
	b=z/kxwz9xnAjwkj1ULw9/4Jii7ijt+ZYEnHtFlpn8t2Lh4u5hH8pUaPp/GfHg/9vLYZiNrN
	WP1ZiEUwdAA9b3AA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1870613419;
	Mon,  4 Mar 2024 18:42:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id QzcHAxsW5mUaIAAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Mon, 04 Mar 2024 18:42:35 +0000
Date: Mon, 4 Mar 2024 19:42:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: NeilBrown <neilb@suse.de>
Cc: Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 3/4] Listen on an AF_UNIX abstract address if supported.
Message-ID: <20240304184229.GC3408054@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240225235628.12473-1-neilb@suse.de>
 <20240225235628.12473-4-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225235628.12473-4-neilb@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.50
X-Spamd-Result: default: False [-0.50 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,socket.in:url,suse.de:email,configure.ac:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[22.98%]
X-Spam-Flag: NO

Hi Neil, Steve,

> As RPC is primarily a network service it is best, on Linux, to use
> network namespaces to isolate it.  However contacting rpcbind via an
> AF_UNIX socket allows escape from the network namespace.
> If clients could use an abstract address, that would ensure clients
> contact an rpcbind in the same network namespace.

> systemd can pass in a listening abstract socket by providing an '@'
> prefix.  However with libtirpc 1.3.3 or earlier attempting this will
> fail as the library mistakenly determines that the socket is not bound.
> This generates unsightly error messages.
> So it is best not to request the abstract address when it is not likely
> to work.

> A patch to fix this also proposes adding a define for
> _PATH_RPCBINDSOCK_ABSTRACT to the header files.  We can check for this
> and only include the new ListenStream when that define is present.

> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  configure.ac                                  | 13 ++++++++++++-
>  systemd/{rpcbind.socket => rpcbind.socket.in} |  1 +
>  2 files changed, 13 insertions(+), 1 deletion(-)
>  rename systemd/{rpcbind.socket => rpcbind.socket.in} (88%)
NOTE: now systemd/rpcbind.socket should be in .gitignore.

The rest LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> diff --git a/configure.ac b/configure.ac
> index c2069a2b3b0e..573e4fdf3a3e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -50,6 +50,17 @@ AC_SUBST([nss_modules], [$with_nss_modules])

>  PKG_CHECK_MODULES([TIRPC], [libtirpc])

> +CPPFLAGS=$TIRPC_CFLAGS
> +AC_MSG_CHECKING([for abstract socket support in libtirpc])
> +AC_COMPILE_IFELSE([AC_LANG_PROGRAM([
> +#include <rpc/rpc.h>
> +],[
> +char *path = _PATH_RPCBINDSOCK_ABSTRACT;
> +])], [have_abstract=yes], [have_abstract=no])
> +CPPFLAGS=
> +AC_MSG_RESULT([$have_abstract])
> +AM_CONDITIONAL(ABSTRACT, [ test "x$have_abstract" = "xyes" ])
> +
>  PKG_PROG_PKG_CONFIG
>  AC_ARG_WITH([systemdsystemunitdir],
>    AS_HELP_STRING([--with-systemdsystemunitdir=DIR], [Directory for systemd service files]),
> @@ -76,4 +87,4 @@ AC_CHECK_HEADERS([nss.h])
>  AC_SUBST([_sbindir])
>  AC_CONFIG_COMMANDS_PRE([eval eval _sbindir=$sbindir])

> -AC_OUTPUT([Makefile systemd/rpcbind.service])
> +AC_OUTPUT([Makefile systemd/rpcbind.service systemd/rpcbind.socket])
> diff --git a/systemd/rpcbind.socket b/systemd/rpcbind.socket.in
> similarity index 88%
> rename from systemd/rpcbind.socket
> rename to systemd/rpcbind.socket.in
> index 3b1a93694c21..5dd09a143e16 100644
> --- a/systemd/rpcbind.socket
> +++ b/systemd/rpcbind.socket.in
> @@ -6,6 +6,7 @@ Before=rpcbind.target

>  [Socket]
>  ListenStream=/run/rpcbind.sock
> +@ABSTRACT_TRUE@ListenStream=@/run/rpcbind.sock

>  # RPC netconfig can't handle ipv6/ipv4 dual sockets
>  BindIPv6Only=ipv6-only

