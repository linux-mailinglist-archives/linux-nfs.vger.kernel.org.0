Return-Path: <linux-nfs+bounces-20429-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HF4OlBUxWmD9QQAu9opvQ
	(envelope-from <linux-nfs+bounces-20429-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 16:44:16 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3DC337CC4
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 16:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0F8C31CA386
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF0F3FD131;
	Thu, 26 Mar 2026 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xwz/ZcuN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FAB6nRCO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6420A1AB6F1;
	Thu, 26 Mar 2026 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774539070; cv=fail; b=SckGUzeFDuFcB2aEn88sTxV6DpR6zFzwUaOsPrVcwv3BoLk6EXkOLgzCr6TuWiY6/4G+K9P5eFznZZqjZ3O+JqZpljFK+rJWkTjNx4Lv/3arOVZT2E5gNYdbcTRGsrrjzJDMRThNndN9+J5AVJ8ofl2FtKpFjI+vqFW80fYEs8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774539070; c=relaxed/simple;
	bh=c5AKqzwkLYvQu+WvLP17xintt5TF41SJrv3297fCXlE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XJL95l8n2IbQwGofm+hsrSGkoj3iw7GKm157ztgg1Ty+BkbWynbGuTxacbKmULt4njGFtMPjUyZNcc4CXfHaubOl7kpZRasBV9urpkVPrWspFhQvEfPemRDTD4M1M980K2+ogIZnG/ThzJOtUmAqrM5gbRcXLSgWtvlTjVu5KLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xwz/ZcuN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FAB6nRCO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q7ALDN3465214;
	Thu, 26 Mar 2026 15:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dYClvBCnVyBXjAoW+OvAhyJxyDotqZGDG1MT4Vwjjo8=; b=
	Xwz/ZcuNwO9jJGKdAjZt4yzC+GVgKQ9lfw+KL2M1VnAIv3JzHO72mdflD9lpTWby
	QugkY+OmC0pU5hii6h+Xx15nk/0fgqtqlh2LyS5FDss2iVZWk5wMzO95ep6gYeRr
	Es7vXXpDJxIxgoXcpz2rHChxZXw55TFIssryVuywTfwjVky+GhR+CpHL30PC969b
	T9TuBme9fIb0xgCCnV1dbQj5nKpJtnv3cpkGYKpXNN/+l7BII0xWtRGMYzniQzOh
	30U/l1mn1QEEhVft8er+6My7qvi0BgujUV+I/kHhIdWjutcgbQ5vyY0kfmLVmB/L
	yPPTuqfGVEoNAn4QUbf4oA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1khf8far-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 15:31:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62QFKlEj039963;
	Thu, 26 Mar 2026 15:31:01 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011042.outbound.protection.outlook.com [40.93.194.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsctm9b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 15:31:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhNpRYKhZYXI9b2FWUr0nSzMHcgW2tJ/xxTGcHeY7fWK7HyMCsDggdgColQ0/TBXYajePIYibFEpuiKNs0/nMGvfjuIgGs27cR3bTJUGXgQwCkC6t2n0LVmWC9B19nmCBWzk4vW4QpLewZjBiqI4/hn04Zy2RgkoHWBGPMBDds4MJ3PTmD9/4N7opGCtSGyjPy2mxc9Yr44OqcoPev+k/70OvYVxmYhG8AENrykmtQ8i2LrI5Mxedx4r9i6JY9zrNjZh2kQX9JIu4RdVKHJudUBXW+k+IQRsYBE8YdCNqFsVL1lZYiRWzESB7E9vLNGVYBbHm4yD4rYpshGp8hTtew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYClvBCnVyBXjAoW+OvAhyJxyDotqZGDG1MT4Vwjjo8=;
 b=qXtxhe4AwGc5t/piXFBp3KR2++r4YHsYoCCvRUeUyjG39+hg6fMWGI81yx2dyhqf1iQ1GP9rkRG7vqlSLwh80y8FpKz81BWU/59NajyGuv14WSja5jm0akNO2m0PwE5ZqcUkKKYx/oKCVnVP6UWUn5VHXLP5MQnPYMFygkgBFiAedVmjNT2/Vp9HTmmItyQBv+innoZFlVNq7VKaQ6r2k/ri7GmXr2q9B8NOR2EXxN8bKc5m87AX+PR6RVLSGyG0GfC3szjSV4987yFR0qUj6awbAfA47aarqXNXtHlNBPplT7taGmGdwM79bdnVNMceoTcg0jKMj8QUaQnXm2Ww0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYClvBCnVyBXjAoW+OvAhyJxyDotqZGDG1MT4Vwjjo8=;
 b=FAB6nRCOFt6j7VF3LolKwL2cq99XZ/gtSbvsV1cE5Hyn1qU1y+F0KjyZ17VD7CNC/RsyO2ItpbUfLml9coALk1weNoOJNtXhtMmv/pHBXJ4uxY+DmD1bjDBCcXojeSJKFlxH+56Sp/fQW1jDJD1pqOAfh2Y7Oi2AmZO5rwoRfK4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4485.namprd10.prod.outlook.com (2603:10b6:510:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 15:30:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 15:30:57 +0000
Message-ID: <d453add6-ed23-4d61-af95-d80133b0e456@oracle.com>
Date: Thu, 26 Mar 2026 11:30:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: A comparison of the new nfsd iomodes (and an experimental one)
To: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>
References: <4ebbd194ccfb3bcea6225d926b4c9f339e21c813.camel@kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <4ebbd194ccfb3bcea6225d926b4c9f339e21c813.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:610:4e::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe8c98d-f17c-4f61-85f4-08de8b4cad46
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 G3VuW2Gm8+yw44rD+GbnM4qhES52tact4bJOmICLWtppevpFRNVMtM8TbTwlsbQ3+c/u5Lt/M0QPJaTb1d9emMnd7VssxKkYMrw8os2dOd0R4otwn29RXnyuVE4P3cNtqsquKp/qBC/snxOHoxlVLXtwLUe37U1472JnUX51ZZ5n4adlV9UGXytFrwp8LjbQJRcWehnfpdEgzMnhJd4t0Zwj46O6twyoAKUMDt/mBFrx/YpUiJrTZ+a2CE2iGsi3DxqP+LD6k1EA+vwytFowhtiOrBHuJ8LH6a1X7cpZC6sDGq26gFft3Su4/ydWJuxokqHAMviqeMxbvyvPNpYVnbUlBJH/Nko7bYos4DvteCj+Ltt2glUF/BJVLuBh+s/GjSAmIk2eftYCgSf3aFOKUuA9H3Wr4XkEtEwedNlK25/xr5zkOrVPyn9JpmtKRSO6jSV6SIv6gzoozZjNMHu46PfwFe5OO/gt5JJH2vJ8JXe06clEQvcGCCTRu88c1EYRCVRuX3OiM3dg0oOooGZZ0TQAVOQwJ07fYGSTttPqpB3Xtec/t6v899fbAF0Z9nh6habrf4Y6V8TIt4htEIJuvZ2gaDITEONqTvj6furW/hDSnHfOIhXLKMdcgchNk6FkNtmVqL8IuuRqDP9qxfr/fm4bT1RJtsWSHnosejlmeRg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VVRwdEpXd1NZZGJ5MWN4aHhad3lmRC81cFBZUGlVWklRcFZJV2lzV2F5UERK?=
 =?utf-8?B?R056RW43VGRXOWtFMktES3lQYVpwL0JsMmpZVnhFRnlENytxWWZ5dXF2ZFd2?=
 =?utf-8?B?UnBiZjE3bGwwbzk1cFA5UlB5TEl2N2tKeUtTSFZTT0RoZFJpcUd6blo0RjFC?=
 =?utf-8?B?djdMWVhUTmhjbFlwT3BvTkR5SGZLVW9CaTI5VjhRZ1Vva0Z3YkxZZVUvYW9p?=
 =?utf-8?B?a2RXQ1RHVDVvU2FZT2FzVWhiTmhRODRFU3FDaFo2bzNaYjZFaDZEeUxwdjE3?=
 =?utf-8?B?aXIvV0lmUWViSlV3ZUxKa0NVWjJDaVRISkZndlF4ckt0QWZ3Z3JuVGRweERQ?=
 =?utf-8?B?OWdMYUZld0M3ZlRsRkJ6MkdsQm4yMVJ6YzJoTnFFK3p3YmQ2RTNpVEg5VWt2?=
 =?utf-8?B?SGRsUEhFT29rVmg4YTJCa1RpelJTa3llSDU3dGdGYXlKVGc5clVzaGZ5YUlO?=
 =?utf-8?B?Zzkvc2NCT014b1JaTFBVemVNY1NFSzdaQVd4TVZONldDS2tXTVJ0YTVsWCtP?=
 =?utf-8?B?NUNFRzRQdjRZcmtKaHRwK0xvWE1paWZoRUlZU0FMU0R6dFZOQ2liZnVoVFZo?=
 =?utf-8?B?TEJCVUZOY24rSnJLdkVCWlN3YWFyKy9OL05GSE93V09yaWt5WUNFMGFVWUJ2?=
 =?utf-8?B?elRrUzhOWTc3TGxsR2hjUHdDVWJ5eEJqTWhCWDVyRkNqYUE1RTNDNlQ0SWhv?=
 =?utf-8?B?czdlcGVpR2VFZ1Ewenl6WGVTVnZHd1hIdXZVRTdwRDJzdzl4anNlNzJPaU00?=
 =?utf-8?B?aHRMMmk2VllRUk5Vazd2MmN6ZnlNdE9OWDlISHZ1VWR6aFVWSlhya1VqZTFa?=
 =?utf-8?B?TnlWM1pRSFd2ZC9GbzRUd0lLYVplVGpKektSK2oyT25BRGZGdGI4b2VrS0ty?=
 =?utf-8?B?eHI4b2ZhYTBQVjJML0tGdGhSdVZFK1cycUlYUXV3L0NBWWNnY2NTcStJb0tS?=
 =?utf-8?B?RmZtNlVQdFNTcTJLUk5lMzM2MzhHV2lUcFR4T3Nqa3RxNExwOFB5UExVZVlS?=
 =?utf-8?B?ckc1blE4dnRKZmxqbUUyelRKT0FhSnBmSGJXOHBzcjlqbitoTEpaU2h5RUpw?=
 =?utf-8?B?M1FBbkY0TW1RdzJIM1lCZy83NGNLMEt1UTBWdjYvMm1DcEs4WGhNZzVvVXRk?=
 =?utf-8?B?d1p1N0RlOU1LSnp5MU1FcVBGSVA4REp0MjloVk1xVGhBSUlqUFdpNUdVaWZx?=
 =?utf-8?B?VnQ5aW5qdVVLVm12UEN5NkhxRGFTL3JJZFpKb3N4YlFvdHhJR3JYVzFnVFRP?=
 =?utf-8?B?czZSbFBJRTV2OTR5aUVkS0dZOVYzZzNTSFZ3aktjTFg2Vjg1ZlVkdmVKVUlq?=
 =?utf-8?B?Q3cwMytBNUUwSVBuQjhjY1JReTFNVHZISjhyTTV0dzZ0Q3gxTTdFRzcxb2dB?=
 =?utf-8?B?a3J4RHpZYWpSYlR6SGpydTRIUks3cmRUMk5FSWdqbVZRYU5aQ0JNZmRJYkJD?=
 =?utf-8?B?M0puL2liU2hjUFpBV3NPNi9uSVdpZEM1QXRVQm1hMXNDMkRTUFlDM1ZMUXVj?=
 =?utf-8?B?Ync2WWpja1JFNi9MUXRMWTBoMW5iWXZFNkNFUHE1SUtzeDI4RHBKWERZTEJm?=
 =?utf-8?B?Rkk1VXBqZUxKTEc2eXBhaGoxS1Y3YXFjajhTcW5FUzdjenBjVGlyQTRzVWJT?=
 =?utf-8?B?aTVqU0ZlalJqL1U1YlFtcEU1bzQ5VEZ1ZGozRFRKdWxFV3FHUlBDNFp5VFN0?=
 =?utf-8?B?RjlpUTJsQ0t1SGRwZzI1TXZJdlhoMVZ1QkFoeFFMWEJVYzNBTlRBZjFjME1o?=
 =?utf-8?B?ZmllMGZoYzJxRU9NK1Q0VXNvcGhZZmlBbm5mN1dyZFhvVk5EZ1A0MXJsQWZl?=
 =?utf-8?B?Wi9pMjIvbXdYWk9DUmY2R1JtMys1bklXR3VsZm1iRGdPOHRrT05QOURzbnZ0?=
 =?utf-8?B?a0c1dEhETWQxNlYrNHhPdzJmUUt1TU1ZbWR0L1dTS01TRjlVcDJ0azJyTU14?=
 =?utf-8?B?cmNMUUE2enhGTHVsVjVtZHVvQnpqZ24wOE56RDBSR2tNQTZ4ZWNSV0VmaVZD?=
 =?utf-8?B?bDk0ZTBaZzUyNjFqNWMrSkxvRjF1d0Q5OC9Ca0oxODVoL25ZSWZVYWM3KzhG?=
 =?utf-8?B?MFdTbGNRbzJtQ0VybkVmcW5WSmhIdXE0SnI3MTdQakNGdDVBZ3NXMmJnOU44?=
 =?utf-8?B?T3IreStScEVZV2UwRlNzMUoraGd2aUQ1eVJRNXVLYkpSNWxEYnVFZ0RPK3g4?=
 =?utf-8?B?bDZUY09CVW1jSXBZVHhOQU9UQkk2Q3lHUTZHcFlpeTNYdngxdElhU2NWQy9n?=
 =?utf-8?B?WTdBZXNIQ3lzcGlFQ2liYUJJL3J1eGNPMEx5TFkvTndVYUgvckkvVE11enht?=
 =?utf-8?B?dDh1QjdkdmxiQnhYV1FyTDhGdTNCV2szRDV1cDM1VVMzazB2bXVDQT09?=
X-Exchange-RoutingPolicyChecked:
	cwaajZf8+frSQXlrAJ7IS9nH1kBGqtPUPq35RGi+PRrmaKfvy8fhbxhwgsaqheD9OjY4Hkx+0mBykW7yqn/uD3kpkKxfGP3eDHdxQKR9e+IS1ZPcFsCBd+Qr9hCjLc0oYpC9X1xJ2xuIJ37wq8DaB/HTNMqclobYhH7P3SofKHIJxYDnjvcE24YPzTE0FfXuVuse/8YQB8uHY4LHfbtdyzdW513GmI/xuolSSZGgAX4HUknzMTP6xjT3ZJOi5/qDHDF5n2AF7dYU9qobxfyyhVO6J/sJKnm22p1WNQIx1cqYlDZIf0GSVRLimvrJCeh14IUGaJYz7FxFtLgpQT3P6A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ha4x+ikeLLhbFRLitksk1nJmoZlV7Gbvc/9B1uzNzFb+Yz27yQ1JJcIYYQ71X8j3V3AgNR0LUyorA5ykl8Fe4bygF4s0K+Q+ifOaoPhPsS2ngWIXGw4AGysNTjSRZzVA8mpBFwm2sK/hlQz3Qx6m1FV/0eQiRwjtBRMr1JapIK9eIFPzXR42eTl02V6qgS2+1fuc8blScMnYCpd760hbxQBNBmu33VRU667nfQ5XDO0WW0tUfa6nMhRF7I+Zrfs11uCdLb6VMYAKmu6gR277VFO7gQfuyBLzt3CXGcMy613c003zjqPuA63h0BRVSYRAIr8DOMPEUp+c/SlLil4FQogu7yKgrUG/CcaDd3gg0N4Cl+lk8n9IU4uCESMqXw2WNVGbPGMZ1Za9DhiwwPS5nCOFbSq6OV3sOkm+wvVSb6KpIg8jYorsthZks2UVSi7FUbZqJFeiF1HNOUfCP53lFqqlvB7cvLb/6J/4jHY5n1lJ2xzxR+giO1RnQ/VQQX7zAF5mqCH7cqOn06kc+/VExKFj9Q/ZA6ZVztcQe+zYQxoeGuDZ1iEgEpCOrQH4Jp7/ldmg1CYEsZDOpz9EupMa965rYPwkeOA785/+Y6xu6hU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe8c98d-f17c-4f61-85f4-08de8b4cad46
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 15:30:57.5936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvnPj9enoWyX4Mn8wPt9ZwSoCNET2NsXHcuyqr2OJb9AeDBiGfuleU/tUTOSGL3fUyUT31im0uzzs+Gwj4Xvrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4485
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=526 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603260109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDExMCBTYWx0ZWRfX1aGXSKgPF39B
 Giahx5+llkvFFQrXyabDgHd21CjEPw3M+qY6wsBRhU4xvT0JlVMULKQYRwHvE9brvNdfG86OQoL
 T9X9N+t6y6vXGh/J+35J6rV3allJgDB3K1QGxUNcp6vLPPD3pSVNVsEFmhnVZN+fBq4aqvCkaEP
 rHWXNuqcJYy13DZ1sfOHSKSdJtZnBZsm2JmsubN1zZUZj/lS6V7CkGs6XbZJXmfoaftNs4eB7JM
 6/ot6nGmcO91D60uT6Pox2Aau/Pt3SO77V3pVIiduh9M8x7OeYI2sIIa8nS6Hv4F4bb2VQvEqmk
 QYyvAqT4FqaTln4JOSRkx6bwaJdHLm5P0AMsKiUEr3pZ3yfZKsYOukMP8OuuhYsZXuAVNFQfUNL
 XB8i2QbPdxkJUYHAweHxoeWUtPhWynHPEml8CqpdgcYx6t/GTD/W27m67qHS38I7QXr3VcNtPdZ
 HkZyDwJelfodRK/A2nQ==
X-Authority-Analysis: v=2.4 cv=AIvfpCdw c=1 sm=1 tr=0 ts=69c55136 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=qN8iZ0LCc0IvDgTb:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22
 a=qutJ3oGYAAAA:8 a=NJ4IEFOjWCQq7l1YO-cA:9 a=QEXdDO2ut3YA:10
 a=kvciRYWlRGjMxkl-AhjN:22
X-Proofpoint-ORIG-GUID: IBDpOaTIQL03SysCfoA-5C9Z1QnstjyW
X-Proofpoint-GUID: IBDpOaTIQL03SysCfoA-5C9Z1QnstjyW
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20429-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[markdownpastebin.com:url,oracle.com:dkim,oracle.com:mid,oracle.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5C3DC337CC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 11:23 AM, Jeff Layton wrote:
> I've been doing some benchmarking of the new nfsd iomodes, using
> different fio-based workloads.
> 
> The results have been interesting, but one thing that stands out is
> that RWF_DONTCACHE is absolutely terrible for streaming write
> workloads. That prompted me to experiment with a new iomode that added
> some optimizations (DONTCACHE_LAZY).
> 
> The results along with Claude's analysis are here:
> 
>     https://markdownpastebin.com/?id=387375d00b5443b3a2e37d58a062331f
> 
> He gets a bit out over his skis on the upstream plan, but tl;dr is that
> DONTCACHE_LAZY (which is DONTCACHE with some optimizations) outperforms
> the other write iomodes.

The analysis of the write modes seems plausible. I'm interested to hear
what Mike and Jens have to say about that.

One thing I'd like to hear more about is why Claude felt that disabling
splice read was beneficial. My own benchmarking in that area has shown
that splice read is always a win over not using splice.


-- 
Chuck Lever

