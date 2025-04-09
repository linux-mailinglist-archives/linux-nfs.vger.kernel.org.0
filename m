Return-Path: <linux-nfs+bounces-11065-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 523DCA829AE
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 17:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CADC844464C
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 15:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D358026B950;
	Wed,  9 Apr 2025 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XDEzWUso";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iBfi+Mig"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B5A267722;
	Wed,  9 Apr 2025 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211002; cv=fail; b=AcIqd7+wdNmARrnIULHlcwq/AqDKD2qG+Q1AcHo4xcSNGWTMuTTpKuegHfXzMXuwqMMhgjWVNZN793aynzWcjoIaCdnmxQXdG3Yd/+pMdqwl1MVGAe8NjHR5AJ8CPqIb64IN8SnKfPP8aHXzjXT+V0ejc/xdFLDwEpNqp1eNqdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211002; c=relaxed/simple;
	bh=P+/WYzTibTV66l7nTUW5MQodIdYUgNtl0xhPcGg8BgY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TN29OO117Cll94gWXdJmoAep00etcWARZzjwruCFugkulI3uuirHr/ACsDqImmosQSj+K/EhzGYZmSbOvtN+y4cSmlBADp+zrq3MJ3p6jmSu0Ag5s3S1xctmJ0snxo2b/GpJeFWeFjObbZf/hAzy3CI3imIeO8SONdjl+lz8iH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XDEzWUso; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iBfi+Mig; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539Etf3m023702;
	Wed, 9 Apr 2025 15:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=CXUDi17ipqaDl8bKa9E41aiIJlTZt1rQ24UWfOQIHJ8=; b=
	XDEzWUsolW4oiGEYNJ8Jxq9hBtSKPBU0MM8kiUswjvPzxqfF4TRUfsc3NYHVAVXS
	LNFHftr8f/CrRVaKmFzCpRAKuTTpcdb6U2C2/KlhjrwRJaH1R5aeyc1fKbIjLQ8E
	ZbB5J+u1FHTaIR06dM0ovDAv26PSVQ2xOc5sHlLE0zO/DghKF1AWnrQddkxdqzed
	DM2acKmyL8mBfJ5+N8X4dNVEAj8KAtKZWvBaUSstJM57iL8OCMQBolGHuVVyyepj
	0oSU3UjeGNbqvTDUGh5L4jLb7ajQDXg/ViR+RR9i4dxYP4/SAi06s4Lg6akxLh0p
	G4KNAu4kYekwyASQpoTJ7Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tuebqdkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 15:03:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 539DlAWA022130;
	Wed, 9 Apr 2025 15:03:06 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010003.outbound.protection.outlook.com [40.93.20.3])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttybndue-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 15:03:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQXbZ6yhS/w8MjZyzvSN3lYzOcncjFg57beLksQwdTGcqyAWvhVCh0e51ZAJGkGQ4nMj/MwHaOB59bJgmskKBUNIkGu81tqozjvikMLammHFwZafwCNvAZ8Z6CFDThBIrsO03038ur/AarGh2Y83LmaGGZsZX5BJjSxy2ZCdLJeNYGpoJKNDn+ECAUMSBWOA3W7dClBB9Ggiirb2bAv9KL8MnFJw8nl+oKW1u8rKdoR2TrU/G2kTHfWcf6VW043szEaPFM/ngcmzjtpdLiMtyMdvd0ft6P1KtS3+jG8VccJyzrKeo+XKjuFUTAz8hVYzzTNlmpUMuM2bsrHofCF/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXUDi17ipqaDl8bKa9E41aiIJlTZt1rQ24UWfOQIHJ8=;
 b=EPPBJOGWRhDK2t8S5fgp5GX6E/uDM32g/HTEXD5rTXo7BIRnnuqatZPgSPLlU2Myjo5o5qyvejPb1AGSRaE6uc6CvGrptgh2ERsK15r9uUpxG853XPBsc9Wu28db2wiTGGuiJ5/I92HtGlR48kcAcIVWIGfYAqdMwvmMNmBBOmWRdD2LVsV9sCh6fBolzHLn2sF143iuCdz5wFD36buTJHXhij53Ae/lHTG3XSlqbJn/CTH3XuHzqFV51YXqdKSMcPzXEsPa/8GIZfIsZxnO9D9oaLQXC1UcDlstmSJOzgmirq6+EscCTzZdyn+R8Atm5pG+mD9a0UuLZiDTrtcigw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXUDi17ipqaDl8bKa9E41aiIJlTZt1rQ24UWfOQIHJ8=;
 b=iBfi+MigTissdqXGQxjIrEcbt4V9hU24G4iWvoGebWeKgcUxUJqSPSS6AtHmGfldTcbeCxtyB3S4aVOPcGkjv85K4eFYsTo5lMd4Ezqt0nprP7kidJOJA3O5O63ynPvTz/onUd+ynOITA9Mfg0udWouaIHoTMoX34iJEZUS48Qk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB8107.namprd10.prod.outlook.com (2603:10b6:408:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 15:03:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 15:03:03 +0000
Message-ID: <df6ba077-5f29-4bbb-a011-e9570aa2c923@oracle.com>
Date: Wed, 9 Apr 2025 11:03:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] nfsd: add a tracepoint for nfsd_setattr
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
 <20250409-nfsd-tracepoints-v2-4-cf4e084fdd9c@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250409-nfsd-tracepoints-v2-4-cf4e084fdd9c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0026.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7dd4b0-0091-48cc-120f-08dd7777a063
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bnhkN3hhK08vVTZaSHRSbjdpM0F3RUlscmM2a29wRGk1azdnN2hicExMdDJD?=
 =?utf-8?B?T3lVWDBaVmdZeG40UTBGTXF6RFFIdlJBWnZPak9hOGVyZzNmMDFrWURTSktu?=
 =?utf-8?B?eUtTTDNVbEd4ZHdSRDlCN2NYV3R2YVJuRFF1Zm9zVTBJWlNCMEZUM1lla09O?=
 =?utf-8?B?bkJ6bVNzZ2p6M21HckVodytuSm1XT0k5ZDdnc0MraWh0ZWxTeUFkRkRhRWcz?=
 =?utf-8?B?RXdoWWFvTUdZVkx5d1lsZFRQanZCdHhlVElYMXptdU8wVUFkUlJsWmpXcnVa?=
 =?utf-8?B?aFArTklPMUNPYnZYMVBhaGNETHFXc25oT0lmNlB1L2ZVWlZaQW1Mc3lEbjJB?=
 =?utf-8?B?bkV3NjFRamVLek4yY3hVd1c0OGlNWkhOY3FZb1NCYTBCQmVsMUlEWmZzcmpW?=
 =?utf-8?B?YS9VVUtNbno1T2JIc3YxOXlLYWt6RnArU3RHVGRZVzdiWk1jVFE0RFpIbXdC?=
 =?utf-8?B?UURUOHRqT1pZUTc5dnRnTnpOWW0wc1QrV2Y3UU45R1VpR09HeUhoZU16YjB2?=
 =?utf-8?B?QjF6RHArNUZIcm9wSmNWaW5aVEFuMyt5NS9MOVFDRDI1R3dtSGZrYU5xVTM1?=
 =?utf-8?B?QTZCMlFqVk5Oa1Bhd3ZES1lzWFJOV2p4VVhmc09oWmcxNWRsVlJ5NW9xWDlC?=
 =?utf-8?B?VTF6TGlOODdZazJlVjQrbVhBOFovYmF0V2hOY0grSS81MHRLcXdCQmwvajFx?=
 =?utf-8?B?N3RPNmNjQ3FRNEVXMFdLYU1qeHI5K3hDM0JnamwvVjVFeDFlVkppUDNsTkZS?=
 =?utf-8?B?ck9hOStMSXNodFdhMXE2dVdoV2JEUGRQMUVDcm9veHVRTkhwZXQybndSMjJt?=
 =?utf-8?B?a0lwME8zbk9Ib2xWWFVWR1g5cWtmY01ia2huVW1hZ1g1dFI3cmVwU0xtRmt1?=
 =?utf-8?B?VkhYbklWdmkzZFBTUnQzbFdWdEpyQnRURGdoUU1MNnVsV1AzN3BtMklvTHFZ?=
 =?utf-8?B?MHB5emRweHV3Y1F4bDBwV0h4SGhuNDVuOWJCbU9TNGRrZnJsY282b3A3U3Ns?=
 =?utf-8?B?d1pHTEhySW5tblR5TmpOU0FHc2gyaWF4UDhpZVBQM1pwRTkwejliLzkyT2xK?=
 =?utf-8?B?TTc2cEF1QjFQZkNmZUQzdFZTcmd5S2ZFSnVBd3lNN3NpQlZEWjNSclc5ZXVF?=
 =?utf-8?B?MEE1T3NWZmhUYTZkZVdtVUtmU2FQOHVnaUhqT2xtZ0FBM0xuZ0p5WHVPM0Zh?=
 =?utf-8?B?a2JXZU8yRDZNV2NMekkvTEZERkZJc2ZHWUFENFM3ZEQxR0hhc053bk14UVRY?=
 =?utf-8?B?ZlArYWFsc0tCOTM5K3JSNWdxU091RWVHOFJGUFd0UU9tYjdIa3EzSjJxTjV4?=
 =?utf-8?B?UHFURkpSK0RQSUJrQmtxQnhoQjhybTV0VGpSY0ZxUEp1V0J3aGFrT0UxKy9z?=
 =?utf-8?B?ZTViN0ZYeHF1dWpDdVh6RHJObVVKYncrZXpNNmpvL0NkSTV6QTcyc2Eyd292?=
 =?utf-8?B?aE1QVGwycnF4QkpzR2piU09DWEtYWTg2YjBzZG0yNFpCQlI2TXcvc0x5L1h0?=
 =?utf-8?B?dCtIYjBVQjYwVzlXcmJOTFYxZEt6WEZ6K1M1YXdpaEFnU3JhcTZhaUlNbFJK?=
 =?utf-8?B?QnQ2SXBOcytSdlk5KzBWbkNVMTluZlgxVDN3NEcvRzdMZWRkZ0s5QVM3bGt1?=
 =?utf-8?B?R3NRdlZCdDkrOUE3QjBKakJJOUFNWkN0SUwxcm16YzBsSEZsM0wwTlpLK2tk?=
 =?utf-8?B?YUtXekZmcDlUTjNPR1J2UGRvM21WZVZURzBlRGsrYWZSVytUV1M3ZlZaVlFo?=
 =?utf-8?B?Q1BwUm1NM3hCQ1FaM1UvdEovWkduYXlUako2Ykt3c3daUUdlM0JVNzhkRTZq?=
 =?utf-8?B?OFd5WHNXb0VaemtrWDhwZ2VzT1ZBWElsdG1IMGl0azhyV0xvODYvclczc0dV?=
 =?utf-8?B?Z01WKysyR0hURmNrUFNXU082eitBUkI1eWlDOGswanQwYWZxcGxYaUU5QkY4?=
 =?utf-8?Q?jCtkPnSlW5c=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Q0EvSUhWb29RbW93WmJCK0JZOWlCbnBYVmZyMXhSTW4wSHdodzAwTGZUM0Z4?=
 =?utf-8?B?MFJ5VVVoZzk3eG9tbU9aamcwelVXOXVpNjVIVWU2SVRrdnZLU21ScEk5aXl3?=
 =?utf-8?B?RXNFUUxFU1ZqQ3JFQVlnc0dlSjFaWDk1WDJKSnU1R09ROVBUbHUxZE96ZXA2?=
 =?utf-8?B?cHgzNEtHZHJrMnJQWXJXTjFJKzRxVzliR1hBb05kZnhjWktvUlZ4MTloWGFv?=
 =?utf-8?B?K3VwK0lWU0ZwU2FBRFpSTVRTVHo0UnYzVlZHVEF5SmpPZHI2K1U0WXhPOFMw?=
 =?utf-8?B?YXRiNERJK0xHSTRjVVBqS1BIamtXZ0JDZVhUMlNRUGZhb3JacStFTUZsbWs0?=
 =?utf-8?B?L1NGZmYwRWhEaGJZWFM2eklxS2lic3p6cFpNMjFzcVc2amdwUVRlVEtidkJB?=
 =?utf-8?B?MEg2Z0NrTzNia01TT2tZbCtpRU5KSWg3bU0xaHpQOE5KZUE5ck11OWdhREFs?=
 =?utf-8?B?cXU0NnhCdC9GdmhHaWpSa0NyQ003NU45b256WEpLV2NkWGxNYVZ0U0VzN0VR?=
 =?utf-8?B?SmI2TzJSVmh2bHQ2K2NueHVNbFg4UlI3Qk9GL2RNOGpOYndFQkZPRGJ1aVQv?=
 =?utf-8?B?Qit6QVAzLytoQUhRQ3ZUSE1wenkyd0tRNlFWZlR2OURsRW03ZXNMVWN3WTlX?=
 =?utf-8?B?RUZjdXYxSzJLVWs1U0lZRnUwVmI0WUNpYlFDRGlYSDNJYmJmbS9qUFhKZjBG?=
 =?utf-8?B?YXlmbkNoa2cxcGRsSDBSUkNwRXNaNlpNRjJNY1BwNUR0WnBsRm10SkpMZDl3?=
 =?utf-8?B?YVhNcE9NRFA4c3cvUXBYeUpydWkrU0NWei9Qb093enNXcy95YnFmTE9HUkNl?=
 =?utf-8?B?T20zdmptM1puTHRoaW1iUVdrUnNZWk0yMVRPaFZUTXJQNy91NjV3azA3cXVM?=
 =?utf-8?B?SHpIYlEycWVmRlM4WFBuT3QzaGp5WktzTHo0bzg1dVRSWFZDSWxzVDdCUTVP?=
 =?utf-8?B?WEc3TWQ4dmJMWFVCdnRXK3JiOFZkdHQwYm00UkpMa0JRbEJsZUZhMUpjQ3c1?=
 =?utf-8?B?Rk1rMHhEbDNJV3RLTXFzWWthRG0zekFQODROSkhIdGhnZ2k5UGNHaWxnYWNT?=
 =?utf-8?B?ZFIya2gvdFVZMzB2S2swUGhMakJzSzRWZnVUQ1k1MHd2RHBBTVBQNDRkUzJq?=
 =?utf-8?B?QTRqeXIwa1dQK1pQODdHbS9Bd1VjOHpzWmtUT1pQNkRXTlM5dXhRK3RZK2o4?=
 =?utf-8?B?NHdvQW5Sa3hHK2dUQmxFL1d4YWd3Z0Q4ZHpPT1IzMFhGWERWU3plZG9RWEZk?=
 =?utf-8?B?RENjT2UyenJPTXdEVmhuQ0FUbS9PNGhFekpseEhJcUsvMENGNk4zb2xqcTNa?=
 =?utf-8?B?OHNveVhRSXpwU0lPZU8yVXY3WFJFWU0yL3ptdlNOWWtRT1FPbVpxNTVWMFFy?=
 =?utf-8?B?dEhqQVMyQlpTYmZzM3RHZ3diRFFwWjhTSldqMUtpVllqdm1haklXU0xsZVFS?=
 =?utf-8?B?MmNMK0piekEwZ1dNamk0eWxaL3dYUHZ5UVBGSnVucThtVW81WXhxdzU2aXZv?=
 =?utf-8?B?TFJ1dEVRV3MydkkvVytiT1NkQjlXYXI1V1F3a3JRSGt1aU5yVytSWFZJdlc4?=
 =?utf-8?B?WWN4WkRseDAwWFpFc09ycnNwZU1TT1lsYUt1Ry9zQjJLa0RubWdYd3pGQ2ts?=
 =?utf-8?B?cDQwRVF1a1RTdnBXdUVBSHVQMVJtMElaeS9UR3kyc2xPdWlCc2VBV3JuU3hE?=
 =?utf-8?B?T2ZtWkZhN2dyYitob3Y2bDdmQ0Z0dFdNci91dUxpRWpTaVU0TE51NlowZHhY?=
 =?utf-8?B?M1o0eS9VUmR2Nk1VMnJ5T01ldldla2ZlNU9KaS9MUU9XOGozUXZ3d2JPMm5J?=
 =?utf-8?B?ZTNJRDJZZGRIcnFDc1RVT0pJbWd1aUhVOHRkQm1qQ1dhQWE2eTZpODRCbnF5?=
 =?utf-8?B?U09ESG8ydFpGUEI1TStpUU00NFNST1JYaWhaYXZMTzdVeDMzNksvTG5mTDVI?=
 =?utf-8?B?emZwUGRSLzVIbmFndy82b3VrM2JualpNNTgwZkNQSHdTRWFzcWNkbEhEZmox?=
 =?utf-8?B?R1c5Q1ZReUxVM1J5cUh0VVY0RmI1bHZKNGM3MFhzak1FZm1FTnF6UnNxSXNU?=
 =?utf-8?B?TkR4azNoUTRCclIxS2xyeDUxR01MbWFEYnhLYWtYKzJIalVvQ2F6Q1dsYmJi?=
 =?utf-8?B?Q1dDQkFSWStkOWEzNWhNTEI2TzI0bllwY0dhejIrQTBESFVWYkIvNit1RE8w?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lCB1pcF58qa3LnKezjMLJXK5lf8XgVvlxq+wtnsq+ihqNFt0A8DJcHeAtHaqS/XUCx+5hop7ELEUjcdJ1MUYYcyUpWCEZYn9An9SKssuw+3W4CcEZLNBbEcMiefO+tPVKEsogib4fKG0td0f3k+LKVW4GDT7VgSpnhYyZ+PTwiR20OU3aAfcCZiruAHHxEl8gzAB1MN27BDEooiaHsSuUwKeV0xwdj5DoYFDhnpNvpAKixlxpBziiwifuJI8XxXzrftr5b05CwcaUDD+Xt56IzuUPHro45qpTaQIpjdUqwQqOiTdf2elEaZA7i+QIFeXEdNGgPDiEhREt6RvWkA3LlHFKv13mgoCbHjqcGcdec+tAiNKAfltwm51WLbpIXRkvwuEQBupYH89jVkTOrK3HypB17Ce/zeuTee5Lkv/jKKFCxRFi7iSNsvK5GuWPDCcy8dzzSdEeodfsxOHFb2CBsSYqqY2GrggAZSugffUZHWwUxGGGShNHUnmISM9PLqilWjkVPwJLfFnL9sp9HYFA5ZwexJOQhwVj8e6LGMHm9jYLzeVwS53fDGftRY/JwsokF93V5YrXXntao0cM3tGzTDxACOAAeI4B1/7JA0Kecg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7dd4b0-0091-48cc-120f-08dd7777a063
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 15:03:03.3388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXHWzlZq3QLb7CXyJ6kZxDE4Tni13gbwPBfd0i09XVrOaIhe9IzZbqlMiI3IBtxVkS1T7oJW978lNAzUNvWGLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=955
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504090094
X-Proofpoint-GUID: xAAyIiJ4L10OH-ONw9fVcKohjgJ5IcpL
X-Proofpoint-ORIG-GUID: xAAyIiJ4L10OH-ONw9fVcKohjgJ5IcpL

