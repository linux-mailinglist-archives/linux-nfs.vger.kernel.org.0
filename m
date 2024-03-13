Return-Path: <linux-nfs+bounces-2285-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E4487B48F
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Mar 2024 23:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9777F1C21825
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Mar 2024 22:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416A95D8E1;
	Wed, 13 Mar 2024 22:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JkavoSZi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vtUDqZ+v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB4C5D8E0
	for <linux-nfs@vger.kernel.org>; Wed, 13 Mar 2024 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370081; cv=fail; b=SIaCd8NClcImLECcO0MblGM5zgCQALs29lydrpNkPk010JrBkGbKLbjuXvf7HltVzGdkYuxCm7rAbZT1Jm169UbY0xUUtARV6twnDOPNRA7ISSAQe0WMotj2WuVNjiKAlizb6GA/8o6s/dAEy85Y8a0NMqZICNdmz1lWp8qNZJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370081; c=relaxed/simple;
	bh=a3ZMVvewlfrirH+kf8LJVzQdu5HpQKiNsVtWO4+FCTw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XR2gG3Xzaa43x79DYWkG5oQ8AT+a9g5V9i3OENHG129+gp5zCCIm1ig7xAlCGXBF3LQKY6PqU3vt28iQ1Ve+lLhYVU939BeZdPOH8W7UakCMEpxxzyHUlaMfP0iJ2OJmoekt4RRbIJNC4f8LKNOfUSd8z3M2hSwCFJ4VVsMYYC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JkavoSZi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vtUDqZ+v; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DKwdHe015521;
	Wed, 13 Mar 2024 22:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=JmLOWHzrtC+FuBdCqVhQb+RtLpyAuKOdqFtLiD4FMQU=;
 b=JkavoSZicr6+iurTotMFt8HbI21kXZ8ZIGtEewSM+YBElcAs+5NvwdvHUZQffCsrYGGa
 iJDNLriU3cRwvFrNeQfFbEIIQKhiOVf6xOOq42LJTODi8sngxaqkuJL/HIhShoC+wJEW
 vLKx995rd6zetvA0rZh03mdBFLiTxzVR3XITo8dktZvJKFxpKB5b9M17RwuOFRVMKWwx
 2K64fz0JWg29aZIEQsDN6P9ngX2iAcBx5qYD3zMDfYcU94eUbI4/SSn8E35v1/gRZHHh
 zLUE5ONei6k1k8WW6UC7jGtbEPM0bQ3ZB9wCiaE2VOXJ1RFGrCjVtbhEtE9CA9FbLP1E ww== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrej4286q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 22:45:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42DMe1Ka019729;
	Wed, 13 Mar 2024 22:45:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre79hdrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 22:45:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EY5K48P8iT+n+Yz7v02DDBUrkSrgX9IWiIs82hNTrRPGk2v7aB4AAG8QIU9hiGFWFcsWwiVEn/t7YFkPFYmpvXDu1uBlBbZ5vyszZddq9wbUlirfFoSYJVD1aeyTyzz5A6EZQZ9peWhsmY36MZRLFJqWqLPDJMnzgjUgifwtBlKxJAm4tHoxrktURzY/Ako8vpBHKbINMXs4QkuXF4dMzSvRnfygjI/NJ/LY6tQSI0duBtCImkfV3R3j/DpqGUkctSJUTgAuw7C46bM4dcH9X9THJ3whYmludL+MMhA/zBFylN70+oQ4zrf8G+qQTnyO+16eAGFxrrPIfzlTU6w1FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmLOWHzrtC+FuBdCqVhQb+RtLpyAuKOdqFtLiD4FMQU=;
 b=nu/aUfQYhgyi1Rr7bcjWMQQWKS+aVbFveQRJVt/mY6VQGPCaIzz4+OxZWASUBwGYTz87mqRXO9fOI9HcyIXDWbASSnwT2XSBsxls1xOkDqsdU/4uVoKZuykc24NmGDaPVodi3smX9bOK2Hy+WT2Qf3+DXazL8J42V88SKCwJspjSo9X60v7h/LSyL81UenPU+Q5C0ft/5QKQmf0pdETMtx1ltid1i7tcJFGhr3oX9OO3C/DHlBGVSZ3UzbqUyNC3CnI4oXLs1LQYzQMaaE3QoaJv1uB0wsBC9xRRsc8S6LWFQpvYjjV+cq+eTLQ0Kx59wXVDeIpdP2aRR1rKe7H6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmLOWHzrtC+FuBdCqVhQb+RtLpyAuKOdqFtLiD4FMQU=;
 b=vtUDqZ+vbQ/39uzkX7WWD/GJhCAshYajxF6SR2xP9saLMdwHKVTwaQLpFcQVrODYzLq2HGyz5EHtDXb594gT1xRaALd34CAygg+B+pwm5MHtZkb8vaVXgIwAaQgG4QCF+VjQYybKWaMa5TTFenL/IpomCRThtAP2STqODi41ay8=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH7PR10MB7695.namprd10.prod.outlook.com (2603:10b6:510:2e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 22:45:40 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3%3]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 22:45:40 +0000
