Return-Path: <linux-nfs+bounces-21453-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NZGNUJp/2nQ6AAAu9opvQ
	(envelope-from <linux-nfs+bounces-21453-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 09 May 2026 19:05:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 563865009F6
	for <lists+linux-nfs@lfdr.de>; Sat, 09 May 2026 19:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4849E300F14E
	for <lists+linux-nfs@lfdr.de>; Sat,  9 May 2026 17:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FB139D6E6;
	Sat,  9 May 2026 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mZ43no2j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sgXD1NrF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D513BBA07;
	Sat,  9 May 2026 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778346293; cv=fail; b=i8efs1PxdSXXG1v9xDxO8KyXIQn2VWbtaViPXOhMdrPoGuNxRxQsqCH2NG8a/rQ5W/Ltne9vuvGnotksSzp+ViBE5rjiDe7JOh6ecfJcpZteFgHksaOWbrGsk5sgSvFu7xPjFdL+z+UJS0oJYXk3q+xK1U8vislpYbhuoU7PXMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778346293; c=relaxed/simple;
	bh=N+wgT+A11j1KXIbc1fMk91wNT2RUdouk2dNJN2nCbE4=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=pxolRTqAX8V1sWO2FPCSGb8BQpB8qxCQ1zOuR5ADhtZIXXYdDs3Z4KPVw8pQD615dtDnh/zGdygabGmCyue/9knRK3JjepUfGwmv0BjCHXAVdkpxL2048gaVi/LycQdvaEPfi38PnyRheicWsSWrFlELrmXU1GshKV8TBjMEm9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mZ43no2j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sgXD1NrF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 649GDHfN3028644;
	Sat, 9 May 2026 17:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=3A7LFOfiHiWZGwzL
	lLIb5dIiPS/JPaRCNS86cwh0cPQ=; b=mZ43no2jwKxaZHsURElNXx7Cnr1C2HGr
	n5n2zhHo5V4p5H6SlrWFtX9Wmq9lvO7AohnWnF2Wx+WJHEIxWGNQkvUIZ9hRYQNC
	TEWX0DKQjrwLO1Ah9PrzxAGJX1FSuBmp/gU3ZQbwwCEcYCdjW+jRP1m4Kehte82O
	wn4y+EeUi6+UrRSz9yrFe8awMVlpSjMYgBsJ6eQe+yWa1JXd37lXrbClqp4J50UK
	WdIMEwRAKCnH6V9eNYeb8fKqcRQ9PJVJSernTJ8KdB/S7HjNigZAwiUxMMOX+JB2
	d6JALy9szWZ50OYSXhqnZiw3AHcdIuAlEi1hqY9OhRgtmVC1ht5xeg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e1vhs0ax7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 May 2026 17:04:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 649H1LtF022003;
	Sat, 9 May 2026 17:04:46 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e1uc6qyrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 May 2026 17:04:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJHohwyTZj91ITz7qOeUrGgHtw0fZ8RBU1E9K9UmLM4tJ6fH3WqIgsBPIjZOIzAA0pklMj5O7D8H36vg09Kwlo97PDVtOXfKTrtv+/vB9dkGd1wkm6UNkJYG+KyE7POjD1ZjhiArNoF4Uk5BR/sE7qhpPJ0wAmUgDtSfov1flHY3IyUKk6wwQ20l/kRDagGdr0cmmqPod+CbPxNNKij9eAkYQHrNQB7cgNOMqAdqXT3GdNQSz1RkLPqzwpZArZZcLfc8DKEXWkfRXNuX2SHU8RSHBcq5KbPuKSiBzYzsQkVV4HUP+djbFPD7M5ZSvvMMW+8xLWASZC9ebzlY4dLPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A7LFOfiHiWZGwzLlLIb5dIiPS/JPaRCNS86cwh0cPQ=;
 b=N7wCvjIU0HhqeBxIXyAHuqRu1TQ17GCci0vSheZwH1smVMaKEUYTTl2MDw9Eb6C7tLQnycW/AKL9xJWgbo8URtQYo4cY58a1h1pYt+D662GY3r3cmuUYPrTSEYBpzIYM6A5VK5OmlMuzlrvC1uGhhcXctPEpTUvXUPlyx/tnFND4+zWKT17o2H6dp9xSZiPIHCv3W3iOF2yQNlJBvQM7eX+om6HvaBPniQkxsJG7aVIbvTbCi+IASYcwjV5v3xLur4lx1iMrPy4d9VDheCUhtZvan8/TkUC+Py46rcCaJtRI6rJrIZKUHxinjttfH73G/ss4QsbhJMtP/AZJh/hMGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A7LFOfiHiWZGwzLlLIb5dIiPS/JPaRCNS86cwh0cPQ=;
 b=sgXD1NrFu4ITSPN7M7FAJIFdHwidR39eMW3COmiByA/TdEtygUY6tCqaUZEMgoLp1tVcUJydGXvIsvRkCJQhVatNEp82E/rONG8hcc2dwUMGo/OLCranG0sD3PHKNkKckmTqo99Skh0pS+3ywwY9Nsu4wIllRtTvlui5m1rH7PQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5739.namprd10.prod.outlook.com (2603:10b6:303:19c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sat, 9 May
 2026 17:04:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%3]) with mapi id 15.20.9891.020; Sat, 9 May 2026
 17:04:43 +0000
