Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091B77C561D
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 16:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjJKOCi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Oct 2023 10:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjJKOCh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Oct 2023 10:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF9EB6
        for <linux-nfs@vger.kernel.org>; Wed, 11 Oct 2023 07:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697032909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OfVphKfwXSPy2gTuMPcbrHVYxWKcucTFFVTKU2lXyTw=;
        b=UUBEms3lZTP8hyXTQ2u5YfQJ2K659nJtgcVVebNd4gC8rUKkxMxFWXSUpu2jJ6GYbSY3w3
        Q+VOin2SIkKRICb7av7NSVUDlJnrQ/NQBQsxglMMOP3Ky9CherFVBdc4S1rCcpc85N9rV7
        AWZhPdhBBGReIgoMKbwB1F7+coAk4mU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-wMB23U4kPnq8I-9ED-oykg-1; Wed, 11 Oct 2023 10:01:33 -0400
X-MC-Unique: wMB23U4kPnq8I-9ED-oykg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08D4981DC18;
        Wed, 11 Oct 2023 14:01:22 +0000 (UTC)
Received: from [10.22.9.172] (unknown [10.22.9.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B18941C060B0;
        Wed, 11 Oct 2023 14:01:21 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Dai Ngo <dai.ngo@oracle.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: missing patches for v6.6-rc
Date:   Wed, 11 Oct 2023 10:01:21 -0400
Message-ID: <09B062C8-6D70-4BAF-88C0-07A3BA3A36EC@redhat.com>
In-Reply-To: <CAFX2Jfmrh1YVtf_G1pSsORnF5qVMBjrgMBsS4BWTmx+vLdoAZw@mail.gmail.com>
References: <2e840ad028869edeb4238869eca81593820688b1.camel@kernel.org>
 <CAFX2Jfmrh1YVtf_G1pSsORnF5qVMBjrgMBsS4BWTmx+vLdoAZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 11 Oct 2023, at 9:55, Anna Schumaker wrote:

> Hi Jeff,
>
> On Tue, Oct 10, 2023 at 8:49 AM Jeff Layton <jlayton@kernel.org> wrote:
>>
>> Hi Anna,
>>
>> There are a couple of client side patches that I think we want in v6.6,
>> but that haven't shown up in linux-next yet. Do you still plan to take
>> these from Dai and Scott?
>
> I've pushed out Dai's patch to my linux-next branch, and I can do
> another pull request before the end of the 6.6 cycle. Is Scott's patch
> still needed after your patch "nfs: decrement nrequests counter before
> releasing the req" which went into 6.6-rc5? If so, it doesn't apply
> cleanly on top of the current code so I'll need to fix it up.

Yes, that patch is definitely needed.

Want me to send a current version?

Ben

