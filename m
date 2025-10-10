Return-Path: <linux-nfs+bounces-15136-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C7EBCE0D0
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 19:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 980044EBDA6
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 17:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F449215F4A;
	Fri, 10 Oct 2025 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NisQsLZx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QcWs3MZ2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22C13FB31;
	Fri, 10 Oct 2025 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760116275; cv=fail; b=SDrkZZ4/L0Tkwed2HO1CKD0tffYgDS6xLH0sps5vs+N1lSy+QqfP5qLGjqFo+VXE6LdQYJp7g8yEjJzo5tCy/gaKJhhOBWFALbWYjOtDzwHH27zixKfiBnaJFFUkcuBLLCedAFomZS2b6ogp12fEX3yD7JqAOqPc7ZiWY+abdyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760116275; c=relaxed/simple;
	bh=8R8Wlh7OlAh0paIWvEGCkdc/kdVo1iOy0CTauBI5jsc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dB9LSQy+KpNVo0BRx4kVBEAY2FYAL3wkYZNvqnPGf8w2kG8ogJe3eCZcufFvTryStel7I0NLDg72OHzk3rjvXbpgPvH6QEJyRzJ5CYXCLZyyzh4DhahoLJ/vt9BcViKzLUN94ayEED+DDr17sdxY6yhbKNuPDM/m+6jUua4NI+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NisQsLZx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QcWs3MZ2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AFu2W5031788;
	Fri, 10 Oct 2025 17:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=g602nD/5zgKUts8VbxrwXT7zXHKslQQtBEILElfNx9M=; b=
	NisQsLZxFpMJIbNAKBVmwlTXANas1JzEloj3FCWBDCpxIenQ3sgyG7mTRjnhPF0F
	Ui9kw5UnPsdStRzfsF4/4u+BJWZkii/8sBLVBIQ4eSce5+QRTYBqQVkv35X+XP05
	Pv31/ATld5nM5w83YFBikklHIwKizf9XBSh33eAgQecHCxubmNNQIWm+eqhaFHm+
	/jS4lupDv8McbfESdF0B/sevvtqnalc7mgw08wVcNkIju962sK0lATWa/g7vcS9q
	JqVI+qZUwSPS89JvKwejdOO6LTmXGcAb9Odn4zqOEMnteFgcgisPaMXtwkUP38Xa
	e4FmaJH4iQN+mWsAytdWdg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6cc8h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 17:11:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59AGGoGa022918;
	Fri, 10 Oct 2025 17:11:01 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv648e6w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 17:11:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDYOc10zEbHpnodFIHj6oAbHF/qfZ0/TvZxpnLlhEB1qsx/E+RRumHqnzOxN3nagTBm5vEp/qeALVmpXfRoz9XkJ88L3yC7z9238s0ymdOy0wG/v1Drf7iEFku4ZfkLJsORmSTuxNO3Wh5hFl4tdPdHjv65Qao3VEPpzmzxshgqaJfsOfsXNtslIdGXMgJxcqRwpfWrd6aLv+5qZp4h8VNq4Z016PA6fJ2JniwVi0OpZxv/GfQYYBv/Gur9cU2raO3U/lgGJMe2zWI5H+kFV/MP/vhU8HFsft04SH5sD/+HxNtNllXzbXQ6XEw242JbVAXycd4dNyFwUYzVYvFduLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g602nD/5zgKUts8VbxrwXT7zXHKslQQtBEILElfNx9M=;
 b=gXt2WaR5ebQUXqOFxwX8ELvd2WpEh/j3vKEeS82y3zPQO/IXY78xlj+JTgKrDOkDSGFu5faHY/W/k+nxfN3JHmnqWDIZzuqEREq7E5eRZuSzWMYuiIZ+d1fKTIIzy/dtLj56t7ZAh8HfZ4RKOCpKo4GuQe4YR6Aj1PeismcR4VUoHibOrRvnTGWuQpQiDfSRidQEtnpjODYmbtF5eikEA/U9WKSfSuwecCk4cFozdG8gkVwFRIQO8MwrT3n6GDGd+bCOje7PCyfK/xqp1lekvk62gpfdxCZRrst+4Vo5lRMf42kcDb4N7N2bpOhZY78Bm8DAOj/b+gKxKixRJYBxiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g602nD/5zgKUts8VbxrwXT7zXHKslQQtBEILElfNx9M=;
 b=QcWs3MZ27AUJ0xtQ3S1vU9cYFEtqeATd708etDjQWnhRUun1ww3QRJNZlXlFdHUNT8SsVaSthqg0hLprg8S5nwzcPpEGXtxoRROLWJ/YnhHCvLNqXHx9rkVMz4KN9fbTDQkoYhFpCo+OMc8JVlsIMgQqjxcYLylGLtLCCtxpklY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5178.namprd10.prod.outlook.com (2603:10b6:610:dd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 17:10:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 17:10:57 +0000
Message-ID: <1e87bb8f-17f3-4a64-9001-22889c64455e@oracle.com>
Date: Fri, 10 Oct 2025 13:10:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sunrpc: allocate a separate bvec array for socket
 sends
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc: Brandon Adams <brandona@meta.com>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251010-rq_bvec-v4-1-627567f1ce91@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251010-rq_bvec-v4-1-627567f1ce91@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:408:fc::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 990fab86-32b6-40f2-acdd-08de081ffaad
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MTBkNE9VWDV2d0xmZE5oKzNCU1NQaUJOcXFycks4aDdHai9wMUpCWnluSnVa?=
 =?utf-8?B?Z1RXQkxRYml3RjkvSmdUNExuYlRRK1JPN2p6L2g4cVRJWDZhNjVUSnQ0dzU3?=
 =?utf-8?B?TTFOZkZ2UjNteHhQNjdkeXpLTjNyY3RqdFdDajAzTStwNUo2TnVhdzRZQlcz?=
 =?utf-8?B?VnVaY0NTRHJQQ2wvQ08xczZVaFhTY05uM2hteDlScUxSeXZHa2xoTHJyeW5H?=
 =?utf-8?B?c0Y3M0dETW5vdWxyamxBRElOL0JWWGUwQVRPODkrckFZbGNORGloeU8wZkFI?=
 =?utf-8?B?b3FzWFp4N00vNnU4dTlaNHY1VStUTzdpU2x6QzBCY29qSHVEdEJ1YzlWaXFD?=
 =?utf-8?B?QnR4ZTNiZXoxTkpBNVF3V3VVNjlzS3NaMHIzWDlkSy9iTlkzS1VybzI2NlNv?=
 =?utf-8?B?dHpEVzduNVc2dk4reUFtTGM1VVVycHQ2dGF1YWp4cHhLZmJ4N1ZKT1VMR1RS?=
 =?utf-8?B?OStrdWJXNGVrV0NqSFBmbUV5b09xYWUyd3Z1TEpaai9EOURScEZIc2l6YlJw?=
 =?utf-8?B?S25tSkdKZzE2dHh5ZEZubDNuQXh2OE1oK0RtS0pZSzBRK0lXYWdJdVlMMGdB?=
 =?utf-8?B?a3FSc3cvWkM0NzJreTBUQmQya0loa1FzU3ZURmpmekQvaEF5SXYwazFuM3Js?=
 =?utf-8?B?SStYQW9UaWNmcXE4VFd4aEFReWVxeEFObXF1YTlnU3pjKzhuM05pbndsQlg0?=
 =?utf-8?B?dFh0R05SNzIvZ0VXbmc5dE1FdzY2MGhaQ2kzNEFoTk92Q1RWckN6ZVVka1dh?=
 =?utf-8?B?akZJTE9XcjJzQWFQSzBFVmpQcithY1EzVkUrbmI1dm1hSVYvV1h0TW1GZGtO?=
 =?utf-8?B?OVlUT0pTTUEweHc5MXdiUzhWUFFVdURIVUFzSGltZVIxRkNxWXhZV0pMU1VW?=
 =?utf-8?B?d3NtY0N6TkpUc25vVFNBelh2L1VvM1kzZ0ExRkhhcm54dklwMUh3YlZHd0Ev?=
 =?utf-8?B?VlRodndPS3JTZ0Ntdkx1STYwUDlYOEZWZXIzVnp6dXBGR0EwK3cxN3I4MFpR?=
 =?utf-8?B?RDFYcmxhOXhMZ1JOVWFxbnFJL3JDRjFDemxHenZqYVc3UWtPUXZWVFhCYytK?=
 =?utf-8?B?ZkxIYmM3YStQTGltZUtrMWdQMEV4dnhWTHgzOExzSSt3YUlvLzR3T3k5NnRm?=
 =?utf-8?B?bmdFQTRESmtoWE5PcFlFWEJXYmRxR0xZYlFzV1ZzOFdyM2Jjc05mdHhtTXJw?=
 =?utf-8?B?QnRKZ1VJUWYyT0N2M3F4Qkt3WnM5cjNxT1VMNEU0WTJuMmtTZVBINnRBSW1q?=
 =?utf-8?B?bG44b1E0aDl0ZUc0NGs5d2hScFpKTnRVU1RjaUR5ay9WcWtEMkxvUU52YWZ0?=
 =?utf-8?B?dmdtN3ZEa2F4NzlMeUhEdXM1YldTVlR4a2t1czFtbE5RMUszYlVTcVBBd2xI?=
 =?utf-8?B?em5nZUcydVN1RWwyeEcvaGlhSE9QV0FFYlZVczVTNFpKOTB1eDFpT1BBdVFw?=
 =?utf-8?B?WnIwck8zb1RuYmphMGtPcTBXb09kOFFqbnJ3ejRwcml1MHk2b0dLbWYxeWNm?=
 =?utf-8?B?cklGZkptTFNhOHBEQzRGcm1mVVVQb09ZRVNHczZlVjFGL2g1M0ZOVlRXc2xh?=
 =?utf-8?B?eFNKNVd0RWVhaCtrVERoR3l2bTR2amNaMEdIVDlXL253U3MyRExMdFRpaUZa?=
 =?utf-8?B?dnF0MHJtV2c0YmdQSFRIUWI0bGlraXVCZzduMkpLODFveU84ZCtZWlgrTkk3?=
 =?utf-8?B?RzN1eDJtSHZ4cUlKQ21HRlBEN0FnVzk0dzRCaHUzZjJ3VmtGNzlqQnV0Zjl1?=
 =?utf-8?B?L3I2QTFUT0dxV0pzWGg4VzByekkzNlRjZG01VUNLN1NRMVlqa09rMmNsQ29J?=
 =?utf-8?B?Z0ZQb1BjYjlhcGhwRDFYNVdMK0ErY1hOaTEwbnhVanpkWmNaOWloRGxIbFUv?=
 =?utf-8?B?QXdIRDJLQStKU2R1dTZmZjdHS2JOeHI4YnNsTXAxN3I0YlMyV1FiYnJkeVZj?=
 =?utf-8?B?RFk1MWNKa09RelRPK3MrbWZ4R3RqajduOWVIdkh5YWE5U1NVQUVkWW5nRTRB?=
 =?utf-8?Q?HugjpdNHsWkT4SXi5Olv/ckxlsFB80=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Wjh1Q0JqcVNJTndacS9YT0pZcDE3NHA3Rk5HTGpyOFRSdXkvOENyanhEWU5S?=
 =?utf-8?B?RDg5bysxdDJTVjBYTlJTZ2k4RnJrMDZJTUtxQ093L2M5ZmNlanFlb096bThK?=
 =?utf-8?B?U1NnbXBDL2RFaWNSd2ZrZ0RaZDV5VUhGZVNENDMvUVk5QlJNK0FrRWxDUXUw?=
 =?utf-8?B?S3VWOEhHNXlaMEdJcGpSUWU1anEyNnhQVlhrS3JjTkJGekJhU1VtN3pIM2R4?=
 =?utf-8?B?N3ZGY3RrS1Y3UnVvaXBtQUJ1YmlvdGoxdXd2ZS90RVZ6MFB0QTlSZm9SMEl4?=
 =?utf-8?B?RytpcG5oSXFQeDErelVIVFJKT3hlR1R6U2xtT2RldWhkWjhVZHJZK2ZRK3FL?=
 =?utf-8?B?bWtBSndjQW9FUGNNNllsVHZHZ3NuOHRZcHlyOHdqdXA3L1ExVGxkSVFCUVNq?=
 =?utf-8?B?ZFVNTUhBcFE5VGxINmdtYjNiRUlMOGNCWjcvODdvTXlKZEtwRTI0WmhRUHAy?=
 =?utf-8?B?N0d5TnBjQ1BlalV1VlMvOTl6bHVQRlRhSTg4MmRoeXgyUGxwaXAySkEyaHl1?=
 =?utf-8?B?K2NwM2l5YTAxemtsdlpzNHB1TXFFMVhlaVRndWViZ3IxS2V0TDRWeWlWcVMv?=
 =?utf-8?B?ZEZTYzB2eWJyQjdoWWVHSEQ4a2Nmd3RmTmY4ajUzUkR3b0FyNDg2akhpZmJF?=
 =?utf-8?B?czc0Y09iUHEyelJzS3pWejQ1eUtGTnV4SFlneUt1VzIzREFyKzVHMVJkbExm?=
 =?utf-8?B?NnBsLzVjSm1NajlKTmhqbnMwSUkvYXFaL3Z0MmxDcWVXWS84OUl5ZStxNlpv?=
 =?utf-8?B?Y29wc0RzYXBROFY4TXZzWHhIS0I3aC9DeU9uZkJ6MC9UanV4UzlacnJyRDhV?=
 =?utf-8?B?UVhLUEg1WEFMRUUyYTZGSk1jUFZNa2wxVzJhaXkvYzgzUFJpVlh6OXptbHdr?=
 =?utf-8?B?bHU1SWEySTJUb0kzY0tKOGthc3RRanF4STlPU0YvK29BZHhuYksrU3RvcVl3?=
 =?utf-8?B?akFTUVQ5SG40aCs5Zm5JQTBidzlBRHd1QVoxRXVXZHk4b25hZEJHekZtemRU?=
 =?utf-8?B?STVkRGRwUDY5MTZCYlJ4Rml3SW9sVlFwZ1c0bDlOc2pDSnlBU2FxcmRvME5r?=
 =?utf-8?B?dnFZbEZzU3RhcXJWRis3azNKSlczSE0zTFlSTkNWTW8vSWtqcGd4MU51OE8v?=
 =?utf-8?B?VjdlMmYzcnIyZ0FMRDN0S1RtVDBRSitNZEhaVG03NjdtTmlsamdFSkQ2L3gr?=
 =?utf-8?B?b0VBQzJ4WW9wQnZVQkRvb0JXWHhJb1I3cTJxTkZSN25TZU1VditLWjBMM3U4?=
 =?utf-8?B?QlVNZVMyTkJRODVFK21wclVxK1RvY0NrbnlhVno2VzhTUTgyL080SWN2Z084?=
 =?utf-8?B?bVlwSTBlMW9TTW9nQW9SRHZLbXFyOHQzOWZjZlJiUEFyUnBGYlA5V3p5N0Q5?=
 =?utf-8?B?RlQwTk9DQ0xaTmZQbzZETEdGRHk2UTU2S2JxUmkvTVhrckxvd0VBeS91eXJt?=
 =?utf-8?B?czVxVndnY0VsVEo2dUlXVUMzQk1GUCtwdU1xY2hsSlljTVBsSTFhY1ZNUVZm?=
 =?utf-8?B?MkMxaXhRRlUxZzJxRXY4d2JHZGozSHlQY01kbktFMXBYeHByUmdpcVA1OEgw?=
 =?utf-8?B?WjZVT3c5Ykc0V0Mrc2F2d0F1VXBHZEZDMGlwTmxlTUdKbWx2NTFPK0tDNVFM?=
 =?utf-8?B?Z2ZzTUlPQWJpWFN5T3pjTVNVdWdsQzJCM3lRVS8wblU0TXlwSFBkeFQyc0d0?=
 =?utf-8?B?Z1daNW9SQmpUdC9rSXFBa09MTGNvR0pvenpuZWcrUlZmeGR1U1diVDVVbUJM?=
 =?utf-8?B?VDJIV1Z1YkwwUkdIbjlNeGJzR3ltSno2dzFBWlM0ejE4T1JXVFRQOXR1bjlt?=
 =?utf-8?B?Z1lTVEpCS0tsMFlhWWJVSEdyVHZlQVZzb3V5R0U4dVpld2dIV2YzUktrZnNt?=
 =?utf-8?B?UXB6elN6NFFqclZGbTZWUEI0OGpCQ0NhZUszQTdMRFU0Q1RPbHBVdjlXQms3?=
 =?utf-8?B?MzBjTDR1UHV4OUVLN2lWVVlXeTdaZHE1emtTL0h2YnB4UjNEVm93ZmJzTGhu?=
 =?utf-8?B?Yy9KWUtkOGRIeENwNzIrdGovUEgvbno5Y216WC93N1lnelozbkZQTmYzYnVL?=
 =?utf-8?B?Uk5Ed01kem9jYlFQU3YwY2hnSlkraGthK1VBczRCdk5SMklIK3BrUkVGSFpq?=
 =?utf-8?Q?HxrPT3/Gq3MXIskldHs8JYNsO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZtfIDh8M9/63wW48gpTjcJF/sdTnreEKvyEeK1gGmS03z0BvYHc/X27teHTUdXu2vJsRhL5zYay2144IMkUtRkSAk4+r+CjkebvCQ6aZVm5qFMVBaZ54GlKRy9ZKDpkfqf4UWdtEL3pgjfl+kUf4uKw+tLV2/k9al3BJrE7OIMuwhRxymIbzOTZizVLa3aq7pEuP/Pm0zmL/Ecn/SO0x1E6n2B9JqEn0DTet/iocuLWfb1vPcYqRBRi7jrpxNYHL+Tw2euiqES5QRqZG5/Oprk/Ceb0pARavmHohYCxbUkN8UTpnRUS/u7yVDwLhz2EY+eFIiZ0pXyKlhvqs04fQek8hxiY9stIDTtIyeuNmwGHX4WGS9BIaOqOVkwQTc43+VDBqIjTsVKQURg2rKvjZNfXsx0nXrP5pyIRm+iLzF2AknZv0LkJFwKTJ3pv3CybyDNUEpGWIqVGMNMZATspysrTqxzNduCe6G2CIB8a2XNZSRjovHKI/4nOet7mhIsjvV6j0BwNNz1CywQu/5/vigIWaS9F6aNFWXmjWCxpKQFCFC/7TE8OM9Ml4IY/zSVZkwJa9g0LQ5FE/5RGqXG/kyyN46PPNuAciifvSiFTJ+Bc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990fab86-32b6-40f2-acdd-08de081ffaad
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 17:10:57.7102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPj1IcSpyWASl+P614if9hIpFZU2u8WAP0f31Q+p1ZLVRWZUloV5EEdFPCpF0d1GyS9GCd1Fy2qEiPmj8+vFvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=948 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510100099
X-Proofpoint-GUID: VHzOnaSA9r82-1IwL1aNrcEU2HBtpq7Y
X-Proofpoint-ORIG-GUID: VHzOnaSA9r82-1IwL1aNrcEU2HBtpq7Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX/QG+TAr2eQ6k
 /rkJwoZe3p+Sg4K8+OR3ZLwfji70E8m9b+ScJXWCl4FQdKMF37VysQy2ipKbQaQGz9+k9ee/JaH
 AJeo5IiKvPdjlkbfe8i/Lj6jdOgjKk4GdR9AuwO+CXAIIJR/VxLN99yWsH1bmCNBgpC3zNwSDVN
 Wa9gUqwMLPDYbb2HystM1qPxZGCm9HQsngSSwU/KMBoyRbirWX4DzOHlkmVG8kPRHOaCVfeFdPo
 Wo6pgPEQadpP0RiapP1MVVumtfVkg2wnydntB2oMoxZ9bLRYcA4pnyqMQ7UV/5Bcisvqi/Ilnp0
 UrED1AmLh/PiE5n2Uy9IMj8A0lcNRPqpiBy80jsULUgG7eO59h6Kre4YrRXPero0I1ioM35Ufax
 4sLCPvyZzwRDSBcKqsUoGpGBjZAj3j+CjKC7slPWs+qsqTL/H+M=
X-Authority-Analysis: v=2.4 cv=FYA6BZ+6 c=1 sm=1 tr=0 ts=68e93e27 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=LySwq7V6QOF-aWFzXEkA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12091

On 10/10/25 12:27 PM, Jeff Layton wrote:
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 7b90abc5cf0ee1520796b2f38fcb977417009830..09ba65ba2e805b20044a7c27ee028bbeeaf5e44b 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -730,6 +730,12 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
>  	unsigned int count;
>  	int err;
>  
> +	if (!svsk->sk_bvec) {
> +		svsk->sk_bvec = kcalloc(rqstp->rq_maxpages, sizeof(*svsk->sk_bvec), GFP_KERNEL);
> +		if (!svsk->sk_bvec)
> +			return -ENOMEM;
> +	}
> +
>  	svc_udp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
>  	rqstp->rq_xprt_ctxt = NULL;
>  

On UDP sockets, NFSD doesn't handle RPC messages larger than 64KB.


-- 
Chuck Lever

