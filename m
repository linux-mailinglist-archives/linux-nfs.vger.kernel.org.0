Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8B6589989
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Aug 2022 10:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbiHDIy2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Aug 2022 04:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbiHDIyX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Aug 2022 04:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 688ACE0BE
        for <linux-nfs@vger.kernel.org>; Thu,  4 Aug 2022 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659603261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Ko9AgvpK/tPQVq7ns9jWow4bdHUTifT3a3mG9q2q5k=;
        b=ORWNDv+ozcPiye8zJkYffuJRUBz9jm8m52R2CGj0s9NNAvyZNUb4wwGkq85L7dimMpd0yg
        SZyZwGpQAzdEfkzgFKmwtANHL9jNNKmZf0ImVDxYbxzOMzIfjqtlZYsrxE41ui7HVSSqAF
        ymMnG8aT/e3SK/YYye/LY2eHu5u6Uy4=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-RflQU8cqN7G_wJR9aimOyQ-1; Thu, 04 Aug 2022 04:54:18 -0400
X-MC-Unique: RflQU8cqN7G_wJR9aimOyQ-1
Received: by mail-pf1-f198.google.com with SMTP id bq15-20020a056a000e0f00b0052af07b6c6bso7733608pfb.21
        for <linux-nfs@vger.kernel.org>; Thu, 04 Aug 2022 01:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Ko9AgvpK/tPQVq7ns9jWow4bdHUTifT3a3mG9q2q5k=;
        b=z/gQiyfzB5OJruibczen98MchjauOu7f40CiZ418Ddp8rUszicWoktJDI8UZDb+OeG
         p4CkmXHwxl5+bx0Ixx8Wi+WAqN7SSoErsgLXJg0q8snWpoTfDAQ6vTh+nCWxPVoPTglW
         dZpBjjSGjpYHy3QwoDDW2Fp09zaKHXnE70aEppLIIabU8Jtayc10pXkSmnpTvyMJBVyE
         4U//yPPIe3rdtMHkuHuv5JTIJJ48o2vjl3PbyLRfaHtbVg6mD+OYX/jTH5QWj7MrfG84
         N5a4ozIlHC33HIgUjOIJwH4q3QSLPEt2HyDJ+mqRKNhcYLB1YWk+p0xMdfqBkoWPDNUh
         lWHg==
X-Gm-Message-State: ACgBeo1LuWYn3IZmLX9xZUjBjSsIyio+Ar4IhwVkS46Miqsct8hdEs4T
        wpULmFfiiMGIQCet41FKM8XONkLxYWg6cRVhudorG3TNWPyS9owfUoEWgWuUnlYmvhhw/Vsti2D
        zI05o0MxZ+SFWzRNP6UY3TDxUHbtlbgUdTE/k
X-Received: by 2002:a17:903:11d2:b0:167:8a0f:8d33 with SMTP id q18-20020a17090311d200b001678a0f8d33mr959246plh.95.1659603257013;
        Thu, 04 Aug 2022 01:54:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4QAwjD/iRBqrzMqhZAXF4/R/ljcQxQWEni+1EPMo5eUWMi9HSIvL89bzbRb6hocfhbqhh0ek5M4KdvX6z5HMo=
X-Received: by 2002:a17:903:11d2:b0:167:8a0f:8d33 with SMTP id
 q18-20020a17090311d200b001678a0f8d33mr959225plh.95.1659603256616; Thu, 04 Aug
 2022 01:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220722181220.81636-1-jlayton@kernel.org>
In-Reply-To: <20220722181220.81636-1-jlayton@kernel.org>
From:   Boyang Xue <bxue@redhat.com>
Date:   Thu, 4 Aug 2022 16:54:05 +0800
Message-ID: <CAHLe9YYtRkzJ_HBsRZCUXyVH45jdR-nT061OAnBC-3dX0izcNQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] nfs: fix -ENOSPC DIO write regression
To:     Jeff Layton <jlayton@kernel.org>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, chuck.lever@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jeff,

Thanks for fixing this! I have run some tests against this patchset
for days, and the results are all good. generic/476 would complete
within 30 mins typically. These tests are:

For verifying generic/476:
xfstests-multihost-nfsv3-over-ext4
xfstests-multihost-nfsv3-over-feature-ext4
xfstests-multihost-nfsv3-over-feature-xfs
xfstests-multihost-nfsv3-over-xfs
xfstests-multihost-nfsv4.0-over-ext4
xfstests-multihost-nfsv4.0-over-feature-ext4
xfstests-multihost-nfsv4.0-over-feature-xfs
xfstests-multihost-nfsv4.0-over-xfs
xfstests-multihost-nfsv4.1-over-ext4
xfstests-multihost-nfsv4.1-over-feature-ext4
xfstests-multihost-nfsv4.1-over-feature-xfs
xfstests-multihost-nfsv4.1-over-xfs
xfstests-multihost-nfsv4.2-over-ext4
xfstests-multihost-nfsv4.2-over-feature-ext4
xfstests-multihost-nfsv4.2-over-feature-xfs
xfstests-multihost-nfsv4.2-over-xfs
xfstests-localhost-nfsv3
xfstests-localhost-nfsv4.0
xfstests-localhost-nfsv4.1
xfstests-localhost-nfsv4.2

Regression tests:
ltp-nfsv{3,4.0,4.1,4.2}
pjd-test: nfs
nfs-connectathon
nfs-sanity-check

All tests were run on x86_64, aarch64, ppc64le, and s390x (part, due
to some config issues).

Hope this helps.

Thanks,
Boyang

On Sat, Jul 23, 2022 at 2:12 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> Boyang reported that xfstest generic/476 would never complete when run
> against a filesystem that was "too small".
>
> What I found was that we would end up trying to issue a large DIO write
> that would come back short. The kernel would then follow up and try to
> write out the rest and get back -ENOSPC. It would then try to issue a
> commit, which would then try to reissue the writes, and around it would
> go.
>
> This patchset seems to fix it. Unfortunately, I'm not positive which
> patch _broke_ this as it seems to have happened quite some time ago.
>
> Jeff Layton (3):
>   nfs: add new nfs_direct_req tracepoint events
>   nfs: always check dreq->error after a commit
>   nfs: only issue commit in DIO codepath if we have uncommitted data
>
>  fs/nfs/direct.c         | 50 +++++++++--------------------
>  fs/nfs/internal.h       | 33 ++++++++++++++++++++
>  fs/nfs/nfstrace.h       | 69 +++++++++++++++++++++++++++++++++++++++++
>  fs/nfs/write.c          | 48 +++++++++++++++++-----------
>  include/linux/nfs_xdr.h |  1 +
>  5 files changed, 148 insertions(+), 53 deletions(-)
>
> --
> 2.36.1
>

