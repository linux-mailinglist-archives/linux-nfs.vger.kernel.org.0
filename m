Return-Path: <linux-nfs+bounces-10344-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E970A44DF6
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 21:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3EE3A17CC
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 20:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7986919F41B;
	Tue, 25 Feb 2025 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TGbbN1cY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d96FEZG3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A167818DB04;
	Tue, 25 Feb 2025 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516196; cv=fail; b=UYUrFhi/tTFe9eunXUi/3DBUOfBqMPVYQuOQbXezR/qHi+qUsMP1703Mgvnz5gJQUo1IjC9FhxvW23BJw2pFkRfiAiVXn52/PztoFJD6kJ3xxaGPqGeTzbmcRrRC0LfpsgD0wy8l70DtsO2q+DBqoeNyaJ+qWV86YCefnGx4Auw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516196; c=relaxed/simple;
	bh=TrxcXRUdqn3fgivRxZCFqKt5AIjqvtmvsjTCVduBdT8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AMHmO3L4S2apnXJ76BRIrVJxlxS4V6MM+SX6f9leTBwkUsRIXPPrZX9PvYM+RBh/Fojr59Wvg/Ay5LRodLMYnQlNQxQuRceymAaVh9jl4UEFnIGhPxmEJvnCzY6S0VaLN/P9XqJm7w5fa1A8ofJsoS1Mdwo83WHfGbjhpundllk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TGbbN1cY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d96FEZG3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PIXd5E015982;
	Tue, 25 Feb 2025 20:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hHw+H1qe0uhSSf1VSkXOLa0a8PtUSiFJhZHCJeozJw0=; b=
	TGbbN1cYIFgjvEc/SavRo/KPdIs0wyGKl8jY9pIxHavHzbzu6Fth3RBmjCqez9Bt
	eFE6mkL0EwEKDh/6KrWl4xvdWUGXA5kaSX05/rfvy/xkX4rq607jwG9GnOA8n2EV
	oSjafHF9FUeJh/9MnRIpNhdOdgtCbjH8ULCPeCy5IEJUSgsg7BdS29XKkmgyMk2z
	5kbjLJTQIxjEF+S0E8YQ4ooUCrZWa3hVDbH4GGRbb9BgFAGBeixskP7GrqC3pxYW
	n/GtueTr/AD8hbc9N3Z4n8q9Twu220EqNqXv8T6cxQU3N35s8jK4bnhzL7h+OHmu
	DcsuNgATMZrRaZ3qUO1/fg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y66se86f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 20:43:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PJ7Ehh010098;
	Tue, 25 Feb 2025 20:43:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y519h3eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 20:43:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UE0AXCiUPceKnIsq1pdZi8bflk3SZCn1myqx1+wXFO0gsNcZUvNXTjaNWVgTvKFSeU9kBTGrLHgbySdwmvaIAWIUNBK4ceMAX0VBdkmSLbGmGXKBaMxEIKmgl3JEBPT8972nmO54yRk2Xr7SCyBMyby6x9U0Sxe5asX3BNWjXkTufq72IMeq/gwbGlkAvNYZDCIIIsf2GZxEL6Cdiew3vic79sh58gk20Gd0xCKcHgn3Q9y+dZ9hTmfYuvA3jY7lbjEYFdbsp9TO1/+vFB5mblwwo9OYAuL5WphiZA+if41pqTWbpC9D6stBFhEV8uVzWpfL5XSeGSRfB4C7FODrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHw+H1qe0uhSSf1VSkXOLa0a8PtUSiFJhZHCJeozJw0=;
 b=FZWGoW0q1IVZo2e04KMvHroUO5jSnZYlc3nHLF9FSn08htSBWiHcMKNEx7PUJiGc4zCYU1qtbbA1LyJuFwWAPIFt9ZGMavqJRUQ8vI6OM1yl8S5r+VDPllsDZ9BeSrlQKQPmEUpZu+x9tFx7J/4UwfGI0bPnwk+tkEFK+gYQZtFxCND4W6H9MxO29Q9YM/yn3QyT0bwwc6RDhPVf529U7KyX1dfQs+V3+EjsDpjhwGZISMH78wUCVNDEGwwKMCY5er1LuW6o60q9fRWs80SCJdudLbJX737m6tjfv8U5J0G+wmBU18Ts1WjDRj/yfIm1r5AP1+6zK2fXcB+lz1nDMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHw+H1qe0uhSSf1VSkXOLa0a8PtUSiFJhZHCJeozJw0=;
 b=d96FEZG3xv5LUyeg4OhKca7e3+HFqkC7dmf4M+/6u8u7/86zWdJgMBUkuiYDnha9OFOuP6NWm9WdLiHGLxWwE3AOV5q+52DRfwNkzQT7mF8RqJCiQIxuOEdFQN5umWdYtpXCktxbu4b85KGB2T0Pc0BYlaItUVLwjv/m+gMTziE=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by SA2PR10MB4571.namprd10.prod.outlook.com (2603:10b6:806:11d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 20:43:04 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%3]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 20:43:04 +0000
Message-ID: <9dd4a808-3f02-4978-8d51-fbfca5676991@oracle.com>
Date: Tue, 25 Feb 2025 15:43:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm,nfs: fix memory leak of lsm_context
To: Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org,
        casey@schaufler-ca.com
References: <20250220192935.9014-2-stephen.smalley.work@gmail.com>
 <CAHC9VhTXzweNA+h37ZBMjymbuar32tmr4aa9Qphk8JM4ya+y0A@mail.gmail.com>
 <CAHC9VhRp1Q6VsYNPmcQ480j8FLamSkMSj=HzBU0MuikEbgQvRw@mail.gmail.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAHC9VhRp1Q6VsYNPmcQ480j8FLamSkMSj=HzBU0MuikEbgQvRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:610:76::11) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|SA2PR10MB4571:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ee4f23-2884-44b8-37b1-08dd55dd006e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zmhic3J2VWoxbDBOQTJ0cld6VXJISmRPc3dsQ0JCZmh0WWp3akUxeEZLTFVV?=
 =?utf-8?B?QjRvdmxkckx1dnc2eU0vSGZGcktBN3NnQnpiSUFCTnF4bWgyaVZ3bjQxSjNN?=
 =?utf-8?B?Uk5PSWxhMk0wcmxuZXprWVZpdVdaaFQ2aXFXRWM0eW5wczkvU0Z1aEJuY1RL?=
 =?utf-8?B?REhYY1dDbjlvbDNHcTVkb3UvM0plZmF6d1k5eURpMlRJcnpKbVc0MWJwR3dZ?=
 =?utf-8?B?UkxncHJMbVBmbnk2bjFlc3FsdHY2OEdIUm9uckZXa0h5Q2dGNUdlVXBWdTVE?=
 =?utf-8?B?S0UxRTdYUmJqdGxkTGdWOTd5YUU1UE9OWDAraHRycjV5RG1tVVdhZ0t2RENy?=
 =?utf-8?B?UUpod1FMOVlYYm80U3lGUGU4QTFUVTVkd2NtK1FTeEZ4OUhmL0NhRFZOUU1m?=
 =?utf-8?B?cW5FT3BaaldZdndQbnp5VnU2alllbzFidmV6d09IWU9iWnRuMEhuZkh0RG01?=
 =?utf-8?B?NWcrV2kyV1V5a0Urbm9pd3FCUFViMENtU2hkOWFpOHl1UU9nbUdDbnpXUnBM?=
 =?utf-8?B?M1Y1Si9GMTZEZmx6dktlNDRYOVZjcjZiU2d1NGJHRG00Z1MydUtjckxsSHNz?=
 =?utf-8?B?YTZGWlpJSU8vNGhwTFFUcld4TUdjMjVzR2tKN2JFb1l0QUFsTk55dmVSa2to?=
 =?utf-8?B?WjBkbmMwaGFvY0YrZS8yK2VhbHlaOXJ3NmhkSnlUcUV5TkF2R1Izc1lMSXVV?=
 =?utf-8?B?bEl3T3IzN3l4QzFPZXVSVU84bDJwckdQaUdldFhKdnd4dVVQOE16UHFmNElL?=
 =?utf-8?B?S3JuRmhFenJjOVVVYmJUL3pyKzRSRXhvajNwVVBxNE1GK2d2UnZGRTJaRDhi?=
 =?utf-8?B?QjR4TGlWNWNPMmdPWHJlV0wyQXdUdU1CRUhTNUhhTEF2RHhZWjVIVkc0UHoz?=
 =?utf-8?B?SjhTTDF1YWhVSGZ2SHhySGx4UzR3Y2dDTUZwaUx5ZEhSUnFWemtyejZ2Wit6?=
 =?utf-8?B?UHFFZ2JGdjhlc0xWTnI5V0R2YzQrdUowWHZYaW9CS1dwc20xRUVNcFRxNWFt?=
 =?utf-8?B?bGFYKzl4TGN1SmRtYWExTzJGaGErVXBtR0lZUkdJRjRZUG9kRUYrUEdzRUpT?=
 =?utf-8?B?ZTRtb3V2WHFGSGZiUWdIejBjaDBGTVJybFh4YnlaUld4eitTV1c5MGhCR2Rj?=
 =?utf-8?B?R1RNcWRxcVhzUnpMc3JsY0hLWnJjaUZTNHdJUk5Bb1lKUTJZaHZ0bGx2L29n?=
 =?utf-8?B?S21RLzFBWUxyRFg5MFNXSlJBOStDdUt0M3RhbEtnT3FMekpTK05UMzFwc3JH?=
 =?utf-8?B?VkxkODlQMjN6SFBNcjFFVTd3c00wWlVHMGRCWGpCUUNrWFNUSE5DL2FINkd5?=
 =?utf-8?B?eER0WTFjdXBCWHFnZXB0VVVVY1RFeFMwdTlXbmZmZFJocDRnb3dwV002WGlO?=
 =?utf-8?B?cWd4dXNxSkc0TnA1NUVsb3VpdWsvUEtzZzhIN0M0b1RoNitMZkV5Rm9CbWhS?=
 =?utf-8?B?Ry9nd1FWaEVkbW9BUk9haHZjcTV1Vyt5V3JGQzl6TVRtOFo2Z1pVT2lNTUZx?=
 =?utf-8?B?SVZHVXhTeUN2YjlVRm9IbTVmeStIRWhlOFY3RTExdjFZTkFlSEhHT05mU2tK?=
 =?utf-8?B?dVNuTHpHZHRQWHVzbFl0NFNkVlpZYks3UEdJbCtyUFFTblJWcEZ6LzN6QVo3?=
 =?utf-8?B?S0Fmd3l2YlgvK1dVMitnOFhVaVJyaFM5VFZKdTVSRzV3TGcyQXJFU1Jway9z?=
 =?utf-8?B?Um1hR1ZvOTFpbEVDaXRMeXdBTjIwY0lrekZkdHM2Wm5saXVJTjdIVzJDK1B1?=
 =?utf-8?B?WHVCOVIvZGwzck9scGpsMS9DY2w1TjE2ZEhrOGlFOVVBS2ZtOEJLSm13YWtp?=
 =?utf-8?B?UzVzTTlhS1FqdE5ENEdZYjVJMWZNcyswTnc5SS9FMXdRS3NQMVB6TDNneVY5?=
 =?utf-8?Q?bDebTLCQXXFvg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0tpMGd1Ly9ock1OWitJdXpJTDJnc3BscWdoeUpjMmlGVVVRa0FLQmhiMHcv?=
 =?utf-8?B?MCtWZThSSTYxNDJNRlpTS3hkVzJNQjIvTUZoMHpVRXdTWWxmeGxTdTRRWXJq?=
 =?utf-8?B?by82MW5SL2YrakRZYVdpWWxEM2FKcms5cnFTTGxJdk9tQTZxaU1vQlZXU2FR?=
 =?utf-8?B?ajRsc2lPZ3BvR2dzalR4ZXZzODIwNlUyeElWUDUvUmdXMG5CUFllcHhMc3Jr?=
 =?utf-8?B?b0N6Yy9PM0ZxaEI5NlJ5VHQ0aHIwYXRZMnpUZGp3a2pQTWRXTWFzdkJ0NnJy?=
 =?utf-8?B?RGdvMTNEaTN6RWtkVDNzK1NjdVMzeGRBWG4vN0prK3dJc0RYT25URDcxL3Ns?=
 =?utf-8?B?b3R0dEhqMGNZaEU3YnpOZkpTVGxwS05uOHdFRXN0dlVBYU1hc1g3aFFnZEVj?=
 =?utf-8?B?amhKUHB0R1hxaUNHNW03ZXgrYTRWVkNOUW0vczk0Mkw3dHJxbTdteEZKZDkw?=
 =?utf-8?B?dzh1UUtubUVQTVZoQmJvVnBTM29iZEwwWWtqMTh3YUdvRlE5cmRjdGRhVTVC?=
 =?utf-8?B?OFFCR245SmFDaGQyVFY3d1dyQ3dYNDVHT0dOelhuR1ROQnFUZy9SOTlsbFNN?=
 =?utf-8?B?Z21FZUx4d253cjdlZHh0U2EyNlNaWkd0cGN1UVFVSnNyRnJCWk1BL3EzcWkw?=
 =?utf-8?B?V1BYU3creVRXZGluUitGKzBkMXJBSGhjMEpYWVp0ZCt2L2VwMUcrVUg0c2Q0?=
 =?utf-8?B?LzlsMlA1eDNzZjVCYzIzd243K1RzTzVIRjB5U0s1dWJKN0RyR2tVam9WRjJ2?=
 =?utf-8?B?MnZIZzJOU1RUa2JCb2FtNU1nTy9oczYyODc5Y2ViaGFRRWRkdTM3RmJNVTVT?=
 =?utf-8?B?N29YY0JqdWZaNHVRZGZzOVV1QTlaZEdnSDZmeVZ5RWxKbmkyVzRKZ2QxbG04?=
 =?utf-8?B?MHJhSC9QUk5TVlJLaE9CSW5wcEVUM2pqNkZPck5ncVNJd3FmVnBQTm9Jb1I5?=
 =?utf-8?B?Rk4ybWRuRlN6b2QyYk1pcFB5M0cxaFJDaWFYY1hFL1BUZGIwSjJNeUJDQkZN?=
 =?utf-8?B?Ym1hb2dmTDZrT09IZGlCWUxKYjdPMks3aU5IZG40alI5TkN0VkNQSWFFN01B?=
 =?utf-8?B?NWFZaUVuQlZpL2hhb2RHcng0UVpEMFNvRGU1NEp4MFAyTVl2K3ZFdHkzbWZO?=
 =?utf-8?B?eForNHpwZCszUVg1NlNaL2RPY1RIc3pVVmRtMFZUSUIwVWkxTStta1N0cFZh?=
 =?utf-8?B?ZU15aG5YejJnZzNjbzNKcThlaEN0dmZPdjZPZEt5NHJ5OWFSV045Uy81Y3N1?=
 =?utf-8?B?aFhaNVVYN1Z2Q2VPUXFZV0JzeDZiL05IQU51eDNrejR4YTNwWVNzK3BPUWFV?=
 =?utf-8?B?NEZNaDdwVEpoaFZ0TGM3NWRaTHNTWmE5RW9yYTNqK0NtOXh4RVhsRU5ZRDA2?=
 =?utf-8?B?Zk9wVTY5V29qSDZjdzcwczViZkJKNnJkbXcyTk1FZ1l4ZG03UFVidExYYmJT?=
 =?utf-8?B?Z0tPTUo2NmNLQWY3Z05WU0pHWUFaVG9YSW9uVUxPMXNTSHU4YjhnTUFnWTIx?=
 =?utf-8?B?bjJIaE8wbjFhaDcxTWdsUXdjU3NsU2VZdTJPcHkxdlJMTldlVUpuL3ZKOXYy?=
 =?utf-8?B?MEhpWS8xcGxYN2dlTElNQTMySVBVUzlLNnBFSjR1TmJWK0luVFhoWjdDU2FJ?=
 =?utf-8?B?ZnNQQUJOTGp0a2tFQkxld0ZlMExuRmVjcDYxeTMyaUU4S3I5eXZLenNEWWhR?=
 =?utf-8?B?eXVzM3MyclV6Vkl6c0JHWklEMFA1L3BOd0lRQ1Rwdm1aeXpDenJJVmc1b0FY?=
 =?utf-8?B?U2sxNEI2d2Y0bWExNkR0MTQyV0hJU0RZalFDMXRWTjN1b2pFRGpTcEdEeGw0?=
 =?utf-8?B?NmxEbTk4c1ZabThGUkJ1WitYSnNWeEdHc1laMUhLTmRwVFNwOVlmaVh6eVIz?=
 =?utf-8?B?TVFXRGNIY3Ryck94YlN1T2lwWlN3UXI5d1FKL1d1dWszUHdnL0xJQ3VPQnUv?=
 =?utf-8?B?cG5XcGhjSVo5WW9OVVAvYlJWeGZXTjc3VFdCeFRoTHplZUFIQmNCRHAxckRR?=
 =?utf-8?B?Wi96ZnluVmNTSnZZdUk4YnJvQUNqbFQ2QjRHRDV3ODlTOVBOMkNNaVVrUXph?=
 =?utf-8?B?bFJtbldCellHTmFIeEhDUEZ3ejg1R3YwSVYzaXN6bjU1Y3JFbzlzN2Y2bFJ2?=
 =?utf-8?B?cG1qV3NGK3VZZkF3Zis3ckpBeUw1Nk5Uc0VrU2tBL2FKVFJJbFEyS0w1V2t4?=
 =?utf-8?B?bGwyd25icVdlWkxseDkvZVBWd0svT29NdDkxOFBzK1pJUTZuV3NISThLREdv?=
 =?utf-8?B?SGlZY01mWlh1d0dPc1pjdUtOT0l3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GtPQxVgfhR5MjXzSBG3FZM5zFrbLqQOlmKKn0sq5f6FeDiivZ6hzLtmQIFmISm/CqcPhoTOuvrw2dVzwWX6vW4PHJ4Ua1x4v6CmJifdC8gx+rkWX2qexRPLFq6G1BtkfK7uXq511vWwM4Q1oyAQrtAxdvIHUn0s1SCyhsLlvoUQOxtIasRE1o40YfWSBpgzCRzM8kR8bGgqeB6JAA1NlaKOXe3znILFxArJ6s/40ZSamWbHl4/s1cyZGkpBiIu4PuO52XSHOor4arQ5d6+z02d8p3iPy1bjM03dMOFquYND19GKjrSFicUQ7tOKOKH1KZ1TRSnFPAXdjJb7REUgbT74iyUiXu5wFlRDQQNUONLDexNdJajeXFadiKbDCtKweTkJr6TCMXLXo+54v9MlbVZSE0zyhYOs8m9czK0uWsHtnq4F9TBF6TOkug2JI3VYVYQ/3N2PSBGu3zpS26PmrzXUVRlvftvHIMaPc726pPCv3HujYnw03lfh+iVBuDYLaZcla8HW6jjvbAZR0K4CNvu04+ZOdd4gGvLVuWXWlSXMx3HoP+j2soCdVDM2ShjeDxO+QobAZglBWbAqaeMVlzWZoeQyoMSjWAhdcgkh/xm0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ee4f23-2884-44b8-37b1-08dd55dd006e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 20:43:04.1202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcGXXoy/TFw5A4eUMJWnG0LWyWAy9in6XuN8XskYhFQ/5WjJBJah6saq3xavQkNYQckLLzgXZsP5Z5nn8gvJ5ROfuCvtQb4IQbFCSLGqPr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4571
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_07,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250124
X-Proofpoint-GUID: 2KcwCccXo3F8z0PUaGazsnGvtnkxtrUp
X-Proofpoint-ORIG-GUID: 2KcwCccXo3F8z0PUaGazsnGvtnkxtrUp



