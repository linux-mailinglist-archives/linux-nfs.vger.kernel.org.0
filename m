Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE127467646
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Dec 2021 12:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380436AbhLCL3M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Dec 2021 06:29:12 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47610 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380434AbhLCL3L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Dec 2021 06:29:11 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B39l0t6018020;
        Fri, 3 Dec 2021 11:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=akMr4xAvkcwfJtBxUazdjBwRlgmBplIxY0Xw/wKg1mw=;
 b=SLZpu4Kh4fmP12uMNhRCbeEsHupgwJoar6wSwJ2Gt8//ynAVnm7opH6woJWIl9Yt5VIB
 4o01MdnyG7EN8JoiBJsRPn4kI1WQPQjFcHf6eEYj1qdjJDqn3hFfwbbDbM/yfcxtBao6
 BFnziNgTjljQGMI5KJrJ8Wj5zB+JYxZF23q9kMCWmsRtFBaQTP6dYS9Z9J7zJg38xuKO
 IXuS/2lA2ayi+YXKwRsc5FhCpwt6s3zsdMSQzF7oBtFwYRZw9HcP/DkkEgdC7eqdumlh
 7RGJoYfv1gZ6SqVi40XOamNApAaovBuBgydUTDCqjZOZplUfooBLgSC5HTH1rhKhXKg3 +A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cqgwmgdty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 11:25:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B3BMRfk037236;
        Fri, 3 Dec 2021 11:25:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3020.oracle.com with ESMTP id 3cke4w3kkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 11:25:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYhmETKJQ+8u5RNQkln/XkNTPSNx8yqqm+uFkSFM3KRWD7Oy9ih9TdnbGWZzTvlcnmqVQdT/33Jr0TbH/hg9gZzv4g12GmSnIEuG1uv6OOr7Jvj6SP3whqPTZVBJ1yBdfphe/2y23yNA9q5NM85gHM3ZP+zdC6c0b/gtCWIBjRPyR96Yfmcx4PpMU84VMR5XZpWpenl4qy/cPxK9MQmej8O9YTdtJH8U/CrIwzQVk7cPePh1VTY7NOgyxuVcO6TrvaU118Kg4O7YzQ9mnasoNxMMcX14xolppTsn5uMTN3SPyl2t+kFJLWsaPTPVZXn1dibTe4ru3JnwSUd8tmMfLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akMr4xAvkcwfJtBxUazdjBwRlgmBplIxY0Xw/wKg1mw=;
 b=Zm7bBRXvelWyYsRWQS0o/jt0hqjXVc81qXo112DszEkHA5QAAOaleDXHOA5oP/wE1Qa5ivqP1X1jagcLs4R9/J6EVpE++drBYz7JCv6Xd6EiHOfX/F5smUkXEhGmeWGqSTogf1NIQAaF8q/8XQUtmR0eRk60xyyfI1BVOj2rGmFlfueOduw7/tbbhGBQxW1W+EUg8QQIEQp74azeFL/mC4yrtue9jThKzgA5IKtBfndYw56y/smmftKOYH/u1RMCu7a0H6SDzGRJIQouh+dgVkwwjzp4Jbb3W6/XKgyrBC4jecjnqbJrX4oYNZPFYX4NYAbeXvrXAdlVgmM8Hr/pCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akMr4xAvkcwfJtBxUazdjBwRlgmBplIxY0Xw/wKg1mw=;
 b=FyUQrkS+x5s2Uy0tsAQdgI5V4hi4esQqWSSyhE2rZA+i2+oISulAjX12PrKgcmxxz5t9jRzU8/2IicdNlXVid2Ho2qVhjdbQuL/OxugoxChziztX4RO4vyvE3IReYtpRr2gksoMwJbkEXb5bwtHaUwH0lv5iZRPUCBhAZ5SYvPA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1486.namprd10.prod.outlook.com
 (2603:10b6:300:24::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Fri, 3 Dec
 2021 11:25:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.027; Fri, 3 Dec 2021
 11:25:26 +0000
Date:   Fri, 3 Dec 2021 14:25:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, Neil Brown <neilb@suse.de>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] NFSD: make symbol 'nfsd_notifier_lock' static
Message-ID: <20211203112505.GI9522@kadam>
References: <20211130113436.1770168-1-weiyongjun1@huawei.com>
 <888F3743-AB98-41A6-9651-EFDE5987AA01@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <888F3743-AB98-41A6-9651-EFDE5987AA01@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0059.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0059.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Fri, 3 Dec 2021 11:25:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25304bc6-1f8b-4e99-48e6-08d9b64f9a48
