Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4104949E862
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 18:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244314AbiA0RJC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 12:09:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56896 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238767AbiA0RJA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 12:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643303340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kAV23rTMcuty4CJFZ8o8ysOxnvRFj2DI1yB1mT746og=;
        b=QU+UARpVft1TH4Ycj9CFqX254OOzM8EVrl3ZtSl6Dm32JTefsVBZbhy/HPfFFespA+mbTR
        N92inGTPutQzpsDrmtG8FbGj739lvdaM7u5zo/Los13xUSThaZNJ09o4q0S2CfBUaczQ+J
        pX2caUc1wui+XiRXE/spsU6KvZ7L4xc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-shGTAKOgM8yUlnc9QcFl7g-1; Thu, 27 Jan 2022 12:08:58 -0500
X-MC-Unique: shGTAKOgM8yUlnc9QcFl7g-1
Received: by mail-qk1-f200.google.com with SMTP id a134-20020ae9e88c000000b0047ebe47102dso2803077qkg.18
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 09:08:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kAV23rTMcuty4CJFZ8o8ysOxnvRFj2DI1yB1mT746og=;
        b=QpSAh+1MYO67rQoeLtdyUfhEyNRkxWnEn7darFVH7K+teR8sp704Ih0++aCIC8nvEJ
         xWOuuYAl4jTNNy1FuCY5Ml4+nReMWbw4lX/Xe8ro0eiNejNUqCxv3zBlKktVTzdhLXgE
         VKKF3lGa79pijl9Ycv1E0JnKzBqwkm9SsfFZG9zNjteuTZ0ZwJc5shb+ot1RxmTh5wH4
         0hlSPAbjy/v50wL+kqwYB0FptpPPYlxpNrUdrmLLtvq34WKb6z6X/qhfU0n9f5SwM3bW
         6FUhX2IZna5KU89rXEO6jQm6TAZH0+uRlUusCDs9/JOzRU1C2HrdFvNWmwC/p6NitzQX
         1qTA==
X-Gm-Message-State: AOAM533jREf5IJ0JN/uY9oUwtUGS4NNOGuT0EnPjSHAvF1Nsjo3Wr2Xu
        Fbku9bRKcYnpbeNugoObNvQPE6LYEOjtitHqQqLYhUvhLw2bYn0D6nHEx+8voaVR0O9Ggn6gGCv
        uj82QL+SvU6GFCSGGILY=
X-Received: by 2002:ac8:44c9:: with SMTP id b9mr3555320qto.524.1643303338469;
        Thu, 27 Jan 2022 09:08:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDu0k2yM0Z7B8jNmnNXJFkDazruS7TZzFMNaHKbWmY0JBs9tIC0IfQuLij5Gmty6LtXXG+Yw==
X-Received: by 2002:ac8:44c9:: with SMTP id b9mr3555294qto.524.1643303338263;
        Thu, 27 Jan 2022 09:08:58 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id a141sm1694826qkc.73.2022.01.27.09.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:08:57 -0800 (PST)
Date:   Thu, 27 Jan 2022 12:08:56 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal " <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        xen-devel@lists.xenproject.org, drbd-dev@lists.linbit.com
Subject: Re: [PATCH 05/19] dm: bio_alloc can't fail if it is allowed to sleep
Message-ID: <YfLRqCMAhLH8xhDD@redhat.com>
References: <20220124091107.642561-1-hch@lst.de>
 <20220124091107.642561-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124091107.642561-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 24 2022 at  4:10P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Remove handling of NULL returns from sleeping bio_alloc calls given that
> those can't fail.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>

