Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CA159E8CA
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Aug 2022 19:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245020AbiHWRLv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Aug 2022 13:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344660AbiHWRLK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Aug 2022 13:11:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683CBAF485;
        Tue, 23 Aug 2022 06:58:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NDvOef019350;
        Tue, 23 Aug 2022 13:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DNytdAE+8oYoFd2Cy7i1o8IEM2FfTwyk7KPW0Ott8R4=;
 b=zZIk3atAbHgKAGL3FdflPvWZua3pCC7pAp4NZggHnDF0Q7CDMysZ/spBRFqteEhXO2mR
 POQWAHuCa6ROPQI0waG8if6TZh0JXB0/Vn1BW5tGBq8ZN9fQTQCXCQgmocqDw/QzPbEl
 XLH5H1h3tDdBYV7C/odiM3Z+lSDeRGnjLvRHEm0nNRr18+5S+Q4qvhkodDgwgTe/FRUq
 kYo7P6KFQwSf6axOhSkEW3bmqP4qkU/n02tHonlwOX7ReghwonZ/lUWgn6yi9ImxgcB7
 7vj7iLtH8zs0bDt9IB/iOzEOscGqKyR5IEKywjk3MrN+fH51PhfqGGofoMw2J3v/jmP3 mQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w23rhea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 13:58:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27NCGNbO005817;
        Tue, 23 Aug 2022 13:58:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq31ws6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 13:58:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCIieN2o4bt0cde0QLP3OuLLwlOfYIZKNU27T2CRslpfr0TRG+KZD6y5Q/53tG6+dPuKxQv4OTxE0gM9v1+KXbH4IUheZ5Eoo/iY67inUdDm/dC8kD1mopq8MXPrjWEw6le4zYOv3wqt0wA06VQIHIOQL6UpiSqHrH8x1BCe8OXjYxdgHVWe1CT0np5u6tyjYaB7Bewyr9ElXkpYY/aeeTguy3dCqcyeKqfH17+NOFje4sF9lKZgQlb74PLm6oE+bLZ1FhqnGKX5zmXNNceJ4CWECVa9mNd2VgJIlB2LSu07S/977eT6hAcXGN+tQtAmPBvGnQeD4vxRY6DWo6hhFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNytdAE+8oYoFd2Cy7i1o8IEM2FfTwyk7KPW0Ott8R4=;
 b=A3YOVk8fLZ/yUwGzhgi/PPw7trWG8cfrc1Vk/xg0MgMId1S54aMVlVXBod7/w2Zgc+dlTKeBCxGRdRSQAlqYUxvSXqLb24/ZAudw3ipzRYi5YCxbfa/8ec4pYWCnn9lLsMKcx91UuqzkcwVRRLk0girGK5J8JRAtWjqzyezetU/WWUANGGHxn4aqwmEgShu2NitviAiRhcc9RdcLLaBM+b5V0Z4XEieNv/wpXT/yh8xsXPUcmfzx9N9GzUD586Z5XUTXEqo27ng6PVdzj1GcMmCoUPRPlvhrgkE3e04cC8KuNvYuRLgYqfXnmXor89e1DYGkv/yhFoUSXOR1zqsy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNytdAE+8oYoFd2Cy7i1o8IEM2FfTwyk7KPW0Ott8R4=;
 b=Np0KVzNnN2zCL4hYYC703BudupQGsW2abfXuKCJ1+6DvLjhEUxu1FV7iqWV53wjfbCDNfIexE4u5GdQJlRd0I1F4GuQgtAvzJYkm0CMrEMZhLwr5ByojmYUw0W6wJHB/ZUoaCsbr8Goe9NG1uZ+SrRKbMhiKMRgpfPGwhJY4QJU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5245.namprd10.prod.outlook.com (2603:10b6:5:3a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 23 Aug
 2022 13:58:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9%9]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 13:58:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on addr_wq
Thread-Topic: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on
 addr_wq
