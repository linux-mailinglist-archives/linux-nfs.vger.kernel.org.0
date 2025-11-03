Return-Path: <linux-nfs+bounces-15915-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C38C2C5CB
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 15:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B711884A3B
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 14:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EAB13B293;
	Mon,  3 Nov 2025 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f+5jl3ox";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rUO1vuIz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B4627F4F5
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179392; cv=fail; b=UrfkHZcB0DKgX05b5r53ztMk6ldR/sBNOmXMiwsSBMyG1KOgfslTiaIBocpZ8v7Y56/Ws9GDv0ULjWtsBZTpNqq3I5BIIUEeZnaCcfxXcd5edJqqaTAHfHnV7HrpZSUnqTiisiOgEzevPpla7XFertDhJ6Na5xZgwr/vmx5FiL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179392; c=relaxed/simple;
	bh=uMZ6Fgwo5v5OZtTIhnR1Vrfx/unWIKda0DxEidYgkEU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kPbJFONAmekskGuAfF2qy7ptKVZDvk/YW1vByAdUHUx2QQyW7hjaK8WXF1XUkGJZVy7GE4ycVrnFR1WXWVu/LNlQMwthcYwZRAeciwLfJ5BY8p31+CLN1GQjjQRlNE5bCZZOwJrXr999RiYk8QOa0tkYUbzqtOzTPms6EHoL4fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f+5jl3ox; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rUO1vuIz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3E5SWc003371;
	Mon, 3 Nov 2025 14:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=H+QDQ0tP47Tu4sP3cQp7ADRy9j8Seh2OpViZPw+3OnM=; b=
	f+5jl3oxludEWBglgGDM4s4pL+9i5u6+zGH+gNmOzdIwRxwaRPt6UN+JWLKuNfWT
	nJAhysraH0rBfHozw55MdeLzQxkqrxns2chngIhnOSeD5otj2QlOHVcflnN8JADn
	A52GGo3RFKEHMuB1zsmWYh3bAc+hCbQfY13MDqBDQEnZoh78zTmTBvfdHrpsMm/y
	joR6tDXPtdAGKi43DKG12MiWp+h4Pq/+H4JDrAVKiX55WOiHnA3qbqI9fAgYsQw2
	vwaKpLte6K2hQM4QQi0f2A3fHUPkPSFcDONKhodHxZz0UsdxSQYcMJLweDFoI4+F
	eYQYGNx52lpW2N8tuWBcKQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6wu6r0uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 14:16:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3DdN05039711;
	Mon, 3 Nov 2025 14:16:20 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nhyk4h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 14:16:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2EHWBZw8Wp7b9qXExx2+WCQOmbkd+atHNwl5KApX126fq7fiv2NwTC9QkD9uBcBvlejqrbH2dashKZhQkIJUOoEE6jrkZ321LJHuH+4m9uH/zoRge3GwbMVgzTBWjY0w/acjS8d7ZMJrE4c6azCrgd1uBP6sFIlh6eay6rXmQ4xJte7kk8XlfNZqbrO6TtRYSBpeOsFKXa7A0N2HVRUa7PRJ0SzkUP/b+DLv5Y1vU1DXv+cjx8JxTwOyN1ANaN/3CPk07ZvRDYKAE4vdaPQckmPBrM0WsZ4LEHzxu5esLPf99zpPfaYPmdYiUci9QFZjF11UCgZQpr0Ih4qki8yvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+QDQ0tP47Tu4sP3cQp7ADRy9j8Seh2OpViZPw+3OnM=;
 b=GAu6EKlkEQDwyb+T0RJPDtx9CzmZBMqTN/G6/9dGrxicZA/xwrh68AXmVNxMKnppMjNqyZJ5DiaFbq1bMDqD2ndnedv1hXAcIRkmdONjddXk/sA4XhxxFCeipkxHZQ10cFTuJPfaRr1xR1IHLa1bqqM4c4shXhHi8CXJC9k3m39UotSGIAh5DXXeXhQgqTLW+nLatBmnEuGLIs0iYar3U8XTaoONf0KA3miDcDUPCtcu1EKB+VTitW6QhmLZ7+rJQL5NAPnyfN0xFUOmx7I2X1T5Ev1vD4gvPBPdSei7pzFxuyawluKipIxeZP9wUSkYSBgD8FjmOXYT+nLbiMLlFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+QDQ0tP47Tu4sP3cQp7ADRy9j8Seh2OpViZPw+3OnM=;
 b=rUO1vuIzDYgIJX/s/FCtVsvVVimOQObkcYdK1pbjMMDs7GLnfUsMoMACIRPXbidttChJMVVLkWMpbmLOFQSU2wn6iTLlCvgrZZxabx945IFBd8Z0Oqwuk/nbCkTz+VIQU0C9l2tWe0abQqOag8gLr4yuNunCotfrol5LTG4oBOc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PR10MB7927.namprd10.prod.outlook.com (2603:10b6:0:42::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Mon, 3 Nov 2025 14:16:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Mon, 3 Nov 2025
 14:16:15 +0000
Message-ID: <841a3ef8-d5c8-4f87-9244-f79a10c66e3b@oracle.com>
Date: Mon, 3 Nov 2025 09:16:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] NFSD: Do not fence the client on
 NFS4ERR_RETRY_UNCACHED_REP error
