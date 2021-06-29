Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008223B78BC
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 21:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbhF2Tgs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 15:36:48 -0400
Received: from mail-co1nam11on2133.outbound.protection.outlook.com ([40.107.220.133]:55712
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232197AbhF2Tgo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 29 Jun 2021 15:36:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bgho/t2ntl5Uxqf9fYeTe7uPlIFkMECghVY+fm71KYFYlPcadoteHz0ctqk6sYaoVVWbA85wjG3JeuSth0sfjp3DmlrRRTNQ8+DQEyWahFJK2UYnIhfJjR7v1CMqVKir1IshsAn+jYJ0KfzRu9kLh9qNgrHOunkanVCliYTcI5D7QkoLjAWbwvrHBOWImCepf5Npeo229Yx29MzgbSdGolPYWQ/tsrwKtkmd/jCsrrZG9xRLCmbFrjsytC4VLdCeWL6e/nIIPeG4DWqfLoqPTkywOsj29SMvC8K0qMendYjIJdD/Uo6v25AF0x1KOfbiIZ0hQwb3KJSqugSO+PEsvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtFk54BTrB9yyk3DFXKsS6e1ibTb0q/Gt0VbfUrFxkM=;
 b=c9RKgCA4Wn/NFgItnt7v1IG6QKMYIZGhmgB7SBcqvsJNSASlB0nNX75CiN/7u3IauIaBqw3bUkJGaEy61Wetz8HhuCl+cehW02juQAWM33phl8JUhiLAPxl3JNL0Cv5NnR/IUuRoiuETDF/2693or/ARBGSdPP+/1wcmP7Obp8LiU53ujRkyPc35Or7IQVbP9bq5GLYcSqBOIBBr6jaj6llsvpr9a4Ufd9NkufOHTJw3KU6NQkMFdwMWToaqKndxnEYmoEq95wA/NtVRAf5ZW7q1omGilchQLSpq6NQQwfGByaqVJ6TRSlsznzwHcAT+VRT44R0nPOSk5N5FBinSmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtFk54BTrB9yyk3DFXKsS6e1ibTb0q/Gt0VbfUrFxkM=;
 b=fn/rjJBM4QmYW7TBMd9SuFVKgq255Sg3M0cApo8ulljJ3bQAW0ozvKZteDh/zUdpCNjg3iBBJd1DJ8zarf7JsQRI4GaNXp8RgzKv+Hok6D8RsQKwLUM0sTbIqHtlL1McHGXVVo2ikFZkCSN3Sr3DkQyWF+ejgieuffHu8wy+mUEyKsw68UbEngWjnDEazuHMPBhzUVP2zTPeuHw00eD3H7/xGxAHdu4PtkkqdmIXD+LDGMgn5FLyfLB6A5GfDZVubYsCY1nnzP9QP7Q3NTCGWFe5slnC4UvGEBkgZSkHQ86rTc8gG9rMtN+ppxqXgM05TvQwGkl/VlfnshtWfQZEzw==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH0PR01MB6955.prod.exchangelabs.com (2603:10b6:610:108::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18; Tue, 29 Jun 2021 19:34:14 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::81f3:3a8:e00f:92ec]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::81f3:3a8:e00f:92ec%9]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 19:34:14 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Hillman, Richie" <Richie.Hillman@cornelisnetworks.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: RE: NFS trace new to 5.13.0 (GA)
Thread-Topic: NFS trace new to 5.13.0 (GA)
Thread-Index: AddtE3KnceyIXtJFQ4q1p77amM2J2QAAn1oAAAHqJXA=
Date:   Tue, 29 Jun 2021 19:34:14 +0000
Message-ID: <CH0PR01MB7153CDA5ADFA9306044DEF80F2029@CH0PR01MB7153.prod.exchangelabs.com>
References: <CH0PR01MB71539295AEF1947518073D0FF2029@CH0PR01MB7153.prod.exchangelabs.com>
 <A9DA4F5A-9BA8-4395-82CF-24C071AF1F8C@oracle.com>
