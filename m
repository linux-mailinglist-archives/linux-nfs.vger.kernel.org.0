Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D7E3A678E
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jun 2021 15:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhFNNSx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Jun 2021 09:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232825AbhFNNSw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Jun 2021 09:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623676609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8X6wENh4cEp2w8OyJIrC6plbv9qsEVDy6lRe2s1HLyw=;
        b=i0WkLp/dbPh+z+So/Yyk0pUii1OQwsOa9b+VZZvuPY6JghxfjSewsz9OSxmtmVJo/8zV4j
        8Q0R0ZdP7llkKhDnnmBG78hIQ6YR5i47eUR8ssHDMEJKktDfdKCEqdS1WTWyPflAXF7CVu
        EGa0s6ZCNZeDnZnyUQuSBI1zU+Ar39E=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-OMJSzL9nO-mwLuVtboc6XQ-1; Mon, 14 Jun 2021 09:16:48 -0400
X-MC-Unique: OMJSzL9nO-mwLuVtboc6XQ-1
Received: by mail-qt1-f198.google.com with SMTP id 5-20020ac859450000b029024ba4a903ccso6939016qtz.6
        for <linux-nfs@vger.kernel.org>; Mon, 14 Jun 2021 06:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8X6wENh4cEp2w8OyJIrC6plbv9qsEVDy6lRe2s1HLyw=;
        b=AaNE7KIuZUT+Z7IsNRUG0pRtu/m7znyx3F19DrnN5h5Vz/duzNprAXvn5W35FgZUHz
         WiESdoATrrdPIx/FNm9mdMBeYQnLIVwYObdqESf/OAFRbVaJFEYClb9R4bo1n9HkXkb1
         iJRlz2bKEP3cw9t1l4ziHBU8amHN+t9mBMcok8j2nOs5N+1dNEXbw/asRvi8cekrakO4
         1yzScTp2utDgT/+u/NgcixXCmFLzdwopTFaVbUuorLCl8Kchzv7a0/jWkE90UUHGZj1Y
         N5LWt7ylFh40GOAy4r8gYM1dGknaYf7lfSfqV+xq3lRyqKmRpeCvkJswG20nC3Ts/vcE
         EmdQ==
X-Gm-Message-State: AOAM532IFNNi336J4HUv5QU+pQFEEIhCUxMlr/apHMR1qu9PsxyglSOu
        SYCxAXiJeVM8DcWopU75FB03s8c6wyeLmqGe/DU7gjPsLOsOr7p9fv0rbSK5/kr0OI6XWfB5H6G
        sNgMY/E2wRsDWMr/1R1vF
X-Received: by 2002:ac8:5d0a:: with SMTP id f10mr16988985qtx.250.1623676607943;
        Mon, 14 Jun 2021 06:16:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR1uGVta5+p2C9/vXEruLatMN6Eb7+HaXCxr4T1QsgtJuf6V5AndFAdoqSRtqVjpsaIoNW+A==
X-Received: by 2002:ac8:5d0a:: with SMTP id f10mr16988960qtx.250.1623676607684;
        Mon, 14 Jun 2021 06:16:47 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([71.161.93.112])
        by smtp.gmail.com with ESMTPSA id 7sm10173089qkb.86.2021.06.14.06.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 06:16:47 -0700 (PDT)
