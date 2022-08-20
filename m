Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC78259B0A3
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Aug 2022 23:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiHTVz5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 20 Aug 2022 17:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHTVz4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 20 Aug 2022 17:55:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51161260C
        for <linux-nfs@vger.kernel.org>; Sat, 20 Aug 2022 14:55:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KLTwGl012947;
        Sat, 20 Aug 2022 21:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6j5lZTLZ3JrTQfnDCp76ZVdO3RFyLZtkAMjAUPtXwlo=;
 b=0AdOT6ls2JdcCw5+W3IdTa+ZNvFW8FzcTCJBQvDS1rUSkWiNCwr5FJDMG7u2IX2QyXb1
 cL4izrBNsaAP94tvxnNoBb2f3vzRXpdrdFgc9o/Hseem7sQcgqMBcBAnacDpdk194bXf
 JPJZsnMm10zq78jxcA3iDrQugqIpwlO6FnyQrvK+x9hHgYkMgf2cwpBtQ0pwiXP4R0pY
 8umSiiD/rbJywWJrtquGb4hhGVLh7RRH+0Ji3qsH53b4OwzrsPWzJDKCV9s2GiT9HUWT
 Z6n6oxgY08/DLBgy04q35xZ4iGHdiXy9PpivsIDJvwNVxR2L+UxJIkheDzauKrSwrH2m cA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j37jyg0d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Aug 2022 21:55:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27KIj59p040924;
        Sat, 20 Aug 2022 21:55:36 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j2p274rqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Aug 2022 21:55:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQHK+GPbYbL8F1Q9MNjJbJzlBtK12DQr1APZnXpyeKOOXi3ENXqmqPZkQGDvHZkCoefo/0lcbhFma1cWQlmUFv4F4uItdVSzESGl+2xVNPNpNQGlGcrq7MYx/Y1HGwzCMQiYnJquacbyUTcp0vp4RSBpTwC6fRtKDke/Oid28rWYXS/uuqkq2ZmG8yBZYplPVaE/aM4VltyUtNC2/KQGvT2X44opZW8tTN8Jdyb8R6SGoXDIHOAN88Hg/PW20ZasBcCFoIHhQ8Zh2ET1u71b+DMR0J8zWFAd/j5+B6KmgLqWyBPAEdoIqBrFbHrP7wwS8mn6Uh1H3l3S6yvC80xYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6j5lZTLZ3JrTQfnDCp76ZVdO3RFyLZtkAMjAUPtXwlo=;
 b=R/as3qapdtM7Qg2ihO2df6lbwM0PeFimDAgfrw01Mzk6j+uLMmC35Qc+G9FFVqRciN6JtOeu4YtNniQoEMDmPeZOXx73jOWU3oXk1lHo7JePFpOXLfypn5s+6WkiVxLYHa+lAH6dxGv5AZzceQdp6moJQRv44jZDsfNMpHXfxzY+xI/KOR2p0kBJEmOv4L/zeG2VvgGNCyeyIP8ObLiOufaHstxtLqIpZm6uWeACGDFDdr+6WhfqbsY/oK51OUoh7/OnjMMhqj3r5UH5ufmMCJZmRcoCYNharqY3vm0VdOBHqCzo6MyCsA7gz94zKZaIEDG0VA/HTZx+TnXm3J2vDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6j5lZTLZ3JrTQfnDCp76ZVdO3RFyLZtkAMjAUPtXwlo=;
 b=xU5lb9Kx9FlCRIXW/DZkn+i1Ky0NRNANiyX1hLrwj79UlKDvn3KcLdDDadyxfYSzo52co//qpJaI9GhoK3mqrl63nvvfEjA7iGJX+MHMUURDJczWd3hT+bSIH/H7Pb+Lgb8Z8qd9bO3EfGUxJWTZ2jE962yrzmbWISma7+iJd9M=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5699.namprd10.prod.outlook.com (2603:10b6:510:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Sat, 20 Aug
 2022 21:55:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9%9]) with mapi id 15.20.5546.021; Sat, 20 Aug 2022
 21:55:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: check_flush_dependency WARNING on NFS/RDMA mount
