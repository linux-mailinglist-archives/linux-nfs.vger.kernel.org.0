Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66A2646673
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Dec 2022 02:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiLHBZh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Dec 2022 20:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLHBZg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Dec 2022 20:25:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B6C880C9
        for <linux-nfs@vger.kernel.org>; Wed,  7 Dec 2022 17:25:35 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7NO3lv016818;
        Thu, 8 Dec 2022 01:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xXYpQegTSnDvfVYVbgHbdS8rAf2V8da6ObQ6ZSFSor4=;
 b=1fiGiGZGPET1IT7YiarzuWhpEwngKSfYDtNk+lz9zuJ24+9qOJPQTF0S6Bi70LXy3hHX
 XmUCSr/C9cz82iEAOl2RVXeTGIxAjtkS+wMXAqf8yhF3Xtdrvie7RHdYTS2jdAQzVDZM
 /Wqv3uMqrNNJ/vqod0wyqAbU/qCwedCI8chuD6g79t1b+L19CDNzEyfQNYYk2IGxJhz+
 dH+3ZgmrvuSkRvP5gPctc3OBS1XYMIal2ncxEsi7/i8pibavpWmvznbhapnNItDq3e9B
 aU2ynnIO8XBfmQkcwA+qrIa0bXR1RiKYT1x12XnzRS1Yt3XiKlWagd00qjW9j8SFzIvx pQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maujkhpy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 01:25:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7N2QIr009765;
        Thu, 8 Dec 2022 01:25:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa6a0npt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 01:25:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibCqmS8HfwoTHZ7yNn0cAzGtadLxk2vEUCnY/e6/UkqprvH9kF+FoPnvhNlwObmT7daGIedlvkyUElf9kEGDVUgWty+7gR24HXjOs8ayPsYlly6T3oEewooQZfw47ngYskDIKX3W+Ejv+Boz+yk9kujUFMWw8HEPq2k6DPnmgO/Sbz+o1im2ljWL8SLc3Wpl1Si8tRaP8gGaymQtzMYwu+/nFhHVxJTTjCjMg0QnMHHEFqBIwpz9bOIbb1rrRnUrvwsFRreYN8knXLmYRorgXX2EkLNLheV5OQLopiIecRl8nVFhleqBWqX5Vuc49kxhqBlPTyI9gfXEqXrJ2GCJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXYpQegTSnDvfVYVbgHbdS8rAf2V8da6ObQ6ZSFSor4=;
 b=Xlmv90Xc4QSUau8iOsQHhVuOvB6aJvmg1Ib9jClkUriUlGTtL1hA/FlMK2S3wwQsInXJlSt8azNQiVImhxAMfYzVY9qTlOxpe7dag41iZnAqC/QOIuTZILg8J9PiqOFxqphqRid5HCax+W6qSG5QZlbhDpsswUaYiF26D3hWmHaNPxrhZnjZNseVPlN5QtcMaMP99MfhLzfvVvXd/lcZS6NQj1SUD4XPjO7fbiBhGpnVMnNUPfnzDJ1fITMp08u8K3tCMk9LnmyY5EMP8Q88f5Y+kzPalklshhPrkDKmHJQ3IlsR199MZ8d8zcY7Cwc/EToDLf7iLe7sU/Xi6Z28eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXYpQegTSnDvfVYVbgHbdS8rAf2V8da6ObQ6ZSFSor4=;
 b=QsqiKc5ZnGpU6bT5/veNpsecdiLqP97icLwmjqGi1455ZF9wE61P9r0n1O9/UQRNDj6Mou1sg9NRZhN2pAsE9XkkASMN8eUp6BWE0Y9/Y8rRbIZkYHgEPvLrtlwk0T8bZ6rsHu5WBj4RrIDvlW3FubX9Teg13sY8VndVuIi6HVg=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by PH0PR10MB4805.namprd10.prod.outlook.com (2603:10b6:510:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 01:25:28 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::e208:8886:f6f1:ab09]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::e208:8886:f6f1:ab09%7]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 01:25:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: don't repurpose nf_lru while there are other
 references outstanding
Thread-Topic: [PATCH] nfsd: don't repurpose nf_lru while there are other
 references outstanding
