Return-Path: <linux-nfs+bounces-13765-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC0DB2BE7E
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 12:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C6918830C8
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 10:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8D5319864;
	Tue, 19 Aug 2025 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VOdkUSpZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WteYg5ij"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9331A068
	for <linux-nfs@vger.kernel.org>; Tue, 19 Aug 2025 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598023; cv=fail; b=DU/fJYEnD2A0lpAuxzjeFWbAKv+ZGK7NnXg9WdkIoFfzhnN92vSu+KLwFqCBmtu8DLXsvswr9uuJQYqxHoaHIhy27CKD70UHPpRM5iw0oJPc1cjqmVX9D3Yppfdywu8Yy9uEeqbyJQa29QePAVqlIXaIsfnfZ7uHuBTffIzXhNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598023; c=relaxed/simple;
	bh=q8Xr+R/JyAklClWfQUUGzmO9jIeE9VQ8kThpXQfJIh0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kir8aCb6KbnyaobJyONFsHJW7vn1wKGx6NlMpHzWaY1MQQcS/E7mVnzlOD0dYqCqgwlrlSBTB4EbnKNCubG1hc81pPvhC36VodVrxrORhukH6SMthgsr6IswXi9dGplHZ3YJ+X0hhWCOBAaIyF9WjInAEclKXC1RmdpoA+05vqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VOdkUSpZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WteYg5ij; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J7u3j0015852;
	Tue, 19 Aug 2025 10:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MTuxkJmhFAuvfhG6sWlgzHGQbIPfdInEvUIRlUBluTE=; b=
	VOdkUSpZG6S07TpHJZz6FlIyAyEZwrh658J6UmKDIbgN57wxZuFZ/+TfL28ipDLC
	u7IcTIaf051pUDgYKtbOFkiyluS2rsrBCy0kzNSL2CI/yNaJqvoRfgucNm1+ihWc
	u++nltakwVZa+NGkF3FO9TXdm+gxymqfYizcezQqbNuvseHB17zPpLUA5/lFEqZA
	QwEbxgnIMCed2aqvgpmFTnCo8KY6jqf+00xYRvnJdMGuuLxYn4cn383HVV2dwHL2
	JBKqxIuXjak6HdyvzZmTU+VXaBtefOlKxrGiBXk4hoJzyr/FVLcQnE596swAYzx2
	und4nrUqGU0peR3CnYa5tw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jjhwvwk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 10:06:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57J9xEVC013835;
	Tue, 19 Aug 2025 10:06:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48jgea86v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 10:06:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oK/7Umt24nJ5DqRlnjjjwxyjZYHUfkCDzrUDw1jNu2R2GH+bJa7rs5Shqfd4S+TlQ3BAX/JTuKvXZ/rSEcQrBjtpH6T2b8/xrmgTKwdIv5Z31YykSVUbdJmgRFHkSAweakIeaaZMM/+jNX77fGDUsz70WsojHwQXTqJb2jCu/0D5jxPW/fxDEch7W6srtYFBjXQXTot+47yXY+RBx6/pdz2blwR8lqaJ0nM/L6OMKxYZXbmXdOscCJyCsbBXL504gNYdkpvNCzZYpm/eJzObF1AtK4DuL/yoZPB4352dKTyCZC1SoXfhyJLUtMJGZ9PmwE5WAc9sqJj3EfrnSpVmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTuxkJmhFAuvfhG6sWlgzHGQbIPfdInEvUIRlUBluTE=;
 b=dtnwAml3s7RosytEqZLj+5K2ntIjZz/w8Fq0AADie6R/dqPiPrjkJl+kOYqpGYZlOThXSaDrJjNyvqcK36ChQ6+YeEPdmGAqeM9RKJ/RtpkHwa7daluMsxOWuH5R2fCKJYVn4VQoYv1f1PthjZXkenN1OtG+QkVAlDsJgM/acTpVYJ/jLxBkSnt81+fz46bDSrIWv56163AsTfHTPbARK07M8kfpKtPao3LKTovTEw32v8VHyLH1FJUEbPimqLEpvmtSh69SsCHMrBk/WDltDW+m0kmEfzGjou67twpM3qFCwOiS+vZBCmAjHXMRt3ev8Wu9qL2nui2RQ6c6CEfEHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTuxkJmhFAuvfhG6sWlgzHGQbIPfdInEvUIRlUBluTE=;
 b=WteYg5ijX4zZdSK1qEKS0EMOjnAjtkN1Kbm6puY0CPlYBi/tXgaFmHxR6KCd1gEvtBiDSdRt7Q9feZSybPhj6sXDKTmz7nwgSENELcmbRwvWi7VuSaPoFmK3RZ/lvjJxaI9au6RX1LHUzY80zSOa+ZQkUEMCbSbJrJkVyd8apX8=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by PH8PR10MB6502.namprd10.prod.outlook.com (2603:10b6:510:22a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 10:06:38 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019%4]) with mapi id 15.20.9031.024; Tue, 19 Aug 2025
 10:06:38 +0000
Message-ID: <ec8477cb-6a65-43c9-a756-e1499a1aff9b@oracle.com>
Date: Tue, 19 Aug 2025 15:36:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] SUNRPC: Don't allow waiting for exiting tasks
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: NeilBrown <neil@brown.name>
Cc: Mark Brown <broonie@kernel.org>, trondmy@kernel.org,
        linux-nfs@vger.kernel.org, Aishwarya.TCV@arm.com, ltp@lists.linux.it,
        Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Anna Schumaker <anna@kernel.org>
