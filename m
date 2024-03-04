Return-Path: <linux-nfs+bounces-2179-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BD9870AC4
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 20:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF63A286A63
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 19:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9694679DD6;
	Mon,  4 Mar 2024 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IstXizse";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XW4dWXET"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F2179DA5
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580837; cv=fail; b=IEv0AKaVR6wXAZgpvfVnEIyPUtEZ6y5d64fhLw3JZor0rURg6fIyyw1WYRPYKsjRBnu71IUbgJEn0iIzYARCV+fyTZvmk4ND0TPOR1hyU75uCY4KHIydhcrJa9jy3Cx5pvuuFzzjtbsrqnMkS5/Pj19y7512OCnC6CVoUCgHo4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580837; c=relaxed/simple;
	bh=Hmz2HJQEyaB+t3fcvihFjOIvBhaPuOcGwI+mI5mIuGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QF2j1b4OTsKThyOlU4CzlDnM4eNG4T3cNImafZsYSPxpwc9UppzERBj48UicZ5ft/ro+O/CKwSq+dG5lClLZIKyvT8kcD0ZZ52+gSDno4atD5F8I3CNshMx5Mc5PjnnRu1bm8vbgDeBrRabtDfVegr/YJ7OtV4T8b+4NwkYggiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IstXizse; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XW4dWXET; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424IxkZl031605;
	Mon, 4 Mar 2024 19:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Hmz2HJQEyaB+t3fcvihFjOIvBhaPuOcGwI+mI5mIuGk=;
 b=IstXizseWGXoU6eVT/BQw7pRhXCKIdFUsIc9+tokUD8COV95wbZAOLRfSQRqWwqY0yai
 ByUkU4oWvLtUQf3SPdRcIZY6KT/4fTlHwNfJu+FpGjMwj8gZ4qjJppp1E6+aRBUxlWKU
 lmbPICleB8UVO02gZnYgyhyfSEkFeaxjRFAzqDcSMzki+lg5n7sLXxS5qxvRZ7XJ6lNw
 G1BZrIez1LItpe6+yWWrgA80vGHqnp8GmjPuD0pM1NXwCl3zROJMcmDaE19HfI30KWTq
 1cmchBH1DTODoVx2J2+Ci6x9cyVZ3tnPPIAWW7Sm4JSJdG7sSaGTOsI1qzSJ43z0bawz cQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkvnuvfmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 19:33:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424I2r5t018921;
	Mon, 4 Mar 2024 19:32:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj69t1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 19:32:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFyE61jzOICuIGZ/c6X5vImGAHi3OVEcKpWFSBuvpUW1cUHMZyZw+asHnmXMqfUC/rqC1d1DYwsHUMknZRBV4EW2Mb77GZ/Sbnuo2XpM8WiWyAel44CvQ5/VNTlO2GzGScRXa10uZgsXKxirXlAgcRtaqGufRfI3GR9u7dkswnntsn7d/U+1M+noJ7mP9aTwmRs9mXC8U6BUjAKUtYTtnFWjyVICLHbUdf7ATnmfXH+QibC5aQojfokKRvwDyBpEMfg6dR2MSuYlIEoumCeXUDfds9Vre0ndGsfY0qTiyV3Qxpz2LqCrOV1S7Hbi6PAKZNYZuPoB8RopOCy2gjGHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hmz2HJQEyaB+t3fcvihFjOIvBhaPuOcGwI+mI5mIuGk=;
 b=XTJ9Mo+LrDQxcAQwiRUUuNg28GogZgHFapury2hUorJ0h3xYRLPAx7rMtUO1FkOM7EcxDl365yGSWyoaPWWjNgldGKx6yKqWCpSszPJKYqotYniNkbML9cm28idUHK7RWae4IxGYnopKipXwGUSUL1hALxJdDQfktGQg9k/mCN+eapeIwMYNIlELv7XFURtTmwRK6RyKH2qXDAF3O93WG/rPGBxm7v4zYayzLbdG0yPOcbTufgF1kk2idrN5w4QKppt9/kNsq1Fl5gBn6Z62Va91viOLahH3/+cEq1qFk14L7vEXQU1NPXzF6zrCHK3yB5JOs5jNLtjH1R0yh2hNBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hmz2HJQEyaB+t3fcvihFjOIvBhaPuOcGwI+mI5mIuGk=;
 b=XW4dWXETQDYOQV5kCW6LzXjxftd0bs8DeIFPi49vbJTxbqSiX8wTAimu2Gvn5ENOPmA593gAdZ388YXND4GYSAoqmTMd1UxbGrrkIt/ACJ3kCnae+3BIeZpcw22/Y0of2CQPVG+LW9c7KLecFrt0kNdGZcYLDDSIc1lFU5vIx/0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 19:32:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 19:32:56 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Olga Kornievskaia <aglo@umich.edu>
