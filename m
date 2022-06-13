Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A21549E41
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jun 2022 22:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243158AbiFMUA4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Jun 2022 16:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243364AbiFMUAe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Jun 2022 16:00:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9927E0CD
        for <linux-nfs@vger.kernel.org>; Mon, 13 Jun 2022 11:31:45 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DHn9Gq017867;
        Mon, 13 Jun 2022 18:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oXGdDI5porBerE2C8K24aqEEBx0rSxa/p8uexFba17Y=;
 b=zwEPYXy9lnpUZCTFLS5ApndjZlu5Lg5Nxy8CIEzrfVj6JrfyLk7QWtNLLquUhkFAdBHf
 tI/WyccA9iuebRBAwcfRUIcA19QCoTv4Fh/uQ9UbL4ijArDc6L1JLqOoforJm6zv3bTx
 6ivHAC9VT4DBzKBr2XK8stfPgPP9ZlQ+ZkVXV6m1HCmBS15GcquIXnNtRln4stHAFlQB
 +cLidRnwVnsD1g5BHGqfJ0kVncOJZ8xQPKBNd7KdF2HFOvgvVLad+qrJaz2AMUO3e2wr
 d+dHzYxGu1pD4npP38cdL82TT9HZ4GDsprTCABJVcaK7Xvb8dDwKULu2VtgXqUWC1ulu /g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhfckuut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 18:31:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DIQes8040340;
        Mon, 13 Jun 2022 18:31:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpah606ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 18:31:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzuyyisZt208Tt3kQ8osj7i4cCWIw7N5MzqCR7lnjNqoTp5RJaX+dpgirXng7rYTgQuRln0IuHg9/Js3kcuP28yaGxHMXri77i0+qgByIHIN+PBf0saM7YIvvF9s0yUyTlXNLsIhvMtvMV0vALSN0OiBBKwZhyGdCsAle4PUCdJJyVOyuQNZk+ssRVwdBZx8BUYx0I2nSk40jrGcQWxEpFgwEvNmsxYR6p2T7te2+bBltsqC68EnYJbIg+I7KRBsoYC9+8X24mKuHZopXXmJlAwVJ9+Dx5i8jbpYTmb+YBFsW+wE/3CxwJnmU0mmzHeGGLdnwBfw2rxzB0ovjSOa/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXGdDI5porBerE2C8K24aqEEBx0rSxa/p8uexFba17Y=;
 b=N9LUovc+ipQhXvK1jd6yfToiFsg110nx4WM85JbTd8NzVzuqqA4/tCtwmSbj66yMxx/kZv5YuijEKuKgBMmX4WJDibyot+D52FWKm4Au6fmpLZAXQYiemC2buNJA6CjadxN+TuLs7X+0ICZQWe98qdUkAt6XNUvtXcyhduWUeYsxmZe3QMPdfELVWtt4HOTHnWV+DteqK6we7LxTEO3zuuAe9PMy01anQmbT+wJzhy35JzVG15Er5xLuEOJqatnHwdHwNieUdH4w5oXXson6v+FbCoq95T84nC2mkB10TcHC0c/kvNJZXx29YlXPHsexSYN4nODyO7BR5JJcMH+dNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXGdDI5porBerE2C8K24aqEEBx0rSxa/p8uexFba17Y=;
 b=uKglh31a7ngw28M5fX0yxuIh6leOu0mHBAD9k3nmgJxrHgpV5rggAx+9QE6y3nZi1gQOh8skil2sXWXVMNrfTWRVVmvWgEivjd8eYVIOMnTyBlVWraz91pvy8h4bTQq27YX3BcZxvJUnWj4SWymLPyAMOWATb0tPIjx6KsN/gpo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4619.namprd10.prod.outlook.com (2603:10b6:806:11e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Mon, 13 Jun
 2022 18:31:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0%4]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 18:31:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NLM: Defend against file_lock changes after
 vfs_test_lock()
Thread-Topic: [PATCH] NLM: Defend against file_lock changes after
 vfs_test_lock()
