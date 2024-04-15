Return-Path: <linux-nfs+bounces-2812-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7248A52A9
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 16:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CB71B20B94
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 14:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863A97353F;
	Mon, 15 Apr 2024 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pz6NKA/x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u2DhfKvL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7968A7318A
	for <linux-nfs@vger.kernel.org>; Mon, 15 Apr 2024 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189980; cv=fail; b=dTA8JXy+L2GSBbt9AMi96IOxMNS/f6iGivqTIsfNeVcs/+RJjhyXMHKhoutZAh11vOMqhv5hleqO9p9z7IO5FBL5jdF7ecVf/HCmkMLGo0YW9Q5oaUBV8bmLuHil713Nn9YM8pvP+SPv9smXMtRSc4omTN/D8/he+RAal6pwRqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189980; c=relaxed/simple;
	bh=l5gi9syws6ayaa0uz2Pc+vT3pfSLwFjLOjK0tf3RPjM=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=LSCMcEbeX94w0wuS3pizfhFHUqbR9l8a9OLzVnXvC+rpjSB3yZ2A/2ty8JU/CDC2vnX/m60JYIklFtg9INkf35RBaKJSVMo7Xr0GB1/5XsvFeyyPOsrcXBFUIGPE2Als4sJrPJH4b/d4XN7BUyg6la8tYZSmvNgdM9U0EjPoPbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pz6NKA/x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u2DhfKvL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FDY8x5006607
	for <linux-nfs@vger.kernel.org>; Mon, 15 Apr 2024 14:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=a/g23C9K4RrSk/r5Oc1f+y+ap4NszWhg3Fdjf8qdtOE=;
 b=Pz6NKA/xR3M9UNLJdB1PC0XuY2/kVGPpblYuxJLKJXDR3MW0Uk16l2MU44CACkCfmWiD
 55Ciq4wnoeKiRTA2Mz5qyYuzTcUluf6D/jCeBeYY7mDeZA07Wu79oM0VE07HZaqkLKNJ
 qzYhqv/dC5s6einCSOlm7KdcTkUB2PR6X6Ux9DB+ZrsFCUWKRhGG2feR+oyRVfNTg76p
 NZBLT3fdoNUjsHATR9li8FLij1EzaX6YkjdWr3ui9e8eCZdf0w0opBXlB3zmNy3z2ISc
 zN6Vu7wwBfGuaYvsc6ptgvikUapjIqn8MC6GkygrZjrxOJ85DzJMa6yZL9P7KMj5AkMN qA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgffawbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 15 Apr 2024 14:06:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43FD2R5B029289
	for <linux-nfs@vger.kernel.org>; Mon, 15 Apr 2024 14:06:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg5tur6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 15 Apr 2024 14:06:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wbt2ToL2UEbCudJ1coVY/zKzRl2iA4iGhPqqU8kmb8YL3nd8L/11JtK2M9CfBhLBHQnC1KtSexNSRbts8A8WkM7EbKlZEUnd1kOL/+BTvEf30a6KwffHnn1fHVQjX5qGibWKgCdDU8XnKAzirvLg1aNnIAnBvOQZnt5H7WPFPQ6jm98sGUy4XSeHSnpNLkYucf1rQ+iOvhTHL30jKeek8ZktSKWEvxbkK4fP8vR6vuO5SqyL+9tnyx3GQvLaAwlq26dp/oWoEw54IUOPTjM6GSFVcBLmlOkPZZpH1k18s6BTvuK9zPt05x7aUPsGOonJPmEZQhjPcOpj8+ysTnNCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/g23C9K4RrSk/r5Oc1f+y+ap4NszWhg3Fdjf8qdtOE=;
 b=fG/3OhhqFQEnkNKqLPLS5SxXcurAbKje4MLaWV8QtmZVTJXb2iThEm/RqOGyZtzmJ/16ph1jtAbIPjJkodFthK6L912PFAc1ozm2W6sb9JhLOGKM/OJoTRBv+608aYRuFy91S+cm2T06KKf7bhLJB5ip/HBRZ3slz8+XPhWBvgWuOBb3iU6k6rp26jfHX2FIte6C2O7NXFdGZ2LAx88KRfYJp4+/374eCQQ4OMDqgiaXK61V0cCq7xTHr4/pBpyhZZomsCyEVP0nDA1CA9wrzoWsaoAADbt3YQioTjTLsqsaaHkEVrBQmiHUOV+jOx9Q/iqj/DHgz7nxEh83mNePwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/g23C9K4RrSk/r5Oc1f+y+ap4NszWhg3Fdjf8qdtOE=;
 b=u2DhfKvLkZTcMYXBf0wAbwhA7JreykYik/BJEAB4isFURQHJHyiZOT2SaVI7JxJ+SKOUChbc4M6C/aAVI7enuCIjWYmT4Rhrpm8fo2ozbmvaKMXTPy/FHiiodcm4OR8IlyesLLqPUnvb4f2t6lDY4+rUPksCjwe05V9hwKpL/P4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5704.namprd10.prod.outlook.com (2603:10b6:303:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 14:06:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 14:06:13 +0000
Date: Mon, 15 Apr 2024 10:06:10 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <Zh00UsSHskzLk9xv@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH2PR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:610:58::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6a316c-fc75-4ab1-3086-08dc5d553571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Fqg6bE7sGfdPfgnVTH0+hH5w+BFYZzMoGyP2lIsyl8DzPFQ/luUTuAkEdGVdde3yF5pa/34FUG/ctHCbQ3/fmmS5J/aLWPBRYNCD9cqXT+aNfJLiuifZZs6K1ONFP71nWW0g3pDToyuf5GQzMp1R8+jv2DhzyWBxUMjQE40ZqJF/WPBdYo5YUS5ZEj5s2OnJ0L3b+k+MNVTvAA4KudAxHO8jrsmp6iDfcbCV3URM+1LMTpwH3C+EYhWXazpH0nrINmsgBXhXGNI8dBVuZLE05bWdQtFt0pPyZlUCr/aTam9FYKUD19A61RLIIv5OPqkTxaXpzQ8vA9ikAtPAjP+LsURXiPxaZjPg6LuGTUuN7EupK3A20Vibktd0pdLQkfp9yH5kycstuykJL/q8cmxF2R0By/y1I7duU6WRzegPMMePm/BIOdOICdgX0zMsEApqfbPVWvST+4IZ9iGfnrU/unc779h1NWhB7TH/lqqP2dc+mujvpUeKHQcu8lyrnBnm4eGG90TPUzxiMdr3Z9eCMdAnBiikehr+ILaoPZI9GPseCiLK/16pAHjejw5ynnSUsz7exQKDHyS9kWL7SeCsNjMhCZKNBRTOCDoVbNq642ZRNYk6qA18PoNDPlp0Rs7BLysS9WYDBejW3K0dLHVq1nvGLTwzwR+6HZenYUd52ts=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2VDdKxKD5GKrgpQusPlnVmFTzTvZQw0Pql0JuTpnZX0xrKPw1ZcJGOQw6z4P?=
 =?us-ascii?Q?cD+qA40ga1iGDTcS9/bWxxR+zdmASjX/NrgOx95yfB1LUF3fURBR7RoI8+Q2?=
 =?us-ascii?Q?okuRkppJS3Md0du/6GWG+fsQ6wW1emyJ2PAfWBXR8yoPeVjNxOREN7dVFKOW?=
 =?us-ascii?Q?ccD+sY5Q+2BT9MZw0o05sfdUTSQqgnUnS2m5P2fdSHCjtwL+SdwQdJIEegrk?=
 =?us-ascii?Q?OB4eSchZFa8eAAe68shj7weV43XgQ27KKr1TSJEx4sWojA7Eosakg6c5IcWb?=
 =?us-ascii?Q?V8oUixpgfMyYPq/Ka/zvyJKH+jKlNlcmbSHX7YS6dVI+aZ/5r+qfMRVoTmWf?=
 =?us-ascii?Q?8at8fATpHXMYj4HOEccOVQ9wPv4l3c5KT35iqBadTUWID8chSP2LAnNqdZhV?=
 =?us-ascii?Q?WC4NsqysfHTryS4yW+oq3PmFXNW+PH3ocbLd4EKM7+cPDvC2YwDu8ehq4eck?=
 =?us-ascii?Q?L4+C8aB6H6zk84x6C6garATovlSgug9c5rP2LVY/njlHDEU5v8x4slZ8zpHN?=
 =?us-ascii?Q?uiL+RzmAkWbi8qFrTqlmd6taTEkD+hTc97wQ4IjIrEJ0RkrqHI9w7VI7uk2r?=
 =?us-ascii?Q?p710v17ofEIqUf43t+v782l46DsVPgj4CLF1U6QvW22D4BnGpJmAmXkNGbuF?=
 =?us-ascii?Q?Ibi7OQMMKxPo5XJ430tzNMLJFvUeReVmwbdr0rC1AUylLPdG4pSgquUgHvkt?=
 =?us-ascii?Q?Rt8lhZ1hAY6LGjTXVC33wl28bddBIKmwX1Q6sAuExONYH/CLObd2v5Ve2RQi?=
 =?us-ascii?Q?IYTDdJvYHBD7FEYtCD8Psw4kjbInSkkIrZv4zxVdjyM0LX0Zc0SjKiuzYoF/?=
 =?us-ascii?Q?uu7jJ86FSRHt7UmOsf13zTc1XI8oP2E+rBkp9P6qg+HwqWJn7ZA6cij9naPA?=
 =?us-ascii?Q?FmlHftagI3gxKy2HEXbrPLbleKjedaVxi8djPobH9PAvfCB25pdOyzulFBkF?=
 =?us-ascii?Q?z1NfI6Gz1gXE41Gb1xu/geA67wR5xjJNkvNnMj2/MQ7T4BKSBi6oW+Oef+IV?=
 =?us-ascii?Q?nt0cwOYC/ouuV8HpEpkrgAd2Xp0YZeJ3h+314W3hhz6vIggHkfD3TVcTc6g0?=
 =?us-ascii?Q?YAYyBNUkZQ3PhareQe2jGYEqVCt4CtZM9ZkbzInVR4yu2ySP0h/qdueCJR36?=
 =?us-ascii?Q?DNp2RziETtMyZYX6NA9DCx8Sfb0hOeoAiFYw/C/726WqnVjzov8y0JdYf+fm?=
 =?us-ascii?Q?zO5pVjW7++zinLffRCst5iqc0jwWobH59AwqPASnTKQRiSrj20MMAQokH0WO?=
 =?us-ascii?Q?0D/X2JbcjVNjRnxGTirsvKv6Es2OG7d7FfGRmDAhy5HJcBSLLQfiXHHwu2Hg?=
 =?us-ascii?Q?6DkalujDN/+EzntXJ9Joh3O50mc2s3z4b/kx3eGtmC0aoV3HFDUA72N/nNbx?=
 =?us-ascii?Q?EXVvLRSSVDGymk7FFl2L4eXM4UH2Rpm7M/i+V27M3LZLmRdjdZ6daUTJC/qg?=
 =?us-ascii?Q?OBABI75Ro62hXMYIIuaW+wn/a7Ym/TzdijS2Karg42qC1ZlRB8ox8HWd10uB?=
 =?us-ascii?Q?Hl/kyny49NA4QCmGZoO4bbSIngkjT2pIh2r6XEfZFV3w2SI4DtPRpY9nqfx2?=
 =?us-ascii?Q?f4ajWVXqSrNh+MaLwxsOgJQh6nIT7+NsK35Bya2/8urs/pwTdC/+iwidtbeL?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+Y0ZI8kbzlfraDMDL7mQc/6wvCxEP+2kRQnEMJAQ7pUg37cS7h5/sfLKXfVuDYao1hNsn3od4meH4hg2YEFqshxw8N+cXrqnT0qIoBSbtnb8v1ugDXYNExUQnffYCu01s/OHUbPlLGDMDaTZIm/0z19A7HGKD9/jiBdq6nDya1slR8FgbstfaOmxl0RruiC5SUo3X6qLirUqOK7/zWbQfhyhMo3JIJmWixxi39t07RFrt4lx5JSk+7Yhrm8BSD95ONRvSBHujie8u9m6fszowiflbse7pLi9oSJMfyWIaQxJMaR/+qnfcXwFXjC2cU0pg6Y2TEk9OiO4HozY2ociIHzawrrvm2/7ERasWT8qCf7l753ITrfp8nsJhw5sVf9j8taj7EcndAdT2sFAQ997D9caldrwAIbo5cka3ho+tbkBDvtWmbOBALD9U/Bd1msR0CyGa0xrVkKsOw2b2men0D8+kLalawjPaGS0QPwRtNWFquvUBSeXOJo0C5IlQdsH33xPr5fHzUAO8zsUALtUwO+q+LLa76MiP473DmwWIQbqrbEauEoz3Mkae7ze02D/6jcNp1GMXv6n4HwOI03FVtdG5qxC/31RGOcVbir3tDE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6a316c-fc75-4ab1-3086-08dc5d553571
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 14:06:13.0885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zfhF+vdibtkCWYQfzmWiRhs7o0ny0k3msDsMvVXTKZJXNzFmVPKznitl3YOlCrPKqeeoTl2ukSk1LhcFpDZfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5704
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_11,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150092
X-Proofpoint-ORIG-GUID: dEcvnuNpAFyK5mquRLwzrXkJJ-6LwZz8
X-Proofpoint-GUID: dEcvnuNpAFyK5mquRLwzrXkJJ-6LwZz8

It's apparent that a number of distributions and their customers
remain on long-term stable kernels. We are aware of the scalability
problems and other bugs in NFSD in kernels between v5.4 and v6.1.

To address the filecache and other scalability problems in those
kernels, I'm preparing backported patches of NFSD fixes for several
popular LTS kernels. These backports are destined for the official
LTS kernel branches so that distributions can easily integrate them
into their products.

Once this effort is complete, Greg and Sasha will continue to be
responsible for backporting NFSD-related fixes from upstream into
the LTS kernels.

Here's a status update.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes. I'm currently using
the NFS workflows in kdevops as the testing platform, but am
planning to include other tests.


LTS v5.15.y

v5.15.154 has been released, and it includes the NFSD filecache
backports. Oracle's own QA team found a small fcntl regression,
which should be addressed by v5.15.156. I am continuing to watch
for issues.

You can find these patches in the "nfsd-5.15.y" branch in the above
repo.


LTS v5.10.y

No change here this week. It needs to be rebased, and a few extra
commits are needed to match up with what's now in v5.15.154.

Next week is NFS bake-a-thon. I plan to restart work on nfsd-5.10.y
the following week.

You can find these patches in the "nfsd-5.10.y" branch in the above
repo.


-- 
Chuck Lever