On 2/24/25 9:44 PM, Paul Moore wrote:
> On Fri, Feb 21, 2025 at 3:10 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Thu, Feb 20, 2025 at 2:30 PM Stephen Smalley
>> <stephen.smalley.work@gmail.com> wrote:
>>>
>>> commit b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
>>> did not preserve the lsm id for subsequent release calls, which results
>>> in a memory leak. Fix it by saving the lsm id in the nfs4_label and
>>> providing it on the subsequent release call.
>>>
>>> Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
>>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>>> ---
>>>  fs/nfs/nfs4proc.c    | 7 ++++---
>>>  include/linux/nfs4.h | 1 +
>>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> Now that we've seen Casey's patch, I believe this patch is the better
>> solution and we should get this up to Linus during the v6.14-rcX
>> phase.  I've got one minor nitpick (below), but how would you like to
>> handle this patch NFS folks?  I'm guessing you would prefer to pull
>> this via the NFS tree, but if not let me know and I can pull it via
>> the LSM tree (an ACK would be appreciated).
>>
>> Acked-by: Paul Moore <paul@paul-moore.com>
> 
> I realize it's only been a couple of days, but pinging the NFS
> maintainers directly in case this has fallen off their radar ...

Thanks for the ping on this! For whatever reason, my email client decided
to (unhelpfully) put the rest of this email thread in my spam folder. I've
applied it for v6.14-rc.

