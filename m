Return-Path: <linux-nfs+bounces-11107-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4561DA85EE6
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 15:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2357B8C65EC
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 13:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D2E189BB1;
	Fri, 11 Apr 2025 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YWprIAwF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QCenGqhP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5775217A586;
	Fri, 11 Apr 2025 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377920; cv=fail; b=XcAm9qVJc+zIij/TlWawtBEegLkEGNTmeupoMtEfmbZJTXjfSXCRaQMJ6yr/QmatxNsfFr6EbnVMmZo1q0p/0lxmVbAKh9rLHy9Im+6Rc1PrRRQaeS+GpukRSSqMISYJXfCodiSXNmP5im1iW92uK+SzNGhsDBtQFyp3kFjIalE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377920; c=relaxed/simple;
	bh=bU9ZsBW1tn7V2wa1tr8c7lvAjgunpvYeCXMMNzgSUZc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fXQ2VIEz5j8aJxoEnM4i/v6biZkme/bKzxu7sh053dSPnR1UqLCB819JpD9hY+E0vsfkElF+KPRJrJ7hlA+vUPi7COt3vm8YRJe25mbHceARdLirnF+pYZ4A7LNMytSKmMeTyF4HqNwogbjRuKI3KBtjnIDDDhsOaAdQbmKJ4Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YWprIAwF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QCenGqhP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BDJBDA003514;
	Fri, 11 Apr 2025 13:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8ovUt4YfzefGzyg49Z6Ps34M2Lc739OBi2CRqCGHoHA=; b=
	YWprIAwFCh2e9M80bv51gIbsefl6TNrbg12p1dttD/64ePVw8Naf+hq69ySG/MTR
	NfNPMeAJydT97fTA/0wn1tszcA/min+0O/i9Nd1ssi2k7BaJPxe+jDYDD2vJFigA
	lxuZE0IcMQ8GcgZ9q3kxTolop1/VoOBLYRQPu1LmbnLXyDmWx+MQYUKHd3qTBgzm
	YTl7QE/DBFa85WdxpbnOXnXzXuytKb/Ee+L99NyDY/YWQzkZeEDjHyQZNVUI3l94
	2I4ChAfynrAOejtXlAlOuuKmL4Vq9ZtL83rEXnhAaXkjDpeXPL6DszGWgijX8gL1
	sa7aAuxQ/iwD8UBF6wQBGw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y3ux80eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 13:25:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53BCVFeW001275;
	Fri, 11 Apr 2025 13:25:06 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010018.outbound.protection.outlook.com [40.93.12.18])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttydp0v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 13:25:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giy/e+4fLZZukaSn4URl6nLLgXDkgm1FHbyoIKL9AeQiMx1vrz2f84FUclxC1H+elO3to9AXp1axRMW1hrMNw8t/V0xxFNhcdDOIafKkk120r3bg8ZeYY7IfP4s8cEJaNlbh3MItZnIC2m24JfwaV2xoC7eAchZIqVbHBAb4uXxJZlEQU196eJ5S3Slae//thtr1CsG1uKIFM9eGR97BCfetOmrmXFMunEDKPtUetw7+b/NT51rhZgL1boIcwosjF6dpo+Obd6ZTLvZy5YBQiw6q/3vy5AdAe++BOravrGw3VVZr+eNN3Xha0oJEXfk7r+vgvPZnXvWbYWccd0qmRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ovUt4YfzefGzyg49Z6Ps34M2Lc739OBi2CRqCGHoHA=;
 b=wAq2BU+pSIVL3iPrt1kzV7UBM0neGB5WFye6wL9ZCTzfyj9fGtdAcWhJ4kkOCgMRRTpxIKBN+KxUtTjlAx0aKxgLn1OYDenUaCh8NLtJYe1LLcUNlQC9IjBuZighCz+0uojnVQOyJzR7d/Ltcgo5C5a//l2nWPEjcspA33v5fqsvhxZkM5CbBkZf1i82Gg5DHnQN2XxPiSblENL+4zTPsIwMvitlnFon1DmfSzEewgKpbfZ4z/YNMULzA79GknTs85p+UAh3BPf5OZEbNnF3Dwr8p4jRxkXfXNAuQdb7JsHVFZnGsGx4vQvukN84/gqpvIGSYZR19K65chaibel3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ovUt4YfzefGzyg49Z6Ps34M2Lc739OBi2CRqCGHoHA=;
 b=QCenGqhPEzx9YuVFVdEkBCw9D3bzOQiqGpCmYeB+jXHrsqYxpgV0AKRmVmNXvy3bQnpR8OfOBicIMkR3WDpsF8t5oWg3P5vdPCBq2f8B3FnHjETYE4y9rC8UiQoMOYMbpt8VlaDpnezo6kkdkppJvrVfPldmsn0PM/+QJZi/9bA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 13:25:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8632.017; Fri, 11 Apr 2025
 13:25:04 +0000
