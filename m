Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDF075A2EB
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 01:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjGSXqT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jul 2023 19:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjGSXqR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jul 2023 19:46:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0AEE69
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 16:46:16 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFONNI005167;
        Wed, 19 Jul 2023 23:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aCPIOEKWwEvpWAlOAkt6q8rREYX+F3dIa7dm/att2Vo=;
 b=zpJpQ4FwDjcu0ak7nPGc3BP9zx+XGXEAI1SAkW7QB+N3cRV2Mvmn4DXXm1MycmzZlsbG
 q5Bz37os5/VFYVc8hrCY40lFNnc3esSnskOO/tov3LzPX0R5Jx0HmsLybnq6nkJqc1uV
 Jr5uAEAuaHM0uLmUynoFJQ4o3+5Pzg09z2ls2ZF81t7WPA+HOoQ7tMsdKzpVe99Zbryl
 sDozyxmKAvs7Bbbjy5a0LDTcPxut8qv7GSOQ1v/2fj9/BMHwyTT4hSzs5GEYwDp+2VWk
 trTii93FrMTBNPX03urUFfLrx67t32eiH0U+xA7nOs8MmM6oGaaKXsWvETFZwlVFV/5b 7Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a8nam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 23:46:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JNQcbw019173;
        Wed, 19 Jul 2023 23:46:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw86dmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 23:46:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8nQxfn7jToaCNiZXVwVttZCm3EY3k0LDOs9MR3zMPo0JTXcyJu2+ZD9mub/40qoX2yiP5QN7Ky2PxTzXxUcPwofBRpPNiraTk4jlE3OA71GV2OtWK1HxoXe4vHYWy4Wt3o1WhXmriZrJ7RAxDF7LMCgSgyIZLrJDW6jLBImEijaAGBccZ6BW95BZ4Yn/VDh4VS61pKf570P+mU9igIQ8yxqGsvLi43/U5IR4gj4BdWe/EJVFU8cEFeVJJEs62gixP+EGZR7TLpLp5HwgswQKjX0tgb0mkof7FCOosUHnE+yiTynyZ03zN8hlxKwGYT61fIwitghQ2dlruhiEmTGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCPIOEKWwEvpWAlOAkt6q8rREYX+F3dIa7dm/att2Vo=;
 b=To+S6ok+lY+GH7nNP/Q8dE9NDdPzufsCUh8xn7yi7I3/ZJ84F9PLOEtAMtA2ohEN0Irl8AESRTeuSzrhTGU639CCu1QYKiOM5zs87nVh520T9xbGENwjCLwbNm+rpsrZx/GMQf6ZHi8BO3At89953QCpR7XGbRJ5xXY9REv75H/w5B+VSCToAXyGlug2tyDRY7p+SYwoHoS9aZIZNVUGZJmCs9QJHrI+9YMUWsqi7L8FZ4LBEVnfuwBNjl8gByq8s8b1ByX9IcPpeAiiOoJrzEtr5JqFFbEDwZJTRejaXA2/GB5YVdZoIFClU0+kVTOOOl06ZC8H6hPeogOAC7c9nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCPIOEKWwEvpWAlOAkt6q8rREYX+F3dIa7dm/att2Vo=;
 b=G9WTIwNGDCX+Zl3LM+vBtQPU4s4fUQq7m1DT5UX3NRtXgCeHWOQMDBnpc9qSNCLgiziHTYQk1E6J4I3jPYid6ld+DfuU0CC5OiW0oWGZVG0vl76IKrCyLYAvs/HF0pJkN6UY9FxWcj8x8K32M98gsA4IxBshSkp+hXnujESnlg8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6676.namprd10.prod.outlook.com (2603:10b6:510:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 23:46:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.025; Wed, 19 Jul 2023
 23:46:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: oops in nfsd-next branch
Thread-Topic: oops in nfsd-next branch
Thread-Index: AQHZuorXdNBxFgcDg0qLkVfZ1Dwbh6/BwUCA
Date:   Wed, 19 Jul 2023 23:46:09 +0000
Message-ID: <E9A71D57-83DE-4E04-8CB8-073244B88392@oracle.com>
References: <554d3bcc05c2e1e3624607c9fa543d6aea4cfadb.camel@kernel.org>
In-Reply-To: <554d3bcc05c2e1e3624607c9fa543d6aea4cfadb.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6676:EE_
x-ms-office365-filtering-correlation-id: 6614bb21-6fc3-4295-efcb-08db88b253ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Zj4ssAo1HuMVb7kc4S8fEqohSC3TCpYxaKukSqehAn293H6mCLK5BqaRHrCzCBIGHofbWOM5ENgAYlzBA9kPEG+XfHFhhhJW4IrfNQCzjy6gv+lFkRVnIufpczMQotEkqLgKdTbF/JWpv/tENgGStqNUiG1FvejeOy+5W9fSQYgmwW9IXnbX2K8KXsa+QUbZYy6zs4XKHaYLsx73Ysr2mPpebeBHObIxYSDuZbgQ4nBiELtufHNbj1OCvyE089mvVYx88A+bmyqTuBBPwgUJHkEQrxB16cWlONp9TN7xyU2MBUYW8rbEu7jGm2EaSb1sVNxuDDfrgcxBETzfGMwCO7ao7X03II4pC6C8EPZRpXcVtinDHqwCnDuXTK1OJ28K1/Xd3aBg4Mbh+efdE9zaDrIf6T698OJGpBeybW8KO/8p3CRSon+RX0OWgKl8oGO3C6p6biFpAHRNn8SysZWuPW8lNT+d7xlx43Uo463hulSYNadOsmY6f3zWduTsv2fjWcGPBnUkTW0Gu/SoRbPjt+laiiU3BsthCDEJEp+26+97DvUlaR3/nPU3mmMRSzs+L789le5KbaQCT627quGgZHZj/ZQtVZxP+jHVY48e9NVVKBwCqlk0fqpzJCzaPYzO5s3HOB20ZCmYi5x75Pp3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199021)(122000001)(91956017)(71200400001)(6486002)(45080400002)(478600001)(33656002)(38070700005)(36756003)(8676002)(5660300002)(8936002)(2906002)(86362001)(6916009)(4326008)(66556008)(38100700002)(64756008)(76116006)(66946007)(66446008)(66476007)(53546011)(41300700001)(2616005)(6506007)(316002)(26005)(186003)(83380400001)(6512007)(3480700007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1nfwFfPDGI17ZlXLfDa95I1NTgK6JyRzPzDjcz3QxTALzgSJfMWfjQ1ktAsW?=
 =?us-ascii?Q?QMRk1KTY5nRE6GoBucIH6dlOcnVX3I/Ihw/usNir6ERD24xA2eIm7FzEwGzE?=
 =?us-ascii?Q?aWvNLH7LVDx72MNVC1C754TYyIX4T7eJ8FOXZyLdVNGWoioIpXSCYzhDv49c?=
 =?us-ascii?Q?t4L0Pd/+8A3ZIyUOOkhjpaxwefU6f90tI3/BoPrLzmyA5bgn8LGM2ZWF9aXF?=
 =?us-ascii?Q?4U96zPGLrNNNPxuQH7Pj8XOHHLTRp4gu0hAyp068EI7dJe9SqSfcxjnylikb?=
 =?us-ascii?Q?8gLRKqWaRD1j6uM8+BhjQAY7BldL0CRsm9W9u20immj3ZSOZ1XIfuB0viJ7L?=
 =?us-ascii?Q?iCXiXzmoHnZjxUdYOThX7zexlipOf1Tvtag9fRyfNPKv6a07VkR1+WZZS1vE?=
 =?us-ascii?Q?mcEMJsySgdgfVPwO1qapzdHFSZe+c+Ex7E1ihGtTMfdgnHpxf4+vKva2i4Cc?=
 =?us-ascii?Q?X3B2v0rschmUslFPpNK2PRP+X9rbpCk5VLXT+ibGkVc4fnq0ZH3B4bE0SzER?=
 =?us-ascii?Q?n850qqfwqsD9vOwYbRehg7UxXRaI3j0+I3qP7HKCD6ujo4v8+5p7o/w+XL6+?=
 =?us-ascii?Q?1HzN5KizwRCZQ3Lv/n+lI0mmDiEn6vgOhU0Qva/+n9meiR/0XuPQThAQDqTb?=
 =?us-ascii?Q?40PNPP/pLkIMBz7oznIbruaq1jEqmwfrJO+B6fgAOl+rTtbfKSp6WWlr+wGX?=
 =?us-ascii?Q?MKguGRsbm6k03Sz6U3n1XWx+NeddBVclFru/9/6hL69StcN8jZtAyV64YkrG?=
 =?us-ascii?Q?C2wxtLTxfOU0/6madzJhuLLa36oI3C9G9eIQYANw3/JYTaFrpNjJrM0kayo7?=
 =?us-ascii?Q?yrfoEYOzjJ2OSPOTskle2yYbNtdZevy8CUyKR2rJZzTZWJ9+sL9SWZ8mBUhj?=
 =?us-ascii?Q?q3uB+KpVxERvrwPSIcIvpQ1wTUw5X65QVnlvT9VS64+hEMDpPjBXjCEKm3KX?=
 =?us-ascii?Q?63be1wiMliiwB3/u+H7xVoCYCB635uM5+MyEyQav2P+tK7DMj/2ijB+zH5lO?=
 =?us-ascii?Q?TRi9pu5WvDVD/i0A7qEqYipu6OsPyWGuZcS+lmZURKUTRVwT7YHoFOR0xdly?=
 =?us-ascii?Q?/2S2PQceptuth4uPoB/uz9MRwENQm+ExoJL685pEuTlp4CFp1c+zZ4WIFzk3?=
 =?us-ascii?Q?nFphy9tFIluf7D3/UaMJ3laac8v6DN98M00+Crd6xCulttkCGhZMSwQlJB0H?=
 =?us-ascii?Q?w9Uii3m8XEEJt/Qv/8Ni7mO3C0ZDFmH3Utns+nOR52+gW5XFEr664jTwXANB?=
 =?us-ascii?Q?jWkvTySUY2MSts/3HzFg/3sYSF03qOgDZHfzEl7vizCgeownYBfIOqX2cM4N?=
 =?us-ascii?Q?iqj8RHSHCSjk8QnTqKsBNJVEAV1bXMPBhqB1e2zAbjpLYikszlNxIhBY93nk?=
 =?us-ascii?Q?5P7vgbzv8KM9ifKjnFZt/XZe8xRN5z/lVPYhp+wdhsjxCqLzIwerz3ZnH7kg?=
 =?us-ascii?Q?d98bx7Vd265ljFuTaOxYDM9xcjAJq/7NokP+xLk+0zwsiou5u5rpVlT7x0Jc?=
 =?us-ascii?Q?lcR/SZaO7RJND59OCc9j12j0YqbaaL5bsTvaHGEiAx2k8gg1lYlehkhZxWP2?=
 =?us-ascii?Q?yYbnAciKs/Y9DxEEmF97GvfnpjaY+Ebaeacf4OkPiSfciU94vaskxgqiQtn4?=
 =?us-ascii?Q?zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <162680E54571D944875A4A2FBCBDBEEC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vqys5c5u5J+zfzoFlFTLlENriY7fV806ejWcHYEm2GITwN9zH5XloVj376sVQoemzXmZ5tm6eNVfVVYttvrmHbseSJGVw9wYj6Qz6frZBvi7O53qQX8dt0ShMADljcCGzzY9kQ4rerrpiyy50AyoMKXNox+dMZD2VIBmAS7bc0h4XSAPh7ZO3d//LYRhJs6K6PjhJPLHYqcONmgGVdpZ71+ZHZBJDgiyAJD7g1m1OCBUnc9+CfOiL263771IMPJ/UKT6RsUs6gqrCRr08lB2U+hn4eRnl10dPdLwlWVr7NDA0yIuRfDhmuuw4Ulose9kGvpF2Ln2dT6G7zjDIomkPaCUwIZNjM4eVl43JXvOnFTFYDKHtctyestPp76+rGdQDxWd7R7yT4/9+bJYJKI1QO+VLyyLDd6mtO6vh/mIBYdftRFQZyK1XuuAyNsTMx8v4fMzOzPlPBfGtKSmRnrmC54ewWLykdbGIu3fNMSHRO+zcHxeT28z5G6BQkQRsaCnJjmnFL0wXAzm0i9Ez12TI0ff/TH7Kx2s53Yk30205k6izh5laKuWSaa7WdvOuK2jPKGeZtuYhYEinhTGBbxOAVeElut+eFwlbPHV7FKUurBzc4TxXpqUs14jtB0u5hNUnnVHCvuo9fSILVdUeiuRsD2UOhollIwa2WyaVEIRuBonpVNu7qy2qMLPxXcgHYsQ1jUo3zKwW65sXFAe6OKipVAmwDNuckMkFg1TtG41XVMzDHnVflf7ECpozdVmrosKf+ul3HwWm7n7kvUDerOJsRQinLkTgVbeRZL8KLLk/YI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6614bb21-6fc3-4295-efcb-08db88b253ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 23:46:09.4347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y0Qb7pLi7nQeubRcAkmGDOjkjP2JXTM+4W9SfnmorjSLEVLRWSmIKS+T1FT+3umQwRzuUsGhzmAdymE+PZj5Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190214
X-Proofpoint-ORIG-GUID: P7EIZeMPasgWpQICz0-ykVO4nRA6xBec
X-Proofpoint-GUID: P7EIZeMPasgWpQICz0-ykVO4nRA6xBec
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 19, 2023, at 5:48 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> Hi Chuck,
>=20
> While doing some testing today with pynfs on a branch based on your
> nfsd-next branch. I'm not sure which test triggers it, but it's one of
> the v4.0 tests.

I've just started running pynfs on nfsd-next, haven't seen any
crashes so far. I'll take a dive in tomorrow.


> It only takes a few mins before it crashes:
>=20
> Jul 19 19:22:43 kdevops-nfsd kernel: BUG: unable to handle page fault for=
 address: ffffd8442d049108
> Jul 19 19:22:43 kdevops-nfsd kernel: #PF: supervisor read access in kerne=
l mode
> Jul 19 19:22:43 kdevops-nfsd kernel: #PF: error_code(0x0000) - not-presen=
t page
> Jul 19 19:22:43 kdevops-nfsd kernel: PGD 0 P4D 0=20
> Jul 19 19:22:43 kdevops-nfsd kernel: Oops: 0000 [#1] PREEMPT SMP PTI
> Jul 19 19:22:43 kdevops-nfsd kernel: CPU: 0 PID: 743 Comm: nfsd Not taint=
ed 6.5.0-rc2+ #19
> Jul 19 19:22:43 kdevops-nfsd kernel: Hardware name: QEMU Standard PC (Q35=
 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
> Jul 19 19:22:43 kdevops-nfsd kernel: RIP: 0010:kfree+0x4b/0x110
> Jul 19 19:22:43 kdevops-nfsd kernel: Code: 80 48 01 d8 0f 82 d8 00 00 00 =
48 c7 c2 00 00 00 80 48 2b 15 9f d7 fb 00 48 01 d0 48 c1 e8 0c 48 c1 e0 06 =
48 03 05 7d d7 fb 00 <48> 8b 50 08 48 89 c7 f6 c2 01 0f 85 9f 00 00 >
> Jul 19 19:22:43 kdevops-nfsd kernel: RSP: 0018:ffffb0858661bdc0 EFLAGS: 0=
0010286
> Jul 19 19:22:43 kdevops-nfsd kernel: RAX: ffffd8442d049100 RBX: 000000008=
1244052 RCX: ffff8a665e003008
> Jul 19 19:22:43 kdevops-nfsd kernel: RDX: 0000759a40000000 RSI: ffffffffc=
0b13a45 RDI: 0000000081244052
> Jul 19 19:22:43 kdevops-nfsd kernel: RBP: ffffb0858661be40 R08: ffff8a665=
e003008 R09: ffffffff8ebdc4ec
> Jul 19 19:22:43 kdevops-nfsd kernel: R10: 000000000000000e R11: 000000000=
000001b R12: ffff8a6656f20150
> Jul 19 19:22:43 kdevops-nfsd kernel: R13: ffff8a665e003008 R14: ffff8a665=
6f20100 R15: ffff8a6656f20980
> Jul 19 19:22:43 kdevops-nfsd kernel: FS:  0000000000000000(0000) GS:ffff8=
a67bfc00000(0000) knlGS:0000000000000000
> Jul 19 19:22:43 kdevops-nfsd kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000=
0000080050033
> Jul 19 19:22:43 kdevops-nfsd kernel: CR2: ffffd8442d049108 CR3: 000000027=
7e1a001 CR4: 0000000000060ef0
> Jul 19 19:22:43 kdevops-nfsd kernel: Call Trace:
> Jul 19 19:22:43 kdevops-nfsd kernel:  <TASK>
> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __die+0x1f/0x70
> Jul 19 19:22:43 kdevops-nfsd kernel:  ? page_fault_oops+0x159/0x450
> Jul 19 19:22:43 kdevops-nfsd kernel:  ? fixup_exception+0x22/0x310
> Jul 19 19:22:43 kdevops-nfsd kernel:  ? exc_page_fault+0x157/0x180
> Jul 19 19:22:43 kdevops-nfsd kernel:  ? asm_exc_page_fault+0x22/0x30
> Jul 19 19:22:43 kdevops-nfsd kernel:  ? nfsd_cache_lookup+0x3c5/0x770 [nf=
sd]
> Jul 19 19:22:43 kdevops-nfsd kernel:  ? kfree+0x4b/0x110
> Jul 19 19:22:43 kdevops-nfsd kernel:  nfsd_cache_lookup+0x3c5/0x770 [nfsd=
]
> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
> Jul 19 19:22:43 kdevops-nfsd kernel:  nfsd_dispatch+0x62/0x1b0 [nfsd]
> Jul 19 19:22:43 kdevops-nfsd kernel:  svc_process_common+0x3cb/0x6c0 [sun=
rpc]
> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_nfsd_dispatch+0x10/0x10 [nf=
sd]
> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
> Jul 19 19:22:43 kdevops-nfsd kernel:  svc_process+0x12d/0x170 [sunrpc]
> Jul 19 19:22:43 kdevops-nfsd kernel:  nfsd+0xd5/0x1a0 [nfsd]
> Jul 19 19:22:43 kdevops-nfsd kernel:  kthread+0xf3/0x120
> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_kthread+0x10/0x10
> Jul 19 19:22:43 kdevops-nfsd kernel:  ret_from_fork+0x30/0x50
> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_kthread+0x10/0x10
> Jul 19 19:22:43 kdevops-nfsd kernel:  ret_from_fork_asm+0x1b/0x30
> Jul 19 19:22:43 kdevops-nfsd kernel: RIP: 0000:0x0
> Jul 19 19:22:43 kdevops-nfsd kernel: Code: Unable to access opcode bytes =
at 0xffffffffffffffd6.
> Jul 19 19:22:43 kdevops-nfsd kernel: RSP: 0000:0000000000000000 EFLAGS: 0=
0000000 ORIG_RAX: 0000000000000000
> Jul 19 19:22:43 kdevops-nfsd kernel: RAX: 0000000000000000 RBX: 000000000=
0000000 RCX: 0000000000000000
> Jul 19 19:22:43 kdevops-nfsd kernel: RDX: 0000000000000000 RSI: 000000000=
0000000 RDI: 0000000000000000
> Jul 19 19:22:43 kdevops-nfsd kernel: RBP: 0000000000000000 R08: 000000000=
0000000 R09: 0000000000000000
> Jul 19 19:22:43 kdevops-nfsd kernel: R10: 0000000000000000 R11: 000000000=
0000000 R12: 0000000000000000
> Jul 19 19:22:43 kdevops-nfsd kernel: R13: 0000000000000000 R14: 000000000=
0000000 R15: 0000000000000000
> Jul 19 19:22:43 kdevops-nfsd kernel:  </TASK>
> Jul 19 19:22:43 kdevops-nfsd kernel: Modules linked in: 9p netfs nls_iso8=
859_1 nls_cp437 vfat fat kvm_intel joydev kvm cirrus psmouse drm_shmem_help=
er irqbypass pcspkr virtio_net net_failover failover virtio_balloon >
> Jul 19 19:22:43 kdevops-nfsd kernel: CR2: ffffd8442d049108
> Jul 19 19:22:43 kdevops-nfsd kernel: ---[ end trace 0000000000000000 ]---
> Jul 19 19:22:43 kdevops-nfsd kernel: RIP: 0010:kfree+0x4b/0x110
> Jul 19 19:22:43 kdevops-nfsd kernel: Code: 80 48 01 d8 0f 82 d8 00 00 00 =
48 c7 c2 00 00 00 80 48 2b 15 9f d7 fb 00 48 01 d0 48 c1 e8 0c 48 c1 e0 06 =
48 03 05 7d d7 fb 00 <48> 8b 50 08 48 89 c7 f6 c2 01 0f 85 9f 00 00 >
> Jul 19 19:22:43 kdevops-nfsd kernel: RSP: 0018:ffffb0858661bdc0 EFLAGS: 0=
0010286
> Jul 19 19:22:43 kdevops-nfsd kernel: RAX: ffffd8442d049100 RBX: 000000008=
1244052 RCX: ffff8a665e003008
> Jul 19 19:22:43 kdevops-nfsd kernel: RDX: 0000759a40000000 RSI: ffffffffc=
0b13a45 RDI: 0000000081244052
> Jul 19 19:22:43 kdevops-nfsd kernel: RBP: ffffb0858661be40 R08: ffff8a665=
e003008 R09: ffffffff8ebdc4ec
> Jul 19 19:22:43 kdevops-nfsd kernel: R10: 000000000000000e R11: 000000000=
000001b R12: ffff8a6656f20150
> Jul 19 19:22:43 kdevops-nfsd kernel: R13: ffff8a665e003008 R14: ffff8a665=
6f20100 R15: ffff8a6656f20980
> Jul 19 19:22:43 kdevops-nfsd kernel: FS:  0000000000000000(0000) GS:ffff8=
a67bfc00000(0000) knlGS:0000000000000000
> Jul 19 19:22:43 kdevops-nfsd kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000=
0000080050033
> Jul 19 19:22:43 kdevops-nfsd kernel: CR2: ffffffffffffffd6 CR3: 000000027=
7e1a001 CR4: 0000000000060ef0
> Jul 19 19:22:43 kdevops-nfsd kernel: note: nfsd[743] exited with irqs dis=
abled
> Jul 19 19:22:43 kdevops-nfsd kernel: note: nfsd[743] exited with preempt_=
count 1
>=20
> faddr2line says:
>=20
> $ ./scripts/faddr2line --list fs/nfsd/nfsd.ko nfsd_cache_lookup+0x3c5/0x7=
70
> nfsd_cacherep_free at /home/jlayton/git/kdevops/linux/fs/nfsd/nfscache.c:=
116
> 111 }
> 112=20
> 113 static void nfsd_cacherep_free(struct nfsd_cacherep *rp)
> 114 {
> 115 kfree(rp->c_replvec.iov_base);
>> 116< kmem_cache_free(drc_slab, rp);
> 117 }
> 118=20
> 119 static unsigned long
> 120 nfsd_cacherep_dispose(struct list_head *dispose)
> 121 {
>=20
> (inlined by) nfsd_reply_cache_free_locked at /home/jlayton/git/kdevops/li=
nux/fs/nfsd/nfscache.c:153
> 148 static void
> 149 nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct nfsd_c=
acherep *rp,
> 150 struct nfsd_net *nn)
> 151 {
> 152 nfsd_cacherep_unlink_locked(nn, b, rp);
>> 153< nfsd_cacherep_free(rp);
> 154 }
> 155=20
> 156 static void
> 157 nfsd_reply_cache_free(struct nfsd_drc_bucket *b, struct nfsd_cacherep=
 *rp,
> 158 struct nfsd_net *nn)
>=20
> (inlined by) nfsd_cache_lookup at /home/jlayton/git/kdevops/linux/fs/nfsd=
/nfscache.c:527
> 522 nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
> 523 goto out;
> 524=20
> 525 found_entry:
> 526 /* We found a matching entry which is either in progress or done. */
>> 527< nfsd_reply_cache_free_locked(NULL, rp, nn);
> 528 nfsd_stats_rc_hits_inc();
> 529 rtn =3D RC_DROPIT;
> 530 rp =3D found;
> 531=20
> 532 /* Request being processed */
>=20
>=20
> ...and a bisect landed here:
>=20
>=20
> 767b1d5badd6eb418e3f91f0cd8fa6d2894ff43a is the first bad commit
> commit 767b1d5badd6eb418e3f91f0cd8fa6d2894ff43a
> Author: Chuck Lever <chuck.lever@oracle.com>
> Date:   Sun Jul 9 11:45:16 2023 -0400
>=20
>    NFSD: Refactor nfsd_reply_cache_free_locked()
>=20
>    To reduce contention on the bucket locks, we must avoid calling
>    kfree() while each bucket lock is held.
>=20
>    Start by refactoring nfsd_reply_cache_free_locked() into a helper
>    that removes an entry from the bucket (and must therefore run under
>    the lock) and a second helper that frees the entry (which does not
>    need to hold the lock).
>=20
>    For readability, rename the helpers nfsd_cacherep_<verb>.
>=20
>    Reviewed-by: Jeff Layton <jlayton@kernel.org>
>    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>=20
> fs/nfsd/nfscache.c | 26 +++++++++++++++++++-------
> 1 file changed, 19 insertions(+), 7 deletions(-)
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever


