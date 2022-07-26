Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F261581837
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 19:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiGZRQ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 13:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiGZRQ7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 13:16:59 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3141F1A04C
        for <linux-nfs@vger.kernel.org>; Tue, 26 Jul 2022 10:16:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id q23so10393467lfr.3
        for <linux-nfs@vger.kernel.org>; Tue, 26 Jul 2022 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4jhcdp/3tGE30Y8lsXkhUzIMOQ7pq2o374TyaQfvuy4=;
        b=ljtebOTm04xgawEBWUHCjD3hSpl8GjD+Y3MYPc7KORUHPODwkAn/VDrBYlULAqPcIQ
         +bAjsYMPpC9KVeg1k9/YskIIlSKaMfaguxY/QpxFVANb+7D8Q0O5Fl23n5qcD485VnHT
         tuu/FGOAr7GxI6jfqumpNN/VmadqHl7qKDmnRIHzoHqVqzGz3SWoTGwCNEN35w922ujB
         jHA5Zflo9aFo7RAuTgzqw9tGe/56zZY6s/ld0qHMXPUDUtLxSd7GuReDSvGx8HG0R0ab
         SGOjIfJEX3d/1Vkuv87oOqeCidLjsCFhUhxtuSRtyeVYqOAuEJ6Cw7pvvba5BjLy5PEU
         tUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4jhcdp/3tGE30Y8lsXkhUzIMOQ7pq2o374TyaQfvuy4=;
        b=Cq6rYrcPezZmQhloX0qAAXl10zrZj0guT9aeQEp9Duz4RpjSdIRNC1K/BYycd+ylyX
         NRjo3yQbtwUMccFg1ftwU5BAU1OH3heaSw8qOg5aHChObzKUxvWQDg8X1SrHqTxMaSji
         GEuwBAKehNqEZUR1SooqCokU9saHHX2uvsdXMsO1NA9aR0sSTM5xa428z0jAlO1L5ICt
         +NrK5Ypn6GyL5wqMJq2gScUMiWx8JtYaTSPdyjqC2uZz17LtzvgjC0xBx1aVBHHZ3oao
         kFtIbZ/yJFr8EepNMqpOyZ48Kz/n2GuPcr/8lsQ1FJ7RwWpbqBDLnQ29zDX08zS4Tknu
         YwrA==
X-Gm-Message-State: AJIora8q6LLGN7F2hKnv82vAIYjZb8F7E/KbNx9cx5mLhRfR+3zjXLoJ
        P75ttdGlLZet6nft7IFseqCAm5kk4tFG+SxdHlCCpD8pH10=
X-Google-Smtp-Source: AGRyM1tLRUTThfdm/aLOxp7lxaEWxS6MyPCQSc2DgpzKcf+sRUyalUUJEa2qhP5D0RnHvV2812dt1N6+KDm9CMdphlg=
X-Received: by 2002:a05:6512:159d:b0:48a:9c0b:752a with SMTP id
 bp29-20020a056512159d00b0048a9c0b752amr2689511lfb.321.1658855815909; Tue, 26
 Jul 2022 10:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAD15GZd=sxsXiNmuN-FpRk3E_cKRF_CTLqxd5XJ4KhtON4XkPQ@mail.gmail.com>
 <CAD15GZe1__nJ6SfAr1zs4Vq4za9D=FP__SotyS37RVh=2OWu-g@mail.gmail.com>
In-Reply-To: <CAD15GZe1__nJ6SfAr1zs4Vq4za9D=FP__SotyS37RVh=2OWu-g@mail.gmail.com>
From:   Jan Kasiak <j.kasiak@gmail.com>
Date:   Tue, 26 Jul 2022 13:16:44 -0400
Message-ID: <CAD15GZdCYTr0Xfn1-n-aXf5FxLDR-zrYR2TutHk_4RRbP6+pVA@mail.gmail.com>
Subject: Re: NLM 4 Infinite Loop Bug
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

Even after applying the above two patches, I have discovered a new set
of NLM 4 requests that break lockd.

Unfortunately, I don't have enough experience to suggest a fix, but
would be glad to test anyone's attempt.

All requests are non-blocking.

Scenario A
=========
lock(offset=UINT64_MAX, len=100) - GRANTED
free_all() - never finishes and lockd thread is stuck busy looping

Scenario B
========
lock(svid=1, offset=UINT64_MAX, len=100) - GRANTED

test(svid=2, offset=UINT64_MAX, len=50) - DENIED
correct, holder offset, len are (UINT64_MAX, 100)

test(svid=2, offset=75, len=10) - DENIED
wrong, because holder (offset, len) are wrong (UINT64_MAX, 100),
because the above
lock overflows during comparison to (49, 50)

Scenario C
========
lock(svid=1, offset=UINT64_MAX, len=100) - GRANTED

test(svid=2, offset=UINT64_MAX, len=50) - DENIED
correct, holder offset, len are (UINT64_MAX, 100)

unlock(svid=1, offset=UINT64_MAX, len=50) - GRANTED
weird, because it has now created a lock at (offset=UINT64_MAX + 50, len=50)
not sure what the correct behavior should be here - FBIG error?

test(svid=2, offset=75, len=10) - DENIED
wrong, because holder offset, len are wrong (49, 50), because the above
unlock has overflowed the offset

-Jan

On Wed, Jul 20, 2022 at 4:01 PM Jan Kasiak <j.kasiak@gmail.com> wrote:
>
> Applying two commits from the Linux master branch seems to have fixed
> the problem:
>
> aec158242b87a43d83322e99bc71ab4428e5ab79
> 1197eb5906a5464dbaea24cac296dfc38499cc00
>
> -Jan
>
> On Wed, Jul 20, 2022 at 2:46 PM Jan Kasiak <j.kasiak@gmail.com> wrote:
> >
> > Hi all,
> >
> > I'm writing my own NFS client, and while trying to test it, I've come
> > across a way to get the lockd thread into an infinite loop and stop
> > accepting any new requests.
> >
> > Kernel Version: Linux ubuntu-jammy 5.15.0-41-generic
> >
> > The client is a python program, and it does not run rpcbind, NLM, etc...
> >
> > I issue an NM_LOCK (procedure 22) request with block set to false, and
> > get a GRANTED reply.
> >
> > I then issue a FREE_ALL (procedure 23) request, and the lockd thread
> > gets stuck in nlm_traverse_locks - it matches the host, calls
> > nlm_unlock_files, and then jumps to the again label, and repeats this
> > loop forever.
> >
> > It's not clear to me who is supposed to unset the host from the lock?
> > Any pointers as to why there is a jump to again?
> >
> > Thanks,
> > -Jan
