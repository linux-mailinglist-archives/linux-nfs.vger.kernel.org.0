Return-Path: <linux-nfs+bounces-16557-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80245C6FEFE
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 17:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D1314300D1
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 16:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DD436E559;
	Wed, 19 Nov 2025 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nIbAC3MP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dFg8+PT7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03B036E543
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568136; cv=fail; b=nnMO0M15pEXwVTwdPojc4jCFOh9RWPhtpeBQMl7V429b5yAa8S9DSvSfq9kdDw18AOqDBEktan8ms4RcHn8zeyDAtvBLpHr67snoihQvEC4wt41rCsN/DbDYN213PHI+P5U0MCpZqxr8wk9foHcO/OpYe97rFeyI2lEY9JWe0P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568136; c=relaxed/simple;
	bh=uM4dlH61wVBlvrmTBHJbVjLTX25MoUGdoKcdhTdDJf8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qd4eHL5P8OZWmUpuDVUfH9SCwz+XFBLjiqKQ8tL1B7sXxg3zg86AmdZLLGLuz3ekmwjpc5eKg04EDvhQyY0TwaQybp2m28o/7zeEu6BFW40ajvLWIDBxj2fcZ8aOB/mzMq9b3PJAtjIrwb6PgXFwWvXjzHV05xQFqarTHM5ZQGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nIbAC3MP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dFg8+PT7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJEfxbg001715;
	Wed, 19 Nov 2025 16:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tubC4+JtvJaD//iVdvterFHloMQGhKqoT98fL6hjfrc=; b=
	nIbAC3MP3UNWqZA8B6RSZlfi88QJWqyCte4bTECvOY/rs32Nn8/Ad5EXscQIzylQ
	sQnsyPvKv9dyOFv9cS6Z7ZuKYJYeemptoKY6F1QkRCkjMSFtyYEp0fFdiCYdH0Bw
	8Q4Vo4aaoiswKgXQwpgfEoTHzukTG7cxToYE51oTnE8NtsS9jZfNckKh0cZFXQLP
	aYOkR1TAqCeGFnTshjVLAh8zgAw511acZtlygMHC1GaVLcP3nuWXd5TrhahPU/Ft
	nV9uAtHoKvHBFHLA3jNSrGoNzH28KUhwbHAmJ1TKgTVLGCWb2hlkkMAAEk002ODg
	3Pyqx6FJ9TFhW5S1IgS9Jw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbuq78y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:02:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJFLIEs002427;
	Wed, 19 Nov 2025 16:02:06 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyasqph-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:02:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnVzRDM31DeytdUS+RJ+lMm7+YCf6gPxkMr1QU4Q64MF8H0LXXq5lQG48arNHNi9y7y5e8pPw0Giyq4mk6sJ81+8b4gGXpqb30kkp5WtoUEOxn2xHB2s+DfFoLngU6Xlfm4R4xKtU3npG0/Lno4kQFh7+17wbM5Xa/9AKQWGlVw2XbimkFJ82Z+Ey57lhTrFafXJDwg0Fex+eHllIPMMMYqyBNIpbAb6cFt7NB4whrVB+IiiskhSFlGT4UcIojvmHIARkdwdKp40nfRBW/4+VD0hYLtwVCe1LE2c/URJUm5ip2lQi9C8e3VPbP+NlTmkAx2J/itM8Pdm4kzDjphD1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tubC4+JtvJaD//iVdvterFHloMQGhKqoT98fL6hjfrc=;
 b=PUXKmzvKj2PgaqLlLYR+onMM6yAycBGx+KRaiQ1O5BNeGJjmFPJlL5tjp8Xb3skADSHGmydWFAtY2lorNE4dgM3zVJyxqiP/XFm4XixQc8IjyR0Ju5tu+8wvH+1hoHTa2ZpSGzKw23DjG1VkpNYRjcI9JNrzeLrn0yMPVsqJfYk3h0/+0lXPxOdlckKnh2l7EJtT0rE6r1MxPkkR1FaQpz7Qz6K+JDmD0eRIOse/Uylf9EEbK2NCe04lftbTR2htuJTa2a9TbUbPHWPW6OiQ9+UKQH8veVEwEI26eTdfASlwcE0pqkfnW6oC2XptWX2wSgvR1XzEJr/OdDcEyaGxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tubC4+JtvJaD//iVdvterFHloMQGhKqoT98fL6hjfrc=;
 b=dFg8+PT7XHLZqnP6W4IZE91e/o2GgXYh3i6yOEMDJAEbe921gUcVgTyXpiXIhr5RXpuFw86HqHUo6m3IdfhUuXng4nw9j7Od3XcOt0pkHd5QBMlN++Fn2Skiw3eTehQhDE4gL9K0Mn7kWfL/QBXLInOWvMswqOq5AFOxzivdvpw=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by PH8PR10MB6340.namprd10.prod.outlook.com (2603:10b6:510:1cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:02:02 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:02:02 +0000
Message-ID: <a27cc4b9-20c2-4065-97d5-81683f686195@oracle.com>
Date: Wed, 19 Nov 2025 11:02:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/11] nfsd: rename ALLOWED_WITHOUT_FH to
 ALLOWED_WITHOUT_LOCAL_FH and revise use
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251119033204.360415-1-neilb@ownmail.net>
 <20251119033204.360415-2-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251119033204.360415-2-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0042.namprd07.prod.outlook.com
 (2603:10b6:610:5b::16) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|PH8PR10MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: cc7b808c-531f-4a90-43cd-08de2784fa56
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MHRaciszTlB0aTZvbkpDeG9sUTRxVytkUmpXK1c4R3ZzRmZjbmRseG5NVFdT?=
 =?utf-8?B?TFRsMHdBbFlEVW1BVlVxb3NMNHNyTThPdEVUckRuSXh2R1ljL3VUV3owRzdX?=
 =?utf-8?B?amh1V2hxdGxtY2M5UHR4dDNURDlmSFlOUjNFbVNrcjNMVCtMVlR4TGdVUnZm?=
 =?utf-8?B?dTFkZHRMMnFBdGVrbEZRNkppYjJZbmpnbk9VeS9YUXlTQkIybVNuY2Z0L1Bx?=
 =?utf-8?B?cTd4T0d5aG9UMXV2Vzl2MGR2NnNuSHJCK1ByQTErUUUxQVUvV1hnZGo2Y2VI?=
 =?utf-8?B?NE9HOGQxZzVMZVluWEhUTHh1cUlieVQ5Vjg0dUtVTmp6YStNVUQwWHM5VHkr?=
 =?utf-8?B?VnluYSt3NVdJbE13Wlh1L3VoZDVzVUJ4dmRCa2R4RDJyeXdjZ29GQVd4RUJR?=
 =?utf-8?B?d0dkbmt2bGt6c2xWVDM4R0gvNkl0NVFHdnFyVktIOWx5WWl3ZXU0U1QwaXBM?=
 =?utf-8?B?cGNZK01NdjJ1Ukw3Yk1Ldis2ZHV0dDl1cThFWGw2Tk1Ma3JZNmQ5NWxVeXZk?=
 =?utf-8?B?SUJOTVlzWVZ1UWZtdENtajY1b1czUktoTVZFaFRIOFQwTjRyRWJHRHRxcG16?=
 =?utf-8?B?WXd6cWkrYnZQMUdnM3EwUzA5YTFiZ2MrMW1zL0dxMHhFa2VoTlVRUFNnYmZ4?=
 =?utf-8?B?QWpGY3VyMG00akU4eno5eTNJbDdLQ3BHRG5iZU1MYnRDalJHMXk5NU9XMHFn?=
 =?utf-8?B?MVRtcGExVWpCc2VTRGdEYTNMUlFYZm05M1lqNXAyVjJhZnFyVElCODNORGpz?=
 =?utf-8?B?RmpSdEtGU3RyWW0wRTJyOVErTCtHSE00MnhmeWFycis5YmpvUEtOaXNLdity?=
 =?utf-8?B?WG5aS3JkelF6dTNTYjhjaFBQWDRYMVVEMTcyTzV5R1V6c2hxcmJ0bXl5ZjJB?=
 =?utf-8?B?Mk5qYmJvWUNsTWNYV0lyT3djNkMxdk9hZklMRkE2c2NtQXE5UW5hM3puMHh6?=
 =?utf-8?B?Q2d3NStIS0xXVVhBQjVBWURkRmpFZDNmTTFJL1c0dkh2anFOZVRRR2doWTVD?=
 =?utf-8?B?VVFJTm84VzJsNmtmajdpZW1LR2ZmOVBXeXhZMitwd1hEekdjTmVDWjZMakZ6?=
 =?utf-8?B?dXFHWmU3a0c1OHBVTGs5cWNzQnlLOVkwTlFvSmcxYlJLTWcwSTVPM2hJWjM3?=
 =?utf-8?B?MjRxWDg1TUVlVjVKNENOeDNFaGhyY2M5WDBSRU5YWlVsV3lNNFhrS2lQSk90?=
 =?utf-8?B?a2dQVjVoUk5ZQXpaSjA4d1ZWVmNZVVBidmxSNUw5QzN1NkVvK1ZyZzFyTnhE?=
 =?utf-8?B?TjRJdkNKbjNEazYwUHZvV05WNWZ1WjB0NFdFQmFLcUZ0Z05WT2M1R0VEandn?=
 =?utf-8?B?R1J6TFhPek9UZFJCdU9MUmZGSHZjMDluTGw4OGJqNlU3THh0Tll1cGk5UjdP?=
 =?utf-8?B?ejFqNmE2aUJYRzBUOEZKRVZvTWRYREVGR0t5WFNtR3dBb2oxMDlHUVdqS3B3?=
 =?utf-8?B?UmJoemVGTkhOaUp6cmZrYWZyQ2VYeUhPZnlzaXAxNnBqZ3B4L3NLSVloeU55?=
 =?utf-8?B?MFFlWUd0NGh5U1FJRzEwWSt5SUp0V25IbDZxWUdKN3ZFc3VkdGZEeFM0K3gz?=
 =?utf-8?B?QThrbDl3N2dINVVnT3BWUzVTWStWejAzMWJCdHgxKzhrWnpiVHJnVlhPbDhr?=
 =?utf-8?B?UW9jQno0UnNiWEVCMVZzeUxSVWsray9OMGpLaVk0WjdlRU5GMkNCdGxiWUw2?=
 =?utf-8?B?WkZpYk5Rb0pKUmZxSEdDQW94Wkh3VE1uZkkwWkNBT2ZlblRvd2l6ekhmNk5h?=
 =?utf-8?B?WTU0azBqSUxqejhTaHNBZllLUUxiWGdCYnBBdVFUQ2pjeWNLeDR5N3k5bjIv?=
 =?utf-8?B?S2xMMkNqTzlzcFEvSVJBcTZ0bkl5Wm5jZ2N6dGVtcllhYVlUVUQ2a1B1ZGty?=
 =?utf-8?B?TU84alRod3Y3NDFib3lCcUM5MXgxUlMwV3dLNDA4Z29LUWhxbWwrdHZ1QXlK?=
 =?utf-8?Q?1RlMX43jDoEks2oRlJW2rTxGaPyhhrbi?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NENkOGFxMGtJNVkvdVNpbGMvbjdVZ3AvM24wSFB6ZUtiTHNOZTJJY3RNTFZQ?=
 =?utf-8?B?ZTYzL3JHT1hKUVBxVm5URkx6ejlZZ3haZWZjM2tJNjNxeko5V1NRdVh0RFdk?=
 =?utf-8?B?bzR3YTl0U3ZFR0xTd1FsU1R4T1BJakdKTDZvZnRrQ0xZMXBWa0NTSEpLZlZT?=
 =?utf-8?B?Yk1ndFNOSHVmcGJzZG1oYjc0N1JTQ1BvTmYxemlGUjVUNnhyMUIraVhPNk1l?=
 =?utf-8?B?cnlDeG9tM0txK1hFazBIU3lsVTZZRHdYYnhCQ3BOYjV1bktlQ1h4bHhmemVm?=
 =?utf-8?B?Y200ZlgvenM3WXFUbmpYVnUweGp6ZHVQMjB4R28xdHJpejN4UUZaMnVJSGJn?=
 =?utf-8?B?RlZ6cG1CektnWko5elNyTlQxZk1aaGtqTm8wbE1VaXJRdHZYdHdMM0hHY2ZT?=
 =?utf-8?B?NmpJRHU2R2dDbElVQnRsc05KVzMreWNZNlltRmt1SVZ2cXJLbDdJUjlHZGZk?=
 =?utf-8?B?SVRQa0kyYjdleVZEQ3ZnU0dodjVEOXJjR0pjcmJBNHhvaDFLc1FIWFRkZUxh?=
 =?utf-8?B?RTRQc3NVM0xTS3RaNGRBaUwrQkRZRzRWNmgyZTZOODNKWWxDMEJYZjVGZjh0?=
 =?utf-8?B?NVJ0VmJSaCtXWEF4UEwzOUNMQ3I0TWVDdE9uMUwydmYySEdhaDgyVXVmeFV5?=
 =?utf-8?B?dU1MRTBpZHQyMGZnWnJOQWpCZVhvakdRNnQveVdNL1owWVJWMjVoNjlTR2Fp?=
 =?utf-8?B?ZFp0bk5hbFFDWHlEa0J4dGtWMWVNMnFPMmRETWRUWWNzOVlNZnZveXdhK2RE?=
 =?utf-8?B?eXdWcHVBVWZaUk5yWUJvS3FEUGlnaUQxT3RBdHMySVIvd0FUMExaS3A0YTc5?=
 =?utf-8?B?d0p5cHA3OW9PbUYvVitrTnRXbEJOdFQvNWpxeVYwOWdQNC9aSlJkbitBWFRm?=
 =?utf-8?B?TFpCUTVQYmZZbjNkVVdXUW1ub0toa3pzeFEyMEZmSjNTT04wb1ZtRkZkdXFi?=
 =?utf-8?B?bjNwZzM1SkYxS1JvaEJyZjBsa2tkeXkzSEV3cVBVL2lmVFlnb2hQaUp6T1JE?=
 =?utf-8?B?WEdyZFp6S3RWYW0wTmNtUzY1NDc4R3NwOXpuenRRSlpncHpSbjN3MVRINjlG?=
 =?utf-8?B?NWlqUnRpU3UxUnJrQzBEMmFFWHpFYVB1RndHZXIwR0NGaGV4aFJ2ZXJER2FV?=
 =?utf-8?B?VHM5SDMvakhDWGliMElmNHFSbklFa2tXWXJqZ1UyY0pweDNoTTltUFkxa1Bj?=
 =?utf-8?B?L0dZaWRSdThIb3h1czBoQjBMeUNBRWJXaGVlbitxeTFBSS82Uld4QnBhRFFR?=
 =?utf-8?B?blkzU2N3cnBydjh6cE5YUStRZWpUdDdLaHZac1JZL3lOckRWQVRTWGxRem5N?=
 =?utf-8?B?NzJ1MGtHMzFiUWJuUWpxUklaN200VFYvUnZlYlpodUNIaXAwcis5czNUbWJo?=
 =?utf-8?B?alA4eVduc2wzaytVS1Q1clBIeC9mZkdKb2hZd3FuUnQxbUVmWXZxcjYwTXND?=
 =?utf-8?B?UFl6YklCbVJzVUh6ZlE2Z2lnM0VLY1RNZnEweVY3a0RjYTRpZVJ0TS9mdndh?=
 =?utf-8?B?dnc4d1dPNUthejNuRWZiRytXZzdRcGFrS0U4em8yekdpN2dIZk45OE11SjJR?=
 =?utf-8?B?MGN0OEtGWXQvdFVvSXYzWno0UGJIWUJwT3BtbU4zQjRGa25VYW9pVnVoMkNK?=
 =?utf-8?B?NUZYNFJLbm9oVzNsQ2JqbmJXMWtodUlESm84c2thSlJlNEJFUktYVnp3MHda?=
 =?utf-8?B?aXlBc2tJSU42a3NTTE5OUWh3R1NEdU9Rb2ZYRGtVeC9mbjRkdGp6K2QvVDQv?=
 =?utf-8?B?Rzk3YnJIc1IrNzc5eTJXSmx6NGJyQk1QN1VBUmRLL3RpNjYxeitEVXNmRlM5?=
 =?utf-8?B?Y0N1R1o1RG9yVHBXYmwyT2dDMjRId2xEdGJjMkpYQVREYWVVK0E0eDFQTnVt?=
 =?utf-8?B?NnRMaWNPRnJvSXJ5TWx1S0JPT1VlVWw2OEFOcG55WGJsR2RzUnFKYUpsS3hG?=
 =?utf-8?B?QVUySDJLYzFjQXU5Ulh4U1VBSzJkSHJpb09yVjNUczUxR3R3ZTZqWWZtSzB0?=
 =?utf-8?B?ZkpuK3FjbER3VHJYVkI0TkIvOTNLTEJUelRIWE9hcm5HR2FBbktZWVBweXJv?=
 =?utf-8?B?VnlFRWlNdXFmclowMi9nRnJqRXROb2R0ZWZMd0M2b21oeUJFN3FDNVZ1bkQz?=
 =?utf-8?B?QjRZUHdtR3VUMG1jNEt5eTJGYnMxd3NSZTdJdnZEL1pjODZDK3FmR2ZvSndE?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0mtvmf6WMVAuCOWMSPHI7FGyEh5Hb936lE5Hk6PklR8+RgFuQ3Me4EyJjBbfUV/urC7lqBpNRtptftXJUvg+vd0i06ImVsk8j9n9sC0UoOUXn4caTrSAKmOcZq/ClBBnGoh+OtYTQfjgkwV3ZOCMFx6DzRpQ36g3wALl78j8Uijsw9FDt8wvO5EJwtAMcYVNHJxMQvX4NgqVBJpukZBuQ99JcWmQMVMEO6MRaYt64d3lMjWLZ6CJCEtdUsvqzOqqN6nZb+BbmfuYlFML9Q6oS9adJ9fzR1/tYufLpvyPgQEwtH5akK2uObi9HuzjWHsz6S6V3FacKl4IWCzL3rLGC0PDbE4VGnM6tcVf2Iy4G9pFWZueCY5/dCH7207+eDZD0morXoiki/9g/7Na8dlRuvX7uq2Wq6m+4eHOYRvxk+fikdtjZqGIieexkOlckI5sCSzR3C8O0pRJIxm1ZiSMYcCrHiJIzej1b8ApxJAF4fA/6+g97TdsrZ9kCLlxBgzShZbgAVOegcKrZmJZ+/7lhNe2bpmD6a5aTGXwff7so/Cb3eZudUJhYbfnEWxLHSD0hJIJnxKIwiRIJDM8EBGpehSuf6BuxCVaUHvR4m2RoD4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7b808c-531f-4a90-43cd-08de2784fa56
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:02:02.3878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjW4B09womGBjKp7eZvVT8hTy+rMugRBfd29/mBDOXLv5LBYNaxxndf8ATB0rUL6Zrmc+qDUIXN1b2lHSY454w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6340
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=927
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511190126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX4HxagaKSmBA1
 YqMzbgM3FqXBwycJ9OzovccwY7FgVjhV83E2H0SZlwbhGlTR89Y2apkx3kTc0fNfl16JOBrwMQL
 XrO0bbZgXcbuXJ0Ap1mkavNjA42gJJsZtdKkBAUVfEmJMFFfSB4x9icbY9Vpv0sPJZuhX2M5OSw
 SxpTjPXcYB9CMUZWk/6CWiIW9DLY7OMzCgfqh/GVranSTJvnQmeLuvUf64QKX5uFUZPAEjgHyOo
 WeaBJRC+zpmR2wZHMdupR9/bnc7a9h6RyNW7Y4k0Kjv3Gccuz9uiznACaO+Ry/bUwaTburVX3dM
 xRSq63HPTAPPmteYJ7M7dr1sazdHpU1pktIrPf2VmONR0joBlkBtbhPVsXw/IKUVYPDTT/v9KZY
 ZWyN7+gRYvK0ZOmrYnUdR6dmn4Qjhg==
