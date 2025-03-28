Return-Path: <linux-nfs+bounces-10941-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B259AA74A71
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 14:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E741896D80
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 13:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAF045979;
	Fri, 28 Mar 2025 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tc1g1pHh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fh0b1kLl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD2D35942
	for <linux-nfs@vger.kernel.org>; Fri, 28 Mar 2025 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743167499; cv=fail; b=ckwkEPtRi2zeB48iq1ggoiNpVUBc2Z3vuyecJw4P/RrPkFU/qb//e9+p09gAIoldBHOkCMVMabEIIYXUELg20KrNWzYsqkLzgcbZgjZf9pJ4AgOHQsqhNxnrIRjxTdhc6Xa+Uwg3nF0hv8ZQc8xo4TVfwEZbwyk1kSn6r84EXoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743167499; c=relaxed/simple;
	bh=VXJ8cZ3FlH7fH5vVRjtG5Oi1Z+Twj0QKWyF9N/bUqmY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IMSpH2x/mIrDW4MgDjhLyly0mWfVyr62exSavCO8iyk0bQVhTBGXM9oWQC4PuxKcjjUlMWRPo2r8LUScdRC3PmVPXGp2tzWs3oSTVR0fN+6MuEI6v8ZLB6eb10okS8aLTIYnomDMA3NCofxlY+frBFX96i1BgYLtKU+EpldH2nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tc1g1pHh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fh0b1kLl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S0u4XB020259;
	Fri, 28 Mar 2025 13:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=NKudNGdR+ig45fY72WNqf97MMTtJA/B9Jf2v3ftUk0c=; b=
	Tc1g1pHhcQ4B0RRJtU/x27VinPc+FzWGFkSlFL4MMRGDXHTxn+5lNBMw40kraqhR
	mH+6p4cJo5Ww2N6B3WeKCXfUHlB9T0FCAkAu/1AVA9K2ub2KW383OiIW7xiIkC+Y
	2HPmX24GVRtEEuZvbeV7oOUS/Wll8fDEn+BWWSmG4XXncRaaaK7kb/FDTtm0F6Of
	yHEhuTPNx6oB/pu5gErHvwVHUCH2zX05K7gS8vvnXv7PLPH/pm6gz/IkNh/jTc2W
	vjJUUzWlV/jkEaK3J988Um9RJiH+uS/uBr7d4zcVu69poRdb3vFQyIT1k37JpnQn
	pWgkx1og6jYOlVY4fn3fDw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnrsptwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 13:11:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52SBuF8x036460;
	Fri, 28 Mar 2025 13:11:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj5gnrjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 13:11:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bew79SwvWZY4HsaaIJn8P3K5WrkQovx6w3I1tnYzIagW7aRsTRyKTfRkkCTKHewfE8/CQOen83jAUwgmtq0JfWEXiffQawFTfNPfKNtEqJI+sO+V0+rbfb+S4nwiFnYnROPnVAVIsYyKVrRLgoGA9FbO89sdizcwr+icpPf+A7dXqRXtO0EtKCU+JRZkBmUvuS8mkS0nnB5tZBZgwry37oW0I9vLwFZO7sfj9u94Y1DkhYbYgzoLw/ZDJRT06XnYN3pq9bh0N5r2/MPuYUekmi2xLpmpFIvGe0xBuKUcc3Wp2JbNB/izgPRX+HKGXluRAQfh6neN8EI/SngBs7ZA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKudNGdR+ig45fY72WNqf97MMTtJA/B9Jf2v3ftUk0c=;
 b=piQMmOBxGU+o5utSyfjpwdv5vDtz+qtNts4k2hR8f+BbQuMmbBt7zxM2YZu85banAvE4HWnYgUY+6kQs3vreWMjs+vN9KSWu5IWnvny+mMaCG82Zay1oWi5+Tt1rflx2eHtzsiG1aCehevBEHO9b1dE9JaD8P/aFfrBthpEsbudK4c9vL07ZhHk2l4zYYbBeXLe5CuUqZs/96/Rpm4dQkT0xhm5c+6xQQ6PxL/SW141rDHTQdBwWANlKmffeg8qOwhU1hPXbRunKaTG15P/tBBHzFpLcoI9kuL8aixSQQRXi9kpJfXFwzWgAe6qDtM9QqufvAegAlM/jpPdUrh2lKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKudNGdR+ig45fY72WNqf97MMTtJA/B9Jf2v3ftUk0c=;
 b=fh0b1kLlogZAif1KVYQaIHgwrGKbigDGapsnmDvGDdS9DlO6t0IbBWXNXvaDO8jxrbKI+3K5Z+Es2zh99PtGWVgI3K9zq/0y8QmBRrOFVU1RhFsmhYoNxxKOzGmUDNObjvo/JsVTyDvmKfdAmV/oH2J7b6xDnCjpH/oWxamfnqQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4814.namprd10.prod.outlook.com (2603:10b6:a03:2d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 13:11:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8583.027; Fri, 28 Mar 2025
 13:11:31 +0000
Message-ID: <17f1020f-42b8-4231-8af8-6b0d90067d10@oracle.com>
Date: Fri, 28 Mar 2025 09:11:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: The (sorry?) state of pNFS documentation?! Abandonware?
To: Martin Wege <martin.l.wege@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CANH4o6P5mXTR6dpKCKHHrF4jcAL=wWoy3AWK6vateUHphSPvqg@mail.gmail.com>
 <e0930049-e97c-4cda-8cbc-8ad02cd5438a@oracle.com>
 <CANH4o6M-gG+e5saZO7LGPU66X8f5azRh78S6ECF-K=zw=J7wxQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CANH4o6M-gG+e5saZO7LGPU66X8f5azRh78S6ECF-K=zw=J7wxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4814:EE_
X-MS-Office365-Filtering-Correlation-Id: f11f83e6-e9fd-494a-8996-08dd6dfa0ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ump4MW11aW5uek9RYnF5ZGovdjQ3b29qSTh3V3o2VkdGbGVPTVFGZXdPcDlr?=
 =?utf-8?B?MVFHZkg0TTROMVBzd1FEUnhGVVIyVHQzemRoM2lMWHZXN0ZCMU1SMVVvcEJn?=
 =?utf-8?B?WS9tNTUzRlFiTjBmZG5SL2h3Rnh2bGlCd0xiU3QrS0hSN0xIK29YZDNzeVRG?=
 =?utf-8?B?L1lMdzQ1aDFUU2M4OUNQOURYNUJRa0UrRTF6dm5JYlF4QzBtNjFXbDlGdUs4?=
 =?utf-8?B?UkdaWkFaR0dNU3g3R1pQLytTZllWL0dGRXRXTEVkT1ZzQ1JhWkxGc3NMZUh0?=
 =?utf-8?B?WFF3RGJZVEpXdjZha2NRdUtLcG9qSk54ZDJvMVpLQ2JkMk1USGVPaVVGNjh6?=
 =?utf-8?B?d2lQdXcxNWJHeXZBajhtanNFKytsVjZLcU9NdTBEUkdKZW54aG9QZ1hnZU5T?=
 =?utf-8?B?Mm4vVlpCdC9zYkhGK3FWc0IzRGdGRTdtNytQT0RzQjU0QnlwZWFXcWhudllE?=
 =?utf-8?B?OGJQbXVjV2JyeDUzUFF2YUlYc1JWTUFrRmZtRGdwRkRhdWFrdVZzVGF0YVZh?=
 =?utf-8?B?SEFIWmNJbklzQXEwK3RMT2RHdTdOTXZEVXhXTnd1NTZod0U5elRNSDd0Mktm?=
 =?utf-8?B?a29UM2c5cVFjREVTbGZuaW96WG1nOHBLZGtNSE04TmNwK253VC9mR09IcXpZ?=
 =?utf-8?B?TTd1S0tMN0pvSzRqK2ZPOUZjQlZYNHN6REdQcmxKc3lwNWhENklKMGIyU3c1?=
 =?utf-8?B?NHFNS0lMblA1emVtZnJyVCtOMFE0TFZUekNGUFFLYTUvSUY1QkZPdGsxbmx4?=
 =?utf-8?B?Nmcwc2p6bTErR2oxNWVzRXZBa3pIZWgzYmhjRDVTcStacXNkQTlGR2V1Skox?=
 =?utf-8?B?emhGWGtxVE1nRTc4Um53RWVCcU4wcEZvbHFURHZWa3JKRlYwblhWRENIUHpW?=
 =?utf-8?B?WTVXV2tqRjFFOUlsbEdKUVFWV28wSnJHYitSbUlBRGU2UEdZV1M5cUJ2Zkdz?=
 =?utf-8?B?SHZkelZQSlFMc05TdWZPSXpzODBSc0xxT0ZXNU9La0VyNnBjL1NCUFhWSW42?=
 =?utf-8?B?VDNqWXhReGI1TEpNUW1URzlZT0tJQk9zNGNDZTVtUVFCcktxTzJMYXFQb1BI?=
 =?utf-8?B?RkJ2K1JBdUg5OGUyU0tKdHBHK2QraXMwb0xPZFRKSGYxa0RDVS90cHpSSmk4?=
 =?utf-8?B?cVoxa20xM3pWTjdqcjZSZS9oNkx1SENUblBGb05sVVBtUUR0RXBYd2tkRW13?=
 =?utf-8?B?ckZ6SFgxTU1RNUVZNFh4bGZHVlpBOFFCWVk2T0xNU3E1ZmZFUzJkSitxYTRy?=
 =?utf-8?B?M1ZtMVFSdy9QcE5NR2FFQy83Y0h1VTMvWWlGQzdxQXdtOCt3TjZEVVFlWGtL?=
 =?utf-8?B?R2VzcjJKbHBoQ1RvU2hHNEVuMk5Zc2ZQSzFEeXl3YkQ1aVZ0VnpNcVlZUU1P?=
 =?utf-8?B?cWh4eTlTOFZ5b2pRYld2dDFJWGhNdE1LWFh6TzR5ZjZrc3RSclJWT01Zb0hL?=
 =?utf-8?B?alZDSFUzcHRBQ3BCWXRRSWR1ZEo2UlEwR1NNblJ0cExDZlF3aFVHTGl2UVBK?=
 =?utf-8?B?SngrL1dCc25WN1lMbUhiaTV3UzdWSlhldGdEYVFkdit3cG9TTkZINzkvOWJK?=
 =?utf-8?B?NzJhR3ZtUlRXYWViZWtrZXVqOW1tdUZ4N0ZJWXRBc3M1TDBYb2Q3dURyRHlt?=
 =?utf-8?B?SFFVZitkWG9ucXZaelZYL1pwSmNQb1dBKzBXTU96TlpFTnVwVnJpME1hZ2RW?=
 =?utf-8?B?bkozaHI4SmNyV2tlNmhvYUxnMHNxYUYrdm9WdjhURDJCMjZXeGR4ejk1Y0pE?=
 =?utf-8?B?dkZiMnNhQ1NPYXVLa1ZqcUs5WHZDRUwzOVBHeXd2RE4wNE40QXk2YitBZEd3?=
 =?utf-8?B?NFJNQ0pYemszaW5ORklPaVk3blRKdDJpOXp1clJYZ2FwN2o1bnN0eTJoWWN3?=
 =?utf-8?B?OUhodDNYSm84d2c3dzVtZUFockxGcGw2S1NFZGFZSkM2cEkyVjR2RUNOR1g3?=
 =?utf-8?Q?EMTnFzJ4HRE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUU3OGxiZndoU1dwWXBudWdDOXQwTzVNWmM4SDZiaHVyYWs1THJRZ1NoVWdn?=
 =?utf-8?B?K0xUL0lmWHQ1V0V6MGFEQ1J5Y0RTTlc5TnVPeFRMNFNWeFl5cy9peTFpMjVI?=
 =?utf-8?B?RVltY0E4cmN0OEMzSHRxMjBhbWY5YVEvSXdOcjBhV1p5OU5vc2I1MFc5MTI5?=
 =?utf-8?B?czFCMXBOSWt4SWt2YVRzVG1oWXY5UzlQVjlvMHpnN0RTLy9hamc0OXA0TXhm?=
 =?utf-8?B?WklkMDl3YzJQN1JOWGJRbVpyQWFLZzNrSFFSdHZZSG1oaTlTTy82WEtuV2Ri?=
 =?utf-8?B?QkRaS0FFVXY0T2pmMVRUSG1DSlk5OVd3UXZRR3FUQ3BSNkZoV2tpcWV2d2R0?=
 =?utf-8?B?M3RUNlVtVGFXaHhLVlRBcG5SYVE4cjFkN0NhczFRQjQvclZIMno4aldSTU40?=
 =?utf-8?B?eVhyQmxrZ2hIMHFpVDF0bVFkMWkvY3NnRXU5SGFKbVpML0kxZytCTG10NDlT?=
 =?utf-8?B?NGY1aVVUY1Z0aFhkalJrQzVBUzlTem8xTTRVandBOU5QL0dSd3BHYTdOcXRp?=
 =?utf-8?B?YUxtdVRwN3MvM0MralhOVmI5K0tVbWdMc1E1Y0I3OGJuQU1XRElZK3lNeldW?=
 =?utf-8?B?YWFTaXZtaG1sczNTSnh0U1owazR3b0h0cWxlT0JWeW85Qk5MbGJWVlpTVEpO?=
 =?utf-8?B?ZTQ0eVlpYlZwTWxMUWJ6UElIOVMzdlN0c25ZMDdVaDB1b3E4ekVXMzRKT0dw?=
 =?utf-8?B?eUdiOWt1ZVFVUFlrUDB3emJlMW1nSGg5MnhTOTRQazROblZwNDF1UkIwU1pC?=
 =?utf-8?B?WllwSFJhak1iZjNzMFVJeWpCZXd2bFRLU1pWUm9adVdHWng0ZGs4RVd6b1ly?=
 =?utf-8?B?TFBTbkRIVzRIbmVuVGpSQ3h3cVMwclB3dzBTclAwMytPckJPNS80Qlg0S2xL?=
 =?utf-8?B?cS9KTlVOMmNCbnhOWFZwZG5BdDRTcE5RUXRkbE83ZVpxbkxZYUFoTDJqN2ds?=
 =?utf-8?B?SGh0enZyZVVDV1p2T2FZTHhUQVpzQ3ZNTTZWc01oNURqOEtORmxDYkNvQmtC?=
 =?utf-8?B?VEwwMjVmSm4zUnRWK2twaFdqbVROaUdabUh3QlArN3oxd3NPTC92cjBzNEQ4?=
 =?utf-8?B?c2V3Q2E2RC9vLzN4d3JzSTI2M08zdjRzSWNVT3lTM1g0T3R2NURrc3hTNzFx?=
 =?utf-8?B?VVJ1dno5Rk1jVU9IaFh6MzR4UWJiTmFWUWthVzN2bDRiQmt6SHFYYjhNdVBz?=
 =?utf-8?B?THhlSy94aThuY1RoU1dBS1ZNK2NvMFEvUlZObnI1bFM5aXJ0T0pDUXU0a3Z3?=
 =?utf-8?B?cGJXMW53WGFrK0pTeTl6TVRFVVFPNm96RzJsL2s4L2RZdS9ac1hNWDdpV05N?=
 =?utf-8?B?VFdvWTdRc3krWHUvaUxwaVFVQ21KbnJFN29jV0o1QkcvSjd6aHZ5MzV3SzFU?=
 =?utf-8?B?QnJMSHhuRm5qcjNaZHdCYmNudXBYTlpGQk1sbVhLM1BxdWVEUkEwM0tOZ3h5?=
 =?utf-8?B?ZmlYc2RiT3E2RDJ1aTBaQmwvMEhPZXUwNjBzV3ZlRHdlbnJHdjdwaFNaN0NW?=
 =?utf-8?B?eE5oc0Z5VnZySmRGTUJXQWc4VXp5T1VNaUQ4SzMwVEY4Q3F3VTcxNXJIbmR1?=
 =?utf-8?B?V242b0RZWHBnWnY2SmpUdU1ndkFRSHdDclBVM3RMTU9xUUJjVXk3WStWdjcv?=
 =?utf-8?B?U2dDb2w4b3lEK0RxMVhFMktqT2U0MEM1NDhjaEE5WHFVR21wN2dDVU1HeGJh?=
 =?utf-8?B?OEFZaCtJZWtlQmNKQUtHN1ozT1JJSGFpaXFKUTR6cGJVamdkKy8xTDUrYzNG?=
 =?utf-8?B?RFpIdXVaOXc5S0RpcHRtV3NuTC9Kam9YdmQxR0x5dUNkOWoyZXlFMWVRcTho?=
 =?utf-8?B?NnV6TnZidStQYUdxNjE3bVpQbjRrUENQTE9qdWJtbHR0TVRUaVZXelNCazJy?=
 =?utf-8?B?VVpNZWFDbkpOOXVrN1RlMm83bkdRRzg4N09Da1RlcFJZdU1HdTEycVRQMElZ?=
 =?utf-8?B?WXViWkdrRXdLUkFpS0FrdFZIeFlrY1hhR1laZmFIWTZwdDVCeU9MVDdCeWFv?=
 =?utf-8?B?cVUramhYTWhhbSttRzJFaS9yZ0ZWUnk2S3A1NkNPYlZGTkxwZ1ZGV2dyRE4v?=
 =?utf-8?B?bmo3Q1VvVHlrdmZNM2ZSMmNWUGgxdW82ZkliR3diMHhaRjZVZ0JqVWdoUE1a?=
 =?utf-8?Q?BlK/U0fQchrJumeRKVGjqBhS2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4HTlJ1scMBqi95+zk/xFuYSv84OAtLCeCfyeUxuDahDovttVVUCjEzN+ydVisZD/lpNyRxda5SiauS3s8a7CtjGFwgV5CiTHWu9JEofJhASq9vKuGMAJtVZdTgeKyX7I5oAoHuTjtoCzS9mWfRREI4oax9gFrp5AWsluc/bAaDNfcc0W1qLGARifWz8du14LMO4BOiZUXmTyt7GJqIhMFhNPUXUvO1ULkXyJH519i4E0CZepy6SHPTF1w7hOFdVldIOf5nYH5Pn4FHkFFo/O+QTroHvD59cA7IxnjFEEpL34SuSGeSht96X06jq8BQZit8V7iBq3IzdalwwRp0dzdSfYoMVzxJ2nVW0HLkRNyb+bZCMhMeKsyLcLOfLEnfAwMl6HAbaHOO7lnyXQq2amo0SJvUOIMteAlOER1qAZLMjgfZ4tVOKS55emd62CvRhWccUbViaYHelOrPVcuDg7sPAEbocMIMWb0xdkkRd9x5FOh/WYWKJqU2pSHFGpGZng2aXQxtfPJXOMReDDRLT1Ywpcp0ISshLUWY8GRuthW0AGGd4LxvcqkrL6tJk23KYdJUOs0TF602gMe3ouuwATAp8LkHA6NzBZlRsGELkIlPk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11f83e6-e9fd-494a-8996-08dd6dfa0ef1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 13:11:31.7482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: es8D3mXmw3zGnmHkCoW2STqcHnQgAXKF+zg3BrcJDsibFqBaptOAS3YXy1s2JwIna6Yvrxsip5FcinO+50O/tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_06,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503280091
X-Proofpoint-GUID: C82BoWi8HqdgYCf_-927ZeDcVP3HIoCO
X-Proofpoint-ORIG-GUID: C82BoWi8HqdgYCf_-927ZeDcVP3HIoCO

On 3/26/25 10:33 AM, Martin Wege wrote:
> On Tue, Feb 11, 2025 at 3:00 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 2/11/25 7:54 AM, Martin Wege wrote:
>>> Is there any up to date documentation for pNFS server support in the
>>> Linux 6.6 kernel?
>>
>> There isn't up-to-date documentation for NFSD's pNFS support. There are
>> various efforts going on to improve it, but as we are swamped with other
>> more pressing issues, there hasn't been good progress.
>>
>> pNFS block is supported, but it's not straightforward to set up.
>>
>> pNFS flexfiles is supported, but the implementation supports only the
>> case where the DS and MDS are the same server.
>>
>> NFSD does not implement the other layout types.
> 
> More questions:
> 1. Clarification, please:
> Which layout types are and are not supported:
> LAYOUT4_NFSV4_1_FILES
> LAYOUT4_OSD2_OBJECTS
> LAYOUT4_BLOCK_VOLUME

As I stated above, pNFS block is implemented. "Does not implement the
other layout types" means the NFSV4_1_FILES and OSD2_OBJECTS layout
types are not implemented.

The I/O protocols that pNFS block can use include SCSI, iSCSI, and NVMe.


> 2. Is Flexfiles also part of enum layouttype4, or something different?

Flexfiles is a layout type. It is described in RFC 8435

  https://datatracker.ietf.org/doc/html/rfc8435

NFSD's implementation is simplified and not for production use. It is
useful for testing client implementations of the flexfile layout type
and not much more at this time.


> 3. dCache supports pNFS MetaDataServer (MDS), and NFSv3 Data Servers
> (DS). Where is the spec for this?

This sounds like the flexfiles layout type to me. You will have to
confirm that with Tigran and his team.


> And why, WHY NFSv3 DS? Why not NFSv4.1 DS=

Supporting NFSv4.1 data servers is what the RFC 5661 NFSV4_1_FILES
layout type already does.

For more on the motivation behind flexfiles, consult RFC 8435. But
generally the reasons are:

- NFSv3 READ and WRITE continue to be lower latency than NFSv4

- There's still a lot of data in the world that lives on NFSv3-only
servers. Serving it in place is cheaper than migrating it.


-- 
Chuck Lever

