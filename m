Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758AF328AD2
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 19:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbhCASXj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 13:23:39 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59974 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbhCASWM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Mar 2021 13:22:12 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 121IF3M7080172;
        Mon, 1 Mar 2021 18:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3l4HoR2nIFptKCbEax1roxEg2HbxtJ2DE43RZ3UC58M=;
 b=Y4MJtRKffq2i9lGh4rdDzMlFf0sGm1CHz1WW2FYkuR+Du0PpIbHnZC5zRxp3xCyprQFx
 0YWHBCAqSColH3S2f98whYx5MwHwnLVfT6qfBkx0isS/o3bwS//IswvsFWawYGohjuXp
 u+6eyNqzWt1XzxRl+54ZNNnnJh/l7cdnZmGfphKUuU/n8fRw0wPQtGoRFP85oYTLHCjz
 ium7JZRnwr+7krgOp/As9BEhdm+MNyJnWNkC7hDyFdHcJahXb5nAPpy3ND2erzMVcfwM
 PLP6ExKUFcUsWJHMpuLa74Dxd9kinYhBze+Jf/ayCJ2ulZXqM0NGKHVfVemXfl/PfvnE 2A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36ybkb50f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Mar 2021 18:21:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 121IEUR9138250;
        Mon, 1 Mar 2021 18:21:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by userp3020.oracle.com with ESMTP id 36yyuqwvbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Mar 2021 18:21:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZucC/yD5UqpNkeEaP+b0eD4hoIDu/S7LTADm8blCsH4UlzmncA5rhSTSibpKVYQhoGWKJCsyRqWMb93aCkrSxg5tMU771MYeIwRdxzZSW+btCkwfy7nznPVxBUrE0Ex6s1U7ja3XQ9kr2az1qsTGN1l6LnlSTiMH9siqWoiQ4BpwCG1huWNeJSAhBZUtZZ6m6fCXxkuJn0SobpotpeYKiplfSoSYEfrGzIr7tvwnNSIBp64SVGpIiVtqvY7fue5HseaUX8x36cdFP/OaCDvrW0EWtZuov1JIcignhSUpA0XLeoAhPkQoHt6dNa73TwivTtZH7mpZ9F7ddT9TkbmLJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l4HoR2nIFptKCbEax1roxEg2HbxtJ2DE43RZ3UC58M=;
 b=UwHjmli4jjVRECgRdDoX3kHwOFnaZC0TPHknsJI6l0tl+k14m8eRHHzWjROhIOjjaMO2yKkLGBHA2Yu7/l9ZOaCP1LX0Eg+WOKT/V0Xq6lTdDOtn2M7KHXnwMv1R919ZwhKNDc5RQ3Po1HeDLMDay7for/AYBAGkHgT7xHLJrd1l99BdJVzq5RcZ+dlt3dtxf5ZX/iRkZcQH7JthT2DLmAsp02CmBREgiAvWTW+oJZkA8BVdSBPy0ENEIu1JlWrrP3+TnjeYVuQOp8xVlodb8QcTOOvA9XdA6SPDoBipD/ixcSCZX6Dt95C5ll7Za+zf8vzI/UbtEUZ4EiRM26DVLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l4HoR2nIFptKCbEax1roxEg2HbxtJ2DE43RZ3UC58M=;
 b=FrwL1JhxXsAS6UMjfQYr56IWx5gsbNOGppQml1e2CBxInTzokx7RyV/K+JAdQ40EMoKoYNVFyHYZ3ETEAb3McLS46XMUD+Hlj5YrchH6nYxmFKN3o+mh6CtM7oJPX+GL37ML2RdeAsJwQFZZKE3td9yk0NXIo21sQaztyu0tdOE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4161.namprd10.prod.outlook.com (2603:10b6:a03:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 18:21:27 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 18:21:27 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Daniel Kobras <kobras@puzzle-itc.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: fix refcount leak for rpc auth modules
Thread-Topic: [PATCH] sunrpc: fix refcount leak for rpc auth modules
Thread-Index: AQHXDJPLGG4N2gFkYEKpGIw1cGBThqpvQ6UAgAAS+wCAABUlgIAACKqAgAABzIA=
Date:   Mon, 1 Mar 2021 18:21:27 +0000
Message-ID: <3A372E86-B7E4-495C-83F5-6B092E708AC8@oracle.com>
References: <20210226230437.jfgagcq5magzlrtv@tuedko18.puzzle-itc.de>
 <C2704113-2581-4B58-806B-BB65148AC14B@oracle.com>
 <20210301162820.GB11772@fieldses.org>
 <F2DE890D-C2D7-476A-AF6F-949B105728E9@oracle.com>
 <20210301181501.GC11772@fieldses.org>
In-Reply-To: <20210301181501.GC11772@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b759388-2f38-42f6-b486-08d8dcded46b
x-ms-traffictypediagnostic: BY5PR10MB4161:
x-microsoft-antispam-prvs: <BY5PR10MB416124693C593FD47089B7F4939A9@BY5PR10MB4161.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xbpg1WfTMLmL6IAhaBm5kP0Rew+ovJwpsBma22dm5nyli+7ZxSrtNcxAoxsrLYqodL9D/R0icbHBAtlL9woeRz4CRw41Q2n4tZJ9Cxx2vbcbVmmwTwYxTOiD5ejZdA+OmcPdG7kcN8DINvNxosFQotHJajfyGJSeSmNKwsp5xE+Imbml2Rd2+SF6G2XSshBxYjk8LiZC0nEqHvm5nI41U/xeZbwvDjy0NIW2hw2oJgIGLyw8IXsUSJuLGEl3syfQzI24G/o6zyV2xRewMwORbO/gjL0/uBnNvl/1fnPFJBlDZrsPvgmvlaZofu4lSW/4Z7CIqTcMqHqRYedW2+uWp+4+xAsvQZz9AjE41u8MQguS2EGGEwBSaZPgFGuAYNFIFjmDuFTO8za34peUoDjb1YSz3ATtXLgpVVMWaZnYpgsmheOJi++TFOvIZ3h4/Ltkkd+XAui4UzqQyUIZQalteoQkOuQfpLqW0QzLBDWKTgyJV0xTV/9rU8OQ2p2WejnK5/rRjSPxWxN6mNGg5aaKVwwrI9VVUs2goxGUXVxKEwGy2q/sHQ45qoO2HsxebZM/R4zK8UZzYshWMkzL1tdyIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(136003)(376002)(346002)(86362001)(6916009)(5660300002)(2616005)(44832011)(33656002)(66946007)(6506007)(54906003)(64756008)(66556008)(71200400001)(6512007)(76116006)(36756003)(83380400001)(478600001)(186003)(8936002)(91956017)(6486002)(316002)(2906002)(53546011)(4326008)(66476007)(66446008)(8676002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RqbMeOeHfzCrOEY1skTVNDO95P0nlLU/f2sZV19N24NLg7wqS9R3Iyx2C3q8?=
 =?us-ascii?Q?a1BZfGK2t29swpUuHQ7XCjBvKuq/9tOXvl4+w1Ow1p12IDqZZSjMR9NaV9a1?=
 =?us-ascii?Q?Nnkuefy8rgLE4XpUtdIV1PO4RRXDWYvcNQ08iKSWLv3jMgKmVl5KlC219d7S?=
 =?us-ascii?Q?8+jxupNtNCyOx0CNmvF9yHgvO43IR8rzqpGjSyaClWOLAr03LZuBBn+z+A9V?=
 =?us-ascii?Q?p784oK10X5i/y4yu3tQMhj+CEvt4zd/Xm0nxwAI876ieDZgJjpfeE1rP2yxx?=
 =?us-ascii?Q?lKr6FuzKL3pakelAMdaOB85J/lSE8vWIsVh/rTWvDu1V3bwnfqpzAzkNgby0?=
 =?us-ascii?Q?Oovf6QCb30j7Kb6zP7wlgLlmM/Tgq3jqtZzEYt8jESOnrYq97c2BtWzzIF3N?=
 =?us-ascii?Q?bT+2yCo8H0JNvQI8H15kwxCJCYy3yfKrNLaXln7q4FrV2fPyOm4SaeZMmIdu?=
 =?us-ascii?Q?PPMKOwZ8G7nDfuzihav8dGCLSHqt5WNwWggJrVjT27qB0KtROfAaFYtGeFnu?=
 =?us-ascii?Q?PlMHuaIaUD71inDmA7/nRfCTxjNXQTgGlm+KmMLpKBgqojRnL2UKghcM6Qah?=
 =?us-ascii?Q?QOedwnWUPLzVzQC3Uvr6IdgHtJmPZ/5mjVTrLiBaOj/FoSevpLO3BZVwWx/0?=
 =?us-ascii?Q?bv+HOPSHa/q+ow6GPAbHzmir4+9uGQgWf0qJIYOwASAXeWGe2SHmua587H9x?=
 =?us-ascii?Q?HnLZdbZckCBXYkZ0Rf7XOefeB6YlESJ9zYirPlVcoD0N9aOp/0G/wpjrbwmK?=
 =?us-ascii?Q?bOWdhEjAuSpesmzo46xWRueGlgyRfmIfIMzE6Mr3s4jvJS7oc49nR4VdhPND?=
 =?us-ascii?Q?MwsC5RoD0RCCefmjlrDPqpo3Ntyp0/tICkEl36cYiBOKLe3gmpYtDOi1VSvM?=
 =?us-ascii?Q?Rkz7YS70wHl1QiNIMjJVf+U3Iw1hZxZySnxvXsIPGxcF2Db6LkCdVha2m7CG?=
 =?us-ascii?Q?0gI5kWorNw3Aft27Y2HRHoiOSh7myuLXguKIGct2fdUjxlaGfLt99aFT+P15?=
 =?us-ascii?Q?4PT2r3kKAud1WXdoHS37YfKLMPLZWyfMz+J1IGLoK7U30FR6mnZB/vZeSoi6?=
 =?us-ascii?Q?GgIxqmJKG5HNvxn1ohmz3+135fudGbMpnTKgAqAhpYk/z9KnhjfbYXmWgMzC?=
 =?us-ascii?Q?fNkbhXYXMXqDTyBzwzxS8Iu9HzRGdzdGKAHqAaMLEh8blMZCsOnqR7SdgX2z?=
 =?us-ascii?Q?Uc7NrDfYTftebSLWID5RzfAsaaRhWVc8EUKBM6F8s8F9kS39rhkoLOj3qlCP?=
 =?us-ascii?Q?IEBto2+8M4BwrcFtEUOlTxzESvOuEZxfN2mcObc5kvyZYtLUenWUgsiAuamj?=
 =?us-ascii?Q?iFyWvM+ykV4DOkgT14rbuKDF?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D607D932A2EF0A4EB2F72FFCA079EF7E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b759388-2f38-42f6-b486-08d8dcded46b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 18:21:27.6449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fa1GT26muqMU7FXZFMPpg/kknEtv7RGQaKWDykj4C4foT+hXIR/ErLstNeELWdsF3S60eGEiPc9WDzCH6xfwwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4161
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103010147
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010147
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 1, 2021, at 1:15 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Mon, Mar 01, 2021 at 05:44:02PM +0000, Chuck Lever wrote:
>>> So, the effect of this is to call svc_authorise more often.  I think
>>> that's always safe, because svc_authorise is a no-op unless rq_authops
>>> is set, it clears rq_authops itself, and rq_authops being set is a
>>> guarantee that ->accept() already ran.
>>>=20
>>> It's harder to know if this solves the problem, as I see a lot of other
>>> mentions of THIS_MODULE in svcauth_gss.c.
>>=20
>> Perhaps a deeper audit is necessary.
>>=20
>> A small code change to inject SVC_CLOSE returns at random would enable
>> a more dynamic analysis.
>=20
> That might be interesting.
>=20
> I don't think this patch necessarily has to wait for that.

OK. It's in for-rc now, and sounds like that doesn't need to change.

Poking around a little, I see a try_module_get() and module_put() done
for every RPC. Considering that both have a preempt_disable/enable pair,
that seems a little expensive for the value it provides. One might like
to see the module reference count handled a little less frequently, but
I don't see an obvious way to address that.


>>> Possibly orthogonal to this problem, but: svcauth_gss_release
>>> unconditionally dereferences rqstp->rq_auth_data.  Isn't that a NULL
>>> dereference if the kmalloc at the start of svcauth_gss_accept() fails?
>>>=20
>>> Finally, should we care about module reference leaks?
>>=20
>> I would prefer that module reference counting work as expected. When it
>> doesn't that tends to lead to people (say, me) hunting for bugs that
>> might actually be serious.
>>=20
>>=20
>>> Does anyone really *need* to unload modules?
>>=20
>> Anyone who wants to replace the module with a newer build that fixes a
>> bug. It avoids a full reboot, and for some that's important.
>=20
> Fair enough.
>=20
> --b.

--
Chuck Lever



