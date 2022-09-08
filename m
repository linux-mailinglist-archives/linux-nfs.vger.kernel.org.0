Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429E05B23BA
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Sep 2022 18:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiIHQjs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Sep 2022 12:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiIHQjq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Sep 2022 12:39:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967E433E2B
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 09:39:45 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288G4Rh2025889;
        Thu, 8 Sep 2022 16:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3b4vR9ZPqDL/SXGxaZoBBUYneOd8sJB4pQzpiFEgTwc=;
 b=1gVmQT9iy+z+n2CWkK5WAR8LJlyzGsQiQeqUecQOMlpg8q7YRAi9gXkEvkM6haCHuUzF
 SxQZzSdzVWIuSNxI2iQ3QEpmOYtWRklqcxffpKbHO89A81a8iN0setkGp23HNTZQ1du5
 Rgluijk24H/4FZMMiQD2Ai1U+QEEu9PVuIwYPRKhdnP47Fm8LB9b25gVTxumftPSISmM
 Pqy0MoPHmBErZzc2ZJV/hBs/w9IDOMAeHOrM/X/HSDMkCEg6Vb5TVA0XZCRTSDQiiBMj
 pWyx/fNCyKYO+FCLjw4gCHMVbrTmIvOugWj1L1I2V6JlG8YjM4+l9oyuWAmuQZbGfuQE oA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1mh1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 16:39:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 288F1XfR028944;
        Thu, 8 Sep 2022 16:39:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jf7v6wn46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 16:39:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPg9ipHbEVRnepNznkbD+mkn4o2VpMCCcTrffhNPMwiUB7B0y3L+FVBSh695sNMKKcVFNdVorx4gfCVfKJOxYgTMJXQX09Vqzqt9VJN8geYJJDo/tYwCsYivtjsi4jZOcgiRUBPMTe0lG7h1sUSQ3KVGSRcoaFRPajysoTSASi7BTEH/eQM5ywVN19iGurrNds1ezjOexsv9ogakFz/rUazNPuMFTzJv7YQ4teP+I7Aqk9eEaWIDB5A26e8iBjiTKC9s0+0c5ZyhoKWs2Y+nqTAGl2mceuz+4s3vumHFsP/EsNGilTNU6tIme+qPZj0lgR6Wz9IFpQgMl+YbmjEXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3b4vR9ZPqDL/SXGxaZoBBUYneOd8sJB4pQzpiFEgTwc=;
 b=hqGoJKT49qPLu93lXq7NzJ5iJKOC3W4fRcHjTGSnHaAOqXueLVOV+u9vPwBX7MTwe6VmhD78PiRpQotam4z8xs6mRyMDBatxXkGzxuSXUJ3TaPuzWGGqCQS5n1XkhC9DjAf6PuU7uiIj4t7kGU+5l+rE1segQhMb0DLn6qTWOB227Lc9mSCmRegSXozCVT3sUmoVTnniPJpXWZM0wVZ/owSLGOwvHV+wskPsIwbBmpSrulni3mWOHyAeUrrHS52+o0m9OZeRjzrhyXtL795J2zrW1Tst4+MHAGhGK5U147HFvXNJgLhU2Vb/6pvla7N8WTUJq2eAeVBxEXNIHqPOTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3b4vR9ZPqDL/SXGxaZoBBUYneOd8sJB4pQzpiFEgTwc=;
 b=wwCbsBzFMpU5JfkvCSRzNSxu4JJFhZixZStlbXEkWZ6NaurZRM9W2sIIUyKtz/kDwrXMXAKZlvgbIU13aC1QRHp2kMA/j593MWrH2iJxiAfAfBJ2EvRBlqsBKv31XXyaabXIsAyE5vU8RF83yzpg0y6R+OvlJg60iWhAypyg7v4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4175.namprd10.prod.outlook.com (2603:10b6:208:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 16:39:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 16:39:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] NFSD: Simplify READ_PLUS
