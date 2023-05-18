Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906AB707982
	for <lists+linux-nfs@lfdr.de>; Thu, 18 May 2023 07:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjERFWQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 May 2023 01:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjERFWP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 May 2023 01:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B795C30C2
        for <linux-nfs@vger.kernel.org>; Wed, 17 May 2023 22:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684387286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wc+27JL/yOtB8a9pG/9pB0vmWbj5yDS5LrHGaZGLLHM=;
        b=f6vWgY44dReN9eikyk7qBnmKfXjdSkYT+86Or5f0Hj5FoddbaPwQ1vF0zJXVCh445+QwIM
        MM925HlzfSS7dpBXtqm67qG/AGWLWKJRGcy7KEcBxl5fPWLbT7MxqdRzDjoFkn9+Kv10rm
        ZXaMdvXyCxMA4zlJfToaqYnkjyt0wKs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-qibMoZbiOda2bQXfbLKCkA-1; Thu, 18 May 2023 01:21:25 -0400
X-MC-Unique: qibMoZbiOda2bQXfbLKCkA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1ae4c498f0cso18394475ad.2
        for <linux-nfs@vger.kernel.org>; Wed, 17 May 2023 22:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684387284; x=1686979284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wc+27JL/yOtB8a9pG/9pB0vmWbj5yDS5LrHGaZGLLHM=;
        b=IixNFEaI9n6gRUNszpBE7hdZN6tq/r47hA3zmqWjE5HecEyUr/s6qJWOmvpdnVKTdA
         Mt7PLmjomfm+pgCufk2AEniy9SV5Nlukaam6UPVsHm3tOuTwj/JomRs7W/N2GXQAFr2r
         flumeBz92TgPhI6YBBovrLM5vvvQ5bBkFFRNB1+aPeC6+9VGSW4bTmTppT6ji2tNPhrI
         FkJ9z4GL6Q9RzvK1v1+UJ8Bi6D3iXFH7+rRIm5ZfWcz7CRryeNpGNXhbMZ31Cp7m5a+X
         CbLR822A9mpg4WtmuH5dv0m60BPTNZb4V9as3nr+2w6RVaI/Eri5LtGdO3uq+Y5bNNMa
         jE8Q==
X-Gm-Message-State: AC+VfDx98iOuAbK18dCQ5okuSMT8u05Ir/EpGjh66uanFLo4I+i8EpIg
        9zIjgFBOyaHC4mgBD4+LFED3zPnPhy88uUFzO3jbbRYjXpkGCK63Tcc5SY3Al69z2Th64xCTkuN
        1TUt+HiRgA7iTwr3bxEtyrQRqEfL8af3o/A==
X-Received: by 2002:a17:902:eb46:b0:1ae:89a:92 with SMTP id i6-20020a170902eb4600b001ae089a0092mr1324171pli.59.1684387284118;
        Wed, 17 May 2023 22:21:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4NuKpN7cVRM0ETD6pMBPt6iVxSpDl2D/m6w2E6HHup5ZO4MbT2ko+dhIK+4tFQ4J/XwXs+oA==
X-Received: by 2002:a17:902:eb46:b0:1ae:89a:92 with SMTP id i6-20020a170902eb4600b001ae089a0092mr1324152pli.59.1684387283704;
        Wed, 17 May 2023 22:21:23 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001a6388ce38bsm312079plg.240.2023.05.17.22.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 22:21:23 -0700 (PDT)
Date:   Thu, 18 May 2023 13:21:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v3] generic/728: Add a test for xattr ctime updates
Message-ID: <20230518052119.n6egt7itugl7wjyb@zlang-mailbox>
References: <20230516141407.201674-1-anna@kernel.org>
 <20230516150027.GB858795@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516150027.GB858795@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 16, 2023 at 08:00:27AM -0700, Darrick J. Wong wrote:
> On Tue, May 16, 2023 at 10:14:07AM -0400, Anna Schumaker wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > 
> > The NFS client wasn't updating ctime after a setxattr request. This is a
> > test written while fixing the bug.
> > 
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > 
> > ---
> > v3:
> >  - Add a 2 second sleep before changing the xattr
> > 
> > v2:
> >  - Move test to generic/
> >  - Address comments from the mailing list
> > ---
> >  tests/generic/728     | 43 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/728.out |  2 ++
> >  2 files changed, 45 insertions(+)
> >  create mode 100755 tests/generic/728
> >  create mode 100644 tests/generic/728.out
> > 
> > diff --git a/tests/generic/728 b/tests/generic/728
> > new file mode 100755
> > index 000000000000..8e52eb4b219c
> > --- /dev/null
> > +++ b/tests/generic/728
> > @@ -0,0 +1,43 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2023 Netapp Inc., All Rights Reserved.
> > +#
> > +# FS QA Test 728
> > +#
> > +# Test a bug where the NFS client wasn't sending a post-op GETATTR to the
> > +# server after setting an xattr, resulting in `stat` reporting a stale ctime.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick attr
> > +
> > +# Import common functions
> > +. ./common/attr
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_require_test
> > +_require_attrs
> > +
> > +rm -rf $TEST_DIR/testfile
> > +touch $TEST_DIR/testfile
> > +
> > +
> > +_check_xattr_op()
> 
> nit: only common/* functions are supposed to have a leading underscore
> in the name.

I can help to remove the leading underscore when I merge this patch.

> 
> > +{
> > +  what=$1
> > +  shift 1
> > +
> > +  before_ctime=$(stat -c %z $TEST_DIR/testfile)
> > +  sleep 2
> 
> I think it would be useful to document that 2 seconds is the worst ctime
> granularity that we expect from any filesystem (fat) that might pass
> through fstests.
> 
> Just in case, you know, we /ever/ create a fsinfo call to export
> information like that, and need to refactor all these 'sleep 2'.
> 
> "sleep 2 # maximum known ctime granularity is 2s for fat"

Hi Anna, if you don't want to send a v4, you can reply this email to tell
us what comment you'd like to write. I can add it when I merge this patch.
Or you'd like to send a v4 by yourself :)

Thanks,
Zorro

> 
> With those two things fixed,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
> 
> > +  $SETFATTR_PROG $* $TEST_DIR/testfile
> > +  after_ctime=$(stat -c %z $TEST_DIR/testfile)
> > +
> > +  test "$before_ctime" != "$after_ctime" || echo "Expected ctime to change after $what."
> > +}
> > +
> > +_check_xattr_op setxattr -n user.foobar -v 123
> > +_check_xattr_op removexattr -x user.foobar
> > +
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > diff --git a/tests/generic/728.out b/tests/generic/728.out
> > new file mode 100644
> > index 000000000000..ab39f45fe5da
> > --- /dev/null
> > +++ b/tests/generic/728.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 728
> > +Silence is golden
> > -- 
> > 2.40.1
> > 
> 

