Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B593E3B9B
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Aug 2021 18:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhHHQax (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Aug 2021 12:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230049AbhHHQaw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Aug 2021 12:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628440233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/pNP+80tdfIhNTsGuOQ2f0qSglRrT8gAniIipe+Wc8Q=;
        b=SKkihRenmKLoYSeX/7ji8lF4F1N3KLAiwFS4GAlUq9VaoCaiukwP+B4f+wBynQ008XNQ18
        JRmQkK7N48m5HnJR51eoPanmg+pAjSoY01ITk9pXrXOTyeHFA5Gnf/5uPKxobJyQlxyhKf
        ulxoopD5bEgDX49H6+v1defgriL4aMc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-6_y4LUZ1NBu_xOB8T80rjg-1; Sun, 08 Aug 2021 12:30:30 -0400
X-MC-Unique: 6_y4LUZ1NBu_xOB8T80rjg-1
Received: by mail-qk1-f198.google.com with SMTP id x12-20020a05620a14acb02903b8f9d28c19so10351679qkj.23
        for <linux-nfs@vger.kernel.org>; Sun, 08 Aug 2021 09:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/pNP+80tdfIhNTsGuOQ2f0qSglRrT8gAniIipe+Wc8Q=;
        b=nqRW9OhMxWd6h8C9SUV17QaJ4B5g7cAUj5AkPTTN2IijPbkJpm7cm7A/1zM6z/Qcld
         cG5nuAfcQUkP/cjblrkGhphl5CRQNZvfPMefP6nJClI1C/3Jmvj8ep2S8VGhsP/z2XoB
         IypymMbxJ3AL1IVBORdYQukFoK/Mkt17UXoOkzZtL6aYD+iKumaB0mk1X6zvG7O8fAz2
         NFo+e5mu1reyYO1z2FqKnQlilZavLV/imL8iHJ5Dq6coIXblRe4xgykNulBtYYGvkj3E
         uwep7Cz1APzs0ZiyRSF/nxhrEGGqIinf3dsoQYwdziyAig7e54dpDN5MNiEkzqd2tCxO
         mwPA==
X-Gm-Message-State: AOAM532KtJTzAkWFdIRVV0B+vIYqzSeMCJBtI/22qNAvj+CThUCAUbwl
        e1nN8iMx2Lmx1EGbi6jcJkLFAwaEDZJiW8ANgy6Fb8HMr+Qbcm/vo48798niROkZWNE48gsYLe0
        bG+iBDw5wzz841fHH0ndW
X-Received: by 2002:a05:620a:2f8:: with SMTP id a24mr255191qko.360.1628440230366;
        Sun, 08 Aug 2021 09:30:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxB2VOqIOuyyKHS9Oh4nifdQbsqbNE5QWmQFbKnoFgmPCI4ASyjoyJrjm6GP8g5hN9117vEzA==
X-Received: by 2002:a05:620a:2f8:: with SMTP id a24mr255175qko.360.1628440230177;
        Sun, 08 Aug 2021 09:30:30 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([70.109.164.82])
        by smtp.gmail.com with ESMTPSA id z9sm6098758qtn.54.2021.08.08.09.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 09:30:29 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] Add a tool for using the new sysfs files
To:     schumaker.anna@gmail.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
References: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <50f2d601-70ce-81ec-11f1-1bdc5ae526c6@redhat.com>
Date:   Sun, 8 Aug 2021 12:30:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey Anna,