Message-ID: <f44ebcff-446a-4582-82af-5f206bb0823a@oracle.com>
Date: Sat, 9 May 2026 13:04:41 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
To: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Subject: [ANNOUNCE] ktls 1.4.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:610:58::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: c66a7d62-9389-44de-58d3-08deaded1075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	s0Ii2EaeG+BaecSmAfgZR9nJ/FId2tHNVPoBesIKroDgLfZvUv3zh48ni+Pi1yPR7IzZIfg+WnEntJtJroo+o6mgfrV9qgRuvMuh5HjT+QJLomukY/inprUvw3PRFXtQtL3jMpzc9HkALooR6kwpB1v4uO9zKIvCRRn/ZycSm/WrEKYbGO/xwzJ0PCIrv7/Y4Bsvcius4U86JRNq12ND20mn3gmflEQZMljYgKmgJfzeas6ckeajd1FjtSSubtcKa7DeQh2BT4MhNmBz4gwVNkJPg8U+kyP8tKjUvi0eXy93JfjHGu2yS8ePDN1h4vXpA3KUUrIkZ8j569NppzxUb6dHhKoZz4CJILIU8gsi+go7bn262tv0DJQWqO4CK5XJlfZ/f1DQSL6rEVOydZTfGXt/GbOdCmpn/PhdlTL8Dwcz4qNdStzDbme4j4UHfzNbwnwtGDwOHETr9K0TpXsq9Qc5RUNfbajeJRWYqangBlip+8Sxd5HfQfZ5T4VaUvSn+Sw/pfxLDd7d0C0OHc0rnqF83Bu59bN5QmAniff1MZYdLaE6OKyexrsK/G+RvwAbPflcaDCzP4zUT0T0sMxDoH0L6vJxTPlLB4OPCrpYHG9MP5i0KKAbTQ5hMo1/Ug1dWN8YlLt78ufAbUyEkB/XrQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aThlcEVBNEc4NjRWeDlGL2h5OGUrSG9mc3RITHBpNXVXdU1sd3ZHaEZxczdo?=
 =?utf-8?B?UWZBb2NLeFRRN21lenJjU3lEU2V5aTNacmw3NlBzYnNyb21scnpmYmo1ZTkz?=
 =?utf-8?B?OWs5bTVvNHNZNlRPQlNXM2FFNXJ1eDY5NGc1aSticTBSZml1WmhCSjZDVVRM?=
 =?utf-8?B?cWJvQmN5b2xybUNMQnNOdk9YQ3V0L2tXYkptTnpFQTdKSi9DQlloZnhQanJp?=
 =?utf-8?B?YjcwNEFRVnF6M2Zhekd4cTZya1kvMVlpQkorTnRzL0RVUHlDZWtpSktlTExU?=
 =?utf-8?B?bzRRK1hPeS81K2t0cUhaQXMvdHRrcCt6VHNtMmwzQklMUUtuYTFPUmlGQlBW?=
 =?utf-8?B?WlBCT0FXc04yWWpMTjBxNnUxZ0REZUF5Zk1iODBnekE1eE9senF6MUkwQ29K?=
 =?utf-8?B?c2ZqblIrU0k5bDh6T3hxL2xOUEJEOFkvRDFyOUV6L1dCZUJ6bjhuZlVTWS9T?=
 =?utf-8?B?WU0yaXJqV0JoakNVNlRDM3Qrbm1GdXBCanI1U0Z5UHQ0VUwvUk5ENnBaWjJZ?=
 =?utf-8?B?TmNxUnNiWFNoaFFrTkdMWnVEV2pKcEdWckVQYkVwejl6QlNCTDBkZkpjQ2dv?=
 =?utf-8?B?L0Z2dzFwVnkwN29Ia0V2S25oVm8ycGxxVnlyRWhTRFZuRXdXQko1MFMvL3lM?=
 =?utf-8?B?bnNKUEdIcTdPcEsxaHBpVGRoeWpYVEMzRis3UjIwU2lCTGNlcDhIK1hKVEdJ?=
 =?utf-8?B?WEllRmphRmlLZDdzTC81ejRGRzVyajRucmNHVUdiczFKUEQwVGxZQWl1azRG?=
 =?utf-8?B?YTdIM01OajRQWThMLzlLM0tnYnQxdzF0dlNtNW5WNVVUVVlDQ0lTWVJxajVL?=
 =?utf-8?B?NjRLZVorWXExU2ZjOCtuUCs5OThYd3g0ekVnU2Q2UEI4THBuQkYxeGFkb0Fh?=
 =?utf-8?B?NHl2a3ZxQUxPTDZuN245RmlWMlYydTNOcDR1UzlBMzF1eHRSTW1vRExTd291?=
 =?utf-8?B?WEE3REdmL2NpY2VKSGFnYzU1cHpjWXh1Rzk0dEM1RVhFM1pXTm94blo4QXdW?=
 =?utf-8?B?bGRHVWVjSkZXT28xdmlLUTBTMXpJelJvRlk0REtmSVQ3TmE2cWxZbTBpVS9o?=
 =?utf-8?B?aklUaThrS2JMclh6OTh0SWFuTkpmV0M2MFZGS09TVG9xOXR1NEFyK3lGOGdJ?=
 =?utf-8?B?U0UrTTd6Q2ZBMEw1RzJsNFN5UFBVbzFqd1VuTFpDRTU0c1NqOVA1UDNiWWxx?=
 =?utf-8?B?dlRsajZFY05ES3VFZEJvM0d1cXNqR0x2TEQ0MjFyYVBsQjlTNCt2akplWk9k?=
 =?utf-8?B?MjNydzZETklaU0UzYkZqendwcTV2V0lFQjE0ZDJueUdwdnJwb21QR0UxTlFx?=
 =?utf-8?B?Wm1WUWhndWQ0emg5ckVIVmVYQ2dlUWlpVzBHUmo4RDh2bnlNY3l2bjJUUTl6?=
 =?utf-8?B?UUdWWXQ4WjBCdlhlZG5MWEFpQmN3OGhxbmRjTkVwWmg3REpxT2t6MEliVW1n?=
 =?utf-8?B?bGJSNXkvb2R1QXMzOTU3eS9xK2ZENXBna3BrSWdTZW5FcmJ3MTVwSVhxSXF2?=
 =?utf-8?B?NEVEY3ZGRzlIM0N5eGxHbk1QYktwZENPRG5GaWFRdjFxY3JFbmYyci9iVzEy?=
 =?utf-8?B?eXJncWRlQWJ1bmVzSSt5QTE4SEJZMTJTSWZ4cEhHMVFTbThSQWtlZU1CSEpM?=
 =?utf-8?B?RmI0MjJHU2dPME41WVRRM1kyUjlzbzRlbmFJNkcyWUgxR053NkxiSVZnYjZE?=
 =?utf-8?B?MFdGMjhERWs5ajJBNUdkb2NMMzEzb2IzY2prTko5VE85V0lTU3YvR0gvTTJE?=
 =?utf-8?B?VHVNd2g2cWxyZzRxTFhlaWs0OFNVQ1RXU0Y1aW1FYUVsZDkvZjk0VnBrb1pO?=
 =?utf-8?B?L1VZQkdQZTZYR1QyTCtpbVVGYzNoOFZLWW8yR3c5RHlBQXMvek9ESS9vTGFP?=
 =?utf-8?B?ZUplaUVQcTdrcW5QZ2JRY2REZEpLbEVKaWhwQWoya083RDNKNmZYK2thV1Vj?=
 =?utf-8?B?MGRFN0tWdFBuc2hkTUdqRkhtMHpGN0hwbmtLZDhCUDFxdzNNTEhaTFlENndR?=
 =?utf-8?B?cURKQy9hL2JRK0VSSC95N1lHdXNDbUFoRDJrcVZKdXRGaHFwa1VaK25MaExs?=
 =?utf-8?B?UXMzVUt5KzJNRUMxUVRuQWk3WWwvbzMzOTNvc1k3dEVGMkFVV2RHOXRIbXFp?=
 =?utf-8?B?eDZyUmFzc1hOSytmcHcvTFBURWtoR3A5UVlLUEhlZmVqVDhBVUhTNXhnSHN2?=
 =?utf-8?B?OFg2VUp2cGt5aWlFKzljd1ZDRHZsYWgwbERMMk1BZTlBWUdOK1g4OXJ6YmhC?=
 =?utf-8?B?MDRTQmRwSlN5Sk5xSHJtNWFleEFxanZQSHU4K05vWEMvYlZoSjZSMDNyR3po?=
 =?utf-8?B?MHByejgxQVBtNy9hUXBVMXQ5aWg5SzVzcDdENnc4SW9hUHpQZlY4Zz09?=