Thread-Topic: check_flush_dependency WARNING on NFS/RDMA mount
Thread-Index: AQHYtN+Sv4pAiwwN90esG+z2zuh7AA==
Date:   Sat, 20 Aug 2022 21:55:34 +0000
Message-ID: <229A8283-F857-4A34-99B8-EC71BFEA4C55@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0613d9d2-1efa-4154-b70d-08da82f6b554
x-ms-traffictypediagnostic: PH7PR10MB5699:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NPFf8jOavE6G2iGS0A7Qa6zYPWjf2W0XSXhA1vPJ45mFW/WXq3JsSNbFBNQRxoF5PSbLznr7hZqT/zZJTrgjWZBPTjhQw7VPClwaDZjFsqb1lO58Jaxiylc9w72ky/WevnqD2iSvmGcO/1aHoi40nxPY2ehhzPuVBwkoyqatXZXGfT3oSYpbyjl0INcVVZ0EFURMBAoChDWhWKmjl/+oZFnDDJZKW+lxoqPNs7g5zUQa47oompeTprDQaHKqEiBTlqfpqGXCwBleC8LQU5TjRJxHWZvgshOuBg3DLlLIqYPqtrFuLkFMCa+JDXgeES+iibm3+19vCskJ1GmleNc8RotDPhs2fTN/znvLKd5q8MroJKK6V2R29eV8FQvJ7G31XxwC5hEjHhDWyBUGb1PetY0GawVr9EXZtbw6dNddYi1azHd93OAg0BcZmkp7D9PGn0aAitj1XPftobe2yb6bBeZFJgUx7X42TMqnOR+0do7lOQrWK2pJg+4giOEXngYHuhk5un9jnJs+ZE25EHb+G5hur+Ate2IzYCHvCiOxdhT/Ec12d1JDXW2JQh5aH1sZAa457dX2NS2Zn30g8bWxOgXh9WBw3a8HZCmol0GSLUywDR7fZxD8dQ+yLiHayR58/KPY2V6uIcmrYZPEI2nVOFp+64sYKsNiRIo56lyl8kLrD8y67cDjzuF6gO6PoaQBKllZLhp6nBXjUD4C2J7Y4V4v6N4/HZWTSVnapn9Tv4hCUIqbo6o6xC/OlHh2bZJ9csUhjRg2yH2UBY3cidheiKX/AqloKBax+6FlAWNNu2w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(396003)(376002)(39860400002)(86362001)(2616005)(83380400001)(122000001)(38100700002)(38070700005)(186003)(8936002)(5660300002)(478600001)(76116006)(66446008)(64756008)(66476007)(66556008)(91956017)(36756003)(4326008)(41300700001)(2906002)(8676002)(66946007)(6486002)(6512007)(26005)(110136005)(33656002)(6506007)(71200400001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PwAgmSNWhI/fkhJYEWOD+nwFNNtI/SPlSkzVDCeA9TiQzeCtNuND4KS4vrEX?=
 =?us-ascii?Q?hNP3OlVUO68TNStp/pU9uz0FrsW4DyhEijgUTSF/KcRa9gYxr41/PxaoMASX?=
 =?us-ascii?Q?UPshkUcYR/sJyo+k9BpanjUqLIgfCByis8UxrBF+x2fYFq2SUBzc1B5oxhgc?=
 =?us-ascii?Q?Dl+E8TPAGaDCSfRxnDscZwYhcieJX4+BfYf3jivFEipqityl4ZAVZqYF/8i3?=
 =?us-ascii?Q?fR6Gdhxkbl84uczR2U6WAQSbhrmeF0erOOThMeM895hcwhw1FkAifp70eNbe?=
 =?us-ascii?Q?V38SGb7ux9sGd7ZIVGkw1R/3XWi2Og4Jk+yP1neT0W+14fwN7RuKNuC/wAaz?=
 =?us-ascii?Q?dPXdJTCZFD5eia9EnLX21gxMyXj3VmqeG3xZ1dBrFhJjEmP/iIifdlC+jodx?=
 =?us-ascii?Q?wE+51vWGdQ4E2VeHCpA3j8Ih0rvSMPvTWMi2hSf0CtHJPOizMXLVhl5OMqGl?=
 =?us-ascii?Q?kqCM0szjUWiHHGPib5vsgiY5XgeNSAYmunTDSPKq2tFze+zxVTOF4Pwh42KE?=
 =?us-ascii?Q?IfKlrgl4HYxYaxbeU25ciys1IPyCJOPPv+EvDVPGLnqL2IjCXXq+7Z+4gt27?=
 =?us-ascii?Q?r2hKYqa+mkv3MHoQcd5bCiO4Kt/aRPtnHU1ODZVL4Kg0+T8wz3lIesWVxT31?=
 =?us-ascii?Q?EYXMazcD4dyqjphc2dbQ/D+WzzB2IQDQZ6VberJ0Qp1PoqXD0kYpW5mbTvp7?=
 =?us-ascii?Q?vS/G2uE7ondY8XndEQx6HHtPuJ+qu8knoiNIo9abwMt6faBEg4aKvR6M7zjS?=
 =?us-ascii?Q?0r2FPt8j+MD9k31MGwYfbh8NkFvMjrgrH9G78wKTdabjxvKdERsQ25df7XdP?=
 =?us-ascii?Q?YB/00wXMrgwQL7gxa0hRRJQ01W5X0HBz0PrOxrffrZW5OMl+1vLxZSTDWi6I?=
 =?us-ascii?Q?vI8oiIJyz+b3qbtfLiBmwAilu0LPaWhS9ZGzZIndFg9RL4qFDfvOywlbovUC?=
 =?us-ascii?Q?inM7pRXWt4Te0e8mCXyHE7StxfRp7JFGfLwjA7EtBIUYCV2fg37BHlb7Rlht?=
 =?us-ascii?Q?heSbn/4oQIYClBh/kE44MbgSjGEJu6bCeVpgI3YtaSDFS8JN0edAzYj09w4e?=
 =?us-ascii?Q?ZeltJTWDSjAg2wv0BTjSmOZzTFyVrVhd3QDACyWiQarVUPmh5mC9J68B7ERN?=
 =?us-ascii?Q?NNnoDRBjzGOLNLPo23OkJowdAE6UdzoZ/qEeqk/myCM1UZIvsD7zCdVIB9d+?=
 =?us-ascii?Q?qvZrxeteiCaAAWRGwK+7EzXPM/Q3Q15vdc1qUN1zj+cf7KlWw56wpkkf0kQG?=
 =?us-ascii?Q?yTcKsovoyashCZWtv1ZPpY1JlyqVQchQ9BzI29PcCrU3NUI4b5Zkt7v7xJPv?=
 =?us-ascii?Q?ZvNP9BM+dpefWQdZqyVJWbgzu3mCFQqEjfjOLuEjhLrq6Q96liWMQ3SChU9R?=
 =?us-ascii?Q?UbPsMQgYVSgM1KPWyr3WIo6mA+BXsdMqRXPbO4Tcom89GVxBe0BB/lM72aIZ?=
 =?us-ascii?Q?1W66ony7fBakmhDO9BEdgeho/h4anC521nS7BPSse5UniMxSmfK7+UBBFUPS?=
 =?us-ascii?Q?sKSE9ZLpfpbScLx4l6uUOjHs2RTkwNHYnsfYuTUDln54SfxVa5S9OE/w3ft4?=
 =?us-ascii?Q?UuKeXR57eDfReS6GsB5/bl1rvvgnljUHxo7xzZSUr9h7shVfgHxHw06Jzkyk?=
 =?us-ascii?Q?IQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A726879B5783E8468170F5025BA9A7FF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0613d9d2-1efa-4154-b70d-08da82f6b554
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2022 21:55:34.1984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B64ZSS3l6oFcPn7SRbnlfeV2HuqM7iGo+36j54lbCMKmB0FZ/t6BFUFgUQl+w8XU+aUUFqHGesoMNm0JLEgSMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=923 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208200094
X-Proofpoint-GUID: U9zIua2VsrTpGetvKqFoZjI7_R_cFak6
X-Proofpoint-ORIG-GUID: U9zIua2VsrTpGetvKqFoZjI7_R_cFak6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

This warning just popped on a stuck NFS/RDMA mount (the Ethernet switch
port VLAN settings were not correct):

Aug 20 17:12:05 bazille.1015granger.net kernel: workqueue: WQ_MEM_RECLAIM x=
prtiod:xprt_rdma_connect_worker [rpcrdma] is flushing !WQ_MEM_RECLAI>
Aug 20 17:12:05 bazille.1015granger.net kernel: WARNING: CPU: 0 PID: 100 at=
 kernel/workqueue.c:2628 check_flush_dependency+0xbf/0xca

Aug 20 17:12:05 bazille.1015granger.net kernel: Workqueue: xprtiod xprt_rdm=
a_connect_worker [rpcrdma]

Aug 20 17:12:05 bazille.1015granger.net kernel: Call Trace:
Aug 20 17:12:05 bazille.1015granger.net kernel:  <TASK>
Aug 20 17:12:05 bazille.1015granger.net kernel:  __flush_work.isra.0+0xaf/0=
x188
Aug 20 17:12:05 bazille.1015granger.net kernel:  ? _raw_spin_lock_irqsave+0=
x2c/0x37
Aug 20 17:12:05 bazille.1015granger.net kernel:  ? lock_timer_base+0x38/0x5=
f
Aug 20 17:12:05 bazille.1015granger.net kernel:  __cancel_work_timer+0xea/0=
x13d
Aug 20 17:12:05 bazille.1015granger.net kernel:  ? preempt_latency_start+0x=
2b/0x46
Aug 20 17:12:05 bazille.1015granger.net kernel:  rdma_addr_cancel+0x70/0x81=
 [ib_core]
Aug 20 17:12:05 bazille.1015granger.net kernel:  _destroy_id+0x1a/0x246 [rd=
ma_cm]
Aug 20 17:12:05 bazille.1015granger.net kernel:  rpcrdma_xprt_connect+0x115=
/0x5ae [rpcrdma]
Aug 20 17:12:05 bazille.1015granger.net kernel:  ? _raw_spin_unlock+0x14/0x=
29
Aug 20 17:12:05 bazille.1015granger.net kernel:  ? raw_spin_rq_unlock_irq+0=
x5/0x10
Aug 20 17:12:05 bazille.1015granger.net kernel:  ? finish_task_switch.isra.=
0+0x171/0x249
Aug 20 17:12:05 bazille.1015granger.net kernel:  xprt_rdma_connect_worker+0=
x3b/0xc7 [rpcrdma]
Aug 20 17:12:05 bazille.1015granger.net kernel:  process_one_work+0x1d8/0x2=
d4
Aug 20 17:12:05 bazille.1015granger.net kernel:  worker_thread+0x18b/0x24f
Aug 20 17:12:05 bazille.1015granger.net kernel:  ? rescuer_thread+0x280/0x2=
80
Aug 20 17:12:05 bazille.1015granger.net kernel:  kthread+0xf4/0xfc
Aug 20 17:12:05 bazille.1015granger.net kernel:  ? kthread_complete_and_exi=
t+0x1b/0x1b
Aug 20 17:12:05 bazille.1015granger.net kernel:  ret_from_fork+0x22/0x30
Aug 20 17:12:05 bazille.1015granger.net kernel:  </TASK>

At a guess, the recent changes to the WQ_MEM_RECLAIM settings in the
RPC xprt code did not get carried over to rpcrdma... ? Need some
guidance please, and I can write and test a fix for this.


--
Chuck Lever



