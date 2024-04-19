Return-Path: <linux-nfs+bounces-2895-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50F08AB182
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Apr 2024 17:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D879A1C22C60
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Apr 2024 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA19112F599;
	Fri, 19 Apr 2024 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="PsdLMMyc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DA912F58B
	for <linux-nfs@vger.kernel.org>; Fri, 19 Apr 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539725; cv=none; b=lrQyxaPpV5r92vVuIOGimpHD3PRiMJHZCiv3ohosZIbd7oBNOIt1HU2XrGtF9wjD+q4y2muRM/RryOLS/HkNzvolEO3ZRw3dogJ+vv+SUDQhrH18arlVKrvkm8Gd1BcW5dNBYdF9P64pTh3r6cxAzOjx69baOLAiZgF2T2Oe/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539725; c=relaxed/simple;
	bh=mgd/YJEhY6gDZNrGQd6vAVIbNqQ7w+RLaH8V/teIbVo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qtU+Q7CE/B2skLSIGzQlbykaG6k/2IlPpygzuSuUxlDizQEKyTMkQqdzGfvrX/SYGdpDo+Rlpi25zSA8s2r2cGWcIiN9f+5WG7H50sUiB6VCzszjHxJVQbw/Ngnwo/SAj8FFWA1qNh/7Ztbd8JjPF72+GS5Okb2ZfrVMhWz91G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=PsdLMMyc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e5715a9ebdso18322795ad.2
        for <linux-nfs@vger.kernel.org>; Fri, 19 Apr 2024 08:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1713539723; x=1714144523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rUWoYmrGRrSzpOH112x4D3kNDZG2oo+mn/c3wg7soEw=;
        b=PsdLMMyca4/GQIeyHCPORFEaYLUI3VsurnWCWJKcZhtDs+vLd6GiuPOnEBSv5nIMFr
         h/VhPBVmqsOMj0iyiH2lUEm1jGRaV+sNFffSmccRM9KsNWn84bzQEAWJjEzfDWewXAxe
         VyNwryHxN2wMJtDQ61vfMb3n8rEg0CVqz4ppXbHICK2mq/mpHq1vI+H/+2/GTdzBkatZ
         r2RZYwUZ0BTP6dQhOy8K97FpcywLeCHUdd3/IbMVa8V8Lb78RzPvmq4Dhumac0P7rJ6q
         zB4ax8fw3BehoCASUJtOtZ3qSaQcKpY8RthymylxKwA1cmN+alJFvx8WNcP6ClijiA9y
         0VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713539723; x=1714144523;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rUWoYmrGRrSzpOH112x4D3kNDZG2oo+mn/c3wg7soEw=;
        b=jXyfbS/D7pqRGDd8rFJxcWESAkzJWVi7oKfeE6+jo2uMFJMch4eQcU3CpCWdRFT6/H
         FCvoC5VUZRfJKCg8f9bfNJXHHPXCIZl3mxNt/jS6yN5erJv1Nji+GE/UmYkHDxYP+fQ7
         FQnqMcLZVtxur5dopETcnBg3++yP2hcTqbBGinHrZ3psleHuDgmA1Wq41zTu8Ii4wB2u
         eTYX4/8Lz6L8xu33nCk6hfQ5ExW3am6Zt2MqE3/6TIxfXHPldq841l3JygjHAXXl9xUU
         uYgiL8I0qNoAL6PHqeNcsa4KX80dH2kqKErl1owpbBCV7oAkoxK5GkeN2p1ISZxueWlA
         joYg==
X-Gm-Message-State: AOJu0YzJab+EHUUY8FuyHbLtOyvWNB0teLZicSPtpg644m0RpcmXdc15
	ozG+/lsduRiz2AO3Cl0qI+2PB5FWbeZNEUnI/iM5oqaOr0R68qP84JyDFwKLPiU=
X-Google-Smtp-Source: AGHT+IHRqpXOF/91kLaulfGXCdUQHpulmLjLTOStNsQ/N3Zddq4CBp9weUYatWvv3rJ3tIcbrABGOA==
X-Received: by 2002:a17:902:7489:b0:1e5:5be7:be86 with SMTP id h9-20020a170902748900b001e55be7be86mr2463735pll.52.1713539723009;
        Fri, 19 Apr 2024 08:15:23 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902680b00b001dc05535632sm3519376plk.170.2024.04.19.08.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:15:22 -0700 (PDT)
Date: Fri, 19 Apr 2024 08:15:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: chuck.lever@oracle.com, trond.myklebust@hammerspace.com,
 anna@kernel.org, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
 Dai.Ngo@oracle.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org
Subject: Fw: [Bug 218743] New: NFS-RDMA-Connected Regression Found on
 Upstream Linux 6.9-rc1
Message-ID: <20240419081520.57bf66c1@hermes.local>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I forward networking bugs to the maintainers.
Netdev does not use bugzilla, not sure if NFS does.

