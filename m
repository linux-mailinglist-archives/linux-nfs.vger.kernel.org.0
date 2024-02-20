Return-Path: <linux-nfs+bounces-2030-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1DF85BF21
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 15:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7AD1C21B8D
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 14:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E936BB50;
	Tue, 20 Feb 2024 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sb1l+yMF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gej3i/Lb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33C26BFC6;
	Tue, 20 Feb 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440671; cv=fail; b=G/RQZGr4CLomUTuR5dMq/vuTttzb+Xcp/W5trp3eWCw5vwT8aJBxc5fzz7OY2PqpwNga8KKh3uhIIEXTJusMnvwDfXRyYweh0Z5cHKHJsYP+77nKaY6YXZgONnHPhBNzFYdtDXbssgDErEchqTzesJRkwdUC0dvEyOA2LowbaPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440671; c=relaxed/simple;
	bh=D9oPQ/46S1qHigwgjRybx0CYMQEepjj3iyI3kFuMElo=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qe40XlAbSHpLOi1XECMp7HljQXYxd0/hJvES4lMA/ulsrr1yw6sHEAwGDrg01OdPLZPXherWgKjPm5luy5C0EmE3vVggvexpgGKUHbWyVl/qynnQoYxtsXck2fPH2oeteeBRX+7UvjDo0Kp41f0QuKNfC7+6GnNTV8dpcjfavfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sb1l+yMF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gej3i/Lb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KEe8Ld001786;
	Tue, 20 Feb 2024 14:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=7WeTJLj/ftQsoUsczKGTyXUA2EmME1MYViATS9dV1OU=;
 b=Sb1l+yMFU28ouDzLQEltlRoeVBbPCWU/D9ZGGhMlEx9G649FAcXiLJ7be+ywGPPjbiKA
 rYyku87nZF34P8zU7SfL/FLOHRRIQ6UtHfTsU3gVL34TiaPIRrT6FB4RikYfSHsuBbEc
 LH3PHhElpkU81mKXMMoZmRw+qnFfvUuozi+rretqEKO7UJuoRMBkojAmosNkeqGm5f+Z
 CW8jV4uIw37J1tbHo1P9swpftBW84uN7maKidCZxW6/lcELy4vzK+emyceDWrBuNk3zw
 QMoVZcXVgXliky89beK/DNeybRnwuz2JIZfZTy8y693WLtVSLeAU1p+KsifWCGloSVvA 4w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk3y0am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 14:51:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KDU9aq006609;
	Tue, 20 Feb 2024 14:51:00 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak87k421-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 14:51:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLqVWJ9yYPgQcPmhqxkkWoP3fR9+xczNkbvnTMoXbRtl3DSB7/3Lr5/7m2WXpQ506RfMd7HZ7YaaqgRfD/VPSgxck039IvF9Fur8tcE3wODAzjhhcF9i5Ek46thtRmtBG7ncncr3Oph2eOHcw39R4v7GFXYsA1HG2LG7uqqdqLTzz7UY0u9/nFZamUr+Oa3PkgO4OHkT+CJeYVvVGpqdcdGEjkXzqLn/PsHhobcINfNcQLJJuz872PaWxRGCv75+lQA5mzTSJrhjj1+bC6b3IFk89TTapDRJNF4K1tmJiGsVrKoJAPZQ0gS0PBbmEYpQz2rWokyWGBVvxcRlfe1cRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WeTJLj/ftQsoUsczKGTyXUA2EmME1MYViATS9dV1OU=;
 b=l0urJfzfe7gubV4vQbcBw83VriYbJgsTcSQ3pIdKh4Y6eauLiPrR+RVM0bACsYB4YRzex+AQgKJquGzkEBueRa58INJElizB+iLZyKszzFXJIFx5i5b1mq2TAklL6t1umsA+eazvg+GAawMuD0LsCyamwu27m/tKmtC9hSWhP5sZhYPhg8CpkLDXnoMBbZB7G7SvC0tWdwgenvZVlrPEq7Omk2QHLLgU8gLm6dfbF1VrzCAa0LCo0dP0EwNp6uBmHhG/Jwn/RP3GNydNDxytKRI/D69nuZAIHoRV8psfTzQ4gIiqhKoESVavc9E/KxOK7rEaHOsXzOWBf9TxrSMWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WeTJLj/ftQsoUsczKGTyXUA2EmME1MYViATS9dV1OU=;
 b=Gej3i/LbUDBSL3YfuPpd9VbSFrVqMjAbKE+fOAfCR64NoYwYzXWg8RNb//+UKYFHBotw2Z169ak9U+ZL+S6hy0roiUrKMyP4aTftT31i+ZZU+gUOt8KOHRMDLxSa4LdUIRV91FOTC059QHXOeaKwAsNZidae2ymLFbls6mWQY9o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7818.namprd10.prod.outlook.com (2603:10b6:408:1bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 14:50:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 14:50:56 +0000
