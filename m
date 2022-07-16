Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1FE5770B5
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Jul 2022 20:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiGPSUd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Jul 2022 14:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiGPSUc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 16 Jul 2022 14:20:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF02E18E26
        for <linux-nfs@vger.kernel.org>; Sat, 16 Jul 2022 11:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657995631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=195cW/z3KMV0K1sldmZ5SRJI7BDD2cIJipXVVtuVne0=;
        b=O8DIuGia1W7d9U+iCKbfm8PGMjF/BcYMjNFgBIU1ivQLBmX1ltl6dyLBhrKA/e0s+2cmvT
        Wbqwbz4S/lX/nwBMLHKx/W6n7dsIBI5VTwaKoMk1Hks+AAY8WrE1i3rgxWftbId0E6YYum
        Tx7pnlDOMnqIYRrlwjb+42Y+0TnptZ0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-9k-cSsT2PlWi9SgkDugz_A-1; Sat, 16 Jul 2022 14:20:23 -0400
X-MC-Unique: 9k-cSsT2PlWi9SgkDugz_A-1
Received: by mail-qv1-f72.google.com with SMTP id r12-20020ad4404c000000b00472ffb530e2so4283283qvp.18
        for <linux-nfs@vger.kernel.org>; Sat, 16 Jul 2022 11:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=195cW/z3KMV0K1sldmZ5SRJI7BDD2cIJipXVVtuVne0=;
        b=UQ7yg5gRPTYqkHB20fQPBDixIJxxuFlmb+QQWRxtjcpiHCAGkcoFeUIVcaiwdMxMAZ
         +VD1imxDMd9GMC8tUxjpe/oIEulT+PbYCyzZkrwxOpo/4fltvlgiaE05BLXnEK3i1bH/
         SKUePbCwICRc6dUwJn9sUJg6V+vAbpaBf2Q/f0QXILmfHNEgDCoV0grfDXs8rL7YEXEo
         tIUzGShzl3YfO1oGns6Y7Tefp0S84HVMghlXcdDYS8i72GRhFBxzHlFmwEkwy9OrGqK3
         /p2G+X+ZbKX2a1qC7Q4MT3DzrThA9MTu7jjZBj00Fi4sbnJrxJ07tkUd1//tfe12Tocn
         kFcA==
X-Gm-Message-State: AJIora/2jd6o7ghzrHxyRWLbR+8nMwfB4CZMTl8GlL/3PisAxoEkRklS
        b/XoOd4P87NDFf3Jzgmd3FOmlTNm5+XpbJQIWSUY7xHxGHfLDvZAQEIx7tULoL2Szu/01Z/d5jU
        Bd7h0XZeqNfixZQQjKgfN
X-Received: by 2002:a37:b802:0:b0:6b5:8330:55a with SMTP id i2-20020a37b802000000b006b58330055amr13402634qkf.778.1657995623334;
        Sat, 16 Jul 2022 11:20:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vBJLHGBuXrnC4b7BpvS9EkUk7I3RFs6KAGVe87AvBHrfPMazd7sf7jwyD2ScRfvHZ3vML+VQ==
X-Received: by 2002:a37:b802:0:b0:6b5:8330:55a with SMTP id i2-20020a37b802000000b006b58330055amr13402623qkf.778.1657995623029;
        Sat, 16 Jul 2022 11:20:23 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:db8c:7bbd:f449:802d? (2603-6000-d605-db00-db8c-7bbd-f449-802d.res6.spectrum.com. [2603:6000:d605:db00:db8c:7bbd:f449:802d])
        by smtp.gmail.com with ESMTPSA id i10-20020a05620a404a00b006b2849cdd37sm7465825qko.113.2022.07.16.11.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jul 2022 11:20:22 -0700 (PDT)
Message-ID: <fd568705-8036-b556-5a43-9fb59b4cddd4@redhat.com>
Date:   Sat, 16 Jul 2022 13:20:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] rpcb_clnt.c add mechanism to try v2 protocol first
Content-Language: en-US
To:     Roberto Bergantinos Corpas <rbergant@redhat.com>,
        libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
References: <20220701144422.328923-1-rbergant@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220701144422.328923-1-rbergant@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/1/22 9:44 AM, Roberto Bergantinos Corpas wrote:
> There have been previous attempts to revert protocol tryout
> algorithm from v4,v3,v2 to previous v2,v4,v3 :
> 
> https://www.spinics.net/lists/linux-nfs/msg89228.html
> 
> Apart from GETADDR/NAT issue originating that proposed change,
> its possible that some legacy custom applications still use
> v2 of protocol with libtirpc.
> 
> The change proposed here, introduces an environment variable
> "RPCB_V2FIRST" so that, if defined, old behaviour is used.
> This is more flexible and allow us to selectively pick what
> application reverts to old behaviour instead of a system-wide
> change.
> 
> Example :
> 
> $ tcpdump -s0 -i ens3 port 111 -w /tmp/capture.pcap &> /dev/null &
> [1] 13016
> $ rpcinfo -T tcp 172.23.1.225 100005 &> /dev/null
> $ RPCB_V2FIRST=1 rpcinfo -T tcp 172.23.1.225 100005 &> /dev/null
> $ pkill tcpdump
> $ tshark -tad -nr /tmp/capture.pcap -Y portmap -T fields -e _ws.col.Info
> V4 GETADDR Call
> V4 GETADDR Reply (Call In 4)
> V2 GETPORT Call MOUNT(100005) V:0 TCP
> V2 GETPORT Reply (Call In 14) Port:20048
> 
> Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
Committed... (tag libtirpc-1-3-3-rc3)

