Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30F449E88E
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 18:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238765AbiA0RLo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 12:11:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244389AbiA0RLo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 12:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643303503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xtKZnu3m4MJ1lsPgVyhgN06mFCH9uLK+At7c0q3e4j8=;
        b=LN8FAamK45sm6noJKUN6tg+JuKEjFXTHjCz0Gz3hQXd7xEnG8vCRHb6CYG8/0sito9KieR
        EoA3uFroRZoPvlL+SDdS4cbDbrpWlWUd6YK5HZdf/U3wzh4GlyqcSS/9tB/oQEndPVNawx
        37imUkamyk+Z/2GOH1G55UuYiAToeOc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-V2Hfe1hpPn6rrwYsQFnvTg-1; Thu, 27 Jan 2022 12:11:42 -0500
X-MC-Unique: V2Hfe1hpPn6rrwYsQFnvTg-1
Received: by mail-qk1-f197.google.com with SMTP id p20-20020a05620a22b400b0047ecab0db4fso2879426qkh.2
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 09:11:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xtKZnu3m4MJ1lsPgVyhgN06mFCH9uLK+At7c0q3e4j8=;
        b=IeyHfkkRaVfM06twoqo15UbIJBIsNx5GigJowuaV7CQfgTU+NYU+JjeHOxi7yiKVP5
         VUk9JFUE+yN0R3yVNEC5TrSGoEv2cTXfZZpGYovypwza+J7J/rwuCIS6+vT6We4GTukV
         q8LUbAntEUPRUHlioHWMCKGg3MDZfjNUPF27KmOdP1ZNea+xhknkjJvrwEuB2z3/jtH5
         Jw06PXkAaC4MirTqSPhdvGkMrn7C1Co2Z4Y066KJh82CtykW1F3muatjtmP5uf6sQ5PO
         8Ek/AGBKwcyQ25bsYeVuFxD8EWs7qDP5Jjk+d4mHb7/cUa2cyjmMRq315ieq59iIriUq
         Kafg==
X-Gm-Message-State: AOAM531f4qMfNpuEVs2RPlmiUh3v5lsTYqaTxQj3tjvauySZ39zI6M1X
        mzUNygX2JignbK7bptN1e9Ck0gMzhtkS7weI8DbqWhhDq2IXmw3NUdMrngsUowOoJSVGVG8L2os
        AC1HBE9BLngKxVd6sgEk=
X-Received: by 2002:ad4:5968:: with SMTP id eq8mr3808168qvb.80.1643303501889;
        Thu, 27 Jan 2022 09:11:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztPCW/ls/HGsD9xe/WMaahh4UjrJsfEVpwqwRI5tHMnXcgyiZLuuvrhgvmY/MRUsNQeYYfvQ==
X-Received: by 2002:ad4:5968:: with SMTP id eq8mr3808154qvb.80.1643303501730;
        Thu, 27 Jan 2022 09:11:41 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id w8sm119796qti.21.2022.01.27.09.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:11:41 -0800 (PST)
Date:   Thu, 27 Jan 2022 12:11:40 -0500
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
Subject: Re: [PATCH 08/19] dm-thin: use blkdev_issue_flush instead of open
 coding it
Message-ID: <YfLSTPB7UUZKqQKL@redhat.com>
References: <20220124091107.642561-1-hch@lst.de>
 <20220124091107.642561-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124091107.642561-9-hch@lst.de>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 24 2022 at  4:10P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Use blkdev_issue_flush, which uses an on-stack bio instead of an
> opencoded version with a bio embedded into struct pool.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>

