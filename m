Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D4F6541DD
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Dec 2022 14:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiLVNa1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Dec 2022 08:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbiLVNaU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Dec 2022 08:30:20 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8B3DEF3;
        Thu, 22 Dec 2022 05:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671715814; bh=MKbfsu4NWqfI//GBSkMSplfnRBYgBov2LFmHHQoGku4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=J1M2XBWd/qp+QtPl6PjYhqCnkdaaCbEhURGGnFsG0YQZHbq5tjMRwuLFstY+tkFBg
         llFJDhx2MWLmlcEIKITVhKLt6OU1cY5Mgot/AoMcZOVWg8aL/d9bOQM5y2opKRyX6P
         /sBfdxDgoN4+dQkO79jUE50d0thQ6bXgMcANUbyTBPyFUFEDniWCUGGyhfSOcYvGb6
         AowlM2GDKxC0xZyHAYtcNhAUeqvPBF+9HX0shNSeCvGF1kUpaxGd5h4g6zOny63agT
         2ti/wAEkgMVPUDaUGMLOceUA6Azpws8V7mOXqiRkrFlIpqWHfDT1LAhXDkeEUJ7r1V
         7SH4sZ+qgQN5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([212.114.172.145]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0oFz-1ouNVI3owP-00wi1G; Thu, 22
 Dec 2022 14:30:14 +0100
Message-ID: <e51b8b218f18abe00ec76eb911d5b5b5af02f79b.camel@gmx.de>
Subject: Re: regression: nfs mount (even idle) eventually hangs server
From:   Mike Galbraith <efault@gmx.de>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Dai Ngo <dai.ngo@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 22 Dec 2022 14:30:13 +0100
In-Reply-To: <36902a3dd6ee1a8656548ff5b5eadb88245e2799.camel@gmx.de>
References: <65ed34338c69cb034295f2c9cbe0af684d65d30f.camel@gmx.de>
         <360f3dcfb6cfbefdbcc42fc84c660995142a8645.camel@gmx.de>
         <241c118c2fb60df744bbe351387fc29a34ff6ab9.camel@gmx.de>
         <f533c2e38c0619ea0c3b4346d1c7c99c5ae2122b.camel@gmx.de>
         <1A404CDB-95A8-4D04-B76B-91D4F063B489@oracle.com>
         <36902a3dd6ee1a8656548ff5b5eadb88245e2799.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xJN9DQxlyPaV3UdeQIbZwtlVGhlF/rQsHlwly0jbgwWHGfo1NNr
 w/bqp2OoJnhBGI/kH+ryMGTQ9UiW9bPuSRb53PDrwDEoJo2kKoAkZdaIULtID7fzLz8MP09
 dMla6By1qsG+0+FAtj54Z+ArHIFDgryzd4oOit+jP5hFPJEPZhAL9Hcm3mUF/jTQWyy5EEw
 ItI2hZZrZWX8IXV6yfeAA==
UI-OutboundReport: notjunk:1;M01:P0:TCvGYhhlAyw=;XHMmMNZHuQMb6HzWGpqHUNCGZmN
 31UnhWX7Yf0x9F3vMS7QbAppJNYNluxogKJCc2kVS1pOtm+P3BBDWCC7OeonBfzdPrYTvD16k
 7VnUMk9zNv/vf3FDnUUs5t+l9npFwYWIe9vkBXoiH67C8PrX8PkkQ9Ez5hX9yPuKBeyFZJmqp
 mn/h74sMbib3OwUuy+4YZr3HyA+gXagVFr9QwxFnaM4wn+OB2A3CNE0GGD8zjSoll+iMkEabY
 R/gDA8yUsEFJdSIPhCjZ/Pu/CWbI8NCDQJzuTCV0IR4esNZTXVDPyDip1gKzgEC5omCqU6mP9
 IWdBjQuIiIpGbnMZcn/fyegGFw88iCaPqU8Smfu12VF5z2pstsr5DHnrtkwbyvuBCQ3Ih1DtL
 6UMBew17IFna7wVdOxqEyI+MAKAFjviCK4hEIV4SvZcZgO1vLXezdvZKhX5GuYI4LOSr+S46j
 6j4q3hnvK4Sfjdqd1VfGYkmP2WNh8kt0e/pkA7BReYifaSGZUUb4pleWYVWUJi2dT7AbM3CNo
 LZjmUMNcUAIMaNAZUwQwjvrnSff6zduM2i4EkraSOUpSSvcqHcmc81ME7iz3KrW0T8ClbvbXW
 iwQVNNn//KcwWpteqEosxb/GnQRvUJehbhVUNqYz2NCjurZwz1IpbTnQMkJIPWPvgsrrQsmfV
 jRt5ZQ78NA1T/nIiPFl46ry+XrBEez1KLQ8ptdqleZ8E6cDY2y5OAEvlWKvyvK+YLpJDNdTtH
 MmHpzWKWIbNWxMiVa4UgSJ/k9fbSYUWMQv0wQ5395ickTjdPej+5mSpXB0kYXs0B3xmLPHY64
 DsuhwTtRyEeDpMUGiUaNdmFt+Npze60xNmnrNozFybjth6W2c9uJolH3gEuLrDhVtMvQ9JcL4
 JD650eKoVOVLerEWf+7sC4MhPI3zguplHDxXLQIerpZiVSbPCg/kMYBO8r9KoI1N4MtL8tuG9
 +/h+1SOUh0DSCpRG99Fw0k9W+qA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Quoting previous mail for context.

On Thu, 2022-12-22 at 05:14 +0100, Mike Galbraith wrote:
> On Thu, 2022-12-22 at 04:42 +0100, Mike Galbraith wrote:
> > On Wed, 2022-12-21 at 10:56 +0100, Mike Galbraith wrote:
> > > > 6.1 didn't reproduce either, so it would appear to be a merge wind=
ow bug.
> >
> > Ah, not true, turning evolution loose in nfs mounted home and letting
> > it refresh mailboxes while desktop box was kept busy jammed up 6.1.0 i=
n
> > fairly short order.
>
> Well crap.  That was _not_ virgin 6.1.0 after all, it was 6.1.0 with...
>
> 44df6f439a17 NFSD: add delegation reaper to react to low memory conditio=
n
> 3959066b697b NFSD: add support for sending CB_RECALL_ANY
> a1049eb47f20 NFSD: refactoring courtesy_client_reaper to a generic low m=
emory shrinker
>
> ...applied from poking about yesterday.  I had given up on those as
> culprit, and intended to pop them off and rebuild, but they were in
> fact in the booted kernel.  Oh well, booboo could have a bright side.

I let my desktop box play server/space-heater for a long test session
of 6.1 with and without the above series: with, box bricked 3 times in
~5 hours, without, 0 bricks in ~6 hours.  Box says woof -> duck ;-)

Given the similarity you mentioned, I wonder if my bug is perhaps your
sneaky bug rendered somewhat less sneaky by that series? One can hope.

	-Mike
