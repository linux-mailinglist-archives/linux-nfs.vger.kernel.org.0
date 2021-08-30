Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091613FB979
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 17:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbhH3P6A (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 11:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237629AbhH3P5u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 11:57:50 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2482EC061575
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:56:56 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id g11so8581569qvd.2
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dk5BetLebNnEqSw14yGsvT2Uuhrbzwh3AKCWUAFJ8yk=;
        b=DtkvuRwss0ixo5+g7SM2lo03SgvDSpU8Q34KWArIPl17O0tuDJ+HdRbpxvV5fC6t8V
         bgh1o1lL6ksOhYtiFCjS7LEy0AdK4koN0yEtZjt9hum9JRgC4M0L2i5cuze4m1U0jDMc
         uiThTZDu1/wQuAPKpscaFRiSir2/inEadb7JwyUVD3c5AudtUoAsSOu11yZSSKnv0L15
         vsXNdSm/mSZaN36UFm5OymlBupMq2HFdRZBSggTj0FOHZPNCLjGht1lNnWk5g8tLG/l2
         I5y5wu4l5T4eQuMHnIery/D4Ixoxwfu++Z6WegODOjwMcWzcv1WJ3GzgZqQq69It0Qw6
         29cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=dk5BetLebNnEqSw14yGsvT2Uuhrbzwh3AKCWUAFJ8yk=;
        b=qJhvwdJRIVdyGt9EndLJbBa/sYxQnnnU5cODZ2ae5lkuJrE36m2DnmZu40xgxmOud9
         GrtLVgL3sfUFKhlxFyfzJJD/qyivj0ZYkRItJG2ysQa/whY29CLz5JJGy27VNqIbzHGN
         WB0CF6JIQzltZgFgVWFofTI3ySRGhi/GoWcPIF6OP1B7HYgl0H4WE1dwmZxAHUMxH6pq
         +yIoH3gT1OgAHqj0R+R5boiSSxXtM70yQaEZVkFhWdAVVQ+6bs8eYwezt7vRYNDwn/Qd
         PPoVRMii0YnN7Em5T+Bxbkmz/g8ZkbZwbOUoDX9uNzYLnktqo85H1PgTFtE2P6xQRTVF
         1l7w==
X-Gm-Message-State: AOAM5301nv5kJazpecE0CGG4K6U0YOsbOtfeQbhXfTpNASvNWMgcL5+c
        T7gyxCYKuQwLC2fEsm0+EfU=
X-Google-Smtp-Source: ABdhPJzNsUa/3pvC/+3MjK26lOBf2BWqrrkfO6ujPgm6bRBL1QinMYoP6/xUwarzgd38NdFdOKt4xQ==
X-Received: by 2002:a0c:e910:: with SMTP id a16mr24122169qvo.37.1630339015106;
        Mon, 30 Aug 2021 08:56:55 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id 12sm8585217qtt.16.2021.08.30.08.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 08:56:54 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 0/9] Add a tool for using the new sysfs files
Date:   Mon, 30 Aug 2021 11:56:44 -0400
Message-Id: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

These patches implement a tool that can be used to read and write the
sysfs files, with subcommands! They do need my extra patches to add in
srcaddr and dst_port to the xprt_info file. Let me know if I need to
resend adding support for kernels both with and without these patches.

The following subcommands are implemented:
	nfssysfs.py rpc-client
 	nfssysfs.py xprt
 	nfssysfs.py xprt set
 	nfssysfs.py xprt-switch
 	nfssysfs.py xprt-switch set

So you can print out information about every xprt-switch with:
	anna@client ~ % nfssysfs xprt-switch
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
	anna@client ~ % nfssysfs xprt       
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
	anna@client ~ % sudo nfssysfs xprt --id 4 
	xprt 4: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
		Source: 192.168.111.222, port 726, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
	anna@client ~ % sudo nfssysfs xprt set --id 4 --dstaddr server2.nowheycreamery.com
	xprt 4: tcp, 192.168.111.186, port 2049, state <CONNECTED,BOUND>
		Source: 192.168.111.222, port 726, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0

Or for changing the dstaddr of all xprts attached to a switch:
	anna@client % ./nfssysfs.py xprt-switch --id 3
	switch 3: num_xprts 4, num_active 4, queue_len 0
		xprt 3: tcp, 192.168.111.188 [main]
		xprt 4: tcp, 192.168.111.188
		xprt 5: tcp, 192.168.111.188
		xprt 6: tcp, 192.168.111.188
	anna@client % sudo ./nfssysfs.py xprt-switch set --id 4 --dstaddr server2.nowheycreamery.vm
	switch 3: num_xprts 4, num_active 4, queue_len 0
		xprt 2: tcp, 192.168.111.186 [main]
		xprt 3: tcp, 192.168.111.186
		xprt 5: tcp, 192.168.111.186
		xprt 6: tcp, 192.168.111.186


One question I have is about the name right now. Is naming it "nfssysfs"
okay, or would it be better to name it "nfs" with "sysfs" as a
subcommand? Going with just "nfs" as the command name would allow us to
add other non-sysfs tools as subcommands in the future (such as `nfs stat`
to call `nfsstat`, or for new commands that would otherwise be prefixed
with "nfs")

Thoughts?
Anna


Anna Schumaker (9):
  nfssysfs: Add a nfssysfs.py tool
  nfssysfs.py: Add a command for printing xprt switch information
  nfssysfs.py: Add a command for printing individual xprts
  nfssysfs.py: Add a command for printing rpc-client information
  nfssysfs.py: Add a command for changing xprt dstaddr
  nfssysfs.py: Add a command for changing xprt-switch dstaddrs
  nfssysfs.py: Add a command for changing xprt state
  nfssysfs: Add a man page
  nfssysfs: Add installation to the Makefile

 .gitignore                  |   2 +
 configure.ac                |   1 +
 tools/Makefile.am           |   2 +-
 tools/nfssysfs/Makefile.am  |  20 +++++++
 tools/nfssysfs/client.py    |  27 ++++++++++
 tools/nfssysfs/nfssysfs     |   5 ++
 tools/nfssysfs/nfssysfs.man |  88 +++++++++++++++++++++++++++++++
 tools/nfssysfs/nfssysfs.py  |  23 ++++++++
 tools/nfssysfs/switch.py    |  51 ++++++++++++++++++
 tools/nfssysfs/sysfs.py     |  29 +++++++++++
 tools/nfssysfs/xprt.py      | 101 ++++++++++++++++++++++++++++++++++++
 11 files changed, 348 insertions(+), 1 deletion(-)
 create mode 100644 tools/nfssysfs/Makefile.am
 create mode 100644 tools/nfssysfs/client.py
 create mode 100644 tools/nfssysfs/nfssysfs
 create mode 100644 tools/nfssysfs/nfssysfs.man
 create mode 100755 tools/nfssysfs/nfssysfs.py
 create mode 100644 tools/nfssysfs/switch.py
 create mode 100644 tools/nfssysfs/sysfs.py
 create mode 100644 tools/nfssysfs/xprt.py

-- 
2.33.0

