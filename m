Return-Path: <linux-nfs+bounces-11648-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C872AB2070
	for <lists+linux-nfs@lfdr.de>; Sat, 10 May 2025 02:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E45D3A6E5D
	for <lists+linux-nfs@lfdr.de>; Sat, 10 May 2025 00:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D3263CB;
	Sat, 10 May 2025 00:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="namCQdqf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G83Ych3j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CEA335C7
	for <linux-nfs@vger.kernel.org>; Sat, 10 May 2025 00:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746835872; cv=fail; b=QiWXVnTneH6gsrlvjCnVEHj8i22DkBBRyiPKik45CTsT8Wkc5iSx5MQ1NrENonJd7KxNFaNe9wwB4MGTgUTks8L+OKqH/OB3ifgLZYBMTdAVQJn0R6THg9yYnjuuYFXv7QVGfbtqdVcRq2X7DSp/30lX45ozGqavVAX4pvXDymc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746835872; c=relaxed/simple;
	bh=d2wpOyxUUAuLqciuiwywjjxFSWsN2OyNdPlFJ6S03jk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=be8WaDdvFGGrFXv7zaC1s1LvI1wYNbz8g9s+XyvUIH3gbiYEeHbyJI7O0B2uLx8B1KJ8TaIFVcOthLgrtzFePRepiYscJ7triHwzDJXL81phydPsgi04X0s4oH8VaamUZhSHH10CTTaxkCpbYtLq61gxNJ+Ea1Fx1tGygnAVx6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=namCQdqf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G83Ych3j; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549LY23a012080;
	Sat, 10 May 2025 00:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=XWCcIVHnmB5y4x8WKRw13hBdFdccX/ZVD5ROJKnj57Q=; b=
	namCQdqfvsVsAqWF9AwxJxCTx9F1OaJO0MEudrkmEqrHcYeXlFTu/1noNs/vrgTg
	GHsUzc+tn0riIogQEQm2Zeih74Q6CI8bFe0Cfvyh7ulmC6KACFJxK7QJKDPfQ8sx
	F5cUCKd6t6Zo1PYLlEEDFVmQrO6oDtgowYBwndC1GCt+afeGmsqUyeErdzXhqhEy
	ieQHXD0TtP8T4tSRA1OYvfty96yaMDSwfvoRzeCy1l8ao9n2TstAjWltUGxHkrHt
	mNWQux2nmJRBGZlmm5SNXx5E6/tlQISJNTsHkECaRGokspCQ+gxHttl5DJGmPtpw
	vdKcU0b1S2IkAQEXJoQ5sw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46hrcr89nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 May 2025 00:10:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 549N7Xth018219;
	Sat, 10 May 2025 00:10:53 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010003.outbound.protection.outlook.com [40.93.11.3])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kdav7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 May 2025 00:10:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vB10ZP/LemxP9BgI6rz5hmeJm56mc7owPvYWer2NzxebpYjeNf89xKF2Sfagce5UI8Tmgkq/kbwKL1/UU8mls8vIRZ6XL86puwP1K2vjXXIYqB/ci5fHilQbEszNQVNPisT08vbBLr/AxdSeKCzt6Neacpp0/rrdHaorVRfNgLih55mUxPnmwol8AI056FUuKkDCigFNcIaNgZ8JzwRyvF5fi825gCqT+Qj59bCIM9NL+LQpGRdq2Oasxe4kTbO3HBhJhePGduNOz1C+Ey/3OWFThJfLXucPDFI8Q8Ch8d1FC4GJVnE5//qGNXsC01TulOQ0Bok3xcw2joSU380l2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWCcIVHnmB5y4x8WKRw13hBdFdccX/ZVD5ROJKnj57Q=;
 b=qtp9dJL/Cp9PeAyTauda3rZMfk3MRLftMKsP+hHuGFlGSW9QZ7tckBLo50cDKc0ekb7mv5UNVLJu6sMAz+JiZ3tnPpjODS/seuxve6GWZaNKv+AUZ4UMM9Oz0nnD9C1s1n8YLEqipAzi0uMiYR+c5N86AiRnNZhOzE1pfYf9JMqk6mJ28Mo8dwOah5HNYJfTnehXBINkFyrbC1uU0BZZr1aLcen52GMSP7mPwjbtISqYEc6ME+Rn4miaSUaZs3gEk0OU1+iLEsxa5Mq5mRnUDZ9XkW7Le9TNPR4TUxtmdKrkblhqt319EuKryEQApZczz9upwl6RMvok6HaYCHafOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWCcIVHnmB5y4x8WKRw13hBdFdccX/ZVD5ROJKnj57Q=;
 b=G83Ych3j9zENQbxb1IKZwAX1peRQGk8Dumyzuas1GvUoCDC0Z9X9r7zbcurOEqyTIWbx2KEjD7OjfDV0btwsAl+JhLrdnggdTU4MMripiPQ3Py53v5xdtzw/s1mTaqATZL7DjcZsT8OjQA772Krxs8XGkMgisUO1aHLcMN5bvuk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7179.namprd10.prod.outlook.com (2603:10b6:8:ef::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Sat, 10 May
 2025 00:10:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Sat, 10 May 2025
 00:10:47 +0000
Message-ID: <89da1d14-e66f-402a-a0ca-2434476e4c7f@oracle.com>
Date: Fri, 9 May 2025 20:10:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 1/1] NFSD: Offer write delegation for OPEN with
 OPEN4_SHARE_ACCESS_WRITE
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        neilb@suse.de, okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
References: <1741289493-15305-1-git-send-email-dai.ngo@oracle.com>
 <1741289493-15305-2-git-send-email-dai.ngo@oracle.com>
 <ac9d076fb33f7ad5d536ac593a2eb6afd09015b0.camel@kernel.org>
 <0314dd65-f7ed-47be-b39e-813e6b334ec9@oracle.com>
