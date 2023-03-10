Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1275A6B4B9B
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Mar 2023 16:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCJPuK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Mar 2023 10:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjCJPtd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Mar 2023 10:49:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC8A64852
        for <linux-nfs@vger.kernel.org>; Fri, 10 Mar 2023 07:41:08 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AF48l6025886;
        Fri, 10 Mar 2023 15:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=D53uNWAWP3gYx+Qge/WJ6dB18NpYnmAYqWfAk+li+PE=;
 b=S2gjZ/id3G89oA4TLihSGpBAx1tj7ci85fd05s3X8G6K2zjTL+YAtDeDbAEFwrVwQMem
 E8cU5M9WTG9lEUUlY2KiQ4MksqoWBDR8m6Sj1IY4SAT/D1pDU+6uNKswNj0J9mCaDCrG
 KlSXuE5BtWN3N6ZAE5UWp407C4KTXyaNQMj0tZGcXw7gXfgHDzkro345T1GJFjir/uez
 zrn+dmj0IVqnPFG5zRD0exVBdcX7VuMaBjuOGTGJucUSU3eQFRRVWUgJ3z+MBgM3FojS
 HK0crNXalQVEko+affFhtHL00isXZFNVnSuXZjgQvsL5GJ11bttuRbNMSG7H81i7y/IY Qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p7v3w174q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 15:41:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32AFd5Ki025804;
        Fri, 10 Mar 2023 15:41:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g48khyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 15:41:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B914BHIOOLPcPI+voq/irHijI+25i/TF85p56J8XVWjZiHQQUT/oztW6hLSr98+eXT96/9QwPGCNp+hCRYiQNMzXOIqmeaJgwsriOVlwX6XV2dP/ymUlPf+INFcieU/VMOAif3e6Z6GOWT8IJWJI6hDT+aJsnUE2y0Av0280pSiP/UuiY8ZhrDnxheUJBlxm4OV3J+xvLpVOunOFa2Z0Wz1dNe5vMflHzL0pxpgSdAcksuxNILeaOqilZ0sz1iKiI98HTthd1K0d5JDE92lK75IbByF1Cx6Q4YEeXORfVvzkJVwkKnVdA0QyTet9Grqe3BAgGMLKGYDbumN5pxXecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D53uNWAWP3gYx+Qge/WJ6dB18NpYnmAYqWfAk+li+PE=;
 b=i27PJ98bL3y3J3nAJfeF760JFnRbJp72jtjEkR0A7Y65qVo8TGbsZeY/Tc459QWdtaxZ2Z87JCFO/CLOso+nU2nrq0BdYlYjuGgSNg23wCcxPKpypsfAWCe+bi9DB+F+s8BKEGKEaQp8RATFWWC3i9ZPfyESFeOt3V88WC99haGrmNG5usmw6DYexs2a3V9l/GwbwbfqcvmG+A3w8rrwLQZK+c9mVQYpiKh+H0JFE/kiMxH/hcG9YY75CqYpaJFRBepkOqiM/loXT0SsDClHlcxunjwKmwNaDWXbPbPD9V+0Qn/LLwHbx6RFoVb99BgeoYpG9j9PlobNvNFOUJoVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D53uNWAWP3gYx+Qge/WJ6dB18NpYnmAYqWfAk+li+PE=;
 b=ygb/TxqbXgl6RyxzahsNUZYi2iQNbQlPWX6qiYwjsxh+Z4vKwqewLG/lhgSi5kQP4U4vd8nckTd05+IC4HgmQGE5PkVjjtGAhNXbTTmzdwyzYBk95YKFksXi4yu2f7aaUXE/pJjEY+qXuI6Yl97v/yGSrbaWJUhgqZi4TwqzVYw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 15:41:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 15:41:00 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] lockd: fix tracepoint status name definitions when
 CONFIG_LOCKD_V4 isn't defined
Thread-Topic: [PATCH] lockd: fix tracepoint status name definitions when
 CONFIG_LOCKD_V4 isn't defined
