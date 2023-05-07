Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC94C6F979D
	for <lists+linux-nfs@lfdr.de>; Sun,  7 May 2023 10:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjEGIUj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 May 2023 04:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjEGIUi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 7 May 2023 04:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F8F11B48
        for <linux-nfs@vger.kernel.org>; Sun,  7 May 2023 01:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683447588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3p5eUiPMYiUWP3LG+f7wOt7GUjbH6dBCFoNn5++Jcb0=;
        b=CsKGr65/pcDcIinfpdrJCGmfG6rl6S+sSm2xIVbTw+WO3Aw6Ex8dSspk1XDudVx8oUSnX3
        9yY+w6fijK9BwQgK6DG8BDcr17gwPMJDZv0Xzu+vKwRBAOCnWmr9i7PzsHyj245XlWrS8x
        /1QNV/yME+9kKx16WAmoxsPAN+JEyKE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339--_RH46uNML2BmY78h4gCFg-1; Sun, 07 May 2023 04:19:47 -0400
X-MC-Unique: -_RH46uNML2BmY78h4gCFg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6437923cca9so3391178b3a.2
        for <linux-nfs@vger.kernel.org>; Sun, 07 May 2023 01:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683447586; x=1686039586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3p5eUiPMYiUWP3LG+f7wOt7GUjbH6dBCFoNn5++Jcb0=;
        b=F9S6MkVd4ZxPHDQHa8TpUh7PMXflYYwDdwL21Dr82WSXyEJoqUtK2F1I4XDwKarr3v
         TOtFRjaa5aWNBcgfxRd/UzNAupJQk6Z4wri4aJ7L8lQW3MSyUVWpLF5k9rWMTRpH1ctS
         7PYLFNnEm8pyuPZ/Vn8o0QSPJk3+QgK40hOED8pgVA8FcKx6vwUHPWH74SFycwI05WTC
         P94wJYCjA/Z1YRBqSJE5QFBcS5LUw3Y1FYQ+ebyRzC11EnY27N9qOYICICGEqH+rDOza
         BOjUasjKSwZDnTKCWtKjWgLmb0eNfU3MCMYakRDvg41FhLo6kOjX0u3VETonJ9Xa6qNZ
         6hcA==
X-Gm-Message-State: AC+VfDztAhkXfIItYdQ6dxAzzdyZ8dK692s3ulRRpFXAzzXbrM18DrWb
        kzqIkuAgBDBj3SUrIWXQcF4EbG7lH4fBSDp6QqD1Pwz5M1ZZe97uXCkBoNzpBUtjfcBa8zE2DTo
        Uo11H8uZQQBKnMTU0Eq+80igBTD2syuw=
X-Received: by 2002:a05:6a00:801:b0:63d:2260:f7d with SMTP id m1-20020a056a00080100b0063d22600f7dmr10356355pfk.8.1683447585867;
        Sun, 07 May 2023 01:19:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7lZqXsCvda8ccaiywa0/ymTfDXBtsnYIvYrplWXiVRnosRizGXPju0O7BLMMq0BbPMpEWRFQ==
X-Received: by 2002:a05:6a00:801:b0:63d:2260:f7d with SMTP id m1-20020a056a00080100b0063d22600f7dmr10356337pfk.8.1683447585437;
        Sun, 07 May 2023 01:19:45 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v5-20020a62a505000000b0064182e41e21sm4069643pfm.81.2023.05.07.01.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 01:19:44 -0700 (PDT)
Date:   Sun, 7 May 2023 16:19:40 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/728: Add a test for xattr ctime updates
Message-ID: <20230507081940.oirsiwiuuljbjmsi@zlang-mailbox>
References: <20230505172427.94963-1-anna@kernel.org>
 <20230505223929.GA15384@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505223929.GA15384@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 05, 2023 at 03:39:29PM -0700, Darrick J. Wong wrote:
> On Fri, May 05, 2023 at 01:24:27PM -0400, Anna Schumaker wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > 
> > The NFS client wasn't updating ctime after a setxattr request. This is a
> > test written while fixing the bug.
> > 
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > 
> > ---
> > v2:
> >  - Move test to generic/
> >  - Address comments from the mailing list
> > ---
> >  tests/generic/728     | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/728.out |  2 ++
> >  2 files changed, 44 insertions(+)
> >  create mode 100755 tests/generic/728
> >  create mode 100644 tests/generic/728.out
> > 
> > diff --git a/tests/generic/728 b/tests/generic/728
> > new file mode 100755
> > index 000000000000..ab2414c151db
> > --- /dev/null
> > +++ b/tests/generic/728
> > @@ -0,0 +1,42 @@
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
> > +{
> > +  what=$1
> > +  shift 1
> > +
> > +  before_ctime=$(stat -c %z $TEST_DIR/testfile)
> > +  $SETFATTR_PROG $* $TEST_DIR/testfile
> > +  after_ctime=$(stat -c %z $TEST_DIR/testfile)
> 
> What happens if the filesystem's timestamp granularity isn't sufficient
> to capture a difference across a setxattr operation?  Most of the time
> we only update the (fast) timestamps at every clock tick, right?

OK, by talking with Darrick, I think "sleep 2s" might avoid most problem
of timestamp granularity at here. (If this change don't affect your original
test target). Any thoughts?

> 
> --D
> 
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

