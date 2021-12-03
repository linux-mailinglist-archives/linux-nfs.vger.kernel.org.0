Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C66C46789D
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Dec 2021 14:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381218AbhLCNne (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Dec 2021 08:43:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45963 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1381202AbhLCNnd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Dec 2021 08:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638538809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yPcDglCazMhWjriiVNGQgVXDNtgIq322wgaChjlksEQ=;
        b=EuW6p2fHU2xReKcjJPNVTPqhgvjJeD9XPBRaoleHV0ZzBDXY0UTdw+1+RE1tj8tWQsvLFv
        kX5kBzfjDSxBg7uxQXKC+EduQPjLWqBD5WY1O0fq9IG/CywXpCh6OJHZgDRx7MjVDT9Jp+
        iHKHpc4kXFmZojY8cDh012q44IvNgXQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-0NYZ7GbtPN2mD-ObDBQHPw-1; Fri, 03 Dec 2021 08:40:08 -0500
X-MC-Unique: 0NYZ7GbtPN2mD-ObDBQHPw-1
Received: by mail-ed1-f72.google.com with SMTP id q17-20020aa7da91000000b003e7c0641b9cso2575070eds.12
        for <linux-nfs@vger.kernel.org>; Fri, 03 Dec 2021 05:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yPcDglCazMhWjriiVNGQgVXDNtgIq322wgaChjlksEQ=;
        b=3ko+xAQa2yCFji8e7g9t8tYGOvUdC5LnxmXYw9DPPTcH6PKzASzXrY424EiEEWkCt1
         6N9Hb0xw8T/0gY14PqLOKv9RBa5UF5CguetcDoLMenkJEV28pPosxfSZcIdxtXbkeUzJ
         z5uJWgZhrpGfB53CN8FCrG4yM0Y/RVsfjPonc0erbrfIPaNduWaVQUwr7oqZZF8UA42V
         clQ9XQLDijMCeecXt0EIzwwdtDLSXF1+sDk4M+Bdp1NlQVXSJDOr+ezKth2EmsTTvEvo
         W3/vXpG4IlJq7Oq0gmt5cHGETlQjbsOsZI4Sg+u3b3i25yrEEtxahdws6ZB0XVHOgxwz
         nW8Q==
X-Gm-Message-State: AOAM530/7vVl0bNkrfPZGPiHFab6tgE0svDvyUknxi06II1ypDmZGEPa
        mGEbEDhgTqAZV52TM2vzAA6cv7aYnx+HetDASqSZOpUBrxjDsEiT5NDbeWztsD+MM8HkdZv5qUJ
        MDCbRzaYjUP2pC5tJwzu94bvLMgaq62z91coG
X-Received: by 2002:a05:6402:2793:: with SMTP id b19mr27274170ede.247.1638538806972;
        Fri, 03 Dec 2021 05:40:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyI9Qw1oxMDkoxcJLeNXGwN+4J9ucQa9OAhxgvq+uM6upel8a9wswn660gH/g21CfwucpCpvJaiDsPdl3wB5Uc=
X-Received: by 2002:a05:6402:2793:: with SMTP id b19mr27274134ede.247.1638538806704;
 Fri, 03 Dec 2021 05:40:06 -0800 (PST)
MIME-Version: 1.0
References: <20211201085443.GA24725@kili>
In-Reply-To: <20211201085443.GA24725@kili>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 3 Dec 2021 08:39:30 -0500
Message-ID: <CALF+zOkZgtfP7HrX4oP=qx2uKr3FTRHqECRqKGkRBZaz6F-jdg@mail.gmail.com>
Subject: Re: [bug report] nfs: Convert to new fscache volume/cookie API
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 1, 2021 at 3:55 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hi Dave,
>
> The patch 1234f5681081: "nfs: Convert to new fscache volume/cookie
> API" from Nov 14, 2020, leads to the following Smatch static checker
> warning:
>
>         fs/nfs/fscache.c:32 nfs_append_int()
>         warn: array off by one? 'key[(*_len)++]'
>
> This is an unpublished check which assumes all > comparisons are wrong
> until proven otherwise.
>
> fs/nfs/fscache.c
>     27 static bool nfs_append_int(char *key, int *_len, unsigned long long x)
>     28 {
>     29         if (*_len > NFS_MAX_KEY_LEN)
>     30                 return false;
>     31         if (x == 0)
> --> 32                 key[(*_len)++] = ',';
>     33         else
>     34                 *_len += sprintf(key + *_len, ",%llx", x);
>     35         return true;
>     36 }
>
> This function is very badly broken.  As the checker suggests, the >
> should be >= to prevent an array overflow.  But it's actually off by
> two because we have to leave space for the NUL terminator so the buffer
> is full when "*_len == NFS_MAX_KEY_LEN - 1".  That means the check
> should be:
>
>         if (*_len >= NFS_MAX_KEY_LEN - 1)
>                 return false;
>
> Except NFS_MAX_KEY_LEN is not the correct limit.  The buffer is larger
> than that.
>
> Unfortunately if we fixed the array overflow check then the sprintf()
> will now corrupt memory...  There is a missing check after the sprintf()
> so it does not tell you if we printed everything or not.  It just
> returns true and the next caller detects the overflow.
>
> I feel like append() functions are easier to use if we keep the start
> pointer and and len value constant and just modify the *offset.
>
> static bool nfs_append_int(char *key, int *off, int len, unsigned long long x)
> {
>         if (*off >= len - 1)
>                 return false;
>
>         if (x == 0)
>                 key[(*off)++] = ',';
>         else
>                 *off + snprintf(key + *off, len - *off, ",%llx", x);
>
>         if (*off >= len)
>                 return false;
>         return true;
> }
>
> [ snip ]
>
>     86  void nfs_fscache_get_super_cookie(struct super_block *sb, const char *uniq, int ulen)
>     87  {
>     88          struct nfs_server *nfss = NFS_SB(sb);
>     89          unsigned int len = 3;
>     90          char *key;
>     91
>     92          if (uniq) {
>     93                  nfss->fscache_uniq = kmemdup_nul(uniq, ulen, GFP_KERNEL);
>     94                  if (!nfss->fscache_uniq)
>     95                          return;
>     96          }
>     97
>     98          key = kmalloc(NFS_MAX_KEY_LEN + 24, GFP_KERNEL);
>     99          if (!key)
>    100                  return;
>    101
>    102          memcpy(key, "nfs", 3);
>    103          if (!nfs_fscache_get_client_key(nfss->nfs_client, key, &len) ||
>    104              !nfs_append_int(key, &len, nfss->fsid.major) ||
>
> So then we do:
>
>         len = NFS_MAX_KEY_LEN + 24;
>
> It's not totally clear to me where the 24 comes from or I would have
> sent a patch instead of a bug report.
>
>         memcpy(key, "nfs", 3);
>         off = 3;
>
>         if (!nfs_fscache_get_client_key(nfss->nfs_client, key, &off) ||
>             !nfs_append_int(key, &off, len, nfss->fsid.major) ||
>             !nfs_append_int(key, &off, len, nfss->fsid.minor) ||
>
>    105              !nfs_append_int(key, &len, nfss->fsid.minor) ||
>    106              !nfs_append_int(key, &len, sb->s_flags & NFS_SB_MASK) ||
>    107              !nfs_append_int(key, &len, nfss->flags) ||
>    108              !nfs_append_int(key, &len, nfss->rsize) ||
>    109              !nfs_append_int(key, &len, nfss->wsize) ||
>    110              !nfs_append_int(key, &len, nfss->acregmin) ||
>    111              !nfs_append_int(key, &len, nfss->acregmax) ||
>    112              !nfs_append_int(key, &len, nfss->acdirmin) ||
>    113              !nfs_append_int(key, &len, nfss->acdirmax) ||
>    114              !nfs_append_int(key, &len, nfss->client->cl_auth->au_flavor))
>    115                  goto out;
>    116
>    117          if (ulen > 0) {
>    118                  if (ulen > NFS_MAX_KEY_LEN - len)
>
> This check is also off.  It does not take into consideration the comma
> or the NUL terminator.  We need a "+ 2".
>
>                         if (ulen + 2 > len - off) {
>
>    119                          goto out;
>    120                  key[len++] = ',';
>    121                  memcpy(key + len, uniq, ulen);
>    122                  len += ulen;
>    123          }
>    124          key[len] = 0;
>    125
>    126          /* create a cache index for looking up filehandles */
>
> regards,
> dan carpenter
>

Thanks for the report.

The nfs_append_int() was actually a portion that David Howells
wrote in the latest round of fscache API conversion.
So I'm not sure if he wants to fix this up or if I should give it a go.

