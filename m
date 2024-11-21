Return-Path: <linux-nfs+bounces-8190-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6856E9D557E
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 23:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273BB283DDB
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 22:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B851C1DC05D;
	Thu, 21 Nov 2024 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tfcq24Se";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gnitM5NU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D6C1CEAB8
	for <linux-nfs@vger.kernel.org>; Thu, 21 Nov 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732228181; cv=fail; b=f1uRjQ7fUWPVMHlWGOxeTHD8UGNgOyWwHngQRLeSYYJmnSHciHd9Edem5pqi4X4gBqYo21SO4gICH4Mt/p3lTWTEVR7KpgbCvasWE9jdH4BVdQLFHiZor9hZJMdwBaQvFfJw5sRMp1Bu18QZ/6qCSvLkuWxhP3J0ixor0LlqOJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732228181; c=relaxed/simple;
	bh=VC0WbT/ZJmIFvtsPh+7G1zCWnsVLBnJC+Kahomi9UNY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QaGyz40MTQ/XNDsjG9YwFaz7lcqTiFVxwRrY6/CMWA19nGZWeLqdDQ3LyWgxILjpJGfs5b62X69AhzMQQtxKUPgYsmOc8FNSTM7boN4NjXDan/cbMb0cRjyftYWpway0a8BBNrlmwuiwNr1rUNe0HfL4flgg0zAXxhEHnkjSsZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tfcq24Se; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gnitM5NU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALIBrZx014434;
	Thu, 21 Nov 2024 22:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VC0WbT/ZJmIFvtsPh+7G1zCWnsVLBnJC+Kahomi9UNY=; b=
	Tfcq24SeW+Zoy0IfbHx4UCbFiVzUc2jIovplpx8VBA+IuxgQNJoDJ1z2h22JBVEA
	x3Y6E9EXJ7rD30sEpN/yjhzqLDTvwSH9GN7F4jMxnf+L8sTBXXbhos3Pww8Mn2Kq
	LSBigEsFhEYuG+VmJacdn6cjr6tB1xaE18NEGick1PEQAAcXkExK72QMw5TSQr8M
	i54lUmihYjhaIXwfmhTRrDEaFgOTS75x69wrpO16IbXl6r7PBv63752Q37rZb4Ma
	x4yuO8JTYwEDYMG+/kdW4gkfSbV4dEKnfYIIr7YjZIot7LnBZT/uAQwjNJ21IY2I
	92QDQIKlaOqco33sl28cNg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0stuht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 22:29:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALM2MPr037215;
	Thu, 21 Nov 2024 22:29:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuch85r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 22:29:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1iz54Z3dN35KUThxbxg4Q0wJcBnhEGBW0I5k30ALIUb6K5gQY3paCKQ/D+pLaf+KYHPTL0qEkrTy1qLipyh6/U7o9JhorfrTQZm6qjskjJ5qVCItmQKFI/uoH9neGUOJVuOpMV22tvGStcp7aExDwC+ZpcYOj+YszyxGVpQr8sZn0RV4RC+eFoFEsrfqt8BuQAUEg+7PptOPTBzgFgLz0N0MY2X/Vu7eOAVSu+8doHkmSpbAlHa4lxt8IoFWZlz9/1qhbnmoyj25zjiN0sLMQLoiF7aiiIvUQyJXVrmY/aXWAl+L/7KzijPA7NN8oDazSnL3ILYVTR4sRy5BhIkVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VC0WbT/ZJmIFvtsPh+7G1zCWnsVLBnJC+Kahomi9UNY=;
 b=mKh7XKwYBwMQCYeC7PxrjWKw9HAf1NkJuBcFfEYt3oCKnZ0noYiiX8qOGgTu27QjjM979vVOURJ1y3w0NXEDGAP2CJh0E1M0g+VcGoMUVzCQTKDROVSOE1RagqXU2RZTgw8flDUC25pOKd8HAmvDEhMKmUwW2XorNdmJUMplvPIOhJ+d870LB0uOMJiN7YvHs4ZyR37AlN+IQs/1dpQhSjUGsQWiuhaiP1vX+3UsMLspW8c+U38yq2jjp+VP2Y28Ah58WmfITrc3dEOSjAUYtHdY4kfVsWOx6MgHK+mMiwytuFEgzBAsNGww6OFqm9e64cnjyRlQ3P+TKrvOpa0XBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC0WbT/ZJmIFvtsPh+7G1zCWnsVLBnJC+Kahomi9UNY=;
 b=gnitM5NU8Mzlk+XVfCiyyDpURYwnodf0Yr4O4LE0iXeS+eZXSSBNXxD5AgCPr/S7EmEcRnDMBAb9FxiGVWujc4jpmwSDmlrH9WSSxhVg5xkwh0laIYajTCc34fDA0qxNKwcKjggtl35iBl4eq0/iSjuRdLRMvK5sCqWIXjfEHBc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5590.namprd10.prod.outlook.com (2603:10b6:806:205::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 22:29:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 22:29:23 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	<dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 5/6] nfsd: add support for freeing unused session-DRC
 slots
