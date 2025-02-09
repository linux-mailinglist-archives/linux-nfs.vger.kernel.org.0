Return-Path: <linux-nfs+bounces-9985-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD4BA2DF18
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 17:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F170E3A4BF5
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BD51A2C27;
	Sun,  9 Feb 2025 16:27:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020114.outbound.protection.outlook.com [52.101.51.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A14A2E628;
	Sun,  9 Feb 2025 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739118429; cv=fail; b=gMWbimq6poPCnyi/plaAEPCz9UAt1+HE9MoPJgHJo3DUDAzh01HvqDaMNKZVh1U3AqeBISlHoJ9K7tVNRIdzDJqeGmh0qsd8MLrl7RWVq/mlInaUsSZmPCSMJjnuxKrQJujGTjonhJNglTRXkrjgeaRrN82cXHQKxxQjk0gWhfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739118429; c=relaxed/simple;
	bh=akaRpLvymfRq9rbwe9vAcMnWbPxfQFX6jMArtWChJXw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qEUDcM8cfnw2Kjo8O8sciM616oTE1ruvpUvcFSmkVdVVPEoKHF4KbIjWueDB3xGFQbIIXnkH2WCd+tL1xFDY/8m2fOGJX9bSpFAfJWl2N3MVWGoyc+sFye3V3bqMoXkkVmFUxz4N4RB5Ic9UJr0HS+oUugph9X9uXKjRBllmv4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.51.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cr5iyn5DVWXh945oKXEI2dgQmdfr+zVmXMyWk2GOFTY3KWv4RoifxPWnER98qERDCcqM4GXuk3QqYVAnYrJRXBlbmTzi1CrLGbuWAqBKh270dG+GOgHaPcHTcS+O6g+ruapZusdQjtcS2hljN1xSyQXBktJF7BfCGLYYAN6X8BJ9l7leWKkMVOlhU7JKYXv5AbGX44Gx9cyk8Ee6+JyVnF/xYVQuZtTfjxdiMTinxvWbUrb9C2t5EHrbHdKucif/r9neE1BhgVhvF+qAIugzrPIj61H9meOhsSzwNj6x/gck0a5GKL+M86kzwQn1k0y63aH9tZl91eoSiyX3qDlAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jh4Hswe4JrLHuBZHy5pET+4FMrj0RVNj/SJJLux406Y=;
 b=LnlkQnSl9pBUWiee4CxHOvfBJVLAn3uJijmATri0a1eUHXU3pbviilvfUrPjCVZobrRHFLp3DIEry4GlNzHLYi+TL2XncRHHaj2DAi2mqT8roArcNBTGpS5nciZYBAOYV5Rt6+5ty22t4JpAkDsOX8QQs6fzLqUOXcBilDyQQXkS3bFQ25AkkYWoAidddQmGejkNEQc7Kzrt2DCRITc0xQxpmgRPzRmUpyvrwSvG2csr2ut/iYE7pwwpqun8qvPi9tuaNfomg8Yzmb6po3gUrOIiEW/rjwabFNRnH4HaRkiJHuWd520dxr3pWnMzfxeikEIueC6O1m4P8S1d4FUmiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 SA0PR01MB6396.prod.exchangelabs.com (2603:10b6:806:ef::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10; Sun, 9 Feb 2025 16:27:01 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%6]) with mapi id 15.20.8445.008; Sun, 9 Feb 2025
 16:27:01 +0000
