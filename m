Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A63563971
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Jul 2022 21:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiGASyd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Jul 2022 14:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiGASyc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Jul 2022 14:54:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FC242A03;
        Fri,  1 Jul 2022 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656701671; x=1688237671;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/3W26CPV1zZPsa5SRa3jysRwiLePSzs3w9B4RMyKqAk=;
  b=JIXbLufGPxLo0mrfgCG8h6YKUQevNjh1yMWY49tCC8qLHH1PVceQJnYq
   L4AD+y7MeZgHYymM2eo3p5P8A9qa1eYzE2MG8tTCf6aVSPxdUj0RtPjAZ
   RNparylTUHLfd5aBz9W1MECeWatia6a9d5BZ747QSEJiNxPzSlLmT7105
   B4L7mzYZCbl5pd7rN8wlLmVrG5XsRdDetTY0idsciq+/mt6ZnDAqZRvyg
   9prC80YkXJDSEdPWeMWq3DMZfZCFWSHk3TW6OiMs3aOe9sZuFvaeO5ecp
   1iZ1XWfihBPggwlHkTdUNOEiaFyEzAbYVkSNLXGWH7Mwnx+J/mK1ei0cV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="308251061"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="308251061"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 11:54:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="694612086"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jul 2022 11:54:31 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 11:54:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Jul 2022 11:54:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Jul 2022 11:54:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRkWd0pklLP+r8mo8ZAmEYhZK2mHhtCrwVqBd/m2mpgZ0+CjNjPcnzsRtokyBKSX7MCwqG2qz+DRklWzi4VDUSDvWOUoEFagZBcch2WCsial7uHAhp7CsEmXRCI2wJhvsyC1PoLptVz45SGuUSPi5PaBbioRXaoDbIF7hvGcNf86C7QnaYLinIzVWFeDT1kZ3lvxgbc00W8UerpI6vaDNYCTwO2AhhgDflhlszsiHt7osXIRNMmqmkNTMthVJ+KOhogTzABs5v1HhhB4TNpFuJUSHSIfucyfFbfwwScIu3tl9ofniSSqk8iI79BJmOpXS9jLTGmbenH9aGllj7cP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tB9o6geR4j41wDj0+PVXvUYkTbA8FUI7fumMHtMYlRU=;
 b=dic5r6ugQGn6vLM80eHGYbraYPmDdaQBZ4KYqLcHwYr0TCCZqoj838Q9GJsM9/Z2SC4lPP8oqQYuh5fJ0aRZr7vKqAae0NLQvCh7QYGs1ut1udGLcF0UFKgEy6bimsQJGt64Jr74lpmdkhS+7I8oBult73G6NvQYMdd/8aNeyKx41GqVMM3vAtHS/oG+QTyNUK5s65GzR+PF+6YFuVmj6/z4jEcNFKWtURS0WtgV/zwIk9kqQDvd5D08nRJAnjDn0mG6E48ZljrWSUYEjOr4VjtBClWuFE67BDQQg9jPp2LcoAKrKm1fB9C9SXca05wZgsbfTSagya8YowLiJUyYzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 CY4PR1101MB2133.namprd11.prod.outlook.com (2603:10b6:910:17::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Fri, 1 Jul
 2022 18:54:23 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207%5]) with mapi id 15.20.5395.014; Fri, 1 Jul 2022
 18:54:23 +0000
Date:   Fri, 1 Jul 2022 11:54:14 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Baptiste Lepers <baptiste.lepers@gmail.com>,
        <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs: Replace kmap() with kmap_local_page()
