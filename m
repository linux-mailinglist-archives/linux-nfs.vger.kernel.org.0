Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D815A5E692F
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Sep 2022 19:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiIVRI7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Sep 2022 13:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIVRI6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Sep 2022 13:08:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0718130561;
        Thu, 22 Sep 2022 10:08:57 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MGtZn5016450;
        Thu, 22 Sep 2022 17:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Gx1sDPSW0HtHI0Iqjs2o7BSUito2gZQpNXC5utl5Ps0=;
 b=gE2Vrv9bvAGmdMzcUa+wOtkhsjaHtgQMXjV/3cUqOAzqm14cIxYEI/oQptoChNzWTdbf
 ochK4ue3nFILTKoM7RaTDfTpD9g6/2JWWNxDY6k+6MMTV4IrX0PY1Wt0NL7c53ijKfBX
 fye/0fvAw1k3EUoMzYWMJZ5kbJGTw92rEJDQuw5X97XT6MaA6yefwU0fnMY2FAiGEO29
 jIZuZZzC+RIL5g4z2qklGA+wCL5cp9/Lle8TjrJN7JiQhqA9eeJbfFDsaGVvZpARMI3D
 tHvGSTsI7FXuTGX+01aps2Pfu1s0UfReLWWDwE6oNEAXxJHzsdrkw05Tw9ZsSnuG1fWW FA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68rp38e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 17:08:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28MGA5Ss005677;
        Thu, 22 Sep 2022 17:08:43 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cqu3tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 17:08:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdsFWoVVj98vN9qaEKcILOBLNU1gEKh7WjIdQsifS6QEkOK6+ZeGKIzRtvIE26j12i/qFxynX62hoSA8WCRuD4OTSZ3QubS9SaSehNwldyF7x4Twnz240ska4PDmmU6sHjdvDtCdtWMcL/uOoFFlPdJdJZ2SVZIbMKZWpxh4V5tc98yAISpDJOAXGiXTrHw5G6imLzINx3zrERO7QOhAVy3yqrMrhFgF83V8BE80V0wHG3T6ftm+42uEswIHdqQpNmev1x5A7incMeiiD5V1ETjm9jk9QGoN1+ngkdwFZW5NoFeFJ/c6AbLn/SrNTzHwxzJwUfu5ffJB8HUBgvCnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gx1sDPSW0HtHI0Iqjs2o7BSUito2gZQpNXC5utl5Ps0=;
 b=PlTT66IIIyjOajZ+TsYHJvcaeinSAhvfQ3IxS/FIYBJntTCiY+zVX0CQ2QklxV1/9FVAk1IFQH4jGSYNztjw+U4EkFRisHt85QhPq+6iuHGUIxqmXQKJDwb7Q8WpY6SKkGpuchuY8Uh1MflxqH+3xH0Xk4Ok0yCfaZkIx6wekajLWj37uoyTqqaDoSSHs4M67X1Oax41keHck9UOwuNgR0QJ+8G27jrX+4WMLZZ8eXv4NsRs0GsFPc1DW/iShU/pmF5hZNHnFF4Y+4nFuv+IIYoGEWKP2t1EaqDMvTwhW8wRB9mKNAdZpoQTH2VM6T6nkoNtAglU5n2Gc7uTbLGu3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gx1sDPSW0HtHI0Iqjs2o7BSUito2gZQpNXC5utl5Ps0=;
 b=TX9SipvDaK3gClt/Bg+i2qMx/mn3rmE34Vi2R7OUQfBRPK1zF6MPNQ9cqT/XMW5HeDjeeEDi+5C7v8vuF2c9hZWp/rP5mqfEG4rXK0ARhK8nVCxcnORI5pWhvtZJvrq5e6pdXvcIWCbaV2mRVKnchcyJyhKVTR1zeJA+j4zwSSc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6456.namprd10.prod.outlook.com (2603:10b6:510:22c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 17:08:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%5]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 17:08:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>
Subject: Re: [PATCH 3/5] nfsd: use DEFINE_SHOW_ATTRIBUTE to define
 client_info_fops
Thread-Topic: [PATCH 3/5] nfsd: use DEFINE_SHOW_ATTRIBUTE to define
 client_info_fops
Thread-Index: AQHYzphi3AzPA3f7A0e3mtEi2O3Mu63rrryA
Date:   Thu, 22 Sep 2022 17:08:41 +0000
Message-ID: <0376BA94-9B04-47FF-986E-8DD1D3FF1EE5@oracle.com>
References: <20220922163156.2027440-1-chenxiaosong2@huawei.com>
 <20220922163156.2027440-4-chenxiaosong2@huawei.com>
