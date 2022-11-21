Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ADB632D7F
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Nov 2022 20:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiKUT5L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Nov 2022 14:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiKUT5K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Nov 2022 14:57:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF44764E1
        for <linux-nfs@vger.kernel.org>; Mon, 21 Nov 2022 11:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669060574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HVSJqXnfxuToEm7bBTHXtldh47YHTtebqoaQPeI9p2E=;
        b=CKLfw3fw0S1SodwgGCixSjakFle/f5N+gfzKIWL6/XV9v/TmSxftlAgliGnTBtoxTMh80q
        VAByLYjdRN00N5K+ANFKkOnoYE2NhyI/IX0UEBhXCGBpLviZ0EZ8MqCeQhR+GObeK2DFvY
        0yUpprt3qOS+MvNPGSD7BoCuCfEFinE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-657-ldjs7G-TNle00-uAIzvQzQ-1; Mon, 21 Nov 2022 14:56:13 -0500
X-MC-Unique: ldjs7G-TNle00-uAIzvQzQ-1
Received: by mail-qk1-f200.google.com with SMTP id bq13-20020a05620a468d00b006fa5a75759aso16803629qkb.13
        for <linux-nfs@vger.kernel.org>; Mon, 21 Nov 2022 11:56:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVSJqXnfxuToEm7bBTHXtldh47YHTtebqoaQPeI9p2E=;
        b=hmHhgoQtcDGEOR5z9+VWCPGA41dvfx36oa8sBGN56wbPlvmzxQTxGNVgkC2cVDZcP4
         2EFgXr4RaW8uCYbLfP24cFRxFOxp80atkIn0BZFap3oOM7JArpeCD3QJOy1s79eSk4Pt
         WS/bYTZm5GWBTGsTVBKD1bxSpt0+kcMyoKxHVa51z+8v31qPL47O/Vj+rY2iEjewvVwy
         GN3Gliulyu1JIhLfB4um7X5M9w8+ig0VAQrkomrjBZzmSyoxtH1rVE5+kWognYMGHZdL
         IddTvAgZ091Wx3OEUsiNSkhF86ttURE//0AxKXa8FmmjnNhc3+P0hVKn8XlmTGuClCKt
         3Wkw==
X-Gm-Message-State: ANoB5pkGRVP4iNoDmp8/G2ZaHo0kGwoXmt5Gt1Oeu4h1ZROnv3OD8PKs
        B7TxNtasuYdWFm7Z6vKhnCxmvPsfFgW47uYG4eoOIAB2Bj6sc13mRv21PcBj3gG0YDuffWQEFUo
        YUKHP6ePVe8T0nSZVjTHW
X-Received: by 2002:a05:620a:1310:b0:6f9:ffc6:45d1 with SMTP id o16-20020a05620a131000b006f9ffc645d1mr9270691qkj.663.1669060572603;
        Mon, 21 Nov 2022 11:56:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf51ga9O21vlLSDAdaF56sJwjOi/EF3wXU5Gggs8EZSitD4GT4VxqrzRRHrgsaHTVYLtdr2tlA==
X-Received: by 2002:a05:620a:1310:b0:6f9:ffc6:45d1 with SMTP id o16-20020a05620a131000b006f9ffc645d1mr9270670qkj.663.1669060572297;
        Mon, 21 Nov 2022 11:56:12 -0800 (PST)
Received: from [172.31.1.6] ([70.105.255.216])
        by smtp.gmail.com with ESMTPSA id bs10-20020ac86f0a000000b003992448029esm7085207qtb.19.2022.11.21.11.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 11:56:10 -0800 (PST)
Message-ID: <ca426a84-cade-8af8-41c0-c0f5d5c64f4a@redhat.com>
Date:   Mon, 21 Nov 2022 14:56:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH nfs-utils - v2] nfsd: allow server scope to be set with
 config or command line.
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <166813011417.19313.12216066495338584736@noble.neil.brown.name>
 <166848711530.4614.10805714091203567578@noble.neil.brown.name>
 <166848720192.4614.15106591314080263893@noble.neil.brown.name>
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
Committed... (tag: nfs-utils-2-6-3-rc4)

steved.
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
> +		if (unshare(CLONE_NEWUTS) < 0 ||
> +		    sethostname(scope, strlen(scope)) < 0) {
> +			xlog(L_ERROR, "Unable to set server scope: %m");
> +			error = -1;
> +			goto out;
> +		}
> +	}
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