steved.
> ---
>   man/rpcbind.3t        |  2 ++
>   src/rpcb_clnt.c       | 27 ++++++++++++++++++++++++---
>   tirpc/rpc/pmap_prot.h |  2 ++
>   3 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/man/rpcbind.3t b/man/rpcbind.3t
> index ec492cc..4cb271b 100644
> --- a/man/rpcbind.3t
> +++ b/man/rpcbind.3t
> @@ -187,6 +187,8 @@ in
>   .El
>   .Sh AVAILABILITY
>   These functions are part of libtirpc.
> +.Sh ENVIRONMENT
> +If RPCB_V2FIRST is defined, rpcbind protocol version tryout algorithm changes from v4,v2,v3 to v2,v4,v3.
>   .Sh SEE ALSO
>   .Xr rpc_clnt_calls 3 ,
>   .Xr rpc_svc_calls 3 ,
> diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
> index 0c34cb7..db3799e 100644
> --- a/src/rpcb_clnt.c
> +++ b/src/rpcb_clnt.c
> @@ -818,7 +818,8 @@ error:
>    * The algorithm used: If the transports is TCP or UDP, it first tries
>    * version 4 (srv4), then 3 and then fall back to version 2 (portmap).
>    * With this algorithm, we get performance as well as a plan for
> - * obsoleting version 2.
> + * obsoleting version 2. This behaviour is reverted to old algorithm
> + * if RPCB_V2FIRST environment var is defined
>    *
>    * For all other transports, the algorithm remains as 4 and then 3.
>    *
> @@ -839,6 +840,10 @@ __rpcb_findaddr_timed(program, version, nconf, host, clpp, tp)
>   #ifdef NOTUSED
>   	static bool_t check_rpcbind = TRUE;
>   #endif
> +
> +#ifdef PORTMAP
> +	static bool_t portmap_first = FALSE;
> +#endif
>   	CLIENT *client = NULL;
>   	RPCB parms;
>   	enum clnt_stat clnt_st;
> @@ -895,8 +900,18 @@ __rpcb_findaddr_timed(program, version, nconf, host, clpp, tp)
>   		parms.r_addr = (char *) &nullstring[0];
>   	}
>   
> -	/* First try from start_vers(4) and then version 3 (RPCBVERS) */
> +	/* First try from start_vers(4) and then version 3 (RPCBVERS), except
> +	 * if env. var RPCB_V2FIRST is defined */
> +
> +#ifdef PORTMAP
> +	if (getenv(V2FIRST)) {
> +		portmap_first = TRUE;
> +		LIBTIRPC_DEBUG(3, ("__rpcb_findaddr_timed: trying v2-port first\n"));
> +		goto portmap;
> +	}
> +#endif
>   
> +rpcbind:
>   	CLNT_CONTROL(client, CLSET_RETRY_TIMEOUT, (char *) &rpcbrmttime);
>   	for (vers = start_vers;  vers >= RPCBVERS; vers--) {
>   		/* Set the version */
> @@ -944,10 +959,16 @@ __rpcb_findaddr_timed(program, version, nconf, host, clpp, tp)
>   	}
>   
>   #ifdef PORTMAP 	/* Try version 2 for TCP or UDP */
> +	if (portmap_first)
> +		goto error; /* we tried all versions if reached here */
> +portmap:
>   	if (strcmp(nconf->nc_protofmly, NC_INET) == 0) {
>   		address = __try_protocol_version_2(program, version, nconf, host, tp);
>   		if (address == NULL)
> -			goto error;
> +			if (portmap_first)
> +				goto rpcbind;
> +			else
> +				goto error;
>   	}
>   #endif		/* PORTMAP */
>   
> diff --git a/tirpc/rpc/pmap_prot.h b/tirpc/rpc/pmap_prot.h
> index 75354ce..7718b8b 100644
> --- a/tirpc/rpc/pmap_prot.h
> +++ b/tirpc/rpc/pmap_prot.h
> @@ -84,6 +84,8 @@
>   #define PMAPPROC_DUMP		((u_long)4)
>   #define PMAPPROC_CALLIT		((u_long)5)
>   
> +#define V2FIRST		"RPCB_V2FIRST"
> +
>   struct pmap {
>   	long unsigned pm_prog;
>   	long unsigned pm_vers;

