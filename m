Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4B8705161
	for <lists+linux-nfs@lfdr.de>; Tue, 16 May 2023 17:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjEPPAg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 May 2023 11:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjEPPAa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 May 2023 11:00:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E554487;
        Tue, 16 May 2023 08:00:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CE5C62848;
        Tue, 16 May 2023 15:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81940C433D2;
        Tue, 16 May 2023 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684249228;
        bh=Nn2s+2bIiaTZdGebq+VZ2gTYpRfgXxTZZanKy2Bqze4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YxeCMFc/HZW21O3XAx/9Ecorg4UjhGccbhvUmqw1YPFJlJ0uakCBTjE0WXvvH6ObF
         JMhmB91dirsabyy6uS5BhZBJ1yooIWrnel5qjtcTDJpZOkHQySzXiHkEKyuCag1bL7
         rDsi8sVi87T0OGI59goCdcCDh3U/DgOPdKR9+J5iZ9aP/CxYQP7R0tYzlHKhpXMtWs
         kulPtypjrg+sDModF1NfQPDn46wuBweuZjBUTxzdRx7JskQU1x3/n54X+K/HNlDbYi
         GPIAgzPyW6VFRqm2TN3GWUcgXu/le1x0cyb3d57jvok3LIO2DhAeR9NDZfk8z5WU6H
         EUWjKlOa4hedA==
Date:   Tue, 16 May 2023 08:00:27 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, fstests@vger.kernel.org,
        zlang@redhat.com
Subject: Re: [PATCH v3] generic/728: Add a test for xattr ctime updates
Message-ID: <20230516150027.GB858795@frogsfrogsfrogs>
References: <20230516141407.201674-1-anna@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516141407.201674-1-anna@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 16, 2023 at 10:14:07AM -0400, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> The NFS client wasn't updating ctime after a setxattr request. This is a
> test written while fixing the bug.
> 
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> ---
> v3:
>  - Add a 2 second sleep before changing the xattr
> 
> v2:
>  - Move test to generic/
>  - Address comments from the mailing list
> ---
>  tests/generic/728     | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/728.out |  2 ++
>  2 files changed, 45 insertions(+)
>  create mode 100755 tests/generic/728
>  create mode 100644 tests/generic/728.out
> 
> diff --git a/tests/generic/728 b/tests/generic/728
> new file mode 100755
> index 000000000000..8e52eb4b219c
> --- /dev/null
> +++ b/tests/generic/728
> @@ -0,0 +1,43 @@
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

nit: only common/* functions are supposed to have a leading underscore
in the name.

> +{
> +  what=$1
> +  shift 1
> +
> +  before_ctime=$(stat -c %z $TEST_DIR/testfile)
> +  sleep 2

I think it would be useful to document that 2 seconds is the worst ctime
granularity that we expect from any filesystem (fat) that might pass
through fstests.

Just in case, you know, we /ever/ create a fsinfo call to export
information like that, and need to refactor all these 'sleep 2'.

"sleep 2 # maximum known ctime granularity is 2s for fat"

With those two things fixed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> +  $SETFATTR_PROG $* $TEST_DIR/testfile
> +  after_ctime=$(stat -c %z $TEST_DIR/testfile)
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
