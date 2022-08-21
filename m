Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB2F59B525
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Aug 2022 17:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiHUPmL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Aug 2022 11:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHUPmJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 21 Aug 2022 11:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984D322B05
        for <linux-nfs@vger.kernel.org>; Sun, 21 Aug 2022 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661096527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vPY/Iq/xi6w1iMim7US8f8DfoFzuIIz4EoiLyt1pS0E=;
        b=QqB5cg6qCfTHm+kUETbxfJAwf+CBxG3rhEze7ajhRAoFzZg7mcOfHldkHpQqeIzQUtakQR
        +KNh8qLrmV1scvzg4G6TsKHINVJDeQSeyq6006ItAzLN7wgq4oAiPUn1ubt44Yz5jMccpY
        qC7wjTnHkT0D/YJHM5SBB0i7EEUIf8Y=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-hoxkN7hBO-mTMk0Vv06VJA-1; Sun, 21 Aug 2022 11:42:06 -0400
X-MC-Unique: hoxkN7hBO-mTMk0Vv06VJA-1
Received: by mail-qv1-f69.google.com with SMTP id gh7-20020a05621429c700b00496b1a465b1so4371331qvb.5
        for <linux-nfs@vger.kernel.org>; Sun, 21 Aug 2022 08:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:from:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=vPY/Iq/xi6w1iMim7US8f8DfoFzuIIz4EoiLyt1pS0E=;
        b=xUT++l+bJZy4tEDZZ77voVXGaE9Dk9aPuhJvNt5xXk+QgASFCkIweasdFxgiwBC1Lk
         Ileyj9D3eOVr6hC2xnx2BjQFuMwCRnZeWuzbCmz9+Crr9a0V9bZcOm3nTASGysx8rubr
         gF0hcW/ICUEPXZl+c30JpJrLC0zOP+qKF85pmLlPF0FOoFldIqtw4gIzkDL2UekaTBsz
         4fGf8B/Pb1fTggDgAMfs5hqkuo2uQN8ErIB5dIlsdEDgKaWQUnQ6MqC+M5onT0+Rhgdg
         TbSPNyVBQONKY0ntN/AK+DvOOWrGJkcKwiRJ9SLmUiwmsTWPHXZ/HBRwabUQG76/GjBs
         gWIg==
X-Gm-Message-State: ACgBeo0rVyb4dz23o5pGAnwAGXXAdCLZpyXSFXPwDCvqAoIzR83Xd81e
        qiye8vFBKTTZwrROPh7ylHbpkfjsme69ex4Cf4++rOlzwVHcXnychaw5n4/BLYLCzlbSgkG3WaI
        PZVZ+FdNh1faC6+XjvY5MI4pc+Gr+ZbzjQWLyhQGjbS/FsgK+3ylOqUZDEtUTuKxNPyOGJw==
X-Received: by 2002:a05:6214:76b:b0:476:5c98:2a55 with SMTP id f11-20020a056214076b00b004765c982a55mr13034469qvz.70.1661096525481;
        Sun, 21 Aug 2022 08:42:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR43SYIUTWMfWKO1fXeXtj46uPMA/CiUQ+i546Wh4JDUmbVhv1CTV4JidQBkBW+kOHTC4fCltQ==
X-Received: by 2002:a05:6214:76b:b0:476:5c98:2a55 with SMTP id f11-20020a056214076b00b004765c982a55mr13034455qvz.70.1661096525130;
        Sun, 21 Aug 2022 08:42:05 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.245.220])
        by smtp.gmail.com with ESMTPSA id do14-20020a05620a2b0e00b006bb0e5ca4bbsm7159529qkb.85.2022.08.21.08.42.04
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Aug 2022 08:42:04 -0700 (PDT)
Message-ID: <7f97d49e-f91f-65ef-8617-1a7f4e3684f0@redhat.com>
Date:   Sun, 21 Aug 2022 11:42:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: NSFv3 needs to die, so NSFv4 may live
Content-Language: en-US
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
From:   Steve Dickson <steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey,

One of our product manager shared this we me [1]
I thought people on this list might find it
interesting... I did.

steved.

[1] https://www.loadbalancer.org/blog/nfsv3-vs-nfsv4/