Thread-Index: AQHZU2WPXEMgsYXzs0GNgl0xs61HJq70Jp8A
Date:   Fri, 10 Mar 2023 15:41:00 +0000
Message-ID: <414ED508-BE73-4DB1-889B-9FD7C29E2481@oracle.com>
References: <20230310153238.77446-1-jlayton@kernel.org>
In-Reply-To: <20230310153238.77446-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4759:EE_
x-ms-office365-filtering-correlation-id: 2a5a4c9d-9189-4fb8-1f04-08db217dd923
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gCKYB9uHSkCwlR0AUwzRItFwBlAu0uyQ+402pkfKLG/uZNDKs+4RUAfas0Ql92bk1SWM+en6yixl47RA96A5m2WK/Y0zhbHwp98ZO4fFvIxMNm0XzkCgFQeuePC4V79lKdr/MMnEDp8hkYBTeU7mVSS9oh5SeTQQJHhbdWIwQcx7L7EEaoPri/oLUk6hX0KoF8GRVujfjA2gO6icdLKeUNQ2/tTXIRwz2Djr7YRbaB/o2alFjLUbzkqYoZ4HWmIi4IlZEGWVhScVquaSPsyjYWoMY7SGM07+ceYDyQx6q/Ki5f571m3aczq27ci/uU0SlXHANYF3eaeAZvf0eBSTwnnxNAbyvxfTFJ/UTyAExlMA02tNEBm3YbeZO71I7PT8FAcHsj2/vbqFC5YF6G/hwBTT2DXrdlp3QLXHGBCI2X/PmzC3jSBkorI/adfB43tJVU9T3nFHL2zvyf/IZi4FsRbovY2ywarAqlLZdQ7AN9RZhmEA/pu+L0EzposSQJ55CZ5Tw0Y+j3CftO2eywcxOtckI/UZI3/MdJaGCIVzEn5IK9RC8eRTwGnJGIwXJvRvVUfS01t+WvBH0uQhp9DH1Jg3mhcR5oxXXGaQ7BNOR9BkDKZFjkzQEC5fLIpchpIWStmBYJin55LtTYfBw36vqFf4LSQY0hylWbWOFawAl7J/FWiG1ZlvZMGZvDQluiNd0sy5y3nRNB8ubQqLw5bDko9AOFjD+30f2ePUC4vgql4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199018)(33656002)(36756003)(966005)(71200400001)(6486002)(186003)(53546011)(6512007)(2616005)(26005)(83380400001)(6916009)(5660300002)(4326008)(91956017)(66556008)(8936002)(8676002)(64756008)(66946007)(66446008)(76116006)(66476007)(2906002)(6506007)(38100700002)(38070700005)(86362001)(316002)(122000001)(54906003)(478600001)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LFf/04Ql5aIJJVyy+RQbmoyIJvGwlGbR+eWgsvPt/gJz+tnp/KL2vJ5KQD6C?=
 =?us-ascii?Q?y9L4ZcfmQnCvPeAvrJ2Id3aDwPCK4ZtQH3Y2ExzdJFnDgH7fJSGxothjco39?=
 =?us-ascii?Q?PihU8CMANla8kbpm81PRKA5l4P3SKDdVvR8uBsPcD/kesmPQi/NDxyu8iEjy?=
 =?us-ascii?Q?rP4q1ysqgaY1M6pbYRN1kCxK/7FlX+cEgjxkqBzwmy+MvRlCM8gg/8Sej1mD?=
 =?us-ascii?Q?kI6zRWViJxK1yWPymQtopI2WRhvdMciNteRool4MD5HBrQHVViqfMTg2lkGi?=
 =?us-ascii?Q?xjIeYq8SCM+CR/ZleDzw/9j/jVGyO8ZfhdENpNhZphQHUhNqiH5JuAOLPmvP?=
 =?us-ascii?Q?KpSZcMI3q5lSGsCU0NcT/r+OH8bFrfhTo/JMeoifhS7+RrSWFsAc8IxH9WJN?=
 =?us-ascii?Q?f2Y+jG83QeWB+jxWIT9ya8WTSJgYPwtcCV0SsnpAqdQrZeE5SLQ1OZSsJa9t?=
 =?us-ascii?Q?flwWtwg7Rvdp/0Uw4szTDezzMH4+LX+B2xNhf5lgFrKBJsHK3fp7UWo8qFMY?=
 =?us-ascii?Q?FR8MNd5e5PhF/ZUCA5hcb0eLx831js49vHSLNuqdApCHzunRUGmz5Q4SbVhT?=
 =?us-ascii?Q?nQvR/LjeqbCdL6jcPOonUGzyHKnC3AsRFM4xn8fPuQW9mkgt5kPE0q96uamV?=
 =?us-ascii?Q?/enSFHzB39pJhOl1mTC2W9sdqMyIXsMyZapwL4keP461Ez0kvh5KbWG2weQ0?=
 =?us-ascii?Q?iy1nPdTnsJtO8jUhzRmDpcAMl8siD30kGSEPxnWsgS8C6rCmx1CLsyTeCDgV?=
 =?us-ascii?Q?Snvs83xWxKkGtBYWolEyRsgZFoB542rIk+ly2bU6lbOjE4ahSsIyK1R0R3PZ?=
 =?us-ascii?Q?i717EArOnyxz/O8lpMDsUmHrGbqAiysRJScnsnNcbbimNFWArEVXBLhuOT13?=
 =?us-ascii?Q?V59R4k/pabu+a+ThK765MyoX7Ky86Ts0QrILH3wP3yD4+CewxR41LZSWaPex?=
 =?us-ascii?Q?bIIuw6J5l+YwJK2V8aStWB0LFlHBCEy+sracnzU7HNOyUhjSH3vBLdCnPZ0J?=
 =?us-ascii?Q?Brb6EJce34KwTF7Lqa/g7mzWGaVFSKL4MLyUWdVrtHazGycNccfzUr0kCLgR?=
 =?us-ascii?Q?9SUre6R8uEOWDsELMoXXQGWIIXbJQO8gjXKyzODKw4KUs22uET9zRzILHID/?=
 =?us-ascii?Q?ajjomVoqp4rOZU9CjiIDLrqLvMOP7elFzYK8SC8avbj7SEue9GJDk92ioS3E?=
 =?us-ascii?Q?iJ8BjX6JLdq/hwadW77nkHgXVkn6xCQudZqcdnMoNDTtZfub7Ldj8MXqB1XG?=
 =?us-ascii?Q?DWTsvm51yd/yfJMlDc1o6VtlrBFrp6OezCNzPR+XomzptSieojHMephS2nkF?=
 =?us-ascii?Q?Ex0xDqnLdYbJovDjXoB+/N8gL7/Qzy0r9jU+V16C/NgLCLYMW1xRIb/tMvUd?=
 =?us-ascii?Q?mwb2CKoplk5Ga7i7XZfBHILkjkGGh8lgKRRaGPp2090pKR5BetoUmGLXPGbM?=
 =?us-ascii?Q?44GGUYb3dNyeJuNTNQ771MshAlzihjtCMiNB9vvEJj0cj+jsQ1WzVtmO8cR6?=
 =?us-ascii?Q?NgULxbsOr53+1QT/5zYhqEZhyTNxHsSqnPB7I6RKoZyXYwby+9yYzYZRDO13?=
 =?us-ascii?Q?rFpwgd/V146LpD4AF12NJXsWxhPsajE19b9fHVHMwB9mkgOjtb5fm67jwh2H?=
 =?us-ascii?Q?Cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <37E31E047ADE4A49B5325444A0EEADD7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eE7zHTrL/+ZjE19a9Yi5xu2uNH3Ka0rKZTuhoh3HQxVBXfB2CL1/AAqWHXK/IBLiWArIj6+8sHKgulKM19DcfiNiOUUWoUKtkCB/upg0QCB0IZUkiLVymr8N1th6W6c6n/nSOfi7/S969nj/7VPN4LqpdRykHcUEmGd0DDaH+2PnjMoOV8UxzLorN9Z7SGINujOFmy6+TabiB04waaDEhtBzUNqd68Ju9xSqnJ0K7N6e9hdyOE28nqlHxnBAfxy8cFfXPFBmC7ckk4DLvPJ+Cmbmxs2quIXecM/zs9bRACQ5SVn3l8rx7VcvIuX7yVPjJRDp7vkTjxTxRrM2alJalikP7XWAUf7+BhlpfkWlP0LnaKxo5yE5jacME+GCRd63T4SJbu8hwds/W2V/BDsed2VPQyZeYkGhsBguzWT1u1mSx9nkhMjBrfZzAxE+CNpLgm2OOHbhsKGyxNBYIk7aZw/AHQWcEBpPZxQGVFPW1sJNZ+RAZgV4TuC7rzF3C39MOwjx3HQkmaPYokpnc7m1aP7azsO86b0a4dPJ/UMggB2VV6P1+zFv0DylQDVGwktvpVIds+X8a6/750hQ6UD6/tNGMowNSdrXqKvy9xSAeurgX41/DBjylSn9ctEprAKkJLaWu8+UClGzptqhYd2fD/l2HVQUSLN8/AEErVCvcxRvf7lh95offpBjE4Vr5qYqAkLQdPHhhr5Ixah9QnucRfZrR7n9yITSIB3gsxei7rNDno0W3qhWH4WNjHyr3/mfWntDcd1R+NkQWX1oMb9Gp8z3RfAZrgrXta12JxDKdpq4AjvZL1/AWlqU+UG7HEiccoGWjZMEpbhPv+1I+oodDdIWcWAGZfT0PiaXk0443OM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5a4c9d-9189-4fb8-1f04-08db217dd923
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 15:41:00.0487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C0GZPrk7h3qIb5irtD4cVJxQyhm2UmjFIEE+BHgVUUZfyzJyz3fSh3lRQia7J04s+2sVSwJvOnKhX1gfJPrD2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4759
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_06,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=993 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100125
X-Proofpoint-ORIG-GUID: qJP696qk4MI-bHB07Wegox3627avDi5D
X-Proofpoint-GUID: qJP696qk4MI-bHB07Wegox3627avDi5D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 10, 2023, at 10:32 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> There is probably a better way to do this that doesn't repeat anything.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303071503.shUSoIpC-lkp@int=
el.com/
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/lockd/trace.h | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>=20
> Chuck, I'm fine if you want to just fold this into the original
> tracepoint patch too. Also, let me know if you see a way to express this
> better.

