Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E370E6456F1
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Dec 2022 10:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiLGJ6t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Dec 2022 04:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLGJ6s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Dec 2022 04:58:48 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956772C13C
        for <linux-nfs@vger.kernel.org>; Wed,  7 Dec 2022 01:58:47 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-381662c78a9so180676437b3.7
        for <linux-nfs@vger.kernel.org>; Wed, 07 Dec 2022 01:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3IU7j/fGQw488nTr3UdYtHsBo8tWefZ/LoILwoUa3Eg=;
        b=opCUybT63u6jk4pKUL6KXy7eDxizeFUgxgC64OdAw0b05FLxEWolyTezoAENX0MGxA
         6Sog89eCS+JfLcJWDpfDUY5JQK9O4Ya5Iu75ex3R8WJH/gD4l+d7R6dZKSNFS6re5LFD
         Ou6xXcdSjgm+PpTDHtp+H0dzkZW8r0C6bb6Aezchx6WkdJ3cL/ToIGdWzH301gVh4uOz
         aJ3mtHAvWoGo+XaKQea6sC6nEEGxbrQBh+CmCG/OJwNjK0QnEeK0ExD7jxxhNqhigm2C
         fox5XCZTTcWNaKOkIX1yZlO2r7TvLO1VVNpTZnnL/3C2JHB5A5b3+fvIerkDUgSceZlZ
         igxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IU7j/fGQw488nTr3UdYtHsBo8tWefZ/LoILwoUa3Eg=;
        b=beIlm63qGeRef4cAaOIRWUV4NfR/mQcXEqUnMtfSR56GiaQ2QnWXtp5UYeAA9AC+JI
         8nXMEgN7UHJ3Nq7vNZ1X0N5in0k3/cY4huTO9nH6wg6YskkzUNPsKAF9KiR8aYUQuyTN
         K3LAS/LrAg3ePTuL7V2LkpRzfw8AmJHlUWGgvg/c/8ox32e1R6NM0cPn3ECGCD9r5zvT
         0xkl/KhYFcMggcskQXcLnA57jNQ1262RkqrvRbCkVaTbiFpvyO9KL+8GfA9bjmpZBX7m
         mdBR1id2J073k9pabvXYP3JTFK7yonnbCZ7cJc+xSpVSxmyG9VFtfClN+FKChjYTHHCt
         3cWQ==
X-Gm-Message-State: ANoB5pmA7rfdci2JtPJCrSxlLENy5wao/Hiiw7xh/UzrmmZbyHpmyPyd
        M3B6XH84yEJZ7LyV4E6Mx6ldWbAkLO/5x+nPsZuo6w==
X-Google-Smtp-Source: AA0mqf7qMpRk93JQT2/H1E8tobsiY/6Z8KxYAXhkxymLEUSVqHyGr/QSco7kNP9PSxRtb46LShntC5AWTQAO7sSF/hQ=
X-Received: by 2002:a81:f14:0:b0:3f1:f4b1:e197 with SMTP id
 20-20020a810f14000000b003f1f4b1e197mr9161371ywp.324.1670407126795; Wed, 07
 Dec 2022 01:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20221117142915.1366990-1-dwysocha@redhat.com>
In-Reply-To: <20221117142915.1366990-1-dwysocha@redhat.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Wed, 7 Dec 2022 09:58:10 +0000
Message-ID: <CAPt2mGOYeJNbqzb8RD94BG0Y8HpHja_UCG6kifQR1kNuWyiMcg@mail.gmail.com>
Subject: Re: [PATCH v2] fscache: Fix oops due to race with cookie_lru and use_cookie
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Daire Byrne <daire.byrne@gmail.com>,
        Benjamin Maynard <benmaynard@google.com>,
        linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I have also now tested this v2 patch and can confirm that it also
fixes the race in fscache that we were reliably able to reproduce with
our (re-export) workloads..

Tested-by: Daire Byrne <daire@dneg.com>

Daire

