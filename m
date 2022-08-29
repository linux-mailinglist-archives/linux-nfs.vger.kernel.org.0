Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9DB5A52E6
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 19:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiH2RPL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 13:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiH2RPI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 13:15:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6092180F;
        Mon, 29 Aug 2022 10:15:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TGidfo029024;
        Mon, 29 Aug 2022 17:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/FCokW4FLcqMVdOLnuGTF+YoA/yLRLm656qlkFmCS6o=;
 b=EYyXjQnBUKmZ2dv1lDnivCAYxX9qg7jeFn/lSd+u5BN6y6QUSIu5OBCgL0cBKAs+UZfr
 DI4t4UR+E4ACRV5hmZGZ/mHZxbI6illQQ6j3mVSXVFYDhuSXk7HcP92R4cRQ8RkK+m6Q
 /q3o735LnnzfuUWAQS2FzsnC9/Yex/p0pzQc9Aopi297x03T1us9EWPnUtGo2g3W0INi
 dEkCPVNNsOL+UimTmV4SzNL+QVAdl4PxgdV8QXLmhzJWVYWPh1NoJJkmFbJCejtRxSLu
 O1FsylGjrevXDHO7uQCMysHZ04z+6Ts393ajuKsW8f6qQkZBm2MMWiJ/vHdqprilv8k2 hg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7btt403v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 17:15:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TGIEmH033360;
        Mon, 29 Aug 2022 17:14:58 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q2p2qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 17:14:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOxPwgmSfh5nOKW5gKkemqgx/PvcOdMt+irCnyiG5jAr81RRM1BWLM+J41nIF2PkDI3zPKRI8fMhaRbmIVOoGuL3VlrHLOhowhf091j/UHHMrzObfDSBmHpo+OM1nOdSKZaC41/bdzF7PNks+lEm5FBf6smC1xGU/8zkPIUYXRjNJ8qFJiw/x3Q2vo24Zb+62IaCxvzb0EqQUEOkVpvW0CNntqevJ3kbPKepO6guLIkZdA5KRaA91K0oOZFtPAVqrhXI2bNp+OvRPKuAdT12Yl0PNqR5WCLMp2Ma7MGauoez3VvyYPGUUaUWUOS0gpS9PWazutXnpP4AnI37/oJJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FCokW4FLcqMVdOLnuGTF+YoA/yLRLm656qlkFmCS6o=;
 b=TcuHQphw3ElxMqe/MfANTC474mfqGElyxil7a4RyX1dBLGtRnJ3mpowCcpqN303BhFJ97in7F/YNe0U9QfxxOAWzbdDXBOrfrBHKOY1WxAHDuDNQvUq4wsIKMLD2548orzERNEz9W5XiniWeKEXapjgB8smEmHQplGrqEkTJhozgAilaW6zeW7CHhkgzOkeKe4KikenK49eyLb2nVR7g2DnKriPB/eXY/CGSoYnV3gK9mF6JYROZ/eMQ//qkUyCEBqq2T4o7ZIUVViIAKw67W+Jbtir9VrAufW3jWKVJXqBUVtpzYt2RgVV5dDvg6iFs0ZK/55/kDyJLRd63O/9jcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FCokW4FLcqMVdOLnuGTF+YoA/yLRLm656qlkFmCS6o=;
 b=Kv1XLzbVCZpZluvmhVYeY/8S5Bh8Ch7pLb9a74GY6Advkzxbk73n3aaVdRW+7ZfqmWF+0OMJjOp8a0FsG8L612LTim2ujLfVkvu2D2EwS2dIdImpZeg2fhoW07Q+pJXdHP9kOVtY2ImAlgKJyPtUBjIhA6TbHgPoBx/4XfYe76E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL0PR10MB2787.namprd10.prod.outlook.com (2603:10b6:208:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 17:14:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 17:14:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on addr_wq
Thread-Topic: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on
 addr_wq
Thread-Index: AQHYtjxDHzOcFbDad0CgCtqOY9xpUa28It+AgABhkYCAAUS4AIAAULmAgAMZTACAAAltAIAAAa6AgABhRICABIF0gIAACD6A
Date:   Mon, 29 Aug 2022 17:14:56 +0000
Message-ID: <90CD6895-348C-4B75-BAC5-2F7A0414494B@oracle.com>
References: <166118222093.3250511.11454048195824271658.stgit@morisot.1015granger.net>
 <YwSLOxyEtV4l2Frc@unreal> <584E7212-BC09-48E1-A27E-725E54FA075E@oracle.com>
 <YwXtePKW+sn/89M6@unreal> <591D1B3D-B04A-4625-8DD0-CA0C2E986345@oracle.com>
 <YwjKpoVbd1WygWwF@nvidia.com>
 <08F23441-1532-4F40-9C2A-5DBD61B11483@oracle.com>
 <YwjT9yz8reC1HDR/@nvidia.com>
 <FF62F78D-95EE-4BA1-9FC6-4C6B1F355520@oracle.com>
 <YwztJVdYq6f5M9yZ@nvidia.com>
In-Reply-To: <YwztJVdYq6f5M9yZ@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f899207e-1d10-41ff-9577-08da89e1fee5
x-ms-traffictypediagnostic: BL0PR10MB2787:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mlnInrFhWp3TH0qGigKn5o3/0/oVM6xTltbf+wvWVt0u+cA9Rg2Ww0lsNM1nR2UYsyERfb7nqbtvNWMpHa6GIlu/tLra5uiqkjidqfzu5S9jkTXKPaxJ379P8M+oL79fNOadwWkxsRmbZioFQglDoVgEb/tSJobJjDRlV2H6Bge4I89hvn6WbCX64CELrDaMseY0da0n1eVyNZrSrPL3OCSHVDzxYuQ0+bTmFsvZzN+8X9SwjBo0vTS14IFFmDk/mJfm2hjaag4sHH1uIXzW2LZ/uSViT36FKxAZnEcTlbYQP+5zITD+olLU+iwujHx4OJBTeCuMPOZU0q3uYs83CAMoIQ8os/LOAAqxOnmsbLigavbOjjuod6VvYnbou8ujz0H99wuFUxXd+WyseQHbM0V2rnvi8cXDUf72QMGUNNRrOkw05gwgFZHf/O2B/CKkod5XmnvyyZT17Ud7rSbp1eaKqIULvUl69eZCnf/rGr8xvQVDQG4WgPgaWi9pTXXWjE4+2b+YbhZdnGSS7Dtr9ADAmWEVu2JozF2NgkvYgPdcYpPfvzF5YXho7Irf/Ngv75gEegmnU//QU7N2ItVRtnmdMEB08zeCEagdkDPzJdAvsFFwMuO5l4QHrzKvBopI1q8p6jNTueK03jMzk/Om0ID2jsaAIfBkoWYBBf7hM8uFxeCJuKJauwvMkr0fuIzmddDoPiPRUeBBC6pVAZad1gvQSm0cngLUtZQcu1df+uGubZE6SRFSKQ8pLEjVyasYIt5xXaNgiAiBw7fioJem8zRc/5kD36P5XYZJqf92XlU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(39860400002)(136003)(396003)(346002)(6486002)(8676002)(316002)(66446008)(66946007)(66556008)(66476007)(4326008)(54906003)(8936002)(6916009)(71200400001)(91956017)(64756008)(76116006)(86362001)(5660300002)(478600001)(41300700001)(36756003)(38070700005)(53546011)(6506007)(2616005)(2906002)(6512007)(26005)(122000001)(83380400001)(38100700002)(186003)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UxNpnlbfzfGIAic4i6D4rflFEPJEhTQaJ0pfNw66zQrNTJSAIEjrNmkOqfL3?=
 =?us-ascii?Q?v5i7wzAKnwnjs3YJZ6K603FMqzjaRcv4SoqFhaeWtwVdCOkZ3y9hdOd6OLm7?=
 =?us-ascii?Q?N0kihGzNKE1ErGsskf0e5BtY+YvGXk7NTBjPVZWjvib8Fl2SMPtCVcaIdEWS?=
 =?us-ascii?Q?hYt2zwvOUb07hrvofkHwPAB1LQ3seFeig75ZfIS9H91PmKFt4d3EmRcqjPOb?=
 =?us-ascii?Q?Se0D/8qvsnOBppN9FtJyYp+b15AHGKN9UNHTz/egSLnXk7rv85fsE+TLM9xP?=
 =?us-ascii?Q?3CEkfM2W8uq++412OTcOqv9a51EZzckU0+NWnxQGM2QJSZUm2NyAbhPNG6hy?=
 =?us-ascii?Q?oRm6Py5WGMFcSSaXrM44NAdId92dq6X+JHFErt9or63YV0uSKdnFhm7PdB8Q?=
 =?us-ascii?Q?0/YCBtC+3l4HVfWCHMbDDDkwsttwFpAmYYVy4j6J8gewDp+kYd3XUji3vOgn?=
 =?us-ascii?Q?I1zdQEa9dXGFkcwWUSN6oOJBFJ80mlupt4OVFllV/St82usgKUXJC+hpcv1z?=
 =?us-ascii?Q?oor8hnKPbkSfZV/YKPbFeesALjkjmMxBqkv5GEIs9aTT655IUS8RL5Ll/xYi?=
 =?us-ascii?Q?WXdtY8Q/c7OabPSIWzP1wKkCAns2ijzEx7ro6CGs2RJm9K4NAN3bt/Dk5/eK?=
 =?us-ascii?Q?7fk53GzkNc8CsqTPlZn/G6Ps+D+mmTUmXayQr0Tz3hTWgZhY9Q3l87UmXoy6?=
 =?us-ascii?Q?++CACsVunPEJo9uE4JC14Jg/WmcY1YJQ645jHwcsNa/wie4lgTlJRnxQCiDH?=
 =?us-ascii?Q?0N/vtCYlp4VXvXKql8YYdlEfMSlDYS8WUMDPJVrR6DnA9b+0XRDalKAlBVoF?=
 =?us-ascii?Q?wAlwGACsSaBUH4uT96sfhgisxy4LVy3zcWNQGsHTo078ctw4zY1AyqEt0p3z?=
 =?us-ascii?Q?xix6Um0PiCDywCmA4xJpuQzB6XuCx9HqN4rpHn77Q6ql+CyychNHJkJiN+CY?=
 =?us-ascii?Q?k761Qu9SinXpcPhIcP+qCGzMgiT/isHtsFU+mh/92k4LzPnYB5h1dSUOlI3t?=
 =?us-ascii?Q?SppjH8oThAgbqhgfV963ArCziayb1a3L+qGQdpBeMH6PExiGonCg5TgDuxaj?=
 =?us-ascii?Q?7ZGQl4st2rszP44H4/AXxeaUzcLMiXAlIE+ECcejGFkxF7T3EHldYWvmXBW1?=
 =?us-ascii?Q?w3X4k5gNqBon4YjF77NxOD24anoqdgsZvOav6C+l5FZ4sQ2+0QAfvm4MVHsY?=
 =?us-ascii?Q?7VnJPrQx/XnLPYVSk9MJlKpPPymmzsdlS44DwFdQykFwAmxjSV+8AiIf/iKC?=
 =?us-ascii?Q?Z6/PhzS841nSyzQofF67toOktvquahgxxDt2SWZUSQqPjppLedzr+lJP63dZ?=
 =?us-ascii?Q?aWo6ht3YByfOS8exTBcxZ6VZC+6ZuodrkYIVus0NoVWUSLK/2dAPhGSOVykR?=
 =?us-ascii?Q?5ge210IyyQwcR7NBlSz5kEWw3bvMpcWC8ziduqMfygWj0HsEAUHyVgcNDXj7?=
 =?us-ascii?Q?MeSWEiBnJBpBx9UPyoox6cg5p88p2ARwMdxgm0FLjO/VKfr4DCATy1LJ/hQL?=
 =?us-ascii?Q?7Oy0JHkmioFYORw4K7Eb4z260jmQ2cOJh632TpQMUuD6rV2/JZOHT4SUF7aY?=
 =?us-ascii?Q?PCDCC4QQ/QNCMk3fJ7KTDbJr+HswjYIlQoEjMuYxgTfvOAe5xjfwkh07K/tn?=
 =?us-ascii?Q?Kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8100F58ED790D747AB50CDF1139A7E19@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f899207e-1d10-41ff-9577-08da89e1fee5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 17:14:56.3139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yvtVUYUMhJM+3CISqcyZjcLwqGjW3jLI+BPxcgQojLkTdHmC/1tfc0/pEJVl3DsXYgo188I/RM8WLyk1N1F++w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_09,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290080
X-Proofpoint-ORIG-GUID: Ep7FKVT3MOUUhuVSaVm-UtvbPHIC8AKQ
X-Proofpoint-GUID: Ep7FKVT3MOUUhuVSaVm-UtvbPHIC8AKQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 29, 2022, at 12:45 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Fri, Aug 26, 2022 at 07:57:04PM +0000, Chuck Lever III wrote:
>> The connect APIs would be a place to start. In the meantime, though...
>>=20
>> Two or three years ago I spent some effort to ensure that closing
>> an RDMA connection leaves a client-side RPC/RDMA transport with no
>> RDMA resources associated with it. It releases the CQs, QP, and all
>> the MRs. That makes initial connect and reconnect both behave exactly
>> the same, and guarantees that a reconnect does not get stuck with
>> an old CQ that is no longer working or a QP that is in TIMEWAIT.
>>=20
>> However that does mean that substantial resource allocation is
>> done on every reconnect.
>=20
> And if the resource allocations fail then what happens? The storage
> ULP retries forever and is effectively deadlocked?

The reconnection attempt fails, and any resources allocated during
that attempt are released. The ULP waits a bit then tries again
until it works or is interrupted.

A deadlock might occur if one of those allocations triggers
additional reclaim activity.


> How much allocation can you safely do under GFP_NOIO?

My naive take is that doing those allocations under NOIO would
help avoid recursion during memory exhaustion.


--
Chuck Lever



