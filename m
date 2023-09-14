Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C406C7A0562
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Sep 2023 15:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbjINNTX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Sep 2023 09:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbjINNTH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Sep 2023 09:19:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 666EA210C
        for <linux-nfs@vger.kernel.org>; Thu, 14 Sep 2023 06:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694697494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G1WyEYvPM3QUaqgl3QrV/jla+92UgRRrt+4vi4hz7WI=;
        b=Ys8KgaaG+/I9E7jWoHBMiaR36Cu+sLZA7Fgs3nw16BBJRVfkGBnhjxayLiaQ9M2647XqNQ
        BCJrkt3MO29wc+Kins3R18DNKu45iOYFtkW0zGcMu1L+PA8hLjHoYGkUsXKBVSPiRaxlCA
        u3nvOSpDE6VaZPt12DiBDrKPIFUQ/PA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-AavwOOW0N0qhaztPUMsmLg-1; Thu, 14 Sep 2023 09:18:11 -0400
X-MC-Unique: AavwOOW0N0qhaztPUMsmLg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18D8E80590C;
        Thu, 14 Sep 2023 13:18:11 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87049200BFEA;
        Thu, 14 Sep 2023 13:18:10 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] NFSv4: fairly test all delegations on a SEQ4_
 revocation
Date:   Thu, 14 Sep 2023 09:18:09 -0400
Message-ID: <D8B1F20B-E08D-4ED1-A0F5-0C2C763FEC88@redhat.com>
In-Reply-To: <6c85bc9cc6bd8d70fe0e74b096c72944f61874a7.1692903063.git.bcodding@redhat.com>
References: <426fa7ac71b4c9496039cc16169029a5abcb6dc5.1692902495.git.bcodding@redhat.com>
 <6c85bc9cc6bd8d70fe0e74b096c72944f61874a7.1692903063.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

This one went through the ringer in an environment that saw multiple clients
live-locking, and resolves the problem for them.  They asked me to add:

Tested-by: Torkil Svensgaard <torkil@drcmr.dk>
Tested-by: Ruben Vestergaard <rubenv@drcmr.dk>

Ben

