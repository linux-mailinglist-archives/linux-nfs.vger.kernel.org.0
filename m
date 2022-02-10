Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA134B1512
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Feb 2022 19:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbiBJSQB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Feb 2022 13:16:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240735AbiBJSQB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Feb 2022 13:16:01 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD9A391
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 10:15:58 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AGCeeg013543;
        Thu, 10 Feb 2022 18:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8qv2vTPjsQeu6wF2WfMvSzZu7hl9PGvHrgpUVSdv1ko=;
 b=TOZoKODNsXXxGEqCIyxGlWVHB7/mm8+llA2ooGqnxLMD54rKizbrBZ6pZLTm5SS7+yan
 zvYs+9uCgirxZ0lp/jLJRmb8WxvFXR1xxswmmE4YzujJatqhcFM31qLJBFpM6g0jLadK
 TnchRIkYjkYYFF5k5vhhdlzFrkeyqigD+b+yDKU3qdkO465h+CmCNVZ2S6pKx9/8scsG
 SDkhW4mlDBKxJgWs7r4+TA6LYPYxLlh/l898k7/QWipCoj7EdcT00UvpQXCtAj7q5LHm
 a3y3sjNfJ0V56LUee0sUiG+Ff7tiju7GPxYvRGwlLDMljplibFa1+XNCJ0Qzwr7njVCO 6Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345stt6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 18:15:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21AIBtRr132716;
        Thu, 10 Feb 2022 18:15:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3030.oracle.com with ESMTP id 3e1ec5hyax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 18:15:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xcm2d/mdNzM+4zw5FMFvfRmI5oARC1XUUUpcBIQ72jGhIFP8DVti6quHsEbg+I21OuH02ZMVJtX7LH+unf2SH5ay2FVtTeW9qG10hs7+mKIz6WtR42vNemMp9Dlf3o96Q0B7LTVcCbarWpZKi312xjyCvsIzL9L6d/6wSBtLU2gBger5794dgw1Cdg2mFKomEb+sqTATjvzWwejwtHLBJUDjrX1FjO28LnwF/oKMLfub9en9/NaRMCqMPOZu1fDq0FMU2n+Qk5FQN275EuLUv+7QqBSxd5i92cd0UQGsAOdVOkKPQKFlr+4kp0hRP9JOt8SUyr4rblyeIm2DweNNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qv2vTPjsQeu6wF2WfMvSzZu7hl9PGvHrgpUVSdv1ko=;
 b=ayWPW5OM+K9IlT9hlR8pMYySv5ujLbAKBVj9NBX0L2ym/Smw0cae1WWwiQr4idjY+laI28DbtSL11z0c/T32QINAFWXz1P2Pvk+T6XgKpVrHLvTUG/lk82vNAAnjV9v+g34q7qYC5+orUov6r9ee8apgyCMN3D5j87Gb0GMxD8ISopB9E/0/Rq18hylt+WgJijysdMMSPFhk5FJRSEC6bBNrQ5zA8yumGyEnZbp3Q+pEBeCstddmwSOAeQcqSoPoBUjwCYsyGPbFU0a8o8VmBM+MXi0zuo//pHEP8D84VaEsoDSbImZVqbgSz3+n8JGCjRG+Qf7Lvqpg+N13p6kVUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qv2vTPjsQeu6wF2WfMvSzZu7hl9PGvHrgpUVSdv1ko=;
 b=HgGcwsfoQ79L696kpuz6oBZ5DCtTkrhJDfWD9axrFzlFpvL6QZokAJcBVzLi56JqR7zTL+2FyOEn9SheZ9nn/n2sQlCi3gll6qgp0NqUtnwz+dqUnLO6nkXadjs94dSCQYtrHa7KPbCm8ZHbwUpecWKbvlR05ypNfSymaDL92YQ=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by MWHPR1001MB2174.namprd10.prod.outlook.com (2603:10b6:301:33::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Thu, 10 Feb
 2022 18:15:43 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 18:15:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Thread-Topic: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Thread-Index: AQHYHqhMlT21uFtPcU6l7DrJSxeLtayNFxwA
Date:   Thu, 10 Feb 2022 18:15:43 +0000
Message-ID: <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>
References: <cover.1644515977.git.bcodding@redhat.com>
 <9c046648bfd9c8260ec7bd37e0a93f7821e0842f.1644515977.git.bcodding@redhat.com>
In-Reply-To: <9c046648bfd9c8260ec7bd37e0a93f7821e0842f.1644515977.git.bcodding@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43393277-7726-4848-c155-08d9ecc15a0c
x-ms-traffictypediagnostic: MWHPR1001MB2174:EE_
x-microsoft-antispam-prvs: <MWHPR1001MB21742DFAD2C14737F3CB7689932F9@MWHPR1001MB2174.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bPdloUMIylBLQh4vFY1uQY7gpDedaQpK+Zo2WATCogPjuSapmQQd7o+z1eVobi+3oIHLKdRhyK2R7VaDvk0rLk/3ITSAm4N+vmQT/VChKF+YxCHZHgPfdQCZby2dUsHr6yAVxEVKOihb3PTDS5E7BnJB5RcUo70pLes4g8csoXh7WDnf2fJk/4qZCv6v+auCEfoYBlCsCWAijg/cq5VVQiJhdO+dnxa1mVbWnHzNFeKPvfgO0EMsKuDqRKIVD85tEK0uV1DWvGZhUOp/JxPHLaRE0oCJOcE0GoJk75fqv42M1gI0iY8WaC4IdtbnI5OUkwaSF7MdqrtKwB7pDjWAJgpKKIIaxzAktj+TOmJSX+xWeEIVwiK9I0UtLpNd+8BDT8zSUc4AmeroIX+fqi3g8Z4X0wAWgGDMrCFuaSNoa6ZqhVgkFBEuJQRjx32vfn7sM81lOetkFSBxRbrNP3FSkcbAqcoy54phGlrafjsHQNSz20Q8qrA6bEqD988sOnD6Vcg32TlqLMYl05VU/T3ICfYzb7D8sj/aZT4PwtRKgmsXMrklAyQuzRSaXdQQ9pldquJRpOVWRaG4teqArML/1o6CIt9n43CySDQfSt5QvPQcRm2a1FUSxA+M0TB4OftS89+Su2KUEiwt/SRGHyliGtBPx+nz25fDeWq352WCypjdHsijgG6xfw8NIJl10xza99/5a/Ph4dC73TE38XsgRaapqTr5wmH2eFab+9WJDFCh7ef5kxrwSzialldoB5K6zgR2hypXQYo/vcSrO93qHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(66476007)(186003)(6916009)(38100700002)(8676002)(6486002)(5660300002)(66556008)(316002)(83380400001)(36756003)(2616005)(2906002)(8936002)(33656002)(26005)(6506007)(6512007)(71200400001)(53546011)(86362001)(4326008)(64756008)(54906003)(66946007)(122000001)(508600001)(76116006)(66446008)(2004002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RHhKVk8A2GNO7J/Fh7PQvAWLxpJrtHSDlTWFtfME3Jm2jdjr1YOb5RwuwtZs?=
 =?us-ascii?Q?rKBx1UwQHVPSUieBgtxLHJtM8Wp5rW7X/8dQOVFvTcX865ssYHYfLHxFnmka?=
 =?us-ascii?Q?MsE8sXALfuVwQp0dwwI6YusWhGy/fh3IUW4bJtToYGlE9mBD5+lH7kY8KcZl?=
 =?us-ascii?Q?lNCNt0k1NKvqq4679cNDyVXCHx/q3cpPjSN6iO6YeAOEqUN7mRoUDcjEI/D3?=
 =?us-ascii?Q?ACpXKUepl84L+SHC1XRzDuLc9x5trVfGQ5hfh0Kk0yFjVKwxJw7rxLkNNjcP?=
 =?us-ascii?Q?s0H88CBlP/NA4Is0FgcQqTDNiUgWvhjabMO202zBqOJEObX7En/4PViXHw1r?=
 =?us-ascii?Q?Cswr7TNGThai0ggYoZ8JS+8ORv0MtUaQXKWI4PJ8KMx3MnCdGmf884oYWKMM?=
 =?us-ascii?Q?l90yOLgCQehYimTYf1hCHrws/Fhm73ENmHY3Az0zFKh408i0mkrOGauvoToy?=
 =?us-ascii?Q?suQFnzUn/Bb/pSzSL6UgL4ezRdbawEJ0HdmaUmjAGhcAV0LnZFbkwRowA3Ny?=
 =?us-ascii?Q?tkD5AyIDfIoCEkI/tywS6+438VXk949hF+Oy1us8PErl2CX9McablcMEfvJI?=
 =?us-ascii?Q?hi3fkDI5+iia9oJOHB3jAMjtVUao2LtuDF3EwF33egMwgfb+IjAUvlrv6V8n?=
 =?us-ascii?Q?ooNjZHqQd9nXJWAPQzjh4/yTKnuovz8e0FZGXbL0wjmWTquAFlb5+zFpQu03?=
 =?us-ascii?Q?DyFTg6XxnfqtPsaQgA+MB/aFRUSzj7eNh57dQoO3xImE14yR+Sn1Ut+ZCx51?=
 =?us-ascii?Q?cFieiVnB425oS5K3o+dxZD2k0LTHhcrijD5SeJFkcpQqGoxIkd5hm3u9EtV3?=
 =?us-ascii?Q?E5esFv/NAzRzKihFtR8TRFkzDk7BHp1gISxUSnRSJp8OfFnfgAqEKDGqWILf?=
 =?us-ascii?Q?CVixbpZAHiOlWS68t2keAbs9EKorjz2sO2k1A+qCXlzAlUUWAe+YAW58dFLe?=
 =?us-ascii?Q?45NGI+7dpKM6jD6bKCFIqAIuEvjUiGmzPWq+XELKClyyU59pZepv38a+Ojkm?=
 =?us-ascii?Q?gQSWtuBepadKVEwvUOCA3Qo8AeaGh8JCwybt/NH0Q3AzuFhoIjEHpSMkib0V?=
 =?us-ascii?Q?W/Se4IQcop2OT6643+708HUfKVumoQv+6CKHQaQacfP6gViZQJ5JajuAjy5j?=
 =?us-ascii?Q?zunQYf/Im0PcqhHvmelX8amvyEyQTHr+l5nATd7aSxqE9qPoGgNLjBFiibtP?=
 =?us-ascii?Q?Ehq23fe3FfRFJAghPZ+MfvZprtMKdZB6qzvu+WMyOC4RO8yuJfJFVNHDkKSG?=
 =?us-ascii?Q?z2y4lIZH3BTcBcOtohmz4GAg++b4gpnzlDMGJYRmE7GkFRbFL+bU/9dSVHPz?=
 =?us-ascii?Q?O0VLFAJ94NYU064JD6eIyBIb67totOKBADT+NBtQY24ccPiL67lp6N6Zw5xI?=
 =?us-ascii?Q?e/cG7knCCNo+Uks0WRRF+cRzgX8Z1yH9eMw5b0triX7GO0SRkI3+nMyBe1Rg?=
 =?us-ascii?Q?3jihyr+VUdx+clcS7j1gMi+67fTf7liR9P8RFfxxPM6LA9lqQNS31u4+2KFG?=
 =?us-ascii?Q?5zf8nHGnEQIICgBA4mmMDNvfb1qVYPv4PH61f5AVbFEu/dgrThGo0OHsh+4i?=
 =?us-ascii?Q?zkB2QOHJfPOH1rryqYi4CuEiBjyPJwdvYB6IC9Y/AB62QrKHbt1aV+c26CaL?=
 =?us-ascii?Q?iwJQLbBgAXYnjh0dYVKkvqQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B8C964629002F6418EFD97D4067A2A5C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43393277-7726-4848-c155-08d9ecc15a0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 18:15:43.1858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ShiD+1FmtzF3kEikoFTd6vVJMYp03g1wK518kAcF+wnSiT356nW5zfJx30VHjueVrMeAp2tKNG0e/mQ6CjkIxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2174
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100096
X-Proofpoint-GUID: _gl6zzE6IK_3EhQeMbEjDok53l1jXPxT
X-Proofpoint-ORIG-GUID: _gl6zzE6IK_3EhQeMbEjDok53l1jXPxT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 10, 2022, at 1:01 PM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> The nfsuuid program will either create a new UUID from a random source or
> derive it from /etc/machine-id, else it returns a UUID that has already
> been written to /etc/nfsuuid or the file specified.  This small,
> lightweight tool is suitable for execution by systemd-udev in rules to
> populate the nfs4 client uniquifier.

I like everything but the name. Without context, even if
I read NFS protocol specifications, I have no idea what
"nfsuuid" does.

Possible alternatives:

nfshostuniquifier
nfsuniquehost
nfshostuuid


> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
> .gitignore                |   1 +
> aclocal/libuuid.m4        |  17 ++++
> configure.ac              |   4 +
> tools/Makefile.am         |   1 +
> tools/nfsuuid/Makefile.am |   8 ++
> tools/nfsuuid/nfsuuid.c   | 203 ++++++++++++++++++++++++++++++++++++++
> tools/nfsuuid/nfsuuid.man |  33 +++++++
> 7 files changed, 267 insertions(+)
> create mode 100644 aclocal/libuuid.m4
> create mode 100644 tools/nfsuuid/Makefile.am
> create mode 100644 tools/nfsuuid/nfsuuid.c
> create mode 100644 tools/nfsuuid/nfsuuid.man
>=20
> diff --git a/.gitignore b/.gitignore
> index c89d1cd2583d..4d63ee93b2dc 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -61,6 +61,7 @@ utils/statd/statd
> tools/locktest/testlk
> tools/getiversion/getiversion
> tools/nfsconf/nfsconf
> +tools/nfsuuid/nfsuuid
> support/export/mount.h
> support/export/mount_clnt.c
> support/export/mount_xdr.c
> diff --git a/aclocal/libuuid.m4 b/aclocal/libuuid.m4
> new file mode 100644
> index 000000000000..f64085010d1d
> --- /dev/null
> +++ b/aclocal/libuuid.m4
> @@ -0,0 +1,17 @@
> +AC_DEFUN([AC_LIBUUID], [
> +        LIBUUID=3D
> +
> +        AC_CHECK_LIB([uuid], [uuid_generate_random], [], [AC_MSG_FAILURE=
(
> +                [Missing libuuid uuid_generate_random, needed to build n=
fs4id])])
> +
> +        AC_CHECK_LIB([uuid], [uuid_generate_sha1], [], [AC_MSG_FAILURE(
> +                [Missing libuuid uuid_generate_sha1, needed to build nfs=
4id])])
> +
> +        AC_CHECK_LIB([uuid], [uuid_unparse], [], [AC_MSG_FAILURE(
> +                [Missing libuuid uuid_unparse, needed to build nfs4id])]=
)
> +
> +        AC_CHECK_HEADER([uuid/uuid.h], [], [AC_MSG_FAILURE(
> +                [Missing uuid/uuid.h, needed to build nfs4id])])
> +
> +        AC_SUBST([LIBUUID], ["-luuid"])
> +])
> diff --git a/configure.ac b/configure.ac
> index 50e9b321dcf3..1342c471f142 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -355,6 +355,9 @@ if test "$enable_nfsv4" =3D yes; then
>   dnl check for the keyutils libraries and headers
>   AC_KEYUTILS
>=20
> +  dnl check for the libuuid library and headers
> +  AC_LIBUUID
> +
>   dnl Check for sqlite3
>   AC_SQLITE3_VERS
>=20
> @@ -740,6 +743,7 @@ AC_CONFIG_FILES([
> 	tools/nfsdclnts/Makefile
> 	tools/nfsconf/Makefile
> 	tools/nfsdclddb/Makefile
> +	tools/nfsuuid/Makefile
> 	utils/Makefile
> 	utils/blkmapd/Makefile
> 	utils/nfsdcld/Makefile
> diff --git a/tools/Makefile.am b/tools/Makefile.am
> index 9b4b0803db39..a12b0f34f4e7 100644
> --- a/tools/Makefile.am
> +++ b/tools/Makefile.am
> @@ -7,6 +7,7 @@ OPTDIRS +=3D rpcgen
> endif
>=20
> OPTDIRS +=3D nfsconf
> +OPTDIRS +=3D nfsuuid
>=20
> if CONFIG_NFSDCLD
> OPTDIRS +=3D nfsdclddb
> diff --git a/tools/nfsuuid/Makefile.am b/tools/nfsuuid/Makefile.am
> new file mode 100644
> index 000000000000..7b3a54c30d50
> --- /dev/null
> +++ b/tools/nfsuuid/Makefile.am
> @@ -0,0 +1,8 @@
> +## Process this file with automake to produce Makefile.in
> +
> +man8_MANS	=3D nfsuuid.man
> +
> +bin_PROGRAMS =3D nfsuuid
> +
> +nfsuuid_SOURCES =3D nfsuuid.c
> +nfsuuid_LDADD =3D $(LIBUUID)
> diff --git a/tools/nfsuuid/nfsuuid.c b/tools/nfsuuid/nfsuuid.c
> new file mode 100644
> index 000000000000..bbdec59f1afe
> --- /dev/null
> +++ b/tools/nfsuuid/nfsuuid.c
> @@ -0,0 +1,203 @@
> +/*
> + * nfsuuid.c -- create and persist uniquifiers for nfs4 clients
> + *
> + * Copyright (C) 2022  Red Hat, Benjamin Coddington <bcodding@redhat.com=
>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor,
> + * Boston, MA 02110-1301, USA.
> + */
> +
> +#include <stdio.h>
> +#include <stdarg.h>
> +#include <getopt.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <uuid/uuid.h>
> +
> +#define DEFAULT_ID_FILE "/etc/nfsuuid"
> +
> +UUID_DEFINE(nfs4_clientid_uuid_template,
> +	0xa2, 0x25, 0x68, 0xb2, 0x7a, 0x5f, 0x49, 0x90,
> +	0x8f, 0x98, 0xc5, 0xf0, 0x67, 0x78, 0xcc, 0xf1);
> +
> +static char *prog;
> +static char *source =3D NULL;
> +static char *id_file =3D DEFAULT_ID_FILE;
> +static char nfs_unique_id[64];
> +static int replace =3D 0;
> +
> +static void usage(void)
> +{
> +	fprintf(stderr, "usage: %s [-r|--replace] [-f <file> |--file <file> ] [=
machine]\n", prog);
> +}
> +
> +static void fatal(const char *fmt, ...)
> +{
> +	int err =3D errno;
> +	va_list args;
> +	char fatal_msg[256] =3D "fatal: ";
> +
> +	va_start(args, fmt);
> +	vsnprintf(&fatal_msg[7], 255, fmt, args);
> +	if (err)
> +		fprintf(stderr, "%s: %s\n", fatal_msg, strerror(err));
> +	else
> +		fprintf(stderr, "%s\n", fatal_msg);
> +	exit(-1);
> +}
> +
> +static int read_nfs_unique_id(void)
> +{
> +	int fd;
> +	ssize_t len;
> +
> +	if (replace) {
> +		errno =3D ENOENT;
> +		return -1;
> +	}
> +
> +	fd =3D open(id_file, O_RDONLY);
> +	if (fd < 0)
> +		return fd;
> +	len =3D read(fd, nfs_unique_id, 64);
> +	close(fd);
> +	return len;
> +}
> +
> +static void write_nfs_unique_id(void)
> +{
> +	int fd;
> +
> +	fd =3D open(id_file, O_RDWR|O_TRUNC|O_CREAT, S_IRUSR|S_IWUSR|S_IRGRP|S_=
IROTH);
> +	if (fd < 0)
> +		fatal("could not write id to %s", id_file);
> +	write(fd, nfs_unique_id, 37);
> +}
> +
> +static void print_nfs_unique_id(void)
> +{
> +	fprintf(stdout, "%s", nfs_unique_id);
> +}
> +
> +static void check_or_make_id(void)
> +{
> +	int ret;
> +	uuid_t uuid;
> +
> +	ret =3D read_nfs_unique_id();
> +	if (ret < 1) {
> +		if (errno !=3D ENOENT )
> +			fatal("reading file %s", id_file);
> +		uuid_generate_random(uuid);
> +		uuid_unparse(uuid, nfs_unique_id);
> +		nfs_unique_id[36] =3D '\n';
> +		nfs_unique_id[37] =3D '\0';
> +		write_nfs_unique_id();
> +	}
> +	print_nfs_unique_id();
> +}
> +
> +static void check_or_make_id_from_machine(void)
> +{
> +	int fd, ret;
> +	char machineid[32];
> +	uuid_t uuid;
> +
> +	ret =3D read_nfs_unique_id();
> +	if (ret < 1) {
> +		if (errno !=3D ENOENT )
> +			fatal("reading file %s", id_file);
> +
> +		fd =3D open("/etc/machine-id", O_RDONLY);
> +		if (fd < 0)
> +			fatal("unable to read /etc/machine-id");
> +
> +		read(fd, machineid, 32);
> +		close(fd);
> +
> +		uuid_generate_sha1(uuid, nfs4_clientid_uuid_template, machineid, 32);
> +		uuid_unparse(uuid, nfs_unique_id);
> +		nfs_unique_id[36] =3D '\n';
> +		nfs_unique_id[37] =3D '\0';
> +		write_nfs_unique_id();
> +	}
> +	print_nfs_unique_id();
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	prog =3D argv[0];
> +
> +	while (1) {
> +		int opt, prev_ind;
> +		int option_index =3D 0;
> +		static struct option long_options[] =3D {
> +			{"replace",	no_argument,		0, 'r' },
> +			{"file",	required_argument,	0, 'f' },
> +			{ 0, 0, 0, 0 }
> +		};
> +
> +		errno =3D 0;
> +		prev_ind =3D optind;
> +		opt =3D getopt_long(argc, argv, ":rf:", long_options, &option_index);
> +		if (opt =3D=3D -1)
> +			break;
> +
> +		/* Let's detect missing options in the middle of an option list */
> +		if (optind =3D=3D prev_ind + 2 && *optarg =3D=3D '-') {
> +			opt =3D ':';
> +			--optind;
> +		}
> +
> +		switch (opt) {
> +		case 'r':
> +			replace =3D 1;
> +			break;
> +		case 'f':
> +			id_file =3D optarg;
> +			break;
> +		case ':':
> +			usage();
> +			fatal("option \"%s\" requires an argument", argv[prev_ind]);
> +			break;
> +		case '?':
> +			usage();
> +			fatal("unexpected arg \"%s\"", argv[optind - 1]);
> +			break;
> +		}
> +	}
> +
> +	argc -=3D optind;
> +
> +	if (argc > 1) {
> +		usage();
> +		fatal("Too many arguments");
> +	}
> +
> +	if (argc)
> +		source =3D argv[optind++];
> +
> +	if (!source)
> +		check_or_make_id();
> +	else if (strcmp(source, "machine") =3D=3D 0)
> +		check_or_make_id_from_machine();
> +	else {
> +		usage();
> +		fatal("unrecognized source %s\n", source);
> +	}
> +}
> diff --git a/tools/nfsuuid/nfsuuid.man b/tools/nfsuuid/nfsuuid.man
> new file mode 100644
> index 000000000000..856d2f383e0f
> --- /dev/null
> +++ b/tools/nfsuuid/nfsuuid.man
> @@ -0,0 +1,33 @@
> +.\"
> +.\" nfsuuid(8)
> +.\"
> +.TH nfsuuid 8 "10 Feb 2022"
> +.SH NAME
> +nfsuuid \- Generate or return nfs client id uniquifiers
> +.SH SYNOPSIS
> +.B nfsuuid [ -r | --replace ] [ -f | --file <file> ] [<source>]
> +
> +.SH DESCRIPTION
> +The
> +.B nfsuuid
> +command provides a simple utility to help NFS Version 4 clients use uniq=
ue
> +and persistent client id values.  The command checks for the existence o=
f a
> +file /etc/nfsuuid and returns the first 64 chars read from that file.  I=
f
> +the file is not found, a UUID is generated from the specified source and
> +written to the file and returned.
> +.SH OPTIONS
> +.TP
> +.BR \-r,\ \-\-replace
> +Overwrite the <file> with a UUID generated from <source>.
> +.TP
> +.BR \-f,\ \-\-file
> +Use the specified file to lookup or store any generated UUID.  If <file>=
 is
> +not specified, the default file used is /etc/nfsuuid.
> +.SH Sources
> +If <source> is not specified, nfsuuid will generate a new random UUID.
> +
> +If <source> is "machine", nfsuuid will generate a deterministic UUID val=
ue
> +derived from a sha1 hash of the contents of /etc/machine-id and a static
> +key.
> +.SH SEE ALSO
> +.BR machine-id (5)
> --=20
> 2.31.1
>=20

--
Chuck Lever