Message-ID: <3d16719d-11f8-4016-a311-6ee8dc11667e@oracle.com>
Date: Fri, 11 Apr 2025 09:24:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] sunrpc: add info about xprt queue times to
 svc_xprt_dequeue tracepoint
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
 <20250409-nfsd-tracepoints-v2-2-cf4e084fdd9c@kernel.org>
 <d18a4caf-45c4-46a8-81af-400d94f51606@oracle.com>
 <1c99e177b4880f92044b4a37a735081b1f9d6118.camel@kernel.org>
 <91a99432d2b72ddcb88de0e86dadbfbfbf4590ab.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <91a99432d2b72ddcb88de0e86dadbfbfbf4590ab.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 18294c8f-fbe2-4c68-2221-08dd78fc44f4
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WGhEYkc5QXE2ek0vVXRrVjlHZ3JuVFVKWHFXRkcvbE4vK21sMlM4YStxUHNO?=
 =?utf-8?B?MmxPRC9jaHZOU3pLWG45cytjUWhXWjNaUlFhS1dYdi9RZElYNk10aTM1WWlD?=
 =?utf-8?B?V09wL2pEeWtiTmJRNERnRldmZXFPTDd0a2p3WU5SRmkySzlVcnYzQTBIajRT?=
 =?utf-8?B?Yk41bXY1d2lGMGVHRkxqeElJbXFkaHFNakNoTDFmZWMzR05NYmw3YTE4eFpt?=
 =?utf-8?B?enZzaVlETzlJR2hXYUJYN0ExSG1Ma3h0bDNnREV6SWNZczBPNHRSMmtjMVNy?=
 =?utf-8?B?NUF3emZCUHNJczlwcDV6UldwdUNEZjMvaWsveDNPOFlnWUhlV09IK1ZLenRF?=
 =?utf-8?B?T3hvQnAvemxrbjgwWW5IdElWZ0pyZ3ZoNXJIenRrRDVicTZjSjViWmFNYW01?=
 =?utf-8?B?R0hNdG1OTWk2dzJISmVwUHpPczE3QkJiZ3JKWXcvZnF1ZzhSNElwcnB4YmFi?=
 =?utf-8?B?UGR3TC9XbWx3d2JmYWI1M1QyRjUxVjFEVTRVMWFqYXRoWjVQbURzZTdkUUgr?=
 =?utf-8?B?OGNFdSthS3N5bjdRcUVKV3puaHgzODNCSFZoWUtNQVlnTFNVcmpkMDg0UTlX?=
 =?utf-8?B?TjYybGtnRDMrL01Jd1UzU2krc25ETXhtbnc0THpZTHFJcGttdS8vQ0FHSWhj?=
 =?utf-8?B?QmRGc1FtQXVUcG80TFNlVzVxUktGLzU3ZHlOSnJDNDVody9lQkNhSlFTcDVF?=
 =?utf-8?B?Zzh1dk1pajBBZlpxZmRFaWZGWDZ3U3gyVitxSnh2WnNUZ2htVWI1SjRhaG0z?=
 =?utf-8?B?eGNuT0UxWUFqZ3ozbDF4MXRXRkpZQ0U2UVBmZksvdzYxdVk5UzVvY1hZMVJV?=
 =?utf-8?B?d3J6eFFkRVZKb0Q5eFIzRGs3K0p3eDMvK2k0VmloNmphWFd1UkduRytQeUM5?=
 =?utf-8?B?RU9CeGxrM3ZTYzJ6N2lGNURPaGZMR0ZnVHV4YnU1SHQ1MTJxSnVSdGpMNzVB?=
 =?utf-8?B?bG8zRWNDQ2pWY2dTUXNrM0Zwd1lMNldQL1dXbFROT2dxMVJqL0FTNEtUcSt3?=
 =?utf-8?B?TnRCbm9DMExqUHpPNVVmNjZ1UnZ1WVU0UEhybzlidzZMZnpxdmEyc1g4ZklR?=
 =?utf-8?B?MWtMYm15VnhIQko2NXRpSnRJR2lkTkJzcHUwMGJFNXJpZjlwZjJtVU1sY3Zj?=
 =?utf-8?B?YVNobVVPVTV3ZGtlV29mS0VWZzEySUpEWk50SDY3NUhzdGFhNzcrVzk1VUVt?=
 =?utf-8?B?bzJ0ZW5FdlI5UGRKeENvZlRTU3hSNFh2OFB1V0p0c1ZYOHFZbWlZOTdKUFpZ?=
 =?utf-8?B?eHltbEFtekJnNml4SU11YjZBRldaTlcyc2pzVUhXcGpLT1AxWXFNMEEzR3FS?=
 =?utf-8?B?QUNwa200YjY5M0dBMGRGRWpKVEVsWHFucVNyNk8ybWd1N1Z4eXNlUm90K211?=
 =?utf-8?B?Q3FWK0VteUttM1RQZFBXYU5Qd0pvUnhScDB6eFdodFYrTnk5WDIvVVI3YTNX?=
 =?utf-8?B?K1JsdnVOR3JyVW82TGlDZmwxc3ZORGFSVHNlbHU5bk5MZkZ5NW5YU3F1MTd5?=
 =?utf-8?B?NlRaYWNnbm1uamQ2VWZWcVhjZ2RITHJTVCtMSXNmSzJHVUJmN3FQQmd1aUF2?=
 =?utf-8?B?YnFjZDhkUU5GWkJnVjI5bzZUMWQ2eTZiNldYcHErcSsyeFhSVURQOE03Qms4?=
 =?utf-8?B?WGJ2RHRVTHNGL0hIWUJTV3pic1lsTVlqeEczNkFkdm9XajVoMDhZQ0RRL2s1?=
 =?utf-8?B?ank3YzE4QVhBMUZaV0l0T1UrMjZwUmZEWjB1UnRkREkzNHBrdEVKajZDbDYy?=
 =?utf-8?B?VDFPZnIzcW5aZG55VmRpc2dYazZ2SFNXcjYxUE43Z1lLL05qUXdGU05vZ1RV?=
 =?utf-8?B?TFNnM0w3Uk9YWXhyaEZQOEpFY21NcWdva2VwREo2UkYvbm5BYmJtOENnMnFm?=
 =?utf-8?B?TE1oQlM4ZlNqZlU0MUdHamlqUjQwVUhmR0piNU9rUzZOWm5oVGJXYlhYSFdI?=
 =?utf-8?Q?Ynbe+jiDC60=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dU13SldBYXdwSFlldWtnbDUvcVpFNmNBTWY2dGdXTHFJYnBIMExxNnROL3Vz?=
 =?utf-8?B?cno0ZkZwdGpXZVpGTzA0V3dESnpLclhRenhaU1ZneWxXdTB3Q1JUWDBxWmN2?=
 =?utf-8?B?cE50RVhmM1FmK2Y0cDJQYzJxTm5OYmZMbDNWRFMvT2dTOXlieU9vTHM1dnNT?=
 =?utf-8?B?S2RDZmdHVkV6OHRnS3krZkN0Um4vWGtpODYyTytTQmlKRTd1REZLbURxaHBK?=
 =?utf-8?B?czMvYndJbS9OV2hKNmt1MDRwOXdMM2Q5NXRnSHdVUjlmUC9WZUY0dlBtOU5O?=
 =?utf-8?B?Vmlwb1pkSTMrdkFGYzNVWW9iOG9WbnZBVWh6SWhDL0h0d1JyaEl0amdiVjU5?=
 =?utf-8?B?aXcyZFdwejlWTnNJQ0FtbG5YMkV4Q3pieDNGVytoT3Zsb3ZmTHlDQ2ZyR2R6?=
 =?utf-8?B?anJJRXJGNGFmVFJFSi82NkVXV1ZuelRYVjZlTXRYZEdzd3YzOUR4SkRPaXc1?=
 =?utf-8?B?MEljUDF2R3dTbXowQ3REaDA4cHhiYjRUNTk1SlQreXRpY3ZPRDNHVE5nMC9y?=
 =?utf-8?B?VDlCcjI1cmdZMUUyUktTQWsrU1ZNbjJNNm9ibWY4aFA0bmZnU2ZVWE1ReGVM?=
 =?utf-8?B?SVQySVpyUGdkblBETmxFRS9zei9jcmhOcjZOU2k5OWIyZDJldEpQdnFkV0hS?=
 =?utf-8?B?MW9iakhhK3pPZDh6LzNvUVNRYWw5aDk4dks1c1M2VTRYUEV1ZWRHZTZ2Y0xD?=
 =?utf-8?B?MmlGc3NFY2ZPZTZ3VUJ5dlp6amdsYzBBUjhZaVB5MjdOZE5vTFNMM0NvNmpt?=
 =?utf-8?B?UlVBcG9SNFJFNUZBYm1HcmNjZWl5NzIvbllUMjFwNHJFbG1SVHdqVVJ6bXFx?=
 =?utf-8?B?TzVJTTh4THlJcEZ5VHUybUdXQnBFL2h5Zmx5U0IzTnNha0NueUZ6ZmgzbGl0?=
 =?utf-8?B?ejVuY0xzV1hNSllDWFh4MXRqK2xxODY5Y0sxSEQveTRaODZLVnNScUFnVnd1?=
 =?utf-8?B?VGF1bG5LNjR0OFNKQkNFdkx0UWtPbzVaazRxRTQyYlp0Vm9HUUlFNjk2eUkz?=
 =?utf-8?B?ZFBrY3YwMHRKQlVtRllwZysxY3VIeHMrcHhzVnBtV3loeVpLUytKSXZFU1dQ?=
 =?utf-8?B?UjIzWkNZMzJzZUFHMDZ2NzJ3eEVOazhpN1ZMa3dITHBuTGt1bUxRQmRpSjJy?=
 =?utf-8?B?NXg1RlNKWktzbENxdGZ2SzZQYzMrWXBIUlVneDI4ZW9zNlhNYTZGQ3pjK0dH?=
 =?utf-8?B?UVRNbCtGUmVJelA2M1dWVUZRdnp6UHd6STcxaGNIOVhWbnRUc0pIaXJjOXJJ?=
 =?utf-8?B?TGhhNGh2dHkydDlNUkJqRWRiMUZnbkNDblQ0cWVsbWR1b280Tm5QL2NpZkxj?=
 =?utf-8?B?cUprY00wWTBlV2dVMEdZd3A1eUs5enJVSFZRWnRhUTl0eVpoU3JqdGVOU2w3?=
 =?utf-8?B?dXgvRUlocEV6ZFpzTkQyblFXV05STFdBay9Bb3RzdzBsODI4ejQvcnY4NW04?=
 =?utf-8?B?NkV5RGNSYmFhNE5IY2xIdE9aZVBsVVdBVGVsRHo1Y250QXNRM3d6b09NRjFs?=
 =?utf-8?B?UVV0UkQrMGxRQ0IwS3pGTjdFeFZLME9wUXlpcklnSHh0YmZSSGhLSUpsd2Fq?=
 =?utf-8?B?RUFKanBIOHlZSEhEamh4ZWQ5MnJqeGxWNTd1dHZxMkRha2I2U21FKzBQd3po?=
 =?utf-8?B?MkVqY1hXbkhqK1dFUGtSVHJkWXBJUmRiR21NWGRWajUrdmpVSDZOL3JaQm9M?=
 =?utf-8?B?UkU0cjdjd1V2ZWE1bWV3Nit4L2szbHdMdXh4WjNSaTUzTHd3M2J4RXVTaEZJ?=
 =?utf-8?B?TjN3N1F1K2Q0L2RUL3RQTlMwajQ1aFNuRFlNbmFML0VNOTd0WWx0ZnJjVTYv?=
 =?utf-8?B?M3hGNWVoR3dGRmppeFlsUExIdENHT2Q2NisrblN5S1Z2UnBDd2ZTSEhTcHg3?=
 =?utf-8?B?eDNsdUF0Wms5cTVwdXNIZ2sxQnN4Y3BOekpBbHVpRGNpZm44TEMzMVllNDJz?=
 =?utf-8?B?TkhSUExQL2FuaGJMK1c4cUg5SXV0TEloTms3MjMwMUlHelQ2dVVMaGxtbTB2?=
 =?utf-8?B?akJaUm5RL0NnVFBmQmZzODdYODdtOTRWSGlvdkkwRnlmRXRXS2U2SDJuOUp2?=
 =?utf-8?B?NCs3ME1nVDhBN2ZZcUNlZzdEekIwT3hSbVZCVE1ablZ4SW53ZTlKRmY5czZY?=
 =?utf-8?B?cGpyYkNMUDhRVDJtNjdrK2pQVXBjekE1VGdsWGN2Q0o5VUlDR2dBb01wTXRG?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H13tZp7ScUrVOsWJKsfrW4NtO2SBvFNhTdrRrNsoYR+nmb1Wq06SdQ4GGWcCiNfUj1kJjaYncDo2C0bPgQm4jIyElUcfW/nzWFhYKMXEenKRmxGZf3EWAH049//QV+9/2Up81H4d9Y3kbf/Y9InrlQ0QIfuLp+OED40C4ivRPkKSH1DH9mC+/sOSpMfAKZUnX6OskRCdpVLlnYX/ZjnSM4nzoARLD1VbjgijT3PRTO3GFh7Vo2+3l2llG2exArt5ANLcZAeEpYQJxNiz/tCx8MP22A9/k9TiD4dgx9+jUlifYns/lqPmvN22HnqhS5fBv2W0HdLcFP9eb2VrhakX+H2BtN9lWGA07fyWr16IfG3RjQkZTRUjUSerZFjMMb50F0LBGPJOQ8ZXAKZBObZ6Kv+PdVjv4wXmGO7q7RSxFN5GcLK7Lq9IIl9py7RriCzTXK02yWCVW2bGrNIBWOn3mQ5AWKCFM9J6lkunv+yutPkZUnwWrKok0dp/4qgWaX0QU/KrmIsnNSkgNYqhzIqVZmgbtWkhpeP+VlkfDGFs5hAHb0y5CXmpRAGc8fo6F+eLmv2vr3cJIZ7zf2o9rs9TgK3klUOeSZyMVrYzQ32rjYI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18294c8f-fbe2-4c68-2221-08dd78fc44f4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 13:25:04.1571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqxPiJwiBUlSg9u5KCg8tRlFFq3W/aDwGEeFjoJlIJ+aYNnhVGC/MR/QK2z3ecMQK7ar2P58VYjlDsfUzGy71Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504110085
