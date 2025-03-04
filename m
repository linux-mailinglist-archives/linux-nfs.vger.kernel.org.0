Return-Path: <linux-nfs+bounces-10465-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80865A4EE84
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 21:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366A01894FF8
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 20:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB331C84D7;
	Tue,  4 Mar 2025 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KY5/qvpu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZZej/Zw6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BEC260A3E
	for <linux-nfs@vger.kernel.org>; Tue,  4 Mar 2025 20:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120681; cv=fail; b=AGkXi6ir103KM/UhEbXZh20kYJMzyBqs9bMd51tqBkQAUNEGnSCxWoL8KJwjCkzJKgxtdQefmJmsQXQsKOtCGGE0FWQ1TOFGh/vSWqfnzEQ48qqPkyVCIpLJvQPmcfWEuPDXxNeAeMQhCkX8HC/JtwuVYZzbuFxBWQEGX7Ss9qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120681; c=relaxed/simple;
	bh=DsoIAu/QACn/CwC+x7XITKF/OPJ+yY+enITedzCGtts=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y42EN3hMmbDEySBU1u+MxclVPnNIEcKRcJO3zeXdo0fNgHlDHs+IQmVtXMGuVUZra0D5ZNRwbro1NDQXw0+zTvfWJoc8iBNscyTpWiD6VQo2tg/ygB9Iul8C5fD+UD+ZUcTSNtL0EKJAd9RhV8lspnLckJ1rOyjwo566ZSTnRPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KY5/qvpu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZZej/Zw6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524HMidS018436;
	Tue, 4 Mar 2025 20:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6j1mXt6oCdk4VkqiU9KzuAMyHSIwLJF62mSy5eD8DOw=; b=
	KY5/qvpug3OrvOlrYFRlo+59KVRpByC/+tW+dIpJ5hZHN81a/1pHjshFgPKR+Xh9
	3yFXZs5fP6W9GVVTWa67tlSi28aPIc+vD/7nTXqq+W0L6IkKGQPmEWjoS1Qul3e8
	eoVJRFWUdj3ewZ1LUw+5IiV+N0viDwoO1h3ExcEwhLkKih35rEQEA+MdmkwlLtrh
	SREHaJumtiXaJLf4/K0qspSSI5qvaFJYale/YDF874LXXzXpRk/VEF7CGb6AXP6M
	qYe/xam++oTfbLoWuKzv6qZSwn1DJLr++gGu537Q2mYrjS3ZwWzg22jC64cfkzcR
	dUr1ZCTkwzXoOwSivdKekA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uavx2xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 20:37:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 524Jop7h021872;
	Tue, 4 Mar 2025 20:37:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwvee8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 20:37:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7NtZQewCQsHuBD61YRNuaZntTnm+TxDGQqDgqSpjHXgV3Vo2qFAV0jvgzlmculp1BFxcfY0OBO9Cdpk9eZ72X8LZ4W40vORMLdSHicCmZbAUk3EUefeV7nSlxMNx2h5za6MgPOoj7tFGWlhDH/cA9D9t9Yuo3paSfDKmYDMAm85T5MIkc/fKa7cUGXPdt2CvbsI60G2BR3uGFjbK3p0Ovw65bNIQ666qiF70wbf+hoUcW3WGG1QFyzYXTIeTRHt+FQXU9FeX5ENgcyutuFBb2OlfV92T0rO+8DnBoib5R4R6Ivr3A8HwcZdzkoCnuXsEzqIPsE1f0sNIm64rTHzvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6j1mXt6oCdk4VkqiU9KzuAMyHSIwLJF62mSy5eD8DOw=;
 b=gW2FpnKwwbBCNYs2zhdnfTybybVYUJEtniUhq5Kys82ZWVhdrJb4xnCZG8B+ozj9HtKZm0tJMrLJfKpIDrWZK3I6U7+kvjO5UR489XJfiKWyRhAC/7Ipo0jGSrlUkWza4rY174B6WihHNlnuW33J1Z+Zd6s+XGiCvm7mlyntlgn8KqIG6cbVfKEDiqEskgsD5b8eiNy7cDSlwu/+CDHEEMqWPVHraP+RXslpFPdjCtylqKioEBWwJQF1XG8uY6hEVY5jCwhsLGHZ9NYHftFIvHprat/Zp5QXThnYhRyF6Hu9Ny8a58yM/9oTpOds8ryBCXyfYcC2TtbvpOaan2f+8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6j1mXt6oCdk4VkqiU9KzuAMyHSIwLJF62mSy5eD8DOw=;
 b=ZZej/Zw6et7jdmaFa0bfBSw4M15DwcVP8dF4XhPOpQ6hCQB2k1Hf3gXOwf18yMAQli9RbmQnAzfHb6DvwIUZKSBpsGqLquBLR3stVTysYk2A5mRPBskBrigQZ9Pr6gO9zPX+G01UOr0bvwpCRYr305xRjoeEmSwSX17J0Ubjx/E=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 20:37:50 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%6]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 20:37:50 +0000