Thread-Index: AQHZCocR54kkwni/b06C3xGXE2M6Qq5jMtmA
Date:   Thu, 8 Dec 2022 01:25:28 +0000
Message-ID: <395344B2-753D-4900-90D3-EBF06B20E5BF@oracle.com>
References: <20221207215830.221147-1-jlayton@kernel.org>
In-Reply-To: <20221207215830.221147-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5134:EE_|PH0PR10MB4805:EE_
x-ms-office365-filtering-correlation-id: bbb6664d-bf5a-4093-9a49-08dad8bb16e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cLdOwmEE1Q4q1n1Dbj3IKBOlJmm06wq1/P9R622OMI4NPBblGYJUS2yuklabqjoM38hZZiTa0qzI6NZcBlRUzDEawm09+V9XBrT54UqXrgFfiGxE799KsSAxdHOwfLYqyyA5X3YP9yqY02EGasj+Q84PyK6x7kJOQn68Wo7oGG3X+TmECJRosFvYbD/IheMmqPTMoOgUzu11fAVjMqxq+uzyXwjRmC7AXn1uNSswiQRNINcsvkpi2mAV+hnBEPa4BV3u7NLwUdvUYteMeZ8moZOh/6FN47ZsX0vqc3Dtw5GeHIlIckWALPC+pAmBJfknY96uXnOYBf4/wAkSoUtqHbHsXC1X5pLlb+M4vMcckS4HJjXXRqvl5I1KjdnAF3MZ5B7w99dewvgVY87o394167jQmP9LmCvW5gSwJtcOi/H+5iZiDRlSXZFiWV/wC8MURWCGVmz/HW1P29/upvKarfHC0qPlhuYoW4F4DVC0R2Z7f3UcGViPDu+D8h/jWRtbZ9UES5B9JGEFG+dzRhrJY1Iu6GoIZ9C8DJSn0b5R/ukDZsmK0dJev3QkA4n755zKhBZ9NVrP7ATn3CbSIp4H6Br21svl5LvxlvNnvatnrmfuk2JVrwyqctaT+z/b31JqB9MokXnf8vSzSOct2oApEdIqncIEkjslkNarmkiBYDyOU0Xk4Cr3SqK4wgc58RA90Y94ucftMXQp2b/3YewYdpdG6w5cdUmEv7y1RhvRjsQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199015)(38100700002)(316002)(41300700001)(478600001)(53546011)(186003)(6916009)(38070700005)(8936002)(71200400001)(5660300002)(33656002)(36756003)(6512007)(83380400001)(26005)(6486002)(6506007)(86362001)(91956017)(4326008)(8676002)(2906002)(122000001)(66446008)(64756008)(76116006)(66556008)(66476007)(2616005)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nBBxtjRiYqPbsmnoz8kXgqVxob+1SqoJh1C62Bi8Ol2l2+cAyC3s0SWjZJjk?=
 =?us-ascii?Q?thMwLbNwpGX0y3SwIY7+TYHOsUQfpm/aLu3jRPxv0rthcG49bmiUnUWEKiYE?=
 =?us-ascii?Q?pV1HWhBmtGNRrgn8NJSuEovZGydI+heX9jl6L2ZGcT5veI4HBQ4hrpSqJnNe?=
 =?us-ascii?Q?2WKYHKq9UT1cFTund68gmFz5qufgWqvZBBKAILCl4ieEXsMZlSpfruN0hCYX?=
 =?us-ascii?Q?baqSOc+eyGufhfy/8mhUSY0kkT0048LVi97992QukrFng4rt8y3CGzfiOwp9?=
 =?us-ascii?Q?9/F7JG0EhXgFDHeVGi+qU+eyPJoI0hIrAbjg9zn/puyPtfc3Y+xwj+4Zqv8m?=
 =?us-ascii?Q?r/W8VeBZj8UZRn+ITe1/cMVNC5Nr6z6MxlEwHYrMImi9efHh0nct0nKVbGFs?=
 =?us-ascii?Q?uwEyVAoC6Q7Cp/nTfaiMQx/gdAadfCK7KQRyCmnYOSUSuVBX4PbnhOhxECpm?=
 =?us-ascii?Q?DPYdDTZlxUiajgWkUmOF7LAxMySn/yysohU7XtjszSaFtJdSq6lipH8F3gX3?=
 =?us-ascii?Q?RmQRRzmkFyqniPdBW6mdHstlpDM7yzudOW+4oS+2ceW26/7QrWEgCu60KCka?=
 =?us-ascii?Q?WTMn9NMrOf+9HXjGNj3fwk68rrwD7f1vrwWV5VT1ljyuEXaSMGFarMFiYf8Q?=
 =?us-ascii?Q?Brrz9KhuHuVIQ0G1CioNgVBXKWj2mVIlCbo9YXe40Hf5JzNxyCAeveuutHvI?=
 =?us-ascii?Q?uh59Xzb9WV8KZ7bu5sNl0E0yIMG5Gy/jSaw9v1/ooWXlUSupuGzvZAvHBMhC?=
 =?us-ascii?Q?pmTFkr/ohrqo9pNM7dFsKOpQteA2DqDQfhA6RpBJUjrRaH2ptMxEs5PdIq8v?=
 =?us-ascii?Q?n1+7xhidIviEre0jq4ZimhHo0ekCt+GlNlh4biAUUljj2IAFTPQwbBWOXSQ8?=
 =?us-ascii?Q?7g2UGenBYbIaB2RM9jXYz93VNIDw+SNFbnQGL8QItkLLwvsrVnJQ1Jyf8J34?=
 =?us-ascii?Q?YxObmBaQCNo1kdBsJB9soq+MVb2OE5NP6FPkc43r7pt1tYmPRQX61kVxISGK?=
 =?us-ascii?Q?gk/UgpuqzSqH6hSQZI/RgCIW4++eS6QGRHHesJm3g6htmAOzQneFdjqbQhNa?=
 =?us-ascii?Q?21nfpHk0R3QIQRDJEZTROj4aMDO1WRVrXMffgioJ5JbgE6j2+9xkMSfaFzK3?=
 =?us-ascii?Q?PkgmqkZuRoF/xxVyIlcijmunGxuLk4jY6u1x+A35948DCKknn/7NB4k1mt8N?=
 =?us-ascii?Q?FpOzXhGak7PpovQvj65gAFqiTy5hste4iat19cJfUfKI3hXqArl95IAKKELz?=
 =?us-ascii?Q?kFotLngZQOt1LFPJgiy9xLLvNESTacBbLmuzFYbNqYPDTuHlQ0bxH9XDdsbc?=
 =?us-ascii?Q?e6nrVgQJ4ksDrRNLQmDoyOj14NYKSd/HiX0pMEX5oZCvBHf/h6x2okSX7G4M?=
 =?us-ascii?Q?fKoWp/8DvxjouhXxVPIMoYxAuE+Be2560a5kn8FQUQGh2FTiNFzhbSJNZaap?=
 =?us-ascii?Q?oj1U1R8beFIyPVgddC3TfZ/dVbIN8mTJDhHGz6bYQq7ZoVysLaNM9mEN+o8J?=
 =?us-ascii?Q?MiM3S6I+Ds16m810BfslYmoAokXh1D3N009d5+gIzOvWhTbQ+3rgCPKrJ4iX?=
 =?us-ascii?Q?cysj8hQ4RDPwhOmgL/kNKIl3XUFU3lexdhKG/H9P3lYtpu83cy2N7+TA4DG2?=
 =?us-ascii?Q?Jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE979051821F214EBF5692141D937B7E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb6664d-bf5a-4093-9a49-08dad8bb16e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 01:25:28.0820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /tDhd9Xziz8oy1dPJgx/ApzrU5mR7BWEy4hMoU891j6vVItdHKwbyX22SGNNAMXQbBQX5gvedOFUBWKP7hwvWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_11,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080009
