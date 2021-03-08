Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2D33315B0
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Mar 2021 19:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCHSQb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 8 Mar 2021 13:16:31 -0500
Received: from us-smtp-delivery-145.mimecast.com ([63.128.21.145]:35606 "EHLO
        us-smtp-delivery-145.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230481AbhCHSQZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Mar 2021 13:16:25 -0500
Received: from zmcc-3-mta-2.zmailcloud.com (zmcc-3-mta-2.zmailcloud.com
 [35.238.170.66]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-_1hF5DgFMN66Q-Pf3a9V4Q-1; Mon, 08 Mar 2021 13:16:22 -0500
X-MC-Unique: _1hF5DgFMN66Q-Pf3a9V4Q-1
Received: from zmcc-3-mta-2.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-2.zmailcloud.com (Postfix) with ESMTPS id EB61DE28C6
        for <linux-nfs@vger.kernel.org>; Mon,  8 Mar 2021 12:16:21 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-2.zmailcloud.com (Postfix) with ESMTP id DC66DE2904
        for <linux-nfs@vger.kernel.org>; Mon,  8 Mar 2021 12:16:21 -0600 (CST)
X-Virus-Scanned: amavisd-new at zmcc-3-mta-2.zmailcloud.com
Received: from zmcc-3-mta-2.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-2.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EoVh2J8MSiPR for <linux-nfs@vger.kernel.org>;
        Mon,  8 Mar 2021 12:16:21 -0600 (CST)
Received: from jbreitman-mac.zxcvm.com (unknown [72.22.182.150])
        by zmcc-3-mta-2.zmailcloud.com (Postfix) with ESMTPSA id A6C83E28C6
        for <linux-nfs@vger.kernel.org>; Mon,  8 Mar 2021 12:16:21 -0600 (CST)
From:   Jason Breitman <jbreitman@tildenparkcapital.com>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: NFS Mount Hangs
Message-Id: <5E3B228F-5CFC-4EDF-B52E-1CDB947ADC00@tildenparkcapital.com>
References: <C643BB9C-6B61-4DAC-8CF9-CE04EA7292D0@tildenparkcapital.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 8 Mar 2021 13:16:21 -0500
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA45A274 smtp.mailfrom=jbreitman@tildenparkcapital.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: tildenparkcapital.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Issue
NFSv4 mounts periodically hang on the NFS Client.

During this time, it is possible to manually mount from another NFS Server on the NFS Client having issues.
Also, other NFS Clients are successfully mounting from the NFS Server in question.
Rebooting the NFS Client appears to be the only solution.

I believe this issue has been discussed in the past so I included an article that matched my symptoms.
I do not see a case statement for FIN_WAIT2 at https://elixir.bootlin.com/linux/v4.19.171/source/net/sunrpc/xprtsock.c.

NFS Client
OS: 		Debian Buster 10.8
Kernel:	4.19.171-2
Protocol:	NFSv4 with Kerberos Security
Mount Options:	nfs-server.domain.com:/data	/mnt/data	nfs4	lookupcache=pos,noresvport,sec=krb5,hard,rsize=1048576,wsize=1048576	00

Output from the NFS Client when the issue occurs
# netstat -an | grep NFS.Server.IP.X
tcp        0      0 NFS.Client.IP.X:46896      NFS.Server.IP.X:2049       FIN_WAIT2

# cat /sys/kernel/debug/sunrpc/rpc_xprt/*/info
netid: tcp
addr:  NFS.Server.IP.X
port:  2049
state: 0x51 

syslog
Mar  4 10:29:27 hostname kernel: [437414.131978] -pid- flgs status -client- --rqstp- -timeout ---ops--
Mar  4 10:29:27 hostname kernel: [437414.133158] 57419 40a1      0 9b723c73 143cfadf    30000 4ca953b5 nfsv4 OPEN_NOATTR a:call_connect_status [sunrpc] q:xprt_pending
Mar  4 10:29:27 hostname kernel: [437414.135211] 57420 4081    -11 9b723c73   (null)        0 4ca953b5 nfsv4 OPEN_NOATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.137250] 57421 4081    -11 9b723c73   (null)        0 4ca953b5 nfsv4 OPEN_NOATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.139345] 57422 4081    -11 9b723c73   (null)        0 4ca953b5 nfsv4 OPEN_NOATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.141496] 57423 4081    -11 9b723c73   (null)        0 4ca953b5 nfsv4 OPEN_NOATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.143712] 57424 4081    -11 9b723c73   (null)        0 4ca953b5 nfsv4 OPEN_NOATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.145940] 57425 4081    -11 9b723c73   (null)        0 4ca953b5 nfsv4 OPEN_NOATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.148227] 57426 4081    -11 9b723c73   (null)        0 4ca953b5 nfsv4 OPEN_NOATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.150575] 57427 4081    -11 9b723c73   (null)        0 4ca953b5 nfsv4 OPEN_NOATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.152938] 57428 4080    -11 9b723c73   (null)        0  fb0400d nfsv4 LOOKUP a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.154478] 57433 4080    -11 27bf33c1   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.156023] 57434 4080    -11 27bf33c1   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.157549] 57435 4080    -11 27bf33c1   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.159073] 57436 4080    -11 27bf33c1   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.160587] 57437 4080    -11 27bf33c1   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.162094] 57438 4080    -11 27bf33c1   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.163597] 57431 4080    -11 3118865a   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.165100] 57432 4080    -11 3118865a   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.166598] 57439 4080    -11 3118865a   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.168088] 57440 4080    -11 3118865a   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.169573] 57441 4080    -11 3118865a   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.171058] 57442 4080    -11 3118865a   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.172532] 57443 4080    -11 3118865a   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.173991] 57444 4080    -11 3118865a   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.175452] 57445 4080    -11 3118865a   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.176906] 57446 4080    -11 3118865a   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.178349] 57447 4080    -11 3118865a   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.179792] 57448 4080    -11 3118865a   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.181227] 57449 4080    -11 3118865a   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.182655] 57450 4080    -11 3118865a   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.184081] 57451 4080    -11 3118865a   (null)        0  fb0400d nfsv4 GETATTR a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.185494] 57418 4880    -11 d42d6144 ab8b1696        0  fb0400d nfsv4 STATFS a:call_connect_status [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.186905] 57430 4080    -11 d42d6144   (null)        0  fb0400d nfsv4 STATFS a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:27 hostname kernel: [437414.188310] 57429 5281    -11 907fb25c   (null)        0 5fa6554c nfsv4 SEQUENCE a:call_reserveresult [sunrpc] q:xprt_sending
Mar  4 10:29:30 hostname kernel: [437417.110517] RPC: 57419 xprt_connect_status: connect attempt timed out
Mar  4 10:29:30 hostname kernel: [437417.112172] RPC: 57419 call_connect_status (status -110)
Mar  4 10:29:30 hostname kernel: [437417.113337] RPC: 57419 call_timeout (major)
Mar  4 10:29:30 hostname kernel: [437417.114385] RPC: 57419 call_bind (status 0)
Mar  4 10:29:30 hostname kernel: [437417.115402] RPC: 57419 call_connect xprt 00000000e061831b is not connected
Mar  4 10:29:30 hostname kernel: [437417.116547] RPC: 57419 xprt_connect xprt 00000000e061831b is not connected
Mar  4 10:30:31 hostname kernel: [437478.551090] RPC: 57419 xprt_connect_status: connect attempt timed out
Mar  4 10:30:31 hostname kernel: [437478.552396] RPC: 57419 call_connect_status (status -110)
Mar  4 10:30:31 hostname kernel: [437478.553417] RPC: 57419 call_timeout (minor)
Mar  4 10:30:31 hostname kernel: [437478.554327] RPC: 57419 call_bind (status 0)
Mar  4 10:30:31 hostname kernel: [437478.555220] RPC: 57419 call_connect xprt 00000000e061831b is not connected
Mar  4 10:30:31 hostname kernel: [437478.556254] RPC: 57419 xprt_connect xprt 00000000e061831b is not connected

Reference Article
https://patchwork.kernel.org/project/linux-nfs/patch/20190220145650.21566-1-olga.kornievskaia@gmail.com/


Jason Breitman





