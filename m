Return-Path: <linux-nfs+bounces-8551-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CD89F0EF7
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2024 15:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75128161D20
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2024 14:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B401E009A;
	Fri, 13 Dec 2024 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H9o/f31o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wL1SdmmE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C041DF261;
	Fri, 13 Dec 2024 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734099513; cv=fail; b=fEDyaS/deSTqyXvPrD1GDOV4oSRI+mo1lKPwBeIuYkxIV0Bx2SR2afNPfSm5q+1UyAzNVnGwmTnRieYCmx9cYOHEzcfLJWkKPdGBtQCW7kBhqLVYe29aUd2VS8hgO+EbRtvo9tK3rfcn+wMW4u0k48xK9OBlW2UPVoLSA3c/gdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734099513; c=relaxed/simple;
	bh=TiuXSafZPR+DhMZSnt73PlPl18COgo1GVaYPTNkKRxk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=frr6H1rlZF9le1VBt2BZbZhqbSvvxJoKc7Ya39lF+DLaiiC/Z33mRsCGCLCMc4tuniSNW9anj2BNiIcMy3+5yuhiNFN/k4z2AqpF6pDzYPCy7xRwIo6JVIWreRVgiLNIbxNcnGl9dXijsQTuS8Ds8pB1wrJuCKAmOek4A6yYlyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H9o/f31o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wL1SdmmE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDDk9JN017439;
	Fri, 13 Dec 2024 14:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=R8/MqOf08czlY4kDyejc4YAuGtwwwKi5gkujNTkTur8=; b=
	H9o/f31o+hIA4iV214lMaKwn0aE9jQDb9GABdQq6I6Dm/03oTtTximP+EGEi09/q
	opOcDFeW5qs/Cs3ieB4o6FGtXWZwK0C4JOrr56nu89xPZTAOoSwjNkP9QOpifEae
	NyQuKWnoW2VQozlytnuTBsCFcM9q/2iOgveaMo7WSVpC99Q/2tOj7go2D1ZZoPX9
	emL3U5T2F3OGuuwOQ7UHCJx8uE/DE0VQjoOXHdbK0KYr84mtZr8g+UtXZ6zyHRac
	cwWZAvgx34cYTUBgxctjTYbVQ+WDALyd9hZWw1cJyAjYI0IKV0Wpou7WlV/mXtzE
	psQ0AbzwUgCOA4BbJpNG0g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43dx5samq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 14:18:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDCFI16034912;
	Fri, 13 Dec 2024 14:18:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctm1xxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 14:18:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ll2KLKmsR/L47GDK6hbgzDeKTajTRALeGNBdopRWY11qVk+di21BUhNciGXeeMNHdXSes+0IAQA7O7EFs3pM/Z3kbDPlVrjlBtz4pngSU87Xp0TN/8nwPNdsgVFPCNXD+riH3u73/+/EiOBT/cruzTf4SveKcT7NKgK2JThXs+gGAupGt3xJeRybhzJOpXYJzmT6bIyh2SQM2qlFBWuryNKVKfwkbSUmfJjXdya80DBep09g/O+1AVEmJFml4MBrmjaxO0S05SgLxJsRU2LtpE1KvEzu5XDatw/ou2PDHhx2DLzPWoMYHVadUZozAH7WeApgdg4H8QHmys6NDPaiOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8/MqOf08czlY4kDyejc4YAuGtwwwKi5gkujNTkTur8=;
 b=noqSjyyrUiSTD+2103bUxPkwmTVBXjtZF/u3Ij5QMxA/bwLNT640meKTCfenFdEK6b9Nj7mYGD5jup5TUICAzMp7RB35B99H5GFcK7oZmqiz5LRxco7BjL8aLm6BXES0aZSmu6C14WcmZESwpyWviK2ltXU5iWiF/f3p03aFO1xg1ZzNHpZfRlQVaimXCwJq7ktQXbMurJVxSx9NhJjDbgl5vrAorrdAsUhVBkeZUOjAtj/JIz9lAUuEx0H0LUrZJGU+a+o5P38bGIOkJU5LN0hooubGW1moGxNX4sQY7RP6Hepi7KjlxUSRGxeqyjzH84mGY3CkA2+FqyLbaAPx0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8/MqOf08czlY4kDyejc4YAuGtwwwKi5gkujNTkTur8=;
 b=wL1SdmmEER8gmor1zgNS4xXbqSoPedE+bEMZqw8dYWbMMhWL3gtZnvNDfAPdU+HgA05xC2NBIDKcpDIXS8gPXxROHXHFpYJhCTJZ/3ZQUY9kTdu2rpyy3DJ5GoEVSs1mVt+VJ0sycV024H8b9Gw9LE+CQV9ElV7FBt2ZuVv68AU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ1PR10MB6004.namprd10.prod.outlook.com (2603:10b6:a03:45d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 14:18:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 14:18:12 +0000
Message-ID: <c4835f2b-0edd-49a2-9f61-5bd7090382dc@oracle.com>
Date: Fri, 13 Dec 2024 09:18:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] nfsd: handle delegated timestamps in SETATTR
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20241209-delstid-v5-0-42308228f692@kernel.org>
 <20241209-delstid-v5-9-42308228f692@kernel.org>
 <2a3c0a1f-0213-4915-a4c0-a2ba31ae1bbc@oracle.com>
 <f697868bfa7f219d51ba8251db32b22ad942ecd7.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <f697868bfa7f219d51ba8251db32b22ad942ecd7.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ1PR10MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc6b709-a689-4993-4398-08dd1b80fa18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVVwQ2VlN3B6ci9JNEs3b3JybEM1UzU2UnRUbE10K1VSRDRLUU9wVUlROXE1?=
 =?utf-8?B?clFFdy9GSkYrcndmbjZQL2RHODhSeWZ4UWsrbXVtVlJRc1Blek5ON1hvVG9h?=
 =?utf-8?B?TElUK3g3UnA5b2JnUlgyM0pOSVpXNjdzOGQ5YURqRzBzVGpicWt2MDVENnFK?=
 =?utf-8?B?ZVZLT3FnclFMQldLZGw3QlNLanduQzJ1Vy9WNnErZS9VR1hCM2lyMlJDM3Fk?=
 =?utf-8?B?VU9wOFk4ZjVveWZYdG0rS3B1cVdGOTFXSTEvRHRWeHMvRE9zTEt4WG1CMEZW?=
 =?utf-8?B?dWVlOUFMaHVZbWNjeEQ2Mys3TFZmU2o4VUFzbU5kZDY4aFlSTlpXS3pDYkJa?=
 =?utf-8?B?WHdteG5FcGRSSjNBa0JlbXkvd0c3dVFqYVJ2eENZUXlDL2tNUzFQc1ZLOHNo?=
 =?utf-8?B?S0ZudmtyOW9VazdCZjY5QnhCVFFGNVM5ZWxtTmM3ek1WaGNuZHBrdEc1NVZu?=
 =?utf-8?B?cmtFVnEwTGZRY05YZmVPLzdPQzBIWUpoQTBHemt2NElqdmg2dFlvNnJDblBz?=
 =?utf-8?B?bFRpNFBiK0JETWtkTmpaYjJKK2F1S1BLRVl4cDd1QkwxRmFsYVI5TGIzZ25o?=
 =?utf-8?B?QUlZMmVWMnlyT2MyTDlWa09kWkxHbGdGQXZneTJsL1R5YUkybk5OM3Jibmo2?=
 =?utf-8?B?S0VGZk1NRTB0d0xhNEQ5eGwvVkJub1NLQk5WUVptUUU4UExHWHEzdS8vMjhP?=
 =?utf-8?B?NW9nT3d3cUJDRUErSGY1K016WWgzMEc3dUlzWEV4blg3bVFTb0kxUy8vR0pv?=
 =?utf-8?B?TjVuaHZXd2hYTVNYM3dzMXRoekZYTElYb0Y1M2ZXNkRheTlYZXUzYkd3UTZR?=
 =?utf-8?B?UXF6MWs4SDl1SHp4ZmFTaUtRUEJBb0Y5NUw2OWpSWng4L3RoSDRXcDdidWdU?=
 =?utf-8?B?OW9qYVhEcktHQ1hVdnV4S3BqcHo2WjRTNWljb0krYVd4N2dqbWtJMkFrM09M?=
 =?utf-8?B?NEd1RS8rMzYySVdOc1g5Q3VKSlVXQTBGWTJDVWUxMVB0aVJBcVdVWXNjVnpM?=
 =?utf-8?B?OThDcTU3anJ4Vi9IR3Q4em1QdWVtOGlZL3ZEaGFXT21mNlJTcW0rNnBpVVA2?=
 =?utf-8?B?b2dubHlJU0J4eWRCTmk3RThhWEdlYlFrMjVaRHlWaXRTWjhKNE12MFpFOXNY?=
 =?utf-8?B?QnhLZDZxNnBETXU2OVVaMTAwTGlRWm9BZHdsVk5EdkJ6aWVTQys5QjBQUVNa?=
 =?utf-8?B?NEJrNEJFYW9OUkxVbTVnVmlxeW1NeGxDcndLU3YwSCsrTGFJdVlDVUwvaWdS?=
 =?utf-8?B?UUM3bHFNR0ZDeDVDa01YZkU4am5odUwxcGs5SWI2SGhyQzZGKzlNSWNyRnF2?=
 =?utf-8?B?dWNBVGdpczZONjFBUWJRSUxhcjlUVGU4dm9YcVVld21HZnlqZVhKUzBPVnNi?=
 =?utf-8?B?cS9vQmpxdjFRT2lQT0dIaHVVbHdsb0pUTE9jQ25ub2Q4czJ4QkErZUNpd2RH?=
 =?utf-8?B?dEtIbTZVWkwrdjRGdk81KzJtaTJlVWp1bDZxVEVjdHZmeUZPNlkyYmxISnov?=
 =?utf-8?B?dzNUYVAvMEcvbEVjQjl0bzNhcm9DLzFYc1RRaXhwS0V5MW52dkhWZG8zTEhS?=
 =?utf-8?B?Qm9xZm9MN2R0QVZ2SVJ1WDRTTTNHby9SUEFqYzVQRXVlTEtHS1pmWDVYQVQ5?=
 =?utf-8?B?aDREaVBvcmFOanhtSS81YTNCR0xvSml1b2gxdCt2UEFsRWp3RGxwbFMxK01M?=
 =?utf-8?B?bTA2TjdqaXZ0YjEzclNjcWwxc0diWFU3Q0E5MDNuNXZVTG9yclF1UnJSUUox?=
 =?utf-8?B?aGhKUEdrTVJFeG1xSmNady9MdmNXRjVxTG1taWxNRlB4MU5CTnEyd0dIbU5Y?=
 =?utf-8?B?TUE2dHpYU2tBSThsYkFOdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjZMSmNkd3U0eVNabHdQRDNHK3ZtSEJuKzBZTEhaSTZqVFhOd0JFSTFEeVVy?=
 =?utf-8?B?bEtaWTFvS0N4bDlJSUZXeUppK1hENlJLVTRZSzVoSGpGMVpNRVJ5Tm1oa3hV?=
 =?utf-8?B?RzF2Rm5vL1Z6NXE4S005Qy9EYVNzenhLeDk2Yk11RDBHZExnSHlSdDI0bURo?=
 =?utf-8?B?clk4NlloOG4xcFJxbGRGSHFVZFNNaWZITmtnYzNJVTY1MkJSNEJYNnJiU1Nj?=
 =?utf-8?B?d2JqWS80dUZsOVQ3cUttQlExajgxUUlGckVJM25LT3VCb0lST1ZTRTc1d3M3?=
 =?utf-8?B?RkhzQ2tjeGppT2Qzalg4bE5CbU9WcGpETUtWWXdKZWJzSWY5ODBWZEtTSnk3?=
 =?utf-8?B?d2RlL1F1bWlpa1FUN1JONHBSbVllbUxJL0NSOWhXYjFwV0tsS24rUk1URWxZ?=
 =?utf-8?B?TVBiQXZHRnlXSVlVQWgyVWZnVzVBS3NCME5kamd5MmYzWkxjdEJQdEkrdUNT?=
 =?utf-8?B?c3hOWG8xSkd2ZUh4ZGpNcFV3L0IwNy9kbXEyZ2JvK2V5UlgwYXJzVHVBazJj?=
 =?utf-8?B?WlRNWnBJM0o4d21hSFBNaytKd3pOVVpSSVF5QTRVSytKRm9zeXMxVUt6dG8z?=
 =?utf-8?B?Y2JyK2t0MXR3SlY3MllRQUU0d25hTmJJUENKanpPaDMvbmtZNkQ4VmU3S0pC?=
 =?utf-8?B?cGhSMXhiQzFwa29kSGt6RmJDbVVNMGdYNlVUSFBBOG44WEFvMUUwQWk3NmZx?=
 =?utf-8?B?cnM1MUp5dkJjRWVKbWdTVFo1bU1sbm9hNVorTXFhTzdIRkdFd3BoczdvT0h6?=
 =?utf-8?B?QnNHdE5qaWphK0xML3VLWWxqSnZvc1ZrYUxzcmxWbnJRTk5FR3BDbDhwZSsy?=
 =?utf-8?B?TjdjMHA1NTZ0VC9lNXFYK3lCUkxRU09kYkNndTliMnpVckdQYUVMTzZJbTY4?=
 =?utf-8?B?allLMVYrakFMWURGK1g5c3V3YnF0MDJBN3BBbmhwTnByZzZ3MXhyMWFlVmQv?=
 =?utf-8?B?R1BMNHBJM284R1gvQTcvb1Mzblg4NTgxS3haMVFzU3pJREp4dURVemhGa3d4?=
 =?utf-8?B?dS9GSGExRFR5S3VYWE4xZS9vOHNmZ3o0azlScUF2WEJBTTBmcGgvenpmYUUw?=
 =?utf-8?B?RXpXWjhKZ3pJcGZkSDRuSVZxTURJbHJXM083VU1rcHFHOVZORUlieHlKek9i?=
 =?utf-8?B?N25qelFOeE9hYWhLZkwya1NLUURSakdDZTZRd2ZRMjFldkdmUlNYVHIyWWht?=
 =?utf-8?B?c1pOYjFRdmNFQ1V5dTd2ZkFRem1sUWUzZGM3dWUrcWlSYzJZc1NseFN5bUV1?=
 =?utf-8?B?YTJpZXpabFVYSEpkaGxLOTB4SXQ2dFRISFVoKytDMExvVVdZVE5mekorckVn?=
 =?utf-8?B?Tzdhcy8zS0k2NXdETmJsKzNobmhYL2tpejlHS0JtTW9QRW5LRW0xV3loRkdD?=
 =?utf-8?B?SFpvOFpoeDFGSnIzWXE2YzMzV1Q0NjgyZEVqL25oVUx5K1JKdDNpczdDYmZ0?=
 =?utf-8?B?dEZ2OFgyS3BBWWh2SEg1T3VxcllYL1ZSUTlxaGRzbHIwaUIvUkVsZTFBenRD?=
 =?utf-8?B?Z0QzaXFGRWI5bWJXZURpZlpaM0o3NUJLdE9xMEg5OFE2ZThIYmZOdVdxM2du?=
 =?utf-8?B?Ly92aHVBbUFQNThEaWNYclZ3eTd2b0FmTzZBUTlKUlc0NGNNUHk1MndmcUg3?=
 =?utf-8?B?ZDNFaU1MQUgrQ3diNlhlSWtvMUdFaEg2dklFUXFpTllVNk1oR3pGOGJ2c2dw?=
 =?utf-8?B?dVkxUU9rNXdSOUYyeTE5cFdCaXRWK3JLYVA4Zzh6T0t1bFM1RU9Xc2FDSnpW?=
 =?utf-8?B?V09CR0tBZTRlc252dy9xc2hLWlZqM3hRSCs3VkdRLzhzSGk2MUg5Tm0yZmxa?=
 =?utf-8?B?MWh0UmxKZm1RZGdiZWdnVnBZdDVnd2FYaWxubHMrWitEK1BtZjg1bENINzRM?=
 =?utf-8?B?bWtZM0RvcXV2dEpHUG5oaXgwREFGbytFSkpkM3h2bWZMa01iT09ER2JsdSsz?=
 =?utf-8?B?L3lDdHhwaWd0eWJ0RzZyZU9lYVdyZVBkWWVOOTNoVUVYYjRNcmwvQU1kRVds?=
 =?utf-8?B?N1Jad1hwa0JqZEdsQlNSRkNkcktNYzBBakRrbDErM2cwbm9jYUEvL2RXRVFq?=
 =?utf-8?B?d3M2QW4zaXdleFBBelZEdnhOVVVzdXp2d0JydHRDQVM3b292WEpPeXhZcnFI?=
 =?utf-8?Q?qSzrOztH4V2D/iMZjkOO5w0q6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e6de8kLxTugFyuu5Ig98NjWIJHmfEyIV1MVdP8eUQGi5YYtqjDkQSl6fabSGgCNtjh8Vi1rno4v+gIz1BFieVlGfWOQbz0QdYgnqrC+VZOSyBydPb7HDbz6qHDz2UDeeA7cUZjnJFf7tmqev78GTOVNgxhdE3ZxXaTygRUnh5vLd4tWq6u2B7IYExWzyR4tc804C+dTHeD9eASr5XXNnx0GKQy/sAXTfCQO1UJ607M57TR2qfE3wTqHuuJpYmz6GeKRx/kB0kFSNOTevdXwgTlMeL4LxSVkhruyUtYk6iJCAWnOh4l20BkvQQw74B7EA/Li4DP7fdvIfAZ+O/ONuuaudjKX9wegw4V3xYewmxIg5ob4qN9Ytj7gBzwupiGcpwxh1yXBct9N5IhiaCFiP08uT64EpMzOyGxtlZZMM+EzgKRvnVPiJTSQSiwijXVDNOSLHtUcrc320zgRhPw/avo204IRNCyp7NxIzRCWCYVrMPyiNxhNuNfFI6vC2LsH7y+Go/HqUmklCNtIrNW6vt4EHKXShPkIH/pLJzpk0PNAu55G5a7OtCr6GwqdLGqvgHPnxxcCh38clqmu0xtgz7zFioXP889AvJuCAz4/B9Nw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc6b709-a689-4993-4398-08dd1b80fa18
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 14:18:12.3408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOPMyqw84uZHn80LudG0XNWySJJSiYVbz552/0imQt3bltMrIHQlE4lUezrkcZnzqdmewQTsneKW2YM7WGSQQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6004
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_05,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412130101
X-Proofpoint-ORIG-GUID: yL26LYeUeC_HpvecOYGN5rKrCVYClrOE
X-Proofpoint-GUID: yL26LYeUeC_HpvecOYGN5rKrCVYClrOE

