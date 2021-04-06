Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0AF35593F
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Apr 2021 18:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhDFQeE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Apr 2021 12:34:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43012 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbhDFQeD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Apr 2021 12:34:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136GTVDj087600;
        Tue, 6 Apr 2021 16:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MZurK3+bm1GW6p0L+kA5ifLz9e9phBj2Ktu6vq02tKI=;
 b=laesaT1+KwOVjNxDB5K8tfsSCfTFcw4W8XcA7cwdmqGFGwpollQL+8BZwlHzmHdVAU9q
 8d4w543kZ6TgnSZSM74DR0fuocP6rKZF5OwTYK2Y/flzmkLGw7XCFw1RCy+Bdm1zaWPQ
 28WUkd1pjI/1PLF/eiTfGE2gu0dpd44OqMrKQqI9LMB8+SovjA3msUsY9ZUvwBQp3Lc+
 G4HdYh6qfY0XPYSbqm+1oBP4U28sMW2ZAw/h2O4pUgCQwnfosY7b1RD47TNbIb/sureY
 LdrFs6CRJPI0vyX2HGkwYcMQQdexsvSk8L/B607KyjsDwDNnbwUW/m6jnFy604ipBdYV +g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37qfuxdg8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 16:33:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136GVwiS141678;
        Tue, 6 Apr 2021 16:33:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3030.oracle.com with ESMTP id 37qa3jpp0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 16:33:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaC4U27j5BhKk1ZOm5vrnTUICh8kuWzuEoAaIrnX7Ctqf9e0F4KSJqQwg+60ZYdE6apQUS3UDTha1t+RarsgnDAQgZQnVRx3s4CuLIfikdN1TZ4LViS16HjLGziR79Oz6JMRWYFOkEDQnBugVshbOmPAKMN1dUDJKnrkzH+vxNdYZsbHAT6K/g4y6FFbcXoaQmFbOaNAyoDIdwvYnq9I14JW3vPPY89Ww5+PUmXfj14mIuM71EzZNWIHaAjgF4VnFCFPrROWtpZmn3rfEgbtV54Lq4+W3YEBsBzErtV5NC8phJS7jS5dF9ALIR0CIFU+Df76gxHHyRCpSzGGqBDIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZurK3+bm1GW6p0L+kA5ifLz9e9phBj2Ktu6vq02tKI=;
 b=dluxR22QWpp5hWh9rXMB/sJBE7TOugdWrvUhvph1HBGqMcFcAGctHucjluRC2Dv5AMHLO1oC7E1WLvhl2hc3NVles27yRwd3I0aQ1smabAYcSgU2wwE2CLMJFxbVB4y8k+mLyFDtHMHy+HZO6kFwAXoPL4eo/ZgPKF5iDoEl5ayNCDlwQollQASAHc3fC4xSIzR4uQRjDcMc7R36tYNuf5PaekhO1BSG4awKJQhxnFeBZvOlKs1NzydCt23+wTnos7O4Hqd5SsBj/g3GfwmSpFttV5nI4X6WzTNC5Z5R3vh+pC8HH+2lL5FMg64BADObh3SyhUJy3BuxSExha29Zrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZurK3+bm1GW6p0L+kA5ifLz9e9phBj2Ktu6vq02tKI=;
 b=TOlFkZRa88z5k3ne6v7zdCcXhLNKcbLOwfEMYkRlgX4FQ5TsVerk8g7/hrukSSu8jFs6RlYKsheFbuiJjZyfffceYJGpIPeqKWNXO2lQQOFUDgVw9SBGYFwcjbxlaNbOuqI83adJTHtIb1JknOtYY9K6HQJCUvcTzafOEvHpXGE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4653.namprd10.prod.outlook.com (2603:10b6:a03:2d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 16:33:47 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 16:33:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH v2 0/2] enhance NFSv4.2 SSC to delay unmount source's
 export. 
Thread-Topic: [PATCH v2 0/2] enhance NFSv4.2 SSC to delay unmount source's
 export. 