X-MS-TrafficTypeDiagnostic: MWHPR10MB1486:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1486EC91E193A074F6D315938E6A9@MWHPR10MB1486.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACBMbzSkbIC0x3Q18PGUIKgP+adGgRxyDjCmqdnVHO+/UjT8kmzNgLdmGOP17M7ZLrrpxl1yyP9HIghVupLfPr0t8I1BeQrz76i938eZ7D3mkicf7NXScSSF73UwYd8sY80GHTEzR7uo+AYCz3YCh7GhOesMvA6B8qL5S+HWewozB1E/r0bXrr+eZrtcxOO8DZicQIKuXbKI4+fOAO0/iRi1F5mJVyiKiitVGpd318oCbUtBk4MisnI5Z4jABMWvwXiCBUNuB2+NhNNrNsL0P+vmizHC502ggBwX8id71focfIBakwJqpK6u4v1IiyFGsKiG1JyoBTGAAuZP5I1/i4W0cPsc+NCjXuRJ0SgPAM6nM9SnQ2LcHrO8sLiHBh7KH2iLUR2mjj8Q7iN3ivfnvIn3D4fTb3LoLec02mO1MJPqSROQEzq+ZGjKPm2+QGcwnIjmV2meziHPpl4fQe48CMbPcirysQulglUkLSh1yvuLeLvBouY5qB8w86ShZNs4s3QBol8sIPvq1uy1xXH+omi+U+un1ZrBkB1lT5HByWN8AcqwIJHKMSSO4VBw0No1JmbiGYpXe5uUvuPr5wQft/zNfr3oHMEhgxdnD+nMTnpiKX4KKNbyKTKdMLU87rYavLZIU4umFuaU3P4kMWa4LEJqykdC6j+dbrJKCAMT/b3SHgvstrz9K/B7T9UwzrjVAiMtF/42JPT3eMuBx+IA/L/uCCWTbe9NOn0w5uAACy6qZuVlgWD1Dwh0Do/R9vZPzJ8MOGLF8s1X2rHGTI2k6a7Jww5c16M0paWisU/TRzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(6636002)(26005)(33716001)(55016003)(966005)(54906003)(956004)(9686003)(6496006)(52116002)(1076003)(83380400001)(316002)(8936002)(5660300002)(508600001)(8676002)(44832011)(6666004)(38350700002)(38100700002)(186003)(86362001)(6862004)(66946007)(33656002)(66556008)(4326008)(66476007)(9576002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dIx12IXUXM7It4tr+rBXv+0x+tBs81YdrkVkdy8myxKnJMGQnjyZdS8kzDjQ?=
 =?us-ascii?Q?wvp2sJTglLgK5pycDhlKVWirRL1Is2Ou3nCaWkRkI8PU5JuIaho25+qFlD2q?=
 =?us-ascii?Q?738YchM3lT/rQCF80u9pR+KVpX4BMgGMaNzYlhjyoa/K0wSAhkG47Xx07x9v?=
 =?us-ascii?Q?dwtKOciz6i3y8ueWhBf1Wkzvou5XjggW/T/wJ8JoCZxv3tyIVCyGSQ/eMar4?=
 =?us-ascii?Q?pgI2MkWLfNZz6P1ey5wFPRkqbv+bjy+W2hXwsLJ3EJV5YUCQSdw/0x1NQU/c?=
 =?us-ascii?Q?MRVUZ+wkHktxyAPQCUOLV9tbqE09MgGft+5TPwC9AB6CNZ5K5LcCjV1/Uu/f?=
 =?us-ascii?Q?/KIlY/hANCh2r637/fr5Q0xRFEwW0kvSzTDQt56ypSl0iSOcHKUar6vLiH4x?=
 =?us-ascii?Q?uRVJCG52yqXpEDbeuzmUofVVPEj3GgA7u1k37RrkWz66golyPcfv+r9UCTAZ?=
 =?us-ascii?Q?Nzn1Zlzy2VdP6h9aUMXdloYQuB5rAT3NICGIfgNU9ZYlDIMltqqBbkgBnMtp?=
 =?us-ascii?Q?LsHVh0RUq6OCAfZ6l5jZQjENG5lPDNwWcTrHuPHeKmaUPv+WZtGjB6KjfV3m?=
 =?us-ascii?Q?M+x8P9J8uCFBAzw2uhodIkljSdYHgS7BwhFR9Rc19e4NNQ3/aw46iCNFrIrv?=
 =?us-ascii?Q?0FxM4TfFEvrU+WcnMR0/pF2pwuWIo+TXMC4CaU9qw4OQCNm9dhfYpV2vzWax?=
 =?us-ascii?Q?z/OA3knHJRz18nn7x9vAOkTEAn0lnYQMGcgnl7TphEYb/bvcofgiIn7Hx/Yl?=
 =?us-ascii?Q?+M3uMB/6NXsHCZEJ1dT9RN4btjIE3iv9LGDsDfWNDtWCsAfeoRF6GI1uDYrU?=
 =?us-ascii?Q?HUL2qLJY7vLkEwhDUH+BLDhpB756FHvrJ5Do394ruPcP8HtmxCaXOYHaTdfT?=
 =?us-ascii?Q?hnrzHTsW+qKRwzoyMcAxmzYQvpG6MVkiJlyM5t51bX/RKTe+jzp6gDNyycJz?=
 =?us-ascii?Q?g6t7L39g3tXBMrGq10EI/LNEVnDEBuqBauhbSRXs6uXV4a3Olux4lMtx0Ykq?=
 =?us-ascii?Q?vWWSSoS0GuQGE8JqRkmbVFiJDHgbOYTI9G6pcnF/frNo9jXPExtJails0mdJ?=
 =?us-ascii?Q?dnW9Zkj6yL+FGCxCKKB2/Pj35vLcrdZimot+ANkfpknUk2pXGjjVdGnMYKqK?=
 =?us-ascii?Q?XP0XvDmcgJhIEBUS6OkTyRbF/xUOV+dpBrIe7KGdaHochKGBi5xEicgo6u0v?=
 =?us-ascii?Q?oWpgK0/lSugqKNn1rXMMf8pN8kiOAzpQ2XPA+I5FD0IqLcojGm1FrpE1YQRR?=
 =?us-ascii?Q?3amfDNwMtO05tcF6GEopPa4seqP1twRPZe8Bf+Cf4gnJQ2Dk8hRpgRk65Nqj?=
 =?us-ascii?Q?iDpxYtSfdsiX3hrqnJ6WmdHVbdcvN9uJixH2h5FWa7uvmo7xiSvekd5wLSbR?=
 =?us-ascii?Q?OQwxNd6HxmIbh/H0bk9hskuFfLSJ9A3qNhjfM/zBg9jm9/qYMLIkQtyt0Lwh?=
 =?us-ascii?Q?SgRD9XsMl1s4YajElR2K1tbMe6J9bEyVHdVYV/MdjRozIq61K+IRGyZhPg8A?=
 =?us-ascii?Q?isll7B7gAOPApbgDa6JjqsYdCkkn8mtspnAPCOcmoFkzt7hiugo2vZObLb0k?=
 =?us-ascii?Q?+y0MFtBNarrcYGRxzupJXkCCsLgZPgTXeOBoct1Q+kHLF1nEu9CNavoZDmm6?=
 =?us-ascii?Q?VmFnmLklVOBVumCA4mLHASD5+6i6e7pa7SqftJOFIxK0bBxRMTdwbvH2nOHy?=
 =?us-ascii?Q?qbudzxU5igp9jxxqiT7Ot1K4wzQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25304bc6-1f8b-4e99-48e6-08d9b64f9a48
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 11:25:26.1803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvMVHIHonuURlzKx03fatmNO7gMCFdOA1jh+GC4EPA1U9ZApyxPg2iWrI8ZF8djuWwFSsIdMxsBdXIgWkO7iF9LvUwbwzj53fgrn6oFfYRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1486
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10186 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030068
X-Proofpoint-GUID: ECRV5JVDBJNvRDLipmrhAx2HvYwubcTa
X-Proofpoint-ORIG-GUID: ECRV5JVDBJNvRDLipmrhAx2HvYwubcTa
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 30, 2021 at 08:19:47PM +0000, Chuck Lever III wrote:
> > 
> > -DEFINE_SPINLOCK(nfsd_notifier_lock);
> > +static DEFINE_SPINLOCK(nfsd_notifier_lock);
> > static int nfsd_inetaddr_event(struct notifier_block *this, unsigned long event,
> > 	void *ptr)
> > {
> > 
> 
> Thanks! This was pushed to the tip of the for-next branch at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> 
> I removed the Fixes: line because a backport is unnecessary, and
> the commit ID is not yet permanent.

Removing the tag, makes it more complicated for backporters.  Before
they could tell automatically from the Fixes tag that backporting was
not necessary.

On the other hand, does this patch really need a Fixes tag since it's
not a runtime bug?  Different maintainers take different sides in that
argument.

If the patch needed a fixes tag then a lot of maintainers have scripts
to update the tag during a rebase.  There are also automated tool run on
linux-next which emails a warning when the Fixes tags point to an
invalid hash.

regards,
dan carpenter

