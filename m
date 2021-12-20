Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACEC47B4C1
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Dec 2021 22:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhLTVJQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Dec 2021 16:09:16 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26078 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230171AbhLTVJP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Dec 2021 16:09:15 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BKJxTgA014421;
        Mon, 20 Dec 2021 20:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bH1mw+kewiw5Xfdykbfq2DTB/S0nYGtA0OcrBd7S60U=;
 b=DRQ+E7r3boi7q4rBUtLc6kpAVyx4nlX6jCpfuPPZpc6Nb2eHOdgr7BHISgwyyAZbYTPh
 2fkUMTe3gAD4dvEVRMJLmCFFqDCGgq6abh9ImvHI+qwzalRMhiLqhT5uyncxOKWNiCpv
 6A2cJOa68/qpV2vjaBjChRloqk7Y06/opgNf1+g4kkeBxGU8JF0+Sh6YqXczgLDaxUav
 ern05GleswOzLPtNugqALcQqkJowb4M3qjJ3lHY/Nb1prH4S5wvZTz2EDBJmqeebCE/R
 EIRkAtFsuHQ1ktYNEpgosu5sg+zmLNAPlD9Dex5MShp9bFF5hmDPdisSljmEyNS+rLb5 jQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d2qk29hah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Dec 2021 20:12:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BKKAnR1172615;
        Mon, 20 Dec 2021 20:12:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3020.oracle.com with ESMTP id 3d17f31x1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Dec 2021 20:12:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=au6nNSdA2Xq5YcCyNG7fYdibc8AZWp3qMbKhXNTcZkhzykadZcAbuNet9b7e89zyFElWqv+A5URsmdPAb5kFgDsN0dvCtw2QxDeVFen+MnDJhz03NuY07FnlBF9VBJGnz7Y3UlAdJNRcw+anSWq1KJOT9RrBymbLaqVb+X5d79/L3IlRYeAQE8Eusf843e9MRXrv6/0y5A7gabhI3cRx/sU1cmKxYLbWcoKqpnAI0OtUuKWPv2MkM17pBGMndTzb7CgpGMbxaqNsQbX8vxMs3a0HA1ms1Ve/RDI2WqmMUpqw7aP/WeYiYorlWD9/4lJz6TVOOpP64KMh7OQvwiZ+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bH1mw+kewiw5Xfdykbfq2DTB/S0nYGtA0OcrBd7S60U=;
 b=EywIIZxt+nqQ4UnHSrMrMrfm96CY4DCeotY2Kr4y/mlsiufG1MyJtuo4cpzhB4queSAvbyO28qIBVv51rxFdZNyyc9QwOduTos/eTgCaQunnFmD+zQvhgfaDUx/kj4no9+m+c0enHIy51992uY7XDeNJIMOmjKzl7IQlp9St+Att7ZYNBEYhPEI+SvI7HkvicYQ0yEL9H5FpjTrxaKgxO4aB30FfQMwTpx5NbdwZVNe02WP5eRmau+uHlLS7A2U5cbRlUKMUn12dStMatG1d11E9CYzJmNSVcB9lAcKqOV8eQSX2JP/JioTe8xhSEqe9SLlRJbRCDbuYLobFeEUXPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bH1mw+kewiw5Xfdykbfq2DTB/S0nYGtA0OcrBd7S60U=;
 b=Sbuhp2Sd3hXrGgrYwmJBD3OLaYbKUK1y1berZC6O1xLYgZ7M+AdMhM7uf1ULl12PazhvjCCFl5L44O02Oqgo1LZlMyA/ADgCJnN77TrsEADS32BWh8KnFoG0+G6/htfFb3RyPlftrYDy1iaawhgUz93MY7hmAh/EzA+ohlqJwik=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB3877.namprd10.prod.outlook.com (2603:10b6:610:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Mon, 20 Dec
 2021 20:12:04 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 20:12:04 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Subject: Re: [PATCH v2 10/10] nfsd: Ignore rpcbind errors on nfsd startup
Thread-Topic: [PATCH v2 10/10] nfsd: Ignore rpcbind errors on nfsd startup
Thread-Index: AQHX9HoJf0UrhpbILEawWnDLCGoAp6w6H74AgAArPACAAT7dAIAALdSAgAAHjwCAAA4jAIAABWOA
Date:   Mon, 20 Dec 2021 20:12:04 +0000
Message-ID: <68CC5554-757A-49D4-A6D9-AB282E482B7E@oracle.com>
References: <20211219013803.324724-1-trondmy@kernel.org>
 <20211219013803.324724-2-trondmy@kernel.org>
 <20211219013803.324724-3-trondmy@kernel.org>
 <20211219013803.324724-4-trondmy@kernel.org>
 <20211219013803.324724-5-trondmy@kernel.org>
 <20211219013803.324724-6-trondmy@kernel.org>
 <20211219013803.324724-7-trondmy@kernel.org>
 <20211219013803.324724-8-trondmy@kernel.org>
 <20211219013803.324724-9-trondmy@kernel.org>
 <20211219013803.324724-10-trondmy@kernel.org>
 <20211219013803.324724-11-trondmy@kernel.org>
 <831659F6-3005-459B-92ED-933BBCEE6FE9@oracle.com>
 <3167a9a815ac9c82700bd58d8c421de31eee8b91.camel@hammerspace.com>
 <316378A4-BCB1-4C8F-A16D-43F8F9DA8FBC@oracle.com>
 <9679c6f76f751c6c379bcfb889fd1dcba1671eac.camel@hammerspace.com>
 <753AE969-5C7E-4BA7-8CA4-003671710DAC@oracle.com>
 <e61524640024e31f41126e106c599428ed00a49c.camel@hammerspace.com>
In-Reply-To: <e61524640024e31f41126e106c599428ed00a49c.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be664861-2aee-4313-160d-08d9c3f4fd82
x-ms-traffictypediagnostic: CH2PR10MB3877:EE_
x-microsoft-antispam-prvs: <CH2PR10MB3877F0AFF8E0C16BAC51120F937B9@CH2PR10MB3877.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4YEcAzfDWsFVTCTvQSUTtKGnMrbywILLG2xhVJwl+kfyVCEtts4FpdfQ9hwyjoXdxPje9SUQUfxCkUdMGLahJZNeoLLzDdl3dqdoBDmIuFkekQCoUjeC/SGXP2gtaX9mezpI953seC4lBh8vqly9EVM0AxESaYxzQTnd5BZ4JVlJEQVBpTaKEa9z36R5iQdmWCOTZQ6dGbhCHkIbv+mT0isnzKV90mHDBqtX5DT2/kLjGBFvNTar3XK2lKpKkt0ShT1+ba2xamazahJUQvqvj1BXavtTD1pGY3icIMQlfKfKgih8SPF1hESbZR9XaQObegdUU4UZR3/Qt5/sRjy7FfOZCux20q/x9ukQcyXUf6jkEeMAVPJ6j8d3ygA9y4d5UFxVLAE9FQu604Ip4ENXSmUZW28SxHYM/giHjBBvY2N0Y0jWJDsckEWf53uuYbvMTVuEZapnQvCRl7iTqdeHlmO3ZttDt9wF6DKhOiEK71so/7IZo2uTrRpRYUJoavMLXbHGSLzGfuqdCVkAbi1qtgOioDzTM9xe/qlSQ39nYVySJpwrsDnG9GFSLzmN3HMdp+apN78+/O61toSXot9lsVWf0eaN3Z6LHXBs5VrOurZ/aBMrBcAojZ3PxPMMOHXa2aWRaNTzwfmn/ie2B2MYSrF21jW6uw0vigtIOfSQc9ufAqNeHlaXS1WkbZ4y/gBJHJgX0DalVwWYjQUF7BqEHpcbovCaZaaPFnn0mbPq0udcDlEc6LaYrE5JDYhUsIuA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(2906002)(38070700005)(26005)(66476007)(6506007)(186003)(6512007)(6916009)(66946007)(76116006)(2616005)(83380400001)(316002)(66446008)(64756008)(66556008)(71200400001)(33656002)(508600001)(36756003)(4326008)(38100700002)(6486002)(8676002)(54906003)(5660300002)(8936002)(122000001)(4001150100001)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Af8mZ5JKBjNYtHk1SHOlMXDMEAsXKwT8ryucyjyhYjhvG3HU37qMG4r5cgJZ?=
 =?us-ascii?Q?du0p6GaW2IXZZGv+hInBJUfNvxnZaE9AtidEiHEnczyd1rUVXfiliSaV0M6y?=
 =?us-ascii?Q?cMbNBdKYTM/ooWb4RGFvL+Rh/azB9qpu62JBziA616LFAdWrtQXCJsg8l3Jh?=
 =?us-ascii?Q?ZFQRn+QZPFCBLJEIDlQaA527rm7i2llZDhEaDWZThsPBRJvwQ7L5aAjH6nL6?=
 =?us-ascii?Q?Bte87UkUM4rO9w3EC67xdd53Gt1dCwI38VEA+SBonAVyYY2GtrWVk4qzDDLo?=
 =?us-ascii?Q?mM2B3bCehwd0X/9PPKSpmPHzNWUGpSWeNby9SL6H6QqoFdZ5K0IZmz5bOf2T?=
 =?us-ascii?Q?vSfh4Xuz8U07kOieRDtjLcQikqIc/E7OADRjrELGmJ53p0O52Z+08Hr2Kbc9?=
 =?us-ascii?Q?Hu/FXSbkwpn/lA7bIu1kTuf0R/G6p/765reUxok5X4OrwwIkMCKayd3PaHck?=
 =?us-ascii?Q?uHCj7ZLHNxRfCniuSOSTHxFQKFqFVxs1DlLrKgT+kxjX5BnhqRV/wh7qxe9u?=
 =?us-ascii?Q?hvYJQxd+W4itMchKfStcBvhSIr9EX4zDqM6oHyOXPu4uWUJ3V1drD6NYqfyu?=
 =?us-ascii?Q?yqAAxqEiG3y2wsd+6gVanTIK4T0AmBlQxmsGTPZRT860P0aHfA2cTsJVb6q5?=
 =?us-ascii?Q?RlbH2BjP2dTuByTR6RWPj4nKy9zwm3Enc7k+fg/3MBvEBxl4vHy97Q8DkHMu?=
 =?us-ascii?Q?3KTa5Sk7AhIPRJU5CCxDyO7eV9cuFAv6CxgclRmyZMEpNYIDjEgfvhBn88ye?=
 =?us-ascii?Q?u5SYc7EpIP6UckYxWKScoxwipduow0T7/rHDW+oJssmmstDHvems4w294Y6T?=
 =?us-ascii?Q?2k+0Na8sCFGs/pBc3zAhE0i9VDvfufCNGlnSCu7dQVNva0wobV8V5EB+/h7N?=
 =?us-ascii?Q?gsLYVaIaTOgMPMW9Jh688YBppUvhzQL9CJl1Bl1fw4w+Dpa3UY8I2/4qDwYP?=
 =?us-ascii?Q?n44SorjxVIyacWr8J8omP6QB9Elwkr6iChQodt64xM8TuXkPsn5t1eKMqaa8?=
 =?us-ascii?Q?VHaGw2UbxigrJJlDNpoDycSS2WCSLcN4zFGjvQc792wXUbj/klmYiEDz7kzb?=
 =?us-ascii?Q?NRzOp7NTOCbljYCt4N80wMRyPXm70oDLJHyaASKcWV0Rg8pLGCFnlWNI8Re5?=
 =?us-ascii?Q?7jWAFeEp8Zezfl81CTX0tYQB+ots+JTwWQdwcS1ILaVQ3+DyS/uEJN41vBm5?=
 =?us-ascii?Q?tTNnzOec2oZhrbw1b7rESoZcdBhSttp6qXmiAs28MVfNO53ZkPPdOKGkGEGa?=
 =?us-ascii?Q?HdZqcrGkkRGS9D4rqmQxPuyRLl9rem2b9OIn2I2c8JemS2nWjzFSbZIBjsUb?=
 =?us-ascii?Q?ChYgbQCerbRPTvmJYLGI7QWrBGHwJ+qf47oM6Usk4/tPKy685jXW4OTbZAhN?=
 =?us-ascii?Q?SQt9cVUln4r35bdlW1no7c9bzMSVOFQU4jrtdVkOlG0M3ESg4sDEv7V4iRHE?=
 =?us-ascii?Q?VBxTrysPQZ4LWT+tcY3/a/URf5kWA5U31YLAec4ZB5uOFDU66YkkQJ+xazdk?=
 =?us-ascii?Q?zP/Icf0rvzXNnbk4G1WnpmdtmA92MjBhHI0fjTT1TNDH25cqC2rteS2DCIzB?=
 =?us-ascii?Q?mvUoEkt/gyKXn4IbrJhMNLQsanhMusLpJasckDBVJfaE7u8zDhupu+xuLGTC?=
 =?us-ascii?Q?/xWlo1MwBjmvthlvqymYzzM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F99993B887F82341AECF0CA6C9557D18@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be664861-2aee-4313-160d-08d9c3f4fd82
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 20:12:04.0983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xS8SEVv1+2bwHKaTBj4ULN2zJzn+So2SSdaRGf5OI/HpqhWZQQWMJI2MYwEqar0rjISCayOqQyaOCsfNEbrnWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3877
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10204 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112200113
X-Proofpoint-GUID: AvvUie0ujr0CDc8JE6byPEBIXPSPl_ir
X-Proofpoint-ORIG-GUID: AvvUie0ujr0CDc8JE6byPEBIXPSPl_ir
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 20, 2021, at 2:52 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2021-12-20 at 19:02 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Dec 20, 2021, at 1:35 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Mon, 2021-12-20 at 15:51 +0000, Chuck Lever III wrote:
>>>>=20
>>>>=20
>>>>> On Dec 19, 2021, at 3:49 PM, Trond Myklebust
>>>>> <trondmy@hammerspace.com> wrote:
>>>>>=20
>>>>> On Sun, 2021-12-19 at 18:15 +0000, Chuck Lever III wrote:
>>>>>>=20
>>>>>>> On Dec 18, 2021, at 8:38 PM, trondmy@kernel.org wrote:
>>>>>>>=20
>>>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>>>=20
>>>>>>> NFSv4 doesn't need rpcbind, so let's not refuse to start up
>>>>>>> just
>>>>>>> because
>>>>>>> the rpcbind registration failed.
>>>>>>=20
>>>>>> Commit 7e55b59b2f32 ("SUNRPC/NFSD: Support a new option for
>>>>>> ignoring
>>>>>> the result of svc_register") added vs_rpcb_optnl, which is
>>>>>> already
>>>>>> set for nfsd4_version4. Is that not adequate?
>>>>>>=20
>>>>>=20
>>>>> The other issue is that under certain circumstances, you may
>>>>> also
>>>>> want
>>>>> to run NFSv3 without rpcbind support. For instance, when you
>>>>> have a
>>>>> knfsd server instance running as a data server, there is
>>>>> typically
>>>>> no
>>>>> need to run rpcbind.
>>>>=20
>>>> So what you are saying is that you'd like this to be a run-time
>>>> setting
>>>> instead of a compile-time setting. Got it.
>>>>=20
>>>> Note that this patch adds a non-container-aware administrative
>>>> API.
>>>> For
>>>> the same reasons I NAK'd 9/10, I'm going to NAK this one and ask
>>>> that
>>>> you provide a version that is container-aware (ideally: not a
>>>> module
>>>> parameter).
>>>>=20
>>>> The new implementation should remove vs_rpcb_optnl, as a clean
>>>> up.
>>>>=20
>>>>=20
>>>=20
>>> This is not something that turns off the registration with rpcbind.
>>> It
>>> is something that turns off the decision to abort knfsd if that
>>> registration fails.
>>=20
>> See below, that's just what vs_rpcb_optnl does. It it's true,
>> then the result of the rpcbind registration for that service
>> is ignored.
>>=20
>> 1039 int svc_generic_rpcbind_set(struct net *net,
>> 1040                             const struct svc_program *progp,
>> 1041                             u32 version, int family,
>> 1042                             unsigned short proto,
>> 1043                             unsigned short port)
>> 1044 {
>> 1045         const struct svc_version *vers =3D progp-
>>> pg_vers[version];
>> 1046         int error;
>> 1047=20
>> 1048         if (vers =3D=3D NULL)
>> 1049                 return 0;
>> 1050=20
>> 1051         if (vers->vs_hidden) {
>> 1052                 trace_svc_noregister(progp->pg_name, version,
>> proto,
>> 1053                                      port, family, 0);
>> 1054                 return 0;
>> 1055         }
>> 1056=20
>> 1057         /*
>> 1058          * Don't register a UDP port if we need congestion
>> 1059          * control.
>> 1060          */
>> 1061         if (vers->vs_need_cong_ctrl && proto =3D=3D IPPROTO_UDP)
>> 1062                 return 0;
>> 1063=20
>> 1064         error =3D svc_rpcbind_set_version(net, progp, version,
>> 1065                                         family, proto, port);
>> 1066=20
>> 1067         return (vers->vs_rpcb_optnl) ? 0 : error;
>> 1068 }
>> 1069 EXPORT_SYMBOL_GPL(svc_generic_rpcbind_set);
>>=20
>> And, it's already the case that vs_rpcb_optnl is true for our
>> NFSv4 server. So the issue is for NFSv3 only. It still looks
>> to me like the patch description for this patch, at the very
>> least, is not correct.
>>=20
>>=20
>>> That's not something that needs to be
>>> containerised: it's just common sense and really wants to be the
>>> default behaviour everywhere.
>>=20
>> I'm not following this. I can imagine deployment cases where one
>> container might want to ensure rpcbind is running for NFSv3 while
>> another does not care. What am I missing?
>>=20
>=20
> Monitoring that rpcbind is working is not a kernel task. It's something
> that can and should be done in userspace. The kernel task should only
> be to try to register the ports that it is using to that rpcbind server
> if it is up and running.
>=20
> In a containerised environment, then even the job of registering the
> ports is not necessarily desirable behaviour, since there will almost
> always be some additional form of NAT or address + port mapping going
> on that knfsd has no visibility into.

Today, the kernel fails nfsd start-up if it can't complete rpcbind
registration. If we want to change that, then the typical process for
this has been that the user space components to support it need to be
in place before we think of changing kernel behavior. Are they?

And, if knfsd is really not the place for checking the registration,
then the right answer is to remove the in-kernel check for everyone,
but only after a proper user space mechanism is in place.

I really don't want to have to carry a module parameter for this
transition in perpetuity. A better choice for managing the transition
would be a CONFIG option, which is relatively harmless to remove once
it is no longer needed.

I don't object to eventually removing the kernel registration check,
but I want to see the transition away from the current arrangement
done properly, please. At the very least we deserve to have some
dialog about the long-term direction.


--
Chuck Lever