Content-Language: en-US
In-Reply-To: <0314dd65-f7ed-47be-b39e-813e6b334ec9@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:610:54::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d060cda-92b1-437d-6ffc-08dd8f571d37
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RlVreURNTklvZ09kQXBZMXlYSVkycStCVTl6bHp1UWJIeEVTbzZlUjh5TU5E?=
 =?utf-8?B?UERZVnhtQW5EUFBTdGNkOVdiR2xrSmcvajVYOHRHMndwbGh3UzJubm5ZWWtD?=
 =?utf-8?B?VkpxL3dId2xvSlJUYThmMnRzYi93aTVGa1ZJb0RRaExpU1VKSWFlWHoyaDlW?=
 =?utf-8?B?dXVUTWJaNVVRWTIrU2ZHY2RKaCt4WElSWjZvNElXaXU5MTNtTDI3V0NvbG50?=
 =?utf-8?B?YWswWGMvV3RWMUFEQSszamJLN3NYMEdQM2xjNEtUM1ZXcVQzc1ozRTI3b29Z?=
 =?utf-8?B?SElucXZwSjFvcmpVUTdhbnBQVFdtRlp0alo2TnF6VDBsaUhpa3I3OUpCZzFz?=
 =?utf-8?B?dEhoeWpTNGNGSWNMbzZwc0FWdWRzWExUbEFVeWxTWDhVcHZ4M2xwcXM5a0Jy?=
 =?utf-8?B?RUtrM0ZRSTIwQkxBSi9pWW8xTWZCOW9WUEFTTG8wNTZVOElJVzJIc3ZWUkdC?=
 =?utf-8?B?UWMwZ1phdmxHOFlobktuNW5VakczWG5BWDR5U0ZHam9pdndmQkhQRjBkbWt2?=
 =?utf-8?B?L1JWY09RUHd4aGRvaG5PaFkreGlkRi84UTNCRm5KSisvMGhLeUJZM2VDT215?=
 =?utf-8?B?OHJ3VW1lMjlVaDdvUUdHV0pOR1dxalpOUm5XSFlYQ2k3NThvVStZUTZtdk8r?=
 =?utf-8?B?WTlOUWhrNWw1NDBYQzFYTys3dmV1dElTbExtMnRYMDUrTHdmT3k4SExOREw2?=
 =?utf-8?B?dGJMV3JCbkhPcW9JL0RlbitqYmRNVDhVYVhPWE1yZ1ZwcTBoMjRON1hGaXAw?=
 =?utf-8?B?QlBITjlXSGQ0dGF5eFpDVG1XdlR3SXZmRmJIcDZKdmxaTk5wQUZZNkdOdU8x?=
 =?utf-8?B?c2tOald4VENUS0tLUUNIbm05L3Z0UnpBOGNGdkVwN0Q3K2V5SkdkZDd0VmlO?=
 =?utf-8?B?WTFSd3g2d0l5emkvWlVKQUczdk05aG5Eci9XWEVDZVFpQTBrTE1nM09sNTBs?=
 =?utf-8?B?OWlzSEx2WUlnay9wZ25ZbncyWUFCNmFTNWVvN2dCeTVLdmVxd1dBMUJ6Q3hQ?=
 =?utf-8?B?ZFRJV2FXVkQ5a21mWENwZ1Q0YlZ5QU84SEVjQVJqR0ZSVUxuYWxLa1dxNTgz?=
 =?utf-8?B?UVJkaUplZnpxNlZkS0JWTm9UdTFJSk5iNzdwNjRlMFQraVBwN3FWTjFjVXQ3?=
 =?utf-8?B?Q0pFN0pYT2V1ZEdQRFRyb3kxUEp1M2NFLzh3dkRKdWNIUmlkd1haV1E4b1NQ?=
 =?utf-8?B?cWVCbWd0eHNFMEZ2TjZVaFE4NmZ0L0hBY0ZmYkY4WHBSSUt5TDBxK1R3Wlkz?=
 =?utf-8?B?Ny9FajJKbjIyZ0pYQVBOQ2hwRm96dUU0aktrbUpiZ0pEU09lM3QwcDJzOTV4?=
 =?utf-8?B?MHBoU0QzUy9FVTBaN1V5TFFlUXpaTzdvRmltZWYxY2JEVVZROU5OZHdETEQ1?=
 =?utf-8?B?MGMrdStKbmlXaDJRR3F3NzZzMnRGVHZsNDZSc2JKakorNzlwbGFnZmgrakFX?=
 =?utf-8?B?Y1p4R2h3eTZ4Z1hJK1o0ZXRrUEpmakdYVWs0aUMyMmR2OG9UU1lmbTlBRVRC?=
 =?utf-8?B?dERMUFIzOThxYjlkcys5STBBV3MrUjNySVdrck5STUxxVC9oZmsxUmRJamRB?=
 =?utf-8?B?NzF3Vk1PbFoxT21JVExJVTRTVkMzU2FWQndiVTJnd21QU1Z3V3cyMGJUcUxD?=
 =?utf-8?B?bGRNZzZZelZaU1QzdThaWThIQkJROGtLSGVLWkV0SjJrUEJnYTFGZEpCRDJ5?=
 =?utf-8?B?OHFabXBlbzMwTXpLZnlJK2tWdCsxZkVKenBNVyt1VFJ0K3piR0VWZ1UxU2lx?=
 =?utf-8?B?VzZNcFo2QXpTamZuaGFQZ2g5TzZ5NStNSkZubHhTQ0Z2UHRLQVkyWnFnR3I2?=
 =?utf-8?B?QlpPS1YrKzZ6cTJ0aWhkcEplb0pab2RqaDJ5dFplRlZkNGN3Q0d6bXgwSllX?=
 =?utf-8?B?SEd2dHR3d24zbkdoeGZFSFhVOTZkWE1YWlYyeVR6d0NvdXlaNWp5RDFNdmZw?=
 =?utf-8?Q?y3tVhmG3w8c=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VGp3TXpsT3NLYjVXWDdsZVZZK1dDWmc1OFlySzdZSHFTKzVHSmNGcUpLWDhF?=
 =?utf-8?B?NlEyQk1PSVY0TFM2YTJYcGtidlBuYkE4dzhoUkVPYlI1eFVSZ014eG5Nc3J0?=
 =?utf-8?B?MGtkcG93S0pjSlF0bVBhWVZsUzArUFl6OW56NGd2UHFxaXN2MFFmaGlKQVc1?=
 =?utf-8?B?WHBWQ1hwai9uakwySURiK2VVT1BvOG1wcjB4M0g1KzZSakJlZEJJOEFJREIy?=
 =?utf-8?B?YmdEQXRvTTNLOHhYYmczU3UzSkEvMDFiTVpGTDhXazVZL1NPbGJkU0VNTXBN?=
 =?utf-8?B?K2lTMnBkSjBUaVNUeC8xbWZFeFRzK3BSbk9hV3JpT3ZXUUFCeE85UXhjN3hI?=
 =?utf-8?B?eTVVNnJRVlpZRkNSQzVwUFBYNXl3TzBJT2ExekpWTkUwcUFEMyt6NHBESkQr?=
 =?utf-8?B?aGw1TTdaQUJPb29ZT2dvQWxxQ2VzKzkyN3NhVWYvYkdNdVF6bzgxanhjbk9s?=
 =?utf-8?B?OXJXWWlJS2ZEaFJ3NjY4YS9ZdGNaZ3J2UjZFdnZnclN3ay8rblNSeXd3TElY?=
 =?utf-8?B?SnZhcW1Ub20vUTl4NDFURXhGS0ZCRms5TUN6bUxKM2d5RURrOGVmZ2d1T2g3?=
 =?utf-8?B?RkNHYms5ZXNSbFlOdXNmTEJlOElPY0pmVTE1VG5yMEtvQ0ZNY2gwWFVIRm1m?=
 =?utf-8?B?VWtFWU1JMWFJbVNBRVB1VzVFU2xVd0twS0tYOFlkK3hUQmIvdzF1azZVaHNZ?=
 =?utf-8?B?Rkt1WmRrbkxSeUVOc1pXZWQvMmhiaWhKdFcyRUMxY3JSOTg5bVAxaFRkajJE?=
 =?utf-8?B?WDdUZVppMGxhbTZNNmdrVzQ2OFVHWllLdWdJY0dRS3JSZWx0cjFkZ0pKSEtP?=
 =?utf-8?B?L1Z5ZjR1UmVySmxzWDdHL3hlQytMcFViQU1FU0dlQURITCtjV3lkRVBRZUNZ?=
 =?utf-8?B?TEdUQk5WQWc4ZFE5NU4vcjJyazB6V0ErOXZaOXBDNm82dUR1MXJkaE5zVERi?=
 =?utf-8?B?Y0p5Y1VPMi9vUldQS1J0cnpkV2lvVzNoT1RlVFEzeVdRTG14cVZXRG9kVVdw?=
 =?utf-8?B?aU9jajNQUTVFbk0ycGRFL1d6QW5LdENKa1FjUU5VdHB3ZTVOL05BSUNHa1cr?=
 =?utf-8?B?UWN1aVUwMTA1OXp2ZWdhdWlGTkpsMWxXdngzajZkUi83TFIwV0xwWDBUYm5X?=
 =?utf-8?B?aUk1UUJnYzNSVExjTHlFTTBvMXBzZjBRcWZWK1M3b1UyTU44a0NtRHpIM2ZY?=
 =?utf-8?B?Q3M0M2trbEVpOU4wU3JXVXBUOGtqN1hFQVJxTjBJOFNCZVd3Z3JmMVdGNEhN?=
 =?utf-8?B?MVBnV2lZUWtRTnJMdk9Iajd0SHVKWFo3QlB0S2tIb0VLWDZ1T0FROUlkVDFL?=
 =?utf-8?B?QjNGM3ZtdmcwTW1Ta1BUSTNPY1pvQWNzMnlhd3VBaTBCUG9DUUtqNmlkWm0r?=
 =?utf-8?B?eDg0a0hodTZXaXVBTEluUTMzOGdBQ0hWZ2haL0srT1NhUEdrU1pmRXZkb1Br?=
 =?utf-8?B?UFBSeGNWQ3RXK2hNWjZ3eVlpYjZBNy9hb3hnUG81S2x1WVoyZThaV0ovV1lE?=
 =?utf-8?B?M0huSGNETEMxdDlaTmtFbUsySy9ZbS9iWW8rUVIrN0xDSmpETmV6aGxrd3RK?=
 =?utf-8?B?a01UM0FuZlhBdjhTdys3YTBjMHIyb0hRcWtSbVlabzNKUHRTd3JVRFlzaDls?=
 =?utf-8?B?WmQyK0hMRHhxV0d3Q0JueVhycDFjdWlDVlEzbHJhS1dxYllGUVB1ZlNCMnJF?=
 =?utf-8?B?c1ZZWjFzOXUzZVozeEJoVlF1NHovUEpCSFNaRzdHRk14NEVyNHVkWjFZZ2xQ?=
 =?utf-8?B?SXZaUEhKNHhVYjVlTWhJMmIwZnRPL2o2NkswbHZjSEpoenRFditGQlJJZC8w?=
 =?utf-8?B?akZxbnlwQWs4TGdmb01LNFhydVZlRzFTODRRMzdoSllLQnhtMUFSSGRpajJo?=
 =?utf-8?B?dWgyN0lZT0ZTdTBkelpweS8yUjBwbFo5bzJSaDZRb2F4RXo3Vk5EWUx5WXY1?=
 =?utf-8?B?Q0N4bUN2MFpsNmpRUmFIenZoazNDS09BTUkyenFWbDhQN0NXdEljbkJycEJj?=
 =?utf-8?B?ZTNuMnNPajE5VEk0NUhhb1FGTUY0d29xR2RkY1RibW9mK1VSRHliUnc2RzVQ?=
 =?utf-8?B?c2JCTmJib0JZRVVGcmEwZkIrWXBSaU5MaUR2OVlDSmpYOHoyVTFXaFlwckph?=
 =?utf-8?Q?5lIFBEmji1TVlIzdOfPdB1K+W?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zX4yK5nYUCDpYgEgD78z7izpfjUsc9lKgPO0rb8DsLMDffHkhRqaFcOQOPa061Kj3d/EqXtxM6sH/SGVN4p17t064xwG1Fo06v0g6iCTzsnZzoxkoHJRbQbqr43vHHv7ngyYLssCKGjwTyvQ7DylPmoqsdAPWAOTK+IWJyCi4BUz45HtXFYx8Yzce57q6XHP/ygW8jqlI6P+rf9JjF1ylqO6F+h2xNxmypzUFk06RcVB0T7LbjzR8yKlLYdXVqilVnfXwzOCPzRenFJWZnXgNhINkweYxDvkhvD22gfczW98KmMX3J1O32L3zx6OaPb/APczqiB0Erv6741Y/XLfUaE49/20rBgqUpvhYdnbS8IR8BtfvOk4+Ur4MTmYwWfHAHAu++Jq/r/5PLGV3kvBf61/gsK1OeQuGSuRpxKjqyzoBCXgDXIUELBBegcxa5seEOcV7RZHxLX4EVN0OU92yaf7etyv3jqyDWK8YDKz+AWEZqcxGgLMiVtA8q62ITyvpcwBO2D5A3vsUol7Fsmy7Wkzbvgox9/FanwPo7wzf4J6bqjbMAeINddHPhBaeddsEaAJ9Cc/RO+7ey+IZjfYwuq6VzTLwtQj6iJWLICYnow=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d060cda-92b1-437d-6ffc-08dd8f571d37
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2025 00:10:47.4442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtXiM4+iqF+0Le4kaLZGrNtRGLyGEm7fwIukMmfinvpuEc47HnI0IP1i/haOOuzed904d00jkv0ZlKJgLwEc0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_09,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505100000
X-Authority-Analysis: v=2.4 cv=Y9P4sgeN c=1 sm=1 tr=0 ts=681e998e cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=z7eetdy-DeGWTFkhgfIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xAnzcpgPJ3RvaqHZdM-CveHZsyWBZkXi
X-Proofpoint-ORIG-GUID: xAnzcpgPJ3RvaqHZdM-CveHZsyWBZkXi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDI0MyBTYWx0ZWRfXzhqodFLgSyys aK7gZffAMcOW/bxcUTYlkqmxxUsxfhVSAoopzRNB+KZPTy1oAitBT6bGKVvYS2tvWvj0mqKCtTJ gVxoaZlmxj8evArLNxUsv1nOaXQP7b5AEzIERUu8xsUioZBWXwhXemQhKOxh8bx7iqTIFuOkkZa
 b7nBwZC5gXvAl7bTe99nBLpKAWhFQ2hf4lBj4/WLg7/jEjoL2N/mRASYdZlGP8J7MDF7gENf2Z3 I3c3xg2MQMmh4M5xn7HQhPW5d9VKN+x3G+L5GMtRJ9w1LGJ4Id7Oz2wOVTDRpSoaw2IdjbHGfMo txiicDv4MWVaFvDBkDB1LnjhlqSUTg1om2pvhg1b0Wu2JP2cHRo6fqZV+dcXmM9gMQZ4qRwPC87
 e46bLsXYs644kilJwlUl7wNhpcTq3xO0z54MYYin7/zn+aNjxPSyhkNRCeWUB8CFoZ2ROyBN

