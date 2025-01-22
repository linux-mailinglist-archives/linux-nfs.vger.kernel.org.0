Return-Path: <linux-nfs+bounces-9456-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF62A18B27
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 05:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E59D3A61B5
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 04:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49FF1586CF;
	Wed, 22 Jan 2025 04:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=glanzmann.de header.i=@glanzmann.de header.b="lAyNaLwG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from infra.glanzmann.de (infra.glanzmann.de [88.198.237.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0E2158862
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 04:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.237.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737521521; cv=none; b=HqxS/y9Ke/+FzQS2ANhz/6/tI3EImvlg0l1DDeQ+28/OdSPHYGIKvWFYRq2ZASywgj6ERc0jUp4NM8Ts9/Ul9OICVB+vcT+YiSM1SxjiJWAKLEMzCo7z1NTHI7fF0iMqxwe4SJ30KTrPIj1guydMSdDvjLpSwoCcXVHgYOLIOXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737521521; c=relaxed/simple;
	bh=jz6qRPbfjNA9P9ZeS4PADiV96bIyv5ud2LBc+NbapGs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W7rIPaJce7BdnFd/2HTENb2uxSpLGpYYa1m9t0zb7Lr2j+VxhU7yEXTbgw0As+h+ECn12ab+owCmrGi/8+Go+Qwaw6CNV3vg8wjhbZNcZONCZYXfeq3S0EOXG/updZ1IYBsd/iZuUFkMmdWiF1ClcMVYBYhCWAfNL7WFBchVB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=glanzmann.de; spf=pass smtp.mailfrom=glanzmann.de; dkim=pass (4096-bit key) header.d=glanzmann.de header.i=@glanzmann.de header.b=lAyNaLwG; arc=none smtp.client-ip=88.198.237.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=glanzmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glanzmann.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glanzmann.de;
	s=infra26101010; t=1737521160;
	bh=yuoCmQ2S02MQUFf1tCjJhhdUAM133dOZpzwixKiBdbQ=;
	h=Date:From:To:Subject:From;
	b=lAyNaLwG7qp9PUFf1EkWowa8vGKPudoXcQ0bYKZQD5CFh3YLo48LK5PuApu6BWnvW
	 tpu6YxkngFtQmZqs6Y/Z19okg4Zr7kHZhk4n/55D7iFPk8qmIK9Eha0uRA8DnY/DiW
	 zv8rrj07J+yeWRigT6fonvjryBThudkuRzg/2wKH93x8an8o8pbZe2d0uKwvjua7ON
	 NwznX73CYlKiquw/u2EaNyMghc0shuV2LG6/j+4Y9AoKskbdr51xJX2LVQ5C47nd4a
	 1D26TQwYhLsKaS2Y1IrTnt/UFr7Q3tkJU/CGP1ba1zyJQw2a7qqQBIlJ7vUA1cQFQ1
	 3ZBqbCuUqOpm3GtRbhtmmRDD4WGqO8IYuX45a+3ciSc6VUXxyCt1eH/2L2yP+jvk+r
	 C/xfPP1ja0L6w3sK9ftcdSuAG1lFd8o1G2EIPySzhB+SK12BLuiexemLm+CvXHWYa7
	 P0OnISChmsMuFbf92ie+QdGmFEjzLKcLSetPObRyBzxFPovK17LYs2TgOEZQeH8Rnu
	 3MVfpI8enR8WLpYONHjliVOR6H+5HDBny/fqEJ/0LbejmgqbK+BoPeJNIEgnTXk+BQ
	 BlJgDXkmz3hlGqQRXb/CwjY8sBh7ob4eU5EChbyLG5VAsgEVtNZOSE9GSa5yFj+UNR
	 32Kc1RnYSQ+N+svhKzjTFGJs=
Received: by infra.glanzmann.de (Postfix, from userid 1000)
	id 4B85D7A800A5; Wed, 22 Jan 2025 05:46:00 +0100 (CET)
Date: Wed, 22 Jan 2025 05:46:00 +0100
From: Thomas Glanzmann <thomas@glanzmann.de>
To: linux-nfs@vger.kernel.org
Subject: NFS 4 Trunking load balancing and failover
Message-ID: <Z5B4CPZlNgobvwxu@glanzmann.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
we tried to use nconnect and link trunking to access a NetApp NFS file using a
Debian Linux Kernel 6.12.9 with the following commands:

mount -o nconnect=8,max_connect=16 10.0.10.48:/vol41 /mnt
mount -o nconnect=8,max_connect=16 10.0.20.48:/vol41 /mnt

