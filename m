Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B12C3F4D57
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Aug 2021 17:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhHWPWP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Aug 2021 11:22:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26646 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230380AbhHWPWO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Aug 2021 11:22:14 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17NEbYE7006594;
        Mon, 23 Aug 2021 15:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+GFRs2/SbEdMkXz84/kyYna1cWAkUezeHylBv/C1G34=;
 b=YtJfnOUFW4yh7tMEQ1zI912A0tfE2QkGk0YSiL7tZiJgF1C1shsSEw/xsXHiGUDcuMH+
 XENs+fojmeLEWIAxKBSWp8fNzdVobtIB4rRyDlF6pBVWTqLM9f6S6kFitDLPgKSz/zZ8
 z9zATSZ/8iLbRZyb1YqbZeCWkAIVsA/qHDpR/N6BAr+RMXQXpdosjpNmyZ8egjI0upyx
 3fdJVk9fP4m9mwo2/0wpDuzgXOxS/gVDHsqr0ifiLu65XOy5ZbG0LIRVWaatM+K4TgBC
 EedQX0ha542n0jwJOwbppiHbMvrFRmWACI03FVgzdOkYZZPZ9ENo5hSsDwZcaglosIuJ ww== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=+GFRs2/SbEdMkXz84/kyYna1cWAkUezeHylBv/C1G34=;
 b=TKERWNjOe2Sc8ZyWh3LOH20ZglvjJjRz7HFq5j0eDe80e6uaBLhGn85tw1VT4roBpLIq
 WmzlIP4vkjhfCKvjuTLUl3jGFA0CobRiq/1RPitrXnGUz+pU4lFBHYRryyiwM7ROGsgL
 Y73jDV+ln67b4GZwsRXpOhiotMN64jpRXMzZPkQR1/VYeDIT+0i4rn0LbQab4uu4OL2s
 /Sks32mroUYEUaY/d6He0slryhaicum4uFBN6EO5q2VOEGBpqtMZ9eA6WGLLn880TLqt
 7HRGcpfKw4vYF+EKh9EIphnLq65z8cv5Q7lhHnsg34JqjpTigvUnBWHcdngJLHeHKP0c 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aktrtsxug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 15:21:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NFFU8w031065;
        Mon, 23 Aug 2021 15:21:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3030.oracle.com with ESMTP id 3ajpkvdwub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 15:21:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHLKtxHkajapGZBbIBVBJDcGRheRTeH+0r9mXIbqvAWcgCTt4ckEceMqbTWXQQeO2wqcIx4jyjHEKDB4+GqVKDxCLFB4w+n8EnCZrrMtsMx9pomejlJlKbCWuNeIsw4A+2UJ9ehdB4uCc86rNnY017Csy3RUTJg+x4eFhidWgsfPDxbETPlYWfVcgSeq7IvcyoXEO7R+xXcEFW9NIcSXJh4ZSMGJhX+zLY7XzUtKGYUenBwwZU6gvIPhMOQUS0qaMbD9ZW/h9fcONmlG+/N+s1/SpE4FXf/VBgOhxa9HQnSmHw1VV4A/UE8M6kGwmj8U5OhdS0MIw1trshSUggNlkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GFRs2/SbEdMkXz84/kyYna1cWAkUezeHylBv/C1G34=;
 b=Wb53qtvx7sA+9g5Y/Yc7a71dJwzYGDbldPpAlYdJ5G42GF20cvUSlncX4ubpL21+1z2jAiMo5ykMbK/oYf84uV3l55QQkYuc/1JVfdMzJu3eYN3O4XhdPg/aQOSdBtx60J76yvtz2YBXtg7ONgYgMVjvrkX6oFysENl3A8DUz0PraCxaKri9SlqqrHe9ciFMGQu397CpM1LpzKnCuB9+bfASX5poVeD/JYBK6TrR/8wrArlgi4lt+VQ04I4VQk6KcjpnC7Z2h24+woWTGVIlWadPRqRZHcEfFNVfZHWpNxQb0DEpVLRPYruW7oSUWmsWlwNdv3lNIEkhGggPX3i/6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GFRs2/SbEdMkXz84/kyYna1cWAkUezeHylBv/C1G34=;
 b=IZrADaBIGJkxqdAjD1UeOAmmmQ2BxC2aw/UVPQDcSeFCtazfFejvZoozIniA6kKomx8qMe3Bymgi06UB+GJP1FsqwCRAWvBWeFG2denllm1DFCHEC35INp5VcupP+YR2FMtVC57mRZ3yHSAiE9HQaj5CZdKLZDo22hq2RlMcKYo=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 15:21:26 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 15:21:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: recent intermittent fsx-related failures
