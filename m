Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEF412178A
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2019 19:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfLPSgm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Dec 2019 13:36:42 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34939 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfLPSgl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Dec 2019 13:36:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so397754wmb.0;
        Mon, 16 Dec 2019 10:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=j/OOxCQM0nUcpbg0rlV/CQsLDZ5ZDrjQy1E+zoBagdI=;
        b=JMudFJ2YR4kBLZRZ9almvtkAsak9mnaHMWAzuyDZK9A4MwBFSNg5fcBgHysYr7i/oP
         gd4rn1Y3xnJ7eTm93R/GL+UGJSfJp5g9Gt38H54NHl5h8wB+BQgAPlQ9eiq9IJLlSYkw
         jWNY7zBm3j6fX6d+F/xj3LdKYOd4I/6xDUhAW2RNVV2BYq8wAO+QwB+o5sGD3o/uzoiw
         7IxAklxNz5Klrvz5v2DnTGyJskKSk1AnzkoxhwQuxEcKxMCC8eQN9YAW1/3XvuCC/xmS
         4gUiYcvQoHMUQqyfS/Z96E2e7VeNp+Fx8k1Tb4RQ2TMvCnRlpbqLklZaoauziWuxiL7p
         fnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=j/OOxCQM0nUcpbg0rlV/CQsLDZ5ZDrjQy1E+zoBagdI=;
        b=h4F+ugMzGQrpZKe4p2veAO67jF+B8aMjsr4o/jZrQvyIOR6QH+tz8bxB0JRuR/Z63B
         dvJ7P/iEOoEGi6RpbKWWJRXxTIOWd7PbbInI3W2c5uHbi1K5p9i3VJ9GLAnqxYdVOt6J
         hUiS0CF8AK5vKQ+ePxMw2y0gkMmeWzkhbRrNcWNb3kSQ5ybWukgUVc00qj11Ndx1B2nX
         k7W4+HFQbqu/EevDBSOFMOvUBKXHN6FcCMwuKMUN4O+smRFxe6FJuFwpUoYtJqjo9Dnb
         8gXatXehLy/1T/KSvLJD7lYd8eSFwsrpqQcH2GKKO7FtTI2w2jI4UUHUfvnAZUULdT+S
         TC7g==
X-Gm-Message-State: APjAAAUTAFdDo7U4pzydM9TbcuGs33EhLGf6skvHo73JwnV4ugkFe2de
        9qdurU/oHQ/qjzjp85B0dSs=
X-Google-Smtp-Source: APXvYqzTLT8Xks5zl3PQnab/bVWlEWUCSFOpaVhki4OhCxHORt2ZcnjsQ9p2XXx+fSO9mGjCtiKDtA==
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr408319wma.159.1576521398960;
        Mon, 16 Dec 2019 10:36:38 -0800 (PST)
Received: from WINDOWSSS5SP16 (cpc96954-walt26-2-0-cust383.13-2.cable.virginm.net. [82.31.89.128])
        by smtp.gmail.com with ESMTPSA id t8sm22501509wrp.69.2019.12.16.10.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 10:36:38 -0800 (PST)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     <linux-nfs@vger.kernel.org>
Cc:     "'Trond Myklebust'" <trond.myklebust@hammerspace.com>,
        "'Anna Schumaker'" <anna.schumaker@netapp.com>,
        <linux-kernel@vger.kernel.org>, <linux-nfs@vger.kernel.org>
References: <05c201d5b439$d99083c0$8cb18b40$@gmail.com>
In-Reply-To: <05c201d5b439$d99083c0$8cb18b40$@gmail.com>
Subject: RE: [PATCH] NFSv4: open() should try lease recovery on NFS4ERR_EXPIRED
Date:   Mon, 16 Dec 2019 18:36:37 -0000
Message-ID: <05ce01d5b43f$c0861650$419242f0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHLcykFO2swrFFW3C5mPegNnWnxpafRjXFw
Content-Language: en-gb
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,


Currently if nfsv4 lease expires on a server Linux client will return EIO to
open and won't try to recover.

