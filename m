Return-Path: <linux-nfs+bounces-4379-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F8091C145
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 16:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165CF1C2356A
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109B11C006C;
	Fri, 28 Jun 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gp/3OK3W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="smYMVIdU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3101C006B
	for <linux-nfs@vger.kernel.org>; Fri, 28 Jun 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585626; cv=fail; b=bqONsTx7wW0I/B8a/3sL5vjYlqg7LcpaisqI6gcDjjIr/pWpThNVCmmGpRlTjjP5iSUaOGE66SixmlAmCQp9eZin4eWrM443k5kWaPf9xWspFoOAdMW6LD0pJIJc8WldOyx8b4yGO9hEz1M2zv7XHNLXYVh5u0l/9blnwvbhl/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585626; c=relaxed/simple;
	bh=dCWOe6RvbDxEMyEZvSaNI8qcIqoy5zG6bm0ImR6UOs0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BFa0aBjlKgYPSxtR5yP/HaWOrd4t0uZOhI7sNyjkRVqfjRUa9MzawYoxMRZAvkTd7+vhzrf/87ADy5kxZ5bRLWVKobfvLeBEcyL/haCcdTRHjljGypZTD42+aLphcOISOHmav0Sh/Op55DxEvhuQGjn7PqpnVZ3Ex8ZTwx+g6p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gp/3OK3W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=smYMVIdU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S8MUJu009172;
	Fri, 28 Jun 2024 14:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=dCWOe6RvbDxEMyEZvSaNI8qcIqoy5zG6bm0ImR6UO
	s0=; b=Gp/3OK3WILSj692ACN6tiD8e6yb9C+exfPZrOe0p3jmLch0SrU8t4khgf
	j9GeY304LaPDcOmn5ldVRnztAmN6ZEU8en7uasqDNUnYxZ2oqV/ORCS7NMHWzJaL
	snpVRpLM4WtAcs9TM0XXTT/5W8fSI71e4uZpyVzKp8SG834w4+CFtk3P/x/7keOV
	yx4+kKmz1l68f5eiRuYFzZDb1GELe8fZ4z5FJNnc/msbFOJCPFE6bBBkM7WTzcDn
	U/AkyINJcgwkQWzxozFYVLPv1aq3rt0jClxtyBVbPnxWYyTEEJZ63G3FPrbmxCOs
	O7UNiLHBDfXA1HufL5l11eMaOy8+Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7srbpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 14:40:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45SEPfHN037037;
	Fri, 28 Jun 2024 14:40:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2ch6f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 14:40:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLwiX1xWeG8Neo9fhDYfUy9Ko8TxKWCG9xlcMJt9Fqbs1i1VCLKOcMFIfYrvrr58X40kx+wfNvhAmD8annh6boZPT3DP1/XUOse+q7UREbmiPSAbDw9GgEUa/Wt399EqySVzuylPQ4WTg88cdeBtLbjGOe5X7PDmSRIbpKs7dGSWNeNnK36IIzMy+fv61wAkZbfgvZ72m1dn5+i3px2jlUso8kYpuBE5VhFQhbT2NTr4qIs8plhNwFIq9bZgUyaz5kLFAjliJEzW1aM8ZPKW18J9K53g+Eqf0UkHs5nBeoTxkhSddoJ/xaIUJa1etuRDYphi9Zq86RQZh6b29VgJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCWOe6RvbDxEMyEZvSaNI8qcIqoy5zG6bm0ImR6UOs0=;
 b=CkNOiuDd9c9af7dT2uYTdVlDFL/Eg08FEXBX1exjyDwFV2FbsFfvNQ3Qj77LN4h1GJTtZTY8joHuTVcc+Mpeo4TnUHN0ri54UQOJL1YFlxfHWJc/Z5G7IStY86Lk8jk+jJzCvKiPc+2FYnEPzMmrPqa4iMF4ENbm/mHtqugw7cpiV5nXfzi/yZzcJBdtAjq04YWckHSk9wv1ChfjngGDb9dGYY9KOzP1v9TKI1Uot6WTvg8IB+HZB32iwam/PSF2NkZCKKrpBnirInouc1+b4hzgHJkjZ6Vs3Us5DvO0ZOTec5DDNid8K0WTfAMZh8LgzwvEgQwG91ROnf3sUZQcyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCWOe6RvbDxEMyEZvSaNI8qcIqoy5zG6bm0ImR6UOs0=;
 b=smYMVIdUBnvdyCAsAsduUAkzxQyVPH/wT4MntYF5CZO5KBlm4WW59SYQo6+suBDe27Ymhcyc1neB02P2JInHlD4DcI7JY3X1eDej6BNHVutpIIurdrFFBBzmgBcf/t8r3ss18dlEtVadmbpxjGsJ9+eKGFkssA/nEv8ucUADoRM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA6PR10MB8015.namprd10.prod.outlook.com (2603:10b6:806:438::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 14:40:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 14:40:12 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Linux
 NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust
	<trondmy@hammerspace.com>,
        "snitzer@hammerspace.com"
	<snitzer@hammerspace.com>
Subject: Re: [PATCH v8 07/18] nfsd: add "localio" support
Thread-Topic: [PATCH v8 07/18] nfsd: add "localio" support
Thread-Index: 
 AQHax/Yk8qbCJnBvfEikS8P31EOgBbHbwuSAgAAFSICAABaDgIAABngAgACjS4CAALm+gA==
Date: Fri, 28 Jun 2024 14:40:12 +0000
Message-ID: <5562AF19-2576-4C24-A598-C46409F54159@oracle.com>
References: <639F4CEB-04FD-44D1-A781-06D3223B01B2@oracle.com>
 <171954571368.16071.11625198645464096617@noble.neil.brown.name>
In-Reply-To: <171954571368.16071.11625198645464096617@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA6PR10MB8015:EE_
x-ms-office365-filtering-correlation-id: f9bf04c8-42ae-4dc8-eb6d-08dc9780379e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UUxLdXAxLzFQMkg2VE1pa2l6em5wL09ad202YldLYnhyUEhiM1lZRktub1F5?=
 =?utf-8?B?UEpkaXJKNThCUHZ1N1VKWHhhSmlOeVRjS3Jmd0Excnc2WkZFTTFmMEdLWktj?=
 =?utf-8?B?b1dSMVcvVHRrdUtTR25JMVBDbVFLK2dWNHpkT2hCNzdqcXJ6cWVBWGJYdTF5?=
 =?utf-8?B?dXByM25FZHlQTmtUR21GMUpIMHVnVE5Cc1J4cFQrZjV2dGp5OTlRc0JXcjNn?=
 =?utf-8?B?TFVSZUxxRVRabzlBc1RUd1ZjVXRBbTc1M0RnVmpZT0xhKzNFOU11NldVNzdY?=
 =?utf-8?B?K3lZZGl4TjgrT09RV0pvaTlOTkZQeGlGdytRUkJ1cU9ZcEtiT3ZXcGU1enVv?=
 =?utf-8?B?anpFVWQxb1dsZkJwNWJueHRDak80S2FQaFBSRk1EVGw1OWxMQ1FiekhXcVJI?=
 =?utf-8?B?cU9lQjZ3NzRGd1cvNGNGdldxK3YzNU1JZ2dQdW1SSlBtbTZmNE5pSVRaMzV0?=
 =?utf-8?B?TmZlRVZaRE5iMWZqMi9qbWFPeXg4OEd1TXpwZTEybkFQN2E3TXpEelpldVhL?=
 =?utf-8?B?WXZ3MUF5WjZyeEZXWVUwVjMzN3ljNHhsYkxPb1RhTmVISzBlZEpZRHI1Nzhh?=
 =?utf-8?B?M3lKZ3VQWkIzc3laYUhJZStpenRQSUVhQVl3MlBEYWsyTHNIWHB1RnF6UnFn?=
 =?utf-8?B?VGFSOUdub1NKa2RDWHNBWnQwMjlBc0lJbXE5YlNTU09yQm84WExvdnpwa0JY?=
 =?utf-8?B?dDhQSUlyamtrK2MwRUNpRmorOFlzanZoZjlOTnh3UzFEWDBBdExXcitxK0Jh?=
 =?utf-8?B?am80eW1XZWJUMEExVlB3eVhtVHoyejh2OWpoejRFSTZhaUEvZmhoQ1k5VllX?=
 =?utf-8?B?dGVsYXZHdXY5VWxXZllWMWMrWFE1UTBwQjBoUkJnYWkvMHNhNHVPUUZudDBB?=
 =?utf-8?B?bXVQMDFyM0xPbTFNZmVydTlFRTFnUGxzSWwxUVhWMloxOEtDRVpvcVk1QnJ2?=
 =?utf-8?B?MUtXaEJSNUZVTFk2OTBzY3JMcFNLWGxIWUM4U2hQYzNXSjdkVFFQTXFEcXZI?=
 =?utf-8?B?ZzNLT1RubGVRdVphcDZLQllGRENwWjJMRUdxY0dxLzAzOUJrUTZkTWZBT1hk?=
 =?utf-8?B?cTQ5NWZkM21NLzlrRW9STmxmZndENnpKVGJQNXBiZmRJNUEzUTNJSG45YXpi?=
 =?utf-8?B?TE9qcjdYTmkxbkNQM3FYTkdnQVNwaVhPZnh3SSs2YWZ4c2Rid05semZ0YVIz?=
 =?utf-8?B?b21nRzljZExheUdqWmRuV2QwSjRzZC8xNzlWZDdNdHdnbGVUaE9sY0VUUHVw?=
 =?utf-8?B?cVd6RjRNdDdlcnJybmRXMlpoaFJOWElsb2JnbS9wNVVJbFEwNXlGUHBhekZU?=
 =?utf-8?B?WDlqMlBiTVh0RWJkL3dRa3NiaFV5b1JZY2NSaVhWRkJhWVlKTGRhdVAwemZ4?=
 =?utf-8?B?Sk9WdDgveXI4THV4T3RFTVgvUDlOUU1DZUFwQTBGbkJKbGJKOTRpUllaWnU0?=
 =?utf-8?B?UXI1bkgvK1ZEZGtNSnR0VmFzZ2FUZm50aWFPUDhMd0REQjFkbjJmSnYrU09J?=
 =?utf-8?B?cWdnTGZyUFRoTndnb3F1VVBoSDFIUzhiWHdvREpUbllvWE1mTjI5VjdCTGph?=
 =?utf-8?B?WVNkU1M0MG1FbG9jTEhyY2w2L0xrdUZoK2FEME9qTjcrenA5WGIzTmlQTUZS?=
 =?utf-8?B?bFNrdEFyT1JRbnVQaW82MWQzUWgrWHg1QnIrb0Q0ZkpmbloxZnVZNjQwaXRC?=
 =?utf-8?B?eWZWbkxRN1k3aEcvM3lsdkgwS01FczFBL0dyTWNMNW5BOHFVMDRrWk1Daytx?=
 =?utf-8?B?N0NCS0UyR1F1NXYzaytjaThjVlBid0piNmtvbUFlTE1LWjdHNkI0eVQwU3ox?=
 =?utf-8?B?a3lPMSt4NGRHbTFNaWw5ZmZ3TkVlbks4bVlwVjNtTnVXN0hRWFowcVdFam1p?=
 =?utf-8?B?TlMzZG5xMFkzcjA4ZU54bnNjV1NIanBNd3A1M0Y4Nnp5Vnc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bzFCdDRTSC9DYmo5LzRmMFNUeUU3THhleS9EV3NtQlNWMklReWg5WFl4N0lN?=
 =?utf-8?B?OTNxOHg3Y3BpTGp2Q05HNHFVTkUzVFhBSXU1ZFZRcDhQWEJvQXArQVB5NEhl?=
 =?utf-8?B?bzBFRlZSZVRoMVY2Qlo4OXhTUnA0TjlrL05DYUxxWnl4T01qV0JVaitieUtu?=
 =?utf-8?B?M0hrV0hXbnoyWjFNdjJlcXFFMmdXL1h1TDdRamVHME1XOCtqM2dQckppdGc5?=
 =?utf-8?B?c1l3eDlrQ2hqWVpzY29yb0I5emZ0QkloNkpMMzFOeVlJMWxjUjdhQ3pLRWpy?=
 =?utf-8?B?b1dtaUZZeDFhRzVPR1ZTNnVIdTdCemlma0k1VGJiYUxZT2h3V1MvZVJRcFpN?=
 =?utf-8?B?NWtldU5JdDVGTGNCZGN2MVFJbE1nNEY0dmtwbmNNaHhLVUZqZDVpRDdEK3do?=
 =?utf-8?B?dkpsRFNKUS9YRnNiM1pFUmEwckJCTmljWFo3SmVPUjFkNG9palY3ZzMvNGE5?=
 =?utf-8?B?QlhFa0RpYnVIQmJxelVuallRWUkvNlZ1aWlOVG9BdlFlWUYwa1pTZUVDRTFm?=
 =?utf-8?B?cGhKUlIzTjMxdHZqNzljU1VjWXdGVXVQN3VQVytCQnROS2dKVFJwNW1jRUJt?=
 =?utf-8?B?MkFmb3g0S1JXc3BKbm1TVlQyWkpMT2daejVKTkNWcE52SVB0T2pkak9GT1pM?=
 =?utf-8?B?Yk1ucWpWWjRwQkNpS1NYT0g1dVBOQzlmL1l6NWZWNmcwQVBDeGZrTVRiL3ha?=
 =?utf-8?B?WUR5Q1RNZlp2d0d6K0xtenA2TCt4eHhDRE4rUWhnL3hSQ2NqaXRMdExCbzFV?=
 =?utf-8?B?UlQyWXNNalIrdTBjNWNKa2s0QnNxNHFzNTJKKzJJV1U2dVlEeVZobnNvNVha?=
 =?utf-8?B?K0Z2RWZFcmxVeXhZNTFEQUhCa3ZoT3RvS1pWS3J4VXVsR1BhS0Y2WFVKQmwv?=
 =?utf-8?B?NDRPTUFFRGtFbWxhMENTTjBDRjVTb0VVSUh6S1A0T0FteUZsTzVvajZ4ckdB?=
 =?utf-8?B?SmhwSkNuanlUTlpFRFl4SDhmRXZndzY4cmgrUnF4aFMxdk5GdTdCUk9jaisx?=
 =?utf-8?B?UE5nRk8vUXVnZ3BYWHNnVjNsUXRpTWFzR1pmUUdnSVB6TVR3ZElMM0FYd3E1?=
 =?utf-8?B?anJqdXVSOVppanBLa1BralQvRVhYY3MvSlY2VkJ5WlV0SWJiV0RCTkwzaXJZ?=
 =?utf-8?B?VzRsK2lJRXkzbnBwWVlZVUpBbXNndm9INkROakh5R25oRnBXMkFha3JQeHAz?=
 =?utf-8?B?NFJHeGp5di9rd1BYNGNMbGxkMDdKcEVVMWNLWEJiUW8rYzcyZHVVQ0Z6NFI1?=
 =?utf-8?B?bDFZSkFpc01OOHRka0F0OHg2V3dZdUF5U2pNUDRPaDIvd3FFVFhzTm0ybVM4?=
 =?utf-8?B?ZmVuaXNvTUFpSEV4NlFlUUZBUEZCWUpieEVzMGg3TGxRN0JHTExmY1BDYmh3?=
 =?utf-8?B?MzZiU3JFUjVTZWZnbFJCYm54MUZYZkxPM0hHTitSMEswelhjVVNHY1hJMGRz?=
 =?utf-8?B?Z0RyYVdGVVZaYUtTa2hFOXo1L1gyN2FiU1ZDSTJrN20vdTVJenNkNWN6WWt3?=
 =?utf-8?B?RzZsckFvUUFPeTgza25YRkF6OHd5VnFUMTdRb2VQaUVQaHlCK0I4ZzBNY2R5?=
 =?utf-8?B?c3c1R09Uelo5ZUsrbitaYzAra21vNGtUTCtxQzhwRVREaGZXeDREbndYcmZj?=
 =?utf-8?B?VVhtdnlueFZmZEtqY2dKSWNwbjJLamovVTQxRkFlSWwxOWVxV2dkZXlXOXNw?=
 =?utf-8?B?WVQzbWxSb2trTVlQaXF4dnBrazlrdVdaRWl0Y0dYMDBKTkVXNVVqQ2U0cUhB?=
 =?utf-8?B?aWRGY0VRVElUMmg0OGU5NU5sbUxMVzQ5TjB0ZmRraHRsRlFEcUUxSi8xWUdO?=
 =?utf-8?B?dCs0U0pmR2NSMVNTQ0FBT1o3a0JNRVFJZEt4VW01OStPNXNheFJ3QjBNZlZs?=
 =?utf-8?B?N1RBKy9uQ1JkVk1oZUNhaDBqODRzcGtUT05PVmVmVnpPaWVnOU1sOVBwMjMz?=
 =?utf-8?B?MEZWeUxpNEJRKzlhNTQrbThEcCt0UklEK0toaytHL0lMT2VPblk3ZVFKWFhR?=
 =?utf-8?B?SHV0Qzl2WGttSFlncmFkUXZSMmtyd0NIeG95WENad1dVZzVXWTVJRU9kTGJx?=
 =?utf-8?B?blZ3WTgwSmg2ZHBESVdCRC91Y0JsN0NCRGY0RHRvejgrYW15QTcwa1FBUnRO?=
 =?utf-8?B?ak84WXhkV1A1aHdEckxoRjdwbHBVVk1idUhLa2xUeDRhVk05aDgzYW1yOFJ1?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D1EF03C87504248881017CEE5CD7FCB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	z+8r00f6S5++Qt8aMHgSPYbqe+YQn41xQ4ulxOtPbiE8S4a1tBACMyHibECBiPBZfNCbN0uqTQu+tw21hU1Z0O7uunvEiGbi7xlxyMCiN1QcF5GV1C0UZXtau4St4n4vIEpJjO4M7wI+d2SHEnr/1HIbcVaihsI0UT8B4EeSba1mcX6G+KvzhYGtGy1PY1Ri3iqDmPKicTAPSQwz31hEofqJOeSOfuBBaIQgMY9T0u8gwl7GX7ZNoVJ/GyvZm954tkVR/1s1JrBHT38eSswEjdhdezJB2y0VTEpie8haMl5D/8p1A8rGXLeZlnZfMLYscWtFwtx4PCcTt9dQirR/DIfgZzwSKuGapaukg/0pbuIONa5Wn38lPjSrPl6G+YrGs0C2vZ5G9n3tQgdX3BHXPbTECKOYNkXUEQYpwbrsFpshWMWV1gDwvPP3nLQi3ZkBzb85X6EK8toBz7C8qVjviXjSnkvcy39YsGPX37Vb60boCa1OzNbByIssKJDUAiYwqfnV4IBMC5Uv6zdCmI846L67ErmJVgDR4wJzinRcDZe/QCWcxYM4Mfb0idrq2ClPTPE8EIKqJzfAtlDht37wLA2bE0fiEqoyle7IPoSw0YI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bf04c8-42ae-4dc8-eb6d-08dc9780379e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 14:40:12.4501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r0PqyrhdjpJI6fbLYFC2iGbFWp3BgPTdU0GBATqwF6xPKe/qEPn1qmERl/zHKAzf5+6cQpsLVwhbm0D4F+G4sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8015
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_10,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406280109
X-Proofpoint-GUID: r-pYnGhT5B_GaJtQo0MmfaxNSZZPikor
X-Proofpoint-ORIG-GUID: r-pYnGhT5B_GaJtQo0MmfaxNSZZPikor

DQo+IE9uIEp1biAyNywgMjAyNCwgYXQgMTE6MzXigK9QTSwgTmVpbEJyb3duIDxuZWlsYkBzdXNl
LmRlPiB3cm90ZToNCj4gT24gRnJpLCAyOCBKdW4gMjAyNCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3Rl
Og0KPj4gDQo+Pj4gT24gSnVuIDI3LCAyMDI0LCBhdCAxOjI34oCvUE0sIE1pa2UgU25pdHplciA8
c25pdHplckBrZXJuZWwub3JnPiB3cm90ZToNCj4+PiBPbiBUaHUsIEp1biAyNywgMjAyNCBhdCAx
MjowNzowM1BNIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4+Pj4gT24gVGh1LCBKdW4gMjcs
IDIwMjQgYXQgMTE6NDg6MDlBTSAtMDQwMCwgSmVmZiBMYXl0b24gd3JvdGU6DQo+Pj4+PiANCj4+
Pj4+IENodWNrIG1lbnRpb25lZCB0aGlzIGVhcmxpZXIsIGJ1dCBJIGRvbid0IHRoaW5rIHdlIG91
Z2h0IHRvIG1lcmdlIHRoZQ0KPj4+Pj4gZHByaW50a3MuIElmIHRoZXkncmUgdXNlZnVsIGZvciBk
ZWJ1Z2dpbmcgdGhlbiB0aGV5IHNob3VsZCBiZSB0dXJuZWQNCj4+Pj4+IGludG8gdHJhY2Vwb2lu
dHMuIFRoaXMgb25lLCBJJ2QgcHJvYmFibHkganVzdCBkcm9wLg0KPj4+PiANCj4+Pj4gUmlnaHQ7
IHRoZSBwcm9ibGVtIHdpdGggZHByaW50aygpIGlzIHRoZXkgY2FuIGNyZWF0ZSBzbyBtdWNoIGNo
YXR0ZXINCj4+Pj4gdGhhdCB0aGUgc3lzdGVtZCBqb3VybmFsIHdpbGwgYXV0b21hdGljYWxseSB0
b3NzIHRob3NlIG1lc3NhZ2VzIGFuZA0KPj4+PiB0aGV5IGFyZSBsb3N0LiBObyBkaWFnbm9zdGlj
IHZhbHVlIGluIHRoYXQuDQo+Pj4+IA0KPj4+PiBBbHNvIHlvdSBwcm9iYWJseSB3b24ndCBmaW5k
IGl0IHVzZWZ1bCBpZiBsb3RzIG9mIGRlYnVnZ2luZyBpbmZvDQo+Pj4+IGdvZXMgaW50byB0aGUg
dHJhY2UgbG9nIGJ1dCBhIGhhbmRmdWwgb2YgdGhlIHN0dWZmIHlvdSBhcmUNCj4+Pj4gbG9va2lu
ZyBmb3IgaXMgZHVtcGVkIGludG8gdGhlIHN5c3RlbSBqb3VybmFsOyB0aGUgdHdvIHVzZSBkaWZm
ZXJlbnQNCj4+Pj4gdGltZXN0YW1wcyBhbmQgc28gYXJlIHJlYWxseSBoYXJkIHRvIGxpbmUgdXAg
YWZ0ZXIgdGhlIGZhY3QuDQo+Pj4+IA0KPj4+PiBXZSdyZSB0cnlpbmcgdG8gdHJhbnNpdGlvbiBh
d2F5IGZyb20gZHByaW50aygpIGluIE5GU0QgZm9yIHRoZXNlDQo+Pj4+IHJlYXNvbnMuDQo+Pj4g
DQo+Pj4gT0ssIEkgdW5kZXJzdGFuZCB3YW50aW5nIHRvIG5vdCBhbGxvdyBuZXcgZHByaW50aygp
IHRvIGJlIGFkZGVkLg0KPj4+IA0KPj4+IE1lYW53aGlsZToNCj4+PiAkIGdyZXAgLXJpIGRwcmlu
dGsgZnMvbmZzZC8qLltjaF0gIHwgd2MgLWwNCj4+PiAgICAxODENCj4+PiANCj4+PiBTbyBJJ20g
c3RydWdnbGluZyB0byBnZXQgbW90aXZhdGVkIHRvIGNvbnZlcnQgdG8gdHJhY2Vwb2ludHMuICBG
ZWVscw0KPj4+IGxpa2UgYSBuZWVkbGVzcyBtYWtlLXdvcmsgaHVyZGxlLCB0aGVzZSBjb3VsZCBi
ZSBjb252ZXJ0ZWQgYnkgb3RoZXJzDQo+Pj4gbW9yZSBwcm9maWNpZW50IHdpdGggdHJhY2Vwb2lu
dHMgaWYvd2hlbiBuZWVkZWQuDQo+Pj4gDQo+Pj4gTWFraW5nIGV2ZXJ5b25lIGhhdmUgdG8gYmUg
cHJvZmljaWVudCBhdCBkZXZlbG9waW5nIGRlYnVnZ2luZyB2aWENCj4+PiB0cmFjZXBvaW50cyBz
ZWVtcyBtaXNwbGFjZWQgKGJ1dCBJIGFsc28gdW5kZXJzdGFuZCB0aGF0IGZvcmNpbmcgb3RoZXJz
DQo+Pj4gdG8gZmlzaCBlbmFibGVzICJvdGhlcnMiIHRvIG5vdCBiZSBkb2luZyB0aGUgY29udmVy
c2lvbiB3b3JrKS4NCj4+IA0KPj4gVHJhY2UgcG9pbnRzIGFyZSBwYXJ0IG9mIHRoZSBjb3N0IG9m
IGNvbnRyaWJ1dGluZyB0byBORlNELA0KPj4ganVzdCBsaWtlIFhEUiwgUkNVLCBsb2NrZGVwX2Fz
c2VydCwgYW5kIGRvemVucyBvZiBvdGhlcg0KPj4ga2VybmVsIGZhY2lsaXRpZXMuIE5vdCBhIGh1
cmRsZSwgYW5kIEkgZG9uJ3QgYXNrIGZvciBidXN5DQo+PiB3b3JrIGNoYW5nZXMuDQo+IA0KPiBJ
IHRoaW5rIHRyYWNlIHBvaW50cyBhcmUgcXVpdGUgZGlmZmVyZW50IGZyb20gdGhlIG90aGVyIGZh
Y2lsaXRpZXMgeW91DQo+IGhpZ2hsaWdodC4NCj4gWW91IG5lZWQgdG8ga25vdyBYRFIgYW5kIFJD
VSBldGMgdG8gZ2V0IGNvcnJlY3QgcGVyZm9ybWFudCBjb2RlLiAgSWYgeW91DQo+IGdldCBpdCB3
cm9uZywgdGhlbiB0aGUgY29kZSB3b24ndCB3b3JrIG9yIChob3BlZnVsbHkpIGEgcmV2aWV3ZXIg
d2lsbA0KPiB0ZWxsIHlvdS4NCj4gDQo+IEJ1dCB0cmFjZSBwb2ludHMgLi4uLiB3aGVuIGFuZCB3
aGVyZSBhcmUgdGhleSByZWFsbHkgdXNlZnVsPyAgVGhlIGFuc3dlcg0KPiB0byB0aGF0IHF1ZXN0
aW9uIGlzIG5vIHdoZXJlIG5lYXIgYXMgY2xlYXIgY3V0Lg0KDQpJIGRpc2FncmVlOyBzZWUgYmVs
b3cuDQoNCg0KPiBXaGlsZSBJJ20gc3VyZSB0aGV5IGNhbiBiZSB1c2VmdWwsIEkgcmFyZWx5IGZp
bmQgdGhlbSB0byBiZSBzby4gIEkndmUNCj4gY2VydGFpbmx5IGhhZCBhIGZldyBwb3NpdGl2ZSBl
eHBlcmllbmNlcywgYnV0IGFsc28gc2VlbiBhIGxvdCBvZiBub2lzZQ0KPiB0aGF0IGRvZXNuJ3Qg
cmVhbGx5IGhlbHAgbWUgd2l0aCB0aGUgcGFydGljdWxhciBiZWhhdmlvdXIgdGhhdCBJJ20NCj4g
dHJ5aW5nIHRoZSBhbmFseXNlLiAgc3lzdGVtLXRhcCBjYW4gYmUgaW5jcmVkaWJseSB1c2VmdWwg
YXMgaXQgaXMNCj4gdGFyZ2V0ZWQuICBGaXhlZCB0cmFjZSBwb2ludHMgYXJlIChmb3IgbWUpIG9u
bHkgb2NjYXNpb25hbGx5IHVzZWZ1bC4NCg0KU29tZSBvZiBPcmFjbGUncyBjdXN0b21lcnMsIGZv
ciBleGFtcGxlLCByZWZ1c2UgdG8gdXNlIG91dC1vZi1iYW5kDQpkZWJ1Z2dpbmcgZmFjaWxpdGll
cyBsaWtlIEJQRiBvciBzeXN0ZW10YXAgYmVjYXVzZSB0aGF0IHJlcXVpcmVzDQpiZXNwb2tlIGNh
c2Utc3BlY2lmaWMgY29kZSB0byBiZSB3cml0dGVuLiBUaGV5IGZlZWwgdGhhdCBlbmFibGluZw0K
YW55IGxpZ2h0bHktdGVzdGVkIGNvZGUgYXQgYSBrZXJuZWwgcHJpdmlsZWdlIGxldmVsIG9uIGhl
YXZpbHktdXNlZA0KcHJvZHVjdGlvbiBzeXN0ZW1zIGludHJvZHVjZXMgYW4gdW5hY2NlcHRhYmxl
IHJpc2sgb2YgY3Jhc2hpbmcgc3VjaA0Kc3lzdGVtcy4gKEknbSB0b2xkIGJ5IFJlZCBIYXQgc3Vw
cG9ydCBlbmdpbmVlcnMgdGhhdCB0aGV5IGhhdmUNCmhlYXJkIHRoZSBzYW1lIGNvbmNlcm5zKS4N
Cg0KZHByaW50ayBpbXBhY3RzIHRocmVhZCB0aW1pbmcgYW5kIGhhcyBhIGhlYXZ5IHBlcmZvcm1h
bmNlIHBlbmFsdHkuDQpJdCBjYW4gYWxzbyBydW4gdGhlIHJvb3QgZmlsZSBzeXN0ZW0gb3V0IG9m
IHNwYWNlLCB0aHVzIGl0J3Mgbm90DQpzb21ldGhpbmcgdGhhdCBjYW4gYmUgbGVmdCBlbmFibGVk
IGZvciBsb25nIHBlcmlvZHMgb2YgdGltZS4gSXQNCmhhcyBubyBtZWNoYW5pc21zIGZvciBkYXRh
IHJlZHVjdGlvbiBkdXJpbmcgY2FwdHVyZS4gU28gaXQncw0Kc2ltcGx5IG5vdCBhIHZpYWJsZSBw
bGF5ZXIgaW4gbW9zdCBsaXZlIGRlYnVnZ2luZyBzY2VuYXJpb3MuDQoNCklmIHlvdSBwcmVmZXIg
c3lzdGVtdGFwIG9yIEJQRiwgeW91IGFyZSBzdGlsbCBmcmVlIHRvIHVzZSB0aG9zZQ0KaW5zdGVh
ZCEgSG93ZXZlciwgYnVpbHQtaW4gdHJhY2luZyBpcyB0aGUgb25seSBjaG9pY2UgZm9yIHRoZQ0K
YWJvdmUgY2FzZXMsIGFuZCBpdCBoYXMgdG8gYmUgcGFydCBvZiB0aGUgc291cmNlIGNvZGUuDQoN
Cg0KPiBJIHRoaW5rIGl0IHdvdWxkIGJlIGdvb2QgdG8ga25vdyBpZiBsb2NhbGlvIGlzIGFjdGl2
ZSAtIG1heWJlIHNvbWV0aGluZw0KPiBpbiAvcHJvYy9zZWxmL21vdW50aW5mbyBjb3VsZCBwcm92
aWRlIHRoYXQuDQo+IEkgdGhpbmsgaXQgbWlnaHQgYmUgdXNlZnVsIHRvIGtub3cgd2hhdCBzZXJ2
ZXItdXVpZCBlYWNoIHNlcnZlciBhbmQgZWFjaA0KPiBtb3VudCB3YXMgdXNpbmcuICBUaGUgY2xp
ZW50IGNvdWxkIGFnYWluIGhhdmUgaXQgaW4NCj4gL3Byb2Mvc2VsZi9tb3VudGluZm8uICBUaGUg
c2VydmVyIC4uLiAgbWF5YmUgaW4gL3Byb2MvZnMvbmZzZC8sIG1heWJlDQo+IGF2YWlsYWJsZSBv
dmVyIG5ldGxpbmsuLi4NCg0KTmV0bGluayBpcyB3aGVyZSB3ZSBhcmUgYWRkaW5nIHN1Y2ggdGhp
bmdzIHRoZXNlIGRheXMuDQoNCg0KPiBqdXN0IGZ5aSwgdGhlIG1vc3QgdmFsdWFibGUgcGFydCBv
ZiB0aGUgZHByaW50ayBkZWJ1Z2dpbmcgaW4gbXkNCj4gZXhwZXJpZW5jZSBpcyB0aGUgcnBjX3No
b3dfdGFza3MoKSBjYWxsIHdoZW4gcnBjIGRlYnVnZ2luZyBpcyB0dXJuZWQgb24NCj4gb3Igb2Zm
LiAgVGhpcyB2aWV3IGludG8gdGhlIGN1cnJlbnQgc3RhdHVzIGNhbiBiZSB2ZXJ5IHVzZWZ1bC4N
Cg0KDQpORlNEIG5vdyBoYXMgYSBzaW1pbGFyIGZhY2lsaXR5IHZpYSBuZXRsaW5rLg0KDQpOb3Rl
IGFsc28gdGhhdCB0aGUgY2xpZW50J3MgInNob3cgdGFza3MiIG1lY2hhbmlzbSBjYW4gYWxzbyBi
ZQ0KYWNjZXNzZWQgdmlhIC9zeXMuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

