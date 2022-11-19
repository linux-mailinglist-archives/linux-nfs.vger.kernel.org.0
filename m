Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F90D631072
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Nov 2022 20:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKST3u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Nov 2022 14:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiKST3t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Nov 2022 14:29:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329E013D21
        for <linux-nfs@vger.kernel.org>; Sat, 19 Nov 2022 11:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668886133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z8K+fa2iUWSFC/JPWZXb3P5J46FJ4fMqLku1ynZvDqU=;
        b=LyuBy3dS2cUtOwDWxHPaqUjuX8ZFLPCY0PxxfT8+zWwQ5b/j2jjZwOgJaSerUTjDUjOV00
        EAtB1PjCNMJvEeIz8Tqwtk7Q+JG2ls1ok456j/TQhRsQStADKNYQg7Xuvf3xTO74Td71Ms
        Hxwg5cp/hfp4YguTmUkAq4ItFx0ejDw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-381-YElXQXeKMDSVPRr3XkSElA-1; Sat, 19 Nov 2022 14:28:50 -0500
X-MC-Unique: YElXQXeKMDSVPRr3XkSElA-1
Received: by mail-qv1-f69.google.com with SMTP id nn2-20020a056214358200b004bb7bc3dfdcso7911008qvb.23
        for <linux-nfs@vger.kernel.org>; Sat, 19 Nov 2022 11:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8K+fa2iUWSFC/JPWZXb3P5J46FJ4fMqLku1ynZvDqU=;
        b=0kMU+aqTs/w+P5+z8eUEvhu/Q3EEnawHevxQ2pwwvyrgPafQw1UELp0tztHaOQ3yux
         wjEJzoPGj9e50vOHQcbpUfjZj53gGD6iOx0gJQ4Bfqq8rrx6cL74JMBnto5mgUHN1hHo
         LXNiy++/3O50MIhRnc7SLcAW3ARjS3tC6uHBlVMqts4ZApsOXit5h0tUFWArpzn4O/hJ
         Q3ACUQdgT17y70UVhMGfBASbssp092Z8UOeEgFijBwgeGEyMdCHGOp+C5ftiNTcEDVcO
         YAHaPGrd9OQ3vuW0dzbw+GlSP8YcZ0bJ1+OC/GnRtqh/anx9CirjX4EH+3SgK7BCy2Og
         ltFA==
X-Gm-Message-State: ANoB5pm3t13JT6MWVMaDEt2673EsDGrUCBwKxdT4rBwymL8PnD6NAYXr
        ZJUAiZZeoOWSw68+5m1kuqQOrZzu9TNis7UaOD96BemTuV1aZgfFvtmuPWDWJxmLJOYGgqS75sg
        aXsmovYE8xBa7xKk2hzJ6
X-Received: by 2002:ac8:5299:0:b0:3a5:3623:17b2 with SMTP id s25-20020ac85299000000b003a5362317b2mr11806623qtn.543.1668886129526;
        Sat, 19 Nov 2022 11:28:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6zhkZsFKp21FCHbk9zUfJYHseH+/TUEUZiVVUtQP54igd8GXlKca239QsykBFSIlzBIl07EQ==
X-Received: by 2002:ac8:5299:0:b0:3a5:3623:17b2 with SMTP id s25-20020ac85299000000b003a5362317b2mr11806613qtn.543.1668886129207;
        Sat, 19 Nov 2022 11:28:49 -0800 (PST)
Received: from [172.31.1.6] ([70.105.255.216])
        by smtp.gmail.com with ESMTPSA id x1-20020a05620a448100b006cec8001bf4sm5227369qkp.26.2022.11.19.11.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Nov 2022 11:28:48 -0800 (PST)
Message-ID: <78d9e894-7c30-fa5a-58ee-b99b161e475e@redhat.com>
Date:   Sat, 19 Nov 2022 14:28:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH nfs-utils - v2] nfsd: allow server scope to be set with
 config or command line.
To:     NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <166813011417.19313.12216066495338584736@noble.neil.brown.name>
 <166848711530.4614.10805714091203567578@noble.neil.brown.name>
 <166848720192.4614.15106591314080263893@noble.neil.brown.name>
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <166848720192.4614.15106591314080263893@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

