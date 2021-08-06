Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491353E3037
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 22:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244760AbhHFUR6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 16:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhHFUR5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 16:17:57 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFEAC0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Aug 2021 13:17:41 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id a19so11238270qkg.2
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z3BnxvkkG90O7gZdRdAtc3HyRdlMscKwtpq+2Yj+S1g=;
        b=YNBdeAF9Ahc5954jmn3hg+LsQs+q+IZJVZOUqpg6Jc+CaltKTmuAFcBfnd5qK1VjFI
         gjV36MQseV8APGmwgG8wM0D4+q3102CkxgGctASVlal/idMszOmT5h5uIvom1/W6vVwI
         TImSFEnLvtJ7ayP7PFuxwUi/R+plyiLlEq1wxVnFvU82Pf8i2TgWqhu/Azr0URlVKEtq
         CFSGvI0/TMPSTRbW8o+74YJJAtQssYS+4vZK6HUOxCS8pwdyktkOyaVt7rviQvYpyK1o
         V9qlZ683DU0nRmf0N24OP0V2/KNBRFEUwAwsThOFhVxkCTXYln8MNd9gshiJtEjVhf56
         1bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Z3BnxvkkG90O7gZdRdAtc3HyRdlMscKwtpq+2Yj+S1g=;
        b=gUGA3rrUayLGsauAXCIK4ZZ2ADiEnlGRckhEzfaBRBEEKGa6x8nR9qkF2uW6r1W3mO
         tqgcHWRmCZfOPVphvqaV799y3ADrKjqwWQfNwQv3kyWbWF6/BHR3AlJ9lJIrGK7oKGCq
         zzElLL8rrMRVA+8ne3F2e40WxIl8bA0Aiq7l1qUuIaqESx6wxbDaYmZrZVmlYXjubyhf
         s8wZ4C52zzJHBKRk4+m+ASBW0rk+Cd5Dp5yqGA/c6csQt1643Fv4eBzyud15J0CfHBii
         0XePVy08f32V0qGCptbz3pqHfR05yQYa8/9/KFDIT9lWz+F907t/dW0CSGoe0NRzcasR
         ob0g==
X-Gm-Message-State: AOAM5320qSMbkdoegx9g8uxWykR61RoYq90zQX4sBRmt11YPn8jX86qF
        TMccJ8NFKgSQnhBEeINN9pymbAGahywnUA==
X-Google-Smtp-Source: ABdhPJyi2UsHWgNni4NZgki50ydZacPbfaWSiSuNZAHXC1KelbsfsKH/KVdz8nmUdYFlEN4EvqYapQ==
X-Received: by 2002:a37:46d0:: with SMTP id t199mr11718534qka.416.1628281060694;
        Fri, 06 Aug 2021 13:17:40 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g11sm3705720qtk.91.2021.08.06.13.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:17:40 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 0/9] Add a tool for using the new sysfs files
Date:   Fri,  6 Aug 2021 16:17:30 -0400
Message-Id: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
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
	nfs-sysfs.py rpc-client
 	nfs-sysfs.py xprt
 	nfs-sysfs.py xprt set
 	nfs-sysfs.py xprt-switch
 	nfs-sysfs.py xprt-switch set

So you can print out information about every xprt-switch with:
	anna@client ~ % nfs-sysfs xprt-switch
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
	anna@client ~ % nfs-sysfs xprt       
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
	anna@client ~ % sudo nfs-sysfs xprt --id 4 
	xprt 4: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
		Source: 192.168.111.222, port 726, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
	anna@client ~ % sudo nfs-sysfs xprt set --id 4 --dstaddr server2.nowheycreamery.com
	xprt 4: tcp, 192.168.111.186, port 2049, state <CONNECTED,BOUND>
		Source: 192.168.111.222, port 726, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0

Or for changing the dstaddr of all xprts attached to a switch:
	anna@client % ./nfs-sysfs.py xprt-switch --id 3
	switch 3: num_xprts 4, num_active 4, queue_len 0
		xprt 3: tcp, 192.168.111.188 [main]
		xprt 4: tcp, 192.168.111.188
		xprt 5: tcp, 192.168.111.188
		xprt 6: tcp, 192.168.111.188
	anna@client % sudo ./nfs-sysfs.py xprt-switch set --id 4 --dstaddr server2.nowheycreamery.vm
	switch 3: num_xprts 4, num_active 4, queue_len 0
		xprt 2: tcp, 192.168.111.186 [main]
		xprt 3: tcp, 192.168.111.186
		xprt 5: tcp, 192.168.111.186
		xprt 6: tcp, 192.168.111.186


What does everybody think? Is there any thing I should change about the
user input or output lines? How about other subcommands that should be
added with the initial submission?

Thanks,
Anna


Anna Schumaker (9):
  nfs-sysfs: Add an nfs-sysfs.py tool
  nfs-sysfs.py: Add a command for printing xprt switch information
  nfs-sysfs.py: Add a command for printing individual xprts
  nfs-sysfs.py: Add a command for printing rpc-client information
  nfs-sysfs.py: Add a command for changing xprt dstaddr
  nfs-sysfs.py: Add a command for changing xprt-switch dstaddrs
  nfs-sysfs.py: Add a command for changing xprt state
  nfs-sysfs: Add a man page
  nfs-sysfs: Add installation to the Makefile

 .gitignore                    |   2 +
 configure.ac                  |   1 +
 tools/Makefile.am             |   2 +-
 tools/nfs-sysfs/Makefile.am   |  20 +++++++
 tools/nfs-sysfs/client.py     |  27 +++++++++
 tools/nfs-sysfs/nfs-sysfs     |   5 ++
 tools/nfs-sysfs/nfs-sysfs.man |  88 +++++++++++++++++++++++++++++
 tools/nfs-sysfs/nfs-sysfs.py  |  23 ++++++++
 tools/nfs-sysfs/switch.py     |  51 +++++++++++++++++
 tools/nfs-sysfs/sysfs.py      |  28 ++++++++++
 tools/nfs-sysfs/xprt.py       | 101 ++++++++++++++++++++++++++++++++++
 11 files changed, 347 insertions(+), 1 deletion(-)
 create mode 100644 tools/nfs-sysfs/Makefile.am
 create mode 100644 tools/nfs-sysfs/client.py
 create mode 100644 tools/nfs-sysfs/nfs-sysfs
 create mode 100644 tools/nfs-sysfs/nfs-sysfs.man
 create mode 100755 tools/nfs-sysfs/nfs-sysfs.py
 create mode 100644 tools/nfs-sysfs/switch.py
 create mode 100644 tools/nfs-sysfs/sysfs.py
 create mode 100644 tools/nfs-sysfs/xprt.py

-- 
2.32.0