X-Exchange-RoutingPolicyChecked:
	bLpBBzZMcv4d6Oz3PVvf+qOTfdlNmEi7Fe47Z9z17Fxkpdq0X0yWgasiNSV5J7gr0UDtpffCeyU1xfEBGAFE3nUxy5gxAQBsZTRSWaMjKPl/Y3m8Y7ZGUazHHEGNlw7Y0dmn+VUQ6lS4pUxTKMrGkfh2r5tvW+8uJ2PBTv9+UUxpj/zbPMb8rgUcs5Ro/uSpzyVT2JRKoq7P0exR0C8yc1BNYjS5T+dbAi0tvvsauH/5eIMYOryjyHXRgEeWDlHApyFJssgWzw2ZcnxiweHAONhixD/2UjEe+pNAERAkUSSk0uf2OSg6M/r94OA30euxbp/Layen6DHeTyNmiVXF+Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7IFgZtrWUP6KVfLeAink6JS1tOkOXTivN7OPB+psAf4fRah3V2wGHWOEcLFF3uW17nw8HGzYOrT88UdrSqF0u51GmxTeOW0wRAGS7ytUTumAK+GT46h0Vw9nFW/PIXIDBsPYVEuvUKbrjHzzOeccWu0NONFUvczJvWFmEdxjnXstm3jzt0lf7p6TIBorDVkSIGODcElBT1c2l3lWu5Pzt3x1iKPKRhnukNXF15Is2nSKEzVQEiUOQ6anWEI1jLnvD/CL27hfZKDQQtk3qPUkzB/yO5lZd7D7L4qfFW/Zn8cAA0sogIXrD4Td893WN0I1KlHuF3cwUTmxSEUGeQL3LAiM6MV1EFrBf5sNkeDImNg871sd0ltSvS+xbLXAo1m08H9kbciNyu/8AqHZ3e5chbHK/o4ViYQ0AzEbEfJodtuEB5YsM4QJQu7EcC4/wK7yVwKfwmfXhHbKCVPdcJI3Nn2cKZrzcGsSAa01tFsJjkashenOP/Kk3K9J/2A3HDA1bsZ6UwTCZMm0tnAmX8AfbjhSmVLfZknTM7gmZ+ypkVB5ov5aBVWDoXjKRdm0t2UIcGH9Rme/12QJ7jvJ+gqwQxmVXTj4T/F63jZTNP/96wU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66a7d62-9389-44de-58d3-08deaded1075
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 17:04:42.9988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfW9UzymPJzYlj2AllGKzyPolLpQigA6xpoX2FDGIp4tuLYub8ucYOfaUPt1cW0v+EkQbTjEKGFfOVWwgKjj8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5739
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605090185
X-Authority-Analysis: v=2.4 cv=EKQ2FVZC c=1 sm=1 tr=0 ts=69ff692f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=NEAV23lmAAAA:8
 a=cMSsWa0dAAAA:20 a=fL_pwJrYTMJrOwfy3iEA:9 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: iMxDoztgQQoFe2GjvxTzfbxwoIKRw4pV
