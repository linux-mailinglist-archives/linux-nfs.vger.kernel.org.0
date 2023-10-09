Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E907BE665
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Oct 2023 18:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376275AbjJIQaM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Oct 2023 12:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377226AbjJIQaL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Oct 2023 12:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C48099
        for <linux-nfs@vger.kernel.org>; Mon,  9 Oct 2023 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696868961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5E6zMxJ2KNnCeOURZsxND1PpW6nucE7iyQbJdyWHjcM=;
        b=Q2oBuPp1EAEFibUAykbtLClJoCJQcA6PHEyOAr5s+bNpGb5yqug9b5MAAe2lRTd4Fvj2LC
        Tzsib8pmhLIoBuqGosybdxv6AzwVVHCSIkT2aeVbc2SOMv6iNBicFPXPqMpBGCK+BH97Ar
        qoi1jE6JCU8lyxcU6I341wYN+8olD8I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-lny99eHyM-qCeyfXkXREKg-1; Mon, 09 Oct 2023 12:29:19 -0400
X-MC-Unique: lny99eHyM-qCeyfXkXREKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71B61858F1C;
        Mon,  9 Oct 2023 16:29:19 +0000 (UTC)
Received: from [10.22.32.33] (unknown [10.22.32.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1810A40C6EA8;
        Mon,  9 Oct 2023 16:29:17 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        trond.myklebust@hammerspace.com, Olga.Kornievskaia@netapp.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3] NFSv4: Fix dropped lock for racing OPEN and delegation
 return
Date:   Mon, 09 Oct 2023 11:58:12 -0400
Message-ID: <CBD6A8F7-D581-45A2-A299-76809D052BBD@redhat.com>
In-Reply-To: <CAFX2Jfm=sibLroZSqkGEfDMT=-JdgR1F91-kCHHdGc4kTLuYgg@mail.gmail.com>
References: <93929ecf62e79670f1e3a1878757fc9fa443aa7c.1688210094.git.bcodding@redhat.com>
 <CAN-5tyGf6txJpoJBSzEh75BgZAQ1f4TbZF10Dw25GjeE4Pz=7w@mail.gmail.com>
 <CAN-5tyHOGoyhnkN5ZNjgavwQJWmGf6wY-NfgGCixdrXanedwFA@mail.gmail.com>
 <CAFX2Jfm=sibLroZSqkGEfDMT=-JdgR1F91-kCHHdGc4kTLuYgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5 Oct 2023, at 14:16, Anna Schumaker wrote:

> Hi Olga,
>
> On Wed, Oct 4, 2023 at 2:55 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>>
>> Sorry, I didn't mean this patch. I meant the revert patch.
>>
>> On Wed, Oct 4, 2023 at 2:53 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>>>
>>> Hi Trond/Ben,
>>>
>>> Did this ever go to stable? I don't know if I missed a mail from Greg
>>> that it was picked up or it never got picked up because it wasn't
>>> marked for stable?
>
> Looks like the revert went into 6.5 as commit 5b4a82a0724a. It's not
> marked for stable, so it probably wasn't picked up.

Gah, thanks for taking this on and fixing it.

Ben

