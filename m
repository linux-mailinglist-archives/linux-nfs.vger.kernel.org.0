Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCC5180C37
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 00:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgCJXTD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Mar 2020 19:19:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43278 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727659AbgCJXTD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Mar 2020 19:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583882342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z5sLqw2q00TFWFE2+/xEamSW6/qGE1IWWYINTtiDzeQ=;
        b=ePT3ybQq7KlGmqxO6iw8fnPh7diSygkqL+zDJkDzSfoSPeRrt0z1uZYL9GJmmcxMWAgUIJ
        bupMJEySk8dAf3qr+64zujsrYvGLpXGQ9rp6XYpGlIe8jtiYzdF5PjXzbscA/f6zq/oXu9
        TuBg8tgx7poj6sxgV2q6pz6Ffz1K80w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-PK5GffabP9ej_oIJrMHa2w-1; Tue, 10 Mar 2020 19:18:58 -0400
X-MC-Unique: PK5GffabP9ej_oIJrMHa2w-1
Received: by mail-ed1-f70.google.com with SMTP id m24so191392edq.8
        for <linux-nfs@vger.kernel.org>; Tue, 10 Mar 2020 16:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z5sLqw2q00TFWFE2+/xEamSW6/qGE1IWWYINTtiDzeQ=;
        b=FTgxPMeUs8bpHUFnzK1pQ/319IASVYNmnqUnc5tJ5XMH5HMa1onz7RJP8zMASGcEF1
         OwFqKSboBRKhJIeTbyRvFKn5y5IgnXdwAIagOkepP3QTMn3FkfJBobYIFwvOKMd1s1el
         OObNOhdterD7DgwhiFA44KV/BsltOIv+VuSdwa+T8oBLETvY+aawhsMMrR2osOrEG1ql
         bhACGdUQU/u/7bkDArdIk/4Rdstc50o8AStBTJSjzagAHjz8U+GFhBPx3fRKhXcWyomx
         l3PCggKuThOcwhqLh/Yj0ijundYldBDSfjFcHKlTXSCGYdsFQA6n6+bsdUFa1EV9q7dt
         EiZg==
X-Gm-Message-State: ANhLgQ1pzJT7Lm95/89cfb5V4albmY1+GxPF6hS+i2lZLk7aCNWFv3YV
        FDsy6vJJ4EH+ztU1RnZt15n/3mP3FJlTbyISU5NHk3SmB24E+jTO/IuUGCTFG7ihdIO5PYz5ppz
        u0Trz6SUnFN/smgVhuR6tA/vXj0YGhga+tdS6
X-Received: by 2002:a17:907:262a:: with SMTP id aq10mr12415672ejc.377.1583882337423;
        Tue, 10 Mar 2020 16:18:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vstjHqiZOF0xElis+31S7G0gY2aH73JLw/AluJvKeWmdJcJyHfoWoeERc+w0Ht0pyWZgseKXsqtbLAkFkQLxyM=
X-Received: by 2002:a17:907:262a:: with SMTP id aq10mr12415648ejc.377.1583882337100;
 Tue, 10 Mar 2020 16:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200310223516.102758-1-mcroce@redhat.com> <d473061b-688f-f4a6-c0e8-61c22b8a2b10@cloud.ionos.com>
In-Reply-To: <d473061b-688f-f4a6-c0e8-61c22b8a2b10@cloud.ionos.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Wed, 11 Mar 2020 00:18:21 +0100
Message-ID: <CAGnkfhwjXN_T09MsD1e6P95gUqxCbWL7BcOLSy16_QOZsZKbgQ@mail.gmail.com>
Subject: Re: [PATCH v2] block: refactor duplicated macros
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-bcache@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-mmc@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 11, 2020 at 12:10 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
>
>
> On 3/10/20 11:35 PM, Matteo Croce wrote:
> > +++ b/drivers/md/raid1.c
> > @@ -2129,7 +2129,7 @@ static void process_checks(struct r1bio *r1_bio)
> >       int vcnt;
> >
> >       /* Fix variable parts of all bios */
> > -     vcnt = (r1_bio->sectors + PAGE_SIZE / 512 - 1) >> (PAGE_SHIFT - 9);
> > +     vcnt = (r1_bio->sectors + PAGE_SECTORS - 1) >> (PAGE_SHIFT - 9);
>
> Maybe replace "PAGE_SHIFT - 9" with "PAGE_SECTORS_SHIFT" too.
>
> Thanks,
> Guoqing
>

Wow, there are a lot of them!

$ git grep -c 'PAGE_SHIFT - 9'
arch/ia64/include/asm/pgtable.h:2
block/blk-settings.c:2
block/partition-generic.c:1
drivers/md/dm-table.c:1
drivers/md/raid1.c:1
drivers/md/raid10.c:1
drivers/md/raid5-cache.c:5
drivers/md/raid5.h:1
drivers/nvme/host/fc.c:1
drivers/nvme/target/loop.c:1
fs/erofs/internal.h:1
fs/ext2/dir.c:1
fs/libfs.c:1
fs/nilfs2/dir.c:1
mm/page_io.c:2
mm/swapfile.c:6

-- 
Matteo Croce
per aspera ad upstream

