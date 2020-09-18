Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4861D26EA9B
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Sep 2020 03:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgIRBpy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Sep 2020 21:45:54 -0400
Received: from smtprelay0052.hostedemail.com ([216.40.44.52]:52850 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbgIRBpy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Sep 2020 21:45:54 -0400
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 21:45:54 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id BC09018011257
        for <linux-nfs@vger.kernel.org>; Fri, 18 Sep 2020 01:36:08 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 6C077182CF66A;
        Fri, 18 Sep 2020 01:36:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3870:3873:4321:5007:8660:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12679:12740:12760:12895:13069:13148:13230:13311:13357:13439:14181:14659:14721:21080:21451:21611:21627:21740:21939:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: home77_5210bfa27127
X-Filterd-Recvd-Size: 2929
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri, 18 Sep 2020 01:36:03 +0000 (UTC)
Message-ID: <ce5aa7a4881411836f16693a482d756be7bc79ca.camel@perches.com>
Subject: Re: [PATCH v2] nfs: remove incorrect fallthrough label
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Hongxiang Lou <louhongxiang@huawei.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-nfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Thu, 17 Sep 2020 18:36:01 -0700
In-Reply-To: <CAKwvOdm84xCFq_KVQcNws2QveJdOM_uRrH9s023Gv8sp8V79JA@mail.gmail.com>
References: <9441ed0f247d0cac6e85f3847e1b4c32a199dd8f.camel@perches.com>
         <20200916200255.1382086-1-ndesaulniers@google.com>
         <ce28bb9bc25cb3f1197f75950a0cfe14947f9002.camel@perches.com>
         <CAKwvOdm84xCFq_KVQcNws2QveJdOM_uRrH9s023Gv8sp8V79JA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2020-09-17 at 14:41 -0700, Nick Desaulniers wrote:
> On Wed, Sep 16, 2020 at 1:19 PM Joe Perches <joe@perches.com> wrote:
> > On Wed, 2020-09-16 at 13:02 -0700, Nick Desaulniers wrote:
> > > * (call of function with __attribute__(__noreturn__))
> > 
> > I guess panic counts.  I count 11 of those.
> > 
> > Are there any other uses of functions with __noreturn
> > in switch/case label blocks?
> 
> If you look at global_noreturns in tools/objtool/check.c:
>  145   static const char * const global_noreturns[] = {
>  146     "__stack_chk_fail",
>  147     "panic",
>  148     "do_exit",
>  149     "do_task_dead",
>  150     "__module_put_and_exit",
>  151     "complete_and_exit",
>  152     "__reiserfs_panic",
>  153     "lbug_with_loc",
>  154     "fortify_panic",
>  155     "usercopy_abort",
>  156     "machine_real_restart",
>  157     "rewind_stack_do_exit",
>  158     "kunit_try_catch_throw",
>  159   };
> 
> Whether they occur or not at the position you ask; I haven't checked.

Just fyi:

Other than the 11 instances of panic, I found only a
single use of any other function above in a switch/case:

drivers/pnp/pnpbios/core.c:163:			complete_and_exit(&unload_sem, 0);
		case PNP_SYSTEM_NOT_DOCKED:

Found with:

$ grep-2.5.4 -rP --include=*.[ch] -n '\b(?:__stack_chk_fail|panic|do_exit|do_task_dead|__module_put_and_exit|complete_and_exit|__reiserfs_panic|lbug_with_loc|fortify_panic|usercopy_abort|machine_real_restart|rewind_stack_do_exit|kunit_try_catch_throw)\s*(?:\([^\)]*\))?\s*;\s*(case\s+\w+|default)\s*:' *


