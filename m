Return-Path: <linux-nfs+bounces-2584-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4478941D4
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 18:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA61BB22290
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 16:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB608F5C;
	Mon,  1 Apr 2024 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hZHWaz0Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DZr2lkrF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBDB481B7
	for <linux-nfs@vger.kernel.org>; Mon,  1 Apr 2024 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989996; cv=fail; b=qlWt1+L0la9KYl8i9oUC3DnqkBGQONsBEQak6iVYkQjarf81fWTrxbtafwfCS6IjYMKDheNbzLtkTZGhI+4/uN2EtObtPtkt94I5RNlNrWjlGu5VSlx7SFywd58aNxzv2D/rOQ1RT6r89WcronBhBS7myA8RTahitWCd1cbR7lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989996; c=relaxed/simple;
	bh=rKqyOVt4nvbt2TgQmxUnB6bT0Ttgo+jk2+XMKbCrOSo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=piKDHwXbawLUudnVscJC9qvPJmoLd0JeES4BMSm62Nmfh9/TsbHdfbIjmm+vsE0R84pOAk8TCHH/IfHxM0VZqoN2pCrPrkdwfN6Bes6fle7ektQR3UD1OR+nse4mohVFtAhHzoSK6Yb6QQ2CQpACjuV4xZ31gON1Pm/HURLEawQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hZHWaz0Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DZr2lkrF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4318iBFM027618;
	Mon, 1 Apr 2024 16:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=XOXwM8F3Ek22dE5uGi17gnXgR6RU8SCiE/uDiOq/zr8=;
 b=hZHWaz0Ysiil0ZpTWdbXQUWBO2ZSQL/Vmr5B3bnKJyRSXo52qgKUSRqD/bo6k2pXp+4q
 9BQEpmEvcHZYzL/TKc0fKIAJGHs7q2G7GkYs5nV0L1lA7xraNq1MCW7YPUDlLKJsg096
 aaaxKZauHXKn7dvSVk6//cbvo/GYhK2gTZOekpOHzp5a6fWsqxrAxXlpi7OmVnmRVant
 awnKgD1m4qk5N497Dcq13Dn7W22YRq0ssPII8L9dOfGToKEzaNzFnHsLfd2HJ8HJ9bNf
 9iPIoXqea5059FbbKbwGW5wcMOkU0JWZ+aNdygA0cdvFVGoeAnA0MiQ/Kow7Dcsx974U jA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6abuaraw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 16:46:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 431FThY4021362;
	Mon, 1 Apr 2024 16:46:29 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x6965uytt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 16:46:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbRDS1WfNyHefJqr7lpdEuQQKHQnyfU+UpDGfn+3ETGeqyQCqTsGndx+YkYLXZ2mcNy0mcSfuVCObhByY0Ph786D+O8Gp5hIeIqx8wXCqecVqZ57VPeDLAhr6i2O8Vr0aqmmXI/btHOEy2yj+u012L//TnbhfFNmFB8/lr9IVK+ORixZNQM/XQuo8BRXwu9wJQvSy2SBSFvqGsIvut2x8EbOwHJlfdLwZ7SSHTMH+LDufYjjkt3J7R8S69jPvhuYp3eLXxSfEHBtttj95TGgQ89HoXl1iLPXWFN8Vv1LxMZUlJXTMQMgJEwqcUSjfIgXRX7MfpaQuaamz+9Uh8qJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOXwM8F3Ek22dE5uGi17gnXgR6RU8SCiE/uDiOq/zr8=;
 b=fRovyklF7Gr+YbfPnCDTLjJAf5kYiwYKqQ3LPCKCz3deOvAfQNmKwgpG6AlGyZ6h/W0SndxfS7XsJ2gcpMYLwVkBiZ5ExFz4BjBvVrxRijAgy9XlZs0HldZkycN052G9RGsWclhed1bLVM6KW3QYgSaIGkKtO3ZY8YLnonhKPuZ4JYuBrtnab9YhmJKBlmnkI0q0+DbbhqZgkNXwN6gDtT5cXadXMSC+usVc0vxrGSdUPoo9PA5OEbRqmZtKUGfFvhAhshESOXxNU+xs5kpKwQoLmEvxyC/6jmXwOFjQXPZJ/+TZG1y3gKti5EpFirCyHBWa/vRS8wIXNGRd4P/NFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOXwM8F3Ek22dE5uGi17gnXgR6RU8SCiE/uDiOq/zr8=;
 b=DZr2lkrF9xb1dzs3Ib2oKO6qR5C5kX1GABhG4eU5d9IoC8dfxzSgxMVtzscj6/7U3KmONqHaCtalmNzw/utTf/e1FFhEZC8skqib3EHUWMxs841o6xtTovAc5YFvJA8rrLrxnwglfPEkhoHkenVaM8PZqreTwrJX+br1nuRazaQ=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DM6PR10MB4331.namprd10.prod.outlook.com (2603:10b6:5:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 16:46:28 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3%3]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 16:46:28 +0000
