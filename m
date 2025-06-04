Return-Path: <linux-nfs+bounces-12089-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43085ACDFE8
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 16:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1EA3A75E6
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 14:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13262397B0;
	Wed,  4 Jun 2025 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="InDL400p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KLhAJSYa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990DA1E52D
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046225; cv=fail; b=VfZ8T5VCpnYtLIDigKIuKEH21h+0bJl9J3Lf8geFtG28cqsQS87DnBm9VUHTYiOBJAbOIAejJaUVqkG0u97hzzM9NBYsb9zQZ+0M3O1TuEOMXxSSJ7rXAo7tWpFjVMPy7mOvC512hsh3imH1L3001PVFhebEML0+op53NQurYSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046225; c=relaxed/simple;
	bh=qE/TFkodOV7e+vkKKfD5kd7OBw/BICOHc401ArbN2ls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lFFROuRQg0qa0p7RYblufBwmx1GV9AUTAwKmksKhfI84LwEircn0Omv6oevw77hoJEnJFas7mF72Do92Gjxgqbqdu5t3AsEZsy16sFMhDreQjUvPGCASFOFZYx9L903LZkrEzL8JdAnWkobOg2n+iXAWnR55yS5o7+3gWSf2Orc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=InDL400p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KLhAJSYa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5549MbtX025534;
	Wed, 4 Jun 2025 14:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=S+vG1YZEd6sHbeBHJD7S34f60X2M3uNbp3KMTViUV0U=; b=
	InDL400p7lgSiEY+p5I/hJyTQ4P4ZEbtpPzT3HtQGU4z3tSZu2xVMxSs6CS2+H7M
	VUkexDBvjVk8zJiUMxDj4olnbWACnkWXIr4MBCSmws0guTMiaFXbUTVb9YACBF1/
	vINtJSxkjOKlq+LN+fw44fv8N5/QPrryzuP0R5JuG/AfkYzWvys/pcW3Xx549qAo
	x4DPTxG78pLmruYv0kOxSrXYY0xLo1rzrdIZG60VE0psKgaUXNZFgozM1VAhOLf6
	JvQ5Hw4nTxoDx2ColdqX0D+Q2/F3Ecqph0yU0UHCAwW3ZwFcWDqOBrwqTn4Nv5ZF
	wxZ1lHOBcXJTimk/NeOPSA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gahc5k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 14:10:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 554DlbxB040770;
	Wed, 4 Jun 2025 14:10:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7b2a0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 14:10:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4XySgoJVOK/z/AqOyD3CcXolVkG1050iQotFSTcFi33UgKmxbWII2LsqOaSld8DsMoXVdk9XCoYMwoGyWHpchOzECk/dCgZIehYNd3LUIgfmfnh5n2T1MiMh5OBbCPOcaV+IICifRcFH4ucVezvfHdd+q3oe7u2WINxKCOY0q3+hWvXaztwQhLmJ+Fqyq+Fcpx+BTi+ZM2OjQYAT7IEwAl5JOB/2cRE3jiqqlTwbRGhVRQUV8kRuxfKIq4noMIC3LQhQgKt3qcWZdHRlkO4WZauY1VDkBFAgXnlrJaoBW96Kkc2zR7T+xj5ssdvyFI2TOjoWCPd3vAUup7Z29UvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+vG1YZEd6sHbeBHJD7S34f60X2M3uNbp3KMTViUV0U=;
 b=bWIhgy/5tcs5+wsoFczBPhYgKIpwW/JxbgtB9cxVPtHQmPQkRkMyVL0D+ayhJfK6+IZnOOfC9XUhHXc/e8/b2pol0fhmzX0P3ruLZmeKfR3XMswR9TvXw15cguA+fD9cOqK4pcT3T1oc53OPb5GPLDFiOqPUechXnZu3cGGjSGXfhlknUyeFMge8MdBOfb3ARSdhHV3CK8faM45/m0Og5GEw9/kulGefGjH72N6G+wkSwey+O0rl7QOJ8ec8iVj02yooESdG4mPzZaGSX04/3qaK1lqFFmlzPG2gaoVLIZ3q7qmXY3OZrUyQ8Yfoz3g3ikhZCf66uVm4cWXONIIfgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+vG1YZEd6sHbeBHJD7S34f60X2M3uNbp3KMTViUV0U=;
 b=KLhAJSYa+xJjwYaJuGENZUVkgD5LsJVMaRgCyXn32yZMR585o6HD8WOktYEDxQ18r3cPt5rFtvq360xxDqIYlw5QmP+barMz0dPz1YaPGmCtSr5saY5u7lIwOekcOefVQ0lmyzyay+zhd0FSDVR3AoKBjjhUme5vA3WfjC0K3T8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Wed, 4 Jun
 2025 14:10:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.020; Wed, 4 Jun 2025
 14:10:17 +0000