X-Proofpoint-ORIG-GUID: 7Qy25ua7ER1G5ZDfcrtOb4eyXuCAfXLX
X-Proofpoint-GUID: 7Qy25ua7ER1G5ZDfcrtOb4eyXuCAfXLX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 7, 2022, at 4:58 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> When testing with a backport of the latest nfsd_file overhaul patches
> this week, I hit some list corruption with the nf->nf_lru list_head.
> Analysis of the vmcore suggested that a nf_lru had been reinitialized
> while it was sitting on the LRU.
>=20
> It's not safe to use the nf_lru list_head for anything but the LRU
> unless you can be sure that no other references can be taken, ensuring
> that you have exclusive access to it.
>=20
> In practical terms, this means that we can't queue objects to a dispose
> list until their refcounts have gone to zero. nfsd_unhash_and_queue
> currently violates this rule, as it queues nfsd_files to the dispose
> list with active references held.
>=20
> This function is called both during server shutdown and when there is
> conflicting access to an inode; two situations that have little to do
> with one another. Remove nfsd_file_unhash_and_queue altogether, as its
> callers need different things, and just open code what its callers need.
>=20
> Rename __nfsd_file_close_inode and rework the loop in it to put the
> reference(s) earlier and only queue the nf to the dispose list if its
> refcount went to zero.
>=20
> __nfsd_file_cache_purge is called during server shutdown. At that point,
> we don't care about the refcount since we know we have exclusive access.
> Just unhash the objects, dequeue them from the LRU and then free them.
>=20
> Finally, update the comments over nfsd_file_close_inode_sync,
> nfsd_file_close_inode and __nfsd_file_cache_purge to better describe
> their intended purpose.
>=20
> Fixes: d2cdf429693a ("nfsd: rework refcounting in filecache")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Applied internally for testing. I'll plan to include this fix in
next week's v6.2 PR for nfsd.


