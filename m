Return-Path: <linux-nfs+bounces-3882-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0118390A35D
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 07:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCF9281452
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 05:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01B5DDA6;
	Mon, 17 Jun 2024 05:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aJN9nlHB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1717F5
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718602515; cv=none; b=Ph920nfUyDKfhvfM1OHRpRt4jef4k34ZauMhWgiYG11PgI5z84bxPYSH6HC+ocf7B9dAltl8T2v3ZX44pThw7ekc7Jie5rpIKRIM/BtyfRJy+0On/WMQUAL6JK4ZUfiNaHzB0W0LLOfIGXSrpiltZQ6HdsLtPxQLgZECIle6Tjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718602515; c=relaxed/simple;
	bh=ll+IvGp6glkhPDRrLZnezJvPDN/UbWVtZw9rkPJNXgw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ECeogbsp3tt67eBJThfpvJAh9MpTDRvEniPTN+dAS9K6MzAdutasXr83qMJUPE5zgvcfrjbXnUrhfVnRvBgeNoY9d/9yFyNyKnqnQ/INws96IwkBiDlLJcAxXDBM2dUPsh8VO7Z6pI1HsLLlUaS7qcVXQTqYim3EFL1ikDh71Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aJN9nlHB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H5TJTx015185;
	Mon, 17 Jun 2024 05:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:to:cc:from:subject:content-type
	:content-transfer-encoding; s=pp1; bh=nYtStndJWFvYyMRld3CUx/mrxb
	g/OeFw0shXdzMXWlg=; b=aJN9nlHB9e+fzJRwrg8prjAtnOgr2kIxB1C2/fBoh7
	CVYIkvNyMmLmO1W01vPGU4IyMvNuUYcXFLeEpXpE8VAuUA4wJpMLkZcGlR9VfusL
	Ad5G72YMiqvCfMmyChpbcc6XSXNUjzACxXWH6ZpsaOaInXHiSo1nasVU3BbzSR4P
	be+qgufHjAOHZ9TlryIzyfjDLsc31nWZkhq1RqyIDsf2XtlTz0pfvlxyEVBnuZP0
	GPOJF2wrXVvkickRb41nG49ftlTxf8YJrWajJtCEotPy12iGhpxkk5z2LanpU6MV
	BTzE9TuLkFC66Kp9LVRpyltIIFmSTUOrEYEOAXGgmwog==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytf18r0s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 05:35:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45H41eEU006226;
	Mon, 17 Jun 2024 05:35:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysn9u7gbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 05:35:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45H5YuUA46465372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 05:34:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC6FA2004D;
	Mon, 17 Jun 2024 05:34:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 512C420043;
	Mon, 17 Jun 2024 05:34:55 +0000 (GMT)
Received: from [9.43.115.247] (unknown [9.43.115.247])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Jun 2024 05:34:55 +0000 (GMT)
Message-ID: <c2e9f6de-1ec4-4d3a-b18d-d5a6ec0814a0@linux.ibm.com>
Date: Mon, 17 Jun 2024 11:04:53 +0530
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>, linux-nfs@vger.kernel.org
Cc: Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: kernel crash on cat /proc/fs/nfsd/pool_stats
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5qOywZBeXJuVbZqLE3vKgiF36Bda6N9L
X-Proofpoint-ORIG-GUID: 5qOywZBeXJuVbZqLE3vKgiF36Bda6N9L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_04,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=985 mlxscore=0
 bulkscore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170039

Hello NFSD maintainers,

I found that cat over /proc/fs/nfsd/pool_stats sysfs leads to kernel 
crash on upstream kernel.

Console logs:

