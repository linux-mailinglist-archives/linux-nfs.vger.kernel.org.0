Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4E33E9955
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Aug 2021 22:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhHKUCH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Aug 2021 16:02:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60450 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229946AbhHKUCH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Aug 2021 16:02:07 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17BK0hrm013164;
        Wed, 11 Aug 2021 20:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oNg5kscKNTfBUI0Uh8byJ5lFnRmf93Df6A3vcQrXJJ0=;
 b=MVWHZfUo0e9f7tYZFM/9i3B4SKTe8PGOe4c2VjzEfpDAR4LWTyorqUnfJsEj+/4YNKDO
 99rvcz28QuX4WNj+FBI/yM2wDcrox/XzBeB7zv1N2ESjjoqZGyksduQGUOR2GmrU2RNY
 2iiwLM2+NHVKjvWAciEF2VjGJlq6oyXmYku8BbMg9BJrEA/K3oJTitolOBwLeGYdCTQL
 KAJ2F49JFZSMKRLzj7MNjSwZc6qmpAMnj0JIQWY0ReCvqqWGHWOHfqCGp1VhGEtDREpr
 L2ahmBR+aTfVyrEeH9xQ8genXYLOzlO7e1peaUhrqSfp0ST7vniAUo/iVg4x0V3XIPn0 ew== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=oNg5kscKNTfBUI0Uh8byJ5lFnRmf93Df6A3vcQrXJJ0=;
 b=ichtT8vz4zPni1WdJJKvOuG2dS2RUh1miCdl96zbJ/ocPDzSITGMDrXLMRkCUe7iE/HC
 KjHWPFmdfXrdiUnh3dsaixxtOd5qSEbYd7QAGL6nOqSFdjsdRJHZQAWfRT5CjBUkAD8Z
 ZDTgLp093DgA0tyOp3KJToUvtTerTH4+ncCw6/rM0Xzyk/uh4YavR4VWuQX/FSPksbMs
 +1kd1WFXNFi3R7uquAnB2Q+GaEGnQ563c6rEjEUa9WevIG8yADPFlbupxgOtNVMhz3+E
 +kij7hEAOR+1N8gKwTV8QzIKPtLCsQZl1dirw3WZwj96t9F/C/CIw3vzEnpPpbNMPOpy Qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abt44bnqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 20:01:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17BK0Tx7154316;
        Wed, 11 Aug 2021 20:01:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3020.oracle.com with ESMTP id 3accram7cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 20:01:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SITPlENwMBXRLwFtJLrXCwQGexR1y1awia+tL6WhG0t4xCfDmaKgmPe/CLUIS9gf0yj6kgRpjx3j3q4eCe3XTHizr05BDX1joSXxkz3BmP+uTc/HBSz5yDbMLkD/cKNLX37aL1moJCj4Vvt3wQhk0iBskIFtpkIwu4uTGSaik5mdU2yu9KH+aFLX5GUR+a0UgsX6crbMyp9rdItnHOu92ngDRaSf0wwDi7GMiIOe9mauYmNoHG3z/PMkpgRput4jCzTk7CQYNJXTtO9mXJlLyNcNQ8Gyu1twALnwTWsoOJ+hlRxlRVdwrdVJcpkx1J7B4dTyQ+DpjUTakwIa9vPU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNg5kscKNTfBUI0Uh8byJ5lFnRmf93Df6A3vcQrXJJ0=;
 b=lQevJiABTRvdh0tp3VDvuy3H636D2WWEbHNiuUtr9vS0g56JDrLkqcP0ON4ZbbN+MybJpaCWMEKwYDR39eT3kWZw+rMAHm2k8FDsY3omB7Gik9IcmttmOckbS051e4r5nPzYOZ9/DtTMRn/SdNWMGs2jUUpNYKD3ppNBGLD1gUzrhlQhvWziiLCaUq3LU57lkU0KqqGSgAMvTUOxf/riZyVsMSyxzCmIa8vGAgv79Tu+5TxTxY4LBbwrbnBXhwHwxRtkMQnO+IYDGoXYs92f+DyO2DVmtm7GRVU5gVKBobHK3uOLC2AvJhhnU6IG2Ypd8EHfTmKYbh0n6ck10D/YEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNg5kscKNTfBUI0Uh8byJ5lFnRmf93Df6A3vcQrXJJ0=;
 b=Kdzt0cERce1CJsWowt9+vBJRi++xOC/GNkoCrpymrjWE6pQbCIngkT4sy41V7fLcDN+0PyBykc4Cky+P1xorBxIpnhGfMh/6piImjJjNWMTyedvZqtFOq0gi3KTmCzu8egJxDRs2CuhnSfnSdbvSddy6/R1Sqb1z5bZvK+4fR9g=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4768.namprd10.prod.outlook.com (2603:10b6:a03:2d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 11 Aug
 2021 20:01:30 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 20:01:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Bruce Fields <bfields@redhat.com>
CC:     Timo Rothenpieler <timo@rothenpieler.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: Spurious instability with NFSoRDMA under moderate load
Thread-Topic: Spurious instability with NFSoRDMA under moderate load
Thread-Index: AQHXSnp8j8N6G2OhyUK9Nr2RtJxnoarn3hgAgAATb4CANuhZgIBOXZcAgAAVhICAADVLgIAASYeAgAAo1oCAAAOTXYAA6JWAgAADg4CAAANlAIAAA4eAgAAZh4CAABNpAIAAEuyAgAADt4CAAA9LgIAABEuA
Date:   Wed, 11 Aug 2021 20:01:30 +0000
Message-ID: <D417C606-9E27-431E-B80E-EE927E62A316@oracle.com>
References: <4da3b074-a6be-d83f-ccd4-b151557066aa@rothenpieler.org>
 <72ECF9E1-1F6E-44AF-850C-536BED898DDD@oracle.com>
 <e12c24fd-beaf-31ce-cb49-36ad32bd22b3@rothenpieler.org>
 <daae674a-84d4-de36-336d-693dc582e3ef@rothenpieler.org>
 <9355de20-921c-69e0-e5a4-733b64e125e1@rothenpieler.org>
 <a28b403e-42cf-3189-a4db-86d20da1b7aa@rothenpieler.org>
 <4BA2A532-9063-4893-AF53-E1DAB06095CC@oracle.com>
 <c8025457-7376-e1b7-bd6c-e5c6ee5d9ce7@rothenpieler.org>
 <141fdf51-2aa1-6614-fe4e-96f168cbe6cf@rothenpieler.org>
 <99DFF0B0-FE0F-4416-B3F6-1F9535884F39@oracle.com>
 <64F9A492-44B9-4057-ABA5-C8202828A8DD@oracle.com>
 <1b8a24a9-5dba-3faf-8b0a-16e728a6051c@rothenpieler.org>
 <5DD80ADC-0A4B-4D95-8CF7-29096439DE9D@oracle.com>
 <0444ca5c-e8b6-1d80-d8a5-8469daa74970@rothenpieler.org>
 <cc2f55cd-57d4-d7c3-ed83-8b81ea60d821@rothenpieler.org>
 <3AF4F6CA-8B17-4AE9-82E2-21A2B9AA0774@oracle.com>
 <CAN-5tyHNvYWd1M7sfZNV5q3Y_GZA2-DoTd=CxYvniZ1zkB5hyw@mail.gmail.com>
 <95DB2B47-F370-4787-96D9-07CE2F551AFD@oracle.com>
 <CAN-5tyGXycM1MKa=Sydoo4pP85PGLuh8yjJYsoAM3U+M1NVyCw@mail.gmail.com>
In-Reply-To: <CAN-5tyGXycM1MKa=Sydoo4pP85PGLuh8yjJYsoAM3U+M1NVyCw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7b45e60-3470-48be-4ebf-08d95d02cf92
x-ms-traffictypediagnostic: SJ0PR10MB4768:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB4768C80BABE81D66CC5EFA8493F89@SJ0PR10MB4768.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1UVcqGZrnD5iss96b5f6Ai6IdAgAb5r89xPuRC8MOJFs96iSP5jMH3V+DGow8F+eUoJ1WjnLjtKHqiALv1iXIfqpGZL5mRRiAVaSN2wcE3NcobQUI39RNbHc5Oisob3YxOPBoeUMNnXgGCcYRO6nkHKeG/+HNv5Q71mM7pIUCGax0V9iQInUBXNMCfX+o1fxWe5vuxTcxkYy1zkle+Qp3EYbGnhrpBl9DW4z6le2vQsYv49Ik23U07t2/16E3PlVW5gY+F0PDtzYE6vjE1OwAvzJQBazI9fYadSiXk4NBon6c8wEd6e+ROQ/bOPR64Wl1+oOa0Y/gTzjnnYr3qL72M39ZRd3+l22wsGWupSsSqe7gbx2lfiWL5754F8KV9xJSIH8HmozWvSaztMfA/Nmrkf3WLTPhMFifRnWa9J6klnhIX1SxqtGftW//q0Msv8m43gX27VU2cnjJJQlIjDbOYw5LJ/dIHKU2l0EgCHcQvhnylP//sF1HsTJT1zT0Z3IaWnMihaF1fzhPPE54Ctl2Yol4O5PjSfrq8cKoKNyaE5EtrJEXnGr2RYfAIfGuPvEht23f4Nd6Icf7Si8bcrXgxeS7dU6HVJU/05G1lYwrkYD/Z4YjoHeXx2nSvpl3KRi2AH497n+jz6JuIt1XdiIlj5ipDyBNEbAoO59AXyho2rjW35xtzSK0NEEWiQCIUz9Ez3sqmJOW6PBxHDeCML84/T5YTc6jh+B2jbwbYeV+Tf0B6bfcgZNSOH6dxZFqNMy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(366004)(396003)(376002)(6512007)(110136005)(8936002)(6506007)(54906003)(86362001)(26005)(2906002)(66556008)(478600001)(316002)(91956017)(6486002)(76116006)(64756008)(66446008)(66476007)(66946007)(186003)(2616005)(33656002)(83380400001)(36756003)(107886003)(8676002)(5660300002)(53546011)(71200400001)(4326008)(38100700002)(38070700005)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zxw3UXLSMMgPVMhPxRyUXVIAU8D7ZZByPfZfV8B85VfFEUaHm1C37ntWBa7X?=
 =?us-ascii?Q?s1pu9tNhVpdL2kII9m0YdyP8wI2KNvMHHCGxtIr0lB08A7kuzsnapXb/e4KV?=
 =?us-ascii?Q?no5L04wnhUIO60ZrUIDeq8/8raoRUba7f4hsGgO/s85ScRE2FmGOpq21rw7W?=
 =?us-ascii?Q?9FegNXV8+Mrk+XZCyR4h57pzB5h88loti+gbAhomu843p2iM1j85X1P3xvfm?=
 =?us-ascii?Q?g+glZ5pK84zsgB2Q0ESskI+fuJKzl2YwSYoqXgtM7q/d3Xjbmj+w61GJSSqN?=
 =?us-ascii?Q?gFV6PVpgwMWERqrXnqC4m4zTr24QjCA+U988SRpJJ4m6nJwICJxN1KgyOeSL?=
 =?us-ascii?Q?b6mXRB9bGR1UkELDSvqEItM3y7oR5ET6q2kuF4NnofhmwLvmk2yNkkvme5lj?=
 =?us-ascii?Q?xFeky12SJf1vlc0o7Kk3J5afkCkG8JjSD73jaKoC9VRtS02EOQlofJZm+ehr?=
 =?us-ascii?Q?yGqMPqg1ZapqPc2iSNnT1/mbOqfPqyg4kMXDGmtZG/x8ozmevOGJ3uWKsMjD?=
 =?us-ascii?Q?Rl3ZImowEX29Nk1Cm8t7ZWgG+/DbQ67HB20y1X0h4qPBf1CL697w/uX+BeQd?=
 =?us-ascii?Q?1rXZXrzFVRP39HcTGPFReVPQkyo3L5yvxp/ZOxbjHXxiRALg0ZRnsqWjkPNp?=
 =?us-ascii?Q?u3Bw05TS6+AmIl78Wlm6wY7oUNxHqUmVzCMYeAFN3eybGJ0/eR/+ak3ZMmxo?=
 =?us-ascii?Q?tEDpKbivxOBrY4FFIlYQtaXizlFuy/e8BarCpHLIQ4PCoAE+RlGbWFbbIVwe?=
 =?us-ascii?Q?qpbZzlE6H3p3gqW7s/03/tZWy3E4BKdKoVjVNfo6myDc+OPfqPlrMHIq6l55?=
 =?us-ascii?Q?ACG6UVYSNMW1qDGqLs+FB0t+MjM3bXYtmogOsfo9lDwBNip8pVV2ihbXfmv2?=
 =?us-ascii?Q?/Pdn1w4cUyXw+Hy6Vu3NOoAHZzAv9xy8UcVBJfQ39G7fGSzc0ZU9AEL9xpHD?=
 =?us-ascii?Q?wwqJqBQZg9DN5KrIxQg9ld6GdS7LX/PSa7KolX/OkO3Q/kapLjkAPEHi0oqf?=
 =?us-ascii?Q?eTMY/U3rSpEeDP/cuVzZE3SH3MGGHBJ/d/mxhBX88qXidTAyQR3gaIb2AIpP?=
 =?us-ascii?Q?ZNOEXYsu4hNCnuhoJDle1DIA1imNWhV7VKXRp9Et3EmMpudv+nhExH8DzA/G?=
 =?us-ascii?Q?INtg9DRkOBYjJ4BNw/s6/+fZLLleybUQ+j+Dt6QGDZEFaPFMHs8NJxwoK00I?=
 =?us-ascii?Q?e+lEc95gzxqY/m2cq/KNu422CM6q8/7lrE6cIHHb5VHzsq81FcZHA6lIJ7q0?=
 =?us-ascii?Q?n8qfvmb/Y1IukroG0CRFWDJlHtVwqu1fg4CjrpxB7Pmt4uWIynicdwYh2stu?=
 =?us-ascii?Q?TjAt17q72RDPBulKHrhUCYW3aRPHvK1DhLRk7Pd7CUG35w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F549DBF3F6E5B24782CFA1CD11AA0E4A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b45e60-3470-48be-4ebf-08d95d02cf92
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 20:01:30.1942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Jotb+cKlRlDA//wTSJdmyUFm/PuSz/+czz6xv4m/ASS1Hpb1ssMTHptbQDIIij1GwpUxB3txwFaoJKDJeR3dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4768
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110137
X-Proofpoint-ORIG-GUID: 25K84QKsNSuIdd346YC12QnvDHml-bDB
X-Proofpoint-GUID: 25K84QKsNSuIdd346YC12QnvDHml-bDB
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 11, 2021, at 3:46 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Wed, Aug 11, 2021 at 2:52 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Aug 11, 2021, at 2:38 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>>>=20
>>> On Wed, Aug 11, 2021 at 1:30 PM Chuck Lever III <chuck.lever@oracle.com=
> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On Aug 11, 2021, at 12:20 PM, Timo Rothenpieler <timo@rothenpieler.or=
g> wrote:
>>>>>=20
>>>>> resulting dmesg and trace logs of both client and server are attached=
.
>>>>>=20
>>>>> Test procedure:
>>>>>=20
>>>>> - start tracing on client and server
>>>>> - mount NFS on client
>>>>> - immediately run 'xfs_io -fc "copy_range testfile" testfile.copy' (w=
hich succeeds)
>>>>> - wait 10~15 minutes for the backchannel to time out (still running 5=
.12.19 with the fix for that reverted)
>>>>> - run xfs_io command again, getting stuck now
>>>>> - let it sit there stuck for a minute, then cancel it
>>>>> - run the command again
>>>>> - while it's still stuck, finished recording the logs and traces
>>>>=20
>>>> The server tries to send CB_OFFLOAD when the offloaded copy
>>>> completes, but finds the backchannel transport is not connected.
>>>>=20
>>>> The server can't report the problem until the client sends a
>>>> SEQUENCE operation, but there's really no other traffic going
>>>> on, so it just waits.
>>>>=20
>>>> The client eventually sends a singleton SEQUENCE to renew its
>>>> lease. The server replies with the SEQ4_STATUS_BACKCHANNEL_FAULT
>>>> flag set at that point. Client's recovery is to destroy that
>>>> session and create a new one. That appears to be successful.
>>>>=20
>>>> But the server doesn't send another CB_OFFLOAD to let the client
>>>> know the copy is complete, so the client hangs.
>>>>=20
>>>> This seems to be peculiar to COPY_OFFLOAD, but I wonder if the
>>>> other CB operations suffer from the same "failed to retransmit
>>>> after the CB path is restored" issue. It might not matter for
>>>> some of them, but for others like CB_RECALL, that could be
>>>> important.
>>>=20
>>> Thank you for the analysis Chuck (btw I haven't seen any attachments
>>> with Timo's posts so I'm assuming some offline communication must have
>>> happened).
>>> ?
>>> I'm looking at the code and wouldn't the mentioned flags be set on the
>>> CB_SEQUENCE operation?
>>=20
>> CB_SEQUENCE is sent from server to client, and that can't work if
>> the callback channel is down.
>>=20
>> So the server waits for the client to send a SEQUENCE and it sets
>> the SEQ4_STATUS_BACKCHANNEL_FAULT in its reply.
>=20
> yes scratch that, this is for when CB_SEQUENCE has it in its reply.
>=20
>>> nfsd4_cb_done() has code to mark the channel
>>> and retry (or another way of saying this, this code should generically
>>> handle retrying whatever operation it is be it CB_OFFLOAD or
>>> CB_RECALL)?
>>=20
>> cb_done() marks the callback fault, but as far as I can tell the
>> RPC is terminated at that point and there is no subsequent retry.
>> The RPC_TASK flags on the CB_OFFLOAD operation cause that RPC to
>> fail immediately if there's no connection.
>>=20
>> And in the BACKCHANNEL_FAULT case, the bc_xprt is destroyed as
>> part of recovery. I think that would kill all pending RPC tasks.
>>=20
>>=20
>>> Is that not working (not sure if this is  a question or a
>>> statement).... I would think that would be the place to handle this
>>> problem.
>>=20
>> IMHO the OFFLOAD code needs to note that the CB_OFFLOAD RPC
>> failed and then try the call again once the new backchannel is
>> available.
>=20
> I still argue that this needs to be done generically not per operation
> as CB_RECALL has the same problem.

Probably not just CB_RECALL, but agreed, there doesn't seem to
be any mechanism that can re-drive callback operations when the
backchannel is replaced.


> If CB_RECALL call is never
> answered, rpc would fail with ETIMEOUT.

Well we have a mechanism already to deal with that case, which is
delegation revocation. That's not optimal, but at least it won't
leave the client hanging forever.


> nfsd4_cb_recall_done() returns
> 1 back to the nfsd4_cb_done() which then based on the rpc task status
> would set the callback path down but will do nothing else.
> nfsd4_cb_offload_one() just always returns 1.
>=20
> Now given that you say during the backchannel fault case, we'll have
> to destroy that backchannel and create a new one.

BACKCHANNEL_FAULT is the particular case that Timo's reproducer
exercises. I haven't looked closely at the CB_PATH_DOWN and
CB_PATH_DOWN_SESSION cases, which use BIND_CONN_TO_SESSION,
to see if those also destroy the backchannel transport.

However I suspect they are just as broken. There isn't much
regression testing around these scenarios.


> Are we losing all those RPCs that flagged it as faulty?

I believe the RPC tasks are already gone at that point. I'm
just saying that /hypothetically/ if the RPCs were not set up
to exit immediately, that wouldn't matter because the transport
and client are destroyed as part of restoring the backchannel.

Perhaps instead of destroying the rpc_clnt, the server should
retain it and simply recycle the underlying transport data
structures.


> At this point, nothing obvious
> comes to mind how to engineer the recovery but it should be done.

Well I think we need to:

1. Review the specs to see if there's any indication of how to
recover from this situation

2. Perhaps construct a way to move CB RPCs to a workqueue so
they can be retried indefinitely (or figure out when they should
stop being retried: COPY_OFFLOAD_CANCEL comes to mind).

3. Keep an eye peeled for cases where a malicious or broken
client could cause CB operations to tie up all the server's
nfsd threads or other resources.

--
Chuck Lever



