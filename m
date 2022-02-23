Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095DB4C190E
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 17:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbiBWQuF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 11:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243010AbiBWQuD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 11:50:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8EA34B86A
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 08:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645634969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dmp99w5IKxwKeM4n2GpLYymQGXm1caD0hvHACQfTXM0=;
        b=X0xYK7Sf9AtWCJG+Go9mFKOwEZpomVTR/e/ddeuKFAyNUgL2/obH3jZmPz9b4xbxnfPgtF
        P7EGcHAIdp24Hv/VGfi8LJF2zMtF4LHDW+Lv+BFcCJae3QXPTBdWjwjmRCnUs013QA00Hv
        I3dJT7R3TJyFdScWme/rjVAl18giANg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-VoOzbY69OR-9sd-cTAKhEA-1; Wed, 23 Feb 2022 11:49:28 -0500
X-MC-Unique: VoOzbY69OR-9sd-cTAKhEA-1
Received: by mail-qv1-f70.google.com with SMTP id jr12-20020a0562142a8c00b0042d7901650cso4273263qvb.17
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 08:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dmp99w5IKxwKeM4n2GpLYymQGXm1caD0hvHACQfTXM0=;
        b=q369BXAwpKQgdO1EunNSbArTUcfd2bEEelzmNnDhBxtKD7ZjF0+P20DFycyPxXM5OJ
         NrRlcfblZJNrOunEv0SSsmAWPt9CXLmOE9wEQVxAgTbI5zR4Kusijr3VTpqACZtFkKqm
         /ed50BMSDGuP+8ez3ozmYItUwFzwJhKRJTbgiO7ScZ6PPDMAyRgGYppD8/XzOf5H53+O
         lTqRPNBVEE6Ybe3sK9xnyOAaUfSQMLFXTZk/ZyNcsJLvpfA4LxVAudkMGNIdX9304H4x
         DZXmaziby5gJhCPsmP7qbMnfO55IbBn8AgVJMttBTdzIJUMWkvg/HPDNNJFq8vOKwjtZ
         wnwA==
X-Gm-Message-State: AOAM532qCHCBC3LNQz3X1SSFwAbohCww/5hS2zg7Jwi6z4ahNLs9pAl7
        OyTyUQxHuqbMXNByN7DGurPMVIGgsMoTduiMvZmXOorZBP2ziPxdR5QSUfMMCw7BgaQHhtvtlQ+
        X5zTkKiRdwwQ8qSs1cwc6
X-Received: by 2002:a37:a34b:0:b0:47d:8a95:3f83 with SMTP id m72-20020a37a34b000000b0047d8a953f83mr334851qke.467.1645634967736;
        Wed, 23 Feb 2022 08:49:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLKHKuf6eRrMkGlxNRRIkOpmR95Jaes5Uk8jJNA0nFpx7nRqvEqLet1BNLFvUrJRPuqJZz5Q==
X-Received: by 2002:a37:a34b:0:b0:47d:8a95:3f83 with SMTP id m72-20020a37a34b000000b0047d8a953f83mr334832qke.467.1645634967417;
        Wed, 23 Feb 2022 08:49:27 -0800 (PST)
Received: from [172.31.1.6] ([71.161.196.139])
        by smtp.gmail.com with ESMTPSA id x4sm41419qkh.42.2022.02.23.08.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 08:49:27 -0800 (PST)
