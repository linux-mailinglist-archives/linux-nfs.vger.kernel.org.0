Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3923708D4
	for <lists+linux-nfs@lfdr.de>; Sat,  1 May 2021 21:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhEATpb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 May 2021 15:45:31 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35926 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbhEATpb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 May 2021 15:45:31 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 141JaeJL131520;
        Sat, 1 May 2021 19:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=q4H0Hr6li+Coaf04F6AjSAPa/apu/r5IvgdZfJcU00s=;
 b=MK/GKYCNU5Mtcu+iOs2kQN9wj1WaELVJK3iuoZUkC4yYXehJBC39zC36M01PA16bGZJn
 33jQYmKHIuXr9cNvr2I2v4anfWDymsHuR3mGmftEg5DDcr7a37NWo9P07ozjc4ciIolc
 wOggTmZgMigPe4iKexk/8v79WFrjNI8l7f5bE1N0P3/BqQAf+VCT+VZBm2CHO5Np3p4d
 igAhYrtO3zrAS+Ewa+qd13QhKil5lXVgJ7wdgtdWbHbTwHVcJiYVCXfVgOD07Ym0bT8D
 Na6yBh+BMkcQDMn826KajPeD+iiaoylG0ckCI4NNcpFmhIzZscIgqUViZzKMzd8I8ph9 og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 388vgbh3f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 May 2021 19:44:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 141Jf9IH042433;
        Sat, 1 May 2021 19:44:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by userp3020.oracle.com with ESMTP id 388xakjw1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 May 2021 19:44:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QI17rlR/U0hAzI7kP+y8GxuTNT/BHtYX+XdyYC6zLCBVCQBSPblHM52gWh6fsy36QJ1FjvWKGNBjQ7I1c8Qg7nYj6exGWTLGx8su8ffUkfbXZdU2XG7EwtD+684tvJPVrIdsgaY7KQBz47wc3vAe9pjRKk1lT7j3Lo+pZQmZcRXJ+1KvnHB5HJM1DJQfXjBGfn7amjSpbH3XbuzdMQgH2iKMWeLREaoP0oiG24vHgq76pXsO9Gw50oCqn+p+rHmxq4HhHjodO8iytYFUbkcBwH4Z5KAnErQeYyGQU+ZoVZZBtcke90sURuXxj/4dUE1HCt4+t1OgpuE3dFBYbFys9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4H0Hr6li+Coaf04F6AjSAPa/apu/r5IvgdZfJcU00s=;
 b=F40aeIq8uvbzXGD9860qhxEicXh1aSF2CI8Cn48Cm/LOmtzk6xszsqy5fvKat66auLpBJ03r6Mr+sE3U3ANfHwGeVvfKWiwLVDZf4WFzI7LddpPOkw29Kz6V6GuW+LqNhTmKob6xFnSJ3H5I+pTCIHGR9sXfTvmwIc15zLONRzqVc2BI64kW8S33AE08/YakOePexWiu020d2Ys3a18nAHFcPh5FV2CsDrkV5OxjDkpks/7FrGQCZUrqmWwxeourucwSikYHpGla2CW+1OlNYS6pRhu+pW/5IUwfHxzTgce0N5IK65Cvq1jthF9uzikpVPPB/ngeNeE38jfCqhBEpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4H0Hr6li+Coaf04F6AjSAPa/apu/r5IvgdZfJcU00s=;
 b=QszYq4VpoZ+8z4cZS04mQ6JvzDA87qTjntdanACbvNrmDngwdX+OzdNi8ZxN9eyhtP7/4q/zDXlfuMB8Yzop1VxiUCN/zShCSUkTz3AlTN47FZKC9+mQA2N31qRQZiko2aAlBcZFEd92HgBG/ick2dVfEyJzQcXfuWlXENmpQ8w=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3382.namprd10.prod.outlook.com (2603:10b6:a03:156::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Sat, 1 May
 2021 19:44:31 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4087.035; Sat, 1 May 2021
 19:44:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] xprtrdma: Fix a NULL dereference in frwr_unmap_sync()
