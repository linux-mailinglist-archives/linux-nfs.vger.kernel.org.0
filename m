Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E7C6BBCA8
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Mar 2023 19:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjCOSsD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Mar 2023 14:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjCOSsC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Mar 2023 14:48:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1571A305D8
        for <linux-nfs@vger.kernel.org>; Wed, 15 Mar 2023 11:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678905987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kyuyjRPDwfvSbhu0F15Oj5KCCMZBNE2zDmX6D+QJprQ=;
        b=GWNftc7yPZAX4aAGIRTZ1yCAmialxvg8GWeQeBEjmdBL/AQQE6FdkinssMZmI2/9xQiKDy
        tyIB86GgcnGhR71vLiBTwpp88tfMUdZwFRsvHDg6SsQzUqltKdPtil6D7Rx0R5InRGvgf2
        QKY2mRg9Nx1Dq22ylmp90ODA8UE/3+Y=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-2_4Hrb4GPei0xsH-RQPdBA-1; Wed, 15 Mar 2023 14:46:26 -0400
X-MC-Unique: 2_4Hrb4GPei0xsH-RQPdBA-1
Received: by mail-qt1-f200.google.com with SMTP id c5-20020ac84e05000000b003d6a808a388so515771qtw.8
        for <linux-nfs@vger.kernel.org>; Wed, 15 Mar 2023 11:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678905986;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kyuyjRPDwfvSbhu0F15Oj5KCCMZBNE2zDmX6D+QJprQ=;
        b=GP6O8GUdWNckMNltelaBIT/NvB7e+E2ai7VpwtktGZJazDtH5vACmRAs3riyJFCNyX
         sFRl8Bk1oAWwC/3gsSSfd3BkG3Hn0stNtsvfSl7EqX0vWqlPVwIhk+fmUgzWDijdgusN
         LO7eU8kFlgtsGE+Qbc8hSWEcxl6VOnqrKWhnNjPcb4fHdBaW69sKNWSK2NVTztpLcskP
         KYuxlFzdUG74nW4m6DNo4eN8zoBgS7xeXA7mVoZz0bZ9RQk7HC1AeAGBYKFTLYrQiYPf
         cQb9jFwUswgjrCKzwhH2f5T78uOoyk45m63nDnET3UHrX7K+Fl4jCvGwhohhS7sU/G4H
         MYqA==
X-Gm-Message-State: AO0yUKUHKocxXv/V4ZjrluLSrYfh00s8ThpbJTzdtp5WfuXRvDppfEv5
        VyVvFJ9SU3f2+CJV+P0kKFmSSdq+ZT8sJ4Se08w+0LmpAxW5GkYzWlBbL07iE6vo4/XrcU2Z51H
        hvsvkzMKSd5g2ChQvP87+
X-Received: by 2002:ac8:5b8b:0:b0:3bf:cf77:a861 with SMTP id a11-20020ac85b8b000000b003bfcf77a861mr1406569qta.4.1678905985837;
        Wed, 15 Mar 2023 11:46:25 -0700 (PDT)
X-Google-Smtp-Source: AK7set8JGuwe00m23WRZR3MCRVT2Pcw9+AVk9UgmncYdL4cPbpqJc+gn8/QucpaLObL1AE3ygf1LaQ==
X-Received: by 2002:ac8:5b8b:0:b0:3bf:cf77:a861 with SMTP id a11-20020ac85b8b000000b003bfcf77a861mr1406551qta.4.1678905985586;
        Wed, 15 Mar 2023 11:46:25 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.245.66])
        by smtp.gmail.com with ESMTPSA id h19-20020ac85493000000b003b86a6449b8sm4204744qtq.85.2023.03.15.11.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 11:46:25 -0700 (PDT)
Message-ID: <901dd325-ba62-e327-571f-e3897130f835@redhat.com>
Date:   Wed, 15 Mar 2023 14:46:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Steve Dickson <steved@redhat.com>
Subject: Announcing the Spring 2023 NFS bake-a-thon
To:     nfsv4@ietf.org, linux-nfs@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

I am pleased to announce the Spring 2023 NFS bake-a-thon,
April 24-28, 20223. You can find information on the nfsvbat.org
website [1].

Like last spring, we will be running this event in virtual space.  
Please note the VPN registration and setup instructions so that you can 
punch into the BAT network.

Look forward to seeing you (virtually) at the next BAT.

steved.

[1]  http://nfsv4bat.org/Events/2023/Apr/BAT/index.html

