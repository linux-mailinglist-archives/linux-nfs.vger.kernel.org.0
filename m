Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142257CB4A5
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Oct 2023 22:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjJPUcl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Oct 2023 16:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjJPUcl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Oct 2023 16:32:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0AA9B
        for <linux-nfs@vger.kernel.org>; Mon, 16 Oct 2023 13:32:39 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GKO8Cx000703;
        Mon, 16 Oct 2023 20:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=k3MdbtOHw2HDrHGwq2pdPBv/uskxZYu5g6Zun9cveIA=;
 b=sBr6T4LTI+S7Rbn5fxuqZKvvzkH6NQrS5vWMS4YDYDoYT0Owq0f7/4xk6sAcRgaJYyNO
 b9XoKbjOhvte5YGK88pdwsTAM1mnKs+jcL8tCZywzGm1FPMlQ5ROh9zORREUCY/81JLP
 7VoNeT2YkVawv5Dz2uQIggxJ+T2/XExB4EBNLtp5kml6MC8xSAT/leDCNysipxIycPF+
 r/vmAebZm4uTbUFZtiEE+0jd+DRqHicwbtgpDVw+1Ze45cWb/phLWtMcKg8cieQenMfn
 Zk7cj5cRdfu/mmMUSh0s1Ln8ippI2IzLCZ6wRwyoA7qRkMzuUEitzrWnvLMQ7J+LqtCW NQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk28ksbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 20:32:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39GIo1R2021944;
        Mon, 16 Oct 2023 20:32:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg5046hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 20:32:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcW3pf6rEl/8v1b9qzabEuj9jOnFEV5EdO/JoZHuB3ap2yq0avGwLZ0SrPRuDXHDWMA5YGY7wf/+6hkYipNtaKaTVzJlLQzId//mV6SjXfMRF5e9turWDVcyL3/WC/CkdeE+wdz55g9VA3/fn/mUigc4k29bK7T20ECquX5GPP+JrV/8qOwB2kkmS8GE6FjCfbEmpX7DrkqxFxfo1wSwkBVsfXPubikki/FzZ82iB9SaGuVurHCZG39imT7Mc43BQylKzq3MJwK/ErXX99TOUDYGPdiTkuc14WiF8QNtXlMMMgDN3v2ZNJ2Cf0v9lPqvnqcGjE07aitMDgsIoFMk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3MdbtOHw2HDrHGwq2pdPBv/uskxZYu5g6Zun9cveIA=;
 b=WCT26s2n/Fds+fWmRs/RFasP1rW+/DmFgwX+ix21Wf0egL+zdCi8SCU8U/mWxXkWwyhLDft0EETRmV72VOsEZWI3tWbkS/7vsX0CqnH9z3NVpAwZ0PtQWgbHF9ADsXxfyAeYgkVaEtcafUIUU59TFjIe6EnnAVJlSfeVYcoGhxCzhO/nTWoDQvS6UKR2nGlL2ByproogER+Hlnl0jq35sx3h5INgt1qqAtHAYNw0Ba2xj3U3TI8e/L48BohGW3meFgSkg/0KitbkmIvSOTTadA0nRuU75q7YqksSDR6dwOCEkbFnWsZXl7Apc1iAL5a4e45wmDBI0zddvEFIOBz6lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3MdbtOHw2HDrHGwq2pdPBv/uskxZYu5g6Zun9cveIA=;
 b=JqJ0nyq0AJJFWOOkKrMHB3jH5Pfbmr7o32aZ7YEMOivjhFPuN6K2oqotAwPcJi5MeJmTfrsVa1Hm2HVFLEWdormiSmEoAnhK4MYgP2lv8mqcBFYbrvOpAFMtXMjThvTRVQeUAIm6JYDhstI32JUG/6XEYVGGHjg+bMq94mUdHyc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB6374.namprd10.prod.outlook.com (2603:10b6:a03:47f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Mon, 16 Oct
 2023 20:32:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::cf32:e9b3:e1e0:9641]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::cf32:e9b3:e1e0:9641%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 20:32:35 +0000
Date:   Mon, 16 Oct 2023 16:32:33 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: lock_rename() needs both directories to live on
 the same fs
