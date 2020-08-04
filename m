Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2302D23BAB5
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Aug 2020 14:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgHDMt1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Aug 2020 08:49:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44958 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgHDMtZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Aug 2020 08:49:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074ClBEc070889;
        Tue, 4 Aug 2020 12:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=I7+n0yat0G2I3segpcUkyL5arHFfiLX4t00jL6+H8cg=;
 b=CRw92SpRE8pnnV8nOdSbqsqHMWCv20oiY6NssRlgFF5wqtf/4WAEmQFF5gUAXXFtDy4Y
 ioAJzhV+C3KuyU/WE+SK11P47zJgbo4kAvm5NC7SGwtJausyMdUUzckCdE5Jvxhd+7OT
 hKezdeNLfLpf8ZFfkhFZiuR6Y7b7OmoXURkQzjm50SPzLOGe/f3J0+PfUAJgdm9WevBK
 ouTd/W9zY9KvxEkKVMOIluL5WPJIJ8sv+3qpUga3EthAUezyip/bCtbM8wiicwATi59u
 EUBjzbz4ulJEmgBHNYSdtvAU6aV5ZJHMAfzFTxmZ6taPTwffiClHDfOW1vQ/I+q9Vel0 sQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32pdnq7bsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 04 Aug 2020 12:49:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074CgqJa021621;
        Tue, 4 Aug 2020 12:49:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 32pdnq5fxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Aug 2020 12:49:19 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 074CnH82030989;
        Tue, 4 Aug 2020 12:49:17 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Aug 2020 05:49:16 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: NFS over RDMA issues on Linux 5.4
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200804122557.GB4432@unreal>
Date:   Tue, 4 Aug 2020 08:49:14 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DAF6EFDA-5863-4887-B495-0BE3CA714209@oracle.com>
References: <8a1087d3-9add-dfe1-da0c-edab74fcca51@rothenpieler.org>
 <CE6C02CE-3EEB-4834-B499-376BC6020A17@oracle.com>
 <20200804093635.GA4432@unreal>
 <92a5a932-b843-eed3-555e-7557ccc1f308@rothenpieler.org>
 <20200804122557.GB4432@unreal>
To:     Timo Rothenpieler <timo@rothenpieler.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040094
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 4, 2020, at 8:25 AM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Tue, Aug 04, 2020 at 12:52:27PM +0200, Timo Rothenpieler wrote:
>> On 04.08.2020 11:36, Leon Romanovsky wrote:
>>> On Mon, Aug 03, 2020 at 12:24:21PM -0400, Chuck Lever wrote:
>>>> Hi Timo-
>>>>=20
>>>>> On Aug 3, 2020, at 11:05 AM, Timo Rothenpieler =
<timo@rothenpieler.org> wrote:
>>>>>=20
>>>>> Hello,
>>>>>=20
>>>>> I have just deployed a new system with Mellanox ConnectX-4 VPI EDR =
IB cards and wanted to setup NFS over RDMA on it.
>>>>>=20
>>>>> However, while mounting the FS over RDMA works fine, actually =
using it results in the following messages absolutely hammering dmesg on =
both client and server:
>>>>>=20
>>>>>> =
https://gist.github.com/BtbN/9582e597b6581f552fa15982b0285b80#file-server-=
log
>>>>>=20
>>>>> The spam only stops once I forcibly reboot the client. The =
filesystem gets nowhere during all this. The retrans counter in nfsstat =
just keeps going up, nothing actually gets done.
>>>>>=20
>>>>> This is on Linux 5.4.54, using nfs-utils 2.4.3.
>>>>> The mlx5 driver had enhanced-mode disabled in order to enable =
IPoIB connected mode with an MTU of 65520.
>>>>>=20
>>>>> Normal NFS 4.2 over tcp works perfectly fine on this setup, it's =
only when I mount via rdma that things go wrong.
>>>>>=20
>>>>> Is this an issue on my end, or did I run into a bug somewhere =
here?
>>>>> Any pointers, patches and solutions to test are welcome.
>>>>=20
>>>> I haven't seen that failure mode here, so best I can recommend is
>>>> keep investigating. I've copied linux-rdma in case they have any
>>>> advice.
>>>=20
>>> The mentioning of IPoIB is a slightly confusing in the context of =
NFS-over-RDMA.
>>> Are you running NFS over IPoIB?
>>=20
>> For all I'm aware, NFS over RDMA still needs an IP and port to be =
targeted
>> to, so IPoIB is mandatory?
>> At least the admin guide in the kernel says so.
>>=20
>> Right now I actually am running NFS over IPoIB (without RDMA), =
because of
>> the issue at hand. And would like to turn on RDMA for enhanced =
performance.
>>=20
>>> =46rom brief look on CQE error syndrome (local length error), the =
client sends wrong WQE.
>>=20
>> Does that point at an issue in the kernel code, or something I did =
wrong?
>>=20
>> The fstab entries for these mounts look like this:
>>=20
>> 10.110.10.200:/home /home nfs4
>> rw,rdma,port=3D20049,noatime,async,vers=3D4.2,_netdev 0 0
>>=20
>> Is there anything more I can investigate? I tried turning connected =
mode off
>> and lowering the mtu in turn, but that did not have any effect.
>=20
> Chuck,
>=20
> You probably know which traces Timo should enable on the client.
> The fact that NFS over (not-enahnced) IPoIB works highly reduces
> driver/FW issues.

Timo, I tend to think this is not a configuration issue.
Do you know of a known working kernel?


--
Chuck Lever



