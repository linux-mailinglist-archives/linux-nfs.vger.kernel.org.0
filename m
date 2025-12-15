Return-Path: <linux-nfs+bounces-17110-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A23BCBFD6C
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 21:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 123E13021F99
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 20:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610C0326D43;
	Mon, 15 Dec 2025 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="be1ZB7Ps";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OpNchxrm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DE8327206
	for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765831886; cv=fail; b=E9c5JlpgLN7o5uodAfXKdXeK59onbnQfMqKSaXbSUMFyddUKxSlOatphvqYQTT7AfQJotMolT6+WZaNF+psQtB4zq/tuX6+CKpbCuOnY2eef7ObhCVfS90Nxlzg6vSKptW6vAy0Wyweglz6/wVoThxCPHZPcZUf04MvVOUQ9s64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765831886; c=relaxed/simple;
	bh=Ve4rzbatVQrfIWc2nBvK7HUuq73gaGVf8aKFlSq04O0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TzeUMDgdF1RW11NiMDSKbYRkHFtE2YqidniiB8UevpBJswhc08yV2/1XHx6K4KnhmXS2M/4ExsuVsaY1ZrjsiKW/MEO/gCEowtrRqptAP928xDXuJM5EMZdmmcWHV9vGFyXrF2v9CrTRElhPVW/QtL6Zdf+wAkQZQ8ch7WW9tus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=be1ZB7Ps; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OpNchxrm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCO053058966;
	Mon, 15 Dec 2025 20:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4lJxwlgj0BvqdAA5XzknU12X7l8jHEJfbDsb8uhxOBk=; b=
	be1ZB7PsOqjrJPD4sDMuSm4J2ak0uV/Ibg8TvRF2XybgDO5UHXxkYyVXFWhEd+E7
	5aGqXtmkRd9mF2Fnr8tnfsII/N+4KGR+6uHGCcfvRVKSZBj9QXKKiD65fobt+D8+
	UWGMMICssxG6QxYT8EzZObBVYZOrg1JmVEw/DCytLsa9kW/UqPBU6eQvt6A9bGir
	/IG87RKdwWlt3Ihs42zH+5tTb03NfP3K1ATCEyCMCq49Tq97X/ahA3riggp2kmS4
	U7Uilojv55n4RKlZR2lEXBlYG475gRS/1Etm91l4Mo42B3bmEPhu2YCoCzTvIZFv
	e1iX1FUXpocli5B7IOEWzg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b106casdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 20:50:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFKJRea016412;
	Mon, 15 Dec 2025 20:50:56 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkjxnxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 20:50:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YN9VPULOjaOjQNA5BlJN4qQlg9+oDZie8k40b6/MtEiFHfIHw3hgu8D2DFr/SB8BTWh4Uebd6yso88B0qDS2eytEo0Zm9CgaCYmID3dqS4sNG0ksZSJPEvdohIyn1TJHOlN1tHF7sqYyKruHm5AMgXr+KmEovrv1bEURf11K03I1y5nGE8CFe+A7DOMuhVOy8GYw3ByGCR0jxeeDxlv3/p/xsJI96WBGm4bfjyl17vMZgB0JZBYeAUH0iBTqyQcZm/bCyBoLCVN9T+zh6+ByQkUXsYEbW+f2501LfA0Pir0G4wCyjg7m2tWBQ5QubX+h3jBZmoygfv9+nJa5jGiBfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lJxwlgj0BvqdAA5XzknU12X7l8jHEJfbDsb8uhxOBk=;
 b=KJjW00z1SwEzyGfna1DgLG1OZ41fQPw5jOtts/IJTphMRXeLq5nZMo0DmAQ71aW2e8C9RocRi7cq6WqRM2swqzUSYccMbD+UQBrDossVCmt2wM3BCaKrWMr721M0B1nGWJjfg/Hdp0qn1Rn32McmW1RQRn/z6VSGXN3svyP3M7TxLvtzlAeChe2E2HmUxDcRk6eH7faO/vtr5yrawDLKcrQovvrNRGi0bm3WxPo8Ava6qjTJLxaujkgy6amh0qjuWAHQTZ+sAz+F36il0zs2KFAZPNz62AgEIvvqpJABnI6aTX05l93VX+6xBS2Zd0nV/RSf+e+B/HJvfgidGs5luw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lJxwlgj0BvqdAA5XzknU12X7l8jHEJfbDsb8uhxOBk=;
 b=OpNchxrmyVpRINJzUYrsWXcoEfT8AgQ3QiAPLuGXTX8ZH+tcaqG9iHa3Mo67HliZdTKvyNF3uR6WaGejrghlX7zrQnLXStLZDm30PshCSJl0ibp1ahvZX24o5n8KPuAlEljamSnEtIxdzs+CHEUJdKrofPY1A3TbQYF71OlC5hg=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DM4PR10MB7403.namprd10.prod.outlook.com (2603:10b6:8:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 20:50:53 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 20:50:53 +0000
Message-ID: <2b624d30-ae5b-4ae3-bc16-92e64a9655b4@oracle.com>
Date: Mon, 15 Dec 2025 12:50:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] NFSD: Move clientid_hashval and same_clid to header
 files
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, neilb@ownmail.net,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
References: <20251215181418.2201035-1-dai.ngo@oracle.com>
 <20251215181418.2201035-2-dai.ngo@oracle.com>
 <f8b4865f-044c-4a5c-b4a6-6e1ea9e756e4@app.fastmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <f8b4865f-044c-4a5c-b4a6-6e1ea9e756e4@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0170.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::22) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DM4PR10MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: df359dc9-72ed-43b9-eb4e-08de3c1ba2df
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?U1VuYXJMZUJLcHl4ZHd6d0o1VHBFZm1UeXR0MDhpL0pjWHJ3WEIreGVlWkNN?=
 =?utf-8?B?K1JzejBycUtjcm1IYVV2b2lkbHhTZ3pLcmZ3RFp2NUhib2dTRU9zaDRVdytR?=
 =?utf-8?B?YmoxQUFEZ0s1OXZUck5pd2RFb1l5TGFjck55ME5wY2dNRzlUVjZOcDhpSVIy?=
 =?utf-8?B?aGE5dmZNazNmd3NpZDNDbWxRQTJzcTk5MlEzdFlLOEJGbUlIRHh2cDE2ZVlV?=
 =?utf-8?B?NEJMLzNtM0RwcWw2ekcwajMxYXFsSHNPUEVzOHJlTEt2Y3F4a3ZTUU5OOVY3?=
 =?utf-8?B?djg2KzgvbDJDNzQ3c3VuMDJMMHNsbHd0cm80UUY2ZGRYV3NESnFjK1BYQURS?=
 =?utf-8?B?WHZIYkJGeU5rSC93aldxcEcrNFF2R1Z3ZmNlWDB6U2pSMEphTUl2bHJMU2pB?=
 =?utf-8?B?cmxFVHFiaks5Q1RjUzVxUldPSWZhLzNpTUc5YXU3eC81ZGk1bDRMbzhDNWZr?=
 =?utf-8?B?OHdwcy9uQU0rYlRvN3hwZ0M0dGFYQzJaUTd1UGNDdU0yZVNuellWTFNYeGVP?=
 =?utf-8?B?VHpyVXNMeXBwOTFMOUJMRFJQTUhZaWhVcjVaSHRQSlN6d094YjNESTRpQ1VJ?=
 =?utf-8?B?NGsxQS9MVkdQRS9PdFZxWmMrMmY4ajc2UnZKTW1ncVM1dGp1dURiVDBCck83?=
 =?utf-8?B?MW9pbnFScEFPa2F5cE1XUDU1S2xoaTZBQlhMazlOQk9QdldCbTBaY0cvZFpI?=
 =?utf-8?B?NlZxenlMVHlYS2QrZ2h1cDRENXpCSVpvRFEwMFhCY2RScTZzZ3lHdUZvR3FG?=
 =?utf-8?B?SldFMENpaWoyWWlQRlVyRHpQd2FtL3JPV0pxUk5RcFlna3J0dWgzZ1dQcUFj?=
 =?utf-8?B?L0lLQVd2Ky9WenpKTmY3d3c1VVozTnFmR24xeitBSmdyR1ZheXltYXVMQWNv?=
 =?utf-8?B?VnNHRlFBSjRtU2VWU2ZNc0JaRXN3cXlEcEpDQ3hRNWRRK0JBWW1Sb2JVTXFD?=
 =?utf-8?B?WVNiK0g5Um1FYjFXODlOYlpGODhJZGdUbXdCQndMZjljek1xWFdhdVJsazJw?=
 =?utf-8?B?bXp5K1kraFoyekRQQzV5ejNXMVlhVWxPcFpmN1hOcTdFc0RHYWdoSlhjRUJk?=
 =?utf-8?B?Y3R1WmtEZEtPS3h0amE4YmlqbldTSTN6VEZiN0dhZjN6U1lheXRna1BFbEZL?=
 =?utf-8?B?dWFuRkVISHNkOWFKb0tyNnNpMnNUQTVkTnB0Smh5RkZMdHVwM2NrTTVucWlZ?=
 =?utf-8?B?Y1ZpUEpPbno4UDBWZHFHQUhZSkswT01YdkpvU1RYZ0s3MnFrYWlGY1h1Sjc0?=
 =?utf-8?B?TFpNVmx3ZUZIT0NnZlg0VzFPOGNnS3JTQU14NWplNkFSVTZuazdIdG5SVS9G?=
 =?utf-8?B?ZWNSK285bitPMmduVEYzSFBieHZRYUx1SzB6cUQzRU84VE5OQmdxYm5TdXdI?=
 =?utf-8?B?QlNXZFJyendlbW5VNkNEdDZDSmRNSkZXbUZmdFZTOGlSUVlBVmdOUzNTaCtE?=
 =?utf-8?B?dERWaGx3Y1AxN2NLVlQrekJXYnZpa2tyd0hmZ2lLU0ExL1JKVXpmbnBXNXVV?=
 =?utf-8?B?eStENk85SG5pdlIvRjZhMUxDVnl5Znh0eENyc25kTUVaTUF1eXUwVVRjdXdS?=
 =?utf-8?B?TEdyakRYM1FvTGl1ZFBPcSsvNWxXNmZtbFIyMnNrWEdrTXIrNUhaUUhPalZv?=
 =?utf-8?B?RldTRnJaYXNJV2QyNVZoOC9PQTRVUmtDU0lVWllKVVByRTlCMEJVR1B1M2N6?=
 =?utf-8?B?VDNlREs1WG42N2puRmUvbi9FTHJxVWlrOXNoYjc3dlBidGVUZTh1b2pVTnV3?=
 =?utf-8?B?a3NMcjg0c3A4L0xWUC9KazlzQTNmbFRXZGNCMHorcE9YRUk2cHI0UGRoUVZa?=
 =?utf-8?B?MW5RL0IzeXNkM3ZmUDBzUEp3M3VNa2dNZ2hILzBBSkNmaDlibERGS1RyQURl?=
 =?utf-8?B?b3RNeVFod00yTytXUjU0STZKOE5oaUZLQVgwdUhkcWEwTWhzY1h2alp1NElj?=
 =?utf-8?Q?NwrrkjxcSdeGPBNnUubX0tIkF55Mordt?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WlM2OGtGZjhHSHRXYXRxWTRzOXNSQzVJVlFYNVpjZEVPZlhrK3I4QmdsaHlB?=
 =?utf-8?B?THY5RTdDY3VjcHRnYkI1dGV0dmlqdkZ1Tm12RzRQQ1Nyc083TlZvL2MzSmtj?=
 =?utf-8?B?UGxHNTdlMXVTaDhSYm1QWG1sM2tRV29SOURrdnFLSHRkOTNFQ1NkbHRYOUNx?=
 =?utf-8?B?VldyZUxjYS9VNktGSm5uR2JYRkNBTTZlaWRYU2pNLzlmUjlISE1ndkdYemo3?=
 =?utf-8?B?M3VXTWhhVWdxOTVnVk5aSmpmT0JyVlhoem9qM3FYZmN5NVBsRk9ncjg1dmlI?=
 =?utf-8?B?RktHNHZxQnBEM0tubDVGUHozM0NLQlJESWMzRlc0MEpEOTZJaDBLOVhFUmw3?=
 =?utf-8?B?U2hpUzNvbitJdUExSzZVbFpXazhGUiswaUVNUDcwZ3pIdVdVZVBDbENwa2ZC?=
 =?utf-8?B?c1lXd1JkUU9zQ1RBUk9ncWNHS0JEVllHaG1kYUQ0dlQrMXdBYTNnbE5Hbm1G?=
 =?utf-8?B?NGFQOExFSFA2TDREZVpEdHArU0ptOVJQdCt6MkdwRGdueGRBOGlWbXRRQTR2?=
 =?utf-8?B?ajJldVNyUHo2SUJPaXc4QVFVOGJadEVvZjBGUGkySjhzcVoyRU1LRW81ejdi?=
 =?utf-8?B?bHIxZnZ1SnRvUWxlWTE1S3pUdU9nS2pxYXdUQjMyQ1BKSUxQMU4rTmszRWNS?=
 =?utf-8?B?Rlo5Vm4yd3NKbWVwNUxCU1BnY293aWtCOUJtYkFJSEpUK2ZiVDFVQnBXRHho?=
 =?utf-8?B?dy9IM3V1NlF0UklJZjFxdTdQWmVCMENkSVk1L2cvVndvVDNlR21MSVJNMTVV?=
 =?utf-8?B?ZlE5bEh5V2xvRFNvRTlObWpYbnlyeUJ6MzMyVC9WU0wzeEwvUWQ1cEtlSTE1?=
 =?utf-8?B?YUwyT0tzWGwvcUhtZm50SjBlL2NiUVVhREgybjIvbXRLZXhyWDZNbjF6VXBM?=
 =?utf-8?B?bktubFF3SXlaNjlWMkdXeUwzbUtJS3VEYTBFRDJxdEp1aG9sQkFveDVpM3JR?=
 =?utf-8?B?elpSQ0h2b2ZXaEpHS09ic2FadWh6SjhFYXVuNVJUS3cvVEpCRk5qY0h0V29B?=
 =?utf-8?B?ZzRvNlp1VFBZcUNGSDlzQnB4YldBMmc1TFptYmFpb3RWYndrNzlhMjVVR3dQ?=
 =?utf-8?B?MWJvQUNocUJGaXlIQ0l6K1hmUnYyRjltZkl0RjFkdS9TcWZ4OEpOeUkzbDNK?=
 =?utf-8?B?NVR5SldyYjJBRjhVYXZFUlRrZ0hDOEpXT0x3UHBmbnZFV01LaEVTYU00WU1B?=
 =?utf-8?B?M0FUb2FaYnhNNGU0K1lkN0s4V21tZlZXTmJsTlAxUjhpbDhNUmNpeUxOMmdW?=
 =?utf-8?B?bC9nNldPajNVSGFCeUpZWGtnZktPTytzZHVYZG5XMktYSEhMNFFNSlgyb0lW?=
 =?utf-8?B?bWxXaHUzY0JicGNpVFliVi9qY2NYaCttQklMRUw5OXlKWTFNNUpIVkJmZ2Zm?=
 =?utf-8?B?bElTK0pBL0UxWTg2YWs3enhuNzJ6N3R1L2hQUWE4ZTJ5Q0VGU1p1Ulp0ekdj?=
 =?utf-8?B?SkhuMlZucEJDQVBpRXVaaVRaSW5oTnpjNjI3R0R6V1BaUnE2Tkt6RXlQSWNi?=
 =?utf-8?B?bjNrMEpEdTFaenFaN3RKZThQLzEyUWQ1Mm55b3VMakhHNWtuSXRBWitaYmVw?=
 =?utf-8?B?aGdQRWxxUDVOQU9CaEErZmJIeVI2TVJyemFzcFdDZVorRXFMc080MDdmN29Z?=
 =?utf-8?B?V1Zid0xXaG9QK3BPUUp6Z3QxbmlTWWZKczhudkg3ckdweHl1M01EZlFsSjNW?=
 =?utf-8?B?QnRqeVozVCt0OW9SeFVIdlRmbFpjYklaak83cnFFNlQ5SEJoNnc1N3FJZlcv?=
 =?utf-8?B?engzWWt5eGJveW5nTUViS29QL3ZxVkR1S3lPcmhJWXU3dmwwcmcyUm5obU50?=
 =?utf-8?B?VnVBQnNpQUI5RVRhZ0w3RzV0TXJjcXJiRm5STmdJVTlhcVl2ZFdJbzdRclFr?=
 =?utf-8?B?UkFQZGhOMW5tUFhTUWJkY1pMamZ4OUlHbnZ2cWwwUkxnRWxBVmIwQVBaVG0w?=
 =?utf-8?B?OTNuTWtmTjdUckJsMTJHKy82NTZUVzM0K1pWRDhFNFNGeFE1aVdDQVkxNUE4?=
 =?utf-8?B?cnlDcDlKc1MxcWR1SEloUWtsRnZnQWtzMjBoZWFIbEJWNEJzM2lrVG1iclpD?=
 =?utf-8?B?TGYydFI5NGM4Wk1aNmtINGZmaWc2b1RubkR2R2huM2hZNStrOG5pRDh0SVk1?=
 =?utf-8?Q?Ur+EosO0AANByT1Q342WuGVHa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lLYsKZ8nEaH6q/ZbkF13fwHeDVO8KsqiI0S029JoAZCAuoXDvcjySDdx1jRLY035w+21ROoxH4bLHNQ6Nl+oysKeCfA3zZu0EVyR0F78/CZAFhaVPIXjizAgrpQvvCYS6cnJZKGlSvJfWC8oPNW0jsDR/pszwL+VykejYwP3r02kX8gPUuX4tRtSwaS5sgKnxvqAZoLB73CoKVciVQqsKru8CH94DgRiuABSpQp9SMK/rpsYFuIJkFO3B9Tz0VcuprgDN5RYt/uSUPzznyni7EwVu2Uo0En5zQDDSYbUmXwy5vpCEsPPid1ntJND6NFeIqOcl7PBzhViKiPN7KpdFK0V2WeM+1vgFmYMX8pFXTvaS08z4FQgXJr0nQz/05IxXhOiBLf2R3kq7geXurn92mx7XtphPB24bGRduVbmga6Yz8UaXPTysodUjoLiy0YjZb6Sr2ZgFDbDPg+Xl7Pv2bAkgPPDxIEZOdvj5FTUXoPLIky/ue/fQtzyryk4LbmjPiYqGPVTwIUy2XVyBBJzm4P6/GR7gAoeBWSue2uGRMdAx+7XixGSN+HRsKPftLICvaYtqaiyaRDwq4w/zFNxtm/sHfpPSU32Ai3NS7En9MM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df359dc9-72ed-43b9-eb4e-08de3c1ba2df
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 20:50:52.9641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dp4wb4BWxZC+rolHUgVcRUB3wcRMQbtAZ9Haw7oYFz4B83LNEt9r+HUTJYIMwrBIPDKhI5UVyEY9xbim9Lq1aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7403
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_05,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150179
X-Proofpoint-ORIG-GUID: xidy8vNNoUHVFl8FWetyd2QXvNpQ0ogt
X-Proofpoint-GUID: xidy8vNNoUHVFl8FWetyd2QXvNpQ0ogt
X-Authority-Analysis: v=2.4 cv=et/SD4pX c=1 sm=1 tr=0 ts=694074b1 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=vOBmweaS3fF6bxQiBYUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDE4MCBTYWx0ZWRfXxzupwy4r7Cp5
 eDZBlvlMgpqwbEpetfIIHtXXVcem+XRCPJzEL7rg4pFXtoJ1n8cl4BIZ8KcF6A84m6lc+1Eon26
 RuW1eUJk3araDbXB2+imhLgEiNzSOwmONxbt8vgXWNVhCsCdXErSTwMamLFbC3QZMItOuk7eQ0W
 rhZA+Wr5TpZqGzhTga1ogMYH2bm3Zw0RolLyiOBVzn5d4S2W0C+kNjuO3ovbuK6sE4lcJWhfm0Y
 okWYIyDghqFuOJHUhfiS9LpZ0rmgcAlt1pVvwOep4u4jOSpKGaUk5zzC4QwGiXS1msuvnKgjdeT
 cT4MkO4wPi+3nQjR+ARuRZjWN8h3td/x0MJeBVWZwLpYrxaP1TzPGj0WjNkgHZU76VwmXoKD6IE
 u/m3yS9CuMe/kF0lTCOqwU0R6Q01+M20rbhFB63fVjMiyQDmOGA=