Thread-Index: AQHYfysdIoOx/JiCV0ytFXEmbRLY1a1NqUmA
Date:   Mon, 13 Jun 2022 18:31:36 +0000
Message-ID: <53767203-004C-4538-8E29-1241CFB19F43@oracle.com>
References: <9688295e35c07d3b3d6c71970b6996348c2d8f1e.1654798464.git.bcodding@redhat.com>
In-Reply-To: <9688295e35c07d3b3d6c71970b6996348c2d8f1e.1654798464.git.bcodding@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56cd47de-b011-48e4-ab61-08da4d6af2ec
x-ms-traffictypediagnostic: SA2PR10MB4619:EE_
x-microsoft-antispam-prvs: <SA2PR10MB4619077D7DE5B5F0D664C84693AB9@SA2PR10MB4619.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6RmQvrVi6DGoC1KHOQe2v6AIXx5eAvOH3qzmdUiKkDb1KnS3+SExredlNxloXrUT34Bk0J50vHWFRdy2R53IkrKYnNMIDhXqsMbkmkfI076d79kybg6NPnZwodeswy+yGONIQ384AjdVeTIPm6JFDlddJ/DuO9fltRBoVhQJz10kIJQfJuO/PKWgYiKiRB4rKYjBMyKMQ8tyzLt0E9vHlStt4lX/uyiKWPPOfVhz3p/6cWXv5dVH9mPDZz4rPtySM8gV1YdYLB26ev+5pI6TKSBe/7/Q69h+Kc6r9UKeWqCzB6HNsOO3JmzSJA46K3D1HpgENKNBlDpgPDcffFFOUe2KL/wdoxmULjmOj944zmuQvxV6epQmC11uo8Ip67M/spb1ZW+InRwzUo3wkOExWZxAvuWYyJc1IYjJCgYON5ZzzFM7svhClnP83Q8UEgLnmvLWM/2TMpSy7Zjf4j2QoF+j0VJsPMd6Kqh2jrfAGRX6R+jul6Jgpabf/8ZqPtnUrVF9cxcXydLNoi+VL9XqBbTnAUH7m/J7btRDI55671y1hoqv9kh+/gfEOKfWVtsf2nhqzIms24KhKoS4eFbs5nnp0M52FFz3MXhRUgybZ2ejHw9GKJJlLAbaBKuFbCEoZH1gfcbPvDDpN2NY4VGgqQ7mRHb4YecXr2PEZU6BdEiGUr4JJIdatnihiILv0zH+2r0IM9+6mKX1IWDI3oAt1tPxz1V3msBOGmfBnu0WGaU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(53546011)(6506007)(8676002)(83380400001)(64756008)(33656002)(2906002)(71200400001)(5660300002)(8936002)(6486002)(508600001)(38100700002)(86362001)(38070700005)(6916009)(2616005)(54906003)(36756003)(122000001)(316002)(186003)(91956017)(6512007)(26005)(76116006)(66476007)(66446008)(66556008)(66946007)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6poy3de8ToH/yv26FXkiudqqGuSWMy3lbKQh8Tg5ip3VlcXeF3Y2p+3KOhTE?=
 =?us-ascii?Q?8Hyj0CuueWa+bYe49BYNYmZvrcg+M6PGmWhL6a5nW4xpkXEiIgxZgvlEkMC+?=
 =?us-ascii?Q?/XK8U7i0gqXjZOWa/gCw0FH8OlhdlvFskwz3x6bgwRvTsMbDIfe+gGT9oXEX?=
 =?us-ascii?Q?CMxEduMd/oUGZUPDoBwsyEmeD6AqzeNKSxLFNHe+KMG3CAOz1KfOBfMKIvR4?=
 =?us-ascii?Q?KQYL84O70Bpa7CUwECQbNhTd4j9CMJ7nrF+gv6DXwCx9Ohv6GuGggt5xwVAA?=
 =?us-ascii?Q?o/XdnKMhdfcaGLmy7o5vq2zvzKrxtKc0z4vlSkcvXuXNGbAKS4S6mPED0kkC?=
 =?us-ascii?Q?bDzqrEfPkdQOeY82DwmAcSCU5yPf9orcKy1+k4hvZ6u96NAMA27oWXSo2dJG?=
 =?us-ascii?Q?HRyXEi5BCDn1GhzMKQ9lVUvBJuKsvcgIHa8uiL/cdVgOMa5+SuNiAdN+u4oS?=
 =?us-ascii?Q?Wuh5sQYxzqL3b/VTWATEG3S8HwldQtYU5Bs61OQNLTCDuKBtVSufim7mOhDN?=
 =?us-ascii?Q?VAnyZnXGAPqB4EXMch0raRIwPf7N3A0f1kQ7+X42roq45ItqNHLKU9pf3ln1?=
 =?us-ascii?Q?+rxNpG6zwF+2DTzFw1x8iGjM6iFsO5wrFmvTDiQBJg2wgErIPrZKR2rqnJhi?=
 =?us-ascii?Q?KCxulUPd42KVkoBz+d3A66Y+kqQu7GMIUcxHkRFvG7nieEFBRdXbz9kKCsdx?=
 =?us-ascii?Q?oOURXNvOmA/rJQR3Iz0QowLLr09LePYPBixhH5xRrOurVZtQEB03YnIEi0xy?=
 =?us-ascii?Q?joX+R3V+ZX+pSydlLubFNnilxhKmCfLKD3eeZ/1H836gwCmAx5xBlx9qTijk?=
 =?us-ascii?Q?itgyFitccNQqhWdCprEYRGjn5gILWkaS9t7F764E1EMvBbeG6dolhpszRUHz?=
 =?us-ascii?Q?rbtLM09FWp/Y98+13mQH2sAfXUYd0HIYEjJCnxc/2De9p7OcxgnrBEhA5N02?=
 =?us-ascii?Q?l9BjhAMbivBKxrtDW/N07MffoIaOsvYhnyIRlRzt84vDqhYsaiGqTzC+424A?=
 =?us-ascii?Q?CjqUwXhhsFRoenJTaEIlR87/yPP/UEf6VBzY4RAnhQJtd0UJZXrFYDclbYel?=
 =?us-ascii?Q?Kd+fg0ozNJlxjsw0ONB9v8f/9DSaidP9xC99D1Lb3+jIxcmMl7mJMbDlnygS?=
 =?us-ascii?Q?8MxLgqFdAflMYrafZUY/SNRy8/jXG/orhmObjHlHwfDTMnLfjR2nf8Ptax7b?=
 =?us-ascii?Q?Qxvu9I1I6SYVmGVBqWdyJR1wrjLMCJQUU6M6hH6QQgtwGvE/4p5ei8q87VPY?=
 =?us-ascii?Q?uzjZt+KqBcVFx5hArN4nfDDAHxQ6zzrtA1Q/jZRO7p8nJ+nI5l6l1ZmHyNEc?=
 =?us-ascii?Q?9qEk+wV9x6vZlovTWWoQAnpdTb/IN4yMmBzA2UwXtuJnM/NcW+e5ZDRPKSUF?=
 =?us-ascii?Q?XkNIora2Fw8Qua0jU+d+WhYUKE5BMXvQmwa3SHrFbiXv6hVRBiBuPxr4fvcu?=
 =?us-ascii?Q?13208lyP4dLhif4SjyE9IOzLsd3crTrOHY6REeVVch2gs+Pap4s5jeoQliFa?=
 =?us-ascii?Q?oqXC6aLqOq1iygpXlMfF3fABHYGncRoy4cBLu8qmHkWE477AKIOCuZhftM/o?=
 =?us-ascii?Q?802TEQ5Ub9YLw903FQ8oooTkVZne+5XpmCvnjYkXRHTbdkj4St2Dm3mYUy0o?=
 =?us-ascii?Q?RlV6G7Ejg2Dmc6qoJxFwK+BhM+NRzeJ0uPF1ZYWqwHsIQG84abh2ZeNCQ59v?=
 =?us-ascii?Q?huZAhS7/5CS3fyDx+YlcNi9MrmDhIT2pr7GSvuim3cBT8/Zmo2WXr+nJZvk1?=
 =?us-ascii?Q?9XfTABzezitJOXcUx79nq+XMEtTz2EM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <86F760062C4E4646A8CE9A6BBEF0ECDE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cd47de-b011-48e4-ab61-08da4d6af2ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 18:31:36.3346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hb+yK9PouZTEwBj8Iq0IyHqmGr2vpbtWIOYzxjMhVFuUgBc4E0GIfv+vJYYwvBSx87Eaan3t8TqbJFocrJoc2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4619
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_08:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130078
X-Proofpoint-ORIG-GUID: yjZ64fC6hRmLcb_Le2z0An6RHna3RoYg
X-Proofpoint-GUID: yjZ64fC6hRmLcb_Le2z0An6RHna3RoYg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 13, 2022, at 9:40 AM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> Instead of trusting that struct file_lock returns completely unchanged
> after vfs_test_lock() when there's no conflicting lock, stash away our
> nlm_lockowner reference so we can properly release it for all cases.
>=20
> This defends against another file_lock implementation overwriting fl_owne=
r
> when the return type is F_UNLCK.
>=20
> Reported-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
> Tested-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>

