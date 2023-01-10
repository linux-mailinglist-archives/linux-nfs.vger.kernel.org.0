Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973BE664BD7
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 20:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbjAJTBM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 14:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239673AbjAJTAt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 14:00:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CC51CF
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 11:00:23 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AIuiNo031880;
        Tue, 10 Jan 2023 19:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ke3xbo0fi5CE91wNQhtxMA3ptlOREC6K6/r65ydEOUE=;
 b=p7beGvIPMgBL1sNjsdje3SNX3xWyHDEeqHuAsXH73oQpk7vNKfuueuvQTZw/W8JlF/iX
 qcQuTDNJKhTHyW34fBsRYl2uOKmn/BGJqU1cPVGYMg2RSHqIhg8t3xhZxrIzFW9/nQ8F
 QvfSqQL8boAhr/Am4x/zhoZtd56U18emZIUecF5Nd6TxkBy1QCZNxEX3YY/JX1kOYzSU
 LPx756O59dmU9meLjlfGN2pi5lKbNjAsUZbNgcB0fnl7cX0HkLnK+0w5diJTs4SsO1gS
 d2zgQpmvBJTpE3XPAJeFMdz8PblrobT95LNd1Xh4y93Y+UVhgQMTwXhkJ1RUfqlqe/Et bQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n173bh3k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 19:00:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AIIpjW017114;
        Tue, 10 Jan 2023 19:00:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1d6chuav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 19:00:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=am/uCgxeOAkYm/LM6OROSZbBYpgbtM4DqOZXr2sRCRcrlOQOqwrYFH5bngz/IXVml+J0+CVzYcdAFVGt72Jxx2AWDkQJzE60kgQtPDM5aAx4tXeWBe2Dy21Cw22LeyDKNW+9ehvKlEBVrQ5Z29nZGWElWJNe17ITbWu3aVkDLnSdGMzTO66KfFAm3xnYM/elJh3au5j45BhOvJaRZ/vMFWTc+ginnef+vWZziOCavEz68bFVvnAq8oPdZ8Srf+DtpPw2sZihvkvl0VbhnFCgA55ubuPReKxh7MaUkl4/dik3xcSLeeNsE17+ufZUIVJMR0J1uW7tA0RWjLLvXSvDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ke3xbo0fi5CE91wNQhtxMA3ptlOREC6K6/r65ydEOUE=;
 b=TKz2EEqFwWc6yDG9KAQ1+dw3X26H5ZoqHunRWVAqUd2F1qQXEfiAhKFtzdQdzwFxA3A3y2JqAP5Yys0s+cNAwkO4y8a0ZS5MGYTMefqDiYOSHIkG4j6TJlYq+I19vpmyLJ/wo7s0ZnEbbqLT/EDxEhc/zoYq0mC4g9KdETJ+759p3Mn+Js2ioCyK06+n1UqN39vbRt1EaysJZ/nPEMoR7A8/fYuKs3A3dlzJNHFTfyfj9mA8yP1A4r3h/mJ1YPZ+sKGRpaZlTN8CUD02jFdLPmW6Nz2igPXdpTQPhAUFKd8r8LnZTlkIvl9ptiF7fmg8d6djNXDKyjd4hYqD4GPAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ke3xbo0fi5CE91wNQhtxMA3ptlOREC6K6/r65ydEOUE=;
 b=YNOlKTjHreltAiQKeCizKsCfmD+/Jc8yOpYOkzfW5ZN7D1rtsqd4xkqe/09fJNx50TXCoKrmdWcnCgsbegYP0Zp5qoYcP1Bbzolc/BVpAxbz2pW8GyC+/Z02cIKAcvwyGyyw7rJKEJ9GNZDCJEM1m+rUn9N+vbRjBY+elpt+CAA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5577.namprd10.prod.outlook.com (2603:10b6:510:f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Tue, 10 Jan
 2023 19:00:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.011; Tue, 10 Jan 2023
 19:00:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jorge Mora <jmora1300@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v1] NFSD: add IO_ADVISE operation
