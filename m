Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E0C77D07F
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Aug 2023 19:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbjHORAL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Aug 2023 13:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbjHOQ7z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Aug 2023 12:59:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40A61990
        for <linux-nfs@vger.kernel.org>; Tue, 15 Aug 2023 09:59:52 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FGioaJ001001;
        Tue, 15 Aug 2023 16:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=00bEahF8F0+p1j11uRiy2yKZtPk4naThFS/PDGiedEw=;
 b=JSj2fPC58dKqrlwugf0gCBxoiRlvv3ty9hv2L/QDswbXao9ikqUswv0ow6v7YSB3zmM1
 WIeTByBX+zrPPREfx28jhz2Ztr6r8aBZsc6DhFybPmfzIK/SMGq3GYLvmGnyIOaQCVGf
 qGJaM7MLNuLW18M2XLH3y4bDxl+4fEhVF0VypVW9SmU+D543JDJ6HGJfn9cOFj4vpjtL
 z+zCCv+mP5k/2H7ej6dFgBSD1op7dhFe7MMZiocq+zCDREPy85b3uF5E2VUnOUhNARaU
 uVVMHe480X9m6yyLN+UR0wjkSnaTq13DoUiU8gnonNEoC91JtXoIMT4Ihhj+o4BLVBQi qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se30sw7u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 16:59:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37FFuwu2019874;
        Tue, 15 Aug 2023 16:59:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3vjr2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 16:59:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cehWqy2CCMWT3C08ADbQqI3i4yIpL3vr28T/VaY1U5ic/p5vJyZydEN4QfxI1l4wBcnMqMMO/G48KtsnrUZOAXeIeDZqHc4TgKYe15n9AOt+gMJr/KyQkLyWUDW9hdklp+orhXY/ncnw1A5DXCTKb2PMZpwBdXpeDSrVLN135Mo2TIFNvgrNvg8rruSlsMF/od55ravKVMxJEor+rUCY3n5zLTvqrMYh9P+zmKyOcrBLcf5laXme/4+R/ynYGZk/OSvNIavZflzoDo1U5DJplGrScZTNOTaaW/i9+waHOeFqIyBG+x3dO4EDehUq55wUFRWSyMvAeNbUj8kQ5sNNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00bEahF8F0+p1j11uRiy2yKZtPk4naThFS/PDGiedEw=;
 b=avVoFoQ2zKrIYRgx/1c7+R4THGLteErR5u/nog0Zvuhm9m1eQaC7B9ClR2AjMcrYpsC+HsjI7oeLPa+rQhCRYzBnObLlWEmLUeyJ2T7LRDZKuPyyIxkGCiyKoBIe7TuopU1G/cUwfsS++t+ZN1wCFqkBPsV+mniTOK2cOhI4L+Pp4WV7eqqXeBQGPaHuNENA6/nn2cspYeE0XgIVs5Gslhp3qeVdzymc8HYHj3Tvj7b0YL7zkI9VkzIPJ9ictMkU4iTuE/6EWpg6plnODs1E4z2lZyymzDreJFlRBgmIeEt4vOmOSXQSDkfZSOyD6UkSYTp8m6yH/Vs1mzdAsOAqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00bEahF8F0+p1j11uRiy2yKZtPk4naThFS/PDGiedEw=;
 b=Tgtbl7IB0x4mrOB3ZM4ETkG/LmhluvyBat0fBDVN2gaJNoIPStPTUiwMHZRTR9GxgDJhvfPoEzeGplPfA+JL3DLmuEuONIdqxcilGBhTh+oFl1VN/tKQLhUy4uMQWkXJ5stiNPzecNQTAwVaMy/4g80li3zBK1VqfsniBbBbsTE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4369.namprd10.prod.outlook.com (2603:10b6:a03:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 16:59:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 16:59:24 +0000
Date:   Tue, 15 Aug 2023 12:59:21 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 04/10] SUNRPC: change service idle list to be an llist
Message-ID: <ZNuu6VaU8XzYuEQj@tissot.1015granger.net>
References: <20230815015426.5091-1-neilb@suse.de>
 <20230815015426.5091-5-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815015426.5091-5-neilb@suse.de>