LGTM. Applied internally for more testing. Comment period
still open.


> ---
> fs/lockd/svc4proc.c         |  4 +++-
> fs/lockd/svclock.c          | 10 +---------
> fs/lockd/svcproc.c          |  5 ++++-
> include/linux/lockd/lockd.h |  1 +
> 4 files changed, 9 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index 176b468a61c7..4f247ab8be61 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -87,6 +87,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_=
res *resp)
> 	struct nlm_args *argp =3D rqstp->rq_argp;
> 	struct nlm_host	*host;
> 	struct nlm_file	*file;
> +	struct nlm_lockowner *test_owner;
> 	__be32 rc =3D rpc_success;
>=20
> 	dprintk("lockd: TEST4        called\n");
> @@ -96,6 +97,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_=
res *resp)
> 	if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
> 		return resp->status =3D=3D nlm_drop_reply ? rpc_drop_reply :rpc_success=
;
>=20
> +	test_owner =3D argp->lock.fl.fl_owner;
> 	/* Now check for conflicting locks */
> 	resp->status =3D nlmsvc_testlock(rqstp, file, host, &argp->lock, &resp->=
lock, &resp->cookie);
> 	if (resp->status =3D=3D nlm_drop_reply)
> @@ -103,7 +105,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nl=
m_res *resp)
> 	else
> 		dprintk("lockd: TEST4        status %d\n", ntohl(resp->status));
>=20
> -	nlmsvc_release_lockowner(&argp->lock);
> +	nlmsvc_put_lockowner(test_owner);
> 	nlmsvc_release_host(host);
> 	nlm_release_file(file);
> 	return rc;
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index cb3658ab9b7a..9c1aa75441e1 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -340,7 +340,7 @@ nlmsvc_get_lockowner(struct nlm_lockowner *lockowner)
> 	return lockowner;
> }
>=20
> -static void nlmsvc_put_lockowner(struct nlm_lockowner *lockowner)
> +void nlmsvc_put_lockowner(struct nlm_lockowner *lockowner)
> {
> 	if (!refcount_dec_and_lock(&lockowner->count, &lockowner->host->h_lock))
> 		return;
> @@ -590,7 +590,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> 	int			error;
> 	int			mode;
> 	__be32			ret;
> -	struct nlm_lockowner	*test_owner;
>=20
> 	dprintk("lockd: nlmsvc_testlock(%s/%ld, ty=3D%d, %Ld-%Ld)\n",
> 				nlmsvc_file_inode(file)->i_sb->s_id,
> @@ -604,9 +603,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> 		goto out;
> 	}
>=20
> -	/* If there's a conflicting lock, remember to clean up the test lock */
> -	test_owner =3D (struct nlm_lockowner *)lock->fl.fl_owner;
> -
> 	mode =3D lock_to_openmode(&lock->fl);
> 	error =3D vfs_test_lock(file->f_file[mode], &lock->fl);
> 	if (error) {
> @@ -635,10 +631,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_f=
ile *file,
> 	conflock->fl.fl_end =3D lock->fl.fl_end;
> 	locks_release_private(&lock->fl);
>=20
> -	/* Clean up the test lock */
> -	lock->fl.fl_owner =3D NULL;
> -	nlmsvc_put_lockowner(test_owner);
> -
> 	ret =3D nlm_lck_denied;
> out:
> 	return ret;
> diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> index 4dc1b40a489a..b09ca35b527c 100644
> --- a/fs/lockd/svcproc.c
> +++ b/fs/lockd/svcproc.c
> @@ -116,6 +116,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm=
_res *resp)
> 	struct nlm_args *argp =3D rqstp->rq_argp;
> 	struct nlm_host	*host;
> 	struct nlm_file	*file;
> +	struct nlm_lockowner *test_owner;
> 	__be32 rc =3D rpc_success;
>=20
> 	dprintk("lockd: TEST          called\n");
> @@ -125,6 +126,8 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm=
_res *resp)
> 	if ((resp->status =3D nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
> 		return resp->status =3D=3D nlm_drop_reply ? rpc_drop_reply :rpc_success=
;
>=20
> +	test_owner =3D argp->lock.fl.fl_owner;
> +
> 	/* Now check for conflicting locks */
> 	resp->status =3D cast_status(nlmsvc_testlock(rqstp, file, host, &argp->l=
ock, &resp->lock, &resp->cookie));
> 	if (resp->status =3D=3D nlm_drop_reply)
> @@ -133,7 +136,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm=
_res *resp)
> 		dprintk("lockd: TEST          status %d vers %d\n",
> 			ntohl(resp->status), rqstp->rq_vers);
>=20
> -	nlmsvc_release_lockowner(&argp->lock);
> +	nlmsvc_put_lockowner(test_owner);
> 	nlmsvc_release_host(host);
> 	nlm_release_file(file);
> 	return rc;
> diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
> index fcef192e5e45..70ce419e2709 100644
> --- a/include/linux/lockd/lockd.h
> +++ b/include/linux/lockd/lockd.h
> @@ -292,6 +292,7 @@ void		  nlmsvc_locks_init_private(struct file_lock *,=
 struct nlm_host *, pid_t);
> __be32		  nlm_lookup_file(struct svc_rqst *, struct nlm_file **,
> 					struct nlm_lock *);
> void		  nlm_release_file(struct nlm_file *);
> +void		  nlmsvc_put_lockowner(struct nlm_lockowner *);
> void		  nlmsvc_release_lockowner(struct nlm_lock *);
> void		  nlmsvc_mark_resources(struct net *);
> void		  nlmsvc_free_host_resources(struct nlm_host *);
> --=20
> 2.31.1
>=20

--
Chuck Lever



