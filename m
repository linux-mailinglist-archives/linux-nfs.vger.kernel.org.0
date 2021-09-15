Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B6540CEF7
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Sep 2021 23:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhIOVqG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Sep 2021 17:46:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47108 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232127AbhIOVqG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Sep 2021 17:46:06 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FLYL8X022288
        for <linux-nfs@vger.kernel.org>; Wed, 15 Sep 2021 21:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JbU6lmhFzu+Pd5KUSdFetKXW4BIl3IGFQ2yPuhQ189A=;
 b=YOENE00GdUc/RHLC3owMrm8h6pP/GOTr2MQ3ujUgpPzShd5q71LALuH/odw+7XI9MqZH
 ARcBW1HXD1zIcFzKJoykis0DQ1Q2G1OOXQGrq01uH+0w1Z+eNcwO1XaN/8QrCTGWplvK
 TeXL9QZyte5D4tEQSgjygm59UfH5FPbLCefYTS1RRPIrgYLLmJTgGiWPMABRhFkT4YIg
 z/qyE2fBh91ZGDeQ5tF1R7gbP4H58NJLEdExrZJH42mOocWoXyZXe0Ml3aFo2Vn41Vue
 uQSO2DKxGHAwO/GI5oLxwCaHucR51CHrYY/LbzLEgrXXs4LShHMWZr8lh6x9FIOzN/td xg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=JbU6lmhFzu+Pd5KUSdFetKXW4BIl3IGFQ2yPuhQ189A=;
 b=MoBkDzf8eWX/pF4KEos1+mgP1nVzZcAwN7QwxR4CctZGjqcFkkK7PDgonGs1HXuo/e8f
 iKDia8TKffpHdFFEdZVfKzhaexL8x/BbfVSXJuike9+4J7IeR9wlYbhgxdI90zJxpEAI
 KdsxnEajWxCC7fM0bv3thpLmDy5WllX2VJh8j07S8N5+P9hI+sRCEvyjpEDgfsQdTX+n
 J/x9KxWCwFkkU6CyoV1ZmemU9u5588uhsuQyZCDSs5nGLfFIfCtCqWiWOAIUaXEBMSAs
 ivSIJ/Ubpt2VabWqyh2FAUIOig+l3j+b1IFnHWfqcL5V2r1oT4yL7F43r0twHqWIasrj dQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p8tegp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 15 Sep 2021 21:44:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18FLabkX019448
        for <linux-nfs@vger.kernel.org>; Wed, 15 Sep 2021 21:44:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3030.oracle.com with ESMTP id 3b0jgf7517-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 15 Sep 2021 21:44:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWsUXcmD17pjaMPupKtmYLSB4qHGDi4lXPWVC6jC9pzh8JXedVm66duidtTro+h/jlabrb4AS+MpnjxCESCvOQm4QF74rIG7Y/mkkYi0Wg7pnDQdAo3YyFLsVdYK4kjLZ+hIHWOQHqoTz4XlcNwXGOrYU1NpqZ9G3AIVVEpovwC+uq+n+OJokWWbvh55oDa/U8nPOu7Zxl2qfKjD3JcqJCc34f0a5M9z4aUwnnbPERYprADbuDFxP5FSFUr140Q44AVwRb/pHGjqrP/QHXva4k0tSR/FvsQFRKo/eWehpxsW/iv1tmwuzj0D3DauFDHYfP8NSPkS7lTp9KMmWaQ0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JbU6lmhFzu+Pd5KUSdFetKXW4BIl3IGFQ2yPuhQ189A=;
 b=JfRcvNymo2FaeqK8kts7P5uxqVnzhnKIkYzvInHaLqTrGbjQbdi5TSB+7bnaTMhYIrii9FOwMvs6umTOA2oKgjB5N+F3bG8UbRKBpUGImUKejLFfOwQlXrihQ1BBNNV2XgxqLSFkLqjbnQpUDLjE29zeSPRAy257NCZVo/DldBfq+mz13tqNPUy5JEfbX8D0g3iMuxhwt3NxHG66tCfFokXZOwzuSp/dPmWxR18LWEhyUAzCgmuZnT7PRJ/kbMH68jInN1vpLar+L1CktsnLxzXVqDJ2zGiRNmtUmMQ9BUv5hhu1lzQJQcXyDyuDsPiY22LJ2jCtBfTVVVlBUTC+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbU6lmhFzu+Pd5KUSdFetKXW4BIl3IGFQ2yPuhQ189A=;
 b=Jo3d3aSyKUPTVeZ/zqHlWgpeRHCMrQCDKcgOXLTpBFytWnBaqoUcpbYRKMDwNG+a3hSazYKUvjjQDvx25yqKdw5sb+xdvSHixinaNgmHNa9Mz8Wo2neZj5UdIKpiFQ0FgZ0GQ0W4As3TEQwOX1MCiB1c6K2Nys6Q7C9FFV6yk+g=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4816.namprd10.prod.outlook.com (2603:10b6:a03:2d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 21:44:44 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 21:44:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] lockd: crashes in svcxdr_encode_owner
