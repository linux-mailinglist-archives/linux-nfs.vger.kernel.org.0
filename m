Return-Path: <linux-nfs+bounces-15954-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD43AC2DE9F
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 20:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B812F4E2200
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 19:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651772E090C;
	Mon,  3 Nov 2025 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V0ctt+3E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KsqvF5ge"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAFE2BEC22
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762198602; cv=fail; b=GKaVLlruC6uNvGOQ0eA5vCL/4WuRIOl0pdQln4Uwn57YxApcFd1c5clvSAxci3RwJX23ka5v9CfTRYt7u2dAARWpL9RI04hqTRdL1YydDA+G3nMPPAlWPi49vuIm2h6tUzTVkRwcUK44yWcUmLflXu5tnOGDr86ZW0Gf56oAIUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762198602; c=relaxed/simple;
	bh=hamXywYOp4bORzvqK0QtgNaSy/G7VUKjbrM+lOrGDzk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C35B9wsxqIVkmlXxUzygI0pZa+oryaf3drjpSvNxfS/+TxMVS/c85k+1ellpf7lgkzeSwg6UkU5J/FZqRG0mWsUIotGnzWDYloxB3pPI4l0nQXnrpUfXHub2HTABdD+6BVaXvxiZdF40NrdYL63vz90O7A2EoxYjcmRPwoC6M9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V0ctt+3E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KsqvF5ge; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3JTbH8020068;
	Mon, 3 Nov 2025 19:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mBN7CMgs7Lkq7DHpIyT1zo4YaipVUtRuCBeKgcLHQ00=; b=
	V0ctt+3Emr2Hx6yPIz01sDOxGRlpqB/eUF4vNNQjwnRwuxNZEME0tvWn6BIh6elq
	wAiugRFxssW5i4ArgoQeYxTOh2a7NAlJ5Qyk1C4BhlUxeS5prOjKkw1E2jccW/qj
	ZRUPFF7kuCj2EeF8ygC1NYQRppiW+dCjoQndIOocjZdT6q0HLw7gPnSEA1VeBxhY
	Gx/7B1Qch/VKXwZKWRKIP9OJnmzV2wvSEmB0HgoOjIPgJzpoRb7N4tKKrz1bVHPF
	I/fN8Ds1n0IQzyhbuYxo6Jxh8fRllntm2rmAqmhQETRP+U85ESM/gBhmNUnLyLnT
	38JiPuXwt7x2cJ3rPtkpvg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a72kjg0dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 19:36:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3Ixm1f020980;
	Mon, 3 Nov 2025 19:36:29 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n8kxrc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 19:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1cv40b6eHafT6LhIRK4fRc/nZKuImmyQoSQfL9299UeKTwjUp3m/B483AOADoZnYKkditSg3t4BnuokQM4Jpjapu/yIArHc/DxEUUTHVnwZwOcDhkmHupib2AQTpswaVV2u3aVHf2ARq3qqzUiDwO0uKzj4M4qGr45El8SB8jgf+usheiMNS5uvwBFNUWX6YzL7GzkDFEsoqXsG/KK26WKpDH689pBJ31WEjbjTQuBMdJAGSPAxPD5OozXE501sc9rGKjytd4bA/UieBOmo59y1DrLIoh+/oSpF0UA5uPslvhd7D0tdtr68Z87vT947fat20BR9Y+7k1KLnQz5CZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBN7CMgs7Lkq7DHpIyT1zo4YaipVUtRuCBeKgcLHQ00=;
 b=S4bG0EIQr/YuJ9tVfl9Ln9uDj0XdkymZgfy1RyrLvwVTCfroRaqa9uJKzfoHXl3WRJZHKBThcDzI//ki8yZuvQE7wg0OgpuJxDxzcAXotfh/KO2u9jLA3UX2u9CKhfc1E0zyCgKaXFd0pv6HLOpSCV7HJQXWgyLRFM3L8tkahpweTqb1/QST8qe7niDhkPpP2yGoHWD//e28uSy6sp7YeFzvCz5MZOz8D8xB36YD7ptfxUxJmea2EG53wc5B3w9tuV6+5vMBLzJ7TSNNx4lMMm4E7sdW4PhaQ8V/3KN2rw+1p7J5ZPuiizINYBUazTvwg+EWyXlC3e+hu55TPd0+eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBN7CMgs7Lkq7DHpIyT1zo4YaipVUtRuCBeKgcLHQ00=;
 b=KsqvF5ge+uaZV7X2VXRy3Xjf7D6OXCvdeUin7CunbDnnH7lOHLiXsZU9iCuhiTl9EDQs5GieKGLJvKYWFTcMij0x0eoQUKrZUDJx8Vs2OByCWqbWOkOCf+WXZ38bGLSV6YYXyfs9NjMCbDRduvPraeh2XXpNrgLpPvc3NSYqoTc=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DM3PPF72E3677A1.namprd10.prod.outlook.com (2603:10b6:f:fc00::c2f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 19:36:25 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 19:36:25 +0000
Message-ID: <a5d81349-c670-4aba-add5-c921a14c8e6a@oracle.com>
Date: Mon, 3 Nov 2025 11:36:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] NFSD: Do not fence the client on
 NFS4ERR_RETRY_UNCACHED_REP error
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc: neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
        linux-nfs@vger.kernel.org