Thread-Topic: [PATCH v2 1/1] NFSD: Simplify READ_PLUS
Thread-Index: AQHYwvN0H50fO0bVeUq5hyL/2HYwe63UazcAgAACI4CAAU/pgA==
Date:   Thu, 8 Sep 2022 16:39:37 +0000
Message-ID: <00A8D990-E8BD-45F1-BC29-0AC6AA1D7B27@oracle.com>
References: <20220907195259.926736-1-anna@kernel.org>
 <20220907195259.926736-2-anna@kernel.org>
 <06EA863F-8C11-4342-8D88-954E99A07598@oracle.com>
 <CAFX2JfnNa80uhdeg=8YMiVWQGimkC7VrPHORjB=8SyOVw35Z_g@mail.gmail.com>
In-Reply-To: <CAFX2JfnNa80uhdeg=8YMiVWQGimkC7VrPHORjB=8SyOVw35Z_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4175:EE_
x-ms-office365-filtering-correlation-id: 905652e8-7131-400a-3753-08da91b8b819
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v8TUQqrTYWKeJKFytCNagEpOqt6TAKLUAu1iatwQhepEvkQga+ckNoNOzZ+Xsd9aCUAp/JJuhll/yuT1uYtGt4EC0vdWx32g2vohTPVxbjemEFLPiqIpDLjfD9vXwnVVZp2hzHIjT1sdjLeHAwFa/0otYbfPxnFE92mlWMzJilKWoJ2taAtjhnKWx3DcH2kcOAoV0u7s3Vsxcxn8LToNPKAqBx2yEYyAp3SqtK97BAp9E+684CuD1XmHL0Ay0kM8ADWU5xaErhujObQXXA2GCPSpxBRgF/eNS5WfpMCyzmfUga6e+TF/te6ezwuLsHadKtSJVwj+f6MSa9JCIP97vG4kiGvPqlSAIaQ/tx0OEXeOPGW0WbS5qQWg2bArnAzSwVtCgusshJ2HbjOGRjxB8OTDI7uQ+PBzXxc1r3CXgnBBPub+X2mJheeZCFHj4KADPLPHWYtd08ogvdG6JXq+hZ2N2evkzZ4onP7+uhFWdZsUYLpiMLlvyBgTea4tWxOu6TZD38OJ2wpY9biu4yO3jJZ4sV5gTCjlgRDlhfuwV4Tl1gNioyj1VmT2GRYphR2q5PqEhzQwjaBi/uV+hD4shd1rnZ1wuFrGiaPMSvL1FoFYoslCsm2jqfm9XkfHbs0voHBXmh3ey0BzgVf5/JhRlmdjXhCBZyJnEBGpD6wgYg8qBn205gZ+liZMkSaUKnm/KaEYAiGa6NGfx7/dFtyUGihajrRhYtG4nNMJOLNvzmQ/4k25oA7DRrR0Do7hf3v1RxBEPNh/n76x1cwIQe/c3TrqSYcxktO98OTPLPMnRcQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(346002)(136003)(39860400002)(186003)(5660300002)(66446008)(2906002)(4326008)(66476007)(66556008)(66946007)(91956017)(64756008)(8936002)(8676002)(2616005)(76116006)(36756003)(53546011)(33656002)(6506007)(26005)(6512007)(86362001)(83380400001)(478600001)(41300700001)(6486002)(38070700005)(316002)(71200400001)(6916009)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ewRDdaKg5pLzxjCRBBEwxX8WXmSIQYDkg4BQKSewPLkSqGJiSqLRRpdom0ue?=
 =?us-ascii?Q?RiPPRRNAbTvmqJbp12RuH/2BpIr0GaS7GYUNeuNMVF/Z600hK27VgzJScpTZ?=
 =?us-ascii?Q?CiaeNEyMkeo9xHLU8VYrC4cvcwz0yeZu1xiDxDBW1myURYtquJrfjrEq9AsF?=
 =?us-ascii?Q?0m/B9ywdk06iOLNGkl2kaVHQ9Ia4gUvO9/15uueIScY77gg3C/HL0NMS+swX?=
 =?us-ascii?Q?ptardn5zKaZN2J3aDhFKPmBl+bH5RqrFxhWI9CQrLnAwN7SmkREbmvyCvRS4?=
 =?us-ascii?Q?r37CfBxRcfgFPhUm09OBU7XcbZs/O4VE/a36cQYaL1zj6QBx9UWTubF/jg8T?=
 =?us-ascii?Q?45nHAyyjR6FfPfZs7yfZ3QF1r/ZIpws5xH3rEhCdtqc8NPZoOiUeWxlOzVGF?=
 =?us-ascii?Q?5zlI0idAyaxlwg+J65zis6ppzOvZfH6sBqMTS2wG7GqYJe63Zpbu9Rdg/x0i?=
 =?us-ascii?Q?qKECwyG2GjzmdA3JgClx+JwgPUpt5FF9TEVxvFnY5Fc5llnsoySDhnRIVVaz?=
 =?us-ascii?Q?gUEPi1ZL9ok0SGO2F3BMxkVuZLx4bGIcmK7UBrWhoItLehfSL24X/R74LK2f?=
 =?us-ascii?Q?NXrkuD5pPDcWXSCQlyo2wHTAk3Y/A6ei81OFZ4jyqtKZ97TJkjcR77A6x6r2?=
 =?us-ascii?Q?DRfoDusoJnJrBa4uGhqPqCb6sx8PMnReKz5XP8Y2tVqegqNfZAz7Dym9ZvvS?=
 =?us-ascii?Q?HfbQFoQDisFFBltWLOFN/8ASIBOm6XDdDx8nExNcMkA0hDl/7NovHwkYZ6+M?=
 =?us-ascii?Q?KjH0M3F3MHm7wpOScNW4EmP9dnGzJqmk89tXx6JoVQTYvyPSuBybJ8ggyCUo?=
 =?us-ascii?Q?/Fp9MDLK60snYF6jjzTUBIg6lcDMhQTnKERhvg5lf/3eAmlzbe929GSVwOVr?=
 =?us-ascii?Q?f5mOTG+qxMnwDgKGFvABIskSzKXYTh+HDy+x0PVfYeFHWSb0yT2S2K/elh6d?=
 =?us-ascii?Q?PBiIwQcfIZgtf/zq5lcEPI4yd/7Cb5kkJYUjbYu0gtVE+47kfNI2CsDSZgcs?=
 =?us-ascii?Q?z54iDR5gpEfP9pBZTwaS62W6gWeMo6EWMVDW9LvIgbNUPTxrxFOUS8/M3hdy?=
 =?us-ascii?Q?XHmz8XcqBoNqoQhDV3m/czfCTSX/66DZqDzKwWgVjEdM0pyB9s8kxYrFCqVR?=
 =?us-ascii?Q?gfACzQlLztWTpsM3i+jxRoZh9Ycrxts8Ql6H5Ylge8XYE2DgCXqT67hdFiCO?=
 =?us-ascii?Q?WGWrIHsl5uCYs0D1Cwwgs3a3z5A56F2iF9Gk5Zn3K65UkPEwotUvQAO5ctbJ?=
 =?us-ascii?Q?0MDwOjTuIgEBhu1clXsERDllOs45GwlOtqTqrDtHa0k1IKAbhNSP0azpei/z?=
 =?us-ascii?Q?kmawJB4dVHhwLi7zCsvuh+cEchDwfiYTbVL6Pf7cLc4yRVt9/8Wxu7MUuL5j?=
 =?us-ascii?Q?dZF6RXvPJUquXXHan3ScoQ2947HwSQjBYyBrtDGRiwVm/3MqXX6O7nikq6Ah?=
 =?us-ascii?Q?wGQ6eUS7OGdmucTl6EHnWAqe+0oKvAytqBKrefT4ymaxJz6DbN+kq73atmfD?=
 =?us-ascii?Q?tnvljOaMRUpaGf+GllH+5r8si+Aivny/V4vUr6VYxUqrpmMC8sT38gpEtXc5?=
 =?us-ascii?Q?WSk9q0wbba+18bzzmvyTSKSb2YuUaMxd8QKE0pQ/i6DystPCKBeplikOH4Aq?=
 =?us-ascii?Q?Pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18B3D7591FAF9443A255D25FEB0F48EA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905652e8-7131-400a-3753-08da91b8b819
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 16:39:37.4860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7SblJzYu+PjhfQ3WLASUWjJZAWe9mRf8YWxqnodn3GjvRoN6IoWzAvt6q6DYEW7RakSIyqSWD0Z0pkPqGZb96g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_10,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080059
X-Proofpoint-GUID: GI8gG1bOrNdOVKwaNGT1WGufB1JU4qU4
X-Proofpoint-ORIG-GUID: GI8gG1bOrNdOVKwaNGT1WGufB1JU4qU4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 7, 2022, at 4:37 PM, Anna Schumaker <anna@kernel.org> wrote:
>=20
> On Wed, Sep 7, 2022 at 4:29 PM Chuck Lever III <chuck.lever@oracle.com> w=
rote:
>>=20
>> Be sure to Cc: Jeff on these. Thanks!
>>=20
>>=20
>>> On Sep 7, 2022, at 3:52 PM, Anna Schumaker <anna@kernel.org> wrote:
>>>=20
>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>=20
>>> Chuck had suggested reverting READ_PLUS so it returns a single DATA
>>> segment covering the requested read range. This prepares the server for
>>> a future "sparse read" function so support can easily be added without
>>> needing to rip out the old READ_PLUS code at the same time.
>>>=20
>>> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>> ---
>>> fs/nfsd/nfs4xdr.c | 139 +++++++++++-----------------------------------
>>> 1 file changed, 32 insertions(+), 107 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>> index 1e9690a061ec..bcc8c385faf2 100644
>>> --- a/fs/nfsd/nfs4xdr.c
>>> +++ b/fs/nfsd/nfs4xdr.c
>>> @@ -4731,79 +4731,37 @@ nfsd4_encode_offload_status(struct nfsd4_compou=
ndres *resp, __be32 nfserr,
>>>=20
>>> static __be32
>>> nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
>>> -                         struct nfsd4_read *read,
>>> -                         unsigned long *maxcount, u32 *eof,
>>> -                         loff_t *pos)
>>> +                         struct nfsd4_read *read)
>>> {
>>> -     struct xdr_stream *xdr =3D resp->xdr;
>>> +     bool splice_ok =3D test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags)=
;
>>>      struct file *file =3D read->rd_nf->nf_file;
>>> -     int starting_len =3D xdr->buf->len;
>>> -     loff_t hole_pos;
>>> -     __be32 nfserr;
>>> -     __be32 *p, tmp;
>>> -     __be64 tmp64;
>>> -
>>> -     hole_pos =3D pos ? *pos : vfs_llseek(file, read->rd_offset, SEEK_=
HOLE);
>>> -     if (hole_pos > read->rd_offset)
>>> -             *maxcount =3D min_t(unsigned long, *maxcount, hole_pos - =
read->rd_offset);
>>> -     *maxcount =3D min_t(unsigned long, *maxcount, (xdr->buf->buflen -=
 xdr->buf->len));