To: Christoph Hellwig <hch@lst.de>, Dai Ngo <dai.ngo@oracle.com>
Cc: jlayton@kernel.org, neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
        linux-nfs@vger.kernel.org
References: <20251101185220.663905-1-dai.ngo@oracle.com>
 <20251101185220.663905-3-dai.ngo@oracle.com> <20251103114500.GC14852@lst.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251103114500.GC14852@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:610:b3::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PR10MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7fc365-a502-4f37-7755-08de1ae38ce7
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZzR2Zk1hVDJDSWFYSDd1eEZLN3FqaUl4QjMrbGJ0YkFlcEJxWXFWQ1hVMkJz?=
 =?utf-8?B?WjcvOVVaV3lHaTVIczVoV3lldFBvbi9mTm92V1ZibmlmQ3ZXTDMwMUtUNGlv?=
 =?utf-8?B?MEUyblo1bS85U0xPcDFpSkVWZmV2dHd1a1lNdUlRdFI3MU5xbnV2ZDI1ZE1J?=
 =?utf-8?B?c2wwOWRWS3FIRTdsK252VHB5L09nVDlrMTZnQ0JzY0xtMkNWaTYveENFMitt?=
 =?utf-8?B?RVFid3RnWjVxTUhtN0o4RitzN292a3RnMUkrMFhNYU5Fa2JNSFZ4enVFZU52?=
 =?utf-8?B?SkdTbEdkb01nYTJGbmNFbXhxdUZlYnRVcE5QR1BZeFJjZkhoZlBZaTdCK2FH?=
 =?utf-8?B?NEpHSXE4akgzSVYrczFJWWFhV0o3Z2ZUMHY2aFlWV2ExRDdJRnJtMjRVa1Z1?=
 =?utf-8?B?MVlxbjR4dVEzREd0N0NSSDVJNkczeWVJVmw5VWZaOFNSeHNnbkRIMlpnZ2to?=
 =?utf-8?B?SHRWeWV3YjlUQXV1Z0VqTmg1alBGTFhhN0ErZStiZXVNNXBsRldRenRaWVFa?=
 =?utf-8?B?UDU1QjgyRWFFcWVaNWNJYWFodkppK3pIdVNDOEExL0NTY2diaHJWTW53cUR5?=
 =?utf-8?B?U0xzVk5NYjNPU1pjeWVKR0FmNnhsSlVudzVtZm52SUk0UGoweXdXUTB3b0M0?=
 =?utf-8?B?T3VyYUNLZlIwSkZocUtMWGFLbDNzVlJQR05nNDZuOEFUaGxJWjZETloxeThs?=
 =?utf-8?B?a3BNZ2U3M09tUks2QUF0TGMwd2ZJWlAvZmY5cC9ER0tmUXRGZzZuN0lpUHZH?=
 =?utf-8?B?SmJ4S3A2ZlVLQ2thcjl3MEJKM2Jnb2JValYxOEpuNWxFbWM1ZW9NNzIxTnZT?=
 =?utf-8?B?bjdBbWVST2hMRlQvM24zVnovbmg2NzJudlZmOWsyQlVLWXRTQzRZNFkvNnBV?=
 =?utf-8?B?cWkzZzZwbk9jZ1lwY2lDQ1hTTGJYYzNDTEhwWnp3OTZyNVRPc0QwM0VJOXor?=
 =?utf-8?B?M0k2MWlHTVF4eXpqdlluS2xOQldiaFZQelRxUGFVUXZCQ2tqM3FVWmViQnp6?=
 =?utf-8?B?ODc0VWt3RE55N0xPNE1ZY0tucWZJSENhdFVZTTZYR0V1NVRvMXI3M3BjV0Zy?=
 =?utf-8?B?MDhWRlBSWENiYWtFT2NHMVpCMW1TL09HbCtZbXByVGk0Z2hIdllrUGtZV0l0?=
 =?utf-8?B?aVNhdVhrdytQUGFjaFBvM2tsbytXZWYvbU5mMjk1VjRzcThQMWprS3hMdURY?=
 =?utf-8?B?QzBYcXRJMW15dE5aTENWNmIyOWpaRmpzTkxIWTliYW9jWnk5anUwcGFpeXZw?=
 =?utf-8?B?YlQ3aVRnazhRUFBLak1IS3dEbzd4ZE1uWTExSE85RzZBTkV6aS96RWxreUFs?=
 =?utf-8?B?VkYrcmdtcFZiN1lFK01FMjc2YWVUdUVrdnJLUTV3MGxhUFQrbENnanVmRlJY?=
 =?utf-8?B?cmNoNnBlZjhJNmxQdnlVWWhPQlc4b0ozbEluTS9Wb2xkaU9kT2lsV1c3cXRO?=
 =?utf-8?B?N3prNHZiZVFKM3lqRENWMEh3U3o2VWVSdUduY2ZHRXRJMjlYVVJuZVU5K1J1?=
 =?utf-8?B?VUwzNU10WTQ4WFFndVpCMk83QXdoWXJXWS9vbUUxTk9ENURzMTlFSzZKNlAv?=
 =?utf-8?B?eWpNcU5ER1RsZFJjcDk4VG5rRFdSNVp4SHJMdG9BSXV5MFB5VUhiTDdoclph?=
 =?utf-8?B?L3VKNDZ1dndTckdIOE9BMTJPQTMydlB4S2dqc0d0N1lOTnRPdVhKL013Ykxl?=
 =?utf-8?B?eHJ6TWFGYmtKVUVldzVXQm9RRXRhT1htWWl4enMveG5QUFB4ekM5Nk1ZdTRK?=
 =?utf-8?B?S3A0b0xINE80QlhJTTI0Ykx5TTVHa0dLYTR3a3BNOFVjZGFTWjN3a3ZSdkJh?=
 =?utf-8?B?OVRTVTlRazIxdWVzNGsvVDJZeWJMdm8ycmRsbEpBcWxaZGdqVXozSjhHRkFX?=
 =?utf-8?B?NSs5RktpMHY4K1FpNHNFOHhOQmNEUmpTVXV3STBkVlo5WUNmdm9jenRQMDZT?=
 =?utf-8?Q?oALfJ2nVy8lrlWAohZwzFe44vFOkbtYw?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?czdMK1crVXF3Q1kxYW5tTEt4TVR0dGhsYXh3WGc0QnZnTzl0TzZsZU1CNW9N?=
 =?utf-8?B?eE9ZRUJDWlkrN1FvZ1RFcEJTbE1ESTZPdGQwTlpKeXg4cks3UXg1QThiM2Y5?=
 =?utf-8?B?K3BZczVKTUxjbGxEaVRkTVpkR1FtMzFFQlZRZXZvMzE3RGgxVGlXSG5xQWh2?=
 =?utf-8?B?TWVhcjJvNWZQQ3BlQ3RpUVYzaGtRUmd0NFFuU0dLM3ROTWlacjd2bUc5SUZP?=
 =?utf-8?B?Z0I1eEtEbk45ZVAxc0FVa1FRUDYrbmdDUXIwR3doUFVBME1FVTBqNTZDVVVI?=
 =?utf-8?B?NGVVQzl6Uzh0SjlvQXUvK2ZCbDlXYmVTQUlwR2hNV1lEN0kvUGhXbHZ0WjVm?=
 =?utf-8?B?OVIvL0c3N0JBNTRkemVkcndyM2Q1Y1grUW1uZDNERVpLSndRT3Q3N21nZTJP?=
 =?utf-8?B?eFBraGFpbXdpbDV0U1RmdzN1RXhnOEVUdEVsRksvKzNUSjlOWng2TzlvWDBG?=
 =?utf-8?B?RnFydnVMcURvckZ1S1llWkQwOEQyakhZRDd1VHQ5RFNWUk9VOFhLck5KUWF1?=
 =?utf-8?B?bmt5QVhrU08rUnE5ZTVEV1pmVGlJSXQ5VTVsa0dsSTBGMnFBWjlzUzBpZnA2?=
 =?utf-8?B?Y09Jdlc1d0NKZTZhYjFuLzNSc2x5OEEyeU0xSUtrSWF6QkdYZ0N0VmNiOVRP?=
 =?utf-8?B?SVAwZ0M4RFIvb3F1eXoyUkxXY3pXVWZ2cEtMRnV6SjlSK051Sm9rZ01sSnBF?=
 =?utf-8?B?SEFCRVlRbzlDRWFLdmMvcWZXR1pmUjQ0OU5rOVJpQ1ZRSElQbFo4VzduemdD?=
 =?utf-8?B?R2lFbDRVckZROGdWa1ZKK2I2RjVheDVmemVVWDE4N00zdGhPaUo4S2ZIYW9u?=
 =?utf-8?B?ZnNYRncwVTZ1R0VxNnQ2cG1NMW9vVWFOZVI4K2dBV0p0c0Y0eFVhSlg3b2FV?=
 =?utf-8?B?VFRYK1YrWGRHYnBYUlhneDI0TDRlWk9NYllWUW8zK1dtOU0zSW1SV2VGVzB2?=
 =?utf-8?B?eVVGYU8vQ2JlS0Rra0xIYkdkS1pYdlk3OGRrcnVaZUY3Q0hZT3BJcnRaVU1X?=
 =?utf-8?B?bS9zUXdrZEE1aHlQWnhWL3Z5bkJCRnM4TGNVYnZwVFVyRVJ1SENrcWxTWCtn?=
 =?utf-8?B?bndzR1dZZThVN05kajFWSEhseFI5MC9sYno2NmkvRDNQNklKVjJzSC9Uc3VS?=
 =?utf-8?B?MFRhbCtmRk9Gekk2N0RMVXRreEp2dEwwS0FHSVloTVRqWHQ4cVQreGFuZFZt?=
 =?utf-8?B?VVpiN0ptQnFpWWlqTmgyRy9VUkpUTjBXYWgzK05YaXhLQjdDSzQ5U0I1dkEz?=
 =?utf-8?B?SEJvYit1SzJDVEEwVUVLWjc2VmNIbHcwb2ZNY015VlVxVnIwZ1h6TnlyVFFz?=
 =?utf-8?B?NVBYUWxCY2t5Nzl2eUhoU25HcXR6amdUWTVoOUlNdS81ZW1KZEZhMGdlRG9y?=
 =?utf-8?B?cXk4dEJqM3dvbGREQjVBd1NkZGgxb0dmQThHaG9pcXZQOFJadWg2M2xjQ0pO?=
 =?utf-8?B?QndxL2ZSejRJNWdwYkpyd20rUXc4M29Nb0J1OC9heHFxUGR1SEl5NVdESkEx?=
 =?utf-8?B?VnExNDRieVpQOGZHR0dHeWduRWJlSXVFNHl1bzU0d0dweW14WGRodmNyWFdY?=
 =?utf-8?B?dTZPb3pBY0wwQXZhVGVDaTBiWmJGWmhaR05VdmpJMW9ITWNBWXZXT2RmNmN0?=
 =?utf-8?B?V0tUckM5UGpWMS9TRVBra0dQa2VLZlVlMWdhUnlKbEMxMnBQbTN3bHZCN2VE?=
 =?utf-8?B?a3JWbWdHaEVrK1M2WUxKdS9WZW1mZVpuRmI5aVFVY1c3UklPcnZYOUJJejY4?=
 =?utf-8?B?MVBsSGFZQmt4WEVoYit4bFZRNVAyRWJGSHJmTC8ycW9xUko1ZkJwN3RaNlFi?=
 =?utf-8?B?SDVYTlJNOFR3REoyY3NabkF4c21RaG5ZczZuWE1TbVd2a0RwRHZMWWVUWXlW?=
 =?utf-8?B?RkRnbHNYaVlBMmdES09ZUmZlV3ZHdC9keDZPMlEydkdZMjBFaFJIdGZPWXVK?=
 =?utf-8?B?UFg1bDgxYWdaRlRPMXhWWEZaZHlSTGxReUpxVU9xYWpjdXZsci8vMlFxbWU0?=
 =?utf-8?B?eEhOL2NDSjJ3Y0habGVQSlhzZWM4NU81RXJ5V2F6UjVkc0JUUWkvNTcvR0J5?=
 =?utf-8?B?SHNtSG1yWG9TRHRVL1BZMnNKU3FMMEQ0NXIvZFFTOWZzZkJ4RG1Wb0lHVitX?=
 =?utf-8?Q?f5+iY0bZ5dPCmNVUkQGLPtxba?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oQsCv/5XaWumD073YY3j2C7XhNp6hNTeXPnXeoWaV6ywoSH+5DnjLgGr3aBebOuoLFRX+11MdiivZxYok4eXPNQYsxnGNI4pX5g5F5VZ005owZX37TvVfvcMvo0Nno4EVa2/juf82IGng/4ggAlUObG5NyFQnHlb1nPB9yonCnJPXtobQuRFWeoaFbq4ItdrhVYrGHvtbTlcRjo6RpAWaaZCk0Q8WlaBMN54raGQSowsWdm+TyHY9xnI51Msz7rv5rKbciM/ykIEY66zRAr252PdU4zESaQZCxqi0fNu/arbhFXTp2NWK5T8O5/n6l/Cw7shiIPNt8MrU/zJ/qf7M2gd3XLxi9KoJkQoh5SKaK7Py96KB3dW0iYIS1U8EbUT3o+Xfnaroq0f70DcKNBQDZlkmGo/w0Gqoszi6hkSeQfFcKHgQoNidIO0FpjiDAnBtXRmxtL/sd/BwNdEMfjnJAp/jQ9XnJ7G06QmC5Au0ZXMBREvbNzSsuMba6wENjSAoXIJA1SUfq8hubs79VnwZQwQ9KOFS4WmNi3BwRMPwNE2kwTUW7Ltf9j2ZpChz9eB+ay5XRdLJohOlSwkTOCcwrwP6PhmBRphpmiB6j53/1s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7fc365-a502-4f37-7755-08de1ae38ce7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 14:16:15.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzSrknCQBD/koiqbuYjCjxIMVwBHF2E5ZNAOVcEuED++ey7XreyIkhiZnNNstVPjrW10olXshmnczQO66ZoKjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7927
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_02,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030129
X-Proofpoint-GUID: 3n6G0OQmqXUKeDqni74aNvLiqfJzPGvF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEyOCBTYWx0ZWRfX10NC3TUoOJpf
 qZppY+rEbwiQ1bIiyEJMELL8Cscd3kOUuIWHTW0+8mCIvLMb5Um0qRi/pQHZyFl2X8hfeA6agRM
 EvN9YhKx2hc6KUNEEz/7NAnXDOTcdDp2U8VoSIUuA8My4Hq1t9OPcDkZXjmDZ7ifBffceDGC/kc
 jXF+rvA77NaZpW9WwdgF3WCq6jQDmOcbipV5iLMYEzUoQjNI8sXhMQLWoT1tT0kG82BxvUrZJbW
 9VYnmQd4X4yzBdDARx6AebV7UKQNZ+acD6G3jxniPt4tOBVfkUbBuyaECsFyiwE0gVcLJ8J9Mrm
 2enIO68Sfi5g9SowMMudF0b/Vx8OZ904KD5CE78UCnpgDireSs98F6Oev+jU6XU0wpYkDc6F7UF
 rAtU0qrMTwbvO9AmcSKwhNaG+ofT8rDcW6oLKs9W0GsM8QCX11I=
