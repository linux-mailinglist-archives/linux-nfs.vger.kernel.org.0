Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50CA4ADB6C
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 15:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351384AbiBHOmN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 09:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241996AbiBHOmM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 09:42:12 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD12C03FECE
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 06:42:11 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218EBI1C007544;
        Tue, 8 Feb 2022 14:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uts1tR4O+a+0FIcyc5h9VG1x2//eYhYqaJNIGP1JOrQ=;
 b=vAdvE2szLZMuNWZjA+mOiwa2pOdcJ1HleL3PrsV4vfz4DwJ902TcgEE/4VeVWHUe9TLD
 hTDUn2NvDTw0jXk7EcFEfARccWQGWG96RVgtKbuf5zB23ZOGJFAeGs30aO/1ZiWAH0CK
 XNwX8ET4MV4igJKr/XnJEBNKL4OVx6jInWSp14OHqPYawEsn4LVonIvJxEzmdC3964bF
 T6NajNk4ZTl3YnCRyQF2igT15eG8FMp+8I8V3QFGWBUh2kWizmRYk+wpV6NK2wtpnRwh
 zh3aiFUyK6zdy9mBBpTLYt3AIpBHhcXsGXzIBTRe8ximuWRJD2JXH0GN+K76q302C2Dh 0w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e368ttwq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 14:42:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 218Ea5R5018700;
        Tue, 8 Feb 2022 14:42:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3030.oracle.com with ESMTP id 3e1f9fbu9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 14:42:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoMUob8/OpJWZD9Tf7ltzqC9LvDFbeUr29mcLIAxIBy1UtJm+AwC4FmA5UpR4JysHJEWX4xI0EHoMomdeP+Sca4iNBHQ8QC8KiveJIC/qykctn/HSx2Qbe2L3Gor8WXQJp5jPonLokCiNGmj4OF+4q/TErWHjDKKmZZFz9ax179JnPD30YDHSCRdL4QUsN4gWsr5e1+fKXsf+jEB3ZUw0Gg9R4MFmcTRIRDwadDNzp407Seb9Va/ggnQCwTRtAO85ne8V/pIjBB/XLTrsdk+rUMA2MGHVqzUS5klA/BXTEQkAGuYNoy647c2Zm5nD0QHsVXc8pdb2m9kvSdwe0Qkkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uts1tR4O+a+0FIcyc5h9VG1x2//eYhYqaJNIGP1JOrQ=;
 b=WtU93yFgqZ1Xu16Vyyl4hos+YUvcyUlzKHZs7EnLBJPA5MVtA4gS38+ASOW33eMoSIldtPVrjojjhs0Jit1/Gq34vKt8mKq2oI2nTzfJ3/h7Q0dP7QycYuqzngj0L1EJyLQ4rIuGfbiQundSHx15yZXm6NkVK/fIT/NYWZlRuB/hulpyvHFKSgPwGIy7LlVn/Iuls54HDiAsQeIAFycHzOiOzffP+AmbX5HaqHvHzLbuNG8HXU7NMJ8VPJ6qr7N+4rlklLsxGnTZU0s5ij766R0QPe88PSd52h/8V/BOG76tix2jmGMKhzlNj7i9akp/45WtUTKreSjosZuMrM1aPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uts1tR4O+a+0FIcyc5h9VG1x2//eYhYqaJNIGP1JOrQ=;
 b=TBgVh2LHPMQwYVBvsB11evEzwJRHBqWvupyhbpngUtTQcIPIzMrOKC18wkHCx+bTgM9gVkE7t6TL/HdF3j3wUDPzyH3gVg0rsNoHYh7lGqIjcVfzN6KHNk+Ls0IgVTge7YrnjmWDgoIVof9rijSVL1GgnIHR05qbjGkrNvXjPIY=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by DM5PR1001MB2121.namprd10.prod.outlook.com (2603:10b6:4:32::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 14:42:03 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 14:42:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: v4 clientid uniquifiers in containers/namespaces
Thread-Topic: v4 clientid uniquifiers in containers/namespaces
Thread-Index: AQHYGqGbn3llxfcWCk+UU34Bdwb7RKyFReOAgAAYOYCAAsQQAIAAHReAgABAAoCAAEjVgIAAwaaAgAAlXYCAAAwlgIAAA4wA
Date:   Tue, 8 Feb 2022 14:42:03 +0000
Message-ID: <6211BF2A-2A00-4E00-8647-57D829D41E8D@oracle.com>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>
 <6ac83db82e838d9d4e1ac10cb13e43c5c12b2660.camel@hammerspace.com>
 <439C77F9-D5AD-4388-B954-3B413C1DF0E2@redhat.com>
 <596C2475-76AA-4616-919C-9C22B6658CA7@redhat.com>
 <DB8B60C8-B772-4604-A841-47F789723D5D@oracle.com>
 <b192022ce73ea690a117d7710b492e83be99df31.camel@hammerspace.com>
 <43990B9C-013C-4E77-AADA-F274ACBE4757@oracle.com>
 <8CCCD806-A467-432C-B7FF-9E83981533EF@redhat.com>
 <c9948f895e91abb76a21609bf629b88bbfcf4d9a.camel@hammerspace.com>
 <CEC36879-0474-44A1-984B-BAE69C168274@redhat.com>
In-Reply-To: <CEC36879-0474-44A1-984B-BAE69C168274@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a1d3dc9-b89b-4327-8f3f-08d9eb112c37
x-ms-traffictypediagnostic: DM5PR1001MB2121:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB2121D0C2831C3B0F9AB08736932D9@DM5PR1001MB2121.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QGU1MhbuFlgP1upQodaNbUuC6wR3YMMM1fQZGoe4Fq6G6yHZIK8o3slWfPhfO2uzPFlXxtP6wvK57vewMn/+wdk7zppQloapggz8kG2cf0YOAxJGZuiaxBVsl6xbykCTkCtATqcCvS8szxJYU4CPebxmZPyeRJ6eYlcLE9e3Hcewfi0zqUyXTAJwBASDSR76guA8Ii9hWUS0QqS9gQyW6/92Pxwv9E2i9XQyMTg0vDFEu2tNI7S3dQjmjAQE2S77ucBlR+3/H6kmgcs1s31segkZSoMQReBf2q1sqU4RGm3VbP8mE5UMhovgTwnPDhw0mLlsZGURRBxh2YjQGfSGZj/wnYdr1DDw5D+JgvfXU9cj/VR9XVL0CTs7d+Ax25hNeUusvWiYFcfYRPhGzd6wq6vRxleq2/ZSOzqhm/14M3CgsI56hIgoyC1O/HbN8yOVesHQcRCCzUGYu+4qbgwTmmaXc+3fs+m7fTJTJxv5ISlg8vyOTssv2katbbgZPkgpF+EJTF9GMuHBN6y1gXUKm2baOEn4o5zJsS9UvmoBe/x+w1cuWvXPrNsYHGfF/wSE3tC3WV1Mfh2YLjOaVD2K2SbCMnO/Y5UrfuuDAA8I0yjERm//xQe1//htcffJe9FZuiAyOn2Fhdyg9fkSCADBUb54S9K+3JYB5J8IAp2IYIZ0npq4RK7x+OGugPRp80yIcXL/ylHJfRchX9HXoGT/lZtOfvCtrDDCRJW13+JstTuE50SpKxUChcibYVjUL4Vm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(71200400001)(4744005)(508600001)(8936002)(38100700002)(316002)(6916009)(54906003)(5660300002)(36756003)(2906002)(4326008)(6506007)(6512007)(38070700005)(26005)(186003)(2616005)(64756008)(76116006)(66946007)(66556008)(66446008)(66476007)(8676002)(33656002)(122000001)(86362001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vMbMSGhLrrSRFiUelmXdcuV1Blefp3Tpia4Xzh9QvXTVD/UIs1eko1AdNQPR?=
 =?us-ascii?Q?EGm02pGcgR38EU8qYEwYXNlb2avlr9mTzoyR5WjmCRRY77APF83gaUZF4g4f?=
 =?us-ascii?Q?RkbnIb5oUwvHQvTNf6eySS7wZ6hXQPFw18DN3WBbfvQcg07IXMqvmMWtqXAH?=
 =?us-ascii?Q?GZU4qbqPvm5pqxp0P7xzzBjeBS8DlSz29+yVBZkFELOQqe4966UL79C1Uytg?=
 =?us-ascii?Q?ezahwQT+Cp4uPVRquJiF84BHoVrd/pk1Eg/A1TGPcqfli8m4GMYOForR/WDC?=
 =?us-ascii?Q?B0x7ns/7WNnUe/6Tm84JPaeNXwakgisFvcgoa22SyBnIA3k0Af8pLAV1RyO+?=
 =?us-ascii?Q?6mxLNOn4ansCuKrN8jPYBimBqyGVvK7cjEyCLr1qrZGLS40jO5WWNCoxWeiS?=
 =?us-ascii?Q?ErrrPbc03XrIihydJ6Dowjqxny+0RbD86X0XPr6KSykQZ59VdqH+tzNXNAut?=
 =?us-ascii?Q?sfLMkU/eqqXWvl3ZCMatiTXA7ikkmHpZX4YvrBpLOYz3I/+1dqwF8gSN2RUQ?=
 =?us-ascii?Q?RLlBTsYVDCwGnw5tz+BzhDi+r3b1ErOawkKQrqXFbB87vEuq7vktuZUgkORF?=
 =?us-ascii?Q?MmKuXeXvRRBfO5kiMMfy4P/5B0j0FX7DuriDACZDLakVH9AM4pGUMq340sBs?=
 =?us-ascii?Q?PMQ6lSHEI2Vb9ZwxMxrRudXjmg6QxZNXu64qmGFX4a9v+QU1WFyOJEUvgUcr?=
 =?us-ascii?Q?Q0eM/g4n28Ov0z0oWfnFjxK8NqNNhJe8Um75VOW8yZA37/ZQzfX+AkTTXJHE?=
 =?us-ascii?Q?kafwDqQTsPb5z7LOAqJ9LOXZ/c/Hg5jlBMiybVkNoNUUSy3Cnx4znREWva8c?=
 =?us-ascii?Q?cLtXje9XHLEb/2jcLZq4cDoDdDFbk3/qE8s1YJcUCywFf165ea6RDZMYYXWY?=
 =?us-ascii?Q?WB+t8jO5QXXXGySi54sjnJ5JCLwrRZONHX1CHeeaXLAJyyIgpW7Jh4We6+KS?=
 =?us-ascii?Q?x4BIo69WzK9IxaAFxAFxyO33Tau5+Hl0X9+relYchBGWFaiVoRmKQ3HmvO+C?=
 =?us-ascii?Q?ZnVCpxt5DKgOpf9HwB7GENYy5Mm43vdSMtzOxJJ2nGC/3ZoJR+6gh+7U46jc?=
 =?us-ascii?Q?WORgFY8ZI3d/iSTXlT8uW9iDjAfrA4mnZKZ3PD2Xt2z91BV6jJlnT2NICKqC?=
 =?us-ascii?Q?1Yc6GfBenvulpC7pTzrQitTXYSPeCndU0wlO8hh/4eoDhG7qXHerivrweOaW?=
 =?us-ascii?Q?71c7ySqkqt9in4LvbJouKnR8RGG9RPDbwYcQr9S/aVK9UI4vFMPCbopbSiea?=
 =?us-ascii?Q?nNPo1SJ81XpzJJpqdkHFTd5Q0wDrPm88s1KjW2JsMJDuSW5ezLbQFy5cEbMC?=
 =?us-ascii?Q?UglVbm9MS83nUvxSrt2+JCx7rxtEGKoUaAxHhK2kjYwWkK1hJzhbM1m3Ld/D?=
 =?us-ascii?Q?KvNyjcUrMKZFbi2sWmR7OBo82nxpwbqkZvxbd936M5xkCkkNWgl/tkVqG6m3?=
 =?us-ascii?Q?Qq1N81Wzai18MUsWNbSAyek7RPCx9QnhvzwqxP0LFIWIpETu8XJ5UO+AhL1R?=
 =?us-ascii?Q?Sqcar53OmaYz786B3sUUCqGy/gPx8b6XlVkQE1VVpPLmb+hl90V6su8d2kpS?=
 =?us-ascii?Q?Suy4awI2YHoF0JnHggmzBE6WG5/WQ/xugNOOuZ0f3PHSlhjl2y8mwMHDN4f9?=
 =?us-ascii?Q?MIeGDqFizfPE//BgX7AvZm8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <51C58E9491FA41408CDF1684643297C9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1d3dc9-b89b-4327-8f3f-08d9eb112c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 14:42:03.7977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p1GmlR6/xinigY5vU9cJ9r1fCGSIw4p/cdCcO1ZficYdjq0gTL4xcYJDxdmoBcu+b/Fug6AUfPWrCjiKX07GJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2121
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10252 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202080090
X-Proofpoint-ORIG-GUID: E3oPTqoLSygy7jDkFR2RBKNYokZGUu4t
X-Proofpoint-GUID: E3oPTqoLSygy7jDkFR2RBKNYokZGUu4t
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 8, 2022, at 9:29 AM, Benjamin Coddington <bcodding@redhat.com> wro=
te:
>=20
> On 8 Feb 2022, at 8:45, Trond Myklebust wrote:
>=20
>>> Can't we just uniquify the namespaced NFS client ourselves, while
>>> still
>>> exposing /sys/fs/nfs/net/nfs_client/identifier within the namespace?=20
>>> That
>>> way if someone want to run udev or use their own method of persistent
>>> id
>>> its available to them within the container so they can.  Then we can
>>> move
>>> forward because the problem of distinguishing clients between the
>>> host
>>> and
>>> netns is automagically solved.
>>=20
>> That could be done.
>=20
> Ok, I'm eyeballing a sha1 of the init namespace uniquifier and
> peernet2id_alloc(new_net, init_net).. but means the NFS client would grow=
 a
> dependency on CRYPTO and CRYPTO_SHA1.

Or you could use siphash instead of SHA-1.

I don't think we should be adding any more SHA-1 to the kernel --
it's deprecated for good reasons.


--
Chuck Lever



