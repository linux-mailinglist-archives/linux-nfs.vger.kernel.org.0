Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3D55B2282
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Sep 2022 17:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiIHPhX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Sep 2022 11:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiIHPgx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Sep 2022 11:36:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC287FB8CA
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 08:36:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288FVYCU003276;
        Thu, 8 Sep 2022 15:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Lgj6ZcmwtapkmXWqtqD0niBXheo8Sfkk/j2nf8lnzE0=;
 b=zsFQsWgeWP2t/ztcA+BL2HbKOn3fJ4R56hh5yHXmKDBPgHwONf/IQ/nYLhM5QudtpXfK
 KV5U2cfFLPRmcSiTXSuKTLECWWXk85Wr1bYb11nnyGFqOW+C6bngJmdXHxY6e/Gn1vJX
 GiojV/qC1GU1Dw+AM82X6jOjYbRZkT9sDQ+SRnBNUdFn9j5eaCaB85jmU9ZPVuAyqlp7
 UlMTveazYCDxVXdauLpmyMzpjJBzLGQzZXOCuq1w726Ybv/TjXCEK/2N10r6to4AzhWR
 Dqx0Y1zgBnl5Al6RKcaR8WBj1W2Rxf8dqW8AXnlwyXEkEk4ta7BFJB2SKGLPpHxUlA91 Mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxhsv848-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 15:36:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 288FM7rE038765;
        Thu, 8 Sep 2022 15:36:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc5gk6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 15:36:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHXAAlGtsWcTUt22m8GLEg9N9fn0Wm2gcF5FUq5Qo3AgXJV59waqkwZgmC6rr/DLm2JKVw5j1fcqFIzax+bz7gmNCohkkZdwEKoSUsYVx76xvA0AEUNSJZxuaUPGtAEYC+0phM49tcE0XnfJVc5DG8U++B6hfz1h9Vwxi2q0GCA8MoFSppq1SxxYBIZOZ1gETgqsKIProNnATFCP7bGcif1z+0f1eDW1PWTdoUaJhb0XQkKJ8u+zf4a2mVEp5+gshpX3CPlCvCg2e3y9gEzbg3n+WvJE10mz6PEKv1JVw7YkteX3DmBsF8LO23VRxNolAHxATnyWn0jpAUPM9rik9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lgj6ZcmwtapkmXWqtqD0niBXheo8Sfkk/j2nf8lnzE0=;
 b=eO04F5Aji2SC/SC2G4ryPL0AfowZI6Tt6+Pej3vZIycVSuELq0SUoD62KbXzjjy9Al00t2d0d+fwQ5wYsi+0UwLD1CIr1MIK0b50LMGfQeBJA4K9Tt6bHk0fRovlc5zTrUhUJIXvoaNWcopOiXPdZ+7Dt9csys6S0aFp4zMii2mvRejwzoyXpPEWohqOLz7QT3AkBKFAHnE16Zd3FxVuLc+lyWRLGCs651bQcRaav2d07V0xZ2iMu7wgcsWrPbNRa7oTipW/96cEnOZl9kM3HjDayrm/P3x/5jPd61ZzQ3UOvgXtq6RBt1X5XNgxCEIgbDMsEwwn96675by9EbZVMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lgj6ZcmwtapkmXWqtqD0niBXheo8Sfkk/j2nf8lnzE0=;
 b=fDlzJFNje2Ibig6uk1Ii//l3k5Kjd3XP8utfu1EjC8jIYK/VrGbl7Yzaa8HuQnK9VkrBW5wILejuw9yIWT2BJL9Bfob0vkEWZyP6fWrNuG8o7+dACU/Z5IRI1NVC9jxZCEShlT20gNuiIS6HAK86W26il2uBbFCwOkn+jN2TuNk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5230.namprd10.prod.outlook.com (2603:10b6:5:38e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 15:36:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 15:36:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "anna@kernel.org" <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] NFSD: Simplify READ_PLUS
