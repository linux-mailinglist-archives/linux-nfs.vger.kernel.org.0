Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E40F61F749
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 16:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbiKGPLk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Nov 2022 10:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbiKGPLf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Nov 2022 10:11:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1C71DA6F
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 07:11:34 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7DKplG026778;
        Mon, 7 Nov 2022 15:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uV0u/Csq2CD8jiCXQoegNe3VzLf8idXHHpMankpx7mA=;
 b=fYyDMeat+G69IwCw3yV6duo53TX09s/LH5ySgcSrNqt3uYpRX3EXcAes4qWu7q+km3EV
 6VRhf+A6ICV3f7QaFNtY4YCDHeT1fvQ8nZ3sBTdtDASlPolAzGU3t5BP03wNPoYawe2X
 Ln5DDiPkn9/EDqMYv645LlEQbEZjmsG3UlxbAQxvqpQIp6tSUzTIQiVm3orn2iruHGDL
 Zj6kdh6VO8746NV25NUfGkkfWu3ymELnE7cIsWm9CW5sdnH7eyDFLE+Ts62M8743wdre
 mBSulcukh6PCiN39V7EeImpxT+8LxreG9IyieaZqK/GF/UQB4+5yMURJAosi0GifBqPl 9Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngnuv3vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 15:11:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7EhgNh030102;
        Mon, 7 Nov 2022 15:11:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctjce4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 15:11:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2GV/rFeo6oID5M7wLGkFOeQk8CP6+2CkCvhVaa0b456rEjHfhDWEailuz8ai/EVnRdLGy9D/D9ILR+Og1RcqvqPTt3qARdLJwZV0lXH/rFn+pDmfSI4R1uTnZjbiOM8dq30i0z+MhIkgDIdKD/9uJi5iL62B+LMhGrmoZ5vjVt/utvencQSzyn6QYWCuIVfGgzsyCHiJG7wi4VSPlLy/M4kiOag1IdXahmP87LqEPw+JFnWvSNqBEcWMjNQ8SsdHZrKl/nWtEs4qZNht/4mXqwAHAc3LEXuTKJaa/orzGsuvtM8XW+xgTyV6FPrX1mn2N0iKcZg+y1V51i/F4i9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uV0u/Csq2CD8jiCXQoegNe3VzLf8idXHHpMankpx7mA=;
 b=VH8JYCYvKzdAvxayAAvjpuGdbcmVUGbWVcjJPRr5mRxA25NpSqR52pTTtBHJJgXy3KiaQ+cFpmjPqWId1lXBfn0KkgpN0PJ3y6LgSHxnaYsALBNj035JmMlwIbEkF9rQq/elX0qTVGTvFatdNpsfhz1+mn8KB4k2Kg4Np8yYN08++uhJ4+QzxyZ6PQ3/JmwLrS0M88wPxi27WU2bCh3yyfFPldb1sTKTGBO3aNoK29TLOqJXBQxv+d1iB5AMzIjBaLb9U6HSDaElPrKG+VGLHZqqfsxDETxigNFimbcmTMiEidraAhAh8qGQxOwBSodZZVeENsaK70vMIKqG/+skMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV0u/Csq2CD8jiCXQoegNe3VzLf8idXHHpMankpx7mA=;
 b=r/xAeRGSgl92LU1SY4ttKomxlMpzIj1PbvqPc19XCQCAVCCxlfLr2xAB0KeIVr70fkc3b2UljQuIZu2paL0svYH8Kpyvq9MA6CIvJLWEYSxui2U2VGYe6jSIuh7nwzS3eUE7gGdeGgr5i4opr6TOhn1Xe0BfxrPW746FsjJwnYI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6475.namprd10.prod.outlook.com (2603:10b6:806:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 15:11:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 15:11:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: queue laundrette to filecache_wq instead of
 system_wq
Thread-Topic: [PATCH] nfsd: queue laundrette to filecache_wq instead of
 system_wq
Thread-Index: AQHY8rndf59pLVGVO065DXdRZAFKja4zkPUA
Date:   Mon, 7 Nov 2022 15:11:26 +0000
Message-ID: <2FC9BEB2-189B-4EF6-AC61-40263BC47737@oracle.com>
References: <20221107150128.46951-1-jlayton@kernel.org>
In-Reply-To: <20221107150128.46951-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6475:EE_
x-ms-office365-filtering-correlation-id: b8d5df39-a61a-4b7b-574f-08dac0d25781
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hkv6hHXPbvSrFqwjvfRk2E/GeXKMJm+QzedXPC6kmmEiIgKoTCNroHx7mSb5PZXid7cOusMKnn0qscCGEhhR5IQqOuHEwYbrKLCoN/1KtM0QGHifkwPYR4h8mcQ397pD86gwJhKx5G1LMvuVy7DMozDQAApGiB0ca2ve/pA56YFDEgZUtvgWFOctaMHvwFT+SO9IZGFqhushugqU25JlZuP405Ff5TiIpcRnRl/jrIX/ONp4HaRkSwX/rnpifQ2BYc5i2GSWnxGlzm+EXmv6rIS2IHFMjxPQPrxrU3YujyzfK1NW4x1Y70Mxr2Qk/gF6mNov2yIHvtkStzCTnrl8L2KqNE1dwBV+KXWOyqkb8BIL1DNt+1kVRGp/u6Y8SMfMYWGup4tL1IZt5O1g8I9N39+RghvgJxUgDkvwN9qMEPL455ZOE+VdJ1WSL31MfUtYPbk8UT6KGNNH3Kg9D6XZHhR5s8Q436rSiUoIV+s+dE13i5i+Y9QDTFvGs69FpkG2m6rFuXTLC45MUuoe+eDb8ggZHIPZ4KcCHAlsG5aOC7ikKYjnJ8kXrQ3XRYE4vmD2XAVWkpiQqPE6usiCw+XzrrmVG7f3T9Q4hsxXHJR19RNeVa95cGnp17AGXhvd7U4HQBkSmW4Lm+KL23zE9XWJZ8uz3Wti2ZU1entQI5KRa0xkUw3bEIIgzbW/9YOm8etcjCwE/e+6jGUOj19c7XE1FzALZtEm6nRYYqSACXEA8lVarcjgsVJQPAMb/tQ/Gr096b+zsuODt7qC+jc78M266sVD4pk7jp6UCrB1M6grGT4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199015)(53546011)(26005)(6512007)(2616005)(186003)(6506007)(83380400001)(122000001)(2906002)(66446008)(6916009)(478600001)(71200400001)(38100700002)(6486002)(5660300002)(41300700001)(8936002)(91956017)(4326008)(76116006)(316002)(66946007)(66556008)(64756008)(66476007)(8676002)(36756003)(33656002)(38070700005)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W6o5QXdqMVIqpCQZr8qZZ+OIqFNtq23I+tjrRftFbYFsbqpg295SSYsl/RtJ?=
 =?us-ascii?Q?BLxBlIe/hCiE48bCwcd/z1Az4MhoyPR0YqLamUVRtLHJa4ExH24TUuCplel1?=
 =?us-ascii?Q?EXao6v7sLhH9dPkKEGV1TnPIKUnvYeWrJ2MpRGXfHk7VlMFhoXs3xuVLb/IA?=
 =?us-ascii?Q?XoGpt2UMuFWLJwrMv6oZUQ/q3QLyekmWWzs8CrhqSU6m4TED6Z9fxinGg+th?=
 =?us-ascii?Q?fZ0LSSHnuECcQIIt5+JLx/pT7JPrp8Jt3BiMpooI1r/xAlZmPRXUbziIGa4F?=
 =?us-ascii?Q?A3uTmtAWUzO0QHtBgeOnJfDVYpOX3YQtXsvgKy3IKvJbSG367U9byQCUVn7C?=
 =?us-ascii?Q?1MrT22/YIEncoLCjWnIcLM/LdzYvgwYpiHfBfp4tO/QAP0yTP16JLbROTmXR?=
 =?us-ascii?Q?xa+fn9H1KOIbRePxumvpzXtSfzgFy1qBbN/c48tCRcXuKI+Sh0C8P/8beoWc?=
 =?us-ascii?Q?3RLrVvQ4lpQXS1gHRzo+rKcQjK3V5HeDyjFMIdsdgKsCUyE5I7y7A1Uat30b?=
 =?us-ascii?Q?Nj4iH4IWWO0Yuj4OSUc8OtwK5swYEV1rcdTUrh4kNkOEl/ptTlUzxMfca1Di?=
 =?us-ascii?Q?/hVnvcS23T1Ud/o3LBWlwaEpKqJoGhdhJnBs+CmrOChb3vriXi/6pavy8vvA?=
 =?us-ascii?Q?MyVVYdx96n0yga3Oyys69dTscL5UBlWJFu63cM2xEBTkhETFz+6bAc25kFWw?=
 =?us-ascii?Q?mh4mFpHH6C9zozDzvR/SXH3pNlW2GmCDG6FtIJsArcZ8UqQWxBJ38sFBAcc1?=
 =?us-ascii?Q?ybHAvf8ShYOlf1vY1OLFEKu4u5u4GSQxytXWeCAly5mzQOdC8vzuItzY8eHK?=
 =?us-ascii?Q?/tFpoVfUimUywY/LHSJryfnPFe8jZ/qK1jP2QUL4+XWxNKp59oU1Yy9r3HOq?=
 =?us-ascii?Q?FkgbT7aJ/gli6J6TdtmCyule+5IJ3yZ+Ey14AwqkYNWPOxz8lGHdQGyNveUm?=
 =?us-ascii?Q?cMBO/xljrlBU4PpCwmxKVx63+3QwhN1ajeU+PdXzshL+a15IZN16OMOKv/jC?=
 =?us-ascii?Q?4oUwMkyIgNXttHMjE3o4Sfi3SjzsXEaFBwF383HrxNLLHsbAANrR885taV/W?=
 =?us-ascii?Q?vc92GPpJUj2Z2OgB+OtVBbrnuponG4tO7RGq3m5ubCCfiR8RR9CeYgVUfRt+?=
 =?us-ascii?Q?ye/UpXJkPxnYeWr+RPjDTzOlPZSaxDr4Og/QQx7hqP18i+RFttj75zSG5OOv?=
 =?us-ascii?Q?+AR/b/8Ds9R+0mKydwIN9tYSRBJVdUjxp3zaHZ3E3feoK3p4El2F4hQzM8YS?=
 =?us-ascii?Q?uo4HFmpQTBa+ITjC47NmFCqRwOc6n3rQMvVxX2pTVPQHNM7Vvl2xHyyGZ8eh?=
 =?us-ascii?Q?inydZ04IHif6352WGQ1Kw7/SCWvmGv2FmX9LTAK6ss0y1QIb77bWj4jSc/7f?=
 =?us-ascii?Q?yEjazgJwqSLH9kg4SOMT1y9jklM+omoqrNyGC6pez/Khf0QvaiHhw6vUNLbk?=
 =?us-ascii?Q?b2yvuM/1KAEyqB0hUjBhodgd1xXUDFSdUkDvk3tGNEorSn17X6qF0KH6ZcJi?=
 =?us-ascii?Q?jkpiStP58KU2ws2h8ivLLZ4yCTW1qK6IGe3Ea/UQvlBPKPmW5kA1K7Q2LWK7?=
 =?us-ascii?Q?CzVcH5cZfA6lkiAxS0GuLpSKsEMi7shZAka86YAhPQxTGne9gnoXeKSPf7UE?=
 =?us-ascii?Q?Ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <869FEF4BA627A1499735EA5DECDE8E5B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d5df39-a61a-4b7b-574f-08dac0d25781
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 15:11:26.9636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /J1+yVar8VG/8nIN4khm3QxDCZbb8iX8bUXFi1vu76mh9tbh++D3fBs3l2X+GzyAluYzdx0wvMYzSN/MDmm1Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6475
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_08,2022-11-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070122
X-Proofpoint-GUID: ZRqC11sgTN_yDPtpw3DI2cMmf5pTOC00
X-Proofpoint-ORIG-GUID: ZRqC11sgTN_yDPtpw3DI2cMmf5pTOC00
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jeff -

> On Nov 7, 2022, at 10:01 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> nfsd has grown a dedicated workqueue for the filecache, but this job is
> still queued to the system_wq. Change it to use the filecache_wq.

Actually... there doesn't seem to be anything special about
nfsd_filecache_wq. 9542e6a643fc ("nfsd: Containerise filecache
laundrette") does not make clear why it was added.

Playing devil's advocate: why not make the converse change and
replace it with system_wq?


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 1e76b0d3b83a..018fd1565193 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -212,7 +212,7 @@ static void
> nfsd_file_schedule_laundrette(void)
> {
> 	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
> -		queue_delayed_work(system_wq, &nfsd_filecache_laundrette,
> +		queue_delayed_work(nfsd_filecache_wq, &nfsd_filecache_laundrette,
> 				   NFSD_LAUNDRETTE_DELAY);
> }
>=20
> --=20
> 2.38.1
>=20

--
Chuck Lever



