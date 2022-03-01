Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC6A4C8F2E
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Mar 2022 16:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiCAPfz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Mar 2022 10:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiCAPfz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Mar 2022 10:35:55 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F1EA9962
        for <linux-nfs@vger.kernel.org>; Tue,  1 Mar 2022 07:35:12 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id t14so22323128ljh.8
        for <linux-nfs@vger.kernel.org>; Tue, 01 Mar 2022 07:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=o9t0gIto97JzMdXIJEeW6gdCw7gjDnbydaCp7ezxmfM=;
        b=Apa45TKip7j64EOY4MLBGmxuYuRwrOO04pU4WFuNXojFLapxHtuY57tM7CROzaMHx6
         z6RcgEJglgVyCSYqtWkC13MPQ52a/1eAgRdyatVCeN1epUWKkcoh97jb+9VZF0inynIW
         +qvnyUIUDtzymAgb7mePEPTe96B20CjAdxHWdM6VJbYpigc0nY8XV8gg0hmLGZlgoMRu
         05wKS1Qc1B1Ayue+oebMVXpo+xVaCE8zzylOx6pu0em5Xf92rh0bk6E/EXu6WuSXTOgT
         +Drk4Uk4v0DvaLFDJB/d1CNpk+25kzj3csi/A+EzOhbcJHKw+iGkeJ4VzeQIlIbklgoI
         UFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=o9t0gIto97JzMdXIJEeW6gdCw7gjDnbydaCp7ezxmfM=;
        b=6LGKHYT7R4VFlYVMY/89TYzzqFPDUigg5qHL86fBOczC2Qh2Xcc6d61tOJ77TpXDoh
         Q95MFoEVAm360iPtQgzgneo5UGZo/eXI10+IEfti3RwtASgJJbc1Z1iTkHLbqBQkZPaP
         Nu2+qSJaA8nPs+17He3ReSxMFuDmnsM4y2YzTvtTjciN4KcIUdXSGp/HqbYnKoSm1TzL
         7DhaXZ3q0vhzdLWfBw/28cnQffW+EP0FvpiKrYv3SZottSXy+bxHJ5weKNOY5FsyI9I4
         USgZmsP6lthmaLXOBYEVnZu/6gO5ZWNT/7+y9RtIB5f/2r2yqvwDLKKjr8+gkRNzImC8
         lnEQ==
X-Gm-Message-State: AOAM531Kc2bFc8YlkLVd5wUuJm79SYoTvXrUt59mt8l1dfFGCNEniDH5
        h6YNnza8vziQ3Fbyz+A9OdolmvjP0nlgdzKl+TWLgdU0XKI=
X-Google-Smtp-Source: ABdhPJwAlJQDl3P+7WWR8+ncncwcdUv8a4rRioYzUaXNoRfKOo5Dyon6+yJfyZWYtMZWQwQP8VHOT5PXYWdZRwC5TDw=
X-Received: by 2002:a2e:b444:0:b0:244:c6ff:4894 with SMTP id
 o4-20020a2eb444000000b00244c6ff4894mr17313845ljm.457.1646148908121; Tue, 01
 Mar 2022 07:35:08 -0800 (PST)
MIME-Version: 1.0
References: <CAAmbk-f=Y_k1h-5b3yrGUj36LtL+ZU=J-sC01mrDj83wyKBMkg@mail.gmail.com>
In-Reply-To: <CAAmbk-f=Y_k1h-5b3yrGUj36LtL+ZU=J-sC01mrDj83wyKBMkg@mail.gmail.com>
From:   Chris Chilvers <chilversc@gmail.com>
Date:   Tue, 1 Mar 2022 15:34:56 +0000
Message-ID: <CAAmbk-fqYXQupHEyPk_iONzaNXRuH6Dz24gZw9Bvswx2X8EWgg@mail.gmail.com>
Subject: Re: [BUG] FS-Cache write but no read when using sync
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

You can disregard this message. I didn't realise there was a separate
mailing list for cachefs. I've re-posted the message to the correct
mailing list.

-- Chris

On Mon, 28 Feb 2022 at 19:24, Chris Chilvers <chilversc@gmail.com> wrote:
>
> While trying the new FS-Cache implementation using the 5.17-rc5 kernel on
> Ubuntu 21.10 I ran into an issue where it appears that FS-Cache was not being
> used when the sync mount option is enabled.
>
> While monitoring /proc/fs/fscache/stats it was observed there were high writes
> to the cache volume, but no reads:
>
>     IO     : rd=0 wr=344713665
>
> Further tracing of /sys/kernel/debug/tracing/events/fscache/fscache_access shows
> a large number of io_write operations, but no io_read operations.
>
> The volume did fill up and perform culling as expected.
>
> When the mount option was changed from sync to async the cache performed as
> expected and a mixture of io_write and io_read was observed.
>
> -- Chris
