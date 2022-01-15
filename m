Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740EF48F91E
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jan 2022 20:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiAOTq7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Jan 2022 14:46:59 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5082 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231172AbiAOTq7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Jan 2022 14:46:59 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20FGdLxf018362;
        Sat, 15 Jan 2022 19:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hD+oVm3wb6kGdiEBvYMLjzpzQahg9VVMHSuID5q2z3c=;
 b=RHimibof20EgZtsexxeXixYHMHFBsdgLKLtIp8cj90S7qvZ3kcKQFikaKDl0Ga0l80pN
 2zxpY6c/sSWdJZuJYNlDY13UEtO5eYuLKyunZueaEPvEAL75pMtA2YWMyaoeei6s6C7B
 O0BAm8yYXTElWyeKUms0he9v2eTtY8arRqXT1w17Q0u1CUEYQ4o9GpyVdjU/mctKftG2
 zcoVmBZyTdsOZcPBFiJtHb/Gz4xMRmhsQ9GzaMKtb2x9eVTQUwA14uKYj4+rn3dKAPzu
 1n0MrVjybE4p8VC6//s2WrjT6GzsOkZaLpS4eT9L7dyE0V8e7CEuUzYDQEjUPC3nowRO fA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dkpttgrsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Jan 2022 19:46:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20FJfoCG068476;
        Sat, 15 Jan 2022 19:46:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3020.oracle.com with ESMTP id 3dkqqhpdsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Jan 2022 19:46:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UC3pHYgOE/WVJy25BnYDOtPYlNPjqquK1fbvWMQQqgaty6q9lKkGuGIvgk32nQZuk/Wgch6VY1pmjoxkafayOe/7OcqjktNUW7JlrYFNPQRF17B6wl1PVP1woxWAg5J/IzzyxmjLnoYu3wYmLbS+N56ObgFMkWJc3hsFCm9tanbYwux8NDRg3EMgLtdKxA3iQhDkL/DDpKR9rcImx3kaesStjdSb49hZtMToDYGxp7xpmIpaXfeP/mbdEEDCVNDzphKVn3ks9Jy7zTfZRMiBaqB5SvntpuBeNllhWQbk/3GSu8R9OgnBi7aWuNY++PBxmGTjzdlAqxJwqDEBEoflfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD+oVm3wb6kGdiEBvYMLjzpzQahg9VVMHSuID5q2z3c=;
 b=mkwTNVtVEk7B9/LUMtEF9yuRJCkZFVfrs4Jp4UD5pE3p5KhO4Eazvg+vA5SwGd8kQlc8Jg9hVhq388SoLi0epohdpH5hFgU2vB87T7hF7DbkSFtp+h51gNMI5xmZ//AuYUtFDdB6aJFs4FlLQn1mDzbD5Vh8f5l7sDiJ+riwSBI8Y/JYGkzpRGkC+1CX1pIWCkxNcBcVPZTPdzEArj6ZOiM02rPuQNkWYrM7nvA+NRqcgXfAUUoGwJ0D5qqoMH2s8VAKYQikbeZQk9AmIlJOdkkn1bhJxAso3VnzVcpDyeAabaEHYFtAVDGhsxIdJGiZkzifaUKjrIYb1hwz6Itb4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD+oVm3wb6kGdiEBvYMLjzpzQahg9VVMHSuID5q2z3c=;
 b=XrcA2Dcs+4j4Sn7ta0MZp9OYsaNUAliJvZ8LTv1JLQhXGQcy7DyuyBKilgoJ95hs638BXTzmGz04e3qO48sUwl1JcrYqiMUd9Rmrw3LXKWxd3HEGpoy33CYCqgnVMoT1eoZUlBtAtPuYI/+Coh+x3h5mIszU5Kxawu1EMy96J8M=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by BYAPR10MB3143.namprd10.prod.outlook.com (2603:10b6:a03:158::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Sat, 15 Jan
 2022 19:46:07 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4888.013; Sat, 15 Jan 2022
 19:46:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jonathan Woithe <jwoithe@just42.net>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [Bug report] Recurring oops, 5.15.x, possibly during or soon
 after client mount
Thread-Topic: [Bug report] Recurring oops, 5.15.x, possibly during or soon
 after client mount
Thread-Index: AQHYCTZE+ENVwkeetkGrNbALtTtuGqxioWgAgAEb9gCAAMFGgA==
Date:   Sat, 15 Jan 2022 19:46:06 +0000
Message-ID: <927EED04-840E-4DA6-B2B1-B604A7577B4E@oracle.com>
References: <20220114103901.GA22009@marvin.atrad.com.au>
 <C7A57602-4DDD-4952-BA38-03F819DBD296@oracle.com>
 <20220115081420.GB8808@marvin.atrad.com.au>
In-Reply-To: <20220115081420.GB8808@marvin.atrad.com.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72c027e2-63df-44bf-41f1-08d9d85fac17
x-ms-traffictypediagnostic: BYAPR10MB3143:EE_
x-microsoft-antispam-prvs: <BYAPR10MB31439833FA786BCC0F386A4593559@BYAPR10MB3143.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R155YXmbi0pvINoHyYQIZQ1XdG1zorJtcTVXVE1PrDcBy93TtE0eENVHLqpTVmUH3Kjna1ynOFmhnFHQAPCBDtsHC4VuN4p4GlFBxcs0lswSkCaqnUKI/lz0AyYRjLuER5r601eoc4OL/hsHOZl7Gyqur27f6qLPG9a23P9U0AkUdxVlowbTdZjNapCOydDhScmWlipPmUJnVuWDJZNQauVWBlZKdWEnpcGYMEWUNxa7iAHm8WMXgqNBGHqEIt4soSC8EGdObIVAbgHsvhOdt8Mbx4+43neLnD7bU1S6mxNv8XXxdllb6RnlUU8SbCovrAbrrdzhTtJ5W7SBuHd86IZC5WayYbYceJnSa3hJFtO4B1rfn8siE6UC/P9zxVSz8vx38ZivcTOEtnRRmnGMR2rZzcHbd9n0aK59+uSsCCX7iHJjH3/iPJlKVaPzSaqnOSL4u0E/2kAKmkvja7tpU4Y8mh/gMCB0mh74o90HBANFKpRhxd9NJ+/7vTy+SiDcEdKIr49ECTdKXcbCZLr6Q8gQnR3u1kLcv6oTT8v6xKQ/LH+wXgIRR3LYIasJoWWBTImW11n7/5Jeo06rQYoTaIl0Flr7bGt6Xo/mYd0kiNdI3SPbYyyL5IrVShpiaAkeypZDbdGp7KYsE4lS92bZl4qKjzRVC+ftYXy3Nx1ZZ8b1pJRQgLyZe/CxNn76SChzwRqdUVRTZei+eepVoEtXxpHY2r53pTKrwP9kULcIeBNhgWpm4vYpQpXW1NVOnqOS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(76116006)(26005)(33656002)(6916009)(2906002)(122000001)(83380400001)(86362001)(38100700002)(316002)(6506007)(54906003)(71200400001)(53546011)(2616005)(508600001)(186003)(36756003)(6486002)(8676002)(8936002)(38070700005)(66946007)(66476007)(66556008)(64756008)(66446008)(5660300002)(4326008)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zm/VQXHzwap3OdRnrvNXll548d5Y+0Jp/R31SFT0xfAFJ9T9EMZUcGX6Wuqb?=
 =?us-ascii?Q?HwBDjOc4pNNnQ/rRcas+Xw5Fp0JHsfKJApp+B/XJBrP5qfcqxMR59rpA7KZh?=
 =?us-ascii?Q?mPMHyEjN9b7TcPIrEuN8KhGmwN7+os9MRbCKhFdhC3pUCUDOx8R7b/2lDxf6?=
 =?us-ascii?Q?PVkarlzFvamkrqbEbCBhVIdgEvdi8MsTKsUIiayWt/Wd7nVvBAYKU1u60s/S?=
 =?us-ascii?Q?B2eDOrim65hhv73pv0X8l3RgOjB7F0MXQni7D1blC3VOCMA3KEO/FnRdaJYP?=
 =?us-ascii?Q?TXwwJyCWf9XcjPYxEiNDs9YujeJo0MIc+4Be3Xfqm66wSheBMg8OqJ1GnM1O?=
 =?us-ascii?Q?jj4zUS11hZg1qfA/W+Q9/l8yt+dTv/Uvcqavl75cCvSseCEMpjR9qdH42Odu?=
 =?us-ascii?Q?hzwKbOYlVWg52krYeSoYYU4Y81nFTP6lPZO7VfMW877NBLk11B+Sx9ANNFbb?=
 =?us-ascii?Q?Hhj6t4XV3G9WXFvu4n+gOxG7mZMywFj/BEmV+j95/kfdRv+PK7zlnKzPqp+i?=
 =?us-ascii?Q?llqKiwtzRaogG6skbQ9At2G+3sEGc6xgkeIgRwdoIbZJ0S/4bdOcuRZvwU+7?=
 =?us-ascii?Q?DppQ8gyH0C7lmVcRVx0uI/md12/JcQTB5ZtoX//Vg1+ByULo2xhKdCkmnwgv?=
 =?us-ascii?Q?a0ZgrUaOxPFnvyWFYi02U5n8qC/DY3DWSbmBiryvVbmZO+oj/gZetCsf9b/M?=
 =?us-ascii?Q?rR47/VpF35jzHPJXRrtz4KL0Y9gNAsMxp+YkvgsuH1jXHIx44Kc85ElEtHG2?=
 =?us-ascii?Q?Y+3eVnq0R8aMtaCO0USpzrKDhUGlgh6EKvt1J94tJ4lprpKIE6SQrf0bHsPb?=
 =?us-ascii?Q?x1pYNMfeJXjaCDD4w1NgcO7oyGqsB6VtH8TleCWbaa8T21oMdpwCpeXCNdss?=
 =?us-ascii?Q?4ipSKjejbP06W1TZe1SpE6+J9D3MNUERhHwTFt/PZGCVhUASLhE20U2KrlLK?=
 =?us-ascii?Q?RXKdjNZUgxD+Xa8bpt1pAmSGTm0BorheEuxP1lp4y//G0BdWG6HbKi1BUE8O?=
 =?us-ascii?Q?Fi40XifjJmdfZfoKtr9/Jj77clo97Sn+qAB62/NgCsjGwenIcUEDE+3CWF9c?=
 =?us-ascii?Q?afiV7+liMK3hgfTPM/P8e6gVkHvowhGbk664RRIywtwbxTjI8M6pqyinPhKO?=
 =?us-ascii?Q?Ijq14mbQ/mhBrhqM4+LszMFtHNzyDXa5MXvChAbSOOIx13WzZr0TCsPCNG+A?=
 =?us-ascii?Q?dYT8GUOQaTf7DEPqBO9xy+Y9C6vsPPlWQi8BFwJFoHRfTj6lrIvAbY9Qmrhb?=
 =?us-ascii?Q?FalrsaUkS9fHk5HyWm65v7G1JFDp2A0c17qaZpKg3hgpR338HSNhdYC/mWfT?=
 =?us-ascii?Q?ccomsawawkTbdPlIkEk+rQBrzdeOxfXWdV/CW/1ur+NPX+LXvtXrcO4X8h7R?=
 =?us-ascii?Q?VZu44mwE97wNhyjvmWjUmSqGDrLI3LfWd5HBkwEZJFJdgjTT2XT0Z/FPWv3G?=
 =?us-ascii?Q?yYn1e2CJdz9W4u4L2kzILVWDaoIYzw6RE7N1b4+tGSahLtghsWoqUKf4RBZt?=
 =?us-ascii?Q?OlwYX0N8AH+G3IeT5EddxDdqm4t7FmDrjVCzKTnh5+yJtWUT/YLl9+MHCmi4?=
 =?us-ascii?Q?iK2FdCoGXXG+UsTg+SGhSCcj4jKtcbZiKSMN4Rra1e2Sgj7QiI8H4Ki4QjOH?=
 =?us-ascii?Q?sCsWjVU40og7EUdqfWqFDFU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7185EBDB0C1E0F44BE8BD5A0E5A37506@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c027e2-63df-44bf-41f1-08d9d85fac17
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2022 19:46:06.9552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6nUdOy6ZE43Sxg38y5NGeZLAlpbRdOae7/2klqs9c4QCGDdu54HyPoqs1UfhmDMVW9WEqMwkHqr1No6S+AnYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3143
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10228 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201150128
X-Proofpoint-ORIG-GUID: 6QSAwsoDUM-f-jN67q6r_cCBYq7d9RJl
X-Proofpoint-GUID: 6QSAwsoDUM-f-jN67q6r_cCBYq7d9RJl
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jan 15, 2022, at 3:14 AM, Jonathan Woithe <jwoithe@just42.net> wrote:
>=20
> Hi Chuck
>=20
> Thanks for your response.
>=20
> On Fri, Jan 14, 2022 at 03:18:01PM +0000, Chuck Lever III wrote:
>>> Recently we migrated an NFS server from a 32-bit environment running=20
>>> kernel 4.14.128 to a 64-bit 5.15.x kernel.  The NFS configuration remai=
ned
>>> unchanged between the two systems.
>>>=20
>>> On two separate occasions since the upgrade (5 Jan under 5.15.10, 14 Ja=
n
>>> under 5.15.12) the kernel has oopsed at around the time that an NFS cli=
ent
>>> machine is turned on for the day.  On both occasions the call trace was
>>> essentially identical.  The full oops sequence is at the end of this em=
ail.=20
>>> The oops was not observed when running the 4.14.128 kernel.
>>>=20
>>> Is there anything more I can provide to help track down the cause of th=
e
>>> oops?
>>=20
>> A possible culprit is 7f024fcd5c97 ("Keep read and write fds with each
>> nlm_file"), which was introduced in or around v5.15.  You could try a
>> simple test and back the server down to v5.14.y to see if the problem
>> persists.
>=20
> I could do this, but only perhaps on Monday when I'm next on site.  It ma=
y
> take a while to get an answer though, since it seems we hit the fault onl=
y
> around once every 2 weeks.  Since it's a production server we are of cour=
se
> limited in the things I can do.
>=20
> I *may* be able to set up another system as an NFS server and hit that wi=
th
> repeated mount requests.  That could help reduce the time we have to wait
> for an answer.

Given the callback information you provided, I believe that the problem
is due to a client reboot, not a mount request. The callback shows the
crash occurs while your server is processing an SM_NOTIFY request from
one of your clients.


> Is it worth considering a revert of 7f024fcd5c97?  I guess it depends on =
how
> many later patches depended on it.

You can try reverting 7f024fcd5c97, but as I recall there are some
subsequent changes that depend on that one.

--
Chuck Lever



