Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6DD277830
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Sep 2020 20:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgIXSDY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Sep 2020 14:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbgIXSDX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 24 Sep 2020 14:03:23 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E09A2399A;
        Thu, 24 Sep 2020 18:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600970603;
        bh=I99kkXfpnCyP071qSXVnw/h6mfsDjUJARC4tb7ruJi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fykI5J7y49QDhZmE9E94V2RBH+sMrnZE6zq3lkLEmwltw8bBE91kf+EDBgh139SHo
         /ZtlqorHr5jA1baMlqVuC2aJ2LpFKeGB0isCdBsr8aeqpk4wH5Joo/nO2Pnkp+3JBs
         Kf5llzuwvpf0IMH5/SsGSc0Wofdde5NV3buyNx1Y=
Date:   Thu, 24 Sep 2020 13:08:51 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Hongxiang Lou <louhongxiang@huawei.com>,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] nfs: remove incorrect fallthrough label
Message-ID: <20200924180851.GA2411@embeddedor>
References: <ce28bb9bc25cb3f1197f75950a0cfe14947f9002.camel@perches.com>
 <20200917214545.199463-1-ndesaulniers@google.com>
 <CAKwvOdnziDJbRAP77K+V885SCuORfV4SmHDnSLUxhUGSSLMq_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnziDJbRAP77K+V885SCuORfV4SmHDnSLUxhUGSSLMq_Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 24, 2020 at 10:19:08AM -0700, Nick Desaulniers wrote:
> Hello maintainers,
> Would you mind please picking up this patch?  KernelCI has been
> erroring for over a week without it.
>

I can add this to my -next tree and queue it up for the next merge window.

Thanks
--
Gustavo

