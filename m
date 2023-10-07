Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07EF7BC6F8
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Oct 2023 13:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343782AbjJGLAh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Oct 2023 07:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343826AbjJGLAg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Oct 2023 07:00:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8725093
        for <linux-nfs@vger.kernel.org>; Sat,  7 Oct 2023 03:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696676394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eDApa3RrBksKMdjY+xMBuKyfAdJZDq83gDf1xJlW1ko=;
        b=dAOTJewqjHF9U/BR0CulXpRF72hdBdJw3qij5KGju/vBm+Zdc/35qmBmn4tY5M0WJMz6+o
        osV+lV5OdkoNCLiTOyhI5HcPb4gwJef5ltwNlBulNeUagvBTAgfwFUfpOWqDNcxUfOcqcf
        IxGasE5uBWIyBj2lHqzFoQtvOZcbDzg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-AsDo3tNBMLu9aH8wSdcEiw-1; Sat, 07 Oct 2023 06:59:46 -0400
X-MC-Unique: AsDo3tNBMLu9aH8wSdcEiw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-775842dc945so54471585a.0
        for <linux-nfs@vger.kernel.org>; Sat, 07 Oct 2023 03:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696676386; x=1697281186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDApa3RrBksKMdjY+xMBuKyfAdJZDq83gDf1xJlW1ko=;
        b=J0FQnTWIUuEuNFZ90uQCdCV7ubpLSZosegeqNJRI4ms+5/yxR23kUmZTKUlcOAfLC3
         BH8e2HpdIR+bCgtjkydXcXhvbASfipu/C5MQervWYmERaIfbfR4cFMt13nugRJOpHAtn
         7SLt2kOgfWCqzJCtDTSaE3bds/WaM0zmcg0UhvpL4py2m/U4RalWeXEDiYV/d+P8s0ce
         Qd2H4vymn+nXGq0HdpRMq5FLkWBv0MkI4ZhJOGbFFA22csEN2Dqml5BAmJwCYZ32TiOj
         wlQW3uTyyehzoxnUAQp6hhhhZ085Xf+Q+9FjCtbfzPWixXmZev2ZF108IkIURy2u+re5
         8mwQ==
X-Gm-Message-State: AOJu0YyVc9l6Erh0ExKSUR9Feoob32rMKBPp5QAsOlC80+RATYZ1PgjX
        35JD6ER6Tzcd+c92gNJJeQtVTMeat+o6M13bTtMFlZwfoNIJO6ixjYYVsXriv4PEVLh7CVc796b
        MaBZ9p1W11XGNNa42Wqgr
X-Received: by 2002:a05:620a:268d:b0:776:f188:eee6 with SMTP id c13-20020a05620a268d00b00776f188eee6mr6253524qkp.2.1696676385955;
        Sat, 07 Oct 2023 03:59:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQEuoz0+jzxL40mnytK273UhHoINe+CgmqDGb5IyB1cpf1H4xhEIig7OQE9xZKI+hnwN/OtQ==
X-Received: by 2002:a05:620a:268d:b0:776:f188:eee6 with SMTP id c13-20020a05620a268d00b00776f188eee6mr6253512qkp.2.1696676385535;
        Sat, 07 Oct 2023 03:59:45 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.164.53])
        by smtp.gmail.com with ESMTPSA id p4-20020a05620a112400b007684220a08csm1974690qkk.70.2023.10.07.03.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 03:59:45 -0700 (PDT)
Message-ID: <8e69cfca-0329-2ca4-5368-b78e1d55b6db@redhat.com>
Date:   Sat, 7 Oct 2023 06:59:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] binddynport.c honor ip_local_reserved_ports
To:     Otto Hollmann <ohollmann@suse.cz>,
        libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org, Thomas Blume <thomas.blume@suse.com>
References: <1654766776.2720.14.camel@suse.cz>
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <1654766776.2720.14.camel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/9/22 5:26 AM, Otto Hollmann wrote:
> Read reserved ports from /proc/sys/net/ipv4/ip_local_reserved_ports,
> store them into bit-wise array and before binding to random port check
> if port is not reserved.
> 
> 
> Currently, there is no way how to reserve ports so then will not be
> used by rpcbind.
> 
> Random ports are opened by rpcbind because of rmtcalls. There is
> compile-time flag for disabling them, but in some cases we can not
> simply disable them.
> 
> One solution would be run time option --enable-rmtcalls as already
> discussed, but it was rejected. So if we want to keep rmtcalls enabled
> and also be able to reserve some ports, there is no other way than
> filtering available ports. The easiest and clearest way seems to be
> just respect kernel list of ip_reserved_ports.
> 
> Unfortunately there is one known disadvantage/side effect - it affects
> probability of ports which are right after reserved ones. The bigger
> reserved block is, the higher is probability of selecting following
> unreserved port. But if there is no reserved port, impact of this patch
> is minimal/none.
> 
> Signed-off-by: Otto Hollmann <otto.hollmann@suse.com>
Committed... (tag libtirpc-1-3-4-rc4)