root@debian-08:~# mount -o nconnect=8,max_connect=16 10.0.10.48:/vol41 /mnt
root@debian-08:~# mount -o nconnect=8,max_connect=16 10.0.20.48:/vol41 /mnt
root@debian-08:~# netstat -an | grep 2049
tcp        0      0 10.0.10.28:834          10.0.10.48:2049         ESTABLISHED
tcp        0      0 10.0.10.28:826          10.0.10.48:2049         ESTABLISHED
tcp        0      0 10.0.10.28:951          10.0.10.48:2049         ESTABLISHED
tcp        0      0 10.0.10.28:707          10.0.10.48:2049         ESTABLISHED
tcp        0      0 10.0.10.28:853          10.0.10.48:2049         ESTABLISHED
tcp        0      0 10.0.10.28:914          10.0.10.48:2049         ESTABLISHED
tcp        0      0 10.0.20.28:862          10.0.20.48:2049         ESTABLISHED
tcp        0      0 10.0.20.28:771          10.0.20.48:2049         TIME_WAIT
tcp        0      0 10.0.10.28:844          10.0.10.48:2049         ESTABLISHED
tcp        0      0 10.0.10.28:980          10.0.10.48:2049         ESTABLISHED

On the netapp you can see that the traffic is unequally distributed over the
two links:

n2 : 1/22/2025 04:38:58
                                  *Recv                  Sent
                         Recv      Data   Recv   Sent    Data   Sent Current
 LIF           Vserver Packet     (Bps) Errors Packet   (Bps) Errors    Port
---- ----------------- ------ --------- ------ ------ ------- ------ -------
nfs1 frontend-08-nfs41  26865 905471818      0  13786 1599403      0  e0e-10
nfs2 frontend-08-nfs41   3952 114124809      0   1737  201578      0  e0f-20

While that works, we noticed that to the first ip addresses 8 tcp
connections are established and to the second only one tcp connection is
established. When generating load we can see that the majority of the NFS
traffic goes to the first ip. Is there a way to have more TCP connections
established to the second ip?

Also we noticed that when we take the first server ip down, the NFS
sessions stalls. We hoped that the NFS client code transparently uses the
second ip address. Is that planned for the future?

I also tried the above with the VMware ESX hypervisor. And with the most
recent version 8.0 Update 3 C. The traffic is equally distributed
across the two links and when taking down one of two links, the I/O
continues.

Our Setup: We have a NetApp AFF A150. The controllers of the AFF A150
are connected using 2 10 Gbit/s links using two vlans to a Linux VM
which is also connected using two dedicated 10 Gbit/s links. In order to
direct the traffic, we use two VLANs. As a result we have two
dedicated 10 Gbit/s links between Linux VM and NetApp.

We also noticed that we get the best possible performance from Linux to NetApp
filer using the following mount options over one path:

-o vers=3,nconnect=16

With that setup we can get 150k 4k randop iops with a queue depth of 256
(4 threads with 64 queue depth). This maxes out a 10 Gbit/s link with
4k random I/Os it also maxes out the cpu of our NetApp controller. The disks
are busy 25 - 50% (16 4TB SSDs).

We used the following commands to generate load. nproc = 4.

# high queue depth:
fio --ioengine=libaio --filesize=2G --ramp_time=2s --runtime=1m --numjobs=$(nproc) --direct=1 --verify=0 --randrepeat=0 --group_reporting --directory=/mnt --name=write --blocksize=1m --iodepth=64 --readwrite=write --unlink=1
fio --ioengine=libaio --filesize=2G --ramp_time=2s --runtime=1m --numjobs=$(nproc) --direct=1 --verify=0 --randrepeat=0 --group_reporting --directory=/mnt --name=randwrite --blocksize=4k --iodepth=256 --readwrite=randwrite --unlink=1
fio --ioengine=libaio --filesize=2G --ramp_time=2s --runtime=1m --numjobs=$(nproc) --direct=1 --verify=0 --randrepeat=0 --group_reporting --directory=/mnt --name=read --blocksize=1m --iodepth=64 --readwrite=read --unlink=1
fio --ioengine=libaio --filesize=2G --ramp_time=2s --runtime=1m --numjobs=$(nproc) --direct=1 --verify=0 --randrepeat=0 --group_reporting --directory=/mnt --name=randread --blocksize=4k --iodepth=256 --readwrite=randread --unlink=1

# 1 qd:
fio --ioengine=libaio --filesize=16G --ramp_time=2s --runtime=1m --numjobs=1 --direct=1 --verify=0 --randrepeat=0 --group_reporting --directory=/mnt --name=write --blocksize=1m --iodepth=1 --readwrite=write --unlink=1
fio --ioengine=libaio --filesize=16G --ramp_time=2s --runtime=1m --numjobs=1 --direct=1 --verify=0 --randrepeat=0 --group_reporting --directory=/mnt --name=randwrite --blocksize=4k --iodepth=1 --readwrite=randwrite --unlink=1
fio --ioengine=libaio --filesize=16G --ramp_time=2s --runtime=1m --numjobs=1 --direct=1 --verify=0 --randrepeat=0 --group_reporting --directory=/mnt --name=read --blocksize=1m --iodepth=1 --readwrite=read --unlink=1
fio --ioengine=libaio --filesize=16G --ramp_time=2s --runtime=1m --numjobs=1 --direct=1 --verify=0 --randrepeat=0 --group_reporting --directory=/mnt --name=randread --blocksize=4k --iodepth=1 --readwrite=randread --unlink=1

Cheers,
        Thomas

