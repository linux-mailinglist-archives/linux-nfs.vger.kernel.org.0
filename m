Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5E06153CD
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 22:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKAVMW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 17:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKAVMV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 17:12:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FF53A6
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 14:12:19 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1Kn9Jo000575;
        Tue, 1 Nov 2022 21:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=IyEJrqqtU+XwzBaOMaLGittyf1/RDk7MPJQNXxhao3c=;
 b=2UtPSQAO+bE+oDVLDobq+Kk32AWc0nfkIhX1B+k3SBSCV5CjusRS4vqUh4PTEf6Y1e9d
 AZ6pKHy1BpAlXhfVZNzVhSTPXUo60/QE+BWXgdRTaCQpfdT4C/bKLOoh394E201AR0uw
 Lx2zrXfK5EzwR9nhC7gq8V11m0zcwft4i1j2BargPOSAbZoFMzJGydnJJ93RCMSyHrCR
 omi6tuzc2jzpEgp6Z8Z0zMKByr/Yix4LZWf49rrar2c/pxq/dBLvdc5aPOKKwDxYAf7s
 4gPQCgMnB9mqdr2epcPejQgh0zwmFSGJMdwo+p65md1xoSbH+hXBWHIoeWR/godKERBJ 7Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgussqwhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 21:12:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1KGWde014091;
        Tue, 1 Nov 2022 21:12:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm4ugwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 21:12:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yi2Ozr9EZCa454dwD5ijJIHKb1AlRMOMk/wLvmLbgYx/ZW/BA5s0VAtezS2A74Tt0W0+C1c6iSIndvLqlaFUeClqEqTLScLeYlwD63L+2DAGKQjsZ15CchSJx8eoxHPscmUwmRHHyru6dpqZ11nh4/SY8nFpivul1UH7sx+BUSeU4XuePtD8k4CQcX1hEnKKo2Poj+sYFtzJcG15lc4xqcETbCRgh6ILb7CGiOF7J9I3mdTCFDt4+/HZkxu0g2ytXVwxpmxxDdojERE9LmauUUg7GnSeWU3DjpxLZPrENjBQuAJG389iJyQsNfBH79iQxC95nXY/D0wbMmyUHe4uyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyEJrqqtU+XwzBaOMaLGittyf1/RDk7MPJQNXxhao3c=;
 b=gUnQMrblqmyfem0FCKxZlHIYN0VnXGxat1fUOIuFweXouOAWZBY2TcqzF31vH7tW7MSsNWgwcRVLKbkdNkd3DVtQnkVKtyDzFWiipbffuZK3HhYF1hGIl9lKMGwJ+XtOSImpc3bx3UYK1aLBcHRjo/fxc0iZikfDfJjGzIJBECqjzWpOib6gUPvI6SPivNxCaYajEm76yLRDDKo6nDrxDpGDm/tABRZ4XQP4Z5VmxHUM3ozzGhc7BWYVFI2WtUdGZqt1oDcWlPwj7h6+Jc2kS/YjtscaWV8Y2rtJxZLegkKTiD9UnoMAvr0XA4JJ8+u8xh4emXoB9sRgNgc5z5Jd6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyEJrqqtU+XwzBaOMaLGittyf1/RDk7MPJQNXxhao3c=;
 b=xrQjqckWFPXhzcR61spNirJQuoRDaibRjjpxv1AYZ5YgGxYCb2B0PH3jAbABQnWlmPnGjBZDci2aLz1ZMW5ZGDkuTQbW6UzetUaXczoNK6Mf/qWGnxXkWDuAfRclImACf9PWF8X1B0q8kkwJvu5CFDiBDhwbGadxsF+Ty3hWHwc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6524.namprd10.prod.outlook.com (2603:10b6:806:2a7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 21:12:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 21:12:08 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] nfsd: close race between unhashing and LRU
 addition
Thread-Topic: [PATCH v5 4/5] nfsd: close race between unhashing and LRU
 addition
Thread-Index: AQHY7gDL+y7FIybaF067dT9j2NqLWK4qkTCA
Date:   Tue, 1 Nov 2022 21:12:08 +0000
Message-ID: <1E01AC3C-7B11-4CA6-A26C-385663B74A94@oracle.com>
References: <20221101144647.136696-1-jlayton@kernel.org>
 <20221101144647.136696-5-jlayton@kernel.org>
