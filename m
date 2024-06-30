Return-Path: <linux-nfs+bounces-4439-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9094091D395
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 21:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF742B20BCD
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 19:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7BD1553B4;
	Sun, 30 Jun 2024 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cbEjozNz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pye8rsQS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716D337169
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 19:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719777369; cv=fail; b=qfuC2o6CHeb/RzrXm0Lr80PMlxdAA9F0WnW9ZCggobyS3/lXtya70q36b8hh1mD3Mg92y3TpSkVixNK1UgRV0Rn9LUPuJlaUXGPhL1RdOrl0hIpttlYeaRJSQ476okCIAwoPBw/Q9HnRp9YvIb4KMz47vCcDGvlYb7ECWm6IHaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719777369; c=relaxed/simple;
	bh=vEmCfhG0xqKJ3LV6cLjGYIHAKlVndN5RT6yvzo3ZtVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TTF2EB4MPe7qt2PnQ3cTwuLVM9QBKRn0b5lrYEw8eeY+Rz+tfuJUUpT+IQ1ny31HBVbJE6d9w4HSWA1ylIylnu1gidpb2lmzBCZGtuGVwVxkLkRekdQf2+OIM5jb/Ddo++NP3jsrZLNGcGZ3/gY64gxMz3iZrmPo+TzN5vhHtmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cbEjozNz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pye8rsQS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UJEZKS032259;
	Sun, 30 Jun 2024 19:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=l/1Cty0RomnO20V
	cs9qWWt85VLhddhewaawrmZnSJqI=; b=cbEjozNzHXLA2j7d4MsDiB09n/h1fxs
	gIeMWr5FlWuo1AvtuoOKqlFbAUw8DN9AGzYRNkt83il4PdllMd8s5toa3cGk90vT
	CtTK6z6NdGMMyaFG+trZ1hxqwPFMfmBTnKyWnE69dBTbbTQnHUKRGHfeyV2I6y4s
	AtQvo99iy50L6ksQpD6ojgTd7Q/V4rScdPkEfcy4rVg0+YWatm3iZ1v2okAHDAYv
	aqCmzTS6nFXic10bbAGjFemeCJWeG1ArBZFTOLpSv7mJsYVBuw8rV28Dqjkf0lig
	G5okv2fg1KY5UICGP18G5KUwLiSjmBVSwCS32wS4uMi/9C2Us/+6kWg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aac9faj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 19:55:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45UGLHXj023108;
	Sun, 30 Jun 2024 19:55:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q5gmbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 19:55:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3OsPxxls/WKXILoATpJht7+tZsU44Emo3fjJindwkEc3u5vuzBgAA/L1EZzIEnII1uhhvT7g9krje8h3FHv1Hl+pocuvAf/cQ4yj39usxr9nia8wbnBLVJgp+keUPxHnt+RLrkqJ8SX653Cgr7JiSL2W97o41udUTYxdeHjAcQewk1Kk6c7TQFeOC5MGfIISbVX018JQLfhj7Xd4st1xghhs1qyzB3QxdmBjFhVKwOTpXALavqgoC39ha4TJHMqCfQsG+fd2aaGIojngLDHY8bK7Ex4/Lzd4nj8EdRaPgudxCb68o3WWfPZ5bYHHgzIy14B1Muv8EwRwYEVAKwVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/1Cty0RomnO20Vcs9qWWt85VLhddhewaawrmZnSJqI=;
 b=CH+Y5nLRQFQiYZgFpl4vWege2OMIzSj0whxt1rOK3Taox9hADNuLCYTT5IEiaTcxVhnLGmCe+OsZ6yUNXacqdWY3kpqqyIqfx7FWhq96Zg6LAFh7UmD+oXh+dE8x4yK9tn43xVnNI7eO8Xse3XnjsPNyDUTEdXiViDqR7Ay2YAHSBxQ6XFUsRz9Y+3LND+KK0VIXjhDofKNgjS4XIbv1QJxbsdDkG64dJfQS900KSK/kQZjpX+Ihdmiy8KhoHk1Tu6BSRUdDO3mqMag18mTKvyfEe7UyKMZVWxTPcccNb4tg1aULclgIqvB9iAAGB2kVjwEQrBQGyZCa+9j4gKZ9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/1Cty0RomnO20Vcs9qWWt85VLhddhewaawrmZnSJqI=;
 b=pye8rsQS1rdnOwuJDJFkRYnVMtcxMMTygC8kgUrex9o5nC6bfggfeuwI+pxe29Gm8iPcL7deFd6gy8lAymoEEjFq8gcSsAD6zxzIslRe3+lOSUtoajg/mcejab5ewgUF1oaSOfeAQhHB5S8WOJvgixVX0B/y+hVsJxr9fv1rK8Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 19:55:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 19:55:47 +0000
