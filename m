Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F82601A24
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 22:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiJQU3P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 16:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiJQU1O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 16:27:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D05012D18
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 13:26:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJi488025283;
        Mon, 17 Oct 2022 20:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=VdxCfWPb1f5OwEuZTeW78Y9ei0wjNUONTBh5P80/C74=;
 b=1usa1kjshieXlE/UTPsimWaHnU+H+33BaFNjrs8Kboqv/0yAZmhH+fAo4ukCgwnLScvZ
 D0hUUv2xCbF0b4ThkJcsrBlSMa48G6aheIsavtzEvCGjwHQ+TrrjWaau6IEuBiCq/LxO
 tS/Ldb90BRdO0G9G1RZpgco7QAipg7pa22MfN/Wg8vN0S0cz02IilnAYuavfk1d4hBHj
 dFWIYAvnstirg2bW7QM8jOKGTa4HykNTPxWr68uMPwr7DrzvHiSC2eGl10iBy5mh7Ind
 Y4DlUYgUfGd0ws8tWdc4Ck2wA1xNhSaR7nA3cxs0QjJBR9FgmMl/VRrUxvc/pOfV34rP vA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9aww0jry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 20:25:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJaarj017276;
        Mon, 17 Oct 2022 20:25:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu6etqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 20:25:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUlk9OmzigCRk7+brp2CpFokOeAfw1DbSiWHv0mMNX6qz821OSAVF9N6qIvN5t2BYkNSh0HrVTF6SbVdIh6gR1mYFnjQ/irCSaHGbggZYEiwFdxQqfbpbisbHfmHaXe7Bh/V9EYCP00W939bCTKBmB7gEKgNLbXoBm9Byq+tToC/14lXKKRkyfIYp7WwzfqnHJORVDa7mXF8T6a9kvaTPNXmnsQrEyMRun8hippK1h6FFIMIhTrQnlFZFfNmRYvkZxOnQBel5TvGffOCFkNM3uRYUD2ZqaeFcSzPx06/bHFdsmjEpzf+uRLYBLxrfb2Te3p7Hc2zo03/CwxwRaYQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdxCfWPb1f5OwEuZTeW78Y9ei0wjNUONTBh5P80/C74=;
 b=ArWGWVOZCWqG+HPb8JgH7MtQNnn48VPdaSisBGsCq5ikn/LaamIBbTE23BgJkXquWC8mSLqK4Cyse3kbkdwF89xw+D+cbWkNCctonCzvURVXYh97NMsJeBFn44Hbl1cqzMb/+2dKAmDRXz2Z2DjEyDRCj9ftOSbsntirfk3pLRoJkHpliUOH6NakAtvme0VXVvwKc09zFcnWUtjg0g5P5tM7ANEvLlTuRDWmM/toTVZ9ny67jvX/PVbJsZG5PhCGxQV0xOP5Frm+vxOyCXcwgemWHBorzmXkRNRx8mVpNLIv3MH5a1iOYakUNTCMzwUPpgq+XvOTwYw7Pts+PN4f4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdxCfWPb1f5OwEuZTeW78Y9ei0wjNUONTBh5P80/C74=;
 b=lVTMZXdXSp6DsA6Go4sjWRifpMza62RbjF88zmggI8Cc8c7bOTGjN9MTtgMCI3r3FKbF4FgbCfh8B/riUxQHlpBmQ27kHuYVPUtvYJCSTY6m7V9ghRq0NkKeF4H5cTUkPS3XtpCqEnmXXnI/6SYofkecgWFyII1l/tGvmDwkV5I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4921.namprd10.prod.outlook.com (2603:10b6:610:c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 20:25:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%4]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 20:25:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] nfsd: allow disabling NFSv2 at compile time
Thread-Topic: [PATCH v2 2/2] nfsd: allow disabling NFSv2 at compile time
Thread-Index: AQHY4mUY7jHiOJ42ikuh5Uvd4y0Rpa4TCHAA
Date:   Mon, 17 Oct 2022 20:25:36 +0000
Message-ID: <0A1BE7DD-070F-4427-823A-92866DC7C9A9@oracle.com>
References: <20221017201436.487627-1-jlayton@kernel.org>
 <20221017201436.487627-2-jlayton@kernel.org>
