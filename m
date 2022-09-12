Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8D35B6141
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 20:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiILSp4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 14:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiILSpz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 14:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BADA20F4C
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 11:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663008353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UY8oNSXeB3iNEtV05MCTpvbMof8O246ZzRmaBCGr5qg=;
        b=KUTfSMaeMEvr+1+GmAFJYAOSwSEIHycNqXmAb632HinG1/6AfQr8gzO9fn3tVRNwDMJfX4
        qJd6XSUVEp8/rMnEVfS7dvLzx34rZfXWAvaCMV4wDROJeDJaxJbSUiGEaG6LgVhpdYp/9Y
        ZWtg10WS8ki0uxMQYyQWXmHCHqmqyu0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-4zPnmrOtMSKkGAR5IZGefQ-1; Mon, 12 Sep 2022 14:45:49 -0400
X-MC-Unique: 4zPnmrOtMSKkGAR5IZGefQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D0D98037AA;
        Mon, 12 Sep 2022 18:45:49 +0000 (UTC)
Received: from [10.22.33.151] (unknown [10.22.33.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B0B556D1E0;
        Mon, 12 Sep 2022 18:45:49 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Al Viro" <viro@zeniv.linux.org.uk>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Olga Kornievskaia" <aglo@umich.edu>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: Is this nfsd kernel oops known?
Date:   Mon, 12 Sep 2022 14:45:48 -0400
Message-ID: <2F22D90A-3B64-43F0-899D-E41001DF3021@redhat.com>
In-Reply-To: <Yx45clPaZODzYV+z@ZenIV>
References: <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
 <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
 <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
 <D0A6E504-F2C2-4A5F-BC51-FD3D88A790F0@redhat.com>
 <CAN-5tyHYH7ODzmTK=Maa3NZOSxfcE0mfaWY11+n2htQpya869g@mail.gmail.com>
 <EE9C1D1C-AA5B-48BC-9E3A-8A4523456AEE@oracle.com>
 <25AF9743-A2A2-4AFE-9123-BAD3C8F17655@redhat.com> <Yxz+GhK7nWKcBLcI@ZenIV>
 <8B4DBE66-960F-473C-8636-8159B397FFC0@oracle.com> <Yx45clPaZODzYV+z@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 11 Sep 2022, at 15:39, Al Viro wrote:
>>
>>> +	for (int i = sd->len; i > 0; i -= PAGE_SIZE)
>>> +		svc_rqst_replace_page(rqstp, page++);
>>> +	if (rqstp->rq_res.page_len == 0)	// first call
>>> +		rqstp->rq_res.page_base = offset % PAGE_SIZE;
>>> 	rqstp->rq_res.page_len += sd->len;
>>> 	return sd->len;
>>> }
>>
>> I could take this through the nfsd for-rc tree, but that's based
>> on 5.19-rc7 so it doesn't have f0f6b614f83d. I don't think will
>> break functionality, but I'm wondering if it would be better for
>> you to take this through your tree to improve bisect-ability.
>>
>> If you agree and Ben reports a Tested-by:, then here's my
>>
>>   Acked-by: Chuck Lever <chuck.lever@oracle.com>
>
> OK, I'll wait for Tested-by and send it to Linus.

No new crashes or corruption after several passes through xfstests.  I've
also tested the RDMA transport on soft iwarp.  Thanks for the fix here.

Tested-by: Benjamin Coddington <bcodding@redhat.com>

Ben

