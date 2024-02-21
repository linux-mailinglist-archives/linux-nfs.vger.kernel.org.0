Return-Path: <linux-nfs+bounces-2045-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4FB85ED74
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Feb 2024 00:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6171C22527
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Feb 2024 23:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB9912BF14;
	Wed, 21 Feb 2024 23:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nT4qmwjN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ypLZ2In5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2DC12A14C
	for <linux-nfs@vger.kernel.org>; Wed, 21 Feb 2024 23:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559556; cv=fail; b=fAAHN15sPt+U2kcp+bl0Lc12WvK7036oPiGN2cQ+VWTzTaDc0Ngj+GsaphhEC71TPMnnrc95Z5f2nrUkcA+sv/Cv59yI88NwzUfn4W2qmDttWIaFpo8TjHh5T8nTTMC63MyMXbqODn/syy/G1hAeBSBbZWZt03p7Qxf/6dG4Lks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559556; c=relaxed/simple;
	bh=AZwxKloSREyksYx6wwpMBnlyNfkcTNZAY6hRpvI81Hs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qzt/yd2qGspnN3XfHcsV1SwJoFvxV42CC5xXFgFzqRFmOtgWDpHqJblaKZH06lHzAZ4EoWA9KO3CqFHPjOVVJ6LPC81GxyQ9+DKyilO+5n8RbHQm4piNn96W8TMlOxlYPXI5pUT+jpKLRIJfAlu+dMGmBcOGicBN66Vur0la780=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nT4qmwjN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ypLZ2In5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LJbFWj017556;
	Wed, 21 Feb 2024 23:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=NYS8f3cCTVSADdaxTnU1gvJqsd9GjAz6I4QXMh84CoY=;
 b=nT4qmwjNNadn9q+nq4rQNYwqT2ejZC5qS4sNVD5KEgnC8vWaLbCNE4KYItT36zBon1yn
 WhvOEr1y2IpaKU7Okf7ytlKWUSl3mkh+7RDpsMQNLzfqxafI5ICe83ItL3lAGDctiR0O
 1vVn/RGcjLHsv87LgPkWdz7PvRSLOOtjkkpwZp570+XqAhf6V/08MXgU5Nh+IKkeEfeL
 jQ3UXoZ34uOeCbF3UoJH4CIVysjYVTv7NGe017+RYUKaroCRKRQXoqdeSfwPb9ZiRL2/
 53qMJ75VmS+/VB6vNWWdQf2ZseAZ95ExINXItK1y6dhmvLWwtbBB0l67Dq/IbhkrENnR 7g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd4kntxuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 23:52:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41LNQFF8039679;
	Wed, 21 Feb 2024 23:52:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak89tq79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 23:52:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C81sDaIztOcvcta6cr8835iBIjBnkQIAmUlZrRSGyBSlHf4Zs2eX7Xqfo4K63PhjNu+CFR0bWCvtDeF9bBtZezGIFPQQvhDNAEhUghMnD/fojwNgridGaR+d45aFyBSWZpflIot4o9pWpUvoAlg6yoHKlnMIXEQ94w8aXWFBPlXRjVI5zNUnb8y0A6k41rAXtRmpholKavqQXJai2e/dLMQji+0jG0C9Yf2X7II+H3t9ibv/Y7PNeIkX+gt0szxee3nFl6i4xScrd/EwyuZ0g0uhVfS2ZndhTun0RyNhxLBxvgH7mo0qJRRuaoafc94TsxfDb/mBAA620GUnlkxH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYS8f3cCTVSADdaxTnU1gvJqsd9GjAz6I4QXMh84CoY=;
 b=PzqRPEnDz77xj7IR27Pk1lZiZQnxv7+zCgmW1r0Au8SPyA3Sspy44khF0FjmYwr7++OY2reg4ZdkNlq5EDOZE2+CjSQFJfWIV5cR6p8nK7+YI+C731rv59UgJTuO7Ei7KdhF6NcU9ksNHGDvv6vvtt79t+Fu1298RPgkgPN8NcLLW59CJ0l3iOhHCl3xGZtM+njoonVBFXQR1deIT2JfV0VUxHpW5VEE/PwW/aqVoNe9UkoyWmvWAzr1WHGBbCYpUoMOsyH6s1Gny1i7qJHZLAsUrhbFdbdxOUIoJJBs5gdHLCIWV9GasB4y88HKDqvWd1DZfkKstF3KOLwmqLXx6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYS8f3cCTVSADdaxTnU1gvJqsd9GjAz6I4QXMh84CoY=;
 b=ypLZ2In5SrYi68ma7biekU16/PFT0wmg+sMqbRdPwfkycLxwlB5asEwKWl1uTmvas5frLFJAFGQRL57lSQEpibwBqmXCgkctw7dJcHczZ5IFA6PJdt1L/S4tJiMSOPPS4nReLE/Mt8S7d3oby1MfL7xRh7XxphzmY9sgboYfLfs=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SA1PR10MB6366.namprd10.prod.outlook.com (2603:10b6:806:256::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Wed, 21 Feb
 2024 23:52:28 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::9a8e:88e2:8d1:d51c]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::9a8e:88e2:8d1:d51c%7]) with mapi id 15.20.7316.023; Wed, 21 Feb 2024
 23:52:28 +0000
