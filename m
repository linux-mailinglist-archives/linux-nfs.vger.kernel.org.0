Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB9B5B0E98
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Sep 2022 22:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiIGUwM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Sep 2022 16:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiIGUvw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Sep 2022 16:51:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECDBC2E85
        for <linux-nfs@vger.kernel.org>; Wed,  7 Sep 2022 13:51:38 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287KnDL3018538;
        Wed, 7 Sep 2022 20:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LBkXu85iNkTQDaazZm5iRHW4facMCR1vgsydqpUcgQw=;
 b=de0tn8pqKLbIXoZxGxU7gdImTvV4DDpslNPWCsM3eS/xbH7+AGBZYgc7uqci89wm5DvA
 UzqOxF5+2bvmKI/Z0vLTIKRRNc5tL/txeUDys1iZK1YWwOXDBoJ4j8YDejptru08Bvuj
 f+B8UiRz8gyIriVtiYNFSnvV7hmZfk1IyDvVpNrSBc0O4pXY68tX69cm8LNCQZcT/Vkm
 rfVRTwSeBxEcBJswl+xAxkUjG2LaAzo6I9U5Ln21C8z3JfomMClxOc4OHV2GARJalkXV
 NZ9XoKqiKBu3VpwylAkqGmsTfCKPBcuPIYiLzT5yumLqnCW62xNrjeGWrW31H+03+6tA zg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2j3ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 20:51:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 287Isq4Q021122;
        Wed, 7 Sep 2022 20:51:16 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwcauv3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 20:51:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6OsXmwsieCxFkNUzt7AAaIPnY3CZaRKI09ZUT20o9rWuk2JzAGgXmpbY8Lhf6lvgCjKZGCgDa/KRVOGt4zxp1vkzBi66DgkTWwPANvkoFuQLMKCJ5kJXCo3luEw/OH5tZh3Vn+DkMaZAeZLEBSkROK7sZxBJdqR6PJm/Xn1ojHtSr9EOeq+AhhziItTWFbkDiBKIWK5Xu9SZxSMQ8qaUy4BmRkGecbPtkBvYUcWQDAhk9n5zmFpW5lwxb3wfzbHbVlQjYoiOjJvix9JtJjEyCYAREM3vGJy8yG78Cal/NFrk/iZnemvi5a1toe/5EE8AAvnbYTHrTcMmffw+lnhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBkXu85iNkTQDaazZm5iRHW4facMCR1vgsydqpUcgQw=;
 b=h1eiwm5lVP6Y5L0L7PsmOozLe4pxNZWElyCRoVjeFMcty9Uw4SZXkQwkWknuG4eJUVB7RE3M8Io5IiAlDw2ZDoMoFiyVT04zWj5O1jPZ2AdE30E/gq+QGnabmS/WnMtoqlye5OWw2g1yDe6jeG5GO6F6LyfT6h/nSWmt9bcUlS4bRW6FfUmnK2WYHybzhz8ghl9LQaLMcIg+3f3EqwVEoDv2KRq85lWmTon9gITxF32yCNHEIVf457UVJMDJhEJbH6l9KZirWVb6YPG/Iw31Ogfw4N81/V6t6SbCo2cYTia5oPkXgvl0MKjfD4ZzmZBqnO3Q/+TKXc+ev6THETcqoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBkXu85iNkTQDaazZm5iRHW4facMCR1vgsydqpUcgQw=;
 b=lu1paiTQ5kGrUz/UBz2zaFE7TtBok3gMvdLb8OxZibcT6WHPJERbe8+NryhqFa2w1shg8TtvgfD4S6FTy7+KBRVs6o0b2tS3FG3ue6AegbWdjw69pnZ/4vfjf4s4Xs3mIysvvmk4OsHYKl5dA1yOCSQFWC3MLXW88PddljzGOnI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 20:51:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 20:51:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] NFSD: Simplify READ_PLUS
