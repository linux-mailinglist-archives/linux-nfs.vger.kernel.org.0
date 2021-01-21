Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B7E2FF900
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 00:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbhAUXkL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 18:40:11 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42566 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbhAUXkK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 18:40:10 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LNU5kH037530;
        Thu, 21 Jan 2021 23:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=LAgUcLRpMdDPbL8FY0uMnR5BX3BMvKrR1oWaflQy7rs=;
 b=Qi8CyzOepZdaZ//COHIr8lBBtxrXrzpoNJZXh7Lc1sDB4GNU14Wzg6U8ynx6Z3Djhh0u
 i1LRCj/21yYde3YWQXNP/r/MXYUg42WVEH+ZOfNiAHLqMNj3K5uTp7/yoYZT6wJrPZqu
 4lP7NDFoYMHCW31aGKEZgx7lPo1uOdMCT+FfFm3JJ8RqIFgAr5eXRvJVVkyr7zfi2uyo
 DDOdtIsvFCtlGHon1mGEDFPV0VIs3F1oUVeG5C1bIXrdhyURoAByMe8j6Ro/77OAkqj8
 Rctv1z6l1m96Sc6hWAdl50VnzewXv9qTVzAnTWLz40+EZoLcMoL0szQEF5+C1LlZoB0p +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3668qahu55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 23:39:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LNUmCi163727;
        Thu, 21 Jan 2021 23:39:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3030.oracle.com with ESMTP id 3668qxuufr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 23:39:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfUKMXrC+xTXVhJOyibfAcOU+/pCICBe5fkK2Gnya3iBwnCmze4EpIdSJzDuoS+dvPxOGUM8d7qizrjDvOXCyfBaaUisBlEo8gjsMOvqExc3mr7flqDNahDt3P6y3d5Qo3bRwr0eAih1J+2PaUoZBoedyVa+cQFqI22NdS61rVi+UKJRf5pk+GbFOjjv9pjf2vIEgZ9Q3EmJ4aOrwID2XEdlFRsQRnc9i6v+W43D+DVTBnTxfndof8PugHONlNgl0tvRBYvWjRk9iSH5b69TAkVMonGJQ6rWl/1y6f5nPKJYAg9GuJtB/KGkXE+YMKllpaOu+k9qeG1UtRpcFYj9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAgUcLRpMdDPbL8FY0uMnR5BX3BMvKrR1oWaflQy7rs=;
 b=CgCYkbfRY7J/desh1iMVtlGEX8mgGiT+D3w70vI6ueFBp6U3wmE1axSHcwg4J1LTrabXU9rFLgTn2M/EJqnEFs7CqY4Okf3KxjlaQE1XwmC+nSy+fRF4AnqhlMuQEUgdgkmghfrK6VLpVwHxtaZtoiQYkZEQ4AA+XtiQ5EeR4QUGCY3fTvtrPjqsjBe//MCh0pO1RvLuVQV5/eyIiwT4l3XQlPqLz3Tfcx8yKeH/eDFkHC1NgfNBewOB/w6jv3PhwLG8swXepIsR9v6Y4K6wLQ8ketcwDRT/NoV+I2gP5FoJsZeAAeHRS0HNI8Y0WGFJr+sJHDffVWCWYNEWcaWtcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAgUcLRpMdDPbL8FY0uMnR5BX3BMvKrR1oWaflQy7rs=;
 b=BXwMdfuUjIC5LLmBuD5zs9MLs/CLEtypnAa7aift3mGqReE0ICMnCndIhm+5QCQL0h7XggQC0z6VGdEx9F/Yb7x+Eb+13+4K0UyuxcuI0+CWUKL8MMNy01Y8H8SmaHBgXOy+CU56Q/cXW64yd9RWtQnnEor32zDiX+CfXCpHbS4=
