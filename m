Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A70F710CAC
	for <lists+linux-nfs@lfdr.de>; Wed,  1 May 2019 20:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfEASZl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 May 2019 14:25:41 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:36512 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfEASZk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 May 2019 14:25:40 -0400
Received: by mail-vs1-f43.google.com with SMTP id x78so7900209vsc.3
        for <linux-nfs@vger.kernel.org>; Wed, 01 May 2019 11:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CL8fj/1WvD1XOCsOkJZLbwr2FkrpulNbESBS+POuiy4=;
        b=hu/9UibJbGHN4C66jypCqfrbpjHMgUcaeYXOGUNbli3BiwRurGxcpdiXWQHRQ5i06U
         Y11FqcRwwKe4Azn+8nSK+mXnIP8Lr8lTLiTGRZ3nr/fhzubOnGjrJnrDWU/Dpet3fmLk
         YEKBuYVr+e4TorKS95zgT9WAQiACfYixLAVkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CL8fj/1WvD1XOCsOkJZLbwr2FkrpulNbESBS+POuiy4=;
        b=q6uYo/cl678FS7n1IixWXbcUszsrYzcQ/kIJmhCjC8JYCmGGUvOZujjq3TOwGzXhHh
         DEFWQJf4SWHv7hOOsVOK5p8Rj/sugja1PV2jDWmglphpIwazHHWKneC4XdIICEL4glcQ
         DPgvOcFimk+TAxIOWjmaNh53c67zQQ3GcGgdqoia4VSbIW5JoYzQI3BbTHr4NYblX96J
         V6M6UpmhzdcxcPzs8PVYF0F4MYyP7VpznJZoP4CIX65hIiatCTsjHz5x79/012f65BVG
         ReiMx2z6dBbCPTPP91iAJTULUN0I3LRWnuC8MMadw+LudX5Sb/ky1jgHegUJZXbFLYq6
         GMnw==
X-Gm-Message-State: APjAAAVmQBzU5aGp7HOWZ49M1fU54Q3ljKPq06vHGNkK6PbWVgYjDLVM
        BTyh6PmgZwk1k8F4fM3aUNNFiaWGjAQ=
X-Google-Smtp-Source: APXvYqwMop9OG0Qb1Oxib4w6A/Oq9wTGxWGBpT0YV6dLhY8i5apnSLLrZTFTe8CtTS3Qno3QAiRO7Q==
X-Received: by 2002:a67:644:: with SMTP id 65mr15896385vsg.132.1556735137778;
        Wed, 01 May 2019 11:25:37 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id p44sm10278482uae.7.2019.05.01.11.25.36
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 11:25:36 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id x78so7900134vsc.3
        for <linux-nfs@vger.kernel.org>; Wed, 01 May 2019 11:25:36 -0700 (PDT)
X-Received: by 2002:a67:f849:: with SMTP id b9mr39824551vsp.188.1556735135694;
 Wed, 01 May 2019 11:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190501160636.30841-1-hch@lst.de>
In-Reply-To: <20190501160636.30841-1-hch@lst.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 1 May 2019 11:25:23 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKMswkBy-kEk7mb01v3oJADvGyhRf6JMh7BsjUKsme9QA@mail.gmail.com>
Message-ID: <CAGXu5jKMswkBy-kEk7mb01v3oJADvGyhRf6JMh7BsjUKsme9QA@mail.gmail.com>
Subject: Re: fix filler_t callback type mismatches
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux mtd <linux-mtd@lists.infradead.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 1, 2019 at 9:07 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Casting mapping->a_ops->readpage to filler_t causes an indirect call
> type mismatch with Control-Flow Integrity checking. This change fixes
> the mismatch in read_cache_page_gfp and read_mapping_page by adding
> using a NULL filler argument as an indication to call ->readpage
> directly, and by passing the right parameter callbacks in nfs and jffs2.

Nice. This looks great; thanks for looking at this. For the series
(including patch 5):

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
