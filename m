Return-Path: <linux-nfs+bounces-1407-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A4B83CA79
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 19:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC431F27374
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 18:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D8B133994;
	Thu, 25 Jan 2024 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KJntqQiO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dKjcxM56"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDECD133982
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205803; cv=fail; b=nHnz+tFR3063adSjxanU3rkw9U2X+iqpmuAHgEyd89hWi0dckiqD+v/e8Pu8Gug8RwWXad891KZB1S3WBzxpv71+xT87ax+uniegKxNzPbCtKFlDRnxYRbXBpbnaArQiByinQg1LkkzBKO+23WW1OHFH8E4VwD+0eZjV7jZJ8FU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205803; c=relaxed/simple;
	bh=djV9il2vMByKXb3v8uzMTf0YcdvNKd/1m4AQ/X4NkR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bvX0ixBBKQSX4XoW3XWItQh0Abmz3JEbjhx09Z31VxayOMl69mNv4VCm2yNdIMjfL8NO1nLZ6L3lWwxAGEgflVs1dvgYUTO2PkXF0e6Df6MNlhQDRcVD+iqlF2gHkgaovQoG3etHTarnmkji3RXndOJ7pQYipVXQa8wHpFR549I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KJntqQiO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dKjcxM56; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PGoV9c011472;
	Thu, 25 Jan 2024 18:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=GBrHn7AcJWaOn07WBHE1qQh5fG7zaJZjtosOyevboRQ=;
 b=KJntqQiO48hG6XS4vbhU41Vxo8iruN+Yt9FWU/VUu1KmM2kX0lcGIY0a2QPX0AMOwzxh
 Sday9o4WHy4yAtEu9wB4ZPPC5j65JGZoamoiJBznELwUbTFODcNAIpVKbcl/fC/FIv71
 7Byu8iAuLxcvLC4A31czXk1oyizx0uKMhVAbuWb5fAVm/rOn2LkXZ6IxC64fPTcsidEB
 GnFFTgM3wQx7N1GSIDbJEklEkuuAPClIy/FlSA48xceE8dreuhqxAscwF2+LzPG6PWBv
 G9fYIR+CQdt+EoaPXw4FF4TNsblAqbleUOmCYlkvf3Wf2RvJBvE+P+759+JgHa9arWWG XQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cuyu37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 18:03:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40PHnMgK030682;
	Thu, 25 Jan 2024 18:03:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs3758d2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 18:03:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT3dKuaT1RNWSio6KA0cLNfTTo1uZMlW/b+Uykw8iff0QDI6sBJXXmkKrEYvBQqEuA9Q4MG3WtiG8BS0CEVmmJcLCA12t+BfYpfDxYgH7hncecZfH2HUcb+iM2+zZiqEjffmx2p6x9zQs/txKC9EEn+JaMFl+8p0mGaW9Lx82SyVUFCiRPupMmBZ86sJ6kP0QGYy1A/J/7lKZoJVbC3jEMI6o8FQb85IDUCmjbF+o+e2bmeRzWTd3cOCWFzG42FjleNkLz3k8shhYEtc1lXIvLCmbU+7lf39gS+r4ZrymtJFgWVs9nm6gAVDnvRPLa8HcA7AlosDWcvCzsjtIalOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBrHn7AcJWaOn07WBHE1qQh5fG7zaJZjtosOyevboRQ=;
 b=TkSAVbpN4KwiKntmyL8FpXii77rVA8UjHOfr36ZRY6bwM0JBfHU2WTxVit/xnORF4nDR2nNs/BxkYelNH/4CzKGHu16OZVfPIYd8zzISrUrDYXxhFg6SwguyQyLCs4/b/MzT35UvJAxsO7B24RLmRiz3BdBzpGFGG3e25G9nJt36MI3f/nXjjfeZRKWwJeIyLaMp1atsELlOapvmVCBoM2rDO+hBvuzUNWNpJWvIFL0xPZz1fe564fAfxIosx0yiZcL6Zv/XUz0k30dtxTvlOzUMJpMrsI2sWQvoaCsfgq5+7L1kxmdnw88dMqg7cX11lGmyySdmsKFOr+FCTwQgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBrHn7AcJWaOn07WBHE1qQh5fG7zaJZjtosOyevboRQ=;
 b=dKjcxM56nEHTVPbaTtGqK2zmGnvp73q3Czp6DK5I7iPnX0a6m5r3ufxpP+sBmF4kMdKH7L0sgrewqpujuJM/BANc/04t66RGKmhyaBFHHVryDLDRgOyXwNV/GvFqHGG7PoHAX4l/K4WwfGazlmgy9ml1b7OLvIS8hgJwNSTX9OU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6918.namprd10.prod.outlook.com (2603:10b6:8:136::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 18:03:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%7]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 18:03:10 +0000
