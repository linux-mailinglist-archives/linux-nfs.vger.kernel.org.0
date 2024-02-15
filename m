Return-Path: <linux-nfs+bounces-1960-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA2F856512
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 14:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F8E291701
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7129F13248E;
	Thu, 15 Feb 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ff6N0jRd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fw4JhvUg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93383132481
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005355; cv=fail; b=Y8gDzNqF69zGYISd78f1306Awlg5uBEIWaBSnxWs5WtCu0rwfbxD3Glv4KWgTsPBRC82i7oH0lXzc80qiWO1zHtV8mhQWGNLVtBP3Ym3atew0ULOyw6G9sjQMJeou9yJC0/RFfl8bJEzMKyumB2IgKINKVAunCJiT8oRQ5Iz3AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005355; c=relaxed/simple;
	bh=BgTgahRsXtbki+hYV/n0fFo8bczUZLCQ1rpuakcccxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YAv5teT8fTFYpNrkSIYn43g7MG6JX2uqjCzseo7a6PL+21JH0IbT2reasMkQiEVWLDybgubfEp14ftWxNhObkwhNrBWAaX2alayCrUnHv09vs0HCGp93/EZyKFAoeiZmONsVcewzYyA/eV/P9mlPTWAJUynVsEu+ovN64z1G3bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ff6N0jRd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fw4JhvUg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FD8eSN030940;
	Thu, 15 Feb 2024 13:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=ljhERtrsK5FvM74v3rFCfNpY4kuqs6Nyq9+zU+bMLCA=;
 b=Ff6N0jRdxJ6WnHXoHVCUgQVhefhcTv3YRX/VKV7+v9s/Yvovg8Hh2N4nxNd3eo+asOKO
 9fQbyyuH1TQiDf0Ph60VdSyjJVUyTnP1pE9YXGIS4hxnl2KitZlKhSoGQlVcbWnG/CEI
 jAKIjlt94dcnYB6ubv4WlN0fhoqCAZrQDqLvD70URIAxu0wF4ZU3MyqbE6L7/TcbmdW5
 wHo+/apZrZbPBCztKJUeK7zVWiRqpU+YPaMQILaVlYMblyDe/rnu1gROV/j01PhSYX5h
 QvmEdgDjsvwh0ZYt1XQByL0V6iVFmCGAPuf5tsetZZ+0DmMEFWbPg27R7uuEJjIUkinw Dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92ppj6ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 13:55:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FCo7iI015414;
	Thu, 15 Feb 2024 13:55:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykahkjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 13:55:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZnr1oCPnAk1eGXl27e7xB0H/EBbJzZ2E0EZvEljPcObu7PHOSB5dDx4wQboW+mnivf3/Kb8fWOZCXx4UNO4HmXAt3VvR5iLOffOu/8aOpWigfxHzJ7acsojf625zOMhm3GErZGMC3mO/d1NyKVWu21MpmheJpq19WxlsupClg3bwk2PMFPeKoUuBDV75r+iqHZW8L5XQMGEO/dzZXHp1qd2gm9cTjfRA6ifhpAGsRduxD+rYXwF5Bawo9YLBEjy108XaLRMQpNnjmLQzw4UiISm3ozGbajqQcvevP9cJFZtw4LwCWsj61ws0ryoO16UCYrghI0cOx19pNwoGIbISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljhERtrsK5FvM74v3rFCfNpY4kuqs6Nyq9+zU+bMLCA=;
 b=kkH9q6eCyd8s1aTP4TyfGXFd8pQukhGRf8h412RfTZvlmENNvgsZtgxpT7Nfm7uW99VcpfXSTZBiSeSbSf0igahTtkXtrMa/MOR+rxK0vAFJ1PdPVo4Jrp3KZehUNvQ5K9oOEL1JMuPakeHfimSDUwa89ldB8XAoLSUnc1eNpFGyEY5nMMcDTlSgL5nNUOk+5PSENcN5I5dEVfH39EMBIL3GFHcq9+Mkcc/QimotMafyeJW93zqeJNih1Cv4+V2H+iiAWn1448BBGjt2bejHDo+bXMPDHIwpxBv0UNdrrHOcD8O0Bp4SNl3ZqXbkJZZk/kf5vQMIbUk7r56xx2nezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljhERtrsK5FvM74v3rFCfNpY4kuqs6Nyq9+zU+bMLCA=;
 b=fw4JhvUg6CC5C5vD4GTimI6w442PiCYykHNroLtSJ15rQ2Bab8cf88dm5n0OmAtzjIpm24e5GwoGSSbSwfzAIxcggtqzIXGaruK+xcYHxXKiMuCLUf7rvrXcqqBxguIN45p+hH1mQWba+9LCv0fWS3gAKa+IKUBSx/RxRydoMpU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA3PR10MB6950.namprd10.prod.outlook.com (2603:10b6:806:31d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Thu, 15 Feb
 2024 13:55:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 13:55:47 +0000
Date: Thu, 15 Feb 2024 08:55:44 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: dai.ngo@oracle.com
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSD: handle GETATTR conflict with write delegation
Message-ID: <Zc4X4HsBZiXS7lbX@tissot.1015granger.net>
References: <1707846447-21042-1-git-send-email-dai.ngo@oracle.com>
 <1707846447-21042-3-git-send-email-dai.ngo@oracle.com>
 <ZczTPSSCmKSmdSnB@tissot.1015granger.net>
 <7994e006-b2e7-4c9b-9644-52225e1d9594@oracle.com>
 <Zc0DEuJ+jYevKc3Y@tissot.1015granger.net>
 <3c26b22d-5b9f-4a8d-bb03-ddfe802e87c1@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c26b22d-5b9f-4a8d-bb03-ddfe802e87c1@oracle.com>
X-ClientProxiedBy: CH2PR05CA0015.namprd05.prod.outlook.com (2603:10b6:610::28)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA3PR10MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ab36ec-61e7-42ed-3ef0-08dc2e2dcf72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	s9QpWYppTFSnho4xHzSo+Q4z/YlyodMQevT5Rsc56TSZEf0J+mjZYqgAs6gWNZ+PUOl6KRhBa6DDIqaRji5/6QksM5CdRxAT+aV7VCM3zFMIw8HSItecKo7v3UuptfrY4OuVayIlObi0WrBvT39jix9jfB+XNLKClMeMUBckXtzbW+Zm0VSn6gUAgjc2xuA4ZlFqDBr+X7pCSkjrvgpS/OwzKNrgSxveuAc7pex5coqeBrXkdAgoL2EYWMYkeFpW6/tv8T1C9M5B+smCDrqId2h3cvKky2uJm/Z4Xr4Qp8pG1/CyR0r1G/QQI26zWIZBnJ+07qGJ3WlkoY0BarAld8j+ePDlKs49LtUErB49baMHF3tGxg0I6EGWTdH7ooUw9mQYUh7z8ZqaM3o1lt5uROuZIzq3M3DNyU0c8ahDzK38RDn6R+dNyR2FwHg/5USwmEd4bapbbPIt/PR1B6BUw3j24VRnmmwDNJSrcDCXw+qh+/jhvztNs1UvVjGMgivXb/0d2zUu+DsKzwrXx2ZcOGK26WYdMuDkecOJRfP5BoppJCpF6qIYmWr3UXB+wYyx
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(5660300002)(2906002)(44832011)(66946007)(6486002)(316002)(478600001)(26005)(6512007)(6506007)(9686003)(6666004)(6636002)(66556008)(66476007)(34206002)(4326008)(8936002)(8676002)(53546011)(41300700001)(83380400001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?f442aKdlQGT8xbyWZhT7m0tX0lAZvBMAaGRaIqovJuOIbmSXBSW8VRn/CmmU?=
 =?us-ascii?Q?hsu+jwJjyc2dtq8G2EDoAq0Hs8t6SEIqjijU9X1KWJzPMqhob9Su/cgPXtzb?=
 =?us-ascii?Q?I5wdufUMOxesrusT9ydNArwfdzdnBk1u5zx1wOM9prd7yBgp+McU6toTYBkJ?=
 =?us-ascii?Q?dlfw6zVYQRIo3yEK9mckDrRXGem9lUVIdjRiPCfWczWn3llOhZ3Ldl+lxgOT?=
 =?us-ascii?Q?omb/Oh27LJHUtqJ+uQSIMjok/sSVLw+Adlva/MIzYjRJ/EmELpydIvziLL69?=
 =?us-ascii?Q?gAwnGND2DFlPQvvS+W5UExgtDw0KtmYSoL0VhwzD9cnnchZKEa4fRQIYYYxH?=
 =?us-ascii?Q?DM6oisJR6WEVXfFJvpJ97T/1qT//ogAFMyWa7hVPt4WFKJZQfGLhVHLYKQlo?=
 =?us-ascii?Q?gl4xDZSm4qKefIobq3Au0qjyrfp8mPT6jhzoIHGAnuKmtvGSAsvI0dxwH6yR?=
 =?us-ascii?Q?ZtjklqfI87+Q9JJwnvf9apdQSkfjQEqPczsfdATyoNKfqhRNo4cF5fKTrQmL?=
 =?us-ascii?Q?DSIOdjM7pfxzALurZbdarLxbvu44FIqnXCyJjhvHYwb8iEekFuPEAE2CT4qI?=
 =?us-ascii?Q?i9nQ2j9hh7I12gSscMBmE6DJB9T1a8Q71UHnGOYrnQmKxIqTSsnWaRkLePAK?=
 =?us-ascii?Q?DKw9VGr3WLsJlY33KKDuyWZu2m8NgwBiWWDCgaT+LjTq8cdd66wy7zk9UYVa?=
 =?us-ascii?Q?26SwGs4HmT9KfTnBl1FsbcVqkgcjCxJKCn3Ily+1fwhML+CallffCDMzFivs?=
 =?us-ascii?Q?JIY8jqViR2CMKQuy1zsLw/xqv9p29ZjGmVYTKvb+VBAYzl0wm7AXnI2/xeLW?=
 =?us-ascii?Q?7RcnmSzcMnqmts3LsFvsMshaOA5Oszl23RTXLRJLoWBVZL/2G/VsX85e9VlK?=
 =?us-ascii?Q?UdV2aCPH5d4/SUnx/H0/3TUIgf2TYjEHJBIYx9nYeju54cZLygWQEtwRNruA?=
 =?us-ascii?Q?Dqh45OXotk+G89nPRHGi1aiX8aCe8aN9n7yyhnO0YQLjwOzpkhx1qWhGDyGR?=
 =?us-ascii?Q?afbIagdszUwmM2VgBK/eghp4Wze7cefoE1Uldgur/b5fsEj0NLROv2h45FIv?=
 =?us-ascii?Q?oW4CV5chCcGFLVFJtl/0kX+uOIxUKVvWXqF7R1n7vAmshzjcYQjtHSiU0yLt?=
 =?us-ascii?Q?rcyDI2y/be8EPOO6ktZsNUwYStUSbR8Ak5YX0qm5AvanpDR9HPGyLV+ZVDGL?=
 =?us-ascii?Q?hirQgbpZQyAMX8a4Y2Ll3+aKs2zvA8E88FRDb1OkLtZAynXQgVygRMV0lyuA?=
 =?us-ascii?Q?CnJTpjVVZO2dpumU7SNbffXHkT2ptcPrep/6tbDmfor36RK/R8IfL+Twql3u?=
 =?us-ascii?Q?+b+/MZHPzVfAMr1Uj/B7uLgq/GG6Zrl55P/5dFEqvqLLE6SfWB6jU+RTEoux?=
 =?us-ascii?Q?DRMQjubjKgfanpTmNhcTzQ/y8yUzCb2p71g5jjPvafhPjuNlE1WB/641nQKC?=
 =?us-ascii?Q?zMkdvubauZTfrVRSME+Ew87pe2q42XTKrlLF2fYwZU+8k4t+7/Hhg72+4BJA?=
 =?us-ascii?Q?IRMSGD/Vg788e76RL7TbQQo3KhjnatX/u2PM10AmAEm+fklltUlxrI1kjG4Q?=
 =?us-ascii?Q?JwCTo4QlQW0NeDD/r6srBgcyCKo32ydj8ASlrGqLcZ7daEiM518KkSGZ9boi?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8WzPydOkYOKqItTCkwRSawW/UYvjGyuGx3pwo88N1oDDzct4Y38ryIdjq52tzXwOTjIK/0PbiUvTwqUFWrTh0E/Abd26binlWCldaNbkFdHEA9CGtH6cpenmoTzhnvuco2EKvnC4o1AMWPL47CII0nCkjrsuSZDDA3/izo30hEEXnn/NYZzhkBpq+oXqL6G0S1LBjKb84DP6WuTm0px0Xa/Z8AtIpvpicHXFRVHU4Gqpq5piwfkagERQgIb8INhX9zklRN7GHYOOm6uK68oR1ekJhdEubxqz4tBPWfw6rH0UHswnAxcrJkVfRDBvtsCQPRJw/MfzeNqHU+BRLOv+nG5ozNICAZ1pLj1kWTdn7InJKzxYfzVYlvbSeUpW/bhlflMo3j5HdeO/qHY4uxRUUxrDHdft2EdVSS/t+eCmFHGmv76HEwWrlAX1zzH6nkLeQcc25FPOJEjaWyKUkQugAmnga6FvKeR0PnXc+OTyOaWWDd8vVa3PtqFzjo+gc/OOX0sJ/NZT/n04EmQfTU+aB4Xoge6q4loFmJSZdM+XubeE81bKpPf7nAqt+ELi315YEh7ZWcg0pxyphdASarI/xjmxQOvI+Jnt5CHWub9ya+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ab36ec-61e7-42ed-3ef0-08dc2e2dcf72
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 13:55:47.1417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URbvH/pk5/OntLBoxMxn4Lwgfg1kuR2kR8X+CCetBXdGsUdkzmqxicIHKEhBl1m4lSv8ttYjXIFngkEgrdeBMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_12,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150112
X-Proofpoint-ORIG-GUID: rkucsyZ_yCZIO7cJPynKhPVxnLoDsDwL
X-Proofpoint-GUID: rkucsyZ_yCZIO7cJPynKhPVxnLoDsDwL

On Wed, Feb 14, 2024 at 10:22:05AM -0800, dai.ngo@oracle.com wrote:
> 
> On 2/14/24 10:14 AM, Chuck Lever wrote:
> > On Wed, Feb 14, 2024 at 10:10:50AM -0800, dai.ngo@oracle.com wrote:
> > > On 2/14/24 6:50 AM, Chuck Lever wrote:
> > > > On Tue, Feb 13, 2024 at 09:47:27AM -0800, Dai Ngo wrote:
> > > > > If the GETATTR request on a file that has write delegation in effect
> > > > > and the request attributes include the change info and size attribute
> > > > > then the request is handled as below:
> > > > > 
> > > > > Server sends CB_GETATTR to client to get the latest change info and file
> > > > > size. If these values are the same as the server's cached values then
> > > > > the GETATTR proceeds as normal.
> > > > > 
> > > > > If either the change info or file size is different from the server's
> > > > > cached values, or the file was already marked as modified, then:
> > > > > 
> > > > >       . update time_modify and time_metadata into file's metadata
> > > > >         with current time
> > > > > 
> > > > >       . encode GETATTR as normal except the file size is encoded with
> > > > >         the value returned from CB_GETATTR
> > > > > 
> > > > >       . mark the file as modified
> > > > > 
> > > > > The CB_GETATTR is given 30ms to complte. If the CB_GETATTR fails for
> > > > > any reasons, the delegation is recalled and NFS4ERR_DELAY is returned
> > > > > for the GETATTR from the second client.
> > > > > 
> > > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > > ---
> > > > >    fs/nfsd/nfs4state.c | 119 ++++++++++++++++++++++++++++++++++++++++----
> > > > >    fs/nfsd/nfs4xdr.c   |  10 +++-
> > > > >    fs/nfsd/nfsd.h      |   1 +
> > > > >    fs/nfsd/state.h     |  10 +++-
> > > > >    4 files changed, 127 insertions(+), 13 deletions(-)
> > > > > 
> > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > index d9260e77ef2d..87987515e03d 100644
> > > > > --- a/fs/nfsd/nfs4state.c
> > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > @@ -127,6 +127,7 @@ static void free_session(struct nfsd4_session *);
> > > > >    static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
> > > > >    static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
> > > > > +static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
> > > > >    static struct workqueue_struct *laundry_wq;
> > > > > @@ -1189,6 +1190,10 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
> > > > >    	dp->dl_recalled = false;
> > > > >    	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
> > > > >    		      &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
> > > > > +	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
> > > > > +			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
> > > > > +	dp->dl_cb_fattr.ncf_file_modified = false;
> > > > > +	dp->dl_cb_fattr.ncf_cb_bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
> > > > >    	get_nfs4_file(fp);
> > > > >    	dp->dl_stid.sc_file = fp;
> > > > >    	return dp;
> > > > > @@ -3044,11 +3049,59 @@ nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
> > > > >    	spin_unlock(&nn->client_lock);
> > > > >    }
> > > > > +static int
> > > > > +nfsd4_cb_getattr_done(struct nfsd4_callback *cb, struct rpc_task *task)
> > > > > +{
> > > > > +	struct nfs4_cb_fattr *ncf =
> > > > > +			container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
> > > > > +
> > > > > +	ncf->ncf_cb_status = task->tk_status;
> > > > > +	switch (task->tk_status) {
> > > > > +	case -NFS4ERR_DELAY:
> > > > > +		rpc_delay(task, 2 * HZ);
> > > > > +		return 0;
> > > > > +	default:
> > > > > +		return 1;
> > > > > +	}
> > > > > +}
> > > > > +
> > > > > +static void
> > > > > +nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
> > > > > +{
> > > > > +	struct nfs4_cb_fattr *ncf =
> > > > > +			container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
> > > > > +	struct nfs4_delegation *dp =
> > > > > +			container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
> > > > > +
> > > > > +	nfs4_put_stid(&dp->dl_stid);
> > > > > +	clear_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
> > > > > +	wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
> > > > > +}
> > > > > +
> > > > What happens if the client responds after the GETATTR timer elapses?
> > > > Can nfsd4_cb_getattr_release over-write memory that is now being
> > > > used for something else?
> > > The refcount added in nfs4_cb_getattr keeps the delegation state valid
> > > until it's released here by nfs4_put_stid.
> > If the client never replies, does that pin the stateid?
> 
> Won't RPC timeout on waiting for reply?
> This is the same behavior as when recalling a delegation,
> nfsd_break_deleg_cb and nfsd4_cb_recall_release.

Fair enough. Looking forward to v2.


-- 
Chuck Lever

