Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7E878F20C
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 19:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344685AbjHaRky (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 13:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjHaRky (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 13:40:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D95E60
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 10:40:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VGQ0Qr009398;
        Thu, 31 Aug 2023 17:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5J2xI9ynQvWKNYqgdI1Ph5enzmGnQr/UcukTrX3lEWg=;
 b=yHleQHpPke37Thc7ZhwtF4ie/AWMMZhHD6y7lMFSZUxdBWODwNN/ZylmQ6a82v5kfQUX
 2SBo91ImrcZPEt7O202rvUFiPOhRA/HYoOrxsCiBLaxcJDPUxWqI4pz2h2fdCM7bY+Lt
 +s68IGpfOr/H1o/8ME/w6qabdIQbNLeH7G4rDEPPo0zTmCsvfYbqdIzT3TNcxzl+UXgM
 zbq0KYiKx3ndmC89PptznqBghf+EO26GnyYqxbn0WTsUogeVGwrBmqlG4vqr5HY11mRi
 a3AOqvucEN8XV2vDtSUvwG5PDTjhWSV3J9RrgXdDMhfov+LOebCrUBMMQlp/sCOJl+TC cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9xtae5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 17:40:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37VGFXV0014250;
        Thu, 31 Aug 2023 17:40:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6hr9kct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 17:40:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvjwbdCAWRMYwZNtGTrDWyLcPfbTSQpQLQrlYE4mSPRlb8SFQRfQWyR8pRD187ADYPMDM01BKzd5eJxEpjd9GX//dnIVB9e8sWfwPKuWp1Dd7/Pj3stdZQskS58h+nIwHeT0vPifB57u5dxbjBoAEkEg07NLDuuLDZubp/SRRVTKPNCyW58KgEytSK+HsGHUK8hwHS0l4J8GX57/+y5zdrY3yx4B5QC7DHnJlzb3Vwp3pDPkHFhpkFyu5vNsYYSl2fZPbTw6yMNlY+x5977X6O9MFGMoEW5W7Fi59fWKmPbMuqku9vdg18OXS90GFk4iU2pArbSjFSvWDiUe1kJjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5J2xI9ynQvWKNYqgdI1Ph5enzmGnQr/UcukTrX3lEWg=;
 b=VlMRPgB/S/T20ZZS15MnN7LXouJokphQ9BmAzTlo5nzelMPfsNzW2jQbk4eu8GYcI+H56dnnOugYAxmVQiTTqIkoaTFqip73IV3+Tp3VqsJmDou9QkpKVmMxVbhTZqi9zAhHoWCOzM2MhwCj3Lwi06N+HeqUgEv2LHdXM8NN6khUPcOw0GbPXz+Vpf8vbjUSW08ZeYqUgSbUEyYyRxVntbPov5np9y8AHDADVqErkT1VZeqDfu/U3GxYgcZRcltpj4RoVy+QsxHdC0lqrz2GDkP+EplcxiJKqk5eQ8pYzcdVG03th14hNXQjkXTSHIIEXgt/s1PlKJ59J4P8To8MOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5J2xI9ynQvWKNYqgdI1Ph5enzmGnQr/UcukTrX3lEWg=;
 b=cdlkCVgWQpW2etu/IsL2F8qfQfF0O9TgQI4b9kls7YwRJsP4/WuIFPiMSHzutRn9UbJcDK91yCMm9ombTlc/XbRjh2Zy2pAVabZbzipnVpCjkcGvAY0ipBpklUxyzaRUfh/XQAdP2xLgC/od4fOb/37y6LUi8ogwez4QPMFYhKw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7218.namprd10.prod.outlook.com (2603:10b6:930:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 17:40:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 17:40:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH] NFSv4: add sysctl for setting READDIR attrs
Thread-Topic: [RFC PATCH] NFSv4: add sysctl for setting READDIR attrs
Thread-Index: AQHZ3B4dgLDJ4SXOg0GwHvMHaaKXJrAEmDoAgAAJmACAAAprgA==
Date:   Thu, 31 Aug 2023 17:40:41 +0000
Message-ID: <B67A89F4-ACF4-4A53-B8CF-CA7487EFB129@oracle.com>
References: <8f752f70daf73016e20c49508f825e8c2c94f5e7.1693494824.git.bcodding@redhat.com>
 <021d9cf4ba3ee8a776d8c227858866caf6c7308d.camel@kernel.org>
 <4C7FEC52-164E-408C-A26E-611F6D7C314B@redhat.com>
In-Reply-To: <4C7FEC52-164E-408C-A26E-611F6D7C314B@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB7218:EE_
x-ms-office365-filtering-correlation-id: 5cd5b985-c905-4f72-74e3-08dbaa4965b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kYfLZLTO9m4tlq1S4zbwRGYXwnjdqPnRbgVpVZWcXGZ2edC7iNnq9IAzEZlnumbnNagrFFRZhm8xrZyLA6kBRZQypwPxXWJDxiE6pI4tYBBtCWIlCnpzS8Gj8f9ZNM6NuDYJcdUzlcHEBZqdoggo8eSPkSHismnp36AE32l/LzoERGNfReeVG5xT8iVqWrUFK7L7wVz0Q67zo8bBgDV/IbOAroPQpBEQU6s0D91733c9GtBnLPyuyH8GVSg/UZTrfvYAXnKeAbAvBzowJY7GkVYZpti1Hod8iN+UHbcgUOPl7G9hbul2B2CT+10jHV/BO+mtaxwmkQbdBx3qrsuR2eKermKCabbzqWqf/2wRl/8DPmcuz63wx7IFb2Ce4OadRQq1mUH5R63Se+OjABsJgCYsgrUTenSHcxvaWYZOkaI9j/rklxzFrcn8Lrokh5KhE23r6tSekRDNOaTUTWpBmFxI36mccZLD8gkvwL9vKm+nfOnd8DPfyTv+QUQA1SnaOsVTH49T+lH0tIzp2v4qMQ0tFLsiuoQ/426wP39QSsAMtGSYRbyA+mkEW5DGXHK07TrFopOvferW99zllN2lmuAnxfvD9YMRMiywgAPwy00kSL9PvBeWqSCpxrt42keaSiUWw+kAZEDeBsXRw4E5jw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(1800799009)(186009)(451199024)(2906002)(64756008)(91956017)(316002)(6916009)(66946007)(66446008)(66556008)(66476007)(38070700005)(76116006)(122000001)(54906003)(478600001)(38100700002)(8936002)(5660300002)(86362001)(8676002)(4326008)(83380400001)(41300700001)(53546011)(2616005)(6512007)(6486002)(6506007)(71200400001)(26005)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n48x2q7SA9dZ1yCvcgaWr2J6F8+wRcZ6uL8LpmJvNRzl9FZpmRQxHmcelw0D?=
 =?us-ascii?Q?8J8aS+2375d0dRk6BjmU6MapLR+PzKqK5e1ZPq9W3DZybjEJJqtGZOYWeJzF?=
 =?us-ascii?Q?TWWAW0xJusrHnf/1bpiOCfY7eedM+ii55ucWBVnzhAInfq5DDntEn6cRFquw?=
 =?us-ascii?Q?i1aYZ3+RDkEeHKsYLw3IHA2ZWSnntBgdQSYIuIgaA10+4mWcAQBCWRCWK2R3?=
 =?us-ascii?Q?SvF7OUqFHdUQoIKj6/pkkwa/xhx7DwrU+ERQs/AEtB/EzUFUTzy0rwhhCaCI?=
 =?us-ascii?Q?pUti+NvYQlloSpTc99ZAGCxkjYwnGXxlbtguvzBxslA/oZ4rxf0a8UkZi0rr?=
 =?us-ascii?Q?auoVOPb4Elzc6lb2AE0PkeRFWZlPm2S/8ueSZWVX4qzbS9bEppobUzFyLVDC?=
 =?us-ascii?Q?VypFan0aBFFABHlVuDW3XrE0/t7QrNL9TAPfXyBrczn1oUImb6L8u4227q1a?=
 =?us-ascii?Q?vN0LtcuCUGG+yRL715mldvyipgKHt/kmvaiAtNByEVZGM40FHtnFmw1B8U6s?=
 =?us-ascii?Q?7wqUYtTaMp75+Rrv6ql5VUENQHHBSL3ut4flMOc28ma+syhaziOWH/MgPqcu?=
 =?us-ascii?Q?q/VOm8fbUZNghDGV3H8DYaN5df4DwtRMjWG8CKkywgkkEVKR6zgX8rlu08F7?=
 =?us-ascii?Q?DXQqnpmNsChuf1Qo9jYeO00VPCwiRNskKJMQwP0uMCSgcCuDYQu3e7AibvYm?=
 =?us-ascii?Q?KKfZLqAFuh86zJWbeACXGxUuRPNT18HI5quB/NZfnRRpiEloLnFfuwBOizuW?=
 =?us-ascii?Q?93LgUR4cJU1C7MwFmdUf5O6i9t7YsuTitH4DWUxp53Q9QnekB533x/dOijf0?=
 =?us-ascii?Q?4yLYVtUHGyJFye11+Ug6NdN0P4TR9jW4mPo4vgqKNAovNG7gyRRSqx5UCf8k?=
 =?us-ascii?Q?2iojwTm8cGNrOYre6GP8vRyy8mqZS8BuQPoZ9HHPhvtRAxQ1ytQ3nvV+r4J4?=
 =?us-ascii?Q?7Qga8Yg9GcX5wZ9/gd8EqIvAVh1fchJGqfurIZopyb0jZTgIJdDma4nQwRlb?=
 =?us-ascii?Q?tmRb1YsZCZuDWrKtR/1oQusTe3okP3uuS+AxT3GzLlLRqEqgHwbq8AGXMxAc?=
 =?us-ascii?Q?76Cr9PAmFuqG3G+cQW8Uuf5+gXFSSl9n1xArhp4Fd9GURRVFiLEhPzB9htU5?=
 =?us-ascii?Q?g0XeZd2NDMeHV4q1kAhhF+5jUkjTwgdd5g9845eypgGgy9BXs2eN8X7wA/tx?=
 =?us-ascii?Q?o7GY1empxlZchOIvcTtPkavNQeZMteGu1ToBEc9Jd+tZ5oDxZlTkptTZ3c1Z?=
 =?us-ascii?Q?L+LD/BkgW9X08WXpfPmm7uJY+Sf6sE8j9pYiCWUZJRbX7VKFpTlR6IuCQiYn?=
 =?us-ascii?Q?pLChpqVbPqaNcfKuJIffgSJbIapjL+9qaJk/C9YBXvacGYY+HMq7v98LM6mI?=
 =?us-ascii?Q?6H4YGPICc3O2siDVMtq4xLFEN2cQzX7EJ+Jslqpp3rEndHNPpFm53p/+DRC7?=
 =?us-ascii?Q?C0/w7v7y2u5TZUXbOiGlazbwpH38Q+/eCJZ+rilZKUNOk6kj6iS7SH3fGz/E?=
 =?us-ascii?Q?L2EZNUNrgQPNkErTtB5xg0aKpAG9UoUwOwUpOB6sSsSTmX2+HK3crluoGwk2?=
 =?us-ascii?Q?MyfdSjZ8YhyqbCnVaWvjYesskWIJRFJ2zJSVToDG3s8UuHVZS5/pbnb47+AI?=
 =?us-ascii?Q?nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BF3A410BFD7F7949BEA5493F0095F142@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OZiaO/P7WUelD1xqP22dHY5DUrs0LYNOY98gJR6/EplA1m78WEgSp/kC7D7s2d/KUifRQN254CDNGq30k4Wc4ve7kcm/GTenBCZQDXEvXryvu8tQa++cDzKVvpOhNoATzNUD5HZQo/w3uy2tH4Snpk28Krep1j7UjC/p6WSU5Ka3VRCXgs6VjHl2dQ8hvv5pb7Nf9KtfmRLA04Hy6+eXjWlOQaQ+CrLrrbd4P3HloLDcrO5r5ik9/1b5Bs8f4x7evF+c1vnGztTC522NeLS7PTCGrGLduua0PhB45YoI3cybBUbckCH4WGKxT8nSn4GwBh3DkZiw1z/7YWsfnYhh1bI7mo/qjoWicAXzhJZwpeWug5FhpVvmWZoDzkzUpRJg6N6ra8Qo2RRk05XaOysEMkTRTmT1Gh6tlsR8RpOVk83muVSHBr3SgH/Ail8uDYCYp+570p3OONF1CHfXmywMFl9fPc2M2CmEprsn8zXNnr4ijR0Vps3k/LT/Y0b5L+nHLlHZdkDjA+twZ8jRBz6KR7lGUyxx0TVXJfHp6cuCFLmkiFB4QgW0rOsDhrQT7pd0ILZLTM/8y/l2r5hxhFiZvGEUEhHquH6PcVHzHr40zS5QVSQV2uVzaETPpKkkgBvz27V95c+7n4gkD24inH++cIvX1OxFLpNK/VBCOIsOD2v1/4ylEq88NS/tW5J/ANz8GY5BiDz8R1AFOR7m43NhUKAXFciT9Z78XdEVp7nBJygNEOJpHWqfo/By0mjbAwmfV2GclPaszgC99bZ5ZDH5fpxcDkNBtaR+ynt6u7PfcxaeJzpLrLUP5IbxvsoMnP7a
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd5b985-c905-4f72-74e3-08dbaa4965b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 17:40:41.8201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ItmLF799GGbRFEmMB996/uoycLjKAysOFs5jgKn5rWytB8AOwOZL8kdqKLEhGjVq7FNaEawlgiKSEu76pTQyWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7218
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_15,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310158
X-Proofpoint-ORIG-GUID: 2kYurHvuM0G2_w3gtblmK3SMmtU4SmtA
X-Proofpoint-GUID: 2kYurHvuM0G2_w3gtblmK3SMmtU4SmtA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 31, 2023, at 1:03 PM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> On 31 Aug 2023, at 12:28, Jeff Layton wrote:
>> This doesn't seem worthwhile to me. We have a clear reason to add
>> WORD0_TYPE to "basic" READDIR, which is that we want to be able to fill
>> out the d_type for getdents.
>=20
> Yeah, and exposing all the bits might create some interesting effects.

I'm wary of adding a permanent knob, but I don't see a problem
leaving this patch out on the mailing list if there are one or
two folks who will actively try this out in a multi-server-
implementation environment (say, at bake-a-thon).

There are two sides to the trade-off:

- If the client can pick up more information in a READDIR,
there might be other places where it doesn't need another
synchronous round trip. (and of course, watch out for any
corner cases that might trigger a CB_RECALL/DELEGRETURN).

- A particular server implementation (I recall OnTAP had an
issue) might not have a large cache for file attributes,
and that would turn requests for additional attributes into
extra multiple short metadata reads in the server's filesystem.

Performance studies would be interesting, and I bet this is
something a grad student could experiment with using one of
the "captured trace" workloads that academics have floating
around (or at least they used to have them).


>> I don't see the same sort of rationale for fetching other attributes. It
>> would just be priming the inode cache with certain info. That could
>> useful for some workloads, but that seems like sort of a niche thing.
>=20
> The issues I frequently see around READDIR are that we keep micro-optimiz=
ing
> and regressing in another place.  If we set WORD0_TYPE, there's a non-zer=
o
> chance someone might start yelling about it in awhile because their serve=
r
> takes longer to query the inode.  Its nice we have the option to give the
> power back the user sometimes without needing to grow a mount option, or =
use
> a module param (which would appply to the whole system) - so this was a f=
un
> example.
>=20
>> Adding more info also reduces the number of entries you can pack into a
>> READDIR reply, which is makes it easier to trigger cookie problems with
>> creates and deletes in large directories.
>=20
> I don't think those two things are related for filesystems with stable
> cookies, or I'm not understanding you.
>=20
> I'm in favor of the default READDIR asking for type.

I say test/measure first, but I don't object to the idea.


--
Chuck Lever