For example:

$ date; strace -t -e trace=open head /mnt/3/var/log/vmware-vmsvc.log
>/dev/null
Mon 16 Dec 17:37:16 GMT 2019
...
17:37:16 open("/mnt/3/var/log/vmware-vmsvc.log", O_RDONLY) = -1 EIO
(Input/output error)
...


The network/nfs traffic:

2638 17:37:16.286642918  10.50.2.57 -> 10.50.2.59  NFS 246 V4 Call ACCESS
FH: 0x62d40c52, [Check: RD LU MD XT DL]
2639 17:37:16.286929287  10.50.2.59 -> 10.50.2.57  NFS 194 V4 Reply (Call In
2638) ACCESS, [Access Denied: MD XT DL], [Allowed: RD LU]
2640 17:37:16.287295942  10.50.2.57 -> 10.50.2.59  NFS 258 V4 Call ACCESS
FH: 0xeddb7439, [Check: RD LU MD XT DL]
2641 17:37:16.287448815  10.50.2.59 -> 10.50.2.57  NFS 194 V4 Reply (Call In
2640) ACCESS, [Access Denied: MD XT DL], [Allowed: RD LU]
2642 17:37:16.287666576  10.50.2.57 -> 10.50.2.59  NFS 266 V4 Call ACCESS
FH: 0x8503e2cd, [Check: RD LU MD XT DL]
2643 17:37:16.287786851  10.50.2.59 -> 10.50.2.57  NFS 194 V4 Reply (Call In
2642) ACCESS, [Access Denied: MD XT DL], [Allowed: RD LU]
2644 17:37:16.287984808  10.50.2.57 -> 10.50.2.59  NFS 350 V4 Call OPEN DH:
0x8503e2cd/vmware-vmsvc.log
2645 17:37:16.288194276  10.50.2.59 -> 10.50.2.57  NFS 122 V4 Reply (Call In
2644) OPEN Status: NFS4ERR_EXPIRED


Both Linux and Solaris NFS servers return NFS4ERR_EXPIRED if nfsv4 lease
expire.
Recent ONTAP versions return NFS4ERR_STALE_CLIENTID which is handled
correctly.

The patch changes handling of NFS4ERR_EXPIRED error to also try to recover.

The issue can be triggered by exporting over NFSv4 a filesystem with a
sub-filesystem,
for example by exporting / and /var (assuming /var is a separate
filesystem).

How to reproduce the issue:

On an NFS server run:

# cat /etc/exports
/ *(rw,sync)
/var *(rw,sync)


On a Linux NFS client:

# mount -o vers=4 10.50.2.59:/ /mnt/3

$ date; strace -t -e trace=open head /mnt/3/var/log/vmware-vmsvc.log
>/dev/null
Mon 16 Dec 17:28:45 GMT 2019
...
17:28:45 open("/mnt/3/var/log/vmware-vmsvc.log", O_RDONLY) = 3
...


Now, on the NFS client run:

# while [ 1 ]; do date; umount /mnt/3/var; ls /mnt/3/var >/dev/null; sleep
10; done
...

Because of another bug (see email with subject: [PATCH] NFSv4:
nfs4_do_fsinfo() should not do implicit lease renewals)
the above while loop will prevent the NFS client from sending RENEW
operations to server as it currently assumes an implicit
lease renewal which I believe is not compliant with the RFC. If you now wait
long enough for the NFS server to expire the lease,
and then try to open a file (with no other NFS activity) it should result in
server sending NFS4ERR_EXPIRED and the NFS LINUX client
will return EIO to an application as shown above.


This also gets triggered if a sub-mount in automatically unmounted after
nfs_mountpoint_expiry_timeout, then shortly after there is some
access to it which will trigger for it to be automatically mounted again
which will delay the client in sending the RENEW operation.
This results  in a short window during which open() will return EIO to any
files from the file server.

This was tested with 5.5.0-rc2 and the provided patch is applied on top of
the 5.5.0-rc2 as well.


Best regards,
 Robert Milkowski

