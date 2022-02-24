Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7540D4C36C5
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 21:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiBXUTI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 15:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiBXUR4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 15:17:56 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717BA79C5C
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 12:17:24 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OJiJdY018755;
        Thu, 24 Feb 2022 20:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TWXJnD3795KqmUOpM4bOjMuljdKqnh0IKDNUsLueUj8=;
 b=COYX21C+IkshFQSsmLVo0K3nuLVQ35i3Z7wo8zys3YWvFJl1MeiifwKseNxtCkXRX9QY
 rCEw78toEwxI+vO0ih5uplqAfoC+xbKiArYQL9vepo+O86K6adg1ZTUlY4QqZOQWcncn
 rrbGpiTGUsXGXfz4Wct2N8+35gIZTr4Rrn9uaOS3x4lZz8PMUE1hBaPGPpABhM/y5S2M
 ITtGa+UE2SW5KQXVjAGPXSARcSn99fJnZChanlMj+ryD/Aj7Dv3oFyHXwf9Z4Pq/KREK
 bgwW+Y5txSDPPVbhWAH4XlGJWiDdcFmm+NkWqhY5AohYlBzDyAbh6SD2AVB3gYXmfZV0 BA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecxfaytxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 20:17:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OKF3hj091540;
        Thu, 24 Feb 2022 20:17:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by userp3020.oracle.com with ESMTP id 3eat0r8fsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 20:17:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdE84XJEORG8xCL1Jz7lC40BeZ6kIzaqvETKk8gpZ9/AeLGjVVNkd0biWFdF75RKAr4//60bRBJZCfuhPQFRhe0V0N+LRaDCPqQHzkE1QTafuFzqNSnVIPsU+ydUif0oPbo/AAfeaa4xFxI0AoTekSZ5vad7czeJ43NriLiAcJcPELX4karHoKrUvLkS4Gzkm4WeHJhET792KcT8xC5PctCqkPSxLmwxhCxILPRMeItfyqekzjGS2Jyr9RK4+J87SlPwi30Um36kkArDTShZe6Apa4S9/URqybUUhGDGxBOdB4umwejZyaWE/kO5WlUjokveGAWz7RaW7Ae+rYTWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWXJnD3795KqmUOpM4bOjMuljdKqnh0IKDNUsLueUj8=;
 b=nMA7cN9XCpAhBq6RD6VglCUwQlXptbq1Y0Oy/Ig0Jf74ml5jvBuwnyLYhOStIhQCbZ1znlrREJryMDXKiakffJgYin/gELnMB7txY0bbpBGCOZncwDpRzNq5Qvw56v7efLpgg73fh7sLwlsV1kPkHrCEBzzSSNQPPbaW5775BAXygn/vYk2VseA5xep1bsUzd46OmqqhHJzTU6JKbgHHOtD+VGT4P3A3ofn9BEBSRqJUQ4yvHUxsZqLEff82oBQT1ULUgBiMJq7H4TCR78eMpRx0uhlj/XDcJuRfihDNLEt29X8wKW3V6w7NtjYdHqzp4tBxeNA/hzSqJFYVYhZvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWXJnD3795KqmUOpM4bOjMuljdKqnh0IKDNUsLueUj8=;
 b=b+193wNcDjlsy4Q2D+eUvUUNMdpIkGUxsRbelphZOqr2bKIOnYsNe8FQJqqgGZOYQsQCxtbUMclsjxieOmlq2GVkZy8qeU/TlzrzQzR15GeFWSgX/qwXX/xLGN4B0mmIbGj/6YIJcMVc0qvDddBW46pujFuNy1YmIssuRM9i+wE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY4PR10MB1254.namprd10.prod.outlook.com (2603:10b6:910:5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 20:17:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 20:17:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: more robust allocation failure handling in
 nfsd_file_cache_init
Thread-Topic: [PATCH v2] nfsd: more robust allocation failure handling in
 nfsd_file_cache_init
Thread-Index: AQHYKZoEe5El1hMKYEiEq+uh3pv5TKyjI9OA
Date:   Thu, 24 Feb 2022 20:17:16 +0000
Message-ID: <BB7DEB92-1E3D-4BF5-A723-650C2B95877D@oracle.com>
References: <20220224161705.1041788-1-amir73il@gmail.com>
In-Reply-To: <20220224161705.1041788-1-amir73il@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4288e36-aedb-4242-5066-08d9f7d2a6cb
x-ms-traffictypediagnostic: CY4PR10MB1254:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1254306CAC3FB4F28A4038B6933D9@CY4PR10MB1254.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e4xyrRUH2d+XGrrujBfo4zyFCbTlYRVoCeP8RwQ5JrmSb3dk0//lASpTfKS/So2wzn441bq7EBQzBtchCedDtTkPUYel6vX/nPusCXfSevx5xdn4HiV2556xdxDl0y3JVaKXNTvkvBAYu66inhqT8AoXfp5hHYSYGmFI7fE+7mO7OJLUdldBW0W7Hq8JCjlLLLNfXhc+DZqOoBtEEeHys3XF17rzwWRzz9+Detnz0gTC8yPp+8baCjfWp83ispR7Uh94+2OmlgFLXifZYH6sms/7KXXixahIgnI5qWMbvrCsGX2fabMm+E3OGX194hbDQr8usfY4gQgAjBRjdZTdMAqA49wKNo0NNLqmYqzi0Z8dgF2LsCL8x+LmkWX9KUMWQhr0/sJaQpUs3LqfCZWrAACwa4S3GJ631F6E+B+dZp4PnczYVjQ8ehQMK9tnehBqGMwXuYi+eiEJS5HxH8dmjV1rFI1+0rljFQrsH1R0YpWkQlkgxzYkCk1qxxYF0lFE1GQHi2k6+y8y1k+4+YmdQvMQjVBJ39i2X8i9cSrxhz1jfnA0p41u5ItXFlT1tHcDdK0YC63Na11yrUnLj7bGafh9r5Q0qR4cu4jQoxXFvU2jzFBzBIwCD4DwQOItcWdrQjjy2LtPZAg0i3cPV7w2ViY/jkIkAbELxb8NSN03VYsXBeKR1XYyhmaUrRAwi+ux5Ga7NFCWkRVVjHIi0Z6NXEmEAs7b1KqmkCYQoX4OcYD7jaRAFfrukVzTL2CQnCSgbpJYz391cpFyFYFEtOxhuDs51R9J34pz4dMOb3OQTVNllEAIyxsBqAoBIUdyQ/uecng7XHftYUI+inl7YoJUmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(966005)(6486002)(83380400001)(54906003)(5660300002)(6916009)(26005)(186003)(33656002)(6512007)(2616005)(2906002)(122000001)(508600001)(53546011)(38070700005)(38100700002)(86362001)(66476007)(6506007)(71200400001)(91956017)(4326008)(36756003)(8936002)(8676002)(66446008)(76116006)(64756008)(316002)(66946007)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E/6DxnF1seuIkfN/AjpJo9jvSepCxSzgZdKLBMcqQPcr+IrMuHYItfmmI2Aw?=
 =?us-ascii?Q?GGYogdmgCp80GHuwpAEknyR6V3xZzKY9jn/JA/B3MsZ6rHgMNxegYMXfrW4l?=
 =?us-ascii?Q?HIO1r98oDwJ4POld5+axVy81T4pGnyn156FwBTh5cjaoOvH8FTaIuKBv5/j7?=
 =?us-ascii?Q?Y+0EbWcGTP3nU/d1Ntq9l9xPSv98/PCfWaojVtWEWVWmpo8i9MnXUgrq/xB7?=
 =?us-ascii?Q?VtSJnaX/KTBpErNcLmLnYCsukXoMHj1tHI9W4MNJXHPdKj+/bDa4NH/Xp5g9?=
 =?us-ascii?Q?JhNywUJU+Q0Sm+KOFTgTtwbIy6ri6plncmOMt2MLAoTWteBpTrVY0+Gp2gi3?=
 =?us-ascii?Q?gMFNCktgQRr3ZHnDtihHg70fjrWgZUo5Sznk+sdChJ2Z1hXHGEy3GgnJplPr?=
 =?us-ascii?Q?h07OGAuhHA1MHNjg2zYIX3KKhygqJp1gDZo/TL7pIbw0tZnFKSnoZMWnFCD2?=
 =?us-ascii?Q?97MfBsj+5QXMoyt4bSNuIySJwVvqAV+GFt3Xp05DZOZhpCoWFzIQPaGqqSQX?=
 =?us-ascii?Q?gqQl3Uk1P0Vjt4ieiE7yZpXhgheBKJJIr0IvE6ceD8/pmwb6eKKSZcko3voL?=
 =?us-ascii?Q?r0gKconq3bpjF1/f+HY0TrOxskfewO4eGLoZ2hEMCt5KZbuIBRRsaX1u/HQn?=
 =?us-ascii?Q?73H51pHsynSHa/3DayGXsCbiap+neNwAfwHr8AW1K5ypVBwY+/wPSb/qrYVP?=
 =?us-ascii?Q?YPGkszVTCj93PFd9Ks3MqvfpOv5uRzf8AJdjKnLCEUde2CPi8WxTmB5/LHje?=
 =?us-ascii?Q?e8FCBMwf4SOpCCO/qlMxy1yVKxRqbn7YMQ5eSplb9/tvellVmbgEFCu3X6+A?=
 =?us-ascii?Q?7p/OM1VX5FLSJK9p0syOgiyccyX5kAXZnXe8+FaypeBKizMB614E16Z+nPXI?=
 =?us-ascii?Q?DCVVmEl3QcNTXaeVLEdCjgBIc9l54+Op9Ry+UavCmtg2SCd0VbVeWatsX15x?=
 =?us-ascii?Q?SXdcc9lqzodUoAn4WL6Zu7m44F/cCiqZD/jF6b0nGK331FC0JO60il/P+/b3?=
 =?us-ascii?Q?8Dm1d1YU4ZGUC/HIjytw7R4tSI52eFqt6ODB6YaQnhfcM9QcewC2ad29Hv1T?=
 =?us-ascii?Q?0vMkyO6XRYCahzjtfeJTe7k4vkRwGZ7NWbXXQaLu7KeUbbLy49YeKct8rKFR?=
 =?us-ascii?Q?Lj6aW4H3bhe0qaNgjEJA/V5UlRvXjiMhEySu4fM86k82LKQqvJ1PL6mQY6Lh?=
 =?us-ascii?Q?jQkpeVmupBIjIkQBCL6xgLdV54+Tt2XU3HlvvcRc+akAsm6NfMKrLwGSlkBu?=
 =?us-ascii?Q?HyVU5pb3/wOsKzVZU7icbjFhPee3/4KC2Olgl9VtMk6QFt95E314i0XqAKzZ?=
 =?us-ascii?Q?TdgoC1NgdxAD/zZLiijz5I7Pz6Eu5vgfud95yH+LfJm4qRnuSaZdR1VF7Fk8?=
 =?us-ascii?Q?zeA+GJGc4ZscZdQkIQvaLAsaLUoNvF45IEPgHcFoVUKEO4LVy61XTeZ5tRf5?=
 =?us-ascii?Q?whU0sE5SurowToQD5ErDY+wvhBKovw08/aBiD0cKldpGfOD9D3l4jj4OopUK?=
 =?us-ascii?Q?L3mnsFDS+ES6cqNzCacYWFsfJDD+p5uN4x11qdo/lHs8tkjJ5BcOVyauTDRk?=
 =?us-ascii?Q?Cn4Q+Ibv8NfWQ0GqpF/fu9c//5Mgi+tOyXGOT7ufIK3UKl++uYgoY+mBPX/P?=
 =?us-ascii?Q?u5t7zwvrhGNptIQbVj+JO6A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7259812126D4A5418C1FB386D69499A2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4288e36-aedb-4242-5066-08d9f7d2a6cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 20:17:16.2389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0iAnpimlOCbBqfyvXid6F4SQoTzLM5FL6LaBOa5C+1UJzkg5ou6gOSGHqCmjXzv0HITFJ+X5aHz2A+AfqDKbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1254
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240112
X-Proofpoint-GUID: _WS4RxAm9MXNsYeJLAv0WrPL2EIJwEPo
X-Proofpoint-ORIG-GUID: _WS4RxAm9MXNsYeJLAv0WrPL2EIJwEPo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Amir-

> On Feb 24, 2022, at 11:17 AM, Amir Goldstein <amir73il@gmail.com> wrote:
>=20
> The nfsd file cache table can be pretty large and its allocation
> may require as many as 80 contigious pages.
>=20
> Employ the same fix that was employed for similar issue that was
> reported for the reply cache hash table allocation several years ago
> by commit 8f97514b423a ("nfsd: more robust allocation failure handling
> in nfsd_reply_cache_init").
>=20
> Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to nfs=
d")
> Link: https://lore.kernel.org/linux-nfs/e3cdaeec85a6cfec980e87fc294327c03=
81c1778.camel@kernel.org/
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>=20
> Since v1:
> - Use kvcalloc()
> - Use kvfree()
>=20
> fs/nfsd/filecache.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

v2 passes some simple testing, so I've applied it to NFSD for-next.
It should get 0-day and merge testing and is available for others
to try out.

I don't have anything that exercises low memory scenarios, though.
Do you have anything like this to try?


> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 8bc807c5fea4..cc2831cec669 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -632,7 +632,7 @@ nfsd_file_cache_init(void)
> 	if (!nfsd_filecache_wq)
> 		goto out;
>=20
> -	nfsd_file_hashtbl =3D kcalloc(NFSD_FILE_HASH_SIZE,
> +	nfsd_file_hashtbl =3D kvcalloc(NFSD_FILE_HASH_SIZE,
> 				sizeof(*nfsd_file_hashtbl), GFP_KERNEL);
> 	if (!nfsd_file_hashtbl) {
> 		pr_err("nfsd: unable to allocate nfsd_file_hashtbl\n");
> @@ -700,7 +700,7 @@ nfsd_file_cache_init(void)
> 	nfsd_file_slab =3D NULL;
> 	kmem_cache_destroy(nfsd_file_mark_slab);
> 	nfsd_file_mark_slab =3D NULL;
> -	kfree(nfsd_file_hashtbl);
> +	kvfree(nfsd_file_hashtbl);
> 	nfsd_file_hashtbl =3D NULL;
> 	destroy_workqueue(nfsd_filecache_wq);
> 	nfsd_filecache_wq =3D NULL;
> @@ -811,7 +811,7 @@ nfsd_file_cache_shutdown(void)
> 	fsnotify_wait_marks_destroyed();
> 	kmem_cache_destroy(nfsd_file_mark_slab);
> 	nfsd_file_mark_slab =3D NULL;
> -	kfree(nfsd_file_hashtbl);
> +	kvfree(nfsd_file_hashtbl);
> 	nfsd_file_hashtbl =3D NULL;
> 	destroy_workqueue(nfsd_filecache_wq);
> 	nfsd_filecache_wq =3D NULL;
> --=20
> 2.25.1
>=20

--
Chuck Lever