X-ClientProxiedBy: CH2PR14CA0017.namprd14.prod.outlook.com
 (2603:10b6:610:60::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 45fb88d3-66d5-4b76-957a-08db9db0fa84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zdyfwKwoVHhbhsNMJ/zhbGtO/vrkKd2XcBOpdesbCAJTLFwMimJIanRo7epHE8GJPyQs19tR13sOg3CftfFE31stG8dxDFLbXY68SMLTsuc6Aht1mg9sV8zDOeVzvc9Cm936wFKXYFyBCd4T7jVrXA6t7ZQcZBHcjgwau4C/ZM4nZHE4BIHMETftghOnHoTarHuaAV18pfDnISFpOEmjV9ahwIRnG6d0jGFcAbYPMhZKCLEsQt8BQB975fukvYLwgHFoym4U6SRu9/mXOfY8bdCLnGDm5kdWZaL6e4MvXir8zfiRX9kZ7viL1bbj53+gywSF9GbGtFBsMhLtR203Khb2JC3dIc8CBkeWz79952UUcnRyXIE/PoD7efstvdtwBPZQpjtSRV84ACx2BlKFnYNLQxDQ/739WETrNnOIyTZi/3LqzpE6boAAnIlfkaTT3otiq2VbGhLSVKFUVhW9zcZOXAI8xrE+4FcwvTMgATV7wrdd00l77KQsd3SAqaGrfCD3nmm7uKPGKbuGUcvTVnA95bVvD6ZUBl3CREsR/SQorMDpT0RXV2TGfL9LnLvn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(1800799009)(186009)(451199024)(41300700001)(8936002)(6666004)(38100700002)(45080400002)(5660300002)(2906002)(86362001)(66476007)(66556008)(66946007)(316002)(6916009)(4326008)(9686003)(6512007)(44832011)(478600001)(8676002)(83380400001)(6486002)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3q8JDJSs7Z5XISj2x+oEoy1ThrKI/wSRTXQvUaIwryZsfsSJL/kRaH03jhwL?=
 =?us-ascii?Q?d4wr/TrcPKj7Gi/qwXrIrG99akljPd1GTtniiT0KXYKXbc57cc88Yr8LD8Ap?=
 =?us-ascii?Q?vEbWsrs3Dl9Chnuftc5qYi8Rj/SeYbiRrE7LjxPlOL4zIUj/UlXBoZHIS0AE?=
 =?us-ascii?Q?J4BUHqGSbWlbCj22lOOrzE3lznpdQ6kbH/3fYpfa1RXfT6DH3RFe3KTfNlNU?=
 =?us-ascii?Q?KlKd2bF4iUuASQj4LUONIMDs7kcSjlf6ZQHxWuiqZrpsckU4jH61opwzdewn?=
 =?us-ascii?Q?q3X1PsEUgU1iNo/S9exgCd3PtFl8UBq0eGqL3XbJwSCM0Yi+vcwq1RZ9WobG?=
 =?us-ascii?Q?wzNvXXa6/x0CMaSGDC+aqvMzFispOHX+2F0kwVYrFP7BIW8bpZ/Ynpsb01nw?=
 =?us-ascii?Q?AZ9hUtTNO0cnKOFgtx5BNUEArbQ0v5WHTmLUwMVi7pZg7UiSHUC66194oIBt?=
 =?us-ascii?Q?/Y5QXQ+jxSv0n6bMfpTp8pn/PdQ94J5t7KEgIOgF+NFCFmVHDxlSircz6UxF?=
 =?us-ascii?Q?yTAycvaEwsP7SZ8/KRxFqtUOddXd56RZAJNYnk6F75NQLaoRcxbovmHMuNDf?=
 =?us-ascii?Q?PukdpdifICw1iAUqVNBp3kiA2LC73pzqt4TgdmcCw3rgqOwZ0pulvODm+C7a?=
 =?us-ascii?Q?e1JjnPq7Pc7k/lMUzbJL0oFZBvFw+tDezy7EnvmKuCwmZsRtAd6VPS69HX86?=
 =?us-ascii?Q?DAippNgIB/L2kFfBEJ1tFkHD/J4XDyWZjPYLvANj3PDb9ux3xdWji6Ssk+KY?=
 =?us-ascii?Q?1Ze/dxSjsUmJ42XekwcxE6zeV2U67wh4RTTaww7w9Ixh+wg5NrhXVhR4Mw+n?=
 =?us-ascii?Q?JF2IhZozYR7zNw5JpRO3xYgtzygj32IwTehSNsPddM+sFIrwBTusclDFfFLy?=
 =?us-ascii?Q?3uh6AHvZ39iAH4PLJjSL9SRcQfmcY+mH9c0Ck0whopYiM6D6aEE4zq1IpoCb?=
 =?us-ascii?Q?td8UlNl/y+A8puYaHdSMdy8Eo7/ANlZximoMoxL+A3Kj3Wj9Fs4/5zRhiyOG?=
 =?us-ascii?Q?P6pWHtE1tY7iyRNibsAPJ2huTmzSlTjIDhM9efwFR2xhXW9KcpdRXoLgdZs1?=
 =?us-ascii?Q?sJ7qrruIDECz5wznsHDygQ9LIv1sHxrlDqPU1LAO+n2nYWh9qi4l3MCqblrT?=
 =?us-ascii?Q?0nNeORrq8pAzluHn3w4raQkf376zudYelJ/ehPpfmHdEHW2VGAjthF8SsKFF?=
 =?us-ascii?Q?tXDwlSGYJHygldmW6FbL26gd5+64zohHDVoMRVZH9Oyq3+fSWAG4L4Y2Utmm?=
 =?us-ascii?Q?hIzaEGZJcSEboOldk8t70N2FGGHpunQu34AsWMNIbgz/zvw7c/VfbBUvd0o3?=
 =?us-ascii?Q?NFIpGdrsy1Pzw6RjLxLjzjbBNxu0HXE0R+cIHsNBESRU8WQjumHUyPhC2YvS?=
 =?us-ascii?Q?SPNOTBi33+Zvz+vulv7gsjsm8H2UWBHp02Wz0+RuCIPLVc5FsURkSPJpUTC3?=
 =?us-ascii?Q?dLxD9LzYI2MC1ZjacDF92iV6GZJ0rhATTuL9RTbrXA+3WPjzr2toWlzD1ieR?=
 =?us-ascii?Q?GCkABENhT3+gPJhT4dJAEm6ofgtGC4H2sRjQ+fNGRg1TvZhPffQwStQVf9Nu?=
 =?us-ascii?Q?IEoCFfaR0QN4l4HT0PcVZZwqb3YuHlxGohp6byk+96y2+XB7PWnat7HuLoR9?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kSC2MYg0p8CgVUEekjP1B6YrFyTHa0BzZp5akIHktAfc9kUusjalWnlEuSAH2ly3tETpFgphkMsacrloECOdMOOFR4aH4LrauMaujrokKymFNLE41iyErB0tGuecpe5QZuxEYcveALoTHZngALkfhWxFytVi/HgKnNVNA79l3cLZyuM3gE/Msusa732w1LI6cxv25bF7AaJdmP6HTUJzBgY573ma/FYrAi5vS96LGku+xj3EEZTLURH1w5SG5zhMptR1EmafB2MFKt5G98s3sMXVu8BY6PJ+6MtWfunKLfNXuvQ8Bp5TQXm03zSwF1/I9DLD+NgmbrEQBwF93ouhX3U/gOYJ14BexSisFL5zF1xm5DJcA0epleczfdB76uW3lRESM3MH/8EL5fe4H/+AJ7h22qwcBvlv9iVO4MkznsKkL1K5MdGXYHfgaxiZyRqkS+1c+PllKDyfiGTVXB4U6onl+dpq43HN5x+vxaB1pqtq4ZgQ+82lOifb+/J81XvQKi6zmPA1iAZZREBOEodpYP60prGU/fzUQnjQJ6Bb9l0+c/n40WhUr0ShCUDWXLrBumSHZMzP4W6lCMZFkBfpysyYGHHXgqXgGD57dymVkTl/GUI78EwcciE9Xc7AE7oH9i8daO85l0WofE2RgOYswzPeuR86hqjs+bpR7IjNjAzn4u9UnvB6yDUVRzTitea1XMdqRxI3HFCKPgStpXTkh71uk2MjFu5Szjkt6Oqg+n4V83xu32OHw6q+EDdYcNNOr6yrc88lwr2E/vDwOkupiykrWQBvcvWBLIsdgsX8CS9xcch2vhg1CfNPVd1vmQ8T
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45fb88d3-66d5-4b76-957a-08db9db0fa84
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 16:59:24.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifBOCw2ppb8zPIxt47GdREQ8HK6P1WJOB/vt1gfvdcm7KflnUEn1enwGKTIS+98XNOJsuvoHUG73ikK8bu4A3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_16,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=862
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150152
X-Proofpoint-GUID: w5OL1ea3fPPu-WxSc7BJsfO1PZH6jsAv
X-Proofpoint-ORIG-GUID: w5OL1ea3fPPu-WxSc7BJsfO1PZH6jsAv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 15, 2023 at 11:54:20AM +1000, NeilBrown wrote:
> With an llist we don't need to take a lock to add a thread to the list,
> though we still need a lock to remove it.  That will go in the next
> patch.
> 
> Unlike double-linked lists, a thread cannot reliably remove itself from
> the list.  Only the first thread can be removed, and that can change
> asynchronously.  So some care is needed.
> 
> We already check if there is pending work to do, so we are unlikely to
> add ourselves to the idle list and then want to remove ourselves again.
> 
> If we DO find something needs to be done after adding ourselves to the
> list, we simply wake up the first thread on the list.  If that was us,
> we successfully removed ourselves and can continue.  If it was some
> other thread, they will do the work that needs to be done.  We can
> safely sleep until woken.
> 
> We also remove the test on freezing() from rqst_should_sleep().  Instead
> we always try_to_freeze() before scheduling, which is needed as we now
> schedule() in a loop waiting to be removed from the idle queue.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  include/linux/sunrpc/svc.h | 14 ++++++-----
>  net/sunrpc/svc.c           | 13 +++++-----
>  net/sunrpc/svc_xprt.c      | 50 +++++++++++++++++++-------------------
>  3 files changed, 40 insertions(+), 37 deletions(-)
> 
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 22b3018ebf62..5216f95411e3 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -37,7 +37,7 @@ struct svc_pool {
>  	struct list_head	sp_sockets;	/* pending sockets */
>  	unsigned int		sp_nrthreads;	/* # of threads in pool */
>  	struct list_head	sp_all_threads;	/* all server threads */
> -	struct list_head	sp_idle_threads; /* idle server threads */
> +	struct llist_head	sp_idle_threads; /* idle server threads */
>  
>  	/* statistics on pool operation */
>  	struct percpu_counter	sp_messages_arrived;
> @@ -186,7 +186,7 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
>   */
>  struct svc_rqst {
>  	struct list_head	rq_all;		/* all threads list */
> -	struct list_head	rq_idle;	/* On the idle list */
> +	struct llist_node	rq_idle;	/* On the idle list */
>  	struct rcu_head		rq_rcu_head;	/* for RCU deferred kfree */
>  	struct svc_xprt *	rq_xprt;	/* transport ptr */
>  
> @@ -270,22 +270,24 @@ enum {
>   * svc_thread_set_busy - mark a thread as busy
>   * @rqstp: the thread which is now busy
>   *
> - * If rq_idle is "empty", the thread must be busy.
> + * By convention a thread is busy if rq_idle.next points to rq_idle.
> + * This ensures it is not on the idle list.
>   */
>  static inline void svc_thread_set_busy(struct svc_rqst *rqstp)
>  {
> -	INIT_LIST_HEAD(&rqstp->rq_idle);
> +	rqstp->rq_idle.next = &rqstp->rq_idle;
>  }
>  
>  /**
>   * svc_thread_busy - check if a thread as busy
>   * @rqstp: the thread which might be busy
>   *
> - * If rq_idle is "empty", the thread must be busy.
> + * By convention a thread is busy if rq_idle.next points to rq_idle.
> + * This ensures it is not on the idle list.
>   */
>  static inline bool svc_thread_busy(struct svc_rqst *rqstp)
>  {
> -	return list_empty(&rqstp->rq_idle);
> +	return rqstp->rq_idle.next == &rqstp->rq_idle;
>  }
>  
>  #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 051f08c48418..addbf28ea50a 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -510,7 +510,7 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
>  		pool->sp_id = i;
>  		INIT_LIST_HEAD(&pool->sp_sockets);
>  		INIT_LIST_HEAD(&pool->sp_all_threads);
> -		INIT_LIST_HEAD(&pool->sp_idle_threads);
> +		init_llist_head(&pool->sp_idle_threads);
>  		spin_lock_init(&pool->sp_lock);
>  
>  		percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
> @@ -701,15 +701,16 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
>  void svc_pool_wake_idle_thread(struct svc_pool *pool)
>  {
>  	struct svc_rqst	*rqstp;
> +	struct llist_node *ln;
>  
>  	rcu_read_lock();
>  	spin_lock_bh(&pool->sp_lock);
> -	rqstp = list_first_entry_or_null(&pool->sp_idle_threads,
> -					 struct svc_rqst, rq_idle);
> -	if (rqstp)
> -		list_del_init(&rqstp->rq_idle);
> +	ln = llist_del_first(&pool->sp_idle_threads);
>  	spin_unlock_bh(&pool->sp_lock);
> -	if (rqstp) {
> +	if (ln) {
> +		rqstp = llist_entry(ln, struct svc_rqst, rq_idle);
> +		svc_thread_set_busy(rqstp);
> +
>  		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
>  		wake_up_process(rqstp->rq_task);
>  		rcu_read_unlock();
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index fa0d854a5596..7cb71effda0b 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -715,10 +715,6 @@ rqst_should_sleep(struct svc_rqst *rqstp)
>  	if (svc_thread_should_stop(rqstp))
>  		return false;
>  
> -	/* are we freezing? */
> -	if (freezing(current))
> -		return false;
> -
>  #if defined(CONFIG_SUNRPC_BACKCHANNEL)
>  	if (svc_is_backchannel(rqstp)) {
>  		if (!list_empty(&rqstp->rq_server->sv_cb_list))
> @@ -735,29 +731,32 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
>  
>  	if (rqst_should_sleep(rqstp)) {
>  		set_current_state(TASK_IDLE);
> -		spin_lock_bh(&pool->sp_lock);
> -		list_add(&rqstp->rq_idle, &pool->sp_idle_threads);
> -		spin_unlock_bh(&pool->sp_lock);
> +		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
> +
> +		if (unlikely(!rqst_should_sleep(rqstp)))
> +			/* maybe there were no idle threads when some work
> +			 * became ready and so nothing was woken.  We've just
> +			 * become idle so someone can to the work - maybe us.
> +			 * But we cannot reliably remove ourselves from the
> +			 * idle list - we can only remove the first task which
> +			 * might be us, and might not.
> +			 * So remove and wake it, then schedule().  If it was
> +			 * us, we won't sleep.  If it is some other thread, they
> +			 * will do the work.
> +			 */
> +			svc_pool_wake_idle_thread(pool);
>  
> -		/* Need to check should_sleep() again after
> -		 * setting task state in case a wakeup happened
> -		 * between testing and setting.
> +		/* We mustn't continue while on the idle list, and we
> +		 * cannot remove outselves reliably.  The only "work"
> +		 * we can do while on the idle list is to freeze.
> +		 * So loop until someone removes us
>  		 */
> -		if (rqst_should_sleep(rqstp)) {
> +		while (!svc_thread_busy(rqstp)) {
> +			try_to_freeze();

For testing, I've applied up to this patch. When nfsd is started
I now get this splat:

do not call blocking ops when !TASK_RUNNING; state=402 set at [<000000001e3d6995>] svc_recv+0x40/0x252 [sunrpc]
WARNING: CPU: 3 PID: 1228 at kernel/sched/core.c:10112 __might_sleep+0x52/0x6a
Modules linked in: 8021q garp stp mrp llc rfkill rpcrdma rdma_ucm ib_srpt ib_isert iscsi_target_mod snd_hda_codec_realtek target_core_mod intel>
CPU: 3 PID: 1228 Comm: lockd Not tainted 6.5.0-rc6-00060-gd10a6b1ad2a1 #1
Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.0b 06/12/2017
RIP: 0010:__might_sleep+0x52/0x6a
Code: 00 00 74 28 80 3d 45 40 d5 01 00 75 1f 48 8b 90 f0 1a 00 00 48 c7 c7 b3 d6 49 9b c6 05 2e 40 d5 01 01 48 89 d1 e8 e6 a2 fc ff <0f> 0b 44 >
RSP: 0018:ffffb3e3836abe68 EFLAGS: 00010286
RAX: 000000000000006f RBX: ffffffffc0c20599 RCX: 0000000000000027
RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: 0000000000000001
RBP: ffffb3e3836abe78 R08: 0000000000000000 R09: ffffb3e380e70020
R10: 0000000000000000 R11: ffffa0ae94aa4c00 R12: 0000000000000035
R13: ffffa0ae94bfa040 R14: ffffa0ae9e85c010 R15: ffffa0ae94bfa040
FS:  0000000000000000(0000) GS:ffffa0bdbfd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f59c2611760 CR3: 000000069ec34006 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? show_regs+0x5d/0x64
 ? __might_sleep+0x52/0x6a
 ? __warn+0xab/0x132
 ? report_bug+0xd0/0x144
 ? __might_sleep+0x52/0x6a
 ? handle_bug+0x45/0x74
 ? exc_invalid_op+0x18/0x68
 ? asm_exc_invalid_op+0x1b/0x20
 ? __might_sleep+0x52/0x6a
 ? __might_sleep+0x52/0x6a
 try_to_freeze.isra.0+0x15/0x3d [sunrpc]
 svc_recv+0x97/0x252 [sunrpc]
 ? __pfx_lockd+0x10/0x10 [lockd]
 lockd+0x6b/0xda [lockd]
 kthread+0x10d/0x115
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2a/0x43
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>


>  			schedule();
> -		} else {
> -			__set_current_state(TASK_RUNNING);
> -			cond_resched();
> -		}
> -
> -		/* We *must* be removed from the list before we can continue.
> -		 * If we were woken, this is already done
> -		 */
> -		if (!svc_thread_busy(rqstp)) {
> -			spin_lock_bh(&pool->sp_lock);
> -			list_del_init(&rqstp->rq_idle);
> -			spin_unlock_bh(&pool->sp_lock);
> +			set_current_state(TASK_IDLE);
>  		}
> +		__set_current_state(TASK_RUNNING);
>  	} else {
>  		cond_resched();
>  	}
> @@ -870,9 +869,10 @@ void svc_recv(struct svc_rqst *rqstp)
>  		struct svc_xprt *xprt = rqstp->rq_xprt;
>  
>  		/* Normally we will wait up to 5 seconds for any required
> -		 * cache information to be provided.
> +		 * cache information to be provided.  When there are no
> +		 * idle threads, we reduce the wait time.
>  		 */
> -		if (!list_empty(&pool->sp_idle_threads))
> +		if (pool->sp_idle_threads.first)
>  			rqstp->rq_chandle.thread_wait = 5 * HZ;
>  		else
>  			rqstp->rq_chandle.thread_wait = 1 * HZ;
> -- 
> 2.40.1
> 

-- 
Chuck Lever
