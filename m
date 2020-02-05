Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 124BF152675
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2020 07:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgBEGwd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Feb 2020 01:52:33 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50]:40133 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgBEGwd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Feb 2020 01:52:33 -0500
Received: by mail-pj1-f50.google.com with SMTP id 12so561449pjb.5;
        Tue, 04 Feb 2020 22:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6PJHyHSz05S8+8S3GVaSFvF3XnJ43EL/bKHV993LL5w=;
        b=QEJT3j1riOMafr7jFCTWJyNtCjqWdJsiZqfjmmjYJvgF7xwlgagHsB0CriMBprmzSl
         tlNt9k7ehjzz9TpM0s3sxzhef2sVHEMaR/nACctgDQFn4SjfFaTlt/viAnXOXpQPLcKZ
         jhxiUemoSaapg5O1lScWQ+artD410k2z6Ol8k7cRKelubUFchxXKqAlFcZQE7vQ8QO3Y
         YClrnWEOrwzlU+UPmO3rLUVT4H/9dOJqwMot8dfnqy0Klwx1m0JURiw9dPfdmss50GOG
         PsBlUYInWFUdNIMwoT6RG5Iw6UHGULlgM4w5DlZV1G1A9IkQ5dY43CXIW2k2wmJVNb+q
         YCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6PJHyHSz05S8+8S3GVaSFvF3XnJ43EL/bKHV993LL5w=;
        b=iQUgLwjpp4XKPG4PEeWbdER+cQi2FPw1+QxnhgA9pVLQqrC2kjmfNUOEA4ndWzaBEV
         EDQmqdvrmT7CLt4+rFuhRZX6D08q3U0as/7ITE20H6XAazipR14Q+zlrgMqoQ/Ocqzph
         AA8Wg4jJ94JAufRIIoXW67xuGJC8JNqYnQ0fR/seq0xNfxz/FicniysGMJ+bhsjVGOXB
         UmhEvakp8yRRcYRlweqMn8iH1YqBDSdWQ7sXaZbp+xB0ZklMXwecPPZObrUWbhPfvZfa
         FEfuMG/Hh3Qo7juhKR7ww5QB6R0ADUNkNcMBQC9Yw9z8dQtq3O+0c0WpI+twTDC6p/S0
         QYwA==
X-Gm-Message-State: APjAAAWYaVhBV+ykS/3x+a3i0UvPYz9OtY4UGZIjF1noxD3wGtf3c8WY
        RkFTtxLzLYBnKptR1UIdOfo=
X-Google-Smtp-Source: APXvYqy+lSHkOEXRWAr3Fw/1tiK4y+gg9TVwymj7RLzvqbDNuSSrNlLytW0PSiCLqT7XkRaEr1pyMA==
X-Received: by 2002:a17:902:ac88:: with SMTP id h8mr33297833plr.131.1580885552075;
        Tue, 04 Feb 2020 22:52:32 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a13sm27901022pfg.65.2020.02.04.22.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 22:52:31 -0800 (PST)
Date:   Wed, 5 Feb 2020 14:52:24 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: A NFS, xfs, reflink and rmapbt story
Message-ID: <20200205065224.slfdmnka7avcyzrl@xzhoux.usersys.redhat.com>
References: <20200123083217.flkl6tkyr4b7zwuk@xzhoux.usersys.redhat.com>
 <20200124011019.GA8247@magnolia>
 <20200127235617.GB18610@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200127235617.GB18610@dread.disaster.area>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 28, 2020 at 10:56:17AM +1100, Dave Chinner wrote:
> On Thu, Jan 23, 2020 at 05:10:19PM -0800, Darrick J. Wong wrote:
> > On Thu, Jan 23, 2020 at 04:32:17PM +0800, Murphy Zhou wrote:
> > > Hi,
> > > 
> > > Deleting the files left by generic/175 costs too much time when testing
> > > on NFSv4.2 exporting xfs with rmapbt=1.
> > > 
> > > "./check -nfs generic/175 generic/176" should reproduce it.
> > > 
> > > My test bed is a 16c8G vm.
> > 
> > What kind of storage?

Loop device in guest.

# Host:

[root@ibm-x3850x5-03]$ lsblk
NAME                            MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                               8:0    0  2.7T  0 disk
├─sda1                            8:1    0    1M  0 part
├─sda2                            8:2    0    1G  0 part /boot
└─sda3                            8:3    0  2.7T  0 part
  ├─rhel_ibm--x3850x5--03-root  253:0    0  550G  0 lvm  /
  ├─rhel_ibm--x3850x5--03-swap  253:1    0 27.6G  0 lvm  [SWAP]
  ├─rhel_ibm--x3850x5--03-home  253:2    0  1.7T  0 lvm  /home
  ├─rhel_ibm--x3850x5--03-test1 253:3    0   10G  0 lvm
  └─rhel_ibm--x3850x5--03-test2 253:4    0   10G  0 lvm
loop0                             7:0    0    1G  0 loop
loop1                             7:1    0    1G  0 loop
[root@ibm-x3850x5-03]$ smartctl -a /dev/sda
smartctl 7.0 2018-12-30 r4883 [x86_64-linux-3.10.0-1115.el7.x86_64]
(local build)
Copyright (C) 2002-18, Bruce Allen, Christian Franke,
www.smartmontools.org

