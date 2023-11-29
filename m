Return-Path: <linux-nfs+bounces-166-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5F87FD6D7
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 13:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0833028356E
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 12:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4781DFD4;
	Wed, 29 Nov 2023 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLOqq2Kb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E44510DD
	for <linux-nfs@vger.kernel.org>; Wed, 29 Nov 2023 04:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701261298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/bZ9ZBWg15LQLGLKG2SKBUNpg6Kagay6sKA6tid+bE=;
	b=KLOqq2KbnoNTv/OSuhxDiQCGeAY4rbwUNinHwwpS/k5eUrmki8feLQEnZwWRD+VHLB8uoo
	2kP9ocBIvO8V0fKZGWUQHYOtYKcijgwI01Mn5NE4JYZ8rdys1iF1YZp3rSI6IihD5UgWyV
	JewqNSrFn3mrOiEauJZrzbqJvjD1EcM=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-eMEOXQXtMveIdzq2ArJ1MQ-1; Wed, 29 Nov 2023 07:34:56 -0500
X-MC-Unique: eMEOXQXtMveIdzq2ArJ1MQ-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-58d7fcec894so689719eaf.1
        for <linux-nfs@vger.kernel.org>; Wed, 29 Nov 2023 04:34:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701261296; x=1701866096;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/bZ9ZBWg15LQLGLKG2SKBUNpg6Kagay6sKA6tid+bE=;
        b=n9Tr2gEayrUoJ9tFIHsqxSSm6UVGQIwGHnAX030VZqGPUb0uYr3vPg9OGIxzhQxjB3
         AOwOewqyK3mMTlp2OuXeRoh7qpPNWgWsoz0xyw0jb9vj/AuPLCpaYn1y+4HhXeByoavy
         n5cdryg3zTci93uf5QXmKjvFo2JaScEvwQCleqkCp/HkslTtmZ972rtqYi1NnXz50W7C
         AUc+btbnbS4X2rPCjT7duhrm6hKsqZKh8qs6ZH2W0INySz2zxzxAKhTB72Y54hHmXG90
         Wjm0hScPUWQENoqyaSPKtGJ8ZGoJlETIsFNoRytUCtT981BkJ+w4KqrOZ9IqtqABzEyA
         33Tg==
X-Gm-Message-State: AOJu0YyMuHMIqrH3+lMmCqAJCV5FYXK7Dt9rIH0MJbwkY8Kxj4iliJvd
	OG1NDD3kJTAhv6EszXjiNR0/+1qc7q/G5Z1+6jQ9oqKLg0DoWBOOVZAmxEtNVTOSnZYupco6LyH
	gJsJmxC7P68KszQjCt1PO
X-Received: by 2002:a4a:c691:0:b0:584:1080:f0a5 with SMTP id m17-20020a4ac691000000b005841080f0a5mr17779370ooq.1.1701261295844;
        Wed, 29 Nov 2023 04:34:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnraxXZ2mmN5qoGrB45O0k2KEpLhbVpyzxtUXUSzAlJbCJ8y1snkFRRJigMGCOlvKE7nq8mg==
X-Received: by 2002:a4a:c691:0:b0:584:1080:f0a5 with SMTP id m17-20020a4ac691000000b005841080f0a5mr17779352ooq.1.1701261295435;
        Wed, 29 Nov 2023 04:34:55 -0800 (PST)
Received: from [172.31.1.12] ([70.109.186.209])
        by smtp.gmail.com with ESMTPSA id z20-20020a0cda94000000b0067266b7b903sm6098546qvj.5.2023.11.29.04.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 04:34:55 -0800 (PST)
Message-ID: <863c8d38-5c80-4dd3-9332-2a4139000d83@redhat.com>
Date: Wed, 29 Nov 2023 07:34:54 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils v2 2/2] testlk: format off_t as llong instead of
 ssize_t
Content-Language: en-US
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>
References: <b38ecca96762d939d377c381bf34521ee5945129.1700601199.git.nabijaczleweli@nabijaczleweli.xyz>
 <9d2b8bdc146a1fb48b391ae1adda0b6249ba9c5b.1700601199.git.nabijaczleweli@nabijaczleweli.xyz>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <9d2b8bdc146a1fb48b391ae1adda0b6249ba9c5b.1700601199.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/21/23 4:15 PM, Ahelenia Ziemiańska wrote:
> This, naturally, produces a warning on x32 (and other ILP32 platforms
> with 64-bit off_t, presumably, but you need to ask for it explicitly
> there usually):
> gcc -DHAVE_CONFIG_H -I. -I../../support/include  -D_GNU_SOURCE -Wdate-time -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE -g -O2 -ffile-prefix-map=/tmp/nfs-utils-2.6.3=. -specs=/usr/share/dpkg/pie-compile.specs -fstack-protector-strong -Wformat -Werror=format-security -g -O2 -ffile-prefix-map=/tmp/nfs-utils-2.6.3=. -specs=/usr/share/dpkg/pie-compile.specs -fstack-protector-strong -Wformat -Werror=format-security -c -o testlk-testlk.o `test -f 'testlk.c' || echo './'`testlk.c
> testlk.c: In function ‘main’:
> testlk.c:84:66: warning: format ‘%zd’ expects argument of type ‘signed size_t’, but argument 4 has type ‘__off_t’ {aka ‘long long int’} [-Wformat=]
>     84 |                         printf("%s: conflicting lock by %d on (%zd;%zd)\n",
>        |                                                                ~~^
>        |                                                                  |
>        |                                                                  int
>        |                                                                %lld
>     85 |                                 fname, fl.l_pid, fl.l_start, fl.l_len);
>        |                                                  ~~~~~~~~~~
>        |                                                    |
>        |                                                    __off_t {aka long long int}
> testlk.c:84:70: warning: format ‘%zd’ expects argument of type ‘signed size_t’, but argument 5 has type ‘__off_t’ {aka ‘long long int’} [-Wformat=]
>     84 |                         printf("%s: conflicting lock by %d on (%zd;%zd)\n",
>        |                                                                    ~~^
>        |                                                                      |
>        |                                                                      int
>        |                                                                    %lld
>     85 |                                 fname, fl.l_pid, fl.l_start, fl.l_len);
>        |                                                              ~~~~~~~~
>        |                                                                |
>        |                                                                __off_t {aka long long int}
> 
> Upcast to long long, doesn't really matter.
> 
> It does, of course, raise the question of whether other bits of
> nfs-utils do something equally broken that just isn't caught by the
> format validator.
> 
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
Committed... (tag: nfs-utils-2-7-1-rc1)

steved
> ---
> Same as v1: <44adec629186e220ee5d8fd936980ac4a33dc510.1693754442.git.nabijaczleweli@nabijaczleweli.xyz>
> 
>   tools/locktest/testlk.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/locktest/testlk.c b/tools/locktest/testlk.c
> index ea51f788..c9bd6bac 100644
> --- a/tools/locktest/testlk.c
> +++ b/tools/locktest/testlk.c
> @@ -81,8 +81,8 @@ main(int argc, char **argv)
>   		if (fl.l_type == F_UNLCK) {
>   			printf("%s: no conflicting lock\n", fname);
>   		} else {
> -			printf("%s: conflicting lock by %d on (%zd;%zd)\n",
> -				fname, fl.l_pid, fl.l_start, fl.l_len);
> +			printf("%s: conflicting lock by %d on (%lld;%lld)\n",
> +				fname, fl.l_pid, (long long)fl.l_start, (long long)fl.l_len);
>   		}
>   		return 0;
>   	}


