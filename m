Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4106E5F1DDE
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Oct 2022 18:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiJAQvM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Oct 2022 12:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJAQuv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Oct 2022 12:50:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EA32315C
        for <linux-nfs@vger.kernel.org>; Sat,  1 Oct 2022 09:50:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 291BtmjF008222;
        Sat, 1 Oct 2022 16:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2RaRMoq7138EEGABckB3sDhbhmoWwnGLhONHb0BQ/hE=;
 b=pvVpNxg5nN/3+KvUpvqKLULdQcF4uxE9BRNxtEZdzkKcexk2y2jElgTZTOkIwMBfgm13
 Z0iYA3IpDK9tYmKZftZJyg6vK+dQm5v9DVUC1tf7V4ll50n8NtkkT7GK+UXhfNcFJHft
 cvOZ8mkrBsIAcdgjc4Uv1qZ/qT1vhqVMeQTeE+YBL/PQOMqcHe00Ht6cc/xtTGcS2Gmo
 qXvIyr8suuPxdbSdVJjZRLo9hhZGPx2vQlhYwK32OUYnEZf0PoFzLkqCDXBnVlQwmG35
 pEqn+mTqOVQ+lkBWMYRnuSffBru+yHI7huZi5c9eosp8+dYDYQuDmxk4XL8PAbYlQb2W JQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxdea0r2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Oct 2022 16:50:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29195sa0034505;
        Sat, 1 Oct 2022 16:50:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc087tqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Oct 2022 16:50:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0qbUyTDvKAHJpaH+1XlIt/O2+u/es85JKE7ezB+34h/fPxiNq/LZIz/+geVlxclWlAQisWjWlA9u8RkngfalZnJO7UVeJ15K+QTiPjVJJYo1+WbIhYrkSa2iKMsuiKMB7L6qBWvjadgOPtot+jsh2jEmmlqm7cdk5BtUhCVzSnoCsf/U5sqXOz+468j4D/gXqixoQgQwb4Jhr9TfMNYSiHNYMa05foAnQsJTmsS8GtTQuO31WgSZ8lYWS2IZ/R2dOcvpH+fmFZ6lrRcxmXaxZNf/2sDBkyJBxarihMvPWsGvV6LHtziRFGgOp0YOdNy8y1NqFD7Vq/DA5OWQ7Eokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RaRMoq7138EEGABckB3sDhbhmoWwnGLhONHb0BQ/hE=;
 b=dTRlfTrzbf96J8Ftl5a9pJXfaVLp04sS2re5bHVIXBUIey1oE+kePqdbNnsCp2d999Rdzofm5ZnttDVWcemlyw9hrklNHAOTvxkMF7vghsFvWoGPiqe+1cxUr1AIjBjmGDjPlCYWe1ECKU0GyqOxmtDvb44aGW7pWtVweRZC/pXgWawQWy6fYd8kUJHYOpxgWlet5yE5PG6yiSUbHpNWpoCx0YmyNyMCGmWpSeNswCkZK4K7mI9fKB3VoTQaVuRvFg6StJorRCc+JyK8F/i3qPX2fioX8iPTnoJMfRfDzT2y+h9CNmzGbJIwWCyoQz151hCZv659j9hBkfzQyyIHjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RaRMoq7138EEGABckB3sDhbhmoWwnGLhONHb0BQ/hE=;
 b=Te1fWbZSnEJGDU4M1YNv3O2A5HjLG5GbK2T0tnnyOXs6By10QstYyPSmRCLLlP/ZUh+wMF2ArDRd1piDvlYen0ZsOBraaK6WQ31/QMCB5+fK+87vNSVdShjRjranIrGTjDlChvBaqPqWQ7u6n0GvVSyx3y9Hi7c9tlMR3nPqsYw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4321.namprd10.prod.outlook.com (2603:10b6:a03:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sat, 1 Oct
 2022 16:50:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.024; Sat, 1 Oct 2022
 16:50:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v2] nfsd: nfsd_do_file_acquire should hold rcu_read_lock
 while getting refs
Thread-Topic: [PATCH v2] nfsd: nfsd_do_file_acquire should hold rcu_read_lock
 while getting refs
Thread-Index: AQHY1Xx83NLvB6RPo0qCB3ayozGSka35q3EAgAASgYCAAALTAA==
Date:   Sat, 1 Oct 2022 16:50:13 +0000
Message-ID: <3187452F-E577-4F95-B786-D83C1A8BFC37@oracle.com>
References: <20221001095918.7546-1-jlayton@kernel.org>
 <CD650F11-FFCE-46A3-90B8-45C742D8B670@oracle.com>
 <00076e31d59e95f97dc6d049aea9b2f41e54be54.camel@kernel.org>
