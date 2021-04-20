Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7AE366139
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Apr 2021 22:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhDTUyf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Apr 2021 16:54:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49818 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhDTUye (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Apr 2021 16:54:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13KKovK2179851;
        Tue, 20 Apr 2021 20:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=HZuuNV7Ds7dobpKWU5bk2SRgaVVJdOZtc+3l12eOp3E=;
 b=zDUqvktuvH54jqWVByMOjYwVJ0IhRNO/z/SfPcUzJ+mbSLj1QflRo88+HKg0Dlrfcdsm
 2dOZCBIG2xJ9RnDSlr/5cDVC4QFRtVLBcblioSI8zoDs2J6JDUsJFAfhcazKHBkwuBLD
 MIM5RzwsDM+en76WAb3yz9E/gZfGjZ7xeiWNPcVb95SDa+t3H2W/p8KIVTl7rD2qkQno
 aZ+/Pvb1ZxRnHm87+6czwUJH0pYbrtXjUr9GHmPOQ17OT3DRvWzsV2GXvdt8hGyQRY0r
 ELIL/ahNAxP/P1a9Ucmt3mSJ6lV2uG/BKuazCxj26NawIM+SGQ7ti2KBlqQJJMy45VmM 7Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37yveag57v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 20:53:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13KKntR2138309;
        Tue, 20 Apr 2021 20:53:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by userp3020.oracle.com with ESMTP id 3809et7td6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 20:53:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N05dDdNUD6ZCzilgwfs6b7AGl6QLY87QCiIs+mNjPpFBHhhKlirzMM/Br/vh/e0c5KS87FV8z8HsMVFtJC0NT+GR3l8AMdgZ62YVveG+wbVVDFId0QaiO1tCr3RbJmUYLEjtb7I0tv1lTboXBgFpTIak6+SkuNu8HdSRTr7MdGmmmuNa2/xug9/vSG+CZAGPqAZjjDrSgJC+QwKDAkyl0pFJzh3mM5alk6OV0sKN1Wqha8VgofK2R1VxBgug2z5+hzzGmDp3zB/6ACUgMmudGflXeVQQyihtoEV6u4hYBYIKY2UEvnuhkH3mcljt648g1ry7UjeY6yh+i5irLwS/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZuuNV7Ds7dobpKWU5bk2SRgaVVJdOZtc+3l12eOp3E=;
 b=KdW5w+8bO5MWD/E5X4UaS5EmpBa2cZEIEjIIPdmmcra12zEHFvVQ/0J2OE3uPJCmwVooT/W/y3SX2wnn2LtB3o7vJcSerb1jXI2jhcu0kdLEBY0cVHJ7/troRZ3mvbNxAPF/KWxpAR0Ann9PjlmtUrErny9fmHjHjVMWaPOuUrHehUiQ2sw7wMlF+Q1fxAs0OxSx8+P3vB+Ipm/StZ8TZqnzwbKfY53VNCjODVGgVL7CScRZ08hEmBthc7qRHrL5R1Hgbe+7gGr2yPu+L0IRwBzQ3OkAJoH+LivtpEt+BDUWtKFLvveMAEYUfbTKTS1PItTe8H6tDBo8PCeTg3MOlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZuuNV7Ds7dobpKWU5bk2SRgaVVJdOZtc+3l12eOp3E=;
 b=k85ADEEIwNuL7WfA1av79/cLYbMB5TgUN0/O9LQNBDclMKko592s/WfsezIJK+FcBBb3Sm94OvEjjxx9EDisFqe2Ps8DPcXUD3As5eU4r10kazMuqA7euLwZ6jsQzindVdXLmsmWgfzMgVQPYSq1nkx5rL5PM2SKtnwoKcZGGYY=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3141.namprd10.prod.outlook.com (2603:10b6:a03:154::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Tue, 20 Apr
 2021 20:53:38 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 20:53:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 016/141] nfsd: Fix fall-through warnings for Clang
Thread-Topic: [PATCH 016/141] nfsd: Fix fall-through warnings for Clang
Thread-Index: AQHXNiOvDnzipbpPY0qAlkhMeYEHgKq94jCA
Date:   Tue, 20 Apr 2021 20:53:38 +0000
Message-ID: <908682DD-63BA-4914-B4F8-BE0317C2DCDC@oracle.com>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <0669408377bdc6ee87b214b2756465a6edc354fc.1605896059.git.gustavoars@kernel.org>
 <BF1128CE-4339-4145-9766-4EE7A5F58B5F@oracle.com>
 <20201123224605.GF21644@embeddedor>
 <eb3be82d-1930-673d-22e6-e76a5bc210b8@embeddedor.com>
In-Reply-To: <eb3be82d-1930-673d-22e6-e76a5bc210b8@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: embeddedor.com; dkim=none (message not signed)
 header.d=none;embeddedor.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b962b745-59e6-441d-6a83-08d9043e5f48
x-ms-traffictypediagnostic: BYAPR10MB3141:
x-microsoft-antispam-prvs: <BYAPR10MB3141E5770CFF9F60A479DF1793489@BYAPR10MB3141.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 84xmUQN4c7bpfuPkM0SwsIdj6sVHeePXZcpzo4a6la0x8caAOGonVTn18e6A+wEAHx4127xy6LI2805PZvdBf6ephQs/o/gnCHRAEsrfJDJlCIa8GKKhiknByZZ9xmzAcl4QuH3NoABE0XAk2+tsIBlIk6MlOLRD79G1klvZ7x/i0ZBn2u3SVOrpoks/48MPCeY/DEMSeckbEJ16ki0pDFReedPz4hFMW/0gHI591H2bldnfiPDEbI4ZWsIEEGYUXZ7Vwf9QlKCAqduPfnrDKMdG1bjsY3wzuhPOKmLRY8BpN6nG1ocbKFSD4r/jgVjRyyE0S4AKUBFhYl+3Ek0+5qSDZbnEZqnSJAXiY6svI8kk47tWDKHk3iRlU+TvnDeW9yYJhdC5pY7REWz7+ZTdMY17VTQSHCgcVacX09NedOJPg49aUJGKYw493xs6y9G+8CB0APG5Rr1KrHkwXzgW+KczaRnUJ9HKqIfYUPC5Tk8qh/vOwownxAAuvQRzv0iym61VH7+5vL/JLXZzHW48FIxZg04DSfMxXtD0eQQK8EEf77S9I0newQ/vqPW6JMm/XSXP3JLoVk0H6dI6uHFVl+yujE1zOSE0Z/SFmcOrJt8g1B9fTnzwQgTv+McpxGRYvLRNp4O2PHMRjx+z2GKPioQRzUMMwKr0lvsSCDn7r5JJ5e81q539EK5V8BIJJcrwoXN63V4UT0JcLvlk1hLaKIL5QYsbbd8DopC4IKKgqKE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(366004)(346002)(39860400002)(83380400001)(36756003)(478600001)(66556008)(186003)(38100700002)(122000001)(66476007)(26005)(91956017)(4326008)(86362001)(66446008)(8676002)(966005)(8936002)(33656002)(71200400001)(6512007)(76116006)(64756008)(66946007)(54906003)(2616005)(6506007)(53546011)(6916009)(2906002)(6486002)(316002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8V0CSmb9+/HQJV4gcd9P+ifCt2ErQrp/OxRzZ1claQYOgG96/3y1xuc62uzT?=
 =?us-ascii?Q?4yUAYPzr7DG/vj8EcWIMqRmu50j0yvITvBB/XIW6s+ClGn6TNNMZ9v4ACds1?=
 =?us-ascii?Q?rb2+u6a/MFyww3WncMdUq/jYI1vGzfZHvD6DP3bbd6ERIl/zYVC/5SfazYLS?=
 =?us-ascii?Q?YwuaWeZaw8CA/6fTD1jRc25Btpepmll2rkFrTwHUbiPSQEfJic4VM4cd7qAt?=
 =?us-ascii?Q?F5EIUOW+0ZV0fLu3yrSCmarCmSjW6Ms7IoyPDiFrFLt0jfXyrQzvxWQYXh3b?=
 =?us-ascii?Q?a9VO4z3ojqtbRcJBrqqjZuBvB1hbRl4LLwBKXkJr4APJ8Zh5RD5Xr6zW9YGc?=
 =?us-ascii?Q?U8iW1jCJK9CXpVcUnUkh5AzMBtSnAgehBWnOen6f9bKGS9PnDytQ/U9iRak1?=
 =?us-ascii?Q?fCe7tKJAk1xGUn8fl2Oo2KpsUEGX/eY4jzheUiylQPB+Rdewqj49Ra8lAct+?=
 =?us-ascii?Q?Hbhw1kyGastFd84aZtJhIi4EuAHlF5WkBUuD3LO+eitV8BDLtcH3tc7TxnQ9?=
 =?us-ascii?Q?DQYdAmg2tjgu1l8M4q10/tl2eTK48E3/ncRIR/1LaISp2NNRAblh40owqe1Y?=
 =?us-ascii?Q?oTOxP7Pm6BfQ59LYyQA+BbSiT6jHW8JB7lMTtXgZEyJVlC0q/QGUhIhuLOXI?=
 =?us-ascii?Q?DgG8eRmT+jBDmvWAafcalvZtRmuQu9rzt/1EzhDN+7sOq/rdGgdnkWpOTo9b?=
 =?us-ascii?Q?sclLTV00kG2CyifJ2lw5tqP+u/LpVJqd4Mh3AIEaLnFgJE0i8ZyHGAWiRfjO?=
 =?us-ascii?Q?5zUFQjAV4eVNAkP0xK1TP956Leg+lQRqX9AgO90OUM5URwdIawcuNtjpBuJG?=
 =?us-ascii?Q?Z1XHmRrbB9cP7NyvVWliB4gd+p3w4Rx8SWXLiZScPNcWfnWmFa5I6tZKlfxX?=
 =?us-ascii?Q?LRkejP95l6sh0km/GNK5mTe1vYQa0IKEKM9ea11wwxgJ5ubiUQlSuVBTZDFA?=
 =?us-ascii?Q?+QUZpTuc6iJ7jQghidxE4BGwiensf797lKjR/9L5/I38feAUqlXN8N6WMw84?=
 =?us-ascii?Q?1A+R1l6s59XZEVIN8tftgv70XVjUFG5+gK49Wgy1Oy7naYuR++xBcDKvNDoH?=
 =?us-ascii?Q?0A5b+XiSD6TpF6MdYCE9wodDPUmEUx9klW8SK1XzvckrmCX7oSC1UssAC8a5?=
 =?us-ascii?Q?S22ky+O61r3JhXsWnv2lJl2JEQwN0apBl6Q1qMXR2TTkXEzvrE/8bKdbJIVy?=
 =?us-ascii?Q?euemrwInVt7EeuyEUBeqiU1ZL00P5nqY8iodQwg3WipXQRyr9Szwl1UOPLsw?=
 =?us-ascii?Q?3ljadeO4paw3lcvV0t1+5Pm6mc/Fw04RzUivrXOyH9gN74MAzVGbq6SZwEC6?=
 =?us-ascii?Q?A1hnvJcDe+9bgmyWZlc2tsfR/UHC8RdIWwBbC38BCjb3VA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10C420978BFF444CB032B87219D2A5AC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b962b745-59e6-441d-6a83-08d9043e5f48
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 20:53:38.1565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VOZjiCtsNULJdbdnJfqgDjuI5wyeWS5SopYeuL5lh/jqh790mHbwglwa05YT/SlC7RImSyrVt2IMHG/wxtTF5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3141
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9960 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200144
X-Proofpoint-GUID: AvTdnkkT_WDZ3TkxYR5nWyYtoKFcIWJM
X-Proofpoint-ORIG-GUID: AvTdnkkT_WDZ3TkxYR5nWyYtoKFcIWJM
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9960 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104200144
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 20, 2021, at 4:28 PM, Gustavo A. R. Silva <gustavo@embeddedor.com>=
 wrote:
>=20
> Hi all,
>=20
> Friendly ping: who can take this, please?

Hum. I thought this was going through another tree.
I can take it for the second v5.13 NFSD PR.


> Thanks
> --
> Gustavo
>=20
> On 11/23/20 16:46, Gustavo A. R. Silva wrote:
>> On Fri, Nov 20, 2020 at 01:27:51PM -0500, Chuck Lever wrote:
>>>=20
>>>=20
>>>> On Nov 20, 2020, at 1:26 PM, Gustavo A. R. Silva <gustavoars@kernel.or=
g> wrote:
>>>>=20
>>>> In preparation to enable -Wimplicit-fallthrough for Clang, fix multipl=
e
>>>> warnings by explicitly adding a couple of break statements instead of
>>>> just letting the code fall through to the next case.
>>>>=20
>>>> Link: https://github.com/KSPP/linux/issues/115
>>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>> ---
>>>> fs/nfsd/nfs4state.c | 1 +
>>>> fs/nfsd/nfsctl.c    | 1 +
>>>> 2 files changed, 2 insertions(+)
>>>>=20
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index d7f27ed6b794..cdab0d5be186 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -3113,6 +3113,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct=
 nfsd4_compound_state *cstate,
>>>> 			goto out_nolock;
>>>> 		}
>>>> 		new->cl_mach_cred =3D true;
>>>> +		break;
>>>> 	case SP4_NONE:
>>>> 		break;
>>>> 	default:				/* checked by xdr code */
>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>> index f6d5d783f4a4..9a3bb1e217f9 100644
>>>> --- a/fs/nfsd/nfsctl.c
>>>> +++ b/fs/nfsd/nfsctl.c
>>>> @@ -1165,6 +1165,7 @@ static struct inode *nfsd_get_inode(struct super=
_block *sb, umode_t mode)
>>>> 		inode->i_fop =3D &simple_dir_operations;
>>>> 		inode->i_op =3D &simple_dir_inode_operations;
>>>> 		inc_nlink(inode);
>>>> +		break;
>>>> 	default:
>>>> 		break;
>>>> 	}
>>>> --=20
>>>> 2.27.0
>>>>=20
>>>=20
>>> Acked-by: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> Thanks, Chuck.
>> --
>> Gustavo

--
Chuck Lever



