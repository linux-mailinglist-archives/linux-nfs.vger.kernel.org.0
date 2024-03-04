Return-Path: <linux-nfs+bounces-2167-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDCD870306
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 14:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3228A2840B5
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 13:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367073F8C7;
	Mon,  4 Mar 2024 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lf99OFG0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kC5mML/h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8763EA9B
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559700; cv=fail; b=Se89Ojcj2zA1cJKMChNaJKNCt9EI8m/JYhWfVA9gH49/DhBr+1U+jR2dB2RsJ+u12gmaeMAcSSAHLTLpJ0fQJl5sInINery/RTJN/Qd5jB9zt2Hr784kOgomNARiduNu0r7z52oxnNWfXTpWD99fho/AMZmaX1KOEXhXfoP5Qto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559700; c=relaxed/simple;
	bh=MQaQvxUHDKRireHD3SxyvKzIyu2QHmmmXxPfrcMUgCI=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TW6fPCZeiO2J7N4j4OjCirWZUjdC+nNM17P+MhPqFee/U7Vy0xCjMf+o8DQneyNVKnSlzhkmbCNljoacbOSdhlOMLBU6X8oH/4jjbkUQuJP+SJ+MfGWHx6pyATbADw6HRt08cmOPBxAlYWjo/ynqTo/UBQtEDsZyAAfTroYiN/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lf99OFG0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kC5mML/h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BT7jY030296
	for <linux-nfs@vger.kernel.org>; Mon, 4 Mar 2024 13:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=DMv/e+QgULIEVEC3sftLDliYi5NkJSMCg1/lHVFSTQE=;
 b=Lf99OFG0XYu7PsxPYSseP6oWkIb97FOZgAb5fWMp7VwLmqPaKwKp8nA82bYahIOewYnE
 IkdY9jdI5cR1KkH32aMvdEEeqFGrRSi5Gyr9xy19JxI9tu89kOOo7wpE/Zr/VYjSWQFs
 XyBnrkuPWPWeZTrmaXvT3pEAQn5IkHW+eyBEBkZoDBBvl1eNqw403JEE63HGST+8iuWV
 wu5I5KZSGHqukyNfpJZqkHFJQAziPBEruUoTnK+8KjivT6CtqZEHPDM1XbK8+LqyWpLA
 d5c5A8tQDwZDKGuuLHnPTAUd1VyMG07KvE3v1F7YFU3KOvDedH+x6dRTJWzej4UCBwk6 FA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkuqvbed3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 04 Mar 2024 13:41:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424DAqiq018881
	for <linux-nfs@vger.kernel.org>; Mon, 4 Mar 2024 13:41:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj5rse6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 04 Mar 2024 13:41:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjD+CUoY2FM14TSNnvx4jqla78IWmrrtml5lLtwFwGxpFFaRQjrPhyNRRn31I/f2gm/SQ5wl+7kflUC1/GTr5t9briILOCR+9SwI0C+pBOQkiLigBRkleq3COVeyWgpyr+xhumoLgVqU07C36gSiHqv0ULI249s+kyQr+W73U9yiGmqnSgEDqX2JS5XAmInXuVFKpOUV0fA8TdG5IR6JFq3SnXgWJyek260LAPo7Knu/oD0Fe/LCgbdW2DiLnfpl2h0ykpOLFu1ynxp3J4u0iGEvj/+9uxBnFF14K75qJTilvLz37e6v8SLbqNQ8hxbj6Op2fTX8fNX1bRi7G8AKsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMv/e+QgULIEVEC3sftLDliYi5NkJSMCg1/lHVFSTQE=;
 b=h4TpJ5wizM+F8lW+lCWyqVcPfm2ZyRnXBz2z0s/QHVB0VvkS81KIqy8guqONkq7cKiSOrYzkKm2xmCnyOn2vrtLUd1X+MAJmUxzxHGpF3BagKadjMipOWjvJMlaHBBCiT07QJUBRkH26nKiEZVfl6jUfReL7cVgdEcOIXmPIpRt4a0+itsg0VdmY0yS07bus88+tmnKmeXW/yGNiImGEMqUJDVxKsEnGgTCoVevVWyeYQ1cHuyGNzzJqcaomtnfcx6/Cf2cwGsdC5g7UYsDFJUqElSoQDSaRJFpOBYV4KhB2qN4ynUMyiXrv2/MvzOon6q+1E+QwgAzdtawBGQYAtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMv/e+QgULIEVEC3sftLDliYi5NkJSMCg1/lHVFSTQE=;
 b=kC5mML/hOMVaBw4TPxv8MLYKWkr09fqvXvxatvnZgcNefC77RymNk3kvJGpuNdKZ4ONWviT1yB+PkVorEDVXiWKqLlZ7DfxatmUZnRmz6miWDIMbgLbP7OEmU+zvC4zlkSEZwwVdmhWGZqZNkhLIuHMWT2sZ/AfjmlMSr7F67lw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7297.namprd10.prod.outlook.com (2603:10b6:8:d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 13:41:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 13:41:33 +0000
Date: Mon, 4 Mar 2024 08:41:26 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <ZeXPhjmjHXgK3ANB@manet.1015granger.net>
References: <ZdyedKSSsIARB4ZC@manet.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdyedKSSsIARB4ZC@manet.1015granger.net>
X-ClientProxiedBy: CH2PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:610:59::38) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd57e9a-a69f-4a5e-5338-08dc3c50ce64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Qi2nKLAqGun7huH0ec93mhMpG4JUZBbDJG9s+BhCs1Gr6YlwXHatNBPmqa/XeaL8qZpKXDKAN6+3OiCwS3pfyioZhGaP4Wo/+1b0LWkMKk9a3YOvQAYChGU2iZqZl3m50KlNRF53X4tXxFdnRCkcQrS8Ndo1z+2m7stWOeiz94mPiIEGsJNRNppnCtzraGGgWB2mg2TOQn7QBQulADX2pKagaZsqVLbBdtBgJkFW/uAjGUJ3cOVCMi9TxUPZXyzLX6aE/5TQSj5vl5PNo6lGTmiXhJ0lvzAG7MKyYJMj/xF0yB5kX4j1NwL1Oltc/ppSCC4BF0bNV148LPzxhQ7HEoQKluPvuSJQQ5mKF+585iJqsxjH335vGwppyoSIiuJ49GaLiubbxfI72zvFl8fWI02HiUr2GrM7wJArVqQnnR5TCf0stcBQmJLPkpiqM5x67DAIHhk5R3vT3NGdCIN9xy3Oc+6j21lVz2WDuZUNFcMcweowDFNi+qDTlZ6m0twStGEYhiip9OVXE4ciV1jduAiBh5CKeK7AP6hsxAMvDEHhQ2/fbZgpnGATjBl8P/H3udX1TAHIJh7TR+VCZ4pERH6WC8EcKXXko9dde5A554M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MJbVUzxyO6eU74KN7DhiFvxGGQOP4wdUPLDbUMX0ShCznYhJiaNttbkPg00e?=
 =?us-ascii?Q?+0EBdaXJmZITqESj4rkpLY6WJwe3f1/h7ytyt0Jiu/YOJFzEDRUVpRdAoQuh?=
 =?us-ascii?Q?WtGqHzZgT3EpVHa3npfwxRvcdR0ucEWgJvUY454dPDx/GdlZay8SZjc87+Lm?=
 =?us-ascii?Q?+1GUIpGp7UlHfO0q6r4T4z4qeTcPH9LEusY+VQAxnlxX2KCsxyXJMZtiYbTZ?=
 =?us-ascii?Q?8euoTKX2hkqJ3w894iuS3pfCoEPL9XOpEMQ+RGzY/E7eeWZkQ2lXPOYIT1et?=
 =?us-ascii?Q?e+p9whfqc3xnoqc3E8G2Xehn6gtHDZc4/LQZPT80+UNmZjt8YZoCycrD7A3R?=
 =?us-ascii?Q?edyTz8chDr37BhUDIJkqspzFuWhunJ/FK2d1RkYH1lDRFgxP8OQRO7ZkJlew?=
 =?us-ascii?Q?DCvcluPuoAEeb2upjief7dHuc2y8kYcQOVQkKN7yZ1YW0fTXlzv9/YpEjeLf?=
 =?us-ascii?Q?FATP3+dE2jYAhsAhdOB2IsP0PGqQuxhrUVwoT9StWE+ic2plYPlVwygkuwPo?=
 =?us-ascii?Q?lKBlqfWxk4s9/8EO/ZLpSG906BWVR7stQSED5orcaNAioTsbQulZbZW2EyRb?=
 =?us-ascii?Q?VVGSe+WlhHPWEtxDGIznb5m8OmSZ3+Bjy77Y2hwwAo8HzC7i7/HlmI7XhuRq?=
 =?us-ascii?Q?P28ymaQUKoIclOWrNcgF5N1ogkiYff9eOvH4zItkUHVxqa7DjFwNl+6B5MvV?=
 =?us-ascii?Q?g59AsDxqnHtfdTo1Ejp56E4/aGlWqvyARocXv9QTGrA8wPXC1SS/AzdCv6kC?=
 =?us-ascii?Q?s95z6Afsh/uwSPt/n/0VGZiDhL3ryqoz0RMiZi24UxPq5/fI+LrjvbXix6FE?=
 =?us-ascii?Q?n/NMjjKpJndU89vtrdQLCQhCVV9eepP/c44ZY4hsvtTfFZn4F2Rw+rp9YeyR?=
 =?us-ascii?Q?debZMSaYjrcQRXrenHmholuMC7/pdmiinff8Azc03uvNDKrP86lZ7ZWcZGVN?=
 =?us-ascii?Q?wnFQgsrXpOzP8JkhTgF0ZIOdeGjFF9D9ytClNhr1L5+Bi9DX9BgcQmaAaE7d?=
 =?us-ascii?Q?brd4/63Wrd0H8nZD+nen77R8dX8adkapaQ1cH9Phyo2dzwhfK8AZ5zc4Iegz?=
 =?us-ascii?Q?RcYzMf8z0osCjB+/Rg5NLH3Al5jymF3zNEU9rkLbzdW9tZytr44FYu1jYpFh?=
 =?us-ascii?Q?LZm5A097+MYfh2HhAwPcIcsEldn2YymayNl+TS/83tim6uq6ctYFMxqB5GAq?=
 =?us-ascii?Q?H0SakDuu/w2YwFgeGiCw9j+yckFJgpUFJwkUOencmDPbDVg6G3kNizul57nO?=
 =?us-ascii?Q?5xIsFiZVht2YZw4r2ykuD/KRIsxh7HdZiI2kNR1KkAQucQuIQ5NBg9to1P/a?=
 =?us-ascii?Q?36EbWuESOH2OHfFRICzht7YXyvdLtN+abv9hVYzdsqyXJ9PCU9ocqqIsm8Kx?=
 =?us-ascii?Q?g6VEaWblIBcGqBodf4vMDdh7nD4lASkj6Npi8VzbCAsqxVrykl891twkZE1d?=
 =?us-ascii?Q?+WPNbeeq25+abf56tB2oJbcxPsVquRr09DlpbLk6jt94+iicjgjvXEO+ulwk?=
 =?us-ascii?Q?obklaDnM+7TpepznnqUe/Rp92r5K0sODsInuwIBru99iBVQk+FwsLPBJ45fA?=
 =?us-ascii?Q?/RwLJWmMuoY5G7D35YxDPXdMEVAllb0PyiHXkmTJYNYLrWRrtXnqmTUSafp2?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/FDR66lfmPo4gWjvCLXHw/w5u0cRmW1tByhM+XocWdU15U+6aA8+nl2i8z2a//oGA8/bD7lUoUTCNmWxq7TejQC/27pLDjMbHmk8mVB+hwRBk31n4nsKB2ltFmtm3t9FJ/79JdEG4aFnBgsfPq+mn4jVLsBxMxln3posChkgBgmGn8mkVzBQZluaPVwBwkQa/oLRh0YcdAzmv/ZQRkLKA7iqYgdsA8OkAf9s7B26VgePqPC3iBptwWC79H3VdexoKZg8/GDhcxNf4vatJAaZrWf4NeoRiBqkOZElEfg9F89oWqX2TNRBd1pHxSupYpV0K6fzwk5m7A2h2KJBjEKAZ/tEzljETXZ2/KowRvcc2xPwfkILMveX49S7aRTskgMB4JPZCOuth57VusMdvoXyK/FfVn83gDdK3VWjPIBySO9b/3UU+fCuZXEpN04RpcPmRHDJujVRvjI5DzOiCp7YBOg4Ek6ZDEAGFSUShYRLXe3TaYSICpvtz0OvH4RsXcjEEH8JZuzw1NUwMK29xHRfAlOjqcTanXHBhE6aPJHIlEzV/uR/aGOEJ71qZCp7F1RsFH0HHQMbAfwbdTHw+5DNFzpUgv0nXnVTDDT6kwDhQ58=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd57e9a-a69f-4a5e-5338-08dc3c50ce64
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 13:41:33.8534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNbP9Sg30zc8AgMTIiWawr8p/v1Rz82Pi8khyUEfosq/aXJu3ILJrGZpRwYfo0b7VNBQmkq7EfTVrWr+/tqkBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_09,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=843 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040103
X-Proofpoint-GUID: RT95A-cotE22aRjbVClbYoTzOyMeUGCn
X-Proofpoint-ORIG-GUID: RT95A-cotE22aRjbVClbYoTzOyMeUGCn