Message-ID: <ZS2d4aRUxY0LA9S4@tissot.1015granger.net>
References: <20231015172927.GE800259@ZenIV>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015172927.GE800259@ZenIV>
X-ClientProxiedBy: CH0P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: a4493b93-4944-48fd-70ff-08dbce870832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: unf8TXkDdt5U/pD00KDvu5iVPl8yvFZpXNIZgm3jw400VQ94PDxdAdgiq+FLaOjrEriOiLRRf4Y6hUbsNWn3Ho6C40R08/LmTxW1PgnfQ+/8Ny+7SXRwUMwclNy1Erx7AoWf848NI9O7Pz53/j5c8e7QFclHdeCdEA+IS8cpq8aZSV0XNaBB+NK9KmK0KZ1HbCt989sV9K7NTeeV8s2cKOlHDNI0WC2a6q6lAbB8QoTior0sObkmuQWedk2CRhDI5YyoX1V2uW4Z1/dz7vEORRqcUpkeEzNiCyUn1KoywaKx/vHYkW2c2FryTgvj4ux54DYNgiaoJ50Oz0hfXNj+/kVjxjWTZHNnYKgwkX4oxyRe7jDFuNmSnCFqjatZogP+IxGFa+BuhricH8YKFTVsxsAUkVTLeWRz+yRAjVjB65Ir7nY97Z2KStykkf7V5Zwso2x13DZ5s4ucZWxdvdoHqZNpPtTTmuCahbq3TxitZbXmMbUYWckhyilBgs04ZhNR0Ga4r2ekbsWXocmhJkOIxoH20l4ImG8d5tfgijoxpcCcHbIWAYemIjAepmrYK0/Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(6506007)(5660300002)(44832011)(2906002)(26005)(38100700002)(86362001)(9686003)(6512007)(6486002)(478600001)(66946007)(66476007)(66556008)(6916009)(41300700001)(316002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dPSddSWaH+NlkfzXltiQ+3vRS5EWNpRqTjj1170pkApO3wFr5fyqiObkGtj6?=
 =?us-ascii?Q?ysMFRizb/ojyMc07eMaQMYh1j1TRSbBkRQB+9jP8XmzN7SDQv3tojYsApatM?=
 =?us-ascii?Q?OjX39OUlcxiz1lBL1QtIQbsLCAZFw9B1MwzLTY6QTNKkh3r/AhN0m5YiAg2V?=
 =?us-ascii?Q?TOXIoxbqP1SMdYqRm7WCPCp/eSm23q2wdCyamplzkEgmPl3s/154oi4scncF?=
 =?us-ascii?Q?LYMcB69jc5gVxLqACnzPyPBYvPApiWlWL4Fhz5U1O1qDb2033qOCryYGEM/t?=
 =?us-ascii?Q?v8VsEXd7DAemy0eLsXvudDLyNkPDe093rW0tCSTkHCZ8EIaHkWL7XBoxmMbO?=
 =?us-ascii?Q?DHwhbuP3ywnJYOhI7bkw9BhwLWTztU4swFoVKZhccQKi03Lq8rVapT+wqMDV?=
 =?us-ascii?Q?4A9bBaxaAcCOXPDUVxaVyceC+35r7FrSs6L81cVBaeAa6xNmTtIifquiOyrQ?=
 =?us-ascii?Q?znMsRoWxABnEUTsMXNyYXglZ6DJKWu9nn89d4RMJ8mN9v3quqoVlo3w/TF4i?=
 =?us-ascii?Q?0xceQ04vxiQKwaBwXgT/o9MAeH5mhHw5+FDSLqjMrApnd1jyjrLas35jfPyA?=
 =?us-ascii?Q?5rB9C2rL6/W5RTSORan3uMvqcUQ/QBvGAAdfRLjbxgUwYTQWt9AzNux1epTl?=
 =?us-ascii?Q?mUcPySAJ5v+c5/I4EhdkUBzGJ3VaEVCwd/N3ZlAmb/WXPOBYn95ZGsyyOsvm?=
 =?us-ascii?Q?XUSlFh0hXMZlHrblAPzy7+N06fsJHnn6yznetCJTfJs9vwfpWUeAIZIXewb3?=
 =?us-ascii?Q?KRYp0reHeIEOWTUGyuql5IKOwBV+fdQO7lxLkHVA5x9HfjKArM/A83F47G0S?=
 =?us-ascii?Q?sAnG2LA9gZvq6FaUMMPapnwoyV5Y4ojuySJmQnGSpuhq5ssOYlQ/jx6DfmDB?=
 =?us-ascii?Q?LIrbqMd4AuXBktqArBSsNV5kIQaskuriYk5D/hMLBBGRk9GGa+oSb+NQKmkk?=
 =?us-ascii?Q?XSBgdwKOYEtfMhmHlegUztzOKJNvuGs4L/zSAwWjt8ZQTmmqGP/k1ukK1RIF?=
 =?us-ascii?Q?tgEwvoEYKL4YpxIAEXwysXpsFIBdgQRivLhgqfnY2EyKQMvgDPLbB8HBEO7z?=
 =?us-ascii?Q?fy81ly0+p4XDdza4xiqLKnSo+OiuMlVvnJgxH2wrOZnlI1t9OhzpnnpUtRHh?=
 =?us-ascii?Q?k66LQqx7D8T9Vc8GuO1ovkMzbWe9K47XnEQFR/S2R6wXfdSk6wHWX2Hn9Xk1?=
 =?us-ascii?Q?IiO4ux2/r4RTYcNAFkIN7AQSt13omCBfTkbmeCNZ+F9/Lhey3cIcWVDUX58L?=
 =?us-ascii?Q?fiZfZkYXWLmuZ/eHqBTGd/LrzJxLtZJ88rzOrNC2xnx/JuYyPOyiiFA83LUV?=
 =?us-ascii?Q?gK3e4AHC13uVvMuli6nlCFO0A+M/HbK/HeqfG/PVkPz6TJObxDStrVaJcqcq?=
 =?us-ascii?Q?ymfxFORiy5bG+88TskLtnYLfb5jfzlDvMTjNEweSZbPPwTQNy/3Dj7rtQ6eX?=
 =?us-ascii?Q?6KwgCH9UQLLtXOhaIgGQSjgSHgrA5RP+w7cREtSDbg11liQTFVnFnEFnY4dd?=
 =?us-ascii?Q?z851tlEdwzfmBOCmbY5yZDZZHUsi2mgywzvmF+FROiIWHCC/I6Lc2WKm6YfS?=
 =?us-ascii?Q?KbGhrql9g5Q9Lx4sCEAAw4qZ4TQz77IqaYyR7CaM7Lv7d7O8hPlDN6YyRtu5?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: maEG0aKTI+efXBl5K4qwqADgauCWcbP1QSdMdAwV6Yxhh7LCiIHQBQP1RfTbCgL15pXd0JR9shkrUukDkeBzBTPkniHxv0y0UTjYfvSyaCR+P6r1Gb1zfetrjVvP5f7vzrcXF8w5dQzgZJQmMcnWCEfHAZ/Nl+TslSi70t3FWXkDU25sxnrnXrr34IqXdawA3+JoN0zWFSAU92/5PFM+FQUcUY5XXEYCWmyhkXg6ajf8GI7/oReQVTTg1zM2zU4+Yk9z6KUMCFEOrogYQvVaqfXcuyk0mDaRK/kZqeF4TdCfUrVMX9Oa/nyLNmZjbc7OTJz3nW0UudW50vj/RIdWO3DcE+stXWH7yj/OHa8Oj7SCutf3RGIPZNg4RdapytmcWRg5R5l0U5rWMRskT5tp+svyLtHx4OXxMLa8Kvar0ZMVV7n8xD+km8+/+lNJto6zl2zOpO9JULy7Hximtd1bZCXJ8L3BmwhfILeHHcmKFI9UnTU13MO5SMcodoCzOxtgYSUVwiX4PG7ANPwU/JM8BJQ6fMdfG9mTCys05n9eZX3Z/7kk+6y4B5c+s5Mg70PZsKHVxE2dQdUtff0j0Ak93S25ZkC20ggrdVzqDN0EPNZVojiMAWLKfLnVy/WscTuTZPak93BszbJftOXtt3BfNllcVUazdg+GSb16xdhi1clMoocQ8hTjiv9p7YeaAspIE2tSws5hpfitBOtdPCVe4wf2heA71+mhx/jmusykYm1wA1ZldtSPrWY6szyxmUriQ+boTATvP5zI2oAAHDJRUSLtC67N+c0CJVH0x0ri/OoLnlKyNqDuHbFEWwMWsyWc
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4493b93-4944-48fd-70ff-08dbce870832
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 20:32:35.8114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aK1BNFRIispLB8kirBKnFRjD9hx4CZMbYr7MEUvjLCM28D4fQWwvOJzqImTQmu1SzB5o5cLojPE0dPDBEpfTKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6374
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=939
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310160178
X-Proofpoint-ORIG-GUID: O7TnsIL902mN7v40qrx8FjSakNO3CaLH
X-Proofpoint-GUID: O7TnsIL902mN7v40qrx8FjSakNO3CaLH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Oct 15, 2023 at 06:29:27PM +0100, Al Viro wrote:
> ... checking that after lock_rename() is too late.  Incidentally,
> NFSv2 had no nfserr_xdev...
> 
> Fixes: aa387d6ce153 "nfsd: fix EXDEV checking in rename"
> Cc: stable@vger.kernel.org # v3.9+
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> 
> [in git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #nfsd-fix;
> it's an immutable branch, please either pull from it or put that thing
> into an immutable branch in your tree - there's a lock_rename-related
> series in the making and I'd rather avoid mixing unrelated nfsd stuff
> into it ;-/]
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 48260cf68fde..02f5fcaad03f 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1788,6 +1788,12 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
>  		goto out;
>  
> +	err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
> +	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
> +		goto out;
> +	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
> +		goto out;
> +
>  retry:
>  	host_err = fh_want_write(ffhp);
>  	if (host_err) {
> @@ -1823,12 +1829,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  	if (ndentry == trap)
>  		goto out_dput_new;
>  
> -	host_err = -EXDEV;
> -	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
> -		goto out_dput_new;
> -	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
> -		goto out_dput_new;
> -
>  	if ((ndentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK) &&
>  	    nfsd_has_cached_files(ndentry)) {
>  		close_cached = true;

I ran the git regression suite with 12 threads on NFS/RDMA mounts
using a matrix of NFSv3, NFSv4.0, NFSv4.1, and NFSv4.2 on exports
of tmpfs, btrfs, xfs, and ext4. All runs completed successfully
and in a timely manner.

I think the patch is good to go.


-- 
Chuck Lever
