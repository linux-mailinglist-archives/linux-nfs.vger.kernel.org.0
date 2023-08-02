Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD75476D3DA
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 18:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjHBQg7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 12:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjHBQgq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 12:36:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F26210D;
        Wed,  2 Aug 2023 09:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B29D61A3D;
        Wed,  2 Aug 2023 16:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D626EC433C7;
        Wed,  2 Aug 2023 16:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690994200;
        bh=sV9qWtZYA/XAbSOW2+izp/wRSw7lq0E1fHmoZAgWLrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iz7CQ3kle6mGVHxGfohYo3bXWW3hzdY38Zv0nm8z0QkgnWHDuXIuAX7WmFmXyF0+S
         SDCiLVTo3c34xmdYqltrLjab93qW/zng8X1CTyxNJKp9SM61iJcPOrkg4H3FtfdmA+
         XdkEbH3Aj9FMVyOGLgBsyEvAriW7CSBlqyvb702iCr6XiekcM5uKA9UOWBYG27rkOY
         RTwj6rmRNysL1yXOtGEtQVdWwpNlTMZTV+ZJdfSQupwIHCi89kGkKw3bBbfnuN/2X/
         zuHB3zYlQf0lOa4U4spaxllHfwMfnCMsRYm0I4GIsAmOc+wxB3x/YspXNTBi6eIOCK
         xzyNPBBX9fUmg==
Date:   Wed, 2 Aug 2023 09:36:40 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfs: test files written size as expected
Message-ID: <20230802163640.GY11352@frogsfrogsfrogs>
References: <20230802054646.2197854-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802054646.2197854-1-zlang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 02, 2023 at 01:46:46PM +0800, Zorro Lang wrote:
> Test nfs and its underlying fs, make sure file size as expected
> after writting a file, and the speculative allocation space can
> be shrunken.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
> 
> Last year I sent a patch to fstests@, but it sometimes fails on the upstream
> kernel that year:
> 
>   https://lore.kernel.org/fstests/Y3vTbHqT64gsQ573@magnolia/
> 
> And we didn't get a proper reason for that, so that patch was blocked. Now
> I found this case test passed on current upstream linux [1] (after loop
> running it a whole night). So I think it's time to rebase and re-send this
> patch to get review.
> 
> Thanks,
> Zorro
> 
> [1]
> FSTYP         -- nfs
> PLATFORM      -- Linux/x86_64 xxxx 6.5.0-rc4 #1 SMP PREEMPT_DYNAMIC Tue Aug  1 15:32:55 EDT 2023
> MKFS_OPTIONS  -- xxxx.redhat.com:/mnt/xfstests/scratch/nfs-server
> MOUNT_OPTIONS -- -o vers=4.2 -o context=system_u:object_r:root_t:s0 xxxx.redhat.com:/mnt/xfstests/scratch/nfs-server /mnt/xfstests/scratch/nfs-client
> 
> nfs/002 4s ...  4s
> Ran: nfs/002
> Passed all 1 tests
> 
>  tests/nfs/002     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nfs/002.out |  2 ++
>  2 files changed, 48 insertions(+)
>  create mode 100755 tests/nfs/002
>  create mode 100644 tests/nfs/002.out
> 
> diff --git a/tests/nfs/002 b/tests/nfs/002
> new file mode 100755
> index 00000000..b4b6554c
> --- /dev/null
> +++ b/tests/nfs/002
> @@ -0,0 +1,46 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 002
> +#
> +# Make sure nfs gets expected file size after writting a big sized file. It's
> +# not only testing nfs, test its underlying fs too. For example a known old bug
> +# on xfs (underlying fs) caused nfs get larger file size (e.g. 16M) after
> +# writting 10M data to a file. It's fixed by a series of patches around
> +# 579b62faa5fb16 ("xfs: add background scanning to clear eofblocks inodes")

Er... has this been banging around in the trunk for 11 years? ;)

> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw
> +
> +# real QA test starts here
> +_supported_fs nfs
> +# Need a series of patches related with this patch
> +_fixed_by_kernel_commit 579b62faa5fb16 \
> +	"xfs: add background scanning to clear eofblocks inodes"
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
> +	iblocks_real=`stat -c '%b' $localfile`
> +	if [ "$iblocks_expected" = "$iblocks_real" ];then

What happens if real < expected?  Should there be some sort of bail out
for unexpected things like that?

> +		res=0
> +		break
> +	fi
> +	sleep 10
> +done

Though I guess the runtime is capped at ~100s so maybe it doesn't
matter practically.

(What happens if xfs blockgc only runs every 5 minutes?)

--D

> +if [ $res -ne 0 ];then
> +	echo "Write $iblocks_expected blocks, but get $iblocks_real blocks"
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
> 2.40.1
> 
