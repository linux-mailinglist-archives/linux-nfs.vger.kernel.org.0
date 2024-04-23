Return-Path: <linux-nfs+bounces-2965-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A038AF5D2
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 19:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2441F22149
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 17:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F12213DBA8;
	Tue, 23 Apr 2024 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XO5/QZn3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VoJC9bZG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E995113CA96
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713894578; cv=fail; b=aTToJSNMRM2V0sZS+Wqughu57DvXHOHIZo2oEAXRW/2fIhejcRCofCwlG8XveSPoSXCzldZvzeEtWw6fzhst9dMbboXDroIFFPnHh2qNBg/BXDuDotyZEtgga7AkLSI4Pro9Kbo3taQodugKnyiuSDUnPg7C9fy7/346dndnhdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713894578; c=relaxed/simple;
	bh=Qe4YlWP4c+z31ZF7M9PgY8g+BuwkyxfaNNDlgPO57Xs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h2ltMvwgJtlvatOyIEZYHXplpxGlewIj0CKwVGcvEC3KfyZGXyYAO+FYk4omF46jwiAjugyeZ+9rHcKZpeQbx9yIBfuywWF0TPTW34wkONBlKWaTfSiYY48tquCHeU6zN4IwqiluFTlTVY6XuUFONzhmjzdUit0b0aDGaJOIhIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XO5/QZn3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VoJC9bZG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NFUOCS006565;
	Tue, 23 Apr 2024 17:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=acDbPwF4lhFEQ97yb3HLNKTprs0UnLnXzyYYoG66gQw=;
 b=XO5/QZn3/aCmhQfyIgb2IngNFZKx1OF5tpcQE7d/kZd6e6RAMoQd1tKtQA/azPofw9Uo
 8Yz2I7Lz1VeV+utKuVpB4OhAUl6LB/beBnja8Yhi7TNZ2N7V0Gm1GgTmYVbWA8uyYcsG
 0zNt/qAMI38ZXF1qLTm2NBl9bSGXhk5C4Uq68wIiWUsFhbbKCQQDEHcl/BS+3py+4haK
 Ho+ArJW6JzmNBDwC6qoj+lIb94vTz4bi1huCr38uj6YJgTyBg6DbzhF9k8sA8luhefXs
 skIg/QLM8iZZgENBdi5wSCcr0+UvY0SYff4+r43TqmIJp6Dp4DdhGoO5alZq5P/C+wC5 Mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4md6p1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 17:49:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NGJEva035582;
	Tue, 23 Apr 2024 17:49:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm457myju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 17:49:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsVjHXN6lRsr3vaiEcdO7QRpHZrI7rlxyOonOul6hgGAxuunBtMatiPSc3ZK9rKo0ohDys3UZ+jmF/FFDPCmiM8pI7o2pnDaJIdb8WKdJG3mfB/b+Bt7W4uUQp4Y4brCyLnY161QLT/r7BP00VMhVT1P7gmyexc5MbbpOvwYyxuqpbdrcF0Jsneb/Yu2pITZlS3slcp/TktmLI39H7rqkDpF3ZuLnxc7wQP7nBM5UNBWneHTfA2V5cIdaklWPxaLb8ljxBvgTAt6u57E3v3357N7XXwkD2cFooce/EXBLlMiW0mJJimhr1uhh9bLS9ifxWBMH+fYPws0LD8Spg5/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acDbPwF4lhFEQ97yb3HLNKTprs0UnLnXzyYYoG66gQw=;
 b=IQZX/ZAdPYiQNXST7eY/5NZYEk4KLd6Xo61ptcuqqb5Ny/Wp6F26R5li1ebTjdItJQwGHrv3egYEBRwx8CP+3hlkwHMEjmo6J5tZUUeVFHC+VEeDMAaCBmZi/D5+3a7liaULERyo/edmIvyMp6D3C/aB5n4KXqOcYMy77kW077HVOJJhBhITkCSy8PXq2A0wOacAM8O0WgZdTDY52mlRCCmez/IyJUc7ewGxA1k/wCFBLeCFwJCuqREwi/SLjc9bF8tNvy7d1OOOYR+sAf+PweElgiXF1b9WrlaayScSwcGJL5kO4ltXS1LBGtjzkS1eXkNw/90v18P+nQWi09RyqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acDbPwF4lhFEQ97yb3HLNKTprs0UnLnXzyYYoG66gQw=;
 b=VoJC9bZGGfPKuZtHRmQR7Clvoe0KigJNMZU/B3+Md7j8a3isZzVYoGrJUM4EyqXb07grUnRmwHwNHiUT36dnLdIt4sGU5k0giqdUlX6y0tsFGtHDcDPiGr84xi7qimV1H1RN7eBz4mc6gX3xjhr3BeKuVa1XZT4DZOXEUg16Ll0=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MN0PR10MB6005.namprd10.prod.outlook.com (2603:10b6:208:3cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 17:49:30 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::4c3a:47c2:806d:2e16]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::4c3a:47c2:806d:2e16%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 17:49:30 +0000
