Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8619046F1FB
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Dec 2021 18:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243034AbhLIRgd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Dec 2021 12:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243033AbhLIRga (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Dec 2021 12:36:30 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB64AC061746
        for <linux-nfs@vger.kernel.org>; Thu,  9 Dec 2021 09:32:56 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r11so21447889edd.9
        for <linux-nfs@vger.kernel.org>; Thu, 09 Dec 2021 09:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iqExJZ9/DphBTKULUzi0rda5Ww/lFJEMJ0HrtECPjTI=;
        b=CEZX4drLnp80p9b9oVxK0f0qT2WA3YF+B1Tl8CQVWg2uGKK6+gQz0h/GPS2FyiNNJ9
         gAKRuC48E81Hb/mGX0sY3phjIF/WMv16b9bipyIo+rIOFDAbKwrmyJ7HqNkTia2gkVbu
         /I1NAgDWldKvVVC+e1z0jNAfGMMlQioj2HEiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iqExJZ9/DphBTKULUzi0rda5Ww/lFJEMJ0HrtECPjTI=;
        b=zTElzGBPIDO9l+1Dpwn6ZL0YKp+ERZzGgHH26WGR/xhLvDIfw48ZA8CdhBb+IFlVES
         3qJ0mR+Uq4HqV3S2UEu32l8I+q8XOcv0FOwFCgRENl+1pdr3otSDwGYcg9dBC8h7PMgv
         DaUOiuaFmzaiCpt5blsXPWX5bZYyMtUMyAn3hSP80dZ0dqc3R1uOol30WCI7oyFp1h2q
         9pshXKcludEjpQe5oDznryjJJcWTkeu30Bpu9xdUY9d5CPcrUIjEh4hTKJefY8uLMFYt
         IWRro/+BKJEnLEmg3wNfIKniU+WerkxtD32rOnnt2ABw2mg5IqPwZeUM9oG17EOYt7fD
         kMcQ==
X-Gm-Message-State: AOAM5321VJ5B79/+ZgqPzmBFT50+XpI7W+bUBPwA+hqBzw8aw4dEzZZk
        hufOJI9jghFrxXgcIw4LxXYZCV5i6J6zJbkD
X-Google-Smtp-Source: ABdhPJwwbKyGwB3zkyGBCAZEXquOe+tDStRc4L4+JQEm4XDW2A9Cw8h4++ntQUn7QcUtR6nS3Myjzg==
X-Received: by 2002:a50:9e0f:: with SMTP id z15mr30672748ede.278.1639070993967;
        Thu, 09 Dec 2021 09:29:53 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id nd22sm237406ejc.98.2021.12.09.09.29.53
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 09:29:53 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso7137585wms.2
        for <linux-nfs@vger.kernel.org>; Thu, 09 Dec 2021 09:29:53 -0800 (PST)
X-Received: by 2002:a05:600c:22ce:: with SMTP id 14mr8659906wmg.152.1639070533785;
 Thu, 09 Dec 2021 09:22:13 -0800 (PST)
MIME-Version: 1.0
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
 <163906891983.143852.6219772337558577395.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906891983.143852.6219772337558577395.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Dec 2021 09:21:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgejk2DA53dkzs6NquDbQk5_r6Hw8_-RJQ0_njNijKYew@mail.gmail.com>
Message-ID: <CAHk-=wgejk2DA53dkzs6NquDbQk5_r6Hw8_-RJQ0_njNijKYew@mail.gmail.com>
Subject: Re: [PATCH v2 10/67] fscache: Implement cookie registration
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 9, 2021 at 8:55 AM David Howells <dhowells@redhat.com> wrote:
>
> +               buf = (u32 *)cookie->inline_key;
> +       }
> +
> +       memcpy(buf, index_key, index_key_len);
> +       cookie->key_hash = fscache_hash(cookie->volume->key_hash, buf, bufs);

This is actively wrong given the noise about "endianness independence"
of the fscache_hash() function.

There is absolutely nothing endianness-independent in the above.
You're taking some random data, casting the pointer to a native
word-order 32-bit entity, and then doing things in that native word
order.

The same data will give different results on different endiannesses.

Maybe some other code has always munged stuff so that it's in some
"native word format", but if so, the type system should have been made
to match. And it's not. It explicitly casts what is clearly some other
pointer type to "u32 *".

There is no way in hell this is properly endianness-independent with
each word in an array having some actual endianness-independent value
when you write code like this.

I'd suggest making endianness either explicit (make things explicitly
"__le32" or whatever) and making sure that you don't just randomly
cast pointers, you actually have the proper types.

Or, alternatively, just say "nobody cares about BE any more,
endianness isn't relevant, get over it".

But don't have functions that claim to be endianness-independent and
then randomly access data like this.

              Linus
