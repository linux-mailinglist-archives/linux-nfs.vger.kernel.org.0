Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B4C6E9955
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Apr 2023 18:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjDTQQn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Apr 2023 12:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjDTQQm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Apr 2023 12:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42892D58
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 09:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682007352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1pInpJS06NPSZKQ7HjbyMjhyUVNHzW/x/pwrLPA8UFE=;
        b=aChzbDWh+hKNABAhsmNBYgh7FM4TYwzpLX0zgh5KAuAgNqCrRBkCoHj4VlxThx9y+34FMP
        FoC/iOoc4rk3NOT83YXSgBP2T/k+xy0lQ+oZSGJe8LiIHuwWhSp/DZIbPyo5ImbQljRHDx
        DVvtFcgQEdoUQHrbGd5XF2bJp/p+NQI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-0P1DSWs4Mry2eDkd8JZ0Yw-1; Thu, 20 Apr 2023 12:15:51 -0400
X-MC-Unique: 0P1DSWs4Mry2eDkd8JZ0Yw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-5ef5fbe2cfaso683136d6.0
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 09:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682007350; x=1684599350;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1pInpJS06NPSZKQ7HjbyMjhyUVNHzW/x/pwrLPA8UFE=;
        b=FAuLPKyoSgtBB1wy9lxLkHac6lmooHKenXbsMqsKg4NvRLmJMF5wW73YUnvfXTu8eJ
         ekoMiG7FBMQRGRjiD0YK+iLCbEZ0KAFu4vONj7Vou2A748QuW0aFMnZvx/JcORxa7Syw
         GU9OYLyWqHM//VU4CO8vu+Zf7OsJoYNQ7+BMFOvtkTf5Zp+PcJrFWys++jQRCWf8eeiw
         dwutz+bEw7d2uEolAqES6WPJRNEQPTzQwVOFPb7Tij1bV4MqjFqSucn7jeQHQ+b/CHuK
         G4H0KiRLdIhFRnHySqnV9D5uDr/dPCpcbzxVu25Wfl8/jaWEu+H7GTD/A5eQjpbprrj7
         12uQ==
X-Gm-Message-State: AAQBX9eJOOvDElOPWZ9uIZKdhVXu0DMDoc1RMh+Re3OV8epe6N4Se+Zh
        F8wrATtDBoEbB3p9wzje0ZNcQ5X1jFaYuRh0YK17FwGNrCQq5NexZTwh1Oe8ZSPkpV78gRJlaVS
        H4N69D+TLgBODg3UzCsWsOClEp04i
X-Received: by 2002:a05:6214:5292:b0:57d:747b:1f7 with SMTP id kj18-20020a056214529200b0057d747b01f7mr2848617qvb.1.1682007350602;
        Thu, 20 Apr 2023 09:15:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350as5i6Onlab5SxKqkYqX+WDI7uGScM0W+AfU3fQ746oqDRKNiOswERFhsWDvBmYisvRxasD6A==
X-Received: by 2002:a05:6214:5292:b0:57d:747b:1f7 with SMTP id kj18-20020a056214529200b0057d747b01f7mr2848597qvb.1.1682007350359;
        Thu, 20 Apr 2023 09:15:50 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.248.80])
        by smtp.gmail.com with ESMTPSA id p8-20020a0c9a08000000b005f07afa6966sm485084qvd.80.2023.04.20.09.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 09:15:49 -0700 (PDT)
Message-ID: <7f916c5b-0848-d048-eadd-cff6ae17adb8@redhat.com>
Date:   Thu, 20 Apr 2023 12:15:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Steve Dickson <steved@redhat.com>
Subject: Spring Bakeathon Starts Next Monday (reminder)
To:     nfsv4@ietf.org, linux-nfs@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

In preparation for next week's BAT, there is a
new NFStest 3.2 release [1] which now supports
Python 3 as well as number of new tests
and a new nfs-utils 2.6.3 release [2] which
has RPC-with-TLS support and reexport enhancements
as well as a number of bug fixes.

The nfs4bat.org web page [3] has been updated with

     * Where to register your server's name, type, etc.
     * Where register client results.
     * Where to register for talks that are give at 2pm (EST)
       (Note, these talks are very informal... slides generally not
       needed. So if there is a subject you would like to talk about,
       this is the form for it. Please sign up).

At this point we have a pretty good registration, but new comers
are always welcome!! If there is any interest... at all,
please reach out to:
     bakeathon-contact@googlegroups.com.

See you, virtually, next week!

steved.

[1] http://linux-nfs.org/wiki/index.php/NFStest
[2] https://www.kernel.org/pub/linux/utils/nfs-utils/2.6.3/
[3] http://www.nfsv4bat.org/Events/2023/Apr/BAT/index.html

