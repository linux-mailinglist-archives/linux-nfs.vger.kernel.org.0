Return-Path: <linux-nfs+bounces-4187-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 827C19111D4
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 21:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39034285AF9
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 19:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B040B1B143E;
	Thu, 20 Jun 2024 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G8cWm+9X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DN1V4eOe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B336B24B26
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910607; cv=fail; b=utF3dcqTxtu8KFrHHKqBy8CuYX3tyikmM56fO25+eldXtGYemVexJC1uhnHNUl6b0tGfpFb7DrMZ0EOilLjqQl95D/2L3K+hzNvmgmu6Jm0l9ifMFWv8+9ylGVjFywGSg+exsCXSdLt8bqmy3FPxJdu1puTGNcQQTUH7YrIa8Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910607; c=relaxed/simple;
	bh=Sw7LHT8UL+7rwWmhacGL8Cu5evJ3RECySA3REjnUPT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nva8s8XuitEE0pHVqKOcPxJsHysrwYydl/3vIsz+/KLP4kHou0JRTHBt9xUidLP3NN+lIu94lpv2zA+VuOrDpBuTfP4NaAYQ1jVk1Kj2dlIgn48/kyAZJEaajmNs9YXTLs/VLJp3q6AsccOs5SbBVydT05Ov/6DgkzUjm/jVgJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G8cWm+9X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DN1V4eOe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KHBDv6023453;
	Thu, 20 Jun 2024 19:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=Sw7LHT8UL+7rwWmhacGL8Cu5evJ3RECySA3REjnUP
	T4=; b=G8cWm+9XEcKwoehPq9s8FjH8tNhJhnsfcRX/11wCLNJF8re0qgTEX/eWp
	g653TAtuyyakb1nwCKqzyKGAlrgMKBnYPbs48v7vV1HpE/B3bkw1K0jcCzokaEaC
	vb8F2ga45JJlxX8worSwWdiGq/kzN8cxb1C4Qz7w0n+ugj4z+NyaFyBR7oXclbKj
	qFPkpqqhnS/9TuRXos/pYCmUkcu+ykW+XY0WOpaCD9Z+CEL9+ypc0uuZJZsqxnoR
	CsGE4ZJNL1ZA8l0Tz2OKpAjRq0x61hiZllastkx9EAr/0tPODhsx5jUrNHnHVEdy
	bc/0TRewsaugSV0RzFAIprX1gPd1g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrktr7qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 19:10:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KIhLYW012782;
	Thu, 20 Jun 2024 19:10:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn3mjwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 19:10:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fp9sdj/vDTp7EzUhAx4IDlNmRg58JBpI9DUpYJhZiSb0P5XnBc7D/tmu+4C8btxcJ7PNf3MvxcNL46SNItLAIoTqqCMqe2yF0AkqCDNHKSYRKzyRSDfNrcFosadz06xZZhNRoYuprxHqNlg1g9WxGjpl8owsGPx1TYMdK35xaJTa6z1FWa/fdpUOS8hXi2FHJVgmcUb47tYW/bRcssc5I8AYQEbQJ5Ybfd9vUHbo6Wv0xC21g5Ebyd31+hLUmxwXRqQwhijhVs/JpoVYjFDKCvnuFgHriDjd3wWXvPE7Kb/Kwd1zM+o1CkiQgNYqvu6m+wM7lzhrGVz60qr6Q10wDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sw7LHT8UL+7rwWmhacGL8Cu5evJ3RECySA3REjnUPT4=;
 b=HfE0k2PoMowr2cg2TAi+sPxVcCaHQMbvIoBeX8kHhMX/kPf3oPW81uvYT8t+CDDruNqwoUzmJ5c9vTK/cUE55VbkOXAbef4uCj0PswDrFU83L4EUhymSSEcAieYsH+ZYWrmp2eLT9EpBGsgRc4+Ixb9SNa6ntYaeWVJct14tMtWLOOAp40UKorJuBNvlqX9KxDaKMcKQrbdKIzfKEr3Xi+N1mTdLEauRUuRm89+uqm9jb62O2PUnUqXLyModUkeowOT4GBh4aT5chdyDJCkKrpARuGI1zPm9hGkt+x0gaTMXWcJD2aQ+vlgWDSPUpJNwPNApWovLkPhFrOUV7+lHDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sw7LHT8UL+7rwWmhacGL8Cu5evJ3RECySA3REjnUPT4=;
 b=DN1V4eOeOyPsSIvaJDgyefDsopgzt7GIGdv4XBIMsBcAGZeUhQb/HPtJCXYap23G/J0IfxaHB3PW2mStmRSFRWTIxN9DTbozRjRV3ZfvmV1oU0wpwNd1ZCri2BXNRihLP+ph+bno8VZ74N+8sA9n8qQqxyxFRD/2ho0gthN3Je8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7932.namprd10.prod.outlook.com (2603:10b6:610:1ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Thu, 20 Jun
 2024 19:09:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 19:09:58 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Harald Dunkel <harald.dunkel@aixigo.com>
CC: Calum Mackay <calum.mackay@oracle.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: nfsd becomes a zombie
Thread-Topic: nfsd becomes a zombie
Thread-Index: 
 AQHawINhxmk/oYie502r8DWoEFDBZrHMBR+AgABQzACAAUEIgIAABisAgAEXgYCAAF95gIABEKWAgADlEgA=
Date: Thu, 20 Jun 2024 19:09:58 +0000
Message-ID: <264A8BCE-02E0-45E6-BCF5-6FFAAE7404B1@oracle.com>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <4eeb2367-c869-4960-869b-c23ef824e044@oracle.com>
 <661a6c9a-81d6-46fd-87ec-274100b12189@aixigo.com>
 <ZnGfEDvQB1FRGVQK@tissot.1015granger.net>
 <668b479b-3a51-4287-b9d7-44d6dfa4eaf4@aixigo.com>
 <27922D49-743D-4FC2-86C6-6926FE52537D@oracle.com>
 <50d62fc9-206b-4dbc-9a9b-335450656fd0@aixigo.com>
In-Reply-To: <50d62fc9-206b-4dbc-9a9b-335450656fd0@aixigo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7932:EE_
x-ms-office365-filtering-correlation-id: a9ae8294-29e1-400c-5320-08dc915c93d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?YTJ5UWlHT3A5NkR3b2thLyt1aERHYzZXUUZFamtOM3N6OWZPcjBmZ3kzQWN5?=
 =?utf-8?B?dVk1WHZ1QkRoTzZuZTJHekEvSGZwbmVGKzQ2UjhQYjZWYTg2SnBvMFlidUNF?=
 =?utf-8?B?VEY0cHI1eVM2eS93WUU1R0h6SVNraDVKaEpOYTg3ZlRrSE55TlF1S1BUZFBD?=
 =?utf-8?B?WVA1K0ZSK3NpM2x6eTdEaW5FaDdBaG5tOWpjQ3ZyTjkyYlZMUHdWQThzcWNp?=
 =?utf-8?B?THBkTXVyYnE0MThja3RrcFJETUpXaTdrVTBWMmgydUJLUHlQVlBFS2pVc2Zw?=
 =?utf-8?B?VE1hQWNZdkRzZGVSekl6Mm1hTm0zRzVVWHVFR2hEZWZVOFVRNmhPeVFvVER0?=
 =?utf-8?B?a3g0S1hvRDdWSG5ZSHlNRU1MVlZHd25aTmRSbmFxNGtzQ2ZNZ1VzSm44cXdt?=
 =?utf-8?B?QUp0eGRXT1JrZ0dnTXoyVUJRRjJxSjcyRFM4MVJnUURyVkY4RHErbUN4aUhL?=
 =?utf-8?B?a3VuSnl4V0RtdHBzUko4alM0VHJrR3BNQTZVcVJtWWduTFNrdU1FclZIYlZ2?=
 =?utf-8?B?MHBiNGZ0ZlhBVmcvdjBrTHNVOWtzNXRzNUM0WE1kajNTRnhOenhmT1JSWlpj?=
 =?utf-8?B?OGhBZEY5VGdWZVlBVHNZMkRTcG1HYkpRRXpzVEEvTTh1WEZjVlVLdkVVa0xH?=
 =?utf-8?B?eVZVQzZ1R1RmMm5FZlVrMGlRa1ZVcWdKbjJZYnJUUjlPTm1qNXNRczluakVB?=
 =?utf-8?B?QzJ4c0hBR1hqcFNQWmFlc2NLOU9nZ3ZGZERwb0tTMEZLQjMwb0UwYlVlL3NG?=
 =?utf-8?B?TDNIVEZ5cExHQ1VMZVVQdVEzWmxobVVhWkJXb0F6YzNibUJ2Z2RLcW0xQ0l3?=
 =?utf-8?B?d0Qyam8vY0ZXM2IzRXBBNW04SHNrZmpYYUVPRDVwOXhZTUJOY0RkUUVneXZU?=
 =?utf-8?B?cW9FdHVnK0loVnZjTEdQbzAzVnZOUDBqVWZlYVVYMk41b05hMUNmMjBIUzFF?=
 =?utf-8?B?ZWtNU3JBeTRucFNZeWhjdVdtdkl2SHRNZlpKNitTWEkwbWZ2Yi9Vem1SQmxF?=
 =?utf-8?B?M2pVVncwOTA5cUxSWnpKUHNTNHFURXlDSDAybVp1K1habEdTQ2RrdlFoMGFF?=
 =?utf-8?B?c1B0cldxZmFSd3hYaXNxM1o5WHVrbzRUeURnTUtCdDVMWnhSdVhoZm14UldW?=
 =?utf-8?B?Q1dTbVAzQUd5eWY5elprbUZ6QlRYVnczS2Ruc1lhQ3ZCQkQ2alFRZXpzMU9y?=
 =?utf-8?B?QmhwOG1zUzJmVmhZSTdKck16elBMNis1bDlyMkJ4NzlrVVJTa2k0Ymo0YXo4?=
 =?utf-8?B?bjY1dWZ6ODJhV0NBNTZZeC9oQ2xlTWhSNFJ6cXBkdDhXQ2pZb2U0UkVUQXhl?=
 =?utf-8?B?Z1dlVG1KTXJ0NVNrZHdPVmNNc05OZVpFSUdZUGZWb01IYTFCSFlwRzVaMDFM?=
 =?utf-8?B?MmUxbkU4MEl3Ti8zaCtLb3lwT0RzMXVHNEtLZENLYmZ4Mzl1bnhBQWJWaXRw?=
 =?utf-8?B?ZWtBdGMxdXppS21ycjFMbzFCR0JYV2psRkJIVTlnOTM5dU0raDRjdTdCeHJP?=
 =?utf-8?B?bHhQQXYxTy8zbDlTVFF4NW50L0VrbFRLNzN1bElrNEZHcW1mUDhxaEtTWmVL?=
 =?utf-8?B?Z090NW8xWStNdi93RjRIMTVWU1BpVU4walcvOURCUDdHUmtmY3FWQjUxQ2U2?=
 =?utf-8?B?cWRaRXJsY0laVjhnOWcrYmljMHhpTlErWi91NmF3dW5QekxhMWQzaHBCUnlT?=
 =?utf-8?B?YWpkWVRoNDRjVEx4V0VnT1EzamVYN0d0dnQrc3JKVks0WEZ6ZlpqQUNBOUZ6?=
 =?utf-8?B?dEExYlpkL2FJZ1ZIdlpvQS85Q2FJM1ZpNEpmNWRiNitQcXZFOHF5U3c3TFo2?=
 =?utf-8?Q?k83WelxBH4ZYPiyEHOknTS9iL7NIYsd4gkTnM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eUpEMHYxS1QyZ0VYWWg1Y2tDY3hrY1NWNnBTVEJGMXB4ekJJODRXMDVJa2V5?=
 =?utf-8?B?c3U0OElGUjF5NG94ZUhNa0RZR0tCc3RyaW94QVdpM1kzanlNc1VJbC9lcFBV?=
 =?utf-8?B?MW1rTVlUcXpnQi9wNmlVVW5nSFVycDliRGdyQm5qWEVPNHhqcDN4WStQVURE?=
 =?utf-8?B?Z1dqQUpJNTR3K3BpcFlQMUt6ZVl0Z2hmZVAvdnFLU2xNSTFMb2w5cWZCZnEv?=
 =?utf-8?B?S3VCbDNhVjg3aVdtREdEOFUrRDhsbU1Xc0VWejRROVhuRW5BUGRhVmJjMEQx?=
 =?utf-8?B?Vzl3TGh6MzhKT25FMVRoRWI0VlFhRlBPdk5wZ1N4cVNvTTZaVHJTMVNRNU1m?=
 =?utf-8?B?aHhDbGhQTHFtUGgzbUUxeVB1czl3YUdTZnBnd0lVc21EUmZ4UGxET29SQUc0?=
 =?utf-8?B?VFBFdlhhYU5GamM0YnhUY0N2V092Y0JYMlp6RkNPQVNMdUdhU1U1M3NjZTRz?=
 =?utf-8?B?VjYrRXBiTzBJUm9FT0liVVlpUEhyUGVVbG40dGVnSkkyd3k0azA1UUM2dGRB?=
 =?utf-8?B?SU9nSW81VStHOGhpREZ2RHc3QVQ0ZEQ4S1kxQVlyZGIrOGZhUHU1UlJvdzBE?=
 =?utf-8?B?V2dzOFk1WVh0NmFHNlkzUlM2djIyeUZONzJMd2UwYnJ3UlBjN1lTcHpyOWI1?=
 =?utf-8?B?YkFnM2sxMEY2TDhvTDVVWDZqc04xbWlYdXpmUFRpOVVXN2VvcmtQMHNDdmRv?=
 =?utf-8?B?cjhtTjBmN0d0K2dHSGk0Z011N3NsWUI0V2wrVGVoU051UlZHYW9aYXRNeEI3?=
 =?utf-8?B?eHdEZGMzalYzTHpkaERjeFFXdHVCR2NSRjRGdkduKzRJUStzNzhJS3lpWVVI?=
 =?utf-8?B?S1NpMWlJelNtZ0dCZnVDVy9VY2RzRHZZWm1oMC9veXZES2g5V1E2UGQ4dW1h?=
 =?utf-8?B?eTBQTUZIbFFab0xuNE55TW5QalBKU2ZobHhzSXVHZjhhVGJic3BRZ2l1S3dJ?=
 =?utf-8?B?N21aazQ1eWluQ3VTSXhEc1RWTm4ydCs4VjR2azUvc1JiQ0s4QmJoeDBBNXk1?=
 =?utf-8?B?UitiUEhRSGN1NHZRRVhtM2ZtdG1EWG82ajZJQStMNmZqdVZpOUtweWQ2b01O?=
 =?utf-8?B?aHN0b09RV1pCcmtoU3NmNVNRQTYrUXdTZDdJeG1McHBUeFNGWVZPUFI1a3dK?=
 =?utf-8?B?L3hua2ZZcTJpOFphRkF1SEd3Q083M3RwUEFmRDFiWEtEdUZ3S281SkRyemlh?=
 =?utf-8?B?V21pZEhHb3hvSFRPNWxCM3RXRUhZV3E1Vnl0N0NZUVZoMFo4RTZRSThBUTRa?=
 =?utf-8?B?dytGandXNU82ek9BQ2dYRzhjbnNvQk1XT2gycC9EeGRnNnJNZWwwOFRFYWFw?=
 =?utf-8?B?RCtNMlZpb0tFNG1lalRZM1RScFNhdmpCZjVFTzdicmpGRkkrL0RleXpRQk11?=
 =?utf-8?B?VUEvNnU5cHlVeGpiRW5lcVljMitzNE92MzdLQ2JHdWhoamtSTlpyZUhUUzFl?=
 =?utf-8?B?QlJ1cVdjVUJtQmNTZ2VkdTNveVM1WVlMa1J4aE1URkk5SXVRMGhsbWhQd201?=
 =?utf-8?B?djZJS0JWZkc5amhCYjlGQytoQktuOEFoNVBiNEtkb0w2VXVtczA1bE13T0s0?=
 =?utf-8?B?bmNETXZuUGNUOFNaQk50WWRYdmNBZTNFMVZ5TTl6UzBYZ0swUk1iMEVtZXlr?=
 =?utf-8?B?bHQ1QlY5WmF6TXBaa3E2SU5GODg4Wm8zV0FUbmVaY1FuVGcwQUdSUjhTYWNy?=
 =?utf-8?B?TldzSi83N0FzaDZERXVCK0RUNXpDdTRNb05ZTjR5NjQzQXZQYTdlcDBwcjky?=
 =?utf-8?B?NU5ITS84SWV2Mmk5ZEd1ekkrUXBSSkF2dU5udmJDeGdTck5teXpNM29NSUFQ?=
 =?utf-8?B?azJkZGxyUndTQW5NRlpWOTFTaktGOWROWnB3aTNIL1VCVEJYdlFkZTlFUm51?=
 =?utf-8?B?dVdVSVRrNlFSSjU3eW0xclY0bTVxWjIrNExBRXJpSHYzdG5pMGdaMWFRc1Nw?=
 =?utf-8?B?OFBBVkdhVHdjZTVmdEplTGkweTROQW1mOFE5MlVUZVltSGJodHFpcUQ2TWY0?=
 =?utf-8?B?NnlFamRaMDJjejdDSkczSlBON29vU0NhQVBsOWZDOVhtczRjdlBwcnA0SnJi?=
 =?utf-8?B?N0FVdFYrc0FQWTRJdDVkVWN4OE05WkpGUFJhR2JYbXdldi9Ud1pwVWRJbnhp?=
 =?utf-8?B?eVNoZ0dqKzMyV0ZXMlFRc2hoQ0lMNnVCYllOTHRMQ1NoRWxiS0t0ZlVTbStv?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BFEA878212327458110E2FD65CE87B0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Kt/h/7OzJO2oCwD44N5NiwyHaNerdYgSv3n1uyCwaLDVTzo+tkuGHn9v1Z1mUNNGwCUaNRulte0SWFPcGCfWLgJ6E66OA4Cy2eGleXouxFSwkm9ver9UHsg7bRHDGxGEIi08S+LFkgzBcGLvM/6k2NMqDbK9/IoUhM0EjSX7wKaAeeOaab8PVUPC8Hw5TJI8pcCk/GMC9/XFASMzcKT0X//AxCY1pBI6ph6K/eSI1PTBqTYbcUJc4ar0Hh8+tHCROWwvijSi8B1P1C4tIOK0oumBfCL7nqNZOA68gwpZMcIvQQEldW30eBElOJw1cIS4Yl4xVnjbncWX80KlTUzk40gcaddT082MIffq8wioCKomWpT0S56dVgbci4hMtv/IQA5bLa8+5BgwVA02wVEUDmejPPBpwDsq4lKefgOCkb8IUJdaxnV0GA3iGZfZFr4cjASl1/PRlJkz7gz3KmvNoTbThh+TOmDU4yTXpXhtPXqGQnr4s6VPZ+XMCGZTN8Rk3GK1LXMxeqRzkedLLDG3TgyAjER7O93XdyGlgfY9dkWvehrueRaIILbzs/OTb1nuBUrt7N49dHSx67FI/7ya/DR3tGCKreagbqyuH7hom5g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ae8294-29e1-400c-5320-08dc915c93d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 19:09:58.2772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6He5Pt7r0m5ih0ENrAPOCzpdsC/Zklc4VlCpPBQVgZlsi7BLUNd7UdlxhMLWGhChdz8Wz9W4cXd6y6+ViEJMDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_08,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406200139
X-Proofpoint-GUID: xFInS-Pw0ucuCRUx4oNLnx8DNAwy_INk
X-Proofpoint-ORIG-GUID: xFInS-Pw0ucuCRUx4oNLnx8DNAwy_INk

DQoNCj4gT24gSnVuIDIwLCAyMDI0LCBhdCAxOjI54oCvQU0sIEhhcmFsZCBEdW5rZWwgPGhhcmFs
ZC5kdW5rZWxAYWl4aWdvLmNvbT4gd3JvdGU6DQo+IA0KPiBIaSBDaHVjaywNCj4gDQo+IE9uIDIw
MjQtMDYtMTkgMTU6MTQ6MTUsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+IFRoZXJlJ3Mgbm8g
d2F5IHRvIGFuc3dlciBlaXRoZXIgb2YgdGhlc2UgcXVlc3Rpb25zDQo+PiBzaW5jZSB3ZSBoYXZl
IG5vIGlkZWEgd2hhdCB0aGUgcHJvYmxlbSBpcyB5ZXQuDQo+IA0KPiBJIGFtIGdldHRpbmcgdGhl
c2UgbWVzc2FnZXMgYWdhaW4sIHNpbWlsYXIgdG8gcHJldmlvdXMNCj4gaW5jaWRlbnRzOg0KPiAN
Cj4gW1dlZCBKdW4gMTkgMTY6NDY6MTQgMjAyNF0gcmVjZWl2ZV9jYl9yZXBseTogR290IHVucmVj
b2duaXplZCByZXBseTogY2FsbGRpciAweDEgeHB0X2JjX3hwcnQgMDAwMDAwMDBhNWZmOTRhNiB4
aWQgZjlkNmE1NjgNCj4gW1dlZCBKdW4gMTkgMTg6NDI6MjMgMjAyNF0gcmVjZWl2ZV9jYl9yZXBs
eTogR290IHVucmVjb2duaXplZCByZXBseTogY2FsbGRpciAweDEgeHB0X2JjX3hwcnQgMDAwMDAw
MDBhNWZmOTRhNiB4aWQgNTlkOGE1NjgNCj4gW1dlZCBKdW4gMTkgMTg6NDM6MTUgMjAyNF0gcmVj
ZWl2ZV9jYl9yZXBseTogR290IHVucmVjb2duaXplZCByZXBseTogY2FsbGRpciAweDEgeHB0X2Jj
X3hwcnQgMDAwMDAwMDBhNWZmOTRhNiB4aWQgNWNkOGE1NjgNCj4gDQo+IG5mc2QgaXMgc3RpbGwg
cnVubmluZyBhcyB1c3VhbC4gQXNzdW1pbmcgdGhleSBhcmUgcmVsYXRlZCB0bw0KPiBORlMsIElz
IHRoZXJlIGEgd2F5IHRvIG1hcCB0aGVzZSB3ZWlyZCBtZXNzYWdlcyB0byBhIHJlbW90ZSBJUA0K
PiBhZGRyZXNzPyBJIGNvdWxkIHNldHVwIGEgc2ltaWxhciBzeXN0ZW0gYW5kIHVzZSBpdCB0byBj
YXB0dXJlDQo+IHRoZSB0cmFmZmljIHdpdGhvdXQgYnJlYWtpbmcgcHJpdmFjeS4NCg0KVGhlc2Ug
bWVzc2FnZXMgZG8gY29tZSBmcm9tIGtlcm5lbCBORlMgY29kZSwgYnV0IGl0J3Mgc3RpbGwgbm90
DQpwb3NzaWJsZSB0byBzYXkgaG93IHRoZXkgYXJlIHJlbGF0ZWQgdG8gdGhlIGhhbmcvZGVhZGxv
Y2suDQoNClRoZSBiZXN0IHlvdSBjYW4gZG8gaGVyZSBpcyBlbmFibGUgc2VydmVyIHRyYWNpbmc6
DQoNCiQgc3VkbyBzdSAtDQojIHRyYWNlLWNtZCByZWNvcmQgLWUgbmZzZDpuZnNkX2NiXCoNCg0K
VGhhdCB3aWxsIHBpY2sgdXAgTkZTdjQgY2FsbGJhY2sgcmVsYXRlZCBldmVudHMuIFdoZW4geW91
IGFyZQ0KZG9uZSB0cmFjaW5nLCBeQy4NCg0KIyB0cmFjZS1jbWQgcmVwb3J0IHwgbGVzcw0KDQpG
b3IgdHJhY2UgcG9pbnRzIHRoYXQgcmVjb3JkIGNsaWVudCBhZGRyZXNzIGluZm9ybWF0aW9uLCB5
b3UNCm1pZ2h0IGFsc28gbmVlZCB0aGUgLVIgb3B0aW9uIHRvIHNlZSBldmVyeXRoaW5nIGluIGVh
Y2ggdHJhY2UNCnJlY29yZC4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

