Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0873C7A06D6
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Sep 2023 16:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbjINOF3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Sep 2023 10:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjINOF2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Sep 2023 10:05:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C29DF;
        Thu, 14 Sep 2023 07:05:24 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E8mxYD015442;
        Thu, 14 Sep 2023 14:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=giTc/GRTU6miAlAmMsOIbO9zGkB+hDWdNFKnASGOH6M=;
 b=FEIsiT1l8PAZkHo06enKFe3LDOkJLnk/4JMR/RS3TzoQdQXIGb8ovUZ4WOPDkRTdeTpW
 pNDlR2mOGOUSYl2L4irrSne5Nq+um3Guw1Lucwz4SKIBauh9zozwZCFb7NEP4UYuxHPD
 VH+mkgwwxpGRsaveB3sJQuPaod9b6hGbGbNK+Vdd0W9aiNwmwYT3SOuZmyFt5P4A22JP
 /KSa3GAkqCpbi9kUTAePSnRNoadqseaZFGaLcp7OuXc2xxWNkE+tOYm4oq5M78RvhkXI
 dDT4xgGPGpuxQYl1nUs/LnoXggFvXiaelVZBVHmKYvhxysRYh7oGM6uE4nr0JZ+Jecw+ Jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7kdhny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 14:05:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38EDVAwS007400;
        Thu, 14 Sep 2023 14:05:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f59g53n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 14:05:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaMaE1PGhEmXdxa8ZlnH2NiRnK9B6Ynosnggf5QIEkffg2770k4JhELDOf+P3aVi19DwNvtkkqvbrMUQWc7iXjbULIQ1UNpAPeTiP6NH/U+qtB4+mlOsffc7srY2ImvwEqdjL9Y2igOaY0FAWBrSwrHdH5a2ZT9UUtjBKG2dvTW3aTKA4kemHsp74+sWhfR+qkzDO5fXMw5WAnR7KTLPp2z6Sfz46LfxBPFO7YFjZYjxFGv4iRRtkUj9nkZ9EBrK+rMgcFEglAY4RjeSnTB4lj0Twrn1Y4eGcqzcOtPnSTtc94Eb6A6+HE8iRZeqohQOTWbLxpyGJ5LMMHRZzeht/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giTc/GRTU6miAlAmMsOIbO9zGkB+hDWdNFKnASGOH6M=;
 b=adfuTcyVeCoHRm6q0V5BEj3pUGfRYr5XfgW45SiMGGH32gXchwfZ/Y/TUa4Kbq0sAetpnm/t1wxfATeBsgQNI3/Moh+1LPGZCcCoAjDSjIfEjgKekjWT9eQirnyf3LE5UlwMS8NrQlFLsAWaOsXCVbih5v57TbbYATxQc7vCuRq7BVnbGlw8JJhxgUEoyG7LIAw3sHJBtjlPUE4eQi4S5wfZ8vr+kvkcI2mbY7p19RLdLQnDMkC830IP/YmqrIQyPDKEmJoWxD+QUXXOdKtjNiSLn8AvVU+zpeV6OfrmTJU4C0zMXUVa3C3C4zdYQiDlhB5oYchmznMji3YOJXSgTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giTc/GRTU6miAlAmMsOIbO9zGkB+hDWdNFKnASGOH6M=;
 b=Je+BO2MKk7aVreMHr5X+CdvbU5fjqQR9riy7WZ3SxBp3OnENt0nF3LersZvRmWWadnRnqwBnpZvXvbMG9V8kqfvgocuc7iBGw2nRSO2+YbEy0PJua7lm+IK6YeqffHtZljmAFjp7Vo/iVhCHTyABW5/ZO4MchHDlJRwJim/Ohuo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5700.namprd10.prod.outlook.com (2603:10b6:510:125::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 14 Sep
 2023 14:05:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 14:05:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 11/17] lib: add light-weight queuing mechanism.
