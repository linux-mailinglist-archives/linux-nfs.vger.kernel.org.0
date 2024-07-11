Return-Path: <linux-nfs+bounces-4822-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4591692EBDF
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 17:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC0A1F24A68
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 15:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B391662FA;
	Thu, 11 Jul 2024 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PPDHfl3D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SJTx+NDd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE1128FF
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712618; cv=fail; b=Uw0hsocrOZI6tD3lw14BZJKLc1jr4NeGg4EFL5Ambf/UvOzDg8Ci6/0I0fet5PRewojwn3BIQFOGqAEob7RRLiyuHiR/Pzhj6iy+bHRgqNd3WvQHx6abcunl0QJfoprP9Y00Ti4BSJ/9AYN7A8RcVTBDKReGXJiFmuhGsNeYGoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712618; c=relaxed/simple;
	bh=5wjoCcxXP/b9z+vOT7ZhIHjOtXkW0ivO6w6sp+D5u9M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LwZsIQCzJ6kMHaUVktvFlkZGwe762/2uE+4mhYrT5AWLZb5o4CQQwVgSaLIVPD2QcyG7lmmGnq+iUOmabgViL1WGcyMhW6dZjLKX/GnGb5kfN+vypndLNTVVftZDwbaMCT+SwxYGmMOFXJSVPLFwpBRqOanzQYLrJ9rvCzPyddQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PPDHfl3D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SJTx+NDd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BFBUEO012943;
	Thu, 11 Jul 2024 15:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=5wjoCcxXP/b9z+vOT7ZhIHjOtXkW0ivO6w6sp+D5u
	9M=; b=PPDHfl3DUkxaNbrl5gReenAEgAcc0Dv/z7Hs/Lh8Ci3PDejOXVZhPa8Rj
	yyPuCbcTcRmScd49vELxt6vZVPLwHDC46myubAVi0Aw+VWE5VljKquWlz6TIw+70
	ZZDfrbP8z7898xhZWBSGw8jGjpOJrhwjUJ9uwJCLGmbs2QAdQ6TjMXaQ/38IItwO
	Ro9teTjRvUWhY6bJzlehL5tUfxA+sQyFv6Xds2KZ+HLi+noCgUumMByjUTrPBZmw
	Dhg0dU/IvIs4HhQHa0n1xA6Y6k4L0wVXc5w1pTBW/u8wTHoNve7pIiOc0j4bFYs2
	jLnYQ2M9CCIMskIEjnG7rMJSM620Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknsy0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 15:43:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BErn2P010864;
	Thu, 11 Jul 2024 15:43:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv5xbts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 15:43:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1ru7X4ppQhOEyDG34VJyeQcapU9cAipmIQBXVyDHoEGEm/btMaKHsyRB1XBzkCP4gZ03dODSBY7a25bwikt0oVUj9a7QF+qog3PIuNqWiqBgEeJzLGv905yL8f5gGcNL9pw/DI4Gb30WiRhQa9qPHLUpTx3Exb62Ex9McVSsaoBV9yR4aQE6J6EprKhRqCY11XAV5ESYcUWKFWNN4DZcXQT0sIiwVYgwZcoY18jzWVlrjGI1N6wW0/LLd4VNMHyi1GqwtVJU+GiKeYNgShr78TgvPYQ/cz1LK72Lk2Li4738AHaYH1EaItuxu5rstCKCNbKomPgaRquI2+VH8zFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wjoCcxXP/b9z+vOT7ZhIHjOtXkW0ivO6w6sp+D5u9M=;
 b=x4o5uEVRf7JAUJiViicw7H2pdxgRUxJFlz8ygofyOKZDLYGXOIxtSkau+YCAAq+b7eYO5UP0O1Ometpcq8k7gGMxCOqbnkWBWH6oYiTZKEqSYY4NMi9laVrpqYMUnPa7vGHaNU5YG9a8Q4wbQTNdG7CtcgM4Hdsq1YufMcVUcQIRicRh/NERw2lZetFwHeUb6M+/wtYplo/XF7LEp/+c9xzIIRuMsWAQl2zZXTfRgW3GgPyVX1NKKgPeTi3/OXc3NdkoY5ual1AwtvT/sQzENPfam764P9BxAb5beCmIE0mHyXwodT1sJTHIkSKzO7r10cshTIGnkCcictGXh80ofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wjoCcxXP/b9z+vOT7ZhIHjOtXkW0ivO6w6sp+D5u9M=;
 b=SJTx+NDdiT38rtO+7Ox6+jqXocMH7RZl5LPoVhQE0u5DVnNAxCifhAvWCxHoM6JVpT+y48eBJtg56K7DkmJ9EI2xXXXmI3inD5paXS+nSSy1gS6sqkCocP+O3lgITV9HFnldxNHvZOOXpvg6K66nT83fb1DCClxGue3jHZ4nw/c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7196.namprd10.prod.outlook.com (2603:10b6:930:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 15:43:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 15:43:15 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
CC: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker
	<anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Fixup gss_status tracepoint error output
Thread-Topic: [PATCH] SUNRPC: Fixup gss_status tracepoint error output
Thread-Index: AQHa06Zlmua5rY536UGCdGYX4HOZRLHxpqaAgAAEF4A=
Date: Thu, 11 Jul 2024 15:43:15 +0000
Message-ID: <6160CA6C-DA12-4025-AB5A-F180BD03E195@oracle.com>
References: 
 <27526e921037d6217bdfc6a078c53d37ae9effab.1720711381.git.bcodding@redhat.com>
 <Zo/6G7ANcWEWkd0l@tissot.1015granger.net>
In-Reply-To: <Zo/6G7ANcWEWkd0l@tissot.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB7196:EE_
x-ms-office365-filtering-correlation-id: 6f735d8e-1938-4722-e55d-08dca1c02df2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WjBHR1dlTGFHdklNcXZHWnY2R0ZWRDV4TFZYTGZLRVkrZWFPeHhrc3g0YjhL?=
 =?utf-8?B?TXU3QWJlUUNJRTNqdGIzODhidFE4eG03b0ExWEFRYkpudEVFSTJxMElOc1BZ?=
 =?utf-8?B?b0hSeUl3RXA2WkxzbktxTC9XR1hiS1FKd1hYWmlVcTVXUGdMdzJ6YzdaOGNn?=
 =?utf-8?B?TW83NGQ0WFVlZnI4TGZob0xyOXhOLzArMVQrb05WaEF5ajkydXd5V0dsaG9a?=
 =?utf-8?B?Z0lyVEpuRnlHNlhaRTFGUkRqQUg1TUY2YjhEZlgvdDFTbi9NUGoxMjFneEha?=
 =?utf-8?B?UmZvcWxNYVZHVS9MaTNpcG5LTmdXdGlXUC9uNTQxSy9jZjRYVjY1eUxDYk9m?=
 =?utf-8?B?K2x0WHVJM09sTk9qQlpNZ3RESnZydXIrRmtqUytLbWdBVXp6Yk9wZ3FaTlJo?=
 =?utf-8?B?K09ZT1JWR081WHFwL05CRFJselVvOVdEcUpUM3VIT2xIMWxwemxDc2lqOG9x?=
 =?utf-8?B?ODFIWDgyTHlNdG1JdWNUQkR6UWkvY1E5NDlmdHZLSjlpNFZab3hzVVlDUnhQ?=
 =?utf-8?B?VjJpYjd4ZGdxVjRLMDRmZEdLZjJkRVRIRXdlaXpsYURQRlRQcW00NGZMMXBU?=
 =?utf-8?B?N0syaGpZcVpwdmtxM0Z3K0w2Smh6V1p5WTVZVk9xenh3TThUVVkxSERJc2NT?=
 =?utf-8?B?YWRRTVRiWTl1VmVKR1dhazJmSm9vRnhER2ZOZmVhdk50NytLdG03ampoMUZ3?=
 =?utf-8?B?RmxnTE14aXAwaFJDZTgybXNnY1UyVnEvQ1FpcFgwUzhUaVg2elo3UVZ4cFIy?=
 =?utf-8?B?U1BDdHBrelVUWkJUdW1xMzhqOFY1V3lqejQ0d3daSEd4aUoyeDhQZ1JRbDhO?=
 =?utf-8?B?T0N3OElQODF5SGl6YWg4Q0M0WC9oMnRJM3R4bU41MExOTUk3eTM0TWRnc0dT?=
 =?utf-8?B?RHlpK0hVMFUwQkhCUnBzd2UwczJMR1orc3AyOStNVEVleTN0UlVVK3lGT2U1?=
 =?utf-8?B?bnJZQ004ajJMMWRxU3Z1a0VFNGR1T2hPVlU2djc3V1MzVGpDM3pnam5OcktI?=
 =?utf-8?B?empudWR1a3RmWTZoMUJWMEN5ZzdqRXBMVXVRaDFwN2NZdmUvV29lTmlJaFpr?=
 =?utf-8?B?eElQMTIzMnVIRUhRVndMQkI3ZEFWYThhalBlTnZaR1FlYXFLdGIza2tDcTAw?=
 =?utf-8?B?a1NNSFBkdCtudHBid2ZuV1VkTkNibDFGb2VzdHdYcUg2Kzg4SGFwVU5JNSt5?=
 =?utf-8?B?OVZmR043dEJ4QjdlN285ZU5WYk1Rb2FYdTJ5U3dhVTZXbzZ5UU9WdkwxSjlk?=
 =?utf-8?B?a1BYZ1ZmaTNNdjcvVUVpVVpsSDRmSEQvVXk2R0RtMWtVV282V1BQcDh4L0sz?=
 =?utf-8?B?bjM2K1Z0dWRJa054WkpqV2pXM0hRNVozUGpQc0Jqb1RRcTVqOXZtSm15NzZZ?=
 =?utf-8?B?bmJOdUR5Z2JSVWVmTHZ3ZDVqZjU5aFlsK2JheEtGRWdmTGZ0UE12QkViejZt?=
 =?utf-8?B?MTUwR2pjZDd4WDNTQ3M5OHhYYUIyeXVCekZkNGtVQkRLSjQyWTVaUUVNK3E1?=
 =?utf-8?B?UjRhNjZ5NEEvb1VRYjk5S3NLekhTOXRrRFlIY0R6dk1ITjhWNlNXckZpbnJ5?=
 =?utf-8?B?aEl1eDZBT2ltVEdHMFpUMmYrcTVjL283dWhUUGZaeitJQVVnck9pZWcvQTM3?=
 =?utf-8?B?K2h4ZVI0SGpPdlQxYisxMVBleGdpR3VzNVNBbTZZdVVDZ24rSWdjbnFkcTZW?=
 =?utf-8?B?aXRjVk5GWk1xdzZMSW1DVVUrcGp5RU01RmlCemNtUkFRclZxdFpJZmMyUkVT?=
 =?utf-8?B?NkxTbHpkc1duL0szZnR1MjdaZVYvRzcxTlJkZURSQ1pERWVPcDR0SDZrVzJ1?=
 =?utf-8?B?TUxQSFlxaVJ3MG5rekowY3AwRkowR2FWU1J0TjF2Z3R5OUFoSXp1RjBTTnJ1?=
 =?utf-8?B?aWFNcmZTTE5iUDZLS2tvbjdDZnB1RHRRRHRsVldBZXBTb1E9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZEFjZXIxekhwZC9aTVlvU0l6bXdyc3dPNnU5dk1mNDhycXVsYzhFdHZyenVG?=
 =?utf-8?B?Y09TelNRNXM0TytScmhVdnErNlltRUlqT0p1NW8xUjhXZGhPM0hTMnNRZHNY?=
 =?utf-8?B?c0JOZzVEMUNJRGhuUVZjbDY3bllSVmxjdDRPaDZJS0NFWk85YUloN3BjeFNh?=
 =?utf-8?B?RU1jN1NoOVF0MXM1Qno1VXhNWFNjVHlxajkyRzQrQXdkK3ozSC85a28wOExn?=
 =?utf-8?B?dVkwaTBiYi9WZ1FNTHBvOW9xdHVRWk1VWTF1TnpiTEVEci9LY0J4S1F5Mm5o?=
 =?utf-8?B?bmZIbDVWelAwTnBEemdDZnNobXlpZHEydUJLb3REK3Vvd1M2MURXZFBrTEZZ?=
 =?utf-8?B?RG56WDBsZ0VLUHZHOFUvRUVnbW11ZWQrZ2EvOW9ZZEZjS1NURkF5UFczZW5p?=
 =?utf-8?B?d1hmOVIxUTYrSXZwL1U2YTBOTFJLRWcvQlZXdTl6NmZiVHpWV0ZpejVnMkpw?=
 =?utf-8?B?aXBmUW5hR0ZiNzIya3FxVDI3aHpxSExmOENQLzlRVlQ3NjRoNDJZMGdHY1J1?=
 =?utf-8?B?aVAydFA1ZmtrQlZQN3NtOFFGdGh4ZjlnUkNBVHVRUkoySUFuWEttb3VkTUxI?=
 =?utf-8?B?VGRSMjlZSEw2a0FWazBhQldqK3ZTRGdybXcvMkJYZ2VrWStGKzNDQjhpRldl?=
 =?utf-8?B?UlQwaktjNjZVNnFFUUNHUFF1alZwZlR3V20yVkhoTEZrRGdLWThmK3NXYUZV?=
 =?utf-8?B?czBaQzJubnhFQW1qWWhrYXJ4NDUzeEJINmd3Z01TM0x4ZGVnZnJDMVI3VEly?=
 =?utf-8?B?dzY0eVpwbVVXUktDeTYzV0pZdkNkUUNxZ2plWENhSEpLbGNCUGszQjV4NnJl?=
 =?utf-8?B?R0RnU01yeXFKa3AzVDhDS0dEUVdkamJLaXczRDJZVUdCY0l1cHdERVp3ZFd2?=
 =?utf-8?B?cmdXdEhVbUY5RlF5dFFrZFBUYllpMXgzcUdPU0lkczlDa0c4QmN0SEI4YUNq?=
 =?utf-8?B?enNxU2NnV09zOGFqRGdkSjU5SWJrU1BXUHUzWDRpRG1RZFpYdWp3ZDFjWjFw?=
 =?utf-8?B?RVFVYlBtbXBRVGhTRE10a0FPZDhLQW8rSGVXSy9IWCs5eDNKZllUc0ZxUU9T?=
 =?utf-8?B?bGpGdjNaWUxaVy82OHc2cnlqZENWRXdXaUxFMmFNV1ZjamhjMmh4VENFQzhw?=
 =?utf-8?B?TkF3Q042L3cyWDl6NXYxaS9XODNjZVR4c0Z0eUpENkliR2YyY3hsVmZPWFQ1?=
 =?utf-8?B?UkdOdXlUa1hnMnRXc3FScUl5QVpJOTZSa0h1OVFMT3FKQi9INmZHYlVMZThI?=
 =?utf-8?B?M1lkVk1XU0ttUkxNSWM0YXlFVTlQTWl2cVFxRStLc2Q2OGtmM2hKd0xaM0Iz?=
 =?utf-8?B?cWR0cHNWdGNqQ3VrZUlmdnlmSEpHS0RkeWNxMUk1bzFwR0tsUEtmSndTWkty?=
 =?utf-8?B?ME1NdFhuc3pnNnpLQlJEamFnYmxQN2RtcEZRb2t3WHc4bk1FNnFFQ1I1S2wr?=
 =?utf-8?B?VjB2RlVFVVZFaFc3bUo2cTd2a0VzS25aUFRKaGZuYzVoWDhicUZKdGNkUmJx?=
 =?utf-8?B?WkRnTHh1NnZUSjZJSjNaWlhMSkZ3RUxxM0pXWXJSMmRNSkZEcVAybGhHdkZB?=
 =?utf-8?B?bDBiTmdtbVI2UnpkaUozZGsxa0FFdTZTbVhqaUY2YVRHMVhscjk1ZEVJNkNs?=
 =?utf-8?B?NjlxSFAwNERzeXRiREpvR2ZpNlBwQWI0Y2VGNDlyZVZVY2k4VEJBN2tEU2xk?=
 =?utf-8?B?cmFSb09CWllXbWNpS1FEelpBb2lETjdXVzJLL09LYWVtaVlIb1hia1pDYXdC?=
 =?utf-8?B?Ym44QWxUTXcwTGEwYitQOXFtc0VjaXovbkptbFJSUVloTGYyeEViVWFtejh5?=
 =?utf-8?B?TUtidGhUdUNBcUlpYWFoQUI4VmZHZ2JWNERvQjliZG9qczE4cWxLWFlKeG9T?=
 =?utf-8?B?WmRhMnVsYWtUdnZ3c0lRN2VhZzg1V3VSa0FkbTc3UThCNmhIUHFraXJCREk3?=
 =?utf-8?B?RzhsVXdmendIbklRU0d6aEJuNm1LNUJaY0U2VmtWczJ3aUJITmJGVkZwQk5n?=
 =?utf-8?B?YWh5VWVKb0ZMUHpZWUErWWJXSGszM1YvQWhRWWg5QnBxVVFaUWtFS2JmeFF5?=
 =?utf-8?B?VUNYQmJGQVpKUGd4b3N5bjZWMjVDSHA0eGN3bDJqYmdYNDUrbDlFSzZPb1Nh?=
 =?utf-8?B?TWJ6aUhXT3pHQ2ExY1piNUk2azhIam01L1lsZjJBUlAxc1hmb2FkcWRyTGhz?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EB433C69E31B342886029E443D85531@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gb6jUcsiR+TYV6oBrZO2PzEkAnitY+m6Oze44Ph20RadYIiw96TgyYvJpuecIPF7rAcsoHRbgNe0kAxl48eCEVBRcjGt3iU+JwW0aP7pFoyZytqVJGrKUl5gz8j1rAHVMis6d9WEj7CW+z6bOKnl4xhrdIIjZBX9KsQpgNi4FGYI+XHHue4iSoqhsdWto5N0OUzCE3pbj2Fd+AZRmbaz8YU6pV0gH46I3Ouc0YIGQynK1sdWkAdY0iXpjNfb0POKYn+32E4GnuUbozHzA7BJAeHFMDdWLs1AFRBgz6rPVR1yEptZlX6jXlknKep6c76Z4KQQXPHXGbbzbrzgIcwl/bNXLGt4D7W/3NeOSI/tUms/GfbQpxrEL4PL8yJc3DuIJNNHDWpxepitSr9gK4QZkBeAsq9y/jvpWtlRpL9lnmv9LY06yoDtHXku6KcsAn88ZSdxDljiUpBVvFbUWKAzjSXdc/PfqhURoQ8hhxsksU2JiGJovSp4544yJ16QBIyMAOCBwDy3ibFnjGX8lk3vOIJUdBcY5eOs3mn6gY0Sz1zC/fVt7zaefeRy+txZrLimO9spgV4J4cN97vPBYcM4yDMBNa64wA6z2Ybn69yCmrM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f735d8e-1938-4722-e55d-08dca1c02df2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 15:43:15.6104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zaqOeNepellQwnLi698IUh6C8n2jLg/xsyZJwUksuolZJo4rgsGKrz/tX78ALc7MBwy/8vVfcvW36ZxBI0U+fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110111
X-Proofpoint-GUID: egAJBgrhwMvysthDIMNvL1UyPrXB5J6N
X-Proofpoint-ORIG-GUID: egAJBgrhwMvysthDIMNvL1UyPrXB5J6N

DQoNCj4gT24gSnVsIDExLCAyMDI0LCBhdCAxMToyOOKAr0FNLCBDaHVjayBMZXZlciA8Y2h1Y2su
bGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEp1bCAxMSwgMjAyNCBhdCAx
MToyNDowMUFNIC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdyb3RlOg0KPj4gVGhlIEdTUyBy
b3V0aW5lIGVycm9ycyBhcmUgdmFsdWVzLCBub3QgZmxhZ3MuDQoNCkFzIGFsd2F5cywgSSBtZWFu
dCB0byBwcmVjZWRlIHRoaXMgcmVtYXJrIHdpdGggIkkgY291bGQgYmUgd3JvbmcsIGJ1dCAuLi4i
DQoNCg0KPiBNeSByZWFkaW5nIG9mIGtlcm5lbCBhbmQgdXNlciBzcGFjZSBHU1MgY29kZSBpcyB0
aGF0IHRoZXNlIGFyZQ0KPiBpbmRlZWQgZmxhZ3MgYW5kIGNhbiBiZSBjb21iaW5lZC4gVGhlIGRl
ZmluaXRpb25zIGFyZSBmb3VuZCBpbg0KPiBpbmNsdWRlL2xpbnV4L3N1bnJwYy9nc3NfZXJyLmg6
DQo+IA0KPiBUbyB3aXQ6DQo+IA0KPiAxMTYgLyogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCj4gMTE3
ICAqIFJvdXRpbmUgZXJyb3JzOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgDQo+IDExOCAgKi8gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0K
PiAxMTkgI2RlZmluZSBHU1NfU19CQURfTUVDSCAoKChPTV91aW50MzIpIDF1bCkgPDwgR1NTX0Nf
Uk9VVElORV9FUlJPUl9PRkZTRVQpICAgICAgICANCj4gMTIwICNkZWZpbmUgR1NTX1NfQkFEX05B
TUUgKCgoT01fdWludDMyKSAydWwpIDw8IEdTU19DX1JPVVRJTkVfRVJST1JfT0ZGU0VUKSAgDQo+
IA0KPiAuLi4uDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

