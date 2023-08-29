Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAB378CE01
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Aug 2023 23:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240658AbjH2VGe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 17:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239695AbjH2VGH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 17:06:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0491BC
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 14:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693343118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uknlgcK/Il++pYk902pIvRt2xWcGPo78nAG730mLyJM=;
        b=R+Ug+rUe8XMVkNO7Ki62dR1bJ46vHb1zVmL4BIjBoERYLbBP8ynSFo3RXwsyA3Gps8WKXS
        KUurUPY9HXHYoDCZN+C0vqq97pt2wHqcIXuPUequrei+7XW1jx4n/UO7OMFyaJsrll10Da
        L+2V+LPhTFukF/omXXa1jIjaidebReM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-683-PJM7hu_LM4mvAAl9WGMAZg-1; Tue, 29 Aug 2023 17:05:16 -0400
X-MC-Unique: PJM7hu_LM4mvAAl9WGMAZg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2711F8015AA;
        Tue, 29 Aug 2023 21:05:16 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 97FE15CC01;
        Tue, 29 Aug 2023 21:05:15 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: allow setting SEQ4_STATUS_RECALLABLE_STATE_REVOKED
Date:   Tue, 29 Aug 2023 17:05:14 -0400
Message-ID: <41574FF3-6559-40D0-BC6D-3CD33410C9F0@redhat.com>
In-Reply-To: <ZO5Wd7BdgsNMOpfU@tissot.1015granger.net>
References: <cd03fb7419f886c8c79bb2ee4889dbc0768a1652.1693326366.git.bcodding@redhat.com>
 <ZO5Wd7BdgsNMOpfU@tissot.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 29 Aug 2023, at 16:35, Chuck Lever wrote:

> On Tue, Aug 29, 2023 at 12:26:56PM -0400, Benjamin Coddington wrote:
>> This patch sets the SEQ4_STATUS_RECALLABLE_STATE_REVOKED bit for a single
>> SEQUENCE response after writing "revoke" to the client's ctl file in procfs.
>> It has been generally useful to test various NFS client implementations, so
>> I'm sending it along for others to find and use.
>
> Intriguing!
>
> It looks to me like the client would probe its state and
> find nothing missing... fair enough.
>
> Would it be even more useful if the server administrator could
> actually revoke some state, rather than just pretending to?
> How difficult do you think that might be?

Probably not difficult, we'd just move some state to cl_revoked.  We'd need
to work out a syntax for it, or add another procfs file, but I don't have
any need for this.. yet.

> Or, conversely, what exactly can you test with this mechanism?

You can test how well the client performs TEST_STATEID for all its known
state, looking for unfairness or perhaps skipped state.  Doing a
TEST_STATEID walk can be a big lift for clients with a lot of delegations.

There's been recent reports of the linux client getting into a live jam
trying to use TEST_STATEID to satisfy a server that keeps setting this bit.
Its pretty hard to catch in the wild, and network captures are typically too
large to handle.  In the process of trying to optimize how the client
performs TEST_STATEID ops for all its state, this patch made it easier to
artificially trigger that client behavior.

I'm ambivalent about whether this goes upstream, but here it is if others
find it useful.

Ben