Thread-Topic: [PATCH v1] NFSD: add IO_ADVISE operation
Thread-Index: AQHZJSQBUzdcYqCpSkGTK0NFqr66B66YAUIA
Date:   Tue, 10 Jan 2023 19:00:14 +0000
Message-ID: <525FDD70-D00A-40DD-9C2A-71048F4D612E@oracle.com>
References: <20230110184726.13380-1-mora@netapp.com>
In-Reply-To: <20230110184726.13380-1-mora@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5577:EE_
x-ms-office365-filtering-correlation-id: 756b03a6-62aa-453e-6cba-08daf33ce861
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0nofHuxRKekUo9l1EvQkW328lZkIdBOFc7qg3iHj0LL3jvMrkx6F2QPbSve60M2W9s9lSlfZcf5OOxCbFFZ5/pTlL8mTdwo567qoXFmXTecBmF9Ya2VlLpjhTwk8mNDkv9Np9CfbT6KXLk5RxWSduTATS+P29pm5FDTJXnLpF+BRLQehtrEZhsMuPdfYHMazwxuIfP5Pl7DYgHEtQB4xSEwilP5MB9HD8tCsdvMFGdTdYS17Pv03Tx4Q7RsGl63DyoHPPpqdwG7rm0nbHYu+plQIheGwkLQR2TgkbSVMGabyQ8Mmm+R3KKiv/NfY5kMpmh7O9RKfap90dysdZskxWWu7FT1Rl+tg0YUcYW8BPDGnrBQlyUet8SivduwKbfaRMZUEdhRRAipnB4RO9pe8vs4GKvRQnfAJvvYB60VJLu0uwMMeYCC/jLLnqLveCexvwMFWjPE6LiRhKeoaJ8RfgXUD0TAP4Ti3YB7D9oix3jTiGrqeV29MLdTqE5oyf+Rn+6S2D2ceZ3K7YjBLZ0PzzXlC/KKKcoaVBoCK/2EOT1KctrZS7QEBwKybHW9Te8v16Vz30gqtcRqRpBJy7xl6MEW7gC3Z0bTq2IzEmtpWq8rtuuVjMgyjrDIrFkHzMdFnpjaaEAuJY3+2z2g7H3UD3iRs/QBMXNBNXWKR2OXW4O0VQ5msIuDJ7iv1tanNKzGAJKGt+pPsj3VUTQ4DW+GqWts5548qzjofut8ENBDmUEI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(122000001)(83380400001)(86362001)(38100700002)(38070700005)(2906002)(41300700001)(5660300002)(8936002)(6506007)(53546011)(478600001)(26005)(186003)(2616005)(6512007)(316002)(66476007)(66446008)(64756008)(8676002)(4326008)(66556008)(66946007)(91956017)(76116006)(71200400001)(6486002)(54906003)(6916009)(66899015)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fZ1RbJGqWviS1n5Ffr99VSi7rVo0IMpavGgDeeg5ectwTIj8wKftPbeWxxvq?=
 =?us-ascii?Q?g1FMqejiUgaEbkveucbgZYdL3RPTnse7aoRAw4yZ8cDtfkj8UhdQHUHkSnJL?=
 =?us-ascii?Q?pSBRWSutssr5LYXe+fF6ukXeJLeRC5Zjc2hQM0JD4wuTiU4hW8AEIRc/1Cc0?=
 =?us-ascii?Q?j76JY3DXz755YzNPaiYOCoAPVgVfrBgf0+yS0P2/gT08avvExMOtvBrXZCBE?=
 =?us-ascii?Q?glTuouGu0Ck34pp6Au+9nf3XuBfIZYaID53M57MTz1ofoLXYNgvuwQRSQ9Y4?=
 =?us-ascii?Q?kEZ1ZuZkhbI600VMGJELZ8N9bRhSkYXsci8oLUWA9nF0L/vTtabFaCALONyb?=
 =?us-ascii?Q?l7b8950/zVuv5amg+GfrP2Kp6HaN9Q9e+/4GS90g7Ys+LbarDnkBy9JgPbIl?=
 =?us-ascii?Q?ex9olAPA9bnRzOUsU5x+QP/hVlNHmTYtT9YCXEcvyOMF5VatnSzqoCcNr340?=
 =?us-ascii?Q?SFESs8gemcuqjySEUxs+1gfMCduti1P7iA+Sq1NZGaXTkQh++DSYEZ6xYAV2?=
 =?us-ascii?Q?mVqztglhOM/o4mArJhVf9KPMZl5ims0YmEt8S0h1bR6Sux5prRpqaubHWub7?=
 =?us-ascii?Q?0OQNLiN2WbFT5JiJZss22Veed1zZ9D7lkozN+104QDEil6UqnMWbwpACl2cm?=
 =?us-ascii?Q?p3nr6eJPC3XmwjD79jGnKgxWvM8WUWWUSmEdP6391JwiaQoteYuCU1wQx9/M?=
 =?us-ascii?Q?ACEqHRdQIRumHF+UfQi/LCk6Don/u3/mmeMpEVY57lDw2oSeaLAXKNH9lnpT?=
 =?us-ascii?Q?OVhsmoQ4Lej2KW6T7fIMEvgfxF+uN/IKOKND+/jXrJqZmkr+OnKCPM3Yo0HI?=
 =?us-ascii?Q?aoa7yA394LiCvG609onAqKSfUrNTv0gcyGbwKKk5pRY8gobTKVsNG+hA+5Eh?=
 =?us-ascii?Q?smq4XJhZd8XMgUa7nY4IGRztLI/VGjyJngQkN57nWcntBGrnwiaClvE7OGQc?=
 =?us-ascii?Q?59YXuFelM2ANbe6ltzKd7tmFlHry+y+Ov/Yn6fXPoC0+4GtTL4q3j8FTLX2m?=
 =?us-ascii?Q?Icbsh2J5ACogjxaCcLoA4QgZIz0+1Ty2aiSnkY1hBJp1u1WHSukkoiR4cL8e?=
 =?us-ascii?Q?v6NGquDroDJmHUYZ2a/JvUZU4NbB1KzrqFMa9DusopFsVA/DhiBccooM2Wh4?=
 =?us-ascii?Q?zC1cSmIvsJRowAabxC1XnQJVLqzUEgSCaCJXpN+Y8dZRVSsbGgxX/YsUK5a/?=
 =?us-ascii?Q?kZARcWfo5YQqq3x3rMtQ2qPp60qE45sMY9jpwYuLpTQCtePSMzHA5/EHlkvr?=
 =?us-ascii?Q?77feIySPv8/44+upf3PsvbK09DlG8YeqPRJ+HAh4Xn8ftbf/df6QXgpN7x7O?=
 =?us-ascii?Q?YgrAYQ/XTOtLORH2cPnuvBxZ+p4vbUOpp2fEpehdd2EFvNO3C1Pshik8FmqB?=
 =?us-ascii?Q?lV/8JNUFsl9GoCHctv8UkcjdhGLN/+2CTIG+uESbBArL8xhbIymD6kQBne77?=
 =?us-ascii?Q?+WJlnh/JmV25lq2pCG4pRHoIs394p4Zc2rM+mbyHfe3NxZQpgP07VUHsqsJ+?=
 =?us-ascii?Q?bAcLJJmWZLKkHrFSo6bJEajMaZkUch0Le0wpcD7dYXSTHFCzdd9ZSsbXqjKd?=
 =?us-ascii?Q?uzBLqC2/wdRDYYIs1oy4kgOm/3tWOXWsoQOHkpxq/2V6EenKJ73GOEfvVkhk?=
 =?us-ascii?Q?iw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <59A686273170D74AAE4DD4AEE9E2B46B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yxNZc3bLXxue9AkZN0QNsURm2dSkalXf1n7+fb+22NF5+iCQmjDWgYVMtQFexItewL8zTCOCUXpg+63GgvBVRFHAka2+isRM87D8PwC6+Fx0p3DxjGosotwCQvvKZfDALt7FI0G4kCAQGtp2kuwI8OvFNPyPH34xVvsxI5lZeV45unWaT5Z3Qqlyl8wbI8x3+1yzns+Qc+V4bl8/aeUozOal25XAohnH+tflw4+qkAHXDqw/rHqchYLQjWkfUtsaAjNwzFG7zHjyAbH+722zt3Gl6LWEl27PMtkfG8dwRTHXm7Y99h94/1p7dVUeExOREtT7ncRbZfofW3+jL26q5gs3Se84cgIJa1ijonIVJLpUswBUwwAbRTaNHjJAfJq6xw0kyMEU7TpL8aCW+JPQn6FvOInDcnQGfIlx0qh9X5XrtJrvekMDSbh8ZdxpOSUfD6ZLeN4KPAnwpBKIOw9oegq3wrLjQvW+WOgzXWaf1aOi1BAq4PHtysU1VY/Z0vWgDcTszem0wu1zRqo4JFBGFFB9v+f1oKpZOnyezqc9XmWKmjasY0HFsePQ/rg2oz7+5Qo99LdSC0m+9DuKeEUvPgJQaAw8kxJ/p3sKir9w/G8DbEiEAPpFSY+iqfR4K84iAW4+jNzfN3lp9TxMnvDEp486d6vAcQdxUHECKi+C30n8kFZxEE1dFU52EA+rmWeD91dv5Q26VDJaofZDobILRLQXbV0ESIO6VcVf/TmF2Knw57KrBMS1A0uKccdfEI624ZPO0zGB2GSJHbinNapKr/QWxqwFdWWMjEVNUF0KZETtjrkZazqNLVcAh4x7qDXb
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756b03a6-62aa-453e-6cba-08daf33ce861
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 19:00:14.8476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +74tRRJGuntBDUDZYzs8v+UoXOFoLn2bkwPH4xXMKWlK+gI2Ue1Pg34mctKo2cS0dWrRWgb9mlIqwiBGDIvamA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5577
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_08,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100124
X-Proofpoint-GUID: CXfin285xx9tPoKFedpTODpCZ_9HkIPv
X-Proofpoint-ORIG-GUID: CXfin285xx9tPoKFedpTODpCZ_9HkIPv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 10, 2023, at 1:47 PM, Jorge Mora <jmora1300@gmail.com> wrote:
>=20
> If multiple bits are set, select just one using a predetermined
> order of precedence. If there are no bits which correspond to
> any of the advice values (POSIX_FADV_*), the server simply
> replies with NFS4ERR_UNION_NOTSUPP.
>=20
> If a client sends a bitmap mask with multiple words, ignore all
> but the first word in the bitmap. The response is always the
> same first word of the bitmap mask given in the request.

