Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA603486A91
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jan 2022 20:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243380AbiAFTjF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jan 2022 14:39:05 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:14664 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243378AbiAFTjF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Jan 2022 14:39:05 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206HTEhs029123;
        Thu, 6 Jan 2022 19:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=u8CQAVLVUn0KjCd+YmCKbleSWAKnyhzJUkw50u0ajKg=;
 b=JoIsyP7e6OyRkhUME68dG0BZS7iXKjKD6Qlv1H/eU6wH0NDBLy9tXNjTuS1JeN1z8Qk4
 DCgahKb6oo5N+u25S2lNd46KfvMr2SKzWjukgTB1WKo5J+O4so+HUVKx4n5+Yld9s+SW
 CXoIcIa3VHFpLvEUuw6QQ+YhqncyfHlGSAmqm/XTLjO5PWUbHHNu7ELCyKxZieOiQt8E
 uUbOVeJuvsK0P4n0VllLcp50OhSGRCRBfKJT/4RQyWWREsKi6eQcosxIIcjJHgRFRiVL
 vruyUg4PtPyopwM2O3RDjqogLogs7VoxM1Gn2q3VzxUczPLF+zD1GyalsAAmfWznxNQT ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4va0a83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 19:38:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206JZjXj084752;
        Thu, 6 Jan 2022 19:38:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3020.oracle.com with ESMTP id 3de4vv65g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 19:38:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLNPLUx5bYmIxWDIu0TI8OC5qAFi/4baIEQH6eAXJGwPpeYvHq1XDMjpFKJw9uvpTt55F1jZuiLEUFlx+Ec00EBJ7/Ygdg39XyFYwZfg7XrQDTG3qbexPfWfkQH7J10cWMhatZZunWhyLhuqneC7JtCYk91vFOcO9icTzKqSk5W0dFFV+vufEPwpAAefIgneSG6Qv+yVWO9S6IG32Gp1ry2cD+Mbx0t3pNfGNS2FXV+r9T7cRkVOFVkNp0iNRmeYai1Xdi1Friaf1lJ20IJI4ZRvFaV7pKPetHcbQnpTsQBYQgTL3J+z7RROgV8wu2p+WDm5n1tfEuT2bufDr970JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8CQAVLVUn0KjCd+YmCKbleSWAKnyhzJUkw50u0ajKg=;
 b=BB6o/cTW2ATZozBv1bJH3W3QEBeLhPH6IFqNlUKurj9TCAwbvu6cGiyr3qANqVdxc4+Ht4hbPKgKi3bfPYdYhd5ZD52p3UA+x6Z7HAm50fQ9fUHyxdf0cov1s0D9cTPhfatJijVDkH9LN5lYyoo8x/u2mfNBME++WHAvzczk/P0aYEIyWvmKD/+i/r2UyF1IyQw4w4Or8kUyHFQEedKPsOT0tD7TWhujuuDAiy/pJAg5dG40Pe0K1RX8mKrI9kqVUQawZ8tX3rJAjzl+EQ/u4FQY0pJzOXaUYEj2GRPKijRhLrYSTAeQZfqNThwYbUFH7TV4HtjOwCLvQxZWTLkxtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8CQAVLVUn0KjCd+YmCKbleSWAKnyhzJUkw50u0ajKg=;
 b=VzDkOfAZTGeKk5/bHOMSqkyUo13NPaR9FcnR5IDYGD5b8z1qlS5XPJ6P+pUDf3ZNltjaoSf45DQ/Gl4mvNMzb+QDQiZSmK/3KZEwPEbazGFtqM0bgoPvgRToMkxVgvhY969LyH8KJJ/1W8ryMss8HhWNFD9pUNLodiEraJ6flOM=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB4874.namprd10.prod.outlook.com (2603:10b6:610:c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 19:38:43 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%8]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 19:38:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Bruce Fields <bfields@fieldses.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        "rtm@csail.mit.edu" <rtm@csail.mit.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfsd v4 server can crash in COPY_NOTIFY