Thread-Topic: recent intermittent fsx-related failures
Thread-Index: AQHXf/8fslPfHYBEJkGXNGWvoY4o9atRAYKAgAASpoCAMFDsgA==
Date:   Mon, 23 Aug 2021 15:21:26 +0000
Message-ID: <9D849792-600A-464F-8340-8F5C32ED2439@oracle.com>
References: <67E1CF9F-61C5-4BB9-97FE-61B598EFC382@oracle.com>
 <2e8bce7bc15b02bbd1dcf740f2d993d6e3d58367.camel@hammerspace.com>
 <36417C84-FE59-484F-859D-3445F53CC0D7@oracle.com>
In-Reply-To: <36417C84-FE59-484F-859D-3445F53CC0D7@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1dd8f598-02ee-4a60-4fcc-08d96649ac9c
x-ms-traffictypediagnostic: SJ0PR10MB4687:
x-microsoft-antispam-prvs: <SJ0PR10MB468761AE0671951F1627367193C49@SJ0PR10MB4687.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UXltcxJvWZ9dYKGRJCtUNRYDdeAVcSZpnMWBeIpN5cjVNvzbLFGwv8H1p3vIWA2W9hHmXNWwnutxMkiRMS6qHK/FgNiA9zmIywXzVrENndWzQTHSXKOrQChYA9lBVMSYwHZuLpM2Hv2Fz52HRdida/EtL7/8mgIaQ1ofIlo5B5uQlqP3aczlMCrCcsu4kyA7D4hebdRUnSPDPHm4uxaSUPPh8U06Qml/3tNeTkobGpPbfVG8k+1GpuAXk3cyTXA844334UI+Tc0YHLz2co8SU6iOy5pAZNW64ywxC2PUoQBqfXdlyYkhGLyeBSm9CcLLybSIoUJAgmvtTDz2MMYUlwuFkybUv/MyQxHyi/nZiCDspC2fGS1SsH0g5TVuaFWLEzvYsmOTyCc8B1vgFng1tZUdH+eTEkw2pqnOxA80Nz6+Lvt0V7O0dl+c0QsAc+y+nXDdZ0SlYvQvbzch/Ko9Zh0FDR9b+cR7NZgB63ccw+lji5zFex899HdZVMuhAQtFUBWGBQGr2EwVDESF6Mre4V40kgo0JY0F2TXsSf1nwiJ9UGatv3qnsqB/n/iD9n2voGfrKgHOkcQWXU5rSWCMvzeSIigWn+UD/mQ+ljMdPbdH+kRfPzu1HmA42KVU1iiithJGoGcLegfAnkGBXTkshT/lp7HBrohN6rYS0grQMG1hCBYqJDLzK2fc0bCiQvOqUaX9MioCc2fOQfo+z8usXDrE/4XCO8pmHekGVhd+PhjENuRiS4i6MYMn4YKkwIY6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(346002)(376002)(86362001)(33656002)(4744005)(8936002)(38100700002)(26005)(66946007)(8676002)(4326008)(71200400001)(3480700007)(478600001)(38070700005)(66556008)(53546011)(66446008)(122000001)(2906002)(6506007)(83380400001)(6486002)(66476007)(5660300002)(91956017)(76116006)(2616005)(186003)(6512007)(316002)(64756008)(36756003)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t422Su+IeuDtxUA3F8wzdJJsOoA8ICGH0D9JC3zHTDXIxTvX5O0iwCuVmFVc?=
 =?us-ascii?Q?nlzfo1BehcdclPM4xKYUi0pmt2Gx2ITqh9yeZqpulnaK1X5bd7w2IND5mUNo?=
 =?us-ascii?Q?wPiLiwwJhZXYCcoTBisF65md/7OHBaJfrCntJs8S0jDkfUkWsCbAKaYBPWkQ?=
 =?us-ascii?Q?xsX0QTGRUHS+EQXbh+pkZfvaLKdHMTxom+UNBC3snJMxTH+nrXaMe6fgvWxt?=
 =?us-ascii?Q?lZTM3HM+Oakwrm7T2uOJqFRDxe/2o/aFtbbp6FnKCz5+OhfFQxkupm2BH2aD?=
 =?us-ascii?Q?pWxnKBVTd1EY5WPMMqfvB7DU9c+BDRmJ+zZ0KnmMQkIJBpY0SIKwxC7/8VWx?=
 =?us-ascii?Q?zOfUY+G3bcvEckgeJ4roOWkuPAXfKDxeelx3B7IpZWFrFOnp9+2SYH493ROU?=
 =?us-ascii?Q?T//Veqgu2Mlb9fgFrfULGi2APNz6uYIT7FPQcts/e+wR++3BCMKZKZhqM8hK?=
 =?us-ascii?Q?Yj+H70aaNxvd1fEe4DcUZM4EyMuljcokME8Lt/DlwapQOuea62Nx6IBq0h4P?=
 =?us-ascii?Q?b+Z58+C0CBlkRM3WbFZFSXofiHJBLjTmi+JbMkVSIylOXoFK42UCKgx7Pyks?=
 =?us-ascii?Q?yANuN6APj5cG0JuOFLMKkqnnD9x4/d+BKzY/v3mkzlSSLQG2G/gS/guTXPvy?=
 =?us-ascii?Q?abfGObkeGX7WWdL6+iIz2y2t39eGmwj2Xy/vmKKTtTz3FfO9TMCi3YFNeG9b?=
 =?us-ascii?Q?OXKyBmnS6NspSIKa0/ZG3FVFnmqrfhuq+0Z9GY1ijedxc9oUdEs2d0L0l3eQ?=
 =?us-ascii?Q?mRHXv0M52Kx7UZDcWdUeUGm6Yo35JOi96K7clEONy0Q9Q+6hq2yZr0BM9BqO?=
 =?us-ascii?Q?rHEbSZQOeO6Ha7ruYk/jEiI0ysbgpNddYIuT0lR8hoXVfQ9Fzh4TlloUDFqn?=
 =?us-ascii?Q?wEw3bKxGNwNGx+XlRvM8HcY+kmIh747k8evVRsIBp9LduUK27VUBf4iGIvh3?=
 =?us-ascii?Q?vIgx691RRFGzFK3Sc/CpqBtsqn1C+JA1+xhY8xEtAE9j1kdY6/hte5wAutmj?=
 =?us-ascii?Q?f38syCJ8FGSnhFlCTRl0Omw8ETIJi9xYtaBHL9rj6XsOW/5XHIJVzNCcFyTu?=
 =?us-ascii?Q?CGS44dpOqE0CXEmGr8vw/8XDG/Iwj/AL9rVaXicVEp18nbHzKT2Iivi3qDwE?=
 =?us-ascii?Q?qIFsRDy7lHl+uH8IFv1xZqclJOJJhsBtyR0QXNKgqJjfr6ZGLjYxXrx48TMq?=
 =?us-ascii?Q?np4v9Eug6XWUfFwVI5eAJKP7vMuYZ457pUAEt5hOCRzXY2cb8OL/WYhmvZec?=
 =?us-ascii?Q?UcC06tGMbjCrgiiOUHNR6W/AYledBmG6PsFZmCZaRtPlgCxvR3cAREMiIHCf?=
 =?us-ascii?Q?prBFaZBkRYjwsQToYNtyF0ec?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <06BDCB435FECE041B2C3B023B75D90B8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd8f598-02ee-4a60-4fcc-08d96649ac9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 15:21:26.2414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8H61lFITAt/hxLN++EHVg+HbNJCL9H4emiOBXg3ieuXOLeClbDBecVELD1z0w0AqfkpLGgpoVlmnue7r5WaJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230106
X-Proofpoint-GUID: jbWhjgj-I5atTscN02kslXPVZfWKPVlY
X-Proofpoint-ORIG-GUID: jbWhjgj-I5atTscN02kslXPVZfWKPVlY
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 23, 2021, at 5:31 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>> On Jul 23, 2021, at 4:24 PM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>>=20
>> On Fri, 2021-07-23 at 20:12 +0000, Chuck Lever III wrote:
>>> Hi-
>>>=20
>>> I noticed recently that generic/075, generic/112, and generic/127
>>> were
>>> failing intermittently on NFSv3 mounts. All three of these tests are
>>> based on fsx.
>>>=20
>>> "git bisect" landed on this commit:
>>>=20
>>> 7b24dacf0840 ("NFS: Another inode revalidation improvement")
>>>=20
>>> After reverting 7b24dacf0840 on v5.14-rc1, I can no longer reproduce
>>> the test failures.
>>=20
>> So you are seeing file metadata updates that end up not changing the
>> ctime?
>=20
> I haven't drilled that deeply into it yet.
>=20
> Fwiw, the test runs against a tmpfs export.

Btw, I'm still seeing this failure on occasion. It had stopped
reproducing for a while, so I set it aside, but it has cropped
up again.

--
Chuck Lever



