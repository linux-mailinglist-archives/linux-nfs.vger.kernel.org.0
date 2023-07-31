Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B3676A431
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Aug 2023 00:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjGaWbm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 18:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGaWbm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 18:31:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDE4EC
        for <linux-nfs@vger.kernel.org>; Mon, 31 Jul 2023 15:31:41 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VKfv9c001804;
        Mon, 31 Jul 2023 22:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zsyKe3lTdoH/QiV3D0JhTfjeGWWWWj+VUs6vKwhtD4M=;
 b=NMsjQF1ERG2/sfs0rh1UxUyxXNBJ6WOXnKb8eNh58QgBURYjOO1Sb1Yv//ojn8rUCHsp
 uF8vGr1WNOasBuKKu7PvPp6fbhbyUkuudaWQfhzdvvtn/m8NFBpAVo2EV+HPckQVqvuY
 01z+vGL+JQ5p0QYMDf8wrDnzhpwiAZQZYIN9/bV04AY3WJzF1ILBECu3ITVs3M1P2k2T
 RscvXbnkbBZvUM9RBmgow6yE9C7WhHGn+bZZyqZkcH218oD0F5PppNW1LAqwTvnU4G8G
 opw3FZCGGMPGRHiNzo7So7JpZTvU1r/9tcr32gf1TtfGN5Rk2OpzXZeSe0jlBC1c57Ud rw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spc3qje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 22:31:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VLHd1K038121;
        Mon, 31 Jul 2023 22:31:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7btvdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 22:31:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcOzPqh7eF7Q/HmwUbZw0Atdz0O4MlG2q0YdMe6eazMeCnh/R6xQvDPyK/FwTH8sJWc/PZVTLCMLvsmtrWFDJJg/mrl/LmqNLidGVjA1ATm9RxvbAyzl/ev5OehTEL6dGl3xZ7BagJMbY+aYt7Y37mHTko+aYX4iS1CCQ1IpAHgZsJ8RcJWnXhJQQSUNmuuZdH62bCDJhbcXH+4hHm22TQzMptPEfAmAM64J92HvhbtcU3f27/Csrd67uIVozhjiuEPMu+40YDJLUIXUR9utv+uuh5XEO0lAst5UpBtYzfdLTfD31uO6GDkxs42UmWRStT5sw+WUYjqRP8bwr33gtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsyKe3lTdoH/QiV3D0JhTfjeGWWWWj+VUs6vKwhtD4M=;
 b=HtQZ7mA39CS7YJ3Yt7O4WSYhtzAea9yMzylER+vSZqGCORTjP09yTZChKLX8/sHfS8z6RyH4MAdqV7ToGHimvGOixmm9LBlEmwdOrcDrgMnwy70raLJxGk7RZg9S3rxz80arVLo3Lk+0YgQdoI+WZk18yQrLEB0DygdcH3hJb+sVcFQ9HNGvjMMNXnHvWd/ScK14+Nl2cr4ij6DZltM2I1MWoD35QJW5el3sdX+wC4w1ydEZ9r8fytoaf5Huwt7VX+q8NGQKt0LyRiku5QiFfhcNh7hveDaCOyGW08SCxMklpl46euIO+DWIHcgCeDrLeWlyANGPLm3sEY6ca2cW2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsyKe3lTdoH/QiV3D0JhTfjeGWWWWj+VUs6vKwhtD4M=;
 b=PHUEMdge335hw+I4+616KnTvBSefw4idICw/r9zw/x7ER07ttLaHkANlpbXgZWDBJODvsrAfGqniWVrnWyuit60ne47XuLDCPjB2tkUMcNDq+BDjQD50qbJtZ6yDSDEMI69B0hgCScnVoyVeuDT+VCxufNREmcOnx5vBr16vBeg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6419.namprd10.prod.outlook.com (2603:10b6:303:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Mon, 31 Jul
 2023 22:31:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 22:31:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 01/12] SUNRPC: make rqst_should_sleep() idempotent()
