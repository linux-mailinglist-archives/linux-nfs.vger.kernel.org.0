Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB4DE96EF9
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2019 03:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfHUBjT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Aug 2019 21:39:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38682 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfHUBjS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Aug 2019 21:39:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L1dBoQ005608;
        Wed, 21 Aug 2019 01:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=xhKGxGwdzfuiE6xkuP2e+PBaSYp5vPVIdRc1W2wD7UQ=;
 b=H9jNldLBKYfkOhi3Yj435o1owWATKJlejUc+I8OF92Q1xu/4vFnguwaNPz+rNNfPbXiz
 iOps1/ZySfp6u1WoZzcR/uJNs6AEUuMKokt+BfLBwqKK+X9fQBBONLtnrsWHKX2XJWfJ
 QbThaR9G76phodn5yS//k7U786uKq2C+cdRmtz/dmHrcM6FPFadYSmK4c+yG+nGtvMvi
 v2mPe05U7oTSbLRB5QuSzInKx4bM5+p+75jBarf80wu5H7fmqo5UwpVI5j4SVfFT6nrW
 H4ULpMKCzZkPLaUKYCNN08uDBPqaZ+7o4gxhUXswQN3RevC9KY6MdXEhfDbmVLzcBSfi GQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2uea7qt2q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 01:39:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L1bsKV176485;
        Wed, 21 Aug 2019 01:39:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ug269d8wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 01:39:14 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7L1dB7E030094;
        Wed, 21 Aug 2019 01:39:12 GMT
Received: from [10.132.92.146] (/10.132.92.146)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Aug 2019 18:39:11 -0700
To:     CHUCK_LEVER <chuck.lever@oracle.com>, bfields@fieldses.org,
        linux-nfs@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "JANE.CHU" <jane.chu@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   jane.chu@oracle.com
Subject: kernel panic in 5.3-rc5, nfsd_reply_cache_stats_show+0x11
Organization: Oracle Corporation
Message-ID: <72e41dc2-b4cf-a5dd-a365-d26ba1257ef9@oracle.com>
Date:   Tue, 20 Aug 2019 18:39:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210013
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

Apology if there is a better channel reporting the issue, if so, please 
let me know.

I just saw below regression in 5.3-rc5 kernel, but not in 5.2-rc7 or 
earlier kernels.

[ 3533.659787] mce: Uncorrected hardware memory error in user-access at 
383e202000
[ 3533.659903] Memory failure: 0x383e202: Sending SIGBUS to 
read_poison:14493 due to hardware memory corruption
[ 3533.679041] Memory failure: 0x383e202: recovery action for dax page: 
Recovered
[ 3564.624934] BUG: kernel NULL pointer dereference, address: 
00000000000001f9
[ 3564.632707] #PF: supervisor read access in kernel mode
[ 3564.638440] #PF: error_code(0x0000) - not-present page
[ 3564.644174] PGD acd7b47067 P4D acd7b47067 PUD acd7aba067 PMD 0
[ 3564.650784] Oops: 0000 [#1] SMP NOPTI
[ 3564.654869] CPU: 58 PID: 15026 Comm: sosreport Tainted: G   M 
      5.3.0-rc5.master.20190820.ol7.x86_64 #1
[ 3564.666420] Hardware name: Oracle Corporation ORACLE SERVER 
X8-2L/ASM,MTHRBD,2U, BIOS 52020101 05/07/2019
[ 3564.677112] RIP: 0010:nfsd_reply_cache_stats_show+0x11/0x110 [nfsd]
[ 3564.684106] Code: 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 63 
47 ec 48 89 e5 5d c3 90 0f 1f 44 00 00 55 31 c0 48 89 e5 41 54 49 89 f4 
53 <8b> 96 f8 01 00 00 48 c7 c6 d9 b8 74 c0 48 89 fb e8 9a ae bc f2 41
[ 3564.705062] RSP: 0018:ffffaa140f87fe18 EFLAGS: 00010246
[ 3564.710894] RAX: 0000000000000000 RBX: ffff9f7c9b562ca8 RCX: 
0000000000005c19
[ 3564.718858] RDX: 0000000000001000 RSI: 0000000000000001 RDI: 
ffff9f7c9b562c80
[ 3564.726822] RBP: ffffaa140f87fe28 R08: ffff9f801fab01a0 R09: 
ffff9ed347c06600
[ 3564.734785] R10: ffff9f801e287000 R11: ffff9f8012f8d638 R12: 
0000000000000001
[ 3564.742749] R13: ffff9f8012f8d600 R14: ffff9f7c9b562c80 R15: 
0000000000000001
[ 3564.750712] FS:  00007f3cfaa92700(0000) GS:ffff9f801fa80000(0000) 
knlGS:0000000000000000
[ 3564.759743] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3564.766156] CR2: 00000000000001f9 CR3: 000000add1894004 CR4: 
00000000007606e0
[ 3564.774120] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 3564.782084] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[ 3564.790050] PKRU: 55555554
[ 3564.793068] Call Trace:
[ 3564.795800]  seq_read+0x13b/0x390
[ 3564.799502]  __vfs_read+0x1b/0x40
[ 3564.803202]  vfs_read+0x8e/0x140
[ 3564.806794]  ksys_read+0x61/0xd0
[ 3564.810394]  __x64_sys_read+0x1a/0x20
[ 3564.814484]  do_syscall_64+0x60/0x1e0
[ 3564.818572]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 3564.824199] RIP: 0033:0x7f3d163a304d


The panic is reproducible every time in 5.3-rc5, here is the steps.

On system with Intel DC PMEM, configure at AppDirect NonInterleave mode,
# ndctl create-namespace -m devdax
{
   "dev":"namespace1.0",
   "mode":"devdax",
   "map":"dev",
   "size":"124.03 GiB (133.18 GB)",
..
     "align":2097152,
     "devices":[
       {
         "chardev":"dax1.0",

# ndctl inject-error namespace1.0 -B 16 --count=1

# ./read_poison -x dax1.0 -o 8192 -m 1
Read poison location at (16 * 512 = 8192)

About a little under 30sec later, kernel panics.

thanks,
-jane


