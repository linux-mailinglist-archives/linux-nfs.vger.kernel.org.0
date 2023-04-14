Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C58D6E29FC
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Apr 2023 20:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjDNSVJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Apr 2023 14:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDNSVI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Apr 2023 14:21:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D399EF7
        for <linux-nfs@vger.kernel.org>; Fri, 14 Apr 2023 11:21:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EGv5hf014490;
        Fri, 14 Apr 2023 18:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RrT4lMPEMSIBpNprZXxDmR8LRvs2jehhFD3a1MXdj7w=;
 b=JyZOSiwbggr4wXiNC+ppKBQIG0S9DsTGe/65Ah/XF74C4yxFI32lP2Fuj3Mm1til3xva
 TXZ/z3vhGmqpc0Y6WP05In4lMfGVxA5nMm/DQNfkrKy2z+svxCzThvcZT8bJpy+7fhy8
 5AsOEQbXVdl8Cs73+Dhkhv+Pn5aaeYzwz0+BMLM2e3ZR3d8ZYrADBm06JXnq4xJeG9he
 NLwc754AQJ1T/OIHmeHlHOsQMRWM4f3+RjeRGjSN2vJo8w7dQUWHHMLfz95owwzuY6tk
 fZsctqKj3e1/WOc3TVBae0ub3VOgdfZBJJ9h6J90tLU3U17MFo1jEUonJW0UX6i4gSY8 XA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0ttxra7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 18:21:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33EIF389020984;
        Fri, 14 Apr 2023 18:21:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pwwgsrkwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 18:21:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6gdHtJGNxgApfPs2iVBMLzVatzQOLKMalXXrimfhkQPZh28tzqHZTTqbDkSQ89GLbSiPHfgQbR5CWfSP3W/S2IV0hHwx3UiTTONrPnneSSE0ogL4zd1xurNqwAjkMr7fNoIFkxsCT+VVZGKerE5NDHFm+5rriNrH9FHUG4oF6VIL0/MHT6ydem3JLTKcvNtY4dvGLUDqNdYH99HdPldIbK8P0Xw+KDY/cNqvhdxQiZNpuTH3CMC8Vdw5Ukhr7aD6lm6XjIw4wx7bfHacfjDebNm7W4QuzcbMuHrgP6g+W1ycY1QwNBdHZpN9sRFVniJO6h2qptQX32dGpk+09sn/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrT4lMPEMSIBpNprZXxDmR8LRvs2jehhFD3a1MXdj7w=;
 b=Q1uul+Bz4FVzAnAT78kDZXN1g1B/saJf4CMSgd1wq9/z/uYxnRnkHvd2Eh//S1xGXZVejUTjHRDhrwLGXyBODc6PPq5clDGhHlJbP2Jr5gJ2yQ88sb3k20I+YTpSugsR/67h3hiB5zaEMHnx29osvnetIKjIlnMDniVasNscSkqA+CYosausO/CIe/nsq5OyZvooTgdjni4djKTJ1XQDmSnWQjKNekHFCur3QnS333T5d7ehvw6XIBtWMaSG5jWHVXLGYHRzvNIC6b53A9wRKSj625tIX6c1agu438go8e+G5LeW9oyNzy2szeStxDmN9OBz/kiM/PL9PY3frdIypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrT4lMPEMSIBpNprZXxDmR8LRvs2jehhFD3a1MXdj7w=;
 b=lKGXbGkIVHFzGHm+XqpQyNWOS9UcFEe0pVcPn3yFsb3ERpoOeSFg0sl8UKyHSu2wZxMTUmYnk1qcvUtIzpfEb9ij1wRdX3TpMxrEP9bBPBi5II84h8c44opuuSIeIh5/3MoSVYTC4bSB3ZagVPmeJ1lFyrOCK//nUWjI0YH3A4U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4432.namprd10.prod.outlook.com (2603:10b6:a03:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 18:20:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%7]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 18:20:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/6] nfsd: simplify the delayed disposal list code
Thread-Topic: [PATCH 3/6] nfsd: simplify the delayed disposal list code
Thread-Index: AQHZK2K9iQAA9AGCR0S9mUeEchObFK8rpOWA
Date:   Fri, 14 Apr 2023 18:20:58 +0000
Message-ID: <7810C14C-DC16-48DF-8A14-1A1E7B9A2CD8@oracle.com>
References: <20230118173139.71846-1-jlayton@kernel.org>
 <20230118173139.71846-4-jlayton@kernel.org>
