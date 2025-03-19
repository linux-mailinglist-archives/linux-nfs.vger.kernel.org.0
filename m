Return-Path: <linux-nfs+bounces-10705-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA31A69BD8
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 23:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCA38873F3
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 22:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BF120899C;
	Wed, 19 Mar 2025 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WaJ+hKJW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wwiBvzkG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7955A2147F5
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 22:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422399; cv=fail; b=TYbF9WCOeL9C8FVWL6kvoM7nRpDkHVnXqsTwrXTZXOlYZgxSy38vWdAPbS9zrjJGz0s78yUow7UzUPBnNWzlREqavQUjrZIKrZroNIKSKIp41PlJDY1RP4vktdHX3bgbPmZb9Q1J1m5fOsGeuAkvl3WWf2szqo6wxKEEJcJlMDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422399; c=relaxed/simple;
	bh=iJqwNEemy5QuiKhxsbtnepDy9zJt709zVYY5FzR+wdo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FfS924EFdjqMCyGecaSMcJLlI/mEXjLk5W4Qpl0sx0ZlXTZX/YkF+GS9KYLV4B1fr1i5HXDRvEqt2kg9U9XU/QnhwOY250fkFrGMGKhGCwmb3jYls2+dcXOSzpt3Ylste0Zn4W+0tlGQehc6zNBntrp8WcVCHkrXrx8Xxb/F5m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WaJ+hKJW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wwiBvzkG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JLuXhQ006652;
	Wed, 19 Mar 2025 22:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=z9iGL1sUTQk/bYpduyWqg3NUEj++aeJoxaqQ2b7YUOY=; b=
	WaJ+hKJWwV8J3a+bPjUChSkFaIr7vHQ6pYhI/ebvStRtvJi/Fyz46MbfGTq5oW4m
	dHGOXWz4nan1BGBRVPpV0bJ7y8Nm19qQs41Ce4s3cJWGcDoMo/GWX7E2QTWwAUTT
	ohLBlT+4h06gzFwpQt+pZ+zVxN4W/mDrKssoKLb2PsQzEoQf05dafwm8dtyp111I
	Gb+pAHQWn5xLMST54YAovcZ6SZF4IiDnRf5absoFbklfgdFZqZ1tpYFBYemgfNoG
	4xtkT+Ez0R89R5Y7ss6o5ho4+PRDF/r6TnQ+vQnmHd4YxWRt8jTuvFFe0Lp9v7nv
	Go4Bekqt6glFRFZdo5HHrA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23s4xfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 22:13:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52JLNSVg009621;
	Wed, 19 Mar 2025 22:13:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxm1u488-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 22:13:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSTlvXUvL6N56MmFS+/h9Q8WFNt8PlLHyBOUEkxlXX85NguBqyj/XYpIqUWSWWqJAA28/vXKl8WJaSXXZAY1DoARxAlbjlPPDVlBU/y2ypXyDk+pqy1eCC+FsgoCgAfWfiR4E6oB3jn5gvrTyStlogysGvoMtbjqfQFOxOvex4dXYLV7I+kIW/CYAoEknsYMp3QcxKAzyb2PvHRNzi6+BjOnbisav0BtT1/E4LFEgaclMM3z5nWnB4c06yaymMm9ui/XlCDVU4dGeBvmPbZnhww9o6uJnnFTnhQCujFUWUtLKOr+jMpU9hSlOJX7OencTtBemztOM+6l9KxCTTSR6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9iGL1sUTQk/bYpduyWqg3NUEj++aeJoxaqQ2b7YUOY=;
 b=yt95KBwToegMu6WkM9t5WUDBZUAYpWMtHdH6na6GcDUGQhythqCPaEWR48jHwM1RV29IpUADFWzghrqHyykMhqN2JNOYGoZxc7QqvwntdrM24VHdVJAwyIX1AZX8+61O1cpoNJOeUH7DlPCPmH1LnLEM6Z58CrW3ytjl3toW7IrZyDnqxjLOROWv/0zJmQrquGg7kfJjOGquRTdq+FFX8Bpho7fuxpG6dPDy8XWAvIDMvQUUEzC6ojs1OuWrsviwCj5ALhthzOEbZVfIHAUnF3bbf+hjuNOylWDDpI5pKfdfBvitjNDg9+AUYEAxAuBPhUQoXJzJ5wgJyLw8D1pW+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9iGL1sUTQk/bYpduyWqg3NUEj++aeJoxaqQ2b7YUOY=;
 b=wwiBvzkGspEiglBFaqTuaJtbR2VT14Q3MlirM7C6kGYwJXv7GkDHukoi1HG6k2BxgCCRkONceLlOOHJW/vBjYucAiJ9VYx5Y88dl2YIQUbCOuRAoviIcnq/KKDZa9WK19gSTcq2TgPNoMHvVHtOJ8ORW6Tkxa73u+A2nr24s4zU=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by MW4PR10MB5704.namprd10.prod.outlook.com (2603:10b6:303:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 22:13:04 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 22:13:04 +0000
Message-ID: <8cb253d2-5877-4b3f-95f0-eadaa85a1d50@oracle.com>
Date: Wed, 19 Mar 2025 15:12:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD automatically releases all states when underlying file
 system is unmounted
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <543f93fd-3b5a-4e4a-b2b0-0a1b7e1e8361@oracle.com>
 <174242076022.9342.12166225816627715170@noble.neil.brown.name>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <174242076022.9342.12166225816627715170@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0395.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::22) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|MW4PR10MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: 8826ba05-1351-401e-0b05-08dd67333845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHdjUVYwaUF1U25MU3ZCaWp6RWwzbndVc28rdGNwRHdPckg4Q2ZiZHU2aDhY?=
 =?utf-8?B?MUIzcloySnkrWlNlNlJZRm9yYWozNW8vTDNObTZ0UTNJeWhnMVZoSjd4ZWZL?=
 =?utf-8?B?UUpnQVVQRndzRTdRUlZDOXgyYWNLeHNUYzN3ZnFwVWpIUVVSYS9FNkwxL2p2?=
 =?utf-8?B?NDNCaXovWU1RZzgwT3lxdVlSWDg0M2ZiMTN5YTVBaVM3MkxMNmIrTGRyZGZR?=
 =?utf-8?B?VnAxZFBrbDNEeXFSbTY0MWliV1NjRm42SDZKejdiQVRRMlJvaENJd2cwc3ZF?=
 =?utf-8?B?Rkk5NlpmS3JjNW91V3JTU3pndXBFZDJ1UDFLQ3YyMTI4bkw0TFlBVXdsK1JB?=
 =?utf-8?B?RnQ5WTdXdTZjQnVNQWN4eFNkZEJGWHlCVXYzbFF6eTEzMm56b1N0d01VNVBu?=
 =?utf-8?B?QTZWOVVhVStMZnVSVUJnVnhMWHQ3cC9tR0hCWGgyZ3FYbGxQZmxDNnpXRnEy?=
 =?utf-8?B?KzU0SGlHWnV1OHlxN25EWFBTVWt0ZkUwUkRmZGl4bS9QYTNRNFVxblBPTXRC?=
 =?utf-8?B?NGJBdEZUSXVTNTViUUNhbU5iQmxhQnZEaVR1VjlPT2pqcHUydkV1TGxIQnd1?=
 =?utf-8?B?K2htb29SSEZLUU5tTGJzcmUrclRTemswS0VYV2JDWG5vL0wzQWNsZFJqZlVP?=
 =?utf-8?B?VUlMQW1QS1REUWp3aHhaYU5xUTlSc1pIa0RCaFFPdXQzbjhTU25zS09sUXIy?=
 =?utf-8?B?Wk5IcW9UMWYxTm9HK0ZOaFp1TTM2ekpsWE8yV2d5MGgwV2JRSmNiZEUxS3ZM?=
 =?utf-8?B?NnFUTG9PbzRZY1phRTV6QTh3UlI4WTBtZE8zMWtjbEhXWGo2b3hxRUtoR01y?=
 =?utf-8?B?WjVGeHpUdDZ1VTVhajRwRXlBZ1Z6NHY3N1NaMnZmanU4TlBjQXV4MHhndi9Q?=
 =?utf-8?B?WFdJbzVHb1dUTXpDd2lmMnNNOVlyUWx0U1pXYUsrQU9SK3VOTTFEUUlUQ05E?=
 =?utf-8?B?ZnZXV3d4REg1dDBra0s1VEU2VGVtalFMcW9LN3pDZ2I1aEJZUjVVSEc1Y2Yw?=
 =?utf-8?B?K3pKTGovQU9ybTVCMnRwT253Yk9EZmRnZCtnSGhDQkNWQ2VYZk0xQ2xONHZz?=
 =?utf-8?B?ZWxSTGlVd0ZlTkhGdmhqMGcxWlFzUG9GMVZuOEdsbzJ4MmJvRS9iWThXdXVi?=
 =?utf-8?B?V3piNm9PWjhINVRGRGN5UWVSWG9STTVOOHhUMTh4WWpISjVldDBOdmRnU21H?=
 =?utf-8?B?djhmWU1XU0FWQ0czY1pTaHI0NVpSNGtaaTVOL2VGcVdGaGdqU0RMQ1poMnFo?=
 =?utf-8?B?N3dCN0UyZGFpVXVSNFZzZW9WSGthKzIyNm1DamlYcGJZTjFRREhLNGduQzVp?=
 =?utf-8?B?cWUxNnhWVmZHMTRQM0dvWFJCQ1Nxak9oWFduWUM3SW9UOUpyTXVMVkdhTjFS?=
 =?utf-8?B?L1VidjQrRDkyOTBnWEI2RnZBbmI3cWRxNGpSTUhaZjJRY0JxYVN4eGVGT1dP?=
 =?utf-8?B?N25yRjFidkxsOFVFMmZDMmRTbWc4enk0UEZMRjQ5ZDNRWlVjdk5pVWdkZ3ZO?=
 =?utf-8?B?SHhQN3hHc1BKNktNUGN6eTdRMndxaTNQMnpQQ3BKd3k0aWdjZWNyT0hJTktw?=
 =?utf-8?B?ZG9SNWhnci9Qazd4MzZoTldENTNVU29xOWZ6OWZwT0ZEWnM4blc0ZjhqN3ly?=
 =?utf-8?B?Sm9CcUVvNG1oR21iUVpJdGpoa3hJNTkrZmN3MXJORzBxZ0pWa1FPNTl2WlFU?=
 =?utf-8?B?bU1RSm1zalBGUUdOWjIyTDNvaDQvMXZSUjE3TVJyd1pVeUw5ZnZhMUVJMXFt?=
 =?utf-8?B?N2FGK3l2YVJUZmVmU2NoaDRKbFp4ZkVIK2FuSFArcXY5dmN0VUIxam41NnYr?=
 =?utf-8?B?Y0xvc2tYZzViQ2todSs4L2taeVkzWXAxamZoSThLcy94VkR5NFNzendXY09E?=
 =?utf-8?Q?vy0MhkuoSJA0H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzVCZ3JBRU9MSXhZeUlUekhRdjZ6WmI0amhPSVp4aHJYcExCRDlwSkw0c2VT?=
 =?utf-8?B?UWtvbnVBTDZmc295UWdGRGFNSTAzRjR4MzZOSk1vN3Jxd1RFdUI0SWhDcW5V?=
 =?utf-8?B?YUd0QWd6aEJpYlBxdDhwWHZKTEtGRGlqMU9HTW5GdDRjNGovYXFEMUJWaUV6?=
 =?utf-8?B?MXN4L3dYZ2hKVHYzd1YwYk11VzBvcUE2di9xNDNjelJNbkU2R0w0aU9FVHU1?=
 =?utf-8?B?TXZDaHNESTBzbCtqVCtISlVtanh5NktqNm43d2RPb3FNMTZlYzNtaXU5QS9p?=
 =?utf-8?B?LysrU1hRWHA1Y0pIMmtaTE9oL2tXR25qQUpFY0FWWGtiVkp5YnVHUks3RlNL?=
 =?utf-8?B?M3hTRUdEeEVtWHU5RUk4Q1FNNjFQTElyc3NYVXo0YlVOZVJod3hXZGN1RFpo?=
 =?utf-8?B?RkYwaU9kQ05WN1lLS2lIWHpGQlVmSWh1RFU2cnU3NGlHQjU0OWZoanc1SWov?=
 =?utf-8?B?RzczT1c0SklQU3VnQ1RNRnJBNUhHZTFqNEMrbzdtbXZXbUt1bVhxMGV6cWZB?=
 =?utf-8?B?amd6TCt1eCtLdjcyRGVHajhqVEx5cVkweGFQVWcvRWhYWDZYRWNVS1BlL2FR?=
 =?utf-8?B?V2gzUlE1bGpUd3BQWmRLV1E2Qk8yTlhLWFVnMGJUK1pTendRNnIyc2YwY25N?=
 =?utf-8?B?UnlzT1RuamVLQWo0NGpnVDVIUXp0eENvTlpRY25DbEw4UDZKOG12SU9pTDda?=
 =?utf-8?B?b0toMFMyZm1iS0VJSXVVcDVRR2h6eFVucy8yTGc2T0tJRWdwNk40YmpPemJm?=
 =?utf-8?B?SlhWenRMSWIzdjJNQ0trWEM3WkJOaVJGRndVS1dra1VYN3FkSGRyQkg4UExB?=
 =?utf-8?B?NkRFbDd0SysrTXZuRWl4Nm82VUUvMGFaQjZWSVZjNXZWdzY3V1dJbnB3Qjdx?=
 =?utf-8?B?bVZCQlljZ21hR1NmVU83dnBBU2NKaldVdHJ2b2xrY2QrTXFmWlZYT3lTZzcw?=
 =?utf-8?B?akZFRGZXQkEzUXhtdmtVZ3lkbjhDK05kUWlMcUMxY202Sy9FTldva28yei95?=
 =?utf-8?B?WHR0c2hWNmJnYkt0cnZqZG02bkJLYzRPUElXa09oYVdTd2RuQTdSN3VTUTBt?=
 =?utf-8?B?cjZYYjVneFdEYnlhU0J4d1pONlladkw4Q0lnQTYwREhuemtkb3p2VEtuVS9n?=
 =?utf-8?B?VE5VZU5xYlBZNW1xa0s2d2Z5VWZTLzIwaUhjYXNUb2VVVGx0eE9yK2FjV3Vu?=
 =?utf-8?B?RFM0dXJTT3pZS1hnbEpwTkc3MnR1MFllY3NZYkJDa2FnbjlFT3prckNWSDJN?=
 =?utf-8?B?UnFDZXZPV2FwenF3eTg4bHAzWVNZeGVHK0FQRll4OC9nWFRHYUtuUWlCMDNx?=
 =?utf-8?B?amU1N05qZktrZmR0TUxtMDhLQ0lQS3h1MDBxTDdjNkJFYjF1Tk94VGw2MGtn?=
 =?utf-8?B?dHlQV0w1QWZxZFlsbHkyYXJWWnFLclZxeWM2emRlL0U3SEpnSXd2K0QyNWhQ?=
 =?utf-8?B?Q2k4NHk5UGFCQXBqMVFxUmUxam5XWmFVYzFNaGNIb2pvTkU0ZUhuaGN3RUh3?=
 =?utf-8?B?bWpZWVlBSDNxZ2I3SnR1dDljdWhjWE4wbGh4SFdweTBJMm5RTmxLZVFjc29Y?=
 =?utf-8?B?ZUV5TEZpMGk1RWRmSEJvdU1oV3BVS3g2c1FPaEo3citPQUhCUmxrWEI2Yjc2?=
 =?utf-8?B?WXA5anlyVTcyWDZhVWRwZnVSRkxiaDFhcVoxd2t2amlFVWdLd2RhTkdkcHFW?=
 =?utf-8?B?SCsxUTRvRC9XMDlsYjRqWExwSnRaUFpEVlN1QzlaNXpYZ1NWMjdHOS8xMFQw?=
 =?utf-8?B?bko4bmpPeDBsZmJELy9KLzBVK0syV0R3VFZIcXlFU0FFbFgyZ1lONDNjSE9X?=
 =?utf-8?B?ek5DNk5nM21abDF0VmZpTGh5dkRHSzhsS1o0bnFnZmJVQk5vRVhWT1dvbDZ0?=
 =?utf-8?B?V09WT3ExclQ2T1JoZ2R6TjNnTW83TTNVUkppdkI3TGxqbXZIOVM1SCt4aUo1?=
 =?utf-8?B?WlcvZDZlSEVLaGxsQ1ZTeGJ2NmpDTTduWEZnNjFjR1hsK3RlNkI0ZFpFN3ln?=
 =?utf-8?B?Q0QxZDU4NER1dE5mdHBxd29kWERUaXpFRVRmcXlCTE1YVmtjQjdPMGdBeXBD?=
 =?utf-8?B?a250V2N0NHBHL0RFcXdXbkNERWJoT1pyOWN5OEdxSGtiUDhmK01Bb0Q4eC9H?=
 =?utf-8?Q?tLZOrwZbqkf/NmMs4/H0BOWhu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3yhln83a9lLkKIP9kcfMh2uxfUONoaN2WzuP+n5NOA0WwTS+6O47QD2YM6KdYfwa3KYgr78a38e0qzW7/BgmIDp8OO8NH5XMmqwluiztEPHbHR7Uzel74L4rOwfwW1YsGQEauO3WcNt3a7CIMoas9EmmpiShOT5XsA/FJOdpFWKiwXF0BwzswlUGZs0mMPIRBXkwqFNL60HNc+eXoibUUEJsgHkoqY0D5a3zWt1MDn+OP1YXMrQB4SIA47/tvEBl3HPzsklBHDr2Riv/ZPPADB+A7DUnoHxjDeNzi2vqMoKpOAQxsMuc6Rn6PU+CXo9ycdk0lI9cmZC8Bydscc2DbcKmFeeAyhSrzkp8x5Svz5cfHUmwtrY3ydHemk1jJSy8ihmEXOlq3+C3mRhbWvZ12BcM3kUCtDVVNf6NFqcK7No4SBfCyThNCUbzlxKTKYi5XXhGQT4fluFTqivTUXj+AYAe8m8eLtrkh+PYmhoeMJ/9q8qQmXOjmNkc3ZxbXjvyVZYbZYCEa733dH4ROaPK3L8YJf7VJklh2gaPcVEG/7fIIkA2zVLw7nU15nRD31mbKvMM1ChknptZucEcDp6lGVOH/aCBUwxK+nZV9IOiALY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8826ba05-1351-401e-0b05-08dd67333845
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 22:13:04.4233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4ctEqJSt3GW5PZCYiff4XLV3k897jQ9CWgPzzbhbdnd/mwIIwOujHlZIfAxdegbFvc+QVVHvrHLmA3Pk211hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5704
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_08,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=982
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503190148
X-Proofpoint-GUID: EdsVyBUARcrj2bTsswHD0jGoN1U27aBs
X-Proofpoint-ORIG-GUID: EdsVyBUARcrj2bTsswHD0jGoN1U27aBs


