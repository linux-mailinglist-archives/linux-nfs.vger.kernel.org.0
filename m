Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9BC326498
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Feb 2021 16:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBZPUK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Feb 2021 10:20:10 -0500
Received: from mail-eopbgr680096.outbound.protection.outlook.com ([40.107.68.96]:6143
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229598AbhBZPUJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 26 Feb 2021 10:20:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BB+wNU4rHFTxj9AmQJR26KDM9jmHqM3ngxkPM75+fa4aseRYUpMUKxe/mfsLo/mr20NkwcL/iX2rWuV0TRRtykJvbPmOPsDcocLy8K0lc3tQ8lUA8v7vS6jYaEfyFJ5DBCwzQB62zdMbdIyjqCMpL9wxouBz7SsI/njh0PIU8eaJeFWSYrgOz5aqPur/IXa0z1C4X9+R00dDq0O4GyNYOijUc6Fj27KaYG7sQLvcpV6a9KexTLRG9a8+IY11n4Q9K4wppLbTW/dnbS8tsTVzxgo0/bWWq6Yopam3yHgLdFJPh7BVOF21PhUex3JfU3+dEwEPuHEKwQA4H4fbRuxEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lORNRjPqSLR7H+hNV9Fa54PXAD6DcfKjmHBvjs+r7rI=;
 b=LREyOwAEfErPO1sie0XtHEUv5vZ0YRuLf0Lwf2t9u9mndHmbeW0sj+jno7vLKIg3fG46j8BtsaZ7PAwcfeBs75iCJtswQJkfJwVAykABejTRRUcLm4mxwarjcbYKlbMhrsuGn5W4oWyvqOo2TcA0fibLRYw38tOBTtJhj8DJkU0j2MDjFEjMBgYmb5mRcCNDIYskzu/YhosqSjWzfIUEZuYKKnP+GhnkkF3W6G72r7xVg9bPKrUBuxxAqOtZpwF7KYk03gwtf7xzlF4J+BfOnYfl/aqDsH+pLqRUw1yLiL51rU3PKq443ihS4bSO4HDz07vBsoogAuU81tobyVYifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lORNRjPqSLR7H+hNV9Fa54PXAD6DcfKjmHBvjs+r7rI=;
 b=wvVpfOyK0yn/5wQRmcpGdw8hTKjdwk5SDob0fLuRIM83QyYoiyTKtaQR29wIovyQYah27dNFqH52pmfUVLYaTFxE0G5Od/pFnhSQivCcLteYE1aCCjjpqbApGpsW2vbB/REqHxDeYUl1thQv9lO9BvQEvQLwXwvnakI7RlcgWXE=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from CY4PR11MB2007.namprd11.prod.outlook.com (2603:10b6:903:30::7)
 by CY4PR11MB1766.namprd11.prod.outlook.com (2603:10b6:903:11a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 15:19:19 +0000
Received: from CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::d9e3:f5a3:ae25:3bf0]) by CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::d9e3:f5a3:ae25:3bf0%6]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 15:19:18 +0000
Date:   Fri, 26 Feb 2021 10:19:15 -0500
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Bruce Fields <bfields@redhat.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] Repair misuse of sv_lock in 5.10.16-rt30.
Message-ID: <20210226151915.GA2586@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <20210226143820.GA49043@zipoli.concurrent-rt.com>
 <YDkNFKmzb7rbumYf@pick.fieldses.org>
 <AA751435-2DB2-467F-B0EC-133BE62A8581@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AA751435-2DB2-467F-B0EC-133BE62A8581@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [12.220.59.2]
