Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770A349E886
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 18:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244326AbiA0RLL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 12:11:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244374AbiA0RLK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 12:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643303470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hISkPgWXBvxaPJR1A6cjvL239jVaZB/M99kE10NpdT4=;
        b=gwmGBaqmswElrrwxP/iaVlPUR9CRA0TxcOunX1m1I/QdVv+duNdNabLhm2veREWyHjK1hO
        ZjN4ggVKjT10BvWXIX+WHltZK9vylnx5iQ6Tx52PUs4fhXmWdf4i/LoH38o15io+eDeh32
        q92uQCcTJH5KdT6YHANyW4Hb1aSBesM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-F5hdBFVENCu_jhaQA8ZIVQ-1; Thu, 27 Jan 2022 12:11:07 -0500
X-MC-Unique: F5hdBFVENCu_jhaQA8ZIVQ-1
Received: by mail-qk1-f198.google.com with SMTP id k190-20020a37a1c7000000b0047d8a74b130so2845081qke.10
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 09:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hISkPgWXBvxaPJR1A6cjvL239jVaZB/M99kE10NpdT4=;
        b=L4qerr8vWMVovSuPdgXU3Zq3Dx2ncx0uNNRtDO8SaOMHrAmJ1EbQAO9DvUdQ46W3Yd
         qSVaWLyqQnM+pOGKu67CX+3P4pF08oHrD5yhVEz/xKh5wtssN1gi1H/PLan1BSwT5j4Z
         A0kv8Ip9+4v5NRQSU5nylE+OTCMYeIfEuHFrF7IyDD1qZk8g+VHC0wocyagnThkY8Lgg
         p3BRGwJZDI63ydYuvsUiJ9rSjSCdzwhbl2PxWxgslBttQdDVTlFT/prKkoLR/bOZCv7B
         e7i3nOx16oILbT3enXsERsZXWCZswIR8b3ITGuyQUBEAEsG6wo5zCH9XLpoyapu3RbDK
         tPFg==
X-Gm-Message-State: AOAM532WfEhc8nV/wkxFA8MgJwqrhgrggaURdDIQxGp93vjRwc2+slwS
        vFF+gIEDbbc8xmvTf5p2FLVYPKKmQ9FS09HNyUigFSz/puvYKdqNf88HAg3r2WacBKeY2lAv7u7
        C1z11AcyK837apHvpn/k=
X-Received: by 2002:a05:6214:c2a:: with SMTP id a10mr4419656qvd.42.1643303467584;
        Thu, 27 Jan 2022 09:11:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQanMj7Y00ur/yzuLmY8gwfKPDXJeoixdwOU4KzNAVApl7lAtazZ8/rD9LIFjZrTulwd1nlg==
X-Received: by 2002:a05:6214:c2a:: with SMTP id a10mr4419637qvd.42.1643303467335;
        Thu, 27 Jan 2022 09:11:07 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id h6sm1661870qtx.43.2022.01.27.09.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:11:06 -0800 (PST)
Date:   Thu, 27 Jan 2022 12:11:06 -0500
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
Subject: Re: [PATCH 07/19] dm-snap: use blkdev_issue_flush instead of open
 coding it
Message-ID: <YfLSKlF89y3Cbf+S@redhat.com>
References: <20220124091107.642561-1-hch@lst.de>
 <20220124091107.642561-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124091107.642561-8-hch@lst.de>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 24 2022 at  4:10P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Use blkdev_issue_flush, which uses an on-stack bio instead of an
> opencoded version with a bio embedded into struct dm_snapshot.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>

