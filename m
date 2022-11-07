Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE22261EA11
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 05:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiKGEFy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Nov 2022 23:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiKGEFy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Nov 2022 23:05:54 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1989360C5;
        Sun,  6 Nov 2022 20:05:53 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-367b8adf788so93627147b3.2;
        Sun, 06 Nov 2022 20:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AkJkBFRHBq0yfkGW73lPxetYhgvhGPajTrAk3G/9Ib8=;
        b=l76CZi9ffkLkjLH0uPqxFLum3ZPXPgvFsx94x92ZMW+iRTJpqvNZ6mJdin35gvI8Wy
         oiQblbKk1IyBtVclvaaScdG89l2vbM/ocXun63GV7nsM/GCLfogubbVYjKhIYaDS/ClF
         dOEI/CJr2t8D+nedgpbC2e/r0rjjfqCGy6EzQzN2SzRgThphX4Mkvrw08Z0M4vwgdMKB
         2IOrV+Mq6lLdp86g51v+QccKOg9ViDjO3ey7FZWEv1x4vjpxi0nQVhRYpM+Q+nfXbMPv
         w1+9eTc8GUk+ZpA8n7XN2n7+RxT59agVflnG9qUfafNRAjl/fsRW079igL96PhtN1qFS
         pLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkJkBFRHBq0yfkGW73lPxetYhgvhGPajTrAk3G/9Ib8=;
        b=kTtvtuM6hgISNhN7SsAwB6Z1ZU2E25r7y8GUaxmAJW2tY8ngct5L3XMpLP6YLoRDg4
         sBuPZpCVYGCMOaJ5JzW8r7R/6yNMAFyRumHQ+Sk92PmxBFO0yXCwknMOiVzmMUROzTAA
         Cakaxa9sVM/H+wslJAwGN9qjhOxK82bbeAINjQ5hPuuVfMv1x0SDDoe/EexIYs6X11rT
         8r+dft2n2IZ5I+e7rLLNHlbZKLZ8wFRVCide1ztIficwK2LY/aIKA+n381VA4tbLlKOg
         W5Zvn+Yd9HiMmoanrDael3NOTFfvqQXSxXB0xp6NMEwiFj5ZYkFBDkvRbjukzUs+QReK
         adHg==
X-Gm-Message-State: ACrzQf31oS3teWaS6srCONrHE0NLI95mVbPq3WE1Uo5k34eXeB+m9le5
        zMWdmdI51fH3P5WUzTcRFJajbox+3DbFO371nieXwoFUS5g=
X-Google-Smtp-Source: AMsMyM6IgCjLx4iJBoc5hixwYAuTEy1/iOgTcj82ZwiZJ8/dkS3LhmZEuwpI3Z1/u0393lQ6moQoTg5gWNanCTh7phg=
X-Received: by 2002:a81:7b83:0:b0:370:2bf7:ec61 with SMTP id
 w125-20020a817b83000000b003702bf7ec61mr44305856ywc.46.1667793952354; Sun, 06
 Nov 2022 20:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20221105032329.2067299-1-zlang@kernel.org>
In-Reply-To: <20221105032329.2067299-1-zlang@kernel.org>
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Mon, 7 Nov 2022 12:05:41 +0800
Message-ID: <CADJHv_vHbto5c4Ubzpg0teYYQb3Cnre8OwPpTpa0EDao5skeCw@mail.gmail.com>
Subject: Re: [PATCH] nfs: test files written size as expected
To:     Zorro Lang <zlang@kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Cc:     fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Looks good to me.

Ccing linux-nfs@ for reviewing.

On Sat, Nov 5, 2022 at 11:49 AM Zorro Lang <zlang@kernel.org> wrote:
>
> Test nfs and its underlying fs, make sure file size as expected
> after writting a file, and the speculative allocation space can
> be shrunken.
>
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>
> Hi,
>
> The original bug reproducer is:
> 1. mount nfs3 backed by xfs
> 2. dd if=/dev/zero of=/nfs/10M bs=1M count=10
> 3. du -sh /nfs/10M
> 16M     /nfs/10M
>
> As this was a xfs issue, so cc linux-xfs@ to get review.
>
> Thanks,
> Zorro
>
>  tests/nfs/002     | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tests/nfs/002.out |  2 ++
>  2 files changed, 45 insertions(+)
>  create mode 100755 tests/nfs/002
>  create mode 100644 tests/nfs/002.out
>
> diff --git a/tests/nfs/002 b/tests/nfs/002
> new file mode 100755
> index 00000000..3d29958d
> --- /dev/null
> +++ b/tests/nfs/002
> @@ -0,0 +1,43 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 002
> +#
> +# Make sure nfs gets expected file size after writting a big sized file. It's
> +# not only testing nfs, test its underlying fs too. For example a known old bug
> +# on xfs (underlying fs) caused nfs get larger file size (e.g. 16M) after
> +# writting 10M data to a file. It's fixed by a series of patches around
> +# 579b62faa5fb16 ("xfs: add background scanning to clear eofblocks inodes")
> +#
> +. ./common/preamble
> +_begin_fstest auto rw
> +
> +# real QA test starts here
> +_supported_fs nfs
> +_require_test
> +
> +localfile=$TEST_DIR/testfile.$seq
> +rm -rf $localfile
> +
> +$XFS_IO_PROG -f -t -c "pwrite 0 10m" -c "fsync" $localfile >>$seqres.full 2>&1
> +block_size=`stat -c '%B' $localfile`
> +iblocks_expected=$((10 * 1024 * 1024 / $block_size))
> +# Try several times for the speculative allocated file size can be shrunken
> +res=1
> +for ((i=0; i<10; i++));do
> +       iblocks_real=`stat -c '%b' $localfile`
> +       if [ "$iblocks_expected" = "$iblocks_real" ];then
> +               res=0
> +               break
> +       fi
> +       sleep 10
> +done
> +if [ $res -ne 0 ];then
> +       echo "Write $iblocks_expected blocks, but get $iblocks_real blocks"
> +fi
> +
> +echo "Silence is golden"
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/nfs/002.out b/tests/nfs/002.out
> new file mode 100644
> index 00000000..61705c7c
> --- /dev/null
> +++ b/tests/nfs/002.out
> @@ -0,0 +1,2 @@
> +QA output created by 002
> +Silence is golden
> --
> 2.31.1
>