steved
> ---
>   src/binddynport.c | 107 ++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 99 insertions(+), 8 deletions(-)
> 
> diff --git a/src/binddynport.c b/src/binddynport.c
> index 062629a..6f78ebe 100644
> --- a/src/binddynport.c
> +++ b/src/binddynport.c
> @@ -37,6 +37,7 @@
>   #include <unistd.h>
>   #include <errno.h>
>   #include <string.h>
> +#include <syslog.h>
>   
>   #include <rpc/rpc.h>
>   
> @@ -56,6 +57,84 @@ enum {
>   	NPORTS		= ENDPORT - LOWPORT + 1,
>   };
>   
> +/*
> + * This function decodes information about given port from provided array and
> + * return if port is reserved or not.
> + *
> + * @reserved_ports an array of size at least "NPORTS / (8*sizeof(char)) + 1".
> + * @port port number within range LOWPORT and ENDPORT
> + *
> + * Returns 0 if port is not reserved, non-negative if port is reserved.
> + */
> +int is_reserved(char *reserved_ports, int port) {
> +	port -= LOWPORT;
> +	if (port < 0 || port >= NPORTS)
> +		return 0;
> +	return reserved_ports[port/(8*sizeof(char))] & 1<<(port%(8*sizeof(char)));
> +}
> +
> +/*
> + * This function encodes information about given *reserved* port into provided
> + * array. Don't call this function for ports which are not reserved.
> + *
> + * @reserved_ports array TODO .
> + * @port port number within range LOWPORT and ENDPORT
> + *
> + */
> +void set_reserved(char *reserved_ports, int port) {
> +	port -= LOWPORT;
> +	if (port < 0 || port >= NPORTS)
> +		return;
> +	reserved_ports[port/(8*sizeof(char))] |= 1<<(port%(8*sizeof(char)));
> +}
> +
> +/*
> + * Parse local reserved ports obtained from
> + * /proc/sys/net/ipv4/ip_local_reserved_ports into bit array.
> + *
> + * @reserved_ports a zeroed array of size at least
> + * "NPORTS / (8*sizeof(char)) + 1". Will be used for bit-wise encoding of
> + * reserved ports.
> + *
> + * On each call, reserved ports are read from /proc and bit-wise stored into
> + * provided array
> + *
> + * Returns 0 on success, -1 on failure.
> + */
> +
> +int parse_reserved_ports(char *reserved_ports) {
> +	int from, to;
> +	char delimiter = ',';
> +	int res;
> +	FILE * file_ptr = fopen("/proc/sys/net/ipv4/ip_local_reserved_ports","r");
> +	if (file_ptr == NULL) {
> +		(void) syslog(LOG_ERR,
> +			"Unable to open open /proc/sys/net/ipv4/ip_local_reserved_ports.");
> +		return -1;
> +	}
> +	do {
> +		if ((res = fscanf(file_ptr, "%d", &to)) != 1) {
> +			if (res == EOF) break;
> +			goto err;
> +		}
> +		if (delimiter != '-') {
> +			from = to;
> +		}
> +		for (int i = from; i <= to; ++i) {
> +			set_reserved(reserved_ports, i);
> +		}
> +	} while ((res = fscanf(file_ptr, "%c", &delimiter)) == 1);
> +	if (res != EOF)
> +		goto err;
> +	fclose(file_ptr);
> +	return 0;
> +err:
> +	(void) syslog(LOG_ERR,
> +		"An error occurred while parsing ip_local_reserved_ports.");
> +	fclose(file_ptr);
> +	return -1;
> +}
> +
>   /*
>    * Bind a socket to a dynamically-assigned IP port.
>    *
> @@ -81,7 +160,8 @@ int __binddynport(int fd)
>   	in_port_t port, *portp;
>   	struct sockaddr *sap;
>   	socklen_t salen;
> -	int i, res;
> +	int i, res, array_size;
> +	char *reserved_ports;
>   
>   	if (__rpc_sockisbound(fd))
>   		return 0;
> @@ -119,21 +199,32 @@ int __binddynport(int fd)
>   		gettimeofday(&tv, NULL);
>   		seed = tv.tv_usec * getpid();
>   	}
> +	array_size = NPORTS / (8*sizeof(char)) + 1;
> +	reserved_ports = malloc(array_size);
> +	if (!reserved_ports) {
> +		goto out;
> +	}
> +	memset(reserved_ports, 0, array_size);
> +	parse_reserved_ports(reserved_ports);
> +
>   	port = (rand_r(&seed) % NPORTS) + LOWPORT;
>   	for (i = 0; i < NPORTS; ++i) {
> -		*portp = htons(port++);
> -		res = bind(fd, sap, salen);
> -		if (res >= 0) {
> -			res = 0;
> -			break;
> +		*portp = htons(port);
> +		if (!is_reserved(reserved_ports, port++)) {
> +			res = bind(fd, sap, salen);
> +			if (res >= 0) {
> +				res = 0;
> +				break;
> +			}
> +			if (errno != EADDRINUSE)
> +				break;
>   		}
> -		if (errno != EADDRINUSE)
> -			break;
>   		if (port > ENDPORT)
>   			port = LOWPORT;
>   	}
>   
>   out:
> +	free(reserved_ports);
>   	mutex_unlock(&port_lock);
>   	return res;
>   }