In-Reply-To: <20221101144647.136696-5-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6524:EE_
x-ms-office365-filtering-correlation-id: aaa42e72-c921-4a62-37c3-08dabc4dbc2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PqT9zgGGpeOWeENEZ7tQuVWgs6ScHLvqys+ilcdTfQBlmMPV7cwaEb90o5ARNDdlvoGoVsF5SLINQ0ZnKhWxzsDC4PWocd40BAxGFm5J6CwyoOq8+kkAu2NV1RqzPooFDdjn6+2xvvF/LeMl6d+Gu57KWDsuiY7WzqaNsOf7ZZHdkHJFPFwScl0+igkl9waYYBxoDvZVUgezO/ibcwll62oG+NgGNJvWCRlsAfDUxhwYSSoDlqLGZDK4ulYWNimo71KTgUJqTmyQiZyJGj965JNVfheUc5b+ivBvCwOaNngjOdXRx/dzVjekFbc5NMM9k+XPbGoL37u7MYmpUZXXr776u345Nexv6bkE9AEp7qP4nA1UcQEsbMRsbN4x43g+ZfZPS6M7orgrkeoV22evl2u7RjpJuZCBTFZ4tUTTogxytJc7J7Z83RzTKHOlDabXVTFCrLmySdEpVJhCwtoKUXqNG4OFRVyU1kTh+FQ/LDpYSlm1qkHeckyyBIRiR0wjSKQ16xO9/QLtl4RaKd0iPltCP48w1T63YYBWa+jdf1zkhXpmbaTeXsCuBsN/zOfu69cLotGjOrdXxqSoebtaRT69DHXA4L3bkU9OT362tKF/rq8oI/rr7sV97+t/XH94okpjxj827MViXA86rnt4GBuTP1VjCFUhxJhO7+yrQvIYO0kkDNZJw4VwyKgXibb13kFeqVxuPoT4N8CJyTEc44wXiTNcawXNTzpV4OxT9hvBMdZc1j1ywWPjpFT3VevX7vLhNQ18avlqrXvHdBuuBHn2e4hstP8sjxgOrzAjD74=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199015)(66556008)(86362001)(38070700005)(36756003)(33656002)(6512007)(26005)(66476007)(64756008)(41300700001)(66446008)(76116006)(66946007)(8676002)(91956017)(8936002)(4326008)(2616005)(6506007)(478600001)(6486002)(38100700002)(186003)(71200400001)(53546011)(5660300002)(54906003)(316002)(122000001)(6916009)(83380400001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SqK9YTxh8n4eygM8Ls+DkrcHEZyzxoKYX/coqu/wpThL6Ddto6lXqY6a2WtU?=
 =?us-ascii?Q?Kj0DNiHe+TNcGaG7+S/d84khJ+D0Z30ZeignyS0by1cNgNuROd4C/0DRpFI5?=
 =?us-ascii?Q?SumvJaEvF+sIPLNtM+MGHagAJRYTEFszXjqNkhcZ13m9tjXkwo0r77mIyzWs?=
 =?us-ascii?Q?visCAfMP9XEsR+WYm8pR7uEGjWp9xMh/QwYS6+8KXC/PqxH72qjjlGu4dLy0?=
 =?us-ascii?Q?5s6Ic4uRC1D2Fux4XCeQNgxev/J8dC+ALKKeT9FsSqG9LNSowR8yWq1u6QQs?=
 =?us-ascii?Q?Btq+mdDu2Q1fNhW4lxMkMqPU3xy5Zhjv4XavxVjyvcG9xSTcTQI+3IpT9fB6?=
 =?us-ascii?Q?yHnk6jHzSetaZm5vtaFNWvBKfC2Dg4kygXKrVS5KwKM8bpGOyR4SBFNltDct?=
 =?us-ascii?Q?pHzcgcNbNzPPz6d6F2Dr5x6/6i3rX5rzhIc75PRJ+P1FcFbuv5CMCeQ7CMc4?=
 =?us-ascii?Q?Z5oat1gA3Im5stBc/duLkntp3gnTIJXUbnzj4/xIWSfG2OaeH+886g/fjBSE?=
 =?us-ascii?Q?LJDzrFzMiu9Ep5g0Zk3nlmSua2xHOv+ITJOz33m0VKxY1WbNufFMRfTTEQ4L?=
 =?us-ascii?Q?+evItq20/tIm0wmNpXMAIXb0VgCj3iZciuN0CQuSalJtocF79ou6Y8/YUuiy?=
 =?us-ascii?Q?evM+CWECQjRnEmSD8kDhiMUTm8OVQ9wMcZ4TnOwq8ZuB6y3xDiNvSrgYFYK1?=
 =?us-ascii?Q?KmL+vqD6VZxKE8qRjdKMbublrAzh3i+JJHVI0zyDeH5vfaiFvRAgkAKuTMhQ?=
 =?us-ascii?Q?RKuDISPGtECcPilC1eORIw15wHalmIOTcvSojaO5pO9XDuNjmYba003uRixX?=
 =?us-ascii?Q?6RAKxhXC0br6rxmSVltOr+uGL4GiofD2LOIkkoeyHy5iZB4TjaRE28Nl25oC?=
 =?us-ascii?Q?Knn9r5DIqdnIX08epmjKJbAsG3g7RRzlFgKk0IoNmQ7mCi8SgXzags4DMPCV?=
 =?us-ascii?Q?l9g7seL6egv1puNGtFoWjxBbWMrTHs+7xE14fcSo+h0cTKkJmXyU2SXATq1H?=
 =?us-ascii?Q?539GFDgl6ASZ29CoRIbQ/j+QLbW5r+Dmc5AFe3x9fZlY5vkzFHSOnyLBv9gF?=
 =?us-ascii?Q?n0LzdS4u6D61Q/BGxRRRMc3i0t7dCl10UdpQMbtu24v61vUH/AR9aXhZml77?=
 =?us-ascii?Q?EoBoTS89v18bqOdEGTk07yoTaX5pBGTuAjZdg7VtDedLHFXmojNnZIxnQ5bo?=
 =?us-ascii?Q?wIlg5P08aruByPpeWuC9D9Gsnr7HUytuLbI+cDuaoXPOjF1wB98OduR5gCO1?=
 =?us-ascii?Q?8rOpqxNlQmyy8eWwY1TpwsNN3XCchbKnel7V87uR+4i2vzEQ4LXqCC+NRFfU?=
 =?us-ascii?Q?RE0DYtYs7rT0v465XyzG9V95YibrzdcDOQmtZjUIszUxMi7jWIEt5fn/8JSr?=
 =?us-ascii?Q?IS5zB71kRKL/xBRBW5aeozaOB5T/YOlyGK1dsz0uvdPatmkHRGB4cFlqo+z/?=
 =?us-ascii?Q?OYM/2Jyo2U5qIvejciQwy3eKNbIY5NbCH67wvVUbQbk6gW9qYoqBo3KxdhTR?=
 =?us-ascii?Q?CvbNYAmaNfTtUmtopbO+YuMoOx1DLQIbpfPt19uGXRVUCPmszdLw0zvx3v2d?=
 =?us-ascii?Q?JgS6Xk+S1Nfyv+xW2JfB3X3rJevqzKdBHSwom1mpRrmRrzavpI77IAjuzQLh?=
 =?us-ascii?Q?6Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB8D691F59B98F4F9EF9A0F703D3B239@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa42e72-c921-4a62-37c3-08dabc4dbc2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 21:12:08.1421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m5wdPDz0njrXmqROQv+J6HOcjl3QmDjf5EAwRNt+K/QXbUgUE0iSxLI2TymjgOUDoiZQHw4xA6pOWvLILSZZDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010147
X-Proofpoint-ORIG-GUID: Ik5xZUzq3POcfGHFJvQVFFNg-ErNqHUH
X-Proofpoint-GUID: Ik5xZUzq3POcfGHFJvQVFFNg-ErNqHUH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 1, 2022, at 10:46 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> The list_lru_add and list_lru_del functions use list_empty checks to see
> whether the object is already on the LRU. That's fine in most cases, but
> we occasionally repurpose nf_lru after unhashing. It's possible for an
> LRU removal to remove it from a different list altogether if we lose a
> race.
>=20
> Add a new NFSD_FILE_LRU flag, which indicates that the object actually
> resides on the LRU and not some other list. Use that when adding and
> removing it from the LRU instead of just relying on list_empty checks.
>=20
> Add an extra HASHED check after adding the entry to the LRU. If it's now
> clear, just remove it from the LRU again and put the reference if that
> remove is successful.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 50 ++++++++++++++++++++++++++++++---------------
> fs/nfsd/filecache.h |  1 +
> 2 files changed, 35 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index e67297ad12bf..bcea201d79c3 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -409,18 +409,22 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
> static bool nfsd_file_lru_add(struct nfsd_file *nf)
> {
> 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
> -		trace_nfsd_file_lru_add(nf);
> -		return true;
> +	if (!test_and_set_bit(NFSD_FILE_LRU, &nf->nf_flags)) {
> +		if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
> +			trace_nfsd_file_lru_add(nf);
> +			return true;
> +		}
> 	}
> 	return false;
> }
>=20
> static bool nfsd_file_lru_remove(struct nfsd_file *nf)
> {
> -	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
> -		trace_nfsd_file_lru_del(nf);
> -		return true;
> +	if (test_and_clear_bit(NFSD_FILE_LRU, &nf->nf_flags)) {
> +		if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
> +			trace_nfsd_file_lru_del(nf);
> +			return true;
> +		}
> 	}
> 	return false;
> }
> @@ -476,21 +480,31 @@ nfsd_file_put(struct nfsd_file *nf)
> 	might_sleep();
> 	trace_nfsd_file_put(nf);
>=20
> -	/*
> -	 * The HASHED check is racy. We may end up with the occasional
> -	 * unhashed entry on the LRU, but they should get cleaned up
> -	 * like any other.
> -	 */
> 	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
> 	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> 		/*
> -		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
> -		 * it to the LRU. If the add to the LRU fails, just put it as
> -		 * usual.
> +		 * If this is the last reference (nf_ref =3D=3D 1), then try to
> +		 * transfer it to the LRU.
> 		 */
> -		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf)) {
> -			nfsd_file_schedule_laundrette();
> +		if (refcount_dec_not_one(&nf->nf_ref))
> 			return;
> +
> +		/* Try to add it to the LRU.  If that fails, decrement. */
> +		if (nfsd_file_lru_add(nf)) {
> +			/* If it's still hashed, we're done */
> +			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> +				nfsd_file_schedule_laundrette();
> +				return;
> +			}
> +
> +			/*
> +			 * We're racing with unhashing, so try to remove it from
> +			 * the LRU. If removal fails, then someone else already
> +			 * has our reference and we're done. If it succeeds,
> +			 * fall through to decrement.
> +			 */
> +			if (!nfsd_file_lru_remove(nf))
> +				return;
> 		}
> 	}
> 	if (refcount_dec_and_test(&nf->nf_ref))
> @@ -594,6 +608,10 @@ nfsd_file_lru_cb(struct list_head *item, struct list=
_lru_one *lru,
> 		return LRU_ROTATE;
> 	}
>=20
> +	/* Make sure we're not racing with another removal. */
> +	if (!test_and_clear_bit(NFSD_FILE_LRU, &nf->nf_flags))
> +		return LRU_SKIP;
> +
> 	/*
> 	 * Put the reference held on behalf of the LRU. If it wasn't the last
> 	 * one, then just remove it from the LRU and ignore it.
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index b7efb2c3ddb1..e52ab7d5a44c 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -39,6 +39,7 @@ struct nfsd_file {
> #define NFSD_FILE_PENDING	(1)
> #define NFSD_FILE_REFERENCED	(2)
> #define NFSD_FILE_GC		(3)
> +#define NFSD_FILE_LRU		(4)	/* file is on LRU */

Be sure to add NFSD_FILE_LRU to the show_nf_flags() macro:

 866 /*
 867  * from fs/nfsd/filecache.h
 868  */
 869 #define show_nf_flags(val)                                            =
  \
 870         __print_flags(val, "|",                                       =
  \
 871                 { 1 << NFSD_FILE_HASHED,        "HASHED" },           =
  \
 872                 { 1 << NFSD_FILE_PENDING,       "PENDING" },          =
  \
 873                 { 1 << NFSD_FILE_REFERENCED,    "REFERENCED"},        =
  \
 874                 { 1 << NFSD_FILE_GC,            "GC"})


> 	unsigned long		nf_flags;
> 	struct inode		*nf_inode;	/* don't deref */
> 	refcount_t		nf_ref;
> --=20
> 2.38.1
>=20

--
Chuck Lever