Thread-Topic: [PATCH v2 1/1] NFSD: Simplify READ_PLUS
Thread-Index: AQHYwvN0H50fO0bVeUq5hyL/2HYwe63UazcAgAACI4CAAAPhAA==
Date:   Wed, 7 Sep 2022 20:51:15 +0000
Message-ID: <9DE01D1A-9328-4F10-9E9B-9A788E1F249E@oracle.com>
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
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5031:EE_
x-ms-office365-filtering-correlation-id: f20a9173-89ad-4b34-7163-08da9112b4b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Fw4g10L1g8aDP0CRhjlLx7XeNb9WxxyUR91pHmxYwuDLPbnL1DguFUZIDMmAwpIogOYPhEertRU/IiyAi5BC1bHm3SOGTdCTtQxduQEvNN2V2ddeIsZ7fAiN2+ynb6XwLFV7en5LbbOJGc+TxQGcoo1TU8tkfm09D9LxyHYJoxebNEvjM2/cruFYJtjwaoEJUSdMstplU7AHLUDaAOYL0Bx9Dx+6HnosCWuf1bJgw8YRQrmJFJgHybXrvNgyuWrLV1OKwO20FBcuOPpotX77d30DZys9fcr+jbO/CGW9WSDgk61lYBRIsK4JS6yMdWqG8UV8dAvl3VrgLuf2zdFAWLoyAJG8uH8cNu0tRq+cy7lrJglf0XFp7Bid1Y4MaUYZ/3efLlENegadDswyRTEAFjmpJxLpOdODXIU5NO/AvPfomZBnZinUM+TWTjs2Lkze0j0UFXsdEhV9gKoitJOpaAp3XkO+5O5su4d8PHxEZdrpjpIQmxdi+IA9CSSN1H9Tz8pS78dABHXO23b+T7HvmfokFOep5AC9jZZLY54wHW1IPHKnFaBZyk3xcHCPJjyE9h8Ihe9+kWTq1y1DKbW4dzMNXegE/wpYannSA1LgZgSCNeJoKamSZcD9aopzOwJAknGvIQIyEOYQUC5PBa7L9Ezu58g/SqTMEmF7T7/3FDJJTAyrf8THvCyvN54Ifue0SHclPtlofHVXql6SdVKmbMEbEdYkwDIhNSTwJPvF5heWiQRZ04CEPm6P9Dh73sBjtJaUF7QsBpII+DgO+dPPGm1e48NiyWDLveQY5n6edA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(136003)(346002)(366004)(66446008)(66476007)(64756008)(4326008)(8676002)(66556008)(66946007)(86362001)(76116006)(91956017)(38070700005)(6916009)(316002)(6506007)(53546011)(83380400001)(41300700001)(2616005)(6512007)(26005)(186003)(71200400001)(122000001)(38100700002)(6486002)(478600001)(36756003)(8936002)(5660300002)(33656002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hhNLltJVecpN8QEqOdrSz1AoS4LlsEG29Emd+axP5jZclPaT7/CFiFXOqyMr?=
 =?us-ascii?Q?K6uDPGL3n50HF2WLxfOLVIxZlcWgLwLQ1fG/nhRMnEXhgU3ib3xj3f9P9A6J?=
 =?us-ascii?Q?CHnIawKF61o3EVTNDpedsmgrSZTrIb7bSgQwbWVEc2wisLdvAC7H8xijXycK?=
 =?us-ascii?Q?yFa1Cq3Rp/SxBXzr71bQA2vfakqsOr0r2fE8yLh8ajW9Va21Z3olb9jNncaM?=
 =?us-ascii?Q?XXq8eLFlqKiE7aTfMGmcFXnh1Bsy/UQjfSffzoUYb0ogcwJGZIPzzVdV0h9F?=
 =?us-ascii?Q?ygnhGRYqLOdo9DuUQ71aBkpj3fd9f4hrG4jW0Nm2+WgBpuQnnO173FMqQO9i?=
 =?us-ascii?Q?VPv4M+nDsm4/rFU7NfWz+JTeeJdjhdhJbtlsEA85CkTa9F+7WKR1+K8mo/UV?=
 =?us-ascii?Q?IYNq/x3aEPDBN2CL0koC+NMllXzxrJPLFpyebXgjzvgP2hUr2U8M3ctL58Ql?=
 =?us-ascii?Q?CHozSK6sJ91WwvPhOXm/2C3MNf0SNbxWQWpfgraSZU9An5vM3o7t69WZYnTO?=
 =?us-ascii?Q?tkHuvs//Mtb2xKcLrFhvbI0wyxL4U8JWsAqmbvyvYIzF3GayfEYEOmrBh6C9?=
 =?us-ascii?Q?WWi9EgVmz9NCLybd6WXMcsvifGliLULMkPLtpEd99abhy0iQCsumEhvv7SBC?=
 =?us-ascii?Q?WmnXs1vs6JuDEjmmBu2oin96Vxhp82q35uBktm1Y8YBEs9fyqQve/IXQTs2u?=
 =?us-ascii?Q?SemvOJFBtLQ9i6Dkj+n303ep0vuyYUTMrjolN+tGxtgUK/hSUogcXVklA2DI?=
 =?us-ascii?Q?zJKwtaF6O1j954OP2vJf9C2oM3Vm6F/M5rzMJDlBEnMNKwkbLbLn+FAR+5E4?=
 =?us-ascii?Q?JMSenaWzbxSX7BezPq6x5LX8Roig8SF078m4PusSSsS1SRH8JgsAp80VFQ0E?=
 =?us-ascii?Q?IMJl2FeuRvQUVQ2eGjJ6QeqnNHFTaXgPwg5VBg+yQTC/F0N0Nv7ZvAmCTfR9?=
 =?us-ascii?Q?51Rw4x5/IDziTHW/D7tgvXtTK3lftlzsCGIF9T9UD7OBdLvPIUEMe6294Ihy?=
 =?us-ascii?Q?mlCD1UbvK6sGe0glNMh83Bx73yejUQwZjL9Xw+hs4ERNZvuW9eszuPo10vgv?=
 =?us-ascii?Q?r+DeE0cNjdIn4ijOF3iYvs9nHeh1KMXvOuNCOSk3VGMFkIAfqbJ3+SE4q5x5?=
 =?us-ascii?Q?e2usDJDQpuNXAAcN0G+xDviBeywK7F21BfPXLXp0GjWRWTcl468TzHoLbO5o?=
 =?us-ascii?Q?sqKg0axdNC/Tf74utNRHfGMcGpB5S/61gjWhIe/Ogq6lZP9E2Xnl5tEizaS9?=
 =?us-ascii?Q?ufJCfRsCQcQr1z6npfnHS8tmqawvPJxtcDj+pBYlH8CtzlMElL1GzfTj5phk?=
 =?us-ascii?Q?g9WwYQj1ftN6MiJMuAFgs5Q5eDzFpxW338owY0A3pQduauDc/leBEWe23HfM?=
 =?us-ascii?Q?2PokL7m5ApTeBQIsF0RvxtkgsaWhO3nBuNGNTaPeMzyzuz6cMJ6kyr/3c/Vg?=
 =?us-ascii?Q?cBqydjesIo6F2N+s1RhSvcG65MXqaiFoBfryK3belSy7eK+erXXOGe6Yp69O?=
 =?us-ascii?Q?ZV4M3IwiwysW7QCr0ZqvOQ763iYkkYRPMLT9AMGRsErrAYvDTi4XYmCh8k+T?=
 =?us-ascii?Q?Ap4zRW6wEDV4MbtPLmDbCgsKDXSHfL+H0HLKQW2l1rEmd84GOFqWVpmRRX46?=
 =?us-ascii?Q?Ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8FB864BED0ABF4498EC3C1C84EBDDA1B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20a9173-89ad-4b34-7163-08da9112b4b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 20:51:15.3106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRY3hXXeRbsogKaV8nYLm/Vbuw8gI8uX+dJZ5jByfQKqVg/lCWaaOmWoYe2r+jDOOXpaLUcz6Hr+Bx9SWoy4fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070078
X-Proofpoint-GUID: ruuLShcRJ_BJOrh66knim4gJgfFHJA3J
X-Proofpoint-ORIG-GUID: ruuLShcRJ_BJOrh66knim4gJgfFHJA3J
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

I would like to hear opinions from protocol experts before we go
with that choice.


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

Sure. Make that a predecessor patch and fix up the code in
nfsd4_encode_read() before using it for READ_PLUS in this patch.

Suggested patch description:

RESOURCE is the wrong status code here because

a) This encoder is shared between NFSv4.0 and NFSv4.1+, and
   NFSv4.1+ doesn't support RESOURCE, and
b) That status code might cause the client to retry, in which
   case it will get the same failure because this check seems
   to be looking for a server-side coding mistake.


>> Do you have some performance results for v2?
>=20
> Not yet, I have it running now so hopefully I'll have something ready
> by tomorrow morning.

Great, thanks!


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