In-Reply-To: <20220922163156.2027440-4-chenxiaosong2@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6456:EE_
x-ms-office365-filtering-correlation-id: 4d28be38-cdf4-46b9-58ab-08da9cbd198d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q/HMH3TAI2Sl9Ao7TtE7IW04G2yWfyBZxcZ+9m9IlftiXVBLC7HlIwgDPO134I3aI10CIcJNwxnOq45dGpbhVAvVKLJ17F75rhtabHDjSyY0ZTo1IjMlBMIjjWpAs5WF0HR8tePNYZ/CP5CW0bNROSEqxVgSTEjta1sS2/qHWkSkVYMjjV7tX6Nzf1PW5Tp0IpFHfZb3U50yeJ9Gx37Ym7ekC0ePaYZW2/qsGhvBUeoJZrm/cKdcBX52Yq8F5y/XFvoMnYvkXLUmXC/CbZNwqLfi7QZLu0Cpjv1euJM3wn4zLsQGZPTXuaHEDbmoSCat4W9ft3lCEFmjhCebI03LKyS+nuDgwt9JtixLCTHXsHmbosco+oyfzJDrrrXztVSMs2SZz8Pq8Kun8lyX/92qWb5L/HlJPKIwqv+EJkgBvUHfSmlQHC0SmhZ3MgPiw6r2gVeyeekDV9SydjAU1aQ6k94v+lfHkPn3julbQ7BplfkI/h2Q27ACkFA61QVuX6W5fTq7B3mRYHbp+4eZ2PgzqFPptisgUbwrbQfPzt8WSaJa4XMf3Hh6xWS0nVQwAJrN/Da6g7R3o0QwTYzSI2jXK5XkvjnisE7jXqDDg8Zk50OvmS2sXxgJ+vGm+qhdqNve1GfaLidXEJQxlgyhYROC2xnoWbKtK2D5zUdVAJibqK5KR369w2LLahRAE93EPLNw9o9JLP6+6senfWiua+r21l8InF48oC18KHb5uUO1iqAkYygYsGLOg38Nr2HMwWhYqSEbVfTL2fCPRuCYxe+fBCMq3BujDvK6pHjwvZGgnSY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199015)(2616005)(2906002)(186003)(41300700001)(8936002)(6506007)(6512007)(26005)(5660300002)(53546011)(86362001)(122000001)(83380400001)(38100700002)(33656002)(38070700005)(36756003)(316002)(6916009)(54906003)(478600001)(6486002)(4326008)(66946007)(71200400001)(66476007)(66446008)(64756008)(91956017)(76116006)(8676002)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?at79PjpkEoG/OC3u3DEeamS+ShBMoOpg8JCILzqdeG0R9VmC7Fz5eHw17DH9?=
 =?us-ascii?Q?YPDaaJnNwvbxLKHGg6+t8m5GoVvbIWTu3wvQWqEAxEweFkWmshoRV613fRwS?=
 =?us-ascii?Q?ZZdlwPgQeudXTjWjUG3n/JBsNgRa/mTp8B9oFMSgl2p2H3UGiNEFZ/+2h3Zr?=
 =?us-ascii?Q?lyvcc1kOkblEMR7aM9hFFPsh6azTPtZcszC5XqgfHKAA50rNrfNGed/8o5C5?=
 =?us-ascii?Q?0QOoPljmF/OO4uQVgIRHUI7nqmcfsiVG5E4IMmQY0fO/Rh3OV6GAN0nbyEgT?=
 =?us-ascii?Q?0aZFKPJRsJ3Mem9aLpUmzYfSN555QDvBbraoSeAeK3OHLztF42r0ynjM4VaT?=
 =?us-ascii?Q?XFi7cHQseKmdS7q/pkX3yKasHJa5zt2ySbLnaPnYBMt8xu4id66m8BqKS5vp?=
 =?us-ascii?Q?V+NJ0vJbhEyiNAfzE+Wcns5ScY1isQU1nA/UyNw4N6nlwABJHXEYh3LG5DW/?=
 =?us-ascii?Q?mwJsN2+SL0g8oBDLz69bnTmEm/J+fR5ZsyxLe7HxAJtPc4zrs+5QYcQr047D?=
 =?us-ascii?Q?VcXAAr42rg8Q1K2YCPubti+PH/6ITnIgsUWR2lvSGJR9ybb9A09cBwTdxZKL?=
 =?us-ascii?Q?DMV/Pkdr2ZVJQhP/uneCpIdvdcPa12ZJMU2uSfuw7nkNXpQ9lE52iUmAgLEZ?=
 =?us-ascii?Q?ly6ZnjLFlAi7ZebZhIh4jmHqURqw9MXhHroU/cfRdMEVevBZS0rU5ZpQd1Tt?=
 =?us-ascii?Q?cCxht1GgtEYwgR5zCDPtoj1MuzoWa6G7MfogvkFTtj8MaqNPwBB4LTpUHRPu?=
 =?us-ascii?Q?YaHKXsHfTD3HbvGU43HQ5JRA1MCn3Kku2r9FpEC7zHLItldCAguV7nIL2U0w?=
 =?us-ascii?Q?UcZoVihW+VGEXR8EXe8woG67Qb52ZNgeA+PM/L/fUjzqV7xs8oZNXiYg5B2K?=
 =?us-ascii?Q?KnQLb9HLelph+U7pfE7UFf1oNbORLXww9vUvWPRaZETczMKOJrCx3MuzAKXd?=
 =?us-ascii?Q?EbjdvavlEvM8KeD6pWsmmISyGCZXMK7l8NV8rqInao/lE0J0fOOvh5mYf4Hn?=
 =?us-ascii?Q?3LYkf4vIDC88SUgPIsm54hNCYM1TYacdUU8FkhaKmANijdN4SzxTEOJ3MECq?=
 =?us-ascii?Q?UBb1Aco82ml5gxoxSOl4eEHJ1hxY+9/Clh3zwTJxFiryJVm8E4s+1vGr45T9?=
 =?us-ascii?Q?bdzsCqP9m759PrWyNl/opVCssvvil1r0mTVcdOqltYyao+3HryMZhygAFjvc?=
 =?us-ascii?Q?j/Sw01pQDyW/w7493FDvzZnLbxgpfEGkQI6jQcz2rai96a2AyGVchxtxjoJj?=
 =?us-ascii?Q?lg/tnGle/qUJfqLCy+lk+sAiOPD7d4XDfq4Qjma6bDo1SUHSMryq58FpDW1z?=
 =?us-ascii?Q?z+qOD5+xwSmGned+4a5Ao4DBoYB/G502I924aZG0pPrcKnNVrOfMvHr/JkZJ?=
 =?us-ascii?Q?hPBeU3WvlMBqL6DM6+zc7Vhdnqs6sSAc35ra/JLtBWL1gxUfk4wkq14iCFoM?=
 =?us-ascii?Q?UFrP9xyyxThcR50XPnHsNsIMy5q6YKrB70u7UWn2wQ1c/66OF2V3qaKQwz8y?=
 =?us-ascii?Q?btf5XGchtPVpKle9hvlvGPASYHwaOqYRPUKJe04jr863FsAyU9IOUaKCblbW?=
 =?us-ascii?Q?9r2TWuNckEAY8eSgIoBnJjecxH2/1VHMVQ9UGhdnzq9bJ3RDsKxeZjcR8w6A?=
 =?us-ascii?Q?fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F5A90055D9AD944EAC8ACB5AA066788A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d28be38-cdf4-46b9-58ab-08da9cbd198d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 17:08:41.7167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDuGpgeH49A+7cq2Ma3WDrTVJpPPX3oh21UCplPrQIzLSZ58524FQ5x5zkJWHEMSZc5tJVaGovRfL95hd5Sr8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6456
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_12,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220114
X-Proofpoint-GUID: rTQVUwgkplvTVNitajP0d0wCpvv24fz3
X-Proofpoint-ORIG-GUID: rTQVUwgkplvTVNitajP0d0wCpvv24fz3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 22, 2022, at 12:31 PM, ChenXiaoSong <chenxiaosong2@huawei.com> wro=
te:
>=20
> Use DEFINE_SHOW_ATTRIBUTE helper macro to simplify the code.
>=20
> inode is converted from seq_file->file instead of seq_file->private in
> client_info_show().

