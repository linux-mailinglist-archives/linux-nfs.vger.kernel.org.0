Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D4D67EB00
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jan 2023 17:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjA0Qee (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Jan 2023 11:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjA0Qec (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Jan 2023 11:34:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFA940E1
        for <linux-nfs@vger.kernel.org>; Fri, 27 Jan 2023 08:34:32 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RESvUN009579;
        Fri, 27 Jan 2023 16:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gtqDEGpT6Z2WYKYusLVZJng9WKfH1mlZu0Gnep7q/B8=;
 b=VZtx2oWFbuRMrgz4NvEeR/NiyFHOG17dtwRwYbzq59jG6AsIu1rykEdCREc8+mJ4Zn8W
 K3R4DV21SIcKM9x3PXTzKpkdrTd5s4Nt8KWVnkZdYLGl3HeWShUq5xHtWd+cvsaGBixM
 8JCZ7DdDzeWXJFdUGklzJjoRKegebIjW5DJaxI8UcX5QrYZ/zhuXNc/rmfXe+omhotig
 GpZupiU2x48b8AsS8sOOCK5goArYxXHFKNtdW6E0znW08sDdcOAEHfMN/ZftLPlptUCE
 znbrT1ofG4rSNmLYqdDW6OQv4WRsXUHE+liC4NO5/EsSSsTN1iXZv24ODHZisiO0BBkH YA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n88ku53p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 16:34:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30RGMDMe023932;
        Fri, 27 Jan 2023 16:34:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g9srkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 16:34:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuNgAmoww5QWJKlhIHzgWaqZYaw55+XXjsDg1nCTBSUD1jZeqax5vQzJBoQ1hslp8wCxJCnEOTx6aVA6Bx2+1W5qTiVLkUBOdKicUsVhynm4v5yfSqFjzXo4hdW2zukXHEX9lHrC5XuWwcrYy/24K0tMrGZnpVs/N1LeIOuuBPy7zkLlSCxn20HUCySpLLOT7qR7+yttRzy3pf95YTF/6utn+SqtFj+3QMWj4SvHWKL7fdXbFyvqxxiIMeHHWGdVtAcFozt5GjJTsN4tLLss0ElqkjbnFfN5M01c/gQCy7cMnrZ2BzpGjHRe0QdadKd/PUWVjv4mRpX3V7KDVM8Twg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtqDEGpT6Z2WYKYusLVZJng9WKfH1mlZu0Gnep7q/B8=;
 b=i3oDMNmtAhmcUOEMJj/oN4/500PInvitR+iDhAY1+SmhZoWIBOfQ04d31aTvVOk3F9Lav9Vo78H8g+zpT1gT3jk6ob7yCPmIVHx7tQRiv84a2vpiQW4GtwEnD+BDB8RgRAf/2eWqbDksMqp2DlZuyZ8LKi6fQCB3cYq3dXtNVEdDaEM6H9pXlKjRx896KB4zthSsgPGcA2y5hqOISM+XaM5536QQwcPqtEz9nDQf7YWZuuzq3g9LCCaO9hqtPkm7ZDlB5/y/fHRFkJcjE+FPJ0I/SCPpTS/UatZ7cfERxMS6z95+e2WehETLxk1C78seJTrq15Px47rnXZrYwnqfBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtqDEGpT6Z2WYKYusLVZJng9WKfH1mlZu0Gnep7q/B8=;
 b=xz1jR4kH/b1eGY462u93TyGtX4HyX6g7EApjsbONmW5Os/mn1DK00pdUj66nNsyo6drabktKZXjpv1jYPK6c40s0pUcG8wg3gfZHxjB8aCG+Q0MBBgegjc+vurWe1i3utGTgUFR9u+lP4fcwtl3Kh8bS+2GM+xhk2qYslle0oag=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7433.namprd10.prod.outlook.com (2603:10b6:610:157::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 16:34:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%5]) with mapi id 15.20.6064.013; Fri, 27 Jan 2023
 16:34:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix race to check ls_layouts
Thread-Topic: [PATCH] nfsd: fix race to check ls_layouts
Thread-Index: AQHZMmsV5D34wjZzDESw+lpk/7zjnK6ydZmA
Date:   Fri, 27 Jan 2023 16:34:26 +0000
Message-ID: <C9FA580A-52A6-4208-AFA2-91E8BCB36B9F@oracle.com>
References: <979eebe94ef380af6a5fdb831e78fd4c0946a59e.1674836262.git.bcodding@redhat.com>
In-Reply-To: <979eebe94ef380af6a5fdb831e78fd4c0946a59e.1674836262.git.bcodding@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7433:EE_
x-ms-office365-filtering-correlation-id: 912004f0-a0f0-4742-553c-08db00845ac5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OrPUyep9kvwrcYwT2fn1K7+XnqFh68XGhi+08g52rlJhqg3g4w2sEwoDahjJZNY7WuswoYvFrEJJE4K/p6luWYbhReqWrGQiRRRemdRroc5LaymY/yBueivkfnsWO+4CUQzgAAkgnPyLiBfgVklKIAVZS+5/gVsMm8ttFgS16Sf4lOeHB7F5TohSyGCA64S3VmSokrR8V0YvNFJmNAicBkuqAuzEDXJPrK0wcpAtIX7uVTYR7QEYpQLuPPRJclAjm8P8O35DsjoKfyWGZ3JkwkpGIFe2aADHQkmcgHcksl7TprJbOAdG5qNP/+Zh+Dp5CUWCHUEfCbX1oXQiFvMX70ltje06wUCsitZYDFgozu15qXOPm+jest+5HBRdXv/kI5f75nuiOcuOiPiy7QGU5Jq8ZxUbgDopD6wtblgT1Lrb3GImmPRDYlQvh57SfV42OpMpKBpgfQmp/HOsLYozpr3GhIzmtHvsSWxbgLVZQ5XWChvHCOC/wzt66h96Eh4Uur1GqrrCMFnVb1nA+PO614hkUZUTMZtmnTXaFGq2BYVV0hcSo5nsNFPfjd+dBGhuFHJKTPWqZSO5m5gazyfHreIheqdfeaw2JxR0wrCT8o8o/Vl6l1G95Pqj/A2lkKVBmDSD0yvcJAixQUxCyHhRAUTFR5S0Z4lPbRU3Xb5w2uMGtGTvenrN4shItcS8yyT36EeVf57hYVtA44andVmjliXezOsNYdXJ1Jnjis7qPLI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199018)(2616005)(6512007)(26005)(186003)(83380400001)(53546011)(33656002)(38100700002)(122000001)(36756003)(66476007)(66556008)(66946007)(76116006)(86362001)(38070700005)(8676002)(4326008)(64756008)(316002)(91956017)(8936002)(5660300002)(2906002)(66446008)(6916009)(41300700001)(6486002)(478600001)(6506007)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o3D1hZh6M/40Qbv77A82mVqLD9g8njlp8HIM74Mqi9V/wQZWzNxT5IN2Wjey?=
 =?us-ascii?Q?KYr0blOaLDy0/3625pNXHt2QVqEGivMNgiXAH9vpSLXREDx+KrvVmwoDtH+x?=
 =?us-ascii?Q?b2I4DIM/K+EZfW5OxjfWhW+Fvji++/ONn15MXQFQpO7oH24/5tx9Qp6IgHwR?=
 =?us-ascii?Q?JWCDB/s4cTvazexFPSMgOAkx6n2JkJsU6Vfz0Z3ydctlZOR1FWUd+3lJbhNn?=
 =?us-ascii?Q?VHgJWHDQfmggls8mDhcljYh2s0iE5FavZ7nmgtiNk/Pcpp6zBhK0wrofzHi2?=
 =?us-ascii?Q?CUJiQogIXKdOLcUg0hFVBiNH6LIqc0u0oP4m8rfeFBFxtlD949NEp7KkQtwi?=
 =?us-ascii?Q?sG+lTQfoBoSFkgzKGpSuSGBWqt1MvUN7yD9rjmSSjz1Vo+zAIsg6+nmV9ZXV?=
 =?us-ascii?Q?uEj4cUwcr7j2UI+HC3dDhxaw8goxF5xnPIDWQSonwcjwpaHhYejTkYD+Bzcz?=
 =?us-ascii?Q?oDYm3JmCLD/c2GnFc1ZJuV/AEwctXFSv77AjDJgBvV03PvBq6KZ6lxwunpec?=
 =?us-ascii?Q?P1QcM2gqZOWi3312dAgQeX8ndJEC3b60jP7uj7nRhYAs0zJOHvEUvhJnjc7+?=
 =?us-ascii?Q?Rvns9oxUUc5VU6pOSw5wqVmGOz/Oh35pvWUkDv3Mu6NQhwywxd280AugJ6Q+?=
 =?us-ascii?Q?tWxvNKghvdQ0ylllMWT/Xz6XPjQhdt0QYc9/C+Mr1fxDIhBYKMZtYjfcRriB?=
 =?us-ascii?Q?lHwtl6IzlQCg1DEBKb3ncQyQZlmqt0kPllSqJpcjE0X8mtHKQC+yYBVYmfwr?=
 =?us-ascii?Q?okqhVe1bNj3wA/xxxxaX8/X9BXVE3v86oqCDJDUzwug/1is5sZ90IxapePC7?=
 =?us-ascii?Q?/oD9dVG9iXoha5YLqaTznDf5bUfZVFoaeY5wn3xBpF5prRJzZJZwxZn/Z3oZ?=
 =?us-ascii?Q?k5A1oN1xaujn0AWglnV3qRUxvs67FXMjKcirnC73xg/qazIixyQkYJIPSG+F?=
 =?us-ascii?Q?iD9KUDCaIHj72/mru98HSL8/vngMZFYuZAIcjFLp/ZOv1VuZhZITDprpUY8/?=
 =?us-ascii?Q?vyS7RS7+o1DHnvSSWrjxV7MaVvAyIvPRlkQ+TsBmv8Z3QrUBL98WHSxrjzoq?=
 =?us-ascii?Q?EM8eqtZ+v4THmUo4+h0XdOu+cl52HA6ZnU/vZX0Qdz4Sr+0zC8WY6ruaQofK?=
 =?us-ascii?Q?KQJPWYpVSLp4uPEzCyLdgj6z0QSjVdKmakgDWpcPN3NrTpk3jJrCf/df+/21?=
 =?us-ascii?Q?TCOtKYjFFqJ5jwcP/8O/j7MIbKrTuW5ZbXLkimIvQbQK5PtftWgRdA+1JMEf?=
 =?us-ascii?Q?TRz4MW2znK1rjqPJsQFoPqhPxlwADE9KgZPAHh+YSGPUcX39OT3y5aTqY2z8?=
 =?us-ascii?Q?Ni2nlOjKrZFyG5odMrF3wOma9pYAOlJuqxVjmJ8CGyL0Tdpsc6CogdZgQVQo?=
 =?us-ascii?Q?bvlZuhEPnG0BNH5MNrQLoq+gO8o2nvPYFs2+3dlnZVQQjhc3umb3uZf3VscT?=
 =?us-ascii?Q?d74su09tedW7MBL3tkcs2JVAxsJGbkE/UL4XTQXtEAlt67/8pv8bkdWh79WQ?=
 =?us-ascii?Q?iPS1whNPTtOPg3A09gl4LB9jLnW3dqWSRppLoWUec1WbAMDnue8KVJjLpG+i?=
 =?us-ascii?Q?5EV0Kh+a9VxGDfkvr+bURn6UQPTbh9VNoktirBQQhL58fw4594S7k40cTkl6?=
 =?us-ascii?Q?Nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65CC7D7BB3D5AC44AC46E9661C947415@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PLtRweuWkuLRXueAj6Ps9rXZPwMYJ3e/e2NRTzUbHhC6+ZTrWTC/a+Lu2R52O9SUoWwAiTtZmRizWhkpwi9T2MVK/7Q4krDKifyeZI+Qdrhwz+LBzYzwMbQ7pv0P3aoF7vk/e9/uo4Monq2rL1uizMxwrH8rXjOulBApxvXAkHuRGQxLupLwwn9eeCRm+JKLVfK6L3IAQFoCnd3sFhUkECqjkkO/3js+KF5pqkCMfJ54EU2jEa/qQv2j8nx705xdZdVtm8qMNdpYB/KlSb9oeWntVkR/CSzNOuz8gs5B9HCx4XWAtrXO068raAcTRu8GLyTy56PbinRn1jPcSJWNQcIxm8SZ8HC5PJJ1dvRL5zT7QKc+phqznjXLDW/FnHbYqtk5yi2aHElwWYP89+h2kiRpOs03uphOk5XpAzXMgC40ZNUyvovygqu3D10dkIyceaI3bs5X3Ky3Nsk56rxwCil+9pF35K70lG5gFv671YqGImZL5mIZCG+LzfWN7QCmKdu8LOY4D9V0XhJbP178ijyaM4JjsED3RF4Lx75m2f5BNhP88u8ATL7tscZ4zu6qxLZmjam0aCJUJ3tVweM2Dru/BN78hKP4UPipBz0apRHUcpEvmj5JNpk7kS9CFnZR+NX8WsX0juua8rea7e9uwifNlUp3Wa4k4INC6g0uePPB4+YjXGUouyTGeVyX+NFD0hIhL90SuNRTDQJslNkQh/xLaVK3gUosSdK/SknUdO37Nd8Qr11xy0FEBjT8lZI7+Z08jB6RZo5Oce0HSXnoGBumhNdd8Bumpll8UkicLac=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912004f0-a0f0-4742-553c-08db00845ac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 16:34:26.1465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: By+ocEvc4qYVbSvNrFOse7mQqT/gcvb7sQ/rbjpw9S6+G4quRff01NDw0qOSrPG1Hqt8t4sHfaktU2hL3Ib7Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_10,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301270154
