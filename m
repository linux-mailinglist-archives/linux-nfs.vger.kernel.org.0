Return-Path: <linux-nfs+bounces-11838-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3C8ABD933
	for <lists+linux-nfs@lfdr.de>; Tue, 20 May 2025 15:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC53189430E
	for <lists+linux-nfs@lfdr.de>; Tue, 20 May 2025 13:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9036241103;
	Tue, 20 May 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZaBg9ddw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I0pbifDA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B14F2417D9
	for <linux-nfs@vger.kernel.org>; Tue, 20 May 2025 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747747229; cv=fail; b=f3H2zQSsoVtkpKApg89uyqGpdRjLD7dQdRLbtB4iV0DOMc3MxdA9CVRvmRyJKJhVXgqyf4rb+h/PovPj2kgHrKb1zdoVMobovSYlcDHNJm1iA9kUjyU/e0+UUM4LH5DvTtjhG0WqkyP+gDDibvfh3/smq1AP1pxE7j0gOdosxzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747747229; c=relaxed/simple;
	bh=w01OG7h6Kk+ecMlPnz4+denQXIiP+aT+O4xJgEnecN8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lGhlAbY581t8f73aGWiPiUfACHNNdhbbLM1bL7w6rCqCfu441fpilyMmyK8MbI3g/siPb5FcGIe+XmzT9jnlUJWwEftJkwz45N/GbXC+NgpKudye5Qw8YB5yivv8cmoUeqv7Bx6PjJiaugLaKa7XIrk43LOwRMoWYvmEFQY4ICc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZaBg9ddw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I0pbifDA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KCu5BK014633;
	Tue, 20 May 2025 13:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/LhnvQ+OUVUEV+Yumi9Iqn9uUzrmS7B+JqcoO/tHxEs=; b=
	ZaBg9ddw+Ah2zooPQscOi/n6zRZ3dCMJiAna+6jNsqRIJLazoC9YKiFTTGT/mmro
	FmdbvMQbMa2zjB7azMisZRxpF/pxj+mJJAPJ3Na0LsMm6EYvyOsVuzxnRZXfYTDw
	ZPJpD0zI3kqZv20hPs+lU9DTt7pc0DsLQcuqrJzo1wf06Ke60koEl9L1gTZPMs/d
	OJSA9mRcV3n2exL+ELZjiUAfsFRWLlzW36NhO/vllj0+mjLiFP1ofgduHEzNVKRd
	w2hVW66mnZTwVZFej7CnxeCOFkrKE9NawdHPTSTgN/19iN1rgijTQDx4RsUS30yK
	BIl+8XB9LVBw/9lDX95KKQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rdny9a28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 13:20:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KC0720000821;
	Tue, 20 May 2025 13:20:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw80wnm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 13:20:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVOEYLsQc6wTGGr4kYIYMxX6SjuKaKfy1ywsoBHwmbbsXayyRf/cU94EvbvbQGHmg26JD51DLRkqDI2VOx7ln1jyHSfDK7Tog3VbDGuuxi34yi7EOdB6EvZbs8O/d1s62jakYlRfartUPelL2A9TgmYO40HLcfHYA8XdgQAtsQIAFQtVJF6f+S43aXCjRsq4QTKMBKozzUIuuZbXDdhK8zfJKEUaMm07GqNxraxH59sM2mBMy9V6PRM2z+OH/DKL/gjAL8/6a1qBQa9u8+K8Hf+SwzitjYjEdQPeUqG/hnHGVQBN/fI8nZMYZT/F1DyvDwAHM5qXvsxT45u+RCcw4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LhnvQ+OUVUEV+Yumi9Iqn9uUzrmS7B+JqcoO/tHxEs=;
 b=fV1m3ICvegXGKY/AwKvlsMjvuP0oSDu6RJGOUOJcFlGpYjCceMInLMFekuZIlL2NzFh0NnAJSQdDFiWRYrNwCUPzieF6In+1rWGk0yVEuI+QIZCqIZK8ACG0UpBMTOOoeApVJtEhCjQuMpVmLAQp3bXRDrjLocgA8xieCByDsOYzjDulLapXz1LpJMxeNv6+cAAO80hxtCq1/neahas3JzvxoIjvzVGyG9DF0gR+eOMKBcjWA+FSoA6x8SFHT3LS1+Wpw5Uw0Li5tKEfF1outRAVE3PaDSoYX9ILmAzqvqmwLWHXglwAGnEAypDmy1IDnWesdrLyv/raubJCeSWljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LhnvQ+OUVUEV+Yumi9Iqn9uUzrmS7B+JqcoO/tHxEs=;
 b=I0pbifDAm5fWSurphoLLqkObpJBDNZ0VLejmfObJ8aeg4w0LWciBP5adCqcCpmV6Y9pLGE5ftm1wac45xh0mh3R7yqQEtRZg/gir5KTK1on8W8AWUy2YXOgeWCyu0cKWYoIaMq6ssIoZRxuHi4jNFF8atyfWNYVfTKkMmAcSeGk=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SA1PR10MB5781.namprd10.prod.outlook.com (2603:10b6:806:23e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 13:20:10 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8699.024; Tue, 20 May 2025
 13:20:10 +0000
Message-ID: <8aa0e4bc-c95e-469c-9aeb-59e2f103a604@oracle.com>
Date: Tue, 20 May 2025 09:20:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: Rick Macklem <rick.macklem@gmail.com>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
        Steve Dickson <steved@redhat.com>, Tom Haynes <loghyr@gmail.com>,
        linux-nfs@vger.kernel.org
References: <02da3d46-3b05-4167-8750-121f5e30b7e9@oracle.com>
 <174763456358.62796.11640858259978429069@noble.neil.brown.name>
 <780a7e7a-b8c4-4ebf-ab79-d1480afb6b6f@oracle.com>
 <CAM5tNy5Utc5NYbEY+E_g91Hsfa6QiZsEo+MEwKHzvryQxe+j7g@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAM5tNy5Utc5NYbEY+E_g91Hsfa6QiZsEo+MEwKHzvryQxe+j7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::13) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|SA1PR10MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb54125-e8a7-48b4-eaa0-08dd97a10bd2
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NkVlbm9ubGsxU1Vkd2d2TGVpZkdpMzllWE85Qk9Hd29aa2tFU20wbW55cC9G?=
 =?utf-8?B?VXNEb1JWMWg1S3EvdVJ5U2wvOHBWdm1QWmpzbUV0ZVYvNmNzank0eTVsNjR3?=
 =?utf-8?B?MUF1aWluaWtLQktMZzdDRHFMenJITHhvV1J3TkpMZGpWeUkrRXVLbldvZ0R2?=
 =?utf-8?B?TEFIYWduMjd3NkNWSFV0K3pnc1h6dUorcXhSUkdocko1QzRTTnJQa2dtcjlZ?=
 =?utf-8?B?ZEVaVXpDUUNmR3ZOQURxWUowdzJTUEtETGhjeW05cjl5U0I0VHlsU3JMQXdh?=
 =?utf-8?B?a01rL1BMRmU4R0krNTZkdTlIVnloUUJ4TnpwOTNFa3NBZGpocGxieDJRc3Nv?=
 =?utf-8?B?YTUxNjNiQnBJVU4zN1p0dHM4SmlLelUwM3lEOU1vZmxCN05KTkpXWEhTZTVT?=
 =?utf-8?B?d2hlODQ2QnIyeTJWR1d2UE5kcmtwTFNTdDFtcUwvQjhDd1NYR2UyM0R5UVZE?=
 =?utf-8?B?c0hKbVl3SkdoTG5tbkNCcVhFV1IxWVRtVDJEZGp1bmxCWHJVcTZKdlF5OU9w?=
 =?utf-8?B?MFNlTm4xbUlQZDRGNUZXREl5emNoNHQ3RHExNzd4akdvRzR6OXVadXVLVGpa?=
 =?utf-8?B?Kys0Q1JhMXdUVlBWN0VpcklhaW1DSEo0SnRsdzdrdnJ1djhmVURqUDN2aVlR?=
 =?utf-8?B?WmltSSsxVjc5cUlQdEhJbUYwOGVBSll4NHo3bXZqNkVpcWlzc1FldUhtVVJq?=
 =?utf-8?B?NlZOaWFyZ210VVdHTDFyekhhYmtGbDJLWVIzWkZ4SGhCWHZlM2QzME1PWmJl?=
 =?utf-8?B?V2VWQTQ4K1VobzBzZlZoWk4vUFBFc2hLVHF3RjBpMG84OEdwU3NGS0YyenpS?=
 =?utf-8?B?UDIyZitXSkFmcGZUcFE4VVlrbC9iNzZUekhmaUxSWmZZdVQrSS9QSjF6cXNk?=
 =?utf-8?B?ZE90UjdieC9PaGc1dytUTTBPd2RZMjBLWVFjOUw4N0dxSTRadEJTd21icm5y?=
 =?utf-8?B?ZENYWTlEa1ZTdUVxbmRNTWRvaGZKT3NQR3RmVHJ3ZzFvbngreGNuQUhDT2R0?=
 =?utf-8?B?a1pINEt6UUxQc2h5dlFSaEJIbmNCZlNHazFvM21mUy9PWE5mNjhMcnhJL1Y0?=
 =?utf-8?B?RjN6R3pjbWdNanJNRk5uRVJrdTQxREJBclUvOGhNaVhnZnJEM1R2RFJ0TkxY?=
 =?utf-8?B?RFBjdmh3REw1VDlpRGRXaVRwZHVkaGtVQis5bTY1b1JWY1lXODFlRjRVZmJy?=
 =?utf-8?B?d0ZEYmxKY0QraUJ0MjlRQ2x4SHlSaUNYa3ZjajVOUFA3SC9ZcERMbmpzZmZC?=
 =?utf-8?B?WFZXQldKRVVSUjdJQ3pEcHpyZjRxekhlV2FzL0x3QnlpdDgrL1RsSWF0cEVq?=
 =?utf-8?B?ZmtSMjVRWmVteFFQUGNhK1ozeGJIbzhrRmk3YzVkd2VvNGlEYWJVb0k3UVZW?=
 =?utf-8?B?ZnBKNVZCV1lhemNmcStpeG5mRWhUUGc5WnVHQ0JzSC8wYnNCTnhaSmlNMk1n?=
 =?utf-8?B?ekI2YUNJalJVUkxwSjVCQ3lIWERHclZsRndSdnQyRjZtNXFHU1hjOGUybERa?=
 =?utf-8?B?dTRuVFlwRnNEcjRUS1RNbUlJOU1IK3FyeEkwYjM0OEZWR3ZjRDZzY242am8y?=
 =?utf-8?B?R2pCQ2JlaEZ1VlFjL1NtNXRINHIvUjBIYTdnYmZUdXBBWnJodEJoUFIyczJR?=
 =?utf-8?B?eTNTeTBTd3JacjhMais5SDZFaHEzc2xTNVZxYnk2YVdmejlqRVpyNFY0dm0x?=
 =?utf-8?B?YjJmOTZzZVpJbmJSWTh5QlpsY2N1UmpBTElmeGdVSVJYTmVNY05MZDg0dFZC?=
 =?utf-8?B?OFJrNHlMNGprUnZibC8rTGZ0ck1rOHdBVEhGU0k1RUNsVEtEL0FKMFQ1RFRo?=
 =?utf-8?B?L2dOY2sxTTNGWWs0TElqZ1ozNTRjV0FyMVYydXI2dXRYdVhyZ2dqemVIdmJv?=
 =?utf-8?B?WldtMWc2dUR4U245WEsxVkR3Qkx5YXUvcTlxcjVlSGlPZFE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cHhmbUJGbDhSb1Z4UE5sWXFUN3hYeThqbkpIc2oxRG1NWHlZa09iUENDWmRV?=
 =?utf-8?B?OGRoOEplVjV5eGYvYnY3bDNySGdXSU9IR3BTUHovVVQ4aWVoc2lSUmQvM2Y2?=
 =?utf-8?B?K0orUG1HRlQyR3BRZFYvVTZjRVhSWTM2c2QwKzV2dE5LSjlkZ2ExYWk5YUI3?=
 =?utf-8?B?Q1dNT1NxOGFwbzJPZVRIQXpUZWZOMWxvN1ArT0pnRmtnL0V2ZitFZDBSTCtR?=
 =?utf-8?B?OEllaXBqam9JaG1pdVZSL1RPcHp1L3VleWxHS1d0aFJCeGJNWlJoNTd5alA0?=
 =?utf-8?B?WDBteGNqSnk1UXUxNzdyTTYxN2w1V3doYURaR0o5cWZUVjkzZzJiWW5FWFZD?=
 =?utf-8?B?eUF3R0FCRHk0eEhZenQxY20vcHlxN0tndlUyTjZKK3ZYb0VET3MrWXB3OGhD?=
 =?utf-8?B?WVh3M0NpSVhjSmVsMElJTDgzdDRYMHliOVlUSlFjNVEzT3lFV3Z2bldBa1Ix?=
 =?utf-8?B?MlhMNnlyVTlkRUE4M0xaYzlRSy9iM3RKQ3VWUkQvbFg1bmE1N3BsWWsvSjFO?=
 =?utf-8?B?NE4vV1B6SVpmUG52dDFXcnVtejZpN0YyejU2dFQrSUlZRDJLQmlYZ0luWkdH?=
 =?utf-8?B?UWloRXVhdjJSc0QzYk5yWVdRMGlWait4YmFlcno5dW55TlRyWEtSeDl5OTdI?=
 =?utf-8?B?UDVuREhqR090eDhUeldwaGtEK1VxOWpTSkJjd0hIeXg1dnA4SkEzdjd4dTVq?=
 =?utf-8?B?aHZoeGgwZGNtTysyTmE3SFZjR2JwUkU5UGgwNld4VFBvZTVUeENVVDRpaVhi?=
 =?utf-8?B?YUZnWmRDUmpBc2d0UW5laW9naVBFMS9CS3paMjNsNzJRMUFkN25CeVZNV3V0?=
 =?utf-8?B?SHhGVDlubWliSXBVTGY1bmlYb3puMVpjVjNtU0FmSFpwYkZ0M3dwa0ZabmE3?=
 =?utf-8?B?NDlUVUxhTmtqVkxTNU1PM2dYVUowMjlGVDVyQkVoMnFQQmtaUEJSdk1MdU52?=
 =?utf-8?B?R0VXN2Rnc3Z4bFAwa0lHL2FSN3VNRkI4OEgzSlRVUXdCdkdBUTlYUW8wTXdW?=
 =?utf-8?B?SHdmNURybUFZMkh0K2lvUHh0STdOWXh3QmN1bjd2bEtSTDNkOVRXRVVBZXVJ?=
 =?utf-8?B?K1hjcFp1U1R4K1I5QitXaVJqa2JNN0lzdDgrbE4vQStBZmYvdTZkT0tKbXNp?=
 =?utf-8?B?Tm0rQXBPMHFxejVTMGtqUS8xWGZwVDF0VlEvMFdzZFpWTnhrVlNSVVk4Tjk5?=
 =?utf-8?B?MFh3NEdvRzY5SXlNdTd0ODBqS3A3STYxN2dHcE9lNGZuV3kvZmw2Q043MEFX?=
 =?utf-8?B?VS9EaTZSODJRdS9iNlo5TmRLbWhSUGNxaXZSQUtxQ3IwV2U4TzFNa2xDQTBZ?=
 =?utf-8?B?MGFBUkJZaHBRNkd2cDJVc0dEcFlDNUF1WGRNMloxa0lsRkI4aWpjcVB0ZndV?=
 =?utf-8?B?ZmVEa0JpVUNVbkE1b2ZEaXVzcm1PQ09acHpjY2gvdDJlM0NGM1RqbkNpdmx4?=
 =?utf-8?B?OUo3NFgvRWx1dnJUcWJ1UTZ6Zk14aGEwdndESTNOYjJUUlBsQnpCdTlqWVND?=
 =?utf-8?B?VFZCTDIySDFFNGtRT0xrbjc2dU1Pbm13OU9pNFN0V1FlVCtUdlpwNWNNK2xB?=
 =?utf-8?B?U2tPNklmTldnVGhqVSsxTVdsc05UdnhFQXdWdk1ENktRcWNJN3VhUzAwNW9T?=
 =?utf-8?B?NUhGcjhqRHVKWVBQUnpUbjRVUFFxVFlEb3o5OE4vUTNwZDkrMmluQUtYNDZK?=
 =?utf-8?B?UUNmRHJPWkFPSWFLL3pkRko5eGowNHc0eHoyOEtkcnYzYXdWS0dRRVlpVmRr?=
 =?utf-8?B?bk0rdXp5UUcyUmJ5YXBScEc2Q3lGQzdsZmYvYkpiYkx1TUNqdHh2VWRFUmNQ?=
 =?utf-8?B?TkRpZGFVazhnQi8rbUFvRFI5T3hWQnRhMUpJV2xjRXo1dG1mejhDcUtuRGxm?=
 =?utf-8?B?S2VrUzdRYzE4cnYzcWpYN0ZaWm5seFlyMlhVVGZneWtHZnphZSsxbFI2K0FV?=
 =?utf-8?B?b21KL0JWS3JSNHBSRDZ0K01oUjNzcDVSdjV3RXRiQ3pub0hwcUlzV1JaY3E1?=
 =?utf-8?B?K2pWSnFwNFlyQkRKZ1VuR2Y2eGxaSGowcDhuZDFHcWlCWHdUSlMyalIxZnpD?=
 =?utf-8?B?Q1VSVzFlNFg4UTI1eUNQMTI0djkwVDZRT2pha2M2Wm1wOVR4VWxUL290S2JT?=
 =?utf-8?B?TnNscUpQRWgxZ2JSYnF2V3NadThuQ3dBWTgxai91QTg4djhKTVRYaWRDRnF4?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W8+XnxW9qDzy+EvSMfygexb99zvDC47b8mwb751jbUKkveF+1yd9LpOPZIAdLua+3tEuhWpebGcROUwp5FZ1lFhPnJcA9bi3W+pWB6U0l2zrmVzy57gdS//l9x/B8/Wr4JWDnKE3lzTEThWJ3A3hLzCylgxes+RHXEQfKZQVzc7E2diV0f3ODCWgkaA6gDhfyOzOu5U2so89UePwmeDr7bGNmxiW9QWh6Wfp96NM1cm8Ik16GSgcHbUVnPzfm43eP7+LVHGcmD5acTquoq6oR/l7PRkdoymDfHjMqh0ILdr6vu/m3U68aIlPhHhUwn9G/OvLzPTOpw0zvuzrDpdxbp2bTCqU+givQlkoMVfVEmJEva+zDGjko9CzGSMXavkYDE/S4Siox/YdZGR8SXPma/7iWJHQT1a5OTA9NbAacWxY/dwnf3kiVwPShEG4fRLckX0sBX9J3QuPpgnzEMQl59c0FBEp080U5oBEZlEyo7Xq0nGNue9XH9DaD/BG8bGmSpd141jNYwOnAyh5jonOFcQkp/xj0EY64OfhFN5S0xlKB1PIgoHDvO+bNGM6zrIn4VSfjnv6PlXZFxs27d8aQv59csNUrYpB2irWZPAxOJM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb54125-e8a7-48b4-eaa0-08dd97a10bd2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 13:20:10.4323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oisayc2cgiSxlPTOx3ik8VZjDdbzWHhNuHv8Tc5eKTAv2VXC3QKA+wy6MuOhPazQHR0HOtTCCsBC0NrTMnfIrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505200107
