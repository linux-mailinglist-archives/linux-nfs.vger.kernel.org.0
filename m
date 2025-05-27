Return-Path: <linux-nfs+bounces-11925-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE08AC544E
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 18:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E054A2123
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A0827FD49;
	Tue, 27 May 2025 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jXSelnEm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D6Oa7Mot"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C95F27CB04
	for <linux-nfs@vger.kernel.org>; Tue, 27 May 2025 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365128; cv=fail; b=TKm4GALAOZDVACL4vU96CupguERqaHRA4z/Czm9XiLhZecSBjOblmBpKK8Yf9QlV0lErzUc4qJlgl8Q/7PC8uyv7s6hWMGFVp2pZ2Wg1w502iRCvxYnKwbs9MhOgLQRaclTXP8uY8b62KVROYJ3NghfffWCs47JHf+IgmPrlxL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365128; c=relaxed/simple;
	bh=eWF4It08We2+apc/IeWG69q3wd/nRK8d1or95F5uy9k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OTQgCNT3bBMpm1pOLqCteyN0o3slox/nyL431vXWkAvJ7HHuje5x/yEDhjvfwu8YA3Xhn3ap6B3C2D+f8fp3hrDyOiECHNJEKGkUfq3HKwCgxdTQ9tMLRBO2fEQYyjc1mcI+3Fv7EmQv9y3XMzqYg54k+uyIGHGx4A8w1nVSqAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jXSelnEm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D6Oa7Mot; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RFu5dg002536;
	Tue, 27 May 2025 16:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=stwvxHwsZtGIS7PT2FTq/XQuCVmDIc/kOHxaDgqxxuY=; b=
	jXSelnEmYxq6Iw4y8dM1HQQsOp0pwQhMTkhqKZYkD0zudrs1aMkNzey9Vn+w85rC
	hnqX36JtBAfu0l+MgD1+mOV1Faa9ayVBAImw2cHoP1ZarYqyyViLED8p8kHS9oVY
	xcX0p2z3L3YLfHutOUuSMClYawPWAUvminp6BRIMiu/sRrXcWc4qVx97S6KjH5Ud
	i/wvrIbWFOPbI3GdlOaH9dg1iJXGKJGgP31HyPokMrSmGKOJO4dyDs88tSyHv2tV
	bBdkfby8B8r0qIUoEX2zFBLLZtDKFhJR2TEjflwBzOPzmkLQx6Qx3iRePes0wy2i
	clyIseXD7n6BhoUA8TaRTQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v33murq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 16:58:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54RGNlex035760;
	Tue, 27 May 2025 16:58:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4ja5cp6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 16:58:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Afc4vRqk2go1vihqYmM9pJ4iw5w7lKDqS2VVpWzesmPX8GKLSU/0rgq11+M5a2Mq9bVBG/MnTHGv/CQtuIDJR1XmdGaMjSEz6bg3y1UMYL+oz5BYtwsJx+suGjnrddBg4YZeBQGfEYf+L7m/6PY/r3dZcRHbGNor78ABVtxgZKNdaM05qCM03OyRJCEBeuIIQEDjPMrURqXAAMZiEYA+ez238FqNnYKgEv4sYw8MpMRbP5OK5NEN6CEXUrfiTff/ojjphOcIZ/KhL+SWI/ZHYkWtdOH5T2nxRY9FbG29BJHAlBt3172p4lHfg0ZbsJwWtm4FfpfF147SgnfIYKdOPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stwvxHwsZtGIS7PT2FTq/XQuCVmDIc/kOHxaDgqxxuY=;
 b=PcMhE/Stgh/OSwZnQFfwCbaHygm2hq6GowM552vE/xX9iPZqXzVNBMXNiXUIdLBM0aWiAfv5Q+R96D3heqtn8L+zwsAlD76mgEG3y3B08TVpR6fzsjT6tB4HrTb6srGrtGIj0RZBSf19A0Z9jU28q64rJ1iqgvBFxAvhHRmX9nkFgPuY8Iiyu0lpDeybFPM2Myn8otU9ZOVhvQrVrRw8eScGNIgC1j7ubFJQ+8Z/yuRzXNfB5e9g8kLnejs/bpGQDw+cb2Y5Gzrs58Q7YcIl5dv6tdESz7kcX9jUz6c4cmk682iCCLN2qhKJVjHl1PJ05lr9Vowd9lEsR1QsvdHoxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stwvxHwsZtGIS7PT2FTq/XQuCVmDIc/kOHxaDgqxxuY=;
 b=D6Oa7MotlZxJA9buEtm+xZ3r+mmP6sd6i6xMbVl1Bg9z17Z8DWXqPG2FetdsRrpoOx8H9U5eKOSqwbolRKAfkCQ7gub2fKwoBpOpbmo8YPcwhSwl7r8f8t+9K8ovsAGOgXqta79MOUcKfs6CxzDb9PuID4deaoROymYmohH8RmU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6511.namprd10.prod.outlook.com (2603:10b6:303:225::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Tue, 27 May
 2025 16:58:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8746.035; Tue, 27 May 2025
 16:58:30 +0000
Message-ID: <3b1f01ad-2c20-4e3a-8543-c3fd6bf20086@oracle.com>
Date: Tue, 27 May 2025 12:58:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: Rick Macklem <rick.macklem@gmail.com>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
        Steve Dickson <steved@redhat.com>, Tom Haynes <loghyr@gmail.com>,
        linux-nfs@vger.kernel.org
References: <d539c502-e776-460f-852c-8af9722ad9f8@oracle.com>
 <174821817646.608730.16435329287198176319@noble.neil.brown.name>
 <f679b62b-cbf3-4225-a163-870c65ff0c9b@oracle.com>
 <CAM5tNy6sgLg1HFBBkRe5JoXbrDjWiJfoxW3S-ZHh7HGSoVXzgQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAM5tNy6sgLg1HFBBkRe5JoXbrDjWiJfoxW3S-ZHh7HGSoVXzgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f628319-d882-4393-ecea-08dd9d3fb4d1
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SzZBMU14eEo4bjh0MktFZ0ZMclZJNkVsamlXUnlvRHRVRjVzajNzcDdRTWRr?=
 =?utf-8?B?OVllRzRQNUFNWFZSWFhWMU5mZzhrQXRhZEIrUGt5RmQxbHZzdzN1ZDNuSnNu?=
 =?utf-8?B?Q1M5aFpha3V4TXVUQ2YwdVRTdEZ3K1Z1M3VKWkNZSGk3OVpFd3JVSkRkV2lr?=
 =?utf-8?B?Q2I0VHRidklGbW1BSGdNb05iYnkvY2RLVzE2TXZFS2lwZ0NWY2hOL29yc2gv?=
 =?utf-8?B?OEJRQTNmSmhPNmh5dytKQ0FQUTF1d0V1SnhZWHZOZkFrWkIxZklzVXkvbjdV?=
 =?utf-8?B?bG4vSlRxcm91WlNVUndPQmk4TkJWalQ1S3pEM2pYOGJQK3oyMzM1ZzFIS2Fv?=
 =?utf-8?B?Wm1rTWlCUTQ5MFNsekRBRWZzYmZlaUFiaGEyZit1bmVIWEFFZ0NZd1phbkVU?=
 =?utf-8?B?OWQxSjhkZFV4L0FtSldLNDNiN0FONXlzZi92ek42VWlqbmxZeVlSSEZQUC9D?=
 =?utf-8?B?TmtnUWYyemJ4UVlxNE9WZ3J1eWVPV0xPVDVtdzJrNjl3WjIzQStHS1h0aG93?=
 =?utf-8?B?Z3NCZis2M2RZOUVVY0JuZEpVeGYvc1Z4KzFTUGVIbWpYN3RxWERmM1FoU2xl?=
 =?utf-8?B?SWNiTlhvdDlYTHNRRU5VQldPalJnSys0RzZIWU1RTG0yaWY4YXEyVjBxNVY4?=
 =?utf-8?B?aEt6K2xnaVVQNVNWQ2NEK3dXNjZXVytjMFpLYWluWFl2L0Jqck4rdlJzYkc2?=
 =?utf-8?B?RkE4M2xaTThnbnlYbFZ0UE1SWmY5SWhoRjVubzgreE42WWRoVFh0S2N4NTdK?=
 =?utf-8?B?ZTdoUjVqU3JrUDQzRWxhZGZWWlB6TVJrb1dCVE9iSFVzaER0TU96MndMYjZZ?=
 =?utf-8?B?RTZ0ZjNiMitHcFZndXorWFpDbTYwN3JIMThNc2QrVCsxaGxvaWVxZFBwTW9y?=
 =?utf-8?B?Q1FLbkV4SkVYMEF4ZlRYblpaYi9uNzg0NExHYXUxSERlNFExZTU2WFNVYjBm?=
 =?utf-8?B?UWkzaFZjM0JDWnlNTEdtSm9VOGNmUGxkMUtlNjdqbkJHWkxYWEJ2S3J1ZEo5?=
 =?utf-8?B?elQ0OXZ6dHQrNVpIMjBmUE1WREJyTUNnQm01OGlSK3RpdDNQV2gvVFNpa1Rh?=
 =?utf-8?B?SHJYT0ZXWnpSY0FoUWtoQS9qSzNGOHg2UUpUanFZWFIvMkNnNlA0S2VHVjhp?=
 =?utf-8?B?Z0h5RDYrK3JPR0N0eGxmemJEanJSbWZ2ZXUwK3YreWFqTTdMWWs1aTM3bkZ6?=
 =?utf-8?B?T28xOUFBMGJxTDYxMUJYRncrVnp5eHBFcHVYTzE4S29NNkFWRkwwYzRLM0hs?=
 =?utf-8?B?bUdlUU15VzZDQ1g2QnVUVDhVUmFINEFZeVRCSUxxdFRhRUNpSnhrUEN4dWNs?=
 =?utf-8?B?Um50dFI0TW52eTQ5dGIrbjUrOEV6SnJ4aTlXNHdwWEhQVkVDRTRuS0dhbkho?=
 =?utf-8?B?RHI5ZmhyODBSMW1PbGQ0cU5HUy9GUlE3SHNvYXF4c1RucU9WQ1FPZDRrZ0tH?=
 =?utf-8?B?Y1IwMHhUNEw4ak9Ic0RaWUZpSElrMlNKYXRHRlJLcXQ0VGVkSURaUEV0dUs5?=
 =?utf-8?B?MzRMRnZFQStWNjdOOEQ4bHJwNDRnR2dRakRtM3VnNTljeVJmdTBQZWd5bmdK?=
 =?utf-8?B?bitVdkVWU2pabXNVWVh1TVJVcTR1cVMwMVFpdzVpaGdOOUNueGErR2RRak5G?=
 =?utf-8?B?Q0ZvcmtBNEkzODZEUGtmVG1WQ2IwalpRQ0xzcjk5cHhEeFpNTjhCTVJOckZX?=
 =?utf-8?B?T1MrZFRnUGhLK1Exd1VMQXNwZTg5Z09GQVFZbVJya1lOSFEwUjZ2bGNZd3hL?=
 =?utf-8?B?MTA5a1VKcEN6LzVWZTgvcXAyekh4OUJIQVVTd1FTWjArZ2hUd013QlpIREw2?=
 =?utf-8?B?dHZRVHZMMVRVTG0zd3pjb2JMWjBYL00vK1pKWTRMUFo1NHRxVDBScUorNHlI?=
 =?utf-8?B?cHB5ZjhxZjFkMEU4dTFpa3AxczdIYlVZbk13QzhhdURiOFZJRG5YRXpFd1Iz?=
 =?utf-8?Q?Eh+YRhto36E=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YlVEVUVidytJaGF5YjBuMnJqWXp4R2VCN1VoenlyMUl1ZFpObFg3dVNncllN?=
 =?utf-8?B?aEtCV0h0b1ZpMEx4WVk3eUNCQXJVdDJYWExQdElaY0FlbVNWQVhXaDVBSW5s?=
 =?utf-8?B?c3FLYWFLODFmSStlZzR6L2MwOVBPOVAzVDlNYldRemJVWWcwbWRyaXVHTDVp?=
 =?utf-8?B?bjlnb05YSHhUT3NnY2RHSmVRc21xZ2Zjd3hBSUpYY2dhbUxsY1NmSkxsb0hk?=
 =?utf-8?B?aW5jUlVjQWczajdaWDlVNTdodXFud0hBV1BPaUNaQ2ZkQldPODJoa1czQXkw?=
 =?utf-8?B?UGlJY1NrOUJybkVkeHVrU3FBYW5QY2gzcDNyQ2VNOXdxbzlpbWd4QWlkeDlv?=
 =?utf-8?B?cG8yNDdzMlNrWUNBbzlRWTFndWFZOU5BSHAwSUVwV2NVODFESnorRVNqN2N5?=
 =?utf-8?B?U3lkcW95VmhzanFwSGlodERMNUZYS2VEUTVsMmhDaE5lM05HMW1ROGlqYmFa?=
 =?utf-8?B?QVkyU2tsbndSaldHbHZYU0VhbGFIeS9TYmc3UVdpWmdnc1FTSHhsNlAwcFFw?=
 =?utf-8?B?Q0JPdDVDZmN4YXpYUXFPYjFuY29RbEhjWUVxRjZIQWUwNGF1ZHdXRWkyK0NL?=
 =?utf-8?B?RDQxUENqSnRpWmtzeWlaTmVhUXBFSGxjNTVETnovVjRtdXcvT1FhdlFIN0hT?=
 =?utf-8?B?WGJLKzBiUFdCT1Y5eW1HVWZlZlJ2RlR0NEQ0YnRzZXdxMWZXMjJnbFJaelJD?=
 =?utf-8?B?NlY4czlxZVYwenlDM2J6R0FRQVIrMzgrelNDN0NiV3VlZmNDWC80SDNYdGs0?=
 =?utf-8?B?WUNLWDhEc2RVU3FabjZsazA3cCtrdk9yUnE1WGcvejdpRE1UOHdzTFc2amhW?=
 =?utf-8?B?dENkdklxU0FHRjhoMUQ0d0hxVXhPYk1qRE0wVXgxSFBJOXdZMmFBVUdBZmZV?=
 =?utf-8?B?TmcrTlZYbExQYlk3OGlDOER1d1NLcktMcWRuUG1OT1V6ZHd6NUZHczdHQ3Jn?=
 =?utf-8?B?Q0ZJYmM0YjJ4dlF6ZHFEY21XY0pvOElFUTE1QTJreFlCT2ZaRkgvY3NpRjNV?=
 =?utf-8?B?MWZNQzNMTkpKVmJCbWVKWnhITXA3R1lxZ1J5eTBnSGVQOHVaMkw3aTZYOTNq?=
 =?utf-8?B?ajhOSnlpaHpscjZtdEdQa0I2YVJNQUFERU5LUU16bVJmbStsNXZTQ2RTNDU0?=
 =?utf-8?B?dXZiWHBxUVA0SmRFOHR1NmV1TVFTQXl3bGVDNW1QdEVrS3JhQ0UyamVqUEFy?=
 =?utf-8?B?MFlMYVo0U0VBb2NkM1lyMm9WdVdHdXRralh6ZVRycHVMSGQxcGtNcjN1WWlk?=
 =?utf-8?B?QStwbUVLN1NoV2hRRFltT3RaRkY5aVJoaWx6TUdXYzl6RnAyMWdpbm9zMzdQ?=
 =?utf-8?B?RDhtdjFIMU9xT0xTQVpJZ0VTNkE2QmM4SlpYMXNQbEdjdy9ZM1BZWWFVZjR2?=
 =?utf-8?B?VnVSNDBDdUxpK0VENlVFVVAyd1phSGhGQzBpU1RhbEhiVWY1OEs0dStTU0w0?=
 =?utf-8?B?a01xUG1VL3hLRzVIaHNpNUN5azNFbkZwMlZVaU01M3dva204NFpoUFZiQXRZ?=
 =?utf-8?B?QXFxTk9raEthQm9VWG9NbDJ5SGNXZ1B6eGdINVF6eklybVE0RTdKZEF2eXZP?=
 =?utf-8?B?RmlMQU5FUTFBU04rME9aZzlaWEpqZVB2VnJMRXgwc0hMd0tML25Zb25ndkZI?=
 =?utf-8?B?M3RPZ1ZseGdpS0JKdmFLZXBPc0RmdWFJTnRNNjJUY1R5aGZKUGJoaXYvd2lC?=
 =?utf-8?B?SjR2YTF6eTdHQ0hIKzNVTFNpaCtUL1NrdU95RGNyamxGWWhzWXpkQnVwVHhQ?=
 =?utf-8?B?ckVDVDRtb3Erck1vNlNtMEtjelkvL2lyRDFyUVpqQVVNVnhGM2JvVFNaTlph?=
 =?utf-8?B?c1Z4elBsRVZmNDVhT0dQYVIxZUtYRmphZy9jOVE3VGRoeXhQd2Y3MGlsdzU2?=
 =?utf-8?B?ZU9neXhHRVFtMEhTdmVDTm5yT0lSMjRielJvYXdhdE9mY3pqMGJ1TG5iYy9t?=
 =?utf-8?B?dGsrMjhJa0xNd2VSWnhsdC92czlKdGhrdnlaUnV6aEJlaHNwN1gvOGFhZDQw?=
 =?utf-8?B?aHcxTEJ1QW9oZWg3NDdEa2ZyMHVSeFl5WEcyK25qVlpLWENJL3AwZTBGdUFS?=
 =?utf-8?B?MDF6ZmtUWUFTcmhROHQ3b3gyWTRUYS9HTlF4UUw1RitsZGJ0MXJiSWZxaDdq?=
 =?utf-8?Q?T4kVPpNmh2zXAmKPL/XkVUzZM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	13mVI753dXbi0M7y8Vf3tlubpK6zkvvsN75Xrv/0sAqX2oC2eB5A0E/CVodAwtU04oefUIoychWM7vnEUdOqSd8qj56zmosYu6eH/npbCglULrWj4vFa9+RD7TFZQ2rFV+tjPjulgDNbfQjOd5Re8RWf2cgZ4RKMskDXzwy9XfpEmr2M3ekr7zC4FdwVKOViby1oZwQuJAHMxA6Mn/Plu+8uBYJq8f+LF1e1Q79yfh5Wy8WT46O9ZWMzh0v6dzS7Iqei6946+a0geyyAeB+F5fz5DJ7qNG1I0sRxFNy6PeX61Rrw+jsj2y3fiGMDis1pi6UdjZ7/PuonMzdsl6V6H3wQ6LPEF8APthn3Uje0uyvcVPSXwvGKZKp8aGX87EM+hKleKU2wbHSHLbZL6jM3DGaOy5EqMuEI1fIbcYTKBwMsEObbxGKtyRZIUL+ZqX/nirbwYA9cQjrcZCg2H+gz9yRK+OM5CVuexUXM4zc73cr9diHYA62ZLuyPILXzK5Xu/vJGNzEwHl6z3qD4XA10iiX09CEyQWV6dDLkpQCgrDPbfbL4WrThnWEyqBcik/CBPSJYVLS8YKgW6JK84W7oqyaW97jM6XrNiy5pW3ZgC/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f628319-d882-4393-ecea-08dd9d3fb4d1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 16:58:30.0203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xnHL8yUmygHzcDLC4JArET9F8Kjf0zS1M5RTnLxEZ0EXG/J+AKJey05zbkU/6LHlDq5nkZSsCoGpEwLoLPmuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6511
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505270140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDE0MCBTYWx0ZWRfXxBfkNYkIZEKv Arl8CdyWfm9xOZxPMq868JnYh5rWt53QXVkmxzMWL1zWOd0G8a0XWa7Rv3rfmnRt0GOhkpcuKNm 0d20wQhlG4RFX5w2G2TFKQvxxUbt6uG9zSuQHAJGdJmgtcChn1yDMWQrN+fBcay48WmF5L/YqBb
 S0rCdbLTB7cY6QRj9+gvgrXhvKaATAkB+wlXZLRdi9xRDCBLv6XGopF7jCMbWb6aE7ZYoa3AsRv DGJ2JScVmSfAJmOsAy65F357S7DuObg9M2CAiXga/R9EAfLOKR6b7+i3+L86lRhDxz8JGqfPGCM K5t7rxtZoFST5lNQ/sVr+0Au81ul/AWBj3DNQHTiz9yZ5kgJlj+Qb/rx1JJqTS2BBNkwaIhPrBG
 SU5qaHcQy3mU5hSnC7PROKR7Gp9vIdep0iUTnTiX18RPDbS3liCKQKB/t2y246Hm5Hde6j49
X-Proofpoint-GUID: G7xtY0qyO-9VMG9xkQ4qlLmCZXDt754O
X-Authority-Analysis: v=2.4 cv=aO/wqa9m c=1 sm=1 tr=0 ts=6835ef41 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=A1X0JdhQAAAA:8 a=VmTLJXlr-ypnv_8QofwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: G7xtY0qyO-9VMG9xkQ4qlLmCZXDt754O

On 5/27/25 12:29 PM, Rick Macklem wrote:
> On Tue, May 27, 2025 at 8:05 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 5/25/25 8:09 PM, NeilBrown wrote:
>>> On Mon, 26 May 2025, Chuck Lever wrote:
>>>> On 5/20/25 9:20 AM, Chuck Lever wrote:
>>>>> Hiya Rick -
>>>>>
>>>>> On 5/19/25 9:44 PM, Rick Macklem wrote:
>>>>>
>>>>>> Do you also have some configurable settings for if/how the DNS
>>>>>> field in the client's X.509 cert is checked?
>>>>>> The range is, imho:
>>>>>> - Don't check it at all, so the client can have any IP/DNS name (a mobile
>>>>>>   device). The least secure, but still pretty good, since the ert. verified.
>>>>>> - DNS matches a wildcard like *.umich.edu for the reverse DNS name for
>>>>>>    the client's IP host address.
>>>>>> - DNS matches exactly what reverse DNS gets for the client's IP host address.
>>>>>
>>>>> I've been told repeatedly that certificate verification must not depend
>>>>> on DNS because DNS can be easily spoofed. To date, the Linux
>>>>> implementation of RPC-with-TLS depends on having the peer's IP address
>>>>> in the certificate's SAN.
>>>>>
>>>>> I recognize that tlshd will need to bend a little for clients that use
>>>>> a dynamically allocated IP address, but I haven't looked into it yet.
>>>>> Perhaps client certificates do not need to contain their peer IP
>>>>> address, but server certificates do, in order to enable mounting by IP
>>>>> instead of by hostname.
>>>>>
>>>>>
>>>>>> Wildcards are discouraged by some RFC, but are still supported by OpenSSL.
>>>>>
>>>>> I would prefer that we follow the guidance of RFCs where possible,
>>>>> rather than a particular implementation that might have historical
>>>>> reasons to permit a lack of security.
>>>>
>>>> Let me follow up on this.
>>>>
>>>> We have an open issue against tlshd that has suggested that, rather
>>>> than looking at DNS query results, the NFS server should authorize
>>>> access by looking at the client certificate's CN. The server's
>>>> administrator should be able to specify a list of one or more CN
>>>> wildcards that can be used to authorize access, much in the same way
>>>> that NFSD currently uses netgroups and hostnames per export.
>>>>
>>>> So, after validating the client's CA trust chain, an NFS server can
>>>> match the client certificate's CN against its list of authorized CNs,
>>>> and if the client's CN fails to match, fail the handshake (or whatever
>>>> we need to do).
>>>>
>>>> I favor this approach over using DNS labels, which are often
>>>> untrustworthy, and IP addresses, which can be dynamically reassigned.
>>>>
>>>> What do you think?
>>>
>>> I completely agree with this.  IP address and DNS identity of the client
>>> is irrelevant when mTLS is used.  What matters is whether the client has
>>> authority to act as one of the the names given when the filesystem was
>>> exported (e.g. in /etc/exports).  His is exacly what you said.
>>>
>>> Ideally it would be more than just the CN.  We want to know both the
>>> domain in which the peer has authority (e.g.  example.com) and the type
>>> of authority (e.g.  serve-web-pages or proxy-file-access or
>>> act-as-neilb).
>>> I don't know internal details of certificates so I don't know if there
>>> is some other field that can say "This peer is authorised to proxy file
>>> access requests for all users in the given domain" or if we need a hack
>>> like exporting to nfs-client.example.com.
>>>
>>> But if the admin has full control of what names to export to, it is
>>> possible that the distinction doesn't matter.  I wouldn't want the
>>> certificate used to authenticate my web server to have authority to
>>> access all files on my NFS server just because the same domain name
>>> applies to both.
>>
>> My thought is that, for each handshake, there would be two stages:
>>
>> 1. Does the NFS server trust the certificate? This is purely a chain-of-
>>    trust issue, so validating the certificate presented by the client is
>>    the order of the day.
>>
>> 2. Does the NFS server authorize this client to access the export? This
>>    is a check very similar to the hostname/netgroup/IP address check
>>    that is done today, but it could be done just once at handshake time.
>>    Match the certificate's fields against a per-export filter.
>>
>> I would take tlshd out of the picture for stage 2, and let NFSD make its
>> own authorization decisions. Because an NFS client might be authorized
>> to access some exports but not others.
>>
>> So:
>>
>> How does the server indicate to clients that yes, your cert is trusted,
>> but no, you are not authorized to access this file system? I guess that
>> is an NFS error like NFSERR_STALE or NFS4ERR_WRONGSEC.
>>
>> What certificate fields should we implement matches for? CN is obvious.
>> But what about SAN? Any others? I say start with only CN, but I'd like
>> to think about ways to make it possible to match against other fields in
>> the future.
> Just fyi, here's an example where filtering on the DNS or IP field in the
> SAN (SubjectAltName) could improve security..
> (Dusting off my CS sysadmin hat.)
> 
> Suppose I had a file system where student grades and exam questions
> were stored.
> The mount was restricted to faculty offices, where their machines had fixed
> well known IP addresses and FQDNs assigned.
> However, as it was for my case, the building their offices were in also had
> student labs and the building was assigned a subnet by the campus
> networking folk.
> --> As such, a student could easily come in off hours (when the faculty were not
>      around and, as such, had their office computers shut down) and
> plug into the
>      subnet (they just had to find an RJ45 jack somewhere that they
> could access).
>      --> They could then set their laptop up with the same IP address
> as a faculty
>            member's office computer and defeat ordinary /etc/exports
> filtering based
>            on client IP address.
> 
> However, these students would not have the X.509 cert. with a DNS or IP field
> set to the correct address in it. (They might have a valid cert. so
> their laptop can
> mount the file systems students have coursework assignments on, but it would
> not have the DNS or IP of a faculty member's office computer.)
> --> This additional filtering would stop them from accessing the
> marks/exam question
>       file system (or at least make it a lot harder for them to do so).
> 
> As already discussed, there is a tradeoff between using DNS or IP. (I'll admit
> FreeBSD doesn't currently support the IP case, but it probably should.)

To be clear, there is a marked difference between relying on reverse DNS
queries versus relying on a DNS hostname or IP address contained in a
client certificate's SAN field. DNS queries are untrustworthy, but
fields in a certificate (once its trust chain has been validated) are OK
to use, IMO.

But I would like NFSD's administrative interface to be unambiguous about
which DNS/IP information is being matched against.


> rick
> 
>>
>> What would the administrative interface look like? Could be the machine
>> name in /etc/exports, for instance:
>>
>> *,OU="NFS Bake-a-thon",*   rw,sec=sys,xprtsec=mtls,fsid=42
>>
>> But I worry that will not be flexible enough. A more general filter
>> mechanism might need something like the ini file format used to create
>> CSRs.
>>
>>
>> What about pre-shared keys? No certificate fields there.
>>
>>
>> --
>> Chuck Lever


-- 
Chuck Lever

