Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014BC62DE8C
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 15:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbiKQOpe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Nov 2022 09:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbiKQOpS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Nov 2022 09:45:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49B34FF97
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 06:45:16 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHE3xlv007746;
        Thu, 17 Nov 2022 14:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xG6u2qT8qf+PHFo/m2vMD7MV6oDfuNN0b9XA1hKCvWQ=;
 b=s6leor9NYJDugV0dFYDovMORaDbxdQmxb9XJ/UrE8dxXKpms4WjeI/44bh6978VN/naU
 qYSklfzz63KZSHxfUVYs2bqcjYrZ8F/gV122MaHEw8AZybUDOL44MVXnm4O/4ebavXNA
 oVPYoX8qtzw71VxRh+KpatU0bs+sDxqD5rXQEXu0kYQHonxzGIGcGIcjO6HElqJk6grJ
 qN0abLeV1GqM6ro58y8Rd1IiKX6OQQrIg9BGVQJEyVWiSpJJEBXczVEJBoPvLCWsCBPY
 MfoTCGPs30/bWxhgwiddpzpDwsA5DRF5sk2aV1s5MPvyQRWlA8Be+B7NYr9ZmmIZSr9r YQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3hu1kab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 14:45:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHEBOqA008832;
        Thu, 17 Nov 2022 14:45:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xffw34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 14:45:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFKDUDHEwDgKFZ0cmdFmv3UDtIwjfFtyr9ZtO6fUpi8WX9q+qm/YQ5HJdPWOZ0Hyy3R2c+0TFPxFzIH+lvHbDBhK68Ll7zixbDItP9SKvKoGB0/VQYDJHStbYJGngduzyYHiGirclLJf+9oK1TvWI5sKnUXGZRZ+xFvdHWL1x0GUWOmAZqfyOzoPxAr6KMQtaiX6Kqk8uQhJDswo2tIhqMGwlsATpjdomkwIR3xDlV/GStnSY4CM6NMfeQLGjZrAEOocPv9yvmOjODSlDuSCfB9OQLMloicHPdWGEkUPlgJfLCMaultEIRdSQ4rW743hbhSZfyI4mifxUVVa5Cxalg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xG6u2qT8qf+PHFo/m2vMD7MV6oDfuNN0b9XA1hKCvWQ=;
 b=nHTcQ1afKTpNPdEnoK5vqzqMj6hUzHkFjeTxWtlF5KbxSq1REU6n5Ze72XAwQS9HopNRLfUQjGw1KXjaHuo68BBvWxVdiDmx9+8sJ1eCwysp1VClqEPR6G+wl1x+bARAQHoluO17ezJRs/lY61TkSVvq5s/lUj9a5yjdQgFwEyfqJEorwSTaHq0gcnQN904y6T9MMgGqR11ywzPv90XGK4Oq7fAZbrkUd0M0jT+3WNPwlEcuUDRIGsvPiVfsUmY5guYysFYqFbR+VmI8OzSCqx8F/kPMZoo4dJ+pO4XvCRX7A6XiTo0R266NyRns5C2XatRGZ6KFCssF99RB7iFD3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG6u2qT8qf+PHFo/m2vMD7MV6oDfuNN0b9XA1hKCvWQ=;
 b=RWa+MFDuX3dW8cJMp4XeEzjLGbqNGKUn6NmmJ6gFFGu1ym01CHaLLER+MVAoLUU2RtsJJIDRQlrfXF98cmrDH+cg3ptBwdwZQbE8FiN7z5gAeXRwu/VzFhQPAnexKL7obMgJUhOh7C5qmlWBZBvYRa38zzZ4idaoFkSb5HD0aB0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4426.namprd10.prod.outlook.com (2603:10b6:806:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 14:45:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 14:45:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 3/4] NFSD: add delegation reaper to react to low memory
 condition
Thread-Topic: [PATCH v5 3/4] NFSD: add delegation reaper to react to low
 memory condition
Thread-Index: AQHY+jb3Q9z7OCAXJEO7/AW220qSP65DMfQA
Date:   Thu, 17 Nov 2022 14:45:10 +0000
Message-ID: <E139DCC4-ADC2-49D5-9386-1471E8BB1665@oracle.com>
References: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
 <1668656688-22507-4-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1668656688-22507-4-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4426:EE_
