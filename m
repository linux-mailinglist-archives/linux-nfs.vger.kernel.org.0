Return-Path: <linux-nfs+bounces-19100-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC79B7pym2kizwMAu9opvQ
	(envelope-from <linux-nfs+bounces-19100-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 22:18:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC0B170637
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 22:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73BA33009F02
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 21:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109541A2C04;
	Sun, 22 Feb 2026 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r2x1ZZ5v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pa1e07dj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CC211CAF
	for <linux-nfs@vger.kernel.org>; Sun, 22 Feb 2026 21:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771795126; cv=fail; b=uoFE516gwvEHol8A5ZXSGUdivcjCoL3cgDDdrsgiyEnq8SbjIadklMNipE9+3IW+6kRBGDbkikV6+GEn6oZMvtrOMxAJrZo1pW+Qggwd/5YoU3IH9ILEE5L91A6hgSg52+YR3s3JDBTZkKbjLVsIcIGLUf1k8x74JJca4gid8Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771795126; c=relaxed/simple;
	bh=Tj87XImqhN/2l7LF4KLpIhu2yv3qkJ0FpgHLqZR1hA8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uhytzi8DwUAPPy/kfzGnCCSJ7gidFE0x3SVc8UzVEG9AknQ9Yz4Ov3thrCkVc0GdRapFa3Tyro+HXfTP27e1TAEijLWJPhcTcqYZv2WUGiEgifpxvr6luRx/5fzTqpNK/5mS2RQ1Mzsm4ZOUCtPBKq3drGVAuCyzF/HAKX3KoWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r2x1ZZ5v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Pa1e07dj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MLFfL5499655;
	Sun, 22 Feb 2026 21:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uGxCs2lcNuAnG1UkJlIeo8+Pq1ib7GdCmnKUL3xiMdA=; b=
	r2x1ZZ5vfNFQVCPvqm53UefEwanAQUov5I3wJJ69qowwPFURqti415qayv4ldifI
	SOUNqoT4KFHZr6tm57mCKmv0ZoE7XmDzTehUKDc+QHHjMAcSD6mX2dpQBLr2d6MS
	m8j2TzcyJfqIk4hUDhHI4zx4UIqWlmQNd9OM7bQZzLF5wZ2hUJyBCtQlS7iyzU2C
	u+fZEBBalHu3UAq/WyODPhvk850Kk/YTpvR6MQgffbkZFgNMTX8nBBcpNlrfjo4v
	uE5RlKxvinocgwxk7zRfHRxirPUFlo0FCSswwL1gEV5FCqhw/YRi4BTbqwStttcv
	vAxV6UyTYRO2EdNBCIwiqw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4ar99xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Feb 2026 21:18:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61MGxJGW006332;
	Sun, 22 Feb 2026 21:18:33 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf357wuj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Feb 2026 21:18:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnDCojIYD6ajCu5OfZU3gEqqgbSETObPIiyok+Y0vAC9i5m6Z3M2OB/X4uOnbZQOYAWPxkJPTD3u8SbEpL15QwAXRXCcFYInnZ9NRyodGelmh4X90oQFKXyMqVIKuVbglcyU2DTxjpikxQku0YuQJudhxsTVBsDeJ8Htoc1SaeOFsMtkqmegT995k/JCTOqT2j4aq1BnUjVThxQJ3Cb9PbtJ+MrCEuRwPsBsgxyzdj6PAL7yuimDN9BLf4zRki48gCI7aFiGGe4+fHUOYUU1vl2uMygb3A76Kjg695z8kyBNHyaa2X2ojRSUOq1UF7VuAsrKO5/t+yQtgfoaY+0mVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGxCs2lcNuAnG1UkJlIeo8+Pq1ib7GdCmnKUL3xiMdA=;
 b=Dt5MBlf6F6qoprwQBWe2r2ff4SSde1RBy6g0UmSHyGF9IXhfxi02istGKS5s98LUVRGnW7qW/x687K6OLLx3fUreub6o7j9Qp3SNE4Hg2H8FeHgoAvIttn9hsr3B6Y/1v9hvDpfaj/NoO3/ydAyoZ3hJZdJKoZNIvB7PSbT7EMk5LuzJqJXaSgqJguZjVj1SJnK87MBjvdi/v23Lv74/cZTrQqK8clsskR6XV+16jCAMtOR+r5iebS/WFM1h4CacEn6qwe1W1BruTogJJdW9FXnSQnB+eiLPw1jEKGIWRp7f0yhPn4k0cG/TrKLR3FhgJUKr49Vjo099LKX83SXY/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGxCs2lcNuAnG1UkJlIeo8+Pq1ib7GdCmnKUL3xiMdA=;
 b=Pa1e07djyaLjs8tqDggLZwQTGgXklW5wDikb/bf/+9LAZui197DndVqgRhAy4cMn9eImd5DULKZf7RTu9BW8zAbU9ulGhKrJVhhYgX+cSpTgD9gEwycEuPjyenzG3TXKEyBZcusZx0iaKivvtXyzCT/gT/8111X7Hd34blLqU04=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by IA3PR10MB8090.namprd10.prod.outlook.com (2603:10b6:208:50e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Sun, 22 Feb
 2026 21:18:29 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9632.017; Sun, 22 Feb 2026
 21:18:29 +0000
Message-ID: <831ee3d3-4d5d-4b63-80e6-51d1e5907666@oracle.com>
Date: Sun, 22 Feb 2026 13:18:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: Expose callback statistics in
 /proc/net/rpc/nfsd
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
References: <20260221215733.3643669-1-dai.ngo@oracle.com>
 <8d11898b-9889-43b5-bb96-445870367949@app.fastmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <8d11898b-9889-43b5-bb96-445870367949@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::27) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|IA3PR10MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: b8dc10f2-dc99-49bc-4010-08de7257ecb3
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SjJxUXRJSzI1b0hZVEh4V1A3WUdTN2pFd2RuVjRLekY3OGRQcVNIMVd3bE9p?=
 =?utf-8?B?L2NQY1BMQ2Y2SnlnQ3hGOTN4czlYeVdBNVFtRzQvanRmejZsZFNFQTRWNzdy?=
 =?utf-8?B?RklkcHFuSFZTSnJNcExlbDFTaDVWVEl6VVhkQUQzWnhac1lDd3Vvayt4VVN5?=
 =?utf-8?B?Z1RjMUltOWNVblFHVlFUb1ZyT2o5ZTlrckNzWmtPT1NkRndLb1FadUl6Tjlu?=
 =?utf-8?B?SkNaMXpJbGtncEt4NG8xMTB3NGkvRy81QnY0dzVwc3hnNi9MSDJwc2JCbWpk?=
 =?utf-8?B?RU1IMGNHR3ZLVWxlMXY3Z0FhaGhjZit3R0srT0JWWENXQUZ3THBCcTdJRmJU?=
 =?utf-8?B?QU1DTy9MQWVQL2ZJSkVqVVJrcGFDNms4cDRPWUpCT0UwOThkMkt3aWZxZklk?=
 =?utf-8?B?bXA2KzVjWDVvSXJXQzE0SHllTG1MeEVIcFpCVnpVbkZPaDh1RjlkV3F2T3dl?=
 =?utf-8?B?Skx5cHBlMnR2RlJnQVZ5ZWdUVTF0ZzNDRlNOUm1Kc1E1dnJEL3M0REt1SXJY?=
 =?utf-8?B?WndyRGJ6akVKM0tMellWNWh3VlJLd3REMWM0cGwxd0M0d29COWJSWmlMV1J6?=
 =?utf-8?B?cVZMVXhZU0JIYy8vNnJhaVJpSDY3VnpjT3Nwc2VCOEtsUStWeUo2NW5qeDlv?=
 =?utf-8?B?Y3FjdDNzbS9BTC93L0ZFM1p3aUlUSCtWejNXOHNOSTVvTDYvL0RRSHNoYytr?=
 =?utf-8?B?SXJlNTdQYVhFVE1LWEw1R09Ld2dJV2dZUXB6UE1rS0ZDUUNaZmUvWUhJZTI5?=
 =?utf-8?B?UG5uMmFvdGR5eDA3SmlHRHFmZDZqMmZaYjhkNzF6SytEeVRrRm1NU1BHUDZi?=
 =?utf-8?B?TGZrVkRmMVNwOURla09obzdBd1VvUk0xV2lrMUNhUVg5dzU2UTV1MU92dzZ1?=
 =?utf-8?B?TUZLd2piSklhN0h0V2xhOUhPSjBYcHpuUFMzVHVRZW03enhjZjRmb0xEZTM1?=
 =?utf-8?B?Q240aXdvUktGazNxeHdzZndFWHMvU3FBUE4xeDRWZGlZbmFBNGZDWkVCOTJK?=
 =?utf-8?B?eGQyaUxDcnR5eGpHWWdCQmpKK0pVREdwM3JZcE9ZZ0FDTzU1QVdnTkJJSFEr?=
 =?utf-8?B?R1d1cjVQVTNEUkczOGRvYk5QUW9IYjVFRWlRbTVmVEk0MkR0YnVIZm1lTjRW?=
 =?utf-8?B?bEk4RXVKbXV0cStyNFU5Vkw5MklRS0VlWExqZWRKNHVuQjBjdEN0OEcrZ0Rt?=
 =?utf-8?B?VzRJVEc0eVdKc0dJaWQxRmRwR2VFKy9yWnJOSGI4K1FxWkthSUdmRlpSamY0?=
 =?utf-8?B?T1U2SzdUYkhsZVNydlVNdkh5K3E2YXN3cmhqcHpVRjBPc1F3eTNOV0pYeTdz?=
 =?utf-8?B?cHUxRU9sdHZMK2pYQUVMMXZleXAwTkpVdUwwK3oxVVNJZ3lkTzdVUmtERGR2?=
 =?utf-8?B?VG5HaGx2K2g2cDlXbmk1TE1maVdLT2pWSWtCOThqbTZqTWFPeGNNVTNoMU5U?=
 =?utf-8?B?cFpkMng0YURuVndzbDQvM3JjTzBINXZLc2p4bE1UdHdGdEtLczNzRFJvMzln?=
 =?utf-8?B?dG1PbW5MZVhERSt0SFQySTg2akJEWUZZcDg0N1BlbE5lRnozR1FYc3pPbUVG?=
 =?utf-8?B?amwzazkrNUxmb2o2OStiR1FCY21vSmNRcmdYUEdEVnYrRmdhZFdSWE91SzdX?=
 =?utf-8?B?MVpVUFlDVlUxUjg2Nkd0dXB5YUZWcVptK0N3NEd0ZjR1R1I0NWh6Q3lKd0U3?=
 =?utf-8?B?SkJvR1BTakR6eWFCK0dxOS9kV3U3dDk3QXQ5NXpLeXdXUkdQNzc0YWRDSXh4?=
 =?utf-8?B?RFBhdE1PSnQ4eGRSeSszVElldGhwaVp6anltelRmL1hqcFk1SFlzQ0J4S3NZ?=
 =?utf-8?B?OUR6U1FzdmxZOXlWck0yaWtEYUYxaFNwVFd6NkhPb3FaMkM2T0RUMTZZcDBU?=
 =?utf-8?B?YWtibDBqSC9aaHBTUnF5Lzc3WE9SRG5OZTFxZlpQN1JjWVpzLzdwRGlFeXBO?=
 =?utf-8?B?d2lHWGM0Rk14MzNOa1RsOWVxQjBIR0l4TXZBenVhbTZNdkZpWXBUVHdKQzl5?=
 =?utf-8?B?YWs4NGcvWFo2YmVCMktrRk92Qnd1dmhHREZlcUZCdDVuSkQ0bXV5WjAvTHRP?=
 =?utf-8?B?dlhxOXNsTVh5YlVaNzR0ZWE3OHo2QnNrV0ZIdzZKT0NwcVcvcTFKeGZSMDFE?=
 =?utf-8?Q?KHrc=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?amJHMndnTXl0WDBDUHlCQnRnZWltR0oyS1lna0RIdWVCb2ttNXFLcVV4QTdW?=
 =?utf-8?B?QjZZYlRnQnBpZ2lwSUNkUjQ3b2duWHVMV2lraFpaSlFJdFRFbkYxdU1oV3dm?=
 =?utf-8?B?MmdlVjlsaFc2UDZFZmpEWjJPRlc1Wk1tUTBQRzJLL0dXa2ppdXViS0F4RGlj?=
 =?utf-8?B?MTNscVcwc1QvaTRCajRSNGs2cXlRV2Y2YS9NQklyYUxIUHg2TUFJeGxYL29W?=
 =?utf-8?B?aFJyNm13QkQ3MUIwakE4MS8vZFlxU2xGem9UaC9ZSFpqSnUzZkpHUFNzQVNh?=
 =?utf-8?B?L1ExcVAyU1dHM24yUG5xbFRxc3lpOHhtTGlHS3ozL2JhZGkvcjBmdENKUlpE?=
 =?utf-8?B?dlZPQVcvcUcxTWRicFF4Tmh1QXYzMnh0dW0veHB0SWVtK3FiaFhTczhmQWhl?=
 =?utf-8?B?QWdpZ1hMM3lnVkYza3F3eElHTkw0SVJEaklUeFlRazA3U0EvRXlXMFA0VXlK?=
 =?utf-8?B?UkoyT1BTQ25oaWd0OEt3RnVUMkE5UldMMm92cXpaU3ZJMFhBelo5dWdVVHJl?=
 =?utf-8?B?Zmc2UHBIQ3dnYW5nZFIxZGtZVEpCblFVMkNNclM4R25TcWFCS3h4dUJqNkhh?=
 =?utf-8?B?V1hqSkpXeC9uKy9sTXcvMjlDSThWVFl3aEFjSUt2cWlmQlhTd1JON0RLNFJm?=
 =?utf-8?B?clZ2M25wOWJOOHp2b1FGV1Y4My9Ca3VrZ25uRExJZ3A5bVNIUkNkY1dQMHk1?=
 =?utf-8?B?U0wwYndabE40Zy92QXBoa0ZyaThPS0tWSk0zMzJJV20zc1FCNjhvOExxa3I1?=
 =?utf-8?B?bmtPN2hGVDVkT3ByaFhpTitLejhsaFdFNjJITmNIV1VrSlJPMkx1MTIvMmdV?=
 =?utf-8?B?eUFtZzlaVlFwTUs1ak5sVEJzdjJNNTdkamtLa0N0MzVnd2hNY1hSNmpGdjV3?=
 =?utf-8?B?d0lSVnJSREpJK2VoMURwT0NvYzhEaWZVeHdhRHJyb05ZdmdNRVJycXdqRFZ4?=
 =?utf-8?B?bnBmeE4yeHZwQjZXb1hmTkxsZmIyRnE4b1R4d3RKTGt3NVdpOHg5bUJwM1lX?=
 =?utf-8?B?MWE1Q2gzcVVtYjNJYkxKamgvM0E5b1RFZ3pLd1RUcHk2S0xlSEJ3S0Z2WEVs?=
 =?utf-8?B?L25jazRub3VkMkpvVy9TaGZqRDhFWGtsRWtzMUphWm1JQjV4RkJab1EwZlFl?=
 =?utf-8?B?UDlnKzBkUytvZllNYnFCc2NoTWVzYTg5R1N1WkZCS2JYR1dLYlZqTDR4c3Fz?=
 =?utf-8?B?M0lyOVZoejhFd3lnZXpPTG1xVlZXa1pSWCtQakxKUFEzanpLVk1Zc1BuQURI?=
 =?utf-8?B?Z2hnZXdLNTFURmFLbzIxMzlPVWJCODRRVVR3b0FvVllCaDZkZHhjU3ovSUk1?=
 =?utf-8?B?dHJ0cFIyTVJabDhKZlEyQ1NwVERxZ3FNV0xxQnNHUmRRa2hlK3REZ1J3U1pP?=
 =?utf-8?B?NlZjaHdGUTJYV0hiQlJZTG5LaGp4UDgwUmk0Y0V6UERjVkIrSVJFQUdmSk1l?=
 =?utf-8?B?Zm5HdU1pZUJTWi9nQXYvZFRyTWJiNFB3SnNCdXhNbjFnRDR6VUlHcXhTNnBp?=
 =?utf-8?B?Y2p2QlkrTXlBdmVwM0FjTytQcThmSXhhYkVoSDkyeXNWTzBwRXhrbkRnSkVP?=
 =?utf-8?B?SHllQ09sREVhMkQ5SzZCQkg3ZkhIYnNNTjZJeTBxbmx0MG5LZUs4R0VGUG9z?=
 =?utf-8?B?ZlZscVRWMGhXZENmbTN4NW1Zdi9hb1N2ZURHS3ZhSmljazBOMWM5MHBNZ3VO?=
 =?utf-8?B?SWVQcHlyWTZFcFJ3QVYzRHBCWStVYm51blN2Z1RZNmQrTm9mR2ZSMElkalVl?=
 =?utf-8?B?L2hFTUZpN1JJWEx3aTRLVFBhVW5iVGkrQ0YwVnFpc1NjcFZPaHV3OHVKM2E1?=
 =?utf-8?B?TEkxdytqeFpRWmN6Y0NScWhCVXRKZ2FJcDhISFRBNDBvU2o1VzRTNkdLOEdh?=
 =?utf-8?B?Zi9nRzVKdm5QS0h0Ty9UZkpkOStJMTV4OS9YajVOWXBSbGhQTStOSVJ3MGhW?=
 =?utf-8?B?dDNuN2tVcXJTd0RncFNXY21JTnVVS1ZpT050S3Q3Wk1SdkRDOUs2TmIwRUth?=
 =?utf-8?B?WW4rczJpbnpZVURicC9yMm5jMnkxaTlQMFJlbldHWXBmVW91a2dRb0RVKzlY?=
 =?utf-8?B?S2tkaE9jRjdyUHRkdjJoQ0xLc2lOZVYrNGlKcjhkMFJaamhzQnpTTlBYNXhq?=
 =?utf-8?B?ZU0wbGtrS3NEVmxhZFM0dTNqallRZC9xNTk5WU1pL1daWVZMT3BkMVJtTVhv?=
 =?utf-8?B?U0tCTDhESzVzWURBSjhEK3ZNSk9rRU1xT3BjYVNBRXB2R0dqd0JDekdSbiti?=
 =?utf-8?B?SjBWTjBWSk5xVmdRQ2V2ZVY5TTZwdGtkZkNTMmNyOFBRSTNHTjZvQ0NRMXhC?=
 =?utf-8?B?QmozaUJzbUVBWEFtWXQ3WC9pMVliK0xLcXdCMktKMW1Vbk5oeU1KQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B0bT37GeuCfq57MeD7FHw812CLwaqYTXdgaiXS7+Sm9HrNyDpWvb3Edlp/c0XgoWOGQSpp5GS1EMehmYZgmqv5bvMSXw6DtZUiYXbadS0C/Fk1qvwuhtE1BHMwrgjtDYf+8BwEgMoYUhCTPRKnZbbGUb/UvUbOyHPR6qFYK+Rv0VrI/OEn810QlthtQ5hmfR5vqa+6zsnCBnSPaRLDDUArdDGOMprHuSAa1Sr+7IcRPo3ph/91yalFuRSEz9o2Q6r8UkKbXA7cjIjIRSyz8SiIYDqk6TSqXxdaClvPVEX8r9ZcY+G/kyUuIcP9t1JlqvLrhUqGOicQk6bL0UIm2puK1lQJ0BASQnzY1wY2NQBt6vipav2V+YjpMVV0bs3+rldC5OBMXfBGaqbJrQUjk6o/YBclm8THvBMJmmcALfjngv0SLYEDFWQbogV1ly8LxbRfnylmrIzIpoymP642OFvMNJmZzsXFS19XO939xwR7QAM/GdR+QfOczGWOEqdeP38IJ//hEjxmSMulTkLE2/qAKKIocv0onHYfyd/8UhXY+AbaPNWmZli9xa4fLu5qS44vuRxgBzZ5e5tgfh9dgrEous5+8Dwf1K45nAl3OzP5U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dc10f2-dc99-49bc-4010-08de7257ecb3
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 21:18:29.4017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2743DiG+kV9+VB9zgbn389nv1k2RXnzURWISZCGQYpmnS4sOvKbACFiKRVSFQnmWA4jGGhTac6iU2ZTNlc/K3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8090
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_05,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602220205
X-Authority-Analysis: v=2.4 cv=La0xKzfi c=1 sm=1 tr=0 ts=699b72aa b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=1_XXTIKIznOfgUEsmscA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GYkeX1qZLZdkQiqTKyI8Cn5fULiBndG_
X-Proofpoint-GUID: GYkeX1qZLZdkQiqTKyI8Cn5fULiBndG_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDIwNSBTYWx0ZWRfXylM44N0m+kUw
 x84ffrQ3p6tZ5liYDHVh1FjawVJns1FkrUAX9r5bLnNs29hHOQGQwNyP0Hk57fplF0+YtyPfYWH
 5z+EEV9qrDlPwfQ7gZ78vGioj0xvrcEBQlmfbrlCKW2oKL4LZ6vSN0/e0YKdAiCb8ESpdAET9yT
 YXqH0ePkA+ydFBrBxQZnbPLTd38EKimJtv+znCV1mQW4MffEWzSK6xu88UOnwUPc1TinPFbOkPr
 I7hQF2X9i6h/EBBRi9+ozwgVSP052wB9/0nexjA9EFF4wslsxiAbEK0O/UXxHU3YhgXryKRNxJn
 zSDO4BSZnvg4XNGkwDOk/zpZgqjKYu1SXgqkR3EojgFleY4Pew+89w8eWE444v2MwIuhzM0TIV/
 +lZwwo5NQ4A5sL24ieGFY72T8jsd2nn6LoDFPUT2lpXTyBXhfcWU1y6mUKEA/x21AqSS7jEE+yz
 WNqjQYD6XZ+sxvkzpXw==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19100-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.com:email,oracle.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8CC0B170637
X-Rspamd-Action: no action


On 2/21/26 2:57 PM, Chuck Lever wrote:
> Hello Dai!
>
> On Sat, Feb 21, 2026, at 4:57 PM, Dai Ngo wrote:
>> Extend /proc/net/rpc/nfsd output to report NFSv4 callback activity:
>>
>> . Add system-wide counters for each callback operation.
>> . Add per-client callback operation statistics, similar to mountstats(8)
>>    raw format.
> The commit message needs to justify why you are modifying a legacy
> /proc interface.

Oh I did not know /proc is a legacy interface. What is the proper
way to display nfsd statistics?

>   I assume it is because you want these metrics to
> appear in an existing NFS administrative tool like nfsstat ?

I should have made this clearer in the commit message.

nfsd already maintains backchannel statistics, but there's currently
no convenient way to view them during normal operation - developers
typically have to inspect a vmcore.

This patch addresses that gap by adding the backchannel statistics to
the existing output of /proc/net/rpc/nfsd.

At this time, I don't plan to extend nfsstat(8) to report these statistics,
as this patch is intended for developer use only.

-Dai

>
>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4callback.c | 33 ++++++++++++++++++++++++++++++++-
>>   fs/nfsd/nfsd.h         |  1 +
>>   fs/nfsd/stats.c        |  2 ++
>>   3 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>> index e00b2aea8da2..5d6c91b2da24 100644
>> --- a/fs/nfsd/nfs4callback.c
>> +++ b/fs/nfsd/nfs4callback.c
>> @@ -36,6 +36,7 @@
>>   #include <linux/sunrpc/xprt.h>
>>   #include <linux/sunrpc/svc_xprt.h>
>>   #include <linux/slab.h>
>> +#include <linux/sunrpc/metrics.h>
>>   #include "nfsd.h"
>>   #include "state.h"
>>   #include "netns.h"
>> @@ -1016,7 +1017,7 @@ static int nfs4_xdr_dec_cb_offload(struct rpc_rqst *rqstp,
>>   	.p_decode  = nfs4_xdr_dec_##restype,				\
>>   	.p_arglen  = NFS4_enc_##argtype##_sz,				\
>>   	.p_replen  = NFS4_dec_##restype##_sz,				\
>> -	.p_statidx = NFSPROC4_CB_##call,				\
>> +	.p_statidx = NFSPROC4_CLNT_##proc,				\
>>   	.p_name    = #proc,						\
>>   }
>>
>> @@ -1786,3 +1787,33 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
>>   		nfsd41_cb_inflight_end(clp);
>>   	return queued;
>>   }
>> +
>> +void nfsd4_show_cb_stats(struct nfsd_net *nn, struct seq_file *seq)
>> +{
>> +	const struct rpc_procinfo *pinfo;
>> +	const struct rpc_version *ver;
>> +	struct nfs4_client *clp;
>> +	int ix;
>> +
>> +	/* display system-wide status, count per op */
>> +	ver = cb_program.version[1];
>> +	for (ix = 0; ix < ver->nrprocs; ix++) {
>> +		pinfo = &ver->procs[ix];
>> +		if (pinfo->p_name)
>> +			seq_printf(seq, "%s: %d\n",
>> +				pinfo->p_name, ver->counts[pinfo->p_statidx]);
>> +	}
>> +
>> +	/* display per-client status, similar to mountstats(8) in raw format */
>> +	spin_lock(&nn->client_lock);
>> +	for (ix = 0; ix < CLIENT_HASH_SIZE; ix++) {
>> +		list_for_each_entry(clp, &nn->conf_id_hashtbl[ix], cl_idhash) {
>> +			if (!clp->cl_cb_client)
>> +				continue;
>> +			seq_printf(seq, "\nClient[%pISpc]:\n",
>> +					(struct sockaddr *)&clp->cl_addr);
>> +			rpc_clnt_show_stats(seq, clp->cl_cb_client);
>> +		}
>> +	}
>> +	spin_unlock(&nn->client_lock);
>> +}
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 7c009f07c90b..cec0c6167ddb 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -591,6 +591,7 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
>>   #endif
>>
>>   extern void nfsd4_init_leases_net(struct nfsd_net *nn);
>> +void nfsd4_show_cb_stats(struct nfsd_net *nn, struct seq_file *seq);
>>
>>   #else /* CONFIG_NFSD_V4 */
>>   static inline int nfsd4_is_junction(struct dentry *dentry)
>> diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
>> index f7eaf95e20fc..cc601719ef26 100644
>> --- a/fs/nfsd/stats.c
>> +++ b/fs/nfsd/stats.c
>> @@ -66,6 +66,8 @@ static int nfsd_show(struct seq_file *seq, void *v)
>>   		percpu_counter_sum_positive(&nn->counter[NFSD_STATS_WDELEG_GETATTR]));
>>
>>   	seq_putc(seq, '\n');
>> +
>> +	nfsd4_show_cb_stats(nn, seq);
>>   #endif
>>
>>   	return 0;
>> -- 
>> 2.47.3