On 4/9/25 10:32 AM, Jeff Layton wrote:
> Turn Sargun's internal kprobe based implementation of this into a normal
> static tracepoint. Also, remove the dprintk's that got added recently
> with the fix for zero-length ACLs.
> 
> Cc: Sargun Dillon <sargun@sargun.me>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/trace.h         | 35 +++++++++++++++++++++++++++++++++++
>  fs/nfsd/vfs.c           |  5 ++---
>  include/trace/misc/fs.h | 21 +++++++++++++++++++++
>  3 files changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 0d49fc064f7273f32c93732a993fd77bc0783f5d..c496fed58e2eed15458f35a158fbfef39a972c55 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -11,6 +11,7 @@
>  #include <linux/tracepoint.h>
>  #include <linux/sunrpc/clnt.h>
>  #include <linux/sunrpc/xprt.h>
> +#include <trace/misc/fs.h>
>  #include <trace/misc/nfs.h>
>  #include <trace/misc/sunrpc.h>
>  
> @@ -2337,6 +2338,40 @@ DEFINE_EVENT(nfsd_copy_async_done_class,		\
>  DEFINE_COPY_ASYNC_DONE_EVENT(done);
>  DEFINE_COPY_ASYNC_DONE_EVENT(cancel);
>  
> +TRACE_EVENT(nfsd_setattr,
> +	TP_PROTO(const struct svc_rqst *rqstp, const struct svc_fh *fhp,
> +		 const struct iattr *iap, const struct timespec64 *guardtime),
> +	TP_ARGS(rqstp, fhp, iap, guardtime),
> +	TP_STRUCT__entry(
> +		SVC_RQST_ENDPOINT_FIELDS(rqstp)
> +		__field(u32, fh_hash)
> +		__field(s64, gtime_tv_sec)
> +		__field(u32, gtime_tv_nsec)
> +		__field(unsigned int, ia_valid)
> +		__field(loff_t, ia_size)
> +		__field(uid_t, ia_uid)
> +		__field(gid_t, ia_gid)
> +		__field(umode_t, ia_mode)
> +	),
> +	TP_fast_assign(__entry->xid = be32_to_cpu(rqstp->rq_xid);
> +		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
> +		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
> +		__entry->gtime_tv_sec = guardtime ? guardtime->tv_sec : 0;
> +		__entry->gtime_tv_nsec = guardtime ? guardtime->tv_nsec : 0;
> +		__entry->ia_valid = iap->ia_valid;
> +		__entry->ia_size = iap->ia_size;
> +		__entry->ia_uid = __kuid_val(iap->ia_uid);
> +		__entry->ia_gid = __kgid_val(iap->ia_gid);
> +		__entry->ia_mode = iap->ia_mode;
> +	),
> +	TP_printk(
> +		"xid=0x%08x fh_hash=0x%08x ia_valid=%s ia_size=%llu ia_mode=0%o ia_uid=%u ia_gid=%u guard_time=%lld.%u",
> +		__entry->xid, __entry->fh_hash, show_ia_valid_flags(__entry->ia_valid),
> +		__entry->ia_size, __entry->ia_mode, __entry->ia_uid, __entry->ia_gid,
> +		__entry->gtime_tv_sec, __entry->gtime_tv_nsec
> +	)
> +)
> +
>  #endif /* _NFSD_TRACE_H */
>  
>  #undef TRACE_INCLUDE_PATH
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index d1156a18a79579bf427fe5809dc93d06e241201e..77ae22abc1a21ec587cf089b2a5f750464b5e985 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -501,7 +501,8 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	bool		size_change = (iap->ia_valid & ATTR_SIZE);
>  	int		retries;
>  
> -dprintk("nfsd_setattr pacl=%p valid=0x%x\n", attr->na_pacl, iap->ia_valid);

Nit:

These unindented dprintk call sites were introduced by Rick's POSIX
ACL patch series, which is experimental. He's promised to remove them
before he sends a final version of that series.

Your patch can leave them in place, as they will be gone soon by other
means.


> +	trace_nfsd_setattr(rqstp, fhp, iap, guardtime);
> +
>  	if (iap->ia_valid & ATTR_SIZE) {
>  		accmode |= NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE;
>  		ftype = S_IFREG;
> @@ -597,7 +598,6 @@ dprintk("nfsd_setattr pacl=%p valid=0x%x\n", attr->na_pacl, iap->ia_valid);
>  						NULL);
>  	}
>  	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) && attr->na_pacl) {
> -dprintk("at set_posix_acl\n");
>  		/*
>  		 * For any file system that is not ACL_SCOPE_FILE_OBJECT,
>  		 * a_count == 0 MUST reply nfserr_inval.
> @@ -612,7 +612,6 @@ dprintk("at set_posix_acl\n");
>  							attr->na_pacl);
>  		else
>  			attr->na_paclerr = -EINVAL;
> -dprintk("set_posix_acl=%d\n", attr->na_paclerr);
>  	}
>  out_fill_attrs:
>  	/*
> diff --git a/include/trace/misc/fs.h b/include/trace/misc/fs.h
> index 738b97f22f3651f2370830037a8f4bfdf9a42ad4..0406ebe2a80a499dfcadb7e63db4d9e4a84d4d64 100644
> --- a/include/trace/misc/fs.h
> +++ b/include/trace/misc/fs.h
> @@ -120,3 +120,24 @@
>  		{ LOOKUP_BENEATH,	"BENEATH" }, \
>  		{ LOOKUP_IN_ROOT,	"IN_ROOT" }, \
>  		{ LOOKUP_CACHED,	"CACHED" })
> +
> +#define show_ia_valid_flags(flags)			\
> +	__print_flags(flags, "|",			\
> +		{ ATTR_MODE,		"MODE" },	\
> +		{ ATTR_UID,		"UID" },	\
> +		{ ATTR_GID,		"GID" },	\
> +		{ ATTR_SIZE,		"SIZE" },	\
> +		{ ATTR_ATIME,		"ATIME" },	\
> +		{ ATTR_MTIME,		"MTIME" },	\
> +		{ ATTR_CTIME,		"CTIME" },	\
> +		{ ATTR_ATIME_SET,	"ATIME_SET" },	\
> +		{ ATTR_MTIME_SET,	"MTIME_SET" },	\
> +		{ ATTR_FORCE,		"FORCE" },	\
> +		{ ATTR_KILL_SUID,	"KILL_SUID" },	\
> +		{ ATTR_KILL_SGID,	"KILL_SGID" },	\
> +		{ ATTR_FILE,		"FILE" },	\
> +		{ ATTR_KILL_PRIV,	"KILL_PRIV" },	\
> +		{ ATTR_OPEN,		"OPEN" },	\
> +		{ ATTR_TIMES_SET,	"TIMES_SET" },	\
> +		{ ATTR_TOUCH,		"TOUCH"},	\
> +		{ ATTR_DELEG,		"DELEG"})
> 


-- 
Chuck Lever