On 3/19/25 2:46 PM, NeilBrown wrote:
> On Thu, 20 Mar 2025, Dai Ngo wrote:
>> Hi,
>>
>> Currently when the local file system needs to be unmounted for maintenance
>> the admin needs to make sure all the NFS clients have stopped using any files
>> on the NFS shares before the umount(8) can succeed.
> This is easily achieved with
>    echo /path/to/filesystem > /proc/fs/nfsd/unlock_filesystem
>
> Do this after unexporting and before unmounting.

Yes, this works!

>
> All state for NFSv4 exports, and all NLM locks for NFSv2/3 exports, will
> be invalidated and files closed.  NFSv4 clients will get
> NFS4ERR_ADMIN_REVOKED when they attempt to use any state that was on
> that filesystem.

In my test, client gets NFS4ERR_STALE for the PUTFH in the GETATTR compound
which is expected.

>
> (I don't think this flushes the NFSv3 file cache, so a short delay might
>   be needed before the unmount when v3 is used.  That should be fixed)

Thank you very much Neil!

-Dai

>
> NeilBrown
>
>
>> In an environment where there are thousands of clients this manual process
>> seems almost impossible or impractical. The only option available now is to
>> restart the NFS server which would works since the NFS client can recover its
>> state but it seems like this is a big hammer approach.
>>
>> Ideally, when the umount command is run there is a callback from the VFS layer
>> to notify the upper protocols; NFS and SMB, to release its states on this file
>> system for the umount to complete.
>>
>> Is there any existing mechanism to allow NFSD to release its states automatically
>> on unmount?
>>
>> Unmount is not a frequent operation. Is it justifiable to add a bunch of complex
>> code for something is not frequently needed?
>>
>> I appreciate any opinions on this issue.
>>
>> Thanks,
>> -Dai
>>
>>
>>
>>
>>     
>>
>>