=== START OF INFORMATION SECTION ===
Vendor:               IBM
Product:              ServeRAID M5015
Revision:             2.13
Compliance:           SPC-3
User Capacity:        2,996,997,980,160 bytes [2.99 TB]
Logical block size:   512 bytes
Logical Unit id:      0x600605b001665aa019cb17be1e9ce991
Serial number:        0091e99c1ebe17cb19a05a6601b00506
Device type:          disk
Local Time is:        Wed Feb  5 14:35:57 2020 CST
SMART support is:     Unavailable - device lacks SMART capability.

=== START OF READ SMART DATA SECTION ===
Current Drive Temperature:     0 C
Drive Trip Temperature:        0 C

Error Counter logging not supported

Device does not support Self Test logging
[root@ibm-x3850x5-03]$ virsh domblklist 8u
Target     Source
------------------------------------------------
hda        /home/8u.qcow2
hdb        /home/8ut.qcow2
hdc        /home/8ut1.qcow2

[root@ibm-x3850x5-03]$

# Guest:

[root@8u]$ lsblk
NAME          MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda             8:0    0  800G  0 disk
├─sda1          8:1    0    2G  0 part
│ └─rhel-swap 253:0    0    2G  0 lvm  [SWAP]
└─sda2          8:2    0  798G  0 part /
sdb             8:16   0  200G  0 disk /home
sdc             8:32   0  100G  0 disk
├─sdc1          8:33   0   50G  0 part
└─sdc2          8:34   0   50G  0 part
pmem0         259:0    0    5G  0 disk
[root@8u]$ smartctl -a /dev/sdb
smartctl 6.6 2017-11-05 r4594 [x86_64-linux-5.5.0-v5.5-9386-g33b4013]
(local build)
Copyright (C) 2002-17, Bruce Allen, Christian Franke,
www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     QEMU HARDDISK
Serial Number:    QM00003
Firmware Version: 1.5.3
User Capacity:    214,748,364,800 bytes [214 GB]
Sector Size:      512 bytes logical/physical
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ATA/ATAPI-7, ATA/ATAPI-5 published, ANSI NCITS
340-2000
Local Time is:    Wed Feb  5 14:39:18 2020 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82)	Offline data collection activity
					was completed without error.
					Auto Offline Data Collection:
Enabled.
Self-test execution status:      (   0)	The previous self-test routine
completed
					without error or no self-test
has ever
					been run.
Total time to complete Offline
data collection: 		(  288) seconds.
Offline data collection
capabilities: 			 (0x19) SMART execute Offline immediate.
					No Auto Offline data collection
support.
					Suspend Offline collection upon
new
					command.
					Offline surface scan supported.
					Self-test supported.
					No Conveyance Self-test
supported.
					No Selective Self-test
supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					No General Purpose Logging
support.
Short self-test routine
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 (  54) minutes.

SMART Attributes Data Structure revision number: 1
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x0003   100   100   006    Pre-fail  Always
-       0
  3 Spin_Up_Time            0x0003   100   100   000    Pre-fail  Always
-       16
  4 Start_Stop_Count        0x0002   100   100   020    Old_age   Always
-       100
  5 Reallocated_Sector_Ct   0x0003   100   100   036    Pre-fail  Always
-       0
  9 Power_On_Hours          0x0003   100   100   000    Pre-fail  Always
-       1
 12 Power_Cycle_Count       0x0003   100   100   000    Pre-fail  Always
-       0
190 Airflow_Temperature_Cel 0x0003   069   069   050    Pre-fail  Always
-       31 (Min/Max 31/31)

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
No self-tests have been logged.  [To run self-tests, use: smartctl -t]

Selective Self-tests/Logging not supported

[root@8u]$

> 
> Is the NFS server the same machine as what the local XFS tests were
> run on?

Yes. It's also reproducible whening testing on remote NFS mounts.

> 
> > > NFSv4.2  rmapbt=1   24h+
> > 
> > <URK> Wow.  I wonder what about NFS makes us so slow now?  Synchronous
> > transactions on the inactivation?  (speculates wildly at the end of the
> > workday)
> 
> Doubt it - NFS server uses ->commit_metadata after the async
> operation to ensure that it is completed and on stable storage, so
> the truncate on inactivation should run at pretty much the same
> speed as on a local filesystem as it's still all async commits. i.e.
> the only difference on the NFS server is the log force that follows
> the inode inactivation...
> 
> > I'll have a look in the morning.  It might take me a while to remember
> > how to set up NFS42 :)
> > 
> > --D
> > 
> > > NFSv4.2  rmapbt=0   1h-2h
> > > xfs      rmapbt=1   10m+
> > > 
> > > At first I thought it hung, turns out it was just slow when deleting
> > > 2 massive reflined files.
> 
> Both tests run on the scratch device, so I don't see where there is
> a large file unlink in either of these tests.
> 
> In which case, I'd expect that all the time is consumed in
> generic/176 running punch_alternating to create a million extents
> as that will effectively run a synchronous server-side hole punch
> half a million times.

I've tracked this down. Time was consumed in "rm -rf" in _scratch_mkfs
of generic/176. Thread https://www.spinics.net/lists/fstests/msg13316.html

Thanks,
Murphy

> 
> However, I'm guessing that the server side filesystem has a very
> small log and is on spinning rust, hence the ->commit_metadata log
> forces are preventing in-memory aggregation of modifications. This
> results in the working set of metadata not fitting in the log and so
> each new hole punch transaction ends up waiting on log tail pushing
> (i.e. metadata writeback IO).  i.e. it's thrashing the disk, and
> that's why it is slow.....
> 
> Storage details, please!
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
