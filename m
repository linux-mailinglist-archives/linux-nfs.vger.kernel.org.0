Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B4A49EB50
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 20:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbiA0Tt4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 14:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiA0Ttz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 14:49:55 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10745C061714
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:49:55 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id hu2so3811072qvb.8
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3e8h6kKbAzstWQQgLI0QPxCAZT5om4JOr3OSWjN3bUk=;
        b=JRCF7TWhZTW/JUGUfSZbJgoXK++JD1TpqI53h9gPjYUCseSe1R0kufsSFeA+3K8KJ7
         2vTSWE89nJdoJIm/LiluOp+m0Ts2EJJRdUjsHlPmVopjPAHYMSW56Uh1hY21uzKK9j/R
         hd9TmIges8710T9Rvq2OT0rsuHCGq80WQbuO1jdtNzdh2Zkr+ugGMB9rq2CJ4V8Fhl+w
         qLcwq9xeLIFTWIXD1OOd57WTtPslzvacFiP2jCYziqx/kInUabLHHSwsfdSMB4IvvzZQ
         114wt8fyjglveplV/3iOn1dYjRv8NXXT7o+BEhTp/CXe45ltrBNEmlIIDZqbMl1dCx4o
         BpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=3e8h6kKbAzstWQQgLI0QPxCAZT5om4JOr3OSWjN3bUk=;
        b=7TAWe64oUdWdmNW1aP709zlRN3PJ9D2D01yqYF1F/CjpCFHNaLHV6SXtESOm3LIQS1
         3bxTDhR1jXoAw+aK+R2LGdGNa6n4AxXYL899Z0nINQybqyb557dVUMqUKSZp+ofKrim9
         PI9fnOnVLZG4WkwEQ+Zhpb9+8SK0QFlXj94PNF8jWc+aNK4h52WeDH/ArZFtf8dBUUud
         eq4zoBIDrdf0U8/PdN5szcYl8FP0auLvXa3jMNXdnq9E/sN7V4IKpnTJWUDXeqgb2xq9
         k4euenyL11Te7p60fsO0icjwz2OMTd3YT61+yq23cbC9lkXVq36je9rdNqBcMYovF0Ee
         uvGg==
X-Gm-Message-State: AOAM530mL9l7iWEo9+2PjXRymXU2UUaSoRTdcnvbeR60DmX0zrL18RoJ
        CXrAYYRAq08aRarR7H5lpAI=
X-Google-Smtp-Source: ABdhPJyrzjM4ozas4DPNFpGJKvEtcfzgAfiQ3K0uCooZ7rP6ou1IXZD6DJi44JejfsNDd0+yMW/Tow==
X-Received: by 2002:a05:6214:20e7:: with SMTP id 7mr5125284qvk.48.1643312994067;
        Thu, 27 Jan 2022 11:49:54 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g7sm1836483qkc.104.2022.01.27.11.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:49:53 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v7 0/9] Add a tool for using the new sysfs files
Date:   Thu, 27 Jan 2022 14:49:43 -0500
Message-Id: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

These patches implement a tool that can be used to read and write the
sysfs files, with subcommands!

The following subcommands are implemented:
	rpcctl client
 	rpcctl switch
 	rpcctl switch set
 	rpcctl xprt
 	rpcctl xprt set

So you can print out information about every switch with:
	anna@client ~ % rpcctl switch
	switch 0: xprts 1, active 1, queue 0
		xprt 0: local, /var/run/gssproxy.sock [main]
	switch 1: xprts 1, active 1, queue 0
		xprt 1: local, /var/run/rpcbind.sock [main]
	switch 2: xprts 1, active 1, queue 0
		xprt 2: tcp, 192.168.111.1 [main]
	switch 3: xprts 4, active 4, queue 0
		xprt 3: tcp, 192.168.111.188 [main]
		xprt 4: tcp, 192.168.111.188
		xprt 5: tcp, 192.168.111.188
		xprt 6: tcp, 192.168.111.188

And information about each xprt:
	anna@client ~ % rpcctl xprt
	xprt 0: local, /var/run/gssproxy.sock, port 0, state <CONNECTED,BOUND>, main
		Source: (einval), port 0, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
	xprt 1: local, /var/run/rpcbind.sock, port 0, state <CONNECTED,BOUND>, main
		Source: (einval), port 0, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
	xprt 2: tcp, 192.168.111.1, port 2049, state <CONNECTED,BOUND>, main
		Source: 192.168.111.222, port 959, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
	xprt 3: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>, main
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
	anna@client ~ % sudo rpcctl xprt --id 4 
	xprt 4: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
		Source: 192.168.111.222, port 726, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
	anna@client ~ % sudo rpcctl xprt set --id 4 --dstaddr server2.nowheycreamery.com
	xprt 4: tcp, 192.168.111.186, port 2049, state <CONNECTED,BOUND>
		Source: 192.168.111.222, port 726, Requests: 2
		Congestion: cur 0, win 256, Slots: min 2, max 65536
		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0

Or for changing the dstaddr of all xprts attached to a switch:
	anna@client % rpcctl switch --id 3
	switch 3: xprts 4, active 4, queue 0
		xprt 3: tcp, 192.168.111.188 [main]
		xprt 4: tcp, 192.168.111.188
		xprt 5: tcp, 192.168.111.188
		xprt 6: tcp, 192.168.111.188
	anna@client % sudo rpcctl switch set --id 4 --dstaddr server2.nowheycreamery.vm
	switch 3: xprts 4, active 4, queue 0
		xprt 2: tcp, 192.168.111.186 [main]
		xprt 3: tcp, 192.168.111.186
		xprt 5: tcp, 192.168.111.186
		xprt 6: tcp, 192.168.111.186

Changes in v7:
- Fix up detecting if sysfs is mounted

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
 tools/rpcctl/Makefile.am |  13 +++
 tools/rpcctl/rpcctl.man  |  88 +++++++++++++++
 tools/rpcctl/rpcctl.py   | 230 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 333 insertions(+), 1 deletion(-)
 create mode 100644 tools/rpcctl/Makefile.am
 create mode 100644 tools/rpcctl/rpcctl.man
 create mode 100755 tools/rpcctl/rpcctl.py

-- 
2.35.0

