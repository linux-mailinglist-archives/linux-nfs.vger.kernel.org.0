Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB79598FBA
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Aug 2022 23:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347095AbiHRVlS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Aug 2022 17:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347114AbiHRVlQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Aug 2022 17:41:16 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD4CC00E1
        for <linux-nfs@vger.kernel.org>; Thu, 18 Aug 2022 14:41:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id f22so3475055edc.7
        for <linux-nfs@vger.kernel.org>; Thu, 18 Aug 2022 14:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jWdgShH+woaXq6LOzYOjpkqUkDg6p0AAjgsSfaYQc1s=;
        b=co400v7LaMrxlNvxVM1VR2thuF91ykiiJi31rjmHT76zWLXsUz/lGYxp6y1PNBtp7I
         nhre4aYfbd/ABLXxh9NEQS4s868Y+KQ2J0cii84Z9rVUsZF7VQ4yMBa2HlgQkbD+OKqK
         inXQVNLeeQriNCV6LU19y9nYh1UPaCNKFxHFNXLu0555fMjveHREZ0YHftVp5ldMdhi/
         k6S1fL0Ge7oEvojVQEfzAe9mRXCTZz8uphm60jjQfRL9pcT0V1OjwAJ7A1U6txQr1vyX
         IRs5OYQGGwK2ZW00khpmGk+tY+NU57qBvAQpG8iMv2399HK6q6cA6/ark6r/1cNEMvhK
         RV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jWdgShH+woaXq6LOzYOjpkqUkDg6p0AAjgsSfaYQc1s=;
        b=oI03jBAm/nKN82Z+go6++ToWdRVzjDKc09qtvqQnCb3+g/GN1ezsmLJxzY9sNVoeS8
         9KOTNqRie8XfmUPSk2M3al4tS52RarX+yf+4Wx5MiCosmDZHR9OWzUqykbRXSTyY4ZM8
         zbVHb5DtyIGV8Kcsu074YrGu5/mVOJOi9PP0H+b1CfbPkMXGgJ7BrzTYiPYs0Zb+6f/4
         g5ZJ/GAJmOKg2A69NMAUGcaQ7R+UbLCgpOb7MH7zgZn5v+VWFMZ4AhiQ2nDU7ynXQpJ5
         gqA2DNQ++4PB+9lAPI3q+GwUIodfgKb8MJ7EhWJJbMp9AAbrJJmHInGYw1tg6fRzI4K2
         Hxhg==
X-Gm-Message-State: ACgBeo3L6gOEk12Pvg+9jEQ0bre9dxcXUYt8UZEln/9K62SAtcMDw24K
        A4pWHfFvoqZr1bmhwyHNreqwkOVCuSQoZzCvtnM=
X-Google-Smtp-Source: AA6agR5yyWmG1D1qHcdI7lI0fsOJq8w6evcXBYHYQw4IrXPn2jyR1uh9kTXvAiBxM58dAMf+7AkZLggtGfMXTn9MsSY=
X-Received: by 2002:a05:6402:40c2:b0:440:4ecd:f75f with SMTP id
 z2-20020a05640240c200b004404ecdf75fmr3605699edb.405.1660858872480; Thu, 18
 Aug 2022 14:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <166063173439.5425.8345694210902041629@noble.neil.brown.name>
In-Reply-To: <166063173439.5425.8345694210902041629@noble.neil.brown.name>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 18 Aug 2022 17:41:01 -0400
Message-ID: <CAN-5tyHdCigw38VYXFCOdsG2gcKfLp9jUFm_MFLK0PQi+vpjrg@mail.gmail.com>
Subject: Re: [PATCH] NFS: unlink/rmdir shouldn't call d_delete() twice on ENOENT
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 16, 2022 at 4:20 AM NeilBrown <neilb@suse.de> wrote:
>
>
> nfs_unlink() calls d_delete() twice if it receives ENOENT from the
> server - once in nfs_dentry_handle_enoent() from nfs_safe_remove and
> once in nfs_dentry_remove_handle_error().
>
> nfs_rmddir() also calls it twice - the nfs_dentry_handle_enoent() call
> is direct and inside a region locked with ->rmdir_sem
>
> It is safe to call d_delete() twice if the refcount > 1 as the dentry is
> simply unhashed.
> If the refcount is 1, the first call sets d_inode to NULL and the second
> call crashes.
>
> Refcount is almost always 1 in nfs_unlink() so this must almost never
> happen else we would have seen crashes before.
>
> This patch removes the d_delete() call from nfs_dentry_handle_enoent()
> so as to leave the one under ->remdir_sem in case that is important.
>
> Fixes: 9019fb391de0 ("NFS: Label the dentry with a verifier in nfs_rmdir() and nfs_unlink()")
> Signed-off-by: NeilBrown <neilb@suse.de>

This patch addresses the problem I previously reported. So Tested-by.

> ---
>  fs/nfs/dir.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index dbab3caa15ed..4648b421025c 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2382,7 +2382,6 @@ static void nfs_dentry_remove_handle_error(struct inode *dir,
>  {
>         switch (error) {
>         case -ENOENT:
> -               d_delete(dentry);
>                 nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
>                 break;
>         case 0:
> --
> 2.37.1
>
