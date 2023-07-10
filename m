Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E197774D821
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 15:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjGJNr7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 09:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjGJNr5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 09:47:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DE4FB
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 06:47:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AAOD6q014675;
        Mon, 10 Jul 2023 13:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GTag9X3g62TFGvQTWHskqOFFDHI8zNHbGVToLn8ep08=;
 b=PCVPMVk74+X4k7SFc6fDYi6aZ5WeujFrHo2WWIlZPXCpjyDLu6zVNyRhdjebb7ERPFjW
 zN4f51fdkqA8SI1Phq/bqWHEz2HztTowCHqXcQzrNW0lUM5ZLtB4/VHFSTi7xKSRiu7k
 u+F7OQjeIf4zGcomwAVI2zP6XEOwNNtroJtnQImMbHbPray1NyUDIHg1/oksWoNYPAGc
 gLFxOI0yGxkYh3SOb+j3T0Ek2Bq7uKPtl6kPWNX6Q4BCH0yFuqiCan1Rp8ZLSJekAfqu
 6hJNDhxhUjgsQTJKXWYk9CzXxF+BR70z60Hsk4uoZZq5E3doRFqpnLJ/pBZWgiZP8sE5 MA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrea2rj4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 13:47:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36ACRMpj016133;
        Mon, 10 Jul 2023 13:47:51 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx83gdus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 13:47:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2FfZEzLvepnLYAMn5QJr+/Z1nh3CGdfHo9qqAtdUtF6xjee6cg9ZbdzD6ovXipBtfBX5axVsSIPFjHLYCFp3Wr7ya4a/aZ5qFcn3vHVuTVE0eyJE0cmj4KdR4Nz7YuzLm/S6x5aY52FZCwDrpqnSZ5AtmkgeGVsbbFM35x6iz9nQ+IxetSmDqeas8KOcICZvpl5vg91lHt+RTEuy+FiAQtExC6SNpcJqXTWq7FIuUqeKeqYbtQpDN9/XkzoynLMd60rd9XaLQK0cVI62v/rINvvy9StyBq3nK6zIfssHebdtFFN6plJPB3YrOvgQOOETkoLmapUsbylQyCPCiT1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTag9X3g62TFGvQTWHskqOFFDHI8zNHbGVToLn8ep08=;
 b=nJWSgcZ2BwfSnOEpWFVAH7cW1Rs5gBHIuVRduIvVH5JnIpW4mFVZkUsWJlInyq3DxxZqU15D+FYA4iMIb3YMLJplyFanzeXcggRQwgwZAug+aiXrezVpRabtu4Y3N0n4CGqC7/w9pA03yVugN5svMFTU9nmumqvuqFYO/b6NaUOsyvZ93YiDi4F1Uovfp4M4gToAxCXqYf4Fi9Imw+tK+TDwkYLIAec7gpLKcDGeIpd0Y3v/Rfks3xMWGJCp/nWJ/ne/flD2JK76fqH2umtQRI7tu3brwtVO5OxeJQxVY/SdI3HQ0NILmZpSVxYBdmoc5W/qqK3dnUsaVQC7BETgzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTag9X3g62TFGvQTWHskqOFFDHI8zNHbGVToLn8ep08=;
 b=TujM8KRd7z7gP/5zM32N/ebfBmEk7JlVKzmk4wKdv2yCz7v5uMAif8OTn1fpWnFOd3gD6fA61pTtxxhY2XupGAkpbYfQwyP8GxUUxpm/edQmC8dWOaU6/sqwjZ97QLIFbv03F/mTwKimGO8v+4jZH21vI3GIcdp1xoUAFGwpqmk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5087.namprd10.prod.outlook.com (2603:10b6:5:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 13:47:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7%3]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 13:47:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 0/6] Fix some lock contention in the NFS server's DRC
