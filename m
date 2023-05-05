Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5E66F7C06
	for <lists+linux-nfs@lfdr.de>; Fri,  5 May 2023 06:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjEEEpx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 May 2023 00:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjEEEpx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 May 2023 00:45:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901E7124B7
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 21:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683261905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dtinxNP6pyEAADcAheaRiWg2W9bzRumM0aISKTp3vB4=;
        b=BFCfv/UHnq9ratDXNpnd2JIWsir4lkQSlvMcJmBJvuphZtomcE9huihaxiuJ6KJNaVpU9h
        tc6TD1kSq3uk2Yw1pebE0qnsFR+BhQKVjj/7guFpyV1zEE4IuPlkkjsrnIukgDQ36HgYYT
        EOuyGThtB1y9qilHpvb5gzbpoC+GyIU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-wGrt4RIyPrujBrMT9UrScQ-1; Fri, 05 May 2023 00:45:04 -0400
X-MC-Unique: wGrt4RIyPrujBrMT9UrScQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-24e1d272afaso643337a91.3
        for <linux-nfs@vger.kernel.org>; Thu, 04 May 2023 21:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683261903; x=1685853903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtinxNP6pyEAADcAheaRiWg2W9bzRumM0aISKTp3vB4=;
        b=UuBUewQrl/pRBQba/+RtGIsWsVREkh/QdEA1v2ldMSklm1CQJba4oeVL3fqAowv1Sh
         co/dBe+pfDJhXAAEZOH/UrgmjVRGbTlCryN2WF67WWyA1nA4r30GGlY2JQOOfl3xjcRN
         LT6htOjEXGtr55nKiPYXINMrXfgBSQ4WSwPmHLDtSGs2IyyUHpvKWyORSOHA/cB9d8BT
         NkrlFVeY+HVwFDLD8UK6NR9MKtfCwZXAyJQQXPrHjll1Ci+Y/+Hiiq8FeoVPrG5jZieq
         4JWM2z3vllA7Tbt9350emlaKTKzeXnHL1vV8Nyl/cTuw5XGOhfen5Kr2+8pitzsa8ufq
         Sh1A==
X-Gm-Message-State: AC+VfDw/kvSVVWJsyxYvrGT3BXPt3xIDlkkBxXRvt75nlmmtq2JiFSAJ
        3Mj47++JMGzOtNmyGqiDCsjeTpRT1kzq/dRwA/17L8ncf9y3FfpFyEXHlexgcqd300/JdCEHFIN
        ShLXL754VmMnBbjJVBDssmOILGFt43wQ=
X-Received: by 2002:a17:90b:4f8e:b0:24f:fdaa:53a8 with SMTP id qe14-20020a17090b4f8e00b0024ffdaa53a8mr153130pjb.37.1683261903160;
        Thu, 04 May 2023 21:45:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ669p8ANY0Serq4RD9to3ecYl3IrYiZldJRvOf6ym7gbyuYh/ea49QCsKWXQ7/IPQAfJ8m3lw==
X-Received: by 2002:a17:90b:4f8e:b0:24f:fdaa:53a8 with SMTP id qe14-20020a17090b4f8e00b0024ffdaa53a8mr153113pjb.37.1683261902785;
        Thu, 04 May 2023 21:45:02 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bg7-20020a1709028e8700b001ab12ccc2a7sm544485plb.98.2023.05.04.21.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 21:45:02 -0700 (PDT)
Date:   Fri, 5 May 2023 12:44:58 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] nfs/002: Add a test for xattr ctime updates
Message-ID: <20230505044458.wrvhvamrkcuqin3z@zlang-mailbox>
References: <20230504204847.405037-1-anna@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504204847.405037-1-anna@kernel.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 04, 2023 at 04:48:47PM -0400, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> The NFS client wasn't updating ctime after a setxattr request. This is a
> test written while fixing the bug.
> 
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
>  tests/nfs/002     | 39 +++++++++++++++++++++++++++++++++++++++
>  tests/nfs/002.out |  2 ++
>  2 files changed, 41 insertions(+)
>  create mode 100755 tests/nfs/002
>  create mode 100644 tests/nfs/002.out
> 
> diff --git a/tests/nfs/002 b/tests/nfs/002
> new file mode 100755
> index 000000000000..5bfedef6c57d
> --- /dev/null
> +++ b/tests/nfs/002
> @@ -0,0 +1,39 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Netapp Inc., All Rights Reserved.
> +#
> +# FS QA Test 002
> +#
> +# Test a bug whene the NFS client wasn't sending a post-op GETATTR to the
> +# server after setting an xattr, resulting in `stat` reporting a stale ctime.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick attr
> +
> +# Import common functions
> +. ./common/filter
> +. ./common/attr
> +
> +# real QA test starts here
> +_supported_fs nfs

Great, a new nfs test case!

> +_require_test_nfs_version 4.2

But I'm wondering if this case can be a generic test case, due to the operations
in this case are common (need xattr and ctime support), don't depend on
any nfs specific features/operations.

Not sure why nfs4.2 is necessary, can it be removed or replaced ?

Thanks,
Zorro

> +_require_attrs
> +
> +touch $TEST_DIR/testfile
> +
> +before_ctime=$(stat -c %z $TEST_DIR/testfile)
> +$SETFATTR_PROG -n user.foobar -v 123 $TEST_DIR/testfile
> +after_ctime=$(stat -c %z $TEST_DIR/testfile)
> +
> +test "$before_ctime" != "$after_ctime" || echo "Expected ctime to change."
> +
> +
> +before_ctime=$after_ctime
> +$SETFATTR_PROG -x user.foobar $TEST_DIR/testfile
> +after_ctime=$(stat -c %z $TEST_DIR/testfile)
> +
> +test "$before_ctime" != "$after_ctime" || echo "Expected ctime to change."
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/nfs/002.out b/tests/nfs/002.out
> new file mode 100644
> index 000000000000..61705c7cc203
> --- /dev/null
> +++ b/tests/nfs/002.out
> @@ -0,0 +1,2 @@
> +QA output created by 002
> +Silence is golden
> -- 
> 2.40.1
> 

