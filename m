Return-Path: <linux-nfs+bounces-8179-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2809D4EBE
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 15:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97FA3B2261F
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 14:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB1C1D4144;
	Thu, 21 Nov 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bz0uXUNB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FpZww7OC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3351D1D7E4C
	for <linux-nfs@vger.kernel.org>; Thu, 21 Nov 2024 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732199801; cv=fail; b=TmB3j6UgPYCAj8+248e8OloAb8KkKkQaspfrGFxyDYGe0cuJjFaY/InXAWGiLGrERgh//ApIHuPH16MRn3iG/VcCROwakAIU/zjUfVbYJtQJzOao0Pzhmm3VCkvJ/QTHfxeWEbY9DO08hmeyYHGOs+pnJCIuflJjX70mFvJ8Vic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732199801; c=relaxed/simple;
	bh=NhrizvX8xQYCmYly5PnfckLiOqW9WqRzMzLPR25cfks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k4NWwoWmBjQCNtb8bx0LAClFcuLQ8q5u4IFozdq5VGc+pumkTDe8/j+OTu4fE/lFsHO+93QJLVz4QmTvOAxKKFY+/5+nBiyA4ofX5pDVi9elH7I/14CRCnLzn1Gas1Am+8cn9UU4uXbOXlIrciaKV5y0I/q5MFtcczjHckP1c14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bz0uXUNB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FpZww7OC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALDKIDg007679;
	Thu, 21 Nov 2024 14:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=NhrizvX8xQYCmYly5PnfckLiOqW9WqRzMzLPR25cfks=; b=
	bz0uXUNBSnkxPTN48yEqYZBp3XOu4PleIUB5IYzMPaMR6IlWiRZvSIDQFGEoGWs9
	KFFBNOLbrQvOu0cvCzkAaXh2/q+0d/Wx3phHxaAkNei9YlHL4Ww1QSNgx5Gp8HMV
	yL6mhf70E3BX7LIQ+g/lmfHWaOQ3ur/9NbRX5Vc4tVdQZ+5AsK3fk8jXZU6YtkdP
	1vY6+7amwp72t+wL8LxMOV8e/vPax+mSEr7Raxa+wHLhE8GImRCB+AFZMKR8Nj/a
	cnuS0naEjgCTKov7tTj2bjsa76LPkfAExPGGnCuVIv5aA4tXsUxspANR+fO12wJx
	xFNyjHBXk/bvnqYM/UCsvg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 430rs5d6sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 14:36:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALDDoGO009087;
	Thu, 21 Nov 2024 14:36:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhubw5ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 14:36:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vytIQU4JRkVkYtt8byqnAsNn7xjYV3P6VYyRmj/vQlzaSI6ULVEVT79dUgTY2waD3OyqOmo1V+/ktDOhPi43SvB0FMkf1zCqKrzipJ+afHnMzYwSkd/LQfv9P7+fQjh0fGu0sLJUadbf0bXzdT9+yHwjoFK1PW/lseG6kCyZ4xabxVpi9fCCwsEubgtl/cSEhtFQwz0utUbi/FTnH6tuzrNAEq2/xkvWwxSiyjFk8YpfZgf4ogrDCytlV1+38Vo+m7ESxM30C5KhcqIujG7IyZ6MUr6r72CNyqwlQZMx5u/gAbyr/AUImEtdmWCp2f+qwGI3ndNlyMtBdjQoKJmIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhrizvX8xQYCmYly5PnfckLiOqW9WqRzMzLPR25cfks=;
 b=sYd2fGlDneWvoTX7XCv5ihTHLvo1ybNaSZ2NRc5M3q9gU5n3PDNz0KuiL0p4XPjGwpW5OHVeZ6Sifh21HffgOEXFtLRkpSNrq1tME43oHeGEBVVdhn1nrBVSSkOxSv5Itxc8Epv53KBThN2o5eIEZuOyyBtAArD9bNM8vtwyeFgGenn2cSVDw4N4EsnR6A5d/Zb8ktpgYipdrIwsaw/FMWMny3CYZGV7rFbsGEOODymspHNcWPJliXSYcDOvZqeQf7zQqYJ6HiC5XPQhuiUfA5vlxAMdHknDR9b0Q6yElMM8f3WBCbULjkcKsqoaB8At4Z62Q/o0kZiE/yHdKOmU+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhrizvX8xQYCmYly5PnfckLiOqW9WqRzMzLPR25cfks=;
 b=FpZww7OCE9q2dayeyo1ayM0ijnpSA5OzstDbMGibmk9wB4IuGVGJG4B80EQzlUsl2VSru3Sx6gUn2EUOgnKlG1YV15TLqGDlHiuF0SatCGLXhYxo78N4X7U4p5GmJBhDwm6j8/XvP3nQxqdwhU58P5VKMEZ8Qm0BN+Sh2peKjy8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4436.namprd10.prod.outlook.com (2603:10b6:303:95::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Thu, 21 Nov
 2024 14:36:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 14:36:32 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Cedric Blancher <cedric.blancher@gmail.com>,
        Dan Shelton
	<dan.f.shelton@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH V2] nfs(5): Update rsize/wsize options
