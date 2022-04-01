Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BAD4EFBB6
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Apr 2022 22:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352320AbiDAUil (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Apr 2022 16:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347930AbiDAUik (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Apr 2022 16:38:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A1E143C69
        for <linux-nfs@vger.kernel.org>; Fri,  1 Apr 2022 13:36:50 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231JG1QK031566;
        Fri, 1 Apr 2022 20:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UbNGVoXbVXeNeNANW3JmKPTKxrclRmZuNex7liYjmoY=;
 b=Xi8G002QUpy4Q2FLFYJr8TPa1IuP0ghnWYxgl4ZkK5Vri8ak9DKDmhEG8vhr+h7jpvST
 EzhJ324JtUTFBWeMxfsXl/m+2VhhfcQZvBqYETIKG7VRWl7QOXPzQWFTLZUf+qlyUMu2
 GlT4PYaLnli6ui85HVlSiUHwK5ohLHVGKwrSuFRx8IO+3fVDSOM2fqtWGRb/ZAhQP8zP
 BtoJh+jObViJKUV3RC74TfLokIVJ2vjYsZwtij/LYUmG5brSG8j5GOrQOj30Sw5IVKrI
 CIaX79WECjSON94sCoDgglctlas30P8AZK63E4ZqDjXLfLsQ2fR1UFBdBwxjBMko86Pv ww== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tes7xkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 20:36:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 231KUcI2008143;
        Fri, 1 Apr 2022 20:36:46 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s9649yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 20:36:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMbo1GVyMQrD4RMElg91I/EGFnDtat5N7m3KVFzjdSwYrcYJB/+c3nrquog/9mYIxoM1IUtRT/GV2LnAAdg9CZWKerBeLTkPy7MHdLptDBi7/6eDSugPZTxufDw5CeYBY8SWyOFqW9ZkZ9oF82uY+mKezLIq7TrUG19l7U6RM9nP8RDQJIYaxku1XboOAfnrzA/AatC+Sc93dA8Q8hMUknrbWWTdAGEtMXW3Mj0KA02pzTccEgspjtbaw38QY3AdAoakZ4CDm4UVAJLE+xgUEJi9pB03bn6ZcJVrdlhXU9VNcCxXZKkjRY/3epX4aEbmjHi60bImvcLJre34WsXhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbNGVoXbVXeNeNANW3JmKPTKxrclRmZuNex7liYjmoY=;
 b=nl0Yy0Qmmoxh+9MuxDAGScPA2LMmHT9md643p9gb6bziiTtBQ0BfJvu0q+IsOhFgMYHE2AWncj3QPJlDEOgMY4PYn1NgRQnQlNpzFR5zFxNHVlr0D/8QRpxWMS0WMyvj9L3OYbq1wO8Q0lfeGavp9Tl4a4h5FR7PnGkykqpEYqQq+YzbIU2IElTP7P4RpBFC6UXRdAj3+VDyCdxkZTsv3LEr5LkI+KqNPengLg+xl2/+4juLhbVibF/sBZwSL4jAyrB4/lvKQ5dMO7JIqEZvL0tDomBhe3g/1ZYN5r6Rp+YnTpcF8a28FGu8yVqze+GHw4IqqOLfcOru3OqgOGiLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbNGVoXbVXeNeNANW3JmKPTKxrclRmZuNex7liYjmoY=;
 b=z19EBLheX98pQV3aoXTrVRqNk7kbFTE+06cZKb1iV03NDgtwlTcoYxaUOmuZHT5V601UAweHtoH6rMes8u0yOkEwQk4TR6P04eQwvrgkD4rHCJa3P52JjDa9DTfeoSzGfYa2VlaowuV5OcFpiGqz/GPPI0mXooZuaViI8d2gYcE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR10MB1395.namprd10.prod.outlook.com (2603:10b6:404:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Fri, 1 Apr
 2022 20:36:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%6]) with mapi id 15.20.5123.026; Fri, 1 Apr 2022
 20:36:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: [PATCH RFC] SUNRPC: Cache timeout injection
Thread-Topic: [PATCH RFC] SUNRPC: Cache timeout injection
Thread-Index: AQHYRT9d30kfVhsJXk6J1Bbr6Dbau6zbhecA
Date:   Fri, 1 Apr 2022 20:36:44 +0000
Message-ID: <678A5594-5482-4D62-B887-6711191B530E@oracle.com>
References: <164875901265.5020.8768104920180114958.stgit@manet.1015granger.net>
In-Reply-To: <164875901265.5020.8768104920180114958.stgit@manet.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca254a3e-d335-4e2d-a040-08da141f5647
x-ms-traffictypediagnostic: BN6PR10MB1395:EE_
x-microsoft-antispam-prvs: <BN6PR10MB1395D3EE6F68B510BF46D15193E09@BN6PR10MB1395.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MGl9UfoLSJISgNwvZ3C7Hsz2gj44V/bgeGrMX57vO3ghUNcZ2X9Wd5IJpKN4xQEB5ElA8omZb2TjumhqXIY/yscGWWybi/xPFMeysezH/0gb+qabCQndjE3E0niBL0jSYey17SOMyNCYqXLwT1ToDZJb3nnFte1pXeqQEUvTgjAUbs6pDSM9pM5sBA5RGJpPduNcoATt/fapjKodCvtEakbd999Svn38vT0bvTT5UQb17lfsGJgCau/RoQ5pySf87XGn2yhUmEqwkWBm0GVMzerxViqpJHxX7xeC3yiyPsG5VBfdv59/ZA30G1fNQVW4GamaOOnKjqWQsIuXvFpR61LqBmTb9SzaXNrTeVm1H8bOlzidR2iu/Ibbhpup2A9c6AphHxQkSkexg8jK9xTOGkfiJUmjqoA7GQj4gpoiuTBqlUBk1A/pFSSaIcDBfnWjbpqNIn5X+SV7LFKO0aIEa9Tnnl0EcL/OEKTiJR5JXvzgkBcc10uQy48y4BdcWHAnSDvYjN/+OpMrq75xZlah/ACS6BzYo0mp/JniacjcFDs12lamBN+0zXtB4Njw2rjdoZZRvP+Odcoh/ub67cQ2tq9PMFtKQDuQ8hV5ZeybhbLCw/UxufLmxMLz9ixSL0WkeL4SM2lqiAogvEw4kTucdxWIeABk/QgjkG8y9iVunYR7m6QO4PFwF388H94rfsDFfzWVMYLmO1BhbhR8lldKdl2V6VI4UlTgn3Q8H1IYquTMoO8J+yCYOCpLnhsZbr7B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(186003)(26005)(6512007)(6916009)(2616005)(86362001)(38070700005)(508600001)(83380400001)(36756003)(5660300002)(38100700002)(2906002)(64756008)(6486002)(8936002)(71200400001)(122000001)(33656002)(6506007)(66556008)(53546011)(66946007)(4326008)(91956017)(66476007)(8676002)(66446008)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9XzJRjOyejdZO25H5aV0Yf3suIMKw2IDliJ3s7qslvmVzImFIGgGiEcXlMcS?=
 =?us-ascii?Q?/Je/DuEtnP9diwj64GTm9GmZ89C0tvstTwi+fXitTkQSW7j83PNXuHinoAbK?=
 =?us-ascii?Q?nboNnRE7/p15TJUSblpvHadYFn3N+zRdaIs630Hj97EemWLXLg+iz052HXyK?=
 =?us-ascii?Q?TVjgMwf9ZRXXwTYhOZSIz/EWKG8+EM9UI1OlNKSCyQXzvx0edmYyp3tNLIMP?=
 =?us-ascii?Q?LlVNxb2xF8LrWPcQP8znbPX6yEYhfdWu3SsWa5usOKWeFwUxo+6G+3hv4F9l?=
 =?us-ascii?Q?pfpZdeuBOPd05nbhk1isWXSvcVzcSWbT8aBqjoiSX6sBMMTq/m+M0uSlT6lq?=
 =?us-ascii?Q?BmESV/vVWW4Om60ZwyrhJHwZfJ9KxAKge7hONY7qAW3wmAYO5hDOyIUC7jPB?=
 =?us-ascii?Q?KehT0AAnv+f1jogVUJFcUjUvLiKZcHK1TASIIO7L+9EWiXKZcJlYcjzhI2XF?=
 =?us-ascii?Q?HjbN1XLI93c8KLa6R70tzAeTvJ7PVUf3/SNAZloEUb1EZyfQfsRsvoG7IxoU?=
 =?us-ascii?Q?xZESe43td3HIBl0mI2/ey/WC2ybcj8ikj/PriTc7YpYYJtR7PtpQURiYIyEO?=
 =?us-ascii?Q?N5b4muj7zrRioWQZY7LiS/4IitH2lznuX8upTUq7x1tguLqZKMRF8xWmMxOQ?=
 =?us-ascii?Q?PSa4COj04KtdTTKPajR4/4pZqtGRH07OB4zN5OXe7k8/qPs0d9ugIM4FwgAl?=
 =?us-ascii?Q?xCGE37eFqRP192nB8juJFF9iG1AiNd403JX+bvuB9XaxZFemrsCwr4hLBunB?=
 =?us-ascii?Q?5oNGf0qMwJsOGcj7WjXuUFEmIqMO1fKhY5GrNqEaX4Vv+sjAQmOAU3xYZsK2?=
 =?us-ascii?Q?fgjjwT1n+Wrknp/L8Gq+QSJZlOhMmvfOVWqENCUkkfxPFUiQrplc15QN57iA?=
 =?us-ascii?Q?SkW3pkRxbJ7Abg+paD4QOrpJo7t0GYjwIntUEhPMnTyC8ShtMIhONpVTj+uo?=
 =?us-ascii?Q?ZUJqHED9EmD0RXsRm2gommSF26UBf63uF4dh8Dgty9fJirQItmXJQHO212Lq?=
 =?us-ascii?Q?AbBPrjFwQuuHAIGUGzyEp2I9oDR+Xz+h3E6IeL6MiaXOvLaBDEJlbyRaEjWe?=
 =?us-ascii?Q?fQUtSUIVRldCNbpV4crNNwALdDjzYXDdXuRMVA6+QkjzNkPsIs+S+qHSTYmu?=
 =?us-ascii?Q?rgkomcRLvi02n6bZECd37lV0WY8AJvmVlVRbCOjbft4WOKaUeoC3awT3nCix?=
 =?us-ascii?Q?AwfBFVhEKHACdh1X+B5nvJMbWYdbKapNLJbh/4pxpyby+AaE32+7cIpUeBop?=
 =?us-ascii?Q?6JjPqwtdf/cN5iwITkwBAtIF1Our1w/doUFQJ+yd0IPuZvkbar6u0lNrQfUl?=
 =?us-ascii?Q?hQmH5VRQZxn4waFwrXqFvIdxRFbbcfJEmp4W6m/TSXxvxg1xY1YQxpSdkhlH?=
 =?us-ascii?Q?bAOkg80umdl9CQVSGbRj4oMYRIePwvIHjR7ON6wOZnH+jvBZOxuwnex1ARI5?=
 =?us-ascii?Q?pF+Vtc4r+WxENw1mJKL6tBmC3O9pmNjXoB8JRzdfj7T4cBcz3OS6WE4zmgvB?=
 =?us-ascii?Q?92g3wf4VdxB0AEHKDQXDClvvHHrJM9H7SfbPHHd99BdRTC+UZzdLTuhxukzA?=
 =?us-ascii?Q?0HZRWE/Xb+oUJ859IQzvPt9Y2BpDext90P3hgKU8tIXEfjR0R0G40duZyKfx?=
 =?us-ascii?Q?JWRKbB4T81OP871rokK8nn7N9SF+e09MzF7frTOdjpLQyuDBW+bW8CnF9I2V?=
 =?us-ascii?Q?+MbQGotB+NnDvJaCYD7cYaSHjYVWQmbsRjJNNlH0wH8UsgPyq2mlVlNPmnpc?=
 =?us-ascii?Q?7gO5UFEL4hr65fWNW59k/0oKhbutVwU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6889B18A7A77FE4C99EFEAE73B7CF971@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca254a3e-d335-4e2d-a040-08da141f5647
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 20:36:44.9173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DtxxixsARe2UcwWqOlgfopsiKR91Grcgr0f8vwtc4CpEjkVSyDUyYRg/xHSlM2Gmx6DBTgVQozG03figBEVs+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1395
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_05:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010098
X-Proofpoint-GUID: CwAXFYlFrteEFEw5zXmhBb0y7pscimFN
X-Proofpoint-ORIG-GUID: CwAXFYlFrteEFEw5zXmhBb0y7pscimFN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Mar 31, 2022, at 4:38 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
> Cache timeout injection stress-tests the cache timeout logic as well
> as upper layer protocol deferred request handlers.
>=20
> A file called /sys/kernel/debug/fail_sunrpc/ignore-cache-timeout
> enables administrators to turn off cache timeout injection while
> allowing other types of sunrpc errors to be injected. The default
> setting is that cache timeout injection is enabled (ignore=3Dfalse).
>=20
> To enable cache timeout injection, CONFIG_FAULT_INJECTION,
> CONFIG_FAULT_INJECTION_DEBUG_FS, and CONFIG_SUNRPC_DEBUG must all be
> set to "Y".
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> net/sunrpc/cache.c   |   16 ++++++++++++++++
> net/sunrpc/debugfs.c |    3 +++
> net/sunrpc/fail.h    |    2 +-
> 3 files changed, 20 insertions(+), 1 deletion(-)
>=20
>=20
> Proof of concept: compile-tested only. The idea is to inject timeout
> failures in the cache code so we can see what happens when a rqst
> actually has to be deferred.

Using v2 of this RFC patch, I am able to reproduce Trond's
crash exactly on the same nfsd thread that's handling a
deferred request.

I'll work on addressing it.


> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index bb1177395b99..e5ec125afec9 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -33,7 +33,9 @@
> #include <linux/sunrpc/stats.h>
> #include <linux/sunrpc/rpc_pipe_fs.h>
> #include <trace/events/sunrpc.h>
> +
> #include "netns.h"
> +#include "fail.h"
>=20
> #define	 RPCDBG_FACILITY RPCDBG_CACHE
>=20
> @@ -629,6 +631,19 @@ static void cache_restart_thread(struct cache_deferr=
ed_req *dreq, int too_many)
> 	complete(&dr->completion);
> }
>=20
> +#if IS_ENABLED(CONFIG_FAIL_SUNRPC)
> +static inline bool cache_timeout_should_fail(void)
> +{
> +	return !fail_sunrpc.ignore_cache_timeout &&
> +		should_fail(&fail_sunrpc.attr, 1);
> +}
> +#else
> +static inline bool cache_timeout_should_fail(void)
> +{
> +	return false;
> +}
> +#endif
> +
> static void cache_wait_req(struct cache_req *req, struct cache_head *item=
)
> {
> 	struct thread_deferred_req sleeper;
> @@ -640,6 +655,7 @@ static void cache_wait_req(struct cache_req *req, str=
uct cache_head *item)
> 	setup_deferral(dreq, item, 0);
>=20
> 	if (!test_bit(CACHE_PENDING, &item->flags) ||
> +	    cache_timeout_should_fail() ||
> 	    wait_for_completion_interruptible_timeout(
> 		    &sleeper.completion, req->thread_wait) <=3D 0) {
> 		/* The completion wasn't completed, so we need
> diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
> index 7dc9cc929bfd..68272885873a 100644
> --- a/net/sunrpc/debugfs.c
> +++ b/net/sunrpc/debugfs.c
> @@ -262,6 +262,9 @@ static void fail_sunrpc_init(void)
>=20
> 	debugfs_create_bool("ignore-server-disconnect", S_IFREG | 0600, dir,
> 			    &fail_sunrpc.ignore_server_disconnect);
> +
> +	debugfs_create_bool("ignore-cache-timeout", S_IFREG | 0600, dir,
> +			    &fail_sunrpc.ignore_cache_timeout);
> }
> #else
> static void fail_sunrpc_init(void)
> diff --git a/net/sunrpc/fail.h b/net/sunrpc/fail.h
> index 69dc30cc44b8..13b8436b5f15 100644
> --- a/net/sunrpc/fail.h
> +++ b/net/sunrpc/fail.h
> @@ -14,8 +14,8 @@ struct fail_sunrpc_attr {
> 	struct fault_attr	attr;
>=20
> 	bool			ignore_client_disconnect;
> -
> 	bool			ignore_server_disconnect;
> +	bool			ignore_cache_timeout;
> };
>=20
> extern struct fail_sunrpc_attr fail_sunrpc;
>=20
>=20

--
Chuck Lever