Message-ID: <e6a35c75-ce3b-43f2-9657-308a094877cd@oracle.com>
Date: Wed, 13 Mar 2024 15:45:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd hangs and nfsd_break_deleg_cb+0x170/0x190 warning
Content-Language: en-US
To: Rik Theys <Rik.Theys@esat.kuleuven.be>, Jeff Layton <jlayton@kernel.org>,
        Linux Nfs <linux-nfs@vger.kernel.org>
References: <55366184-94bb-4054-8025-1125db3788ff@esat.kuleuven.be>
 <aeb9e7b96161ac247c247b90c143935e80c7faf8.camel@kernel.org>
 <df8cc19c-f12c-4f7b-947a-4e21f8b97685@oracle.com>
 <80c412ac-ea74-4836-9dae-8be6e3aec0e6@esat.kuleuven.be>
 <63a2600a-b916-4bb2-967a-4eaa8a143e35@oracle.com>
 <ffebc235-c0a2-4d9d-8428-9592811994eb@esat.kuleuven.be>
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <ffebc235-c0a2-4d9d-8428-9592811994eb@esat.kuleuven.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0072.namprd02.prod.outlook.com
 (2603:10b6:a03:54::49) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH7PR10MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 61708065-5b14-45cc-d7b2-08dc43af4f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wSucIGI1f69Sjuqr/RrusRNfZF3nD46W/UnMCaV28mkGlL8SStgGIQwMkfI1BEzP5oOjjnYHPYzIeGuwuW10LC/nB7x1sFClNZdRmEc8fw8/jhLLi4vuWlSdxy+bai3Nrx4OMAznutAGJXGJaVwinc/udhq1B5RWfzdjqxoWaBnbpH6S7+tVIC7uxBK5Y38ffk0T0y00Oq2rqI/7nZ8ktx+EtqhZu/ytbqZusr4PWo09a94PmfBlB3fWpm2lzI4RtOTNe7kuIWV7VfNYUNQkO0PiWlpPOhznX7kN08YJPhBd9glY+ck0A0k/t/pRxSDshuHCtGXLTjF1PMOQRXYXrbbjkZSjhXGywxBUXpDTClnNyu4l0M8QphNVOYIVUZKSq/66FBaTGmDoTqd9qK4jIOYtgUCDclVWlOlQslChzRh7yRa6JCfxLx3fonWXjG/rLaTFKuibBLmXSlGpesFTq68wt52XjsLCfzu8Qm/awM4tBYodzPWlBeiC3zbhLktzTcBwJSzd2tqrDUrzG6E4+RigKdDLKqHPg0IxySYiMuyN/Lqi41Oz5YAoUKC661kCEURba+kFCA9IfQuCzVKPPGxeflnuK+5dNNGzfEhAkSTKfZcXVy370uv4BOtxOr5QLtrEyQ5VCN+5UyxI4bC8OOOLh2UjfiUSq2tgJjTLAzw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TVg3a2gwUUM5Rk1FbWlCaVJTMUptR3o2ZTY3KzVQWW1rbi9abTVuNCtSZWFH?=
 =?utf-8?B?L0hySUpRd3VaUGxPSzVNQWtwWFhZcks0TXpQaWdCbFh6OVM5ZDZLd29Cb2xr?=
 =?utf-8?B?M0U2TXlFMEZTdHg1cTBVSVNvUERMaVhKT0JCc3lrZTdyMEdmNkZLQ3U5TTJR?=
 =?utf-8?B?WmZoWUY5ZDE2VytzYnphVzB0UVhvTnFaRmxzOGdHYUw1NkZRejdncjlUNnpG?=
 =?utf-8?B?WHFWRDVsZVR3VzhaU2gvVUpNazNGQzQrZnF3ak0rUzUwSVlzSkUxV3RoRkV2?=
 =?utf-8?B?RGtKQWc5ZmZXaEsyY3BIV01YQmRzWnpDdHdpdkJHNlRoWmRoOERSZDhZY1NR?=
 =?utf-8?B?U3NhM2cxRTZ3Qll5Y1JOWWZaL25KRmJBeTdKSXVSTUcxUXEzeURkYjhlbldW?=
 =?utf-8?B?aTdBeTJKOW94RFpDSzJZVW1kckNpc1NhOEZ2T295WnMzTUlZUGNDVkJrVDR1?=
 =?utf-8?B?aHNMZ01wcUt4WHlpTXdtaGZqRXA5K0dGczluN0FtNklwSVU1eUJ2MjVUN09t?=
 =?utf-8?B?a1VSeUl0Yk82ODJBeWxkUCtva0ZqS2oyWHhUY28wMXlYdXVZMHVvYldEeHQ3?=
 =?utf-8?B?L1pMYzYyNDhnZDB0SFVoRlVRdDIxdHJndlhjWCtqZWh6eGRRcEV0Tm1kY2RP?=
 =?utf-8?B?dThENTVwMHhzcnF3SXMzSzU1KzhwWW96VE95eHV4YVdlbGtwTTJoSXBOSGhF?=
 =?utf-8?B?T2hWQWFuS3VLeE9yWWpqcXpSbFRiUzhzVHRtS3lta1pwdkk5MWoycWNrSDcz?=
 =?utf-8?B?UTlWZCs0b1lQRy81SlVqT1U0NW5VN0E3eHRBM0szNG5qYXNOQm9SbCtjZlRw?=
 =?utf-8?B?TW85TjJ3OWpyd3FpTDFwZTQwNGNPUzR6dlhJSm9tUGdSTG9wTmd4Vy9KNHhp?=
 =?utf-8?B?bm4rZm9DUnVRUGJDMTRSdFBUSjJmQlRTVkZJbnNvQml3TTE4YWYzMW14Nm5k?=
 =?utf-8?B?YTF0RzhvdUJPUUx2aXN1L3RNVFRKWE1BN21yYWNvN2JGR2tzZ2J6TDViazJk?=
 =?utf-8?B?eDgvNEI5RW1wazRmbUl3Nzl4YzZvWnpsdkwzMmY0YWxPckVNZVJCeVJZM2Yy?=
 =?utf-8?B?Z0ppbnJBdExRSTQ3MjB4ejYzWldWT0hlM2JMdi9PM2dTdDl3UzJjaTRyd1Rj?=
 =?utf-8?B?eXA5MUNqWGNXeDBaOUJPb0hzYy9LVG1DME8weHB0d01kNnphUndUa1MzQnZp?=
 =?utf-8?B?SmFVa240Z2xqdDh5aUh6UnBzUklpQjl6eTk0V1d4V3NJeUpQK0V0OE1BamhR?=
 =?utf-8?B?am9CRVhKOGY4VDZMTkFnbWt1N1BJRjB5UStkRHcrTDJiM1BLTjljbmVVclNh?=
 =?utf-8?B?UHlvYThNRjFDVWk1Z0lTc1RzSW01TzAzVkZ5U0VuWHJyM3phOUxlaTJ4T3VX?=
 =?utf-8?B?TXdYakZJamtoaEszaCtQRXJ1MTFRTjFsb1pQalpBeWMwSGVMTnVKVDVINkox?=
 =?utf-8?B?ZFFjVnJDVXlHL0FkYU9rQ3dORncwTlJnbnlIdzl3WHVqT2VMLzdDRTRsMk8z?=
 =?utf-8?B?cC9TcVlxbjczV0ZVdnZ0Tk03NmY0VkI2eFhWd3JrTFV2cEFCUmxtUU9UOUQ1?=
 =?utf-8?B?SHdMT3daTmVGd0pXYjg0dkRudVVnaEJmY1FZWmNsZzE1dE96V2dpN2g0a2ZQ?=
 =?utf-8?B?djRWRVhWV1JkcTRVcVVjRDI3Mm5Kb0RsQXlTK0xHUDVXZHR1Q21yZFUxUjF4?=
 =?utf-8?B?NG92MUJLMm0yYWhaV1pHQkx0S3JYRlh4QS80VlcwVzVvTmtyemVveEpBem9k?=
 =?utf-8?B?cktTVXB5aHNibXdqVmNOWEM2ZWt3cmMzeFpna1ljb09sbldNMzRZdDVXQ25j?=
 =?utf-8?B?UkZYQ21VVDlVT3dhWGVBUnQzblhmUHVjZ0puWVBVSmZSUnZmSzlNNHN6Z2VN?=
 =?utf-8?B?bFRHbDU3YllXeStmNWRpajhwVlgxSXB6WUJsSDVJa3Z5dkh1eWh4dzM5RUxK?=
 =?utf-8?B?T3E3dlQ4UUp5QWhqZUc1TE1PY3B0Y2VNVzFvQmFnM3BTSFRvTzlYd0NUYThK?=
 =?utf-8?B?bnlJbUxSMHVQdHArZXZJSEsvZFdIYkVSRS9ITUtJY1l6NXZEc256NmxzUUVB?=
 =?utf-8?B?UzIrOUxmUHBVSFZIRnVqdkZDWDhBWVE0TENqT1E5YnpyMThqRWVqck9STWI3?=
 =?utf-8?Q?OfIkvbgd7tNQzfyvXnSNw22QJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JsvThy1LRCgYrFTXAdoF4s1m4TESrpt/fHseiALAW4VkybrcUiwiYT1cb2EQCQc5Zn3Ej6qRE90LA2AGHxxR7ZzHEjC5hSn8WCqWago8VaMtnZywCsiJGx//EzPpKEvX9I0SPbj1LXhJU1NGdz5XRtBWOJ7zF0pBXp+OtEhh97XtaYCVYKsubUwscrAO74vexQ3TNatJ0O5J/Up3vee0OdH4+yY6b7TLDEfrFXbAfTBFXMMJco/hPfZoU0/eXapDD9/UefjuOlX3p168aYyL7jUVxxtnYNEv+/9Xnmgo31biockN91B480sNVMcLR8kCT4NpTbb3FdtvIPeQWQYfVWJ8bXijMB5WKZM0P6Q0ot2OU6CYOU4EfqjNzfxQnySNw9WaZPvAjQJS2YJBGF3GKBMMIq/BVgYEwoy/EhDHKehFvykstm7NEUgc+/yOQIgKeS8zeJGyGelmH0ZWqM567qHnovXhb017oViVWAg50YNnBYxphocNNMFeskZBLYCVQYOfFJyARM2WG9lS0o4CHHbUrQ6zVkU0z1rU/ePWpc+Wy+8Vc2Gl8s/cgwguixbzdnRtLkGRbQTQLZlhKaYQg87REu2/u7oEMABnu2zpihk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61708065-5b14-45cc-d7b2-08dc43af4f07
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 22:45:40.6138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyD+TOuQ20L3FDKKIDeoUyqZU0Nzm5O0tB0eIq8A1OZyv0gaOge5RpbL+L+0k892nNcAbJE7fHVMccasDzlDEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7695
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403130174
X-Proofpoint-GUID: 3rJMFPcJATHM-DJ8gb3Es71X1tYnFZQh
X-Proofpoint-ORIG-GUID: 3rJMFPcJATHM-DJ8gb3Es71X1tYnFZQh


