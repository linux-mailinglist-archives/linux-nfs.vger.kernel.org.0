Return-Path: <linux-nfs+bounces-19993-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCgpCEo5sGlbhQIAu9opvQ
	(envelope-from <linux-nfs+bounces-19993-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 16:31:22 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC9425393D
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 16:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6405C335D34C
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 14:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F392FCC0E;
	Tue, 10 Mar 2026 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d4Jq38da";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PvsTJiZX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282EB3002D1
	for <linux-nfs@vger.kernel.org>; Tue, 10 Mar 2026 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154790; cv=fail; b=mhhyWLrFg3qlCDuaRdwhRkp5NW1x4apqKRpPylEapuQTzeWzwedP6hL+vhfYxizOy6ND9NF2aCeiRcTdgC7VE5rqrPTxz0uzd2JfsDJXYsZV7xd7urqXAF/+Ey1+APMachT9k9KCmJ7TRfNbw3aZlGmbtcSnFJAat4NqjUwP/98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154790; c=relaxed/simple;
	bh=9CztMGwmIBJJWbaS+qwRu6Rl8f2c93xIMO5zManPNoY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MBVkY8cyw9cJUiOvpAK1pgf8OVnmeM1PO6fj2Yiudxkc8QNARC3FuKXE3GJ+PO7u6h4dSckGdCxqFzeHOfhMmxypMMO+dj/8fYjAy6BezY2vY7a8bKVm76LyrefwTdYLngvrDgrYULt456sc48u0q7oMuwA0AybDdSbhjCnTGOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d4Jq38da; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PvsTJiZX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A9J3tV094083;
	Tue, 10 Mar 2026 14:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YvgaADbiwMOdQuUwZAWe2asaffY9Fm1wEjmIMcTAZy4=; b=
	d4Jq38daPO+TkBCzKOJrTvX6rG51BOfGGkTNGGlVDaOQqNZPaqHBDgEXdNgpLx33
	R0/auWLcvN2ghi88me4HRluphk4b2/ceXNUvQ5KJCHIXnWDqfKMM9+MZKrYujcfJ
	bMmCuenC9qOYsH8iyqLgawl8G/mTbxeNximHBp0ONnG1yOKG2SIBWdKdI8vwX5WS
	DM3MqOD4GewwSDuDJhd18KW4YJMhNJd7dJl3ivMk8nL/Ksu6/6F4YqtPApW+64UH
	9Oo1FaGZvXnyjS6CF2p8OQPeCarwPSQSrQJJ30Efeca6rULgQkLujpplqVMfwaJp
	AH941u7c7xRssHrFl15/pw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csmdkk0y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 14:59:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62AE82bk009040;
	Tue, 10 Mar 2026 14:59:34 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4crafa72k7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 14:59:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYfbEssLuNu0TfvcJklqaHK4Eu9RW3Z46cDRennFEnad3Nfo7ChG3AdzP7LJxamUitTgsL3WJesOumTDGqy47Bd0yguPrbxHcd3NhGGwrtt2Yodbha1FEkIn4Y4VQfcQc4/VA5Kaah3IIIxGLazHIGGZML3P1ERxGC4yHS+0kQ9Iyb2DFK20jT4vSL5qwA9VeaN7zcoCzMmT+OH3AxvmcMS8haL6xUYmEz7HAS/CClzIvOTyMYNweqOGNVA0RQjHr99zvum1/x7+8fXeABXMjMndXScGzJwGD3mCYEa0vAWgu8neuLOcME2WctZB/IF4E6B1w9opImu1A2nh+pYV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvgaADbiwMOdQuUwZAWe2asaffY9Fm1wEjmIMcTAZy4=;
 b=Fucp+jSR7cqwZu+2QJqVC74YI0UCvrarga+w6Fvlr2DDhrhj+aNx5o22p1tDYLb5/Q4pxCsaKVU7IPR/1HYm69vs5MuIJmZYUjV2LiROOtrPHLlTO3kt87uUvejw3rvC1Oq0MLYvI3asav09O/evY5859XF/wCuecDnHwPs8FxXgrezznCgbmeMgEGFWrI+Qzum9qow4ae1b3HU/Byrg33mDZe/97D9D5J74qCkS74eoTbzG5wB1Qw3r8H82QMkpxqvMZzyp503xHmyzafr4Mfisu1d63PrzGponFTQPY/0mtTXFGjLYe2k0yaGvAB0NGisiTWid5APD4bTDlN8aaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvgaADbiwMOdQuUwZAWe2asaffY9Fm1wEjmIMcTAZy4=;
 b=PvsTJiZXKoldmAjjySk+rznf4kck+NCQhO/w6zzh76Od7X4ef8SnIOVoBPEAoQhfFLuW25avPgP5btkkvjY4Fsxc8RNEkKu/rThmzH6lfug1WRBjIzf1G62gfgeWnB6jP4JIq/n4b1I+iMkuioJu5FMnqPTPrWWX7ethixVUOHA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4214.namprd10.prod.outlook.com (2603:10b6:610:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 14:59:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 14:59:31 +0000
Message-ID: <caf43aae-e08a-423c-bc32-04acac9d20a4@oracle.com>
Date: Tue, 10 Mar 2026 10:59:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/11] NFS/NFSD: nfs4_acl passthru for NFSv4
 reexport
To: Trond Myklebust <trondmy@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna.schumaker@oracle.com>, linux-nfs@vger.kernel.org
References: <20260224192438.25351-1-snitzer@kernel.org>
 <abAb8NYJECfXkRLg@infradead.org>
 <1c630798e0c931310f86f636abe84a72b86f7aae.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1c630798e0c931310f86f636abe84a72b86f7aae.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0430.namprd03.prod.outlook.com
 (2603:10b6:610:10e::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: e67696a1-ea48-4438-2dba-08de7eb5a25b
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 Groz9SFIcfs7u9Wp0cy7kQivSttOzvIOypBAIS8/0GzilNsiTv2rHXE1C5wAeJ0IuZRuSXrig2EEDTMegqQKGuN6MvsRKW+Y7Z8nwcdFuhHpUljU9P+rd6Vi0qUOL3hWDJXgqE0+ltnpZkBLgZb9Km2MrzepjHCJ1EisceLD/OggV2QAxBmzKa45rGmTJhbB1WnJs0kMUpjduuyjzOS/bOmNQLQF5JU5eQ3CAzQCxemqV6gAahsSBFZz/wRunFfJkkabclWc7dA7zpnmeULoxaa3sWrqFP8PaAB8Ew8cRDWna0Jme8GYRwZ/n8qdgPZsjbnfUSMkRLED2nMlEKpSxSUvsrOE4eIxIctgzCrzbqSDzChGdAt3QA4L1wiop/X+4Lxed870l5vesDkQ8aWxglUOa42VHcxAHz796tAC4EC68uu1jQ6A2qzkcGuapJwU/QpaDX/WdraBH3dno2NLkalbAZqwKp4WeXgm/4FL5of4ztFvQK/7VTFxibbDfRRathvVvtc3FWX72+0HBLNkQle83aJ1jLlQp4W1amPo+VIPGxJ6tLFNqa4PaDSY/Wsjj81ritZ4u1vEo/705/7rak6TTaerL7CDZCbpqKZwlTp9uUBSr+7v6Ss4D3FzCjSCR91NgDKlCWSMC0sGiPqG7nER3WefKnrUycC1VIenPFW9O6yMNHw5y+27w6+wAdyrr5gBLtjxzD1x8PsPUYQqXWdvDZC37Aw5cybuWJntjCk=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bzRmS250TlpFT20yS08rNHZxR0ZlOTZoOW0wbmJvZ050Qmc3cG1aL013a2RO?=
 =?utf-8?B?VDI0bUI0UWcvVzJOTlZ4cWJBMVp2OER3TnFMK2xXSUI4Nkh1cUZDUC9NQTBV?=
 =?utf-8?B?MTArUkpSbmpPUGZKTGlmSHdMYnlqa01EWlp1UHBYdm41bjRmOThFcmZLRzRI?=
 =?utf-8?B?WXF0L2NMQ2pTakxGNWdkWXNIL2xyZVg0QTEvZGFNN0NhTlRBSU5MZjZUTmpo?=
 =?utf-8?B?V3BLNFlINHFiRy9PS2UrTXVucWRSczBQRWY5cGllaVBMVWoxUnhWWk5NNVIr?=
 =?utf-8?B?a0JGN0JYRlMyczBQYjJJVVVSaGZ0TDdOcncyWXY1UkxoQVNOa0hub0hKUmdr?=
 =?utf-8?B?WUFiZkZTZWhzNFZxWHR6eHZza1lIcVRUSHllZFBzc205MW9aTG1YQk1DTzVX?=
 =?utf-8?B?Nm80QUpuaTB6VzhyYTFGZWhyWkFiZm1OUVd3dnF2b0hnbFU0dU4rQ2djVVlp?=
 =?utf-8?B?VmhvbXpPaENZTFlUdVNmaHNLbjBnbFNxdG51UmJBS0UrN2pSNjgwYXdGME9P?=
 =?utf-8?B?K0N6b1RpaTBiSDJVUUpNQThaNlJDcjR6aDJUbEZYQTFqTElVbWszZ1BQd1NH?=
 =?utf-8?B?K3lmdG5ha0kzdGJVdW53dFJCd3JDbUZ6RU1VWGxmWHMzZEI0NUUramFnK2Rh?=
 =?utf-8?B?SHNWaFQ0QXdJR0h0dmJFTXBySHNGU1BRa2J3anlYK0poQnZOd1NxbjczTVNI?=
 =?utf-8?B?RTIxTjdaS2R1MzRzRmZxa044V01rOUFlOThFYTJxVnpoQWtGT0FaWWo2d2hU?=
 =?utf-8?B?a3dDMWhiN0FwU2wwd0FYK2lHSGtQY3REc0FUMlgvU2cxY1A3YURoRWFSZVZR?=
 =?utf-8?B?NXQyeWQzMWx0aWRnTWJvODcxSlRRQTNTTlZsQXFtTld0TzRtYXFBRnByMW03?=
 =?utf-8?B?T1ZEODBlS0N6Nk1QUnFQQVhvZXE0QjFOVHdnNEozNE1lcFlFT1hKTE5iY1gr?=
 =?utf-8?B?N1N1SWRtRm9rRDVPWW1ybFhlZDdQVmd3Si9WU2pJK0J2S2VqM0dOYkx3WlNM?=
 =?utf-8?B?OGRSbTdqNU0xOFpRTGtJTnY4MXQ2R09UbkFnWTU1OXhQRHVRTjFKSU43WmdF?=
 =?utf-8?B?bWJyOFFPUU1YWjhjemltcm9GYnJsc3B2Nk1CU09RbFgwSXprSnJxTk5JQUd3?=
 =?utf-8?B?Z2NWWDV3cHpIcVpzcCtaRlp5eThlQTJjQ2t5c3pxaWFLMVhsTzRsQm5vaEhM?=
 =?utf-8?B?eWJMRTgyMnVhTjJZMGRYZ3c4RVR2WGxVZ3BSSWNMN0tJczF1dnQvUTJhVENj?=
 =?utf-8?B?S3NHcStXcmZBaEM4R2NhY2g3M09HSW5iQnFpU1VVVS9KMlU2LzBWSEVlcDNl?=
 =?utf-8?B?dUp1Wmdrb255cnlOdW91TW5MQXl5eWpNOHczdGZsd21qSUs3QXU1RkdmTStB?=
 =?utf-8?B?Z3lBL3VjRUY2WHE1WkZ1OGNJMFhZNDNCK3MyUy9qUCtDWml4UWtGSEVKK3RH?=
 =?utf-8?B?cld6OTk3dEppbWJTNVlzUjUrTk9PaEF0ZmlybTFuS2pHaS9iaUNmQ05vSGhY?=
 =?utf-8?B?TW5jNmltM2oxQS83dlE5c0xvNDduSlpTenV4bERZQ0xxSjdBMjJmQ1JiaDh2?=
 =?utf-8?B?b0FJekp1TUVoZHhQdXJlYVVZK05MMHNrbHJJekZrZUVSWnlZK0FKYUxlTWhp?=
 =?utf-8?B?WFRzYzdITkEzZitCK0UrdEI1VU9ocW9ETVM1c1dMQzJjVzIzSG1zRk5TRE42?=
 =?utf-8?B?VDYrcVVQUDdrcEF4QjBzb0NrbTFLQmV4TnlwTVlmbGx1bkRVOU5Bckw4M2U3?=
 =?utf-8?B?dFV1MWdFbndFSXVZb1h6eTB3bnhqUnVoektRQWhLeXM5UGJhODdyUVJPcEtP?=
 =?utf-8?B?Rkt0akUySWFzWTdEUDRseW5DMDJhbnJqblgxbHFPMk9YdWExQ2dwL3dDVWVi?=
 =?utf-8?B?ZzEwaUVKMVUzeTN1eElxK1NBTjJnZmJCSmRSdTJSeTRUL0N3d0tsT3Myc1U0?=
 =?utf-8?B?Y2VCMmF0WlJITVYvejZZWDI4QXFVbjAzaEhPVmNlK0JYSCtLLytaTVladWJ1?=
 =?utf-8?B?SjgwSmQvM3crMFp2UlQ4S1dQSm13Qmg0L1BneXFwNjNPM2xPZzkvSFphWVZ3?=
 =?utf-8?B?SUhaUTY0NmhpRk5TWWU0TVV2YlRGbnBqejVEUjJPS3RSdXNTdlVjcVpUR09I?=
 =?utf-8?B?dG1kQ3RKc055cGEzNUlzVC9HVCtldUlxVzdnNzRwcGxoWFkzZkwrZ0NoT2Za?=
 =?utf-8?B?a0hzRWdCR0dBdnJ4ckw1R2I3NVBtQWtQYkFncURwRDYzSjlwcXY0dkVZV3hZ?=
 =?utf-8?B?R0lCZS9FQURlQStKQTZqSXhYMStEaW1waU1rZmZSL3h2YlJwYktBVVVYczlS?=
 =?utf-8?B?NE5iTkNFRVVkUW9xaU5nWEJwMEp2eUJFd2JBSG53c056N1YvL0JnZz09?=
X-Exchange-RoutingPolicyChecked:
	OsJMBIUOQ+Fe6EJrEnWoPenmnSddy/C6suUt0mdDQ3anUcRWDpZSDYeuhmoA32u3mAxGXc2hZkl+AncRpmi5AMQw40YytMuvB2PhAb23jpfbIoUG1mbKgyW7Ac9UNYDsbKGQWlx7xONn0A7GuqjiKBZQmPnkdehp9fV004cZUaUKFR8qG6pXiW8kw9/0Hh+WcRoKESJzVWoU3jK+Mka0W1d1RVE1N7PllqfXFDqApr9fzQ6H5diG4UBynQn4VJp0U1NK0Z7lPWhe78UqYx+u2kAdSlUUL7I2KFL/1LRZM8UkBz414x1XXVfHy3ejyhk/Sw2QAi/M727+U1K+fl6RFg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RxobSEzXn+tMizVNlPeVlIMdW0RjWaqzCd0dvg1+JQ18St8VTnzqRftDMHLnIrJzjDeXVUi3b/xxm4p3lUAjLVVE0d0ZYSRKTUaYxzeap2khdBqIrOHttqyfe9RuANRqHzOhVD3RIrrEoeUzxEFYV34dsHXY9kSkxuaTRDjJRierVK9SpZJhqcT0XpSuO3jBnaoyfnt/P860ujn6+KnQPAWB4+8sLtaD3vCmNgO8T2l3w10SvJMeG6XJaf6OFLA/Vw7BqpFfv5rjgfC8Jz4YXb+1i4tip9/6J4EiTrdUE7vNCgjc5hswc+ayVrr/tPL4tspoHz1Xs4uipwB+kMb1bJA9S1jwHvtDhSJOhoZ+EF465AIhKweTWTqEir31pXlCf/90QVhHRtURzFwCAWJL5DlAUs8lHtUpuMeAKLaI9X2R62Cst0TSKk9xOT4ioxebMbWxKs23oKdIBd9qbMBkze/oSfwVS1jk+MXzydW+rSFmE+/n2ER1WPvcxiBWG/BCu+SraAAPuvdbzmkENQz/1NdbGoYwQKzbfEeozYZTBymAaFIpC8IWCcXDf6kdk32E+tKGjKytXC9uChBMOvwKbCPLU1le9JHyfzJ3C2ON8Dg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67696a1-ea48-4438-2dba-08de7eb5a25b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 14:59:31.5387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCAc9yQogCiiQDysPZj0Z9IT63VUFLjBweIwz7ssAVvAqNduW82d80ST9e8IHWZiSfpeTxesR9t0NKX5VFwIqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603100130
X-Authority-Analysis: v=2.4 cv=MuBfKmae c=1 sm=1 tr=0 ts=69b031d7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=4WvFUIpoJ06I5X75CLQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HLd1imMbh4Fb3C8OvWqnH4MwPb_z4EHW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzMCBTYWx0ZWRfXxrDxD4P+2V4z
 a3dsLMreGGW+iXf2ThZLEg1av6kx6NvVvNT/91AAL/VTlqmSaET1NpfUp31ySoCDSWr3TupTWPc
 3ecn02WZNfrqZZFcSU8hY7XR1jlOIao1DlLPv9aHSSUQPwUIGEi9BxSy9n97zXGwEThQZ89X07Q
 Mua5baNj6UzgnF5k9yz90OIccUcrdaOD0FkF+XvzdWLgWIZVECpf96LiUgqJZHKFbaR9wji0wcq
 u6hTtRgRSinsTfqhj8Qeaiqoh/Ryen3rIdsm9GvYwTrvD8u0zYKttoY9kbqahJeS9pw5gEFStO/
 ewdgRkyQ9+CdDrM+MHdIWaNRQoeMbK5C64naoIKQ++MCh25WLs+/l68Zt8kelvdy1VZYL9ZZ7oc
 WiEYPPEAfyo7rS/gKYezClCwsJJiRsyJNMwUle611qIFsKG6LTuP27e+OxtaiQZqOQQVTm7tmvk
 5dpsoL5iSlp1obU1fIQ==
X-Proofpoint-GUID: HLd1imMbh4Fb3C8OvWqnH4MwPb_z4EHW
X-Rspamd-Queue-Id: 6EC9425393D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_SEVEN(0.00)[9];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-19993-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+]
X-Rspamd-Action: no action

On 3/10/26 10:53 AM, Trond Myklebust wrote:
> On Tue, 2026-03-10 at 06:26 -0700, Christoph Hellwig wrote:
>> NAK on this whole thing.  Linux does not support NFSv4 ACLs for
>> pretty
>> good reasons.  If you want to add it you'd have to do it properly
>> (even
>> if that is a bad idea in my opinion).  But adding a weird special
>> case
>> for passthrough is a no-go.  To be honest I really don't understand
>> why
>> your (as in Hammerspae, not you personally) want to abuse the kernel
>> nfsd and nfs client for that.  If you want to pass in the protocol do
>> it in userspace without burdening the kernel with it.
>>
> 
> Like it or not, Linux knfsd _does_ pretend to support NFSv4 ACLs. It
> does so by using a (lossy!) mapping to try to convert the NFSv4 ACL
> into a POSIX style ACL.
> This is a problem when you're re-exporting NFSv4, as we need to do,
> because at best it mangles your ACL. At worst, it throws random error
> codes back at the client.
> 
> So Hammerspace does need that passthrough ACL in order to have re-
> exports work as expected.
> 
> If the upstream community is unwilling to take patches to address the
> issue, then we're quite happy to maintain the code separately. It will
> still be available to those who need it through our github site.

I recognize the need to avoid ACE mapping when re-exporting NFSv4.
This is an issue specifically for NFSD (which remaps NFSv4 ACLs to
POSIX ACLS) and NFSv4 re-export.

I will accept a clean implementation of that for merge, and I've
already pointed out where the prototype implementation can be
improved.


-- 
Chuck Lever