On 12/15/25 10:58 AM, Chuck Lever wrote:
>
> On Mon, Dec 15, 2025, at 1:13 PM, Dai Ngo wrote:
>> As preparation for introducing infrastructure to track SCSI fencing events,
>> relocate the clientid_hashval function from nfs4state.c to nfsd.h and the
>> same_clid function from nfs4state.c to state.h.
>>
>> No functional changes are introduced in this commit—only movement of code
>> to improve accessibility for forthcoming enhancements.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 15 ---------------
>>   fs/nfsd/nfsd.h      |  5 +++++
>>   fs/nfsd/state.h     |  5 +++++
>>   3 files changed, 10 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 35004568d43e..13b4dc89b1e8 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1423,15 +1423,6 @@ static void revoke_delegation(struct nfs4_delegation *dp)
>>   	destroy_unhashed_deleg(dp);
>>   }
>>
>> -/*
>> - * SETCLIENTID state
>> - */
>> -
>> -static unsigned int clientid_hashval(u32 id)
>> -{
>> -	return id & CLIENT_HASH_MASK;
>> -}
>> -
>>   static unsigned int clientstr_hashval(struct xdr_netobj name)
>>   {
>>   	return opaque_hashval(name.data, 8) & CLIENT_HASH_MASK;
>> @@ -2621,12 +2612,6 @@ same_verf(nfs4_verifier *v1, nfs4_verifier *v2)
>>   	return 0 == memcmp(v1->data, v2->data, sizeof(v1->data));
>>   }
>>
>> -static int
>> -same_clid(clientid_t *cl1, clientid_t *cl2)
>> -{
>> -	return (cl1->cl_boot == cl2->cl_boot) && (cl1->cl_id == cl2->cl_id);
>> -}
>> -
>>   static bool groups_equal(struct group_info *g1, struct group_info *g2)
>>   {
>>   	int i;
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 50be785f1d2c..369efe6ed665 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -510,6 +510,11 @@ static inline bool nfsd_attrs_supported(u32
>> minorversion, const u32 *bmval)
>>   	return bmval_is_subset(bmval, nfsd_suppattrs[minorversion]);
>>   }
>>
>> +static inline unsigned int clientid_hashval(u32 id)
>> +{
>> +	return id & CLIENT_HASH_MASK;
>> +}
>> +
> I can't comment on the overall purpose of this series yet, but
> there are one or two mechanical issues that I see already.
>
> Let's not add NFSv4- or pNFS-specific functions to fs/nfsd/nfsd.h.
> Same comment applies to the function declarations this series moves
> in a subsequent patch.

