Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41D11B0C39
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 15:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgDTNEt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 09:04:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47880 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726287AbgDTNEs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Apr 2020 09:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587387887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W/bxTTX2WEiUDHSLV77/6UHjct+uk1657fsz3qpCp+I=;
        b=GBFcZPhHgAfgtRHndsOLYevqpMbRbexqLHXLQOwibGNCiK8/EhPgQxdohKZXqpQJmM8Sb0
        DYlW6LqonqDMUF5NMim2C16KA0fIZTkRvjxvGp/4HQWPO+R2KCjo2H6bxsDmzTTW6ZmoS8
        jFQ1qHt32ZjcQARwyKos3g1tPkXr9JI=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-d1HGWHi6M8G5NXW8FElSqA-1; Mon, 20 Apr 2020 09:04:43 -0400
X-MC-Unique: d1HGWHi6M8G5NXW8FElSqA-1
Received: by mail-oo1-f69.google.com with SMTP id u14so1871358oon.17
        for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2020 06:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/bxTTX2WEiUDHSLV77/6UHjct+uk1657fsz3qpCp+I=;
        b=iUiPLxt3uJWfEGREgWqfs7S6lNwiPsdjFHRQB5H19wvJP+LA9i9WHNOtyGwP5MdaP1
         ruuO7870VS8XM4sB5zn6hdIF59ZOIoBZaGNCBK4mqExX+Mq/dxZCJ4d+zZtGYJbSUojj
         ZE7acQhr/Gzino5iPJIfbWJoipvPZ91bzGt8lkengi+5ujVpwi53CI6MyoP78bDLQPbN
         tovNZuHGMDkG362Wm8dE494I2arDXvue95zLlpm+a51wu4HIqi0g+s3Ihvs7KMgX3sS1
         BnQNTM1WxZSNOLT9rwe3Ty3cOYn/T18kOuO+RbQWH6wwgTJimMHL6236WC2FYfPrbryr
         iRbA==
X-Gm-Message-State: AGi0PuZO0zNUpSFcSsF1BCQE5vLkc3cxlUpK+aa7eNBjHIZZm4jKwEHx
        n/CKploWfTW34f29v9RUrAJ0BGpy5VMT26E+ce1y4gync37lsuduJ6O3BAugoHwvMvWSBhSa2Fp
        uJvCPUXoDcFqaL/3w3sW+zFNP595Xw3j6XaTj
X-Received: by 2002:aca:88d:: with SMTP id 135mr9971538oii.10.1587387883080;
        Mon, 20 Apr 2020 06:04:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypLY7P4yV5E3/wHnumRqm5PZKROtZDJ6lfZUbx8EURZu+U+ZcCM/EEpfnJ9UL6QjsmXOxs19CnraHACJqSY6K+E=
X-Received: by 2002:aca:88d:: with SMTP id 135mr9971505oii.10.1587387882792;
 Mon, 20 Apr 2020 06:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <1587361410-83560-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <7b95f2ac1e65635dcb160ca20e798d95b7503e49.camel@hammerspace.com>
 <20200420125141.18002-1-agruenba@redhat.com> <52a445020247f4dbe810ce757e48cd563a69c4ce.camel@hammerspace.com>
In-Reply-To: <52a445020247f4dbe810ce757e48cd563a69c4ce.camel@hammerspace.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 20 Apr 2020 15:04:31 +0200
Message-ID: <CAHc6FU411Eoo_E=aQiR=Vk2Tx6XCZEuiz25NykWY+dd5wKrszg@mail.gmail.com>
Subject: Re: [PATCH] nfs: Fix potential posix_acl refcnt leak in nfs3_set_acl
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "akpm@osdl.org" <akpm@osdl.org>,
        "xiyuyang19@fudan.edu.cn" <xiyuyang19@fudan.edu.cn>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "okir@suse.de" <okir@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tanxin.ctf@gmail.com" <tanxin.ctf@gmail.com>,
        "yuanxzhang@fudan.edu.cn" <yuanxzhang@fudan.edu.cn>,
        "kjlu@umn.edu" <kjlu@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Apr 20, 2020 at 2:59 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
> Well, that should Oops when either IS_ERR(acl) or IS_ERR(dfacl)
> triggers, shouldn't it?

Yes, checks missings. But you get the idea.

Thanks,
Andreas