Thread-Topic: nfsd v4 server can crash in COPY_NOTIFY
Thread-Index: AQHYAkTSfcyQ73azGUqH3aX+rbcvl6xU3MuAgAAFmACAAYFegIAAAboA
Date:   Thu, 6 Jan 2022 19:38:42 +0000
Message-ID: <72AF9C4D-BD02-48E9-B1A2-34FA51282D43@oracle.com>
References: <7318.1641394756@crash.local>
 <20220105201313.GE25384@fieldses.org>
 <88B4B5A4-74B1-4D6C-8210-BE6C754EE5FF@oracle.com>
 <CAN-5tyGAu-LfcaB0V1QvNS533PmqEP7Zqgxd=oQEaxFGmCn+_A@mail.gmail.com>
In-Reply-To: <CAN-5tyGAu-LfcaB0V1QvNS533PmqEP7Zqgxd=oQEaxFGmCn+_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8e5c445-6bf8-4aab-8f2d-08d9d14c25b1
x-ms-traffictypediagnostic: CH0PR10MB4874:EE_
x-microsoft-antispam-prvs: <CH0PR10MB4874E3927FE15BEF351D2FB6934C9@CH0PR10MB4874.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DWfGk2v3IKYhg2MZgEwkBswKSexVnYD+CjHw+iJgewOesfS7vNm//eAY40VTeBkOMBJdodAcAwI79waeaI7tV7LgHNkO0jL4dOmfsv/9gVl1Vx+f9uT//UwCSWVjynrzv5nqLC+++aKXcnsHD9Sh9aark/xGO/7gHqtOa5Wv7bgt5ZqmUK/34Qo355w/zuwyd65Lq4Ulg0kOYLULAEGqUiKjICj3ecjaQFovWEHOKaX+PHvZN5bUvsclRv8/K1IP0iyft1ZzLNQuRJOiqDixTOqoI4A7M/Ds7IEcOiGPc3RXJwFAAclTgB4z7PtBnT+ZywsbPOJF1Mx1LMm8rb4JtlCkjy54KZSRdqt96134TKjdPp+UOcFHGY/Ubv3dZKkxgBCKQjo4J1CpKUCJW0AoZ8OdxCqKxdn2Joo8GiGYPbawNWj0XpmuiNwsE/uFSgrwYSF2UEtk+nCNtf4U3ArQaQBFqK0VSTu3Xbn2sUK+N2OlQYtAPeu7pNyBWe+WrH0GYuW3BlFiawLasGHmQsF6UPo72+hLvD4/OSZ9BW/CLt6E4HvQMV/GLgs/yQnoHs9FGufobVMI5HzU3tak4ts9gv/7po3gCzpIJM0h3orBj718+VkhYkC7T774lNlTvzHksEcd3PrwKnA3U3nSyLFBcBtftTvq47o9n9TI13mJdz5vHgmrmIBDZO/h8Xf9NyVQYJM0JxpuP6Hp5Y/3K3NvqoQcBZWxUvdD+wNlVmJO03XWxOO5weVhk/YqKvia/7wb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(66446008)(316002)(76116006)(54906003)(2616005)(64756008)(36756003)(66946007)(33656002)(66476007)(38100700002)(86362001)(66556008)(508600001)(53546011)(122000001)(71200400001)(6916009)(26005)(8936002)(6486002)(83380400001)(5660300002)(2906002)(6512007)(38070700005)(4326008)(8676002)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R3SbyjIR9LELNBiXkdvAqk4QOyAqsz6WjdSKEy0dVZVG2nDNktVZxb6cEgWc?=
 =?us-ascii?Q?N7hUJ2zmU/Id6O6yBmd+Bt8jp1+TSO7OvFTZ25ptRzwqpCEnxofZWF12MGWV?=
 =?us-ascii?Q?1Z1t1GCoueiqqJHTcm+Bf0ho21rlYyZr/53vlxhuA99BViT6JjxWPFUD4PO4?=
 =?us-ascii?Q?jIBGpni3grr0T9Z35D7e0kTu6r6lAd1Azz0j0y3U5jhy9KS6s2/18XUbX2aQ?=
 =?us-ascii?Q?WFpCr3AtVTrlHvk4RobCRkDTgran4PUcUXidNoLJ+SIh8eDg/ifyQFrMGJXY?=
 =?us-ascii?Q?31TENarvw2ljjgI7oObvaCcQNJHavsCVOweLlat7lWfSuZDAlX5o6IJj+pU3?=
 =?us-ascii?Q?kPQetLE6IvNUF3fxTtRjCQOyreff/M9bgyBDsdrgLvEFTvjT/9PavsiWlbgY?=
 =?us-ascii?Q?1iYyvIddY6sDZtl/dagEBOhPqDJ2Yy+fUmuzwGDGvmhX6Oi0XHOTwClBiJ8z?=
 =?us-ascii?Q?yFkEt+Kvn5dI6zLdh2jbhBQxkr9pLh3b1TtE8qm9C1emI107MR5IoPsyGley?=
 =?us-ascii?Q?907dET+zfWZVEp/J0cHOwmTQx9fMbtkWYh5+BF7u7f2yETJsRlKT90trpyAo?=
 =?us-ascii?Q?qqegz9DwN1qgdOpmyhgMIW/h1u2wnrUNMVogfhE5mZoJSLjnGqDswf9MrirR?=
 =?us-ascii?Q?G9fH1wq5o+2VCl7/XheIzrSbdjYnADcg2ogwGhfvNEg9S0TGLiffAxKZBp74?=
 =?us-ascii?Q?A5ijCKDJzzazIPn6Vui8oZSfrKSmgkbP55QpY2XTjfUQSuIDRM47L2HxQpns?=
 =?us-ascii?Q?jCJ0C7KIN86ffSyri+C3D2GLk+doNK5045R3jYtL8x3hvN8ugFAtBlEy16hr?=
 =?us-ascii?Q?x91Ma8VtJWusTZaScZGI4ZP+u20665o7MTjs8SlLlitDTOEakliEtPvcHx+J?=
 =?us-ascii?Q?kfE1uqHRqRHH/LwEG76cjPR3nfvnX6og8TOsVpI7WRYFbfKcYBK+7pQraBA2?=
 =?us-ascii?Q?4uBR6Qj8x1Q0fvlHucRmyU4r0kBiumliqwNx6DRxft04LMbnYUXn/RgWW4a+?=
 =?us-ascii?Q?qZdvmowBFfeFcThxVFWOn3jjwAFu8KUdhZIxtoHEXnwmU+Sw+chKycHY9Wjg?=
 =?us-ascii?Q?cPsp1Et8h5z6BX6aGoO9biCJu8ogvWuCGaZtwIE31euuwTUlmpdWYia8dzZ4?=
 =?us-ascii?Q?3AgQpQ9eYwvGQEQa7ejo6RYyxBTX0ozKLEkKjhWKlRbH5wEODdFbqdKNRQ1a?=
 =?us-ascii?Q?4tGWDcWvxrrOOeh2G/CMLSJlatZhM2RyYfE/ZNSI92vJJ4NoJXMjPVHNU9oa?=
 =?us-ascii?Q?xAAWzV61ELtHVGQcRY7q8otREhMQChIv15rmUv5AI0Mj8VvUETAQFWW84sF/?=
 =?us-ascii?Q?N0QSZRksIUSCndaIgzNVth3ZlErIh2z4mUi6ylY2ylmJ+t+peb4+/AvxDPhY?=
 =?us-ascii?Q?9a1mtGe4t3oi0altr30zugoNgR5mBt6UjlLSWmPBLuRtJrpRMUvHK0LdUH7E?=
 =?us-ascii?Q?UEtnUcufjVYsh2s7d0XPPGutnxy0Mi+ULax5wtEe0q8sRa9BvtQBMG/Qfpkw?=
 =?us-ascii?Q?gAIT7W0BmUaQiDczj3fbX6bRf3I6LHyPHPwkAO3wAnj+Xe2DkfmK5J4U+R4m?=
 =?us-ascii?Q?SPlNdaANW23he2LJnDBzarRczrfR7vcpXz2sKTse7gKqYfqI8rrARfCq3C8B?=
 =?us-ascii?Q?1xgtNxbYAU/bfNO/LtxOyIo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <637AE610345A354581BC777574B13F0F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e5c445-6bf8-4aab-8f2d-08d9d14c25b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 19:38:42.8811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 18inwHA5jcjrdwmZpQhnAjTWfDSEWREJcXKgYFzAu0pxkEApllJprIXSI3WlAvBlaGt1e0OhNftq6us85uMa5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4874
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201060125
X-Proofpoint-ORIG-GUID: VE7BVaEUEeDo4jhDC-wbWjQX074gKyM8
X-Proofpoint-GUID: VE7BVaEUEeDo4jhDC-wbWjQX074gKyM8
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 6, 2022, at 2:32 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Thu, Jan 6, 2022 at 12:41 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Jan 5, 2022, at 3:13 PM, J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>>>=20
>>> On Wed, Jan 05, 2022 at 09:59:16AM -0500, rtm@csail.mit.edu wrote:
>>>> If the special ONE stateid is passed to nfs4_preprocess_stateid_op(),
>>>> it returns status=3D0 but does not set *cstid. nfsd4_copy_notify()
>>>> depends on stid being set if status=3D0, and thus can crash if the
>>>> client sends the right COPY_NOTIFY RPC.
>>>>=20
>>>> I've attached a demo.
>>>>=20
>>>> # uname -a
>>>> Linux (none) 5.16.0-rc7-00108-g800829388818-dirty #28 SMP Wed Jan 5 14=
:40:37 UTC 2022 riscv64 riscv64 riscv64 GNU/Linux
>>>> # cc nfsd_5.c
>>>> # ./a.out
>>>> ...
>>>> [   35.583265] Unable to handle kernel paging request at virtual addre=
ss ffffffff00000008
>>>> [   35.596916] status: 0000000200000121 badaddr: ffffffff00000008 caus=
e: 000000000000000d
>>>> [   35.597781] [<ffffffff80640cc6>] nfs4_alloc_init_cpntf_state+0x94/0=
xdc
>>>> [   35.598576] [<ffffffff80274c98>] nfsd4_copy_notify+0xf8/0x28e
>>>> [   35.599386] [<ffffffff80275c86>] nfsd4_proc_compound+0x2b6/0x4ee
>>>> [   35.600166] [<ffffffff8025f7f4>] nfsd_dispatch+0x118/0x174
>>>> [   35.600840] [<ffffffff8061a2e8>] svc_process_common+0x2f4/0x56c
>>>> [   35.601630] [<ffffffff8061a624>] svc_process+0xc4/0x102
>>>> [   35.602302] [<ffffffff8025f25a>] nfsd+0xfa/0x162
>>>> [   35.602979] [<ffffffff80027010>] kthread+0x124/0x136
>>>> [   35.603668] [<ffffffff8000303e>] ret_from_exception+0x0/0xc
>>>> [   35.604667] ---[ end trace 69f12ad62072e251 ]---
>>>=20
>>> We could do something like this.--b.
>>>=20
>>> Author: J. Bruce Fields <bfields@redhat.com>
>>> Date:   Wed Jan 5 14:15:03 2022 -0500
>>>=20
>>>   nfsd: fix crash on COPY_NOTIFY with special stateid
>>>=20
>>>   RTM says "If the special ONE stateid is passed to
>>>   nfs4_preprocess_stateid_op(), it returns status=3D0 but does not set
>>>   *cstid. nfsd4_copy_notify() depends on stid being set if status=3D0, =
and
>>>   thus can crash if the client sends the right COPY_NOTIFY RPC."
>>>=20
>>>   RFC 7862 says "The cna_src_stateid MUST refer to either open or locki=
ng
>>>   states provided earlier by the server.  If it is invalid, then the
>>>   operation MUST fail."
>>>=20
>>>   The RFC doesn't specify an error, and the choice doesn't matter much =
as
>>>   this is clearly illegal client behavior, but bad_stateid seems
>>>   reasonable.
>>>=20
>>>   Simplest is just to guarantee that nfs4_preprocess_stateid_op, called
>>>   with non-NULL cstid, errors out if it can't return a stateid.
>>>=20
>>>   Reported-by: rtm@csail.mit.edu
>>>   Fixes: 624322f1adc5 ("NFSD add COPY_NOTIFY operation")
>>>   Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 1956d377d1a6..b94b3bb2b8a6 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -6040,7 +6040,11 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqst=
p,
>>>              *nfp =3D NULL;
>>>=20
>>>      if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
>>> -             status =3D check_special_stateids(net, fhp, stateid, flag=
s);
>>> +             if (cstid)
>>> +                     status =3D nfserr_bad_stateid;
>>> +             else
>>> +                     status =3D check_special_stateids(net, fhp, state=
id,
>>> +                                                                     f=
lags);
>>>              goto done;
>>>      }
>>=20
>> Thanks, Bruce. I'll take this provisionally for v5.17. Olga, can you
>> provide a Reviewed-by: ?
>=20
> I reproduced the original problem (thank you for the reproducer).
>=20
> Reviewed-by and Tested-by.

Much appreciated.

--
Chuck Lever



