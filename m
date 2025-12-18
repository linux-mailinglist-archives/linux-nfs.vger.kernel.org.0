Return-Path: <linux-nfs+bounces-17186-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5037CCD6CE
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FBD430253FA
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 19:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB38430FF2B;
	Thu, 18 Dec 2025 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OdZc5mOt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fTtRSBgR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C833A6F5
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766086895; cv=fail; b=CW7lKklzV1DwV7MD4Ky3ZMLkQpIhCEWuiXtLjxQFnYmT5g7XoUJnLb7wGa/iYCXIWvLsvTR8/8FKpRbXgM3Cwj8av/00eN7a59z8fSvYwhTWqv/tXZT9k33WmwnnmvnmMAtm9iIIWY1M3f0IiPKQTUnRaALZsVb+RlvDW4C7jgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766086895; c=relaxed/simple;
	bh=laSmgJPFrJSVicPC2gzE20+iuOJUjzwkN8MMBApszOQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TnQ9ueFoOFtxU/fRAmxEYSFuPMhFDvuHLCY9egtw9JAXWcquh/K0mTEi73Hsq7owAcgYODTGiZ0PdXGIAPUyBJEp8cUY004qKlE66QZ4P+9fydx8oQrb+2sdsJvFIE5eMWPzXqFWIWZhiKJ8zKCsma+2QxnC2kJT1kz3Rds5u9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OdZc5mOt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fTtRSBgR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIJNL1N1972742;
	Thu, 18 Dec 2025 19:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=laSmgJPFrJSVicPC2gzE20+iuOJUjzwkN8MMBApszOQ=; b=
	OdZc5mOtJUH9D+dled1sZAjQvmllIebSNQgslwVm9oFI0YSfwr3YtAUWYFzR6hw5
	j7ibiF5I3FXI6bpprLwohzeP8Ulahidi6ubAty3jHAvIt5yy3K0Z7UmrNdYPaaES
	Axf25vnTA/pPuzjmxgEtxFH3IgfBbbwfSnOQzyFX1lodOSKLGYtwwWpoCxqRaz1q
	OTzYIBMASG7ojWAr3xunTx9CDw+SWobzFwWHgPliL05CHNiE10UJXcp28ofUdalz
	3MHx6/t/BkynSieRfWoH4eqqDzd+OxlxBcUSTUMKI7z+q4/K+6JH61rsKzm523xB
	N7Fx9/fanXv7wiVcvE4dMw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b47qpsbuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 19:41:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJTomh037053;
	Thu, 18 Dec 2025 19:41:12 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010029.outbound.protection.outlook.com [40.93.198.29])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qtkge8p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 19:41:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlX134m+t16XL9+Mf7mYdydiyRzmHTZh25Lfgr3JTKfFrJaP0hBCEONKlOo4sl8Kn4ynovRwKiAuBxgSf3MHuRdf8ADfwNdCbaTTlkBg67e6eOaJ5uNBIAwbSMBVS13xGGfRKkvGWBc4B8Y1hrvSuw5VJoa/0X7Rk6n1HiQrjO+KUdCBBVmASxfPVCmpU7ZPjuKWkl/NcZoMRSrmYnB6J1yf+iLARAmxmjKKNyZzQfI6appUH2EoP5kAZBIXs6cfA3P/i9wNOR6AQllJ4yvt67tLfnGnpg09hcP48Y5xVIqNIrJ29d6LlMX+RsK2apMeYUmSz8x7XxAdxzdOqPVpMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laSmgJPFrJSVicPC2gzE20+iuOJUjzwkN8MMBApszOQ=;
 b=Wjw7uGgOpSOsZPI+AU84ROoBSrTUbAva9IPl9olIatP+7SF9K8CKvuYg5lpCiOLD1KdcaE5zgZNaHGqqX62Xd8GS+Doqj58/gjQZk5Pu4KUqNwnNUJO5RzGDno0hRgC2vJEvf4RAZD60ufald32XxWvA1zVQKy2t54aHXW+3eUFicbZOMrWkYps2lyZXrC6JlgUczSvkdfx/JlHFTIUXVhB/bl40QeZ+hweC8/0OiK7UVMb5A0JVDUe9ylgv+Tuewc8EgND7TCwvJ5qugtcXjorB4gIhUhV26eytFp5+cMmZsCDxN+J9AIyH8OI5DvSDocIx6StbNOYLaXWi+S6NIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laSmgJPFrJSVicPC2gzE20+iuOJUjzwkN8MMBApszOQ=;
 b=fTtRSBgRWIvG2Z7Ha6xJjXOxOiCaQiQJPL3P/pPOsRmbsDhUujqAAIBPwIbisLRQOysLcWbzNor88aOyvfP3AgqxoSDHEmLqpEnBrDQtCzqJJ3zz6MD77Ruudjg/l7M1m+97Uo1Uyhs96KWYCfuBEe3HsrLwNEY1POR/TJA37bU=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by MN2PR10MB4192.namprd10.prod.outlook.com (2603:10b6:208:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 19:41:09 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 19:41:09 +0000
Message-ID: <6e61f602-5040-45fb-8829-9e82c03b9ad6@oracle.com>
Date: Thu, 18 Dec 2025 11:41:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] NFSD: Prevent redundant SCSI fencing operations
To: Christoph Hellwig <hch@lst.de>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, linux-nfs@vger.kernel.org
References: <20251215181418.2201035-1-dai.ngo@oracle.com>
 <20251215181418.2201035-4-dai.ngo@oracle.com> <20251218093458.GC9235@lst.de>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20251218093458.GC9235@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::15) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|MN2PR10MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea7e187-2b98-4663-6f50-08de3e6d645b
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bnVkL1p3YnZaaGxCWUlSOXdmZ0dad1BQN1VqUzBWZVMycUg1NGpXNFVWN1VZ?=
 =?utf-8?B?cEhVYUlOeHROM2trVzhnekF6RVdoMVlUNy9aVUJGaFE4cEVVeklRbjBjK2Yv?=
 =?utf-8?B?OHh1dE9XOUE1UjV2TXJRckZDRlFhbkV2R0NWRWFTVERjNmpFelVQVEJaMUhx?=
 =?utf-8?B?SThVZmFQSTlkODBFNTFsY20zWnJTb2pDL2VzVW0raFlaUzVvdjVjZENqUjhi?=
 =?utf-8?B?V2JZZDZZbGpucWpoS2x1ajVBaWdSMDA2VkxqMms0bXN4M3l5ZnVBU1k2MU5J?=
 =?utf-8?B?WGduRlE5ZlpZeGNpNFRmbGhJSHBDamxFMmdOell0WWtqMWlvRm13TDFWWk1y?=
 =?utf-8?B?MUFhbjBYcmRibEh5N2JkTDJzWWxOQ2pOWEhYd0RYMGgwblo1cC9qbDRJUHBx?=
 =?utf-8?B?TDlsaW9DNEpBUkY0S3Z5Q2xCKzN3SEpUajRzaVdpak5sNXRJbXJsK2JlZ0lH?=
 =?utf-8?B?d0d6NWNjT1hyemFEd1lEREV4QW5HbGdGa3R6ajhnVHZYSXNLWGRrYzhiM3JY?=
 =?utf-8?B?ZTBETFNMTU45M2xVU3FhKzA5ZWQ0VW1wVUY1cnB3MmhlK2JOYmtwNEllYVB5?=
 =?utf-8?B?cmVzem9TMGQ5eTNlTWlEY0loN2JwTklUdUVIUnlPcmJqRzk3NGhPbWs0eGoz?=
 =?utf-8?B?R0JDeDQzWkJMb0pXQWZjbzJTVmYrSEZiSm13MW5WOEFWVGlwVUd2aENSbGxC?=
 =?utf-8?B?K0xiYWlFR2lPRUloQzIvdEk4RjB2d1hYRWNsUlpJSVpla2I0VjliTDdHa2pm?=
 =?utf-8?B?RnNzb2toeTRqOVlsK2VDNEFEVTRyOGkvZ0d1WkpHY0tpck16aXJ2Wnp4bnE4?=
 =?utf-8?B?RXVvYVRrVFVIMmllb0pwT1R4TEQyS3VuQ2o3bWFQUW53ck1BUnJ3UUhTMnFL?=
 =?utf-8?B?cGxHQ1llU1o0NytnOHJaRVlucWhWTG9Ld2ErUEp0d0M0ZHFHbnBFTEluYzZQ?=
 =?utf-8?B?ZnJWNjRkS0ZqS2w5ZVhKS09ja1kwSFhpYXFmcjd5WkNuWko5d2xCaExzNnZo?=
 =?utf-8?B?Z1FSdHlCM1djQllGZGhLR1VVeXk1REdsYjNpT0NwNll5NUIzQlEwa2RtR0k2?=
 =?utf-8?B?RkRtemhIWDFnbnlDbXUyc2ZrT2wwQXUzSlRKWm5xSFJLajloM3IwTlF4OFBG?=
 =?utf-8?B?bDMvSXhldUdpTFhxZW9NQ1lyd0xwUXc0aUR4c0dBVWFxUE5DVWZRWWNIVWdQ?=
 =?utf-8?B?YXhYczY0ckZOb2RSNit5WFpRNm5udk9Ra3hJUk5DR1llZVdLNHlsWXpxQUll?=
 =?utf-8?B?N2p0Z1BwUHZ0K1pRNy9wanhZd1RWRTIrQVhqV2JuZUtuSWhSd1ZNalhjbXN3?=
 =?utf-8?B?UEJYYTMwdmJDUWk0ZGxLd1lhOHUzTE9jYkRCMTBBUk5zVlp2T0NHYUV0aTZX?=
 =?utf-8?B?bjhqdGw2TkRKOUFXL2lEbm9PZzlTdnBQTEh5QUR1MmszVGxQbWNpcE5WOE9x?=
 =?utf-8?B?SmFiS3M5QkZLNmI5UWY1TXRYNlAvelBWdS80YkJnN3ZxRmNNdWU2bW1NZklG?=
 =?utf-8?B?MGtXOFZ1N0U3MmVnV3J2VEhEVjBPeTNjdEM3K1VsK3FiaStrcmREaTA0eGgr?=
 =?utf-8?B?WStFcVpDVFV1akZQMk1Db0JVV3J6MVB0WE00OVVtMGVYdlBMY1Fib1lDN0pN?=
 =?utf-8?B?MUo1SWdSd0FZZ2FuVXZZNHkwMGhnWlZNOFlDempUSEF4SjBRcjJESnFVMVlG?=
 =?utf-8?B?YURqVW55ckw0TnBkRElVczdtdU90YmF3elVNS3F3UGJtZUNMcktjOTIyVmRj?=
 =?utf-8?B?c2xZdlhUcHdUU2VzdU9OMm5jL2djYlU1ZWdmSG9vemg1V3pyazhIMW52M1lQ?=
 =?utf-8?B?YXdmNEE4KzJDTUNDVGNnYjl0U0lPSzBYdy8yZXhMdStrODU1QkJ6UjE2MTMy?=
 =?utf-8?B?Tjhid3d3TTVtSGxjdWYxNk5URE51SmJVV1gwTWhKUXZMRkt2bDJaY2V6SHZp?=
 =?utf-8?Q?hz9I78l/eMTt5v9HkB7j8ge5N75MmmEF?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?blA2N29ua1RES0wxZUhkdEZ3VlFTbW5tVFhTZWduYUVPd1hUd1BaWWlBb1Ru?=
 =?utf-8?B?OHY4VWpoK2pEMElLZ1RVazMrbzFBVE1aQkxFbjdrai9tYlVDRXRja256bnVs?=
 =?utf-8?B?SWRXSmJmTHRaRmw3QTBsMHlEMjloSzNXc2crWnNrWEh0bERkUWphV3JFdFhC?=
 =?utf-8?B?SlNMck1ZenliY0tlUDNPWkZLWS9uaG1iUjFKU0dhQUZNR1FOK3pPRHVsSUZH?=
 =?utf-8?B?Mnp5YmtoV29ZNGJUM3NFNWw5dGtkejlHSm90R0RzblJGNHhQSTNCc3ZwV1k1?=
 =?utf-8?B?b0NDUHY0RzZqNUwybzBscGVqQlJmYWV4dVhrS25LdnhqeHQ4YUNQYUpqdkFp?=
 =?utf-8?B?K0tiZmRmSTRhSjJ1dlNyYzJqS2RLUi90cG5YWjFPdi9zNlZFUlhCY0gvUWFO?=
 =?utf-8?B?eWNjVFZiOS9IOEFWS1ZySUtpcjlBMmJBaXpFdzVwbnNkUE55b1VHSmtpeEtt?=
 =?utf-8?B?eld0YkF0UGViWW9KdGFHOEJTeGlrQ253T0xNWjFvOTUvMkpIUXBoRTJEQUdN?=
 =?utf-8?B?QXVOdWoxUnAvdEpLeGNKOFJ6eXd6YjhhMEZjTk94dnFKTFBPM0FscTBoMmh0?=
 =?utf-8?B?Nm1nUDJuRjVxNC9jTnF0TVBZK1VoeXlOYkpWTkU2ay9PRGtpby9JM3YwS1hi?=
 =?utf-8?B?NnlqVHN2SVNwcXIrYmtibE1jMkxYZnRJaFQvR2FQTGRNMUtJRWN3cStRUWx3?=
 =?utf-8?B?YTZab0I0aEwwbTlPcnVtUjR1Ym95NGNxTGlVWE1ZbFJRcDkxcm8vUTVydmgx?=
 =?utf-8?B?dDNGd3lTRGVWOUpnQ09mWEx5cUFRQ2QySXJVM1F2V1Z2c21VeGhucDUzMzhM?=
 =?utf-8?B?endaNTdkMHV4YSt2VEhnYWNydmdLVzBYNDg1M1BHOXJuVDd4UTJ6UkNVb043?=
 =?utf-8?B?eEY2U2N2VGhOOGQreThlRG9mZG55UElvN3VmNGx3Q3ZaNHh2ZG93ZENnS05m?=
 =?utf-8?B?WkNhbjBtTHJjalppZWNPUFpzMkZ2bmNLNUc0Y01OSC9SbitqeWdpb2dBOWpJ?=
 =?utf-8?B?VlVBeVAxT3ZTTFNrak1SMWlSbHc4WHgxY3BGWCtUMGdvdGFhMjJ4aHRxT0Q4?=
 =?utf-8?B?aU11T0tXUUxZL3hrcUVJQlpRZTNjTGFqWnE4ckd3NHd6SHRwQ2lqTlR4OVd4?=
 =?utf-8?B?dUNUeWM0YjRGN2ozZWYrMFBaRThGS3ZwSWZnRFJKVFhIcEQwYlFqeE1MZUEy?=
 =?utf-8?B?TWUwNGFSWWFyOFc4UEJaOGRJdDNvUWdzTjZaSldOU05DcmRpd3d6UTVrZlgx?=
 =?utf-8?B?eW5BSkxRdUZ2OGplVkZ6Ui9jNkFBWWwwcStYR1ZhV3plMURJUWVUNGpUaEo0?=
 =?utf-8?B?SVpSSzdmazB5dnZacUpoYTBjYWdOZmsra2pRNEhHemt5SW5tRThiSldJTWhL?=
 =?utf-8?B?YTQ2SFJ5bUd0cE1SbDBNQUJGOVRycGFVeE1UNnJJYnhqQVpibkVlWEtzU0xJ?=
 =?utf-8?B?MEhNbWlRNkxBVldwRW4xdkhpKzVUSlMveExyd1h0Unh2eTd1bHpkYks1RzZM?=
 =?utf-8?B?RlA1R2pHYlJhSGFSekxIUHBuMnExVU5Gc0R5dmxUSU43SmJlQ0hiUXNvb2Qv?=
 =?utf-8?B?S1pWOFE1UnI1eXBCL1ZRd24xNlE2YmRHcDVIL1g0Z2lxZUZEenNKU3p3bndQ?=
 =?utf-8?B?WDlUa1pvTENFM1QzOXR3OVFnb2NNbEpCdERWQUxtWW5Ibng1MHRMTFJtcEFq?=
 =?utf-8?B?ZWxPYmtLSDVJVUMxd3N1b2hLNkxzc3pLZDNERXpvUEhDaVFoaXo2TzZ3YXlQ?=
 =?utf-8?B?bXBRV1lFTnRPVDM5RWZDeDd5SHFDMU1lVm1HaENIN3RIL01XeDE1STZtRU9S?=
 =?utf-8?B?eG5uNVppYlVmamUxNWFNRlBsM3cwQWd2ZkRYbHptY0RpRjlLREFETmpML1Bn?=
 =?utf-8?B?azYzTGNrRW5uQWhpZEtSZ01LQjJGVXlGUjZWR1Urd3RHM2RRbWtMRktVbVhY?=
 =?utf-8?B?UThjdCtUdHZ0S0d0d2pHOUZ4MlM5amtJMUMzZzYyNWpXYUpTK2VaNjBtNEZs?=
 =?utf-8?B?cnc1U2xkb2FQQ2FFcW9uUWx5ZHB6Z3RzUUZsT1N1Y08wNHlSTWlxYzJIUDNk?=
 =?utf-8?B?NTJHdkY5WE1hY3RScmNDMUZMd1NFNjVqNnlTZzFocXBqQ3NoYUZwYTJOSm83?=
 =?utf-8?Q?SeljWxOKWrxIjZh0/7dFLfMyB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4tM0XE+2Tum7Hk/FdCdqeuYzlSB8mPXcZwOvXpgB5MBGkoQFcDwhodeuqzU7lVTkEEQ+SygLFfNg05OXN/5Oha4MHFMSAdPWjuGApK5cF5qp3EmLNDOm+UL4JK+DuFkooGRzNVThzRFLfRkUbxYDr8RgKNlmXZCZa5iQwEVRKZ1RBNTCvRZKzIm9OKrmir0Y+k6k4TyERk5vKH8Cr1wWb1HKE8Lf01/NWnrI3uGAps+aQkXbIsYE9RUnfSZFwVXeCIOmBel8ZVfjqMkjiHQqImXb0Z7zsUkpEugi0pCsfrImy6hSSRJ30H5+/F5e0SaPLh8H6YeP9aLhU9mY7VT6bIWBWpRFF2Q/LTYQHGA6k8LKj5t9+Ce41zKQK0pVxekDD4W2dtpHMLl5jA5YjPndK+BPBbrcDsVYbmW/6RIlj/HqtB+z6UuHwM0vFHbOuzViwjD2+jKA2aZfLQ8y1BKDYWyFo/ir3b3gQRZ/K8kHsfCN5HPKqLGJo4ozGBY1wQwfoPN5xCP3m8DJn4hR3rVUcT2hKHMaH9wHnRoB6B76ilDWEcyuvFyMP1rWD5H2ztAyv+cfwqp6FEVKBdlQj7pbJYZZvbcUKz9bwKde59UCxTo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea7e187-2b98-4663-6f50-08de3e6d645b
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 19:41:09.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qK4VfHY1rpsfhsUI4C9aAnEVcTQ371KanRTJZ/q7ogkz0ZbB3fyFbbEHbup0hblV3Kl5PiGrlIMynO2kDuy7ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=799 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512180163
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDE2MyBTYWx0ZWRfX6kYhD/xbeEEh
 6Pc2INCFvSrbzmN9YX2nsSwZxbToyjXDoUvOoIBciVUkV9l4LdFAzSdTDU/nbCfA85i/hAHBhIi
 HgWr3SS5PRSvJFQAJWe3tnTTUHLlQ+B+zI2j2liUABOihxf8GDQt4zac9djyoLNZiIW8k1zj16H
 NWb1tRZQX1OZb5WIbpl1Y3SAMDrcoy8xIikjWE4RZscRNcJW/BkMPibHFYt/H0DKZH2kD40RZFo
 9Yf/oH8CDZLjpCKk0n2bJCvHEEnzsjUraYeYKLWxHAkwAGgynHP4gRqQcJqw4N1IIb6F5RP0rGH
 3eR53EluOVDlTDvkDeDNuIXCwkYrbkVQLdi19vFN8FfQZuq6B4CHpDuQ0tPnWHpL12hGHSNiGow
 iMtkuVMxLb5UkraHBzLzBUeDwXajClKnJJiOX8Ftu9bYjesDYk0=
X-Proofpoint-GUID: Wi5dvGy_Pa5muwmn0eSxZKDajeyU5wJ1
X-Authority-Analysis: v=2.4 cv=ePkeTXp1 c=1 sm=1 tr=0 ts=694458da b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Kd01QJ8ec_IageESwV4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: Wi5dvGy_Pa5muwmn0eSxZKDajeyU5wJ1


On 12/18/25 1:34 AM, Christoph Hellwig wrote:
> This should probably be kept with the previous patch it is closely
> related.

will do.

-Dai


