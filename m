Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8AF6FE72E
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 00:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjEJW2B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 May 2023 18:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbjEJW17 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 May 2023 18:27:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5730B30FF
        for <linux-nfs@vger.kernel.org>; Wed, 10 May 2023 15:27:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 184281FD72;
        Wed, 10 May 2023 22:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683757677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rmcDvBb1DN+dpV/CeQXfXBRRLbc1BkZEL5uTjoENFmE=;
        b=pLkxA5GVkves6GRxPIN9vCiJ997k2ua0StB0ZuHk7Mj68RlQ/aMD8ExeUY8Wv/7fz4ZDQ+
        +h64hQrBWg2nbyTIBenDxIbhfyI2tlL1scG0JlrHMBz5zTu0hF3Fhav+dqZrCFlrKNU9Lx
        RFFgL0Ls9Tq7wIoISRZA1cDiaAf5fvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683757677;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rmcDvBb1DN+dpV/CeQXfXBRRLbc1BkZEL5uTjoENFmE=;
        b=lOHS6K92tv//tGikFVjyFB3zhOx/dzIZK6PDFWRmHAc/OmZiybkt+g+PbjCxLyXF0PcACz
        H9iH4jlJmOvUggBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6C1013519;
        Wed, 10 May 2023 22:27:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I/tSJmoaXGR2DAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 10 May 2023 22:27:54 +0000
Subject: [PATCH 1/2] Listen on an AF_UNIX abstract address if supported.
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Steve Dickson <steved@redhat.com>
Date:   Thu, 11 May 2023 08:27:36 +1000
Message-ID: <168375765675.30997.5190278705102773872.stgit@noble.brown>
In-Reply-To: <168375751051.30997.11634044913854205425.stgit@noble.brown>
References: <168375751051.30997.11634044913854205425.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

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
 configure.ac              |   13 ++++++++++++-
 systemd/rpcbind.socket    |   18 ------------------
 systemd/rpcbind.socket.in |   19 +++++++++++++++++++
 3 files changed, 31 insertions(+), 19 deletions(-)
 delete mode 100644 systemd/rpcbind.socket
 create mode 100644 systemd/rpcbind.socket.in

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
diff --git a/systemd/rpcbind.socket b/systemd/rpcbind.socket
deleted file mode 100644
index 3b1a93694c21..000000000000
--- a/systemd/rpcbind.socket
+++ /dev/null
@@ -1,18 +0,0 @@
-[Unit]
-Description=RPCbind Server Activation Socket
-DefaultDependencies=no
-Wants=rpcbind.target
-Before=rpcbind.target
-
-[Socket]
-ListenStream=/run/rpcbind.sock
-
-# RPC netconfig can't handle ipv6/ipv4 dual sockets
-BindIPv6Only=ipv6-only
-ListenStream=0.0.0.0:111
-ListenDatagram=0.0.0.0:111
-ListenStream=[::]:111
-ListenDatagram=[::]:111
-
-[Install]
-WantedBy=sockets.target
diff --git a/systemd/rpcbind.socket.in b/systemd/rpcbind.socket.in
new file mode 100644
index 000000000000..5dd09a143e16
--- /dev/null
+++ b/systemd/rpcbind.socket.in
@@ -0,0 +1,19 @@
+[Unit]
+Description=RPCbind Server Activation Socket
+DefaultDependencies=no
+Wants=rpcbind.target
+Before=rpcbind.target
+
+[Socket]
+ListenStream=/run/rpcbind.sock
+@ABSTRACT_TRUE@ListenStream=@/run/rpcbind.sock
+
+# RPC netconfig can't handle ipv6/ipv4 dual sockets
+BindIPv6Only=ipv6-only
+ListenStream=0.0.0.0:111
+ListenDatagram=0.0.0.0:111
+ListenStream=[::]:111
+ListenDatagram=[::]:111
+
+[Install]
+WantedBy=sockets.target


