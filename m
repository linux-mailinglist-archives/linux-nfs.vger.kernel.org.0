Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA763378AF
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Mar 2021 17:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbhCKQDY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Mar 2021 11:03:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44768 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbhCKQDJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Mar 2021 11:03:09 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12BFtXSO045293;
        Thu, 11 Mar 2021 16:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=AkWzmvBzjG68h+WKeHJFhilsbQGvj69M444UL1A+o2Y=;
 b=DjiUPjWSdV4mNrcC0g0Wr3vWvFvs5nLOrWWzbvBVKqDMPVBhMq1pk/7fWYmRGPAosk0m
 QmrmZjkJrUDB/qrhr6tA4PYpwXCrdhTikpvi3RrEk4AwsS/x3rTYZhpEZwhVy3zutMrO
 ukLKTUk+z0OO1Nc79MTG7HGsKTWuHdpfoQYQsTcn5uzAw7hv8oY7RCeJm2OV81kiCU7I
 WrQ3OmO2Dh5F/uaDgEnJFq6+BSUBJCQvVasvwvZyRlKCGrf0kSRt/NLUVOgIRu+Xl6BD
 tMk63OyMZj8h89/+0ql0UjdbqpxwEnagzlrQgRlptBka6AWr7M1gqEEXJ/CqUFAUUReF jQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 3742cnf2ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 16:03:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12BFttmF065064;
        Thu, 11 Mar 2021 16:03:01 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2053.outbound.protection.outlook.com [104.47.36.53])
        by aserp3020.oracle.com with ESMTP id 374kn2qfuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 16:03:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOzAZGspnpVk7BV0F+SEc6dy8LC0bkyUCC2xmtPz0+jXUc1XnzzZFQlww7wOwOQRxM+4fq5IuKZsy/0dUMFFjie+xo8kXbL6fbKQAA8qRlT5WMkJXrE4x2cOp1w2Nn9xODN2HPPeHs1b3L6ytdAvrLUUkr6icaMIxG+0HoG2oexf3u+O0QhUCNjKWAZvP5Ww+B7PLGQ3leYbW08Wt7wg6+siMxGHzFJdvXN5rem/EX24LvSPi8s3ViwpfWR5qLgz4e0ys40t/lVcDfIbdBjSXhHpANaVOgYzVyIVsH4URGSjEaMf1sez1oZmCcuggI1TrUdzqbvxF2bQYXbUH3o2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkWzmvBzjG68h+WKeHJFhilsbQGvj69M444UL1A+o2Y=;
 b=JeW/+x83xu7/puqbpYg28FKwvKEfU0keM5E6xi90kJqAdAz59T8vXcSgGVLboMSHtaGOstiTLsVGbGNx4cwOtTZFBQ0GAoXgfOqugy1xbDAWH7KtOlKxsWQdKaZhZduA8lXw0bxacuz2ryh8plFM92rqTAW7r84RBs1B2D4Rybuh1oZFffjWMXR1conqpxURVvStlXkI4HKmi+nteODIzmlyykFB64ApWTk7OINnbeGSw/XC0aWPMLHVnWuQShf6gk+bY0oAok52oxF9gKkB2KbPjzCe1b7BUUjfEK25c2tQsBby5W7VQpJDLVZFvi4VYPDIE/82GUcnxyerR3uGvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkWzmvBzjG68h+WKeHJFhilsbQGvj69M444UL1A+o2Y=;
 b=lgIsCbEcsMtF3P9uyWZz2hXDahxKwGyiRTyP7PxrLWsytFGBPX+7zOIJTIApHYr+NmJ3f3RyKLuYgSCcMqPh+kdizRo+NQrWm0aY4iiHGuaRgTkvmBc4kLPX+vvud6ngq/sDyOXFf5mCp8f0T6/Lqwo6WVgMiwd1x7cs/O0sVVk=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2792.namprd10.prod.outlook.com (2603:10b6:a03:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Thu, 11 Mar
 2021 16:02:59 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 16:02:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] NFSD: fix error handling in NFSv4.0 callbacks
