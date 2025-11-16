Return-Path: <linux-nfs+bounces-16427-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1380C60DFB
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Nov 2025 01:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A622E241ED
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Nov 2025 00:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE7528F5;
	Sun, 16 Nov 2025 00:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pYxbCgTo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XeDzz7bG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6164C92
	for <linux-nfs@vger.kernel.org>; Sun, 16 Nov 2025 00:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763251580; cv=fail; b=avdUBBXyffNujf2rrr9nm1AWXBZ68kiAWSBds/+yDI7EU3oS+BAioBVyX1zrJaN2fEuBDlR/l0zaKiv1msorrVlmHIKbw1mZMGBTxDE2DSvYO9n4klO81cI1a1vM35LXudTyMq5T4sF+/i/601SiPJn0vTpXJ9oDvBgm41RJYIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763251580; c=relaxed/simple;
	bh=luuuKjNBqwCBRQ75e94FxwGvLboSu+ehrX6gSVE7lOE=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gkwEpdMWeb36UIl2DaP47Z5L37ccnVm+BdlmHePuEZxCZ6S88qPW5hnbSsWU/W3CrclHcYzR/SNMDLMFkCuagGe6dJVCW+Qecz5gYEjnBv5ow4UKNJprnMLF6VcdZEyMdW0L/ATZ34Uw8sEuhgNdam0ndmxM3CL7s6rPuW7he/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pYxbCgTo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XeDzz7bG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AFNt15C030383;
	Sun, 16 Nov 2025 00:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sUzDEjWsa1Gj3aAZQ3C9cEVL4bDaO57W2j4JInXYUBM=; b=
	pYxbCgTosaReSYZryw6z7OxS8K2yQEqtFW21LM2OzpTxH1Ndm1BF7DsE6Pns1DhQ
	5eLcZ4fQYMfU3VSMYivUHithPEB2GXZTMgFKYBLVW8PCiKW449cyOMqBnub/6LX1
	zPWzBygfGYahkHnHVVd8ecEKS/waneeDp8hBqEmJzeey4DhS0NM5PIbid0XFINRy
	GDZNxBwiVXhEKybmAuuBEFK1aWt0bjKnNlBFULMxi5DNbALxVSVTq2stgpgDUBrB
	hrmrHkT2KeYwjUGxAzG/TDcGVfPYa2p5mh9Ku/SJjB7tQSLIkHpF8cFx39X+hIBX
	JPEfuI/FaGK7tjukC/i65g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbb8jyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 16 Nov 2025 00:06:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AFIUFuW007832;
	Sun, 16 Nov 2025 00:06:06 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy6c872-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 16 Nov 2025 00:06:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKGj/NkallnzzsiGlBSVHfGk/QzhhrZXp4Gr4Mv2LLrbB4Q3xDbbIZ5LNIlAUHL7Ob2Bp9ITJjmoaggZtDJwxoYkGdP6Jk8q1gz1pxZS9YXHr8hLamB9zhTJngorDpo+ruT+R3VjBxoUzRBxBlESZf5R6BIKxLrTzPIctWFxAwNTGUFTp1DTBDRFqS6SM6abockg17Pu4uJLv0OJRL20Ja+Y/tk/4ROoUzz7mxUflDOW210/Bgy8wNbBPFt4GywyE7XoCOzjiCnonBIbooEwB+tsvCrRmvKLdGhTb9cqnyBkbxKkw6KjMonxJDS8UtlHormoBgwgcSbqg3DxPIyjhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUzDEjWsa1Gj3aAZQ3C9cEVL4bDaO57W2j4JInXYUBM=;
 b=dK5LzUSD2Mo2+Tr6tEZunqYAltwepPBrXozl0VhPJMYuc9Z9PoZ0HsDKOyN7UKFDyh2BXjABWLXPxIwJTDQ3lECDixF72PFnTm+stvx+zEb94f0/G5cTD4noOuGkQNhCQGmCFC+SGhGY+/HCfmO+iHKqobp2vofmB9zsorZ48BoOdTSQbOpS645MOmBZUFqTwnoHNd2EGQ0hYSIWQX24XCTH8AjUncuQgZdHHtt0bbYjc7r7VbkShyKRzw7fK5JEffykukhO67gNWENEiMgsLW/o2rIQsnhwhGLd1QSb4DW/cxNeCCrGoh/Qj6ZLCHY1RigS1UhswqE+ZWBvfLhR5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUzDEjWsa1Gj3aAZQ3C9cEVL4bDaO57W2j4JInXYUBM=;
 b=XeDzz7bGN8fEk9DIzw/COcJeBb6+fPlSULMVA+uxBgFjKjcKkPxf9AunncMqV3lF6u0JBrO5/Gc2ipfVTM3vlzh1/PePMNYhCrm9oHeFEqgTExaGIs2P46oo9cuimyhiCHFY4raqByVYxLBkf1o7M/e4kSQJoaAMm54DatnyJAY=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by SA1PR10MB6494.namprd10.prod.outlook.com (2603:10b6:806:2b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Sun, 16 Nov
 2025 00:06:00 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%6]) with mapi id 15.20.9320.018; Sun, 16 Nov 2025
 00:06:00 +0000
