Return-Path: <linux-nfs+bounces-12382-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D83AD778D
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 18:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83AB2163AE3
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 16:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BCF299937;
	Thu, 12 Jun 2025 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MY8vBr+3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y9Jmx2sK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6457F2206BB;
	Thu, 12 Jun 2025 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744376; cv=fail; b=CTsG1UyHNxUqi3CRuilm3dnaR1Sy7autQCQFrVlJ66+xtT/uKhS+vHz4i+Yx6N+87F7PD73b2EjJRUK01iHE+yHLvOPoqb+ngB+LC6rHkNS+mFie6tPz03s6wCt2S3ZXBfNl2IlT8+KzOrAZOiks7SqwZ3E0+Db79qYD5Ecj0v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744376; c=relaxed/simple;
	bh=jNsw776y6H6e0mbZzd15+bA0udta1dcZPDnZz5IFBCo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WMKv+ZGPynUZVkKDDuM3D01hlIe9a2us2s33tggVbHM7orsk8JxYCtPu54r0Claqy8s8M4kpfiTzLCFyp2ry70jDqIHBldsjdmhvqEtDgqFwBC5ObJLppsxLYJZv4XASFmONgopH5idRyP73Ms7S+6DZlzZeQ6/TqMrI+VpZt+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MY8vBr+3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y9Jmx2sK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CEtdEa024653;
	Thu, 12 Jun 2025 16:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=L5hrjcNTBRXdC93YpOw00W+sxtZhe8g1J4FdXnJHHkk=; b=
	MY8vBr+3MxYUctk37PjsQaVBeqwJNec0Y3LV/IA5nlgTGDdUPqDGIQoWpTlW+zNg
	fdmJLAo4PvNYRUA48HS9gihJo4G8Yn+aYZ5TbkZJCzoBKjSKCSHfjV2BkyWVxlB1
	R/YTxSApX4DgSCNvVvSsBtrdF8ko8pP4cmbRihdiiHXyJO2ts8XC3JM5WxkxjuhG
	ZdQ3niupLNUlKLIEQSINSOmWAkOdwBI7tgrzf14zrNfjkWnJdmx+m5v0rAXB7Hvu
	/KOuvywc8uYxzqItlri09AxEwKSxcxBgJzD5fzRvSTDrULmnzVFWvm0k6TBRAGju
	kW54ZS4OkjN0pz0eay+c5A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474bufa058-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 16:05:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55CF5bSX016733;
	Thu, 12 Jun 2025 16:05:59 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvbt2h5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 16:05:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grKgIFbSCezNHoQEtztEzMC4b9FI+WtTz7mVJdBROBpkqyYUcUdcjQWvTk9JhWSHMh6MAIvtAXe8N6UXc2LO5aG0o13SvtitCMis3HzYJFPnblya48YazYhBhKO1Pk7AD8ek2gzrSdAJxyEZ2XInOuPsxsVzMC3EU2PA/yuLt+F4Q44Hi5Z/ykCu3rhGPIAgHPYvgFKQEczBNkkFDMoE1Seon7RGrcfIby+hTz3zuNfAZH1OsuP9o9jESWsDtxMClq0sxxx7KkZLx8Rz1HhCOwJFUhj7tgOdA2NGappepEueMCY9KinW8YC9HGiuSwW878UxHrblIbs1NMPdps7YTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5hrjcNTBRXdC93YpOw00W+sxtZhe8g1J4FdXnJHHkk=;
 b=ZwjoYZaoMPaImEAJ3XQk/N5Kay38f+TlamI/W6h47+/88ecoC3leOx90alSlmD4WvDLZIljAO0ODE5FdOifQr0MX67RR5c91t0jQHt/FIXsrq30QVfZyIdA5w4nUxxNthajkVrWj4PevKgOHXTPyLwuhHU+8w5f67TFYeWw4l1TUtNMq1kGqdt85NNZWOlKeRzHWuWLuBoAue/VsCd7hqJixC0VPCdek3JF3lFybwUZt43j7FguahcKagGudLAZ7He+togPOLUPU/8uNv+ld/I6mwF9fZWG7YY8Qy7Lw8OD1iGHVx4QbXW2W6NXtYw+jhzDtMUDeLZo4VTpUIz5lug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5hrjcNTBRXdC93YpOw00W+sxtZhe8g1J4FdXnJHHkk=;
 b=y9Jmx2sKXTayzJJykfKA16aMdm4VpmavhOy6EtNUL+YP7VG4oy+0K5XjoIWYTjllyAi3NhWY37BH4M+expoIMQutxTBXe70SDyP94SjkSMa7rxDAfn8KxOsOs4bSwTOmednwEyGq+p7bEoe3ZyAW7mGcX1gz5VYku9oTa51FWJA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH3PPF553978BD2.namprd10.prod.outlook.com (2603:10b6:518:1::7a1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 16:05:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 16:05:55 +0000
Message-ID: <ae18305b-167d-4f27-bc3b-3d2d5f216d85@oracle.com>
Date: Thu, 12 Jun 2025 12:05:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nfsd: use threads array as-is in netlink interface
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20250527-rpc-numa-v1-0-fa1d98e9a900@kernel.org>
 <20250527-rpc-numa-v1-1-fa1d98e9a900@kernel.org>
 <a8d4c4cffe1a35ea831110ce1c7beea649352238.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <a8d4c4cffe1a35ea831110ce1c7beea649352238.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0010.namprd08.prod.outlook.com
 (2603:10b6:610:33::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH3PPF553978BD2:EE_
X-MS-Office365-Filtering-Correlation-Id: db8f8451-165a-480c-8309-08dda9cb033a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?K0lYbnlYUE9lN0FnV09HcTlOakJsUG1UbWVsV3hHSy8wQXduUXZoZkJqNExS?=
 =?utf-8?B?OHozc2o1dXVVV3pOTVFKREF5WkNxSDVDVGhFOFQybzZ4ZFpPbUluNG9VQ2N0?=
 =?utf-8?B?bjZPM2Y1aDNMQ1RENWVnYS8xc0FiclM4d0pMOC9KWmZadXRKQVBuTUhWWFJL?=
 =?utf-8?B?MVJOci9vSElHcEo4OS9kNDdiTHh4emlyK3NPU01KUzFIMUpJYzJjeVo2blJX?=
 =?utf-8?B?VklkZ1JVSjlRaG5XcU1EMjJtaVhEQ1IyR05FOSs2aGpuRWZtQ1JEbEwzZmNC?=
 =?utf-8?B?Ty85aXgrRzVrSzFsTzQwb1NJRjhjbkNmYW13a1M4VksxR0w2aFpvS2JzV1ly?=
 =?utf-8?B?NUgxUS9rYmZRZS84aXN5bEtTUmhnam1USXBnN3QzSVpBb1lQUng2dHd6aTZ6?=
 =?utf-8?B?ZzFtdFFiL0xDazZkU1hURTVnN2lLclB2WS9YSVJVOFFPcXlDU3luODJMdFdM?=
 =?utf-8?B?VVl2aHYzdXlNbThDNGNHa2pMRHVMN0hBMmIxbXhDVVF3eVZ0Tjl5ZDZNZEJs?=
 =?utf-8?B?SnZIQk1qT2tPOGtPU0Q3MGYzY3ZNZkU0c3M4Szk2Y0Eyb2xVdGd6WmNvckU3?=
 =?utf-8?B?bFBhVWJRZ200a1N4QTEyS243anhKRWdWcXlTS2pSNFByelB1b1M0VllKRnhq?=
 =?utf-8?B?bVNYRDVrTy9ZeGkxUWFJYUlmUDVIdjl1VjI5RU9JZjhIUUtnUmFXTFR0anVw?=
 =?utf-8?B?bW9zdDFZbmpkZlovMXM5WWhEQkJlelVXRGpzNW50RW52ODNpREtHL3hHRk9T?=
 =?utf-8?B?V2ppa244Z3VObDhQRWpld1BDeDlGdzlvZ21qa0txZ2wrK1VRYVhrdElmVTZK?=
 =?utf-8?B?VUxpazV5eENVMFE1R3Q0a1NtdVNpbjdTTkl3MkVEdWQyeDkxSDRaeXZwWmxr?=
 =?utf-8?B?cTlMVm9LODV2VE5rUTBjV1FHQkZPbFBmYmNLQnoxaythb1pqdE1jVHB0RWtn?=
 =?utf-8?B?TTJ2SjNkRTNLWkdkWnlUcnByMDNKWVZWcFRlM1ZqejM4WHpyQ3ZMdTNJekRx?=
 =?utf-8?B?L2VEczVhVEI2Z05ubWJXQUk1NlRyUG9FMkRIMVNzMmxlWkhtQkwyMkdSMHB4?=
 =?utf-8?B?OEZ5SzFtc0w2WG5XeW8xU3ZFME0rSElTZ1ljMk9pTUxXSmJoUmVUcWdrMFl6?=
 =?utf-8?B?NGRDSWk4KzQycUZPWWxEVjVlZUxhL0dBNFVBYlZKekVPd3BaamZVajhYdEtv?=
 =?utf-8?B?bUFZV21SNEE0VWczYkh0dFFGT2VaSHYwYVREUFgxVXo2L2tMNExBeGJUMUdH?=
 =?utf-8?B?WnZIVksxcW94YW1WL3JjUW9Ba3JLYzRGbWNYbWRIODRiMkh4UWdxeGkwcGh0?=
 =?utf-8?B?QlVXNmFIUFoyc01tSkJTbkRhSWZaRE9xZVlsRG5lWDlCZUdwaGRXZHdscTFH?=
 =?utf-8?B?WGkvaGhFQVNlRVV2Y2dBWFBWSklYVmh2anNZQmp2QjZnN0RYRUxPSWVhMnEr?=
 =?utf-8?B?blFsZ2JSM0ZEMWVvRWZ3ZlFnU095QWhDcGpQWE5XdzEwT1FvUmQxaG4xWi9h?=
 =?utf-8?B?eDVLYzBWR2crUnZ3WkkzTWJUZjNlMnZ0OGMvRFQxZXBTWmVUMjVpUnhwdTdE?=
 =?utf-8?B?dDZrTVRhd1kvcm5xQkVRK0g1YWpGcHVhdVhEZXM4NmpPdU8zb0dlYUQ1UG1L?=
 =?utf-8?B?RnJjMWZBZ09RaStnMlZrdjIyeFY4ZHFyRkNLUFUyUzkvREZEdTBWWFlXV0Ri?=
 =?utf-8?B?c3c2M2ZESmFDZzhCcTBYVGlaKzJLeTlseUpkWUgwY2RRUm1JTXF0ZFNiMzYv?=
 =?utf-8?B?aTRPQnRIVHRZclE4akxiYU8rNnltNUhtbjJzbHl6aDZCeWwvZmFyWHV6ZWhZ?=
 =?utf-8?B?WHRnbWxnNFVGNXVxdEcvV0F4Qi9veUxSdDlSU3F5ejJJTEpFVElnWU1FL2lC?=
 =?utf-8?B?ejA1YkM3MUZCSkpuUlk2UUJkeSs1ZlVmN1ZnNjZQOEF6VlhpcXNZVjZqL3VC?=
 =?utf-8?B?MGw5UWtqNHo4Wk8wbDdNTFBlRUc2REw0VjB6eStkb1FQRnV4OHdIY3I1K0pI?=
 =?utf-8?B?dU1NMXZYMnRnPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RGMvSjhyd1JqNTlFUnVzYkh5K3dYQVlIL2ZMdkErS051UmZpbFFwbzhDOEpT?=
 =?utf-8?B?NjU1TXZJZEpYdDZNdFVKVkMyM09ZLzRFV1lIY2MwTkU5cStuNHBvNWxGUHkr?=
 =?utf-8?B?OFVVV2RvMEFDMjdNMFl1ckhCWFBGRmNMWFpEMnJ2cDBvSWI0YzRDak94ZUtB?=
 =?utf-8?B?ZFhzUEV4RVNvZldrcDh3c0RCRlBTRENZKzF5MG5mcHBtTWhka3phV09UckpP?=
 =?utf-8?B?Z2JBR2hOMkhnNWFEeU1JOVAvY0NwN2lmZXluZHJwdjlpeXQvcjlwV0hOVzRm?=
 =?utf-8?B?eVNUQXNkQ2doMFVlSHJzekdzeTRXdjJqbjEzNmVQNVlJejIzTGxKbkNRM2Jq?=
 =?utf-8?B?NnJhTFBhNVNZSmFHblp3bEh4OC9XUC9oUFhhalZieXF5ay9nZlNQOFZLVGt3?=
 =?utf-8?B?djhQcytpQW0xUVRyWUFZOWE0U3ZsZDVzWVNvcitwUGF0WXhjRzd4Y0U3M2N3?=
 =?utf-8?B?eFFTR1plTjFzWWFGMlM2enJIM1IydndqTTFXbS9sdHkvZTVuWlkvNzM2UFlN?=
 =?utf-8?B?Rmk1MnFHa25VWVhXbVp1RWc2MHUvSkZBV0RBcmxwMTc5ZmNGTWc2ajZFYnlX?=
 =?utf-8?B?eHZuRkFDOVRkT0t0T0EraGdsczB4MmZFTHNpamNOQi92OXYrbWlhZmxCRWlW?=
 =?utf-8?B?YWVIanl4cFg1enVXTnZQVEJPWnRkVGZmK08xQ1hIU2lOUW1US1JyRFRXZlFT?=
 =?utf-8?B?UHlleTkzdXpVWUg2d3VJMmZHMTdzdWpNbW5FeU1XbUd6L3ovWDBpUG9tSklw?=
 =?utf-8?B?SFM1cVducGdLb2NqQklCcWg5QzR6V1RzTFdyM2FDUEgwOG1MM216bktkS0du?=
 =?utf-8?B?bjBPQ1hPVnY5UTFNeGNLR0pvK04wcEVDYUZma2ZIMjk5OGtRUjFNa3FUOVVy?=
 =?utf-8?B?bmpUS1I1MjBDdXdvUkI4SDMvSXIzWlNTaDlGeGNkVFB2QkVxTzdtV0R1eHNa?=
 =?utf-8?B?SnBocHExVVFvWHFuYzBKQUlqZW5PMXVNSEJqaSt5MDJsUkFxb0NuNFBlSzNH?=
 =?utf-8?B?UHM5TG9xeXB0VDg4dk1jNk1UMWNDdXlYTmtwRTVlbmlER2p4WjFyRFhTTndV?=
 =?utf-8?B?eWEzSnFEVUhtSE5jeCtId3pqNXp5cjFNWFZPOXFLQitGdllrL21XeEx4eVhO?=
 =?utf-8?B?WGgwS044ZjZuY1pJd2pQRkI1bXEwOGsvWWVOT29hN2hnU1JnRDExTy9Ob0Js?=
 =?utf-8?B?M1lDTC9QeDY2YjFFbnlDUEo4dTBrOHVHTWZaQmZKTGwvRmxQNkduaUgzSVRU?=
 =?utf-8?B?dURydWgrbGVmeXBoNHRrTDFIQVM3MW5PSTlmeEZkYnRFbThtczBBTFFOVThw?=
 =?utf-8?B?NGZBZkphSzFPcUNwUGZZZnhybktWMVQxN1NTWTZ6bUdvRyttTjAwc1V1TWxG?=
 =?utf-8?B?RytFQVlXWXpMSWhvSktJNldwWmVBeHBzZDRhR1pjV2lIRHNRemlOMVJnK1U2?=
 =?utf-8?B?YjBnOE9mbXYwRXRsQS9Ba2VqNS9pcVllVUZ6azZDWFhKRXlLQllhRkEvb0l0?=
 =?utf-8?B?dlczaEhmRDVSV0FPSzIzbmh5NXRDWkxZL2FQOXp6amlaRlFZMm82L2VWVTd1?=
 =?utf-8?B?RnBLRlU0cDZiOG9hdEFvR2NKaVF2MnNPbTNrWlduVmw2OGVVem5JSDRyaThk?=
 =?utf-8?B?dlZnN25UdHl3Y1g5WTd6SHllemYybTVVeFl1UDZzV2xHdW00NFJ2MllXeWpM?=
 =?utf-8?B?R2tjSGxDVlU0ZGtJYWhmU0RDQmZ5R2tXd2RyeFV1UHJSbDgxNkY2anNOSGdB?=
 =?utf-8?B?d2lJNm5LMTk3Q3RNdTEwMko2SU9laGRmU3pNZmxOWVpWZGRKUFZERkl6ZTlV?=
 =?utf-8?B?eGlzM1FDU1o5aVFMRjAxeUV2YWU5NXE0S0YxaVVzck9vTWlkcmp5b3VML1NR?=
 =?utf-8?B?RVRMajlDUzRaK1VnY0F6Y005MVJkY2lzTEpYVm5jQXFnQTRHb2MxdVNJNmRw?=
 =?utf-8?B?bmNJZGtYUHcyWEYvZjZyS3Nab3lXZTFIcnRlTWdSVmdsSVJOWDBIVTJJeFN2?=
 =?utf-8?B?NG5qYnovVm1Tb1FLaTRrQmVldUlUc01qOElrd0VuVzJFUkhhSHlKdEtyY1pi?=
 =?utf-8?B?MXY4OGtuUHdIT0k3L285UGYzSFViam43bklpMkEyTCt2L1NCaWVRSHR5V3hY?=
 =?utf-8?B?aVlaOS9oQjdqVVVMVkJma0RIdXBxVm9EU2Q1S2JsV3cxR2VreHJYZ3B4Zk5y?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IRqJr8Pp92pXNBiYOhuHz0EQAZhkbOfM7Iz3HoGHOi6e2RLPdj0H/Nmgn8ridJSJBpCKs3JgUOkakmTvGvdN4ocPXHVcOF8nDEjo4aMkFWCin2ik4TV75hC9PyimgTZFH+La3vnPoX/F6WjUa3NN62kmMyB8H0l082GiuAEImILz9kGOYuSoiis0BQE3LgG9AtgGTkaWVi/DkdVnCFsOM6E1VR2xVLIrcD6kC8wC5LgDbKasGcHegpjCk3/2okGKPJ1fFXX62vLBuX8KfLmfTrpYSmhelwjHPWhpuYRy3Sgonamsdh1T0U4CR58We9BgE9LZQw0wYfIzDrWquSK0/qqCZgY/YyGQExrdRyUDAQgFMgZ6EWEBwuJzG2SHO9cWjc7QChze17MKAaPc3QqoAT0pf1QkcQEpUIG0bQY5NSgWO31H6waY5ISJxm/cHBqypDJh8Wul17B5k5+LP/VpMwckMdW2QXqhlwueXloFi3hla011Zg12n3oqb0bNbK1oWrR3WiLMYrG/Une778x+xBKI6MsTesEhpH+vHCa5bK/ucF7ZPVrkIpRMcunDyxYtiHX7D3Et/MPQ7VWvSK3Joy7xdN/7gb4DJnoumAuYo0A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8f8451-165a-480c-8309-08dda9cb033a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 16:05:55.5254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWNlTA4ag0rLM9ttfn+hUpa8iAepdCV2i4QG0dErMhrGcpMPCpiq2yAMM5d5DqcxzkfVsAjLa8ij01ZFi/iJfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF553978BD2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_09,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506120123
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=684afae7 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Bh6Hd10N0vOKljiG1-cA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-GUID: ZMVtv2XqdPTSEIzLAruwy7U5CiWAHSnS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEyMyBTYWx0ZWRfX6iY+OTE5B46X sWcK5nmCiXCj9+cD+Ov3waSFH9bO6CCOBPvfZAqGnEMgLm+SmvXWxV0sl1kkDAIxXsWfgWeAmpU 6rJh1yhZM5V5MvzJkv8EY3QwBLUw62zIPJVKMBPa8Rq3vVtR0muHdY4fKL+cFQF/IUNRLkkvXwa
 9jp4yQNCX4p9jCh4H1Ancfb2CH8D65B+TFwa1a5yDXBr5TJPt8l5DXI7JNeYeZ0aRue0dvZ/AKz GgZITH+5Gyb6KhMSMjzu85Tl3mYmG1Jre7pAWHc0yCHrKacmpBtp3uuzp6j8KPIGx4JA/1rjITt 85k3+xQEsFljBtwA7eYatYhllNZ5DJacWi3avpf/mG7nEnvHGYgDghwe6Q5yj4IF2hiB7CJVFUe
 b0aT1wqYRA8OLMXRZhuybVEZE/bjU1IHwP3/7K/AvsWl4ZJ0CcvPl+Sl2+O/Jke5a6eMIQSA
X-Proofpoint-ORIG-GUID: ZMVtv2XqdPTSEIzLAruwy7U5CiWAHSnS

On 6/12/25 11:57 AM, Jeff Layton wrote:
> On Tue, 2025-05-27 at 20:12 -0400, Jeff Layton wrote:
>> The old nfsdfs interface for starting a server with multiple pools
>> handles the special case of a single entry array passed down from
>> userland by distributing the threads over every NUMA node.
>>
>> The netlink control interface however constructs an array of length
>> nfsd_nrpools() and fills any unprovided slots with 0's. This behavior
>> defeats the special casing that the old interface relies on.
>>
>> Change nfsd_nl_threads_set_doit() to pass down the array from userland
>> as-is.
>>
>> Fixes: 7f5c330b2620 ("nfsd: allow passing in array of thread counts via netlink")
>> Reported-by: Mike Snitzer <snitzer@kernel.org>
>> Closes: https://lore.kernel.org/linux-nfs/aDC-ftnzhJAlwqwh@kernel.org/
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>>  fs/nfsd/nfsctl.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>> index ac265d6fde35df4e02b955050f5b0ef22e6e519c..22101e08c3e80350668e94c395058bc228b08e64 100644
>> --- a/fs/nfsd/nfsctl.c
>> +++ b/fs/nfsd/nfsctl.c
>> @@ -1611,7 +1611,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>>   */
>>  int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
>>  {
>> -	int *nthreads, count = 0, nrpools, i, ret = -EOPNOTSUPP, rem;
>> +	int *nthreads, nrpools = 0, i, ret = -EOPNOTSUPP, rem;
>>  	struct net *net = genl_info_net(info);
>>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>  	const struct nlattr *attr;
>> @@ -1623,12 +1623,11 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
>>  	/* count number of SERVER_THREADS values */
>>  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
>>  		if (nla_type(attr) == NFSD_A_SERVER_THREADS)
>> -			count++;
>> +			nrpools++;
>>  	}
>>  
>>  	mutex_lock(&nfsd_mutex);
>>  
>> -	nrpools = max(count, nfsd_nrpools(net));
>>  	nthreads = kcalloc(nrpools, sizeof(int), GFP_KERNEL);
>>  	if (!nthreads) {
>>  		ret = -ENOMEM;
> 
> I noticed that this didn't go in to the recent merge window.
> 
> This patch fixes a rather nasty regression when you try to start the
> server on a NUMA-capable box.

The NFSD netlink interface is not broadly used yet, is it?

Since this one came in late during the 6.16 dev cycle and the Fixes: tag
references a commit that is already in released kernels, I put in the
"next merge window" pile. On it's own it doesn't look urgent to me.


> It all looks like it works, but some RPCs
> get silently dropped on the floor (if they happen to be received into a
> node with no threads). It took me a while to track down the problem
> after Mike reported it.
> 
> Can we go ahead and pull this in and send it to stable?
> 
> Also, did this patch fix the problem for you, Mike?

I'll wait for confirmation.

-- 
Chuck Lever

