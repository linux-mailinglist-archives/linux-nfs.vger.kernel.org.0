Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A385A2698
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Aug 2022 13:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344172AbiHZLIo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Aug 2022 07:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343971AbiHZLIm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Aug 2022 07:08:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE036BCED;
        Fri, 26 Aug 2022 04:08:41 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QAwcwf000883;
        Fri, 26 Aug 2022 11:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=aBRr0eAgNy2R+SQZFcEpRSpsMbAQ4ZuauCJ8tHi3y9o=;
 b=JBopIzvEMcIv0La1pbthpJkruG8N2XM6YlKYv4hWAscbk7Qec8l3LCI13z0rh4VLqDY0
 ZAbbSJYDzvcWlxYFsf6+uTLSY5ESqvMfqt8WIToO46Kbt+9210BXVxgNH3G+9+BemTuT
 Q3YPFIGxFmJC/M1EG7alvzlAwAtVk9vGdvk7QsuLqj6FZx/YBAIVJK1f2S4yrvskK7zK
 VB6G2fASfoB8Tv7ou6nlD+fzDlYPIp6ch7WPpKFq8hdoyxaLSs4s79E6pDMes+pZc37I
 BXgBnZTitxgLRLi/Wd39IbxTtw0MW7huTeiEthJTFd3ou8h/azxsqwd1lBznVFVs38M+ hw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w241bww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 11:08:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q8OmVp012072;
        Fri, 26 Aug 2022 11:08:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6qnqqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 11:08:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGxhBFP79eEr8pshPkoCWMw7dos2KoYU9JlqKV6PFXpga+xEBgPovmB/WWK++EuB1W7vL2GtZrHWCxkwV8HR2FPl62DJik8q6ObIbr8G+SBHtPTVhidbdrMxCGOisWRKzJzf9N1cbneXfbmgifZscYMZEtE90UJ47fDZ0cW/DL4aLYhIEIU7+E7Z2/MKbH+u0ji5mifTCaJq159OG8JWi3KCVjEqbvkq3COM31Fvk07EkvPAfQqLc7+bQ5QP7njouGpLirzr6QR6B3mO1Gb9OYMyS4Gdl2BxgKTcAO5j3al85vCZXaNa2j1d+mAnuhvINSVHre4imFCU5zcvOjGOMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBRr0eAgNy2R+SQZFcEpRSpsMbAQ4ZuauCJ8tHi3y9o=;
 b=FuGU7/bK5c5waJfDOCAWPLeYBjXJSeP6FsEG2PStz5eH6H0l90r5GmW8tFxSsNFcyyI5PTznEx5FWh6+Et/JFIESSrMf/U2geS58yvu7RISHTcjPJcL20pDqaWVPohGrsxMQB3KwEc6Xd11wSO7fiOEMK/+invoitSpNu4LWrHKi0bLTplUaqTWHMzPuvBz953GM9ElneCDEM/8o35JKb0MBA3+Ked47MPSzQESQRJXZwAyBVZFTBw9j+pLand7DS5rtOX2AbS8VuSzpxygTgWHsitqj8OYvrixL0GMx96KqPIBWoXGj+NpFxcdplLffAeoSyZzogEdiVGMsfi1Ghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBRr0eAgNy2R+SQZFcEpRSpsMbAQ4ZuauCJ8tHi3y9o=;
 b=QU1rVHeaYHuCOuj5yONlhulxCj1T+XNtyA1fGvZldrYmzQl9gy45JEqPo0KRlWbIURCAfkW4rRsC+4bXW0+XWhC6w44zW6/DY2cpHpaWVYVmTPr5vTI4tf6Eq7BvhY5Ei4f3Y9EtdFR3ZrYLxAQa6hL+TtYmp9/jz6L8ZL/fvoQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5764.namprd10.prod.outlook.com
 (2603:10b6:303:190::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 11:08:29 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 11:08:29 +0000
Date:   Fri, 26 Aug 2022 14:08:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fix a memory leak in an error handling path
Message-ID: <20220826110808.GE2071@kadam>
References: <122a5729fdcd76e23641c7d1853de2a632f6a742.1661509473.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <122a5729fdcd76e23641c7d1853de2a632f6a742.1661509473.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0038.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::9)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 675b082e-a31c-4c35-4b9e-08da87534e19
X-MS-TrafficTypeDiagnostic: MW5PR10MB5764:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X5p6As82icKoh1WqNtkQHh+PXjEq94maWNiPU5F+U8IBEjeVdkFbvhL6NaHohER6MQQvlvaarXICOgu/XCiycVRQxh+t3uDDvtiwrCzq/95Y8dki3D5YiC+I2NrYwDUzqKGVqpVGy9nLZy/gmoBU5gtopb4x0HuRfClIa81eHrLfwlctZbdy8oY94dYUScBvhG090TfjWr6U+diJ941hYGjvW5Jky/vzSJkgjnq7uUI+bFbrGHMew3ubIwsyhyO5jktQhKecvVM9ECNmiZBGjBPPPU5JsIDeZ36YYueCQRWsGG26/7nRmCcGatwAyfmjIbFlQNXNISBHZDath3k7yKpBedTwSV6kE1rohyOjp9RgjzF8EdAQzXJN0hr8JY2r3VKnF8ak2Xff5skEbhhia886xAHEgBdUOMsBEl95sbq9DDlGW4eOKrMas+nt7EsF0uuD7ZEqToxHkpuhOhuY7pHmVSCap8tHWv+h8sqQYF9wSXNj/7MqAZDF0EcJtk4Hmeft4O4gif/gW0+rD4NxByWgpC5Ix1ez2o0AF0HkFrzlUqNqXhtzh/eZDdQ1iOpSxNZ1xu8NUA7aM5G/zs6+gbItLPNPn2+qhhy25SBCp8rkYIn7xgI7di8gay0WH+p0Gw0x7N2z4n/kqYnbeLK+O84r0re369U0jbKVYosxVzDMBstDHWY3qpnZ7NjwMG3BgFUkbQ2GC5X7SjptrEknCkP/y99pDC04uqCwrcYjaqqDuo9TyeqPE9hoSKBgeL9huxAB6Fk2C42kE3cuvHIQzV5NzhvrheU3C3GSJ9DCFIY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(136003)(39860400002)(346002)(396003)(83380400001)(33656002)(6486002)(41300700001)(52116002)(2906002)(478600001)(966005)(5660300002)(8936002)(4326008)(66556008)(66946007)(66476007)(9686003)(8676002)(44832011)(38350700002)(38100700002)(86362001)(6512007)(186003)(6666004)(1076003)(26005)(6506007)(33716001)(54906003)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bpNdnp5iOlq/HZDdhZYY+A1v8wD7zJBbDFi9hALD9nFRJUERSa7VuVyOh1oQ?=
 =?us-ascii?Q?kNIi6/EHeLHAvLmh9PS4Mpps4XXgSj/5eKaqbo9N3yEks0l4LDEr7StnJlDi?=
 =?us-ascii?Q?PK77cmQglu44qJ7xhXgDY2R2alLMDJWzu4mUpbhdVUrW2VS6Zlel/zjDm3Im?=
 =?us-ascii?Q?CuoUTfySyLlOcDGi8cMNbmimyDBQslRxkSvZ876Ee4+a03qo2IV08OqRjtTy?=
 =?us-ascii?Q?qMFyK7dfdVQrI5a3YibEI5Ll8kkfV8Xy5qeKoFktnHh9c52dnvp6StWicj4L?=
 =?us-ascii?Q?sP9ovSWMAwSjq+F3oHWVlwC6yktn90XqljmzxusttYbkJryBxLNqu5L11e+4?=
 =?us-ascii?Q?wIPFORvT9eyhbwQc8MIzwpJWxf7v98dDRJ8iH6v7Xe+IBnUC+cXSWqfFS0o4?=
 =?us-ascii?Q?p0EvXcOgg0MQwl+hfmt1w6jozOS5e6K9nDBlBZ66j+YQlOJXVrnAMM440wuw?=
 =?us-ascii?Q?amxJguTBQ+rFLER7shC+78XxVv+HRU6vmW3+yoYCZwAi0SxFe9KhKrr5twX2?=
 =?us-ascii?Q?PZPDh0dA+xGYJUzG5OHdLXD5peVKymzokQ+IG41995SGFvRwDtlztiad5RXu?=
 =?us-ascii?Q?1ctIl7VUZXzuAywniF68TNFouwjF0P7IP3Ri9iPpjBpq2STSOijZBzw9jflI?=
 =?us-ascii?Q?6Qg6WakTWth0qxZR295cLM5vA6xeWJW5571a70D59KLNFy0Z6c/4zMQ62y2l?=
 =?us-ascii?Q?ssIA1sBe7rnibSHXIgNFZia7h3q0+xECvRAHV6BieT/GBrxW/xde6b9HFZll?=
 =?us-ascii?Q?RdvMDKgPi2LsrELzoGcUvG/h2zJHV1S9UZYzPtGuRb3nENfftIjgssIQ0Eef?=
 =?us-ascii?Q?R6qc2OtOgNwCP8FkEgLyKXv3YiuafA6Mha6lq9egWxyjB5sxjmu2cTqTsWy4?=
 =?us-ascii?Q?bV1fk2JFrSSwAhQy9pC1qAslXzjzRUqh1JLlpnigfdVtm0o2zjZ01LnclJQF?=
 =?us-ascii?Q?Oyk7aXVEJwwCnNWlGBwEgCGd2RFs8LBHQ+4zYFSKNpTVGMMRmTtSOFPOiBUG?=
 =?us-ascii?Q?wBS9bBy+Ak8OdX3PzTD9ZZnI2CBijHyQI8OKutVn8mx7Nc2Zurt0xsRWaPLY?=
 =?us-ascii?Q?baL9c0ps/A1noquhUBB5mraxtWNYza1QIJTK6iRJ0emHCkSbkS5yl3xcbvfQ?=
 =?us-ascii?Q?Eupdis/jMKBkuXJ8BpXxgtjkrp0gPm6I1yG4qXHrbkLEM/ftBrDiuiUYJja2?=
 =?us-ascii?Q?ybtliFPXgktO/xXA8h4Ll8DxscVUnDz83YBJkj6IYZnp9NbGCG2QWK3Hd/6y?=
 =?us-ascii?Q?fBjIBVL5yRJ4xgHTYSHkX8awYmhK6jgsSftYESOcRjHHMdulyS68O3EqSH2K?=
 =?us-ascii?Q?tHkVGP0erzrfXagQ6l4HJjydPySMkBtQAPZ3wFMLEgmrtatyM/4hFm6LfvA7?=
 =?us-ascii?Q?VWNy3+8Ygt7q66YlNkuXLhYRGl55YMN2c8TJNarBvHR436uk/O+NLzh8Tqxo?=
 =?us-ascii?Q?vgeD3ZF3MbYS9rR1saCyuNJCcilTB20dv75AJ8BgStRHtHGxduGPcYII+X6j?=
 =?us-ascii?Q?35Es8dI8+HuvgrwtfKb+LpHuTAW2UXTB27KxxLvO4ntF1cnTh6EN2p3Q+Yyj?=
 =?us-ascii?Q?QwRznVa3EBj2r9kf9t2IBArmXCRCXi3R3v0mau9nLHozlAH9nio4B2ZMDzrB?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675b082e-a31c-4c35-4b9e-08da87534e19
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 11:08:29.1474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /RLaYWc7jI2qCDyd7uK7Z/dedQTKIYHf5YhsmhxQp0G0GHryx6flhiuPSTPZUP1ZfWjv6pkfzn2IqdQ0DqWJg2lgeOGga+MP+Mixmq5S4kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_04,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260046
X-Proofpoint-ORIG-GUID: P2gbWQPwDn_TBaOFyQvwlGWYnRUsMH48
X-Proofpoint-GUID: P2gbWQPwDn_TBaOFyQvwlGWYnRUsMH48
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 26, 2022 at 12:24:54PM +0200, Christophe JAILLET wrote:
> If this memdup_user() call fails, the memory allocated in a previous call
> a few lines above should be freed. Otherwise it leaks.
> 
> Fixes: 6ee95d1c8991 ("nfsd: add support for upcall version 2")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Speculative, untested.
> ---
>  fs/nfsd/nfs4recover.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index b29d27eaa8a6..248ff9f4141c 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -815,8 +815,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
>  				princhash.data = memdup_user(
>  						&ci->cc_princhash.cp_data,
>  						princhashlen);
> -				if (IS_ERR_OR_NULL(princhash.data))
> +				if (IS_ERR_OR_NULL(princhash.data)) {
> +					kfree(name.data);
>  					return -EFAULT;

This comment is not directed at you and is not related to your patch.
But memdup_user() never returns NULL, only error pointers.  I wrote a
fifteen page blog entry about NULL vs error pointers the other week.
https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/
This should propagate the error code from memdup_user() instead of
-EFAULT.

regards,
dan carpenter

