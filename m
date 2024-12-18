Return-Path: <linux-nfs+bounces-8641-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7155D9F5C6C
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 02:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD36116D729
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 01:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E739E35948;
	Wed, 18 Dec 2024 01:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HbiVkdGn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZH9rvIsH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E742235943
	for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2024 01:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734486684; cv=fail; b=naKhmL28jl3PVL26NlI7+cHlOLsHoGl0ziMF2eEPDzFUJ2MmsEvTbX1b4pBVxWz3Oq7bKKJp/jxBpj1jTiiNXHgsN820NGSD5Ht9NW0/7aV45RumlqOKVWRmbZ41jpUvYwB9SicbNCfv92Y5PQoEk2eMqexutVtDwn/ecb32yTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734486684; c=relaxed/simple;
	bh=utxiki108OT0IFkubnVni32AL9E2OE7bP2SQzYCDqIM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l80Iniu/Bcw+2dTdygXycwHuhS+dF/Grl+gh3HCXltPpDjXy0qL8Se3sgzd1zs4ACVBkAZp8Km6GctEZhLdQWF+NOo8m55nZCf0noG3ioyNcRAwf7579SdyFK3ynPaGpl9Qdbo8ofhXVGCBr9uyuV3gbK4JgoL+dyaa2/CvjKrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HbiVkdGn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZH9rvIsH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI1NIqr013399;
	Wed, 18 Dec 2024 01:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=WnnEeWSQZe3BJBoQX0gyj6XJxeBsiZrrlsmMJTEA0+o=; b=
	HbiVkdGn4RnPxPLv9ybgtzSswVgWwE8AN3bFwi/1dhv8Z2uP556dqtHgUzBK2az9
	ytpBSlICAxHaplOExatHyqu58qrFA8EvxCJCod1zxmOS5WJWUe6rGdz2O76Xk8RM
	K58ZwndlmwGBJQPp2ZiirVtKqJ3Jaqvb+2mT26sNhv5SMOx7Y+pmyOYyGV1Rvjwl
	cYmoBxa77BG99NxansojCLMjg8PiaOsyDmrZxvT6tzTzV9hcL5Eks93ZEoGU5NWm
	X/udBp/zpLWFPypFlCc4UheIws+lENHvNRZkRs2dTPft0XygQ+GAN1XgPoHFWZZO
	KJnrEoEHYfnbyvzRcCjxIw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h2jt7jst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 01:51:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI11q1k018284;
	Wed, 18 Dec 2024 01:51:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f9es2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 01:51:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2WjCF7IOBi305AgAooWQVlwQg/vGTkRYb1HoJvfxFzPJBW0HUACTUHAipMIuJglUjESO75bJQgInPgwhhuom7yLVdzgtZUhj6SStgTT1IVG59DGQOuWp6CD7NjdbCTgjaoTrwLQbWZ10HDxsKt1pRn+CwYLsltF9cyY3B58U1Bvy46ggNDVwVFWgmm7Ltinoh8hZaQesj6Xwt8ZCfMTF9/SAS8nephGNp4m88JNaQv9wjBl26j3fa+LHoBc+69qFJvOqfO9JaudP4aqArbMrswJ4J8GrvoqTVkuGcgTz5o0CCVsJ0dnzFENbSoLfbohM4bTEffenGdhD9NgtTVfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnnEeWSQZe3BJBoQX0gyj6XJxeBsiZrrlsmMJTEA0+o=;
 b=h5XXduVwhV10aVXC2VCdoJRfOnuxU1dX1i8oQmxJQ6nroK+VssR6jvgnZb8jzy+xJrdYK1wF+YDZr3tl9nWBMCb8qhVNU1Xel4ium1r1leq0pY2tDplLuP7BVZyVgsAAMo+NjnI2IZaseyqjk7O3vzwSnvicV/90NZ6sw2FwSFflybuLQ94M+dndpG5iCoVWzOaldCjtJRMvCjJLsECvy4klxY4mX0dOu8LYdrKTzRfXBfrTIdLOXtQtReYLBN/TFtuv+vhmujIwUZOXnwl1G6d4281129uuxcDVvTeL2lJ+jP6aA9jqT6gNClXE5dtTiXbXj9BjRWlT64YpoDnSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnnEeWSQZe3BJBoQX0gyj6XJxeBsiZrrlsmMJTEA0+o=;
 b=ZH9rvIsHUezHZWkFfgujomI3nd76EkiPIOhLO8FtvHTvZe9hMQoHVwp9Trz3gVyK28GVFOa/CoEBqLNS9im3Lx1F1q+nd44obHuJjF1zj7xg1WLTbcpugn01oNe9dv0dZG6y4ds1MwNVF8gfQtUvgs+L/HXc3efnAc3vQh3GBwU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6828.namprd10.prod.outlook.com (2603:10b6:930:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 01:51:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 01:51:11 +0000
Message-ID: <4804ce6a-fa67-4b50-bc31-715689d3c766@oracle.com>
Date: Tue, 17 Dec 2024 20:51:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: knfsd server bug when GETATTR follows READDIR
To: Rick Macklem <rick.macklem@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        J David <j.david.lists@gmail.com>
References: <CAM5tNy4-SNVD+zqgaJTmLtAQ+kKV_Ce4tRr2zqgjTq1KPM-rfQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAM5tNy4-SNVD+zqgaJTmLtAQ+kKV_Ce4tRr2zqgjTq1KPM-rfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0037.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b2ebee-077b-4252-4df9-08dd1f0672a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUNubytTVi9IOGZQdDV0bDhLc1dTZCtZZFB2NEdUd3JTS044RmpIeGJIaXh0?=
 =?utf-8?B?bXhaTFFFRVFMaEZjTnFNT2UwdGM0T0tpdmlVRUhMdTFKL0FQRFY5aDlEcWJP?=
 =?utf-8?B?RkVXRkVoVEJMMHlGVGp0bENPS1U5Yys3QytQTWl2Y0xwSTNPUzMrR1V6MTE1?=
 =?utf-8?B?OWpTZFhQUHQzMWlRcGV5QUNKTDIvZktseXl1bU8zREhWam9JRUFoRCtXUDNX?=
 =?utf-8?B?eVg5VXhEdGdqU3ZoQndXYWNITkJBSUxsYWtyTW1MaTc5L000aXZtNUJpV1Jw?=
 =?utf-8?B?dmZGTFNacTZPVVduY2VnN3ViQXVEWU1mb21BenRvazRaRDdKSml2c0VCUURS?=
 =?utf-8?B?aXVteVdGUFk0cWhlVTJQSlM0aDkzekx6RWtnZEJLRkRvZXV5M1VKZGh1UU53?=
 =?utf-8?B?aHozS2ozU3g0QVc5S2NLRzIvTG56VTdadTcxVm1jbjk2M1c0Q3hhUUpURDVS?=
 =?utf-8?B?R2VjRW0rYzNHdmYwaWxpU0VBZnhsbUdTRlNhUVN2Z2xWQW1BTFZlL01jSkxh?=
 =?utf-8?B?N3VBbTY4bVZxKzFRazlkNVdrTmY0OERDVjUwR3QrUGxjNEZCZmpmSFM4R3lt?=
 =?utf-8?B?TW9SaTltODBOVFlUVy9jMldlZU9rRU03NE5SVGlHU2lna3ZkUll1KzZ0T3Yr?=
 =?utf-8?B?L2NVR2lxRlNZQmhwM0lnelllOTRDdkYyd1ZCdFpDckVEMWV6VG4renZTbDVZ?=
 =?utf-8?B?K1RhMzJtWG9GckMvMzF6aFFPNWVSNk1rVzRENElwMk5jWUVGajk2ajJjNGFy?=
 =?utf-8?B?NDM2L2tJSWdWQjVkdDFrRGM3bElGSy90WWpOSTF0eEt5QUJwVjB2amdMOTVs?=
 =?utf-8?B?emhjVmQwOVpFbGVna2gvR0tVUGx2QWFDUWpsUXhjR3BNV2E5MkZjeTgvSkV5?=
 =?utf-8?B?Nk55VFhveWxya0hDQUR1VHZYdlFZUzNNTHNEc1J3ME0wbk4wYnhRL2RLSVJs?=
 =?utf-8?B?RmlNcUhRVkVzazVYWHZVTzFZQ2xGM20waU03K2hXUXp6VUw4M3FOYzc0WXN6?=
 =?utf-8?B?b2F4SG0rSS9uaS82dVhrUGVSSlNtUmVUZTQ1a2d1T2kyWnBkc2l2ZU9wekZ0?=
 =?utf-8?B?UFo0Z1RJRzA4QXlmcWhtbXh1eFBUMXV3dnZLNGFWVnVOSm1BYmVoQ09NZncx?=
 =?utf-8?B?Umx4aG4wMS9tTzhBOEZzbmhJMjF0TGEreDVNOUVWc1hXNG5BZkZGbVBHdjB0?=
 =?utf-8?B?YStRS0t6MDRHaUFjNk9XNVBvNEFzWnlKcFpzV0Ird08vZ3VzNVdDWDJEZklL?=
 =?utf-8?B?RERJdDZpbGJORFZ2RlNyNFlxS2pCdm5HQ1dGS0RtYWlDOGhIaEY4SmNJVTBS?=
 =?utf-8?B?N2s2N2hpdFZJN1UrMjd6WkhFY3p2QnJxSGtXRmlMdEtxVC9WS2c3NTh0WXQ1?=
 =?utf-8?B?SURlNXJZZDY1NHBxNlBzbXUwZlYwdjFSaU1uRWM5OGpEelVOeGdlT1Vwamdx?=
 =?utf-8?B?RjMvVTRCZFpTVWpzK05HcGdaQU83QkZPWGE3ZjFjQ01WTGduc1o1WmFBdWM3?=
 =?utf-8?B?NEhoVXptQ0o1cCs0SmRxNXpqYU9mdWFOQk5UU0NEK2l6L1ZLYTJ4YmRvcnFh?=
 =?utf-8?B?b0VlUW12OGRxbFNHbDYvKy9XUkhXWEo5RDRNb2V1N0V6MWZEdjRabjRyRTVW?=
 =?utf-8?B?bXZIMjM2eGF6UVpIRm9jMkpnYmd6cHJuTGFaK0FPZGxoMmJ2T0N0bCsramt2?=
 =?utf-8?B?dHhVUGFTUEhoUFlNMXNLUUdLNE5la0taWldkSkl6TXJHdmNCeWx1L0tKeHdM?=
 =?utf-8?B?UEhMZnN2N0g2WnJmdjg3LzVabENQQmZod0R5anllMnZWM0c4Y1ZkSnh1Z0xQ?=
 =?utf-8?B?bEFpV1hSWjRkUGhrdmNBWWUzbWxxWHJyV2JoR3NUUWJZRnJiQ1pxbDFhU0Ni?=
 =?utf-8?Q?QLMQoQfsz0J+C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rys3b3lDT1M5Qytac1FwMENQVlJCMUxpTjVrZmM4elNIcjZSaXVxZDdJbjlR?=
 =?utf-8?B?bHg5cVR1YmtlajY5THJRU0JGMTBhS3hLME03QlBFSnZvNGhsTVZ2VWRtQVUx?=
 =?utf-8?B?LzhMMHl0M2xXREs0THVqbFJMNWhzcnRPUlduandkTkFaZUNIQXl1V3d4OW1Q?=
 =?utf-8?B?TTczU052NWJBcU9UTkU3TksxaVcvcS9SYnJiZ3Z5aEZWbzFCajRxbTdOOHJP?=
 =?utf-8?B?RHd5Q3RmUlplRURtRkVPVFhCZmJOZEoyL1Y0MWpEaitQbDhZN0lwNjkzY1k1?=
 =?utf-8?B?U0NIZlMvNjRZMFg1M2hZRVd4ekQ4S0Z6VTJCbFZoOUdUQkU2YkRBTmh1dHdp?=
 =?utf-8?B?a29jWU9rM0g5S1NsNThWY1BzNkZqYkhkTHBOUDF6NGM2UnFmNE5nYnN2bDE5?=
 =?utf-8?B?TlU5QzFqR3hEZXBxZm8yK1YzS2JEaUtOeEpVRVZubS93TUJza1hBVXNhdHdp?=
 =?utf-8?B?c29NN0g2RnlCK3R5TjFTSitmNk4rMjZBWE8rRThPUFhPTHM0bDRVTEdLNkNC?=
 =?utf-8?B?b2ZubHltc21BV3hFc1Vob3lZTGt4THBBVDJ2NHJOb3Y4c3JpV1hkNXRrdS9q?=
 =?utf-8?B?cHJGbmNlVTJFcVY4Yml6a1VreEdkVitjOFF5SlRyckFJVkZjc2phZ3RtamUx?=
 =?utf-8?B?Z1hLbEx0QVJrSm43dnBYN0RLRUx2dWZxdjZFTlBLZEhEdUJJTWRMSGZYVU5W?=
 =?utf-8?B?MDkzQk9sRC9OWDZXMHN0ZzYyUlppcWxoSVBkbzdTYUllYnZaR053UEs0SERq?=
 =?utf-8?B?aXRPSVNFcHlkZHdRZ1ZUcXgySGdyLzRhYTNOTWVFdUJZWHZabWkrYUp1UzFL?=
 =?utf-8?B?MzJ4ZWxmdnVYc05PT2xkKzNFU0UxMEgvSjA4ZStLNWh0VHZIYUovdUtiOS9z?=
 =?utf-8?B?K0RqZjY0a29POVprZC9PclU5a1psT0k5eFVZaGNCZnhONk9aUXFqSEY3bDBM?=
 =?utf-8?B?dXgyQ1BvRDdPV2dyTCsyV1QzOGJ3UGdteE1pbnA0RWZWQ1dEQXRVcnVNWndh?=
 =?utf-8?B?V1BJN1NYZ2svM1VmTmpadzhzVFZMb1owclN4VmN6eHFORDRmZzAreUJIVDc4?=
 =?utf-8?B?ZGVFSXViZytjNFVoOXJhVFpMUHlmRVBicmc3d1VVUkJJSVlzZEhrQldJbVJi?=
 =?utf-8?B?T0Jid2lHZm80UU5UUGpDSXd2V2lVM0ZnSHdJWmw1Qms5dDQwaG1aOHVGQTNC?=
 =?utf-8?B?SU1VbFNkTjd1L0xoMXQyMG9DZTkwRE9Dc2I1RndIc3BlNHVXZEg4VFNzMHZy?=
 =?utf-8?B?ekhxUDRRMUovZkZPN3Z4ZEdqWCtZQ2V0aWR2L0IvR2ROTTVXN3JxaWxTckF1?=
 =?utf-8?B?ZUt6cXZLL2xmRmNIOWc0WUl4MHhxRmNuYkNUYXg4QnEwRXV1K3VyRnB1N1Zi?=
 =?utf-8?B?bFVyRThqa1hUKzZ6K3N1ZG50SDdwREJZNWhNdXhrM3daYlpJbEE3ZUlFb0dI?=
 =?utf-8?B?M0xXWUdGbDNDMmdaTkQwZ1VJVWx2ellQUThBYlBEVFFmS2ZuSDRzbFFzckVs?=
 =?utf-8?B?eGp5eE84dmxHamxxREFKTnN1RCtnNzVtODZJeW5CMStyZnROeFQ2V2V6cTRO?=
 =?utf-8?B?VTZSby9nK2M5N05qb0Raa2s0bFNmMEIrbEJ4ckk0dEh1ZVVhaUI2MU02czNy?=
 =?utf-8?B?a1lISUs2SllPV0lsbW45Vko4M1VzR3dGSm94Y0YyMDAvQ0ZtQzVvM29ybVpQ?=
 =?utf-8?B?eG96THdXdWpUYit2akNNK2tLNlYyM2t6NnNjbWJDeThZRytXdGhtV3puZnZz?=
 =?utf-8?B?bFZRUmg5Mm5EYTJxS2FSQ2ZlRVRHWnJ6UzUvL3gvM1FKWm5abHlCR3ZRVVBY?=
 =?utf-8?B?TGp5VFNiWHBIblJUeUpUL1RsbTFqdFJhbHdHR252ejB6Z2ZTYXNrRmVQV2VO?=
 =?utf-8?B?M05yOEFQQ2ZDQXovQmo1eWg5SzI3Yld1aE1mQ3Z5SmxZSjJRNU9jN09Kdndl?=
 =?utf-8?B?YzV5Qm5zcnlmRUxxSzE2dlJ1ZkZGaWo2SE91aUhHTDJNb3NJK3QzMWNMVEww?=
 =?utf-8?B?RXhoY1lHa281VGQ5WlFwbjY3SWJkOURaay93TmZSR212QVNSbWJQK0Q5NkR3?=
 =?utf-8?B?dTRTZFNGaVZGbTMzWjlmeTVIY0hGM3RSdksvSmE1a3Uzb3pHUldVRFVPaCtU?=
 =?utf-8?B?NzdmVHYwbnprMWRleDU2bXhYSW4vRlZqNktZelg0bERBWDJsaE1UYmVMYWdV?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yq4tVjDV8EhfjxinM5XOgbfCp7YBauGNgsd2nig/HJdTxNmRtdbrpf/V6EXATnfECgTsl84Q3MWbE3LbSbQwd95TnLrsgxxxla4DHOdpGpIwXfmQ5x/+B9mkjccT3qf9wUptmwiivPWy1lyN7RfcQ0uMoPrvb17Dzc3LF8jowk8e92/Y6BGsG9vWzogFxk8TAZpHExxpT2EsIcZyUg5dXFhVxUfNNFw7dySITXB0wap4bUMYcWT3EnSs/mJZsJdlixR6F184x0isIaCY5IMAj00czw0K49p10SRSHfxVfa0jpAQowIgiEOmU/PyGQAF1b6lmHZFb3/vnn1KJG91IvYwDXylPPJZ6yrSx+MbCUeXlb2olx2KbjYJGDLYrUAECE+lmpuZNn9MOOyPfQ+VBpHjnH6+gWlLvHPbuWLZCFqM71aEKzwr6AyI13Krznb4XGrgJpvy8DkEhHaolu3MLFAzgZz3F5KGSORmDwwng3YbjdrZB/itPSQ3eio3eRuhTebEKGU07LLf4sZD4It5ZQaZlpvS11SQpkQbi+K6UZfIxrZ/0V7BLQZ1mfZUlqhBcW2NjImde9wr5cwX7Uwhi2bqqqFJjjD9tpM//7r9vPnU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b2ebee-077b-4252-4df9-08dd1f0672a7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 01:51:11.2003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nre79yM4YS9jpce3giChFZTueMIFO9XVkNn9vg1qzCX3Doee4y7lJuZmHESUcjRlBWZzG9PUX4dLpju2TmT3aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_01,2024-12-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412180011
X-Proofpoint-GUID: QaNg7k0ssVbukChSPBb1TEAeNBZPabj2
X-Proofpoint-ORIG-GUID: QaNg7k0ssVbukChSPBb1TEAeNBZPabj2

On 12/17/24 5:10 PM, Rick Macklem wrote:
> Hi,
> 
> The attached pcap file shows that the knfsd server generates
> bogus XDR for the reply to a GETATTR that follows a READDIR
> operation.
> 
> More specifically, if you look at the pcap file in wireshark
> and go to packet#22 and then click on the operations and
> then "Opcode: GETATTR (9)", the start of
> the XDR for the GETATTR will be highlighted in the hexadecimal
> window.
> Now, if you look at what follows (in the hexadeciaml window),
> you'll see that the GETATTR reply looks like:
> - GETATTR (9)
> - NFS4_OK (0)
> - Length of bitmap (0) <-- Not (2)
> - 2 words of attribute bitmap
> - 98 (length of attributes in hex)
> - attribute values
> 
> Everything looks ok, except the number of bitmap words is
> 0 and not 2.
> 
> Since the knfsd does not do this normally, I'd guess it is
> some sort of runaway pointer or use after free type bug that
> causes this, maybe?
> 
> Sofar, it only appears to happen when the GETATTR follows a
> READDIR operation.
> 
> This was reported to me for a FreeBSD client mounting the following:
> Debian 12 w/kernel:
> $ uname -r
> 6.1.0-25-amd64
> 
>> - what type of file system it exports
> 
> ZFS:
> 
> $ dpkg -l | fgrep libzfs4linux
> ii  libzfs4linux                    2.1.11-1
>                 amd64
> I suspect that ZFS exports are not common for the Linux knfsd?
> 
> Anyhow, I am not sure if you have seen such a problem before,
> but I thought I would at least report it.
> (I have cc'd the reporter, in case you have questions for him.)
> 
> rick
> ps: If the pcap file does not make it through the mailing list,
>         email me and I'll send you a copy.

Hi Rick,

ZFS is an "out of tree" filesystem, so the upstream Linux community does
not support it. I'm guessing libzfs4linux has its own upstream
community. Even so, it is a not unpopular choice among Linux NAS
enthusiasts.

Also, 6.1.0-25-amd64 is a Debian-built kernel, not sure how it relates 
to the upstream kernel (distros add their own special sauce, and this
code base looks a couple of years old to begin with).

It might seem unfriendly, but we usually ask, in such cases, for the
reporter to work with the Linux distributor first. If they can reproduce
this issue with an "in tree" file system contained in a recent upstream
Linux kernel, then we can take a look. (Or you and J. David can give it
a try).

If it can be reproduced, we have to fix the tip of the upstream branch
first, and then take that patch, as cleanly as possible, back to the LTS
6.1 kernel code base that 6.1.0-25-amd64 is based on. Debian would then
be responsible for taking the LTS fix into their kernel.

If it cannot be reproduced, then it's likely there is already a fix
somewhere between 6.1 and the tip of upstream. Generally a "git bisect"
can identify the commit, and it can then be backported as described
above.

HTH


-- 
Chuck Lever