Date: Tue, 20 Feb 2024 09:50:53 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>
Subject: [GIT PULL] NFSD fixes for v6.1.y
Message-ID: <ZdS8TXWl3QKf0qdk@manet.1015granger.net>
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
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f91739-f8b9-43f7-e49b-08dc32235839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7jl6mxXwtSIgltPvDdF4pePySd2f+/vRDtqtM5CObmcVP31Ik2sW2T1p7kO3q+Ta41j+EZsZxyfOUvrloMr0smrac1d/gevx3W+Y/6KzadxKZUg21ib3rOYWQNgpl7Pdum+sAsLWXmBeXBJd/a5DNk4DnTZHVNqHqttfv5MEQAoCqp4Vqf1oNpep9yhL9Eif36yPyKpOhDhRGqCJl84nAibXFUYArHq+PUn3eENOh9f7bu+OrhUnHn8gBRRZhB0Te/l7wVh7Hy8Wzd4LNOlvf8wq6/AVLNXdcWVJ4gXELUdZzU9TDOYS7L5EglG6CjlBMAAGfw+2Uzjq8FY2LgWH8tGh/5lBIZo8QsMDuZXR2ZhiSQ2kzo2BkxFGFiifDpMI16K0slpKYrNzc3Ibk6okNWEIqxKbuWT3wdt2D5hW+NkI12BUIkUQeFQyFVkzLDbbWRC7twLEgPSvwGtb88LwWRCqvFPlhyTTgAFQ2LF16QWwWrQ3I8sWaMIj02CXGfKKTrHY387Z1NFcJrpB9NKzug==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pm1ufkYZBFXsCeQVT98pO+2hPsJJuALF3t9uAyu25w/Uxi5aGeI1eQ1voLeB?=
 =?us-ascii?Q?hYBGSYscWFpE6D+sQ9IHuvo9Dywx7tHE2payt4v3vZIpB7r3fswFGD1K6vHR?=
 =?us-ascii?Q?+oZuqgjJggnCEL/b6e2Z6bo2aGuRc9tsYZCoKr6e1lPdO71qU8pAJTdMVFZn?=
 =?us-ascii?Q?b/ICF4mAh6JM1GxLkmxq0jr9gARrBtZuNrgLe9x3njmd5tbGEJR1L0gPb7ZF?=
 =?us-ascii?Q?LKOaNUal77KR9+/GcePlH+ae5gp3/4pZgw7+vMJ6uoIeAL/8jfYPC4Y5E1nr?=
 =?us-ascii?Q?tjZg84TppSypqWNpqhCyZbV1+sVNW1X2VqP/LNx/r2xbCaHzCzd2QciwzP2r?=
 =?us-ascii?Q?A8sI9TdxTtvCx93jbweP8NJAYp8oUTyUr8wugBfLGqE9pY7Ai4J6hkqnAAeK?=
 =?us-ascii?Q?lSBaxDCPeOs8IESB8KxdEXSLbQ9NBo4X9mcEh6CIDlkEmptcTo2wLMsW2WyL?=
 =?us-ascii?Q?12K3mdxDFDTYH5Z0+jCct9QSkezXFEOkgnP9Q/oGWVz/Eq55A/aFA8j3Fy+H?=
 =?us-ascii?Q?s2udZ5t4NnQckFqaMUR+feuJ2c4jjHyojZqBAN31uK4KFzLuLAWKa14dc5LY?=
 =?us-ascii?Q?jUdBcYC0X4qf5VuYEdmS4b6oIROnDT+bKEnsJ5ZBqH636ekdQg9LmuG4rRZf?=
 =?us-ascii?Q?Wr4rctqNN2eVITpW9D92EwjspfPxb2Il4TfyiHNfh/Lc70pB/7dTkI28DLEG?=
 =?us-ascii?Q?zvvFka9D2cWRTXvtZBL1sFAaPWXpjSCpf9PsFWBOdLKtml3KwUvI9qj9N1o6?=
 =?us-ascii?Q?NCBZRNXHNZJ4yhCIZluhoNyo4Kln4bWiMLGOzU4Tl3B9igZE8i7dLBJkFUxP?=
 =?us-ascii?Q?bMb6ZEybzggwGr4946dhTCWYhm/FoKhAMVk8+0eA4FlwlxVEXQEktoM8md4G?=
 =?us-ascii?Q?BtaHnhqD51JoO0L9hCH1t3UZI8VJckREDpvAzR8kQh0gIajaC9szp2VlSaAL?=
 =?us-ascii?Q?WxswqVKpFmbSE3qf4znA908OMV4qq/BTZY8kyVam6TJYoabtPKw+q0KnsH65?=
 =?us-ascii?Q?EFEr7XJ+2HxPD6lfkNOX00yaz+hScrXK8uLUlZhjB6BcmIh+MN0wcme1K0hL?=
 =?us-ascii?Q?1ixzDBGhUEJ5L74h46z4X19VwUayzr5OPId+QH6OgRjVbkarPuER+ezNiGEA?=
 =?us-ascii?Q?XtPMxOj5inBBL0p+laBRr6DAwDodDxJo5+kF6Px/WNit6xtIuuqWrfXfDvwV?=
 =?us-ascii?Q?unKLrPecOaD7fLwe6npa/EvGi2X3DXnAUvz5Av3WOTdYJHTgkiiTE5uMWOAV?=
 =?us-ascii?Q?duAZGZOF3O46EG9bIlnnU4vPwC0haDZrP1Pk7tH+pLL3rDe6knDuCvyySjQE?=
 =?us-ascii?Q?Hz0edfXnBLF40v6kMf+6+aVTlx/nk+/B7s0U3/iZDDdLYshinF0lxA99csjy?=
 =?us-ascii?Q?HccfItq7lNY/desB8htAKGd88mrjkqs/iF6SpuHWLx4pguP3wc8S7ZmFoicd?=
 =?us-ascii?Q?7krWca1Da8b4S50zglWvrJ3XRMIIsDzJEejgIwqQ8gJ5roMVE1RZKCujvCGV?=
 =?us-ascii?Q?mAGkmDt3rEpUIrAzXRwxPQ1GmP6kEYwY/+lutEPFXZAD5Upex0YY0b73IgkW?=
 =?us-ascii?Q?9WmDhqqHjJxI32Da5z3hmi/0CvrcETvjQrzt+/Vwch3a6iacMqSnJRwProGq?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	79oCTxFFIyv4Qr4yTl0vw56vU0jetXSKv2spCaXbMgl8RvtT/RMKguv91G87p4sH2z81YcPh0TzOxOy/1iPntzpMv0YWF7ap/wEn/2BNKZ7JRcOOblUYKFDPGuo/PI/qWKRccM/xg9yBQ3weXlm78Vb20y10wAZQRDusyPvpvB9rMCnnGomNzHCgbZvBC0hj/hGe0xiNusd+eMT6sAbHSFMVfpDEusBXLBTu1nnIDOm3IAXKNmvVHgFWq6PZhenSILO4Btg3DDqGcuiXksb5qYEzn2u3DE9Rv2gBzjtUKsau1vp5xnWOwfzkj5q1oCKHnuwBBDxOjrYX2UunAiJPoOhLvDAGfM3gtllUzpFPsugztXDF+gDwRfHlJ0V/In6f8ORgXoLPrSc0jb3TB5tQNrifZ1lXWJkjizpIDZWLrjhI/PaOFcxncAyiBG4wLAsCpiyCLAreWAAkY0jTJ9SK2iqwEdkHqfDZyT61fw1zpvhozUBxOuBcCt3ZY8YZanSLOmpr5N+puGwZB2xEbS2EQ3THSDR5X3OCGaSjgJuJcUlnuuehNjdJqQWcNUg5shojSt43ex6N9Qt0DbBKEqkW15mw747QYXlCFqPNhMRMiX0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f91739-f8b9-43f7-e49b-08dc32235839
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 14:50:56.5979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJh/h96zUINsQcTnWVdvYFPJ8UA2T9/br9VHSw9ms1N9nHHGb/zm891tBYc/IQMZEhfkMDZJpn3AApV9nrZNsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7818
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=826 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200106
X-Proofpoint-ORIG-GUID: 9wYgQ8TJWQxfs1iBowxq7ohPPIkGEKk7
X-Proofpoint-GUID: 9wYgQ8TJWQxfs1iBowxq7ohPPIkGEKk7

The following changes since commit 8b4118fabd6eb75fed19483b04dab3a036886489:

  Linux 6.1.78 (2024-02-16 19:06:32 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git nfsd-6.1.y

for you to fetch changes up to d432d1006b60bd6b5c38974727bdce78f449eeea:

  nfsd: don't take fi_lock in nfsd_break_deleg_cb() (2024-02-16 13:58:29 -0500)

----------------------------------------------------------------
NeilBrown (2):
      nfsd: fix RELEASE_LOCKOWNER
      nfsd: don't take fi_lock in nfsd_break_deleg_cb()

 fs/nfsd/nfs4state.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

-- 
Chuck Lever

