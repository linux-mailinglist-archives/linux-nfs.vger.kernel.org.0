Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00634FA81D
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Apr 2022 15:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241935AbiDINTV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 9 Apr 2022 09:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241932AbiDINTU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 9 Apr 2022 09:19:20 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C2862F5
        for <linux-nfs@vger.kernel.org>; Sat,  9 Apr 2022 06:17:12 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id p65so1397342ybp.9
        for <linux-nfs@vger.kernel.org>; Sat, 09 Apr 2022 06:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QEAOft9J8DOAKayJbGZ9g46BdFYqwqCZhGEHzaIhcV4=;
        b=1FNE7pbiIa9oilTg3fw9bAPQV+xgtQ/9oj7IrfoZLdp1tlCB/f0NLtH02Vmhz93YHy
         WgI7K5H4LnvwcrW/XIRlvDbMNb2W8rcPjstL1grQ1zkSf4DB3l4n2uIRQk2xtcLcpQSd
         mMPuza2mTHnRdKr8odgQcTW21G5i9kAxmhTEI9ebfcTyPm2Oc4fIerCLc0fWlQYdVgAj
         rqu0VJYYjF4Gyl5u4XWpSD2+KUp9QzEx5/nCKfrM+M88OojpK3DcDAGk377T5+HMe//j
         mGAFRaYwTub89DSa8K4jRYoofl0YL1MrvdLz4SA7Yw11sl/Nlth8FSzYcY7nzOkwjLIy
         xQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QEAOft9J8DOAKayJbGZ9g46BdFYqwqCZhGEHzaIhcV4=;
        b=gPGUz7KNrsm2YGR1Ten7MiBsw6lTNqUaWYGDZ5Hy6zfpkw4D/KXONgFvRDCltK4yLd
         vwiHXXwg7JidqrFMoBFUHZzsEpDhEueelHmScXqB8Iat7Y/1sHDPkNOYV5mTsUqk7ukZ
         Kf7ZEpGNtl85pka32VebFQ45AstthRND7GraBGoA68bCiX+CkEa7vlpwnTma2c1zSxv3
         NlRORFHytJtREGk4gMJ3pmaOjFAmYcZKfwJ8Yenb2Ws8UuK9Ynql17pgx+6G9ywwVBuL
         s2XHycKcljctf89YA1E2NnAD8EbQnf4whduboEUuqKWpiIz+PoF5pkidC2jCxNptEPmQ
         YKkw==
X-Gm-Message-State: AOAM530wyrTU37Jdm/5XICsdTAN6sCV71y321NO3OTJ8lax2OnfEUo+1
        ECmhYaIG/4vxEI/CcRv3T8qzKk7NAIgikq8Gznv0NA==
X-Google-Smtp-Source: ABdhPJygYzjsvkAOjjCUPmve6P8vLX65dX1g2b1DW6Y987MKIHAfiUGYwjljSA9DjtSkQBit/7DlZXdrBqX/XcvvqSQ=
X-Received: by 2002:a25:d68e:0:b0:641:1cf4:a4c1 with SMTP id
 n136-20020a25d68e000000b006411cf4a4c1mr2049697ybg.89.1649510231956; Sat, 09
 Apr 2022 06:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220401025905.49771-1-songmuchun@bytedance.com>
 <CAMZfGtV7Uf3Z1G-0WQNe_DukPz4t5HuxPRrNMVLJ1GVST9jQpA@mail.gmail.com> <6c1181826d5fa8f2cffcd9cfdcb717c5cc3416fd.camel@hammerspace.com>
In-Reply-To: <6c1181826d5fa8f2cffcd9cfdcb717c5cc3416fd.camel@hammerspace.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 9 Apr 2022 21:16:36 +0800
Message-ID: <CAMZfGtWtdy=HEc6yazBFtzANUB8z+PGhiHaurXi6020GUgVZdg@mail.gmail.com>
Subject: Re: [PATCH] NFSv4.2: Fix missing removal of SLAB_ACCOUNT on
 kmem_cache allocation
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna@kernel.org" <anna@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "smuchun@gmail.com" <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 8, 2022 at 11:24 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Fri, 2022-04-08 at 23:21 +0800, Muchun Song wrote:
> > Ping
> >
> > Could someone be willing to help merge this?
> >
> It's already in the queue.
>

Thanks Trond
