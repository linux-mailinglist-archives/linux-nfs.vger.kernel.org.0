Return-Path: <linux-nfs+bounces-4838-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9875E92EEDD
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 20:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260C41F221B7
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 18:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D172716DEB9;
	Thu, 11 Jul 2024 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FDBkzO+9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L5kYCmE4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E7016DC29;
	Thu, 11 Jul 2024 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722491; cv=fail; b=d7Wjpdqkqek/oTbEcgx8dZQ2keHy67V7u0Jh2pjx68nwhokvr6eD/UM8JFPJjJpWuPy7/O6jOzYPAocYkQ0ammRQLfHjw9KAGZ4OZazp6KKH1TjbmC1yZSWbSNtDv8+IA3ZvDR6HMJQ86/6h7uBDXccPLXt2yZB8BA2+y59H3WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722491; c=relaxed/simple;
	bh=t3IrjzAVRl8cY79OaXkPNihFF0hSf/EK4bZBy3aoMR4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lk8CtV3wb89573dg/Skw5lWUNcGeC4hnzq6m2wrc0avM/Ps2LkOikJbM2OmVxTBe3TQNQ58F+1zMDYJS4PL/tDOJ5lgTuDg1OMFBOpIS084sf8VajZBr7xvn5g0ne8VYh7ppR7JpUvrofrMjFnXURcyapDyzX7MAJJ38xdczv7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FDBkzO+9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L5kYCmE4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BFBVvT031018;
	Thu, 11 Jul 2024 18:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=t3IrjzAVRl8cY79OaXkPNihFF0hSf/EK4bZBy3aoM
	R4=; b=FDBkzO+9md+VQNpo5UryZzwOYD9Im7psVMNwIij5U+eGr8ZDXGcDUSTJt
	NWx+AUlxQCLW/00ZxpDKuSFxCQFVEG8oMvubyeV4gohERXhdVoC5ioVsa31yHFtE
	DuY3NSEtmStMdHKrnJXA/zRrIqjhyzyYzC6fdkADw9fiswdBO21x31mmjDf5045J
	BjNmEeq9RS1ydMjG8NCCh96yCddfQQFS4VeQqm5GHu5rU0JHHGhKxncAjIQ4e1EW
	fKs2FFLbOux4Z3Cm6I0W4jSY3N6PrVm7GoW/8spK2cSdoK+Hg39NF3rQWYtaG1w9
	8kyA1WTUS676iVoh+te3ecp/VpXjw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfstaqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 18:28:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BHs9WR033754;
	Thu, 11 Jul 2024 18:28:00 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv2mhee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 18:28:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HR5uqDxQcbfM7js4UQzZj5qGXFnXgxHf4TBJ26tNGmPNFpWcBkhnlZLv28ysqh5k8H4CEKtsSAb9merrOAVLRlStNFgv3BP8vJNJEP+GxBOyDBIzYWL9TbX19zbME4hGo45WFEw7C3T4xbkmObH4DQlVdg7rOPPBfU0KULnts+DYlqZuIFYFPDiWY7bwvzNkH1lmJ8rcLaFHGLI/3DJKX8ytxLnNcpZFqdjZC3fH0+aCjmmWfpS6ib9b9S3b4EWHu9By+5ud/IefQ1qsC+moGY1C/qNz0+0zcdAETVvTt/Zo8/GLl1MQb4h6mdUVx1s+GGy9puJXJpQPovnlBop1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3IrjzAVRl8cY79OaXkPNihFF0hSf/EK4bZBy3aoMR4=;
 b=sGG1UMeURBgJxtDHxn+oGHEr2MkY2XIydcH1uJMm367U+C8mgBTo9uMNZpaMFto4iNHz08ez+wQUX6DWRrZ15bjJBR+00hPk3vaN5liWeDQXSDWon+1ayBCZXXhEPazqk5Fp0aYg9+jWkejwQJoJZek/oIBxYkmNrv7Wa96qmT6N8qjYnxGm1Pf5ZRj59WCWTxqCGVMsmNZRA711KKdwzhuhwFwBa0u4taQ4NMue11nMwVUvfgEp2SQbKLPBb84jhjq7BOXUf4O2JAiNQH08PIflVSvGk9aeHYdMCjYqB9KmCnp+OQKdZvc3qILzRDlv4RRjjgdr0ppO/edw55Pqvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3IrjzAVRl8cY79OaXkPNihFF0hSf/EK4bZBy3aoMR4=;
 b=L5kYCmE4poNRc+Z3gHBI61Oitwy3YHMoGIMlXzfKCsSJpPhgaWJs/PgwdS9YZqIa6xfTR+m4iIGRyeKk7jAPfNgvnevXaWnxlkLbRua+X4Im7XLyMmgb+5PLX7uXswfvXHr85clvyZ7vupZYIvhsnezD/mRLjrXqEvDr/VO9afk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7361.namprd10.prod.outlook.com (2603:10b6:8:f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 18:27:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 18:27:55 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Youzhong Yang <youzhong@gmail.com>, Neil Brown <neilb@suse.de>,
        Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] nfsd: fix refcount leak when failing to hash
 nfsd_file