In-Reply-To: <00076e31d59e95f97dc6d049aea9b2f41e54be54.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4321:EE_
x-ms-office365-filtering-correlation-id: 979cb3d3-dd94-4fb1-2a72-08daa3cd02bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bi6uR8Jgr2RAVwJ+q/6ZspIfxJKLVL+UncwZ+Qze6h8+iUOP0Ctz/2HYJxguKdOJJOIR8ufcLZs6uc2vYgGdeSivS0yR4A1t7sw7Rx52E2kUNB/156v8iptgtvgXGK73XrDApIayCBkK8JTJHJfBvTDJUkbjbeyFFgdDfFEkllThIokaipWQBr9OL+zTRxuciDgnB513qwLSpJCWdVFhciPO4nVoYuW0wM71TW2XfYPQ+qDos9rmNu7caVnpRwKuql0r/wBXLhxXBF00j5lNRWVlj8I7NacOeZySsniv/9kjV3l0ba9W1xJZ7x0D4cSOZMxDRLUq5PiPG+3JN7R+cTR6hhfyLPJP48Vt6mJW2V3dKu5ehVsr0PFnm4tUu6eXZWkBb0A9aUahrI52YaTnBB+lDeszhpyMXozk/guRjhopqRsfyWx7gtRGzNgM7UPRC3NopC479bjP3IeKQPlO6hdNZlNwkJYYIIJj86suH93PvTvUwHhYUjCX7/nlGFdPSuU7nDUvD1hE6fQ1oasvlbOW5gRZI2atbGFPQiuDE4qm/LKk8OQ40GtL2uLLwCngXD0uUm+UfR3ETLpH8rWaIZA9pU5H5bolc28IHCQZUy+wJmXZ38dK5jWkEgWfLbPvB1Xn/N0jSX/ZRmQYAU8rBJtHJhaJRyFARcgWRHDJCtCYW+9lklmkugIXy7Rfp6g2ipOeaPRcE+9i2zXEvohO0DD4Xs7ZyBc156ZldoVNOu6zPWYg5gAMnhnzFNczln9YjqfTkjj35DT93xHjMKM4GIR8+T/I7ryu+9wKoOn2Mvw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(39850400004)(136003)(346002)(451199015)(54906003)(71200400001)(316002)(6916009)(76116006)(8676002)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(478600001)(91956017)(6486002)(38070700005)(41300700001)(6506007)(5660300002)(6512007)(26005)(86362001)(8936002)(53546011)(2616005)(83380400001)(2906002)(122000001)(38100700002)(36756003)(186003)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D7ZHHx2S7Gb/LI3Yl1/TNKh3HrjwLzTmpVP7i9bR4+V1+Fux8bjtSlwVrNRR?=
 =?us-ascii?Q?merEevlEZO3kj9tQZbRGxuQYRMYcaboZRSj06cvTDycdyrnZp+IvA9nvAfvs?=
 =?us-ascii?Q?EImAfpA06k/SiUekJ7V9LqE+/yCEKqyV8/AcXBmruTuuDWlQYWAHyEQCbDgB?=
 =?us-ascii?Q?MasekgOmJ/a4LxYeJ8sBaDiFmD33ECSCGkjg1fRGJDQBjvoVPrvM6zlal0zi?=
 =?us-ascii?Q?ICpUvb1HhaiRacinC+JuBKw21Gn1tGsIZLxbqADPZ2B7LDZdQF0uTRCU3JoC?=
 =?us-ascii?Q?e01dfGo4Pe03hJO/lAyD+7vy9KTHLM4W3wbK/FQSrX9TxwyeOs+jpJWvAmei?=
 =?us-ascii?Q?PFhkAyH+VnFtHGpR2X8b+eZwxMjXCqOpWnGRn37nvoutuN6kYKSpri8MxRs8?=
 =?us-ascii?Q?wr0TzUKDIniT2WsAXEezxsjaWP8piBJ9W/TGUs/kWlFNQX7nqKoTg7Pl+m/G?=
 =?us-ascii?Q?+nhxcLtnsPP13YYwM/0M0WM1jdKvhwDAld7WlBuxyOz2bTnvxBMImmcRmmEE?=
 =?us-ascii?Q?/N/vJd5BVyLXQ2nV9zZ9BJPXexHuBIESH78qsCX13c/ZiM//7dic/ZR29zDM?=
 =?us-ascii?Q?kldGgC7ggbEwTBZl6/fjdygwo2wHbCBNHIstHvyvahwToCHUYKI3lJMJxG7k?=
 =?us-ascii?Q?pcQD0VYBT00UgfX7dNpfApXPRlG44f1pGmBGUOex6sf/maId1pAIysoMy0A5?=
 =?us-ascii?Q?DSSay9Pmiofn9OHJQ6hJ5okSzU6f9+M3OyB4Nq6OyVSeVqb0HW9GIVS94qwo?=
 =?us-ascii?Q?aucsutFGyAXaMKXLZiPs7pHyUN+CEcgw3dC3eyy4YekdTDrLYW9Z5Bo7+2oP?=
 =?us-ascii?Q?fp0WWkVMQkqdDZx/r1jRAIgzrbtiCI0DDDSt0L7MG43zH8i5x4Cy/8oQIsq7?=
 =?us-ascii?Q?maWJZ5mLbSzFExSCxXOv22g6erQQothmfLIc5yjauxVz/J/n38/VHzEJTC9e?=
 =?us-ascii?Q?OKxERB3Pb/i7p6lSbMu5gk72tsFPZiqEN+8qYnOPPzlpwm06p9YXkeu+Ae6C?=
 =?us-ascii?Q?yQeOumBQMtyy1UvK9H1n9YI12vUsVqwGAmt/TCJFTD14fa4xSdtlmbdOlIM5?=
 =?us-ascii?Q?NxjgTn/+S33kOBHgU5F6WhKbeViuFTgO3aDKtKMjNXqJ9cEvEkAISrPcu5zT?=
 =?us-ascii?Q?eLgLXWE4RGCBTnMQQ0kqx8FgHCv6LZt36JLVfvnpWGnj4vCoLKwzrbNapk2h?=
 =?us-ascii?Q?nglURaoYLkSEEWOCUVipW0rmT70JKLjdsfeT3xKzAFGTU1rNoHrAZGI8+ID8?=
 =?us-ascii?Q?1Nr9uG0sOdr/Yp9BvNvyI4sK0q7dVbMHXc3RmfGirPVs/NHjdeHHRG8MViKV?=
 =?us-ascii?Q?L8M1VTw9HOB5aXs9iYCS3LfGnjq4Q/jcDdppCvx/axgWucbwbPDXM4S1M+ih?=
 =?us-ascii?Q?Pw7LffOTxM1coVSdsrz7tOBFy0w0oTIzATv+L6zcAxthKpRLGt3JLMwlsia5?=
 =?us-ascii?Q?Myo2W/nSD1nLFPbR5tJe3UEylC9+i2eGl46ExQ+3s11GFcJR1LRM0wk/WIHu?=
 =?us-ascii?Q?OjFf0nGS9LzXmkcjgUSfunyjbBikw3dhZBl6siPdlF1giw85QT4TtNKbyZuX?=
 =?us-ascii?Q?K+PDk6E9LDjzpGUyBRVLC/WFhgFc9cu042syxn3xjDQ6jfWNGrHXzGX4UraO?=
 =?us-ascii?Q?Dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AEF6EEA581DBF74F852C0802C221B91B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979cb3d3-dd94-4fb1-2a72-08daa3cd02bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2022 16:50:13.5765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VL3i4Cs2EwHyLOe0ZtrXefpZpNHqD/HoRgwfEFwoGxyfZ+7zcbTB71EQ9rhQU+MqLFeN51TZiYnRC2gc3mp1zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_10,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210010109
