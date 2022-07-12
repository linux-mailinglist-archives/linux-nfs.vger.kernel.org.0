Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296E55728D0
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jul 2022 23:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiGLVyS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jul 2022 17:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiGLVyR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jul 2022 17:54:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602311FCCB
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 14:54:16 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CLEBPb022731
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 21:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=d6XfIxLtJAOQ+4sjH47iG81ea6rZlMQ6C6knOZeNrsE=;
 b=STSqyh2K9SPolNJm6dNGc3PjoBrC1Z9T4fbHvZAmvR+RGZkPxGQElauDjbmurz6oIG5j
 MMx9T/GQRdLXjoGEazk4hCTD8UzVnWcORSO7kcNSjayFwXlff2EV62msRrXO3+hhXTS2
 Z/6hQsAYpaQ5OjKknjyKYofoB7cR8HVUPAzhCLT8Cj1fUwXfp3aCh8W0/Jnbs0I/1Pue
 HOPHxNgCBj2cRDTubqKSiLOVrlbbS4eq25++k1diT0TaEwG4yBWEhQ14p+OZ8s7vXhMi
 MhhG8lSlkXaxw9FPV9AJan/VDByTV5tDQxug7g8tTEukOlQVYghO+wzoH5Nx+VWeMGBK 5w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrgdvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 21:54:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CLobH2027239
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 21:54:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7043mnkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 21:54:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTw5CRPnejM/mOY77Ak767/4vKydyJcKGlhoGHllQjj/3NdK1ZMp6/EU9t6ZO+OHoxP4vvYE3/6ggxip/gMXvl0a6QIC3Cn2S2YUOy/Ib/MBHDWg8s6hZx+gfg8NLrNYo9Aus4KsyyT5o6E0RyL0JImcXv78L7AhdqNanodyjkp0LkL+f3Fj/5M8/xLA1N+MDPkitvtyqM80HBq2QwOHT3KnWIjDovbz+4ub7BuDW4lN0AuSGrMLIv4EULgaBkiea/AZVaV5FbRGem7fC1rw1tUDpIgyBpand/ARJCxvmQy25nnXb64i+RzkItTA3YmdTRh2Dv2NS659zOAKfNTDvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6XfIxLtJAOQ+4sjH47iG81ea6rZlMQ6C6knOZeNrsE=;
 b=nHUthtmS7Iufhhcew+BPiF6NfKOjJEu768Wbef5NXLnPCBvqUDJyievnRYHIXY0nzRBXLzhEu+7kmWQgUGlkEFSDlX0/3mgL4Sr3JWNoTfbKZifmmR1QB8MoT5JIuZoYHxWBY7wO57HWZ/MFnvnE1aHP9f4EH4+/BV6g5YYgp1Sq3JrxOiTxNBIjesGQyuB8O2x6HwoeLvK+o0NVZw3S2ExHpABwWHbBHn7hvBI4DnxA2yCCVFBftQAHgnagzfwjSjFQGHdpdPU93ISSUwmNVF3bpRdkOyALoGgWQDOuwxP6ebR8lbvEM+VCJJ2IDoXONQQMOghyCJyilW9ZYHqhLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6XfIxLtJAOQ+4sjH47iG81ea6rZlMQ6C6knOZeNrsE=;
 b=uj0TCMxtUo4bxYwtOnyVRuNZgILEigZhPZz778AkezOYM8SQ6Cn7qXR+vVk+KgYRi0cs0J3D+B+aR6aKxxbuVPiO3m93X+Wqh9t3wFFjN0xePfwPeJaND4orcT4e0te3o+ka8Ar6fh8Ohg6k4iOgHnzgjK5uAsMRkXagNAzgmqA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4017.namprd10.prod.outlook.com (2603:10b6:a03:1ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Tue, 12 Jul
 2022 21:54:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 21:54:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] NFSD: limit the number of v4 clients to 4096 per 4GB
 of system memory
Thread-Topic: [PATCH 2/2] NFSD: limit the number of v4 clients to 4096 per 4GB
 of system memory
Thread-Index: AQHYliuGQrjuLSRYvkiWuZeoZ0JRFK17R3+A
Date:   Tue, 12 Jul 2022 21:54:12 +0000
Message-ID: <D112EBD0-D062-498C-A15F-65A44097AC6B@oracle.com>
References: <1657656660-16647-1-git-send-email-dai.ngo@oracle.com>
 <1657656660-16647-3-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1657656660-16647-3-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00d22ae8-23fb-4cfe-aa49-08da64510e7a
