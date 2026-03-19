Return-Path: <linux-nfs+bounces-20280-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P4FHE09vGlxvgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20280-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 19:15:41 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C341B2D0AE2
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 19:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74E4F3285520
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 18:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED353988F1;
	Thu, 19 Mar 2026 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eTWj4fPH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I03YHcGB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1876039A051;
	Thu, 19 Mar 2026 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943679; cv=fail; b=mVtQqhSHE8Xy1KA0T92ZN2wmH3UC+ZULy5qTRtF9kXdJ0VafYoTF9yEvqE9MZOhOpv+E8zlxrOIg1BpPspeYe5CIZFAtu1fPoZHt9GzMBPem8Bu0hNlEIjc9hAQFmKS7QK+Gso4zGi1XBhHoOGX/7rYswDJD6C0GasIqfDyDosI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943679; c=relaxed/simple;
	bh=pi9xkXrwHf4T99pSggyJavW2NuYUV+SjZawA10xYJtc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kHBO23/n36KU6hPWuvEmv80dp+VsGSh6277RN3etVwd9YcHHeZVw33zU5MHAmpOmSt/AlqL3vUc85t+Y2cfT8cP+FMTOWnRfRg6E84Jz01FzjfQ0Nx5UCFjdWGy3mNbA2NSvhTEM2ZKvouiyNlPJ0VLgR6SeLYxMJLYUG5j1Q/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eTWj4fPH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I03YHcGB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JHI1Zp3985954;
	Thu, 19 Mar 2026 18:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MD2ynwbr3JsVAlG+5qWXxWh9cOnYj/a9XAFxVyXc2WA=; b=
	eTWj4fPHLg5p2VIQoHixHyoIkkohBWjQjdTkGvrnT0YSfSygp2Kx6caqDyj0+EnG
	hSgzHOblVpwed8fcAR/tWDV2hiMjfmv4+R9Tv68iIJppaUO0EMSOC8MLHtnQKB9G
	ndHeYTRut00/ua0XLP2445eJeIp1NcWHBhJDmAei0Yq7Mio0wk86/txw6t7/ATS0
	qSyJWD0HLAkHyHlnHeSMsrbPcZGGTt0fPqidpf90x2ro+hPG1S3xIZ3mQXyLQOfu
	v0isZQGGtHLYE7rD7POAEOgc3SK6eJjTtMtxPNyAxx2PMO4jDo9JS0xyTThEJ+CT
	TmVSbbcZVY+RvU8WLNaedg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cw07rggh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 18:07:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62JGwCsw030734;
	Thu, 19 Mar 2026 18:07:50 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010067.outbound.protection.outlook.com [40.93.198.67])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4d9kg7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 18:07:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EU9EQBPi/XnUsMr5eDfm+qCmE+p6w/VnIVGp1ZcOux8gDwcv1LflCPzjdxrE+eTRY4X5s/3u8jS4tF2AuWEiYX18NiD0OW6kQywNlCPvxVwzNj6dpeF+8CLknXtZJRlZVDRQbasut7xVoFvWNg9ss9jwedPCIcwhMA3feRKg5GOEMyi1IvU5+cKVMO2TUHZr8jLlBTyyMBiwm7Zb/bknlip9TbujGwHlvaHmFhkWSc89CO+3bUbTxmkgB5GG9rf+2PyPa/kyIraDcQjHaQ01XHgu9I3inxMsi8VpxD8lMlMNjibxTyPvCClgY608Apyutyq57XSOtReXj4OleHjBmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MD2ynwbr3JsVAlG+5qWXxWh9cOnYj/a9XAFxVyXc2WA=;
 b=Dk3Dlscs1Cc+U1q6trYqfbII5wVkNNVFmat0psEzwi8KM3oBZFCHLl7jisPcWFPtN7CdaKlYxpw9zTKCE3sVLa5Y8Lsh5Bu8QLNQI18XsHMeGN5z5P7vndj0di1EEcmWwKH+5Pl9TRuZZuydb+I/wHhYIXQAtW4MKI9vvbONp09sC+AsEY0nB+k7A89+n4Z64RmYC+gvwJOLiZQJsTzwXpQu0rzPZhVgMe5cnXd0u2aRggiguf+CbJFqjfgTvuEzqFjfspiWTJbtZm/R8Dierg/cG9hOeq/5uTLWcYadoCKF4jRNk4VET31gvYgGO9HJDzixSSbwsZanMqM+LRR3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MD2ynwbr3JsVAlG+5qWXxWh9cOnYj/a9XAFxVyXc2WA=;
 b=I03YHcGBoUwGhW9aG+4gaqMusqssfquJb8pERPJgA8P9ob6SBimlouT539kiCY5SsGFRmxNMwQ/UmZD0fsdDcVdPWIoQ6uNabdXoGXaWYv8U3M3rbqCrsC8w5PdkQ6H4atW4mJUp/47sjOWwLkXEKWJ+xPzth4InOPUbhsjVTSA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4714.namprd10.prod.outlook.com (2603:10b6:806:111::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Thu, 19 Mar
 2026 18:07:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9723.019; Thu, 19 Mar 2026
 18:07:45 +0000
Message-ID: <0908b7ac-658f-491b-89be-f5a1d97e991e@oracle.com>
Date: Thu, 19 Mar 2026 14:07:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] sunrpc: add helpers to count and snapshot pending
 cache requests
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
 <20260316-exportd-netlink-v1-6-6125dc62b955@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20260316-exportd-netlink-v1-6-6125dc62b955@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0016.namprd14.prod.outlook.com
 (2603:10b6:610:60::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4714:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b31ddf-3d43-4d38-a41c-08de85e26bb5
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 wOo7QuzKYjb9IiwM7sBWbVEsDOVyJscU8zfVYx0OR3Enbp3srnobJ8Vi+qaU2QP+H7xW5n/xRBVlz8NvTeuodn1JOmrZRe4wFRpiGTQyH9o8FhOGl0F7UkwTV7aKUH5lKrVduEvCydq1k1kfNT7SG/mPhjMWwwFxaUDcMKSfc+RnZMc/YibWsTzsnxiRG01F/+GIFZpSmyYlzsdXKf2qVzs7wXcGFkUuFKadF/b01x8tNEjWm/KTV28RmwloRCkkvzwP8sVdv6fyWIWY6eiIKqLjRQd8xEapYwWHRU9Vvwy4foErD2nxNTQtdnotw57nyWdA+w2Y5OQhMjvN/Rk2Tmpc89upAdFxWj14uKYknbPI1KaVUkMoeP1/COwOGtoGZgTYGIYismBCaTHOoDUkBTuxkOZ0raXUw3nMd5kMt1qwGoLvPZwO01gtxoy9kJ3LJE/uBHw6dYlk6Ru5eCPazJLfUtG6DD34pAHFT/tiJ6BUxxT06+Np+B6CWPz1NzgurawWxTDxsYEMPADXCL7ZE/lrFlNHozeY7B+zF2EK9hb3DlT4L5Cyi/nLwphB8TYP/PgiQ+K1E+dWbyZxh072iTgOdelBEKEJMdV/mxK61WugRgP1T08jUqlgeTmROkdo/TdzFsy/hGFdHeo97iGzwR9wC2xs9fdvVXeF/Ifj/sHRyQ9rmAqsrsKlBAF2h/X6tV3wt3/6bF+3IfB9HIyFqvDieRfCVXGgcSvBWgnne7E=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?czVmQWNWOER6WmViWXBHYXJxY0VJZE5mUnpPTnlHQ2JOWkN2c2RQU0tDMlc0?=
 =?utf-8?B?cXhid1R6cVJZajVjcVVXNUhQZTRTUXNGYmlBSVRpZGxJVVRuVlVMSUh6Ukpn?=
 =?utf-8?B?L21IcWk1bW9EZW40Z21NM0FSN05RU2xRVVpnSkVSWWRvbVRHWXp4ZEdKeWpo?=
 =?utf-8?B?ZUUvWHpmTEJHTmovNlhCNUVpUG5YYWFzSnR6TkorMTFOa1MyU1IzRWtMeVZO?=
 =?utf-8?B?cnFoMDBtc2tXcjBzUi9SY0FsNHZpMVRwdHhaRWtqNzNVbjJLUkNCMUNCVEd3?=
 =?utf-8?B?NG9RT0Nzb1VuV3Q1R1gyeTRVaWZUejF6azg5UTdyWFo0WUJFbzE5MlRwTHU3?=
 =?utf-8?B?eFNEOTBlSUp6MjdMNEE4ZDdFMDQ1bnJSODlQQnlLTzl5c2tsbDJDR21JLzFU?=
 =?utf-8?B?b1BhNGpZMXV3UUhOTkhwWDVuZXI5QTJGYnduY0lUOVh0SnlTM3ZJU3M0MUFu?=
 =?utf-8?B?emJFbnlDQm14ekxrS1ZVY2tRUXJyVFA5eDdWWGJFVGU5S2M3TW8xRjFtZXRi?=
 =?utf-8?B?Qm9tektKM3lxYkpqWHJTSlF6NXBBelM5aTJMcWFUKzhIWFBkZithY21IdEhm?=
 =?utf-8?B?MTR1WFhicnIzOEtucXdsZnJmT1JxbHVzN1FlenhLMjBNZFZ2SjF6N3A0Ykcy?=
 =?utf-8?B?dTdBK0s1Zk5nVkJJSXQ2bGt6ck1MSzNmZVprUVRoS2dHQ2Z0QSt5aTJOays2?=
 =?utf-8?B?NTFTZEVwRFR4eVVLUFNIalhMNmEvenorb2MrRjFVb2pVNWZUMFNkMDdka1pL?=
 =?utf-8?B?cnJHR21yTXlCZEdITy9WTnJuV3hsU3RWY2VWYVNNcjhEK05rRkVJWHBJS05q?=
 =?utf-8?B?aTJIZGRvSzZDc0hvNjNoNUZOZWxPTUtzaStOREZwa0lEL05qTzVINzZxTytt?=
 =?utf-8?B?R2NqWG1RVmlINlhwdllrb0lSSE9DSmVXcGtyajg5TERjYmgrdjZwbUJJYTlL?=
 =?utf-8?B?c2hVQUpuYms4TEl5MVBrNTJQOEpQK2s4RDJGcUtYMjBxK3FSWWJYV3I3NENh?=
 =?utf-8?B?WUI5SjlhNWpHYm1ycVBpeDlSSTlkUzJySlJzQmVQamR2aVljWkxhMHQzTjJ1?=
 =?utf-8?B?eDVVQ0dZMUtBUzdFenZHKzNXdlBTZm8yRllSL2xZY1p4QzdBVTZDYWpNWFUx?=
 =?utf-8?B?UU5nNVZEZkE1S0FHQ3ZIaXdpZkVSMk53UXlDbmhWcWdJRHQzcTIrbnpBMmll?=
 =?utf-8?B?QkxSSzVHaG5YVmxPczVOcmpOS1B0NERpTWhlV2phZXp6RWRQdWhvYzl2YTUr?=
 =?utf-8?B?OURDNDFXZmxxbUxzQjkxMkxRK0hMbjlublZjSWVScEJOU3JIRmZMZmFPWFAw?=
 =?utf-8?B?YTNTVHBYYkc1UVo1dUZhcSttRXdvUlhBZ2doZGYrdHMrT3pCdVk0cTZqWTF6?=
 =?utf-8?B?WmNURE9OWUM3ZUcyYUR5U3c0eURYMWtKTlpSZEZvUit6RGJJZU82WjVxUVo4?=
 =?utf-8?B?UTN0MTNFTDF3S2x6VlRSSmVUZktqbTBnUEUyb0NNT2ptRXNkMnZFM2ZwYi9t?=
 =?utf-8?B?b1B5M3lUcktiR0xLUXNGbUxxWFJ1WTdxSytkU29keUh5SnQzYUU2MEczaTJF?=
 =?utf-8?B?RHAyeVR6QzVGQmFoNTNMQ2dmTW0wbHl4WjNOdDJBN2ZpaUpGODArU3hSUExt?=
 =?utf-8?B?QXRnNlFGeUh6RkFrbWdQdTNtWGJrY2ttQmE0TzVGR3JZSFgwT3F6OHFWTWhV?=
 =?utf-8?B?SG1UUkNtblQ4ZXNDeHpreVpjR3hSKy92VjRFVkVqK3F2S0xWUjNRbDNhbFU5?=
 =?utf-8?B?bHBwdEJtaVZtRXlLTzdRNGc4YmhxWFdncHVTWHVNdjNvV2YzMWxFWFVJcDV5?=
 =?utf-8?B?WGJKdXUxcm8rMG4wN0pyZnVPcEFRdDhydzNTNU9oUEJVLzdjUmZ0SVJPT0E0?=
 =?utf-8?B?OU5KVTVGYmZWVGtaNk53U1lqbWlubVhpU3hiRit1S0x3RHIzOUg0ZVVmWnc5?=
 =?utf-8?B?dlVTTFlSM3hGV0FoQTh6QmFDZ0VEYW1wVk9RVjUvUzhZYjBaMDZMOEwrSVdy?=
 =?utf-8?B?cHUrOHhKWldNTjZidGFhU0NxeEk1MGFBQ0JrV3BORnpiZ3hJZ3d3TVJGNHlh?=
 =?utf-8?B?VzdQTVNQVmxWOXhvNmkrM0NiakN4Ukc5RTJGN1A3S1hlenJzV1RSY0x4eFgr?=
 =?utf-8?B?QXhrTEM5Vk1taWdTVmk2ZW9JTy9kWnI1OHMwVXpPYUVLVy9aM1Ziem5jQXdx?=
 =?utf-8?B?TnRnelVjcVFRVWEzaWNMOXFVRlNJeWhSWDRmTXpMOTByL3BnMEJvbjJ2NlIy?=
 =?utf-8?B?MDNsNFp2MUpZbUNIUXZWb2F4UkZGMENLNHZFWTVNbEZ3T2lGZEdRYU41Rzlt?=
 =?utf-8?B?aVcrR0RoYkpiZGl3cTh5dkFkdGF0UXhVc3hxdlN4YnloLzJnNW9Edz09?=
X-Exchange-RoutingPolicyChecked:
	Uq3QHfJ2wADJ2J/5PHyirqgmpB9ZdkJAwFd5pCbraU0qKYcJ8XOkiha25ZWgLySyCXnijOCA7c49G9WEZvtJt5mRSKNHQpozwDwd8tfNsfcOnSWh+MsgxCGZr4CYhZAMKLkVutHZ2XwZYw03V+eOeSShqYcw0tiPDtVPS5mKCxGHK+n3rTxWo+vJ/SXOnSFvm+muNbBU27Kp9KGOXNiiASsh8OQqTU/VXgt9xHSNBmAQNAzTjUpVc1Xb5c0eyiH4A5lJTlkToFX+6SOf3RP4gmgKKEfncPA78f5p0SiEAdOnuR+bDrc/O5IeJZOzQhA32OdZ6VoZfIiE6BESkXJAmw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hN1Vv8zmkfCVUoKoNBhzT/pR3XAuRZ5hMVEZ//OZTrRgM3Zj3uHfrr9sQ0Tx+l8LqvGlOQrYQUvkYwY07FNXMvZiVMftIVWYHoK0+l15mf8gj9jQL2qagDY4UfBmXZU4Yjqxiio8CtFBPtjDKgbsvUY5UcfRDTxDswy4pj4jDUGUJYb4kZx7DzMbGJTs9ugsY4t9HW2i+vewd3M+rFPeq2whijH4E/5zOHxf1AiTrXl5l9tobdU7IydII3INdZPzjP5SVUdd1lcXX7HfUnu6A0GaiBk8BdcU5/dLe39qDRfRU2JBjcz4aL/x3n6gLUi5lE6k/89a9vOfMnGve1GV/W0Pi+Mlhp5AZHq7ZfrQYvkUpeTBLM37Bu6HHpmyprRSg+Pfw2W4KD9M09y6No+75HTE/uGBAORBr2IIZoheedVxYfuEOgrFXQgniZBlv5n1mVz6Lhyl1NnzIDfWhqCxXpkbzm3TvfIaN1876DM1J5UnfTYdacQEw1O9r3qWqv8H8fy59RB5yKFAs7J7lG/Qkwu+ejGxeXyrTcO9lSB7fTtmSQqRidoG2mKmhjk3dnb4SajxQAtM0PpwNbvUZxxwLm00uoELjfici9+wO8NRZn8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b31ddf-3d43-4d38-a41c-08de85e26bb5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 18:07:45.1419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTU0N6rjh7dNfNbBAIWLnjukOjpibF+QZxzpzb8ftckQS/3wlrEHTovOlv8eQWeyFxZxzWC0v5qy9bYSwr9jrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603190144
X-Authority-Analysis: v=2.4 cv=HcsZjyE8 c=1 sm=1 tr=0 ts=69bc3b76 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8
 a=lyYOG8JIML_z2Nq_F4kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: O7QAxWe30_Ex9IjvSTj_WHNhbSHya6gj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE0NSBTYWx0ZWRfX1fB3sieZ1Pfv
 AFQkm+IeYlEb43HpR6wC4MdKp29zahNBBJ0iFAfa5S1Bia4PjWWZgHS3ZdHE2n3QElLMVrWTEI/
 +pDKdLFXSGJCVLu8ZrHlBc5pV2bJw6gZxbI9scuMLBS6OKbQUriDrAxkmGyTbCHab5pOxE26U9l
 nK0QLqv3VCz2bnjTLkRVbzzooAUpPnKFhuL35ee0g9us+d/Ek79nczHhfUlz0TUhbuza6xyt5lB
 7g66+P6lCOM/2YJViIPI74kb6at7BiRDjYGKkWscdHnWW/CmgNEv0YrJ7Npzx2XsDwmQYcE1k9x
 tbWuk9pNGpFgfiaPcPaHpM7e5BL5KY/R/i2lsp+DKiAOU1RsBRwQi/L64bpSChj01v4CNMq5cJV
 FeEz1uWi80rdC+Ppab206j7Xfkwqu9G9pEuwrm5AX6M/6Ws6NrAc2IUPFvT+DGtkzH4M7h5ATyP
 EPIr1d5dFYbbgQzS/YA==
X-Proofpoint-GUID: O7QAxWe30_Ex9IjvSTj_WHNhbSHya6gj
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20280-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C341B2D0AE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 11:14 AM, Jeff Layton wrote:
> Add sunrpc_cache_requests_count() and sunrpc_cache_requests_snapshot()
> to allow callers to count and snapshot the pending upcall request list
> without exposing struct cache_request outside of cache.c.
> 
> Both functions skip entries that no longer have CACHE_PENDING set.
> 
> The snapshot function takes a cache_get() reference on each item so the
> caller can safely use them after the queue_lock is released.
> 
> These will be used by the nfsd generic netlink dumpit handler for
> svc_export upcall requests.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/sunrpc/cache.h |  5 ++++
>  net/sunrpc/cache.c           | 57 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
> index c358151c23950ab48e83991c6138bb7d0e049ace..343f0fb675d761e019989e47e03645484e0aa30f 100644
> --- a/include/linux/sunrpc/cache.h
> +++ b/include/linux/sunrpc/cache.h
> @@ -251,6 +251,11 @@ extern int sunrpc_cache_register_pipefs(struct dentry *parent, const char *,
>  extern void sunrpc_cache_unregister_pipefs(struct cache_detail *);
>  extern void sunrpc_cache_unhash(struct cache_detail *, struct cache_head *);
>  
> +int sunrpc_cache_requests_count(struct cache_detail *cd);
> +int sunrpc_cache_requests_snapshot(struct cache_detail *cd,
> +				   struct cache_head **items,
> +				   u64 *seqnos, int max);
> +
>  /* Must store cache_detail in seq_file->private if using next three functions */
>  extern void *cache_seq_start_rcu(struct seq_file *file, loff_t *pos);
>  extern void *cache_seq_next_rcu(struct seq_file *file, void *p, loff_t *pos);
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index 819f12add8f26562fdc6aaa200f55dec0180bfbc..2a78560edee5ca07be0fce90f87ce43a19df245f 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -1906,3 +1906,60 @@ void sunrpc_cache_unhash(struct cache_detail *cd, struct cache_head *h)
>  		spin_unlock(&cd->hash_lock);
>  }
>  EXPORT_SYMBOL_GPL(sunrpc_cache_unhash);
> +
> +/**
> + * sunrpc_cache_requests_count - count pending upcall requests
> + * @cd: cache_detail to query
> + *
> + * Returns the number of requests on the cache's request list that
> + * still have CACHE_PENDING set.
> + */
> +int sunrpc_cache_requests_count(struct cache_detail *cd)
> +{
> +	struct cache_request *crq;
> +	int cnt = 0;
> +
> +	spin_lock(&cd->queue_lock);
> +	list_for_each_entry(crq, &cd->requests, list) {
> +		if (test_bit(CACHE_PENDING, &crq->item->flags))
> +			cnt++;
> +	}
> +	spin_unlock(&cd->queue_lock);
> +	return cnt;
> +}
> +EXPORT_SYMBOL_GPL(sunrpc_cache_requests_count);
> +
> +/**
> + * sunrpc_cache_requests_snapshot - snapshot pending upcall requests
> + * @cd: cache_detail to query
> + * @items: array to fill with cache_head pointers (caller-allocated)
> + * @seqnos: array to fill with sequence numbers (caller-allocated)
> + * @max: size of the arrays
> + *
> + * Only entries with CACHE_PENDING set are included. Takes a reference
> + * on each cache_head via cache_get(). Caller must call cache_put()
> + * on each returned item when done.
> + *
> + * Returns the number of entries filled.
> + */
> +int sunrpc_cache_requests_snapshot(struct cache_detail *cd,
> +				   struct cache_head **items,
> +				   u64 *seqnos, int max)
> +{
> +	struct cache_request *crq;
> +	int i = 0;
> +
> +	spin_lock(&cd->queue_lock);
> +	list_for_each_entry(crq, &cd->requests, list) {
> +		if (i >= max)
> +			break;
> +		if (!test_bit(CACHE_PENDING, &crq->item->flags))
> +			continue;
> +		items[i] = cache_get(crq->item);
> +		seqnos[i] = crq->seqno;
> +		i++;
> +	}
> +	spin_unlock(&cd->queue_lock);
> +	return i;
> +}
> +EXPORT_SYMBOL_GPL(sunrpc_cache_requests_snapshot);
> 

This API architecture introduces a TOCTOU, since as soon as the
queue_lock is dropped, the count can immediately become stale.

The count returned by sunrpc_cache_requests_count() is used as the array
bound. To wit:

  cnt = sunrpc_cache_requests_count(cd);

  items = kcalloc(cnt, sizeof(*items), GFP_KERNEL);

  seqnos = kcalloc(cnt, sizeof(*seqnos), GFP_KERNEL);

  cnt = sunrpc_cache_requests_snapshot(cd, items, seqnos, cnt);



This appears in all four dumpit handlers (ip_map, unix_gid, svc_export,
expkey).

This isn't a memory safety issue; _snapshot() caps its output at max, so
if the list grows between the two calls, entries are silently truncated
rather than overflowing the buffer. If the list shrinks, the arrays are
merely oversized.

However, the practical risk is incomplete data returned to userspace. If
the caller is guaranteed to be re-invoked (e.g., the netlink dumpit
callback gets called again until it returns 0), then missing items due
to list growth between count() and snapshot() is harmless: they'll be
picked up on the next pass.

But looking at the callers, they all do this:

  if (cb->args[0])
      return 0;

and then set cb->args[0] after the single snapshot dump.

The dumpit is a one-shot: it snapshots once and signals completion. If
the list grows between count() and snapshot(), the truncated entries are
silently lost and there's no subsequent pass to pick them up, IIUC.


-- 
Chuck Lever

