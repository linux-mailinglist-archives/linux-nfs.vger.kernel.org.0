Return-Path: <linux-nfs+bounces-2477-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6663888C99C
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 17:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DB81C63AD7
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 16:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F71611E;
	Tue, 26 Mar 2024 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OdOOfeEo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tNUrWHPY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDBB1BC57
	for <linux-nfs@vger.kernel.org>; Tue, 26 Mar 2024 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471377; cv=fail; b=dsMKalm37zh6P7DiwMMzW23J8Mco3AkjPKFEc9zlf18wSr1HqX/GmYpVQlywIn0xHH0DiemIvEk/rrx4FFZL5mhs0qvLmSiGoMZT+JVdLEx4zqUwh/vsZVdE+RNr4/QCbn+dQRZYGhbK9dR2I9BWgWaLHr8oHuQ5Fbzqh4E0xwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471377; c=relaxed/simple;
	bh=6v8cuklYw9fWvYimy/sNHO9yOBP/Sjtl6DqjORHz4+s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T3Zm6ucIEtkxwGRn/oQ5GX/IfNpZwERgRQe8fK2292JUis4It78E6JKP1AuLFxkDiA57mY/4QTvvuLjWKYuPeRGDXYOD8JvFDh4s4JyYDS8tFR018UaZKZoexkn+KIQg4rBXonO5X6TRXLfbOJf1AfRNSZHKIiDVflnk+cgv7m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OdOOfeEo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tNUrWHPY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42QF47wN025634;
	Tue, 26 Mar 2024 16:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uYFhTqbJuDO8yCtAtEeM8V81vptAS7F4GQmRHoWvosw=;
 b=OdOOfeEoAMkc0bVOSWzuP8t2r16Tvpc6V5WhAtsluCR/n8Ri9/RYWbC9CPyHaoW8DKdR
 ciOuVqMIv7z35rNpiKNlZSrvj7UtRTgQhkYjBbS4hCX+YjQTy7C68oedOURXPV1ZZyuV
 bnkaExWBODZT9RpbaA0UM3FOvWH+W88Qoj0qxEH0BBtdRDhtMBRhWXeLv1V0nDR+C/X1
 7dcfds2mFVcdeckiV8pitQ4raa/IuXohzrA6V+EvGMXgEBa+06EFn4/Q2MMahkLrwZ43
 scbhpzNBaPKJTtXdblAOjg2jYlc44sH9s2vLEeW6Y5enW4RzPP4io1B7jwCKU8DKOcUz Fw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1ppunh2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 16:42:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42QGZjfp017606;
	Tue, 26 Mar 2024 16:42:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh7gpxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 16:42:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRsMJST3Dn7TIAG9ji54jqPPxSYApAlBkXE5NGi884BNI0bPZvKXzy4zi2DZ3+FP6Q9CZ/c40THRAbbD5bmh9MQ5ecH7JB7esEwVgYodbE7sBt4Dm8owwBZaRV6r0awjQME7SDglT/SJKf9r76BMWI7iFPdW3RL7/5Ns4BrTN2JX8QgQMurdqCSebEHpIUXNRhTWD2FEfe4egoezbihgXeqwWHlMkmvVVwD6xUu6IWGRSKODD4O8XB8PQ6zJNETb3aoOziU5BbC9RMQbgYuy6Q/uC6TtPXTrejiBFIgNQr4sMajOgPREF3x4bHkaaujy+R17JAkysGljz6xa8aoFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYFhTqbJuDO8yCtAtEeM8V81vptAS7F4GQmRHoWvosw=;
 b=mmAfFdzU92Voh504YVw5KD6DISVtXhSCoOtrQxfgZQUd7gXh7Mfhzr92sjpjFylGQAMi9tNnagQ8t3kURtLef4tBlPSYm9tDSHHo64qs+44uueyNilPE1V7X5NtlR4jZG6gW9Kzxx9bkJw9WylkpJ0WXrqi9qvk8xqhRy/0hjO1iCSLDPbiZmJETmVCbeAQWks6kCYvR5g91HPHOkEB1t6ApjDPZRL45u8hAo0RkGxAiSNJyee/tPictq9EpDoVAnaIghvuYbs4V01anf2wz1eYR4hUIaVr3LQlXWmOPUkQ2SdhZbn30qO++uRKzV7i/sobgCgLfplLfPazVSZdwLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYFhTqbJuDO8yCtAtEeM8V81vptAS7F4GQmRHoWvosw=;
 b=tNUrWHPY0PE3ltzM4QavSIHw2t/ExM61bYDaF+gY0yscqu79OdyH9wJsGpRLq8ppyThncZaE9VkiRtzWeEwG0FV+YGbwJw8TB4hx3RgJ/ahuM7SB6CLd+S9z7/2GRUnnykulbxY5dBZ/dn4q6UeCHzXQ8r/nPZ3q0xZdWE0JRxU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6686.namprd10.prod.outlook.com (2603:10b6:208:41a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Tue, 26 Mar
 2024 16:42:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 16:42:41 +0000
Message-ID: <39c143cd-c84b-47b8-945f-bd0bbe8babfc@oracle.com>
Date: Tue, 26 Mar 2024 12:42:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: WARN_ONCE from nfsd_break_one_deleg
To: Donald Buczek <buczek@molgen.mpg.de>, linux-nfs@vger.kernel.org,
        it+linux@molgen.mpg.de
References: <5b63ad24-1967-4e0c-b52b-f3a853b613ff@molgen.mpg.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <5b63ad24-1967-4e0c-b52b-f3a853b613ff@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0030.namprd05.prod.outlook.com (2603:10b6:610::43)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6686:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0EWC8WoBSXz8bjzgO1+S5cY35l/gp7FpVbL6z5h745QjhwhVHbvUdTExSsstl6U8Xx0Ve1E0uCRsar0CSWDiwgl6OH1wWJUcmbjBMVB9haeTN1zaKF5MavL7VFPpa13CCKJw5CLMrIQRk1wScVfD2/udjGJqrN3u9P4cp06ry93Uiieon1/aXxhkHKUcADXw1QB+exqH2df42CtCIGIsX6/13uWr6XDpk6zOxV+bixDtxHqHf/Guc4Ga3CugRxBjPbz3P/A6GIAnUhZ22BOJzpMPfvIBRrfDpv9lHfeLcQpEs+P4bIAIeHduVqd/TTaS6qVt1pWgaApkH7cxxORD2nSbv0GEJpJfRaTytyBp+t+nlHauo0nw9z/KvZkZbCqxR4/BMflGrcSpOe++Qe6NKZjm8vClZQj0sGPLUebA2RolC6LFChg792jgLhwOoDUZUiNfYj7ZH4WsQ2rZfHJtD8LVxp7hsn1sUY5aEH5ntXdZGuEfAOnQ1RcXX88srcX5sWwvy6atdI3YU46ppI8iq5q04rzpTC+chYBK/o1SMl7PZ4+FilyAIimK6bQLtVuZLe3LPVq3N2OhudcGJAAX3MuF7HNuRR4B1eoNmkFpeu+qChL16Bovgrpo7H1VAQIvSC143qi+QwbczJBGa3bzaohiXnWinjC8x6Hr906UUY0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?enJLc2d5TGVJSnFjVXVOQnRLc0dRNDRmMzBGUFR0V1FJbGxYZkYvbW1ObWxa?=
 =?utf-8?B?RDg4NkFrWmdCUFZPK3BkOHdtckI5S0RqcnkzeVliQkZoajByMU5sWTVWK2Ey?=
 =?utf-8?B?Y29HeTZxYU1JQ0RtdUhOTVVYRjNJZmxnenlINXRNMWlLOTROY0Focm9KdFRu?=
 =?utf-8?B?amo5MnptSE1TOTFHcU1WemJac3hZY3pjV2NHSGhvWGJYVmpsY2FkNnptTEd5?=
 =?utf-8?B?em1nNDZCOW9UU3FiTEdXejlicFVCM1VBT3BOZ1hRa093M25sL3I2SnIrYUN0?=
 =?utf-8?B?V0pHQXR5aTFrMVQ4N2lVSC9XMyszZjVQK2NpdGRRVXFNc2hqVkRsc2hqUUs5?=
 =?utf-8?B?aDRCUU50S3hLVzVLbDJGZDB0bkRIeUFhMWl1NGxabnROcDNIRER6VE4rZzJ1?=
 =?utf-8?B?SEp0RFdnajFNWGhYZEtWN2IwYUVBYmZ1M2hZVWZDWVVGYkJaWWp1YUdrN2Uw?=
 =?utf-8?B?c3hTbFBmdlh3eDJ6OHJ2WjI4dzkzOGM1Sjl4VXp2VUc1K0NqMnZ3eEQ1ekR5?=
 =?utf-8?B?b09hOHp4dWUrY29NUko4VDlNUE9RNERCUFBheFZJQnU5TUd5UDJ6bHdvYlox?=
 =?utf-8?B?WE9ZZUdJK2hoV1haTlVKbVNqUlNoZEpmWmhKcjhWcXRSZmFsYjR0bURRbkYy?=
 =?utf-8?B?QUpaNzdHLy83RzFiT20vTVFzYmVyelMwODdMcDFXcEQybGpCTTlDVCtqK0ho?=
 =?utf-8?B?MlVKOGNQcjloaEpxRWVIb1pORkJXMkozYXM5N0NSRUFzOFZVMVhnN3lUSnZ3?=
 =?utf-8?B?VEFESDlVa1RzbUdCR0FGYnUwVWZEbzljS3FNTWYwenNpTXdKbzJkSTBNNjBB?=
 =?utf-8?B?Q29KNW1JNUN3TElWZGNjbEl2UzFyUWtVV3RWeEtWSU51YTJ3ZUw1OURzWUVD?=
 =?utf-8?B?c0Y4ODVHemR4amNla2s1WTF6V1BjMGRlbUxZSlR0bFU3Qmo4c1BLUjVnSVZi?=
 =?utf-8?B?dEp4d0NnMzdTOFpJaFNaUU9WZVpoQVVaSjc1cUU1V3BnV1pZYnAzUEVaVi9T?=
 =?utf-8?B?a0UzRmU5Vk5lZm4vL0NRSmRxaURkcG1VR1NGbnZiMWJiNUdqR0wydElXUk1j?=
 =?utf-8?B?cDhYQm0rVWkxS0hMU0k0cm12Rjl3QXIxek1YdzZKSy8yOTZyR1F4VTBVRjFU?=
 =?utf-8?B?Nm0xUUMyamZiaVZUZzl4bVRqbnRoSEF6T0x2WmVVQzdzSkZrdVJ0NUh4dWhW?=
 =?utf-8?B?VnRpcVB3UER4SHIvNXJrNDlMemU4TEdvWktLVy9WdzRsVlVyelRFQVJTeHVQ?=
 =?utf-8?B?Zm1xWGFXNzlkU0RQOXEzb0lwZFkrUnNWK2krSDJWVmhxSXhOU3RINXNBZHlx?=
 =?utf-8?B?eTdwcGlvU0xtZkExaFkydzRTTjBhdGxuUDkydUNtampOcUpBOFQwZGVKc281?=
 =?utf-8?B?dDFLRlR1Sm5ZUDJxRlB3dko3NUJ3bEcyeXZ4OGgrcDVxam9TQmtXRjJjc0lx?=
 =?utf-8?B?cnFjUkxDQnZ6dTNTZ00vYXFGeWtjd09JaW9CWlhtZ201NC9zV2FadElYaDAr?=
 =?utf-8?B?K1o2M1B6MjdzQmhHUFkvdWh0SFBBOFZxeGtTWitFTHBrZXpFbVE2QlJqM05u?=
 =?utf-8?B?aG5XN3doTHZKTjZHVzY0aDZnU2Yyc0JPMHA1WmtibDBVb1dxSG5mQ1QyS1Zy?=
 =?utf-8?B?QXRYcEhEQVNSNzYrYk9lVkRETkpMYVk3V3NXNWhTQU9DN05JeUtnLzErSHk1?=
 =?utf-8?B?SjFkc0pQRDBiQ2lncXFnUnVzN1BSVkZVTSsrVDJhRVh1bGdQbUUvK2YxRHBT?=
 =?utf-8?B?cnlBZENEaSs1Y3I2TkMwaTMvMHYvWkVTc09aekFIN2FQdHMzMzBMRGdwSWFv?=
 =?utf-8?B?WDcwWGFIb0pFT01nUktpaDZFQWNEYkZsdnRIeWtsVzViT2pzTGU4eGNlZlVL?=
 =?utf-8?B?cWtIay9icWdKRGZHQ3RldzgvOXA3a1ZzVTRMTENHQWQ3U1VObndYSmp1Zktr?=
 =?utf-8?B?SVZZS3JxdEQ2OGgwT0EveWdSZVRxREJBWlNJN043bzN6SVBsbkYvQkN1cWYw?=
 =?utf-8?B?OWk3LzZCajZ2MTNjTHZ6cC9Gdng3UE1SUkVISXZYd1c2ODgxQ3RTaDR3aUpM?=
 =?utf-8?B?dG15TTA0U0pKSG5LY2ZTME9scWxmZXBHYkhsR3pKemMzd2R0VzhlcUJOYzR3?=
 =?utf-8?B?YWlCeXU4VVQ2dGhSMGFRR25rUFMxMWc5NkxobU4rVWVvU2g3SGplN251WHpG?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kX/ipplFkjTm5mfcPBuUqy4q57WWQUDaOK7p6NpD5crcVBx3FOZfTtwQr9WH94Uve9HNt9atGFOE3nX19ZqaSh7MPqZgevP/PbJOCOrg7uysplrBqXlfynmFJEnBF8o2GoRMY4v2AQp6DWaWisOrot/sKN4OyvNeqZwFFmNE5uVLTvbZSdQlk8ZZ5M1S4m1dfgjYwEHZnQQJcW1bIQyPKOHrTs66N6HHdKTSx1BOmWIwzJ3lIMCtspyRkN1CSOrrvLvwc4XQDQTus5nBr5s9vSuQp4xuQAHayHyUJBfu7maqRBCrVaefbFv0e8YGWxgXSx4k9K5udLKm0VOkUgu0H7O7K6IraDg0RU2qgE31QXGiFTMltzRnrDIIX0YoeHuUWADJS+IWcEi60B+EYMceM3cQ2HYvRt1WB5Zt+u2HbPDmot1/Z72+0E5JfRUa+4SOdUKAS5EeGqzxdPjDemgpC61RTDZl37xwcOjzrvrEnmNt8QbnfH5zHoHRHG/ltJKnfemzT9e/Pri4zCT59HMwVBkQKnw29WxiK4it88YpGNLAGtNfWTsyQuIXpPumWs0qSMjKLyUvwyITrr2w1KgKbxAFkZx37QJYM1mcGZCyG54=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec16528-b2cd-4908-4aab-08dc4db3c0dd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 16:42:41.1071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFZQSPgapQs0MZ2d1bQo+A3DZ1c/qy+PxpmaM3ewMvNF1z0mO54hY6bV3+fTFCG4KXVFn3tOLnj90tIA36flGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260118
X-Proofpoint-ORIG-GUID: bhFQD_WpTEN_cQv19Ugt-FnMq6-e9RGv
X-Proofpoint-GUID: bhFQD_WpTEN_cQv19Ugt-FnMq6-e9RGv


On 3/26/24 11:04 AM, Donald Buczek wrote:
> Hi,
>
> we just got this on a nfs file server on 6.6.12 :
>
> [2719554.674554] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000432042d3 xid c369f54d
> [2719555.391416] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000017cc0507 xid d6018727
> [2719555.742118] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000008f2509ff xid 83d0248e
> [2719555.742566] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000637a135a xid 7064546d
> [2719555.742803] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000044ea3c51 xid a184bbe5
> [2719555.742836] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000b6992e65 xid ed3fe82e
> [2719555.785358] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000044ea3c51 xid a384bbe5
> [2719588.733414] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000008f2509ff xid 89d0248e
> [2719592.067221] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000b6992e65 xid f33fe82e
> [2719807.431344] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000fd87f88f xid 28b51379
> [2719838.510792] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000432042d3 xid fa69f54d
> [2719852.493779] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000ac1e99fe xid a16378bb
> [2719852.494853] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000017cc0507 xid 0f028727
> [2719852.515457] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000017cc0507 xid 10028727

These clients are sending NFSv4 callback replies that the server does 
not have a waiting XID for. It's a sign of a significant communication 
mix-up between the server and client.

It would help us to get some details about your clients, the NFS version 
in use, and how long you've been using this kernel. Also, a raw packet 
capture might shed a little more light on the issue.

> [2719917.753429] ------------[ cut here ]------------
> [2719917.758951] WARNING: CPU: 1 PID: 1448 at fs/nfsd/nfs4state.c:4939 nfsd_break_deleg_cb+0x115/0x190 [nfsd]
> [2719917.769208] Modules linked in: af_packet xt_nat xt_tcpudp iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rpcsec_gss_krb5 nfsv4 nfs i915 iosf_mbi drm_buddy drm_display_helper ttm intel_gtt video 8021q garp stp mrp llc input_leds x86_pkg_temp_thermal led_class hid_generic usbhid coretemp kvm_intel kvm irqbypass tg3 libphy smartpqi mgag200 i2c_algo_bit efi_pstore iTCO_wdt i40e crc32c_intel wmi_bmof pstore iTCO_vendor_support wmi ipmi_si nfsd auth_rpcgss oid_registry nfs_acl lockd grace sunrpc efivarfs ip_tables x_tables ipv6 autofs4
> [2719917.818740] CPU: 1 PID: 1448 Comm: nfsd Not tainted 6.6.12.mx64.461 #1
> [2719917.825777] Hardware name: Dell Inc. PowerEdge T440/021KCD, BIOS 2.12.2 07/09/2021
> [2719917.833781] RIP: 0010:nfsd_break_deleg_cb+0x115/0x190 [nfsd]
> [2719917.839911] Code: 00 00 00 e8 3d ae e8 e0 e9 5f ff ff ff 48 89 df be 01 00 00 00 e8 8b 1f 3d e1 48 8d bb 98 00 00 00 e8 ef 10 01 00 84 c0 75 8a <0f> 0b eb 86 65 8b 05 0c 66 e0 5f 89 c0 48 0f a3 05 d6 1a 75 e2 0f
> [2719917.859303] RSP: 0018:ffffc9000bae7b70 EFLAGS: 00010246
> [2719917.864962] RAX: 0000000000000000 RBX: ffff8881e2fd6000 RCX: 0000000000000024
> [2719917.872520] RDX: ffff8881e2fd60c8 RSI: ffff889086d5de00 RDI: 0000000000000200
> [2719917.880050] RBP: ffff889301aa812c R08: 0000000000033580 R09: 0000000000000000
> [2719917.887575] R10: ffff889ef63b20d8 R11: 0000000000000000 R12: ffff888104cfb290
> [2719917.895095] R13: ffff889301aa8118 R14: ffff88989c8ace00 R15: ffff888104cfb290
> [2719917.902625] FS:  0000000000000000(0000) GS:ffff88a03fc00000(0000) knlGS:0000000000000000
> [2719917.911094] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [2719917.917236] CR2: 00007fb8a1cfc418 CR3: 000000000262c006 CR4: 00000000007706e0
> [2719917.924760] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [2719917.932285] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [2719917.939833] PKRU: 55555554
> [2719917.942971] Call Trace:
> [2719917.945834]  <TASK>
> [2719917.948344]  ? __warn+0x81/0x140
> [2719917.951983]  ? nfsd_break_deleg_cb+0x115/0x190 [nfsd]
> [2719917.957470]  ? report_bug+0x171/0x1a0
> [2719917.961562]  ? handle_bug+0x3c/0x70
> [2719917.965459]  ? exc_invalid_op+0x17/0x70
> [2719917.969715]  ? asm_exc_invalid_op+0x1a/0x20
> [2719917.974317]  ? nfsd_break_deleg_cb+0x115/0x190 [nfsd]
> [2719917.979820]  __break_lease+0x24b/0x7c0
> [2719917.983991]  ? __pfx_nfsd_acceptable+0x10/0x10 [nfsd]
> [2719917.989495]  nfs4_get_vfs_file+0x195/0x380 [nfsd]
> [2719917.994740]  ? prepare_creds+0x14c/0x240
> [2719917.999164]  nfsd4_process_open2+0x3ed/0x16b0 [nfsd]
> [2719918.004570]  ? nfsd_permission+0x4e/0x100 [nfsd]
> [2719918.009618]  ? fh_verify+0x17b/0x8a0 [nfsd]
> [2719918.014243]  nfsd4_open+0x6ae/0xcd0 [nfsd]
> [2719918.018777]  ? nfsd4_encode_operation+0xa6/0x290 [nfsd]
> [2719918.024524]  nfsd4_proc_compound+0x2f2/0x6a0 [nfsd]
> [2719918.029922]  nfsd_dispatch+0xee/0x220 [nfsd]
> [2719918.034619]  ? __pfx_nfsd+0x10/0x10 [nfsd]
> [2719918.039144]  svc_process_common+0x307/0x730 [sunrpc]
> [2719918.044551]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> [2719918.049883]  ? __pfx_nfsd+0x10/0x10 [nfsd]
> [2719918.054404]  svc_process+0x131/0x180 [sunrpc]
> [2719918.059171]  nfsd+0x84/0xd0 [nfsd]
> [2719918.063012]  kthread+0xe5/0x120
> [2719918.066539]  ? __pfx_kthread+0x10/0x10
> [2719918.070664]  ret_from_fork+0x31/0x50
> [2719918.074611]  ? __pfx_kthread+0x10/0x10
> [2719918.078735]  ret_from_fork_asm+0x1b/0x30
> [2719918.083018]  </TASK>
> [2719918.085563] ---[ end trace 0000000000000000 ]---
>
> nfsd_break_deleg_cb+0x115 is the `WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall))` in nfsd_break_one_deleg() in our compilation
>
> I think that means, that the callback is already scheduled?
>
> One nfs client hung trying to mount something from that server.
>
> Best
>
>    Donald
>

