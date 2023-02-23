Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDAF6A0DCE
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Feb 2023 17:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjBWQW5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Feb 2023 11:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjBWQW4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Feb 2023 11:22:56 -0500
Received: from mta-102a.earthlink-vadesecure.net (mta-102a.earthlink-vadesecure.net [51.81.61.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69BF14EAA
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 08:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; bh=7lo335aTzNQ/9vAmYhc3ie1JdbQ5ELC2wduoE9
 KSQEI=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1677169361;
 x=1677774161; b=iJhfFQ+8DUwcmeVEQDbA2gkZ55f7be0GxN/rjtAtCfigTN1fkvohXKr
 n7yVtNde+gx7Om/oWrKqtYw/gs/ajo1V+7IsLa6TquVK0/wJwwpKktSOxqlcKsFgI7AVmwb
 H2xsmp7VvPxxK60MGblA2kt4UvBq5x465UUxfc9wbwVKXc5LfHdpWYleP4S/mBtKBB3+KhJ
 Bm0QaeY2a/ZJOJVxBADT6nu8sA6vQ1VJ08Gs7KVbknCUgXNZwu3orwMr7Nx2fH6YL+oni0t
 /PjtqIptpbnRfg5sKUR7yCShT7V32LeazoTuBFtFGmXKG/RZM9+BjIrmv0VXbSZDYJ+cBQQ
 T0w==
Received: from FRANKSTHINKPAD ([174.174.49.201])
 by smtp.earthlink-vadesecure.net ESMTP vsel1nmtao02p with ngmta
 id 9634fb4c-174680a5e1000490; Thu, 23 Feb 2023 16:22:41 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Jeff Layton'" <jlayton@kernel.org>, <bfields@fieldses.org>,
        <dai.ngo@oracle.com>
Cc:     <linux-nfs@vger.kernel.org>
References: <20230222134952.32851-1-jlayton@kernel.org>
In-Reply-To: <20230222134952.32851-1-jlayton@kernel.org>
Subject: RE: [pynfs RFC PATCH] nfs4.0/testserver.py: don't return an error when tests fail
Date:   Thu, 23 Feb 2023 08:22:40 -0800
Message-ID: <029901d947a3$0dd00c00$29702400$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQInBvp4ShtorjsaZdmfQzq7ERPYu65BNzBg
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

> From: Jeff Layton [mailto:jlayton@kernel.org]
 
> This script was originally changed in eb3ba0b60055 ("Have testserver.py
have
> non-zero exit code if any tests fail"), but the same change wasn't made to
the
> 4.1 testserver.py script.
> 
> There also wasn't much explanation for it, and it makes it difficult to
tell
> whether the test harness itself failed, or whether there was a failure in
a
> requested test.
> 
> Stop the 4.0 testserver.py from exiting with an error code when a test
fails, so
> that a successful return means only that the test harness itself worked,
not that
> every requested test passed.
> 
> Cc: Frank Filz <ffilzlnx@mindspring.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  nfs4.0/testserver.py | 2 --
>  1 file changed, 2 deletions(-)
> 
> I'm not sure about this one. I've worked around this in kdevops for now,
but it
> would really be preferable if it worked this way, imo. If this isn't
acceptable,
> maybe we can add a new option that enables this behavior?
> 
> Frank, what was the original rationale for eb3ba0b60055 ?

We needed a way for CI to easily detect failure of pynfs. I'm not sure how
helpful it is since Ganesha does fail some tests...

It might be helpful to have some helpers for CI to use, or an option that
causes pynfs to report in a way that's much easier for CI to determine if
pynfs succeeded or not.

Hmm, one thing that would help is to be able to flag a set of tests that
should not constitute a CI failure (known errors) but we want to keep
running them because of what they exercise, or to more readily detect that
they have been fixed.

> diff --git a/nfs4.0/testserver.py b/nfs4.0/testserver.py index
> f2c41568e5c7..4f4286daa657 100755
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