On Thu, 17 Nov 2022 at 14:30, Dave Wysochanski <dwysocha@redhat.com> wrote:
>
> If a cookie expires from the LRU and the LRU_DISCARD flag is set,
> but the state machine has not run yet, it's possible another thread
> can call fscache_use_cookie and begin to use it.  When the
> cookie_worker finally runs, it will see the LRU_DISCARD flag set,
> transition the cookie->state to LRU_DISCARDING, which will then
> withdraw the cookie.  Once the cookie is withdrawn the object is
> removed the below oops will occur because the object associated
> with the cookie is now NULL.
>
> Fix the oops by clearing the LRU_DISCARD bit if another thread
> uses the cookie before the cookie_worker runs.
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000008
>   ...
>   CPU: 31 PID: 44773 Comm: kworker/u130:1 Tainted: G     E    6.0.0-5.dneg.x86_64 #1
>   Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
>   Workqueue: events_unbound netfs_rreq_write_to_cache_work [netfs]
>   RIP: 0010:cachefiles_prepare_write+0x28/0x90 [cachefiles]
>   ...
>   Call Trace:
>    netfs_rreq_write_to_cache_work+0x11c/0x320 [netfs]
>    process_one_work+0x217/0x3e0
>    worker_thread+0x4a/0x3b0
>    ? process_one_work+0x3e0/0x3e0
>    kthread+0xd6/0x100
>    ? kthread_complete_and_exit+0x20/0x20
>    ret_from_fork+0x1f/0x30
>
> Fixes: 12bb21a29c19 ("fscache: Implement cookie user counting and resource pinning")
> Reported-by: Daire Byrne <daire.byrne@gmail.com>
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
>  fs/fscache/cookie.c            | 8 ++++++++
>  include/trace/events/fscache.h | 2 ++
>  2 files changed, 10 insertions(+)
>
> diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
> index 451d8a077e12..bce2492186d0 100644
> --- a/fs/fscache/cookie.c
> +++ b/fs/fscache/cookie.c
> @@ -605,6 +605,14 @@ void __fscache_use_cookie(struct fscache_cookie *cookie, bool will_modify)
>                         set_bit(FSCACHE_COOKIE_DO_PREP_TO_WRITE, &cookie->flags);
>                         queue = true;
>                 }
> +               /*
> +                * We could race with cookie_lru which may set LRU_DISCARD bit
> +                * but has yet to run the cookie state machine.  If this happens
> +                * and another thread tries to use the cookie, clear LRU_DISCARD
> +                * so we don't end up withdrawing the cookie while in use.
> +                */
> +               if (test_and_clear_bit(FSCACHE_COOKIE_DO_LRU_DISCARD, &cookie->flags))
> +                       fscache_see_cookie(cookie, fscache_cookie_see_lru_discard_clear);
>                 break;
>
>         case FSCACHE_COOKIE_STATE_FAILED:
> diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
> index c078c48a8e6d..a6190aa1b406 100644
> --- a/include/trace/events/fscache.h
> +++ b/include/trace/events/fscache.h
> @@ -66,6 +66,7 @@ enum fscache_cookie_trace {
>         fscache_cookie_put_work,
>         fscache_cookie_see_active,
>         fscache_cookie_see_lru_discard,
> +       fscache_cookie_see_lru_discard_clear,
>         fscache_cookie_see_lru_do_one,
>         fscache_cookie_see_relinquish,
>         fscache_cookie_see_withdraw,
> @@ -149,6 +150,7 @@ enum fscache_access_trace {
>         EM(fscache_cookie_put_work,             "PQ  work ")            \
>         EM(fscache_cookie_see_active,           "-   activ")            \
>         EM(fscache_cookie_see_lru_discard,      "-   x-lru")            \
> +       EM(fscache_cookie_see_lru_discard_clear,"-   lrudc")            \
>         EM(fscache_cookie_see_lru_do_one,       "-   lrudo")            \
>         EM(fscache_cookie_see_relinquish,       "-   x-rlq")            \
>         EM(fscache_cookie_see_withdraw,         "-   x-wth")            \
> --
> 2.31.1
>
