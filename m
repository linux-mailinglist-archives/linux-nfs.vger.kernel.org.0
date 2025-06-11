Return-Path: <linux-nfs+bounces-12325-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4EDAD5EA0
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 20:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054DD1882883
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 18:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEF626E6ED;
	Wed, 11 Jun 2025 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QIjRGklC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QyLuorVr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6F26058A;
	Wed, 11 Jun 2025 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749668079; cv=fail; b=EFi7tGtlK63OsPF9CzWtwhgYcCFgZiRaKISqXuFxJFIEgvyjpDXsiYEnXjGM40BM7Vh3ARF910tjQkDMtA8c6A1xX/x2/EGZ/Cs872IpFcKXEnDV3sYG5Qth1SVxtlilt6FbgtmmlrRXoObtGssPSkr0QsX/P07rFUTzYx6kAWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749668079; c=relaxed/simple;
	bh=zQV/B8kN5Kr91f4vskB8bkKYpy95V7cqBNYkUEStvXc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XuQorcWS4p70LoXQnvfCM7bA6ultOXHwiXSlGhzdaLzgpM3m922tuKe/9Pfe+eW5/tnj3PmGOuxalBg9NNSYHjxhi97mbsNCSt8lQddCvKDYPs2giXMJGrxpteTqJValvdfWyybz1hJ7SEIHgpqrqRUoeDCquMgxGevtMTtIdsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QIjRGklC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QyLuorVr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BEfZvP004610;
	Wed, 11 Jun 2025 18:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8EtWe3HZiuoqlSMkuA823r56VdsfxgeRZTghKGh0TC4=; b=
	QIjRGklC9REJz2uZ0pZ5xNlOHOfUHJPoqr1ZgA74PY1BPTNjshVFdMCf4xcyra/X
	HKkPwtg5fbPSJ9rHJJKHjYhN9QeGmyye0VktRpdIsUEChpj/EK10zQYURqmhpC72
	QGeUCl+dqCLAu3jtDUkhyryOc0AXdz5Ul1K3cLKbxy55BWqtzTRsNbp5a5OB8HEZ
	CUezlKHQ+DpUNiCa1UwOOM8ghf5eIzjZBaGiXboYkKxK28qJwZaDZoUiPUeUT8Ya
	mUx7dvLHJmcw/Uw3V8lroRqlvBMmIlZEoWDAOxuIKp9XIsLvuQO+z2+EaDB9fzaQ
	IwIJOGp5wpDckTLuzudnPA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dyx0dhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 18:54:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BIUNgD007382;
	Wed, 11 Jun 2025 18:54:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bvabtym-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 18:54:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJDqQNkGN+684XRITjrRBkSdLzmtktRGTWjIjD2MxiLP0+nsovml37OPQYIPtsGdJjXVaU2zvWmD9aoOnZGFFJYcpcZvqEMeYskhRYb3nxoQCInYxw9xAd4q5AGGtUmV0BFa0FB92pID4ZylJv595u8+7xW5HjqbSGi/TewPmyr76ljg/nJ8lNbXY4u6a13cZ5PM6wxELgW6xow2wOOqobKUaA4ZfIJOSRF700oDMGH3icAX6mchfKz1dZ9KrdTfIvNuq+YMW2Fx0sQur4LyQe2EEu6sp5w17DSEa3lU+1qmE0NUWp1KUUjE5UcVT5ME+6gevtn/Ff8kIigapCkSMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EtWe3HZiuoqlSMkuA823r56VdsfxgeRZTghKGh0TC4=;
 b=WuVNmc5pq0mHeg6ixy/oAx+x2hP5NrAnhrGVgrZTTk+P5y33cj7ES4PdyVZ5IAcbMpUttQVfYjV9TkyaX/IfdwMFCuQ6+ROtkU6wGjXuazu64gXR4uwnY/v+oAj5wgjNAyGV1Vt+jwRIPGAkfvSGMpO2ZobeodMYessJbypsHEPVxlUdsMlamD8AkGNY1qaxYqwnbJhXXepPLuLO8Qk4Exa6+Wd3Orw4xcrPzbiXIn+rB4GsBrdl1ehK8BDpro4qOWoavUgYkr9+JwPJalB3R4uMOanK2u4byQzKKqSQbxmN+ZZwqiluMRbXhl1ZcPC2hF4AV6gOZaCkeC67895k3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EtWe3HZiuoqlSMkuA823r56VdsfxgeRZTghKGh0TC4=;
 b=QyLuorVr1jFHls1hMSPG24z+Ym4U2tcHWBGvQ+e9zOBxr8YWxr4kvE+C2c/tKBfkgj9oOaAY3hy7SyX4fpSVGnzR48V7IAHA6opcWWAK8JlKhm89P4leHmEhRuizcd5X2qe3IsKYS2KFjbqHKiUdUtnCBW6PNzs1slQUtyN4mHo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5649.namprd10.prod.outlook.com (2603:10b6:303:14c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 11 Jun
 2025 18:54:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 18:54:11 +0000
Message-ID: <81cd5e1e-218d-4e24-b127-c8d1757e4d99@oracle.com>
Date: Wed, 11 Jun 2025 14:54:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] fix gss seqno handling to be more rfc-compliant
To: Nikhil Jha <njha@janestreet.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250319-rfc2203-seqnum-cache-v2-0-2c98b859f2dd@janestreet.com>
 <d78576c1-d743-4ec2-bf8c-d87603460ac1@oracle.com>
 <20250611A18503192e946d6.njha@janestreet.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250611A18503192e946d6.njha@janestreet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0314.namprd03.prod.outlook.com
 (2603:10b6:610:118::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO6PR10MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e3e72b-9c59-440b-490b-08dda9195a69
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?amJyVTRyRGhDcjdCK2t5eDRKMkVYa3JHN3hlQ2xaOFZQbmpSbkZmTUQxOHh2?=
 =?utf-8?B?Y2cwdDlPVUw3RmFSZlZOVHBYU1JwbHI4R0dMcEc1ejB6R05wdytPOXhFYklF?=
 =?utf-8?B?ZlFJT2daQWdNNVJSckx3aTl3Tytxa2o0RGE0OWl1NzE5NDNSQ2hzU0lQdzlx?=
 =?utf-8?B?UHlUU3cyNjlWSTRvM3lkTURlaWVHNTZiVjczOHRtbXRaZHNmNVdyQ2ZNMEVm?=
 =?utf-8?B?eE51NWoxaE55TkNVNUZpMmFXc1Fnc3BCWnJhczMwQVdhcFJ6L3M0cHBSS3o5?=
 =?utf-8?B?QXVRYkh5YXhYWUJMUGJhejZ5Z2VteVhabjFjWmt2NkxXOGhRbGhXa21sM05P?=
 =?utf-8?B?YlljN09iVGxneU1YVHRGNlVQdkRzM20rQzNWYnNSWUZsTy9LLzdyVm5JUHVU?=
 =?utf-8?B?Z3d0bE0wRzhZcDJVNEZBQUcxbUVxMVB1U3FvVnpVS3hnTXRpZzdoazhZTzhW?=
 =?utf-8?B?RGFxdldFVkxLUHVON0QwQlg1L1JHMmhtd0RDWVNuL0ViaXF2MG9UMlJ4YWt0?=
 =?utf-8?B?VFVZbGtWaDVGbzRCb3d6bUNpUlRvNTV5cmpsamFvWTVRQUJMNno1MWpFdDEy?=
 =?utf-8?B?Y2p1MmdPa2NieEErQmVZRk5YSm9zcjZsT0Zvdit5czFSWjVkdllYa1ZtK3VP?=
 =?utf-8?B?aVhRRFJyd0UwdDBiMXFYSkJJS0NqeG1oRE5wd0hDR2xVWXJUR3BReEgzQmlK?=
 =?utf-8?B?UXNIeDRXRG9TL25FMXppZFpHRGtCQkF4RlkrcFVWWkFIcnM1UVQ1MWQ2STln?=
 =?utf-8?B?VDM5b1M5NC8wMnpBeS8ydGVRQTdjQ3ZmbkZnZkMrU3Fhekg4aU1qZ0hmejFK?=
 =?utf-8?B?d2hkTUp3cXR4RlZ2ZVlRNXVwMStQUDYveXJvclpUdk45NVdBSnZpOHF0Tys1?=
 =?utf-8?B?VGdDSDdxZk4yTE84azhkYUkrenZEdFBqaURUWmpyZ2pBcnBJaVJzZ090TUNW?=
 =?utf-8?B?a3Vib2N3QUIyTG1EUTUxcEE2MCtBVjB3MDJPZlZaOFhndG9ic25oeFM1ZERv?=
 =?utf-8?B?ZlJ1S25yV1dqYzlTZmFrTXg0S3pJTTlnNG1uT1hqYzhKV0UyZmV5Q2lXWnFz?=
 =?utf-8?B?TDF3NjJneG8wdkd5Z0RjY2V5SjJlUml4bUk4U01FVDdFMjNuSGo0ZGt4RHF3?=
 =?utf-8?B?S3I1YkJ0Yi92eVVVTXhhS3pveldhNmNtKzJvWHg2RVhkdDdSWm01SUp0aEgr?=
 =?utf-8?B?Q2kwNEl0TXlXbnNqR0RwUEZYOTRWTjZaVmRjS0NEYitUbEo3SytHZXlTK2pQ?=
 =?utf-8?B?UkVpRXY4R1BNWHVkSnZxeTRIZE9pZjBjT3FhbUc1TzdBeDQ3aUN4Mi83Z2FW?=
 =?utf-8?B?THhUWW90a1dBTU9TL3dndVJ2dkYxdWRZczVzM1ZnTkV6V3ZtRERHSmNGdVh3?=
 =?utf-8?B?dWx3K3oxajBoblRYL1RnSS9wSmhqYVIyQm01b3QxeHNwTW9wU3VIalJDZW1V?=
 =?utf-8?B?SVRTb29WOUhWUkczSW1rU3lYOEJZbkh3MlMvcnJjSW4rSGRoamJmWUYzYjBx?=
 =?utf-8?B?RFRaY3RCQWdDdi81NngxT1d4aGhHZjNRMll2VS81T0M1NnNsNVNkNWh5cXV5?=
 =?utf-8?B?d205RmFWcWloVEVMSEE5NjlNUVdXQloxTFpsZjN6S3ZIeXB3L2x2SlV3YU5o?=
 =?utf-8?B?SFdYNEdENFhOVkxnNHZ1dlg2Vk9Hc2RTNzJMQnJ6Q3NNK1pJUUIvbjRIRHlY?=
 =?utf-8?B?YlNRRm9lZTl1ejlPUUhjMUNpc05oSkpkNUMyR3AwdEptbmVSMXlMY0k4Z0s2?=
 =?utf-8?B?aHpQNnQyYnQ2aXY0ZTBnZGhtNnBFTHI5cEdja2FaVWtLT2xreENCTC9uWWJD?=
 =?utf-8?B?bWp3TjVyOTc3TnduL09CSE5JZjh2SjdrcmRrQnZrTFQ4bFZQTklKbWdJYk8w?=
 =?utf-8?B?OFZVQXlGQTlJNC8rTk93NTU4dnFNMTJFRDVESjh0R1huczcxQUJNeXNxQjFH?=
 =?utf-8?Q?RsnAxZtK+Pk=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZHZ5N1lCMTF4Y0hjVFNmbmFWVFd3clR5UGZDeTM1S3luVGVjQnA0emgxejIx?=
 =?utf-8?B?WEVHbTNXY2YwWEttRURjQXVka2ZPSkkvSzhjUUFUbHIvK0tpa0JyamtTMUJr?=
 =?utf-8?B?N0hXcWIzRjRtVXNMTDZhYXNYNnU4Qjdadjh6d1hYNll5cGR4TXR6aVZRZlJm?=
 =?utf-8?B?UU45TW5GWEN2cHlPbzRIN3RZSmtaRDYyMDJBdTJjbGY1NTZPenhFSnhCemVh?=
 =?utf-8?B?ZGVjRURYT2FoVTIzVEcwNTZzM0FrdldSVFR3YlMxbTEwb0NIbjlXT3JaeVFR?=
 =?utf-8?B?ejRQZ1JZNzhDSkRNbnBIckY3c05BYlRuMjMrTExYbm9XNU15T1JLL2JoOVJJ?=
 =?utf-8?B?bnN4b3BFRFd4YjRySjFiSWMwK2ZVakxEUVJhbFZUdFo3KzBrQ1lLbmlibEg5?=
 =?utf-8?B?d2xacEUwQWZRMTRTWWQ3RDNQSG9IZzNScVMzSFVFUTNaRzE4c2xGOVRYSklM?=
 =?utf-8?B?RmlYSTRwcEhhZkdSSVpiWDM3OWRvS2o2Zy9jVEIvV1BmZlhzdEZKdGV2ak83?=
 =?utf-8?B?RkUwWVR1UERMQkJUb3plRW5kMVNNaFNCQ09GUHloUitSWEZrRzU4ZGU1TnZs?=
 =?utf-8?B?WlE4dEtzd1JScDRDOFJVNlNTc0tmQ1ZianJpOFV0RjE3eSsyTUcxangyYVVR?=
 =?utf-8?B?d2hROGxWTDRrd0pZUFMyT0RqNnlUZVZoNnpscmh6dE1SaHdFZkxpek56RG9j?=
 =?utf-8?B?WkJYalZ5K0VBN2g5TGsycVNIVVV4SlVsWDEySEs2ZS91NVM4Yk9wUmR2b1Bv?=
 =?utf-8?B?SGhwVGFHc1VZSUFKUS9JVWdQMVFyaThMYmtYeTBTcGNEQ3BWajREWm1YM1hF?=
 =?utf-8?B?TWdHTHQzVlRVU2tybWdkeWRWVFlDVDZ0RFE3dzJaUFVWczJ1N3AyS01EaWdF?=
 =?utf-8?B?eVJoSFVxUHFTRkYyUUhWWm4xelNvUGdOUjVJYkw1Si96OHBTT1ptMS96MStI?=
 =?utf-8?B?Y2NxTmloa1NjcFIxRlAzY0xjczNJMkwxRGx0bG0wSFozcUo0VjNtcmQ1djVo?=
 =?utf-8?B?ZjNyd3Q4cjRnQnpoeHRXN29mVytqSFkwWUduWXZuMTVLdDk1eHpkNUp6NUFX?=
 =?utf-8?B?TjkvVEV4dS9qcVdlYkxqR0pVQkhVWmtPYnQyOFl3S0pKS3lmSTc4cFJhMnl5?=
 =?utf-8?B?alptbVpFR3N2ZjhzUHgyZ3d0RnFOQ0FkcFptV3daUENMWEVqcjhjWlJ5L3pt?=
 =?utf-8?B?aE9tcTZOOThadFZBVkJGYkpiSTBjZW5xaktXZXArdWxFSStUUEkyQTZLK2ty?=
 =?utf-8?B?M1pBUEFERHdxQzJSbVJBRXBqaFVSRUJQSkNKbDV3aEFkY0V6QmdUaHlSZ0tZ?=
 =?utf-8?B?Nnd1VDQrbytjbWNRMS9FSDQzRndtOEQ4NjJvc3NUVFB6RTVQRVYvWjhQQXZM?=
 =?utf-8?B?Yk91cXB5clpTRVdCM1QrTFh3ZjF2MnZxcERqbml0OVUreHVxMDQ5SUVRVUFM?=
 =?utf-8?B?aDMvbmI5bUM1NEx4T25CNlowS1NRdTV3MUFlQjROSmRacUQ2eVpkTlZQdkhP?=
 =?utf-8?B?cHdQOWxEcXJsZUhaR0xmYWhzckJQYTBlSW1PcjhHWEMxNTBOVFhWT0U3Yk5K?=
 =?utf-8?B?RWExRThyd0c1bnpJQ2kwMTJPS3ZtUHM4ekFEdXM4YmhybXNUNkExQ1N2dVFW?=
 =?utf-8?B?enNqN1VOUzZSNTgyeDJRcHpVczhuZ1MzLzJESjZVNEJCa3FwdVVrdWNlMHZW?=
 =?utf-8?B?SFVhWlZ1STdjUVBzWHVXaUhLeDgycElBMURDRmxVRzU3cTlHb2VhWTdpbC9J?=
 =?utf-8?B?anNya2s5SzdjeTVHRHhtQnRoY3d2ZW51MjFrVlJTTG1pdXFCMDVZYXVHbytq?=
 =?utf-8?B?Qm45eGFKQ2JCSVZVR1FCVDN6NkVEcVU5M2FkOGJuSVdjajhnZG9CV0ZtNWpZ?=
 =?utf-8?B?eEpBZkgwODdkVHE4aUwvUmNPWkkyRkh5WHJkeDNCMWJRVUh0ZllJbGNZUVUy?=
 =?utf-8?B?M2k5SHoycURaNE4vTng2KzFSMGROemVXV1UzbXcxRms2OTlPelpQdWI3Y1NJ?=
 =?utf-8?B?cU55WjBnZU9mVXUrNkV3UTk4bnBlRHBNUTR6bkNjdkppcm5xM2kwelVXZ2hm?=
 =?utf-8?B?aTZtKzNuTTh5NGVDR0NtODlhcWNyeGlOT08wU0cxSk9TckIxZVVDaUI0VzFG?=
 =?utf-8?B?ZUNnUXUvZUxKS1NjeWEwM2MvSkMzRGZxZDJUVEV5akZqQ1I3M0ZoOWVOT1dY?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z1tl9Tg3jZrQRuax3hXd1jbj2FtuyYAdfTQxhbYEQ/cvrHVgFjXu3d44nPyxq9UdyyYntnQSp3blf4YyKdPLGhboAf7WF3fKZm2xRGmsz3mooMZ47VhT/XcSkJ2bkNA9ALJatP32rg/1j+m6+GsvYS51+l8P/vICgVIvCLJpYkNRmI6f2szJIN/omSqjx6110K4oVa2nKejaWbrv54b7nH/WFV53bkzvduBfkg5jYMrxlh/RKWnUtvNIh70gTSP//iNSvrjSzsJXoaLlEXB+TweBGtHyI39aBHhIF+ITtLgGy/G3zwPufIHjZnfCrbI+MMto3stexbZHaXHhNKnmzDDtTFhtZ5QIjC5MwAXQ6LOnkn8+6ac/lzERw6OsKvBrLr8bof21YQ2HSqTBG3JTAikQk7Kqj5PM6jiV3RBeNqeUoyN10QyXnk+343qQvZA93mCGbY+GBZFBLZTIORXNuEHhNaNbIvNYKid/u9aBle87eWypM1xcLfqn1+QnRyT/Bt589WMFHUkkpX5vVMXwuOjPJInIzQazPZCQ9sq9ISAIIibEHrcIk7IRYXtd/vNTGPD5mXDflDTehAZWXG9+3kKCl1NKAZV87liIDvCI024=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e3e72b-9c59-440b-490b-08dda9195a69
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 18:54:11.4340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TKJ3LlFtXnLb0odyIex0oAv5wEa8AXW8qsOoXogBy2emaC+Yj9KsHqO9bfsU12G2hl1O1FFS8M6yakyubGPFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5649
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506110159
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=6849d0d9 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=h6pNz4pCAAAA:8 a=yPCof4ZbAAAA:8 a=HhbxCqujKRu__zX7uJMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ZpoZn5rNyLF8gW58NSEC:22
X-Proofpoint-ORIG-GUID: eN8IP2pRNc_Sysu5RpsVybTyLxIrsjjf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE1OSBTYWx0ZWRfX1nN5OtuqosVI bRvH+1Sesk3mawh4x0NZsjvTOx1lsB+Wm5Ag/qVMzYogoIO+1ofNRYFYiIpQhMxNb7j2bZXuQB0 vRaK3nX5XFHxnxKZCPsrd71dd7I6LO4WUNsS0izut9T4/JaCQEB0jSHozYu26o39wdt33vgj1OK
 GQKjNpZ9gKK+RX05prR4g+gbRiIpohc0bvwz4YosWEiUE0YQaltu5VXhXBMlcKgMt+fR8GhrPWp zLAal8CZNpe7l0RmPGheswU5ZrFXSGefUReYAJ6l55/4KKseSxkN4PQ/8tUPL+3/+7I/HLYWNYY S+j1Rf0H24VFvIYEHB+SxR3Nn6YVDlIrqOYL/feis777FmuChCdMKpE8GvqW1vM/FS1MNLbzrgl
 oGPGWrDRLKaVlELkjSnUJuYmmPdY5V9hPguNTUB8AIglMtd6ZLw5U/xzqfwgzu6Tur8v3mOS
X-Proofpoint-GUID: eN8IP2pRNc_Sysu5RpsVybTyLxIrsjjf

On 6/11/25 2:50 PM, Nikhil Jha wrote:
> On Thu, Mar 20, 2025 at 09:16:15AM -0400, Chuck Lever wrote:
>> On 3/19/25 1:02 PM, Nikhil Jha via B4 Relay wrote:
>>> When the client retransmits an operation (for example, because the
>>> server is slow to respond), a new GSS sequence number is associated with
>>> the XID. In the current kernel code the original sequence number is
>>> discarded. Subsequently, if a response to the original request is
>>> received there will be a GSS sequence number mismatch. A mismatch will
>>> trigger another retransmit, possibly repeating the cycle, and after some
>>> number of failed retries EACCES is returned.
>>>
>>> RFC2203, section 5.3.3.1 suggests a possible solution... “cache the
>>> RPCSEC_GSS sequence number of each request it sends” and "compute the
>>> checksum of each sequence number in the cache to try to match the
>>> checksum in the reply's verifier." This is what FreeBSD’s implementation
>>> does (rpc_gss_validate in sys/rpc/rpcsec_gss/rpcsec_gss.c).
>>>
>>> However, even with this cache, retransmits directly caused by a seqno
>>> mismatch can still cause a bad message interleaving that results in this
>>> bug. The RFC already suggests ignoring incorrect seqnos on the server
>>> side, and this seems symmetric, so this patchset also applies that
>>> behavior to the client.
>>>
>>> These two patches are *not* dependent on each other. I tested them by
>>> delaying packets with a Python script hooked up to NFQUEUE. If it would
>>> be helpful I can send this script along as well.
>>>
>>> Signed-off-by: Nikhil Jha <njha@janestreet.com>
>>> ---
>>> Changes since v1:
>>>  * Maintain the invariant that the first seqno is always first in
>>>    rq_seqnos, so that it doesn't need to be stored twice.
>>>  * Minor formatting, and resending with proper mailing-list headers so the
>>>    patches are easier to work with.
>>>
>>> ---
>>> Nikhil Jha (2):
>>>       sunrpc: implement rfc2203 rpcsec_gss seqnum cache
>>>       sunrpc: don't immediately retransmit on seqno miss
>>>
>>>  include/linux/sunrpc/xprt.h    | 17 +++++++++++-
>>>  include/trace/events/rpcgss.h  |  4 +--
>>>  include/trace/events/sunrpc.h  |  2 +-
>>>  net/sunrpc/auth_gss/auth_gss.c | 59 ++++++++++++++++++++++++++----------------
>>>  net/sunrpc/clnt.c              |  9 +++++--
>>>  net/sunrpc/xprt.c              |  3 ++-
>>>  6 files changed, 64 insertions(+), 30 deletions(-)
>>> ---
>>> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
>>> change-id: 20250314-rfc2203-seqnum-cache-52389d14f567
>>>
>>> Best regards,
>>
>> This seems like a sensible thing to do to me.
>>
>> Acked-by: Chuck Lever <chuck.lever@oracle.com>
>>
>> -- 
>> Chuck Lever
> 
> Hi,
> 
> We've been running this patch for a while now and noticed a (very silly
> in hindsight) bug.
> 
> maj_stat = gss_validate_seqno_mic(ctx, task->tk_rqstp->rq_seqnos[i], seq, p, len);
> 
> needs to be
> 
> maj_stat = gss_validate_seqno_mic(ctx, task->tk_rqstp->rq_seqnos[i++], seq, p, len);
> 
> Or the kernel gets stuck in a loop when you have more than two retries.
> I can resend this patch but I noticed it's already made its way into
> quite a few trees. Should this be a separate patch instead?

The course of action depends on what trees you found the patch in.


-- 
Chuck Lever

