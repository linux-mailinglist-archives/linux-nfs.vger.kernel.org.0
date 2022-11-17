Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13BD62DDA5
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 15:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbiKQOMi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Nov 2022 09:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiKQOMg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Nov 2022 09:12:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2696C76164
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 06:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668694296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wpo0rn1pBCjCV4bU+0IiTD80Tf+UEqnfeMIwfEX23AY=;
        b=ihPb6V73FOF4XIjvvVDz5ox2qGkkFSSsWrzSPvrc3IeR4ZlgzHpHdIVSzWlN9jmrDHhp2v
        c6j5caJXHdTDStzzBYBl5ThPxdFyQRE3kV37CfG3IavGk+3/OWZFRXGyN7PMpSzzLs5LrV
        q6RdNvyYjEavQe/T7A2Aa4BfeXpaRaM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-354-ez0yF1WuOIWI2kU2pUt1Bw-1; Thu, 17 Nov 2022 09:11:35 -0500
X-MC-Unique: ez0yF1WuOIWI2kU2pUt1Bw-1
Received: by mail-pl1-f197.google.com with SMTP id x18-20020a170902ec9200b001869f20da7eso1483503plg.10
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 06:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wpo0rn1pBCjCV4bU+0IiTD80Tf+UEqnfeMIwfEX23AY=;
        b=aWvnrJgjkDJPUKCXPtZpxTUcrlTC0jWZIDOC9adcr3dGH2201XsmlkH7XSlNJRkiXE
         mqaSfDhmomjtSh2XsEszHlQ8MRMnFbiChe/ZOzeDREBBLBw2l2z1dXhq77TWyh9arFZx
         Dt79E3/+Knuz1nZFxsGB0iqo5fRyE8TlE7pJ4t6XsMK7cuIzKtNy94kKCIv43aBdX8Fv
         KLVTZ9Fxv1ZEqtXe+ezkDxxmcc7pIxqVmj7+TTL8jEhHFui+mLcVYH1K6mfMcj0Bbb7M
         CPh66yOCjCZs1DK/zbxiB7eg82YAo2/iXHiqVd6hllo/KDOI+l1VZf+QX0MtNnWJYxMf
         z46w==
X-Gm-Message-State: ANoB5pnaWnWKFAPpnky8GYOuLVoSsrWN1QQ8v15KjCOio6aHz1+i4myA
        yrXehxy/52ukBwEiNeIzFvCyTiFYb60Bwj1yx1yXAAH3ZDbhweR5XMs/F37i1mRiJQYkcV8IK66
        EZz71QFLfd0XhvpxJMtCwaDap4DvgajQEUVOs
X-Received: by 2002:a17:903:2448:b0:188:f5c7:4d23 with SMTP id l8-20020a170903244800b00188f5c74d23mr1251321pls.125.1668694293609;
        Thu, 17 Nov 2022 06:11:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7/ptWMpGaatE6yG6Y+YKNblVlzyCypiHU9BbCa7bA6jTELsiAgZ0A87A2SAAlaZv4B4d6D7zmTD9hbRM9jYwc=
X-Received: by 2002:a17:903:2448:b0:188:f5c7:4d23 with SMTP id
 l8-20020a170903244800b00188f5c74d23mr1251307pls.125.1668694293360; Thu, 17
 Nov 2022 06:11:33 -0800 (PST)
MIME-Version: 1.0
References: <20221117115023.1350181-1-dwysocha@redhat.com> <20221117115023.1350181-2-dwysocha@redhat.com>
 <3716830.1668693167@warthog.procyon.org.uk>
In-Reply-To: <3716830.1668693167@warthog.procyon.org.uk>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 17 Nov 2022 09:10:57 -0500
Message-ID: <CALF+zOme4qF1y5ZLuhNO8Cahn-YCDnNCRQ4WN75C9cp69B6KPA@mail.gmail.com>
Subject: Re: [PATCH 1/1] fscache: Fix oops due to race with cookie_lru and use_cookie
To:     David Howells <dhowells@redhat.com>
Cc:     Daire Byrne <daire.byrne@gmail.com>,
        Benjamin Maynard <benmaynard@google.com>,
        linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 17, 2022 at 8:52 AM David Howells <dhowells@redhat.com> wrote:
>
> Dave Wysochanski <dwysocha@redhat.com> wrote:
>
> > +             clear_bit(FSCACHE_COOKIE_DO_LRU_DISCARD, &cookie->flags);
>
> Actually, can you do test_and_clear_bit() and then log a trace point, say:
>
>         fscache_see_cookie(cookie, fscache_cookie_see_lru_discard_cancel);
>
> if the bit was set.
>
> David
>

Ok sure.  I will post a v2 with the trace point and the test_and_clear_bit.

