Return-Path: <linux-nfs+bounces-11132-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C3CA88CB8
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Apr 2025 22:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7E03B32D2
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Apr 2025 20:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34421DDA2D;
	Mon, 14 Apr 2025 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZS9uO/mD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ICuGiFy3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE72D1D79A0;
	Mon, 14 Apr 2025 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661364; cv=fail; b=tF24utntKlDUs7/cc10QfZxF1KQ/kjxwqExuxey/PJsr+yKMMiMbXCjHOd+RO1VK8At+2IweGwFWM5l23lLaXYuE9BYnMEdK+H7bSYR/vD0tVWezA+R3j42KqfCpq5GfZlUMfwxBmN3BYbFsQBw2dCnRI25J/iGvxcNQ6pXJMCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661364; c=relaxed/simple;
	bh=2iiYmOJSgdt9d0B152aKLohempJPw7QYMBXu0tXymFA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pTls+TCJ5l+VkWei7vkubpAA8qUVBG/7izm82qzee1yq68zMv3E5cqARCA4jmYK5jLvrT6zutLkqBslWHyxu8usyxZz03fKNrQ0GCcaQ8vLWss4++bbCw0Lngn6hh6ThaE9nVxzs3wArEoQRVe5pFeFb867QUgHBEt7yjtvKdUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZS9uO/mD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ICuGiFy3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EIq13u019839;
	Mon, 14 Apr 2025 20:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wRlWkgJ+X1ha/theRxJp+XzSYhtr3HaOVXOxsQaUhRM=; b=
	ZS9uO/mDItXX45QO6yODfsmoF6KvxQheXloPoz0PLYv0EifXGPu7+IMD/DC82ZBP
	wDKpnGXApJI7OEW5opHcmOEmsMgkV9GzPAjBhLXrVaU/XglFm10BwCpqj5CA6x3Z
	fmoA4NW9hBAkVdZMjeQcx6AUzEsBQK8ETXYT1GYA581QwshR7J/gPFPkaKNSId2I
	GsyWIZud1YM22silYvTw44Bw4zXhXKa4VjGNVX5iovZCPuadnPzMBv+Rxs1Jxs/0
	cEyAyHc1xow6jBfNG02FZKWpjJTE77Co0+sYDYaRi6nywC1KhA3raeAgpgLBRjhw
	c86I0OsQkpQSHzQMsiPyng==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46180w85j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 20:09:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53EJOJsG031119;
	Mon, 14 Apr 2025 20:09:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460db9gmxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 20:09:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8fdrgeGOqc3YNJg4U1bEhCjk+zCW9eThQi36SdB//zRBxJDLMzpKchhnLIj6rV7LS2i6IkEORJTWEXae28Gyw2fDl8Szdy9pE9qzgFlencVzLuQR8qz+0AGcxuOX2WP05Ty0tSuMEgTZ7dISho/g5JSX20S3otkMh24LVL6fGKvpRnuKJn/KZrigbRiLaF9K7NYZP6hE2uvSgI7QplMRYpLh+SY9inQxIrHmhKu8dgqt/qOheHUABSvlnFpW/yThwAQ0tp32g8t8V38jxBtL+FK1sdTTIS/J7R8CXHUCdZ5x2tmjgx+9pEZ4wn3eLgzqTE1BOV+YQ7gnpSpHsO1FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRlWkgJ+X1ha/theRxJp+XzSYhtr3HaOVXOxsQaUhRM=;
 b=hz6lkQs/5wl1PkzqveTuMElw+ZJLFrDplSaLjOVhyY6DQ2YdrASsntSqlYL7o6hjeJd4RtL6ekC7Bi6emVJDczeouHDamk1ebQsib8iG5y7s3rhrPsrSJB2rD6OftkRxTmRZ4jJcRkUG1/OAdhjIILIkmLciAkxv4TO6qsBY+OnUD3nxom6pHx9bRLdhy64Qlm/Ic4HEF2rWh9E2EsWH+Zzc0vJ80joi7ue2FDPp01zY1Wc7HDGOczS2vUbk6tztvuSRfeYvB1mOi1CdqHiXgZBBXP+TocL0X3zxPrRp21nZELte+4Y1acgJlPlTd1CtPYSAYilaNgctAblRHB/CNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRlWkgJ+X1ha/theRxJp+XzSYhtr3HaOVXOxsQaUhRM=;
 b=ICuGiFy3N6E24uMAFbpU2JEw+r18NxokPbIxVlrmpgTxKiLLnwhhOocFXO+n14XLQduV1Zy8Wms6uFqqm9e9EbibgjsWVYbn4c6ABrK1HWMrQ9gbBx9o9ipCjWmiYadQrNxxu8MZclU/NBJ6pqKZpBHGcMAQdT2itXfvALRgVZ4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA4PR10MB8424.namprd10.prod.outlook.com (2603:10b6:208:56d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Mon, 14 Apr
 2025 20:09:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 20:09:06 +0000
Message-ID: <8cf7d044-bedd-4516-957f-309f93b95f5a@oracle.com>
Date: Mon, 14 Apr 2025 16:08:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: NFS/SELinux regression caused by commit fc2a169c56de ("sunrpc:
 clean cache_detail immediately when flush is written frequently")
To: Ondrej Mosnacek <omosnace@redhat.com>,
        Li Lingfeng <lilingfeng3@huawei.com>
Cc: SElinux list <selinux@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <CAFqZXNtqPBMGUL8kvYoW2VzdrmcY1cx1+NL+LmOs0oxjfG5csA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAFqZXNtqPBMGUL8kvYoW2VzdrmcY1cx1+NL+LmOs0oxjfG5csA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0303.namprd03.prod.outlook.com
 (2603:10b6:610:118::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA4PR10MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: b394023d-0249-4d00-3c2b-08dd7b903563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXByc0hlNDRtblNKSmFnVS8wdGQ5UUdWY1hIODV6L1V5VjJXdjN5UVB5Qmty?=
 =?utf-8?B?eUlSbE9wRGJSeXpqbnZVRFNaaEJsNVhtK3V2K2c1cHQzM0xnWFp3alVja2NP?=
 =?utf-8?B?QW1MVmlWc2F3Z1AwOGxMQ3ovUTFYeU5TOXZVRGI1REUwTjZrOUpFQlRXaS90?=
 =?utf-8?B?UXZidUlMNzJ5UG5HZkRqSnpUVVcwdERjZU5icHhwZ0NHOTVJTVdkNmFlRUdG?=
 =?utf-8?B?NlhEUXNLOXk3VGY4eXdwQVh1UEcrM2ZSWG5WT041a2NrZC9sOE0rc0h6NGlq?=
 =?utf-8?B?NVBRNEM1bWFOYVZJTUoxaXY3cTlmb3N2RU43Qk9UWXJneEh3MWVDakc3cFZY?=
 =?utf-8?B?TjE4L2xWblFMV3BpdHVqK1RBMDZ1K3M0dlRZM2prVWJHV3pVZFRWSmRwNWt4?=
 =?utf-8?B?UnR5dHFjSEpqMko1U3BlYnFoZFo0eWdNNmdvQmxNSDdwekxtMnFyWVoyL2dN?=
 =?utf-8?B?ZGwrWEpHR1JpOGZYUVUzREVuWG91SUZScUFiWjFIZTg4RFFPOFdrVHdmeFVL?=
 =?utf-8?B?QkVCc2Z2RHJ4bHVvVmNuVGNmUVp0SHFVL0VEZU54ZmVtOGRUYjZnelplNjRB?=
 =?utf-8?B?NFRDelJJdmMvMzZXNWYzbU5SWk4xSjZSMjBnaks2WDdDb3NYN3FscWpQOVFn?=
 =?utf-8?B?d2Z5ZytZcnE3d1FsMTRkMWFkakVvU3Z4V0dRcnVKKzlkUUFDekhQNit6Tm5S?=
 =?utf-8?B?NE14ZGM4SEp6dXR5bTViai92eW9qaU5rZ2x3S3ErM1VmYmQ1WEdhVlgxc3k5?=
 =?utf-8?B?eTladm55eTkyOTZVbDJodmZ4cGU3SGdqRjlsMGxITUJ3Zi9PUkpkUXhMQ3gv?=
 =?utf-8?B?V2hhNDMvQ3YxbHliSWhtL2l1MVY0UWhicnhkMGp1TXVta3BSSWxBcERVYzBK?=
 =?utf-8?B?dHJpTVBqRE8yOGRDZldQREdKWHRJNW00T0ttbHhadThlRVBKdWsyMGk4d25J?=
 =?utf-8?B?cHJLdWl1MGFSZ2s0MHN3TWRGT0FrbXNMS05NOGNFbDdOSG9SVmpDYXgxU0JN?=
 =?utf-8?B?VVc3aElkc0Z1N1l0TTJOWXdiRktEbmVvbW4rS2xURTdNa0ZkZk84czljVWgx?=
 =?utf-8?B?bGJycUJXWFVsM0RtaVZqM2JpQ25zM1ppbTNmRDR6dHp1LzAzWkVEK0dyWi90?=
 =?utf-8?B?V1BKRUxEU3lYOFhUa1JGWXE5ZmtvR2ZvK0REU2JGTW1rMmlCNnhGYnREWURJ?=
 =?utf-8?B?NktxR2dLb3ptQXAzM1VZMjk5czVRWjNSa0ZFaG1vZFE1MkwyZHd2cDlZeU5z?=
 =?utf-8?B?eWt4ZW9KQTBLT1VQYnh6WWZZMGRXdmRWc3RnTE1QTzNDa0lJU3dSOHJFWVRZ?=
 =?utf-8?B?QXN6RFd6VFZTQUF5U2Q0Z1VoNCtJbHlIdk40Kys4M21Qb3AyeWprUVQwaVhG?=
 =?utf-8?B?eFhpaUk1OEZQTTkwMHlockdBdnpGT3lLUndrVjNURURPOWZWMjZubWtXSity?=
 =?utf-8?B?YmZ1ZENVbUxGeUdZYWFlemIyVURnMzFzZVN5NGdDK0h5bHl0RnZzQ2JUb0Ev?=
 =?utf-8?B?bHZjR25NdVNHRVpDeTlMQnpyZ3IrVDNQSTRNRWJRelYvYTlPUG5jRWNQZ3FX?=
 =?utf-8?B?aGhPdDdnd1A0VHpRSGZwdFFEMEZTemQ5dXF5Q3UxVlYxdXVOOFpZVWd5aUlU?=
 =?utf-8?B?SHQxWnVtRHZEdlkvb0h0RDY4V210V294Z0IvZVFuQ0NvWUVVRDZmSXVDT0gr?=
 =?utf-8?B?NUVGZEVrUUhyL01WWVBnamIwSFdrbHRmbXVEc1U2S3lBdjk0TzJSNmVFbVl4?=
 =?utf-8?B?RWdLaUNNNnhZWE9MeVp4cHB3elpteTVESkFzM2piL2JqRHAzWFJpdHJaRGlK?=
 =?utf-8?B?OXRiaTdnODZzRnNhbVl0MEliYk5IcjNDcVFtU0dqMy8wVWZjVVUyL01HSkFO?=
 =?utf-8?B?Z2hpS0twZUQzcFR3WUwxTTA4Uk9zWUhTL254VUJPcUVuRHdJQm4wMHh6UnQ4?=
 =?utf-8?Q?nWdwgqPyIA4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkYvb1p5ZUJkL3ArYVRLTFc3ZFpKSWpJZWI0TzZXN29ya00xWVdoTnhiZHV1?=
 =?utf-8?B?cVhZejl3NU1Gb1EzRTFNZDZLemI5YWdNakxKSkNnSWd5TmVjYzd1Wm1xYUlr?=
 =?utf-8?B?VWpuL0VoWkE2Nkc1VWhFWUIrWXI0VnRLdXRDQXRPcDh4aEcvVW9DZnVtKzZq?=
 =?utf-8?B?UVM0ckpOSEpyNU1obDgyTFZLWUdPVkphL1ZHZnBnckNwSWFHRnkvTU5LU3gz?=
 =?utf-8?B?cFdrTWdYZUVpaUFSVC9kbW5lYUhFaFViNXIzUVZ5T3FTZSsxa00vUXY3VUMr?=
 =?utf-8?B?dDQ2eHlEbVF5SnJhT2pZeVBlcE93VnJabUNiVUd1MnFYU1psdmtKRkZmNEtG?=
 =?utf-8?B?aTZUY1hRVnF2cC9uUFNTYnlTaDN4ZUI4VHNNNTlvUHJrTUJSc08wU3FaUmM2?=
 =?utf-8?B?d1lHOU9jbmhrYkhCWjB2OXJLSi9PbTR3TEczaHFaVGdDdFpqVVdNMW5sZjhz?=
 =?utf-8?B?RVFaRUM5MlVnRUlOdUVQc0U3WmZDQ2g3c01aWVNKSnluU3JDS01RZXoxcnZZ?=
 =?utf-8?B?eUR3SHhXZFB6NzNVa2Nmc2NkTGZwS045T215Sk9VODh1ZVl0dGx1OHZtNlpE?=
 =?utf-8?B?U2p5TkhmNklaRU14QWZQR0hIYUs0a3BFU1gwVGU3YkhrUmw0UTRsZ0lCTXBM?=
 =?utf-8?B?WCttbEU5b2Q1STRuTVhIVjRQQzBnWXMraCsxdm8wNEZPeFBYVlM1aVg4Y0xj?=
 =?utf-8?B?OEFIT09tUFA5T0c2R2YwbWxiR21kOFRPbEVGOXNhNXFwWENjTlJkVU83Nkdv?=
 =?utf-8?B?bVg0Rk9HL1Urd3FRa2pNQkZERXYvb2pPeCt2eTZZY211cUV4SitjZ0t2SFRF?=
 =?utf-8?B?Q294TVhKM0pRaXdqVDhkT2NYWFhTbVZabHJ4VmNoTXFmWlUxUTVBb0d5WmhM?=
 =?utf-8?B?ZnhrTG9obU5vQkp0WmtlVTlTYmxVQVJyS3lUUHhMVUZCMW8xdElCN0ZvdXlS?=
 =?utf-8?B?WEdoeGk0REk4azBFLzJ2TWVlMHVtWTJSQU1uMldHZ2kvbC8xYmVQR0kwbng2?=
 =?utf-8?B?TmQ2c1BnbDZNOXdyWVNWc1JBZ012VS9LU1UvUXZraFIyNUM3VEVwRHF6R1dX?=
 =?utf-8?B?WC93bFJXOFBaRmpMQlhOaGJpUmd4MnFwYnhOdmFaQXg5TWlNYXRXMVVFd1FM?=
 =?utf-8?B?VVlzVjBrWXZSbDN5TjZRck5yeVVUTFpVc0ZTTTk2SjhSTis4eUtDaDNIMjVq?=
 =?utf-8?B?TDB3aXFQV2tTOUpiRTR2N3hZRVpPRm5LQXFDNTJHODJWbURUTnFHTzdnUkUx?=
 =?utf-8?B?cUZ3c3l6ckt3SzVra0ZnczJFYzYyYkVwZzY2Y0llM1dscTJ5cGJKR3dOK0Vv?=
 =?utf-8?B?RFg2VVVyejdweEV1YVFJdnZPcmF5NkM0QzF6TlhCV0F2bVhvcVNTbkxvYzB1?=
 =?utf-8?B?RFBuT2VpdzlMYXFRaWxqNjRrRXNBYW1GS0xxL08xSkJVVk11N3p5bmVwUU1s?=
 =?utf-8?B?Z0xlakpDMmlZQmkrUXltaUxERVgwOHM4YkJhZm43bWZVM3F2Umh3NFZMdi9p?=
 =?utf-8?B?OWt5Z3MycUc1alU0UnhrV0xzMlQ2cHNwQ2tvbzZuVFNIWURnVGlFSXREaWlD?=
 =?utf-8?B?dEFOTEhSUitENTk4ZGpUZDBTYkRsbDJHTU8vT3JVUURycjdaT2tCZ0MwZm9u?=
 =?utf-8?B?eE1XbXdSeTVWcGRkQkVIQUdqUXkvVGJQdnhCckRQS3dWNnJoLy9WSkpLeDls?=
 =?utf-8?B?eW1DNWtVK2NEcDdMY252QXhtT2JaczRFaGMwRTBQU2pFcmRUK2Y2SGpYRTM2?=
 =?utf-8?B?VnZERlF5UVE5bW1CSGFSbVE2YXlBUjU2ek9rVnE2YnVVd1ljcm1NRGg0VnhF?=
 =?utf-8?B?N0U3RG5RMEl2Y1J0UWN1YUwwb0l5M21XazZ0aC9Nc0NZZ2xrZ1BjOENkQmpB?=
 =?utf-8?B?RE9URFlvQ0tHVSs5RXg1MVREUWRJTmZVWDloVG5xTXJRQkRpS1dKR1Q0U3BX?=
 =?utf-8?B?dzd4SXM5NDBRZHZMWmFLZEJUT2pRQkNiMU93RVVBc1ZLeWRxMG9UQ01TbzZz?=
 =?utf-8?B?c3lyZS9mUDZxUjBnU2ZyK0RuUCswMmZPbGVTa0VnZ3Q5MHBldDZZWTVVZllS?=
 =?utf-8?B?aDA0UEdWM21ockdaSnJOdThiV3IvQWIyMXpqcjJNbG9USlJSV0NQcWloQVBy?=
 =?utf-8?Q?PpIab1xGN+6PDkRxpl9WULVQJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CzhjVJB82clCQO9rYuJ+ZZRckPPPq4WwRP/+GPz3EOJsKtxsdx2ycEocZupilMX55GNmBnuanEnhheyGV52+cL8Vdf+LrGVwvjyQUCsUWC0yANpq5/9T8A+GiF7sakcEbUdo/MQocgbwyw9Sctc6y8Iq5PW8AiyTyE5ofqzyfM/IkwC0YU4G8jur0nJ3mYRqmLXpSa4cEOtvf+mpB+/42ZiaKQMxIx7WuhUtRxnAvYBrzXi8aEJEvdUqVp3ZfPiaRTJIUahqdkptN4RlpalA7HkWbSSEh6dDmj1qIKfv++8/TtWt2G41Oxh6SjFuuQUkMxfIRIAAIHzQJd6+7jKk/UjOtW3TS7CaGF0No/9JF29Rj69QEOpYP1oV9nNUIvYC7MHBhO16jeRRf0793fvj02yns3EZXMSMmn6TO8JqkoDUckZ+7yXEEWzDftB0VnwIAf6eBDdkykys0fL3GuDGfp30RUyWuwq5IYHvpjAQHj+vUY81EbMRWg+K0SLa4GWTECAFSGMk/gJdhIP7Allp14eAEl/SL6M1Xum09dPbasvCd+TFtAU/LK4ojaNwAtWtJbX7wGfBqytxYKvtyGvkVEQTjQCp4YJDIlJiic0tXLo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b394023d-0249-4d00-3c2b-08dd7b903563
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 20:09:05.9744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFwY6BMffhDmsA3hVS4N4tVkYhoZTOaW39z0CVvAvuadOB8vRsD+kd2TMJbH1uGNV9MBtIRt/63m3PEPG7JY4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8424
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504140146
X-Proofpoint-ORIG-GUID: 6tNngpbblxdiapLFh3U4Vbrpays5YGFa
X-Proofpoint-GUID: 6tNngpbblxdiapLFh3U4Vbrpays5YGFa

On 4/14/25 6:53 AM, Ondrej Mosnacek wrote:
> Hello,
> 
> I noticed that the selinux-testsuite
> (https://github.com/SELinuxProject/selinux-testsuite) nfs_filesystem
> test recently started to spuriously fail on latest mainline-based
> kernels (the root directory didn't have the expected SELinux label
> after a specific sequence of exports/unexports + mounts/unmounts).
> 
> I bisected (and revert-tested) the regression to:
> 
>     commit fc2a169c56de0860ea7599ea6f67ad5fc451bde1
>     Author: Li Lingfeng <lilingfeng3@huawei.com>
>     Date:   Fri Dec 27 16:33:53 2024 +0800
> 
>        sunrpc: clean cache_detail immediately when flush is written frequently
> 
> It's not immediately obvious to me what the bug is, so I'm posting
> this to relevant people/lists in the hope they can debug and fix this
> better than I could.
> 
> I'm attaching a simplified reproducer.

It looks like the attachment did not make it through.

Li, can you have a first look?


> Note that it only tries 50
> iterations, but sometimes that's not enough to trigger the bug. It
> requires a system with SELinux enabled and probably a policy that is
> close enough to Fedora's. I tested it on Fedora Rawhide, but it should
> probably also work on other SELinux-enabled distros that use the
> upstream refpolicy.
> 


-- 
Chuck Lever

