Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B44D6FF4F0
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 16:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbjEKOuS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 May 2023 10:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbjEKOtl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 May 2023 10:49:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6122102;
        Thu, 11 May 2023 07:48:07 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BDwi7C002732;
        Thu, 11 May 2023 14:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CMRtUueoaQb656WqDEtDe/SznSxU+TBxSIBjZyYRd0Q=;
 b=ewhS1kr99nURHryXrCffIyV5a+QOe4ePBzo5RpsZk6LtXVP1AnNj99uZfNIBmj4UiuoO
 3uPQfx3R1WfJ3Zwy0RiV9zspSDx70GDIcJWfPrxEZMiS+RNaUitXM4zqzFlbml+OY2ks
 hlQD0uCP0leO2D1fHjgEcAucUCIM3mjpfYhmbb9paVGGhnNbEW+MO1f5oC0xuj4AjcEI
 wzhIgHvsExGgmQE2g2eRGnFRFbmMwE/XB3zLrAJZ4Zk9Zztalgg/qhap5HjjA7NFWgm0
 bQbxZgKYEjuqU8pI9NR72zVF8NNy33q2jsm2jYYeoStlsZrzrEuhHNAVnQ6AUgIGFpCP Cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7757e1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 14:47:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34BEQP4E004446;
        Thu, 11 May 2023 14:47:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7pm419p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 14:47:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1d9fzkWqIpzjS2eFNNxDuFhNNXudSrououxfupkjRHZ4ZzA1tknin0asBn7svEV63UQCinMrGjgQ4TkwU7ViqPd1lojTkkH7De4k7WZYnfZo9Ml+ngpVBngQHN7MLqi2ARHaD5umDs1lCtUCdT65lUYOlEM3ggsZEB7nSodVKHYx2dIr1sgLT4kez151VtXhGDx4ETj/+uEBNhFL1N4dTg0n41B1zjoI2jo6fS5ZxGH3SIRBL4jjVPeBuPH1UycnRBqcaVzLhRMFj1c2Wgyv0p5p7A250qc5n0weg8uLpfXUBqtrBq3TQD/N6vh22/56t4W6V18Is53zvqyEDJzWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMRtUueoaQb656WqDEtDe/SznSxU+TBxSIBjZyYRd0Q=;
 b=Nj+76H+9GMtM8TmZp/zH1ewVKdfa7tILWW4bCnjIarTWcXlzjSOsrwZVDDKREtPOLX4T5nejGngtrAK/nVjI6LTFQSYlisXVzHTfw7Wey4npocA0/qUQfRhzoTtOLqMfKnTYFH7Kn9qA/Hhq2PpHLZYf+F8SgC/VJWCcOtg8vaaTBvF9sj573nQCgxaSszCyBucJxqPywCM+SlUFng359O8SQLZkfOGqL7L6QNFssEdRRoqlXN2hMnsZ5L6PjzGORo8uX3fLUNi+9n6UjVodovSs2hOkXv3cP09C0eGhMXkXARIHXtHW9NytUI6CaLGm0JxPfKM0PNTb244GmMgZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMRtUueoaQb656WqDEtDe/SznSxU+TBxSIBjZyYRd0Q=;
 b=EJ//z6Q91BHlB2SbP48L/N9A3KQ8OP4ee95336JS5suo/f+yUT3+EbGsXmkqoqxwqmGtjshGjQ01Ke1AD0Q6UtkcMIl3lXhqwZjEgDVDx7scALqCZZEKjRQPp1ObSlJesQwqHbAWtzmFgvoxEBWnM+RXL2O/P7ZupgxPEuTZ2/M=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ1PR10MB5929.namprd10.prod.outlook.com (2603:10b6:a03:48c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Thu, 11 May
 2023 14:47:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6387.022; Thu, 11 May 2023
 14:47:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFSD: Replace all non-returning strlcpy with strscpy
