Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8E17A9BA1
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Sep 2023 21:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjIUTDH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Sep 2023 15:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjIUTCp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Sep 2023 15:02:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352367B96D
        for <linux-nfs@vger.kernel.org>; Thu, 21 Sep 2023 10:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695317822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oK2PX137XfTZOWRLKOkFV4Sa+eaXzi/ddegWpwPmmro=;
        b=LdmDX3Nxl3egsXbRDO2a1J1SyewJFg4zHxSye+ZR0K9AOA23j3jKqAWbPbf0rCwc5NPhxN
        4uYob3JMqY32x7EMAX/Qa0QCTzWfCIy7kCa1WuUlmArW42GJ6gX62zEZSHH0/dSpPs5H5n
        8FAR743pto9JaAuyDsSmeFwifOkNMJQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-mUrt3AzuM4SyZWCzE0M2nQ-1; Thu, 21 Sep 2023 10:20:47 -0400
X-MC-Unique: mUrt3AzuM4SyZWCzE0M2nQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-577af71a2a8so822937a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 21 Sep 2023 07:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695306045; x=1695910845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK2PX137XfTZOWRLKOkFV4Sa+eaXzi/ddegWpwPmmro=;
        b=boStPuxnCPvAmAGWIo4KZbwZ6sK/MgzjzMPwWAAXesZlCSzJGzt4cLuV7eWLHX6j2Y
         hVQm1a2/jO/C4fWw/mQFQPeeh9WyEZ3550H8MMxLxuSbRPBTukXGmZTXaXk8ndlfkEl7
         Ow6d20rdNcOUvBgEc4Eova3GsGtfba9bVPwoEjh+wqtD48bIsbca8FowaBQkd9aMOMVk
         zVpAn8r9pM8zLLaRut1+x/B1SGHYQdNE5CW0uZ9CBOEkgbsTWuPPrkYFRfqOMkpkCHvL
         z718xSzIaZwd5IRCBOUzpwyeQnG19ElmNbTUvb1IjNqS9LURed8yRRdv73EIK/7scpCD
         tjBA==
X-Gm-Message-State: AOJu0Yy41MnBFo61xFUddhCk6v9kU+qq2ltvXmDJtN9ES9oexM2TVNEb
        fgcP9UizmRGWsuUKiRFtK+s4lmTkC17fO9Zttoeo/UZP1r1k+HmQBIdTl8aLzoGQRnXjsvxu5zl
        wP0+1Vt55ObbjPUcDbIY8
X-Received: by 2002:a17:902:e851:b0:1b8:8af0:416f with SMTP id t17-20020a170902e85100b001b88af0416fmr5592885plg.1.1695306044992;
        Thu, 21 Sep 2023 07:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQyylMW0W28BrF97Ryzwd7N7x6wv78ELjt1csgIkBrtP15gOHsBecy+9nrfVNi5btFXUa0wA==
X-Received: by 2002:a17:902:e851:b0:1b8:8af0:416f with SMTP id t17-20020a170902e85100b001b88af0416fmr5592862plg.1.1695306044621;
        Thu, 21 Sep 2023 07:20:44 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902ee5100b001bb7a736b4csm1550033plo.77.2023.09.21.07.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:20:44 -0700 (PDT)
Date:   Thu, 21 Sep 2023 22:20:40 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Yongcheng Yang <yoyang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH] generic/471: add a test to check move in mountpoints of
 the same export
