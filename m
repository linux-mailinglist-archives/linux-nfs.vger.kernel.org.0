Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3B333C6F1
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Mar 2021 20:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhCOTjF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Mar 2021 15:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232227AbhCOTiq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Mar 2021 15:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615837125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KkREsSmx9uhi5xrLC8f+QiXFk62mdoHd61YjXxSbk+o=;
        b=a9OIz5/Ojnw1xleg9xLboExc9etsNM1P6JxhXtSnWSntFlIqwLWgOiWHShTKc//0OMkQNt
        x8iZJIAKkd6dryVNYOa0gFDRAWa2tbf7m5fu25qCj+dcziPAVw4D99d/H//Jbtk7J5uCZr
        CdvkivAfWf2piC83tSr1fGVseZVctUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-ASUCyeKHMQGIONw34Eux8A-1; Mon, 15 Mar 2021 15:38:43 -0400
X-MC-Unique: ASUCyeKHMQGIONw34Eux8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CDE7100C661
        for <linux-nfs@vger.kernel.org>; Mon, 15 Mar 2021 19:38:42 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-124.phx2.redhat.com [10.3.113.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 314F35D762;
        Mon, 15 Mar 2021 19:38:42 +0000 (UTC)
Subject: Re: [PATCH 1/1] gssd: Add options to rpc.gssd to allow for the use of
 $HOME/.k5identity files
To:     Jacob Shivers <jshivers@redhat.com>
Cc:     linux-nfs@vger.kernel.org
References: <20210301214622.829462-1-jshivers@redhat.com>
 <20210301214622.829462-2-jshivers@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <3f02582a-c3f7-cc95-78bd-1728b49e6fd2@RedHat.com>
Date:   Mon, 15 Mar 2021 15:40:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210301214622.829462-2-jshivers@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/1/21 4:46 PM, Jacob Shivers wrote:
> Since commit 2f682f25c642fcfe7c511d04bc9d67e732282348 $HOME has been set to '/'
> to avoid a deadlock when accessing Kerberized NFS shares. While this works for
> most use cases, users who depend on the use of $HOME/.k5identity files are
> negatively impacted by this commit. This patch allows for users to use their
> $HOME/.k5identity to access subsequent Kerberized resources based on the
> credentials in said file.
> 
> The default set by commit 2f682f25c642fcfe7c511d04bc9d67e732282348 still remains
> the same, but a user can pass '-H' to change rpc.gssd behavior to not set $HOME
> to '/'. Setting 'set-home=0' in /etc/nfs.conf has the same effect as passing
> '-H' directly to rpc.gssd.
> 
> Signed-off-by: Jacob Shivers <jshivers@redhat.com>
Committed... (tag: nfs-utils-2-5-4-rc1)

steved.

> ---
>  nfs.conf             |  1 +
>  systemd/nfs.conf.man |  3 ++-
>  utils/gssd/gssd.c    | 28 ++++++++++++++++++++--------
>  utils/gssd/gssd.man  | 19 ++++++++++++++++++-
>  4 files changed, 41 insertions(+), 10 deletions(-)
> 
> diff --git a/nfs.conf b/nfs.conf
> index bebb2e3d1e68..eabe8c7c34c4 100644
> --- a/nfs.conf
> +++ b/nfs.conf
> @@ -24,6 +24,7 @@
>  # keytab-file=/etc/krb5.keytab
>  # cred-cache-directory=
>  # preferred-realm=
> +# set-home=1
>  #
>  [lockd]
>  # port=0
> diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
> index d2187f8aca1a..7fa35d441eca 100644
> --- a/systemd/nfs.conf.man
> +++ b/systemd/nfs.conf.man
> @@ -253,7 +253,8 @@ Recognized values:
>  .BR rpc-timeout ,
>  .BR keytab-file ,
>  .BR cred-cache-directory ,
> -.BR preferred-realm .
> +.BR preferred-realm ,
> +.BR set-home .
>  
>  See
>  .BR rpc.gssd (8)
> diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
> index 85bc4b07bebd..1541d3710b24 100644
> --- a/utils/gssd/gssd.c
> +++ b/utils/gssd/gssd.c
> @@ -87,6 +87,8 @@ unsigned int  context_timeout = 0;
>  unsigned int  rpc_timeout = 5;
>  char *preferred_realm = NULL;
>  char *ccachedir = NULL;
> +/* set $HOME to "/" by default */
> +static bool set_home = true;
>  /* Avoid DNS reverse lookups on server names */
>  static bool avoid_dns = true;
>  static bool use_gssproxy = false;
> @@ -900,7 +902,7 @@ sig_die(int signal)
>  static void
>  usage(char *progname)
>  {
> -	fprintf(stderr, "usage: %s [-f] [-l] [-M] [-n] [-v] [-r] [-p pipefsdir] [-k keytab] [-d ccachedir] [-t timeout] [-R preferred realm] [-D]\n",
> +	fprintf(stderr, "usage: %s [-f] [-l] [-M] [-n] [-v] [-r] [-p pipefsdir] [-k keytab] [-d ccachedir] [-t timeout] [-R preferred realm] [-D] [-H]\n",
>  		progname);
>  	exit(1);
>  }
> @@ -941,6 +943,7 @@ read_gss_conf(void)
>  		preferred_realm = s;
>  
>  	use_gssproxy = conf_get_bool("gssd", "use-gss-proxy", use_gssproxy);
> +	set_home = conf_get_bool("gssd", "set-home", set_home);
>  }
>  
>  int
> @@ -961,7 +964,7 @@ main(int argc, char *argv[])
>  	verbosity = conf_get_num("gssd", "verbosity", verbosity);
>  	rpc_verbosity = conf_get_num("gssd", "rpc-verbosity", rpc_verbosity);
>  
> -	while ((opt = getopt(argc, argv, "DfvrlmnMp:k:d:t:T:R:")) != -1) {
> +	while ((opt = getopt(argc, argv, "HDfvrlmnMp:k:d:t:T:R:")) != -1) {
>  		switch (opt) {
>  			case 'f':
>  				fg = 1;
> @@ -1009,6 +1012,9 @@ main(int argc, char *argv[])
>  			case 'D':
>  				avoid_dns = false;
>  				break;
> +			case 'H':
> +				set_home = false;
> +				break;
>  			default:
>  				usage(argv[0]);
>  				break;
> @@ -1018,13 +1024,19 @@ main(int argc, char *argv[])
>  	/*
>  	 * Some krb5 routines try to scrape info out of files in the user's
>  	 * home directory. This can easily deadlock when that homedir is on a
> -	 * kerberized NFS mount. By setting $HOME unconditionally to "/", we
> -	 * prevent this behavior in routines that use $HOME in preference to
> -	 * the results of getpw*.
> +	 * kerberized NFS mount. By setting $HOME to "/" by default, we prevent
> +	 * this behavior in routines that use $HOME in preference to the results
> +	 * of getpw*.
> +	 *
> +	 * Some users do not use Kerberized home dirs and need $HOME to remain
> +	 * unchanged. Those users can leave $HOME unchanged by setting set_home
> +	 * to false.
>  	 */
> -	if (setenv("HOME", "/", 1)) {
> -		printerr(0, "gssd: Unable to set $HOME: %s\n", strerror(errno));
> -		exit(1);
> +	if (set_home) {
> +		if (setenv("HOME", "/", 1)) {
> +			printerr(0, "gssd: Unable to set $HOME: %s\n", strerror(errno));
> +			exit(1);
> +		}
>  	}
>  
>  	if (use_gssproxy) {
> diff --git a/utils/gssd/gssd.man b/utils/gssd/gssd.man
> index 26095a898293..c93cde6a66e5 100644
> --- a/utils/gssd/gssd.man
> +++ b/utils/gssd/gssd.man
> @@ -8,7 +8,7 @@
>  rpc.gssd \- RPCSEC_GSS daemon
>  .SH SYNOPSIS
>  .B rpc.gssd
> -.RB [ \-DfMnlvr ]
> +.RB [ \-DfMnlvrH ]
>  .RB [ \-k
>  .IR keytab ]
>  .RB [ \-p
> @@ -282,6 +282,16 @@ The default timeout is set to 5 seconds.
>  If you get messages like "WARNING: can't create tcp rpc_clnt to server
>  %servername% for user with uid %uid%: RPC: Remote system error -
>  Connection timed out", you should consider an increase of this timeout.
> +.TP
> +.B -H
> +Avoids setting $HOME to "/". This allows rpc.gssd to read per user k5identity
> +files versus trying to read /.k5identity for each user.
> +
> +If
> +.B \-H
> +is not set, rpc.gssd will use the first match found in
> +/var/kerberos/krb5/user/$EUID/client.keytab and will not use a principal based on
> +host and/or service parameters listed in $HOME/.k5identity.
>  .SH CONFIGURATION FILE
>  Many of the options that can be set on the command line can also be
>  controlled through values set in the
> @@ -347,6 +357,13 @@ section:
>  .B pipefs-directory
>  Equivalent to
>  .BR -p .
> +.TP
> +.B set-home
> +Setting to
> +.B false
> +is equivalent to providing the
> +.B -H
> +flag.
>  
>  .SH SEE ALSO
>  .BR rpc.svcgssd (8),
> 

