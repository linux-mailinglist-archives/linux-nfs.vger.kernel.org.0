Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D46C3EBCB2
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Aug 2021 21:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhHMTvU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Aug 2021 15:51:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9132 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230440AbhHMTvS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Aug 2021 15:51:18 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17DJQxlu016489;
        Fri, 13 Aug 2021 19:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tJekCAGGSrKmhGuA6hKjzLQ8N78A1Rnt/IgDFU1CKYA=;
 b=lRmuNLt80OtaRUAWS9kNFLbzseSALiDX48ey26gfIzaC2IuRqFk1dmM7bHFj7lolSftg
 pjCtEX4wDc339gIcIeccjtnvJZbTN+qhcluBx95NulIE+/mKMub4jumwZgYZIkrMX4A8
 bL8feDrRI9QlbgxTc5uoTzSDGDVXomfOJhhCYklLo0lzyJ+yO/5dmnwodNHOPFY/rFKm
 WcG6uIaTSpb6tNwbhypNQnT6GQ9X2IbD5fiVVwd1sF50gtg1QIlHPqWqTGb0sIXafV7h
 o8xOXmVj6+t0K61+fdq9lTN7R8k3VYxymw/RZNb30KYhT6ng7wloj15zMg86D+FW2auF 0w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=tJekCAGGSrKmhGuA6hKjzLQ8N78A1Rnt/IgDFU1CKYA=;
 b=lKgCskebr4TTUnhDHW3ENnQ72kkTaC5ofQ7POzHMoJMsymR3f+ayybXbBklaLd5p1Iqa
 Aiq3AHtX2ZLouH/yQP/Lz24gQ0wGrip42qovu2Y2x4hTBgXkN1jrspQCun8W/kpXPEFI
 ov9sB1Wo9N9esTblbTTJKz//p5llYRHzGwxYadox5WToJfFgZs6R4W6jyewqyDulaqiJ
 eNvCUbJ/ktJj6GlsYQTN3/YrZOuodHWqVDet5vyLYnBC5pTcGbAgfuBgXt6iczUPO2gf
 fPE6DTO/8oEzBGqMLTtWZYLVKbgaYD9bcTzToxdcv9TkmE4FwZBgHDqAxSjLfYKvXTzF mA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acw9p4921-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 19:50:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17DJoaLq028243;
        Fri, 13 Aug 2021 19:50:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3020.oracle.com with ESMTP id 3accrenax4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 19:50:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjYtp8651dZHnyfaq7IGb4JZTDddMqCQF8T9D3B5n2l5l7563MM9FUcZJKqCXYQBnj57YS3LYa/qHQ5VXIwQU9RolQRjrH2U+T0TsUxRCzhzDa2wlxsjXuw2prNMVBF6Nn5X+t4kRCDBn0qH0gMER2ykuaw70C4v63fiYdlypltnVU+8OVNdtcs/DA8FFidbiz2Gcdd9mpKopZZu96zCLoWR9qnm10IZwHTtthkopnyF3vTda8u1b7VVumRyx5S5X7wc1aUqwPF5igQPFcdR2AXK6xzfF9Zy1IrqtyPsAPGLYbrVZTn/jQ+wN3C2rTGC3/gvBquonhPuh8wtW9lsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJekCAGGSrKmhGuA6hKjzLQ8N78A1Rnt/IgDFU1CKYA=;
 b=OgYvoDkmd26vhUvCVdfX689c1hEI4P9ZJf3Q2SMvYONVQ+F2DK86us8Ie9CRff5736l568GiZyF+hmGeq58gTy/rJ7l3SxOCcTtYjhf8zMADL4MHH2cIB3gdVdKH623DIzuTUGHUyUz5G6bHe0XOtD0Z4j/kTT9AYVoook2jJ2HooKaBRFIbPrwUXldMm0f6co2EYAV+uBvoNxqDUgxZoJ1O2uUXRc5t7QXZMJ2Al2OsplAU7jnF/sI73TqteVrHyTnRnbFVdNN5DOtU8TBt27Fk+NgtJ2v3cxTBFPf4MTawM/dT505ZerxCZmom3bxxC6kSb0dWJb2kDvAN+NPzzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJekCAGGSrKmhGuA6hKjzLQ8N78A1Rnt/IgDFU1CKYA=;
 b=VL6vD5VVlD9Faqeb422NCUaAY4n33+uSXphEu7tTOaXk97K7WjwSk+oUGgRgrydMQNdr3I5IxjdSWgo+BNTqJQcK0nBX6oOZkRhKvp/yx4q3wNBwNmOi5vFgmST/x0R+IbRd6wqPpmioY6N/tzoEAJVhdJ1eDHgOIq33FarRgzU=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4388.namprd10.prod.outlook.com (2603:10b6:a03:212::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 13 Aug
 2021 19:50:44 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 19:50:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] minor nfsd fixes
