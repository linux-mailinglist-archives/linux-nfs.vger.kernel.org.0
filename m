Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E505159048
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2020 14:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgBKNtJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Feb 2020 08:49:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35406 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgBKNtJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Feb 2020 08:49:09 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01BDmPWI021196;
        Tue, 11 Feb 2020 13:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=IDSqzdH2/LznSsGFP6leJGSOIsZcDBvKHhH6r3lK0ws=;
 b=P4a8FzpPoO7YKbgIC/vKz4g39sx/F07bZq51Y+dFjvd72bOHttMJAgxqgKwkOuLLB3Ph
 xw9r71h9nDpN1wilJCr4Wr3xbyiZAata1jlkTUT/XMqMvJJClBkRfrUZg1+1MTqhyLYV
 p/0OGd2SXkPBCmemNUg0t2ED6S5iNYTdj6dUF8VeaECB0/VcvmmWXZbgvhYQUTdw/rMc
 mFbWQ/PyUoBASPTTUlvlI7iYXWFizxForr4BwKRojY4xxwbxyOp/7lE7SXDDKFbuUXv7
 43SsZJ29CDCPBOSq6QJeAxEF6p4EeOYAQQcfYF9wWV/UkRMmyW+VQYmLecdvR0oWCDed +g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2y2jx63kvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 13:49:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01BDl0wd017885;
        Tue, 11 Feb 2020 13:49:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2y26fh7cwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 13:48:59 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01BDmwUo012920;
        Tue, 11 Feb 2020 13:48:58 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Feb 2020 05:48:58 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: AMD IOMMU stops RDMA NFS from working since kernel 5.5 (bisected)
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200211072537.GD23114@suse.de>
Date:   Tue, 11 Feb 2020 08:48:56 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2CE039F4-3519-4481-B0E2-840D24EE4428@oracle.com>
References: <7ee099af-e6bb-18fe-eb93-2a8abd401570@tomt.net>
 <20200211072537.GD23114@suse.de>
To:     Andre Tomt <andre@tomt.net>, Tom Murphy <tmurphy@arista.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110104
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Andre-

Thank you for the detailed report!

Tom-

There is a rich set of trace points available in the RPC/RDMA =
implementation in 5.4/5.5, fwiw.
Please keep me in the loop, let me know if there is anything I can do to =
help.