Thread-Index: AQHYtjxDHzOcFbDad0CgCtqOY9xpUa28It+AgABhkYA=
Date:   Tue, 23 Aug 2022 13:58:44 +0000
Message-ID: <584E7212-BC09-48E1-A27E-725E54FA075E@oracle.com>
References: <166118222093.3250511.11454048195824271658.stgit@morisot.1015granger.net>
 <YwSLOxyEtV4l2Frc@unreal>
In-Reply-To: <YwSLOxyEtV4l2Frc@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0a58893-6082-4a4a-afc2-08da850f97a0
x-ms-traffictypediagnostic: DS7PR10MB5245:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vxLepmZqXzBBgRqLVgkI4M9oiBL4sEoxpe19h9w0w6K2lcndRjQXxjZM7yoL9agtPFQ+1tJlcXf1TedawbyPhm7gIwDIa2o7/EIqDE/mLzQuFAQmfIwXZwFoTba/NbVoTacc1DNGTAfzKG3ifWaAfXZXWhW7qWej6Z82CHYeqJnOG20RcDoYm81PlcpxzMAV5IdsNAhvwBHWi7xKPor/gWNvl3l/T3P2NTtkAaMidz28c2zk6dUT8xSAVscjXkVJsr4aGQUml0sv/WHgX/SupC7xdLOOZX1r+T4LfkXCBObXqTaxiDr+Gya4Tm8YgQsROkTBNfgZzXLiqFdUtMOONk5SMRNKkDcUSJZ2FfhSRARuix4CCsj67sfGBuHj7rEiUngE54BTjqx0lL5uEz5TfuNxUc6+4iXSp0cxJk7xrDTDEyTC6cYuBcEomUC8l5wXmJ4sUoGadnRQ1e3dxOtoG80DXzUes846RsJr4Laut03WwRucHAl8ZmL2Eu06I7aFM80kbSbp7MuZCBgyQ3VMlog+MzrfDUSy/BvbNw473oxessRyM9Gp37LnlIRZwLh/Ys/i+D72CWdc4YAuJiKgxMv5Xb0KKDo/09Zz9mg2/m/TI6Shid4GbMfiKcYkNs+7zrMDs9BRJgUmEhCdMWO3tDK+bn4yZP6oVltYE3yxhb2Ai6wuKS2Mz7+U4spdNl7vwwzDGMHdR3ID1mBrpAZMW3NNl4eQHUv9b0eQ/C33Cj91+CJokfI8gb/xSVNHEcvF93zX6ElANyn5vd0HKgWpiwhTnuUNbYVaOVyLI0vwgtg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(38100700002)(33656002)(86362001)(186003)(2616005)(6512007)(26005)(2906002)(6506007)(53546011)(122000001)(38070700005)(83380400001)(8936002)(41300700001)(316002)(6486002)(478600001)(5660300002)(54906003)(66946007)(36756003)(6916009)(91956017)(76116006)(66476007)(66556008)(66446008)(71200400001)(64756008)(45080400002)(4326008)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rrxVOfhHy/XV+IS36ZXOwRzHWXgoAeDrm/XGYProgSKCYhcuWpiU//wsFfOn?=
 =?us-ascii?Q?LrSUYLufiX9IrIDcTbFFaMMxNbknqylLLk4hCrk/bQex75PHtX8tvqdyD6fW?=
 =?us-ascii?Q?VCc5/pRTFiPSrmUwwudjQKsx9I1DaJoKHswjWh72wKHrkz2JvGfWhFPXMxz/?=
 =?us-ascii?Q?qjuq5V7IAoHSZJ4xGrVMAZ4RHuMto5eX+GmM81wtdqQicxbg8aJZ2rStUKNP?=
 =?us-ascii?Q?1gDoojIOre3aeLC/jJPuhvasanqXNv6/eCjtCLoU5R1PmcDT8mItjlo0N9zx?=
 =?us-ascii?Q?vWFhvL0dSGnfF6j+NFFQGnB2/rvfuI03jetlQIViWQpk5ZzWd3mlLdjnIshU?=
 =?us-ascii?Q?y9NDypgSzdoCRt0clo004KI5AvGVJ+1kmehrqY5sYk/Jfche4sKnT4dFoheY?=
 =?us-ascii?Q?Or0Cm6lpZGj8YC4KIeCj1B3UN1S5u/6laTKpPg6kKRlFUt3Tn4slWTg93VCs?=
 =?us-ascii?Q?y4C9XKPy1J8l8JFWiSpreim5kxkEyurBxFKqbywdDUu5BhfsJwDojtICd+gC?=
 =?us-ascii?Q?QU/8JTYEKp4RLJF0QPNax9bIQ9xH3jx/eZdmlhPk6dIl4l9ZgYuTxtMEXJA4?=
 =?us-ascii?Q?V75Qt8r7M7KheEQE9cWYCBoksCE/mAFGCm2NuAfIrulchUKvHHGxY2oKzW6t?=
 =?us-ascii?Q?LerzdxNA+rXqvyjUwu1xCzyBuuzB9tCxewHs2cVCTozgo3dRHRgt842P/Z+S?=
 =?us-ascii?Q?o4QKsDQvUdPdMy8xWTyCpuv8LeGq/b3/ULkgMLb5iV3GE7MmqwoohvIixwTX?=
 =?us-ascii?Q?r4cE1qhLgCmKKhIU9RdCr9PXgOpNYHLi6p9dBQmvsg70prVNz3oVDTY4jCeo?=
 =?us-ascii?Q?vvDsL36mF7ItMdpKGZWvXwtSCgpKC8rFu2nNRLHv1HOzhHU2zFGMjOD6+xoO?=
 =?us-ascii?Q?vMx0wC3uxDNQNuQRbSI4OthWijZGLvlrY1EdGzTLsMsJtziKn2KJWLIBBLr3?=
 =?us-ascii?Q?YgkjSP/6Ri56ixfHUr19fPaYoM4DQ09xAeeHISWo/u/uMC7pFOk64G0Vg01k?=
 =?us-ascii?Q?ON9ZK81yg4SGh/CUGtPXZHeYMWKhzniAeBWMYjSRQ7+p/wS7+MStk9WZuPi7?=
 =?us-ascii?Q?kYbzNxQkBPsKw90cXxR78vYKwTrgaWLYLHfbfHfmVRGX8bCGaN5kHYyUmN3c?=
 =?us-ascii?Q?v25nPBjeCOqK/suhNNUG8KIhl3kQxfMKHrINteCwNNO2ciO7w7W+aE0gsMFD?=
 =?us-ascii?Q?xFx+5hLnnGzitdN5vSwfwXiQradF4YhrbHGIl0ZlXyHLZmXvu2wFbybaeveC?=
 =?us-ascii?Q?mr+ZUSKZ5veJfa0MX/3owfrY1mZL7aWK+LrdJEgf1Z8z3DWLt/rvaX2dP9/F?=
 =?us-ascii?Q?4B0mhiZooh6tVx6iOg6U9Pp7VULbS/RBuACWbSOWQVs9RiIb233VuAfqbaLw?=
 =?us-ascii?Q?txtZvf4aavS+shZQu5lUcZTGSOEPZU9MfB5DyB8ywaynCkONgd1/o9JPudV8?=
 =?us-ascii?Q?0Nmsba/0WKDPtwd+58QrYATIfxD6XNcqGDLE5c91f7ytwPXAS78n0TBh+ypM?=
 =?us-ascii?Q?A/2fFVN+9PMxzbQ+8ZXle/c4Y9QbvxUDZk+r5GzFjujwg7gmllCPgzTUioBd?=
 =?us-ascii?Q?b3cQRCCj8WzSRp8hixOQtnJmW/TZeerbkPnw+L8pEQCePTHPoJXaOmavru7V?=
 =?us-ascii?Q?2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FC4E7E6A28D1434A8020EC47198F830F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a58893-6082-4a4a-afc2-08da850f97a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 13:58:44.0771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QpBKWa5aoepLaq6ej+kL49TFwjlzI1XAHSzOqEVKF5dI988fsy1VTjRNPB59MoN3kQTCc+ABGk0+q8HYh6rXUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5245
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_05,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208230056
X-Proofpoint-ORIG-GUID: fzX87KF7HldojEySnL1tS79BWsQwXTVH
X-Proofpoint-GUID: fzX87KF7HldojEySnL1tS79BWsQwXTVH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 23, 2022, at 4:09 AM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Mon, Aug 22, 2022 at 11:30:20AM -0400, Chuck Lever wrote:
>> While setting up a new lab, I accidentally misconfigured the
>> Ethernet port for a system that tried an NFS mount using RoCE.
>> This made the NFS server unreachable. The following WARNING
>> popped on the NFS client while waiting for the mount attempt to
>> time out:
>>=20
>> Aug 20 17:12:05 bazille kernel: workqueue: WQ_MEM_RECLAIM xprtiod:xprt_r=
dma_connect_worker [rpcrdma] is flushing !WQ_MEM_RECLAI>
>> Aug 20 17:12:05 bazille kernel: WARNING: CPU: 0 PID: 100 at kernel/workq=
ueue.c:2628 check_flush_dependency+0xbf/0xca
>> Aug 20 17:12:05 bazille kernel: Modules linked in: rpcsec_gss_krb5 nfsv4=
 dns_resolver nfs 8021q garp stp mrp llc rfkill rpcrdma>
