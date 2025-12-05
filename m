Return-Path: <linux-nfs+bounces-16964-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85356CA8F83
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Dec 2025 20:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03407313216B
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Dec 2025 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E60379AE9;
	Fri,  5 Dec 2025 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m3ynukfx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yrddgsZz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C353656ED
	for <linux-nfs@vger.kernel.org>; Fri,  5 Dec 2025 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764960720; cv=fail; b=XQuq6FImxyFIKGNLPDZywk4g1x/ry3bVkQIbxzBdcumYoSkLmkUkVUSw0TQ2DTMKSI2dA265v9QzcLzSMRp8bq9xjpjeMBj9eJTkQljQMVhJN/xsZ2nwE3LyYS86XLvXWc94GoaFSjX4sqrsBTvIbGwMfc8ozmIPNNl5hY4Y16A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764960720; c=relaxed/simple;
	bh=amhm8zxTfbHb3dB2urmMLmYLfZPgdPzdmXRYQlbqJgk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CWKEuy6w+99Efy+ckzkVvvpcrPwExtWoxqplhOaJAJXKtkuxjXa62G6iTAbwADClWTL/caskM3EHDn7Fq4QQCEGMgRuUkDbDzAohLUE9BS4TrHLIk1Cy+AkN4sb8rIfGkmEiYAH6JZ4bd42Z/obOKOPXIIJsC0DdFNY6MEG86zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m3ynukfx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yrddgsZz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5IZkbH498295;
	Fri, 5 Dec 2025 18:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=amhm8zxTfbHb3dB2urmMLmYLfZPgdPzdmXRYQlbqJgk=; b=
	m3ynukfx8FAkXyQF7v09QytpL0jdKN11bpiuJbeqG431Fk3yUdV20QlYGF2QqNKF
	NUq+Eb3uNnLDs852x/Kb+NM5nlhYckUvQcCpzwjo0WG2BzVPN34IW5D2syKjTKvA
	avc0OFgPLMUZAnEzi/uT89jjemwvzX+g/6lUnZf5TNQ4cJTULUeUzpMTDgRh3sUb
	fbP7xkFuXuXobIO5K8gmsOCN0uY8RyCjHkMGYBfJiIopr/PAsHrwzEcXTbjK0KhL
	xlJwGgdfJCeY97gV9BKScEVKpxr8fk2tG6flyJHMS3zh/jPmaNJRjPwMsi8cos2o
	ob2r7QAGipV54LTVZhRqLw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4av4td80ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Dec 2025 18:50:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5HkMBd040029;
	Fri, 5 Dec 2025 18:50:39 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aus9f8xda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Dec 2025 18:50:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1Zp7ucbth65G13zDUTsKIfrnxJkV/tNI6parOcsY4+/MVpe/VQuNllAasUTJTg5T3Z3HXpLWzBXpnD4VRcS+JTZgGBkL7RjXOtz5U6UhiaYhnnYMk6sL+Uqr8LWjKkbRyTPA+SYPSqknL2/uUiZtOs1r1pGOOWktkWblPFrOh6pSG4ho2QXqMj58lWoQOgckNL0KkCzF/tURPmFIdtiJO0Y1Sxn7QCkT7l838maB8DLim+cYf1bcjsQhxEouy8CmEf6zOLc+5xOc7ESKVIoMgXYykHHeS2pGJNSf4IyEIem9l64/f5rTw4A57c4Wai21ZAt06/Eog5GhLaMoaExbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amhm8zxTfbHb3dB2urmMLmYLfZPgdPzdmXRYQlbqJgk=;
 b=kIEE3LiMwYB9HLNP/j6OslD9fS+Z+BBR8CzXswdkCbuDMUbSXuJJKoRPrucW3UCeqcHhyqrtkjyqVhpXbwscST5vdY3/GgCkVUaVh60nhNqI6RDW5Ihwqyv/3/+N+RKLv9Nl2+/Oui23765fK06WjJtLGpjSRiLD7o0AagIREe9bZ3ZhmICG0sE/2v36dIgasrXm4RPzd7zrHrrvLrJGYEzw0W/FJSncWYrIyDCgKcaoVI1SfqDr7aZzeTRRxj39G4x7j1K6j7hryYYerzdGR/1zL732M+hrHXHhajEeWIMbLJrS1i/Xzb95lqtfQzBNy8Yr7C33IZALafNMHzvW1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amhm8zxTfbHb3dB2urmMLmYLfZPgdPzdmXRYQlbqJgk=;
 b=yrddgsZzP+VFBwmnCQsTQhcP2DxDtZKjIkkkpZ53OGL6LcgfJ1+o2w4DUFoR7u1Ms2/cV1FgpWE4EYhQMpnVq14IaShI8bV+NzZ+ayfGae0VDu07jhSWr+X6z4LXy1NFmx+8qHCZIzo+HwccpEVvgznkkrMyVpl/yLplZcOGfNQ=