Date: Sun, 30 Jun 2024 15:55:44 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        snitzer@hammerspace.com
Subject: Re: [PATCH v9 13/19] nfsd: add "localio" support
Message-ID: <ZoG4QOGLTy/0zsS0@tissot.1015granger.net>
References: <20240628211105.54736-1-snitzer@kernel.org>
 <20240628211105.54736-14-snitzer@kernel.org>
 <ZoCIQjxougYwplsp@tissot.1015granger.net>
 <ZoFwj0gkBf3Pr1RI@tissot.1015granger.net>
 <ZoG1pF_sgAUDoH-n@kernel.org>
 <359d5b252f6f5a7eb348c79beb00a9e6594b743c.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <359d5b252f6f5a7eb348c79beb00a9e6594b743c.camel@kernel.org>
X-ClientProxiedBy: CH2PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:610:4e::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: b235e092-b773-49b2-2078-08dc993ea2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BypQBVx+xmwdOwCtxJYL965mJ9opu/vi/HeKjxKtBNBCxGkGMX7xS0T6fM68?=
 =?us-ascii?Q?wOfWd7g+HxkRzgOptNgUa3X6UKQ1QljOo5JH58xbutLCNwX4HlMHn8XSGaci?=
 =?us-ascii?Q?A7T3616dReq0B25PiXWOPub8N+kerdSnoXxS+uMXIV1zGsIG3wcoBcnyQFMA?=
 =?us-ascii?Q?2RE/BwPG0TJnrS+11bz/BaneHxGK0Ii5NCVkEVEUGRBxnYL4xmKZqRZcBtDk?=
 =?us-ascii?Q?yEsbtSNMHIAaD5SbQTNL++Xp1LrbBkBaQZ5f11iZE1YhwO410nlAhX5GoVay?=
 =?us-ascii?Q?D2BWHSu2pyq2FMjeD2qXD9nhgB7CJ4F4JFfywc7cI+AyEOj8QknmEcB9hTcZ?=
 =?us-ascii?Q?nsT9rzqchd7C6JCqsG4oVsCurMXyXij1cRXThPotOwyuKvqzN4ap7Nl8d589?=
 =?us-ascii?Q?SvumuT9Pp+cqqNiULv+POzXVytlVZsEBvyMMYIR6473IZVSM5I2zx5WyUQax?=
 =?us-ascii?Q?1/SSeDjjJiR3npAdOUxbrYO0v6NLkl2R0cEJ+4P4bNobYkM6NZQVQORhpZpo?=
 =?us-ascii?Q?0/WpJ+zXcq6WRjv1GGq+sqEHs1ME1niw00C01BtnV+jX/XpClnqozF/SK+cs?=
 =?us-ascii?Q?GAOjNb3Gr89VUUA4dPD9dvm/7q3MSiblNsJOHMCpkJkMt9c9ggCFbXniHSit?=
 =?us-ascii?Q?IVi9HB3keE905lIHRu9A+d45gfJIk0NXyJvGKI5BMji23np80IwicgHAcUJb?=
 =?us-ascii?Q?s/cGJdCg1sDJMJadWVOlJ48zdppLx1KVgz/X0zaVCityD2b2jkIptxVD1wz4?=
 =?us-ascii?Q?ku0OZzoATvmn4cn57xTgtqPvGLmYldJ+SPZd+5dtExx3e8dtefTNtfoMEdg8?=
 =?us-ascii?Q?chs/7L+cgSrk1AhY+EFBT/z+2VsADBjC3VDTDpy/aiecw6CpiYqHS2KhKuHD?=
 =?us-ascii?Q?cKYqWoK1eIInHDGshalVRFgrGAJwpD1xy9xouxm6zKsNUgGZlF9npRT3+RZr?=
 =?us-ascii?Q?MgH+rCk2pCdlvrNWhaMX0A3EtiyH+qWTE0zpXovGf6QKliGBimzx/EULria6?=
 =?us-ascii?Q?UdFDSKsN+z+VWcNnT60wmcDDOrnPj/vV05gKkMGqFLSWKjC1Z2k62r8DtYex?=
 =?us-ascii?Q?COu+1HnAKH6bVQ0KH5zM8jp0UwhVB3dVngLUENavk3Q3BfGxyRFjsktWBYHl?=
 =?us-ascii?Q?MeWXaxpUWktJyb9qkW1Ze1AP1lEfTIMWF/QQTpBg/vFE+zqKht68++OZKi3r?=
 =?us-ascii?Q?0CVRDiCINP4lZ+pecHOPDbs/icZmOVXQBnjfofTcEkFdb+Bom28bo9i7asLX?=
 =?us-ascii?Q?aCoZ9pavlJ2jh55gQNXnqre/c1j3YN/tNgTBA2aPQ71vM7QoyuBEcw9eHZpv?=
 =?us-ascii?Q?4chXl7MB8k1Q/qBulb79BO8TeuW/ajHgMCA8oScY+4av0A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QbEGY25kuNdlYTwcT8hTW/5owP9Sup8KP6qn94WyMy1n8gJf8JZXNzx6dcV5?=
 =?us-ascii?Q?yExKDCtcRf3C3eQj6xI+Fde4Vhl63ATcOd+2H4VN+pw5V2QllOZpZ6BsS1av?=
 =?us-ascii?Q?eOtwPnU1uf+rlJQOQ8JJxc8dd2Bkz3+AfLzV6YlCN19r8yhwhoE2dhfamv00?=
 =?us-ascii?Q?uBOJHIfka98U515RpDXXG9MpKj7ZSAf1blX83zrrVNc5Z7Nzs8cKDoPhxUBu?=
 =?us-ascii?Q?7fkzD53RYj05baK+tceoaUrM7xE6lDggspzy/u4+QXtcf+4Hh3dIT39gRv+k?=
 =?us-ascii?Q?ZXmf5U2GCVzPuRId73DoPyD+9oqPcvzKjkTsQrW6ISmQQrcVlBWI2lBnJWQk?=
 =?us-ascii?Q?Zk0rvXDAFjwWjW2xhnuZi01jIyECr9ZP07ThMG08p7BIux+q6m/wfAYRp2LK?=
 =?us-ascii?Q?o5nvHcDfEXbPfv0mjiQkg65ScUxesO3l9g3mEDo5+I4D/ArnGdwN55XZ/+MK?=
 =?us-ascii?Q?G5fYGvX3TBX9MpCyYG/ZO5cEtXs57gLrFHq+2Q9HZPfK95US2r3DjPYy3rcV?=
 =?us-ascii?Q?x64j4Ml5WQXSCpZjA+1hro8WUcJXZ1N0ca8ZxCm0+Rg3Es25Gp+IhZV8ClXR?=
 =?us-ascii?Q?BuXuONGOQSb892zLlVcK6QxqakYUnMR4T4Lmooft6GLycVYT40eUOjviTGsr?=
 =?us-ascii?Q?vunKRM1Z+DbrNSpMkvvBqDmKPmy3up8bXF69ilClj+wg1mMhwFG7ieIugu8g?=
 =?us-ascii?Q?ra6CMR/HO4OEvXOH0GbuZZ2fioJvK7y5aXeu0Bqqzc9uraA+apESSXchmi+k?=
 =?us-ascii?Q?mMr5wsGfOjgnBF++mS8X8ABG7TB5t7Rd8hRJGSSGdPvHL8xO2dbDDzk3kz3N?=
 =?us-ascii?Q?DjGj9Y1vBmph5bGBNjetpf0cW2JZLt3SvwJvfa3MUQ+xY+e/jKLF3vLZ5Kt4?=
 =?us-ascii?Q?6KrYJiUxV+S9aqC0QGYx7BCFTyG1CCf1vEzbA6m3mrkpbBWIolEAGZoTWHsY?=
 =?us-ascii?Q?q9xjH6BSdSdVGOuqDUxTAfFwf/FesHA4XGEhWYfry5KujBXCJ/FvygRB1tNQ?=
 =?us-ascii?Q?7NMMw/KaeU5B05b+TYd94g8cYJCyzCaex2zQpNV+ZtBC7ggkUGECoKL0TYzU?=
 =?us-ascii?Q?K8gb2w1lAceN0NsPy0G76nWGc7H3p1htNX0QVVk3vo/tI68f8h6q6/LR2pkO?=
 =?us-ascii?Q?qWUH5t0QB+swNgah+RWQTNXOSgHLiiGijkE15IHqWFc1RMNjUIC9EWuHKucd?=
 =?us-ascii?Q?ns36PZnb47Hw2iFLXmDXG+XzKgn2VPXS9X1OdShXZxZyk/dsHg84N4kIxWpr?=
 =?us-ascii?Q?LaWYRazy76d4AjpHwX8tJpl4EBg5YtTyyvkIGQeoBLBoHAmxst6ko2zVOuLV?=
 =?us-ascii?Q?Z4LDCgjymxYmx4PzApKELOgzOnDajOOG0SNBolf1SCn4kcTUr0/eUe4uWU2p?=
 =?us-ascii?Q?FD0LiyMrZlREch5DwH1e36mGkXUXjuC3C3nGiIuXHFOefwJ8l5T9QzDDeQA7?=
 =?us-ascii?Q?G4YSVAZFzsTtVhAfo4plF0XMuh19HeGXNpt1i/B2KQM3RbFiml/uNxI0lPSg?=
 =?us-ascii?Q?rYREt3Qx89lKFuTV87EUa7xtqRLnaXE/b00aVtgwzdbPocyOu5kHSr0qzK6/?=
 =?us-ascii?Q?vGKNIftAswhiy/CPg9l00Z++R/DyPOVTrOIndLrR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZSOh9sI+lDBwUkiRK6j1EobNGpcfPwu5BNOno2CMzt39ActRhxDbzLT+T7xYnlRdizB84KF7X2FNyfEHvZvgm0jOcCJGQaFsvherybvatWpYOQL6nKe7AkeM+3ec9tKXzSalHPt8nXo//vbS+fHHGHo4qePWwLJvOnWZtLfBN8Iz/cGO0UDmiJo54NVQUN//DBU2ryyXDs/MsBiY2pKhN4sG9oIPw/5uZDbPSh2UvbEQRy91rzNQXxByPHGj/GV/oicMJC1hd/FT4/QacIUlVwogGQ5KR4QM6MNCddF5fYX9USRYjfju8+zme6GlcU8NyOHbfvx2q9JHYKnFCng23J/MXTmq7xs7MiB/rc5aP77XWusuSO4oYjeGfaRqnJ+omUdwwjzVmorOkiPlX/BWiCyuAF0eTSb3QRcf8R8mGIN/wa0GhWs++o5wYj0AtNqZ4gCgPhJls9vSe/seBIemwVJMr6lpUBu+tPMDBnc3tVJqF7pwNyLyEplEkG/81qH978E+ZyZIbZHPt7vzhAhHBtqByE23c3gZxD0CH/L2InkPbDwHm+Te8AhkAlwvB6rr6rP5R9+DW9fDFRPT0jeWyecnNLP9y5h+PR3vr1MDEQo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b235e092-b773-49b2-2078-08dc993ea2af
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 19:55:47.7785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TgQE3rGTt+DaeHhl51O4vgjYZsoBqD6LtDUxkHhBtdtgvH0Gp381VoTq2iyh+g73QXlDS+sj1wzWF4LaaxcRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_16,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406300158
X-Proofpoint-GUID: eVQINdn1L-M3sUz-GWCIOY_wKrAgWp1w
X-Proofpoint-ORIG-GUID: eVQINdn1L-M3sUz-GWCIOY_wKrAgWp1w