Message-ID: <fe95feb5-a2b7-456c-957c-2b50f1eaac77@oracle.com>
Date: Wed, 21 Feb 2024 15:52:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: send OP_CB_RECALL_ANY to clients when number of
 delegations reaches its limit
Content-Language: en-US
To: Calum Mackay <calum.mackay@oracle.com>, chuck.lever@oracle.com,
        jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <1708473508-19620-1-git-send-email-dai.ngo@oracle.com>
 <530d4fa6-f4f8-4981-b352-095c9d038f41@oracle.com>
From: dai.ngo@oracle.com
In-Reply-To: <530d4fa6-f4f8-4981-b352-095c9d038f41@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:74::18) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SA1PR10MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: b8654bdb-66bc-47e5-3d41-08dc333828fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3jaMjd08I82FLDLaphvwlX3Pc64thnMa/Q/k7v18gBpraJpDQKstJrtC0wdElf+T0g5zyteYXTUIZRDWjvVjJ6fkzy6m5miZwXr5ozB3Hn3k/W9z4gQjK7t1AzHHhwAEHmmrMI8/n2OVPJ4Thbq0XOGPEkl3aBRpCi9bdwThq6+C/WeqpzJQR8ffiGaMvgeUilmSHUsqFRKpGR/755LmUejzIgwCPLhmY9Zrz6JcDQb7BK9Rquj6XxIMR42YQRVE7+cSDb81cgJwbQ86HHf+1gpjf+BC/u++JJf2131tZ8e7bVVEDkP48uCS7+kZwl1YPVVWvwtqtjt/sOncWKys6UESp2n2NVB9rlnVMMyvJY5JQ6DJNY3jm5aFxkkrWIBmYyBnex6rMGMVMvAtlVO5ZIK5Eucm5mSp1tjJVwbifEYflBf2LfTgPVXvGgsOvBNX7CyBJQOU4pRUVBJW1erLcYAx1L2PWa0q1in9VNF6kMoD+yPeoafmC4UuRBIVcV/LrxGpRGm6XZxqn0gwnaJVTf9LNijgnrrMDwRXjh6TPNk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NWFEb0pseHhPZjY2TEFla3ZjMzFkTTdIWmk5bG1QNStWMEtBR1ljSXh6K292?=
 =?utf-8?B?aVpFOHRtdzQveFhRNXgrSG04UWJadWtJMUwrNWM3bHlOTXprUElhMlR1SFds?=
 =?utf-8?B?N1ZBWUcvdWl3MUFjT3V6dGJpbjdpTzhNZ213TFUyN2kvK0RRSEdyNmdHUFo0?=
 =?utf-8?B?TEdNV2lmTHhIdzA0UjZCNytOOW1jVTRERVUvSkxmdkRCMEpUTmVaUnBmeHRU?=
 =?utf-8?B?NW1Nb0F1eGJuQk0rdG1Hcy8xdlBEdE1kS2VWNzNxdWtrZ3padndIWC9pQUt0?=
 =?utf-8?B?UDE3cksyTGxOKzRNK1ZQWFd2TU9PUlR4MFVmb20zNStpTE9UVG1Sc3Y1UVpi?=
 =?utf-8?B?Z0FycWVnclNDMFFXQzFtR0ZyTXh2QUJhVlVjYm9SaU9tVjZSQklBUlozdUlp?=
 =?utf-8?B?S1BkN2piN0Fyd2pUUk9qYnRTMXlLSHFwejJlVU5wMHM4NzBSSnBXM0I0WTMy?=
 =?utf-8?B?Y0laVWdobzFEb3ZQaHF2cjJpN1JJcmhKR0cwTWpRc3QwTjVpd3pIbEl4clhU?=
 =?utf-8?B?Tld4eW5VOEdQQyt2OThuK2JQSWQzcGRQRGpOMy96NkZkQnl4TEUxeEFnQ2I0?=
 =?utf-8?B?cmVUZUZ6SGVFRE1zdkMwY1JKdURlTENNMlRUYkdiaEhONGt1d1oxbDVjWHhi?=
 =?utf-8?B?WHVQclNqaElWQ2ZISCtUem1QUGt1OC9BaEM5VXlUenVUdm9uUmxnbnVjTlBl?=
 =?utf-8?B?WUM1Nzc2UXQ3enJhZ2JPc3o1TERrVXJsbENxWlNiOW91Q0pQTjhac2hpVkhX?=
 =?utf-8?B?RlByYUVJbXo4R3Y2eXlKbzQ4d2lSSXJGUVQvZ3k4aHNQVDBJa2JwbTdlWTNU?=
 =?utf-8?B?T2RiTWlrWnF1RUlLR2ZnQVYrSzFRdUFKSlJINFc2ZWxmVFp2d3VmMDR2U2dP?=
 =?utf-8?B?TFJWejdMOW8wNEcvd2ljTUlRYzUzaVRwZys0QTNsVEJOeUxnMERNdERxZTc5?=
 =?utf-8?B?RGdGTjh3TmI4VW03dElYWG9CckVwaXJXNGNvMW9sOHl0cmRJZVVVa25lVnJ4?=
 =?utf-8?B?UC9EampsQTJ3emRkUlVNNk5jSGJxc3NKUXlnY29WN3M0akZUcjIzVWN1MFhW?=
 =?utf-8?B?eGR6aTJEN0NTNS9XRERtWG5pb045NEF5Mk9DZzM0enZPWFc1Y1FsQ1NRR0Q2?=
 =?utf-8?B?TnlvMk1iZDRGOTZ5bVAwc2Y4ZXFCUVVXbHhEZ0JjSWdHVkV2M3dNZkRKdDlZ?=
 =?utf-8?B?dmRXQUo5bXlXemRkeE8wSEFzVFFOeWM4cWE5blhDYzlHdHUrak8ycW84NU90?=
 =?utf-8?B?TWdCNEEzOTlidHY1WnlYZHROM3hYU2F1dHprcFNEeW93WFczMmJtcWhhaDRO?=
 =?utf-8?B?S0dSaDE3UzlnRW1ORTVQdUdpaU1yemI3bW9hSFJabzJxVk1KNFpOcXdTMkF4?=
 =?utf-8?B?dXFvRVFqUEp5bzFpNGlOWGp4UStVRkZPUEQxOU4xTTl3dTYzK3d4Y1ZURnY0?=
 =?utf-8?B?TVVtUm5LUFZVRHJDYkQ4TmpOV1JnOVRYVUVJUW9yUUZsM1ZkZTVrcFFlMURJ?=
 =?utf-8?B?TDNDTE12YVFJYlFGQy91elJMZjBHZHRmOVVId3lPbHJORUZEdy85T09nYVl0?=
 =?utf-8?B?UEcwTEZXdy90dEU2ZHZlQTUrWlFubGt3NHhKYmtNazdCWHc4UXpVN0JodzJU?=
 =?utf-8?B?Tkl4ekdZTjZLTzJxamNucHlmeFVPUWUxeDZkQVhEbllBYnRLdjFncXR2WWkr?=
 =?utf-8?B?REM1QTd0c0RSMEZrVU1aMURlNTA2UTJCdFRISTBOeGJYbmlUeVBHRy93QnFK?=
 =?utf-8?B?T0dhbkx1Z0RMcllVWlNGRUMzdzR4OGM4R1UwVXRTY0srWk9uVG9NV2JzZHFU?=
 =?utf-8?B?aXNhbnp1TDlGUU5wbkMwdEdTeFdOZlpFcXY1QXRCSDh6blkyU3hMaDgvOThS?=
 =?utf-8?B?bTFTNGVpc3p2MGxGWGpHWGsweW4zUklRRWJlcElPcFJSdmxDdTdHUlZRTUtw?=
 =?utf-8?B?SmJqOTBtV0MwOXNtUTQ2eGo5MWpMaHhMc1pmbm1MRWRQOVkrcitmejg3T1BP?=
 =?utf-8?B?QmhRM1BOcWw4RnpMU3o3N1R4L2N2Z2JSL2VDRnhVZWZDR1RGSXNhcWtCcUhD?=
 =?utf-8?B?SVloSkY1RUdMM3BiS2RkclJlYTVNdjRCdVFJSjhOMWFva2ViY3c5cDZ3cGkw?=
 =?utf-8?Q?xcoe5lUHSMG5B8pN1dtTogapf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Khu6INUgUxqcJ2eMFe2qkgFJZbG7V9/llndEkOuneiH8skQWjk5mTpvZq98uKNJOfT0vVGhq2P3ZUNL9XbqDYzPgi7l6kGosUKdpZxpLISakqt1/UnTJyJaxPcOdBGwl+dV99dV1xMj1Vo37SP+w0gHVs9BBCVA8dVx1KgNFYuF+67gW0LZUlvEkAxQxZJW9KCahC5MieomeO75EQUGZ1yrNK84C2QTrJTw4+rk0R29L8GdE4C56qmQ46PHtpNYEhjKpPOG5Ziip5EQFORP+iZ/GTDaLU2H57apA2DhEqGnSjHZxWGjjmsE9bxCtTGDnvrRwQxityAMNSxht8KmN1ZUSUhU7OLphBiNIilHKRxnWSrttsXCgrubh9HqN9Hy+ZXmvRYN8nff8NJqJNqL4/UEAHCJ5s4q86FhFfJppI3TtRLPQWUILadCsFZZnRdeuWPx++V1V0jnVgkdMAE6McnYCPOIHoRr4vBLgZzPMnAvDtbpXipQSA2Dmea+bntuHD4FkPYnNoJsrX9idz2uwQg+HZTBzHWuqEWnHhMy2N3Y6VKKe1+fejPs49PH5SbRPDb97ZqnW2u5IaIpgULL2u7MSM7DFl8P3ORzutAfIMsk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8654bdb-66bc-47e5-3d41-08dc333828fc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 23:52:28.0338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsOtGfanFPm9dpWbr6NniScqQ5CxbSKiw+oFwcDqCk0qIcz8ks9ZatzPLtPJdHQA7jmUbLGPZnzEpqArMTtevA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6366
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210188
X-Proofpoint-ORIG-GUID: E-Lke4RO-pX0VMnawbh_qsoHmMd3yvCK
X-Proofpoint-GUID: E-Lke4RO-pX0VMnawbh_qsoHmMd3yvCK


