Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861D361DBB6
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Nov 2022 16:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiKEPly (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Nov 2022 11:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiKEPlu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Nov 2022 11:41:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E49DD116
        for <linux-nfs@vger.kernel.org>; Sat,  5 Nov 2022 08:41:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A5DfnLP018865;
        Sat, 5 Nov 2022 15:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/hcgoiF5Oecw5L8jYYKrBo0HwZLx0eptm+2/Ju7jpiE=;
 b=OjbGsSsJqxcGh1FnFZwH2/gPEhqlL51+lUW7k0JfxJvMP1XJMrdPsjuA/B8AOm+HdPv/
 lDzjaZG4Li6HMyr5EkcAo7eqfO8+SqXulo2cTA+pFIrOj6c9e1EREm9n67HTnRP/jdAO
 9Avgyigvid/+bs7OfE7a4EfPISwvR0Akhy31HVUb2k4dK7pKRw1liRn91DSBThZOK6bv
 l2cUDhta8PLi0HjaCGjTu/6sgIBtXsPF5Y/3Y1RrX9UOnCamg7VJ6FZCxu08Kg+Tfjfz
 +7XcR9DrCuOk6IiRxWFwXBTpWYr8cbOMjgiN/O+UOp1OS6H+LpUjXCwq0TzL5aGDyYQQ PA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngkfrkm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Nov 2022 15:41:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A5Bb6ex035701;
        Sat, 5 Nov 2022 15:41:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kne923c04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Nov 2022 15:41:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3oaU7IWM/5flwauclnQS3EUYh28+6L5nRJTz45nff18UGUCaPQRUbJtd78BjCs/2JDQvvFrMJo5qrFk3IVZuQkCOhfBwzbRfAdZn2oVLx9qjQFwf6TYHO9LMPwquTfc8rTNNAkCmi6cqrr5CU5H1bfeRmeDZ3JmhgW5jabubzH238EIc+UIhfAmibi8EzduPzYYVCKnHG0jH5os5VTxPERxfcjyqxdlUoXEZxHHDhyF1b8gH+xNzOgA/Btd4eWanqcvNUVX9UjwIiuIXE9wSh6KKmWh40QVg2uaFQiXixp5kcz5vgMtjGEsc3P0oHYv4R+S/ovxED7RcCnrIKRH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hcgoiF5Oecw5L8jYYKrBo0HwZLx0eptm+2/Ju7jpiE=;
 b=e013PAJJMr7uJB7mNb3lCQ2c9k0tpXQfJqn4K0yJ3z7N+Vu4z1jPz9OjJKAZ0rqMXq2TMUhH8Izclo7NwlfeXSBWWv0fcXokFYRyD89NRRGB+oY+NulENd6lgEJRbzD13DuifvSQFYo5mM0MjP38+MGtTS48oCwZRvVH9Qc/qokgQ+AljkrdqfxrLmfLFj3KnjRMn85FBomtZoVJ8gj44hi2qly8AsENTGzSxsjx1bSs93oqCqu+A6ynPTYpDu2/4gTamU0bgV9c/ZrcyNqHJxEH0YFFw3crEVvBerG74FJ4GIDvdNJbXmk08qQGznL9tTJqHzg907I+Hrfzo6wPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hcgoiF5Oecw5L8jYYKrBo0HwZLx0eptm+2/Ju7jpiE=;
 b=lbZkhWVKUE2PIWhP45OZnj6rsDlvFWWcIkCQk6BamZQ0Cz2NP4BdLu0CUfeHiWusTXcDubEmbT/qJX0/XdFLsbyMbG6s8N+7HB2HlTYgKiMiqDTwdI3DDvD7uLIcGYHAJY/5uEPXSsVNtO7yXtyqHPsFtvBvPaF+y09nxz/YR4Q=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by DS0PR10MB6247.namprd10.prod.outlook.com (2603:10b6:8:d1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20; Sat, 5 Nov 2022 15:41:09 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::e208:8886:f6f1:ab09]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::e208:8886:f6f1:ab09%7]) with mapi id 15.20.5791.022; Sat, 5 Nov 2022
 15:41:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] nfsd: fix use-after-free in nfsd_file_do_acquire
 tracepoint
Thread-Topic: [PATCH] nfsd: fix use-after-free in nfsd_file_do_acquire
 tracepoint