x-ms-office365-filtering-correlation-id: ce2ec57a-378b-4b02-0d5d-08dac8aa53f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QSWS+pgJMsp3d7gmtPXBy+4FVQz9jbAJgyqynd9/w6dYUEHk6sNKuIDRwtElWtnOVnkcFCVe/QYziCORMJPRe+9ay8pUbdW6JmUXjWnBWmSZRwchJuGEhOlXWd8uUK2rU649ORHYikUvp8vXdQS7O44fbEOiHaT1HuCh16KDO1Mhi5pOiBdVxxcCY5JGQNklCGikhyuc0Bev4XB4NTXlYolm7cOubUps/QLqVTlYZP49SpvxVSZRUkXXhgFIimceWOw9tR/F7IJ33/idrojuAJiKcag8e6YCCOEb2PgG0tjFjFtCrFKmq3yUb3xwENt2HlayqYCB2Baf6/PYRgQdhP9P6uJ2mmYu0MhJ28wpA7Tvm6erk16y8HYI5bla1cNY2yOs8PPy+CmenVy5wSioi0iRSxpUc/Im8b942kziemHgR25GYYyZQZHESBPzvB/ajH+eVKKef9gq6QssYnIbg8y9EidYOq6h4peqk4aSbSdc72xawRi+WfFsOMrE6sokw0ZSP99t/UO7rOqVVOr9ABcLgrH8uVFZkq0myEBjweEwZ0Kr1Zir4050OS/gE5596iP3PLF1CCLA+dNgdKKPcSWVtpgTMEjrvcJEzttfqN6rEDppM9umUG/UC9ON5EYQAhqkbq6CzC5miLjEN/syz+76Ice8pCo9mVZCNIZbR4Fo8Xpx8bAnoNERfJDvH1D2C6Y5qObgEKFagoe0YM8LLr0tfVpiHDSB/BWbuW+/qEw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199015)(2906002)(83380400001)(36756003)(33656002)(91956017)(41300700001)(2616005)(76116006)(86362001)(8936002)(38100700002)(6506007)(37006003)(54906003)(122000001)(53546011)(6636002)(6512007)(38070700005)(26005)(6862004)(186003)(5660300002)(8676002)(64756008)(66446008)(66476007)(4326008)(66946007)(66556008)(6486002)(316002)(71200400001)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fj0hvJ1ahs2OBGIDX9LvjX5kO4RpRxWa0AcZss01VFBi9mtNR4Hnw8iPorQ9?=
 =?us-ascii?Q?GRk74elSaxlTnzKXhlsGAeC61W9FQI15puCuYs87PiDGnoLPzqoFNuu3u9iH?=
 =?us-ascii?Q?DN9WzXcE68dxkz5v6RUU+uHA9xWx1KtD7FlVSWu4XjOiaeUmm9qBbLymN7Ex?=
 =?us-ascii?Q?bDHXGKCm6zsJeicyKobZHoZxEaWUVS91y+sLILDPTu8MtTnEL7Uw0QFXXsmN?=
 =?us-ascii?Q?nbrW+FO+48CBPrb1kgYXPPUzeioD+4APNrP1hDroirNdFuMdw6jP9j8mb2iI?=
 =?us-ascii?Q?Yjt3GYqIGNG7Gadcn1QnJuMwXVFbhZ5v/wGKPrdRmWYMJhBYNgCWsmZ/dqKX?=
 =?us-ascii?Q?LqWT+ZaPZN5tz0i8EFE0uV2JavCk3ZYyjaJYHyP/fQZJznOeJeY3egh5uu7u?=
 =?us-ascii?Q?YDH30j0ZAUHmz2w3Uxij+Vr0vpsOMDg3qRatUanUyxBmWLzBKc84MTETaXzA?=
 =?us-ascii?Q?LRvncvi4tOeNZO0X0OyR3NxGN3dQjCPe2cu2hNUtMC13agBQPtw6Hyo9xQu1?=
 =?us-ascii?Q?GXF3YXiwUYZr84oVdybDYLOnWlf/38uh8Hydd6KMRVG7aMpuTn7DTtzIbLBp?=
 =?us-ascii?Q?er8WH64oHXl1WxnLcumYTp3ZcEXnII3zz2WMjL0ptCR73OeKttbpNKX92xMJ?=
 =?us-ascii?Q?opnW4HdH4cXvgsHPYy8Qcpyx+BxpdXp4CyUoeD6a9ziOOEfv2gDNHHpk4H6U?=
 =?us-ascii?Q?UyssxOnd5nY5F1V3OZIwGvBq9iTlAsQi53gdlfuuAN7ju7cAct3WXmaqFCJU?=
 =?us-ascii?Q?GEwrySMSoh9+HRn/UHyKQIf14UBTLde7pePl4sLn1EITdr1DIwPae6LDA5hJ?=
 =?us-ascii?Q?42B7sd1fUqVXXU5Vxkig5Si79kwFAF+yIWFXxF8iSoJWAiWvRDbkF7JIFJSL?=
 =?us-ascii?Q?3e6cwx+BbW0afhnclfWZ877umjSuqUL9d38xvpE+HzXTm8UoayEtRTjhum7c?=
 =?us-ascii?Q?qYssvVB0AQu7romSUMU/79qhgicQUb2X3XIjxA0UhVHKfyZPnaIaAhEOmEGr?=
 =?us-ascii?Q?r0gBaoMf+G0sZ9orzUPyh5bK7gBrsDXKv+GhNRMUPPv3y5ItQ3e+ERM6qrnt?=
 =?us-ascii?Q?Fj7Ledd53f809zJZRFl8uuIEeQKQfvSfpUgvyPpoh7Nkd4np7rujuXlDHZMZ?=
 =?us-ascii?Q?jcbKDmI9f0Xzz+DVfLBAre6K6SxvglID4AwZ+qM0G124X1fypZ7GJm3pj+oV?=
 =?us-ascii?Q?wNd5j4wxBj8Bd1MC/IlYmEfQ0EQDKCmfFh0cT59LSY/WmFgWNtSCj+eypA38?=
 =?us-ascii?Q?XY27J19FsO2fF1U1ZBAOjcPQRHfKtefgR6oCoJpCbCqXSOUVduQjgYQqwkmY?=
 =?us-ascii?Q?yuFFp7i4+wt9OEJy0Sq0n5y4Xjseu7ZlSSGYqk6J92I82l1Jh0LIB+xfYPIk?=
 =?us-ascii?Q?lhcvThLIg2GbzFR8wmi7Jz9rro/7ZWVj1j8u0tDBLH6RnqsEZ+iXi1E3rD0n?=
 =?us-ascii?Q?P/SHAOnzm3Wv1BRJL9rY5UWybDxYQZcrHkBwR4GjlGXucoAXKU4WkPqcfiCT?=
 =?us-ascii?Q?1QgEHmJOkYSbcv1uEORtnWYBJ5Mh2BpJBg8gfw/VDYs8ugC0kJLeSFFcdUlw?=
 =?us-ascii?Q?K9djcbnECB0XAMXi0x1nPXV54VgxcVqO9McLAEUqTKEUBzhOOqPqIT/9ne9C?=
 =?us-ascii?Q?qA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C9A35233A57A5348B9BB18F9C2E18595@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9K8EDSpRleeHvzb86E9RZ1hmzz1TO8yi4FUdY2iymq0rGrHBRRZ7Fgk2S77dp1xi4OfmyZ3H5abKp3JYIkYaD9y3uUA5CQp7xdjeCf6AtCT73mCgAcVjkBSaVSOhv7jfEXXzCqGZF5j1vxGPmbHWxD6AkUPQEC+ICdDT08lo8e/JOXZyuglOj1rnAJBGZh1QH7xoCNrzOJhCy+lMLQ3g1qHg8vI763aSpaVXv9bdDT89qxGaKI0egcqsGfewhMm424VlaekRlIPK7KDNSVZ3OC+M0aD4ZmXNaPWgYxSrTpIXeMf49UbTtSUNBcQL+IWVgcCIgAIIQfI9VYYRgaa9n2E7KjNkUHh3yYYdnkH+W1AkWHjT9N2Ufdc+CbQZXaF9W9fd73g776Do5hTtaLE9J4VQXdmIb+UM1kK3m6XWOyguRHNQqkXG1KWe9aRbEWkwdDmkyVFdCOkeVqPb7AW62L2/qv1tglwxNAONTPFcD0t7wIPEhiFYIhcflPz2r+3XTIUZlY/nlFm7vZEI4vK8BKXi5KDnMl+xJxpOq+gAMjhhhxON6eSfmAWnOvHTpDTvPPBeSGdvPEUvQNF9PjSiZbGHx8ZN2/vlRizpQeqNaVIISg4nYx2dcj6jUrddqPAucXmTR4OZsZJ/J+kZ4j5Kzmqwy3UJddlKZlsbi1xIGrM8eXDJ2bnrJ74b5sqNBBOAJXdymS2IH/v7YTxy08+8Kc4g5sZHHBS35BWSHqSgSq3HXTFxdFlbC7FzNCL36sgTmLud5fcMYgAWjd8LMFFJRVu8CcslLzqJ1Jp4jfGDuqM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2ec57a-378b-4b02-0d5d-08dac8aa53f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 14:45:10.4285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fHE35MXxQtaI8mh3F3WQudiGZOI6oGJjtlcvIep1p1CzMWpTIGME80BMmrcgxCN985wV+G3AcvIc+L8iR/btYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170111