Thread-Topic: [PATCH v4 1/1] NFSD: fix error handling in NFSv4.0 callbacks
Thread-Index: AQHXFo7o3JLy/Gvzh0im1bdfEfIZyKp+8uQA
Date:   Thu, 11 Mar 2021 16:02:59 +0000
Message-ID: <9BD1A9B5-4105-4612-9599-A990ABE1A42C@oracle.com>
References: <20210311155500.14209-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20210311155500.14209-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e130de18-0633-41e3-5b6f-08d8e4a72478
x-ms-traffictypediagnostic: BYAPR10MB2792:
x-microsoft-antispam-prvs: <BYAPR10MB2792B7C787F76F54360A220593909@BYAPR10MB2792.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YNBiHP9jwo5eN0BQdMF3pmnt/yuFW16GBCfGm/DqHTyRAomnLHYxjBdxBBTDDYDBZm6AO5wzyaIPiYIWZUzGJNScFhuqNOzlnC4DAlEb4DUsff20JSzpaLqmsoZJA/RdN0Vsr2Kiy+7eh4hF5bLfwj7/zxj9SxelT0+XV9bx906CLAz2eSVl2CDWplWuyf2JAE6U3qGid3o1gggHV5vRM831fmbsULIwZR0U8JHialyGvxjZnPC+EwsX5x+hq+TuY46kn5S1DTLUTAThAHbo0hxulZUxY0dqffBPbRGhjwSi6b4Wr5H2t06buOoZl41hckuNMsw6Jbi1OgaX8zKkFCZeRnLaUpYrqwgbAkxpkJznP9YapMCNe1UO/BvKsG5jBN4MP+0LYvfhjuAvYgdp0kewe2oo4SO0EliKm7IavWFhRHaiqyYIEV5gc0Mi5LgS/CQsUm4zBGt1EsujMFGpLcc8OfahRUTjRCycQikepTGBvRS4Mj1zOW+PEJSLufkV42njsiRHjvYFjUzioZviokUlLT8AXtmlHHUC4FS0cAwOfQF9gUaPSm7F5cZPrWcJsWGh8DJLKTWNKHmIPnpt2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(396003)(39860400002)(366004)(71200400001)(4744005)(2906002)(6916009)(4326008)(316002)(36756003)(5660300002)(66946007)(66556008)(66446008)(86362001)(64756008)(8676002)(8936002)(91956017)(66476007)(6512007)(76116006)(6486002)(53546011)(478600001)(6506007)(54906003)(186003)(2616005)(26005)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uvoHC2PI5iciTPl76YZqnDgXJG1Wg4iNjaabGgW9ZAJb42hHNdkm/f0SuS6w?=
 =?us-ascii?Q?hw5trFB9W8RdJj60ApGh1BFBqMcAAEOUTMl5u3M+FeMGPIfUNyyfwtbW9Mmu?=
 =?us-ascii?Q?hBGaKQJQZQumgZjsXOfadZOG/+HSuU7OuYI6BKq4cGMZQfrFuSDmj1ez3RXB?=
 =?us-ascii?Q?xCO3uXdFdg4Cmv9MrupakVrkcK8VOT16fXabP8wuaCZfpAeDZjqkq0ylwGcd?=
 =?us-ascii?Q?vv161WijFl6FEKSi8clVO7Q+mk+YjpsE8T2dkkew64vbaFWtS8RvaAE4doo2?=
 =?us-ascii?Q?nL8k2o8gohdPzHOYk6pqF86751/yCVFKWfQWHip5dncMrUq3C8pjVZRwLmRp?=
 =?us-ascii?Q?2AragWV6u2OZzwMuz6lFgCXzOecN3UzPZA0oj0JCANCIyUdl96ZSRG8zyF9l?=
 =?us-ascii?Q?WsQJQoci0LzYUVS3MmfPauC/XD34LZRw0FB2M0WCE2jydtSHv2tdU7rdavia?=
 =?us-ascii?Q?ofwXlEhtmgFOD037KbFG7bvEvIjBzdZCHpe6XACrxiUj/k9p8VZtojiyN89a?=
 =?us-ascii?Q?4DvJT3ChkvNvakz9c/tECVzKOHaRIchxx2vMSSjq2KcmyNocISlr0OfYnKlF?=
 =?us-ascii?Q?6hY3rwGaYMqB93YS+aU496atKB+kp4RVW/fQhA8Ww1EzyKCohCV/hqWUhVRA?=
 =?us-ascii?Q?5REB/XEt+HgirVb4AhHl+XihP1QSAivXGjRLMh75VbevSg6Q7qOJxmz7p/Ow?=
 =?us-ascii?Q?iYdVhtohxM4jXpIwWBEB++0RG3th37NbjVAIBJMlHwD74iipkPOicaPVL91a?=
 =?us-ascii?Q?PgRpW+vzP2GTrr1TGpemOH2HH1TUhv0lXvIXbE5G1dtfFCo4tISbBlqHIPgX?=
 =?us-ascii?Q?VU+GxrQCqYz8GVSx1FgpZbFKp33wg4DJv0qk/uq+AarPX6Om/Ma0YUFYNH96?=
 =?us-ascii?Q?ijiAZRPWxZKYXYrG7JMUrOa4r7l04B9iBg8cM9J6p0UWBqsEmMcZbaEIjSBP?=
 =?us-ascii?Q?q3kvyFI/YSYoOPF3x1UZTOR1nrVRyvWmn1yJTKqgbA/6f9XmC3m/t/bj600M?=
 =?us-ascii?Q?N1ExkvWmZzIAsNtbPnY3MzkBcP0WRBShuPfIuzodmUQbiqEMV6neo5mGE7pN?=
 =?us-ascii?Q?aLFrlWiDBPlzBejRSOjtRT6zdPGPk/PHrloVqyinBeKMJtDlt0Xr8R8QzrRj?=
 =?us-ascii?Q?ZAiWVSDxHGDtzhqo1XlvKkMt1+j/x2JhNqceIZyCF6jJ01ELvoT6I9zdsKak?=
 =?us-ascii?Q?Dim9avtu5weytfDpHv/BJPRlJo7HzLFCMiU/rFhLEXnFyaq2dcmvsL0+/nz7?=
 =?us-ascii?Q?kLZkKvFYqebxWvztesvkQmcPrEb0jsXJfAMozlpgQsIvCZpfBZrn7mhV5nCJ?=
 =?us-ascii?Q?eH25kjY8vbllTXS7omCJLHM9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A31E357AF8E860409AD17C6294B21754@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e130de18-0633-41e3-5b6f-08d8e4a72478
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 16:02:59.5065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TnTYUjCGMzEJsFJEMtvutf191Cj371L1bFJtZPVK89pTGN3prycdZMXtHYdbbrzENhmBt22Q+E+JF85SOPRsLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2792
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110085
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 11, 2021, at 10:55 AM, Olga Kornievskaia <olga.kornievskaia@gmail.=
com> wrote:
>=20
> From: Olga Kornievskaia <kolga@netapp.com>
>=20
> When the server tries to do a callback and a client fails it due to
> authentication problems, we need the server to set callback down
> flag in RENEW so that client can recover.
>=20
> Suggested-by: Bruce Fields <bfields@redhat.com>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>

Thanks. This patch has been included in the for-rc topic
branch in the repo at

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

I added Ben's Tested-by.


> ---
> fs/nfsd/nfs4callback.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 052be5bf9ef5..7325592b456e 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1189,6 +1189,7 @@ static void nfsd4_cb_done(struct rpc_task *task, vo=
id *calldata)
> 		switch (task->tk_status) {
> 		case -EIO:
> 		case -ETIMEDOUT:
> +		case -EACCES:
> 			nfsd4_mark_cb_down(clp, task->tk_status);
> 		}
> 		break;
> --=20
> 2.18.2

--
Chuck Lever



