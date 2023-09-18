Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930CE7A5439
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 22:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjIRUhD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 16:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIRUhC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 16:37:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149A910A
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 13:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695069369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KhFFQ1dhi3PhAPzzJGz6elEY7IM7FwLQI78uAPJpPck=;
        b=L+sRqt+K7BQn4AO4R10e+gbtrMMOJIhqIz6lcXKtg0FKxuuvUB/7dViH/o29llkQn6h4YD
        RZoVC1INerJpeNllkZf4WfXbR/2X6Btj/NAwtqgNrLPU4T35eFu6CLk1RPA7xPwaYxActy
        xaKXOanYRO8ouNacegfPFiwEuQvE4tQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-GcdFVT6OPTCCWl4SUOH96w-1; Mon, 18 Sep 2023 16:36:05 -0400
X-MC-Unique: GcdFVT6OPTCCWl4SUOH96w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E29A85A5BE;
        Mon, 18 Sep 2023 20:36:05 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECC84167F8;
        Mon, 18 Sep 2023 20:36:04 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] NFSv4: fairly test all delegations on a SEQ4_
 revocation
Date:   Mon, 18 Sep 2023 16:36:03 -0400
Message-ID: <B39D8F7D-B852-42C9-BC1E-2DED2AC23ACA@redhat.com>
In-Reply-To: <D8B1F20B-E08D-4ED1-A0F5-0C2C763FEC88@redhat.com>
References: <426fa7ac71b4c9496039cc16169029a5abcb6dc5.1692902495.git.bcodding@redhat.com>
 <6c85bc9cc6bd8d70fe0e74b096c72944f61874a7.1692903063.git.bcodding@redhat.com>
 <D8B1F20B-E08D-4ED1-A0F5-0C2C763FEC88@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 14 Sep 2023, at 9:18, Benjamin Coddington wrote:

> On 24 Aug 2023, at 14:52, Benjamin Coddington wrote:
>
>> When the client is required to use TEST_STATEID to discover which
>> delegation(s) have been revoked, it may continually test delegations at the
>> head of the list if the server continues to be unsatisfied and send
>> SEQ4_STATUS_RECALLABLE_STATE_REVOKED.  For a large number of delegations
>> this behavior is prone to live-lock because the client may never be able to
>> test and free revoked state at the end of the list since the
>> SEQ4_STATUS_RECALLABLE_STATE_REVOKED will cause us to flag delegations at
>> the head of the list to be tested.  This problem is further exacerbated by
>> the state manager's willingness to be scheduled out on a busy system while
>> testing the list of delegations.
>>
>> Keep a generation counter for each attempt to test all delegations, and
>> skip delegations that have already been tested in the current pass.
>>
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>
> This one went through the ringer in an environment that saw multiple clients
> live-locking, and resolves the problem for them.  They asked me to add:
>
> Tested-by: Torkil Svensgaard <torkil@drcmr.dk>
> Tested-by: Ruben Vestergaard <rubenv@drcmr.dk>
>
> Ben

Did this one get rejected with a reason?  This fix could also be implemented
with flag (as I mentioned in a reply on v2).

Ben

