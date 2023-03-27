Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5216CA5FA
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Mar 2023 15:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjC0NcS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Mar 2023 09:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjC0NcR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Mar 2023 09:32:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C902689
        for <linux-nfs@vger.kernel.org>; Mon, 27 Mar 2023 06:32:16 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RDUSsv015549;
        Mon, 27 Mar 2023 13:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=D2UzFNqAzeVrXNl/t50a2QDxqiBloxEK37H4bD/GEDc=;
 b=aml6ITb+XZoqaHt4//LjtibsgwUN47Msd605Sva1ENGNN87l/XOFWwwN/+0H0wkDblto
 4+bGj7s6qmgRzB9tMwsUDVsYj9iyN122KEReQpffrKVH1YwHGoRGLkHEH+TUiT5azkcc
 WvkiZe6ge1wXi217ci1UydLkT8hmoYH3Zv8Fa7hCR9SJxXa2JMqQ6HNcI/MSwJ944U/i
 DFXK8o8YIQZLdgXtqKaMI/6k5rnlZYKW4aW6rKHNPVX0YaIlYlWMqNl9KDe5chiftSqZ
 m6qNZrENm+c5fjLwjKB9PmUZD/hP//vFe6oTMcLL8g8RcALY056+1VkautbvxUbXPq3N 7Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pkc2pg0fg-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 13:32:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32RDAiWn005401;
        Mon, 27 Mar 2023 13:14:37 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd4qpwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 13:14:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OU+D6tdjPX1pbsvgikGJ07bzOQRdB4AplvT570f3VKBj0t3BQLP0Hyxcyaf21dS37d/oUdsjTua4MBzs13e04nK9R2p5IRTdy0H+phgoSrR6yUJz04hDasBzOyB/AsMzCluNHH8Jv15uV/y5LeXPJplQpG7kDpgPd2nMV5Vb/9MGCJb4wHwVtj1T8tlyc2evZJ0FDvL/fzpbAWI0wEUTMMk5zyyUBT0Okngol/J3x8y7FSNY/IEtMMBUnJi1Glof7WLDJjPlfUCIkaCzo714URPq58DNMcXTcoNMVfLyPx1AYqWXW5noGWTpJZbYYX9SQ5D9cm3NdDDabVWhIPuQ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2UzFNqAzeVrXNl/t50a2QDxqiBloxEK37H4bD/GEDc=;
 b=j6F+TgNkERu3PTlvefIAuM+LTesDLKL1XbQoGoezfeGGfIxuYpytlK4PoyEb6V/XLXiI8tNK0oAKMqo0zkvChOPyGE3egKbqYaE7BdqCOQhg2vw07Wlqg/dNopLZf6VsEEvTiF3iANCM1kEpIHXuXL4rIbZR7mgHchWkrbuEiLCB0TPTpaLCuJmC7p0VziAnEPrXeN7uct2RYkYogaiA53LRVJQ+jZj6eu5gulTwXk8Jk08eN5lsR4FPGStCOpmJ5xIPQ8AT1cf++tXjiYj8xbfUzADMyB39lizsHilBPFbk7lzW4yRXJIWGHeLAbYHogLbmK68/mWdW5poCmWhFRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2UzFNqAzeVrXNl/t50a2QDxqiBloxEK37H4bD/GEDc=;
 b=Gh4mp7j1KP/A+8kjfQpLFUyjx05gsWBs/IFPMHk7O1vYcYahMH08ch0v9yMIcpr+f6FXBgvb444QZdsWuVxaRZtRyP+RGDy9BdBn5kfadrvyzWCKnwl7oHNPCBfJjuFL/H1oFOQb3FKJmtNZj95/FqBvIClj3xcSPQP85rwOVJM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5889.namprd10.prod.outlook.com (2603:10b6:a03:3ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 13:14:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6222.032; Mon, 27 Mar 2023
 13:14:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Zhi Li <yieli@redhat.com>
Subject: Re: [PATCH] nfsd: call op_release, even when op_func returns an error
Thread-Topic: [PATCH] nfsd: call op_release, even when op_func returns an
 error
Thread-Index: AQHZYJXx2NKl9PvYPUieoFYGsmlSLK8OmvcA
Date:   Mon, 27 Mar 2023 13:14:33 +0000
Message-ID: <C871117E-1591-4F1C-94DE-3854F88FF8FF@oracle.com>
References: <20230327102137.15412-1-jlayton@kernel.org>
In-Reply-To: <20230327102137.15412-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5889:EE_
x-ms-office365-filtering-correlation-id: 9786fba4-e958-4900-e350-08db2ec534d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f2BUalR6Gvqpj+RbWAPc0ioWOUaNiXUkq+kLZ9j5Qr23m4HVZ1MsrFAR4hVjEFMGgo1abCL2wIgbJj+WYrT5CZJERuHAlmmxXuHscI/smuiICduAXBLEDFF3Q19DQ8KY3yg0dewgAKpt4jTADwPxhswvgM+ZLzh4nFgBzNoSPnqMFTMgUuRvJydqSiueXATtN55yZdE8kv971AAgfBGbj0UvP2W+D+c0MEGMsSO32eSVFFshcOqlur1Cq83moVdsmMzW5o/vmutjFjVStJYV4nMUd4mAZ5U2SlPzJbjgD5ArvKuR7M1iqieRjmgjd2879wBbyCVs7yPi3k5yahDI6A4OjlQmfkvN0bs1xb5WN3GuyqIBCUogoAm3PZg/vwyssdNz7TjeYcXWpjFM5jyjxux/1MBRzB5tsEUUuWZmNGLO1ZrGSJfPDRqQU/BdPIFi+7WZ4wR5eCpLIa2B6LFdeN297NXrbOQaHhX+2N85uACl+sOh4neH9y6HBWztlOq4X5QockVmsDvSInyib0RRTCudIj7vynFLl8HfkOldG9W6XbHzPV7lhqO9TBmKKe9gvi1aNy9CeTeNf+b/KnFTVnXZHKXZdYh7i+NM3GfjQ2t5a2bIvpNwprL3Z5iM/Frx5w7WmMxKAnIrTiY4UlKHaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(76116006)(8676002)(4326008)(66446008)(66476007)(66556008)(6916009)(66946007)(64756008)(41300700001)(91956017)(36756003)(186003)(83380400001)(2906002)(5660300002)(38100700002)(38070700005)(86362001)(33656002)(122000001)(2616005)(478600001)(54906003)(966005)(71200400001)(8936002)(6506007)(6512007)(53546011)(26005)(6486002)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x+bLnDDogtkeQ2BeA9rF4m7Mn+rO07Az0lphrIkgN5pUCbE/pqavwhEEKYmY?=
 =?us-ascii?Q?nk/l4ZIu2uKGrltWmR4Rc+1U2/PNDwHmO6DSuVSv0beABasPIfezH+breSo/?=
 =?us-ascii?Q?Vy5q29u+YdxT4fDdGGPkzsU5zGoRgg1w8WteC4czxkeYujDFKwJY52/hmv1R?=
 =?us-ascii?Q?6VSu25CRRlLbIQzPwyBiywPG3D9n7iqk2eE5iNfErALQDZPUaEz94zHH5kdT?=
 =?us-ascii?Q?75N9HmkIZ7vrAg32h5ZP10nI9JFgj1B8YDZ4Frq4QiBwXj20v/1UBKkejsx8?=
 =?us-ascii?Q?LC6veXe5IxI315x0CMf7tsX0iMzbaNzOjfVfTt0Bv66qlM+sKSyoWuT5jcTN?=
 =?us-ascii?Q?dll7YwZNCaarIVinrPKikQalbWxXUpopyXuhy13g+yMERz4W/oDHsysDK3za?=
 =?us-ascii?Q?pCkAcLeOy0FJ8aEgts8fvwEPi+HeX6sQ9hXsGYuaHO2ehZlDN+Smb9YlzQJh?=
 =?us-ascii?Q?YKrsYftsPF7e8IP3AoPTtEzVB3VB60Juqi0yhgSHoBRcScHkj9vVc5uKF9F2?=
 =?us-ascii?Q?V15QPilhNap/Glsf2/sboANd1JMZBdEALgVxzICbKtGaTDi8mk+EIKDuVrMa?=
 =?us-ascii?Q?a35ac8B8ucqaWYPGib8wymZi02bkQfHMfphNuAUmbs9tDabGIiw15i53+PMc?=
 =?us-ascii?Q?O7OnBLx+ge7BmMlNEdTJK8nJR0l9GLqWbl8R85Ox3h26jVQaRcJh8LM4Tdre?=
 =?us-ascii?Q?uqnhtxhUpjvop6P7n1GP+H1o3L3A2ewg9cQpDvy7LRD//7Mnw/CGPD9m9qfr?=
 =?us-ascii?Q?y3dB9JTnh2SPYkzKWLQ6QFMJuBTet3nSgbM8PzuF9RZNgsoJEOIVMOnDL8G3?=
 =?us-ascii?Q?GeOfLi92nOmdWbLOZ61fxarlOfTn2OS0tNuv+KkdbCDnjBrPrirO47NgaoDH?=
 =?us-ascii?Q?AVBjhT9tbGiJRigT28vE44dXCU1kSYO+2y7scdd5Sjw7qcYB0xv4zdXduEl/?=
 =?us-ascii?Q?MCLTcJYv5FDpezPiVKev2rVhTlpEMExdxnbLGji0XIgGx0Y8+YPK2Z04/Jmt?=
 =?us-ascii?Q?YMBGf6uTPwGjIjgWhK2acXvE2+l+r6NFC9O754WuRQ53/feTNqOKmiKKRPwd?=
 =?us-ascii?Q?7z9LPEfhwgoPVACWeHB/TmxqDNIusraCRxytYEiETG2wk/ZjJe7bxgU0EKUH?=
 =?us-ascii?Q?i91LrYGqppJmkRGhvDvIzooIfSG54pl5W5LWGppNwGiIQaBM1jPR0EVCXoJv?=
 =?us-ascii?Q?l0UqAVbierbHZABJdNUJekyAlmt8R6vBFF6VYOBy3NW/fybWGGwvqWpXcN55?=
 =?us-ascii?Q?u35+mm/XkfiWbQ/fOE3XIL0rAaD3PW5QEsqMMJWaNPg2OYSBw+TD/Kv55d2r?=
 =?us-ascii?Q?VS5+TLQRGxJnJqxhuroiWp+q6ZKxcdBZVoA+xCsRs3iB8XgVbMbirgvuI6+m?=
 =?us-ascii?Q?hB+cug9MNEPOK75aOnRfFHmJ5d5ucGJpc0yA02xQgTyd7aSCo++Oh2lWadv1?=
 =?us-ascii?Q?3qhZ3CsR2JWRmyxL2s/10l5ConRm6kBBhyVmaSPGDHYp8veO5oGekw8EfSdJ?=
 =?us-ascii?Q?WuKScdgFiqfO/AOESeTt/D/g/Ub6LPCJoPbBEqBZZzStzjWLDA2h+ic1/JJg?=
 =?us-ascii?Q?nrW2rryjRk0pL45FPtG4x9JgRHg3nXH5nZXGlYEHx+BVhFk19ZY6xk1+gUPS?=
 =?us-ascii?Q?Mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3A559A31D4265C44B1200F77D61BD393@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Tn0cTUd5LXEEbi8FKsEAdtiAqAb76bmAkHEG9PcdruM8mo/JK2diASfRhaG8Wk1dR92LzdsXbeA/QVJqqWNDMGoSsdYZn0+PX3bW93kowByrSN74pEofaKz6WBzCe/CqvE/6sm7xUKiBbOYBDts8xjhrTVmZe8rStiEdn3JaBhRmHlFNolv/PiCF2xI5WflKT00WgYGpZqNa4ykqG6Kvj9u3OzDRMenxrSfjkOR3GIO47T3DEIo2rR9FZSneUrPxrYtO4nK9sFuCxGLhM4CgJRNwv9jRew2+5lX9t3WTtBxrUnf4ElSP+4e8J/KuUTTry0t+f3OnOowlR9yI6XMgBGnVKSCTP4K4jD0JfBiJ8R8Qm9QwDW55AB1zkC0lKpL5SsTVToHq6fEHnEK6zGVu0Qd/LqqjU5tY72+T+obe1haVgsye6msNoBzS1T9sfmeUWajfmDcdftek014T+MJL2UJOjEIF00iuOmfe8iUSR+9qnMy6dGB/aKieUZNFZ2aiqqA/KnogxRysDwVO6M0oPV3T7kFfZnX5knC8Yw0w9fvQDYkmJ+dtJxtvGR3EppSjaeTfv22P6CCehrQULcAHGy8Nq0JYo9fp9hJZyD5KL4YZ5UcmQ8EY2PhZ3m1tUvtQ7d6KlbXtruGEXy5+W91yXoItTJjNKFwroRFOpOboR/fUHdou10pJY6wvBh1YIr7mwN9DTRzbfdT8Lvxm1V3cqXmE7RyeLtp32YbcwHZnij8QYHQaASLKYZZiEagzufIYfjRAKm//M1+myKTz/OyyAVde450nduTuqm92Zt5rOl+t1Oh5E4xfqAs2Ix+KLs0t
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9786fba4-e958-4900-e350-08db2ec534d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 13:14:33.2887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abnGZoZLjdLvmLVOcEqP2fN/1EfNT3wHxWlKL3y03fzYsaF8eKfC1mHF3I1EchpqFLPVz16gAQekFH+8QP5qwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5889
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270104
X-Proofpoint-ORIG-GUID: eTK1lYpJ4fgpN-FPm7TTlIsUPc3_5uQr
X-Proofpoint-GUID: eTK1lYpJ4fgpN-FPm7TTlIsUPc3_5uQr
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 27, 2023, at 6:21 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> For ops with "trivial" replies, nfsd4_encode_operation will shortcut
> most of the encoding work and skip to just marshalling up the status.
> One of the things it skips is calling op_release. This could cause a
> memory leak in the layoutget codepath if there is an error at an
> inopportune time.
>=20
> Have the compound processing engine always call op_release, even when
> op_func sets an error in op->status. With this change, we also need
> nfsd4_block_get_device_info_scsi to set the gd_device pointer to NULL
> on error to avoid a double free.
>=20
> Reported-by: Zhi Li <yieli@redhat.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2181403
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Thanks, Jeff.

May I add: Fixes: 34b1744c91cc ("nfsd4: define ->op_release for
compound ops") ?


> ---
> fs/nfsd/blocklayout.c |  1 +
> fs/nfsd/nfs4xdr.c     | 13 +++++++------
> 2 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 04697f8dc37d..01d7fd108cf3 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -297,6 +297,7 @@ nfsd4_block_get_device_info_scsi(struct super_block *=
sb,
>=20
> out_free_dev:
> 	kfree(dev);
> +	gdp->gd_device =3D NULL;
> 	return ret;
> }
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index e12e5a4ad502..6b675fbdabd0 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -5402,7 +5402,7 @@ nfsd4_encode_operation(struct nfsd4_compoundres *re=
sp, struct nfsd4_op *op)
> 	p =3D xdr_reserve_space(xdr, 8);
> 	if (!p) {
> 		WARN_ON_ONCE(1);
> -		return;
> +		goto release;
> 	}
> 	*p++ =3D cpu_to_be32(op->opnum);
> 	post_err_offset =3D xdr->buf->len;
> @@ -5418,8 +5418,6 @@ nfsd4_encode_operation(struct nfsd4_compoundres *re=
sp, struct nfsd4_op *op)
> 	op->status =3D encoder(resp, op->status, &op->u);
> 	if (op->status)
> 		trace_nfsd_compound_encode_err(rqstp, op->opnum, op->status);
> -	if (opdesc && opdesc->op_release)
> -		opdesc->op_release(&op->u);
> 	xdr_commit_encode(xdr);
>=20
> 	/* nfsd4_check_resp_size guarantees enough room for error status */
> @@ -5460,11 +5458,14 @@ nfsd4_encode_operation(struct nfsd4_compoundres *=
resp, struct nfsd4_op *op)
> 	}
> status:
> 	*p =3D op->status;
> +release:
> +	if (opdesc && opdesc->op_release)
> +		opdesc->op_release(&op->u);
> }
>=20
> -/*=20
> - * Encode the reply stored in the stateowner reply cache=20
> - *=20
> +/*
> + * Encode the reply stored in the stateowner reply cache
> + *
>  * XDR note: do not encode rp->rp_buflen: the buffer contains the
>  * previously sent already encoded operation.
>  */
> --=20
> 2.39.2
>=20

--
Chuck Lever


