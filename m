Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2780A7AC832
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Sep 2023 15:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjIXNH4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Sep 2023 09:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIXNHz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 24 Sep 2023 09:07:55 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F03FC
        for <linux-nfs@vger.kernel.org>; Sun, 24 Sep 2023 06:07:48 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-405524e6769so13779965e9.1
        for <linux-nfs@vger.kernel.org>; Sun, 24 Sep 2023 06:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695560867; x=1696165667; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKQSFpVOWxzppMdEhRBjtILfkWW9QMcDhFU8SoDWQAk=;
        b=kh2oQ/KiuQW+7w4+1e7VGmqJQuzswk1ubKFXpTitDDjQTEO7jpfDGh5Utp0gNDH11E
         9GZw9+RjG2ThXoGu/NxSF9/QN+nE+zM0e74l0ec/GnLCx+hUBltId1dz1bnqQhbyEgV2
         dQPz4+ISUgdbFsaUrTa9+JFgY2yry9UOaM2ZooOC1WR7o1RTKpEA4WerxCD87sMT1BPw
         uUcyi+wpe5vHliSR5WzLfcXGMnBjndRPq7EyFWvBPYNISIiroACcMMeLT7f5GGZRv+dw
         11n1pfPfNRGN9hvNMihXd22TGEK2AwLrhVi3/ilmMK1LPtDrm1rNW9QGxM8zgxJKYvGt
         /nRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695560867; x=1696165667;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zKQSFpVOWxzppMdEhRBjtILfkWW9QMcDhFU8SoDWQAk=;
        b=qVFfwxzyVpRw2bNppwD3qmuClBkLg1jm18wAjY94Te/1fulbGiA13t6icsUGo3CG0r
         BLlYyfsqJ4LrWpPW+BvdPntig92FK00QcIGl1LOFTyyVZvvG56RfnFvVJG55Ac38kx/M
         MG8pVYdbJf38JINnXqZ2HW4Q07kUXWGwWkP7LNJRrl+EoD/7zfDAlzXWR1Ywx+SgTnL7
         iibWk2rk0Cut92PD7Me7DX6PjZ+d8/lvVsRhk+ue0LEjKvbc7tJoWULTYpwgkmHceOTi
         A0np0ONmqgq7mnc80U9Pbewk6PKQx4j2x0WbcLuMHPaOETGg0eZTihKbPgrpTVzMjcvE
         KeTg==
X-Gm-Message-State: AOJu0YwuCGF6Yv6oQP2NrBuY1SuxgRBIvP9arOuDQWUedSsUfm++0R7c
        a42CapAuLh5VR4wUidYSK2gWzGilBH0=
X-Google-Smtp-Source: AGHT+IEdLuaiKAOfrLeT/TU7QzvRik9UimNH/jbpDeVdeGpfMzxvuBfnJPGzfzzUUMCjwz5oWbHQzw==
X-Received: by 2002:a05:600c:2050:b0:402:f91e:df80 with SMTP id p16-20020a05600c205000b00402f91edf80mr3245322wmg.3.1695560866897;
        Sun, 24 Sep 2023 06:07:46 -0700 (PDT)
Received: from [192.168.1.13] ([88.118.123.149])
        by smtp.gmail.com with ESMTPSA id n15-20020a7bcbcf000000b003ff013a4fd9sm9620115wmi.7.2023.09.24.06.07.44
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 06:07:45 -0700 (PDT)
Message-ID: <f1d0b234-e650-0f6e-0f5d-126b3d51d1eb@gmail.com>
Date:   Sun, 24 Sep 2023 16:07:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
Content-Language: en-US, lt
From:   =?UTF-8?Q?Mantas_Mikul=c4=97nas?= <grawity@gmail.com>
To:     linux-nfs@vger.kernel.org
Subject: Data corruption with 5.10.x client -> 6.5.x server
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've recently upgraded my home NFS server from 6.4.12 to 6.5.4 (running 
Arch Linux x86_64).

Now, when I'm accessing the server over NFSv4.2 from a client that's 
running 5.10.0 (32-bit x86, Debian 11), if the mount is using sec=krb5i 
or sec=krb5p, trying to read a file that's <= 4092 bytes in size will 
return all-zero data. (That is, `hexdump -C file` shows "00 00 00...") 
Files that are 4093 bytes or larger seem to be unaffected.

Only sec=krb5i/krb5p are affected by this – plain sec=krb5 (or sec=sys 
for that matter) seems to work without any problems.

Newer clients (like 6.1.x or 6.4.x) don't seem to have any issues, it's 
only 5.10.0 that does... though it might also be that the client is 
32-bit, but the same client did work previously when the server was 
running older kernels, so I still suspect 6.5.x on the server being the 
problem.

Upgrading to 6.6.0-rc2 on the server hasn't changed anything.
The server is using Btrfs but I've tested with tmpfs as well.