Message-ID: <d18e8b50-2eb1-419d-a937-9314ea39e08e@oracle.com>
Date: Tue, 23 Apr 2024 10:49:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] NFSD: mark cl_cb_state as NFSD4_CB_DOWN if
 cl_cb_client is NULL
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
References: <1713841953-19594-1-git-send-email-dai.ngo@oracle.com>
 <1713841953-19594-2-git-send-email-dai.ngo@oracle.com>
 <Zie6ochDV9VjumK4@tissot.1015granger.net>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <Zie6ochDV9VjumK4@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:208:23d::34) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|MN0PR10MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: f09d0fbe-7c3e-4f01-b443-08dc63bdb9d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YWpxdk90bnRuQmk2cmJXWUlhcysxcDZ1cGpLdXlDZzZkU3NMTTBrUGJad2R5?=
 =?utf-8?B?QzU4R2JOTDExNlFsQXM5Y1A1azNiNjlUMjNISEdaR1NHT0hsQXFJME4vZUla?=
 =?utf-8?B?Q2xxdTZBQUhndmtyckpSOWlWWkplNnBsS2x3RnhMK3FkeWkrMFp1TUtCcDZl?=
 =?utf-8?B?aDJkUk9VNjlSSDlWdHR0NGVmOE1OYlBmZkU0TVRQaStuWEtzYXdnMGZLRHNw?=
 =?utf-8?B?Nyt1aTI4OGFrTE1YWEluc3ZXeGtBaWpIcHcwcXU0MmdpZk5FbEk1SXZXSkFO?=
 =?utf-8?B?ZW1TZlhpRm9CWDBtNTNFS3JzNU1wSmFyVUpFOHlwZ1Myc3dzenZEN3k2R25P?=
 =?utf-8?B?TUVOcDYvVmt6cERtWEdFSEZ2eURBbmdETXNuYnpJOXMxOEcvSFN1VGxFQ0Vi?=
 =?utf-8?B?WVYxREJWZXUyV0cxbzV3Z1FYK0NyQmNzSCtuZlhoVEJhNEdkbGxkZFZvV3NE?=
 =?utf-8?B?Vm5Qd2FHOWVEMnQ0ZUdmK0ExSGhpZm11MkEvbUtxb2tWT3FGOWZ5M3QvQy9C?=
 =?utf-8?B?UjhCbkcrV2R1ckRVL3lia0IzMksyc2MydVNoQTNBanlQRUVKY1FtYldzbGpm?=
 =?utf-8?B?QlFFbjU0clNtN2E4Vm16RmJsdFRGOWxUWlFwdEJycnU0Rk5KRzBzQ2wzTmxE?=
 =?utf-8?B?OVZOWE9PQUh0WHMwSE12dUpFUWNKcWpnQkxmMjQ1TW5oYkV0MllNaWh3OGhX?=
 =?utf-8?B?RWI0cVdaMXNwS2lYR2E2cmZQcW4zSUJBbmhYVHMyOUNBM2pGVjJmTWp5QVhx?=
 =?utf-8?B?Zy9iYzZrSnhFdEZUc3lHZ01KZVN1VFdHZlU1WFlRcElrSEt2TVVEc1BuMk9a?=
 =?utf-8?B?aDZHVy8vcFlYeWk4S3FVUWxhY0dVZEVNUWEvMmVXeW9FclRvVWhSMmdndmdM?=
 =?utf-8?B?a3hzS0Fhc0FVNTFGeVQxMythREtSdmVTLzlsWWlQZkE3NDlHL2ZYN2tCdGZr?=
 =?utf-8?B?SUN0N3RnQ3dNM1hBTEN6Q2ZKUHdHUE5MbTdZQ2JNc3pHMkZQNE1Zc1h4d29O?=
 =?utf-8?B?NzRsRHRTNC9tWFoxMGFTRWpzaVpnNlZ1UHhQMENMR05VMXJsa0dzNmxhTjVS?=
 =?utf-8?B?Y3lKU2l1M3Q2YVBWY3JMV1FrSVdLUzNKY2plazlDVzljRmlYNGVmK0oyY3JU?=
 =?utf-8?B?WkdiWHdsVmZwRk8wNThucFh4MGorLy9tcU5WRWNBaHE4RlEzUjkzdzdIRlpH?=
 =?utf-8?B?Z0laRmZhRERsMlIrTzI5SDN2WCttQTk5RGVKajYrSERMK1J1ZmY4SnBPVEI4?=
 =?utf-8?B?YUlqcDRTN3o4bjQrcmNmeDdnU2pETFpacnJ6ZzRCRXBUREpHMlJYMi9oLzJU?=
 =?utf-8?B?Qnp5ZElHRDRGZng1S21sQk4vVzhEQXUzaEhOSlJlaFpFWi9pQ0szZ1NPdmtT?=
 =?utf-8?B?VkdoZC9DZXZoWU9Lam1WdzN1dm9PM0RQZUVVaDV4MVpqb0p3STVaeG1XaTFW?=
 =?utf-8?B?Ync0WmhGM201QlJDYmNLRHEyZGY5dDN2TGd4Z1RFRkFKYi9kZHd6MlZaQ21i?=
 =?utf-8?B?QmlZcXZBTzN3R1ZzbEh3Wks1SzFpZGlIdHBoaWdFUEl1cSs1bkpyRExJdkZq?=
 =?utf-8?B?bXRYaUkyTlVsMmRvRnVxNkhJNlVoZE50a0FDcWU2VGlsUnIxL1c0STJMcTNH?=
 =?utf-8?B?NTBVZlI2dm51Rkh3a1FKVTkzZXk1bzQyMHNJNUZJVnBuY0FDYXliUTJaemRw?=
 =?utf-8?B?cWJrSDdIMWx5Q0NDd3ZUSkxVUVNrQWZVVzlSUVRCaUZlZmFpdzBqNUR3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TWNzaHIxSldZb3cyOVRlRDJHZWFJSWw2Q2pCWGdvK0kvdFZGa1R1aWRKRkg0?=
 =?utf-8?B?OFVLclo2emtMZWZkbkVJMTQvK3l5ZVdmN01oU3FSRGo5QW9MMkl1cXk1b0d6?=
 =?utf-8?B?eFlKZ3JYb1EwOHp1b1BUZmU2TVJtb2xET0VaczV4SmJaOWV4NFdzSnlFVEV6?=
 =?utf-8?B?KzBSeXFzUlYvek53M04vM0tNUlpoV1pwRG5qRytBbGtkT3o1VVRKOW5lVEt0?=
 =?utf-8?B?d3V3UnlwM3loRnE0enN4QzIyNUNZcFV3QWFIUnJ6djFlem5RTjdEcnM2c01y?=
 =?utf-8?B?QVVBaWhKM1cxUWtSSHBXZHFCbWM3cGgwL0Y3WVNUalhCZ2xObm96WElqNEpI?=
 =?utf-8?B?LzhJMnJxUWpTK2NiRFJkcWJuSFQwR280NUw5bFFROUZ4OFRxRHdvQVhPcnpv?=
 =?utf-8?B?Zk5JdjdGcERkd2IxRjhOVzJlWUZTL0hWSGJoYVFHNk92WTBwRkhXN01BNXk3?=
 =?utf-8?B?UGhLaXlRYXJ4dDBoQUt2RDlHd0RNaS9xbmRFVkdmcENOWjQvNTR0S0s0czNU?=
 =?utf-8?B?ZHBIY3E0TXM3YXdyWEwwNUk1S0pkUjhub2liOU1xK1Q0ZGdrN05qbnM0cnpu?=
 =?utf-8?B?S01uNVpKT1phU3llMkVkMVhOTmlKVTZUSmVaZTYxMXV4OGcrS0l4cFZUalNi?=
 =?utf-8?B?aVlLdElPT0p4RFU4dnFvWW9iODJCMmhBRUYzelRNZFJSVlh4OXR6bjByZGp6?=
 =?utf-8?B?c1dXVUEyV2RkLzl4UEIyUXdpamhEMWRzV3B1U3VacEtQSjZnREEvNTczQXk5?=
 =?utf-8?B?SjBRRjNzUkNGNEhIUFdBVVdId0xnS2kzcGliOEpyb292ZlpLWjVXNWxXSjk0?=
 =?utf-8?B?SkVNT1Fvb1F4WTNsRFp6REFlZ0JyVjRQajZKb2hKWWw3TkhGVDFRZWhraGlT?=
 =?utf-8?B?UEhNSTg3V1FjWFdFbWswWnI0S1VhUTc3UC9YT1dBdWtzY3A3NXB2S2U0WmVI?=
 =?utf-8?B?eDhZRFV1aSsxVGNSQ3NFdWh3ZlRnWFRQNVR5NC8rb0FqL1V5bmRlRGsvMWtC?=
 =?utf-8?B?YkFGNllQWm1sZjdQd2xRSi8vRFJsSFcvTEFnRlpmNlJwUXBGTmpWak5lQnBo?=
 =?utf-8?B?TXFTYmhteDQ2RzZMR1plWFBmcVpESG5lQkxwRXdBL05hc1RGS1RISDR3anQ0?=
 =?utf-8?B?TXdIQnpycG1Sd3ZldnF5RHVmYi9YWmU4TzdlU1BzWHNKT3VlSi82d2FvVjRW?=
 =?utf-8?B?TWI5Ly9jcWR2a1NXbTh0OC93WDNoUHBSTWIvNkd6aFpCbm5IWjVXV3EwTG5n?=
 =?utf-8?B?bGlqL2dPM2ZXY2w0QXpMTXZydExyb0FvVVZncHFzbUM5RWRxMHU5MXR0ZWZh?=
 =?utf-8?B?QVBUcTRJNjZnbU5NREtzNlNtc3ZiNnQ3bHZYWk5aK29mVWdiQkhCVGg3YTBY?=
 =?utf-8?B?dVdFeVQ2SW1nWWlOeURQRW95Wk5tdE9GQ3J1aHBGZmJFblJ5cDlReUVNVSta?=
 =?utf-8?B?ZCs4NjAxRktlelhPNVU5K0dPZ0drZzFJSXFqOVczSEJnNldiOEFpSUNCaUJK?=
 =?utf-8?B?RmFVRlJNV0swcEQxbzdFSHhFYUx5SE9ESm9lTEphZEdrSXlnU2Z6N1ZPRGQr?=
 =?utf-8?B?amR4VU10UStmZzBEUkJ5RndDUDlEdUVZeno5Ti9zQUxFWTE5Qjl2VEd5Ny96?=
 =?utf-8?B?aERhSm16UUpFZjdDVy9GTjdmYjluTXZmdHZYeW9sd3dBdTdjY2QyMTBGdTNF?=
 =?utf-8?B?MTVkOCtjM1N2SEZXYjFtOUY5V3IvUjRWSUZXUHhwdm5YL1VjcWlEWENONGN3?=
 =?utf-8?B?aWdKR29tek5rTWpMT3UvTkVSOG8rcjZHUVRMaHd2MlRSQjhnNUhqT3I3NmZn?=
 =?utf-8?B?ZTVzMnFHdDJNK1YwNVQzdVh1NE9vdE5DNXQzejQzYndGVnBGRnVET2Z2RlN4?=
 =?utf-8?B?MEl5d1hlakhYM3hxeWMxWk9sMFBTUkl5dXJ0K2NJZmZrbSt5T01tTVNWVDdB?=
 =?utf-8?B?WUNDMDl1ek1EZUFuQjFwUm5qaGdqTFVTMGw4QnVSckNRQWdLekVyOW8za1o0?=
 =?utf-8?B?ZjA4V0w4c21qbE1nMWpudHNnWmREMENMMExUTWIrMUs5VkhxUXJQZ2VJdWV0?=
 =?utf-8?B?b3NFa0VMVXdVWk1kWG45d0Nrb0Ntc1pXcUREZ1gzbXlERExwVjdNaUhjV1hX?=
 =?utf-8?Q?SLnxRzOnu6r8pSiz5P8nV+/NB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nOzA7HZouImG9cLL1Fu3G+FIhvVEGjWeTlcVwJ9LCoqTD0xU/42oU+9VIYidIw2GXTyXKBVxX1dVWOdF5feBOFf/YPQ7MWi5JgZ2jfmSNUXHFH/fPpo0+Je55JsDtGHpDa3fPi6Qmja+9TLQBM7kooPBZph5aotomgg+P06ttY9aufv0zW+U5ScXVlNLcHsYKGPfp5esbIKC5PWEEGZ0c0GFInDQ8xbYHzjlwlExPum6VolIgQOzvgrVtFRgrV4yh+IYRndKP/L/n7CyIg17kzCNf0R0Uy9zJqoFvP+2amhMhVlp0KNLkPttP3pzubU6qapk7l+UTkDiWp5URvSiaJV+3IXEdPgzlkvdl0arP01ngaRDzhA3AUBBvKOnUl2kJe1imgTFKVKQ3AVhBYWYpqogadCh3lCgc2dF/jFB9F1pbiC7uIj1PK+wAoSYj3lC/iT17b4SJqgba2eOcYu/Ad9QTbr2KrR8G4zYADGxgwQvh4FDhQG4ND37lHaHTI/qvga3aKqU5u/1YpgMLqpFDPQK6kgWk/OFmbw79ZKo9HGFwwEEFbQuHHLM2UNsUvNN7scQgaKWNW4F960Qa1IwOn04sBVR8kEPsOkauPDBal4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09d0fbe-7c3e-4f01-b443-08dc63bdb9d3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 17:49:29.9208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUxFJMvJOgXbps0HUo2BBGKm39HJ/AkbJmWntUnyMkgfzhjSjrPLb1hVs/Yk6DNEtAKdp79tC84bCc1q5hT9FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_14,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230040