Date: Thu, 25 Jan 2024 13:03:08 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jorge Mora <jmora1300@gmail.com>
Cc: linux-nfs@vger.kernel.org, jlayton@kernel.org
Subject: Re: [PATCH] NFSD: fix LISTXATTRS returning more bytes than maxcount
Message-ID: <ZbKiXLK9LocES/jZ@tissot.1015granger.net>
References: <20240125144223.12725-1-mora@netapp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125144223.12725-1-mora@netapp.com>
X-ClientProxiedBy: CH2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:610:59::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c1cf21d-cf89-4f1c-1c51-08dc1dcfe46c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cOyUlRFQO3pp3J/bU8f5B4878U8NSC+/Ypqdz9zGnKD/F7RAoTj3gkciQTRh2HZH5Ecy0B1cc3F5ERUNd/GgLH3mEcTlrrxyGrJOZaM2nnrKADZIUYm4eJYE3IIEaCw4Zvnx8I2V91q2X14jENBaFFpK3mbOVfw7ARcDt/F0tj42AoB1n4wozJzDMSMcyGxO/msWuGKgBRxYeQQma5a2PEKb6v/fPfKQdCGPD5xsMp5/r9b/bSJILUHFQI3hWZ6Ux0zL5xKzci5oOaxn/flFdROh9jusYRa0DYhCc7S6BuBAeipBH7ge7QGH4YbWJIyTnVR3aaVH0XzzfZnAMec5L+lB/fYcIYH2nV57+0mYORYLYWgQQ0SA3yRmcCID8gk8B+k24p6kKA+LWLeIKJvpnnhMX9sgxNUHOGDy5VlnoU+q6wfEWJCrRJcn1ujhqrVGQQEXFo5UNnLvLWmK8R6aZVbEygKC3ykXIS/TZjN3gyCAKoAsdaN58sZRSWwZkXPtB4g9fZs5J5QzEYL1EjVSG96sHIWHNeLzwsPLAGalvB37Q3O3WELjl4g439qJd97JKUlWaIJZ4o/aBH8DFq7GgcZ3dcRV0zI4J3fZ6ITlSjYS4GGZ33LmwL3YdG7vd+/2
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799012)(451199024)(186009)(5660300002)(41300700001)(2906002)(9686003)(6512007)(26005)(83380400001)(6506007)(86362001)(316002)(66946007)(66476007)(66556008)(6916009)(6486002)(478600001)(38100700002)(8676002)(4326008)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dJ8dhdtdaxLABfcVsgRA4aAzflW28hciQUIdabC+oMUHBYfqqVoJOKX3Izqo?=
 =?us-ascii?Q?xrLi63qZxi4FnAmLhZXCPChNREuih28d6Wt0X+87QwQ4PXO19BhMIln+s2g1?=
 =?us-ascii?Q?Xie6mt/XtRX6ulFYpVAk6uh097KUGq6zSkxLDU+sbeKhDRYeWOxKTdjYkP1b?=
 =?us-ascii?Q?fh5Zj0d82o64/sgw394qmQyyAS+oNqH7+wbhdoJztQJzvJ4qBNUsurJazrgP?=
 =?us-ascii?Q?oQoUN684biL/sWttfJajblDt2D9E3vV5friV++TNgR4Nd/XLVmgZCume3NJ9?=
 =?us-ascii?Q?1GVii0XadkHzAd/f0FCQCggkXPJmCAU8UMAV21iA55engHg8BUOR1pw1IOUP?=
 =?us-ascii?Q?RkpXglJWj8yGAZWcZUP/w1PLgyYYY+lj1nz+g7IcwUbtiWoFEBfRD5wCA8t+?=
 =?us-ascii?Q?CphD1N2fU7DanCHB+GMfgR0aMXgWJ+HPIOf/5omARkTik602vXzYxmFPiYOY?=
 =?us-ascii?Q?6627tYhn+taC8xZ2XacLTix76Pba9WKriPYGnSWlYmzc4n2CvV00/Y3j3jfd?=
 =?us-ascii?Q?Y0DX79N6ipdWpNdeO9P2v8pC4RWlS5QouCgRI6r1IwR+PiZanPte/4fWayWK?=
 =?us-ascii?Q?hZGAO4tPEDJNZFY8xqmIByWR6HhUXp+K3Tpa96mvhLqxzLwouYD/J/CLYI2J?=
 =?us-ascii?Q?oZkF9pla6wgy7cj5DU4dVTKTIyL0bZcS1Pm+wCeVkSvCVeMnJ9P0/eV1QAcP?=
 =?us-ascii?Q?QJT3L2cdep6u6lZz09fDaAbk4GUWj44VeAg4hwE0DetbuN4SsdrZbvOo4sEj?=
 =?us-ascii?Q?e4YuJ3BSgXjmv89CNahttYKY2h7eruYtcrDIX7FM/B3MQBsAo04XVUZ9TgJM?=
 =?us-ascii?Q?MlPTIf7cJLAfWnzWNwxv/Xo9NW1pe54QMILuT8vWj9beNMG6lOaC+HGaho0U?=
 =?us-ascii?Q?441T35+9F25TnYQjj6MT19ZkunS7ap//LMT5XwuTLH8jYIUcWBWHHAQ/4796?=
 =?us-ascii?Q?NmUOgdjbcPGYWgJbsYaYY+T2xIPOwQBtRdAFlS2v7v4ZOF+R0V+xHCIIIvdr?=
 =?us-ascii?Q?c72riD2jGyusatqoFZD/+YFC4ZibgPLhpksG0gt2FfooKkio38PXWpD+6sZh?=
 =?us-ascii?Q?45RjP7IgpwlUmjOgb5oTCutpmGZ0u2R2Wi7JjFjVzS28YshDfeCNriJ4fXus?=
 =?us-ascii?Q?Se5p+Ju7BFozgASU53XmuuIIHCx6W4G/jkGRf52A3ivmYA3R90d5qUovJKh4?=
 =?us-ascii?Q?oBMHFtOpNzZoS5GV98TH+wH5TzRTIIBvk9jHjjqQYJdVI2i7y24W9qCkpjRg?=
 =?us-ascii?Q?wh0vQDUWz5rxQ/LGk3LP9d/PE3yg7G8/hkN03rQiFOabkPuVaPFv5/QcTNeR?=
 =?us-ascii?Q?CrzaiJH0QN3fu9CjoADCszBRGzrDfuGJ+Wy3g+PvT7SgUrnCfP2YAzwUCkU4?=
 =?us-ascii?Q?uIaH1Px1/UXHzHkYSUhRARlEL+McHz6qdfWp+FDZFZA+7GfFZv/iaXZh5Kxd?=
 =?us-ascii?Q?S7zlaXAT6jXvH4FyFtjE443y/AiQifjhViPK7iptyKiTHNim2nBrQ4kHIadU?=
 =?us-ascii?Q?qo3t1NkogNr+46uJErAjoIshRpnyXoR05I8pLtXB/0b4ZtXtcFe2Kt+ajRZN?=
 =?us-ascii?Q?yQmdA67BU6dPKeh6l3GUSnWRioPueoyc3qNdI+HvERZ0uGkAlgpYfIk5qog1?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	evuntdUZe+gf/Yba8EHAT6xVfKfOvUOv/GCuhpiO09hkgEq3N8KxU0h605hxSJ1dfm02b9hThE7KSXR/teiyB7lYyPhrncexNNalwvtN92S10G2J47NOUSgrP31ac1cxbrnPzLcyUBu6igP2TMi3pfUPBUAQJmbzigiA4at2e/G2F4yDOkCdzolQTQpkPid606W1vxYBytoZDFhJOjA5it1pqKm8zNP6seNHWZ0mLi8IWiyD5P7ukbs5cEZVko/lEKtWPDUh7gZCAd121r2sdiZODG930SXOGvXDqz8h4VJ1w2YxKpUkGhsvNnZ31HMpRLuaGNTRIFgDvc+6cVsYTi3PzOT8+qYKKNy3VBjH3bQplHz+PPYUeefTcJoFYlAbVnYca9BYeJhd9YvnuADbyAbOhybO9CZpXrkmyYhYIuyzEBtEqbiVWeNPwppVTXBXv2nexQH9rEEOA58jOxBnrRTXuHIW7c9Km40kAAhnIQ8TNHF8cGZjByUP4kDlkAvdeSsi1vHLg/4ybc8iuAosZmXeOuZfXehlI8LWRwh5xqi4kpbbwc2vx7GxhaioHs5XKzRFn9oImzhVU9Zmh7BQUdZ6dM9sBikoDijpsdjzpJY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1cf21d-cf89-4f1c-1c51-08dc1dcfe46c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 18:03:10.8602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaeZb9afvnNhM+D5sx1dQjSRXTVok0UUZ2itMEwUCLmrZ4tcF6XhjOuAdOzyu/j4yiDLspwUVveSl0sipednng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_10,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=661
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250129
X-Proofpoint-ORIG-GUID: 3ESyQJH4VVfR2Xg9qV4WtK9mNHQUItu4
X-Proofpoint-GUID: 3ESyQJH4VVfR2Xg9qV4WtK9mNHQUItu4