On 3/13/24 12:50 PM, Rik Theys wrote:
> Hi,
>
> On 3/13/24 19:44, Dai Ngo wrote:
>>
>> On 3/12/24 11:23 AM, Rik Theys wrote:
>>> Hi,
>>>
>>> On 3/12/24 17:43, Dai Ngo wrote:
>>>>
>>>> On 3/12/24 4:37 AM, Jeff Layton wrote:
>>>>> On Mon, 2024-03-11 at 19:43 +0100, Rik Theys wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>>
>>>>>>
>>>>>> Since a few weeks our Rocky Linux 9 NFS server has periodically 
>>>>>> logged hung nfsd tasks. The initial effect was that some clients 
>>>>>> could no longer access the NFS server. This got worse and worse 
>>>>>> (probably as more nfsd threads got blocked) and we had to restart 
>>>>>> the server. Restarting the server also failed as the NFS server 
>>>>>> service could no longer be stopped.
>>>>>>
>>>>>>
>>>>>>
>>>>>> The initial kernel we noticed this behavior on was 
>>>>>> kernel-5.14.0-362.18.1.el9_3.x86_64. Since then we've installed 
>>>>>> kernel-5.14.0-419.el9.x86_64 from CentOS Stream 9. The same issue 
>>>>>> happened again on this newer kernel version:
>>>>>>
>>>>>>
>>>>>>
>>>>>> [Mon Mar 11 14:10:08 2024]       Not tainted 
>>>>>> 5.14.0-419.el9.x86_64 #1
>>>>>>   [Mon Mar 11 14:10:08 2024] "echo 0 > 
>>>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>>   [Mon Mar 11 14:10:08 2024] task:nfsd            state:D stack:0 
>>>>>>     pid:8865  ppid:2      flags:0x00004000
>>>>>>   [Mon Mar 11 14:10:08 2024] Call Trace:
>>>>>>   [Mon Mar 11 14:10:08 2024]  <TASK>
>>>>>>   [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>>>>>   [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>>>>>   [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>>>>>   [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>>>>>   [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>>>>>   [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_schedule_timeout+0x10/0x10
>>>>>>   [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>>>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_shutdown_callback+0x49/0x120 
>>>>>> [nfsd]
>>>>>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_cld_remove+0x54/0x1d0 [nfsd]
>>>>>>   [Mon Mar 11 14:10:08 2024]  ? 
>>>>>> nfsd4_return_all_client_layouts+0xc4/0xf0 [nfsd]
>>>>>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_shutdown_copy+0x68/0xc0 [nfsd]
>>>>>>   [Mon Mar 11 14:10:08 2024]  __destroy_client+0x1f3/0x290 [nfsd]
>>>>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_exchange_id+0x75f/0x770 [nfsd]
>>>>>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_decode_opaque+0x3a/0x90 [nfsd]
>>>>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>>>>   [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>>>   [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660 
>>>>>> [sunrpc]
>>>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>>>   [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>>>   [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>>>   [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>>>>>   [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>>>>>   [Mon Mar 11 14:10:08 2024]  </TASK>
>>>>>>   [Mon Mar 11 14:10:08 2024] INFO: task nfsd:8866 blocked for 
>>>>>> more than 122 seconds.
>>>>>>   [Mon Mar 11 14:10:08 2024]       Not tainted 
>>>>>> 5.14.0-419.el9.x86_64 #1
>>>>>>   [Mon Mar 11 14:10:08 2024] "echo 0 > 
>>>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>>   [Mon Mar 11 14:10:08 2024] task:nfsd            state:D stack:0 
>>>>>>     pid:8866  ppid:2      flags:0x00004000
>>>>>>   [Mon Mar 11 14:10:08 2024] Call Trace:
>>>>>>   [Mon Mar 11 14:10:08 2024]  <TASK>
>>>>>>   [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>>>>>   [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>>>>>   [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>>>>>   [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>>>>>   [Mon Mar 11 14:10:08 2024]  ? tcp_recvmsg+0x196/0x210
>>>>>>   [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>>>>>   [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_schedule_timeout+0x10/0x10
>>>>>>   [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>>>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_destroy_session+0x1a4/0x240 
>>>>>> [nfsd]
>>>>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>>>>   [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>>>   [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660 
>>>>>> [sunrpc]
>>>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>>>   [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>>>   [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>>>   [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>>>>>   [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>>>>>   [Mon Mar 11 14:10:08 2024]  </TASK>
>>>>>>
>>>>>>
>>>>>>
>>>>>>   The above is repeated a few times, and then this warning is 
>>>>>> also logged:
>>>>>>
>>>>>>
>>>>>>
>>>>>> [Mon Mar 11 14:12:04 2024] ------------[ cut here ]------------
>>>>>>   [Mon Mar 11 14:12:04 2024] WARNING: CPU: 39 PID: 8844 at 
>>>>>> fs/nfsd/nfs4state.c:4919 nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>>>   [Mon Mar 11 14:12:05 2024] Modules linked in: nfsv4 
>>>>>> dns_resolver nfs fscache netfs rpcsec_gss_krb5 rpcrdma rdma_cm 
>>>>>> iw_cm ib_cm ib_core binfmt_misc bonding tls rfkill nft_counter 
>>>>>> nft_ct
>>>>>>   nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_reject_inet 
>>>>>> nf_reject_ipv4 nf_reject_ipv6 nft_reject nf_tables nfnetlink vfat 
>>>>>> fat dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio l
>>>>>>   ibcrc32c dm_service_time dm_multipath intel_rapl_msr 
>>>>>> intel_rapl_common intel_uncore_frequency 
>>>>>> intel_uncore_frequency_common isst_if_common skx_edac nfit 
>>>>>> libnvdimm ipmi_ssif x86_pkg_temp
>>>>>>   _thermal intel_powerclamp coretemp kvm_intel kvm irqbypass 
>>>>>> dcdbas rapl intel_cstate mgag200 i2c_algo_bit drm_shmem_helper 
>>>>>> dell_smbios drm_kms_helper dell_wmi_descriptor wmi_bmof intel_u
>>>>>>   ncore syscopyarea pcspkr sysfillrect mei_me sysimgblt acpi_ipmi 
>>>>>> mei fb_sys_fops i2c_i801 ipmi_si intel_pch_thermal lpc_ich 
>>>>>> ipmi_devintf i2c_smbus ipmi_msghandler joydev acpi_power_meter
>>>>>>   nfsd auth_rpcgss nfs_acl drm lockd grace fuse sunrpc ext4 
>>>>>> mbcache jbd2 sd_mod sg lpfc
>>>>>>   [Mon Mar 11 14:12:05 2024]  nvmet_fc nvmet nvme_fc nvme_fabrics 
>>>>>> crct10dif_pclmul ahci libahci crc32_pclmul nvme_core crc32c_intel 
>>>>>> ixgbe megaraid_sas libata nvme_common ghash_clmulni_int
>>>>>>   el t10_pi wdat_wdt scsi_transport_fc mdio wmi dca dm_mirror 
>>>>>> dm_region_hash dm_log dm_mod
>>>>>>   [Mon Mar 11 14:12:05 2024] CPU: 39 PID: 8844 Comm: nfsd Not 
>>>>>> tainted 5.14.0-419.el9.x86_64 #1
>>>>>>   [Mon Mar 11 14:12:05 2024] Hardware name: Dell Inc. PowerEdge 
>>>>>> R740/00WGD1, BIOS 2.20.1 09/13/2023
>>>>>>   [Mon Mar 11 14:12:05 2024] RIP: 
>>>>>> 0010:nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>>>   [Mon Mar 11 14:12:05 2024] Code: a6 95 c5 f3 e9 ff fe ff ff 48 
>>>>>> 89 df be 01 00 00 00 e8 34 b5 13 f4 48 8d bb 98 00 00 00 e8 c8 f9 
>>>>>> 00 00 84 c0 0f 85 2e ff ff ff <0f> 0b e9 27 ff ff ff be
>>>>>>   02 00 00 00 48 89 df e8 0c b5 13 f4 e9 01
>>>>>>   [Mon Mar 11 14:12:05 2024] RSP: 0018:ffff9929e0bb7b80 EFLAGS: 
>>>>>> 00010246
>>>>>>   [Mon Mar 11 14:12:05 2024] RAX: 0000000000000000 RBX: 
>>>>>> ffff8ada51930900 RCX: 0000000000000024
>>>>>>   [Mon Mar 11 14:12:05 2024] RDX: ffff8ada519309c8 RSI: 
>>>>>> ffff8ad582933c00 RDI: 0000000000002000
>>>>>>   [Mon Mar 11 14:12:05 2024] RBP: ffff8ad46bf21574 R08: 
>>>>>> ffff9929e0bb7b48 R09: 0000000000000000
>>>>>>   [Mon Mar 11 14:12:05 2024] R10: ffff8aec859a2948 R11: 
>>>>>> 0000000000000000 R12: ffff8ad6f497c360
>>>>>>   [Mon Mar 11 14:12:05 2024] R13: ffff8ad46bf21560 R14: 
>>>>>> ffff8ae5942e0b10 R15: ffff8ad6f497c360
>>>>>>   [Mon Mar 11 14:12:05 2024] FS:  0000000000000000(0000) 
>>>>>> GS:ffff8b031fcc0000(0000) knlGS:0000000000000000
>>>>>>   [Mon Mar 11 14:12:05 2024] CS:  0010 DS: 0000 ES: 0000 CR0: 
>>>>>> 0000000080050033
>>>>>>   [Mon Mar 11 14:12:05 2024] CR2: 00007fafe2060744 CR3: 
>>>>>> 00000018e58de006 CR4: 00000000007706e0
>>>>>>   [Mon Mar 11 14:12:05 2024] DR0: 0000000000000000 DR1: 
>>>>>> 0000000000000000 DR2: 0000000000000000
>>>>>>   [Mon Mar 11 14:12:05 2024] DR3: 0000000000000000 DR6: 
>>>>>> 00000000fffe0ff0 DR7: 0000000000000400
>>>>>>   [Mon Mar 11 14:12:05 2024] PKRU: 55555554
>>>>>>   [Mon Mar 11 14:12:05 2024] Call Trace:
>>>>>>   [Mon Mar 11 14:12:05 2024]  <TASK>
>>>>>>   [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>>>>>   [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>>>>>   [Mon Mar 11 14:12:05 2024]  ? __break_lease+0x16f/0x5f0
>>>>>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 
>>>>>> [nfsd]
>>>>>>   [Mon Mar 11 14:12:05 2024]  ? __warn+0x81/0x110
>>>>>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 
>>>>>> [nfsd]
>>>>>>   [Mon Mar 11 14:12:05 2024]  ? report_bug+0x10a/0x140
>>>>>>   [Mon Mar 11 14:12:05 2024]  ? handle_bug+0x3c/0x70
>>>>>>   [Mon Mar 11 14:12:05 2024]  ? exc_invalid_op+0x14/0x70
>>>>>>   [Mon Mar 11 14:12:05 2024]  ? asm_exc_invalid_op+0x16/0x20
>>>>>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 
>>>>>> [nfsd]
>>>>>>   [Mon Mar 11 14:12:05 2024]  __break_lease+0x16f/0x5f0
>>>>>>   [Mon Mar 11 14:12:05 2024]  ? 
>>>>>> nfsd_file_lookup_locked+0x117/0x160 [nfsd]
>>>>>>   [Mon Mar 11 14:12:05 2024]  ? list_lru_del+0x101/0x150
>>>>>>   [Mon Mar 11 14:12:05 2024]  nfsd_file_do_acquire+0x790/0x830 
>>>>>> [nfsd]
>>>>>>   [Mon Mar 11 14:12:05 2024]  nfs4_get_vfs_file+0x315/0x3a0 [nfsd]
>>>>>>   [Mon Mar 11 14:12:05 2024]  nfsd4_process_open2+0x430/0xa30 [nfsd]
>>>>>>   [Mon Mar 11 14:12:05 2024]  ? fh_verify+0x297/0x2f0 [nfsd]
>>>>>>   [Mon Mar 11 14:12:05 2024]  nfsd4_open+0x3ce/0x4b0 [nfsd]
>>>>>>   [Mon Mar 11 14:12:05 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>>>>   [Mon Mar 11 14:12:05 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>>>   [Mon Mar 11 14:12:05 2024]  svc_process_common+0x2ec/0x660 
>>>>>> [sunrpc]
>>>>>>   [Mon Mar 11 14:12:05 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>>>>   [Mon Mar 11 14:12:05 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>>>   [Mon Mar 11 14:12:05 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>>>   [Mon Mar 11 14:12:05 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>>>   [Mon Mar 11 14:12:05 2024]  kthread+0xdd/0x100
>>>>>>   [Mon Mar 11 14:12:05 2024]  ? __pfx_kthread+0x10/0x10
>>>>>>   [Mon Mar 11 14:12:05 2024]  ret_from_fork+0x29/0x50
>>>>>>   [Mon Mar 11 14:12:05 2024]  </TASK>
>>>>>>   [Mon Mar 11 14:12:05 2024] ---[ end trace 7a039e17443dc651 ]---
>>>>> [Mon Mar 11 14:29:16 2024] task:kworker/u96:3   state:D 
>>>>> stack:0     pid:2451130 ppid:2      flags:0x00004000
>>>>> [Mon Mar 11 14:29:16 2024] Workqueue: nfsd4_callbacks 
>>>>> nfsd4_run_cb_work [nfsd]
>>>>> [Mon Mar 11 14:29:16 2024] Call Trace:
>>>>> [Mon Mar 11 14:29:16 2024]  <TASK>
>>>>> [Mon Mar 11 14:29:16 2024]  __schedule+0x21b/0x550
>>>>> [Mon Mar 11 14:29:16 2024]  schedule+0x2d/0x70
>>>>> [Mon Mar 11 14:29:16 2024]  schedule_timeout+0x88/0x160
>>>>> [Mon Mar 11 14:29:16 2024]  ? __pfx_process_timeout+0x10/0x10
>>>>> [Mon Mar 11 14:29:16 2024]  rpc_shutdown_client+0xb3/0x150 [sunrpc]
>>>>> [Mon Mar 11 14:29:16 2024]  ? 
>>>>> __pfx_autoremove_wake_function+0x10/0x10
>>>>> [Mon Mar 11 14:29:16 2024] nfsd4_process_cb_update+0x3e/0x260 [nfsd]
>>>>> [Mon Mar 11 14:29:16 2024]  ? sched_clock+0xc/0x30
>>>>> [Mon Mar 11 14:29:16 2024]  ? raw_spin_rq_lock_nested+0x19/0x80
>>>>> [Mon Mar 11 14:29:16 2024]  ? newidle_balance+0x26e/0x400
>>>>> [Mon Mar 11 14:29:16 2024]  ? pick_next_task_fair+0x41/0x500
>>>>> [Mon Mar 11 14:29:16 2024]  ? put_prev_task_fair+0x1e/0x40
>>>>> [Mon Mar 11 14:29:16 2024]  ? pick_next_task+0x861/0x950
>>>>> [Mon Mar 11 14:29:16 2024]  ? __update_idle_core+0x23/0xc0
>>>>> [Mon Mar 11 14:29:16 2024]  ? __switch_to_asm+0x3a/0x80
>>>>> [Mon Mar 11 14:29:16 2024]  ? finish_task_switch.isra.0+0x8c/0x2a0
>>>>> [Mon Mar 11 14:29:16 2024]  nfsd4_run_cb_work+0x9f/0x150 [nfsd]
>>>>> [Mon Mar 11 14:29:16 2024]  process_one_work+0x1e2/0x3b0
>>>>> [Mon Mar 11 14:29:16 2024]  worker_thread+0x50/0x3a0
>>>>> [Mon Mar 11 14:29:16 2024]  ? __pfx_worker_thread+0x10/0x10
>>>>> [Mon Mar 11 14:29:16 2024]  kthread+0xdd/0x100
>>>>> [Mon Mar 11 14:29:16 2024]  ? __pfx_kthread+0x10/0x10
>>>>> [Mon Mar 11 14:29:16 2024]  ret_from_fork+0x29/0x50
>>>>> [Mon Mar 11 14:29:16 2024]  </TASK>
>>>>>
>>>>> The above is the main task that I see in the cb workqueue. It's 
>>>>> trying to call rpc_shutdown_client, which is waiting for this:
>>>>>
>>>>>                  wait_event_timeout(destroy_wait,
>>>>> list_empty(&clnt->cl_tasks), 1*HZ);
>>>>>
>>>>> ...so basically waiting for the cl_tasks list to go empty. It 
>>>>> repeatedly
>>>>> does a rpc_killall_tasks though, so possibly trying to kill this 
>>>>> task?
>>>>>
>>>>>      18423 2281      0 0x18 0x0     1354 nfsd4_cb_ops [nfsd] 
>>>>> nfs4_cbv1 CB_RECALL_ANY a:call_start [sunrpc] q:delayq
>>>>
>>>> I wonder why this task is on delayq. Could it be related to memory
>>>> shortage issue, or connection related problems?
>>>> Output of /proc/meminfo on the nfs server at time of the problem
>>>> would shed some light.
>>>
>>> We don't have that anymore. I can check our monitoring host more 
>>> closely for more fine grained stats tomorrow, but when I look at the 
>>> sar statistics (see attachment) nothing special was going on memory 
>>> or network wise.
>>
>> Thanks Rik for the info.
>>
>> At 2:10 PM sar statistics shows:
>> kbmemfree:  1014880
>> kbavail:    170836368
>> kbmemused:  2160028
>> %memused:   1.10
>> kbcached:   140151288
>>
>> Paging stats:
>>               pgpgin/s pgpgout/s   fault/s  majflt/s  pgfree/s 
>> pgscank/s pgscand/s pgsteal/s    %vmeff
>> 02:10:00 PM   2577.67 491251.09   2247.01      0.00 2415029.61 
>> 75131.80      0.00 150276.28    200.02
>>
>> The kbmemfree is pretty low and the caches consume large amount of 
>> memory.
>> The paging statistics also show lots of paging activities, 150276.28/s.
>>
> The workload at that time was a write-heavy workload. The writes were 
> probably all going to memory until the buffers filled up (or the ext4 
> commit interval?) and was then written out to disk. And then the 
> process repeated itself as a large part of the writes were rewriting 
> the same files over and over again.
>> In the previous rpc_tasks.txt, it shows a RPC task is on the delayq 
>> waiting
>> to send the CB_RECALL_ANY. With this version of the kernel, the only 
>> time
>> CB_RECALL_ANY is sent is when the system is under memory pressure and 
>> the
>> nfsd shrinker task runs to free unused delegations.
>
> Would it help to increase /proc/sys/vm/min_free_kbytes in this case?

I'm not a VM subsystem expert but I've seen recommendation to set this
value to 1% of total memory.

>
>
>> Next time when this problem happens again, you can try to reclaim some
>> memory from the caches to see if it helps:
>>
>> # echo 3 > /proc/sys/vm/drop_caches
>
> Do you think this could help the system recover at that point?

There is no guarantee but it's worth a try.

-Dai

>
> Regards,
>
> Rik
>
>>
>> -Dai
>>
>>
>>
>>
>>>
>>> We start to get the cpu stall messages and the system load starts to 
>>> rise (starts around 2:10 PM). At 3:00 PM we restart the server as 
>>> our users can no longer work.
>>>
>>> Looking at the stats, the cpu's were ~idle. The only thing that may 
>>> be related is that around 11:30 AM the write load (rx packets) 
>>> starts to get a lot higher than the read load (tx packets). This 
>>> goes on for hours (even after the server was restarted) and that 
>>> workload was later identified. It was a workload that was constantly 
>>> rewriting a statistics file.
>>>
>>> Regards,
>>>
>>> Rik
>>>
>>>
>>>>
>>>> Currently there is only 1 active task allowed for the nfsd callback
>>>> workqueue at a time. If for some reasons a callback task is stuck in
>>>> the workqueue it will block all other callback tasks which can effect
>>>> multiple clients.
>>>>
>>>> -Dai
>>>>
>>>>>
>>>>> Callbacks are soft RPC tasks though, so they should be easily 
>>>>> killable.
>>>

