Return-Path: <linux-nfs+bounces-17735-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A166D0F174
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Jan 2026 15:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D05E3023D06
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Jan 2026 14:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CD6346AC8;
	Sun, 11 Jan 2026 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ9EZE/t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E28F346AE2
	for <linux-nfs@vger.kernel.org>; Sun, 11 Jan 2026 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768141051; cv=none; b=XqlQQAPX78fcdLFRmwyK7VTL6rU0c+PinSfSDJKZHr5fhkpGC8ba81u1aa33DMbxT+fQEPpqcF6/Du9jpmgrKL1M9jow4pNQF/rS/jBTG5kHT6YTqvsV8XlWHmrF9w/Arficpyf7HgIQl3O66nCzw4UFb+XD/nzOYlBnPu47ZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768141051; c=relaxed/simple;
	bh=tPGQ4me3lNATYqYpvKIOt8bNRssCWMiTnFFzIPiABCU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gOTz6tWK1DGkvxALlA8RFvBhktocBVbpSRk1rQXkaLUfQuYMeRC0d911zv8K/yl4nweEO8SEl5W7azWSCDcHanrLine3xfTqVeKSBhh5u3Mcz3YavMPI382rsK/G6btgxWvnbInuz1iQTwzW64Dg5D462JrNsknzPnLQ6ZBLbhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ9EZE/t; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47d182a8c6cso34085545e9.1
        for <linux-nfs@vger.kernel.org>; Sun, 11 Jan 2026 06:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768141047; x=1768745847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5lgTSMbCJ+kAWtXt6KlwM7Lxkcfb9mdFUwob+Lc1Vs=;
        b=IQ9EZE/tpvrEBjqvGt+aB0JdYUapP0538DxgTwqn4soQFiXjyd1dqIqtlCXPqtpk4D
         eDwCxtZ+Qhwguwkyb2z31OEOdYhLz96jil+eEAikX6theHEeozc4E8ggb9ZTdTwq5RG4
         VDTbjxqbKwmgPClbtLaQEm0uz2FRFA5jfJ2R4dljpNQ1tQb1rqG+UaudzmizkjifguZk
         t5QjFegH93KEUrYrCQU8x18WaT9rqFvun7Fz4RWD5UdWH0Tv20eJ1Q9+mttUjh6R/aK/
         UfbqiyuMDwrsYsvqforvnOp8wiVQ+PrPW02A7xmtINAk3YakbcyqE4u5ZCOsP0l/+z1E
         9KSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768141047; x=1768745847;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:sender:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P5lgTSMbCJ+kAWtXt6KlwM7Lxkcfb9mdFUwob+Lc1Vs=;
        b=YXWXZ2gYU0AFDEkZbS5wBiPifZBLKUKS/FnKM6lEzcp9UkcRyHoOZtjYwnI3eN5c8G
         g2piajsMwObWFQ5yP/u276xic9GG/bcl/icM47SBNxOCx+L6G0p+Yu+6WLNDMb9fEdmB
         SP9cFx+92mh5RaFXnDeh6W0TkKWu3OqIvcf+Ps6v/7kcMy3Dkstz1teUlkAu1sT92ZGF
         UVeBHHpwFD405EMdoi2He4VasmJI5/5pOid8TaUbyFv5tZKB+gvwGr1wWD7Pg8jiM+mQ
         fWR/AfKzfu1iJJZZ0CVRdO/hvQVZQuHqLCjp22DIFpbQkSCEGtB475u0YCW5b8JRgG2m
         NhBg==
X-Gm-Message-State: AOJu0YzpvXECccpDV7+axEsFN0WvtAC/89UtEtmbljbPeHEeIyDXgYCS
	QiO0b3MwJOzRyGBT28fnJI3n12E6ly6Jeq5KzFUBfwG3aiVUYpdrREnT
X-Gm-Gg: AY/fxX5TWn23Gaywk3697L8vWbGFb/X2ael8bDhvpLkHIUNGyfBco09zMj8KGFKGhrg
	S6JTUWTO8kwAJBq7kRs2sGYaO2Q4iHbaH9L8oNoJVYMblP8tkoeEnob9upGpCpG+Tg829xHCx5x
	HXhcNJWmPv218FIQ+mHSBdgvTZr3nuc7IXWbV0UY/5sCaQbSFOoY8F6vLFBbhqGscW99iLz329K
	mziokT4O2AMC2Z+j7aEtcoFEg3sNrUKH4pjVQx95ugrelu2oVATm+YlCtFNZwTYwGe7HywijV0X
	pG4g2YQ8aKls+3RtW8cs19tw6cpbMo6L3O6pdl1oyyplq17F3vTyUjsPQkGqN5LkwNS+wCIaCt5
	JVW1EM7YYFmFYhQGlVjiLQ5aYpBlgczxmpmN3Je2kyL8BI7969jnyFC4J+CpehLkNp/MaAj+Fo+
	VDTFzYqAPWcmueM4nRdxpKua+f2wIa6Ggvuk1fCw1O2Vu+tiKpddtlDNI=
X-Google-Smtp-Source: AGHT+IHD1vrInrR8Tngmz4iQNEZuEPPcg//WAtu8RBIQ3jMqIaXzk4UEebfcfAfZf9fTGGfosIa4Uw==
X-Received: by 2002:a05:600c:1d0c:b0:471:700:f281 with SMTP id 5b1f17b1804b1-47d84b4093cmr152063245e9.25.1768141046248;
        Sun, 11 Jan 2026 06:17:26 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e1adbsm33847868f8f.17.2026.01.11.06.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 06:17:25 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 1FDBEBE2EE7; Sun, 11 Jan 2026 15:17:24 +0100 (CET)
