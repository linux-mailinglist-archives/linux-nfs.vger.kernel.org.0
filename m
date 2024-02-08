Return-Path: <linux-nfs+bounces-1865-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64A184EA1E
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 22:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3591F3009F
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 21:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728D348799;
	Thu,  8 Feb 2024 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SVuCSXxO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0SdBZlNg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A54F1E7
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707426652; cv=fail; b=gq4WqyhUu6LGzIR7VG+XBB43xH5pkSL27HsPKLVkF/yGySas08Hd9FaEOxQuvEm431UzmtsbPmXmP/i9Q4e5KJa9UOAZIIbMOh/kJyzGnSfKXnPxlKJVylrQEQTVjruFMoQeBy1hrrm6eyUETK/WV6cQQj+RmQ+t28DNC9luO8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707426652; c=relaxed/simple;
	bh=8vTrIe4OJ3RjLaxolgnmBDyuCY5VrQQPYDmRWdCbJ4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HdHQGK3/BtAFb5Bye3m0LPYVvsAsAq9KsxhBmB73w1xN4WIsQ3v5uGSRMRdLC7Qy1NeIF20e60fHH3Jsjr1Z+j4ndecKrAQpQ7ExHa1hKtRtK7tHqH2fzTjhEy0CXQPev7kghOd+yfQ6yHs6dIDIOjZUv+TGXuQ2gSoFB68+ycQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SVuCSXxO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0SdBZlNg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418KxB0o011950;
	Thu, 8 Feb 2024 21:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8vTrIe4OJ3RjLaxolgnmBDyuCY5VrQQPYDmRWdCbJ4Q=;
 b=SVuCSXxOhtZsW6hvKXWwW66mW6LlR8XpXSie7rgOxNdKrgTEH1MrY0k7k+TBFxOuh2Sf
 PM/RnlznkxyuQt9+e6YUz6t6xBTxS09mmVzBuz7nhpexby7GOgoNxf7MTOb8OcPCGUHM
 Vs25xKeuqGHhixUYY3ov0/g3I9EygbvD+OQ4bfP/5G351sYL/dTPYNAj1LiQaLPQLW3U
 raLsYKwtKVztgmkrlzbokRVy6Jd09zjAdKiqaV8A31CuY+5LIM0KRzrL12nAfpSYIgEB
 ewmcArnFca+sKj7Ikg2ILdHTaQM7mYrWJbszM9Y3+a60HqG8z6Thme8sH8xW64Kt8glk oA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1bwewpfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 21:10:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418KAjfJ038305;
	Thu, 8 Feb 2024 21:10:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxb8qmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 21:10:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fx1Wj29TxtoMAOn/5X1ebGeJo6MY+Oi+GfcrPABdSp5G/ClnwvE23zPKf/B5Jm3AObs5OMWQjrwmQPoIkANWAJ1jZHvWAqIxbMFlPk2EyQEPeq3fPOqow94b9ozS+o8v2cODr5YEDsYdjtRMIRFcIN0dFS0BWwWthv5NjrBlelcApdwqZFAaDtwLAniqy0b5/6BlQ+73jLpIBG81+1C0pyzGh4g6gUyOdyJf+TQ28arW+Ra0/uJlSNGCaXWk2LQuk1ZsLJHHu0IJ7ld9DM2xfOPL93NrZ3piJ9YVF6zz7xwICPhChlqCFT9s0zadWQkGeHWUXl0BxtngESrW+Vwiow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vTrIe4OJ3RjLaxolgnmBDyuCY5VrQQPYDmRWdCbJ4Q=;
 b=D3gFn0IyqUoe08r1yMuMIsC28lSXd+EUphojYQ3dYE4wWe4hlGUp5CsVpPgRcJSo2Ft+Eh49w7tgFR+qz6fSDdMFyWeLSOgIOniCRZRjgpcor9cPJXBEVfygtt109dl0ebxAVtWxpLxC5XV88YB2zUJFYkZ5RS5ASuJ7lVh0sV71Dh+ZOET7IwKjT2TNh5brAeoecTV9yEJX/j74XiKsOsWLLeR5EJnmjpTvi5k3eanU2vDMcpEldzrJBIvK19ZUgkXzl64+YRwborTEov36oZH989k9nXOB8H+0BztCYgzxaeviKn8t4L1GOiKXDg5qJSkqFCjWVzpt4F3b25/qgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vTrIe4OJ3RjLaxolgnmBDyuCY5VrQQPYDmRWdCbJ4Q=;
 b=0SdBZlNg3GM8mXJQfbHaxnDmBXKYJm60AbnPbUPrson40pNDhw9OMm2IXrmrir4mSBp89HLWxGhAgpps5sRsEwcTxqKoOxSEwr7LgfZO7MqP3J8jP4PYNGVcaxoi+YWcAlgsf9XFQs9VNzciJLc1bgrBSJjDbmGNyxHR/V/sN6k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4629.namprd10.prod.outlook.com (2603:10b6:510:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 21:10:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.037; Thu, 8 Feb 2024
 21:10:43 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Charles Hedrick <hedrick@rutgers.edu>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: apparent scaling problem with delegations
Thread-Topic: apparent scaling problem with delegations
Thread-Index: AQHaWstcr/sBhJW1c0inPGg6Tk9HQbEA8OqA
Date: Thu, 8 Feb 2024 21:10:43 +0000
Message-ID: <1AF9A62E-55BE-4A08-95D6-26784218C940@oracle.com>
References: 
 <PH0PR14MB5493F59229B802B871407F9CAA442@PH0PR14MB5493.namprd14.prod.outlook.com>
In-Reply-To: 
 <PH0PR14MB5493F59229B802B871407F9CAA442@PH0PR14MB5493.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4629:EE_
x-ms-office365-filtering-correlation-id: 9c79380f-7403-4723-c36e-08dc28ea6967
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OclrhAedZNKHJhGTWbeiNgZWbNEEFboK9NUpbie3LFRgkESNJ7HfphdWHnQThBcIkVdlG+IRfheB70DLhz7uZ+C0gHn//Ii3okrsWlvxTQ8Goa5aKZTIxN+nYDdXOL4qj32iyj3F0ipvXea68sHQEm7mAASiXfH8cV/8r2CRJvXMpTJhCv07F24vzI8RMr9AydGFwZHvz48IiqJW/QAFV1gL3k+mj8yrJR/dDoujPtAT8ZWxdIJTDD0u3b/JhSJ6tUDTUsnBLiwC/iJyURj9XONk5psQNK36n4z3FdBV6ytbM7WjaSnk2YCwUvX78biboeYvx9wKuGqGicUklo2iFv8GioKld8p5PZNXX0I3bgAiowG42paXuvqDtnUKVN3t9NCVACH/DUiXWMhsLJMzhPIHaQ/P2CSOMjluH1jPOhNdCkuyFb7QjbJ6k+wHR6hWAWVh1SSFpnVi/ZvWDlqtJXP6DplL3aRSZIY8Utayzo1mlgruws2Xh+FrIpwYGMuvJ/XrSJV4TDKVhC5Oqrz06OWDM+9Sek84EBoBKN8lErn73CMDIwoapfxLS2cBidNfVacvHlZ//g6gWhOrDvJS6oFUJlC4sAa2/6nx1TmHPjiWkSBWbUSg9w8NQVpldoxa
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(5660300002)(41300700001)(83380400001)(38100700002)(26005)(86362001)(122000001)(2616005)(66446008)(316002)(53546011)(66476007)(6916009)(33656002)(71200400001)(6506007)(478600001)(36756003)(66556008)(64756008)(66946007)(76116006)(6486002)(6512007)(8936002)(8676002)(38070700009)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?a3kzQjc0aFZpTytqV1NOOHo1WGUwVnJMcnVJSTc4aFhDbkVzRXN6aFRBdDFE?=
 =?utf-8?B?Q0tqTmp1V0UxQjN4MVRFY0VtNlRNNlRuZFBTU1RjUGplSXp5QysxajNwNkds?=
 =?utf-8?B?RWY1OU95dXFMSU1KaGwxbldvUnJnR24zd295OG5EUzZRWVk3UTFOUnhYVFkz?=
 =?utf-8?B?bzBDemFrWTBIUW1YWE5VSVBjSnBhQlV1Qm02NlZpUGhRM2VpVlUrWXpGWmdx?=
 =?utf-8?B?YUFvVlpnWDMxdHc2TTk0dUJmaGJYUTZDRVhwU2RzSU5HVGRiYW9nWm9WZUZ4?=
 =?utf-8?B?KzBlVGpxME1teWRPbGIrN3A5RU13Vlk0c2RSWk9KRENuZHUvMGhkMkpIMVg1?=
 =?utf-8?B?N2JEeFNyWWF5UmdzZGVMRW42NnlMbXlkdW96REY2anBkT1VLbVY5TGkrWlBk?=
 =?utf-8?B?K0NEYlBtalN2SmRDSDlIUE9kWHI4b1d5bnYvbkRBMjMvQ004VFlWRk5xZlVE?=
 =?utf-8?B?YkVwVWpUblZZV3pFc29VajdiR2lTd2NJQXVBbzlqdWtwTHdnNkFHY3kzZnlO?=
 =?utf-8?B?N1A0Q2U5M25qY29BakRDdTBFSFNscGJqQVRxWWJYNC9nd1FRQldBYjhla3Ja?=
 =?utf-8?B?UFZERFkwT0FkUXl0RWYxYlBZSS91NHBtZ1cxMWZ1dWZLTlIrekN3SSswTGht?=
 =?utf-8?B?eTVEeGhxU29ZazZaZUVMUzJTODBjbG9xRm8zbTA2MmxqMURzRURKdGg5NDhS?=
 =?utf-8?B?ZjljWjRES2JnTnZtSDBTSUlWMEJ5RVdoanhjUmJPY3FYaS8ybU1GV3hxVFpL?=
 =?utf-8?B?WndBanFUUllHU2RRN3pJbmswRmRleXJGWkR1bE53MmdkQm03VEJjQXJQbEJU?=
 =?utf-8?B?WXRENW1MODhXbXdnVE1JbFJUZGVMZ3FSTzdQWnMrcys1TFNMS3VzbWJDdnBz?=
 =?utf-8?B?Z3JiQlIwbXNhQUVpMjNVY2VCQkVkUm1ld1RNM1ZxcXRUMkNLY0xBVkZsaGh1?=
 =?utf-8?B?Sjh4ODJENW4xUzRmQU0zcTFoM3dNQzlYRWhQOEJwSEJsMzBYU1ppRDNqTExX?=
 =?utf-8?B?VHlWdDQwYVZZNHFCNCtUWjUyeWgzZUJnUGppVFp1ZXVUUE1sTHp1UG9veDZN?=
 =?utf-8?B?UEtpUk5sNElqbVhXODhTUnlxK2FHSWxyNFBacTRjN2gyZHdFOVpobUpCMkVR?=
 =?utf-8?B?QTR4N3JDNVVrQXJ1aHpNY3I4SFpDVTZRRUIzcU1lSVFtcmlNTHFPa1pwRXdk?=
 =?utf-8?B?V25vQVVxc1Y1OXMwTmlpMnZpdUFET01Za1VRVlFzT3I1SGV6ZUl4MzRjT04w?=
 =?utf-8?B?VUVkN0JuR084QTVjbmlrTm1qc2ZJSVBGMDFZbGl6d0FCU2JiR2NFUlRQYmUw?=
 =?utf-8?B?bExHOFlQbFVIVTFHalRkS2JZcGIyQzl0U3dSQnpIN0xrNE45V3ZPY0hEd2hJ?=
 =?utf-8?B?NWlMKzdWdHZ5c0UzcDBybHBjYnZEam9GK3VpMXZ1SUhJWm5SaDNsbzZjOE5y?=
 =?utf-8?B?RDRyZGxQUzZCUHRIdjY3YTAvckV6UXdnZEZZNmlxUXNsNjBRREE4OWwwWnVq?=
 =?utf-8?B?MnQ5TUlPTldWZytFREZWNWJDTi9rcGdJZDIzYUxFZzlsT0hsb2p0cnJWcjNW?=
 =?utf-8?B?VjRPZkpjejBRMzNndDRJTzFPREc5cVYzMDNxcHNucjlSc2gwdW9MV1pJMDlE?=
 =?utf-8?B?RzZlK1ZVbmN0RzlWcG54dDRWTm15WVBhdzYxdHV2WWs2RFY4aDFUSTZlUnIz?=
 =?utf-8?B?SGRTWmd6Q0pxV09LK2xQdW8xRVVYT2U5YkVWTXVGQjJwTGROUlpkeDJSaG9O?=
 =?utf-8?B?cUJNMUpxUHBQRkFEd0lwZ1UvSDBpdmFRMnZBQ1E0bldmNjFYd0hmRGdSWEsx?=
 =?utf-8?B?aHlUV3k3S29ZbnU1OGhQVEdqZnhsOEpxU3FwYTFCUy9vY1l0M0U4N0JxUXFJ?=
 =?utf-8?B?ejdxdVMrLzlORC9VRkhjOVhwMWlqV3hzNUQrVS9jc2pHSTBwTjl2c1VmUHNz?=
 =?utf-8?B?SU9pOEZZWmVJRlRkaDNVU2dPQWlDRmJkWEhCVExjb1Iyb2pnN1YxcHBaeU9F?=
 =?utf-8?B?WWFTaEFFUWQvRTBoWmlsQ3hEM3YzRFJNdE1FelhSZlZyVUVkaDJRVU1NWEZW?=
 =?utf-8?B?eE9Ealo1MSs3VnZhWGxOOG52cHp2SXhUTi9pNnRPK1ZML1R1ZVppNmorcFRo?=
 =?utf-8?B?alBScUVqaG9RT2drV2xNSXZSdjFkYytnN21MN2JsdndZNThWOWZYdlRFZmFo?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <747F6FBDB37A32448E034D7B897FB2EE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4Z2OeUZ1SwiLZNK1v/coXRuduNf9hWj7xUJT8QEaLBKWLGjKMemRR2C3/5k1ss4YOZI1+QDBDJYcvQkHTjGzkqUEJXbVkYe+SQAYk6Z8froovpnUgrHySw5+Ws1/yhnGmq6E1jPjlhduclXsJZtcD3/tYt9RPKCMINdqrsrLu88vTkW/YD77sK+pFgPjOY6/A030UMB+obJRS6bmmxAAt9fOl+dndZRNbHgQrLtpUzOtalPOEXbaaQA8cCbKMVCJfrqMwZJr/CnD/4LxvTPI69mokl/ndym/U8LStR7SZG92A74hO++2Gx9iEr1ihxNEmNVgHctrd89PNNJxJRRlS7JMyyUmcI9VOKfkiucJtoFP5j1X0zLsBr6dyqthV22f30tgz6MG8ONVuCRAGNg3CLd+2kCN5BisUOIisroeGJy1CisGDZUbBptmLjTGUffCU8EpG8OidPwR1uyjLWKUIQZRj9bWVnf4GSdcqUdNl3rxySJjmPbvSHA/TGccymcGdYB990MB6lv5FHbSV0kpTwKQ3d7CUEelOFIz2l37D+Gg30LhsqPpxJD5cCL17jTTVTMGSemzpDpVts2LnA3x/OhLWfVNOIl2JVhZ1UKFUfQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c79380f-7403-4723-c36e-08dc28ea6967
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 21:10:43.5027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qou7t3Xr+rg0H2qUww0pVWubjJgCOB/qI4se5SykqCHRsNu8DD6aE7d+9bmQdvId/BpdfmPfy1yVBvhsubcrVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080115
X-Proofpoint-ORIG-GUID: T40oZGSpKWm7IbdRMMajEV5SMYF6xEn8
X-Proofpoint-GUID: T40oZGSpKWm7IbdRMMajEV5SMYF6xEn8

DQoNCj4gT24gRmViIDgsIDIwMjQsIGF0IDM6MjbigK9QTSwgQ2hhcmxlcyBIZWRyaWNrIDxoZWRy
aWNrQHJ1dGdlcnMuZWR1PiB3cm90ZToNCj4gDQo+IFdlIGp1c3QgdHVybmVkIGRlbGVnYXRpb25z
IG9uIGZvciB0d28gYmlnIE5GUyBzZXJ2ZXJzLiBPbmUgY2hhcmFjdGVyaXN0aWMgb2Ygb3VyIHNp
dGUgaXMgdGhhdCB3ZSBoYXZlIGxvdHMgb2Ygc21hbGwgZmlsZXMgYW5kIGxvdHMgb2YgZmlsZXMg
b3Blbi4NCj4gDQo+IE9uIG9uZSBzZXJ2ZXIsIENQVSBpbiBzeXN0ZW0gc3RhdGUgd2VudCB0byAz
MCUsIGFuZCBORlMgcGVyZm9ybWFuY2UgZ3JvdW5kIHRvIGEgaGFsdC4gV2hlbiBJIGRpc2FibGVk
IGRlbGVnYXRpb25zIGl0IGNhbWUgYmFjay4gVGhlIG90aGVyIHNlcnZlciB3YXMgc2hvd2luZyBo
aWdoIENQVSBvbiBuZnNkLCBidXQgbm90IGVub3VnaCB0byBkaXNhYmxlIHRoZSBzZXJ2ZXIsIHNv
IEkgbG9va2VkIGFyb3VuZC4gVGhlIHNlcnZlciB3aGVyZSBkZWxlZ2F0aW9ucyBhcmUgc3RpbGwg
b24gaXMgc3BlbmRpbmcgbW9zdCBvZiBpdHMgdGltZSBpbiBuZnNkX2ZpbGVfbHJ1X2NiLiBUaGF0
J3Mgbm90IHRoZSBjYXNlIHdpdGggdGhlIHNlcnZlciB3aGVyZSB3ZSd2ZSBkaXNhYmxlZCBkZWxl
Z2F0aW9ucy4gSGVyZSdzIGEgdHlwaWNhbCBwZXJmIHRvcA0KPiANCj4gT3ZlcmhlYWQgIFNoYXJl
ZCBPYmplY3QgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTeW1ib2wNCj4gICA0NC44
NyUgIFtrZXJuZWxdICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBba10gX19s
aXN0X2xydV93YWxrX29uZSANCj4gICAxMy4xOCUgIFtrZXJuZWxdICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBba10gbmF0aXZlX3F1ZXVlZF9zcGluX2xvY2tfc2xvd3BhdGgu
cGFydC4wICANCj4gICAgNy4yNCUgIFtrZXJuZWxdICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBba10gbmZzZF9maWxlX2xydV9jYg0KPiAgICAyLjYxJSAgW2tlcm5lbF0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtrXSBzaGExX3RyYW5zZm9ybQ0KPiAg
ICAwLjk5JSAgW2tlcm5lbF0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtr
XSBfX2NyeXB0b19hbGdfbG9va3VwDQo+ICAgIDAuOTUlICBba2VybmVsXSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgW2tdIF9yYXdfc3Bpbl9sb2NrDQo+ICAgIDAuODklICBb
a2VybmVsXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2tdIG1lbWNweV9l
cm1zDQo+ICAgIDAuNzclICBba2VybmVsXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgW2tdIG11dGV4X2xvY2sgIA0KPiAgICAwLjY1JSAgW2tlcm5lbF0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFtrXSBzdmNfdGNwX3JlY3Zmcm9tICAgIA0KPiANCj4g
SSBsb29rZWQgYXQgdGhlIGNvZGUuIEknbSBub3QgY2xlYXIgd2hldGhlciB0aGVyZSdzIGEgcHJv
YmxlbSB3aXRoIEdDJ2luZyB0aGUgZW50cmllcywgb3IgaXQncyBqdXN0IGJlaW5nIGNhbGxlZCB0
b28gb2Z0ZW4gKG1heWJlIGEgdGFibGUgaXMgdG9vIHNtYWxsPykNCj4gDQo+IFdoZW4gSSBkaXNh
YmxlZCBkZWxlZ2F0aW9ucywgaXQgaW1tZWRpYXRlbHkgc3RvcHBlZCBzcGVuZGluZyBhbGwgdGhh
dCB0aW1lIGluIG5mc2RfZmlsZV9scnVfY2IuIFRoZSBudW1iZXIgb2YgZGVsZWdhdGlvbnMgc3Rh
cnRpbmcgZ29pbmcgZG93biBzbG93bHkuIEkgc3VzcGVjdCBvdXIgc3lzdGVtIG5lZWRzIGEgbG90
IG1vcmUgZGVsZWdhdGlvbnMgdGhhbiB0aGUgbWF4aW11bSB0YWJsZSBzaXplLCBhbmQgaXQncyB0
aHJhc2hpbmcuIFRoZSBzaXplcyB3ZXJlIGFib3V0IDQwLDAwMCBhbmQgDQo+IDYwLDAwMCBvbiB0
aGUgdHdvIG1hY2hpbmVzLiAgU3lzdGVtcyBhcmUgMzg0IEcgYW5kIDc2OCBHLCByZXNwZWN0aXZl
bHkuIFRoZSBtYXhpbXVtIG51bWJlciBvZiBkZWxlZ2F0aW9ucyBpcyBzbWFsbGVyIHRoYW4gSSB3
b3VsZCBoYXZlIGV4cGVjdGVkIGJhc2VkIG9uIGNvbW1lbnRzIGluIHRoZSBjb2RlLg0KDQpXaGVu
IHJlcG9ydGluZyBzdWNoIHByb2JsZW1zLCBwbGVhc2UgaW5jbHVkZSB0aGUga2VybmVsIHZlcnNp
b24NCm9uIHlvdXIgTkZTIHNlcnZlcnMuIFNvbWUgbGF0ZSA1Lngga2VybmVscyBoYXZlIGtub3du
IHByb2JsZW1zDQp3aXRoIHRoZSBORlNEIGZpbGUgY2FjaGUuDQoNCg0KLS0NCkNodWNrIExldmVy
DQoNCg0K

