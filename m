Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E8D156C50
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2020 21:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbgBIUCF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Feb 2020 15:02:05 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:44497 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgBIUCF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Feb 2020 15:02:05 -0500
Received: by mail-pl1-f169.google.com with SMTP id d9so1921669plo.11
        for <linux-nfs@vger.kernel.org>; Sun, 09 Feb 2020 12:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=SLXJVSkHzur6U0/cQO20c0n77nyge2Wpa4S16wgCDu8=;
        b=ukSUICnCA9nV6ur1H0PZzfjoXARjwKPairy7HZcYLuaw13P6bQfeav+4mPQxwjml3M
         QYh0jqgNg8AXsjHT13SffcZ3p6GWd2g9d2mfoZRAzZ/LHewVeyhNkqn6zAVRXxB2l3po
         RBAIi7fGN5wo7d6otjcXVHOGNJE0OxCoX3ux2RS/7/ClJyBXXUhdoELVZI201f+aCxRV
         IaqTXGw7pkZoe5lHBV0fF3eM60OhjQlDka/Zimyl0vwZ8FnZbjpFmIyhDZoVf9JZUVTn
         MFxqAgl5S/ZyLdmGVFqDLIxdga6RdxKy7z2IhnP/UtJixci9HybR0qd+136wLi6cwZAO
         5iRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:to:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=SLXJVSkHzur6U0/cQO20c0n77nyge2Wpa4S16wgCDu8=;
        b=AMqZpJtWUIsM7MiSddPUmBLOAvSZ8A7H1xCSIb2YxiBHkOcKmY/PLTOBLQQhxekrna
         D1mHNZ4Ly6x89RVDds5QwrZSQx7bKLwryr8axu6nQcb7VuybFOpCGelfkEy6zvjMzxdN
         8FeO510LvVvgD8P1mILhIpVtR3Zw55msM6N0URXhMAMgjNXlRNaFY1XadT3oa0VMBuET
         M6l0c3uRnNyOo1/XYAjG9C2tHFiP4VzRgm10D8Mme/D0Ba0pgycTu3nMqvChp/RhqiRw
         r65gf3dOIPFmJ1TAcf+kAMZRIn9hIm5dH0ghORWPSbIHfyB0WXeZZWHvr7hcd5UcG9yX
         uo/w==
X-Gm-Message-State: APjAAAUHfxGVK1AauHuvTWIQBVc3W1rDEcvSrpg2shiPeKP/tWT6EdP5
        pG6+uzp86Fr3HCuiHbD8U9XZY9aR
X-Google-Smtp-Source: APXvYqxQ2u9TodWqw/P9yacZ/CsfzNby2ettgJPqZlC+BK1VIO7/Y05D9FQYnJDpCj0kvWS2+BiWoA==
X-Received: by 2002:a17:902:6bcb:: with SMTP id m11mr9881163plt.10.1581278524482;
        Sun, 09 Feb 2020 12:02:04 -0800 (PST)
Received: from mua.localhost (99-7-172-215.lightspeed.snmtca.sbcglobal.net. [99.7.172.215])
        by smtp.gmail.com with ESMTPSA id f3sm9967983pga.38.2020.02.09.12.02.04
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2020 12:02:04 -0800 (PST)
Reply-To: pgnet.dev@gmail.com
To:     linux-nfs@vger.kernel.org
From:   PGNet Dev <pgnet.dev@gmail.com>
Subject: boot-time rpcbind/rpc.statd issues -- can't open file ..., can't save
 any reg ..., etc ?
Message-ID: <21d9595c-f132-adfb-1158-6c7a5d7710f7@gmail.com>
Date:   Sun, 9 Feb 2020 12:02:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

i've an nfs v4 server (nfs-kernel-server), with

	rpm -qa | egrep -i "^rpc|^nfs"
		nfs-client-2.1.1-lp151.7.3.1.x86_64
		nfsidmap-0.26-lp151.3.2.x86_64
		rpcbind-1.2.5-lp151.118.1.x86_64
		nfs-kernel-server-2.1.1-lp151.7.3.1.x86_64

on

	uname -rm
		5.5.2-25.g994cf1f-default x86_64


after boot,

	ps ax | egrep "nfs|rpc"
	  263 ?        I<     0:00 [rpciod]
	  273 ?        I<     0:00 [nfsiod]
	 1379 ?        Ss     0:00 /sbin/rpcbind -w -f
	 1383 ?        Ss     0:00 /usr/sbin/rpc.idmapd
	 2348 ?        Ss     0:00 /usr/sbin/rpc.mountd
	 2365 ?        Ss     0:00 /usr/sbin/rpc.statd -p 4000
	 2432 ?        S      0:00 [nfsd]
	 2433 ?        S      0:00 [nfsd]
	 2434 ?        S      0:00 [nfsd]
	 2435 ?        S      0:00 [nfsd]
	 2436 ?        S      0:00 [nfsd]
	 2437 ?        S      0:00 [nfsd]
	 2438 ?        S      0:00 [nfsd]
	 2439 ?        S      0:00 [nfsd]

and nfs et al _seem_ to be functioning.

but boot logs show p3 errors,

	journalctl -xb0 -p3
		-- Logs begin at Sat 2020-02-08 13:27:39 PST, end at Sun 2020-02-09 11:39:21 PST. --
		Feb 09 11:38:39 sharesvr011 rpc.statd[406]: Failed to open directory sm: No such file or directory
		Feb 09 11:38:39 sharesvr011 rpc.statd[406]: Failed to stat /var/lib/nfs/sm: No such file or directory
		Feb 09 11:38:50 sharesvr011 rpcbind[402]: cannot open file = /run/rpcbind/rpcbind.xdr for writing
		Feb 09 11:38:50 sharesvr011 rpcbind[402]: cannot save any registration
		Feb 09 11:38:50 sharesvr011 rpcbind[402]: cannot open file = /run/rpcbind/portmap.xdr for writing
		Feb 09 11:38:50 sharesvr011 rpcbind[402]: cannot save any registration

