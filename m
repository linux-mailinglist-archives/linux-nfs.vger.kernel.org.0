Return-Path: <linux-nfs+bounces-4230-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3FF913510
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jun 2024 18:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D4BB21ED2
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jun 2024 16:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868701DDC5;
	Sat, 22 Jun 2024 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aDlTnBqp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w+KwcVs6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9D170823
	for <linux-nfs@vger.kernel.org>; Sat, 22 Jun 2024 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719073804; cv=fail; b=jjdyA1Vz/G3HLGLFGIS93aXO4VdyBVmjY+nIuokgre2Pw/JfAEwVqhmAFgQqaS14R8DCBeIVv6wSLfSdK6fVfCPFiE1fxANWb7HwkpP3NAtpMfpn9HgDRTZh80S+vwgci/foLiQLolebYFgt0/r/fFIeW4aLwifG5FQ+smyHjyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719073804; c=relaxed/simple;
	bh=q2KMUtK8W+1VbeahJTNkrLATGzXue+mipUEdkp2gXQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=puPbj4xBIP0Slu5o7st1cJ63BSkhNDTzR3QjKB9kcTGbMtI869WkIvnexSEulnxhcyoyiKJS8yHsI7Iu8NWTB/dXcuLtuAFIvsqQOYb1eLywKXdM2OhNmKIbU5/wX2kHblryHrogUDT7HT/4pbaC2beKU9NJ9Bw7FAYGDry8f1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aDlTnBqp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w+KwcVs6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45MAfOhZ001227;
	Sat, 22 Jun 2024 16:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=6kXzCD3QtLhgXq1
	HfpQHgkHTGRuaHaSjE8BkNlFl0q8=; b=aDlTnBqpSLFCIEWmXMZOmixnLPvL+Wb
	ArJajlOYPrrn6kGpCNW8wDsAlPV4itmhk3XBnnT4ape687K6yivEaKS0qUSprt60
	UhQtq/ztzb3ZRrJ8WfvDCFNsMUK9/Xw2lNnh5YQxlmtrc9Vlm6QHBGu5+hMEdpV+
	dXBGMquSlRmiMu2AdfW5nGGqXLISeO1PH6uWax37LoNlEI5OJ5xmjiG21J3CHdAf
	6TkKEdM9NrWx07MO2QYVUjNXbcM3wdNdZhlk+CKNQXuazmX+eWuHJ7ZR+V82I4ot
	zieQyadkNGDlZJUmqjF9owMgjyEv69SG0q+zhw1er2gny5C5jFG+3pw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnd28g26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Jun 2024 16:29:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45MFmAMt023335;
	Sat, 22 Jun 2024 16:29:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2ax2ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Jun 2024 16:29:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipe683aANHHgPvFwip5QA29P/NAhUAVyCOCcU9KAvVk0qRyA3ZEQNhZx+Z3Bebiv8ExkYsgbi+Yy01QhTkobeQnVexcBqqL4uPkxHYdyxFprVnECaTrkOq/8j8N5NUBLu4GA99GnPXZc7ndHXLfL/lBwqBxnPAtF7Af0QBhvlg+yK8DzSDUfY+T7V+PMJCgPGuDs3X8r2OkhNWMTNeqdUgrLK20TBssZvjnvpkzMKfhRIgyY85RVvGTVWm1ssLqp2rZfJgUavU1uev40CJLYNbtRrwSLdozHE3HS1GPssM5yRzeZyiEyQmjq5m7/jMvhJnxIxcY54PKlbP+SfbciIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kXzCD3QtLhgXq1HfpQHgkHTGRuaHaSjE8BkNlFl0q8=;
 b=P8CDtMOJ9W1ewi9AoYCZyht2K4YKwRklVKJDV8mHJu79Nmo2qnSlderHlsW4eYzID/kScL5z/rB3p95rvDH7JFajxHFfvbKHXoTkuLInmsMXJMzsnZ3i5SWo14LwAtjAb/tSce0JImK/3at3dyg/I2hCPwHFTWkZNbgz+crz0t2lkkaMEYeSX/v2FhSq642SBnPCP+JHDZYFq+ttCJK/YeDRIvOTxOjcpGPv3NZXXz5DyhyPp0xB/cmey3hmVHU9vqlYBL2AzMNaGKMvInNr/6W/fWm/MRcXRzwGHDW+pc2RSFNK5aIG9rSHn+QHccBzb5R12Z+/QZimuEewrNM0Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kXzCD3QtLhgXq1HfpQHgkHTGRuaHaSjE8BkNlFl0q8=;
 b=w+KwcVs6jt6xPnFjSqIWbawJ4lKNK25kXsZBxAE6es75vYkba895PyiznxCPjZSa9hIO8O9qAh73toOLT0QfiKQwb5SJy+KOsj6qLQWd4Cu+XJETaqT5330Y7eyMrugy2wWNepxCAYEU0Jr2V30tT0beZE+q/CmK1mEGijg60hE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5086.namprd10.prod.outlook.com (2603:10b6:5:3a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.24; Sat, 22 Jun
 2024 16:29:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.024; Sat, 22 Jun 2024
 16:29:35 +0000
Date: Sat, 22 Jun 2024 12:29:31 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 2/4] nfs/blocklayout: Use bulk page allocation APIs
Message-ID: <Znb765CNH/5WCVkp@tissot.1015granger.net>
References: <20240621162227.215412-6-cel@kernel.org>
 <20240621162227.215412-8-cel@kernel.org>
 <20240622050812.GB11110@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240622050812.GB11110@lst.de>
