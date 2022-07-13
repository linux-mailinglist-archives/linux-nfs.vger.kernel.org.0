Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E325573975
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 16:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbiGMO7S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 10:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbiGMO7K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 10:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7841F1CFE9
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657724344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0KKXZaTJN1bGnDN8K+Xo2xn1xWiTEkaPMSA99AxkC1s=;
        b=grfine7vBeU9RjbRsydigqMLRwCx5klJDIX71kDMJPfDt1KTI9UD3/tACc28RPrY05Rat1
        xb6LP3Js0YW7O8Io14vtuCErGhbv3Td++MV9VHLFK+5mDIgU9tCP4m6MWFNqs8pY0WrB6l
        MlwRQajMXCG2aVdpN9nMyvOgTGv5y90=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-fSuN6H3RMD6MfEO8y0uaZg-1; Wed, 13 Jul 2022 10:59:03 -0400
X-MC-Unique: fSuN6H3RMD6MfEO8y0uaZg-1
Received: by mail-qt1-f199.google.com with SMTP id u10-20020ac858ca000000b0031eb2399323so7550623qta.16
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 07:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:content-transfer-encoding;
        bh=0KKXZaTJN1bGnDN8K+Xo2xn1xWiTEkaPMSA99AxkC1s=;
        b=0w89dGH/oZQEpH72hxc1WjG+XmS4oQ8hFv9iVWnIbOkf9SHcEHW9JkBkDIphnI3hhS
         +jYeXRYGYE2rAa/gYXc/TfDJVvnyE7uefcBC8z14v4txiQdDRvSKcheXcwqdbcxqZDIc
         9vvdPC2ZawGw7UUi5gT92UoN6+O+tLXLcKibL8uJcgNbzZjb0x62Fg0jytGpELSk9xKo
         xU/lcF8vO4VPP1YiIXgON3uIg+912nSGAICmfI5XQVeZKTMkMF3i2rg5pSO9zIkNlWb6
         OV8AEHWKyjtLXSHnY2q+VBr1R6WeQ1Kx45IddSNbHIsGoYTlYRK7WBrA6XAO7O62TxQJ
         B9gg==
X-Gm-Message-State: AJIora/FIV/m5MXLsX+4yzpuWJAqcWceYd1c0S5g5o+owhPYte6C35cT
        TSTHLA2IK9wnKdBI+DU3Js0A+vkYvjroNJnG6rV/p3MwGTqraPi+dLTbf1QK8qrBvede6XkAbuu
        nvYULq6UTU7CQTgfJDUamq1X38+mvhoao693Oou+tWPxjEDEC79WPvyWC32U+XTJUZwJXCQ==
X-Received: by 2002:a05:622a:492:b0:31e:b6ac:cf7 with SMTP id p18-20020a05622a049200b0031eb6ac0cf7mr3323612qtx.202.1657724342838;
        Wed, 13 Jul 2022 07:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t59Ga8xiXDeVUQQr+Hc1wZiemhK8gEIPmyd2GitsJErXiW6NxpCQpmgzmlfhi3LqDDJL3qVA==
X-Received: by 2002:a05:622a:492:b0:31e:b6ac:cf7 with SMTP id p18-20020a05622a049200b0031eb6ac0cf7mr3323592qtx.202.1657724342540;
        Wed, 13 Jul 2022 07:59:02 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:db8c:7bbd:f449:802d? (2603-6000-d605-db00-db8c-7bbd-f449-802d.res6.spectrum.com. [2603:6000:d605:db00:db8c:7bbd:f449:802d])
        by smtp.gmail.com with ESMTPSA id bx10-20020a05622a090a00b00304ecf35b50sm9786292qtb.97.2022.07.13.07.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 07:59:02 -0700 (PDT)
Message-ID: <480ddad3-f93a-dab3-0f50-b4b7ebacd6e9@redhat.com>
Date:   Wed, 13 Jul 2022 09:59:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Steve Dickson <steved@redhat.com>
Subject: Announcing the Fall 2022 Bakeathon
Content-Language: en-US
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
        NFSv4 <nfsv4@ietf.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

Red Hat is pleased to announce that we'll be hosting the
Fall 2022 Bakeathon at our Westford office in Massachusetts, US.

The event will be F2F as well as virtual. Hoping to
draw as many participants as possible.

Date: Mon Oct 10 to Fri Oct 14
Address: Red Hat, 314 Littleton Rd, Westford, MA

Details, registration and hotel info are here [1].
Any questions please send them to bakeathon-contact@googlegroups.com

I hope to see you there... One way or the other!

steved.

[1] http://www.nfsv4bat.org/Events/2022/Oct/BAT/index.html