Thread-Index: AQHXKBgu9IXq70YdMUCq9qUqUB+L96qntQoA
Date:   Tue, 6 Apr 2021 16:33:47 +0000
Message-ID: <D85FBDD3-5397-4D47-932D-159AFE2A5E0F@oracle.com>
References: <20210402233031.36731-1-dai.ngo@oracle.com>
In-Reply-To: <20210402233031.36731-1-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b4abdec-db51-4083-ddd4-08d8f919c07f
x-ms-traffictypediagnostic: SJ0PR10MB4653:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB4653E73E46DF6DF1A47D723E93769@SJ0PR10MB4653.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DjAIKXxeuVbkPMxd5Mo5VyTEiKm0j15bQzqHRy3tKKGOQ/q2ciNIfQxqRUDcyAV9AvOlkPzpbGbN2wYUzsmeD+GWfqrbvRFOhzt9ki8dDXbmVVPZ/rZMI28Cl9Zpwe9DNDR/ZKFoiYkaLkYjYTSYxSywllL3r093SVGqlUibM3voUGfGB0YJgtjhSefr4DC7pk2SEE7fJw3N1w7kAdcfblTj4gb5tzdjY1yuoid1Xt8QGhmNqmT6su6oWdy9Kr7xKXDz5xntRoKwYZsKQIVxa7du9I0TNORTE3c/U4NCubke7sSkOkQieARsgq6QLzWHe7ibdhfN9frV8vEDcntOD8CDvw1IS/Cz5/Y/v2UGTY6ZRCkCi5T5OXD/Y5KdJHF30mrOQ3K/2koWOH+EmbjLg9vDnOTbJHLYZ28sAPRulegK1Z5Cf5unS6VOae2KRDwsjZkoBnc6F+jSmaOjQuCmR27kIQ+JNNaN4r4M2wEBPduIoZIXWaUGCJQlpnzuS8Sje5J28FbWs94jvkpOikgoaYTncCdczRbU7iXL/KFZ4MqLirjrlJ4F3DGfxIvKXAFchlsYuqImUpdzYpd2/t7YvYF5LOdp+s7unnkiVnn5+w+TBjCKmE1cyeX+TGj4VSchVBXt0pEtWPVTXJ3OMceTsTUozmmpWLixKj9pHeFRjJi1TrOQNISk3BhiodZ+rZyu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(136003)(376002)(39860400002)(478600001)(33656002)(6916009)(4744005)(8936002)(54906003)(64756008)(86362001)(38100700001)(66556008)(186003)(66446008)(5660300002)(66476007)(53546011)(71200400001)(6506007)(91956017)(2906002)(6512007)(36756003)(316002)(26005)(2616005)(83380400001)(66946007)(6486002)(4326008)(4743002)(76116006)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?THLwBc7cxEM+doBNA3QKjtc0gK+EkEwXsildzGh0Ctdoy/m05kXDueHod3dZ?=
 =?us-ascii?Q?Kkv59zS+rR68CrXBpH6Y58DlSfQyoPFmvrHI5NKF6mr1PklP2Lg1SgmqpXh6?=
 =?us-ascii?Q?JreqwiCraoXfv3d0ce/QUyFJOYutnk9zOjhq9PITdjOvLxMWjEXHz1nmbxVe?=
 =?us-ascii?Q?RLBZO0Ks5ho1v3vJOb9+OUtwe0sdQRAYyklkTYw2Ynwt5nxSJoOSeKY8l5CP?=
 =?us-ascii?Q?ziTOkv8QGGZpyUJ8+JQvKAXiOphBXt/4Q7SPaHqQf5pHgEESMj3gth/iNfhH?=
 =?us-ascii?Q?2ZWax1QKfjj9ZC6m3KJTR1D7bnU2T33YAtS8sk/b52LaSe/K8RKD9Q6n0IOc?=
 =?us-ascii?Q?26LQ86+cDmJtn9A3Tj36yZ6hV/rqTd8dgGJqJQ6rz9n9DsHNP8hp9H6NueKU?=
 =?us-ascii?Q?mbzKh4dMFPnRudgMdlQXw2A8Fw/hPfqkYk5R8s+gFIrb6VWKTX5w8fgwa6Bb?=
 =?us-ascii?Q?aAuQ3H+Dccy6iZSJTqIAvesdbbsp1NKYN3gYM3awDduXhpDYdDU73L6utRK5?=
 =?us-ascii?Q?/beHgo/hCdRNmrZtg0T8wvpguWwR2XjfDLiZjSKdr34opbvshnnwiFtPwGN8?=
 =?us-ascii?Q?mhbfNobHjonSOiFJa00dE5+qrcXD9bz+zbeFsD5YjL+96BlsuurwWonMqCRV?=
 =?us-ascii?Q?+JBJxZ6YEfgRWFv5FJmuriomWcbnqSIvYnc1QAX0+K3VyE9DXl7hVm3UdISS?=
 =?us-ascii?Q?rfDwTnbQiEVJQNDNbqfsU6cUaVXasVutp/stnpmY0MD/DmXeavIusz1U29bw?=
 =?us-ascii?Q?mwHRpzYmqDzDCoeVHWFPwKoi2hWfWtHC/V6C+QM87bQdcDlG1Or4M1ooZWRz?=
 =?us-ascii?Q?WlpNWtkc9EFao9MdWZ/MptLA8aSBIFsGVwcYbvXoqc99uyff4jUyFdGJBsZ0?=
 =?us-ascii?Q?+/SW6Qwbwyy0Zu40BBrYyGaHBAmVGL9F7PjQA00rg10ZT6RvucDdz1kot8B4?=
 =?us-ascii?Q?qTCcSwkcGvEa+zgA1qKqmSQHSex5Re//HNZ49Nqm4qlseVgL0hcHkgZsbXnP?=
 =?us-ascii?Q?Iua+cKybb7QZ0C/FpzAfwS7xRRr4w4sQEsgitbv7yZPfFwrI7hmtSvaL5Y1X?=
 =?us-ascii?Q?7zn0KkiL9DEmwPzjmiLENN05kcs4sib+CAVdwVQZN0kLBEjgFP/g96MZ0PZF?=
 =?us-ascii?Q?bVwSleqlV8mHuVQhLpgMAqAYgmHPXhABOO2EHudphgPGxml7Zsf+TJpgHz8u?=
 =?us-ascii?Q?jr6z3M5c+cbX/R22FQ3Xgno00b+5nafqieimjnSukToCoAVYMRXkwAaIOMvK?=
 =?us-ascii?Q?5bqCaTgdGEXTqBEkXkdXK2XUStsLBo62jFVHfb9UHvpHsfdAe0JABx91foNS?=
 =?us-ascii?Q?tv6/1Isrr2LS99eXqvazOi9Y?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6E7F8826DD79A9438185AE2A1FEF1D43@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4abdec-db51-4083-ddd4-08d8f919c07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 16:33:47.1312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R7meH2GW9L6KyBACiAGXkSdXdNgyrs6A7j92AFtU568B6EqJp8agsb79ssK8RvS+2Sp4SNwgCL0SHTWNwp1Rzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4653
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060110
X-Proofpoint-GUID: hARfPwgkYo-cbW2Ox7yWqrDiwmkvdVqu
X-Proofpoint-ORIG-GUID: hARfPwgkYo-cbW2Ox7yWqrDiwmkvdVqu
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060110
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 2, 2021, at 7:30 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Hi,
>=20
> Currently the source's export is mounted and unmounted on every
> inter-server copy operation. This causes unnecessary overhead
> for each copy.
>=20
> This patch series is an enhancement to allow the export to remain
> mounted for a configurable period (default to 15 minutes). If the=20
> export is not being used for the configured time it will be unmounted
> by a delayed task. If it's used again then its expiration time is
> extended for another period.
>=20
> Since mount and unmount are no longer done on each copy request,
> this overhead is no longer used to decide whether the copy should
> be done with inter-server copy or generic copy. The threshold used
> to determine sync or async copy is now used for this decision.
>=20
> -Dai
>=20
> v2: fix compiler warning of missing prototype.

Hi Olga-

I'm getting ready to shrink-wrap the initial NFSD v5.13 pull request.
Have you had a chance to review Dai's patches?


--
Chuck Lever