On Sun, Jun 30, 2024 at 03:52:51PM -0400, Jeff Layton wrote:
> On Sun, 2024-06-30 at 15:44 -0400, Mike Snitzer wrote:
> > On Sun, Jun 30, 2024 at 10:49:51AM -0400, Chuck Lever wrote:
> > > On Sat, Jun 29, 2024 at 06:18:42PM -0400, Chuck Lever wrote:
> > > > > +
> > > > > +	/* nfs_fh -> svc_fh */
> > > > > +	if (nfs_fh->size > NFS4_FHSIZE) {
> > > > > +		status = -EINVAL;
> > > > > +		goto out;
> > > > > +	}
> > > > > +	fh_init(&fh, NFS4_FHSIZE);
> > > > > +	fh.fh_handle.fh_size = nfs_fh->size;
> > > > > +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> > > > > +
> > > > > +	if (fmode & FMODE_READ)
> > > > > +		mayflags |= NFSD_MAY_READ;
> > > > > +	if (fmode & FMODE_WRITE)
> > > > > +		mayflags |= NFSD_MAY_WRITE;
> > > > > +
> > > > > +	beres = nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
> > > > > +	if (beres) {
> > > > > +		status = nfs_stat_to_errno(be32_to_cpu(beres));
> > > > > +		goto out_fh_put;
> > > > > +	}
> > > > 
> > > > So I'm wondering whether just calling fh_verify() and then
> > > > nfsd_open_verified() would be simpler and/or good enough here. Is
> > > > there a strong reason to use the file cache for locally opened
> > > > files? Jeff, any thoughts?
> > > 
> > > > Will there be writeback ramifications for
> > > > doing this? Maybe we need a comment here explaining how these files
> > > > are garbage collected (just an fput by the local I/O client, I would
> > > > guess).
> > > 
> > > OK, going back to this: Since right here we immediately call 
> > > 
> > > 	nfsd_file_put(nf);
> > > 
> > > There are no writeback ramifications nor any need to comment about
> > > garbage collection. But this still seems like a lot of (possibly
> > > unnecessary) overhead for simply obtaining a struct file.
> > 
> > Easy enough change, probably best to avoid the filecache but would like
> > to verify with Jeff before switching:
> > 
> > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > index 1d6508aa931e..85ebf63789fb 100644
> > --- a/fs/nfsd/localio.c
> > +++ b/fs/nfsd/localio.c
> > @@ -197,7 +197,6 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
> >         const struct cred *save_cred;
> >         struct svc_rqst *rqstp;
> >         struct svc_fh fh;
> > -       struct nfsd_file *nf;
> >         __be32 beres;
> > 
> >         if (nfs_fh->size > NFS4_FHSIZE)
> > @@ -235,13 +234,12 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
> >         if (fmode & FMODE_WRITE)
> >                 mayflags |= NFSD_MAY_WRITE;
> > 
> > -       beres = nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
> > +       beres = fh_verify(rqstp, &fh, S_IFREG, mayflags);
> >         if (beres) {
> >                 status = nfs_stat_to_errno(be32_to_cpu(beres));
> >                 goto out_fh_put;
> >         }
> > -       *pfilp = get_file(nf->nf_file);
> > -       nfsd_file_put(nf);
> > +       status = nfsd_open_verified(rqstp, &fh, mayflags, pfilp);
> >  out_fh_put:
> >         fh_put(&fh);
> >         nfsd_local_fakerqst_destroy(rqstp);
> > 
> 
> My suggestion would be to _not_ do this. I think you do want to use the
> filecache (mostly for performance reasons).

But look carefully:

 -- we're not calling nfsd_file_acquire_gc() here

 -- we're immediately calling nfsd_file_put() on the returned nf

There's nothing left in the file cache when nfsd_open_local_fh()
returns. Each call here will do a full file open and a full close.


-- 
Chuck Lever

