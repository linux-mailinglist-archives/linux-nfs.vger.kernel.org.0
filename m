Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9EE747512
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jul 2023 17:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjGDPPJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jul 2023 11:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjGDPPI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Jul 2023 11:15:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CC410CF
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jul 2023 08:15:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 364EibX8001580;
        Tue, 4 Jul 2023 15:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aC77SWgB1UtlSpHBG5lULVdZlUS0TNt7VL57iW9ZXoA=;
 b=w6b7Jp67PDDXkM8t7qqRInRV1UdYHxd7o0uPo18sCtmZbassoPnbsi8I2RccjcpP7vH1
 R0Q/HtHEsbios3mrretbL5RvsoMpU4hUwi5Iv6lfs0E+ph8WYHo448ie6piIsNHxowvr
 u/05T8jqwA4MuenydKL9SkFyrpTCSVw0GHrVDQPZEarC2MPwOtPlpDnIPpA59VazDGB6
 icTCnybN6owgAIzjf4aD8FlcStlHghq3eci8o6qq/TA+LFZiNari+p+5YwgDaNx7CbjG
 0IG5pRfyQscM48vKsJECr/thoXGzwEeIfqILjd+45wgDhqNwDIO8SuEz+Cll9GKIjjYI SA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjcpucr5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 15:14:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 364EDLCX020781;
        Tue, 4 Jul 2023 15:14:53 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak4hg4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 15:14:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqkYqF6X7H25uryKZa/3zZdm19du1c4a2MJdc25aUYBIrPKR3KdxwnpzoLmBqiiJ3HPnQ/DTD5zSsxsemWcNOP8OxeWRTtI2L166OqARGD+NRgZkZkIZ1ZT1EXWldw+0F7DPej5W3TeTkMFCfm+RjP/8ZUuERZniNe5YSVo30FGyqicGhz6u/JXZ7puXnPEurK1z/rIfmeAz94iX0zugTvwOV8g4oRtvmlximylYFh3ncnxosmbh0OYjJCKiJNfxkDup6hZVsiddry21Kb6A+4ICE3706gJ0he2+a/3ZvJI/wMtftT94oKqSR3e11pfn23m4h9TOIyHb5lWFpdUlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aC77SWgB1UtlSpHBG5lULVdZlUS0TNt7VL57iW9ZXoA=;
 b=XDffEkQTpTYxAxpm7+O5LdbxGTKu9T3VuxBQQXcC6fqGXQ2CSrLS4J8g9sQrVp8+8WWenjT0+quC2L/0FlF4MyMCsevXtZ7AthWML9bA4VEuP2om/rxJBkgnMXUoCxKoK29bg1UEOiAZ5v2IbDixIIIqmjLXOmW/54Xwq+gTgZOhbWAGQKDS0kbLruRoAZU6lME7obijgqPUQ3Pm9+VNQJJeLUJQy0LnLmlsqNLEttwnaFfJgTCbdgg2orFUW64yM3ylb2AjrvmslfoKX2RQoHaVWxEiAZkMGdrQ0ef0/9QejOkcVDlIxOyYsHDRVfxJ1hDLgzA3AaINBX/w6IDQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC77SWgB1UtlSpHBG5lULVdZlUS0TNt7VL57iW9ZXoA=;
 b=gJjb8FX41CxTWv4IYrVxmYE8x5r1YTM1pJGnKGIGmqAFaq1atayhmQEWswqMz//WND8ezF7dFZIjZ9Q5VPkZTU06r4KxPVF3fYwXeghz7ADQajdeIAtTf1ahkhVcIUyvRewj1Kg3fCxobzeAAqzR6I5xTBJQOcoZYTgPrHR/LeE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6628.namprd10.prod.outlook.com (2603:10b6:510:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 15:14:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6565.016; Tue, 4 Jul 2023
 15:14:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v2 9/9] SUNRPC: Convert RQ_BUSY into a per-pool bitmap
Thread-Topic: [PATCH v2 9/9] SUNRPC: Convert RQ_BUSY into a per-pool bitmap
Thread-Index: AQHZrgusqLNMAUbTHEe6lx14EU8vTa+o0P0AgAAKLACAAAQbAIAA2SeA
Date:   Tue, 4 Jul 2023 15:14:51 +0000
Message-ID: <5A969052-0872-4C04-AE8C-C989B54A9CEB@oracle.com>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
 <168842930872.139194.10164846167275218299.stgit@manet.1015granger.net>
 <168843398253.8939.16982425023664424215@noble.neil.brown.name>
 <ZKN9xmRn+EN/TQwY@manet.1015granger.net>
 <168843704829.8939.9406594114602623376@noble.neil.brown.name>