Message-ID: <a30b343f-b6cf-4566-9565-28a5fd5ca851@oracle.com>
Date: Mon, 1 Apr 2024 09:46:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
From: Dai Ngo <dai.ngo@oracle.com>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <ZgV5zwR0q/vjBAtI@tissot.1015granger.net>
 <88fac8af-c194-452b-94eb-7658b9056246@oracle.com>
 <c97be8b9-c0ba-4f2d-9340-78368008ba4b@oracle.com>
 <ZgbWevtNp8Vust4A@tissot.1015granger.net>
 <97387ec5-bcb4-4c5e-81af-a0038f7fc311@oracle.com>
 <ZgdR48dhdSoUj+VM@tissot.1015granger.net>
 <09da882f-4bad-4398-a2d0-ef8daefce374@oracle.com>
 <ZghZzfIi5RkWDh9K@tissot.1015granger.net>
 <84d6311e-a0a3-4fc6-a87e-e09857c765b3@oracle.com>
 <039c7e38b70287541849ab03d92818740fdf5d43.camel@kernel.org>
 <Zgq365RJ9M5qsgWY@tissot.1015granger.net>
 <5108ca5a-b626-4ae9-a809-ae3fffb50cab@oracle.com>
Content-Language: en-US
In-Reply-To: <5108ca5a-b626-4ae9-a809-ae3fffb50cab@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR1501CA0036.namprd15.prod.outlook.com
 (2603:10b6:207:17::49) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|DM6PR10MB4331:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hw5Txc8bsr0crgbKdFzyoDWb8eblw9REMfWChrslyy0+N+ejVhSdl20Mwln10JJaK9+jWN0oin5D4osJdUwqPywDN9VPZhqvKqx6vDC9C5WLruF7aGYFuJpfgjMpg28Un9Y7wCSvd3vyaw1fluhVCsEylG46bKkgeSnV7unSMzZ8hqAdMwfIfpCB9B3Yg9HObJrpojRbzPNA2i3T0JIxEZ+Jc89H4tMnAWdy+ylqpsgLRE/BVNw3zyOsixRBMAYoYxYLNF4wBhgdmtu3b4aQuhmD3IwFn/vWQJwgui06w0QxtX9md0JfDOgsUXgpranqxYMVgR0u34KV2qLXEIov6f8Y17ZKptoFgpSxiCH20AGOW3o6rZxDYjCQOlXi/wjuW51LDZqtZXuVPXC//Pw2oYIyHEQclt03rI4Hz7z7w+tprr07i6bNB2gylN45DN4TcHEjnJwf2j/cdikTE89QWwdHLXkhcWP4Xmij70wBDH3xNTBhsOxGGOENqYiJ7BaSnULI8OGxGQ6uHquVPt6CVX4taireQHifCE1B34H2va7fJuCIAij87I/b7eYTLo1FqC0uGgx7p7Vl9f9XVbm3kUTj1FthN9C3sJIiuhTvm50C2bY5sWe40AjRb3PYXNTm8hOiT2yu4nrQJExqKWPILO7X1QKc62EiKbrUoemKd4A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RGx1UXJQbkExYWo5N3A2Y2lvWXlNRnZRMTVGcjN2Ujg5WTI1UUgyRnhwUUtQ?=
 =?utf-8?B?Q2JCbkk2VUF1SDlzTjNRVVVNbGdFZTJFbEl0T1l1OW9EYnFQQm9YaE5TSTJr?=
 =?utf-8?B?VE1OR2xabGkyTDlzTk5FYS8xVmVlTXEyUGUwMmZCYkd6clJwRDRONk5SMVRz?=
 =?utf-8?B?c1djbnZNdTBMRy9uYXpRUVVmVWdQeXZ5WVZ3d2EvWVI5RWxZdFJ2MGduMGNv?=
 =?utf-8?B?clAxeXhiNEFWamZlT3FPRkRmY25jMjlYTUtMbGNKYjM5WWZ1eWhidHpDaGlr?=
 =?utf-8?B?Z1J2WFNXWlNzT3MxS3hQdkdwZnFjMFlueGg0aG56RU1RemxzamtxM1lweXYr?=
 =?utf-8?B?NzZudHZjaHArRFUzS1EwYmJjNUkvei9ScUdKeldLeHZQcm90Zi9JakdhVlh1?=
 =?utf-8?B?eXcxVXJ3aWxlRGk1T05VQ3N3RGtHQ3dXRURaTUZVTHFjNlhjdENZY1RMQk1u?=
 =?utf-8?B?UGt4cmRYQkJpKzc0dW5tdmVUYzZSLzVtdVg2Y0xLTnVYMnYwby9xZGdreGtL?=
 =?utf-8?B?eEV0dkVUK1QyVXFlMkdsL1ZxYmQrY0IzdUJHaGk1a0xnNUdncVpncUx5RFAw?=
 =?utf-8?B?UExhNU5sWU1rZkFTZjE2RDlHRE9FVGJjWHFJWXllYkdDNEdCYXFoUk1VOG9w?=
 =?utf-8?B?R2FrTm5wUDU2dGR3bDV3K3kwMUM5bjNabVdieVhsOUtKOHd5d0UxUTJVOXA1?=
 =?utf-8?B?RWdPSFgvRmlmY3dDRGJlSS9RVTl4VFFDdDM5V2ZlYVVycE8zWXdwdk4wZG4x?=
 =?utf-8?B?MHdFSlVyOTRiWGg0WGRxRHZ2UEVOUU5Nb2lzc3l1MjQ5Vzc1QVd1VzNMQmo5?=
 =?utf-8?B?MmtDY0RVNjRycHQwTTIwOVRzSERWRkJPUHllN1dhZlE0c24waG1JUlhVV2dp?=
 =?utf-8?B?OU16Q2JqU0h5dXoxWmlwN2w4UXkrdGlLMGVYMkNkTWlianlDZGt5SVkzcmM1?=
 =?utf-8?B?SG4wUXVTWW5Fb3VsTHpJN0pDV2lDNHF4b0tnV3M2RXNubXRFazk0NWhDK0Vh?=
 =?utf-8?B?b20vM0NGYnNBSEc0c1Q4T3RBeFpoK0JBalpzenVLejNYcDJibXFENWs2YUR6?=
 =?utf-8?B?Z1U4RUVjQmFHaDJnNFNZUCtMSzNCajZtSGhDY3cwR0FjREVpN0Y4YXJWUkEz?=
 =?utf-8?B?d2RGOEtzckJZN3RMVW9DR3RNZFo5RW54YkkwdTh0dVRVSTJGbTRnRWdCdE9j?=
 =?utf-8?B?b1pGdndJOUFuVnVTN005ZG1FcGZ0bGhXRlNETGY3MUZERE1lekZ0NS8zYXBY?=
 =?utf-8?B?SVN5MVd3azl1YVdzNUtrd2hvUTQ3TlBBeEpFWm1MVTR2QUFUOGVGRS9NQW43?=
 =?utf-8?B?dGpGaXpydC95aVJZOGhIWlBVSEFFVE0rUDcrMVVwcFNPYTQ2M3o2N05MQTZW?=
 =?utf-8?B?cWxWRWxPWUdpVkpYNVFhbXlmZkhLUzFDSXRSSGhtTEVUMlpTZmNmYWM5UU1l?=
 =?utf-8?B?bjRnaEVzVUJhMjRKZnRoQWc0Y0FOdkgrTmVvV0l1aG1seVJRVU9xR1JGbFI3?=
 =?utf-8?B?MTEwTkd5TVhJbU84aWJnc3B1eGtoTUpBZGdlNUFSODJRU2FVaUM2VEtCS2tB?=
 =?utf-8?B?dUJaanpLaVNERmdIcGRRT05KNWNuSkV2cmpJVUM3cGdEUjMzWDBKd1NNWWJZ?=
 =?utf-8?B?RzVEd3VOelM3WExWV2xQVDFGaVE2MmFiQ3ZIV1ZnM21ISDVEa253K2NyYmo2?=
 =?utf-8?B?UVNVN0U3UW43Q3B3ejVCL0xnRWc0OG5udzQ0TDUrQlNxU3psQ0cyWDlOWGJn?=
 =?utf-8?B?TUNRSi8rWjU0RjhhK1piS0FibVdnL0ZiUmlMSk1oK2txZEw3ZWtFbUhzK1Rm?=
 =?utf-8?B?bmtWNTRhZW15RTU1OHFWRk9VZmx1K0JPNldBa0ZackRBWFEzZytVV3dBWkVV?=
 =?utf-8?B?TjgvV2Mvb0RPOXpmUUw4dEh4MjZwWlFSczc5WVhXTWlSQWlVZFJhNFRpeVRR?=
 =?utf-8?B?R3JxQkFSdUVPWVc0YmdnN2xxRHRiZExLL2dCWGhFaWFZaTlDOHRWb1gwRkFq?=
 =?utf-8?B?UDlaejNHbEdEbkU3emtlUVY2R24ram9yNmxUQ3lKa1NSc0VxQ2N2Q09kaWNY?=
 =?utf-8?B?V0VnaVFlSDhpNTJBVkdOODhNQXJXZmQzMVFaU0JkZExuWnVUVFRmVXFORExq?=
 =?utf-8?Q?68Q+dwXTK8Cg6h+AyPOA+hX1l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hwHChkJkYIlpGbqTpYZk4CV8u0jxI3aynuBclxnQ5bCldLJzw39mxuwQ2xJI2mgHVcIfeLIJ+gctS/MO31fH+QuyJ00uQ7sTmOEf0t6bIVBocdNIzfEOieeKQKK1XHKhd3WDMySmgRiCL2vCMl7/jlBcRZyP45yVyesLN0OdNvCB4lapnD05cy/fJRbJdQrDlZ1aVaumzyuvraQpb4ecRjiwkwPNOKxC0yVRklDdUl0lU+8oeEKgqAGJdQVKOY5Qv6e3hspk6cDiGFSJTP3Ddf6Q4iXPyuMs7a8U0lJoQwxj/MjtF3U8wfNXpWdylL+f8+HFMbDXT/i8tnqkUYFhH2DEzPoRCqippXaucGW4lnZGltx5zByDHdmkyh4kcstw+fISBWJU4ybIc9/oiLAPXL2y0cnp5wyvRHdYsmBvilToER0uOhRZ5fhytGaPhRSebhdSrJQlboYm4UeLpBDO+98Mp1M0HhQB8b1TTfTWDh/8WK1ho6dF3SM3wHKuqymJICdC5DLVtbz5Oc3Tv1Zaouwc0JiAfIxiV7Y9jZj+IaNUkmmnK84upc0AjOLY7WU+kmhEz+CsjnsQGw5kjkJvnkYI0CJEr7A0b3Jj2UYeEM8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5b3986-f840-4d7b-3f79-08dc526b469e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 16:46:28.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nabfecNBovsyRfJBxyqbl4kb9f1ItHFkxcb3PFqM7sqRrLhrNmlel/52fPeWbODiMFqi7F4H4COxm9Mf+h0aqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_11,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404010117