Begin forwarded message:

Date: Thu, 18 Apr 2024 00:00:22 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 218743] New: NFS-RDMA-Connected Regression Found on Upstream Linux 6.9-rc1


https://bugzilla.kernel.org/show_bug.cgi?id=218743

            Bug ID: 218743
           Summary: NFS-RDMA-Connected Regression Found on Upstream Linux
                    6.9-rc1
           Product: Networking
           Version: 2.5
    Kernel Version: 6.9-rc1
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: manuel.gomez@cornelisnetworks.com
                CC: dennis.dalessandro@cornelisnetworks.com
        Regression: Yes
           Bisected e084ee673c77cade06ab4c2e36b5624c82608b8c
         commit-id:

On the Linux 6.9-rc1 kernel there is a performance regression for NFS file
transfers when Connected IPoIB mode is enabled. The network switch is OPA
(Omnipath Architecture).

The most recent good commit in my bisection was the v6.8 mainline kernel
(e8f897f4afef0031fe618a8e94127a0934896aba). Bisecting from v6.8 to v6.9-rc1
showed me that "[e084ee673c77cade06ab4c2e36b5624c82608b8c] svcrdma: Add Write
chunk WRs to the RPC's Send WR chain" was indeed the culprit of the regression.


Here are the steps I ran to reproduce the issue:
1. Establish IPoIB Connected Mode on both client and host nodes:
"echo connected > /sys/class/net/ibs785/mode"


2. Start an NFS server on the host node:
"systemctl start opafm
sleep 10
systemctl start nfs-server
modprobe svcrdma
echo "rdma 20049" > /proc/fs/nfsd/portlist
mkdir -p /mnt/nfs_test
mount -t tmpfs -o size=4096M tmpfs /mnt/nfs_test
sudo exportfs -o fsid=0,rw,async,insecure,no_root_squash
192.168.2.0/255.255.255.0:/mnt/nfs_test_testrun/"


3. Ready the client node:
"mkdir -p /mnt/nfs_test
mount -o rdma,port=20049 192.168.2.1:/mnt/nfs_test_testrun
/mnt/nfs_test_testrun/"


4. Run the actual test from the client node:
"
#!/bin/bash

fsize=268435456
jfile=/dev/shm/run_nfs_test2.junk
tfile=/dev/shm/run_nfs_test2.tmp
nfsfile=/mnt/nfs_test_testrun/run_nfs_test2.junk
rm -r -f /mnt/nfs_test_testrun/
rm -f ${tfile}
rm -f ${jfile}

dd if=/dev/urandom iflag=fullblock of=${jfile} bs=1024 count=$((fsize/1024));

for i in {1..100}; do
          cp ${jfile} ${nfsfile}; # Bottleneck 1

          cp ${nfsfile} ${tfile}; # Bottleneck 2

         cmp ${jfile} ${tfile};

          rm -f ${tfile};
        echo "DONE with iter ${i}"
done;

rm -f ${jfile};
rm -f ${tfile};
echo "Done";
"


On v6.8 I was seeing this test taking about 1m50s to complete, for all 10
iterations. On v6.9-rc1 it takes 3-7 minutes, and I also see these kernel
traces printed continuously in dmesg during this regression:

[23720.243905] INFO: task kworker/61:1:556 blocked for more than 122 seconds.
[23720.251709]       Not tainted 6.9.0-rc1 #1
[23720.256387] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.
[23720.265268] task:kworker/61:1    state:D stack:0     pid:556   tgid:556  
ppid:2      flags:0x00004000
[23720.275822] Workqueue: events __svc_rdma_free [rpcrdma]
[23720.281803] Call Trace:
[23720.284630]  <TASK>
[23720.287067]  __schedule+0x210/0x660
[23720.291063]  schedule+0x2c/0xb0
[23720.294668]  schedule_timeout+0x146/0x160
[23720.299249]  __wait_for_common+0x92/0x1d0
[23720.303828]  ? __pfx_schedule_timeout+0x10/0x10
[23720.308987]  __ib_drain_sq+0xfa/0x170 [ib_core]
[23720.314190]  ? __pfx_ib_drain_qp_done+0x10/0x10 [ib_core]
[23720.320343]  ib_drain_qp+0x71/0x80 [ib_core]
[23720.325232]  __svc_rdma_free+0x28/0x100 [rpcrdma]
[23720.330604]  process_one_work+0x196/0x3d0
[23720.335185]  worker_thread+0x2fc/0x410
[23720.339470]  ? __pfx_worker_thread+0x10/0x10
[23720.344336]  kthread+0xdf/0x110
[23720.347941]  ? __pfx_kthread+0x10/0x10
[23720.352225]  ret_from_fork+0x30/0x50
[23720.356317]  ? __pfx_kthread+0x10/0x10
[23720.360602]  ret_from_fork_asm+0x1a/0x30
[23720.365083]  </TASK>

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

