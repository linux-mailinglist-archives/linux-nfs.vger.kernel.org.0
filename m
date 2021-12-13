Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B53473661
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Dec 2021 22:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243070AbhLMVGE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Dec 2021 16:06:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243078AbhLMVGD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Dec 2021 16:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639429563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TT/gq1NqQbt1n10mE+9S+/x8qCpJ6xMxDtVYZGzNZE4=;
        b=cO1QdPq/yuqxlzvwc61L/YFRR4tVcpSzcy/aJkdzAkAYxEd+Dd5uw2ApFZgBve2S02G783
        WKbf7I7NMQD7uBbb1P7gNMSaDpyx3IZEr8Wmgiu1wqCTtyLpzP+nqbCJf9+YrSxyeEBEHL
        0ijuFJTRJ4gfEW+zn+q+jBqABwAYUUc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-eK9NwM4AODqELgV3c4KkaQ-1; Mon, 13 Dec 2021 16:06:02 -0500
X-MC-Unique: eK9NwM4AODqELgV3c4KkaQ-1
Received: by mail-ed1-f71.google.com with SMTP id eg20-20020a056402289400b003eb56fcf6easo14984554edb.20
        for <linux-nfs@vger.kernel.org>; Mon, 13 Dec 2021 13:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TT/gq1NqQbt1n10mE+9S+/x8qCpJ6xMxDtVYZGzNZE4=;
        b=FskTkHDumN8MsOKXIJR5Z+r8rpx6oBZVxBNo2DoUS/gHCOYFblgHCHLB7PwS9Itmxw
         3qkOeUyjbD6+WP0NsPzZbhbC5uCWtKlFbpecizHdVFTNpjmV6GK8N9IN+3GidFZ8Qt9Y
         3tKcVZeZznffr8juIcg5NlCICOzP8ZRSxGoyfzWPeWcWCRUfrZR92CacVbAQF+yFmCDv
         gllzAsjtQAXcKrJNQqBgbsM5SNmEuZIcW8KqtUvNxKBvlRUIT2YMm+rNIXvrM73bA/hH
         z262YszpavUC+oL2PE0gXHTYxZ/EHQJFwGmdRUufhrye0waShz/pDSDwuEDbSmSo5feF
         aZXA==
X-Gm-Message-State: AOAM531Jn462ATX32m9/Oxf5ftJqbvygHH5BLUvI1TyI0t7wVZyaHmW3
        5gNe642RC7QAGKsxIJfOaM015/Pwt++qvdUEYKYvqYcKe2gc3CcTdCVHTFtJr0mObxxrz/IJuyz
        iaM1Jsrljyd0f5ASs7KFstDFuLrILbD66I+F6
X-Received: by 2002:a17:907:75fb:: with SMTP id jz27mr793451ejc.623.1639429561169;
        Mon, 13 Dec 2021 13:06:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4NjlrB/AU0qc2PXB1u/hctD92UOUgZHL1rsQyb7txMh2VUaIkOIe0h8SvIBIMtXdVvLsQghzif+k79HmKhNQ=
X-Received: by 2002:a17:907:75fb:: with SMTP id jz27mr793425ejc.623.1639429560945;
 Mon, 13 Dec 2021 13:06:00 -0800 (PST)
MIME-Version: 1.0
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
 <CALF+zOnA2U6LjDTE8m2REDTMmFVnWkcBkn0ZJQRGULPUjeQW4Q@mail.gmail.com>
 <CALF+zOnmJ0=j8pEMikpxYgLrS10gVZiXfCjBhDz9Je0Qip7wnw@mail.gmail.com> <599331.1639410068@warthog.procyon.org.uk>
In-Reply-To: <599331.1639410068@warthog.procyon.org.uk>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 13 Dec 2021 16:05:25 -0500
Message-ID: <CALF+zO=_DeOHLARqFqZ2qL04PcwBGOxTXf5UUdBNQj29yOSYvw@mail.gmail.com>
Subject: Re: [PATCH] fscache: Need to go round again after processing
 LRU_DISCARDING state
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Dec 13, 2021 at 10:41 AM David Howells <dhowells@redhat.com> wrote:
>
> David Wysochanski <dwysocha@redhat.com> wrote:
>
> > > [  432.921382] BUG: KASAN: use-after-free in
> > > fscache_unhash_cookie+0x9e/0x160 [fscache]^M
>
> I think the patch below is the way to fix this.
>
> David
> ---
> fscache: Need to go round again after processing LRU_DISCARDING state
>
> There's a race between the LRU discard and relinquishment actions.  In the
> state machine, fscache_cookie_state_machine(), the ACTIVE state transits to
> the LRU_DISCARD state in preference to transiting to the RELINQUISHING or
> WITHDRAWING states.
>
> This should be fine, but the LRU_DISCARDING state just breaks out the
> bottom of the function without going round again after transiting to the
> QUIESCENT state.
>
> However, if both LRU discard and relinquishment happen *before* the SM
> runs, one of the queue events will get discarded, along with the ref that
> would be associated with it.  The last ref is then discarded and the cookie
> is removed without completing the relinquishment process - leaving the
> cookie hashed.
>
> The fix is to make sure that the SM always goes back around after changing
> the state.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
> diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
> index d7e825d636e2..8d0769a5ee2b 100644
> --- a/fs/fscache/cookie.c
> +++ b/fs/fscache/cookie.c
> @@ -755,7 +755,7 @@ static void fscache_cookie_state_machine(struct fscache_cookie *cookie)
>                 set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
>                 __fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_QUIESCENT);
>                 wake = true;
> -               break;
> +               goto again_locked;
>
>         case FSCACHE_COOKIE_STATE_DROPPED:
>                 break;
>

Agree and verified with xfstests generic full runs twice with NFSv3.
Prior to this patch with NFSv3 xfstest I'd regularly see the crash:
BUG: KASAN: use-after-free in __fscache_acquire_cookie+0x437
https://marc.info/?l=v9fs-developer&m=163916153103008&w=2
https://marc.info/?l=linux-nfs&m=163917893813589&w=2

Tested-by: Dave Wysochanski <dwysocha@redhat.com>

