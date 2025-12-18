Return-Path: <linux-nfs+bounces-17184-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE91CCD6B6
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A239300CADC
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 19:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49DB3A1E8F;
	Thu, 18 Dec 2025 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PSG/fSB3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A/W1wOZJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A8C1E98E3
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766086867; cv=fail; b=YNlZmBp0m/7lxd1se+F2BKD75IRus05nXc8H115ffilpLh5fIEJmpkvJVZygNwEw3fla5BpUnUlO8BOnX9yJFFA4pUuWZNEKuIdo4E7wRV7XWp91BTPsHG2O0Y4gMLcoa9QoaQ65two6KDMu2NdbjZxtWCEHdXIja/61f/Qm4HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766086867; c=relaxed/simple;
	bh=3utDJ/NfST51a6m3019AJPkCPdhkVC0Rd/iXzRkLE5A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n219oJ0YtFzq+qUe5ydHYwehCf+MbZUlK154gjJ+xV0L4qqo3MDgROoeHg8Ujp2BK65vGQ9jtVdfRIu5t85qTV26MiJqB2rDKXGPGGC3YpRUs4dYuh4JaX0JJ7WSuf6aE5tA9T39QQMBbczwM3HGaViaRhKGMMU8Sa+FohLvIJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PSG/fSB3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A/W1wOZJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIJNTE32161949;
	Thu, 18 Dec 2025 19:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VqKtQO5co6ywxh5RIsXPwD743NWdr2rB6VexgE4zIM4=; b=
	PSG/fSB3Z+16CQY4RFJRwtWxjJa4lFNAiu9IzrGI/yuNn9/PEkIDxjUHTwBwsBiq
	YHiXfEO/02DIHmS/WDGXtvp0Hzon/6b3zZGMuVxQIyBoHo+65Phc2BjuE0roICGJ
	IKZT+N7/igs2gQ5LdqF53BCcJU+4awenQCMcYx2llUuaY/jKEuzPs7mIDze2CTWh
	DgQRR6CUjMeajp+D5PDd5keivuiH7XJCpj61JaIz3KOCi11VGfKcS2Rcd7fIm3NG
	YMt5Rp+PyGxprJcmBkmplmA3DnGUQBeuSemLjbiTqy8kcc6qNgU9NX1pcIgEz4CF
	1/yujNeSyZaZ7IyujLkKuA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b10160d2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 19:40:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJTKqI014135;
	Thu, 18 Dec 2025 19:40:43 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013045.outbound.protection.outlook.com [40.93.201.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qth0d2j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 19:40:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfT1CP4FmJBi+6YFLBp6FqXODBZ6ZGHJ7yWAh976dLLojjBHQ9dVtyULJheXj4z6QfqfnuxWrfzzJVHjeKtaAzi4vckazHzQ23RjkiE5V4zSv6fnSub8Qxd/oqEweK2b0Q+v1sNkh6gMgkrtYVdFfZrQ0B3JM5C3VeIsfqSVXiwrH9P5fABJ6mYmEClaTvfmrw71paKNKAyqDBPsrwFQeW+GaW6XHRffFOW3FZHU2/T4DlB9jjY340KaV0O+mXKyIyzSBIrZkXbGuTEOaMfzTzk6ze3R3V39HjiAkgpZ7b9j1YludvQC2xdUZzt4knxij7ytLHeVTrzdW99PFQi/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqKtQO5co6ywxh5RIsXPwD743NWdr2rB6VexgE4zIM4=;
 b=cwE0XN8SqchpfM9w4KIWFEeFYDbbq7m4qRjB0WBiJcmDoWuZE1G2z8YQ/6CDKrHjGGfNXWFE+xxH7iR49gk/XQbLl6ZtQTjpKkylLjJ8XZxvhsUFzCDCbVBsw2Kq7IrVzKop0AD0gkSky/ir5doH1uQ8Kx+9Z+LKqpM+rBg+xwH3CwnD1R6kS3iaN/przAFikthr30GdvXlWv3D6+5ywt85/OgNy+yuLSo5TJRZjRZPNcrGjh2Nn6MK/vnB/RgxbWrY/disaPIhjF16CreTI8UEOkldaqafebHJvimbzZUpTvk4dPxSI/8KJIZCDIcXA6wO7IfrIszbzolJ+GFzOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqKtQO5co6ywxh5RIsXPwD743NWdr2rB6VexgE4zIM4=;
 b=A/W1wOZJFLiDCl74AjEMTQ80Ek0pIzRo0M7AQ+91NKQXmXrPfvg6hPstYfFFs/3zfQ/s+/fBtM/7IEI3j1GqvdhmsxBr2W5pCW9UdQf32h16EgF/5jX1AL5AkWFm1dLruQeLg8bjMezE7KDCXE6WTfqRI2BWp0gXCkgnFHA6RM4=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by MN2PR10MB4192.namprd10.prod.outlook.com (2603:10b6:208:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 19:40:35 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 19:40:34 +0000
Message-ID: <f0e07e8d-f89a-4f91-93b7-77e09c6b7ebc@oracle.com>
Date: Thu, 18 Dec 2025 11:40:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] NFSD: Move clientid_hashval and same_clid to header
 files
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        neilb@ownmail.net, Olga Kornievskaia <okorniev@redhat.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251215181418.2201035-1-dai.ngo@oracle.com>
 <20251215181418.2201035-2-dai.ngo@oracle.com>
 <f8b4865f-044c-4a5c-b4a6-6e1ea9e756e4@app.fastmail.com>
 <20251218092530.GA9235@lst.de>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20251218092530.GA9235@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::35) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|MN2PR10MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e1889c-7e44-4d1f-bbf1-08de3e6d4fe0
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?M3ljQUpnMWJweW5MNHhSR0tBVjNJZXhURUNxVkJoOHVZbnpUUkV2SStTOHZz?=
 =?utf-8?B?QkN6ZTRnSjVVOWI2dDh1bFg3UVZRdUxxVzN1dDcyVG02RG1KTitiQXhJdyts?=
 =?utf-8?B?Rktob1hsYVY1QVdKVEN5dmo5TXVJdWMyTHBXVnphcngwckhDSnB1d2xxUTZ5?=
 =?utf-8?B?NnBQV0o2VlU1b0xXUzNSaEhEcXFFTGRocGV6NmxHa3k1WmF3M05tRVVvbjBs?=
 =?utf-8?B?RWJHVEFhRk5FVTF3WkxreGlLV2FQTGtqWXpWMmpTQUE0VkJIYkFPQzRuejNt?=
 =?utf-8?B?S2hiWVQ5bGZadW8rT0JEUUZGMEE5cmhnckZUMWhnOFZDeE9GOFliUWVuaGVQ?=
 =?utf-8?B?dmdTUGVhM2tiblY0dWo2d2VXdG9MTEx0eWdvMjNsY3VhbDZaZFB5TWxUaDBl?=
 =?utf-8?B?MDFRVWhmWXpjZ084enNrM2hINVlKZFRSYm9uZ1lZVFFGQkIwL3pXQlZKK3h3?=
 =?utf-8?B?eHZYRnhXRlg5bVI1K21xaW41UlIxeDc2RTZHdTRLYXYzZ0dXam5OcnF1MVU5?=
 =?utf-8?B?R2UrY0ZWV0Q3cmVKMkcxRm5KVXJxTXl6emVqQmk3QXFMMjNybDdlSW9Zc2NJ?=
 =?utf-8?B?S25hQXAwZmttUlh4dTFYSWhuclQ0MGhtOVdHWmtOZ3JxMEVDeUJnbTkwdFFs?=
 =?utf-8?B?RHhTdXgxbjRHL3VJV1I5Z0xFQzROeGlnRlY0RDZXOHVFYTArUC9nR3EzMEdm?=
 =?utf-8?B?aC85d29XM3F1eVFZVXFQa1JkSzRQMm9xYnhrcnQ2TEczbGl1Y2YyTTJyUEh1?=
 =?utf-8?B?RUZBbWtUQWpaMnExOXhWU2RJR2lhd2oyZGQzRHZIdWVXbmxTWFMvSkc2L1RH?=
 =?utf-8?B?bmozRTFIL1J5M1JPSVFQUnlyYXIzRmVMa1BZSzdER0YyVkVLUWJCeGxDdUVo?=
 =?utf-8?B?NFI3ekhGd3RjRlkzZFFXb2tSczBob1F3clhqMUZCUnpIQ3pZUXdlUS9Ic25U?=
 =?utf-8?B?c01nL1dNbyt2ZzNGUC9qQTQzOWM0OEl5OTJzVmZrOEptY0JINGZiTFZzS0VG?=
 =?utf-8?B?WUhRc24vOHMzUmpka01wQXd5aWdOdVArY1NIYmdaTXZvaUVhRjZpQzRPMVd6?=
 =?utf-8?B?MUJzRVp1TEVFb2J6Wk5ZV3poV0ZPUzY4aEpEcm94aGQ2cHlKN1JiZ3ZrZnVq?=
 =?utf-8?B?SkFDR05uclFQeEYvR0ZHUjVNWElad0F1K1lPQXRZMmk3eUI4akFhRkx4NjFl?=
 =?utf-8?B?dVRCOFVtSmZ0cmpNbmpjR2tvQi9aMEFBdEgrOEgrNXFqRGwxdHdTY0p5bDRR?=
 =?utf-8?B?VTU2SUlaeTRPMjF0amo3K0FGQUhYWmZybEt5SENENllBR0JRc0FxZzFmY2U2?=
 =?utf-8?B?V0lLQ3lzNVp3TWxvRUw3MStmMGZqSWpMd2diMURvMkdJMUloY05uUDlRZUYr?=
 =?utf-8?B?QzFrWDVqSGFTTlZEU2FYK2xUanhyayt1RzVxbW9BRnhaM2JWVmpuL1M4TDBr?=
 =?utf-8?B?c2N0V2RsVmQ5a2M3QXhyOXJJdGRmWnRmTGk3NUs1S1BlNXVuWGxoNXlwa1VH?=
 =?utf-8?B?YmlHckt0bHJ5TEhwV3NGOWU5N0pCeDNzOEhyKzdWSlhhczBHZW4zMUNiM3JU?=
 =?utf-8?B?TVRUVStmZ0tOcHE0WnJZanIrd1pkaFBpVTd0VFZpSFBvSkZMMWhWVjFiNTQv?=
 =?utf-8?B?V1JCRUVqOGJsZ09WUTJpdGJkTTJ6YnNtU3NqMFF5dXJsOHE1eWo1dFhxbk13?=
 =?utf-8?B?WDRHTVNFN0VpVDlxQmtSRlNlbGdtTHNaWlpwVGl6Smw1ZjV1Sm5weWo3ckdN?=
 =?utf-8?B?RVZLdDV0cmMyWFl5UTRXSjJMNmRBaDJJcGQ4L3h6NklDMjhhVWZNckR4UUtI?=
 =?utf-8?B?RE5DdkxuTmRFYy81cDN6MUNLWC9XWHBGUTdWdzRiQlF1aFlZT1JyeExKbE1W?=
 =?utf-8?B?NGNKN2NJTXRYNGxNT2d2ZXl3ZHpQR1dFdVhWYmE1TEUxQ3J2eW9yT25QY1Ba?=
 =?utf-8?Q?BqSEE6yV2e/+eN2m3IGRRKqgzIW+WdBZ?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?LzZvWG5BeU1MSVRKZ091eFd5RytiVVZZSjdzYVhFeGsyZDBWdGhMd0FHV0xy?=
 =?utf-8?B?Zy8xQnJYNUdJYzA2NGVBNHlITHZtK00zeVMrVFJIcUJTNjUrL2NDSzZ0ejJ3?=
 =?utf-8?B?SjdsWXpwcmc1V1N6WGtkQVFWWVJkUkpybTVUcUpMK3p0Rnd3czYyS09sUXo5?=
 =?utf-8?B?SGFnL01MZEdKZnBROXlLcGdMU3RLUUFldXUzdmVyQncwQTdMcDhHN2Q1SnUv?=
 =?utf-8?B?U0RrUnJqZEZzMkMvMnE2cXJyeithUENiL2hpaXBMd1RzWmhPa2NvKzBqbXhH?=
 =?utf-8?B?NndDbFJxY3Z3dGxXeFJBaG1xRzJZZmYvRE15YWRjSlJLNjJyNHZxY0cxeWFK?=
 =?utf-8?B?b09RbThJT3kyNTZRSnhRWEt0aDY5d1VZamhRblkwTTY4aU14dFdWRktSSnJH?=
 =?utf-8?B?MWhXRjFuTFVubklLTlh1TURua241b1B6M2V3Sk9ydXdVYjV2MDAweWs4OTZh?=
 =?utf-8?B?dStqcVEyY0Z1UzVLaVpEM0kwc3RwNDVMUHc3eUpBSWd5T3g5WllIejhtSEVR?=
 =?utf-8?B?STJqaWlJeWp5ZWhINnQzQWlvTEdaZ2htVkdlZDJRODNSYzRBQ3VYR0FzdGRi?=
 =?utf-8?B?UTJuR3JwYU9SV1pUSndzVU9udnEvcTF2L0pXblhCNHBvUGFHNDBGQlV4TitB?=
 =?utf-8?B?NXZUU0FwY3RleVZBYm05OXRJRUU2WUpNQ3d1SU56QlpVL29WQkJYWWpvTW5T?=
 =?utf-8?B?QXZxTVZDbFNMa1o2TGJDQndoVmlOOUduRGNBWHFiUHJNSFZqVVh4QmtsTXBO?=
 =?utf-8?B?ZVpRU2cvNzI1NXBVYkEvbmNzNHRtT2o1VDdyZnI5U0p3N0k5UDl4c2tqYjFo?=
 =?utf-8?B?dzI5NTVPaTRkTVU0dElya05vb0hPeVZhcWR5NXJ2VElPSVhFU0pleStOZGs5?=
 =?utf-8?B?aFlaaEVxSVA1WWVkVFNocFJZRGVMSmJ5RHREaGdLWGRhazB2L0JuMVJYcGNi?=
 =?utf-8?B?TVFibm56ZmY1OXA1Q0NKWmpaSXcxOFlMbFRXd1Y2TzNHNXM2VGo4N25RMmRo?=
 =?utf-8?B?dE42WjFVaE1NcXlqTnNtVnZ3WUdJTTZmT1NENzlLSVVialF5QS8vT1RqTXdL?=
 =?utf-8?B?WWRXK3NnODhURjVZZFIvTVpZMllmemhRak5uSEFpeDllM0VUeXI5YzIyTG9z?=
 =?utf-8?B?d0pXWjJLOFpUeFR6cEFWVWlBNXRPN2xNZHVFZzhJRk8wVTlkODNDQnVzZzlE?=
 =?utf-8?B?SVJ2SlpOcndOWjZMK3R0S08zTGQ1a21sc1EvYm1UdEw1YkhPbzNiT2lpVzU2?=
 =?utf-8?B?bTcyZEhJQXVrVHdRN1duL3ljelpoeFZtUU1pVDVjM1Fmc3RKbml1c0hnbnN4?=
 =?utf-8?B?aWFuU1FTS1E1NjEzaDE0RFRucTVYVkp1Y243bkFzbDk4YmxzVkhTU1BCYzRu?=
 =?utf-8?B?cER0U1NSTUljQ3ZGT0wzY3djQ1lRcmNlSlROZnZmWWNsUGZTVlpKb0N4aXND?=
 =?utf-8?B?YXp2YnJBMytzcktRK2pIRDUzT2FXelo5R3RRZTVZY2R6VkhiQzg0YkVyMGF5?=
 =?utf-8?B?Ujk1aS9yTVpsMXpmbno3QWtEZ1g5OUNYRitCRFI0aXVnWk1IbW9NSkFNRnlw?=
 =?utf-8?B?UnF4THBCYU1KV2RKdVVaNytBU2ova3ovakNUZlZlMXozRzE2UGVDUVBEK0VL?=
 =?utf-8?B?Q3UyTDQ2SXlRMk1wazFjK3ZuOHhkdFFQd3NTK0R0Mk1ueXhCcEo2cDNDdnFY?=
 =?utf-8?B?aUhGSEphYndlZTM0NWpqeDY2RlZjVXJKcXpzeUtvY2tNY1J6bGFkRUc3ZVB0?=
 =?utf-8?B?U1pabGQ0MEg2YVRhMDBmYSt0UGk4QTJ5cjNiaVBadkxGdEt5YmJQTlJOeGcv?=
 =?utf-8?B?andlcG04SWtVNnBTa2RlNTdsaGx5Nk9renFwSnBGV3NjVHRzK0xESGsxVFBB?=
 =?utf-8?B?QmdkR2tGRjEvRS9mVmtpTGFCK3hxV1V6VWhHNmlPenIrcC92aTNtL2RDcDBo?=
 =?utf-8?B?Z2V6OVM0d09IVHJqV1RTdm9IRkhldnNXMnp2akxkZGgzcmxiTGFscEZobHJi?=
 =?utf-8?B?UXdGMDFDVDM0UGo3YW1DN0p5aVBPbGRGR0RTc0FZR0lDSFhVYXl3Z01laHU1?=
 =?utf-8?B?a2FZOHZIajNBbjFFcVgxZ1lrQlB0cU4xbksrTk0wSjltVkUrRjViY2x5SVpI?=
 =?utf-8?Q?/YKN3QBjYY9vtTGIzjE7MIhKx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IHGEsNiysEPqzBpVTojinO9IbVq2zuCb4mXsqEqIb4A4f/dWbosN0pVlxOi0xYlrTzN/7HQGMXF1wqUSKG2HMrXiCEruTPxBpLIJN4Id+NbYzACl6o0q+98CT0z6r1FNrn7VVut9KnG5zGzBpidVuLnvvbUsgZAShe65QsELv0SfkVPUNUn76G53IXIoCVHLWFacxDFJYL+simNojJiZSoZa4pQPf7v1R067oLQWtif2g1dxsA/xBromDpLY7qVS0f7N9fWjPNH1aDOvuB7Q0M90PpTQzfq6xu4EpOLj9goAqYN7MCWtSNBkl4wKzaU5eyMdwkEQj+sYXic1MM013yy39a/140N/Jt/I7oAQ1I/4+LVA6LIPEeMsvOv2GytoAuG8UUi4ZAfnuEqjg2iPJBlC8mQJ7eg199OU2AAfGp4/ERVfIUruCntCZHnQHDqcXAfyZcUwSCNhvjWf2bw6IjGXP+lb7+ecxT1+aY22+YG+Ls0u97CI/C/897lemo+h7iMmKy8Z4GFr2ts2tftZULbyypwkGumuo3cr+Afnbv56bRIy0DqxcUCyOUerGUOdtQdHdFQPZTVRP87MTTsJnMVLxGIqqXZb/VME21t63VQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e1889c-7e44-4d1f-bbf1-08de3e6d4fe0
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 19:40:34.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /T9w3fGwqJceuBFq7mYBjQlZX7rEwDQyPJSeC7RmdwlQ7MfZPUQ/+Qnf/SI1h9tulwmlB7mhlJW0ESZQThw8MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512180163
X-Proofpoint-GUID: uGSvUHYSPO4p-4UDqxfB_YgZH_GNAmcJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDE2MyBTYWx0ZWRfX5Iks3ItibPz9
 m3qAvN0cYCw+M7s1K+Efa4v366IfmsxV7Moxq7ECRjKNYe2C14AMp0IMcHEbDgHACFzfWIYqZYf
 TdzD/mGeiszqJekEqbsjN0p6twOMclQPmi24445AYrHtLDCZYYqLLF2ISaZ7eE3QtbbrVXNDVsf
 F58eaMztlzXi8w0a5LmihJRj9rrgWaIw4K274MXHk4EZ/LGgi1Ju1x+kjqvfw9HVqsKa72D7lBP
 jFKCriR1Al+57zlbRp/ngi+xVSOo3a1p9pqJrBomECs73kiv/Bmv1lOuWk5JXxetyjqYgfbY8Tg
 PLXoxjmV4oeKnRoZiuD4ujzMqBJ5HSp0F7B4d/nSlh+uaG+ZCcYjStQokpuNIstOD6Ml6tmFLsf
 iJ1rjfD26CzUpfqH2igmVXdbVL4spS6Nfb4r6gca/7EzDrC72fw=
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=694458bd b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vgfiIO5nhb6QsJr_dcEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12109
X-Proofpoint-ORIG-GUID: uGSvUHYSPO4p-4UDqxfB_YgZH_GNAmcJ