CC: Trond Myklebust <trondmy@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: enable nconnect for RDMA
Thread-Topic: [PATCH] NFS: enable nconnect for RDMA
Thread-Index: AQHaao72xnTeniJsCUKBfHo9wuyOUrEmCiAAgAHtj4CAAAipgA==
Date: Mon, 4 Mar 2024 19:32:56 +0000
Message-ID: <51189037-DD10-4806-8596-D4374067FDFB@oracle.com>
References: <20240228213523.35819-1-trondmy@kernel.org>
 <ZeTC2h59TXUTuCh_@manet.1015granger.net>
 <CAN-5tyH2dkLbt9dMau46ebrU=PfvLgo2=mr8u3_C1gUnAGM_ow@mail.gmail.com>
In-Reply-To: 
 <CAN-5tyH2dkLbt9dMau46ebrU=PfvLgo2=mr8u3_C1gUnAGM_ow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4623:EE_
x-ms-office365-filtering-correlation-id: 90a2c78d-d30a-4151-9414-08dc3c81e472
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Qv/UZXtejqBZ9Zvdub5kW26LrNPkZUJ0aWUpj1HWGyPX5lKwW9DDiIWUIXPNqWZUB1VtkmUJ45c5+Y2VFkvAuexiL+hRm/nwj30HdjrA5Rd6aRyt0JEvn6O0VOhC8dnwTjRXBsKf6Ra5IskmQBFVWex0AP0DSJTQUMgguJqjGFKF2ciJH73O9D3JDzIwCw4bqJOba2iCDtxu1hNrkyukiPA4RJkfcZVuoFgst29cVeufm5yFR8W+cdukJ8+LkpSpP76td2r9DLZfM/mejmr6NXc+v1NCkmce1QjKM74B3iPCTt3SXTNFV3h/LCVcPqgp465H2TDJiIClvidcvu4NVYMgP+QjTN/rwpE1+jZlkRFi5Bkbpv7kRf5f2cGHrX57NA9MKY6l3ucXQUnmV8L6+XNN1VaJNM0zpzvbpPZFKq0COtqrDoXey4bYIlkUpWchknkcBuLctqJcJJ0oYfzzrAA9CZmpuq+9jnyG8IN8MIxVHiMOInNM/ZJAm6XEjk9AZBDiuz1sCq8d8ZEVyLJ0naUkQCtAYxoPBXPFXvzT6vXn+xAWCzvFHaYzEQOmfchNQRlFDzmjuZfAGd6QVBorQJM2b9yXPaNxsgEC/I6kZvF1p7zJdVVyeUMi+6vePnVN4H/UXaDfxSuRbDkO6dWNPspzOYa9x3UDYR4JQwkvYNxY4WlCgn8qh4e4TXLHLDqvpOZv2ot5ODWQCsxTOuhcBg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aVJ5NUgxZzNmSnJ6ZkVuelhodFBvRmNSeXR3OUhOYVBvb212NThwb3FCUUJH?=
 =?utf-8?B?bjlJTldsVnZjTkdVQlgyQkVFQ0JoSUVHVk9uTlFLUEZQN2lZY0NObk4zQlBC?=
 =?utf-8?B?TU1PekpTTkpqUVJpOXUyTXh3QUlyU0U4MittemwwWGZSYmkySjZIMmh4L1d0?=
 =?utf-8?B?YU1PQ3NLSjFMdVcwYk1rM0xRQ251eUR2T0Jhd2RsRDdnVU9RWmpWaUJBc3hp?=
 =?utf-8?B?ZitaaXRVTXB0RmtsV080cFhUTXlNZGNQbFVRWjh3dkVKNXN0c3I2VHRlOWpR?=
 =?utf-8?B?MVFNRUdYUDYyUGhMOUJyd1ZoOTl0WEtLanV1MTdPQkVIT3VLNUJYVW1vM3Nv?=
 =?utf-8?B?WmtFR0hscHRmY3dKM05XS29vMDRLYkREcEI4UGJ1T2hoaGx1TGNkdkZRR1ht?=
 =?utf-8?B?K3plYnFkYjlsUnpaY3NsQXl3QW8vZEVQb1VzVVI2NUdQQTROejBlRXZQUVJu?=
 =?utf-8?B?RzBTZUxKY0hxMzZHK2xIYjRUOURzTWJ3UVR5SzhHWEhaby9ybjFwTWNWenpN?=
 =?utf-8?B?SDlXTWpzMWtQR21HTldQdll5cVJnOTYyYytOK2pXWng0Z05VYW02aTJZa2pN?=
 =?utf-8?B?djFubDIzQkNXSWhzVEtsVUUyN2dBNlMvQWxCRDZ6T1ZHaFh3ZksyS1NDRnFi?=
 =?utf-8?B?MmR1SEc4ak9tOWVtWnVpZXJwNjJZTW1yb3BJL3NIYXFrbTNnTCtqQWpoa0lV?=
 =?utf-8?B?aG1SV3BXc2dSaUlndzFlYVhsVTIxeXAvMDYvYVpsckh4Z204ZDZrNzlSMWJt?=
 =?utf-8?B?bGFEQktySDd1clQ5TTQ2aVo2SEtlVnZ0Qlh1NTlTcGV2dTBCMGNicWtSeVMr?=
 =?utf-8?B?OUZtNDBmMW4zV2NzdmFBQ3c4UHA0VVF4azJpR2U0YlkzT1dzM1VvSWxDTlgv?=
 =?utf-8?B?amlOSG9UYUJSaEQ1b0tRRnUxWi92STYwZDBLS0JBRWFjM29DSzZ0TUFjUVhJ?=
 =?utf-8?B?NkRNRUxpNjJuOGVvdHg2cUsvSXBnWU92QWRaUW9yUGV5SXkyMkdHZmhONFhR?=
 =?utf-8?B?aEQzaXBCVThGazdzdWhtZGFRVXNOeExIeWUxVGlNUmwvVHFFbUdCaTZkWWNO?=
 =?utf-8?B?RkgxVVdxUXNJdzdDZkx6aXczZDJoSThERDZhSGdaV1lZM2FHY3VrNUdqeU9m?=
 =?utf-8?B?SHZWcmpSS0IxZzhPTGV2NTN0ZHFSZWlQUzc3UTVrcklnL0ZpMk44WlFtUkdB?=
 =?utf-8?B?d2ZTSUFNNHlLMkI4VndBSEhXcW1CQ1dNSDVMVU9aTExic2tDTGdNb2NOQXR1?=
 =?utf-8?B?WnYraFoxLzZmRTNBNkFDMXE2dytvWEJnVG1ENHB6a21Za3BPTTc0SXp5TEE5?=
 =?utf-8?B?TmpIRWJqNFNNbGVCYXg2SEhjNTJlS3VFdnh4L3lYNXBFNlcybWlBQzJIVGY4?=
 =?utf-8?B?TVhlSmdQcHcrVVF1ekxNdHZVNzF5SEFqdEJkMmlvMGVWSE0rMHFwYUxQd2pM?=
 =?utf-8?B?LzNlZjNad0tWM3Uxd1J1a3E3Ny9DeDlXL2lXancybkNhRVhrcEJHaGUybDY3?=
 =?utf-8?B?OExZNDZYUm5xRWprUWVLVEpIc1pQZVZxTm1hZTZoZm9VTE4vSlRuTFlML2Ix?=
 =?utf-8?B?MUEyMlp5QmkwOVBYK216T0tJK01CTHJWZWJFQTJNSWtTbSt5ZWdGOE1Xb2FU?=
 =?utf-8?B?T1QzZmtOY1FZcHo4czN0bXQrQlY5OTFoejIyaExjOHMvK3Y2UzVVNnpuRU9I?=
 =?utf-8?B?bllmb3FQbmg2dXMxUVRNU3pQWTF5bHh0d1NvMndCUXlhNzdWNVk0VWJMNExX?=
 =?utf-8?B?bDNwWHVhWnpCVXJDSldwbUJjc204SWpnOVJWQkdTd2FCZHh3T3owc0ZvTmQ3?=
 =?utf-8?B?bnVhZllMNFZCcW1Lcmw1TVdiZ2RSZ2JMa2w5SCtUdkZqYUdsZEM4TmsyelVX?=
 =?utf-8?B?emxxLzh4MmVWRUdSelJ3UnNIQWh6aHVjdEJhRG9JRHFjTWN1K3ZmWFBQdC9I?=
 =?utf-8?B?bTdDdVFMZTNpbVZoVWxpMlIzUEZNSVY0TWNWN0d5cFZ2MWwveHFtU2YveWly?=
 =?utf-8?B?ejQyS1ZJbkhsdUJLSlJLZ3ZRWGxhRHVpZjYybzJWZUVqcUE4SUJtV0RNKy80?=
 =?utf-8?B?bmt0Mm1CMmpUMUJxTEtZZjk3c2xPVUwyQlF2TW1ZTWNEUFNwU1JDOGV5bWhC?=
 =?utf-8?B?YmJjZ3JXU3N3QTIxQTZFSXJqMmZWWmFiVHFIKzFMU2RFSk1SckdrZFJSMnhJ?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DB88A1A64DBCD4CB25AA7F1950A31B6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aqeYbccddashi7PIgxakdAfsIZMn7La9PgSJAyKVmdgjAZwSo790bvp/n5YiBYNy22hfYMNfHYIpQKdsLwphlgp5an53oX3D347s34TVtaehsuzG1b1HbEC6laZaV8GPfx5gSBhpUPmsLnIWqoEp2Wfdv7ZGOpx6zev27LHlJhHFX3Tu688tluwIQUNW4bWJrzKllH8TFpX0nVRId+/GAF8aavd6Nd8MPr8FYZ+ieNhuKSlpZs5LKPl8bwy2qq+vA0ryTkkKZMc92Zahh2upNu3TzFMk2IUdcZQn9J44CJCJQTMDWosgcyQar83del8fbQ7AgXdxQX1oNCEA0aL/ooGp9Yzus7htHbliyStE3dokBFbcL+AZXr4IxpAGdAg19BSgJXt9bFwQ/CaECfbJfaV6DIEIRJotJlXigpU9VkO3N1K6cVpeLgBa+5ZfhiOFibnHGoF9Dh/pUycxVHezM8CQ5e5dylpza5NyisQvLMZQ/FCib4WnVXTDdlcJNTqPWuecxd09RDPlttLlVFmMhHUfoMWDgS17A539QeLSsxGWTWaSN6mebgn5kGA+3HHdEfybKZuW9UQ0kn53DjoXsYgjdd3uXOuh8O3MDLJo4mg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a2c78d-d30a-4151-9414-08dc3c81e472
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 19:32:56.0824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kvgFMvr5xZU/slIgGFY7a31E9iSEtTnxQ1aRP1Its7wtUxmg8p0NspTnEpdSwe1MJmm0HBEcUMc4LxPVhd0boQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4623
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_15,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040150
X-Proofpoint-ORIG-GUID: mNtiE3ux_2OjFRIkuY7-r52ZV1e4255o
X-Proofpoint-GUID: mNtiE3ux_2OjFRIkuY7-r52ZV1e4255o

