Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631CC27783F
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Sep 2020 20:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgIXSHz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Sep 2020 14:07:55 -0400
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:60986 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728577AbgIXSHz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Sep 2020 14:07:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 4FBFD100E7B4A;
        Thu, 24 Sep 2020 18:07:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3867:3868:3870:3871:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:7903:7974:8828:9025:10004:10400:10848:11232:11658:11914:12043:12048:12050:12297:12555:12679:12740:12760:12895:13069:13161:13229:13311:13357:13439:14180:14181:14659:14721:21080:21325:21433:21451:21627:21740:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: flesh53_541162527161
X-Filterd-Recvd-Size: 2054
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Thu, 24 Sep 2020 18:07:51 +0000 (UTC)
Message-ID: <734165bbee434a920f074940624bcef01fcd9d60.camel@perches.com>
Subject: Re: [PATCH v3] nfs: remove incorrect fallthrough label
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Hongxiang Lou <louhongxiang@huawei.com>,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>
Date:   Thu, 24 Sep 2020 11:07:50 -0700
In-Reply-To: <ca629208707903da56823dd57540d677df2da283.camel@perches.com>
References: <ce28bb9bc25cb3f1197f75950a0cfe14947f9002.camel@perches.com>
         <20200917214545.199463-1-ndesaulniers@google.com>
         <CAKwvOdnziDJbRAP77K+V885SCuORfV4SmHDnSLUxhUGSSLMq_Q@mail.gmail.com>
         <ca629208707903da56823dd57540d677df2da283.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2020-09-24 at 10:40 -0700, Joe Perches wrote:
> On Thu, 2020-09-24 at 10:19 -0700, Nick Desaulniers wrote:
> > Hello maintainers,
> > Would you mind please picking up this patch?  KernelCI has been
> > erroring for over a week without it.
> 
> As it's trivial and necessary, why not go through Linus directly?
[]
> Fixes: 2a1390c95a69 ("nfs: Convert to use the preferred fallthrough macro")

Real reason why not:

the commit to be fixed is not in Linus' tree.

> https://lore.kernel.org/patchwork/patch/1307549/