It's apparent that a number of distributions and their customers
remain on long-term stable kernels. We are aware of the scalability
problems and other bugs in NFSD in kernels between v5.4 and v6.1.
 
Therefore I've started an effort to backport all NFSD commits to
those kernels. The backported commits are destined for the official
LTS kernel branches so that distributions can easily integrate them
into their products.

Here's a status update.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes. I'm currently using
the NFS workflows in kdevops as the testing platform, but am
planning to include other tests.


LTS v6.1.y

Greg told me this morning that these are now queued for the next
LTS 6.1.y release.


LTS v5.15.y

I have updated this branch to include commits from v6.2.16 through
v5.16, all applied to v5.15.150. The fixes include most NFSD and
fanotify patches in that range. I've begun testing this series, and
so far the backport looks successful.

You can find these patches in the "nfsd-5.15.y" branch in the above
repo.


LTS v5.10.y

Backporting is still under way. I've gotten up to v6.0, and plan
to continue to v6.2.16. The fixes include most NFSD and fanotify
patches in that range, but exclude some because v5.10.y does not
include the VFS ID mapping patches that were merged into v5.12.

You can find these patches in the "nfsd-5.10.y" branch in the above
repo.


LTS v5.4.y

At this time I am planning not to backport to 5.4.y because of
missing features in this kernel.


-- 
Chuck Lever