> ---
> fs/nfsd/filecache.c | 111 +++++++++++++++++++++++---------------------
> 1 file changed, 58 insertions(+), 53 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 1e76b0d3b83a..8bf2fcb0f580 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -461,35 +461,6 @@ nfsd_file_get(struct nfsd_file *nf)
> 	return NULL;
> }
>=20
> -/**
> - * nfsd_file_unhash_and_queue - unhash a file and queue it to the dispos=
e list
> - * @nf: nfsd_file to be unhashed and queued
> - * @dispose: list to which it should be queued
> - *
> - * Attempt to unhash a nfsd_file and queue it to the given list. Each fi=
le
> - * will have a reference held on behalf of the list. That reference may =
come
> - * from the LRU, or we may need to take one. If we can't get a reference=
,
> - * ignore it altogether.
> - */
> -static bool
> -nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *dispo=
se)
> -{
> -	trace_nfsd_file_unhash_and_queue(nf);
> -	if (nfsd_file_unhash(nf)) {
> -		/*
> -		 * If we remove it from the LRU, then just use that
> -		 * reference for the dispose list. Otherwise, we need
> -		 * to take a reference. If that fails, just ignore
> -		 * the file altogether.
> -		 */
> -		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
> -			return false;
> -		list_add(&nf->nf_lru, dispose);
> -		return true;
> -	}
> -	return false;
> -}
> -
> /**
>  * nfsd_file_put - put the reference to a nfsd_file
>  * @nf: nfsd_file of which to put the reference
> @@ -700,15 +671,24 @@ static struct shrinker	nfsd_file_shrinker =3D {
> 	.seeks =3D 1,
> };
>=20
> -/*
> - * Find all cache items across all net namespaces that match @inode, unh=
ash
> - * them, take references and then put them on @dispose if that was succe=
ssful.
> +/**
> + * nfsd_file_queue_for_close: try to close out any open nfsd_files for a=
n inode
> + * @inode:   inode on which to close out nfsd_files
> + * @dispose: list on which to gather nfsd_files to close out
> + *
> + * An nfsd_file represents a struct file being held open on behalf of nf=
sd. An
> + * open file however can block other activity (such as leases), or cause
> + * undesirable behavior (e.g. spurious silly-renames when reexporting NF=
S).
> + *
> + * This function is intended to find open nfsd_files when this sort of
> + * conflicting access occurs and then attempt to close those files out.
>  *
> - * The nfsd_file objects on the list will be unhashed, and each will hav=
e a
> - * reference taken.
> + * Populates the dispose list with entries that have already had their
> + * refcounts go to zero. The actual free of an nfsd_file can be expensiv=
e,
> + * so we leave it up to the caller whether it wants to wait or not.
>  */
> static void
> -__nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
> +nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispose=
)
> {
> 	struct nfsd_file_lookup_key key =3D {
> 		.type	=3D NFSD_FILE_KEY_INODE,
> @@ -718,12 +698,30 @@ __nfsd_file_close_inode(struct inode *inode, struct=
 list_head *dispose)
>=20
> 	rcu_read_lock();
> 	do {
> +		int decrement =3D 1;
> +
> 		nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
> 				       nfsd_file_rhash_params);
> 		if (!nf)
> 			break;
>=20
> -		nfsd_file_unhash_and_queue(nf, dispose);
> +		/* If we raced with someone else unhashing, ignore it */
> +		if (!nfsd_file_unhash(nf))
> +			continue;
> +
> +		/* If we can't get a reference, ignore it */
> +		if (!nfsd_file_get(nf))
> +			continue;
> +
> +		/* Extra decrement if we remove from the LRU */
> +		if (nfsd_file_lru_remove(nf))
> +			++decrement;
> +
> +		/* If refcount goes to 0, then put on the dispose list */
> +		if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
> +			list_add(&nf->nf_lru, dispose);
> +			trace_nfsd_file_closing(nf);
> +		}
> 	} while (1);
> 	rcu_read_unlock();
> }
> @@ -732,22 +730,17 @@ __nfsd_file_close_inode(struct inode *inode, struct=
 list_head *dispose)