Thread-Topic: [PATCH 0/2] minor nfsd fixes
Thread-Index: AQHXj7p9GdLm/nXmBEmWN1u3Iz2TTKtx2YuA
Date:   Fri, 13 Aug 2021 19:50:44 +0000
Message-ID: <50550C4D-6F22-4142-B66F-9B616D3FD5DB@oracle.com>
References: <1628800903-10760-1-git-send-email-bfields@redhat.com>
In-Reply-To: <1628800903-10760-1-git-send-email-bfields@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ab470d4-1338-4a21-2340-08d95e93a35d
x-ms-traffictypediagnostic: BY5PR10MB4388:
x-microsoft-antispam-prvs: <BY5PR10MB4388018BAFE30626030A492693FA9@BY5PR10MB4388.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +t1b+yQ1qoD0/dW4OogiP77Flny1dUC8e4P3O16gxjaIDNnF43t3AlBCuGpyHBxf52rb7N6IYf4495yWpMdPY2NDhePloG3TRuw2WcdvWH4JOasf4gUz3xDTAYbBV0yRT+kLBlXQScsgj3FOQ186UiSY0la1FtTTakiqCWocnnxjftC5EQEH1Is39dVsT/P06WSrCt3gF3XANEn4qSnQsm4r17In3S8exRa/0WgiG8m3xFpdCaLlBgoeGIyPO9CdkDAUQoJGnATYuc7ziy5FIc3ME8tj22NlmOKJxdE1EcryzCh0eWPxoo+1tV2QCKBY4hlYVWyvCiJiZfvnfAz/vPVjJI0s2hypEq/Cv2l9uFBtPg8uXOlZg86Rv4gaPBjI3e7qBNpw/q5/M2QYOJFHJi2G2RBAlgA+PFszo+/sYUp1W5/fhQOPLTlF8FSnX4R6oGXcHcgPO2u6ZQCRmOjPDfjnZqhdca7gclizWqkJ/Et5/mWytjtIMCNKPbWKXF6StX2uHdMoPpCvDfkUhTshYNivB2z16F3Z2IS6ftDsvvRRemHMa0s6591z7jIigLYXcXJphhq3YMWSaA8xqRFQgfS31kqXWJyLAtdPSksBFw/CgJp/meY9nVzHaLGGfD0AG5Mxwwm0C4NF5+jE59gSmCCW5QF+fIIoSLMuoOwlmZqRPKWt++uVRvW1xRF1OIAjmyx6CrYTyr++ckU0oJeucjTxMUKs6f3si38yv2KPPvM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66446008)(2616005)(122000001)(4326008)(83380400001)(33656002)(6486002)(508600001)(6512007)(6506007)(53546011)(66574015)(64756008)(36756003)(66556008)(71200400001)(38070700005)(2906002)(38100700002)(66946007)(5660300002)(66476007)(186003)(8936002)(8676002)(76116006)(4744005)(316002)(6916009)(86362001)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BfoozI4dWuVfDMMxByvhTUZ0X1SyNdJhLa0BBzc+a9w1pzjrgal13LuI/5pK?=
 =?us-ascii?Q?XO2oG1r3QcDzqz8ur9QLqR2KcwG7JoKYVa7U0kzpHB9L1fwt9tOmZh20OaRf?=
 =?us-ascii?Q?d/ONtJhsSZ+qv3RxwBvFNE2vAM0pTavVepAmGMjnGlQEfLFbR11Gaycbbu2M?=
 =?us-ascii?Q?v5kFlK0XoxcJpIFz0qmAExf2lHArJlpCaC9l4oEMHfPf/HSetV+Cabg2qyzu?=
 =?us-ascii?Q?QztNIk1qgIf4zW8Gc+O0Ac4Si4t8ZuzgXn3TQNPjcf3JQiz1MrV4iF1ceOcw?=
 =?us-ascii?Q?REY9Aw7Dzkze+rjMOvDmT+xSxlG2IueBRART/iZgQMDZl84g2tgDfxiqZHFy?=
 =?us-ascii?Q?gtFCXwoYTrIJomGYFONQYZcWkcTyCXIFbzlH1NxAfgaFKKuEx3smPBvCQWJU?=
 =?us-ascii?Q?AWsJPwO6pJhi7tLiHGXqegTg57pe72uJanZ5ESww2UxPyenSCmrGWtSOKYcf?=
 =?us-ascii?Q?LBn+i2yeNsk9R6uydtHW7urToK5X65MX195vFbO13OIwqQpV4yFpUbkT2Pcv?=
 =?us-ascii?Q?GjtkEGHj28fuzBZGh2IptiqiQ2NRd5hl3cSLV+Tyjn9R6WJcgpcBI0uoSEkx?=
 =?us-ascii?Q?ZsB/7kj7tg+ce2rJ0TbBpSCQJYd+/XrMs7++vQTVcBdaduFu0xQsoMg/ivav?=
 =?us-ascii?Q?XV++0BhwW8D18Mu/2zdbwv71apBHc93JzKVdDidKCX21gtqd0XaYiHfJUSg1?=
 =?us-ascii?Q?guiX1bu/diuvrIf5Gh68GOZ99r8EYHyXRfh9ddz7Z92qEBvbfktVBTofeH9V?=
 =?us-ascii?Q?sXIBMjXuaFoaATURr3lYlDVQfXqXnJzOicOOEAYkFiE/aKAtEVREA5f4ccMy?=
 =?us-ascii?Q?dQOSkb6l8LkBBli+kWcBjxUjODxKai+gYMQWsiSbyGSOIFziM9nxlb8D8gmm?=
 =?us-ascii?Q?lfGqY7fizq6p3ZSm2c/h7jkvDZghf7n0/8ArlkX13hVWKTV4twReqHjwUNEw?=
 =?us-ascii?Q?qOEPB8CQqXsvSSjuimn4gmdTU+F4jxZRL9Ep+FsYK7+yAEbx9+JlMBWfVnR3?=
 =?us-ascii?Q?s8l29ZWauKUYxuLIz64qhnFZHPynIkgDnvzmi7nCDVQe/EHdaJYniT1epoNy?=
 =?us-ascii?Q?uE6MbuE2krD9LoJrs+a3UJjaLxVHefBPbC9w6w7iaGo26wbCLKOyyD6aFymv?=
 =?us-ascii?Q?KoQg9a+cj8ShQ8SD5iwC81pvcLedteOOde2mQs6iCpmws+5FnPVwToPOLMrm?=
 =?us-ascii?Q?VgxiH2bsu4kI6czXUZstNvyp9Va/riSXdOiSf3Oi46rBpyMuqbvuWLdIoXuw?=
 =?us-ascii?Q?X5aK/XAejtvSWI8hPmjndU3rd3tACZ3syAS872dImSq/SKqOS65DoGV8zo9v?=
 =?us-ascii?Q?etuJFZfYKgpygx+N038AVZJ80Oc09Ma5Sv3hFIpnMEAu46dKuZicQr4KK4n6?=
 =?us-ascii?Q?o3vbsp66vo4L+utqEtUb1HMBrcRV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4045750E5C62C54EBA7E68E983671FDC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab470d4-1338-4a21-2340-08d95e93a35d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 19:50:44.2434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OCXWr//qHyfx1KkAS4ecSTIqRzxvGQgxD/7WhQ0gfL+H/p4VRKJ4tsEy69f8CxSInTLU+FWF6WuUfq+COpIg4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4388
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10075 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=969
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108130115
X-Proofpoint-GUID: lqrF4-V2XtP9KfN5paHAzKm4C3JN6081
X-Proofpoint-ORIG-GUID: lqrF4-V2XtP9KfN5paHAzKm4C3JN6081
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

> On Aug 12, 2021, at 4:41 PM, J. Bruce Fields <bfields@redhat.com> wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> These are two minor fixes I stumbled across while investigating other
> problems.
>=20
> --b.
>=20
> J. Bruce Fields (2):
>  rpc: fix gss_svc_init cleanup on failure
>  nfsd4: Fix forced-expiry locking
>=20
> fs/nfsd/nfs4state.c               | 4 ++--
> net/sunrpc/auth_gss/svcauth_gss.c | 2 +-
> 2 files changed, 3 insertions(+), 3 deletions(-)

I will merge these once my power and internet are back on.

--
Chuck Lever