x-ms-traffictypediagnostic: BY5PR10MB4017:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O5sbmiEOntlBvt9f1NIdFnpdPHT/raCyNJzZmPLeg72bOtayCkE+FcI0iblYIjgCFUewPogpFQOFszwbpwpCUWjuqHh+e04nKS3QgP0r9ZqWGNZN9SP0XkKDr+705oi3WlHVz9bZvlpi98Mj3kEnTl1HryIPU+HyzAegXUSuio1OEMLs5D7e19tgjU0/ahF6mQlDLQ+zhPBSrDFpf28CPjL05Ym4RgCvLjKBg6U9yzW1YJQEWsApDQi1iM/FWo1y1fvNVAO7oE9rGlqatvySFzmgJeuvJxFI/xxalIy/8p28H2oBsMlKy2l3AhLSKgGKhZoim020HRXvxqEMt/tstZcbhrChRReljIxVHIs5FbbzNQbeilhLi7WYp5RMHOXjkvMYTlztZqd7zGKaRKVE1Vh31FH203S9E+jkNyji7mJacdJlfVhDmdhDP3YcPob9q5rzI0Ly+bUkahMgF5yaHX4SEpcaLLs7q7SF+6lg3353rRLTfuSn2fLzCD7JJOdeDnUpGIurkdXS6fsdgJJzugvhnpYosDcdfE9CAc4Fug0tWZpqiq8Nk2uxDBVZpxfcGR13z7Zee1EqWs7DmDRMeSdRsfCdoNX6yIYX4r3uOqSIzydF5AvIZ1GlNEzmzHquuaUgRgOwmtnC9tec1N0LpW/o9nCnqFQO0OxqdWOQKYH9nxKPQ14Oz3cAc6RPHg4yZJYjIV9J0OsK5PMK9jxKjM8aoy82KDUKW4lGK1gChybtQ1qesuVQ04Vjni9rz1hyoUmh8KPdcoD5elbZ8RBIDpijuQ6e53MNXaYsBTsVpspZKA/xBUmgx8zo4qPFc0K9cJbgUv4Yq8NufHnQE1BrSZixzdd2nouIg/sJ4gJljuw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(396003)(366004)(136003)(39860400002)(37006003)(38100700002)(86362001)(6636002)(4326008)(64756008)(66476007)(5660300002)(6862004)(316002)(83380400001)(76116006)(66556008)(8676002)(66446008)(91956017)(8936002)(66946007)(478600001)(6486002)(53546011)(71200400001)(2616005)(33656002)(38070700005)(36756003)(2906002)(6512007)(6506007)(26005)(122000001)(41300700001)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O/n0KRHArlnX1+Gw9c5yyaHIqsFzLLQd+HGKcG4vtKR+qsKD4MvHWJYBY0zi?=
 =?us-ascii?Q?rNeocDZ7gAGKU9i6QZJVd7GH6wXz5GTJPS6PlFhbPqH8aw4wB5Xu9fGkkFC4?=
 =?us-ascii?Q?v+8LBpFYSTEjK9Vkr8HwahcfDzEeOU/cd+hBKco84kc/EJlLRIN83H+5U4JY?=
 =?us-ascii?Q?FzklSXlLCHwCbUiXWMnCIyYLzcnxGnLk3xFm1mepeG103hsEQA4tcRrdUQxF?=
 =?us-ascii?Q?Xr//q2Z1KYcgPiibA3t2B87zA7kXIcE9SS53Jx2JIRoq5KOVp+bTU6mAdq5A?=
 =?us-ascii?Q?ZxvoHPR3auCKK5F52zBUnSk5SnsGGF89to9VUtBRDYA225YIfylAAjDCsBGr?=
 =?us-ascii?Q?zC7QwpVRFBevM73g3rE+bw/4zFaEoPUyUt/8ZFn67exrOyP2/8SWM0tIdMFM?=
 =?us-ascii?Q?RtKHipImk06AdoTnp/pBZJF80C9hO0W/A9kcKoRHj2uajyrIpx1GAHnI0Qdi?=
 =?us-ascii?Q?8gacHlntQTlsoqLbaEujdtFe1PGmlL4teD3W2lh4f/T8UXuYTS4N91pZZ26Q?=
 =?us-ascii?Q?39WfJpi5STkYutSl5ASSlmV0HVUVEkpBz2lC109JMMh2cVH1RFL+GsNcE/uw?=
 =?us-ascii?Q?pax0xgHuIZxO7eQWJqlX6ibnH352whQGR3xWZCvZrMUw4kJ7Piff8qREJRzH?=
 =?us-ascii?Q?a9l27zjyT0RFm63KW+CoxPi4lEktiHpO4aPushdBw5DiaUyssQjr44dUBePQ?=
 =?us-ascii?Q?Lo0rsOQZVeKff/mDct46LGkjSshJWolJDXCU+GMH4Irit9ibE9RqqcWIJc3n?=
 =?us-ascii?Q?PKR9ucVMQg1faR4JGN4wrTyNGeTDWWUc1s25iqx9bu4ECa8t8p9XWgHyfYUE?=
 =?us-ascii?Q?3Qjn2ijdrmryyFg2O1vWIpRtU/1JZGyRkUfVtOly3EenvZ0ivHDnnErromJ4?=
 =?us-ascii?Q?VQd5i/uEpd7rDQ4bIl2sdJf+Q90IPct1tQbAZVFginyTM7Hd8L9SJvbLPLp1?=
 =?us-ascii?Q?WaABPzDzOv8XCeCzsLaZQKjzZwziq3k7w9OUiD+IbxBoj1JBuRcKker8cDaT?=
 =?us-ascii?Q?L0isLXWiI/06YXYyt+8mmYfWdau0gjsp90YWLAls5ekPtNi4ovLA9qf8WsD4?=
 =?us-ascii?Q?bP2uOmwe449TkNaszFnX5wIGaPJWQaHhNEdtXVIu6xcc7paxuJ3wTco76aQe?=
 =?us-ascii?Q?WAOVDalas6iixDPQn8MSAyhDkvqrgx2QVCj0eoU3BkpUlTDHbKh7uYwXKk5v?=
 =?us-ascii?Q?ejjBAfbAGygV8Ao5Y4eMF3pVNqvUtp7WPq8udnLvZ3UIlBhUCwaXXdprLsV6?=
 =?us-ascii?Q?/oSDOaWFsujbiOlTpFa2lSwLRK6TMSHYFfQjoOEQNB7C2UX5BobssCCpauaK?=
 =?us-ascii?Q?MQuv6JW1u1dfELzY7+bUsf9ENofsqpbi44eHrXJa87r8TervWSlheyHvx0b4?=
 =?us-ascii?Q?yiVOuXnnQRfRxa2IszmUAkYCcQH3qRzW+oXqYm76B8OL7RLs3f/U8XipBZ7b?=
 =?us-ascii?Q?e94M7Dga8EWmPiQ0dU9kk2RSqNCQCBm4cENvo+iz17LfQmEsyeUDeRqtjobt?=
 =?us-ascii?Q?qomyPfGvcvJcz2I1Xe5+1XI2QsuLgAl9Gi+A7jGB6wtzREp/MKSbSdekFsQg?=
 =?us-ascii?Q?T5D2iqOQFzSJbsm/3UDtVguY9Kk8V2m/7EnJ4Fzkr+EyHJPusKngtUdP4MZk?=
 =?us-ascii?Q?/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5B6464E352EEC343A7561209B37A0C7E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d22ae8-23fb-4cfe-aa49-08da64510e7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 21:54:12.3926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MM0MSQPyjuY5nKSThTrhBv8LBulaV32Y4r9DEhtibkNmcBkgtvqzM8uBdr4KPi8zJSIj6EeAMWPq/fw+BSRW/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4017
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_12:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120089
X-Proofpoint-GUID: 2hQzqNcGPVCROZvcVVnTr_k_YNsmZRGc
X-Proofpoint-ORIG-GUID: 2hQzqNcGPVCROZvcVVnTr_k_YNsmZRGc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Dai, lovely to see this!