X-Proofpoint-GUID: 5ieC_uCnbs-_enVD_jX8GgU4AR3AIe8o
X-Proofpoint-ORIG-GUID: 5ieC_uCnbs-_enVD_jX8GgU4AR3AIe8o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 16, 2022, at 10:44 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> The delegation reaper is called by nfsd memory shrinker's on
> the 'count' callback. It scans the client list and sends the
> courtesy CB_RECALL_ANY to the clients that hold delegations.
>=20
> To avoid flooding the clients with CB_RECALL_ANY requests, the
> delegation reaper sends only one CB_RECALL_ANY request to each
> client per 5 seconds.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++=
++---
> fs/nfsd/state.h     |  8 +++++
> 2 files changed, 93 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 142481bc96de..13f326ae928c 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2131,6 +2131,7 @@ static void __free_client(struct kref *k)
> 	kfree(clp->cl_nii_domain.data);
> 	kfree(clp->cl_nii_name.data);
> 	idr_destroy(&clp->cl_stateids);
> +	kfree(clp->cl_ra);
> 	kmem_cache_free(client_slab, clp);
> }
>=20
> @@ -2854,6 +2855,36 @@ static const struct tree_descr client_files[] =3D =
{
> 	[3] =3D {""},
> };
>=20
> +static int
> +nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
> +				struct rpc_task *task)
> +{
> +	switch (task->tk_status) {
> +	case -NFS4ERR_DELAY:
> +		rpc_delay(task, 2 * HZ);
> +		return 0;
> +	default:
> +		return 1;
> +	}
> +}
> +
> +static void
> +nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
> +{
> +	struct nfs4_client *clp =3D cb->cb_clp;
> +	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
> +
> +	spin_lock(&nn->client_lock);
> +	clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
> +	put_client_renew_locked(clp);
> +	spin_unlock(&nn->client_lock);
> +}
> +
> +static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops =3D {
> +	.done		=3D nfsd4_cb_recall_any_done,
> +	.release	=3D nfsd4_cb_recall_any_release,
> +};
> +
> static struct nfs4_client *create_client(struct xdr_netobj name,
> 		struct svc_rqst *rqstp, nfs4_verifier *verf)
> {
> @@ -2891,6 +2922,14 @@ static struct nfs4_client *create_client(struct xd=
r_netobj name,
> 		free_client(clp);
> 		return NULL;
> 	}
> +	clp->cl_ra =3D kzalloc(sizeof(*clp->cl_ra), GFP_KERNEL);
> +	if (!clp->cl_ra) {
> +		free_client(clp);
> +		return NULL;
> +	}
> +	clp->cl_ra_time =3D 0;
> +	nfsd4_init_cb(&clp->cl_ra->ra_cb, clp, &nfsd4_cb_recall_any_ops,
> +			NFSPROC4_CLNT_CB_RECALL_ANY);
> 	return clp;
> }
>=20
> @@ -4349,14 +4388,16 @@ nfsd4_init_slabs(void)
> static unsigned long
> nfsd_lowmem_shrinker_count(struct shrinker *shrink, struct shrink_control=
 *sc)
