Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59390437FAA
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 22:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbhJVU61 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 16:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbhJVU61 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 16:58:27 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEC0C061764
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:09 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id k19so3213223qvm.13
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PkXEdosU6r7qdPe09Kh0445LIJWLPsjiwVCOAChoCeE=;
        b=GBBsSz3jllqg1GtrABOmMKlkyRTT/c98pxP1rQAeXvi39HtNl2HbAamojHDN3LYe/E
         bAFQe6N7DZ6a621WW3SBTaEzwoboJRL1ZLK4I8ln0AZ0mj+DyD3HXtDacw9zczf4wXpw
         MnJYGuN+tnOS5nZxoQGtT780FnLlOg2PXlpHfBltkltVjE49YpNyu8PQSljNRFjLbGxa
         OwEMylMh0VUFkYvnoMUcdy4XKWKKD7TXoiDrQWNk8ZR7C/x9hpSKlMU674+qLV+kCdX1
         WwwzgE4zWtDAdGBFcNtqFMzr26rOQVWH+QSg0rRvl/B5bkdCp3d6w7QqKsdGn1+7eUSz
         GaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=PkXEdosU6r7qdPe09Kh0445LIJWLPsjiwVCOAChoCeE=;
        b=QawE/YtrHScT3iF4k2OUVi31oyCIXpGl+F43k4yIfuOxgK/2dsAImChR9HCn2NGmrr
         2sX7B4YB0c+g1olIk1j5n9r3hwCSjIqzs/YVMOexKSHgG882gevWB11DMU0hnKKKrpcX
         Ayv4km0utnxSD45FedacJOUktZx/1v4meIO/FGHDXL/gImi2tcQi5j9pz59OsDvEoWQj
         Xu841XiEKhDWTxb+U/ShVdCTY0t/jpB9OkUREzLjYWqZzLCtlxjJkYYLjc54DXZB4243
         ml1vw6cTdj39wAwJ5b98JGmbETB7I06IzX2cu67XelK/D0EPEG9/LUHdXWNixpA559pT
         dRKQ==
X-Gm-Message-State: AOAM5323laU73BkiOb4O5ABbvPq+FKeGB64NwVQfn9xTTQJOkscMQWk9
        3JIe1Q2hLPEsV33DtZ53ptA=
X-Google-Smtp-Source: ABdhPJx6+6BfTBoYMnv/Gy2+yBQuniBR9Vl+jnlXqjxB1XnBhXnDr8jRmL+S+4Vu5vVpG0MfS5mqsg==
X-Received: by 2002:a0c:aac2:: with SMTP id g2mr1918540qvb.41.1634936167962;
        Fri, 22 Oct 2021 13:56:07 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id p9sm4576279qki.51.2021.10.22.13.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 13:56:07 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 0/9] Add a tool for using the new sysfs files
Date:   Fri, 22 Oct 2021 16:55:57 -0400
Message-Id: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

These patches implement a tool that can be used to read and write the
sysfs files, with subcommands!

The following subcommands are implemented:
	rpcsys rpc-client
 	rpcsys xprt
 	rpcsys xprt set
 	rpcsys xprt-switch
 	rpcsys xprt-switch set

So you can print out information about every xprt-switch with:
	anna@client ~ % rpcsys xprt-switch
	switch 0: num_xprts 1, num_active 1, queue_len 0
		xprt 0: local, /var/run/gssproxy.sock [main]
	switch 1: num_xprts 1, num_active 1, queue_len 0
		xprt 1: local, /var/run/rpcbind.sock [main]
	switch 2: num_xprts 1, num_active 1, queue_len 0
		xprt 2: tcp, 192.168.111.1 [main]
	switch 3: num_xprts 4, num_active 4, queue_len 0
		xprt 3: tcp, 192.168.111.188 [main]
		xprt 4: tcp, 192.168.111.188
		xprt 5: tcp, 192.168.111.188
		xprt 6: tcp, 192.168.111.188

