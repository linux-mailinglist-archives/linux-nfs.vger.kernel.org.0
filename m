Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF743D65F9
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 19:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhGZRGm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 13:06:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49302 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229489AbhGZRGl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Jul 2021 13:06:41 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QHfecD014588;
        Mon, 26 Jul 2021 17:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DoxOtP17RhDARS3NOcjrPuvV0HKmdvvRummeFRM1NKc=;
 b=hq4syABMsXXeqFukRdWmDdGKyvua9JrY8BJ47gfl+K/o/n2GP7qVsVmz+q4Zd/zTiXct
 6qIGaCP/G+kx3PjQsCQTs5tBd/MLQc14WNZ7P/NCd7Gx3Kd+czGjgmaZxpHLUvIc846t
 B+eNYF3XndkTsrRayJzyrVYaWMMneOan9eGFBzvu782yIeAQz4z3vnKauQ1h1HPyZFFj
 EVGco3G2rodDC88pTH/CgmQTOljnv9D6QSzTYZsH2/58EKI34/yTQnaIwIrflOprfBSi
 jbjorVPpgGE8jVrT45S3G4WeylogDUpZj1Zpr5UUrb/ywNXL/mIauEwPEuRaKZ3dup0q 1Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=DoxOtP17RhDARS3NOcjrPuvV0HKmdvvRummeFRM1NKc=;
 b=rtpFOhbhNFd2zHTZJG+FoFVcyP/Z032VGbbvde+QUpoIDb67JNiu6YMCJ2r6GdaUK9rt
 d69JEq/Yl+hciwbF3ft+Oshm8HMBdzmQbVdFIvBv5bCMT0Y8peMG7RcxMAA1bBKpC99z
 xmCCzvwT3Q4YuTW8t+CNKghDGi1P+DB3lKJGiNAOJ+YRpRmJbLvvjVWqwW1vnXeAR8ko
 b9Q+D3FrRIEnPZXI14qT62NA9eao/ddx4C/Yvv7MfcbZ1tQ5sSbVTwhRN29H6WPf54Qc
 ySGN7q87fZglCAH/eatGiHvo0Ss+l/pAwISF10mNG+nC2F6SRnyX6+iCdyMl/bGVmSAp Fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a18nft9uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:47:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QHfecd175104;
        Mon, 26 Jul 2021 17:47:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 3a08weye70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:47:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEoj5ba5ZwYb0+QFOVq2EywdpyC19W7/QRvcOPG5NiLX13kLTwCS36aSaRNwWOVo6TXM5pzbbCSmvubZEGaAqLC2K9VahdabH0dF6kKyX/V72Y7DiVeQnmF/m3PCJHOkCAYGqqaTcTEJwLtGsS5/6GSv39+bMEsglLEQz1B0A1yyJT2Ij/nXNOU6W5qa1DLPfjRXmkUhow85/4bipCY3JCgMzW4TI2H9DGhaOY/3D6lArFOyrKUb85U0s6YsFY4euUNpsh5InPB6P/Rbi4S2fuHLcAeGyjZfT2hh93akD9LfYMhsD6gWkCSU04w9d1QQqgCwXDnQpnpzoOEcYuW1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoxOtP17RhDARS3NOcjrPuvV0HKmdvvRummeFRM1NKc=;
 b=mp1zSpIi4b5bXx7ihBIFB9bqSh9VLKFzi8tYWQL/nCW57ycw0D4SxGTgmDE5NA015Owl5G8P8Ete4+BMTb5//aacE5M1wShGq2Xcx4BwZ/Z1Y3bAmfCHqj28sf7qX/i5LJt21QvoEMYfcWgyXclsGT9nBeUlvDtrIYHRqg6eBJZvBIAq5b9uRAyTyvdTSy80jopjLh90vZDnZq6nPh5OmUh1109d00T32CFkjhM3KHj3jB22WqhAaePX4ya0OIPKEfIgdwxGff9glyOQU8gjbJP7uvd2fqI62gxZHQPkL/3Kv/R0bB0iUntAbYM/bJuxKNIVTFWb2ebF3bqZHqCyQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoxOtP17RhDARS3NOcjrPuvV0HKmdvvRummeFRM1NKc=;
 b=Z1k27cPRgCEIxvQB3oV+scpNp+v04LvIBVlJHF0yH0bf0oz/4TEVe0gxZEyo/wwT5YtgHOSdJHc1pYknaFDPMyqkEEN/zu4WT0dvT8TmPx5PSrTdQfc+WrCg/UlUuQV25J930BbADq0fa6F54VoIfu87yIUq1JHqAiP5Li8ZqK0=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5647.namprd10.prod.outlook.com (2603:10b6:a03:3d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 26 Jul
 2021 17:47:05 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 17:47:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] Optimize NFSD Send completion processing
