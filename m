Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C826E496DFF
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jan 2022 21:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiAVUeJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Jan 2022 15:34:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62906 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230311AbiAVUeI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Jan 2022 15:34:08 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20MK2nZP015992;
        Sat, 22 Jan 2022 20:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fiRZ66ayLSnqi0ecrH+YkiQ+u65x+edBiqAqxnOzXto=;
 b=Xb65iRf9WnUtWiS6pmMt8dmtVvVjJHS5ISu55rTLfpCdvai4/8vyh80oyJC0TOrUgaHx
 YKEQiNPKeeCjbF3mnN4GIXubbT6d9Pf/5YANVioEcSy7jexgYmlqeb0bhNkJSjm4hLkX
 LEynrMjU625gO8hAiho3RvW179aFmoK8Bdghnf9fWHgLH5HSA6OilqnyDbjpXKualaZu
 5Skv0dKENi/1AInyaCStYAqsOsQu/um8CCc5qZBTJKT6c5IFCQkxEGq/C/RnvoA/Z3Y4
 YAabuteEPLMKG8YgqUEQ+WZtbNAerPswiaLqLHgXBg9yKsPz3xuJBSBK/gN7lKQzaGYX ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dr8h19cj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 20:34:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20MKH8Ro191707;
        Sat, 22 Jan 2022 20:33:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3030.oracle.com with ESMTP id 3dr7ybwx7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 20:33:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqWWunt4ddgo/6sBcTW/LNmkn6MAPQ+306uNn8OcY2qy3Wm5KIzeZUb+dS7kvNPyfoip8sAwoLB4YAFBSOVwSCD1GGG7CuWFGBsmhyyNNg+IS3WRqvbTZhp0qBtXYzLqhNPT2jdmOB47DqWpyG63joMggBqTDEnGTdqQcxdcckA44C1vTQyT4gqQ97e7B8EmVL+XJ9hElQyNT+m9mJMZiJgup8t1FEbdj3cvWvnqMny2Cp6UaUeDY3/oZFNa9RI4ovRxM6Xov1/1y3IPH0FxsUbbKDk8uYwTHW5G0ThdtVC1g7YT8Ye9NMI4shMjI06AJFtxZqKS/DHckvl/Tm2OUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiRZ66ayLSnqi0ecrH+YkiQ+u65x+edBiqAqxnOzXto=;
 b=NEpTgLh2i5ekA6R6pGPDiDo5TsttzTjmTHgX7HxS4qNP50DCoUqN3mPen4Fm4BK+O06YwuzALoof3ljyFWNOLU2Hhs1UGRO1OhiylINoPQuvY5zFR/Uocz6f+jtbQyrFvqoIKUAOjKHztrbSBgqKP9+Oup2G0C8/XRhGcmjK+J8ZABZzsCZLFqqguIcVXesaIV45XeUEFO+yE94PxPVQWeg/Qw7Qu8OkSq7afdwRPoTENVNzhjwCFLNv0K2aD/em1CMk9jJEGj8/bRiqWz9+GbafvHXDVGP/95/eQmxjzDatp0qoaADgHwvE1y3NNc7v/9C08G/jp3LR3Fm4d0LP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiRZ66ayLSnqi0ecrH+YkiQ+u65x+edBiqAqxnOzXto=;
 b=QwziT0we0ouHmwF+6bq3tu0kS4p69wM6vQFp6JoqKEv/ktu7+N5ggZ4G7RWoI7KLFZxI9J2Jged3SLAdJibU50h0qqm2jEOL8uA6f4k0xH3hUmNsBSziE7XrgP4VBaq0Pm4sbgxmXLjhVr4LVQS9DR9ipaO0qr2gyvmHlnTcwsg=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by BN0PR10MB4920.namprd10.prod.outlook.com (2603:10b6:408:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Sat, 22 Jan
 2022 20:33:53 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4909.014; Sat, 22 Jan 2022
 20:33:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Aloni <dan.aloni@vastdata.com>
CC:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [PATCH] NFSD: trim reads past NFS_OFFSET_MAX
Thread-Topic: [PATCH] NFSD: trim reads past NFS_OFFSET_MAX
Thread-Index: AQHYDvfTRZNTkkSWjkWDIwR2Vc39WaxuD5oAgADuzQCAAEhDAIAAIDaAgAAZ7AA=
Date:   Sat, 22 Jan 2022 20:33:53 +0000
Message-ID: <6CEAFC69-B6D8-4C07-A121-E03FB6220354@oracle.com>
References: <fa9974724216c43f9bdb3fd39555d398fde11e59.camel@hammerspace.com>
 <20220121185023.260128-1-dan.aloni@vastdata.com>
 <5DD3C5DF-52EF-4C84-894C-FCBB9A0F4259@oracle.com>
 <20220122124710.4l5bzmfxhf2o2yee@gmail.com>
 <04E4C6DC-B78F-45DA-871A-296379B2D484@oracle.com>
 <20220122190105.hgl53kthxmxlanaa@gmail.com>
In-Reply-To: <20220122190105.hgl53kthxmxlanaa@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f8e16be-9e62-401e-9e4b-08d9dde68167
x-ms-traffictypediagnostic: BN0PR10MB4920:EE_
x-microsoft-antispam-prvs: <BN0PR10MB4920A7C83D1C74C04A544B18935C9@BN0PR10MB4920.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OY0DMtpjuS3HwjKQex2616Hr8gvkZHZSBCKLFU3D2b+c4dxmaabm3R3D8i76Z+Q9WN3ZniNjFpCBMpXQSV7ypbk28BXdR2jQgZUMR2gOEq+oT41MlfjyDG//EGXgTI8eKK2X7RH8XZEDw8deob+vItxwMbfUASzl44Dx4nR5Xk7aM1lT/6q8khfAATLhzTRG0uMa70h/+OgkyAZxM9BZ4WO+Lu+rCjCuDSsiycTL4p2p3rJNB1pgBl0Ddq0Gdu5UiCivNQ2izLdyLmJZ8NEjgDX5HaSAkdYwVyNNr6CdK00XDRapMjnyAcXH2w+Qe22h21IUDnYsG1QOR207LJkBiYDO4V9e9aGkSaYYC6wW5MrAXIx7D5VJegYU7YhkZMwzhliDXcG8t+OP+Mvs+3QBXpBhHKYmiM1b1BHfgbJvjESfPeCx1/XFNj59UopnrMniXraYpRXbUZ1mTs59OY+lzsHjbk9ifrhe4/DPFVrzKHwe+8ADYG1ayI5nkK00C5iC9woT5N8oX3NFjVaO4nsHhXJrsFDfuxlN+qkblUpW0zsTkgde5CGPf4QnDt7dShRXAPZt3a4f/W/D2zc3IofCLf8rG42MJGKLf6pxyl73Vuftpxr0gH7CS87g587Zsio4qMMD3X9E+/0Z7xsOtSPxJL73CysZj+8jc75mXFQKx5tNND2W3Vvv8poy1SaDwUQ6OEXSdFIl/OxXX09IrVQ8g1V4vbqNMH+CnIA4+lzhJdo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(6916009)(26005)(66476007)(66946007)(316002)(186003)(38100700002)(6512007)(38070700005)(6486002)(6506007)(53546011)(4326008)(33656002)(2906002)(508600001)(71200400001)(76116006)(86362001)(2616005)(5660300002)(66446008)(8936002)(8676002)(36756003)(64756008)(66556008)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1MOmqFGXFjF7i5j9giv/tvMTZdRYhHSlLWj+k3BBQa4dzeO4VSxOc0RCTk1q?=
 =?us-ascii?Q?6MNU05CAYp3CdT0SVPt3PsMxXX/icJ1ND+cxCgKIWbAugolcYk7uwJYlM7i8?=
 =?us-ascii?Q?tsz8b3/2InsCdGzVNNwIPlqSxcQ0I/kg9jQIAam59TNllS3Coz17i4BW86rE?=
 =?us-ascii?Q?QTnL/a8YC/chv86w0Fj4biawSnONE928xQWbxsjGI2kbqUky5IYBYXWy7QvE?=
 =?us-ascii?Q?mzgGSXq1B9iPNWZG9IrqClo3OuRsnXn1BcskJTaV+WLtGkmnl9DRVjg7h0UB?=
 =?us-ascii?Q?4jJ34Ta7JRC7hVPMewF/fYZA63tr6hv1v+7a9prGd62TFLTdoPDQShTMMATE?=
 =?us-ascii?Q?Yz8yMqUuab+WXQIfsereoGfharC103oKgYQsphYCQkKixhJCId0Ghd6YImnV?=
 =?us-ascii?Q?47ixqad/rHGiPHB4peCJFz98B1w+6i//UwBqW1m4SAqst+RLje3UpN9AcTSG?=
 =?us-ascii?Q?JR+vllStY7WD/EsEwqTvXKv6FWivnAEUl+pX/+a2gxnr80l8tlWHD/amoR3E?=
 =?us-ascii?Q?0X8nRptrhGRh3Er1Ixdv3xBHUwqTy1S3C/8KbYn27j2YBdfPYZ3dfwWPJPXt?=
 =?us-ascii?Q?ozhPqOeRbGxsa3seCdT3TUkl0RO0rAw9534Rgl4SpacARIpKIxpiibEuMLiL?=
 =?us-ascii?Q?AnGVFWKFIAd1D2mpryFBmJGb0g5r7DC3IkoEkQeo9izcpJYVTyKUPjpgGGi9?=
 =?us-ascii?Q?+EtUzp1SBgOGjl3OtnxJSU7ZtcXJRmqT7szw91lT6eOjx22V6hOYwVAbeg5f?=
 =?us-ascii?Q?A/gx4R2AIgdmAGE5VlceT/o9itqgSkgoUL+gsgvJ+BTi5Wxk861gyQ01aBHN?=
 =?us-ascii?Q?fuQA5DqsbWVYdTAsJgkD70T3Kh9678X8MRL4YYwMU1M73OEo1yF3xM1eofre?=
 =?us-ascii?Q?kkHuzZ65dtFGAeQBUpS4wbS+9/zgvjHF5Tw6tQrVqD8GY2+po030RNyFOGiS?=
 =?us-ascii?Q?/A5jy+aAtLsib09/5gwWfgcWWE3MHEfD6g0pZz81jR/Kcm0TnWN6rN6ZcvKe?=
 =?us-ascii?Q?NliumRIOC4cX0Zjwj4dTyX1wvmjGMhbCAq2dT3D/ZlD/10V9zkNj/79Mf9eI?=
 =?us-ascii?Q?9g//WRwHaBje0H29JRBCyIxvI2ZLp4i+FZkYfDozkRM36eOvksB19Du6tO95?=
 =?us-ascii?Q?cYB6ABNYfECde4RwyNgxAsV8D4YzaXqDXo/0Qbht+NjMk+AhTDSK6NH9ZGyy?=
 =?us-ascii?Q?bFKLNK5Ykbem0iKnVdtwU0uK8buG+dzlKZ+aO7+Da+pUfrzwrQJGy2WmRxKX?=
 =?us-ascii?Q?dQCZWMb6uHy0cBwTutK8ywVRGrkbVu218yXyx3ATHPKBDJe4B9OzqiYRfDaP?=
 =?us-ascii?Q?pZjlOY1OrGL0J5BMsZ6cHfxzGO/s1KJ34n6tEAgjhUj4wm9l7ZND2KXyx0be?=
 =?us-ascii?Q?2tohtdehml8qORPaigGcSYxbPE7icMVc3cYOLri9GCTsD7V4LUnOzsKIPriO?=
 =?us-ascii?Q?tWAVw2KQAM6FoGjzVRT42fQeyUp9dYUSEuN9TLYjQoQaFZVmcpnEIOFgg1jS?=
 =?us-ascii?Q?EjI+JHU7J/fbCDVOVRH17Ssk/auHm0LbCvvLKG5zTd2pkDHFbsHJitq/Dr1K?=
 =?us-ascii?Q?VFcgJ37AR4YS7y4EnxdTZHccyNAEXSaHJ5v6Tddzjn/giA50A1U4LEWAAJgm?=
 =?us-ascii?Q?egP8iI+4QzyiqSdZqzkZlDQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <04FE12DCF92BAD4590451A1ABC30A625@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8e16be-9e62-401e-9e4b-08d9dde68167
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2022 20:33:53.1810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRWsmMXY3G942JT5VE72EJLRYZkxTcF2/k47ElbOLi0jJ6zpPyqEEqz619XnSE28vRe06Y7TnfxoRhInAIkheQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4920
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10235 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201220145
X-Proofpoint-ORIG-GUID: uoUSW9tAN-0sZnnezaFVlNAeWZQ58nmk
X-Proofpoint-GUID: uoUSW9tAN-0sZnnezaFVlNAeWZQ58nmk
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 22, 2022, at 2:01 PM, Dan Aloni <dan.aloni@vastdata.com> wrote:
>=20
> On Sat, Jan 22, 2022 at 05:05:49PM +0000, Chuck Lever III wrote:
>>>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>>>> index 738d564ca4ce..754f4e9ff4a2 100644
>>>>> --- a/fs/nfsd/vfs.c
>>>>> +++ b/fs/nfsd/vfs.c
>>>>> @@ -1046,6 +1046,10 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
>>>>> 	__be32 err;
>>>>>=20
>>>>> 	trace_nfsd_read_start(rqstp, fhp, offset, *count);
>>>>> +
>>>>> +	if (unlikely(offset + *count > NFS_OFFSET_MAX))
>>>>> +		*count =3D NFS_OFFSET_MAX - offset;
>>>>=20
>>>> Can @offset ever be larger than NFS_OFFSET_MAX?
>>>=20
>>> We have this check in `nfsd4_read`, `(read->rd_offset >=3D OFFSET_MAX)`=
.
>>> (should it have been `>` rather?).
>>=20
>> Don't think so, a zero-byte READ should be valid.
>=20
> Make sense. BTW, we have a `(argp->offset > NFS_OFFSET_MAX)` check
> resulting in EINVAL under `nfsd3_proc_commit`. Does it apply to writes
> as well?

Geez, that's whole 'nother can of worms.

RFC 1813 section 3.3.21 does not list NFS3ERR_INVAL, and does
not discuss what to do if the commit argument values are
outside the range which the server or local filesystem
supports.

RFC 8881 section 15.2 (Table 6) does not list NFS4ERR_INVAL
as a valid status code for the COMMIT operation, and likewise
section 18.3 does not discuss how the server should respond
when the commit argument values are invalid.

Aside from nfsd3_proc_commit, nfsd_commit() is used by NFSv3
and NFSv4, and it has:

1129         __be32                  err =3D nfserr_inval;
1130=20
1131         if (offset < 0)
1132                 goto out;
1133         if (count !=3D 0) {
1134                 end =3D offset + (loff_t)count - 1;
1135                 if (end < offset)
1136                         goto out;
1137         }
1138=20

which I think is going to be problematic. But no-one has
complained, so it's safe to defer changes here to another
patch, IMO.


>> However it's rather interesting that it does not use
>> NFS_OFFSET_MAX here. Does anyone know why NFSv3 uses
>> NFS_OFFSET_MAX but NFSv4 and NLM use OFFSET_MAX?
>=20
> NFS_OFFSET_MAX introduced in v2.3.31, which is before `OFFSET_MAX` was
> moved to a header file, which explains the comment on top of it,
> outdated for quite awhile:
>=20
>    /*
>     * This is really a general kernel constant, but since nothing like
>     * this is defined in the kernel headers, I have to do it here.
>     */
>    #define NFS_OFFSET_MAX		((__s64)((~(__u64)0) >> 1))
>=20
> And `OFFSET_MAX` in linux/fs.h was introduced in v2.3.99pre4. Seems
> `OFFSET_MAX` always corresponds to 64-bit loff_t, so they seem
> inter-changeable to me.

For now, add OFFSET_MAX in the NFSv4 paths, and use NFS_OFFSET_MAX
in the NFSv3 paths, and at some point someone can propose a clean
up to replace NFS_OFFSET_MAX with OFFSET_MAX.


--
Chuck Lever