On 8/6/21 4:17 PM, schumaker.anna@gmail.com wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> These patches implement a tool that can be used to read and write the
> sysfs files, with subcommands! They do need my extra patches to add in
> srcaddr and dst_port to the xprt_info file. Let me know if I need to
> resend adding support for kernels both with and without these patches.
> 
> The following subcommands are implemented:
> 	nfs-sysfs.py rpc-client
>   	nfs-sysfs.py xprt
>   	nfs-sysfs.py xprt set
>   	nfs-sysfs.py xprt-switch
>   	nfs-sysfs.py xprt-switch set
> 
> So you can print out information about every xprt-switch with:
> 	anna@client ~ % nfs-sysfs xprt-switch
> 	switch 0: num_xprts 1, num_active 1, queue_len 0
> 		xprt 0: local, /var/run/gssproxy.sock [main]
> 	switch 1: num_xprts 1, num_active 1, queue_len 0
> 		xprt 1: local, /var/run/rpcbind.sock [main]
> 	switch 2: num_xprts 1, num_active 1, queue_len 0
> 		xprt 2: tcp, 192.168.111.1 [main]
> 	switch 3: num_xprts 4, num_active 4, queue_len 0
> 		xprt 3: tcp, 192.168.111.188 [main]
> 		xprt 4: tcp, 192.168.111.188
> 		xprt 5: tcp, 192.168.111.188
> 		xprt 6: tcp, 192.168.111.188
> 
> And information about each xprt:
> 	anna@client ~ % nfs-sysfs xprt
> 	xprt 0: local, /var/run/gssproxy.sock, port 0, state <MAIN,CONNECTED,BOUND>
> 		Source: (einval), port 0, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt 1: local, /var/run/rpcbind.sock, port 0, state <MAIN,CONNECTED,BOUND>
> 		Source: (einval), port 0, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt 2: tcp, 192.168.111.1, port 2049, state <MAIN,CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 959, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt 3: tcp, 192.168.111.188, port 2049, state <MAIN,CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 921, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt 4: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 726, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt 5: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 671, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt 6: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 934, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 
> You can use the `set` subcommand to change the dstaddr of individual xprts:
> 	anna@client ~ % sudo nfs-sysfs xprt --id 4
> 	xprt 4: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 726, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	anna@client ~ % sudo nfs-sysfs xprt set --id 4 --dstaddr server2.nowheycreamery.com
> 	xprt 4: tcp, 192.168.111.186, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 726, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 
> Or for changing the dstaddr of all xprts attached to a switch:
> 	anna@client % ./nfs-sysfs.py xprt-switch --id 3
> 	switch 3: num_xprts 4, num_active 4, queue_len 0
> 		xprt 3: tcp, 192.168.111.188 [main]
> 		xprt 4: tcp, 192.168.111.188
> 		xprt 5: tcp, 192.168.111.188
> 		xprt 6: tcp, 192.168.111.188
> 	anna@client % sudo ./nfs-sysfs.py xprt-switch set --id 4 --dstaddr server2.nowheycreamery.vm
> 	switch 3: num_xprts 4, num_active 4, queue_len 0
> 		xprt 2: tcp, 192.168.111.186 [main]
> 		xprt 3: tcp, 192.168.111.186
> 		xprt 5: tcp, 192.168.111.186
> 		xprt 6: tcp, 192.168.111.186
> 
> 
> What does everybody think? Is there any thing I should change about the
> user input or output lines? How about other subcommands that should be
> added with the initial submission?
I have not play around with this new tool.. but I will! Looking
forward to it... But... and I should have mention this in v1
my apologies.

The rest of the NFS tools do not have have "nfs-" as the
prefix only an "nfs"... As with nfs-iostat, I'll me more that
will to take the patch with the '-' char, but I would
prefer the  man page and the installed script be call nfssysfs,
just to say with the current naming conventions.

steved.

> 
> Thanks,
> Anna
> 
> 
> Anna Schumaker (9):
>    nfs-sysfs: Add an nfs-sysfs.py tool
>    nfs-sysfs.py: Add a command for printing xprt switch information
>    nfs-sysfs.py: Add a command for printing individual xprts
>    nfs-sysfs.py: Add a command for printing rpc-client information
>    nfs-sysfs.py: Add a command for changing xprt dstaddr
>    nfs-sysfs.py: Add a command for changing xprt-switch dstaddrs
>    nfs-sysfs.py: Add a command for changing xprt state
>    nfs-sysfs: Add a man page
>    nfs-sysfs: Add installation to the Makefile
> 
>   .gitignore                    |   2 +
>   configure.ac                  |   1 +
>   tools/Makefile.am             |   2 +-
>   tools/nfs-sysfs/Makefile.am   |  20 +++++++
>   tools/nfs-sysfs/client.py     |  27 +++++++++
>   tools/nfs-sysfs/nfs-sysfs     |   5 ++
>   tools/nfs-sysfs/nfs-sysfs.man |  88 +++++++++++++++++++++++++++++
>   tools/nfs-sysfs/nfs-sysfs.py  |  23 ++++++++
>   tools/nfs-sysfs/switch.py     |  51 +++++++++++++++++
>   tools/nfs-sysfs/sysfs.py      |  28 ++++++++++
>   tools/nfs-sysfs/xprt.py       | 101 ++++++++++++++++++++++++++++++++++
>   11 files changed, 347 insertions(+), 1 deletion(-)
>   create mode 100644 tools/nfs-sysfs/Makefile.am
>   create mode 100644 tools/nfs-sysfs/client.py
>   create mode 100644 tools/nfs-sysfs/nfs-sysfs
>   create mode 100644 tools/nfs-sysfs/nfs-sysfs.man
>   create mode 100755 tools/nfs-sysfs/nfs-sysfs.py
>   create mode 100644 tools/nfs-sysfs/switch.py
>   create mode 100644 tools/nfs-sysfs/sysfs.py
>   create mode 100644 tools/nfs-sysfs/xprt.py
> 

