Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4068F2FFFA8
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 11:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbhAVKAW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jan 2021 05:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbhAVKAL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jan 2021 05:00:11 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE51C0617A7
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jan 2021 01:50:56 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id h11so2672204vsa.10
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jan 2021 01:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HqmXNnhOvww/se+uqGpbG2r6Wj6LjG3RtqIoCGkH17k=;
        b=Bqt3b8b7kp2zQsjWv07hRffU5ZdsKDvLLb7CTBAQdsqsw2qRHDDv257TenVn8PQ0eh
         7Faa1tfN668wJ7fnNrENLH7AoZ+Yz7eIgCNhVFIajtS786Ovqkv97Wr+V6k7E2k62MxY
         +zFfZILJZPCMb2mgb5PIp7UG3mhyPOfuQoIscUoL7KcMmyArbnUdaC0O1T1v40yAIWCH
         kb3Y/uHtCaFYyztgZ4c9IexZUktiJQ8TjmoyT1uO1aGHIVI3c5zzudaDyrdeK9RYpTX9
         cIrmQQoHomR+23NhDIIBOqW/csi0rItWAjz9B7IdKkogQi35H0szd9iVKvGtnr3lgOid
         vpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HqmXNnhOvww/se+uqGpbG2r6Wj6LjG3RtqIoCGkH17k=;
        b=oOpvmEnwxaB5ZghDlxu5nTNifUw9I7u6rMKpEpkSHpyjbtvIjvIlBOHTj0LX94ayNm
         BvmEp9uc6BXiJRAwCAl5MXl8ggH0XI2Sqo/5+ZP4SLlZwBS5gwhXlyLgZW34VhZTjFxF
         tMjzho8PfFk9gJlexn9rvnV1HKaBIc4nct+o2qKod8rIyXCd/gTeq6mYvQ5sLWcSl449
         KVvVPKVqzHDP9VWlWnha+DAewMOA/JKaUx45fDWn3GJ+D9s5vLX179I/1cWmcWbJ45/J
         2I5z+T0G3y3uuMB/pj7HrGyAL+9+erAXrfQxSCKoAdUeJ3CSxA5KWSPs0j9+jMlJyeky
         1Y5w==
X-Gm-Message-State: AOAM530Bg2dLPYA4qyQExNyalc961KuuB7c8BG+7Qzcl9kHBa2nWIAxp
        9Y9ruc2o0s8aLNb+9eJrLoN2bPXZBvvuXyQciX/yoQ==
X-Google-Smtp-Source: ABdhPJzQkvbtXPAnaOXaJNiT2RO7BkT9eaJIQxnmfKyCTkaPtmRekmQxRuUvkDQuHQpmYuEkgvFe4kOJ3FrZfm16N6Y=
X-Received: by 2002:a67:f997:: with SMTP id b23mr235525vsq.34.1611309056136;
 Fri, 22 Jan 2021 01:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com> <20210122092824.20971-3-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20210122092824.20971-3-guoqing.jiang@cloud.ionos.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Jan 2021 10:50:20 +0100
Message-ID: <CAPDyKFoPL4drfh3efKXyhXLp6Ce+j=oHwNd9VnVP4aaKQ0zmDQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] block: remove unnecessary argument from blk_execute_rq
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ide@vger.kernel.org, target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 22 Jan 2021 at 10:28, Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> We can remove 'q' from blk_execute_rq as well after the previous change
> in blk_execute_rq_nowait.
>
> And more importantly it never really was needed to start with given
> that we can trivial derive it from struct request.
>
> Cc: linux-scsi@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-ide@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-nvme@lists.infradead.org
> Cc: linux-nfs@vger.kernel.org
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

[...]

>  drivers/mmc/core/block.c          | 10 +++++-----

[...]

From mmc point of view, please add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

At the moment I don't think this will conflict with any changes to
mmc, but if that happens let's sort it then...

Kind regards
Uffe