Thread-Index: AQHY8R1vzMCgpPcPH0iHb0w/pOeG964wd9AA
Date:   Sat, 5 Nov 2022 15:41:09 +0000
Message-ID: <C331D33E-9C80-4B1D-AD1A-9475656FCE5B@oracle.com>
References: <20221105134926.23726-1-jlayton@kernel.org>
In-Reply-To: <20221105134926.23726-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5134:EE_|DS0PR10MB6247:EE_
x-ms-office365-filtering-correlation-id: cbe76f4e-1592-49d1-3ff6-08dabf4428ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fdhO3gw/9TibQ2njFh3gwRWRQRRZP4O+fWBYx3oynUTaaRf628/8t7FZ7MbFGyuH5+RvbQkGrQAQ1KHpyQ6Yay032Bq21aEayaOWaEAuKc8AWU7/Ds6WwQW2MwmmnveqRfZpMIne3pC2/+mxyMk4hBTwPZep1t1y3l2a5g51Ef/MmfybWkkm0dUkSVkR+4MpVfb2zYJpxGUFFWScWyWwLVGbiNVJihG7jgLK8WuC3D8nktLPSxBVoVbpIhk6YVqreOVfXQ9bUGiqrxeHLcnfQy/eJKgSpB83Vpr+BeKaPlVO8zQKvPzODaiEBiSQNBQSDWwcrcO6FDhUuVBYKt5lESL+yWgP9AknYIcbkwjopkM0v5lWVZtsxtFS9A/SueG4b8l9KTIuCdVJkue6dZFsXUt1qykhF3GXfiBcHEnO5vUVl+T839Ym9OV+25+V0VVHSpZ64KnoY/EaSKbwEhavn+qpfl3kT1+G5hfCfBT1YAawJ13HZhs3CDCqH3Ww0vRcHCwacKSJM668nMKHANnmYkJyAa3R5XOxiSoVgU1nJ0mkAiZkVP9gJ9p40LnvSLkWGHCWiI8NOZmLlTxSuxYSwoTwMsxOusMpB3T9TqewVljlOqXp1tULckwIbzZQpkIiwo4g6lZ0LATqfYMVdQ796XsfpmXhM01LurDFhYn1vI8MzCplmn2AvAQk9e4XmtKMzIkaIF7KsEu+0w4qR+0fZPI6LprDPZGrjaw83q34pJwUYo10TJIY1HUUridnLtUlCfVWnSjfyY2jRblMzgWH2QTqZnRO4fJT/L3iFfK4hQg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199015)(5660300002)(36756003)(2906002)(66556008)(8936002)(33656002)(66446008)(66476007)(66946007)(64756008)(54906003)(76116006)(122000001)(91956017)(4326008)(8676002)(316002)(6486002)(71200400001)(41300700001)(6916009)(38070700005)(26005)(86362001)(38100700002)(83380400001)(2616005)(6506007)(186003)(53546011)(6512007)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sbKhYSQ8cLqAXnDc9HW4MEqWWQJhprWJOQIeDMaDPUBhSTL7NNcVxRXDA9kw?=
 =?us-ascii?Q?HXNN1Vf0/+h4Bl1BiC/H8/TDAGrGW0qcPRL/sXxjeOMy7gJDTjh//HLErddr?=
 =?us-ascii?Q?pSFupCOnmj3Ofx7GAOytii4hbENdqlY1fKDjkRDUq4KVE1yIYlYaAo4mxB1Z?=
 =?us-ascii?Q?7sRtGamzpD1jU177w3gwCGmQu2hzwHdUHv6Pz0dkR8QlvZXNKnMV/kE+xsVs?=
 =?us-ascii?Q?pMb4/mivOxcsgBgGkarLAXZvDgfXLaC8C8Xp13JVesXTUVIz0KCfaiMpJGhc?=
 =?us-ascii?Q?jXJkAhI5WAn8LL9R7gvpq5QxYbP+qGmn0yiMYGKekcl3j+OwMXtF4ORu1a3r?=
 =?us-ascii?Q?A2CnamU+Z7BG0uXkTF+3WeaQl5DgQMfrH6BeNUNGFT4jDIKVW+TDfmELPPqt?=
 =?us-ascii?Q?vLrzy9My7JCvboaHXjNHF5erdJ+ibqOtKzDGwA9BlELSZNXfI+D5NwQNE9dl?=
 =?us-ascii?Q?sgOUGK8Ba02TNS1HwNcPwxXBWOG1028xNhs2gsWrThTgZUbrt9ACDWtPLp8p?=
 =?us-ascii?Q?LI5BmgrfpZ4zc/Nl+tamRrrnIv1/YUt0cgoi9zANrRutZOAikAeWvGph9hNh?=
 =?us-ascii?Q?jGn9G7C5Emxhc9+aYE/BhmjAOYqA13h1nXHK0RIj0HzruJNgyKIPmBxz5l7l?=
 =?us-ascii?Q?+XOVRo5qnS75tyhkxZbu05hI/G/V3R2J90S4AXCX11cSstK4ZeEEiibIsA5o?=
 =?us-ascii?Q?7OlYTNymvDQNb8BQLp2M1f5PShb2FbhlbAdjLjrdUPN5t1b9W2LKmricYy5c?=
 =?us-ascii?Q?fI3BUntzsDPpyGwDLceIZ14T8omGk9mEvoKDbfWlSIM6kGERAyw6kE7Cb4dA?=
 =?us-ascii?Q?tDvfBlGeYpkyU2js8/I/zHfpDEUEW4kfW3HtTb0AO9OVaBNJ4022nt64A9TX?=
 =?us-ascii?Q?WC+KwPMNuqZjWVkdha3kbUyjaSyJfh9s9EfPyqXDx3H24wPt0OMDMqxBrOgI?=
 =?us-ascii?Q?Sny2X4NvMjQO6YsED8CR9txtON2Eh9HEjydkFxKpp6RlU23YUG/NDxKGHHqd?=
 =?us-ascii?Q?jmkURx7rFCTlnXahO50f5ZbRIZRskEFd3q1G7tKC9kwSZmgfGCFuJdGsmRwM?=
 =?us-ascii?Q?8lDncvpasXNJciPchknEHD4s1YBmGvVF12+rGcF9PVS6S4q6kZXJ6UxXY9yw?=
 =?us-ascii?Q?RKUDbx76x7b6FNBeAoWkLpMhSBr6UKmbALNyIVKH1aynzITk8bAyA2Lv5zJo?=
 =?us-ascii?Q?HlwBId5wFS55+KhfeqydmvU45UT9sac/h0uRX0of0sBfH2B7WpRLqEvxZwri?=
 =?us-ascii?Q?B5gBLR+7rJFu6ObdSlLF5qo8VbZ6CP5u7NoqOLXs+XsJo96ofFo8ihfcaJEx?=
 =?us-ascii?Q?BdPwt2ijXVKVKwNRCouum4ARsbBDSb6IYzy6uH4X0zJ/M9tRYFC0SGcuJ+oN?=
 =?us-ascii?Q?NuzSlr21tks1TIduG2As/nqx3fGR8upbK6iDN76+Xf8v0geDgJ0QG9nSa+Hy?=
 =?us-ascii?Q?9peLNmahaEr5eQTsbpY7nrQLXCQRxcVOvb5M1Zck+L/4pj9E9P730az3i2tS?=
 =?us-ascii?Q?3ICXzDKZnzF03sg6koe2gkrhaOWaXwv5+L4B24k/03kZlfgU9bytTJdj/zPC?=
 =?us-ascii?Q?Vjwl1neUaeado8u/uoDz7ZK+sadmbNllHIG4pE4yeNpFYy2whDsCWtSbFzYK?=
 =?us-ascii?Q?UA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC823C381EB3D54985048E86F3460448@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe76f4e-1592-49d1-3ff6-08dabf4428ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2022 15:41:09.1352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWIAqoxyKmwb3z+HScgvk/quEY+5TM+a6jMxycrEFaBmOrN197ZfweOVVYF+KUMcTPdulkGUeRlhAXJZYhq5ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-05_09,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211050118
X-Proofpoint-ORIG-GUID: KJy-apSMC76I7SH5LDW3BKwRo3ij4c7D
X-Proofpoint-GUID: KJy-apSMC76I7SH5LDW3BKwRo3ij4c7D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 5, 2022, at 9:49 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> When we fail to insert into the hashtable with a non-retryable error,
> we'll free the object and then goto out_status. If the tracepoint is
> enabled, it'll end up accessing the freed object when it tries to
> grab the fields out of it.
>=20
> Set nf to NULL after freeing it to avoid the issue.
>=20
> Fixes: 243a5263014a ("nfsd: rework hashtable handling in nfsd_do_file_acq=
uire")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 1 +
> 1 file changed, 1 insertion(+)

I've applied this to nfsd's for-rc. Thank you!


> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 687ab814b678..02c1454dfe50 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1124,6 +1124,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> 		goto open_file;
>=20
> 	nfsd_file_slab_free(&nf->nf_rcu);
> +	nf =3D NULL;
> 	if (ret =3D=3D -EEXIST)
> 		goto retry;
> 	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, ret);
> --=20
> 2.38.1
>=20

--
Chuck Lever



