Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC55A8929
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 00:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiHaWoN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Aug 2022 18:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbiHaWoM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Aug 2022 18:44:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCE79DB66
        for <linux-nfs@vger.kernel.org>; Wed, 31 Aug 2022 15:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661985850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b8BIA9V4gV/R6v0QwJqqLfE32V68GttrRgOEBCLtJSA=;
        b=e+nQts7+20+GVgjvK2N9l1oZZzWD4ByB/PgKB6ZU8YINRi2MT80ziyn8TUZ79g2O/J+pCz
        HtOAIXnQhxkGnMsLkppFff8MniuH+99mND99M9u3n+5cer/5H/gH3ZpoZNoq35xOyuMqU6
        BP49MIBKcpYQ/nmB7F8zKa4uKx3lB0g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-wicl6dt_MR-0G5YNgRoa5w-1; Wed, 31 Aug 2022 18:44:09 -0400
X-MC-Unique: wicl6dt_MR-0G5YNgRoa5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBF213C0E214;
        Wed, 31 Aug 2022 22:44:08 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 677211121314;
        Wed, 31 Aug 2022 22:44:08 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: client call_decode WARN_ON memcmp race since 72691a269f0b
Date:   Wed, 31 Aug 2022 18:44:05 -0400
Message-ID: <14AB2A51-CF42-4CA8-9627-7837BD0D584A@redhat.com>
In-Reply-To: <24350372a2a5cb244bc843faef569404088f9278.camel@hammerspace.com>
References: <6806AB48-F7D6-4639-8D03-E31BA25C4CF3@redhat.com>
 <24350372a2a5cb244bc843faef569404088f9278.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 31 Aug 2022, at 17:34, Trond Myklebust wrote:

> On Wed, 2022-08-31 at 16:20 -0400, Benjamin Coddington wrote:
>> Hey Trond,
>>
>> Since "72691a269f0b SUNRPC: Don't reuse bvec on retransmission of the
>> request" I can sometimes pop the WARN_ON() in call_decode(), usually
>> on
>> generic/642.
>>
>> I think there's a kworker halfway through
>>
>> xprt_complete_rqst() ->
>>        xprt_request_dequeue_receive_locked()
>>
>> between these two linse:
>>          xdr_free_bvec(&req->rq_rcv_buf);
>>          req->rq_private_buf.bvec = NULL;
>>
>> And at the same time the task is doing the WARN_ON(memcmp()) in
>> call_decode.
>>
>> I'm not sure of a good fix - perhaps we can fixup the other paths
>> that
>> require the NULL check in xdr_alloc_bvec() so we don't have to set
>> bvec =
>> NULL.
>>
>> Any thoughts?
>>
>
> How about this?

I think that will fix it.  I'll test it overnight and see what happens.

Ben