X-Proofpoint-GUID: -LiYOSxriMMAJM_84iZe0fiuphjWCGfO
X-Proofpoint-ORIG-GUID: -LiYOSxriMMAJM_84iZe0fiuphjWCGfO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 1, 2022, at 12:40 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Sat, 2022-10-01 at 15:33 +0000, Chuck Lever III wrote:
>> Hi Jeff-
>>=20
>>> On Oct 1, 2022, at 5:59 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> nfsd_file is RCU-freed, so it's possible that one could be found that's
>>> in the process of being freed and the memory recycled. Ensure we hold
>>> the rcu_read_lock while attempting to get a reference on the object.
>>=20
>> I'm OK with entertaining clean-up patches in this code, but I
>> am skeptical that this patch addresses the concern enumerated
>> in bug #394. As you've pointed out to me before, the "UAF on
>> DELEGRETURN crashes" appeared well before v5.19, which is the
>> kernel release where this bit of code was introduced.
>>=20
>=20
> Yeah, there may be more than one bug here. In any case, these patches
> should close potential races, so I think we ought to take them.

Agreed, all of these are valid and desirable improvements.

I've applied the two from yesterday to my internal tree for more
testing. I plan to apply this one as well once the wrinkles are
ironed out. Since these are a bit late in the cycle, I plan to
push the set to Linus after the initial nfsd-6.1 PR, either near
the end of the merge window or in -rc1.


--
Chuck Lever



