Return-Path: <linux-nfs+bounces-2724-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6A289D03C
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 04:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 720F5B236A9
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 02:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F70E4F885;
	Tue,  9 Apr 2024 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EW/8CwmC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jbx4Ji9j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15734F88E
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 02:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712628526; cv=fail; b=QRugWIh/fP6my55/tIakyMXkWCRo3CD/RyVX/+TDg69Kfuq7f/PaC+uiK74OPJ1pl7/PIGcLOz3Yh1SYsGc6oJlzrd1Nv4DA7CLRMLF9DUKLLFb6cXCw63CaTbTrfCLNVPG++K1uscdamQR/WauL8GFnyJWUGtNI0y1f9eJ19pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712628526; c=relaxed/simple;
	bh=zSDb++kkZtUFMqmgnsuYnq7mvcVQC28f1Sr3X+2SY1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qhUV5LJ99eu+Z+BiE9UnnJEY2L/7Qjwe0JSg50IMiuV+gzVxsf9n9Gx1t1msPfdfhs82BkQpfDJ4OxolzBo8cCRLr09YEL/CcQIQIDddvcwYz/tb98Tr/N/ikYOEj4EOtBACVBnwU8nYYe9NNz8mBQLj+y3h8ck7UTvfwmQN3r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EW/8CwmC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jbx4Ji9j; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438LnKwJ031156;
	Tue, 9 Apr 2024 02:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=R8/txJ2fqhinr660MI9AHe/YfN96cfNguyictrqCgno=;
 b=EW/8CwmCFWzQ+u3ikn3m4Hq6r+IPxe4qW99l+/4LgXxKa3q8UXRfY/V3SfmSZVs39mB4
 JvC2ZKAOQMoOcphRvIeMhl7v0E+osE3N42yPgDrYk86s7lPxsbyXtDAxjiYoQu2oS+VJ
 1ShOfna9be3bEQug/jpvxE1LT80ekEtJ5CibZVT7D2sHVFmlhJGVwJZ/xPCgCUL+e9ZO
 WxONAXX+VybuVw+RNyr6tQZ30xjcBjT/ZX14CpS9CKFiBpq0smcroIodEEx/G5d5mQJt
 PA4jtS2U18IvKDYP38pIs7qIE03lMIEDOZo5b8tuw12T2lw3BQbYzB9uFPp71OAVNtgz ZQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw024438-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 02:08:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 438NeJ11003016;
	Tue, 9 Apr 2024 02:08:32 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavucgn8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 02:08:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fg2Fl7AIjxnT+3XDEi34zFfkIrOHaniAmdfThpS6Toi7/5p7BbWS7kW38+GvVwOxRteUu2oIp60jAFvubky/9vMgPr3npmltWe8OwAZPRuZUsYFeFQmxpBXgNW/uQdofJkHjDwun9R43ULzi7IFzIOJlnMzUImBhWTr8HIFk/XdeUP5cfBA/NLegxFdf0jEnEEoovBjrNyRsW9KRDkT6dagbjoucVr7VEq4738vIWFGK1WxgNX/w7hMobqL5haZvFb6TU3c956XfZVIVJqf2vFFphO7/X+cw/79+4sqgy2ZUa/xnzXLU0uCjCq2eeKKLX6CrbmwpipkrLaMHx775Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8/txJ2fqhinr660MI9AHe/YfN96cfNguyictrqCgno=;
 b=aYvtuniR3UGO/j54Y/tOEIy2Ezd5jR8LKWvhUidPDR+0WfUHWMCjlFwVrIxYaeSK2PbDxS0n4l+UcpjVNtiFNH79cNtd1ndWlDn4MypUN2ZmZLLieD3X4jfyNo7ZvvTgf4vRCbuMh1L/bIOFqzez66hMFEGHFHDcSD3fbPPMALvWOgMZ3u/GD6N0J29daXzSZT5cAdOsdrvRlG+ayHvY6yty+YKy3x1G/AAxClyg5qIfoDECTtEGuh7onMpBy68rengwC/+qChg/cKvw6SQGvKwaHtImuB/RPUop8lOPXLffrzqHalDSzWtj19i7ksUVbx0EYULDNO10UW48yayL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8/txJ2fqhinr660MI9AHe/YfN96cfNguyictrqCgno=;
 b=Jbx4Ji9jQdpfgye8UsfmlkVl3BUubiRcRMcKMKIcIH19+0Wz7r/JD9SeJ56grgce6qg9eMxGRvwsTtkbgYcYKCrEubTvkBKO2F7t5m2QUydkv3hPYwArti/TSPWJCC968XcFVnypg14oKP68f3IXq2i2jNK1USYKQ8HvJyjowpQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB7439.namprd10.prod.outlook.com (2603:10b6:610:189::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 02:08:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 02:08:19 +0000
Date: Mon, 8 Apr 2024 22:08:16 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Chen Hanxiao <chenhx.fnst@fujitsu.com>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: remove redundant dprintk in exp_rootfh
Message-ID: <ZhSjEGEMyVuyApha@tissot.1015granger.net>
References: <>
 <ZhSPRTPtGCm4InJ8@tissot.1015granger.net>
 <171262513282.17212.15154633882557010394@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171262513282.17212.15154633882557010394@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:610:20::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB7439:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ojJKJLD48bbFB/C50HQSw1wFHXVghu5SHNNz8RAQnAV7u6zQmfYLV380ZxjNjuL/vZ56h+mKk1pE78L2dxBgY5ogCVT9MLINCm6UI5/pRjGqPGNDKlxmBAdgvChXGm6ghTZn76cLerR+ehTgYf4rvNLtPWqY2OPuVAOFs8INshXX21FGWfHqwdXUMW+Kp/W1ed+1xlmL6HTkeSOvhbPy9aH23Hd/zapSQ6a8AvBtz/YuBawJYKg1osroJzNzG3X0TfCoxY+Ny54BKUS/ogM3yX6FP5buaU/mEfQ9/qlxRUco6mL2FMv3+KtiyVpbh9pYNj5T+lEPclYHtcLV3mdYglI/rKw25gT1zLc7WITO/+6Z2zSD1B3B7k2TBVhrt4a7vFut52d1tyy/QZGHLDlBaNcMrgAj3X6IcKdjrqYfTaa8HhOfSasSzURhsmeBEO1foxhhiSlhqKZyqgAJ9VR2U5Xzh1cPchMdgW4+8r+3f6aCPJzcUxsXtBwzvMDnVbeIAgjusTlKhKH/2sIpO5Mjf1SQXDcaOOpqLJAeEcJBIOcc10vaGktHZhUp5M9VlWSayqeF9wUBdD8fQMZf7Fb5ZwzkPlfISJVdI+D25BfUtO5AqYV7+Xgofvw0IdYV57aFnhK2iHlXKUTKeXq1ZxVw7KOR6PAbRHLEpucz13Cesps=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YoCYIQd+5/WY1d0fQK62UtBsmzDgdkH+r8PCesHK+jR8z+3SmvC1bC+2GXFU?=
 =?us-ascii?Q?L+JH7ULOhaIjJQe5jr/nacVW5HBbAtULS09el1aqQ5sIYUhsPLPW5tpZzDPq?=
 =?us-ascii?Q?6VfFR0BXTlQU1JRd0/Oyb/ZYOKQqbefpdC6z8jVR18umFvSd0Z2a4+4pDaEV?=
 =?us-ascii?Q?CF32OF6w6KYoD4PEAdoeGfDyrOsrKMato1sysgqVNRZHnmVAUnfupHfNCvsk?=
 =?us-ascii?Q?HDkNGtyKhcmOUKnqBS7GasubCe/mKZ6vvpnyZ/S0IN8PnWguF9yTjo1jLon3?=
 =?us-ascii?Q?puajQYn80aP1Os20WcAdlxMFgXkZkMv2QEPVGhaF1EHVG4V6JaHAVoK8obsp?=
 =?us-ascii?Q?DMU+8mPc5uVwZ83VxNXdOx0E3gSwTlqoBpSbsjeeKZpZ4w1OYseKUSNT2xD8?=
 =?us-ascii?Q?sScw7XWknti/CtlWmw5cYzHz7rfzPihZeYfzjLTWhroD+LcwYVmXZj75pBuN?=
 =?us-ascii?Q?M/D3mW1PP6S0FrsfNcMORhyzkKgJJo6OfXeF6qBsdBIA5YLxkDsH2H7b8k4k?=
 =?us-ascii?Q?cmQgATd0JOa7FcrE3npcrJeaZGcO2EQRZSoJAT4sT9J84kojF5qpVwoM7KrK?=
 =?us-ascii?Q?UskddDw4g2krs0WSPktGJNhwdH/lPADqsb2PvhLTxF5X3wJydgpb+PEDpBNg?=
 =?us-ascii?Q?cwDjHttnGNu1jw0eM4Y/odcrZrQB4JDtHjNhUev3KaQ+RCZlgLs0HQ9sVVot?=
 =?us-ascii?Q?zdMWcAXm4IxmRieKtPn1ga1XYcoJC0y+mjVQdtIauLj6ifuIovcvVEpSeSm3?=
 =?us-ascii?Q?Uvt8NUS0Zlcvq4fI8NcrSwMB1m2PJJ9QHgXiTA+4+OQfZwWrS8NFpLYxIar6?=
 =?us-ascii?Q?V0xLMvasDW9QzATx0HHhy9C95qhzIsLD1CMT9f8ewamdKcIMbsmMpiZhzP1f?=
 =?us-ascii?Q?z6XE7IKlCE7oVxHAIeCJF2e2G69SiEE3lxufPKmbQvrTD1G36xsxSdQUrS3d?=
 =?us-ascii?Q?k0dFCQYP354sWNAhyP2p483JwGmO/qgFswDZb8JSNtRDaSV3rTL8nILQngHT?=
 =?us-ascii?Q?HJwsGhWo6BT7nvOvQdQUgSKQixTAQUFed4wp8uhXHPSp6TSLEZ7nrc36ZcCA?=
 =?us-ascii?Q?IpvA+eICN1bhxWZA8OzaJA+oMVaLrbWaZT3wAAhdYaggbib6rrcF2czi36JF?=
 =?us-ascii?Q?KFSfAS8BffjY8NvhNx6g1GDoC0HY0Mhq+wckExvJ3Msv8or5SJQEZTbzYMmb?=
 =?us-ascii?Q?0FPvvMqLrVTcopyCGjtjKF3P3ofqdS/hetWC7xBGmPc7uWbXbpIfR4s+f7am?=
 =?us-ascii?Q?wkw2PJ7CgMB4ZQUAbcpRktGVrzMyOYTrI6M7Byn4yb7kL5Z8dAFZA//NBsdd?=
 =?us-ascii?Q?Dkqpe8Ror5tEEFXUJz+Z0Ha8fF8FI9iIy85UOzxUAKCj8aC6fmSwKtlUc9s2?=
 =?us-ascii?Q?6/K1pu+MQRhgTugl2i3TkZ+SWveTNgzDW8WUhacopnaavussrzVKu9JgKH/8?=
 =?us-ascii?Q?OvywSIUB5eq5HEMmUgGNlvV7oaO7dHwNAiI+95Oj8+zZsd9A6FTkcCzkuUoi?=
 =?us-ascii?Q?WxG1gsgYc7tfxtMjnGZMetBxuN/OdwTASnjRIm5x+MV2ItTqlwjkbv2bKXeN?=
 =?us-ascii?Q?HmN9CrcnONHnJmVUNHeGMaGjxNEsaigkydILvzUBr2lBS/TahhmzTy+W6w+7?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SKTnfwMEZBbnMHRdA906ExbVwzw5cB/9wjRj69oSAHVcp53QOjqvFoxGhfwfV59M7cGWwhZnAqrQ2rkrQQIuk+jL6+Yl1GXJX2hxUjud4cvk945H8g73MswSS7NJOlCmXdYq+LQkifUm3T3JyLx9TEFzWhoYIwP4t3b7HdzbTieISZ2fCwDxYNQz3Yu+9ceJp6kCROfK4F2rZ9i42tR8O75UwmfasoEmvwh1dDHNAT55UXmS3R+4JYI+Q8yc2B+8+y2hg0vFJAwQPojrc+gdUUHanWtYuhN/5cNhrtYERcakkheyLTWleIT/Ga+GFC8jcbFXJtIssM3SmqyJXwkimm5gXEsOQgN4S04epY+ZXGEx77SFgKLFHlBAvXn3VJUZydrGo1H2QT9y//tMZX2K+WaiuZlP5W9i9pm/L43zwBV02bIXODEFhCmFMayIjT3FSrllkJ9SRJEy5k3ZIX8QFo/kVcvJjkjWX57PdA44ZbxJTBFZBHCvfZBkAi62qXa36iEZUex0F2oO+++35hNO3Q+56AaDo+i98oQQNsu4Pg3IWm27TNxySkW2UZTS+zeFZfiRRn8qNZFt6UnItzUclR/2EyP84oT1rhmlVdPwmys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a3dab6-2061-4d9c-9df6-08dc5839ed3c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 02:08:19.7328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c743S8AUrcigVyF4RSKloG1aX1KfB9AB5gL5bct2VCfWu/U5eHOmQXUEd/aX9bCKk/1mob/IgxnSy0whHFji7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090011
X-Proofpoint-ORIG-GUID: r8DVV9ZnhjciUGBQApd4kniDRoDhHR3Q
X-Proofpoint-GUID: r8DVV9ZnhjciUGBQApd4kniDRoDhHR3Q

On Tue, Apr 09, 2024 at 11:12:12AM +1000, NeilBrown wrote:
> On Tue, 09 Apr 2024, Chuck Lever wrote:
> > On Tue, Apr 09, 2024 at 09:21:54AM +1000, NeilBrown wrote:
> > > On Tue, 09 Apr 2024, Chen Hanxiao wrote:
> > > > trace_nfsd_ctl_filehandle in write_filehandle has
> > > > some similar infos.
> > > 
> > > Not all that similar.  The dprintk you are removing includes the inode
> > > number and sb->s_id which the trace point don't include.
> > > 
> > > Why do you think that information isn't needed?
> > 
> > I asked him to remove that dprintk.
> > 
> > Can you say why you think that information is useful to provide
> > via a dprintk? It doesn't seem useful to system administrators,
> > IMO.
> 
> I'm not saying it is useful, but I don't think the onus is on me.

No the onus isn't on you. I'm merely asking for feedback (and I
explain why below).


> When removing tracing information, the commit message should at least
> acknowledge what is being removed and make some attempt to justify it.
> In this case the commit message claimed that nothing was being removed,
> which is clearly false.  Maybe just the commit message needs to be
> fixed.

Agreed, the patch description could have more detail and a proper
justification.


> I don't think these tracepoints are just for system administrators.
> They are also for tech support when they are trying to remotely diagnose
> a customer problem.  It is really hard to know what will actually be
> useful.  Many times I have found that the particular information that I
> want isn't available in any tracing.  I expect this is inevitable.  We
> cannot trace EVERYTHING so there will always be gaps.

When there is no in-code tracepoint available, the usual course of
action these days is to wheel out BPF, systemtap, or drgn. Distro
support engineers know how to do that. Server administrators might
not be so well trained, so I consider dprintk() of primary
importance to them.

Here the dprintk() is reporting information that seems useful only
to kernel developers. That's a code smell IMO. And the guidance in
these cases, historically, has been to remove such observability
either before a patch is merged, or after the fact, as we're doing
here.


> But removing some information that was previously generated seems
> like a regression that should at least be justified.
> In the case of write_filehandle() we are now tracing the request, but
> not the result.  Is this generally sensible?

Let's instead look at the specific situation. The purpose of the
nfsd_ctl_* tracepoints is to record in the trace log when 
configuration changes are made, in order to juxtapose those with
other server operation.

So, here, it's quite sensible. We want to observe the information
that was passed from user space, and the starting timestamp.


> Would it not make sense to
> trace both after the core of the function (exp_rootfh) has completed?

In some cases there are already tracepoints that would report or
infer the new state, so reporting a result would be redundant in
those cases.


> At lease the knfsd_fh_hash() of the generated filehandle could be
> reported.

Chen's original patch replaced the dprintk with a tracepoint. So I
asked, a week or so ago, for exactly this kind of feedback. There
have been no responses until now. Therefore it seemed logical to
assume no-one had a use for this info.

The folks whom this information would serve have been silent to date
with any specific suggestions, and usually we hear from someone
quickly when removing observability that is depended upon.

We could record the FH hash, but what would it be used for? User
space requested the FH, which can be reported by the requesting
program.

I'm not hearing a convincing specific justification for maintaining
observability here.... but we have a few more weeks before making a
more permanent decision.


-- 
Chuck Lever