On 2/21/24 2:55 PM, Calum Mackay wrote:
> hi Dai,
>
> On 20/02/2024 11:58 pm, Dai Ngo wrote:
>> The NFS server should ask clients to voluntarily return unused
>> delegations when the number of granted delegations reaches the
>> max_delegations. This is so that the server can continue to
>> hand out delegations for new requests.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index fdc95bfbfbb6..a0bd6f6b994d 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -130,6 +130,7 @@ static const struct nfsd4_callback_ops 
>> nfsd4_cb_notify_lock_ops;
>>   static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
>>     static struct workqueue_struct *laundry_wq;
>> +static void deleg_reaper(struct nfsd_net *nn);
>
> Nits: If this is actually needed (you seem to be calling it after it 
> is defined?), 

Yes, it's needed for a clean build:

fs/nfsd/nfs4state.c:6554:17: error: implicit declaration of function ‘deleg_reaper’ [-Werror=implicit-function-declaration]

> shouldn't it be with the other forward decls around lines 84–89?

I'll move it up in v2.

Thanks,
-Dai

>
> cheers,
> calum.
>
>>     int nfsd4_create_laundry_wq(void)
>>   {
>> @@ -6550,6 +6551,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>>       /* service the server-to-server copy delayed unmount list */
>>       nfsd4_ssc_expire_umount(nn);
>>   #endif
>> +    if (atomic_long_read(&num_delegations) >= max_delegations)
>> +        deleg_reaper(nn);
>>   out:
>>       return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>>   }
>
>

