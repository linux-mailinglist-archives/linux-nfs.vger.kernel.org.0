Return-Path: <linux-nfs+bounces-4006-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9F090DCE8
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 21:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398222844B2
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 19:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB7A16CD39;
	Tue, 18 Jun 2024 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CrryI1GO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mAlZ8I9h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDC015E5BB
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740500; cv=fail; b=Op7iAANV5CXi6GxG+RyO5m1fk+Sl+wTOh5UYUVib8/DoYGSAiFkOrA/03tjvbPShGK7UvLp7AJlpE2yHNWocN8c2Yu/GYCtdjVUUJNIOUJsYoutDd3+Wge+nhbqDGiR9731ijWN4EUkffB0nXNRapZTapDLTrYYFNFFW9Dv9cIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740500; c=relaxed/simple;
	bh=uK1XKfSV4QJ9YW3jep9kSG3o6dVZrmUxAiX3PcKPR2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t7rZbxZ9aSatVOLmEidaBjaXLVVpQBBuTAwkY9N9hPJXwd4ZOpclOsACCCPDK+d866t4awxthYhMN8F9OQxyOhe5hiBKnVjju+b2exB473gQkpraPYg9/0+qrliWMJoyNym4DtTPfy8Wb6g1/Qnryzx08ivgHSgt4CjhAYmEFzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CrryI1GO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mAlZ8I9h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUqra027364;
	Tue, 18 Jun 2024 19:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=uK1XKfSV4QJ9YW3jep9kSG3o6dVZrmUxAiX3PcKPR
	2s=; b=CrryI1GOXIZQYjHmnkt0TMM93rAnPcuyn7+uIE3cvOvVoAD9Q0A9FhokB
	jj3FLsebtmVVlzEqv8XnWvEnfnxYKy/4rTsVIE8aBglsyajqYc1ixW9UiOgkj/eg
	Q/N7QpXvBDhEwbxufdFu6XO233uBtbww40Glf5zm5ushP32WEmsGcpjG8Oeb8cY4
	we2wTn6dm1aCQEvNlDdyVPjvVphR6wGC0ppJarunqPcK+dfNV8lIKOIy/hJG7AGo
	fY2fNRno0dg4uWDb/HHwIkeBJiAKVICQgnp1wThiJjVEZIJk1XWV8VjzRan5SO/U
	DZ+yNSyqFIEoQkipfZ2TZDj53pNtw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys30bnss1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 19:54:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IIpAfY014937;
	Tue, 18 Jun 2024 19:54:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1denwm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 19:54:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyAkhKN/ruASY5QAjjEIBJn9lrjpOu93cwEHzpsvYej0lHmUAIAWemFvq2is9p76bZq1SGkk2zaFfmjlexpPcQ6Xd4CAQMci2Ludn3zN/aPk+CRRjKVbYE1dHNIhP1n3swckhFPtGadlR8cQHKQyvYStpJoaO+6K1mRj4AFwSSkGdzy49q1aKthWYLyf9RmBbVyaPcTVccR3MlxpNa220JvS8+t0IQqwN/PUx1HBcAJ+6TAbt2z+pi0e+GxVSRq64i16FXSXq6hqzfSZEknDGEYYPhskrQsWjwp15gBPlZk5r9EJ9nFVwf9xp9aMaj4BkkdDuZ6wSouzagRi0n8Jlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uK1XKfSV4QJ9YW3jep9kSG3o6dVZrmUxAiX3PcKPR2s=;
 b=haIN/bVZAtCGF5MSZZhZRoLNThJ6dq/jd/hge7JWPHK6EPs5PkXppJQ7k4zlLMbHBIk/UD4ndm8qsMY7gBbiWjFzZBiXtYuCPEQiEVuSDp8cOUCWaduAJf76LCx/OEVGylrUbxNNrZaPsygUhfY5pKqq5xh57gomjYjXsD/3WDaHgSe3K+kc7JfHsVbwFhOriPWtPl8vEo3AL9/hEb9rcLUhd173qkV9eEkH6OVmpcYskSBI0FW63Vf9WhV0Q5pMM2BmvyZjk+TvIb7U0EYdTEczcn0xP00BFNkn2ptZ5rzI9WAjUyXXJ4vEl20mD2g/v2L8WTO//Nw/esdZfPsgeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK1XKfSV4QJ9YW3jep9kSG3o6dVZrmUxAiX3PcKPR2s=;
 b=mAlZ8I9h/pOXhBTUraLUxUNksZkGnPbxOKwZ+lfeB1l+2zpf0w3eOZrYp4Vs8u/Kwmx/Z7O6EjloDEZ8j2Wv0oGk1ltW//bD+it2hgPLfGJrHxnwXky0gptdhMRUU9ELDTeuxT9rgSAmKy1Dwy/ELawKG5nq6RQRCZ3B24omdk4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4799.namprd10.prod.outlook.com (2603:10b6:a03:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 19:54:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 19:54:43 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>,
        Dave Chinner
	<david@fromorbit.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        "neilb@suse.com" <neilb@suse.com>
