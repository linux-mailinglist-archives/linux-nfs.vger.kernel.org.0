Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030726327F
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2019 09:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfGIH57 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Jul 2019 03:57:59 -0400
Received: from ivanoab6.miniserver.com ([5.153.251.140]:35990 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfGIH57 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Jul 2019 03:57:59 -0400
X-Greylist: delayed 2614 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jul 2019 03:57:59 EDT
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1hkkKV-0002zG-Qo; Tue, 09 Jul 2019 07:14:24 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.89)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1hkkKT-0005QY-B2; Tue, 09 Jul 2019 08:14:23 +0100
Subject: Fwd: NFS Caching broken in 4.19.37
References: <5022bdc4-9f3e-9756-cbca-ada37f88ecc7@cambridgegreys.com>
To:     linux-nfs@vger.kernel.org, jlayton@kernel.org
From:   Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
X-Forwarded-Message-Id: <5022bdc4-9f3e-9756-cbca-ada37f88ecc7@cambridgegreys.com>
Message-ID: <ce4e1e84-50a1-c40b-a0bc-fa8ac4d7676b@kot-begemot.co.uk>
Date:   Tue, 9 Jul 2019 08:14:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5022bdc4-9f3e-9756-cbca-ada37f88ecc7@cambridgegreys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Forwarding to maintainers (apologies, did not cc on first send).

A.

-------- Forwarded Message --------
Subject: NFS Caching broken in 4.19.37
Date: Mon, 8 Jul 2019 19:19:54 +0100
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi list,

NFS caching appears broken in 4.19.37.

The more cores/threads the easier to reproduce. Tested with identical 
results on Ryzen 1600 and 1600X.

1. Mount an openwrt build tree over NFS v4
2. Run make -j `cat /proc/cpuinfo | grep vendor | wc -l` ; make clean in 
a loop
3. Result after 3-4 iterations:

State on the client

ls -laF 
/var/autofs/local/src/openwrt/build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm

total 8
drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../

State as seen on the server (mounted via nfs from localhost):

ls -laF 
/var/autofs/local/src/openwrt/build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm
total 12
drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../
-rw-r--r-- 1 anivanov anivanov   32 Jul  8 11:40 ipcbuf.h

Actual state on the filesystem:

ls -laF 
/exports/work/src/openwrt/build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm
total 12
drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../
-rw-r--r-- 1 anivanov anivanov   32 Jul  8 11:40 ipcbuf.h

So the client has quite clearly lost the plot. Telling it to drop caches 
and re-reading the directory shows the file present.

It is possible to reproduce this using a linux kernel tree too, just 
takes much more iterations - 10+ at least.

Both client and server run 4.19.37 from Debian buster. This is filed as 
debian bug 931500. I originally thought it to be autofs related, but 
IMHO it is actually something fundamentally broken in nfs caching 
resulting in cache corruption.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