Thread-Topic: [PATCH v1 0/6] Fix some lock contention in the NFS server's DRC
Thread-Index: AQHZsnxbV8dyPdC2OEuC2hGjvlROW6+y+MMAgAAMcQA=
Date:   Mon, 10 Jul 2023 13:47:49 +0000
Message-ID: <0959A996-3FB0-4920-AB5C-BE84A7339DE9@oracle.com>
References: <168891733570.3964.15456501153247760888.stgit@manet.1015granger.net>
 <35ca6665f3cbedb60b904bfe4e74ca37c32af985.camel@kernel.org>
In-Reply-To: <35ca6665f3cbedb60b904bfe4e74ca37c32af985.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5087:EE_
x-ms-office365-filtering-correlation-id: b5598fb5-20bc-4f95-33e3-08db814c3fe3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GEMpB61AuC/ZFfHBSYOJOEpXTbFEy3NkOP+UxrE7QhpfjZkKynJcThWwwu9i1JFkma1BkDqlUz+/khH5sQimFmo4X7hymeHEtlH9aioFfsolgMg71G/3oteJFjpKuFAS/5Q5o8qerU6j0LpRa2eJxR0k61Ok5GRFiOk8y8b89aerX5RFHHYRFxOcdHb548juk3xVMuXWWWOydbVyPZmVoIUOK/vO0IXdkGOKKweJpOCsS6HaZ1DXU3MOn8WUGrs1hbTTtyH3WFv7Qw05JWXgErapZkCHJVO+eHUcaFrzFg+km8uCX/UuFFGaI6SFMNtdwxIdba4ENr4R03VcWGPb0HNYE2khEDByy0uU6hQLTVIAhriupDIc1QoT/Cp+jxNWL6qHyUG4bhOayeAwCLJfhyK/epkn3poMTdB+gtrXrJFzz9cdCvnuNfACR4e4r1n+oByj/TajEgvt11Oz08fhXIi1qhsCHsbG+KoiuIGAMtQxGp61JL7UAcpWh4RU5UFWY7d+kaimpsATayltsul/L2FUoidNO08sxtZLm01VJZrnV8w1zyiJO68hjdjk/V/20LY9mHKjo2ojX+nHURIo3zoZlw6CQbJWSJLVxIYymBM5vi5KyzKFZU8DDOTDwvktq0xcNigPg4hDXGmCwfN8zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(38070700005)(36756003)(33656002)(86362001)(38100700002)(122000001)(478600001)(71200400001)(54906003)(6486002)(6512007)(8676002)(8936002)(5660300002)(2906002)(316002)(91956017)(6916009)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(41300700001)(2616005)(66899021)(26005)(6506007)(53546011)(186003)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RwUkuFr1AHOymM1v45kgEF3a7Ulby6KXTp8sHXon4z+yxfej/t2VUrxQElTU?=
 =?us-ascii?Q?1p8EtZPA0S1rE5aFBCcvYqbnNDmARj1u2/NAxsTWJcTscVZUphpQv+3px5LB?=
 =?us-ascii?Q?jTlfFF8152/CFq1/hEbm8e67VSACk6xug21i/Aw09Y95NN+/8qm1U2xcMlfJ?=
 =?us-ascii?Q?/OJ1ArmXskOTlRmKL1QeomC1sv0RmASFOggK8h+2Eyr+144cypTIS7iQlGtd?=
 =?us-ascii?Q?bLqgX+2IdGcPAxjsuYWFZBmq0uOLn7EhIHaG/UAjmy2HHlXPzl7M/uF5sJRv?=
 =?us-ascii?Q?dJQxO/7GLah5PpglItWPHRIz8AuD+m9ZvnENlmAU9v83vF1LX8hGWJlOTtBh?=
 =?us-ascii?Q?HZvmDHEVoehbxZ8YL8NTYi+buwWcF/+Mogn3yDwH18wzwsbBS0xW4tBrGkVi?=
 =?us-ascii?Q?Hx3uHYHp2XO1DX4Y3f6f4dQ6PLnEwKp6QlkVGEqCch6W4zmOL+gnDhpJZPIC?=
 =?us-ascii?Q?VAZ76QhaxgHVP2SHKZxJjcD8+H7VEm33J9IJXLN7/dDSGLIokn1ekJdRvrSG?=
 =?us-ascii?Q?kptlPz+HvefBW6MQVJGgQcwzWC1HTp80MYSDxDujCj6vOJTY+BgZyofKeyv8?=
 =?us-ascii?Q?aI3Fd2LuF7FA25VOpEwHYVwmqFakVGvLAApUP8QBPpcMAN7dslhJXE19DKQC?=
 =?us-ascii?Q?1uv390NSktABrhlNQGvfun4Q4Qlixb4iSDC+UweDUNnlCLUg8NkAVO/aG2So?=
 =?us-ascii?Q?AQXex3STt8mO8fpzqzjV8tl9/vY5zfnr0D7C+n1TmJc29HxKF9sNhvbhZfIU?=
 =?us-ascii?Q?XVadLnBwjvk+ZipF7EGOUeqGhgZga0ZKttSEUyUGbepYk4qHokOPnUVLQquL?=
 =?us-ascii?Q?wvz/d0J01Sea4IiqfF8XrQY9lAgLwjz55KuR++QefoFFgyZWrEu8hNkmMDAb?=
 =?us-ascii?Q?X3Or488F18yswlj9qYVqLm9WKgy0Ia18NFOENCA9oG4pxCkI6kUemt7exU4P?=
 =?us-ascii?Q?RDTP4QARVeWoeNgW/pg7rcvlwwHDVuvQmNtn3ETw7LnkafFSNiBEq2Buwut1?=
 =?us-ascii?Q?bkei8PFi9h20bMPMmbXOzywZthbB4aMMEinFVEVz4ups7Hr9R2/L2vlnbLRY?=
 =?us-ascii?Q?LXUcrf5Y7CM6RtzhsVmCcePTrSC5iC4Quw75MCLcA50MMuEHWO5HwdQ/p6fo?=
 =?us-ascii?Q?SvzxFv2hpV9mlksqiikdDLJCjkN0pmd/pW1mXBv51t4LEGYMVITQhT04tfm1?=
 =?us-ascii?Q?mTp/cipBSjgVx7X0NotSUaP3A/VaNZV0blCAU1KtmjYolW6gJcOicnu/Om/Q?=
 =?us-ascii?Q?mevCl7lXzTdWjkeqRIRGCyqahkkf9+x+udCyBmJYuuP1ZEwLl7ZoDrMa8veg?=
 =?us-ascii?Q?PJb5fIPDN+5Yn9dGDpTOpzMjf+D35Wq6L0Ul7MVKECdWtJd5FwgXFf6mDI0x?=
 =?us-ascii?Q?rcoG0zxleymSZd/xxxCdA+9Kw1tWVFhHVmhhzqvVHF0R6ts8AsNgKgUsuMc+?=
 =?us-ascii?Q?98jMUeHWHdKKw6zkAY8WZylTpAmHE8/aFmlgqZR/1AQ0X4u+aYtDcCShA/Tb?=
 =?us-ascii?Q?fSNkLZFJan25jla7W2Oo2W2xNAAL+L1bde7ctH939+JanmQR4VTy6BzWzhWc?=
 =?us-ascii?Q?INqWGhjYl6PtB6A92eAr+JZf/NwMA49GdgYxQ+MSBog5jCLz+3ktmUC1FZ3q?=
 =?us-ascii?Q?wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1448A7C7BB75C94C82C66B04E87967E9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 49F0ej0zhnMvKGj13jpS3TyAeRmACAMn4Z4tWfThuVBMNwOyLxuiB69WXyfX2cOQiL755MK51pR/8XOescnkInG/f4KAWXXw97iZxqDiUs3nc56P8RA1g9t8ncTvTa3VgBuhiMHKwKf4oWFjhNxjNUwhRKTFlC6B9Pk+rB5FXs+LGMCFQQqJx6vdvIVMfyxmo5nkr/eQshsbb5fS0XL+LoGRKc+UEqML8FF4p8k9DZwZrratWu5h6t8B/4PU662UOK4qQJnFgQXRMEVs3061GKo+Xl5rYeEjdqdl7OYvB/+xksL5Wj+DqvMdG7z6w/4O5c7VDIan6wjMLHzJBB+OAL4CSkR/cWvmzyklm0Xy/46ywN/ZVqtGXKy/Ltk26Y24+dGVaVWhxSy2Bd7wiWR5AWV4Ivzfmtkm5OPVUwL50ICnHDSC2jq17r3Mg8Rbsc1n/zr4p4Tj/TggswxRDfX7tjlk4JePw1GFsqr7n4J2nCnfZfuq244bvmrgOz6c4uvPYdEckBA9hNw22qHSaWI8IlqSYcvM+knJgk1PzuA/s0Fvq6EsaapKUQP12hjx2HRtYi55NnT331YGT4ELQyhHhGOboJIOvnBmwaIrKXFIfiMPPmJ0GMERZE+3b5xjJdTsQ4uKnm0HawaAV1OUs6uA88CbgFPl1Vc+knZ5dUEZuGhQwh2g9/coLRxR52YrkERIFvoRLF8aWexQr6eXkev6E1PFS9j66ZFLHNMrqKW/89mau28oRLKOJxhE7kWETHu4ZTEk3XBNshvgTdAmr+HzXeBjjbAMvfp/PCxuwYKpGis=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5598fb5-20bc-4f95-33e3-08db814c3fe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 13:47:49.2119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fgn5h69+PhTvD8j6O4+rIFCxQjA5mIiVRhC3v3UU5bh3gAUTX4bMV7L5B5cJKVdCLMAyf0ccJNB9R0NZ0xKEhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=983
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100124
X-Proofpoint-GUID: 3Df7iEI0nV_jXVMZfjZD6bWzxiEBkUvU
X-Proofpoint-ORIG-GUID: 3Df7iEI0nV_jXVMZfjZD6bWzxiEBkUvU
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 10, 2023, at 9:03 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Sun, 2023-07-09 at 11:45 -0400, Chuck Lever wrote:
>> This series optimizes DRC scalability by freeing cache objects only
>> once the hash bucket lock is no longer held. There are a couple of
>> related clean-ups to go along with this optimization.
>>=20
>=20
>=20
> The conventional wisdom that I've always heard is that a kfree under
> spinlock is generally no big deal. It can't block and is usually quite
> fast. Are you able to measure any performance delta from this set?

Yes, a couple of percent better throughput with a tmpfs export and
a fast transport, which is not a common use case, granted.

I think the difference is that, after this change, we're holding
each bucket lock for a shorter period of time. That's enough to
reduce some lock contention.

But I also like the shrinker improvements.


>> ---
>>=20
>> Chuck Lever (6):
>>      NFSD: Refactor nfsd_reply_cache_free_locked()
>>      NFSD: Rename nfsd_reply_cache_alloc()
>>      NFSD: Replace nfsd_prune_bucket()
>>      NFSD: Refactor the duplicate reply cache shrinker
>>      NFSD: Remove svc_rqst::rq_cacherep
>>      NFSD: Rename struct svc_cacherep
>>=20
>>=20
>> fs/nfsd/cache.h            |   8 +-
>> fs/nfsd/nfscache.c         | 203 ++++++++++++++++++++++++-------------
>> fs/nfsd/nfssvc.c           |  10 +-
>> fs/nfsd/trace.h            |  26 ++++-
>> include/linux/sunrpc/svc.h |   1 -
>> 5 files changed, 165 insertions(+), 83 deletions(-)
>>=20
>> --
>> Chuck Lever
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>


--
Chuck Lever