X-ClientProxiedBy: SN7PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:806:122::20) To CY4PR11MB2007.namprd11.prod.outlook.com
 (2603:10b6:903:30::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from zipoli.concurrent-rt.com (12.220.59.2) by SN7PR04CA0105.namprd04.prod.outlook.com (2603:10b6:806:122::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 15:19:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca5c7376-aafa-42ae-2212-08d8da69e2d5
X-MS-TrafficTypeDiagnostic: CY4PR11MB1766:
X-Microsoft-Antispam-PRVS: <CY4PR11MB1766341EB6CB9124E2B4C652A09D9@CY4PR11MB1766.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TKjctn60pMwvmJ1Pln65eci4rPYIOFcuuNz6qUpUj6b6KrIQi7kKLaJnwNRI6joUF47E27R8lU3tXCEHprmIsQyXbKpgu9+AA5IoHH3lZXy25YDO/xwHvfVZ9sUmwxPBdERveY6Z1oJd2HwUDwBUcgAam/hfvqTLH1XMHJUfjXqm0278l99pSDv/iCXgbW+1r4zhD+Nwp+3GWXVkSxlQKaA027qsiGHOJ0XA+YPmP+Fqj0mL08vX3+N/jbVWIqOBtLWd0wNt8F5cZ6DdKwWUqwmX3IUYnN0hP9YJPtH12ntisq6tVo7VzCijQ9U2zx+6SSw2+pDMlwsjPD4n+ah3A3RnXB5tY85zG6eTLdJYgCwAPLTqGWCGrG6dRVLZHLUrwsPJLwC/keNgbrEzEGSL2fP6vLKDV3OqZUfAgxsmqD41RN2KYCuwV4KtFUenrFHwcvg36vm1Xt/ZXo920Mp4Kn/8zA4GBvGFyUsJe+kGtN8OZDuIgqjQvueDY4hR7FZTMd2jaIiY9J8z41LKr+uWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB2007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(366004)(396003)(136003)(376002)(55016002)(66556008)(16526019)(186003)(53546011)(83380400001)(8936002)(4326008)(7696005)(8676002)(1076003)(3450700001)(6916009)(86362001)(66946007)(33656002)(2906002)(54906003)(478600001)(5660300002)(316002)(4744005)(956004)(52116002)(44832011)(66476007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iF+FHbi4HLLlSMZ54bZ0EFDD1jhvLnVMY1vjIh+877YJqp+B+CQHxMj5zMH8?=
 =?us-ascii?Q?XkzuVqElTAVabNCf6RHatw+I765avcNOCEQ1C/4x3LkoDLhaIMWDsXgH46QS?=
 =?us-ascii?Q?SHFCWoXnKOg0nsjZJK0LkfvNuBXE3mulkhhlpnQI3e+t7WODZfj1+FY1+0G+?=
 =?us-ascii?Q?EyLgcNfdgDRV9R5NQjflbXSmAmToF0UIHdmXY3YDzJEXm6QaoyqqOHaX2oRf?=
 =?us-ascii?Q?CXXA3wqzkRbS2ccvwg7k4bGxwd/DtL2eOWe/uKq/upVDw92djnB+g1SUxCOQ?=
 =?us-ascii?Q?PaLo8bT0ywhNUxValMVP1EyEX02e9+TxZfgwDUWUKKtGTAjoy5yoVNWeIk3N?=
 =?us-ascii?Q?01FrZSwCbMhgEwVyyUb6nuEU/+WwHJhhoL3YyQ+g0aENQB1Hwlp8kk0OfT4J?=
 =?us-ascii?Q?rWu45EEM+PN/XuKoT56zvQ9rcv2onC+e/UnyvUCuVMrrHdJS1TsADYA8K6yr?=
 =?us-ascii?Q?7JK0Rm7h0l8MBQtlf4SqEcwCSf6FYuULge2lyC2UAgyxFrt7FU3ojA9LLcWX?=
 =?us-ascii?Q?05gzfbeZq5i9xVnK1R+7sXdbHriRQE+ItKldCtLuNbfKMRp9Jwf8iykM1uGI?=
 =?us-ascii?Q?ArPyipxL3fV/32AsE2aLJAYdWRWhRM0inmoez3t/NRfmXvPr3w6Px5XB4auB?=
 =?us-ascii?Q?gHg9zemRbWmIaEMxxdZb+mw4bzho3PkvjpjOtWf3cMsQfJt/Ku4f7woGsnrb?=
 =?us-ascii?Q?GIJYGsoWoOc4nLyjOTsONDb5hhOtm87ct+eGEI+h2WmhToebkyEPYB03izyM?=
 =?us-ascii?Q?s73DaKGjqt3ygIaahVJgPg42OEGecnvufv8w2ByKf2cQ6btlSSkbzzv1cwJp?=
 =?us-ascii?Q?p0dB6HAK8gmWBaXDZIMbtojtCTC5T2ZamM3cURqT4ZwjxlF3TjyjTT+FBwbt?=
 =?us-ascii?Q?52V70q7f/ZUXrbjpjNoD1EXmEzGYod+ynz9r2PQ81TWk55bRiCBcNvHU9xsP?=
 =?us-ascii?Q?1ogqHjgjLbuxui08j47vmuMxIuX5JUT/TItSQgp9MeIAx/ljtg8GnHCY7p0c?=
 =?us-ascii?Q?LwX+LZJHrEEx3+dto6gU3RUPIB+XUMSFdphHgCLwdVuVJAglgGpx99d3OX0L?=
 =?us-ascii?Q?3iKtuoUssAQ8F9n/vvdfd6Vobx2RgZ8Tit/fi2rIy5Yxh54M7zf8Uw9mDfzJ?=
 =?us-ascii?Q?R8clekKHzVBbKlnNNyDc8IYCcFlExeJhEesmK42uYHKuwD/0rMTP2Zhp0KT+?=
 =?us-ascii?Q?g+FgBWcDqo80wbnGN3R3xE+S1E7YyUfsiz89LXIf4QGLTYnltVNNrOHCNOs1?=
 =?us-ascii?Q?5+IUEKmr0wtGPTSsXlkMp7A+AStTP7YseRFkLpp2IOcutMdJCa34rRljzje6?=
 =?us-ascii?Q?86qPiijBEWFxYiKJ9vb59rNm?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5c7376-aafa-42ae-2212-08d8da69e2d5
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB2007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 15:19:18.8293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EI/OtXrm72s4t3sZyOKTxV/eQ26Yj6NZaBCYJpi05FasfdmU8PoThueGEzeTtVGCkFEMDLikTT3RCBk07nPIEWHAQjUZL0mvFmePCs/m3YA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1766
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 26, 2021 at 03:15:46PM +0000, Chuck Lever wrote:
> 
> 
> > On Feb 26, 2021, at 10:00 AM, J. Bruce Fields <bfields@redhat.com> wrote:
> > 
> > Adding Chuck, linux-nfs.
> > 
> > Makes sense to me.--b.
> 
> Joe, I can add this to nfsd-5.12-rc. Would it be appropriate to add:
> 
> Fixes: 719f8bcc883e ("svcrpc: fix xpt_list traversal locking on shutdown")

Sure.
And thanks, everybody, for the quick response.
Joe
