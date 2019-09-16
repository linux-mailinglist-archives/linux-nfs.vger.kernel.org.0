Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD89B34CA
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 08:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfIPGnp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 16 Sep 2019 02:43:45 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:58757 "EHLO
        mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfIPGnp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 02:43:45 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Sep 2019 02:43:44 EDT
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
        by mail.lysator.liu.se (Postfix) with ESMTP id 32EE240014
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 08:33:45 +0200 (CEST)
Received: from [IPv6:2001:6b0:17:f002:9c7a:2043:699e:c8dc] (unknown [IPv6:2001:6b0:17:f002:9c7a:2043:699e:c8dc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lysator.liu.se (Postfix) with ESMTPSA id 1BCDD4000A
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 08:33:44 +0200 (CEST)
From:   Peter Eriksson <pen@lysator.liu.se>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: (Ubuntu 18.04) NFSv4+sec=krb5 client turns into a DoS device after
 ticket expires?
Message-Id: <213387E7-35EB-415C-989E-3148D9157D23@lysator.liu.se>
Date:   Mon, 16 Sep 2019 08:33:44 +0200
To:     linux-nfs@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We’re investigating a problem where we are seeing a number of Ubuntu 18.04 Linux clients that bombards our NFS Servers with TCP connections. Like 400 requests/second of new TCP connection requests to the NFS server port (with unique source port numbers) which causes the firewall state tracking tables on the server to grow like crazy.

The stream of IP packets we are seeing look like this (times in seconds):

0.001280 Client -> Server SYN
0.001289 Server -> Client SYN+ACK
0.001516 Client -> Server ACK
0.003609 Client -> Server FIN+ACK
0.003615 Server -> Client ACK
0.003620 Server -> Client FIN+ACK
0.003841 Client -> Server ACK
<repeat 200-400 times/s>

Ie, initiate a new connection and then immediately disconnect again.

On the client this coincides with a user which has their home directory mounted via NFS (v4) with sec=krb5 and an expired Kerberos ticket and having an “evolution” process running. This somehow causes rpc.gssd to run a lot...

The rpc.gssd seems to be doing this:

> Tasks: 266 total,   1 running, 193 sleeping,   0 stopped,   0 zombie
> %Cpu(s):  5.0 us,  1.5 sy,  0.0 ni, 93.1 id,  0.0 wa,  0.0 hi,  0.4 si,  0.0 st
> KiB Mem : 16303264 total,   955844 free,  3912820 used, 11434600 buff/cache
> KiB Swap:  7812092 total,  7811580 free,      512 used. 11481708 avail Mem 
>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                      
>   705 root      20   0  328888   4924   3568 S  20.8  0.0   1520:27 rpc.gssd

> epoll_wait(4, [{EPOLLIN, {u32=9, u64=9}}], 32, -1) = 1
> read(9, "mech=krb5 uid=1036985 enctypes=1"..., 32768) = 50
> clone(child_stack=0x7f4746f5ffb0, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, parent_tidptr=0x7f4746f609d0, tls=0x7f4746f60700, child_tidptr=0x7f4746f609d0) = 1310
> epoll_wait(4, [{EPOLLIN, {u32=9, u64=9}}], 32, -1) = 1


Evolution has a number of file descriptors open:

> evolution 26916 olaha93  cwd       DIR               0,68       45        4 /home/olaha93 (filur04.it.liu.se:/staff/olaha93)
> evolution 26916 olaha93  mem       REG               0,68            229909 /home/olaha93/.cache/mesa_shader_cache/index (filur04.it.liu.se:/staff/olaha93) (stat: Permission denied)
> evolution 26916 olaha93  mem       REG               0,68            175429 /home/olaha93/.config/dconf/user (filur04.it.liu.se:/staff/olaha93) (stat: Permission denied)
> evolution 26916 olaha93  mem       REG               0,68            171739 /home/olaha93/.local/share/gvfs-metadata/.nfs0000000000029edb00000333 (filur04.it.liu.se:/staff/olaha93) (stat: Permission denied)
> evolution 26916 olaha93   15u      REG               0,68    28672   230539 /home/olaha93/.pki/nssdb/cert9.db (filur04.it.liu.se:/staff/olaha93)
> evolution 26916 olaha93   16u      REG               0,68    28672   230541 /home/olaha93/.pki/nssdb/key4.db (filur04.it.liu.se:/staff/olaha93)
> evolution 26916 olaha93   18u  unknown               0,68                   /home/olaha93/.cache/evolution/mail/e013fa56fec8685e5cb71733b66216b51495a944/folders.db (filur04.it.liu.se:/staff/olaha93)
> evolution 26916 olaha93   19u  unknown               0,68                   /home/olaha93/.cache/evolution/mail/1e49c4d51a101a775373e6455c4ce75b1bcc87a9/folders.db (filur04.it.liu.se:/staff/olaha93)
> evolution 26916 olaha93   21u  unknown               0,68                   /home/olaha93/.cache/evolution/mail/13f710d8659a79fd42ea3aff53b116f6a67bbbeb/folders.db (filur04.it.liu.se:/staff/olaha93)
> evolution 26916 olaha93   22u  unknown               0,68                   /home/olaha93/.cache/evolution/mail/94e55bfdbf6fe8f93ceedef1a7ae247fb97ea2ff/folders.db (filur04.it.liu.se:/staff/olaha93)
> evolution 26916 olaha93   23u  unknown               0,68                   /home/olaha93/.cache/evolution/mail/16e1d5d4fcf3c26e45b366759fdd06df1b55b979/folders.db (filur04.it.liu.se:/staff/olaha93)
> evolution 26916 olaha93   24u  unknown               0,68                   /home/olaha93/.local/share/evolution/mail/local/folders.db (filur04.it.liu.se:/staff/olaha93)
> evolution 26916 olaha93   25u  unknown               0,68                   /home/olaha93/.local/share/evolution/mail/vfolder/folders.db (filur04.it.liu.se:/staff/olaha93)
> evolution 26916 olaha93   26u  unknown               0,68                   /home/olaha93/.config/evolution/mail/remote-content.db (filur04.it.liu.se:/staff/olaha93)
> evolution 26916 olaha93   27u  unknown               0,68                   /home/olaha93/.config/evolution/mail/properties.db (filur04.it.liu.se:/staff/olaha93)
> evolution 26916 olaha93   29r  unknown               0,68                   /home/olaha93/.local/share/gvfs-metadata/.nfs0000000000029edb00000333 (filur04.it.liu.se:/staff/olaha93)


Repeated errors from evolution in the log files:

> Sep 13 16:01:48 lille71 evolution[26916]: camel_store_summary_disconnect_folder_summary: Store summary 0x559b44194390 is not connected to folder summary 0x7fcaf40428e0
> Sep 13 16:01:48 lille71 evolution[26916]: Unable to load summary: disk I/O error
> Sep 13 16:01:48 lille71 evolution[26916]: GError set over the top of a previous GError or uninitialized memory.
>                                           This indicates a bug in someone's code. You must ensure an error is NULL before it's set.
>                                           The overwriting error message was: disk I/O error

Restarting rpc.gssd doesn’t seem to help. Removing the expired kerberos cache file doesn’t help. So my guess is that evolution somehow triggers new NFS server connections but then the kernel immediately terminates it without ever sending any data to the NFS server.

(Rebooting the client works - but.. :-)


It would have been nice if an expired kerberos cache didn’t cause this aggressive behaviour…

- Peter