Message-ID: <95aec38e-0eeb-48bb-a313-a3ca88da12af@oracle.com>
Date: Sun, 16 Nov 2025 00:05:57 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, NeilBrown <neil@brown.name>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] Add tests for OPEN(create) with ACLs
To: Chuck Lever <cel@kernel.org>
References: <20251115170815.20696-1-cel@kernel.org>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
Organization: Oracle
In-Reply-To: <20251115170815.20696-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::15) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|SA1PR10MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: 65fdc36d-6460-441b-dd53-08de24a3ec91
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?blBtUTUwckZEb2RJOXBOZy91L3hYc3I0MmlNdU1tSXdGRmpjNWpnMlQxbU4w?=
 =?utf-8?B?R2JwZ014NU5ady9YUms3Qlp2WTJJU2R4bEQrSUoyVW5oSGY1R2RLWW10Kzc2?=
 =?utf-8?B?TnJZbndxaExiWW82NTlVRS9qZFdSQjJ1MThqdmdNT0hhQVFMa2ZyS0FBVXhN?=
 =?utf-8?B?MVJZdERpYTI5OEpiOTlXSFhHM0I2eGdoWUlSUi9SMVNKd05iVVBmWURZdVM4?=
 =?utf-8?B?YkVkV0NHTzJycXBNQWpqbGtQbDlKdXFGbmdzY01vdW9wSTZzM045U282V1hB?=
 =?utf-8?B?ZFEwLzdOeXRBeVQxN092KzhuTDVBM21aVkw0UlVpNWl2OXZrQXoyOEJNM3NN?=
 =?utf-8?B?TUl0UkxnRk5GbFBXaGhuVmlkV3o2Wk9YS244bUxJbmxranRDMlVWVVd3eEFL?=
 =?utf-8?B?Wk03NytqbXhWMFg0MmFodndQYW1sdStKTHlCcmZ0ZDJTc1NJbitiQU1SWXJU?=
 =?utf-8?B?d0NEOVZJZ0Y1N0cyT3ZTTWZEZ0o3ZWt5ZThrNmtlL0wzYkhxM1gyNDNLREtE?=
 =?utf-8?B?NkxEM0V5b0RZc1hsSHZHNVN2S3pwMHpkK3B6YTBlRG5XRHFzMUdQR09EMitV?=
 =?utf-8?B?VU9oZFNJR1Fld1JWRUdocDhiN0RhSFdkT0RTaE5NMkN1K1R3MUMrZHZMZ0xo?=
 =?utf-8?B?ektsakNnekhLTklEZ0hvTHF1TmxseFpCMGcrd2VtdHFidGU5VDRZM1N6ZVho?=
 =?utf-8?B?R01XbHAxemhkN2VuMTBtTHZ2VlRZcTBIL3NqWFJCYy9nZTVQUkJyWXBPL3Rr?=
 =?utf-8?B?cXZmRFkwMUgwTklsYzE2c1J5c2w0UmFNeURPRG9WbkFNSDRzUWhlZHplbEkx?=
 =?utf-8?B?REprZDAvdnN3bnAvTGtSTk03bWhsNzdzYlkzTlJSeTViOWxUdkdiSkliMkR3?=
 =?utf-8?B?eVZKWTNyRTVBQkE5Z1dFditib2tFd3M0K3dBdmFqZFRNMjkxekdBTTF6dlJn?=
 =?utf-8?B?MFVhb3ZyblNFWDJvTEZENmRNOENDU1N3eUlBbDk5TktPTWlxajMrbDZOeWgy?=
 =?utf-8?B?Z0t0MjNKK2hDWU53MUJHOWdKbHVIQ1VBYS9Pc3d4LzNrUGIybDRFdEIxay9q?=
 =?utf-8?B?ZmNBeGlmUGFCWG9LaTZ2M0hJWG5vVUFrVjh0NW1vbXJSU2MwSzhLWnRGTEtz?=
 =?utf-8?B?TFNRM1I1VTU2UWFERFEvcVpGV3d1aDNSU1Jad3o3eFB2VHF2dEJRVzViekI2?=
 =?utf-8?B?MUJ5RDZjZFgyY094VnJTWWtHQ0lKTTc5eFErajRhSm5OajNuQytUTGVNNHZn?=
 =?utf-8?B?U0tNWXozbjJpNGNsaVZOWklHYjNEQXpyWDY1amEwbzI1QlZWaTdPMTZpdXJY?=
 =?utf-8?B?cEpPbm1aRGtzU3JieXBqVkxqZFp5eFRvZjl2SDRycTRuWk9SWVhpaHVUdFlt?=
 =?utf-8?B?c1ZqYjFsdzdRU3lLVHd4L0VadndaRHZacjNYUDVUc1VrNVVTWnJPZVpGamJI?=
 =?utf-8?B?anhEWXVyUjIyZnBMd0ljK0tiaTVhZ2VHdE5Cd2NrSkxnc0I2a2lNanF4UDc1?=
 =?utf-8?B?czNYNTVBSnJGTzU0UjI5SUx6U1huNXlPdUR3RlJ5czJBREhweGNNS3hmdlZV?=
 =?utf-8?B?amNPNjJwOXZuM3NkaUxHcFRVc0JsSTJCa3BBOHhaZUNkZ3lSeGM3bWwrUUpu?=
 =?utf-8?B?MVgrZnRmdmt5RG1NanZuUjhraFpFZGtjM1dWd3dsb1Y4eUZPU1BTMkl0OGhR?=
 =?utf-8?B?dU04UWIwUHFLOEpwU0dtbG9yTTF2UzNHbmRaL1pIclBaS0hQOFFFQm8wd0w2?=
 =?utf-8?B?Umc1YTNGMmxQRzJBdjlIS1o4UkRIT0JKZW5IMDAzVUpyc3lqUkIyc1EzMng0?=
 =?utf-8?B?NGIrazdSd2loOGw0YnI1R3ZuZ1hMQlNJR1h0bGw3LzkxaE93YUorRUlqc2pr?=
 =?utf-8?B?eHB5ZWc2aWpoRW03T0pvOUdkaTVpbERXM1dBRlpZUlA4RUZZK3U3MVR4QUI3?=
 =?utf-8?Q?71ZamQsiU158yQ+nv1vDegDK0N5ULi+r?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cHF5VDQxYlVCOUdHVFJqeFo2Ky9lTlQ4YzluY3FDcGhMQmNHNkFFU055bXdo?=
 =?utf-8?B?UGlnTmFIM2JySStPd1pwYTFua3hHWjFwekQ0RW5GTkR3M0VUc2tCRU1Rbm9n?=
 =?utf-8?B?eE9JLy81cDJuSkNmVmtaS0xiUktBVWNCUGhrajIzWmo5dVo5RU85akNwK3RH?=
 =?utf-8?B?RTlCdTF1SE9RN3U1ZEU5L29WNEl2ZzB5RnBwWFY2WnByTTQzV3Q5VjZaRzhp?=
 =?utf-8?B?NnR4QmhOeTlXc0JWK3IvNjBOak96MlpRWEQxUElESXVsWlpQYjk2d3Y0aXUv?=
 =?utf-8?B?VVRYaVBpRkh4MmJLNU5GbnZ1WUZtQTdOM1JZbXd6a0IwUk1YbmhtVkNvT2Zi?=
 =?utf-8?B?ejlud1Q4M1k5UmdyZDZnS3cxNlhNaldrM0RxcU5UN1JXWTZybitzTCtZaTZz?=
 =?utf-8?B?NGFkT1ZodEluZUxvSzZJVVQxOS9VUUJOZjhRdTVZTmQzU1lKVVhrQXc3WFpn?=
 =?utf-8?B?bnpUZjVCZDR4ZkhrRDRIQ2RxSy9wYXhmMm8wQ1pWSXR3c1EyeEwvajVCM2l2?=
 =?utf-8?B?R2w2RDJyRmhoVzVIaUlLNzJxRlMzNGVtVFJ2WVhERzZXOXRqcGhZTGxFU0xV?=
 =?utf-8?B?TmVPN2E4b3F1dkFsY2lDWWZKRnA3ZlphdVJIUk5Ybnl0cmxabUE2c3ZTRlQ0?=
 =?utf-8?B?ZUpURGR4YWs4Mkpnc0Q5cHN5clFMVmZpQmZ1TG0zUjFOSVJvOFA2blRiWG5N?=
 =?utf-8?B?TU9mdVpUSVNZRytTNmhYL2p4cGFhZXlpUnBLMW44NzhMOE1YVW95ZzExblJx?=
 =?utf-8?B?ZEE3WFZMeTJpM2dyZW5mRUY4TUxXVGVBZjNwaWlWb01pMy9xOHpzK0orUVBs?=
 =?utf-8?B?WTlOZFJSNkYzSWUwRzluUmZaLzJuTXhLN09LUWJyS2thRzhRM3dnc1Y2VTN5?=
 =?utf-8?B?Vnp2THhkQTRUa1FYbWJua0xOLzBoUzd1UXdIUWZWRm5XMVpTdmdSSHdwa1J6?=
 =?utf-8?B?dldsWXdzV2M2TnRmVW5JS1hLdVgrTGRPWTZ6ZE1sSmtMM0RicTE2K2xSdkNa?=
 =?utf-8?B?T2s2QzBDdHVCY3VhVkxDMGR0elM0R1NzSDM5NnpkQ1VBbTdzeHlBYzFXTTgy?=
 =?utf-8?B?SmNKMnNiRWRWbnphdHlYT25qaTBjS05Ea1dScnpPZlVaLyt3WG04SUNPSFB5?=
 =?utf-8?B?WnJKemlPdW8rVCtKRnJ0OVYreTZNa3NwZXJ6T1pweVp5MVZiNG5ZNjYvNWsv?=
 =?utf-8?B?Yk5tMjVXWTVDTnk0eHd5VmFOTk1hUHBUeXRNemtlczFFQ0ZZY044Um05RFdi?=
 =?utf-8?B?Y0t5bkwvOC9FRkhoczVOZzB3Wmt3bGRzOThpS1AwMDNra25aMDVoUXpGU2cv?=
 =?utf-8?B?TTNWRGV4cmFLZ1VxUGxUSCt2VzlMZ0hYTVpCS0ZUOGcwSXB2M2hPTlRBNGRH?=
 =?utf-8?B?QS9NQllGRkgwdmcxL3FZMSthM3k5eWlyUmhjTnc0Sk1FZTNKckVycW4vNUlh?=
 =?utf-8?B?OUtzVzJzVTYzdXhvclZ2VzQ1Q2daVFlBSWxkelM1OHVOak0rM2VwWlRQZUJW?=
 =?utf-8?B?YXl3cURpZERmdVNLaThCSkRYaHdISW1MV2t3OE4yOWdJQVdKRTJ3a3lWZVRa?=
 =?utf-8?B?bHJ1UnZtcWRPT2Zvd09Zb2tlSnRoOWVPSmdTRk5vUDlNNW55dVRQclVpTTg1?=
 =?utf-8?B?QS9PZ1ltU2xVNVA0WkZWNFJTam5vL3lCSmZsZjV4V0h4UlVHbGxibSsxYTBP?=
 =?utf-8?B?dTNqaTdqT0IrbXZ6Z2l3cFVseG9KUWNJbFJGU0x1MDZtQStsd0RGUlMydHVh?=
 =?utf-8?B?ZUwzN3lKYzc1R1haS2x1cm02UXZEMkxTZzc0WFJYUkcrZVV0MXdCSERIQWdn?=
 =?utf-8?B?TThXYXdDRnhXaFhNYW05Qkg4VTFUejRCbGd0MmtoaHNEOXJTdFRNTm9OQ3lh?=
 =?utf-8?B?NXBEOUZ2ZytvUVZ0dW1jSG8zdUN6MUU3TDArMGdGdzEyejZvRkdhdENqbHkr?=
 =?utf-8?B?V3duNFRpY2hFcExCZVVsTE9aNjhXZzc5Um9MVWpKL0ZuZllLRFpEVTExVndX?=
 =?utf-8?B?TzdlMTJTMnV6VDV4WVBUY0hBV3VmTUozdUFJajZ3d1p6MWVOOEhwZG5LS0VX?=
 =?utf-8?B?RWpxQUR4ckl0OS9vZWZzSytWcmI2WUN2b1VLRU5ickR6OVJ4eVFob3dyMzBC?=
 =?utf-8?Q?23oD+QqyBuqg1prcBRXrWyumv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iN1gfllUYB8/17zjizP2k3vu9VdD8HDuI6xdjEQHqDe+1jwKCnGFInqaeI1fMP370SqrwN3OF6X21ZblLhOvW050l2UJudbv4L535POrlhSH30jdgWaS+fJMehSjcSn4bHV6forZ2xEYFtm6PsUwhjcACCRpOXVeBNkf2lOdF6M/yx0Em4inJwf3cUhkTkGHXY1CziCREKEKa1Eb5I4oF1X5n+E8zJJfA2Z1KlABfI0aO8j249XSh7lSbnHWzzmK2UOqLwIiy5ra9eH1AuLfmiUP6fQ7/7LvTxNAgCUYS/UgUrzA6REug7Tr1hRFDaTGfWFEwNfq3dH3sNCbpHwzx4x4WTgKqw4WAld8OCFQYe6QiVgSiZ7qtiB5K0XMjA7/wUUrKj77u2V+YNc+ev5qSqN9bk7OrrcVW/sCO2OwDfpcfexahOUjG4TVMXVPzJLmVfDdNrLpG1s9jn4vSpC2yBU7tTAITGtd50F3H3Wi9ywIYQrefnoyK4efdXd/tgksr7Z2doPyvBd3qzCW37OcwmkXl3Kgmn5GJDFZ1xUt66GL5SV71q3herPq53JHNDHrDC9V17cp0ADP/u/coh3NJuIu0mnAHtZIQLuFzGUZJ34=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fdc36d-6460-441b-dd53-08de24a3ec91
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 00:06:00.4152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNuTUpEEus2LDYNTxAB2AIJvkKsOI0mI5Y3Kuiir1pNqvdxKCHjp8oaNswWZT586wQBbdYP2AJ/VEVAyDo0BsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-15_09,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511150202
X-Authority-Analysis: v=2.4 cv=BoqQAIX5 c=1 sm=1 tr=0 ts=6919156f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=bmsUf6aftzKqNmuSHbIA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: nVejHSOiKeyWWA8RLYdWnvzO9_0I9tCR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXz3t8vW9PeunX
 OuBAAcwb2d/3fOB+91BejoOudRgSlp6zuKuU/2OETCpzn3DgH0NDaEsgYxse9aCMPMdr/OclBx4
 td+8XQX0Z9jBK+EgfhFFfyTI44gUCe7LBN+rX6dmygjW9nOcxHPZGv+hTf+ogJnwFUagUxWG3gb
 dtD5m09Q8RDppC/HGZRW31PCEI7V4X2dTeLs53okcGquZZ4XqfgRDBJTbAvEOkE8aWkRXNImH37
 XwTXhkdCd2KH6h7Y90hi50O2oGWklPCT5IXnAYg1G+vk/Gc+uRr9jWKo2EZ7teWV9BtcYF5pnX5
 R5KyxZedi8Gv8OWYF5CkL5C2P6p0Hq7as+lRRmjnHoftqPpvDJCj/gWlPCWR5LeTNwkKdv2O7xl
 fPZ3lmlycIsqYMeiD8qrjHVCCPys9A==
