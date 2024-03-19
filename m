Return-Path: <linux-nfs+bounces-2396-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F39D880030
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 16:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1859D1F22860
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223C36519D;
	Tue, 19 Mar 2024 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g3WYaxEz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qJqPbol/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310A42E82E;
	Tue, 19 Mar 2024 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860602; cv=fail; b=Z1f0mjMJYv94JKALTS1XKe4CfKkVhNsdJVhnai+xNOy1xOFrViZf6BfscDqZD7Zr/PEdHPrKJ/RBDn64PJT+3mCwXWVVOj/0XA2A+sdMoLwou/cEkfJrxmpckHS0iSLCBYI0M00oo1VFEEQVKHjm8Yq17wUAh7K+Ni4k++XORSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860602; c=relaxed/simple;
	bh=7BNc7OQBbUUc0Jfimd0r04Q1G028U6QPbRNvzXKYP1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NWEXqScmn1omqbCnlAUPSDpnv+4cLPaGLM/BYjxAR+UWYYOUyxF8i0tIeW4b2ErMXc4xSoOa6aiUryO6l+kqcukLjWcDMM/qCw2HmF1nrY4lh/bWqbiED77UDfpu/TSd4CPvUe07+mPOG2DwPAAeAsVzqnyqa2QzYWObjlVsAYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g3WYaxEz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qJqPbol/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHf2s013476;
	Tue, 19 Mar 2024 15:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=+pwD33i7ZeDntEBIiXGnBBWOq78N+YuTEjqXYBmHKbo=;
 b=g3WYaxEzKiIGZrYo+WcwClqwrd4hazoD0pgfw/UxmlGDfcBVe0PfY2dljxRYsSEox1ui
 KhcJCf+q2J4gFYmu61uisM7Bzf4Hc4PleAkuS3ammgjI/BaXu3D34JFk2FXDrYi5qSQw
 nN38eDQGKmwTiPtnLpi8vb1iuxsjMh9igGexTSxhOZDXa4WoDe0CIerDpqVakB/VR/GI
 ZLuNn9TqasqxgdbgJKHNgmUpJLvieyeFPcnEDx1Ftd8hTuQHpANnVXMcF5GWghj9THCQ
 lKWlwcDx1ZBJZLXb59dPKiq5qJQs5I3lMTFnlsleWcXGoIi44Fe6AH0UBWXqHwiWCqq4 2A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww1udds3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 15:02:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JE2f3k028739;
	Tue, 19 Mar 2024 15:02:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6cbkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 15:02:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GK9V7M5eHGy9W6gwUt4QThNWOJJelQvHAzi2arEESLWUX9zq+w0VHb64NRExqazcfCYSfDC46xq4pzDkV0+KmRjIvk606LkKsaEM19RorBGe15B9zCbYZSSlRDQLdcc6pd8Wwfg4zKXr2z71gwCvcdP/Q7sen30HYo1KIKoEYDfRfJ32/kOvKoy2U6jiTEzngIga/Z86+j0FbJOwP1a/CzhskMp1OxotiVfFZkGd6SVpMocD3qVaCnFW0G/wJVnqEi8KOhkWhmgPtm0lGoVO+v/KKmN/2RdqFGK/4ptMicjcv8vq4HVyzzF4mUMJEuqaQ8NUGCsBFHx0A7C+PI3bkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pwD33i7ZeDntEBIiXGnBBWOq78N+YuTEjqXYBmHKbo=;
 b=PU0C75TLi4AcSq6vwPB6eFi8iAin0qUOhweWmEoX2LrEHoYS8ag113SH+1JKtyuqBRxdzUEUzMwQRjLvsL8KyDqY2C/OAUzjpjsY/Muai1M8P7GlXbZxfrTJ1f8j1VRhDABaXwDTpezkoYr3nBKxJiKVJfsG/vEyHzDz7FzSEWRQ/6bcp4gnjS8D1A9jq7C6RaDqE8vcxRb7cwX8eHzBE7SEfZEiZYjc9EWdkV4pDiGy86viRoheo8jOHd8Q7+WG8wpjQGt6ktERZYH4sonsMf17eB9LAc+7q18RmWGryOTAdfTPotXGOAnqmdkMkUQgRcM0J6hu+mQuPwG6Bbm5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pwD33i7ZeDntEBIiXGnBBWOq78N+YuTEjqXYBmHKbo=;
 b=qJqPbol/YMIppzF5i4Y6eoU/ZlKFw+3F2c3gnkfJ2Oj3mGr8fClPC9n+lPEiQ25fJiSb/ziaibPxEE5277ejVAnXQKOxA4OBjepwEKC71NnmQ66piIbGSEbyi4Cr9Ki0q3wUs28IP6zjRSXIQViH5RFKvsa3N4Zdz1nfNN8Lcho=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYXPR10MB7897.namprd10.prod.outlook.com (2603:10b6:930:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 15:02:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 15:02:55 +0000
Date: Tue, 19 Mar 2024 11:02:52 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: trivial GET_DIR_DELEGATION support
Message-ID: <ZfmpHFMYFmnIiBD1@manet.1015granger.net>
References: <20240318-nfs-gdd-trivial-v1-1-158924b9e00d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-nfs-gdd-trivial-v1-1-158924b9e00d@kernel.org>
X-ClientProxiedBy: CH2PR07CA0061.namprd07.prod.outlook.com
 (2603:10b6:610:5b::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYXPR10MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3350a4-7f6c-491f-0af8-08dc4825a86a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	idcgqO/PZgYt7CVcAho+o9619+rd8eRQO3XWRI05LSKrOXEg+skKtJtAlOBJWnONyuCYVzO/D7miksqt3Wm+O6Q2KuGdKErmXe2G74xAELXkgu/bXIOvteDZYkgECygIW1rIRfuZuLB4BxX7KIngYywtWIOHYWpQTGcQcwyIjK6MaqftbkQss3y68CXrC2rYd7JWBem+7XTJ1a6N9U7HNHHh8XLlarRjmEa57w0MvOhID8J+YAF+Dhswf4lRaSmNkeB0If5yztUtEyQ2Qx2GtecZBVxO/9DxVWJKktaBdR/bgHDz1bYIus7FPi/925zFOo8zz8r/N8D/bS/c0sgpccE2lHUzHZOdEB0yczvmUonwdXkF2GSes/l8rf/+XhFeoSUebHbC1yCYinkQ8It9craoXFkglDI4VOq+uu1pYAHJ7JOGJaAyYiopX7305pCHCq1g79kkOS8Obxgj9VN6xdp4AMsREmpqN/ztK7768lSVWOVjK3CMqEBARX13He1TyED9s0SvvJXuq0PbN0tGYdoqzpZ80c8XSQDgLhwAzM68DFVYkwrS9bf2n29lM6RvvTpNRPJiWRCMh8uTjtPZvGxEqqYctOkcC4kIHDGGCcCQ3GsQZYcUgddViXCLbzvcULsy18SKYBudthsfIYb5+Y8EDckXJG5p0KSxRWrxuik=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BzE+nqL4Nc2Ysfiw8rOxvkYI+/pWmVqPOAtUxZiW8whzRxKhX2lsfelqE2LK?=
 =?us-ascii?Q?Wp4p+ilhftNZOe3QAA+xKtS4P3lFCgPrWMbjdFeBvQx4CZLAJ+7t7A8gDVDi?=
 =?us-ascii?Q?LI5V/heOTsrdswANLUIxlY0asz+pfU+bWEhuWgopk7H2ca6CP9I0/pLPK264?=
 =?us-ascii?Q?d9q64yLgZivtLduD1+Ka3GiRpqoN/3411mnakJ3XE2VykYo1pIELhpo/q1uk?=
 =?us-ascii?Q?ILl9LznG9T+Zydqli+sTTFcwCVZbBJM5JwOfcqUfsyVN+K4Ghof9rpADo+nH?=
 =?us-ascii?Q?ghAli+O0VGBhlUuzt6TDrm/PLKAksVJAa/vWPHYfGBCUTXO2QWc4OW/k+29l?=
 =?us-ascii?Q?AS/Fh03lJ9aVySGSfEQbmlTA8gNpVIu0kVRdpzm8RShu9FkOnFq40cVW0Jri?=
 =?us-ascii?Q?eV4i2VL3E682D6yD35Ku9LwagP5etq6zMwgomQmpUmOUvcfvg3Nwgl3/kRPZ?=
 =?us-ascii?Q?7ZjtWYwLzY1tTI84ozLnywofHpjfeu7a+JhqBoOFnugjiaVqqmiv59t+8YpJ?=
 =?us-ascii?Q?XRX8mrStnKjxY4LvXvGPXgkJ5jsKlYXBNqLX8q9E0B9IPN7PTzet+hClhc11?=
 =?us-ascii?Q?XTxvlLSY3Wc3ZI2VerMoJtkE94FTdT2bwGOQaXEHJYhQzohETtwHSJwFDvrr?=
 =?us-ascii?Q?NtdFKtxk3F+kegsoTkycSToY3ZAjpGu+4W4FP2OGqGcTpoD5D0DMNvgZxe8R?=
 =?us-ascii?Q?mjJTrW0l8e40t9OXnXLvYXTg1Vr5KNau4iY4HbE+cakupn4VrQ3vnXiDrOzy?=
 =?us-ascii?Q?/QvpqEDjXWfptlDw4G1EQf2hC+P2NSXV36IyPCv88vRmXrfO10qj3Ra3WRbj?=
 =?us-ascii?Q?N1xcZZ2E+sQGivohf3eXh9TWsjjeqASuzQDlyj7R5qrsdSi2eeX3jkUfsia3?=
 =?us-ascii?Q?vzkQGeM1ROSjS42neKKwPUhLC4PA/ZEVynRhWtWaHtGLDvfz+o5mzg8z8TTi?=
 =?us-ascii?Q?c5UgcGfRwE8PdbZEw+OghAj/y9eBZEtjrmUv3bhdWCUhSf19VTLgKbOQwhSS?=
 =?us-ascii?Q?D7svr3I+XSk6ls8gyygGxgLjunzuihEApS25/+t9+4bQSKRSd8YM+1u2Ff6r?=
 =?us-ascii?Q?emj+pP+yUcDCnelxyo7YKe7Ol/znPcU/+SnnvcUWR6Bh8IkyA/sap9F7/mcn?=
 =?us-ascii?Q?V+BBYbssVeIgEFax8QazBI20bmYuZOphgXQdSHeWYkwdZBQTo/Rb6jyQrYRB?=
 =?us-ascii?Q?JtSI9VAumhwpEL3XalSchK3Sm/ulFemh2WvRig48cgepoJ32DzqIV//O2WOQ?=
 =?us-ascii?Q?qv7cgQLPUT73d9+HyWY5DmC2D8MxIHGXbeSRc5jwEGOwDbE8Wia7GhwMsrLV?=
 =?us-ascii?Q?mZaPpa30prtNsKvI5Uai1/mEBJAKEUokrLzdprwLkkUgOH97LDnchZpLV67+?=
 =?us-ascii?Q?WO+28nlkS8QVahlr7F7h6OFovHnvEdd7zjFuMPG70sAyHtXfqt2MR0WhaX1L?=
 =?us-ascii?Q?AKI6AMvJjxt2ZdPjcI7gXQS0hZirRWTHds8rFWyV3kB/0tYXTu8A4OBWY2cE?=
 =?us-ascii?Q?Fkjblg/6LAjecHxvtDqN+Hcc13Kk5vjKKkyiVhMbScDFYRN6pCMP++9WXdfh?=
 =?us-ascii?Q?dUMCRctMzN62Opngc+MDUsdG/s7phMzzfyWGAtyqCA8t3QPuTDf1FXRpF35Y?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9JtpsRuYrcoH+tBaOTsPFNxvPM4sBzvYdQ5eg+vpdtmnLRQ3dE4k8Ebzt9XhzS/qWhtxiKX0bmbchKkPwrGN/kDRK5VQW3+qaavQb7B9KU5hiKQvaJnJwIIanuMM/Gmp4cF3/++fKW3EvSY/TZ5uTU7WtiDIE+xOsz61+zVhjcOaDwy8QF/+ZwaSO36fLGGtk/a3LLbfCxrDVjYmmrQTxz6xW9H2BBD9Ng8HPKsOuOBrgxS+2wWYNuHnEPak7m5bmlb2I36ghCT4p+ZglCok9QSJ06q+KwmgJ+kGEv0xO0nVr4QE2MHsK934vLk3wLv72k4v/R5hTh6Npju91G8lZE+c3onS0sAqJPhvXLf+Q9KvVoFUuVvunZ9L9SI3/4FY4qGhXq3WKaMuF9kyLrHRTKsV/WmCuKgCS9/7RCOJWWeAQJLjTNZ7rH1O07xiJUjFDfuj762uTlXat6PCaukE2XWoizEg7ylhTXQIQmtTlOhKMbS9NMg3eUcSAxZcQxkX74zo4WM9DeEMpzbw+ua5YV27DbfJLg44ejKcSKw3omArBpmCkxKa6XCfuDJxvDJNEszkd9N3EjcnbB5Xb1Mn4h7/e8SlCtfP6j7XACBRKiM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3350a4-7f6c-491f-0af8-08dc4825a86a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 15:02:55.7790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nnvHOi16hpnevuui90BYqHabe/5XiGq89eZ4ypT8opNZPLgzC7W+z5t7gIZ0RG6yg9hEo//KFiEsAgFhsYVsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=614
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190114
X-Proofpoint-GUID: BDKexg7P745vIxZHhw7f_H3jpJYM9Xon
X-Proofpoint-ORIG-GUID: BDKexg7P745vIxZHhw7f_H3jpJYM9Xon

On Mon, Mar 18, 2024 at 12:48:04PM -0400, Jeff Layton wrote:
> This adds basic infrastructure for handing GET_DIR_DELEGATION calls from
> clients, including the decoders and encoders. For now, the server side
> always just returns that the  delegation is GDDR_UNAVAIL (and that we
> won't call back).
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Please consider this for v6.10. Eventually clients may start sending
> this operation, and it's better if we can return GDD4_UNAVAIL instead of
> having to abort the whole compound.

Applied to my private "for 6.10" tree, which will become nfsd-next
once the v6.9 merge window closes.


> ---
>  fs/nfsd/nfs4proc.c   | 30 +++++++++++++++++
>  fs/nfsd/nfs4xdr.c    | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  fs/nfsd/xdr4.h       | 19 +++++++++++
>  include/linux/nfs4.h |  6 ++++
>  4 files changed, 144 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 2927b1263f08..46b3d99c2786 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2154,6 +2154,18 @@ nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	return status == nfserr_same ? nfs_ok : status;
>  }
>  
> +static __be32
> +nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
> +			 struct nfsd4_compound_state *cstate,
> +			 union nfsd4_op_u *u)
> +{
> +	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
> +
> +	/* FIXME: implement directory delegations */
> +	gdd->gddrnf_status = GDD4_UNAVAIL;
> +	return nfs_ok;
> +}
> +
>  #ifdef CONFIG_NFSD_PNFS
>  static const struct nfsd4_layout_ops *
>  nfsd4_layout_verify(struct svc_export *exp, unsigned int layout_type)
> @@ -3082,6 +3094,18 @@ static u32 nfsd4_copy_notify_rsize(const struct svc_rqst *rqstp,
>  		* sizeof(__be32);
>  }
>  
> +static u32 nfsd4_get_dir_delegation_rsize(const struct svc_rqst *rqstp,
> +					  const struct nfsd4_op *op)
> +{
> +	return (op_encode_hdr_size +
> +		1 /* gddr_status */ +
> +		op_encode_verifier_maxsz +
> +		op_encode_stateid_maxsz +
> +		2 /* gddr_notification */ +
> +		2 /* gddr_child_attributes */ +
> +		2 /* gddr_dir_attributes */);
> +}
> +
>  #ifdef CONFIG_NFSD_PNFS
>  static u32 nfsd4_getdeviceinfo_rsize(const struct svc_rqst *rqstp,
>  				     const struct nfsd4_op *op)
> @@ -3470,6 +3494,12 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  		.op_get_currentstateid = nfsd4_get_freestateid,
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
> +	[OP_GET_DIR_DELEGATION] = {
> +		.op_func = nfsd4_get_dir_delegation,
> +		.op_flags = OP_MODIFIES_SOMETHING,
> +		.op_name = "OP_GET_DIR_DELEGATION",
> +		.op_rsize_bop = nfsd4_get_dir_delegation_rsize,
> +	},
>  #ifdef CONFIG_NFSD_PNFS
>  	[OP_GETDEVICEINFO] = {
>  		.op_func = nfsd4_getdeviceinfo,
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index fac938f563ad..369b85e42440 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -1732,6 +1732,40 @@ nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
>  	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
>  }
>  
> +static __be32
> +nfsd4_decode_get_dir_delegation(struct nfsd4_compoundargs *argp,
> +		union nfsd4_op_u *u)
> +{
> +	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
> +	__be32 status;
> +
> +	memset(gdd, 0, sizeof(*gdd));
> +
> +	if (xdr_stream_decode_bool(argp->xdr, &gdd->gdda_signal_deleg_avail) < 0)
> +		return nfserr_bad_xdr;
> +
> +	status = nfsd4_decode_bitmap4(argp, gdd->gdda_notification_types,
> +				      ARRAY_SIZE(gdd->gdda_notification_types));
> +	if (status)
> +		return status;
> +
> +	status = nfsd4_decode_nfstime4(argp, &gdd->gdda_child_attr_delay);
> +	if (status)
> +		return status;
> +
> +	status = nfsd4_decode_nfstime4(argp, &gdd->gdda_dir_attr_delay);
> +	if (status)
> +		return status;
> +
> +	status = nfsd4_decode_bitmap4(argp, gdd->gdda_child_attributes,
> +					ARRAY_SIZE(gdd->gdda_child_attributes));
> +	if (status)
> +		return status;
> +
> +	return nfsd4_decode_bitmap4(argp, gdd->gdda_dir_attributes,
> +					ARRAY_SIZE(gdd->gdda_dir_attributes));
> +}
> +
>  #ifdef CONFIG_NFSD_PNFS
>  static __be32
>  nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
> @@ -2370,7 +2404,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
>  	[OP_CREATE_SESSION]	= nfsd4_decode_create_session,
>  	[OP_DESTROY_SESSION]	= nfsd4_decode_destroy_session,
>  	[OP_FREE_STATEID]	= nfsd4_decode_free_stateid,
> -	[OP_GET_DIR_DELEGATION]	= nfsd4_decode_notsupp,
> +	[OP_GET_DIR_DELEGATION]	= nfsd4_decode_get_dir_delegation,
>  #ifdef CONFIG_NFSD_PNFS
>  	[OP_GETDEVICEINFO]	= nfsd4_decode_getdeviceinfo,
>  	[OP_GETDEVICELIST]	= nfsd4_decode_notsupp,
> @@ -5002,6 +5036,59 @@ nfsd4_encode_device_addr4(struct xdr_stream *xdr,
>  	return nfserr_toosmall;
>  }
>  
> +static __be32
> +nfsd4_encode_get_dir_delegation(struct nfsd4_compoundres *resp, __be32 nfserr,
> +				union nfsd4_op_u *u)
> +{
> +	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
> +	struct xdr_stream *xdr = resp->xdr;
> +	__be32 status = nfserr_resource;
> +
> +	switch(gdd->gddrnf_status) {
> +	case GDD4_OK:
> +		if (xdr_stream_encode_u32(xdr, GDD4_OK) != XDR_UNIT)
> +			break;
> +
> +		status = nfsd4_encode_verifier4(xdr, &gdd->gddr_cookieverf);
> +		if (status)
> +			break;
> +
> +		status = nfsd4_encode_stateid4(xdr, &gdd->gddr_stateid);
> +		if (status)
> +			break;
> +
> +		status = nfsd4_encode_bitmap4(xdr, gdd->gddr_notification[0], 0, 0);
> +		if (status)
> +			break;
> +
> +		status = nfsd4_encode_bitmap4(xdr, gdd->gddr_child_attributes[0],
> +						   gdd->gddr_child_attributes[1],
> +						   gdd->gddr_child_attributes[2]);
> +		if (status)
> +			break;
> +
> +		status = nfsd4_encode_bitmap4(xdr, gdd->gddr_dir_attributes[0],
> +						   gdd->gddr_dir_attributes[1],
> +						   gdd->gddr_dir_attributes[2]);
> +		break;
> +	default:
> +		/*
> +		 * If we don't recognize the gddrnf_status value, just treat it
> +		 * like unavail + no notification, but print a warning too.
> +		 */
> +		pr_warn("nfsd: bad gddrnf_status (%u)\n", gdd->gddrnf_status);
> +		gdd->gddrnf_will_signal_deleg_avail = 0;
> +		fallthrough;
> +	case GDD4_UNAVAIL:
> +		if (xdr_stream_encode_u32(xdr, GDD4_UNAVAIL) != XDR_UNIT)
> +			break;
> +
> +		status = nfsd4_encode_bool(xdr, gdd->gddrnf_will_signal_deleg_avail);
> +		break;
> +	}
> +	return status;
> +}
> +
>  static __be32
>  nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
>  		union nfsd4_op_u *u)
> @@ -5580,7 +5667,7 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
>  	[OP_CREATE_SESSION]	= nfsd4_encode_create_session,
>  	[OP_DESTROY_SESSION]	= nfsd4_encode_noop,
>  	[OP_FREE_STATEID]	= nfsd4_encode_noop,
> -	[OP_GET_DIR_DELEGATION]	= nfsd4_encode_noop,
> +	[OP_GET_DIR_DELEGATION]	= nfsd4_encode_get_dir_delegation,
>  #ifdef CONFIG_NFSD_PNFS
>  	[OP_GETDEVICEINFO]	= nfsd4_encode_getdeviceinfo,
>  	[OP_GETDEVICELIST]	= nfsd4_encode_noop,
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 415516c1b27e..446e72b0385e 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -518,6 +518,24 @@ struct nfsd4_free_stateid {
>  	stateid_t	fr_stateid;         /* request */
>  };
>  
> +struct nfsd4_get_dir_delegation {
> +	/* request */
> +	u32			gdda_signal_deleg_avail;
> +	u32			gdda_notification_types[1];
> +	struct timespec64	gdda_child_attr_delay;
> +	struct timespec64	gdda_dir_attr_delay;
> +	u32			gdda_child_attributes[3];
> +	u32			gdda_dir_attributes[3];
> +	/* response */
> +	u32			gddrnf_status;
> +	nfs4_verifier		gddr_cookieverf;
> +	stateid_t		gddr_stateid;
> +	u32			gddr_notification[1];
> +	u32			gddr_child_attributes[3];
> +	u32			gddr_dir_attributes[3];
> +	bool			gddrnf_will_signal_deleg_avail;
> +};
> +
>  /* also used for NVERIFY */
>  struct nfsd4_verify {
>  	u32		ve_bmval[3];        /* request */
> @@ -797,6 +815,7 @@ struct nfsd4_op {
>  		struct nfsd4_reclaim_complete	reclaim_complete;
>  		struct nfsd4_test_stateid	test_stateid;
>  		struct nfsd4_free_stateid	free_stateid;
> +		struct nfsd4_get_dir_delegation	get_dir_delegation;
>  		struct nfsd4_getdeviceinfo	getdeviceinfo;
>  		struct nfsd4_layoutget		layoutget;
>  		struct nfsd4_layoutcommit	layoutcommit;
> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> index ef8d2d618d5b..0d896ce296ce 100644
> --- a/include/linux/nfs4.h
> +++ b/include/linux/nfs4.h
> @@ -701,6 +701,12 @@ enum state_protect_how4 {
>  	SP4_SSV		= 2
>  };
>  
> +/* GET_DIR_DELEGATION non-fatal status codes */
> +enum gddrnf4_status {
> +	GDD4_OK		= 0,
> +	GDD4_UNAVAIL	= 1
> +};
> +
>  enum pnfs_layouttype {
>  	LAYOUT_NFSV4_1_FILES  = 1,
>  	LAYOUT_OSD2_OBJECTS = 2,
> 
> ---
> base-commit: c442a42363b2ce5c3eb2b0ff1e052ee956f0a29f
> change-id: 20240318-nfs-gdd-trivial-19b6ca653841
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever

