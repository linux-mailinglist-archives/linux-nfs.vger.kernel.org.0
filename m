Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340CC78568E
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Aug 2023 13:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjHWLOO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Aug 2023 07:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjHWLOO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Aug 2023 07:14:14 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2E2E47;
        Wed, 23 Aug 2023 04:14:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf0b24d925so35946915ad.3;
        Wed, 23 Aug 2023 04:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692789251; x=1693394051;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qBzTYpIaY0eNPOXEfLhPS1Eq02rOoxrsLBeQtRmQkI=;
        b=R/mEGaiawMIbszpvQxLNPN68CM1+qQNzewkt3WGF8+56pXjm/OzuAXNhQ7uf/5ArUS
         kDlkW7/jybJUdp5VQgCgtIu96diGeTiBlxW1oFSFqImLtDfVIOaJVaE4kfU+G6quW6pJ
         shs64jHufCYLfV2naz7xMrn+EWzjOfYWhFcwz8A45h4MTUqtwHuWxJSwoWTWsJWnLzQ9
         0LmpjQtOCZ6aiIoBvPMLuQMzDPhbZr1ql3lOeN8UiguziWnAk06Ye7lnlrtj/JXxLG0D
         RJBa6mz2O0z8Li2ERBkHUoV0fXU2mdlNC731frugQ925YcFbGIj9QeAYX6m2HLHoul93
         x+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692789251; x=1693394051;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4qBzTYpIaY0eNPOXEfLhPS1Eq02rOoxrsLBeQtRmQkI=;
        b=CpVEIJRTjLvIFwcuoqp3OkC6+qAWGw2ZRSu1bAi65WiJfSJvbmfW/OgELAvSuodjR9
         ntQD6LNmzAXr0qwUZhezO/HSODK/Rmyx6iU+C3Mf2DRu1j5yd2WKdu0afRpMS7Xi3vo3
         tqyw8QHiySzB4sx4lpVU2zemuP1793Et/9r58SAcfyGqq3zCtrZ5pq0zE5+5UxuphgTi
         3O+SLMm77IjM4+H7nE4hBdI/PrfTVVYr4jcVka54KVsfuuW+dFINCvPFjpngTX1n4muY
         tpNVH0rpClAzvTbaJ7OveUyRx2jVZ2FS2Z/ENV0nFr2AbCD5///hzcyeLAc3l/3l8tCl
         iJ+w==
X-Gm-Message-State: AOJu0YweCpuRpwKwqzjXPPW1mG4+ZiAMQ9SRUPOb+v38lkLxtAzejOwx
        IX7yOZk0FNxp4aLku7OnZDY=
X-Google-Smtp-Source: AGHT+IFQ4GfEQHwFW5B3P9gxyx57bQiXP0/ODLLyX8/UN4QA56F0uCMfoyrIu93LoDEqTbavxCLKDg==
X-Received: by 2002:a17:902:d705:b0:1bb:1523:b311 with SMTP id w5-20020a170902d70500b001bb1523b311mr8326641ply.41.1692789251390;
        Wed, 23 Aug 2023 04:14:11 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c24400b001bf10059251sm10611051plg.239.2023.08.23.04.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 04:14:10 -0700 (PDT)
Message-ID: <d9255749-bf1e-c498-ace6-048d36fa962f@gmail.com>
Date:   Wed, 23 Aug 2023 18:14:03 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, greg@greg.net.au
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Network File System <linux-nfs@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: kernel 6.4/6.5 nfs 4.1 unresponsive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> I have two Synology Disk station NAS devices with NFS mounts present on Gentoo servers with the following fstab mount configuration:
> 
> 10.200.1.247:/volume1/filer02-sata      /mnt/filer02-sata       nfs     vers=4.1,tcp,rsize=32768,wsize=32768,nolock,noatime,nodiratime,hard,timeo=60,retry=6,retrans=6,nconnect=4 0 0
> 10.200.1.247:/volume1/filer03-sata      /mnt/filer03-sata       nfs     vers=4.1,tcp,rsize=32768,wsize=32768,nolock,noatime,nodiratime,hard,timeo=60,retry=6,retrans=6,nconnect=4 0 0
> 10.200.1.246:/volume1/filer04-sata      /mnt/filer04-sata       nfs     vers=4.1,tcp,rsize=32768,wsize=32768,nolock,noatime,nodiratime,hard,timeo=60,retry=6,retrans=6,nconnect=4 0 0
> 
> 
> On Linux Kernel 6.3.6 these work perfectly fine.
> 
> As soon as I upgrade to 6.4 (tested 6.4.7 through 6.4.11) or 6.5-rc7 NFS mounts randomly hang and block system operation with high load times eventually resulting in a system freeze.
> 
> dmesg/syslog:
> 
> Aug 22 18:13:49 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:13:49 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:13:49 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:13:49 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:14:35 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:14:35 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:14:35 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:14:35 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:14:35 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:14:35 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:14:35 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:14:35 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:14:35 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:14:35 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:15:23 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:15:23 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:15:23 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:15:23 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:15:23 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:15:23 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:15:23 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:15:23 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:15:23 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:15:23 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:16:05 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:16:05 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:16:05 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:16:05 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:16:05 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:16:05 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:16:05 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:16:05 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:16:05 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:16:05 sjc-www2 kernel: nfs: server 10.200.1.247 not responding, still trying
> Aug 22 18:16:54 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:16:54 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:16:54 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:16:54 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:16:54 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:16:54 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:16:54 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:16:54 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:16:54 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> Aug 22 18:16:54 sjc-www2 kernel: nfs: server 10.200.1.247 OK
> 
> 
> The box in question i have been testing the kernel upgrades on has 1 x 10G NIC set with MTU 9000 for NFS volumes and i can successfully ping the nfs host with 9000 byte packets:
> 
> sjc-www2 ~ # ping -4 -s 9000 10.200.1.247
> PING 10.200.1.247 (10.200.1.247) 9000(9028) bytes of data.
> 9008 bytes from 10.200.1.247: icmp_seq=1 ttl=64 time=0.205 ms
> 9008 bytes from 10.200.1.247: icmp_seq=2 ttl=64 time=0.279 ms
> 9008 bytes from 10.200.1.247: icmp_seq=3 ttl=64 time=0.402 ms

See Bugzilla for the full thread.

Anyway, I'm adding this regression to be tracked by regzbot:

#regzbot introduced: v6.3..v6.4 https://bugzilla.kernel.org/show_bug.cgi?id=217815
#regzbot title: nfs server not responding loop on Synology NAS devices

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217815

-- 
An old man doll... just what I always wanted! - Clara
