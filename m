Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817AF313B92
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Feb 2021 18:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhBHRwg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Feb 2021 12:52:36 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37248 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbhBHRvq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Feb 2021 12:51:46 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118HiVmK088748;
        Mon, 8 Feb 2021 17:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=8mNP1UlXr0U0hk5bgJ43TIv2fCUzZQGaprToya/rHQU=;
 b=xDTaXXoGrRrxQ5hevKW4/yE0HdiDoHoB0jGfpju6+yf/E1jYt7eKaOtMPZQVFIS0fXve
 KhBOgbu/MPX95CpfrdXVvCMiAACS6s4F6mrF0R6+jani/NpR+xuFqjMWlYJADHp2jpgY
 sqJQ1JJQRjHRfUizB6oGQdZwR9VoJenXNx/Ln9ZokZ++mIEGA/H85QI7TEa3wzJkmRhc
 XSIZs/lik9pqnnAbhzG81PjLMRDNWrr/uDa1bVFUAAU0xTS1dYGAcjGtrKwjqHHJ9PIX
 /VijgFDwRUCSeGJ1mCqkEQSXvonIrJZbry+Zfmh+VX6fPQyAqFf1awAt38LyvMTtDfoC aQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36hjhqmss3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Feb 2021 17:50:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118HiurV090689;
        Mon, 8 Feb 2021 17:50:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 36j51uyspp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Feb 2021 17:50:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2PGL4uLPl2FLhBYg2FZKh4F/o/SbBFu+hhfcdDhVSHb1k14TIQqqWP9xF0SnzQoBSLs6IzFiuYhRbFuODXeAdo8VpNhX8P/QZzc3IRQmSD5oa7BgFZNE05yJjGN1CeojmL44BHiZoKX4ukIVPeLGXm31fmtoWt7BInTZ2/8JP4zxeaknDTw1V5heqrQ8e/y52lOh0dlYqR1NkyE4u5GafryegiiLT81uDPJ2YpBBCnZ/1V7fSXUsVyq6CmPtEVydmAV+b42xHG0fI7WaeSRIKvWxqA049b1IpxkWk5Tprw8N0ZARxsV19O43SCMxxrSBmQJNjp99LrZPIGtG/trhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mNP1UlXr0U0hk5bgJ43TIv2fCUzZQGaprToya/rHQU=;
 b=GMeyPHUx0A4Ss2DitfFJxUMYKbuh6g8exNMwBTa0EmiArGY5vSOBoFHmkz3Gf8jbC/PeNvkK2pm2FOrcsR2dm8cR95kr/rskF52xNHlSA1Xg5z2xjjcPMaYe5JsZv5tYv8MdRgDlFTkPYknkhHjf8MjcqkGFKOKDnZi8LBIvZe500nYpU0T/9j/vaOhaOq9xt6exR6schANchhNy/4FyfvXmFYMLidGP3UGfi750JP7GkKH8eGn+AmvrAgcLz/QKo5OYmBWuWR13/BmkbvEz1GpgkiIFl9awfrAnJEliREaiGOaT3DZu9FL/yx3ezFyBLz5A+MHA70oOSllNwNjP6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mNP1UlXr0U0hk5bgJ43TIv2fCUzZQGaprToya/rHQU=;
 b=bAKtXWz/CN+92L6gV9WlPcw5GjZp859/50HeuyBxz1V4oAX/Pn9mQhvTi9ZBKSGrImWMks3gvynWDUUAZTg9CtimSCNHyL7l0qpY5IbXa26fv/+3BMQS1oOPcqqNf3KyZIuZLFXLzbXY4pB4IJm1yLAaep6kvAFs0e3zrVLh2Jo=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3335.namprd10.prod.outlook.com (2603:10b6:a03:15d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Mon, 8 Feb
 2021 17:50:51 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 17:50:51 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     "mgorman@suse.de" <mgorman@suse.de>,
        "brouer@redhat.com" <brouer@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Fwd: alloc_pages_bulk()
Thread-Topic: alloc_pages_bulk()
Thread-Index: AQHW/jD1lENfvnr+s0+/RnBes7PyXA==
Date:   Mon, 8 Feb 2021 17:50:51 +0000
Message-ID: <EEB0B974-6E63-41A0-9C01-F0DEA39FC4BF@oracle.com>
References: <2A0C36E7-8CB0-486F-A8DB-463CA28C5C5D@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2096be66-3fd1-4b15-14d5-08d8cc5a134a
x-ms-traffictypediagnostic: BYAPR10MB3335:
x-microsoft-antispam-prvs: <BYAPR10MB3335FBC8B7A820FF3D9441E9938F9@BYAPR10MB3335.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SodmqH4X1/VJ2rfG6ntNIlXnmVPGE084ImppmDpszoqCfoW0fNUpJKLz+DgbLP9/ZE44HdNpKWKPWCuVomQCF8f59uMeR51dLpWDevuFBRgqDoix4J7PJi6wPuZV2a8siI9FwOL9jIYUb/3gJZ99X6lz63+2ih3vUO9YbuuP4cyNLOP6zZAEzDATyndWEGWtBKRWBLpBvkuDG/YV8clYpn/F5qFwimPFtjrXXJGTgOdI6q8w2/AGLCVarCZzQQQHo278lxC0IOZSMYpq2zvJc4o+4jwczpugA3Y/ZYMC+DF3NnRj/zSk/HGUb5SYtBkmhPsWzoRgYhItx0yr5Fc9AIaBDUr8gu6F3wwpLiVA/87vDkY9wkvYafK0dZdIEZiWQflqPf6b5weoyYM8Mqjy1P2/7d03+ZYOWCo8OMGEpUGAF50g3MhbwXNMVKSRP5w62q6/W7ZJI06x2SYHvCQ710dxqrO19MoyowoCDtaQ4958u7iJ04v9neXaLnc9Fy6PTi+qcq7ubEQdI9m20zmIbwsj5WHDwiYraFMD55/Zud3bx0/THaYKG5yn/sORtVhrf1knvGDEtkiq96g6zqVeW8Oo9rvJN3sQBNNFxSuelGlnFC2yhpZz2bDleiyBD0ZRR34+dsdsGqPMBynRA8EopoO5tLM2QLVki+ni3+ahM/w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(376002)(346002)(366004)(66476007)(66946007)(7116003)(66446008)(91956017)(66556008)(76116006)(64756008)(966005)(36756003)(2906002)(8936002)(83380400001)(478600001)(5660300002)(186003)(316002)(2616005)(6506007)(54906003)(110136005)(6512007)(26005)(33656002)(86362001)(71200400001)(6486002)(44832011)(4326008)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nvsXzYImwjpmKeQqmF/ydDKkFBI+IQt5Z23bq3bCnQCcLZBydpOyBfFJmY5V?=
 =?us-ascii?Q?jMxvb+FtWilvbbHqsFYAa2hbS0lvLDZnjT+yRfzhWOSIO2rXzAHRWgRhppMp?=
 =?us-ascii?Q?vHSe/iRTdm4efCzjBnBaV/2jkUbzMLA0IWixy9p4QgHNDILlkYWkjcn0WFFZ?=
 =?us-ascii?Q?H7Uup4d87E+gVeh/je+9mNGFuawlFBlN3NtkWf65AJ5i6BXxEGNUYZxj9Tzl?=
 =?us-ascii?Q?N78hbWWupjN9KDvHQESene14gIotFRJm426Y9SUgcaXPt9Wp/Ayw98VazZ50?=
 =?us-ascii?Q?Tk9tLg1cRqyMcqkDb/ZwjCpwxSE5/uO/o6EEAKpOncrcXpR+CWqOQ0fLPkCl?=
 =?us-ascii?Q?Y/x0EkjGGcAXb4ct7g7auZsIZm+NtP0ReVFGn7Y30lc25T9Ml2hu3Wewrl0b?=
 =?us-ascii?Q?HoLJXR3xnh2eGPLiYeIXm9gHV0aoqwNTPqUbsF53/5rUArssS6lueTDuF4dK?=
 =?us-ascii?Q?9MIHvM/s7UmxDdEjRR+R85HUPHwE/x1eGJZnG3Zr8V7WnKk6AQ6abc+H9wOT?=
 =?us-ascii?Q?csVhtE3OPTfJkYnT2oEJBQylS6DF/csUJhSe4tnXfnBOY7uKHAs189sNMTIk?=
 =?us-ascii?Q?Mcnd8XO+36Q/4/qUi+g4UeFOX5jk7dIVvFAHKPXsw4vZ4Q3YKf76WyiQvrto?=
 =?us-ascii?Q?eRp7r9pFHLBQ8UAKesXfA+qke4yXZVSZeS/a9xHHLHTvRtbbbCernHHaVYY5?=
 =?us-ascii?Q?elb+00CELoBKXVz7v1DK0rMTKzJQKfE1bGlyCABxFcoLaTU7zz7AWNVE7pqq?=
 =?us-ascii?Q?XomCT9iEKmgqk/nxv191r2/cu6B2/NaJWFqlo16N5u5kV2lNj3Tl1W0t8TqV?=
 =?us-ascii?Q?2q+jzReYGLkuy96fvK0hXkIphEk2a+mQMBPbafwWYQCxbgB0fqwE+5pgqZJx?=
 =?us-ascii?Q?xZ9E36cHGv9y11TDocsPLiKjqeWoHAA3RIj6n9FvdmueWNpnxBkPCx18ZzIB?=
 =?us-ascii?Q?Y0TwcXVBeTsA1Q1IKeWlZ4SuJAsrFnogIfd4w0Qiwz7BQOF771tv0ZvQE1r3?=
 =?us-ascii?Q?uh9DWfNHpifXzWET/+ozsJ/IwQUzQHvuzTcmcUejT7jWq8g+oXuVohfiwWay?=
 =?us-ascii?Q?IJt5wpgY6CwiVSFFxCQG9IZIUvMlzIBX34wxcBNyniADUhV3Cyhf6z87XTV9?=
 =?us-ascii?Q?wYYylnjP1oOvC9dCyThK7N6WBF/CxKld4PiKLsveWIQyK7qz7GTiI082Rrh6?=
 =?us-ascii?Q?EUlQkzQ5lYV9ife0MwkTAojp87LDlW+YiMBugzyRI3BpgHkGwnNyoB2H70pi?=
 =?us-ascii?Q?yYYBEoq2JUV9m6cnxFx4zhR3UVfXot0ix0Z/19WV2yY0PwzV1glhno8YzX6u?=
 =?us-ascii?Q?9ONIzHGNXo2S6g8GQfSyr0W+?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95BB4FCF69F5CB44AC61BEA102D8BB48@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2096be66-3fd1-4b15-14d5-08d8cc5a134a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 17:50:51.4594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ArZRKU6SuaqYhbe9p1q2yKHa7LUsNYo8HshX7S4uEb0JU1yiPnoSq5S/GcNeRUkwmFF4CkUSyWutLP6gu6nS0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3335
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102080111
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102080111
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sorry for resending. I misremembered the linux-mm address.


> Begin forwarded message:
>=20
> From: Chuck Lever <chuck.lever@oracle.com>
> Subject: alloc_pages_bulk()
> Date: February 8, 2021 at 10:42:07 AM EST
> To: "mgorman@suse.de" <mgorman@suse.de>, "brouer@redhat.com" <brouer@redh=
at.com>
> Cc: "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>, Linux NFS Mail=
ing List <linux-nfs@vger.kernel.org>
>=20
> Hi-
>=20
> [ please Cc: me, I'm not subscribed to linux-mm ]
>=20
> We've been discussing how NFSD can more efficiently refill its
> receive buffers (currently alloc_page() in a loop; see
> net/sunrpc/svc_xprt.c::svc_alloc_arg()).
>=20
> Neil Brown pointed me to this old thread:
>=20
> https://lore.kernel.org/lkml/20170109163518.6001-1-mgorman@techsingularit=
y.net/
>=20
> We see that many of the prerequisites are in v5.11-rc, but
> alloc_page_bulk() is not. I tried forward-porting 4/4 in that
> series, but enough internal APIs have changed since 2017 that
> the patch does not come close to applying and compiling.
>=20
> I'm wondering:
>=20
> a) is there a newer version of that work?
>=20
> b) if not, does there exist a preferred API in 5.11 for bulk
> page allocation?
>=20
> Many thanks for any guidance!
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--
Chuck Lever



