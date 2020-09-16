Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CDB26CAF4
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Sep 2020 22:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgIPUTf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 16:19:35 -0400
Received: from smtprelay0049.hostedemail.com ([216.40.44.49]:41948 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728366AbgIPUTc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 16:19:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 958F6180013D2;
        Wed, 16 Sep 2020 20:19:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2898:2902:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:4250:4321:5007:6119:8660:10004:10400:10848:11232:11658:11914:12043:12295:12297:12679:12740:12760:12895:13069:13148:13161:13229:13230:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21451:21611:21627:21939:21990:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: goat48_1209be22711c
X-Filterd-Recvd-Size: 2294
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 16 Sep 2020 20:19:27 +0000 (UTC)
Message-ID: <ce28bb9bc25cb3f1197f75950a0cfe14947f9002.camel@perches.com>
Subject: Re: [PATCH v2] nfs: remove incorrect fallthrough label
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Hongxiang Lou <louhongxiang@huawei.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Date:   Wed, 16 Sep 2020 13:19:26 -0700
In-Reply-To: <20200916200255.1382086-1-ndesaulniers@google.com>
References: <9441ed0f247d0cac6e85f3847e1b4c32a199dd8f.camel@perches.com>
         <20200916200255.1382086-1-ndesaulniers@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2020-09-16 at 13:02 -0700, Nick Desaulniers wrote:
> There is no case after the default from which to fallthrough to. Clang
> will error in this case (unhelpfully without context, see link below)
> and GCC will with -Wswitch-unreachable.
> 
> The previous commit should have just replaced the comment with a break
> statement.

> If we consider implicit fallthrough to be a design mistake of C, then
> all case statements should be terminated with one of the following
> statements:
> 
> * break
> * continue
> * return
> * __attribute__(__fallthrough__)

Just fallthrough.  __attribute__((__fallthrough__)
is only used once in code for the #define.

And maybe add see: Documentation/process/deprecated.rst

> * goto (plz no)

goto is a valid style inside a switch/case label block.

There are more than 1500 of these goto <label> uses in the
kernel so the 'please no' here doesn't seem reasonable.

> * (call of function with __attribute__(__noreturn__))

I guess panic counts.  I count 11 of those.

Are there any other uses of functions with __noreturn
in switch/case label blocks?


