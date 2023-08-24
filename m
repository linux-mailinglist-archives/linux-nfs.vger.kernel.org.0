Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3316678702E
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 15:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241123AbjHXNZC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 09:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbjHXNYa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 09:24:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5730619A1;
        Thu, 24 Aug 2023 06:24:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OAdkL1027194;
        Thu, 24 Aug 2023 13:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=Hn8i8LXQ0iofxVQ5Z9+E8rdWcE2sOXhdkcrzJyRIcgU=;
 b=1xv/tVS5nWqYT6WC8obtrwkfNLuAIf719mMV+gfmHB/TK42OSSi+CywUYw3djf+moFNx
 6ZO7ixlDcHXdNBlS9IVuAON7P3xymkXHYkweqDtdVfOkRbLyom4nJvAcU7potUpIcVJV
 Lcv7jGYAWVbfQKVNojR9sgFFp7MYnDHtxJkaFRBhPHzbsf/Ua2EzoeZXhnf4XTzw0IXh
 UlICbv1pJZ0Ho3DSDz3A5Tea7vc2jREOxNKhVO7+VAqHgRlaHmoM3JIUYW8QHr/cxwcV
 tEg6dX27tN1QTOp1NSrc3YlPKVL2Bm2jIkzc0LEFyOJdtWAJADziM0jHiCh7Pcq6FZBb hQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yxm2kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 13:24:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37OD8N2S005852;
        Thu, 24 Aug 2023 13:24:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yt74ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 13:24:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxytRDsjB5XUWCu0oJ1xuQbsWjjjOZRvHcn6tCRPCF3zIsRF4LYhV4vvmZ1skrivXgNugl1V4Solr1fh/rPRyoD74Tv+K090LDXDX+0vdOR+/nUwBztPiuLMj9vv4BnaUS0TFq2UzPyv2xF/H2OrsN2XqeW9IgoWE+komIV49knkuMrKK+h0SNzytRcCVQRKRQ4YV3HHQsSVh6m4lmpiP7/HVwtmh5QKme5uGkY1iDrld+wXE7huAaJjLliXAHZtd+V5DbzmOG/qjiUWu19f1WOetaY8XywECO/WOPtxGlKi8xdJvRTaQfRYd5/uU0JEFCTac1vLfcAKPMmIVz+5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/Vxjst9jV/SqMJLClzYPXlXO1ymJTPTaTFDwnTd35g=;
 b=WgvKf8NI86qPBuq5WZIxV0PzvfF4qmlOFUrNl30kgpMqWPtROlboVHkiwtzcrGW6YIPY7Z+nlCDlvn2aHFX22USNQn9UX2d5XPCIkJtiJwdcc+GVp7GMQrT+0plptjJasKJKTvcrlInMkZuxp5Av1yWjovVERfPF+QuOI3rfgl37hynuDxFmGxfrtnd6wScMeuKQ2d2yKS+TqemyZUuh+9vcy5NJNWZH4fa4Rbi3swftWvRBZ8DF7H621wZTBTEUJoYRCnlwCxqyIqR01ih/obPp+jj6tV8iEpxRjEq7vZxPCuKIYkNfElIPUyzSxA5HvjcGg1fswD1Iq5/7bJVdaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/Vxjst9jV/SqMJLClzYPXlXO1ymJTPTaTFDwnTd35g=;
 b=rjOhF/8UzXw7p20kC2WUjDSi26I+AnqqPh6kVhr2tU+Wqd1LS1ar7bOiUUzOfjNKHQinVA7Dqw1Yn+gw196ucV+RVZxVDHJUPrpcMNVIwmGyNWtNcOZxeOMHDeFAoXZh8pMYKfI6e0v08FlEFntSjxitcTk5xfm12/CcCuGydQ8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB6959.namprd10.prod.outlook.com (2603:10b6:510:28f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 13:24:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 13:24:00 +0000
Date:   Thu, 24 Aug 2023 09:23:56 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        linux-nfs@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [NFSD]  39d432fc76:  fsmark.files_per_sec -100.0%
 regression
Message-ID: <ZOdZ7DiQ4jqhoj0i@tissot.1015granger.net>
References: <202308241229.68396422-oliver.sang@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202308241229.68396422-oliver.sang@intel.com>
X-ClientProxiedBy: CH0PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:610:b2::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b6ae5d-81c1-4620-3d7a-08dba4a5608a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQn8wvKxIxiXMhgT40vNXhdRAioRh7CYGfEV9iJiS4+did089X4gn20gdoLHfHX9Rp23NHnZ9wHx5DZTa2zMld1idT6+RikfkiC6wdeBjI3Cd53V63ufuvc9FMpWxHIANcZyXoibM/WlAjMHh49cLqwwjurIE4O7lrGrXtxTiyauCG/TxqHBEtVwqK+8Vg+ZQ+OW1SbZalqcJ6Q/qAZiG8yTOV9avpeksCDS7HluOwxJ6rGa7y0A/5HXF1Zi+ooHN2LaQcff5ELl+HEGDJms/TrZmf8jko2xOxIOTovNeZGRK9wCyaMooicMFMvNn5wjoDxRd8Q860EePzq7AQhExUaopltRQCzAD4TLvjmNsxk8aqQh9B4quhNTW5LSa0aQEfgrWU6M3u+JaKz5yeTbovJk0s+22j8XZZ+h1rG1KbjM7wde4HAGXByxmI11F+6gkxmmU/nzkmm+TsDd3onX765zcNLXupYP/MlTIvsO+YFqLceRxKB4dTIA66oBk2ane/+Ls4nWq6eLChEeYrViPoO4N1/bp8tk2r1k0Cwq6thL9de8SkpO2x+6/4qQTpLFX4cKN7jPWsm+gcDadqC7Xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(186009)(1800799009)(451199024)(5660300002)(8676002)(8936002)(4326008)(30864003)(83380400001)(44832011)(26005)(38100700002)(19627235002)(6666004)(66556008)(66946007)(66476007)(6916009)(316002)(478600001)(966005)(41300700001)(2906002)(6512007)(9686003)(6506007)(86362001)(6486002)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NBQ6RgW7w48s0MLoG0gy0HuuQqGpgWHL2O4u6Npml/ILD01wNeQEWg259q?=
 =?iso-8859-1?Q?RAwmNMftAprA+P83vYewUFvNAeVYgrdCneRTsLzrOpxUgD6Hoh+2bQXVpE?=
 =?iso-8859-1?Q?P/0jlHILuNWVzDeyxklC1isqGDPUS8zPuw6g0M2JgOY6szUWbGlKaorVH5?=
 =?iso-8859-1?Q?NyUfIrHQPvfBwgSkymvzx9BYHmKmdwVnbUW88Mhg8kdci8PmRykNFfRCcw?=
 =?iso-8859-1?Q?i8DQTnPUFah31oagk9K1StcHHWL04HOJ9L4hei1TiyZuM3saj16ocTXr6l?=
 =?iso-8859-1?Q?x5CMYqWtzxp5L8zO+IAXdmK+4ElPr4k2DzEYjViPuucsg061kVtcPQy0d5?=
 =?iso-8859-1?Q?LxZiSbLExfTAtn/gDJ+wM9LGuMKjb3+1SZR/D9wSSgQmzLA4BZLgjWIbDF?=
 =?iso-8859-1?Q?YRUPNkgg0/WXUyK6e7YLActWnSoDKKpzwGcZjvJ9WjlskfLe4awDGbhbJr?=
 =?iso-8859-1?Q?K5Vw7bfvAq5gDGrT+EzkE+vEdu7/eUA8VnLb4qUzzw3AW1Rx/CTmYrshco?=
 =?iso-8859-1?Q?GeXFHst8X+7BFhwnEhk9SIFhNVIdNwWZ6Dj6Nqm3Wbg0cWeFrZEm88dJo7?=
 =?iso-8859-1?Q?hjV7LfPoboHNoJjswdiuu3z4CpgZvinxHNJwTgcqQHTn0Wpl62usCO/AFX?=
 =?iso-8859-1?Q?xdSxfReEQE4lnngNyqAshJ/tlbJomr6qEI2kALJ95oMY+xWVl6HD7y4p/S?=
 =?iso-8859-1?Q?X+SCONqOiRwHLDHZ6498W2thkyWhD1uCcKnQl0T2eVArGaIky+sfmMX9JB?=
 =?iso-8859-1?Q?3KHofIgus368uHIVxFuD/kx9OKchrdgm4ybyFQDEKSIHqPdRW19srN0DWy?=
 =?iso-8859-1?Q?ffeBTT0RWcLmi7cg6OiOVJ+5IzroIYQJiNldvRGbWLyKFjncXd6UxcBR9z?=
 =?iso-8859-1?Q?62/kfwD5Do+5nXWt6N/wGhNpju7UWCJFo5iW16zbOtmzszL1A2PsVT588t?=
 =?iso-8859-1?Q?B/BzU7Y9qiFAFU+Dv8BMEareNyD6DnP0dSvt3T6T5ZF5c7HfEyyYYLokm0?=
 =?iso-8859-1?Q?EfKqKUaPesRu583FxOg98Muu1udQ+J74z6y3qHcf1MzBkIDcEOfMXUKyyJ?=
 =?iso-8859-1?Q?O9OhzsQUUXumarQP50DDiz9ek3CRK+rhcR/RAKCFeBrdavwCaj5TAReTtR?=
 =?iso-8859-1?Q?wsM6nllGu18K/klnkYmIahOJFhJ9T6VzIf7zEyXfNnFGyWT0egchwX+5zH?=
 =?iso-8859-1?Q?rX9qCA60YGtbPhFB2bThidWkSZDzuInc0ejKXVOYoFZmoZWjNawhVIq4qj?=
 =?iso-8859-1?Q?8vHHrFtEXzgkfuio9OpqvctaUbMI7/UxlVOmn5EQPmQ9G8l+LnBAdKMI1E?=
 =?iso-8859-1?Q?GZzz/GQCGQ8YUWrAHGQpRflrCqzInXFQRiaZsOPRjKlHJsKHQ3pMUMvAw9?=
 =?iso-8859-1?Q?/ZfeoV4p/co4T86+tzYMLCJ6z6bO+J+/1d//lNkJx8wdDEvvjCDY0WANFW?=
 =?iso-8859-1?Q?nbZt0Wr9T877z3hUmUkCQEVTxQXYgg7fxkm1mFVbN0PYvNGt+M5XfgE3ul?=
 =?iso-8859-1?Q?VEL8bQ/4toiEHfjZze9KQfGi0pagmy5nu0PVVn95JN3TrdY8wny9uvUtBE?=
 =?iso-8859-1?Q?YVmJVzg3RkCsa3H/C6HCnLoICNBeZCqSyDQVqJJ2sFBDBy/VJ5AbysSPot?=
 =?iso-8859-1?Q?7R+5KI2aoRiEnwW3s+FVhjzZOS9JL0fBwuSKHF3nKwq6GAfx0TqOggcQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0kG2dIiXKctFWzMpxAgtmENbtQokWMd9CyQ2w9lgNwp7jc98V0jrTaTynNcx7p0jjqojU4QujrJL7z/le2ZpDok3Sevu0RuIyjAogl3cs7QyUcx3e0rySgDsPeAwr7CpbpXNt7u7NKzsb9f/qxD1A3x/vLh4wWGJRNGW2KLzM1QE0QHgCT3h3Q/uV5FdGCMSTrwqNz0TtXPhn8LjlAjhMPwzjPzigmldvkpMsPyKhX1+X58tPyZOkdhf5qN7bnv7oGei5k/zx1yWiBiaqAMXDxzUQr09T3sthu6hXvOGk0q633qPyXv+GeFfIlj8hftJFrAKt/tmRjIWx6jo8VDX+THzvWHGPJz2nplWZ6vlb3CwGzpbgBORANvOzb3oe0vBU5Ygw12KVRV0XHKEsgozgfTylnwdEz4x05mhC6Sr6yxNvlkD/udCre8F6U3DAh1RCdjtchvKgOrG7nr1hSq8QqNa+zl+axOrozkY3LbmOYhq3cYY86twwPufOvKwTYlcxpXMU/5lMr5DOn5TyjEamBW8c0mZL9LR7gya5mTShrJQsRq2e0SJVBVDeHhoVETt+Rv+Q4xJCvKivU/dkeNQYBZfxZjD7yt+0nFhhObe+5aMoVM9TJJ5HkMJTj2Nx9YLHLnU5tP7SiaVcv13y3KPP02HCeGpJRfdp96ESs9lTceca3e5xFiiy43Qc2lFmexH1K6Klq5bz2IsQgJxMBoQEdvxBY9INCYHPMLx6rzp8LuZHQHaJAZCI69IyFMpFAYt0mEJ2z7nNpys+VPQ+Ado43flXaLyVe4gG4NGpoJWbcb/SF3COA07acOCWd9dUvMgDdxjWrpdJFvsOs7tSwxT7+YwWEXrWHec27zHl/+eh4A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b6ae5d-81c1-4620-3d7a-08dba4a5608a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 13:24:00.4900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owIFbYkdNrbrqbeDxrnR1si7Ee91Z40nNy/qwcn0fgrdtOA+/ltU55knnkQh8tw7mOLEHFDaM0fEwWRv7tbe5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_09,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308240111
X-Proofpoint-GUID: 1NGao-lGYkqHm8hymX67lVoSPj66RlFO
X-Proofpoint-ORIG-GUID: 1NGao-lGYkqHm8hymX67lVoSPj66RlFO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 24, 2023 at 01:59:06PM +0800, kernel test robot wrote:
> 
> 
> hi, Chuck Lever,
> 
> Fengwei (CCed) helped us review this astonishing finding by fsmark tests,
> and doubt below part:
> -			nfsd4_end_grace(nn);
> +			trace_nfsd_end_grace(netns(file));
> 
> and confirmed if adding back:
> 			nfsd4_end_grace(nn);
> 
> the regression is gone and files_per_sec restore to 61.93.

As always, thanks for the report. However, this result is not
plausible. "end_grace" happens only once after a server reboot.

Can you confirm that the NFS server kernel is not crashing
during the test?


> FYI.
> 
> 
> Hello,
> 
> kernel test robot noticed a -100.0% regression of fsmark.files_per_sec on:
> 
> 
> commit: 39d432fc76301cf0a0c454022117601994ca9397 ("NFSD: trace nfsctl operations")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> testcase: fsmark
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	iterations: 1x
> 	nr_threads: 32t
> 	disk: 1SSD
> 	fs: btrfs
> 	fs2: nfsv4
> 	filesize: 16MB
> 	test_size: 20G
> 	sync_method: NoSync
> 	nr_directories: 16d
> 	nr_files_per_directory: 256fpd
> 	cpufreq_governor: performance
> 
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+-------------------------------------------------------------------------------------------+
> | testcase: change | fsmark: fsmark.files_per_sec -100.0% regression                                           |
> | test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
> | test parameters  | cpufreq_governor=performance                                                              |
> |                  | debug-setup=no-monitor                                                                    |
> |                  | disk=1SSD                                                                                 |
> |                  | filesize=16MB                                                                             |
> |                  | fs2=nfsv4                                                                                 |
> |                  | fs=btrfs                                                                                  |
> |                  | iterations=1x                                                                             |
> |                  | nr_directories=16d                                                                        |
> |                  | nr_files_per_directory=256fpd                                                             |
> |                  | nr_threads=32t                                                                            |
> |                  | sync_method=NoSync                                                                        |
> |                  | test_size=20G                                                                             |
> +------------------+-------------------------------------------------------------------------------------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202308241229.68396422-oliver.sang@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20230824/202308241229.68396422-oliver.sang@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
>   gcc-12/performance/1SSD/16MB/nfsv4/btrfs/1x/x86_64-rhel-8.3/16d/256fpd/32t/debian-11.1-x86_64-20220510.cgz/NoSync/lkp-icl-2sp7/20G/fsmark
> 
> commit: 
>   3434d7aa77 ("NFSD: Clean up nfsctl_transaction_write()")
>   39d432fc76 ("NFSD: trace nfsctl operations")
> 
> 3434d7aa77d24c5c 39d432fc76301cf0a0c45402211 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>      51.67 ± 25%     -90.8%       4.75 ± 45%  perf-c2c.DRAM.local
>      35.36 ± 16%     +35.2%      47.81 ± 16%  boot-time.dhcp
>       1.81 ± 41%     +90.9%       3.46 ± 31%  boot-time.smp_boot
>  1.455e+09 ±  6%  +12542.8%  1.839e+11 ± 20%  cpuidle..time
>    3013365 ±  2%   +6257.5%  1.916e+08 ± 20%  cpuidle..usage
>      81.11 ±  7%   +3758.6%       3129 ± 18%  uptime.boot
>       4349 ±  8%   +4266.2%     189897 ± 19%  uptime.idle
>      71.95           +31.7%      94.75        iostat.cpu.idle
>      18.35 ±  3%     -84.5%       2.85 ± 56%  iostat.cpu.iowait
>       7.98 ±  5%     -70.3%       2.37        iostat.cpu.system
>       1.73 ±  3%     -98.0%       0.03 ± 15%  iostat.cpu.user
>    7176382 ±  6%     +37.6%    9873307 ±  6%  numa-numastat.node0.local_node
>    7210227 ±  6%     +37.5%    9914765 ±  6%  numa-numastat.node0.numa_hit
>    6958614 ±  6%     +29.1%    8981736 ±  4%  numa-numastat.node1.local_node
>    6990967 ±  6%     +28.8%    9006618 ±  4%  numa-numastat.node1.numa_hit
>    8749533 ±  4%   +7050.4%  6.256e+08 ± 18%  fsmark.app_overhead
>      61.92 ±  5%    -100.0%       0.00        fsmark.files_per_sec
>      22.77 ±  4%  +12864.1%       2951 ± 20%  fsmark.time.elapsed_time
>      22.77 ±  4%  +12864.1%       2951 ± 20%  fsmark.time.elapsed_time.max
>     189.33 ±  7%     -99.5%       1.00        fsmark.time.percent_of_cpu_this_job_got
>      70.09           +24.7       94.75        mpstat.cpu.all.idle%
>      19.80 ±  4%     -16.9        2.86 ± 56%  mpstat.cpu.all.iowait%
>       1.18 ±  4%      +1.0        2.20        mpstat.cpu.all.irq%
>       0.13 ±  2%      -0.1        0.07 ±  3%  mpstat.cpu.all.soft%
>       7.10 ±  7%      -7.0        0.09 ± 12%  mpstat.cpu.all.sys%
>       1.70 ±  5%      -1.7        0.03 ± 15%  mpstat.cpu.all.usr%
>      71.33           +32.5%      94.50        vmstat.cpu.id
>      18.00 ±  3%     -87.5%       2.25 ± 79%  vmstat.cpu.wa
>     784537 ±  5%     -99.0%       7461 ± 21%  vmstat.io.bo
>      10.17 ± 23%     -85.2%       1.50 ± 74%  vmstat.procs.b
>       6.00 ± 25%    -100.0%       0.00        vmstat.procs.r
>     101767 ±  7%     -91.5%       8688 ±  8%  vmstat.system.cs
>      70688            -9.1%      64225        vmstat.system.in
>      43996 ±  5%    +121.0%      97246 ±  9%  meminfo.Active
>       4516 ± 14%   +1588.6%      76266 ±  6%  meminfo.Active(anon)
>      39479 ±  4%     -46.9%      20978 ± 24%  meminfo.Active(file)
>      34922 ± 23%    +551.6%     227542        meminfo.AnonHugePages
>     397478           -24.1%     301733        meminfo.AnonPages
>     653045           -19.5%     525838        meminfo.Committed_AS
>     154701 ± 15%     -42.0%      89789 ±  4%  meminfo.Dirty
>     401768           -23.5%     307192        meminfo.Inactive(anon)
>      33307           -11.3%      29548        meminfo.Mapped
>       6837 ±  7%     -27.6%       4950        meminfo.PageTables
>       9016 ±  7%    +814.1%      82421 ±  6%  meminfo.Shmem
>     324959 ±  7%     +25.1%     406488 ±  2%  meminfo.Writeback
>       1940 ± 58%    +683.0%      15195 ± 36%  numa-meminfo.node0.Active(anon)
>      18757 ± 14%     -33.6%      12450 ± 30%  numa-meminfo.node0.Active(file)
>      18975 ± 47%    +872.5%     184526 ± 25%  numa-meminfo.node0.AnonHugePages
>      79966 ± 22%     -38.8%      48963 ±  8%  numa-meminfo.node0.Dirty
>       5833 ± 21%    +235.6%      19573 ± 31%  numa-meminfo.node0.Shmem
>      23325 ± 16%    +198.4%      69601 ±  9%  numa-meminfo.node1.Active
>       2576 ± 43%   +2270.7%      61072 ±  5%  numa-meminfo.node1.Active(anon)
>      20749 ± 15%     -58.9%       8528 ± 46%  numa-meminfo.node1.Active(file)
>     183812 ± 19%     -67.5%      59692 ± 75%  numa-meminfo.node1.AnonPages
>      67153 ± 14%     -39.2%      40835 ± 14%  numa-meminfo.node1.Dirty
>     184305 ± 19%     -66.8%      61274 ± 73%  numa-meminfo.node1.Inactive(anon)
>       3143 ± 25%     -37.2%       1973 ± 21%  numa-meminfo.node1.PageTables
>       3184 ± 36%   +1873.9%      62849 ±  5%  numa-meminfo.node1.Shmem
>     339.17 ±  5%     -91.4%      29.25        turbostat.Avg_MHz
>      11.43 ±  5%      -8.2        3.23        turbostat.Busy%
>       3004           -69.7%     909.25        turbostat.Bzy_MHz
>      52538 ±  7%    +834.8%     491105 ± 18%  turbostat.C1
>       0.41 ±  7%      -0.4        0.01 ± 57%  turbostat.C1%
>     849439 ±  2%    +679.9%    6624934 ± 48%  turbostat.C1E
>      23.10 ±  3%     -20.1        3.02 ± 53%  turbostat.C1E%
>    1067521 ±  8%  +17084.8%  1.835e+08 ± 20%  turbostat.C6
>      64.56 ±  2%     +29.6       94.19        turbostat.C6%
>      87.74           +10.3%      96.76        turbostat.CPU%c1
>       0.83 ± 45%     -98.5%       0.01 ± 34%  turbostat.CPU%c6
>     128.85 ±152%     -99.9%       0.09        turbostat.IPC
>    1858116 ±  5%  +10114.2%  1.898e+08 ± 20%  turbostat.IRQ
>       0.64 ±  6%      -0.6        0.01 ±100%  turbostat.POLL%
>     154.16           -23.3%     118.17        turbostat.PkgWatt
>      63.10           -15.5%      53.29        turbostat.RAMWatt
>     484.83 ± 58%    +683.5%       3798 ± 36%  numa-vmstat.node0.nr_active_anon
>       4690 ± 14%     -33.6%       3112 ± 30%  numa-vmstat.node0.nr_active_file
>       8.83 ± 51%    +916.0%      89.75 ± 25%  numa-vmstat.node0.nr_anon_transparent_hugepages
>      19775 ± 24%     -38.3%      12194 ±  8%  numa-vmstat.node0.nr_dirty
>       1457 ± 21%    +235.7%       4893 ± 31%  numa-vmstat.node0.nr_shmem
>     484.83 ± 58%    +683.5%       3798 ± 36%  numa-vmstat.node0.nr_zone_active_anon
>       4690 ± 14%     -33.6%       3112 ± 30%  numa-vmstat.node0.nr_zone_active_file
>      36457 ± 22%     -59.5%      14783 ± 10%  numa-vmstat.node0.nr_zone_write_pending
>    7210556 ±  6%     +37.5%    9914914 ±  6%  numa-vmstat.node0.numa_hit
>    7176711 ±  6%     +37.6%    9873455 ±  6%  numa-vmstat.node0.numa_local
>     643.83 ± 43%   +2271.4%      15268 ±  5%  numa-vmstat.node1.nr_active_anon
>       5189 ± 15%     -58.9%       2132 ± 46%  numa-vmstat.node1.nr_active_file
>      45952 ± 19%     -67.5%      14923 ± 75%  numa-vmstat.node1.nr_anon_pages
>      16398 ± 15%     -37.8%      10204 ± 14%  numa-vmstat.node1.nr_dirty
>      46074 ± 19%     -66.8%      15318 ± 73%  numa-vmstat.node1.nr_inactive_anon
>     785.33 ± 25%     -37.3%     492.75 ± 21%  numa-vmstat.node1.nr_page_table_pages
>     795.83 ± 36%   +1874.3%      15712 ±  5%  numa-vmstat.node1.nr_shmem
>     643.83 ± 43%   +2271.4%      15268 ±  5%  numa-vmstat.node1.nr_zone_active_anon
>       5189 ± 15%     -58.9%       2132 ± 46%  numa-vmstat.node1.nr_zone_active_file
>      46074 ± 19%     -66.8%      15318 ± 73%  numa-vmstat.node1.nr_zone_inactive_anon
>      34148 ± 11%     -62.3%      12864 ± 19%  numa-vmstat.node1.nr_zone_write_pending
>    6991051 ±  6%     +28.8%    9006790 ±  4%  numa-vmstat.node1.numa_hit
>    6958699 ±  6%     +29.1%    8981908 ±  4%  numa-vmstat.node1.numa_local
>       1128 ± 14%   +1589.1%      19066 ±  6%  proc-vmstat.nr_active_anon
>       9870 ±  4%     -46.9%       5244 ± 24%  proc-vmstat.nr_active_file
>      99377           -24.1%      75431        proc-vmstat.nr_anon_pages
>      16.67 ± 23%    +564.5%     110.75        proc-vmstat.nr_anon_transparent_hugepages
>      38368 ± 15%     -41.6%      22410 ±  4%  proc-vmstat.nr_dirty
>     100443           -23.5%      76796        proc-vmstat.nr_inactive_anon
>      15586            -6.6%      14560        proc-vmstat.nr_kernel_stack
>       8326           -11.3%       7386        proc-vmstat.nr_mapped
>       1709 ±  7%     -27.6%       1236        proc-vmstat.nr_page_table_pages
>       2254 ±  7%    +814.2%      20605 ±  6%  proc-vmstat.nr_shmem
>      81381 ±  7%     +24.9%     101605 ±  2%  proc-vmstat.nr_writeback
>       1128 ± 14%   +1589.1%      19066 ±  6%  proc-vmstat.nr_zone_active_anon
>       9870 ±  4%     -46.9%       5244 ± 24%  proc-vmstat.nr_zone_active_file
>     100443           -23.5%      76796        proc-vmstat.nr_zone_inactive_anon
>      71853 ± 11%     -61.5%      27641 ± 12%  proc-vmstat.nr_zone_write_pending
>     404.67 ±  6%   +1276.3%       5569 ± 13%  proc-vmstat.numa_hint_faults
>      69.67 ± 27%   +4299.9%       3065 ± 77%  proc-vmstat.numa_hint_faults_local
>   14202988           +33.2%   18923999 ±  5%  proc-vmstat.numa_hit
>   14136791           +33.4%   18857658 ±  5%  proc-vmstat.numa_local
>     335.00 ± 10%   +1203.3%       4366 ± 82%  proc-vmstat.numa_pages_migrated
>     698.50 ±  8%   +5553.1%      39487 ± 15%  proc-vmstat.numa_pte_updates
>      11408 ±  2%     +84.5%      21048 ±  5%  proc-vmstat.pgactivate
>   18935279           +26.2%   23897622 ±  4%  proc-vmstat.pgalloc_normal
>     225757         +2641.0%    6188094 ± 19%  proc-vmstat.pgfault
>   13477492           +37.7%   18558535 ±  5%  proc-vmstat.pgfree
>     335.00 ± 10%   +1203.3%       4366 ± 82%  proc-vmstat.pgmigrate_success
>       8658 ±  2%   +3345.5%     298318 ± 19%  proc-vmstat.pgreuse
>     637184 ± 40%   +3336.2%   21894720 ± 20%  proc-vmstat.unevictable_pgs_scanned
>       0.23 ± 10%     -76.3%       0.05        sched_debug.cfs_rq:/.h_nr_running.avg
>       0.43 ±  5%     -48.4%       0.22        sched_debug.cfs_rq:/.h_nr_running.stddev
>      13720 ± 57%    +127.8%      31261 ±  2%  sched_debug.cfs_rq:/.load.avg
>     109.64 ± 26%     -72.0%      30.67 ± 14%  sched_debug.cfs_rq:/.load_avg.avg
>       1053 ±  2%     -20.8%     834.32 ±  3%  sched_debug.cfs_rq:/.load_avg.max
>     274.91 ± 14%     -48.8%     140.77 ±  7%  sched_debug.cfs_rq:/.load_avg.stddev
>      13475 ± 20%     +63.8%      22072 ± 17%  sched_debug.cfs_rq:/.min_vruntime.avg
>      39896 ± 14%     +40.9%      56195 ± 15%  sched_debug.cfs_rq:/.min_vruntime.max
>       5378 ± 23%    +108.5%      11216 ± 14%  sched_debug.cfs_rq:/.min_vruntime.min
>       5503 ± 11%     +57.4%       8663 ± 13%  sched_debug.cfs_rq:/.min_vruntime.stddev
>       0.23 ± 10%     -76.3%       0.05        sched_debug.cfs_rq:/.nr_running.avg
>       0.43 ±  5%     -48.4%       0.22        sched_debug.cfs_rq:/.nr_running.stddev
>      65.15 ± 36%     -93.0%       4.53 ± 76%  sched_debug.cfs_rq:/.removed.load_avg.avg
>       1024           -87.2%     131.45 ±119%  sched_debug.cfs_rq:/.removed.load_avg.max
>     242.33 ± 17%     -90.8%      22.40 ±101%  sched_debug.cfs_rq:/.removed.load_avg.stddev
>      23.97 ± 36%     -91.6%       2.00 ± 84%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
>     504.33 ±  3%     -86.8%      66.39 ±118%  sched_debug.cfs_rq:/.removed.runnable_avg.max
>      93.28 ± 17%     -88.6%      10.66 ±106%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
>      23.97 ± 36%     -91.6%       2.00 ± 84%  sched_debug.cfs_rq:/.removed.util_avg.avg
>     504.33 ±  3%     -86.8%      66.39 ±118%  sched_debug.cfs_rq:/.removed.util_avg.max
>      93.28 ± 17%     -88.6%      10.66 ±106%  sched_debug.cfs_rq:/.removed.util_avg.stddev
>     447.97 ±  3%     -93.2%      30.55 ± 10%  sched_debug.cfs_rq:/.runnable_avg.avg
>       1652 ± 21%     -65.3%     573.91        sched_debug.cfs_rq:/.runnable_avg.max
>     361.15 ± 10%     -72.7%      98.67 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
>       5515 ± 10%     +57.1%       8663 ± 13%  sched_debug.cfs_rq:/.spread0.stddev
>     447.20 ±  3%     -93.2%      30.54 ± 10%  sched_debug.cfs_rq:/.util_avg.avg
>       1651 ± 21%     -65.2%     573.90        sched_debug.cfs_rq:/.util_avg.max
>     360.75 ± 10%     -72.7%      98.65 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
>      35.87 ± 32%     -92.8%       2.57 ± 23%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>     627.00 ± 32%     -88.2%      73.92 ± 11%  sched_debug.cfs_rq:/.util_est_enqueued.max
>     125.31 ± 21%     -90.6%      11.82 ± 13%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
>     773027 ±  4%     +25.1%     966950        sched_debug.cpu.avg_idle.avg
>       3844 ± 16%   +9867.6%     383238 ± 36%  sched_debug.cpu.avg_idle.min
>     284379 ± 22%     -62.7%     106134 ± 15%  sched_debug.cpu.avg_idle.stddev
>      56501 ± 11%   +2798.3%    1637565 ± 18%  sched_debug.cpu.clock.avg
>      56505 ± 11%   +2798.1%    1637568 ± 18%  sched_debug.cpu.clock.max
>      56493 ± 11%   +2798.7%    1637561 ± 18%  sched_debug.cpu.clock.min
>       2.84 ± 14%     -30.1%       1.98 ±  3%  sched_debug.cpu.clock.stddev
>      55933 ± 11%   +2766.0%    1603047 ± 18%  sched_debug.cpu.clock_task.avg
>      56388 ± 11%   +2747.3%    1605532 ± 18%  sched_debug.cpu.clock_task.max
>      43272 ±  5%   +3548.5%    1578791 ± 18%  sched_debug.cpu.clock_task.min
>       1611 ± 45%    +102.9%       3269 ± 31%  sched_debug.cpu.clock_task.stddev
>       3920          +950.0%      41168 ± 18%  sched_debug.cpu.curr->pid.max
>       1512 ±  2%    +241.7%       5166 ± 17%  sched_debug.cpu.curr->pid.stddev
>       0.00 ± 28%     -66.7%       0.00 ±  4%  sched_debug.cpu.next_balance.stddev
>       0.22 ±  7%     -87.6%       0.03 ±  4%  sched_debug.cpu.nr_running.avg
>       0.42 ±  5%     -63.9%       0.15 ±  2%  sched_debug.cpu.nr_running.stddev
>       6681         +2922.6%     201964 ± 20%  sched_debug.cpu.nr_switches.avg
>     203120          +243.0%     696661 ± 25%  sched_debug.cpu.nr_switches.max
>     347.50 ± 19%  +12362.1%      43305 ± 29%  sched_debug.cpu.nr_switches.min
>      26003 ±  2%    +367.6%     121580 ± 15%  sched_debug.cpu.nr_switches.stddev
>      56496 ± 11%   +2798.5%    1637561 ± 18%  sched_debug.cpu_clk
>      55771 ± 11%   +2834.9%    1636836 ± 18%  sched_debug.ktime
>      51473 ±  5%   +3047.3%    1620032 ± 18%  sched_debug.sched_clk
>      17.02 ±  3%     -78.0%       3.74        perf-stat.i.MPKI
>  1.839e+09 ±  6%     -94.8%   96458674 ±  5%  perf-stat.i.branch-instructions
>       1.20 ±  7%      -0.4        0.80        perf-stat.i.branch-miss-rate%
>   22120063 ± 10%     -95.7%     961876 ±  9%  perf-stat.i.branch-misses
>      59.22 ±  3%     -50.6        8.66        perf-stat.i.cache-miss-rate%
>   91195048 ±  7%     -99.1%     801389 ± 18%  perf-stat.i.cache-misses
>  1.507e+08 ±  7%     -98.3%    2538095 ± 10%  perf-stat.i.cache-references
>     119037 ±  8%     -92.7%       8685 ±  8%  perf-stat.i.context-switches
>       2.52 ±  3%      -7.7%       2.33        perf-stat.i.cpi
>  2.236e+10 ±  6%     -95.2%  1.081e+09 ±  3%  perf-stat.i.cpu-cycles
>     264.18 ± 12%     -71.9%      74.16        perf-stat.i.cpu-migrations
>     331.37 ± 29%   +2939.3%      10071 ±  2%  perf-stat.i.cycles-between-cache-misses
>       0.03 ± 14%      +0.1        0.09 ± 23%  perf-stat.i.dTLB-load-miss-rate%
>     734621 ± 10%     -86.2%     101019 ± 22%  perf-stat.i.dTLB-load-misses
>  2.249e+09 ±  5%     -94.3%  1.281e+08 ±  4%  perf-stat.i.dTLB-loads
>       0.01 ± 10%      +0.0        0.04 ± 13%  perf-stat.i.dTLB-store-miss-rate%
>     122554 ±  8%     -80.7%      23688 ± 11%  perf-stat.i.dTLB-store-misses
>  9.999e+08 ±  5%     -93.2%   67811239 ±  3%  perf-stat.i.dTLB-stores
>  9.066e+09 ±  6%     -94.6%  4.866e+08 ±  4%  perf-stat.i.instructions
>       0.47 ± 64%     -97.2%       0.01 ± 42%  perf-stat.i.major-faults
>       0.35 ±  6%     -95.2%       0.02 ±  3%  perf-stat.i.metric.GHz
>       1229 ±  6%     -34.7%     802.68        perf-stat.i.metric.K/sec
>      81.72 ±  5%     -95.3%       3.81 ±  5%  perf-stat.i.metric.M/sec
>       3477 ±  6%     -42.5%       1998        perf-stat.i.minor-faults
>      52.18 ±  4%     +41.9       94.08        perf-stat.i.node-load-miss-rate%
>   18404682 ±  7%     -99.0%     176907 ± 14%  perf-stat.i.node-load-misses
>   16742387 ±  9%     -99.1%     144408 ± 22%  perf-stat.i.node-loads
>      12.77 ±  9%     +18.7       31.45 ± 27%  perf-stat.i.node-store-miss-rate%
>    4850218 ± 12%     -99.0%      49478 ±  9%  perf-stat.i.node-store-misses
>   36531812 ±  6%     -99.1%     320605 ± 19%  perf-stat.i.node-stores
>       3478 ±  6%     -42.5%       1998        perf-stat.i.page-faults
>      16.63 ±  3%     -68.7%       5.21 ±  5%  perf-stat.overall.MPKI
>       1.20 ±  7%      -0.2        1.00 ±  4%  perf-stat.overall.branch-miss-rate%
>      60.51 ±  2%     -29.2       31.34 ±  8%  perf-stat.overall.cache-miss-rate%
>       2.47 ±  3%      -9.9%       2.22        perf-stat.overall.cpi
>     245.31          +464.9%       1385 ± 15%  perf-stat.overall.cycles-between-cache-misses
>       0.03 ± 13%      +0.0        0.08 ± 22%  perf-stat.overall.dTLB-load-miss-rate%
>       0.01 ±  9%      +0.0        0.03 ± 12%  perf-stat.overall.dTLB-store-miss-rate%
>       0.41 ±  3%     +10.9%       0.45        perf-stat.overall.ipc
>   1.76e+09 ±  5%     -94.5%   96442481 ±  5%  perf-stat.ps.branch-instructions
>   21170965 ± 10%     -95.5%     961854 ±  9%  perf-stat.ps.branch-misses
>   87299736 ±  6%     -99.1%     801893 ± 18%  perf-stat.ps.cache-misses
>  1.443e+08 ±  6%     -98.2%    2538635 ± 10%  perf-stat.ps.cache-references
>     113951 ±  8%     -92.4%       8683 ±  8%  perf-stat.ps.context-switches
>      61339            +4.3%      63977        perf-stat.ps.cpu-clock
>  2.141e+10 ±  6%     -95.0%  1.081e+09 ±  3%  perf-stat.ps.cpu-cycles
>     252.91 ± 12%     -70.7%      74.14        perf-stat.ps.cpu-migrations
>     703511 ± 10%     -85.6%     100987 ± 22%  perf-stat.ps.dTLB-load-misses
>  2.153e+09 ±  5%     -94.1%  1.281e+08 ±  4%  perf-stat.ps.dTLB-loads
>     117341 ±  8%     -79.8%      23681 ± 11%  perf-stat.ps.dTLB-store-misses
>  9.573e+08 ±  5%     -92.9%   67795911 ±  3%  perf-stat.ps.dTLB-stores
>  8.678e+09 ±  5%     -94.4%  4.866e+08 ±  4%  perf-stat.ps.instructions
>       0.45 ± 64%     -97.1%       0.01 ± 42%  perf-stat.ps.major-faults
>       3324 ±  5%     -39.9%       1998        perf-stat.ps.minor-faults
>   17622482 ±  7%     -99.0%     177005 ± 14%  perf-stat.ps.node-load-misses
>   16025463 ±  9%     -99.1%     144476 ± 22%  perf-stat.ps.node-loads
>    4642492 ± 12%     -98.9%      49511 ± 10%  perf-stat.ps.node-store-misses
>   34969456 ±  6%     -99.1%     320794 ± 19%  perf-stat.ps.node-stores
>       3324 ±  5%     -39.9%       1998        perf-stat.ps.page-faults
>      61339            +4.3%      63977        perf-stat.ps.task-clock
>  2.065e+11 ±  3%    +589.5%  1.424e+12 ± 16%  perf-stat.total.instructions
>       0.01 ± 60%    +113.6%       0.02 ± 20%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>       0.00 ±157%    +425.0%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>       0.03 ± 16%     +71.9%       0.05 ±  3%  perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork
>       0.01 ± 38%     -65.4%       0.00 ± 19%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>       0.58 ±151%     -96.5%       0.02 ±  7%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
>       0.00 ±108%    +218.0%       0.01 ± 13%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       0.03 ± 21%     +92.0%       0.07        perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork
>       0.00 ±120%    +267.2%       0.02 ± 12%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>       7.44 ±112%     -99.6%       0.03 ± 25%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
>       0.04 ± 91%     -81.6%       0.01        perf-sched.total_sch_delay.average.ms
>      55.05 ±169%     -94.2%       3.20 ± 12%  perf-sched.total_sch_delay.max.ms
>       9.41 ± 27%    +263.5%      34.20 ±  5%  perf-sched.total_wait_and_delay.average.ms
>       2099 ± 13%    +875.6%      20478 ±  4%  perf-sched.total_wait_and_delay.count.ms
>     309.85 ±  2%   +1511.3%       4992        perf-sched.total_wait_and_delay.max.ms
>       9.37 ± 28%    +265.1%      34.20 ±  5%  perf-sched.total_wait_time.average.ms
>     309.85 ±  2%   +1511.3%       4992        perf-sched.total_wait_time.max.ms
>       1.83 ± 24%   +1179.9%      23.43        perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>      68.28 ± 38%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>       0.93 ± 30%  +26685.0%     250.13 ±  3%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>      69.46           +46.7%     101.87        perf-sched.wait_and_delay.avg.ms.irq_thread.kthread.ret_from_fork
>       1.64 ±  6%   +2380.5%      40.63 ±  2%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>      39.18 ± 14%    +863.6%     377.57        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>       4.35 ±  6%    +576.4%      29.42 ±  6%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>      32.32 ± 47%   +1966.0%     667.82        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
>      49.09 ± 11%    +739.5%     412.11 ±  4%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
>     245.00 ± 39%     +56.7%     384.00        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>       3.83 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>     507.67 ±  9%     -75.6%     124.00        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>     449.83 ±  9%     -72.7%     123.00        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       3.00         +1500.0%      48.00        perf-sched.wait_and_delay.count.irq_thread.kthread.ret_from_fork
>     343.83 ±  9%    +416.7%       1776 ±  2%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
>      73.33 ±  8%    +121.9%     162.75 ±  6%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>     302.83 ± 30%     +71.9%     520.50        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
>     117.50 ± 18%    +212.1%     366.75 ±  4%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
>     299.23 ±  3%   +1568.5%       4992        perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>     236.11 ± 27%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>      69.82 ±139%   +2069.6%       1514 ± 31%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>     238.02 ± 28%    +322.4%       1005        perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>     292.85 ±  3%     +70.7%     499.98        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>       5.04         +6666.8%     340.75 ± 18%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>     305.61 ±  2%    +800.7%       2752 ± 29%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
>     303.33 ±  4%    +705.6%       2443 ± 13%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
>       1.83 ± 24%   +1180.3%      23.43        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>      68.27 ± 38%     -97.3%       1.82 ± 12%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>       0.00 ±223%  +7.7e+07%     766.71 ±  7%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>       0.93 ± 30%  +26838.2%     250.12 ±  3%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       0.29 ± 69%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
>      69.43           +46.6%     101.82        perf-sched.wait_time.avg.ms.irq_thread.kthread.ret_from_fork
>       1.63 ±  6%   +2390.3%      40.62 ±  2%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>      38.67 ± 13%    +876.3%     377.56        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>       0.07 ±223%    +576.2%       0.49 ±  7%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>       4.34 ±  6%    +578.4%      29.41 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>      32.27 ± 47%   +1969.2%     667.81        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
>      48.50 ± 11%    +749.6%     412.09 ±  4%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
>     299.06 ±  3%   +1569.4%       4992        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>     236.10 ± 28%     -98.5%       3.65 ± 12%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>       0.00 ±223%  +5.5e+07%       1000        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>      69.82 ±139%   +2069.6%       1514 ± 31%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       0.55 ± 77%    -100.0%       0.00        perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
>     238.01 ± 28%    +322.4%       1005        perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>     292.84 ±  3%     +70.7%     499.97        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>       0.15 ±223%    +647.1%       1.09 ± 12%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>       5.03         +6675.8%     340.74 ± 18%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>     305.61 ±  2%    +800.7%       2752 ± 29%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
>     303.32 ±  4%    +705.6%       2443 ± 13%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
>      37.90 ± 63%     -36.6        1.29 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      37.90 ± 63%     -36.6        1.29 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>      27.62 ± 86%     -27.5        0.16 ±173%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
>      24.63 ± 88%     -24.6        0.00        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
>      24.63 ± 88%     -24.6        0.00        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
>      24.63 ± 88%     -24.6        0.00        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
>      24.63 ± 88%     -24.6        0.00        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
>      23.24 ± 82%     -23.2        0.00        perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
>      23.24 ± 82%     -23.2        0.00        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
>      23.24 ± 82%     -23.2        0.00        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
>      23.24 ± 82%     -23.2        0.00        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.get_signal
>      19.58 ±103%     -19.6        0.00        perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      18.70 ±111%     -18.7        0.00        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      18.70 ±111%     -18.7        0.00        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      18.70 ±111%     -18.7        0.00        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>      18.70 ±111%     -18.7        0.00        perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>      10.10 ± 88%     -10.1        0.00        perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
>      10.23 ± 79%     -10.1        0.15 ±173%  perf-profile.calltrace.cycles-pp.__libc_start_main
>      10.23 ± 79%     -10.1        0.15 ±173%  perf-profile.calltrace.cycles-pp.main.__libc_start_main
>      10.23 ± 79%     -10.1        0.15 ±173%  perf-profile.calltrace.cycles-pp.run_builtin.main.__libc_start_main
>       9.52 ± 97%      -9.3        0.18 ±173%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       9.52 ± 97%      -9.3        0.19 ±173%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       9.52 ± 97%      -9.3        0.19 ±173%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.39 ± 87%      -6.4        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write.writen.record__pushfn.perf_mmap__push
>       6.39 ± 87%      -6.4        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write.writen.record__pushfn
>       6.39 ± 87%      -6.4        0.00        perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
>       6.39 ± 87%      -6.4        0.00        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write.writen
>       6.39 ± 87%      -6.4        0.00        perf-profile.calltrace.cycles-pp.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.39 ± 87%      -6.4        0.00        perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write
>       6.39 ± 87%      -6.4        0.00        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
>       6.39 ± 87%      -6.4        0.00        perf-profile.calltrace.cycles-pp.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
>       6.39 ± 87%      -6.4        0.00        perf-profile.calltrace.cycles-pp.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record
>       6.39 ± 87%      -6.4        0.00        perf-profile.calltrace.cycles-pp.__libc_write.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist
>       6.15 ±101%      -6.1        0.00        perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.main.__libc_start_main
>       6.15 ±101%      -6.1        0.00        perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.run_builtin.main.__libc_start_main
>       6.15 ±101%      -6.1        0.00        perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin.main
>       6.08 ± 79%      -6.1        0.00        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.08 ± 79%      -6.1        0.00        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
>       4.63 ± 80%      -4.6        0.00        perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin
>       3.84 ±104%      -3.8        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
>       3.84 ±104%      -3.8        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>       3.84 ±104%      -3.8        0.00        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>       3.84 ±104%      -3.8        0.00        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>       3.84 ±104%      -3.8        0.00        perf-profile.calltrace.cycles-pp.__mmap
>       0.00            +0.5        0.52 ±  3%  perf-profile.calltrace.cycles-pp.__run_timers.run_timer_softirq.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt
>       0.00            +0.5        0.52 ±  3%  perf-profile.calltrace.cycles-pp.run_timer_softirq.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>       0.00            +0.6        0.59 ±  9%  perf-profile.calltrace.cycles-pp.hrtimer_next_event_without.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
>       0.00            +0.7        0.71 ± 15%  perf-profile.calltrace.cycles-pp._raw_spin_trylock.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt
>       0.00            +0.8        0.77 ± 25%  perf-profile.calltrace.cycles-pp.update_rq_clock_task.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
>       0.00            +0.8        0.79 ± 12%  perf-profile.calltrace.cycles-pp.update_blocked_averages.run_rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt
>       0.00            +0.8        0.80 ± 23%  perf-profile.calltrace.cycles-pp.__break_lease.do_dentry_open.dentry_open.__nfsd_open.nfsd_file_do_acquire
>       0.00            +0.8        0.80 ± 24%  perf-profile.calltrace.cycles-pp.__nfsd_open.nfsd_file_do_acquire.nfsd4_commit.nfsd4_proc_compound.nfsd_dispatch
>       0.00            +0.8        0.80 ± 24%  perf-profile.calltrace.cycles-pp.dentry_open.__nfsd_open.nfsd_file_do_acquire.nfsd4_commit.nfsd4_proc_compound
>       0.00            +0.8        0.80 ± 24%  perf-profile.calltrace.cycles-pp.do_dentry_open.dentry_open.__nfsd_open.nfsd_file_do_acquire.nfsd4_commit
>       0.00            +0.8        0.80 ± 24%  perf-profile.calltrace.cycles-pp.nfsd.kthread.ret_from_fork
>       0.00            +0.8        0.80 ± 24%  perf-profile.calltrace.cycles-pp.svc_process.nfsd.kthread.ret_from_fork
>       0.00            +0.8        0.80 ± 24%  perf-profile.calltrace.cycles-pp.svc_process_common.svc_process.nfsd.kthread.ret_from_fork
>       0.00            +0.8        0.80 ± 24%  perf-profile.calltrace.cycles-pp.nfsd_dispatch.svc_process_common.svc_process.nfsd.kthread
>       0.00            +0.8        0.80 ± 24%  perf-profile.calltrace.cycles-pp.nfsd4_proc_compound.nfsd_dispatch.svc_process_common.svc_process.nfsd
>       0.00            +0.8        0.80 ± 24%  perf-profile.calltrace.cycles-pp.nfsd4_commit.nfsd4_proc_compound.nfsd_dispatch.svc_process_common.svc_process
>       0.00            +0.8        0.80 ± 24%  perf-profile.calltrace.cycles-pp.nfsd_file_do_acquire.nfsd4_commit.nfsd4_proc_compound.nfsd_dispatch.svc_process_common
>       0.00            +0.8        0.81 ± 12%  perf-profile.calltrace.cycles-pp.cpuidle_governor_latency_req.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
>       0.00            +0.8        0.84 ± 12%  perf-profile.calltrace.cycles-pp.run_rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>       0.00            +0.9        0.86 ±  8%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains
>       0.00            +1.1        1.10 ± 20%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
>       0.00            +1.1        1.11 ±  2%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains.__do_softirq
>       0.00            +1.2        1.18 ±  5%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains.__do_softirq.__irq_exit_rcu
>       0.00            +1.3        1.27 ± 28%  perf-profile.calltrace.cycles-pp.tick_sched_do_timer.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
>       0.00            +1.4        1.38 ± 49%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
>       0.00            +1.4        1.44 ± 46%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
>       0.00            +1.4        1.45 ± 14%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt
>       0.00            +1.5        1.51 ± 12%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
>       0.00            +1.6        1.56        perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt
>       0.00            +1.6        1.59 ± 12%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init
>       0.00            +1.6        1.59 ±  5%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
>       0.00            +1.6        1.61 ± 13%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel
>       0.00            +1.6        1.62 ± 12%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations
>       0.00            +1.6        1.62 ± 12%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.secondary_startup_64_no_verify
>       0.00            +1.6        1.62 ± 12%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
>       0.00            +1.6        1.62 ± 12%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
>       0.00            +1.6        1.62 ± 12%  perf-profile.calltrace.cycles-pp.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
>       0.00            +1.6        1.62 ± 12%  perf-profile.calltrace.cycles-pp.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
>       0.00            +1.7        1.72 ±  8%  perf-profile.calltrace.cycles-pp.ret_from_fork
>       0.00            +1.7        1.72 ±  8%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
>       0.00            +1.9        1.86 ± 10%  perf-profile.calltrace.cycles-pp.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
>       0.00            +2.0        1.97 ± 11%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
>       0.00            +2.2        2.22 ±  4%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>       0.00            +2.6        2.56 ±  5%  perf-profile.calltrace.cycles-pp.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>       0.00            +2.8        2.85 ±  7%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
>       0.00            +3.1        3.10 ±  8%  perf-profile.calltrace.cycles-pp.arch_scale_freq_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
>       0.00            +4.4        4.40 ±  6%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>       0.00            +4.6        4.62 ±  5%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
>       0.88 ±223%      +4.7        5.61 ± 11%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
>       0.00            +5.5        5.51 ±  4%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
>       2.36 ±100%      +5.6        7.96 ±  9%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
>       2.36 ±100%      +5.9        8.22 ±  9%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
>       2.36 ±100%      +8.6       10.93 ±  6%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
>       2.36 ±100%     +13.5       15.87 ±  4%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>       0.88 ±223%     +21.2       22.07 ±  4%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
>       0.88 ±223%     +21.3       22.22 ±  4%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
>       0.88 ±223%     +30.2       31.04 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
>       0.88 ±223%     +38.9       39.74        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>       0.00           +42.2       42.16        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>       0.88 ±223%     +81.5       82.34        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
>       0.88 ±223%     +82.4       83.24        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>       2.48 ±158%     +87.7       90.16        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       2.48 ±158%     +87.9       90.37        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       2.48 ±158%     +87.9       90.38        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
>       0.88 ±223%     +88.1       88.95        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       2.48 ±158%     +89.5       92.00        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>      74.91 ± 19%     -71.0        3.92 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
>      74.91 ± 19%     -71.0        3.94 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      28.80 ± 65%     -28.5        0.29 ± 33%  perf-profile.children.cycles-pp.zap_pte_range
>      28.80 ± 65%     -28.5        0.31 ± 36%  perf-profile.children.cycles-pp.unmap_page_range
>      28.80 ± 65%     -28.5        0.31 ± 36%  perf-profile.children.cycles-pp.zap_pmd_range
>      28.80 ± 65%     -28.5        0.33 ± 29%  perf-profile.children.cycles-pp.unmap_vmas
>      23.24 ± 82%     -23.2        0.00        perf-profile.children.cycles-pp.arch_do_signal_or_restart
>      23.24 ± 82%     -23.2        0.00        perf-profile.children.cycles-pp.get_signal
>       7.90 ± 90%      -7.9        0.01 ±173%  perf-profile.children.cycles-pp.record__mmap_read_evlist
>       6.39 ± 87%      -6.4        0.01 ±173%  perf-profile.children.cycles-pp.generic_perform_write
>       6.39 ± 87%      -6.4        0.01 ±173%  perf-profile.children.cycles-pp.perf_mmap__push
>       6.39 ± 87%      -6.4        0.01 ±173%  perf-profile.children.cycles-pp.record__pushfn
>       6.39 ± 87%      -6.4        0.01 ±173%  perf-profile.children.cycles-pp.writen
>       6.39 ± 87%      -6.4        0.01 ±173%  perf-profile.children.cycles-pp.__libc_write
>       6.39 ± 87%      -6.4        0.02 ±173%  perf-profile.children.cycles-pp.__generic_file_write_iter
>       6.39 ± 87%      -6.4        0.02 ±173%  perf-profile.children.cycles-pp.generic_file_write_iter
>       0.00            +0.1        0.06 ± 17%  perf-profile.children.cycles-pp.unlink_anon_vmas
>       0.00            +0.1        0.06 ± 31%  perf-profile.children.cycles-pp.__get_user_pages
>       0.00            +0.1        0.07 ± 28%  perf-profile.children.cycles-pp.cpuidle_not_available
>       0.00            +0.1        0.07 ± 28%  perf-profile.children.cycles-pp.__lookup_slow
>       0.00            +0.1        0.07 ± 26%  perf-profile.children.cycles-pp.check_move_unevictable_folios
>       0.00            +0.1        0.07 ± 26%  perf-profile.children.cycles-pp.check_move_unevictable_pages
>       0.00            +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.__percpu_counter_init
>       0.00            +0.1        0.07 ± 26%  perf-profile.children.cycles-pp.get_arg_page
>       0.00            +0.1        0.07 ± 26%  perf-profile.children.cycles-pp.get_user_pages_remote
>       0.00            +0.1        0.08 ± 26%  perf-profile.children.cycles-pp.drm_gem_shmem_put_pages_locked
>       0.00            +0.1        0.08 ± 26%  perf-profile.children.cycles-pp.drm_gem_put_pages
>       0.00            +0.1        0.08 ± 26%  perf-profile.children.cycles-pp.drm_gem_check_release_pagevec
>       0.00            +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.hrtimer_run_queues
>       0.00            +0.1        0.08 ± 45%  perf-profile.children.cycles-pp.__x64_sys_mprotect
>       0.00            +0.1        0.08 ± 45%  perf-profile.children.cycles-pp.do_mprotect_pkey
>       0.00            +0.1        0.09 ± 33%  perf-profile.children.cycles-pp.lookup_fast
>       0.00            +0.1        0.09 ± 29%  perf-profile.children.cycles-pp.rcu_do_batch
>       0.00            +0.1        0.09 ± 32%  perf-profile.children.cycles-pp.can_stop_idle_tick
>       0.00            +0.1        0.09 ± 32%  perf-profile.children.cycles-pp.__vmalloc_node_range
>       0.00            +0.1        0.09 ± 32%  perf-profile.children.cycles-pp.alloc_thread_stack_node
>       0.00            +0.1        0.09 ± 20%  perf-profile.children.cycles-pp.perf_read
>       0.00            +0.1        0.10 ± 26%  perf-profile.children.cycles-pp.perf_evsel__read
>       0.00            +0.1        0.10 ± 21%  perf-profile.children.cycles-pp.menu_reflect
>       0.00            +0.1        0.10 ± 21%  perf-profile.children.cycles-pp.alloc_bprm
>       0.00            +0.1        0.10 ± 12%  perf-profile.children.cycles-pp.vma_interval_tree_insert
>       0.00            +0.1        0.10 ± 27%  perf-profile.children.cycles-pp.nohz_balancer_kick
>       0.00            +0.1        0.10 ± 18%  perf-profile.children.cycles-pp.mm_init
>       0.00            +0.1        0.10 ± 14%  perf-profile.children.cycles-pp.note_gp_changes
>       0.00            +0.1        0.11 ± 21%  perf-profile.children.cycles-pp.cpuidle_reflect
>       0.00            +0.1        0.11 ±  9%  perf-profile.children.cycles-pp.dup_task_struct
>       0.00            +0.1        0.11 ± 52%  perf-profile.children.cycles-pp.find_idlest_cpu
>       0.00            +0.1        0.11 ± 52%  perf-profile.children.cycles-pp.find_idlest_group
>       0.00            +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.drm_gem_vunmap_unlocked
>       0.00            +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.drm_gem_vunmap
>       0.00            +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.drm_gem_shmem_vunmap
>       0.00            +0.1        0.12 ± 38%  perf-profile.children.cycles-pp.irq_work_run_list
>       0.00            +0.1        0.12 ± 13%  perf-profile.children.cycles-pp.__switch_to_asm
>       0.00            +0.1        0.13 ± 11%  perf-profile.children.cycles-pp.pipe_read
>       0.00            +0.1        0.14 ±  8%  perf-profile.children.cycles-pp.exec_mmap
>       0.00            +0.1        0.14 ± 44%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
>       0.00            +0.1        0.14 ± 14%  perf-profile.children.cycles-pp.irqentry_exit
>       0.00            +0.1        0.14 ± 14%  perf-profile.children.cycles-pp.walk_component
>       0.00            +0.1        0.14 ± 39%  perf-profile.children.cycles-pp.pick_next_task_fair
>       0.00            +0.1        0.15 ± 25%  perf-profile.children.cycles-pp.smpboot_thread_fn
>       0.00            +0.2        0.15 ± 51%  perf-profile.children.cycles-pp.update_wall_time
>       0.00            +0.2        0.15 ± 51%  perf-profile.children.cycles-pp.timekeeping_advance
>       0.00            +0.2        0.16 ± 47%  perf-profile.children.cycles-pp.copy_strings
>       0.00            +0.2        0.16 ± 16%  perf-profile.children.cycles-pp.ct_kernel_exit
>       0.00            +0.2        0.16 ± 40%  perf-profile.children.cycles-pp.select_task_rq_fair
>       0.00            +0.2        0.16 ± 33%  perf-profile.children.cycles-pp.perf_event_task_tick
>       0.00            +0.2        0.16 ±  4%  perf-profile.children.cycles-pp.__libc_read
>       0.00            +0.2        0.16 ± 28%  perf-profile.children.cycles-pp.__x64_sys_vfork
>       0.00            +0.2        0.16 ± 19%  perf-profile.children.cycles-pp.intel_idle_irq
>       0.00            +0.2        0.16 ± 22%  perf-profile.children.cycles-pp.___perf_sw_event
>       0.00            +0.2        0.16 ± 28%  perf-profile.children.cycles-pp.update_rt_rq_load_avg
>       0.00            +0.2        0.16 ± 39%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
>       0.00            +0.2        0.16 ± 16%  perf-profile.children.cycles-pp._find_next_and_bit
>       0.00            +0.2        0.16 ± 24%  perf-profile.children.cycles-pp.evsel__read_counter
>       0.00            +0.2        0.17 ± 13%  perf-profile.children.cycles-pp.irqtime_account_process_tick
>       0.00            +0.2        0.17 ± 49%  perf-profile.children.cycles-pp.shmem_read_folio_gfp
>       0.00            +0.2        0.17 ± 33%  perf-profile.children.cycles-pp.rb_erase
>       0.00            +0.2        0.18 ± 31%  perf-profile.children.cycles-pp.drm_atomic_commit
>       0.00            +0.2        0.18 ± 31%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
>       0.00            +0.2        0.18 ± 16%  perf-profile.children.cycles-pp.hrtimer_forward
>       0.00            +0.2        0.18 ±  4%  perf-profile.children.cycles-pp.readn
>       0.00            +0.2        0.18 ± 30%  perf-profile.children.cycles-pp.sched_clock
>       0.00            +0.2        0.18 ± 27%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
>       0.00            +0.2        0.19 ± 28%  perf-profile.children.cycles-pp.check_cpu_stall
>       0.00            +0.2        0.19 ± 30%  perf-profile.children.cycles-pp.begin_new_exec
>       0.00            +0.2        0.19 ± 20%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
>       0.00            +0.2        0.19 ± 19%  perf-profile.children.cycles-pp.__vfork
>       0.00            +0.2        0.20 ± 34%  perf-profile.children.cycles-pp.drm_gem_shmem_get_pages
>       0.00            +0.2        0.20 ± 34%  perf-profile.children.cycles-pp.drm_gem_shmem_get_pages_locked
>       0.00            +0.2        0.20 ± 34%  perf-profile.children.cycles-pp.drm_gem_get_pages
>       0.00            +0.2        0.20 ± 34%  perf-profile.children.cycles-pp.shmem_read_mapping_page_gfp
>       0.00            +0.2        0.20 ± 18%  perf-profile.children.cycles-pp.rb_next
>       0.00            +0.2        0.20 ± 39%  perf-profile.children.cycles-pp.drm_gem_vmap_unlocked
>       0.00            +0.2        0.20 ± 39%  perf-profile.children.cycles-pp.drm_gem_vmap
>       0.00            +0.2        0.20 ± 39%  perf-profile.children.cycles-pp.drm_gem_shmem_object_vmap
>       0.00            +0.2        0.20 ± 39%  perf-profile.children.cycles-pp.drm_gem_shmem_vmap_locked
>       0.00            +0.2        0.21 ± 45%  perf-profile.children.cycles-pp.run_posix_cpu_timers
>       0.00            +0.2        0.21 ± 20%  perf-profile.children.cycles-pp.tick_program_event
>       0.00            +0.2        0.22 ±102%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
>       0.00            +0.2        0.23 ± 23%  perf-profile.children.cycles-pp.ttwu_do_activate
>       0.00            +0.2        0.23 ± 25%  perf-profile.children.cycles-pp.arch_cpu_idle_exit
>       0.00            +0.2        0.24 ± 15%  perf-profile.children.cycles-pp.rb_insert_color
>       0.00            +0.2        0.24 ± 45%  perf-profile.children.cycles-pp.irqentry_enter
>       0.00            +0.3        0.26 ±  7%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
>       0.00            +0.3        0.27 ± 16%  perf-profile.children.cycles-pp.rcu_core
>       0.00            +0.3        0.29 ±  9%  perf-profile.children.cycles-pp.error_entry
>       0.00            +0.3        0.31 ± 15%  perf-profile.children.cycles-pp.call_cpuidle
>       0.00            +0.3        0.33 ± 22%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
>       0.00            +0.3        0.33 ± 22%  perf-profile.children.cycles-pp.drm_fbdev_generic_helper_fb_dirty
>       0.00            +0.3        0.33 ± 27%  perf-profile.children.cycles-pp.sched_clock_idle_wakeup_event
>       0.00            +0.3        0.33 ± 18%  perf-profile.children.cycles-pp.ct_kernel_exit_state
>       0.00            +0.3        0.35 ± 47%  perf-profile.children.cycles-pp.ct_kernel_enter
>       0.00            +0.3        0.35 ± 17%  perf-profile.children.cycles-pp.hrtimer_update_next_event
>       0.00            +0.4        0.37 ± 16%  perf-profile.children.cycles-pp.idle_cpu
>       0.00            +0.4        0.40 ± 30%  perf-profile.children.cycles-pp.hrtimer_get_next_event
>       0.00            +0.4        0.40 ± 15%  perf-profile.children.cycles-pp.irq_work_tick
>       0.00            +0.4        0.40 ± 20%  perf-profile.children.cycles-pp.timerqueue_del
>       0.00            +0.4        0.43 ± 10%  perf-profile.children.cycles-pp.call_timer_fn
>       0.00            +0.4        0.44 ±  7%  perf-profile.children.cycles-pp.read_counters
>       0.00            +0.4        0.44 ± 45%  perf-profile.children.cycles-pp.ct_idle_exit
>       0.00            +0.5        0.48 ±  8%  perf-profile.children.cycles-pp.cmd_stat
>       0.00            +0.5        0.48 ±  8%  perf-profile.children.cycles-pp.dispatch_events
>       0.00            +0.5        0.48 ±  8%  perf-profile.children.cycles-pp.process_interval
>       0.00            +0.5        0.50 ± 18%  perf-profile.children.cycles-pp.process_one_work
>       0.00            +0.5        0.51 ± 23%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
>       0.00            +0.5        0.51 ± 10%  perf-profile.children.cycles-pp._raw_spin_lock_irq
>       0.00            +0.5        0.52 ±  3%  perf-profile.children.cycles-pp.run_timer_softirq
>       0.00            +0.5        0.52 ± 27%  perf-profile.children.cycles-pp.schedule_timeout
>       0.00            +0.5        0.53 ± 16%  perf-profile.children.cycles-pp.worker_thread
>       0.00            +0.5        0.53 ± 28%  perf-profile.children.cycles-pp.timerqueue_add
>       0.00            +0.6        0.56 ± 18%  perf-profile.children.cycles-pp.schedule
>       0.00            +0.6        0.58 ±  3%  perf-profile.children.cycles-pp.__run_timers
>       0.00            +0.6        0.58 ± 18%  perf-profile.children.cycles-pp.get_cpu_device
>       0.00            +0.6        0.59 ± 14%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
>       0.00            +0.6        0.60 ± 16%  perf-profile.children.cycles-pp.update_rq_clock
>       0.00            +0.6        0.62 ± 61%  perf-profile.children.cycles-pp.calc_global_load_tick
>       0.00            +0.7        0.66 ± 21%  perf-profile.children.cycles-pp.enqueue_hrtimer
>       0.00            +0.7        0.66 ± 17%  perf-profile.children.cycles-pp.local_clock
>       0.00            +0.7        0.68 ±  7%  perf-profile.children.cycles-pp.hrtimer_next_event_without
>       0.00            +0.7        0.70 ± 24%  perf-profile.children.cycles-pp.get_next_timer_interrupt
>       0.00            +0.7        0.74 ± 15%  perf-profile.children.cycles-pp._raw_spin_trylock
>       0.00            +0.7        0.75 ± 29%  perf-profile.children.cycles-pp.update_irq_load_avg
>       0.00            +0.8        0.80 ± 24%  perf-profile.children.cycles-pp.__nfsd_open
>       0.00            +0.8        0.80 ± 24%  perf-profile.children.cycles-pp.dentry_open
>       0.00            +0.8        0.80 ± 24%  perf-profile.children.cycles-pp.__break_lease
>       0.00            +0.8        0.80 ± 24%  perf-profile.children.cycles-pp.nfsd
>       0.00            +0.8        0.80 ± 24%  perf-profile.children.cycles-pp.svc_process
>       0.00            +0.8        0.80 ± 24%  perf-profile.children.cycles-pp.svc_process_common
>       0.00            +0.8        0.80 ± 24%  perf-profile.children.cycles-pp.nfsd_dispatch
>       0.00            +0.8        0.80 ± 24%  perf-profile.children.cycles-pp.nfsd4_proc_compound
>       0.00            +0.8        0.80 ± 24%  perf-profile.children.cycles-pp.nfsd4_commit
>       0.00            +0.8        0.80 ± 24%  perf-profile.children.cycles-pp.nfsd_file_do_acquire
>       0.00            +0.8        0.81 ± 13%  perf-profile.children.cycles-pp.update_blocked_averages
>       0.00            +0.8        0.82 ± 25%  perf-profile.children.cycles-pp.do_dentry_open
>       0.00            +0.8        0.84 ± 12%  perf-profile.children.cycles-pp.run_rebalance_domains
>       0.00            +0.9        0.89 ± 15%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
>       0.00            +1.0        0.98 ±  8%  perf-profile.children.cycles-pp.update_sg_lb_stats
>       0.00            +1.0        0.98 ± 24%  perf-profile.children.cycles-pp.update_rq_clock_task
>       0.00            +1.1        1.08 ±  9%  perf-profile.children.cycles-pp.irqtime_account_irq
>       0.00            +1.2        1.16 ± 17%  perf-profile.children.cycles-pp.tick_nohz_next_event
>       0.00            +1.2        1.17 ± 14%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.00            +1.3        1.25 ±  2%  perf-profile.children.cycles-pp.update_sd_lb_stats
>       0.00            +1.3        1.31 ±  2%  perf-profile.children.cycles-pp.find_busiest_group
>       0.00            +1.4        1.35 ± 28%  perf-profile.children.cycles-pp.tick_sched_do_timer
>       0.00            +1.5        1.46 ± 48%  perf-profile.children.cycles-pp.tick_irq_enter
>       0.00            +1.5        1.46 ±  3%  perf-profile.children.cycles-pp.sched_clock_cpu
>       0.00            +1.5        1.51 ± 12%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
>       0.00            +1.5        1.53 ± 42%  perf-profile.children.cycles-pp.irq_enter_rcu
>       0.00            +1.6        1.62 ± 12%  perf-profile.children.cycles-pp.x86_64_start_kernel
>       0.00            +1.6        1.62 ± 12%  perf-profile.children.cycles-pp.x86_64_start_reservations
>       0.00            +1.6        1.62 ± 12%  perf-profile.children.cycles-pp.start_kernel
>       0.00            +1.6        1.62 ± 12%  perf-profile.children.cycles-pp.arch_call_rest_init
>       0.00            +1.6        1.62 ± 12%  perf-profile.children.cycles-pp.rest_init
>       0.00            +1.7        1.70 ±  7%  perf-profile.children.cycles-pp.native_sched_clock
>       0.00            +1.7        1.70 ±  3%  perf-profile.children.cycles-pp.load_balance
>       0.00            +1.7        1.71 ±  5%  perf-profile.children.cycles-pp.lapic_next_deadline
>       0.00            +1.7        1.72 ±  8%  perf-profile.children.cycles-pp.kthread
>       0.00            +1.8        1.76 ±  7%  perf-profile.children.cycles-pp.ret_from_fork
>       0.00            +1.9        1.95 ± 16%  perf-profile.children.cycles-pp.read_tsc
>       0.00            +2.0        1.98 ±  9%  perf-profile.children.cycles-pp.perf_rotate_context
>       0.00            +2.0        2.04 ± 11%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
>       0.00            +2.3        2.30 ±  5%  perf-profile.children.cycles-pp.clockevents_program_event
>       0.00            +2.6        2.60 ±  6%  perf-profile.children.cycles-pp.rebalance_domains
>       0.00            +3.0        2.99 ±  7%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
>       0.00            +3.2        3.18 ±  7%  perf-profile.children.cycles-pp.arch_scale_freq_tick
>       0.00            +3.9        3.92 ± 31%  perf-profile.children.cycles-pp.ktime_get
>       0.00            +4.5        4.53 ±  6%  perf-profile.children.cycles-pp.menu_select
>       0.00            +4.7        4.71 ±  6%  perf-profile.children.cycles-pp.__do_softirq
>       0.88 ±223%      +5.0        5.86 ± 11%  perf-profile.children.cycles-pp.scheduler_tick
>       0.00            +5.6        5.64 ±  4%  perf-profile.children.cycles-pp.__irq_exit_rcu
>       2.36 ±100%      +5.8        8.15 ±  9%  perf-profile.children.cycles-pp.update_process_times
>       2.36 ±100%      +6.0        8.35 ±  9%  perf-profile.children.cycles-pp.tick_sched_handle
>       2.36 ±100%      +8.8       11.21 ±  6%  perf-profile.children.cycles-pp.tick_sched_timer
>       2.36 ±100%     +13.9       16.30 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>       3.24 ±117%     +19.3       22.55 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
>       3.24 ±117%     +19.4       22.66 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>       3.24 ±117%     +28.0       31.28 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>       3.24 ±117%     +32.7       35.97 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>       0.00           +42.2       42.16        perf-profile.children.cycles-pp.intel_idle
>       0.88 ±223%     +83.5       84.34        perf-profile.children.cycles-pp.cpuidle_enter_state
>       0.88 ±223%     +83.9       84.78        perf-profile.children.cycles-pp.cpuidle_enter
>       2.48 ±158%     +87.9       90.38        perf-profile.children.cycles-pp.start_secondary
>       2.48 ±158%     +89.5       92.00        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>       2.48 ±158%     +89.5       92.00        perf-profile.children.cycles-pp.cpu_startup_entry
>       2.48 ±158%     +89.5       92.00        perf-profile.children.cycles-pp.do_idle
>       0.88 ±223%     +89.8       90.65        perf-profile.children.cycles-pp.cpuidle_idle_call
>       0.00            +0.1        0.06 ± 20%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
>       0.00            +0.1        0.07 ± 19%  perf-profile.self.cycles-pp.tick_irq_enter
>       0.00            +0.1        0.07 ± 26%  perf-profile.self.cycles-pp.check_move_unevictable_folios
>       0.00            +0.1        0.07 ± 33%  perf-profile.self.cycles-pp.perf_event_task_tick
>       0.00            +0.1        0.08 ± 19%  perf-profile.self.cycles-pp.hrtimer_run_queues
>       0.00            +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.irqentry_exit
>       0.00            +0.1        0.08 ± 21%  perf-profile.self.cycles-pp.hrtimer_get_next_event
>       0.00            +0.1        0.08 ± 26%  perf-profile.self.cycles-pp.can_stop_idle_tick
>       0.00            +0.1        0.09 ± 29%  perf-profile.self.cycles-pp.irqentry_enter
>       0.00            +0.1        0.09 ± 43%  perf-profile.self.cycles-pp.update_blocked_averages
>       0.00            +0.1        0.10 ± 12%  perf-profile.self.cycles-pp.vma_interval_tree_insert
>       0.00            +0.1        0.10 ± 34%  perf-profile.self.cycles-pp.irq_work_run_list
>       0.00            +0.1        0.10 ± 43%  perf-profile.self.cycles-pp.ct_kernel_exit
>       0.00            +0.1        0.10 ± 41%  perf-profile.self.cycles-pp.__sysvec_apic_timer_interrupt
>       0.00            +0.1        0.11 ± 13%  perf-profile.self.cycles-pp.tick_sched_timer
>       0.00            +0.1        0.11 ± 42%  perf-profile.self.cycles-pp.filemap_map_pages
>       0.00            +0.1        0.12 ± 26%  perf-profile.self.cycles-pp.rb_erase
>       0.00            +0.1        0.12 ± 56%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
>       0.00            +0.1        0.12 ± 13%  perf-profile.self.cycles-pp.__switch_to_asm
>       0.00            +0.1        0.13 ± 21%  perf-profile.self.cycles-pp.hrtimer_update_next_event
>       0.00            +0.1        0.13 ± 36%  perf-profile.self.cycles-pp.hrtimer_forward
>       0.00            +0.1        0.13 ± 25%  perf-profile.self.cycles-pp.rb_next
>       0.00            +0.1        0.13 ± 42%  perf-profile.self.cycles-pp.update_rq_clock
>       0.00            +0.1        0.14 ± 34%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
>       0.00            +0.1        0.14 ± 23%  perf-profile.self.cycles-pp.enqueue_hrtimer
>       0.00            +0.1        0.14 ± 32%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
>       0.00            +0.1        0.14 ± 15%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
>       0.00            +0.1        0.15 ± 40%  perf-profile.self.cycles-pp.clockevents_program_event
>       0.00            +0.1        0.15 ± 23%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
>       0.00            +0.2        0.15 ± 21%  perf-profile.self.cycles-pp.___perf_sw_event
>       0.00            +0.2        0.16 ± 14%  perf-profile.self.cycles-pp.irqtime_account_process_tick
>       0.00            +0.2        0.16 ± 19%  perf-profile.self.cycles-pp._find_next_and_bit
>       0.00            +0.2        0.16 ± 23%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
>       0.00            +0.2        0.16 ± 25%  perf-profile.self.cycles-pp.update_rt_rq_load_avg
>       0.00            +0.2        0.16 ± 19%  perf-profile.self.cycles-pp.intel_idle_irq
>       0.00            +0.2        0.16 ± 17%  perf-profile.self.cycles-pp.hrtimer_next_event_without
>       0.00            +0.2        0.18 ± 45%  perf-profile.self.cycles-pp.timerqueue_del
>       0.00            +0.2        0.18 ± 27%  perf-profile.self.cycles-pp.check_cpu_stall
>       0.00            +0.2        0.18 ± 36%  perf-profile.self.cycles-pp.update_sd_lb_stats
>       0.00            +0.2        0.19 ± 44%  perf-profile.self.cycles-pp.run_posix_cpu_timers
>       0.00            +0.2        0.19 ± 18%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
>       0.00            +0.2        0.20 ± 47%  perf-profile.self.cycles-pp.__do_softirq
>       0.00            +0.2        0.20 ± 23%  perf-profile.self.cycles-pp.tick_program_event
>       0.00            +0.2        0.20 ± 26%  perf-profile.self.cycles-pp.rb_insert_color
>       0.00            +0.2        0.20 ±  8%  perf-profile.self.cycles-pp.sched_clock_cpu
>       0.00            +0.2        0.21 ± 41%  perf-profile.self.cycles-pp.get_next_timer_interrupt
>       0.00            +0.2        0.21 ± 60%  perf-profile.self.cycles-pp.ct_kernel_enter
>       0.00            +0.2        0.22 ±102%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
>       0.00            +0.2        0.25 ± 26%  perf-profile.self.cycles-pp.update_rq_clock_task
>       0.00            +0.2        0.25 ± 26%  perf-profile.self.cycles-pp.__irq_exit_rcu
>       0.00            +0.3        0.26 ± 38%  perf-profile.self.cycles-pp.rebalance_domains
>       0.00            +0.3        0.26 ± 33%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
>       0.00            +0.3        0.26 ± 25%  perf-profile.self.cycles-pp.perf_rotate_context
>       0.00            +0.3        0.28 ± 20%  perf-profile.self.cycles-pp.tick_nohz_next_event
>       0.00            +0.3        0.29 ±  9%  perf-profile.self.cycles-pp.error_entry
>       0.00            +0.3        0.29 ± 38%  perf-profile.self.cycles-pp.hrtimer_interrupt
>       0.00            +0.3        0.30 ± 18%  perf-profile.self.cycles-pp.call_cpuidle
>       0.00            +0.3        0.30 ± 16%  perf-profile.self.cycles-pp.load_balance
>       0.00            +0.3        0.31 ± 22%  perf-profile.self.cycles-pp.ct_kernel_exit_state
>       0.00            +0.3        0.32 ± 20%  perf-profile.self.cycles-pp.irqtime_account_irq
>       0.00            +0.3        0.32 ± 31%  perf-profile.self.cycles-pp.timerqueue_add
>       0.00            +0.3        0.32 ± 28%  perf-profile.self.cycles-pp.sched_clock_idle_wakeup_event
>       0.00            +0.4        0.35 ± 20%  perf-profile.self.cycles-pp.scheduler_tick
>       0.00            +0.4        0.36 ± 16%  perf-profile.self.cycles-pp.idle_cpu
>       0.00            +0.4        0.38 ± 17%  perf-profile.self.cycles-pp.irq_work_tick
>       0.00            +0.4        0.39 ± 20%  perf-profile.self.cycles-pp.cpuidle_enter
>       0.00            +0.4        0.40 ± 18%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
>       0.00            +0.4        0.45 ± 36%  perf-profile.self.cycles-pp.do_idle
>       0.00            +0.5        0.50 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irq
>       0.00            +0.5        0.51 ± 18%  perf-profile.self.cycles-pp.__hrtimer_run_queues
>       0.00            +0.5        0.53 ± 17%  perf-profile.self.cycles-pp.get_cpu_device
>       0.00            +0.5        0.54 ±  8%  perf-profile.self.cycles-pp.update_process_times
>       0.00            +0.6        0.56 ± 27%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
>       0.00            +0.6        0.62 ± 61%  perf-profile.self.cycles-pp.calc_global_load_tick
>       0.00            +0.7        0.69 ± 16%  perf-profile.self.cycles-pp.cpuidle_idle_call
>       0.00            +0.7        0.73 ± 14%  perf-profile.self.cycles-pp._raw_spin_trylock
>       0.00            +0.7        0.73 ± 29%  perf-profile.self.cycles-pp.update_irq_load_avg
>       0.00            +0.7        0.74 ±  9%  perf-profile.self.cycles-pp.update_sg_lb_stats
>       0.00            +1.1        1.10 ± 14%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.00            +1.2        1.18 ± 31%  perf-profile.self.cycles-pp.tick_sched_do_timer
>       0.00            +1.4        1.45 ±  9%  perf-profile.self.cycles-pp.menu_select
>       0.00            +1.5        1.51 ± 12%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
>       0.00            +1.6        1.63 ±  9%  perf-profile.self.cycles-pp.native_sched_clock
>       0.00            +1.7        1.70 ±  4%  perf-profile.self.cycles-pp.lapic_next_deadline
>       0.00            +1.9        1.93 ± 16%  perf-profile.self.cycles-pp.read_tsc
>       0.00            +2.3        2.30 ± 52%  perf-profile.self.cycles-pp.ktime_get
>       0.00            +3.2        3.18 ±  7%  perf-profile.self.cycles-pp.arch_scale_freq_tick
>       0.00            +5.8        5.84 ±  9%  perf-profile.self.cycles-pp.cpuidle_enter_state
>       0.00           +42.2       42.16        perf-profile.self.cycles-pp.intel_idle
> 
> 
> ***************************************************************************************************
> lkp-icl-2sp7: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> =========================================================================================
> compiler/cpufreq_governor/debug-setup/disk/filesize/fs2/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
>   gcc-12/performance/no-monitor/1SSD/16MB/nfsv4/btrfs/1x/x86_64-rhel-8.3/16d/256fpd/32t/debian-11.1-x86_64-20220510.cgz/NoSync/lkp-icl-2sp7/20G/fsmark
> 
> commit: 
>   3434d7aa77 ("NFSD: Clean up nfsctl_transaction_write()")
>   39d432fc76 ("NFSD: trace nfsctl operations")
> 
> 3434d7aa77d24c5c 39d432fc76301cf0a0c45402211 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>    7488368 ±  2%   +7979.7%   6.05e+08 ± 47%  fsmark.app_overhead
>      62.42 ±  2%    -100.0%       0.00        fsmark.files_per_sec
>      22.46 ±  2%  +15766.1%       3564 ±  5%  fsmark.time.elapsed_time
>      22.46 ±  2%  +15766.1%       3564 ±  5%  fsmark.time.elapsed_time.max
>     192.33           -99.5%       1.00        fsmark.time.percent_of_cpu_this_job_got
>      43.05           +13.7%      48.94 ±  4%  fsmark.time.system_time
>     978884            +2.9%    1007574 ±  2%  fsmark.time.voluntary_context_switches
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

-- 
Chuck Lever