Message-ID: <7da740d0-1e4f-4e1b-986f-9516c8286d19@talpey.com>
Date: Sun, 9 Feb 2025 11:26:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] nfsd: handle CB_SEQUENCE NFS4ERR_SEQ_MISORDERED
 error better
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
 <20250207-nfsd-6-14-v5-6-f3b54fb60dc0@kernel.org>
 <28174296-129d-4459-aa23-a94bbf00d257@oracle.com>
 <3e4d14075482489cd010e4ea621c0bd368700e27.camel@kernel.org>
 <40970e33-4689-4623-a423-b346e739ba80@talpey.com>
 <66532654ca25280ffa30168a977601ba4a37aaab.camel@kernel.org>
 <29e739f1-2d85-40c2-a549-5ab9d71686b0@talpey.com>
 <35cae0eb73781bb36c49aed2c2bc49a808698635.camel@kernel.org>
 <2f9fe86f-b49c-460c-bf2e-fed97970952d@oracle.com>
 <ad26cab0-8f63-4ff7-a786-1d0ec51da490@talpey.com>
 <d6fdb3ba346ef606f630441de1a34cb00030cb4d.camel@kernel.org>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <d6fdb3ba346ef606f630441de1a34cb00030cb4d.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:408:e3::13) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|SA0PR01MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc6487e-6992-494c-0c00-08dd492694c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0tVNVo0Z3lXcXNJRlE5SDlhS3o0Q1psREYxQXlPRlBtWUt1QXpGVzI2eVNJ?=
 =?utf-8?B?ZHg3b1I3UXBzNGNXSGV0d3NCOVVCNHlyOHR5QUsvdHBuTGZtZGVzazFRRnVS?=
 =?utf-8?B?MUx3Z0Y5ai9YWnJVUnBHZFBZSnpzdzQrYThvM3RsTmw4VkNPdzlVWmVDVUcw?=
 =?utf-8?B?RytCcU9JWThrVG9uZzZKRGszTmhPYk55Ym1acWpHZ3B0d1R2RWxKclJldi9h?=
 =?utf-8?B?R0tTWSt4NjhJTWFpa2xDWnpCdklHcnFCL1hvMDlHZ2MwM09JUE83NDJUd0tx?=
 =?utf-8?B?UWZXK3VETzY2aWFoMkU3OE05SFhrcXl6T0ZnV0NGNkErdTRvelRCcERmWGE1?=
 =?utf-8?B?NkdtUm9VZXB1eGZLalp2Y1R1Qk5XT1hycW5jZXUwN2FITkw5aE5aUmc4ak5h?=
 =?utf-8?B?Zk5sSFh3WDFYaFI3elo3YUdsdksrVVY4R1RIeTBhT3ZLVlFyb0JsSWo0Z3ZK?=
 =?utf-8?B?d2NqQjM3TTFjM1ZVNElocXNXTkNsOWRKUXJKREtMQ2VqQXNpd1BYZnZtZXhx?=
 =?utf-8?B?MGdrUHJBWnZVc2dmclVZaWFBbCsyQnFwWjhGaktEbzFBRm4vcVl5NGFWaW5E?=
 =?utf-8?B?bzk4L1pFM2xwNklER1R5UUZWN25HdHk4ZVBVeGloU2d1Tm1TcHFjY001T2Vt?=
 =?utf-8?B?Z1RwSnkxbmUxNUwreVAvdTZQVU84ZkZsTGZIVzQyVGVsbzZTM3dLYTNhRnJ6?=
 =?utf-8?B?ajEyOWgwWGYzTGE4aFIrSmJtcVVCbjA5ZURUa3ZKMW15NTdCbENRMkxsMjBk?=
 =?utf-8?B?elBxN2tHWGJObjErNngreGQ0RnphUEFRMGk4bldUSC9ZOFp4Vmdydm1NNG9Q?=
 =?utf-8?B?RWo5cTFlWSt0SENsSUNNT01WeUV5QklNU0dLeE5aSHgzbGdoSzhyeFIxTkM4?=
 =?utf-8?B?bGVIS2NhTlZWeEVGdEo2L0tyQzFJYUp3bmdlanNoZEZCMnEvN1lrY1VrTDRt?=
 =?utf-8?B?ZWlsN2MzMWVlSHJLM3d5YzVMZVVnUktMS2dleVZwN3BjMVU3Vi9iSlZBdlhj?=
 =?utf-8?B?cjZOTG42SXp0TmtnRUpDVHN6WDI0TEU4TTdWZTFMQzI5Zm9CY2pvckcxTTRr?=
 =?utf-8?B?SUxQVkFZeXF0UkNEczhDdkYxbTF3VDZvR2xNOWtTV3A4SmVGM3h1NkV6TWNw?=
 =?utf-8?B?Mk5tWkV3VTk4dXd5bjU2T1JKeWlPZ2hwRVF1cEwwRnFtaXpDZlhGaGN1NGxs?=
 =?utf-8?B?Q1hEVWJZdXBlWlhhSERoRGNIRFFCT2JRMDREcFF6K1VXcnhvRExTSkJPVHEz?=
 =?utf-8?B?TlhKcTJPWEdsOVFvUURYRndzTm1EK3MrWDAwRVd1MGkzbVJSS0ZOVUFxSEdo?=
 =?utf-8?B?R0FEUmxzbjJKQUdVZE44T1VGQ1h1ZTRSc2hwZVQzd25xTlA2Skl0VUhYQ25M?=
 =?utf-8?B?N2Y0QXVSOUxHU1BsNzBmN29ZWlR6aWdHTHIwbExnOXo5VTJXTzlWbzBCK3JE?=
 =?utf-8?B?VjBkRU5Fb05TRUJNN3B1eVV0czl0RE0yZy9hY2wwdElZU0ZTV3c1YVl2bHJl?=
 =?utf-8?B?a0JKNkxycVArUlhleGkrNStyZ0lmeU43cnJvRlF1eWxRSjBZWFlPOUpxcnVx?=
 =?utf-8?B?ZkptSEMyZFk5VzN0ZFUrd3RkWEZjblRmcnB1Nk9Pb0huSnFHOU1UTU5vY21T?=
 =?utf-8?B?ZHE2RW16N3R4Q1EycEM4RGZkWm9ZOHY0Rjc4RXhWS1YrbFhETmlweUE2R3Vo?=
 =?utf-8?B?cThPRDYxUFY1eU1pWjd0RXZEc05pVzBhN2JMckM2clRzWTBhUzBoNiswaGFF?=
 =?utf-8?B?Vnd1N3dJL2xOSE1CUnNKV3E2aTNPaHBlTDM0NHZOL3hscnN1UVhoOXF3TGFl?=
 =?utf-8?B?RWhPTEFmdkhmb2FNbHYzNUFCSHJNZnRwNnN2TGxMenRPVWY3NjkzS3BXMXJw?=
 =?utf-8?Q?5sSTGmLXq3vNe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVVETnNRNTI3Wlh1Szkwd3Zsc3U4SndNMXF0UFNvOXJMYUlaWXRHS3dxZUJs?=
 =?utf-8?B?UnNnT2FCeVJGaXN5Rk85YUJ4aEVTalFDYUswZWNWZlZLVCtyZXpNMXBYcXRR?=
 =?utf-8?B?bHlFQVJXQWhSdGdwdDJFdkZtMzZLakJMYTN0MkNtaXNOR0JUNWRIYTdYSHRL?=
 =?utf-8?B?SzlSMURLTGxHaVRxVjc0dW9xRTZudkI5Z0txMVVxekpsdVNhMkhvZTBWdXpY?=
 =?utf-8?B?MnJlczlxbkxNRUZ5UWlSMkJ4ZDhDWEYrb0RpS2Jzd3NRVTRlaTNhRlU4c3hQ?=
 =?utf-8?B?Vmp3YnJ6MFNPZ1E3bnhOdGFxeS96MlV6VVc4T3FlTmNXWXA2K1N6MW5PQlVh?=
 =?utf-8?B?N1ZjWnVjanVLd3ovMTVKL25CVldGT2QwYkxEblR2dUhTSXhjTkhsSThqQmJa?=
 =?utf-8?B?QmFJb1ljNjVNb3hHc0dXeWNRd09BakplUk5CMFo2Z1cySjl6NUd6bWk1bXA2?=
 =?utf-8?B?WEo3cnpXVkw1U3NSYk1EKzRkUWxLV2VvbzE3UXFiWG8xZ0p4dW95YnNmUGVZ?=
 =?utf-8?B?aDVFVENSQWFOWUI2NmZHVU8rYUM5cUNPS0VsT2Jad1hORGNZeitLQllqR2tG?=
 =?utf-8?B?QU92RVQvYkJVOXA0RUhLYXZpVWhqUDErZ1VZSzNzUGFyOVNPLzhYMGJXdGt0?=
 =?utf-8?B?Q0pnbjhCWjdKMzNzdEVTd3VsbGg5STNZMlpLbVY3K2ZwWW96djVsVWcyVkNs?=
 =?utf-8?B?cXJGMEUyVU9oWC84OHU2QzBjdmtPaEhIMng0TnoybHRMQ25xQ29NZ1g4QXFH?=
 =?utf-8?B?aDUwVXV6T2VJMFlPSVNuak9HZDlNNUtkM3ZjTkdURy95bGtSbnhsTmxZVWUx?=
 =?utf-8?B?MjN1SmRzQ01HYWhEempNbXFiL3Q2RnE5OGphUmNJRjc0WjdKTzBQY3N2TmRW?=
 =?utf-8?B?eTRUWXNXY0tnMzE5cFFScXp2SzE4M0E1d1p3WEhaMzhsWEdKc0lvTFNOWXJL?=
 =?utf-8?B?NXlqZVk4VDROeThzTGZhL2VNZi9RTUE1b2RGcGZOcSt4enU3NlVsK1poRG9M?=
 =?utf-8?B?UlgzNldEL3FqKy9GQlJqdVVsS0xXUE9vVWI4SVEzYWNZZVppRGV4YkcxclBF?=
 =?utf-8?B?cW5PUDZ2Z21xVUlQcW9nUEEwM3Y0YVRVY1N6MHFveEw5OEdocVhIRGZrbGN5?=
 =?utf-8?B?RXVyUVd2S084VEJuUVdtM2t4WVhlTDZBSk4wV2xZZnlZMzlHMXlwQkE5MkNE?=
 =?utf-8?B?RVdESmN0Sk9hMHNFZkFNRGRWQ2ROS093bzJIY0c0QlI2WFFKOE9mNXF4NjNQ?=
 =?utf-8?B?UDdwT05UV3ZVVUlwNnVzTE9vWVpUd1U2N3ZXeFVzTmxSL1V0VlFCemhSZ1FU?=
 =?utf-8?B?ZXpQeWJMWHExQXVMTjJaai9uSWRUdE90bjI3NlRVMVZEOWJ6clRWK1phdTZ3?=
 =?utf-8?B?YXo3VEF6amtic21WeUtZUHlKTDVnd2VLMjZtbDBqZFdVd043cGovMlQ0Wnhl?=
 =?utf-8?B?bFlldnFkYy9neHhJOGllTHZPUm5LOU9uemhyRUVmTFhXMFZmMUNyNzBwYTBQ?=
 =?utf-8?B?Rnh4c25wNm9ia1RqSDlIMUJ0NnFRVnFIZGN4ODdhVzB3SnI5cS94ekh2YVdJ?=
 =?utf-8?B?SzZDVHRMYnUyVWEwaVNWWFNiLy9zU0RmbENUVWl6bWhWcEJ2cGRYMHZOd3I5?=
 =?utf-8?B?dkhDaUpSaTZwanllRlVqNjhmN3F3dUE2ZHN4YjlDKzF2R28rNnNYTStuMy9x?=
 =?utf-8?B?OFh1dTNhT2xOMEw1ZEpTSkVBWm9URDVwT256Vkw3b0pVaE5QTnh5NWlIajdy?=
 =?utf-8?B?bVNDckZEL2M1enQ3V1dHNGFoUEdadWhEd3R6eEM3YmVKclppZldiTXhudmNV?=
 =?utf-8?B?MGI3YnNHNXRJck5GaGVZVWdiRlBrTWIyU211V283eExmeURrcVpaQUgzMTl2?=
 =?utf-8?B?Vk9mMk1BWHozSERMa2pocjM1TmtGTVl1dGN5UEVyS1ptRWthbmgxTWhsN0V3?=
 =?utf-8?B?aGZ4RG90ZTNnRm43L2h3UGpDSzRFNWRLQ0RVbmdMNUJYTTZIa0U0MUpnK29C?=
 =?utf-8?B?ZWl6Q1dLVUNIZkNNM2NwQldLM00wcjFtUW5qNXdVUXRQSkpKVThxTERiYm1n?=
 =?utf-8?B?RWdHZ2owU3JyVlc0Q25wNTNteHZFS2Q2Nmd0WlllVmdDUHhHVDQwS0t1YlBu?=
 =?utf-8?Q?7gH8=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc6487e-6992-494c-0c00-08dd492694c9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 16:27:01.1710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzRi7MR4/4l6/IHf8Ydhv/ZTz4mRoexKDWWuipkz8YfXhPMAVOI8rkQLecEIZQG8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6396

