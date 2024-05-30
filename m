Return-Path: <linux-nfs+bounces-3496-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADB88D52E3
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 22:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD2BB23567
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 20:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D50555880;
	Thu, 30 May 2024 20:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stonybrook.edu header.i=@stonybrook.edu header.b="FRg5NTE6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0275C4D8BF
	for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 20:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717099757; cv=none; b=Qyg+RkmtCq8N1FmrMI8PN002TWJ0TA9l7wmNT5jnlPiB7dShkrXmQRWAY9h6H2IwmIzH9B/GDKuqE5U52m6Rmx3xkbAT6PMPmrptup0giY8CRrsSP5gNd647rLuSDLV0MwjUpYGs/TOpbfOnypD/nvOJ+jRt59A7lLYKa/D3xUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717099757; c=relaxed/simple;
	bh=uZdaZz6syMv7Ez0cmVQhuIgITFRVbCB3EKjLe5yewYk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UxMpSNipNIm0dNTiI2n6CrpPf9AzE4oWTwoUm8P+FiS60yj6E4oKd0Zn13COAf8Bfvc2dNxwUGZHLeBtizz9PipwIRwGPT5vldbKesdojYO0RDbXoOlwlokrm64d7bN8dtIutzt6kMgP/vtVCqm4H+S+zHryFyWKfscRe4TXKzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.stonybrook.edu; spf=pass smtp.mailfrom=cs.stonybrook.edu; dkim=pass (1024-bit key) header.d=stonybrook.edu header.i=@stonybrook.edu header.b=FRg5NTE6; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.stonybrook.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stonybrook.edu
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-df78acd5bb6so1340231276.3
        for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 13:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stonybrook.edu; s=sbu-gmail; t=1717099754; x=1717704554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SqL6eLScFNp1TWaafPvu08qjZwQmfXYTFBvcyvaocyY=;
        b=FRg5NTE6VxwdjMTkaAxgCKnPfB9v7zouhkB5gTJ5vDW8EvBeNWerblXng3VZ/J6JO4
         +hOBge9NrhbaQNp4DrftKn58rjluYIk7RAF8NTQm3zkhv63wtfOvxIxKlFHSgkjyPxFX
         jvFhn++ctKCb+4tNTOfY7ZmT357vLtTUvlDfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717099754; x=1717704554;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SqL6eLScFNp1TWaafPvu08qjZwQmfXYTFBvcyvaocyY=;
        b=X6xXN0PYLVVW0+A9zXm7unJarMMhORWfy3V06dHsykMNClw0wHPXkM93l2Zx3GUcWD
         UxVCBWbKn8vL2wwT2iT/iJxlTryvPDlLyB8KE50pJOvBLJuYwpvA/nJIBSingDqVqIWb
         j0dFBNnZVbbLjpq/7xABHWN0pmxxC8U34fqTzDG2HmuNkGEcKKBejqaR6g+G5p1/P+d7
         ItBgplK8TBxBk0vNZD84V/OaeOqVd8BqKOW5srJRUEzP5PZKdSqc5NmBvRL7w8YYWnTo
         s3NKiLdc2Hxp+vNegnxcqE1D2R8JkJ3ZUppQyfCA8M33kMsFOKEOeky+PL5Yi+I25A9o
         pQBw==
X-Gm-Message-State: AOJu0YyG4cppFlMcc4OimTAZuju/DfTlGT/qifKnm50oY+ZYlucZfWHb
	d46apqCy4QtEyldpumQOoC/tR4QIyMHmgMErx2/bK5wI8h0rd0YuM/NeNIt9HzwD3fVg4TkMWcv
	8FmoGZb3y+VvUQ/a+krGsMuHjAA+AKO3GqY3SWqxr9XF+1e48mKI=
X-Google-Smtp-Source: AGHT+IFrARtcFNLjrO+iTOXAGqskw6PdaRXB6RjX4sluWaJvEZD+21vEfCuoAlPt8NUd84NFMDlm6G4lei7NMYV7+lE=
X-Received: by 2002:a25:9347:0:b0:df7:955f:9ba4 with SMTP id
 3f1490d57ef6-dfa5a7db908mr3450844276.51.1717099753769; Thu, 30 May 2024
 13:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yifei Liu <yifeliu@cs.stonybrook.edu>
Date: Thu, 30 May 2024 16:09:03 -0400
Message-ID: <CABHrer2qzHZvcoSOfzHsJtwVRC97ygxs62ZTFaib0N2YpT4otg@mail.gmail.com>
Subject: Inquiry about unmounting issues in Linux kernel NFS
To: linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com, 
	anna@kernel.org
Cc: Gautam Ahuja <gaahuja@cs.stonybrook.edu>, Erez Zadok <ezk@cs.stonybrook.edu>, 
	Geoff Kuenning <geoff@cs.hmc.edu>, Scott Smolka <sas@cs.stonybrook.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

I am Yifei Liu, a student at Stony Brook University working on a
project - Metis, which uses model checking to test file systems.  A
part of our testing involves mounting the file system, performing an
operation, validating the system state, and then unmounting it.   I've
noticed an inconsistency in NFSv3 and NFSv4 on the Linux kernel v5.15
and v6.3.0 running Ubuntu 22.04: sometimes unmounting the underlying
server file system after unexport takes 25-35 seconds due to the
device being busy (EBUSY), while other times it's nearly instant.
This happens using any of Ext4, BtrFS, or XFS as the underlying file
system for NFS.

