Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C92934699A
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 21:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhCWUJU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 16:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhCWUJQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Mar 2021 16:09:16 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BAEC061574
        for <linux-nfs@vger.kernel.org>; Tue, 23 Mar 2021 13:09:16 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b4so4585990lfi.6
        for <linux-nfs@vger.kernel.org>; Tue, 23 Mar 2021 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Z+VSUun7UW8wI5cY9MF29WsXwPI9fW+U4LbQ5d8Hk0w=;
        b=WpFACYjbs3wcHAjDq5LEbotNXK7hohiHc+BnMCiPApXodhibpuFogUJ45Dfm5peFil
         18HPmDZIVgnS37BHCuNcLsV2qFvgPR9MAXgqiqYx4tvJYniVi1kPywjOXPZo6+VgA/d6
         OXBDfuknJY1YmaXy/hHJi+k6u/nMm4IHxOIm85mWI0AqHtFOGlBmyrsCBdkgr+ueRUmU
         zZDq9M3WuN7QpcO8c3rq8WJQKLvdvHmr7bSlo0p4Xna4fICOyixEoJf8c2DCFAaQy2mM
         OgIqut+MqswgGPflWaaZxE7wd8E0QVoDcF7SfhpqM/PstRlLhIQYWriROaT00A8atwqr
         p7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Z+VSUun7UW8wI5cY9MF29WsXwPI9fW+U4LbQ5d8Hk0w=;
        b=ddq3E7ikkLPVu4wOHd7HPEwuumwR3EA8Cpo0HgmlZC/HRipw1DXm0IK0V5KdxZHK5L
         xq2Oi3YwxWdwLDVsqC+p6YSOoZv5d5npHTtJIstCv+vRmYpciJF5hq96upues4ixgmUg
         zR9fGi8NODyYrb3xmMARn58+TH9QvmSG7abjhvpu/ecAN4t2DAmQUA4HCPIP0iVtbLtp
         EuJYTxk1vuuSxmm9FOi9mB0qAG/yxvMAqx9vj4S25BE5nm/CLr0cV7d+QpxK8f+exCjA
         T/vygq1u9t4mlK5mzD0om5GecO2AxuGmqgPJ6gfbL1wwutMzghfbEVNGJ+aoZjTKJTHd
         ocIQ==
X-Gm-Message-State: AOAM533N7kIvuMZmt0rWtrV4PC2+3blYZjgg0mlxosoobS4LxFAdMUDl
        eiJYFiGR60Vgj5B49/7xDOLdq2OORZV+QtnHT203U+F/a+2/Qojd
X-Google-Smtp-Source: ABdhPJws4b0EwIJW00FQyc+5wXmV6YgnaKOqmUrfV0z08yxMwQrbBEMewROeSXCWNdezJmIPyufF1h4p/9HYzPgTCIw=
X-Received: by 2002:a19:c20e:: with SMTP id l14mr3277309lfc.402.1616530154279;
 Tue, 23 Mar 2021 13:09:14 -0700 (PDT)
MIME-Version: 1.0
From:   Benjamin Maynard <benmaynard@google.com>
Date:   Tue, 23 Mar 2021 20:08:38 +0000
Message-ID: <CA+QRt4vr+CUgP-4xkVQwLWNZMHo-w6TwU8bFwzuZcUc1RPi-RA@mail.gmail.com>
Subject: Input/output errors when mounting re-exported directories that use crossmounts
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linux NFS Mailing List,

Please excuse any incorrect terminology - I'm not an expert in this
space but am learning :).

I have recently been experimenting with NFS re-exporting in the 5.11
kernel and have come across an interesting quirk when re-exporting a
directory that has subdirectories on different filesystems. I'll do my
best to give a concise overview of my setup and the issue I am seeing
below.

I'll use the following terms to describe the components from here on out:

Source NFS Filer: Refers to the originating NFS Server that contains
the exports that we want to re-export (Ubuntu 20.04.2 /
5.4.0-1038-gcp).
Re-exporting NFS Filer: Refers to the NFS Server that is mounting and
re-exporting the Source NFS Filer (Ubuntu 20.10 /
5.11.0-051100-generic).
NFS Client: Refers to the server that is mounting the re-exported
directories on the Re-exporting NFS Filer (Ubuntu 18.04 /
5.4.0-1036-gcp).

(Source NFS Filer <-- Re-exporting NFS Filer <-- NFS Client)

---
Source NFS Filer:

The source NFS Filer consists of two directories that are each mounted
to filesystems on different disks:

root@demo-nfs-filer-kernel-community:/home/benmaynard# lsblk
NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
sdb 8:16 0 100G 0 disk /files
sdc 8:32 0 100G 0 disk /files/disk2

The /files directory is then exported from the source filer, with the
crossmnt option set so that clients can move to the child filesystems:

root@demo-nfs-filer-kernel-community:/files# cat /etc/exports
/files 10.0.0.0/8(rw,wdelay,no_root_squash,no_subtree_check,fsid=10,sec=sys,rw,secure,no_root_squash,no_all_squash,crossmnt)

-- 
Re-exporting NFS Filer:

From the Re-exporting NFS Filer, I can then mount this exported directory:

root@reexport-server:/home/benmaynard# mount -t nfs -o vers=3,sync
10.67.10.54:/files /files

I am able to successfully list the contents of both the /files and
/files/disk2 directories:

root@reexport-server:/home/benmaynard# ls /files/
a_file disk2 lost+found

root@reexport-server:/home/benmaynard# ls /files/disk2/
b_file lost+found

Now time to re-export (using the same options as the Source NFS Filer
including crossmnt):

root@reexport-server:/home/benmaynard# cat /etc/exports
/files 10.0.0.0/8(rw,wdelay,no_root_squash,no_subtree_check,fsid=10,sec=sys,rw,secure,no_root_squash,no_all_squash,crossmnt)

--
NFS Client:

I now want to mount the re-exported directory from my NFS Client:
root@client-vm:/home/benmaynard# mount -t nfs -o vers=3,sync
10.67.10.51:/files /files

The mount completes successfully, but when listing the contents of the
directory I receive a Input/output error for the directory that is on
a different filesystem:

root@client-vm:/home/benmaynard# ls /files
ls: cannot access '/files/disk2': Input/output error
a_file disk2 lost+found


root@client-vm:/home/benmaynard# ls /files/disk2
ls: cannot access '/files/disk2': Input/output error

If I unmount and mount the Source NFS Filer directly, I am able to
read all of the files. The problem seems to be caused by the
re-export.

In my efforts to resolve this I tried a number of different options,
and the only way I was able to get things working was to explicitly
re-export the directories that are on different filesystems from the
Re-Exporting NFS Filer (Source NFS Filer exports and NFS Client mount
command remains unchanged):

root@reexport-server:/home/benmaynard# cat /etc/exports
/files 10.0.0.0/8(rw,wdelay,no_root_squash,no_subtree_check,fsid=10,sec=sys,rw,secure,no_root_squash,no_all_squash,crossmnt)
/files/disk2 10.0.0.0/8(rw,wdelay,no_root_squash,no_subtree_check,fsid=20,sec=sys,rw,secure,no_root_squash,no_all_squash,crossmnt)

With these export options I can successfully mount the Re-exporting
NFS filer and browse both directores:

root@client-vm:/home/benmaynard# mount -t nfs -o vers=3,sync
10.67.10.51:/files /files
root@client-vm:/home/benmaynard# ls /files
a_file disk2 lost+found
root@client-vm:/home/benmaynard# ls /files/disk2/
b_file lost+found

It appears as if the issue is something to do with the re-export, but
I am struggling to track down the actual cause.

This is causing some challenges as the source NFS filer that I am
using in production has 1000's of subdirectories on different volumes.
Manually re-exporting each of these from our re-export server is a
challenge.

I have a lab environment configured so happy to do some more testing
or run commands if it helps with troubleshooting.