References: <> <b0393ddb-fca7-48b9-832f-ed17ccec1f19@oracle.com>
 <175369525960.2234665.4427615634985880450@noble.neil.brown.name>
 <d0dbfba5-a323-4227-858e-94ecb364a0ea@oracle.com>
 <7e6108a8-3dba-4a1f-b347-91579a659698@oracle.com>
Content-Language: en-US
In-Reply-To: <7e6108a8-3dba-4a1f-b347-91579a659698@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::16) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|PH8PR10MB6502:EE_
X-MS-Office365-Filtering-Correlation-Id: 62eaf100-297b-4f05-303d-08dddf081609
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YlN0TU5ENzl4TGJtb05pRU4wNm94WmtLMVNBdFdwUVlIdXVIK1JDMTlPZ2dj?=
 =?utf-8?B?K0drNHRPOHAzdDk1MjVLTFIzazFoTGRBcU0zS0tJRkVzSm9uUy9NQUZla1VF?=
 =?utf-8?B?NGFiaElQdVdoT2VOV1dXTjZqQTkraDUzT1dsTzdmc2syeUcvdnJIbVc5Qlht?=
 =?utf-8?B?T3I4dEpqVXJKblZNb0doK3k5YU1SQlJtTDNMR0N6UjZGallVTjUwTVRJYlF0?=
 =?utf-8?B?b3M2U3VpS1dKVVRtWjFTUXRIVkJZQzlQMTB5blo3UkJ5UENTWW5IeHBCdVdz?=
 =?utf-8?B?a2FVTWcydnJMekozeHp0YkR6RXRjaFFKd05lRjUwdk04aDk3L21iZXVPYk56?=
 =?utf-8?B?QWNBOE5uaS9HN2xyMHpPOEZadXovSUlUOWFtamNQQ2ZlRGFxQW9zV2lQUXp1?=
 =?utf-8?B?TzIrYmJpcGd1NmtyVnJJRmt5YS9tOVNaakV0WExpZmtrclBXYmNOUVR2a1pT?=
 =?utf-8?B?OWhxdFoxcFBrQ1cwb09nV05rVUJubEVzRit1SXUzWWZnc3I1SjlDdzhzTFhZ?=
 =?utf-8?B?RFhWbC92UWpCYklOemlTOVlseURDTWh4Qm5BQ0dZS1FzOHlYVWVsL01ZdERs?=
 =?utf-8?B?MHl4cE42TUlsV3dsVmVvV24vYmdwVXF0SWlEYmVEMzdjdUg2UmI3MDlLUmU1?=
 =?utf-8?B?WVhaV2FFeE1XL2o3UStLSzgzMERCNDUzUnhRZDdqVzBBTzBkNFFxajI1aEZt?=
 =?utf-8?B?ejhqWlhnVUZLa3FrV0F6Z2xBRGhQeVVlL2FTTVFaRXZxVjhnMks3NHB6dW91?=
 =?utf-8?B?aGRLZW4yaFZtRE1iQVNiZkI5cTZMZUtBN0VnYTlsTGhSYUtQOVgrRjlkUHZu?=
 =?utf-8?B?SkNrQ3NVNGtBelJPSVB0QTZKVHIyRVFSMUNMY1R1ZHE1ajZBRnVYdGYyeGRs?=
 =?utf-8?B?czRjNWlyaDl6M1B4d2FwQ1A0eHVYRzlTdCs5TlJIcTFtNXVNZ1QyVUpqYU5Q?=
 =?utf-8?B?RnlGMnJ1K3JpNjVzYVBKL25UalhEdmdYcXZVSlgvMm9oWWM5VnpneVk4V0o5?=
 =?utf-8?B?S2dsV2pOa3dQTzdLcTdYTGhxa3l1aEQvd1ZhY0tIUExaWm9HUGQ5WTVPMnBr?=
 =?utf-8?B?NjgzL2xyQ2M3VUh2MjgzVWxSVFhxd01MZ2xiQThzWi9tZXVoc054MFVJNEFQ?=
 =?utf-8?B?ZUlqZVdydDkyejNlWVVncmVUOEFmZ1dtWDFGL1dNaE1SYm45dXoyb3AvcERT?=
 =?utf-8?B?S1dnS0kySHJ2akdUVzV6MmtFMkpoQWhOVER2a1BWQTRnb3E0Y1N0L0N0RWRQ?=
 =?utf-8?B?L1gvTmZYWS9qc01qQmtlMVpPVml2K2Q4cU9EVkZyUFY4STk4OGcrZEFYYW1w?=
 =?utf-8?B?aWRTeFhnYmJ5ZGZMNzU0ekdnUHBKelBCQWhCeG5QdU9VZm1MS01LZkdmSjA5?=
 =?utf-8?B?cmF0MkFEWEw0dW1tblFORTVWRGdQUmdjN0ZQS1UxOHJUY2tTTWtRcDB6VEtK?=
 =?utf-8?B?MDlNR1RxUmhEK0xIaWpOSWZ3Q0dJWW9Nayt3V0x6dHlXdy8xbEpFZXByQ25s?=
 =?utf-8?B?b0NpS3Y4RW9Ha20xZnNkSjBrTWNwQkJqdThGeUdTbkhGNVJxcEUvc3ZySDZK?=
 =?utf-8?B?YTdmbW03Z3o2UFAzcXFqUVJ2QWNxY3llMUxVSFdoMXROMDVKTGJ3d3J2a3BF?=
 =?utf-8?B?am1oK0dnOVRyUjhSRTNmVCtZd2U1RURkRktvbnNJcUhCdUN0NjNhN21hK0tX?=
 =?utf-8?B?S3cwUHp4OGRibEtoVmk1bVVwb3N6WENtYXcvRC9TZEpCZ25qZTlmZHNWVVEr?=
 =?utf-8?B?aE96dmZyaVdzazhPT1k4ckhlSndXcWlSWXpyelFmemxiemovSVhYZnREMUNM?=
 =?utf-8?B?R3RDYXZvb2tvT1B2SXl0MXN4SDZIV0k3elhoRWUxWktydzdVWm5BeXR1L1kr?=
 =?utf-8?B?c0o0NlJhem5sdEd3K1hQWkFRWXFtOGVVdWVrNWxCTi8vL0hHN3hqdDdURnlO?=
 =?utf-8?Q?V3rXPUYzpVs=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?K2FFQzY2bE5wcWJGais3cWZZS2RXNmFCYTB3LzFSM3dPUkoxZWdDZGhpYzFR?=
 =?utf-8?B?QVB0RlpGUXR4R1lrQUVTVHJSMmFaT3FIVmY4UExwZTlPL3d6TlpyY3dXZk1q?=
 =?utf-8?B?bnMvQ1pjeElyS0Y0NlBwS0tIOWVOd253TEsyZStzZ2JMUFNoSUIwdGVqbUI1?=
 =?utf-8?B?cEpkT3NHQmNlZWE5dXpvb21Nd3BmK0tLQlJxdURyZGcyNVdyaUdMcU9odU9l?=
 =?utf-8?B?T1gvQ1JxNlEwM0xUTm1WVHlUdTVFcFRlSFkxY2JTd3hnQk9IVFFRMVE4M2pW?=
 =?utf-8?B?dlZkYU1FVUNqRHpIenZROGRYYWpIOW96bE8yc1lOT0Q2TVk2Q2lKRnY1YTEz?=
 =?utf-8?B?TVdlbGNjc0poemx6NHg3Nnp5ODI5R1lnWTN1OC95NjZLWks1RmVKRTBFeEMv?=
 =?utf-8?B?T1NFV24rNUc4RkFWR3Fjd3lKeVFsRUprQWxqcmhQMW9VZEhOakRzd3oyYTNZ?=
 =?utf-8?B?NWZ6ZlBPMXJaWGN2TkNINTkweitVeEhkSDBIV0F4SENlT0M0NkpZR1FPaXYv?=
 =?utf-8?B?elhZa0UvQ29JUXd4L1VLREhia2FvNXhzTzRkUE4wNC9CSVJSYlB3RTJiclpt?=
 =?utf-8?B?UVJMU21tK1hINXdvcUVDTTdlOWlhNXZWRzF3UXRGc2NMWHNXQlJUQTh2QkNG?=
 =?utf-8?B?RDhEaFNuVEZMbjV3WFVUUk1BMFVlWEEwRW1nbVlrME0wVUtVbktIZmwvZWZr?=
 =?utf-8?B?QWo1dlZORHV6YXMxNjgzMVBkRmZ5YzhTckFabmp5ekdrWFJFK0hNZXp6SitH?=
 =?utf-8?B?L2hmUHR3Mkh0RE0xNHhSZy9LSGUyTGFTQzdxS0xRT3VLM0NOTEtiN0FvMXo0?=
 =?utf-8?B?SlBIRW9jUlBLNzgyWDVYRHFjZW52dzlSZ3NsUyt5OUVEVUNzajZuUjhtWnRl?=
 =?utf-8?B?eVU4ejBoSTdkUFRCa3JjcC9oRk9SQUZJanFZbWU4eGJ5cnE2aVBLY3B0OWQy?=
 =?utf-8?B?VnZlVm9YVHpVbThBRHJrYjU3VG4rTkEzZnJSUU01TnNJNXdrbzk4VjhRMHZI?=
 =?utf-8?B?bThXTGVtSENNQVYwb3dobFg5ZFRIQnZnODA1c3dWc1JPdTEvK1NpMC9WZXFt?=
 =?utf-8?B?eVhoYW5RRkhBRzJZNWhoTEcyM2dGMTM1bmdSQ2NiYXY2dGNudjBuRXptZWR3?=
 =?utf-8?B?eXNDVEVIWWdQN1NaYXZGaWJSeWpFempqbHBXV3FzMlMxN3BNT3RJQy9pU2gr?=
 =?utf-8?B?cisvTzA2Y3RlY2JSb1FHQzlkV3BpVDdoV2F6S0NIbnFYYUI4d0ZuTnZmOGN0?=
 =?utf-8?B?Tm5UY1NiRG5EdklyNHRIRTF5ZFJnZnBCWkxNV3RxS3J5UW9VZG4ydkdRbEdX?=
 =?utf-8?B?c1NEbnJObVByL0ZsN3FBVmxQdlY2VHZJTmtXVHZPSG9Qb1NoVXJBNjdVWDRp?=
 =?utf-8?B?NW1WWWhibnR4VCtGVmxZdW4vTFlxdGJwb2hKNW9zZEJjQmY2Y0trOUs2U1BX?=
 =?utf-8?B?bkFjbzNFdUlWYmkzUUl6N2xVVFhBWEkzajN6ZXQxSk9hai9NR2FiMXlhdzMr?=
 =?utf-8?B?NG45Ty9IaVZQQjNxbVhTZTc2QnJPSW5WM3c2SWphZkt1UmRabDhVTjNWQnFU?=
 =?utf-8?B?RHE0d0QyMTA3WFhmTkNSSTNuZ3Z2TzlmbGRKNDI2NCs0SHFxUVl2ZVZ4eStB?=
 =?utf-8?B?OHFxTC9tZTlPZ3MrbjkyV3RCL2VXMVRQdjhFbWlQdHhZQkJ2Y0o4bU9VWm5C?=
 =?utf-8?B?d2N6Mi9FVkZyUkxiamp5eDlNeDVYbzN2OEFwcmFsdjVjQWJrUkxYUlJiQThM?=
 =?utf-8?B?bmpqR2gvbUJYWmJEamI5RGU4cURocmR0eEZ3VWJOcHhOTHEwaGJTZ2JRcUVW?=
 =?utf-8?B?S2tZMldONzREQ1pidFNVclloMzRjZmY0MUQ4MUc3aUI5akJyS2JhY2FTeHpx?=
 =?utf-8?B?bmsrR0R5N3BIRksrcmtCM2ZrcFUybm1nZmlwUjlCdEpJVUFGZ2VLT3Z5bkNu?=
 =?utf-8?B?RFZuUVNEN0k2dDFOeDVOVXdtK0ZVdXdScDJ4UlNVb1Y5NnEvenBUMjdJK1Q4?=
 =?utf-8?B?VmhOMVFXN2tmdzhma1JXYlR2S05Db2J5bTFydTlaMEp1Z052UUNwRTYrdHlt?=
 =?utf-8?B?NWpudnFMaFJSdkhpVjJhclBGcmtwT1YyQzRhVjBNL2xPT251czNGeXk0SVZM?=
 =?utf-8?B?K2V6bm5DNXI5OVhqeVJ0SjdLbWdTbUZmdGdKeWVqS1VyNTdiZjROeTdWR040?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sbz/xV1ydy1HgXLj3GaS6V9trkCSmZjFsvneY/z5Y6WfzGWewF2f4GDVKzGw4bStyEjiaA9UuyF+1lkqzxCi3uqdignd2QqDlPVHEsCJCpM+exl4vIK1lpQ+NcZlMWIUbSpQJkv8PxQc4lywNFHR8baYQsu0a0yOu+escPAjzsUGFcjh0cgtQfB3ow/KNFi2p5PPKfgO4t0CkQj13fA4kPponuZErjPXu1eArZEww5l1PKr3unqYx11Ko681e8TsT8Gc9GSloOPBIi5kOE27d2xSd79bfts1GBv7TzjSF1QPZZoe/Qn4jaqwD5+wfMym/6U2Own8mAyKIqHsESf3InR8MC8BgS18uyMPCodnATEj+vaXexK7pI1SUitfhefS/ioM/6oX+z742NJZ3zPlJe7qgKZ2NHqxBx+MOc/NPB9bvSmzdWsoPWTpMmNWHZj8bBrUskaDHSCaTdhyVMIJIq9sFQ73caW3VnKaFHP6NXEmi9M5QcIJj6vKh1EbupSOFyp8WibMqRjw+Mq080cXJ8rHgRuePW1qqLHFRiyZdAX81a6ZteKsFIKgu7VLY2e4zKI59g3RWEU05c62uWKVsXSAPbhGS2I6Cx+3DaiRXrI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62eaf100-297b-4f05-303d-08dddf081609
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 10:06:38.4032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6C2UWNouD6pv4jZTqyIvak9ybV5JLxYacVjq9xFcw/iIMzNNPbqVTwQx8edE8xkASm09BqnmG8eQ4JbTF+FNvaSy/gKzycQEEgpN9NavFVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6502
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508190095
X-Proofpoint-GUID: PO1ECq9tJj9jdBFtrvnt4Ux7VzkN0nzv
X-Proofpoint-ORIG-GUID: PO1ECq9tJj9jdBFtrvnt4Ux7VzkN0nzv
X-Authority-Analysis: v=2.4 cv=G4wcE8k5 c=1 sm=1 tr=0 ts=68a44cb4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=SEtKQCMJAAAA:8
 a=UYvUichnhQyLrXqmwRwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kyTSok1ft720jgMXX5-3:22 cc=ntf awl=host:13600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDA5NSBTYWx0ZWRfX0l/8vfSKxQxP
 8Xo+fLSDplIzDvo4eKf68ckqaHw0nmJC1hRaVXogAOOv59LGMYWqdZh9Sxv2dUx5/FFbT+rh6wr
 dAu2bPAVPBk0U/WHFBQr92mObfYVopNlPsDhvCSMgb1PgTHXAszhdbXsQp1EzJhDKmIvnqUT3hY
 JPbtAONdfa8UmqIkGdibAiPjVmT44J6gtExWq+eR5lgab98N+VDioJaKxSfvgAWUx/B3KGdkq96
 B0Tg811W/WHCs4r1mPcyBWx4DhaX0ygnIRgKOmrMfj8g2uphsHErnRiGUCBRRNDtfAp4jq2PUDs
 tAUmId4qswgzOsaOi8GXSI0FeBJgOi/Has86txSD/h4ldAmQiKwYKg64uIDsDx5orqxjuVy1J/J
 MmgTI88K6vpqg0mUsVcFex3oxdHsPKlFrdUIhySVmRxXMCf5O1mc6GvWitVhzCo3sPo5CgLG