Thread-Topic: [PATCH 5/6] nfsd: add support for freeing unused session-DRC
 slots
Thread-Index: AQHbOh0Frj5X9m/dQEyMrQOHJ7SFQrK+/WyAgAA04wCAADAjAIAC50SAgAALpYA=
Date: Thu, 21 Nov 2024 22:29:23 +0000
Message-ID: <FDB4D98A-FBCB-4863-BB0E-1EEB2CB50159@oracle.com>
References: <Zz069lQT2WOgR4EC@tissot.1015granger.net>
 <173222565373.1734440.11186656662331269538@noble.neil.brown.name>
In-Reply-To: <173222565373.1734440.11186656662331269538@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN4PR10MB5590:EE_
x-ms-office365-filtering-correlation-id: bd4bc787-8197-4935-c044-08dd0a7bf346
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2RhUWtWTFd2cENXQ2IvakFacjZEemNSWkFaTERDdWg2eVBtbHBvYmFMSkpa?=
 =?utf-8?B?WklYY2F3L29zOUZZOE5MYy9od3pmMGw2WWNkVUQwSk03N1huZTcxb29LbmNy?=
 =?utf-8?B?SnA4dE5GY2dYZjhnaGR1dzRlVGxZODE4VUF2WGtNdGdjOXFsajZLTjU5UUl0?=
 =?utf-8?B?MWJZREZWZ2dua090L09za2R2S2I0Tk9mUTFCbDM3eDRoYnZNVy9OSUJqZXRu?=
 =?utf-8?B?d1FJekxHc0FLOHdDaFJ3WE5wRVVKaVhhWHUvaTB2cWZJTVFiY0JzVmRHY1hY?=
 =?utf-8?B?NmxDTWpzcFc5UDNreDBkeDZwYS9GeU9lb0FtYnowb1RjbTNqT1BPRlhjYjVt?=
 =?utf-8?B?T1pvVEFGcXVaQW04cUgzemE4aFdZZU9wTGZIN3o1K2lpRm5FajNXM204NHF3?=
 =?utf-8?B?cXBnRk9tOEJCN2hEaE9iak5IbXF6bXg0Um1lWFQybTRUZ2tBK3NCQW9Vb0Q5?=
 =?utf-8?B?RUVjbE1yMWt3cWpwVVB2S3ZtdnRNRjNCWkR1ZEU0V29laGRieWFUQjJwaXEv?=
 =?utf-8?B?N0RzcW56U1NIR2VLY0c1S2NDOUZMUjFmcC9JbWJ2SjlHK0ZMQ280M1BXK1No?=
 =?utf-8?B?QlE1MzNLVlJLWGNqZ2syWkxxbVhhZW9wc0QvQkVRMDcxV2NMa01tT3EzZ1ZV?=
 =?utf-8?B?RVJTaE5XSTJrVTlmQWd0SjBXMHJQamQ4QUY3YWtuQ1RNOVJyMTZLTmpNRXRs?=
 =?utf-8?B?UmRIMTFVMDVzWVoxZXViN2FOajkwaS9yQXY4Snp6czdmZ0Z5czlZZmM2YnRI?=
 =?utf-8?B?OU01QkxDaVpVbjYwTCtmTVBDYW9udUgzVVJSWW1Mek9MaUxBVFFMdmdnVGdi?=
 =?utf-8?B?RzBWUTVpa1Jhai9BN0NHT3MwWngwSm5peVZzQThOK2NPaFNtd1lwOEdxU0Y1?=
 =?utf-8?B?TlNYSzk4NzJpWWF0UTZFNHBJR1BTZFhKQ0RmODBXNmU5cnRuYUk1OFFNdXNx?=
 =?utf-8?B?cTdSeENjK09IMVNOZDF6Nk1zL2RUQmxXN2lQTGpnYlkrM3VNUUx4WVBaaTVk?=
 =?utf-8?B?UzYzRFl6cnVheVpWQ3FaU3BMZW1KVGtETzJ0Mlk3bWZSakM2TzNxUzRjamtJ?=
 =?utf-8?B?WjZ2V0U2TFdTc2VMd2VNaWhVcmYvaXUvbEd1VHJNZkJ2K0x3VTlqak1BMy8w?=
 =?utf-8?B?UDg3aEJrRGRGSThpbmlpS0MwMEN6VGJsUm10dUpOd3BnTXZwSllEbnI2WWxt?=
 =?utf-8?B?UWt1ZTl2SE9vK3hieFpNUE5teWpKbnBRM2ZxWUJpMTQ3MGRNZHNjUXdNYnYv?=
 =?utf-8?B?bUVXTUlHVWZWNTRhbUwyQ3lVM1ZZeTZPQ2pXL21PeWtDaURBckxRZGlzV0NJ?=
 =?utf-8?B?bE5LREh2czVERzF4eWhYQU1WeE1BVEc2MlRQYS80U0MwdGNWb2pxY1pqOWlx?=
 =?utf-8?B?MWxEOE84S1J6MXRTNkp1cGNWOCtFcWJzWDVWUU1QWGhPeGIvb2ZwcDBsS3Fm?=
 =?utf-8?B?MmVmS2RqamlBSHRqTE9Hbyt2akc1Y1pQUGJvWVY5d3FmMW9xZVFkYXI4UFhK?=
 =?utf-8?B?aUFKVG5IWGRUbTB5K2lrOTI2U0cvSXlJTGRyMnlKK0RIVEliQXNlQy9SbHpz?=
 =?utf-8?B?WGVOaitmYmxRekwxUlNkRHNuaTc3OWFpU0psQ2h4RzJlT2NJUEhoc3dXYnYx?=
 =?utf-8?B?dTRaTTZrbmpVY3dMcVNNZWNkbmo4dGRXQlVzVkNQaTd6QzZQK0k3czBxdU1Y?=
 =?utf-8?B?aGtndHVHQURka2xxam4ra0lEMklHY05IeEpheHpKNk1tTnhOODEraDBiYnV6?=
 =?utf-8?B?RVRvL1B3anFRQmVhT1VZK243Mk1kdVl6VlFVUTlKQjFybUltdzUxaEJqTnI2?=
 =?utf-8?Q?qH6vmyxoKalFfHiNZPxi2W2UpX2DDmt0hokx4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1FkMTl2eHpxVXpoWEhoYTdhZnVWdVR4akpteG8yMVYwaHROY0U2cGd6Zi9B?=
 =?utf-8?B?R0w5SElyRWlNZHZFZ3N3b3dXYnE3M1loZTdpRjVLVnA2WmdpU3Zhd0R1TEVG?=
 =?utf-8?B?L2Yyci9Zd2luLytkeU50U2dWVjN6bGovM0RLY0c0RHVob1hMbDlwcVhpb3Q2?=
 =?utf-8?B?RGJoQ0Z6Nk5IMzNob29WM2ppU0QxeC9hdnNIS09XMmR3SE02TmN2V0Z5TnZF?=
 =?utf-8?B?MDZscVM3empmT3hTY2NEeC9LazVhTThqUlZ0OWRhT2hXS3VRUzVXTnRmSklX?=
 =?utf-8?B?dk1jWTdzbDRZMlV6MFZkQmVxV1BSZW5KLzJKNnlXTXBZeWxuelowcUozdkhQ?=
 =?utf-8?B?YTdaUFdHcktPWCtFcjFBNDVlNlRab0Y2WDlxczVIVHU4aUNCbEU4ck91UU9P?=
 =?utf-8?B?Nm1VRjh4cTlucUVBaWtRRmE4UXlJZWh1bzBHUWN5U1VWaE5tT0NjNHJEaHJK?=
 =?utf-8?B?eUNSMklBa0ZWUVJwNWxVUkJOYnJ0NUU0dWVoMkZNWHZrcjVkVEVlWHZENHRq?=
 =?utf-8?B?a1NjTGQ2Rkc2bTZOV0U4cnlXRXVqd1NkZzQ1NnNVZFd0WDJuUjB0VTl6OVpl?=
 =?utf-8?B?cS8zV3A1cFJsTVJYZWliOFl0NVJzdGp5c1dlbkFtNHRJRS8zMmpXVlNDQ2hk?=
 =?utf-8?B?dEFRN3JzeGVOTDRheENMWmdTaDdWMEsyYUJuZGtWSzd6MjM0ZXA0dWxYN2NZ?=
 =?utf-8?B?VEx1OTZpOTB6S1VoZ3RvQ0pZV0hEaituQXkzZnNzWjlhaDhIaWNENTFVOFRp?=
 =?utf-8?B?VklYRXA5MUdIRE8zOFFHUjFaemMxMmVvRlc2TkdMdGd3MHBHZGdRLzljbDl6?=
 =?utf-8?B?aE12V1pyeU95RkZKdWpEVU1rUGFoZUtoNlQ0NlBnTHliOHJwTTNiZVVuYXBx?=
 =?utf-8?B?SWNTQ3ZSYmloQk03b3VNTlJNamZFbnRhT2lkUlkvUFk2RWowYy9EWmk2VWg0?=
 =?utf-8?B?ajlDZzFnWExMVHNRd0FIc0RDcXJzZ2hnR3cwSHZPNlVhbkM3WUg1Tk4ycEFk?=
 =?utf-8?B?VXpOdVhtaWpWUk9TQXFwQ3pKYnlXaVRlWW5mMml4NW5EU3FhdjlNMVdkR0Z5?=
 =?utf-8?B?QzdJYzJIL0djeml3ZlV5ZTNWVlF3dWVFNzNWVjB1R252SWw1eUxkT0NqNURD?=
 =?utf-8?B?c0tCUlFxY3ZZL2xsU2YrSEZTRjNWREZmSFYvMkZIOGxlMXdudHpZa08vSktK?=
 =?utf-8?B?OUwxSlgvOXdxV3VhaU55N2o4RTNwQlF2aHNyY3Qrck42bmlMSWc0Z21MS1Nk?=
 =?utf-8?B?alVrWUNMWUhjaDVLaTBTOC9SYnNHL2NiZFFWTDNMK0lMdm40SkExUW1JRnp6?=
 =?utf-8?B?VytudXFMTzAwUHhISWE4dFBzdS9GajVFazRhbHlTdUU4cnN1TmdTczh2SmF4?=
 =?utf-8?B?M2E1WE1vM2JQNWg1cVJBQXB1cDVVQ2pYZmxhcGoyMlo3ZjNOOFJCZFRqVlc1?=
 =?utf-8?B?bHoxczE1TmlRY3ZITmNVY1ErMHhjQkp6dUVOLzFNdTl1YmhzdGVBQVE1ekRu?=
 =?utf-8?B?Q0NwT09PbmR0RWswUnFDUHZSS2p0UHBzZlV3UzhERXRienF2RjEwZWRNWTVa?=
 =?utf-8?B?dnBHZ0ozcDd0c2JqdnNwTFBXeko5RUxFTGh4SGl1QzdEYkk1OXZ2cEh0Y3BC?=
 =?utf-8?B?YnJrUlZZeno2TWdoenNHU1YzMW4yNnQ4NU1pSStXUW16bENVQjZaTlJLbE4r?=
 =?utf-8?B?S2s2dzlPY1p2QUh2Z1VFQ0VJOS9tMXlUMkFYODRyWmpvbjM4UGgzamZXY256?=
 =?utf-8?B?TytvUGRheldxdGkyTXc0VHRhcHR1VnJIWWUvMDNETXVFd2JEaGZ0VTZpT1Ns?=
 =?utf-8?B?U3Rjc1gzT2N6dmV0MDg5b2VBd2g4NERYOFlFemNYQmdGY3JWaXByamRpTW1L?=
 =?utf-8?B?dURSVzJRUmRmTm9jclJ0bGFyblRMNE1abVZVMktUajBGaUY0a1VGbTUyaHRD?=
 =?utf-8?B?V0lXcTBRcnlKY05hWmFDNUtXTUhBbFlkOXhoOHBTYk1laFVSemhURDRuRklX?=
 =?utf-8?B?TStDaVMxc1pJVkMrZ2dZUDV5dlFSRVZjeTZYaXZLaUJzZEQxdExySkhJcDRV?=
 =?utf-8?B?WHUzenE3UHAyQmJtUmZhM0hUTVZHRzNJN1pFWmw5NUNxZnBsQ3A4bnVPS1B4?=
 =?utf-8?B?eGloeWJTU0tuWW5lL3JXUURLelYzUG1zSnQ0YW54SHJaUWxFcGkzTy9JbmJi?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DE3B7488811A54D97633913097942A7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	98pW+RqhKBltG8ZG6FGJ4tc/kY7pnpprthc9GYBOjZiyWkwxk+wFwkN2OX3fmNyow9TLhgd87jdsXX9GndUKJGQdzm3LV9MGTnWelgxUkCcPBivlD76nLps9/durNzNz9uQAkiglgStS9F0hja8pQpVy6tbgvS99ph3QyM1ND+H/79pXbA+UPO5DHbFYY1uVWCmfP+22EsaJNkrrS6KqRy1LwRgU/fAoUAPZgAOczqbtnDrFv7iKUah0aMJX+C6o1P9fgWX55W0W3lRfwxOLgECBOz+MBpBpIEMa8wRMv1mvKlWZSYzMukQz/tbqYEL83TSWa/Wz40PeiSmZRmUAc9/4FVfkOlxETBmUA3I4kuXL7Sm05p+2IVntEbH5yU4LFDm3Jk12v1AWhpAY4KLuathVlpJzF16tN/Mx3Xj3/9nrB3ovjybJfcTHCNE6JyURTlAmKHZ0L1gQuA6z1Fc6s8obYAyN412AF6jAk8xsMgc1SKreEyv0NDlRWTBbkmF+QMFkW6nJC+/tWV+zPqlUELFEErOBKUpA73fdjv69XnF2Hy1q5QeejjGqIl6BGLartWhdI+CeSuFjN2X42i+OjhDNagANs1MdvYEAbH95k+4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4bc787-8197-4935-c044-08dd0a7bf346
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 22:29:23.5175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ltKuiiv2O6GU5CvrNorBHWyB0wuYDh70gx7VLUWcp6/pVzQ35AO1+fJZOcGLTFdx9ypH1tRaWU3gIdFo0wvNmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_15,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210169
X-Proofpoint-ORIG-GUID: MqDnvzxWOhE7YdfaVOWaTD47CY4XQLv-
X-Proofpoint-GUID: MqDnvzxWOhE7YdfaVOWaTD47CY4XQLv-

