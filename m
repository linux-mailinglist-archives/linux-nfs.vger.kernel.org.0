Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C20A7EF199
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 12:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345862AbjKQLVO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 06:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345930AbjKQLVN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 06:21:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA155D5C
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 03:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700220067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86WEu9/c4eNc+CvB1Lun/RnipDZLfsoBDIai2FaBSOg=;
        b=PL2GP8ptPtjU3jrDPbx39zE6fwtkioR/wn/7x5tWqc17kjZWVaNyhjGF6amLe8JJ4y5daY
        ztI6vKOaQBfJBHlbJCxIcy4UWMHeGqbLeSg9TRYy/NUg1cJalU5N2AIgO/u+dIkM7k0s24
        947oo4JXS0KwQaeoAXurFHmpHtpNMPo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-rLs_IBN0P3WbY54BOJgmUw-1; Fri, 17 Nov 2023 06:21:05 -0500
X-MC-Unique: rLs_IBN0P3WbY54BOJgmUw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5026D8007B3;
        Fri, 17 Nov 2023 11:21:05 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B84A2026D4C;
        Fri, 17 Nov 2023 11:21:03 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFS: drop unused nfs_direct_req bytes_left
Date:   Fri, 17 Nov 2023 06:21:01 -0500
Message-ID: <9AF594B0-9477-4EB9-81F5-85A5F9BBAF87@redhat.com>
In-Reply-To: <CAFX2Jf=bDFEx2cfzXtHhaMu0pF5dV1-sheANmAXMf0m-arr61w@mail.gmail.com>
References: <21a1f2a6155398965f79ed64f0bd23bf38a50367.1700083991.git.bcodding@redhat.com>
 <952eea7e97246870f83e7a4592e9338007dfe625.1700083991.git.bcodding@redhat.com>
 <CAFX2Jfkc7p+22aK0KvN4yUerS1HuKDC+Njo_AJV1=5pWW0sUYQ@mail.gmail.com>
 <CCFAA747-7BC9-40AB-8E37-A18B33A01511@redhat.com>
 <CAFX2Jf=bDFEx2cfzXtHhaMu0pF5dV1-sheANmAXMf0m-arr61w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16 Nov 2023, at 17:11, Anna Schumaker wrote:

> On Thu, Nov 16, 2023 at 5:03 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> On 16 Nov 2023, at 16:44, Anna Schumaker wrote:
>>
>>> Hi Ben,
>>>
>>> On Wed, Nov 15, 2023 at 4:34 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>>>>
>>>> Now that we're calculating how large a remaining IO should be based
>>>> on the current request's offset, we no longer need to track bytes_left on
>>>> each struct nfs_direct_req.  Drop the field, and clean up the direct
>>>> request tracepoints.
>>>
>>> I've been having problems with xfstests generic/465 on all NFS
>>> versions after applying this patch. Looking at wireshark, the client
>>> appears to be resending the same reads over and over again. Have you
>>> seen anything like this in your testing?
>>
>> I have generic/465 failing before and after these two patches on pNFS SCSI..
>> but at least it completes.  If I run it without pNFS I can see the same
>> thing.. it just sends the same reads over and over.  I'll figure out why.
>
> Thanks! I have it failing normally as well, so that's expected. It's
> the hanging forever that's not :)

The direct read is returning 0 when there's data on the device.

Oh, the problem is probably that patch drops the update of dreq->max_count,
which I overlooked because of the double assignment.  Shame on me.

Ben