On 2/8/2025 9:14 PM, Jeff Layton wrote:
> On Sat, 2025-02-08 at 20:24 -0500, Tom Talpey wrote:
>> On 2/8/2025 4:07 PM, Chuck Lever wrote:
>>> On 2/8/25 3:45 PM, Jeff Layton wrote:
>>>> On Sat, 2025-02-08 at 14:18 -0500, Tom Talpey wrote:
>>>>> On 2/8/2025 11:08 AM, Jeff Layton wrote:
>>>>>> On Sat, 2025-02-08 at 13:40 -0500, Tom Talpey wrote:
>>>>>>> On 2/8/2025 10:02 AM, Jeff Layton wrote:
>>>>>>>> On Sat, 2025-02-08 at 12:01 -0500, Chuck Lever wrote:
>>>>>>>>> On 2/7/25 4:53 PM, Jeff Layton wrote:
>>>>>>>>>> For NFS4ERR_SEQ_MISORDERED, do one attempt with a seqid of 1, and then
>>>>>>>>>> fall back to treating it like a BADSLOT if that fails.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>>>>>> ---
>>>>>>>>>>      fs/nfsd/nfs4callback.c | 16 ++++++++++------
>>>>>>>>>>      1 file changed, 10 insertions(+), 6 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>>>>>>>> index 10067a34db3afff8d4e4383854ab9abd9767c2d6..d6e3e8bb2efabadda9f922318880e12e1cb2c23f 100644
>>>>>>>>>> --- a/fs/nfsd/nfs4callback.c
>>>>>>>>>> +++ b/fs/nfsd/nfs4callback.c
>>>>>>>>>> @@ -1393,6 +1393,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>>>>>>>>      			goto requeue;
>>>>>>>>>>      		rpc_delay(task, 2 * HZ);
>>>>>>>>>>      		return false;
>>>>>>>>>> +	case -NFS4ERR_SEQ_MISORDERED:
>>>>>>>>>> +		/*
>>>>>>>>>> +		 * Reattempt once with seq_nr 1. If that fails, treat this
>>>>>>>>>> +		 * like BADSLOT.
>>>>>>>>>> +		 */
>>>>>>>>>
>>>>>>>>> Nit: this comment says exactly what the code says. If it were me, I'd
>>>>>>>>> remove it. Is there a "why" statement that could be made here? Like,
>>>>>>>>> why retry with a seq_nr of 1 instead of just failing immediately?
>>>>>>>>>
>>>>>>>>
>>>>>>>> There isn't one that I know of. It looks like Kinglong Mee added it in
>>>>>>>> 7ba6cad6c88f, but there is no real mention of that in the changelog.
>>>>>>>>
>>>>>>>> TBH, I'm not enamored with this remedy either. What if the seq_nr was 2
>>>>>>>> when we got this error, and we then retry with a seq_nr of 1? Does the
>>>>>>>> server then treat that as a retransmission?
>>>>>>>
>>>>>>> So I assume you mean the requester sent seq_nr 1, saw a reply and sent a
>>>>>>> subsequent seq_nr 2, to which it gets SEQ_MISORDERED.
>>>>>>>
>>>>>>> If so, yes definitely backing up the seq_nr to 1 will result in the
>>>>>>> peer considering it to be a retransmission, which will be bad.
>>>>>>>
>>>>>>
>>>>>> Yes, that's what I meant.
>>>>>>
>>>>>>>> We might be best off
>>>>>>>> dropping this and just always treating it like BADSLOT.
>>>>>>>
>>>>>>> But, why would this happen? Usually I'd think the peer sent seq_nr X
>>>>>>> before it received a reply to seq_nr X-1, which would be a peer bug.
>>>>>>>
>>>>>>> OTOH, SEQ_MISORDERED is a valid response to an in-progress retry. So,
>>>>>>> how does the requester know the difference?
>>>>>>>
>>>>>>> If treating it as BADSLOT completely resets the sequence, then sure,
>>>>>>> but either a) the request is still in-progress, or b) if a bug is
>>>>>>> causing the situation, well it's not going to converge on a functional
>>>>>>> session.
>>>>>>>
>>>>>>
>>>>>> With this patchset, on BADSLOT, we'll set SEQ4_STATUS_BACKCHANNEL_FAULT
>>>>>> in the next forechannel SEQUENCE on the session. That should cause the
>>>>>> client to (eventually) send a DESTROY_SESSION and create a new one.
>>>>>>
>>>>>> Unfortunately, in the meantime, because of the way the callback channel
>>>>>> update works, the server can end up trying to send the callback again
>>>>>> on the same session (and maybe more than once). I'm not sure that
>>>>>> that's a real problem per-se, but it's less than ideal.
>>>>>>
>>>>>>> Not sure I have a solid suggestion right now. Whatever the fix, it
>>>>>>> should capture any subtlety in a comment.
>>>>>>>
>>>>>>
>>>>>> At this point, I'm leaning toward just treating it like BADSLOT.
>>>>>> Basically, mark the backchannel faulty, and leak the slot so that
>>>>>> nothing else uses it. That allows us to send backchannel requests on
>>>>>> the other slots until the session gets recreated.
>>>>>
>>>>> Hmm, leaking the slot is a workable approach, as long as it doesn't
>>>>> cascade more than a time or two. Some sort of trigger should be armed
>>>>> to prevent runaway retries.
>>>>>
>>>>> It's maybe worth considering what state the peer might be in when this
>>>>> happens. It too may effectively leak a slot, and if is retaining some
>>>>> bogus state either as a result of or because of the previous exchange(s)
>>>>> then this may lead to future hangs/failures. Not pretty, and maybe not
>>>>> worth trying to guess.
>>>>>
>>>>> Tom.
>>>>>
>>>>
>>>>
>>>> The idea here is that eventually the client should figure out that
>>>> something is wrong and reestablish the session. Currently we don't
>>>> limit the number of retries on a callback.
>>>>
>>>> Maybe they should time out after a while? If we've retried a callback
>>>> for more than two lease periods, give up and log something?
>>>>
>>>> Either way, I'd consider that to be follow-on work to this set.
>>>
>>> As a general comment, I think making a heroic effort to recover in any
>>> of these cases is probably not worth the additional complexity. Where it
>>> is required or where we believe it is worth the trouble, that's where we
>>> want a detailed comment.
>>>
>>> What we want to do is ensure forward progress. I'm guessing that error
>>> conditions are going to be rare, so leaking the slot until a certain
>>> portion of them are gone, and then indicating a session fault to force
>>> the client to start over from scratch, is probably the most
>>> straightforward approach.
>>>
>>> So, is there a good reason to retry? There doesn't appear to be any
>>> reasoning mentioned in the commit log or in nearby comments.
>>
>> Agreed on the general comment.
>>
>> As for the "any reason to retry" - maybe. If it's a transient error we
>> don't want to give up early. Unfortunately that appears to be an
>> ambiguous situation, because SEQ_MISORDERED is allowed in place of
>> ERR_DELAY. I don't have any great suggestion however.
>>
> 
> IMO, we should retry callbacks (basically) indefinitely, unless the
> NFSv4 client is being torn down (i.e. lease expires or an unmount
> happened, etc).
> 
>> Jeff, to your point that the "client should figure out something is
>> wrong", I'm not sure how you think that will happen. If the server is
>> making a delegation recall and the client receive code chooses to reject
>> it at the sequence check, how would that eventually cause the client to
>> reestablish the session (on the forechannel)?
>>
>>
> 
> In the BADSLOT case, it calls nfsd4_mark_cb_fault(cb->cb_clp), which
> sets a flag in the client that makes it set
> SEQ4_STATUS_BACKCHANNEL_FAULT in the next SEQUENCE call.