Received: from SJ2PR10MB7618.namprd10.prod.outlook.com (2603:10b6:a03:548::11)
 by SA1PR10MB6591.namprd10.prod.outlook.com (2603:10b6:806:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 18:50:34 +0000
Received: from SJ2PR10MB7618.namprd10.prod.outlook.com
 ([fe80::480e:bc8c:36c7:493b]) by SJ2PR10MB7618.namprd10.prod.outlook.com
 ([fe80::480e:bc8c:36c7:493b%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 18:50:34 +0000
Message-ID: <1524fd14-f353-475d-9221-15bb4016ec3d@oracle.com>
Date: Fri, 5 Dec 2025 10:50:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: Can the PNFS blocklayout of the Linux nfsd server be used in a
 production environment?
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <cel@kernel.org>, Zhou Jifeng <zhoujifeng@kylinsec.com.cn>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <tencent_780E66F24A209F467917744D@qq.com>
 <5e1b3d07-fd80-47d0-bbf8-726d1f01ba54@app.fastmail.com>
 <aS6ChyDRx-hALj5V@infradead.org>
 <6b29d6fb-04e8-43da-bc1d-0e78572b5402@oracle.com>
 <aTKSMwu9RFGYfNoK@infradead.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <aTKSMwu9RFGYfNoK@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0025.namprd21.prod.outlook.com
 (2603:10b6:a03:114::35) To SJ2PR10MB7618.namprd10.prod.outlook.com
 (2603:10b6:a03:548::11)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR10MB7618:EE_|SA1PR10MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: bcdf4aea-6d0f-48f1-9341-08de342f2c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWJ0OHN4K2tWRkJSWHZ3NzlJMUtOZ1g3R2ZoTDRpWVhucE9ITjRkTk9Ed2E2?=
 =?utf-8?B?MjNSMFVMaXdZNERTbmZHOHcrVEk0bUh2YXlLek41SmxpWitJL0dYQ1F3NTA1?=
 =?utf-8?B?UkR3ZHVOdFVndVJ6SS9zSkJMekNiQ2p4V3NUUUJVWjh1Rk5qbHg4WktRTCtJ?=
 =?utf-8?B?N0ZrTjZhUFJZc2RsaElZMVRYV3VpeElDUEwzcC9JcG9sRnVJNlhwK1Q1S09J?=
 =?utf-8?B?N1QxK2gyQktOaVBFVlBRZE1HTVRVM29nMmlMTXpiV2w3bU1iSHU0MlJoQlQ2?=
 =?utf-8?B?YnVhckZYSlJ2QlEyM0pjSFdCZXUxMjROMlVRUmpzaXVpQ1hmUFNHY2tZcDFu?=
 =?utf-8?B?OUdmcnNpNGxtRkpqMmFSZUMzUEkzUUpjdDVQcVVGZ3c3OCtMKzJKZ0dhdUp6?=
 =?utf-8?B?QlJma0NYK05NNVNFOWJiVEpGZ3dpWkpQOFpuWWtpWSs0T3JVbHkwaU1obVN4?=
 =?utf-8?B?VXpjR1F4WTFxR0VHVWJaSVh4TnBkYXNLREZDWjdOQXgrSzZ4SXpOWWtqbUVh?=
 =?utf-8?B?QWZiVlZ2SkQ2eXhDSElSRXZQVjRGdjZ4RmFOWGg3UTAxREYwODhybklzOXVW?=
 =?utf-8?B?eDBEb1pkaFdZN3Z3aUdST3FOaWxITklOTG1va1RiV3k0S094YXhHYXVIUVE3?=
 =?utf-8?B?MHJ0ZXFXUmNWdGhJUzRmRE9Gb3BVWDUvYzFQeGx4cnB4UDM3ZnAvTDQ2UjRz?=
 =?utf-8?B?Z2dMNkYwM1Qzb2JQK1RZRWFNRllsUmRoam45ZGZ1UWZoKzV5N01wRzRBdXVJ?=
 =?utf-8?B?SVVQM1FWRDhJc2RrWm5rS1pRMHM5Tm1DTjUwQ2dVa0l1V0hjZmVWYkJ0eFJp?=
 =?utf-8?B?ZFpOV1ZGMXprWWdKOEZMaEhpeUx0RGNkTXpJM3hUR2NVZGwwdFBLUVY3dklJ?=
 =?utf-8?B?WFhZdlBjZm9yVzdCRmJPWW9ibjljWGUxV1dnemV0WHY0d25GanBqQ3NSbTRR?=
 =?utf-8?B?VFVwUG1uOUhMUmhENFdTc0c2TGFZLzg2M1JXRVVvdlRMcEdKV1ZiOVNQR01w?=
 =?utf-8?B?a2VjbFU3Um02SVhaaDN3S0JSM2VLUDQ2OERIdXdsNmxGSlVqOGJucW5VRDd5?=
 =?utf-8?B?MWxjcVhLaWJRZUREOTlWZ25JSXRSaXd4QzFpVHBCdHJKM2RiZHNNU2xFdmNC?=
 =?utf-8?B?ZytXYVp6L1I3c1MxY2lDTGdXMEtmQ1hxU1d1NFhwZis4elFrWWg4aXpjRUVU?=
 =?utf-8?B?b1BQT040Rldwb0RUcXhRb1JkdWwxd3pyU0ZyVFpBNU4wNWNWaWoxNWtFczhI?=
 =?utf-8?B?RVdMTkF3SExGZ2FCMkRreTdBUFhiNFhFcTg3L2pLY0lrK1krVFdiQ09JSDZt?=
 =?utf-8?B?NDNGUXJUV2lHdnUydm84OFF5NkIwdGpIUWw2b1hBSnF6LzREVElOKy95S2s0?=
 =?utf-8?B?K2t1MmRPUlpvRk1EZkltUlRPSmwydlQ0T1pRdVhZSjVpdlNMOThkcEl1V3g4?=
 =?utf-8?B?YlFNanY5R05BODRwRmVBY1pJTnprd1krblVlUVZoVERxN2NsbGdCTzNlOWo2?=
 =?utf-8?B?L0ZnUWMwYVQ1NEpDS0hoNTF2Mk5CdkFUYVhPVWgwYXRXZkxnTTVjeVI3ckp3?=
 =?utf-8?B?SDl0NG9HR053WGhaelRWVGp0WG56WWx5dS8rYytNTnZHSHJ6d1NCZjVJNVAz?=
 =?utf-8?B?M0xMTXV1aU9IZmNzbzZKOFVvSzNNSlFoNTUzYjY1eVJPSENBR2ppOTNUYVNZ?=
 =?utf-8?B?NHF4NUJ3K3RoNG5nUHlSeldVOEJsUUVMeHBhQWRFK0xVd3dDVEJWLytSUnlG?=
 =?utf-8?B?bmpFYUFGRlRBUmhqOEN6Vi9BWkFKeWdNVUpRaXR4QXdSQXIwYmN5UWIzTEhu?=
 =?utf-8?B?eTE0UWtkWElzSnJZNXBEVFhScFVhU2JBMVg2UEZBWmVjR3I4VHRzS1E0aE5i?=
 =?utf-8?B?WXlpV2RnZDlMVGQ3dzhXM1dsUCtCZlYrdUc0NC9tb0IvWkU5ekg1Rm5RVjFL?=
 =?utf-8?Q?iVoSmld8uF5dAvmDUoR7F2tKSwxaWTd9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7618.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU5xUG5hUHNkOGZ3dkFZTDc1ekNDbFJsRVI3T2p3UXZmcCtCWSt4NDFDV055?=
 =?utf-8?B?ZVFjMlVrUGhxWGFoMWkwaE9UbDR4cmJueDNTNTcyVGRhWWkrK2RqNGJYbU9z?=
 =?utf-8?B?OFNmU2kxNTlXcEt3N1A3UVo0c2NqZkVnbmRoSWYreTE4QUwyMFBrVEJ0N0pW?=
 =?utf-8?B?VGEvMHVxQXhGcHl0V25zMDA5UHI4M05LYmI5RkpJbVFqUnVzUVJiVzExdVdh?=
 =?utf-8?B?S3dPcUdXSmlBQUh4T3JsT0RNSDl0WHhPaFJObkVQVUlaVkFlNUZHNnM1OWY0?=
 =?utf-8?B?V2ZFYksxdDlDSTE0Q2trQ0NFV2tlNlpXTXYxczJQRDlRMXZSa0VoWmZWdFU4?=
 =?utf-8?B?ZTE1Q0dSNGtHWDlSTUp3M1piaGtreWRPREV2TjFaU3k1ek80SVFDMHJSWXdx?=
 =?utf-8?B?amt3UFF3S1B6VTVhUUk0YkxKNkFwV2s1Mk1qenRIaGxldEpKYnYxTmsrbG1p?=
 =?utf-8?B?VW9IRlhhVUt0VUdaVlZKWk1MNTdWSCswU2tiM0tSam5tU2ErV0w0dDZsQVRS?=
 =?utf-8?B?dHI1WlgvUTd5eXFkV2JSK0tCVkx2UHFtZDhiQ21qQnRlQWl5cEh4NFFoUUdx?=
 =?utf-8?B?R2J2WkNrNVo4dGMvUEp1b2hDYkRpMlllb1N2bi96N1NETDFxSWF5b0tXa2Vo?=
 =?utf-8?B?bGRwb1NSdU5ZL1FWVDMyOUp3a1NFWDNyWUx2U3k1OUVjVWRZWURiVWRzZWJi?=
 =?utf-8?B?TUIrUUlDZ3dmcWNUUHY4NWtzd2ZHSVJhV21vc0NOelhjUlBkQ2M4anB4Y295?=
 =?utf-8?B?LzNCazhqQzcreDNNUlJGZHpScnA3bzFpRHlSbTA5N250Ull6MGlCSFVnbk5s?=
 =?utf-8?B?cExTRW8zZ3gvZE9lNFNSVkZlOXhvTmR5Y1g0L21FcjdsaHhFM3pRRFBlVmNO?=
 =?utf-8?B?cDlqRm9aZE8wVWJXNkNodkU1eDZMQUFKWldBK3BjWHd1Sm9xbDZtYm5zL3du?=
 =?utf-8?B?VE5ROGpIM1RESmpqamh2NE12TzVCbW1lYzRXWkptb0w1MldUUlpHT3hFaUZr?=
 =?utf-8?B?Z0pBZWdFSFpET0ExUlltUjdZQ29RNGltNmhwV3JQMWY4Wk55S3ZJS0E1eEJu?=
 =?utf-8?B?Sk5KYWNlUkQ4VnhsTkFOMGZJVmpZdmNwK01wQVdSbStoakJ5RGhRZGl3YS9N?=
 =?utf-8?B?MVBHb0NFbk0zcUZ3WUxsWEJ3TmlFck5UVGorbjBDekt4Q1hMZm50S1QyQ2Fv?=
 =?utf-8?B?YmNPS3FBdXcrTENpMEFXNVRTSjc5M2RoL0tSOU9Ia3RKL3laR2h4VEsva1lv?=
 =?utf-8?B?aklMRURreXBZcURiTmNnc0lDdzF2UHoydmhwUkhHM0hsNWo1V1pORVQyblRo?=
 =?utf-8?B?Tkx5a0dpNnVTUW5rSzUreXZnU1liaExBaUxIa21hNUVydHJHanV3N01LL3FU?=
 =?utf-8?B?OWhhUXl0T1hUSER4dWppMXdtTFE2TzlFem5YMEhSRnhRdVdwRFdXSUZxVWRJ?=
 =?utf-8?B?b1dXWUlST2VBaFR3QjhudEQ0K1o4R0NSSW4rOWRIS216MUZ3THNJSDBDYWd5?=
 =?utf-8?B?YXc4YnRaY3pyVjBVZHBhMTRDZG1RTXJJeER5aWNrQTU4Z0NMT1E3cXNqV0ps?=
 =?utf-8?B?bFNsaTJTSnRSTkErdmV6Mjh4ZUdlZFplSityUTh4TEZPYUdWdkZmbFVsODJQ?=
 =?utf-8?B?OTBlV2djWWdWOG5tTUVNS3BKRDR1bVVhUExUM0FUZUJIZ0xuYy9wNWVvTVhE?=
 =?utf-8?B?aDBLRlV6TGhjTEU5b3ZnSTJ0cGdHRVRlR0N5eko0aklCVFFNbGl0UDFNRzRX?=
 =?utf-8?B?UWVjOUxRWmtpS1VUamxUTTkvSk5Rcy9pTmFXTTF3WUFBNmhKVEkrd3hmSE0x?=
 =?utf-8?B?RnJnTXhRaGFSTFpBRFM3ZCtQTWZrUE5ZY0phQUwwV0t1aWZuYVp3azJiQmRS?=
 =?utf-8?B?enBjNVl0SFo3M0xvbVBUalgvUDBWZThBYmlPdVlZQ0JHbGlESWNYR1p4aTlq?=
 =?utf-8?B?UUp6UVBqbnBzclBheUtodVVqby8vTXI2ZUJnVHdOZzdFYktIdFJWci9wS0Zt?=
 =?utf-8?B?c1B2V2dQUE5MUnFDaWtMRFpPTWpxTHh3eFFjMTlqTkFPVE5KTitPSHRjMC9a?=
 =?utf-8?B?Ylo2cUhJamNjdWhnbUNIV0M0R0IyNSswK0lGK2RCd1MrYmlDNTgyRzJmemxT?=
 =?utf-8?Q?xUO7V6UOt9o0ACi7XAnaIkaTm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JjVSqOAL2Txk1m/N5ckK2hH0mGHklTACG/qX32VVUFOYN03WbRzcFh/NVQh73MNc1JOke1KLwoD/7DFhoZq5WTw+9tnKM+8MKzQvd5jKPz54ls7ThHV7PRJrLFzz7/D0fNBa48oF1HMnsID2bDMyWDNW0gPKEimWPcUx2vnwN25UpeFzzfek7QjpMuWKmmMhthQVi8vsTM7L29BQJ0DPC8M5M8+zuaMk17awpAaFnxvlS+oyXCIGqrIQM/Fw9+FLSieI6BHz0M9KkP6fQ9tO7lvQT3NBJcPVCVFjMRPikRoBN/hkBBhNlO+BVYvgqD8jFddmmJZN77f9IS2p7QtHxFGthPaGEZIgKKybBJwLklwqrmpno7gJry6iXR/UT82gseTqMtV0zjIcsV0xAFmrpMmTMhcSuiZAUakLrazGjYfm9PO3xzn9TrGtKh6FWg1I8mQ6DQYMz7VT9jJK3VAm/MgWVUta5A4/Cmw4QNpKczvGL+y6x4I9jtSRrY5ajvo5mbEiztRzLuG2X9lYbhtyxGwEuYDlelSHkX9Ed+W8tH6jjRnsnGjT9ubmR7Ll7oNjRcVbTpTNd1PqTBtnjABYgpgGbIyZFKpN/Fw3xWOK4UE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdf4aea-6d0f-48f1-9341-08de342f2c3a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7618.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 18:50:34.5712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNjUthlIltLwJDyKrb8/+vTNFpBNpSHKwWgyxLsqSPOTY8XsMePsNNX82Q4onBweTPHJsWKaZzzLE0rriqbnew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=962 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512050139
X-Proofpoint-ORIG-GUID: b2UXxwArO597wk9PU99axWS_9rDrn0Y5
X-Proofpoint-GUID: b2UXxwArO597wk9PU99axWS_9rDrn0Y5
X-Authority-Analysis: v=2.4 cv=ILIPywvG c=1 sm=1 tr=0 ts=6933297f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=1VY8xy4-P1P2kjXU:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bISZclZxg_Y0aveKf9AA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13642
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEzOSBTYWx0ZWRfXyrx91Ga2jLvn
 81v2D3R/QjQDxPUb+CaqKDZd6Hl8ue3OoPNl9TfQRISHHotQ/AvdZYhyZsulMBjqbupWn0kSNvB
 LYX4BVXYr1Ps3yMYIGjJdQ/T8FwO6qYXiLNAQ6+iKbL6LVdGWqOn59NB+zcfIxXkAZGBrNsxMli
 HdmRNLnqp7LnLdrWRHkWfO13FzvKrEDmyGVZS7x2nrG4mjHgX5d1yx3zkwvrjGTHWn2nLjzQSdu
 n79j5lp5qx5i4fIA2zt96V7DaNxpe8NJDa7qQQLTxInAPzVZumw/5/sP5QVWzO3BW3WT4FAa561
 CtrcMEIFVtaioUE8sbVPEwMTPdv+ENcJjlmrj/7/nLYQGA80VmuCW91bPpFyLp9WA4MvJrh50YM
 2PPW8pqaVe8rXPgVPjuGUeDkDrbohpjPYUoQletvize26YmvLBk=


On 12/5/25 12:05 AM, Christoph Hellwig wrote:
> On Thu, Dec 04, 2025 at 10:10:39AM -0800, Dai Ngo wrote:
>>> So in general I think it should be taken as the same maturity as the
>>> SCSI layout at this point.
>> How does server fence a client using NVMe layout?
> Using the same persistent reservation mechanism as the SCSI layout.
> The very minor difference in the registration scope are transparently
> handled by the drivers.

Thanks, I'll give it a try.

-Dai


