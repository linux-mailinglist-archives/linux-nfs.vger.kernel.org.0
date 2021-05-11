Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE38537AA79
	for <lists+linux-nfs@lfdr.de>; Tue, 11 May 2021 17:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhEKPTI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 May 2021 11:19:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38938 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbhEKPTI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 May 2021 11:19:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14BF0MKr189421;
        Tue, 11 May 2021 15:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=+X38riNy6+EFoimeHPgzYcjA628b0YJ+A8ozYfojjCY=;
 b=jdLcDTuZy+QK04ITy6zbJo6a5ffbKSSi0tjxXthyy7UWUh21jQhoccYg0cqNpN8JMZE1
 STPncb0MgQoT/i9WmROLhBJ+eTxUuVSaFRaqnHEmkrhuKOV+zosfbpUcdakc4XtBXMuV
 kA5As52P+KdI9vdcPVuiQblHonhpuMuvgv2mqBSiFevvABOSddotcTcuORkfsQN2ANPf
 PkSd78bJkA+mY/C2BB3HCjEVRdZaHSy3scaDfUYFnWRIBDfTtHbyt0aLtpbdZ5T52YBd
 JmAwnjnUg3hHVylExVP/j+e6X8H+oTVuxHZieHooUSj5z5ZNH77PZpcbq09Mk5bImR2S wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 38djkmf51f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 15:17:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14BFFsFx196580;
        Tue, 11 May 2021 15:17:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3030.oracle.com with ESMTP id 38e5pxecux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 15:17:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2O86FRsEhKsvldkmdHpswy400P7LC8GcyPrUYql9JQ9JKrK4xIViwVlvdbTUPNR7pkyeJuliWwNvKulqH5AOaP9S4LlvLD0tPx1Wx+MWZwMx9yfzUGRUHtpsmvHxqPZl+eothsNywvyHeV0Xt5hDSk0cWmlGkHi/KPUIkDKsyrTHcKPJVlLPsVrucxPExTlBqUQosZNOwqq97+JoTLK9qPVJ7RYpiJXAOcJFvQTUa2gvQMNRpcyhgFfxVkfAUQEEGe+AT4VTVKUyTKkzsS555jD1FLacLbgC4sWbLGyt6V+1S0RVYTyT3oELMKw21js8soV2A9wlPmBKHiRWi4xsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X38riNy6+EFoimeHPgzYcjA628b0YJ+A8ozYfojjCY=;
 b=FJMJzBVr16zcqV/DuU7rQeQEyl08WVHRlzQhx6/m2/N4R+9lfoXGoYbdm84F87cGDq6/N5VMcFTQawAzLieJ84lG44e3loTMB8LulOqDA+G0bdQGffl2mZneQx28uTRef5JS81isPkLhpbByYUSzbiF+G6t9OaVZJvaYvupR1rUyjmM1x3Mg7jP9VT7nUGQoA7xHsYA7hnKaAGo9J2BjAFXY5FisEKhqcOsmbnJ2ZKQAzt5EH+UnJbQpmuhlycKy4Xv7f7c5n160wiO83AkjQl8utfvrlkWLV8q3S74KDUXbrYwFnbCfomIWAxe1RCjcIXF1BRn/27v4y+oAyAgw4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X38riNy6+EFoimeHPgzYcjA628b0YJ+A8ozYfojjCY=;
 b=sQoZOp/gKYEtcBhEs+16uyEcjB/JK95P7ZxFEFS7ybmwX9k7jL8de16j6PFQSfmnDVrAsMT2qxuenK74GMxLNatKM8GD0rWETDFMAWV26iCgp24jYPTIk1oW4KZKvYlrrt2Oq7iZrkmiQ+BTR8NJ4MD8qKUeMsVT/6pr5gVK4Hk=
