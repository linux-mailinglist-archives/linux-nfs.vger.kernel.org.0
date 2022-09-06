Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C2D5AF38B
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Sep 2022 20:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiIFSXV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Sep 2022 14:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiIFSXS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Sep 2022 14:23:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981F99E8AD
        for <linux-nfs@vger.kernel.org>; Tue,  6 Sep 2022 11:23:16 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IGrFG019681;
        Tue, 6 Sep 2022 18:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=eAQl8WWdEqzMQr28GQCMajeyQ4df5IRsGEmrhH5HX8g=;
 b=x5jL7xlAABtJnouxFK7lrsMloLq8qc1KUINssKgWB0XKbqBSBJRNS3AZgfYh77iOM8M8
 inyW9AtQlHiDxRUGA2Qb7i5IQnD+6v8iQDGkMeM4SNG9Okeu5bH4OW8V1K0SqSRRpE9I
 QoKA66tmf7rqwpWp5bFdTX/WZHX8ShtUo5nw0q+J1Vu1zCHgIZszZb7hSXQ3U1xKs0t0
 rOUYfZDBNsA8YVMhH8qe6ZV663C7PCr6vawc/w4YmQfnC3skJPMWzyBCZXfM+XHcZMeA
 lgXgtR3SlQgcuNNuFO0+YVLqXflwOxN9Inm26EZBxjJ46RnDQTLBIVm3iLzaOW4cslI2 8Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1eqxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 18:23:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286FuFaP023646;
        Tue, 6 Sep 2022 18:23:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9gtv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 18:23:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFs1dllAvKE+QALBJZDMfNYh+w16Z5aCzH7uCqqS7TBBX7U1YuL6oXEQ6Zm5fQaJDitvuXqV0nEOP5MVWgkMggUH0aw4LRTFQI9FTCo4Abz9YikuMXxfxK0ZVc89sia2Esdn4ZEX0FqzbeIBvTaqyTh83FVaj/2i6KButJvX0BUenITiEA6NSko+oKdtnY/jQoXkMxa+qrOfz+JakG7Zgg51Cu+SpMe40LInNFsam7BsLIQQg0wfFZfV8uJWWTV+bYiVggJCb9CnbVX80Ds1Wt0SUP7/xqr+FPDyEzu70JIjHbHsF8HmvO8oah7IkFwLGYevwl2uNbe2UIZMMgpuhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAQl8WWdEqzMQr28GQCMajeyQ4df5IRsGEmrhH5HX8g=;
 b=mplXqov3J+1jV5s+HoGYTQ70cJ/uiSwpjAjIjisHmOVJiqc8NPZCzBDzBcvFOAAzWMHYhMmms2l/AWmVno66MjPOj/NkqngQVoHeVhfStBIlWZAYTYeVc5BF/mwylUxem/QPynCnH3/r7xvwebzjFbSydo+oEFaU9SWNNpb1Ql1kQyyDC5hspMjLKJoX4vHq/qE0+RpYo0KbmnIwp2JqsVYunClgJGnAIKSXy1FjSkeFRBM2Zm+iwiTcZEIB2tyY/wgSzSFBQWgy8Pq6FNX/AQ2oLD8hK+Hzv8nj3HZVs07uyRLMZcrZPPt8Fk/o8ZZ4+HXZDT/ECRvS3AGpqWBFWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAQl8WWdEqzMQr28GQCMajeyQ4df5IRsGEmrhH5HX8g=;
 b=adQuMQmzaf7it80AtNEKxsd4ju6+lm2+CvCJ5I6FvNZQaA5dvdtEZNgmrPxJnULahFafA2Qni8pi+upcVcU7NMw+7pQzVWHc7MImS3CitcHWEsTcw9pXeFVHsYewrC97wT5QmrHx9F5E6j+lBO+6u7dYOTZBNhGY3aefpljP3Io=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4357.namprd10.prod.outlook.com (2603:10b6:610:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Tue, 6 Sep
 2022 18:23:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 18:23:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/1] NFSD: Simplify READ_PLUS