And information about each xprt:
	anna@client ~ % rpcsys xprt
	xprt 0: local, /var/run/gssproxy.sock, port 0, state <MAIN,CONNECTED,BOUND>
		Source: (einval), port 0, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
	xprt 1: local, /var/run/rpcbind.sock, port 0, state <MAIN,CONNECTED,BOUND>
		Source: (einval), port 0, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
	xprt 2: tcp, 192.168.111.1, port 2049, state <MAIN,CONNECTED,BOUND>
		Source: 192.168.111.222, port 959, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
	xprt 3: tcp, 192.168.111.188, port 2049, state <MAIN,CONNECTED,BOUND>
		Source: 192.168.111.222, port 921, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
	xprt 4: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
		Source: 192.168.111.222, port 726, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
	xprt 5: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
		Source: 192.168.111.222, port 671, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
	xprt 6: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
		Source: 192.168.111.222, port 934, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0

You can use the `set` subcommand to change the dstaddr of individual xprts:
	anna@client ~ % sudo rpcsys xprt --id 4 
	xprt 4: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
		Source: 192.168.111.222, port 726, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
	anna@client ~ % sudo rpcsys xprt set --id 4 --dstaddr server2.nowheycreamery.com
	xprt 4: tcp, 192.168.111.186, port 2049, state <CONNECTED,BOUND>
		Source: 192.168.111.222, port 726, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0

Or for changing the dstaddr of all xprts attached to a switch:
	anna@client % rpcsys xprt-switch --id 3
	switch 3: num_xprts 4, num_active 4, queue_len 0
		xprt 3: tcp, 192.168.111.188 [main]
		xprt 4: tcp, 192.168.111.188
		xprt 5: tcp, 192.168.111.188
		xprt 6: tcp, 192.168.111.188
	anna@client % sudo rpcsys xprt-switch set --id 4 --dstaddr server2.nowheycreamery.vm
	switch 3: num_xprts 4, num_active 4, queue_len 0
		xprt 2: tcp, 192.168.111.186 [main]
		xprt 3: tcp, 192.168.111.186
		xprt 5: tcp, 192.168.111.186
		xprt 6: tcp, 192.168.111.186


I renamed the tool to "rpcsys" after the discussion at the bakeathon. I
think this is at least a better name, but if anybody has other ideas
please let me know!

Thoughts?
Anna

Anna Schumaker (9):
  rpcsys: Add a rpcsys.py tool
  rpcsys: Add a command for printing xprt switch information
  rpcsys: Add a command for printing individual xprts
  rpcsys: Add a command for printing rpc-client information
  rpcsys: Add a command for changing xprt dstaddr
  rpcsys: Add a command for changing xprt-switch dstaddrs
  rpcsys: Add a command for changing xprt state
  rpcsys: Add a man page
  rpcsys: Add installation to the Makefile

 .gitignore               |   2 +
 configure.ac             |   1 +
 tools/Makefile.am        |   2 +-
 tools/rpcsys/Makefile.am |  20 ++++++++
 tools/rpcsys/client.py   |  27 +++++++++++
 tools/rpcsys/rpcsys      |   5 ++
 tools/rpcsys/rpcsys.man  |  88 ++++++++++++++++++++++++++++++++++
 tools/rpcsys/rpcsys.py   |  23 +++++++++
 tools/rpcsys/switch.py   |  51 ++++++++++++++++++++
 tools/rpcsys/sysfs.py    |  29 +++++++++++
 tools/rpcsys/xprt.py     | 101 +++++++++++++++++++++++++++++++++++++++
 11 files changed, 348 insertions(+), 1 deletion(-)
 create mode 100644 tools/rpcsys/Makefile.am
 create mode 100644 tools/rpcsys/client.py
 create mode 100644 tools/rpcsys/rpcsys
 create mode 100644 tools/rpcsys/rpcsys.man
 create mode 100755 tools/rpcsys/rpcsys.py
 create mode 100644 tools/rpcsys/switch.py
 create mode 100644 tools/rpcsys/sysfs.py
 create mode 100644 tools/rpcsys/xprt.py

-- 
2.33.1