DQoNCj4gT24gTm92IDIxLCAyMDI0LCBhdCA0OjQ34oCvUE0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIDIwIE5vdiAyMDI0LCBDaHVjayBMZXZlciB3cm90
ZToNCj4+IE9uIFdlZCwgTm92IDIwLCAyMDI0IGF0IDA5OjM1OjAwQU0gKzExMDAsIE5laWxCcm93
biB3cm90ZToNCj4+PiBPbiBXZWQsIDIwIE5vdiAyMDI0LCBDaHVjayBMZXZlciB3cm90ZToNCj4+
Pj4gT24gVHVlLCBOb3YgMTksIDIwMjQgYXQgMTE6NDE6MzJBTSArMTEwMCwgTmVpbEJyb3duIHdy
b3RlOg0KPj4+Pj4gUmVkdWNpbmcgdGhlIG51bWJlciBvZiBzbG90cyBpbiB0aGUgc2Vzc2lvbiBz
bG90IHRhYmxlIHJlcXVpcmVzDQo+Pj4+PiBjb25maXJtYXRpb24gZnJvbSB0aGUgY2xpZW50LiAg
VGhpcyBwYXRjaCBhZGRzIHJlZHVjZV9zZXNzaW9uX3Nsb3RzKCkNCj4+Pj4+IHdoaWNoIHN0YXJ0
cyB0aGUgcHJvY2VzcyBvZiBnZXR0aW5nIGNvbmZpcm1hdGlvbiwgYnV0IG5ldmVyIGNhbGxzIGl0
Lg0KPj4+Pj4gVGhhdCB3aWxsIGNvbWUgaW4gYSBsYXRlciBwYXRjaC4NCj4+Pj4+IA0KPj4+Pj4g
QmVmb3JlIHdlIGNhbiBmcmVlIGEgc2xvdCB3ZSBuZWVkIHRvIGNvbmZpcm0gdGhhdCB0aGUgY2xp
ZW50IHdvbid0IHRyeQ0KPj4+Pj4gdG8gdXNlIGl0IGFnYWluLiAgVGhpcyBpbnZvbHZlcyByZXR1
cm5pbmcgYSBsb3dlciBjcl9tYXhyZXF1ZXN0cyBpbiBhDQo+Pj4+PiBTRVFVRU5DRSByZXBseSBh
bmQgdGhlbiBzZWVpbmcgYSBjYV9tYXhyZXF1ZXN0cyBvbiB0aGUgc2FtZSBzbG90IHdoaWNoDQo+
Pj4+PiBpcyBub3QgbGFyZ2VyIHRoYW4gd2UgbGltaXQgd2UgYXJlIHRyeWluZyB0byBpbXBvc2Uu
ICBTbyBmb3IgZWFjaCBzbG90DQo+Pj4+PiB3ZSBuZWVkIHRvIHJlbWVtYmVyIHRoYXQgd2UgaGF2
ZSBzZW50IGEgcmVkdWNlZCBjcl9tYXhyZXF1ZXN0cy4NCj4+Pj4+IA0KPj4+Pj4gVG8gYWNoaWV2
ZSB0aGlzIHdlIGludHJvZHVjZSBhIGNvbmNlcHQgb2YgcmVxdWVzdCAiZ2VuZXJhdGlvbnMiLiAg
RWFjaA0KPj4+Pj4gdGltZSB3ZSBkZWNpZGUgdG8gcmVkdWNlIGNyX21heHJlcXVlc3RzIHdlIGlu
Y3JlbWVudCB0aGUgZ2VuZXJhdGlvbg0KPj4+Pj4gbnVtYmVyLCBhbmQgcmVjb3JkIHRoaXMgd2hl
biB3ZSByZXR1cm4gdGhlIGxvd2VyIGNyX21heHJlcXVlc3RzIHRvIHRoZQ0KPj4+Pj4gY2xpZW50
LiAgV2hlbiBhIHNsb3Qgd2l0aCB0aGUgY3VycmVudCBnZW5lcmF0aW9uIHJlcG9ydHMgYSBsb3cN
Cj4+Pj4+IGNhX21heHJlcXVlc3RzLCB3ZSBjb21taXQgdG8gdGhhdCBsZXZlbCBhbmQgZnJlZSBl
eHRyYSBzbG90cy4NCj4+Pj4+IA0KPj4+Pj4gV2UgdXNlIGFuIDggYml0IGdlbmVyYXRpb24gbnVt
YmVyICg2NCBzZWVtcyB3YXN0ZWZ1bCkgYW5kIGlmIGl0IGN5Y2xlcw0KPj4+Pj4gd2UgaXRlcmF0
ZSBhbGwgc2xvdHMgYW5kIHJlc2V0IHRoZSBnZW5lcmF0aW9uIG51bWJlciB0byBhdm9pZCBmYWxz
ZSBtYXRjaGVzLg0KPj4+Pj4gDQo+Pj4+PiBXaGVuIHdlIGZyZWUgYSBzbG90IHdlIHN0b3JlIHRo
ZSBzZXFpZCBpbiB0aGUgc2xvdCBwb2ludGVyIHNvIHRoYXQgaXQgY2FuDQo+Pj4+PiBiZSByZXN0
b3JlZCB3aGVuIHdlIHJlYWN0aXZhdGUgdGhlIHNsb3QuICBUaGUgUkZDIGNhbiBiZSByZWFkIGFz
DQo+Pj4+PiBzdWdnZXN0aW5nIHRoYXQgdGhlIHNsb3QgbnVtYmVyIGNvdWxkIHJlc3RhcnQgZnJv
bSBvbmUgYWZ0ZXIgYSBzbG90IGlzDQo+Pj4+PiByZXRpcmVkIGFuZCByZWFjdGl2YXRlZCwgYnV0
IGFsc28gc3VnZ2VzdHMgdGhhdCByZXRpcmluZyBzbG90cyBpcyBub3QNCj4+Pj4+IHJlcXVpcmVk
LiAgU28gd2hlbiB3ZSByZWFjdGl2ZSBhIHNsb3Qgd2UgYWNjZXB0IHdpdGggdGhlIG5leHQgc2Vx
aWQgaW4NCj4+Pj4+IHNlcXVlbmNlLCBvciAxLg0KPj4+Pj4gDQo+Pj4+PiBXaGVuIGRlY29kaW5n
IHNhX2hpZ2hlc3Rfc2xvdGlkIGludG8gbWF4c2xvdHMgd2UgbmVlZCB0byBhZGQgMSAtIHRoaXMN
Cj4+Pj4+IG1hdGNoZXMgaG93IGl0IGlzIGVuY29kZWQgZm9yIHRoZSByZXBseS4NCj4+Pj4+IA0K
Pj4+Pj4gU2lnbmVkLW9mZi1ieTogTmVpbEJyb3duIDxuZWlsYkBzdXNlLmRlPg0KPj4+Pj4gLS0t
DQo+Pj4+PiBmcy9uZnNkL25mczRzdGF0ZS5jIHwgODEgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tDQo+Pj4+PiBmcy9uZnNkL25mczR4ZHIuYyAgIHwgIDUgKy0t
DQo+Pj4+PiBmcy9uZnNkL3N0YXRlLmggICAgIHwgIDQgKysrDQo+Pj4+PiBmcy9uZnNkL3hkcjQu
aCAgICAgIHwgIDIgLS0NCj4+Pj4+IDQgZmlsZXMgY2hhbmdlZCwgNzYgaW5zZXJ0aW9ucygrKSwg
MTYgZGVsZXRpb25zKC0pDQo+Pj4+PiANCj4+Pj4+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mczRz
dGF0ZS5jIGIvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPj4+Pj4gaW5kZXggZmI1MjIxNjViMzc2Li4w
NjI1YjBhZWM2YjggMTAwNjQ0DQo+Pj4+PiAtLS0gYS9mcy9uZnNkL25mczRzdGF0ZS5jDQo+Pj4+
PiArKysgYi9mcy9uZnNkL25mczRzdGF0ZS5jDQo+Pj4+PiBAQCAtMTkxMCwxNyArMTkxMCw1NSBA
QCBnZW5fc2Vzc2lvbmlkKHN0cnVjdCBuZnNkNF9zZXNzaW9uICpzZXMpDQo+Pj4+PiAjZGVmaW5l
IE5GU0RfTUlOX0hEUl9TRVFfU1ogICgyNCArIDEyICsgNDQpDQo+Pj4+PiANCj4+Pj4+IHN0YXRp
YyB2b2lkDQo+Pj4+PiAtZnJlZV9zZXNzaW9uX3Nsb3RzKHN0cnVjdCBuZnNkNF9zZXNzaW9uICpz
ZXMpDQo+Pj4+PiArZnJlZV9zZXNzaW9uX3Nsb3RzKHN0cnVjdCBuZnNkNF9zZXNzaW9uICpzZXMs
IGludCBmcm9tKQ0KPj4+Pj4gew0KPj4+Pj4gaW50IGk7DQo+Pj4+PiANCj4+Pj4+IC0gZm9yIChp
ID0gMDsgaSA8IHNlcy0+c2VfZmNoYW5uZWwubWF4cmVxczsgaSsrKSB7DQo+Pj4+PiArIGlmIChm
cm9tID49IHNlcy0+c2VfZmNoYW5uZWwubWF4cmVxcykNCj4+Pj4+ICsgcmV0dXJuOw0KPj4+Pj4g
Kw0KPj4+Pj4gKyBmb3IgKGkgPSBmcm9tOyBpIDwgc2VzLT5zZV9mY2hhbm5lbC5tYXhyZXFzOyBp
KyspIHsNCj4+Pj4+IHN0cnVjdCBuZnNkNF9zbG90ICpzbG90ID0geGFfbG9hZCgmc2VzLT5zZV9z
bG90cywgaSk7DQo+Pj4+PiANCj4+Pj4+IC0geGFfZXJhc2UoJnNlcy0+c2Vfc2xvdHMsIGkpOw0K
Pj4+Pj4gKyAvKg0KPj4+Pj4gKyAgKiBTYXZlIHRoZSBzZXFpZCBpbiBjYXNlIHdlIHJlYWN0aXZh
dGUgdGhpcyBzbG90Lg0KPj4+Pj4gKyAgKiBUaGlzIHdpbGwgbmV2ZXIgcmVxdWlyZSBhIG1lbW9y
eSBhbGxvY2F0aW9uIHNvIEdGUA0KPj4+Pj4gKyAgKiBmbGFnIGlzIGlycmVsZXZhbnQNCj4+Pj4+
ICsgICovDQo+Pj4+PiArIHhhX3N0b3JlKCZzZXMtPnNlX3Nsb3RzLCBpLCB4YV9ta192YWx1ZShz
bG90LT5zbF9zZXFpZCksDQo+Pj4+PiArICBHRlBfQVRPTUlDKTsNCj4+Pj4gDQo+Pj4+IEFnYWlu
Li4uIEFUT01JQyBpcyBwcm9iYWJseSBub3Qgd2hhdCB3ZSB3YW50IGhlcmUsIGV2ZW4gaWYgaXQg
aXMNCj4+Pj4gb25seSBkb2N1bWVudGFyeS4NCj4+PiANCj4+PiBXaHkgbm90PyAgSXQgbWlnaHQg
YmUgY2FsbGVkIHVuZGVyIGEgc3BpbmxvY2sgc28gR0ZQX0tFUk5FTCBtaWdodCB0cmlnZ2VyDQo+
Pj4gYSB3YXJuaW5nLg0KPj4gDQo+PiBJIGZpbmQgdXNpbmcgR0ZQX0FUT01JQyBoZXJlIHRvIGJl
IGNvbmZ1c2luZyAtLSBpdCByZXF1ZXN0cw0KPj4gYWxsb2NhdGlvbiBmcm9tIHNwZWNpYWwgbWVt
b3J5IHJlc2VydmVzIGFuZCBpcyB0byBiZSB1c2VkIGluDQo+PiBzaXR1YXRpb25zIHdoZXJlIGFs
bG9jYXRpb24gbWlnaHQgcmVzdWx0IGluIHN5c3RlbSBmYWlsdXJlLiBUaGF0IGlzDQo+PiBjbGVh
cmx5IG5vdCB0aGUgY2FzZSBoZXJlLCBhbmQgdGhlIHJlc3VsdGluZyBtZW1vcnkgYWxsb2NhdGlv
biBtaWdodA0KPj4gYmUgbG9uZy1saXZlZC4NCj4gDQo+IFdvdWxkIHlvdSBiZSBjb21mb3J0YWJs
ZSB3aXRoIEdGUF9OT1dBSVQgd2hpY2ggbGVhdmVzIG91dCBfX0dGUF9ISUdIID8/DQoNCkkgd2ls
bCBiZSBjb21mb3J0YWJsZSB3aGVuIEkgaGVhciBiYWNrIGZyb20gTWF0dGhldyBhbmQgTGlhbS4N
Cg0KOi0pDQoNCg0KPj4gSSBzZWUgdGhlIGNvbW1lbnQgdGhhdCBzYXlzIG1lbW9yeSB3b24ndCBh
Y3R1YWxseSBiZSBhbGxvY2F0ZWQuIEknbQ0KPj4gbm90IHN1cmUgdGhhdCdzIHRoZSB3YXkgeGFf
c3RvcmUoKSB3b3JrcywgaG93ZXZlci4NCj4gDQo+IHhhcnJheS5yc3Qgc2F5czoNCj4gDQo+ICBU
aGUgeGFfc3RvcmUoKSwgeGFfY21weGNoZygpLCB4YV9hbGxvYygpLA0KPiAgeGFfcmVzZXJ2ZSgp
IGFuZCB4YV9pbnNlcnQoKSBmdW5jdGlvbnMgdGFrZSBhIGdmcF90DQo+ICBwYXJhbWV0ZXIgaW4g
Y2FzZSB0aGUgWEFycmF5IG5lZWRzIHRvIGFsbG9jYXRlIG1lbW9yeSB0byBzdG9yZSB0aGlzIGVu
dHJ5Lg0KPiAgSWYgdGhlIGVudHJ5IGlzIGJlaW5nIGRlbGV0ZWQsIG5vIG1lbW9yeSBhbGxvY2F0
aW9uIG5lZWRzIHRvIGJlIHBlcmZvcm1lZCwNCj4gIGFuZCB0aGUgR0ZQIGZsYWdzIHNwZWNpZmll
ZCB3aWxsIGJlIGlnbm9yZWQuYA0KPiANCj4gVGhlIHBhcnRpY3VsYXIgY29udGV4dCBpcyB0aGF0
IGEgbm9ybWFsIHBvaW50ZXIgaXMgY3VycmVudGx5IHN0b3JlZCBhDQo+IHRoZSBnaXZlbiBpbmRl
eCwgYW5kIHdlIGFyZSByZXBsYWNpbmcgdGhhdCB3aXRoIGEgbnVtYmVyLiAgVGhlIGFib3ZlDQo+
IGRvZXNuJ3QgZXhwbGljaXRseSBzYXkgdGhhdCB3b24ndCByZXF1aXJlIGEgbWVtb3J5IGFsbG9j
YXRpb24sIGJ1dCBJDQo+IHRoaW5rIGl0IGlzIHJlYXNvbmFibGUgdG8gc2F5IGl0IHdvbid0IG5l
ZWQgInRvIGFsbG9jYXRlIG1lbW9yeSB0byBzdG9yZQ0KPiB0aGlzIGVudHJ5IiAtIGFzIGFuIGVu
dHJ5IGlzIGFscmVhZHkgc3RvcmVkIC0gc28gYWxsb2NhdGlvbiBzaG91bGQgbm90DQo+IGJlIG5l
ZWRlZC4NCg0KeGFfbWtfdmFsdWUoKSBjb252ZXJ0cyBhIG51bWJlciB0byBhIHBvaW50ZXIsIGFu
ZCB4YV9zdG9yZQ0Kc3RvcmVzIHRoYXQgcG9pbnRlci4NCg0KSSBzdXNwZWN0IHRoYXQgeGFfc3Rv
cmUoKSBpcyBhbGxvd2VkIHRvIHJlYmFsYW5jZSB0aGUNCnhhcnJheSdzIGludGVybmFsIGRhdGEg
c3RydWN0dXJlcywgYW5kIHRoYXQgY291bGQgcmVzdWx0DQppbiBtZW1vcnkgcmVsZWFzZSBvciBh
bGxvY2F0aW9uLiBUaGF0J3Mgd2h5IGEgR0ZQIGZsYWcgaXMNCm9uZSBvZiB0aGUgYXJndW1lbnRz
Lg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