X-Proofpoint-GUID: rWNgew0W1kQG9LMpdLgfKlJFPlwjEGvN
X-Proofpoint-ORIG-GUID: rWNgew0W1kQG9LMpdLgfKlJFPlwjEGvN
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=691de9ff b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=5iybq39BXQrBYNhCW8cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On 11/18/25 10:28 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> nfsdv4 ops which do not have ALLOWED_WITHOUT_FH can assume that a PUTFH
> has been called and may assume that current_fh->fh_dentry is non-NULL.
> nfsd4_setattr(), for example, assumes fh_dentry != NULL.
> 
> However the possibility of foreign filehandles (needed for v4.2 COPY)
> means that there maybe a filehandle present while fh_dentry is NULL.
> 
> Sending a COMPOUND containing:
>    SEQUENCE
>    PUTFH - foreign filehandle
>    SETATTR - new mode
>    SAVEFH
>    COPY - with non-empty server list
> 
> to an NFS server with inter-server copy enabled will cause a NULL
> pointer dereference when nfsd4_setattr() calls fh_want_write().
> 
> Most NFSv4 ops actually want a "local" filehandle, not just any
> filehandle.  So this patch renames ALLOWED_WITHOUT_FH to
> ALLOWED_WITHOUT_LOCAL_FH and sets it on those which don't require a local
> filehandle.  That is all that don't require any filehandle together with
> SAVEFH, which is the only OP which needs to handle a foreign current_fh.
> (COPY must handle a foreign save_fh, but all ops which access save_fh
> already do any required validity tests themselves).
> 
> nfsd4_savefh() is changed to validate the filehandle itself as the
> caller no longer validates it.
> 
> nfsd4_proc_compound no longer allows ops without
> ALLOWED_WITHOUT_LOCAL_FH to be called with a foreign fh - current_fh
> must be local and ->fh_dentry must be non-NULL.  This protects
> nfsd4_setattr() and any others that might use ->fh_dentry without
> checking.
> 
> The
>        current_fh->fh_export &&
> test is removed from an "else if" because that condition is now only
> tested when current_fh->fh_dentry is not NULL, and in that case
> current_fh->fh_export is also guaranteed to not be NULL.
> 
> Fixes: b9e8638e3d9e ("NFSD: allow inter server COPY to have a STALE source server fh")

Shall we mark this one with Cc: stable?


> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs4proc.c | 58 ++++++++++++++++++++++++++--------------------
>  fs/nfsd/xdr4.h     |  2 +-
>  2 files changed, 34 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index dcad50846a97..e5871e861dce 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -729,6 +729,15 @@ static __be32
>  nfsd4_savefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	     union nfsd4_op_u *u)
>  {
> +	/*
> +	 * SAVEFH is "ALLOWED_WITHOUT_LOCAL_FH" in that current_fh.fh_dentry
> +	 * is not required, but fh_handle *is*.  Thus a foreign fh
> +	 * can be saved as needed for inter-server COPY.
> +	 */
> +	if (!current_fh->fh_dentry &&
> +	    !HAS_FH_FLAG(current_fh, NFSD4_FH_FOREIGN))
> +		return nfserr_nofilehandle;
> +
>  	fh_dup2(&cstate->save_fh, &cstate->current_fh);
>  	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG)) {
>  		memcpy(&cstate->save_stateid, &cstate->current_stateid, sizeof(stateid_t));

  CC [M]  fs/nfsd/nfs4proc.o
/home/cel/src/linux/for-korg/fs/nfsd/nfs4proc.c: In function ‘nfsd4_savefh’:
/home/cel/src/linux/for-korg/fs/nfsd/nfs4proc.c:737:14: error:
‘current_fh’ undeclared (first use in this function); did you mean
‘current_uid’?
  737 |         if (!current_fh->fh_dentry &&
      |              ^~~~~~~~~~
      |              current_uid

Perhaps we want:

-	if (!current_fh->fh_dentry &&
-	    !HAS_FH_FLAG(current_fh, NFSD4_FH_FOREIGN))
+	if (!cstate->current_fh.fh_dentry &&
+	    !HAS_FH_FLAG(&cstate->current_fh, NFSD4_FH_FOREIGN))
 		return nfserr_nofilehandle;


> @@ -2919,14 +2928,12 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  				op->status = nfsd4_open_omfg(rqstp, cstate, op);
>  			goto encode_op;
>  		}
> -		if (!current_fh->fh_dentry &&
> -				!HAS_FH_FLAG(current_fh, NFSD4_FH_FOREIGN)) {
> -			if (!(op->opdesc->op_flags & ALLOWED_WITHOUT_FH)) {
> +		if (!current_fh->fh_dentry) {
> +			if (!(op->opdesc->op_flags & ALLOWED_WITHOUT_LOCAL_FH)) {
>  				op->status = nfserr_nofilehandle;
>  				goto encode_op;
>  			}
> -		} else if (current_fh->fh_export &&
> -			   current_fh->fh_export->ex_fslocs.migrated &&
> +		} else if (current_fh->fh_export->ex_fslocs.migrated &&
>  			  !(op->opdesc->op_flags & ALLOWED_ON_ABSENT_FS)) {
>  			op->status = nfserr_moved;
>  			goto encode_op;
> @@ -3507,21 +3514,21 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_PUTFH] = {
>  		.op_func = nfsd4_putfh,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
>  				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
>  		.op_name = "OP_PUTFH",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
>  	[OP_PUTPUBFH] = {
>  		.op_func = nfsd4_putrootfh,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
>  				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
>  		.op_name = "OP_PUTPUBFH",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
>  	[OP_PUTROOTFH] = {
>  		.op_func = nfsd4_putrootfh,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
>  				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
>  		.op_name = "OP_PUTROOTFH",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
> @@ -3557,7 +3564,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_RENEW] = {
>  		.op_func = nfsd4_renew,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
>  				| OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_RENEW",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
> @@ -3565,14 +3572,15 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_RESTOREFH] = {
>  		.op_func = nfsd4_restorefh,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
>  				| OP_IS_PUTFH_LIKE | OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_RESTOREFH",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
>  	[OP_SAVEFH] = {
>  		.op_func = nfsd4_savefh,
> -		.op_flags = OP_HANDLES_WRONGSEC | OP_MODIFIES_SOMETHING,
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH
> +				| OP_HANDLES_WRONGSEC | OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_SAVEFH",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
> @@ -3593,7 +3601,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_SETCLIENTID] = {
>  		.op_func = nfsd4_setclientid,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
>  				| OP_MODIFIES_SOMETHING | OP_CACHEME
>  				| OP_NONTRIVIAL_ERROR_ENCODE,
>  		.op_name = "OP_SETCLIENTID",
> @@ -3601,7 +3609,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_SETCLIENTID_CONFIRM] = {
>  		.op_func = nfsd4_setclientid_confirm,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
>  				| OP_MODIFIES_SOMETHING | OP_CACHEME,
>  		.op_name = "OP_SETCLIENTID_CONFIRM",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
> @@ -3620,7 +3628,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_RELEASE_LOCKOWNER] = {
>  		.op_func = nfsd4_release_lockowner,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
>  				| OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_RELEASE_LOCKOWNER",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
> @@ -3630,54 +3638,54 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	[OP_EXCHANGE_ID] = {
>  		.op_func = nfsd4_exchange_id,
>  		.op_release = nfsd4_exchange_id_release,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_AS_FIRST_OP
>  				| OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_EXCHANGE_ID",
>  		.op_rsize_bop = nfsd4_exchange_id_rsize,
>  	},
>  	[OP_BACKCHANNEL_CTL] = {
>  		.op_func = nfsd4_backchannel_ctl,
> -		.op_flags = ALLOWED_WITHOUT_FH | OP_MODIFIES_SOMETHING,
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_BACKCHANNEL_CTL",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
>  	[OP_BIND_CONN_TO_SESSION] = {
>  		.op_func = nfsd4_bind_conn_to_session,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_AS_FIRST_OP
>  				| OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_BIND_CONN_TO_SESSION",
>  		.op_rsize_bop = nfsd4_bind_conn_to_session_rsize,
>  	},
>  	[OP_CREATE_SESSION] = {
>  		.op_func = nfsd4_create_session,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_AS_FIRST_OP
>  				| OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_CREATE_SESSION",
>  		.op_rsize_bop = nfsd4_create_session_rsize,
>  	},
>  	[OP_DESTROY_SESSION] = {
>  		.op_func = nfsd4_destroy_session,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_AS_FIRST_OP
>  				| OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_DESTROY_SESSION",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
>  	[OP_SEQUENCE] = {
>  		.op_func = nfsd4_sequence,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP,
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_AS_FIRST_OP,
>  		.op_name = "OP_SEQUENCE",
>  		.op_rsize_bop = nfsd4_sequence_rsize,
>  	},
>  	[OP_DESTROY_CLIENTID] = {
>  		.op_func = nfsd4_destroy_clientid,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_AS_FIRST_OP
>  				| OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_DESTROY_CLIENTID",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
>  	[OP_RECLAIM_COMPLETE] = {
>  		.op_func = nfsd4_reclaim_complete,
> -		.op_flags = ALLOWED_WITHOUT_FH | OP_MODIFIES_SOMETHING,
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_RECLAIM_COMPLETE",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
> @@ -3690,13 +3698,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_TEST_STATEID] = {
>  		.op_func = nfsd4_test_stateid,
> -		.op_flags = ALLOWED_WITHOUT_FH,
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH,
>  		.op_name = "OP_TEST_STATEID",
>  		.op_rsize_bop = nfsd4_test_stateid_rsize,
>  	},
>  	[OP_FREE_STATEID] = {
>  		.op_func = nfsd4_free_stateid,
> -		.op_flags = ALLOWED_WITHOUT_FH | OP_MODIFIES_SOMETHING,
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_FREE_STATEID",
>  		.op_get_currentstateid = nfsd4_get_freestateid,
>  		.op_rsize_bop = nfsd4_only_status_rsize,
> @@ -3711,7 +3719,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	[OP_GETDEVICEINFO] = {
>  		.op_func = nfsd4_getdeviceinfo,
>  		.op_release = nfsd4_getdeviceinfo_release,
> -		.op_flags = ALLOWED_WITHOUT_FH,
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH,
>  		.op_name = "OP_GETDEVICEINFO",
>  		.op_rsize_bop = nfsd4_getdeviceinfo_rsize,
>  	},
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index ae75846b3cd7..1f0967236cc2 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -1006,7 +1006,7 @@ extern __be32 nfsd4_free_stateid(struct svc_rqst *rqstp,
>  extern void nfsd4_bump_seqid(struct nfsd4_compound_state *, __be32 nfserr);
>  
>  enum nfsd4_op_flags {
> -	ALLOWED_WITHOUT_FH = 1 << 0,    /* No current filehandle required */
> +	ALLOWED_WITHOUT_LOCAL_FH = 1 << 0,    /* No current filehandle fh_dentry required */

The new comment is unclear to me. Is there missing punctuation?


>  	ALLOWED_ON_ABSENT_FS = 1 << 1,  /* ops processed on absent fs */
>  	ALLOWED_AS_FIRST_OP = 1 << 2,   /* ops reqired first in compound */
>  	/* For rfc 5661 section 2.6.3.1.1: */


-- 
Chuck Lever