> On Jul 12, 2022, at 4:11 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently there is no limit on how many v4 clients are supported
> by the system. This can be a problem in systems with small memory
> configuration to function properly when a very large number of
> clients exist that creates memory shortage conditions.
>=20
> This patch enforces a limit of 4096 NFSv4 clients, including courtesy
> clients, per 4GB of system memory.  When the number of the clients
> reaches the limit, requests that create new clients are returned
> with NFS4ERR_DELAY. The laundromat detects this condition and removes
> older courtesy clients. Due to the overhead of the upcall to remove
> the client record, the maximun number of clients the laundromat
> removes on each run is limited to 128. This is done to ensure the
> laundromat can still process other tasks in a timely manner.
>=20
> Since there is now a limit of the number of clients, the 24-hr
> idle time limit of courtesy client is no longer needed and was
> removed.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/netns.h     |  1 +
> fs/nfsd/nfs4state.c | 17 +++++++++++++----
> fs/nfsd/nfsctl.c    |  8 ++++++++
> 3 files changed, 22 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index ce864f001a3e..8d72b302a49c 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -191,6 +191,7 @@ struct nfsd_net {
> 	siphash_key_t		siphash_key;
>=20
> 	atomic_t		nfs4_client_count;
> +	unsigned int		nfs4_max_clients;
> };
>=20
> /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 30e16d9e8657..e54db346dc00 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -126,6 +126,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_recal=
l_ops;
> static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>=20
> static struct workqueue_struct *laundry_wq;
> +#define	NFSD_CLIENT_MAX_TRIM_PER_RUN	128

Let's move these #defines to a header file instead of scattering
them in the source code. How about fs/nfsd/nfsd.h ?