> On Feb 11, 2020, at 2:25 AM, Joerg Roedel <jroedel@suse.de> wrote:
>=20
> Adding Tom's new email address.
>=20
> Tom, can you have a look, please?=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D206461 seems to be a =
similar
> issue.
>=20
> On Tue, Feb 11, 2020 at 06:06:54AM +0100, Andre Tomt wrote:
>> Since upgrading my RDMA lab from kernel 5.4.x to 5.5.x, NFSv4 over =
RDMA
>> stopped working. But only on my AMD Ryzen systems. And so far only =
NFS,
>> curiously other RDMA diagnostic tools (like qperf <ip> -cm1 rc_bw) =
work
>> fine.
>>=20
>> A git bisect points to be62dbf554c5b50718a54a359372c148cd9975c7 =
iommu/amd:
>> Convert AMD iommu driver to the dma-iommu api
>>=20
>> 5.5.3-rc1, 5.6-rc1 are also not working.
>>=20
>> I verified it by booting with amd_iommu=3Doff on the kernel cmdline - =
it makes
>> everything work again.
>>=20
>> The NFS config is a pretty simple NFSv4.x only, sec=3Dsys setup, =
running over
>> RoCEv1 on Mellanox mlx4 hardware (ConnectX-3 Pro, fw 2.42.5000). =
Nothing
>> fancy besides the RoCEv1 and related bits network bits like PFC and =
storage
>> VLAN. Bare metal, no virtualization.
>>=20
>> The impacted systems are:
>> ASUS ROG STRIX X399-E GAMING, with a Threadripper 1950x, BIOS 1002
>> ASUS Pro WS X570-ACE, with a Ryzen 7 3700x, BIOS 1201
>>=20
>> pcaps off a mirror port can be provided. They show that on 5.5.x, CM
>> succeeds, and then a couple of NFS NULL calls comes through (over =
RoCE),
>> both acked, and then the rest just never goes out from the client =
until the
>> mount times out and CM is torn down.
>>=20
>> No messages shows up in the kernel log on either side. I was at least
>> expecting some scary IOMMU warnings.
>>=20
>> More serious hardware is not available for RDMA testing currently, so =
I dont
>> know if a EPYC system or newer mlx5 cards would have similar issues. =
Intel
>> I've only tested as server so far, that worked fine, as expected =
given the
>> bisect result.
>>=20
>>=20
>>> git bisect start
>>> # bad: [d5226fa6dbae0569ee43ecfc08bdcd6770fc4755] Linux 5.5
>>> git bisect bad d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
>>> # good: [219d54332a09e8d8741c1e1982f5eae56099de85] Linux 5.4
>>> git bisect good 219d54332a09e8d8741c1e1982f5eae56099de85
>>> # good: [8c39f71ee2019e77ee14f88b1321b2348db51820] Merge =
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
>>> git bisect good 8c39f71ee2019e77ee14f88b1321b2348db51820
>>> # bad: [76bb8b05960c3d1668e6bee7624ed886cbd135ba] Merge tag =
'kbuild-v5.5' of =
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
>>> git bisect bad 76bb8b05960c3d1668e6bee7624ed886cbd135ba
>>> # good: [21b26d2679584c6a60e861aa3e5ca09a6bab0633] Merge tag =
'5.5-rc-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6
>>> git bisect good 21b26d2679584c6a60e861aa3e5ca09a6bab0633
>>> # good: [e5b3fc125d768eacd73bb4dc5019f0ce95635af4] Merge branch =
'x86-urgent-for-linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>> git bisect good e5b3fc125d768eacd73bb4dc5019f0ce95635af4
>>> # bad: [937d6eefc716a9071f0e3bada19200de1bb9d048] Merge tag =
'docs-5.5a' of git://git.lwn.net/linux
>>> git bisect bad 937d6eefc716a9071f0e3bada19200de1bb9d048
>>> # bad: [1daa56bcfd8b329447e0c1b1e91c3925d08489b7] Merge tag =
'iommu-updates-v5.5' of =
git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
>>> git bisect bad 1daa56bcfd8b329447e0c1b1e91c3925d08489b7
>>> # good: [937790699be9c8100e5358625e7dfa8b32bd33f2] mm/page_io.c: =
annotate refault stalls from swap_readpage
>>> git bisect good 937790699be9c8100e5358625e7dfa8b32bd33f2
>>> # good: [a5255bc31673c72e264d837cd13cd3085d72cb58] Merge tag =
'dmaengine-5.5-rc1' of git://git.infradead.org/users/vkoul/slave-dma
>>> git bisect good a5255bc31673c72e264d837cd13cd3085d72cb58
>>> # good: [34d1b0895dbd10713c73615d8f532e78509e12d9] iommu/arm-smmu: =
Remove duplicate error message
>>> git bisect good 34d1b0895dbd10713c73615d8f532e78509e12d9
>>> # bad: [3c124435e8dd516df4b2fc983f4415386fd6edae] iommu/amd: Support =
multiple PCI DMA aliases in IRQ Remapping
>>> git bisect bad 3c124435e8dd516df4b2fc983f4415386fd6edae
>>> # bad: [be62dbf554c5b50718a54a359372c148cd9975c7] iommu/amd: Convert =
AMD iommu driver to the dma-iommu api
>>> git bisect bad be62dbf554c5b50718a54a359372c148cd9975c7
>>> # good: [781ca2de89bae1b1d2c96df9ef33e9a324415995] iommu: Add gfp =
parameter to iommu_ops::map
>>> git bisect good 781ca2de89bae1b1d2c96df9ef33e9a324415995
>>> # good: [6e2350207f40e24884da262976f7fd4fba387e8a] iommu/dma-iommu: =
Use the dev->coherent_dma_mask
>>> git bisect good 6e2350207f40e24884da262976f7fd4fba387e8a
>>> # first bad commit: [be62dbf554c5b50718a54a359372c148cd9975c7] =
iommu/amd: Convert AMD iommu driver to the dma-iommu api

--
Chuck Lever