In-Reply-To: <168843704829.8939.9406594114602623376@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6628:EE_
x-ms-office365-filtering-correlation-id: a7efb5ac-7bed-4246-538e-08db7ca16a1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /efLR4vj4100RucU5rBgThmaYOiab8HZM8V7MYn+qzss2j748iOVaMhQvRDLW2KnhNH70MIWAOkX8eQtta0U9ZnOJ+fMHXyCkK6QgIEacFbhhCzQcaYhix7tJA6qPRuEPbIJN8QfPpYxdi9H4ldqT0jQtvJN77tK/ih4K+sWXNc5Pfn3F7XmYtXM25QTUiJEyFTNjW/2rKSv7yQzfLEz5RU3yCQSLRr49vec7z7FgByR9aLXK93+nPmc8yJaBX8VYS2weogBT1IB0JwEI8aVjk/GxPNYQ3Dvwk+6l4z0ah8cE4Q9CWSaH52Nk6FrlwAeayhMGT5h1NT81lsRNoxhnxh4F9PiXmFSbLmVOkW1VrdbcNdM2Q/CX9aY/AXJmnrd0k/1nOwtBVUhinbrRCJJXZ94IuN9yoz3NSf9YXSJ81TCIsE9wSm44fNGf19nr38KObHsGBHa00Ruh8Z8rLUzYL62s84FKuJqVD2ENH6rjKH5tnuYQyDUTc/qb7uEUBrPYzaVx87N6oyqTH4nVMwhz7/5PRXumk79NWMWRuyojiCGq1W1dK4M507Bf+joPoT4YAtf41p3bHTFNOv6OuFugJHi1VLTxTihNBjZCiH9j0b89jb3CSSg9sYcd4guZKh1DIq/Wz1IlCU8qubzKGPyrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(66556008)(66946007)(64756008)(4326008)(36756003)(76116006)(66476007)(66446008)(478600001)(316002)(2906002)(8676002)(33656002)(6916009)(91956017)(8936002)(5660300002)(66899021)(41300700001)(54906003)(86362001)(6486002)(6512007)(38070700005)(38100700002)(53546011)(6506007)(26005)(186003)(2616005)(71200400001)(122000001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hq/WvqxUfdeY1IipbYLGOgrbZSP3qnkGzZiG7S4f5JkR+kdMnfQlYcu3wHx5?=
 =?us-ascii?Q?Rfx2PVu3LNhdfN6X7QMd0magSlYXd9eAsb9SYl7G0JjdlKpsYd/xsS6osybK?=
 =?us-ascii?Q?QNjdwAdwXlrmDGkahGfWQpQFqDtrasQ6XDetfaKteUQt6tEKa/PlW5Uid7EK?=
 =?us-ascii?Q?8HQRCmOZETjuD06tdywvg3rBP4U+6EMon4UKHkecMgKzm9qF3wK4f/6kLspX?=
 =?us-ascii?Q?R8XjBZ+nBxdWTYhO2W1vJwSnTBCxhYaENyCZl58nhxfk5p+q8Y8wMGbZXGok?=
 =?us-ascii?Q?dwVe+A8xgcQAEuuJGAEnKRrFuwm2m6SIQr2G8QahRX0eUasSlh9MIdIEWX78?=
 =?us-ascii?Q?HMFWoJyDnnQKitQscw96io6VWWV2c6ti7IBAyRQSyMEh0uVOqtuPCrU47H2i?=
 =?us-ascii?Q?+4SQKUQFPms0m17cIwMPMPzQ24tIR8X8NmZidwNTDAKAKAiMIPYoMuzCpG/J?=
 =?us-ascii?Q?f/NwfP9NoClb4HJ1sTOJKvQdNOHCh6nbl5kBLJFmiM+/13rGMvzLLAuJp+EG?=
 =?us-ascii?Q?NPWEBPoO9mcaUwG3ovWkPBxJ9DT3ronY/wqlmLaSsEfDyBzO/JgetflrFsdM?=
 =?us-ascii?Q?cIvwgJvp2Q/oWaVQz6KuKC3x/WiD5hLbIq9WMO+SNh0rD4Y2scIDdrguXozH?=
 =?us-ascii?Q?BeoI4brVt7bTu3vVYSBHzqe8f1z1Ig5whgrI3DCOIMXyp2+jPebKDX893Jt+?=
 =?us-ascii?Q?FV7UgYAnOtl5chasLIa+H0G49DyVmRdAe+5zVhxigTPVmEKQqLXpYP1plFN0?=
 =?us-ascii?Q?JnXM0KgabLe0jGMKF0Mhgs3JEv0+68O1Z3HvwK2M1iZoHfMPrtEUlw/KtsjU?=
 =?us-ascii?Q?0pnJRJFuO4kmmB8n+IthRU0tmAB74AaFXkS5QAOaBleGawjirI0abBDk1Cwi?=
 =?us-ascii?Q?kqr5u1qV+50gaaFBtjIHTyaXfRdMK4LMNan47VXGOPBW9kapIZgwC+xtiVYY?=
 =?us-ascii?Q?8RzzV0cE9hOW1WD5fc6AUWnp4Y8GgesSQZnXueZeA0hRpDRlSE1L5yqkXNk2?=
 =?us-ascii?Q?vC2mFeakG5uPBZy0aNe8CvFehvDDBdUOGNmbCavMzzeXJpwdwdcAD08OTl2F?=
 =?us-ascii?Q?X/d7LeCcJHlQajFb1pa/3bt5eXTOZ6CY1Q60jgu92yKaINQvCGsF9xYKTNHY?=
 =?us-ascii?Q?ZW/vfosqH0jO82aMHr+pQBp8eSGOmicO8G6BYirzU7RaT6nacMgY3v+R0tTC?=
 =?us-ascii?Q?9TdhNlr/b3XPF287YEJN0zwafZRwrjDVxi96RXDYRfgs9nPJGzEDa0UVvOZR?=
 =?us-ascii?Q?Fs6ZCdgBmd5Avlmrggwx0ZANIx5TUUc1FqSRdPhr6Z0JG0qKmBszFmHbfKRV?=
 =?us-ascii?Q?nBWgJEUJBcrGx/wt5lZN+afPjHufjgHaQy4wtKdBxGV5cTMFUyhUmwb9xGVN?=
 =?us-ascii?Q?SUi9Fa4NB1yCvkx5yp/QovV2Vn/u8Jb66YALgRfNiT+VSjnEsyZEjSJZY0Dx?=
 =?us-ascii?Q?B5VHd5KtW0M1QFKfQ1JW8swVyxro2zKuBOMYjEtOEoFuxn0ZYEpfJ4yDV0Nq?=
 =?us-ascii?Q?b7s7qWiIB1uasV2ie1XaGjZdtMmlr3n0Q/v7NTFVB6UYZpXf1tLiYhFar53n?=
 =?us-ascii?Q?xHJG3IuRJQVHoz2rN0GeUM2f1wRQCU0GmIms8DIvWpGhrzQYGJDowOvttOsF?=
 =?us-ascii?Q?oQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3924D4A21F0A4C49A09E3BADA76EB473@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4yacMXVfCHs1OOI5eCI267hCH0lg+gU43KnKu1mosbEiPrt5IMDl914zDAiWvyIVnN5eYpuDdgbbsMQoRVC0qz9QRdQLd0cb1lZOiilTpnH68TtTerz92XO3xQzuNPKjUNp6D87nf6rCAQfkxXt8emvNnrvmtLr71fK/D6bc9UAVqEC7ndELKPXopmzDorwDZTYiQoLO/ZkCQBodoqkxpkAKXLjQJ9tntZ9rKOBjrKqJzYSl8Psd8QepI/v58g/EROjbP1/5WVkH0hJ4s3Rz/7SqEyTTMBZPXsHG1PWTfOaoR3hFUtgOq3kv+bV/zX+zjZNoj8NMdrHaWx7FO7tgeeNJVUDrU48yAIOAbP0Exb+gWUGMqqjS/AZcsgICSuzaN2fXicdsD+4fIpueCfHTsZAe2gOm4/UOgVjni09YcZnGp9UyP1N+8K8dsL0I2lyM+KPx9ok6bzSRJKxTXNiSWa5QsOP/kzV4czZxJ7hdeyQwD9LokIbdVwgS4DPSD7gN2IReQO4+tsoZ3o9WkTOheJuGB/UH7MXbQE16LpTKQEZDUF568UhaWlAazuT+QCXzerGFLvfYLTLIt6MTFpzQNpaeX9/SLAogTyH9Wem46VqdGU6Dt/kbYN97Bz1JfjKQx5QergU2BOj7bsds/DX5GVCl6LaSu7rMr/NrIq/foQJeP6wdP+sR6GoJxX1TEa3t7EYDt305W2tAIFX/J1nYF7GFjnNcleSheUJJ30+0RhqTYXYAVkwvcHCUOnAaTKJ2S19xqNDNGyexJ2ip/XHgZtDhKX/gRqt4VRgys+8eVspnri4ovnJ13U6qBLnPqSx5gmcc4lGg7WQaVSRni20Ca/ShPqiiusv7HCcKcVJA6sRKLCwHZtyipt2KNd1rdcN6
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7efb5ac-7bed-4246-538e-08db7ca16a1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 15:14:51.4748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ev4A++W8WuVhaZKgpVbX/3yJmgGEtNuVelhbcRDLGpYL9gvEBRD7dndZe66ljAg0SVhCP5Nyfqvu+I/MC8Tvzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_10,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307040131
X-Proofpoint-ORIG-GUID: NoyhTiLHNacYYqh2deGu8v5cL0cgsKqc
X-Proofpoint-GUID: NoyhTiLHNacYYqh2deGu8v5cL0cgsKqc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 3, 2023, at 10:17 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 04 Jul 2023, Chuck Lever wrote:
>> On Tue, Jul 04, 2023 at 11:26:22AM +1000, NeilBrown wrote:
>>> On Tue, 04 Jul 2023, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>=20
>>>> I've noticed that client-observed server request latency goes up
>>>> simply when the nfsd thread count is increased.
>>>>=20
>>>> List walking is known to be memory-inefficient. On a busy server
>>>> with many threads, enqueuing a transport will walk the "all threads"
>>>> list quite frequently. This also pulls in the cache lines for some
>>>> hot fields in each svc_rqst (namely, rq_flags).
>>>=20
>>> I think this text could usefully be re-written.  By this point in the
>>> series we aren't list walking.
>>>=20
>>> I'd also be curious to know what latency different you get for just thi=
s
>>> change.
>>=20
>> Not much of a latency difference at lower thread counts.
>>=20
>> The difference I notice is that with the spinlock version of
>> pool_wake_idle_thread, there is significant lock contention as
>> the thread count increases, and the throughput result of my fio
>> test is lower (outside the result variance).
>>=20
>>=20
>>>> The svc_xprt_enqueue() call that concerns me most is the one in
>>>> svc_rdma_wc_receive(), which is single-threaded per CQ. Slowing
>>>> down completion handling limits the total throughput per RDMA
>>>> connection.
>>>>=20
>>>> So, avoid walking the "all threads" list to find an idle thread to
>>>> wake. Instead, set up an idle bitmap and use find_next_bit, which
>>>> should work the same way as RQ_BUSY but it will touch only the
>>>> cachelines that the bitmap is in. Stick with atomic bit operations
>>>> to avoid taking the pool lock.
>>>>=20
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>> include/linux/sunrpc/svc.h    |    6 ++++--
>>>> include/trace/events/sunrpc.h |    1 -
>>>> net/sunrpc/svc.c              |   27 +++++++++++++++++++++------
>>>> net/sunrpc/svc_xprt.c         |   30 ++++++++++++++++++++++++------
>>>> 4 files changed, 49 insertions(+), 15 deletions(-)
>>>>=20
>>>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>>>> index 6f8bfcd44250..27ffcf7371d0 100644
>>>> --- a/include/linux/sunrpc/svc.h
>>>> +++ b/include/linux/sunrpc/svc.h
>>>> @@ -35,6 +35,7 @@ struct svc_pool {
>>>> spinlock_t sp_lock; /* protects sp_sockets */
>>>> struct list_head sp_sockets; /* pending sockets */
>>>> unsigned int sp_nrthreads; /* # of threads in pool */
>>>> + unsigned long *sp_idle_map; /* idle threads */
>>>> struct xarray sp_thread_xa;
>>>>=20
>>>> /* statistics on pool operation */
>>>> @@ -190,6 +191,8 @@ extern u32 svc_max_payload(const struct svc_rqst *=
rqstp);
>>>> #define RPCSVC_MAXPAGES ((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
>>>> + 2 + 1)
>>>>=20
>>>> +#define RPCSVC_MAXPOOLTHREADS (4096)
>>>> +
>>>> /*
>>>>  * The context of a single thread, including the request currently bei=
ng
>>>>  * processed.
>>>> @@ -239,8 +242,7 @@ struct svc_rqst {
>>>> #define RQ_SPLICE_OK (4) /* turned off in gss privacy
>>>> * to prevent encrypting page
>>>> * cache pages */
>>>> -#define RQ_BUSY (5) /* request is busy */
>>>> -#define RQ_DATA (6) /* request has data */
>>>> +#define RQ_DATA (5) /* request has data */
>>>=20
>>> Might this be a good opportunity to convert this to an enum ??
>>>=20
>>>> unsigned long rq_flags; /* flags field */
>>>> u32 rq_thread_id; /* xarray index */
>>>> ktime_t rq_qtime; /* enqueue time */
>>>> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunr=
pc.h
>>>> index ea43c6059bdb..c07824a254bf 100644
>>>> --- a/include/trace/events/sunrpc.h
>>>> +++ b/include/trace/events/sunrpc.h
>>>> @@ -1676,7 +1676,6 @@ DEFINE_SVCXDRBUF_EVENT(sendto);
>>>> svc_rqst_flag(USEDEFERRAL) \
>>>> svc_rqst_flag(DROPME) \
>>>> svc_rqst_flag(SPLICE_OK) \
>>>> - svc_rqst_flag(BUSY) \
>>>> svc_rqst_flag_end(DATA)
>>>>=20
>>>> #undef svc_rqst_flag
>>>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>>>> index ef350f0d8925..d0278e5190ba 100644
>>>> --- a/net/sunrpc/svc.c
>>>> +++ b/net/sunrpc/svc.c
>>>> @@ -509,6 +509,12 @@ __svc_create(struct svc_program *prog, unsigned i=
nt bufsize, int npools,
>>>> INIT_LIST_HEAD(&pool->sp_sockets);
>>>> spin_lock_init(&pool->sp_lock);
>>>> xa_init_flags(&pool->sp_thread_xa, XA_FLAGS_ALLOC);
>>>> + /* All threads initially marked "busy" */
>>>> + pool->sp_idle_map =3D
>>>> + bitmap_zalloc_node(RPCSVC_MAXPOOLTHREADS, GFP_KERNEL,
>>>> +   svc_pool_map_get_node(i));
>>>> + if (!pool->sp_idle_map)
>>>> + return NULL;
>>>>=20
>>>> percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
>>>> percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
>>>> @@ -596,6 +602,8 @@ svc_destroy(struct kref *ref)
>>>> percpu_counter_destroy(&pool->sp_threads_starved);
>>>>=20
>>>> xa_destroy(&pool->sp_thread_xa);
>>>> + bitmap_free(pool->sp_idle_map);
>>>> + pool->sp_idle_map =3D NULL;
>>>> }
>>>> kfree(serv->sv_pools);
>>>> kfree(serv);
>>>> @@ -647,7 +655,6 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_p=
ool *pool, int node)
>>>>=20
>>>> folio_batch_init(&rqstp->rq_fbatch);
>>>>=20
>>>> - __set_bit(RQ_BUSY, &rqstp->rq_flags);
>>>> rqstp->rq_server =3D serv;
>>>> rqstp->rq_pool =3D pool;
>>>>=20
>>>> @@ -677,7 +684,7 @@ static struct svc_rqst *
>>>> svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int n=
ode)
>>>> {
>>>> static const struct xa_limit limit =3D {
>>>> - .max =3D U32_MAX,
>>>> + .max =3D RPCSVC_MAXPOOLTHREADS,
>>>> };
>>>> struct svc_rqst *rqstp;
>>>> int ret;
>>>> @@ -722,12 +729,19 @@ struct svc_rqst *svc_pool_wake_idle_thread(struc=
t svc_serv *serv,
>>>>   struct svc_pool *pool)
>>>> {
>>>> struct svc_rqst *rqstp;
>>>> - unsigned long index;
>>>> + unsigned long bit;
>>>>=20
>>>> - xa_for_each(&pool->sp_thread_xa, index, rqstp) {
>>>> - if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags))
>>>> + /* Check the pool's idle bitmap locklessly so that multiple
>>>> + * idle searches can proceed concurrently.
>>>> + */
>>>> + for_each_set_bit(bit, pool->sp_idle_map, pool->sp_nrthreads) {
>>>> + if (!test_and_clear_bit(bit, pool->sp_idle_map))
>>>> continue;
>>>=20
>>> I would really rather the map was "sp_busy_map". (initialised with bitm=
ap_fill())
>>> Then you could "test_and_set_bit_lock()" and later "clear_bit_unlock()"
>>> and so get all the required memory barriers.
>>> What we are doing here is locking a particular thread for a task, so
>>> "lock" is an appropriate description of what is happening.
>>> See also svc_pool_thread_mark_* below.
>>>=20
>>>>=20
>>>> + rqstp =3D xa_load(&pool->sp_thread_xa, bit);
>>>> + if (!rqstp)
>>>> + break;
>>>> +
>>>> WRITE_ONCE(rqstp->rq_qtime, ktime_get());
>>>> wake_up_process(rqstp->rq_task);
>>>> percpu_counter_inc(&pool->sp_threads_woken);
>>>> @@ -767,7 +781,8 @@ svc_pool_victim(struct svc_serv *serv, struct svc_=
pool *pool, unsigned int *stat
>>>> }
>>>>=20
>>>> found_pool:
>>>> - rqstp =3D xa_find(&pool->sp_thread_xa, &zero, U32_MAX, XA_PRESENT);
>>>> + rqstp =3D xa_find(&pool->sp_thread_xa, &zero, RPCSVC_MAXPOOLTHREADS,
>>>> + XA_PRESENT);
>>>> if (rqstp) {
>>>> __xa_erase(&pool->sp_thread_xa, rqstp->rq_thread_id);
>>>> task =3D rqstp->rq_task;
>>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>>>> index 7709120b45c1..2844b32c16ea 100644
>>>> --- a/net/sunrpc/svc_xprt.c
>>>> +++ b/net/sunrpc/svc_xprt.c
>>>> @@ -735,6 +735,25 @@ rqst_should_sleep(struct svc_rqst *rqstp)
>>>> return true;
>>>> }
>>>>=20
>>>> +static void svc_pool_thread_mark_idle(struct svc_pool *pool,
>>>> +      struct svc_rqst *rqstp)
>>>> +{
>>>> + smp_mb__before_atomic();
>>>> + set_bit(rqstp->rq_thread_id, pool->sp_idle_map);
>>>> + smp_mb__after_atomic();
>>>> +}
>>>=20
>>> There memory barriers above and below bother me.  There is no comment
>>> telling me what they are protecting against.
>>> I would rather svc_pool_thread_mark_idle - which unlocks the thread -
>>> were
>>>=20
>>>    clear_bit_unlock(rqstp->rq_thread_id, pool->sp_busy_map);
>>>=20
>>> and  that svc_pool_thread_mark_busy were
>>>=20
>>>   test_and_set_bit_lock(rqstp->rq_thread_id, pool->sp_busy_map);
>>>=20
>>> Then it would be more obvious what was happening.
>>=20
>> Not obvious to me, but that's very likely because I'm not clear what
>> clear_bit_unlock() does. :-)
>=20
> In general, any "lock" operation (mutex, spin, whatever) is (and must
> be) and "acquire" type operations which imposes a memory barrier so that
> read requests *after* the lock cannot be satisfied with data from
> *before* the lock.  The read must access data after the lock.
> Conversely any "unlock" operations is a "release" type operation which
> imposes a memory barrier so that any write request *before* the unlock
> must not be delayed until *after* the unlock.  The write must complete
> before the unlock.
>=20
> This is exactly what you would expect of locking - it creates a closed
> code region that is properly ordered w.r.t comparable closed regions.
>=20
> test_and_set_bit_lock() and clear_bit_unlock() provide these expected
> semantics for bit operations.

Your explanation is more clear than what I read in Documentation/atomic*
so thanks. I feel a little more armed to make good use of it.


> New code should (almost?) never have explicit memory barriers like
> smp_mb__after_atomic().
> It should use one of the many APIs with _acquire or _release suffixes,
> or with the more explicit _lock or _unlock.

Out of curiosity, is "should never have explicit memory barriers"
documented somewhere? I've been accused of skimming when I read, so
I might have missed it.


--
Chuck Lever


