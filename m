Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F154B6A0CB5
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Feb 2023 16:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbjBWPTA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Feb 2023 10:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjBWPSv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Feb 2023 10:18:51 -0500
X-Greylist: delayed 436 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Feb 2023 07:18:49 PST
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A15A4FCA6
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 07:18:49 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2B36B71E5; Thu, 23 Feb 2023 10:11:32 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2B36B71E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1677165092;
        bh=e+b3OdxRvhYlyN22wXwefVPgomZyuta/bAqifBiVNsA=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=dbCHb2EvgqI0xPFlP5G3NsVUqyppEucuVgxBnK4itXZxliQrm5YmOFGbk2il/eFk0
         EK9yZ297cU1tjm7m8j3sD/IsvivISUL9NJRL85p0jZNBw82obi9Ztt0I5QPKnJC/c9
         vlNY6KWgipPPBYR78qDxS/rV5uSOp1shGM7jV++w=
Date:   Thu, 23 Feb 2023 10:11:32 -0500
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dai.ngo@oracle.com, linux-nfs@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>
Subject: Re: [pynfs RFC PATCH] nfs4.0/testserver.py: don't return an error
 when tests fail
Message-ID: <20230223151132.GA10456@fieldses.org>
References: <20230222134952.32851-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222134952.32851-1-jlayton@kernel.org>
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

I orginally thought I'd continue maintaining pynfs on a volunteer basis,
but I haven't been.  These all look like reasonable changes, but someone
else probably needs to step in to make sure they're handled in a
reasonable amount of time.

--b.

On Wed, Feb 22, 2023 at 08:49:52AM -0500, Jeff Layton wrote:
> This script was originally changed in eb3ba0b60055 ("Have testserver.py
> have non-zero exit code if any tests fail"), but the same change wasn't
> made to the 4.1 testserver.py script.
> 
> There also wasn't much explanation for it, and it makes it difficult to
> tell whether the test harness itself failed, or whether there was a
> failure in a requested test.
> 
> Stop the 4.0 testserver.py from exiting with an error code when a test
> fails, so that a successful return means only that the test harness
> itself worked, not that every requested test passed.
> 
> Cc: Frank Filz <ffilzlnx@mindspring.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  nfs4.0/testserver.py | 2 --
>  1 file changed, 2 deletions(-)
> 
> I'm not sure about this one. I've worked around this in kdevops for now,
> but it would really be preferable if it worked this way, imo. If this
> isn't acceptable, maybe we can add a new option that enables this
> behavior?
> 
> Frank, what was the original rationale for eb3ba0b60055 ?
> 
> diff --git a/nfs4.0/testserver.py b/nfs4.0/testserver.py
> index f2c41568e5c7..4f4286daa657 100755
> --- a/nfs4.0/testserver.py
> +++ b/nfs4.0/testserver.py
> @@ -387,8 +387,6 @@ def main():
>  
>      if nfail < 0:
>          sys.exit(3)
> -    if nfail > 0:
> -        sys.exit(2)
>  
>  if __name__ == "__main__":
>      main()
> -- 
> 2.39.2
