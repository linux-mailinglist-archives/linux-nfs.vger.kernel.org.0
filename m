Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF4C69814F
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Feb 2023 17:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBOQvL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Feb 2023 11:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjBOQvK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Feb 2023 11:51:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B854093FF
        for <linux-nfs@vger.kernel.org>; Wed, 15 Feb 2023 08:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676479816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+WZqTy92ozfPdnDPKueAeMljl3Kn1xAkm4pvRyoMFAk=;
        b=gbHPmT/tkJFm3PT0hNowgyQ3u3Ayg0t+HipLvm8bMOP/uXE4OkonMNwEvMueItFbycv2GH
        UcdiyFWwwj+1OqUi/qKQX8GjddFoVw0TEKez85E7VS9eEIPYJ8RX+b7PnzQFX887NMJsrb
        dCVSbaSdqnFD9aDWrWY+/QxgPoLGD9M=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-247-uoB4x8XOMyCtyX7zGSorEQ-1; Wed, 15 Feb 2023 11:50:15 -0500
X-MC-Unique: uoB4x8XOMyCtyX7zGSorEQ-1
Received: by mail-qv1-f72.google.com with SMTP id ob12-20020a0562142f8c00b004c6c72bf1d0so10801380qvb.9
        for <linux-nfs@vger.kernel.org>; Wed, 15 Feb 2023 08:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+WZqTy92ozfPdnDPKueAeMljl3Kn1xAkm4pvRyoMFAk=;
        b=3Me1vkVbbSLlLQw6KNuWJ1Iu4jaDD/RBqJg+2akfzc1/WZYcscadlRp4GSaHVeLROV
         sgLLLTdicqV8P1kcBPXPtU8kNpCKvh7sORjGmj/rMkCBd2VjuQ3EKONlteu4f/HXIH32
         lFrCBKmmLDKWHLPTLo+HtcA4/Cvhoq67K0Vv2jTsABdnDV5uVwzL9hPEAdb/s0LHTQPE
         GUS8nvx0iXLCf6tb/x024zSk+WIjg2lH5N9Y5/T8InS3Zq9fidl6RiB8SC5TwGDyn8OS
         8GjpnX8rEwJX0lyhTJoXQjzcibusyVqmwR4IXoj2HjxhoLf7D89rDhfBOmbV84yn7bf1
         Fe6w==
X-Gm-Message-State: AO0yUKUbDpMk5LfM4+R1sTuKvUv5aV4f9GmlTgrqi/Rd2Bfk+DPIyUGC
        RB2vKxz3OFFO3+u5mQs1BWaINAqCaYsZY/6yR/x13St1lmGddBfQeqqn56qgtX6AWvsMIR7Gxtk
        YvjRY2ZqOYnJUP2GNxngg/b2eE1zuDROXSb8q5cHCsL9TLNB7e/iwyu1EdFhlsBh+inp6RTe0WV
        o=
X-Received: by 2002:ac8:5c0a:0:b0:3b8:ea00:7020 with SMTP id i10-20020ac85c0a000000b003b8ea007020mr5267091qti.3.1676479814650;
        Wed, 15 Feb 2023 08:50:14 -0800 (PST)
X-Google-Smtp-Source: AK7set9efyixb3P3QtLDFCx/XmT07CP1DPiP/FZpWJJtXTYyzfeFzCMHzvz2Ei9OxQUI9mrnDMXg1A==
X-Received: by 2002:ac8:5c0a:0:b0:3b8:ea00:7020 with SMTP id i10-20020ac85c0a000000b003b8ea007020mr5267048qti.3.1676479814308;
        Wed, 15 Feb 2023 08:50:14 -0800 (PST)
Received: from [172.31.150.21] ([70.109.136.62])
        by smtp.gmail.com with ESMTPSA id g3-20020a37b603000000b00739e7e10b71sm10073810qkf.114.2023.02.15.08.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 08:50:13 -0800 (PST)
Message-ID: <398eee20-8e08-6ccc-0b2f-4596fc996fd6@redhat.com>
Date:   Wed, 15 Feb 2023 11:50:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
Subject: Spring Virtual Bakeathon
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
        NFSv4 <nfsv4@ietf.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello All,

Red Hat is considering hosting a spring bakeathon,
virtually (since a lot of us don't have travel budgets,
including Red Hat).

But before we build the network, I wanted to take the
pulse of the community.... Do people still find these
events useful? Is it worth people's time? I say YES
to both those questions... but that is just me :-)

I would also like to attract new participants,
hopefully some cloud vendors would be good,
but any type of new attendance would be good too!
We'll be more that willing to tailor the event
to help make that happen.

So if anybody has contacts in those areas and are
willing to share, please let me know... I will do
the leg work.

We were thinking the last week in March (27 -31).
But being virtual... that is an open date.

So please let me know, on list or off list.

Again just tying to see if is  still a pulse for
these types of events.. I hope so  because
Red Hat is more that willing to host them!!

Also any likely new participants... please
send them my way.

steved.

