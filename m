Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FC26727DE
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 20:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjARTId (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 14:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjARTIc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 14:08:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2504A5143A
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 11:08:31 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30II3v8p020263;
        Wed, 18 Jan 2023 19:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=cBfDFUIStkA+EEA6AnWpj5hXvbzn7pQBT+SSlDHVWKE=;
 b=eB15o12pSQ25hkzGE2LXGmVGD9aY7iiP90DETDx1N8aqcP8VfCnyxZW3OmpJaMLUCFJi
 zpAhs6kdGvCcaVFLwf/vTdJWmdc8Pz3VIggfx4y3RwdVhg1boau+G7mFzfOetjmr4t+r
 wyxyebemq1pGQ+nguoNU15HZAFIX+qMwvmhFVvMbXLImI76bGeLng/wGFD+QF73d3MMS
 pOLr9EmqQCVyjrQwSmiJpsYkfmkIxDNdEI0yORbVwrjAwyhmAm04h7X6SAxZf/vu1IIz
 iqSVVObbw9jNvbpsTfYOCGTxZ9X4a7fg9pW5Fy0qKEWWuFW6OGKLGsXr+xhKflLSfYOo tA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3m0trbf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 19:08:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IIrxYu037511;
        Wed, 18 Jan 2023 19:08:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6pexgrbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 19:08:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjezsRT06GRQ95BN+HdHqqzG0XvT/4ZQJxR8olhxc1Iz2RJ5Rd3PgG7hSttgoVbUG8b5uR9ivRR9LMZmqkAISKWXKKQoKhIU26QlxNsOVFi7sLF+wJkS2A01zURn2C3Mj2LdUScZkgn3zR5GHO7IFiNF1Fj9yW+VBFt3toQDThZUDJjvlkIFb4TchcU7N7BZChUf0zZPJ7ZyXFFMrK4Mi8/yH/mLUlmp24B6QTZBrp3FLAE5fPZ3vIG25syvdn6PX3g9nfuNCg2JmgyGmJ1tSsi8O66lEImDHtyeRe8xH+IDKHnwwuR2kGHcotjQFNHsKX+wgD/2arRVaxr0HWpVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBfDFUIStkA+EEA6AnWpj5hXvbzn7pQBT+SSlDHVWKE=;
 b=OE3xM65R3UxNPqWi0m7hPta9+YFr1gYq5zKsaVvtPmMxcpI2wpPTjLLI3DS5EwOTUYbrCRs8RDBJE5lGnabzPDs9GZSIGTwk1b/+3iYWy3esmITHfygIsB7VLI+6ipkPd/zEJjoHprXy9WtQENnnIBjNZ5UazPCViqBJz5zRP2O0QFEPbWvBOGoaV3GQ9b9OeVTzQCDUoKUxJK+RGLWBBHR03Pc5FJlNL85Zd6TX/FyIDYWI4SXDNs/Wdzy58fahSyBmdW3is8twMANaxbSsvPi1+VzggsuNvYy2jZtWokzzPe2MVF7/JtUC7hucbByFMewZC9ucSM0+fB08hFU6lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBfDFUIStkA+EEA6AnWpj5hXvbzn7pQBT+SSlDHVWKE=;
 b=AsPlny7XGkifBjyzJ4rC5LwmGbGgRr/DUZk/21xUYc24tvh1fBPLuXn4BuTN7v7KoIjPLpIJ5pHEIRssnkODAbpnYEp0HKiq5huiQUmp7oaLyl++AF+gF4srTgRiXeA+L1CpuC9m3TSSwnk5x1S9bR76BTarwznoquJHDXnz0QU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 18 Jan
 2023 19:08:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 19:08:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/6] nfsd: simplify the delayed disposal list code
Thread-Topic: [PATCH 3/6] nfsd: simplify the delayed disposal list code
Thread-Index: AQHZK2K9iQAA9AGCR0S9mUeEchObFK6kiaSA
Date:   Wed, 18 Jan 2023 19:08:11 +0000
Message-ID: <0BDD4ABB-2470-483A-A2F7-C65B84546FB5@oracle.com>
References: <20230118173139.71846-1-jlayton@kernel.org>
 <20230118173139.71846-4-jlayton@kernel.org>