Received: from CO1PR10MB4673.namprd10.prod.outlook.com (2603:10b6:303:91::8)
 by CO1PR10MB4785.namprd10.prod.outlook.com (2603:10b6:303:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Thu, 21 Jan
 2021 23:39:20 +0000
Received: from CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::dc95:1194:d2b5:b147]) by CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::dc95:1194:d2b5:b147%7]) with mapi id 15.20.3784.014; Thu, 21 Jan 2021
 23:39:20 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Improvements to nfsd stats
Thread-Topic: [PATCH v2 0/3] Improvements to nfsd stats
Thread-Index: AQHW8E6jQKH16/IcOkKtBMC8P9RYJA==
Date:   Thu, 21 Jan 2021 23:39:20 +0000
Message-ID: <1FD02545-2449-4CA5-B408-957495138CE6@oracle.com>
References: <20210106075236.4184-1-amir73il@gmail.com>
In-Reply-To: <20210106075236.4184-1-amir73il@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8870e233-e230-40fd-b9a8-08d8be65c671
x-ms-traffictypediagnostic: CO1PR10MB4785:
x-microsoft-antispam-prvs: <CO1PR10MB478517696F49FC06F02CD40893A19@CO1PR10MB4785.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +R0LFvTXXVtEH8xKjjFR2NgHBTQr0n3gOgYnPB9b8csRNCmDcylXl7ZSynDrQVdCPcC5gp/Ai7mpdoOFm+o0KLUzX1q4jH+8XEXPdQXiRPNAhWlFfxcW1MiPjHPAsVS5XFdmzVESZanwom23/skbm+QbQfDD5C2O+qq60749u12n2paWZLGj1mW3DZtLzBE08FeNofsD6Az0qQIJSeH+TUX8y6VtQmCmy/qlsV4G+GTjQYFWi77xdAn0IARBkS6fhRzryrlxLA81kXOQpyKkiDZEspyWKCB4HXIwvhYzZRnz7HAjIfoPOxQ8rj8nqjtgx+ba1ngCGGj78wKMhMH+ZGxJmgo0k6zLhUbQCDkN96gQBzjEfGsfp1bFa60vGwYzCn9E5eGguhReMgYDUJEhSyiPsRvdBfw47gkg86H9eTijgdGgwyDW6ETBRSQVyIlu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4673.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(346002)(366004)(396003)(316002)(83380400001)(91956017)(6916009)(2616005)(54906003)(76116006)(66946007)(5660300002)(66476007)(36756003)(66556008)(33656002)(66446008)(186003)(71200400001)(53546011)(2906002)(8936002)(26005)(6506007)(4326008)(86362001)(44832011)(8676002)(64756008)(6512007)(6486002)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mgcpHG/RIdshfY/thcWZdxQzEtwQ0MJlow376hxyPSgpUmUedGsuOjJ236Wj?=
 =?us-ascii?Q?s0k9k1kfkaG1TGVGH8BvXwYltkzbbyLewjMG16UanXwLlabtkrPDS+DZRqGe?=
 =?us-ascii?Q?qmJvnxVTLYGaTvBtSnrgS5yKjING3txwr/brcnlNXPkf4unbKDfQo1NcXOOt?=
 =?us-ascii?Q?akFnErbzNs614T+F360MBg43Vg6lQ8ut7MUld7WSAFuXIHe0hNHh5nSxJ95G?=
 =?us-ascii?Q?H+k0ooi1AAUY4lx3ncguS8XRkoS8FbnswZTVJYHFTpd3n5CSnyWm6ipo9nTj?=
 =?us-ascii?Q?HNpGT8aG3iNb1OOwz9UpZxYxsNCMZO2UNbG7/ALX0hwCrytWcScbRmcSH+YY?=
 =?us-ascii?Q?SlfwTRP5NIawudfpSQ1085ROh003KNPy1Wo6cou2D8ZUqSTTZYCmyBpHp5Ov?=
 =?us-ascii?Q?fZaBHAgbfj84nHFhMxtKnT/y6YTROCMI8O9cWdW/caWgC+ROlc+yodjW+xce?=
 =?us-ascii?Q?0lS4KKWtmTK9qeP1jOU8lJ83ah+XX+Q1eRiyivRRAV8BlmvXTRcGQIuPikz7?=
 =?us-ascii?Q?O1pzKtEk4IqaNIiq5wo6zaBP0l2Wyk6t+yuaYjqBbbzc/CrjNDpFDFDojk+v?=
 =?us-ascii?Q?4hEAlIJyZZwOwXO5PN8Y4MfIIAuPmQZeK7KbVixDs7ra7vrQX3G0McIAQyMy?=
 =?us-ascii?Q?sJuVm6gzC3Bn0pQds0xqRUgtnK2q9BnDEEFZ9+R5AXVqzfao6O60c4ZgS2a1?=
 =?us-ascii?Q?YGWCqVNdUdO5Gtkc6JFZFu4K6UzthkoT0g9ydiRZQwO3Fhzqk4n+nAJwnelD?=
 =?us-ascii?Q?cKyhz7ukD7DNc8wYSc4AcVtl8Wth5bEksRveI+pLWi6MkO3VJiiFmSYaPmCA?=
 =?us-ascii?Q?4M4ux+lME1bi8a16/EsnWpa7PLD+LszLz0tuPt5Zs6frDY4yIQ6Ljjbwk/cU?=
 =?us-ascii?Q?hZ7RvxeXTG1ocj37d6k5TQc8x9UAd01rX/ZeTbTG1LUa/UrB9gkCEsfUWK9e?=
 =?us-ascii?Q?2ejhj8Co3eUPwvlsPWiDE45xRyTG02zas13dbgpk3NNmTlTZA2Ilx+ECA0Hb?=
 =?us-ascii?Q?g+Ok?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E79579C1DC568248AE7BA5E506E22553@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4673.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8870e233-e230-40fd-b9a8-08d8be65c671
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 23:39:20.2365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: juDtTFNJNMXkrn377FlLn8gcaC2X2okKeeHzKzeVjWRhfOjox95unan5vcORsaB1C+2xuSrkCG7zcWFVwlEDFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4785
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=590 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210117
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=834
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210117
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Amir!