> int nfsd4_create_laundry_wq(void)
> {
> @@ -2059,6 +2060,8 @@ static struct nfs4_client *alloc_client(struct xdr_=
netobj name,
> 	struct nfs4_client *clp;
> 	int i;
>=20
> +	if (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients)
> +		return NULL;

So, NFSD will return NFS4ERR_DELAY if it is asked to establish
a new client and we've hit this limit. The next laundromat run
should knock a few lingering COURTESY clients out of the LRU
to make room for a new client.

Maybe you want to kick the laundromat here to get that process
moving sooner?


> 	clp =3D kmem_cache_zalloc(client_slab, GFP_KERNEL);
> 	if (clp =3D=3D NULL)
> 		return NULL;
> @@ -5796,9 +5799,12 @@ static void
> nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
> 				struct laundry_time *lt)
> {
> +	unsigned int maxreap =3D 0, reapcnt =3D 0;
> 	struct list_head *pos, *next;
> 	struct nfs4_client *clp;
>=20
> +	if (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients)
> +		maxreap =3D NFSD_CLIENT_MAX_TRIM_PER_RUN;

The idea I guess is "don't reap anything until we exceed the
maximum number of clients". It took me a bit to figure that
out.


> 	INIT_LIST_HEAD(reaplist);
> 	spin_lock(&nn->client_lock);
> 	list_for_each_safe(pos, next, &nn->client_lru) {
> @@ -5809,14 +5815,17 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, str=
uct list_head *reaplist,
> 			break;
> 		if (!atomic_read(&clp->cl_rpc_users))
> 			clp->cl_state =3D NFSD4_COURTESY;
> -		if (!client_has_state(clp) ||
> -				ktime_get_boottime_seconds() >=3D
> -				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
> +		if (!client_has_state(clp))
> 			goto exp_client;
> 		if (nfs4_anylock_blockers(clp)) {
> exp_client:
> -			if (!mark_client_expired_locked(clp))
> +			if (!mark_client_expired_locked(clp)) {
> 				list_add(&clp->cl_lru, reaplist);
> +				reapcnt++;
> +			}
> +		} else {
> +			if (reapcnt < maxreap)
> +				goto exp_client;
> 		}
> 	}

Would something like this be more straightforward? I probably
didn't get the logic exactly right.

		if (!nfs4_anylock_blockers(clp))
			if (reapcnt > maxreap)
				continue;
exp_client:
		if (!mark_client_expired_locked(clp)) {
			list_add(&clp->cl_lru, reaplist);
			reapcnt++;
		}
	}

The idea is: once maxreap has been reached, continue walking the
LRU looking for clients to convert from ACTIVE to COURTESY, but
do not reap any more COURTESY clients that might be found.


> 	spin_unlock(&nn->client_lock);
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 547f4c4b9668..223659e15af3 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -96,6 +96,8 @@ static ssize_t (*const write_op[])(struct file *, char =
*, size_t) =3D {
> #endif
> };
>=20
> +#define	NFS4_MAX_CLIENTS_PER_4GB	4096

No need for "MAX" in this name.

And, ditto the above comment: move this to a header file.


> +
> static ssize_t nfsctl_transaction_write(struct file *file, const char __u=
ser *buf, size_t size, loff_t *pos)
> {
> 	ino_t ino =3D  file_inode(file)->i_ino;
> @@ -1462,6 +1464,8 @@ unsigned int nfsd_net_id;
> static __net_init int nfsd_init_net(struct net *net)
> {
> 	int retval;
> +	unsigned long lowmem;
> +	struct sysinfo si;
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);

Nit: I prefer the reverse christmas tree style. Can you add
the new stack variables after "struct nfsd_net *nn ..." ?


>=20
> 	retval =3D nfsd_export_init(net);
> @@ -1488,6 +1492,10 @@ static __net_init int nfsd_init_net(struct net *ne=
t)
> 	seqlock_init(&nn->writeverf_lock);
>=20
> 	atomic_set(&nn->nfs4_client_count, 0);
> +	si_meminfo(&si);
> +	lowmem =3D (si.totalram - si.totalhigh) * si.mem_unit;

There's no reason to restrict this to lowmem, since we're not
using a struct nfs4_client as the target of I/O.


> +	nn->nfs4_max_clients =3D (((lowmem * 100) >> 32) *
> +				NFS4_MAX_CLIENTS_PER_4GB) / 100;

On a platform where "unsigned long" is a 32-bit type, will
the shift-right-by-32 continue to work as you expect?

Let's try to simplify this computation, because it isn't
especially clear what is going on. The math might work a
little better if it were "1024 clients per GB" for example.


> 	return 0;
>=20
> --=20
> 2.9.5
>=20

--
Chuck Lever