Date: Sun, 11 Jan 2026 15:17:24 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: linux-nfs@vger.kernel.org, Scott Mayhew <smayhew@redhat.com>,
	Steve Dickson <steved@redhat.com>
Subject: [nfs-utils] "blkmapd open pipe file /run/rpc_pipefs/nfs/blocklayout
 failed" and handling of nfs-blkmap.service service
Message-ID: <176814099134.689475.12160936392296863650@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi all,

This is triggered by an older bugreport in Debian found at
https://bugs.debian.org/1009106 . 

In Debian we ship packages with nfs-blkmap.service installed and
enabled via the nfs-common package to be used on NFS clients. The
manpage of nfs.systemd(7) states:

       nfs-blkmap.service
              The blkmapd daemon is only required on NFS clients which are  us‐
              ing  pNFS  (parallel NFS), and particularly using the blocklayout
              layout protocol.  If you might use this particular  extension  to
              NFS, the nfs-blkmap.service unit should be enabled.

In Debian we ship this enabled by default as the following holds: The
systemd service even one does not use pNFS, without the blocklayout
module layouut protocol still starts without problem:

root@sid:~# systemctl status nfs-blkmap.service 
● nfs-blkmap.service - pNFS block layout mapping daemon
     Loaded: loaded (/usr/lib/systemd/system/nfs-blkmap.service; enabled; preset: enabled)
     Active: active (running) since Sun 2026-01-11 14:56:12 CET; 29s ago
 Invocation: 6bb055c1850a40d8bd2cc5841e92c3b9
       Docs: man:blkmapd(8)
    Process: 880 ExecStart=/usr/sbin/blkmapd (code=exited, status=0/SUCCESS)
   Main PID: 898 (blkmapd)
      Tasks: 1 (limit: 4668)
     Memory: 388K (peak: 2M)
        CPU: 4ms
     CGroup: /system.slice/nfs-blkmap.service
             └─898 /usr/sbin/blkmapd

Jan 11 14:56:12 sid systemd[1]: Starting nfs-blkmap.service - pNFS block layout mapping daemon...
Jan 11 14:56:12 sid blkmapd[898]: open pipe file /run/rpc_pipefs/nfs/blocklayout failed: No such file or directory
Jan 11 14:56:12 sid systemd[1]: Started nfs-blkmap.service - pNFS block layout mapping daemon.
root@sid:~#

The service an the blkmapd deamon is started.

What though seems irritating people is the error level message:

blkmapd[806]: open pipe file /run/rpc_pipefs/nfs/blocklayout failed: No such file or directory

As far I understand though this is mostly "harmless", because
42a065968d0f ("blkmapd: allow blocklayoutdriver module to
load/unload") did allow to blocklayoutdriver module to load/unload,
and if that is done the the pipe file is created or deleted
accordinly:

root@sid:~# modprobe blocklayoutdriver 
root@sid:~# ls -l /run/rpc_pipefs/nfs/blocklayout 
prw------- 1 root root 0 Jan 11 14:57 /run/rpc_pipefs/nfs/blocklayout
root@sid:~# systemctl status nfs-blkmap.service 
● nfs-blkmap.service - pNFS block layout mapping daemon
     Loaded: loaded (/usr/lib/systemd/system/nfs-blkmap.service; enabled; preset: enabled)
     Active: active (running) since Sun 2026-01-11 14:56:12 CET; 1min 27s ago
 Invocation: 6bb055c1850a40d8bd2cc5841e92c3b9
       Docs: man:blkmapd(8)
    Process: 880 ExecStart=/usr/sbin/blkmapd (code=exited, status=0/SUCCESS)
   Main PID: 898 (blkmapd)
      Tasks: 1 (limit: 4668)
     Memory: 640K (peak: 2M)
        CPU: 4ms
     CGroup: /system.slice/nfs-blkmap.service
             └─898 /usr/sbin/blkmapd

Jan 11 14:56:12 sid systemd[1]: Starting nfs-blkmap.service - pNFS block layout mapping daemon...
Jan 11 14:56:12 sid blkmapd[898]: open pipe file /run/rpc_pipefs/nfs/blocklayout failed: No such file or directory
Jan 11 14:56:12 sid systemd[1]: Started nfs-blkmap.service - pNFS block layout mapping daemon.
Jan 11 14:57:21 sid blkmapd[898]: blocklayout pipe file created
root@sid:~#

(if the module is unloaded, then accordingly the pipe file will be
deleted and the service keeps running, and loading the
blocklayoutdriver will create the pipe if I understand the upstream
Linux change fe0a9b740881 ("pnfsblock: add device operations")
correctly, which is in since 3.1-rc1).

In utils/blkmapd/device-discovery.c 

555     /* open pipe file */
556     bl_watch_dir(rpcpipe_dir, &rpc_pipedir_wfd);
557     bl_watch_dir(nfspipe_dir, &nfs_pipedir_wfd);
558
559     bl_pipe_fd = open(bl_pipe_file, O_RDWR);
560     if (bl_pipe_fd < 0)
561         BL_LOG_ERR("open pipe file %s failed: %s\n", bl_pipe_file, strerror(errno));

As the pipe is created and deleted when the blocklayoutdriver is
loaded or unloaded, should the above really be ad error log level? Is
it needed at all?

For Debian purposes at least I would like to make things bit less
irritating for users, keep ideally the service enabled by default, so
that administraors whant to make use of pNFS setup with the
blocklayout layout protocol, they just need to make the module load.

Does that sound sensible? It looks at least Ubuntu is handling it
similarly (but the package is mostly synced from Debian here, with
some Ubuntu specific modification, but not in the handling of the 
nfs-blkmap.service  service). As far I understand Fedora ships the
service in the nfsv4-client-utils specific package.

Regards,
Salvatore

