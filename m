Return-Path: <linux-nfs+bounces-4605-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38253926801
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 20:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9571F24784
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E39181CEC;
	Wed,  3 Jul 2024 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CM8FL6UF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vY+0nyVU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7D317B4E8
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030875; cv=fail; b=gy01ywGy87x9tCOX0XrW0sYaWcZCOdvLeRSGmjeGKTb0P+EsVlo0uFty2hoNTfqRisVIKspu9Y06qlktwdSdNp/Kg9ig3KcHOr2WL/L0M4dHaHv/hZroBl70WgHWNErnz0DJABBfHwVS6F+Siv9RwJEEzJ75cWqhchqnvxIYvPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030875; c=relaxed/simple;
	bh=z/gdW5NCgnVrzEmK5lODrdCQzWOOpWGaR7m9AzVWMfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WEqCMOokUTmm8KtFSbaqS2DcjbJQlhj9BwHVIByuBdH6gNToDD5fHcZCJGWgAJpR6JGqDlIUGg8bT1LUakiyKm905jJBYZTNbVO4Fsj8RKMZw+T+U5xLCkihceS7DZeUcn67nJaBHp4vgZR6AHqg+kdSoMH482PUKmTfYlk3z10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CM8FL6UF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vY+0nyVU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463FMTp9031102;
	Wed, 3 Jul 2024 18:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=db9SXMeWE2p/3C5
	Gzv6umidXFFC5QuUa6YYzB4Jdsrk=; b=CM8FL6UFlw9PW4WNEYUs7BR0FmYTLRE
	QwN84n1WUcr3YVsq5gAVhYdXEUF3vvYb2y1GajNYaLAyy8PrGrZhJ+JGyzCwLqu2
	DNhg8fCxCb4bJ98iA0aHtVhDYB2AFi9/76nACZ4u2iO+tsLOe+vHJdJvrYRb5q0C
	HPSouRLuFiazROBPJSgvMUezJMICTNvTF9SRyjj03WYuWgGbvBBMAuCIwHysBeQC
	xVWbsiDicDNiTeJMT1X0q/Oas4WJLHroaEEicGXpPsbOLHQgIALfudEHGpiWyVRs
	zbCEqD7XQgxCkc/de6Q8VKo4TLe55TNpAR/AsMQmXBpmiPlQDFmrtFw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aacgvrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 18:21:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 463Gb8nH023540;
	Wed, 3 Jul 2024 18:21:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n10fnfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 18:21:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9Nfdpr1pmo1H6DW2PgoJOYvWB7i9rqh9KYW591KPbT20/LzO3QJCqOwJvOvz3mpe2MPXMRu5L7uNI3I4qYBHvJJkTw99nh9SE1eu9iFNYvRPKwRYRxfjFkGaOo1taHtZ87tF4ibmDyrjn/TE+7+Q54yLNl4jLdGR5H6gZpqticds6h/ltIKtDxkoVXZGelofZfPsMG9kPslwXGcazaptpCeHxO8/BMZDyoQZ6mDyJTfxdUIMjlCgP8AyEg+c5Pt8yrR4lr6DQ5uKBHgcoJp3jUysk40B3dU883ArmFhKHQkwHci477pvst5N2a47qldKtfbNfSnpS5w469PCAEzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=db9SXMeWE2p/3C5Gzv6umidXFFC5QuUa6YYzB4Jdsrk=;
 b=m13LNBrElux5rylWqKhLYGMm3q7UaWxxyRqSobeledj3biVPqqV16O4BYzYNr67fl3yJMmtivMIJeYbviAoRYBfflylLmCfnop3dvvgZ1U6eUYWYP249Lq9yzVwKy3PL0uRH2o4FmqC48wASmVbobRQMIUqGuuPoRT+V0cLJAJhp2Jkt53TLeZBJNrQKwsaEGmWA5YFe0brYuF/BOnsqdV3ui6tTZGsV6UBknwhy/k520TfgNm3f9KEvAWt9ASPEkeXod6oOxHs5nF+juzcFjCJcpjhyJXjn7LT1wG2ZsiXWJySqAymNEwVZfo6SfXVX2v9b7ex53xjsEoJSLm5Dyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db9SXMeWE2p/3C5Gzv6umidXFFC5QuUa6YYzB4Jdsrk=;
 b=vY+0nyVUvAXbkTWpue2M09bNhataJIvuGTnsOZld4VqW9+IPiHloKxVObPmj2+WZ8xk2ZcpABS2+F8K6TTrKtz7hSeMnyUuQcjwXG4WIuqfCvB5R7bcMel2gWPM3CgKgyfPXemFYQ3KMyenh5tSqD1pGYXe1kTJQPqHn050oqzU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5142.namprd10.prod.outlook.com (2603:10b6:408:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Wed, 3 Jul
 2024 18:21:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 18:21:01 +0000
Date: Wed, 3 Jul 2024 14:20:58 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Youzhong Yang <youzhong@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: Leaked nfsd_file due to race condition and early unhash
 (fs/nfsd/filecache.c)
Message-ID: <ZoWWis0AgvmiVzBU@tissot.1015granger.net>
References: <CADpNCvYGqA3a51OH=AcqmKyAmnx3yoZjYPo7US+qk-OMX789vA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADpNCvYGqA3a51OH=AcqmKyAmnx3yoZjYPo7US+qk-OMX789vA@mail.gmail.com>
X-ClientProxiedBy: CH0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:610:11a::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: 4627f1cd-9f71-4333-f231-08dc9b8ce4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bWQAvCiiPLydfWrzgdr4hzD/OR0CrjqHQJ+do2Kvj6kr/Y40TbCqQBnFHOWh?=
 =?us-ascii?Q?2xEXBNvAnawW4yi96ktPwfGXmkjhI05MUQ2ryPZ6q5bIDg5dV9/ZzTgnv4WX?=
 =?us-ascii?Q?C8CK/VwLOvDV+IG5Ql9nGCsuzTPSeCHnc3jZcOuui9rBlQ+XH39H6JBbVZ08?=
 =?us-ascii?Q?XmMiqMDyNUDO48gtAN/zVcCXVRmnnQYIvzxZNBi7BBVtDbgjM8jN7fVKei/i?=
 =?us-ascii?Q?CPfcIGoFeZbF0pmdV/UJkP6HfjrxBzcMV3nCxabgmCMp13/hMpG2NtDjNu4t?=
 =?us-ascii?Q?+cMV3ybxo8b2sw9QIJHsOUqz7wY94jYDMJ+hL4p5MY8B/GZ5ru9BGXIvoIzw?=
 =?us-ascii?Q?cL2kQ7bXt4A6LtZQKxb4jLEwyBKmowvw+Y/A5ztRs/5yFrQJZYpcADX/BxqI?=
 =?us-ascii?Q?M0Pd7X0XAKdHeKFM497qpTuZlgFvyVTXf0ZeEEwfMFy9DkSg98/aqdx+cTDe?=
 =?us-ascii?Q?sdDbhU7OvuX+LRDNMqjIdHs2ddeJBeomRhsnNGQnwU0V6Dkj89SEIjDB4xSA?=
 =?us-ascii?Q?cG6g4dH4gIubaYQkckQTWoBTJxJqpl0lQDH8WaPjkwGoASxd2SFH5hv75TfE?=
 =?us-ascii?Q?phMCuYlIuQmAa0lUqBs008nww34dvv4nu4o+jSyqkB7gnzQV+t7ujx6LC6Ap?=
 =?us-ascii?Q?oezvceIKc9KbwMuVr4ZkHb2xc1IekI1nPB28ZZCo8jpirHjn4EsGSJD/8xNk?=
 =?us-ascii?Q?piGvNkEnJIymyrhkBazh0VOp49swCFoPDDU24Lcw6lhc4MaGe0jPgCFs2mo3?=
 =?us-ascii?Q?npT7rkPS96rkeQo+CUG63zjllsTCkDrQsByAqP0G5/zSvYZtyxm939bQGh+/?=
 =?us-ascii?Q?w0V1NdjXad/aSNgTTIF46XYyhCPkN/gLKshgNhzi/lQzMjjR3AVhsVA1Mcbn?=
 =?us-ascii?Q?ft+X4S7w/GsLIKqc+pFB26qofrJ/O9MhP2xonjQvcJElhN6AjWoeri7ujBm3?=
 =?us-ascii?Q?ZkD1MW/9Oxfh9kPSEK2GSqB+YFvp/KNiYJoMAgYNPegiVa40PrzXBCNSpx8q?=
 =?us-ascii?Q?WRCLOivYP8gQrbmUPSaf6pt85YHvWsjZCStk7z9JIZMrib0BywV0MZfd+s7k?=
 =?us-ascii?Q?qXAlvrcLQb18wTlDyxsL84dOa2Xv6LOTyZH3z+w6E2t0iDgvlMzvrHwRsMgV?=
 =?us-ascii?Q?K4qkIyyVnoSNZ+38ff2m21/qDRifSP9+MNY7tBC/Qr0QayfQ7PqC4Fb1qH3S?=
 =?us-ascii?Q?8qTrZTLXEcjHUHcr+YPYTr/Ky9GOmNa0Gh9lpYJ7kmZRtY+QUTvdht4sqfPU?=
 =?us-ascii?Q?dUcJgclTO2fiH8RHOlVk7n/8LhyWKfeCFb5HR5g+tUoeIo8PHJnYKsc5SKiC?=
 =?us-ascii?Q?J7g=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pvi7tR5owP6nVku1k8e8E9Aw3TYw1BQSNXn0rmBHo249xSo3w6wP1J3Q4WPR?=
 =?us-ascii?Q?hLs7rSmFb+MA/eHtuVWp5g0WV235Y7qbWommgVFDPklhlhxALm1CzXjeBGQ/?=
 =?us-ascii?Q?38mOpfmBur2outF4/tKMtAYfX7hyOZX+WAVY2JJa9EpwUhGtYIuApdAHjEQn?=
 =?us-ascii?Q?90kV3ojBMqGE6PgfarsbiOBuC+ctKzbRUrhSEboHT1buM7LAvE4qDL0l32Ia?=
 =?us-ascii?Q?lItjU2JqA5loNCsa0Il8lgBQzCLoxC1Sj6xUtB9HLpmqcToRr9yDGPbwLrh5?=
 =?us-ascii?Q?z4PHz7tjyBpt59J7PJ8kCXttocZ5eB9GFGbWdIMUjDMmzeF6ByaSaF0NycbX?=
 =?us-ascii?Q?f+kiLRN4Cdc8xLfCHxgCjpJzcKCCjeJ7yrmwd5yEw5zfQlkwYmabto/meWIU?=
 =?us-ascii?Q?4Or/yHIvP7rtfh8pEhUWPhrXGajH+RvriJ8/2ve1s6T1eN/Ua5+Qjm9yZahq?=
 =?us-ascii?Q?uE2WzYT58Ave2e1OcKbAqizpmA/GL+YyCuddtc3jQKl47c0/id7uucoXhSsS?=
 =?us-ascii?Q?4InyTGnUNGE2BCXpZFSjXCzCPxl9kaar5GVJMtZIpuVO6yfucrnI58HeXvZF?=
 =?us-ascii?Q?x/3jKiipplNxB693aMcN0QRaw8KUge8W1UKFJL860ZoD2COUTePtF8o/fZKh?=
 =?us-ascii?Q?1kcp2eizHmpreWrcLm8HOIq90imjZgsRAD4pYSSjbNBK+XGgakm80YI+YIQF?=
 =?us-ascii?Q?Z9vEEcHc/wVGzcjRwb939l3NT4zZxCRD8YDdcxDXhHk5chDDYQAeYStedvYG?=
 =?us-ascii?Q?RVy4e5HtI5D8vuTFng6Ro/ULXWRWoDD4VFjU1VEvJ4dJ9nLRkVW2icZ5kjdw?=
 =?us-ascii?Q?TCFFkzMT/kuXgsG2rVEOkr4r3o511Siv5sXCHFQXl6vZ8Z9cIqwGmODaaOfq?=
 =?us-ascii?Q?SpAtW5hqPuI1PnIUpVUluPV+H6+NdWjsSRQeGyDfna74u9H7fHu11sparWIm?=
 =?us-ascii?Q?DJ13JzijUG3+p04BM5LC7ZluhFO7Vj+PiMgCmZKWFVYF7mEYQb79BETXEQ57?=
 =?us-ascii?Q?b/P0K9RHJhgMymenhtOk8Q1Q6SMZruj4CKI4RrlU16+yfTpb7jQpPHppzlJy?=
 =?us-ascii?Q?K5eTWzpxWMtOspJ594bKaLYdB5GUoXGqKc/Fa7m40ZNRXbwn35a8Z3IffXfI?=
 =?us-ascii?Q?TgCGUPkDLYpKbySHeq3rEblVerd3zpgui+OClJPeV53ZBUzNTTvyMM3AaGQq?=
 =?us-ascii?Q?/v7BGIkESDjKIVjodYsz54qrDk0meQXj90u/yaZNlOP7REuRCclnhyJTFxdF?=
 =?us-ascii?Q?6wgf9NDD5pyKw6h5QqVa/Jtes5Ulj94nRbFdUXIyMc3beGxVoz0TvhhidIsy?=
 =?us-ascii?Q?GDNFBUQ5OPNBmsjPcS2AgwvvZ0RMlWrQtjB8v3KEM29kAMKxThi1TU/0dOg+?=
 =?us-ascii?Q?/+u5gE5Lr8tpDuTiDbjRRLR/JBesxOHKuEzWqoXmMQH6H2opwRPmVpRb92vO?=
 =?us-ascii?Q?E0J80hzaicjYbbR8Ao8ujptDGwtTcPgujEysgyjNPAzw+MtYBvsKFPCQC4Uc?=
 =?us-ascii?Q?IfgM61ItEOjPJlSXiwIzDlyq4cm+n3xgxYxg9H2JJZox1gJGhRNaUSuim1w9?=
 =?us-ascii?Q?A/8XGA4fa4ZJAOYBhXpajlK0rsvbEzy/Anz/ZGTX83TIWx7CQYB33lDZDwtb?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GubkKOwgRQTQpsFoCSYEykfkLwJUPDpIliWsgAHdnGO3FlpQnRmyk2eN0MZeBimVP/VMa8UgJf21mbC0OaAK3udN5ty97m4iSCzN+kYe1HZkFspKFFw2dVWb+rVc1MexF7pMcQ8B7QxmSPAckjbs0Dweh6uI1tburu+L8ULyu4n0mq2cTBTwxuF6XnjnkeR6A5QhH7WQBrHh+MZPLPQ33stpM2SdEHFo98BI4rIpL4CWeX9CGm89+yuJcEfiVy6Y7zzrgs8qxj9o5rJsEDfFp/sVG+/XzYWzuds9KihYZN9ZLv4b1qFEBd4W9VCAALBiuaaxZAnQnKCMoi2hLqm6apolv0ryDubMPTq5OMvVbxkdAinqHRUHfPKnVMT3LuqSaaFzIgaVFb4Cb0gGZG+5Ux5HLw/b57Xipxl1sfPJ3CSZONcVpB+nuo9wStbjxnCycYhIExhHKakW6B9vTPV0Mw96Mhv9FGTFMsVZ6OaerG+Sg7iiokNnChR/CinpR57GvksG8KVsehKPO2b92QXMRC7JYs2pnpCntqDwzZimu/lET3U8TjP7HgXUzccOV8MExU99FQRMIBZ/QD5LPceYn6f6HVMP5G1SBBPFCejM/b4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4627f1cd-9f71-4333-f231-08dc9b8ce4db
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 18:21:01.8452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bKrlYRNSeWwzLd1+CGyhOyx/DOSmY0TL0yzsAv7YZI5Z7nZu+KublKxHfY+ThmXzR5ZOk6S9Tv6GET/551yjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_13,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030137
X-Proofpoint-GUID: 10bOVkNuNm-vx7Yq36KvJN6RGHOLtUdN
X-Proofpoint-ORIG-GUID: 10bOVkNuNm-vx7Yq36KvJN6RGHOLtUdN

On Wed, Jul 03, 2024 at 10:12:33AM -0400, Youzhong Yang wrote:
> Hello,
> 
> I'd like to report a nfsd_file leaking issue and propose a fix for it.
> 
> When I tested Linux kernel 6.8 and 6.6, I noticed nfsd_file leaks
> which led to undestroyable file systems (zfs),

Thanks for the report. Some initial comments:

- Do you have a specific reproducer? In other words, what is the
  simplest program that can run on an NFS client that will trigger
  this leak, and can you post it?

- "zfs" is an out-of-tree file system, so it's not directly
  supported for NFSD.

- The guidelines for patch submission require us to fix issues in
  upstream Linux first (currently that's v6.10-rc6). Then that fix
  can be backported to older stable kernels like 6.6.

Can you reproduce the leak with one of the in-kernel filesystems
(either xfs or btrfs would be great) and with NFSD in 6.10-rc6?

One more comment below.


> here are some examples:
> 
> crash> struct nfsd_file -x ffff88e160db0460
> struct nfsd_file {
>   nf_rlist = {
>     rhead = {
>       next = 0xffff8921fa2392f1
>     },
>     next = 0x0
>   },
>   nf_inode = 0xffff8882bc312ef8,
>   nf_file = 0xffff88e2015b1500,
>   nf_cred = 0xffff88e3ab0e7800,
>   nf_net = 0xffffffff83d41600 <init_net>,
>   nf_flags = 0x8,
>   nf_ref = {
>     refs = {
>       counter = 0xc0000000
>     }
>   },
>   nf_may = 0x4,
>   nf_mark = 0xffff88e1bddfb320,
>   nf_lru = {
>     next = 0xffff88e160db04a8,
>     prev = 0xffff88e160db04a8
>   },
>   nf_rcu = {
>     next = 0x10000000000,
>     func = 0x0
>   },
>   nf_birthtime = 0x73d22fc1728
> }
> 
> crash> struct nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
> ffff88839a53d850
>   nf_flags = 0x8,
>   nf_ref.refs.counter = 0x0
>   nf_lru = {
>     next = 0xffff88839a53d898,
>     prev = 0xffff88839a53d898
>   },
>   nf_file = 0xffff88810ede8700,
> 
> crash> struct nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
> ffff88c32b11e850
>   nf_flags = 0x8,
>   nf_ref.refs.counter = 0x0
>   nf_lru = {
>     next = 0xffff88c32b11e898,
>     prev = 0xffff88c32b11e898
>   },
>   nf_file = 0xffff88c20a701c00,
> 
> crash> struct nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
> ffff88e372709700
>   nf_flags = 0xc,
>   nf_ref.refs.counter = 0x0
>   nf_lru = {
>     next = 0xffff88e372709748,
>     prev = 0xffff88e372709748
>   },
>   nf_file = 0xffff88e0725e6400,
> 
> crash> struct nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
> ffff8982864944d0
>   nf_flags = 0xc,
>   nf_ref.refs.counter = 0x0
>   nf_lru = {
>     next = 0xffff898286494518,
>     prev = 0xffff898286494518
>   },
>   nf_file = 0xffff89803c0ff700,
> 
> The leak occurs when nfsd_file_put() races with nfsd_file_cond_queue()
> or nfsd_file_lru_cb(). With the following patch, I haven't observed
> any leak after a few days heavy nfs load:

Our patch submission guidelines require a Signed-off-by:
line at the end of the patch description. See the "Sign your work -
the Developer's Certificate of Origin" section of

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc6

(Needed here in case your fix is acceptable).


> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 1a6d5d000b85..2323829f7208 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -389,6 +389,17 @@ nfsd_file_put(struct nfsd_file *nf)
>   if (!nfsd_file_lru_remove(nf))
>   return;
>   }
> + /*
> + * Racing with nfsd_file_cond_queue() or nfsd_file_lru_cb(),
> + * it's unhashed but then removed from the dispose list,
> + * so we need to free it.
> + */
> + if (refcount_read(&nf->nf_ref) == 0 &&
> +     !test_bit(NFSD_FILE_HASHED, &nf->nf_flags) &&
> +     list_empty(&nf->nf_lru)) {
> + nfsd_file_free(nf);
> + return;
> + }
>   }
>   if (refcount_dec_and_test(&nf->nf_ref))
>   nfsd_file_free(nf);
> @@ -576,7 +587,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct
> list_head *dispose)
>   int decrement = 1;
> 
>   /* If we raced with someone else unhashing, ignore it */
> - if (!nfsd_file_unhash(nf))
> + if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
>   return;
> 
>   /* If we can't get a reference, ignore it */
> @@ -590,6 +601,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct
> list_head *dispose)
>   /* If refcount goes to 0, then put on the dispose list */
>   if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
>   list_add(&nf->nf_lru, dispose);
> + nfsd_file_unhash(nf);
>   trace_nfsd_file_closing(nf);
>   }
>  }
> 
> Please kindly review the patch and let me know if it makes sense.
> 
> Thanks,
> 
> -Youzhong
> 

-- 
Chuck Lever