X-Proofpoint-ORIG-GUID: SjAAYtY5I6b2KnPrBh_09cqO-9bzU7o3
X-Proofpoint-GUID: SjAAYtY5I6b2KnPrBh_09cqO-9bzU7o3


On 4/23/24 6:41 AM, Chuck Lever wrote:
> On Mon, Apr 22, 2024 at 08:12:31PM -0700, Dai Ngo wrote:
>> In nfsd4_run_cb_work if the rpc_clnt for the back channel is no longer
>> exists, the callback state in nfs4_client should be marked as NFSD4_CB_DOWN
>> so the server can notify the client to establish a new back channel
>> connection.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4callback.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>> index cf87ace7a1b0..f8bb5ff2e9ac 100644
>> --- a/fs/nfsd/nfs4callback.c
>> +++ b/fs/nfsd/nfs4callback.c
>> @@ -1491,9 +1491,14 @@ nfsd4_run_cb_work(struct work_struct *work)
>>   
>>   	clnt = clp->cl_cb_client;
>>   	if (!clnt) {
>> -		if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags))
>> +		if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
>>   			nfsd41_destroy_cb(cb);
>> -		else {
>> +			clear_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags);
>> +
>> +			/* let client knows BC is down when it reconnects */
>> +			clear_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags);
>> +			nfsd4_mark_cb_down(clp);
>> +		} else {
>>   			/*
>>   			 * XXX: Ideally, we could wait for the client to
>>   			 *	reconnect, but I haven't figured out how
> NFSD4_CLIENT_CB_KILL is for when the lease is getting expunged. It's
> not supposed to be used when only the transport is closed.

The reason NFSD4_CLIENT_CB_KILL needs to be set when the transport is
closed is because of commit c1ccfcf1a9bf3.

When the transport is closed, nfsd4_conn_lost is called which then calls
nfsd4_probe_callback to set NFSD4_CLIENT_CB_UPDATE and schedule cl_cb_null
work to activate the callback worker (nfsd4_run_cb_work) to do the update.

Callback worker calls nfsd4_process_cb_update to do rpc_shutdown_client
then clear cl_cb_client.

When nfsd4_process_cb_update returns to nfsd4_run_cb_work, if cl_cb_client
is NULL and NFSD4_CLIENT_CB_KILL not set then it re-queues the callback,
causing an infinite loop.


>   Thus,
> shouldn't you mark_cb_down in this arm, instead?

I'm not clear what you mean here, the callback worker calls
nfsd4_mark_cb_down after destroying the callback.

>   Even so, isn't the
> backchannel already marked down when we get here?

No, according to my testing. Without marking the back channel down the
client does not re-establish the back channel when it reconnects.

-Dai

>
>