In-Reply-To: <20221017201436.487627-2-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB4921:EE_
x-ms-office365-filtering-correlation-id: 0c1eb709-05bc-43a8-5948-08dab07dbff9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L3AVBanfdI1JCyNzOUlUSYRTWxsAk/XQd4sqe4AXJRUJ4E8vg1ICBryBIt8+J/FiYlO8s8hSfW/hCuqN4AJHS9Z88AwoQfhcbvDAv6IXi+kdBuuam3yYdLPAaEXCgq6xGzPbAXNg77tPeb73IDZgnCWb6HyGHiip/wcF6ZLxbztw4FbruSlRVEGyLEWV+jTU0v892f/sKMT8aC8yLKfOd3aSM5mgI+U3H5YnrDmUBm59qMtGUBU4qTB2OtWPu9/04mp76Iq5hgjoA8JQsgoZkLLtebqyF1ox120YXDNgX4/E9PNEkleDU8mU7ecVsaZUGdp5xtCFprVPxX2XMSe1+b9fpxd3oGSJ+8H77mVyql80JdFoflGP9beDVnRjMNj34lEMJncr00wRiXlnBcoWikmG2wyfmisp9yDXIUcUFrtLnzrs4FPtKLzbfbDsEv6EiSDQebToq7B4ArajZGshdzjAptjVfIYUlWWYVlQLSBbv4sbbEcNw5s53LTzGqu/ZMGHAxcPAkJCjn70D0vCd6jsl1vBjIWkEZtKrZsmHIOV7BsZoiw5d7b/02r4iAx/nsks3FZyrHvaCcyPVEjJVV6EmnHOIZ3jKd0hMKcZLqjxbjYbD9w0jxWMsjjwkZjwYjkm7dSrqe/9PzF43zx4XuF0kJMB8AFW9aygCJRpUUzp17yk7+lXsTMZEoz4XTE3ulSM6z/5wJu8T+rgr0ApPQAhAq7jH57TWrmPKvDxljfo+qnVsJUTBGEmnj1oEIS/GcR2Mr/KiXB6/W4xKiSMPeN2aynZcDVs4HO3W28NhIQo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199015)(478600001)(71200400001)(6486002)(6506007)(33656002)(66446008)(64756008)(66946007)(4326008)(8676002)(66476007)(316002)(6916009)(76116006)(36756003)(91956017)(41300700001)(66556008)(122000001)(38070700005)(186003)(38100700002)(2616005)(26005)(6512007)(53546011)(86362001)(83380400001)(5660300002)(2906002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WMb1RDBFxFRx8epGvRCKR8w4MTf4NwLW3gATjvR4E4zaOsefmunGKHQ5qYOa?=
 =?us-ascii?Q?Y6ED4CVn/HZzZseEti1j94CVRhr5d0Ezhxnske1wS/DVSX/1a2j9nFqzpQ72?=
 =?us-ascii?Q?6tbSNWT/Ow81gtRYMCpWOd/acEoNy2aQSm6tgqN0fKQ9Evv11JOfsU35oKrM?=
 =?us-ascii?Q?28dNRmtbOXJgfibQVBEeVC5OvM9x4WQg/s6116dofua+xF31GRUdgp+Bexz1?=
 =?us-ascii?Q?z5F2RyFQCD4APs9C/vfdYE3EU5feIA2qCBEoDcDAXWLZmhg5q2eNit9EDq0a?=
 =?us-ascii?Q?VUmfcixQ5sizeR+wguPSzjQZem2nTFRDKDMejruS9tBf8zbrib6HDSQ3ZuQT?=
 =?us-ascii?Q?UFUOW4NjttQQvOyNSlzX0dscUd6KT/3mPTMWB7naC+PrwHxs8Eztwi8uGTqW?=
 =?us-ascii?Q?nh+vWS8tG/E8DoSTJOYrCasUzTOYzFoHHdg4T2CDv0mfNUvYCmOkITbuzDlw?=
 =?us-ascii?Q?zThjWlNSM9mGtBcN3Vev/h84+P2AK/fyz54D1owNlPr0NcL7aXenRmYfC99R?=
 =?us-ascii?Q?/rRbvq1RwjDBZIr2TbLku9DQfBJRbU/zSmOQ16wRWf287r7dNw88m9FUd3NT?=
 =?us-ascii?Q?fcszywcDyC5d4LqfgaH17vBxnY7CZb3bYXriurqTizEOSp/ebqWCw1cLwQxT?=
 =?us-ascii?Q?A4QXIQ7+pvWkHWtceePbZVDCpK+XPHq1xuxtdLc4r6Uf9Yx1tFFXYioxA0sA?=
 =?us-ascii?Q?Sw60O08gP1eNvZPFyi023RvfMMgXoawoM4mL0fWoYb13WOh5zaMFgwmK76vw?=
 =?us-ascii?Q?zW0bsOG/HJeabmvi/OQYyvTsRFs8q+Df69j7DVM45aNVmoyx0JzDWQx7xDxK?=
 =?us-ascii?Q?YW+DekUkosSc54IgPfY+qRDKXrgDxSBv8F62hIIwrrdPQ8MCycNK/VoctVLn?=
 =?us-ascii?Q?2SW2umwe64iIRQqkPnHqMmwZKA/7dKfRKlrTbCufjVYVyfGDTbncoFpQsD3N?=
 =?us-ascii?Q?dDcFjd4RSUILfz9z0macw+OuaQVpnHs4QR62mqdcd6wAi3rokqzYdN7F246l?=
 =?us-ascii?Q?rPpda5mDFPAPy/vrLN2721yxG4aTXhk5t4mpxHjSM0IEICajN+PaKTeKvgsr?=
 =?us-ascii?Q?837EVUK1UURh5vxlWJfHbBsD02yFYcSQOIA40gRBBsnpRqWknevrQWqoKEH6?=
 =?us-ascii?Q?jof9m2GOH/Ub/+6Xgu6YUVxzqyMT/307fFyLXoDg6dgYthLwcmz1QArPTV+/?=
 =?us-ascii?Q?uOU8uC//gPPvWV0QlxlH7qFh9yHkJkH+zxuryb8X4pCk6d8H3JveZvIprqvw?=
 =?us-ascii?Q?mozAIRWXQqkDagfPmzny3INihWAWXdx+l9Q2r8FIJ8kN/KvhOFbTK6OSPO7V?=
 =?us-ascii?Q?MoZQ4T+3dZki+cZ4sn29b8qycHN6SrcWfYXKqr6+/LvIz8zHrQRa44s0LtPM?=
 =?us-ascii?Q?aRBCYkkd6NU0HdwBahniXeYDmQVcVCvwe7i5am+xK3TbDusBEyD2ljsmE/Xt?=
 =?us-ascii?Q?2J19w8K81cCD/fzZkC8P5nWNzGpX8XS6aBRc/3SjSR+J4LyegvmDUaOPzBOi?=
 =?us-ascii?Q?04UpoH0gqIk2N+Xdy3Oywd7lH8x2Ne2ZlIka0yZIxX2zHYRhu7BokMA+Rlon?=
 =?us-ascii?Q?N/VUdF2o2m23QiFQhwnWlQKgUiZPP6qxccJUy5qbxYNTjZWkVFzfECTH133G?=
 =?us-ascii?Q?VA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E717787DF4AEEE46AC71658811E2CA47@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1eb709-05bc-43a8-5948-08dab07dbff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 20:25:36.4223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hpcrM7YqSvSj5OnO3VezsJ8l/Y52EWgIhevkZYr/rnkenKP70mUTiXV/oUGiaO3hphtdggfhG+NA3p5cIg7vJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4921
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170117
X-Proofpoint-GUID: SASceCFdpp_ZgbNh8ZB-4OAvtYsRPbMU
X-Proofpoint-ORIG-GUID: SASceCFdpp_ZgbNh8ZB-4OAvtYsRPbMU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 17, 2022, at 4:14 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> rpc.nfsd stopped supporting NFSv2 a year ago. Take the next logical
> step toward deprecating it and allow NFSv2 support to be compiled out.
>=20
> Add a new CONFIG_NFSD_V2 option that can be turned off and rework the
> CONFIG_NFSD_V?_ACL option dependencies. Add a description that
> discourages enabling it.
>=20
> Also, change the description of CONFIG_NFSD to state that the always-on
> version is now 3 instead of 2.

This works for me. I'll wait for more comments, but I plan
to pull this into for-next soon.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/Kconfig  | 19 +++++++++++++++----
> fs/nfsd/Makefile |  5 +++--
> fs/nfsd/nfsd.h   |  3 +--
> fs/nfsd/nfssvc.c |  6 ++++++
> 4 files changed, 25 insertions(+), 8 deletions(-)
>=20
> v2: split out nfserrno move into separate patch
>    add help text to CONFIG_NFSD_V2 Kconfig option
>    don't error out in __write_versions
>=20
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index f6a2fd3015e7..7c441f2bd444 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -8,6 +8,7 @@ config NFSD
> 	select SUNRPC
> 	select EXPORTFS
> 	select NFS_ACL_SUPPORT if NFSD_V2_ACL
> +	select NFS_ACL_SUPPORT if NFSD_V3_ACL
> 	depends on MULTIUSER
> 	help
> 	  Choose Y here if you want to allow other computers to access
> @@ -26,19 +27,29 @@ config NFSD
>=20
> 	  Below you can choose which versions of the NFS protocol are
> 	  available to clients mounting the NFS server on this system.
> -	  Support for NFS version 2 (RFC 1094) is always available when
> +	  Support for NFS version 3 (RFC 1813) is always available when
> 	  CONFIG_NFSD is selected.
>=20
> 	  If unsure, say N.
>=20
> -config NFSD_V2_ACL
> -	bool
> +config NFSD_V2
> +	bool "NFS server support for NFS version 2 (DEPRECATED)"
> 	depends on NFSD
> +	default n
> +	help
> +	  NFSv2 (RFC 1094) was the first publicly-released version of NFS.
> +	  Unless you are hosting ancient (1990's era) NFS clients, you don't
> +	  need this.
> +
> +	  If unsure, say N.
> +
> +config NFSD_V2_ACL
> +	bool "NFS server support for the NFSv2 ACL protocol extension"
> +	depends on NFSD_V2
>=20
> config NFSD_V3_ACL
> 	bool "NFS server support for the NFSv3 ACL protocol extension"
> 	depends on NFSD
> -	select NFSD_V2_ACL
> 	help
> 	  Solaris NFS servers support an auxiliary NFSv3 ACL protocol that
> 	  never became an official part of the NFS version 3 protocol.
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index 805c06d5f1b4..6fffc8f03f74 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -10,9 +10,10 @@ obj-$(CONFIG_NFSD)	+=3D nfsd.o
> # this one should be compiled first, as the tracing macros can easily blo=
w up
> nfsd-y			+=3D trace.o
>=20
> -nfsd-y 			+=3D nfssvc.o nfsctl.o nfsproc.o nfsfh.o vfs.o \
> -			   export.o auth.o lockd.o nfscache.o nfsxdr.o \
> +nfsd-y 			+=3D nfssvc.o nfsctl.o nfsfh.o vfs.o \
> +			   export.o auth.o lockd.o nfscache.o \
> 			   stats.o filecache.o nfs3proc.o nfs3xdr.o
> +nfsd-$(CONFIG_NFSD_V2) +=3D nfsproc.o nfsxdr.o
> nfsd-$(CONFIG_NFSD_V2_ACL) +=3D nfs2acl.o
> nfsd-$(CONFIG_NFSD_V3_ACL) +=3D nfs3acl.o
> nfsd-$(CONFIG_NFSD_V4)	+=3D nfs4proc.o nfs4xdr.o nfs4state.o nfs4idmap.o =
\
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 09726c5b9a31..93b42ef9ed91 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -64,8 +64,7 @@ struct readdir_cd {
>=20
>=20
> extern struct svc_program	nfsd_program;
> -extern const struct svc_version	nfsd_version2, nfsd_version3,
> -				nfsd_version4;
> +extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_versi=
on4;
> extern struct mutex		nfsd_mutex;
> extern spinlock_t		nfsd_drc_lock;
> extern unsigned long		nfsd_drc_max_mem;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index bfbd9f672f59..62e473b0ca52 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -91,8 +91,12 @@ unsigned long	nfsd_drc_mem_used;
> #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> static struct svc_stat	nfsd_acl_svcstats;
> static const struct svc_version *nfsd_acl_version[] =3D {
> +# if defined(CONFIG_NFSD_V2_ACL)
> 	[2] =3D &nfsd_acl_version2,
> +# endif
> +# if defined(CONFIG_NFSD_V3_ACL)
> 	[3] =3D &nfsd_acl_version3,
> +# endif
> };
>=20
> #define NFSD_ACL_MINVERS            2
> @@ -116,7 +120,9 @@ static struct svc_stat	nfsd_acl_svcstats =3D {
> #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
>=20
> static const struct svc_version *nfsd_version[] =3D {
> +#if defined(CONFIG_NFSD_V2)
> 	[2] =3D &nfsd_version2,
> +#endif
> 	[3] =3D &nfsd_version3,
> #if defined(CONFIG_NFSD_V4)
> 	[4] =3D &nfsd_version4,
> --=20
> 2.37.3
>=20

--
Chuck Lever



