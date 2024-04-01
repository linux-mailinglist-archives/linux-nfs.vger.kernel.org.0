Return-Path: <linux-nfs+bounces-2590-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 004838945EB
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 22:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB31F282E34
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 20:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADA92E410;
	Mon,  1 Apr 2024 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e7WzikmG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0LVDUne5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B5E3D9E
	for <linux-nfs@vger.kernel.org>; Mon,  1 Apr 2024 20:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712002716; cv=fail; b=Xr68ODD3wxLGnpv/hYfbC0+EQiAXQK5HM3EezceOhpv2q3l5tUeBaRWWAD/vdfSJqxb9MuojtQ0aZa7kqS/QO3adrA7nSoXbPG1bETXVDUN2ySw/MwP35sbXnUg+/LUfjXQR7zYFWWPjhNeg3sS67daJBee9ZiELNUitZABtGtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712002716; c=relaxed/simple;
	bh=Ez8d5fE+KLpkMH7KU1TmYaLjn+kuCHG6pOQ6bCxO0tI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FOsZN7xyU9ImVZR9Hq4xD7RrfHAPwigzssTHQ2ZdkNTL1rHdDTUf8nGnO2JvPQwiVMBU0SSHukw+YaB3zjLDg57GAdpqtgb6nfN+f8IJ0QTdCzDHe6RwCI8OcGHo/xYsoZl1uXvLNOSQIkmuZJnO+aZV6W6c88akUCndQWb8Hqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e7WzikmG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0LVDUne5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 431HfWgm007616;
	Mon, 1 Apr 2024 20:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=qIqSm9gXnIy4IU01U9n2+1kwoDJB5g4EBgemUvrrurU=;
 b=e7WzikmGE+UVAz+NZHB3FPBmFoFmfr0apgklQ2qjexYU5m2GbhIMgpaX2RUKLOlAsF8+
 0fq1tSaNqTihIynhB0FllWCAH6PeYtGklzR8XhEsRcLVPZjM/swL01zZRwrbGDdPwwtz
 U5wIPgGOrgLTTicKp2+ydLBVgS/miYI+gHd75Ot19tzYjXKpBa0U6xmkEUhFIuTairEu
 9hZ1RlLDD/LzRvr2GdHwTa8L4iRaZISI8eBxb9bXmlpfsMlXEl3gROIbS85Bc95U9I9z
 MtkpKja0KlnruMrj1FoaCtsJhfwo5k6/Kvj4UbDrx6TnySI+h2hX2xeXy/d9Xbp8bXvZ og== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x695ek6kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 20:18:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 431IZ2E5040386;
	Mon, 1 Apr 2024 20:18:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x6966055w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 20:18:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f46XDnZ1XFT8ZgLygkSz4biadwVcQ9+mQS68FoA1GqS8XlsJTaCVkTy6drhYsfFtLJbn3LHCmov6wJ6fns1G/lICEUzecIsnazpqWym3dDffwdJ+9XMgjPulqo1BKL6yM/aIBcioA0/ZeatsiAK1lvoOxFmS1lPRcDiCOLZFwNtMSAJrT3/XVe285DGtm5aX5UHu9rz9DFxWKUI8YM2EXYwUG2oyxxqIryIi4Nq96UqWHzqU1UZUdQAfIcWsdYKKK6uhvBvAD+pvVHdymDkRwlWNZD0IoUDKcEiccaXQA6B1v25XucaCGcLvruWFObj4+0UJf0XW5CoTqmm3QrxWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIqSm9gXnIy4IU01U9n2+1kwoDJB5g4EBgemUvrrurU=;
 b=K4dFmBGbH6OZnPI4jrpGHMHkQ605WeatoZrvoeqGYjEstLwBOyOFCamLwPwyI30PGAVniWJjfkHKLMW4YKtW85H+6eOVCPEsqFfAZlp5GbkBK4wvU92zt/q1nQ+WxzM0/H6cfDC0Ka52BDfml+PBBA8b5Fxjt4XPIQnYGVqt5nKeArdlK4+flUaQVLywC4I7kdXbcBo4B6w7QSpGPyq8xIP3N76IgFb8CKa3dod6BhA22AcY/E2jA5HtvDeT0wm6dlRdsuMyyhS/Oh24k0e1By6FKE/B1rZLVUQ9ie+HPLcbLv3OefnEcJ76/nxNyyzhWh2TXQuB90hsfypv3uk7bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIqSm9gXnIy4IU01U9n2+1kwoDJB5g4EBgemUvrrurU=;
 b=0LVDUne5rnkX6VXMSJOkIg3vdk3IW5+EadFEk+gGIimOuTtnbgOE3hcncwb/HFgT7phV5MQCcW+Nv43+d0619UcZArXaDRgzUjRemsOiMnGb4TmBt9fwYgULx7B5b756iUT4wvhLjyckl8Er7UlE9DQ5/BEZhdn/Ypeu8QoQuTg=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH7PR10MB7087.namprd10.prod.outlook.com (2603:10b6:510:27f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 20:17:57 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3%3]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 20:17:57 +0000