Thread-Topic: [PATCH 1/3] nfsd: fix refcount leak when failing to hash
 nfsd_file
Thread-Index: AQHa0soGF/qQvWTZV0unhYKg8rR63LHxw4CAgAANUACAAAZmAIAAASgAgAACGAA=
Date: Thu, 11 Jul 2024 18:27:54 +0000
Message-ID: <D6D02751-CD7A-4FF3-8D01-95EE9D303191@oracle.com>
References: <20240710-nfsd-next-v1-0-21fca616ac53@kernel.org>
 <20240710-nfsd-next-v1-1-21fca616ac53@kernel.org>
 <CADpNCvYknMBXf+V=vBLkjOMhTFRN-3o2R9A2c5J4POuaD49kMw@mail.gmail.com>
 <50afe4a63be26a946257c335188e230c86beb148.camel@kernel.org>
 <1874B388-3A15-4D06-A328-C8581F5FE896@oracle.com>
 <0b2fe3a733119b84baf0d65c097f4d716d4c9040.camel@kernel.org>
In-Reply-To: <0b2fe3a733119b84baf0d65c097f4d716d4c9040.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB7361:EE_
x-ms-office365-filtering-correlation-id: 20425389-e20a-40e5-fc83-08dca1d72e87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?K212bEdNTHc4bjBnUFNHQTlleFcyWjBOb2plZ2lLbEdiVmNwK1pmenZ1MG9C?=
 =?utf-8?B?Y0xpeHNmUXZNWTlIOEFwUlNGZndxTkNUcEEvcWFkNEo0cC9pelBYcURuclhl?=
 =?utf-8?B?bHlURFdoM0thcElqQ1pTckt3M0FEbGVEM3RNS2wrUDE0UXdEOWkvYkVPRWdF?=
 =?utf-8?B?T21XV1M4enhsQ0prMVZqR3hSVndiVEZESzR3dys4MXpQZzVnOFI5VnRtSTM0?=
 =?utf-8?B?OEs1elcvUW9RaFVkYlJETFJBSEMvY2ZWRldrSnRCeHBTa0dSZGhUL0VhMklq?=
 =?utf-8?B?TGkvNFhhNGxvR2E1VzFIMTRTeHNWcVYvVzBwQjVvS21OVmcwSjVnaU5XOEpo?=
 =?utf-8?B?NUJ2eExxVnVQVXh6SWx1MTZydEM2UENlaUJWTkFWN2tDSFQyRHNGZVdlMEsy?=
 =?utf-8?B?a3ZhYm9CUGF1RWxuUXgzTUhFQVNyYkNiOVpnSmExRjZZNTNQVjNDd2xpRzNl?=
 =?utf-8?B?dmlGRHJGVTNGbXJ2ZWo1UlJiWmo4MXpPSnF5NW5qTlA0R1lsRFZsbDFjQ1VB?=
 =?utf-8?B?T3VIY2tSVEVGYXpxVDR4UnZqLzFIQnc4S1h1ZmFncnZWNXdYZFhBS09SVDZT?=
 =?utf-8?B?VFdFRnc4WWNhTzBaV3ZVRStIUFdTc25xOG84UXVEZ2NaU2dSamlrWWwxUFZt?=
 =?utf-8?B?SWJ6Z2QzUGNIaS9ReHdtNlhYMExuZ2Yyc1A5cFJHNG50eVEvRjZQbzdrckxu?=
 =?utf-8?B?TEZROU9uTEFFMHd3MHRIN0JycW9kd0RURmJ6YVFMeVZpYnJsNjhNNjNWbEZZ?=
 =?utf-8?B?TEdCdE5BeXRIakloZUFyYVN2T1ROTVhXNGp1c2ZFMStkMDc4U0tIQnNpSjdq?=
 =?utf-8?B?WEV5dWdQZ2xGWHh1SmFJRmdNMGZnMWk5WGhnMHJEYzVlRU82VkVYWGxxcmpw?=
 =?utf-8?B?VWs3VjVyM1UraEpDRUozQXBjK0w5SEw4SXkrTlBqMzFWM2dwOVhqNFdGby80?=
 =?utf-8?B?WU9NdlgwZmxNYjhmV01iWE1lSXlrM1VKbm9Ibk9Wb2pHdFdIRVE5SkJlb29P?=
 =?utf-8?B?eFAxMHV3VzdsL3FLUHVDNE11UXFTMXRWME9WeWJla1o1SDhkYUlRWElDN1JZ?=
 =?utf-8?B?MHZTRWEya3E4M0ZXZmZ0QXNxVWxRNGNqQ2dxMnYvQTBETkIzSndISFRFRzNN?=
 =?utf-8?B?VEgxSGZVUXZCbWYvczhFMDBaeFpxVG1PSGxWNjBVU29KTE1MNmc0NlAwU3Zx?=
 =?utf-8?B?dW04cjRZQ011a3l2dEptd24rbS9vcUpsNWlPdHpPMHJ4VDVnTVA5V0xUdVI2?=
 =?utf-8?B?OUlvYjdHSVJycjRrTEhYMXJ5ek0yREFNMlFDYmUrelg3ZVBWVUt4RGF2akdX?=
 =?utf-8?B?bkdnMzlweUNwYmFHRUFJb0poRDJLMHpjaHZ2YURVWU5MLzd4NW1tbkcwQXJK?=
 =?utf-8?B?bFAvMjV6TWdGMngwMHMxYVM4RGsrN1BLc2M5WG1uVTJFNk1XRkczNXVwdUtJ?=
 =?utf-8?B?ODZKSlZFM2haTlNRNDBGaUdVVGUrdmZKbkxXSG51bGlrL0RyRktObVc1WXVI?=
 =?utf-8?B?ZnBDbjRONUgvbXV4NTVFUTBjLzR2M0NOSlN0a1FERjZJYlBLSWJuRndKRmpT?=
 =?utf-8?B?Y3E0RHFuRE5uYnRHOFBpSm1hUW5PRHh5SjRMM3pQd09JRzZlUGs5L3RUdEo1?=
 =?utf-8?B?V1VRUlAwd05ma2tOeDRHb3QvcUJVa3JvWlVkQzBIdlBDK0pBVWE3bXphcVFz?=
 =?utf-8?B?d0V5UGhwZ2JIN21tUTdHTU9YUXZROEduV0lOT0Qwc0VVUHF2YmNITElkMDBF?=
 =?utf-8?B?QjJ5ZUhJaGU4RDlqazBVYTFDM21sVjlQV2pmbEt4c0c0WmNvdHlSQk9JaTI0?=
 =?utf-8?B?alNxOVJzMUdRaU5hU2t2dGo5Sk14aTVVWmNtdDN6dktLQW5xeDI4Ukx1RDZt?=
 =?utf-8?B?ZnpydXY1VW83NGVTdVVrT3hlY2kzUmxxZzRLUHVDWkg2bHc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OWpPQWVLZ1RrWkVRMURDbzV4dGhLZi9qR3ZjczBMeG5yQUtwcXNHR1UzVFE1?=
 =?utf-8?B?MExsZkRGZG1kOEJ5VzBiYmIwakRaaU9CVTc1TGEvWWF2L1IxUUtZd0JLKzdK?=
 =?utf-8?B?Q1BiVlZoRTlQckRNd0RMcEFHQTFMZ2xQV2lrK1B1ZktpOW52Q3YybXRmTE45?=
 =?utf-8?B?UFNMLy9BUTRndHJNUWZxVDRpSGgxUFpIOUluSjFFdUR1TEZvemJZdmQwVVFx?=
 =?utf-8?B?eFdQdVFQQTdsZCt4YUpYakh4TGdsRFJ0NFlFRXVvQkZ6dEVETGZhM1ZoOHRm?=
 =?utf-8?B?Rkp2Kys1WTIzTXZwbTZPQlhmTXVvdzBodDF5MkpXZGZVK1J1cndxb0hiYWpB?=
 =?utf-8?B?alQzTk93NXlPTTU3T1VyUUFqeFBXNUYxN3l6bnNzRXp0YTA3M1Z4TmU3UytG?=
 =?utf-8?B?R2NYMUl3a1FpM2Yvc0wzZjhSQ1hJYnF3ZGF4L2Z3Z1o4N3VjM1RMNU4vMXNE?=
 =?utf-8?B?VWptdEtDSnM5RkNTTmkxclFhVzBacHFaUjY1TCtRSDl3NzVoc2kxTGtYaTli?=
 =?utf-8?B?UWR3S1FYcWZYcjRFWkVmdlN5d2pJQWJNdXF5MEIvWldmUHR4SHhIVllIVGRD?=
 =?utf-8?B?Sy9VS2JSTlRtU2VPS0hTcXQ4ZnVvMDRvcWxvSGQxZkFrSWQ5UHUvNFdzZVRk?=
 =?utf-8?B?WlRGVmZnQXNqME5nd2FHTFliR2VqQmMySVIyZC9NU2RsN0pRZGEyRUYzNS90?=
 =?utf-8?B?Vm1lSTE4MkdyVnJYRTlYUkJOVXV4NXJTUEM4bnFwY0dVRFF1WENzSlVtT1ZY?=
 =?utf-8?B?S2tVMDRJeEE0a0hsU0lENXNuc29nZDlvNVNkYlBQNXEwaUlJQnROTGRVV0hk?=
 =?utf-8?B?eUZVNDV3SVBoa0tpTmdjMHp5RGpMODlqTTNrMUVrMlFES2FsR3NGYlp2OEpG?=
 =?utf-8?B?NHlYMjd6Um9jU3BteEVndjJHd1dIdFRhOVphSUREUUV1dkh4UmpNdkljY2Rp?=
 =?utf-8?B?TVJuc1JMdVZZcnlrSkJkS2luNXQrRmpQWmZPVEppdXpScWxxVEh3eFd6bElB?=
 =?utf-8?B?MC83QVZJNXlyRDd1NzFOeTA0QWNKRVhrVU9ySnRkTDd6L09XNW9jdytScmxD?=
 =?utf-8?B?eFFiVTFxS0FiL1ZRTHFOeVBRRjQvRGZHNC9WbVV0blptOFNZVGo4ZEZhbERx?=
 =?utf-8?B?czRjTmdBcTdqUEYxOFduNUgvRUdYT2lGVE1tVHc3eEpYa0Rwa1hPV3JLZFZh?=
 =?utf-8?B?RjE2MFJ6a21RS3dveVVVSHhwQ0Z6WEExYkVOY3c4NUlZZDJ0MGRDSjJNSkdV?=
 =?utf-8?B?TWFMdWlCUTBFK3QrdmY4ZjJxM0tiM2tUdlBnaExpa29aTnVzWmpGVGdXT2tj?=
 =?utf-8?B?Ri9uS3Z5NXJBcEJ2T2J0eDBWSXk0dUlaUXpSNUxCb3dLS2VXaS9MNlVPdUwx?=
 =?utf-8?B?QW5EVnpaUmtsQUl5NnJQc1BYNm15TjFiQmdDb1VGTUE3MVdGL0J1aXFvOGtH?=
 =?utf-8?B?WGxtNXpnOVlmeC9kOTNZcjU5MXhwakw0MlllTjZ1RkovaWV6UzV2TVlSajdT?=
 =?utf-8?B?dmd6ODhXb0U5UGN2dEovYjdnbGp5V1owU0ZxK3g3V0ZpMHp4bmF2RHhPOG1W?=
 =?utf-8?B?Z2hXLzhvajRkUDdzVWIvTzc2Y3A1VERxb2FHbmdrWXNpQXdXdXVrQVFRb21F?=
 =?utf-8?B?RzZYWEh0VUx6VElVeTBLRUV5NVhRSDd6UlBUemRCVDR6S3pscmgvaHB4dVly?=
 =?utf-8?B?MTBNMmg4UHVaUHJyamR1Rm9Qb3RzRGRBSDE5bENRaVJ4ZFM2cnlaN0JCZkFw?=
 =?utf-8?B?VDRZRnRuQ2RjOW1NTk1GSFIySUl2UVE1MmQrbWdoMU1FdmROQmxmL2MzRFll?=
 =?utf-8?B?SEZXdU8raVlhbmdwL1ZvZnJ6TzVhRXJXM25GNUl1cnltRVlpUFR0emdkSzZW?=
 =?utf-8?B?MElBWWpOZTdwU1NnbVpMam9rYjFxbXpldkVPZFEwYm5BY2tvcVBZeDNZSVJW?=
 =?utf-8?B?VFladU9rdnBTUnJUSTBYakdQWDVFTnNMZlBZMitmc1JwOUJnUnNEVVlBYnF5?=
 =?utf-8?B?RVlDUGNWMGxFMFFhaEJyN2p5SlE0VkhUbFZzOVJIb2o0aTVWa2ZXbXVaUktU?=
 =?utf-8?B?cUFYWDNybUUwenBGRENqNytIMGRaQlhNSlpmNjh3YU1UVzlTbDZNdzBab21F?=
 =?utf-8?B?NWt0NUJJblQ2WUNyNjlnT3YxRkcxaWZoT2Yvd29qSFpnNHppRDhEc2NITUNp?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16E9C19AC0DFD9419FAAB2608BC2149D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	R2EHLbTgsGxcBTbzt8i7vgmJfcC82H7kvgxWMeF6mwkhIWkaC7NZFoao/Whpj2R415jvUnotFBB3T5s98wpBsmvZyIgY0nGzNCHEbBbOfWbsLlshAwFrAKt3zKzzFxB56ERU6bCEeFg4AhUBnFFqKKzGURmKVuE4HXmWJ6nG8U2YDFiyY44F41XDB6JByBgpI63KMFuLF5587GKafel3s6SMi8eEgzbGKX6Mh3/zzx8yMV2Ix4dwcJJ/GrSgbLcd/loaocSXwEz9tGtWHlikc+Vjl2fuCuwuYRrJpYf7qVFT2j46dp7ukifa6/m87c5RNjt2z9dev9cKK7lzybe7nKgEqyMozCa8kOhCWhrJwRe6+jfuktQ6ZXFx47VeKp6c1EHKXSU4ZGB5T1G4BEiqb1FBRqwwdmiqfdeYmdz3Yp2gsrf3xlm/6MtagMCUbDfkaz+oP/RLbIVNebw17upG2oh3M8UCwz06HQKKUxWYBOIbE8+/xpNrI54Ns536lOwPKcHCLLlD2KcKi5PwPTrb7oyBaseb2wSFXe3T07NwhYiqE3YnqmIhUC7ecgF9chYl5ltSJ2F9g2BCeNlzoy8NWuHlQ+IuyomWlr34noRM/Y4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20425389-e20a-40e5-fc83-08dca1d72e87
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 18:27:54.9921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jkjh4e37bcyUcMi2IkdPRoMeTbcU51oEhpphL1Udh9gDkRKnJKIEQWTpOLwOZ8IwsDeIGv/Rg0VoWx7/ffPn0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110128
X-Proofpoint-ORIG-GUID: 8m35IMeKq6cB_cj4NQaAT0r4uSJG2Oe9
X-Proofpoint-GUID: 8m35IMeKq6cB_cj4NQaAT0r4uSJG2Oe9