Thanks,
Anna

> 
>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>> index df9669d4ded7..c0caaec7bd20 100644
>>> --- a/fs/nfs/nfs4proc.c
>>> +++ b/fs/nfs/nfs4proc.c
>>> @@ -133,6 +133,7 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>>>         if (err)
>>>                 return NULL;
>>>
>>> +       label->lsmid = shim.id;
>>>         label->label = shim.context;
>>>         label->len = shim.len;
>>>         return label;
>>> @@ -145,7 +146,7 @@ nfs4_label_release_security(struct nfs4_label *label)
>>>         if (label) {
>>>                 shim.context = label->label;
>>>                 shim.len = label->len;
>>> -               shim.id = LSM_ID_UNDEF;
>>> +               shim.id = label->lsmid;
>>>                 security_release_secctx(&shim);
>>>         }
>>>  }
>>> @@ -6269,7 +6270,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
>>>                                         size_t buflen)
>>>  {
>>>         struct nfs_server *server = NFS_SERVER(inode);
>>> -       struct nfs4_label label = {0, 0, buflen, buf};
>>> +       struct nfs4_label label = {0, 0, 0, buflen, buf};
>>>
>>>         u32 bitmask[3] = { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
>>>         struct nfs_fattr fattr = {
>>> @@ -6374,7 +6375,7 @@ static int nfs4_do_set_security_label(struct inode *inode,
>>>  static int
>>>  nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
>>>  {
>>> -       struct nfs4_label ilabel = {0, 0, buflen, (char *)buf };
>>> +       struct nfs4_label ilabel = {0, 0, 0, buflen, (char *)buf };
>>>         struct nfs_fattr *fattr;
>>>         int status;
>>>
>>> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
>>> index 71fbebfa43c7..9ac83ca88326 100644
>>> --- a/include/linux/nfs4.h
>>> +++ b/include/linux/nfs4.h
>>> @@ -47,6 +47,7 @@ struct nfs4_acl {
>>>  struct nfs4_label {
>>>         uint32_t        lfs;
>>>         uint32_t        pi;
>>> +       u32             lsmid;
>>
>> I don't think this is a significant problem, but considering that
>> lsm_context::id is an int, the lsmid field above should probably be an
>> int too.
>>
>>>         u32             len;
>>>         char    *label;
>>>  };
>>> --
>>> 2.47.1
> 