On 06/08/25 11:17 AM, Harshvardhan Jha wrote:
> On 04/08/25 1:15 PM, Harshvardhan Jha wrote:
>> On 28/07/25 3:04 PM, NeilBrown wrote:
>>> On Mon, 28 Jul 2025, Harshvardhan Jha wrote:
>>>> On 27/07/25 10:20 AM, NeilBrown wrote:
>>>>> On Fri, 25 Jul 2025, Harshvardhan Jha wrote:
>>>>>> On 23/07/25 1:37 PM, NeilBrown wrote:
>>>>>>> On Wed, 23 Jul 2025, Harshvardhan Jha wrote:
>>>>>>>> On 08/04/25 4:01 PM, Mark Brown wrote:
>>>>>>>>> On Fri, Mar 28, 2025 at 01:40:44PM -0400, trondmy@kernel.org wrote:
>>>>>>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>>>>>>
>>>>>>>>>> Once a task calls exit_signals() it can no longer be signalled. So do
>>>>>>>>>> not allow it to do killable waits.
>>>>>>>>> We're seeing the LTP acct02 test failing in kernels with this patch
>>>>>>>>> applied, testing on systems with NFS root filesystems:
>>>>>>>>>
>>>>>>>>> 10271 05:03:09.064993  tst_test.c:1900: TINFO: LTP version: 20250130-1-g60fe84aaf
>>>>>>>>> 10272 05:03:09.076425  tst_test.c:1904: TINFO: Tested kernel: 6.15.0-rc1 #1 SMP PREEMPT Sun Apr  6 21:18:14 UTC 2025 aarch64
>>>>>>>>> 10273 05:03:09.076733  tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>>>>>>>>> 10274 05:03:09.087803  tst_test.c:1722: TINFO: Overall timeout per run is 0h 01m 30s
>>>>>>>>> 10275 05:03:09.088107  tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>>>>>>>>> 10276 05:03:09.093097  acct02.c:63: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=y
>>>>>>>>> 10277 05:03:09.093400  acct02.c:240: TINFO: Verifying using 'struct acct_v3'
>>>>>>>>> 10278 05:03:10.053504  <6>[   98.043143] Process accounting resumed
>>>>>>>>> 10279 05:03:10.053935  <6>[   98.043143] Process accounting resumed
>>>>>>>>> 10280 05:03:10.064653  acct02.c:193: TINFO: == entry 1 ==
>>>>>>>>> 10281 05:03:10.064953  acct02.c:84: TINFO: ac_comm != 'acct02_helper' ('acct02')
>>>>>>>>> 10282 05:03:10.076029  acct02.c:133: TINFO: ac_exitcode != 32768 (0)
>>>>>>>>> 10283 05:03:10.076331  acct02.c:141: TINFO: ac_ppid != 2466 (2461)
>>>>>>> It seems that the acct02 process got logged..
>>>>>>> Maybe the vfork attempt (trying to run acct02_helper) got half way an
>>>>>>> aborted.
>>>>>>> It got far enough that accounting got interested.
>>>>>>> It didn't get far enough to update the ppid.
>>>>>>> I'd be surprised if that were even possible....
>>>>>>>
>>>>>>> If you would like to help debug this, changing the
>>>>>>>
>>>>>>> +       if (unlikely(current->flags & PF_EXITING))
>>>>>>>
>>>>>>> to
>>>>>>>
>>>>>>> +       if (unlikely(WARN_ON(current->flags & PF_EXITING)))
>>>>>>>
>>>>>>> would provide stack traces so we can wee where -EINTR is actually being
>>>>>>> returned.  That should provide some hints.
>>>>>>>
>>>>>>> NeilBrown
>>>>>> Hi Neil,
>>>>>>
>>>>>> Upon this addition I got this in the logs
>>>>> Thanks for testing.  Was there anything new in the kernel logs?  I was
>>>>> expecting a WARNING message followed by a "Call Trace".
>>>>>
>>>>> If there wasn't, then this patch cannot have caused the problem.
>>>>> If there was, then I need to see it.
>>>>>
>>>>> Thanks,
>>>>> NeilBrown
>>>> This is what the dmesg contains:
>>>>
>>>> [  678.814887] LTP: starting acct02
>>>> [  679.831232] ------------[ cut here ]------------
>>>> [  679.833500] WARNING: CPU: 6 PID: 88930 at net/sunrpc/sched.c:279
>>>> rpc_wait_bit_killable+0x76/0x90 [sunrpc]
>>>> [  679.837308] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs
>>>> netfs rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd
>>>> grace loop nft_redir ipt_REJECT xt_comment xt_owner nft_compat
>>>> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib rfkill nft_reject_inet
>>>> nf_reject_
>>>> ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
>>>> nf_defrag_ipv6 nf_defrag_ipv4 ip_set cuse vfat fat intel_rapl_msr
>>>> intel_rapl_common kvm_amd ccp kvm drm_shmem_helper irqbypass i2c_piix4
>>>> drm_kms_helper pcspkr pvpanic_mmio i2c_smbus pvpanic drm fuse xfs
>>>> crc32c_generic
>>>>  nvme_tcp nvme_fabrics nvme_core nvme_keyring nvme_auth sd_mod
>>>> virtio_net sg net_failover virtio_scsi failover ata_generic pata_acpi
>>>> ata_piix ghash_clmulni_intel libata sha512_ssse3 virtio_pci sha256_ssse3
>>>> virtio_pci_legacy_dev sha1_ssse3 virtio_pci_modern_dev serio_raw
>>>> dm_multipath btrfs
>>>>  blake2b_generic xor zstd_compress raid6_pq sunrpc dm_mirror
>>>> dm_region_hash dm_log dm_mod be2iscsi bnx2i cnic uio cxgb4i cxgb4 tls
>>>> cxgb3i cxgb3 mdio libcxgbi libcxgb
>>>> [  679.837524]  qla4xxx iscsi_tcp libiscsi_tcp libiscsi
>>>> scsi_transport_iscsi iscsi_ibft iscsi_boot_sysfs qemu_fw_cfg aesni_intel
>>>> crypto_simd cryptd [last unloaded: kheaders]
>>>> [  679.873316] CPU: 6 UID: 0 PID: 88930 Comm: acct02_helper Kdump:
>>>> loaded Not tainted 6.15.8-1.el9.rc2.x86_64 #1 PREEMPT(voluntary)
>>>> [  679.877769] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>>>> BIOS 1.6.4 02/27/2023
>>>> [  679.880782] RIP: 0010:rpc_wait_bit_killable+0x76/0x90 [sunrpc]
>>>> [  679.883189] Code: 01 b8 00 fe ff ff 75 d5 48 8b 85 48 0d 00 00 5b 5d
>>>> 48 c1 e8 08 83 e0 01 f7 d8 19 c0 25 00 fe ff ff 31 d2 31 f6 e9 8a e6 c4
>>>> d4 <0f> 0b b8 fc ff ff ff 5b 5d 31 d2 31 f6 e9 78 e6 c4 d4 0f 1f 84 00
>>>> [  679.889976] RSP: 0018:ffffaf47811a7770 EFLAGS: 00010202
>>>> [  679.892196] RAX: ffff97be48e00330 RBX: ffffaf47811a77c0 RCX:
>>>> 0000000000000000
>>>> [  679.894978] RDX: 0000000000000001 RSI: 0000000000002102 RDI:
>>>> ffffaf47811a77c0
>>>> [  679.897786] RBP: ffff97be61588000 R08: 0000000000000000 R09:
>>>> 0000000000000000
>>>> [  679.900600] R10: 0000000000000000 R11: 0000000000000000 R12:
>>>> 0000000000002102
>>>> [  679.903432] R13: ffffffff96408ea0 R14: ffffaf47811a77d8 R15:
>>>> ffffffffc07568e0
>>>> [  679.906233] FS:  00007fc2563f8600(0000) GS:ffff97c5c890f000(0000)
>>>> knlGS:0000000000000000
>>>> [  679.909289] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [  679.911736] CR2: 00007fc2561fba70 CR3: 00000003bce3a000 CR4:
>>>> 00000000003506f0
>>>> [  679.914555] Call Trace:
>>>> [  679.915918]  <TASK>
>>>> [  679.917215]  __wait_on_bit+0x31/0xa0
>>>> [  679.918932]  out_of_line_wait_on_bit+0x93/0xc0
>>>> [  679.920914]  ? __pfx_wake_bit_function+0x10/0x10
>>>> [  679.922944]  __rpc_execute+0x109/0x310 [sunrpc]
>>>> [  679.925024]  rpc_execute+0x137/0x160 [sunrpc]
>>>> [  679.927020]  rpc_run_task+0x107/0x170 [sunrpc]
>>>> [  679.929032]  nfs4_call_sync_sequence+0x74/0xc0 [nfsv4]
>>>> [  679.931319]  _nfs4_proc_statfs+0xc7/0x100 [nfsv4]
>>>> [  679.933520]  ? srso_return_thunk+0x5/0x5f
>>>> [  679.935391]  nfs4_proc_statfs+0x6b/0xb0 [nfsv4]
>>>> [  679.937367]  nfs_statfs+0x7e/0x1e0 [nfs]
>>>> [  679.939138]  statfs_by_dentry+0x67/0xa0
>>>> [  679.940887]  vfs_statfs+0x1c/0x40
>>>> [  679.942596]  check_free_space+0x71/0x110
>>> Thanks.  I'm not sure why this causes a problem as if vfs_statfs() fail,
>>> check_free_space() assumes there is still free space.
>>> However it does strongly suggest that we still need to NFS to work in
>>> processes where signals have been shutdown.
>>>
>>> Could you change rpc_wait_bit_killable() to be the following and retest?
>>> I intention is that when the process is exiting, we wait up to 5 seconds
>>> for each request and then fail.  It's a bit ugly, but it is a rather
>>> strange situation.  It blocking forever that we really want to avoid
>>> here, not blocking at all.
>>>
>>> Thanks,
>>> NeilBrown
>>>
>>>
>>> static int rpc_wait_bit_killable(struct wait_bit_key *key, int mode)
>>> {
>>> 	if (unlikely(current->flags & PF_EXITING)) {
>>> 		if (schedule_timeout(5*HZ) > 0)
>>> 			/* timed out */
>>> 			return 0;
>>> 		return -EINTR;
>>> 	}
>>> 	schedule();
>>> 	if (signal_pending_state(mode, current))
>>> 		return -ERESTARTSYS;
>>> 	return 0;
>>> }
>> Adding this change makes the test pass:
>>
>> <<<test_start>>>
>> tag=acct02 stime=1754066481
>> cmdline="acct02"
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.15.8-master.sunrpc.el9.rc3.x86_64/config'
>> tst_tmpdir.c:316: TINFO: Using /tmpdir/ltp-lNzAk1qhuX/LTP_accZ75zl1 as tmpdir (nfs filesystem)
>> tst_test.c:2004: TINFO: LTP version: 20250530-128-g6505f9e29
>> tst_test.c:2007: TINFO: Tested kernel: 6.15.8-master.sunrpc.el9.rc3.x86_64 #1 SMP PREEMPT_DYNAMIC Tue Jul 29 05:06:28 PDT 2025 x86_64
>> tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.15.8-master.sunrpc.el9.rc3.x86_64/config'
>> tst_test.c:1825: TINFO: Overall timeout per run is 0h 00m 30s
>> tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.15.8-master.sunrpc.el9.rc3.x86_64/config'
>> acct02.c:61: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=y
>> acct02.c:238: TINFO: Verifying using 'struct acct_v3'
>> acct02.c:191: TINFO: == entry 1 ==
>> acct02.c:82: TINFO: ac_comm != 'acct02_helper' ('iscsiadm')
>> acct02.c:131: TINFO: ac_exitcode != 32768 (5376)
>> acct02.c:139: TINFO: ac_ppid != 52326 (2475)
>> acct02.c:191: TINFO: == entry 2 ==
>> acct02.c:82: TINFO: ac_comm != 'acct02_helper' ('systemd')
>> acct02.c:125: TINFO: elap_time/clock_ticks >= 2 (1065/100: 10.00)
>> acct02.c:131: TINFO: ac_exitcode != 32768 (0)
>> acct02.c:139: TINFO: ac_ppid != 52326 (1)
>> acct02.c:191: TINFO: == entry 3 ==
>> acct02.c:82: TINFO: ac_comm != 'acct02_helper' ('(sd-pam)')
>> acct02.c:125: TINFO: elap_time/clock_ticks >= 2 (1062/100: 10.00)
>> acct02.c:131: TINFO: ac_exitcode != 32768 (9)
>> acct02.c:139: TINFO: ac_ppid != 52326 (1)
>> acct02.c:191: TINFO: == entry 4 ==
>> acct02.c:82: TINFO: ac_comm != 'acct02_helper' ('systemd-user-ru')
>> acct02.c:131: TINFO: ac_exitcode != 32768 (0)
>> acct02.c:139: TINFO: ac_ppid != 52326 (1)
>> acct02.c:191: TINFO: == entry 5 ==
>> acct02.c:202: TINFO: Number of accounting file entries tested: 5
>> acct02.c:208: TPASS: acct() wrote correct file contents!
>>
>> Summary:
>> passed   1
>> failed   0
>> broken   0
>> skipped  0
>> warnings 0
>> incrementing stop
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=1 termination_type=exited termination_id=0 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>>
>> Thanks & Regards,
>> Harshvardhan
> Hi there,
>
> I tested this around 50 iterations and it passes all 50 times with this
> timeout.
>
> Thanks & Regards,
> Harshvardhan
>
Hello there,