DQoNCj4gT24gSnVsIDExLCAyMDI0LCBhdCAyOjIw4oCvUE0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAyMDI0LTA3LTExIGF0IDE4OjE2ICsw
MDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEp1bCAxMSwgMjAy
NCwgYXQgMTo1M+KAr1BNLCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0KPj4+IHdy
b3RlOg0KPj4+IA0KPj4+IE9uIFRodSwgMjAyNC0wNy0xMSBhdCAxMzowNSAtMDQwMCwgWW91emhv
bmcgWWFuZyB3cm90ZToNCj4+Pj4gU2hvdWxkbid0IHdlIGhhdmUgZmhfcHV0KGZocCkgYmVmb3Jl
ICdyZXRyeSc/DQo+Pj4+IA0KPj4+IA0KPj4+IEEgc3VidGxlIHF1ZXN0aW9uLCBhY3R1YWxseS4u
Lg0KPj4+IA0KPj4+IEl0IHByb2JhYmx5IHdvdWxkbid0IGh1cnQgdG8gZG8gdGhhdCwgYnV0IEkg
ZG9uJ3QgdGhpbmsgaXQncw0KPj4+IHJlcXVpcmVkLg0KPj4+IA0KPj4+IFRoZSBtYWluIHJlYXNv
biB3ZSBjYWxsIGZoX3B1dCBpcyB0byBmb3JjZSBhIHNlY29uZCBjYWxsIHRvDQo+Pj4gbmZzZF9z
ZXRfZmhfZGVudHJ5LiBJT1csIHdlIHdhbnQgdG8gcmVkbyB0aGUgbG9va3VwIGJ5IGZpbGVoYW5k
bGUNCj4+PiBhbmQNCj4+PiBmaW5kIHRoZSBpbm9kZS4NCj4+PiANCj4+PiBJbiB0aGUgRUVYSVNU
IGNhc2UsIHByZXN1bWFibHkgd2UgaGF2ZSBmb3VuZCB0aGUgaW5vZGUgYnV0IHdlIHJhY2VkDQo+
Pj4gd2l0aCBhbm90aGVyIHRhc2sgaW4gc2V0dGluZyBhbiBuZnNkX2ZpbGUgZm9yIGl0IGluIHRo
ZSBoYXNoLg0KPj4+IFRoYXQncw0KPj4+IGRpZmZlcmVudCBmcm9tIHRoZSBjYXNlIHdoZXJlIHRo
ZSB0aGluZyB3YXMgdW5oYXNoZWQgb3Igd2UgZ290IGFuDQo+Pj4gRU9QRU5TVEFMRS4gIFNvLCBJ
IHRoaW5rIHdlIHByb2JhYmx5IGRvbid0IHJlcXVpcmUgcmVmaW5kaW5nIHRoZQ0KPj4+IGlub2Rl
DQo+Pj4gaW4gdGhhdCBjYXNlLg0KPj4+IA0KPj4+IE1vcmUgcG9pbnRlZGx5LCBJJ20gbm90IHN1
cmUgdGhpcyBwYXJ0aWN1bGFyIGNhc2UgaXMgYWN0dWFsbHkNCj4+PiBwb3NzaWJsZS4NCj4+PiBU
aGUgZW50cmllcyBhcmUgaGFzaGVkIG9uIHRoZSBpbm9kZSBwb2ludGVyIHZhbHVlLCBhbmQgd2Un
cmUNCj4+PiBzZWFyY2hpbmcNCj4+PiBhbmQgaW5zZXJ0aW5nIGludG8gdGhlIGhhc2ggdW5kZXIg
dGhlIGlfbG9jay4NCj4+PiANCj4+PiBDaHVjaywgdGhvdWdodHM/DQo+PiANCj4+IElzIHRoZSBx
dWVzdGlvbiB3aGV0aGVyIHdlIHdhbnQgdG8gZHB1dCgpIHRoZSBkZW50cnkgdGhhdA0KPj4gaXMg
YXR0YWNoZWQgdG8gdGhlIGZocCA/IGZoX3ZlcmlmeSdzIEFQSSBjb250cmFjdCBzYXlzOg0KPj4g
DQo+PiAzMTAgICogUmVnYXJkbGVzcyBvZiBzdWNjZXNzIG9yIGZhaWx1cmUgb2YgZmhfdmVyaWZ5
KCksIGZoX3B1dCgpDQo+PiBzaG91bGQgYmUNCj4+IDMxMSAgKiBjYWxsZWQgb24gQGZocCB3aGVu
IHRoZSBjYWxsZXIgaXMgZmluaXNoZWQgd2l0aCB0aGUNCj4+IGZpbGVoYW5kbGUuIA0KPj4gDQo+
PiBJdCBsb29rcyBsaWtlIG5vbmUgb2YgbmZzZF9maWxlX2FjcXVpcmUncyBjYWxsZXJzIGRvIGFu
DQo+PiBmaF9wdXQoKSBpbiB0aGVpciBlcnJvciBmbG93cy4NCj4+IA0KPj4gQnV0IG1heWJlIEkn
dmUgbWlzdW5kZXJzdG9vZCB0aGUgaXNzdWUuDQo+PiANCj4gDQo+IE5vdGUgdGhhdCB0aGlzIEFQ
SSBpcyB3ZWlyZCBhbmQgZG9lc24ndCBjb25mb3JtIHRvIHR5cGljYWwgZ2V0L3B1dA0KPiBzZW1h
bnRpY3MuDQo+IA0KPiBUaGUgZmhwIGlzIGluc3RhbnRpYXRlZCBiZWZvcmUgbmZzZF9maWxlX2Rv
X2FjcXVpcmUgaXMgY2FsbGVkLCBhbmQgYWxsDQo+IG9mIHRoZSBjYWxsZXJzIHRoYXQgSSBjYW4g
c2VlIGRvIGV2ZW50dWFsbHkgY2FsbCBmaF9wdXQgb24gaXQuIGZoX3B1dA0KPiBpcyBpZGVtcG90
ZW50LCBzbyB0aGVyZSBzaG91bGQgYmUgbm8gaGFybSBpbiBjYWxsaW5nIGl0IG11bHRpcGxlIHRp
bWVzLg0KPiANCj4gTXkgcXVlc3Rpb24gaGVyZSB0aG91Z2ggd2FzIG1vcmUgYWJvdXQgdGhpcyBF
RVhJU1QgY2FzZS4gU2hvdWxkIHdlIGV2ZW4NCj4gYm90aGVyIGNoZWNraW5nIGZvciB0aGF0PyBJ
IGRvbid0IHNlZSBob3cgaXQncyBwb3NzaWJsZS4NCg0KSWYgbWVtb3J5IHNlcnZlcywgYXQgb25l
IHBvaW50IG5mc2RfZmlsZV9hY3F1aXJlKCkgdXNlZA0Kcmh0YWJsZV9pbnNlcnRfeWFkYSgpLCB3
aGljaCByZXR1cm5zIC1FRVhJU1QgZm9yIGNlcnRhaW4NCnRhYmxlIG92ZXJmbG93IGNhc2VzLiBQ
b3NzaWJseSB3aXRoIHRoZSBsaXN0IHZlcnNpb24gb2YNCnJodGFibGUsIGNvbnN1bWVycyBjYW4n
dCBnZXQgLUVFWElTVCBhdCBhbGwuDQoNCg0KPj4+PiBPbiBXZWQsIEp1bCAxMCwgMjAyNCBhdCA5
OjA24oCvQU0gSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4NCj4+Pj4gd3JvdGU6DQo+
Pj4+PiANCj4+Pj4+IEF0IHRoaXMgcG9pbnQsIHdlIGhhdmUgYSBuZXcgbmYgdGhhdCB3ZSBjb3Vs
ZG4ndCBwcm9wZXJseQ0KPj4+Pj4gaW5zZXJ0DQo+Pj4+PiBpbnRvDQo+Pj4+PiB0aGUgaGFzaHRh
YmxlLiBKdXN0IGZyZWUgaXQgYmVmb3JlIHJldHJ5aW5nLCBzaW5jZSBpdCB3YXMgbmV2ZXINCj4+
Pj4+IGhhc2hlZC4NCj4+Pj4+IA0KPj4+Pj4gRml4ZXM6IGM2NTkzMzY2YzBiZiAoIm5mc2Q6IGRv
bid0IGtpbGwgbmZzZF9maWxlcyBiZWNhdXNlIG9mDQo+Pj4+PiBsZWFzZQ0KPj4+Pj4gYnJlYWsg
ZXJyb3IiKQ0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVs
Lm9yZz4NCj4+Pj4+IC0tLQ0KPj4+Pj4gIGZzL25mc2QvZmlsZWNhY2hlLmMgfCA0ICsrKy0NCj4+
Pj4+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+
PiANCj4+Pj4+IGRpZmYgLS1naXQgYS9mcy9uZnNkL2ZpbGVjYWNoZS5jIGIvZnMvbmZzZC9maWxl
Y2FjaGUuYw0KPj4+Pj4gaW5kZXggZjg0OTEzNjkxYjc4Li40ZmI1ZTg1NDY4MzEgMTAwNjQ0DQo+
Pj4+PiAtLS0gYS9mcy9uZnNkL2ZpbGVjYWNoZS5jDQo+Pj4+PiArKysgYi9mcy9uZnNkL2ZpbGVj
YWNoZS5jDQo+Pj4+PiBAQCAtMTAzOCw4ICsxMDM4LDEwIEBAIG5mc2RfZmlsZV9kb19hY3F1aXJl
KHN0cnVjdCBzdmNfcnFzdA0KPj4+Pj4gKnJxc3RwLA0KPj4+Pj4gc3RydWN0IHN2Y19maCAqZmhw
LA0KPj4+Pj4gICAgICAgICBpZiAobGlrZWx5KHJldCA9PSAwKSkNCj4+Pj4+ICAgICAgICAgICAg
ICAgICBnb3RvIG9wZW5fZmlsZTsNCj4+Pj4+IA0KPj4+Pj4gLSAgICAgICBpZiAocmV0ID09IC1F
RVhJU1QpDQo+Pj4+PiArICAgICAgIGlmIChyZXQgPT0gLUVFWElTVCkgew0KPj4+Pj4gKyAgICAg
ICAgICAgICAgIG5mc2RfZmlsZV9mcmVlKG5mKTsNCj4+Pj4+ICAgICAgICAgICAgICAgICBnb3Rv
IHJldHJ5Ow0KPj4+Pj4gKyAgICAgICB9DQo+Pj4+PiAgICAgICAgIHRyYWNlX25mc2RfZmlsZV9p
bnNlcnRfZXJyKHJxc3RwLCBpbm9kZSwgbWF5X2ZsYWdzLA0KPj4+Pj4gcmV0KTsNCj4+Pj4+ICAg
ICAgICAgc3RhdHVzID0gbmZzZXJyX2p1a2Vib3g7DQo+Pj4+PiAgICAgICAgIGdvdG8gY29uc3Ry
dWN0aW9uX2VycjsNCj4+Pj4+IA0KPj4+Pj4gLS0NCj4+Pj4+IDIuNDUuMg0KPj4+Pj4gDQo+Pj4g
DQo+Pj4gLS0gDQo+Pj4gSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4NCj4+IA0KPj4g
DQo+PiAtLQ0KPj4gQ2h1Y2sgTGV2ZXINCj4+IA0KPj4gDQo+IA0KPiAtLSANCj4gSmVmZiBMYXl0
b24gPGpsYXl0b25Aa2VybmVsLm9yZz4NCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

