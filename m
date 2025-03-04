Return-Path: <linux-nfs+bounces-10457-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AC3A4E1A1
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 15:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A25019C0884
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 14:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D20206F03;
	Tue,  4 Mar 2025 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qi6TJzZD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FMMZyLj9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B66253B6C
	for <linux-nfs@vger.kernel.org>; Tue,  4 Mar 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099214; cv=fail; b=D1dZbsPs+CJInFxdwIDTk7oXQULfgy83s8Q/j2TtgQLLXxixn9ruiqHi7ZFyjobucMQXDFXgiEiV9WFCQUlZVYKmysPwZpfDvML8LW6R7NOflaZWCi/WOaTXOYw5e4q+ExWOg0FfVrsy1FHqil5waywe6C3SjaQaz23LRQbEL8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099214; c=relaxed/simple;
	bh=jh6oMqz3mnE4nzex1ZKbNcoDes+aq//YVVzpf825a1E=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=dpuOGRA+eN28ap1KGYu5fseuWh3Y/pNUdMhW3+tebN081heyaaLGfhS5yi2vIdFU/d3eDQvS23GOx4Ah0W0XZtWwEcxyTvpJ4W+HI70YrYingf9ngKrSWpPnkR8HqPoQiHac+cHtDZK09JX8ezuyup8dQiptm41W3CiPR/n1kWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qi6TJzZD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FMMZyLj9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524CajVo011481;
	Tue, 4 Mar 2025 14:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lDkDcZUc7UXirXTN0dZLIKDGe0MISJYk90zyDhGV2wA=; b=
	Qi6TJzZDxxIDH6h91nYQ/krwjAfbS5PF1zOc8mzcwdjdG/xRyUKpcqqI9+I9j1Ce
	xWZFdo/Z6+f72XcJvyeVAxOgGsD1CXqVKtvqd6ILy7x5Bwf9rZX4DO6WtRf4tsii
	5RuLmJcKNdCuKSdsfTcRvie8zAC0lYSYBhZbORMd805cebxWX+DHCI1eeG0fpy/K
	MibBXxHH3/sLZHiOcxBbt0r0PYhiOkufFAGqEu4h+4LgurfSov7rMHtwEzCJlWAE
	FOT1cH52KSIrvwwsqz3Pd4I6tf9XjKoWN47hNZZP/1+kak1wjNqLSUJLK7PQgkD2
	lku1mkTDqMWItY9w9QhRDQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86na7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 14:40:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 524EVHZH003197;
	Tue, 4 Mar 2025 14:40:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp91wuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 14:40:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNYVeKPQMp0GNPLGJZT4MCg37UzlIXrIqoZ4ZDyaXKeRaNCImzMFIQn5X0HwtKYbevL8IBZjhgXbs2lTWRK9YDavyzO5cZfmvX8bruLHaEaeqZQS5LjP8Ng3bWHm5xlSWln0yaq7+KSokud3hFDpWlQhhIxb+zqoofMBLb8gP3Rm7i7Wvwv6vKJuDEMrJJRfTYz/vVRUoOOrg37kEyJQq03xMMJxqqhPVMeBAm5D7u2NdzXiwVkONCGaTxy64aqvNN9xC02ocGyPuiH/wsK/0WPb0Ax7ZTvhAo0g/+G9fdAYuyV7tDumBx1o9bwEXo9cJDn47ZzEZmvMn8dMPNlHsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDkDcZUc7UXirXTN0dZLIKDGe0MISJYk90zyDhGV2wA=;
 b=OuhEeOG9WRs0Qe5GNHlM8HdsDQfVVONWggxeZ/wVvVKeRMbyW226G5VHtdcM9Ksr3LxO2iHQ6mlwE8zp0SKo2ePefvEt0H8CAJQStqY6gjjeier2+ZiNBcfqpVwF2Hd1sSgu/xk5cARzvsPq+ltPn4nf9A/K6I4uE2Oi8FKUEwcuLGbiGQ0SgFMbRVZY9M168aS9eX7hzu4LFCdcOpXA+LamHJAhpWKSZKIqmWZl3ci284sFPuscvlh72JkYXPJdNSwBIFh/+/rzbWjWHIP/vSdoWQZFG0BsjC4zRrHZWqhhRtKKejpWPbJVX/UqnQRVm6S2gK2Ot2H3XRm7VTvi1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDkDcZUc7UXirXTN0dZLIKDGe0MISJYk90zyDhGV2wA=;
 b=FMMZyLj9uLN3WPSv3poLxobezm0kM1u8zQaVzmnmospzR1liT4R+h4jvfEBxOSrRTWHrZ2Z4P2XvQLG0FU1kGiwOHAcICeRTbyqVFOo+ct2DpahrlrcFLK2WYIThYgaOtnvLffNTED390I+suEzhkUtwpPAh0PKu9bLiZXK3hHg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7829.namprd10.prod.outlook.com (2603:10b6:806:3ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 14:40:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 14:40:07 +0000
Message-ID: <cf6ab5a9-3371-4b87-bb40-ee2ee298cd54@oracle.com>
Date: Tue, 4 Mar 2025 09:40:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Increase RPCSVC_MAXPAYLOAD to 8M?
To: Cedric Blancher <cedric.blancher@gmail.com>
References: <CALXu0UdddwbzGUUzKdbxpb-yC-FVMhbdcd-P+OLSDNvjZeByGw@mail.gmail.com>
 <CALXu0Ue+w_P6P_yyVR1y85bKXxkorGrctJ4jiTBctQd8ei1_kw@mail.gmail.com>
 <9138cbb9-b373-477e-bcc4-5a7cc4e16ed5@oracle.com>
 <CALXu0Uew5qUxvH7wum7xC1TBaP43tmrYAbU6iS6yuwJVF6rBrg@mail.gmail.com>
 <db677cf9-6979-4247-a195-5761c27ef2ab@oracle.com>
 <CALXu0UfxxuZm_fFwG9h=+MKhRVfuwXUwhxxnGWV74KtEFt6mgw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <CALXu0UfxxuZm_fFwG9h=+MKhRVfuwXUwhxxnGWV74KtEFt6mgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b24356-b7d2-4942-5968-08dd5b2a75a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UE1rZHQwUzZpSXZEMzZiTUw5UUg2dG5mT3JnclNKVWFLUEdCQlFlUDF0b0dr?=
 =?utf-8?B?aE5CTERRZ3JJL1BncTF0MFBaN3c4WHh2ZE1JZzQ4RGlZS29GRmNndDA5UUZi?=
 =?utf-8?B?UTFkUWMyR1ZTaktFcWtPZEZSYk53ZnROTXRMNW16ai9tWGdEUzBXdFRDcWts?=
 =?utf-8?B?V0F0enZQWld3elZaRVNxRTIvL1Z0cW52dTRKazA2aVg0QmNTMEdHWk5wbGZX?=
 =?utf-8?B?Z2ZIdGdzR0V0aUZPa0hnTE12dmZhVDIyZmVYTG93dHdyZlluMUpKcEpBd1Bp?=
 =?utf-8?B?R1d4VVlBQ3FzUlJWamZVUUtlckhZQS9EaU4xR1lRVE44clFtNEZ6RWlxSkhE?=
 =?utf-8?B?dnpRY2ZjaVZYb2dKU1lEeERLWWs3VnJKNWZBUldCVlc0eEJaUlFZVHpvdW9i?=
 =?utf-8?B?WVJqdzdQcXRyd21Pamt6V1IwWTdXTDdjbnVIbVYzRnlrODdHZ1RQUlRsaThj?=
 =?utf-8?B?VWZtcXNrcXZIakxRM042Y2pnbHI5TU1ZQTJlZ3V5elkvaTdDTFZ5QlV5SkZ4?=
 =?utf-8?B?SHZuZGpZVHNlZjJkMlRFNU9TeE5Ga3ZFZytJWk9KRm9MOGp6MXo2OUFCSkg1?=
 =?utf-8?B?eDhoLzNmVWo1NTEvQlNGVTR0SWtnaWxwcjdicDJjRkxKenUyYzROTjFyVTJa?=
 =?utf-8?B?SDV3YytJcllUaE1zZkVBVVpHVTZYQzJZN0dwQ3FmZUVhN3NqVnVqSDFST25n?=
 =?utf-8?B?QzFBRDFlOTJrSU5XR0dzUXVsNFdGNzh1cldxRmFkVUo1L3RxcVljRVk1Y2xV?=
 =?utf-8?B?MjA1WkswM0lIN3J5bnA4b3YwcGdNN1BqMUY0c2lpVWNHUmphZVBwM2pjYjVj?=
 =?utf-8?B?RVRlNWt5b1BwQnBVQlZQWWtZbjZSRmdCeTd6dW9vb1V3SWVQTnlvQnlXbHRZ?=
 =?utf-8?B?cjllY0lMRWdsY2RXbzNHYzdtblhLWDhWMUNyc3FmZ0x0RFlPSjJGVEdoSFhm?=
 =?utf-8?B?a2sxWGJ4c2FIUFhTYVdqbThpVzQwU3c5T1ZGYjZVbTNwRE5haU9TTHN4RjBL?=
 =?utf-8?B?VnZnOXZEL3I0L1N1Rm9TMkVmb0U0bDRibHNvMG1UMVVnZnNuR2l1OFE2V1h2?=
 =?utf-8?B?OHBhSFphSWpVWjF0bVowcjduaTFZRGw5VTZMK1BOcTlxcXh3dXdXRC9lT3pB?=
 =?utf-8?B?TUZvaHNISllnVlB2UjFlcGttQ1REYU8xRGFaRU9FdmRsT2V2dWRaaDBaaHoy?=
 =?utf-8?B?ay96ZU5CUU5ZRi91YVNKMnNYNkdST3RQS3I4ZGNzazVQZmp0OG8rY3BZOGFJ?=
 =?utf-8?B?VGU4d09kYjdpY3haTjFZWmZWdXU0K3loSmFMUWVlb3NJMUpPaUxZRHJmSWJy?=
 =?utf-8?B?blNmN2NIeEFCNSt3SkROczc2SVc4WURQSC8waFg3b2lWYUV2TzVWK1UrR3Jr?=
 =?utf-8?B?QWdWMHRvM1BzV1lYb3pVeWhaWkU0a0pST2JqRHNoMXlYL1k5RHN4SWdub1dZ?=
 =?utf-8?B?YXZHekZUYXNIUE9lR2Y3Z1BYNUpVTGNQeXFUTFJKRHNIdmdYR2tkQmFudE5J?=
 =?utf-8?B?WW9NZkZzREttT08rYjgxMzJhZTBuYzZ5cTBFdElBV05pdFl4eTRkNmNyc0RY?=
 =?utf-8?B?NFg3TW53eE9kOE9qVkhTZUNoNFh6MVNESkdnRHlHdnlkNW0yYkREK29QQlYy?=
 =?utf-8?B?SEpwZFZ0KzB5dVRpZ093Q1FyaXNjd2ZQT0FLTGJGdEJoSGIvTmY2S0hhUjcy?=
 =?utf-8?B?cEJwdGQ3Zzgwa2lxRFFoakkxbGhpRUhLV0NXYjZtKzBtL21pOVhnWE04SWtq?=
 =?utf-8?B?bTRFUTZMdDNFWUl5Q2gwMDY5UllNNGwwVmp0ZEFVZlVLbS9GTXhHNldLQk5h?=
 =?utf-8?B?TG9BeXAyamkxZWhMZFJYeFVod1NSYlY0NHYvc0Nia28vUHdFbWhFWWRGNU1o?=
 =?utf-8?Q?I2Yt0BYGAQBfE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXhoQzRpakkzYkRoOGZVSlJweCt6dEk3cGFwWTlxZDZyelRyR2NsWHVZYWpO?=
 =?utf-8?B?WlF2WUc2TXN3MzVXNEVXSk5CQnQ0RFhBTTQwNGhqdjY0Ti9VNEVEZ25nTlg4?=
 =?utf-8?B?Y1V4OWpBbURnakl2YmozZnJNMFB1QVdUSExBWkJQZlV3Ujhpb3lkblZUT0g3?=
 =?utf-8?B?QjdXOXI4RWFnY2Q1MWU3SzlEQnVXRDRYTmVHZmt3T20wUE5rT1M3a1NOdEZO?=
 =?utf-8?B?T1JiSTJPRlkyZkZKTWxGUTFCb1Zkam4rOFZnTVY3TUU1K3FBVzI2ejJNaGsr?=
 =?utf-8?B?VkgvWkU2SXdOa2l0cUF3cTJFekdoZm1UTGwxYzJ3NHJNYUpBNE1uaUZ5NDlT?=
 =?utf-8?B?OGNiYXR2ZzRkS2VwblE5N3FTWDdId2FlT3h3UEowdUJXQzgzcTc3YzluWW1J?=
 =?utf-8?B?eHJGaEIwUm5tdGcwUWc3bGxYVmdvZlJ4Z0VTc2l4TWRGcW92VlBtOWhmMGR5?=
 =?utf-8?B?cXlidnBEWWdHdEY2UFg0bVRkWEJSL1p2aVpqQ0FCNTAvOXozOVpHSEJGbytv?=
 =?utf-8?B?MEk1ci9lN2ZVVUlhYmFVOHRvTytyNFdHL2RMUE5wYmVaK3hEVlpuTW1NdTlL?=
 =?utf-8?B?K2NsaVNHTDVqeWZEZHlHLys5NitodHc5YnoyNThtemROWldVR0p6UGdCcnda?=
 =?utf-8?B?VWtUWTdleUgzYkZQWExqN0xxUWtJUkZKSjEwc1MrYXJyYlNUenBUVkdjU2ZN?=
 =?utf-8?B?WVk4UzZzaDJjUmp5elRwWlpEN3F1MWxWU1hpWmNlRU8yVWx5cTJvZTcwMnV5?=
 =?utf-8?B?SjQ3UFVMY3REcWRQaWxyWFB0endMUW9vQlZnSUJSYmhGV1d1QW9NYi9LVDRq?=
 =?utf-8?B?TEE4ZlJnUTNqS2o1UkYvMHU2Zi82aE5LYmtISVNoS2pLbENxdVdnYUdiSHRh?=
 =?utf-8?B?b2I3bHVPckJKc3B4U2lwZjZZQ1hKQlJHK2tOSitqVGRNZXdIMTNQd3VVVWla?=
 =?utf-8?B?c3kraHU0VGQ4MnlxSEFkQ2h2UWJXL0V4Z1l1V2tXQ3hOOG9OSDBEOXkxQVNH?=
 =?utf-8?B?a084TXRkaEc3NnZLUkpjdFZuR2RrZnAwRlp0K29wQ0RRM3NaUWdrSEpWZURC?=
 =?utf-8?B?U1ZHMjZTK3VCTXgxMmYzUHdKU21WUXFsejBTNis2dDYyVDhJM0VwWGw5MFpk?=
 =?utf-8?B?VDNCL2Ntc0s2ckhUSGM2SzRSRDRGanlOeVhCOHgxeFFMRUluUkozZ21PemI5?=
 =?utf-8?B?S0g5bmNOT0lha0dtMVZzRFVGL0dDYnpBY0VyTkh2M2k1dFYwcVpWTXErZm9R?=
 =?utf-8?B?MkpnQ01WNTd2YnNBbnNBbmlvWVNPbmJEaElWNVh3WlBNK0VUby8ybEo2cDhW?=
 =?utf-8?B?STVaY1lyZERZZ1N4Vm1Jd3FlRlFsYU14SkNuRGg1RStvZWRsWlV6MkR2bHJS?=
 =?utf-8?B?T29QTW1wb29GY0U2Q3lIYk43OEhwQjhFS3VvV1VIZmlGcWxYVjR0NlhQR3lG?=
 =?utf-8?B?UmJBOGowVUpnNUpPQXl2b3FtakZ0cERCQTRPV2NPRmcxeUsvSURLc1N1ZzZy?=
 =?utf-8?B?TnBYRERqSGg0NmpsalhVS1dFZlloVHVUaWVyT0RrQ1ZobEpOY0dGVlNpTFh5?=
 =?utf-8?B?UVIrTXVOYmk0MVBOSStUbE9nTU4yaGxCQjRjaXR4RXBKN200MDIvU3lURnIv?=
 =?utf-8?B?K0ptRmdub0kyQzBTM3cyU1kyZWh5ZFJETVpHV2w4N3kvV3I4bzVkMm1pendx?=
 =?utf-8?B?NU8yaW8wTmw2amVLd3V1dlQ3OUoxL05BV3hXVWhTY0FKRTA3TDNaeDE3MWp3?=
 =?utf-8?B?SDl4bUErdENqazhOd0dlYW1iejVnaDEwaG5tQzQ4a1hBU3liZ3RCSlR3WnB4?=
 =?utf-8?B?WjBwYTlsSDRFbWFndEFtUnFMSnBWYW9NL3FCR0VtbVJ4dVA5cEw1MzI2UHNn?=
 =?utf-8?B?a0dZVFZjRHJuRWlDQlB0ZTl3d2VWZ2hwSi91b0lLbnlkL0hpUVgxZWxlWDRq?=
 =?utf-8?B?S1QycWF0VTR3ZUtLbDJZTkNMUERWMGdFNkNlR2JyK1JPb0Z4RVpldjBvK2Vz?=
 =?utf-8?B?VzhpRFpjQmRreGNOOXhZUmtrUnZtNERKa3BRSXdYTEVESWJ5NklSK3F3bFFw?=
 =?utf-8?B?QXJOeWtBVURtWFg0TTd4QzBFUi81SmtGV1NzdktWN0pWUWpNTmRWVHlsV0Vw?=
 =?utf-8?Q?Z53eo/yiF7375IAXDJHUL5cb9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pphH+afiMBo8kFb6Fql9fijYCY9WBaKA8Oe5US9pzUU9e4fbzvCvljlAAYuL9h82fivWGYdh8gqH6x3e8pO3+930iNbWfvI0VIM9mivI1NNw1d4vAS2+OF7NCQ7b0iZA+N2MWJbCbNg3CqqdhqkiqYQ2ufXq96J5OeWoD4MRIQImEdz0EiVRh/DTlMepP+vENCQqnMXI2DWjDroRbvkG1FaUiTiv4mFvU6iufklt5UcOhTd3U4FGBeS0Gf1TTaqCOOp8AqMdprfpXmOV2jOQBfIC33OlI0F3QYBJa876OMdIjJbFbyy0yqSE/QQeFb+LzYFbIhMN9ivuoJSdJ+iGcbf+up54c1PAsjmLli9QpJrBZDtr+y4gvu/sQCOaefBCvr9g2tzD7VFnuPr4jWRih/YK/7x3XG02HwXvjMUulcSTZ3MiZHdjATQSAZ5tacGMY0cz/oaRw9IrrD/5iSCYi7wWDv45L9Gj9qVZe6faE6nWdWd0cVGtFuvZV5yvLIXpyEMu8B2U9WPz2enQyEQjLDIqQhq/FsYDAeH13kthf2nDfeLSQsh/igwEh47aPkkrJZDAuhvq+Frc1bDZHWZ0Z6pup/6OW0Bv53NZNcJuWkY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b24356-b7d2-4942-5968-08dd5b2a75a3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 14:40:07.8282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6nXhhK9uNk4dJlYFhyg+Kkb/36LWY1KDDjHJbd9haxNGVGW07u8djCwI1voOcsUu+A01TJ+v0mx3L/S99bObw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7829
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_06,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503040119
X-Proofpoint-ORIG-GUID: R9XB9WKetB9vofvhauRhMOZLjpJmGVAA
X-Proofpoint-GUID: R9XB9WKetB9vofvhauRhMOZLjpJmGVAA

On 3/4/25 1:43 AM, Cedric Blancher wrote:
> On Thu, 6 Feb 2025 at 15:25, Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 2/6/25 3:45 AM, Cedric Blancher wrote:
>>> On Wed, 29 Jan 2025 at 16:02, Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>
>>>> On 1/29/25 2:32 AM, Cedric Blancher wrote:
>>>>> On Wed, 22 Jan 2025 at 11:07, Cedric Blancher <cedric.blancher@gmail.com> wrote:
>>>>>>
>>>>>> Good morning!
>>>>>>
>>>>>> IMO it might be good to increase RPCSVC_MAXPAYLOAD to at least 8M,
>>>>>> giving the NFSv4.1 session mechanism some headroom for negotiation.
>>>>>> For over a decade the default value is 1M (1*1024*1024u), which IMO
>>>>>> causes problems with anything faster than 2500baseT.
>>>>>
>>>>> The 1MB limit was defined when 10base5/10baseT was the norm, and
>>>>> 100baseT (100mbit) was "fast".
>>>>>
>>>>> Nowadays 1000baseT is the norm, 2500baseT is in premium *laptops*, and
>>>>> 10000baseT is fast.
>>>>> Just the 1MB limit is now in the way of EVERYTHING, including "large
>>>>> send offload" and other acceleration features.
>>>>>
>>>>> So my suggestion is to increase the buffer to 4MB by default (2*2MB
>>>>> hugepages on x86), and allow a tuneable to select up to 16MB.
>>>>
>>>> TL;DR: This has been on the long-term to-do list for NFSD for quite some
>>>> time.
>>>>
>>>> We certainly want to support larger COMPOUNDs, but increasing
>>>> RPCSVC_MAXPAYLOAD is only the first step.
>>>>
>>>> The biggest obstacle is the rq_pages[] array in struct svc_rqst. Today
>>>> it has 259 entries. Quadrupling that would make the array itself
>>>> multiple pages in size, and there's one of these for each nfsd thread.
>>>>
>>>> We are working on replacing the use of page arrays with folios, which
>>>> would make this infrastructure significantly smaller and faster, but it
>>>> depends on folio support in all the kernel APIs that NFSD makes use of.
>>>> That situation continues to evolve.
>>>>
>>>> An equivalent issue exists in the Linux NFS client.
>>>>
>>>> Increasing this capability on the server without having a client that
>>>> can make use of it doesn't seem wise.
>>>>
>>>> You can try increasing the value of RPCSVC_MAXPAYLOAD yourself and try
>>>> some measurements to help make the case (and analyze the operational
>>>> costs). I think we need some confidence that increasing the maximum
>>>> payload size will not unduly impact small I/O.
>>>>
>>>> Re: a tunable: I'm not sure why someone would want to tune this number
>>>> down from the maximum. You can control how much total memory the server
>>>> consumes by reducing the number of nfsd threads.
>>>>
>>>
>>> I want a tuneable for TESTING, i.e. lower default (for now), but allow
>>> people to grab a stock Linux kernel, increase tunable, and do testing.
>>> Not everyone is happy with doing the voodoo of self-build testing,
>>> even more so in the (dark) "Age Of SecureBoot", where a signed kernel
>>> is mandatory. Therefore: Tuneable.
>>
>> That's appropriate for experimentation, but not a good long-term
>> solution that should go into the upstream source code.
> 
> I disagree. How should - in the age of "secureboot enforcement", which
> implies that only kernels with cryptographic signatures can be loaded
> on servers - data be collected?
> 
>>
>> A tuneable in the upstream source base means the upstream community and
>> distributors have to support it for a very long time, and these are hard
>> to get rid of once they become irrelevant.
> 
> No, this tunable is very likely to stay. It defines the DEFAULT for the kernel
> 
>>
>> We have to provide documentation. That documentation might contain
>> recommended values, and those change over time. They spread out over
>> the internet and the stale recommended values become a liability.
>>
>> Admins and users frequently set tuneables incorrectly and that results
>> in bugs and support calls.
>>
>> It increases the size of test matrices.
>>
>> Adding only one of these might not result in a significant increase in
>> maintenance cost, but if we allow one tuneable, then we have to allow
>> all of them, and that becomes a living nightmare.
> 
> That never ever was a problem for any of the UNIX System V
> derivatives, which all have kernel tunables loaded from /etc/system.
> No one ever complained, and Linux has the same concept with sysctl

I think you missed my point. It's not good design to add tuneables that
/aren't/ /generally/ /useful/ -- why does the rsize/wsize maximum need
to be changed for particular deployments?

Basic approach these days is:

 - After an experimentation period, will the tuneable still be useful?

 - Can the tuneable be abused?

 - Is there a mechanism or heuristic that can enable the system discover
   a good setting automatically?

Only after we have strong technical answers for those questions does it
make sense to add a public and documented administrative setting.

Otherwise, a tuneable simply adds complexity of implementation, of our
documentation, and of our testing requirements. We have to demonstrate,
first and foremost, that the tuneable adds sufficient value to warrant
the costs.


>> So, not as simple and low-cost as you might think to just "add a
>> tuneable" in upstream. And not a sensible choice when all you need is a
>> temporary adjustment for testing.
>>
>> Do you have a reason why, after we agree on an increase, this should
>> be a setting that admins will need to lower the value from a default of,
>> say, 4MB or more? If so, then it makes sense to consider a tuneable (or
>> better, a self-tuning mechanism). For a temporary setting for the
>> purpose of experimentation, writing your own patch is the better and
>> less costly approach.
> 
> Testing, profiling, performance measurements, and a 4M default might
> be a problem for embedded machines with only 16MB.

We can make the internal maximum scale down automatically with
available physical memory. That doesn't require an exposed global
setting.


> So yes, I think Linux either needs a tunable, or just GIVE UP thinking
> about a bigger TCP buffer size.

Let me summarize my position:

I'm OK with the long term goal of increasing NFSD's maximum rsize/wsize

I'm not convinced it needs to have an exposed tuneable (after a period
of experimentation). We should consider ways of setting the maximum
payload size automatically, for example.

Even if we need an exposed tuneable, I'm not convinced this needs to be
a global setting. Perhaps per export or per connection makes sense.
Let's think about this before committing to changes to the public
administrative API.

There are other development priorities that might potentially conflict
with increasing RPCSVC_MAXPAYLOAD. There is currently an effort, for
example, to replace NFSD's send and receive buffer page arrays with
folios. That will have direct impact on how larger rsize and wsize is
implemented, and it may avoid the need for reducing that maximum on
small memory systems.

Lastly, there have been some suggestions about how to add a temporary
tuneable that could be made available in hardened distro-built kernels
without the baggage of an unchangeable API contract (the NFSD netlink
protocol). That might give you the ability to adjust this value
without us having to support it forever.


-- 
Chuck Lever