>> Aug 20 17:12:05 bazille kernel: CPU: 0 PID: 100 Comm: kworker/u8:8 Not t=
ainted 6.0.0-rc1-00002-g6229f8c054e5 #13
>> Aug 20 17:12:05 bazille kernel: Hardware name: Supermicro X10SRA-F/X10SR=
A-F, BIOS 2.0b 06/12/2017
>> Aug 20 17:12:05 bazille kernel: Workqueue: xprtiod xprt_rdma_connect_wor=
ker [rpcrdma]
>> Aug 20 17:12:05 bazille kernel: RIP: 0010:check_flush_dependency+0xbf/0x=
ca
>> Aug 20 17:12:05 bazille kernel: Code: 75 2a 48 8b 55 18 48 8d 8b b0 00 0=
0 00 4d 89 e0 48 81 c6 b0 00 00 00 48 c7 c7 65 33 2e be>
>> Aug 20 17:12:05 bazille kernel: RSP: 0018:ffffb562806cfcf8 EFLAGS: 00010=
092
>> Aug 20 17:12:05 bazille kernel: RAX: 0000000000000082 RBX: ffff97894f8c3=
c00 RCX: 0000000000000027
>> Aug 20 17:12:05 bazille kernel: RDX: 0000000000000002 RSI: ffffffffbe344=
7d1 RDI: 00000000ffffffff
>> Aug 20 17:12:05 bazille kernel: RBP: ffff978941315840 R08: 0000000000000=
000 R09: 0000000000000000
>> Aug 20 17:12:05 bazille kernel: R10: 00000000000008b0 R11: 0000000000000=
001 R12: ffffffffc0ce3731
>> Aug 20 17:12:05 bazille kernel: R13: ffff978950c00500 R14: ffff97894341f=
0c0 R15: ffff978951112eb0
>> Aug 20 17:12:05 bazille kernel: FS:  0000000000000000(0000) GS:ffff97987=
fc00000(0000) knlGS:0000000000000000
>> Aug 20 17:12:05 bazille kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
>> Aug 20 17:12:05 bazille kernel: CR2: 00007f807535eae8 CR3: 000000010b8e4=
002 CR4: 00000000003706f0
>> Aug 20 17:12:05 bazille kernel: DR0: 0000000000000000 DR1: 0000000000000=
000 DR2: 0000000000000000
>> Aug 20 17:12:05 bazille kernel: DR3: 0000000000000000 DR6: 00000000fffe0=
ff0 DR7: 0000000000000400
>> Aug 20 17:12:05 bazille kernel: Call Trace:
>> Aug 20 17:12:05 bazille kernel:  <TASK>
>> Aug 20 17:12:05 bazille kernel:  __flush_work.isra.0+0xaf/0x188
>> Aug 20 17:12:05 bazille kernel:  ? _raw_spin_lock_irqsave+0x2c/0x37
>> Aug 20 17:12:05 bazille kernel:  ? lock_timer_base+0x38/0x5f
>> Aug 20 17:12:05 bazille kernel:  __cancel_work_timer+0xea/0x13d
>> Aug 20 17:12:05 bazille kernel:  ? preempt_latency_start+0x2b/0x46
>> Aug 20 17:12:05 bazille kernel:  rdma_addr_cancel+0x70/0x81 [ib_core]
>> Aug 20 17:12:05 bazille kernel:  _destroy_id+0x1a/0x246 [rdma_cm]
>> Aug 20 17:12:05 bazille kernel:  rpcrdma_xprt_connect+0x115/0x5ae [rpcrd=
ma]
>> Aug 20 17:12:05 bazille kernel:  ? _raw_spin_unlock+0x14/0x29
>> Aug 20 17:12:05 bazille kernel:  ? raw_spin_rq_unlock_irq+0x5/0x10
>> Aug 20 17:12:05 bazille kernel:  ? finish_task_switch.isra.0+0x171/0x249
>> Aug 20 17:12:05 bazille kernel:  xprt_rdma_connect_worker+0x3b/0xc7 [rpc=
rdma]
>> Aug 20 17:12:05 bazille kernel:  process_one_work+0x1d8/0x2d4
>> Aug 20 17:12:05 bazille kernel:  worker_thread+0x18b/0x24f
>> Aug 20 17:12:05 bazille kernel:  ? rescuer_thread+0x280/0x280
>> Aug 20 17:12:05 bazille kernel:  kthread+0xf4/0xfc
>> Aug 20 17:12:05 bazille kernel:  ? kthread_complete_and_exit+0x1b/0x1b
>> Aug 20 17:12:05 bazille kernel:  ret_from_fork+0x22/0x30
>> Aug 20 17:12:05 bazille kernel:  </TASK>
>>=20
>> The xprtiod work queue is WQ_MEM_RECLAIM, so any work queue that
>> one of its work items tries to cancel has to be WQ_MEM_RECLAIM to
>> prevent a priority inversion.
>=20
> But why do you have WQ_MEM_RECLAIM in xprtiod?

Because RPC is under a filesystem (NFS). Therefore it has to handle
writeback demanded by direct reclaim. All of the storage ULPs have
this constraint, in fact.


>  1270         wq =3D alloc_workqueue("xprtiod", WQ_UNBOUND | WQ_MEM_RECLA=
IM, 0);
>=20
> IMHO, It will be nicer if we remove WQ_MEM_RECLAIM instead of adding it.
>=20
> Thanks
>=20
>>=20
>> Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> drivers/infiniband/core/addr.c |    2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/ad=
dr.c
>> index f253295795f0..5c36d01ebf0b 100644
>> --- a/drivers/infiniband/core/addr.c
>> +++ b/drivers/infiniband/core/addr.c
>> @@ -872,7 +872,7 @@ static struct notifier_block nb =3D {
>>=20
>> int addr_init(void)
>> {
>> -	addr_wq =3D alloc_ordered_workqueue("ib_addr", 0);
>> +	addr_wq =3D alloc_ordered_workqueue("ib_addr", WQ_MEM_RECLAIM);
>> 	if (!addr_wq)
>> 		return -ENOMEM;

--
Chuck Lever



