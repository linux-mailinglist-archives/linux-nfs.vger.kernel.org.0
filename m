Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36947C5A9A
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjJKR5c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Oct 2023 13:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjJKR5c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Oct 2023 13:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DC293
        for <linux-nfs@vger.kernel.org>; Wed, 11 Oct 2023 10:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697047009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xuZKeTojJH7CmJBVZYpMnwmGXP9i4stp2BEwVYBFEts=;
        b=gHeYeV5CyyM4e9iIQS+hvEZRHDE3lU2Osh4cE2ialgTq7WinSBqmxiFvNcV+apBVlTYOQp
        zUWc8comCzfIRKPZTkFLLUrbZ/qJiYiOeVkr+NDZkt2ljkxMCByBhxpy9nGdEE4h4C5Y0k
        KefBe5UxbCNkg4XOUFQ7w+uRAJonH/c=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-TN7ZExZwOhunpvM2g_JmrQ-1; Wed, 11 Oct 2023 13:56:38 -0400
X-MC-Unique: TN7ZExZwOhunpvM2g_JmrQ-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3ade1013032so12320b6e.1
        for <linux-nfs@vger.kernel.org>; Wed, 11 Oct 2023 10:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697046997; x=1697651797;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xuZKeTojJH7CmJBVZYpMnwmGXP9i4stp2BEwVYBFEts=;
        b=OnaAH6ayT4Zavj0WtvTOZRJZRuk+dCbz3p0+9JEfqoIUV8CYSfIO1Co2SExl/EurUc
         lYy2WwzBbMJZ8LCVhg3Lkt9ACls6oiTrUM8n46CsEsRSY7c59K1bnRElXkpT5e+uWHVh
         R0Dd6UlAZz3MV+5CtVzIn40wa6mz2Fti5yxrGHS21Xp6v6Y7Dnw2lwdIaGqkXaiLg/u6
         VGLW+QbH9cl4hCfDCwsogn4UfwiXAWGlEjIiyQeMUtvC8poh/JHYh/ZJhXf0uqJ6sgDx
         UDxB/r0slkOsQPHwIi/P2WHN37xPaUfeTxbcCItmsUJpFHX9n57HD0cCgR7jy2AfieRn
         sTfA==
X-Gm-Message-State: AOJu0YxGa4F7bCwXXx0wYcfdCSFEJJA4IRLJaNOv71IWUIGTXy/fcAVp
        MFTtL1Ph8bCSlAm1rLlW/tw5q4JfU3QXrQwDs+t95adlGI0Q7lhaIjWbYFUbXMyWNa3xevAVsuK
        VLXD/Y8Qnjrry3yfDyManfZrnkwQigNZyMDC/znqW3ROG30ymCgDkYWoOvgmTaFHP1Q4y3/Gxz9
        TUOu9F
X-Received: by 2002:a05:6808:1590:b0:3a9:f25d:d917 with SMTP id t16-20020a056808159000b003a9f25dd917mr28260258oiw.4.1697046997223;
        Wed, 11 Oct 2023 10:56:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSf2p2jU9uuJKJplQdnXTQoWVcFVK3W8C8r03+j8QzqG+Tc/g7DCIZj3T9OMs6kn04aSTphw==
X-Received: by 2002:a05:6808:1590:b0:3a9:f25d:d917 with SMTP id t16-20020a056808159000b003a9f25dd917mr28260229oiw.4.1697046996872;
        Wed, 11 Oct 2023 10:56:36 -0700 (PDT)
Received: from [10.193.20.130] ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id d19-20020a0ce453000000b00655d6d31470sm5868866qvm.43.2023.10.11.10.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 10:56:36 -0700 (PDT)
Message-ID: <96db32fb-3add-482c-9ecb-0a6d999f27f6@redhat.com>
Date:   Wed, 11 Oct 2023 13:56:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Steve Dickson <steved@redhat.com>
Subject: Bakeathon 2pm EST talks
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The Bakeathon talks are starting Today, at 2PM EST

Feel free to join us via google meet at

https://meet.google.com/gyu-kmxt-rke

steved.

