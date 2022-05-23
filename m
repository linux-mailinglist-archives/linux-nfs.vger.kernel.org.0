Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0518D531456
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 18:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbiEWPBx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 11:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbiEWPA2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 11:00:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFBC5B8AF
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 08:00:27 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NEnGEH005439;
        Mon, 23 May 2022 15:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=dcFuxJVOaBJEUv7sJnrJIZ7UxfQ2NSSvnp9svJ9pzG0=;
 b=cMxv1QLS2n7sNeck9+4qRY+mZzK5ryEW2gmU8qRxcbx2lvKB6qhwAXSDblK/iWKGT1Rh
 SChoh+Ym5Vy4BEcqha+kDpbR2a8rDn5H0ABvDyzDHHV9/koS1zEBRDHKUOT9H012qCnQ
 79J9CHuXMGB5zJuq5ZW1QeLV4DKzLcFXYl/DyhrtLRWL/legbJTtczWoGIY8pUkfl53A
 VMlFIw1hx1j/PvDVhFxC5zwiqdG6klMgnxGTFkIkWwtoB8rbe5nFyOKkonlLSD0NYOdQ
 LF8TSrfzqAEhP4k77qbmyuoQKYWvltvgYh+wGZk4KuP7wIwLxtLyQiHdKldRHQd1gO6X Uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pgbkpb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 15:00:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NF0HQw011741;
        Mon, 23 May 2022 15:00:18 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g6ph7cadq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 15:00:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDv2NWHaE0Vtw2OC/qiKBzeOvkLucASLni+Ps86gaTxS7ydm+8n8mVd473qZXiI7AwCio08YDl6qJF+qJaluiWsawykp3nCa5dA0jFkkHDIhuWERxjmtekCcbCzzrOnR32HxQsP/8ntbiy2KJrK0gUEI8/LWaSKb+1wjRcEQSa29S/XeMjr22Kwqpca+h0dVyjr9znqNjIJxNa7LaXITzjMiUFjadlNnC5kwU0yGs+hMHpZLsjBRx/vhBR4cd/I1KVOYIF5RKwxlq56S8x5oQJSFjsxGhXTe1qjd5Ff/64CXI9fjIk+H5wPJMeUBSBve62lgwzwBfKUjt17ZJb6Nhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcFuxJVOaBJEUv7sJnrJIZ7UxfQ2NSSvnp9svJ9pzG0=;
 b=RXWHkKu0/E5pABXz5SejaCkD5E+jZqBCOWhjM5ofdxqbZoUy2jwuitz8vex4sY675Gf9nsAZHIdSuNJq8Cxhehv58P6ROmQrBzP1KzmBmcqEFu/4/3A7JFmk1c6YavCAgdB5MctEbz8co1nWLAHgK0M9ngRLx9cxgBg+L6S3Bdn2lVrDTC9OwSPArAhWkXg9O7Hp3W6+xkWd9zai8UITvkoZs7uY56cs0tnNHjaNPJslFvqkpG+rMrs7KY31jkkKJtcArV8WV1ga0vPLqqgRtG3t23/YUhYJ4p3c/1Wv0vwHnYqsLea0SNH6i+sKFIVLZTMeVynw+VA4BIqUq6rFtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcFuxJVOaBJEUv7sJnrJIZ7UxfQ2NSSvnp9svJ9pzG0=;
 b=GhE6d9C/716DnJrQb5/i/+v1ozfcD6Q7WlWwPqqa1KVPgntfNIGnEz62EahnLtbOzi+jmEYLEg616YnY4MHkhs6eWC4Lmhw90QN9921mDAHPATwyunaJ9q7ezA+XtY30lytpyOyXk5UBIC+wW9EA8Cub4Myab4ZSGNWBjEbBK5k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB2876.namprd10.prod.outlook.com (2603:10b6:5:6a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Mon, 23 May
 2022 15:00:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 15:00:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
Thread-Topic: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
Thread-Index: AQHYbfIMzaj7dJY/skSZB97V0kxLh60seYcAgAAWLQA=
Date:   Mon, 23 May 2022 15:00:11 +0000
Message-ID: <510282CB-38D3-438A-AF8A-9AC2519FCEF7@oracle.com>
References: <165323344948.2381.7808135229977810927.stgit@bazille.1015granger.net>
 <fe3f9ece807e1433631ee3e0bd6b78238305cb87.camel@kernel.org>
In-Reply-To: <fe3f9ece807e1433631ee3e0bd6b78238305cb87.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 610eb6e1-d390-4da0-84ba-08da3cccef5f
x-ms-traffictypediagnostic: DM6PR10MB2876:EE_
x-microsoft-antispam-prvs: <DM6PR10MB28763AAC351BEDB3E7B4417693D49@DM6PR10MB2876.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rkf+oBhkbBb3oEOA1X1WezQ9pRRufL/f0BLbOS51NkzK/anjKvy9UdcJ15brmhU4X/kExnSwcLc8SB8rDnjR1pD1p4Od5W155dJVGjcx+D6USOmDF1qRQXzQi7YdWnl7TV9oHvfxw8Q6NZAyyzcmpy8xNat92t4/iEjr+pnK1hr+HrvlXe8EKw1xkKHNxdh/fUTiRRwIgvcO04AswrAAoPsXk0krlHGtxd+QYqGv5XAVk+bTmtLQAvCP4H4e6rYqlVH8tH5q4XlJCgDAHfqP44bO4FGzXs4L4QGB+wWyenrIlR7lwwfBSLR8FZ1eXDPsjgApSfb4o1i0O9RpP1ChOuHT45r+jBQtP3ogk/fj/kngro7VopDU5SwWfAvZjq0SJNThDLE6Mn6HB8diGw5dJMCkIrHvDVRWc91uGLUUSc170k3hPst4AOtj9ajN70ykTkJrLyhbSp5iPMTJkJe8PePk1+j/oYdT0jOnACSM/RTKIbo0ykwDIEEx9kaA6+qyP6921LVpNuZ0f3KSYjC8o0Qhbw+bzPW0UV2AKqLrSBzqnCVYaDA5I435ffVNatq+ttaPQ016fCJ8R6nAYyM8duOJRNk8hdJtK4qjepuQdzZwDCH0FjYigEkG2eQCG8TXunlA0qtZyGAyn81jEhwvmNpZPJbfxRL29wMCg4ae+oSO/Qi5r5DhaClkSOOJhuqdD7gK9k5ByOz0Ht2cY5oJ8sO98gkaGXkFVbZhpf0luNZgJDWMArM43jk8MKzJ/Ry+BGgYX6qiJ0g7V1wOaDGjs83iTSLLEPg7JbCXw4XGElJOwD5otnpOgwJkK3wfbBgeLP2WyXquaou4DixNQwzARv501t7iQ4KbGtKccRWWAXwd53DhGifba7SKm/8N5VxQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(53546011)(71200400001)(508600001)(6512007)(6506007)(38100700002)(38070700005)(8936002)(26005)(66446008)(64756008)(66476007)(66556008)(4326008)(83380400001)(33656002)(186003)(316002)(2616005)(2906002)(36756003)(8676002)(6486002)(966005)(6916009)(122000001)(76116006)(86362001)(91956017)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VeG6LoFjTseaaJAi+xMm2OXOZ4HB/vcc1I70VcYqZvEZxh2yQS1LNfm6APCE?=
 =?us-ascii?Q?yKYgiYw1p0J/b/e+HarDovaQ4QxqlDxh/M+uViVZKcvL4zczL6qq8d1fW+tM?=
 =?us-ascii?Q?aquQwXpZzOk0EQFko4MfG4CwOp1kwvxAnyJ7IXYPNjF3rgDdTTwjheQj7Yih?=
 =?us-ascii?Q?4k8fvWHbUY5XT/jdebX4ObAYGfEP10wPEhxTdpeTuJbZKi2YpvmoOGUTyC+J?=
 =?us-ascii?Q?RBaE8xHVLz51i0VYGUayFhFARxRKGS/nBAikQWZ0YF/dyusrLv22Q9DFaPbZ?=
 =?us-ascii?Q?iWiS0Hxa71utaiMtW54RM6ChDN7Ll6R5v07+KGVvlZIl2CLt9T4DELYjXmXH?=
 =?us-ascii?Q?Dl1amCD1opfw8ribSTDtUGseCQgZZjRZNDUeQwnsSNNTXTUeo2DS0rZf0yHb?=
 =?us-ascii?Q?bYUZHFvmQCb8qUGxeKznH9LNLY0BRUFedn4EfgUEaLILx6bKvR2T3IGcj207?=
 =?us-ascii?Q?3z96CsoSPHKFIJySzIpKITNXnzyB2qka/9WMEJMxCpsX2aqHccMnej7b9oQp?=
 =?us-ascii?Q?WU8u5e6I19yg1YK6lmie0TBB14kRgPAzRdtGBuBfDCxeipfRBHEUiYVhMFm2?=
 =?us-ascii?Q?rcG9zSy78I06mQ/5pgb1UgR3lx/H0P/AVqX7RYG6iruPWD1tKqVfOQZhooeK?=
 =?us-ascii?Q?H92EC29yhLQF7PenPPgrtT0qu8td2OYP8Jub1vgXhray4QTEPaQhar4Wmfsi?=
 =?us-ascii?Q?h4LTk8JRN8Ke8r1w1qn0pM09Gs+v98XbEp4MmhXSugLFWW5dgQVA3Ugv2Ozy?=
 =?us-ascii?Q?gSRHByA7c3ZoCRr5EfiTTmFFPAhPr//IMhK3bYKdHjM8jvJsVU+SG4UZ7b5n?=
 =?us-ascii?Q?XO7f7qOk3rDkOAqqqOS3pKZfLdRqFrsvj8EKvVheU2UkvOY/BKMfrCkhgqkE?=
 =?us-ascii?Q?uhZdWZBxiW5y8nu8++OO8sDN0p3V6MoOvWg1hNVUkHmPIzwR+lrAxOWYDaMC?=
 =?us-ascii?Q?aLnCRCnWGQMK37S43imzT7ejQJc8vduFpepAEd7LqLnPOIT92Y7Me9VkIQxK?=
 =?us-ascii?Q?9SV/irsL6G8bKNlWADd+jRSLJIJQtcVJJTNr34GY8LM9dpOmzoNk1OHBvu4s?=
 =?us-ascii?Q?slW9odTUvV7JUWsD816x+Bagcb0lUmmsXNrJpfu7ghWTRAT4/a3570dN03bQ?=
 =?us-ascii?Q?GS6+b0shJeK7qVpTqK7aUHc33qXVemVZxu9iY7KWuKVKF+BGW9oUxkuC6632?=
 =?us-ascii?Q?rlx5sYR72BisrMF7Rkad+TWRRu9Q0ffKeLn4TvXB0z0NqGhEOBpH9Z/RFqQ0?=
 =?us-ascii?Q?QcEj/NDj3cNFMfQ7eeKgbUvhg1spiRJSofzHYoqoA87xACT+7EweCyJ1G9ZG?=
 =?us-ascii?Q?/f7XLtNp0Wk9IsTQ/OV8N8kGJzICtp2jQeOmJG9KyV+A5aiQyugjnTjWBnEK?=
 =?us-ascii?Q?M2zHdScx37n5WZ/OzHwSymLHMEiCnhvfS4yKkrvLW1BWGozfqSFy5keMZi4/?=
 =?us-ascii?Q?udWvuRinT0cGDEQTD4bXGqqLhll0dbUIFLeS6Xp86loNKovLw1/g8rp+rS3p?=
 =?us-ascii?Q?kt9R3Hf3DC1OUuoGqDLnA0yGx980PIwu+pBQnVNrdSZGplnSLguvGt9EdK8K?=
 =?us-ascii?Q?KdWWWyv7MI+u9XV9MjTCKcb4vosAuWiDR/ynQBG6nvg+S6VQCdP78DVL9/Pd?=
 =?us-ascii?Q?qJFP104qkSCrMJ15HJruC4f/AwZvngYaRLroz0fR95PG4gls0qaHaCLC7yEB?=
 =?us-ascii?Q?wzLskWwurpvReCRXzZcTtkMXYKREZSuKQgqNvXIvYBfSFlxzkrlqzlBzrQoL?=
 =?us-ascii?Q?CgsbvGxJz9fhhMZrwaBKVU8AGQypST8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4E651E0D76BF864F8DEFA48E71D97844@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 610eb6e1-d390-4da0-84ba-08da3cccef5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 15:00:11.2887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QFU7A4JH6gvcJZLjxDLDnFK5YWWixY+FHDcxULWEScqgR6BAhvNjF7Ub6XNu7MLi+uNeDxEiHE/BlhrfLk1kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2876
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_06:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205230085
X-Proofpoint-ORIG-GUID: Xmc-1Y_-BBkYU-XotlGlvsDQyljfiggT
X-Proofpoint-GUID: Xmc-1Y_-BBkYU-XotlGlvsDQyljfiggT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 23, 2022, at 9:40 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Sun, 2022-05-22 at 11:38 -0400, Chuck Lever wrote:
>> nfsd4_release_lockowner() holds clp->cl_lock when it calls
>> check_for_locks(). However, check_for_locks() calls nfsd_file_get()
>> / nfsd_file_put() to access the backing inode's flc_posix list, and
>> nfsd_file_put() can sleep if the inode was recently removed.
>>=20
>=20
> It might be good to add a might_sleep() to nfsd_file_put?

I intend to include the patch you reviewed last week that
adds the might_sleep(), as part of this series.


>> Let's instead rely on the stateowner's reference count to gate
>> whether the release is permitted. This should be a reliable
>> indication of locks-in-use since file lock operations and
>> ->lm_get_owner take appropriate references, which are released
>> appropriately when file locks are removed.
>>=20
>> Reported-by: Dai Ngo <dai.ngo@oracle.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> Cc: stable@vger.kernel.org
>> ---
>> fs/nfsd/nfs4state.c |    9 +++------
>> 1 file changed, 3 insertions(+), 6 deletions(-)
>>=20
>> This might be a naive approach, but let's start with it.
>>=20
>> This passes light testing, but it's not clear how much our existing
>> fleet of tests exercises this area. I've locally built a couple of
>> pynfs tests (one is based on the one Dai posted last week) and they
>> pass too.
>>=20
>> I don't believe that FREE_STATEID needs the same simplification.
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index a280256cbb03..b77894e668a4 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -7559,12 +7559,9 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
>>=20
>> 		/* see if there are still any locks associated with it */
>> 		lo =3D lockowner(sop);
>> -		list_for_each_entry(stp, &sop->so_stateids, st_perstateowner) {
>> -			if (check_for_locks(stp->st_stid.sc_file, lo)) {
>> -				status =3D nfserr_locks_held;
>> -				spin_unlock(&clp->cl_lock);
>> -				return status;
>> -			}
>> +		if (atomic_read(&sop->so_count) > 1) {
>> +			spin_unlock(&clp->cl_lock);
>> +			return nfserr_locks_held;
>> 		}
>>=20
>> 		nfs4_get_stateowner(sop);
>>=20
>>=20
>=20
> lm_get_owner is called from locks_copy_conflock, so if someone else
> happens to be doing a LOCKT or F_GETLK call at the same time that
> RELEASE_LOCKOWNER gets called, then this may end up returning an error
> inappropriately.

IMO releasing the lockowner while it's being used for _anything_
seems risky and surprising. If RELEASE_LOCKOWNER succeeds while
the client is still using the lockowner for any reason, a
subsequent error will occur if the client tries to use it again.
Heck, I can see the server failing in mid-COMPOUND with this kind
of race. Better I think to just leave the lockowner in place if
there's any ambiguity.

The spec language does not say RELEASE_LOCKOWNER must not return
LOCKS_HELD for other reasons, and it does say that there is no
choice of using another NFSERR value (RFC 7530 Section 13.2).


> My guess is that that would be pretty hard to hit the
> timing right, but not impossible.
>=20
> What we may want to do is have the kernel do this check and only if it
> comes back >1 do the actual check for locks. That won't fix the original
> problem though.
>=20
> In other places in nfsd, we've plumbed in a dispose_list head and
> deferred the sleeping functions until the spinlock can be dropped. I
> haven't looked closely at whether that's possible here, but it may be a
> more reliable approach.

That was proposed by Dai last week.

https://lore.kernel.org/linux-nfs/1653079929-18283-1-git-send-email-dai.ngo=
@oracle.com/T/#u

Trond pointed out that if two separate clients were releasing a
lockowner on the same inode, there is nothing that protects the
dispose_list, and it would get corrupted.

https://lore.kernel.org/linux-nfs/31E87CEF-C83D-4FA8-A774-F2C389011FCE@orac=
le.com/T/#mf1fc1ae0503815c0a36ae75a95086c3eff892614


--
Chuck Lever



