Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586516A0E12
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Feb 2023 17:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBWQcQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Feb 2023 11:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjBWQcP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Feb 2023 11:32:15 -0500
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Feb 2023 08:32:14 PST
Received: from mta-202a.earthlink-vadesecure.net (mta-202a.earthlink-vadesecure.net [51.81.232.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D5A1A4AE
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 08:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; bh=jloyMi0d7SuIsq3zPK0V5rTV9VPNizPYaviD3U
 lyh4Y=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1677169615;
 x=1677774415; b=VnPlbIHSMudpx3Ub3MUxWdlgEGN1b8cFZAW1tjpXz6YQOpShlBHEtK6
 ROGV2klAb6ufvY+F8oX0dwKWYh9UpboJq4EZjRpqfbNacxmA3ucLAcJiAaSqFcXRrQTCJoq
 OkbX2MUs0XQHjSL2typ7cRhSI0f+hw6HJqyfMsmOed5p/CX3eomwhkd8Ku3P+zigI4vPnzh
 cyRbvW2dasbS0jJY3WAu0tZDnFRHYwwtIvfhoyGf5e2R3RZQa4fnns1Du8W4XxHABZjmB3G
 xwbbENImspS+25Fk4RQKwolZhjt5OojgFQ8oAIyYCDma39GJr2ofCRF4NrftUAjimjxjjVc
 qUA==
Received: from FRANKSTHINKPAD ([174.174.49.201])
 by smtp.earthlink-vadesecure.net ESMTP vsel2nmtao02p with ngmta
 id 20019885-174680e10cafe05b; Thu, 23 Feb 2023 16:26:55 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Chuck Lever III'" <chuck.lever@oracle.com>,
        "'Bruce Fields'" <bfields@fieldses.org>
Cc:     "'Jeff Layton'" <jlayton@kernel.org>,
        "'Dai Ngo'" <dai.ngo@oracle.com>,
        "'Linux NFS Mailing List'" <linux-nfs@vger.kernel.org>,
        "'Calum Mackay'" <calum.mackay@oracle.com>
References: <20230222182043.155712-1-jlayton@kernel.org> <20230223151959.GC10456@fieldses.org> <3B034712-F376-4D71-8A72-703B030140F9@oracle.com>
In-Reply-To: <3B034712-F376-4D71-8A72-703B030140F9@oracle.com>
Subject: RE: [pynfs RFC PATCH] testserver.py: special-case the "all" flag
Date:   Thu, 23 Feb 2023 08:26:55 -0800
Message-ID: <029a01d947a3$a51b4750$ef51d5f0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFaakfSQa9czN/urkZcULRlvLq/BAI3dwcGAlJyRq6vtiJbEA==
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
> From: Chuck Lever III [mailto:chuck.lever@oracle.com]
> Sent: Thursday, February 23, 2023 8:22 AM
> To: Bruce Fields <bfields@fieldses.org>
> Cc: Jeff Layton <jlayton@kernel.org>; Dai Ngo <dai.ngo@oracle.com>; Linux
> NFS Mailing List <linux-nfs@vger.kernel.org>; Calum Mackay
> <calum.mackay@oracle.com>; Frank Filz <ffilzlnx@mindspring.com>
> Subject: Re: [pynfs RFC PATCH] testserver.py: special-case the "all" flag
> 
> 
> 
> > On Feb 23, 2023, at 10:19 AM, J. Bruce Fields <bfields@fieldses.org>
wrote:
> >
> > On Wed, Feb 22, 2023 at 01:20:43PM -0500, Jeff Layton wrote:
> >> The READMEs for v4.0 and v4.1 are inconsistent here. For v4.0, the
"all"
> >> flag is supposed to run all of the "standard" tests. For v4.1 "all"
> >> is documented to run all of the tests, but it actually doesn't since
> >> not every tests has "all" in its FLAGS: field.
> >>
> >> I move that we change this. If I say that I want to run "all", then I
> >> really do want to run _all_ of the tests. Ensure that every test has
> >> the "all" flag set.
> >
> > In some (all?) cases where the "all" flag was left off, it was
> > intentional.
> >
> > We try not to flag spec-compliant servers as failing, because people
> > are sometimes a little careless about "fixing" failures that in their
> > particular case really shouldn't be fixed.  But sometimes it's still
> > useful to have a test that goes somewhat beyond the spec.
> >
> > There might be other ways to handle that kind of test, but it would
> > need some more thought.
> 
> We could use a different name for "all" since it doesn't actually run
/all/ tests.
> Jeff suggested "standard", which seems sensible.

The challenge with changing this is all the CI scripts and other testing
scripts out there that use all. If all suddenly changed, server maintainers
might get a deluge of bug reports for failing odd test cases no one
necessarily expected to work...

> Also, we could add test categories specifically for particular server
> implementations, if that's interesting to folks.

I have already done so with a ganesha tag...

Literally all anyone has to do is start using a new tag so it's a trivial
thing for developers to add.

> 
> > --b.
> >
> >> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >> ---
> >> nfs4.1/testmod.py | 2 ++
> >> 1 file changed, 2 insertions(+)
> >>
> >> If this is unacceptable, then an alternative could be to add a new
> >> (similarly special-cased) "everything" flag.
> >>
> >> diff --git a/nfs4.1/testmod.py b/nfs4.1/testmod.py index
> >> 11e759d673fd..7b3bac543084 100644
> >> --- a/nfs4.1/testmod.py
> >> +++ b/nfs4.1/testmod.py
> >> @@ -386,6 +386,8 @@ def createtests(testdir):
> >>     for t in tests:
> >> ##         if not t.flags_list:
> >> ##             raise RuntimeError("%s has no flags" % t.fullname)
> >> +        if "all" not in t.flags_list:
> >> +            t.flags_list.append("all")
> >>         for f in t.flags_list:
> >>             if f not in flag_dict:
> >>                 flag_dict[f] = bit
> >> --
> >> 2.39.2
> 
> --
> Chuck Lever
> 


