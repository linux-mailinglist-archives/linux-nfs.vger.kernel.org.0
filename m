Return-Path: <linux-nfs+bounces-6883-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83FD9917E1
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 17:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB0D282352
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1122415383F;
	Sat,  5 Oct 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lAri2VP/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lLoGn5Yj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D91D1537C3;
	Sat,  5 Oct 2024 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728142837; cv=fail; b=r4fPaJexT6RV+LQDdnQxlzVRf36iT8mx6Js6p3RfYRZ1XFZ+wvhQ1gIPnoOEbmJdYlCcatZXKo8I+CvYjkx2oNXiqwjU1iV5hXQgD7gsd+PP0+w57gzAp+12if+0Cm28ldf/C3ZJYJezlmg8CQjmI+jKTyIy9GXs9/SJsXqJOyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728142837; c=relaxed/simple;
	bh=j7+fGkHC5PnMypDx9MDaNRiixx1kyVzHCt32pXPfUxY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rb5Ft3tHx0DgHPVAPedUr+treUlwZ6IZ+stgivYYJ0vdOX19lJDG9nc1lJwqYADJGjaLE9GKh9Bol8uL+r99eL4Pjg2OY0O2YZBtYveLMocovfWDnOsSFwIs/6SFQhXHoZ3myHeNh2SfnpuFkUqEHZ5At4pfuV8YCbObFRfITMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lAri2VP/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lLoGn5Yj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 495FZ36I006640;
	Sat, 5 Oct 2024 15:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=j7+fGkHC5PnMypDx9MDaNRiixx1kyVzHCt32pXPfUxY=; b=
	lAri2VP/pkabGBdTZmlsciFUBzhSYJmCHfSqhCWHoRRxlGuiKuTGNXG8SonH0myv
	BJvxfZ58FbT9k9qia1XKt3+KJJtIlsGMEdzhK1JpIqX0oK0iOeCg/0Cf5KMg+mH0
	bB4DZ1cqByfP/N8N0VH4W0Dq720QI0sPOTJ+t44pcPu8MbXhJ4sywp99n8fFEyDA
	iCxpo5FCXq6U6vGnOUORC095hwntJh7cAOM1WGTY7Ll/5FXYQOsqcagGT0Li2KMR
	B6ZatL/ssEK4oe6YjPtb7Ysgb0zQ40u5vg4OMKf2KjsKwDUq4N853iIpjTtXGq9L
	JCIkcFxjdueYSx2pbAW/qQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302p8bm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 15:40:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 495ACIC2023918;
	Sat, 5 Oct 2024 15:40:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwam515-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 15:40:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOEX2oBHktWW+DbRDF7CfMDR8h32EBQ2fnme0P2sChSBJ3zhD6uFE/mqSo746QiKf59hjNSwP0kgPqyi+BKMqNBSy0W1sj4u807Rq3QK674wuozhUH1HjWZd6IRxZSgHgm9drj+SfWUWHuVLveb5VCEv5xCQXHHdhBQsoOQ2/j7rAG8QVrxU2Zb4x5pO7lsUpH+4GzbhL+SdLMHFKIiSCGuOIUaRFvlfgsAp+PSPaCTLRZRSc4ZvCO4hAc1b/V7T08KZGZAojH8uY9XT0jygnZ3qYnb+0cLIUPv26cMwMvZwcAqfTUMpaVo2hgD1GrsGNMLFsmTM1+tENYqB0hs80w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7+fGkHC5PnMypDx9MDaNRiixx1kyVzHCt32pXPfUxY=;
 b=MDNjfI8avccwKxRqDZgsQiOJbk4jh5OQkPXMYGMikAY9tYZS7KBFNtZO+8D/He/bCYe8HtPEeRZXEj0mkUDRgT9U1pGKzNYwthWqdH4j9CRp8exfTMB/HdH6cpXfb8pTWGLJCKugC5zmOLJsRn/WMYECRxXL495XLSR1XyjTtOzkVT32c0loA/1VIplLUcN0dUzjhXn3u50xT5+tXFoRBPV59qlLtU+0vAFX3Xa/aELaQGRJ92S9gd9TW65+jazUgUZ+R3qDTmh4dFPQ7T26eH/Cn97M0vBVoXE3HDV86ZeCtGuQlnpAjd1b/jy6BV/GnjLsIFPHB0het5N0PKYzJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7+fGkHC5PnMypDx9MDaNRiixx1kyVzHCt32pXPfUxY=;
 b=lLoGn5YjgE6E223O+E9hRJC7qgEmcQ9Nx5lHbtvuzIpXQe/s18Rf7bRJod6NTY734+jJM+QHIW+9ggVYEkgzb/ExVHQkFBfHjPLibvDq/MZs080t6wYy/IzzG7aGZRFa5LJKvUyQN9XkjX34Ruy8PMs27yuF8XhpvZQ6PJvCGFE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6256.namprd10.prod.outlook.com (2603:10b6:8:b5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.20; Sat, 5 Oct 2024 15:40:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 15:40:15 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
CC: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Add support for mapping sticky bit into NFS4 ACL
Thread-Topic: [PATCH] nfsd: Add support for mapping sticky bit into NFS4 ACL
Thread-Index:
 AQHbBWF3uBMyrMNlq0W7yVMXJCcH5rJcJPAAgAAIoACABOvXgIAAAraAgBdKD4CAAAjCAA==
Date: Sat, 5 Oct 2024 15:40:15 +0000
Message-ID: <3B6E6840-4D54-45AC-A482-C76D63E8BFB9@oracle.com>
References: <20240912221523.23648-1-pali@kernel.org>
 <Zumizr3WnA+XY9ge@tissot.1015granger.net>
 <20240917161050.6g2zpzjqkroddi22@pali>
 <Zu3K34MHFUYNaRfu@tissot.1015granger.net>
 <20240920192941.l2fomgmdfpwq7x6p@pali> <20241005150843.4ac6nugo7yusz2m6@pali>
In-Reply-To: <20241005150843.4ac6nugo7yusz2m6@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6256:EE_
x-ms-office365-filtering-correlation-id: 78c114bf-a392-4c89-bf22-08dce55401fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dUxXQWVUZUdIbTg0Y0k5UVB3S2dKWi84aE4wb3FwbVJnYnpEcUlpbG9XcElk?=
 =?utf-8?B?MFlNcVZ4Mmo4QzRIQTh6cHVIcXBnUS8xS1F3MDJGUjI0NXh5WUFmN1dadHdV?=
 =?utf-8?B?RkorYU1IQ1UwcUozOTRNejl6bTdUTHFvR2xsYTQybkxsdDJQMVRWRUpuMXhu?=
 =?utf-8?B?YzEwUUQxYVlWOXNOUk0wbS9XMFpKL01iYm90UEI3Ykc3Mjc5Y2VlOElYdFA3?=
 =?utf-8?B?VEw4NGFIOXNvd01zVXBDMmlOZ29sTzE5d216VzB1ZnMvVlZGTTdUMUNqU3Iy?=
 =?utf-8?B?Mko3aXhEUFZsemxDSU1YTDN5WWIvSE9PbFF2ZEkvS29pNzNSb2o4NGI2RWhX?=
 =?utf-8?B?RndKaUJ2eFFheHkxY1RsdkhrTUp3OVFiMTNGT2xGSkM0U0hOV1dTSDhpVnhS?=
 =?utf-8?B?QURIUWh5N2VSSjZ0dnlzR296M1BxcjgyTzlUSmxZeGppTkg1TDVMZVNyd1ZD?=
 =?utf-8?B?YU52L1dMcUQ0QWVTcFhVanQ5WGdreEtLQUNnS3Brak1STVd3RWhoVURiS1pi?=
 =?utf-8?B?VnpWUkI2c0xnbThndWp5MEx1dDdXRENUYzZ2RjJrZWdLTlhUQWVJSDBuTkoz?=
 =?utf-8?B?ZVA5aFRBMUhRdzZTaDFsU3JSOGE5elNkZWgxK2J4Y1dLbWFxMUlGYmxOR0pm?=
 =?utf-8?B?N2x1cmU4d25QS0lvMDl2Y0Y0eEpOckFlTXZYVVZzNFZ1NnJ3MFJMcDk5eDFZ?=
 =?utf-8?B?UzYzbDNLMUtMNC9LZ0NlOS93eURqdjh5YnNSLzYyS1N6aUI3Uk8rRzV2MVk2?=
 =?utf-8?B?ZDR4NWJ3cThVS1ZFdEQ1WldjdHhKbFdpamRzV0ptOHVVT0YveUlXRDVwTk4y?=
 =?utf-8?B?blB3ZzVjVjVtdHJYR01uU3V6S1RuNmtDZCtFclFsaUFPRFFQemdraHFJbVc0?=
 =?utf-8?B?SDIvQVJUTlJLTWJJeXpKejVUR0JlOTFialdULy8yeVFEWHIwcDBxUWRlZXpB?=
 =?utf-8?B?TXl4SkRqUnh6VnRMTjd1UjNQTDhDOEpVbXlncWdwajA4ZDBWZmRrMkl6ODBF?=
 =?utf-8?B?Q3hVcStnaWpzNnBxZWdiVWZmbm9CVU9XTzFqdXp6TVFyTk0xK0RqZU5hSTlB?=
 =?utf-8?B?WE45SlE1TXZKTVc5T1U1ZmVFUDYrOUMzRU11ZkVlMktBakFkbEMyL29Mb3Aw?=
 =?utf-8?B?L0o4K0hBWFZKUjFSY0tKWEtrV3lZRTNDMGdVKy9RdFdIUlFjNmVTa3VUaG90?=
 =?utf-8?B?blVsVUN1dVdZTlZ3NURTdk1leDNyZGI2UkUwOGdoczl5K0NrbDllUStoM0Ra?=
 =?utf-8?B?NmxBS1paUnpmRWJtTjRVN245ejUvVmJ6UFpSeFFGL09yVDdvQ1FzcWVmVVFs?=
 =?utf-8?B?ZkJSNXAwamJTSHFDaDRFVzNjQUtHbGNXTzJrVmlGWXo0TXZwZzhWclZKQ2dH?=
 =?utf-8?B?UktCL2QvOU5KQ29hK0Z4VnhZNjJxWjBJV0FaNjk1ZDZLS0JwMzM3SzdxeGc1?=
 =?utf-8?B?bzkxci9OVnMxSTBrRkx6Y2w4N09GNjQ3S2NlaVhwVU9NcFFoZ0dLMHZCRG1p?=
 =?utf-8?B?dVRnWllESy9oYXZwc3RrN2xncUw2RXdYb0ZCVVlMaWVvd0ZBcTZzajI1RHB6?=
 =?utf-8?B?Wlhjc1ZqRDhqc0R2Mk4wVmtJTXhieDdoZDRsR0Jic0EzSWl4aGFvaWFxbHZ3?=
 =?utf-8?B?NmYyWnRrbzJLLzk1N1k1TlFDWWZuZ0ZzcCtjelpKNDkreXhJZ2h3YVE4cWc2?=
 =?utf-8?B?bHExVjJCckJzNFR0M0lQUzlYMWtOQXNtRzNqQi9EazNwZjViVWZOZjdkKysr?=
 =?utf-8?B?NmU3a3J6ZFRHdGh0VnpxVG9tKzlLeEwvRkhPdGhBeTJwRDJ1L3ZEc2xVL01w?=
 =?utf-8?B?M1dZQk1TenIxMlg0VHZ4UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NU5zNFc3VWllNTlLa0dOYnhjRVRNSDFrU1gzQmdablczQlVOOUhZZkVvMUZn?=
 =?utf-8?B?c2JKV1ZvZWViNkVydjBwSythQzdySzYyZkJoK0o2dDBhZHpSUnRZSkJKZ0pV?=
 =?utf-8?B?SG9sTjNML2tCbVBTbUo4MTl3cUtnOFE2VDBsMHo5RWh4a0RMLzhhdno1ZzB1?=
 =?utf-8?B?cG5ZbnhZZC8rWmRJSHQ1ZlVpeUh3b0dRUndodzZnQ0xocUJhcFVoOGFYNDJp?=
 =?utf-8?B?VzgxVldibi9hZk5ja3pzM1ZOTVRYU014TS9ZVmdGdE9QVnhnR3RhRHhadUxi?=
 =?utf-8?B?VjZZZS9aK1A1S1VJcjdyR2RjdWowaGtpSkZOWm1WV1l0VzhFVzUwRVZZc0cy?=
 =?utf-8?B?ZEZPWjg2bXYrbWM5MVBJRURSS2MzdkY0dWhiMXRxVlZJUEVFYVQrUmtRZUhi?=
 =?utf-8?B?Vmw0NDlkNllHR0Joc2JzcWlYV2o0OGZySzNYMG10cit6MTVIcG1CQmxkVnAy?=
 =?utf-8?B?L1lnZHR6Zm5Kdmk2NFZSTEFlU0srUlRMZFRGTEF0WEdrckY4UjlPbDBNZ1hC?=
 =?utf-8?B?R2NmWC9VMzJBNC9BZnpEb3ZCMFhaWng3T0YySk1EaEUrWVM2Z2xOTXhjT0RC?=
 =?utf-8?B?N2tKL1ovenNHeE9GNzhaWlp4eW11ODlXaE1mc08yUzVIZjRRQkxuZktYTkkr?=
 =?utf-8?B?d2xOdUhhNzc0UlpvL3JKWk5sUEVtZHVZdjF3anNLclF5RGh1MUo3cVhTTHRB?=
 =?utf-8?B?V1o4RmtyT2JjeGVLZUIxdkx4VE54cTNVS3ZrL2ZFL05UUjFRVDNJc2ZTZTFV?=
 =?utf-8?B?MEpZMjkyalRGV0FxVFlFZ2xCTzFoRG5NNXJVZWhHbGN5Kys3SGYvSjgzcExP?=
 =?utf-8?B?VGpVTGlGV1htQ2hYVUVZTUYybS8yN2xiQWthTVZYb0JDekxDZmhPVyt2bE1l?=
 =?utf-8?B?ZlZsaTZYR0dlNWt0TWNidlc2bCtpYXRtQnJrQlhJckJobUtRaWwrRmpYS0dF?=
 =?utf-8?B?K2FjZW5iUkFOKzhXa1FDUkFwekdXOVFsdmNaMTNUK2tCdXdqNFdnQVZLWDlI?=
 =?utf-8?B?c0tKbTdOTGUyNjFTMkhvSFN4a3lDNnhxQzJhMXAzUytabUNNT3o4VUVGYXBv?=
 =?utf-8?B?aWY1MnJjeDBRVUZzeXZZY3lFeklXNk5LRm9xM1UxMkdJd2Qwb25ybm9WUVlI?=
 =?utf-8?B?UWpyOWs3NEhLbHRnUzNCTjNhZldWVTdOZzdhclZWZU82WlQyc2FVUHJJWkx3?=
 =?utf-8?B?NElFeDlkS3N1VEhBVmJYbHZKdkNWbHUvTStWa05GN2NTQWFUVEN0UVNPczMy?=
 =?utf-8?B?dGNETUNBbG9iMENhV1BlTEhkMlNoOEFiVm1hcVZGOWZIdW50YldXemNieE1r?=
 =?utf-8?B?blhFbncwZUdMOVk0aE92emVqTDNwa3R4TDFkT3JmRER6bXp3a0RmSXBVSTV6?=
 =?utf-8?B?WStFTzVCK0RyY1lSUUZFVVhDOVgzeFZ5dW1xNElVK1k0dHdxU3U5V3BhMlZS?=
 =?utf-8?B?UjJVUGlPZEpYcXF3aWdjcUFpVjRZdzJYUXpPbVpBbSt4T2ZzdVBOU2hvc1BT?=
 =?utf-8?B?aGhmVmdIRHREZ1k4cmp5WnlMQnNHMjcxTVRGV016SVFJVkM0YzhjQkltdThU?=
 =?utf-8?B?aDhnN0t0TGUzYW94eUJ5aEU5amtXUURyRDd2ay9iV2twbE1lQW11V1NPRVgw?=
 =?utf-8?B?WVlxQzVyZFdHRmtLa2p0Z2h2dnVWcDM5ZE1uM3JvZWxmWURjcDUrTVdBekEr?=
 =?utf-8?B?dDNCcC81dkp0cmtOSm1hZElJVlFaRDZ0M2EzeVlhSTZZcTBEVHFmSXBTdHUw?=
 =?utf-8?B?MzNYM1dKTGtyaHB1ZVBQdEY2NzNlVWwxMk9NR2lvanJvNUpHV3dBcjMybVB0?=
 =?utf-8?B?ZlYrSEhxd3EzVWRwSmxDSWtYZGdJTXBnT3BveXkyNFU0c2N4UmxuUVJ0dUFP?=
 =?utf-8?B?NkJJd2FIR09lcGM3NzFFbWdoMjY2bDBUdjFOVDJ5eVh6VU9aWjludlJYZlJu?=
 =?utf-8?B?OXE5dit5NzU0eXhXUmpkQW01SkVtUngvcTVGalQ1L2tEWFNabVdreGdUM0xq?=
 =?utf-8?B?aWNlMm5WbHd4eUpVSnRhVTlRNnBad1NpZ29Bdmg5UVFBTzlSamtkYm5ieFFF?=
 =?utf-8?B?ZVVwelBENkpWaGNGM2dhMVE3amlNK2FVNWFORFBKWWtMbHJsd0dKRjdINGFW?=
 =?utf-8?B?b1lEUFJGL2M0NnpCalJQRWdhMEZiLzdCcXRveU9WOXByUlFNR0ZQemlhM2xN?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F30C12CAFC9B0D49914C91DB69391F91@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JAtRfZDVcd8ycWIPQ0zPbI/9ydP+at9a5kQGPXBAii77/xJW3bt/9MW6QDfZX6nFuTV9Gh1nXk6da/NebmNY5IcYnbebJikKWIs9Qi3u+BA2KBLy46Ib2UQYwUeFwLqbcjLHzoHsUUGijRi9hiRV9rAD7yrNQ9M+2ZCJctbJyxM0N1o+QwX5joyRroTCUEweD2Xl0JKRLYGEmDZ1AdfNq6KtoKLpURSfkm6ky3nLGZRJRQX9Rs3F3X6a6WzvVp5fVemGxbU1cfownuBc+dpuSp0abJr8DLCWN+8+bdvSJSh/BrXhWkz8AMXKs7tQ+LXbXeriyXPqBJWXajtOrRUy36QICcLPHfyD5eTeicgii6Za6nW0DEhq7xySsBuc41WxNoLVSHBnjRNk5pG7mC1IJfukv1bQnnNlhW7c1wzgPmsjtMZ2NLLmZHU5chzU03LfoK4o1tghxFieDKIpon11aq/VxYbBMSIh4Y3azfMb7NOfCXSwi6sms9k9wMREZnKHyA77GqSw+iG9mL0jJFnfE6Wljp2DpyAIcc1p/5Vx2EkidJ+kdxlPl4QHxsvlHjlWpLhprsuvApd5CN0LHDlEKl1eMamX/JLfxuFHf7KImlc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c114bf-a392-4c89-bf22-08dce55401fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2024 15:40:15.2891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sz3v8eAJVodqdCaFtJ+0Ab/Lup9yUNS9pIxTWlcIoq31O14g4vqtaxNKhDOiaHNkdgxudWDtr/CT8LqdDpU7vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6256
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_13,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410050115
X-Proofpoint-ORIG-GUID: ZLKBrxxkIJ6D1YwqPdimpFaf7qt8yk6h
X-Proofpoint-GUID: ZLKBrxxkIJ6D1YwqPdimpFaf7qt8yk6h

DQoNCj4gT24gT2N0IDUsIDIwMjQsIGF0IDExOjA44oCvQU0sIFBhbGkgUm9ow6FyIDxwYWxpQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gSGVsbG8gQ2h1Y2ssIGhhdmUgeW91IGRvbmUgbW9yZSBy
ZXNlYXJjaCBvbiB0aGlzIGFzIG1lbnRpb25lZD8NCg0KTXkgcG9zaXRpb24gaGFzIG5vdCBjaGFu
Z2VkIGZyb20gdGhlIGxhc3QgZW1haWwgSSBzZW50Og0KDQo+IFRoZSBmdW5kYW1lbnRhbCBjbGFp
bSBmcm9tIHlvdXIgcGF0Y2ggZGVzY3JpcHRpb24gaXMgdGhhdDoNCj4gDQo+Pj4+IHRoZSBORlM0
IEFDTCBjbGllbnQgaXMgbm90DQo+Pj4+IGF3YXJlIG9mIHRoZSBmYWN0IHRoYXQgaXQgY2Fubm90
IGRlbGV0ZSBzb21lIGZpbGVzIGlmIHRoZQ0KPj4+PiBzdGlja3kgYml0IGlzIHNldCBvbiB0aGUg
c2VydmVyIG9uIHBhcmVudCBkaXJlY3RvcnkuDQo+IA0KPiBQT1NJWC1iYXNlZCBjbGllbnRzIGFy
ZSBpbiBmYWN0IGF3YXJlIG9mIHRoaXMgYWRkaXRpb25hbCBjb25zdHJhaW50DQo+IGJlY2F1c2Ug
dGhleSBjYW4gc2VlIHRoZSBzZXQgb2YgbW9kZSBiaXRzIHJldHVybmVkIGJ5IEdFVEFUVFIuDQo+
IA0KPiBTbyBjYW4gbm9uLVBPU0lYIGNsaWVudHMgZm9yIHRoYXQgbWF0dGVyOyBhbHRob3VnaCB0
aGV5IG1pZ2h0IG5vdA0KPiBuYXRpdmVseSB1bmRlcnN0YW5kIHdoYXQgdGhhdCBiaXQgbWVhbnMs
IHRoZWlyIE5GUyBjbGllbnQgY2FuIGltcGFydA0KPiB0aGF0IG1lYW5pbmcuDQo+IA0KPiBJIGNh
biBmaW5kIG5vIHNwZWMgbWFuZGF0ZSBvciBndWlkYW5jZSB0aGF0IHJlcXVpcmVzIHRoaXMgbWFw
cGluZywNCj4gbm9yIGNhbiBJIGZpbmQgYW55IG90aGVyIE5GUyBzZXJ2ZXIgaW1wbGVtZW50YXRp
b25zIHRoYXQgYWRkIGl0Lg0KPiBJZiB0aGlzIGlzIGluZGVlZCBhIHZhbHVhYmxlIGlubm92YXRp
b24sIGEgc3RhbmRhcmQgdGhhdCByZWNvbW1lbmRzDQo+IG9yIHJlcXVpcmVzIGltcGxlbWVudGF0
aW9uIG9mIHRoaXMgZmVhdHVyZSB3b3VsZCBiZSB0aGUgcGxhY2UgdG8NCj4gYmVnaW4uDQo+IA0K
PiBXaGF0IFJGQyA4ODgxIGRvZXMgc2F5IGlzIG9uIHBvaW50Og0KPiANCj4+IDYuMy4xLjEuIFNl
cnZlciBDb25zaWRlcmF0aW9ucw0KPiANCj4+IFRoZSBzZXJ2ZXIgdXNlcyB0aGUgYWxnb3JpdGht
IGRlc2NyaWJlZCBpbiBTZWN0aW9uIDYuMi4xIHRvDQo+PiBkZXRlcm1pbmUgd2hldGhlciBhbiBB
Q0wgYWxsb3dzIGFjY2VzcyB0byBhbiBvYmplY3QuIEhvd2V2ZXIsIHRoZQ0KPj4gQUNMIG1pZ2h0
IG5vdCBiZSB0aGUgc29sZSBkZXRlcm1pbmVyIG9mIGFjY2Vzcy4NCj4gDQo+IEEgbGlzdCBvZiBl
eGFtcGxlcyBmb2xsb3dzLiBUaGUgc3Bpcml0IG9mIHRoaXMgdGV4dCBzZWVtcyB0byBiZSB0aGF0
DQo+IGEgZmlsZSBvYmplY3QncyBBQ0wgbmVlZCBub3QgcmVmbGVjdCBldmVyeSBwb3NzaWJsZSBz
ZWN1cml0eSBwb2xpY3kNCj4gdGhhdCBhIHNlcnZlciBtaWdodCB1c2UgdG8gZGV0ZXJtaW5lIHdo
ZXRoZXIgYW4gb3BlcmF0aW9uIG1heQ0KPiBwcm9jZWVkLg0KDQpXaGljaCBpcyB0byBzYXkgdGhh
dCBJIG5lZWQgeW91IHRvIGFwcHJvYWNoIHRoZSBuZnN2NCBXRyB3aXRoDQp0aGlzIHByb3Bvc2Fs
IGZpcnN0IGJlZm9yZSBpdCBjYW4gYmUgY29uc2lkZXJlZCBmb3IgTkZTRC4NCg0KQWZ0ZXIgYWxs
LCBpZiB0aGlzIGlzIGEgZ29vZCB0aGluZyBmb3IgTkZTIHNlcnZlcnMgdG8gZG8sIHdoeQ0Kd291
bGRuJ3QgeW91IHdhbnQgdG8gZ2V0IG90aGVyIE5GUyBzZXJ2ZXIgdmVuZG9ycyB0byBpbXBsZW1l
bnQNCnRoaXMgYXMgd2VsbD8NCg0KTWVhbndoaWxlIHlvdSBhcmUgZnJlZSB0byBjYXJyeSB0aGlz
IHBhdGNoIGluIHlvdXIgb3duIGZvcmsNCnNvIHRoYXQgb3RoZXJzIGNhbiBleHBlcmltZW50Lg0K
DQoNCj4gSSB0aGluayB0aGF0IHRoaXMgaXMgcmVhbGx5IHVzZWZ1bCBmb3Igbm9uLVBPU0lYIGNs
aWVudHMgYXMgTkZTNCBBQ0xzDQo+IGFyZSBub3QtUE9TSVg7IGtuZnNkIGlzIGFscmVhZHkgdHJh
bnNsYXRpbmcgUE9TSVggQUNMcyB0byBub24tUE9TSVgNCj4gTkZTNCBBQ0xzLCBhbmQgdGhpcyBp
cyBqdXN0IGFuIGltcHJvdmVtZW50IHRvIGNvdmVydCBhbHNvIHRoZQ0KPiBQT1NJWC1zdGlja3kt
Yml0IGluIG5vbi1QT1NJWCBORlM0IEFDTC4NCj4gDQo+IEFsc28gYW5vdGhlciBpbXByb3ZlbWVu
dCBpcyB0aGF0IHRoaXMgY2hhbmdlIGFsbG93cyB0byBtb2RpZnkgYWxsIHBhcnRzDQo+IG9mIFBP
U0lYIGFjY2VzcyBtb2RlIChzdGlja3kgYml0LCBiYXNlIG1vZGUgcGVybWlzc2lvbnMgci93L3gg
YW5kIFBPU0lYDQo+IEFDTCkgdmlhIE5GUzQgQUNMIHN0cnVjdHVyZS4gU28gbm9uLVBPU0lYIE5G
UzQgY2xpZW50IHdvdWxkIGJlIGFibGUgdG8NCj4gYWRkIG9yIHJlbW92ZSBkaXJlY3Rvcnkgc3Rp
Y2t5IGJpdCB2aWEgTkZTNCBBQ0wgZWRpdG9yLg0KDQpBIHJlYWwtd29ybGQgdXNlIGNhc2Ugd291
bGQgYmUgaGVscGZ1bCBmb3IgbWFraW5nIHRoZSBjYXNlDQp0aGF0IHRoaXMgaXMgc29tZXRoaW5n
IHdlIHdhbnQgTkZTIHNlcnZlcnMgdG8gZG8uIEN1cnJlbnRseQ0KdGhpcyBpcyBhICJ3b3VsZG4n
dCBpdCBiZSBuaWNlIGlmLi4uIiBhbmQgSSBkb24ndCBoZWFyIGFueQ0KdXNlcnMgc2F5aW5nICJJ
IGNhbiB1c2UgdGhpcyBmZWF0dXJlIHRvZGF5IGlmIGl0IGV4aXN0ZWQiLg0KDQpCdXQgYXMgSSBz
YWlkIGFib3ZlOiBub24tUE9TSVggY2xpZW50cyBjYW4gcmV0cmlldmUgZmlsZQ0KYXR0cmlidXRl
cyBhbmQgZmlsZSBBQ0xzIGluIHRoZSBzYW1lIENPTVBPVU5ELiBJZiB0aGUgY2xpZW50DQpzZWVz
IHRoZSBzdGlja3kgYml0LCBpdCBjYW4gbWFudWZhY3R1cmUgdGhlIGV4dHJhIEFDRXMgaXRzZWxm
DQpiZWZvcmUgcHJlc2VudGluZyB0aGUgQUNMIHRvIGxvY2FsIGFwcGxpY2F0aW9ucy4gVGhlcmUg
aXMNCnJlYWxseSBubyB0ZWNobmljYWwgbmVlZCBmb3IgTkZTIHNlcnZlcnMgdG8gZG8gdGhpcyB0
aGF0IEkNCmNhbiBzZWUuDQoNClRMO0RSOg0KDQoxLiBUaGUgQUNFcyBjYW4gYmUgYWRkZWQgYnkg
Y2xpZW50cyB0aGVtc2VsdmVzIChhbmQgcmVhbGx5DQp0aGF0IGlzIHRoZSBwcmVmZXJyZWQgYXBw
cm9hY2ggc2luY2UgdGhlIHZhc3QgbWFqb3JpdHkgb2YNCk5GUyBjbGllbnQgaW1wbGVtZW50YXRp
b25zIGRvbid0IG5lZWQgdGhpcyBiZWhhdmlvcikuDQoNCjIuIFRoZXJlIGhhcyBiZWVuIG5vIGFy
Y2hpdGVjdHVyYWwgcmV2aWV3IG9mIHRoZSBwcm9wb3NhbC4NCg0KMy4gVGhlcmUgaXMgbm8gdXNl
ciBkZW1hbmQgZm9yIGl0IHRoYXQgSSBhbSBhd2FyZSBvZi4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXIN
Cg0KDQo=