On 12/18/25 1:25 AM, Christoph Hellwig wrote:
> On Mon, Dec 15, 2025 at 01:58:49PM -0500, Chuck Lever wrote:
>>>   	return bmval_is_subset(bmval, nfsd_suppattrs[minorversion]);
>>>   }
>>>
>>> +static inline unsigned int clientid_hashval(u32 id)
>>> +{
>>> +	return id & CLIENT_HASH_MASK;
>>> +}
>>> +
>> I can't comment on the overall purpose of this series yet, but
>> there are one or two mechanical issues that I see already.
>>
>> Let's not add NFSv4- or pNFS-specific functions to fs/nfsd/nfsd.h.
>> Same comment applies to the function declarations this series moves
>> in a subsequent patch.
>>
>> Why can't clientid_hashval() go into fs/nfsd/state.h instead?
> Or why do we need it at all?  It's completly trivial, and there is
> no inherent advantage in sharing an arbiteary masking for hasheѕ.
>
>> Also, when a function becomes accessible outside of one source
>> file (like a "static inline" function or a callback function),
>> it needs to get a kdoc comment that documents its API contract.
> And a nfsd_ prefix would also be useful.  All good arguments for
> just duplicating this bit.
>
>>> +static inline int same_clid(clientid_t *cl1, clientid_t *cl2)
>>> +{
>>> +	return (cl1->cl_boot == cl2->cl_boot) && (cl1->cl_id == cl2->cl_id);
>>> +}
> Now this might have some more reason to be shared as we need two
> values to establish the client identify.  Ńo need for the braces
> here even wen they are copied from the existing code.
>
> Also I wonder why clientid_t is a typedef instead of a struct?  And
> if we want to treat it as opaque, why we're comparing the fields instead
> of a memcmp?

I'll drop this patch since I will use a list that hangs off the nfs4_client
structure to keep track of the block devices, as you suggested.

-Dai