Message-ID: <ce69def0-c95d-4061-a8a6-b9d2b7fa2bde@oracle.com>
Date: Mon, 1 Apr 2024 13:17:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
From: Dai Ngo <dai.ngo@oracle.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <ZgbWevtNp8Vust4A@tissot.1015granger.net>
 <97387ec5-bcb4-4c5e-81af-a0038f7fc311@oracle.com>
 <ZgdR48dhdSoUj+VM@tissot.1015granger.net>
 <09da882f-4bad-4398-a2d0-ef8daefce374@oracle.com>
 <ZghZzfIi5RkWDh9K@tissot.1015granger.net>
 <84d6311e-a0a3-4fc6-a87e-e09857c765b3@oracle.com>
 <039c7e38b70287541849ab03d92818740fdf5d43.camel@kernel.org>
 <Zgq365RJ9M5qsgWY@tissot.1015granger.net>
 <5108ca5a-b626-4ae9-a809-ae3fffb50cab@oracle.com>
 <a30b343f-b6cf-4566-9565-28a5fd5ca851@oracle.com>
 <ZgrzwVp4GrbmZGWt@tissot.1015granger.net>
 <86dd7031-744d-4448-96ed-6d3d9c2e49b0@oracle.com>
Content-Language: en-US
In-Reply-To: <86dd7031-744d-4448-96ed-6d3d9c2e49b0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:a03:100::29) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH7PR10MB7087:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1I14L+gq7drkWIdY7vKvUJT1EVcWpLUfwAe2p+MVZMGuRKHNw32H3VsWysdrMw1uDlU8AydFmw6GPdxugLxlcBWf7C5WSCkaTXPgIB1FG2JfVUAWLFZcWKPWDgYbvrr7f9JZDdu/l9cBMtmwF+TmL94xWV9+6Eru14pChWpkDmOkch4/FsOk6o92I3CRfaSqautoa30imywYzCHSsPtHUuxZaw2xZzCi65G3je9eUNxc3g1UZuOgj19QbZK/W7mubtdel6GY6P/jtY7gMOqg1FsxN/qDkgZKfE1yO2vqO8TLZY6Hi692mzxjCM9fZpFEv7LL/zCEBK4SInDtfFSdZMNXQReilOO8me6opu/9swAWn79WXfHI1Br0ZHg5YxA4F2NODp6Vnbb1KwO5GqqwqhNKWPlXuIq3jCfOAGWtb3iVftYwjBIRRPIKVp43g63J8L/pE7wyNItXAgEBmXiu5PDcptfCrRIrFCZDbAbWGfoID94hGodqF+GdY29mkTkrhL3jaeo8fcA5cMbRepYnydR2hZZZY/hEqMck98FTfWZRofSD911cpzVJkj/52nWW6QIs+ptwUT0OfiKmgO5nHFtPAoDyDIo7FY6/UKnSixSOYm8HQJBu63b4cw6j82G7VmeDI6kNi5/n+35aUdc+Isd/Zz97ZrmuOmkb1zVF2N8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K0I2bUtpOVVqRFYvKzArY0p1T1Y5aHFUQ01HaXZYMUxsUGJ6Vktub01JUnZK?=
 =?utf-8?B?ZUhPMGVHdGQ1c2JuaEJXblNTZzJOdXFZQ0pKSmhiVC9ETldjblN0RldTZHd0?=
 =?utf-8?B?YVQveE5ZaG9XbCt5dU0wNVQxN2YzaDhhTGx0U1FlTXFLNkhHdVY5NEcrRnRl?=
 =?utf-8?B?TUVrNVZXTkdiWEJNTWFzYkM5K2dZVGVadUMwRS92aEttSUcvL2hCN1RYcCts?=
 =?utf-8?B?NHNhN0VwUXVuYVZEemVnaVZyVUtiWHoyR3k3RnY4cjRmVmJTV1M1OU1PYTFt?=
 =?utf-8?B?RmdOeVIzd2Z6Ykg0S052eXQ3c2IzYWdlZ1U2NEdsZ0FVWGNaOU14N2pjSTZz?=
 =?utf-8?B?SU9VRFNnbms0U3pZTEgvUkQrdUc4RTZ4bXN6Y09ORlEzWktSeFBNdE1mUjY4?=
 =?utf-8?B?OXNJTm1vYW9xTklJYXFuU2tOenh2bTM1bUNsazAzbnExS1BJaVo2U1JvaFRZ?=
 =?utf-8?B?cnNUejFLRTlPUEhjbnMxSzNpMlI0LzJaYlVHNmQzMjVPQUtwenU1Yi9IU3pa?=
 =?utf-8?B?azlQN1RJUHgxNGNycVdLRnplZ3BQSUxlVVNYMkR2cDhYODkxVHAzMHA5UzJ5?=
 =?utf-8?B?K2o0TDh4TDQ4UmtCUWVLT0dBMzdWTzg1NEhCdjc3SnE2ZjA1T1E5cGFOeWM5?=
 =?utf-8?B?SUh6UGJJNytyajdnM0JVbVBzZ0hYNGpFa3FwdTRqNXJnU2lVangzZ0w2Q0F6?=
 =?utf-8?B?YVBIeStZcW1WdFMyZUg4TTNlb1lKVU44NXJJVmlkQWo4QzhuYmNUMVBRMmJ2?=
 =?utf-8?B?MlBNYzVuY2JFWGRpRG1za2NUTVYvT1EwQW8wcGZGTWZ1MmdtZ3pkNTA5dWNH?=
 =?utf-8?B?eitGRG9NcG5FeXltcnB4NldmU3g4UE50TkVEWWt1bzlFT2d4M0JGQnp4Wjlu?=
 =?utf-8?B?UXRUaTRtV1BxYUl5SElTT0NqWGdsN2VNK0V3S3Fza1ZpREpBTkE4QXFNL1ZN?=
 =?utf-8?B?aVBDOGdvL25raFZTY1ZOOXI4OW1sbU1ybVpHWHFlaFh0MnlQK2hoL25vL21X?=
 =?utf-8?B?OHJsbE9CVjI0WTA4a2QvUHFqd2NjRXdLVUNhY3BiY3Z3OWZ0dHZrWEJWdlBS?=
 =?utf-8?B?dDdzaVhvL1JpVUdZRHZ5Rm1MWUdjVGlHYVJhSU5vczV6cFhEN2swMHhGU0RP?=
 =?utf-8?B?V1B3OU9mY094TzJUcTE2NTd4WkIrK0dXbjIxTzBZb2ZBTytPcmtrbTRZQkxR?=
 =?utf-8?B?WVE2Y0ZpNTZtRXRpOUdPenhVWUVISjYwcHQrZXBydTF2UTBZK2FGVkxxNWIx?=
 =?utf-8?B?aTA1VHZkb3NzeXp0TlRvNUEzWEk4WnpNUnk4SmdmM0dyR01acVlZbDlFUEhT?=
 =?utf-8?B?ZTNFWGtIOTZrNnFjQTV0N3lWZjVKQ3pXK0Ixa3A4Q01MYlhFVGlDVTMxNkIw?=
 =?utf-8?B?Q3ZqUVpZTGNjNVV5OSsrei9xaDBzd3E3aVpQTkZrUzBGT3NlckFaY3B0cmtm?=
 =?utf-8?B?enFhVkRBRFMwVXNRd1BpSHk3RTkwRTN5YitsY1dETDRoa3B0R0FIend6RzJX?=
 =?utf-8?B?Vyt0VTg2WEI3MDl4U09yT3pVaUMwcU5pSTJOc3BuamlmQkN5Q2cvN1B3Qzhz?=
 =?utf-8?B?NVZUQ1UrMVE0UlBLT1YwS1dsUlBRUWUrODRGYUVrMHZGaVVGN0FEOVdGdm9i?=
 =?utf-8?B?WFJGbSs1OGdVbHZqa0VNMWo4Qyt4SzVtbURrVW9FTEpLck5VaHhyVEtEL1JQ?=
 =?utf-8?B?OWZzS1huTFJXbVEzRGxzRHF4NUMvSVYxeGl2anRSVkxEMzdUUWorb1BtdjZJ?=
 =?utf-8?B?SXlwbHNPUVlpTmZ6VFVqVUU2N0xaUG1RSzN5bEZiNzBTSjVCY3llYUxWdVZQ?=
 =?utf-8?B?TC90VGVnd3dTRUpObDE4WmlSWndqZGRsbWlRa1RRYVhZMFFNd3U0azI5K2t6?=
 =?utf-8?B?YVp6MXFmUHVtQ0ZYd0E5RVFqVjN4a3kybEFEZGR6WjVrQVFpOHcwK2xGc1Jj?=
 =?utf-8?B?bTdpM3FjbzlJZUdQRVJUc3pZTE1rWW5IQndRWWF6QWFqbU5DS0ZRQ05TbUlx?=
 =?utf-8?B?Z3kwdFZQSkhSWkFtN3BOd1NIbHIrZ1FwWnkvWDhXejlsOStwd3lObGl5VEt3?=
 =?utf-8?B?OCthQ3YxRFp1Nng0UXBLcDZzcTRUVTJzQURrSml0MnpvWStXVGhKLzVyQVM5?=
 =?utf-8?Q?LtKI7dlrzufL3QLXGVJxEHgh9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	i9jLz7wN+VTB+4BgkoKlujrlH9DJ1W9kPNCl0obLWhV2jLjKIXZZTzlxkzkbRPI56BAxyVvA6D+mBn9xSoN9ROJu/c9s76etFmZnzxgWZNmdvhYBkpOgsHu47MNU/qIXZ2igjyDSb2GXUmZKbXFAGvlOkW1IrwQzmSdDmM1JIL52aahTZ8BZWxweuMsLA7rC/uKfZwh5uU5MHCueMWwzU0pdgDZCmbV38oIhyYIehJoRspTyQ/+nsKn8E+SbC9YIR1ApBvvYDl/7+Z8OXOmZ59VSMLaOfq63E+IGqJ8XbWomQWSOJK5ApYFLEZSRNMUlniezxnGXNI91/jMvfHaYpR4sCVpwy2+V6L8Y0HP4xY1QsHRliFvaWmHWTdIVqWiIo0kcmdblJ/ROhF1DBrPHB0W3XUzdUzv2YgN453vN5cgy1ii89OIQUJSdQpGZtiRXnxiWXYEGivaEWXwUojWq4vwG26de4sldWVunkiyPiS6z8Kui1wDzzHCSceTSyWWROPlDoEe7PkOcyVNCd94l5P01uAXwtMOIIgJPuW+sof/UEG8+eoy5EvsFjNdby+clLjqKIqP+UnwB6OppyRwi2Zm8kESl2png/f6Oe/WURSo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64254e9d-2d05-4fd9-69e4-08dc5288d22d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 20:17:57.6584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Cz4Uw/wzqXxnb7u4VSumQ70tyKtpTRyk6V/O6M2SYFuYpbe3/batMk17JVKB6IUE0/SxRaEJpSwF0lRrjBtWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404010142
