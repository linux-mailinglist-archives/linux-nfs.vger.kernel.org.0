Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31C439FE1B
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 19:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbhFHRtx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 13:49:53 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:34415 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbhFHRtw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 13:49:52 -0400
Received: by mail-qk1-f182.google.com with SMTP id k11so19400164qkk.1
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 10:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y5PH1kHYVukczRtGwzpchLXB+yyOyEkDWOUj/XoULME=;
        b=BczJTHkD3+yZ6uQT/jkFGUNN8iua3TVu/R9WtoBTtDcylZHJ7D1OXPW/TUU+SQwDql
         Z/lwuVpYoa/AKl96X9xeFsfUj1PB2sKNyzhwb7vwmNYXWh05S6jDkupRak0SXb60gqKb
         ajO8gukr5xmA4aDApA/UyWvsnjLARvW3HY7Jl5+BDRblwHzvTJnYYd1e8bHkeJeZRz/0
         AUFE6DR5iv2QP9h/fCVl3Wcadd+YE4KXDH2EVQPPy2SKVYS5bke135hIYLbnf3YN/BQD
         GQ/1pmfqJ1cyAo2MBZbFs6LqLJjMpKY/3i5w4pGrTAey/cCYf9YL4nlw1SGGIZ4Bwuzn
         1kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Y5PH1kHYVukczRtGwzpchLXB+yyOyEkDWOUj/XoULME=;
        b=ZsU3waxHIX0m/N98+ArUyzRWfz209Su8ylIjzMS6K7k1cdnwrwnvHfE7d9J+dru2jj
         qAym27WvbABForLMJ6Yj2l2EOet42W8wXnKABP4rgSs7Qs3yAgdKbfQGmsu0/R4YlPl4
         pSmyP4KhkueKV0hA3je+jmz85mFoOjtuHV5B4wh9EmXZ2CzBE49+jhSfqYUd6Ft/JSEG
         qJoz6VuhEHLzB0hFKbLEtuqNtb93vZEbXFw72JRKWkqczNLft07jDT8BehemwqIzbnS3
         pW283UmCSbpGTuvZYOwAKefhz2xWCPQ0/K4TDiaZl24rSNU/pu/ipwIrwnOP+DRAroqI
         5xtA==
X-Gm-Message-State: AOAM532ymy8JI2h/zhb6qvl4kdV8vr+NSQzhg1x/xhgO3UhGWczqVuqQ
        gGOIAElDdaF814vVj5es4xw/MJ0ne+k=
X-Google-Smtp-Source: ABdhPJwQvFvXKm1fB3LQAApz6QQKi10ryqg9gZknFjDWUszKgBx/1Cr9tJLyy8/E8gsQEcenTSn5vA==
X-Received: by 2002:a05:620a:219b:: with SMTP id g27mr8308029qka.399.1623174418992;
        Tue, 08 Jun 2021 10:46:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id h2sm12963080qkf.106.2021.06.08.10.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:46:58 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [RFC PATCH 0/6] Add a tool for using the new sysfs files
Date:   Tue,  8 Jun 2021 13:46:51 -0400
Message-Id: <20210608174657.603256-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

These patches implement a tool that can be used to read and write the
sysfs files, with subcommands! They need Olga's most recent patches to
run.

The following subcommands are implemented:
  nfs-sysfs.py rpc-client
  nfs-sysfs.py xprt
  nfs-sysfs.py xprt set
  nfs-sysfs.py xprt-switch
  nfs-sysfs.py xprt-switch set

So you can print out information about every xprt-switch with:
	anna@client % ./nfs-sysfs.py xprt-switch
	switch 0: num_xprts 1, num_active 1, queue_len 0
		xprt 0: local, /var/run/gssproxy.sock
	switch 1: num_xprts 1, num_active 1, queue_len 0
		xprt 1: local, /var/run/rpcbind.sock
	switch 2: num_xprts 4, num_active 4, queue_len 0
		xprt 2: tcp, 192.168.111.188
		xprt 3: tcp, 192.168.111.188
		xprt 5: tcp, 192.168.111.188
		xprt 6: tcp, 192.168.111.188
	switch 3: num_xprts 1, num_active 1, queue_len 0
		xprt 7: tcp, 192.168.111.1
	switch 4: num_xprts 1, num_active 1, queue_len 0
		xprt 4: tcp, 192.168.111.188