>>> +     struct xdr_stream *xdr =3D resp->xdr;
>>> +     unsigned long maxcount;
>>> +     __be32 nfserr, *p;
>>>=20
>>>      /* Content type, offset, byte count */
>>>      p =3D xdr_reserve_space(xdr, 4 + 8 + 4);
>>>      if (!p)
>>> -             return nfserr_resource;
>>> +             return nfserr_io;
>>=20
>> Wouldn't nfserr_rep_too_big be a more appropriate status for running
>> off the end of the send buffer? I'm not 100% sure, but I would expect
>> that exhausting send buffer space would imply the reply has grown too
>> large.
>=20
> I can switch it to that, no problem.

OK, never mind. I see that nfsd4_encode_compound() handles the status
code conversion for every encoder, and deals with reply caching too:

5349         if (op->status =3D=3D nfserr_resource && nfsd4_has_session(&re=
sp->cstate)) {
5350                 struct nfsd4_slot *slot =3D resp->cstate.slot;
5351=20
5352                 if (slot->sl_flags & NFSD4_SLOT_CACHETHIS)
5353                         op->status =3D nfserr_rep_too_big_to_cache;
5354                 else
5355                         op->status =3D nfserr_rep_too_big;
5356         }

So returning nfserr_resource from the READ_PLUS encoder when
xdr_reserve_space() fails is copacetic and preferred.