in more detail,

	journalctl -xb0 | egrep -i "rpc|nfs"
		Feb 09 11:38:39 sharesvr011 kernel: RPC: Registered named UNIX socket transport module.
		Feb 09 11:38:39 sharesvr011 kernel: RPC: Registered udp transport module.
		Feb 09 11:38:39 sharesvr011 kernel: RPC: Registered tcp transport module.
		Feb 09 11:38:39 sharesvr011 kernel: RPC: Registered tcp NFSv4.1 backchannel transport module.
		Feb 09 11:38:39 sharesvr011 kernel: FS-Cache: Netfs 'nfs' registered for caching
		Feb 09 11:38:39 sharesvr011 systemd-modules-load[254]: Inserted module 'nfs'
		Feb 09 11:38:39 sharesvr011 systemd-modules-load[254]: Inserted module 'nfs_acl'
		Feb 09 11:38:39 sharesvr011 kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
		Feb 09 11:38:39 sharesvr011 systemd-modules-load[254]: Inserted module 'nfsd'
		Feb 09 11:38:39 sharesvr011 rpc.statd[406]: Version 2.1.1 starting
		Feb 09 11:38:39 sharesvr011 rpc.statd[406]: Failed to open directory sm: No such file or directory
		Feb 09 11:38:39 sharesvr011 rpc.statd[406]: Initializing NSM state
		Feb 09 11:38:39 sharesvr011 rpc.statd[406]: Failed to stat /var/lib/nfs/sm: No such file or directory
		Feb 09 11:38:39 sharesvr011 dracut-pre-udev[385]: rpc.idmapd: Could not find group "nfsnobody"
		Feb 09 11:38:50 sharesvr011 rpcbind[402]: cannot open file = /run/rpcbind/rpcbind.xdr for writing
		Feb 09 11:38:50 sharesvr011 rpcbind[402]: cannot save any registration
		Feb 09 11:38:50 sharesvr011 rpcbind[402]: cannot open file = /run/rpcbind/portmap.xdr for writing
		Feb 09 11:38:50 sharesvr011 rpcbind[402]: cannot save any registration
		Feb 09 11:38:52 sharesvr011 systemd[1]: Mounting NFSD configuration filesystem...
		Feb 09 11:38:52 sharesvr011 systemd[1]: Listening on RPCbind Server Activation Socket.
		Feb 09 11:38:52 sharesvr011 systemd[1]: Reached target RPC Port Mapper.
		Feb 09 11:38:52 sharesvr011 systemd[1]: Mounted NFSD configuration filesystem.
		Feb 09 11:38:58 sharesvr011 systemd[1]: Mounting /NFS4/SHARE01...
		Feb 09 11:38:58 sharesvr011 systemd[1]: Mounted /NFS4/SHARE01.
		Feb 09 11:39:01 sharesvr011 systemd[1]: Mounting RPC Pipe File System...
		Feb 09 11:39:01 sharesvr011 systemd[1]: Mounted RPC Pipe File System.
		Feb 09 11:39:01 sharesvr011 systemd[1]: Starting NFSv4 ID-name mapping service...
		Feb 09 11:39:01 sharesvr011 systemd[1]: Starting RPC Bind...
		Feb 09 11:39:02 sharesvr011 systemd[1]: Starting Alias for NFS client...
		Feb 09 11:39:02 sharesvr011 systemd[1]: Started RPC Bind.
		Feb 09 11:39:02 sharesvr011 systemd[1]: Started NFSv4 ID-name mapping service.
		Feb 09 11:39:02 sharesvr011 systemd[1]: Started Alias for NFS client.
		Feb 09 11:39:02 sharesvr011 systemd[1]: Reached target NFS client services.
		Feb 09 11:39:17 sharesvr011 systemd[1]: Starting NFS Mount Daemon...
		Feb 09 11:39:17 sharesvr011 rpc.mountd[2348]: Version 2.1.1 starting
		Feb 09 11:39:17 sharesvr011 systemd[1]: Starting NFS status monitor for NFSv2/3 locking....
		Feb 09 11:39:17 sharesvr011 systemd[1]: Starting Alias for NFS server...
		Feb 09 11:39:17 sharesvr011 systemd[1]: Started NFS Mount Daemon.
		Feb 09 11:39:17 sharesvr011 systemd[1]: Started Alias for NFS server.
		Feb 09 11:39:17 sharesvr011 rpc.statd[2365]: Version 2.1.1 starting
		Feb 09 11:39:17 sharesvr011 rpc.statd[2365]: Flags: TI-RPC
		Feb 09 11:39:17 sharesvr011 systemd[1]: Started NFS status monitor for NFSv2/3 locking..
		Feb 09 11:39:17 sharesvr011 systemd[1]: Starting NFS server and services...

The errors,

		rpc.statd[406]: Failed to open directory sm: No such file or directory
		rpc.statd[406]: Failed to stat /var/lib/nfs/sm: No such file or directory
		dracut-pre-udev[385]: rpc.idmapd: Could not find group "nfsnobody"
		rpcbind[402]: cannot open file = /run/rpcbind/rpcbind.xdr for writing
		rpcbind[402]: cannot save any registration

appear non-fatal.

I suspect systemd dependencies ... 

Are these known/recognized issues? 

Any guidance as to how to troubleshoot/resolve?