[221875.249341] Kernel attempted to read user page (0) - exploit 
attempt? (uid: 0)
[221875.249347] BUG: Kernel NULL pointer dereference on read at 0x00000000
[221875.249351] Faulting instruction address: 0xc000000001071cd4
[221875.249356] Oops: Kernel access of bad area, sig: 11 [#1]
[221875.249360] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
[221875.249365] Modules linked in: binfmt_misc bonding tls rfkill 
pseries_rng vmx_crypto drm fuse drm_panel_orientation_quirks xfs 
libcrc32c sd_mod t10_pi sg ibmvscsi ibmveth scsi_transport_srp 
pseries_wdt dm_mirror dm_region_hash dm_log dm_mod
[221875.249408] CPU: 9 PID: 98011 Comm: cat Kdump: loaded Not tainted 
6.10.0-rc3nfsd-module-dirty #6
[221875.249419] Hardware name: SNIP...
[221875.249433] NIP:  c000000001071cd4 LR: c000000001071cc8 CTR: 
c000000000fe5394
[221875.249443] REGS: c0000000553ff890 TRAP: 0300   Not tainted 
(6.10.0-rc3nfsd-module-dirty)
[221875.249453] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
22222402  XER: 20040000
[221875.249463] CFAR: c00000000106e598 DAR: 0000000000000000 DSISR: 
40000000 IRQMASK: 0
[221875.249463] GPR00: c000000001071cc8 c0000000553ffb30 
c000000001a96300 0000000000000000
[221875.249463] GPR04: c00000000d006130 0000000000000001 
0000000000000001 00000003fa6f0000
[221875.249463] GPR08: 00000003fa6f0000 0000000000000000 
c000000094c40000 0000000022222402
[221875.249463] GPR12: c000000000fe5394 c0000003ffff4c80 
0000000000000000 0000000000000000
[221875.249463] GPR16: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
[221875.249463] GPR20: 0000000000000000 0000000000000000 
c00000000d006140 0000000000000000
[221875.249463] GPR24: 0000000000000000 0000000000000000 
c00000000d006130 0000000000000000
[221875.249463] GPR28: c0000000553ffca0 c0000000553ffcc8 
c00000005521e988 0000000000000000
[221875.249527] NIP [c000000001071cd4] mutex_lock+0x34/0x88
[221875.249538] LR [c000000001071cc8] mutex_lock+0x28/0x88
[221875.249546] Call Trace:
[221875.249551] [c0000000553ffb30] [c000000001071cc8] 
mutex_lock+0x28/0x88 (unreliable)
[221875.249562] [c0000000553ffb60] [c000000000fe53c8] 
svc_pool_stats_start+0x34/0xa8
[221875.249575] [c0000000553ffb90] [c0000000006329f0] 
seq_read_iter+0x148/0x69c
[221875.249587] [c0000000553ffc70] [c000000000633048] seq_read+0x104/0x15c
[221875.249596] [c0000000553ffd10] [c0000000005e935c] vfs_read+0xdc/0x3a0
[221875.249608] [c0000000553ffdc0] [c0000000005ea41c] ksys_read+0x84/0x144
[221875.249615] [c0000000553ffe10] [c000000000030ae4] 
system_call_exception+0x124/0x330
[221875.249621] [c0000000553ffe50] [c00000000000cedc] 
system_call_vectored_common+0x15c/0x2ec
[221875.249632] --- interrupt: 3000 at 0x7fff85133cf4
[221875.249638] NIP:  00007fff85133cf4 LR: 00007fff85133cf4 CTR: 
0000000000000000
[221875.249654] REGS: c0000000553ffe80 TRAP: 3000   Not tainted 
(6.10.0-rc3nfsd-module-dirty)
[221875.249660] MSR:  800000000280f033 
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 42222408  XER: 00000000
[221875.249674] IRQMASK: 0
[221875.249674] GPR00: 0000000000000003 00007ffff9a085f0 
0000000114f87f00 0000000000000003
[221875.249674] GPR04: 00007fff852b0000 0000000000020000 
0000000000000022 0000000000000000
[221875.249674] GPR08: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
[221875.249674] GPR12: 0000000000000000 00007fff8548a5c0 
0000000000000000 0000000000000000
[221875.249674] GPR16: 0000000020000000 0000000000000000 
0000000000020000 0000000000000000
[221875.249674] GPR20: 00007ffff9a08ca8 0000000000000002 
0000000000000000 0000000114f61d80
[221875.249674] GPR24: 0000000114f80110 0000000000020000 
0000000114f67f60 000000007ff00000
[221875.249674] GPR28: 0000000000000003 00007fff852b0000 
0000000000020000 00007fff852b0000
[221875.249756] NIP [00007fff85133cf4] 0x7fff85133cf4
[221875.249762] LR [00007fff85133cf4] 0x7fff85133cf4
[221875.249770] --- interrupt: 3000
[221875.249777] Code: 38424660 7c0802a6 60000000 7c0802a6 fbe1fff8 
7c7f1b78 f8010010 f821ffd1 4bffc88d 60000000 39200000 e94d0908 
<7d00f8a8> 7c284800 40c20010 7d40f9ad
[221875.249793] ---[ end trace 0000000000000000 ]---
[221875.252258] pstore: backend (nvram) writing error (-1)
[221875.252264]

The above logs are from the PowerPC architecture, but I think the issue 
is reproducible on x86 as well.

The git bisect points to the following commit as the first bad commit:

commit 7b207ccd983350a5dedd132b57c666186dd02a7c
Author: NeilBrown <neilb@suse.de>
Date:   Fri Dec 15 11:56:32 2023 +1100

     svc: don't hold reference for poolstats, only mutex.

     A future patch will remove refcounting on svc_serv as it is of little
     use.
     It is currently used to keep the svc around while the pool_stats 
file is
     open.

I investigated the issue and found that in svc_pool_stats_start(), 
si->mutex is NULL. Upon further investigation,
I found that while assigning private data to the seq variable (of type 
struct seq_file) in the svc_pool_stats_open()
function, the info->mutex is NULL.

Although nfsd_create_serv() does initialize the mutex, it seems it is 
not called.

It would be great if you could look into this issue. Feel free to let me 
know if you need more information about this issue.

Thanks,
Sourabh Jain