Subject: Re: knfsd performance
Thread-Topic: knfsd performance
Thread-Index: AQHawa3dybcUo3ed40e1woBUDQls6LHN2rIAgAANu4CAAAKdAIAAAygAgAABH4A=
Date: Tue, 18 Jun 2024 19:54:43 +0000
Message-ID: <7F7971B5-C7C8-4D0B-99CB-2D6CA8235FDD@oracle.com>
References: <313d317dc0ca136de106979add5695ef5e2101e7.camel@hammerspace.com>
 <58A84B36-C121-46F8-ABCB-BE4F212E9C81@oracle.com>
 <754f3e0f6f962cbd46b2b22e87d9de9f8b285ab4.camel@hammerspace.com>
 <7FFACD6E-86D2-4D14-BF03-77081B4CFF38@oracle.com>
 <70766c4bd70742d0da79be50ebaf2eaeb7b18559.camel@hammerspace.com>
In-Reply-To: <70766c4bd70742d0da79be50ebaf2eaeb7b18559.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4799:EE_
x-ms-office365-filtering-correlation-id: 79f5cc41-482e-4bc7-bd0e-08dc8fd07f69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?K2NjdGhDMVdzaENRNGtvbCsxNURFb0VSVlN6UFJiYTlqMU5yL2dJdDROUTF6?=
 =?utf-8?B?eW9OWXZiTXVJdzVWYzJxdzN3YU02c2t2YnRhL2RsWDJXTyszWjM5YlFZbWUw?=
 =?utf-8?B?WFh4ZXZ5RVh4S3plTHZvUWJMbUdHTHl4R3J4bHpId1B0Y0tRbGp2T2tzUStV?=
 =?utf-8?B?RXB1UGtPZnpyNFJZUFhaVENIazNoeDY5Q0RHQ3JsR2RyU2FvZlZUVFBtZ05x?=
 =?utf-8?B?ZGtyV1R3NnhxMEorcVJNNHZ2RFJ2YWJkY0R4SGU3U2tVKytJazJoVHZScnBj?=
 =?utf-8?B?dy9kMnJCU0VIbDZ0VGc4V1c0SWE0bFNRMFlZU1FQMHZNUEV3ckNOM09iamFk?=
 =?utf-8?B?MTZScW9DeDM3b0lnWlZYcnhxN3BMSUZtdVhkV1AwME5zbVFmRWZSOXdyYTc5?=
 =?utf-8?B?Zkdja1NXVUpQbHJRSnlsTUluNEhyTy9HRE1CZ2VCVkg4dFlaSU1xbitUbk9C?=
 =?utf-8?B?cjFMMlBKMkZtUytzcG0wcDR5TTZyU1pvZldLZS9NUTN1TEEvTHNjY2piRDRa?=
 =?utf-8?B?alI0R0MzaEZBalB6cEcxR2JKbWhMVXR2V1NLZ0pBb09TcktkSkw3d3hEMURR?=
 =?utf-8?B?MnUyN0VocHBIK1NXU3FRSmtjaXdVNXhYZlBRK01XVFlleFh4ODZsNjVEZW01?=
 =?utf-8?B?RGlCVk5zV0g0Z1JVQ2xwMllKVmpYYjFBSUo4MHhSeVcwcEFrbmxVc2lDbkk4?=
 =?utf-8?B?NlA1Z2ZKcllCNVJGZllWcHJCTWIvN3djSDYyeWlFN1VxeWJkOG9IR2pkMitl?=
 =?utf-8?B?UEhlR1JHVzVDdFhVR09lckhpY3N0SFNqR3g3OGhSczZ3b0tGSWxIUlZVbk1C?=
 =?utf-8?B?ZE5RZ1V4Z2p4cWhPRUorc3craC8yOGdUUmU1ZVFVUmFiVDEySit4aDdpZjdr?=
 =?utf-8?B?Zk9Kd1BTdkZ0ZENMRlhabDJaaHpEODVwaDZqRU9ya2ZoekxldWlBOEFjbm5B?=
 =?utf-8?B?dExSRHQ1bjJ3OHYvcTB2dnIxR2lZT1V1SnVsanZmMjYycDgxbUtCUWpTeGM3?=
 =?utf-8?B?b25CQ3RRTFVBVFdlVUt4VFhsRDQ1RFNyNW9tczVnM0gvRHRvVENFUisxbDNF?=
 =?utf-8?B?ejk0eDJ5N2xKL3VwazNrNUtrMEkxSUtRR3hWaHZHY2hTSXg0alQvNUR3Mkdr?=
 =?utf-8?B?SVFyaTNiblNNTmtDeXVSOWx3VTFKMXkwdVMxYUlJWGFvZE1seERNSmRBM0tl?=
 =?utf-8?B?VmxBUzdDUnpyaTBLRUo0UHRjc05ZV05PNm5HMjFrdVFSa25GMmt3MGN3SWNt?=
 =?utf-8?B?NWdEeEU4MHcyUmNzaVBQSWFSdGxldmtsbFp6NUJHREo0aDViMnBNbHJzbFMy?=
 =?utf-8?B?REZRQkZLTTY3ZWR2VDN3aytXOXF0d2t5bUNLUWF6V21qcmNsa014SXJubWFw?=
 =?utf-8?B?Rmh6bkRnTGFxeWRRMkJhMjF5UG9ISUVlNnlLT0ozK1NIODJHUTJKajJJQkhy?=
 =?utf-8?B?czI0RHpQVllGT0ZiM3dGd2lzQ2RKOEZKM1NKRE1xSzFDdVgxejhoTVUxMEc4?=
 =?utf-8?B?OVBLUWFqbXExQXZrZEQrc3grM0xUekhHRFdtbTVzMEpMNUQrRGdVeFVoeEMr?=
 =?utf-8?B?MTUyZEk0K1NYSkMrbkgycnVkUnVKbk9RSHB5MFhaeGIxWXlJdkdGemIvOGJr?=
 =?utf-8?B?azY1cHhLdWkvYUowcmc1Y0p4cHpYNGs0QXFZbjl3UUU4VWZ4U1hVcVIvRzBP?=
 =?utf-8?B?SzJQVjhIZ0FVRVV6UEhPTDR1TDNTVS9DNXJvaXJ2OVpqTmtGWVZQWjhTNG1T?=
 =?utf-8?B?bnZKSEhkSEZYbCs3RlRjTkdDcExMR2JGNnZJdHpGM0EyeWt0TGhYMzA3Nlp2?=
 =?utf-8?Q?JmEXMN6MbGNbtl8ki+Cnc7SgDp/UgjUn1YvCg=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?b0RzdDBReEJGSjQybzlxKzRCcVdTRS9CTFRRcVF3U3h2UVZDWTM4SW95OHk4?=
 =?utf-8?B?Z3pDeXM3NkwrKzZ3SmdkQ1JvZHVNdy9NTnBSUmZaMEpaSVdYZDlvc3gzT1RD?=
 =?utf-8?B?Qjk2M3l3eWJkRExZQVcvbkYySW5YejRRZElvbkZGTUVOUFhnL2oxZ2hKUU9C?=
 =?utf-8?B?MHB3RHZXd3BRYmRRcHRxNVlvQlBMSHp5d1gzTDBtc214bW9rYkpzME83UlAy?=
 =?utf-8?B?ZS9odVQva2VQdzhPWUtpZThrSFdkRk5YS2tFL1hJMzhWaVN1RHQ2OTBLSXVV?=
 =?utf-8?B?blkxRThia2N6S1dXN0JWeGd1Uk1Ib0JndHZOK2N1SDMvN252NkI4dHlIdjJw?=
 =?utf-8?B?RHl6RlZ5NDl0cHVzQXZkdXArZE1uRU5iMTZJWW5IVnZMUlBUOUdKM2dmK3VZ?=
 =?utf-8?B?cUlJOEc5SjNpSk9QYkt5Yk9HVUZMRmp1d2NoK2JhbmpEZHoya2hCQndRWVZJ?=
 =?utf-8?B?Wk4wY0F6dzhQc2dYN0lWSGZLVS9sT3creE1iVkxtUFRlbk5POE5pWWxzcFF2?=
 =?utf-8?B?M3VuMHZFU3o4MWoyaW50MldpenFqMFpmWGFlZXZPeTlIZWFyS2pXVlpqTWQ0?=
 =?utf-8?B?aGhOVVlJRjdqeWlLVjlReGQ1MlY5THFRVHIySUV1ZlNrVkZLdC9kNzdXSkdR?=
 =?utf-8?B?dGRXSm9ZNEZIV044ZFBqMUR4MnJYUjRKaHh3bjh0NndRTEpmTWUrWXZlS3Iy?=
 =?utf-8?B?eXduUXp5eU94eHdmTzdrTFh5amY3RTBEZlUzVGpoVk5MQmdSUU1rMHl1WC8w?=
 =?utf-8?B?Tm5xdVN1Q1RKNHllc0RvMWgwVFhtcW9IL09HMGhQMVdacGRJS0JVQ1ZpS2d0?=
 =?utf-8?B?am9qUkxTbE9YNlhoM0lFRlBaaXZSaHpDZWNkMG9yOTUzay9ya25uMFd5cjBZ?=
 =?utf-8?B?Yks0NlFhdzBhYkZOVDd3dXRPK21US2JGNUx0dTNCMHlEdi8zOUJmSFBjdCtn?=
 =?utf-8?B?cmJOTEN2YzBsVlNEQXQyMGpHbkhxVGFHYnJ1aEpsVGoxV2pmYVNpT1NFQ2tX?=
 =?utf-8?B?TU5NQks1bnVKQS9ubFdMc05MWDFhV1E0aUdjdjhlamxhVzlqZTJlVklFd0pH?=
 =?utf-8?B?SGV4cXRnUDNjZDBIR2doWElleFZrWldHaC9VS29lRnppcXlOcjdUdWpzek9I?=
 =?utf-8?B?dFl1QlRMVDNQdTdlZmJWY2ZYQlorYlFwRjNRbEl4Z0dhb3RlSTdzejlxODdz?=
 =?utf-8?B?SGtpMjg0OXpvT0tCVktVZk1HMGhhWGVObWs2UEY3ZVFGZEJ3WFJyZGtZL2x5?=
 =?utf-8?B?Ui9QNWk1cjJwMG9mVE9mSWZObUduMGNheVFXbFhsV2wyaHJsaHJ5ZnRWUlpI?=
 =?utf-8?B?ZmZraGQyMm9XSkhQOEpDckcxV1RDdm5NME0rdFRxTnMydG9KczhDRHdMbmt2?=
 =?utf-8?B?MWVOVEhpN09FUGEwekJTOFF0R29HQzdWQ29QSURGeDZtZ2I5cVNPM25DQ0sv?=
 =?utf-8?B?bnhnRVpmS1FHem5TWlZhcXI4aWhvb0NpMU1uTkRiZVNzZjZ4Uzl6dWVNWElz?=
 =?utf-8?B?UldaajV4Q3Uvcmh3WGVNdjZxWXZINmpFY1JCNG5Kd01yV1hMWGphZ3h1OGdI?=
 =?utf-8?B?TENFWDNYZWtidkQxVDJ4bVIzalpBdmtHZ3VwTDhXQzYzbk9wajZLTm1TaDJs?=
 =?utf-8?B?TllPY2pNb2M0K0dDcU4xdkZKNThCSnI1WjlKZGZ4MWpud2pBUUVGRnJIWGxV?=
 =?utf-8?B?ZGRpM0o2UXlIYVhSczlSZmppbFNrZ1JiaFFhUEZ3enVRUWl4YXFsWXZoSEZZ?=
 =?utf-8?B?NDZrTi9ZSy9ldUh3Q2UvUGd2dUwveXhpakVNOTFxWTVYL2l0emQySzc0ckdB?=
 =?utf-8?B?RG9WWXp0eDRnaVRJTHJ1MDNqcGtsSXRjMFpBc3FXZnZSRGhIR3RLbTd2bGtl?=
 =?utf-8?B?Z1ZHNUp4c29SSFRMNEUrSlhNaFVWdUpmOEZlU2xONjNnWXBONXFWdmdtbnNk?=
 =?utf-8?B?MCtHbWdjSkl3N1YwRVF1aExydm9NVWs2aUhWaFNodDMwNVhNaU9TekZUVzhv?=
 =?utf-8?B?TEI0dUp1UUZ2eHZ3TTBVYWJxOEUyaWZNV1FUaTExQ1ROS0o1TEhWZms5YzhJ?=
 =?utf-8?B?N2dBTDhOVlpBY0RENEYza1J4elpRbzBoUEwwNy9DZndHdGExWm85elFKQW94?=
 =?utf-8?B?N2JnS0hiV1dBVGpWdmZxRlRPVUdnNUIzdGNFMGZTcDBHaGtVNHpGVWF0OFFJ?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45731ED452561443A47FD2589297CDB6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rtP98IBwLbO/2aub6IQ+bgCoOdLD6FKV7KnSotCSKi7WviF2qqb4w/jOKpmQQ1PyXVkyaYwwn3KKmwQjnYMUP62aPxXROog/YBM5HWDe77nRMjAXbjW2ugcWc0uM6PhmgMmetb+cRQExOwPz5kAInk1eyw+VkbxctSYDgUsoBJWNFl8+xcTgHBU+lGE3ZcuVUQ5Wq8vX/MlRzg/HvBL4O4Gbzlpeu/I9z3kfPTu43qG3tsHWTQuN2dn6FFJ/zJ6l5PRQ1tWo9s9osAlcCdoE6qIzBjWp+hJlBAB5OcWgL7DvwALuSU3wuI+cPyljX3/m79mRuzgIO5LnR2398ma6vpWB+R8uOGblWNcTCKbSv/HrBxBs/mO4nhuBK/rS6w/HIhWD7UeaF7yC0eDW4Lum5fFjfjMQFj6Xcrh2ymwcCIFDQ3rfck0vPJUHt/AnCb9K1ZAfvfNa+RB84V+No8w+7FwBmELif8knqhkt76BvK3gdLajd3yh6kDPb2b+vArS1+xG5eAYlrgl4X4LuIUijfOTXh9+GkLOpTp5EnzNQ3uC6XMj8t5NRf2B6I50E4tj2yUEDjNi8opZ8aaXNvI+7dqa8Fa91xJ+nhXpRSt6wpG4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f5cc41-482e-4bc7-bd0e-08dc8fd07f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 19:54:43.2988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6DcH7tAXr6oJWLZ6VB1sK4K+LsWf9lO/hvw5VPiP222hzksLJ7GrRKBO8Aa3gI9wOkdLqi9NZwzuGRlPkQwNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_03,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406180146
