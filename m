Return-Path: <linux-nfs+bounces-4637-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9B7928A0E
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 15:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED7E1C2246A
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 13:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E1114AD29;
	Fri,  5 Jul 2024 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kSMUBpda";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YwqzIDgL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70201DFF0
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jul 2024 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187123; cv=fail; b=sKBqNaazrtVRI+tjVf8tpF8w97FR9WF1l2XQKbveGLSA9ckyOlcqPTcV1M0AkUFYX7Dl0Hxa4/2O4wLzNTfWNs8ZmzL+cnO/aDAHsqVml8TMMSDqrisuRy8V9unEeCINBGzSMW3s78Ejc6BzwB6FMbvzgsUcaLS0McUIxXJyAGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187123; c=relaxed/simple;
	bh=Hg62Mh9bzDyXxQoXXI7rxIF2IJP6eVorjmkYduXNpY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W9R9Poen8qnFnz8mmhU4z9S+2eBMonQlbnTKp4amL1OotGqwusevwxLLGbaKxVSnPXK6xnjJ+8nyzQ0qSI4JMBKFUrDNN3W125j5a5I7yfiYcmV9gepCp6jIWI+EQoF2rgcmEX0nWUMD7x1WBPzi3FAvn9Ee1smuKToyRJTTBsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kSMUBpda; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YwqzIDgL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465CtUPK017675;
	Fri, 5 Jul 2024 13:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=Hg62Mh9bzDyXxQoXXI7rxIF2IJP6eVorjmkYduXNp
	Y4=; b=kSMUBpdaC+DM6QxVSc3xOMRGOlA1u8AJN9/DgkG2qRSaa7PD6rXIWE7p6
	XBgDgv40aHC0pH5YyJhDKwl6pUK9l6X9MqhSrUp2b0aMv/acRiuWP3Uim5egRfzm
	q9QoiSu/NFB88ByWUpiQiiUqPiSdRfalxW3qD+CpVLKhBzkGSMfqLgRhnnuIH/CZ
	6GFn4P7AinNedMhzJkAgYH9Ets0/JFL1R0tpitmPkeNV5JK6DMTnSXN0L7AKgIoz
	hDUO2+0+Lna1kp1fuRvMurOnWP5VbgD790lxy3kdAhWZxx1WexcH6hUJPCHZLSCd
	QkXBNrzi7bNH42Vlt+PRAhn0ObbPw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a59bpvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 13:45:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465DU91o021462;
	Fri, 5 Jul 2024 13:45:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qhfqw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 13:45:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHlYHGaILmBHtsPen1xzDA9pJDeYthxORZHegC4phnfCj2rNKFnTehOV+ZZjc2eXTpAF7UKAne3/as7tzHw6AemM/IM6uaKTzbyfrnd2+FMR8bZTA7jj2wHWV3nd5LHJcZdlUGt/BowTJ+VP/M8k7+VybWP9rlBTNQ86QF6Kfi0ldKXI7Wk1PKI8/jpXSfXkZd9tpe7mRolGGxUZLq4fYmTqFBORBshloCvackCUs5uTAKS7mp9pv2SyVvxYpAA0h22CVjZMfmgsqoPkJtZdYqKqUcr8i2gy8IHwD7cToJc+o7sBdXiO5/JaH2k5NOjxc9BXr5slllSObj404deFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hg62Mh9bzDyXxQoXXI7rxIF2IJP6eVorjmkYduXNpY4=;
 b=IkLZ1DL2TkKD6pDYqR7XoMt/CUnybrM3gLfWnZkBL7df1bImfA+UHZ7914Ba8S1SMiD+tuRTsQcZIFuEiFbWxJDdCpSLnEwL8Tkb5HG0YC0NBH9fcivdfo8z6ehxvBmqj5Tc4Dyp3iWBo06AKhedhZyvtXEdZ1/BpFPRy3RbYh/abCfYAqXqSM7zl0fcQ2JXLKi1o58RZPNlhMSQZz92riFc6L7MTmkTe4mamkPm2FVTDYTJ/mYGvD+zHpBf7XbVuFTxGWBlBm/VFRoOwVeNpM8Lb0K5x9+OUiMA+ks0EX0BQnP/dLepwEOc1/OMw08k/h8KDL+YhLIdNwH8Xys4Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg62Mh9bzDyXxQoXXI7rxIF2IJP6eVorjmkYduXNpY4=;
 b=YwqzIDgL3/7zbBSPdAgDBkkXIsS9Q9+U7ILEkhPp3rJpV3TxGM5qlenWJ1PPnU4S/T6IlnF7vhbDgKp1BYKojMb9b2TcW9LoQcMQmOi0XO2E0bNdxD6vO/8m4Pm0GC/S+Tv0H5ot3fgBgs3ZL3JQnDdmPDKD9nrP58PxvCqZkII=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4138.namprd10.prod.outlook.com (2603:10b6:5:218::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 13:45:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 13:45:11 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: David Wysochanski <dwysocha@redhat.com>,
        Dave Wysochanski
	<wysochanski@pobox.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Christoph Hellwig
	<hch@infradead.org>
Subject: Re: BUG in nfs_read_folio() when tracing is enabled
Thread-Topic: BUG in nfs_read_folio() when tracing is enabled
Thread-Index: AQHawomlHGP4JoBiP0qrNn07fsoVObHkAGuAgAAE3gCAAAS7AIAAfxOAgAO05QA=
Date: Fri, 5 Jul 2024 13:45:11 +0000
Message-ID: <FF24B77F-638E-4F31-ABB6-B07D48AF73B4@oracle.com>
References: <C225EF84-ED3A-435F-B90D-7A5EF6AC8430@oracle.com>
 <CALF+zOkKf=5YcSZg6OyYHFzTqL3Fktzch95PQ9UOB0SDzqFZgg@mail.gmail.com>
 <DA939E32-2E25-4EDE-BC25-2D5E50F4B711@oracle.com>
 <CALF+zOkwYrZcen=xat9nQ_EhOcfRFdLji56nrXsqWh4w_3RAHg@mail.gmail.com>
 <ZoTc3-Bzfr-gY4-o@infradead.org>
In-Reply-To: <ZoTc3-Bzfr-gY4-o@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4138:EE_
x-ms-office365-filtering-correlation-id: 39cd09f2-09b8-4d51-dc7f-08dc9cf8b0cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NmI2OGhsQTRobWJXa0ZER2pVSjl4ZnNuVG8yZ21PWTZWUllHVzZuTnhMTGd4?=
 =?utf-8?B?L25uSlcvVWVLVmFYck1md2hzZ0NnYzBaWm45eFovUzJjRjkxMnN0bkJrMVFv?=
 =?utf-8?B?dHBJWU9hMmZzODR6USszOEZteGgrVCtRRERyekRkcGxTeFhadDV3d2syaGgw?=
 =?utf-8?B?S09hTDRFc2owK05ZaU1QL09WUSs1a1RxUFRVTzQ4QXV2R3p6b0hQL0VoKzdE?=
 =?utf-8?B?a0pkWTg1RzVZNXNKSFJoL3dNL3h4d1o5OW1veG9sSGVzMmFyb0h0cGcyYW5r?=
 =?utf-8?B?M1JnTDhqb0s0RVBBV3l0bFNrYVhFNE9mMVRZbFlRRHhFZERkcmI2WWJtdjRD?=
 =?utf-8?B?NldhNThFZEluQkZNTlNCTU43UXdMZmo3eHNRSnRWM1BoRk1Jd2tWUHF5OVla?=
 =?utf-8?B?RkVqdkJiT2t4dk4wWG9SM1Q3TzAya3ZaUXo3VkY3cWFKMlg0WGI4QnlsYmtD?=
 =?utf-8?B?Wk5vMDhRSVoyeDJrd2o5ZXF3YWFyQ1pBOGR5UllaenkxOGlOWkFOcnNpMjYv?=
 =?utf-8?B?YnJXaXFqUnc4TkxwLzIzazV5ZGRWSzhWUGZ3eFV3QWt4N3MvT2xYZ28xZlZ2?=
 =?utf-8?B?Z2l0djEwNldXOUh3ZWk5cElIaWRtcFpvT2x3cVhjMnErRWNRcTUzNkVncU9j?=
 =?utf-8?B?U2pOMzcvemRyRDF4M0dCSlZnK2xySHRBSzlNRkpLdjBIMlJIczNmQmxqeVV6?=
 =?utf-8?B?OTVkTkF3KzNGRVR4SEFia29GU05NckE2WXVYOUtUbCtUTnh2bVJ2RnpUM0NM?=
 =?utf-8?B?MFBHamViNnp0Mzc3endXRUIvYVY5NlNsd2J2Q2t0NnZGQU8xRmVmeUdPOUts?=
 =?utf-8?B?c2RWamQ1K2NjZXdQY2xicGgvanlKYU9OLy9PRG0vNXZSalk1NzlCTXZhcVow?=
 =?utf-8?B?M2s5SjBLRTVZeUREZFZJQjlLTnFkbk9adGJzWThHZ3RMVmVWSXAyR1hCUWdP?=
 =?utf-8?B?bHJjQjAzQUlCQkRuQTBQTWxOOUcyNjk2M0xtc3NHSytYYytoSkVVU1h5OGhT?=
 =?utf-8?B?bmJJM2RQRWFwcGNWQ0hDTVBhbzBnL0lYRGJUc2orK3VkNmNJZWVYeDNPdmVG?=
 =?utf-8?B?bHdrWTRnRWpVYTRBQVZCaGFQMzlBREQzU2lOZnFXN3BScmhGNUJNQ2NUYzdE?=
 =?utf-8?B?TitTTXZocldUaUVjYnBVZldJUmNmVnZ5RUF2MGhEM056VjRTKzFOMkthais2?=
 =?utf-8?B?blhRYmpJOE85blEwQ3VNbFphVGhOZEY0bWdFSlVCVFowVHJaUGVCaWE2NlEx?=
 =?utf-8?B?UEpZQXV6VTFJUVdBTUEvQ2loaDV1MS9vVTFRdEMwQytJSU1YTk9lM3NDcnB6?=
 =?utf-8?B?bEFvVWpIK0Y3MjR0YUNyUEhCaFNJbjN4K0tDOG96TmlTU0JMRlpNbE5nSEor?=
 =?utf-8?B?bTh0VytZUnlNYUJFT3BXWmlEQkVzVzhuVktoWlZJZUVpOUs3ekhmMmowNjNv?=
 =?utf-8?B?ZVJhS09TWlhmQlVqZWRJTjR5ODUxNUFoVFkyVDdvMml4MnRvYzhGMUcrUEtq?=
 =?utf-8?B?SHZTTFppSnZUdzRwUWt2VXdmVEVQaWlXSjBQengrSDMwdW5zeG4yN05wY3RD?=
 =?utf-8?B?SE80Y3VybkxCeHk1U3ltQmJ2ZTVrd0dRRlFPZ2VvZ0lkcmpvekRDYWRmd0Za?=
 =?utf-8?B?RnJRRDQrTk12a2xNbGIyb05RK2NYdDhEZHJPZVFpK1FRb2prMmYwRVRXZ3JG?=
 =?utf-8?B?amhxQ1Nvb0lHS04yMW1oWnlBdHJSdjJqbkNiUUI1ZjFPWTFKYjZyZHlSRHRW?=
 =?utf-8?B?dkZyV2lRMEZiZXpwQ1RBVFZwYmFQTk1wUERYYjBBWU8wa1pMMVFtZlBtWExX?=
 =?utf-8?B?a1pPUkhGWnJ6RWtPczZJK1RrS0tCRlFMdnBFU0cvd2hlOThVbWJBMlNqNTY4?=
 =?utf-8?B?blVZVlk2aUp1V1FtT0JvWXVHY0lZNlZOU3RhL1NwNVB0VlE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OGVlLzg3NW5TNHZqeERyMUdWcmllc2NPKzNuM29NbGtRRmUzQ3ZzS2RySVZ2?=
 =?utf-8?B?RU11YVJzbUFaUFNOSGY0UTd5QXh5Mmc3VzdleFZVcEF3ZS9ud3RkTjJGMnNj?=
 =?utf-8?B?WVdWbTBjUWR6TjhmQnJkRk0zUXU5djA5dDJPbTJHdHNEWDRKUGIyRGZBWFlO?=
 =?utf-8?B?SGttaUNlc3o3eHlCbU1ZL0I0RWFQVHRUbENnUjBFSWlNa1JjUU1sRTVUS25k?=
 =?utf-8?B?YlhjUURKM1M1MVptYkdQZ0d0TzJxSk9ZVUE3Q3VTbXc0Ykwvb1ZRRWlaaHJQ?=
 =?utf-8?B?K3pKYUZjcmR6TWFrQ3R6b3o2elN2U1FqZkMwcG5WbjF5dndlTmY5TkQ0Yjdq?=
 =?utf-8?B?QXNvSzJOdnFOcXdSbWtkUjJWZnlsTzNUUXExTi9BQzV4UnNFOEZIMVNtbUI5?=
 =?utf-8?B?T2o1TlJYeURRZjFzUjRFRUlVK09LQXNaVWpIR1JNUUVWanltdDAreW9qcTVG?=
 =?utf-8?B?M0U0TW91VXB5NGxDMHM1UitTMk0xQ050T05DeFFjdi9IYTJtcVllNEUyTDlP?=
 =?utf-8?B?ZnlZUFk3aEJ2VXVWQzhaanBubDF0cldDVXE3eFQzdWR0Vmp4dEkxa3VSaVdm?=
 =?utf-8?B?cTRIQ2tPcU1YM0pCZXpKbzhEbGdoaGxyTXpEVVRkKytuck9kclIvZ3oyM2VR?=
 =?utf-8?B?a2s1bjg1aTE0MTVoYkpOaVNNUm5yTlR3dXY2eWFGbWtTcG1KcUJZRU0yMEpu?=
 =?utf-8?B?QkQ2VTZYNzV4RjkvakMxNzdHOXQzNnRvbzl3aXRSZlNUOTB6WmZtUWlZcnRm?=
 =?utf-8?B?bzJ2K2R1VVJ3R3JZbTNVV0ZPM1gxZHVhUjV6SktwWG1MRUthWTNmcjBKeEpB?=
 =?utf-8?B?RGtJbmJLZW9hRXhrcGczLzhyRzhKTU5jWGhaOTVXSUdwTFpuSTR3bkk1SitF?=
 =?utf-8?B?Sk14NVNQNUkzMlY3TkVIMm9KckYra2x5SW5XTnlpRm1lenluR0tNRmxlWFdZ?=
 =?utf-8?B?aHNhYjgwM21ueU1oMjZYRmNLK2c0d0MrM2duQkZSQXVUMFMvaGNjSzQ0UlVo?=
 =?utf-8?B?MlZnNWE2ZzFlVkUyQW5GdFBWa0VvY3ZMRDRiczhuRDMvUUdnZ2xxSzM3Wm13?=
 =?utf-8?B?b2ZiTUQvMkU5OTZGTTI4aXBEQ3grdTQvY2Q0UHRGQVdTeFZrMXIwNkpob2NW?=
 =?utf-8?B?ZnVRRUZtZDlBc3BxZWQ2RmZ1TW5lSk9sbWlqNzFYMDFUNGtoOHNJQzJUbzkw?=
 =?utf-8?B?OGFoOGE2RkwvZmJwd2pvVHFTUGxzTDlQTmIrY2JHdG1Ndm5qVHBYbnNnSm1X?=
 =?utf-8?B?d1E3ditrZDR0eTlPdjR5WUoyVTN4VWNSMm04a1QyUEdmcldrcjd5UzQ1Z2h6?=
 =?utf-8?B?RXRnRndBeUsySCtQR2JSOCt1aU9YTUFBakdkOUc4cTBhNlhkTkRDZ0tHaHVY?=
 =?utf-8?B?cW1zZW1seHVTdTFwV1RuOVZFZzc5b2M4enZxL0VMc0Y2NTNCZ09Ud1kvSWdD?=
 =?utf-8?B?aWhBWXhSK09JRWZ5UmkxQ2puU1FPMHBCOEVzNVVkcnF5Z2hOTENMcTB2Rkh1?=
 =?utf-8?B?WXl0cHBJSDRoRk4wV3dQTXVLM2pVR0VNcllnUkxZL3h1TlQ1a0QwcTFlVUxh?=
 =?utf-8?B?R3BOUUZOWFNDVktoTGpBZkpxcjZVUHUxZkFXV2gwaG42Q1NwelpRdEdFZ3Bm?=
 =?utf-8?B?TWRnZExtblBGTXZFVVdDUTQzWUhDUlA1b2cxZFE3YnVUaU9RNUc0RTFHcnZD?=
 =?utf-8?B?YWZTVHdsTGdTaEVUTFBJOXRxS3NHQytjT3ZWL1VRWkMzNFFSV2R5WFc5S3Bl?=
 =?utf-8?B?anY3ZnNmd0hNaURYSUdXRkdNREs5ejY5SkFoZGxhWHliT2RESnZLUWxhTkh3?=
 =?utf-8?B?Rkg5WnBqUHlxdFZNazVOVW9pdnJZWGN5SmRKTWtjWkVqbnhKeDdPWDNoZkxI?=
 =?utf-8?B?WlRTcUUweVNKbVJIaWVJVEFod2RDcUF4ZW9aWnpJOTlkQlVPeFRiUExiNE45?=
 =?utf-8?B?b0Q3ckNxSzJGWXFlRU1wcUxKbVJNUE1aL3lMeWQ4R3VBeW1FT3hZaFBBcGsr?=
 =?utf-8?B?b01nSFhwNk9QQXhCbWZ4aXlVR1krd3VXK1dOYWJrZ3BQMloxczI3aktMYzhR?=
 =?utf-8?B?amdLb3FsRmEwbVd2ZWhrYXc5NUtxQjJYdE5Ga1pQaDUrbk5OOGFkTGN4T2RF?=
 =?utf-8?B?NVBWM01DaFlORUpoMUN2RzhYZzJOaEFGd0xPb05vV2taK2xuZTJicHFHSTdx?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DD24E8EF171074A8220F5D69DE2CEB6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NwyshlZxjzXlp1eRnqUc741r9nLdKsKzk0WW7x03ff3lfBV/rqJP17RYlGiYkD0SG8BZD+RC+PvUQeM+3KdVRic85khQsZ5b9j5fIgp8aPHP/E77fwcLEpwB226tpVMKkTggMy10vKVE7jS4pciw5xaa1MJBjJl4I1/cqOEBs3J+aO/nkpbYTVTOU4FTb4pIOv0coMBqy5WNxD+K7hTM23QeVdg50o5plfn8zSwsGTvdXcR0YClbfUvMXpOwzU9ZtJqfV3VbBTj7x5dTnXZoPWRENxnzAFvHcQEMWzRUEQ8dDRSvYSEgcQPOD6JfYcy7C/u/vsDUcxTWslw0kRcpWgeihBa15JWUIyLfU8i7gTaiV6JwMyZxYL1415WmC1rhzcwoMy6otH+kmEsdccq/C+cfv6dVBJ2rrSuy0oyQh31Cvswun2j098ts00xadra3kVn+hC6vrLlwg0h3lzOo+roFXEcI6BLF+uXNXOqXoAZbf3koiC61njM/Ew1+ik/YmlZmx+kiV1w/kNJi2qCQC4erUzN1Dps0cVifAgbYIJlKInOiDINtS3iHTy84XFVcvj2KDtObS7SwOz3MyB1fomj4Kk+18mntH5qQxWSewxU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cd09f2-09b8-4d51-dc7f-08dc9cf8b0cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 13:45:11.1471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6llkoMjxrvBdeUMPAje3U/sEQV/Wk3v/12qJuBRHaP67L65BfgD+uoESM2WtHr5NYfADBNNqP64WO/QRm2G3aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4138
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050098
X-Proofpoint-GUID: ijV3iy3i9uS1PcdDEvRRl9TKeX_fiiFZ
X-Proofpoint-ORIG-GUID: ijV3iy3i9uS1PcdDEvRRl9TKeX_fiiFZ

DQoNCj4gT24gSnVsIDMsIDIwMjQsIGF0IDE6MDjigK9BTSwgQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBpbmZyYWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgSnVsIDAyLCAyMDI0IGF0IDA1
OjMzOjU4UE0gLTA0MDAsIERhdmlkIFd5c29jaGFuc2tpIHdyb3RlOg0KPiANCj4gW2Fubm95aW5n
IGZ1bGwgcXVvdGUgc25pcHBlZF0NCj4gDQo+PiBXYXMgeW91ciB0ZXN0IHJ1bm5pbmcgYm90aCBy
ZWFkcyBhbmQgdHJ1bmNhdGVzIG9uIHRoZSBzYW1lIGZpbGUgaW4gcGFyYWxsZWw/DQo+PiANCj4+
IE9uY2UgdGhlIHJlYWQgY29tcGxldGVzIEkgYmVsaWV2ZSB0aGUgcGFnZSBpcyB1bmxvY2tlZC4g
IFRoZW4gaWYNCj4+IHRydW5jYXRlcyBhcmUgcnVubmluZyBpbiBwYXJhbGxlbCwgdGhlbiBJIHRo
aW5rIHRoaXMgY2FuIGhhcHBlbg0KPj4gKGZvbGlvLT5tYXBwaW5nID0gTlVMTCBhcyBhIHJlc3Vs
dCBvZiB0cnVuY2F0ZSkuDQo+IA0KPiBZZXMsIGZvbGlvLT5tYXBwaW5nIGlzIG9ubHkgc3RhYmxl
IHdoZW4gdGhlIGZvbGlvIGlzIGxvY2tlZC4NCg0KU28gRGF2ZSwgSSBoYXZlbid0IHRlc3RlZCB0
aGUgcGF0Y2ggeW91IHBvc3RlZCBhIGNvdXBsZQ0KZGF5cyBhZ28sIGJlY2F1c2UgdGhlcmUgaGFz
bid0IGJlZW4gYSBjbGVhciBhbnN3ZXIgYWJvdXQNCndoZXRoZXIgbmZzX3JlYWRfZm9saW8oKSBu
ZWVkcyB0byBwcm90ZWN0IGl0c2VsZiBhZ2FpbnN0DQp0aGUgLT5tYXBwaW5nIGNoYW5naW5nLCBp
biB3aGljaCBjYXNlLCB0aGF0J3MgcHJvYmFibHkNCmEgYmV0dGVyIGZpeC4NCg0KDQotLQ0KQ2h1
Y2sgTGV2ZXINCg0KDQo=

