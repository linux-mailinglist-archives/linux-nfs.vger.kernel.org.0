Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D994157F738
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Jul 2022 23:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiGXVf7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Jul 2022 17:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGXVf6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 24 Jul 2022 17:35:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15D0A6152
        for <linux-nfs@vger.kernel.org>; Sun, 24 Jul 2022 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658698556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SWGDA0zppXQfhSq6d1aISsWyoSqSeBf3jiX8M4AYgZ0=;
        b=Ytz0XJtsUb8ipYJyfHxFK8fEr6mpDzn3yenYupIfIy26Sp6bvX0H0pHZuKFG7DB0vyyNQt
        LsSHXk8atF/gMvQSQsGuk4AscS3grYZny+13s0rhfiPswu9D6LEfXWMEbyVmH0ZxjzNb5z
        YGC0bU4/QFnzpMcVIqwlubpUifuynWk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-OM92XLkmNZSaSMKalAQtBA-1; Sun, 24 Jul 2022 17:35:54 -0400
X-MC-Unique: OM92XLkmNZSaSMKalAQtBA-1
Received: by mail-qk1-f197.google.com with SMTP id br36-20020a05620a462400b006b5fa8e5dd5so8363549qkb.1
        for <linux-nfs@vger.kernel.org>; Sun, 24 Jul 2022 14:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to
         :content-language:cc:from:subject:content-transfer-encoding;
        bh=SWGDA0zppXQfhSq6d1aISsWyoSqSeBf3jiX8M4AYgZ0=;
        b=s0ev+sFmVi9Luo/REpAm1HlJXd7CPpAuLJZLn3ry9dU+DdcOjmgA9wNXbUFUnO1aG7
         qrRK0ETyx7wFioL6/8gzHAkD02B3DlWBzMHXoLVLP/4VsGqxA2MY1l1zmFXBJO46/HZf
         WLZFBO7EZMcTZ60aUP+CCfGEbb8ZpmOJxjGmXVJxy2MG4wwAukfLvqJsr1FI6Bl1Z/Nv
         NNyUKzWXl6uikMAmuTq4KXt50iyh8BvlV4BkGyv6hY11970Zi12kvs/ZR+4OZTteGIsz
         TfRfS35TRgsuPKv4mfiAMLqRaKJaHWFIPG//BnfFZmr+CbwyCA6kjPqAe/odxH9HRMAa
         /Mgg==
X-Gm-Message-State: AJIora9998F4HGSOTRCtWId7ms9XPf18uGoqQsnyCZSR0muM0Zgwq1bp
        xWFyCv9EleQv8KI8UdFDo0BalCNKOw//d8CH2f8yKg/Eh2Y33dQZ6MAu2DWCjAfklBdoUoZEQXe
        An2TFIVykP0VS68LWVlXQhHtFsABzUrbL/AoB65zizVsfDUbQh8xDhWcMXqg4gyCs1ZyTNg==
X-Received: by 2002:a37:f516:0:b0:6b6:5dea:909f with SMTP id l22-20020a37f516000000b006b65dea909fmr1238297qkk.497.1658698553520;
        Sun, 24 Jul 2022 14:35:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tw++WbW/edG1LFJVy+s3a5+o7d0++DbVsk8/YCuzvILXPFC1S0BfyLLx1pqBY5e4CxLiYsBw==
X-Received: by 2002:a37:f516:0:b0:6b6:5dea:909f with SMTP id l22-20020a37f516000000b006b65dea909fmr1238285qkk.497.1658698553212;
        Sun, 24 Jul 2022 14:35:53 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.247.125])
        by smtp.gmail.com with ESMTPSA id k21-20020a05620a415500b006b5ed1eccc5sm8346994qko.44.2022.07.24.14.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 14:35:52 -0700 (PDT)
Message-ID: <05785942-1ef8-084e-9851-f01d4a70a0e0@redhat.com>
Date:   Sun, 24 Jul 2022 17:35:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To:     linux-nfs@vger.kernel.org
Content-Language: en-US
Cc:     "J. Bruce Fields" <bfields@fieldses.org>
From:   Steve Dickson <steved@redhat.com>
Subject: nfs4-acl-tools-0.4.1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

I just made a new nfs4-acl-tools which basically
fixed compile problems with the latest autoconfig
releases.

As well include all the latest support for the
new --dacl and --sacl options

Finally, add support for the NFS4.1 ACE_INHERITED_ACE flag

The git tree: git://linux-nfs.org/~steved/nfs4-acl-tools.git
The tarball: 
http://linux-nfs.org/~steved/nfs4-acl-tools/nfs4-acl-tools-0.4.1.tar.gz

steved.

