Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209F626B800
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Sep 2020 02:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgIPAeF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Sep 2020 20:34:05 -0400
Received: from smtprelay0130.hostedemail.com ([216.40.44.130]:55218 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726661AbgIPAd5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Sep 2020 20:33:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 3DD4D837F24C;
        Wed, 16 Sep 2020 00:33:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2560:2563:2682:2685:2693:2828:2859:2898:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:6691:9025:10010:10400:10848:11026:11232:11658:11914:12043:12048:12050:12295:12296:12297:12438:12555:12663:12679:12698:12737:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:14777:21080:21324:21433:21627:21740:21939:30012:30054:30070:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: corn68_1c0caec27115
X-Filterd-Recvd-Size: 3131
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 16 Sep 2020 00:33:53 +0000 (UTC)
Message-ID: <2786f88508b99c8e1ebee62ea955c4026368c878.camel@perches.com>
Subject: Re: [PATCH] nfs: remove incorrect fallthrough label
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hongxiang Lou <louhongxiang@huawei.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Tue, 15 Sep 2020 17:33:52 -0700
In-Reply-To: <de27c65b-ae7d-a2ba-3ab8-717c10f297c3@embeddedor.com>
References: <20200915225751.274531-1-ndesaulniers@google.com>
         <9441ed0f247d0cac6e85f3847e1b4c32a199dd8f.camel@perches.com>
         <55f1ff08-fc3c-62ed-429d-c9ae285a3a49@embeddedor.com>
         <de27c65b-ae7d-a2ba-3ab8-717c10f297c3@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2020-09-15 at 19:01 -0500, Gustavo A. R. Silva wrote:
> 
> On 9/15/20 18:51, Gustavo A. R. Silva wrote:
> > 
> > On 9/15/20 18:29, Joe Perches wrote:
> > > On Tue, 2020-09-15 at 15:57 -0700, Nick Desaulniers wrote:
> > > > There is no case after the default from which to fallthrough to. Clang
> > > > will error in this case (unhelpfully without context, see link below)
> > > > and GCC will with -Wswitch-unreachable.
> > > > 
> > > > The previous commit should have just removed the comment.
> > > []
> > > > diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> > > []
> > > > @@ -889,7 +889,6 @@ static struct nfs_server *nfs_try_mount_request(struct fs_context *fc)
> > > >  		default:
> > > >  			if (rpcauth_get_gssinfo(flavor, &info) != 0)
> > > >  				continue;
> > > > -			fallthrough;
> > > 
> > > My preference would be to convert the fallthrough
> > > to a break here so if someone ever adds another
> > > label after default: for any reason, the code would
> > > still work as expected.
> > 
> > I agree with Joe.
> 
> Actually, this is part of the work I plan to do to enable -Wimplicit-fallthrough
> for Clang: audit every place where we could use a break instead of a fallthrough.
> 
> I'm on vacation this week. So, I'll get back to this next week.

Nice, thanks Gustavo.

As part of that work, perhaps you could also find all the

	switch (<foo>) {
	[cases...]
		[code...];
		break;

	default:
		[code...]
		(no break)
	}

uawa where the last label/default block does _not_ have a break
statement and add one too.

Also see:  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91432

gcc does _not_ warn on

	switch (<foo>) {
	case BAR:
		[code];
		(no fallthrough)

	case BAZ:
		break;
	}

It might be good to add the appropriate fallthrough
for those case blocks too.