In-Reply-To: <20230118173139.71846-4-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4432:EE_
x-ms-office365-filtering-correlation-id: 474aa8e9-aaa8-49b0-cb60-08db3d14fe82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jBFZWcdu5I2NaXkBOauW5vrwGwl3LyQV+gDvdx1tjLqiwWYfgJvV+gHlTKPQLjbuAPd1/4Gqqf3tTqv+RY3pdFgyAok/UDF6+2jS3ap2YSvQQnt1LPbTsIQIPbWVNa4uFfveAWexbzmCrBPzMPTyTjqEx9/TDYcDoZ4dLMYCnQTsyAZqns3y+UDIQeT5+y8Vc/BM5NJE1sDOH/LQXLOxjXCXL0cfGG7W6yoFKlF7IR8xZEdIUyjKM2sYtOsBZs3Pof71xsvMayp3RYceVr59jzidOoKitUbHiQ8++Zg5S+PfriLrKy5plrIxPsnUyE4dQeEXZkFAKpKKW3MJ/7XMPemaJzqyM1HfBXhq9PiZotFiEIrtG8b9aknIw+IZCVNnfKYdsOX7SorXZLtcksv1/WZhNP/8bcpdLum6u3qMImnJDsClp+r4RCyeuC5clviotUvcyGgKvtW2ZDaiVGZ1VvWgxsJY/QX0cOAvbkwr83Pjb690Np/XVO+oVKvQ1WdaoLmagl8sYDdyj8Zk7RJhKAZLPzsY2duu2GEpjBOOH2wIDQ3nm7pxeMQJSjwvQVDy/il9yPq6uF4cttzh/Rz3Bb/Uh9+1SRK0whJYQxdbjNLxJBVaS1GGG5ydzPoE64ggZrdhXK92wnEHfNYHB6gzGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199021)(26005)(5660300002)(38100700002)(122000001)(36756003)(2906002)(66446008)(8936002)(86362001)(66556008)(64756008)(8676002)(4326008)(6916009)(33656002)(66476007)(41300700001)(66946007)(38070700005)(316002)(6506007)(91956017)(83380400001)(2616005)(76116006)(53546011)(6512007)(186003)(6486002)(71200400001)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pM95cqaSJ/HTPX4mMK4Ao7XHXuTU+go1BXy0spjwQZfLAF+XLW6KvjAW8qq/?=
 =?us-ascii?Q?l0eVpap8L8VqXuKoLNSKAvUCmAIpv5qOP9wZykMYWGVTBwqcQKuvpAfVvS3T?=
 =?us-ascii?Q?P4xpiMROvFhwr0zWUtMpCMPwSfj9ZyMBcTh+90EsvAwgv1Ob0vxBVEXvo5f5?=
 =?us-ascii?Q?TYpXmkglrwDRmXd5ygZSZLQuvHdR7CB00VpQJKi6lz/gPlccvyiZcjy/j5Sm?=
 =?us-ascii?Q?mcmeGw3VW/iL4wgUIoS19chHNnv9WwRcrJAJsru8EpN4M1wlTA3P/svXb96e?=
 =?us-ascii?Q?Un6nm7GPAeR2P0PJu9K7m2uOth+hw7C3MSld5e5TR2wQbktq3az7jvTfbKm0?=
 =?us-ascii?Q?VurkY3NBydvSo5TnhjPHEioQWxZY0xFoT2PTWWasj843hwrIVN+uDIZpb6e5?=
 =?us-ascii?Q?Stag6/HOAyQRpsX22c9KU7ghrbcI7+zyzjDu7qAASqkFpKk+qzw8zcbwMo9B?=
 =?us-ascii?Q?xbhQL39guhS192Ttmf/dTJoSH4isI+SQekvcb90cyQuwjcbq0OLQgN6hSia3?=
 =?us-ascii?Q?pGMNJ9hvUZVBGZC3v7jXFKKjdBZyYV2C83HU5eW0ku399eI2Nw9QS8oorg7V?=
 =?us-ascii?Q?CERwgA402rcCxsEqywl9Q77g6FaSGbR1wnDC5PbTx+dTo2EMqFq/5Abs7HxX?=
 =?us-ascii?Q?igzu4g0t28BEjepiLFqLwz5aSJ+LUYIQ68a9ssBEiS0WI+5kIbdgszJXklSo?=
 =?us-ascii?Q?cHVp1NKGtIPboYTMyn6KqFu8gjst/zBOCos+R48DuGpF8W2Ch6WVPRQzEi6X?=
 =?us-ascii?Q?xl6U10qbwIjXJCnMs3EXUhtr6YRqhu2qkgFSdIvgvxfhqaGSx2pjro+E4ojA?=
 =?us-ascii?Q?5LbJ3J7HIw3YwAwjb7y0LeugUau/Ji2kbUHUoV97Zo8Bxohspc1yVs6rWQk0?=
 =?us-ascii?Q?W8plNt2O+pXGCsp4ZOqyESwnTlSrKTalPuMXnacVOAuRxDS5lzcDuADU9fMY?=
 =?us-ascii?Q?RWxDIR5VRr4f27B4lc8dRqF2mzawkrvDqcNQFDwTWtTyPZ7rWJeIAgMfU4Iy?=
 =?us-ascii?Q?IDzrJhwWeyvOuAPfDWxZknX9rI71ow4vT0swG/vQ7lrTuqWZRX1ppB9Fy5xJ?=
 =?us-ascii?Q?zFlGqu8lN2O921D6blUhBbGdzcLWhXicb/RSqip1dFaDI2jaxhCaQ85a6Ist?=
 =?us-ascii?Q?nSU1kVbt3pZi7AKrTCu5GTIbpwhPj+f1SohGdzfdbkcGDeSVnNjCGn/1xkQO?=
 =?us-ascii?Q?hNqmLox0Pa66cDLLOSr0GBCrD4hviz6mraMVDWw7sc5QpJyWBjL13KmmKJlD?=
 =?us-ascii?Q?hLIEAn5Nh/RMnMDVse8Gq0pvsW4S0nMlDIEWPyuStLX6+J85bZi4ZlK0Xovo?=
 =?us-ascii?Q?66tlErVQXv4fvCRjxXuLl0MEaw0FWxnFCz8l+fd58Jtx2YAgv/HFgQoLo9ev?=
 =?us-ascii?Q?fINSrdVoLF/ZTfhI/AU5675LefcgZogCQ6Sw10sf39O0MsqG5NyGymz5T8UR?=
 =?us-ascii?Q?7zyQjahYyeyM/WEK3ds6YuOUllB/m+4dzZmb+aag3yAiJTfRb7NhfAKOu3Hr?=
 =?us-ascii?Q?cslEQp6KQ570bAWAS+yNuLNn8KzkLBOkeaKEHnhXRsUlsuP+X2EKa3CeasxK?=
 =?us-ascii?Q?DJ8dMKQqS9bRCKFwAX6sKQLxVrj045bs4Wv5VooVtpdWbgvlFQtm3GknEh9l?=
 =?us-ascii?Q?Rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8BC3C28D38851A4AAAE2A10B7C9DE2F0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: a5/w0xMsKMCebSsxP2XLs8STpfGn272QS//qveMByPettXZQB4L4mSRd2aiUY0H81GOSrkMkauzfyOcH81QBR8m1Dqcf8A6UcvPGgiF/CmXzG9dmb8XKtKchY8v8pLjPYh9zMvZNakCeKZYxqy6akTwE9Frx0zYsOchnmvsGlws+S+CVUhqjAv6gK23c+13BsVXm2CWw0tdNbsEX4In6AIs0rDWkms95wEvW3MM5f4chQLjw5G8TNnWdAYLAccaJTmdoPVKijOpL2vqZyU+/CLmDhlQl1MyDVp42vMS55uabtrOxPYxslAPHoaVjVKwX6jqOnhnpXnxnHk7LqvQ8SvCqDqWzJHCfMT1YuyuK6ludz4aToOBs68Pcf1eU1kaUZuYDor5Zda8ZkBFWvbnziKtbO4d66WColL9RquJ4dBv7hazxVy+sWWscDCp2n/AIqX3gAMlaQ8lEJpvyks8ztiH8F4Sk0KWfFg8RRkBKVC+Lo48/BQXdmKpzIF9cossCmuaMHAYtawJit7eKN+PjNQ2MITQusl30J5/jO1FQPQkhI3jpEEs3FJhOup6X5I6mGR5REu4Mz9PWHmFI7sqyO7bFPkzdzV75cdwt8WZthwWsECsS6LUSd4F2PbOptmlmDRhnKvfM8OmserpzfFFa4A0Uvtu+2Pg0VX15PXmmRa1yxNZZDGOz4rUlmdIYnYVMjpiRbLhWXJedbgpzsYpYiBAi1ZqOB9317fJqThJ4N6mmr4iytbfSFZzq3AqG0LxfEBi4nfIfDw9+7CoPXy6PC/ozajJQIv8+6gqjYJZHhA0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474aa8e9-aaa8-49b0-cb60-08db3d14fe82
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 18:20:58.1435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QJYxx6R6wnVGq5vxllPL4764mG0MKSm3VmUMlTDJNKmpWt91HiyMOiIKA+CdVSHwrv2xNdCwMQi49hNfM9xWEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4432
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_10,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140162
X-Proofpoint-ORIG-GUID: rY_erF1zU0S_9QArJCB_oQqTrQFmm-g9
X-Proofpoint-GUID: rY_erF1zU0S_9QArJCB_oQqTrQFmm-g9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jan 18, 2023, at 12:31 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> When queueing a dispose list to the appropriate "freeme" lists, it
> pointlessly queues the objects one at a time to an intermediate list.
>=20
> Remove a few helpers and just open code a list_move to make it more
> clear and efficient. Better document the resulting functions with
> kerneldoc comments.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 63 +++++++++++++++------------------------------
> 1 file changed, 21 insertions(+), 42 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 58ac93e7e680..a2bc4bd90b9a 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -513,49 +513,25 @@ nfsd_file_dispose_list(struct list_head *dispose)
> }
> }
>=20
> -static void
> -nfsd_file_list_remove_disposal(struct list_head *dst,
> - struct nfsd_fcache_disposal *l)
> -{
> - spin_lock(&l->lock);
> - list_splice_init(&l->freeme, dst);
> - spin_unlock(&l->lock);
> -}
> -
> -static void
> -nfsd_file_list_add_disposal(struct list_head *files, struct net *net)
> -{
> - struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> - struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> -
> - spin_lock(&l->lock);
> - list_splice_tail_init(files, &l->freeme);
> - spin_unlock(&l->lock);
> - queue_work(nfsd_filecache_wq, &l->work);
> -}
> -
> -static void
> -nfsd_file_list_add_pernet(struct list_head *dst, struct list_head *src,
> - struct net *net)
> -{
> - struct nfsd_file *nf, *tmp;
> -
> - list_for_each_entry_safe(nf, tmp, src, nf_lru) {
> - if (nf->nf_net =3D=3D net)
> - list_move_tail(&nf->nf_lru, dst);
> - }
> -}
> -
> +/**
> + * nfsd_file_dispose_list_delayed - move list of dead files to net's fre=
eme list
> + * @dispose: list of nfsd_files to be disposed
> + *
> + * Transfers each file to the "freeme" list for its nfsd_net, to eventua=
lly
> + * be disposed of by the per-net garbage collector.
> + */
> static void
> nfsd_file_dispose_list_delayed(struct list_head *dispose)
> {
> - LIST_HEAD(list);
> - struct nfsd_file *nf;
> -
> while(!list_empty(dispose)) {
> - nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> - nfsd_file_list_add_pernet(&list, dispose, nf->nf_net);
> - nfsd_file_list_add_disposal(&list, nf->nf_net);
> + struct nfsd_file *nf =3D list_first_entry(dispose,
> + struct nfsd_file, nf_lru);
> + struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
> + struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> +
> + spin_lock(&l->lock);
> + list_move_tail(&nf->nf_lru, &l->freeme);
> + spin_unlock(&l->lock);
> }
> }
>=20
> @@ -765,8 +741,8 @@ nfsd_file_close_inode_sync(struct inode *inode)
>  * nfsd_file_delayed_close - close unused nfsd_files
>  * @work: dummy
>  *
> - * Walk the LRU list and destroy any entries that have not been used sin=
ce
> - * the last scan.
> + * Scrape the freeme list for this nfsd_net, and then dispose of them
> + * all.
>  */
> static void
> nfsd_file_delayed_close(struct work_struct *work)
> @@ -775,7 +751,10 @@ nfsd_file_delayed_close(struct work_struct *work)
> struct nfsd_fcache_disposal *l =3D container_of(work,
> struct nfsd_fcache_disposal, work);
>=20
> - nfsd_file_list_remove_disposal(&head, l);
> + spin_lock(&l->lock);
> + list_splice_init(&l->freeme, &head);
> + spin_unlock(&l->lock);
> +
> nfsd_file_dispose_list(&head);
> }

Hey Jeff -

After applying this one, tmpfs exports appear to leak space,
even after all files and directories are deleted. Eventually
the filesystem is "full" -- modifying operations return ENOSPC
but removing files doesn't recover the used space.

Can you have a look at this?


--
Chuck Lever


