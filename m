Return-Path: <linux-nfs+bounces-2081-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A5D86670D
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 00:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD2F9B20DD2
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Feb 2024 23:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E150E1BC31;
	Sun, 25 Feb 2024 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ES4rSOwA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bKcg1+38";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RaHUHjJ7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n/BoFSb3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE241B94E
	for <linux-nfs@vger.kernel.org>; Sun, 25 Feb 2024 23:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708905430; cv=none; b=FefF+zG/M3YHwWyaya+qUxG5mqIH019myPh5Cet1SCwA7mUMaUtj2/XoaquSCjjlKY5gpiMBvqQ8bzgJ5aQcNtIUaJYRy+I+tPmWCmuBpU1iHGiZtjpKmHDRc0THbcd5IKsFKm8GZA6k96hZ6yYSQKycfLCWvl4rgWCMkzu/WwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708905430; c=relaxed/simple;
	bh=KHI2Z1Q4UmL1TSbIWWXhDKICyitZ4QSc+DKIfGBGygg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCGXNoYv+Uc/wewLqr9k+5yN2mEsIT3PirDYIBnZc0wWiM5XOxn5bLODIdV/1ydW0L9fHt0yuDaCiKhx3aZ1MmMUTtLceWLRqkBdU34jfxFq7nP160xU3lZOb3MGam/fSsbGDN4ScCUP9J83l13SBUjHWgIwPTVDxrDF9x5RRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ES4rSOwA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bKcg1+38; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RaHUHjJ7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n/BoFSb3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7B7E1224AE;
	Sun, 25 Feb 2024 23:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708905427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IurPwmuUAjX6zsDna8Z2CwOq6akHYm61/vixzhal1KU=;
	b=ES4rSOwAGT9nA3kKIZeU3M02nF0UWWuL2gVsi5gPUw4T51BUBZu7ZU+DcOKULIR5VXf7Eg
	CPTJdi4p1PHEJWe2d4shs7coDg+XXyiGgD46a8ug1hIwyQ7LJntfNcJvh7nFNQ8SqHIzam
	v/jrJc0J9HBU9cZu5ZvF8WdOldA7k1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708905427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IurPwmuUAjX6zsDna8Z2CwOq6akHYm61/vixzhal1KU=;
	b=bKcg1+38qZpbL+XF9YSrsPIc9tWnWQa2N8uTU3AgAtA9ZIC2SZXYdEIcs399lhuKJx8mGG
	YPzM4BoGbVOVBeBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708905425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IurPwmuUAjX6zsDna8Z2CwOq6akHYm61/vixzhal1KU=;
	b=RaHUHjJ71BcnqSeVGoiEjp58Q/Y61e46nt0uin+BH7XLUADeTDwB2P2QVPwIcAbeyWd6vB
	voCg42VprRZOwDlwNbTAkURzDdN6E4uoBAxv6Ph4Era3AtImoqYN7P1IfsGcf+oUCmTn5B
	HGAdnEX8YqmltP1m6lk/gZRowEfHnHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708905425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IurPwmuUAjX6zsDna8Z2CwOq6akHYm61/vixzhal1KU=;
	b=n/BoFSb3e5ejBp8oZ8/YRBh9eJi39ry5oOZkU3LfoxTavOg8Ey3RYXWF6r4mUFM5Ctcc53
	XGBUEvRBHuHl3rAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 013F413432;
	Sun, 25 Feb 2024 23:57:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pBvxJc/T22XFJgAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 25 Feb 2024 23:57:03 +0000
From: NeilBrown <neilb@suse.de>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org,
	Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 3/4] Listen on an AF_UNIX abstract address if supported.
Date: Mon, 26 Feb 2024 10:53:55 +1100
Message-ID: <20240225235628.12473-4-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225235628.12473-1-neilb@suse.de>
References: <20240225235628.12473-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RaHUHjJ7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="n/BoFSb3"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[socket.in:url,configure.ac:url,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: 7B7E1224AE
X-Spam-Flag: NO

As RPC is primarily a network service it is best, on Linux, to use
network namespaces to isolate it.  However contacting rpcbind via an
AF_UNIX socket allows escape from the network namespace.
If clients could use an abstract address, that would ensure clients
contact an rpcbind in the same network namespace.

systemd can pass in a listening abstract socket by providing an '@'
prefix.  However with libtirpc 1.3.3 or earlier attempting this will
fail as the library mistakenly determines that the socket is not bound.
This generates unsightly error messages.
So it is best not to request the abstract address when it is not likely
to work.

A patch to fix this also proposes adding a define for
_PATH_RPCBINDSOCK_ABSTRACT to the header files.  We can check for this
and only include the new ListenStream when that define is present.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 configure.ac                                  | 13 ++++++++++++-
 systemd/{rpcbind.socket => rpcbind.socket.in} |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)
 rename systemd/{rpcbind.socket => rpcbind.socket.in} (88%)

diff --git a/configure.ac b/configure.ac
index c2069a2b3b0e..573e4fdf3a3e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -50,6 +50,17 @@ AC_SUBST([nss_modules], [$with_nss_modules])
 
 PKG_CHECK_MODULES([TIRPC], [libtirpc])
 
+CPPFLAGS=$TIRPC_CFLAGS
+AC_MSG_CHECKING([for abstract socket support in libtirpc])
+AC_COMPILE_IFELSE([AC_LANG_PROGRAM([
+#include <rpc/rpc.h>
+],[
+char *path = _PATH_RPCBINDSOCK_ABSTRACT;
+])], [have_abstract=yes], [have_abstract=no])
+CPPFLAGS=
+AC_MSG_RESULT([$have_abstract])
+AM_CONDITIONAL(ABSTRACT, [ test "x$have_abstract" = "xyes" ])
+
 PKG_PROG_PKG_CONFIG
 AC_ARG_WITH([systemdsystemunitdir],
   AS_HELP_STRING([--with-systemdsystemunitdir=DIR], [Directory for systemd service files]),
@@ -76,4 +87,4 @@ AC_CHECK_HEADERS([nss.h])
 AC_SUBST([_sbindir])
 AC_CONFIG_COMMANDS_PRE([eval eval _sbindir=$sbindir])
 
-AC_OUTPUT([Makefile systemd/rpcbind.service])
+AC_OUTPUT([Makefile systemd/rpcbind.service systemd/rpcbind.socket])
diff --git a/systemd/rpcbind.socket b/systemd/rpcbind.socket.in
similarity index 88%
rename from systemd/rpcbind.socket
rename to systemd/rpcbind.socket.in
index 3b1a93694c21..5dd09a143e16 100644
--- a/systemd/rpcbind.socket
+++ b/systemd/rpcbind.socket.in
@@ -6,6 +6,7 @@ Before=rpcbind.target
 
 [Socket]
 ListenStream=/run/rpcbind.sock
+@ABSTRACT_TRUE@ListenStream=@/run/rpcbind.sock
 
 # RPC netconfig can't handle ipv6/ipv4 dual sockets
 BindIPv6Only=ipv6-only
-- 
2.43.0