X-Proofpoint-ORIG-GUID: iMxDoztgQQoFe2GjvxTzfbxwoIKRw4pV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDE4NSBTYWx0ZWRfX0Z0UD9mxrShY
 OaK0sPqpG6Zn5CQTMbCW6eps/Vj3k0FtmkHNg/vWZcJ8NaWD77LSSVdRMEWu8SUicDOYY9Zd5JB
 172cXR8B1eFL/SWT7frkeiM3f5p0jgmuAAK0T+90v8EUmfCQEzEHAkyrbMSHRP3xQYKXwUu98bO
 y8LOn2AC/FNmOfiSU68270YJoa07dcfLdr8rdBVXHMOLL+zJQRRp17GEKen50urroh8fbE+nzwu
 4ngn1/t+H2OiyTdB+XbLMjJyCIAH4ZhZY3r+BrxgjX1VA4XOFhTt++f4dptAA+D6QcWYP37E00Q
 mZ0f0zM61gsh2DmIlSms1SHgUCauzHShafj73EgNf/UpUHIY/jXoJHfbUywp4JWksf8rwiDUyI+
 Yd5IZmo0uFBmcrJ3MNPigRf3QCE8tXuVLOd+0L4Xm3V1mumrs/k5uZExPKGh1uzEBxsWMCMBJWf
 xeo1BSSpg0fC2+AI7HA==
X-Rspamd-Queue-Id: 563865009F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-21453-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

This email announces the official release of ktls-utils 1.4.0.

The 1.4.0 release contains an implementation of tlshd support for TLS
record size limits, QUIC session tickets, and TLS session tags. It also
adds kernel capability detection and the ability to reload the tlshd
config file without restarting the daemon.

Work on other new features is ongoing.


Official source code repo:

https://github.com/oracle/ktls-utils/


Release tag:

ktls-utils-1.4.0


Release artifacts:

A source tarball created automatically by GitHub:

https://github.com/oracle/ktls-utils/archive/refs/tags/ktls-utils-1.4.0.tar.gz

A source tarball created with "make dist":

https://github.com/oracle/ktls-utils/releases/download/ktls-utils-1.4.0/ktls-utils-1.4.0.tar.gz


Issues and requests for enhancement:

https://github.com/oracle/ktls-utils/issues

-- 
Chuck Lever