Generally speaking, the patch description should explain why
a change is being made. We can already see that @inode is
converted by looking at the diff below, so the above comment
doesn't add value. Same remark applies to 4/5.

What might work better: "The underlying inode needed by
client_info_show() is already available via struct seq_file.
Thus it is safe to replace client_info_open() with the open
function implicitly defined by DEFINE_SHOW_ATTRIBUTE()."

I'll apply these as-is to nfsd for-next to get them into the
testing pipeline. Thanks!


> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> ---
> fs/nfsd/nfs4state.c | 14 ++------------
> 1 file changed, 2 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c5d199d7e6b4..4017721a04c7 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2478,7 +2478,7 @@ static const char *cb_state2str(int state)
>=20
> static int client_info_show(struct seq_file *m, void *v)
> {
> -	struct inode *inode =3D m->private;
> +	struct inode *inode =3D file_inode(m->file);
> 	struct nfs4_client *clp;
> 	u64 clid;
>=20
> @@ -2518,17 +2518,7 @@ static int client_info_show(struct seq_file *m, vo=
id *v)
> 	return 0;
> }
>=20
> -static int client_info_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, client_info_show, inode);
> -}
> -
> -static const struct file_operations client_info_fops =3D {
> -	.open		=3D client_info_open,
> -	.read		=3D seq_read,
> -	.llseek		=3D seq_lseek,
> -	.release	=3D single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(client_info);
>=20
> static void *states_start(struct seq_file *s, loff_t *pos)
> 	__acquires(&clp->cl_lock)
> --=20
> 2.31.1
>=20

--
Chuck Lever



