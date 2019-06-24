Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30493517A4
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2019 17:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbfFXPu3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jun 2019 11:50:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36680 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730973AbfFXPuW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jun 2019 11:50:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OFnBqa093797;
        Mon, 24 Jun 2019 15:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=AFy6qlQL44ZVPZ0/RAbg/aU5HjHaKTglFxRJ6Gc9juM=;
 b=ZQGTyNddz3fkfMBqEEk/NIHjhcNK/bxppj5eN7ovCabiq4LUnPg3ufc1LyfNoOlvDQ8D
 GfNrnrhQu/SCBhBLttPicSpzV7YQcIKqTkt4eoHZMfK8+EXAthlyvEdon4knrhTjoMoL
 d97C/zxmL86HuwleOnN0PKZ83xcOtdeSY+YxSgJex5BILFxKD/oAVCuGsu2dCTLoVeGL
 M0kd7eRVg4nmNsCs3kk/JzULJ2w/toTtT+YMGpmDxKIfeUTvE9qUnZUO1FXI8P5UnqeZ
 1QxKlRzJxvyZo10kpFIg6MIOq0m50qxjoFQQojLckpTlmBH5Y3jKni5NJLyyjNqTFCGP dQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t9brsy94y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 15:50:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OFnoT7188211;
        Mon, 24 Jun 2019 15:50:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t99f3bmm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 15:50:14 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5OFoDjp025843;
        Mon, 24 Jun 2019 15:50:13 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 08:50:13 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: memory leaks reported during xfstests
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190623073225.GA21489@splinter>
Date:   Mon, 24 Jun 2019 11:50:12 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE167A82-1045-470A-9EB8-D8D58901003B@oracle.com>
References: <6842E17A-0209-40A2-B71B-14C8361C7166@oracle.com>
 <20190623073225.GA21489@splinter>
To:     Ido Schimmel <idosch@idosch.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240126
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 23, 2019, at 3:32 AM, Ido Schimmel <idosch@idosch.org> wrote:
>=20
> On Fri, Jun 21, 2019 at 05:58:48PM -0400, Chuck Lever wrote:
>> For unrelated reasons I've enabled kmemleak in my client's kernel.
>> While running xfstests, I get these reports on several of the tests.
>> I've seen them on a few recent kernels as well.
>>=20
>> They do not look related to NFS. Anyone know where I should report
>> this?
>=20
> Most likely fixed by:
> https://patchwork.kernel.org/patch/11006849/
>=20
> See this report:
> https://lore.kernel.org/linux-nfs/20190614185237.GA550@splinter/#t

Confirmed that this patch (now in v5.2-rc6) addresses the prepare_creds =
leak.
Thanks, Ido.


>> [cel@manet ~]$ cat src/xfstests/results/generic/013.kmemleak
>> EXPERIMENTAL kmemleak reported some memory leaks!  Due to the way =
kmemleak
>> works, the leak might be from an earlier test, or something totally =
unrelated.
>> unreferenced object 0xffff88886963c4c0 (size 168):
>>  comm "mount", pid 3471, jiffies 4296003082 (age 161.789s)
>>  hex dump (first 32 bytes):
>>    03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>  backtrace:
>>    [<00000000fd30522a>] kmem_cache_alloc+0xc4/0x1cb
>>    [<0000000008f8eac6>] prepare_creds+0x21/0xc7
>>    [<000000006e9e3064>] prepare_exec_creds+0xb/0x3a
>>    [<000000001b408d7e>] __do_execve_file.isra.31+0x103/0x818
>>    [<000000004096f0a3>] do_execve+0x25/0x29
>>    [<0000000008a9aa1c>] __x64_sys_execve+0x26/0x2b
>>    [<00000000599d3d33>] do_syscall_64+0x5a/0x68
>>    [<00000000005d29f3>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> unreferenced object 0xffff888867a4f708 (size 32):
>>  comm "mount", pid 3471, jiffies 4296003082 (age 161.789s)
>>  hex dump (first 32 bytes):
>>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>  backtrace:
>>    [<000000004c53b46c>] __kmalloc+0xfc/0x14a
>>    [<000000002ff13bd8>] lsm_cred_alloc.isra.5+0x24/0x32
>>    [<000000009eb979ec>] security_prepare_creds+0x21/0x61
>>    [<0000000086789f15>] prepare_creds+0xb3/0xc7
>>    [<000000006e9e3064>] prepare_exec_creds+0xb/0x3a
>>    [<000000001b408d7e>] __do_execve_file.isra.31+0x103/0x818
>>    [<000000004096f0a3>] do_execve+0x25/0x29
>>    [<0000000008a9aa1c>] __x64_sys_execve+0x26/0x2b
>>    [<00000000599d3d33>] do_syscall_64+0x5a/0x68
>>    [<00000000005d29f3>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> [cel@manet ~]$
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20

--
Chuck Lever