Thread-Topic: [PATCH 1/1] lockd: crashes in svcxdr_encode_owner
Thread-Index: AQHXqnlJbiEOUuUb70iRUDrVD1au8quloNaA
Date:   Wed, 15 Sep 2021 21:44:44 +0000
Message-ID: <4BAA4889-1919-4231-8402-8DF0B0706417@oracle.com>
References: <20210915213300.25066-1-dai.ngo@oracle.com>
In-Reply-To: <20210915213300.25066-1-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54aa2804-80bd-420f-6030-08d9789207d1
x-ms-traffictypediagnostic: SJ0PR10MB4816:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB48165234A5FA28EAD3EF50B093DB9@SJ0PR10MB4816.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D1+mmJvlTXeaz+sN01F3XU/PZJxOpYp16q4NCrWNQ0QWlKF+CoIwqMaq6zwEK+Hoh5/W1eX3Z73PO6aInJ4i46NgsOlgok/g40nTbKy3ZKJ0CeKK1r03cmDMCl4PKfF7CDJkaSgGdGqcDwfrQzdTIZgS/6zSLzXbjq2Mph2YTyyhYewACkG6PBA6y8fhckJDEf+zKKJjHBg5h4uPm4T2n34ehlD7IDc/YzujXVDlWe9MZ8q2HyJCI5O7D70k3PKeEyCN4S+mXdkCQjpoJNhqSGtIwCDRKJBvVKbZm0G/tQw9D+KzPRRjx/lZwlRQkReD2YDLNJpzyDPJvoSpmEb+BHYwckC3DU91ZFO8qo6iAD1L5yoaV8YieEtwvrqCXfqzLF7PrrRJZFtX8M0yi/OGFdAfdCS21OVqmD4j5ifYb4KjLdX5dcRDw3v9aO/csxqBwMGxofJTjkknumYizUgfx0TjA4Xp4KKO1GZW4SI0dT4Ux9/kDQnxHgN45/2uV62mVs2B9juUrksso5lhKEtNceICccW2Pe8uAZfngpaxptwUFdC0huYxMaTrZreQHSV5ihmy3gefhgVRAk0H8bvVsOgjs06B++Me6ZzFDbQZA36OuAvYSIWq0kTqDXBOL0CXmC0JSpsuE+91UUA0TvLlvG7Hgw1jccLoHYZUzTusB7Vy1W8oUEadBGbQi9532oG152SOTbCYanLHckD7ceA1IKRv7l8WDkSOXy4PMSTylZ0YAN/4YM0AYW9FerqIABFx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(8676002)(86362001)(66556008)(66476007)(6512007)(76116006)(66446008)(122000001)(91956017)(26005)(5660300002)(316002)(83380400001)(66946007)(4744005)(53546011)(6636002)(37006003)(64756008)(6862004)(6506007)(33656002)(38070700005)(8936002)(2906002)(508600001)(4326008)(71200400001)(2616005)(6486002)(36756003)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t9gUdQqEY3AjRC7ECnIE1HGHv8ulTv3Xf2UOCPyF10eHK7kP8doKCs+lRBSi?=
 =?us-ascii?Q?2z0ZdLg0XoVDz+UBM6WBj3KNTCxUwYac3W6ZZ7t0wKpzdr72iHTww6XVo6dB?=
 =?us-ascii?Q?f30nU52X0BPT85cwFtfm8BE0tHimfH76zlMa5HGFkSEUeymLIK7Zars07b0s?=
 =?us-ascii?Q?1C+smrGmdp09x68vTVlv0t+TFKzsKD+wX+4PGh3Yl+YOR1UiYnsn8wpedDrw?=
 =?us-ascii?Q?JJFkgMe9w302+iCGyEedw/RPq8WeutxkSHOAT2rgSN9OZJzgxCfZYoxmoXDm?=
 =?us-ascii?Q?6wt40bYSDgiHE2+Y67Kpd18Bt/rri+Ywq+idgz5bZULYQw26/TNAisLquZED?=
 =?us-ascii?Q?Tzxs+hDncQCMz//EOEsvr2gPKCFXAmZue1KVDfhnbthAKqbIpftPp+mJnsA4?=
 =?us-ascii?Q?r9f8aUf/6RGfB5Vykk7ic73pAnemmOksAJ6cRY4mN3ZAvUWdHr9K+xdAwFaF?=
 =?us-ascii?Q?ODceNrEkNStJd3VIrjXPahBR3v5qHfqu2DQJyUyn7SgHoPHN0mspAhnYv9wE?=
 =?us-ascii?Q?B0VYOCQRC5oO1mu5r13uNXvVS2sqXhtXKJAin+K1FzP8bmLE0FvVpk9FRZ4+?=
 =?us-ascii?Q?fGHv+lg+qd78Y55nhec+tp45O/16wZhftyqQsUfDlzl07EObt3b4GwojrALP?=
 =?us-ascii?Q?X1N5iBcXKU2++zEWd+qTg+EaAVJj7wg5HzIf+Ver5GhD3049tocpEBHRYK4W?=
 =?us-ascii?Q?enM88vUf+fCE8WFot0n4NoSW5vH7gQ+ObzBQgbyb4l0+EOZlUQTFqdDaXwq8?=
 =?us-ascii?Q?BaWhsqoc27pBSiGJgwRHK4tUb/txHAzRqRApszw47plSmNaZ3UnoS2qF+hJz?=
 =?us-ascii?Q?Oskdw/32HI08pAjnPr+SZ8Yu3hD7M78RWzjA2h+nwRMa0odgvkvQMJZIDDYf?=
 =?us-ascii?Q?P1wJLVvGs+wdiLvfdY4F/r+pHu4FOfut0EvRjNowdIDnKUpXvFQ7ZW6XdNJF?=
 =?us-ascii?Q?og7HE6vr2EZ9FKvVISLmKxxLSoK7BsRLc74Iepi8p3c50Xgv3auy6smVouYP?=
 =?us-ascii?Q?+aY0AqGVA+Dm2iD6o5UnmMpLtlOR3rJ4SCtzhGTslAFBB4HeONWmJKen2IpJ?=
 =?us-ascii?Q?lSAMNGxdd2pclvVx4C28WFcR8zxzFvbvwD3hGMLiYTSbPZ5lyyNzhpzspmSj?=
 =?us-ascii?Q?vfUVEgpg3IHHEUejnTud02stUWCxMY2llokJUuDXOgJ0rFerEBbINO7ZUQmz?=
 =?us-ascii?Q?+2YH3Ee0S5R6XzRng7D1z4/cCVX9bLN3JkuedfH7FJIaXBFzdj86VKxROgi7?=
 =?us-ascii?Q?dtX1tNVzZp0pnqE64XRaoOCVTDUUgp26y+303NayyAqFSxW+K565nykM3+km?=
 =?us-ascii?Q?9055xw3AEYinIE+qG18j+glC?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D809F27C646A2F47897906EF21EEE1AB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54aa2804-80bd-420f-6030-08d9789207d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 21:44:44.0868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZPaLp89745ChI/Yii/5dQefKgs4dKOGdbadtAjztZIIElL/hVCs58eN7OfXRuOPrR6icGZKQPhfBgdAuuE3rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4816
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10108 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109150124
X-Proofpoint-GUID: Zq3DiWu1bItOmK0V6iQrRHyn08jJDVyt
X-Proofpoint-ORIG-GUID: Zq3DiWu1bItOmK0V6iQrRHyn08jJDVyt
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dai-

> On Sep 15, 2021, at 5:33 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> svcxdr_encode_owner needs to handle case where no lock owner
> info to pass back, obj->len =3D=3D 0.
>=20
> Fixes: a6a63ca5652e ("lockd: Common NLM XDR helpers")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

This seems like 5.15-rc material, so I will apply it to my -rc branch
once review is complete.


> ---
> fs/lockd/svcxdr.h | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/lockd/svcxdr.h b/fs/lockd/svcxdr.h
> index c69a0bb76c94..04fde20ea8c1 100644
> --- a/fs/lockd/svcxdr.h
> +++ b/fs/lockd/svcxdr.h
> @@ -139,6 +139,8 @@ svcxdr_encode_owner(struct xdr_stream *xdr, const str=
uct xdr_netobj *obj)
>=20
> 	if (xdr_stream_encode_u32(xdr, obj->len) < 0)
> 		return false;
> +	if (obj->len =3D=3D 0)
> +		return true;
> 	p =3D xdr_reserve_space(xdr, obj->len);
> 	if (!p)
> 		return false;
> --=20
> 2.9.5
>=20

--
Chuck Lever