Hi Jorge-

I'd rather not add this operation just because it happens to be
missing. Is there a reason you need it? Does it provide some
kind of performance benefit, for instance? The patch description
really does need to provide this kind of rationale, and hopefully
some performance measurements.

Do the POSIX_FADV_* settings map to behavior that a client can
expect in other server implementations? That is, do you expect
the proposed implementation below to interoperate properly?


> Signed-off-by: Jorge Mora <mora@netapp.com>
> ---
> fs/nfsd/nfs4proc.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
> fs/nfsd/nfs4xdr.c  | 27 +++++++++++++++++++--
> fs/nfsd/xdr4.h     | 11 +++++++++
> 3 files changed, 95 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 8beb2bc4c328..65179a3946f5 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -35,6 +35,7 @@
> #include <linux/fs_struct.h>
> #include <linux/file.h>
> #include <linux/falloc.h>
> +#include <linux/fadvise.h>
> #include <linux/slab.h>
> #include <linux/kthread.h>
> #include <linux/namei.h>
> @@ -1995,6 +1996,53 @@ nfsd4_deallocate(struct svc_rqst *rqstp, struct nf=
sd4_compound_state *cstate,
> 			       FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
> }
>=20
> +static __be32
> +nfsd4_io_advise(struct svc_rqst *rqstp, struct nfsd4_compound_state *cst=
ate,
> +		union nfsd4_op_u *u)
> +{
> +	struct nfsd4_io_advise *io_advise =3D &u->io_advise;
> +	struct nfsd_file *nf;
> +	__be32 status;
> +	int advice;
> +	int ret;
> +
> +	status =3D nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_f=
h,
> +					    &io_advise->stateid,
> +					    RD_STATE, &nf, NULL);
> +	if (status) {
> +		dprintk("NFSD: %s: couldn't process stateid!\n", __func__);
> +		return status;
> +	}
> +
> +	/*
> +	 * If multiple bits are set, select just one using the following
> +	 * order of precedence
> +	 */
> +	if (io_advise->hints & NFS_IO_ADVISE4_NORMAL)
> +		advice =3D POSIX_FADV_NORMAL;
> +	else if (io_advise->hints & NFS_IO_ADVISE4_RANDOM)
> +		advice =3D POSIX_FADV_RANDOM;
> +	else if (io_advise->hints & NFS_IO_ADVISE4_SEQUENTIAL)
> +		advice =3D POSIX_FADV_SEQUENTIAL;
> +	else if (io_advise->hints & NFS_IO_ADVISE4_WILLNEED)
> +		advice =3D POSIX_FADV_WILLNEED;
> +	else if (io_advise->hints & NFS_IO_ADVISE4_DONTNEED)
> +		advice =3D POSIX_FADV_DONTNEED;
> +	else if (io_advise->hints & NFS_IO_ADVISE4_NOREUSE)
> +		advice =3D POSIX_FADV_NOREUSE;
> +	else {
> +		status =3D nfserr_union_notsupp;
> +		goto out;
> +	}
> +
> +	ret =3D vfs_fadvise(nf->nf_file, io_advise->offset, io_advise->count, a=
dvice);
> +	if (ret < 0)
> +		status =3D nfserrno(ret);
> +out:
> +	nfsd_file_put(nf);
> +	return status;
> +}
> +
> static __be32
> nfsd4_seek(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> 	   union nfsd4_op_u *u)
> @@ -3096,6 +3144,12 @@ static u32 nfsd4_layoutreturn_rsize(const struct s=
vc_rqst *rqstp,
> #endif /* CONFIG_NFSD_PNFS */
>=20
>=20
> +static u32 nfsd4_io_advise_rsize(const struct svc_rqst *rqstp,
> +				 const struct nfsd4_op *op)
> +{
> +	return (op_encode_hdr_size + 2) * sizeof(__be32);
> +}
> +
> static u32 nfsd4_seek_rsize(const struct svc_rqst *rqstp,
> 			    const struct nfsd4_op *op)
> {
> @@ -3479,6 +3533,11 @@ static const struct nfsd4_operation nfsd4_ops[] =
=3D {
> 		.op_name =3D "OP_DEALLOCATE",
> 		.op_rsize_bop =3D nfsd4_only_status_rsize,
> 	},
> +	[OP_IO_ADVISE] =3D {
> +		.op_func =3D nfsd4_io_advise,
> +		.op_name =3D "OP_IO_ADVISE",
> +		.op_rsize_bop =3D nfsd4_io_advise_rsize,
> +	},
> 	[OP_CLONE] =3D {
> 		.op_func =3D nfsd4_clone,
> 		.op_flags =3D OP_MODIFIES_SOMETHING,
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index bcfeb1a922c0..8814c24047ff 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -1882,6 +1882,22 @@ nfsd4_decode_fallocate(struct nfsd4_compoundargs *=
argp,
> 	return nfs_ok;
> }
>=20
> +static __be32
> +nfsd4_decode_io_advise(struct nfsd4_compoundargs *argp,
> +		       struct nfsd4_io_advise *io_advise)
> +{
> +	__be32 status;
> +
> +	status =3D nfsd4_decode_stateid4(argp, &io_advise->stateid);
> +	if (status)
> +		return status;
> +	if (xdr_stream_decode_u64(argp->xdr, &io_advise->offset) < 0)
> +		return nfserr_bad_xdr;
> +	if (xdr_stream_decode_u64(argp->xdr, &io_advise->count) < 0)
> +		return nfserr_bad_xdr;
> +	return nfsd4_decode_bitmap4(argp, &io_advise->hints, 1);
> +}
> +
> static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
> 				      struct nl4_server *ns)
> {
> @@ -2338,7 +2354,7 @@ static const nfsd4_dec nfsd4_dec_ops[] =3D {
> 	[OP_COPY]		=3D (nfsd4_dec)nfsd4_decode_copy,
> 	[OP_COPY_NOTIFY]	=3D (nfsd4_dec)nfsd4_decode_copy_notify,
> 	[OP_DEALLOCATE]		=3D (nfsd4_dec)nfsd4_decode_fallocate,
> -	[OP_IO_ADVISE]		=3D (nfsd4_dec)nfsd4_decode_notsupp,
> +	[OP_IO_ADVISE]		=3D (nfsd4_dec)nfsd4_decode_io_advise,
> 	[OP_LAYOUTERROR]	=3D (nfsd4_dec)nfsd4_decode_notsupp,
> 	[OP_LAYOUTSTATS]	=3D (nfsd4_dec)nfsd4_decode_notsupp,
> 	[OP_OFFLOAD_CANCEL]	=3D (nfsd4_dec)nfsd4_decode_offload_status,
> @@ -4948,6 +4964,13 @@ nfsd4_encode_copy_notify(struct nfsd4_compoundres =
*resp, __be32 nfserr,
> 	return nfserr;
> }
>=20
> +static __be32
> +nfsd4_encode_io_advise(struct nfsd4_compoundres *resp, __be32 nfserr,
> +		       struct nfsd4_io_advise *io_advise)
> +{
> +	return nfsd4_encode_bitmap(resp->xdr, io_advise->hints, 0, 0);
> +}
> +
> static __be32
> nfsd4_encode_seek(struct nfsd4_compoundres *resp, __be32 nfserr,
> 		  struct nfsd4_seek *seek)
> @@ -5282,7 +5305,7 @@ static const nfsd4_enc nfsd4_enc_ops[] =3D {
> 	[OP_COPY]		=3D (nfsd4_enc)nfsd4_encode_copy,
> 	[OP_COPY_NOTIFY]	=3D (nfsd4_enc)nfsd4_encode_copy_notify,
> 	[OP_DEALLOCATE]		=3D (nfsd4_enc)nfsd4_encode_noop,
> -	[OP_IO_ADVISE]		=3D (nfsd4_enc)nfsd4_encode_noop,
> +	[OP_IO_ADVISE]		=3D (nfsd4_enc)nfsd4_encode_io_advise,
> 	[OP_LAYOUTERROR]	=3D (nfsd4_enc)nfsd4_encode_noop,
> 	[OP_LAYOUTSTATS]	=3D (nfsd4_enc)nfsd4_encode_noop,
> 	[OP_OFFLOAD_CANCEL]	=3D (nfsd4_enc)nfsd4_encode_noop,
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 0eb00105d845..9b8ba4d6e3ab 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -518,6 +518,16 @@ struct nfsd4_fallocate {
> 	u64		falloc_length;
> };
>=20
> +struct nfsd4_io_advise {
> +	/* request */
> +	stateid_t	stateid;
> +	loff_t		offset;
> +	u64		count;
> +
> +	/* both */
> +	u32		hints;
> +};
> +
> struct nfsd4_clone {
> 	/* request */
> 	stateid_t	cl_src_stateid;
> @@ -688,6 +698,7 @@ struct nfsd4_op {
> 		/* NFSv4.2 */
> 		struct nfsd4_fallocate		allocate;
> 		struct nfsd4_fallocate		deallocate;
> +		struct nfsd4_io_advise		io_advise;
> 		struct nfsd4_clone		clone;
> 		struct nfsd4_copy		copy;
> 		struct nfsd4_offload_status	offload_status;
> --=20
> 2.31.1
>=20

--
Chuck Lever



