Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8C54AE6B0
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Feb 2022 03:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbiBICkM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 21:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiBIA6o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 19:58:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D89AC061576
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 16:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644368317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ya5qejF855GRhDxSGluLFph6Nl2oYN8Tyq3L8zWOz3Q=;
        b=Wjk7Ev/sD3Q8HAH0X5tx+rOTMfNuqqUHv5jKfUT1t6QP8/PTBq6cW3Oaw/Q8ghK65gDpHC
        DOJhg5EvDRJMcy+0/VA/ZrG7AqaaouSHvJYvP17vjV90oUWXI34kYB9fXUXe4BAQCiWGch
        VYw23zs0vkKs7gCgvLRwV3f8tvemi14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-pP_th-AENdy1PZFONZl3DQ-1; Tue, 08 Feb 2022 19:58:34 -0500
X-MC-Unique: pP_th-AENdy1PZFONZl3DQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDC1A1091DA3;
        Wed,  9 Feb 2022 00:58:32 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5E0B1042548;
        Wed,  9 Feb 2022 00:58:31 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, anna.schumaker@netapp.com
Subject: Re: [PATCH] NFSv4: use unique client identifiers in network
 namespaces
Date:   Tue, 08 Feb 2022 19:58:29 -0500
Message-ID: <6155F54B-B235-4C9D-8612-4885F23DC1EC@redhat.com>
In-Reply-To: <81b7ed0f2ec6771986a01d20358f0f640673b901.camel@hammerspace.com>
References: <6e05bf321ff50785360e6c339d111db368e7dfda.1644349990.git.bcodding@redhat.com>
 <189aba691b341f64f653817c9cdf018ef34ac257.camel@hammerspace.com>
 <7CDAEA98-3A8D-459A-80FE-82AA58A4EDA2@redhat.com>
 <81b7ed0f2ec6771986a01d20358f0f640673b901.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 8 Feb 2022, at 16:47, Trond Myklebust wrote:
> On Tue, 2022-02-08 at 16:37 -0500, Benjamin Coddington wrote:
>> On 8 Feb 2022, at 15:27, Trond Myklebust wrote:
>>> Also, why the exclusion of init_net?
>>
>> Because we're unique enough if we're not in a network namespace, and any
>> additional uniqueness we might need (due to NAT, or cloned VMs) /should/
>> be getting from udev, as you envisioned.  That way, if we are getting
>> uniquified, its from a source that's likely persistent/deterministic.  If
>> we just generate a random uniquifier, its going to be different next boot
>> if there's no udev rule and userspace helpers.  That's going to make
>> things a lot worse for simple setups.
>>
>
> So you're following up with changes to nfs-utils to configure udev?

Yes.

Ben