On Thu, Jan 25, 2024 at 07:42:23AM -0700, Jorge Mora wrote:
> The maxcount is the maximum number of bytes for the LISTXATTRS4resok
> result. This includes the cookie and the count for the name array,
> thus subtract 12 bytes from the maxcount: 8 (cookie) + 4 (array count)
> when filling up the name array.
> 
> Fixes: 23e50fe3a5e6 ("nfsd: implement the xattr functions and en/decode logic")
> Signed-off-by: Jorge Mora <mora@netapp.com>
> ---
>  fs/nfsd/nfs4xdr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 92c7dde148a4..17e6404f4296 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -5168,7 +5168,8 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
>  	sp = listxattrs->lsxa_buf;
>  	nuser = 0;
>  
> -	xdrleft = listxattrs->lsxa_maxcount;
> +	/* Bytes left is maxcount - 8 (cookie) - 4 (array count) */
> +	xdrleft = listxattrs->lsxa_maxcount - 12;
>  
>  	while (left > 0 && xdrleft > 0) {
>  		slen = strlen(sp);
> -- 
> 2.43.0
> 

All four applied to nfsd-next.

Note this checkpatch complaint:

WARNING: From:/Signed-off-by: email address mismatch:
  'From: Jorge Mora <jmora1300@gmail.com>' != 'Signed-off-by: Jorge Mora <mora@netapp.com>'

I'm not sure whether that mismatch is a critical problem. These
look like good fixes and b4 says your DKIM is good, so I applied
them anyway.

-- 
Chuck Lever