X-Proofpoint-GUID: wWz7VQtTchUAbTqjg9NdsFPyhTAn_pYS
X-Proofpoint-ORIG-GUID: wWz7VQtTchUAbTqjg9NdsFPyhTAn_pYS

On 4/11/25 9:10 AM, Jeff Layton wrote:
> On Wed, 2025-04-09 at 11:26 -0400, Jeff Layton wrote:
>> On Wed, 2025-04-09 at 11:00 -0400, Chuck Lever wrote:
>>> On 4/9/25 10:32 AM, Jeff Layton wrote:
>>>> Currently, this tracepoint displays "wakeup-us", which is the time that
>>>> the woken thread spent sleeping, before dequeueing the next xprt. Add a
>>>> new statistic that shows how long the xprt sat on the queue before being
>>>> serviced.
>>>
>>> I don't understand the difference between "waiting on queue" and
>>> "sleeping". When are those two latency measurements not the same?
>>>
>>
>> These are measuring two different things:
>>
>> svc_rqst->rq_qtime represents the time between when thread on the
>> sp_idle_threads list was woken. This patch adds svc_xprt->xpt_qtime,
>> which represents the time that the svc_xprt was added to the lwq.
>>
>> The first tells us how long the interval was between the thread being
>> woken and the xprt being dequeued. The new statistic tells us how long
>> between the xprt being enqueued and dequeued.
>>
>> They could easily diverge if there were not enough threads available to
>> service all of the queued xprts.
>>
> 
> Hi Chuck! If you're OK with my rationale above, I'd like to expedite
> merging this patch in particular.
> 
> The reason is that we have clients with the nfs_layout_flexfiles
> dataserver_timeo module parameter set for 6s. This helps them switch to
> an alternate mirror when a DS goes down, but we see a lot of RPC
> timeouts when this is set.
> 
> My theory is that the xprts are getting queued and it's taking a long
> time for a thread to pick it up. That should show up as a large value
> in the qtime field in this tracepoint if I'm correct.
> 
> Would you be amenable to that?

