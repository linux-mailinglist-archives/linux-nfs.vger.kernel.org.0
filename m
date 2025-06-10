Return-Path: <linux-nfs+bounces-12264-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1358AD3ADE
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 16:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A0C17B4F9
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 14:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145D42951CB;
	Tue, 10 Jun 2025 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jmGESxG8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wk88Q9nh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334602BD5A4
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564762; cv=fail; b=hK36oFE4E1v8QH4pGyKdj9qiPE1OG1v5knG8e6URzSXJ7+1gk97251oDIElIkwXjUxWxq4v+wXkaUG0LXAihgtTCQV2a/CXsCqgrzquJxZU2GjdLOTVoVk02vwz2+7jv4yJWxTJt9N8hbZB29M0tqFj8ZR5oVC+7dYhUVoAsZ+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564762; c=relaxed/simple;
	bh=XMBCe+YZIyeqLcrN/T72+Mo1Sm+D6KBjpljyqkQwoeI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QRbhJgUdjcYFZVu5daTUbiVftla4R+3B2NV/+XqrcBm/j3tUMP2JeXU4RPwktWmy8uWOlvhFCxOPVPsP3+zBcZ1mPhDr6vc9JfiBoaUTfYSr9kmqVht13Ki5kaND16ybSDsQCVxONSgmeSlNRiR8NYhvsMH2+h3PFjgarA6VTyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jmGESxG8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wk88Q9nh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADBeNE008610;
	Tue, 10 Jun 2025 14:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZA/DUmM5EdZaH8NWVPCUHH7cHhBYfLJheGOFIjyji7I=; b=
	jmGESxG838/LSDf90DBS4E3P3swjaPpIp9ECj1a2dzu9OGrg4rhDV4SqX1xS+OtX
	KQkT7e99KCbiKzPVQ7h/eFD7katxGZGCQ+w6KTZqcTjGPNYWrd2vsaJjhW1hcXGw
	WV7s6yIVzFiuwOHkhiCHQ65ymeySPGjr1wu08Dp/8/V6NeHyK7y5ngEH5a3SqBwv
	o22O22r/iIpx3R9AWYc1nn2znmmX7BGFc62qytnZrIH04D6gGd1ANYNaGXpr43hC
	Z8vhbrM5ZNJ+ilm+Yv6iXL5iLRKAZ2ryqlVH9BV9PGNwd55CKshZ/46h/dJsPi8i
	qmJs5ZrrILM2414J2ykBsA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474buf4bse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 14:12:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADrRne011797;
	Tue, 10 Jun 2025 14:12:33 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012047.outbound.protection.outlook.com [40.93.195.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv9s70n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 14:12:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3O9qtVkNakKQCIGy6mjnTP00XO1fQ4+FaicsJZvyWLGxPSSZEbC6j/The+c8s1vJpWmo6xM4N1UoYK8FU7UWQcqGZD2Kq4dGC4tZ0yHomQF2vj9gn4lCMcRAhaaZXV20/tUlQW6Ag9jO9tYNWkkCHIhvEUAacP0MSAPMKx+XbFMzlz5qfmR33ot+/BlyEg+GCaws/ktXH2RoRk8z2VUJEzfD5rpps6apOn5lD0XTs0sy7B0vU0nqnq7JD54OfXH8JSGjKIgRHnFl8SBQfTAyu19HqKNq955TNCm76YJZX9Tjw5440h/Ps4ahxB/t3psxFaQPPweeGDb+iGZmvDHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZA/DUmM5EdZaH8NWVPCUHH7cHhBYfLJheGOFIjyji7I=;
 b=wy3tBNh4HHewc1zqtcN3BCEi0P/4Pu0c1SLNqe9PnWeI8qnxTC6ffoVw2P2T6EHHSyOsqKgD2Fm5x2DQFGI9/EVmzEIhES1XXXxdb8WkuGIQKVYABe7hHyMMjFnAzQXfRR6sBGbT+nCV2GgmitRFhsRJyd7xMIvyYMLKc4P9c9M12Z69TG8quzM3l0UmcnxeUqE1YxULF7b5TIgqTcSzuPwtAq8T8kkY3LLy1fBivqVLdVl9yKj1+3xDar2uCFUmXPfINep7oXt3nY9IWlPCRiw5LnFL4A7en5RIwNuEfcc8GuJJiLS51tQXq41nW2bBlqSww4sZLKoq/VB46dLAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZA/DUmM5EdZaH8NWVPCUHH7cHhBYfLJheGOFIjyji7I=;
 b=Wk88Q9nhyQeK674sMogiAsMw98wfW9KOO82yl4nwK0Z6O+8nV3Il8JRIQqagXgxMb8cmrcm/ezL1ZILytsglphfgVaoXpMZ7E0iuvSdEJDFnn3UF2k68yS+tbf7q1ff9+8yQQ6I+bssa/zSGN1D9d8OQthzuoEtBsBZ6W5CtgEs=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by PH0PR10MB4725.namprd10.prod.outlook.com (2603:10b6:510:3e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Tue, 10 Jun
 2025 14:12:25 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 14:12:25 +0000
Message-ID: <34500150-e2b9-4b88-acae-aebeb1694916@oracle.com>
Date: Tue, 10 Jun 2025 07:12:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: detect mismatch of file handle and delegation
 stateid in OPEN op
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        neilb@suse.de, okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org
References: <1749562875-28701-1-git-send-email-dai.ngo@oracle.com>
 <f580a2f30274ca61f44d4b8d4b5e9779acd84791.camel@kernel.org>
 <6bc66030-adba-48c0-a992-82f7bbb153f3@oracle.com>
 <7993b2bf9c38041f8963e9161aaa25984b50d3f1.camel@kernel.org>
 <c187763c-09a3-4027-9833-a78244a4329b@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <c187763c-09a3-4027-9833-a78244a4329b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0004.namprd14.prod.outlook.com
 (2603:10b6:208:23e::9) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|PH0PR10MB4725:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb6f1d2-9895-4b3e-1bb0-08dda828d32d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aFRsZENHSFpwRnRpc2VnSTlKVFJ5UitKaUZ5ZlE0djNZL1Uzdjd4clo1R2Z2?=
 =?utf-8?B?SVdzRjBrMTFHdURwOUkvWjlWaXVEcW50MG52NFZUb0NRR0x4RE8yNHczcG1R?=
 =?utf-8?B?NmNDdVkwN1VLQnlZY2NwSEJQZkF1Yk9HRks1SzMyQjdEMFNCNHFhdVY4QUNQ?=
 =?utf-8?B?cjk1dEV5Z0luM01uK21jaU14OGtiYUYvYWdYMEgyUGRQR0pkdE5BWVpIbHg0?=
 =?utf-8?B?WDlHRVh4MHpQdWJMVGt1cG5uaUt6TmVBQ0RReXBRQUJnZGttc2dTSFdtVjly?=
 =?utf-8?B?OEsyK0hJL3ZrRnJkQzZFV2lNa1luRm1HeFBDTkNGbUxiQ1hDZzlOWlZKK0Qr?=
 =?utf-8?B?SHNRTU9aSm4zYmRyQ09aMHlPdEdyNnFDTWxKNlUwaUg3eXM5M01XME56SnMv?=
 =?utf-8?B?Y1NHbmVySkF6MlkwTFZiWkkwVlV1Q21laFZGbjlLTjVpRGEzRWVWVVN0dUI2?=
 =?utf-8?B?RTNtTnB0QW5GNHhKRE82MCtEWmpaOHpLZFZ2YnFML2JBQU9SR0tEWElBYUVM?=
 =?utf-8?B?VlduWmZISGkwWFNMLy9lb2VRVUtrME1rNkdnL3BlMmUrYlY0ek03SzNzc1Zx?=
 =?utf-8?B?M1ZVNnVVYnRlVnVpL1J2cWV5YTFSam5IUTBGU3AzWXlYYXRtWTRnbGpEUndS?=
 =?utf-8?B?V0pMY0QrY0lJZ1BjbkdTeExyaW5FZUZ1Y3ZEejdQNVJmeE1KZVFQc05YSGc5?=
 =?utf-8?B?VzU1YVAxZ3VIbFRpQWxjdXpCVllEUzcrdTRrMGEwV2NLdGhvK29rUEZRT0Jn?=
 =?utf-8?B?R0pncGZtdkF2bEEzdzg4Y1o0ZVFuU3lIVVE3b2k3dm50TFl1ZStwejhXUVpm?=
 =?utf-8?B?UE9QTC9OcG53K0Y5eHNaUGZLOE1uSHN6Nnh0WlZWWmRxMUVmNDZNUm9JSWNa?=
 =?utf-8?B?TXhuQ0kzSk5KYitvcENyN2ZuY3hadks0M2QzMG56aWlhMEF1Z2NXK0FPS1VY?=
 =?utf-8?B?SFFGVHR4U3FMWE5HajEydlg5Qlp3UTM5d21NdUNKR3M2QktLN082TlZNQUxo?=
 =?utf-8?B?bzgwV0FZTnJMd2hReHZROVVxZFozZ3RNMzFsdG5RbWN5SlpCaEkyWHd3aWRZ?=
 =?utf-8?B?aDNaYVNDYkkyZDNIRkhtdklUb1kyYkpLWGlzZmdTazNsbWJFSlFibkhMbmFQ?=
 =?utf-8?B?Wm9nRVV3Q0pyYy9yQkxVaVhVQyt3UXpSa3lOdTVtZzRrakN0Ylp4OXlJV0Fi?=
 =?utf-8?B?V2hOU284dTRkdkxlOHFnNTk0NnVabjJDRThML01PYlYvZFF6Rk1iQ3hGT3JK?=
 =?utf-8?B?aUpuWXdDM0RCL0NTRkZaNmdsWktmY1lYMjdJcFJpeVkxRmhaamFZWDFwdHFL?=
 =?utf-8?B?R1RWZmhWUHhCMllzallWUDlzTkQzUjdZQ1czTUJLK0dVOFVaRm9ORml4cXRr?=
 =?utf-8?B?b0dJYm50RVdDblpKbUF3N0RaL0phOUtSYXhLOW0xZDFzZ25hSC9Sa3dzaStF?=
 =?utf-8?B?cERnK01Manc4UEYyVkxrYWxpSnF5cVRTNnlaY2dUZDgvWHZQYmVNRGFFaDZa?=
 =?utf-8?B?U29xdnJ4Rkxlc2x2dmdwU2FhZWovcGxEZ3FHeDBlMHBMZTBPandlbWNsTU1V?=
 =?utf-8?B?YzRGMm9oQWdUWlNCYTlEYmxlZlIrZ3pJVml6dU1YMmVqSmFXMW5aVFc2Z3Uz?=
 =?utf-8?B?TnRBcUJLek5kamE4aGQ0bS9yWkZkeXU1OVBtczNPaXpSSG9RcGVvM2ZYUmNP?=
 =?utf-8?B?VXlrMEFZOHk4VGRnaFNISUIvby91c0VKNkNicjZRbkkxSERPR0R2Y1pydTFZ?=
 =?utf-8?B?OWpjQmg3cUc4NmNoTWVnSmpRejlzWldKbkljczBOMzM5ajh2U1R4NE8vWHB5?=
 =?utf-8?B?THRQSy92SDgrZHQyc0dJVmlwUi8zRytnL2hSSXJSM0NPUGRML3JtVjJwMGRa?=
 =?utf-8?B?dU9QMThtT1ZtNTFiUllmc1lZN3J3WnNZdnV0WWxlVThOZmwrWGYvT1dEdXYx?=
 =?utf-8?Q?w/IBheCpHEg=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?a1ZmcUg1UnpZcjRMOEpnSGNCQnVKcE1USHdUak1HL2srNytMcW9yQkwrd0N3?=
 =?utf-8?B?Rk1aeXpOVzl2QlZmbjRsUEhvSXpVc2J4TkwxS0pENXRQaTFKNWpsSCtabkMw?=
 =?utf-8?B?NzA2UzlGd2JhOGtpb2VWcWVUWE16S2IvSlBkY08ySGkzdk9PTkVDMy9HNWxo?=
 =?utf-8?B?WUFlci9uajlhcm1TWHlwOFhVTmJCa25CZXlpWkI4eDVIYVFtNThlZVppU2Mx?=
 =?utf-8?B?L2RKRkl1ZDk3VXhlb013Y0thcGVzNGNkRGc1TlR0MENwcHBmUW9aMlVTdGNW?=
 =?utf-8?B?ZC8zWWFmaUh4ZUg3dU9acnhMSnZtTUU2eGp6ZUJhd1RPb1B0NHN0NWdDQzJq?=
 =?utf-8?B?ZjdleUI1QWhxN2t5RkJQSk5lWmk0QkpXcWE1Q0xkdHg5K085dXNraitic2sv?=
 =?utf-8?B?K1hDMjNuMWxDRVJCL1lJZFZLYk9sWk5jbkc4cGVqUFJmRHBrVkhvZDFadmhs?=
 =?utf-8?B?dVZnUUE0VndvdDNKMC9UTHFyVlljWHR5STJ6ZnduYUNWQmx4WnU4ME1kVzQw?=
 =?utf-8?B?alBZT1ZaWXB3aE4zSFlIZU9SSmV0bkk1SmFCMlhoelhPci9jMTJHYXhaWGRT?=
 =?utf-8?B?Tm5wdWtZS3JTY05wTk5ZT2UxdHlJZ1BFUGRjaWVKQlFmUGsxQWd6OE15UU9w?=
 =?utf-8?B?ZTJka1BKSXZSRzhjT3QzczVQQXBiYTVRWUw3WWxZRTZ4WnhpU1J6alFXTmNk?=
 =?utf-8?B?U3MwUzBkcnJPK3BOa2ZQQ0xuM0JabEE1ME5zcnE1Tko5UlgvenJma1pybjVx?=
 =?utf-8?B?Q01qN2JHMVY2S0VIV2RzVWRFbFVEL2VPSXZEQjV0a1FkY1lWdnRTV2YrL3c2?=
 =?utf-8?B?UVNaVWh4dGZSYTl2bEFGMU9QLzBVZUtFZk9lRlFMTC9Lc1dLeWt5THJhZlNu?=
 =?utf-8?B?L0RCRUc0V0FOYytNVTQxeHlnbS9mOGJHZWdpcWxjdndPOGxoK0ExZVc4anZv?=
 =?utf-8?B?VDdXRkFyNU5YeW5RNXhiOTcxNEdiSnhUMVlHKzF1R2NFSldXNlRNeGJrNHpK?=
 =?utf-8?B?a3YzQmlWcTQrcXNpQU5FeGp2TURtcUFhYmk5Q21Ua09ocG1aL1dqczdDTVIr?=
 =?utf-8?B?N2xMTGdQYVZSRUFsMDJadUtWeW9VUUVZcTVtRDJMaVhsN3VqUmZzVFNjWUR0?=
 =?utf-8?B?RFlYRldNeTY2QXZZc3BSbXZUZ0M2MkNaeUZvZjNRS00xTVAvZks1cTlDY0lq?=
 =?utf-8?B?d2VCSGNMUGJienFqVEVHYjg4QnlpMVRLcmdLU2gxL3dLOEdKVmVtY0xTSDVD?=
 =?utf-8?B?NXJkM2dlbXU2Mmd5ZjF0V0loRy9sYnRsR016eVRyU0plRmFBRTFQTWxVLzha?=
 =?utf-8?B?MmJUbEN3Z1NQakdnY2trMkNQYkZqbkFBOSthTmxOZXhnQWd4dU9PNGUyTTh0?=
 =?utf-8?B?UW1lb0RmeTVGaENmRWp0TVhmWUJZZ3UzclNxMjNUK09DY21SU0VmOFZkYVYx?=
 =?utf-8?B?bWRJOE5TcnMwbFFsT20vRzJkNTJyMGRST25HU3Vtc29pTytWMCtRL2lKd2xI?=
 =?utf-8?B?VjhOYUxiVHNGNTNHTTNlb29JbHRSd3BhV3Y4ZEVER0hRcTRCb3hPZmkrYUhF?=
 =?utf-8?B?YjhiWjdCbktLSmtXcnpVNGU0RDgwUys1Ym5oMW9kWlcwN2FibFltYmdSRm9E?=
 =?utf-8?B?OHpoMWtrWFNscVBLZ2NaWU4xYWludzA2SmVaK1QvVVI3b0RtWm5zMzVzd0d6?=
 =?utf-8?B?Lzkvd29rSy9jNnQ0aytCaXAzMHZoRERJTlYwSGtMRTBicWliMWdkSWg1cGQ0?=
 =?utf-8?B?M2lsQ2ROenUwUEdrcFlBQkIrV2ZkcnVQYXBtSm1iMmZFeHJwN0dEN2ZlMHV0?=
 =?utf-8?B?ZVdocWNJTUFGN3lwNFE5ZFlpRVFhQU5ZaTVPWFNnS2JobHpTUTdVdHhCeXYv?=
 =?utf-8?B?N2o5aHdXcE9GM2t0ZGFObGRWbmZJZGVqMTE5SndDM2FNZHhNQzdDT1B6V0Yz?=
 =?utf-8?B?eEFwdzM1dG5VcWdxd1N6c1EzcHMvLzhjZ0xvTXFjc1NSU1hONnkzeE9WVENN?=
 =?utf-8?B?emRnK2M2UmZBWndHY25pOFcyN2xaWnFGaG55cU51MGF6Q3I4bzNtdldUcXJD?=
 =?utf-8?B?Rzg1TUV4WThkUmEvNmpObjEvWmQyTHhFbXpaYkJVMXRYSFB4ZnJWNHNnK3RL?=
 =?utf-8?Q?2+RuJqmzSlib/1msAapRedKgM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AMb2U6rCWFNwiICLxZirbm60WqdTgsqkH8ZTxIahRGDq8M0AU8SeekBaRKEGAwufBe9lzEc0rs3hkFTB5JxCR/xDuZnWvAL/xfTWAf2ZXI8Vgq6MdGTx50hFAV5Na6a3RmEpgeY8eSQoTaGkknzksaC2a33zF/2XOrT/r1B2ezJvsq0DOnfIFTbvftmKFrvivWvWFg0lA3PjtypdLeps/yC8psdI8yZqzgICovjR8b3cMOoErgjYVcJKMx4ToR/3VT+IKqUwZPat63sU47H/2oMRvWkeQlrzQhxUSSorpeJW35rvLwgZ83euCHWd+75iNUEgG4L+d01oPsoFlJ875g3fi+WPorJUwCrsumcoAXujTyIwD2xf75mdwvzGhwtDovw2Rj3yY6y6n4xrw2WzGWwNC0e7KCmAjp5VM8Lrz1XAv/l5hVtozwO25PyuhLqljl0iEay3pHtyx6OCV6LuKo52en+YLrm4Lozc5yScwxeBmGPEehASpjrhuaxgz7antzwj/7UBYyJWdRrh2EYUSiJWWQLUJwYPgKOW2FTBUMB1vq5yR0gWaQyr22rMGWSaJe0GR9n2PyBEhTcBTkHHlcw6lbDN1/ko0N8Alxm598g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb6f1d2-9895-4b3e-1bb0-08dda828d32d
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 14:12:25.3775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5hcZjdpdfPB1AvLWl5gVRoC2gbgl7Fy0l+Fm4qHZOEk+GYtju9TH58am706H6REsZP0Kcua8ii9NVvBqd12Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4725
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100112
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=68483d52 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=wylpmZp2VGsy62UDoTkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: OiJLWeeDsh0cgB8idyIaQf5inWZljHWi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDExMiBTYWx0ZWRfX4M3IR5+MXYJZ ZEAs3gB7lpZlsgHoQ/Y9tsFqG2tkZ/qjZheccq34VOxU7zJ8nlooO05cuZ5KOSSxDDfranlVhv8 LPVI+IoBU1xYo76O59JONGQ3rhIRq6SPlpGLHkRpUPlbLVpbGAYg2ns6UHKdWCGXSbrEp28Fluv
 MdUeq4G9BLoSZL6xGB2PjUR0ODsNvF3bpuqDlkYLu1LTRao3RBj0XzZ6DNvH6MO6jyPu/IPCbpv xaY+UEdGlYXpomYaeVdxuZQAGKEHlqcF+dhvk5xwqqofH4MGUa+HlamBYgQJLFQGDvV2jPtHQVf WXOH0lapoOyK/SYyX7ZW8rSSS5w6adA4eM6uADE5OxDKT8pJGlTFD5o4YHBxU88UR0etyTySBoT
 +QyDAjwQdu7uf1qZH3y51o5Vn+tdfmPloHyNwqT2TditmyRWDiLcf6YcUQeMSEgHY7hiVfMw
X-Proofpoint-ORIG-GUID: OiJLWeeDsh0cgB8idyIaQf5inWZljHWi


On 6/10/25 7:01 AM, Chuck Lever wrote:
> On 6/10/25 9:59 AM, Jeff Layton wrote:
>> On Tue, 2025-06-10 at 09:52 -0400, Chuck Lever wrote:
>>> On 6/10/25 9:50 AM, Jeff Layton wrote:
>>>> On Tue, 2025-06-10 at 06:41 -0700, Dai Ngo wrote:
>>>>> When the client sends an OPEN with claim type CLAIM_DELEG_CUR_FH or
>>>>> CLAIM_DELEGATION_CUR, the delegation stateid and the file handle
>>>>> must belongs to the same file, otherwise return NFS4ERR_BAD_STATEID.
>>>>>
>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>> ---
>>>>>   fs/nfsd/nfs4state.c | 5 +++++
>>>>>   1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>> index 59a693f22452..be2ee641a22d 100644
>>>>> --- a/fs/nfsd/nfs4state.c
>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>> @@ -6318,6 +6318,11 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>>>>   		status = nfs4_check_deleg(cl, open, &dp);
>>>>>   		if (status)
>>>>>   			goto out;
>>>>> +		if (dp && nfsd4_is_deleg_cur(open) &&
>>>>> +				(dp->dl_stid.sc_file != fp)) {
>>>>> +			status = nfserr_bad_stateid;
>>>>> +			goto out;
>>>>> +		}
>>>>>   		stp = nfsd4_find_and_lock_existing_open(fp, open);
>>>>>   	} else {
>>>>>   		open->op_file = NULL;
>>>> This seems like a good idea. I wonder if BAD_STATEID is the right error
>>>> here. It is a valid stateid, after all, it just doesn't match the
>>>> current_fh. Maybe this should be nfserr_inval ?
>>> I agree, NFS4ERR_BAD_STATEID /might/ cause a loop, so that needs to be
>>> tested. BAD_STATEID is mandated by the spec, so if we choose to return
>>> a different status code here, it needs a comment explaining why.
>>>
>> Oh, I didn't realize that error was mandated, but you're right.
>> RFC8881, section 8.2.4:
>>
>> - If the selected table entry does not match the current filehandle,
>> return NFS4ERR_BAD_STATEID.
>>
>> I guess we're stuck with reporting that unless we want to amend the
>> spec.
> It is spec-mandated behavior, but we are always free to ignore the
> spec. I'm OK with NFS4ERR_INVAL if it results in better behavior
> (as long as there is a comment explaining why we deviate from the
> mandate).

Since the Linux client does not behave this way I can not test if this
error get us into a loop. I used pynfs to force this behavior.

However, here is the comment in nfs4_do_open:

                 /*
                  * BAD_STATEID on OPEN means that the server cancelled our
                  * state before it received the OPEN_CONFIRM.
                  * Recover by retrying the request as per the discussion
                  * on Page 181 of RFC3530.
                  */

So it guess BAD_STATEID will  get the client and server into a loop.
I'll change error to NFS4ERR_INVAL and add a comment in the code.

-Dai

>
>
>>>> In any case, whatever we decide:
>>>>
>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>