X-Authority-Analysis: v=2.4 cv=S93ZwJsP c=1 sm=1 tr=0 ts=682c8196 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=KC2WN_IlM98E9sVeN0EA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14694
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEwNyBTYWx0ZWRfX1hKIGrp28OYY 5drJwsu3ElX7g0xVod+GbHkWCwNPdH+7LoqMi+Nz/yTeIPzx842HlG46t+/Sa0yOrEi+hGqkvH8 T8i5d2htGRtwPlwQ3WVruPNm1c/RpIWFphg7Dx+42AIvAkNMH1q4g6Dxt5RIDink8khRyxoNs8a
 0gOUTjVmBBAL3utRJ9M7s62FQcqTQy7SKaOEnfQqrbFa9bSD5J2o2qqrOjqZv48X3Bj4O3PmSit q962vYwC/0dkQ1qat3PwwBFuBMAMufDZ4MJhNFjuM9Whx0b98WV7DxkXDuu5UJ27H+jvkm/vUHJ sW8JzjNkfFBuAG9XzViIh/fifW8c177jyKWkaQ5p9pjWvwtf80enkaSKcg9Chsn+rJpAtx2kX1q
 q8/71SV9aEHUtK2tcxpeZkw8APr1SM8jU1u50OH0Rg1ZKcHm9fzIXdSpZcB5shrENzFPsU2C
