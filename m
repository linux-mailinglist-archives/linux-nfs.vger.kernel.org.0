Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C6C6A12F4
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Feb 2023 23:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjBWWqp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Feb 2023 17:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBWWqb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Feb 2023 17:46:31 -0500
Received: from mta-201a.earthlink-vadesecure.net (mta-201a.earthlink-vadesecure.net [51.81.229.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5902056532
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 14:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; bh=Ie6wFMNaMLsnL1sj8l6S8vygvA91N8uDSzD8NJ
 0csUs=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1677192068;
 x=1677796868; b=ZevTkcUvkoSDfCASeiR/l4nT++zmS7IAXDub3I/atacFvfLBk9X5ZSQ
 +xMT/Y1QPVZU3PaL0UJMZ57rYt1X9ZCW+GN3CSq68IaztA5Ch6YsDg8Dsqdb8nBygUutSCy
 J5K2IB6Ow4KDzplkJWVKLQLei2XCohwLueqBQpdg3y8hwEfV30kIyUMx/qg52DZ/2NnqQRs
 cr0hGf/X4JJYMkJNTFCiVDJoyyvZ04N+9sKGC7p8lugx+evTUT65O6FTo+IppNwfou+Qk5t
 qsDhoYCDKhKhO5LZzslxgIOxnesACB8eH9Vo8fUaVGW5JItWO4Ei9whtw8FsSP2X4iio8yb
 BgA==
Received: from FRANKSTHINKPAD ([174.174.49.201])
 by smtp.earthlink-vadesecure.net ESMTP vsel2nmtao01p with ngmta
 id 5615c23c-1746954cccb2e987; Thu, 23 Feb 2023 22:41:08 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Jeff Layton'" <jlayton@kernel.org>,
        "'Chuck Lever III'" <chuck.lever@oracle.com>,
        "'Bruce Fields'" <bfields@fieldses.org>
Cc:     "'Dai Ngo'" <dai.ngo@oracle.com>,
        "'Linux NFS Mailing List'" <linux-nfs@vger.kernel.org>,
        "'Calum Mackay'" <calum.mackay@oracle.com>
References: <20230222182043.155712-1-jlayton@kernel.org>         <20230223151959.GC10456@fieldses.org>   <3B034712-F376-4D71-8A72-703B030140F9@oracle.com>       <029a01d947a3$a51b4750$ef51d5f0$@mindspring.com> <fabf62538a93fda344c05b1a07c1298e7f3199bb.camel@kernel.org>
In-Reply-To: <fabf62538a93fda344c05b1a07c1298e7f3199bb.camel@kernel.org>
Subject: RE: [pynfs RFC PATCH] testserver.py: special-case the "all" flag
Date:   Thu, 23 Feb 2023 14:41:08 -0800
Message-ID: <02c301d947d7$ec26d950$c4748bf0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFaakfSQa9czN/urkZcULRlvLq/BAI3dwcGAlJyRq4B7kPYUwIMZLPsr5a1GkA=
Content-Language: en-us
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> From: Jeff Layton [mailto:jlayton@kernel.org]
 
> On Thu, 2023-02-23 at 08:26 -0800, Frank Filz wrote:
> >
> > > -----Original Message-----
> > > From: Chuck Lever III [mailto:chuck.lever@oracle.com]
> > > Sent: Thursday, February 23, 2023 8:22 AM
> > > To: Bruce Fields <bfields@fieldses.org>
> > > Cc: Jeff Layton <jlayton@kernel.org>; Dai Ngo <dai.ngo@oracle.com>;
> > > Linux NFS Mailing List <linux-nfs@vger.kernel.org>; Calum Mackay
> > > <calum.mackay@oracle.com>; Frank Filz <ffilzlnx@mindspring.com>
> > > Subject: Re: [pynfs RFC PATCH] testserver.py: special-case the "all"
> > > flag
> > >
> > >
> > >
> > > > On Feb 23, 2023, at 10:19 AM, J. Bruce Fields
> > > > <bfields@fieldses.org>
> > wrote:
> > > >
> > > > On Wed, Feb 22, 2023 at 01:20:43PM -0500, Jeff Layton wrote:
> > > > > The READMEs for v4.0 and v4.1 are inconsistent here. For v4.0,
> > > > > the
> > "all"
> > > > > flag is supposed to run all of the "standard" tests. For v4.1
"all"
> > > > > is documented to run all of the tests, but it actually doesn't
> > > > > since not every tests has "all" in its FLAGS: field.
> > > > >
> > > > > I move that we change this. If I say that I want to run "all",
> > > > > then I really do want to run _all_ of the tests. Ensure that
> > > > > every test has the "all" flag set.
> > > >
> > > > In some (all?) cases where the "all" flag was left off, it was
> > > > intentional.
> > > >
> > > > We try not to flag spec-compliant servers as failing, because
> > > > people are sometimes a little careless about "fixing" failures
> > > > that in their particular case really shouldn't be fixed.  But
> > > > sometimes it's still useful to have a test that goes somewhat beyond
the
> spec.
> > > >
> > > > There might be other ways to handle that kind of test, but it
> > > > would need some more thought.
> > >
> > > We could use a different name for "all" since it doesn't actually
> > > run
> > /all/ tests.
> > > Jeff suggested "standard", which seems sensible.
> >
> > The challenge with changing this is all the CI scripts and other
> > testing scripts out there that use all. If all suddenly changed,
> > server maintainers might get a deluge of bug reports for failing odd
> > test cases no one necessarily expected to work...
> >
> 
> Are those CI systems pulling down the upstream tree to run? How do they
> contend with new tests that might suddenly show up as part of "all"?

Honestly I'm not sure, the Ganesha CI may pull from a non-upstream repo. Or
it may be that anything that has been added to "all" happens to be OK. I
don't know...

> > > Also, we could add test categories specifically for particular
> > > server implementations, if that's interesting to folks.
> >
> > I have already done so with a ganesha tag...
> >
> > Literally all anyone has to do is start using a new tag so it's a
> > trivial thing for developers to add.
> >
> 
> The problem is that you have to add the tag to hundreds of tests. It's
scriptable,
> sure, but if you want to be at all selective, it's not trivial.
> 
> That said, I'm open to doing something different here. Maybe we could
declare
> a new "everything" special case instead? It's confusing naming, but that
would
> at least preserve the existing behavior for those CI systems.

That might be the best thing to do. That way existing scripts aren't broken,
yet someone who genuinely wants to try and run everything can.

The next problem will be how to exclude tests that have specific conditions
that can't be met, especially tests for a specific server implementation.
Specifying everything -ganesha won't work because that will cut out tests
that aren't Ganesha specific. But we could add a new ganeshaonly tag for
those test cases that is added in addition to the ganesha tag. Then
everthing -ganeshaonly excludes those while all ganesha still runs
everything Ganesha is expected to pass.

Frank

> > >
> > > > --b.
> > > >
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > > nfs4.1/testmod.py | 2 ++
> > > > > 1 file changed, 2 insertions(+)
> > > > >
> > > > > If this is unacceptable, then an alternative could be to add a
> > > > > new (similarly special-cased) "everything" flag.
> > > > >
> > > > > diff --git a/nfs4.1/testmod.py b/nfs4.1/testmod.py index
> > > > > 11e759d673fd..7b3bac543084 100644
> > > > > --- a/nfs4.1/testmod.py
> > > > > +++ b/nfs4.1/testmod.py
> > > > > @@ -386,6 +386,8 @@ def createtests(testdir):
> > > > >     for t in tests:
> > > > > ##         if not t.flags_list:
> > > > > ##             raise RuntimeError("%s has no flags" % t.fullname)
> > > > > +        if "all" not in t.flags_list:
> > > > > +            t.flags_list.append("all")
> > > > >         for f in t.flags_list:
> > > > >             if f not in flag_dict:
> > > > >                 flag_dict[f] = bit
> > > > > --
> > > > > 2.39.2
> > >
> > > --
> > > Chuck Lever
> > >
> >
> >
> 
> --
> Jeff Layton <jlayton@kernel.org>

