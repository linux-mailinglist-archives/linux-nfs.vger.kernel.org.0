Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96C149BBC8
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 20:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiAYTJv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 14:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiAYTJs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 14:09:48 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C32BC06173B
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:48 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 71so9722219qkf.4
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IlyQ8AebH2WvJfQvYG4R1fqftAYRe8FAjICoBwHVmw0=;
        b=QPU5nhKiTXj33Vr76sw7/H5HlA1b4jZb7Th3Rx95rbHW4hsYS7JSGfYwe8YDQ4BAa7
         tU573WaV03UeikkEEPhnZXDp63r3gDhzj/HB0MDZOBrqE77WY48TXlWWnym2OLa9/ZJt
         VIUGp9SMpuIrTq6pMLQLCZdSBDG5imgVM9LwAjA0Xdb/2aVyiuDWzQ/fsF3aHjQ52kQY
         YEdYhHXbXUS68ene979dk/GXn6+Gun4K0lhoGLEQqaF5EIYDLpVxyul6lCjIpHlnFwSM
         O0/i5deRs64WLE/kRrLptJ1wXjdBccj+QwR0thsdFyDk6QsMcEdxLOMKbFzOnekDJUxJ
         /kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=IlyQ8AebH2WvJfQvYG4R1fqftAYRe8FAjICoBwHVmw0=;
        b=hb9cBzl3GWWTmF12fTV20A5GQFrDo8qTOiAy650dwItNScIATJm7lPTS/gyLUHMzmi
         /n8OHZ0qqlnypYbMQm0zLKVNFBoqDO4TI5c18+aznOZIfq7q52GzZc6r4ATohi4CA3bi
         xWknVnG3YBc1GC71JhYxJY4nlO+UbDgm6pQdXDRvRkTiRWq7BS1o+HiWABJMKGuUgtk5
         4liVsHUIkTDKv5jbSOvdzFrxvOsXTao441XYNYGi0SfX8W7kdqIN2/JPK/N/3MP1hMtw
         7AGivBylGL3HZfRGiQ18xMoDAaGTykTKGqPJ570h8LUQZijgDbmq2IUleGKaYYlRZA7B
         YWLw==
X-Gm-Message-State: AOAM530UmfQl3HAn1bwAt8jWUC7ahDdyOD8MpnDYX4rIglzq4ph69nwB
        Pjvf/VsNP0OV8zDyo0/ri1dWZt/02h8=
X-Google-Smtp-Source: ABdhPJz/adBdhNReJaXRyuxQgdHJ/hqau77j99p99e1S2k4xHkRnJWBBCcqYuVhB9h6WehZPe4oNTA==
X-Received: by 2002:a05:620a:4049:: with SMTP id i9mr15787937qko.207.1643137787481;
        Tue, 25 Jan 2022 11:09:47 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id n6sm34802qtx.23.2022.01.25.11.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:09:47 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 0/9] Add a tool for using the new sysfs files
Date:   Tue, 25 Jan 2022 14:09:37 -0500
Message-Id: <20220125190946.23586-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.34.1
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

Changes in v6:
- Squashed everything into a single installable file similar to
  mountstats
- Fix up comparisons with xprt switches to use ID number instead of path

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
2.34.1