X-Proofpoint-GUID: CGI8vuTFMhK5BBLmtPCv09pb6R2ljdO5
X-Proofpoint-ORIG-GUID: CGI8vuTFMhK5BBLmtPCv09pb6R2ljdO5

Hiya Rick -

On 5/19/25 9:44 PM, Rick Macklem wrote:

> Do you also have some configurable settings for if/how the DNS
> field in the client's X.509 cert is checked?
> The range is, imho:
> - Don't check it at all, so the client can have any IP/DNS name (a mobile
>   device). The least secure, but still pretty good, since the ert. verified.
> - DNS matches a wildcard like *.umich.edu for the reverse DNS name for
>    the client's IP host address.
> - DNS matches exactly what reverse DNS gets for the client's IP host address.

I've been told repeatedly that certificate verification must not depend
on DNS because DNS can be easily spoofed. To date, the Linux
implementation of RPC-with-TLS depends on having the peer's IP address
in the certificate's SAN.

I recognize that tlshd will need to bend a little for clients that use
a dynamically allocated IP address, but I haven't looked into it yet.
Perhaps client certificates do not need to contain their peer IP
address, but server certificates do, in order to enable mounting by IP
instead of by hostname.


> Wildcards are discouraged by some RFC, but are still supported by OpenSSL.

I would prefer that we follow the guidance of RFCs where possible,
rather than a particular implementation that might have historical
reasons to permit a lack of security.

I'll need to find out what flexibility gnuTLS offers. tlshd on Linux
cannot use OpenSSL because its license is incompatible with GPLv2,
which is the license the Linux kernel uses.


-- 
Chuck Lever