X-Proofpoint-GUID: TDg9ydteY3mWb0AgE1tY0Eic4OT233O9
X-Proofpoint-ORIG-GUID: TDg9ydteY3mWb0AgE1tY0Eic4OT233O9


On 4/1/24 12:55 PM, Dai Ngo wrote:
>
> On 4/1/24 10:49 AM, Chuck Lever wrote:
>> On Mon, Apr 01, 2024 at 09:46:25AM -0700, Dai Ngo wrote:
>>> On 4/1/24 9:00 AM, Dai Ngo wrote:
>>>> On 4/1/24 6:34 AM, Chuck Lever wrote:
>>>>> On Mon, Apr 01, 2024 at 08:49:49AM -0400, Jeff Layton wrote:
>>>>>> On Sat, 2024-03-30 at 16:30 -0700, Dai Ngo wrote:
>>>>>>> On 3/30/24 11:28 AM, Chuck Lever wrote:
>>>>>>>> On Sat, Mar 30, 2024 at 10:46:08AM -0700, Dai Ngo wrote:
>>>>>>>>> On 3/29/24 4:42 PM, Chuck Lever wrote:
>>>>>>>>>> On Fri, Mar 29, 2024 at 10:57:22AM -0700, Dai Ngo wrote:
>>>>>>>>>>> On 3/29/24 7:55 AM, Chuck Lever wrote:
>>>>>>>>>> It could be straightforward, however, to move the callback_wq 
>>>>>>>>>> into
>>>>>>>>>> struct nfs4_client so that each client can have its own 
>>>>>>>>>> workqueue.
>>>>>>>>>> Then we can take some time and design something less brittle and
>>>>>>>>>> more scalable (and maybe come up with some test 
>>>>>>>>>> infrastructure so
>>>>>>>>>> this stuff doesn't break as often).
>>>>>>>>> IMHO I don't see why the callback workqueue has to be different
>>>>>>>>> from the laundry_wq or nfsd_filecache_wq used by nfsd.
>>>>>>>> You mean, you don't see why callback_wq has to be ordered, while
>>>>>>>> the others are not so constrained? Quite possibly it does not have
>>>>>>>> to be ordered.
>>>>>>> Yes, I looked at the all the nfsd4_callback_ops on nfsd and they
>>>>>>> seems to take into account of concurrency and use locks 
>>>>>>> appropriately.
>>>>>>> For each type of work I don't see why one work has to wait for
>>>>>>> the previous work to complete before proceed.
>>>>>>>
>>>>>>>> But we might have lost the bit of history that explains why, so
>>>>>>>> let's be cautious about making broad changes here until we have a
>>>>>>>> good operational understanding of the code and some robust test
>>>>>>>> cases to check any changes we make.
>>>>>>> Understand, you make the call.
>>>>>> commit 88382036674770173128417e4c09e9e549f82d54
>>>>>> Author: J. Bruce Fields <bfields@fieldses.org>
>>>>>> Date:   Mon Nov 14 11:13:43 2016 -0500
>>>>>>
>>>>>>       nfsd: update workqueue creation
>>>>>>            No real change in functionality, but the old interface
>>>>>> seems to be
>>>>>>       deprecated.
>>>>>>            We don't actually care about ordering necessarily, but
>>>>>> we do depend on
>>>>>>       running at most one work item at a time: 
>>>>>> nfsd4_process_cb_update()
>>>>>>       assumes that no other thread is running it, and that no new
>>>>>> callbacks
>>>>>>       are starting while it's running.
>>>>>>            Reviewed-by: Jeff Layton <jlayton@redhat.com>
>>>>>>       Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>>>>>>
>>>>>>
>>>>>> ...so it may be as simple as just fixing up 
>>>>>> nfsd4_process_cb_update().
>>>>>> Allowing parallel recalls would certainly be a good thing.
>>>> Thank you Jeff for pointing this out.
>>>>
>>>>> Thanks for the research. I was about to do the same.
>>>>>
>>>>> I think we do allow parallel recalls -- IIUC, callback_wq
>>>>> single-threads only the dispatch of RPC calls, not their
>>>>> processing. Note the use of rpc_call_async().
>>>>>
>>>>> So nfsd4_process_cb_update() is protecting modifications of
>>>>> cl_cb_client and the backchannel transport. We might wrap that in
>>>>> a mutex, for example. But I don't see strong evidence (yet) that
>>>>> this design is a bottleneck when it is working properly.
>>>>>
>>>>> However, if for some reason, a work item sleeps, that would
>>>>> block forward progress of the work queue, and would be Bad (tm).
>>>>>
>>>>>
>>>>>> That said, a workqueue per client would be a great place to start. I
>>>>>> don't see any reason to serialize callbacks to different clients.
>>>>> I volunteer to take care of that for v6.10.
>>> Since you're going to make callback workqueue per client, do we 
>>> still need
>>> a fix in nfsd to shut down the callback when a client is about to enter
>>> courtesy state and there is pending RPC calls.
>> I would rather just close down the transports for courtesy clients.
>> But that doesn't seem to be the root cause, so let's put this aside
>> for a bit.
>>
>>
>>> With callback workqueue per client, it fixes the problem of all 
>>> callbacks
>>> hang when a job get stuck in the workqueue. The fix in nfsd prevents a
>>> stuck job to loop until the client reconnects which might be a very 
>>> long
>>> time or never if that client is no longer used.
>> The question I have is will this unresponsive client cause other
>> issues, such as:
>>
>>   - a hang when the server tries to unexport
>
> exportfs -u does not hang, but the share can not be un-exported.

unexport does not hang.

-Dai

>
>>   or shutdown
>
> shutdown does not hang since __destroy_client is called which calls
> nfsd4_shutdown_callback to set NFSD4_CLIENT_CB_KILL.
>
> echo "expire' > /proc/fs/nfsd/X/ctl does hang since it waits for
> cl_rpc_users to drop to 0. But we can fix that by dropping the
> wait_event(expiry_wq, atomic_read(&clp->cl_rpc_users) == 0) and
> just go ahead and expire_client likes shutdown.
>
>>   - CPU or memory consumption for each retried callback
>
> Yes, the loop does consume CPU cycles since it's rescheduled to run
> after 25ms.
>
> -Dai
>
>>
>> That is an ongoing concern.
>>
>