On 11/14/22 11:40 PM, NeilBrown wrote:
> 
> NFSv4.1 and later require the server to report a "scope".  Servers with
> the same scope are expected to understand each other's state ids etc,
> though may not accept them - this ensure there can be no
> misunderstanding.  This is helpful for migration.
> 
> Servers with different scope are known to be different and if a server
> appears to change scope on a restart, lock recovery must not be
> attempted.
> 
> It is important for fail-over configurations to have the same scope for
> all server instances.  Linux NFSD sets scope to host name.  It is common
> for fail-over configurations to use different host names on different
> server nodes.  So the default is not good for these configurations and
> must be over-ridden.
> 
> As discussed in
>    https://github.com/ClusterLabs/resource-agents/issues/1644
> some HA management tools attempt to address this with calls to "unshare"
> and "hostname" before running "rpc.nfsd".  This is unnecessarily
> cumbersome.
> 
> This patch adds a "-S" command-line option and nfsd.scope config value
> so that the scope can be set easily for nfsd.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>   systemd/nfs.conf.man |  1 +
>   utils/nfsd/nfsd.c    | 17 ++++++++++++++++-
>   utils/nfsd/nfsd.man  | 13 ++++++++++++-
>   3 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
> index b95c05a68759..bfd3380ff081 100644
> --- a/systemd/nfs.conf.man
> +++ b/systemd/nfs.conf.man
> @@ -172,6 +172,7 @@ for details.
>   Recognized values:
>   .BR threads ,
>   .BR host ,
> +.BR scope ,
>   .BR port ,
>   .BR grace-time ,
>   .BR lease-time ,
> diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
> index 4016a761293b..249df00b448d 100644
> --- a/utils/nfsd/nfsd.c
> +++ b/utils/nfsd/nfsd.c
> @@ -23,6 +23,7 @@
>   #include <sys/socket.h>
>   #include <netinet/in.h>
>   #include <arpa/inet.h>
> +#include <sched.h>
>   
>   #include "conffile.h"
>   #include "nfslib.h"
> @@ -39,6 +40,7 @@ static void	usage(const char *);
>   static struct option longopts[] =
>   {
>   	{ "host", 1, 0, 'H' },
> +	{ "scope", 1, 0, 'S'},
>   	{ "help", 0, 0, 'h' },
>   	{ "no-nfs-version", 1, 0, 'N' },
>   	{ "nfs-version", 1, 0, 'V' },
> @@ -69,6 +71,7 @@ main(int argc, char **argv)
>   	int	count = NFSD_NPROC, c, i, error = 0, portnum, fd, found_one;
>   	char *p, *progname, *port, *rdma_port = NULL;
>   	char **haddr = NULL;
> +	char *scope = NULL;
>   	int hcounter = 0;
>   	struct conf_list *hosts;
>   	int	socket_up = 0;
> @@ -168,8 +171,9 @@ main(int argc, char **argv)
>   			hcounter++;
>   		}
>   	}
> +	scope = conf_get_str("nfsd", "scope");
>   
> -	while ((c = getopt_long(argc, argv, "dH:hN:V:p:P:stTuUrG:L:", longopts, NULL)) != EOF) {
> +	while ((c = getopt_long(argc, argv, "dH:S:hN:V:p:P:stTuUrG:L:", longopts, NULL)) != EOF) {
>   		switch(c) {
>   		case 'd':
>   			xlog_config(D_ALL, 1);
> @@ -190,6 +194,9 @@ main(int argc, char **argv)
>   			haddr[hcounter] = optarg;
>   			hcounter++;
>   			break;
> +		case 'S':
> +			scope = optarg;
> +			break;
>   		case 'P':	/* XXX for nfs-server compatibility */
>   		case 'p':
>   			/* only the last -p option has any effect */
> @@ -367,6 +374,14 @@ main(int argc, char **argv)
>   	if (lease  > 0)
>   		nfssvc_set_time("lease", lease);
>   
> +	if (scope) {
> +		if (unshare(soc) < 0 ||
> +		    sethostname(scope, strlen(scope)) < 0) {
> +			xlog(L_ERROR, "Unable to set server scope: %m");
> +			error = -1;
> +			goto out;
> +		}
> +	}
So setting the scope resets the utsname and hostname which
will effect the entire system, possibly negatively. Breaking
DNS... who knows what is going to happen, when the hostname
is changed on the fly.. But with that said..

I understand what you are trying to doing, but I just
don't think it's documented well enough... Saying something
like setting the scope *will* change both utsname and hostname
to given scope or something like... I just want be more explicit
as to what setting the scope is actually going to do.

steved.

>   	i = 0;
>   	do {
>   		error = nfssvc_set_sockets(protobits, haddr[i], port);
> diff --git a/utils/nfsd/nfsd.man b/utils/nfsd/nfsd.man
> index bb99fe2b1d89..dc05f3623465 100644
> --- a/utils/nfsd/nfsd.man
> +++ b/utils/nfsd/nfsd.man
> @@ -35,9 +35,17 @@ Note that
>   .B lockd
>   (which performs file locking services for NFS) may still accept
>   request on all known network addresses.  This may change in future
> -releases of the Linux Kernel. This option can be used multiple time
> +releases of the Linux Kernel. This option can be used multiple times
>   to listen to more than one interface.
>   .TP
> +.B \S " or " \-\-scope scope
> +NFSv4.1 and later require the server to report a "scope" which is used
> +by the clients to detect if two connections are to the same server.
> +By default Linux NFSD uses the host name as the scope.
> +.sp
> +It is particularly important for high-availablity configurations to ensure
> +that all potential server nodes report the same server scope.
> +.TP
>   .B \-p " or " \-\-port  port
>   specify a different port to listen on for NFS requests. By default,
>   .B rpc.nfsd
> @@ -134,6 +142,9 @@ will listen on.  Use of the
>   .B --host
>   option replaces all host names listed here.
>   .TP
> +.B scope
> +Set the server scope.
> +.TP
>   .B grace-time
>   The grace time, for both NFSv4 and NLM, in seconds.
>   .TP

