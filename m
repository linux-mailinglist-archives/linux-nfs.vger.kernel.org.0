Return-Path: <linux-nfs+bounces-4765-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1798B92D0F6
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 13:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7EC9B224CC
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 11:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDB718FA39;
	Wed, 10 Jul 2024 11:46:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386FA15351B;
	Wed, 10 Jul 2024 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611971; cv=none; b=pWojTS9gBQm1QAeK2LPCNNCAPm7fZQETyTHpbOg1rdphTphyo3Kntvd4OwVVkjCkvYvcQwYnG+jE2zeOPZ1LdMsIawW4cEJYZjouGZToXlIdJ5HZcoAgyopFTpdxw0Em8LVzRYtuFsWCepa/gO5EnayKB+WBVSxIDYnk3ju9WII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611971; c=relaxed/simple;
	bh=wEHsKZ6AB/l1DGwOREFXd4uINVjPlEAK2sxB0m+MfhM=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=RYfWNZlED9NYMIreylw+ArURWLuO/0jtW0Wgb+DnZMGE15/6N9taNgEBIFTJpzj3dggMBmNRKmtBnfDbQbaSZYGSvyT5Vh4vFONnrdIwk0LYDBMVzqeWowQ0hSgWZBEut+Q9WjHUaJ8yRoQIvyzkWvY1ZeADCK9lQPDE8L/AvUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 39B5D61E64862;
	Wed, 10 Jul 2024 13:46:02 +0200 (CEST)
Message-ID: <4a706b9c-5c47-4e51-87fc-9a1c012d89ba@molgen.mpg.de>
Date: Wed, 10 Jul 2024 13:46:01 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 it+linux-raid@molgen.mpg.de
Subject: How to debug intermittent increasing md/inflight but no disk
 activity?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


Exporting directories over NFS on a Dell PowerEdge R420 with Linux 
5.15.86, users noticed intermittent hangs. For example,

     df /project/something # on an NFS client

on a different system timed out.

     @grele:~$ more /proc/mdstat
     Personalities : [linear] [raid0] [raid1] [raid6] [raid5] [raid4] 
[multipath]
     md3 : active raid6 sdr[0] sdp[11] sdx[10] sdt[9] sdo[8] sdw[7] 
sds[6] sdm[5] sdu[4] sdq[3] sdn[2] sdv[1]
           156257474560 blocks super 1.2 level 6, 1024k chunk, algorithm 
2 [12/12] [UUUUUUUUUUUU]
           bitmap: 0/117 pages [0KB], 65536KB chunk

     md2 : active raid6 sdap[0] sdan[11] sdav[10] sdar[12] sdam[8] 
sdau[7] sdaq[6] sdak[5] sdas[4] sdao[3] sdal[2] sdat[1]
           156257474560 blocks super 1.2 level 6, 1024k chunk, algorithm 
2 [12/12] [UUUUUUUUUUUU]
           bitmap: 0/117 pages [0KB], 65536KB chunk

     md1 : active raid6 sdb[0] sdl[11] sdh[10] sdd[9] sdk[8] sdg[7] 
sdc[6] sdi[5] sde[4] sda[3] sdj[2] sdf[1]
           156257474560 blocks super 1.2 level 6, 1024k chunk, algorithm 
2 [12/12] [UUUUUUUUUUUU]
           bitmap: 2/117 pages [8KB], 65536KB chunk

     md0 : active raid6 sdaj[0] sdz[11] sdad[10] sdah[9] sdy[8] sdac[7] 
sdag[6] sdaa[5] sdae[4] sdai[3] sdab[2] sdaf[1]
           156257474560 blocks super 1.2 level 6, 1024k chunk, algorithm 
2 [12/12] [UUUUUUUUUUUU]
           bitmap: 7/117 pages [28KB], 65536KB chunk

     unused devices: <none>

In that time, we noticed all 64 NFSD processes being in uninterruptible 
sleep and the I/O requests currently in process increasing for the RAID6 
device *md0*

     /sys/devices/virtual/block/md0/inflight : 10 921

but with no disk activity according to iostat. There was only “little 
NFS activity” going on as far as we saw. This alternated for around half 
an our, and then we decreased the NFS processes from 64 to 8. After a 
while the problem settled, meaning the I/O requests went down, so it 
might be related to the access pattern, but we’d be curious to figure 
out exactly what is going on.

We captured some more data from sysfs [1].

Of course it’s not reproducible, but any insight how to debug this next 
time is much welcomed.


Kind regards,

Paul


[1]: https://owww.molgen.mpg.de/~pmenzel/grele.2.txt