X-Authority-Analysis: v=2.4 cv=d5v4CBjE c=1 sm=1 tr=0 ts=6908b935 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vCYoxE5xf7RP7wHHFeEA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12124
X-Proofpoint-ORIG-GUID: 3n6G0OQmqXUKeDqni74aNvLiqfJzPGvF

On 11/3/25 6:45 AM, Christoph Hellwig wrote:
> On Sat, Nov 01, 2025 at 11:51:34AM -0700, Dai Ngo wrote:
>> NFS4ERR_RETRY_UNCACHED_REP error means client has seen and replied
>> to the layout recall, no fencing is needed.
> 
> RFC 5661 specifies that error as:
> 
>   The requester has attempted a retry of a Compound that it previously
>   requested not be placed in the reply cache.
> 
> which to me doesn't imply a positive action here.

Agreed, this status code seems like a loss of synchronization of session
state between the client and server, or an implementation bug. Ie, it
seems to mean that at the very least, session re-negotiation is needed,
at first blush. Should the server mark a callback channel FAULT, for
instance?


> But I'm not an
> expert at reply cache semantics, so I'll leave others to correct me.
> But please add a more detailed comment and commit log as this is
> completely unintuitive.

The session state and the state of the layout are at two different
and separate layers. Connect the dots to show that not fencing is
the correct action and will result in recovery of full backchannel
operation while maintaining the integrity of the file's content.

So IMHO reviewers need this patch description to provide:

- How this came up during your testing (and maybe a small reproducer)

- An explanation of why leaving the client unfenced is appropriate

- A discussion of what will happen when the server subsequently sends
  another operation on this session slot


-- 
Chuck Lever

