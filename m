Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C8358BC1A
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Aug 2022 19:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiHGRtO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Aug 2022 13:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHGRtO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 7 Aug 2022 13:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59CAA388F
        for <linux-nfs@vger.kernel.org>; Sun,  7 Aug 2022 10:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659894551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yJN30IgIdFeqPdQPsqTPZXwtfzMqHC3RcSo4EJL1ecQ=;
        b=P5zOLLiF8LYWEKPlbj98iydJxSfHpcUeGDY5YeLan2ebsVfLPtdYn1a9oGIg/EJSwhJPbx
        4+PbsYKqvk7Zge9WYvSRnw/sH0Hw9EkKFfjKm4r1dbRzO2VKr0RhbJwqVsTQBlbAZ/ZHE6
        jcQrzRlMyEe2xvYnv8OXH+yLBUaewOw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-odU11eisMI6eDeyceTO6Yg-1; Sun, 07 Aug 2022 13:49:10 -0400
X-MC-Unique: odU11eisMI6eDeyceTO6Yg-1
Received: by mail-qk1-f200.google.com with SMTP id v13-20020a05620a0f0d00b006b5f0ec742eso6255196qkl.2
        for <linux-nfs@vger.kernel.org>; Sun, 07 Aug 2022 10:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=yJN30IgIdFeqPdQPsqTPZXwtfzMqHC3RcSo4EJL1ecQ=;
        b=FflO0qLIM9jmATBskrHFQP1cVnKmS/EUKQvBEyMGRPhDGhieDhy7FVoDwc6O6Fewte
         jyK8SNc2R30irUpckwv4UNEyKsMUPl53A57mynqB/6HZbnr40ecN3kLt5TEfwl1Kf4EF
         L9qLiIkagZALfOrzaH0+iViwxtvtJJ5TV1UaXR1pHqJS9Rys91N4deHeENrXHEINvp1P
         w5CC9n+uIQghbsicnW6eaWRd4WoGa5UtMrpKLGT7nNvAiXn/EZzEB19Cu8Mh7L6VCG+1
         VYWv1kJht93oKnyObLc55Sbe+gLFSViHU5bEEsW2r1DO3ELmlkdUez+G9ez8VxgjS+jr
         ZP7A==
X-Gm-Message-State: ACgBeo0Z68YPFagl8x2zrEYHte7ECaHVLbIxvAwGoFmWuNKDLMFUiVKq
        oARFJfCGjSpjYQ/Q4H6pYnCN3gp7F3zbKDQ5dmrbmQw5NRGuxqedzdXIflTzJ20b9yK5KZoyVG6
        HioiROQe6VeHUWzIKSCDb
X-Received: by 2002:a05:620a:17a5:b0:6b8:fde3:699c with SMTP id ay37-20020a05620a17a500b006b8fde3699cmr11708154qkb.428.1659894549509;
        Sun, 07 Aug 2022 10:49:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR547Myw4N3g65nuVw5RMoVKmK/2ObqAJ2+xcRqKNuL23vNqOzf0ZjivQoyrYVCLfzI7TPEKWA==
X-Received: by 2002:a05:620a:17a5:b0:6b8:fde3:699c with SMTP id ay37-20020a05620a17a500b006b8fde3699cmr11708148qkb.428.1659894549277;
        Sun, 07 Aug 2022 10:49:09 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.189.21])
        by smtp.gmail.com with ESMTPSA id y8-20020a37f608000000b006b66510f4f7sm7371284qkj.6.2022.08.07.10.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 10:49:09 -0700 (PDT)
Message-ID: <6b8f9c07-687a-7d00-423c-0b4808a084c9@redhat.com>
Date:   Sun, 7 Aug 2022 13:49:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: libtirpc-1.3.3 released.
To:     libtirpc <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

In this release a large number of deadlocks in the
in the multi-thread code were fix. A number of
memory leaks were plugged and a DoS was eliminated.
As well as a large number of bug fixes.

The tarball:
 
http://sourceforge.net/projects/libtirpc/files/libtirpc/1.3.3/libtirpc-1.3.3.tar.bz2

Release notes:
 
http://sourceforge.net/projects/libtirpc/files/libtirpc/1.3.3/Release-1.3.3.txt

The git tree is at:
    git://linux-nfs.org/~steved/libtirpc

steved.