X-Proofpoint-ORIG-GUID: 586Uy0ISs8TXH8X4Y195621hGu8oqOBJ
X-Proofpoint-GUID: 586Uy0ISs8TXH8X4Y195621hGu8oqOBJ


On 4/1/24 9:00 AM, Dai Ngo wrote:
>
> On 4/1/24 6:34 AM, Chuck Lever wrote:
>> On Mon, Apr 01, 2024 at 08:49:49AM -0400, Jeff Layton wrote:
>>> On Sat, 2024-03-30 at 16:30 -0700, Dai Ngo wrote:
>>>> On 3/30/24 11:28 AM, Chuck Lever wrote:
>>>>> On Sat, Mar 30, 2024 at 10:46:08AM -0700, Dai Ngo wrote:
>>>>>> On 3/29/24 4:42 PM, Chuck Lever wrote:
>>>>>>> On Fri, Mar 29, 2024 at 10:57:22AM -0700, Dai Ngo wrote:
>>>>>>>> On 3/29/24 7:55 AM, Chuck Lever wrote:
>>>>>>> It could be straightforward, however, to move the callback_wq into
>>>>>>> struct nfs4_client so that each client can have its own workqueue.
>>>>>>> Then we can take some time and design something less brittle and
>>>>>>> more scalable (and maybe come up with some test infrastructure so
>>>>>>> this stuff doesn't break as often).
>>>>>> IMHO I don't see why the callback workqueue has to be different
>>>>>> from the laundry_wq or nfsd_filecache_wq used by nfsd.
>>>>> You mean, you don't see why callback_wq has to be ordered, while
>>>>> the others are not so constrained? Quite possibly it does not have
>>>>> to be ordered.
>>>> Yes, I looked at the all the nfsd4_callback_ops on nfsd and they
>>>> seems to take into account of concurrency and use locks appropriately.
>>>> For each type of work I don't see why one work has to wait for
>>>> the previous work to complete before proceed.
>>>>
>>>>> But we might have lost the bit of history that explains why, so
>>>>> let's be cautious about making broad changes here until we have a
>>>>> good operational understanding of the code and some robust test
>>>>> cases to check any changes we make.
>>>> Understand, you make the call.
>>> commit 88382036674770173128417e4c09e9e549f82d54
>>> Author: J. Bruce Fields <bfields@fieldses.org>
>>> Date:   Mon Nov 14 11:13:43 2016 -0500
>>>
>>>      nfsd: update workqueue creation
>>>           No real change in functionality, but the old interface 
>>> seems to be
>>>      deprecated.
>>>           We don't actually care about ordering necessarily, but we 
>>> do depend on
>>>      running at most one work item at a time: nfsd4_process_cb_update()
>>>      assumes that no other thread is running it, and that no new 
>>> callbacks
>>>      are starting while it's running.
>>>           Reviewed-by: Jeff Layton <jlayton@redhat.com>
>>>      Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>>>
>>>
>>> ...so it may be as simple as just fixing up nfsd4_process_cb_update().
>>> Allowing parallel recalls would certainly be a good thing.
>
> Thank you Jeff for pointing this out.
>
>> Thanks for the research. I was about to do the same.
>>
>> I think we do allow parallel recalls -- IIUC, callback_wq
>> single-threads only the dispatch of RPC calls, not their
>> processing. Note the use of rpc_call_async().
>>
>> So nfsd4_process_cb_update() is protecting modifications of
>> cl_cb_client and the backchannel transport. We might wrap that in
>> a mutex, for example. But I don't see strong evidence (yet) that
>> this design is a bottleneck when it is working properly.
>>
>> However, if for some reason, a work item sleeps, that would
>> block forward progress of the work queue, and would be Bad (tm).
>>
>>
>>> That said, a workqueue per client would be a great place to start. I
>>> don't see any reason to serialize callbacks to different clients.
>> I volunteer to take care of that for v6.10.

Since you're going to make callback workqueue per client, do we still need
a fix in nfsd to shut down the callback when a client is about to enter
courtesy state and there is pending RPC calls.

With callback workqueue per client, it fixes the problem of all callbacks
hang when a job get stuck in the workqueue. The fix in nfsd prevents a
stuck job to loop until the client reconnects which might be a very long
time or never if that client is no longer used.

-Dai

>
> Thank you Chuck!
>
> -Dai
>
>>
>>
>