No objection, repost this one with the beefier rationale.

But it depends on what you mean by "expedite" -- v6.16 would be the
next "normal" opportunity, since this change doesn't qualify as a
bug fix.


>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>> ---
>>>>  include/linux/sunrpc/svc_xprt.h |  1 +
>>>>  include/trace/events/sunrpc.h   | 13 +++++++------
>>>>  net/sunrpc/svc_xprt.c           |  1 +
>>>>  3 files changed, 9 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
>>>> index 72be609525796792274d5b8cb5ff37f73723fc23..369a89aea18618748607ee943247c327bf62c8d5 100644
>>>> --- a/include/linux/sunrpc/svc_xprt.h
>>>> +++ b/include/linux/sunrpc/svc_xprt.h
>>>> @@ -53,6 +53,7 @@ struct svc_xprt {
>>>>  	struct svc_xprt_class	*xpt_class;
>>>>  	const struct svc_xprt_ops *xpt_ops;
>>>>  	struct kref		xpt_ref;
>>>> +	ktime_t			xpt_qtime;
>>>>  	struct list_head	xpt_list;
>>>>  	struct lwq_node		xpt_ready;
>>>>  	unsigned long		xpt_flags;
>>>> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
>>>> index 5d331383047b79b9f6dcd699c87287453c1a5f49..b5a0f0bc1a3b7cfd90ce0181a8a419db810988bb 100644
>>>> --- a/include/trace/events/sunrpc.h
>>>> +++ b/include/trace/events/sunrpc.h
>>>> @@ -2040,19 +2040,20 @@ TRACE_EVENT(svc_xprt_dequeue,
>>>>  
>>>>  	TP_STRUCT__entry(
>>>>  		SVC_XPRT_ENDPOINT_FIELDS(rqst->rq_xprt)
>>>> -
>>>>  		__field(unsigned long, wakeup)
>>>> +		__field(unsigned long, qtime)
>>>>  	),
>>>>  
>>>>  	TP_fast_assign(
>>>> -		SVC_XPRT_ENDPOINT_ASSIGNMENTS(rqst->rq_xprt);
>>>> +		ktime_t ktime = ktime_get();
>>>>  
>>>> -		__entry->wakeup = ktime_to_us(ktime_sub(ktime_get(),
>>>> -							rqst->rq_qtime));
>>>> +		SVC_XPRT_ENDPOINT_ASSIGNMENTS(rqst->rq_xprt);
>>>> +		__entry->wakeup = ktime_to_us(ktime_sub(ktime, rqst->rq_qtime));
>>>> +		__entry->qtime = ktime_to_us(ktime_sub(ktime, rqst->rq_xprt->xpt_qtime));
>>>>  	),
>>>>  
>>>> -	TP_printk(SVC_XPRT_ENDPOINT_FORMAT " wakeup-us=%lu",
>>>> -		SVC_XPRT_ENDPOINT_VARARGS, __entry->wakeup)
>>>> +	TP_printk(SVC_XPRT_ENDPOINT_FORMAT " wakeup-us=%lu qtime=%lu",
>>>> +		SVC_XPRT_ENDPOINT_VARARGS, __entry->wakeup, __entry->qtime)
>>>>  );
>>>>  
>>>>  DECLARE_EVENT_CLASS(svc_xprt_event,
>>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>>>> index ae25405d8bd22672a361d1fd3adfdcebb403f90f..32018557797b1f683d8b7259f5fccd029aebcd71 100644
>>>> --- a/net/sunrpc/svc_xprt.c
>>>> +++ b/net/sunrpc/svc_xprt.c
>>>> @@ -488,6 +488,7 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
>>>>  	pool = svc_pool_for_cpu(xprt->xpt_server);
>>>>  
>>>>  	percpu_counter_inc(&pool->sp_sockets_queued);
>>>> +	xprt->xpt_qtime = ktime_get();
>>>>  	lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts);
>>>>  
>>>>  	svc_pool_wake_idle_thread(pool);
>>>>
>>>
>>>
>>
> 


-- 
Chuck Lever

