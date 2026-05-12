Return-Path: <linux-nfs+bounces-21579-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGBbEAd+A2pV6QEAu9opvQ
	(envelope-from <linux-nfs+bounces-21579-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 21:22:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A767D528941
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 21:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D19830AE2F7
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 19:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967CC20ED;
	Tue, 12 May 2026 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KCRj1dUY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kpdBb0Jk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE6368D6F;
	Tue, 12 May 2026 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613679; cv=fail; b=Fv+m6Y04rXbuaWFXaDw/2VNJM9Ac0yBu6P4TnShZXQD4U20hmu+jdkj1tbl7Sl6PlhCgWLT5p5/Vdu/Xexe6D4HN+RbUHMKuQc/+RI6GHYD8guMamghGKaUD4nrwFV1MYmQvUCm/+wV81tRSpZBScekWS+SSrwSZJmPMhat9rtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613679; c=relaxed/simple;
	bh=GETf9qRuSIon1rI/arUvjopqTmmBxHvhkcaKH4/D9Y8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nXF4fRuCdwhg2j0ohflZDFaGNMFIrtMa95R8vo5NWEvHyZ5cAEYj6hiaK/kmaE4Fcw6nJIpB7dSasmZl4yCkzd+xyJswPMSOaMeekCNT3qX538ZgZxVYbS3AA4iFG6osC2tatzLoyrIPnexAy35TZSduly46NT+QEmiw+nkuUGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KCRj1dUY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kpdBb0Jk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CGffGi4095741;
	Tue, 12 May 2026 19:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1PbNS6qtUaJPBzQyZFSauGaUvfNV1ThunkfKyR/ubuQ=; b=
	KCRj1dUYqyau+Kx4ic2nGdjUNwoTP0SZxwEQn8bjy21Got9r/hOR46VGvaFrA/uu
	VBOuJhN1wOggZzB3eLOiq/uOESyRFW+fyswAC6rTpcT4r6CPSa3h8aKua81QmSLb
	+OroCtPaRUAQIj4SVfbKB6RFh+PPE7jgd5T9wwSQ7Hpk+eT0frOq19YsUgBNElFh
	2I/80S2dU2tJZnXj+bjB8stLeDeZ0FL+QEKP3n4l8gA6gk+kzMUiIGRrZk+/la8Q
	GObf7kdScnCEMgDu/lUVrn0fmYloI+hPbyXBOUis8IUm0yfOcLme+3aGH5ng67gG
	Ju9fbuV8eErNbMTtL8FCJw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e3nv89vr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 19:21:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64CJK75U017981;
	Tue, 12 May 2026 19:21:13 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e3ne9w6cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 19:21:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wm05yUyAt0qk7OHTl7HFv3DT9V4WMBoUfluisBizhMVInlt+OHvv6hoCF0PAa4Wg6AeL1zMEuwn7DbmOB14VIB2JrI+F4/RafLXUfhBKaLhq3A8Smg5pB0Teb2FW2McQaWc6Fl4bOmobhcqOwvkDav8zmfkPXort9JfXfiM96B2hmH+HyJS08Cev2LOzpt3V6AS+S+9vSfrJaI0L67AmHIYkJCI9/5CazFfYuJl7W8FNkJ2S3LMTzfNQwGzKs/brR8Lpkygzavh2yYaxz2D9Db2H5PXzW0fZ3VMGhkj+Uony+ei7VJdytrTB1HDo/Imxw5sri/ibGkLkKcAsUTT/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PbNS6qtUaJPBzQyZFSauGaUvfNV1ThunkfKyR/ubuQ=;
 b=K5cmn9d18e0D61D/zG6W/knGGyqbFBxXengunHDyZ9rW0R6T8YQr71c1WnkoYAnSVU+b0cVnfBI+0um5AVzS9wng121Q/oslkwW8CEqWd27rTvHUQEqtyMo93p48dqutVIScSTI6zR7zoB48GFqMZB/9TawHQPMStZgZcXwuiDQjPXd8FA3ZnhznuR0dqAcHqvuJR/md2sH28l57E0zwsmBl0B4E/Yz6FhAXdfGnH9+UhM8L6m1bWlQBTRAz0xdm8lyCzskx6b5Gu9qv8cSg+5dClyQkLpR8P2wlleZZfyt9rUZfGWMaY1VgCPQEJU/M4fnA+j7fG7V6lyxmwZU9gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PbNS6qtUaJPBzQyZFSauGaUvfNV1ThunkfKyR/ubuQ=;
 b=kpdBb0JkIy1GjriOnzJBIvs/QX0uR1iyKShTZHu+ceVMKfyGyCT8DsypFDB5pEy886PhvjmNwLftwvIvLIM6kv7LfwJMc/L6ZzsipnNXMmKf0ND1dkmOVQ2qdYS/IPyehho63q2zf0gQrEd7DjRUFyePccP7Of2FpHV9cWS2rfg=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by MN2PR10MB4256.namprd10.prod.outlook.com (2603:10b6:208:1db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 19:21:09 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 19:21:08 +0000
Message-ID: <bee02ca2-ca85-4098-b025-21532d1317e9@oracle.com>
Date: Tue, 12 May 2026 12:21:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260512172238.2495085-1-dai.ngo@oracle.com>
 <20260512173402.GO9555@frogsfrogsfrogs>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20260512173402.GO9555@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:332::15) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|MN2PR10MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ff0c02-1b7f-4473-c21d-08deb05b9edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	GFgA77QqyY3VyzorIWt2OoJo2nwXGwUkxDJrBVSQLdCx7CEzWgokNVWhKApjDYF5Eaw31wfdO8wsyMEFozX5yc2D4p1sTW1nvrHYhs7zGfYxQiOGky6wdIW/cbRzi+jUU+qOkJLPVT4mTSyLrkid1ie8jJG3w0wqXIQkTU/5wcM3NNpgv90maHyGWStfqvN8jIPBKDKHnEyeura7dDrNOe98f5uToMoajdQ6uk26d6Y8KsT8yhfejDZ0FFept/rSvUJvD/RnlOEIqDna+DvGe1xy67sw5SK2jTTbr2NgzEsHi8oBkQTCtRgJ1Rd4AfYrBGZNWgzHCYnVX3czOtO9F18vCzrGN3YSkGM+SKGdNCQODOpR9L89Uy4mO9IsHMjTOS1ud/4T+iGDT+D3cGoA3u7+oy3LUlYHP2qyppQBdAsek+WMsovLSPGNl/ySTZw1InHifnIpH3QMC9zrc4poRRyd4wqsYJchixl0KYopALVjnIgzrueK2Ep7dnCAWaCmrQ5nv7eH/nZDuXOZm5Y5oUUWh6u9ZOnGuy5jTmX6opFA6Yd2lPEeJGOgdcrt6RhB9hJjhtNhjJsSrjNQF+vwvUwrRNNfrGCIVRMiXWDVriOnGDaUkIiAH/MR6Sa3jt4m3Qj0K5s/by4/dhAjFnW5uehgHMl04FXOW0cdRfP3PxvJHivUSNiFNDWUy79xY87r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHp4YWE5VjNLcVhVeGVvY0FPZ0M3eC9zbldReGZXbGZFeW9UMkZUQUxKZmVC?=
 =?utf-8?B?Z0hCbU1ZR0JaaGFKZGJBVGd0WVpOd2p3UXc3RE5pc2lnalp3dmtSODljL2po?=
 =?utf-8?B?ZTFPdmhRT2JJWVF3cHNpZVdtK3laeHJQcFh4emlwaVVxY0Vzb2piaGozZ2s5?=
 =?utf-8?B?RHZWazI0dk4xWldzdXdxNWs3YWFjMHdId3Iza21iUytGcHdHUTVKU2NsSWhU?=
 =?utf-8?B?MXlGT0FPNUoxY0ttdDlpNEtGcldYZU5XZ216a2RsTmFjb3JIZTdiSG1yeWRq?=
 =?utf-8?B?akJiQWYxZnJqNXp0NEFTU08zT3JQTXc1dGsxY0F1STU4V0tnelV6ZFh6Rmlm?=
 =?utf-8?B?MkpoeEJrNFVpdTFtcWZ3SStLZUwzOE9TV2wxcDUvSEJWOXRqNTZRTGkzMzZD?=
 =?utf-8?B?OWNTekhFdWRZQmdxa2x2TWc5SnZMQ1pRdWw1a0kwVkszTUZoMUQ4R3d6QmY2?=
 =?utf-8?B?bUp3b0xjOWUyNmFpNFdwS2RFYnArcy9lS29XaXUrcTdRd3NWUHVRbzV1MFVG?=
 =?utf-8?B?Nzl4OHlxSERQcGVUUkJQZk16c1ZMaUs2TXZ2Q2ZVOStkS002QzNXN05OeXBk?=
 =?utf-8?B?SzIvMEx1UUpGYmMrNjl0K251OEtYaStzbkJjdHJ3R0tHczJ1dGZGVlNzbjJL?=
 =?utf-8?B?bmNjRGZNeUJFVTg3T1Bnd1daZ3ZuckdGbTRDTE52M0F5NlRLNjZKRmpJcWh6?=
 =?utf-8?B?RmVYNEg4Q0t3eDFEWUZVQnNsUjJXOXh1NmljelRsT2JwUHBCVndDQnd2Ymts?=
 =?utf-8?B?cXNwSjJaZWhmVTc4VmtJQ213VmRuTnFkVXNCaGpyVlhoRExCb0x1UE14UFhZ?=
 =?utf-8?B?cWw3dXVERE1hNHhDMm9VK3VzWE43bUVQdU9ocUlldDQ0VUFCUHBieEI1cmNs?=
 =?utf-8?B?NE5yMzB5T2l3OHRjVHlRWDZyYnJVeGs0U0VYcXVKbGxWUU9vR29HLzJOTDZG?=
 =?utf-8?B?bHVoU0FXQ2MxVXdzaTlJamdJMDJ0UnpqSjhmM2tpN2c1TUZERklGTUdXYVZn?=
 =?utf-8?B?bnY5a3Ixd09zb1drL1RaWUdaTTlSdHlOU01RUW1yZUU4bVU5SzdXY0FqV2d0?=
 =?utf-8?B?MXB5K1kwY01oQjdKTzRBZVZ1bUNPRXM1KzZ0cGt1M3k5L29EL3hiUzFBaHR1?=
 =?utf-8?B?N1A0R2NZRkt3M3hYQTBIQmY2dGROYi9iSlU3LzRLcENoUVZVODRWb3d1ZFRi?=
 =?utf-8?B?bURtSHU1NGRCMUNHU0ZQaWNVWnF6cWQ2enJVMHhIQzYybUNQbWY2aGJ1WFhK?=
 =?utf-8?B?bmRwZHd5ZmtoRHZVam91Mnc5SWtnWkNqUi81aEdTQi9RS0VkWFZhdWRpWExt?=
 =?utf-8?B?b3dPZmgyUHZ4Y29odVJYSTZEbVNLTXE3RjRGSW55VXZyUlBxbW91Y3lrYTIy?=
 =?utf-8?B?NGJ2eURTaERRTThIZmpRejdwMXVNWHNWdHQ5YnVJTVNpSm9jUk9KMjVhQklq?=
 =?utf-8?B?M05rdUpUdHY2Q1ZMKzB6TW5wQ1VCWnBYNFRpS0xJRUtzNUZEWW9ZaXFpcy9a?=
 =?utf-8?B?eFV0U1lTTTg3R2Jjc0lNek9mbC9McUNjYnVEOU1EMVptUGhtQlBScEJjNDM2?=
 =?utf-8?B?NDhPS2FRY3lPaE8yZ2FibFhqYkNNTFBodDVpTmJ1WU5PWTFSdm0xVDV4aU1J?=
 =?utf-8?B?Wi94RGhUR043dFR3Z0tBOVVqVTExVDRMQ0wraW5sMzMxVUFOY1JKWi9CK1BC?=
 =?utf-8?B?dldqQ25WUytWMEUwQ1pmSWh6d2Y0TFAvNlZEcDkxSlIzNThCZjNXZ2NmWUFo?=
 =?utf-8?B?ME8vNVZIT2x1NFJ3SjhzRVBiUlJtU0FGTlZpbHkvNTB6RlNKYUNVTHFYZWZK?=
 =?utf-8?B?eUsxS25HSEIyOW5GNTZiWEVYVlRMS1VwcWZTTmhudUhOMWRQcGxiOHp2Smx0?=
 =?utf-8?B?dDFVZXdKRWpFNFgyQXhsdTJNcGhNZlJOb0NSbmVWZVV1bTU4UjZ0MTRXdnRa?=
 =?utf-8?B?WWt0TnR3S3czcVJEeWVHUVFhRUplN1M1VE9MNjl5TTk2MnRqd1BZWGkxY2lU?=
 =?utf-8?B?NXc4ekowMUZUZ2RTeGdjUm02RllPNmZxbGpKM001Q0w0Yjg1VjhoZlhLNHdr?=
 =?utf-8?B?Qlp4TjJXT0VOMkxMdDVKamhyZkkzWUplVmpYS2VxVGo1S1R6ejdFN0hadDh4?=
 =?utf-8?B?cWtXZzNTZjhRcXJOemZ2eDB1dms4bGlyN3Vxb3BoU1JWdnIvV094MzlPcDIy?=
 =?utf-8?B?djJQdEpScGtUVy81KzZiVkRkVktJRElXRzlDNkhvYzMydW9jYTg1K0RLWG0z?=
 =?utf-8?B?bXhFbmdPamtWUlVmcEU3VXMvcWdpWndkVm05L2JuQXB4dGxkbnFKdGlCb1Jj?=
 =?utf-8?B?dThqUXhiT1dGakpRN1hRaHBjV0FtRlNCYWR2bFE3WUlyYW96YlpIdz09?=
X-Exchange-RoutingPolicyChecked:
	Q8M02e+QF45oSntuK8DYxb61nOxqc3uwwGou823SC16cxuvW1J+henSIXQmB61qRp/J4HTRSzKZayMb1mYaQoCnY4FckLIi89IqvMjfk/a6w9EjCUjD+nCd3WLUE4fEj6Mrj1ZxLuC8TRebP6qkHTqnKZB/5do6jeU83o608p/nMpJmy5yNHVYQTzsj6MKn/o7wtcpL91VMZULgRwkDQ50n4fkDoygNpb4qQjWbZuPV4SbVWenIvS73AaKQ014FYwlofk4Le+M1c5jr1vtOkKuJF4P9Ec3TU3G15lnyBzw2YyDBOYPQotbfQbSnudJr0gE8kqzxuSddUXRjmkrnd1Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W/PKYr7RA+mrLZ27ohNjX7s87TkgCcbJmT61KLPS6BKIakbB4VuM3Ed5c01HVTcVXeMsdWbeTqyq1RaSdC6otc6dDtEfhYnepxBT6lzoPBSNhMM9EDnlBXi5FIgeF1I9P8AAIGA2q0aPGGcdqVKtkcmdTad9pcnwrVmRa6vMjMz/zEakbHCVCwIsj34zaTViOqilTTr5qk8CH70dAiimA7u3KLDl7+QQ3CgJZZ5vGhwXrgln9pC9drCALPsVjAHxhyHqufBdOSfT2HB12sFc0u/aF4GybYz8YXeoVIw990CJrqHaaJqS1Ie/aqVQyhp9Age4SRN0ZUf0qPOjq9YjOzc0YnXD0Kwn/0Ajt+7Ek7ZWL0bPj3kBt64qLkt/2frDGHmy/ysCMkXNneNBiK2C2cOY6JogaXSYlOvfUsTOeGAZ/95lMf7NdYsfALDrDjSoz7yqnU/VE9cexoRDP/En7/Xn6mPhqv9JlDeFjf8sNkamV/7hGWvoODRapzK85LxB5n4Y+m4nNuZH+3UKuvpMRP0HWxx5/0YTm3hhObcNz+GxfL5jXWgoawPJxsyq82Q8anvbNHUNreAu/ofPiwbx4jONv5n+w6dsvNdGBLKUbqw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ff0c02-1b7f-4473-c21d-08deb05b9edd
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 19:21:08.8745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z19Xzr8jAhnZBIQUcab9SaWVFOt1MjsFlIivd14qZxXxp+Wl6C1FhxggpKOrq2EUaf+lHj8GEL0HWr5uUfcDTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4256
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605050000 definitions=main-2605120200
X-Proofpoint-ORIG-GUID: gs9dwyAVmSzX2KHotqo4czv2lcSGALXt
X-Authority-Analysis: v=2.4 cv=bYVbluPB c=1 sm=1 tr=0 ts=6a037daa cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=grOK7JOvU2emLIpHQV8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gs9dwyAVmSzX2KHotqo4czv2lcSGALXt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIwMCBTYWx0ZWRfX/eEAOFcOw1yx
 t9LKtnPq4yDc5C+Y6xewYQ3xNCPS3NyE6G9QQU8MLXwwXjnyqWYUW6xeBTE5bj5Js/Ze61LSj7h
 xHqnqBgrWfgwm99zenFDmUrhfXmf3evdU94/1bgLq248ZvAz0ZwD2BdG2o7DA9G22jQKyBemrw3
 QJ+lTZwU67yFo/Uz3f40nnVvnSlnpW0S9NI3NOQRw3BVaHMgiLEccSA0Nrr9qNh53GKhUfLYbOB
 mHSLWswljA7YvzAEBvzzLpCd/pPV4cpxlWOT3/dzT1lFrpgw/PEJf9hQojO13Y4edpWIcR0qC1Y
 ZQ6b/heJJUXD/4FNAgfUJOvr2kLo2L6QEBwdewNWa+g/pKGH34J6UfUTxuZCMhLhCko5oXXpN18
 xR+EYBheh7bf/wtvoY8l/Dqz1PVNfQp1Q71KsjngyQAW2fge86AwwjCQzpa1EJACdO9Lkp2nJYY
 7+Zg3t693Lr0iWWAixA==
X-Rspamd-Queue-Id: A767D528941
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21579-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Thank you for your review!

On 5/12/26 10:34 AM, Darrick J. Wong wrote:
> On Tue, May 12, 2026 at 10:21:53AM -0700, Dai Ngo wrote:
>> xfs_fs_map_blocks() currently passes XFS_BMAPI_ENTIRE to xfs_bmapi_read(),
>> which causes the bmap code to expand the mapping to cover the entire
>> extent rather than the requested range.
> Nitpicking: _ENTIRE causes bmapi_read to return the whole extent instead
> of trimming it down to the requested range.

Fix in v2.

>
>> A single LAYOUTGET request from the client can cause the server to
>> issue multiple calls to xfs_fs_map_blocks() for different offsets
>> within the same extent. Because the use of XFS_BMAPI_ENTIRE flag,
>> these calls can produce overlapping mappings.
>>
>> As a result, the LAYOUTGET reply sent to the NFS client may contain
>> overlapping extents. This creates ambiguity in extent selection for a
>> given file range, which can lead to incorrect device selection,
>> inconsistent handling of datastate, and ultimately data corruption or
>> protocol violations on the client side.
>>
>> Problem discovered with xfstest generic/075 test using NFSv4.2 mount
>> with SCSI layout.
> Might be helpful to provide an example of the request vs. the
> overlapping layouts.  IIRC the client asks for a layout for the first
> 32 fsblocks of the file.  On the first call to xfs_fs_map_blocks, block
> 0 is a single unwritten mapping, so that gets returned.
>
> Meanwhile, another thread fallocates block 2 and gets lucky in that an
> adjacent block is free, so the first mapping in the file is now 2
> unwritten fsblocks starting at 0.  This can happen because we don't hold
> i_rwsem (or the ILOCK) between calls to ->map_blocks.
>
> Returning to the first thread, it calls xfs_fs_map_blocks again to map
> block 1.  However, the mapping's been changed, so we now return the
> entire 2-fsblock  mapping.

I'm not sure why the file map gets change between the successive calls
from the same thread that services the LAYOUTGET. This test does lots
of ALLOCATE and DEALLOCATE ops prior to the LAYOUTGET.

>    What gets sent to the client is
>
> {.offset = 0, .length = 4096, .addr = X, .dev = Y},
> {.offset = 0, .length = 8192, .addr = X, .dev = Y},

Yes, I will include on-the-wire capture of a LAYOUTGET operation and
reply showing the overlapping extents in v2.

> and the client rejects that as overlapping.  Right?

The Linux client uses a red-black tree to maintain these extents.
Overlapping extents can cause the client to select the wrong extent,
resulting in intermittent test failures.

>
>> Fix this by replacing the XFS_BMAPI_ENTIRE flag with '0' so that
>> xfs_bmapi_read() returns only the mapping for the requested range.
>>
>> Also drop the check for (!error) since it was checked after call to
>> xfs_bmapi_read().
> Cc: <stable@vger.kernel.org> # v6.19

Fix in v2.

>
>> Fixes: cc6c40e09d7b1 ("NFSD/blocklayout: Support multiple extents per LAYOUTGET").
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/xfs/xfs_pnfs.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> - This patch is based on top of the patch:
>>    xfs: fix use of uninitialized imap in xfs_fs_map_blocks error path
>>
>> diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
>> index f7c6dba3d21e..697bf3e4ad7e 100644
>> --- a/fs/xfs/xfs_pnfs.c
>> +++ b/fs/xfs/xfs_pnfs.c
>> @@ -118,7 +118,7 @@ xfs_fs_map_blocks(
>>   	struct xfs_bmbt_irec	imap;
>>   	xfs_fileoff_t		offset_fsb, end_fsb;
>>   	loff_t			limit;
>> -	int			bmapi_flags = XFS_BMAPI_ENTIRE;
>> +	int			bmapi_flags;
> Why not just replace the argument to xfs_bmapi_read with a constant
> zero?

This makes the code easier to understand since there is no comment
describing the meaning of the '0' argument passed toxfs_bmapi_read().

Thanks,
-Dai

>
> --D
>
>>   	int			nimaps = 1;
>>   	uint			lock_flags;
>>   	int			error = 0;
>> @@ -172,6 +172,7 @@ xfs_fs_map_blocks(
>>   	offset_fsb = XFS_B_TO_FSBT(mp, offset);
>>   
>>   	lock_flags = xfs_ilock_data_map_shared(ip);
>> +	bmapi_flags = 0;	/* return map for requested range only */
>>   	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb,
>>   				&imap, &nimaps, bmapi_flags);
>>   	if (error) {
>> @@ -182,8 +183,7 @@ xfs_fs_map_blocks(
>>   
>>   	ASSERT(!nimaps || imap.br_startblock != DELAYSTARTBLOCK);
>>   
>> -	if (!error && write &&
>> -	    (!nimaps || imap.br_startblock == HOLESTARTBLOCK)) {
>> +	if (write && (!nimaps || imap.br_startblock == HOLESTARTBLOCK)) {
>>   		if (offset + length > XFS_ISIZE(ip))
>>   			end_fsb = xfs_iomap_eof_align_last_fsb(ip, end_fsb);
>>   		else if (nimaps && imap.br_startblock == HOLESTARTBLOCK)
>> -- 
>> 2.47.3
>>
>>