Thread-Topic: [PATCH V2] nfs(5): Update rsize/wsize options
Thread-Index: AQHbOqigeUCjXIN6cEW/5cjhJHZz/LLAp+6AgAAj9YCAAPeXAIAADKuA
Date: Thu, 21 Nov 2024 14:36:32 +0000
Message-ID: <B5C75CBA-78E8-4370-B099-17B552512390@oracle.com>
References: <20241119165942.213409-1-steved@redhat.com>
 <59ca2dd7-583f-4141-aef9-4acff857c957@redhat.com>
 <CAAvCNcByu8MAmBRMw6U2a0pHiYQKrp361R9NpCnFp8A3om5hUQ@mail.gmail.com>
 <CALXu0Ueq5HP==Fde=4W70ngVpu=dFCOfNAFbZpYe1zPAKiJZpg@mail.gmail.com>
In-Reply-To:
 <CALXu0Ueq5HP==Fde=4W70ngVpu=dFCOfNAFbZpYe1zPAKiJZpg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4436:EE_
x-ms-office365-filtering-correlation-id: 9e936d6b-5aee-4127-20a2-08dd0a39e511
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWZ6Z2JscmlCK2dVaXBQRzRQMlNtQXhSUWxRWWw3cFcyR0doc1B4NmpCem9X?=
 =?utf-8?B?d2VmY0M2WXJNaXRyWE80aU9uRXhSZHc5ZGpIVkVOa212SVRSdjhHNzRudWth?=
 =?utf-8?B?MFhJaGZ3SngxdkNqOTJlcWhEYSthL3JIRlo5ejUvQ1hsN3V1VUtocjNJQXJw?=
 =?utf-8?B?cW1NbC9BblBJdG5HZFVBNUhkUnI2QWJCaldQR2poWmZxdnp1TlpJeVpycUFk?=
 =?utf-8?B?UUFmbnRjQU5jbzV6UkJ0b2ZGcXdyZyt6d0VJZUF0c3paaEFlSytMYjZFMkhj?=
 =?utf-8?B?UlBSWCtCclpCY09CR2t2WlBSQnB0YUZuYjJSblJ0cDdxSkk0UCtPc3B6TUVF?=
 =?utf-8?B?cWxsVjB5UWplcGRmSlNhRXNuVE0yYkltQlJvZ0E5b2tZUWdUVGdBVlhyd2RS?=
 =?utf-8?B?SythK2RKZndoS3g5NmdIQkw0V2pIMkFOcDdqbkw2OU1FN1BtQ2F0WDhYcm0y?=
 =?utf-8?B?ajBJSFJiRGRQR3N2aHdTZVlsbGN1RlZlM3ZOeHBmYUJWbG9henVPdEJqVXVK?=
 =?utf-8?B?cWVmRFloM053UVdjMEJ0ajlLQmhsZDczVlFFNzgxVFVlZWpNcEhlUjJGSkg5?=
 =?utf-8?B?bG1OU3lXbUE2Z0JWU3JzUTdaUTdVZjZTdlF2QkRKMVhISEdSbEtFTzVBVkdF?=
 =?utf-8?B?a0JQQjZIbWw2NUF2UTNnSEZTTjdDN1BBL3FKMlFUS1p5MzU1K3JDV2ZrRmpS?=
 =?utf-8?B?eDl2SmpGYThTNkQwdE9LWnVoeStibUNtMTFobkNHaTZ6cTBYdU1TN0FURkVV?=
 =?utf-8?B?eDNzREw4M0tNMWNFNlo1NDl1eHVoQkxZVURNeS8zeitLdFNYT1oxT2pISm4r?=
 =?utf-8?B?OWxKa3gxZDA4M2JUU3NGU0RYbStSWnAvS05KOE0zNmJRekp2dGZKQndWdExT?=
 =?utf-8?B?UU5zY3dUQitEa0kwaXNjSW1lK3A5R09YcFlTK1RWRXRET2FRUU85RDF5TUo5?=
 =?utf-8?B?dmhYaWVRV05ZNXlxd0JtVEFCWXBxREhJOFpuRjlVWkw4bzdnYWVQTFE0a3V3?=
 =?utf-8?B?bVlQc0Y1WFhlTUZLL3V4WndRTGVnTlBDRXY5WE9vY25Yc20wN0VzUWtXUWdK?=
 =?utf-8?B?TU1PVUl6SnBzeUxUMi9Pa05tRWliNVhOK1JJQldUdWs4VXJPNkxaK1hOZEtM?=
 =?utf-8?B?TExFOFp6c0xCT0t3MHdvcXd4d3pIYUhoZGZtQ3BSWThKaDNTSUV0amxLVWxH?=
 =?utf-8?B?eDlmc2VLWlJRaFZ6bHlyM3R1YU0xb0VrZTJ5RVdSL1hjNjMvTElwT0svMmlk?=
 =?utf-8?B?OGxGWXNXY2NBWUE0d0NQZmZNd3hBdDZyWDY5NVFlVmx0c0dOOHVDbStkbjJY?=
 =?utf-8?B?UUFFdnN1U2d4YmtvVnpMTzJiRHJnOXhId3VTK0VzcmtXWkJ6WFoxTVpLU0xZ?=
 =?utf-8?B?ZWFVYmgvR1BEdmFiQnNEdU4wS1poa3RYSVJ2dGVZR1Yzc2p1YU5VZDM2bUVJ?=
 =?utf-8?B?a2I5cUpiNlhlOEVTZENTRmdxRkQ3YVE1NmhrSmJlUS83Z1hsQVloZ21ESDQv?=
 =?utf-8?B?ZkJYS2lxRjhTbmF6NGZwcTdvV1ZWY29aME1hR1dSMkozeHNUbkF6Um5jb1dF?=
 =?utf-8?B?TzlCRzhKVTdseEFkYXloSjRrYVA4M1k2c3JVbVJJNE4zU2JqbE1COHFMazc1?=
 =?utf-8?B?RERmL21aUkR2aW9aR1k5ZEJZMXBjaGNpaGRpTENSQ1cxRnEyVWRJcXFRZUJD?=
 =?utf-8?B?TmRBVEpWQnRCajdtQlZDNTh6WmtvbEZKMkswSVB0U2V2enVMekVGeHZFQzVw?=
 =?utf-8?B?bVZDMTBObGk3c1F2YkovalhzUUczVHVZa2F3ZXVjS0Z1TmdhdUFLeW5tcW1R?=
 =?utf-8?Q?LcHSMkfe/bLcrFm6+1IDhww3hz7aqRElQXZsw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NE1oa0RVZHdqbU0ySjFRaytNN2FiT3hndk44R0dEQkV1cXhBY05WaE5NQmZo?=
 =?utf-8?B?QWJqMXU4R2NFbGl3SXRWeVFjNnVUUUNUSFo4azk5UUVjUmZnT3c5dEpBOU1R?=
 =?utf-8?B?bzZCNW1sMWxBOVRzM21WZlhNaU9mWDNtTnI1bUFNeWtFMnRmanE4Z0NDZDE2?=
 =?utf-8?B?VUNqSCt0WXpiR2tiRTVHNGM5YkpFK1Zzb2o1VktkOVAxS0hLTHVDTjd3eG1T?=
 =?utf-8?B?QlJGWkxGV0pKR08vdXpCL1MzOVE1OWxuWlN2ZnZUbDlITWtCcXF5czJPdFRa?=
 =?utf-8?B?eTd0Zk11K2FtVElPcVRDRGxyZzNqUVFzbkhLNlh0RlBsU2t5Vm5nMXlBek9K?=
 =?utf-8?B?RnVIVms4N2x0UkZFZ3lEdU9RZnZHamczRDB0M1B6SWF4QTFKZDh0cWM5ZXNT?=
 =?utf-8?B?YmpIcXphK21ZT0tuNlNrSE5TeXFkaXl0eFdUYjJaRGt3T0dacmc0ZlgvSVZU?=
 =?utf-8?B?SFZRYmtaWnMrNFJST3NTOTFST0ZIbm4vVnZpMmFmc3ljYWlVZXJyMlFuRWxo?=
 =?utf-8?B?SThiTm9KditXZVlndmo2dmF5bFk2TGk4akFNM281YnZEQ1FDWVkvMnlmMW40?=
 =?utf-8?B?eWEvUHVDRzZGa1hlRzhtRGhzVlFWa3FRREJFN0dVdytmbmxmTWZiR3RVQXRm?=
 =?utf-8?B?RzI3YzZqb0dYdDFmZk0ybSttZFRkcDQ0ZHVZNkc3MUJUYXc2TFlKNnJnQ0JR?=
 =?utf-8?B?L2c2UXEvdnpTNUlmR05ydWZYTEJVTFFWdEt0cG9mNzFDeHNnTms5OFdPNDZB?=
 =?utf-8?B?ZW11TFRmQWxqWmJZQlNITXk0SG82YWNMSlpxbzNrMDJPL0huMjhpd3pXNDJH?=
 =?utf-8?B?cTQwVC95a1dlUENURHFjTjdtNVVrNWFJc2pSMHZIOGhvejZvTDU1L2xTelU5?=
 =?utf-8?B?YjFOY2NBUGlsTGJ0UEpCQmxJamxRMVZNNGdCbUtMZEVBT1ZjTVNtTE0yMURD?=
 =?utf-8?B?d0JzRDlnR0ZlVlBLQ3N1cktUem1Ga3RqdFU0QnZnUjNmWklFYVU0c0YzdFVC?=
 =?utf-8?B?OGxaNnJFdTB1NFppemdoQkE4MHNsNmJzT3J4cDdpa0dGV01HU09ZdmhLdGpr?=
 =?utf-8?B?QTl3WS9FaGtzZ2tFQXZ4K2ZQSDBKWWhsdE9abVBIYzQ0bUlLRXplREV0L3pI?=
 =?utf-8?B?aFBDa09NTVA4bDVkc2JVZTNJOFMrVitQQW5tbmo3MXJrTk43YTIrUDJuWnZK?=
 =?utf-8?B?ejVhTlVvaDJMNDBUTzR1NUxzSEFjRHZDZDRzTU5qK3h6a0hkQ09lNzlTRnNj?=
 =?utf-8?B?QXhhWlQrZ3BLcDRuVWRqeERaVkxyTFdJeEVwUUhIOENRRUtUODNFL01WVzRR?=
 =?utf-8?B?Q1NiWGtoUkZmZFNkblhYczlvN2l5ZXVOSFd1MXRrS3NRUDhHRmkrSisxbnp1?=
 =?utf-8?B?dkc2eVAySWQxZHBGTDZzQ3lYaUJ4MjdhT3Yzc3lZS0xDV210NkJuMjF0bzBm?=
 =?utf-8?B?bFpDT1ZXS0xWU05rVW9BK01nQXBJcXZSZkxxazhkbUVNcExQdGlJdk9jdE82?=
 =?utf-8?B?bjBhME9wNTFtQ281d2hTU1Z2NG9MakdQYzJTa1dNK3pNZm0vbTlxT2lLU1hW?=
 =?utf-8?B?NjZ1dWJNSHRvdFRJRTYwM0VOUk5CSWlyWDI5eVo3ZEEvNWF3M0NqVEVicWxF?=
 =?utf-8?B?MWR5N2gweTBxdzczbjZrVU92QjNtR2p2dlZiNnRReXA3SnNtWXh2WmwzbGFK?=
 =?utf-8?B?WkV3Uzc3ME1yRjNoU2hib1A5UVRiVUUrOXBweU1SMDArMW12dTlvQkJ1bDNF?=
 =?utf-8?B?S3FPNnZPNVFVbzZjUG5MdWhPOWtKQ1RNeWdaNFFlbEJnejN2cHZIT1owaUVO?=
 =?utf-8?B?UVB5b0dDcTVtNDMvOFc1cXFtOHpXc0pMZmd2VFdqRDc1emtiV05mUE92UFcz?=
 =?utf-8?B?c1pNa3FMS1k3R3BLWklWTzNON0N1M3d3MHFZWHVGUitsYVh4cGRadXV0RXox?=
 =?utf-8?B?b3Z3ZjNFS1ZvbkUzTHR0ckRGRGpZQllZZ3RmLzloTjVmS0poTmc3UkFGRXJT?=
 =?utf-8?B?dW5JemZwbi9PNzl0a2lBZEVyNzBTMkhZbTZtOU0xNG5OSThTaTZYRFpzSTVp?=
 =?utf-8?B?eG95cFdHaHhEMFk2dUdiS1hVZEE3Zkl2MCtvcTV4d3FmdGd5ZXlLd0RNV2xK?=
 =?utf-8?B?MUo2ZDE4VkFRc3J1OVFvRmJTYkxyaGRyci8rcnpFZkwwZmwycm1uNWhudEZ3?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD20235AD619DA42B2F06FCFF73025B1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+N3P6Bd+dPTRLO+L3JxOCRwbs2ev2jYKAeh2W2e5Q0EEETWTOU9vc0EGtimJuSq3YkJ+eqm2jd+Dca43tCZ9VKCY/Btu4CmqMCftXxmybfezySpho2L0X+BfuSGEdLaF9Km5UmVRqoxzC4L3aSTOzYRNKO6/EGfYd6rWO9xHkzMMitHumlCioLLdt4wD2atAPhoDuM258rmMOx99bmkLnSGvX1KgIhz07ijD4difCq6jMUA5xZa8VXedCfc3y9TQ8dzuaJJRdOJ7Lo1C43GGPpkYod+ZJYb0AjJss+s3/9FMa5ZstFtPffHN7MlQbWDY8sssZ2pwZ3Nuaj7Hs3/bl+iLFj1TMuZdwMJtfjiOgJf63WkTnLth87CLU1I+7HjTDXHVTrowBwBFZJqAXf6TDv0QhxTWA6oQOfQM2iRKVwHeMSCA90QArukp0anzryrAWLCiSqpBNgZ0hTTFTUzilcSzH3JkJ8v6QAZiLjU1U2bk7CLCR0UfDPQqHD+2H8DPFuItXjTuqnHeANOWF6EnHOOh10yNXrJ8fC4nkNaYT9MgS2pTPZKpYz7UHbd6XVa9qGwCTj+WhBsXLAiwpg7Aoumoo3K8E/B1ncjQ5R3bOBQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e936d6b-5aee-4127-20a2-08dd0a39e511
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 14:36:32.8730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRIzkRTMTfiyeZEvi4E8DFBvysgQvvYtThCc1Fug1Ucl6R/VKY4NXVycFoHFHw5tJDdaTyUXwcSyBtHWA0agqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4436
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_10,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411210112
X-Proofpoint-GUID: 3TbHmRbcHj4cB9I9akoWPcfRF68MGs0t
X-Proofpoint-ORIG-GUID: 3TbHmRbcHj4cB9I9akoWPcfRF68MGs0t

