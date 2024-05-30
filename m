Return-Path: <linux-nfs+bounces-3491-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3CD8D4EE8
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 17:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EE15B26F12
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 15:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B857187540;
	Thu, 30 May 2024 15:17:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF8B187545
	for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082225; cv=fail; b=V2rLDrzvDtw22I5V3Jtr6RjBPY5Qs3cWPAgydksg1yiSRjoPv2VuyaPfLL1XL/65ueJ9uHG/617MeO+dqRmAdcxZyyWyDjD+aT5ZUoxzw0+ib4WzJOOpmCp2NNFQliET1jiKUoGw6Q4e0x8N1kQn7ctN27xx9dqAY9cnyAiSCTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082225; c=relaxed/simple;
	bh=cZFdHtdTy4sHUITmSmiLgCay0TPYMFztEQ+4C1/9jE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l8sw7V1FWFZNrkkvX8urm5vlrq/6yiCqzMgmLDROUwa8Zjm98/uUx6aNKURPzwOCMn+oDbV0pKSdNoIHA1kUulkUgasCWpF5fdlw8j+Dhcmhl9/9l+Tcdgv8hrUMY7e5HVFwvgARvfZ6GwZ1t9Cch7545tveYfzgqtvnoZja14k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U7mspg018561;
	Thu, 30 May 2024 15:16:39 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3DbRymFj85P2bx?=
 =?UTF-8?Q?SqkiZep2Wx1+PnYUvnP+NvShtdgiu0w=3D;_b=3DX6r7wrifAF3EsY7+Ch/ewS0?=
 =?UTF-8?Q?fvuhh607HHydfyRmDqVM6cnjDtqMZR7ATTOyvwoZPJTP7_0pwDdzHsjIaPGjiKa?=
 =?UTF-8?Q?wLgSx7cJrxwpempi6r6Brs5ocKqjkkP76p0NLNo0KX8QuZQGBkg_6/w0UHBSSLT?=
 =?UTF-8?Q?unEm2gSvgvAinkQMXUgU5/U6MkO30HiWH2yrQL3v2TPdjJR2qc8LOhfuB_kYH+9?=
 =?UTF-8?Q?tMo91WeQkk9OJxJkutiOMiRNFy6aFIHhXgkW0gPhqQDGnwhOjqA2m/cAWkCo2Y4?=
 =?UTF-8?Q?_E3klU49xMT/cWpNjRbRTHtlKX4DADIMDig+Ftqd6JHUYCXU4oV3jhgrXBpaXHI?=
 =?UTF-8?Q?PLG40j_2w=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8j8955r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 15:16:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44UEP8qC024001;
	Thu, 30 May 2024 15:16:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc52e0qv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 15:16:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdnTSUt5KmZ2jDKhg3+CaX9e7/rsNEZ4FYR1IW4TKLEepl1cDcTc9qO3E5r5b4caFnmIjn/8kkZZdwNwrF9jeBohCtL6IIf9yBQ81jadNHl/CBrlVy4i8r3MCeVJLUcRitrzQwhmyPrmGYRCBDuagclKAN0488YT0MAmgQ913kAtcoLR80duNKq4GrbvRqlGDpRK/CtSseYebAMPj8MZT3LZ17+gFJ2jVBzSHexVBEaP6O7iYvuYlIUTkHSN0hIrBeZPu6T+Wu7tjrk1Jyzb1SL046x72y6D7WIZevWRxeyFr6NfQzNhVA1qIErvpQ4gEsOt68oRcC1kPVgdkUUcKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRymFj85P2bxSqkiZep2Wx1+PnYUvnP+NvShtdgiu0w=;
 b=Ie/nzqrcwJM3GMGTmpMP1/hb/uBOzE3G4V7OmfHGBqlCstKpS27gqeBet4ROV0/2g3kLJWiZ3n1qAKnoz4lE7gVcMyett5qBD7evqi542TJ91UaP6lqbuC59PXosp+pyoypy6lCP3tWAfTXCX0bWQ5dtpEo3P+4hsinhPPPQpze+GrTzec8PbDNpUA8ZyxKiCsmpHIAYvZ4kd/y44e1HMeebPm5AqLOnrIBy2Nu4dKbmy4oFMpXEJVeFxIISBbOQei6B9nBedgVpvg/IkBLDi/JsgQb4UPTdboXKrw7X0cAM8Dwsyluk1IKXJyIZO7W6Ipa64uzAvhecpMaau+ZMZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRymFj85P2bxSqkiZep2Wx1+PnYUvnP+NvShtdgiu0w=;
 b=kH4ikfaKeImjLD10Z+0dsBEszNbe8zsbnrlcOj+j9cmgg7vBZR2n4CAWM2u6PkTHlzz+slISgR8skMKkGloJ7r2H1Uvsmascy+WB9yJK3SaQswRLYiwMJy2742LtMQerzHyysAVxrObOQY8YOkKk9FN33YHkwg1dn8jkt6tx6Wo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6096.namprd10.prod.outlook.com (2603:10b6:930:37::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 15:16:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7611.025; Thu, 30 May 2024
 15:16:36 +0000
Date: Thu, 30 May 2024 11:16:33 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Chen Hanxiao <chenhx.fnst@fujitsu.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: return proper error from gss_wrap_req_priv
Message-ID: <ZliYUa8hNoHgLIkB@tissot.1015granger.net>
References: <20240523084716.524-1-chenhx.fnst@fujitsu.com>
 <E6007B79-DBB0-413A-9C46-6860AA25782D@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E6007B79-DBB0-413A-9C46-6860AA25782D@redhat.com>
X-ClientProxiedBy: CH0PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:610:33::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY5PR10MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 734c2e41-fbd7-4edc-4aeb-08dc80bb7f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ThF168t4xzzBdABBJS1G+ZPuo25YV3z3F9+fFcJH9kp8lBbdc5hKZf/98UQy?=
 =?us-ascii?Q?Mpp2BiGO1e1Yi056TXSTGFq8onRNHIF1DLNOQhBNc3NOJd/Rnzx7HmGW8YO6?=
 =?us-ascii?Q?Nr40HIK/hUv7V2EXbCC2u4trgx9WRdO+fxaCx27gfIQTTf/HGrHIr4u5gH21?=
 =?us-ascii?Q?SzVjYUXhhC5gt5NbluIj/zM9uvHcyDeXpJyfYJVuLxotYTJ2CgWSVHS2AGHC?=
 =?us-ascii?Q?+BKDwA1zwf2nrK/cW9xfdfZuBjH5RvWZAYQ7GfZlA2xHBgeflXssZDgEGiBR?=
 =?us-ascii?Q?JW31VT0tkp/uIoyhglMXA4wVf3Z02DbLaDS/d31lZSJSflkURWjBeNw/ATpn?=
 =?us-ascii?Q?YZzjpT+HsLQCBNVuoVF164CTWDCyOD4YvhVB26wiTyk+P8vyzFmEbiF0IzSM?=
 =?us-ascii?Q?xzs0+7TZYO8bLNiiWppnJkckZAU3yyKDsfG62oDedCly6xXwIa2+mRoKkTCi?=
 =?us-ascii?Q?H4Di4KIEwIykST0V0ufkQ1h+0iQK2AFcXdz7kyqDib2fftLe7DhmUW94Z1KF?=
 =?us-ascii?Q?strL48YqaV0YgF8qfBL+P9KsaMo7UTXWjCSo3/YSNfCVanWccIqJBG/OfnNt?=
 =?us-ascii?Q?5A3UeYIPCV6UPaol1w8mwzAw6sqd84Sy/PCxO4kc+yNtliGvb46LNlb5+QVx?=
 =?us-ascii?Q?24/8IqMq2RoUBz7u1WDKt6b3C9FfwCkbmEnD11TN38cEBKvrEBsKRDqY7ae6?=
 =?us-ascii?Q?vOI0U9KzHAs9ZpF4KjJzuqV+ENytNP6NbwrO4MFAzTdFppq+2xBWPL3bWwmR?=
 =?us-ascii?Q?dmmZVGxv3F4aCdRr71pJwhr8rWYNidgTYL12TYUn0xt02nAr8CIwShAdB0rw?=
 =?us-ascii?Q?egjQgvq8LHzqQQ1auI9Z9dxv/iZHDN/hoEgNiY8w3AUmCIRbniHRtbFX3Aoz?=
 =?us-ascii?Q?5EXf8hAz0bi3XxQlbO0Eoe6tq3U5UgQSZiF7Pe6vcX6Hl7lvwaDSHge13DYz?=
 =?us-ascii?Q?cVntZa9ePL0mj0oSUujCHwhYWDYsGTpzVuZ01WVfQ46+pKfkanHAQlNgu6Bb?=
 =?us-ascii?Q?Q6AJL9Vn5W60bpo5MmQJTZtVJBmodOqWVUrlePr3O0xau6fX4PsYqBHrlLE0?=
 =?us-ascii?Q?q7ktsQhrMkvbugAxc5kJN6zGgboD7f5knbdd+Bx56Ssp6vFHu9+qjZAK4Afd?=
 =?us-ascii?Q?8UK5NBd0RsX1O7TUkG6OA/uFduiwke+ebkjY10R4CpL0ps+pd1QZ8tT6LvyY?=
 =?us-ascii?Q?l6N/Eac/e34vkU+97JoEacrcMjQ5qcnh9BMbRx7ZcF9EdF5nQ3XRywOOU0u/?=
 =?us-ascii?Q?EfF4hN07d5JJRDFiJivM7E13A31F4/lazc8V6hgO5w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ha2EMzSWtN+ed+mF5q/9Mzob91MyuJhDx0cVVf1cYEc4EaaU4bchGzLg81yY?=
 =?us-ascii?Q?gJfiEWgvHy0ppNjV3jihLhtZTVe70aHJ2jXI/NhdtYF7RA/Nexw6qzNcDWXU?=
 =?us-ascii?Q?dxS1FOTj784kbweBKotrMoMFZRPxrYi+BPeni2cD5Ruczjs2vw7Bqa9rN17v?=
 =?us-ascii?Q?F2BXofvzbZFr8sF2d2LjW08wGcfsjIpbyilbfLvPEZOfNdw+K46hog/0ouGB?=
 =?us-ascii?Q?Yde9PzzX8QuAI7kZtXq3ENza+tXTYn49dzRDoczQoxwucwOcU6avqFqD/uvp?=
 =?us-ascii?Q?oeBfOy76+KuJXjSpJawnJTWPd6BbnyoF2QDOrlGwlDN05+blBBq69v/O8Jou?=
 =?us-ascii?Q?0UxPCetfmEc3y8v1FF8Me4ZQOOZVMq3N7fW/Rferxkqd9TavkekdPr/N86e8?=
 =?us-ascii?Q?raKW/pKJ69g8Scb3YKha1y3KXdwLzdJvDJuZJMk5u02dXrCrqhMMBVlEBoP6?=
 =?us-ascii?Q?ZXQIKAS+gHIlq81i2/Jvoz4d3LFcQlm7UCbdi+EPtUIjDx5lC6r48eXowW9t?=
 =?us-ascii?Q?XeG0jCtA/B4qnfjfBeGxLPFMhcKxLKx3+KR4Pw7jLTLqi9VuoHOy/NtVGa3F?=
 =?us-ascii?Q?c3Ecob9Aa1UxPZMLKi1lZT8Wz9a5twftab8yag0hDl+erYPw+dowLTsXQEe6?=
 =?us-ascii?Q?SToZaKjsomTEw4GnzYXOAxEhJkBffPEgE82OW07cIsp4DBG8RIRlaiK27NqM?=
 =?us-ascii?Q?3ZosRPLKV6+AYo20MOXUcuFlezXihvAr5ZEcWuVnrK7BEdQz0fMdV6yHr1Lk?=
 =?us-ascii?Q?39x/5iQQUm4b1EE4yufkYoQQAc67WWWRcHZ4kLvPmbpK6KLO2MLG+bQ65oZI?=
 =?us-ascii?Q?BLLQBsijDnybc0LsI+PiAqc3zMBWkAeLbND3NsshHqLoYiDyZRO1p2V9eD4d?=
 =?us-ascii?Q?JUPw2sB9LtuiV4l9FjyO8DypDlt5e4pCp04oHUwjqcniXLKD/Dil43Kl3IAX?=
 =?us-ascii?Q?8O/5Eib0TqMtwGGaHCfMmSmwk0FgNyCZ9yMU0hKhAnAQ+i+nbzkFAtpBL85G?=
 =?us-ascii?Q?oO3ThZVdQ+r+htBrWMnpq3F2Z6YuderVW56tdnX9BqlPKDdZj5h00VhpP9lv?=
 =?us-ascii?Q?mSr5dx2m51cKcVj9oK4ew+IzhT+R6mINHsEkArGCMbb/2asflMhu1E6GnVgw?=
 =?us-ascii?Q?bCtZs7kK8SGdzrfheUc1IublyBwrygZ5lEjYbWbvbwQN+t2hKKehSUsYJ6S6?=
 =?us-ascii?Q?NPxK7lFhRaVYOuUX3ohthjZW5FTpEsKCgSRJTkNXsgSKAmXpEH8pQZ1ODUsA?=
 =?us-ascii?Q?vO8dedYBIf/ZcTDTwCouIBQ/3wkEQ1owjl5df7TcRdKw0lZ5LklENQPtCAM3?=
 =?us-ascii?Q?VT1R8sryoFoIlOrW6oIgXZBru/K2ElsgzpYlrHYLU0csgGlI4XWsmLDn7voa?=
 =?us-ascii?Q?ZOhS4joLVp9n+yN+Av2hLddDubydzEb/uDRzEtyaj/Z70KNIstFC4VRp2HMw?=
 =?us-ascii?Q?iL7LkDNbzJd2RZG7cf7sjmdb15scyeZ9cH1/fbKlmlhDBemPqVuUf2L9752R?=
 =?us-ascii?Q?UWSDUhO7i3t7dzkUETjzTNdUvRVOENrAJajiKlLHSZJNlq7bibEa6Q3HGJat?=
 =?us-ascii?Q?Tj94//UMGL+KWDFk34aJZ0qUgDSnxY8aXP1zwU6akvkTCmSoMpp89kmr72Gn?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OocndXGxRdabqPsDRp5qHxkktYD/aM4GwLqIQNJanTMAW3YhpIrYdi+pY7mj34/1sbuon6QFviMHo+RNpRyNAW495mXcOAZUA1VqUpKgm1FxkKdSr2bh5nSh8F4QFNsI8RlFzt0x9+TPvLHUG6OefSmjfQazqkH/s1epBvmZ707rGLIL1WqDGS6i1DrRbAFbw4dCWyNpsnkeaOA6M8t6MO2ZeCRRwcRpKBLEy0L8nHheP410HonoGi5ibwiCJVk+7Zf5Jf84nCFF2Zr4sOBWJ5wtZnF89l6BJY6gF7KFvhP2QvLykW1Z58jkq3o+k4rdUpDdr9v+J73IXtSvwN38kfwJ5vbf21p8oOC85Hf8mKOVQ7fvgd8Nc6F2B37AwyZ/JkAemy21M3qtubqIARrv03FGvXW4RicWmCBnGae5kqSAtD5mfgsvX3MTVdPEKvIbmHIvLzy6QWOoXRKRddhhqB/C/rLyHkdgZHa3+x9lSGouMrJiB0ucvlKd7azJ3XVx+KbpGvTLc1CR5ZyPlSWb6ybVFKEzX2jlqYmVumgjVIh1FoMt5aeCOUL5rhy8KrU8X6jcdBnBfHkAQTfH8BpJkVNT7kJaNIKSkY/5v2TqF1E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734c2e41-fbd7-4edc-4aeb-08dc80bb7f69
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 15:16:36.6008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3I6K8oFJB7BqIzuREXQTb34ZegzG9xEf3TCcLFnjobCUBqI7KaD4bZDl7tiu2/OFlViEZ2/Bo7f1Llo0XD5WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_11,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405300115
X-Proofpoint-ORIG-GUID: dD-ykT6vi3GgWdTKnwbHj-W9LGAUaJV3
X-Proofpoint-GUID: dD-ykT6vi3GgWdTKnwbHj-W9LGAUaJV3

On Thu, May 30, 2024 at 09:51:02AM -0400, Benjamin Coddington wrote:
> On 23 May 2024, at 4:47, Chen Hanxiao wrote:
> 
> > don't return 0 if snd_buf->len really greater than snd_buf->buflen
> >
> > Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> 
> Fixes: 0c77668ddb4e ("SUNRPC: Introduce trace points in rpc_auth_gss.ko")
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
> 
> more below ..
> 
> 
> > ---
> >  net/sunrpc/auth_gss/auth_gss.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
> > index c7af0220f82f..369310909fc9 100644
> > --- a/net/sunrpc/auth_gss/auth_gss.c
> > +++ b/net/sunrpc/auth_gss/auth_gss.c
> > @@ -1875,8 +1875,10 @@ gss_wrap_req_priv(struct rpc_cred *cred, struct gss_cl_ctx *ctx,
> >  	offset = (u8 *)p - (u8 *)snd_buf->head[0].iov_base;
> >  	maj_stat = gss_wrap(ctx->gc_gss_ctx, offset, snd_buf, inpages);
> >  	/* slack space should prevent this ever happening: */
> > -	if (unlikely(snd_buf->len > snd_buf->buflen))
> > +	if (unlikely(snd_buf->len > snd_buf->buflen)) {
> > +		status = -EIO;
> >  		goto wrap_failed;
> 
> Maybe Chuck intended to jump to bad_wrap in 0c77668ddb4e?

bad_wrap is specifically for reporting a GSS failure, so "goto
wrap_failed;" is correct.

The bug here is that the earlier alloc_enc_pages() call clobbers the
default value of @status.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> Interesting that
> you found this considering "slack space should prevent this ever happening".

That suggests that the slack space computation is somehow wrong,
which might be possible for one of the new enctypes..? Further
investigation is warranted.


-- 
Chuck Lever