Message-ID: <0946e832-23c3-4607-9794-802e02dc8ef0@oracle.com>
Date: Wed, 4 Jun 2025 10:10:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Implement large extent array support in pNFS
To: Sergey Bashirov <sergeybashirov@gmail.com>,
        "J . Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, Konstantin Evtushenko <koevtushenko@yandex.com>
References: <20250604130809.52931-1-sergeybashirov@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250604130809.52931-1-sergeybashirov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0062.namprd04.prod.outlook.com
 (2603:10b6:610:74::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b58246-72c2-4b0b-c573-08dda3718822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2ZDNDM3aGJxRktzdmYzamhreHAxbkpSWVhXMlVaVmlvTDNJUDdjSCtkYko5?=
 =?utf-8?B?VkVhcHlMa29ZdDlldkRBMXJoeFE4YXRnR0hmRkpsM3l0dVRveGFCNi83RTUx?=
 =?utf-8?B?SklIeGZmVy9JbFZkMGpIZmFIa0k2dnVVbFhGcUwwSThJamQ3cjR4RlFjTjJW?=
 =?utf-8?B?L0w1NVUwLzNzZ3V2Vy8xdmlLTG5FK3k0MzhtKzlqNTNrOTJ2YjFPUUhmWXR5?=
 =?utf-8?B?MWZGQ1htNGxCV1Z6ZTlxUmNqbmZGVHhhV2t1ZWRXdmZBNkM3enN4d3pldU9U?=
 =?utf-8?B?cFM4WXpZYTZ6OWVLZUoveEJsRjhuOUVRekhYNTdWcUFjWmN5Y3JMZlptY0Mw?=
 =?utf-8?B?OTVSRW1RWnl1ZExwelJsM1Vlb0UvQ3NoUnpBQWUwR0FVRzIzU3N2ZjVvdDdR?=
 =?utf-8?B?SmFLS0hjSnJhSWwyYWZiM1N5NUkvektyanROOXB3aTNWR1ByVy83VkhIUmZ3?=
 =?utf-8?B?U0hxdTdHMlZZbjN1YjcvTWZ0aTFwUnJFQk03VkN0VncvblE2YzVPcmtVOXV4?=
 =?utf-8?B?Vk5VRFRkUXFRZE8wS241Q25yc0JLT0xpcm9KZWF6d2c1d2FZdHM0VUE5bXhx?=
 =?utf-8?B?SS9EQ29LKzdVM0FBZW4yNkZnWEN0Z2hWUnhlVWk4UDl3Nk9HLzdCTDhIeXBq?=
 =?utf-8?B?dy8zeTVIYzNlbG5nSmNJRW9mSTU4YjI1ckFHK29yeHd1ejhac0NhZUpHV2RS?=
 =?utf-8?B?dTkveFNoV24xTUNWUWtBZlNSWVFBUWtqQm9HelYvWG4vaGlIbzAvSDlVM0xi?=
 =?utf-8?B?Z1hUZW9SUzVicnJOR1gvOTJyZmtMNTJhVWRZRno0V1NFeVFmZDlsZWhmLzYx?=
 =?utf-8?B?K2pmdURDdGR4UU4rSnlLUzIwbDVIekNpVENVUXZ3Z3A4RW90cGl2a2ZueGFj?=
 =?utf-8?B?a0FFdER4MjJmM2xUMURWR1ZUS3ZKd0VHcVZONThwZjltWEdwZUZQMXVMOFE0?=
 =?utf-8?B?RURzSHhhclptU2tYNkVuRE95RVBsOVdqTnZQbDBCUjN4Znh3RFM4WnhRZWJW?=
 =?utf-8?B?ZDludjBpZytXV2NUcll4OVUwbHVHSWtIYXp3TW1TWm5CbmJqZDR5Q3BOeTJW?=
 =?utf-8?B?bUN1bUsvMjlNVXNPdTZqZHlJRmFTWmNWZWRJWDB4M1hoK2drYlFzM1JyRzZ5?=
 =?utf-8?B?MzVDK3JCZEdQTXdQc1RTVGw1eFdHYTRzWE9rbXprcENBUzZYbUFrWVRuak9W?=
 =?utf-8?B?bGNJMk9JTUFDZm1SSHFCa1BQcjFkWGc5WDA0TjRqR3BXcFZOQ0tqWEU2UDZP?=
 =?utf-8?B?a3N1T2k2VkNPTXZadFhMRE83TmdGYS8wSGdaMU5XMHlSWnlvanVVRjE5Nkx2?=
 =?utf-8?B?UW9YbDBTMTNGQjAvclYwNmhCYVhzS2ZkdGNkSWx3bzVsZ1B4WDJZdjl2VDh0?=
 =?utf-8?B?dlFWM0ovR2VjTzk1QzByZmhsOEwwbXZmcXA5bGpmN1h0a1FtbXNxbjFjdHB0?=
 =?utf-8?B?akxmMFBXTnNSa1JEZVBGTU8vVEovWnRFRkdaTVNHZlgxMTVRYUN3LzU3a2Qy?=
 =?utf-8?B?UVJaQ3NVOVowY2lEWkJYYWlnQ3Job2I4THg2Wkw5ZFV2S0dzWStGdjVpY0lS?=
 =?utf-8?B?eFZBSjk0c0lUVHpnL0Q1emNiZlpJS3V0TFBobnZ0VmRsNWhrbjIvaEdqY2tx?=
 =?utf-8?B?ZzluK2ZZYnJRTTdGdlkrZXR1U2hmV1ZFOEQxcVl6QXQ0TGd0R3FtcXpscll2?=
 =?utf-8?B?RmVtcGtPSm5iZ1Z2clgrWk02cnZLc09aejRzcklnMXdMUlRmR1M4c0E5Rm1G?=
 =?utf-8?B?dkdjalljQkZTVHN2Yk5ha211ZVZOUlhtb3MyNnU1aDdDRzRjZFE2c0MxdnpQ?=
 =?utf-8?B?UkRGMVduSzhUSWRqT1FZZllCUklmcC8rTXR1dFdNSlVQQnB2OEY1V2NqT3hk?=
 =?utf-8?B?U1JpYVMwMitPZTRVVGVuSGdDL2RjNitheVlmWnQyWjdKa1JOOHJ3ZjlyeExh?=
 =?utf-8?Q?7EuP1yfBoD0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzVBT1BrT3pCTHdaYVBZQVF0NDV5RHliZlRDZnljeWRlQzlXY0JmUjZjS3pY?=
 =?utf-8?B?UGtHa05mSG9jUmY4ZmQrUS9xN1ZDYlZPRE9tdzJ4YVUxWUI4K0RRZjdIMm1U?=
 =?utf-8?B?WE4xYlYrWDVKZ200RTc4MUdRZW02T0RIMFVIY2RGMlBPOXJuMnYyblR5M2M3?=
 =?utf-8?B?bkJ3T0ZqUFp0SGM3bDJKS2NScDRiTytlbmpiMUc4YktVd0tIVGhmamRMdEtT?=
 =?utf-8?B?Z1pmRG55SmFudjRhVWhFalVTNWhZVCtuYjR1c3RsQzgweUtzZTBCRCtRdzl0?=
 =?utf-8?B?VXdzTVBFWWtsRUxVeWhMMloyWXlOK0lGOTk0OUFJRldDbVFQUUVOdVpkRS9h?=
 =?utf-8?B?VnZkZ3FYVkJFeWE1b2pEQjBWazlBUk9oTXd4V3U2VXdzSGd5K1hNRUFERlR3?=
 =?utf-8?B?VzYxUHBKVUgwTXR5Y1RJekFWSXErWVNKRUZKRUptSVhlUXQ0d1lRSjJmR0hy?=
 =?utf-8?B?N3prVEZ2eWdYRUtKNGxBc2hTZ2dOM3l4SC9yRXNCOSt1bGlJRy92aVU5Wmlo?=
 =?utf-8?B?ek4vZjhDNTVLeXN5d3FZd052aURtZHh6V1ZncEtPbTMxVlptK3JodFVPQytY?=
 =?utf-8?B?SnptTTdFWFB4czNTSjEzbFhrM1Z1bGE4c3dRWERoR01RMjk4OHprOXNwV05s?=
 =?utf-8?B?U09vcjRidFdHeWh0UDBYS3I5MThMTkNCZFIwR0RXeXQyU2VXcnJZZG5QbGNX?=
 =?utf-8?B?c2MxMFRYN1NxSWNLS0ROTllJdXlabGJ1aGk1RFdUVnhzZmMycklJMnpUNUtl?=
 =?utf-8?B?L3R5Z1dzTE5RVFNKMzFBVVY3VWVpYzZmZ1VCYUo1ZnZla01sSy81Z3U1b2FY?=
 =?utf-8?B?dWxQRlVuTmxTWnhlK0dLNTRmTG5jYTg5c1ZXZklVcjQwMkhnRGdaeXB4ZVc2?=
 =?utf-8?B?clZJSHlLaGlYVFZWR293K04vcTdqaGxDeXE1MklwNE81d3FDQXFDR1RFNTJv?=
 =?utf-8?B?eDk5cUFOdjFIQUptUjE0M3FySWNYWlF4cUxJaVFTYm1IaWh5OXVKZjgzNWZn?=
 =?utf-8?B?clJ4TEhBQ21pV3cwQWpWcmp5cmhCQTNTV1V4blNGRnZSS0NGc2FpNzNDb3BH?=
 =?utf-8?B?SEFoRWVmc2R1NnVsNitOQ1oyQkJvVFVlWVZYSXVScm1sTVNGZ29MemdPMzNW?=
 =?utf-8?B?WlZzZXAyQmVndmVRTFk3NXhvSXk2SVd4S3VvUyt1VGVla0pYQlJZSDNRVGd5?=
 =?utf-8?B?Y1NOeENRTTZjWDg0VThzZ05GemlZQ3pHUWovWFNhSXFsSEpZNTVrTGJqOWt5?=
 =?utf-8?B?K0FXKzh5NU1MQzFIUEhDTnVzcStMblByNkhyaFI0VGp2Z1VOSXNOemp1bFVa?=
 =?utf-8?B?UE4yekRJUkVtYmVGOTM5M0VvSUhIaUt3aDl3SzJiRC9XYlhDZTlRdUFjRjlH?=
 =?utf-8?B?cDlkaVhobUZBKzA1SFp2LytSNUJJcXNOa2Z1Nk1hTTlLZm9weGZPc25LRFVl?=
 =?utf-8?B?ZGwvdGNoNnVXQVlNbDJsaVVFb083WHFRdGdHdE5HeUlLYUR1dmdhSzBYdVkr?=
 =?utf-8?B?RXFiR3Vpc25FU0tGR05JZGRyRDJzUW9NaDhlcEtrNWNkUUJuSDhzdDN6ZmdM?=
 =?utf-8?B?QmpqcmFISlpBSkFjV2MyOXlmUGtWOUFvSTd4YVJWWXVwbExqSUg2a2FBTWtK?=
 =?utf-8?B?a0g1R2lqbisybjViUUsyQjFtbXBwMHF0WFNETVl6U2FhWHQrUWM3NmZaYlZ5?=
 =?utf-8?B?b3ZzVkFjck0zSXpsL2M3eU9rU29WVCtBN3VCbTU4clc0VkVGMXN5dmhqL1Vx?=
 =?utf-8?B?eWVlb2ViYXBrS20vUWJUTkNrdmZubjFiTzFFYi9tZVRDZzZIQldlRHB0alox?=
 =?utf-8?B?ankxZ05taHNwcjBLNkk2MDYySnBnUGt4OGRrYi9ZN09ldkRoZDRveXNJeVUw?=
 =?utf-8?B?YS9reEJOSW5pV3hSZ2N4U2RLOG5sM2ZFVEVleCtCeDdRWllRR3kycUpoQm5P?=
 =?utf-8?B?OHlhVlUyQXBHcFRtaUt4MFdCVHIwYkRzTXRoclBtUnlvWkNnT0VGTlZnSEFm?=
 =?utf-8?B?UFEwOTFBamJZdUUxY2ZlcElLSktqTW9LODVOanF1VU9hRXRMaE5hN2x6Rjdv?=
 =?utf-8?B?QVhmNDgxSkQ0bU15bFFHbXZoM3dGd0V4ZUwvRkZhTEZoZnRGNnlkVEhDMHpV?=
 =?utf-8?B?VFFmSm1mODA0RGpzTDVhSzRvQ2ptcCs4dDlCNjFYZFlOK2JkU29ZaHVzZEpj?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9ANVPbwdqScZCGeX4PFZa09WN68ODIoFhM3mtumYuxioLBcaujzWBfDGq1KDBwub8evr/rnXKQDJqRwNZZ0E4gqVckJ+8ZXzRziZTaMhuznllUiUbEGbCVqyhZArUKoi7bSX73qXivTQBIvkrlgphkJz5qw2990kRKoHk71pGLtzUOoWNJHgz6eKfNZT5TD4UC/ssPQghAIA+dTSLIPHO3LNR414lxzPeImC0jv7DCahEiZ/SmbqfeAbSbpeu3Y0R+/x14lR2fZBjz9FZ9drBfCessInw2IkwGpTvdUgQEI0ASwjrDD+G3+dvzwe4/w9hV9rG+Y4yx88iaB1IkJzYTJcTN9/tEMSpVb8hCPweIJlGoD7jjeCe7G7DAwwlGD9jm1qn94X0sF+hCxq0Uli1oUBp6wlENdfv+npb0s+9xi0gbQ167hhJUiERsszywbimClI3GzpHV4BGBMQSyiRmTT4tTPKGINCnQlEHbuNup1rRnAmBJmX+SU6wPzaEU4aAGuI2oRLGVG7+ApSH0e0FOSlsC2X73ln7P/0JfeXH0hp9kEUDjvSWd9h9qCZg3Kv5AqXm5e6wYpX1Rr1sPC6GhUgkn3XatcrPoEz+c4CKX8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b58246-72c2-4b0b-c573-08dda3718822
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 14:10:16.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AEikTL4ShJnJ/CEzsHfFkUB09AcK915y15cwruGUvZlxBPh+xn9ObQmbT5uy8Dun5iOxzQbJtmSB0nO+ekLcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506040108
X-Authority-Analysis: v=2.4 cv=aqqyCTZV c=1 sm=1 tr=0 ts=684053cc b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=BMxJXzqDAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=SEc3moZ4AAAA:8 a=2TnI0snvVwy6WDbLfz8A:9 a=QEXdDO2ut3YA:10
 a=5oRCH6oROnRZc2VpWJZ3:22 cc=ntf awl=host:13206
X-Proofpoint-GUID: fsZsNWMKxmqxERrSr391mmECByJfjKaD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEwOCBTYWx0ZWRfX1YJHtWnjr8Z0 r1VYBP66rmp/Q2FDtoMWOROaPrSsc2FdNQpLBCTZDzqNLmUP7bPgIgbltcyyuuWVyGe22gxpgx1 6LstcwX0Nk16ADXw6XActJDdUHuPpLFtMTnTmSesAxBIdQa3OwOLv7MSCVObnmTtZmG5B/cPpom
 s3jTIp4ZwdwYaMeT8y0Hu8IWzTFAqBRGyejE419OLhas9uR/QAs75Is8SgF2RR2QYXhcn5HQxzT dabeC3Lec3ftiZAsyUefF2ZKMZtWu94q+q+NM8lbeeuNIiWVjzhT7y231T+C/yaB9mAZKZNLcUA 04c4Zz/5O7gsoi1iYsTPgukpS/0cmpO9E1BLQQ4Ye/r8jlEqKF/PnKRnAd9dUZEf0cve5ybCyoW
 IrV2lAOXF8Y4SoyM4k3x8lZdd5S4jgv093eVIgwJMrHj2uB324xuMixaWT0IHjAS0v8B6ZND
X-Proofpoint-ORIG-GUID: fsZsNWMKxmqxERrSr391mmECByJfjKaD

On 6/4/25 9:07 AM, Sergey Bashirov wrote:
> When pNFS client in block layout mode sends layoutcommit RPC to MDS,
> a variable length array of modified extents is supplied within request.
> This patch allows NFS server to accept such extent arrays if they do not
> fit within single memory page.
> 
> Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
> ---
>  fs/nfsd/blocklayout.c    | 12 ++++---
>  fs/nfsd/blocklayoutxdr.c | 78 ++++++++++++++++++++++++++++++++--------
>  fs/nfsd/blocklayoutxdr.h |  8 ++---
>  fs/nfsd/nfs4xdr.c        |  7 ++--
>  fs/nfsd/xdr4.h           |  2 +-
>  5 files changed, 79 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index e5c0982a381d..d40a0860fcf6 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -179,8 +179,10 @@ nfsd4_block_proc_layoutcommit(struct inode *inode,
>  	struct iomap *iomaps;
>  	int nr_iomaps;
>  
> -	nr_iomaps = nfsd4_block_decode_layoutupdate(lcp->lc_up_layout,
> -			lcp->lc_up_len, &iomaps, i_blocksize(inode));
> +	nr_iomaps = nfsd4_block_decode_layoutupdate(&lcp->lc_up_layout,
> +						    lcp->lc_up_len,
> +						    &iomaps,
> +						    i_blocksize(inode));
>  	if (nr_iomaps < 0)
>  		return nfserrno(nr_iomaps);
>  
> @@ -317,8 +319,10 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode,
>  	struct iomap *iomaps;
>  	int nr_iomaps;
>  
> -	nr_iomaps = nfsd4_scsi_decode_layoutupdate(lcp->lc_up_layout,
> -			lcp->lc_up_len, &iomaps, i_blocksize(inode));
> +	nr_iomaps = nfsd4_scsi_decode_layoutupdate(&lcp->lc_up_layout,
> +						   lcp->lc_up_len,
> +						   &iomaps,
> +						   i_blocksize(inode));
>  	if (nr_iomaps < 0)
>  		return nfserrno(nr_iomaps);
>  
> diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
> index 442543304930..e3e3d79c8b4f 100644
> --- a/fs/nfsd/blocklayoutxdr.c
> +++ b/fs/nfsd/blocklayoutxdr.c
> @@ -103,11 +103,13 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
>  }
>  
>  int
> -nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
> -		u32 block_size)
> +nfsd4_block_decode_layoutupdate(struct xdr_buf *buf, u32 len,
> +				struct iomap **iomapp, u32 block_size)
>  {
> +	struct xdr_stream xdr;
>  	struct iomap *iomaps;
>  	u32 nr_iomaps, i;
> +	char scratch[sizeof(struct pnfs_block_extent)];
>  
>  	if (len < sizeof(u32)) {
>  		dprintk("%s: extent array too small: %u\n", __func__, len);
> @@ -119,7 +121,15 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
>  		return -EINVAL;
>  	}
>  
> -	nr_iomaps = be32_to_cpup(p++);
> +	xdr_init_decode(&xdr, buf, buf->head[0].iov_base, NULL);
> +	xdr_set_scratch_buffer(&xdr, scratch, sizeof(scratch));
> +
> +	if (xdr_stream_decode_u32(&xdr, &nr_iomaps)) {
> +		dprintk("%s: failed to decode extent array length\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
>  	if (nr_iomaps != len / PNFS_BLOCK_EXTENT_SIZE) {
>  		dprintk("%s: extent array size mismatch: %u/%u\n",
>  			__func__, len, nr_iomaps);
> @@ -135,28 +145,51 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
>  	for (i = 0; i < nr_iomaps; i++) {
>  		struct pnfs_block_extent bex;
>  
> -		memcpy(&bex.vol_id, p, sizeof(struct nfsd4_deviceid));
> -		p += XDR_QUADLEN(sizeof(struct nfsd4_deviceid));
> +		if (xdr_stream_decode_opaque_fixed(&xdr, &bex.vol_id, sizeof(bex.vol_id)) <
> +		    sizeof(bex.vol_id)) {
> +			dprintk("%s: failed to decode device id for entry %u\n",
> +				__func__, i);
> +			goto fail;
> +		}
>  
> -		p = xdr_decode_hyper(p, &bex.foff);
> +		if (xdr_stream_decode_u64(&xdr, &bex.foff)) {
> +			dprintk("%s: failed to decode offset for entry %u\n",
> +				__func__, i);
> +			goto fail;
> +		}
>  		if (bex.foff & (block_size - 1)) {
>  			dprintk("%s: unaligned offset 0x%llx\n",
>  				__func__, bex.foff);
>  			goto fail;
>  		}
> -		p = xdr_decode_hyper(p, &bex.len);
> +
> +		if (xdr_stream_decode_u64(&xdr, &bex.len)) {
> +			dprintk("%s: failed to decode length for entry %u\n",
> +				__func__, i);
> +			goto fail;
> +		}
>  		if (bex.len & (block_size - 1)) {
>  			dprintk("%s: unaligned length 0x%llx\n",
>  				__func__, bex.foff);
>  			goto fail;
>  		}
> -		p = xdr_decode_hyper(p, &bex.soff);
> +
> +		if (xdr_stream_decode_u64(&xdr, &bex.soff)) {
> +			dprintk("%s: failed to decode soffset for entry %u\n",
> +				__func__, i);
> +			goto fail;
> +		}
>  		if (bex.soff & (block_size - 1)) {
>  			dprintk("%s: unaligned disk offset 0x%llx\n",
>  				__func__, bex.soff);
>  			goto fail;
>  		}
> -		bex.es = be32_to_cpup(p++);
> +
> +		if (xdr_stream_decode_u32(&xdr, &bex.es)) {
> +			dprintk("%s: failed to decode estate for entry %u\n",
> +				__func__, i);
> +			goto fail;
> +		}
>  		if (bex.es != PNFS_BLOCK_READWRITE_DATA) {
>  			dprintk("%s: incorrect extent state %d\n",
>  				__func__, bex.es);
> @@ -175,18 +208,27 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
>  }
>  
>  int
> -nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
> -		u32 block_size)
> +nfsd4_scsi_decode_layoutupdate(struct xdr_buf *buf, u32 len,
> +			       struct iomap **iomapp, u32 block_size)
>  {
> +	struct xdr_stream xdr;
>  	struct iomap *iomaps;
>  	u32 nr_iomaps, expected, i;
> +	char scratch[sizeof(u64)];
>  
>  	if (len < sizeof(u32)) {
>  		dprintk("%s: extent array too small: %u\n", __func__, len);
>  		return -EINVAL;
>  	}
>  
> -	nr_iomaps = be32_to_cpup(p++);
> +	xdr_init_decode(&xdr, buf, buf->head[0].iov_base, NULL);
> +	xdr_set_scratch_buffer(&xdr, scratch, sizeof(scratch));
> +
> +	if (xdr_stream_decode_u32(&xdr, &nr_iomaps)) {
> +		dprintk("%s: failed to decode extent array length\n", __func__);
> +		return -EINVAL;
> +	}
> +
>  	expected = sizeof(__be32) + nr_iomaps * PNFS_SCSI_RANGE_SIZE;
>  	if (len != expected) {
>  		dprintk("%s: extent array size mismatch: %u/%u\n",
> @@ -203,14 +245,22 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
>  	for (i = 0; i < nr_iomaps; i++) {
>  		u64 val;
>  
> -		p = xdr_decode_hyper(p, &val);
> +		if (xdr_stream_decode_u64(&xdr, &val)) {
> +			dprintk("%s: failed to decode offset for entry %u\n",
> +				__func__, i);
> +			goto fail;
> +		}
>  		if (val & (block_size - 1)) {
>  			dprintk("%s: unaligned offset 0x%llx\n", __func__, val);
>  			goto fail;
>  		}
>  		iomaps[i].offset = val;
>  
> -		p = xdr_decode_hyper(p, &val);
> +		if (xdr_stream_decode_u64(&xdr, &val)) {
> +			dprintk("%s: failed to decode length for entry %u\n",
> +				__func__, i);
> +			goto fail;
> +		}
>  		if (val & (block_size - 1)) {
>  			dprintk("%s: unaligned length 0x%llx\n", __func__, val);
>  			goto fail;
> diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
> index bc5166bfe46b..c4c8139b8e96 100644
> --- a/fs/nfsd/blocklayoutxdr.h
> +++ b/fs/nfsd/blocklayoutxdr.h
> @@ -54,9 +54,9 @@ __be32 nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
>  		struct nfsd4_getdeviceinfo *gdp);
>  __be32 nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
>  		struct nfsd4_layoutget *lgp);
> -int nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
> -		u32 block_size);
> -int nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
> -		u32 block_size);
> +int nfsd4_block_decode_layoutupdate(struct xdr_buf *buf, u32 len,
> +		struct iomap **iomapp, u32 block_size);
> +int nfsd4_scsi_decode_layoutupdate(struct xdr_buf *buf, u32 len,
> +		struct iomap **iomapp, u32 block_size);
>  
>  #endif /* _NFSD_BLOCKLAYOUTXDR_H */
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 5a93a5db4fb0..81f42dc75b95 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -592,11 +592,8 @@ nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
>  
>  	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_up_len) < 0)
>  		return nfserr_bad_xdr;
> -	if (lcp->lc_up_len > 0) {
> -		lcp->lc_up_layout = xdr_inline_decode(argp->xdr, lcp->lc_up_len);
> -		if (!lcp->lc_up_layout)
> -			return nfserr_bad_xdr;
> -	}
> +	if (!xdr_stream_subsegment(argp->xdr, &lcp->lc_up_layout, lcp->lc_up_len))
> +		return nfserr_bad_xdr;
>  
>  	return nfs_ok;
>  }
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 846ab6df9d48..8516a1a6b46d 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -492,7 +492,7 @@ struct nfsd4_layoutcommit {
>  	struct timespec64	lc_mtime;	/* request */
>  	u32			lc_layout_type;	/* request */
>  	u32			lc_up_len;	/* layout length */
> -	void			*lc_up_layout;	/* decoded by callback */
> +	struct xdr_buf		lc_up_layout;	/* request, decoded by callback */
>  	u32			lc_size_chg;	/* boolean for response */
>  	u64			lc_newsize;	/* response */
>  };

Thanks for the suggestion, Sergey!

Note the MAINTAINERS entry for NFSD:

$ scripts/get_maintainer.pl fs/nfsd/vfs.c
Chuck Lever <chuck.lever@oracle.com> (maintainer:KERNEL NFSD, SUNRPC,
AND LOCKD SERVERS)
Jeff Layton <jlayton@kernel.org> (maintainer:KERNEL NFSD, SUNRPC, AND
LOCKD SERVERS)
Neil Brown <neilb@suse.de> (reviewer:KERNEL NFSD, SUNRPC, AND LOCKD SERVERS)
Olga Kornievskaia <okorniev@redhat.com> (reviewer:KERNEL NFSD, SUNRPC,
AND LOCKD SERVERS)
Dai Ngo <Dai.Ngo@oracle.com> (reviewer:KERNEL NFSD, SUNRPC, AND LOCKD
SERVERS)
Tom Talpey <tom@talpey.com> (reviewer:KERNEL NFSD, SUNRPC, AND LOCKD
SERVERS)
linux-nfs@vger.kernel.org (open list:KERNEL NFSD, SUNRPC, AND LOCKD SERVERS)
linux-kernel@vger.kernel.org (open list)
KERNEL NFSD, SUNRPC, AND LOCKD SERVERS status: Supported

In particular, Dai is looking at the Linux NFS server's pNFS with iSCSI
implementation right at the moment and might have some thoughts about
expanding the number of extents in block layouts.

Can you repost your patch with the current reviewers and maintainers
copied as appropriate?


-- 
Chuck Lever