DQoNCj4gT24gTm92IDIxLCAyMDI0LCBhdCA4OjUx4oCvQU0sIENlZHJpYyBCbGFuY2hlciA8Y2Vk
cmljLmJsYW5jaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIDIxIE5vdiAyMDI0
IGF0IDAwOjE3LCBEYW4gU2hlbHRvbiA8ZGFuLmYuc2hlbHRvbkBnbWFpbC5jb20+IHdyb3RlOg0K
Pj4gDQo+PiBPbiBXZWQsIDIwIE5vdiAyMDI0IGF0IDIxOjU2LCBTdGV2ZSBEaWNrc29uIDxzdGV2
ZWRAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gDQo+Pj4gDQo+Pj4gT24gMTEvMTkvMjQg
MTE6NTkgQU0sIFN0ZXZlIERpY2tzb24gd3JvdGU6DQo+Pj4+IEZyb206IFNlaWljaGkgSWthcmFz
aGkgPHMuaWthcmFzaGlAZnVqaXRzdS5jb20+DQo+Pj4+IA0KPj4+PiBUaGUgcnNpemUvd3NpemUg
dmFsdWVzIGFyZSBub3QgbXVsdGlwbGVzIG9mIDEwMjQgYnV0IG11bHRpcGxlcyBvZiB0aGUNCj4+
Pj4gc3lzdGVtJ3MgcGFnZSBzaXplIG9yIHBvd2VycyBvZiAyIGlmIDwgc3lzdGVtJ3MgcGFnZSBz
aXplIGFzIGRlZmluZWQNCj4+Pj4gaW4gZnMvbmZzL2ludGVybmFsLmg6bmZzX2lvX3NpemUoKS4N
Cj4+Pj4gDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFN0ZXZlIERpY2tzb24gPHN0ZXZlZEByZWRoYXQu
Y29tPg0KPj4+IENvbW1pdHRlZC4uLiAodGFnOiBuZnMtdXRpbHMtMi04LTItcmMyKQ0KPj4+IA0K
Pj4+IEkga25vdyB3ZSBhcmUgc3RpbGwgZGlzY3Vzc2luZyB0aGlzIGJ1dCBJIHRoaW5rDQo+Pj4g
dGhpcyB2ZXJzaW9uIGlzIGJldHRlciB0aGFuIHdoYXQgd2UgaGF2ZS4NCj4+IA0KPj4gTm9wZS4g
VGhlIGNvZGUgaXMgSU1PIHdyb25nLCBhbmQgdGhlIGRvY3MgYXJlIGJ1Z2d5IHRvby4NCg0KTGV0
J3MgYmUgYWJzb2x1dGVseSBjbGVhci4NCg0KQSBjb2RlIGJ1ZyAob3IgInRoZSBjb2RlIGlzIHdy
b25nL2Jyb2tlbiIpIG9jY3VycyB3aGVuIGNvZGUNCmRvZXMgbm90IGJlaGF2ZSBhcyBpdCB3YXMg
ZGVzaWduZWQgdG8gYmVoYXZlLiBUaGF0IGlzIG5vdA0Kd2hhdCBpcyBoYXBwZW5pbmcgaGVyZTog
dGhlIExpbnV4IE5GUyBjbGllbnQgaXMgd29ya2luZyBhcw0KaW50ZW5kZWQuDQoNCldoYXQgeW91
IGFuZCBEYW4gYXJlIGFza2luZyBmb3IgaXMgYSBjaGFuZ2UgaW4gZGVzaWduIG9yDQpwb2xpY3ku
IFRoZSBzb2Z0d2FyZSBpbmR1c3RyeSB1c2VzIHRoZSB0ZXJtICJSZXF1ZXN0IEZvcg0KRW5oYW5j
ZW1lbnQiIGZvciB0aGF0Lg0KDQpUaGUgcGF0Y2ggU3RldmUgY29tbWl0dGVkIG1ha2VzIHRoZSBt
YW4gcGFnZSBtYXRjaCB0aGUNCmN1cnJlbnQga2VybmVsIGNvZGUuIFRoYXQgaXMgbm90IGEgYmFk
IHRoaW5nIHRvIGRvLCBhbmQgaXQNCmlzIGNlcnRhaW5seSBub3QgbWVhbnQgdG8gYmUgYSBwZXJt
YW5lbnQgYW5kIGZpbmFsIGFuc3dlcg0KdG8gdGhpcyBpc3N1ZS4NCg0KTm93IGxldCdzIHB1dCBh
c2lkZSB0aGUgYWNjdXNhdGlvbnMgYW5kIGhvc3RpbGl0eSwgYW5kIHBsZWFzZQ0KbGV0J3Mgc3Rp
Y2sgd2l0aCB0ZWNobmljYWwgY29uY2VybnMuDQoNCg0KPj4+IFNvIHVwZGF0ZSBwYXRjaGVzIGFy
ZSB3ZWxjb21lIQ0KPj4gDQo+PiBTb2xhcmlzLCBIUFVYLCBGcmVlQlNEIGFuZCBXaW5kb3dzIE5G
U3YzL3Y0IGltcGxlbWVudGF0aW9ucyBhbGwgY291bnQgaW4gYnl0ZXMuDQoNCkkgZG9uJ3QgdW5k
ZXJzdGFuZCB3aGF0IHRoaXMgc3RhdGVtZW50IGltcGxpZXMuDQoNCkxpbnV4J3MgbmZzKDUpIHN0
YXRlcyB0aGVzZSB2YWx1ZXMgYXJlIGluIHVuaXRzIG9mIGJ5dGVzLg0KQUZBSUNUIHRoZSBwcm9w
b3NlZCBtYW4gcGFnZSBwYXRjaCBkb2VzIG5vdCBjaGFuZ2UgdGhhdC4NCg0KT24gTGludXggd2Ug
c2F5ICJyc2l6ZT00MDk2IiBhbmQgdGhhdCBtZWFucyB0aGUgbWF4aW11bSBzaXplDQpvZiBhIFJF
QUQgb24gdGhlIHdpcmUgaXMgNDA5NiBieXRlcy4gT3VyIHJzaXplIGFuZCB3c2l6ZQ0Kb3B0aW9u
cyBhcmUgc3BlY2lmaWVkIGp1c3QgbGlrZSBvbiBvdGhlciBvcGVyYXRpbmcgc3lzdGVtcy4NCg0K
DQo+IEkgaGVyZWJ5IGNvbmN1ciwgdGhpcyBpcyBiZXR0ZXIgdG8gYmUgY29uc2lzdGVudCBhY3Jv
c3Mgb3BlcmF0aW5nDQo+IHN5c3RlbXMuIEluIGFueSBjYXNlIHRoaXMgaXMgYmV0dGVyIHRoYW4g
c29tZSBtYWNoaW5lLSBvcg0KPiBoYXJkd2FyZS1zcGVjaWZpYyBjb25maWcgb3B0aW9uIGNhbGxl
ZCAiZGVmYXVsdCBwYWdlIHNpemUiLCB3aGljaCBubw0KPiBvbmUga25vd3MgYXQgYm9vdCB0aW1l
Lg0KDQpUaGUgb25seSBkaWZmZXJlbmNlIHdpdGggdGhlIExpbnV4IGltcGxlbWVudGF0aW9uIGlz
IHRoYXQNCnRoZSBrZXJuZWwgbWlnaHQgcm91bmQgb2ZmIHRoZSBzcGVjaWZpZWQgdmFsdWVzIGEg
bGl0dGxlDQpkaWZmZXJlbnRseSB0aGFuIG90aGVyIGltcGxlbWVudGF0aW9ucy4NCg0KVGhlIGRl
c2NyaXB0aW9uIG9mIHRoZSBrZXJuZWwncyByb3VuZGluZyBiZWhhdmlvciBpcyB3aGF0DQppcyBi
ZWluZyBtb2RpZmllZC4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

