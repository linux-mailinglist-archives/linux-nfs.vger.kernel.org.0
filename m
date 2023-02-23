Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34D36A0CBB
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Feb 2023 16:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjBWPUB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Feb 2023 10:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBWPUA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Feb 2023 10:20:00 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14C126B6
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 07:19:59 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4F4C9BC3; Thu, 23 Feb 2023 10:19:59 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4F4C9BC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1677165599;
        bh=Zx7k7eb5uyiKDdh1jt89wHdH0AleamCeFrIUoz2XobU=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=F4uTtpUAjzl/pEZ1caY6jxzD/qXDSE2QIHF+hqvoYHHcBa1LOIrH/SItK6te6B3yo
         IyeUeabU3lPLJZ6ywmLnENu7pbMsgABe+JG8tDhJ0M0Og7HnPFLc6ox3DUDM6iu+Oc
         b5mjSP9/srjPjO8hzVoXHpj16mOhTVm59FBSdcrw=
Date:   Thu, 23 Feb 2023 10:19:59 -0500
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dai.ngo@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [pynfs RFC PATCH] testserver.py: special-case the "all" flag
Message-ID: <20230223151959.GC10456@fieldses.org>
References: <20230222182043.155712-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222182043.155712-1-jlayton@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 22, 2023 at 01:20:43PM -0500, Jeff Layton wrote:
> The READMEs for v4.0 and v4.1 are inconsistent here. For v4.0, the "all"
> flag is supposed to run all of the "standard" tests. For v4.1 "all" is
> documented to run all of the tests, but it actually doesn't since not
> every tests has "all" in its FLAGS: field.
> 
> I move that we change this. If I say that I want to run "all", then I
> really do want to run _all_ of the tests. Ensure that every test has the
> "all" flag set.

In some (all?) cases where the "all" flag was left off, it was
intentional.

We try not to flag spec-compliant servers as failing, because people are
sometimes a little careless about "fixing" failures that in their
particular case really shouldn't be fixed.  But sometimes it's still
useful to have a test that goes somewhat beyond the spec.

There might be other ways to handle that kind of test, but it would need
some more thought.

--b.

> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  nfs4.1/testmod.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> If this is unacceptable, then an alternative could be to add a new
> (similarly special-cased) "everything" flag.
> 
> diff --git a/nfs4.1/testmod.py b/nfs4.1/testmod.py
> index 11e759d673fd..7b3bac543084 100644
> --- a/nfs4.1/testmod.py
> +++ b/nfs4.1/testmod.py
> @@ -386,6 +386,8 @@ def createtests(testdir):
>      for t in tests:
>  ##         if not t.flags_list:
>  ##             raise RuntimeError("%s has no flags" % t.fullname)
> +        if "all" not in t.flags_list:
> +            t.flags_list.append("all")
>          for f in t.flags_list:
>              if f not in flag_dict:
>                  flag_dict[f] = bit
> -- 
> 2.39.2