Thread-Topic: [PATCH] xprtrdma: Fix a NULL dereference in frwr_unmap_sync()
Thread-Index: AQHXPsGwkCwxXF4vCk+FVN4yR5ZyAarPB0oA
Date:   Sat, 1 May 2021 19:44:31 +0000
Message-ID: <64FF51D5-DBC5-48FB-AB90-B95B325BEEB9@oracle.com>
References: <161989777022.1772.5943251585208443632.stgit@manet.1015granger.net>
In-Reply-To: <161989777022.1772.5943251585208443632.stgit@manet.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6d1964a-bd60-4e97-cd25-08d90cd98a2a
x-ms-traffictypediagnostic: BYAPR10MB3382:
x-microsoft-antispam-prvs: <BYAPR10MB33820C024B9AE7F43EBFBD21935D9@BYAPR10MB3382.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dy9R0QDGBngLGB0mt6QzUrCgHM/Zi4YIPg6N4QXmGfjoCHqDlaFhkOdsXe1rVDFDneZ+F9djNUuEdKJqvb7iGqEW+bwhMJ+nlkwowfOYZ92h5/kJ/H6FPOVweOwRmeEAph0lrZjnXgfbPlX0F77ykpK4CDHuF5WVY4u+KvdhB81ruWlS/KFy1HhTrAKm7G30LsjjHJQ2Mz+k0VKsBjfFUH2f++IStHn6R2cPUaAyQpMCu7NWJxJo+/atl+YmBPGDVdb8WTbEvm0Md5kMQiAixEOip0ipe94mmh963EDP02+R8i9ZKi1/gIQ1D4KrZ9FkSGTvVGt0pWCHHodpCxN65eK33c1dzfQawkrspDaoqiN0m2PZAqu7kzAlyGWkWFkXjUwA49ZwBjV/INXxrcx+XeXalgaeRK0bw9eA3vUowRj3LART+sGIE+rYmVM3lll6UbmMNXPyshKpnADqDFnLTJMbbHTcAx5UeZiGN/fkCEL1YTd5AIrGn3nSz11K2UyNySiqlKFfakMFznItZNlzM8RyPWQLpZ44fYwt4Vg+bWysn3ddisiAdY971vMDZ6QaF4eFDlwKjuto/K6qmubtt2WrBjID2bam4gBRvMUQhg3yi68HoEO478ImS1s7nHcjJrbbTu7UOW2sFzDNmP3w+0NiFuAqy9Tqa0WkE1cjoqo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(366004)(39860400002)(5660300002)(316002)(6486002)(122000001)(38100700002)(71200400001)(6512007)(76116006)(91956017)(4326008)(66946007)(26005)(66476007)(66556008)(66446008)(64756008)(6916009)(83380400001)(186003)(8936002)(36756003)(86362001)(33656002)(478600001)(53546011)(6506007)(2616005)(2906002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EIjoewIKNWnJGRLlI1CJUxWKfs0VxqBHdWf7Q93WojoR14ftMXT3LiypqAX9?=
 =?us-ascii?Q?JlgQXyUSvqFp2lMBvqCjpca+CcefQzJdeta3kimiZPfPvwfwQOsj9FJMcDpQ?=
 =?us-ascii?Q?+guhifZfXSgo+d8xjcqhAe+cvPtlN/DmdE6Ay9hedzWAI8qOwbFZWQueXeh7?=
 =?us-ascii?Q?47Vs20QXfTkAOJdxmUSFyI/SMpXeJn3LH1X7NQPJAR9EkWOcL8mgGfT5WL1o?=
 =?us-ascii?Q?B/qFwE9Mbk6KNfsVPLnbMWby78XxlwdTk+BIolMSRJVJf8BE11L7HWTwYUhf?=
 =?us-ascii?Q?zL4KvLH3DLwtVmDcapKOtOszJgbdH8XllaPWj+ypLATYCdfiBCbs23AtbP7V?=
 =?us-ascii?Q?u+EEeGr0pESUD/xiuPWuJaKC1TGJne+HkoUVyUCn2PV0DhMdh2sKBi93pfwq?=
 =?us-ascii?Q?VlXLCr1SBNrKj9nDI1BanM/ke3TyeZHYrVnFMx1Z63HubMBISAE8jTjzRhgX?=
 =?us-ascii?Q?5tV7zEF9gEzDwhX8DiZmazjYmqKL7XlJd1q9RH/QdDLQ2uh6aisVC9n2lwaU?=
 =?us-ascii?Q?W9N8+YNMGh/Im2m+F10rRIW+Yo4TYYAdLZZQneYSrsT9WYL60OFDvBNn81FU?=
 =?us-ascii?Q?HDsa4dbYNg6Re7A1/v3MHqBODa84KkQUJZHK2AV6VXn7M2mLjCyZxGgGHlIn?=
 =?us-ascii?Q?2CMPlOIQsYCoOGFGWMcPxtVwgdNjU17GAedUI3x0gf6MnWTexoG436AiJ0/B?=
 =?us-ascii?Q?GjQwwf1XHaDhiXpA8TeiSEIhOpiMNsAyJTwgk/PwTjrknuGeMevPIdx0n/f4?=
 =?us-ascii?Q?yWazsW9wyO4SVe31i1MVhts3ryA4lX7vyAAfH39VSl84Xr3X8RgI7bzzKZoe?=
 =?us-ascii?Q?FFepkxtLJDOcJoLz7QKXqtvFmldXFPHZ31V41McNcclZduar3qjj1LHR29bD?=
 =?us-ascii?Q?eh4JSv7U89LIqTDwslHRepQbUHv68bh5LqjGroGJy2gtEHKaYCkU6hzg5N8H?=
 =?us-ascii?Q?f8f9+mD1p88109XJnFUSt0SfsYk6jw6nOUnGRqRUln9OLaCTnBLS4Eo18vH7?=
 =?us-ascii?Q?ufLQMiOctcExK6Yj03PW+zT0RJ3X7vSc7Vvmo90o/2rb0OxLnZaXMw57soOd?=
 =?us-ascii?Q?CtTJ8fOV26PCXB2gFZDJRwL3mK+vdcV2nVAFbPDMLYN1VtBive/0zDTB+L2K?=
 =?us-ascii?Q?xha404hxZlAKbo/eKeue8AVuUHYQWVUHQXx+WQgcGh0xFcGiuOdTz0z6Ns/l?=
 =?us-ascii?Q?V0vnFEcoZYyRm3m+Xz3ac0uoqZL8szRBBaTBeWMcjYGX3yI3klXmQP7RuNjw?=
 =?us-ascii?Q?Vk6QdkJhaltNc+49yDujmFumXHClRp5xcpE4M8J1L07fg3l2GOlFLJkDXNQJ?=
 =?us-ascii?Q?VQ/p2MsBL+a0RD8cy7YNpCSC?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <57AC16156AA40F4DB403B8BF47CA2482@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d1964a-bd60-4e97-cd25-08d90cd98a2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2021 19:44:31.4296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +53qj0JIZuRGrwz9WAv6TuURKlrMf1jB7JH+hpKnAKTirqoky2HpGkO11j7px61uikACN1iqpL7q5kucIVKwQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3382
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9971 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105010140
X-Proofpoint-GUID: 4k-1Ryc1QJ18wGZp182dfPuySa35sOMu
X-Proofpoint-ORIG-GUID: 4k-1Ryc1QJ18wGZp182dfPuySa35sOMu
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9971 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105010139
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 1, 2021, at 3:38 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
> The normal mechanism that invalidates and unmaps MRs is
> frwr_unmap_async(). frwr_unmap_sync() is used only when an RPC
> Reply bearing Write or Reply chunks has been lost (ie, almost
> never).
>=20
> Coverity found that after commit 9a301cafc861 ("xprtrdma: Move
> fr_linv_done field to struct rpcrdma_mr"), the while() loop in
> frwr_unmap_sync() exits only once @mr is NULL, unconditionally
> causing dereferences of @mr to Oops.

^causing dereferences^causing subsequent dereferences

Sigh.


> I've tested this fix by creating a client that skips invoking
> frwr_unmap_async() when RPC Replies complete. That forces all
> invalidation tasks to fall upon frwr_unmap_sync(). Simple workloads
> with this fix applied to the adulterated client work as designed.
>=20
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1504556 ("Null pointer dereferences")
> Fixes: 9a301cafc861 ("xprtrdma: Move fr_linv_done field to struct rpcrdma=
_mr")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> net/sunrpc/xprtrdma/frwr_ops.c |    1 +
> 1 file changed, 1 insertion(+)
>=20
> Trond Note: you may need to update the commit ID for 9a301cafc861
> as needed to properly reference the final commit ID for ("xprtrdma:
> Move fr_linv_done field to struct rpcrdma_mr").
>=20
> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_op=
s.c
> index 285d73246fc2..229fcc9a9064 100644
> --- a/net/sunrpc/xprtrdma/frwr_ops.c
> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
> @@ -530,6 +530,7 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, str=
uct rpcrdma_req *req)
> 		*prev =3D last;
> 		prev =3D &last->next;
> 	}
> +	mr =3D container_of(last, struct rpcrdma_mr, mr_invwr);
>=20
> 	/* Strong send queue ordering guarantees that when the
> 	 * last WR in the chain completes, all WRs in the chain
>=20
>=20

--
Chuck Lever