Interesting, I have the lockd tracepoint patch in nfsd-next, and
haven't heard a peep from the bots.

I'll fold something in.


> diff --git a/fs/lockd/trace.h b/fs/lockd/trace.h
> index 3e84e3efaf22..11f1381b566c 100644
> --- a/fs/lockd/trace.h
> +++ b/fs/lockd/trace.h
> @@ -10,6 +10,7 @@
> #include <linux/nfs.h>
> #include <linux/lockd/lockd.h>

Btw, here I think TRACE_DEFINE_ENUMs will be needed. I can confirm
that, and add if necessary.


> +#ifdef CONFIG_LOCKD_V4
> #define show_nlm_status(val)							\
> 	__print_symbolic(val,							\
> 		{ NLM_LCK_GRANTED,		"LCK_GRANTED" },		\
> @@ -22,6 +23,15 @@
> 		{ NLM_STALE_FH,			"STALE_FH" },			\
> 		{ NLM_FBIG,			"FBIG" },			\
> 		{ NLM_FAILED,			"FAILED" })
> +#else
> +#define show_nlm_status(val)							\
> +	__print_symbolic(val,							\
> +		{ NLM_LCK_GRANTED,		"LCK_GRANTED" },		\
> +		{ NLM_LCK_DENIED,		"LCK_DENIED" },			\
> +		{ NLM_LCK_DENIED_NOLOCKS,	"LCK_DENIED_NOLOCKS" },		\
> +		{ NLM_LCK_BLOCKED,		"LCK_BLOCKED" },		\
> +		{ NLM_LCK_DENIED_GRACE_PERIOD,	"LCK_DENIED_GRACE_PERIOD" })
> +#endif
>=20
> DECLARE_EVENT_CLASS(nlmclnt_lock_event,
> 		TP_PROTO(
> --=20
> 2.39.2
>=20

--
Chuck Lever


