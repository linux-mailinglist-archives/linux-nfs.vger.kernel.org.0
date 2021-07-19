Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13E83CD4B9
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jul 2021 14:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbhGSLqe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jul 2021 07:46:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30021 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236571AbhGSLqd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Jul 2021 07:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626697633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jcPq1+1+oQiEPHp6K23QjYbtxnhKxkNFeAxXT+QXeew=;
        b=LDcDpAJUbZZt4o7ZUTejWP32zLkVxhzzfR0viUiv5vdk9amZAhQGmvUVYviAo6onof0RRs
        ty40Ox46eaLwXeM/l0Xnztk+/nKNk6c8+TmjXKFWpG0P3ajIgjM3FzADgacIWWkkTFbrwH
        us3s/Jm9+oo175VWNW9NyfS6LvQe3X4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-QX3Yuuj3PvmS6vUZduibDw-1; Mon, 19 Jul 2021 08:27:12 -0400
X-MC-Unique: QX3Yuuj3PvmS6vUZduibDw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2497F8030D7;
        Mon, 19 Jul 2021 12:27:11 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A21C100164A;
        Mon, 19 Jul 2021 12:27:10 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     xiyuyang19@fudan.edu.cn, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Convert rpc_client refcount to use refcount_t
Date:   Mon, 19 Jul 2021 08:27:09 -0400
Message-ID: <2A9784CC-8774-4633-A0E3-B90CDFC5CF7E@redhat.com>
In-Reply-To: <190d0dec631a2219c4c16a41f7c17e914f625082.camel@hammerspace.com>
References: <20210717172052.232420-1-trondmy@kernel.org>
 <6AF75462-495E-4B63-9A3E-C9639C45C1F2@redhat.com>
 <190d0dec631a2219c4c16a41f7c17e914f625082.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 19 Jul 2021, at 8:07, Trond Myklebust wrote:

> On Mon, 2021-07-19 at 08:01 -0400, Benjamin Coddington wrote:
>> Hi Trond,
>>
>> On 17 Jul 2021, at 13:20, trondmy@kernel.org wrote:
>>
>>> @@ -943,7 +941,7 @@ rpc_release_client(struct rpc_clnt *clnt)
>>>         do {
>>>                 if (list_empty(&clnt->cl_tasks))
>>>                         wake_up(&destroy_wait);
>>> -               if (!atomic_dec_and_test(&clnt->cl_count))
>>> +               if (refcount_dec_not_one(&clnt->cl_count))
>>
>> I guess we're not worried about extra calls racing into
>> rpc_free_auth?
>
> The refcount would normally be going to zero in the above case. If
> anything outside the RPC code itself tries to bump the counter then
> that is a very clear cut case of use-after-free.

I am thinking about users of rpc_release_client() calling it multiple times,
but perhaps that's not something that happens.  This is a different issue
that's not added by your patch, I was noticing it.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

