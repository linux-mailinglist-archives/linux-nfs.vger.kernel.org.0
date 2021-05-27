Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534853935FD
	for <lists+linux-nfs@lfdr.de>; Thu, 27 May 2021 21:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhE0TMk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 May 2021 15:12:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34888 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229878AbhE0TMk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 May 2021 15:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622142666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kref+Va4rv9AcQ2+Qepfa1gg7J0b1mJxUn9dSTBecVM=;
        b=Irq10VcuSjCUUOO2esYO3XcE5kiA3ngoWWGno8oYNsLrXfyJCWCuVHvXiJSU89AElJfmDW
        jKLkrh92/WNadhdPRKAD0QVCbX6fCoJhWhfZDFCworDWOmPRMDwJQ2meJocCVTjdrci+Td
        kJHizCYcpHT5vlfdRA8eW0B1m08PNGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-UbibPBqKO5uYYcT6IPQvIw-1; Thu, 27 May 2021 15:11:04 -0400
X-MC-Unique: UbibPBqKO5uYYcT6IPQvIw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95FF6195D562
        for <linux-nfs@vger.kernel.org>; Thu, 27 May 2021 19:11:03 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-114-18.rdu2.redhat.com [10.10.114.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78AAE5D764
        for <linux-nfs@vger.kernel.org>; Thu, 27 May 2021 19:11:03 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id B01E91A003D; Thu, 27 May 2021 15:11:02 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH v3 0/2] Two rpc.gssd improvements
Date:   Thu, 27 May 2021 15:11:00 -0400
Message-Id: <20210527191102.590275-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Changes since v2:

- Cancellation of timed-out upcall threads is no longer the default.

Changes since v1:

- Replaced the upcall_thread_info.cancelled field with a flags field,
  to facilitate having the watchdog thread print an error message only
  once for each timed-out upcall thread.
- Removed the "created thread id" log message.
- Added missing break when parsing the "-C" option.
- Added some comments.

These patches provide the following improvements for rpc.gssd:
1) deal with failed thread creation
2) add a timeout for upcall threads

Both of these issues can leave kernel mount processes hanging
indefinitely.  A timeout was originally proposed in the kernel
(https://lore.kernel.org/linux-nfs/20180618172542.45519-1-steved@redhat.com/)
but this approach was rejected by Trond:

    I'm saying that we can do this entirely in userland without any kernel
    changes. As long as that hasn't been attempted and proven to be flawed,
    then there is no reason to accept any kernel patches.

So this is my attempt at doing the timeout in userland.

The first patch was tested using a program that intercepts clone() and
changes the return code to -EAGAIN.

For the second patch, I have two different tests I've been running:

1) In an IPA domain in our lab, I have a server running 100 kerberized
nfsd containers.  The client has mountpoints to all 100 of those servers
defined in its /etc/fstab.  I run 'systemctl start remote-fs.target' to
kick off all those mounts in parallel, while running the following
systemtap script to periodically mess with the mount processes:

---8<---
global i

probe begin { i=0 }

probe process("/lib64/libgssapi_krb5.so.2").function("gss_acquire_cred")
{
        if (++i % 100 == 0) {
                printf("delay (i=%d)\n", i)
                mdelay(30000)
        }
}
---8<---

I actually run the test in a loop... the driver script looks like this:

---8<---
#!/bin/bash
let i=1
while :; do
        echo "Round $i"
        echo "Mounting"
        systemctl start remote-fs.target
        echo -n "Waiting on mount.nfs processes to complete "
        while pgrep mount.nfs >/dev/null; do
                echo -n "."
                sleep 1
        done
        echo -e "\nNumber of nfs4 mounts: $(grep -c nfs4 /proc/mounts)"
        echo -e "Unmounting"
        umount -a -t nfs4
        if ! pgrep gssd >/dev/null; then
                echo "gssd is not running - check for crash"
                break
        fi
        echo "Sleeping 5 seconds"
        sleep 5
        let i=$i+1
done
---8<---

2) In an AD environment in our lab, I added 1000 test users.  On a
client machine I have all those users run a script that writes to files
on a NetApp SVM and while that script is running I trigger a LIF
migration on the filer.  That forces all those users to establish new
creds with the SVM.

That test looks basically like this
# for i in `seq 1 1000`; do su - testuser$i -c "echo 'PASSWORD'|kinit"; done
# for i in `seq 1 1000`; do su - testuser$i -c "date >/mnt/t/tmp/testuser$i-testfile" & done
# for i in `seq 1 1000`; do su - testuser$i -c test.sh & done

where test.sh is a simple script that writes the date to a file in a
loop:

---8<---
#!/bin/bash
filename=/mnt/t/tmp/$(whoami)-testfile
for i in $(seq 1 300)
do
	date >$filename
	sleep 1
done
---8<---

While the test users are running the script I run one of the following
commands on the NetApp filer:

network interface migrate -vserver VSERVER -lif LIF -destination-node NODE
network interface revert -vserver VSERVER -lif LIF

-Scott


Scott Mayhew (2):
  gssd: deal with failed thread creation
  gssd: add timeout for upcall threads

 nfs.conf               |   2 +
 utils/gssd/gssd.c      | 256 +++++++++++++++++++++++-----------
 utils/gssd/gssd.h      |  29 +++-
 utils/gssd/gssd.man    |  31 ++++-
 utils/gssd/gssd_proc.c | 306 ++++++++++++++++++++++++++++++++++-------
 5 files changed, 491 insertions(+), 133 deletions(-)

-- 
2.30.2