Message-ID: <1224b697-5863-41f3-aef0-59580d85117b@oracle.com>
Date: Tue, 4 Mar 2025 20:37:46 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>,
        Frank Filz <ffilzlnx@mindspring.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH pynfs RFC] pynfs: add v4.1+ st_delegation and st_xattr
 tests to "all" group
To: Jeff Layton <jlayton@kernel.org>
References: <20250220-fixes-v1-1-92c4b1745be8@kernel.org>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 xsFNBF8EmckBEADY7zXjHab4thpE0tJt04MQJYJKBt72eXTweUlzrny8e55IrVpNI6ueSzD9
 bmTRscSqXNgBHbxOxDpajZpELgLm5c6nXjrmc7H01jWvMbrXheWWYJqp3rAohb2TgKn3iU/X
 1JasxFPghPyAvPgvJkRVzBuiKpcg3iPOUId7Q6GNinXZvOKvEWaP7G5abVZUQOT4DTTCPDWY
 ENTDwEL8nonRCIw/ip26WBoFsuUrW981X/Vch46otvSZay5ewiBL/ZO45JxIJdtMglLGoEC0
 AVrTb3TU/EHMCO5GjoWPt9xxMixG/Wtl/8Ciz0PHnJGT4a0LcNgXYWdecIS0GsBxCznGcLnI
 NLYCdoY17DuUsFC3P7EBpiS0ew0hlHAJt/jjX2AjqI/GXptzUm/sc8td99of2ksYZ8O+vmgK
 As/mbNuPyvd6skTh8R8xEZZ9zGhNmGxPP7Xd/Eud3ShF9oqx4lTj0eZYy5oWzmLFTN1D1uBj
 U+aitbp9TPyPVgqxm57p430CY9EiRocvfarWTOEEswgorumrPQzdtspxtqCZd3AfN3EMvKT/
 YtBO+OQHW9ljZNi3VjBgeH7DlXBQDLaJh6MzqX3htRIDumPhTA0kMaQQahcGicoe6GP/Eox2
 m7fulWq8AGDpwufNdV4WOSt86D4h8orUCz5sctIDnxg9PZjzUQARAQABzSZDYWx1bSBNYWNr
 YXkgPGNhbHVtLm1hY2theUBvcmFjbGUuY29tPsLBjwQTAQgAORYhBNRgW60GIMfKPVXcPoUj
 7wBtwVPiBQJkkc1SBQkJT/ynAhsDBQsJCAcCBhUICQoLAgUWAgMBAAAKCRCFI+8AbcFT4plv
 D/96ncpPbwpw61mb1yDlyrJLpivpaRDHoTSAsJ1Ml+o6DkdIPk8VaGdtE1qMBY8fSF/EUsOI
 qBknBYGSqO4ORihswqYwFPoIUWXgvfzxjA5U2XJ9X6ofi4PLpDmuuYf57iMbDunCDNYzS6vw
 g+dblX9cmlBnms9vQ4oMaIGFB4UOxlXrUiz2wJxbPfL3Km7Vfnu1lvhXj2gadcVQJ0lRe3Fl
 nwYDzXxHEgWOkRKO5251NWSCtPpyWg7HXrwtWSndhAgq5WNV0+j6J3Qz/MotlysgeTRsfpdo
 ioGp4GSSELoQ2h0omgzMAugkvjhOHJJS2NQ107eThfecJJ7QPRVnZTpBY2uV35cesciGNmbD
 h1EKXn8A5VzkWDLf7u450lDcFUb4AXoc1W+1/22nCer1Hen0ZVVerSHAwV/VijVCEVrT7Dky
 zXoWSvte4ChM01/SY5vvU9bnlnRx0Ne3QiTPeb+ajO+M5htlGeLtP7uKTM4yJNj1qn8jFV9Z
 U28zUinmJfdjxTiGmVkiEPmK1bc6Y7WPi3xAcIjV4qnEOPjpndYaJBLNyuuPa48vf++RT682
 nofgpa3k308cGuPu1oRflNtGLpGHO/nsRsdRgRU1nKHr9UaoEDl9xjmPjdTSFDuQRGb1Olxj
 K44wDqhZmlP6caR1C5PxYDsm7VYJlCh8OB2Hs87BTQRfBJnLARAAxwkBdfVeL7NMa2oHvZS9
 LOy2qQO3WVN/JRmyNJ4HF/p33x9jwemZe8ZYXwJBT7lXErZTYijhwTP4Ss6RFs8vjPN4WAi7
 BkBU9dx10Hi+UrHczYrwi7NecBsD4q2rH4xs/QoN9LNJt4+vLzh9HqlASVa+o2p5Fs3TyNSB
 qb4B7m55+RD6K6F13bfXM84msz8za2L9dxtjtwOyOYFeoODMBhdkMourO+e2eSxOtecJXpld
 x1LZurWrq7D79wmVFw/4wP+MOAHKPfpWo/P18AfXEW9VD5WBzh9+n8kquA0C8lnAP9qRxtTs
 IAicLU2vIiXmiUNSvAJiDnBv+94amdDGu6aJ+f2lT2A5+QHNXb0QeaV2ob8wzCOOwZZG5hF9
 9zbS0iVR+7LgnJsoJYcKVrySK5oYfAFMQ8tUA102dZ6lHkVdRw77mIfbaXB637SAIxJGpwI1
 bDw3+xLqdqJW/Rs3BDSGrJRMPE1MnfvaAPfhqWSa9aFZ7wZPvO9sm9O5zO3R08COqCLgJxNO
 AVnJCw9aC5X1XzWyQvE3NA94Afl3KVAU1uxtgTpnwP5J05SllpSXeF4DpnH+sFX4+ZS4Cx+V
 96DgYY3ew6/SUGdMbEfJsqelCqz62vHguMA4cLIMbOnbh9CkGsYeJEURixCywgft5frUtgUo
 5StuHFkt4Lou/D0AEQEAAcLBhgQYAQgAJhYhBNRgW60GIMfKPVXcPoUj7wBtwVPiBQJkkc1T
 BQkJT/ynAhsMABQJEIUj7wBtwVPiCRCFI+8AbcFT4vFgEADQa03pwUyFOuW2gSiiEHA5EfvV
 VTAFOSaEO6vPGqjQBJFlNJ3lnkKhqWZNVN04QF/gMD6oZ9f4N5R8TMzPILloR63GTDCns0/r
 SIYaHE4T8OOmBx/vznygacaif5UVHs3hKxq+7ib+Jq/lxli5m9Ysa+lcbZhrNJftxf4BCqGm
 apdIfjniEnH/AXnYFro8U02WbE3vi2MiCunzpJ08/7NRfda7xVzsGDyohonNgu3UK3wdIDL3
 L0TaQYLgyAUIoZVOlAnu6G2DSStT23/4vkTdfC84EMVnUfixI552MsZGohLw8b+fiYUpzNKL
 UfQ1FgHObaQHlOnhg7CNDoLyoboAPfg04g9EHkz9DFzyyvb71olBg+CnSjDNkW4t4ZVfDGDS
 auwmk8dSYiKEq5DWQPrTCvovIdyfvyi3tb0ftjx5UmFFkXtmFsT4uHk8VV3JxKfXAiQAA4h/
 VXlAMWC8UjfPnz134MyB7HflfcdsEt7tWcH2D2yOeTqExQI+uPSd07SDh12eP/MV370xbRIG
 +K5591/cwhDpyIiIbqUTMDxQmH2G87jaAW1l9u7iZvaPCdg2HxqFBEWszJyONgIM1H4YvoBe
 FRB7zTVxmpqVkYS673d1UWIe4y3SQgl3fnN6pIUyWEgse0a3RZS7jJ0clsX1hKC7yZGDhHMz
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <20250220-fixes-v1-1-92c4b1745be8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0512.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::18) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|MW4PR10MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 5176e7be-5ca9-4cd1-153c-08dd5b5c6df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDlsbnlXRVJZNkI5RVZRYU11VGVsdG9BOGc1VHJFZGpTRW5MazN0M3p1Q3c5?=
 =?utf-8?B?Vm9GM3lwbVdzRlpvZUJNSktwWTRacE1NZmxETzE4Y0p2K2x2TFdsUUtpU0hT?=
 =?utf-8?B?KzF6bDNtSy9ULzNUTFlLUklkZjlXcWc2Um1hOWJMcnRpYnNYTEhUOVBENTVj?=
 =?utf-8?B?VGh1WFA3VHhOSTl4ZzM4c3kreG80VnlCeE01VklDZXB6VHdJSExDMW1jdVlQ?=
 =?utf-8?B?S0Q5YnNJUyt2SWF2S3NVcTNyVC9iVGxEOGVPWCtMQ0UxcGpHNHhoN285ZFo5?=
 =?utf-8?B?QU5HZVhBSmV0ZVRTbkFENFYyMVNBdXh5RUx1cnFlN0pEcUFRVmVxUnNCbVNz?=
 =?utf-8?B?RXNNWEY0TVp4RjFNdjUyTWo1U1FFWDQzMlZ1cGY0TmN0V3FuamFUY3ZXVnZs?=
 =?utf-8?B?VFV0bHkyZ2paQnJMQWxZOVFnRjJmaG9vanZsVmJwUFN6eDhFaExXNWtRRTdR?=
 =?utf-8?B?VnlkR3ZTZ0Q1bjZuaEgxUjN5SGIrU3FZTXpMMnU1T3N3bHpoM2xwSmlEajdv?=
 =?utf-8?B?bldReThnbHlLelV5QjkxWHpnWEppbzVmbDVORE9WcDFidzA3dDVJQmJHNXE1?=
 =?utf-8?B?RXZpQ2RKOXhPL2FQRW5zb2VKT2N6Z0xDK2JyTVlPUEtaWlo4K2FOUnpqazZq?=
 =?utf-8?B?cFZnbVBzTFA1aEpEanU4eGVESVdMZWdTUHo5Tk1ORWs0RmhvQTZtZEVqenY3?=
 =?utf-8?B?ZUUwd1dPcUxKaFVic2RnQ0l1eHhTUTI4dXdPakZPZFBTY2YreGgwdldyUisx?=
 =?utf-8?B?N0ZsRFRUV0oxV202WG83QjlCUUlmZ29rRzNOS0tqd1ZVa1NwYWl3OEVvVGhS?=
 =?utf-8?B?a2pScW5UY0V4WWZ5QXpBSjRZeE1zMzBodElUajErN21YUW5sOHV5ZG1nVFZL?=
 =?utf-8?B?RmpIcVJEMkJVb1I0T1lzV0o5QUd2eldWbjNSbG5KL2tKTFVORC8xbEZoUzFu?=
 =?utf-8?B?SGY1NXN3cXhhQVhITUcvL3Nyb2RFclpOTkpxRDR5NUJzRnRka0JzaEpocVUz?=
 =?utf-8?B?cTRlZFpXeWFRREYvbSt4ckMxRTZMR0FGL1QvR0wwNCt2elBVQUEzNmFnWXNF?=
 =?utf-8?B?SjBsMnJrdVRwS0s0R2FFclUvb0tZQk1YUy9sem9TaFhYTkI5NlpqbjJXR0c2?=
 =?utf-8?B?bExnY3NHRlh4Nm5zRnM2VWZORGxWOTVSSHpPT2MwczFyellVamdFeStIdDBw?=
 =?utf-8?B?V0dRKzlpRlFBQklGV2RFbHEwZGsycTRUZmNDTGw5RGQ3S2s2V0ZUbU5LcFdu?=
 =?utf-8?B?dzB1M000UEEwWHhJMnpGTkJxcmkxV0k5YTMxMXZuRjlEUklHZkxmTm5wRmNr?=
 =?utf-8?B?QXJWMERGK1dkUUI5aFNGVkFkV3ZvWHBTK1F5eUFsT21TV0g0WWZLelJHWkc4?=
 =?utf-8?B?Nk82SVRoS2hqOW9Ca3dLTzdZSk4xNzBkMzJtOFQ2WjlycHBYS0ZBd2hlbTFk?=
 =?utf-8?B?a3RxZC81blhaamVBaFZDZDZlUHdGMUN4MmRsUzlxdlVqWVppTXFrYU9pZlZu?=
 =?utf-8?B?YnJHaElOQW9SMGZOYnBqLzdja1FjRlg5L0dvbWRCVEp4d1pGU09PWkw3ZUpX?=
 =?utf-8?B?aGZSbzE5Vm5XWmEvbiszS3JIMCtqTHJIeEd6ZGxNSVZyeW1aMjF3bGtNVkZJ?=
 =?utf-8?B?Qm9QTjJKOGsxdUJIa0d5Nk1Nb25COU5jT1c3WFY3SmFHUElmemYwMy9tY0dR?=
 =?utf-8?B?MHRZRnVtMDVPcGJSdnlZSEJlaERJRW1OallVSmZ5bHZXdFIrN093QUdqZEtH?=
 =?utf-8?B?cVVOWG1QN1l2Q3R1UmkrSGMzT0ZETG9sTFUyd0JYVTZvVnAzRHROU0REc1c2?=
 =?utf-8?B?TDJCSXcyNitVL3BML1p5bHBzZ3NaT1VKcjcyYW1seEhJV3E3ejduODBmeCtj?=
 =?utf-8?Q?xv7C6kcQC4E64?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RktEYzlSeFZYaG1ZaWFaazVUWFUyWUVxQjRQZUo4bm9TSzRGUnN6NW85cTZ4?=
 =?utf-8?B?N1ZzR0NySHBMR0JNQjdYU2NDdDYzd29EVHNlMm9Ic2hZWlZSV0RaWm5uUExm?=
 =?utf-8?B?bmdsOFhpUnBWYXF2YmtBOCtCYTcwSHRETWIrNTlvZk9mbDRNY0JTcmFVN3RU?=
 =?utf-8?B?U2dBMWo2Q25IVzRIS3dCT2QvZWtBNzYwTnJvaW9Ebm42RXFzaVFiUXhyT05D?=
 =?utf-8?B?ZElLVnRHYUR4N1BQTVVxV015VDVjWWQ1clpDN29pR1BYaUNiSGJKdnZSaXRQ?=
 =?utf-8?B?TmJua1lzc2NpUjZCdlpwdTdCYm9KNEJsU0pVQTlDMWtrek03Ymh0OU9lTmxu?=
 =?utf-8?B?Q3F5UWlXRWE5MlF0MWxSYXlKd2RjVDV3N2FuVXRYMmpFK1VVUG5DYmF3cHBx?=
 =?utf-8?B?S0tBeDJEZVhIT2JFRUg4d2doeXJXU09DMHdBQnlvSDVHYUdOZzVXa1Y0SXNL?=
 =?utf-8?B?V0FITVZjYmVhb1VmY2E5M3h3clNUYTFCVUUza1VDV1RxcGx1UlViVlNKbzYz?=
 =?utf-8?B?SUFPdDZlV1RGWkhWTWxMWm9Tak5rOStyeWxralN5UFNPMEVibVNyRjI4akc4?=
 =?utf-8?B?VlRGbEgvY0R5Q0VhNURldkZTamUxZDJkOXdWRVdYSC9uTThTWUMweFhqcm5x?=
 =?utf-8?B?aC9HZEd4RmNVN0t0dHJmbE1wczJ2Tld0R3JRQVhHS2cvdHJSS2NFMEhpNkQy?=
 =?utf-8?B?b0p1cTkwWFFoZTNoYkU5RmRxUTZkN21QMjNNTEhuTWxKVFp4bjErMWJmVXFn?=
 =?utf-8?B?TE5vSU1HcEE1YlViOWUxZ0VjQ1p4em9EaDdlbnVFVzhEampVcGlsZGJkRVFu?=
 =?utf-8?B?M2JVYk1aZjNjWnVhampobGYzNDRlVnNiVGUxMFR2bllTNGpPT2N0bW1Nc3oz?=
 =?utf-8?B?U2FZS2lPVitDc0lyb1JEa085MEQvVk81Rnl6STloRHNCb1RyUkJweEllSm80?=
 =?utf-8?B?QmxOVjBqVlpmakpqYlFpRFhncVUwcWR1eUR1aXdTODA2bzl5L1ZFcGxXdjFU?=
 =?utf-8?B?UnJnTVltNE53NnUzZHdWSmRBNU1XQWZrRHVQcGF4dTVqT1dnZ3dMaEYyekRk?=
 =?utf-8?B?THd3K1B2bG5VZXc2SVFCQk45M1VPWGxJNmNuTDFzU3dpNzFsUzRMV2NoTEZC?=
 =?utf-8?B?ZGd5VmVWZ3pDTkVITkpjSFdtdUowZTZXUDUvaXNCNjZwaSszUnN5YmRaV3VW?=
 =?utf-8?B?OXF6dzdGSXFINU1rWTRuUWRUYW1HTFdvVlNITUxKYjBMWm5sb0dLbHRZUW53?=
 =?utf-8?B?dlI4RlYyYmVYcVVUQkxzK1BlUHFPWHFFeW0vUnJOY1JoNURIQ2ozWjNBOElm?=
 =?utf-8?B?TGtac2pVUFpCTkhzbGN3VWhobjBwR2FGOFBXRHJPUmN6M3pZTFFKSktzcTE0?=
 =?utf-8?B?WnpjcWZZdlZKQVQ5NDZ3aTE2aU1seDk3RGpuWTBNeHFYaUpNMS96WHVkYVlx?=
 =?utf-8?B?aUE3VGFMb21iUWZTZmJJNjEvYTBGa1R0SU5pZ2s1eE0rTnNveGZqVWZkM1Bp?=
 =?utf-8?B?dnVmcTBvR3FMME42dHd1SEJBL05mb2x2M3NHeFlVajVOMEVHOG51V1FVMm01?=
 =?utf-8?B?amd4eVpoK29MWmdiL0VLTzltRFlYODQ0TnFZZG9WeUxUcm9wSTJSM3kwc1NR?=
 =?utf-8?B?MU96RlEvSlVvY1Q1Qjl0RWJ6cVYyLzU4M0kycElHWkdOV1k3TVA1U3hkYlRx?=
 =?utf-8?B?NDN6anExSC9zL0JicmRWaTd3aWJhdndNamRCVHJFSXRKdi90UTlFQlVOZ2s4?=
 =?utf-8?B?QUc4OFFhbzNzb3BsOHkxZGNzd0p3ZTZ6WkIya3BMSXBLNnFhMldYZTRxdGtJ?=
 =?utf-8?B?TFhZbnpmRWxvZE0wNWozcHNhbVFIMVdoSmhETE9laDV2RWtIZWVPTVdoeUJi?=
 =?utf-8?B?OVZXNUx2YmVrN1l1MVZNQzUwcTFPbHNkTkt5bDhKL3dtRU5iNVUyOVgrTjlp?=
 =?utf-8?B?R25zaG9CQ1cxOTZjT1ZQdlZWREtwSVRyaGJhcHVPZVI2KzRlT0pOK3psV1Er?=
 =?utf-8?B?TU9qVmVJRE5UbXRXV0x2eUdCVmJHYXpxcmVxTkUxbEFYcGVnTmU1MFlCTmls?=
 =?utf-8?B?b05qcnZhQ2d6VmxHamZNRFEvbkErZUtnc1l6Wjd6MkNtWk5lM3JweDlkZlBI?=
 =?utf-8?B?VmZLaTJmMGd1SUxlTm13NzdBTFlNT2JDVDFuNHVoNHJJZkJyWHpQMG5mUG9Q?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8kGVYB9KQ6NYHgxZYipT9/mtOQR6EnBLniMIkvx5kiwFzXvZgvXZX8Be9EM1Emq7sEOj7N63agX6kX5GUqxvJ9/alIAaSXm2A148un7lijkzOSE3UjDsqNdeIIFNr4qYPbodPgSxfqxwgKFxi4DBvzziv8IPRp0oAaJZb+CP7DlBcJKxmLJTQJwyZ1S5SSZGkuHHElOz1pPAT5Q4x4UTuwVeGueiRqMcVltu0SMzScBy78mf/k20uM8cceEbeEM33CuR/dxZQsI/HXZ2ek+Gf8zJnRfTKJxXMD+MjtLiyp2ysisnNRrWeHPp2cIUVmzVr2iRK2hgSXfDxdJmZLC4fnRAxyyzeyMRRJI6xv8nda9gQ6gfEYatsPOF50iSqvVi22WJn6G+uZS7VOI7oC1gY2fq8XKkVEL9UY/FKqbHF4b+XyjZXujS4Rjv4PxmiWRTLTPWmgSO7Gdcn913noySVkkfG9qF0xnPKfhc9pRafHf5H+Vy+l/H8O+neF5gvMrAIOSi7W/bhL+Jrw/DDvD8S24s/vpC0dDl/Q24sVIftLy49InQmDYaxvKf4IiK/FxZuc2wj+azlHkdyBGzEoR5eX14FN2dXiHZJQ/+bMbrDBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5176e7be-5ca9-4cd1-153c-08dd5b5c6df3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 20:37:49.9276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: it72I/1P9jaBZvbAi+IF8HFBEbodsEqt/+Tf+lCSqzsOx5Ck4ZIQLW+LeUr6vomZtcLs6URv9+ydW3gIrbZIsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_08,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=818 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503040165