Fix in v2.

>
> Why can't clientid_hashval() go into fs/nfsd/state.h instead?

Fix in v2.

>
> Also, when a function becomes accessible outside of one source
> file (like a "static inline" function or a callback function),
> it needs to get a kdoc comment that documents its API contract.

Fix in v2.

Thanks,
-Dai

>
>
>>   /* These will return ERR_INVAL if specified in GETATTR or READDIR. */
>>   #define NFSD_WRITEONLY_ATTRS_WORD1 \
>>   	(FATTR4_WORD1_TIME_ACCESS_SET   | FATTR4_WORD1_TIME_MODIFY_SET)
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 1e736f402426..b737e8cfe6d5 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -865,6 +865,11 @@ static inline bool try_to_expire_client(struct
>> nfs4_client *clp)
>>   	return clp->cl_state == NFSD4_EXPIRABLE;
>>   }
>>
>> +static inline int same_clid(clientid_t *cl1, clientid_t *cl2)
>> +{
>> +	return (cl1->cl_boot == cl2->cl_boot) && (cl1->cl_id == cl2->cl_id);
>> +}
>> +
>>   extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
>>   		struct dentry *dentry, struct nfs4_delegation **pdp);
>>   #endif   /* NFSD4_STATE_H */
>> -- 
>> 2.47.3

