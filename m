Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C840A575455
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 20:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbiGNSBt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 14:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbiGNSBs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 14:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCD8F675B6
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 11:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657821706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ppg07p4Hbn7ydVIIZP0n7PySfOqc52r3aMDT8vtE8Do=;
        b=NVfYkGiM17jRfR4V66Ko0Fl2mmp/rW8GdubpzH0p+FTGMTIh8JmxCp+7UZfI34pF4RuhNv
        La4/sTudjrTNKqZfTCIqsP6f7rN+BXQK5PAUTtEua4TN6AZ1lJyjOzo+TkUidfVY8QSDB6
        xlYSF60fEBricLZxQjshTqPZDAMOb64=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-pMsX2QY6MaKyPjol47ZMPA-1; Thu, 14 Jul 2022 14:01:44 -0400
X-MC-Unique: pMsX2QY6MaKyPjol47ZMPA-1
Received: by mail-qt1-f197.google.com with SMTP id b12-20020ac87fcc000000b0031eb197d53eso2027148qtk.7
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 11:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ppg07p4Hbn7ydVIIZP0n7PySfOqc52r3aMDT8vtE8Do=;
        b=UfHlFxhtiHSGk8lWYgt8X4IOikrlB0Q7mMuaCuIUoAePATklOANvN+kvnHGYGD1AVp
         FIjkvutKCljpiDyQiqON80oFkoKfZEW8hkXjd46XKlR4apetTkoJWRmpj+X3i2DKJ/9G
         NtjH7T4FQ8hdsgyPbz8D4UcI3p2Xj95t/1rkS1F/BL3twT/gyUPHEz//RUSHtkrDSBxr
         nrZnOyBLmrbjou0BDYO5NqxxCl5rOp9JZ3jk/sHGP+OT8MWwomFJQr/Nj1iQ9kMJWsSL
         +wDwDcW6mkWJVlZE7dC+pTZgwN+S1IKRGTlUXPmfNN7cOzTdbQlIUYgMPR0fH929I93D
         Qzzg==
X-Gm-Message-State: AJIora/x4b87BmOr0GoktXwo5K5o/f92ZiEZ5uainExpyJVF9HqpkQO1
        pwerSS90hU5oZ/880VcYBEhw0Q4CAiXrotcQyj5R8cbsO6sAsRtAJbVld/kBTqDLozhrXBlY1ZI
        2kRCZ88xBZiSO/ZDVy4CM
X-Received: by 2002:a05:622a:13d3:b0:31e:d596:77ef with SMTP id p19-20020a05622a13d300b0031ed59677efmr2114666qtk.252.1657821702427;
        Thu, 14 Jul 2022 11:01:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sctnpquVIw46Mni+y+5FRYkPk6ZTbSEClxuo8SIpYxZCyd7/S/ZZqfj7MhM+5X4jffBsVNHA==
X-Received: by 2002:a05:622a:13d3:b0:31e:d596:77ef with SMTP id p19-20020a05622a13d300b0031ed59677efmr2114499qtk.252.1657821700660;
        Thu, 14 Jul 2022 11:01:40 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:db8c:7bbd:f449:802d? (2603-6000-d605-db00-db8c-7bbd-f449-802d.res6.spectrum.com. [2603:6000:d605:db00:db8c:7bbd:f449:802d])
        by smtp.gmail.com with ESMTPSA id u12-20020a37ab0c000000b006b554958bb1sm1840711qke.26.2022.07.14.11.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 11:01:40 -0700 (PDT)
Message-ID: <d59de44c-4716-cf5d-906b-5a3d8685f53b@redhat.com>
Date:   Thu, 14 Jul 2022 13:01:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] binddynport.c honor ip_local_reserved_ports
Content-Language: en-US
To:     Otto Hollmann <ohollmann@suse.cz>,
        libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org, Thomas Blume <thomas.blume@suse.com>
References: <1654766776.2720.14.camel@suse.cz>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <1654766776.2720.14.camel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey,

My apologies for taking so long to get to this...

A couple questions:

1) How well was tested... Is in your distro already?
2) Those new functions the patch introduces...
    Don't effect the API? Meaning shouldn't they
    declared as static?

steved.

On 6/9/22 4:26 AM, Otto Hollmann wrote:
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