Here is the process I followed:

1. Mount underlying server filesystem:
1a) Run mkfs.ext4 on a 256KiB brd ramdisk or a regular disk partition
1b) Mount ext4 on /mnt/server

2. Export the file system: exportfs -o rw,sync,no_root_squash
localhost:/mnt/server

3. Mount NFS at client: mount -t nfs -o rw,nolock,vers=4,proto=tcp
localhost:/mnt/server /mnt/local

4. Unmount NFS at client: umount /mnt/local

5. Unexport the server file system: exportfs -u localhost:/mnt/server

6. Unmount underlying file system: umount /mnt/server (This sometimes
succeeds instantly, and sometimes is delayed by up to 30 seconds)

I have also embedded a shell script below that replicates this process
in a loop 10 times.  You are likely to encounter delayed unmounts most
of the time.  Is this behavior expected, or are there some other steps
I am missing?

#!/bin/bash

# This script is used to reproduce busy unmount issue in NFSv4 and NFSv3
# where the NFS server and client are on the same machine

# Pre-defined variables, note that the server and local mount points
will be recreated
# Make sure the ramdisk device and directories are not used by other
processes or file systems
SERVER_MNT_DIR="/mnt/server"
LOCAL_MNT_DIR="/mnt/local"
EXT4_RAMDISK="/dev/ram0"
SLEEP_SECONDS=5

# Set up device and mount points
setup() {
    # Load brd ramdisk kernel module
    if lsmod | grep -q "^brd"; then
        echo "brd module is loaded. Unloading it now."
        if rmmod brd; then
            echo "Successfully removed brd module."
        else
            echo "Failed to remove brd module."
            exit 1
        fi
    fi

    # Load brd module with 256 KiB ramdisk size
    if modprobe brd rd_size=256; then
        echo "Successfully loaded brd module."
    else
        echo "Failed to load brd module."
        exit 1
    fi

    # Check if the mount point is already mounted, unmount it
    if test -n "$(mount | grep $SERVER_MNT_DIR)" ; then
        umount $SERVER_MNT_DIR || exit $?
    fi

    # Check if the mount point is already mounted, unmount it
    if test -n "$(mount | grep $LOCAL_MNT_DIR)" ; then
        umount $LOCAL_MNT_DIR || exit $?
    fi

    # Remove mount point if not created, and create it again
    if test -d $SERVER_MNT_DIR ; then
        rm -rf $SERVER_MNT_DIR
    fi

    # Remove mount point if not created, and create it again
    if test -d $LOCAL_MNT_DIR ; then
        rm -rf $LOCAL_MNT_DIR
    fi

    # Create mount points and set permissions
    mkdir -p $SERVER_MNT_DIR || { echo "Failed to create directory
$SERVER_MNT_DIR"; exit $?; }
    mkdir -p $LOCAL_MNT_DIR || { echo "Failed to create directory
$LOCAL_MNT_DIR"; exit $?; }
    chmod 755 $SERVER_MNT_DIR || { echo "Failed to set permissions for
$SERVER_MNT_DIR"; exit $?; }
    chmod 755 $LOCAL_MNT_DIR || { echo "Failed to set permissions for
$LOCAL_MNT_DIR"; exit $?; }

    # Check if NFS kernel server is running, start it if not
    if systemctl is-active --quiet nfs-kernel-server; then
        echo "NFS kernel server is already running."
    else
        echo "Starting NFS kernel server..."
        systemctl start nfs-kernel-server
        # Sleep for a while to make sure the NFS server is started
        sleep 20
        echo "NFS kernel server started."
    fi

    # Create ext4 file system on ramdisk for the NFS server export path
    MKFS_FLAGS="-F -v -E lazy_itable_init=0,lazy_journal_init=0"
    mkfs.ext4 ${MKFS_FLAGS} $EXT4_RAMDISK || exit $?
}

# Run the setup function
setup

# Loop 10 times to reproduce the unmount EBUSY issue
loop_max=10

for ((i=1; i<=$loop_max; i++)); do
    echo " ---------- Loop ID: $i ---------- "

    mount -t ext4 $EXT4_RAMDISK $SERVER_MNT_DIR || exit $?

    exportfs -o rw,sync,no_root_squash localhost:$SERVER_MNT_DIR || exit $?
    # Mount with NFSv4 or NFSv3
    mount -t nfs -o rw,nolock,vers=4,proto=tcp
localhost:$SERVER_MNT_DIR $LOCAL_MNT_DIR || exit $?

    date > $LOCAL_MNT_DIR/date.txt || exit $?

    umount $LOCAL_MNT_DIR || exit $?
    exportfs -u localhost:$SERVER_MNT_DIR || exit $?

    # Try to unmount, if EBUSY, sleep for 5 seconds and try again
    total_sleep=0
    while true; do
        # Expected to have "target is busy" error here
        umount $SERVER_MNT_DIR

        if [ $? -eq 0 ]; then
            echo "Unmount succeeded with $total_sleep seconds of sleep."
            break
        else
            echo "Unmount failed, sleeping for 5 seconds..."
            total_sleep=$((total_sleep+SLEEP_SECONDS))
            sleep $SLEEP_SECONDS
        fi
    done

done

Thank you for your time and help,

Yifei Liu
File Systems and Storage Lab (FSL)
Department of Computer Science
Stony Brook University