On 12/13/24 9:14 AM, Jeff Layton wrote:
> On Thu, 2024-12-12 at 16:06 -0500, Chuck Lever wrote:
>> On 12/9/24 4:14 PM, Jeff Layton wrote:
>>> Allow SETATTR to handle delegated timestamps. This patch assumes that
>>> only the delegation holder has the ability to set the timestamps in this
>>> way, so we allow this only if the SETATTR stateid refers to a
>>> *_ATTRS_DELEG delegation.
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>    fs/nfsd/nfs4proc.c  | 31 ++++++++++++++++++++++++++++---
>>>    fs/nfsd/nfs4state.c |  2 +-
>>>    fs/nfsd/nfs4xdr.c   | 20 ++++++++++++++++++++
>>>    fs/nfsd/nfsd.h      |  5 ++++-
>>>    4 files changed, 53 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index f8a10f90bc7a4b288c20d2733c85f331cc0a8dba..fea171ffed623818c61886b786339b0b73f1053d 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -1135,18 +1135,43 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>    		.na_iattr	= &setattr->sa_iattr,
>>>    		.na_seclabel	= &setattr->sa_label,
>>>    	};
>>> +	bool save_no_wcc, deleg_attrs;
>>> +	struct nfs4_stid *st = NULL;
>>>    	struct inode *inode;
>>>    	__be32 status = nfs_ok;
>>> -	bool save_no_wcc;
>>>    	int err;
>>>    
>>> -	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
>>> +	deleg_attrs = setattr->sa_bmval[2] & (FATTR4_WORD2_TIME_DELEG_ACCESS |
>>> +					      FATTR4_WORD2_TIME_DELEG_MODIFY);
>>> +
>>> +	if (deleg_attrs || (setattr->sa_iattr.ia_valid & ATTR_SIZE)) {
>>> +		int flags = WR_STATE;
>>> +
>>> +		if (setattr->sa_bmval[2] & FATTR4_WORD2_TIME_DELEG_ACCESS)
>>> +			flags |= RD_STATE;
>>> +
>>>    		status = nfs4_preprocess_stateid_op(rqstp, cstate,
>>>    				&cstate->current_fh, &setattr->sa_stateid,
>>> -				WR_STATE, NULL, NULL);
>>> +				flags, NULL, &st);
>>>    		if (status)
>>>    			return status;
>>>    	}
>>> +
>>> +	if (deleg_attrs) {
>>> +		status = nfserr_bad_stateid;
>>> +		if (st->sc_type & SC_TYPE_DELEG) {
>>> +			struct nfs4_delegation *dp = delegstateid(st);
>>> +
>>> +			/* Only for *_ATTRS_DELEG flavors */
>>> +			if (deleg_attrs_deleg(dp->dl_type))
>>> +				status = nfs_ok;
>>> +		}
>>> +	}
>>> +	if (st)
>>> +		nfs4_put_stid(st);
>>> +	if (status)
>>> +		return status;
>>> +
>>>    	err = fh_want_write(&cstate->current_fh);
>>>    	if (err)
>>>    		return nfserrno(err);
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index c882eeba7830b0249ccd74654f81e63b12a30f14..a76e35f86021c5657e31e4fddf08cb5781f01e32 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -5486,7 +5486,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
>>>    static inline __be32
>>>    nfs4_check_delegmode(struct nfs4_delegation *dp, int flags)
>>>    {
>>> -	if ((flags & WR_STATE) && deleg_is_read(dp->dl_type))
>>> +	if (!(flags & RD_STATE) && deleg_is_read(dp->dl_type))
>>>    		return nfserr_openmode;
>>>    	else
>>>    		return nfs_ok;
>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>> index 0561c99b5def2eccf679bf3ea0e5b1a57d5d8374..ce93a31ac5cec75b0f944d288e796e7a73641572 100644
>>> --- a/fs/nfsd/nfs4xdr.c
>>> +++ b/fs/nfsd/nfs4xdr.c
>>> @@ -521,6 +521,26 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
>>>    		*umask = mask & S_IRWXUGO;
>>>    		iattr->ia_valid |= ATTR_MODE;
>>>    	}
>>> +	if (bmval[2] & FATTR4_WORD2_TIME_DELEG_ACCESS) {
>>> +		fattr4_time_deleg_access access;
>>> +
>>> +		if (!xdrgen_decode_fattr4_time_deleg_access(argp->xdr, &access))
>>> +			return nfserr_bad_xdr;
>>> +		iattr->ia_atime.tv_sec = access.seconds;
>>> +		iattr->ia_atime.tv_nsec = access.nseconds;
>>> +		iattr->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET | ATTR_DELEG;
>>> +	}
>>> +	if (bmval[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
>>> +		fattr4_time_deleg_modify modify;
>>> +
>>> +		if (!xdrgen_decode_fattr4_time_deleg_modify(argp->xdr, &modify))
>>> +			return nfserr_bad_xdr;
>>> +		iattr->ia_mtime.tv_sec = modify.seconds;
>>> +		iattr->ia_mtime.tv_nsec = modify.nseconds;
>>> +		iattr->ia_ctime.tv_sec = modify.seconds;
>>> +		iattr->ia_ctime.tv_nsec = modify.seconds;
>>> +		iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
>>> +	}
>>>    
>>>    	/* request sanity: did attrlist4 contain the expected number of words? */
>>>    	if (attrlist4_count != xdr_stream_pos(argp->xdr) - starting_pos)
>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>> index 004415651295891b3440f52a4c986e3a668a48cb..f007699aa397fe39042d80ccd568db4654d19dd5 100644
>>> --- a/fs/nfsd/nfsd.h
>>> +++ b/fs/nfsd/nfsd.h
>>> @@ -531,7 +531,10 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
>>>    #endif
>>>    #define NFSD_WRITEABLE_ATTRS_WORD2 \
>>>    	(FATTR4_WORD2_MODE_UMASK \
>>> -	| MAYBE_FATTR4_WORD2_SECURITY_LABEL)
>>> +	| MAYBE_FATTR4_WORD2_SECURITY_LABEL \
>>> +	| FATTR4_WORD2_TIME_DELEG_ACCESS \
>>> +	| FATTR4_WORD2_TIME_DELEG_MODIFY \
>>> +	)
>>>    
>>>    #define NFSD_SUPPATTR_EXCLCREAT_WORD0 \
>>>    	NFSD_WRITEABLE_ATTRS_WORD0
>>>
>>
>> Hi Jeff-
>>
>> After this patch is applied, I see failures of the git regression suite
>> on NFSv4.2 mounts.
>>
>> Test Summary Report
>> -------------------
>> ./t3412-rebase-root.sh                             (Wstat: 256 (exited
>> 1) Tests: 25 Failed: 5)
>>     Failed tests:  6, 19, 21-22, 24
>>     Non-zero exit status: 1
>> ./t3400-rebase.sh                                  (Wstat: 256 (exited
>> 1) Tests: 38 Failed: 1)
>>     Failed test:  31
>>     Non-zero exit status: 1
>> ./t3406-rebase-message.sh                          (Wstat: 256 (exited
>> 1) Tests: 32 Failed: 2)
>>     Failed tests:  15, 20
>>     Non-zero exit status: 1
>> ./t3428-rebase-signoff.sh                          (Wstat: 256 (exited
>> 1) Tests: 7 Failed: 2)
>>     Failed tests:  6-7
>>     Non-zero exit status: 1
>> ./t3418-rebase-continue.sh                         (Wstat: 256 (exited
>> 1) Tests: 29 Failed: 1)
>>     Failed test:  7
>>     Non-zero exit status: 1
>> ./t3415-rebase-autosquash.sh                       (Wstat: 256 (exited
>> 1) Tests: 27 Failed: 2)
>>     Failed tests:  3-4
>>     Non-zero exit status: 1
>> ./t3404-rebase-interactive.sh                      (Wstat: 256 (exited
>> 1) Tests: 131 Failed: 15)
>>     Failed tests:  32, 34-43, 45, 121-123
>>     Non-zero exit status: 1
>> ./t1013-read-tree-submodule.sh                     (Wstat: 256 (exited
>> 1) Tests: 68 Failed: 1)
>>     Failed test:  34
>>     Non-zero exit status: 1
>> ./t2013-checkout-submodule.sh                      (Wstat: 256 (exited
>> 1) Tests: 74 Failed: 4)
>>     Failed tests:  26-27, 30-31
>>     Non-zero exit status: 1
>> ./t5500-fetch-pack.sh                              (Wstat: 256 (exited
>> 1) Tests: 375 Failed: 1)
>>     Failed test:  28
>>     Non-zero exit status: 1
>> ./t5572-pull-submodule.sh                          (Wstat: 256 (exited
>> 1) Tests: 67 Failed: 2)
>>     Failed tests:  5, 7
>>     Non-zero exit status: 1
>> Files=1007, Tests=30810, 1417 wallclock secs (11.18 usr 10.17 sys +
>> 1037.05 cusr 6529.12 csys = 7587.52 CPU)
>> Result: FAIL
>>
>> The NFS client and NFS server under test are running the same v6.13-rc2
>> kernel from my git.kernel.org nfsd-testing branch.
>>
>>
> 
> I'm not seeing these failures. I ran the gitr suite under kdevops with
> your nfsd-testing branch (6.13.0-rc2-ge9a809c5714e):
> 
> All tests successful.
> Files=1007, Tests=30695, 10767 wallclock secs (13.87 usr 16.86 sys + 1160.76 cusr 17870.80 csys = 19062.29 CPU)
> Result: PASS
> 
> ...and looking at the results of those specific tests, they did run and
> they did pass.
> 
> I'm rerunning the tests now. It's possible the underlying fs matters.
> Mine is exporting xfs. Yours?

Mine is btrfs, and the NFS version is v4.2 on TCP.


-- 
Chuck Lever

