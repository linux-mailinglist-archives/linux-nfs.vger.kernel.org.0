Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6306F8C76
	for <lists+linux-nfs@lfdr.de>; Sat,  6 May 2023 00:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjEEWjf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 May 2023 18:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjEEWje (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 May 2023 18:39:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23089618C;
        Fri,  5 May 2023 15:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2D7564125;
        Fri,  5 May 2023 22:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019F5C433D2;
        Fri,  5 May 2023 22:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683326370;
        bh=PKPYRvDBNwSHLp6+DPZDUQgj9soQkIFjAjyI+WzHSgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZNErnhJ04Mekg84VApgZdDi/kKmy+y98mHNRmbJnlKDHkAP6EKeNtQ4ELGxpbi/iZ
         6kTykbXQVZsOEL1qjAn575IrshMjtRCmCymAmTajd+nxTiXRzKEO2hGMPk+n9jFPXF
         lweGhKb4qFeydoNYuUk48WkMsvRmP5zSq4mc2FftQn4qcv3EwjP9fmQKeM9fQzfqlT
         ECM9y+Z9CD0FJ7rfDokKDZya/nQsWZD0VBnh2QLwKsczWdSzafDq/of44teFeZWmvj
         Gj30zEJ37SWfVBpVDo/HUBlof68XDM0bRjfS4kgk/1E9pZoEqUlJjmWcS6ZKm3DTcV
         w0azUJO3JRhcA==
Date:   Fri, 5 May 2023 15:39:29 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/728: Add a test for xattr ctime updates
Message-ID: <20230505223929.GA15384@frogsfrogsfrogs>
References: <20230505172427.94963-1-anna@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505172427.94963-1-anna@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 05, 2023 at 01:24:27PM -0400, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> The NFS client wasn't updating ctime after a setxattr request. This is a
> test written while fixing the bug.
> 
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> ---
> v2:
>  - Move test to generic/
>  - Address comments from the mailing list
> ---
>  tests/generic/728     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/728.out |  2 ++
>  2 files changed, 44 insertions(+)
>  create mode 100755 tests/generic/728
>  create mode 100644 tests/generic/728.out
> 
> diff --git a/tests/generic/728 b/tests/generic/728
> new file mode 100755
> index 000000000000..ab2414c151db
> --- /dev/null
> +++ b/tests/generic/728
> @@ -0,0 +1,42 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Netapp Inc., All Rights Reserved.
> +#
> +# FS QA Test 728
> +#
> +# Test a bug where the NFS client wasn't sending a post-op GETATTR to the
> +# server after setting an xattr, resulting in `stat` reporting a stale ctime.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick attr
> +
> +# Import common functions
> +. ./common/attr
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +_require_attrs
> +
> +rm -rf $TEST_DIR/testfile
> +touch $TEST_DIR/testfile
> +
> +
> +_check_xattr_op()
> +{
> +  what=$1
> +  shift 1
> +
> +  before_ctime=$(stat -c %z $TEST_DIR/testfile)
> +  $SETFATTR_PROG $* $TEST_DIR/testfile
> +  after_ctime=$(stat -c %z $TEST_DIR/testfile)

What happens if the filesystem's timestamp granularity isn't sufficient
to capture a difference across a setxattr operation?  Most of the time
we only update the (fast) timestamps at every clock tick, right?

--D

> +
> +  test "$before_ctime" != "$after_ctime" || echo "Expected ctime to change after $what."
> +}
> +
> +_check_xattr_op setxattr -n user.foobar -v 123
> +_check_xattr_op removexattr -x user.foobar
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/728.out b/tests/generic/728.out
> new file mode 100644
> index 000000000000..ab39f45fe5da
> --- /dev/null
> +++ b/tests/generic/728.out
> @@ -0,0 +1,2 @@
> +QA output created by 728
> +Silence is golden
> -- 
> 2.40.1
> 