In-Reply-To: <20230118173139.71846-4-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4306:EE_
x-ms-office365-filtering-correlation-id: 5b610578-cbc0-413d-a0ba-08daf98757e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DOkkBlGQ6Kn0q93eYKPhSMd4tCB8xRFbrqqfGYpojqDT/E6K4ilyZQwOrINAAg4ccj53eiU83ZVqjTyCNEiuvdVDklZ9p9PeqCf7aVEiAN1cAITvLQ52OyCWHLfWJnwaumoDbLABE/DjpTQk8AM6H6j+4aCJxL7jlFMNjKgFbezHT4fFNrLsWJ8fc9X+LGkZ19uhtOUqao9Arz2jh0qqm8J34nx/V2A27tAGiZux69jIRKfl/hU9wiFRBCEbvz6e8M8uaSiHU7RZkkv8O78Avk8Um4C0fjwYVtJX+eImUC0OGSfUvUiyuNsT58+g6u1nNz1rz3whDXhenTgrdLPpbWXXcVMWN9vvXBFJRn1j+XCzBOx8rFKUuip2jp+rPFeQvY5WaAC1KfWJlhKPPV0jSI3nMLiyj6etdxkpJN3xYccKYHHFZsW4l1f7+O+VXdFAALGwC4laTazb2lfsapBdBya6pFkUN66IGHk4NNo9NBnfn1KAnAIS7HbuZOwfVHxvpWMDfwYKiTObp+JE7x+6EaPgAUYv8jfQmupmDqbVEoGxgwbV54AzkyyLHnspPMuawi56lqZDo0Vx6e5VYaTfrpjd+J6rBJVLGpdbKVHHnVW1EM2qs9BJ4zstWeZ9EFiEpgCGHblNPDTs8DMRurq8QQI1dZDBHBVCiXITZ+8ijJmclhzP9JDrlimmKal/ukNoyNxpIEHbnKY2laQS3ErsSk0ZRGEnVirNrCPchnd5x1c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199015)(36756003)(478600001)(33656002)(71200400001)(6512007)(6486002)(6506007)(122000001)(2906002)(26005)(66946007)(8936002)(316002)(41300700001)(5660300002)(66446008)(76116006)(66476007)(6916009)(64756008)(53546011)(91956017)(66556008)(8676002)(4326008)(2616005)(38100700002)(186003)(38070700005)(86362001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jfH0V/n3cPq6JmI+27bERx64duPZyunTJDcN+Vacl8IqqO5I8xHLKcdOO6Xf?=
 =?us-ascii?Q?xYQ1UGK5p4WUJb8ux+/m61R5PRH8Z2sZGnOoUclEieA8nmBNYwou4lw2QExT?=
 =?us-ascii?Q?eOoa1fRr1ffjBgvVS/FTWLSVdhanfQZQXq/C3mbWcg1C+8UKDEp9fHl1lAWe?=
 =?us-ascii?Q?GAHHqnoapyPIY6UMbCDO3DQfSAaPNT8ChGFH+cOCahFWQVOWFuMrsJiCjxTf?=
 =?us-ascii?Q?AufgOFDEsbcBddefXfgn4Y9gylJyGhCAzOeUa7v57a4tDZj1PrRiwkwKd/hy?=
 =?us-ascii?Q?6uRLpWPhe9g3t+C3cdWUQyaQe3LComxwvCePYihEjEbhmXt1j9Jr1lAzgYU1?=
 =?us-ascii?Q?jPDioyBMPYGcWfjPLtG733zLjIhunyDp+Igoa4xpmsvkGCtEqU1CEeElO+YT?=
 =?us-ascii?Q?HSlH7mGsC44T6hRplg/zXG5BIZ5Kiw0MAm3tF2I1mN+7kj3Y4z9nArHsid9e?=
 =?us-ascii?Q?0YxlWo21SEsBz/XbEMw7tBr6rKyWfShScRzcVZlyZHJToTF1QdVxsz0zzd9U?=
 =?us-ascii?Q?vRi5ih/BkaRXsNW9iaknhyHMa138Zyvbwz4iikd2QOH6ie32w1qLb7I8T8fb?=
 =?us-ascii?Q?rg8goH+lOSY+9q1N4Cgo7ledTUmxsBIO7PrIzd3pWrNW4iAKwfoscR+cwVxM?=
 =?us-ascii?Q?9AT51+w+6UoXssyhWiQfsOkBoJE9VS4iw+migP0zjZph9nEpviqb5WNtQbkp?=
 =?us-ascii?Q?sTuhvG0TpSpYR8S+oqW9/icT9dOS7JxVf2HO001WYpVn7TB+tfwnhgrvGeL+?=
 =?us-ascii?Q?KHfC7a5i7z3CsiI3pBN01JCxNyGnYmMnKqhh7Ef7PnpE/v2nKnCFSL/oLRxl?=
 =?us-ascii?Q?+gOcz4MB9Jj8QRlKQ+5ztSCfWt6clQyMw5QlU5PL3XgcYO/EZ44DoL6fBomI?=
 =?us-ascii?Q?fOh5OinzL5+QdExpxoNU9WE6jV1Evorv/oCgA9ytPxDuoCjNtI1RAOg5jvI2?=
 =?us-ascii?Q?SxC5+l8Df1ukW3b1fu9n3CcFB/XsJvMthHXBhJAWFr+yqlRX44M7PPRoDIpa?=
 =?us-ascii?Q?ki0YxpfIARkZUBa6JIkVhXltrp+xbc5aBuacS92wQoD3RSoCbmL7EPSIfrPf?=
 =?us-ascii?Q?9tM0FTjD6i+KmWHOqYXPA77mKhE1ViL1JG0T5CjfdNTJoW+ufbFbZaXps/6B?=
 =?us-ascii?Q?IbhahUaQySRA2JpUFyTOMYp+yF4m4mDaarB80Yb3MvIxs6aSYnV45puyUR7V?=
 =?us-ascii?Q?yIAaITIOJxiTeVRpQv+QPumzNwK9WeJwYJcLl2W6q4KURTFK8vGQF6O+GaHr?=
 =?us-ascii?Q?M2vMr3YoBeb3oXfOlWtAFlaEyRoaSQJJrIqCJvFQaJg8Mtnr3GDbOyRIC2/Z?=
 =?us-ascii?Q?zF9+j1S9jilDPmQTjZvjJPiMe7948Bdmu7OP5BZXNAsf3s8blbjqecURczJm?=
 =?us-ascii?Q?4PwIfTzB1zceaVUYIullwKiKeULwTrdiUFJSb247jY0UAckb/6+dqRJQ2oS7?=
 =?us-ascii?Q?AVzJzJk2J+E7ky68Ry5DRtqGSCKBP0pt5mhS+GtHn7l0lFgxBYVI3XWCAPif?=
 =?us-ascii?Q?Xz1lo3ABseAaJ/8oTOfd6zTGZRGCLIqaR6ztqJMZcD+MFzJ2iWZ+mKIM3FN7?=
 =?us-ascii?Q?mEjDsiIpQPcwEFWVdocx6zDh1p2fZEvzZx1f7OA7RlMg2Tyek567DWebMMom?=
 =?us-ascii?Q?Qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <119FD2E5116AA945A8A31CC0289BD500@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qudKi6ZwTumI9T8I74KSdCSAgicNE46hGL/dBfe3sjtthi11s8/KZ+7/fvOaOFh3QiZYbYK+6lxyYmaZyLiPILgzDLAacHGMCghNa0+DCaSWOGHDE9SM1V5VeliwqWBhrhky6oKQHz9tNsM+CDHpp4ZtPNEM4Hfafi8Ey+UAoevvVV36dFMdXnH35QBV6zHl8k8u5Z7CWDivvvxwTi3KO32fyRFADRhfIT618A4GCh3t7rPfjdXNgtQIOGagRof7VilBF9kkdxzTFgoSRh7JeS1hofc4rOX4O9RjcYI6EB7dzdHQC7qqRmf5mYTER0xr1UcgrpxjBW6rWpjbpm2F+ucMupOFPpENjHEUKuQpjElCpI4sEuoeQoRaPhwVmwr2wNG66TP1D1+KH+DLjm+Q1nY/+NPTRx7BiGInZAbsS7SREnM5FTZ/mAjUlUctkBguLLHP2cYr/rU/YxapU4bz7WTktxOh5mMaqTcGd+C6ZvXa4c6UvxjOI0BM3tlzpu+kDYgGdO8WTCgp0hsGatfC6jqoiKbsvXinRlMhPFg70S3tL7JM+IFnrzii5UvZbrphidTlYPFZsr1toeWJt9KFYMjxxLKac5ap1KiS1h8yN5QjYLTJdt7DAa8cyxYv54VmcrdvYa1v6Y29b22HJYob67BRLh+8MB9mRIveHpT+ddk5+7KRZNBVZX37fpD/Kr8NUui44lFovZVuZ9nvnoYjVMCz1TTYWNMlbfFbZE6qOfgipB0whRaR3hT5ZMyDrFn3GxY9Jombfi9JapDn0qjAZiAhSLrRvfOYL3G+uzwlhz0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b610578-cbc0-413d-a0ba-08daf98757e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 19:08:11.6380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: znlfog71rphRwug5AWV25+ji0LoZeQ0CRcZYjt6bemNwTKygXsDYt+7n6X/mhu6kkpT8eR0bRZt0Mzj2DIZwbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180162
X-Proofpoint-GUID: ihSjG0uV0ywDVIb7kmU8_4AFhQ_AzTzk
X-Proofpoint-ORIG-GUID: ihSjG0uV0ywDVIb7kmU8_4AFhQ_AzTzk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 18, 2023, at 12:31 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> When queueing a dispose list to the appropriate "freeme" lists, it
> pointlessly queues the objects one at a time to an intermediate list.
>=20
> Remove a few helpers and just open code a list_move to make it more
> clear and efficient. Better document the resulting functions with
> kerneldoc comments.

I'd like to freeze the filecache code until we've sorted out the
destroy_deleg_unhashed crashes. Shall I simply maintain 3/6 and
4/6 and any subsequent filecache changes (like my rhltable
rewrite) on a topic branch?

One good reason to do that is to enable an eventual fix to be
backported to stable kernels without also needing to pull in
intervening clean-up patches.

I've already applied a couple small changes that I would rather
wait on for this reason. I might move those over to the topic
branch as well... I promise to keep it based on nfsd-next so it
makes sense to continue developing filecache work on top of the
topic branch.

The other patches in this series are sensible clean-ups that I
plan to apply for v6.3 if there are no other objections.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 63 +++++++++++++++------------------------------
> 1 file changed, 21 insertions(+), 42 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 58ac93e7e680..a2bc4bd90b9a 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -513,49 +513,25 @@ nfsd_file_dispose_list(struct list_head *dispose)
> 	}
> }
>=20
> -static void
> -nfsd_file_list_remove_disposal(struct list_head *dst,
> -		struct nfsd_fcache_disposal *l)
> -{
> -	spin_lock(&l->lock);
> -	list_splice_init(&l->freeme, dst);
> -	spin_unlock(&l->lock);
> -}
> -
> -static void
> -nfsd_file_list_add_disposal(struct list_head *files, struct net *net)
> -{
> -	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> -	struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> -
> -	spin_lock(&l->lock);
> -	list_splice_tail_init(files, &l->freeme);
> -	spin_unlock(&l->lock);
> -	queue_work(nfsd_filecache_wq, &l->work);
> -}
> -
> -static void
> -nfsd_file_list_add_pernet(struct list_head *dst, struct list_head *src,
> -		struct net *net)
> -{
> -	struct nfsd_file *nf, *tmp;
> -
> -	list_for_each_entry_safe(nf, tmp, src, nf_lru) {
> -		if (nf->nf_net =3D=3D net)
> -			list_move_tail(&nf->nf_lru, dst);
> -	}
> -}
> -
> +/**
> + * nfsd_file_dispose_list_delayed - move list of dead files to net's fre=
eme list
> + * @dispose: list of nfsd_files to be disposed
> + *
> + * Transfers each file to the "freeme" list for its nfsd_net, to eventua=
lly
> + * be disposed of by the per-net garbage collector.
> + */
> static void
> nfsd_file_dispose_list_delayed(struct list_head *dispose)
> {
> -	LIST_HEAD(list);
> -	struct nfsd_file *nf;
> -
> 	while(!list_empty(dispose)) {
> -		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> -		nfsd_file_list_add_pernet(&list, dispose, nf->nf_net);
> -		nfsd_file_list_add_disposal(&list, nf->nf_net);
> +		struct nfsd_file *nf =3D list_first_entry(dispose,
> +						struct nfsd_file, nf_lru);
> +		struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
> +		struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> +
> +		spin_lock(&l->lock);
> +		list_move_tail(&nf->nf_lru, &l->freeme);
> +		spin_unlock(&l->lock);
> 	}
> }
>=20
> @@ -765,8 +741,8 @@ nfsd_file_close_inode_sync(struct inode *inode)
>  * nfsd_file_delayed_close - close unused nfsd_files
>  * @work: dummy
>  *
> - * Walk the LRU list and destroy any entries that have not been used sin=
ce
> - * the last scan.
> + * Scrape the freeme list for this nfsd_net, and then dispose of them
> + * all.
>  */
> static void
> nfsd_file_delayed_close(struct work_struct *work)
> @@ -775,7 +751,10 @@ nfsd_file_delayed_close(struct work_struct *work)
> 	struct nfsd_fcache_disposal *l =3D container_of(work,
> 			struct nfsd_fcache_disposal, work);
>=20
> -	nfsd_file_list_remove_disposal(&head, l);
> +	spin_lock(&l->lock);
> +	list_splice_init(&l->freeme, &head);
> +	spin_unlock(&l->lock);
> +
> 	nfsd_file_dispose_list(&head);
> }
>=20
> --=20
> 2.39.0
>=20

--
Chuck Lever