X-Proofpoint-GUID: nVejHSOiKeyWWA8RLYdWnvzO9_0I9tCR

On 15/11/2025 5:08 pm, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Check that the server can attach an ACL when it creates a file.

Thanks Chuck, I'll add these to my backlog, and get them in asap.

I can also use the unsupported idea elsewhere, e.g. as we discussed 
relaating to the DELEG24/25 failures, in earlier kernels, for 
unsupported FATTR4_OPEN_ARGUMENTS.

cheers,
c.


> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   nfs4.1/server41tests/environment.py |  92 +++++++++++
>   nfs4.1/server41tests/st_open.py     | 238 +++++++++++++++++++++++++++-
>   2 files changed, 327 insertions(+), 3 deletions(-)
> 
> diff --git a/nfs4.1/server41tests/environment.py b/nfs4.1/server41tests/environment.py
> index 48284e029634..0b39bce29870 100644
> --- a/nfs4.1/server41tests/environment.py
> +++ b/nfs4.1/server41tests/environment.py
> @@ -277,6 +277,98 @@ debug_fail = False
>   def fail(msg):
>       raise testmod.FailureException(msg)
>   
> +def unsupported(msg):
> +    raise testmod.UnsupportedException(msg)
> +
> +def access_mask_to_str(mask):
> +    """Convert an ACE access_mask to a symbolic string representation"""
> +    perms = [
> +        (ACE4_READ_DATA, "READ_DATA"),
> +        (ACE4_WRITE_DATA, "WRITE_DATA"),
> +        (ACE4_APPEND_DATA, "APPEND_DATA"),
> +        (ACE4_READ_NAMED_ATTRS, "READ_NAMED_ATTRS"),
> +        (ACE4_WRITE_NAMED_ATTRS, "WRITE_NAMED_ATTRS"),
> +        (ACE4_EXECUTE, "EXECUTE"),
> +        (ACE4_DELETE_CHILD, "DELETE_CHILD"),
> +        (ACE4_READ_ATTRIBUTES, "READ_ATTRIBUTES"),
> +        (ACE4_WRITE_ATTRIBUTES, "WRITE_ATTRIBUTES"),
> +        (ACE4_DELETE, "DELETE"),
> +        (ACE4_READ_ACL, "READ_ACL"),
> +        (ACE4_WRITE_ACL, "WRITE_ACL"),
> +        (ACE4_WRITE_OWNER, "WRITE_OWNER"),
> +        (ACE4_SYNCHRONIZE, "SYNCHRONIZE"),
> +    ]
> +    return " | ".join(name for bit, name in perms if mask & bit) or "(none)"
> +
> +def attr_bitmap_to_str(bitmap):
> +    """Convert an attribute bitmap to a symbolic string representation"""
> +    attrs = [
> +        (FATTR4_SUPPORTED_ATTRS, "SUPPORTED_ATTRS"),
> +        (FATTR4_TYPE, "TYPE"),
> +        (FATTR4_FH_EXPIRE_TYPE, "FH_EXPIRE_TYPE"),
> +        (FATTR4_CHANGE, "CHANGE"),
> +        (FATTR4_SIZE, "SIZE"),
> +        (FATTR4_LINK_SUPPORT, "LINK_SUPPORT"),
> +        (FATTR4_SYMLINK_SUPPORT, "SYMLINK_SUPPORT"),
> +        (FATTR4_NAMED_ATTR, "NAMED_ATTR"),
> +        (FATTR4_FSID, "FSID"),
> +        (FATTR4_UNIQUE_HANDLES, "UNIQUE_HANDLES"),
> +        (FATTR4_LEASE_TIME, "LEASE_TIME"),
> +        (FATTR4_RDATTR_ERROR, "RDATTR_ERROR"),
> +        (FATTR4_ACL, "ACL"),
> +        (FATTR4_ACLSUPPORT, "ACLSUPPORT"),
> +        (FATTR4_ARCHIVE, "ARCHIVE"),
> +        (FATTR4_CANSETTIME, "CANSETTIME"),
> +        (FATTR4_CASE_INSENSITIVE, "CASE_INSENSITIVE"),
> +        (FATTR4_CASE_PRESERVING, "CASE_PRESERVING"),
> +        (FATTR4_CHOWN_RESTRICTED, "CHOWN_RESTRICTED"),
> +        (FATTR4_FILEHANDLE, "FILEHANDLE"),
> +        (FATTR4_FILEID, "FILEID"),
> +        (FATTR4_FILES_AVAIL, "FILES_AVAIL"),
> +        (FATTR4_FILES_FREE, "FILES_FREE"),
> +        (FATTR4_FILES_TOTAL, "FILES_TOTAL"),
> +        (FATTR4_FS_LOCATIONS, "FS_LOCATIONS"),
> +        (FATTR4_HIDDEN, "HIDDEN"),
> +        (FATTR4_HOMOGENEOUS, "HOMOGENEOUS"),
> +        (FATTR4_MAXFILESIZE, "MAXFILESIZE"),
> +        (FATTR4_MAXLINK, "MAXLINK"),
> +        (FATTR4_MAXNAME, "MAXNAME"),
> +        (FATTR4_MAXREAD, "MAXREAD"),
> +        (FATTR4_MAXWRITE, "MAXWRITE"),
> +        (FATTR4_MIMETYPE, "MIMETYPE"),
> +        (FATTR4_MODE, "MODE"),
> +        (FATTR4_NO_TRUNC, "NO_TRUNC"),
> +        (FATTR4_NUMLINKS, "NUMLINKS"),
> +        (FATTR4_OWNER, "OWNER"),
> +        (FATTR4_OWNER_GROUP, "OWNER_GROUP"),
> +        (FATTR4_QUOTA_AVAIL_HARD, "QUOTA_AVAIL_HARD"),
> +        (FATTR4_QUOTA_AVAIL_SOFT, "QUOTA_AVAIL_SOFT"),
> +        (FATTR4_QUOTA_USED, "QUOTA_USED"),
> +        (FATTR4_RAWDEV, "RAWDEV"),
> +        (FATTR4_SPACE_AVAIL, "SPACE_AVAIL"),
> +        (FATTR4_SPACE_FREE, "SPACE_FREE"),
> +        (FATTR4_SPACE_TOTAL, "SPACE_TOTAL"),
> +        (FATTR4_SPACE_USED, "SPACE_USED"),
> +        (FATTR4_SYSTEM, "SYSTEM"),
> +        (FATTR4_TIME_ACCESS, "TIME_ACCESS"),
> +        (FATTR4_TIME_ACCESS_SET, "TIME_ACCESS_SET"),
> +        (FATTR4_TIME_BACKUP, "TIME_BACKUP"),
> +        (FATTR4_TIME_CREATE, "TIME_CREATE"),
> +        (FATTR4_TIME_DELTA, "TIME_DELTA"),
> +        (FATTR4_TIME_METADATA, "TIME_METADATA"),
> +        (FATTR4_TIME_MODIFY, "TIME_MODIFY"),
> +        (FATTR4_TIME_MODIFY_SET, "TIME_MODIFY_SET"),
> +        (FATTR4_MOUNTED_ON_FILEID, "MOUNTED_ON_FILEID"),
> +        (FATTR4_SUPPATTR_EXCLCREAT, "SUPPATTR_EXCLCREAT"),
> +        (FATTR4_SEC_LABEL, "SEC_LABEL"),
> +        (FATTR4_XATTR_SUPPORT, "XATTR_SUPPORT"),
> +    ]
> +    result = []
> +    for bit, name in attrs:
> +        if bitmap & (1 << bit):
> +            result.append(name)
> +    return ", ".join(result) if result else "(none)"
> +
>   def check(res, stat=NFS4_OK, msg=None, warnlist=[]):
>   
>       if type(stat) is str:
> diff --git a/nfs4.1/server41tests/st_open.py b/nfs4.1/server41tests/st_open.py
> index 28540b59a8fe..2a06f301543a 100644
> --- a/nfs4.1/server41tests/st_open.py
> +++ b/nfs4.1/server41tests/st_open.py
> @@ -1,11 +1,11 @@
>   from .st_create_session import create_session
>   from xdrdef.nfs4_const import *
>   
> -from .environment import check, fail, create_file, open_file, close_file, write_file, read_file
> -from .environment import open_create_file_op
> +from .environment import check, fail, unsupported, create_file, open_file, close_file, write_file, read_file
> +from .environment import open_create_file_op, do_getattrdict, access_mask_to_str, attr_bitmap_to_str
>   from xdrdef.nfs4_type import open_owner4, openflag4, createhow4, open_claim4
>   from xdrdef.nfs4_type import creatverfattr, fattr4, stateid4, locker4, lock_owner4
> -from xdrdef.nfs4_type import open_to_lock_owner4
> +from xdrdef.nfs4_type import open_to_lock_owner4, nfsace4
>   import nfs_ops
>   op = nfs_ops.NFS4ops()
>   import threading
> @@ -17,6 +17,61 @@ def expect(res, seqid):
>       if got != seqid:
>           fail("Expected open_stateid.seqid == %i, got %i" % (seqid, got))
>   
> +def make_test_acl():
> +    """Create a test ACL that maps cleanly to POSIX ACLs
> +
> +    Uses OWNER@, GROUP@, and EVERYONE@ to match POSIX user/group/other
> +    structure, which helps servers that map NFSv4 ACLs to POSIX ACLs.
> +
> +    Includes both WRITE_DATA and APPEND_DATA for write permission, since
> +    Linux NFS server's conservative NFSv4-to-POSIX mapping requires both
> +    to grant POSIX write permission.
> +    """
> +    return [
> +        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
> +                ACE4_READ_DATA | ACE4_WRITE_DATA | ACE4_APPEND_DATA | ACE4_READ_ACL,
> +                b"OWNER@"),
> +        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
> +                ACE4_READ_DATA,
> +                b"GROUP@"),
> +        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
> +                ACE4_READ_DATA,
> +                b"EVERYONE@")
> +    ]
> +
> +def verify_acl(returned_acl, expected_acl):
> +    """Verify that returned ACL contains expected ACEs
> +
> +    Server may add additional ACEs, but the requested ones must be present
> +    with at least the requested permissions.
> +    """
> +    if len(returned_acl) < len(expected_acl):
> +        fail("Returned ACL has fewer entries than requested: "
> +             "expected at least %d, got %d" % (len(expected_acl), len(returned_acl)))
> +
> +    # Verify the ACEs we set are present (server may add additional ACEs)
> +    for i, expected_ace in enumerate(expected_acl):
> +        if i >= len(returned_acl):
> +            fail("Missing ACE %d in returned ACL" % i)
> +        returned_ace = returned_acl[i]
> +        if returned_ace.type != expected_ace.type:
> +            fail("ACE %d type mismatch: expected %d, got %d" %
> +                 (i, expected_ace.type, returned_ace.type))
> +        if returned_ace.who != expected_ace.who:
> +            fail("ACE %d who mismatch: expected %s, got %s" %
> +                 (i, expected_ace.who, returned_ace.who))
> +        # Check that requested permissions are present (server may add more)
> +        if (returned_ace.access_mask & expected_ace.access_mask) != expected_ace.access_mask:
> +            missing = expected_ace.access_mask & ~returned_ace.access_mask
> +            fail("ACE %d access_mask mismatch:\n"
> +                 "  Expected: %s\n"
> +                 "  Got:      %s\n"
> +                 "  Missing:  %s" %
> +                 (i,
> +                  access_mask_to_str(expected_ace.access_mask),
> +                  access_mask_to_str(returned_ace.access_mask),
> +                  access_mask_to_str(missing)))
> +
>   def testSupported(t, env):
>       """Do a simple OPEN create
>   
> @@ -195,3 +250,180 @@ def testCloseWithZeroSeqid(t, env):
>       stateid.seqid = 0
>       res = close_file(sess1, fh, stateid=stateid)
>       check(res)
> +
> +def testSuppattrExclcreat(t, env):
> +    """Check that FATTR4_SUPPATTR_EXCLCREAT is supported and valid
> +
> +    FLAGS: open all
> +    CODE: OPEN12
> +    """
> +    sess = env.c1.new_client_session(env.testname(t))
> +    res = sess.compound([op.putrootfh(),
> +                        op.getattr(nfs4lib.list2bitmap([FATTR4_SUPPORTED_ATTRS,
> +                                                         FATTR4_SUPPATTR_EXCLCREAT]))])
> +    check(res)
> +    attrs_info = res.resarray[-1].obj_attributes
> +
> +    if FATTR4_SUPPORTED_ATTRS not in attrs_info:
> +        fail("Server did not return FATTR4_SUPPORTED_ATTRS")
> +
> +    # Check if SUPPATTR_EXCLCREAT is in the supported attributes
> +    supported = attrs_info[FATTR4_SUPPORTED_ATTRS]
> +    if not (supported & (1 << FATTR4_SUPPATTR_EXCLCREAT)):
> +        unsupported("Server does not support FATTR4_SUPPATTR_EXCLCREAT")
> +
> +    # If supported, check that it was returned
> +    if FATTR4_SUPPATTR_EXCLCREAT not in attrs_info:
> +        fail("FATTR4_SUPPATTR_EXCLCREAT not returned even though it "
> +             "appears in FATTR4_SUPPORTED_ATTRS")
> +
> +def testSuppattrExclcreatSubset(t, env):
> +    """FATTR4_SUPPATTR_EXCLCREAT must be subset of SUPPORTED_ATTRS
> +
> +    FLAGS: open all
> +    CODE: OPEN13
> +    DEPEND: OPEN12
> +    """
> +    sess = env.c1.new_client_session(env.testname(t))
> +    res = sess.compound([op.putrootfh(),
> +                        op.getattr(nfs4lib.list2bitmap([FATTR4_SUPPORTED_ATTRS,
> +                                                         FATTR4_SUPPATTR_EXCLCREAT]))])
> +    check(res)
> +    attrs_info = res.resarray[-1].obj_attributes
> +
> +    supported = attrs_info[FATTR4_SUPPORTED_ATTRS]
> +    excl_supported = attrs_info[FATTR4_SUPPATTR_EXCLCREAT]
> +
> +    # SUPPATTR_EXCLCREAT must be a subset of SUPPORTED_ATTRS
> +    # i.e., every bit set in excl_supported must also be set in supported
> +    invalid = excl_supported & ~supported
> +    if invalid != 0:
> +        fail("FATTR4_SUPPATTR_EXCLCREAT contains attributes not in "
> +             "FATTR4_SUPPORTED_ATTRS:\n"
> +             "  Invalid attributes: %s" % attr_bitmap_to_str(invalid))
> +
> +def testACLSupported(t, env):
> +    """Check that server supports FATTR4_ACL attribute
> +
> +    FLAGS: open acl all
> +    CODE: OPEN8a
> +    """
> +    sess = env.c1.new_client_session(env.testname(t))
> +    res = sess.compound([op.putrootfh(),
> +                        op.getattr(nfs4lib.list2bitmap([FATTR4_SUPPORTED_ATTRS]))])
> +    check(res)
> +    attrs_info = res.resarray[-1].obj_attributes
> +    if FATTR4_SUPPORTED_ATTRS not in attrs_info:
> +        fail("Server did not return FATTR4_SUPPORTED_ATTRS")
> +    supported = attrs_info[FATTR4_SUPPORTED_ATTRS]
> +    if not (supported & (1 << FATTR4_ACL)):
> +        unsupported("Server does not support FATTR4_ACL attribute")
> +
> +def testACLExclusiveSupported(t, env):
> +    """Check that server supports setting ACL during EXCLUSIVE4_1 create
> +
> +    FLAGS: open acl all
> +    CODE: OPEN8b
> +    """
> +    sess = env.c1.new_client_session(env.testname(t))
> +    res = sess.compound([op.putrootfh(),
> +                        op.getattr(nfs4lib.list2bitmap([FATTR4_SUPPATTR_EXCLCREAT]))])
> +    check(res)
> +    attrs_info = res.resarray[-1].obj_attributes
> +    if FATTR4_SUPPATTR_EXCLCREAT not in attrs_info:
> +        unsupported("Server does not support FATTR4_SUPPATTR_EXCLCREAT")
> +    excl_supported = attrs_info[FATTR4_SUPPATTR_EXCLCREAT]
> +    if not (excl_supported & (1 << FATTR4_ACL)):
> +        unsupported("Server does not support setting FATTR4_ACL during "
> +                    "EXCLUSIVE4_1 create")
> +
> +def testOpenCreateWithACLUnchecked(t, env):
> +    """OPEN with UNCHECKED4 CREATE setting NFSv4 ACL attribute
> +
> +    FLAGS: open acl all
> +    CODE: OPEN9
> +    DEPEND: OPEN8a
> +    """
> +    sess = env.c1.new_client_session(env.testname(t))
> +    acl = make_test_acl()
> +
> +    # Create file with ACL attribute using UNCHECKED4 mode
> +    attrs = {FATTR4_MODE: 0o644, FATTR4_ACL: acl}
> +    res = create_file(sess, env.testname(t), attrs=attrs, mode=UNCHECKED4)
> +    check(res)
> +    expect(res, seqid=1)
> +
> +    fh = res.resarray[-1].object
> +    stateid = res.resarray[-2].stateid
> +
> +    # Verify the ACL was set correctly by reading it back
> +    attrs_dict = do_getattrdict(sess, fh, [FATTR4_ACL])
> +    if FATTR4_ACL not in attrs_dict:
> +        fail("ACL attribute not returned after OPEN with CREATE")
> +
> +    verify_acl(attrs_dict[FATTR4_ACL], acl)
> +
> +    res = close_file(sess, fh, stateid=stateid)
> +    check(res)
> +
> +def testOpenCreateWithACLGuarded(t, env):
> +    """OPEN with GUARDED4 CREATE setting NFSv4 ACL attribute
> +
> +    FLAGS: open acl all
> +    CODE: OPEN10
> +    DEPEND: OPEN8a
> +    """
> +    sess = env.c1.new_client_session(env.testname(t))
> +    acl = make_test_acl()
> +
> +    # Create file with ACL attribute using GUARDED4 mode
> +    attrs = {FATTR4_MODE: 0o644, FATTR4_ACL: acl}
> +    res = create_file(sess, env.testname(t), attrs=attrs, mode=GUARDED4)
> +    check(res)
> +    expect(res, seqid=1)
> +
> +    fh = res.resarray[-1].object
> +    stateid = res.resarray[-2].stateid
> +
> +    # Verify the ACL was set correctly by reading it back
> +    attrs_dict = do_getattrdict(sess, fh, [FATTR4_ACL])
> +    if FATTR4_ACL not in attrs_dict:
> +        fail("ACL attribute not returned after OPEN with CREATE")
> +
> +    verify_acl(attrs_dict[FATTR4_ACL], acl)
> +
> +    res = close_file(sess, fh, stateid=stateid)
> +    check(res)
> +
> +def testOpenCreateWithACLExclusive(t, env):
> +    """OPEN with EXCLUSIVE4_1 CREATE setting NFSv4 ACL attribute
> +
> +    FLAGS: open acl all
> +    CODE: OPEN11
> +    DEPEND: OPEN8b
> +    """
> +    sess = env.c1.new_client_session(env.testname(t))
> +    acl = make_test_acl()
> +
> +    # Create file with ACL attribute using EXCLUSIVE4_1 mode
> +    # EXCLUSIVE4_1 allows attributes to be set atomically with create
> +    # Don't set MODE with ACL - let the ACL determine permissions
> +    attrs = {FATTR4_ACL: acl}
> +    verifier = b"testverif"
> +    res = create_file(sess, env.testname(t), attrs=attrs,
> +                      mode=EXCLUSIVE4_1, verifier=verifier)
> +    check(res)
> +    expect(res, seqid=1)
> +
> +    fh = res.resarray[-1].object
> +    stateid = res.resarray[-2].stateid
> +
> +    # Verify the ACL was set correctly by reading it back
> +    attrs_dict = do_getattrdict(sess, fh, [FATTR4_ACL])
> +    if FATTR4_ACL not in attrs_dict:
> +        fail("ACL attribute not returned after OPEN with CREATE")
> +
> +    verify_acl(attrs_dict[FATTR4_ACL], acl)
> +
> +    res = close_file(sess, fh, stateid=stateid)
> +    check(res)

-- 
Calum Mackay
Linux Kernel Engineering
Oracle Linux and Virtualisation


