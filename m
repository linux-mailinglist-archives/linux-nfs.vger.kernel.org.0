Return-Path: <linux-nfs+bounces-14766-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2651BA94CC
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 15:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5273B7905
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 13:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2332E2FF17C;
	Mon, 29 Sep 2025 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cRSfMkRq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lbov2I6r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA72D47FF
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759151789; cv=fail; b=iAIIPNp/lV3h3+Y/UXXnzMK+EIT4Mxjut6b1ue5USlv5ABUAqhrILCQLKn8KpiiQKfAlLb4f8McO5deh1lxqeqJIUyla8BuqTZ34JZsqn5wjAfGWBYwoUQ2CRszmspRwV3XAXuSE1goK6nMtvUjOAX7ZUMzuuwqpvm4O54hm83Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759151789; c=relaxed/simple;
	bh=lJSHyjBxv4zpwxNsWcUCyDWQGnzlPoczxlG3WAFwCug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZKA0JGgGz7lMji85dWDaRc+mnpYRhwrG5bIx2CxyVxkAC/TFlu+MpD4K0CJaKLodzXDkLGlJfzl504dPaw3Jv0ccYUUnc4dqR4ahrpn6QfZf2HY99P9B9B4f6s298NhAoYZT55zzKidxk97huqDd4d6UtGlnl5sDtXWXbJC7Zi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cRSfMkRq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lbov2I6r; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TCuJtR027582;
	Mon, 29 Sep 2025 13:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=th1DHKJinRAVleBSSeU+V19ssVPmpnz/tGo+UlPWMDs=; b=
	cRSfMkRqe/01HjC6wKnaipF0mgSEB1noCEHLNAZGf8I4RE1I4DxlpIfUFd4sBn8C
	5XONoZ86jnSJIPBX9cj3bZQ329pbQTimev7Ut5A5zCm537BdgYIXFXPU15Gup1h6
	07e6QslR9sCv+2/DrIva3irzINuK9yyquPZp5BgzNN7utKZQTkhPV6fHVf7+X1EV
	LSujyxiU2Hv+ggVhWEm9AWyWXB7AuBktVaWLHv4+j63QI+VCnVuwO8rfCoOQnsBO
	0pFKRXAH55wFBWm/6hDBsQXFvVWzy6awlBHuoF++pVmM9tCU6FJvNNpoOIBnAKCV
	M7hK0BP9rV7YqjORva+GJA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ftjc01ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 13:16:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58TClmNu001995;
	Mon, 29 Sep 2025 13:16:09 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6ccxn9j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 13:16:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsoJKR7KKCQZB7IAK4XzQEuQCRJDjn+7xGxhHe9kKR9sgnXbi+IW3bkOC/mJCpMYSinuyfWL/SnzCF3MROoR6Y3SOfblDujxLqhjndPzsM87kEuJ4/mEOCeWPHEXzUMHOoAGoSyTD8lw5fbXDQ1GG2tP9doSBkQUk7QOPguSJeMRYYuheIGKf/c998Z/Ra7f4SZrfC+g4r2hXxk6gEgU1HFTEA5lkgT1KuthzS+b5PECAQaJCxMTbUWy5ImLeR6SrHtDZxlcwDfLsYZC7XifMSUqJv146J+fA0we8xFDmGYy0OlX7N+cKS4ECWEyee4RWtmAHDc/zk5WEek3XhahxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=th1DHKJinRAVleBSSeU+V19ssVPmpnz/tGo+UlPWMDs=;
 b=McnXNpn7V2tMOVt/EHK+3NsI5Hwvn/dnvr33l53KJ3xTpws+5RlGNVvENildx17zS1Z+fMOOC0BfXcKOA/vhBrZvdYS9aSjNFS0wSBK8Rys8jT36fWmbM4i9i3FLIncVaNu7AzH5u5fZHAHCU5SUoHbu/VrLwHdY59abAT8frSjXmRk2np3lI9KLnU42avUDUt+qSKcU+DuBgkfmJslSdjaq611I34tnfr9lsqWs7BLHFKf6plRIBZF9QRQytGRJoqqSZ4wim+owoMD36CCcYjT5r+ZMAljUDg5T6TOWIlLqr2yPRXHP8Q6vmifnrAaK6OiM8R0eBx0HZkZ/ybmJaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=th1DHKJinRAVleBSSeU+V19ssVPmpnz/tGo+UlPWMDs=;
 b=Lbov2I6rp6uXsQfeRJMZ9RsPWDG0Kj61L/JLOENXdUbWPKR2j9VLwSQFMiCPnvNVfjmtsYx3XAMs0ju9s4LkAOsixP7k5uc3j5k1Ur3SYSrg2WCZyfHTsk1AaGU08sjfO+Qeh6slknQ4DIwAkfFFqAk3qXO/DakwV8z0pnoRCRU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8371.namprd10.prod.outlook.com (2603:10b6:208:576::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 29 Sep
 2025 13:16:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 13:16:03 +0000
Message-ID: <ec936c41-0047-4998-9e94-1998780ad1ea@oracle.com>
Date: Mon, 29 Sep 2025 09:16:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] NFSD: Define actions for the new time_deleg FATTR4
 attributes
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, rtm@csail.mit.edu
References: <20250910152936.12198-1-cel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250910152936.12198-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 861bc9c4-f2e8-436f-76bc-08ddff5a5776
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YWtIKzhHM0NuM1I0aTRIMG45c3ZHdHlSeHNYblYvOXdOZHRGeXgveUJBSW5P?=
 =?utf-8?B?SEpISzdiME5pMjUxNlNOK3dFcWNQcldXV2VsY3N3bjdpMzB6dEtyOXFoR0Rz?=
 =?utf-8?B?S0ZpZFpScnZRL2x1dWs0bWprRlRpTWg1RWFSbzNTSE05Q0l0WGR0TFplTlpO?=
 =?utf-8?B?YWZiNlp5MERObjhWZmZodmdXcnZFQ1ZQZHVkWHhhckMxcGM3OElXT1ZDcmR5?=
 =?utf-8?B?QitqVXZRbkJudVBXaTNRditYdDhCd0liN2cxeThxQTFvenBQU1oxdXJLRCtR?=
 =?utf-8?B?emFrWDlUa28rK0NsejFjQ2tPQlM5TUNGNFdoblRGM1Q3NVJHMDJZbEd1b1Rx?=
 =?utf-8?B?WllodVQvbXM4TnFBaFU1bk8vbXhPb1FiVFpHMTZKQnp0cHhoZnJlZGdjcUtp?=
 =?utf-8?B?NkJiLzBRQ2kzVkN0WXBaOTFnSjlzdXlyekxlby8zMHJxRGJhUGhuQmRsSThO?=
 =?utf-8?B?THdsak8zUE1nYi8rMDNhQzJkVWxjTEJmL3IwbCtYVzBXZEdFSlFqQlR4dnRD?=
 =?utf-8?B?d3k3V0RTUUdoQWJhMUp0L0VCdUx2VlRPZUpNK1FVR2RKYUsvMHhGOUx2Ymox?=
 =?utf-8?B?WWtvYkY1d0I3cW5xbG9MOG4reDRoMnZIb1g0dk1lWlV2cHJQUXhYNmlBT1Fh?=
 =?utf-8?B?bkZGRVJZZEhsVWtacHF4TEhKSm5lcUZHNmx2RXlrU1AwRUJIT3ZGaUE4OXdn?=
 =?utf-8?B?eGV5ZGFQa3JoVGRINUFKbWJMRmJGamVwM2NSUGlkLzhjbm45SXEwTC9MYmdQ?=
 =?utf-8?B?Mk1Cdk9zNEh2RjBqNitlbzdLVkxZazcvYlMrVldka25vNjZueDJsVU1hNmNz?=
 =?utf-8?B?eVhvWW90TW5kaXVXT2NsZ1dHNStCUGlmL0M4amhnTlBLSm03OUF3ZC8vRU9j?=
 =?utf-8?B?Vk4weWNMMlc4VnJ2bjBrRTVTNTAwRmFGVTAxQTR6NXBmcmw1MTQxbnNLNmpt?=
 =?utf-8?B?K1dCR0lxZFFxTmRYUFJybm1WclpUb0xlUmhZMC8rT21LdDhPRmh0czk1Q0R5?=
 =?utf-8?B?MGVCZlQraW5PT0RNcEtFVG1WYVc2bmE0cTdXY3lnYUpHRGxBOVZxcUsrS0tP?=
 =?utf-8?B?QW1qZnBpb2haZnlKeUh1TkhoS21YS2lXa3owR1FJbmdCY3NQUjFWdXZxOVo2?=
 =?utf-8?B?VjArSUhqQ1N4bUJ4bHNJcVpIZDJSejNsNTZEb3BTT29BNStIRHgzd3lsazFC?=
 =?utf-8?B?aDV2QXJDdlplajFHMVh2cmFtMGJLWmZtY2FScm0xNSs0aXNIK1UweW9BclMx?=
 =?utf-8?B?d0RUWWo5S0J6cVdEU0ZmcENCNklLTWdjSzlxdXVvWm93TXhxRVRscE5GUlRS?=
 =?utf-8?B?M01sbjNhcU9yTnFjOVVJYTF0NmxsaXhnV291NTd4WmFpSUhmaWYyV2tDNlJz?=
 =?utf-8?B?QlBRVFRFUFdXeVBFakc1bGpiUlpGTElvVnZSWlpzMU9ja0RZQXMzY3pnemcx?=
 =?utf-8?B?VW9OT3MvbTgvME1kYWtSWC9INE5QOVlPMlEzOVZzMmdYb0FYMnptNHhQb2No?=
 =?utf-8?B?RmgzRHNZMzdvQ0ZOcEJkM283YTRDVFA2Q1FPTmNmWDg2MWdIOXJaR2hPVW1R?=
 =?utf-8?B?Z3hZN1F0YXdvdlN0ZVFkWkd3SGZMUmsxamVVNGduc1JNamV5UGpzMXdiY3Bm?=
 =?utf-8?B?YTNML0tSOWhKaXpEMTN6NEdINlB6NVliWnkrbFpuV2dOUTB2Vlg2eTdMWTBC?=
 =?utf-8?B?MVQxN282b2tUY042MXVTNWxCTGFYeHlwZjNrMnBnRG4xdnh5NUhTK0ZlT2Vw?=
 =?utf-8?B?c3JkaTRtZmYzMVJiekdRVlJ5a3FmMjc1RW9zakZNWHhLTTQ4dkxhQThpVkE3?=
 =?utf-8?B?djg2bGZqN1VTd0V6aFJma0dZV2p0UXBmSHl6K0hPaEo0OFl1c1FuZ2pCL0lp?=
 =?utf-8?B?VWJHK2xycEFGSmRxUnBEQWl3NVFoWkpBQklDcDcwa1duUThYbXgxTTl2YzBu?=
 =?utf-8?Q?R1rQo+OGJv4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bmhYSjdLei9ZSHU5Y2dXZUNYTlFXQWVmMm1JQzVwVElmRlAyZEFjUWxyamJx?=
 =?utf-8?B?MU44MXBlZ0VPTHQvMlVMbkZYVEtxRW5rSHpZWHhMSDNMYmovSXZZWTBscy9M?=
 =?utf-8?B?ZVhBMHZIK2ltMit2REZBVTh1VzNQekg1TzZrZXRGZHFxUFhDMzhvdUw2V24w?=
 =?utf-8?B?ZURUSDdLZFppUXg4WUNYZFhNemcvRHYxYlhMdm00WjY5Uk1wWmdPREErV0s4?=
 =?utf-8?B?d0JKRGZnam1YVXFQd0VKRWhUQ1dENzBLeTFqUUNEYVZjNHJ1c09aZ0cwUURE?=
 =?utf-8?B?c1Znc2VoWTB1Q2pmZzVUdk1JUG9aQ1ZpWjQvYTR5TFBFRmJnYXJINmtGSnlB?=
 =?utf-8?B?MWQyQVA5OVF4UHlWUDBYSEMrWjZDR2FzbXhFcytSQVRSOWp6Zkw0dEp3YkNn?=
 =?utf-8?B?S0FaaWt1STFIOW1FMEpCUzFTU2JBTkdrblcyZWdVaGthcDBWcVEzVm9obEFv?=
 =?utf-8?B?T1g4blNnbUpXbjVYd2dmQWxsbTcvcXdkeGFSOGVwTitEcWI4ajl1dnBxTU8w?=
 =?utf-8?B?NEpBOVZRLzBPRDZac3dDN1g0eTN0TlVjbnNwekZORW9KVzAyV2h3VExBaks4?=
 =?utf-8?B?MWNxNXN1UVdCWUZ2OGtoZWdUVWw4bDF5NFZCWUxVdmRwcnRpb1ViUmpGR1Rz?=
 =?utf-8?B?QytyU05PWEFGdlZkWjVrb1RqMDVQRlBYVU84Z1VyTVlNam1DQ01KNUdCY2ti?=
 =?utf-8?B?cGNUdFZ2cG5xYmlYQzY0WmtnVU03czRqTzB2TmRwTmtvTFBHbzZNUE02Nmgw?=
 =?utf-8?B?OFJBMll4VGdXTC94ajg0QlVTUFpFYWQxQjArMGRZcldhL3UxM2pzQUpqQ1RQ?=
 =?utf-8?B?TWZ4di9CQXFqUWZiYk1QeVNaTk14Sm1IVTN1NTI0U3VzeVBseEhOeWNKZ2NW?=
 =?utf-8?B?QUFWNmJmWStXZGdvK0FaUG9VWXhiWEd6L2cvaTU1dndPUFlxd0xPY2ZOSlZw?=
 =?utf-8?B?SG5LeU5WbThMSlpHa054SWJEcFNEMlpxRU9VSVQ2amxVRTdqVFk1YW92a2JI?=
 =?utf-8?B?VlduSmVWb3JUNkhLK29nKzhOZ2d6UXNDNExlNVp5YTViMjdXMWQxeStnMEVE?=
 =?utf-8?B?ZU9DMDIxTmRjWGNIUFZhWGxRUTFNMHRDNldQbSthbUVwVmhWL0pYWXhpNEZi?=
 =?utf-8?B?QWUyeXI1V0k2OEp5WXJ6UWlZUFZFYys0ZXFSWE1ZamdsVVczOFV2TWl4R3Fp?=
 =?utf-8?B?ZjVSQUV5aHJLSjkvZXp4L0FLWkNtVFROK0RlOCtLL2x6TU04anN1TXI3Z0Jr?=
 =?utf-8?B?WlhlUEhQODJGcVZ4VlBBbTlmT0h3Wm1hL1RNUXd6RXlZVDYvR214TXFSVlJI?=
 =?utf-8?B?Nml3a01HRFJHb0hoQlI2cmMvV0pPUGtBRFI0a2xCd0ZxaGNCOVQ1N1BPRnc4?=
 =?utf-8?B?WlljeXp3NnFIMStkbzNMN0NsVERmL01LT09YWHVuS3dia0FEclJKWklVREto?=
 =?utf-8?B?WGttYTZwUWxUNi9qc2pzemZWbjRwS2V1V0hYakVtZWlaWDd4ZzBxUk5sd3dH?=
 =?utf-8?B?bkx0TVZNTWRXTnRVV1VTUjltRDJyczdBcVZBSUJXV3lUb2xsZXZzUGxOUU5n?=
 =?utf-8?B?d25zTnJrbXVaenJIZi81NXhJM01PQkJwUSsrdGhoMmZUYk9pU2d4aFIrVU14?=
 =?utf-8?B?MnFFTGRQcmtWTkJVRENBc095TjF4V0RhYnEyd082N05IUUpsT1hZTHhlajk4?=
 =?utf-8?B?dHZTdUVrK0lBT05LeE1lWFVjREtLdkdYcXY1a01tRGEzS1ZDdWI2elpqSmtk?=
 =?utf-8?B?YThpbUFvN0ZWU2gzN09USkJMZjEvOTI2d3oxME96WmQ3S0lHVnYxZDNQQjNP?=
 =?utf-8?B?QmJJZFJXNzR5Qjk2dlRLSlF3REVxd1RvbFMvUkFua0kwampKZUFnYS9iZWo2?=
 =?utf-8?B?eENhdTk5UWRRYkRjL3ZQZU5Kb3hqenNMbDBjNmJyL1VwU25YRGZSYy9TeTFT?=
 =?utf-8?B?aWpkRW0zMDN2ZU5kUEhHMDk0ejBxaU02eEozTGFmNXBFSFlmMXp5V24xMG9L?=
 =?utf-8?B?aWp1NktEalJROUtPbSt6Z1JMRDNhZFB6ZnoxNHQwRTZIZmJvV1VTQzRXZHk5?=
 =?utf-8?B?MFpFYTVQMVR2bm1LNXpUSStNWG1sTGNRWFdIMG5vZkZGUHJaNG5aT2IzZHdB?=
 =?utf-8?Q?3BVICUN6IJh8geBVDiRBA3wWT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9oEQNc/rc1LqBRPaTmI5bq9Ft/DPrf82eh/w6Y3wVzYqOxlX83EGZ73c3avBjpB2aci8vkyApkvjVU3NJ9QtioXuuaAJ+dKQSzcHFI0L/IPEiN3Ttue8OeZWNkjYqjhdFaKAx7WHsTdysy/r8boBNU0cfh0CdqrHeJwipxfPYC7sjYHhfrJzCySgo6y3O3lXNe+/bUIneU2OS0JUXHsi6nfRZhpa/eLT72Vp7uKoziwwnI/EwNpzKXmiUGhjRV2Qc/mZNjCadArz8GBBXo5WwL6crYDOhN0DQ2fH0tw51XVpgX9FIwESttkL2JAJpb0/IdYmNmqAMWjKcYRcIZebAjuHJ4bzYJ+3a4X7AleeA6ZR/S2s/+iPLd23YoOHwcn0RUxwJLNsgp9u8fECK3hTYoecOUJFAEsbmepoQ0PaP2EDWDMRh1OtwVwnP0GvoaRg0z/HZYCkD6rtukfr+rugeZ/ZombR2SHJHXDoO315o85WIuz/zuwyrAge3PJOCfTSYR0nMi7JP65gNi7my6V5uWhzz79hzN6poZdfqfDkNEy2omCbW15SEESSrrgaDfR557cF0X6XwnseKZ/E+yZoJdzYxaPxf7AL2C7bDzcM2D4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861bc9c4-f2e8-436f-76bc-08ddff5a5776
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:16:03.7919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOqaEhlgUNJiLfvDH2E+YUuFxo2B68cTS0FJMK2jF1Y8X33T2FDxYvR5v/YVX9P0pspciUpsvPNAxxjTJHyWZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8371
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_04,2025-09-29_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509290126
X-Authority-Analysis: v=2.4 cv=d5r4CBjE c=1 sm=1 tr=0 ts=68da869a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=_Re_vp-Tdsrqcu-lWzEA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12089
X-Proofpoint-GUID: Y32-5R6wwEwSWLPtNtgSPjRnbWFJLTo8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDEyMyBTYWx0ZWRfX+RqweYbutSKu
 /jNHltoNl/kAo1AnXdBXjyt+dIhkr6AqyTrwh6i549OORxUJEbF6LAahD1V4tLF5zc9am+3z8mY
 HNJhW97BroKw3k5LssVfatDJBplpSZ93vxN9FTTJuPJ94tBunb6b9o3GcwJw+LjABsTX3JoTQhl
 OxCxQ96Z9X5xEpLuJmFFt4QGTL3IeMrtBxpN4mPjGM4oajUt6iG2NhhwoBZpaFTKOHpVeM42LND
 vqvyCbOApoAlALK6zEJtRN+VXE2ozIBm4mATMav5dZead7lqtXQQ2LVCOBS4xN3dsIXGI4A7HYY
 drmQrRGJj+Siz8+kfxnfaY07liLNRbjro247T3j40T4ztPmAEwY+QUXBaVBwK7haTjfkt8Ut4oz
 WJzojx6yWCQR8eupPhIp+fQXJNUcdaY7CuFLY9zVsDg/A5gTHOw=
