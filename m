Return-Path: <linux-nfs+bounces-14813-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6531FBAD368
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 16:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2BC18985AA
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 14:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3462522A1;
	Tue, 30 Sep 2025 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QggQ1Iqs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nwvSXRPr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9413303C9D
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243051; cv=fail; b=CrTTEvOzcXeF0okNDTFAR7HeK/qr7XfZ9nRUIeUjIrcnse9X5uJS+ZFXOrrlR8/yB/ZsD1F1yBMO19QL1VAKi33wFa0qx2dbaYMaBfcvBhbj+4oM6mxns0tG/83b6ruSSNqQuo7KH1I2p3CAeKypt8WAOCH4EMAAaEKkJzFq1/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243051; c=relaxed/simple;
	bh=K0Gv3bntcbIZoYtvR9HPYU9+IzvgtYciBQHC1fl0qXc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ii99bube2BD7xnP0pKS/U7naazOYvmVDz+QfntL2fD+0VkUX2RECAdofZCkL1bCw2j4j+y1DNMYTZApPOmXbXJVqOcfspIjby4V5f+17xK9kPXyz+SJ3F58RUpDQNzPu8OpqgeMwX+1Wt8TMLByUK5FqNveKJJ4NFu5xW5WD+as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QggQ1Iqs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nwvSXRPr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UDU3D4027549;
	Tue, 30 Sep 2025 14:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UkQMzcEjwT8wxkpd1nZAki6mUMd001lGjce4cPNRXyg=; b=
	QggQ1IqsWbrVBSqcF30s/SNSjotWLKBgLXHKRO3xVMjrOb+HeCYsZf+JZ5F5gTLi
	bFJsSuy9LK3hp2XoVLmEStXr65bX+nDPQQqMgJgX8vjSAE2ze77nbvmmdbnO5UPo
	ISVoXR9Nh2vUpdv0cBR7XLm5HAdTRRoYNm6QLxAWbZBx06ispx322mteETs+vyfR
	zKR0aPLg7MnQWFp38A5zHUvLo6Eu4Ja70ovud7HJEITM5wAfvNlKpuzGutijzmwh
	JtPEfSp5sGrnZV/qtEcN2Ontr868z1S+SnXksQEm1ioHCXxi0Lx1iiYdZM1nSn2k
	NeKflCpSoVJejkl+iiG66w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gg4r0613-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 14:37:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58UDFNhD027170;
	Tue, 30 Sep 2025 14:37:18 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c7wj0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 14:37:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qC+N9334EepYQGiaKuahOUrrlA3SbAMergb3P39Y9t3W1zVay8s8MIZvJQzI0PJr1vODpXNH0mCp0sn+/ZWU2urtRZU/Vb3HTI0mjAWfOEPTdmaJw6T8ES8j14RLL8vhpiIj32XEZfkSUgWoQVuhzBSjnrmDTL5IQJHkq2RizMgrX3nUDdqyjWQ2wUA5oy+jeTE3dihedwdSxWX/2U699odW+b1ExVe5UNfRa0TTZ8SiCKVTKznB4D8KJjK457OviSAEMcxkbzqA6vptQkdfJqCc7ubl0TuVWsqbT9GIHGBMXSR2tVR4N0yG8OKNwURHnF7btubmnBc/WeZys5CL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkQMzcEjwT8wxkpd1nZAki6mUMd001lGjce4cPNRXyg=;
 b=c02UQWCwXHpyrsdCJV5Yk+NHRUuVF9SA80mkTpPEJ0qFEYhmE3hh01LFA/tpSmwP51ffjrbkNZNsITTTq0rJrTGeQQGfscYZ7Va65JDoJeN32ADVWHIPN4nCMa9SxVVLH5s4MQikVjw0RMdqFrJv3yg8HyPQfzo2tpbaxxdB2ZLkVc2XE/BLCHKLcY95aatOgeOoI23ku9u6ItSFI60jbfKFxkqX02a1Ng4909lgNsy7O6sdFPv1MTSeo35njpy+BYqcQZUzMZAVrvqSJOOfehuHa7mpLJdOyGy1SOll75CeYR90SfXbaQ/jCRd2Hw7sq3KXDt3ERcl9i8tJUeW4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkQMzcEjwT8wxkpd1nZAki6mUMd001lGjce4cPNRXyg=;
 b=nwvSXRPrhuUkpBc5c1QhV8k8JEJkwHSlupUAzQnAuGkHHj+GWdc3zkGBAIcGxttnunel6iMhffw8i++W4gZ6M2m0Pr1ErbJYyQXtKkQpAVj1BP45kUcLacBWQpThi190sPsQRj5mLZ1PfLyLUoV0b8Pi1pRnnvNixMdCPHJz6iY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5601.namprd10.prod.outlook.com (2603:10b6:303:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 14:37:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 14:37:14 +0000
Message-ID: <b5b8835d-1c1d-4e3c-ba85-a7a2eb87b61b@oracle.com>
Date: Tue, 30 Sep 2025 10:37:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSv4: handle ERR_GRACE on delegation recalls
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
        Trond Myklebust <trondmy@kernel.org>, anna.schumaker@oracle.com,
        linux-nfs@vger.kernel.org
References: <20250811181848.99275-1-okorniev@redhat.com>
 <CAN-5tyEmf9HHMuXHDU86Y5FWYZz+ZYFKctmoLaCAB+DZ1zcXSQ@mail.gmail.com>
 <2b87402379d4c88545dabce30d2877722940f483.camel@kernel.org>
 <CACSpFtC3FbdGS6W6yKKwn+JcFmkSKE8yZRkQzuEWwRjAsZYkWQ@mail.gmail.com>
 <831f2ac457624092dcfadcf8b290fc65dc10e563.camel@kernel.org>
 <CACSpFtAqWdPPCbHLnXKGOmn7bR0fBjS9fj_J=i4aNnL+=8t1zA@mail.gmail.com>
 <CAN-5tyEY17k5SZ6hj2QsgW_006c-0ywS5H5vPvadj80bC0X=7w@mail.gmail.com>
 <f6ba4e9d-98df-46f2-b2fa-8ac832b8ce11@oracle.com>
 <CAN-5tyE+VgWxK6ZT0Ls-5cV53DVrSCBMyd2SLz3PfiC2Z=gyNw@mail.gmail.com>
 <CAN-5tyF+uB8p2NP-q-Z6vp9barr3L=vPYWaRSH5iAQk-VEHKDw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyF+uB8p2NP-q-Z6vp9barr3L=vPYWaRSH5iAQk-VEHKDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:610:20::42) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO6PR10MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ce72ea-f3e7-49f2-d8fd-08de002ed93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWZ4eHRsanRVRnVaZGtOV2R4bkpOZm9hNVlpNnphb0FTVHVoSXlncW1oTTlR?=
 =?utf-8?B?QVJZSExpSkJjT1NCTzJ1UCtjSHAwdjV0OVNiUUFQaElaQlUzNWZYcmpkU2ZV?=
 =?utf-8?B?QjgrTm1WaWprVWJsTGdlU3pGenJsQzNYaWNLVkVheUc3MG5GaWl6aWlObFJJ?=
 =?utf-8?B?WjlMVGhKc0NFamZONjdiUUROMGo2QldZbFR6VkVseGkwdXdCK1hNNFFldVE1?=
 =?utf-8?B?M0NiT0dFU1MyUkhoV1pWRjVHbHpQbDhoT1pydDJCYjEwaDBzcUZoQkhJc3cx?=
 =?utf-8?B?aTEwMlUwZmpPYndkRDFtOGlWNDFoa0tRUGU2WGRHVjVMMmo0ZzNFU2dRc3Bo?=
 =?utf-8?B?Q1BlWUowZ2xHVm9lS2tGUVA4UmdIcDN5eHZwSGdqd05ZeHVrQXdsQ2FGYW9x?=
 =?utf-8?B?LzZtMkdIeXlBRjc0SUdUeWxPY0I0SEF2MThpYVU4UVF5aVNNNnRGRXRPSkVM?=
 =?utf-8?B?Q3Z5aUc2WGFIVmVIeERtUDFlWHFVQjZ0K2toTmMwMCtuYlJLVUIwRmluOTJu?=
 =?utf-8?B?allJNmVvb2g3bzhQWUowaUxXVm9Tc3VEdVBWdE8xQm5qZXN2cVVnbWZ1eW9n?=
 =?utf-8?B?bEVSNkIyUnUxZTl2eHdpQ04ySlVWYU83UE1wcGptNDF2Q2lOb1dFUk4zS2Fu?=
 =?utf-8?B?bHJ5YjYydWlYUjZuRkdkdTZTa3B6T3Rua2lpY1Nad3dzWi9rQzZNeHEvaWYv?=
 =?utf-8?B?QktFNVZ1MGhPWHVpSUMvYVJYd1QwaWwzb1IwZFpIamZxd2FKSjFLeU1yWDRQ?=
 =?utf-8?B?ekFpWjl0Y2t2N3RDT2dYZ0Q2TXVlV1FQVzJ1YkptOUV3TXEwbWwvamZhU1Rm?=
 =?utf-8?B?SHFDWXRoTTNncjlubHBNSjhXaHZubG1MRHA4RjA3bjF5M3R0WVdVZGdOWHd6?=
 =?utf-8?B?czZ4SHgySzRSeXJmNTZlcmZtZks0aE5sek43MExaMlVmTzNpQ2VEMVBVM1Zu?=
 =?utf-8?B?R2hSemVnOSs1RTJ1c0EwbUZweDVHTWJ0R3hJWHlnRU9Jd1RYeEw4TWp3c0Fl?=
 =?utf-8?B?azZRM0JlRkh1ZXcrTllMUzNvc095cjZBQ3lVenM4Y0Iwc1psQ1FJVG11K2NM?=
 =?utf-8?B?K3dISGlLQkxCZzZxNFBmSVV2aTllclFmdStGZTBYYXZydXFWb3F1dENDdSsx?=
 =?utf-8?B?ekNuMUdzaVNsQVRjNmYrWGxGamZLTTRGZDlucisxYUM0YXhlN1NSVzdjb2Rj?=
 =?utf-8?B?MEVyRzh2M1U4cGVpOHhVdS9URnlTdlZnL1JOQ0JidU9IU0VqbmsvS0s2aCtB?=
 =?utf-8?B?bHYyejU0YXU2NXFGdEEzRjZsVzc0TWNNS2FERklScWF6UWVKaDlwem5MQ1NE?=
 =?utf-8?B?YlAvU2tlOFhxSi9lQURYNmozcUZUT0YyNTRkc1ZPWUN0eDBrbVlvZGFlbC8x?=
 =?utf-8?B?MWhKZXRVK3NUK1BiSXVJbWNaMEhHWTg2ZHdkVG5UeTZtSzY0eUc0OUFXMTdh?=
 =?utf-8?B?QmV4aVhLcFQ1cWt2ck00eG92Y2R0Zng1SVhjMW04c1RlVTRsbFp0aldnSXE1?=
 =?utf-8?B?RUlaSm5yNCtlSWROc1FRTHBwOGdGT3A4RFhGTytJMWdHZU9hdS9GNTNpdDJC?=
 =?utf-8?B?ZHgwTHFvY0JGT2tmcEg1TlpYTC80clBYODNCRTM4TFhHTUdCQWlxbU5KaEx2?=
 =?utf-8?B?cmFFSytJQ1d6d1pGemZLcmxxQzhzWWh2MFJwa0RzM0Y1YWJPRW9TR2N4eUNZ?=
 =?utf-8?B?aGtpaisrTzN0cWtmc25EanYxZlNJa1B1SGFGSlBpVXVxa0E2a3RvYXRmMEJS?=
 =?utf-8?B?cXZqUFpuWDVrR2RlRjlQZzViZjhKdGI5YWVIOVF5dEdkZ0pzQUQxekVuSnhy?=
 =?utf-8?B?VUxoWS9RZmNHTDQrWm5ZK21Gb3VtNVByZ2pkSUZZTTdHZUZGcURyVGljUmNN?=
 =?utf-8?B?K1JMWW5oZ2FOWk9RRzRjNG9ROHZLMlB6YWcxODl6WmYzZnpBZXM4dnk5VDhu?=
 =?utf-8?Q?3RmGJ2/iWByurru4ix5DgsacOSx6aNB1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjZLczRJVUJNNDJBcC9MYkVQYU1ZOGxGamFvVlZuTFcwNjEvb2NKUWNQY1pN?=
 =?utf-8?B?elVMK0M3cUtCL1VXTTZSRkhueHM3TzZKMGM1V3FWTTRlbGM4TTF3K0x2cHBW?=
 =?utf-8?B?NXN4UmlKVmR4UHBtVW1qZmxQcW5NVTBHeUg4T2JjL1hDMEYvQ2hKbjFRM3JI?=
 =?utf-8?B?UlprUmFFdXh3SlF2YUE3ZTJSYkloK1Rqem1WL2JSY1VpMGlFR2l0UzZ5SWd5?=
 =?utf-8?B?QlVZMGk1aDdEMExaQlhKRWhLeU5VS1BVTHRHN1oyS3hMaU5NenBlWVBvakxh?=
 =?utf-8?B?dGJUYVE4eTUxaFJSZ3ZCR2s4NVlvTmpxUGQrNkYyRU1vd3pYYWsrSkhqMWNF?=
 =?utf-8?B?QmxvdTVPQS9KYndhdmtXWU13YjNYYlE0K3ZuS09xSWdmRnJvazBlTHdadUF4?=
 =?utf-8?B?RW4wamwwWS93cUhpSXRnMy9xNTd3bWVSdVRHcTZzSXdFTXJoUloxdHlPLzM2?=
 =?utf-8?B?S1ljL280R1dNczA3T1VuVmtBNHFGTUgvbU9ITS9QNUpJVE82UWVCbjF3d3VE?=
 =?utf-8?B?ZG45V2hVL3YzU2FFWlVyVjJNa3hsWEFKaXZnS2w4c3J0M0RvaitURzB4ZHBm?=
 =?utf-8?B?NUdTMW9OWlJtLzBLVFlkZVRQZkxXRlNEeW1oQStaSjcxSHE3elkxUmNubmU5?=
 =?utf-8?B?ejlBcG5qZUl0cEFoek83LythbXFrYnBkcTVXVHptcmlEVHBISDFwcVN4MllS?=
 =?utf-8?B?M0czdXNmb3FmV25OUExBYVBOaHQxcUF3dXhGMHVTSkRLT1hUb2lNQW9OSG9M?=
 =?utf-8?B?TnU2RVI5dFppL2liT2dxUXFEUlZWU1JpT2N1dzBoa0x0UHJpNmhGa0Z0YWp1?=
 =?utf-8?B?czBFYk93RzI3L0F3RkJxVk10cFQ3NFBtS0lUb1hDUTFVNjU0RTJwUXgxcC9m?=
 =?utf-8?B?TjJ2cmxFbmx0K3l5dU5YQ1ZSYXJTMW1BYmRvV3VlNitDaERFZm1yYVp6TFNN?=
 =?utf-8?B?ZnpML0lPb0wzYTFEbW1DRnIvNzc5WXR2d1BaRkVNS1h6RzFPWWhhRzVmbUF1?=
 =?utf-8?B?a0d6OUR2cU5manhrRmZmSXBxT1lBLzJHQVBSSXl6ZFdOZk1GTjFsRWdUeThE?=
 =?utf-8?B?V1BqL3p3K1RRWUlDYjNoTFFpZ1NTSURUakNHVEtFZllJL0tlcE9JaldDQkw0?=
 =?utf-8?B?WC9EZTdCUUZZaUdSQ0R6RFg1bUtYYVM2K3FBOVlRTG96VmRKbVgraWhOT1U2?=
 =?utf-8?B?ZVJIdHo3SkRER0gzUUsya091NGZxUUwxbFhCWERweVFaeWJKNG5SUk5yUjYz?=
 =?utf-8?B?MUtsU2tPZzB1eXQzTlozUFJjbUZmZXJldEI2b0FsN2JaWmd2Z1k2K2ZaZ01K?=
 =?utf-8?B?SFlHUEJVeWpDZXZLK2x2cjZkTm85aStlZmlrelFia1NxcS9VSHFoZG91NWJt?=
 =?utf-8?B?dmRyNlZHV1Jyd1lwWnd4Y0VhK0djcS9ibHFYYWJKc21ubW9tS2xRSFpZMm5S?=
 =?utf-8?B?STlmUHg5Y2RPU2hKSHVHalFTcXZrK3lYeDQ1YnN2YUdtUDFNN25FNS9WRXhR?=
 =?utf-8?B?YjhaaWJGRUdpWjZPZFRUTTE2cUwzNDZNMFNwdzNZbG8wdDd2TGRzSzF2bzJI?=
 =?utf-8?B?aDlWemdjWnhBYVNacmUvRmYzWnM2elVZN0RNemY0Y2I2ZVlZaXpEQlFucFFu?=
 =?utf-8?B?L2V3KzQ4WG0wazQrNjBYT1ZOMEZBOVlWWTkwcUNsc2RvRTVMUDh0bENnSXFC?=
 =?utf-8?B?akhrSnVRcXF5UWFlSVEyUlc1U3M3TUZ1UVlPb21EcmYxT0drV1VCQ1lHK2c5?=
 =?utf-8?B?cjJseEVMT3JmVS9LUWFHSk9POThkUWRCTEh0dGdyM01ieHl4Y3I4WmYrcWQ2?=
 =?utf-8?B?Z3Y4aFh5aW1NTXUyS215WkR6aWxrL0NLVGM0N2h6SFlJTW1Nb3FVS3JSSG40?=
 =?utf-8?B?MFJhZlg4UWlNZkppWUFmTDVqNFNsWWRnZEMyYzRuM25zWnp0U1RlQ3l6ZFE1?=
 =?utf-8?B?alBQMkVOVFhCeGNReUlxVTRteUh2dGY3UDBqY3QyandGU1pBTHNKQk04bmVJ?=
 =?utf-8?B?Qm1NTkNrLy9hanJ0MThmeE9WVnVwK2RjeGRSaitUS3NOOTdHNlNpWEM3QkRS?=
 =?utf-8?B?YTJHM1FnNkJMQTJRYmV1Lzd5c041RTVFQnpjMDdUbEdHSEwxU1ZJWnA3NWFV?=
 =?utf-8?B?dElWWFR6Rm1JZ0R3RDVKLzRPcXJheThmZzFvUUwzZmVLa2U4SFdHRVMyUjVI?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ps28lkzsiTicv+jc5HBYwcINHW+nyXqbnzGW2rkDKYSWSFrs2BQvnboWVnkBHczsiwrW3ROuuXM+esR73mIAA3Pl3yKCn9GRdn4rBJPU3kt1j/hrbqjAzwhg1XM3yET0OtNTy6DhBDlcAuyFHt71kcHtbw/c8tNUWPzk9PJmQSSNk5HeQD22M6ZP6tPtUXJJJeX7brBPlMCSrmWOsP5/ahOqsmNgtgYeus2Jo8PZnI2BXdb5u3JX0YiBpQBivJZVC4X5heG9lEEHnCqTLN2HS+0jXEHLKF+CPEQLX6+RiWL9zV/zWWzXi55YiqI7ynaI1F/MyLea1AIuIiYMTHd1wL+9v+Px7Fs0C7oIctod53inBcHI/n7lPjCRe3HokpovyKVUYxrwpyk0k339UWiIC5NUB4c2kZPa8M4RvL4T1yHd08fZamgfGoiv1XUL4Z3gUkVlvQYPhOB1voytJAWHUqKf4BCa8U36nd8LlepPRPnkH9xIafVWBZFllUq3V8aujogJQppp3VyP3rAaTrQnlzjSjIMjShjWTAjB8hj1cM/tmb4T+cxx2hOmaOtLNIRRL7pDrfTDeUcST7NlRI2r6IUt3h4UYymOhALv57OaPHo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ce72ea-f3e7-49f2-d8fd-08de002ed93b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 14:37:14.7741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyTzTVketWrVeaWlfHyej6pI7m5JKJHomlOug9ZNQKzE/RnnCBHir+pShyDVZBowhjT+KIki7quPDwbTPMEMEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5601
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300130
X-Authority-Analysis: v=2.4 cv=Qbxrf8bv c=1 sm=1 tr=0 ts=68dbeb1f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=VwQbUJbxAAAA:8 a=ODMRXMzev6lF2SRTVfsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _drpqbY4kOapdza9sPqd5IGKU97wSPBF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDEyMCBTYWx0ZWRfX7Puj0d3HOe4H
 tL1tpZ24XZil6dGZUL4jMy2HBh+gN+gGYUvMFO5idAmlH1XRj50+6KPjEC7NvWdSRqWPrjmuRMC
 mHNKYzg/R0jR75rI+hfKS31WGkhTlcPUSjMUe9B+1vMjiqS/jiP4RZkeKnO+gjmi0q54lPZuJ/i
 5kc/I7Ld5P2FUA3Ebshekzo2YzXhXg4w/yTilyEYgES+fEoujRnUWzLSL38zIXsUK3l4imvN5tH
 iaTyVascM89+1V5mVn7m3/cJga6sqTANSxaqzZpemN10SqtaV4ixFbzBH4l4xSAMdIDypvfyh3J
 B2ufBo/Lsdfc8F3K9VuDYXH8OwGKWzmU/2y282QMcD4Xbz2er9HCfWuVvp8oQtIaNju40uRUbLt
 ecLy3hV3fCeEYKrHi32pN61tt/nWsw==
