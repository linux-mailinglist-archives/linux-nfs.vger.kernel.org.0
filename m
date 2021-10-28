Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DCD43E85C
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Oct 2021 20:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhJ1Shu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Oct 2021 14:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1Sht (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Oct 2021 14:37:49 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E9AC061570
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:22 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id br18so6818342qkb.1
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zyIISZ5CV1Hgj6FoilB3XVBwMRdsaZZ9Ep2ocTlzy8=;
        b=IvVNjAyAQUJw59cR/uTANf2aEvRrN3Qo/gP1si6Edi6sJYRp3OKimAtCRX0C6OQEap
         mfnvOTfY+7IKj0oXVjjDZ9XjzzhCNM7QyDr2GdUZaQFyXtENbGteZutGrnaBI5e3PlPP
         LH63SuczwINS6pnHCRylhV52Ks0Pg3zai6kJApxw3tBk9nl1v+iOSBJBL7WhVmk0xce+
         wNOjNkC3+uqFToOvnciL3cWWNEFn77xrY4OHwbmj7V57u+ARLWaShi73WwYhWguLlU9e
         gYWhdXZkWlHH2GZfI2ZBt7FjSSUun+pyjja0hxhIJlgNR6jQ8pcLc7seCUBkLtOPIUnj
         6tWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=7zyIISZ5CV1Hgj6FoilB3XVBwMRdsaZZ9Ep2ocTlzy8=;
        b=s6O1LpfWR8idCr6P83Xe2SjOdqWjDYY14C2gd/mhAmKtHHVZzOxgYqi02ZrcEDolop
         clCJx40YRapL1tvN1EL17uE+IBHzCE9qHc45MZF3PHKaGjAHVe4gju52M6iNvze7m1bu
         Qn5BtBcHv4ukmpxoRZBJxMr4lRInd9L51xBRCFc/LyfDj6/TKOXgxC8GFRsph8PL2TeA
         L++2uwxEDD4g/plA38cATZPI5opXtAp81N6G2dOXoSOcGQf6lP5nXa+f8XuTIhgQkTtL
         FdUFHPgSdwBS/x0BsYk8uKAjdzSBfOu7me4Jj2xgXiVXfO5kaOkgJ7M2c+ojLF2G1r8W
         X+ng==
X-Gm-Message-State: AOAM530okng/ybaN3BwLE5L5gUKMTjUTd+4W6/L0eenaMTiJ3r772h9m
        FL29v97RHKwTeaq8qMW1XE+Y5EpqM7w=
X-Google-Smtp-Source: ABdhPJxzn/KmibC+GK3zvhtjw6fAgjxVAQjPE1q12/cbzcyjSOvQcOdf6wxkabTTOV6T/Bt70UE4xg==
X-Received: by 2002:a05:620a:639:: with SMTP id 25mr5020099qkv.324.1635446121459;
        Thu, 28 Oct 2021 11:35:21 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id q13sm2556476qkl.7.2021.10.28.11.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:35:21 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 0/9]  Add a tool for using the new sysfs files
Date:   Thu, 28 Oct 2021 14:35:10 -0400
Message-Id: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
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

Changes in v5:
- Rename from 'rpcctl' to 'rpcctl'
- Rename subcommands 'xprt-switch" to 'switch' and 'rpc-client' to 'client'
- Clean up how the displayed strings are generated
- Handle kernels that don't yet have the srcaddr patch

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

 .gitignore               |   2 +
 configure.ac             |   1 +
 tools/Makefile.am        |   2 +-
 tools/rpcctl/Makefile.am |  20 ++++++++
 tools/rpcctl/client.py   |  27 +++++++++++
 tools/rpcctl/rpcctl      |   5 ++
 tools/rpcctl/rpcctl.man  |  88 ++++++++++++++++++++++++++++++++++
 tools/rpcctl/rpcctl.py   |  23 +++++++++
 tools/rpcctl/switch.py   |  51 ++++++++++++++++++++
 tools/rpcctl/sysfs.py    |  42 ++++++++++++++++
 tools/rpcctl/xprt.py     | 101 +++++++++++++++++++++++++++++++++++++++
 11 files changed, 361 insertions(+), 1 deletion(-)
 create mode 100644 tools/rpcctl/Makefile.am
 create mode 100644 tools/rpcctl/client.py
 create mode 100644 tools/rpcctl/rpcctl
 create mode 100644 tools/rpcctl/rpcctl.man
 create mode 100755 tools/rpcctl/rpcctl.py
 create mode 100644 tools/rpcctl/switch.py
 create mode 100644 tools/rpcctl/sysfs.py
 create mode 100644 tools/rpcctl/xprt.py

-- 
2.33.1