Subject: Re: [RFC PATCH 0/6] Add a tool for using the new sysfs files
To:     schumaker.anna@gmail.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
References: <20210608174657.603256-1-Anna.Schumaker@Netapp.com>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <5814a22e-d8d5-a811-4424-48e3b5cb88c5@redhat.com>
Date:   Mon, 14 Jun 2021 09:19:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210608174657.603256-1-Anna.Schumaker@Netapp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/8/21 1:46 PM, schumaker.anna@gmail.com wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> These patches implement a tool that can be used to read and write the
> sysfs files, with subcommands! They need Olga's most recent patches to
> run.
> 
> The following subcommands are implemented:
>    nfs-sysfs.py rpc-client
>    nfs-sysfs.py xprt
>    nfs-sysfs.py xprt set
>    nfs-sysfs.py xprt-switch
>    nfs-sysfs.py xprt-switch set
> 
> So you can print out information about every xprt-switch with:
> 	anna@client % ./nfs-sysfs.py xprt-switch
> 	switch 0: num_xprts 1, num_active 1, queue_len 0
> 		xprt 0: local, /var/run/gssproxy.sock
> 	switch 1: num_xprts 1, num_active 1, queue_len 0
> 		xprt 1: local, /var/run/rpcbind.sock
> 	switch 2: num_xprts 4, num_active 4, queue_len 0
> 		xprt 2: tcp, 192.168.111.188
> 		xprt 3: tcp, 192.168.111.188
> 		xprt 5: tcp, 192.168.111.188
> 		xprt 6: tcp, 192.168.111.188
> 	switch 3: num_xprts 1, num_active 1, queue_len 0
> 		xprt 7: tcp, 192.168.111.1
> 	switch 4: num_xprts 1, num_active 1, queue_len 0
> 		xprt 4: tcp, 192.168.111.188
> 
> And information about each xprt:
> 	anna@client % ./nfs-sysfs.py xprt
> 	xprt 0: local, /var/run/gssproxy.sock, state <CONNECTED,BOUND>, num_reqs 2
> 		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> 		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> 	xprt 1: local, /var/run/rpcbind.sock, state <CONNECTED,BOUND>, num_reqs 2
> 		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> 		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> 	xprt 2: tcp, 192.168.111.188, state <CONNECTED,BOUND>, num_reqs 2
> 		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> 		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> 	xprt 3: tcp, 192.168.111.188, state <CONNECTED,BOUND>, num_reqs 2
> 		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> 		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> 	xprt 4: tcp, 192.168.111.188, state <BOUND>, num_reqs 2
> 		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> 		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> 	xprt 5: tcp, 192.168.111.188, state <CONNECTED,BOUND>, num_reqs 2
> 		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> 		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> 	xprt 6: tcp, 192.168.111.188, state <CONNECTED,BOUND>, num_reqs 2
> 		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> 		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> 	xprt 7: tcp, 192.168.111.1, state <CONNECTED,BOUND>, num_reqs 2
> 		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> 		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> 
> You can use the `set` subcommand to change the dstaddr of individual xprts:
> 	anna@client % ./nfs-sysfs.py xprt --id 2
> 	xprt 2: tcp, 192.168.111.188, state <CONNECTED,BOUND>, num_reqs 2
> 		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> 		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> 	anna@client % sudo ./nfs-sysfs.py xprt set --id 2 --dstaddr server2.nowheycreamery.vm
> 	xprt 2: tcp, 192.168.111.186, state <CONNECTED,BOUND>, num_reqs 2
> 		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> 		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> 
> Or for changing the dstaddr of all xprts attached to a switch:
> 	anna@client % ./nfs-sysfs.py xprt-switch --id 2
> 	switch 2: num_xprts 4, num_active 4, queue_len 0
> 		xprt 2: tcp, 192.168.111.188
> 		xprt 3: tcp, 192.168.111.188
> 		xprt 5: tcp, 192.168.111.188
> 		xprt 6: tcp, 192.168.111.188
> 	anna@client % sudo ./nfs-sysfs.py xprt-switch set --id 2 --dstaddr server2.nowheycreamery.vm
> 	switch 2: num_xprts 4, num_active 4, queue_len 0
> 		xprt 2: tcp, 192.168.111.186
> 		xprt 3: tcp, 192.168.111.186
> 		xprt 5: tcp, 192.168.111.186
> 		xprt 6: tcp, 192.168.111.186
> 
> 
> I'm sure this needs lots of polish before it's ready for inclusion,
> along with needing a Makefile so it can be installed (I've just been
> running it out of the nfs-utils/tools/nfs-sysfs/ directory). But it's
> still a start, and I wanted to post it before going on New Baby Leave
> Part 2 (June 12 - July 11).
> 
> What does everybody think?
The first thing that popped in my was is where is the man page,
but this being a developers tool, maybe one is not needed?? (ala pynfs).
Although if its going to be installed from nfs-utils, it would
be nice to have a man page.

The second thing was I was thinking... it would be good if
we could run this command on a kernel dump... to see what was
going on when things crashed...

Nice work!

steved.

> Anna
> 
> 
> Anna Schumaker (6):
>    nfs-sysfs: Add an nfs-sysfs.py tool
>    nfs-sysfs.py: Add a command for printing xprt switch information
>    nfs-sysfs.py: Add a command for printing individual xprts
>    nfs-sysfs.py: Add a command for printing rpc-client information
>    nfs-sysfs.py: Add a command for changing xprt dstaddr
>    nfs-sysfs.py: Add a command for changing xprt-switch dstaddrs
> 
>   tools/nfs-sysfs/client.py    | 27 ++++++++++++++
>   tools/nfs-sysfs/nfs-sysfs.py | 23 ++++++++++++
>   tools/nfs-sysfs/switch.py    | 51 +++++++++++++++++++++++++++
>   tools/nfs-sysfs/sysfs.py     | 28 +++++++++++++++
>   tools/nfs-sysfs/xprt.py      | 68 ++++++++++++++++++++++++++++++++++++
>   5 files changed, 197 insertions(+)
>   create mode 100644 tools/nfs-sysfs/client.py
>   create mode 100755 tools/nfs-sysfs/nfs-sysfs.py
>   create mode 100644 tools/nfs-sysfs/switch.py
>   create mode 100644 tools/nfs-sysfs/sysfs.py
>   create mode 100644 tools/nfs-sysfs/xprt.py
> 

