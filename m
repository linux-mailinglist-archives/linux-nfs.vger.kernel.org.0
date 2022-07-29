Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAC15854D2
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jul 2022 19:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbiG2R51 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Jul 2022 13:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238184AbiG2R50 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Jul 2022 13:57:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0293288F08
        for <linux-nfs@vger.kernel.org>; Fri, 29 Jul 2022 10:57:24 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26THtIfO004664;
        Fri, 29 Jul 2022 17:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1PA4UIMGSGphqkHQFSSLSGLjLUb/jmJbYGY21Yd+yec=;
 b=kPT2+1EIctxukj9bGpQY5Jm6mmLmOZZHsamTQ/mTIEFduSt5qJYNypUqpS/RxboKu2gv
 +GiahWkoCumaJX0G6LDfbxRlY6eJPPKrwc5Wq52ep/MklKiE+01T0fb0lUgt+nSy/Mtb
 rii4iGIR96xL2AS8lMP7NmApRXsyz1xZyXDYt9bJemLSSdBaY7bJ3FRQsxNT2Tvk6tqm
 ihJojYhWUqD2XmNvJBzzJSdubMniIeLifMP3aDHy6VezfRI8W7iEtGVUPtJgLDewCX67
 pzUx6XPOjVQVTNHczafiEzjGIgmWupouxziyPiB43X6MJK+8Zz5XbSHWQmQTjMqO6H1O CQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a503yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 17:57:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26TFWHtC009209;
        Fri, 29 Jul 2022 17:57:18 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hm888sakc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 17:57:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YseU/Rq6blFvxYej5jSjPzrGrkiYuZScpsz2lr/oNRJrDg/dIqzzlL8fMv1jDkZpMwVDltj+rsTXOmc6qVLZlwnmdSoxZrKY3M35MrSlgSFbOM8+oddfT0hEGDFzBJbuVqbOVtDJprKqOi/HNyStrCFvZp3xkdQdDhsJhfm74Me075B2QukPAhIuCKH6WLIkJOBCEr6GWiDZG8M+EJ9HabmqXHmzOFIeb8LJMwpIniGIC6qsupXmE+HVP6N+hXh6/VK9rAjFTEpOX6kJTS21Z7nPpZzy4Gd3SdZZ/XVzSciHP61Z7zL09pZEFzvpuwnYar1PglR6b3wEq47Um9ebjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PA4UIMGSGphqkHQFSSLSGLjLUb/jmJbYGY21Yd+yec=;
 b=FMHkxJPIpoNHEJYWBCnt/8Fhn4Js8RCnoxGXVW/MLMBryYtfzulBoey73VMk6kwutLjaC7CFD00/okdful8Bt7bHsOXanwc9vkBo/sP9rEI4m9+LsXSEncc/eNOs4JPBoAVEYeBaZzM5/bYuwFo4Gy3I3yD+XRP05RmMX7xvvt9RcSlSdzfm+KSlztf/KBvpSzdIdVFUxl+Y37Y75JeqOfJCbZo7L2+Ak/OB6Un4ADyZAMQcjAYQ84gNI5J/KPAGp1jbQgMNIu84LZyk0QbwLvNir4hTqHe0TREJxe/ukFaRGo5hXhJuWEmoBOifF95oOyHja1HUjj9z1rQ0GSUlRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PA4UIMGSGphqkHQFSSLSGLjLUb/jmJbYGY21Yd+yec=;
 b=aUfkdn6eP+W3NCK36oxIV+aal/Gq+KY1lq/vsyzgIMaXnD78Xp6rPFnLWdx6/gK+imOXmL8/5FSJVXGuolEWiol/Z+5haCTzUvxJqboom68nwo5QiABOYv097m0sRFeJPN/koz2T6nnhxRj6sAPSFrM2u6GmdwrpaFDD1YuAVqI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB3723.namprd10.prod.outlook.com (2603:10b6:5:17f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Fri, 29 Jul
 2022 17:57:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 17:57:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: Re: [PATCH 3/3] nfsd: eliminate the NFSD_FILE_BREAK_* flags
Thread-Topic: [PATCH 3/3] nfsd: eliminate the NFSD_FILE_BREAK_* flags
Thread-Index: AQHYo2rgY8a6WWViM0iW0L8RSDO/l62VmE8AgAAD4gCAAANOAIAAAlqAgAAAloA=
Date:   Fri, 29 Jul 2022 17:57:15 +0000
Message-ID: <DCA9B6E1-1675-49AC-BAC4-A68DFBD27A79@oracle.com>
References: <20220729164715.75702-1-jlayton@kernel.org>
 <20220729164715.75702-3-jlayton@kernel.org>
 <5B5182C2-2B5D-4863-A6A4-8F3A6098A9AC@oracle.com>
 <de316707b0bb7e73d16acf717253367578e7f05d.camel@kernel.org>
 <84AC7FA4-9DED-4435-8504-310F6F41C130@oracle.com>
 <abb6f3fb336c3039a7c7a298c1d4722a731911ad.camel@kernel.org>
In-Reply-To: <abb6f3fb336c3039a7c7a298c1d4722a731911ad.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5afdce27-949f-4f14-52d5-08da718bc5d9
x-ms-traffictypediagnostic: DM6PR10MB3723:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rnCuIHeiQMeOYSe4fZBQLDGQmP6ioXuZbx9jKMOm/1ywFDNDJUuqFDwXULA4+Jr+Si0Z8RIC/OfPVY37o2yFx+8YGhRpTOrpq1rMRU/UCJYGJMI0q05EhfmIR/poeTNjjRbsgEbI9ftXzeDxQnAHdMuz1BGgL9POM13JY/vOkpEMBgRa4roUtWQlJOFCYfrSzyoedH6VCMGOr3SINTkT4IyTu6qOS1ZqWDx+u+OARksTZ7ON5C2ooQPQGH9qfVXyNOtDKIN10FJnBA7l+EI0qxMAuDIR0YgzVv5T4aOHQJM9M5pWixYIweLeS85mA6nh5lx6nd4GA+eh+W+5I+uJ1mH/whZMpndCTLohHuhG8iTUVaemUIznaFv8dwnRGuuU2TAEdMR9c+YemPie0y1Q0gaKVQzQPvf87w/NwzWaCINsoBAK5mhXKmj+AOlxf3zY2ph+htupA1SBZx1/RA3qdKAqockqqU04iHU+ry4iYXjITwIx3baTeHPm2qUh5UPTkwiMeO1u1MZ+fGMVUcHVMETeFD7QRD93aaUeoRiu7cLORYipX8AszjmufG2m2L1YYuwoHOs/sNm6z0zEsEqVCtdMK3KnNa4ORO/n7NhW5eaAziJv77SQiS3/holjD+EmaNohoIlS5/22c6yPpdUJyd1iMrQIhGU8ZtOv2BaSAQ6KkofAWZb4ZPunJ1z7Ce0VsxIjlYLNfkcyYivS6Wck8uByIXE232YcK4a+Qurl8972CUvg4Y+ESzEwepzFInrtd01bs2LKL67EkIX/cVGL+7xZq+4DOiZI/f/oy6ia26NCPyxEuZcHrALoKFgFFef623LdgWoS7xpvwubL4Zo/D2e2Q5JPDkA21p6EjbOYd9nmKRYFKE5t8F0hqTQPdRJ5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(366004)(376002)(346002)(39860400002)(2616005)(966005)(66946007)(64756008)(38070700005)(26005)(186003)(66476007)(91956017)(6916009)(76116006)(86362001)(41300700001)(66556008)(4326008)(6512007)(6486002)(71200400001)(53546011)(2906002)(8676002)(66446008)(6506007)(478600001)(8936002)(54906003)(5660300002)(33656002)(122000001)(36756003)(38100700002)(83380400001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SHBsXi5mKGmdLLTtihNUb+P/1nT93gcKTRABjcxlWfMWFYYxj63u2ms6w1/H?=
 =?us-ascii?Q?eiW/GkNADaFK9N3LSlY9MjGlriVQA6ZNDqpPqW8d2Wu1vYtt81IFAU3VI6ot?=
 =?us-ascii?Q?Ru5nK9wDAL19iADad8GF0KPImSqJUBu9K+iJE2piCNsD6UrgAvksnT1gpDUD?=
 =?us-ascii?Q?jq8UycOqnE1qTlt2gOVpNVHCWQtuDCDuOj4xVkS6IZx/PMmiWL7YpsvuNDdH?=
 =?us-ascii?Q?hTfFIfMkkCR3XexiFsMA7ciT+4+z6RyJwshrZulWRToSum6maOHKHcknhaF4?=
 =?us-ascii?Q?syLSUAn5kePb6+M8u1I1ClDKHO1ei16uvXzBuP74AFniq61eyFB30HuBIfom?=
 =?us-ascii?Q?pS7CbzWn+ghMauuvLU5s+WdAivOrlkIh7lNh1yhxwQah4yQIEcWsvfkDD1in?=
 =?us-ascii?Q?0V7osuMR7g0dtLx4LJwlizz8miVSIUIwMdt+A4t3ajEbnL6EHUcJC9MWuSAw?=
 =?us-ascii?Q?2mSKXnmQgJH9JyyzVMeInVuukf9liXR6fCRLuOQI8AEFkCM6GpFMHGusMe9h?=
 =?us-ascii?Q?wg8Ye78D9nm/lbm3Uc8qeXfM/o43YhjKcfOxwsSkwhKfxvlamLD9rgXxnQyn?=
 =?us-ascii?Q?9g5ul0wimfI1YnJnTiKUpjfLA3u83Kf0/RNIQiGahVxn1LFrOOPUB2cIZXcj?=
 =?us-ascii?Q?cAMOHf6zX09I7cTF9CiLuS4DyIYLT7QX93c90zgrnB/jeJuSE9SgP6bMsl3I?=
 =?us-ascii?Q?wCHq9zI1FfSrcxD/a0hgmw/cxtPgCFkblCLlZmnAY9fKMW0r+3n6Eobjil1t?=
 =?us-ascii?Q?N92i/RA/EVoXuh9XVr/TxksykEZjUO5ueWZH3kjQ08x/TUcNtm78ugMBpjZc?=
 =?us-ascii?Q?/aPSAt1PUgDxgmOMwcNYQJZJ6aj1Kc9u/x37pZGmrSzdELF6I4LLLyZH394h?=
 =?us-ascii?Q?5WrXnNiRxd/qT5VaZfKxrPmD6xxv8QtZndKcsBYNu+B4Pjq02k5uH2BsgUbV?=
 =?us-ascii?Q?S3RjPgOTlbebvJeQy0Xd32htHmkOSa8KOwSxRC8V4Y85flkUcNgaDRrjrqEB?=
 =?us-ascii?Q?AejttPwFFwXWrBih5z20oTcgNLg9raK7JWC198ExGu71Geut2W0tSvEeZzyQ?=
 =?us-ascii?Q?RbGL09yyBFHGlNyvtrkkmeShj1Jv2GwG5JNIKcBhsxHmgv/yvaCyD4BnctS/?=
 =?us-ascii?Q?h4pbMYvZUFTbGixLgaBLOEl9HrjTogAcYPPu1Pa9RAJ6urKYNKszixxVF0eW?=
 =?us-ascii?Q?XsTJb8KwGx7UlJuDJTLtJKJS+A1SDRZLC/YA18EwQ/Guh9VwTWvNHcPiGJXt?=
 =?us-ascii?Q?UmVYklu0VZ8odSsyyvqLDFCn7K47kfTaPHDsswGXtM0hPQHJruwzQB/4DXe1?=
 =?us-ascii?Q?XnyMEL6LAuAu3q9C9H8CbnmUPZOlid3RMQCgP3JF3DEkLIUfwQ86ADjUvhWH?=
 =?us-ascii?Q?tbT6BuZLM+l7iKpXyk9qYTChJt7Oqpr7BpYptmzix8VHlrVRQpfHiZ4zx+++?=
 =?us-ascii?Q?IcA9+Ue0y8MvJZCY2joa7k9VKUzcJAzQvxTwD0YzKnijl2PBpSPoIANSBBA/?=
 =?us-ascii?Q?dFu3QtgY+CvbIbVfhXQCuzvgefkAaQeP02SEip48ROusikaTl36gvxu7iEVi?=
 =?us-ascii?Q?YSOv5XDDLasNegtLrj5AAngeiMx/9furyxJG2ndw28wc/Yt4XB4fjkOI36qq?=
 =?us-ascii?Q?4Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C3A11C506CAAB4CA3B6B3C2E82EBD02@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afdce27-949f-4f14-52d5-08da718bc5d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 17:57:15.9937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lKJuwTMPDoDvWh6Np7OyaQAcIsbMPw9UzHlFQAczPS3b36iwtP/2BND9gKq/q1rW+8kcRAmeWcINe5ahlZa/Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3723
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_18,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207290075
X-Proofpoint-ORIG-GUID: ifTQs6gKgN_t9yzaQ4l_zLyfEIIM_2mW
X-Proofpoint-GUID: ifTQs6gKgN_t9yzaQ4l_zLyfEIIM_2mW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 29, 2022, at 1:55 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2022-07-29 at 17:46 +0000, Chuck Lever III wrote:
>>=20
>>> On Jul 29, 2022, at 1:34 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> On Fri, 2022-07-29 at 17:21 +0000, Chuck Lever III wrote:
>>>>=20
>>>>> On Jul 29, 2022, at 12:47 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>=20
>>>>> We had a report from the spring Bake-a-thon of data corruption in som=
e
>>>>> nfstest_interop tests. Looking at the traces showed the NFS server
>>>>> allowing a v3 WRITE to proceed while a read delegation was still
>>>>> outstanding.
>>>>>=20
>>>>> Currently, we only set NFSD_FILE_BREAK_* flags if
>>>>> NFSD_MAY_NOT_BREAK_LEASE was set when we call nfsd_file_alloc.
>>>>> NFSD_MAY_NOT_BREAK_LEASE was intended to be set when finding files fo=
r
>>>>> COMMIT ops, where we need a writeable filehandle but don't need to
>>>>> break read leases.
>>>>>=20
>>>>> It doesn't make any sense to consult that flag when allocating a file
>>>>> since the file may be used on subsequent calls where we do want to br=
eak
>>>>> the lease (and the usage of it here seems to be reverse from what it
>>>>> should be anyway).
>>>>>=20
>>>>> Also, after calling nfsd_open_break_lease, we don't want to clear the
>>>>> BREAK_* bits. A lease could end up being set on it later (more than
>>>>> once) and we need to be able to break those leases as well.
>>>>>=20
>>>>> This means that the NFSD_FILE_BREAK_* flags now just mirror
>>>>> NFSD_MAY_{READ,WRITE} flags, so there's no need for them at all. Just
>>>>> drop those flags and unconditionally call nfsd_open_break_lease every
>>>>> time.
>>>>>=20
>>>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2107360
>>>>> Fixes: 65294c1f2c5e (nfsd: add a new struct file caching facility to =
nfsd)
>>>>> Reported-by: Olga Kornieskaia <kolga@netapp.com>
>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>=20
>>>> I'm going to go out on a limb and predict this will conflict
>>>> heavily with the filecache overhaul patches I have queued for
>>>> next. :-)
>>>>=20
>>>> Do you believe this is something that urgently needs to be
>>>> backported to stable kernels, or can it be rebased on top of
>>>> the filecache overhaul work?
>>>>=20
>>>>=20
>>>=20
>>> I based this on top of your for-next branch and I think the filecache i=
s
>>> already in there.
>>>=20
>>> It's a pretty nasty bug that we probably will want backported, so it
>>> might make sense to respin this on top of mainline and put it in ahead
>>> of the filecache overhaul.
>>=20
>> I am a generally a proponent of enabling fix backports.
>>=20
>> I encourage you to test the respin on 5.19 and 5.18 at least
>> because the moment that patch hits upstream, Sasha and Greg
>> will pull it into stable. I don't relish the idea of having
>> to fix the fix, if you catch my drift.
>>=20
>> And perhaps when you repost, the fix should be reordered
>> before the patches that add the tracepoints.
>>=20
>=20
> That all sounds good. I'll do that in a bit, and will send a v2.
>=20
>>=20
>>> Thoughts?
>>=20
>> Rebasing all that is mechanically straightforward to do.
>>=20
>> The only issue is that the filecache work and the first PR
>> tag is already in my for-next branch. If you don't think it
>> will trigger massive heartburn for Linus and Stephen, I can
>> pull that stuff out now, and postpone my first PR until the
>> second week of the merge window.
>>=20
>=20
> That may be best. I think we want to see this fix go in almost
> everywhere.

I will push the removal update to my public tree now. You can
send your v2 over the weekend or on Monday.


>>>>> ---
>>>>> fs/nfsd/filecache.c | 26 +++-----------------------
>>>>> fs/nfsd/filecache.h |  4 +---
>>>>> fs/nfsd/trace.h     |  2 --
>>>>> 3 files changed, 4 insertions(+), 28 deletions(-)
>>>>>=20
>>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>>>> index 4758c2a3fcf8..7e566ddca388 100644
>>>>> --- a/fs/nfsd/filecache.c
>>>>> +++ b/fs/nfsd/filecache.c
>>>>> @@ -283,7 +283,7 @@ nfsd_file_mark_find_or_create(struct nfsd_file *n=
f, struct inode *inode)
>>>>> }
>>>>>=20
>>>>> static struct nfsd_file *
>>>>> -nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
>>>>> +nfsd_file_alloc(struct nfsd_file_lookup_key *key)
>>>>> {
>>>>> 	struct nfsd_file *nf;
>>>>>=20
>>>>> @@ -301,12 +301,6 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key=
, unsigned int may)
>>>>> 		/* nf_ref is pre-incremented for hash table */
>>>>> 		refcount_set(&nf->nf_ref, 2);
>>>>> 		nf->nf_may =3D key->need;
>>>>> -		if (may & NFSD_MAY_NOT_BREAK_LEASE) {
>>>>> -			if (may & NFSD_MAY_WRITE)
>>>>> -				__set_bit(NFSD_FILE_BREAK_WRITE, &nf->nf_flags);
>>>>> -			if (may & NFSD_MAY_READ)
>>>>> -				__set_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags);
>>>>> -		}
>>>>> 		nf->nf_mark =3D NULL;
>>>>> 	}
>>>>> 	return nf;
>>>>> @@ -1090,7 +1084,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
>>>>> 	if (nf)
>>>>> 		goto wait_for_construction;
>>>>>=20
>>>>> -	new =3D nfsd_file_alloc(&key, may_flags);
>>>>> +	new =3D nfsd_file_alloc(&key);
>>>>> 	if (!new) {
>>>>> 		status =3D nfserr_jukebox;
>>>>> 		goto out_status;
>>>>> @@ -1130,21 +1124,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, s=
truct svc_fh *fhp,
>>>>> 	nfsd_file_lru_remove(nf);
>>>>> 	this_cpu_inc(nfsd_file_cache_hits);
>>>>>=20
>>>>> -	if (!(may_flags & NFSD_MAY_NOT_BREAK_LEASE)) {
>>>>> -		bool write =3D (may_flags & NFSD_MAY_WRITE);
>>>>> -
>>>>> -		if (test_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags) ||
>>>>> -		    (test_bit(NFSD_FILE_BREAK_WRITE, &nf->nf_flags) && write)) {
>>>>> -			status =3D nfserrno(nfsd_open_break_lease(
>>>>> -					file_inode(nf->nf_file), may_flags));
>>>>> -			if (status =3D=3D nfs_ok) {
>>>>> -				clear_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags);
>>>>> -				if (write)
>>>>> -					clear_bit(NFSD_FILE_BREAK_WRITE,
>>>>> -						  &nf->nf_flags);
>>>>> -			}
>>>>> -		}
>>>>> -	}
>>>>> +	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), =
may_flags));
>>>>> out:
>>>>> 	if (status =3D=3D nfs_ok) {
>>>>> 		if (open)
>>>>> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
>>>>> index d534b76cb65b..8e8c0c47d67d 100644
>>>>> --- a/fs/nfsd/filecache.h
>>>>> +++ b/fs/nfsd/filecache.h
>>>>> @@ -37,9 +37,7 @@ struct nfsd_file {
>>>>> 	struct net		*nf_net;
>>>>> #define NFSD_FILE_HASHED	(0)
>>>>> #define NFSD_FILE_PENDING	(1)
>>>>> -#define NFSD_FILE_BREAK_READ	(2)
>>>>> -#define NFSD_FILE_BREAK_WRITE	(3)
>>>>> -#define NFSD_FILE_REFERENCED	(4)
>>>>> +#define NFSD_FILE_REFERENCED	(2)
>>>>> 	unsigned long		nf_flags;
>>>>> 	struct inode		*nf_inode;	/* don't deref */
>>>>> 	refcount_t		nf_ref;
>>>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>>>>> index e9c5d0f56977..2bd867a96eba 100644
>>>>> --- a/fs/nfsd/trace.h
>>>>> +++ b/fs/nfsd/trace.h
>>>>> @@ -758,8 +758,6 @@ DEFINE_CLID_EVENT(confirmed_r);
>>>>> 	__print_flags(val, "|",						\
>>>>> 		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
>>>>> 		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
>>>>> -		{ 1 << NFSD_FILE_BREAK_READ,	"BREAK_READ" },		\
>>>>> -		{ 1 << NFSD_FILE_BREAK_WRITE,	"BREAK_WRITE" },	\
>>>>> 		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"})
>>>>>=20
>>>>> DECLARE_EVENT_CLASS(nfsd_file_class,
>>>>> --=20
>>>>> 2.37.1
>>>>>=20
>>>>=20
>>>> --
>>>> Chuck Lever
>>>>=20
>>>>=20
>>>>=20
>>>=20
>>> --=20
>>> Jeff Layton <jlayton@kernel.org>
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