>  * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
>  * @inode: inode of the file to attempt to remove
>  *
> - * Unhash and put all cache item associated with @inode. Queue any that =
have
> - * refcounts that go to zero to the dispose_list_delayed infrastructure =
for
> - * eventual cleanup.
> + * Close out any open nfsd_files that can be reaped for @inode. The
> + * actual freeing is deferred to the dispose_list_delayed infrastructure=
.
> + *
> + * This is used by the fsnotify callbacks and setlease notifier.
>  */
> static void
> nfsd_file_close_inode(struct inode *inode)
> {
> -	struct nfsd_file *nf, *tmp;
> 	LIST_HEAD(dispose);
>=20
> -	__nfsd_file_close_inode(inode, &dispose);
> -	list_for_each_entry_safe(nf, tmp, &dispose, nf_lru) {
> -		trace_nfsd_file_closing(nf);
> -		if (!refcount_dec_and_test(&nf->nf_ref))
> -			list_del_init(&nf->nf_lru);
> -	}
> +	nfsd_file_queue_for_close(inode, &dispose);
> 	nfsd_file_dispose_list_delayed(&dispose);
> }
>=20
> @@ -755,7 +748,11 @@ nfsd_file_close_inode(struct inode *inode)
>  * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
>  * @inode: inode of the file to attempt to remove
>  *
> - * Unhash and put, then flush and fput all cache items associated with @=
inode.
> + * Close out any open nfsd_files that can be reaped for @inode. The
> + * nfsd_files are closed out synchronously.
> + *
> + * This is called from nfsd_rename and nfsd_unlink to avoid silly-rename=
s
> + * when reexporting NFS.
>  */
> void
> nfsd_file_close_inode_sync(struct inode *inode)
> @@ -765,13 +762,11 @@ nfsd_file_close_inode_sync(struct inode *inode)
>=20
> 	trace_nfsd_file_close(inode);
>=20
> -	__nfsd_file_close_inode(inode, &dispose);
> +	nfsd_file_queue_for_close(inode, &dispose);
> 	while (!list_empty(&dispose)) {
> 		nf =3D list_first_entry(&dispose, struct nfsd_file, nf_lru);
> 		list_del_init(&nf->nf_lru);
> -		trace_nfsd_file_closing(nf);
> -		if (refcount_dec_and_test(&nf->nf_ref))
> -			nfsd_file_free(nf);
> +		nfsd_file_free(nf);
> 	}
> 	flush_delayed_fput();
> }
> @@ -923,6 +918,13 @@ nfsd_file_cache_init(void)
> 	goto out;
> }
>=20
> +/**
> + * __nfsd_file_cache_purge: clean out the cache for shutdown
> + * @net: net-namespace to shut down the cache (may be NULL)
> + *
> + * Walk the nfsd_file cache and close out any that match @net. If @net i=
s NULL,
> + * then close out everything. Called when an nfsd instance is being shut=
 down.
> + */
> static void
> __nfsd_file_cache_purge(struct net *net)
> {
> @@ -936,8 +938,11 @@ __nfsd_file_cache_purge(struct net *net)
>=20
> 		nf =3D rhashtable_walk_next(&iter);
> 		while (!IS_ERR_OR_NULL(nf)) {
> -			if (!net || nf->nf_net =3D=3D net)
> -				nfsd_file_unhash_and_queue(nf, &dispose);
> +			if (!net || nf->nf_net =3D=3D net) {
> +				nfsd_file_unhash(nf);
> +				nfsd_file_lru_remove(nf);
> +				list_add(&nf->nf_lru, &dispose);
> +			}
> 			nf =3D rhashtable_walk_next(&iter);
> 		}
>=20
> --=20
> 2.38.1
>=20

--
Chuck Lever