X-Proofpoint-ORIG-GUID: _drpqbY4kOapdza9sPqd5IGKU97wSPBF

On 9/30/25 10:32 AM, Olga Kornievskaia wrote:
> On Tue, Sep 30, 2025 at 10:29 AM Olga Kornievskaia <aglo@umich.edu> wrote:
>>
>> On Tue, Sep 30, 2025 at 10:02 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>
>>> On 9/29/25 1:49 PM, Olga Kornievskaia wrote:
>>>> On Fri, Sep 12, 2025 at 12:04 PM Olga Kornievskaia <okorniev@redhat.com> wrote:
>>>>>
>>>>> On Fri, Sep 12, 2025 at 11:11 AM Trond Myklebust <trondmy@kernel.org> wrote:
>>>>>>
>>>>>> On Fri, 2025-09-12 at 10:41 -0400, Olga Kornievskaia wrote:
>>>>>>> On Fri, Sep 12, 2025 at 10:29 AM Trond Myklebust <trondmy@kernel.org>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>> On Fri, 2025-09-12 at 10:21 -0400, Olga Kornievskaia wrote:
>>>>>>>>> Any comments on or objections to this patch? It does lead to
>>>>>>>>> possible
>>>>>>>>> data corruption.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Sorry, I think was travelling when you originally sent this patch.
>>>>>>>>
>>>>>>>>> On Mon, Aug 11, 2025 at 2:25 PM Olga Kornievskaia
>>>>>>>>> <okorniev@redhat.com> wrote:
>>>>>>>>>>
>>>>>>>>>> RFC7530 states that clients should be prepared for the return
>>>>>>>>>> of
>>>>>>>>>> NFS4ERR_GRACE errors for non-reclaim lock and I/O requests.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>>>>>>>> ---
>>>>>>>>>>  fs/nfs/nfs4proc.c | 4 ++--
>>>>>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>>>>>>>>> index 341740fa293d..fa9b81300604 100644
>>>>>>>>>> --- a/fs/nfs/nfs4proc.c
>>>>>>>>>> +++ b/fs/nfs/nfs4proc.c
>>>>>>>>>> @@ -7867,10 +7867,10 @@ int nfs4_lock_delegation_recall(struct
>>>>>>>>>> file_lock *fl, struct nfs4_state *state,
>>>>>>>>>>                 return err;
>>>>>>>>>>         do {
>>>>>>>>>>                 err = _nfs4_do_setlk(state, F_SETLK, fl,
>>>>>>>>>> NFS_LOCK_NEW);
>>>>>>>>>> -               if (err != -NFS4ERR_DELAY)
>>>>>>>>>> +               if (err != -NFS4ERR_DELAY && err != -
>>>>>>>>>> NFS4ERR_GRACE)
>>>>>>>>>>                         break;
>>>>>>>>>>                 ssleep(1);
>>>>>>>>>> -       } while (err == -NFS4ERR_DELAY);
>>>>>>>>>> +       } while (err == -NFS4ERR_DELAY || err == -
>>>>>>>>>> NFSERR_GRACE);
>>>>>>>>>>         return nfs4_handle_delegation_recall_error(server,
>>>>>>>>>> state,
>>>>>>>>>> stateid, fl, err);
>>>>>>>>>>  }
>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> 2.47.1
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>
>>>>>>>> Should the server be sending NFS4ERR_GRACE in this case, though?
>>>>>>>> The
>>>>>>>> client already holds a delegation, so it is clear that other
>>>>>>>> clients
>>>>>>>> cannot reclaim any locks that would conflict.
>>>>>>>>
>>>>>>>> ..or is the issue that this could happen before the client has a
>>>>>>>> chance
>>>>>>>> to reclaim the delegation after a reboot?
>>>>>>>
>>>>>> To answer my own question here: in that case the server would return
>>>>>> NFS4ERR_BAD_STATEID, and not NFS4ERR_GRACE.
>>>>>>
>>>>>>> The scenario was, v4 client had an open file and a lock and upon
>>>>>>> server reboot (during grace) sends the reclaim open, to which the
>>>>>>> server replies with a delegation. How a v3 client comes in and
>>>>>>> requests the same lock. The linux server at this point sends a
>>>>>>> delegation recall to v4 client, the client sends its local lock
>>>>>>> request and gets ERR_GRACE.
>>>>>>>
>>>>>>> And the spec explicitly notes as I mention in the commit comment that
>>>>>>> the client is supposed to handle ERR_GRACE for non-reclaim locks.
>>>>>>> Thus
>>>>>>> this patch.
>>>>>>>
>>>>>>
>>>>>> Sure, however the same spec also says (Section 9.6.2.):
>>>>>>
>>>>>>    If the server can reliably determine that granting a non-reclaim
>>>>>>    request will not conflict with reclamation of locks by other clients,
>>>>>>    the NFS4ERR_GRACE error does not have to be returned and the
>>>>>>    non-reclaim client request can be serviced.
>>>>>>
>>>>>> The server can definitely reliably determine that is the case here,
>>>>>> since it already granted the delegation to the client.
>>>>>
>>>>> I'll take your word for it as I'm not that versed in the server code.
>>>>> But it's an optimization and hard to argue that a server must do it
>>>>> and thus the client really should handle the case that actually
>>>>> happens in practice now?
>>>>>
>>>>>> I'm not saying that the client shouldn't also handle NFS4ERR_GRACE, but
>>>>>> I am stating that the server shouldn't really be putting us in this
>>>>>> situation in the first place.
>>>>>> I'm also saying that if we're going to handle NFS4ERR_GRACE, then we
>>>>>> also need to handle all the other possible errors under a reboot
>>>>>> scenario.
>>>>>
>>>>> I don't see how the "if" and "then" are combined. I think if there are
>>>>> other errors we don't handle in reclaim then we should but I don't see
>>>>> it's conditional on handling ERR_GRACE error.
>>>>
>>>> What's the path forward here?
>>>
>>> I saw something earlier in the thread that caught my eye.
>>>
>>> It looked like you said that, while NFSD is in grace, it allowed a
>>> client to acquire an NLM lock and that triggered the delegation recall.
>>> It seems to me that, because it was in grace, NFSD should not have
>>> allowed the creation of a new lock; it should have returned nlm_grace.
>>>
>>> Did I read that incorrectly?
>>
>> NFSD did not allow for the creation of a new lock.
>>
>> NFSD got a v3 lock request which triggered a delegation recall (while
>> in grace). nfsd v3 call (with the patch a082e4b4d08a "nfsd:
>> nfserr_jukebox in nlm_fopen should lead to a retry" no longer fails
>> the request) drops the reply forcing the client to retry. Please
>> recall that I was advocating for an additional fix where the server
>> goes a step further and returns nlm_lck_denied_grace_period but it was
>> not accepted. But that wouldn't have helped the current problem.
>>
>> Because the delegation is triggered, the client sends a reclaim lock
>> (but the client already sent a reclaim_complete, as it reclaimed the
>> open and gotten a delegation) so this is a "new" lock and the server
>> returns ERR_GRACE. Client does not handle this error and instead acts
>> like it got the lock and thus silent corruption.
>>
>> The proposed patch is to handle ERR_GRACE error while reclaiming
>> delegation state.
>>
> 
> To clarify there are 2 clients: v3 client (making a new lock request)
> and v4 client that holds a delegation (and a local lock).

I'm still confused about the procession of events. Namely, whether a
delegation recall was done while the server was still in grace.

Could you provide a ladder diagram showing the interactions, in steps?


-- 
Chuck Lever