X-Proofpoint-ORIG-GUID: Y32-5R6wwEwSWLPtNtgSPjRnbWFJLTo8

On 9/10/25 8:29 AM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> NFSv4 clients won't send legitimate GETATTR requests for these new
> attributes because they are intended to be used only with CB_GETATTR.
> But NFSD has to do something besides crashing if it ever sees such
> a request. The correct thing to do is ignore them.
> 
> Reported-by: rtm@csail.mit.edu
> Closes: https://lore.kernel.org/linux-nfs/7819419cf0cb50d8130dc6b747765d2b8febc88a.camel@kernel.org/T/#t
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> Compile-tested only.
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index c0a3c6a7c8bb..97e9e9afa80a 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3560,6 +3560,8 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
>  
>  	[FATTR4_MODE_UMASK]		= nfsd4_encode_fattr4__noop,
>  	[FATTR4_XATTR_SUPPORT]		= nfsd4_encode_fattr4_xattr_support,
> +	[FATTR4_TIME_DELEG_ACCESS]	= nfsd4_encode_fattr4__noop,
> +	[FATTR4_TIME_DELEG_MODIFY]	= nfsd4_encode_fattr4__noop,
>  	[FATTR4_OPEN_ARGUMENTS]		= nfsd4_encode_fattr4_open_arguments,
>  };
>  

I think we might need more here, because this introduces a bug.
(Not one that a working client will hit, though).

nfsd4_encode_fattr4() needs to clear these two bits before processing
the bitmask. Otherwise the client will expect to see nfs4time objects in
the returned attribute list.

I'm not sure if I should remove TIME_DELEG_ACCESS and TIME_DELEG_MODIFY
from the "supported attributes" mask for forward GETATTR requests,
though; or should nfsd4_encode_fattr4() explicitly mask these two
out when it copies word 2 of the request_mask to the reply_mask?


-- 
Chuck Lever