X-ClientProxiedBy: CH0PR03CA0328.namprd03.prod.outlook.com
 (2603:10b6:610:118::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a4db18-12c9-4e9f-5d9a-08dc92d880c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4anHL3aCWW2LRl7G/IJxbAO4VPG9iAdix9N1hhrTMVlxoofsFsnSLLFlfA/z?=
 =?us-ascii?Q?2RRZNdBPjqs5NbuC9aRTHjPej21zE8geZzSGyEpwKZvjIHkOcyYdSlJNg0TE?=
 =?us-ascii?Q?GgCPk0hkkqs927YZaRrL6rWgJqfgGHLsS6916DZmQdPkU41i2EIoEpxVttAX?=
 =?us-ascii?Q?w0MPO8Sl4626BRK3baQyNiNeIX61iV0+LmnwJX96JJRjZpXv4xfy/yiZ2gYe?=
 =?us-ascii?Q?bXTcxVbXDavfoB74K1IHIV5KCFCyZQGhaUM80K1Qt/HnbkTXUABGd72lURrw?=
 =?us-ascii?Q?WwGgAGXfNqwwAIhbeEFfa2eLC7bI2jjiIDYJlkSBgaWUJjQvuPAH0eI1ChQQ?=
 =?us-ascii?Q?pooy26F0VCu4f5kF8Tx3EQlhMwfTEBTiMY7dxxz/Z819TBLnG7IzYT1vYAFY?=
 =?us-ascii?Q?DRCUyWYSzFf9sFScu4EggWuvDibvzhRLlyOU3D8KxPLyIdAFNQ2XdX0ydDvS?=
 =?us-ascii?Q?ccavJFW16sD2mNT4E7wFvWkz/tjYgCMKykF6ojmiuaquQfJ6maKGodeayFTZ?=
 =?us-ascii?Q?RLG8sd5++zcSrLOEjbh/7mNS2A43kLtl7lAquYnPcGRPh9mpEG1mBf5BJ4uB?=
 =?us-ascii?Q?t5W4BvjrYPxlR9k2xxaBCNBdFY5oq+AnVIPo8ZQvcTb4SpuW9CKgl/OKFKs4?=
 =?us-ascii?Q?I7k2IoTsY2GcLKN+hP5drLqUZUUUOOrGUYxwoBz1oItru/3WXNAql2C7+PXv?=
 =?us-ascii?Q?8j1mv6T4zhK0UiNFkyvvw+o/yFfX2+tYm/uks/z9ZsNXFq4KkuhK6Vz2b+nK?=
 =?us-ascii?Q?F3HkwRGJe1ObsDPbLSRGT5ROiSF+IxbSlLzYGJRQ9Qag5/j/rwAb9GHTVOI6?=
 =?us-ascii?Q?Lq6CijQ6TjVQDTEV9CKWG91A6iGcXewn6tTbONyndmC+0shcRi8P9sXuVLKJ?=
 =?us-ascii?Q?Mi2nkufyLCWfX0JcrMIKC6vpPgHkADk6Xy4WdwuK1zvzG9a9O1iZlcu+pf4i?=
 =?us-ascii?Q?GL35pNUnFn1TWnZjsg1iOg1L3cxlsHqGZ565bwoupIa6+dPULZCivCe24YJE?=
 =?us-ascii?Q?RwG6AhT5cacMlJVEjJMZ1e3eU8ijMUOAxIkW68+tzJdJBoMWcu458dKuItsB?=
 =?us-ascii?Q?X5MWYUXkTzYdi0sbIGzjrxbAUUtLVdbE86O4tGJaM6NMCjuPtZCw5gaxck/U?=
 =?us-ascii?Q?sA3xfJv6lt2eA/BLQnH48gGzkdzShwOY3rWFQYa8SqaT3VVROwC9ZxewNFqE?=
 =?us-ascii?Q?bfkums2WIsXXTC7O9AuNMYIfs2v+OUroIBAvAP1HpzFbS+Ins0YlpIqTr7Xl?=
 =?us-ascii?Q?NJdfxcQ/VgaD0hb/3lIwFPGbjswOMY6lFZ+sB5U2suTw7r1Z2DYPqnc/QwJ3?=
 =?us-ascii?Q?miov0sjuu8LifKnQmpXQxQu1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+tYA14K8nsy+LEaf+XdISIFjnvPt4imiAwTHsS4K12qCecunnEYgWaKqTWUe?=
 =?us-ascii?Q?coAD8JKS+unkLt+p2dgQ4Odjf3v+O4iq+Ew1VYVIlFzL8j2XlzPVKzPsLi6a?=
 =?us-ascii?Q?00uTIHT/fyMz7/CUVwoE7PsiLvSSy3V2qKPHkD0LzX07SLEDg0+RhOkvvgMy?=
 =?us-ascii?Q?OWb6D8Ssxp49GmKd5rkSReUQV42VtCBWEd83+bL9sjJjjIBtmvuNvkHQvo08?=
 =?us-ascii?Q?0cZ+4KeFV6CdcSUEbuKW7gkz+gIOVJ88t5RJMGkWHm78PfR6xcKsDkfh9Bv8?=
 =?us-ascii?Q?B+9ZDzy8mHtSZq4s8UbIk7q3CaZQZXnIs9DtH7ibNlfy1xWr/4ZvmQw+q5qN?=
 =?us-ascii?Q?6trzmFC2asqiezn53ZsqE9zhraLAanO/7kD4ZFWeWl2nOWDY13C/WmoqFKMy?=
 =?us-ascii?Q?M7KnsUsgUGxNLOUuGcwpRd0j/nkeRowb7CoHZ+UrGjyLJaLSVQ0+Je8vwxnd?=
 =?us-ascii?Q?BtxpoBxUrfXaMNsvDjzgvZCzURvNgAO6X6Wi6z503wQK4SaSw469BD9Ee7rw?=
 =?us-ascii?Q?da3MRZQOPIOf1V0pVxDRv7D/gmXSWpEyUoR6X7NHPI2qAwRULQCf6z2+U7xk?=
 =?us-ascii?Q?VRqLBjJDYLFHpUYKbPhXYtpF63a979UHyM2oDz30wfvq8Xc1ir04tOL5oDC0?=
 =?us-ascii?Q?amjJhpf/eo3mQ6o7ZRinnC4wrzpi4Ey8C4QMCXhYfZFWI6OhDCdN9VluZ2kx?=
 =?us-ascii?Q?STix7727j1edOpSzjTraMa0kKt5lk8W5h1mtNWDWCZY8IoXY0QCzYlKTdQrH?=
 =?us-ascii?Q?VJf43UrQ5oogyjj7vEpuNQdqMWg6lDJpaVd4ezBi5+3GLnO0BDlTR0IzAPtJ?=
 =?us-ascii?Q?TVB6RVmDmsSFDXUw+P/YOAIo3RH8OPSK+KriyriPT5JBAQ9uv+wYbCLgZf28?=
 =?us-ascii?Q?LNfz15oLh8k0SNWRTQxFffeVkDhAW70lAYkRs6tEHyJyDb63Yn73l0I2kRJa?=
 =?us-ascii?Q?Z8fsXa3vcxAH3P2FIWfOZ8tSpiHkSZ55g6P8wdjCOp3fKp0qgbfsInPcPenv?=
 =?us-ascii?Q?9yhVvGlRK1Yh1QHFYGdwxPTl+DZhr6XPHMmbqM9jtELcWmk5iikEUAj8Bd4o?=
 =?us-ascii?Q?K6nYVqYuqgVoZFmQ8GIiuDiu6QIBY4PpBVzd1uYzBDrb2pgFeSLtCW1T0fNr?=
 =?us-ascii?Q?hxLKJGQWJzk0g8KyasOezE+qiOo9kbK6Xx/Le2BnTCPZv+wMhLy5/aW67HlF?=
 =?us-ascii?Q?D0KzeJiQYwSG9uKmBdPcQIv4dO4kS5ZexDBRnzSAlVxri/QWapMxSQYwLww2?=
 =?us-ascii?Q?jczv2vZFC69Gh8OdtA/vajbOaklR66SYhL9y7j7EifhcFoc1sixSZ/9wl3um?=
 =?us-ascii?Q?u4dOXHW42h7Si52imOjo/nzEIIaGmh8jDwz/DwuMFjzeCPi7iWHaFEBXeOUR?=
 =?us-ascii?Q?PoHUSeAOmRT6zhyF0Is0goXW+GB984BNTJK703cqm5PmAf8FlJdyql0Ys10a?=
 =?us-ascii?Q?4/xAIXStkdrwEIbClgQ/JmTc0hvPJc/lx9+iLBolLPhFfd0ITUCMxG5Vcphv?=
 =?us-ascii?Q?+wcxVU/XSNO4vvCzKa8LyKfF7Za6vNy6+0OohgTE29KVA9FkBavOgIyD4755?=
 =?us-ascii?Q?iJV6a7m5q11rE2AJOSJpydeqI+fMCSdXsStp82K9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZdGmbo9Jv2wgQzOBqPWyOMCNfQ8q1SFOh313Mnjc4i5Zur2DYTHym66awhlPGAl1AykNG3sRQ7k1Tnmd09jFwSDnQPm96Ge7999eSdbeUDNtsqa43x79kV010nfQmbBXpZjf8zelzeYaoO5jslv/A7N8A/vYWP81cZk5hLse7dmvMFpcRawuCL9f8oG9Mudku6m7KfNIgQ+8LvbSU8QfFqwTYHUThI2xAeQ6H1jumPMrgKDmJ9GjqobKLLTSHWiwf2xTxX+RsppxP/DpjaEvCqyPOZXcRykQRCNXLi2gI66iPSzzKq2QYmspkZgF9fMGT9bedhg6bEm4VW34yWjnxZwQ3vKi7h+88If9+UcCKK9i9lS5300H8urEsdzMrr9zY3s+SPsS01p79SFe02n4KvcphIaL5bqkNFS4aBYozqhAsFRsN6iRwjv0P9Kk20YfAOehDCrh8n6rv07ObQ5a1KvK/zcFKAVlyC3RWPwas3BaHoTriH/aBDneWyWxFYWq6CewmNdgcIDeX45CE2XB3Gg4CXxi0Z+ruPNtlzoycXH3NV7SiC6wpPBlmaQpRZMJwIq3qnuUk6+Pl1TBw7Oeiyn/iUIvZRblEWz4T15D6/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a4db18-12c9-4e9f-5d9a-08dc92d880c3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2024 16:29:35.3597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+X4SJ8mv6SEBi3fU76ejPJxUaCvJTD/fUNDmb7BKW+dYybLfxE3IRBeB12kh/yptHHHIv52cxaqzsXHXHXBwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5086
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-22_11,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406220121
X-Proofpoint-ORIG-GUID: xbKZ24bzC38sdKjQvWzCuE_jCWQpNpN3
X-Proofpoint-GUID: xbKZ24bzC38sdKjQvWzCuE_jCWQpNpN3

On Sat, Jun 22, 2024 at 07:08:12AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 21, 2024 at 12:22:30PM -0400, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > nfs4_get_device_info() frequently requests more than a few pages
> > when provisioning a nfs4_deviceid_node object. Make this more
> > efficient by using alloc_pages_bulk_array(). This API is known to be
> > several times faster than an open-coded loop around alloc_page().
> > 
> > release_pages() is folio-enabled so it is also more efficient than
> > repeatedly invoking __free_pages().
> 
> This isn't really a pnfs fix, right?  Just a little optimization.

It doesn't say "fix" anywhere and doesn't include a Fixes: tag.
And subsequent patches in the series are also clearly not fixes.

I can make it more clear that this one is only an optimization.


> It does looks fine to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thank you!


> But I'd really wish if we could do better than this with lazy
> decoding in ->alloc_deviceid_node, which (at least for blocklayout)
> knows roughly how much we need to decode after the first value
> parsed.

Agreed. And it's not the only culprit in NFS and RPC of this kind
of temporary "just in case" overallocation.


> Or at least cache it if it is that frequent (which it
> really shouldn't be due to the device id cache, or am I missing
> something?)

It's not a frequent operation; it's done the first time pNFS
encounters a new block device. But the alloc_page() loop is slow and
takes and releases an IRQ spinlock repeatedly (IIRC) so it's an
opportunity for IRQs to run and delay get_device_info considerably.

-- 
Chuck Lever