Message-ID: <200905e2-cc9e-07ab-3718-1ec66bc679ae@redhat.com>
Date:   Wed, 23 Feb 2022 11:49:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8 0/9] Add a tool for using the new sysfs files
Content-Language: en-US
To:     Anna.Schumaker@Netapp.com, linux-nfs@vger.kernel.org
References: <20220215192150.53811-1-Anna.Schumaker@Netapp.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220215192150.53811-1-Anna.Schumaker@Netapp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/15/22 2:21 PM, Anna.Schumaker@Netapp.com wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> These patches implement a tool that can be used to read and write the
> sysfs files, with subcommands!
> 
> The following subcommands are implemented:
> 	rpcctl client
> 	rpcctl client show
>   	rpcctl switch
>   	rpcctl switch set
>   	rpcctl switch show
>   	rpcctl xprt
>   	rpcctl xprt remove
>   	rpcctl xprt set
>   	rpcctl xprt show
> 
> So you can print out information about every switch with:
> 	anna@client ~ % rpcctl switch
> 	switch-0: xprts 1, active 1, queue 0
> 		xprt-0: local, /var/run/gssproxy.sock [main]
> 	switch-1: xprts 1, active 1, queue 0
> 		xprt-1: local, /var/run/rpcbind.sock [main]
> 	switch-2: xprts 1, active 1, queue 0
> 		xprt-2: tcp, 192.168.111.1 [main]
> 	switch-3: xprts 4, active 4, queue 0
> 		xprt-3: tcp, 192.168.111.188 [main]
> 		xprt-4: tcp, 192.168.111.188
> 		xprt-5: tcp, 192.168.111.188
> 		xprt-6: tcp, 192.168.111.188
> 
> And information about each xprt:
> 	anna@client ~ % rpcctl xprt
> 	xprt-0: local, /var/run/gssproxy.sock, port 0, state <CONNECTED,BOUND>, main
> 		Source: (einval), port 0, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt-1: local, /var/run/rpcbind.sock, port 0, state <CONNECTED,BOUND>, main
> 		Source: (einval), port 0, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt-2: tcp, 192.168.111.1, port 2049, state <CONNECTED,BOUND>, main
> 		Source: 192.168.111.222, port 959, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt-3: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>, main
> 		Source: 192.168.111.222, port 921, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt-4: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 726, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt-5: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 671, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt-6: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 934, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 
> You can use the `set` subcommand to change the dstaddr of individual xprts:
> 	anna@client ~ % sudo rpcctl xprt show xprt-4
> 	xprt-4: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 726, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 
> 	anna@client ~ % sudo rpcctl xprt set xprt-4 dstaddr server2.nowheycreamery.com
> 	xprt-4: tcp, 192.168.111.186, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 726, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 
> Or for changing the dstaddr of all xprts attached to a switch:
> 	anna@client % rpcctl switch show switch-3
> 	switch-3: xprts 4, active 4, queue 0
> 		xprt 3: tcp, 192.168.111.188 [main]
> 		xprt 4: tcp, 192.168.111.188
> 		xprt 5: tcp, 192.168.111.188
> 		xprt 6: tcp, 192.168.111.188
> 
> 	anna@client % sudo rpcctl switch set switch-3 dstaddr server2.nowheycreamery.vm
> 	switch-3: xprts 4, active 4, queue 0
> 		xprt 2: tcp, 192.168.111.186 [main]
> 		xprt 3: tcp, 192.168.111.186
> 		xprt 5: tcp, 192.168.111.186
> 		xprt 6: tcp, 192.168.111.186
> 
> Changes in v8:
> - Improved exception handling when running commands
> - Completely rework argument and command parsing to be more like ip-link
> - Completely rewrite the man page to reflect the new argument scheme and
>    add examples
> - Only call socket.gethostbyname() once when changing the dstaddr of an
>    RPC switch
> 
> Thoughts?
> Anna
> 
> 
> Anna Schumaker (9):
>    rpcctl: Add a rpcctl.py tool
>    rpcctl: Add a command for printing xprt switch information
>    rpcctl: Add a command for printing individual xprts
>    rpcctl: Add a command for printing rpc client information
>    rpcctl: Add a command for changing xprt dstaddr
>    rpcctl: Add a command for changing xprt switch dstaddrs
>    rpcctl: Add a command for changing xprt state
>    rpcctl: Add a man page
>    rpcctl: Add installation to the Makefile
> 
>   configure.ac             |   1 +
>   tools/Makefile.am        |   2 +-
>   tools/rpcctl/Makefile.am |  13 ++
>   tools/rpcctl/rpcctl.man  |  67 ++++++++++
>   tools/rpcctl/rpcctl.py   | 255 +++++++++++++++++++++++++++++++++++++++
>   5 files changed, 337 insertions(+), 1 deletion(-)
>   create mode 100644 tools/rpcctl/Makefile.am
>   create mode 100644 tools/rpcctl/rpcctl.man
>   create mode 100755 tools/rpcctl/rpcctl.py
> 
Committed... (tag: nfs-utils-2-6-2-rc2)

steved.