References: <20251101185220.663905-1-dai.ngo@oracle.com>
 <20251101185220.663905-3-dai.ngo@oracle.com> <20251103114500.GC14852@lst.de>
 <841a3ef8-d5c8-4f87-9244-f79a10c66e3b@oracle.com>
 <b8489e0f-550c-4c63-8429-fb2d44f24c0e@oracle.com>
 <ae427b4ffdb219a64abd7d68680240d9798af845.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <ae427b4ffdb219a64abd7d68680240d9798af845.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0047.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::26) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DM3PPF72E3677A1:EE_
X-MS-Office365-Filtering-Correlation-Id: d012c0f9-fa07-43b3-b52b-08de1b1046be
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?c1VTa2dPSTVxTFIwblJ4enkrZEx3VlpvNUNaVVllVk5ETll5RkRiUUtqVGc2?=
 =?utf-8?B?cGQ0ZVRLajBFQ3NxZ0ZVNW1oQVdtd09rd01uNlNuaUxZNGFzdko5aXRPMmpQ?=
 =?utf-8?B?RTlPQ01KSmI1cUZkWmtmeXdzdXlMTWNXZU9tSmlXSGpoY1IvOTFZVlpvUVR1?=
 =?utf-8?B?NDg4YlhaY1pTaHVwUEVScjFmTitTZGJGbW9zQWNVZ052M2haSEdzeDhpTjR5?=
 =?utf-8?B?aGIrWUg5azRwY2JiVXhEVkVMN2FSRXlybm80L1VWcmFBcGFmMHp6OE1URGQz?=
 =?utf-8?B?UDBWdFl4RzlKREJqaDJwcS9qUC9zWTVsM1RJK08vaTFvOG1NTkpndTVyRzdW?=
 =?utf-8?B?Uld6bjJHUVdaeEtSdmVhYlJYdlhjUDVtRHJEY1JtMUUwSmo1R0tJMysycXA5?=
 =?utf-8?B?TlFBSFRwdnh6ck90UG44UmJjeFFpZmN1aFl5ZndwclovUG5RV3MyUGJOY3pj?=
 =?utf-8?B?LzJiLzVGczhTenJoam5KRXJ4YTF1aFE2Q1AyOENCUWJBTVFoS0kvNnpid3E2?=
 =?utf-8?B?REdRVlhxZjdFN3FYT1JGd3htTmZ0WUcycXNRS2RYSlkyK0RaT1ZCV0hTcSt3?=
 =?utf-8?B?N3Bjek1rQVl0dUQxVmQxZnk2b21EekdBSVpXc1BCb1FqcDQxQ3ZvcnIzT2kz?=
 =?utf-8?B?L0puYy9obnhYRGxLL2dlb2daZi9jcm9Fb2NGZzdUUlN6SUozMjNBY2hBdlA4?=
 =?utf-8?B?SVBJYytFbHJ4YjZReXNrdHAyTXhpR2poZTJDd0RnN3hXYjZ6cUFYVEM3QnZy?=
 =?utf-8?B?OU9CTS92TzBpUTVCZHZTV2I4cStybEhZQlFjV1ZIQnEyVGpKem5GZjQwZmkw?=
 =?utf-8?B?bWIxZnZHSWM0OC9neWRrayt0UjZOSkN5R3RwVzQzRVkwVmxFUy84Tmx5ejMx?=
 =?utf-8?B?Rkx3R0NpUXNqMWpJYVR6NVlvandTcysxYUpPSFlXdElkZFo5NDdjQ1kyRVFZ?=
 =?utf-8?B?SWJRL0s3Mkp6UW5KYk5EYkZrYWZDcXByaG41RzE2U0RBTk8wRStrYk00TEFG?=
 =?utf-8?B?OXNsZVpUNDVpSGVzL2p4T1dpZEJSYnFmWUppNzVJbE5qVGJOYUtTbVBZZHQ2?=
 =?utf-8?B?UUlMVjUzRzVycVoxUG96cHI4RmJ0Um5ERnB6RE1aWk9YNUNxM0luU3pQdkVa?=
 =?utf-8?B?azV1aWhuTk1EaWlHMXlTYlhtR0RwOVBaZVhDTDVuZXdmSGpZT3h0OHdWbVVw?=
 =?utf-8?B?NHRVWlBaQjVrUmxFUlVqTmx3bmZHejRJRVVVU2xqUVR2T01jM255YUFOcFB5?=
 =?utf-8?B?a3AxWHBlNEN3WkR3NjdzMllMSjd6U0JxQ3krUzBYNm83YXh4VUllNFI4NFVs?=
 =?utf-8?B?OWNqcW9ZcVprK3dxdEM5MDRtOGhWa2tBOXVVZGIzeFVTM09hOTFUMnNnOXFr?=
 =?utf-8?B?bjE5QXM0Tkl6Vzc3ODVwZzlnU0tBNEVpa0lpd2ZUYTVEcWM2WU9WQmFES3Fl?=
 =?utf-8?B?VUJmL3NLLzQ0dzB6QlV3NkZIV3h0U2FDRXhPZGVtMnZ1Y09uUnRMUXFmbkJF?=
 =?utf-8?B?TlpmcVNaM2ZKZzlkSnpRNEVIYW5ZS0IrcHFyODBpei9LcmUxeitXbDZCbnBD?=
 =?utf-8?B?VXFYQU5aYkJEOC9YbzB2NU50Njc2UXFuS0Z1ZGxsRnlLb2hJUEV5YlFXcW9p?=
 =?utf-8?B?U1ZrM2pzWnBCUEtqRVJ5d0hBSWpLbHQ0L1Z1aGNQcTdrcVhnMkY3akZDTURT?=
 =?utf-8?B?ZGhEbHkrUXNleWdWT2s5WkRCaEg1anRyNUdwK0padG1QY0NiQnltUVREY0FM?=
 =?utf-8?B?NjdWSTdHRG1ka0k2RG1LMS9rSTBzUUw3MnFpZlMrK3ljYUFKZlRKdSs1eG5m?=
 =?utf-8?B?MlNsc1Y0K2t1VFNHZlNYNUV2WlVCVlU2d3hqY2RIbllJWksySlVqSmM5bHB0?=
 =?utf-8?B?RGovRk1XNFIyeDFKNjllWlFld0hEL2ZSTUxualg0N2w5YmQ0ZG9PTHNJOFlD?=
 =?utf-8?Q?FlD5FgemyqQskWGvmoHEE1YMUxqB3J4o?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?K2pneHpJalJUdGtIWXY1QUpQbmJLQUtTTEdMMmhjVjZXZTNRci9aRkROcXhx?=
 =?utf-8?B?cEo5TytpWkZqdjdyYjlDc1IrUjY3Y2RDdEZDUXJHNkoyRjZDRHhPV0VGejNH?=
 =?utf-8?B?MWQwa0d4QlVtTW9TUUp2Q1AvdUFMK0MzanJaVUF0WEdJTmU4MmFnYkZHcE80?=
 =?utf-8?B?L2FpWVJ4U2dRajBTT2RPdlMremZhN20wK0g0YkZlVmpqNVA5QXV6cDUzZjhM?=
 =?utf-8?B?WCt2dFlLSG5DUUFWR2FVR0tUaXM2aExtalhkL2lNYmtzSzhyL2FUcTZSekdq?=
 =?utf-8?B?UTVUVW5GVGFvSDRQK21YZkxMM3JJWisydVNtaTJBK05RMitFYTMrcG5xSEE3?=
 =?utf-8?B?Y2l6alQrWVlQUnVFeUx1VWM5eVJxNVN4K1pKbUJOd09IamVaZUdTWlErUXZy?=
 =?utf-8?B?ZURuZmhYdVdiU0RmUmltTkVKMk96bXN2WEQ0ZVd4cm9YdTRXOFdqdUJMN2h4?=
 =?utf-8?B?SFJSaEFIWDVabGN4T3pEMDdiekJjbHpnRElGTFFoRHZncHdUYndtOGM1Umlu?=
 =?utf-8?B?ejh6cGR4cldzejhHSnhIS3NQR1RJYmJFS0hpWXpQUU8xczIyMTNRSFBSZkR6?=
 =?utf-8?B?dUN2aUEvMCs3cHdWNDZGMGVXdVdxY2RnRjJnVHFBZVl3WlBNOUNtMDNOT2NB?=
 =?utf-8?B?Tmw0UUgrZ2xYMUNWTThwaEZwZ1ROTlhvcGgxZlViSVJ0WktmMjh3L1YzUnk3?=
 =?utf-8?B?U1VadDBNWGZoMGRrcktya1B3RnVoeHcxSnp4MUNRQ2c5YjBWTFdFb0JWMGRu?=
 =?utf-8?B?ZDRwVk4vWFQ4ZEZjQy9YNldzeGtOTWVjenZEVThiU3ZMTnV1ajFmWmg3VThT?=
 =?utf-8?B?WW9hV0JjdThtQVk3Y2hnNEIwckZZbnRMQTNYNlZxeld1WmFrTlFWVHY5RVZq?=
 =?utf-8?B?bDVsbHFwSG1BQ2syUHBsdzl2d0tXY2JLY2pKNERVbHM1MXJiOWI0U1lwY2NR?=
 =?utf-8?B?U2tiempleEpGR21hc3phMHVGelc4S01xdUJVa3cwRXNOdFphYWI1YmpLaHpi?=
 =?utf-8?B?MDYvK2NOOXFHdmZlY3pXNlUwNmxaNDExR0JMSzJ3cWsvWi9CbC9RODkxVmhF?=
 =?utf-8?B?MUppam5kUmdhTkgvYndTV24vQlAyNXhEVHpxOE93Tm4wMEFWdGlZZ0FXZjRp?=
 =?utf-8?B?MzBIMTBiaUNHYk82WWEvcVZMRDQ1RWljdVNUVTRGYzRWSFhuL3ByLzFhRCtF?=
 =?utf-8?B?YjA3NzJrQmV6blZqSTFrV3RrTnBGRjB1cUIvQWd6Wk50cTlTK1RhUDhVdnNQ?=
 =?utf-8?B?eS9PdEhmZlZpdjQwRGFqUVAxSk9manhPdFNsNk05aVY1aUxicjgvU0w5eHo1?=
 =?utf-8?B?T0FBUDVoSUMvN1JCZGVlaWk4SlF4T2lnS1VhcitOckVsME4yVFlTODFMQW9G?=
 =?utf-8?B?cUVhVm5USUltV21YQldtU3Z4NnhNWFFNK3VISzZGUUttNnJzc2hkOHpnZThl?=
 =?utf-8?B?ZUJhblRzQTZKRnBQbVBWc1VRL2svVjRURkxQZHhsa28xem5TdHJkeE5saVc2?=
 =?utf-8?B?czRuTGoyNXR4L0pzTXU5SnpYNjY3aCtkZmZ6LytsZlRKVlA2Tzl0SE90UTU0?=
 =?utf-8?B?Wlc4RWh0eVFIUjRrYzZRa2MvRVlUZDN5cUtrL0kwcjE4d1B1d0lxeHFmcUtq?=
 =?utf-8?B?ajdlUVBJSWNEVXlIT3MvVzBnbTRHd3dxV2FidFRUd2VGc2NSaER6Ykw0NzVs?=
 =?utf-8?B?VDE0VEZ1QklmUk4reXdRUXZYd04zV0tFKzJGUmtzaWo2QnRFaXNZSG15dUk2?=
 =?utf-8?B?b29YM2tZQkoxLzdCQVgwbEl6OXpKcml4ZE5BbG9BRGhLd09rVCsxK1pZTHVY?=
 =?utf-8?B?Nzh1a2k1YUlWOHBIT1J6TTMwN2hGTU9vQ1BXL0FKcEV1azBaanZXcjBjNXFZ?=
 =?utf-8?B?VVdULzV3aStyZkJTQ1R4b0Q4NlJTc1Q5aTVRYlRlMUFFcXhDYzhNVzZQOVpU?=
 =?utf-8?B?b2VYTVJFa2tzajAzV3UwZDZ4UXdxWS8rUFJYL09TeHNudGRXa3RLeFRtbDBz?=
 =?utf-8?B?UGw4aXpzc2NoRzA3KzZFZVFTUGw5eDNGNmRhMlNjdFFyRjFpaHRTMFArTjFY?=
 =?utf-8?B?SW5YV3NGZ01XN3g1c0ZIZ3FjZWljOW4xVGxyeS80OUY4dWVXOVVlSnFCODYz?=
 =?utf-8?Q?sFvXVyrox8lsyFNcFfw5ahHvh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LBhuxpjmb5HrDXc14sv9w/STn2HrdNNbfPRskZOdhI0qfgsmbxO64rdvz7F69fTv8MDchKKwaOzn4JPdd1B4wUZTLz0F+48naP1jkm/c582sIApT86fA7tqVgaUlLpU7hhhgS/VdWnffQx4xmX92x8/IWpp2idRm9wc13UtcsGkE56vUcKc2hkj4j225oreI+k87zr4zwqUR/W7iZksDLjcczVyxHwFy3K2wtVXTx7te2gWoibA6t+RCCRgQZ3wmOEykmbv7XzlzSTHnbGdNXlMgoxkIOAi0H1AT2VUkcjiMZLt9ZxkiRnBfAnIVNjfXpWPmR8uCBn3UTJtN2x5ysbCrWyuxOYQRA/WtVB6xNSC6PR2V6RERxfTMXrlVetpsso/WJm7CLh2iIqBB/kSHCAkvtu+KLc1xDoKBoVS1nyMl2PqcchURDLS7xUwXlGahx/4SCJma2y3tqzCyGPIYmcQPQk/hZghgO7jrUN9WL44EeWtWkGBtN76N7ZrwglBgTLTRLqiEn6R4zB40XFq22i5xMl23fl/eMdoARAJQ95FfWrMsJToLsXL/9IL3jvwujqdTZWUZk3WM/62wbyd8P1iw+pCivyQEVlJrqNBHk7I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d012c0f9-fa07-43b3-b52b-08de1b1046be
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 19:36:25.5556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9F9E758oyBsMI0vHoyQKh/phsNHwmWDqXB9wntlKnExCuyzi4EsqVC8xpfXeQ8LkB7JFSnCWPQ3shB938bvSPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF72E3677A1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030175
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE3MyBTYWx0ZWRfXw9oJ1CXx/4Oy
 FcAwEsFWF2xdbuJMGuIweawb1Vk/bfn4og8CiOwSuqpW1fCKQez2nUu8cM4xgMQ5unGxus/NsWy
 7UOnDLrrOcOhTpJq9xMr4vMkTC/KgoKvljawVcORKMyn239gv5z7xVkvOfR31WnTQwvvYIfnAtV
 0kHlbORKZOlx+QmPfB26c65DTzLNOLgcUYnOjYdn2MN+HJMw4y4eJc0oBvTe/Jh48FVGZrPOFpF
 vVTrqXKilmSAaa3sby/7w+KlxA29wjj6ajRXEvDBwPOpdOjZHjiWYt/+nrSnMysa/kCfS8TbiDq
 mRMf2kSdNPZkVqMYgx0JMde/YC41kFYqWsxOOcpvtgm97bHAi1OFznPVeGctxXFbP1qkHYQv49h
 QlwQ05QCT6wUghIpccGkoRA297ztFQ==
