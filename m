Return-Path: <linux-nfs+bounces-20278-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLCLGeMTvGnbrwIAu9opvQ
	(envelope-from <linux-nfs+bounces-20278-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 16:18:59 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFB22CD911
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 16:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ACE23007F46
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 15:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E606389447;
	Thu, 19 Mar 2026 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qt36S+Ph";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ymV1ts1m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A33A5E9F;
	Thu, 19 Mar 2026 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933230; cv=fail; b=gwJbEffO0RX/lQMJ6pJw6l9lqCst2y6AtZCvYLIbKf5ndKrjURM2bGCwGauwqWoPlTjLVQ9JwKlPYQUps/ZPA3mlubCmelCBL2Xa9L3B6m1j7P32r9bbMXUs/naY9qDQTgnMG5rSdbVXSOpw1ggpJVAxZIClEIksmE+SDO9Ak0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933230; c=relaxed/simple;
	bh=h5OXqejHTHP6N/nfRGT38qvY5fdq4v5wRpL1mZLp1VY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=djlCpdUqUyvmaFT3HtzcKwe7/g+f6V9h4f0Zs13HOKjcQKWtIkdSmT+u8pc3wlkCwgfNhaD7jL0ggLCBJvLkjJEaFgRT2oXDYa3ul362AhwSmR+y7m7zGtwZuBfsYFCmmRDJCnbs/64aZavFnilVn8sKHryLvG7UBh76w7A21ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qt36S+Ph; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ymV1ts1m; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J2i477975855;
	Thu, 19 Mar 2026 15:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=18L4kWU5hkjQvyYQ0jU1IC01GRy2J4SVDvZssJrlqtc=; b=
	qt36S+PhozsKWU8kjfAUzedxnc4yFjcxU9EXCOgPrVR4pU2h4d4p4SMaiOVyEY8E
	SrV4GufoQ+Wp3cetn824wZbgTpMhO0/owmqbnEZec4AsymgZJz9DTRTcHkQVk+aT
	uUcBux7iQ1/MpY5i+zfV1YTb6qS6JzscljAyrv6UsQ3Tmrg5xeCiU/onfaBRUfNp
	Ofjq9GeSDdGR7+u4qT9vr5lttvrKM7E6QYeOfBPQuBhcsK0NT2mFdEIkyGbwcbhL
	KYn28r1tBaoPxctX+gOCwyxp09VDrAiOjQ09M7hGWI1O/OAjIMYyLr1479g3hSZg
	UiSeM8X0YB7/0pXzQCJoag==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cw07rg48b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 15:13:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62JECpko003397;
	Thu, 19 Mar 2026 15:13:41 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010039.outbound.protection.outlook.com [40.93.198.39])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4d1xug-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 15:13:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4ZaN39AYlbQQepflDhdAB01xd5U1X7nQPO4y4Wm6rOOgcpqCcAk1US8A1aH9bxiNNauO/1ZG4msCNTBy6RNaxrEdE/udp78WbLxGl3ebPMmoXFvaTp7Xh+2uzX4WkP2ABi01/0yxLW4DvQY1vU3SF1AtpGL2ZCpqGq/Z5nqrBkJjGcJ/tO0+F4RRGfEq1DXtyQK+giofiTsNdR3+7L2DH7ybOVsB4ht78QaOcCJyR6C47YqdZo3EzpqRT2cXdEh9OFbBz8MXCE94s98uqaqGjVOvK2mwmguRIilJRdSDeiwt0grXWifD62IIWRBqbkLwD0cfS+soKYU4pP4s7vDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18L4kWU5hkjQvyYQ0jU1IC01GRy2J4SVDvZssJrlqtc=;
 b=nPD5kOXHEwGj3EK4ESbXtWVHTVincynE6qqCW6StbWUAAtPMPPaR3PbiLvoaUZ2cPDf94MKppZIOl/wbsA2lfoMS7U2EXueDF0y2tKItF7W3hqHnx4ILZn15Uawa/vPcD/3C9lRLYlAw1zPLJY4G15S1Noo+/HvijWlvjiV2BImymPUsJ2Wvltu7Pi5/5WEoABbORhsSwuAkaIZzyKUjCOxIPNO+5JnNxEkW19DirC7XK5WHfEKuv5F9Q+yervmHZAbfhfGglmoh/MJ0NCExUNrm94SnAyA8OBiMO9NmMVRuLoIdcT1dLadjpJdausYoQB8bdts9mU+851iNV6/Ycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18L4kWU5hkjQvyYQ0jU1IC01GRy2J4SVDvZssJrlqtc=;
 b=ymV1ts1mRh4k+3hzkiDZ2dS9cr7dR6ez/IRpQGE3G0Vk0NTmsbXgwAujWQ383/rGTiNjhj1IFIenqhvcyCsFn03dTAhogEtFQBphOlXTj7nHg44ifMpLH67BfMCC570zi7aR+fhnNxwZNGeeVD5RJhw8NNmcvTmL9wOk7nb2trg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5574.namprd10.prod.outlook.com (2603:10b6:806:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Thu, 19 Mar
 2026 15:13:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9723.019; Thu, 19 Mar 2026
 15:13:16 +0000
Message-ID: <da7312d0-b31b-4a62-afbc-ce0e656c5134@oracle.com>
Date: Thu, 19 Mar 2026 11:13:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] sunrpc: add a cache_notify callback
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
 <20260316-exportd-netlink-v1-5-6125dc62b955@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20260316-exportd-netlink-v1-5-6125dc62b955@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:610:59::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN4PR10MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: f1fae51c-38cd-4393-cb31-08de85ca0bec
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 Aeuqsz6zYXmZ0lgdgcktBpsr129uQ14oYPDaZgsi/P+m0nKnM6NISg6VTDm4JtT2D8auzrV6wT1K1j1zQrWuXSbsPUl8UGQ6sGExnYa993H5wXJrujQ1IoE/uht58aIB0ebSWic0w3qY//gq+vGVTTf4u6xl9YG8a8NtQ+mbh0w/vcJEtv4p+yGYdEYaRc9T8qgJ4LSI2hCWHkand+QDlsjkYH/gLkaVKHbjM6S+VItFCSQmsernnVVd1HMqcRpgYab6jEja3tOrTyGF+ItyeSA+90UBsfiLubLwybem9nY9XPPEZ8YPdrcksySQWnDmYjCC3w7m3zZGft9zr2uNeVS4NvH320BeZZXCcLAJEZsGcajFuSizVILr4SozNh0FCPinZxAnCG5thlV93OXa11HpSuv4u6N1art+BdnOlCCspkSwMRlLfDR2ZhVGZdlTxbBrUgwphMZDn++uGwqbkGw0u3Xvl062bXuLYu1cyiIiuT8npuFmJEqPhw/tToURq23fDE88ILwosxzeiSaNj5BvCODna9pp8adWjf//VjxXfD01GHajhYJ/ZokYE9RtjKrUJJFqPDd6Tj401XhAMa1vhUR4J8UifscRo+C6YMKofrx6eAFacYqasvrS9H+kyxNZ4l34YFTsFMtg98BJis9EZaBmsmlSeIkKWRdzuUle8mFYCGbuaWjmTdNLTPIcz5rKA6r7jo4Nl9LuLelNiu3pFyBELr/mA9RyVclSl+M=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MHJjYkhRRytmWEZ3NGlFTWFXTEgrSlpxaTFBQ3ZXVk84YVNZUEdYY0R4WDB5?=
 =?utf-8?B?MG0yRjVqWVZrVVkvM0VoVWRzNkFYK1ZCY1l3NDU2Tm00Ym1tUng3bm00TWNM?=
 =?utf-8?B?TWFmR0VmeVNObWNXZWUydHhaZ0QzQ25PeXE5TEpaUzdSTnZDS0VEakRtdjBU?=
 =?utf-8?B?dUEyKzJEcWlwOVA1aGxWV2p1V2JGR0crUFZsSnhuM1pYOEIwSlg2ZUNiM3c4?=
 =?utf-8?B?cWJKSUpSTnFSK1k1czlMYlhveldVcEI3aERlcmlBM0xhNWIxbGtjV0p5OVhF?=
 =?utf-8?B?cXoyNXFSaEVIMndxZE9VOXpaSUsrRWV2MmhmUWl2OTVPM3h6aHh5SU9oVHZl?=
 =?utf-8?B?QlRvTG42U28zRGJmOHlxb0hjWFFnRzFyUXBqS0JGbUN5LzNPT3JodHdncXBK?=
 =?utf-8?B?NjVLd2VDQ3dSbFBnTkMrbEFZYUxQUS9PM3FZVHIxWWtHMyswU1NZR1d4MldR?=
 =?utf-8?B?SnNBa3QwQkg4bnVFd3VuZklSZk1NMzdjK2p3eE9EUlpLQ3Fmc2daVVhaRHk1?=
 =?utf-8?B?R1A5elppMUtzSFA3bFlyYS9OWGhoQjd3WlhjUGVzNFlkWGFjbHlOOE9yNEFy?=
 =?utf-8?B?bmpLVlN3eFB0N3BZQStVM3BSdXpycDdaTHEwaTUwMlM1K3poMmpnaStXODFM?=
 =?utf-8?B?TjdnRi9YY2tFVUhkNlFzM1NHb1hvS3hSMzZsdFFlT1pGMHNJQjI3cjh1ZzM1?=
 =?utf-8?B?M1dEM2h0cmxoc2R5NGp3TVdWUGQvTjFPUkd5cFEvcURmV215aTFFZDRkeE9E?=
 =?utf-8?B?c0pDOUttOTBaTmt1NkN3RVVuZVJGTFFhaW51eDgzT3k5WDR3b012eEk1ZHlU?=
 =?utf-8?B?UDBQTzljekJUTEtwQzkxc1BCQ2RjMm9YSzNzYXZRSE1Ca3h4WjBReFdFSU5W?=
 =?utf-8?B?YmpUOGhoeWtVV29Vd0ZJMVlZNlh6RzlmcW1sa2gzQUxIMFpQaHp2UTFoQlM1?=
 =?utf-8?B?dVlSU2hXVU1Rd3RvQmgxVnBjcEhLZDhKd2tXVTJ2VWpsbWZHZnpXeVFIN2Qz?=
 =?utf-8?B?WUVLVk1uNmdJZDBrNVg0NXNNSTRiVEVXc0RXRzBLNDEyUEdsclpCK21XNzNl?=
 =?utf-8?B?d0h1UmRLS2ZXbVVLSjdZVFlDUVFvNXpUbnRBd3pJZURKTm1GamJzVU5iZ3dX?=
 =?utf-8?B?YzFQMXNqQW9tWFBBN1RUa3VsMXFicVFENUxWSzZoaDU4dHNYenhKaXdQUkgv?=
 =?utf-8?B?MHBlUmlURERhdEZyd0VpUnBJekV2QjNudGFCNWpTWkpvWVN0QW9uazcyaGZN?=
 =?utf-8?B?MGp4V1FFWVc2eXloZ0JMVEFBQXR5UUl6c0tMZkV0U01jTHR1OVMrYkhvN3ZM?=
 =?utf-8?B?YUNlNjNuaGlhYXppd2ZEcHZsY210QkJlODJRSFQxUTc0MFd2eUw0M05sckFN?=
 =?utf-8?B?akxhN0E1MlFsakNEY29wM0phcjg5UkFGRUNIaVdhZGViUXErd2wwc1ljQXcz?=
 =?utf-8?B?cVplN0UvbENGWmlIdmZlY1c1V2lzTmM4VW0zcE9obnZPYmIzUTFqZ2hQQ3Qy?=
 =?utf-8?B?cjhUdzMvRS9IdzZONGxvK3BGbFdyTFpnZ2ljSTI4VnRKdzQxdGdicHpFZ1J5?=
 =?utf-8?B?L0NoTmwxQ1FlS2ZzSEJtTWxFV1oxakV3U2pEb3VLN3h0VUNCaW94Z2VvV3c2?=
 =?utf-8?B?RzJtWEdEaFFEbEw3OTZwSWFHRGZ0NnYxK09WSnFkZTMrNXhZZXN0dHRlS3h5?=
 =?utf-8?B?VTh5dUJ2WFRIRzZsd2xuZ28raXh4NlA4N3RUUWlzTGcvV3MzbkhxRFdEbUFG?=
 =?utf-8?B?S0U5SlU4bmMrdGdHWk5MeXJJZUZSODJINEFEdGxRVzNjMWFzeTBUc09CeVRQ?=
 =?utf-8?B?MEEyOEd5VlA5Ym5GcnIvU0IreEd4by92LzNMdU9WaFp6UXRDVVpNRmpRNytL?=
 =?utf-8?B?bHVvVEZVSlFzWU5ncitQdjUzeEZ3a2puOEhpZHhTcFhQMXAxTUVXUGZJUkEv?=
 =?utf-8?B?Vzg0Vkc0aTJmRTBqQ3hIU29wVWJrZnJjL3ZSTjdNVHNhSXhGaU9CYXM5b0Q5?=
 =?utf-8?B?VlNBMitZNEtkbVFGejdSR00wNEpJRnVJUW9HckI0KytRaWFGM0pZUEF0eDcr?=
 =?utf-8?B?Y1VXVkpPUXRJUzd2YXNpc2JXdzFzYmRldis4aXlPamp0VmRHK1krNGpFai96?=
 =?utf-8?B?K2hKWVM4VWV6eS9WN0F6Wmp3eW9SUXllSFdiTVhoN0FIQUhDREQ1STVzb2V2?=
 =?utf-8?B?OEdqNUhONzNoNk52S00wMFBhb1JMQlNsdmQrMVl6WFg4aFBUZjhScjFBZ0Zj?=
 =?utf-8?B?cEZqb2ErZkoyRlJSSEloTVVVNnBHR3pwc1pYcUNYQVgzYjVINy9pa25HU0ZG?=
 =?utf-8?B?SjVrOUhKSUl6MlE4b3h3WFY1WSt1N2dUSjlPc2N2SGpZUURwNlo3dz09?=
