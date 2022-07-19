Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916BA57A0C9
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Jul 2022 16:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbiGSOKP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Jul 2022 10:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbiGSOJy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Jul 2022 10:09:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B814550B1
        for <linux-nfs@vger.kernel.org>; Tue, 19 Jul 2022 06:28:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JDB6xQ002405;
        Tue, 19 Jul 2022 13:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=TGj/bz+dqxSd6ik47wIAA+YDYx2CTV5j7cGbFCvOsR8=;
 b=1yuMXfHZQ8oFMZYNKA3/u7O5TmYpAcC8Hly6dTm1dVVb3K4w5KoiCRaBmHnZvGGa/Zs3
 SDcw16glg7UTMr+3yud03q+hulGwACu+fcpuVjuBX4Ht/Td1AQE4mf9+xikoCLls3+NS
 q7M8JmXFHSltzSrDlDLZzgKTU76w2T2uNhQBa4VhbUgyNjXdZRvIfrQvrCMS0lci9RL1
 npkhtRpvqKlFTgsJTfzpzLlf4/+l2UzI8DWday60glU5oTmkTFBNry8ExEh1MIoZnuSu
 5Vqv/EG9UukxkX5Y9biwNreOKI8oItP453jTqRjpP6XX6eSoolMQI3VwY2p8Ol3Lb9xE Gg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a6843-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 13:27:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JC2P8g016400;
        Tue, 19 Jul 2022 13:27:52 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1emhn30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 13:27:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxRvklioKTMwiin800LGt8F4mXBs9j09EqXc7jaXEWzTQ1V9+WJb4SxzDP+AnKvAiDb5ljgK5hcD16jQLCAVxDdel9Z6197bH4Y0kEINsCeKhVjmAwAX51ylX+DsJFeGxWeXWpfDvURbUnPpag6CQ50SC29ADceqMeKmeM3J4y2ztsrGKTiPvqqQSowEySuWjz5KLI7W/xugq3tKYNhUirYpN/AnBOzpsK2N02rUONSmt386/URIZ7xHrizuLIFeAJGYuxlxGHzZ5vRh0q0hPHhDeUkrlM07YmEDU8hv4zpBDH+YKNdBaslkyZ3WjOqlkZdpzp1fTx82zpohpYMS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGj/bz+dqxSd6ik47wIAA+YDYx2CTV5j7cGbFCvOsR8=;
 b=NKMKgjja77G7GtA4YJpzTS3EQxgmMaJ2TckBOBHwTcyJgSyvyCDRoZtNebLXB0Ge+LbEHGBTdmmC4AY0YUN0AFOj52l/oTYpgByYboc11sz6sDZ7Te/PU287OibU8pqTc+QqxHr9d5ynVedrCMVl3Zn1w8E2LPOaIFL2/OMOok1wLkRWrrh9GJJZuBbJQbwfjFFWMBtw2Tnj4RA/t5QSEV5sihQLpu4k20/XEZC0q3PyashoUb/7AyoqCB5lkiKCHI+FC/0T3aVn4LO3wIKtLizy07IWrImTiAIBXFOZgtaUXbqewE+0ewxSKVifLw7JrkaqFBha9jhjzKfGBkyteQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGj/bz+dqxSd6ik47wIAA+YDYx2CTV5j7cGbFCvOsR8=;
 b=xRRapqBsyy3O/SqW1xaIicbybPzVYvLRYe32Vy1zp4sklsWHQSRGxZu6V22zBt/Sxq5egrcqGmhCb/2kuQIUc8NqgPrgl2rU/8UAP0rnV3GYWZ4c5xPFvKNmRhy6HNx6QxNlIPDPzSGmphnLL8LC1h24B0DKqPre5+HoIV9iSoI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5502.namprd10.prod.outlook.com (2603:10b6:408:149::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Tue, 19 Jul
 2022 13:27:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 13:27:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: Remove CONFIG_SUNRPC_GSS_MODULE
Thread-Topic: [PATCH] NFSD: Remove CONFIG_SUNRPC_GSS_MODULE
Thread-Index: AQHYmq7FTbvVJcL0IE6jwSQssKBM4q2FEDuAgAChFgA=
Date:   Tue, 19 Jul 2022 13:27:51 +0000
Message-ID: <4936C3D6-AE4B-4F7F-89D1-17CBF38A5CD5@oracle.com>
References: <165815281251.8395.9611588593452344848.stgit@klimt.1015granger.net>
 <YtYqNZCazm64S/Di@infradead.org>
In-Reply-To: <YtYqNZCazm64S/Di@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 671f5ea5-1459-464a-3d62-08da698a7ad0
x-ms-traffictypediagnostic: BN0PR10MB5502:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: haTq5gdIof9FVTf6CqtwHxLyd7GNEK6ozs/244tpDPDcBjqPRKF97wK8jznWKwZJlSwRtLdnLz/xfiicRaFISWtmF6w8kuZht4iCWtSNgvceWWMP27o5a96PaC6+eZXy4tETLnkeSBWQOZOv+gKc3d0dhvsPpz3kycsh2Gcn1GdQ8USQRNdkq1CENGNmkZW4wv58EUG0k/NnqeQV7JSWL91myRRj0FE2tu6FLfHKwu0Bsj28qD9S9raaWP9ypYtV4bqG56m7SU82U2iIc3BNjAdCGL7kRC4TzunTWzkU6+2L3mVmnWJBzN4Fl5GSdBs14NljLh/dQxWI6NtppNE71HdmNIRf59DWtmeYUR2plGl+Lnq0uKdwP5PU3brnMv6pzmvIv3M6ZlPebpb+fyymK5djGOLbfJzeRtn3rH+Hg4Bw2KLcrAh2qlIc8kpIxEq2o/+qbMIjyv3oir1t5dw6U7P8eWSGthdeBCJE4VbeXN8ctRvg5qjEd6/mSLKL+qIaj2qB69nMpZ9fmjCNzfuVtrxErPkc6XbNz/+j0YBUWB3F/mltpmU/pxyIMsRwMi/RV3CV2sk2IwLgTkl90C2tB4MzfuVySN0hjs7ZJz+sXAnJFVZvdz9ORQ1h01R9l6AJLiZj17bR61bBwh2CjGIIpAS8elqMBchBZDEvH1Hmwn1xqPQpbhCCv/3dEkSqw5SzIQ5mWCeDrA4kOouwy9cHGtw3OxpoSrcrO9+0M4BYs0BaakB92LOeb1wmYL9fhyQXDobmzfG24pxClV+HJVFF+SpWtGouLyHy4tpgI/RUQ+nM3M3el0kNVEt9PjQFUI3VdwVnRCrOh1k8v2y+1teWiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(376002)(39860400002)(366004)(346002)(38100700002)(4326008)(8676002)(4744005)(122000001)(33656002)(76116006)(5660300002)(2616005)(186003)(64756008)(8936002)(66946007)(36756003)(66476007)(66556008)(66446008)(2906002)(91956017)(6916009)(478600001)(316002)(26005)(6506007)(53546011)(86362001)(6512007)(41300700001)(38070700005)(6486002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KTJxlQKqDgB5h01gjwJbEwHGVLSNzAju4YPwRQwoqqnkl0lBjRGzuVTSkwpJ?=
 =?us-ascii?Q?2IhXthGfpnGXVqQV8KZa3D0jt7owvcp86IA+dXPoE9EVzthwGo/GrWChYtks?=
 =?us-ascii?Q?11uYreBhx/vTzKYsImhXMXLoaRIx/jhH2d4cySEhRCPleP0P7X8F8PK09yKh?=
 =?us-ascii?Q?/uK0Ni6SLa9o4XqMPE01xlJntVbegaLoUOCEkniOJuEQ9Q0ldxvhAByvRyxt?=
 =?us-ascii?Q?R38hueS0CbZv3zgooVQG3TlzjsGAQ/LazFFfkJNEhFcqyIEK5dpMFYLBjdhJ?=
 =?us-ascii?Q?ViU+L04NjQLdLTlM8Z+69HHuVodyDFXwTa5DFuUfoeKRlhSvPF28GX1HBeXM?=
 =?us-ascii?Q?BODlX9Tx5MClqKbKM4nTLu+/FfEHITMqfmQa+hbS5a4gSO8QJDpj7fxBH04Z?=
 =?us-ascii?Q?UZCNbzAY4D0srOMz+h6ST3Mdw7OVXx3OLN/gTl+kyHy6EtHRQY+y5Bucynha?=
 =?us-ascii?Q?GpXv29qSK2gDdwP9xBEVrLyvtU4e8ShAXn34OA3376Y8MQHkLhb6p+ABBkg9?=
 =?us-ascii?Q?ObdExFNv9cB/RHKTPBqfIUYkIvqoZqHaR4i1BlRFgI1PJ0CXquNyuUWvXpdo?=
 =?us-ascii?Q?175T929oHn8Z3QB/zVnaQlF7yb5zCtm+P31Hu8dLVqLTFRrNLyVWF0jxaqw7?=
 =?us-ascii?Q?K5uDI5ukdaSY5i2NTclGhL0f9HU5doq9vGE983Ms71oEs/ZS/yJdY+WHssgi?=
 =?us-ascii?Q?30/KxzCG+esuD97V92LYcuiowpzcxCGEVsMf1cK5Fu7nN7njzK7yxyo1JwTq?=
 =?us-ascii?Q?PVgxTBgn1EaVHEEngoq6KN0eMqwSyODW/VON9sPXTtFle7MXbB95ZDKqzOif?=
 =?us-ascii?Q?2LtbGR++ufF+bNUGjl75RA54uoAtbbf05dEZvIkyktiXE5E2tT1daRFb9LVV?=
 =?us-ascii?Q?YG6gwczeqnmHxjXn7or/mE+xm2i1VnrWZdiUluhujyGJl9x3ox2lEeT40aI/?=
 =?us-ascii?Q?lZquywDsuTcZZA5YpK5M4f0W5jrOEwnoZH0UybmbEz8cT7AHCo2PG/IKxBMJ?=
 =?us-ascii?Q?j+mf1+niRMFPt2M1htcnn35btyQV8z92ZRXe9PfRSt3YUR7iSp0I4LKg+3EJ?=
 =?us-ascii?Q?1WA48Zno3XisgzzuSSccKpNFtbKxSXZYen/NFKUKr40d0z/IROhFzy3PkC0X?=
 =?us-ascii?Q?2vnn0ET3S+0LhTdmAal492Ari0/k1gBOX5iRKrawBrSXtKSLZoRd+prQiFGU?=
 =?us-ascii?Q?t31aqAOGTckC2h7edIfKvoITfVhDvm52tELFW6au1vbMvI+C/t6O4jj9guUj?=
 =?us-ascii?Q?yuhoRq9QIRNkssujGHoPaXl2nYFM9mjVohKcGqiiI7RCACals8ZqrZfYd+tV?=
 =?us-ascii?Q?czthvO3a2r4qSInpwvL6QzQWuCSJ8VwVgRN1D5/x8chsARI5egAqLcNytZ7c?=
 =?us-ascii?Q?hdeDdRf4EZQmB/KpORX5N94ukttjhGA2aIlQFH6uUVzzFtf43fbNIRohDHbO?=
 =?us-ascii?Q?AROArhQPtqsl4NFlM7aG7WkO2EN0+QUYWtvB8O/zXn2gwDnBnf/8fg4IJBGC?=
 =?us-ascii?Q?BFbQSEtvy06F65YPorjUn3F7/9k3tGhL/Q6jDN/piOeIHKVAEcvHk4/hIT3N?=
 =?us-ascii?Q?uO3+FbwGhEI3s3F6gOcYaXk/pG8kWNf8Ph39zTOH0zCOIC8L+MvzpcMpAGg+?=
 =?us-ascii?Q?Kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <33F278575733A8449939F46A5E3252D8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671f5ea5-1459-464a-3d62-08da698a7ad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 13:27:51.3061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmiS3nPLlteitbD0/LdAvXurDFDVbQrF6xq9clIklonv4uDeNPvIBAYoWeJu04bIBcReW4UWn65XkTcGAQPXuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5502
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_02,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190056
X-Proofpoint-ORIG-GUID: H_pCZbT7BwSTBrlL5n-COBpR3ID_kOXX
X-Proofpoint-GUID: H_pCZbT7BwSTBrlL5n-COBpR3ID_kOXX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 18, 2022, at 11:51 PM, Christoph Hellwig <hch@infradead.org> wrote=
:
>=20
> On Mon, Jul 18, 2022 at 10:00:12AM -0400, Chuck Lever wrote:
>> Clean up: I cannot find CONFIG_SUNRPC_GSS_MODULE anywhere.
>=20
> CONFIG_SUNRPC_GSS_MODULE is set if SUNRPC_GSS is built as a module.
> CONFIG_*_MODULE is Kconfig-generated magic.

I can drop this patch, but I still have questions (and I know you are
just the messenger, you might not know the answers).

Where is this convention documented?

When would CONFIG_SUNRPC_GSS_MODULE be defined but CONFIG_SUNRPC_GSS isn't?


--
Chuck Lever



