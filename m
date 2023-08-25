Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E48B788541
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Aug 2023 12:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjHYK4n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Aug 2023 06:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjHYK4g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Aug 2023 06:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910B11BC2
        for <linux-nfs@vger.kernel.org>; Fri, 25 Aug 2023 03:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692960947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o0VCroRQ3/+MzIVFbmNS1a+zeqwhNtwPx3mTXp/PzGc=;
        b=Qyu6bjlz2x/hni67/97FQXvfyj47L4lQ+1pNWO4bCcHDpls7lcmlCknQAGOuG/EOLEbkKF
        A0AjiyLcF2nIWU4feDufTMoR49hVIaTpF09BSCl/Q4Tg9TvhE8YT1pFQvHxAeoYlUrPJ2+
        IPqNqxlUQ/fFzGaFQ8d9G7ZGezfrQyc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-42k3mfErO52Y1Id1920AMQ-1; Fri, 25 Aug 2023 06:55:43 -0400
X-MC-Unique: 42k3mfErO52Y1Id1920AMQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A979E381AE57;
        Fri, 25 Aug 2023 10:55:42 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-2.rdu2.redhat.com [10.22.0.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 24B17492C14;
        Fri, 25 Aug 2023 10:55:41 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] NFSv4: fairly test all delegations on a SEQ4_
 revocation
Date:   Fri, 25 Aug 2023 06:55:40 -0400
Message-ID: <0AF073ED-9BCA-4DA0-B79C-5011BCEB450A@redhat.com>
In-Reply-To: <6c85bc9cc6bd8d70fe0e74b096c72944f61874a7.1692903063.git.bcodding@redhat.com>
References: <426fa7ac71b4c9496039cc16169029a5abcb6dc5.1692902495.git.bcodding@redhat.com>
 <6c85bc9cc6bd8d70fe0e74b096c72944f61874a7.1692903063.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 24 Aug 2023, at 14:52, Benjamin Coddington wrote:

> When the client is required to use TEST_STATEID to discover which
> delegation(s) have been revoked, it may continually test delegations at the
> head of the list if the server continues to be unsatisfied and send
> SEQ4_STATUS_RECALLABLE_STATE_REVOKED.  For a large number of delegations
> this behavior is prone to live-lock because the client may never be able to
> test and free revoked state at the end of the list since the
> SEQ4_STATUS_RECALLABLE_STATE_REVOKED will cause us to flag delegations at
> the head of the list to be tested.  This problem is further exacerbated by
> the state manager's willingness to be scheduled out on a busy system while
> testing the list of delegations.
>
> Keep a generation counter for each attempt to test all delegations, and
> skip delegations that have already been tested in the current pass.
>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/delegation.c       | 7 ++++++-
>  fs/nfs/delegation.h       | 1 +
>  include/linux/nfs_fs_sb.h | 1 +
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> --
>
> Changed on v2: remove extra brackets that had my debug statements

Hi potential reviewers - this can also be fixed with the simple addition of
a flag instead of a counter on every delegation, the only cost being that
nfs_server_reap_expired_delegations() would need to walk the whole list a
final time to remove the flag before returning.

The unsigned long counter is probably overkill.  Any thoughts?

Ben