X-Exchange-RoutingPolicyChecked:
	VJshJ/5Q1RFB7eiId/MfXYxwUY/9gncwL6UJGNQ+YWNiU9RN4GWvgGQYWlbDjBN1HpAEqA9Rd4MAuBRWrmX38YtT/f8zP3EKPnl/BMSmBlgpJVhpIeWYI0MSN9f53X8ucEU4WxsEUphqOwEiv31N/donttnU9yTCMrchlewWkffB95MItbbdccYxKoi3ZwvXCfV5SDtBDDZ5LzhlpbjtW0GsIzmEvaLWK1SXoYE74tdW0YWFXjPj8X1sSuZtue8PvlJQgxE4nRvw3gppVfEF/9h44MAcy/DmvZqDlwQrMYIQSw21n2Mw/88SnwytDfpLnQTinM6dvdmVQCUzF9WNZA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E/BInW2g77lcazGLwh2wmfpmo7RhHTSU0M7Vd3NYylhexvmt91XNZ4K0Y8hPbG3h940GzgPX+SAnzKP/9ktkhPY8USE2xujfNt1G4qk9gn4uxxOz86dKHGGWyKZC/c8jZSni6MKuDNFckAEjA6DINKmt+LOU8whHPZsyNK/VZw4qI6L95q/MpjhFTdDC6wL4ZUhDMumr0CLkJT7gbajcr0WxVw+TToGLg6Oq1PgLwIAfZq+JKvy7rbe8Njr23LSTiVqPEkU2gon4tZVFOImQfT3A98dnv2YvuceszqPA06sVwHXZ73V0FBcBwZYCc8AC3RHBD4fFtKIKFOU8iDiUN06hWQ8nkjOo/PfB+XtsfRQnrb4LXgNkiI+bOspyP1XwlccDLBkEqxMnzMkWFtslVsrZQWqmJ4n1pvVO5JN2jq7GC66StMT/QCZ2MjZ4lweBlVqOYJaZFYS8xUXPF2JxagXOL+tDVPHOIfi9aPFAI5qx9FNfCJqk/AshRo6PQx6TWWSHgtJjFwjNyBBNreL0Gg0hUTiVNI8oa5YiuUy0wTNx0dwXz2giSkQvntgfiBYfTpoD5ZibdHLkDCfQHUs8hKZi5sUA3voNEjXKkyZlHmA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fae51c-38cd-4393-cb31-08de85ca0bec
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 15:13:16.4374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHnOTsdtJ3ws3/KBY9xZQ+qvbobbwohpJ9nqlrbDVkC0E8x0fPYcg9RU4al8RrZxK4OhzMpaoQgtyhjmC2ltRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603190121
X-Authority-Analysis: v=2.4 cv=HcsZjyE8 c=1 sm=1 tr=0 ts=69bc12a5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8
 a=94QYJDE9GOhKAgsc4RYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NN0r0b2epG9Gg5yYYxlhkO5xQSgDDTp0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEyMSBTYWx0ZWRfX/MMMteHEWYj7
 tlswnVMs2tbCitWAlN8zgCivsh0G2gMJRLLU3k+YYbs987GgB6Ne3zQpcM7tU9oSUNyRLXdMJsc
 mwkI6hdIgY8KEHPedfZcUTyz6wszuOtppeomuZlrpNWE9srkQR9dIm68UeUj2wbVH17gaGv91ov
 Y4MnL9WE5MdyeWKzlA/P1ZzU3XstDqiIo5pDfOco3mpcT6zULzm9yr0OVmY98tmHApPmc8IGQOU
 LilOXx70CQ8maNXM/Dk6hXLiRV9Ihl8iyFvsNrAGQm11WxSwrTF11Hayy/RczaV5DGRQxQBJSyX
 EaJX3DqHGtchzOpuzaXxiaYdWogEOoqXCIdFlUfxqfjnFRyL3ynPlCG4wJuMbZa1ngjKZW0E/p4
 s74/FvFdYMLTbS1zkbIUDfKX1Vr8SgTfpMTtpnRnPdwGcdeevsWhEvY7m8oamwtds+tZ9kKDYO2
 KCEyWZrVTYfZsf7fLEw==