Thread-Topic: [PATCH v1 11/17] lib: add light-weight queuing mechanism.
Thread-Index: AQHZ5L3S7eczMxv7N0KGYdSIc28+v7AV7d2AgAAmQoCAAAmMgIAAJdCAgAAkcYCAA/d3AA==
Date:   Thu, 14 Sep 2023 14:05:04 +0000
Message-ID: <DB109932-C918-4F1E-BAF2-92D921238D54@oracle.com>
References: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>
 <169444318342.4327.18355944158180782708.stgit@bazille.1015granger.net>
 <20230911111333.4d1a872330e924a00acb905b@linux-foundation.org>
 <4D5C2693-40E9-467D-9F2F-59D92CBE9D3B@oracle.com>
 <20230911140439.b273bf9e120881f038da0de7@linux-foundation.org>
 <169447439989.19905.9386812394578844629@noble.neil.brown.name>
 <20230911183025.5f808a70a62df79a3a1e349e@linux-foundation.org>
In-Reply-To: <20230911183025.5f808a70a62df79a3a1e349e@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB5700:EE_
x-ms-office365-filtering-correlation-id: ed9edd74-ca05-4b97-dff7-08dbb52b9882
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xfAik2smIH/6GQMF619G4tkj+TA4QDYUiJZGD/U+waM2wZfCiZOBZT3SPBgMjpktBpPmGHenABcTKok1Zzgoz/Re8oaPTOX0vWQZ4yvqlkJi+JqnLXwxXj/xzSu3aiOdZKhfraRwJnmMLRgbkJH4ikzuOOc3HVDsbjea5SizDtYBEvEJfsqFB/gcv4uIeDHaTlJgj4UJPGIkEVQ/JSOng649u820sVkZVlzEmx4UjDyKuctlHcFekxn4TahpRMIswqmacKiSjk4NjCwauNXfmAOpTzxAq9YlJAp0s0ETODjHC5ByKU7oZsZ3zhmU5FmYIwzPFEF+oFdCMBdfBCaid+URk5jq/GBD0JJoz7N+HZ71sWjzBcgkwg5Wp3fScx00qatD+7gBg14+7cu3u6CKovm80InDj3ynDkE+Qt71hSjyvTX3IuE+0sJmUS3xIEIiOJNrEVRZsUJkXMnn0u+dRHmV8pBsFh00BqrDhxddqX/Wm7PLu/NdlCvvw1O169UYUO96x53BCrttTEzR+fvXBlje4zTxKCskCIr5j2dEObLSGXJ3yS4FFe8cf5tP6fjO1J61T9m4ueNEwAwqT0BLY6Xe4QjM/t7tuTOZrhAT+W+Be5HH67Fh6GnYLbBpKPkSL2QU8/6cRj9i0b8tSIfQx0m2vVoZP9x3P1oa28kGSY7rb9Oyaul33etlj85v3y6f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(1800799009)(186009)(451199024)(71200400001)(478600001)(122000001)(4326008)(8936002)(38100700002)(38070700005)(86362001)(26005)(5660300002)(8676002)(66556008)(66446008)(64756008)(54906003)(66946007)(66476007)(316002)(76116006)(83380400001)(91956017)(6916009)(41300700001)(6486002)(6512007)(53546011)(2616005)(6506007)(33656002)(36756003)(2906002)(16393002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H1Ocppe9csK2g4fzj2pL3KA2w9me7uvszeiGUKiaCfo8UgtwdnPZSR0Cd+i4?=
 =?us-ascii?Q?B+pp7FBvhp8xWoib0r5nlqcnVW+NBNPIi5mI8kCmlsZVG37KUz71H4i6eU3N?=
 =?us-ascii?Q?9VxPPPPJNW2JIA/EZSZRaWoBkS82e9YzQWnGO6Nck0rB5UC5bfYN5z2ekJlk?=
 =?us-ascii?Q?t+JUtud/vgQ7s/RdI7koyjInnPbOIwYFkaPO5O03Msa/v1hFeeCU0juU/Mx6?=
 =?us-ascii?Q?WHann8S+6tXZSCZBdqS0lG9b/Y2ZsdgS7skCTUlLUIkajJaGsXzjpqQv3qD3?=
 =?us-ascii?Q?dZpVHlbYb3B7qT0x790hOwdz7XZPl2f/wDqdRm7JjYTKQp4lL/bi0nEZfEZo?=
 =?us-ascii?Q?sVM0JA/HSgRs3MLhkMiHc3T0QcJRPTNV4e57ryk++BeLsM/GVHpkMQw2Y8DM?=
 =?us-ascii?Q?yGmN4tWgyiQ6HQLnhtNG/ttQX/0SZ0Mg4PxW9fDqgtI9pBrFVMT63CmHwHLo?=
 =?us-ascii?Q?kn1ql0o3EpndArtaEu8vgl1BubSh//1HTqd8PkD2dtoR/LicpXkwfpADb7pK?=
 =?us-ascii?Q?9QpZxdg5m/mdsW21NdsidPpSy1HK1PvW1Gm0aYvT33WYBUOHCnu4AOTKxkW/?=
 =?us-ascii?Q?+xH/Lrti9vpiF8q+tI4JwZJdtkxgAa29yvbrMf7OkYIDWYeJO0GtD31i1Drb?=
 =?us-ascii?Q?Qn9MLCa1E6wMHPbg6T5btl8maWWFXbFQfdavUA0PgJakDxn0NeWrJwwooSbE?=
 =?us-ascii?Q?belxaxXGQu+tlnAhLG98Qh2EUK9PI/NMsnokgp7RcCR4Q7heTF5V4b4HgSZa?=
 =?us-ascii?Q?pBKy31N418xl8yuga7hrZM8kvIdLmki4ZD/8RNzbaTYGYz/9e07MNJlil9kq?=
 =?us-ascii?Q?eucLd9ZyddlgaIuW9niVoIE9MVFBZbg/o7pE+ebH/WNJPWe6XInyrDQeGIdE?=
 =?us-ascii?Q?/rFjdU5aZBQhvTYIV1uMDwC7Rhr5ReP21fixErGOhUmvSxK73t6j9suklog+?=
 =?us-ascii?Q?jS0dlyYvdgvBC5Rdx7ZzmOhVNd82THOTJZ/QV2Etk3rbj4LjMBTwYOslAmPQ?=
 =?us-ascii?Q?bKVHIPyEK+3To9Y3pHgo8i5H1aWunyKzmEYy3MPcdUjjbKcTtU5El2pMR6Sx?=
 =?us-ascii?Q?R+9kdYMD5gi9qPZDCxQcS2ByOEwcoRlyzXDlPhGiXeRRI79IIrNBo/wERm3A?=
 =?us-ascii?Q?DTHcuUryvH8fCJokOzCuU1tmkxusjvR+qB+71ezIP6cP2PEHq/ASVXKv+e/A?=
 =?us-ascii?Q?KDDzFLmIeJ41WdP8WuGOgG7FEmevHRcgVeO4YZjjkZm6zKjUW+LIHKIjS7tQ?=
 =?us-ascii?Q?rFJyBun2NSpCnRIz78wMhp+CU6cw6+kI26FXK7u2N/bNFlPloxFGRTEOQS1m?=
 =?us-ascii?Q?Lah8oNf0y6pbu2e2CwLBH/pC9tmlJ3MU8kgNpIDJGjusUyA3T5bIQVpenBRv?=
 =?us-ascii?Q?UwUXtgpLGVU14vKjSXFMUTuTTy6uKRIqEtsGz3chuGA8Wa55O1MWYVcHRQDc?=
 =?us-ascii?Q?va3jXD1BrCJ2kZ33sXuPiKuK5QHUST3eJ/HeXIhVr74mloHVCX+CBPltiFmX?=
 =?us-ascii?Q?+hmWZY9yxEJvkjoJf/3JDfkHgOytnGSh/a3mzl/l0kqy6Ca/lMJt3IKRfPD4?=
 =?us-ascii?Q?LxWGn51jad+hZE9Hogf7RYAm/jqG130GDtjpu5PQcRGD94wzCwg/z5TW1cqp?=
 =?us-ascii?Q?hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2F305C4796331F4BAED64EA962C70D65@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?I5K0fyttHOTfqk1J5AydKFYa5JJ3ljOxooigcFUT45+f8Ex/4+9q5XAhUf6f?=
 =?us-ascii?Q?5nlaxZLMJyYDzhC+43gJT4RbVAI6+S41R0s23t05hqR6nGpnL5OyTm2ywNjy?=
 =?us-ascii?Q?DcZ007yfEDzCK6epF/u3PcgF4V3t0L13A0P1LzqK8rzU0PIJSVXKEucFiVzg?=
 =?us-ascii?Q?bPCUOeALzouLP3yiQEHdHMQ+TVmq4PAhc36XGAr9vCyWy83MYQPzF2/dxZHQ?=
 =?us-ascii?Q?bNz0UkKK9pjfBFa/hA3fa4M3X8PNhvVsy8jHnhKrdIdFPpe3vTSt2aGNXJIc?=
 =?us-ascii?Q?sq0QWHBF34I9m7/V2EaD/kIgJYqMDxNK+5gbbv5r7cPevld8x+P5ur2vPmVt?=
 =?us-ascii?Q?481O0dLQn5fw3jzFYgditAwrWPhWhuDBRbyFnFdlgFuGMu65m17ysDnPUjRG?=
 =?us-ascii?Q?rDLOZPyhaOBRdGUlBwqZ/cJbMqm1Ov5VryfQNmiqvi9XxV6OoUarlgScJ+9y?=
 =?us-ascii?Q?1X0Xjjw/mE7maATlaejkUYKnvgDrQqpJCpsjKAAvzfLelT6KJtkDjStGU7HU?=
 =?us-ascii?Q?KkUeQc4jSAjhIN0YJj4Tm/gb2sBV1Ut5XLC7ABWNQJZHF2v4SncGiWw5cjHX?=
 =?us-ascii?Q?xlP6s9oNUYe50jlpvg8g/qPDpt3Uy8JX5egTO5Ar5mLAer7xrcj3EhAN0Ugg?=
 =?us-ascii?Q?Q/3ACz0q+DjraiI0w8xhHN79H2WiSm+3ho61I02cJvryfbn7kJ/xUXQpWFEN?=
 =?us-ascii?Q?FctQEX37Bfqse9aN+yq6St7XmhBmJv/l/+k2yGmuGYdEsG3hsw0/DnL6UhKT?=
 =?us-ascii?Q?0uklvSTimhK2b9wTBhEkpb56FWFypJKWgLJ3n33HpaG+qg+6UGGIv/h18rXC?=
 =?us-ascii?Q?F1q44Rp9PU/V1HHbRA6ualGti3PrlEOYRHFhndUgL3UqhgdBSquvbqZ74hT2?=
 =?us-ascii?Q?AjAx3HeRDJZ6cr5tRkcIIOEBif8vTbGh+TIMEbxJOGR7IBM2D96ClwXjCqPg?=
 =?us-ascii?Q?tCEqY+RgEMjx2mJH/A3mct5TPy3On425fneJN6GTit8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9edd74-ca05-4b97-dff7-08dbb52b9882
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 14:05:04.9518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hHVz4ZTQ9KRW5cGkDTXW0gSQZrk8WF5Nfr7vp2hRZu2YfCCMFIIV0sS09D9vci6BtFl401tSahlUKljjzWx1LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=831 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140121
X-Proofpoint-GUID: QgkEulfC8MnuxdwwsX2mzYlwG_OQ3lEI
X-Proofpoint-ORIG-GUID: QgkEulfC8MnuxdwwsX2mzYlwG_OQ3lEI
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 11, 2023, at 9:30 PM, Andrew Morton <akpm@linux-foundation.org> wr=
ote:
>=20
> On Tue, 12 Sep 2023 09:19:59 +1000 "NeilBrown" <neilb@suse.de> wrote:
>=20
>> Plain old list_heads (which the code currently uses) require a spinlock
>> to be taken to insert something into the queue.  As this is usually in
>> bh context, it needs to be a spin_lock_bh().  My understanding is that
>> the real-time developers don't much like us disabling bh.  It isn't an
>> enormous win switching from a list_head list to a llist_node list, but
>> there are small gains such as object size reduction and less locking.  I
>> particularly wanted an easy-to-use library facility that could be
>> plugged in to two different uses cases in the sunrpc code and there
>> didn't seem to be one.  I could have written one using list_head, but
>> llist seemed a better fix.  I think the code in sunrpc that uses this
>> lwq looks a lot neater after the conversion.
>=20
> Thanks.  Could we please get words such as these into the changelog,
> describing why it was felt necessary to add more library code?
>=20
> And also into the .c file, to help people who are looking at it and
> wondering "can I use this".  And to help reviewers who are wondering
> "could they have used Neil's thing".

Neil, are you planning to send along a replacement for 11/17,
or would you like me to fold the above into the patch description
I have now?


--
Chuck Lever


