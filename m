Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A974B77B7
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Feb 2022 21:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239427AbiBOTWH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Feb 2022 14:22:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbiBOTWG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Feb 2022 14:22:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A7A75E7C
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 11:21:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9267C61773
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 19:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEFEC340EB;
        Tue, 15 Feb 2022 19:21:51 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v8 0/9] Add a tool for using the new sysfs files
Date:   Tue, 15 Feb 2022 14:21:41 -0500
Message-Id: <20220215192150.53811-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

These patches implement a tool that can be used to read and write the
sysfs files, with subcommands!

The following subcommands are implemented:
	rpcctl client
	rpcctl client show
 	rpcctl switch
 	rpcctl switch set
 	rpcctl switch show
 	rpcctl xprt
 	rpcctl xprt remove
 	rpcctl xprt set
 	rpcctl xprt show

So you can print out information about every switch with:
	anna@client ~ % rpcctl switch
	switch-0: xprts 1, active 1, queue 0
		xprt-0: local, /var/run/gssproxy.sock [main]
	switch-1: xprts 1, active 1, queue 0
		xprt-1: local, /var/run/rpcbind.sock [main]
	switch-2: xprts 1, active 1, queue 0
		xprt-2: tcp, 192.168.111.1 [main]
	switch-3: xprts 4, active 4, queue 0
		xprt-3: tcp, 192.168.111.188 [main]
		xprt-4: tcp, 192.168.111.188
		xprt-5: tcp, 192.168.111.188
		xprt-6: tcp, 192.168.111.188

And information about each xprt:
	anna@client ~ % rpcctl xprt
	xprt-0: local, /var/run/gssproxy.sock, port 0, state <CONNECTED,BOUND>, main
		Source: (einval), port 0, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
	xprt-1: local, /var/run/rpcbind.sock, port 0, state <CONNECTED,BOUND>, main
		Source: (einval), port 0, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
	xprt-2: tcp, 192.168.111.1, port 2049, state <CONNECTED,BOUND>, main
		Source: 192.168.111.222, port 959, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
	xprt-3: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>, main
		Source: 192.168.111.222, port 921, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
	xprt-4: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
		Source: 192.168.111.222, port 726, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
	xprt-5: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
		Source: 192.168.111.222, port 671, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
	xprt-6: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
		Source: 192.168.111.222, port 934, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0

You can use the `set` subcommand to change the dstaddr of individual xprts:
	anna@client ~ % sudo rpcctl xprt show xprt-4 
	xprt-4: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
		Source: 192.168.111.222, port 726, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0

	anna@client ~ % sudo rpcctl xprt set xprt-4 dstaddr server2.nowheycreamery.com
	xprt-4: tcp, 192.168.111.186, port 2049, state <CONNECTED,BOUND>
		Source: 192.168.111.222, port 726, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0

Or for changing the dstaddr of all xprts attached to a switch:
	anna@client % rpcctl switch show switch-3
	switch-3: xprts 4, active 4, queue 0
		xprt 3: tcp, 192.168.111.188 [main]
		xprt 4: tcp, 192.168.111.188
		xprt 5: tcp, 192.168.111.188
		xprt 6: tcp, 192.168.111.188

	anna@client % sudo rpcctl switch set switch-3 dstaddr server2.nowheycreamery.vm
	switch-3: xprts 4, active 4, queue 0
		xprt 2: tcp, 192.168.111.186 [main]
		xprt 3: tcp, 192.168.111.186
		xprt 5: tcp, 192.168.111.186
		xprt 6: tcp, 192.168.111.186

Changes in v8:
- Improved exception handling when running commands
- Completely rework argument and command parsing to be more like ip-link
- Completely rewrite the man page to reflect the new argument scheme and
  add examples
- Only call socket.gethostbyname() once when changing the dstaddr of an
  RPC switch

Thoughts?
Anna


Anna Schumaker (9):
  rpcctl: Add a rpcctl.py tool
  rpcctl: Add a command for printing xprt switch information
  rpcctl: Add a command for printing individual xprts
  rpcctl: Add a command for printing rpc client information
  rpcctl: Add a command for changing xprt dstaddr
  rpcctl: Add a command for changing xprt switch dstaddrs
  rpcctl: Add a command for changing xprt state
  rpcctl: Add a man page
  rpcctl: Add installation to the Makefile

 configure.ac             |   1 +
 tools/Makefile.am        |   2 +-
 tools/rpcctl/Makefile.am |  13 ++
 tools/rpcctl/rpcctl.man  |  67 ++++++++++
 tools/rpcctl/rpcctl.py   | 255 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 337 insertions(+), 1 deletion(-)
 create mode 100644 tools/rpcctl/Makefile.am
 create mode 100644 tools/rpcctl/rpcctl.man
 create mode 100755 tools/rpcctl/rpcctl.py

-- 
2.35.1

