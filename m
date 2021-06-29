Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1EA3B767A
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 18:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhF2Qex (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 12:34:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62704 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230052AbhF2Qex (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 12:34:53 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TGGE3C011579;
        Tue, 29 Jun 2021 16:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=5nMrPQXbHyoQg3yf7GEI4ThTmInsNi5GRfSlhiSFPFw=;
 b=TYPG1tqnY4UnODYfbjGgKko3GA5DUdh4L0cI6h3uCDWG1rqWaLQTomAlNX40xXKseMK+
 MMCgKpp/ufYtWxy/hx4PGaoNmYq4TfWgodiZUli4ePJ/m/hq67dCn6xFL5w0+ZsYE+IV
 SCRMmcdI2VhQHIqzS0p/I81zYb3DMdLBSkLAwVyYZgiotmGsj1S/uRw5YLYYSFVKDkWR
 m2AAV3Wkky/GO/IVX8MUthKUVc4hfjIpRHEb7ljgumIfGcy/H78zHg+JpnhrnAZY5wZI
 XdRoEaf+NM+X7H/2V8dFyFIR9FQBi3xC+1V4+Ysi6TnNhL5xH+ORmzMLCmVHKa/dqrfM Ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f6pqc2kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 16:32:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15TGLvE8032486;
        Tue, 29 Jun 2021 16:32:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3030.oracle.com with ESMTP id 39dsby8x29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 16:32:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jv3fN9Sj4CR/z8Rljhr1C2AtJlVFX96xXsXju5sR5HVSvOG8fX/kwkZHVt/EDWODNfoCgySOOzkvoFhgq7f7GQ9OTgvnne9zkHzSaIm1HVq5e+j2irlKUvGxhXmm6b4KLotw4MResADLSpE7iYAj2KnP1IRXGEJVPxv9dC2V0FWWEhIHMp0789hjln4t/Xv/C0dtFIvRAZsmD45rrCF5DOEhlXstzZEeWc49Y8gX5ZEeMVy2XVRZPg+tYKSwOOEbtsqUHMASLW8T379gSbrXlcurbUAOj8JEi42Z6mwfSMNmdwgqRfu05lJsYTTzIUyXeumuehlWpH0CrqXGO+aodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nMrPQXbHyoQg3yf7GEI4ThTmInsNi5GRfSlhiSFPFw=;
 b=GnqUGL7pRSi+XUjGV8jSpQ/uHeJNFIuBoALCd35ryW1KifalWDhmPupKnczKpIC1QU3xheOgYhD4tOn/L/MCjYJGJ3MTei+lBfE1ljNS9FwseT734PQa3aoWNJ2lM7R8hn9ZZp+3vySW6pJaqsbLazKexUwMblIzmxMQTb+nB/2sbSN0ajLv4R7me82722zrldu9aEUSLvXu6IuSikyXi7eHF1w1jlZYTcpOFw4hkiUl8ag6LZwK0RkDSgHA6BUouWkzEpdRYlwg1fEQsaMEZDVE/wCsXptVZCuuTpAiKAyiNjxjlERF99AjBzi5pQ12ccCv7y8bP7EhUk95GeAR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nMrPQXbHyoQg3yf7GEI4ThTmInsNi5GRfSlhiSFPFw=;
 b=awqoPuMbWSnccUW08hbR+E9vrqPSXeTXG3tKMWWsd63MUkDFDkO4wVxSftrdRU5zY4OtM993AcRXL7u6l/JMUxHu2YaPyIpobIPswrmL5nEZ78H398dOiOoRhJVrKUOoJLkIA9zUv81i5NjrqYuaeFY5fLD31xc+I/7iqHYnQAE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3381.namprd10.prod.outlook.com (2603:10b6:a03:15b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 16:32:15 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94%9]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 16:32:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
CC:     Mel Gorman <mgorman@techsingularity.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "brouer@redhat.com" <brouer@redhat.com>
Subject: Re: [PATCH v3] mm/page_alloc: Further fix __alloc_pages_bulk() return
 value
Thread-Topic: [PATCH v3] mm/page_alloc: Further fix __alloc_pages_bulk()
 return value
Thread-Index: AQHXbO1toCeUhvRJMUGKkyLQssKzrasrJhsAgAAIrYA=
Date:   Tue, 29 Jun 2021 16:32:15 +0000
Message-ID: <9C7E1CE0-8AF8-4FCD-BABC-F09A2827CCBA@oracle.com>
References: <162497449506.16614.7781489905877008435.stgit@klimt.1015granger.net>
 <be9186d9-1e8e-4d99-ab0f-84c0518025c5@redhat.com>
In-Reply-To: <be9186d9-1e8e-4d99-ab0f-84c0518025c5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b2ccadb-95b6-4db9-872a-08d93b1b74aa
x-ms-traffictypediagnostic: BYAPR10MB3381:
x-microsoft-antispam-prvs: <BYAPR10MB338129B2B4C048AEF36FD01493029@BYAPR10MB3381.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FkQ4RL/QIady76m4S5rBO8hb3wxDfossWukBg5d4Ha3ldA11rWrixcvTRV6xHx0FUkCVe1kZgj+Wh4qhHer3HKQHXdXo/ygxP/Et7TFbKcnHg81rSD9GYwMtksZzP19vou8+9ugpUWf4beiRRqIjvcpyGHOIOFfvX5S7rZejyMnoGci3x+QLKV2fEm9cnsL4rPm5BfKG/ZQXo9fMlxy90cWAEP9QilpuDBKybfV54MZqxTQ6xWk6V8yKRI8DPuO0Yi/sttuKfmGfibBM0Ivtv7r3CbTmvUkpwcSS+7kRJtKUiaDSO5TOQ2ztZ4ES5Zgw2zBotkX8ZkgqH3I5Bftc0dP65QJgIEaa12yqnj+/PlyF7a5fr0wNUzGQl3W3wlAw/f63TsZcxIq1XZoq4UnSRQnEJJMdQGhsia+SeztRpJmGO2gl0MF/VhBmlsKYybQ+oePkQdncv6yNxtDKajK1MospStGjPKFZMaxnlZo8dzzd5FFjFR3hvrOLJo8T/598gOLql2G3t9UFp9rQtmhNsTMRVueDCwqGMxiXSu95rVozWzY2U+/FFaOjjSA+3RjCVOS7yP+UaGuDfqdcO2+CryaA7x6HdOYJU68xOsWUJ4tPjsXIEXAXsfi0tUmB4uyGS/hKk9mxL8/f2i+6xYBHTPtLjKGaPDCetgBpFB+9y9+ciQfkE5pk3KjuX2hhscNedyITS4AmYOLsBv6sUP/1PA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(346002)(39860400002)(366004)(316002)(6512007)(83380400001)(2906002)(66946007)(91956017)(54906003)(8676002)(186003)(8936002)(6486002)(26005)(33656002)(76116006)(53546011)(36756003)(86362001)(478600001)(4326008)(71200400001)(38100700002)(6506007)(66476007)(66556008)(64756008)(66446008)(2616005)(6916009)(122000001)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qed2CMFCjnomc6woHHn7euD9k+/YMtL1RGwoGU/NkxzfB+ZrAxZ1O0dx6u8j?=
 =?us-ascii?Q?P+kVPCIGI2VGB5a3LqVXBm9nxW1YOCbbcQNpSF00f/bvRwSfzt0NO3+DfuZS?=
 =?us-ascii?Q?BFQnk9Uw1lUaABSLX718dVEbmswU4+hqHGUD7Jz4VAOP7e/bSA/5AOqF2HeJ?=
 =?us-ascii?Q?pE19mn3GNc+TWUhUFUt4BEAqenVoRtZB2SkSlakMXUlwg38C9gxv0IS9bS3I?=
 =?us-ascii?Q?o9ARzESD2xUBM5Jkihctze45pQHYCNRWBNmkqLlv6XFWIHPX8axuS7VoQa9Y?=
 =?us-ascii?Q?35YPo+4wBmDCIqhDcb4aA+YqvN8kw21h9WQZ80/1h84WJoedGjUAtZ+zmcbF?=
 =?us-ascii?Q?JXdEImMX4/yVRPXOp32pvyzPSdIRrgr4mCP5PV3/Jw0whXmf/FFUN7zjkVLc?=
 =?us-ascii?Q?7k7viw76HxmWM+zGDQYsHUhW67fEy8N9y+IgTBtRWpyA3s74xdCT+D9TapDG?=
 =?us-ascii?Q?oXfY/yzAGL35jRQYXPcxLFUq2YN7dX/9Tv8hKgamR4ZIwizt4RT/nwZgnQYW?=
 =?us-ascii?Q?RvyjpwLS3IhikmObZp+Ao9BBSioJ3g7ik9Q1+aMe4WrP4NcsqYGforGsQyLq?=
 =?us-ascii?Q?vBh9kyb2x4zONRGG3+zSwMuIYEdasEC30cXcfkR2rdcn/q+Z6z/cBerzKfcA?=
 =?us-ascii?Q?6DfFUanm/VSsknv66dj5cysqz+EdKSa06EC26lWkT3QAWaA50kRXSj4qVwdB?=
 =?us-ascii?Q?rJKWYUy1Wdm0eZkZwhuWG9sPwhV3gBVqx1rWfPVn9Q4f5PDHUoBNofxPSphS?=
 =?us-ascii?Q?KckoPYnaQN2129kj7QLacXCnqucL+t5LC1DQWOrs2t82sHr9DemYmBD9hRoq?=
 =?us-ascii?Q?U0SmLLgL/p10GIFTHJpSi9Wc3ohgevFH7sxL10rbLUpnCTvHq8oicw/i8Ssn?=
 =?us-ascii?Q?yBTLnufCUqNBCvdYZIrRzPUBQuymNqP+PQzmAQxpZVfaNh+ajFfqElfLXADw?=
 =?us-ascii?Q?mSdO8pFnTR8N3MqubkV4xem5XcePQDsnS69nQ4aDfU8fBHgOiw+qqEklqM42?=
 =?us-ascii?Q?JprFlJ3D4pTiZlfL9PPTOYbaDcdlAEbUmepo5CaIyb1h6YL1ItwVinJ3VGh8?=
 =?us-ascii?Q?Ol97r25iRjRr9+nESqfaEUlNsrbB+WFfze8t2jnozn9Lz4/0VsGFGpNN2L1j?=
 =?us-ascii?Q?yxcTs0xcr4OONei2sjm0QChpZ3ul49AGEGzyQzm2OjmQ9ICOXds5n9PnqDIh?=
 =?us-ascii?Q?loCGkG+pButY6MXZGN3UJ1GklNZVZGXvdIWCovMAMZ4xxNDP8TJ68wLn+kTZ?=
 =?us-ascii?Q?8bUPeT9usCFEhJemksycabLLz1mjfyRuz+Kx1FotO6JaEo3mK7HHkExK3DtB?=
 =?us-ascii?Q?t46ZmEhz7evmxRPED9bBxGtH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4B9C0C2185CA5443A3348C04064AA916@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2ccadb-95b6-4db9-872a-08d93b1b74aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 16:32:15.5989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LSQgZWdvcJHBFSd0Ht/UEKATSmc7QDm/RUTZbvGBNV9RFROEq0oiy0DmGYgrfY6oL65Br+hKqndz0sDyqrIoWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3381
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10030 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290104
X-Proofpoint-GUID: coHdTLPLzWuS9YvvqvEU-UH03AAFrCyh
X-Proofpoint-ORIG-GUID: coHdTLPLzWuS9YvvqvEU-UH03AAFrCyh
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 29, 2021, at 12:01 PM, Jesper Dangaard Brouer <jbrouer@redhat.com>=
 wrote:
>=20
> On 29/06/2021 15.48, Chuck Lever wrote:
>=20
>> The call site in __page_pool_alloc_pages_slow() also seems to be
>> confused on this matter. It should be attended to by someone who
>> is familiar with that code.
>=20
> I don't think we need a fix for __page_pool_alloc_pages_slow(), as the ar=
ray is guaranteed to be empty.
>=20
> But a fix would look like this:
>=20
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index c137ce308c27..1b04538a3da3 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -245,22 +245,23 @@ static struct page *__page_pool_alloc_pages_slow(st=
ruct page_pool *pool,
>         if (unlikely(pp_order))
>                 return __page_pool_alloc_page_order(pool, gfp);
>=20
>         /* Unnecessary as alloc cache is empty, but guarantees zero count=
 */
> -       if (unlikely(pool->alloc.count > 0))
> +       if (unlikely(pool->alloc.count > 0))   // ^^^^^^^^^^^^^^^^^^^^^^
>                 return pool->alloc.cache[--pool->alloc.count];
>=20
>         /* Mark empty alloc.cache slots "empty" for alloc_pages_bulk_arra=
y */
>         memset(&pool->alloc.cache, 0, sizeof(void *) * bulk);
>=20
> +       /* bulk API ret value also count existing pages, but array is emp=
ty */
>         nr_pages =3D alloc_pages_bulk_array(gfp, bulk, pool->alloc.cache)=
;
>         if (unlikely(!nr_pages))
>                 return NULL;

Thanks, this check makes sense to me now.


>         /* Pages have been filled into alloc.cache array, but count is ze=
ro and
>          * page element have not been (possibly) DMA mapped.
>          */
> -       for (i =3D 0; i < nr_pages; i++) {
> +       for (i =3D pool->alloc.count; i < nr_pages; i++) {
>                 page =3D pool->alloc.cache[i];
>                 if ((pp_flags & PP_FLAG_DMA_MAP) &&
>                     unlikely(!page_pool_dma_map(pool, page))) {
>                         put_page(page);
>=20

--
Chuck Lever



