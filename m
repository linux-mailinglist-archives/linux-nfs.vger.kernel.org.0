Return-Path: <linux-nfs+bounces-5278-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B1B94DDC6
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 19:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8141F2162D
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 17:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A38158528;
	Sat, 10 Aug 2024 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eNBhKa+A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gz0NRZv5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAFA1B810;
	Sat, 10 Aug 2024 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723311658; cv=fail; b=K+ENzppdFIo1w43YZdvgb2az6I8YRqj6q7kdRzQpHA5rcoHXpvyv3yG1TUghl2k6KbhiyGmN6cUlIfxvXP3wSppcJcNbcaN1/gpE4uw8UBewSC2LKIqC/wlI3KkcluZPARzwrNgbAM5r5ZasKAhMUqXvD7aGFJCjDRU6itZ0JLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723311658; c=relaxed/simple;
	bh=kGx7Hh8hE+6mR6U74+P8JCU8L1EprXcx7DV9JdFd1Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=HU8ZnbUZ8jOUmfGbPPtOcXI9Qs/aX/sqGGO89kHgR+55GxCvIQsq72c8eLl1j06xeThD5DlPMNsLNbVcuFeklX44iP0/uclPzR5jp1rfvaFn7MTIqaiifH2meFixHo1Q+0eywRxADCojpuQWXTWAe7iD02Tpw/oXfaNiQ23URKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eNBhKa+A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gz0NRZv5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47AFwDuq012600;
	Sat, 10 Aug 2024 17:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:content-type:mime-version; s=
	corp-2023-11-20; bh=OkpxjZ1OCH+Pq0GPS5TxhabPVnzIA7QrxYmMFyvZ0R0=; b=
	eNBhKa+AYNAkmq9wy4JBp4lzlvVi46GeWfKqzrrvDp45wa3y28PmhyZtdKRINeSU
	ENzvP/k6K1EthuMueMTEgKXBL+KggKe2e/kRDO3tbL3nJzicifSXKCHN8t45+Nlz
	7UiC0/OOx5poFWdF5hzw/2B4G+19qN/vWOlkY3Vcf8dtyP3Yg1vb9CJbyCu1hvKe
	K0SnhjigsQVf+aREVYZQMtxSiPtNS1AUmr6tbZ/oHvq4wefafnrcwAEhRlzFrzt7
	sCzlaqza0Regl12Nk7+N8pKQuL3wqsW9Vt6p3IAeYGeJ67l6u5+FMz4Nl1K10jYV
	wpveMGA8QAi/Zolny8NZ5A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wytt8f36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 Aug 2024 17:40:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47AHLqqq000678;
	Sat, 10 Aug 2024 17:40:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn5vkb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 Aug 2024 17:40:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQC5kG2v+4XYJu63vDnCQEWurxBEM6v0C4USw3O63FwVlMw0giomN1+jdVHy9/jolKyY8y+69nYYaFhryqNNpB+aa+crSFkw+wSVOmo1FdujF2qJ5GlrHKf6tzcnmD3wFaFXXx/CfV9P86f/5Dyk8oNIcYgiiPdEk6EcixlSRYUD79zBwGnU5TzdWQCMYclZ6/2BG7bOTTo3iNZMkAkS7lafA28PnepKQviUklDuKPXtebbq18Wn4C3Oce7gQ3kfU9/cKHpnudTuUVkKvu7vVrozTSFV0kCr+ILhbrSOHfY5CN15B2m0wBLOLrx0njP+Kmjf/lroGvdGxwJnQfiHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkpxjZ1OCH+Pq0GPS5TxhabPVnzIA7QrxYmMFyvZ0R0=;
 b=KjxluBFZiS79Igya2klktS9U6THPxy3lICQdcxzKV6OnfCd1iFzA3XF5f8qE4omlePUxbYJtfdKLaiv1daUSTQxTRP9vjK8p5EdLQuNXNm06SeD78gjQnb7DCVlFu1rtNpNFWKV7z4r8LEEusDCiVIHii3xtsKn1Qt/xrNWf2SUDXNuPb1+GsoRj/DHa4ll559GrGjnGyTCbj4il56W25XeXLSjtjaiOzgNlEPEyZztd/rWlFjB7O3nqCJskCcXni40+9F93XMjq/PAQJ7WvA5jbyk+CFUbNQFy3oaO0yuBDlaAkeFARft/2NR04IElSfH8zD0qrT+EVFxEZzJArhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkpxjZ1OCH+Pq0GPS5TxhabPVnzIA7QrxYmMFyvZ0R0=;
 b=gz0NRZv5Ht/IfYj2H163UETYct4twOdxq96axb3Xoo4u/TmNFIyM1F8WtGUX1j83X6TqCTUXnQ2FJZJ9L81QWeK6HRK6ApVzMRvhvBPxjjFlrt/wAjDisOLVmdIBNRUAvfHBhvNSKfo/JRBeVaQAy907HJzZe1NZbP5UOeuTdbg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYYPR10MB7569.namprd10.prod.outlook.com (2603:10b6:930:bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.8; Sat, 10 Aug
 2024 17:40:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7849.013; Sat, 10 Aug 2024
 17:40:41 +0000
Date: Sat, 10 Aug 2024 13:40:39 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] nfsd fixes for v6.11
Message-ID: <ZremFwYpY1m/5w88@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH2PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:610:5a::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYYPR10MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 81900f0a-3312-42da-0c4b-08dcb9638e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V0m41G2LLwPSs7de4P1VC2okTNkenrbXQjP8J2zwxzNuoGtD1GjN91RGAK67?=
 =?us-ascii?Q?57nrxKDN8seMrYvsfSdTXw1/mP0sWHhHivzs5BMgTQFrrNgdsPDqZkuNyH5I?=
 =?us-ascii?Q?NGyngoOraVQSwjjeb/JVJt8Qj1Hi3Qjb/dAxDxEXoFYX85e2PzQ0vPYF+O5d?=
 =?us-ascii?Q?eGqS4lcVST3GsJgDDavfYsmhqkAOEyc4XVDMyb/lZ30duIo95799NdV4jHA6?=
 =?us-ascii?Q?oDsWeP7GKBCPK0vL44IvFEGupe2b4fwtBgOCNtoOzyb9qIpWiZrhtE4IB3PM?=
 =?us-ascii?Q?YXzKjE+8PuOZxaPOIhkfuDB76FAabvz5tL8GjZrn66t9Ifa5hSKoujFPnR2n?=
 =?us-ascii?Q?5BjCKUG8l2QyfLHCZNaBdJEqqSxHoOXZ/9oBTw0GHyYQNSKdL1YM9IiegYn3?=
 =?us-ascii?Q?TnhCGLzUTRldAtEwV6/jpH38Wa9mbCC71c00zfmp4go5zSXZVBLmVajfdkxY?=
 =?us-ascii?Q?WzJa/QYavRWb1EW93TmjmYk18SkvaVD/m+Z4Q4URL3ZkQ0XWQaBVPFrkkjXd?=
 =?us-ascii?Q?QHH6BH3z9LRrrKibEhC10e6mxD73wd656D9zvF6Z8cW5VYhbN7wSscEtsDyx?=
 =?us-ascii?Q?MRLlph+10JLOP10hNcwqhFLYuBo8ZbdxgWem+/9zlp7p6gsfvxAeQfb11J07?=
 =?us-ascii?Q?ifibOu4TNzt7igPo0iOqNSSEjhe3FaNACYWV2jsWtKAQxEWTBgp3HUbcspg/?=
 =?us-ascii?Q?Lvul4r5oPTHDV4SCv3XfLxiQ8ozUFGjkSiS/V13hoKQhxMUz3V/nWPLZCIKD?=
 =?us-ascii?Q?G2P4TjEPDAuAzU4QEUJlZuw584CwBJlC/s9qrCr6I2ZMUR8qjmd1MgqxNFjL?=
 =?us-ascii?Q?e1EZeVuluv2WZspC7es9Czuo0VyM343yredbALnefdRNP5gbSgrW8GcIU6gA?=
 =?us-ascii?Q?KBhlAcVQ1kscbvbKUdo3PynL7bCkRGXVbGRyuZxRiReQQGPkCtCeiJN20M7O?=
 =?us-ascii?Q?p92nW7JqAMJRcaC7MaZLR8zvXEmJBV1wPVHT81ug1V838ox9e4DhwYv6odeR?=
 =?us-ascii?Q?V2DJEAGZPZGRyrWknry/PSDTFNeyqMZR+UaDu28oT57K50NXoYFjR8AY+/q8?=
 =?us-ascii?Q?Hu7Vff0JDRGspfWoYIX2qHxsE3rIxAo6BRV/u2/RLnnZWc7+wDZ3dU7pvIaE?=
 =?us-ascii?Q?Lq1tfTATdJrfVAvLJroFBUfUYFBQhOiok7I7dge/tEdtlsVznkP+SkSS6aKC?=
 =?us-ascii?Q?4NyZ/iF5NmQCQC8DcmVCPPxbuB4Poyq1fFpfsZFelMV4IB5yR36RqMEuj7SD?=
 =?us-ascii?Q?+X6YSLIuiINYge8YpF5QYr2FrAZIQUHLcramXeuPM16rfHcuScdu8g1j+NO+?=
 =?us-ascii?Q?tRQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?az39hPmRYBaEJpo0Vi0Ype2iXu2t7HQeUwKl06yt+8Wvs9VQvr7W6Y3JC8u5?=
 =?us-ascii?Q?IW2EKWB/1U0qoI+c247QJmTLvAmRH8bNCRM1kULkX3toAl81hb7xs7s+loIw?=
 =?us-ascii?Q?uZWsKGb32GvQsjaBHu6HbCHE1ZPPZp2a+36NxSd/9DwTcGGzO6gvTpvqecfy?=
 =?us-ascii?Q?GwdQtYQffxctGl2vNBmpydk5ppNYnZv4fufEkClTqOi5HMuM1wmDyT8QLgg+?=
 =?us-ascii?Q?1GH9Hyd/VWL0DtNmQ1hjH0z1pBm22pPQAqtByZC12CJS0ljWrM2CLYR79b9F?=
 =?us-ascii?Q?bpY/WRO6WHFDBEgFOC6qmi22PEPYZrBVy4p5UAitvXfMBc3WzWFI1ULbd6iT?=
 =?us-ascii?Q?zyd4hW7KMalnGwFAxOUeohE4JSxpILzNLPkQyeE7vO6msUV9F1+VwAcCnM49?=
 =?us-ascii?Q?ovPp2c4kT4UAbUEOZ7/qbVnGfO76CRFwZAIj63YXh/HdbbnhuA90v+RG1iGN?=
 =?us-ascii?Q?uOXRsPicZxuKGpkXQedR/W/Sm+6k/8Inz7/i/CJ3/n5kpTY7vSP2p4XDCEOB?=
 =?us-ascii?Q?TzWZt6w1pOLxlIjdeQrR0BOYRPS2WJlr75v725KUopNSsWTAJ8bB0pNDcYUa?=
 =?us-ascii?Q?UhU+qeGS65HkHUXyxOxljLdW92ND97QCQY+gcO+E3Fu0izM//r8vHchQ2Uvl?=
 =?us-ascii?Q?LjGIgL9tmSNgpsl9LZ8QbzgcCefhUmbGHwBQIcJo534NMWLUXHKvq9gS+MjV?=
 =?us-ascii?Q?pNHBqxR3XzY06JjchQuvEiMGBH1xTEszVPtNDXboG5OdT+HkFp6MUjo8bNMj?=
 =?us-ascii?Q?QL5Kt0s2QSIQjx+rlEFJb7UAZuReA9skoehEzxbF4Lcz6X1auIDKALf5okr1?=
 =?us-ascii?Q?ZB6X3kQDqBDjTJ4W3hcVYzvqlBSZusRE5OaNl9e0G8jAHOzW9mx3Wm5pUybQ?=
 =?us-ascii?Q?38SbIb7+KxZ/uPDFkmXQtLr7k1ApNB9/Ye9D3H3rz0XQ+NzVuKZSI7xxZxlm?=
 =?us-ascii?Q?g72+fVR8+VYHELLVPH4CpF1SxQCbncKi8FkLlc1+SoeJXZpu+9w5l026cAN/?=
 =?us-ascii?Q?uF2j5RcFLH6Jox4K9PinsCoQavrcuNROs/0EvPC23jsEeo0JbqMvwS08r5wR?=
 =?us-ascii?Q?ZAAF1wMZ4zmGjvHA1oJd0tUd2/mIPfMneiTiyRBkiU2x2MYsdXPlIh9RmRyN?=
 =?us-ascii?Q?nT3uZHfCLRXrLdDsqu349JmVEl+ob+9RPNVhwFSyXeNrOCE8b+JAFFX7dS3c?=
 =?us-ascii?Q?EU0JVDhAWuTy5wobGkoP8IAq1umOzpFIFLEL6Prg3vchengroRn7KJbC639a?=
 =?us-ascii?Q?pmvVIxweDbfrfKHbRhl69i89ZtxtXijX1D1mTHfEkI4CPs3qP1VjAYyLbhqJ?=
 =?us-ascii?Q?OXgb9l7XBOXEqCRTXYA02i7eM6PUF9XqFPO3oR8gm3PMsLmyzqtRSStmxJSA?=
 =?us-ascii?Q?B5erH11fwU7lHkBX2XkyKUiezTtzcyYgLs0WMOg6a5CKtXrrdFbf/eewIlH0?=
 =?us-ascii?Q?hyQMxMLIcUNWUZJaQURLyR7lWKrGuenCVVOPK+2zgFd5SHD58rgzGrYum6kc?=
 =?us-ascii?Q?eW9O0tS/FzKU1BP6CFMCq32/5goptmmgbbBIAX0YMfpZA+EC4zHtAVln5Qn4?=
 =?us-ascii?Q?Unpn4ILqS8HG+1gb9cph6LUWmqJ+QRtxGUj2jK5b?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xM/Baxk7jSM/7XI2xu7Bh5F+Urf+R8rwp84hykFdDQMywiZSa76BDCFX2hMJYA4c2GeDNYqbGBhNgzYZAOr2eimXednRa0vib59Paa6jCZspV2wsMgvbl168WF3D4mhOZff5/XpmRNCwi+vluxmDl5ibBNvdBUqDoOovN/tLwZtKfAqxG0bHEhvxHZ23YwdLVE8mTie12gl9rxAEPXlFzundj9VpqOLZaiWHW3aPIupEX132UIow8nCjgTcak7S9RrQueoXxPJFKyZliaI0AzgtS8rzoE4HL7teJHMmnbz1bGkYtt9re5MG6VOUbR428PsA+5HsTM3aqw1+gResv/slmojVKAORnh7/IjuzTJm2LwTNb4w1DG4/VURGdd7Iy5ZQUTBDhd7j7I2VyyAuCu/evIOo+2o14riuL1ZR29Qe2Q7x5/QOjd2MbxLNp9l20RfZeUECW9CybjJF0lAEcwF+gp9Fe9ujFQYhBkb7nq68px/kphOmUtnvPCVaWYJE/GaFw7M/eA4mUEni8xpHLqfP3mYfghP6a969w38zmCx803J6KsEpFuD1SEn2Q7LoIItococQdkF9m4wutC+h1LNzQZGuXrfOu0RkDEB3y6iI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81900f0a-3312-42da-0c4b-08dcb9638e2c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 17:40:41.8713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aNIPlQwxqD4U0XZx1EgTPv94hiCmz4Xy/NdihVkLe0LGCjP3P82vawB/qHgycOYRhaRx2z7xTTtinEcoGHsig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7569
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-10_15,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=679 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408100133
X-Proofpoint-ORIG-GUID: gFWTHpy-a3O8aFL9NzF8NQFlK5GbZ-MA
X-Proofpoint-GUID: gFWTHpy-a3O8aFL9NzF8NQFlK5GbZ-MA

The following changes since commit 769d20028f45a4f442cfe558a32faba357a7f5e2:

  nfsd: nfsd_file_lease_notifier_call gets a file_lease as an argument (2024-07-12 12:58:48 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.11-1

for you to fetch changes up to 91da337e5d506f2c065d20529d105ca40090e320:

  nfsd: don't set SVC_SOCK_ANONYMOUS when creating nfsd sockets (2024-07-22 09:47:39 -0400)

----------------------------------------------------------------
nfsd-6.11 fixes:
- Two minor fixes for recent changes

----------------------------------------------------------------
Arnd Bergmann (1):
      sunrpc: avoid -Wformat-security warning

Jeff Layton (1):
      nfsd: don't set SVC_SOCK_ANONYMOUS when creating nfsd sockets

 fs/nfsd/nfsctl.c | 3 +--
 net/sunrpc/svc.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
Chuck Lever