In-Reply-To: <A9DA4F5A-9BA8-4395-82CF-24C071AF1F8C@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-originating-ip: [70.15.25.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9dca224-9164-45dc-393f-08d93b34e0ad
x-ms-traffictypediagnostic: CH0PR01MB6955:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR01MB69557D55F338C93001E2D3EEF2029@CH0PR01MB6955.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:565;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XvBZTQ0PSuzAyxibiguMRRVig+rE8kV37F/+hMaSoS/4aNwokJfD/Mn2vB5DHcSNKFSHNW8GJPZxutVHYKcOz3h0/YvehM+akqZTtf03K5tGycYJoRrcPewdQT2VquPjeTW8AzPzUI1GVdGBnrAShVPGfCo6yDgzBfUVXt+45vb5n7jKFsmUFtBrNG0LJkQw3Ka/h9GE8S7eP0C2yZbY2ZgicU0tV3CoJbczX++Q4k+0olWN+W/5yuES8rLPl3X7ifOfI2eI1axULEOMpAh9ctITCR7EoXLQfZwtQt7npF1x878hRwNp/zRhCWezXG6K3fwroLBWyOOutFBt0ddLu7zBcbXgYA3YYh8qEV/eIOmAoIsJC+S6b4WUGP4eCxGs0dxuKvIPlImYmc0PSAhtXuZAdQ7MoUaGOWwbDyUEfZTddjYNL6BGJowRtQD/E6zgHyuCG1CM5aDuor91PKNjT4jy5uJ/TNH9LbFkF2XHQuWJ5W0sGTAfBfuPX2brQJlJfdbBmiNOD/uOQ6OuDLOsZWRJCR3jlZNZk1bLFX41Hxpa/aBNuh4qhf3jfVCB+L7ClWT6KzV1gjMnCVSYGnk6FGEIgEMmwnwzrnDrii94oBfCf/RbLW2E40+DZ5gmEXC099Tmapu4Mm7yWLKNQ0YO3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39840400004)(376002)(396003)(366004)(5660300002)(55016002)(76116006)(9686003)(8676002)(66946007)(7696005)(478600001)(66476007)(2906002)(8936002)(66556008)(64756008)(54906003)(4326008)(66446008)(33656002)(26005)(186003)(6916009)(6506007)(52536014)(122000001)(71200400001)(4744005)(86362001)(316002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/Pq6NfHx6SjK8dLr5mck60ZT/YvIltdG76D4rxWTBqHXNbK8O1fuiVhAdPim?=
 =?us-ascii?Q?+bu7anCUw7NCSVXOAS+Qsa1Qs7yj6XuCD/2WvVdQ7omoL6eIfC55Cnn39/FA?=
 =?us-ascii?Q?+FD/qnfHzMvdKMcz+Qv6jW08UwcE4TIeGbWwqo8/8SNYfAba394j+hqcw9VL?=
 =?us-ascii?Q?El4w5Qt2lufxKMCpocd3IgOsnruLf33y5X1OX35qKCP/1zXGbslRfxt7PqgD?=
 =?us-ascii?Q?DDp6EqcXAelJrdtlyo4cDIn+o7W+Zb8GN81g8tltLsRxbwlggtN+tuhuNt/W?=
 =?us-ascii?Q?X9tRh5/2dks181NolEwRl9bgHGkVyNnsQU9ZlIRuCkj3Dcrsrw+e6vYeOAxL?=
 =?us-ascii?Q?zU2XxPvmHjmg/7tIx+NPuP+Eryq39WoiEgfnhzrSAVcmXfup1ohdyW4aIE81?=
 =?us-ascii?Q?3kdyYYO/ZdYzc57rRbwhbttSLuv5xup6dvD13NbZlhPBSaPbxbc4ISGO2bv9?=
 =?us-ascii?Q?bcE+Ja3FVMtINXbt3qVKx5Z9U/Ie8gbq+yJmk0ZAn+gNA9B/uJe90lIF/Fvr?=
 =?us-ascii?Q?R94nSXL1orsYei+UrSeQ8G+QCk3koq2TaqVdkgBd0zylFrB7MTntnQf5/+Ej?=
 =?us-ascii?Q?o4GbbZ4pnzqY23eHb5gP0l1/ND27UwaB1xEZ73ZQNhEeHsW7pD/Vn5AM6uCB?=
 =?us-ascii?Q?SwHg1E0UOwRboGjM7uqSlUfggTFAKDIcfWp1YvZtPU7ZOlza6gKLMh1B1t6r?=
 =?us-ascii?Q?YiYDuuRkHeIIBBXZPwswtNELFtsKp2EePVWjgG5fr85lvEKhBglKfvuKChQl?=
 =?us-ascii?Q?rZst37F5zPdvX7TwIlv3iqSXtVl+i1UoSBzy0BMDpwiMuVlIov5okHrvAkkW?=
 =?us-ascii?Q?nCW3bLZVHNCXmHCNzTCNsg0IFTWkqphXuOSYVaSlzNbRumeLDuw2Kgo9O7lA?=
 =?us-ascii?Q?ThTDr+XVl06iohAab8CYU7Rja0LcbtghYUDkBXQcxvwpLp/iMv8jyFh8iy2x?=
 =?us-ascii?Q?T+4xLx9AV0XZgxHGsy7hLXkR/11JZvF2beAJ0T+5G/jushkvJ3Jeqco0I9oo?=
 =?us-ascii?Q?+PYcW4b38UyF5k7QO/U5Xap9ATBP5r+mfR09bOrUOtMDys+SLHbSxg2mAtcV?=
 =?us-ascii?Q?1Gu+C4DLeSH9KTjRpozzcVHdfp8nBd1KTP0McSzzqTOm4k1uIOKJnEJkVTGC?=
 =?us-ascii?Q?dIBSsSFYSW2xYMMF5ZV6O5Gf9ohA2wJ625YwKyxSCMJlrZDbaj0gPhd+XQU6?=
 =?us-ascii?Q?dtoQproH0qQXKSwu79iPkoN24N7XchyNrNng3No4KYh5GTg163G9Cc0d8GJg?=
 =?us-ascii?Q?6GOrRUXfv9IknuFfdRnsBqz03jYQT7MjQ93Lj1BNfH22+5C/V2nbRsfz7Iwr?=
 =?us-ascii?Q?Ci8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dca224-9164-45dc-393f-08d93b34e0ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 19:34:14.2028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LgkXpynAFRZbL5kbHjyZPD+yGmT1XHcDUR5H/ENFj6n28/6qiBJQbbXHgxL/ik2x1yAW+WdKwuW00u//d886419aaFQQtyTPev1w7+KweGtOm3OvNhfOGwnAKYai9WU5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6955
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> The NFS server in v5.13 is afflicted by a late-breaking bug-fix to the
> alloc_pages_bulk_array() API. It's been fixed in Linus'
> tree, but that tree is otherwise unstable for me.
>
> Have a look at commit 66d9282523b for a one-liner fix, it should apply cl=
eanly
> to v5.13.
>

Thanks.  I'm testing with 5.13 + that fix right now.   Will know in the AM.

Mike
External recipient
