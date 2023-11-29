Return-Path: <linux-nfs+bounces-165-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB89A7FD6D5
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 13:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83411C211B2
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 12:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1FC1DDF5;
	Wed, 29 Nov 2023 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6+/dLBz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B303C8F
	for <linux-nfs@vger.kernel.org>; Wed, 29 Nov 2023 04:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701261278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPJYop69h0KlbLcLqZb85b0BEOjMvooQHXzRvNIypjM=;
	b=Z6+/dLBzKs2iQJ4/N4+DiriZKdORx0uAhW6IBTKq4ofaPH+QCLYXA6KfeYSUIr3Isgtavz
	+q36q/kesH90PYI5gQt87eKk2iOsWCNH1R2u7HF27CVza+o/omZyx1UGWkGCjAQk/9CUnZ
	9EXZkzI6SpXjLUkVcInbRUIszsQuW3s=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-KuXwCY9hNcO5-d63qOl7gA-1; Wed, 29 Nov 2023 07:34:36 -0500
X-MC-Unique: KuXwCY9hNcO5-d63qOl7gA-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-58dadcf7adbso235763eaf.1
        for <linux-nfs@vger.kernel.org>; Wed, 29 Nov 2023 04:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701261276; x=1701866076;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPJYop69h0KlbLcLqZb85b0BEOjMvooQHXzRvNIypjM=;
        b=jTGzRSPkpMKaOEnoEx9JZ94p2xpcAD7J/CPHjQbYYpKrCTFG0dkvg6gwChqLMpR2H+
         a9JssHgXf1PWZlBReLPZrweP38m8Kf5H0SJcI9D/BMvfXwo8WWrYlarZKtatU1VDaU4X
         10sqO7hNfnz8CF8dTcjPFqv989X0ysywK6ep8kjhdbOPDQQiy/bMjvwdJjytOYN4KyeQ
         vAtxNDuCFM++94hkrhfzQpPeN86gCxWljIrFKSr0G+fAV7x3iMa4e1T1JrTHBestLacm
         pZ7UHm6L1+jPlvJth5AKX2CUUFPpwJUUGjfJYIoz/lVI8aJAioGA9lZMCXzjO06YMVv3
         CGHA==
X-Gm-Message-State: AOJu0YxW7NHUpG6zhyJARX6vuoVHBezNMcR3cXlqMU6HNy+1WpvRPWdD
	cfkVMNWrFYrwnQzr8YyQBExLq+eCLJonWIZafBFMCYY9c8sPAM19Ckdmxp+zKOGOUv4UCOZRLdL
	jO5YCGjoz3gPN8hmyzLBl
X-Received: by 2002:a05:6358:63a7:b0:16b:c41b:7769 with SMTP id k39-20020a05635863a700b0016bc41b7769mr19301620rwh.3.1701261274586;
        Wed, 29 Nov 2023 04:34:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiAfxFfQNoSTaXQjrP0FRA6OrSuNDWfOn+EEY2hR2VW8HiQjgZJv93VD4SEkJDtJJc3QjWYw==
X-Received: by 2002:a05:6358:63a7:b0:16b:c41b:7769 with SMTP id k39-20020a05635863a700b0016bc41b7769mr19301599rwh.3.1701261274241;
        Wed, 29 Nov 2023 04:34:34 -0800 (PST)
Received: from [172.31.1.12] ([70.109.186.209])
        by smtp.gmail.com with ESMTPSA id z20-20020a0cda94000000b0067266b7b903sm6098546qvj.5.2023.11.29.04.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 04:34:34 -0800 (PST)
Message-ID: <da202cf6-b836-4b9d-9da7-dc9613e936d0@redhat.com>
Date: Wed, 29 Nov 2023 07:34:33 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils v2 1/2] fsidd: call anonymous sockets by their
 name only, don't fill with NULs to 108 bytes
