Return-Path: <linux-nfs+bounces-20850-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOlYM5g/4GnmdwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20850-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 03:47:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8059D409934
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 03:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B66E30177BE
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 01:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CA02288D5;
	Thu, 16 Apr 2026 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NtnbUmMw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VF6ORPHR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880D22A1D4
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776303833; cv=fail; b=d/rHsjA/YNsAEoEOqtdYqQYqn4FlvYjV2++0qoz5VpQpWuoXv/SRwxaqF7IKO1tkRnPyFNoqU3dfqUM4ph2ZbyXF/gzlarjJmIMIkgAWuvFli+SnrLwMYz8eeJQUlj1xSUMYWz9D7CkDE/hNbmNxotx1saHCte8qMR5/b2rRpI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776303833; c=relaxed/simple;
	bh=p4GvHSZLHUqOB0YpF3EbnUGpbzT/8Sm17CIksF92/WI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lo25hlqHdTeuWriBYr5n14ejLtkD3lL9Gd7vPsHtHkt3sf3XX6FWL4sv3vOe2BtHst/4OuzkhNy6n4p1xZYG0R4rLgdCAumNBstI/yjtXCKxOJWcM7rAJT22EgYhgfpB4u8mZBEqeTBNkyaXrCfERCCOn3REk/j+vZnQKuygEAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NtnbUmMw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VF6ORPHR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FJMPTY1531024;
	Thu, 16 Apr 2026 01:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5/gQG+CzQa6FEuJSFHGdGAQ3sL6oJ+oLGVYlzMXAxzo=; b=
	NtnbUmMw2mt93h1rtjj0B/pBftKNM1cWazKXzLhdXVziLPkTyrw/61kfe7dP+pKK
	58zKx7mPeL0DmY8ibr3hIJEFmTbgmRDPjAoGEgJVtXSW20+zy+yxOtfR3PKwgK4A
	L9bViD6KO4eaelnKzfD7xC2jb3MeDMdI3u4sKmeJ4sQGdRtoEz/w+LHIdMylcAAt
	uHSA1eQaTFuDf7y5fsipJKXO2BvChRWYwKjNA8td6XTiqqlKATPOjG8O4J28UAtJ
	Dn2NiJAiyO37HNr6nNTw0eCL0/SSSVpty1nk3f/X4sqNkJLqqaNQ7Y4HbHH41HsD
	xXtcP9Iobp7foNcJXKRU3Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh85qpg49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 01:43:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63G1YRWb021527;
	Thu, 16 Apr 2026 01:43:48 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013002.outbound.protection.outlook.com [40.93.196.2])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dhyk0xqp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 01:43:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXODOh++f7OVkD2ossCHzdk8a+XdRlKkz0juibXzOP1Ub6JO8QErDDzKycEe0dNtEKCPJ5GUFgsz0c2YcK/w+ZCocjOe4YOchPLmFGiwUfhZ9yb2W29AkP9z6vKbuIhNqnzZWP3GvpQXmSLmKnMPXUqLk6uS4P0f9kpjKih1HGAmiIU2ImvcpaRX6NiM1+IGLgcJbV2UGvefW952qK/nm0EcU2rFrd4ZdfTK1zv7rF6LzA37OcXFRJAKLj4pcpG0v5gXurRf3ULKpgXfY1FQR5H1YcWYbw3q+MHeJjCN2JE4eh2UPiLTH/16FqgSFh95LDGeGqND+5ZcZwwpniqH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/gQG+CzQa6FEuJSFHGdGAQ3sL6oJ+oLGVYlzMXAxzo=;
 b=H/oIYrviNNurMLVX9FVRh1KbsyZ53+dY5gfifzL/h32wCOeKjZ22LYisGmDrH5PMA0tvJZQefggtWZM/04UHZURIX45iqgVSkx5b/uRXs5e9Pfj5C5cwopkcH1Au+g95wQj2EVbQIWEpMWuIhBdXxVkww+Zd5NI2L+OKDOtHjknN0uNhcFgeifQ+5VD4lCHToMhbmJNiaNI2VdPwqcnEAEOhaCFhOWuDYS9TR2YNCdiScT0T0txAmFT3UOnye2x0bj20zEEwYqYnA9iZAhmgC22f2vZHpp8IE88Z7zZdbQqFtml0Vx083csqMjPEevo4o8z3hI1U7fm0uG6MuSbdJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/gQG+CzQa6FEuJSFHGdGAQ3sL6oJ+oLGVYlzMXAxzo=;
 b=VF6ORPHRfBAB+8sVnXCjzPH4QLvQXFgHC2n96ApDXD4MeYRFq+rH5+ansFfF913zwEARWsRoylzI50rgMPr7oWZLhpUh4sa2rCIPLAtj9M1kwGKwjU+NhYLsS5mv8jGQhGsDTx5wGYYSLN0laCnDaWQ+65ipM6olMwCR/hQzDuI=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DM4PR10MB6743.namprd10.prod.outlook.com (2603:10b6:8:10d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:43:43 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 01:43:43 +0000
Message-ID: <32195c82-24f6-4e83-9818-b3d981b4c3ce@oracle.com>
Date: Wed, 15 Apr 2026 18:43:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Don't always trust server inode size while client
 holds write delegation
To: Trond Myklebust <trondmy@kernel.org>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <20260401185322.2691848-1-dai.ngo@oracle.com>
 <42bbd9bd83e0887c469a555bc5c76ec06aee722c.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <42bbd9bd83e0887c469a555bc5c76ec06aee722c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0150.namprd02.prod.outlook.com
 (2603:10b6:5:332::17) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DM4PR10MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ade39f-e3d6-44ac-160d-08de9b5997bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ohoMWazDNF+vqupNudrya1qafVnGFcinmlHMrt7xHi0W69gQK0laDhIV9AW4z+ZeSS9V61iYk6umXjayXEuKUEsQZR6LbE43BEXAELNa5q26wqduqCSxrT1Hv9XVtzjv5xJkP35Gww/3bcSKPh9oUvk+0cMm78f0yyl0ymkOV0XiWCSGPKX1cBxMQ9BsMd5cANnH/rIZ6DZxzUQ+MDlA6w58QtEJHt4lLXqK498x2DRFTpsLLcJre/7kJbb+/yfRDRWykyMk+N9TGtZNh7Evr5krprg3zHtDsviP/83c42YGeN3H/nc7jGdoIuuP/anwGrSR6RdNMOuIp/m/OEARyoiOZTBp+3ixuCoGnDH7sIYyVxs1YzLNw6bXI/FfeRoQ+VMzQp4a53/QuJTmByCAVBP6AvXFOnXYUuv5iv4GdTVn8pWAh1hb/qdGhIUWIR97PrmgtFbvy2XUG2A8fHxcL0cP+OwaO/oZXhyMSQTrNyrXW4B2sWJIehw2lV9KcoCmdoJJc8B52KALA1A/UnTgvr+XF6039v56EsmIpUXgHJgfbfqOvO1lW+k8aZ/zh2L6ILwnuyxWFVExI0LQihctArnMGMnEHNhbAlRaUoUVgY6fMYka+VotwabZnF7QXVAyh99m0PCKyg3dm+0GHJGo2rw1Qz60ghX5c2/5B5Ft+ekAP/uPKn7nYEfIxObwvQAL3EA6Zcka7G4yrRcm5k5IDUHWQEPuxVqSLhSHYaAHROs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eCtwN2pjT00ybzRZcXpPVGlEQjgvUmcvMmkzcFJPYmlsS2ZFZnB1cmJ6dmx6?=
 =?utf-8?B?U085MVFSK2ZjN1drc3BrZ0JXdDJrdmppNEI4dWJOZDNrOVZiWTBrWWxWYmp2?=
 =?utf-8?B?SlhyWHp4Q3BkNlZSS1BWYS9pcVdUQTRMenB4ckVvWWpOaHhKdkdZM0F6c1NG?=
 =?utf-8?B?Vy84VUxGcmU1a2pQelBXSElSNUFTYm1YeUY3SGxjcWhQcEtRcDQyVWhpR1R2?=
 =?utf-8?B?bkE5ZUZxQVA3ZGZMVmZYUDhuNFkzc0VPWDkvMmdUK2xGUlJ1M0g4WHRrRDdI?=
 =?utf-8?B?MTRUQVh0T1Z2Ulh4ZlFiQUZTUE13MXQ3ZUNMdGw5ZjJ4eVl6S3hqN1V2WVZ1?=
 =?utf-8?B?ejRuRktBeTduTCtqVTAxa2QwVUM1WCt4YXZPTUZidVU2WWdQcVk0elZPYnll?=
 =?utf-8?B?U3QxZzc0ZFMvSWhaclU3WGx3dUxjTm9heEFuOGFDU2U5Q0xUMTZnVGMxS000?=
 =?utf-8?B?RHo0MEJGMGREM1lORlpiTFdDQit0NXNVbjdQVHRjeXY0R0JLYUZsNzNQTEZU?=
 =?utf-8?B?ZzNtWmI5NGtIWUxEdVVqbllHWmpSdlVSRm5vRVBmdG94djNTdGZlMWdBcUpX?=
 =?utf-8?B?Rm4xL25QZ3hFdU94cXVMV2d3VHBsVG5teDFLbmk3YVZoUjdDbzhMZzhPczhn?=
 =?utf-8?B?WnBYK3lWWGdWZWU5Wjlhci9DWWlhdmtFS3lmSWR2MnJnTnJNMlRyd3ZYZGoy?=
 =?utf-8?B?T0ZtcjFBSGNxcDloOG1iQytRNHJDV2lKdE5UU3lOdS82NVZBOXBFMm1PY0Y3?=
 =?utf-8?B?TktEU1FxamFoV0c2RkwybkhDenZOdzVYTHc3ZW5MVEllZzZQdVNMaDRJNGFv?=
 =?utf-8?B?akgyNzk1ZlU0VVNhZVFIazY1RjVVSEtNY2prWG94SC9TYUpMcVd1Wm5NZmVB?=
 =?utf-8?B?emRhcDI0N3FJWFVzUWR6UlFaaTNLQWFOZjVicXhRbTExWTVSaHZ2cEpOWlhK?=
 =?utf-8?B?NHNGeVZVdVJTWmtoYmpycmZDVGFia1ZjVmRwaGFqVjE2RDNwNGNFVWJDUUpI?=
 =?utf-8?B?aWNwc0p4dmVFQ1NuM0RWV3pIQUNaSU5Oams2ck03Y2tnc0dIdDBUd2xZODBs?=
 =?utf-8?B?dXZZakhTWlpRa0RGZDZnaGhRQlBXM3BPbnBnckpqckVIQVcwVXBoMDBoeWVG?=
 =?utf-8?B?Uk83emJ6YXFEc0lHQkt1QWlMTlVldXR1bVhJYXRWZkVKYkJiQ25lVm1DRE5r?=
 =?utf-8?B?SVA0OUhtZzZ3d2hzOE5VakxWa1duZG5WUHZyRTRLRndna3NiblFiNjJaYzRo?=
 =?utf-8?B?NGpSWmlmRWl3QWV2VE5zeHFrQ1QrQmJwUUdXMlpOdUk1K3lNVlpTMHNoazVv?=
 =?utf-8?B?WUtTK0drbXByOGQ5amQySEFwMTlQTUFUM1kvOHJQTzJ4RzVxeVl5bERsaE1V?=
 =?utf-8?B?Y2h0Wkc2bUN6TVlsUjVYN3pwcU0zcHJLYmZGckZ3U3MrK3VZT2JMb1V0djVC?=
 =?utf-8?B?M1lQeC9MN1M1cjBVMW9OUEZLZ09NZmh2WU94RGhhNlN4dXVnUlB0REV0OWJU?=
 =?utf-8?B?d1JCQ3owcnhaNVBQTGFrRXJLalhyL1VOV2ZQWHdWbDhPZUhYUUZya3NzQXox?=
 =?utf-8?B?Wi9LNnJSWjRIempuSFB2bXhjYUI4K3A0ckFvOEI0VVVOQVdGRVZuZ1lMNThN?=
 =?utf-8?B?aDJmdHdWbmJpZ0FiMS9neUFOZTBidWtsSWtKWjVTQTZMQUVhUUNzdEpteFcw?=
 =?utf-8?B?S0dQQW45T3dJNHNvdVAwWWp3OW1FTGtsNGNoL1hEM1V3bFNjT3BsaSt4ZGNu?=
 =?utf-8?B?ZElkeXE3VVhFODdpY25lMmZOeW5VLzErV29GQjRoYXY2ZGl4clFqVjAzZS9Q?=
 =?utf-8?B?cmNOS0haQWpkZzRmRGNPaC9iMUFnUDFHTG82Q0RKT2dmMFMzQTRxREJNOFBF?=
 =?utf-8?B?UnpqUzgrRklUYkFvamprQ0Z5V2RiNmlxUFZWcnM3cys0elJHeHNhc0hRcHJT?=
 =?utf-8?B?VWtJcWNHVjltaEZyYmtGelZUSmZZV3EyZlNyV2NTMnMrV2Yyem5LWGdzWmhI?=
 =?utf-8?B?bU1GL0M2OThzOXJGWit3TkJ0VDV3dHRpNXNRWTZycy9EWjVoeDE0R3Z1UTRz?=
 =?utf-8?B?b3hXTXJFL2U2ZWZyT1BYeGljSXRCNjVuYzNBNWVIOHZjVVd2TDM3NjB4MWFV?=
 =?utf-8?B?cHFVblNLaHYyaEZnRWsvUFA0WjcrQ1lmWE03ZFBaTnJVNUtlalBQeWVSSVFz?=
 =?utf-8?B?dzZieVZBcUc2ZzJjZngxblgzMGYxdFVRVURqbG1hUFJ6Rzg4SERBa2RvalFr?=
 =?utf-8?B?bXV6ZFZHakFpb1liTGMvN29vRGtaRWl6aUFuMC9XVnNXcjdWUkdIZUZCMklm?=
 =?utf-8?B?dnBzMDdhem1ZNkliam9zRTU3YlBJVmMwWWxBWi94cVJ6UjJJRnhwZz09?=
X-Exchange-RoutingPolicyChecked:
	Eh0pD+pYUdmc6cC3Eu+J6XCp1Fx/VMJ+t2qbtSNChEOWZ7n2sFeBJOUOAbu5jqk30q1t1l+iu0knt6+sWNsRoo/TVBL06BOT8dvM28peIwVLZMdBhYgxCyfgCJMb12gcQvmB/LdxovJXGESh/RYoV+caMptyyV8WegRarOWH77Z130GTR3lUR4rQeRcRVicrAdpYd+04+JCZbGpEjQpRbE0drKTtL7FdbVTV00j5FBVbDi0nIBNowOY1eSFp9ygpuX3nF3sRFu1T7tFXmV4SmB7AW2iNuWDakU3IaGT9/KDehxEZd6uEDCifzYSoLO/sjL/wr6ZYA5Ws6LQpKqBbSg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Idj1doeJk6uqasj6hNR5x1w7kKv3FJzIuCU1du0mS3IIPMWr4v3d1gR9P9R+GgkQmvlCOViQbMS0l8oN+KXjy3D4SWvaC3GcAtyyNK/BDfMe7/mIDRQZLyDwkWGV2RY9aFjGXyOtevZJ3zcQ1GeWpr6MpDd2LgYwCoOU8Mv2E/QhRroYEAdQH3GRLOD2U17by2rQ4HCHb+913OKWgjGKH14NRhkRodzZc0/nHpERIrH1nCio3lIlkmMnMw2lpjdNGFB+eIGksA85Cbn3zMvUU59iqUSjIWaW+3XYGt4MVZNpmLfS2rPZ/bgi2UhIct639VKx2TzRTj498wZv1TIV2gWFNyntmKf6flIge3sc/rhHqowSE9ZGSvChvxnmwvo+pjQCNnXQdaFEQsOt2CuE1ObqtmP3kvwZ/y4oKdvmnFI7/2FDl9Bgr0+fh+kkiVs/IR5uAu3QvS+Y1z0pxJk66AVr8bo7TsTrlBAebVR5kRKR1lxw/sLObF9cgRJFbvYHwKv7BHoA7zBw+IJBE6z/zYBWkyl5eJiSC7VNelppBNIeQUYX7U3msYKt8KiOZk5GaqZ+j8PS3sRgr0BCZvqG96QhujldCyL94A7Z3kbvIpE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ade39f-e3d6-44ac-160d-08de9b5997bb
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 01:43:43.5133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTY4dVrJk85fsT9E+8krp+u53wXuYhvEBR0eHjOVYDTnjfqssXj5b43tjRZU2Ar+dbZw3hxpP/o00q3k2XOeCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6743
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604070000 definitions=main-2604160012
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDAxNCBTYWx0ZWRfX1/Hv04DLYGML
 KqyFNqAeuHw9SOr05zxGghMwq1J9d/+mkpIk5bUfJv8tAGeyTAUtMkarikXwy3PSWu+5S6hpq6Q
 TAHh/QqdC7Zzg3dYVuAIsLNqbddefEyIcQqvRcJOy7sCIdyiDkjXaKnwE5vbMlxafgP6jSRcRi8
 5AKAWT5HZUZ9+TXhwBZgOQYt5pCaPTIEpjRHRk51vcN3rqfB68iVIBth3EeVcQRCIygihZ1KQjT
 08oqxn9IXbklDm4Pz1N+ygqW9pOugVQwmburz7cliaVCr/QJOPBXd+ADpz55LExDGCU18dmYNXR
 RrWeE6uUErXuWG8SVIjRVvOhcaBQvBRcNNkksLy1cnMQjWrUOj7qMpmYTIt03a+ijXkzr1e1uqO
 8BjsOMODrMC6jOBogCBwnzZu+0Vnofmv4povH10Z5ROOPxBuYdAuDfjFwYbpT+iT9Z2JjExUp7F
 NW6zX6RHU15MnBERp3w==
X-Authority-Analysis: v=2.4 cv=Lo6iDHdc c=1 sm=1 tr=0 ts=69e03ed5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8
 a=V-u9EfeGS_Nqy5RQpAoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: szkv4ExxnQHqQeysN6cuFXoMGO1dvBBL
X-Proofpoint-ORIG-GUID: szkv4ExxnQHqQeysN6cuFXoMGO1dvBBL
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	TAGGED_FROM(0.00)[bounces-20850-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_COUNT_SEVEN(0.00)[9];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 8059D409934
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Trond,

Thank you for your feedback.

On 4/13/26 3:19 PM, Trond Myklebust wrote:
> Hi Dai,
>
> On Wed, 2026-04-01 at 11:52 -0700, Dai Ngo wrote:
>> With a write delegation, the server permits the client to buffer
>> writes
>> and associated metadata updates (including file size changes) locally
>> and
>> defer propagating them to the server. As a result, the server-
>> reported
>> GETATTR size may legitimately lag behind the client’s cached size for
>> the
>> duration of the delegation, so it must not be treated as
>> authoritative.
>>
>> This patch modifies nfs_wcc_update_inode to update the cached inode
>> size
>> only when the client does not hold a write delegation or the
>> cache_validity
>> of the nfs_inode has the NFS_INO_INVALID_SIZE bit set.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfs/inode.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
>> index 4786343eeee0..21161ebbd953 100644
>> --- a/fs/nfs/inode.c
>> +++ b/fs/nfs/inode.c
>> @@ -1649,8 +1649,11 @@ static void nfs_wcc_update_inode(struct inode
>> *inode, struct nfs_fattr *fattr)
>>   			&& (fattr->valid & NFS_ATTR_FATTR_SIZE)
>>   			&& i_size_read(inode) ==
>> nfs_size_to_loff_t(fattr->pre_size)
>>   			&& !nfs_have_writebacks(inode)) {
>> -		trace_nfs_size_wcc(inode, fattr->size);
>> -		i_size_write(inode, nfs_size_to_loff_t(fattr-
>>> size));
>> +		if ((!nfs_have_write_delegation(inode)) ||
>> +			(NFS_I(inode)->cache_validity &
>> NFS_INO_INVALID_SIZE)) {
>> +			trace_nfs_size_wcc(inode, fattr->size);
>> +			i_size_write(inode,
>> nfs_size_to_loff_t(fattr->size));
>> +		}
>>   	}
>>   }
>>   
> Under what circumstances are you seeing this making a difference?