Thread-Topic: [PATCH v1 0/3] Optimize NFSD Send completion processing
Thread-Index: AQHXgi0Yw48BQ/9qz0qiTepU3ySxXatVeQAAgAAPIgA=
Date:   Mon, 26 Jul 2021 17:47:05 +0000
Message-ID: <9660A4A1-2DBD-49F9-B916-ED418C6EBD4E@oracle.com>
References: <162731055652.13580.8774661104190191089.stgit@klimt.1015granger.net>
 <c59afd87-b53a-25e7-8a22-efc8428bd75b@talpey.com>
In-Reply-To: <c59afd87-b53a-25e7-8a22-efc8428bd75b@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08e28698-7477-4e6b-ae41-08d9505d61c6
x-ms-traffictypediagnostic: SJ0PR10MB5647:
x-microsoft-antispam-prvs: <SJ0PR10MB56476E59A72BDDFC1F4F8C3D93E89@SJ0PR10MB5647.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gqFgncDkCk65Ba/VOJTdVKC59XspKPv0Yk4V1RFPZC1Rwo67/uhJ76cRQj2nGNyRF4ipUbY1l0vy+A3bYW+UDtrxJYBclVgnaD9sgZL4BxuQKNB9U5WV2p5rKiVYUKWdmDT41KZk7Taw8YYY04V5KzuPLRVjnc16r+BZKq/dofQKT8W4GtBVGvrh01gzjuFPJjjX6B2ois0+bCcV4hzm7+9iTEdcXFTWBkm1A+O9iOGDmnRKLpPVR48Q+jhBlMPa7PYdl1AtJUNtQp6fm3Aj/YRHOcXvxbhB/CkFOSNhAt/BvhgO2Ot9PFHB7vWEnNQqmojbc8sx3MqIO9dDxfuFfPelNBVAhTJ2CKbtQxMqn3v3/zApyOB9VV8NIeCO+leLQ7g0MxK1H0Fupvf9VgKtXr+uMZKNvftm7Qs8etf4POnZwGCQx8JainN6myMlBa05eidnF78pblSVnWlgZaqNO361e4ZAyv4YfPKQkwC4zGVd02iBjINLU3xaUyrj1RbjE9c8WSRMGe0TUPJpMwwFYUNtAD/wyaNF0zX9VoI9KW3mDzHXqzW8tQjuU6rGSXRbtF4/4A7SKC20OrA/4MkNw93OMQlJ2kSr1/qL6WzOYrICrIrEq0Z4bR4LFjsVZnDcRiunoiyzVHhvggJ+yYNQUUfmXhlKxNX0M+9aE8Ihmj0pTU3S6y4J4G6YQTlXsgJ3qtW1Zx3+v/4MmrGjljmNPDUtdgskiR3Zh3KH1FWsj56Ht3w1L2NbXR/J1l6BsxBu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(366004)(376002)(346002)(36756003)(54906003)(4744005)(86362001)(33656002)(478600001)(6916009)(8936002)(66446008)(66476007)(6512007)(53546011)(71200400001)(66946007)(6506007)(2616005)(76116006)(91956017)(122000001)(64756008)(4326008)(6486002)(26005)(38100700002)(66556008)(316002)(186003)(8676002)(5660300002)(2906002)(45980500001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IALR79/7Mjp+KE5+H+eDQKs6S/fdyCGYOj4y2UCGrnR+mr+VzHoeZFqoWtkB?=
 =?us-ascii?Q?QX6aEEbbVnRmgvwayQE5U2kyTjE7FmbX0+PczTkCFXb0GLgnXKS7nAW+Symz?=
 =?us-ascii?Q?DudR8zUQNsKJ/MXbypGFIFQJ1+0dUURIAC66oq73qqwIy83i9wavPpVv4OLQ?=
 =?us-ascii?Q?qsQhhIMJaW9i93dySfRlJhKTZEMQa+x+/mn9fjzygoOf/SEvZIhUWhFkS5WG?=
 =?us-ascii?Q?tuJHAoEFUQLyTqnxc3/IVY3fUmoSGyDMspVfpSzeHbDZBu3I/8zzPDy7F4ij?=
 =?us-ascii?Q?zCvFqrQhPZvAgsteFfo/pqrvLiUlSsO9TyPQph2dy2uDg1365UCxxQ2iutml?=
 =?us-ascii?Q?I2U7bttYDJUmTcl7UZEJ2N5SEWzi8jZRzAQ8X+RLEFNobTo1GxNvqz/4mOkC?=
 =?us-ascii?Q?62lrVHpSsiN0CRQb87W04FAdKFQ7IJBcet9WZI8SB3Z4SnfeSZGhSfq94dwE?=
 =?us-ascii?Q?KBZqPjE908zL2GSO5Tt3sSduqLgMwjqTfL1c2gQaAZBgxB9SFb1AA1176HOc?=
 =?us-ascii?Q?WT8Xe3vOU6eSaQm++35lX0uWieYlSKUfXKkhj9Z2fIkwR70Fr/h1fgV/Gbdj?=
 =?us-ascii?Q?xYgAxxBNJ4b6Ed9/jdzwi9fMQUjy9o2rtjCq5zsSc10oB0pvUDXaCjRQrhrq?=
 =?us-ascii?Q?2BR+uJazHDy1+CoqvozomTFLi8+zqbX6LaVNI18D7CPb8BWFkjdgun3niaHV?=
 =?us-ascii?Q?M39j4jtjaWADmy9MdgLI9PWsXWHVdNrHypGBV15J8EPOW2R67Wuw9c6kujt6?=
 =?us-ascii?Q?63fFMWVdW8bwSwwqp/tstpZk5bgbIK1xOzmEyo5arui0w0Vw5Nc6LMtUyRBU?=
 =?us-ascii?Q?mkWDJK4N5sgk0GJXXgKMjbqT+KTHYBjJSi1rngge+PHULwiO8pYUvISWUJjl?=
 =?us-ascii?Q?tgojA8/IyJCf/pvKGXkQQbg6S8gShhG0eCBrblh3NlXR7KWuYQaNP0f99MmJ?=
 =?us-ascii?Q?tQPuTKo6OggN34xQXf/CZGVg/hK7XhSSoUWG1A31yuA62PkAWm4gARRCrzTA?=
 =?us-ascii?Q?YGXSWBDYPOCgc0QF/4ERdVQ4CF6e8UkNYRh6CruUfr+C+LoRV4J7QyIqUagU?=
 =?us-ascii?Q?68gn6TBq+2ppWCrBexxwgN4dbEjq5ueCUje+gWtREU4hZ2BiqlU9nga/Ui3e?=
 =?us-ascii?Q?FYGZXC9QXjKDfc7oDKoWeGBwagqmhDLu9E6HlkdNpBbpe+m4E/LQybQ9l+vB?=
 =?us-ascii?Q?EsDLe8llUyZbcHSmX8vv8hnN77/9UK1aTnQ6HwiWw4Y76Q3R51q/CDwxh+nx?=
 =?us-ascii?Q?2AuIMSukQTrUleyFtZW9Ow6P2n3lWFT9seq3L4HJwmCVJIGIsVegDugoiJMc?=
 =?us-ascii?Q?zMYlZCISnxFgGqTqE7YDmPWMM7/57Fg8D9IaKFGrvTX2rA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <636A3A7DA5B20B4C8CC2BFE55B8FF839@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e28698-7477-4e6b-ae41-08d9505d61c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 17:47:05.1440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: we3aPYUIpiDYT7uHFIVzI/kpnxXIS4xUcwwTfbNfaQcRlhY7LxPLFx7e7AsCxmfT8by1ikprdmGD+AB45efYbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5647
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=735
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260103
X-Proofpoint-GUID: qehjJtRCYcJIh6_jcy8vtA1ccr5AxAHG
X-Proofpoint-ORIG-GUID: qehjJtRCYcJIh6_jcy8vtA1ccr5AxAHG
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 26, 2021, at 12:52 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 7/26/2021 10:46 AM, Chuck Lever wrote:
>> The following series improves the efficiency of NFSD's Send
>> completion processing by removing costly operations from the svcrdma
>> Send completion handlers. Each of these patches reduces the CPU
>> utilized per RPC by Send completion by an average of 2-3%.
>=20
> Nice gain. Are the improvements additive, i.e. 5-10% CPU reduction
> for all three together?

Yes, the improvements are additive.

--
Chuck Lever



