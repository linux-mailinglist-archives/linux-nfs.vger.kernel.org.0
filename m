Return-Path: <linux-nfs+bounces-14809-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AC0BAD229
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 16:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090DF3A2F10
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 14:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFA41DE8BB;
	Tue, 30 Sep 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jRsB8ZMX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t5xBvWoH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA9518A93F
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240938; cv=fail; b=Z0wx7u+DaP4kIrwJ+RSmw+FS7SHp584HRV+BQDRZCLKY9M6MjrwB5zMlvYHv4q7i6goHoOdBOU9mvJTCDTn05YL+YP6mumbiGZ/E9TAVEbCRCC2mKm6EbbkiAZB8cTZpfKuBwU/jNPCQ1XsQgS8ImJU1djuBqyfSLakXX3b84Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240938; c=relaxed/simple;
	bh=vp0QsGRguW0L67Ydl4t5sG3eIVLIW74hfWKxp97xUZs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n85Lgfl5F579gdXB2hYY/tViZqqcpuash6Bug3afKmgI5uhLEw9gZK0WZp3tj7kY+wdEfu7M4dkZnirDveifhO99Ur4e9s2YUSEqoHa7SZYLkDqY30iM2yM7BhguZrLgzTgwWUdbeeTM6U8dfPluI0XxYzp5Bkj30D2GTss2rqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jRsB8ZMX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t5xBvWoH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UDTXP3026453;
	Tue, 30 Sep 2025 14:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WDoBL8/EOWnq66RgZ3Q5wWNCgZSd0QQkNS7OJdNK9Sk=; b=
	jRsB8ZMXdJtkmJl9rC2JPaEIXGJNGktrS5K235F3Jx2CCzoTiL9y1Y+629aAk7zm
	nynQ+HVFxSVOmyil3/SWO5udf0xVeIYJZ979lBj6yQHp/aphlwo4e36SC/wXceNk
	4o4C6jbB4742gftq6fXaGDcqJr4togMi2cB6pFfBDIsYY/qZY0htgJQjx9zi/HFZ
	SGD1NNhUY5JlnSqblKttcwt0FN111UEXij1G8RbiWCiXLumt7TqwsK0zs7W4bYDU
	Y3e+4e7IP4WghiQsRlS0vLnISN7kp3NdGfQtgHuqwgQKlpwL1pbd+LL0j5YLKhxB
	96tjh2uhnuV5QFWfUs0q9A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gg4r02pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 14:01:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58UCqebo008130;
	Tue, 30 Sep 2025 14:01:52 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010054.outbound.protection.outlook.com [40.93.198.54])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c8ujpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 14:01:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1xH6SHu/smaqHNfFzEMg0LsW+fa4fcLbrVf+pHvvVaBhb6Q9ccBwguYlR1skkNEO8/Sccla7qqvHbKVPQJ8vJk9DbsnzaImnNcXCsIBKXQ6S1gWkVHGMtO5x1s4SmFmfJy3bGX1ldrSWmE8I8VxBJnZmbJYxDuFCL0kmiQtepkdHpGYOB42wiaVe6/uoezSVoBSQYHMEg5xQdH5MO9W3n6xzZ6/PxXrPee7Ar+tsXMeMTAEjA7qUamtBN1t2NUrgIzXUtXJ45MDmBkjzBOQ7q3bMo9zVsn+Dvqp7bfdTvoxLmEw/HjUtCyAYztgLOhGrYu4FAMvXrjqwu6UcGi2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDoBL8/EOWnq66RgZ3Q5wWNCgZSd0QQkNS7OJdNK9Sk=;
 b=drdav1j2K13Osgl8vGYSWIw7Hx5BXTgxifQLX/bKFQJ60L9CohvI63cqTqP2/4Za5BfsfDCnwyAUpoXe7NTZX2rA1bmLhE7IR0iswlW8qXWkt7uBUCr/xWSmo5waYWFo5yPAusG9j9DC416Xytn9qFutNg1dH/UTFyDodAeE16p60euHdsGwKAPAfWb7nZ72mUgUmpaMQiegne8vT2vEEzjU04OuftHyJpqP3UPT2PANRL8uW3THOVhz6rkqrE6aQYgPm3O2/XxOJo8Y2JzJlgxiy4+WTtNBfkq3LP9rnlJPmMOq/gPuIF+hXjV9VNML6mmcVtESnWlJYV52CANRCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDoBL8/EOWnq66RgZ3Q5wWNCgZSd0QQkNS7OJdNK9Sk=;
 b=t5xBvWoHqP3b/yR1s0/rT6sdsvcMJTMvbSYQwNKRMFVi83+1z+510hIcZ7HdQv06R3W9Hi3ayZN/sUhxtKlHkI8KFsSqyXRKTzwgXxiF0eJCrtOxLlEW0vV2DGMDVm+P5SlXwNlb5LUobRCuSjCJF/Satfp1rJ1hTR2hGr81M+g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7630.namprd10.prod.outlook.com (2603:10b6:610:178::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 14:01:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 14:01:48 +0000
Message-ID: <f6ba4e9d-98df-46f2-b2fa-8ac832b8ce11@oracle.com>
Date: Tue, 30 Sep 2025 10:01:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSv4: handle ERR_GRACE on delegation recalls
To: Olga Kornievskaia <aglo@umich.edu>,
        Olga Kornievskaia <okorniev@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, anna.schumaker@oracle.com,
        linux-nfs@vger.kernel.org
References: <20250811181848.99275-1-okorniev@redhat.com>
 <CAN-5tyEmf9HHMuXHDU86Y5FWYZz+ZYFKctmoLaCAB+DZ1zcXSQ@mail.gmail.com>
 <2b87402379d4c88545dabce30d2877722940f483.camel@kernel.org>
 <CACSpFtC3FbdGS6W6yKKwn+JcFmkSKE8yZRkQzuEWwRjAsZYkWQ@mail.gmail.com>
 <831f2ac457624092dcfadcf8b290fc65dc10e563.camel@kernel.org>
 <CACSpFtAqWdPPCbHLnXKGOmn7bR0fBjS9fj_J=i4aNnL+=8t1zA@mail.gmail.com>
 <CAN-5tyEY17k5SZ6hj2QsgW_006c-0ywS5H5vPvadj80bC0X=7w@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyEY17k5SZ6hj2QsgW_006c-0ywS5H5vPvadj80bC0X=7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0046.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 2940e469-d4a8-464d-bcf4-08de0029e61b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjZOV2tFT2hoakY4eGZSTU95a2xCMks2cURTbU1rNUtoOThMNm5GbHpBbzY2?=
 =?utf-8?B?bGdoNzUrSVB1ZUE1bnB1by8yZmEvREkwbWtZZjlEOExTWkJ2Tnc2a2E3bDBC?=
 =?utf-8?B?d3Q5UjdGYUNXWUJKLzJHemRlb0lRZXE2azhUODFwZXRTMFZwNHRFUkF5UGtQ?=
 =?utf-8?B?QXZTVU1ZUlVvRzRIWEpuV3B4aDUxdm9mNjRzOWtCVmdvdHU0UjJFMkMvZEVW?=
 =?utf-8?B?ampsQWljK3BReXhtVjhCUWdOTXZSM25xUFhXUlBqQTJRa21pWklSTW02OUpQ?=
 =?utf-8?B?dU9CTzFPcmtNYWtuQ0lOdGdPK3ptbnFLVUdnT0JTSlhubzlHWWdOVEhRTTUy?=
 =?utf-8?B?ckV6MUZLdXhwcWJYUjViNTJsM0hEckpQVWNDeFN5UFNxSjRlL0Rya1M4Y2t2?=
 =?utf-8?B?TzVNYTVlWk9yUlg1Umt3WWZ4L2VBdnVpZTZvN1hNNjZhY0huelJnNFpTdGRB?=
 =?utf-8?B?RENFVG9aOWZJNWtOYTJOQnRxcVBPYW91S1hub213aFM3U2pDdDY3UXdNcVdF?=
 =?utf-8?B?NUg0RXpDWE1nNDhzZGk1M3ZOcEZmZUlvTUlUbGl5Wm40WTZVaW9RVEdTa0g5?=
 =?utf-8?B?ZjJVWk5zMk5mUUxxK2E5Q2R2MU43cFppVi9NMGRSWjlxOXZsTEVTcXg3TDg3?=
 =?utf-8?B?VVF0amg1SHozMVg4QXl2MFZGbDRKclZ1MVh6WUEwTjFIc2s3Y3c0WU93NGZV?=
 =?utf-8?B?ZElHUUtWTHJVWGJFZzZydERkb0lkVmRnUU51d0x3UWswbENJdHF6VzYrNVU1?=
 =?utf-8?B?ZWRwTXBSZFdNTUpFQ094Z3d5V3p5ejZmbzZpbFRvZndGSFBsSWNMSjBRTDBt?=
 =?utf-8?B?UnYyRXhWUkhSTUlTbHdRRjRUcVJ3Umk2WXo3ZkluMUVmbkZxSW1rWkJhYzBm?=
 =?utf-8?B?V3I4NU5pZU1zRGRJTkJ4YUtMenVXSXZncHVxZXRwa0Nqb1JwQ29ZSDhnOGlq?=
 =?utf-8?B?alNpMVRNaTBUcmlZZ3BDbStNMXUrNGR4UjN5QlFjWDFXdkJFdlU1dkJwVWk2?=
 =?utf-8?B?M2lnejdqckI1NXRCY1BhSWp0OGc1SUJ0T2J6Q3lLYlRZTmRncmpEdDhEeEwz?=
 =?utf-8?B?bWxaM0ZVU21jc2FPSFh6OHlFOHdvMmM4cUZQdTRhR0NaVE5iVmd0NXBjTjd0?=
 =?utf-8?B?NW5hMTFpamNmQ2pEZlhXcjlPQWNrUWQwR09ZL3M3MnpiS1dPZHJpMytrWUhL?=
 =?utf-8?B?dENZSlRBY2FaZko1aktsTGlDZ05TQllCRWUyaTE0YU1PNG82dkJTYitzMTg3?=
 =?utf-8?B?MGZzK3FYRlhqTDNteElQZXMxR0oveWp1MnBKNU5wR3F3RVF5bXllcjc3WUx2?=
 =?utf-8?B?ZE12eFdkcmNpc0djZC90MGhtZTJPeERPVkFrdnRCRU1DaERhVHh4UCs4dnA2?=
 =?utf-8?B?eDRBcVR1Tmg3RjZyTUJwbXk1alI2NzlvSTd1Zk44em5GOXhldVNTb253b2VK?=
 =?utf-8?B?c1l0QjFKQjY1Z1Zzd2J6TVdPcmNrWGpNRzBLcnlSbitXUHNXZVp3a2hCSDY1?=
 =?utf-8?B?Uk8vNHREck9DN2V6MzNmWUs0ZWdkWTNmRWJFUkdlSmo5TTBkcEpQeFVzZ2Iz?=
 =?utf-8?B?enpua285LzhGczI5SjAzeVN6ODdUTEwwMVFvQVhTcVQ2NG0wdlZXQTlRRmJl?=
 =?utf-8?B?Ri83bEZicXNqTDhRZyt5Sy9melBsYmVScmRHWUN5eldpRzFvbkVyWjdWa1Bq?=
 =?utf-8?B?MSsxSUcxQ0t0OWRKM0J1NUJmRm5FbWZaLzhleCtkaU1ZT3dDTGZGb0RyNzRN?=
 =?utf-8?B?MWFLOE9GYThIT2oyZU1Nd0FlM1BGSDU4emdxQlBWaEFQUFBIN1FyYVNWZWRE?=
 =?utf-8?B?R2RjTk1pM2o5YTZKTmdvVy9OZFdPdG52ZVhQWWROWlFvVTZiZEpPR1d1R24w?=
 =?utf-8?B?TTZkL3J6dGhWU2dETkMvRG9mb3ZKSE1icUkrMkdFMHcyU3BsWmVURXNNT0JK?=
 =?utf-8?Q?hJHoDgdBMR8RtzgCQqi9qtPFeLWVR5bJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2c0azl5eFh3RXNxVFQvbUs0ekJzS0hWN2dUcm1MSHlMOGVqZkVzSXF3emRr?=
 =?utf-8?B?ZUM1M1RsYlVuMG5rSEJ4aXR2ZXVPeXE3RVMzSTl0WDhYc2cxaG90aTdicDhu?=
 =?utf-8?B?cjJpRFAySnZzdFhpb3VwZ0RuRUNpWFhNMEx4YUE1UE5RenYzT3JTeDNDQS9J?=
 =?utf-8?B?MGFWN0FQWnpUOEVFTGxCRHk0MENyUDVmb0tCc3JaMGF0akFucnhrdnhlNVdV?=
 =?utf-8?B?ZDFlVHFzTmFyRFQ4ZkY0U0J1K2tYaWpwNjlIRzRocUQ2a0lYTTZiTGpBQ2VU?=
 =?utf-8?B?SlV6cDNhajIrTWtYZ2ViQ3o3dUQveVlpSWJTTkFxRmNBNXlXRkVIMHRWOWJv?=
 =?utf-8?B?dnY3cUlhUzVvdVJ3di9CcUlNK3lSa3g3L3M3SDZaS3hzMkxxajh6ZGNaQ2Nu?=
 =?utf-8?B?ZWdqQTZVTmhFUmFDOXdxL0tKQ3c4ZkNqUGI2U1FHZDZQUVQ1K2QyTVpUcGFj?=
 =?utf-8?B?cFZ1U3N3VnZMWWloaFJPb0ZtOUdRZDNCMlV1ZHpjdGJwdHNrc3IzNWpiNldE?=
 =?utf-8?B?MU1rWlhMTzVpK2dTenZ5RmJId3ZiTVI4bVNoTnhQUjdpRmVwRjVjUVN1eEEz?=
 =?utf-8?B?Z2tNd0R5QXZ5NmhTaUwzNFlNcW1TSW93c0FYL1U4bmE1M2V2QzZRY3p5Nzdt?=
 =?utf-8?B?SnFiYlgzOTVUV3VKWmRQU0tXSGdLdlNwV2RpZFBkOUpZNlpENWR5SkpPVUEv?=
 =?utf-8?B?Uk50cWlCQjBDY2ZDMFltRGhZUDhRSmNzVHV1NFdIeFlXSjFlY21TUjdUNU9y?=
 =?utf-8?B?dDZ1cHk4RjNSdGZVajlydGxMYzBBYVNxcWl3amtVbjliU0tRRzhxNWViRGx1?=
 =?utf-8?B?OEdueFNWOXZpY0daNklERStjQ2pjK1dUU1hXL2FUUjFLKzNxTW1DZlI0YmxP?=
 =?utf-8?B?TlhtWUN1Wm1WQVBOVGRrcHVmK2pIL0tNV2JuVFNpRUV4d2tOKzRRWDZ0cHdG?=
 =?utf-8?B?bGh2elU2MFdneStHZDUvRjlvQ3Y4TEN4Y2NQUnVFR0xYajlQNlhZeHN3TzhW?=
 =?utf-8?B?UXZKTVhvcTc2NWx4c0l4MEQ0ZUl0Wm1jWmlrNDh4RUI1VlZ4Nzk1NTJNQjU1?=
 =?utf-8?B?ZDFtZHlxbnBLTThIOGpKQ2cxMTdZc2hyUFdSOUg3dGVDaUtvdjFha2o4ZExt?=
 =?utf-8?B?V2hPSkFXMUZyeE9XZkdpK3BxdFVCRFd1L05DOWRBWFhxUWo0NDVVdlhjcEkv?=
 =?utf-8?B?VTQvWkdCaWI1ZGNXWW8wV1NnblcvQ3hHandIMzdMcTF6RUFRUFdxUEx0TkpB?=
 =?utf-8?B?YXliZ0VXbXl6Wk9ZaW9mbVk4VjRGMDFKSTVNUVJxL1k0ZDNVQktFNEh0MUpM?=
 =?utf-8?B?K3M0MEh6cGZON0ZQRmw3Rm9MbFdNUnlCOUNja3NEODUwdkN6WklyWkp5Ym42?=
 =?utf-8?B?b0V3L3kvNXRneU9URllxZ3Z5bG5LaHZIdDcxSXhhR1RBc0JlQXBuNmh5S3Vl?=
 =?utf-8?B?RWxEL3Nmdlg0OE5TcDh2YU5sbmRLVnh3dWEyTHV6RmVCTG84Nnc3RjNnZU1Z?=
 =?utf-8?B?N0xtdytNbHpOMW5wZ2JnNitBdmVFNUpwT1poSUM5N3ZjSSt2Sk4zbUtjNDgz?=
 =?utf-8?B?TUlocDBWU1JQWnZBbitiS1lFQ2Y3SEZid0VlMHUrdDBBV0JVS0tBWGJlVkhO?=
 =?utf-8?B?eGlOVjZyUnJ5aFlTMmQ4bWtDVlNTbDdwMTRrZUovUE5kcmxHMFVqbTBWbjBv?=
 =?utf-8?B?Y3RSTHU2MVFLdVZXenZPaFVQZ1I5OHhLSlg3S3ZHYU9UMDFocG0zdWxNdEVZ?=
 =?utf-8?B?QWZxbEhQN0xZNVA5UVhwTE1wL0pvMkNGUjdWSndWM09jaDVSK3YweEhXZ1N3?=
 =?utf-8?B?dG1yN3ZnS0YwQlR1bkNBWFlNK0lYOXE5bFFJQ2FpdWpjMEpXZElkaHhKaGNu?=
 =?utf-8?B?R0d6UFAxZlF6Z1dQMjhmMHVCeGIxNWQvV3gzcGx0amhxd1Y3V0pTYXNPYlNa?=
 =?utf-8?B?S1RnVnNIVm1jV3Q2L01kdUlMQTlUZUhMeDlZNmI1aUNnUVgwQlcwb01Zd2xJ?=
 =?utf-8?B?bm9BQWI3U09Mb2owZXVwekF2c0NNTitIc3FSU1lKOGR4cnROZm1SaHV2UjJ4?=
 =?utf-8?B?Vmo2U2p1Mm01a3hVcmlubW13ZENKOEJLR3MxdE1wNlBhdUo5b2t3aTZZT2ow?=
 =?utf-8?B?VUo0c3k2RUkrS2VUeVpMK3BoSUtDcDYwZEY4NDE5eno1Z256YklMbVNlQmJ5?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oO6egaqc9rf53y+4YB0KGPIF/iFYsU/ibs0kJsCeH3P9kvGAZFe7IwlYwQNrSvDdyD9YsBQIjX5NarPd7mYlweJ9aPrjk833X4v1xjvOZK9UdN1z+H09XSqlNxU97EtKN6wD4e2L+ef3NmjbHB4/S6M2fDEfHk9uJ5OxtfGxXCZla6gjtb8fDUwiba1vRqwPCmlGjwapAcebTGaY0/HY9Vq4u/QkJFvHTtr+ffC5Mg/QwgWQoxtfwCNCBo0tkETO7nMNbdKUJx5UdTPRtyen51Nj1iLya6oEdBNu5VDTp58X7NK7L5zmz85X/ySpEpIgi8ThwVZKWfJnc8H5hRBk+nDq4Wp4AF/G39FksVECh8cLddDqe/eH2GlWEOyGTspcBhuqeVqxEpeW7065u5OcJjSrmsDlGSmcTmVQcq9WpxNsgDOo/A/1bKqeVQi1zRZUUjTSsT/K8tF39cwooTb2sOrLIhTjTksysYPEjw/qEujRWDC5kevoB3VExDK+T+7xTI9xx1BQWjNJMehXBA+FUkcUxQ/t/0S71x5P6SzE6N/Cq3RLGfdJLLtgkH5T5KgmfCxm8Hk7VrPIwDaOq25RuxmKP8VVu+5ceJ8pyjLcnBY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2940e469-d4a8-464d-bcf4-08de0029e61b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 14:01:48.8866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mI23pk4V+R5jpbrXsqbBXoN7hfRns0bmqdOXk1qtqQtNx+FASiHP3tq1T+d3Y7efVQrv+GR9nG51sTuVfDUzdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300125
X-Authority-Analysis: v=2.4 cv=Qbxrf8bv c=1 sm=1 tr=0 ts=68dbe2d1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
 a=3X8GYxko22vzxVWqAP0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HzjurUKSBCWMcZmANqiR4CZWBgrtZRfA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDEyMCBTYWx0ZWRfX9POj2iX0paj7
 abEQPxmQKxSn2Ik+IIOtkggc1loGSg9xGG1PMJJGnmpIKx2mhNFHy08X6NsiHPzApgT6+H330Lx
 5IBXM5WlZ56VsxEfP0yqG31SW4vcLuYi2rtnJoe6lvfJCmSBMRq9I0VfrkFoLn1SYHyZnDuadKg
 FZUnqeXoZ8qYB9dd2AAhMXBD4L7SDg7ZexnjSVGcLRhDu5spBGli9XLqc3luUhw6jr4wjNu3Woc
 BsDCJCFARZfQno5XJSB0qQbtqLx2QtBfyxUhip8WLAcl33CvsVoLFHhyOQ70F99MSm5jDGuP8aJ
 LKMSGcTQI8j0Aw1itfxn3bid6iOIb6hmt1SzEQwwv1CY4HZluL2vttgBaNyuk1uSYUw/M1gSNvC
 ZiUd8yUh7yb284k3YMgaUH0jtkjvig==
X-Proofpoint-ORIG-GUID: HzjurUKSBCWMcZmANqiR4CZWBgrtZRfA

On 9/29/25 1:49 PM, Olga Kornievskaia wrote:
> On Fri, Sep 12, 2025 at 12:04 PM Olga Kornievskaia <okorniev@redhat.com> wrote:
>>
>> On Fri, Sep 12, 2025 at 11:11 AM Trond Myklebust <trondmy@kernel.org> wrote:
>>>
>>> On Fri, 2025-09-12 at 10:41 -0400, Olga Kornievskaia wrote:
>>>> On Fri, Sep 12, 2025 at 10:29 AM Trond Myklebust <trondmy@kernel.org>
>>>> wrote:
>>>>>
>>>>> On Fri, 2025-09-12 at 10:21 -0400, Olga Kornievskaia wrote:
>>>>>> Any comments on or objections to this patch? It does lead to
>>>>>> possible
>>>>>> data corruption.
>>>>>>
>>>>>
>>>>> Sorry, I think was travelling when you originally sent this patch.
>>>>>
>>>>>> On Mon, Aug 11, 2025 at 2:25 PM Olga Kornievskaia
>>>>>> <okorniev@redhat.com> wrote:
>>>>>>>
>>>>>>> RFC7530 states that clients should be prepared for the return
>>>>>>> of
>>>>>>> NFS4ERR_GRACE errors for non-reclaim lock and I/O requests.
>>>>>>>
>>>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>>>>> ---
>>>>>>>  fs/nfs/nfs4proc.c | 4 ++--
>>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>>>>>> index 341740fa293d..fa9b81300604 100644
>>>>>>> --- a/fs/nfs/nfs4proc.c
>>>>>>> +++ b/fs/nfs/nfs4proc.c
>>>>>>> @@ -7867,10 +7867,10 @@ int nfs4_lock_delegation_recall(struct
>>>>>>> file_lock *fl, struct nfs4_state *state,
>>>>>>>                 return err;
>>>>>>>         do {
>>>>>>>                 err = _nfs4_do_setlk(state, F_SETLK, fl,
>>>>>>> NFS_LOCK_NEW);
>>>>>>> -               if (err != -NFS4ERR_DELAY)
>>>>>>> +               if (err != -NFS4ERR_DELAY && err != -
>>>>>>> NFS4ERR_GRACE)
>>>>>>>                         break;
>>>>>>>                 ssleep(1);
>>>>>>> -       } while (err == -NFS4ERR_DELAY);
>>>>>>> +       } while (err == -NFS4ERR_DELAY || err == -
>>>>>>> NFSERR_GRACE);
>>>>>>>         return nfs4_handle_delegation_recall_error(server,
>>>>>>> state,
>>>>>>> stateid, fl, err);
>>>>>>>  }
>>>>>>>
>>>>>>> --
>>>>>>> 2.47.1
>>>>>>>
>>>>>>>
>>>>>
>>>>> Should the server be sending NFS4ERR_GRACE in this case, though?
>>>>> The
>>>>> client already holds a delegation, so it is clear that other
>>>>> clients
>>>>> cannot reclaim any locks that would conflict.
>>>>>
>>>>> ..or is the issue that this could happen before the client has a
>>>>> chance
>>>>> to reclaim the delegation after a reboot?
>>>>
>>> To answer my own question here: in that case the server would return
>>> NFS4ERR_BAD_STATEID, and not NFS4ERR_GRACE.
>>>
>>>> The scenario was, v4 client had an open file and a lock and upon
>>>> server reboot (during grace) sends the reclaim open, to which the
>>>> server replies with a delegation. How a v3 client comes in and
>>>> requests the same lock. The linux server at this point sends a
>>>> delegation recall to v4 client, the client sends its local lock
>>>> request and gets ERR_GRACE.
>>>>
>>>> And the spec explicitly notes as I mention in the commit comment that
>>>> the client is supposed to handle ERR_GRACE for non-reclaim locks.
>>>> Thus
>>>> this patch.
>>>>
>>>
>>> Sure, however the same spec also says (Section 9.6.2.):
>>>
>>>    If the server can reliably determine that granting a non-reclaim
>>>    request will not conflict with reclamation of locks by other clients,
>>>    the NFS4ERR_GRACE error does not have to be returned and the
>>>    non-reclaim client request can be serviced.
>>>
>>> The server can definitely reliably determine that is the case here,
>>> since it already granted the delegation to the client.
>>
>> I'll take your word for it as I'm not that versed in the server code.
>> But it's an optimization and hard to argue that a server must do it
>> and thus the client really should handle the case that actually
>> happens in practice now?
>>
>>> I'm not saying that the client shouldn't also handle NFS4ERR_GRACE, but
>>> I am stating that the server shouldn't really be putting us in this
>>> situation in the first place.
>>> I'm also saying that if we're going to handle NFS4ERR_GRACE, then we
>>> also need to handle all the other possible errors under a reboot
>>> scenario.
>>
>> I don't see how the "if" and "then" are combined. I think if there are
>> other errors we don't handle in reclaim then we should but I don't see
>> it's conditional on handling ERR_GRACE error.
> 
> What's the path forward here?

I saw something earlier in the thread that caught my eye.

It looked like you said that, while NFSD is in grace, it allowed a
client to acquire an NLM lock and that triggered the delegation recall.
It seems to me that, because it was in grace, NFSD should not have
allowed the creation of a new lock; it should have returned nlm_grace.

Did I read that incorrectly?


-- 
Chuck Lever

