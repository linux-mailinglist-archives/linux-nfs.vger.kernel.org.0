Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE9677E5B8
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Aug 2023 17:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjHPP4z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Aug 2023 11:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344377AbjHPP4v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Aug 2023 11:56:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC7CE2
        for <linux-nfs@vger.kernel.org>; Wed, 16 Aug 2023 08:56:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GFnpVN008563;
        Wed, 16 Aug 2023 15:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=pg6XyyjRhDHJg+JvUuCd8gcxjlwxQoq7UAQ1i4g7JII=;
 b=iXTjzOTbU3XfG4wttRSa97m6HhumcIWwEvWqhZe6H0Uj6yJ4dslmYmHAf0Vo13Uq1srU
 2N+aP2FN2ajlerw8GkhWCNtyet9sz2MrM5w870v6kDTUO8G/sAnxkhVKd3ym0m7MKujk
 rIq7e+FqcoWLtmTeY5w17Tp8gW51SAp0xM9ASYtQfSZS4alDD/ua3OKNQuCu4gGk2Cnw
 uNqo/Em7y8U77SF2NSfO/ulDNjhLUvdNqT3Pc9CEYaB7uwRCET7/AnE7Nw9d/6yVLmah
 qumPbSrsA7Ci41CxQ5kM2MTOslWBrDssmKIX3/jNt6uOBOTvkY7ETifwCX49kIXIZX8p fg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se349ffbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 15:56:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37GFe4db019884;
        Wed, 16 Aug 2023 15:56:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3wxbwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 15:56:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEvwNpWx5Wl4Rv02NkDBn2tgQ4He7Fqoy8cy7TdMJIn/mCkVqA8bzZ5VZF0hmVRbdkgiDPE9OVtv/RkyaJFf8sA9k9nBOHjFFp9p5e6CU7PPY6fuJfFklO5Ryf4dh55wpvf1Lh1LS2DU4NezGmtnfhgJUh9t4XkToiphVgE6RMevoJByvYkdf4HsDw2+EnxMRGWW8P9eH/3xlpdg6jYNtBzyp8yAEYERtnsoatURv/J/jjNhkS/wheeZDQ7alTlQbaQCxcSIfGVuNaE5S5dguMgk5kodmvo3CuzPZuDnc8a15uKlR3384EmQAhU4PSZFMiBJ7Zq386kWZyIdoKNnkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pg6XyyjRhDHJg+JvUuCd8gcxjlwxQoq7UAQ1i4g7JII=;
 b=Lq4cn8A8LcPkuk4uWzkaQfoyndsFEVrdgb+P14f6ftOF8dGk0eBTGVXkLEJSkuCB1ffU9mXg0j8M75pu0WRZbcJBhEvRIDx9fzL/ws6Xa9CgOwfsFkyus+aTd7jPrXsSAKr54ZuOIMo0Ux0rer4YF6vuivzoUOI+WfDBXfN67eiw3xCnscOb8euFr8nvHCJfAizJhR5XmoMSlecHVAAxUE97cHQsK9qCf5tHpv1SG4f75/pCH6wsk6BvbfLK+Hdww/SKBIOCKbp8Y2wb8LG5BJE3GBHf8KO4xFQ/diu9wRdsMe7DnLCMVuS6qiM+SEcR8boncbpG9MkML18D9//+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg6XyyjRhDHJg+JvUuCd8gcxjlwxQoq7UAQ1i4g7JII=;
 b=cFfmigoIeZCZZplFbn7Uwm3uISbaUKrDzPe1fvVKAYm48Z7U+465Iq70IiZE7h9ADjqWz3QA0wNscTXCqhd/WaIWpGdMIFvYm3WmrOZD2eiQhUQNzAsVNeIbV2QkH5uZNDUuV3MCywDgWKc4KwNXcQfLNwI2DmUaWq1ulRoQcTk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5858.namprd10.prod.outlook.com (2603:10b6:a03:421::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Wed, 16 Aug
 2023 15:56:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 15:56:39 +0000
Date:   Wed, 16 Aug 2023 11:56:35 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 04/10] SUNRPC: change service idle list to be an llist
Message-ID: <ZNzxsz2jh1Mwp3ng@tissot.1015granger.net>
References: <20230815015426.5091-1-neilb@suse.de>
 <20230815015426.5091-5-neilb@suse.de>
 <ZNuu6VaU8XzYuEQj@tissot.1015granger.net>
 <169213947940.11073.14765809649639298670@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169213947940.11073.14765809649639298670@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR18CA0057.namprd18.prod.outlook.com
 (2603:10b6:610:55::37) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d1ac4c-9172-4253-845a-08db9e716085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NtGlqM0GmdspUi02jpGRHAfcZBDN592ZGnRRxaewgMOnXs20ZwQMIMbfjjVpaG2hNBU9pnBqeSm55rv4mnJE4gP+Fh9luKHPoq8F+xaC0QW1bMfac3YIHUbnXAVv3rmUUjpQOA6c9tyFClCC9kx3w0qt0u2DXkU85azIdKzMCt7J8mRhy3pd4IkULQixWF1OexlnP86lc3N9c5T3nFUREUC5iQdRQvsgGZySShfmjCOPM1i6rRrowdg0kCS+8obz+p7Dm9mVD9iwnh8B72gGxgTOwwhlsneLzHN4ZKsIEVTRNO+/rXF5nYPq2XDZySZd0fhSpONgv5ngXUEORfPWe797vHzzhSXjX78kiGDMg3pfHZhE99pr7lsQFFdRniHLrehVpguvcL13nks0zBl2ijVThHHNxQ+Vv6eizAshZ4I+osqVVn0p9ezzs7XtKMarddHX1v/gPaSfWr6L5bgRtXXFFuqiRqOxscJHu1O7W/qu2vLTy6LaQuFWU9Wufjc9CUjPte/ipElCw/P0EThgi5OuK+oThrbvixrHuhatCzhqcYy4Fa7zvpE/RHpTB4k8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38100700002)(8676002)(4326008)(8936002)(30864003)(2906002)(83380400001)(26005)(478600001)(86362001)(9686003)(6512007)(45080400002)(6506007)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pkp+wJ7QVmptpbumwhP2Duh84xGwF+yMFd47iD73nkMDj7s9wMMGm+lE5Ba9?=
 =?us-ascii?Q?9NB2UdEy1kFTby3wpVDwWMd/IeiF5mR3OfWLk1tCbddKIdqFkACJXrmXQWrv?=
 =?us-ascii?Q?u1fMBhlREKktzTlcfZ0SBtAeg3j/67Q57xqjfj3b0w7LdqcBgqLVb+Bbgw3y?=
 =?us-ascii?Q?IPqToaxWEaDis/1+RQ/zm9CRX0UvYZdX6GzdB1nZy6VoGVyVOhzgB5uhhCaE?=
 =?us-ascii?Q?LSCUM0ZElgZ7dBCz/QebQTu+lISM+unSEP5ZIYMj3kHpNhOf36958C0TkZUT?=
 =?us-ascii?Q?Sw/MyS37YteYViBTdiUWKg5WNZhOnmIc6RH0+S5Jcxp+R8jxgPHe4uq5PCew?=
 =?us-ascii?Q?XEps1sLThz5ZRHeiSPvd0cdpErOXSG+LqOrXpZAsHq1O+TK7fEh+Kj/JbEp9?=
 =?us-ascii?Q?/CKKiF5Z85fGH8N2fNLqbuH1m2t6gNoqEgqiq2vdN5zyjlilR8ld9/gwdQMx?=
 =?us-ascii?Q?ZnLdoyQbEnM8QxQ/TKNnDDWJNQ/DVR0tJAygdaQA9aevL3WUbYqty+nXXR9a?=
 =?us-ascii?Q?Z7LouH7KlKQyh3ZcjzRMSpn3NjuigPfu9xqZKMjF5oum2bWTskgejeS00CRo?=
 =?us-ascii?Q?NOUx1G1SBzFdbDRaN42vHF7VW+4f4b7Z2j6OqA+whH886nRGW3K4/2DWEhrq?=
 =?us-ascii?Q?TLb7viMbCCP7U9LHyITjaB3BDJMybhTmD4mZetFIPaq3F2VbkCl4G11i88RN?=
 =?us-ascii?Q?7pYv0u5izLlb38MkMKNLEqACK4vhQBOsDSCk7jHq7X7fF981TiRuYBJ0jJsL?=
 =?us-ascii?Q?8lMoPrLT5ATLyp7VOk/uzSSgX3DRZgENYi+IRXSAES7pl64ibNJZUrUC702J?=
 =?us-ascii?Q?JRtg+aJKCv+d4hJj69SQhdeQuPr6R4+IYCQCSA/2odLvM3ihwiHS2Y5h5SW+?=
 =?us-ascii?Q?dJQvUiYVsV1duXso03PwvB6o/u+zGIqMDgRa5xhK5GipkbZoznXau/NNBDTJ?=
 =?us-ascii?Q?b66tCPG9ijxyaNXuDUFqoNOxl7WnBT19vMaWN/RoPyTVisI9eZRQq/XUdeOC?=
 =?us-ascii?Q?fgbjsnegXrdwivhHeCYLm2cz6Dk2YaZ4rPqlzsXXgl6a+SoiajT1uru4mJ0A?=
 =?us-ascii?Q?XPqg/Y0zY640kKDPxchIBYtf3k9E2B1ZF0/BexE/bz4iqe5ZTy2rfXlMDlwo?=
 =?us-ascii?Q?+rqimhQi2tm8IfPTpnmpV1OUNZphMK6Egc0Frb8zkNRNTTytGNjF9WicypPk?=
 =?us-ascii?Q?7jQ70Bee/q0Ck7llLktObJMWiIO4Dd5qEcl8EwY27XLmpRnnC7Vue7VYgFh1?=
 =?us-ascii?Q?AD08Z51rhG6KIjRhdpgbWp7AX8UdD8pK+NoqyTi0W17R6wrs+tcp21xkI39t?=
 =?us-ascii?Q?XQ5daCr34Ck85PxNeC9tRy/0o9DUiPX3U5AKoIyCREo50BNODCHGlifrYt8A?=
 =?us-ascii?Q?789k1mrqWwQwlsq3TaslUdS4jQs70AZfJnE4w+G5Iy3D3wKwBgUBIaGI6vRw?=
 =?us-ascii?Q?TnBxwLOUwi6EWA2672PgMSB2TlJlCj3CnaFdtMJhukWlfzATDFkFA5iA8xPv?=
 =?us-ascii?Q?W0UXiQKxN8yffaDcDPRB+TPpHfba7FT9GA7fqIVRGI5bjCY+SKD2ttfIz+xY?=
 =?us-ascii?Q?1Lm7QcTehGmvYEUhq8++V/VkhykB11cG7ucQEP5FIjgHSZe2xBr5PYND5P/9?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9WCtxQRVjNhyEZbmw38urc1r79nK2AR7gAPdMbf+d9oc3Qwfpuoh5T28/eHDtqbxSxKeL0uN8SaFpGlsR+X03n2RBo4KzXNG3QnO7EpeBCzvetT8a/tg3a3DHxbRimz8Y2rOYTe1Vbjn3jW7Tr9AR8lrB4sN0ohrGJ6+Hg73hmJjtnLGFifG0I/7NPAp50lmJjUShWRMCOglgf4dtnaoacAOSj9VtP7KtzIV+kabZyLo/ZsBiLDfCtv5My3kZrmuJACDlk7KcO7gnhrT042+irTXqp2jwX9pksv73pi3jM/GgmlaV12ZGQT/gYgX4ihycOmn7QkfqQdbT5c+f79xAmgR1YXyE7pu6Wn89Xz+T6FHvYUA2FJV2SZZGZ50TL9edubco/waqGPumPLiHlhK/xDnF8EPmHFmm918AgghRU+viWghN+kZaGQICpgJ9S6aZduQc7baJF2claUxdncMGCMRqdHdB/5bBrYRfU1M2Hy5muVnHqXnJn9GzxpVNVLDXnpReTmbss/KQkCWxHBHrffZUd2IbIpuZ19hzG7KqDO8rgQOKf+ObtNMrDa8aAeXgGhifffOjg/SciWabpQxU4qBJoIs4rKyNxvGIsvx3dqvMKWG2hklDqugvuCkUM0BZuPuMGyJwXAtrpsWeyFNBQp9rvKT8BKNGSgix+j28R0b39ggZOl6M2/sC2lrs0oyEA5sxc31T0oEVEaKAl1taZ9ss7Tt73TmN8HGzZsS1Wj2xNd0ZXf7YwshXTG7WLKnUUq900xtxcI8NnIJ34na9jn1xJE3vOQXFiMY4nJ4CKJotJpNLrbLa/zhOjIIXoKp
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d1ac4c-9172-4253-845a-08db9e716085
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 15:56:39.2653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BM9JuaCXG46+RqUSGOK5eyP7pDwNvOyWfrHChe35IvjP4fgOjFvnUaldIzIljCZP5Yyg/s4vv/Xl1Ym7rbppyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_15,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=864
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160137
X-Proofpoint-GUID: ZMXJNb6Vv1HVFTDF2pu0MvjJrru-lGvC
X-Proofpoint-ORIG-GUID: ZMXJNb6Vv1HVFTDF2pu0MvjJrru-lGvC
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 16, 2023 at 08:44:39AM +1000, NeilBrown wrote:
> On Wed, 16 Aug 2023, Chuck Lever wrote:
> > On Tue, Aug 15, 2023 at 11:54:20AM +1000, NeilBrown wrote:
> > > With an llist we don't need to take a lock to add a thread to the list,
> > > though we still need a lock to remove it.  That will go in the next
> > > patch.
> > > 
> > > Unlike double-linked lists, a thread cannot reliably remove itself from
> > > the list.  Only the first thread can be removed, and that can change
> > > asynchronously.  So some care is needed.
> > > 
> > > We already check if there is pending work to do, so we are unlikely to
> > > add ourselves to the idle list and then want to remove ourselves again.
> > > 
> > > If we DO find something needs to be done after adding ourselves to the
> > > list, we simply wake up the first thread on the list.  If that was us,
> > > we successfully removed ourselves and can continue.  If it was some
> > > other thread, they will do the work that needs to be done.  We can
> > > safely sleep until woken.
> > > 
> > > We also remove the test on freezing() from rqst_should_sleep().  Instead
> > > we always try_to_freeze() before scheduling, which is needed as we now
> > > schedule() in a loop waiting to be removed from the idle queue.
> > > 
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  include/linux/sunrpc/svc.h | 14 ++++++-----
> > >  net/sunrpc/svc.c           | 13 +++++-----
> > >  net/sunrpc/svc_xprt.c      | 50 +++++++++++++++++++-------------------
> > >  3 files changed, 40 insertions(+), 37 deletions(-)
> > > 
> > > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > > index 22b3018ebf62..5216f95411e3 100644
> > > --- a/include/linux/sunrpc/svc.h
> > > +++ b/include/linux/sunrpc/svc.h
> > > @@ -37,7 +37,7 @@ struct svc_pool {
> > >  	struct list_head	sp_sockets;	/* pending sockets */
> > >  	unsigned int		sp_nrthreads;	/* # of threads in pool */
> > >  	struct list_head	sp_all_threads;	/* all server threads */
> > > -	struct list_head	sp_idle_threads; /* idle server threads */
> > > +	struct llist_head	sp_idle_threads; /* idle server threads */
> > >  
> > >  	/* statistics on pool operation */
> > >  	struct percpu_counter	sp_messages_arrived;
> > > @@ -186,7 +186,7 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
> > >   */
> > >  struct svc_rqst {
> > >  	struct list_head	rq_all;		/* all threads list */
> > > -	struct list_head	rq_idle;	/* On the idle list */
> > > +	struct llist_node	rq_idle;	/* On the idle list */
> > >  	struct rcu_head		rq_rcu_head;	/* for RCU deferred kfree */
> > >  	struct svc_xprt *	rq_xprt;	/* transport ptr */
> > >  
> > > @@ -270,22 +270,24 @@ enum {
> > >   * svc_thread_set_busy - mark a thread as busy
> > >   * @rqstp: the thread which is now busy
> > >   *
> > > - * If rq_idle is "empty", the thread must be busy.
> > > + * By convention a thread is busy if rq_idle.next points to rq_idle.
> > > + * This ensures it is not on the idle list.
> > >   */
> > >  static inline void svc_thread_set_busy(struct svc_rqst *rqstp)
> > >  {
> > > -	INIT_LIST_HEAD(&rqstp->rq_idle);
> > > +	rqstp->rq_idle.next = &rqstp->rq_idle;
> > >  }
> > >  
> > >  /**
> > >   * svc_thread_busy - check if a thread as busy
> > >   * @rqstp: the thread which might be busy
> > >   *
> > > - * If rq_idle is "empty", the thread must be busy.
> > > + * By convention a thread is busy if rq_idle.next points to rq_idle.
> > > + * This ensures it is not on the idle list.
> > >   */
> > >  static inline bool svc_thread_busy(struct svc_rqst *rqstp)
> > >  {
> > > -	return list_empty(&rqstp->rq_idle);
> > > +	return rqstp->rq_idle.next == &rqstp->rq_idle;
> > >  }
> > >  
> > >  #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
> > > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > > index 051f08c48418..addbf28ea50a 100644
> > > --- a/net/sunrpc/svc.c
> > > +++ b/net/sunrpc/svc.c
> > > @@ -510,7 +510,7 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
> > >  		pool->sp_id = i;
> > >  		INIT_LIST_HEAD(&pool->sp_sockets);
> > >  		INIT_LIST_HEAD(&pool->sp_all_threads);
> > > -		INIT_LIST_HEAD(&pool->sp_idle_threads);
> > > +		init_llist_head(&pool->sp_idle_threads);
> > >  		spin_lock_init(&pool->sp_lock);
> > >  
> > >  		percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
> > > @@ -701,15 +701,16 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
> > >  void svc_pool_wake_idle_thread(struct svc_pool *pool)
> > >  {
> > >  	struct svc_rqst	*rqstp;
> > > +	struct llist_node *ln;
> > >  
> > >  	rcu_read_lock();
> > >  	spin_lock_bh(&pool->sp_lock);
> > > -	rqstp = list_first_entry_or_null(&pool->sp_idle_threads,
> > > -					 struct svc_rqst, rq_idle);
> > > -	if (rqstp)
> > > -		list_del_init(&rqstp->rq_idle);
> > > +	ln = llist_del_first(&pool->sp_idle_threads);
> > >  	spin_unlock_bh(&pool->sp_lock);
> > > -	if (rqstp) {
> > > +	if (ln) {
> > > +		rqstp = llist_entry(ln, struct svc_rqst, rq_idle);
> > > +		svc_thread_set_busy(rqstp);
> > > +
> > >  		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
> > >  		wake_up_process(rqstp->rq_task);
> > >  		rcu_read_unlock();
> > > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > > index fa0d854a5596..7cb71effda0b 100644
> > > --- a/net/sunrpc/svc_xprt.c
> > > +++ b/net/sunrpc/svc_xprt.c
> > > @@ -715,10 +715,6 @@ rqst_should_sleep(struct svc_rqst *rqstp)
> > >  	if (svc_thread_should_stop(rqstp))
> > >  		return false;
> > >  
> > > -	/* are we freezing? */
> > > -	if (freezing(current))
> > > -		return false;
> > > -
> > >  #if defined(CONFIG_SUNRPC_BACKCHANNEL)
> > >  	if (svc_is_backchannel(rqstp)) {
> > >  		if (!list_empty(&rqstp->rq_server->sv_cb_list))
> > > @@ -735,29 +731,32 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
> > >  
> > >  	if (rqst_should_sleep(rqstp)) {
> > >  		set_current_state(TASK_IDLE);
> > > -		spin_lock_bh(&pool->sp_lock);
> > > -		list_add(&rqstp->rq_idle, &pool->sp_idle_threads);
> > > -		spin_unlock_bh(&pool->sp_lock);
> > > +		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
> > > +
> > > +		if (unlikely(!rqst_should_sleep(rqstp)))
> > > +			/* maybe there were no idle threads when some work
> > > +			 * became ready and so nothing was woken.  We've just
> > > +			 * become idle so someone can to the work - maybe us.
> > > +			 * But we cannot reliably remove ourselves from the
> > > +			 * idle list - we can only remove the first task which
> > > +			 * might be us, and might not.
> > > +			 * So remove and wake it, then schedule().  If it was
> > > +			 * us, we won't sleep.  If it is some other thread, they
> > > +			 * will do the work.
> > > +			 */
> > > +			svc_pool_wake_idle_thread(pool);
> > >  
> > > -		/* Need to check should_sleep() again after
> > > -		 * setting task state in case a wakeup happened
> > > -		 * between testing and setting.
> > > +		/* We mustn't continue while on the idle list, and we
> > > +		 * cannot remove outselves reliably.  The only "work"
> > > +		 * we can do while on the idle list is to freeze.
> > > +		 * So loop until someone removes us
> > >  		 */
> > > -		if (rqst_should_sleep(rqstp)) {
> > > +		while (!svc_thread_busy(rqstp)) {
> > > +			try_to_freeze();
> > 
> > For testing, I've applied up to this patch. When nfsd is started
> > I now get this splat:
> > 
> > do not call blocking ops when !TASK_RUNNING; state=402 set at [<000000001e3d6995>] svc_recv+0x40/0x252 [sunrpc]
> 
> Thanks.  I didn't have the right CONFIG options to trigger that warning.
> I do now.
> I'm not surprised I got something wrong with freezing.  I did some
> research and now I see the part of freezing that I was missing.
> This incremental patch
> 
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 7cb71effda0b..81327001e074 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -730,7 +730,7 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
>  	struct svc_pool *pool = rqstp->rq_pool;
>  
>  	if (rqst_should_sleep(rqstp)) {
> -		set_current_state(TASK_IDLE);
> +		set_current_state(TASK_IDLE | TASK_FREEZABLE);
>  		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
>  
>  		if (unlikely(!rqst_should_sleep(rqstp)))
> @@ -752,9 +752,8 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
>  		 * So loop until someone removes us
>  		 */
>  		while (!svc_thread_busy(rqstp)) {
> -			try_to_freeze();
>  			schedule();
> -			set_current_state(TASK_IDLE);
> +			set_current_state(TASK_IDLE | TASK_FREEZABLE);
>  		}
>  		__set_current_state(TASK_RUNNING);
>  	} else {
> 
> 
> fixes that issue.

Confirmed.


> "TASK_FREEZABLE" was the missing bit.  I'll need to
> look back at the other patches and probably introduce this earlier.

Also, it makes subsequent patches fail to apply. Can you send an
updated series?


> > WARNING: CPU: 3 PID: 1228 at kernel/sched/core.c:10112 __might_sleep+0x52/0x6a
> > Modules linked in: 8021q garp stp mrp llc rfkill rpcrdma rdma_ucm ib_srpt ib_isert iscsi_target_mod snd_hda_codec_realtek target_core_mod intel>
> > CPU: 3 PID: 1228 Comm: lockd Not tainted 6.5.0-rc6-00060-gd10a6b1ad2a1 #1
> > Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.0b 06/12/2017
> > RIP: 0010:__might_sleep+0x52/0x6a
> > Code: 00 00 74 28 80 3d 45 40 d5 01 00 75 1f 48 8b 90 f0 1a 00 00 48 c7 c7 b3 d6 49 9b c6 05 2e 40 d5 01 01 48 89 d1 e8 e6 a2 fc ff <0f> 0b 44 >
> > RSP: 0018:ffffb3e3836abe68 EFLAGS: 00010286
> > RAX: 000000000000006f RBX: ffffffffc0c20599 RCX: 0000000000000027
> > RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: 0000000000000001
> > RBP: ffffb3e3836abe78 R08: 0000000000000000 R09: ffffb3e380e70020
> > R10: 0000000000000000 R11: ffffa0ae94aa4c00 R12: 0000000000000035
> > R13: ffffa0ae94bfa040 R14: ffffa0ae9e85c010 R15: ffffa0ae94bfa040
> > FS:  0000000000000000(0000) GS:ffffa0bdbfd80000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f59c2611760 CR3: 000000069ec34006 CR4: 00000000003706e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  ? show_regs+0x5d/0x64
> >  ? __might_sleep+0x52/0x6a
> >  ? __warn+0xab/0x132
> >  ? report_bug+0xd0/0x144
> >  ? __might_sleep+0x52/0x6a
> >  ? handle_bug+0x45/0x74
> >  ? exc_invalid_op+0x18/0x68
> >  ? asm_exc_invalid_op+0x1b/0x20
> >  ? __might_sleep+0x52/0x6a
> >  ? __might_sleep+0x52/0x6a
> >  try_to_freeze.isra.0+0x15/0x3d [sunrpc]
> >  svc_recv+0x97/0x252 [sunrpc]
> >  ? __pfx_lockd+0x10/0x10 [lockd]
> >  lockd+0x6b/0xda [lockd]
> >  kthread+0x10d/0x115
> >  ? __pfx_kthread+0x10/0x10
> >  ret_from_fork+0x2a/0x43
> >  ? __pfx_kthread+0x10/0x10
> >  ret_from_fork_asm+0x1b/0x30
> >  </TASK>
> > 
> > 
> > >  			schedule();
> > > -		} else {
> > > -			__set_current_state(TASK_RUNNING);
> > > -			cond_resched();
> > > -		}
> > > -
> > > -		/* We *must* be removed from the list before we can continue.
> > > -		 * If we were woken, this is already done
> > > -		 */
> > > -		if (!svc_thread_busy(rqstp)) {
> > > -			spin_lock_bh(&pool->sp_lock);
> > > -			list_del_init(&rqstp->rq_idle);
> > > -			spin_unlock_bh(&pool->sp_lock);
> > > +			set_current_state(TASK_IDLE);
> > >  		}
> > > +		__set_current_state(TASK_RUNNING);
> > >  	} else {
> > >  		cond_resched();
> > >  	}
> > > @@ -870,9 +869,10 @@ void svc_recv(struct svc_rqst *rqstp)
> > >  		struct svc_xprt *xprt = rqstp->rq_xprt;
> > >  
> > >  		/* Normally we will wait up to 5 seconds for any required
> > > -		 * cache information to be provided.
> > > +		 * cache information to be provided.  When there are no
> > > +		 * idle threads, we reduce the wait time.
> > >  		 */
> > > -		if (!list_empty(&pool->sp_idle_threads))
> > > +		if (pool->sp_idle_threads.first)
> > >  			rqstp->rq_chandle.thread_wait = 5 * HZ;
> > >  		else
> > >  			rqstp->rq_chandle.thread_wait = 1 * HZ;
> > > -- 
> > > 2.40.1
> > > 
> > 
> > -- 
> > Chuck Lever
> > 
> 

-- 
Chuck Lever
