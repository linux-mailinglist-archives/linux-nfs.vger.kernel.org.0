Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3E1489BCD
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jan 2022 16:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbiAJPGv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jan 2022 10:06:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235119AbiAJPGu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jan 2022 10:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641827210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TdhaTLJGXHcFCh/fggcjKoyARfbGd5BhGZALmvztP9g=;
        b=Asy78koMAEpDGj3IwU5hH3u7t3+S3dpvz8Ta95bhuV52X/lCZYg6kSqbpwBCSSS8MZTqmY
        C+628NjCad6YKJ8ahAioVzCXwh9fAY8A6e6QDAsrUSAZBrtfb9g8xpYdafcByzOFh88u4t
        a8IFqPbzohmVNrRf4Fgr1Zf8BD5OqYQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-mbXpmLE2Pj2vy02xC2vVjw-1; Mon, 10 Jan 2022 10:06:49 -0500
X-MC-Unique: mbXpmLE2Pj2vy02xC2vVjw-1
Received: by mail-qk1-f200.google.com with SMTP id t8-20020a05620a0b0800b004764cabb1daso8093865qkg.12
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jan 2022 07:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=TdhaTLJGXHcFCh/fggcjKoyARfbGd5BhGZALmvztP9g=;
        b=qHuhQ3hNTDL7ACg2BY1PGoZGM//8TxW3IZec95tApcODK0mcuPoRmb8m+ouMqphQvD
         6bO86jJG/iyxZrhdpG3Jr4k0EfCWQb+3Gz07hoee2u2Hubs8/Zpns/qqPkZs88i1iV+z
         GE/Fi2g3B0nSizpFAtubC7CrYz28bdSEYCUixd020oI4R3qbyAq5Yo/n6/1Ty/qS4Y8r
         M98cd8MHP1cYMVqa2j6rC7hvwboLCNrvwpooWnTQzCXT3gBxV17Y6aElv5r0DJQqSi2O
         cbQy3XL5neRFMOI7M2sr338tmW5V2kelFUEchN6sdmnRJ38FecmBBFnnJbu73VzQebp7
         Md+g==
X-Gm-Message-State: AOAM533U3kph5FcsWEgtktPBWQGYwBEqm9Iu3dnSRzxiRmwjZjS/1Fec
        XS6iZryzu0/+9PUk/jRQhevQOZI9IEaQWtl5CveF8+6PWlMOUuF9nBwnPbeMIXrdF87Dxkdw6kv
        Bu48jnS8rfT5MMfi/Ir/jXIioIwP0I9/9gQlPJ1PlCFS0DToxtuTGNyNtAoYsXUvWa8Ai5g==
X-Received: by 2002:a05:6214:519c:: with SMTP id kl28mr69203940qvb.48.1641827208586;
        Mon, 10 Jan 2022 07:06:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzpxRI12hlPnCeDRfLiXdMeF4jdtwfIr1lp43bt9OimvYb/Fk+Ykjo6InceXiel6siakVmlpg==
X-Received: by 2002:a05:6214:519c:: with SMTP id kl28mr69203920qvb.48.1641827208321;
        Mon, 10 Jan 2022 07:06:48 -0800 (PST)
Received: from [172.31.1.6] ([70.105.247.147])
        by smtp.gmail.com with ESMTPSA id h4sm4691719qkp.54.2022.01.10.07.06.47
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 07:06:48 -0800 (PST)
Message-ID: <47ee3efc-8c25-4bd2-e6dc-c03d25e4f568@redhat.com>
Date:   Mon, 10 Jan 2022 10:06:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 0/3] Remove NFS v2 support from the client and server
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20211208163057.954500-1-steved@redhat.com>
In-Reply-To: <20211208163057.954500-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 12/8/21 11:30, Steve Dickson wrote:
> These patches will remove the all references and
> support of NFS v2 in both the server and client.
> 
> On server side the support has been off, by default,
> since 2013 (6b4e4965a6b). With this server patch the
> ability to enable v2 will be remove.
> 
> Currently even with CONFIG_NFS_V2 not set
> v2 mounts are still tied (over-the-wire). I looked at creating
> a kernel parameter module so support could re-enabled
> but that got ugly quick.
> 
> On the client, the -o v2 option is still a
> valid option because unknown mount options
> are passed to the kernel which will cause an
> actual mount to happen.
> 
> But the option has been removed from the man
> pages will cause the mount to fail with
> "NFS version is not supported"
> 
> I guess the only question left is does there
> need some type compilation flag or config flag
> that would re-enable the support. I'm thinking not.
> 
> Steve Dickson (3):
>    nfsd: Remove the ability to enable NFS v2.
>    nfs.man: Remove references to NFS v2 from the man pages
>    mount: Remove NFS v2 support from mount.nfs
> 
>   nfs.conf                  |  1 -
>   utils/mount/configfile.c  |  2 +-
>   utils/mount/mount.nfs.man |  2 +-
>   utils/mount/network.c     |  4 ++--
>   utils/mount/nfs.man       | 20 +++-----------------
>   utils/mount/nfsmount.conf |  2 +-
>   utils/mount/stropts.c     | 10 +++++++++-
>   utils/nfsd/nfsd.c         |  2 --
>   utils/nfsd/nfsd.man       |  4 ++--
>   9 files changed, 19 insertions(+), 28 deletions(-)
> 
Committed.... (tag: nfs-utils-2-5-5-rc5)

steved.