DQoNCj4gT24gTWFyIDQsIDIwMjQsIGF0IDI6MDHigK9QTSwgT2xnYSBLb3JuaWV2c2thaWEgPGFn
bG9AdW1pY2guZWR1PiB3cm90ZToNCj4gDQo+IE9uIFN1biwgTWFyIDMsIDIwMjQgYXQgMTozNeKA
r1BNIENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4+IA0KPj4g
T24gV2VkLCBGZWIgMjgsIDIwMjQgYXQgMDQ6MzU6MjNQTSAtMDUwMCwgdHJvbmRteUBrZXJuZWwu
b3JnIHdyb3RlOg0KPj4+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbT4NCj4+PiANCj4+PiBJdCBhcHBlYXJzIHRoYXQgaW4gY2VydGFpbiBjYXNl
cywgUkRNQSBjYXBhYmxlIHRyYW5zcG9ydHMgY2FuIGJlbmVmaXQNCj4+PiBmcm9tIHRoZSBhYmls
aXR5IHRvIGVzdGFibGlzaCBtdWx0aXBsZSBjb25uZWN0aW9ucyB0byBpbmNyZWFzZSB0aGVpcg0K
Pj4+IHRocm91Z2hwdXQuIFRoaXMgcGF0Y2ggdGhlcmVmb3JlIGVuYWJsZXMgdGhlIHVzZSBvZiB0
aGUgIm5jb25uZWN0IiBtb3VudA0KPj4+IG9wdGlvbiBmb3IgdGhvc2UgdXNlIGNhc2VzLg0KPj4+
IA0KPj4+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbT4NCj4+IA0KPj4gTm8gb2JqZWN0aW9uIHRvIHRoaXMgcGF0Y2guDQo+PiAN
Cj4+IFlvdSBkb24ndCBtZW50aW9uIGhlcmUgaWYgeW91IGhhdmUgcm9vdC1jYXVzZWQgdGhlIHRo
cm91Z2hwdXQgaXNzdWUuDQo+PiBPbmUgdGhpbmcgSSd2ZSBub3RpY2VkIGlzIHRoYXQgY29udGVu
dGlvbiBmb3IgdGhlIHRyYW5zcG9ydCdzDQo+PiBxdWV1ZV9sb2NrIGlzIGhvbGRpbmcgYmFjayB0
aGUgUlBDL1JETUEgUmVjZWl2ZSBjb21wbGV0aW9uIGhhbmRsZXIsDQo+PiB3aGljaCBpcyBzaW5n
bGUtdGhyZWFkZWQgcGVyIHRyYW5zcG9ydC4NCj4gDQo+IEN1cmlvdXM6IGhvdyBkb2VzIGEgcXVl
dWVfbG9jayBwZXIgdHJhbnNwb3J0IGlzIGEgcHJvYmxlbSBmb3INCj4gbmNvbm5lY3Q/IG5jb25u
ZWN0IHdvdWxkIGNyZWF0ZSBpdHMgb3duIHRyYW5zcG9ydCwgd291bGQgaXQgbm93IGFuZCBzbw0K
PiBpdCB3b3VsZCBoYXZlIGl0cyBvd24gcXVldWVfbG9jayAocGVyIG5jb25uZWN0KS4NCg0KSSBk
aWQgbm90IG1lYW4gdG8gaW1wbHkgdGhhdCBxdWV1ZV9sb2NrIGNvbnRlbnRpb24gaXMgYQ0KcHJv
YmxlbSBmb3IgbmNvbm5lY3Qgb3Igd291bGQgaW5jcmVhc2Ugd2hlbiB0aGVyZSBhcmUNCm11bHRp
cGxlIHRyYW5zcG9ydHMuDQoNCkJ1dCB0aGVyZSBpcyBkZWZpbml0ZWx5IGxvY2sgY29udGVudGlv
biBiZXR3ZWVuIHRoZSBzZW5kIGFuZA0KcmVjZWl2ZSBjb2RlIHBhdGhzLCBhbmQgdGhhdCBjb3Vs
ZCBiZSBvbmUgc291cmNlIG9mIHRoZSByZWxpZWYNCnRoYXQgVHJvbmQgc2F3IGJ5IGFkZGluZyBt
b3JlIHRyYW5zcG9ydHMuIElNTyB0aGF0IGNvbnRlbnRpb24NCnNob3VsZCBiZSBhZGRyZXNzZWQg
YXQgc29tZSBwb2ludC4NCg0KSSdtIG5vdCBhc2tpbmcgZm9yIGEgY2hhbmdlIHRvIHRoZSBwcm9w
b3NlZCBwYXRjaC4gQnV0IEkgYW0NCnN1Z2dlc3Rpbmcgc29tZSBwb3NzaWJsZSBmdXR1cmUgd29y
ay4NCg0KDQo+PiBBIHdheSB0byBtaXRpZ2F0ZSB0aGlzIHdvdWxkIGJlIHRvIHJlcGxhY2UgdGhl
IHJlY3ZfcXVldWUNCj4+IFItQiB0cmVlIHdpdGggYSBkYXRhIHN0cnVjdHVyZSB0aGF0IGNhbiBw
ZXJmb3JtIGEgbG9va3VwIHdoaWxlDQo+PiBob2xkaW5nIG9ubHkgdGhlIFJDVSByZWFkIGxvY2su
IEkgaGF2ZSBleHBlcmltZW50ZWQgd2l0aCB1c2luZyBhbg0KPj4geGFycmF5IGZvciB0aGUgcmVj
dl9xdWV1ZSwgYW5kIHNhdyBpbXByb3ZlbWVudC4NCj4+IA0KPj4gVGhlIHdvcmtsb2FkIG9uIHRo
YXQgZGF0YSBzdHJ1Y3R1cmUgaXMgZGlmZmVyZW50IGZvciBUQ1AgdmVyc3VzDQo+PiBSRE1BLCB0
aG91Z2g6IG9uIFJETUEsIHRoZSBudW1iZXIgb2YgUlBDcyBpbiBmbGlnaHQgaXMgc2lnbmlmaWNh
bnRseQ0KPj4gc21hbGxlci4gRm9yIHRlbnMgb2YgdGhvdXNhbmRzIG9mIFJQQ3MgaW4gZmxpZ2h0
LCBhbiB4YXJyYXkgbWlnaHQNCj4+IG5vdCBzY2FsZSB3ZWxsLiBUaGUgbmV3ZXIgTWFwbGUgdHJl
ZSBvciByb3NlIGJ1c2ggaGFzaCwgb3IgbWF5YmUgYQ0KPj4gbW9yZSBjbGFzc2ljIGRhdGEgc3Ry
dWN0dXJlIGxpa2Ugcmhhc2h0YWJsZSwgbWlnaHQgaGFuZGxlIHRoaXMNCj4+IHdvcmtsb2FkIGJl
dHRlci4NCj4+IA0KPj4gSXQncyBhbHNvIHdvcnRoIGNvbnNpZGVyaW5nIGRlbGV0aW5nIGVhY2gg
UlBDIGZyb20gdGhlIHJlY3ZfcXVldWUNCj4+IGluIGEgbGVzcyBwZXJmb3JtYW5jZS1zZW5zaXRp
dmUgY29udGV4dCwgZm9yIGV4YW1wbGUsIHhwcnRfcmVsZWFzZSwNCj4+IHJhdGhlciB0aGFuIGlu
IHhwcnRfY29tcGxldGVfcnFzdC4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