> On Jan 6, 2021, at 2:52 AM, Amir Goldstein <amir73il@gmail.com> wrote:
>=20
> Hi Bruce,
>=20
> Per your request, I added a cleanup patch for unused counter.
>=20
> Replaced the hacky counters array "union" with proper array
> and added helpers to update the counters to avoid human mistakes
> related to counter indices.

Thanks for your patches. v2 of your series has been committed
to the for-next branch at

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

in preparation for the v5.12 merge window.


> Thanks,
> Amir.
>=20
> Changes since v1:
> - Cleanup unused stats counters (Bruce)
> - Replace counters array hack with proper array (Chuck)
> - Helpers to update both global and per-export stats
>=20
> Amir Goldstein (3):
>  nfsd: remove unused stats counters
>  nfsd: protect concurrent access to nfsd stats counters
>  nfsd: report per-export stats
>=20
> fs/nfsd/export.c   |  68 +++++++++++++++++++++++----
> fs/nfsd/export.h   |  15 ++++++
> fs/nfsd/netns.h    |  23 +++++----
> fs/nfsd/nfs4proc.c |   2 +-
> fs/nfsd/nfscache.c |  52 +++++++++++++++------
> fs/nfsd/nfsctl.c   |   8 +++-
> fs/nfsd/nfsd.h     |   2 +-
> fs/nfsd/nfsfh.c    |   4 +-
> fs/nfsd/stats.c    | 114 +++++++++++++++++++++++++++++++--------------
> fs/nfsd/stats.h    |  96 +++++++++++++++++++++++++++++---------
> fs/nfsd/vfs.c      |   4 +-
> 11 files changed, 292 insertions(+), 96 deletions(-)
>=20
> --=20
> 2.17.1
>=20

--
Chuck Lever



