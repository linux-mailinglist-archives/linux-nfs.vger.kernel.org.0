Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA88E75F9B1
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jul 2023 16:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjGXOWY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jul 2023 10:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjGXOWX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jul 2023 10:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C32E64
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jul 2023 07:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690208499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a7+y4J72Q0kEFtJFZr3ToqDneS+Q2vn9lfoVlJ352mE=;
        b=ftoi7EGQNO/mQ0vUjh5ZyQHZzyMFeBJwQ66QOzFlAsI10pI36CYrYhbAtMgIlo0H6keZqa
        Q9uP/LB+xE3Yzxbb2oQY0PelbcyyNnw9N34v+GgXR6AibRxw4qpVHPTmZAOFhYNjP2JlsX
        ibvkGVkE/1W+th+8mvkx4Yog8ei9bNE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-qz5re7l2OkqkGJ3eqPQ9Yw-1; Mon, 24 Jul 2023 10:21:38 -0400
X-MC-Unique: qz5re7l2OkqkGJ3eqPQ9Yw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26824c32755so495666a91.2
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jul 2023 07:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690208496; x=1690813296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7+y4J72Q0kEFtJFZr3ToqDneS+Q2vn9lfoVlJ352mE=;
        b=ZDMmcGE7RGVb4B3lZSMjB2texgekUicMSeV5rVs9gw3WmfdkYyKhhHw20b5/MnSFm4
         +qlEtcYbwHIjX0XVKPdH9C85lCjDDWseuOwfB7lauEufyvbFgaZUr/9OWzr7GTru1dLT
         h3DoFVBIRa7l6V7y+j2iiRk+C2eGJJfSYHzmRAG69BeVGzWDKm1HdzS7f3Q5JWHtAITr
         STxdQXjD8wfcY381EwgQoFqhB1ayfJ4U+8nqu6twATzz4qXndXq5g1CAxES1RKKXemgW
         QLfDuM7rJEUKxfVBOg7mZAyvcLRZaSHZihgHmJmwcrRentTPOj9991igOM4Zl/mfurRl
         pYTw==
X-Gm-Message-State: ABy/qLac/z0p6/JjP+nXt+KlJB6sQVGzbow8DmnzlaV7QPSbs//zyRtY
        ww1jzjPPgZX4NfZbu1Vcl8qDj80JOXmu6+cY7pY3tu4hyL+KYHLzXWGQSP1BeEYy4OBGdGDIaR5
        1J41bWVckZ78zGZLmFSwBsrqL5vvN7FCwfqnROxJv2CTF86M=
X-Received: by 2002:a17:90b:1946:b0:268:2621:6a41 with SMTP id nk6-20020a17090b194600b0026826216a41mr1196355pjb.45.1690208496403;
        Mon, 24 Jul 2023 07:21:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGuDMFWdU3qGv/NZSSOBNW9kWUCS3q97mp2l1nbTr0wImLmNrCBvwj+EKwCJCdxYKm0PhLqITGqeq58nBHRzHs=
X-Received: by 2002:a17:90b:1946:b0:268:2621:6a41 with SMTP id
 nk6-20020a17090b194600b0026826216a41mr1196343pjb.45.1690208496104; Mon, 24
 Jul 2023 07:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230608214137.856006-1-dwysocha@redhat.com>
In-Reply-To: <20230608214137.856006-1-dwysocha@redhat.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 24 Jul 2023 10:20:59 -0400
Message-ID: <CALF+zOk+r18aDDJ19Ngt2N0G3CPeuXD8vVh7cqZ5s+Up9Kw4Uw@mail.gmail.com>
Subject: Re: [Linux-cachefs] [PATCH] netfs: Only call folio_start_fscache()
 one time for each folio
To:     David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 8, 2023 at 5:41=E2=80=AFPM Dave Wysochanski <dwysocha@redhat.co=
m> wrote:
>
> If a network filesystem using netfs implements a clamp_length()
> function, it can set subrequest lengths smaller than a page size.
> When we loop through the folios in netfs_rreq_unlock_folios() to
> set any folios to be written back, we need to make sure we only
> call folio_start_fscache() once for each folio.  Otherwise,
> this simple testcase:
>   mount -o fsc,rsize=3D1024,wsize=3D1024 127.0.0.1:/export /mnt/nfs
>   dd if=3D/dev/zero of=3D/mnt/nfs/file.bin bs=3D4096 count=3D1
>   1+0 records in
>   1+0 records out
>   4096 bytes (4.1 kB, 4.0 KiB) copied, 0.0126359 s, 324 kB/s
>   cat /mnt/nfs/file.bin > /dev/null
>
> will trigger an oops similar to the following:
> ...
>  page dumped because: VM_BUG_ON_FOLIO(folio_test_private_2(folio))
>  ------------[ cut here ]------------
>  kernel BUG at include/linux/netfs.h:44!
> ...
>  CPU: 5 PID: 134 Comm: kworker/u16:5 Kdump: loaded Not tainted 6.4.0-rc5
> ...
>  RIP: 0010:netfs_rreq_unlock_folios+0x68e/0x730 [netfs]
> ...
>  Call Trace:
>   <TASK>
>   netfs_rreq_assess+0x497/0x660 [netfs]
>   netfs_subreq_terminated+0x32b/0x610 [netfs]
>   nfs_netfs_read_completion+0x14e/0x1a0 [nfs]
>   nfs_read_completion+0x2f9/0x330 [nfs]
>   rpc_free_task+0x72/0xa0 [sunrpc]
>   rpc_async_release+0x46/0x70 [sunrpc]
>   process_one_work+0x3bd/0x710
>   worker_thread+0x89/0x610
>   kthread+0x181/0x1c0
>   ret_from_fork+0x29/0x50
>
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
>  fs/netfs/buffered_read.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index 3404707ddbe7..0dafd970c1b6 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -21,6 +21,7 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *=
rreq)
>         pgoff_t last_page =3D ((rreq->start + rreq->len) / PAGE_SIZE) - 1=
;
>         size_t account =3D 0;
>         bool subreq_failed =3D false;
> +       bool folio_started;
>
>         XA_STATE(xas, &rreq->mapping->i_pages, start_page);
>
> @@ -53,6 +54,7 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *=
rreq)
>
>                 pg_end =3D folio_pos(folio) + folio_size(folio) - 1;
>
> +               folio_started =3D false;
>                 for (;;) {
>                         loff_t sreq_end;
>
> @@ -60,8 +62,10 @@ void netfs_rreq_unlock_folios(struct netfs_io_request =
*rreq)
>                                 pg_failed =3D true;
>                                 break;
>                         }
> -                       if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->f=
lags))
> +                       if (!folio_started && test_bit(NETFS_SREQ_COPY_TO=
_CACHE, &subreq->flags)) {
>                                 folio_start_fscache(folio);
> +                               folio_started =3D true;
> +                       }
>                         pg_failed |=3D subreq_failed;
>                         sreq_end =3D subreq->start + subreq->len - 1;
>                         if (pg_end < sreq_end)
> --
> 2.31.1
>
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
>

David,

Just wanted to ping a friendly reminder on this patch as I didn't see
any response or in any tree that I could find.

Also, there is a Red Hat bugzilla for it, so patch should have had:
Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2210612