X-Proofpoint-ORIG-GUID: zjkMbRnIOKk1gcQJp5tT2y4wXbxIs84z
X-Authority-Analysis: v=2.4 cv=WJFyn3sR c=1 sm=1 tr=0 ts=6909043e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=x3xXLs9Itc5nZlHTQr4A:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: zjkMbRnIOKk1gcQJp5tT2y4wXbxIs84z


On 11/3/25 11:22 AM, Jeff Layton wrote:
> On Mon, 2025-11-03 at 10:50 -0800, Dai Ngo wrote:
>> On 11/3/25 6:16 AM, Chuck Lever wrote:
>>> On 11/3/25 6:45 AM, Christoph Hellwig wrote:
>>>> On Sat, Nov 01, 2025 at 11:51:34AM -0700, Dai Ngo wrote:
>>>>> NFS4ERR_RETRY_UNCACHED_REP error means client has seen and replied
>>>>> to the layout recall, no fencing is needed.
>>>> RFC 5661 specifies that error as:
>>>>
>>>>     The requester has attempted a retry of a Compound that it previously
>>>>     requested not be placed in the reply cache.
>>>>
>>>> which to me doesn't imply a positive action here.
>>> Agreed, this status code seems like a loss of synchronization of session
>>> state between the client and server, or an implementation bug. Ie, it
>>> seems to mean that at the very least, session re-negotiation is needed,
>>> at first blush. Should the server mark a callback channel FAULT, for
>>> instance?
>>>
>>>
>>>> But I'm not an
>>>> expert at reply cache semantics, so I'll leave others to correct me.
>>>> But please add a more detailed comment and commit log as this is
>>>> completely unintuitive.
>>> The session state and the state of the layout are at two different
>>> and separate layers. Connect the dots to show that not fencing is
>>> the correct action and will result in recovery of full backchannel
>>> operation while maintaining the integrity of the file's content.
>>>
>>> So IMHO reviewers need this patch description to provide:
>>>
>>> - How this came up during your testing (and maybe a small reproducer)
>>>
>>> - An explanation of why leaving the client unfenced is appropriate
>>>
>>> - A discussion of what will happen when the server subsequently sends
>>>     another operation on this session slot
>> Here is the sequence of events that leads to NFS4ERR_RETRY_UNCACHED_REP:
>>
>> 1. Server sends CB_LAYOUTRECALL with stateID seqid 2
>> 2. Client replies NFS4ERR_NOMATCHING_LAYOUT
>> 3. Server does not receive the reply due to hard hang - no server thread
>>      available to service the reply (I will post a fix for this problem)
>> 4. Server RPC times out waiting for the reply, nfsd4_cb_sequence_done
>>      is called with cb_seq_status == 1, nfsd4_mark_cb_fault is called
>>      and the request is re-queued.
>> 5. Client receives the same CB_LAYOUTRECALL with stateID seqid 2
>>      again and this time client replies with NFS4ERR_RETRY_UNCACHED_REP.
>>
>> This process repeats forever from step 4.
>>
> I'm a little confused here. I could see that you might not be able to
> process a LAYOUTRETURN if all nfsd threads were blocked waiting for the
> break_layout(), but I don't get why that would blocks a CB_LAYOUTRECALL
> reply.
>
> For the server, CB_LAYOUTRECALL is a client RPC (server acts as client
> and vice versa). A CB_LAYOUTRECALL shouldn't depend on having a nfsd
> thread available, since it runs in the context of a workqueue thread.
>
> What am I missing?

This is call stack when the server receives the callback reply:

         receive_cb_reply+1
         svc_tcp_recvfrom+3531
         svc_handle_xprt+3747
         svc_recv+511
         nfsd+588
         kthread+916
         ret_from_fork+479
         ret_from_fork_asm+26

As shown, it requires a NFSD thread to service it. The NFSD thread eventually
calls xprt_complete_rqst to wake up the RPC task waiting for the reply.

-Dai

>