On 5/9/25 5:48 PM, Chuck Lever wrote:
> On 5/9/25 3:32 PM, Jeff Layton wrote:
>> On Thu, 2025-03-06 at 11:31 -0800, Dai Ngo wrote:
>>> RFC8881, section 9.1.2 says:
>>>
>>>   "In the case of READ, the server may perform the corresponding
>>>    check on the access mode, or it may choose to allow READ for
>>>    OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
>>>    implementation may unavoidably do reads (e.g., due to buffer cache
>>>    constraints)."
>>>
>>> and in section 10.4.1:
>>>    "Similarly, when closing a file opened for OPEN4_SHARE_ACCESS_WRITE/
>>>    OPEN4_SHARE_ACCESS_BOTH and if an OPEN_DELEGATE_WRITE delegation
>>>    is in effect"
>>>
>>> This patch allow READ using write delegation stateid granted on OPENs
>>> with OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
>>> implementation may unavoidably do (e.g., due to buffer cache
>>> constraints).
>>>
>>> For write delegation granted for OPEN with OPEN4_SHARE_ACCESS_WRITE
>>> a new nfsd_file and a struct file are allocated to use for reads.
>>> The nfsd_file is freed when the file is closed by release_all_access.
>>>
>>> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>  fs/nfsd/nfs4state.c | 75 ++++++++++++++++++++++++++++-----------------
>>>  1 file changed, 47 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 0f97f2c62b3a..295415fda985 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -633,18 +633,6 @@ find_readable_file(struct nfs4_file *f)
>>>  	return ret;
>>>  }
>>>  
>>> -static struct nfsd_file *
>>> -find_rw_file(struct nfs4_file *f)
>>> -{
>>> -	struct nfsd_file *ret;
>>> -
>>> -	spin_lock(&f->fi_lock);
>>> -	ret = nfsd_file_get(f->fi_fds[O_RDWR]);
>>> -	spin_unlock(&f->fi_lock);
>>> -
>>> -	return ret;
>>> -}
>>> -
>>>  struct nfsd_file *
>>>  find_any_file(struct nfs4_file *f)
>>>  {
>>> @@ -5987,14 +5975,19 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>  	 *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
>>>  	 *   on its own, all opens."
>>>  	 *
>>> -	 * Furthermore the client can use a write delegation for most READ
>>> -	 * operations as well, so we require a O_RDWR file here.
>>> +	 * Furthermore, section 9.1.2 says:
>>> +	 *
>>> +	 *  "In the case of READ, the server may perform the corresponding
>>> +	 *  check on the access mode, or it may choose to allow READ for
>>> +	 *  OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
>>> +	 *  implementation may unavoidably do reads (e.g., due to buffer
>>> +	 *  cache constraints)."
>>>  	 *
>>> -	 * Offer a write delegation in the case of a BOTH open, and ensure
>>> -	 * we get the O_RDWR descriptor.
>>> +	 *  We choose to offer a write delegation for OPEN with the
>>> +	 *  OPEN4_SHARE_ACCESS_WRITE access mode to accommodate such clients.
>>>  	 */
>>> -	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
>>> -		nf = find_rw_file(fp);
>>> +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>> +		nf = find_writeable_file(fp);
>>>  		dl_type = deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG : OPEN_DELEGATE_WRITE;
>>>  	}
>>>  
>>> @@ -6116,7 +6109,7 @@ static bool
>>>  nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>>  		     struct kstat *stat)
>>>  {
>>> -	struct nfsd_file *nf = find_rw_file(dp->dl_stid.sc_file);
>>> +	struct nfsd_file *nf = find_writeable_file(dp->dl_stid.sc_file);
>>>  	struct path path;
>>>  	int rc;
>>>  
>>> @@ -6134,6 +6127,33 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>>  	return rc == 0;
>>>  }
>>>  
>>> +/*
>>> + * Add NFS4_SHARE_ACCESS_READ to the write delegation granted on OPEN
>>> + * with NFS4_SHARE_ACCESS_WRITE by allocating separate nfsd_file and
>>> + * struct file to be used for read with delegation stateid.
>>> + *
>>> + */
>>> +static bool
>>> +nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct nfsd4_open *open,
>>> +			      struct svc_fh *fh, struct nfs4_ol_stateid *stp)
>>> +{
>>> +	struct nfs4_file *fp;
>>> +	struct nfsd_file *nf = NULL;
>>> +
>>> +	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
>>> +			NFS4_SHARE_ACCESS_WRITE) {
>>> +		if (nfsd_file_acquire_opened(rqstp, fh, NFSD_MAY_READ, NULL, &nf))
>>> +			return (false);
>>> +		fp = stp->st_stid.sc_file;
>>> +		spin_lock(&fp->fi_lock);
>>> +		__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
>>> +		fp = stp->st_stid.sc_file;
>>> +		fp->fi_fds[O_RDONLY] = nf;
>>> +		spin_unlock(&fp->fi_lock);
>>> +	}
>>> +	return true;
>>> +}
>>> +
>>>  /*
>>>   * The Linux NFS server does not offer write delegations to NFSv4.0
>>>   * clients in order to avoid conflicts between write delegations and
>>> @@ -6159,8 +6179,9 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>>   * open or lock state.
>>>   */
>>>  static void
>>> -nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>> -		     struct svc_fh *currentfh)
>>> +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
>>> +		     struct nfs4_ol_stateid *stp, struct svc_fh *currentfh,
>>> +		     struct svc_fh *fh)
>>>  {
>>>  	bool deleg_ts = open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
>>>  	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
>>> @@ -6205,7 +6226,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>  	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
>>>  
>>>  	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>> -		if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
>>> +		if (!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp) ||
>>> +				!nfs4_delegation_stat(dp, currentfh, &stat)) {
>>>  			nfs4_put_stid(&dp->dl_stid);
>>>  			destroy_delegation(dp);
>>>  			goto out_no_deleg;
>>> @@ -6361,7 +6383,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>>  	* Attempt to hand out a delegation. No error return, because the
>>>  	* OPEN succeeds even if we fail.
>>>  	*/
>>> -	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
>>> +	nfs4_open_delegation(rqstp, open, stp,
>>> +		&resp->cstate.current_fh, current_fh);
>>>  
>>>  	/*
>>>  	 * If there is an existing open stateid, it must be updated and
>>> @@ -7063,7 +7086,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>>>  		return_revoked = true;
>>>  	if (typemask & SC_TYPE_DELEG)
>>>  		/* Always allow REVOKED for DELEG so we can
>>> -		 * retturn the appropriate error.
>>> +		 * return the appropriate error.
>>>  		 */
>>>  		statusmask |= SC_STATUS_REVOKED;
>>>  
>>> @@ -7106,10 +7129,6 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
>>>  
>>>  	switch (s->sc_type) {
>>>  	case SC_TYPE_DELEG:
>>> -		spin_lock(&s->sc_file->fi_lock);
>>> -		ret = nfsd_file_get(s->sc_file->fi_deleg_file);
>>> -		spin_unlock(&s->sc_file->fi_lock);
>>> -		break;
>>>  	case SC_TYPE_OPEN:
>>>  	case SC_TYPE_LOCK:
>>>  		if (flags & RD_STATE)
>>
>> I'm seeing a nfsd_file leak in chuck's nfsd-next tree and a bisect
>> landed on this patch. The reproducer is:
>>
>> 1/ set up an exported fs on a server (I used xfs, but it probably
>> doesn't matter).
>>
>> 2/ mount up the export on a client using v4.2
>>
>> 3/ Run this fio script in the directory:
>>
>> ----------------8<---------------------
>> [global]
>> name=fio-seq-write
>> filename=fio-seq-write
>> rw=write
>> bs=1M
>> direct=0
>> numjobs=1
>> time_based
>> runtime=60
>>
>> [file1]
>> size=50G
>> ioengine=io_uring
>> iodepth=16
>> ----------------8<---------------------
>>
>> When it completes, shut down the nfs server. You'll see warnings like
>> this:
>>
>>     BUG nfsd_file (Tainted: G    B   W          ): Objects remaining on __kmem_cache_shutdown()
>>
>> Dai, can you take a look?
> 
> After any substantial NFSv4 workload on my nfsd-testing server followed
> by a clean unmount from the client, /proc/fs/nfsd/filecache still has
> junk in it:
> 
> total inodes:  281105
> hash buckets:  524288
> lru entries:   0
> cache hits:    307264
> acquisitions:  2092346
> allocations:   1785084
> releases:      1503979
> evictions:     0
> mean age (ms): 400
> 
> Looks like a leak to me.
> 
> 

An additional symptom: At shutdown I see the unmount of exports fail
with EBUSY. I don't see the crash that Jeff reports above, but I'm
guessing he's got some extra slub debugging enabled.

I've dropped "NFSD: Offer write delegation for OPEN with
OPEN4_SHARE_ACCESS_WRITE" from nfsd-next for the moment.


-- 
Chuck Lever