X-Proofpoint-GUID: 1PFICKVALi3epsMnAbBsQzapi-_zSF97
X-Proofpoint-ORIG-GUID: 1PFICKVALi3epsMnAbBsQzapi-_zSF97

On 20/02/2025 4:54 pm, Jeff Layton wrote:
> These tests all pass against a fully up-to-date Linux knfsd, and I think
> should pass against ganesha as well. Add the "all" flag to these tests.
> 
> Cc: Frank Filz <ffilzlnx@mindspring.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Should we add the "all" tag to these tests? It might also be good to
> think about tagging out a release before this change, so that we can
> tell people to use a specific version if they're hitting problems.

Thanks very much, Jeff.

Applied, and tagged "pynfs-0.2", as there's no other pending changes.


The previous commit was given the tag "pynfs-0.1"; before that we've not 
had tags in the current repo.

cheers,
c.



> ---
>   nfs4.1/server41tests/st_delegation.py | 24 ++++++++++++------------
>   nfs4.1/server41tests/st_xattr.py      | 22 +++++++++++-----------
>   2 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
> index fc374e693cb4b9a9adaaf5ff15a64a02573113b0..fa9b4515dba25c6dd0bf11b409b6eacf5e783cbd 100644
> --- a/nfs4.1/server41tests/st_delegation.py
> +++ b/nfs4.1/server41tests/st_delegation.py
> @@ -67,7 +67,7 @@ def _testDeleg(t, env, openaccess, want, breakaccess, sec = None, sec2 = None):
>   def testReadDeleg(t, env):
>       """Test read delegation handout and return
>   
> -    FLAGS: open deleg
> +    FLAGS: open deleg all
>       CODE: DELEG1
>       """
>       _testDeleg(t, env, OPEN4_SHARE_ACCESS_READ,
> @@ -76,7 +76,7 @@ def testReadDeleg(t, env):
>   def testWriteDeleg(t, env):
>       """Test write delegation handout and return
>   
> -    FLAGS: writedelegations deleg
> +    FLAGS: writedelegations deleg all
>       CODE: DELEG2
>       """
>       _testDeleg(t, env, OPEN4_SHARE_ACCESS_READ|OPEN4_SHARE_ACCESS_WRITE,
> @@ -85,7 +85,7 @@ def testWriteDeleg(t, env):
>   def testAnyDeleg(t, env):
>       """Test any delegation handout and return
>   
> -    FLAGS: open deleg
> +    FLAGS: open deleg all
>       CODE: DELEG3
>       """
>       _testDeleg(t, env, OPEN4_SHARE_ACCESS_READ,
> @@ -94,7 +94,7 @@ def testAnyDeleg(t, env):
>   def testNoDeleg(t, env):
>       """Test no delegation handout
>   
> -    FLAGS: open deleg
> +    FLAGS: open deleg all
>       CODE: DELEG4
>       """
>       sess1 = env.c1.new_client_session(b"%s_1" % env.testname(t))
> @@ -115,7 +115,7 @@ def testNoDeleg(t, env):
>   def testCBSecParms(t, env):
>       """Test auth_sys callbacks
>   
> -    FLAGS: create_session open deleg
> +    FLAGS: create_session open deleg all
>       CODE: DELEG5
>       """
>       uid = 17
> @@ -131,7 +131,7 @@ def testCBSecParms(t, env):
>   def testCBSecParmsNull(t, env):
>       """Test auth_null callbacks
>   
> -    FLAGS: create_session open deleg
> +    FLAGS: create_session open deleg all
>       CODE: DELEG6
>       """
>       recall = _testDeleg(t, env, OPEN4_SHARE_ACCESS_READ,
> @@ -144,7 +144,7 @@ def testCBSecParmsNull(t, env):
>   def testCBSecParmsChange(t, env):
>       """Test changing of auth_sys callbacks with backchannel_ctl
>   
> -    FLAGS: create_session open deleg backchannel_ctl
> +    FLAGS: create_session open deleg backchannel_ctl all
>       CODE: DELEG7
>       """
>       uid1 = 17
> @@ -165,7 +165,7 @@ def testDelegRevocation(t, env):
>       """Allow a delegation to be revoked, check that TEST_STATEID and
>          FREE_STATEID have the required effect.
>   
> -    FLAGS: deleg
> +    FLAGS: deleg all
>       CODE: DELEG8
>       """
>   
> @@ -220,7 +220,7 @@ def testDelegRevocation(t, env):
>   def testWriteOpenvsReadDeleg(t, env):
>       """Ensure that a write open prevents granting a read delegation
>   
> -    FLAGS: deleg
> +    FLAGS: deleg all
>       CODE: DELEG9
>       """
>   
> @@ -249,7 +249,7 @@ def testServerSelfConflict3(t, env):
>       That should succeed.  Then do a write open from a different client,
>       and verify that it breaks the delegation.
>   
> -    FLAGS: deleg
> +    FLAGS: deleg all
>       CODE: DELEG23
>       """
>   
> @@ -357,7 +357,7 @@ def testCbGetattrNoChange(t, env):
>       client regurgitate back the same attrs (indicating no changes). Then test
>       that the attrs that the second client gets back match the first.
>   
> -    FLAGS: deleg
> +    FLAGS: deleg all
>       CODE: DELEG24
>       """
>       attrs1, attrs2 = _testCbGetattr(t, env)
> @@ -376,7 +376,7 @@ def testCbGetattrWithChange(t, env):
>       attrs before sending them back to the server. Test that the second client
>       sees different attrs than the original one.
>   
> -    FLAGS: deleg
> +    FLAGS: deleg all
>       CODE: DELEG25
>       """
>       attrs1, attrs2 = _testCbGetattr(t, env, change=1, size=5)
> diff --git a/nfs4.1/server41tests/st_xattr.py b/nfs4.1/server41tests/st_xattr.py
> index b3eb8a87465b9fd76121e846f9927bfc0867ffc8..f67df9517bdbac0ebd88c0c9f94244a96d5d2d3e 100644
> --- a/nfs4.1/server41tests/st_xattr.py
> +++ b/nfs4.1/server41tests/st_xattr.py
> @@ -15,7 +15,7 @@ current_stateid = stateid4(1, b'\0' * 12)
>   def testGetXattrAttribute(t, env):
>       """Server with xattr support MUST support.
>   
> -    FLAGS: xattr
> +    FLAGS: xattr all
>       CODE: XATT1
>       VERS: 2-
>       """
> @@ -37,7 +37,7 @@ def testGetXattrAttribute(t, env):
>   def testGetMissingAttr(t, env):
>       """Server MUST return NFS4ERR_NOXATTR if value is missing.
>   
> -    FLAGS: xattr
> +    FLAGS: xattr all
>       CODE: XATT2
>       VERS: 2-
>       """
> @@ -53,7 +53,7 @@ def testGetMissingAttr(t, env):
>   def testCreateNewAttr(t, env):
>       """Server MUST return NFS4_ON on create.
>   
> -    FLAGS: xattr
> +    FLAGS: xattr all
>       CODE: XATT3
>       VERS: 2-
>       """
> @@ -76,7 +76,7 @@ def testCreateNewAttr(t, env):
>   def testCreateNewIfMissingAttr(t, env):
>       """Server MUST update existing attribute with SETXATTR4_EITHER.
>   
> -    FLAGS: xattr
> +    FLAGS: xattr all
>       CODE: XATT4
>       VERS: 2-
>       """
> @@ -99,7 +99,7 @@ def testCreateNewIfMissingAttr(t, env):
>   def testUpdateOfMissingAttr(t, env):
>       """Server MUST return NFS4ERR_NOXATTR on update of missing attribute.
>   
> -    FLAGS: xattr
> +    FLAGS: xattr all
>       CODE: XATT5
>       VERS: 2-
>       """
> @@ -117,7 +117,7 @@ def testUpdateOfMissingAttr(t, env):
>   def testExclusiveCreateAttr(t, env):
>       """Server MUST return NFS4ERR_EXIST on create of existing attribute.
>   
> -    FLAGS: xattr
> +    FLAGS: xattr all
>       CODE: XATT6
>       VERS: 2-
>       """
> @@ -138,7 +138,7 @@ def testExclusiveCreateAttr(t, env):
>   def testUpdateExistingAttr(t, env):
>       """Server MUST return NFS4_ON on update of existing attribute.
>   
> -    FLAGS: xattr
> +    FLAGS: xattr all
>       CODE: XATT7
>       VERS: 2-
>       """
> @@ -165,7 +165,7 @@ def testUpdateExistingAttr(t, env):
>   def testRemoveNonExistingAttr(t, env):
>       """Server MUST return NFS4ERR_NOXATTR on remove of non existing attribute.
>   
> -    FLAGS: xattr
> +    FLAGS: xattr all
>       CODE: XATT8
>       VERS: 2-
>       """
> @@ -183,7 +183,7 @@ def testRemoveNonExistingAttr(t, env):
>   def testRemoveExistingAttr(t, env):
>       """Server MUST return NFS4_ON on remove of existing attribute.
>   
> -    FLAGS: xattr
> +    FLAGS: xattr all
>       CODE: XATT9
>       VERS: 2-
>       """
> @@ -204,7 +204,7 @@ def testRemoveExistingAttr(t, env):
>   def testListNoAttrs(t, env):
>       """Server MUST return NFS4_ON an empty list if no attributes defined.
>   
> -    FLAGS: xattr
> +    FLAGS: xattr all
>       CODE: XATT10
>       VERS: 2-
>       """
> @@ -227,7 +227,7 @@ def testListNoAttrs(t, env):
>   def testListAttrs(t, env):
>       """Server MUST return NFS4_ON and list of defined attributes.
>   
> -    FLAGS: xattr
> +    FLAGS: xattr all
>       CODE: XATT11
>       VERS: 2-
>       """
> 
> ---
> base-commit: 81a4693305abb42ffd16e77a4808a1a607693476
> change-id: 20250220-fixes-4bb1039117da
> 
> Best regards,