Thread-Topic: [PATCH v2 1/1] NFSD: Simplify READ_PLUS
Thread-Index: AQHYwvN0H50fO0bVeUq5hyL/2HYwe63UazcAgAACI4CAAAPhAIAAHH4AgAEd7oA=
Date:   Thu, 8 Sep 2022 15:36:36 +0000
Message-ID: <6BFC6BB6-732D-4832-8B83-2F8FB33E84F3@oracle.com>
References: <20220907195259.926736-1-anna@kernel.org>
 <20220907195259.926736-2-anna@kernel.org>
 <06EA863F-8C11-4342-8D88-954E99A07598@oracle.com>
 <CAFX2JfnNa80uhdeg=8YMiVWQGimkC7VrPHORjB=8SyOVw35Z_g@mail.gmail.com>
 <9DE01D1A-9328-4F10-9E9B-9A788E1F249E@oracle.com>
 <8141d61fbff18bf2632ae7fd9506618fd42c7f1d.camel@hammerspace.com>
In-Reply-To: <8141d61fbff18bf2632ae7fd9506618fd42c7f1d.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5230:EE_
x-ms-office365-filtering-correlation-id: 4d43f702-8982-4858-2a6f-08da91afea37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ef9FMMesZsEW3DQqI7kg+s/8yfJihpDaWv+6Mhkfs1mgpIkm5utJtGzeXNX5xBl/Curfh+MOXyWS5+Tw6xDBgz0K/6n24L8X+osReyKQc3iFzCMhFPtZm7UjUxtD4SD8oPfvHLZg32NLyX2oSmZbZ9D8icTecRHo6TIt74SC1B216/vIcwIm25iLQqw41cXyCCzSmeJAWBqJ5qqUWUiU9YKVYhaPtdbnkuF3urx8HL+UADcF/KrJM9f8WAE3BBZPi2NdyusFy+81EY3kipM09/0JdEfFkyvA8zYl5Lss+r38NljROdtjgQDZNB3B2u7FmL0hWN2QbS6kBw7npI3x4T9N4IxgW3DbuW12BAByjXJgAbwRGcrJQ5uC7dtEAJEx4HiU5zYe2ECgSFdK7tJIErDgP+J+54yPUUOqjhrfQ/5zjQglydgH24PL31xJWVgfK3TwHEKEfsYMsD00hmEjQAEo9myGR88U2U6iojnyj8uZVWp7UWsmbabcllfQOmILgPYkJ8S+3FNQL80zPmOG/8P24Z4zL6p1xBLEXLhdUdxCrQVSKUToftgPG6+4Ae8aVoYhd4EtMr8ZcCMIUYLh6fPTf8sH8NR+CqzjAN+/ZcXrXIdq8t6GZvYXfY+i2Oay0BazzTVhkOv6Q7nK41duOFbPBw+F+t2gM0ZlufN/VCmAMGgnkHpLes/ROwJ5f8vjxPGoJITMrcQaxuMFyRo7Ah67tQF6kMy81pEFFVSSfG91CbYcXGs1TLpEwgbjF/4V6vAFu0CQLBnhsb+7v1ZoTMP3JuF6joe5O7eCmV1EB64=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(136003)(346002)(366004)(66446008)(66476007)(86362001)(64756008)(6486002)(38070700005)(33656002)(66946007)(91956017)(66556008)(4326008)(6506007)(76116006)(83380400001)(478600001)(8676002)(6512007)(2616005)(2906002)(26005)(53546011)(5660300002)(186003)(8936002)(30864003)(41300700001)(36756003)(316002)(71200400001)(38100700002)(6916009)(54906003)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KG3bBtnXgVSChRsh+CVGoMtTnNcM7D8ajOZ/sDuBCkIPP25pq2lq090AFAAt?=
 =?us-ascii?Q?KHaEjQ4iLbOVKKhyaaK3x8Xe57kEQ5Z+h7+tar08f4corEPG5fWgc05w9Lek?=
 =?us-ascii?Q?kmyGjvbnLp0Q1Gr+AhAf2PHzmj4PVCdmNYaAZ5hc1rbvAB6C1kHtWRl0GCst?=
 =?us-ascii?Q?npwuG21mwK095TpbrL+AZ4y5T4MksOrVc4gujdiOCGJ8oAZBtkpWiAnyJYea?=
 =?us-ascii?Q?tX6LnpQwtKsySv3OwLVQxrVcbt+LNRSKajTgo6Nx56Cwi20PN36hpeRGtm38?=
 =?us-ascii?Q?+UW74PXlD8O9caTs9/kLt6Icg1MgZGJvaApYyJb15gpZC7fJTarUMR6rfLtY?=
 =?us-ascii?Q?a9PYT9j37rU5HOS3OGe7HqT5ugjbY5RnTBPRdO4mcCerW5OwzKCwy6gtvXci?=
 =?us-ascii?Q?GdamdX26mVKkiJDvGxFvob+IhwX91159ld8OHl055U93C5Bvy8hVkw2r/fz1?=
 =?us-ascii?Q?z47U3fn8ThTjflYC19vfT+7aptH3ksgOGk64+zevfaMJfm4ItQhcPWwO7IbW?=
 =?us-ascii?Q?4p4+tsNBeusEZYhvxp0QsMmt4tAGNi8aWzQoJwn8w1i7800SX6ReueBeOTf3?=
 =?us-ascii?Q?yCytdLx28NSiZ6i5Po8ilfWg7hFMXz91usr1QuRSfCw+obXXToUrBem3S3OD?=
 =?us-ascii?Q?6Obk899tYIK0UHBXNVypx4SMcgh4nd9gAMQqKt8VproFKIe6DWOwP4UEPfHv?=
 =?us-ascii?Q?zjkUbjqQAhZUzfiVoalWG7l/zRczkoX77OKfA5yl/3tQS7hMcVEnQUoZObR0?=
 =?us-ascii?Q?zrYpfVbqMdV+BxxXeTsJZtOIZOGbvhPksQA4HoCa67NKtV0dmXBbHgyJH/JH?=
 =?us-ascii?Q?IKPUorXA3t1TTzxBsoGGLULeSkATRnLJ830Jw9ZnQ+dGQJjOFZjPYiRP46Gs?=
 =?us-ascii?Q?OLWyOrkCprTrHnfV4myZQ3nyT4fZIkRvMo8cydx7y2iTeYomQl3RzmmT4Q0W?=
 =?us-ascii?Q?NswTaO7ledpX16+Ux6NfaV5yYRFbOhLlvkI+CshXcHgoMcrdxzspvaaBUMaL?=
 =?us-ascii?Q?O4Y3QK/tyc0a7JI4EkJq2Ap8EBcQUGPo3qckRC49ss+1tMvCKA/FZa2cmMZ2?=
 =?us-ascii?Q?drKo4+XOxNGCWtGoQi7fH486XZZflenrf1aEHDo+n9dEO8T+HTKKOV8iyBn2?=
 =?us-ascii?Q?pm5YWgEzAwiDNYqSWVjPprnGA86HVlSH63okaVID3fe967r9QBo/qI2wRCZe?=
 =?us-ascii?Q?tRtEClUf7f7ufrwSHcnmyuUqVjudwCKU8maS7eZEZHYZEz3OpEKIJ2DNzFTB?=
 =?us-ascii?Q?YOnH7c+slx4HLSgFcCzuVyC7IGRrfiCm5tkWSQHV+xrbyI8Ub74I/NPZ1S01?=
 =?us-ascii?Q?/XzsqrC5SERs8yESFfc3RtKAMAHihO/J3hf7LtcKm++vWSny4K6663nz+jNG?=
 =?us-ascii?Q?u0Y6uGQRvcNj9+noiLNmv96ox0j1wRu0xDeSFaz+x2plDdDh5ZSOsv+14JpL?=
 =?us-ascii?Q?vjMsQeR/TNbvUxlpxVilzy/llN+M+r/OMwg6Q7kKdGrKrlb7PsKZBRLGgzCJ?=
 =?us-ascii?Q?s+dL+SjEDYcQ3n/gI7r/fG9YtPE0Ekf5qP2Ijqkwe3abXgkgriBEe5XTNJn3?=
 =?us-ascii?Q?a5/JXs4nnz7Ksgj+PXYki/MDxz2BBfJMSgcmW67TProc1pnsNUT6GL1kAlVt?=
 =?us-ascii?Q?OA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A09EEFEFBBC4E24F8FAE4D9A725D1A0E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d43f702-8982-4858-2a6f-08da91afea37
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 15:36:36.0666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jk0WEPxdP3eXSnzTkh0XW3OEu+PrrpPNgSJol3KBTz9IPo1/WhNYo51kW0+5IpF/jteLGRHHRNAN+xmZyxZSKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_10,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080057
X-Proofpoint-GUID: L2FnRs67mDHx1bwyUMeUfkKpkBQP5QKC
X-Proofpoint-ORIG-GUID: L2FnRs67mDHx1bwyUMeUfkKpkBQP5QKC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 7, 2022, at 6:33 PM, Trond Myklebust <trondmy@hammerspace.com> wro=
te:
>=20
> On Wed, 2022-09-07 at 20:51 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Sep 7, 2022, at 4:37 PM, Anna Schumaker <anna@kernel.org> wrote:
>>>=20
>>> On Wed, Sep 7, 2022 at 4:29 PM Chuck Lever III
>>> <chuck.lever@oracle.com> wrote:
>>>>=20
>>>> Be sure to Cc: Jeff on these. Thanks!
>>>>=20
>>>>=20
>>>>> On Sep 7, 2022, at 3:52 PM, Anna Schumaker <anna@kernel.org>
>>>>> wrote:
>>>>>=20
>>>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>>=20
>>>>> Chuck had suggested reverting READ_PLUS so it returns a single
>>>>> DATA
>>>>> segment covering the requested read range. This prepares the
>>>>> server for
>>>>> a future "sparse read" function so support can easily be added
>>>>> without
>>>>> needing to rip out the old READ_PLUS code at the same time.
>>>>>=20
>>>>> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>> ---
>>>>> fs/nfsd/nfs4xdr.c | 139 +++++++++++----------------------------
>>>>> -------
>>>>> 1 file changed, 32 insertions(+), 107 deletions(-)
>>>>>=20
>>>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>>>> index 1e9690a061ec..bcc8c385faf2 100644
>>>>> --- a/fs/nfsd/nfs4xdr.c
>>>>> +++ b/fs/nfsd/nfs4xdr.c
>>>>> @@ -4731,79 +4731,37 @@ nfsd4_encode_offload_status(struct
>>>>> nfsd4_compoundres *resp, __be32 nfserr,
>>>>>=20
>>>>> static __be32
>>>>> nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
>>>>> -                         struct nfsd4_read *read,
>>>>> -                         unsigned long *maxcount, u32 *eof,
>>>>> -                         loff_t *pos)
>>>>> +                         struct nfsd4_read *read)
>>>>> {
>>>>> -     struct xdr_stream *xdr =3D resp->xdr;
>>>>> +     bool splice_ok =3D test_bit(RQ_SPLICE_OK, &resp->rqstp-
>>>>>> rq_flags);
>>>>>      struct file *file =3D read->rd_nf->nf_file;
>>>>> -     int starting_len =3D xdr->buf->len;
>>>>> -     loff_t hole_pos;
>>>>> -     __be32 nfserr;
>>>>> -     __be32 *p, tmp;
>>>>> -     __be64 tmp64;
>>>>> -
>>>>> -     hole_pos =3D pos ? *pos : vfs_llseek(file, read->rd_offset,
>>>>> SEEK_HOLE);
>>>>> -     if (hole_pos > read->rd_offset)
>>>>> -             *maxcount =3D min_t(unsigned long, *maxcount,
>>>>> hole_pos - read->rd_offset);
>>>>> -     *maxcount =3D min_t(unsigned long, *maxcount, (xdr->buf-
>>>>>> buflen - xdr->buf->len));
>>>>> +     struct xdr_stream *xdr =3D resp->xdr;
>>>>> +     unsigned long maxcount;
>>>>> +     __be32 nfserr, *p;
>>>>>=20
>>>>>      /* Content type, offset, byte count */
>>>>>      p =3D xdr_reserve_space(xdr, 4 + 8 + 4);
>>>>>      if (!p)
>>>>> -             return nfserr_resource;
>>>>> +             return nfserr_io;
>>>>=20
>>>> Wouldn't nfserr_rep_too_big be a more appropriate status for
>>>> running
>>>> off the end of the send buffer? I'm not 100% sure, but I would
>>>> expect
>>>> that exhausting send buffer space would imply the reply has grown
>>>> too
>>>> large.
>>>=20
>>> I can switch it to that, no problem.
>>=20
>> I would like to hear opinions from protocol experts before we go
>> with that choice.
>=20
> I'd agree that NFS4ERR_REP_TOO_BIG is correct if you're not able to
> even return a short read. However if you can return a short read, then
> that's better than returning an error.

Many thanks for reviewing!

In general, I might want to convert all NFSv4 encoders to return
either RESOURCE or REP_TOO_BIG when xdr_reserve_space() fails. I
can post a patch or two that makes that attempt so the special
cases can be sorted on the mailing list.


> It looks to me as if this function can bit hit in both cases, so
> perhaps some care is in order.

Intriguing idea.

For READ, if xdr_reserve_space() fails, that's all she wrote.
I think all these calls happen before the data payload is encoded.

For READ_PLUS, if xdr_reserve_space() fails, it might be possible
to use xdr_truncate_encode() or simply start over with a limit on
the number of segments to be encoded. We're not really there yet,
as currently we want to return just a single segment at this
point.

I feel the question is whether it's practical or a frequent
enough occurrence to bother with the special cases. Encoding a
READ_PLUS response is already challenging.


>>>>> +     if (resp->xdr->buf->page_len && splice_ok) {
>>>>> +             WARN_ON_ONCE(splice_ok);
>>>>> +             return nfserr_io;
>>>>> +     }
>>>>=20
>>>> I wish I understood why this test was needed. It seems to have
>>>> been
>>>> copied and pasted from historic code into nfsd4_encode_read(),
>>>> and
>>>> there have been recent mechanical changes to it, but there's no
>>>> comment explaining it there...
>>>=20
>>> Yeah, I saw this was in the read code and assumed it was an
>>> important
>>> check so I added it here too.
>>>>=20
>>>> In any event, this seems to be checking for a server software
>>>> bug,
>>>> so maybe this should return nfserr_serverfault. Oddly that status
>>>> code isn't defined yet.
>>>=20
>>> Do you want me to add that code and return it in this patch?
>>=20
>> Sure. Make that a predecessor patch and fix up the code in
>> nfsd4_encode_read() before using it for READ_PLUS in this patch.
>>=20
>> Suggested patch description:
>>=20
>> RESOURCE is the wrong status code here because
>>=20
>> a) This encoder is shared between NFSv4.0 and NFSv4.1+, and
>>    NFSv4.1+ doesn't support RESOURCE, and
>=20
> Is it? I thought it was READ_PLUS only. That's NFSv4.2 or higher.