Then, once READ_PLUS can return multiple segments again, it should
deal with send buffer space exhaustion by truncating the reply at
the last properly encoded segment, as Trond suggested.


>>> +     if (resp->xdr->buf->page_len && splice_ok) {
>>> +             WARN_ON_ONCE(splice_ok);
>>> +             return nfserr_io;
>>> +     }
>>=20
>> I wish I understood why this test was needed. It seems to have been
>> copied and pasted from historic code into nfsd4_encode_read(), and
>> there have been recent mechanical changes to it, but there's no
>> comment explaining it there...
>=20
> Yeah, I saw this was in the read code and assumed it was an important
> check so I added it here too.
>>=20
>> In any event, this seems to be checking for a server software bug,
>> so maybe this should return nfserr_serverfault. Oddly that status
>> code isn't defined yet.
>=20
> Do you want me to add that code and return it in this patch?

I would still like to return serverfault if the splice check
fails.


>> Do you have some performance results for v2?
>=20
> Not yet, I have it running now so hopefully I'll have something ready
> by tomorrow morning.
>=20
> Anna
>>=20
>>=20
>>> -     read->rd_vlen =3D xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec,=
 *maxcount);
>>> -     if (read->rd_vlen < 0)
>>> -             return nfserr_resource;
>>> +     maxcount =3D min_t(unsigned long, read->rd_length,
>>> +                      (xdr->buf->buflen - xdr->buf->len));
>>>=20
>>> -     nfserr =3D nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_o=
ffset,
>>> -                         resp->rqstp->rq_vec, read->rd_vlen, maxcount,=
 eof);