Message-ID: <Yr9C1h8fIAneJ9MU@iweiny-desk3>
References: <20220628182426.944-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220628182426.944-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BYAPR01CA0007.prod.exchangelabs.com (2603:10b6:a02:80::20)
 To DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9fccab3-385a-4a27-94c5-08da5b931d43
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2133:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7eOlmqX4pInjcKMcUWUpK3+33yLaoAK/Uyv9Phe2qPb04pNcdsFT0LVRK+4rmzDL76x+72XCbDxUN6FNswTHmka/R8jzDkPR3St1CwGP+d+GsrKHIwPvPiUkqTXekaMvYv++Y7NltLfPuOPkHCWZNPm0jlscbSZHf5vtnNwZGF8AyQFrHhRypam19XqPcZ0fgb9AjmmblGoBr9wg3DVf/VGBACCKOeTbO9KRYUs5Jvwgwvn7slGmszh1X75WBzwWoZDwrJcGbBmQgHNGKgcKjos76dtbxzR782bLBzlTAD7E9WtUTLIfWNJhTG2WYFnjLu8AhsTg+0Ao9X1AV+Tnr9ApT9jKn2CPPMHbADd1ytvMosTufOewdbLJkMWg5ZmXm74Xgg82dbqiAAD7XbYjGHsBNcQUXhgkpKUgKmw7SynA6p4XaPLgYMPhIFuNtBdh2b2xjOU0aqt95lUyVh1XP9kirwv5MnudAdwchQg6dzJaRxgORHjQZrJK+hlg9UFiYgjNdKB7mFtIxpsMTnzN7za85l2U9dc/eLSVReJ50sl0LRcOxWm2se4KXV2kL7YiPUieB47ahNzOQS+I6BsEeX1GLpzdDzqzna/f8Kfnmdn5a8Cm4yETWrmY1oOedVf/tPFZzwCfmuGnWyQsvsBldkfnlXhNXD9ivnPRGkkc+Egzr+nVu2r6RfIJBWXvw/Kkn4Y3FqNAlqoGGeMmxl6aZmpeQXo6pP4NARuNOjKVlK/4aFOYgW6MLbCYDB23ibb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(376002)(39860400002)(396003)(366004)(5660300002)(6506007)(38100700002)(6512007)(41300700001)(6666004)(83380400001)(6916009)(8936002)(44832011)(6486002)(33716001)(7416002)(478600001)(66946007)(9686003)(8676002)(82960400001)(2906002)(86362001)(66476007)(66556008)(186003)(54906003)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/etYTQpQXB9ZPstAuaA7/O90CeSt0hevCtzxcNiBeDN+c1q3KohRhajG8Rk4?=
 =?us-ascii?Q?O4Pe8tU+0g8c7IobdIrtfqzbd6oxjPNwBduzXfSnCekKVJzz6uxhsxkJzBvi?=
 =?us-ascii?Q?qthW1Y2Ea87+xAQyY7h9f3pjzSVTM45x7fXZ2o/E+QpMmSxEbVc22EOzwh3D?=
 =?us-ascii?Q?L7w5HWERyvxlsNP2XnPGeaXFAuHdozRYE7cW58l+4ooIrt++vZNNY0tqnzz7?=
 =?us-ascii?Q?II+OHLwT+eKWFzvZY62Rr//Rx1S3tUZ4n0z1nJAnw3uDhyErztBugbTsSRsm?=
 =?us-ascii?Q?D08IfHvgv0V3e8TguErwdNkrrJwS6ikEsPih18tqR8VRARYMLt0VkDWulXa4?=
 =?us-ascii?Q?IBuxGCIgw/ZGNV87yN8hOUYkmpbbTU1bruChEq5z1l1au+BI4E2eSxG2Bz+m?=
 =?us-ascii?Q?1XLOn1sSCXBKncXPw5r4idJejcT7G/TIAr2a6fvAA6/55xiHdmX3y/kTTapW?=
 =?us-ascii?Q?JlfQrjQMW4JXHln+q1ygH4wRMkSPClR5eODgYbl+XMtB9EnOy5YMHqDJ9rhN?=
 =?us-ascii?Q?WtkrYjeGHC4SnKF04VptN/Y5f/b64B390/GSZiSG/83rrkanRUEBwBGiVY5c?=
 =?us-ascii?Q?JI0525n4ugkarx/GJTy7ZyjCG4qQFQUHnXtp2GVrsFG2MCkn/EiQyxzCs4No?=
 =?us-ascii?Q?Ukv5LfVPIDPhEsx78rCZbfiBrj9SyK+qPnatPkBgxLWBHs+Yk82kfQinKLuc?=
 =?us-ascii?Q?ZSVVjgLI3HjWKhJT9MpY+vlbiETWeeQfPpoa8Y9jpNFhbWIQGxGrX/GmcK4F?=
 =?us-ascii?Q?8f0af7Y5kkg4J3vo0ISF/Zf9lh+vRNYKlTY4HyhxZroi6ZaH2IdPPSff9cPU?=
 =?us-ascii?Q?SZhZzE+vjn7aLK/1ryt9QnmWb7usVyllGi9ZY9TfvNf6l83Zc/L36uyIh/Ef?=
 =?us-ascii?Q?h64mJw8XKyPuDA4z2aYvP/jP8Zu19aSdO9Vyr4l1LZhmnLu1kx1GSC+oBtQO?=
 =?us-ascii?Q?HfQWIdvkN7Fbl6xDevzll2FzEr3gHEwXUv8LkQo+BejjBVevqsl/ofikR3IW?=
 =?us-ascii?Q?k/b3PTrTyMtY9MXRnGNDXuWIwmYHRTLfaAZQ1Twp8IIrRM5QbEy7z7F3qKJ1?=
 =?us-ascii?Q?eqD/fo3+1fPUmlT7AFzOrnS6+RbuLdpzVKSaAopHPEhVAUsAFzaTXbo6oGBU?=
 =?us-ascii?Q?3byai6tJfhl8IiXat1ph92MkAULojTXjtwHieHQxFMuAaeqQsugpUWNRGHhS?=
 =?us-ascii?Q?hxkruOdg2AD8RqofRCTVgFytkS7oH48BlhOPXYDlkvFp4Xm/4NwdwOLuFHuV?=
 =?us-ascii?Q?Kp+EOGqyL7XKpMz7HmWNCeHFV+4K4ILk2uHhWqnomFMNU67ziFvuRCENENyq?=
 =?us-ascii?Q?SL/JXyDlKFWWzRG0G2CUUQ2oSc8Fo46Tbej5jN3VnWLbWuLnluNtJzkV0rll?=
 =?us-ascii?Q?UbUTWT+3dJ8gLfGiG/ZeHhB35u74nYfipWYpZ/xcPZgs2gAf16qG6zdniZ2h?=
 =?us-ascii?Q?UVEZ9cqouwi1MRRDJvlCZKwhDWHE7SkuJ14amvlNirlAN6KvNJZqTo0Jzw5y?=
 =?us-ascii?Q?J6YSxVlWKnBM5HxCXQsOzDfLVVX9YVWD4S3Lcsq1/x/LzQ244UO+lozvIjJp?=
 =?us-ascii?Q?4dkPLxHssJ6YKAdnaYJ6Kb3p7/VSbE2zleeYc3kphGt1DREEpXtrZuKryWbI?=
 =?us-ascii?Q?G3s1CCcQeeUPC78V0/iYZC97PMMH6A8nI9ekxw6AbkK/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fccab3-385a-4a27-94c5-08da5b931d43
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 18:54:23.7509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9q6og2WSRTGcYwIz2HR10cVLxxEVwLpkn+N6Y8yNb/sHGZBiF5z4L95DKVYwkAlC3UbgA/3q2n0usBFVFJyqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2133
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 28, 2022 at 08:24:26PM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page().
> 
> With kmap_local_page(), the mapping is per thread, CPU local and not
> globally visible. Furthermore, the mapping can be acquired from any context
> (including interrupts).
> 
> Therefore, use kmap_local_page() in nfs_do_filldir() because this mapping
> is per thread, CPU local, and not globally visible.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> I cannot test this patch for several reasons. While these changes seem safe
> and trivial, I would feel better if people familiar with NFS could take the
> time to properly test this patch. Thank you.
> 
>  fs/nfs/dir.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 0c4e8dd6aa96..8b89f10d8899 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1084,7 +1084,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
>  	struct nfs_cache_array *array;
>  	unsigned int i;
>  
> -	array = kmap(desc->page);
> +	array = kmap_local_page(desc->page);
>  	for (i = desc->cache_entry_index; i < array->size; i++) {
>  		struct nfs_cache_array_entry *ent;
>  
> @@ -1110,7 +1110,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
>  	if (array->page_is_eof)
>  		desc->eof = !desc->eob;
>  
> -	kunmap(desc->page);
> +	kunmap_local(array);
>  	dfprintk(DIRCACHE, "NFS: nfs_do_filldir() filling ended @ cookie %llu\n",
>  			(unsigned long long)desc->dir_cookie);
>  }
> -- 
> 2.36.1
> 