Message-ID: <20230921142040.hw6szynpmemusdi3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20230921134347.839957-1-yoyang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921134347.839957-1-yoyang@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 21, 2023 at 09:43:47PM +0800, Yongcheng Yang wrote:
> Add a new test to ckeck file move (rename) operation among
> different mount points which are mounting to a same export.
> 
> This should be a simple test but it recently unveils an ancient
> nfsd bug. Thus let's make it to be a regresstion check.
> 
> Signed-off-by: Yongcheng Yang <yoyang@redhat.com>
> ---
> 
> Hi,
> 
> There is an ancient nfsd problem just pop up and is now resolved by
> the upstream commit [1]. Looks like it's a basic and simple test which
> is probably appropriate for the fstest IMO.
> 
> This test in nfs will be failed without patch [1]:
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> [root@kvm-07-guest24 xfstests]# ./check -nfs generic/471
> FSTYP     	-- nfs
> PLATFORM  	-- Linux/x86_64 kvm-07-guest24 5.14.0-abc.el9.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Sep 13 04:59:08 EDT 2023
> MKFS_OPTIONS  -- localhost:/export_test2
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 localhost:/export_test2 /mnt_scratch
> 
> generic/471 1s ... - output mismatch (see /root/xfstests/results//generic/471.out.bad)
> 	--- tests/generic/471.out    2023-09-21 05:55:28.514673177 -0400
> 	+++ /root/xfstests/results//generic/471.out.bad    2023-09-21 08:06:16.935695355 -0400
> 	@@ -1,2 +1,3 @@
>  	QA output created by 471
>  	Silence is golden
> 	+mv: '/mnt_test/mountpoint1-471/A/f' and '/mnt_test/mountpoint1-471/B/f' are the same file
> 	...
> 	(Run 'diff -u /root/xfstests/tests/generic/471.out /root/xfstests/results//generic/471.out.bad'  to see the entire diff)
> 
> HINT: You _MAY_ be missing kernel fix:
>   	fdd2630a739819 nfsd: fix change_info in NFSv4 RENAME replies
> 
> Ran: generic/471
> Failures: generic/471
> Failed 1 of 1 tests
> 
> [root@kvm-07-guest24 xfstests]#
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> And it can pass after that patch [1] merged:
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> [root@fsqe-r6515-02 xfstests]# ./check -nfs generic/471
> FSTYP     	-- nfs
> PLATFORM  	-- Linux/x86_64 fsqe-r6515-02 5.14.0-abcd.el9.x86_64 #1 SMP PREEMPT_DYNAMIC Tue Sep 19 08:10:36 EDT 2023
> MKFS_OPTIONS  -- localhost:/export_test1
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 localhost:/export_test1 /mnt_scratch
> 
> generic/471    	0s
> Ran: generic/471
> Passed all 1 tests
> 
> [root@fsqe-r6515-02 xfstests]#
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> Also I have just checked the xfs and overlayfs but the latter get failed:
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> [root@fsqe-r6515-02 xfstests]# ./check generic/471
> FSTYP         -- xfs (non-debug)
> PLATFORM      -- Linux/x86_64 fsqe-r6515-02 5.14.0-abcd.el9.x86_64 #1 SMP PREEMPT_DYNAMIC Tue Sep 19 08:10:36 EDT 2023
> MKFS_OPTIONS  -- -f /dev/loop1
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt_scratch
> 
> generic/471 0s ...  1s
> Ran: generic/471
> Passed all 1 tests
> 
> [root@fsqe-r6515-02 xfstests]#
> [root@fsqe-r6515-02 xfstests]# ./check -overlay generic/471
> FSTYP         -- overlay
> PLATFORM      -- Linux/x86_64 fsqe-r6515-02 5.14.0-abcd.el9.x86_64 #1 SMP PREEMPT_DYNAMIC Tue Sep 19 08:10:36 EDT 2023
> MKFS_OPTIONS  -- /mnt_scratch
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /mnt_scratch /mnt_scratch/ovl-mnt
> 
> generic/471 0s ... - output mismatch (see /root/xfstests/results//generic/471.out.bad)
>     --- tests/generic/471.out	2023-09-21 09:02:14.580495256 -0400
>     +++ /root/xfstests/results//generic/471.out.bad	2023-09-21 09:02:51.145345830 -0400
>     @@ -1,2 +1,3 @@
>      QA output created by 471
>      Silence is golden
>     +mv: '/mnt_test/ovl-mnt/mountpoint1-471/A/f' and '/mnt_test/ovl-mnt/mountpoint1-471/B/f' are the same file

Does the underlying fs affect this testing result?

CC Amir to get his review on this overlay specific failure.

>     ...
>     (Run 'diff -u /root/xfstests/tests/generic/471.out /root/xfstests/results//generic/471.out.bad'  to see the entire diff)
> Ran: generic/471
> Failures: generic/471
> Failed 1 of 1 tests
> 
> [root@fsqe-r6515-02 xfstests]#
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> For now I'm not sure if the overlayfs don't support this operation or
> we just need to fix that.
> 
> Thanks,
> Yongcheng
> 
> [1] https://lore.kernel.org/linux-nfs/ZPyMyv1nNFV2whKP@tissot.1015granger.net/T/#t
> 
> 
>  tests/generic/471     | 60 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/471.out |  2 ++
>  2 files changed, 62 insertions(+)
>  create mode 100755 tests/generic/471
>  create mode 100644 tests/generic/471.out
> 
> diff --git a/tests/generic/471 b/tests/generic/471
> new file mode 100755
> index 00000000..ada48129
> --- /dev/null
> +++ b/tests/generic/471
> @@ -0,0 +1,60 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 471
> +#
> +# Mount the same export to different mount points and move (rename)
> +# files among those mount points.
> +# This simple test recently unveils an ancient nfsd bug that is fixed
> +# by fdd2630a739819 ("nfsd: fix change_info in NFSv4 RENAME replies").
> +#
> +. ./common/preamble
> +_begin_fstest auto quick

This test might be good to be in "rename" group too.

Others looks good to me.

Thanks,
Zorro

> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	$UMOUNT_PROG $testdir1 2>/dev/null
> +	$UMOUNT_PROG $testdir2 2>/dev/null
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +# real QA test starts here
> +
> +_supported_fs generic
> +[ "$FSTYP" = "nfs" ] && \
> +	_fixed_by_kernel_commit fdd2630a739819 \
> +		"nfsd: fix change_info in NFSv4 RENAME replies"
> +
> +_require_test
> +_require_scratch
> +
> +echo "Silence is golden"
> +
> +_scratch_mkfs >> $seqres.full
> +testdir1=$TEST_DIR/mountpoint1-$seq
> +testdir2=$TEST_DIR/mountpoint2-$seq
> +rm -rf $testdir1 $testdir2
> +mkdir -p $testdir1 $testdir2
> +
> +# Don't share the data and attribute caches among mount points for NFS.
> +# This caching behavior is necessary to reproduce this issue as we're
> +# checking the alignment of each mount point's own unique cache.
> +[ "$FSTYP" = "nfs" ] && MOUNT_OPTIONS="-o nosharecache"
> +
> +SCRATCH_MNT=$testdir1 _scratch_mount
> +SCRATCH_MNT=$testdir2 _scratch_mount
> +rm -rf $testdir1/{A,B}
> +mkdir $testdir1/{A,B}
> +touch $testdir1/A/f
> +mv $testdir1/A/f $testdir1/B/
> +cat $testdir2/B/f
> +mv $testdir2/B/f $testdir2/A/
> +cat $testdir1/A/f
> +mv $testdir1/A/f $testdir1/B/
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/471.out b/tests/generic/471.out
> new file mode 100644
> index 00000000..260f629e
> --- /dev/null
> +++ b/tests/generic/471.out
> @@ -0,0 +1,2 @@
> +QA output created by 471
> +Silence is golden
> -- 
> 2.31.1
> 

