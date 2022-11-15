Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7E9629136
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Nov 2022 05:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiKOEis (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Nov 2022 23:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiKOEiq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Nov 2022 23:38:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655525F58
        for <linux-nfs@vger.kernel.org>; Mon, 14 Nov 2022 20:38:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 26D271F88D;
        Tue, 15 Nov 2022 04:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668487123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSP61+4QmvcgVcgoDitJP2jdEQMw/aTjI653PT2HIZk=;
        b=1J4f76+DwI0y6HmR1Zc7Wq7zJyYEvjYLHiy5gx+qQboFJBGMl10GY2jtTmF/8XdFyC2uic
        KwzUpGpVVMzF83Qm7fDgPF5e4iDJ04ve50aQkBeRHgCe6Kbq3h/vSjuqmBXb+0Ei5XFgGs
        wJhP5T2L/zFY1ypfHJOz3vCL5Md5Y+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668487123;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSP61+4QmvcgVcgoDitJP2jdEQMw/aTjI653PT2HIZk=;
        b=af2JsK6vdWCCPCo84BgZgoPJoHIqADAbBECYRLKPRruXFk3mbcRZaqDI3wuqY+KNVET83T
        UxuaTT2BoFT/OpBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BD7313273;
        Tue, 15 Nov 2022 04:38:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jpaoONEXc2O/ZQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 15 Nov 2022 04:38:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Steve Dickson" <steved@redhat.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH nfs-utils] nfsd: allow server scope to be set with config
 or command line.
In-reply-to: <166813011417.19313.12216066495338584736@noble.neil.brown.name>
References: <166813011417.19313.12216066495338584736@noble.neil.brown.name>
Date:   Tue, 15 Nov 2022 15:38:35 +1100
Message-id: <166848711530.4614.10805714091203567578@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 11 Nov 2022, NeilBrown wrote:
> NFSv4.1 and later require the server to report a "scope".  Servers with
> the same scope are expected to understand each other's state ids etc,
> though may not accept them - this ensure there can be no
> misunderstanding.  This is helpful for migration.
>=20
> Servers with different scope are known to be different and if a server
> appears to change scope on a restart, lock recovery must not be
> attempted.
>=20
> It is important for fail-over configurations to have the same scope for
> all server instances.  Linux NFSD sets scope to host name.  It is common
> for fail-over configurations to use different host names on different
> server nodes.  So the default is not good for these configurations and
> must be over-ridden.
>=20
> As discussed in
>   https://github.com/ClusterLabs/resource-agents/issues/1644
> some HA management tools attempt to address this with calls to "unshare"
> and "hostname" before running "rpc.nfsd".  This is unnecessarily
> cumbersome.
>=20
> This patch adds a "-S" command-line option and nfsd.scope config value
> so that the scope can be set easily for nfsd.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  systemd/nfs.conf.man |  1 +
>  utils/nfsd/nfsd.c    | 19 ++++++++++++++++++-
>  utils/nfsd/nfsd.man  | 13 ++++++++++++-
>  3 files changed, 31 insertions(+), 2 deletions(-)
>=20
> diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
> index b95c05a68759..bfd3380ff081 100644
> --- a/systemd/nfs.conf.man
> +++ b/systemd/nfs.conf.man
> @@ -172,6 +172,7 @@ for details.
>  Recognized values:
>  .BR threads ,
>  .BR host ,
> +.BR scope ,
>  .BR port ,
>  .BR grace-time ,
>  .BR lease-time ,
> diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
> index 4016a761293b..169e02a84f7b 100644
> --- a/utils/nfsd/nfsd.c
> +++ b/utils/nfsd/nfsd.c
> @@ -23,6 +23,7 @@
>  #include <sys/socket.h>
>  #include <netinet/in.h>
>  #include <arpa/inet.h>
> +#include <sched.h>
> =20
>  #include "conffile.h"
>  #include "nfslib.h"
> @@ -39,6 +40,7 @@ static void	usage(const char *);
>  static struct option longopts[] =3D
>  {
>  	{ "host", 1, 0, 'H' },
> +	{ "scope", 1, 0, 'S'},
>  	{ "help", 0, 0, 'h' },
>  	{ "no-nfs-version", 1, 0, 'N' },
>  	{ "nfs-version", 1, 0, 'V' },
> @@ -69,6 +71,7 @@ main(int argc, char **argv)
>  	int	count =3D NFSD_NPROC, c, i, error =3D 0, portnum, fd, found_one;
>  	char *p, *progname, *port, *rdma_port =3D NULL;
>  	char **haddr =3D NULL;
> +	char *scope =3D NULL;
>  	int hcounter =3D 0;
>  	struct conf_list *hosts;
>  	int	socket_up =3D 0;
> @@ -168,8 +171,9 @@ main(int argc, char **argv)
>  			hcounter++;
>  		}
>  	}
> +	scope =3D conf_get_str("nfsd", "scope");
> =20
> -	while ((c =3D getopt_long(argc, argv, "dH:hN:V:p:P:stTuUrG:L:", longopts,=
 NULL)) !=3D EOF) {
> +	while ((c =3D getopt_long(argc, argv, "dH:S:hN:V:p:P:stTuUrG:L:", longopt=
s, NULL)) !=3D EOF) {
>  		switch(c) {
>  		case 'd':
>  			xlog_config(D_ALL, 1);
> @@ -190,6 +194,9 @@ main(int argc, char **argv)
>  			haddr[hcounter] =3D optarg;
>  			hcounter++;
>  			break;
> +		case 'S':
> +			scope =3D optarg;
> +			break;
>  		case 'P':	/* XXX for nfs-server compatibility */
>  		case 'p':
>  			/* only the last -p option has any effect */
> @@ -367,6 +374,16 @@ main(int argc, char **argv)
>  	if (lease  > 0)
>  		nfssvc_set_time("lease", lease);
> =20
> +	if (!scope && hcounter =3D=3D 1)
> +		scope =3D haddr[0];

Sorry, I didn't mean to leave the bit in.  I had originally thought that
if -S wasn't given but -H was, then the first named given to -H would be
used as the scope.  But I subsequently realised that could cause a
regression of anyone who explictly sets a hostname (in a namespace) but
gives something else to -H (e.g.  an IP address).  So I removed it...
or meant to.  I will resend.

NeilBrown


> +	if (scope) {
> +		if (unshare(CLONE_NEWUTS) < 0 ||
> +		    sethostname(scope, strlen(scope)) < 0) {
> +			xlog(L_ERROR, "Unable to set server scope: %m");
> +			error =3D -1;
> +			goto out;
> +		}
> +	}
>  	i =3D 0;
>  	do {
>  		error =3D nfssvc_set_sockets(protobits, haddr[i], port);
> diff --git a/utils/nfsd/nfsd.man b/utils/nfsd/nfsd.man
> index bb99fe2b1d89..dc05f3623465 100644
> --- a/utils/nfsd/nfsd.man
> +++ b/utils/nfsd/nfsd.man
> @@ -35,9 +35,17 @@ Note that
>  .B lockd
>  (which performs file locking services for NFS) may still accept
>  request on all known network addresses.  This may change in future
> -releases of the Linux Kernel. This option can be used multiple time=20
> +releases of the Linux Kernel. This option can be used multiple times
>  to listen to more than one interface.
>  .TP
> +.B \S " or " \-\-scope scope
> +NFSv4.1 and later require the server to report a "scope" which is used
> +by the clients to detect if two connections are to the same server.
> +By default Linux NFSD uses the host name as the scope.
> +.sp
> +It is particularly important for high-availablity configurations to ensure
> +that all potential server nodes report the same server scope.
> +.TP
>  .B \-p " or " \-\-port  port
>  specify a different port to listen on for NFS requests. By default,
>  .B rpc.nfsd
> @@ -134,6 +142,9 @@ will listen on.  Use of the
>  .B --host
>  option replaces all host names listed here.
>  .TP
> +.B scope
> +Set the server scope.
> +.TP
>  .B grace-time
>  The grace time, for both NFSv4 and NLM, in seconds.
>  .TP
> --=20
> 2.38.1
>=20
>=20