Thread-Topic: [PATCH 01/12] SUNRPC: make rqst_should_sleep() idempotent()
Thread-Index: AQHZw3tyol8zBRXZ2EKzzd+n2PPZC6/T7aOAgACBhgCAAAdTgA==
Date:   Mon, 31 Jul 2023 22:31:30 +0000
Message-ID: <E1419C3D-9912-4A59-BC7F-78A48AF9A173@oracle.com>
References: <20230731064839.7729-1-neilb@suse.de>
 <20230731064839.7729-2-neilb@suse.de>
 <ZMfDa8YRUH3Lm15p@tissot.1015granger.net>
 <169084110651.32308.3326402203041564605@noble.neil.brown.name>
In-Reply-To: <169084110651.32308.3326402203041564605@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6419:EE_
x-ms-office365-filtering-correlation-id: 652093f9-2930-4cfc-8a33-08db9215e2e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rw7Qz2f/UgA4aahQzHmUFiESvGuEZGmSEZUPdZkTke7RpUk7nEB7T5zpggf6f9Pi2VPMfz9A4qtqNPictAUMB0BMNDckHgjsr827JDqpGIsD7fLqGZLJzvjiSSA5jkwQy1SVWGDIVgvKtIC7HMZllkZ9wKoVSIgYko/PIXy91GGgSIKYhXUD6GM5k7RyvS/DksF1mXbhUfyYGuckL5eh+fIdimxFrTrvxvO9Hj3LTZxyhCI7mIvIm9NvNVm1NIAy0hcpfS3j8MOo2Ytck17hk3f9tc4uWugb6vXeW82DE9VOxoZJ/RqWAzxHYXhNIYkuZCr4KB60VqKindg+pdTnh7TnwxlT2qLbPMx/W8i6PVZL6pMtpTGL1i9bA8pnxMMq7TYSXI6ny4R6SArVQWVp1onFKdQbGP+nrVZXHbWZtQ/s/lHcinjEpNDx89W8Z3jeo3urkWhsx7jbCraI2+lvsB1eJgfgvPpVguiPsumwBakIe8s1SuMlSqXxtlDJRiO8+8KYzBaAQftamLo6QZ16Lm3tTK3zEW+AKGb1M0Z6vu9TgnzYYkBM4brE1lSItu8RVQkmEKTFAvFbOdRN2sviX4c2JEysoDUbvjCADhvGG5QnLBzVsq9wgsHC61X7K+2vPXZeFwAeqMMFUnxCZeDOFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(76116006)(6916009)(66446008)(66556008)(66946007)(66476007)(64756008)(2906002)(4326008)(5660300002)(91956017)(54906003)(41300700001)(316002)(2616005)(71200400001)(6486002)(8936002)(6506007)(8676002)(26005)(53546011)(186003)(83380400001)(122000001)(478600001)(36756003)(38100700002)(38070700005)(33656002)(6512007)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e9GbDo8mSxZtqEqlROgI2fiBYuCK+1dJlGTse6ua98KExaQLwfmIHfqJSJLy?=
 =?us-ascii?Q?c9WYMk7HWcVkGNHIUJeDoNN/5GXss0Xh/Xhv1BTZ852+jHGDcs3HyTVbZr5P?=
 =?us-ascii?Q?IqYwMHiTaK2OSYnvPfQYgQAXadn7KLJDatcF5O4FKYD4gtpmbiodnQ5/ylav?=
 =?us-ascii?Q?JCSWGVo5jDqSDS83iVnk4iU85L52C6GZ2cxm58rqrRbNLpHTPglSASmKkEtR?=
 =?us-ascii?Q?QLhstt5ecxx3/m+heM6OQ8BguWnMHgd3qy4NVJXHOoaGK/LbazP2ZN0r3IPz?=
 =?us-ascii?Q?HUDAUIJhV5fnywZ4dk5+rMHThi16PIwxj1ifZ40AKNuUu2905+ykYooO7Kbs?=
 =?us-ascii?Q?fU4cpOGXmBZXEW+t+SV809wx0qMpMFFvCqwN+JdMwTXr0Emlldf1fYXOtmyW?=
 =?us-ascii?Q?XTlEJr/Lfoo/vvrA7MY6+xYjQNECu48axMpNggJyVn+QuBLpRwbNAHOyg3I/?=
 =?us-ascii?Q?vvIavDpO3CBXvxrLPvy2MXjjQzxo5O/frhtwl7YMJbtSdGn2y68RcUo3TYsO?=
 =?us-ascii?Q?Wjl+yty/oE9qQetCj4AKsq/7+CcNywmI2Z/tDcCfzwC6tFpSN9M9UcqTerpO?=
 =?us-ascii?Q?cSGIUHFsFqu/mqc8T8Hyb139YdgH8oozuH8Q3bKAOK4icYCwAEcRGqtXKAq3?=
 =?us-ascii?Q?JUXKerwbKliYU8ehqk/FmRLE7Y36Poqn0MgyDaJryGkg/odWjnXh8QFrxu/W?=
 =?us-ascii?Q?3L77LTF3Vo5SyxC2Egz+mYdcUB2O6+A6Msiund/PW6WVoCmpbXVkoiNR5BvJ?=
 =?us-ascii?Q?qZcKzW7Y/5uSg+2tK9GgUYWOhfWLwCEk1/zgldL5BZBWnHeL0uX5Kw9tEAux?=
 =?us-ascii?Q?7wCvpPlFgdv/PjQYF3zSVWhAPtECg28PVq3VbAJsI40zQql2zjRaZHEYGln6?=
 =?us-ascii?Q?pnyGzpIuDZtYao1UbgAJiBDZhqvbUDTWz7RsSaQhpvTmVbOgJG0UezI/0Z3a?=
 =?us-ascii?Q?V/J2aRGbresWHAQ4d2GSiFVEktc13iXFKU5lF+elaW+1mTkCFwET8SltGwMJ?=
 =?us-ascii?Q?qxMyS3PqAKWZ6XsTbLrd7llAwB4kFTF5VURlkoCHxgr5yoyvjCLXanV6flml?=
 =?us-ascii?Q?FoUx0uVsHg+5p/vwFk525GHJ3+bOs53lgxJqPfkY+/tI9zMbmOYQxQQzJZed?=
 =?us-ascii?Q?uFTHRKmxBdDrD9zsfPKY+6DUtBZ/NuDLEEnsgZFLjhsH/buRNjjWbHYzJhbj?=
 =?us-ascii?Q?HtxbBaoJLixTyuTZSQVGRM13tHvTcOmBTcdHhAWRb//ycG+L4mJD9LZUG2Wy?=
 =?us-ascii?Q?WszqJOcvrT8URf59vk8La1kvZw1guJ5QALF6ZqAnWtGv7BvdWOuu2VuZu5Ye?=
 =?us-ascii?Q?mVFeIKFXCPMPGRzATpRp/RDe7Y3H7TpMp+9lGICw8RtpG4HhRxmiIiKhspI9?=
 =?us-ascii?Q?PIQU5dAcqNkcUEmoR3gcFdPUZfjC61gFv1tx5X2iznaoyjfeHgqRURKx6mUv?=
 =?us-ascii?Q?IXIM7R0iz2myIqHXgWO6zCcibXUWrLt6Yb/7S5cC9ygWK9MgEEHAI6TBFyIx?=
 =?us-ascii?Q?zS6SzLVog0KdC7pH8YV+6U8lC/JyOYpyTjj0bKZL1+adu55p6lXSFfOfgolh?=
 =?us-ascii?Q?qJBz6Hzj+oxtVo49h0y4foHk2zelMdUgrDKznAZ6OhoSFjvyZrYE4cXuGM0H?=
 =?us-ascii?Q?VA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BA69E3C6A86EC340A85ED23F2B7064A2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pVNItAEA7FlLJ1w9NhIZVb5+EXBxFfXPZc8TV/kwHU7IGAxm/yywF+j/0JLPzUIUgh3xAOAGMPg6kQ+C/b4o0I6j0Uy2CXKIvRCFiG2V9qg4H+d5zXZ+vLg5gqOZaCh8kOmMv3BWOM0IlwBqnN4mJRc1INpVLlyVsxiU9bjDcBsjTL/oqvlhGqTG2Saw/ir8l7NmE88DJAfb9CThIrOWf+ACvXn34f4f4c7M8GNjwUsMaBXfq/VFTs7mgtrJkqbhlF3ueLrXWJVGwvsnpWoTgsbPVYl8ppfB9fVpp+vntI4nWUsqaiWZObTb/nkgXvLdHPuEtJ6gY4G1nTMJufl49T6ondQHDjeICfATsoqQ8Ja2Zfp20AQKHFcfYcp/y8bx6vWwoo9vzuIykvgLWsTAbaGU+Rc+pSwjoInFxPDh3Wa9BvwTqM0qr75XE1f9O9ZZ9vSfocP2bCjB2MLGnuzMtG2Ypc5lcV4DGBByyvijvTpGuzlAUBO8Z3dlG043wNbdI680YovZ4IVxOMVWBAS9khjwZxPElsnLJOdhZCWyhQcMklSfsR6DyDNHdqc90SOeRqdVrvftU98YOBOc/lSAWLxDiWARHDjEmbzHrJgPdTWM1J7KcGr0vbzAlEeICNoCqe7g0KILgQqO8qQt51m02OrxYocaDOyBh8ysbW6+MhdshRGpMRQiia25JARFBsHcgwTaguK/NwefDar2U4BcoSXgVqNWP+hbw46b7+Rg7ZQsfZjUv5C+A89jIC/QL7VYJ6VLRCYWTeYgHdRBDtUkZXONmjttw+dO+xdTLY3Xo1xR7yc+TKiMoj2M3owYFFxy
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652093f9-2930-4cfc-8a33-08db9215e2e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 22:31:30.1214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQ4bt7TIuYULpK3trBYVxK/jQF+8fZUHq94Reybx5+VagidqzoPHXvz9shxYMoy18NcGdUFQvRUzHjPrwqB81w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6419
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_15,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310204
X-Proofpoint-ORIG-GUID: kR2G_leaXeu3TF030dR0UYf66_SdFW1j
X-Proofpoint-GUID: kR2G_leaXeu3TF030dR0UYf66_SdFW1j
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 31, 2023, at 6:05 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 01 Aug 2023, Chuck Lever wrote:
>> On Mon, Jul 31, 2023 at 04:48:28PM +1000, NeilBrown wrote:
>>> Based on its name you would think that rqst_should_sleep() would be
>>> read-only, not changing anything.  But it fact it will clear
>>> SP_TASK_PENDING if that was set.  This is surprising, and it blurs the
>>> line between "check for work to do" and "dequeue work to do".
>>=20
>> I agree that rqst_should_sleep() sounds like it should be a
>> predicate without side effects.
>>=20
>>=20
>>> So change the "test_and_clear" to simple "test" and clear the bit once
>>> the thread has decided to wake up and return to the caller.
>>>=20
>>> With this, it makes sense to *always* set SP_TASK_PENDING when asked,
>>> rather than only to set it if no thread could be woken up.
>>=20
>> I'm lost here. Why does always setting TASK_PENDING now make sense?
>> If there's no task pending, won't this trigger a wake up when there
>> is nothing to do?
>=20
> Clearly Jedi mind tricks don't work on you...  I'll have to try logic
> instead.
>=20
> This separation of "test" and "clear" is a first step in re-organising
> the queueing of tasks around a clear pattern of "client queues a task",
> "service checks if any tasks are queued" and "service dequeues and
> performs a task".  The first step for TASK_PENDING doesn't quite follow
> a clear pattern as the flag is only set (the work is only queued) if
> no thread could be immediately woken.  This imposes on the
> implementation of the service.  For example, whenever a service is
> woken it *must* return to the caller of svc_recv(), just in case it was
> woken by svc_wake_up().  It cannot test if there is work to do, and if
> not - go back to sleep.  It provides a cleaner implementation of the
> pattern to *always* queue the work.  i.e. *always* set the flag.  Which
> ever thread first sees and clears the flag will return to caller and
> perform the required work.  If the woken thread doesn't find anything
> to do, it could go back to sleep (though currently it doesn't).
>=20
> If that more convincing?

Well, that makes sense if TASK_PENDING means the same as XPT_BUSY
except it marks the whole pool busy instead of only a particular
transport.

We're always setting XPT_BUSY this way, for instance -- if there's
work to do, whether or not a wake-up was successful, this bit is
set.

The meaning of TASK_PENDING before this patch was "the wake-up
didn't succeed, so make sure to go back and look for the work".
Your patch changes that.

So, perhaps the patch description needs to document that
particular change in semantics rather than describing only the
code changes. Or we could rename the bit SP_BUSY or something a
little more self-explanatory.

(A more crazy idea would be to add a phony transport to each
pool that acts as the locus for these transportless tasks).

I do not object to the patch. It's just hard to square up the
current description with the patch itself. Speaking, of course,
as someone who will no doubt have to read this description
in a year or two and ask "what were we thinking?"


> Thanks,
> NeilBrown
>=20
>=20
>>=20
>>=20
>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>> ---
>>> net/sunrpc/svc_xprt.c | 8 +++++---
>>> 1 file changed, 5 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>>> index cd92cb54132d..380fb3caea4c 100644
>>> --- a/net/sunrpc/svc_xprt.c
>>> +++ b/net/sunrpc/svc_xprt.c
>>> @@ -581,8 +581,8 @@ void svc_wake_up(struct svc_serv *serv)
>>> {
>>> struct svc_pool *pool =3D &serv->sv_pools[0];
>>>=20
>>> - if (!svc_pool_wake_idle_thread(serv, pool))
>>> - set_bit(SP_TASK_PENDING, &pool->sp_flags);
>>> + set_bit(SP_TASK_PENDING, &pool->sp_flags);
>>> + svc_pool_wake_idle_thread(serv, pool);
>>> }
>>> EXPORT_SYMBOL_GPL(svc_wake_up);
>>>=20
>>> @@ -704,7 +704,7 @@ rqst_should_sleep(struct svc_rqst *rqstp)
>>> struct svc_pool *pool =3D rqstp->rq_pool;
>>>=20
>>> /* did someone call svc_wake_up? */
>>> - if (test_and_clear_bit(SP_TASK_PENDING, &pool->sp_flags))
>>> + if (test_bit(SP_TASK_PENDING, &pool->sp_flags))
>>> return false;
>>>=20
>>> /* was a socket queued? */
>>> @@ -750,6 +750,7 @@ static struct svc_xprt *svc_get_next_xprt(struct sv=
c_rqst *rqstp)
>>>=20
>>> set_bit(RQ_BUSY, &rqstp->rq_flags);
>>> smp_mb__after_atomic();
>>> + clear_bit(SP_TASK_PENDING, &pool->sp_flags);
>>=20
>> Why wouldn't this go before the smp_mb__after_atomic()?
>>=20
>>=20
>>> rqstp->rq_xprt =3D svc_xprt_dequeue(pool);
>>> if (rqstp->rq_xprt) {
>>> trace_svc_pool_awoken(rqstp);
>>> @@ -761,6 +762,7 @@ static struct svc_xprt *svc_get_next_xprt(struct sv=
c_rqst *rqstp)
>>> percpu_counter_inc(&pool->sp_threads_no_work);
>>> return NULL;
>>> out_found:
>>> + clear_bit(SP_TASK_PENDING, &pool->sp_flags);
>>=20
>> clear_bit_unlock ?
>>=20
>>> /* Normally we will wait up to 5 seconds for any required
>>>  * cache information to be provided.
>>>  */
>>> --=20
>>> 2.40.1
>>>=20
>>=20
>> --=20
>> Chuck Lever


--
Chuck Lever