Content-Language: en-US
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>
References: <b38ecca96762d939d377c381bf34521ee5945129.1700601199.git.nabijaczleweli@nabijaczleweli.xyz>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <b38ecca96762d939d377c381bf34521ee5945129.1700601199.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/21/23 4:14 PM, Ahelenia Ziemiańska wrote:
> Since e00ab3c0616fe6d83ab0710d9e7d989c299088f7, ss -l looks like this:
>    u_seq               LISTEN                0                     5                                    @/run/fsid.sock@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 26989379                                                       * 0
> with fsidd pushing all the addresses to 108 bytes wide, which is deeply
> egregious if you don't filter it out and recolumnate.
> 
> This is because, naturally (unix(7)), "Null bytes in the name have
> no special significance": abstract addresses are binary blobs, but
> paths automatically terminate at the first NUL byte, since paths
> can't contain those.
> 
> So just specify the correct address length when we're using the abstract domain:
> unix(7) recommends "offsetof(struct sockaddr_un, sun_path) + strlen(sun_path) + 1"
> for paths, but we don't want to include the terminating NUL, so it's just
> "offsetof(struct sockaddr_un, sun_path) + strlen(sun_path)".
> This brings the width back to order:
> -- >8 --
> $ ss -la | grep @
> u_str ESTAB     0      0      @45208536ec96909a/bus/systemd-timesyn/bus-api-timesync 18500238                            * 18501249
> u_str ESTAB     0      0       @fecc9657d2315eb7/bus/systemd-network/bus-api-network 18495452                            * 18494406
> u_seq LISTEN    0      5                                             @/run/fsid.sock 27168796                            * 0
> u_str ESTAB     0      0                 @ac308f35f50797a2/bus/systemd-logind/system 19406                               * 15153
> u_str ESTAB     0      0                @b6606e0dfacbae75/bus/systemd/bus-api-system 18494353                            * 18495334
> u_str ESTAB     0      0                    @5880653d215718a7/bus/systemd/bus-system 26930876                            * 26930003
> -- >8 --
> 
> Fixes: e00ab3c0616fe6d83ab0710d9e7d989c299088f7 ("fsidd: provide
>   better default socket name.")
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
Committed... (tag: nfs-utils-2-7-1-rc1)

steved
> ---
> v1: <04f3fe71defa757d518468f04f08334a5d0dfbb9.1693754442.git.nabijaczleweli@nabijaczleweli.xyz>
> v2 NFC, addr_len declared at top of function
> 
>   support/reexport/fsidd.c    | 9 ++++++---
>   support/reexport/reexport.c | 8 ++++++--
>   2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/support/reexport/fsidd.c b/support/reexport/fsidd.c
> index 3e62b3fc..8a70b78f 100644
> --- a/support/reexport/fsidd.c
> +++ b/support/reexport/fsidd.c
> @@ -147,6 +147,7 @@ int main(void)
>   {
>   	struct event *srv_ev;
>   	struct sockaddr_un addr;
> +	socklen_t addr_len;
>   	char *sock_file;
>   	int srv;
>   
> @@ -161,10 +162,12 @@ int main(void)
>   	memset(&addr, 0, sizeof(struct sockaddr_un));
>   	addr.sun_family = AF_UNIX;
>   	strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
> -	if (addr.sun_path[0] == '@')
> +	addr_len = sizeof(struct sockaddr_un);
> +	if (addr.sun_path[0] == '@') {
>   		/* "abstract" socket namespace */
> +		addr_len = offsetof(struct sockaddr_un, sun_path) + strlen(addr.sun_path);
>   		addr.sun_path[0] = 0;
> -	else
> +	} else
>   		unlink(sock_file);
>   
>   	srv = socket(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK, 0);
> @@ -173,7 +176,7 @@ int main(void)
>   		return 1;
>   	}
>   
> -	if (bind(srv, (const struct sockaddr *)&addr, sizeof(struct sockaddr_un)) == -1) {
> +	if (bind(srv, (const struct sockaddr *)&addr, addr_len) == -1) {
>   		xlog(L_WARNING, "Unable to bind %s: %m\n", sock_file);
>   		return 1;
>   	}
> diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
> index 78516586..0fb49a46 100644
> --- a/support/reexport/reexport.c
> +++ b/support/reexport/reexport.c
> @@ -21,6 +21,7 @@ static int fsidd_srv = -1;
>   static bool connect_fsid_service(void)
>   {
>   	struct sockaddr_un addr;
> +	socklen_t addr_len;
>   	char *sock_file;
>   	int ret;
>   	int s;
> @@ -33,9 +34,12 @@ static bool connect_fsid_service(void)
>   	memset(&addr, 0, sizeof(struct sockaddr_un));
>   	addr.sun_family = AF_UNIX;
>   	strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
> -	if (addr.sun_path[0] == '@')
> +	addr_len = sizeof(struct sockaddr_un);
> +	if (addr.sun_path[0] == '@') {
>   		/* "abstract" socket namespace */
> +		addr_len = offsetof(struct sockaddr_un, sun_path) + strlen(addr.sun_path);
>   		addr.sun_path[0] = 0;
> +	}
>   
>   	s = socket(AF_UNIX, SOCK_SEQPACKET, 0);
>   	if (s == -1) {
> @@ -43,7 +47,7 @@ static bool connect_fsid_service(void)
>   		return false;
>   	}
>   
> -	ret = connect(s, (const struct sockaddr *)&addr, sizeof(struct sockaddr_un));
> +	ret = connect(s, (const struct sockaddr *)&addr, addr_len);
>   	if (ret == -1) {
>   		xlog(L_WARNING, "Unable to connect %s: %m, is fsidd running?\n", sock_file);
>   		return false;


