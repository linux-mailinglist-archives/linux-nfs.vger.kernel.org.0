Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C325364CC
	for <lists+linux-nfs@lfdr.de>; Fri, 27 May 2022 17:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343669AbiE0Piz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 May 2022 11:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbiE0Piy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 May 2022 11:38:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125E3106A4E;
        Fri, 27 May 2022 08:38:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RDYieQ000319;
        Fri, 27 May 2022 15:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=73xhr3EePLximL+H6iAeMQBIFdzuK7xBXLcozHGacCE=;
 b=K5NT+5XEk5xH+wAVlRQxdPGZZdGUlwpnQeXr0gF3FlOyWwaOeac6h03Bv/8OxHg9WZbf
 okyNTD6l4bEk1SRyr5dtFAD7gsHu4JOY16geXtyIJmzTeilR9MlOjmvPCbGzBvXafs7s
 s8My8yKs/kPagyiaEwgbJKL23J7R6FGZydEK8MaaU2I0iq6bniDpWbWdnDKfwVYpK/Y6
 hKpyfAFEDC7Mgs9TAsE3W0oyrYO1tAoO3Qjsn//qjBU4mfdG3I7W+mqpabcQidowo/z+
 3NcBFIoWrWfwZqplo84dj5WWo3TZJYPQIUAcne1D36J1FFlvTRamIYYgm77ckCg7ezFf oA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93taypxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 15:38:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24RFaf9Y013728;
        Fri, 27 May 2022 15:38:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93x7tp7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 15:38:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7maAzmtHwL4aywh6OwTlsVYKHgj2ntsR0Bu8WlI7PEsptBuDOkJYl2g4+RGQeQ8jDcS9LuJ8bVz+IJRF2PU5+3GPa1UxDiz9O7bWxIG834tx/1CSXd3xYSXUIbjPTZQ1fPpl8yzk4FDHJhRq0vY4xMbcYTY7RW17mSCHXnhbC6YWF+2tzqc6BGBaB9Z9cAKhZx3B9uMj3QHlP6P2twVmw7nx8jj6MygHOloI1ViHIbJ0Dpq4gkONkkSdmF2UKFtX21MsnKZW5aaaEHqIjlKgXH+veVNWik4Eelgyv+XQHY09s3iDEfBnR9BNAUenBiApTVOfeHC7YGrZoxFCiutDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73xhr3EePLximL+H6iAeMQBIFdzuK7xBXLcozHGacCE=;
 b=Zu+aMqT5NMF+IJqs94XuvvYZjpORHU9dOins6o1zNA7QXKJWQAos8NgCj/VjGm9vTb2sLMw5l1UcSC8BNHZ5qEwOsMnqgFpQJ96PvClQLowi+R22GwItue4pCMOlWNVhzOk5bN7QRo+pRNvxN0B4ZaT4SKeoC7T45RO3iOgeAREx0hs66Or/zXm/yMgeFhERHVGrTD4y8MAojyreVH6iyanB8UFOiSi9bnCqWXMUT7RypV5unuCOuEFhtlIpzBoO7+4h+J4EkLK4VhMJADbAVxW9/3m26x6IhFOPjomjFgv9eg3s9SYirGwO1b9FhPPV5USIcNUXtG7GKzjyWlLf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73xhr3EePLximL+H6iAeMQBIFdzuK7xBXLcozHGacCE=;
 b=krsjDDvIRgrHyCTmcD/z14DOCFiRJph1hxJYjibchAOezfq9rmQQqjMObq/wjqNH+2CgJKB3p4/ousRPQQxmHS1GpI7IyvZmSN9j0vW40wXdq6VGlPGo+V9k9JPxqlZGgGJ/pB7wB0XVd/MeQrMrWP50yqQQuvygUL23eQdSxA0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4828.namprd10.prod.outlook.com (2603:10b6:610:c8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 15:38:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5293.016; Fri, 27 May 2022
 15:38:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-XFS <linux-xfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/page_alloc: Always attempt to allocate at least one
 page during bulk allocation
Thread-Topic: [PATCH] mm/page_alloc: Always attempt to allocate at least one
 page during bulk allocation
Thread-Index: AQHYcOC43NoaGkYC5U+9BlY8CFI0/a0y3deA
Date:   Fri, 27 May 2022 15:38:24 +0000
Message-ID: <964C1F37-11E3-4C28-B4DB-817E9A6F7DF7@oracle.com>
References: <20220526091210.GC3441@techsingularity.net>
In-Reply-To: <20220526091210.GC3441@techsingularity.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59f6ac8c-55b5-4043-72aa-08da3ff6efc9
x-ms-traffictypediagnostic: CH0PR10MB4828:EE_
x-microsoft-antispam-prvs: <CH0PR10MB4828637B75D2EE0C4DF9BC8C93D89@CH0PR10MB4828.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yNVfxKIdgKy9Gn+v500tOBFRRpGBAu4LVhBSQy0BEyQzoYIz9cbd6zAbaSXw0wuMCh8eUiqTA8Gr2B5Py2Brijc31zCKQ2l6tsM9N3ctiOnNAEmqz3fXX7R94daUtVA1T4y9CDTp30J2VRyEMvd3D+L0VXmJp40z+mVrb7x1KpfmguY+GpDQdQft3eyWSeVLNv8TByP2ACqSwMD2Gj+KJq8pEVfm2P0ovPOc0lvEoO9PXVP0+2vfVbgi5aJ6DcnRlxWngBs/FOGH+yz5PIvVXOjRj4GCc6pMSe3iTESNjHylvsbhPrs+IyWRFAbezqRpbuRleKUzoQ092ocuPcIzZZQJRFdreEn4FvAqWJ2of5Ql/CY5QzK3KFPS4HJKNLfKOf+DWws2qtDOhbryRlyikRXiB0SwRy8LNZMONLgr9MR2HEUNY1JmknpTgH3m3wArC+CPChMh62EMNxhwvWXLhhJzxb5D/AIk93mYy48rckOkjE2oTGNIHWXr10h9Ofx1DOQzUhy4XwiigOPl45ihIEpMwuAdJ/2Hx8WD2YRiuH332AZ0PqHMZTZ+ATpFfpIj9K7hnANZEbnUcH1WTRPZovDEkX6maNsFTdZk7F55M3uHUlrLvqCU0hzdJnZUx79aSu0ZiGHDKXSFCySEEG1zKFv0hA4roNN2dCskURjRa6vAtikJlvjH0GpnNgMvFsdDTM9CcXQKxuXMF4Br2MAnL0ofepAKFmb0Px7/BVqnSGIAIuQDInNJBtdte4f9zUbFGgNe+rAKRaZTfEab9TVVHQZkVfM/xw0Uk02IxYLklKtbK+4DXKaal1Mnd5FDDxR8U2rdKq22IakF7bAifv8uhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(6916009)(54906003)(66556008)(64756008)(8676002)(66446008)(66476007)(4326008)(66946007)(91956017)(2616005)(76116006)(6486002)(53546011)(966005)(6506007)(122000001)(508600001)(83380400001)(7416002)(186003)(8936002)(2906002)(33656002)(316002)(38100700002)(38070700005)(36756003)(6512007)(86362001)(5660300002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OhUlSyYH5RQx8H88YcU0XNV6QN07yO435u3Gxnj0TJJIsWshToDjPD/WnZSh?=
 =?us-ascii?Q?GOkbGZWeQTHouT+EfHEVMB1JJ12uz2hqnAT1hZrE8A8hjTTrJeGb9GtVS02J?=
 =?us-ascii?Q?0A/n/Qsr8jMa2c7jhx/eX/gTIr5/QYcjznWWrv6/wAlH1jQqUTsAN9DJ5afV?=
 =?us-ascii?Q?L4wG2H214JZdeYq2hyxx9rOwsulxq61DD571ycZscJy8B5pspQ3PWJgXkVWy?=
 =?us-ascii?Q?E4Pes5hUVJWEUiJuw2OHpGI+7oeoENwN+mGXTnBVvFcaP5zHbVy8gVIgP9eL?=
 =?us-ascii?Q?cm1NCRqeJLVYcfnR+Uvex4qHRpVLgodtkIXEsbM87J9ETg+0C/DKpeNIoV/4?=
 =?us-ascii?Q?n8g5KLZVBinBj5igSjbAwuLaXnpAGr4RqwCOaSXMyYj8tpoHQcRnPZSvkfQY?=
 =?us-ascii?Q?PM57xA3WfIfN+pMOUe3kauHobUurOFjtFILTKZJe2sL5k6UahpWW9Iob5/8O?=
 =?us-ascii?Q?bVY2Wq3RsDtEPuikmPaWztp9OpSmEaj2KjRzoyj+yV/90Y0R4/yzQjypLtma?=
 =?us-ascii?Q?SQaOnyNXynZwTAf4SecOU20b4hHq1EuTBf++fpchyy20AlMjRkNmnMZzrBqE?=
 =?us-ascii?Q?OtZGO1RXEfe+8z8pPQz2bf0dyL7M4HPhITjlbrYLHkJ84sJd5jZKNJFRd2j3?=
 =?us-ascii?Q?88TNuW8q0apMCRNN3m24xp9tXTUPFeHHgWwpmjSjn77/fiMaktqMenJmbQqH?=
 =?us-ascii?Q?g9AazXsJnFhAKWPJTvUjMzE0EBTEprvlSoV/L3XlQC0V42d+tpQD5gxRpWct?=
 =?us-ascii?Q?bTJuOaoN/mA4/YWj3fB9wXlUWPaUfRKPbg8DZ7WLinrdp10sg1nW+SQNO9ky?=
 =?us-ascii?Q?vPA9h+mBfrTdHpg8z/+Wr5Ab6rKS2t3fT8rHh03sDyx5o25mji7O+eC5durC?=
 =?us-ascii?Q?asjhQBagNnQOwMkgl4/aPQEec3ADIwUKPDnVhRpO5o2te1sgpZHq/8Vccr7C?=
 =?us-ascii?Q?2bGLYL4RkuepauYDoKxl78jMk3FcqHK4B3SlM+TtolDNbHW+s1SCW54zqOZs?=
 =?us-ascii?Q?7243FeYx1hP4s+tn/R5UBDrwxeIIRRJ+V/+9Xz/edIQzO3WLeBldgBP+i0NC?=
 =?us-ascii?Q?znz0S3z2zrlO8sPrb6wqQnVIInySVhu8pY2mLp1oXHfrGyCcdR/OdjYn2Bji?=
 =?us-ascii?Q?6K/Znq7WHN+muV+AKaM/A9/+dizYd/ykZZLsxBc/pFeySTsaq13/eA+vBhEB?=
 =?us-ascii?Q?XePMFBZb0wB5i4+WvYuEHVltzNmaGmksC8FXYdd5SVEsels3/Mwm2++WujBp?=
 =?us-ascii?Q?xbgxqf/OFGdsCJZJ1ej/bPKWYdk++9WgxM503u5ZDwI8nBuqt2uiUxj+HK+r?=
 =?us-ascii?Q?r90P8/Bh8wVX9BP7EpbnMnJHs9z5oedsRvOLguBc2cez1a1IYYkho4w2695O?=
 =?us-ascii?Q?MLL5BYKtoQl4sBTQlXjoSywIetZzit0ZgDMSpv5BjH6AGNKuhMXz8xbL9LTT?=
 =?us-ascii?Q?MwOnlBXPA/EUVwoQId1xZop4a2Q9XexsyD6jgXAiBmuueywGFOXE0ovsTGP+?=
 =?us-ascii?Q?1rmu5j7qzQyq7SlklaKf6+jplHzOMG1tWIFBw86aXsH052hPZV9N6+1igLDn?=
 =?us-ascii?Q?TbpvtA6/SMS8ES3oVbggszk1w5SM1LbX8vIqXLMe4aYlgBTQvSrL7bYJgelh?=
 =?us-ascii?Q?eejl3cV6SmJ832lGXJQ1orDmjF79jgpAV59qdH6i/alDKFWkf3bXMCR7plzB?=
 =?us-ascii?Q?oNGAUqbo9g3FFqL/X6duEsPpglzt3mAKgSnTgJLWIaz6D7X+sn6aud4sAuDa?=
 =?us-ascii?Q?7smx7gtus7gGrTUmcZxXBsPJ2lZIy2Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8E230F73EA8A4340B51AC220BA45E316@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f6ac8c-55b5-4043-72aa-08da3ff6efc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 15:38:24.3495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XMp59hXF3BYmezMMCzEg6j+IUF7L0JVef3npUzuM+iqzNZYcUQ0jdNIwheMy5m+yCzzSqPKAXUR257F9NW5yTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4828
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-27_04:2022-05-27,2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205270075
X-Proofpoint-GUID: GIAbxOqIidiXYoJaavRi7t-AQMX33m1p
X-Proofpoint-ORIG-GUID: GIAbxOqIidiXYoJaavRi7t-AQMX33m1p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 26, 2022, at 5:12 AM, Mel Gorman <mgorman@techsingularity.net> wro=
te:
>=20
> Peter Pavlisko reported the following problem on kernel bugzilla 216007.
>=20
> 	When I try to extract an uncompressed tar archive (2.6 milion
> 	files, 760.3 GiB in size) on newly created (empty) XFS file system,
> 	after first low tens of gigabytes extracted the process hangs in
> 	iowait indefinitely. One CPU core is 100% occupied with iowait,
> 	the other CPU core is idle (on 2-core Intel Celeron G1610T).
>=20
> It was bisected to c9fa563072e1 ("xfs: use alloc_pages_bulk_array() for
> buffers") but XFS is only the messenger. The problem is that nothing
> is waking kswapd to reclaim some pages at a time the PCP lists cannot
> be refilled until some reclaim happens. The bulk allocator checks that
> there are some pages in the array and the original intent was that a bulk
> allocator did not necessarily need all the requested pages and it was
> best to return as quickly as possible. This was fine for the first user
> of the API but both NFS and XFS require the requested number of pages
> be available before making progress. Both could be adjusted to call the
> page allocator directly if a bulk allocation fails but it puts a burden o=
n
> users of the API. Adjust the semantics to attempt at least one allocation
> via __alloc_pages() before returning so kswapd is woken if necessary.
>=20
> It was reported via bugzilla that the patch addressed the problem and
> that the tar extraction completed successfully. This may also address
> bug 215975 but has yet to be confirmed.
>=20
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D216007
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D215975
> Fixes: 387ba26fb1cb ("mm/page_alloc: add a bulk page allocator")
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Cc: <stable@vger.kernel.org> # v5.13+

Fwiw, Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> mm/page_alloc.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0e42038382c1..5ced6cb260ed 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5324,8 +5324,8 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int pre=
ferred_nid,
> 		page =3D __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
> 								pcp, pcp_list);
> 		if (unlikely(!page)) {
> -			/* Try and get at least one page */
> -			if (!nr_populated)
> +			/* Try and allocate at least one page */
> +			if (!nr_account)
> 				goto failed_irq;
> 			break;
> 		}

--
Chuck Lever



