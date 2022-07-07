Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A281656A8F0
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jul 2022 19:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbiGGRCA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jul 2022 13:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbiGGRB6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Jul 2022 13:01:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F6959259
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jul 2022 10:01:57 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267Er5rJ023516;
        Thu, 7 Jul 2022 17:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GDBqpOKUjOWwT5Ux2hNjtL2LDGxFo7tNk45BTda4elg=;
 b=0sUmPOrLtTN6/hZhppV/lYVeFslijyVU36ajtLQAY/9CYJC4tIEmBkED3BGiL0jQ0hSc
 iPzAWFsEiydrnrYMDBem5XMghJFNwDcCBZo+8igVIfTJtd+YE1TVALpORYMe11FKlIo1
 nSJ/V1kuFlb/0dYA6C316BFM4WKvhBE5S+Bg+DzAW3LQ0qhXwMoSQoH3akwRbbjptJ5g
 hOR9jTSNhiRH6ezKrmELXBy0bLLskuWMYF+la/f3dNbS1KF/QUVWdUCdOA5+/E8bXchy
 7txuy0PFbsLaPc4zs6YJJOwLvNHbmL0FsydAMGqSbohdEmUfhtTGTkK0bwJ/5Ug1oXVS pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubynutk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 17:01:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267GtMrP033665;
        Thu, 7 Jul 2022 17:01:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud6v9cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 17:01:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jW1bLW36tThlwvIn0tEicD3lyP3cpfEVzU47sv6KYJMkxCkh6wKqRv/ha4OYHmbnkr+Efs6XUiucN79AYRjv2jw11N/yI6oiRns5WTgT4ORQD8R0eFG5LiLQKj6XYLsF5S0K+xqImT03MfL9jRPGWtuGeC3itF5N6TxorkxwRa9hX6kjfXKcpt7oaRlH8nlIABPwOBZuQmbj2RGKEOlMlGqfDi4pY+rLvA3gCL9PvURahbt4CO8wC2/eymMLerb3osNmjj/ui85AW0h6MKf25Rn/v7ZfArnIzWPum1Q0ZMqJDlkCbb0DK1sEZaMM40btqxUyzRgJLW6R8Io+xGVCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDBqpOKUjOWwT5Ux2hNjtL2LDGxFo7tNk45BTda4elg=;
 b=oVRt3L2w1Hzqq56Nr9kZuVHWwhobqwEzNLU+Pu0TtkR6QnwFJu98tXO7byms5Q7mnPB3JJz3vcHj2BLOJAQdlKSp8Vi+AmDD6vb4KXgnsaKlqsU+t8nOjnik7LUvd6Ci+SSXoIl8iDmKfN47U/SnceUXQWJdydrNMkXan8Lmtv7yJ6Y5EQNXR4hyswx9XdQcaQ8Vp/dlDIuPIO9w51gyAx3f0M9u4zi3d30x8qPAt/DIdkJKOgnzaTKleZHW9pU/GFiYR9pPNBKvVyumfF4bhVyE9LCDNgJckk8ElkxcaNbfnYCyQ53T6Q1IVS5fy5dgunEkDPTzU57ZXWJV8GOIVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDBqpOKUjOWwT5Ux2hNjtL2LDGxFo7tNk45BTda4elg=;
 b=muQXrd8QwpqeJ0IqveT2wVgR42FPE31WHppILKKAZ5YdVTDtFzS+4oPqfmXla88v9tWJxHu7DOTrG00W6B1ZAuZpuTgC7AywcYgdncKDjq/I7Fz7sXlJiINwD9OW0ExMvOqp8jyB0kzQ7wQpqLwcAljh2i9v4j0sst8+zb19ffI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR1001MB2226.namprd10.prod.outlook.com (2603:10b6:405:32::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 17:01:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 17:01:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Bump the ref count on nf_inode
Thread-Topic: [PATCH RFC] NFSD: Bump the ref count on nf_inode
Thread-Index: AQHYkhpvRGZ0dTioakaq+LLAbdwSV61zIGIAgAABKICAAAC9gA==
Date:   Thu, 7 Jul 2022 17:01:48 +0000
Message-ID: <3A439D76-F78E-4449-923D-7E71A47FE36E@oracle.com>
References: <165720933938.1180.14325183467695610136.stgit@klimt.1015granger.net>
 <f3dc1a01fae6759a350adabf944892417a63d529.camel@redhat.com>
 <307aab1000890798345175063c24a77038a78167.camel@redhat.com>
In-Reply-To: <307aab1000890798345175063c24a77038a78167.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0894b4d-950b-4c94-99d8-08da603a613a
x-ms-traffictypediagnostic: BN6PR1001MB2226:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iMmS08QGinX8GZ6uxBAPnRKNNU4Vd9OekQGx2ojzU33zn0vsEK7sXGTM4nW50RBQxQgJ8C1V26b2HgmTKk2wPg2jsEzPUCeL+hT8jZVTaRGkv8OOHoX01aIseCHBfs+JMPSsZxFn5I+KD1ob5N7T2g/CsKfUtAM5wn7/SdMGb1kYlcbpM9aB8t9Vzwmcr4RzvIA791EiMwFVOO/iawNE7oSZ0bH+tGGCheW1QVwVRYpraWwr2i97aq9ulsMBjAqUx8y9dBSHCKxIGJEueB4zn3U+gwZW8Utdz/5qsrvPHWTmSIjOvyMPm4K+gCDYH31JEeI6asjOxYwL2S0inZFB4QJkL3NvSLMczKHaFQLIkT6VRaZiWGyAnhdTgNcxoecIUEgP2Rb/1EJ60kxHT6Twn2nmzZCkrmGm8fNHSPLNjYiQrnMa1gja5eTALlhYXOOZqNAwWaMHel0QT1W51wMlDvNOByXCwp5NUfXBYv9ErdlABp6KbwNgIIS3UxId/t7IAaNgFLsheM8ZxBQoRdXS1eYFthu16qVicNt9+xyi7LoxvMUE5/RFjJ+cdbMh7hRIFWu/g0p+qvitm1Vxtu4WeeDfHToZhW8d+fTdWwtsCd80ZR+QIPd4f74udfv8dKY6Ry7PQ5GeG7Q672ypoArFw1EcGYpVCj5ZHujJAzEHzF9q1xYYn/U3LHn6LXUtkKCkAESCJDI0tGy/jHanwsUC1KVblR+uPTtRbGQGZjt9Ft6Szt9E+tcB1+rUU4iCp5nFo72JlouZQqUfr2xmE0b0qI4SDLgrg4qLpNyLKxqM4Kktd9apv5fXiZ0mvgP2bMSLSafLlO4Oy1JCIeZqEzwSnFpFs8Zf0fAS0JK7WYlm+nM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(136003)(396003)(366004)(376002)(86362001)(6916009)(38100700002)(478600001)(316002)(41300700001)(6486002)(2906002)(2616005)(66946007)(91956017)(66446008)(66476007)(66556008)(64756008)(8676002)(4326008)(186003)(36756003)(76116006)(38070700005)(122000001)(8936002)(26005)(83380400001)(6512007)(71200400001)(5660300002)(53546011)(33656002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zHfBbmT1qc/Bb3a+gXIjxO8LO1qYI/9rDIvDnRorkvm4kR3coJPMIvczrwVO?=
 =?us-ascii?Q?rFz57gl1gYp4V3sfQSB6qANLLFRi+r0/6wKm09Wzw8q2G6bHbuWDPCFJPmTe?=
 =?us-ascii?Q?DMlckz2pjjcP6bvpCVWe+GUvBTD+JkXtS19qg4tprhZwLt8Ji95i9aSzP5SA?=
 =?us-ascii?Q?uGz2BSRlM5UFWzzewEHXTtvGiG2Hh51BwSDZa3fpnFVqwwJVVCtuZ5XNCKKq?=
 =?us-ascii?Q?elBwJXGiTHXLBdxlGX+qblKzE6D+uObmnydKPaTcD/5UqNLyMIoW6B4+A8Pe?=
 =?us-ascii?Q?KgXmaZjOeXMFtVF3OqyItuZo74TceEc/1wiG3ivZ2/lEm3z0gcH0/z8uTsY1?=
 =?us-ascii?Q?H9nnGmBsKHwMsVC9sb7XS7ynO0hCqp4om2qT7F7CoD78KJBuOpp1E+fjdLJp?=
 =?us-ascii?Q?3crMHVqz+Rx3KnzmaFrVHPribi4X/NlHQ2p6Hg8FAFCRCRQThmVWb2aea0Ls?=
 =?us-ascii?Q?Vf6gcxp1DaNI9XiTtF4MQmXW0ZMcTMqvC/xxj8k/Gr+WNHdKYmEppagq2VL2?=
 =?us-ascii?Q?snQNRCwZAqLz/DuV3RaIjNUE4Hgi9usujT5D5h8Ww/G+HY7jWo0YImOADias?=
 =?us-ascii?Q?YKY56oMDH6qnsVLWLJnOoqSlGLBof8JsmcPwcP9tYCnU16LvF3I+RDJY/SB2?=
 =?us-ascii?Q?qLY0jiWsANDdKQC4eSPsfmD/aVtgNlvzfa7COUU2NB8QScj43qwftJWA0fj2?=
 =?us-ascii?Q?tK0DQshSk8Qhv1IvgVDIq8HR4r+P/kyDN78oR0kNu1uPjBOmRVMACSCEeRR4?=
 =?us-ascii?Q?sR13/92SI68TVBlU4vsjISuAZcxN5LgsX4s/IehIU5QHA5yrcZyC2xBT7gx/?=
 =?us-ascii?Q?yFhtxtAkgZTFepislqpGvOYtrtyF9RWhqj1YWNDjxj4hmpuPeVdlRwIZVA5R?=
 =?us-ascii?Q?q0zHh0dwBtjS1rTTuxKa2n9Y0J1g7m76H/f+ATcrPppLcIoQdhE961cLU6h+?=
 =?us-ascii?Q?fvfN0S+lKwb/H2x42BifXUwLMl3iCSyNWZENxz9+7+brM/AuF60Fbe3wk0JC?=
 =?us-ascii?Q?4QQpKxpp8iPlYTbIb3Or2bLVvsx8j/qHt1afsHYUEl2VSHD9h1R5l1aTu1F7?=
 =?us-ascii?Q?ceSYBx/ACdPKTPbfD7m3BQRkuI0eGCQwOFXjpgYgi6NAQEFR0ONvadaZpjSh?=
 =?us-ascii?Q?7Wlsq/KuF3gHR50Ha37/zD/vW77dnIzovP3Ft3Pd1jdA0ijzxic/v4RvR+/i?=
 =?us-ascii?Q?ft6hLl+nR4Z/TRbVe0oy2LxqGF2kjHx1S0aTMnIPXUDx0waA+05dnhnF+wz5?=
 =?us-ascii?Q?mwmK5QyTX9ylefz6U6+zaI+Oz1vfPfrkmeNCczYla9WSK+daaptzwFOCIVeD?=
 =?us-ascii?Q?+yqQyGleT0OoM1CfXUvtlJWwiaSM3a8Lm5nWnA7EnCl4FlDzeWbq4Pm0hTd2?=
 =?us-ascii?Q?Ifl2MA3LIplDx/40wo/I3IUCWdBNlvc1zX6Qh1Pu/fKSLamxqbVu/sNAJaRZ?=
 =?us-ascii?Q?kr2BOLa9XuwD7kPZrabP7/8ihomav6JvjC9YKzsJuQxq/EhiVI2iuR/3Txby?=
 =?us-ascii?Q?2gZrFLkeJPlYtMsv3RhwxNJFGQe7eo/BwphK7+iFDmu+GwFuaZI/bQ4NY6kA?=
 =?us-ascii?Q?gZ4NBAjQOT0yp5V0QClTGIE4HcdxDOhU5PILv75V03gO2Ssp3+4Vi1V0aw+G?=
 =?us-ascii?Q?hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2076A4E193F75D40A12E3F2E78829512@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0894b4d-950b-4c94-99d8-08da603a613a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 17:01:48.1477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g135Cp7MhUG+/h7GFWDF+FwwIZbHWBD/PRKmUchLnpXDU3cOej8aeaE1EQePnT+/OEWchVpoGgr63nlLpwiVow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2226
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-07_13:2022-06-28,2022-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070068
X-Proofpoint-GUID: QFxApwV0IJ6x3mM7W9biuj-5gu6ZVocI
X-Proofpoint-ORIG-GUID: QFxApwV0IJ6x3mM7W9biuj-5gu6ZVocI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 7, 2022, at 12:59 PM, Jeff Layton <jlayton@redhat.com> wrote:
>=20
> On Thu, 2022-07-07 at 12:55 -0400, Jeff Layton wrote:
>> On Thu, 2022-07-07 at 11:58 -0400, Chuck Lever wrote:
>>> The documenting comment for struct nf_file states:
>>>=20
>>> /*
>>> * A representation of a file that has been opened by knfsd. These are h=
ashed
>>> * in the hashtable by inode pointer value. Note that this object doesn'=
t
>>> * hold a reference to the inode by itself, so the nf_inode pointer shou=
ld
>>> * never be dereferenced, only used for comparison.
>>> */
>>>=20
>>> However, nfsd_file_mark_find_or_create() does dereference the pointer s=
tored
>>> in this field.
>>>=20
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>> fs/nfsd/filecache.c | 3 +++
>>> fs/nfsd/filecache.h | 4 +---
>>> 2 files changed, 4 insertions(+), 3 deletions(-)
>>>=20
>>> Hi Jeff-
>>>=20
>>> I'm still testing this one, but I'm wondering what you think of it.
>>> I did hit a KASAN splat that might be related, but it's not 100%
>>> reproducible.
>>>=20
>>=20
>> My first thought is "what the hell was I thinking, tracking an inode
>> field without holding a reference to it?"
>>=20
>> But now that I look, the nf_inode value only gets dereferenced in one
>> place -- nfs4_show_superblock, and I think that's a bug. The comments
>> over struct nfsd_file say:
>>=20
>> "Note that this object doesn't hold a reference to the inode by itself,
>> so the nf_inode pointer should never be dereferenced, only used for
>> comparison."
>>=20
>> We should probably annotate nf_inode better. __attribute__((noderef))
>> maybe? It would also be good to make nfs4_show_superblock use a
>> different way to get the sb.
>>=20
>> In any case, this is unlikely to fix anything unless the crash happened
>> in nfs4_show_superblock.
>>=20
>>=20
>=20
> One other spot. We also dereference it in nfsd_file_mark_find_or_create,
> but I think that specific instance is OK. We know that we still hold a
> reference to the inode at that point since it comes from fhp->fh_dentry,
> so we shouldn't need to worry about it disappearing out from under us.

Needs some annotation. I would prefer not to get that pointer from
nf_inode, then. As your comment says: compare only, never deref.


> What did the crash look like?

Jul 06 11:19:32 klimt.1015granger.net kernel: BUG: KASAN: use-after-free in=
 nfsd_file_obj_cmpfn+0x26b/0x49a [nfsd]
Jul 06 11:19:32 klimt.1015granger.net kernel: Read of size 4 at addr ffff88=
8180623e1c by task nfsd/1003
Jul 06 11:19:32 klimt.1015granger.net kernel:=20
Jul 06 11:19:32 klimt.1015granger.net kernel: CPU: 3 PID: 1003 Comm: nfsd N=
ot tainted 5.19.0-rc5-00037-g17ba024b204f #3522
Jul 06 11:19:32 klimt.1015granger.net kernel: Hardware name: Supermicro Sup=
er Server/X10SRL-F, BIOS 3.3 10/28/2020
Jul 06 11:19:32 klimt.1015granger.net kernel: Call Trace:
Jul 06 11:19:32 klimt.1015granger.net kernel:  <TASK>
Jul 06 11:19:32 klimt.1015granger.net kernel:  dump_stack_lvl+0x56/0x7c
Jul 06 11:19:32 klimt.1015granger.net kernel:  print_report+0x101/0x4bb
Jul 06 11:19:32 klimt.1015granger.net kernel:  kasan_report+0x9f/0xbf
Jul 06 11:19:32 klimt.1015granger.net kernel:  nfsd_file_obj_cmpfn+0x26b/0x=
49a [nfsd]
Jul 06 11:19:32 klimt.1015granger.net kernel:  rhashtable_lookup.constprop.=
0+0x143/0x1ca [nfsd]
Jul 06 11:19:32 klimt.1015granger.net kernel:  nfsd_file_do_acquire+0x20b/0=
x1189 [nfsd]
Jul 06 11:19:32 klimt.1015granger.net kernel:  nfsd_write+0x138/0x255 [nfsd=
]
Jul 06 11:19:32 klimt.1015granger.net kernel:  nfsd3_proc_write+0x37e/0x3fc=
 [nfsd]
Jul 06 11:19:32 klimt.1015granger.net kernel:  nfsd_dispatch+0x5ed/0x7d0 [n=
fsd]
Jul 06 11:19:32 klimt.1015granger.net kernel:  svc_process_common+0x8e9/0xe=
fe [sunrpc]
Jul 06 11:19:32 klimt.1015granger.net kernel:  svc_process+0x34d/0x378 [sun=
rpc]
Jul 06 11:19:32 klimt.1015granger.net kernel:  nfsd+0x26b/0x34c [nfsd]
Jul 06 11:19:32 klimt.1015granger.net kernel:  kthread+0x249/0x258
Jul 06 11:19:32 klimt.1015granger.net kernel:  ret_from_fork+0x22/0x30
Jul 06 11:19:32 klimt.1015granger.net kernel:  </TASK>

The freed object was actually not an inode, so it's a red herring.
Still chasing it.


>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index 9cb2d590c036..7b43bb427a53 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -180,6 +180,7 @@ nfsd_file_alloc(struct inode *inode, unsigned int m=
ay, unsigned int hashval,
>>> 		nf->nf_cred =3D get_current_cred();
>>> 		nf->nf_net =3D net;
>>> 		nf->nf_flags =3D 0;
>>> +		ihold(inode);
>>> 		nf->nf_inode =3D inode;
>>> 		nf->nf_hashval =3D hashval;
>>> 		refcount_set(&nf->nf_ref, 1);
>>> @@ -210,6 +211,7 @@ nfsd_file_free(struct nfsd_file *nf)
>>> 		fput(nf->nf_file);
>>> 		flush =3D true;
>>> 	}
>>> +	iput(nf->nf_inode);
>>> 	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
>>> 	return flush;
>>> }
>>> @@ -940,6 +942,7 @@ nfsd_do_file_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
>>> 	if (nf =3D=3D NULL)
>>> 		goto open_file;
>>> 	spin_unlock(&nfsd_file_hashtbl[hashval].nfb_lock);
>>> +	iput(new->nf_inode);
>>> 	nfsd_file_slab_free(&new->nf_rcu);
>>>=20
>>> wait_for_construction:
>>> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
>>> index 1da0c79a5580..01fbf6e88cce 100644
>>> --- a/fs/nfsd/filecache.h
>>> +++ b/fs/nfsd/filecache.h
>>> @@ -24,9 +24,7 @@ struct nfsd_file_mark {
>>>=20
>>> /*
>>> * A representation of a file that has been opened by knfsd. These are h=
ashed
>>> - * in the hashtable by inode pointer value. Note that this object does=
n't
>>> - * hold a reference to the inode by itself, so the nf_inode pointer sh=
ould
>>> - * never be dereferenced, only used for comparison.
>>> + * in the hashtable by inode pointer value.
>>> */
>>> struct nfsd_file {
>>> 	struct hlist_node	nf_node;
>>>=20
>>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@redhat.com>

--
Chuck Lever



