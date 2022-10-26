Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA6F60E22C
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Oct 2022 15:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiJZNak (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Oct 2022 09:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiJZNaj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Oct 2022 09:30:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6101A829
        for <linux-nfs@vger.kernel.org>; Wed, 26 Oct 2022 06:30:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QBEOHs002059;
        Wed, 26 Oct 2022 13:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=TsagjqfFCzJH/0ojs4diogwpJmyXXVpLPRqNYVPvEG4=;
 b=hl6g+Rpdl3lpRd1t5U0BLmwHYbNYrSSX7/n61zxq8cgIAOls3XyTx8bSay39L4FdEUFz
 W0XvitYZtfrvApNQgzWKPo8uO5+2kAV1NwRrPP4HThU8MMoSMDY5uUyiTZXe4biDODr0
 ixdN3okmnFT4p1As5fXQ/dwJkRh9xTnJeYXHEydhv+Qbf+E3FCv2Sm4t9Mum7VLByXAg
 63omL4Q3tOyBVYd82nyXf/F101vj0sf7go0x0iydpyZwaUB8E1C2aKSinZmKpGsRE4EI
 ug63Hy8DcRZ0lF3/C6rENhkLxyP66U9FTV8IwwVeS8ROXDZ1Bbqss0ktp/bzaU7/QfcD BA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc8dbparb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 13:30:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QD1Ofs018003;
        Wed, 26 Oct 2022 13:30:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y6048k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 13:30:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oR54CjzHTLxiOug4Jm/grvqo+z1APnfNhWZ4OGdD0ShmUD0RUqIc5TbmAvcHN5PrhtEOr1V0IwogvlGNH15Zwrv0eDWEh3vVdfd5kgKWAKf7E5snwpYkC6Y2o+dMfCNkWqmU+Kym7Hmu0Ha9nODBlRVjlEHs+nvriujiZC3S7x86MH8Wl4CkFApa4JlNszzuIcshbSzDw34MaYo4Sda4ls//Y+XE2V6rawBP4ckLI02r/61UJBQNkc1m2gwxnPLwCyBZNp8zQIRlyDwKq2VGnnfwKhnVtaSPHC8Auxtw+Brq7IaiBz0XIEBIg114vcEyhMqZw/GEYzp+/3xNq0FO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsagjqfFCzJH/0ojs4diogwpJmyXXVpLPRqNYVPvEG4=;
 b=OqtkRJzyh8iqMa1j4kUDTNTA+fjtVCvN1rG6U9NSUANc50lr7emcdwr3iCdQ7w1vWfJLbyNCCs1adM2L7BJyM80lk5iRvt5j2393tLWIeaMfWDNk64P1G8pYJL7+hjPWUFky+Ch/X5ScUWVwgd9fd76Rk/gFvnqT9lVBXbr5cQdoW6QzyNaTXC0wKrfFP9tPpSF3c/LyAqmMDAu7Qe2+Vrqo/NxBn1qcxCIU2fH6/gKjDVhLgAiGJJa9U4TMrcIsirhdUYWgEDm7Bsy7AA49KbFklwrIwXN6oqCQgFbT6/l8WEHnFYbPjxp1oe4cSSgotaX5q2lXDDPwtX2Z8z980Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsagjqfFCzJH/0ojs4diogwpJmyXXVpLPRqNYVPvEG4=;
 b=zQbjVa0rGGgkqAf6IWlFI5/P2t0Bc8W0UZpJD4oYKGqe1Zz5jFeaIWkTC8UQVQnQZBl9G4l4QOIiFqBNjeolNokyc53zRNAPvAarrlk2ogh8gbW2HJeFIeLspPJ1FnTN22Ez/jmGXQbge0A53Uxzb6GS4BpCtkXdhWVIj/2Lem4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6496.namprd10.prod.outlook.com (2603:10b6:806:2b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 13:30:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Wed, 26 Oct 2022
 13:30:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Ondrej Valousek <ondrej.valousek.xm@renesas.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfs: Move ACL xattr definitions to linux/xattr.h
Thread-Topic: [PATCH 1/1] nfs: Move ACL xattr definitions to linux/xattr.h
Thread-Index: AdjpFseyCVMG/398TgCgX5c43WmIgQAKE74A
Date:   Wed, 26 Oct 2022 13:30:29 +0000
Message-ID: <7C212DCA-6031-4E8D-A64B-7969EA4A40F7@oracle.com>
References: <TYXPR01MB18543A8B371E885CC9AA497CD9309@TYXPR01MB1854.jpnprd01.prod.outlook.com>
In-Reply-To: <TYXPR01MB18543A8B371E885CC9AA497CD9309@TYXPR01MB1854.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6496:EE_
x-ms-office365-filtering-correlation-id: c659c827-f48f-450f-d051-08dab7564036
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UaKOU6Xaq8sNg5glKo1hCEOp4YCo2AdplXqrQoz/KFCE2UFYIMQVIaPqEiXXqGxrSQR/k+Ai4bjbhqI6Mz085ZBStFwevO4+CrvouhRJ8PxP2C4egRnnHvYh5r0Ky6X+wpqfugcGnHVAPS98faP+AmGO40K8R/X5dYRmxvG94dZbPyTImwr3M4zV4h4mcBeA0EVWSScw2kzNsNgIYoXUQN7CydY/RcWnEaw8v3HQTXoJwn952Ibe+lZ2Ixee+aT4XBtPus3jFiPNG94NjkS5gyt2sbuuHq5R+m9/QZ4fx/I7/YI3KCu08aBdsAbWWKTX6GH9AbXqyMdt1xr3/kviQM/hkXk/N/5E+3J52CkM5XWzods5Cz/u5U3NZ07pCHjOl1v+V800IvaTVQarUXqmisgNhqcE0zfbtJ4Y0cnU1PwJTB9BK8CleH4SF3wmLJriUOWhdMZ9nsAR5wTPxNPvBYszTi8QHTz4Da/5WtPWymOkdWqxJeDx26uJOekP6gKqhafd6zOpUDxUv+bh5561ATSHBi8idKN+JQBY8ZmLxU2LlMaVvPh/YjVEViOXqSrGpZB9JzJKtBcFUeno/fVUZdPYCT4Cd/8g6vXWcthS6jZMPNv1ha9QED5Bo+VJaBCbJTiJB/XETujVnTLp2yDcPglmR5JqBDEErt1XD5dkyhrjDO7E6ZJtaC/O7szoMaZZE/qg2H52V6A6dcjnt+Cq6HqtjBtXjpT8lgY7mspzKB0XBAregzMWOYHN6NVwHPYPQe7CehRKCffkml+Qah9AxhQWhS0GufIcnHu3M+cUlH0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199015)(478600001)(71200400001)(6916009)(6486002)(316002)(26005)(66556008)(36756003)(4326008)(8676002)(6512007)(6506007)(76116006)(64756008)(66446008)(91956017)(2616005)(8936002)(53546011)(5660300002)(66476007)(66946007)(33656002)(2906002)(41300700001)(186003)(83380400001)(122000001)(38070700005)(38100700002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iQM7J0M+sWWcyoeYZ6P87O926HY2D3iXOmpRHpfnazLRNvKOYwoczhcP4DON?=
 =?us-ascii?Q?+xuaJ2HIIcL2FKaXyPYjWn5hZU6DevHXKCfoLI5ayRBMZCVEVFlLAnsSMzvS?=
 =?us-ascii?Q?Q8/ghVtUn/chAWADc7OgR6i3JV8o+uHJIhhOJ6Zt6DvYfRq/SIfcX6kLbgio?=
 =?us-ascii?Q?8bEWZjR1Hf2L/jc0AYAravKrRMc89nGlft7ls508tM2NCEMXK3KD/4gtDnJX?=
 =?us-ascii?Q?bFL3wMSYGUqiYfd8fBqdnwGEudMO7yPX0nbjjSsY9aKyh80jNwMjn+44H09R?=
 =?us-ascii?Q?3+p4FqhxqvyhaqWoPylUJF5J4VYAWpXEz8F2G8bOC4ZkyA3i5h3qOPIvKWFD?=
 =?us-ascii?Q?2FFqO8rMSAABPEit3ZbggGEmkUa1ts2LFojFHOHS5EUYHUwAgp0KMV720ZY8?=
 =?us-ascii?Q?4fkIBBJ2Yo1616sCjC6JFTR26v58czs/1the39jb5NoIOUf+8kmMZwgFEIcg?=
 =?us-ascii?Q?pPO8biaXnFs2AGgzURXQmOVJRWpdITgQBZZIWnvoZiFqR/WlaZEc7S7cIAaB?=
 =?us-ascii?Q?i36yi/l6YTBBxrCqbM7K9zHwYdUDZFp0s9qRs9FeO01qcGUf35IA7UOkue/1?=
 =?us-ascii?Q?MJ8cP14Fq+f7Z9Y369AaQjvBbanajyzujmntfe4+pK/cq39znPU3eOfQkaBj?=
 =?us-ascii?Q?6THFuYm2fZbcYldGG1s+KAsvDah2/DUK5G/r1olRZ3YXAa+GO0Ew8VDX/wyb?=
 =?us-ascii?Q?hH60OPftsrmsDqmr+LYUC9C3aEE+AvjxH3hveCX/1dPhFelSPzf9FQJSPR3E?=
 =?us-ascii?Q?bXBa2nMdtENFonXoeKi4KIBBviFSGVRv8ymw+eEjDrgV2fxACNhESPquG2pe?=
 =?us-ascii?Q?mLHds3W566UlNk0v9jR/BnCKlSLdD5E1+qcD7kEz0Andi+bh4HSv8qefUm8F?=
 =?us-ascii?Q?qymmu737DflDSJ3W1L4URB4DHL4d8AjyDTw3oUuc8X+LxYHeeLFQLJItfeeR?=
 =?us-ascii?Q?H5A5ikN/zk57Lxv2o8W/OYNyj7SN0IHK79i3Vh4WipT+kWsyvo1ObIOiOfm4?=
 =?us-ascii?Q?Nhs/aJFSFoo1dd9XLvnWw0rAaPM4BdGoxEElqLqoNfrYwR3DiKiy/ZNjFHY3?=
 =?us-ascii?Q?p50GnlF0NdDfWc5hLb+jaznK/x+KwpaD9FZTUZ3ld5LmNvqa29D+Ox+WVnRr?=
 =?us-ascii?Q?b2H+YgG9FXqiNBsLNaqxzoulatnQ1UZnIwRin+seSsMtXf+00YYBvLvzPbNi?=
 =?us-ascii?Q?bwtCl5EkOFE3qDS1IrWxEATe0Am5VeW4WXRz8fr8dVoQ5yPJpHIegtIGaVET?=
 =?us-ascii?Q?6VeYcUiwqFF/iaVDyuHk9+GhgasqrQVd9ONrGayAovISqChfHLM83NXEVQFg?=
 =?us-ascii?Q?SWlfQQlbCf6Yw6V/Ak2azhOWCQGExqBVe1kfqmG34W2Ofafv4MaXgQyW6n6g?=
 =?us-ascii?Q?LvWTdgri8Y+TdjuITifEKs2ylh6bV6LfN5QdEDh5ulHT7MCq5TfdjDVhLInP?=
 =?us-ascii?Q?xnkyTWK40KRzcOs9Da6Y5DvB/c+B1p6MRIXZDQ5bFm6f30uKV8hhsQwdUsAG?=
 =?us-ascii?Q?rQTcdcxlmZEeeiQBUsDC2eohUZl5QnMvioUw256Bw5kT2KueoQtoxaV8SKF6?=
 =?us-ascii?Q?pxgezmU51zTIvx5OFBzRWngkwhSJcSN+Po63WWlcfAAHJwr5kbSZ/HdrW94E?=
 =?us-ascii?Q?6w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0EC82816D762EF41BA171C3685C4FC53@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c659c827-f48f-450f-d051-08dab7564036
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 13:30:29.8594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MGT8pPv53wd/JFkXqC3yuN419jbrK/upFv8CmceBpqE6pfG192Df76wR9e1F+0ot+wd+PyztOgaL8xyFkxuN2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_06,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210260076
X-Proofpoint-ORIG-GUID: tYiB0DzwBa5Cu7bNwkULYTysWTTCkvmj
X-Proofpoint-GUID: tYiB0DzwBa5Cu7bNwkULYTysWTTCkvmj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 26, 2022, at 4:48 AM, Ondrej Valousek <ondrej.valousek.xm@renesas.=
com> wrote:
>=20
> Hi kernel maintainers,
>=20
> Please help to submit the following patch into kernel
> ---
> Signed-off-by: Ondrej Valousek <ondrej.valousek.xm@renesas.com>
> Short description:
>=20
> The XATTR_NAME_NFSV4_ACL definition is also useful for userspace (i.e. nf=
s4_acl_tools/libacl/coreutils) so makes a sense to move the definition to t=
he linux/xattr.h

Hey Ondrej!

Let's start by copying the correct maintainers for these files
so the patch gets proper review:

$ scripts/get_maintainer.pl include/uapi/linux/xattr.h
linux-kernel@vger.kernel.org (open list)
$ scripts/get_maintainer.pl fs/nfs/nfs4proc.c
Trond Myklebust <trond.myklebust@hammerspace.com> (maintainer:NFS, SUNRPC, =
AND LOCKD CLIENTS)
Anna Schumaker <anna@kernel.org> (maintainer:NFS, SUNRPC, AND LOCKD CLIENTS=
)
linux-nfs@vger.kernel.org (open list:NFS, SUNRPC, AND LOCKD CLIENTS)
linux-kernel@vger.kernel.org (open list)
$

Can you update the To/Cc and repost?


> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index e2efcd26336c..07c3d8572912 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -7680,8 +7680,6 @@ nfs4_release_lockowner(struct nfs_server *server, s=
truct nfs4_lock_state *lsp)
>        rpc_call_async(server->client, &msg, 0, &nfs4_release_lockowner_op=
s, data);
> }
>=20
> -#define XATTR_NAME_NFSV4_ACL "system.nfs4_acl"
> -
> static int nfs4_xattr_set_nfs4_acl(const struct xattr_handler *handler,
>                                   struct user_namespace *mnt_userns,
>                                   struct dentry *unused, struct inode *in=
ode,
> diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
> index 9463db2dfa9d..77eb8c885861 100644
> --- a/include/uapi/linux/xattr.h
> +++ b/include/uapi/linux/xattr.h
> @@ -81,5 +81,7 @@
> #define XATTR_POSIX_ACL_DEFAULT  "posix_acl_default"
> #define XATTR_NAME_POSIX_ACL_DEFAULT XATTR_SYSTEM_PREFIX XATTR_POSIX_ACL_=
DEFAULT
>=20
> +#define XATTR_NFSV4_ACL "nfs4_acl"
> +#define XATTR_NAME_NFSV4_ACL XATTR_SYSTEM_PREFIX XATTR_NFSV4_ACL
>=20
> #endif /* _UAPI_LINUX_XATTR_H */

--
Chuck Lever



