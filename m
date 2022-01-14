Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F9C48ECFB
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jan 2022 16:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbiANPTE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jan 2022 10:19:04 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6910 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239294AbiANPSv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jan 2022 10:18:51 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20EEMjiE002522;
        Fri, 14 Jan 2022 15:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=A4Z54vOJdG/oh73qBVi2UX3YMyvFP5dkMmzyMBhTEYc=;
 b=GnBJCn6QbsVT7xASl6xbk2tFid3yYRi4o4vJSgLJE9HtuM/6zUGSVqrLcs5z1DRIOH5Z
 5CYMQQEsqlNzMC9kMNm0RVVBGX++ARyrUn88isLWbLj7ZVbyiFBrJN15XFXpJpW4clgg
 pBj8JPNobalpjEJcaMjq9wczO91VSgZGyXgYZqoMveFbS2rM1VRC5qVKPRYm3BYqILIv
 eUmPofLoKqk0Abc3QiRRiMXr+0gIpG7CRwA6EphRXWoSBMYJ+nsnPxNy3nLnWHmgfzOd
 qK64tRxZaIeEg9GhMhl/X1C0OjYET2l9i/QuqXrrPsles4ah38EtmMTyxL6bwTqz3I2p xA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3djkdnuxa2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jan 2022 15:18:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20EFFnLS185725;
        Fri, 14 Jan 2022 15:18:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3020.oracle.com with ESMTP id 3df42tcpth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jan 2022 15:18:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUWByLZoq4/u5L/J/jAW5DabaVOu2nbn7OahGlHpMmxCJTiPcv+JoNHMSo8SERGqvjcjVXmTOL2Ar/hG35nwb6msR6TRvUprrX0xsf5PHozavRxB8+t8fS54snlZx10MOGOFgueAqmp4gLyoNupwYVGAQIllUeFXU/OdahySuqh2r59o7XQsZ/51WrvYY0Wqh9oqk6h14h+mcO0F+VcNg56YBfntryeluzpjRmxIlhyA7ui+fSiWFKddEcAmf3jIjWBzNbahBwmhr9oQ3l3WQ9FD/b3ohMc8IBMTCqDQs0x9XAwdAyCfoTbiHzWnR8hvutDNdaKf6d63VSI/mG9QjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4Z54vOJdG/oh73qBVi2UX3YMyvFP5dkMmzyMBhTEYc=;
 b=Ioc4s91munGGWNgqrj23/Q3D0r8iZYmt7Zjy4Nwl8Mm8HkfyhEXwg2so9UbcPcdXBhNj6mJCw52bvHWmoicbgL5+CIRdOZeIDHexvTQGRSRUPcLx902DG6KWnLXlWwuKI9u/jAs0FBQuBmg/SLvsk5W7j75Q8k1Tb6mqP7KuQBLjgRNOf8czW27FrUnynKlVyqqHgyQ4LQfKNTPwmpqLsWMGLkJ6E4c6RlSpiuFRdRaEmuIEcWGS7XtY5fbnArrwT7aIFkgIEBOA+7iYF9Ol8eH8DCee3EoRiCR8RoWOCBGTjnjKvpPRT+YWjQVjczTnGdVmQE0ScNvAtIpqwlcaNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4Z54vOJdG/oh73qBVi2UX3YMyvFP5dkMmzyMBhTEYc=;
 b=WJQ5AiFyAiQGtLdo88iVbwVOQx2SMDpsvrtmJCvGSjtK7Pdm9mQiTw1x1yUHL5Pnn9UekrSgvdDb35CFa2cxDsu2EtE/TS64ZrQjbHwQ5wM7uKGyOPSWjxcnDTvc1e7rEKlsBxiZsK2oP9dUdJDV8aDmJu4xJe8OeSclRH3qc3o=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by SJ0PR10MB5647.namprd10.prod.outlook.com (2603:10b6:a03:3d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Fri, 14 Jan
 2022 15:18:01 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 15:18:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jonathan Woithe <jwoithe@just42.net>,
        Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [Bug report] Recurring oops, 5.15.x, possibly during or soon
 after client mount
Thread-Topic: [Bug report] Recurring oops, 5.15.x, possibly during or soon
 after client mount
Thread-Index: AQHYCTZE+ENVwkeetkGrNbALtTtuGqxioWgA
Date:   Fri, 14 Jan 2022 15:18:01 +0000
Message-ID: <C7A57602-4DDD-4952-BA38-03F819DBD296@oracle.com>
References: <20220114103901.GA22009@marvin.atrad.com.au>
In-Reply-To: <20220114103901.GA22009@marvin.atrad.com.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9842bca8-d13b-4aab-36bf-08d9d7710e02
x-ms-traffictypediagnostic: SJ0PR10MB5647:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB56472B5B18D27C090288F02093549@SJ0PR10MB5647.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 160qdb3yl86BTDXQouZ1nZnmEpbVpdkiXORsQO9jg0P53q70iPtctfo3QCINPNelVA86zd5QoFK0yr/oXZHv3PND6M9xDzQgmcnBiwCCFmHlciva79CiHyVXLxgZb5S6I67uvTUWRq4iEbKGtPzpCGWPFpi8IwMeKIUklq0LoOcA3td9+Errd8ihPrmZRaN/5VZ89JESBvJgPvHRLBii6GXbVsyTLKciGWZIOJHA8LFsCBhuXS/PrFVYgbgnOI02sDeayPwY5PZ3fOGvLIkmJQMViVyf1UVe9XbBfQeglrYquXAeXlkxRxa0GWLU7fSR0qIurIF6ZGu/kjP5Di3KqB4QzvKcePzrPLnp8V6+qY5nUH29BZ6Ztv2ENXR1joeakeRiTD1oc9I7+TS4CvIfgvv1dTrfFcaCDw6JrR/zybPv0XmhSuGeNEjTimzk/DXApn0nmWKuUQS8lVCQ7brc6IX6480nJ0uMkqu/fHF/L/CM2ZFIp0Tb3XjIpCNcmUUSmQaoeb4x3iDYp7UkInZWOUDuiS+1j87y++OxJqAKU/KiyLAtWX7vfAQbCSJZneRpEoMwMfwuyCPzC0zVQf/XrOtg9oVkCO8vMrqxK7v9BlSVjOqqsHojNamg6lFugzBld4xwcpgvJ1GzZAwCWUxoM8EYv5IKtkfo3S2PhfTAhd7hK0nJVxnhUQpNp0G95JMVF3MffV8q83st2AfrQrc7eKF7I7SOuwwAYx97JQSBisT61aFFFAoZ3/Ie0WPORfYF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(6512007)(76116006)(8936002)(71200400001)(2906002)(36756003)(66946007)(5660300002)(83380400001)(110136005)(86362001)(2616005)(8676002)(6506007)(64756008)(26005)(122000001)(66446008)(316002)(6486002)(38100700002)(38070700005)(4326008)(66476007)(45080400002)(508600001)(33656002)(53546011)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Qwj5LT55MyOFb2aVdd60wFmor+sfTH8w6DTC6bIaefBDq2kwMb4NsWlHP1Z?=
 =?us-ascii?Q?VOuA6jmi4oSKgxdkN5ICBIGHa4fyV8LPHA8y4nl0cw5aFa0XSSariwK7EsoX?=
 =?us-ascii?Q?5DgyurzIkTG5vNxsnW2iX8vSgl7y2NjW5pzx+gbMZHLNBDKzvoMPzoKo7f3G?=
 =?us-ascii?Q?ZIufg6xsT27lS8tIOs/zhJyOAABWvfCzSJFLuDPZGCppeM4Hv365G5lNepCb?=
 =?us-ascii?Q?HprLKFwugYVTLevrR99qbfRQFrYtb/D7MIjdMQWI4sIhZ+udR93C3XboGALk?=
 =?us-ascii?Q?gZKdYx+HMviIUB2DQG83ZxBjuvS70nHfNJSJMRq6rAkofWgyqObB3JoSu7t2?=
 =?us-ascii?Q?I02F/xQMITStel3i9IpXHjaRVr7WCPATkSVYgKjEcsdWGbinxpjs5W/WkR5z?=
 =?us-ascii?Q?lQBgERbhIclb/VbWRSblqDLyWalln8DnHzbNyTj8ISBlq2u7koA9wXBU2ZN7?=
 =?us-ascii?Q?p6RAk/ePtKmOjb+QeiWa0ivK1lPLnlzgXvfnBJaTVAwykVHWOpC/qCT0t2vS?=
 =?us-ascii?Q?frAHORjgf+oVy/scvkwKQNAe9IFmbExiNWEbrswBhm0zidoHh7esjtk6nWC5?=
 =?us-ascii?Q?VJ392yN38PAtDCh0cJ9LQqCl5+5NQ7056v97KcSQcCztVCbrh2UH6BHt0so7?=
 =?us-ascii?Q?AX1rLmixSDSee4Cj6Lx5UhT7QSKiQU76SJsP4Mx2QWL2ALsMTEQltCIWJDQs?=
 =?us-ascii?Q?MAqH+0CFXaH1g/pOleYTrYNL5XLUBP7CSC7AucLp2J1gUEIYCO5mSS4zLbsw?=
 =?us-ascii?Q?4SWN6qldpoRmsNrfQJfPwenJ/JRduX6axbcnROV/MqYgC+mPELrPHphqgXI5?=
 =?us-ascii?Q?nA/GQtPzoZyki8d38IHJo+HqWjlmrbo3bQkgExy2Dr4KDWqnacAGGJAeb6c3?=
 =?us-ascii?Q?kx8PRfHEzgMMZhvNqOVmdYqywsPViAtjYzb8AwJCUzuMlBp6+5hpNePLTiIz?=
 =?us-ascii?Q?eQWzXh27uv0UnmYjvbQhDrfagyCLCgDq7XLJKzc4ehHJiaMC/o66/fQXXBbp?=
 =?us-ascii?Q?AxY7Lt47i9rSMZm8j/eYgU0eJynDI3LiUcOGQMKBUiM+gcESV3irUYh5zD/W?=
 =?us-ascii?Q?2ZKTcQezh7PYDVqPLS+ZWkC5O5zc50Zbpk6XGrcuZIaBGz/4reNBkJigFWzA?=
 =?us-ascii?Q?nUJonyXwtwdL/U8NziXSDuAe8ZKbhCa7IQHE3dxlRfQ2YceEftLAXUlE721S?=
 =?us-ascii?Q?i/8+WP8zqCTBZvWeu+aKU7uygdMAu2Oqy/NItC5HcRV9/1a8WPI2oaeEXiUN?=
 =?us-ascii?Q?XBy38fvYcnuHQfEx/YE66HaHudP2HBBV8yDt+sXDJcNMxE8PYwtsHuAslLBA?=
 =?us-ascii?Q?AdnYu8TOqup0zL37VWkI//sRAiWkzKvsI57ZdwmR64X5j7OedyrJHsa4z7PC?=
 =?us-ascii?Q?cVZ9W7lDyrZ7xdLUTWceerY3btVgT0VgCdf8JgzcuEcaVZis9UND5r0gXklZ?=
 =?us-ascii?Q?5BcDhLlyG3ShNGeo4/fhZODDoNF4hSZ/AlbLlv8e0xtpLApCIFuWRQVYxt3K?=
 =?us-ascii?Q?a1xVNBgib44M2rC8xCFdQKf1z+I8fzMpez3lr1iH72gnH7s3bzJ5EAtxNgD/?=
 =?us-ascii?Q?iqeB9A3zMnNoWRsWsmSBMP8pCPwrcTCC5G5VSGImnGwWhiNKQNDP3u5QpI5B?=
 =?us-ascii?Q?olC3f3gaMJIjA9kCD407eQU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB1BA3F5C3882B4AB11CBCE81A263AF4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9842bca8-d13b-4aab-36bf-08d9d7710e02
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 15:18:01.4832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7kf70TpJjg88ZBrEsOx6Q05KEtLY4WNCY+snpN6Q1h6venkCxYk++hBjO1bSbA0nqJlayvIYc5G0/ObmBSFubg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5647
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10226 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201140102
X-Proofpoint-GUID: uiAT3yaeFKg8BgvaSFiou0n8lCtDZVxu
X-Proofpoint-ORIG-GUID: uiAT3yaeFKg8BgvaSFiou0n8lCtDZVxu
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jonathan-

> On Jan 14, 2022, at 5:39 AM, Jonathan Woithe <jwoithe@just42.net> wrote:
>=20
> Hi all
>=20
> Recently we migrated an NFS server from a 32-bit environment running=20
> kernel 4.14.128 to a 64-bit 5.15.x kernel.  The NFS configuration remaine=
d
> unchanged between the two systems.
>=20
> On two separate occasions since the upgrade (5 Jan under 5.15.10, 14 Jan
> under 5.15.12) the kernel has oopsed at around the time that an NFS clien=
t
> machine is turned on for the day.  On both occasions the call trace was
> essentially identical.  The full oops sequence is at the end of this emai=
l.=20
> The oops was not observed when running the 4.14.128 kernel.
>=20
> Is there anything more I can provide to help track down the cause of the
> oops?

A possible culprit is 7f024fcd5c97 ("Keep read and write fds with each nlm_=
file"),
which was introduced in or around v5.15. You could try a simple test and ba=
ck
the server down to v5.14.y to see if the problem persists.

Otherwise, Bruce, can you have a look at this?


> Regards
>  jonathan
>=20
> Oops under 5.15.12:
>=20
> Jan 14 08:48:30 nfssvr kernel: BUG: kernel NULL pointer dereference, addr=
ess: 0000000000000110
> Jan 14 08:48:30 nfssvr kernel: #PF: supervisor read access in kernel mode
> Jan 14 08:48:30 nfssvr kernel: #PF: error_code(0x0000) - not-present page
> Jan 14 08:48:30 nfssvr kernel: Oops: 0000 [#1] PREEMPT SMP PTI
> Jan 14 08:48:30 nfssvr kernel: CPU: 0 PID: 2935 Comm: lockd Not tainted 5=
.15.12 #1
> Jan 14 08:48:30 nfssvr kernel: Hardware name:  /DG31PR, BIOS PRG3110H.86A=
.0038.2007.1221.1757 12/21/2007
> Jan 14 08:48:30 nfssvr kernel: RIP: 0010:vfs_lock_file+0x5/0x30
> Jan 14 08:48:30 nfssvr kernel: Code: ff ff 41 89 c4 85 c0 0f 84 42 ff ff =
ff e9 f8 fe ff ff 0f 0b e8 2c bc d2 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 =
0f 1f 44 00 00 <48> 8b 47 28 49 89 d0 48 8b 80 98 00 00 00 48 85 c0 74 05 e=
9 f3 dc
> Jan 14 08:48:30 nfssvr kernel: RSP: 0018:ffffa478401a3c38 EFLAGS: 0001024=
6
> Jan 14 08:48:30 nfssvr kernel: RAX: 7fffffffffffffff RBX: 00000000000000e=
8 RCX: 0000000000000000
> Jan 14 08:48:30 nfssvr kernel: RDX: ffffa478401a3c40 RSI: 000000000000000=
6 RDI: 00000000000000e8
> Jan 14 08:48:30 nfssvr kernel: RBP: ffff946ead1ecc00 R08: ffff946f88ab100=
0 R09: ffff946f88b33a00
> Jan 14 08:48:30 nfssvr kernel: R10: 0000000000000000 R11: 000000000000000=
0 R12: ffffffffa657ff30
> Jan 14 08:48:30 nfssvr kernel: R13: ffff946e99df7c40 R14: ffff946e82fb051=
0 R15: ffff946ead1ecc00
> Jan 14 08:48:30 nfssvr kernel: FS:  0000000000000000(0000) GS:ffff946fabc=
00000(0000) knlGS:0000000000000000
> Jan 14 08:48:30 nfssvr kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
> Jan 14 08:48:30 nfssvr kernel: CR2: 0000000000000110 CR3: 000000010083a00=
0 CR4: 00000000000006f0
> Jan 14 08:48:30 nfssvr kernel: Call Trace:
> Jan 14 08:48:30 nfssvr kernel:  <TASK>
> Jan 14 08:48:30 nfssvr kernel:  nlm_unlock_files+0x6e/0xb0
> Jan 14 08:48:30 nfssvr kernel:  ? __skb_recv_udp+0x198/0x330
> Jan 14 08:48:30 nfssvr kernel:  ? _raw_spin_lock+0x13/0x2e
> Jan 14 08:48:30 nfssvr kernel:  ? nlmsvc_traverse_blocks+0x36/0x120
> Jan 14 08:48:30 nfssvr kernel:  ? preempt_count_add+0x68/0xa0
> Jan 14 08:48:30 nfssvr kernel:  nlm_traverse_files+0x152/0x280
> Jan 14 08:48:30 nfssvr kernel:  nlmsvc_free_host_resources+0x27/0x40
> Jan 14 08:48:30 nfssvr kernel:  nlm_host_rebooted+0x23/0x90
> Jan 14 08:48:30 nfssvr kernel:  nlmsvc_proc_sm_notify+0xae/0x110
> Jan 14 08:48:30 nfssvr kernel:  ? nlmsvc_decode_reboot+0x8b/0xc0
> Jan 14 08:48:30 nfssvr kernel:  nlmsvc_dispatch+0x89/0x180
> Jan 14 08:48:30 nfssvr kernel:  svc_process_common+0x3ce/0x6f0
> Jan 14 08:48:30 nfssvr kernel:  ? lockd_inet6addr_event+0xf0/0xf0
> Jan 14 08:48:30 nfssvr kernel:  svc_process+0xb7/0xf0
> Jan 14 08:48:30 nfssvr kernel:  lockd+0xca/0x1b0
> Jan 14 08:48:30 nfssvr kernel:  ? preempt_count_add+0x68/0xa0
> Jan 14 08:48:30 nfssvr kernel:  ? _raw_spin_lock_irqsave+0x19/0x40
> Jan 14 08:48:30 nfssvr kernel:  ? set_grace_period+0x90/0x90
> Jan 14 08:48:30 nfssvr kernel:  kthread+0x141/0x170
> Jan 14 08:48:30 nfssvr kernel:  ? set_kthread_struct+0x40/0x40
> Jan 14 08:48:30 nfssvr kernel:  ret_from_fork+0x22/0x30
> Jan 14 08:48:30 nfssvr kernel:  </TASK>
> Jan 14 08:48:30 nfssvr kernel: Modules linked in: tun nf_nat_ftp nf_connt=
rack_ftp xt_REDIRECT xt_nat xt_conntrack xt_tcpudp xt_NFLOG nfnetlink_log n=
fnetlink iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipta=
ble_filter ip_tables x_tables ipv6 hid_generic usbhid hi
> Jan 14 08:48:30 nfssvr kernel: CR2: 0000000000000110
> Jan 14 08:48:30 nfssvr kernel: ---[ end trace f8f28acee6f24340 ]---
> Jan 14 08:48:30 nfssvr kernel: RIP: 0010:vfs_lock_file+0x5/0x30
> Jan 14 08:48:30 nfssvr kernel: Code: ff ff 41 89 c4 85 c0 0f 84 42 ff ff =
ff e9 f8 fe ff ff 0f 0b e8 2c bc d2 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 =
0f 1f 44 00 00 <48> 8b 47 28 49 89 d0 48 8b 80 98 00 00 00 48 85 c0 74 05 e=
9 f3 dc
> Jan 14 08:48:30 nfssvr kernel: RSP: 0018:ffffa478401a3c38 EFLAGS: 0001024=
6
> Jan 14 08:48:30 nfssvr kernel: RAX: 7fffffffffffffff RBX: 00000000000000e=
8 RCX: 0000000000000000
> Jan 14 08:48:30 nfssvr kernel: RDX: ffffa478401a3c40 RSI: 000000000000000=
6 RDI: 00000000000000e8
> Jan 14 08:48:30 nfssvr kernel: RBP: ffff946ead1ecc00 R08: ffff946f88ab100=
0 R09: ffff946f88b33a00
> Jan 14 08:48:30 nfssvr kernel: R10: 0000000000000000 R11: 000000000000000=
0 R12: ffffffffa657ff30
> Jan 14 08:48:30 nfssvr kernel: R13: ffff946e99df7c40 R14: ffff946e82fb051=
0 R15: ffff946ead1ecc00
> Jan 14 08:48:30 nfssvr kernel: FS:  0000000000000000(0000) GS:ffff946fabc=
00000(0000) knlGS:0000000000000000
> Jan 14 08:48:30 nfssvr kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
> Jan 14 08:48:30 nfssvr kernel: CR2: 0000000000000110 CR3: 000000010083a00=
0 CR4: 00000000000006f0

--
Chuck Lever



