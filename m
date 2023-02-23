Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC7C6A0DC0
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Feb 2023 17:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjBWQU4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Feb 2023 11:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBWQUz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Feb 2023 11:20:55 -0500
Received: from mta-101a.earthlink-vadesecure.net (mta-101b.earthlink-vadesecure.net [51.81.61.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6501817CFC
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 08:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; bh=ewsyH3njTpgeQBW4cIpi1QzTxRUT7Mf3XJYEIz
 r34j4=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1677169241;
 x=1677774041; b=QHitcWEgjtkSUY/sYfzwOpW3kak2IETTzX0J96782g7zjobAhbOlrqi
 w0uebwCOV8ICwt7Db8C0Pjb7kNqQzVoB5OBr8nIweDj90P1a7EyiWRUXhAgsVArkxz7o+tA
 5l829ZQrm8ohuc47/vuhR4L+iNX/ZX3NdgqG++IiRxOBdVgreBdBxveJKv9Xl7vtsLbRZD5
 4Mc3dSCOlX2ODb2JMkBVGc+2wGZCLRhLrwOOjocfjVTq6SUVFYTS0hErBG/NSj+xAANE/+l
 cWv01qV2+LmcVeByieP99Z54VrIO2i+ZpXzwbPyCYUs2uhm3kvDq8Rzw+jKYohByBPwyClv
 Q2g==
Received: from FRANKSTHINKPAD ([174.174.49.201])
 by smtp.earthlink-vadesecure.net ESMTP vsel1nmtao01p with ngmta
 id 33695de4-17468089f133acc5; Thu, 23 Feb 2023 16:20:41 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'J. Bruce Fields'" <bfields@fieldses.org>,
        "'Jeff Layton'" <jlayton@kernel.org>
Cc:     <dai.ngo@oracle.com>, <linux-nfs@vger.kernel.org>
References: <20230222182043.155712-1-jlayton@kernel.org> <20230223151959.GC10456@fieldses.org>
In-Reply-To: <20230223151959.GC10456@fieldses.org>
Subject: RE: [pynfs RFC PATCH] testserver.py: special-case the "all" flag
Date:   Thu, 23 Feb 2023 08:20:40 -0800
Message-ID: <029801d947a2$c64a1c40$52de54c0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFaakfSQa9czN/urkZcULRlvLq/BAI3dwcGr8ixkDA=
Content-Language: en-us
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> -----Original Message-----
> From: J. Bruce Fields [mailto:bfields@fieldses.org]
 
> On Wed, Feb 22, 2023 at 01:20:43PM -0500, Jeff Layton wrote:
> > The READMEs for v4.0 and v4.1 are inconsistent here. For v4.0, the "all"
> > flag is supposed to run all of the "standard" tests. For v4.1 "all" is
> > documented to run all of the tests, but it actually doesn't since not
> > every tests has "all" in its FLAGS: field.
> >
> > I move that we change this. If I say that I want to run "all", then I
> > really do want to run _all_ of the tests. Ensure that every test has
> > the "all" flag set.
> 
> In some (all?) cases where the "all" flag was left off, it was
intentional.
> 
> We try not to flag spec-compliant servers as failing, because people are
> sometimes a little careless about "fixing" failures that in their
particular case
> really shouldn't be fixed.  But sometimes it's still useful to have a test
that goes
> somewhat beyond the spec.
> 
> There might be other ways to handle that kind of test, but it would need
some
> more thought.

There are also tests that are server specific, for example, there are tests
that are Ganesha specific. For example, look at LOCK11g. LOCK11 attempts to
make a bad stateid, and it sort of "knows" how the server formats its
stateids. There is a function makeBadIDganesha that "knows" how Ganesha
forms its stateids and forms a bad one that will definitely result in an
NSF4ERR_BAD_STATEID.

There are also a number of tests that require specific setup bits to work
that someone who just fires up a server won't have set up. I think there are
some that expect specific exports, or second exports or other specific
aspects of the pseudofs. There are tests that deal with server reboots.

At the least, I want a way to specify to run all the tests that are expected
to pass on a server that has been set up without any special cases, and that
are expected to pass on Linux.

The Ganesha tag, in addition to specifying a few Ganesha only tests,
specifies several tests that may not pass on Linux in general (so they
aren't in all) but do pass on Ganesha.

On the flip side, Ganesha lives with a handful of known failures...

Frank

> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  nfs4.1/testmod.py | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > If this is unacceptable, then an alternative could be to add a new
> > (similarly special-cased) "everything" flag.
> >
> > diff --git a/nfs4.1/testmod.py b/nfs4.1/testmod.py index
> > 11e759d673fd..7b3bac543084 100644
> > --- a/nfs4.1/testmod.py
> > +++ b/nfs4.1/testmod.py
> > @@ -386,6 +386,8 @@ def createtests(testdir):
> >      for t in tests:
> >  ##         if not t.flags_list:
> >  ##             raise RuntimeError("%s has no flags" % t.fullname)
> > +        if "all" not in t.flags_list:
> > +            t.flags_list.append("all")
> >          for f in t.flags_list:
> >              if f not in flag_dict:
> >                  flag_dict[f] = bit
> > --
> > 2.39.2