X-Proofpoint-GUID: NN0r0b2epG9Gg5yYYxlhkO5xQSgDDTp0
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20278-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BAFB22CD911
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 11:14 AM, Jeff Layton wrote:
> A later patch will be changing the kernel to send a netlink notification
> when there is a pending cache_request. Add a new cache_notify operation
> to struct cache_detail for this purpose.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/sunrpc/cache.h | 3 +++
>  net/sunrpc/cache.c           | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
> index 80a3f17731d8fbc1c5252a830b202016faa41a18..c358151c23950ab48e83991c6138bb7d0e049ace 100644
> --- a/include/linux/sunrpc/cache.h
> +++ b/include/linux/sunrpc/cache.h
> @@ -80,6 +80,9 @@ struct cache_detail {
>  	int			(*cache_upcall)(struct cache_detail *,
>  						struct cache_head *);
>  
> +	int			(*cache_notify)(struct cache_detail *cd,
> +						struct cache_head *h);
> +
>  	void			(*cache_request)(struct cache_detail *cd,
>  						 struct cache_head *ch,
>  						 char **bpp, int *blen);
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index 7081b6e0e9090d2ba7da68c1f36b4c170fb228cb..819f12add8f26562fdc6aaa200f55dec0180bfbc 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -33,6 +33,7 @@
>  #include <linux/sunrpc/cache.h>
>  #include <linux/sunrpc/stats.h>
>  #include <linux/sunrpc/rpc_pipe_fs.h>
> +#include <net/genetlink.h>

Nit: Adding this here might be premature. Should it be moved to a
subsequent patch in this series?


>  #include <trace/events/sunrpc.h>
>  
>  #include "netns.h"
> @@ -1239,6 +1240,8 @@ static int cache_do_upcall(struct cache_detail *detail, struct cache_head *h)
>  		/* Lost a race, no longer PENDING, so don't enqueue */
>  		ret = -EAGAIN;
>  	spin_unlock(&detail->queue_lock);
> +	if (detail->cache_notify)
> +		detail->cache_notify(detail, h);
>  	wake_up(&detail->queue_wait);
>  	if (ret == -EAGAIN) {
>  		kfree(buf);
> 

When ret == -EAGAIN, the CACHE_PENDING bit was already cleared by
another thread that won the race. Calling cache_notify in this case
sends a netlink notification for an entry that is no longer pending. The
winning thread already queued the request and will trigger its own
notification. If you agree this observation is not a false positive, a
possible fix might be:

  spin_unlock(&detail->queue_lock);
  if (ret != -EAGAIN && detail->cache_notify)
      detail->cache_notify(detail, h);
  wake_up(&detail->queue_wait);


-- 
Chuck Lever

