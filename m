Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9E632DBC4
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 22:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbhCDV2q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 16:28:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231149AbhCDV2R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Mar 2021 16:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614893211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSQ7O9t+QZAlwIPSVvUf1Ak7t7zJMDKICUH7n5SR8C4=;
        b=BTTUqVhv5Q1pmnGMFZcGLabBUndXWpsFa0NgkEwTot5olVL3pCQvSmq89+sLkmjNG+EPVa
        jTf+PHwAmNMyVI9dgGc2xfXu850CLC40jtDD9ucMAa4zp3uwvmPGNjPUQ0xFCX4IIwdeZx
        SExMJ4WXbhkYle8+rxeLjsdDwzbpEJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515--UpVvj6xN_ufMW3DLrtKIQ-1; Thu, 04 Mar 2021 16:26:50 -0500
X-MC-Unique: -UpVvj6xN_ufMW3DLrtKIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFA0E1084D69;
        Thu,  4 Mar 2021 21:26:48 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-114-51.phx2.redhat.com [10.3.114.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 532CF60C0F;
        Thu,  4 Mar 2021 21:26:48 +0000 (UTC)
Subject: Re: [PATCH] exportd: server-side gid management
To:     Daniel Kobras <kobras@puzzle-itc.de>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210219200815.792667-1-steved@redhat.com>
 <20210219200815.792667-3-steved@redhat.com>
 <20210223161351.zzz62kuxn5bdfkqf@tuedko18.puzzle-itc.de>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <5bf15701-bb19-8bba-79ad-924c7ad20f5b@RedHat.com>
Date:   Thu, 4 Mar 2021 16:28:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210223161351.zzz62kuxn5bdfkqf@tuedko18.puzzle-itc.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/23/21 11:13 AM, Daniel Kobras wrote:
> Ported manage-gids option from mountd
> 
> Signed-off-by: Daniel Kobras <kobras@puzzle-itc.de>
Committed... Thanks!

steved.
> ---
> Hi Steve!
> 
> Option --manage-gids should still be useful with NFSv4 and AUTH_SYS, but 
> commit 15dc0bead10d20c31e72ca94ce21eb66dc3528d5 does not allow to actually
> control the global variable manage_gids from exportd. I assume something
> like the following was intended?
> 
> Kind regards,
> 
> Daniel
> 
>  nfs.conf                  |  1 +
>  utils/exportd/exportd.c   |  8 +++++++-
>  utils/exportd/exportd.man | 16 ++++++++++++++++
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/nfs.conf b/nfs.conf
> index bebb2e3d..e69ec16d 100644
> --- a/nfs.conf
> +++ b/nfs.conf
> @@ -31,6 +31,7 @@
>  #
>  [exportd]
>  # debug="all|auth|call|general|parse"
> +# manage-gids=n
>  # state-directory-path=/var/lib/nfs
>  # threads=1
>  [mountd]
> diff --git a/utils/exportd/exportd.c b/utils/exportd/exportd.c
> index 7130bcbf..0d7782be 100644
> --- a/utils/exportd/exportd.c
> +++ b/utils/exportd/exportd.c
> @@ -42,6 +42,7 @@ static struct option longopts[] =
>  	{ "foreground", 0, 0, 'F' },
>  	{ "debug", 1, 0, 'd' },
>  	{ "help", 0, 0, 'h' },
> +	{ "manage-gids", 0, 0, 'g' },
>  	{ "num-threads", 1, 0, 't' },
>  	{ NULL, 0, 0, 0 }
>  };
> @@ -174,6 +175,7 @@ usage(const char *prog, int n)
>  {
>  	fprintf(stderr,
>  		"Usage: %s [-f|--foreground] [-h|--help] [-d kind|--debug kind]\n"
> +"	[-g|--manage-gids]\n"
>  "	[-s|--state-directory-path path]\n"
>  "	[-t num|--num-threads=num]\n", prog);
>  	exit(n);
> @@ -188,6 +190,7 @@ read_exportd_conf(char *progname, char **argv)
>  
>  	xlog_set_debug(progname);
>  
> +	manage_gids = conf_get_bool("exportd", "manage-gids", manage_gids);
>  	num_threads = conf_get_num("exportd", "threads", num_threads);
>  
>  	s = conf_get_str("exportd", "state-directory-path");
> @@ -214,7 +217,7 @@ main(int argc, char **argv)
>  	/* Read in config setting */
>  	read_exportd_conf(progname, argv);
>  
> -	while ((c = getopt_long(argc, argv, "d:fhs:t:", longopts, NULL)) != EOF) {
> +	while ((c = getopt_long(argc, argv, "d:fghs:t:", longopts, NULL)) != EOF) {
>  		switch (c) {
>  		case 'd':
>  			xlog_sconfig(optarg, 1);
> @@ -222,6 +225,9 @@ main(int argc, char **argv)
>  		case 'f':
>  			foreground++;
>  			break;
> +		case 'g':
> +			manage_gids = 1;
> +			break;
>  		case 'h':
>  			usage(progname, 0);
>  			break;
> diff --git a/utils/exportd/exportd.man b/utils/exportd/exportd.man
> index 1d65b5e0..d7884562 100644
> --- a/utils/exportd/exportd.man
> +++ b/utils/exportd/exportd.man
> @@ -51,6 +51,21 @@ spawns.  The default is 1 thread, which is probably enough.  More
>  threads are usually only needed for NFS servers which need to handle
>  mount storms of hundreds of NFS mounts in a few seconds, or when
>  your DNS server is slow or unreliable.
> +.TP
> +.BR \-g " or " \-\-manage-gids
> +Accept requests from the kernel to map user id numbers into lists of
> +group id numbers for use in access control.  An NFS request will
> +normally (except when using Kerberos or other cryptographic
> +authentication) contain a user-id and a list of group-ids.  Due to a
> +limitation in the NFS protocol, at most 16 groups ids can be listed.
> +If you use the
> +.B \-g
> +flag, then the list of group ids received from the client will be
> +replaced by a list of group ids determined by an appropriate lookup on
> +the server. Note that the 'primary' group id is not affected so a
> +.B newgroup
> +command on the client will still be effective.  This function requires
> +a Linux Kernel with version at least 2.6.21.
>  .SH CONFIGURATION FILE
>  Many of the options that can be set on the command line can also be
>  controlled through values set in the
> @@ -63,6 +78,7 @@ configuration file.
>  Values recognized in the
>  .B [exportd]
>  section include 
> +.BR manage-gids ", and"
>  .B debug 
>  which each have the same effect as the option with the same name.
>  .SH FILES
> 