> {
> -	int cnt;
> +	int count;
> 	struct nfsd_net *nn =3D container_of(shrink,
> 			struct nfsd_net, nfsd_client_shrinker);
>=20
> -	cnt =3D atomic_read(&nn->nfsd_courtesy_clients);
> -	if (cnt > 0)
> +	count =3D atomic_read(&nn->nfsd_courtesy_clients);
> +	if (!count)
> +		count =3D atomic_long_read(&num_delegations);
> +	if (count)
> 		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
> -	return (unsigned long)cnt;
> +	return (unsigned long)count;
> }
>=20
> static unsigned long
> @@ -6134,6 +6175,45 @@ courtesy_client_reaper(struct nfsd_net *nn)
> }
>=20
> static void
> +deleg_reaper(struct nfsd_net *nn)
> +{
> +	struct list_head *pos, *next;
> +	struct nfs4_client *clp;
> +	struct list_head cblist;
> +
> +	INIT_LIST_HEAD(&cblist);
> +	spin_lock(&nn->client_lock);
> +	list_for_each_safe(pos, next, &nn->client_lru) {
> +		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> +		if (clp->cl_state !=3D NFSD4_ACTIVE ||
> +			list_empty(&clp->cl_delegations) ||
> +			atomic_read(&clp->cl_delegs_in_recall) ||
> +			test_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags) ||
> +			(ktime_get_boottime_seconds() -
> +				clp->cl_ra_time < 5)) {
> +			continue;
> +		}
> +		list_add(&clp->cl_ra_cblist, &cblist);
> +
> +		/* release in nfsd4_cb_recall_any_release */
> +		atomic_inc(&clp->cl_rpc_users);
> +		set_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
> +		clp->cl_ra_time =3D ktime_get_boottime_seconds();
> +	}
> +	spin_unlock(&nn->client_lock);
> +
> +	while (!list_empty(&cblist)) {
> +		clp =3D list_first_entry(&cblist, struct nfs4_client,
> +					cl_ra_cblist);
> +		list_del_init(&clp->cl_ra_cblist);
> +		clp->cl_ra->ra_keep =3D 0;
> +		clp->cl_ra->ra_bmval[0] =3D BIT(RCA4_TYPE_MASK_RDATA_DLG) |
> +						BIT(RCA4_TYPE_MASK_WDATA_DLG);

Linux NFSD doesn't hand out write delegations. I don't think we
should set WDATA_DLG yet...?


> +		nfsd4_run_cb(&clp->cl_ra->ra_cb);
> +	}
> +}
> +
> +static void
> nfsd4_lowmem_shrinker(struct work_struct *work)
> {
> 	struct delayed_work *dwork =3D to_delayed_work(work);
> @@ -6141,6 +6221,7 @@ nfsd4_lowmem_shrinker(struct work_struct *work)
> 				nfsd_shrinker_work);
>=20
> 	courtesy_client_reaper(nn);
> +	deleg_reaper(nn);
> }
>=20
> static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *=
stp)
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 6b33cbbe76d3..12ce9792c5b6 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -368,6 +368,7 @@ struct nfs4_client {
> #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
> #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
> 					 1 << NFSD4_CLIENT_CB_KILL)
> +#define	NFSD4_CLIENT_CB_RECALL_ANY	(6)
> 	unsigned long		cl_flags;
> 	const struct cred	*cl_cb_cred;
> 	struct rpc_clnt		*cl_cb_client;
> @@ -411,6 +412,10 @@ struct nfs4_client {
>=20
> 	unsigned int		cl_state;
> 	atomic_t		cl_delegs_in_recall;
> +
> +	struct nfsd4_cb_recall_any	*cl_ra;
> +	time64_t		cl_ra_time;
> +	struct list_head	cl_ra_cblist;
> };
>=20
> /* struct nfs4_client_reset
> @@ -642,6 +647,9 @@ enum nfsd4_cb_op {
> 	NFSPROC4_CLNT_CB_RECALL_ANY,
> };
>=20
> +#define	RCA4_TYPE_MASK_RDATA_DLG	0
> +#define	RCA4_TYPE_MASK_WDATA_DLG	1
> +
> /* Returns true iff a is later than b: */
> static inline bool nfsd4_stateid_generation_after(stateid_t *a, stateid_t=
 *b)
> {
> --=20
> 2.9.5
>=20

--
Chuck Lever



