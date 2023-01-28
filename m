Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA9467F815
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Jan 2023 14:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjA1Nc7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Jan 2023 08:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbjA1Ncz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 28 Jan 2023 08:32:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1027D45899
        for <linux-nfs@vger.kernel.org>; Sat, 28 Jan 2023 05:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674912725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=39ibRxD9EiGYfCoJo44ECEqo6oNyrHEFAZwbMUZqFR0=;
        b=aNiB+nmJVeAPIcpUTP0GPel7fg2QkcI1HWCv1m+LNkNa7nQhkQZOGY7KYU7+gOVxwQaxHy
        xT8DXYTK/CvmfB8Mg+NyWLc0tCoyIpJe2jgsNnON4inRr/M3FRkj4B63gCcTr6AbYI2Y81
        mBDUGl6nwzmyIWUK4Xsls3WveOQYbzI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-OUhKu1vMP2CeCUkoPWDrmw-1; Sat, 28 Jan 2023 08:32:01 -0500
X-MC-Unique: OUhKu1vMP2CeCUkoPWDrmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1ADC6802BF5;
        Sat, 28 Jan 2023 13:32:01 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 75F722166B26;
        Sat, 28 Jan 2023 13:32:00 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix race to check ls_layouts
Date:   Sat, 28 Jan 2023 08:31:58 -0500
Message-ID: <A1324B12-C0FE-4A60-8116-4DCD98C92A8D@redhat.com>
In-Reply-To: <0412daf06541dfa71866be1efedef5456e524ece.camel@kernel.org>
References: <979eebe94ef380af6a5fdb831e78fd4c0946a59e.1674836262.git.bcodding@redhat.com>
 <C9FA580A-52A6-4208-AFA2-91E8BCB36B9F@oracle.com>
 <49815925-FB60-456F-8633-79B4C203B782@redhat.com>
 <0412daf06541dfa71866be1efedef5456e524ece.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 27 Jan 2023, at 13:03, Jeff Layton wrote:

> On Fri, 2023-01-27 at 11:42 -0500, Benjamin Coddington wrote:
>> On 27 Jan 2023, at 11:34, Chuck Lever III wrote:
>>
>>>> On Jan 27, 2023, at 11:18 AM, Benjamin Coddington <bcodding@redhat.com> wrote:
>>>>
>>>> Its possible for __break_lease to find the layout's lease before we've
>>>> added the layout to the owner's ls_layouts list.  In that case, setting
>>>> ls_recalled = true without actually recalling the layout will cause the
>>>> server to never send a recall callback.
>>>>
>>>> Move the check for ls_layouts before setting ls_recalled.
>>>>
>>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>>
>>> Did this start misbehaving recently, or has it always been broken?
>>> That is, does it need:
>>>
>>> Fixes: c5c707f96fc9 ("nfsd: implement pNFS layout recalls") ?
>>
>> I'm doing some new testing of racing LAYOUTGET and CB_LAYOUTRETURN after
>> running into a livelock, so I think it has always been broken and the Fixes
>> tag is probably appropriate.
>>
>> However, now I'm wondering if we'd run into trouble if ls_layouts could be
>> empty but the lease still exist..  but that seems like it would be a
>> different bug.
>>
>
> Yeah, is that even possible? Surely once the last layout is gone, we
> drop the stateid? In any case, this patch looks fine. You can add:
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Jeff pointed out that there's another problem here.  We can't just skip
sending the callback if ls_layouts is empty, because then the process trying
to break the lease will end up spinning in __break_lease.

I think we can drop the list_empty() check altogether - it must be there so
that we don't race in and send a callback for a layout that's already been
returned, but I don't see any harm in that.  Clients should just return
NO_MATCHING_LAYOUT.

Ben