Thread-Topic: [PATCH] NFSD: Replace all non-returning strlcpy with strscpy
Thread-Index: AQHZg4w4w644hNPMzEqt/IwppCpl6q9VJ/yA
Date:   Thu, 11 May 2023 14:47:54 +0000
Message-ID: <72239648-C807-4CDD-8DA7-18440C83384E@oracle.com>
References: <20230510220952.3507366-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230510220952.3507366-1-azeemshaikh38@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ1PR10MB5929:EE_
x-ms-office365-filtering-correlation-id: 190e35a5-4b27-4849-9bb3-08db522eb41e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZVl+yL8IjJ706tsIfqj1ypl/HmGmtqF6XYsdWnaVm75g5w3y9AasnAyfVS+RNsM420KCNP+arUQKMZdx09k9QdBBOw9lde0cw59IU4p2aMTPDGZyquu3GgxCWAgbulYhcQP1ngiLZ5UQtuYf9FDegsgmj7OD+wFT+TykppgcrKVePOpWQxp1RG7AFX7nAQqRtLXlrSEVfKhfLx2BP7CkvAcdbuJ65J19e1ai1VH0Pr50tlksl0e+F25idBVrSDMEYopd1FGZTOeMGIw8HPonxUoxfO37cpPfy/wXcksssoBEg4B4ep88RHQ5kp52aQI4dutyqRMIWum3tZYyh/Jr/pLqVv2ZNUy7kYCJjGGByfxKAFYVp5bHRx9KvvMKrdFwCFXs0a3SEy5TvPZFRQufqjF2HDxn6UV3z/HVOyte3BjhgMtXIN6ax8zdZ+1Al/0+Ps+vsKMqHZ088+qin4g53CDDkpOxZqtdClO1InQHuxP9qbPM8PqdCpAiF7iKZn8yBQJzmd4QXMkfegdSjebR+aDHcBNJDsYdd9MMZSdhcG/uvcSQp62+0s/ar7lbZl7HpRsfoxnswcEL34EJ8pio+gmVuyKvEHditW38Bv4BoMcRckZXEJ6jlBacNkGQLpObQFP+L52QMhh+FWG+VFfYgB9LcA7hndHjD6XFe6NmOY7EdTQM7AIhvWjyzG91WGMQ0ji66sDrZTOM7hE7IU0UWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(6916009)(966005)(64756008)(66556008)(76116006)(66476007)(478600001)(4326008)(66946007)(91956017)(6486002)(54906003)(316002)(66446008)(36756003)(33656002)(5660300002)(83380400001)(6512007)(86362001)(26005)(2616005)(53546011)(41300700001)(8936002)(2906002)(6506007)(186003)(38100700002)(38070700005)(8676002)(122000001)(71200400001)(156123004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZHhNshjNOnomClncv+0qqJIZ1CQfdhGbIg1xZCW2m90yUYsF5sxuJN86cdaR?=
 =?us-ascii?Q?qGFAd8Pe1gUeEB7j9reckUB+PX5P4QAAZxLUpZkLbiF0uGIyV5tvHNFVMik8?=
 =?us-ascii?Q?n4MvmHKqjX+zMPh1gvXR0NwcRNPQKGylsvcm7W0/DaqX2nQA1l7vj7srKeD7?=
 =?us-ascii?Q?R19HS2w2O37V5m6zDZrF1V3E/UNbqCfMcLc/pDjGrk4nNAt05d3SjbmmQTjz?=
 =?us-ascii?Q?fBLIVKaY/yYgmqmKYb+viHaqiKhfF2pq2+WuK7//OX6TdLGlCae3AfMT6WX+?=
 =?us-ascii?Q?0TFnn9slFM9l120VdpIVMiewsXuOKM3QaB8xr31jPdJxOQ0ToLolmeHvwwPv?=
 =?us-ascii?Q?B39yMCrn0Bw2SNfyLoSYnqGHxsSHEQ6aSmgoyeknLd5ECq0Rv0VVgf1aOQzX?=
 =?us-ascii?Q?LVMBqmU3AK36443HQv0MFjuYXtLGv79SWGTLHRgWsofAJLSTiCFJ3pwF6YxM?=
 =?us-ascii?Q?JCu+7cz0GorbcX7+q1qajDFG52nML4u1EIMrzBnbhMwPh/VGzX9f2sP0dVTQ?=
 =?us-ascii?Q?VBYKA6sQu609klaE4MjkX9i8plu62ZFWaa7+mHualJTS0+On6L4j5+YSKCPq?=
 =?us-ascii?Q?n0rciju+u7M7GA6UHTjtadHAynlo4B3uE54ZnMZTYpTrPS5vlDcbQ4gqbCo/?=
 =?us-ascii?Q?iX6p3MCyig5ADRP7/aQicgujgSObWgZ3+TjPGO+x6JYEEa3MhW9LzEJNCQWm?=
 =?us-ascii?Q?xTMErll3jSnz/fXpPuXwZdIbdGy6yJRyWss+GPdaCnQJkaHkMssZM0z4B9L7?=
 =?us-ascii?Q?qwC52MPgqivLCQAbE0c05gUtUyytiuaRHycSJv7oFVdYPo5g3OYIbl8NATAp?=
 =?us-ascii?Q?DRJVtlCVGlovOGP+TxgbIyOEKsJZKsO7uV4/EkhaHcvhv18S6N3Nk3NEXIzv?=
 =?us-ascii?Q?BmAMV701oft92KSyENFBUR3RAFDrprJD5q7Hzy74eohSFg0PfTy6kCEQxihw?=
 =?us-ascii?Q?oXOMg77lpO8ovlShQAnW1oY3Je7qBYJjEkswV4dJo0CQY3MGyYgoblD3uZRA?=
 =?us-ascii?Q?1lt5C9Bsdd04pYNGYSDk6+m00eHvNLbo4gGlhB1WHFGyvKlJ5O+Sec8QF+6Z?=
 =?us-ascii?Q?g2ICCalBam3gVMNBMJxZgfqYjm6oWuZNr+dCAKKS8xhZT6SCJ1QsQoMnvBbd?=
 =?us-ascii?Q?xYwj3zi9iZj10J9iUmPytXwdqwf4fhsREHa9VE3AGm2G8rTGBrFHYSBn2NXR?=
 =?us-ascii?Q?aOqSRoWV6CXA5JgC/joKc+wBVPNlFCqH+zUeTMr3IsBtQh23SLvyQdxa2jYd?=
 =?us-ascii?Q?0WYJTpSVPv2+Mk0uZL+dqxA9pylPxARnmcmaQ05wVUNkjQRWxpwiuywuaDGI?=
 =?us-ascii?Q?3YI18XyPP51b1iih7ow95/pi5S6rthVFjGXVFGjtYiJ3ppXAVk2AY8e6xHKY?=
 =?us-ascii?Q?BIpcMsTy+9C0ObWZ3ub7PwVSaFlwUQ3w3aouCkhbGT3V7tS9vUu5U54HMHX/?=
 =?us-ascii?Q?PVOsQ1PhzWbPJ7WXKt1N6vsZ0zwGL6Ml907SM7v1IXIhQvuYmj7Gyj4lcwAj?=
 =?us-ascii?Q?SHtJe72Faw2mlKc0cEJ3QWzm6ToWa6c1yAhOq5Qc3bIVLyaBdU+ZzSwniaL4?=
 =?us-ascii?Q?PVoET2qpoaf+mfE0VUVJOR+wRolRwIokU1GXd8WepyeOLo0u6WD/TvhHKRGw?=
 =?us-ascii?Q?nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F247C1E5C7D3774E8E98C246C3691EB5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /y6ks7mE4MKZJ7P0lqcxejCUjCfr/FDduIvZEqqydGEJoQoO8B9UTyAhI6qjznIKC8HKN5qtvXShCv1DRRA4KhVI6VEwPsBQk8/bg4dE3vOY0Qh5PXgAVsKjX6aXjP8D7CYEevbT/i1/ZKabpxp4bs4536KUWl/cUYEzSSptR/tH44YWtsxvpSFGykl3gI/CEwr1P5C0hZVRvDAtnsul7yE6blhT+Z8xgLlUBTfLSXCBY8nHLvIuQTCd8D/kHxltke/2dDWm5g2c7t2lltE9pGGStbLGe05s4/hCnyH74v9znH/XvLh9zJs/g78wQ46GKmWjQEVNIAicAD2M8Fq+/LeH6hQ7BdELHe+7+XTaZv5R+9MSyHKs81K3piwz8VSllVhk+Om1lCH3CRsEf+cVnoDnAGUTYIE1XSwP6v2s9sj0IVxTua+9lSrnVpCtuvp0L5atw+H6T/8Qg4DyyeJq32Zf825hgAO/7k+rSU1SEUsdv9EFR8fftUrUO3+lFzv68/CJIj63YwZ9snugXiFHkA7lFA0nkMPC4rtqHfA89PaXGF+6jzM+8EwXZLHnWiY46D79TEE0nzmqFyrz0boun+A4dUtJqcAxV6eFdCXEoOxPX6Lbmvjk1SppePUzcTTru6sCfxD3BiRzCh9SJ8MpEs1bs0PZwNVI71E9fbtUvXZVPbq16PUORpE7VKZtv7VcN+GSUjDHKOXMsNHdo4ZEtL2/vZ+rMnc9H6vGAsrNdboxuuTRWBKBWp+W6phmXvErVaU+7f1Uz3lgFcYRnScFYJIORCx1UIBXkWLdvssuS+9BgC7GYZbZm5aaz3fy+6Sb
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190e35a5-4b27-4849-9bb3-08db522eb41e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 14:47:54.6472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wr2vM7buvdCCZn61SdY8zoopYP5zwJA+P/8/kQ/EvWLty45VLFU+bH3tu++27Hne5Pwz58WOe+6KkwDZA0DiYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5929
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=931 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110127
X-Proofpoint-GUID: xg9u6oicdVT7C4weFTkRI_gnHT7avbgR
X-Proofpoint-ORIG-GUID: xg9u6oicdVT7C4weFTkRI_gnHT7avbgR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Azeem -

> On May 10, 2023, at 3:09 PM, Azeem Shaikh <azeemshaikh38@gmail.com> wrote=
:
>=20
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.

Actually netid should use the __string() and __assign_str()
macros rather than open-coding a string copy, I think.


> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y
> [2] https://github.com/KSPP/linux/issues/89
>=20

I suggest adding:

Fixes: 3c92fba557c6 ("NFSD: Enhance the nfsd_cb_setup tracepoint")

> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
> fs/nfsd/trace.h |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 4183819ea082..9b32cda54808 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1370,7 +1370,7 @@ TRACE_EVENT(nfsd_cb_setup,
> TP_fast_assign(
> __entry->cl_boot =3D clp->cl_clientid.cl_boot;
> __entry->cl_id =3D clp->cl_clientid.cl_id;
> - strlcpy(__entry->netid, netid, sizeof(__entry->netid));
> + strscpy(__entry->netid, netid, sizeof(__entry->netid));
> __entry->authflavor =3D authflavor;
> __assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
>  clp->cl_cb_conn.cb_addrlen)
>=20

--
Chuck Lever