X-Proofpoint-GUID: ZJmGq7qw5N9ul_NcoHbdbWa6aNliUiiM
X-Proofpoint-ORIG-GUID: ZJmGq7qw5N9ul_NcoHbdbWa6aNliUiiM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 27, 2023, at 11:18 AM, Benjamin Coddington <bcodding@redhat.com> w=
rote:
>=20
> Its possible for __break_lease to find the layout's lease before we've
> added the layout to the owner's ls_layouts list.  In that case, setting
> ls_recalled =3D true without actually recalling the layout will cause the
> server to never send a recall callback.
>=20
> Move the check for ls_layouts before setting ls_recalled.
>=20
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>

Did this start misbehaving recently, or has it always been broken?
That is, does it need:

Fixes: c5c707f96fc9 ("nfsd: implement pNFS layout recalls") ?


> ---
> fs/nfsd/nfs4layouts.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 3564d1c6f610..e8a80052cb1b 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -323,11 +323,11 @@ nfsd4_recall_file_layout(struct nfs4_layout_stateid=
 *ls)
> 	if (ls->ls_recalled)
> 		goto out_unlock;
>=20
> -	ls->ls_recalled =3D true;
> -	atomic_inc(&ls->ls_stid.sc_file->fi_lo_recalls);
> 	if (list_empty(&ls->ls_layouts))
> 		goto out_unlock;
>=20
> +	ls->ls_recalled =3D true;
> +	atomic_inc(&ls->ls_stid.sc_file->fi_lo_recalls);
> 	trace_nfsd_layout_recall(&ls->ls_stid.sc_stateid);
>=20
> 	refcount_inc(&ls->ls_stid.sc_count);
> --=20
> 2.31.1
>=20

--
Chuck Lever