I see file corruption when running the git test with v4.2 and pNFS
with SCSI layout:

# GIT_TEST_EXT_CHAIN_LINT=0 && export GIT_TEST_EXT_CHAIN_LINT && time make -j100
rm -f -r 'test-results'
diff --git a/chainlinttmp/expect b/chainlinttmp/actual
index 178e6e4..8370f45 100644
Binary files a/chainlinttmp/expect and b/chainlinttmp/actual differ
make: *** [Makefile:83: check-chainlint] Error 1
                                                  
real    0m10.935s
user    0m10.977s
sys     0m10.425s
#

> Please see the call to nfs_writeback_check_extend() in
> nfs_writeback_update_inode() which is supposed to prevent the issue
> you're talking about.

in nfs_writeback_update_inode(), if the inode has delegated mtime
then nfs_writeback_check_extend is not called.

This is the sequence that leads to the file corruption:

. thread 1 writes 2 bytes to offset 4094 of a file.
. inode size grows to 4096.

. thread1  writes 32 bytes to offset 4096 of the same file.
. inode size grows to 4128.

. thread2 calls nfs_getattr on the same file.
. nfs_getattr checks if it needs up-to-date ctime/mtime/change.
   If client has nfs_have_delegated_mtime it calls filemap_fdatawrite
   to flush dirty page-cache data to the server asynchronously.

   nfs_writepages breaks dirty pages into 2 folios, one for each page.

. thread2 calls bl_write_pagelist to write dirty page 0 to the DS.

. pNFS FLUSH/WRITE of page 0 to DS done.
   kworker updates pnfs_layout_hdr.plh_lwb to 4096.

. thread2 calls bl_write_pagelist to write dirty page 1 to the DS.

. thread2 then sends LAYOUTCOMMIT/GETATTR and uses pnfs_layout_hdr.plh_lwb
   (4096) to set lastbytewritten which is used by the server to update
   the remote inode size which is then returned in the GETATTR reply.
                                 
. pNFS FLUSH/WRITE of page 1 to DS done.
   kworker updates pnfs_layout_hdr.plh_lwb to 4128.

. thread2 calls nfs_wcc_update_inode to update inode size to 4096 as
   returned by the GETATTR while the local inode size is 4128.

. thread2 then writes 77 bytes to offset 4128. Since the inode size is
   now 4096 nfs_truncate_last_folio is called to zero out the 1st 32
   bytes of the page. This causes the file to be corrupted.

-Dai

>