Aha, that's good. RFC8881 only mentions it twice, but it's normative:

SEQ4_STATUS_BACKCHANNEL_FAULT
     The server has encountered an unrecoverable fault with the
     backchannel (e.g., it has lost track of the sequence ID for a slot
     in the backchannel). The client MUST stop sending more requests on
     the session's fore channel, wait for all outstanding requests to
     complete on the fore and back channel, and then destroy the session.

I guess my question is, what if the client ignores it anyway? What
server code actually forces the recovery?

Tom.


> 
> The client should take that as an indication that there is a problem
> and reestablish a new session (and maybe a new connection). Granted, it
> might take up to the next lease renewal, but there's not much else we
> can do if the client won't talk to us.
> 
> That's why I was suggesting that we might time out the backchannel
> calls after two lease periods. OTOH, maybe it's sufficient to not queue
> any callbacks for courtesy clients?
> 
>>>
>>>
>>>>>>>> Thoughts?
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
>>>>>>>>>> +			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
>>>>>>>>>> +			goto retry_nowait;
>>>>>>>>>> +		}
>>>>>>>>>> +		fallthrough;
>>>>>>>>>>      	case -NFS4ERR_BADSLOT:
>>>>>>>>>>      		/*
>>>>>>>>>>      		 * BADSLOT means that the client and server are out of sync
>>>>>>>>>> @@ -1403,12 +1413,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>>>>>>>>      		nfsd4_mark_cb_fault(cb->cb_clp);
>>>>>>>>>>      		cb->cb_held_slot = -1;
>>>>>>>>>>      		goto retry_nowait;
>>>>>>>>>> -	case -NFS4ERR_SEQ_MISORDERED:
>>>>>>>>>> -		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
>>>>>>>>>> -			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
>>>>>>>>>> -			goto retry_nowait;
>>>>>>>>>> -		}
>>>>>>>>>> -		break;
>>>>>>>>>>      	default:
>>>>>>>>>>      		nfsd4_mark_cb_fault(cb->cb_clp);
>>>>>>>>>>      	}
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>>
>>
> 