And information about each xprt:
	anna@client % ./nfs-sysfs.py xprt
	xprt 0: local, /var/run/gssproxy.sock, state <CONNECTED,BOUND>, num_reqs 2
		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
	xprt 1: local, /var/run/rpcbind.sock, state <CONNECTED,BOUND>, num_reqs 2
		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
	xprt 2: tcp, 192.168.111.188, state <CONNECTED,BOUND>, num_reqs 2
		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
	xprt 3: tcp, 192.168.111.188, state <CONNECTED,BOUND>, num_reqs 2
		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
	xprt 4: tcp, 192.168.111.188, state <BOUND>, num_reqs 2
		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
	xprt 5: tcp, 192.168.111.188, state <CONNECTED,BOUND>, num_reqs 2
		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
	xprt 6: tcp, 192.168.111.188, state <CONNECTED,BOUND>, num_reqs 2
		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
	xprt 7: tcp, 192.168.111.1, state <CONNECTED,BOUND>, num_reqs 2
		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0

You can use the `set` subcommand to change the dstaddr of individual xprts:
	anna@client % ./nfs-sysfs.py xprt --id 2
	xprt 2: tcp, 192.168.111.188, state <CONNECTED,BOUND>, num_reqs 2
		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
	anna@client % sudo ./nfs-sysfs.py xprt set --id 2 --dstaddr server2.nowheycreamery.vm
	xprt 2: tcp, 192.168.111.186, state <CONNECTED,BOUND>, num_reqs 2
		cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
		binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0

Or for changing the dstaddr of all xprts attached to a switch:
	anna@client % ./nfs-sysfs.py xprt-switch --id 2
	switch 2: num_xprts 4, num_active 4, queue_len 0
		xprt 2: tcp, 192.168.111.188
		xprt 3: tcp, 192.168.111.188
		xprt 5: tcp, 192.168.111.188
		xprt 6: tcp, 192.168.111.188
	anna@client % sudo ./nfs-sysfs.py xprt-switch set --id 2 --dstaddr server2.nowheycreamery.vm
	switch 2: num_xprts 4, num_active 4, queue_len 0
		xprt 2: tcp, 192.168.111.186
		xprt 3: tcp, 192.168.111.186
		xprt 5: tcp, 192.168.111.186
		xprt 6: tcp, 192.168.111.186


I'm sure this needs lots of polish before it's ready for inclusion,
along with needing a Makefile so it can be installed (I've just been
running it out of the nfs-utils/tools/nfs-sysfs/ directory). But it's
still a start, and I wanted to post it before going on New Baby Leave
Part 2 (June 12 - July 11).

What does everybody think?
Anna


Anna Schumaker (6):
  nfs-sysfs: Add an nfs-sysfs.py tool
  nfs-sysfs.py: Add a command for printing xprt switch information
  nfs-sysfs.py: Add a command for printing individual xprts
  nfs-sysfs.py: Add a command for printing rpc-client information
  nfs-sysfs.py: Add a command for changing xprt dstaddr
  nfs-sysfs.py: Add a command for changing xprt-switch dstaddrs

 tools/nfs-sysfs/client.py    | 27 ++++++++++++++
 tools/nfs-sysfs/nfs-sysfs.py | 23 ++++++++++++
 tools/nfs-sysfs/switch.py    | 51 +++++++++++++++++++++++++++
 tools/nfs-sysfs/sysfs.py     | 28 +++++++++++++++
 tools/nfs-sysfs/xprt.py      | 68 ++++++++++++++++++++++++++++++++++++
 5 files changed, 197 insertions(+)
 create mode 100644 tools/nfs-sysfs/client.py
 create mode 100755 tools/nfs-sysfs/nfs-sysfs.py
 create mode 100644 tools/nfs-sysfs/switch.py
 create mode 100644 tools/nfs-sysfs/sysfs.py
 create mode 100644 tools/nfs-sysfs/xprt.py

-- 
2.32.0