For the initial patch that adds nfserr_serverfault, I was speaking
only about nfsd4_encode_read(), which is shared amongst all minor
versions. That's where the page_len && splice_ok test originally
came from. Sorry that wasn't clear.


> If the encoder is to be shared with both READ and READ_PLUS, then
> perhaps it might be wiser to choose a name other than
> nfsd4_encode_read_plus_data()?

Although the encoded streams are very similar, there are still
separate encoders for a READ_PLUS data segment and a full READ
response. The common pieces for both of those operations are
nfsd4_encode_readv() and nfsd4_encode_splice_read().

IIUC nfsd4_encode_read_plus_data() has to deal with encoding the
the NFS4_CONTENT_DATA enumerator -- it handles a single
READ_PLUS segment. nfsd4_encode_read() encodes one complete READ
response. I'm comfortable with the current function names.


>> b) That status code might cause the client to retry, in which
>>    case it will get the same failure because this check seems
>>    to be looking for a server-side coding mistake.
>>=20
>>=20
>>>> Do you have some performance results for v2?
>>>=20
>>> Not yet, I have it running now so hopefully I'll have something
>>> ready
>>> by tomorrow morning.
>>=20
>> Great, thanks!
>>=20
>>=20
>>> Anna
>>>>=20
>>>>=20
>>>>> -     read->rd_vlen =3D xdr_reserve_space_vec(xdr, resp->rqstp-
>>>>>> rq_vec, *maxcount);
>>>>> -     if (read->rd_vlen < 0)
>>>>> -             return nfserr_resource;
>>>>> +     maxcount =3D min_t(unsigned long, read->rd_length,
>>>>> +                      (xdr->buf->buflen - xdr->buf->len));
>>>>>=20
>>>>> -     nfserr =3D nfsd_readv(resp->rqstp, read->rd_fhp, file,
>>>>> read->rd_offset,
>>>>> -                         resp->rqstp->rq_vec, read->rd_vlen,
>>>>> maxcount, eof);
>>>>> +     if (file->f_op->splice_read && splice_ok)
>>>>> +             nfserr =3D nfsd4_encode_splice_read(resp, read,
>>>>> file, maxcount);
>>>>> +     else
>>>>> +             nfserr =3D nfsd4_encode_readv(resp, read, file,
>>>>> maxcount);
>>>>>      if (nfserr)
>>>>>              return nfserr;
>>>>> -     xdr_truncate_encode(xdr, starting_len + 16 +
>>>>> xdr_align_size(*maxcount));
>>>>>=20
>>>>> -     tmp =3D htonl(NFS4_CONTENT_DATA);
>>>>> -     write_bytes_to_xdr_buf(xdr->buf, starting_len,    =20
>>>>> &tmp,   4);
>>>>> -     tmp64 =3D cpu_to_be64(read->rd_offset);
>>>>> -     write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,=20
>>>>> &tmp64, 8);
>>>>> -     tmp =3D htonl(*maxcount);
>>>>> -     write_bytes_to_xdr_buf(xdr->buf, starting_len + 12,
>>>>> &tmp,   4);
>>>>> -
>>>>> -     tmp =3D xdr_zero;
>>>>> -     write_bytes_to_xdr_buf(xdr->buf, starting_len + 16 +
>>>>> *maxcount, &tmp,
>>>>> -                            xdr_pad_size(*maxcount));
>>>>> -     return nfs_ok;
>>>>> -}
>>>>> -
>>>>> -static __be32
>>>>> -nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
>>>>> -                         struct nfsd4_read *read,
>>>>> -                         unsigned long *maxcount, u32 *eof)
>>>>> -{
>>>>> -     struct file *file =3D read->rd_nf->nf_file;
>>>>> -     loff_t data_pos =3D vfs_llseek(file, read->rd_offset,
>>>>> SEEK_DATA);
>>>>> -     loff_t f_size =3D i_size_read(file_inode(file));
>>>>> -     unsigned long count;
>>>>> -     __be32 *p;
>>>>> -
>>>>> -     if (data_pos =3D=3D -ENXIO)
>>>>> -             data_pos =3D f_size;
>>>>> -     else if (data_pos <=3D read->rd_offset || (data_pos <
>>>>> f_size && data_pos % PAGE_SIZE))
>>>>> -             return nfsd4_encode_read_plus_data(resp, read,
>>>>> maxcount, eof, &f_size);
>>>>> -     count =3D data_pos - read->rd_offset;
>>>>> -
>>>>> -     /* Content type, offset, byte count */
>>>>> -     p =3D xdr_reserve_space(resp->xdr, 4 + 8 + 8);
>>>>> -     if (!p)
>>>>> -             return nfserr_resource;
>>>>> -
>>>>> -     *p++ =3D htonl(NFS4_CONTENT_HOLE);
>>>>> +     *p++ =3D cpu_to_be32(NFS4_CONTENT_DATA);
>>>>>      p =3D xdr_encode_hyper(p, read->rd_offset);
>>>>> -     p =3D xdr_encode_hyper(p, count);
>>>>> +     *p =3D cpu_to_be32(read->rd_length);
>>>>>=20
>>>>> -     *eof =3D (read->rd_offset + count) >=3D f_size;
>>>>> -     *maxcount =3D min_t(unsigned long, count, *maxcount);
>>>>>      return nfs_ok;
>>>>> }
>>>>>=20
>>>>> @@ -4811,69 +4769,36 @@ static __be32
>>>>> nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32
>>>>> nfserr,
>>>>>                     struct nfsd4_read *read)
>>>>> {
>>>>> -     unsigned long maxcount, count;
>>>>> +     struct file *file =3D read->rd_nf->nf_file;
>>>>>      struct xdr_stream *xdr =3D resp->xdr;
>>>>> -     struct file *file;
>>>>>      int starting_len =3D xdr->buf->len;
>>>>> -     int last_segment =3D xdr->buf->len;
>>>>> -     int segments =3D 0;
>>>>> -     __be32 *p, tmp;
>>>>> -     bool is_data;
>>>>> -     loff_t pos;
>>>>> -     u32 eof;
>>>>> +     u32 segments =3D 0;
>>>>> +     __be32 *p;
>>>>>=20
>>>>>      if (nfserr)
>>>>>              return nfserr;
>>>>> -     file =3D read->rd_nf->nf_file;
>>>>>=20
>>>>>      /* eof flag, segment count */
>>>>>      p =3D xdr_reserve_space(xdr, 4 + 4);
>>>>>      if (!p)
>>>>> -             return nfserr_resource;
>>>>> +             return nfserr_io;
>>>>>      xdr_commit_encode(xdr);
>>>>>=20
>>>>> -     maxcount =3D min_t(unsigned long, read->rd_length,
>>>>> -                      (xdr->buf->buflen - xdr->buf->len));
>>>>> -     count    =3D maxcount;
>>>>> -
>>>>> -     eof =3D read->rd_offset >=3D i_size_read(file_inode(file));
>>>>> -     if (eof)
>>>>> +     read->rd_eof =3D read->rd_offset >=3D
>>>>> i_size_read(file_inode(file));
>>>>> +     if (read->rd_eof)
>>>>>              goto out;
>>>>>=20
>>>>> -     pos =3D vfs_llseek(file, read->rd_offset, SEEK_HOLE);
>>>>> -     is_data =3D pos > read->rd_offset;
>>>>> -
>>>>> -     while (count > 0 && !eof) {
>>>>> -             maxcount =3D count;
>>>>> -             if (is_data)
>>>>> -                     nfserr =3D
>>>>> nfsd4_encode_read_plus_data(resp, read, &maxcount, &eof,
>>>>> -                                             segments =3D=3D 0 ?
>>>>> &pos : NULL);
>>>>> -             else
>>>>> -                     nfserr =3D
>>>>> nfsd4_encode_read_plus_hole(resp, read, &maxcount, &eof);
>>>>> -             if (nfserr)
>>>>> -                     goto out;
>>>>> -             count -=3D maxcount;
>>>>> -             read->rd_offset +=3D maxcount;
>>>>> -             is_data =3D !is_data;
>>>>> -             last_segment =3D xdr->buf->len;
>>>>> -             segments++;
>>>>> -     }
>>>>> -
>>>>> -out:
>>>>> -     if (nfserr && segments =3D=3D 0)
>>>>> +     nfserr =3D nfsd4_encode_read_plus_data(resp, read);
>>>>> +     if (nfserr) {
>>>>>              xdr_truncate_encode(xdr, starting_len);
>>>>> -     else {
>>>>> -             if (nfserr) {
>>>>> -                     xdr_truncate_encode(xdr, last_segment);
>>>>> -                     nfserr =3D nfs_ok;
>>>>> -                     eof =3D 0;
>>>>> -             }
>>>>> -             tmp =3D htonl(eof);
>>>>> -             write_bytes_to_xdr_buf(xdr->buf,
>>>>> starting_len,     &tmp, 4);
>>>>> -             tmp =3D htonl(segments);
>>>>> -             write_bytes_to_xdr_buf(xdr->buf, starting_len +
>>>>> 4, &tmp, 4);
>>>>> +             return nfserr;
>>>>>      }
>>>>>=20
>>>>> +     segments++;
>>>>> +
>>>>> +out:
>>>>> +     p =3D xdr_encode_bool(p, read->rd_eof);
>>>>> +     *p =3D cpu_to_be32(segments);
>>>>>      return nfserr;
>>>>> }
>>>>>=20
>>>>> --
>>>>> 2.37.2
>>>>>=20
>>>>=20
>>>> --
>>>> Chuck Lever
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