X-Proofpoint-GUID: fh2eXfpRTg0j9NWE1OuJ6P323-2mv8ky
X-Proofpoint-ORIG-GUID: fh2eXfpRTg0j9NWE1OuJ6P323-2mv8ky

DQoNCj4gT24gSnVuIDE4LCAyMDI0LCBhdCAzOjUw4oCvUE0sIFRyb25kIE15a2xlYnVzdCA8dHJv
bmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAyMDI0LTA2LTE4IGF0
IDE5OjM5ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEp1
biAxOCwgMjAyNCwgYXQgMzoyOeKAr1BNLCBUcm9uZCBNeWtsZWJ1c3QNCj4+PiA8dHJvbmRteUBo
YW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIFR1ZSwgMjAyNC0wNi0xOCBhdCAx
ODo0MCArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4+PiANCj4+Pj4gDQo+Pj4+PiBP
biBKdW4gMTgsIDIwMjQsIGF0IDI6MzLigK9QTSwgVHJvbmQgTXlrbGVidXN0DQo+Pj4+PiA8dHJv
bmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBJIHJlY2VudGx5IGJh
Y2sgcG9ydGVkIE5laWwncyBsd3EgY29kZSBhbmQgc3VucnBjIHNlcnZlcg0KPj4+Pj4gY2hhbmdl
cyB0bw0KPj4+Pj4gb3VyDQo+Pj4+PiA1LjE1LjEzMCBiYXNlZCBrZXJuZWwgaW4gdGhlIGhvcGUg
b2YgaW1wcm92aW5nIHRoZSBwZXJmb3JtYW5jZQ0KPj4+Pj4gZm9yDQo+Pj4+PiBvdXINCj4+Pj4+
IGRhdGEgc2VydmVycy4NCj4+Pj4+IA0KPj4+Pj4gT3VyIHBlcmZvcm1hbmNlIHRlYW0gcmVjZW50
bHkgcmFuIGEgZmlvIHdvcmtsb2FkIG9uIGEgY2xpZW50DQo+Pj4+PiB0aGF0DQo+Pj4+PiB3YXMN
Cj4+Pj4+IGRvaW5nIDEwMCUgTkZTdjMgcmVhZHMgaW4gT19ESVJFQ1QgbW9kZSBvdmVyIGFuIFJE
TUEgY29ubmVjdGlvbg0KPj4+Pj4gKGluZmluaWJhbmQpIGFnYWluc3QgdGhhdCByZXN1bHRpbmcg
c2VydmVyLiBJJ3ZlIGF0dGFjaGVkIHRoZQ0KPj4+Pj4gcmVzdWx0aW5nDQo+Pj4+PiBmbGFtZSBn
cmFwaCBmcm9tIGEgcGVyZiBwcm9maWxlIHJ1biBvbiB0aGUgc2VydmVyIHNpZGUuDQo+Pj4+PiAN
Cj4+Pj4+IElzIGFueW9uZSBlbHNlIHNlZWluZyB0aGlzIG1hc3NpdmUgY29udGVudGlvbiBmb3Ig
dGhlIHNwaW4gbG9jaw0KPj4+Pj4gaW4NCj4+Pj4+IF9fbHdxX2RlcXVldWU/IEFzIHlvdSBjYW4g
c2VlLCBpdCBhcHBlYXJzIHRvIGJlIGR3YXJmaW5nIGFsbA0KPj4+Pj4gdGhlDQo+Pj4+PiBvdGhl
cg0KPj4+Pj4gbmZzZCBhY3Rpdml0eSBvbiB0aGUgc3lzdGVtIGluIHF1ZXN0aW9uIGhlcmUsIGJl
aW5nIHJlc3BvbnNpYmxlDQo+Pj4+PiBmb3INCj4+Pj4+IDQ1JQ0KPj4+Pj4gb2YgYWxsIHRoZSBw
ZXJmIGhpdHMuDQo+Pj4+IA0KPj4+PiBJIGhhdmVuJ3Qgc2VlbiB0aGF0LCBidXQgSSd2ZSBiZWVu
IHdvcmtpbmcgb24gb3RoZXIgaXNzdWVzLg0KPj4+PiANCj4+Pj4gV2hhdCdzIHRoZSBuZnNkIHRo
cmVhZCBjb3VudCBvbiB5b3VyIHRlc3Qgc2VydmVyPyBIYXZlIHlvdQ0KPj4+PiBzZWVuIGEgc2lt
aWxhciBpbXBhY3Qgb24gNi4xMCBrZXJuZWxzID8NCj4+Pj4gDQo+Pj4gDQo+Pj4gNjQwIGtuZnNk
IHRocmVhZHMuIFRoZSBtYWNoaW5lIHdhcyBhIHN1cGVybWljcm8gMjAyOUJULUhOUiB3aXRoDQo+
Pj4gMnhJbnRlbA0KPj4+IDYxNTAsIDM4NEdCIG9mIG1lbW9yeSBhbmQgNnhXREMgU044NDAuDQo+
Pj4gDQo+Pj4gVW5mb3J0dW5hdGVseSwgdGhlIG1hY2hpbmUgd2FzIGEgbG9hbmVyLCBzbyBjYW5u
b3QgY29tcGFyZSB0byA2LjEwLg0KPj4+IFRoYXQncyB3aHkgSSB3YXMgYXNraW5nIGlmIGFueW9u
ZSBoYXMgc2VlbiBhbnl0aGluZyBzaW1pbGFyLg0KPj4gDQo+PiBJZiB0aGlzIHN5c3RlbSBoYWQg
bW9yZSB0aGFuIG9uZSBOVU1BIG5vZGUsIHRoZW4gdXNpbmcNCj4+IHN2YydzICJudW1hIHBvb2wi
IG1vZGUgbWlnaHQgaGF2ZSBoZWxwZWQuDQo+PiANCj4gDQo+IEludGVyZXN0aW5nLiBJIGhhZCBm
b3Jnb3R0ZW4gYWJvdXQgdGhhdCBzZXR0aW5nLg0KPiANCj4gSnVzdCBvdXQgb2YgY3VyaW9zaXR5
LCBpcyB0aGVyZSBhbnkgcmVhc29uIHdoeSB3ZSBtaWdodCBub3Qgd2FudCB0bw0KPiBkZWZhdWx0
IHRvIHRoYXQgbW9kZSBvbiBhIE5VTUEgZW5hYmxlZCBzeXN0ZW0/DQoNCkNhbid0IHRoaW5rIG9m
IG9uZSBvZmYgaGFuZC4gTWF5YmUgYmFjayBpbiB0aGUgZGF5IGl0IHdhcw0KaGFyZCB0byB0ZWxs
IHdoZW4geW91IHdlcmUgYWN0dWFsbHkgL29uLyBhIE5VTUEgc3lzdGVtLg0KDQpDb3B5aW5nIERh
dmUgdG8gc2VlIGlmIGhlIGhhcyBhbnkgcmVjb2xsZWN0aW9uLg0KDQoNCi0tDQpDaHVjayBMZXZl
cg0KDQoNCg==