Thread-Topic: [PATCH 0/1] NFSD: Simplify READ_PLUS
Thread-Index: AQHYvjFgBg77Wrnv30+1UKhkeKONIa3N+vyAgATClICAAAFzAA==
Date:   Tue, 6 Sep 2022 18:23:02 +0000
Message-ID: <B09AA7C8-A15A-444D-8B29-766B1BB67876@oracle.com>
References: <20220901183341.1543827-1-anna@kernel.org>
 <0125F316-1D9C-4A0E-B1B9-1919C9F26718@oracle.com>
 <CAFX2JfnQ=KygdjYMk3uTy2T9N+We3BH_xiWT8eCG9Y7rrVOD3Q@mail.gmail.com>
In-Reply-To: <CAFX2JfnQ=KygdjYMk3uTy2T9N+We3BH_xiWT8eCG9Y7rrVOD3Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 541ff9ea-c8b7-4c6e-9f53-08da9034d601
x-ms-traffictypediagnostic: CH2PR10MB4357:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b99AgXoyUdOxqd0uNsb/DEl2ci1vmJXRlcdiVuzeeNqxNLf1WYKCJ1uI+kG/MKkN4tf2dZKKzsHCTH1pf42VAHYOm6ozXDp0GfaAXa+pFILfieP6qa83pt5Mns3LSMX1YpB1caITwfh3VxXC8PO7siOugiVNj8pEWuApr2MGq0+rbb4R2GwfSGsgfKibPaLAOxH4eZAV6oebXtbaUjw/n8dBEkM93CtfTuoKiXtGK5zb2ssugWSa+E9gB8BDwQqQE7ud5UYpq1UZUVaVZNeQiszxM7/dmABcaoj0gOeUAMSanw4UfRQGljRwYnaMf/tVOsFOwQAMjkJyR9NkNLXM8HM3KG30+Z6xeNKU7BqQZvqGT/+KYWkn8AmZm6Q33jaG7+G4DkK0iKNWu1mIRIWzsAxcskQ5Gru3yfkKjMSbxANPur7rwLHHc8B+hCHoPnz12cEmQ9y51afn9r7frkKrDyAiQDTBraRxLK9xPv/RhW20EMCOO79aNAR5hoIW8RjHTzLNRJPPbfYZV6nDqrUsLTe+snfOeYRQR1890jRdAKVaaGw9hvoqmPcw8mrTmN1nfi37Me3BMfitf2iqYBSqoO5/g9sajN/m3uWnqY8u00vDt/4F7NFfvwvsHgxefw/kUnvyMEc+j4cyboT79z+3z8u7sDwdJqSVqS73QER0Ke8nJ43eOUJGLVODXIdwyE826OFYS6W51QEAlDSpk28CkMhe9l+Kk/b9/dj3UKPJNwd/2/WZoOtSXGH0jR8hxOWkhPbkLoBug94kGcLqfFlpoTTGaIJPv2V5D/IyfXi350s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(396003)(39860400002)(376002)(366004)(2616005)(41300700001)(186003)(6512007)(478600001)(6486002)(26005)(71200400001)(38070700005)(122000001)(6506007)(38100700002)(86362001)(53546011)(5660300002)(83380400001)(316002)(33656002)(2906002)(8936002)(4326008)(8676002)(36756003)(66946007)(66476007)(64756008)(76116006)(6916009)(91956017)(66446008)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xHNrzMblMb94RLlULolOdrdhavivxrz770Yqp3jmTGbZ/apUY7YNNkMsVk3v?=
 =?us-ascii?Q?vKofh7YTmSbskNKvDEU3FoP/UgPiNmIDpVmz627Pfoa+1MROe02USsKGu+p9?=
 =?us-ascii?Q?LBE1vvSF9tv9lyT9tMltTd+TKuSup5vldf5dJ4qP5av4iOo5SC+0I66CO5VZ?=
 =?us-ascii?Q?TcopEXKGiFFpjkMrZE2eXHtKgdH7f1urNrFh7Y6NDIMzkB36HHR+tVxix8Th?=
 =?us-ascii?Q?rldXymg8mgp+chuNVeRxg6d+G/6L9hFCq0zrKZX+rn16GLslJQxuvuRcvvHe?=
 =?us-ascii?Q?jG1oP6R5Bzlvwh0e4LP/2YOAr7FbLtqezNnPk1+ZD+Ei+vbysk/aInzze+MP?=
 =?us-ascii?Q?SWTycq1MM/+27arsYaM9Y64PxTei8pisfy9Myt8Yujxoe6H8p5zdkn5veCyU?=
 =?us-ascii?Q?Ew/GrwbKoUdMOHNc2uZ7tsGKBScagPlsEdsOjb6Dn1FPfr0nCnRsKd/Osaku?=
 =?us-ascii?Q?wbTWPbiTDSM49rASLnzmZfSn/5jiQF2OcTtJ5p4mSUqqfoDchqNip9ZvuxWR?=
 =?us-ascii?Q?3Fxia0iQujdwEqpOlnbN0pdGaj97rlK+aCEeAD63RE3Zbx9vS92h4vTjWhS/?=
 =?us-ascii?Q?hSAHrbNdUf0mTh3p8ewt7B9IHVmho+YR2zd/Nwfx0iagIukujfKMaPh84iGx?=
 =?us-ascii?Q?inqWYus/iWgXlIPuYL7G5cpKTF6y6vOAt/Ky/tu8QSwza9QWMv1GifFbI4TS?=
 =?us-ascii?Q?zA5XFEdmTPJ/Li0l7/2ucDVK03psxEu2lIzG1B7xl4AfeoezZZH+/7BZJ+FX?=
 =?us-ascii?Q?MtT82ItVnfkQ+x24QTNHSK6qwMNKBOFS3ExcrUoc5qMxmKLcGSuXLVf1jJ06?=
 =?us-ascii?Q?LFnRhiDBel0ZhN6xpEJBL0BY9gYL/yCqj+NO3EPZqBOVvNdZiZHzoFljGKI4?=
 =?us-ascii?Q?OgCHbnHV17LRaWFgd688Yt5qyQeaBfiAoEamOsl6HJfOr/pC/Qvwsp25x2KG?=
 =?us-ascii?Q?x0RKR1hljZvOVX6R0uTVKuPPfQI3ODjBYZ8lWfWFcty3q79dEfinvL8pI8DO?=
 =?us-ascii?Q?zBeSLow3bRUgMAgwPuTHEMXnU21qDKcjX9sSOgi7ZxVdNXVKzMGBADE1krwr?=
 =?us-ascii?Q?VuXY7URVeAN7yoifYy7GV4JJuyw/asoAIBPuxYh4rCX1rVv1tsNzzobvP20e?=
 =?us-ascii?Q?XTZdFaKxKciEuSBa3DJMKw3t6gbAyU3/ee2oc977VwHb9nN7xkOAbvoZOe/3?=
 =?us-ascii?Q?fOqoei2JQpMZe+p5LVjU+HWjR+8PRqjS/FIA58iHqUe7U7Bj/EcCdj+pHQ+y?=
 =?us-ascii?Q?wcvA4729fPPL+wAdagjc0N1lI3CMTFREzzSlxX1COQS6T7+GTnXR66GXM7Gx?=
 =?us-ascii?Q?8ou2GYLUSLt1mu4mbOsQVWevT2f6GE/LKpR95oGimhQ538qcrwuTHjJaS1si?=
 =?us-ascii?Q?R2OU1B2ua6yiUPuhHNZ8DtgGVuVg+3YHAwA8UJ+mJ++G+MoSghAzFl3wUTpO?=
 =?us-ascii?Q?eucdwGQ+r7+GqdyWVGUYJYCQAG4+c/kfw6QRXBK7yWEQhfaRHqcERMxiFOcy?=
 =?us-ascii?Q?FkubA0MEiOioCXSFikePY4tBXcKyNNP8bP0n4P1N0fF9VjcKdcFmO1qLnfRG?=
 =?us-ascii?Q?sePVey5l8AYaxepABTS1MfojJfHr+fStutMlSG27PUJpzhV74M9wRPpEfAqg?=
 =?us-ascii?Q?wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E14C663E5DF8047A280C804A20E4144@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 541ff9ea-c8b7-4c6e-9f53-08da9034d601
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 18:23:02.8991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eTGZETAe7QXvyRLx6brJQJwNpOHPJ24yjihpMCMs8jgDgwODkkMCpdngXkPqiajx/3dJIhsh5OnJH2I69RT4pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4357
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060085
X-Proofpoint-GUID: ibzInqm8Mxtr1GqAaT8BSrTWv2qSxVkb
X-Proofpoint-ORIG-GUID: ibzInqm8Mxtr1GqAaT8BSrTWv2qSxVkb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 6, 2022, at 2:17 PM, Anna Schumaker <anna@kernel.org> wrote:
>=20
> Hi Chuck,
>=20
> On Sat, Sep 3, 2022 at 1:36 PM Chuck Lever III <chuck.lever@oracle.com> w=
rote:
>>=20
>>=20
>>=20
>>> On Sep 1, 2022, at 2:33 PM, Anna Schumaker <anna@kernel.org> wrote:
>>>=20
>>> Chuck, I tried to add in sparse read support by adding this extra
>>> change. Unfortunately it leads to a bunch of new failing xfstests. Do
>>> you have any thoughts about what might be going on? Is the patch okay
>>> without the splice support?
>>>=20
>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>> index adbff7737c14..e21e6cfd1c6d 100644
>>> --- a/fs/nfsd/nfs4xdr.c
>>> +++ b/fs/nfsd/nfs4xdr.c
>>> @@ -4733,6 +4733,7 @@ static __be32
>>> nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
>>>                          struct nfsd4_read *read)
>>> {
>>> +     bool splice_ok =3D test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags)=
;
>>>      unsigned long maxcount;
>>>      struct xdr_stream *xdr =3D resp->xdr;
>>>      struct file *file =3D read->rd_nf->nf_file;
>>> @@ -4747,7 +4748,10 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoun=
dres *resp,
>>>      maxcount =3D min_t(unsigned long, read->rd_length,
>>>                       (xdr->buf->buflen - xdr->buf->len));
>>>=20
>>> -     nfserr =3D nfsd4_encode_readv(resp, read, file, maxcount);
>>> +     if (file->f_op->splice_read && splice_ok)
>>> +             nfserr =3D nfsd4_encode_splice_read(resp, read, file, max=
count);
>>> +     else
>>> +             nfserr =3D nfsd4_encode_readv(resp, read, file, maxcount)
>>>      if (nfserr)
>>>              return nfserr;
>>=20
>> I applied the above change to a test server, and was able to reproduce
>> a bunch of new test failures when using NFSv4.2. I confirmed using nfsd
>> tracepoints that splice read and READ_PLUS is being used.
>>=20
>> I then expanded the test. When using an XFS-based export, I reproduced
>> the failures. But I was not able to reproduce these failures with
>> exports based on tmpfs, btrfs, or ext4. Again, I confirmed using nfsd
>> tracepoints that splice read was being used, and mountstats on my
>> client showed READ_PLUS is being used.
>>=20
>> Then I tried testing the XFS-backed export with NFSv4.1, and found
>> that most of the failures appeared again. Once again, I confirmed
>> using nfsd tracepoints that splice read is being used during the tests.
>>=20
>> Can you confirm that you see test failures with NFSv4.1 and XFS but
>> not with NFSv4.2 / READ_PLUS with btrfs, ext4, or tmpfs?
>=20
> I can confirm that I'm seeing the same failures with NFS v4.1 and xfs,
> but not with v4.2 and ext4. I didn't test btrfs or tmpfs, since the
> ext4 test passed.
>=20
> Should I re-add the splice change for v2 of this patch, in addition to
> addressing the other comments you had?

Yes.

Given the comment in nfsd4_read() I think READ_PLUS can't use splice
read for anything but the last data segment and only if this READ_PLUS
is the final operation in the COMPOUND. That will need some attention
at some later point.

Meanwhile I'm going to try to bisect the XFS READ failures right now.


--
Chuck Lever