Received: from CO1PR10MB4673.namprd10.prod.outlook.com (2603:10b6:303:91::8)
 by MWHPR1001MB2413.namprd10.prod.outlook.com (2603:10b6:301:31::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31; Tue, 11 May
 2021 15:17:54 +0000
Received: from CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::c4bc:1a7f:322e:55f1]) by CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::c4bc:1a7f:322e:55f1%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 15:17:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        David Howells <dhowells@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: Extracting out the gss/krb5 support in sunrpc
Thread-Topic: Extracting out the gss/krb5 support in sunrpc
Thread-Index: AQHXRnSAimR4mu9fjkCcMw3l18ItSKreY+WAgAAA0YA=
Date:   Tue, 11 May 2021 15:17:54 +0000
Message-ID: <4BE0328E-4B1F-490F-BA09-7BF8592DC933@oracle.com>
References: <2581831.1620744410@warthog.procyon.org.uk>
 <e7050fe7c8952be103cc65e27f63fdb148155672.camel@hammerspace.com>
In-Reply-To: <e7050fe7c8952be103cc65e27f63fdb148155672.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2135c66-f47c-4c48-3598-08d9148ff31c
x-ms-traffictypediagnostic: MWHPR1001MB2413:
x-microsoft-antispam-prvs: <MWHPR1001MB2413BB189A3D1CC664DC5B3893539@MWHPR1001MB2413.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ozpsrmEiY/nFYAHetDY97f4n+cOKcZiHhmVKYZBCAOcw1t3bhNn8uxbMg3OrmsmWbEboWLYRVaFcBADTthWZvVHCDqNhIwLs1eW6xxqUC8eQmonu2Xtd5tZ2ZBIVQyvY9igXDrqasRSVdLhNu44VqMOM6dUfOZo1F0ugK1UB362r1OYyDR/ZDQOW64BZSPh/PQpsClXgR9BACcRdOAc8UgWz5Zi2cDqyhoNWhGiRqlEokY8ZiTEx9yPsDgJd9mEQD4UuYLXawCY97uACjBucfG+9d5yZ4z8WYxcBwXE1+cV6C9HBdDoRXyNyYaKwYqqCBOCo0h4XjXNFAhXOhoUTQyhh5hxYhQ1eKwW2DT9BnEHHHq9CwDSTuYmJ2vtv2pXaDAQGnCzib7ZQYAh7yml4Txe10uHiioUHxeZR6ZPOs4gxCQ1N4v0rLyJaDceShDDZoZ1RnEjRSb2oK9gfoh6QAuEyouF8bizjrSfs91PVn7d/XQOfHxXCQYIuZPtCPxxDzfW2Dscg30+62CRO0c7y2vvczRYrC23HS0k+8Cg1Ghhx0knGa7sct505ZxytDHmTyYg+9Yf9m91WgIGGW7CjKNh54LNC6dq3bbenonJr9SNSuqCmnX1x9FnjhBj7dpnQV6k3OTpWBM2ei2Er/VtJePMQ+oCUIqn19sqcyVHp+IY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4673.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(39860400002)(136003)(346002)(478600001)(8676002)(8936002)(6512007)(33656002)(83380400001)(86362001)(71200400001)(110136005)(6486002)(316002)(36756003)(66446008)(122000001)(5660300002)(2906002)(26005)(4744005)(66476007)(64756008)(38100700002)(6506007)(53546011)(54906003)(91956017)(66946007)(76116006)(66556008)(2616005)(4326008)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DzYM24/0WMv5tioOatFpWZl3zT3B7NnjL3YN1XIYGIidLH9uaxONp52qLq9I?=
 =?us-ascii?Q?9Q+MGSPVWuWBbTjfUH96FJ0eny8P7+ugj54IgadtP3oXl2mVBvjh7Na9g7qZ?=
 =?us-ascii?Q?Aiqkb3u19+1et8VDvqJS57VgT3P0i2aTN39eCzPdjxUKLn63oV2fmKmBAi/4?=
 =?us-ascii?Q?jT3/wJSdd7FIHsFz/RGcUCwLir/SzyMWBaR58N/aT+rYHxl1U5u0ggX9RORT?=
 =?us-ascii?Q?h7BAM3L9YMdJC8yvOakdrqLVsSOAimwHdQQGcT1CmNqbjhaM4YwaDz9kYQSt?=
 =?us-ascii?Q?5RFMEprEMl6at6rEorXyu2xn5yzn1UXLA1kgJ4sGCONp+2iHYUq3vU1/5C0e?=
 =?us-ascii?Q?9SJ/n1aP9Q5W74P45ga/Dt+j8FWd7zElT1adNW8d+hRZQI3X2kT0ogatvbDb?=
 =?us-ascii?Q?gbH2HVypg/2wdoPCJUMRa2kO3oIECXBsnJFx1kEuEP8WBeihhYOkhlEEaCaZ?=
 =?us-ascii?Q?n09kEwscsnAKhpbc/RXkTRsL6Ak1vrza0QZ4zpi+ZIn9PVsF0NCmDm6VFrtn?=
 =?us-ascii?Q?zHRDtZt5KD2bvzpCbYBGmG8oCoLRvMvAq4MuplWKW4KC5EmIc9mYcEFBME+W?=
 =?us-ascii?Q?UH8tFEjvSyVz4kKRmV/FpM9rJ+kfZllt9ISqbovxHlx0tlsEESs+X4WsMTXj?=
 =?us-ascii?Q?l65K6/jr9yCx61qR0+XNb9k8I9ktOA46gYJ0QKOqxRntFjhBnD6BU77uM434?=
 =?us-ascii?Q?uZZUPv15tO5FQT5SxKQXS7v4TQMtTaTBXJhbzscVDTEdG/Piu3eqbB4/rRgg?=
 =?us-ascii?Q?dZ3lKN3wYJlWc937GDMXcrdAUHP5gbArJ/o7y+Y/ZRMxRm+Ch9C3Z0IDTdvo?=
 =?us-ascii?Q?NbTrytOCO9+ENESbBeP4PhNwlabKAXR9bD4yAto2B4iiniazMOE9of8mwUaN?=
 =?us-ascii?Q?A+h0aH1JDv6swmwzRfE+Q/VPcUbsTjLcGEp5gzOVE5DH4XB2aSAJsA9BLLpo?=
 =?us-ascii?Q?FSYrnWAHFE01K5qYhIy/7dd2p06IAsx6ON4VJcAeuKftzfMW2JD65esbaS8B?=
 =?us-ascii?Q?j0fj+FzpiswAIa5tRitNy3WlbzCUG09xK6Mh27A595vCHzE6gvi4rokPpxaI?=
 =?us-ascii?Q?iuAwtnPrM3y+9wBF2vXYAUShDMkPubJRr3qj7nWeNejROmmg20OXcnF8cfMa?=
 =?us-ascii?Q?r92Z0XZ8/gvfwHhKwag75pv4Ro0muyeJGXCgZxfl3SZuEk2ijzvV3mn3IP6b?=
 =?us-ascii?Q?S1EC4HLu3KB9uByP4KxfEH+HaEWM7RU0f+GFvvIGb6KZJeXxURTfzbwVfUTD?=
 =?us-ascii?Q?knsXrU+y5vfWMnPvmtwmcxeibtPliyQHnY7PZStKmKZGqNmqXzan2nJMInrp?=
 =?us-ascii?Q?Qp7up6ckPT16LB/77aXYB4T9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22FD66E9C10BE441B7AEB2291B2B3B2A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4673.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2135c66-f47c-4c48-3598-08d9148ff31c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 15:17:54.0569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Up2tADdIE+EuE3TORyRXpPYxXiJFdG+8+gEam1loStCiGLCtmFJmzUN/6ea2tpV3qbS+W1ZAuhW1oZyG6BlFcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2413
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9981 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110112
X-Proofpoint-GUID: TdFub6wqaOWse9aGXfVqA2JlVIx_XhBB
X-Proofpoint-ORIG-GUID: TdFub6wqaOWse9aGXfVqA2JlVIx_XhBB
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9981 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1011 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110111
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 11, 2021, at 11:14 AM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>=20
> On Tue, 2021-05-11 at 15:46 +0100, David Howells wrote:
>> Hi Trond,
>>=20
>> I'm looking at extracting out the gssapi/krb5 support from the sunrpc
>> package
>> in the kernel into a common library under crypto/ so that afs (and
>> anyone else
>> - cifs, maybe) can use it too.  Are you willing to entertain that
>> idea - or is
>> that a definite no for you?
>>=20
>> David
>>=20
>=20
> Moving the code out of net/sunrpc into a shared directory would be fine
> with me.
> Note, though, that what's there is a rather old port of the MIT
> kerberos library that was done by CITI around 2001/2002 (IIRC), so it
> might be due for an update at some point.

Would be nice to allocate legitimate SPDX tags for those old licenses
if that code isn't going to be replaced.

--
Chuck Lever