>>> +     if (file->f_op->splice_read && splice_ok)
>>> +             nfserr =3D nfsd4_encode_splice_read(resp, read, file, max=
count);
>>> +     else
>>> +             nfserr =3D nfsd4_encode_readv(resp, read, file, maxcount)=
;
>>>      if (nfserr)
>>>              return nfserr;
>>> -     xdr_truncate_encode(xdr, starting_len + 16 + xdr_align_size(*maxc=
ount));
>>>=20
>>> -     tmp =3D htonl(NFS4_CONTENT_DATA);
>>> -     write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
>>> -     tmp64 =3D cpu_to_be64(read->rd_offset);
>>> -     write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
>>> -     tmp =3D htonl(*maxcount);
>>> -     write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
>>> -
>>> -     tmp =3D xdr_zero;
>>> -     write_bytes_to_xdr_buf(xdr->buf, starting_len + 16 + *maxcount, &=
tmp,
>>> -                            xdr_pad_size(*maxcount));
>>> -     return nfs_ok;
>>> -}
>>> -
>>> -static __be32
>>> -nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
>>> -                         struct nfsd4_read *read,
>>> -                         unsigned long *maxcount, u32 *eof)
>>> -{
>>> -     struct file *file =3D read->rd_nf->nf_file;
>>> -     loff_t data_pos =3D vfs_llseek(file, read->rd_offset, SEEK_DATA);
>>> -     loff_t f_size =3D i_size_read(file_inode(file));
>>> -     unsigned long count;
>>> -     __be32 *p;
>>> -
>>> -     if (data_pos =3D=3D -ENXIO)
>>> -             data_pos =3D f_size;
>>> -     else if (data_pos <=3D read->rd_offset || (data_pos < f_size && d=
ata_pos % PAGE_SIZE))
>>> -             return nfsd4_encode_read_plus_data(resp, read, maxcount, =
eof, &f_size);
>>> -     count =3D data_pos - read->rd_offset;
>>> -
>>> -     /* Content type, offset, byte count */
>>> -     p =3D xdr_reserve_space(resp->xdr, 4 + 8 + 8);
>>> -     if (!p)
>>> -             return nfserr_resource;
>>> -
>>> -     *p++ =3D htonl(NFS4_CONTENT_HOLE);
>>> +     *p++ =3D cpu_to_be32(NFS4_CONTENT_DATA);
>>>      p =3D xdr_encode_hyper(p, read->rd_offset);
>>> -     p =3D xdr_encode_hyper(p, count);
>>> +     *p =3D cpu_to_be32(read->rd_length);
>>>=20
>>> -     *eof =3D (read->rd_offset + count) >=3D f_size;
>>> -     *maxcount =3D min_t(unsigned long, count, *maxcount);
>>>      return nfs_ok;
>>> }
>>>=20
>>> @@ -4811,69 +4769,36 @@ static __be32
>>> nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
>>>                     struct nfsd4_read *read)
>>> {
>>> -     unsigned long maxcount, count;
>>> +     struct file *file =3D read->rd_nf->nf_file;
>>>      struct xdr_stream *xdr =3D resp->xdr;
>>> -     struct file *file;
>>>      int starting_len =3D xdr->buf->len;
>>> -     int last_segment =3D xdr->buf->len;
>>> -     int segments =3D 0;
>>> -     __be32 *p, tmp;
>>> -     bool is_data;
>>> -     loff_t pos;
>>> -     u32 eof;
>>> +     u32 segments =3D 0;
>>> +     __be32 *p;
>>>=20
>>>      if (nfserr)
>>>              return nfserr;
>>> -     file =3D read->rd_nf->nf_file;
>>>=20
>>>      /* eof flag, segment count */
>>>      p =3D xdr_reserve_space(xdr, 4 + 4);
>>>      if (!p)
>>> -             return nfserr_resource;
>>> +             return nfserr_io;
>>>      xdr_commit_encode(xdr);
>>>=20
>>> -     maxcount =3D min_t(unsigned long, read->rd_length,
>>> -                      (xdr->buf->buflen - xdr->buf->len));
>>> -     count    =3D maxcount;
>>> -
>>> -     eof =3D read->rd_offset >=3D i_size_read(file_inode(file));
>>> -     if (eof)
>>> +     read->rd_eof =3D read->rd_offset >=3D i_size_read(file_inode(file=
));
>>> +     if (read->rd_eof)
>>>              goto out;
>>>=20
>>> -     pos =3D vfs_llseek(file, read->rd_offset, SEEK_HOLE);
>>> -     is_data =3D pos > read->rd_offset;
>>> -
>>> -     while (count > 0 && !eof) {
>>> -             maxcount =3D count;
>>> -             if (is_data)
>>> -                     nfserr =3D nfsd4_encode_read_plus_data(resp, read=
, &maxcount, &eof,
>>> -                                             segments =3D=3D 0 ? &pos =
: NULL);
>>> -             else
>>> -                     nfserr =3D nfsd4_encode_read_plus_hole(resp, read=
, &maxcount, &eof);
>>> -             if (nfserr)
>>> -                     goto out;
>>> -             count -=3D maxcount;
>>> -             read->rd_offset +=3D maxcount;
>>> -             is_data =3D !is_data;
>>> -             last_segment =3D xdr->buf->len;
>>> -             segments++;
>>> -     }
>>> -
>>> -out:
>>> -     if (nfserr && segments =3D=3D 0)
>>> +     nfserr =3D nfsd4_encode_read_plus_data(resp, read);
>>> +     if (nfserr) {
>>>              xdr_truncate_encode(xdr, starting_len);
>>> -     else {
>>> -             if (nfserr) {
>>> -                     xdr_truncate_encode(xdr, last_segment);
>>> -                     nfserr =3D nfs_ok;
>>> -                     eof =3D 0;
>>> -             }
>>> -             tmp =3D htonl(eof);
>>> -             write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, =
4);
>>> -             tmp =3D htonl(segments);
>>> -             write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, =
4);
>>> +             return nfserr;
>>>      }
>>>=20
>>> +     segments++;
>>> +
>>> +out:
>>> +     p =3D xdr_encode_bool(p, read->rd_eof);
>>> +     *p =3D cpu_to_be32(segments);
>>>      return nfserr;
>>> }
>>>=20
>>> --
>>> 2.37.2
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



