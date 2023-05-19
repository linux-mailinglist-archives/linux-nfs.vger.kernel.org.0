Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88969709867
	for <lists+linux-nfs@lfdr.de>; Fri, 19 May 2023 15:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjESNgE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 May 2023 09:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjESNgC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 May 2023 09:36:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC05B13A;
        Fri, 19 May 2023 06:35:57 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JCiciZ016699;
        Fri, 19 May 2023 13:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5gW13kNZuBT74BAVhsecCqFOEn7Zrv08ZBINSC+8Kmk=;
 b=fkM+oyCyLti5q0cykbu0hPfkfDSYJdNILrTCFwWeW+CVTLqdyq2tyoSI+aHG74Q7oD30
 IOBotP5vWmu8pyWiJRlyFru0w2eK8ZsXq1oTNV+a6EquIx44igJGSirqIvjfuOHZok0I
 s1tQArQYzxXTNXuQSDxebJCl3J8XDYYudsmuTlrBgCG8VC0/GHBgkSMcADylTlyWxoH4
 buz1XbroNX3NK8Tk0VWiRR09GQhsm2oJufDsvuSazo5NLJhNn1fz1ZaCd0ptdNLHgrpD
 nia8ZVzmdc6+n3F9tIMbNS/up3Tdaku9T5fytDNKOlkjyoxstiY2+rlSG+aEg32bBGhm cw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdtku6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 13:35:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34JDScZM032163;
        Fri, 19 May 2023 13:35:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10e53fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 13:35:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=it0ufuLaFstTwvcomJr7dqBb6B3/1PELICiXiZgRUkyMbwQGkjkRv10efeterL0gvVsmCipohJxoh5VE1uO1n6YrMPsrwMgtsk0cdFQRx+w9tsZwRNEXJMZ+SivslLNJNTHbTqacAK+NUc9Q5Ja71bRAoOmgRgt5ad69Pseq7QdjkMdhr6Jaqvc7gknuiLjY+dAvFs+xCGcCWXSc+DMDOO/4b4fruucKVgwPngYIflS0/OVeRgXCzveSUEuh8eiJrofUSTqvYAunpEq+CBVdHeQapkuUIX6WFe21Xbu3ukuvXv6gZgWo0lKCUzSiNN5dZVlNGcfdjDNCu+bXyAwcEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gW13kNZuBT74BAVhsecCqFOEn7Zrv08ZBINSC+8Kmk=;
 b=lcMs6dPDb8sbe/InihNssDYKDyGc+ruCdRWb3AyF71NIR72gN0tCvvJihqwEbXt+75QrP4wOWuQk5+K+dsAJAZI7aWOrjgF9uXaG4krSW+PzuPs6TGts72HR3C7FDTm5/jewLNKhYzPm/f/wh7lC1s2rsAJOJsCuuRxZpUdXX+BWTqNaY5W1hkNyeWM8ndVcnr6RQ72/wzPD7S8r10FhFK2g8h4Pk0APwoeDX/DzHzkHLPCTpASkutCoHtMcyT4Sv6gCU4Uh/Gri0jzq9kFue2MBPgVOy31BlwJvJtXsFTTtxpvJS1ZLuFBRNrvnca7uDyFOr/feHwX0YL7D6TFBeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gW13kNZuBT74BAVhsecCqFOEn7Zrv08ZBINSC+8Kmk=;
 b=pQ9t1gEPwFFmAGezoCpw3S23eTiawQIWmd0h1X6mHHFvGwQVGW9S6Muav3nbnfK3xX2riGzgYthL3qsCLpNVwnqZeIvA8qJX/6oZv646/R8l3Tb+xxfpMwMgSmSXqufDqAe0i54P3bT3DmZloW1jmfvH1kNJIa+wEyQeB0KKl7I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4174.namprd10.prod.outlook.com (2603:10b6:208:1dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.20; Fri, 19 May
 2023 13:35:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 13:35:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>, Zhi Li <yieli@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: make a copy of struct iattr before calling
 notify_change
Thread-Topic: [PATCH] nfsd: make a copy of struct iattr before calling
 notify_change
Thread-Index: AQHZiNxjTBHmZLbinU6qeN9/OzGsKK9hYmyAgAA5dQA=
Date:   Fri, 19 May 2023 13:35:51 +0000
Message-ID: <C610C3F6-B597-475E-8BB8-D3AA0B21BF45@oracle.com>
References: <20230517162645.254512-1-jlayton@kernel.org>
 <f281d4b831d71ebe86e48c0f45b82b05276bc655.camel@kernel.org>
In-Reply-To: <f281d4b831d71ebe86e48c0f45b82b05276bc655.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4174:EE_
x-ms-office365-filtering-correlation-id: 0d92f1f3-63e2-43f3-765d-08db586df680
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: olHS3Ij6m88E4CovtmLrRwodHl9bRyDt0J9ykvTjq/QgNOg7abuAOi7v1Hb+6te5wPLVWRfdkQztbLBOWx+juGND94bN1GNMrGVox6LEnILwScOR8YHYEs9OgVVdEBGM/qI49fIFdXu4LX5R78zsDSsDvm3wJbgU9S5vrgtA478X+XuVUZjVhJydRgFOhMnRU4RV3rAlux+z47aMwQgNIoQMwYrP+G+qOVWC31PlTWn7Wb3jEqN0v+tSVVOkbdP7zJUkQER7phOUymKxdBcdkjdv/x8lTh/taKHrWCT5uMHSB4Wox/EJYNBC2DvzUDvSHLKIsRxgvg62FB4oemlxm4k3xgC8olyxRdJgCcbWgy3LjKEXkpj3fkYdhIkqxllMZPU9mFZN9HWnnSARu6b2b6483E+Bst9scAQgqzDBKLQcc5K5G9FzQu8kfpQr3r13s8s1HoiifFpGsSfyr5P9TDgxEB9ee1R+KUZPL3Rk5ILaDf6VagSC38aCYzal32i2b8Quuox/l/ARmXWZmEL0YExf8N48Bq8OVU2YY2xGLvNYd0YA1y98rDZWcDPh/ZNNqbP6noIihITk6fOxc94hNCz5a2xecxpV79KTUZcwit3DtKnCtiduGa9rPlR53uoo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199021)(8676002)(86362001)(66476007)(33656002)(8936002)(4326008)(66556008)(76116006)(54906003)(38070700005)(38100700002)(66446008)(122000001)(316002)(64756008)(66946007)(91956017)(41300700001)(2906002)(36756003)(110136005)(83380400001)(478600001)(2616005)(71200400001)(966005)(6486002)(26005)(5660300002)(53546011)(6512007)(186003)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?khCkTNoOio+672ENijlUSw3V3ytrp0lPuBo0X26wAtRixY+0a3nMTmhIDTrE?=
 =?us-ascii?Q?yrcu/R8cYZIRULkHXVCfYYE3JDyFtrxeN6HnVNs6IuZKQ7EdQhorM1WJJm0G?=
 =?us-ascii?Q?eEuK63g2NvgAHEIg4387Co8DvgEvrizL6ZZRqBdiGe0MlXvvdKHjY1DR297G?=
 =?us-ascii?Q?KvPkhaYUgHmEY/7ZX9VHzEG81iIMsxC6g3Jqu6LaXQwcLVqBIY1UM+2INW1b?=
 =?us-ascii?Q?5h318ornrYsK3h5CsvIL4o9AdS5Id0dJ0W62zZxlwk9KX/Q+LE3cqndpzTZA?=
 =?us-ascii?Q?Yp0yIlrtSDLZSBRZp32EetQqbtXj8JWCMbWYTOxxgdwlYjICOgGVvOQDkbDl?=
 =?us-ascii?Q?Yo2cYrngHMtxPF/uC8QVaDeDEBIAl8pU/FxD0k8eKzRdDIzW4llrxa4bqyzR?=
 =?us-ascii?Q?+XQTZPvKY/wVd9Cd5btLBDhJjcRG66oFOjt+VueDF8vX6Uv+63tzoP5LfKOb?=
 =?us-ascii?Q?bK/e2/8wYynehkULarBGp4pQyrFVa38WSLHgypWTPsaU7UcMHlueOt2xA9Td?=
 =?us-ascii?Q?9IEQicpB4CXceOJ+MFNKpE67wrlaNTRKovwqD8fE/DufueMZa/Mx7/nScK7k?=
 =?us-ascii?Q?78y+7GXhncsEjI3OvRr/6nvFxE5rgCLh5AOgYVlUkl9mIiK4PjgsSd3V306p?=
 =?us-ascii?Q?WxatAcyyGNT72s8SX+nhDupY6vnDT8wD6K7yS8v00MKt/D0dZCdaDO5CNFVd?=
 =?us-ascii?Q?s0/kjed9wzAMjGclBTjOb2HtyujLdimpZizpjQuDItbbpCRD//aaxT7XJh74?=
 =?us-ascii?Q?0idiZaF7x0NNPG54LP7+UpZ3/xSGwU7PktOvw6niUqylkzj93MIMxKo6c0qb?=
 =?us-ascii?Q?dYRPTTi3f2k0YlIlpL0zhrjrMB59jFvYQqUi8Cl9/KlXA2zSGpOhORuNom1k?=
 =?us-ascii?Q?HUDGn6FwkwcLDL6bP2xnuXiD2bc49PjyBsY5JZuwy/sum5HVkPfoxFr9qYZy?=
 =?us-ascii?Q?Jgpbm8QeJil+T6zK4Y9AzpANvdfiecr2koohq1ORl/PdJBBg1Rn5ib/oY99O?=
 =?us-ascii?Q?k+VWuoUFfFNOV8NTpRawHxiS/NRPtBi3lfY6Z8zL2pgk1bmpZq1PbiM3k9z4?=
 =?us-ascii?Q?2Lej99zfI0w9IJvEuIe0Ej2r9DUf/bdxs4imMkDKhEusXm5TtiDOzD0WPIfg?=
 =?us-ascii?Q?tRYZJxPpn+1w1dc5mmptF/CnAo1UV1MzFpDYScnAU6Sn3nwfhqd3gwu8KoWv?=
 =?us-ascii?Q?S33bN11HnVytzeD7KybJ7hDuMLJLx0ZDv9leddAgdny2nVARwQJWpc1pkxUL?=
 =?us-ascii?Q?Wq1khpmKHW6EJcoy9d0RzlZnrYCIQyJrD3IzKz2NJB6vSUpkqiA6jjDXuw+i?=
 =?us-ascii?Q?rfXePZsWDzya3zC69Cn2lLNpyaxJVQfX98pYG9+N1eWoTQX7tDKnAQc7umDJ?=
 =?us-ascii?Q?dRCe6/TpVd7kJNB23lF14AZ1oinlqIG/GaaeWwEEbqeRJ/URH8PVx3yT+th1?=
 =?us-ascii?Q?Oc9Qtxbwr51DJYnmZiHYGwC3PvA7jgaZahfsXgQ64X5TGwMTiak5HyM4EJKC?=
 =?us-ascii?Q?9tgjYiyAOIJLclFIIwaAtbljxuulpE/8znLOCRttzWhFVBYjtICr9fSRR4CV?=
 =?us-ascii?Q?fvVDvM7PNEellV9jVyv6+aTqPMQf+e8ZvvwwChl69Tl8yFTMFEoTeTwYLkaG?=
 =?us-ascii?Q?hA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <88EAD4740CA12B46BFE24B955094BF86@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9veAbeUnSonanyq4+64EZQE/FQm+lEnl/RYS+eeM25lXGaPblaGcyKNq7oWGoqdryaTn/ZhkMD+jwA9rhVbEM8DqJ29Th+WN/Gysc5DHbOWm4GbJ+ajuZZNnCmyvYhEqCF5/4Y724G+sxFcyr7L3v5OE0Q8TErzp/W0btGu1nV3/HI70JSJMxaJpBy3sGIeE4SnGpn+zmybenqgPhgl90UvwbRPMtvOUtMo3KwVSKM4zstZNjznDG4AvAAAYjMcsu7Up+WOG0GTw8s8FiKVBrL0HsnD5TiHWxEfNtVOlDH0NmrfV8GH+2DmKrHFxSOcOWqQUmymiZUd1BBbJv335PhznqsYj33lKJplOfxz0s0PVIHUHYRwtp7qDm9MrkwlfFi+qI5d18LnSrZidINj7ewqiQFmc3VnsDHrn4D0CUlJnJUsN6yV2b7bpht3GdfiM3JpbI8y4eKaG3ql+1wk5lJwaXDTxz3nvoubimxm1+QQ/qG1txb6TlVq2vCCX6eHX/82AMj796HUpxUCKJ32mYACIXIJiDijppKDiHcXrUt1lQ4oPLyC+tCQ+mxrZmhIpndAsYxzJhC7dYsURhtDhqn+zwwF4jmw8L2yxhnXjPNYK/4jmV4uCRekc9nEDpg/8P11OCpe1Ngw+F0QiYjZDJwz2dZfxp+Elmix0xYzmwmxr7ZAua8L+TnFk860rpnlA+qsdofbuSfw+hoLTAheSiV/tu0OeKH3MaFl6rqp06q+ioneceo4LaJqvctvj/JwU8LVoqDRISOiqljkg+L87OLiVnNmKyfHpFI+EaoZpX8Mq0cx8Anx/xKOejai1AfyO
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d92f1f3-63e2-43f3-765d-08db586df680
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 13:35:51.3112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WCre4N+9I4Vx7UTfuGbHaA93KSpoiUotcPdx9cQVxB4DD5W9ucFdk1rBYsBBRMCkXoQk9C9XG92V7ueRPz42Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_09,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190114
X-Proofpoint-GUID: cgDzDpfkxjfx9sc-W21QBk6OpISDdzZl
X-Proofpoint-ORIG-GUID: cgDzDpfkxjfx9sc-W21QBk6OpISDdzZl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 19, 2023, at 6:10 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Wed, 2023-05-17 at 12:26 -0400, Jeff Layton wrote:
>> notify_change can modify the iattr structure. In particular it can can
>> end up setting ATTR_MODE when ATTR_KILL_SUID is already set, causing a
>> BUG() if the same iattr is passed to notify_change more than once.
>>=20
>> Make a copy of the struct iattr before calling notify_change.
>>=20
>> Fixes: 34b91dda7124 NFSD: Make nfsd4_setattr() wait before returning NFS=
4ERR_DELAY
>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2207969
>> Reported-by: Zhi Li <yieli@redhat.com>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>> fs/nfsd/vfs.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index c4ef24c5ffd0..ad0c5cd900b1 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -538,7 +538,9 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
>>=20
>> inode_lock(inode);
>> for (retries =3D 1;;) {
>> - host_err =3D __nfsd_setattr(dentry, iap);
>> + struct iattr attrs =3D *iap;
>> +
>> + host_err =3D __nfsd_setattr(dentry, &attrs);
>> if (host_err !=3D -EAGAIN || !retries--)
>> break;
>> if (!nfsd_wait_for_delegreturn(rqstp, inode))
>=20
> Zhi Li tested the test kernel for this today and this seems to have
> fixed the issue. I think you can add:
>=20
> Tested-by: Zhi Li <yieli@redhat.com>

Thanks to you both. Applied to nfsd-fixes for the next 6.4-rc PR.

--
Chuck Lever