Can we go ahead and revert this patch for the meantime until a fix is
obtained?


Thanks & Regards,

Harshvardhan

>>
>>>> [  679.944433]  acct_write_process+0x45/0x180
>>>> [  679.946313]  acct_process+0xff/0x180
>>>> [  679.948003]  do_exit+0x216/0x480
>>>> [  679.949799]  ? srso_return_thunk+0x5/0x5f
>>>> [  679.951621]  do_group_exit+0x30/0x80
>>>> [  679.953329]  __x64_sys_exit_group+0x18/0x20
>>>> [  679.955217]  x64_sys_call+0xfdb/0x14f0
>>>> [  679.956971]  do_syscall_64+0x82/0x7a0
>>>> [  679.958717]  ? srso_return_thunk+0x5/0x5f
>>>> [  679.960550]  ? ___pte_offset_map+0x1b/0x1a0
>>>> [  679.962434]  ? srso_return_thunk+0x5/0x5f
>>>> [  679.964261]  ? __alloc_frozen_pages_noprof+0x18d/0x340
>>>> [  679.966389]  ? srso_return_thunk+0x5/0x5f
>>>> [  679.968183]  ? srso_return_thunk+0x5/0x5f
>>>> [  679.969945]  ? __mod_memcg_lruvec_state+0xb6/0x1b0
>>>> [  679.971977]  ? srso_return_thunk+0x5/0x5f
>>>> [  679.973690]  ? __lruvec_stat_mod_folio+0x83/0xd0
>>>> [  679.975671]  ? srso_return_thunk+0x5/0x5f
>>>> [  679.977392]  ? srso_return_thunk+0x5/0x5f
>>>> [  679.979079]  ? set_ptes.isra.0+0x36/0x90
>>>> [  679.980771]  ? srso_return_thunk+0x5/0x5f
>>>> [  679.982375]  ? srso_return_thunk+0x5/0x5f
>>>> [  679.984052]  ? wp_page_copy+0x333/0x730
>>>> [  679.985648]  ? srso_return_thunk+0x5/0x5f
>>>> [  679.987220]  ? __handle_mm_fault+0x397/0x6f0
>>>> [  679.988818]  ? srso_return_thunk+0x5/0x5f
>>>> [  679.990411]  ? __count_memcg_events+0xbb/0x150
>>>> [  679.992111]  ? srso_return_thunk+0x5/0x5f
>>>> [  679.993689]  ? count_memcg_events.constprop.0+0x26/0x50
>>>> [  679.995590]  ? srso_return_thunk+0x5/0x5f
>>>> [  679.997177]  ? handle_mm_fault+0x245/0x350
>>>> [  679.998807]  ? srso_return_thunk+0x5/0x5f
>>>> [  680.000339]  ? do_user_addr_fault+0x221/0x690
>>>> [  680.002042]  ? srso_return_thunk+0x5/0x5f
>>>> [  680.003553]  ? arch_exit_to_user_mode_prepare.isra.0+0x1e/0xd0
>>>> [  680.005643]  ? srso_return_thunk+0x5/0x5f
>>>> [  680.007202]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>> [  680.009025] RIP: 0033:0x7fc2560d985d
>>>> [  680.010510] Code: Unable to access opcode bytes at 0x7fc2560d9833.
>>>> [  680.012660] RSP: 002b:00007ffde591df68 EFLAGS: 00000246 ORIG_RAX:
>>>> 00000000000000e7
>>>> [  680.015355] RAX: ffffffffffffffda RBX: 00007fc2561f59e0 RCX:
>>>> 00007fc2560d985d
>>>> [  680.017749] RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI:
>>>> 0000000000000080
>>>> [  680.020292] RBP: 0000000000000080 R08: 0000000000000000 R09:
>>>> 0000000000000020
>>>> [  680.022729] R10: 00007ffde591de10 R11: 0000000000000246 R12:
>>>> 00007fc2561f59e0
>>>> [  680.025174] R13: 00007fc2561faf20 R14: 0000000000000001 R15:
>>>> 00007fc2561faf08
>>>> [  680.027593]  </TASK>
>>>> [  680.028661] ---[ end trace 0000000000000000 ]---
>>>>
>>>>
>>>> Thanks & Regards,
>>>> Harshvardhan
>>>>
>>>>>> <<<test_start>>>
>>>>>> tag=acct02 stime=1753444172
>>>>>> cmdline="acct02"
>>>>>> contacts=""
>>>>>> analysis=exit
>>>>>> <<<test_output>>>
>>>>>> tst_kconfig.c:88: TINFO: Parsing kernel config
>>>>>> '/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
>>>>>> tst_tmpdir.c:316: TINFO: Using /tmpdir/ltp-w1ozKKlJ6n/LTP_acc4RRfLh as
>>>>>> tmpdir (nfs filesystem)
>>>>>> tst_test.c:2004: TINFO: LTP version: 20250530-105-gda73e1527
>>>>>> tst_test.c:2007: TINFO: Tested kernel:
>>>>>> 6.15.8-1.bug38227970.el9.rc2.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Jul 25
>>>>>> 02:03:04 PDT 2025 x86_64
>>>>>> tst_kconfig.c:88: TINFO: Parsing kernel config
>>>>>> '/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
>>>>>> tst_test.c:1825: TINFO: Overall timeout per run is 0h 00m 30s
>>>>>> tst_kconfig.c:88: TINFO: Parsing kernel config
>>>>>> '/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
>>>>>> acct02.c:61: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=y
>>>>>> acct02.c:238: TINFO: Verifying using 'struct acct_v3'
>>>>>> acct02.c:191: TINFO: == entry 1 ==
>>>>>> acct02.c:82: TINFO: ac_comm != 'acct02_helper' ('acct02')
>>>>>> acct02.c:131: TINFO: ac_exitcode != 32768 (0)
>>>>>> acct02.c:139: TINFO: ac_ppid != 88929 (88928)
>>>>>> acct02.c:181: TFAIL: end of file reached
>>>>>>
>>>>>> HINT: You _MAY_ be missing kernel fixes:
>>>>>>
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d9570158b626
>>>>>>
>>>>>> Summary:
>>>>>> passed   0
>>>>>> failed   1
>>>>>> broken   0
>>>>>> skipped  0
>>>>>> warnings 0
>>>>>> incrementing stop
>>>>>> <<<execution_status>>>
>>>>>> initiation_status="ok"
>>>>>> duration=1 termination_type=exited termination_id=1 corefile=no
>>>>>> cutime=0 cstime=20
>>>>>>
>>>>>> <<<test_end>>>
>>>>>>
>>>>>>
>>>>>> Thanks & Regards,
>>>>>>
>>>>>> Harshvardhan

