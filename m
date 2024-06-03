Return-Path: <linux-nfs+bounces-3530-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E56968D83D0
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 15:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155181C219AD
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 13:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE0412D74B;
	Mon,  3 Jun 2024 13:25:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DBF12D1FA;
	Mon,  3 Jun 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421102; cv=fail; b=dMc+i0FkqPuu5pmECGlGukEDXIGxkvLN9EZHp7WnnCrTSZX9baOB14pvVSOy02Ed86ky5wOD2kPXUZPgRJyLdnoYnjFhvnTKNHyXgU2eMNVdCgByZiBqaKOOv74Mpu+xLXzj8hP/t+UrVb+qsr+9PBfM3FS6V1lGLR4iS/95rxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421102; c=relaxed/simple;
	bh=ZryPaoBHsTuauR1/aqTieX88yN1YCdFGWiNAanzArO4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XFEJwXOfVM/SfCNvgmRKeG9OvPgAYvJVhBhudxHOXL320n/xaCsIpNwS3sCxzY5njQ47Hcf1Agyb56i0JIZ3e+Gn+CSARYkozRcYqR8IyC1j0krejsMgXspMv9AZQjBN9GwMFGXbq59K6fsKOg4dYdpxuK19I8EgGrDyDvln/sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453CZV3B016507;
	Mon, 3 Jun 2024 13:24:52 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-id:content-transfer-encoding:content-type:date:fr?=
 =?UTF-8?Q?om:in-reply-to:message-id:mime-version:references:subject:to;_s?=
 =?UTF-8?Q?=3Dcorp-2023-11-20;_bh=3DZryPaoBHsTuauR1/aqTieX88yN1YCdFGWiNAan?=
 =?UTF-8?Q?zArO4=3D;_b=3DVcGO9hdhNyuphErv64ykMyzaBsshXksgoT33leDl/z9vC5lnr?=
 =?UTF-8?Q?KKseeQFaDm+kT2K5n7C_5PFUMVag511MyJpgBrvUl5QBbBXBWNzUpSX0+/q7vNq?=
 =?UTF-8?Q?mx9J+UBHg4v3Mtpy/xsUYZHEM_S3eiGvnaNRNPuYA3AgGJtmvBW/pkpSvdUh3pS?=
 =?UTF-8?Q?cq14BFWdQKUCNbT8OctZwD+nyOSkyGC_lk8Sb4dZz3VJK4W/lH8iDNFk2bHnCs9?=
 =?UTF-8?Q?AacgkqIAoMCTB/I+TI+hCJ6VJjRIhEhfS25WQ_D/DLhFbZfCy8daNulZu8TIVHy?=
 =?UTF-8?Q?HoNyx+qs0AMJDEGir25rxIzTK+URsfd2yjJZIEw/PtG_uw=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv05aup1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 13:24:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 453Ca6B4025103;
	Mon, 3 Jun 2024 13:24:51 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrt75u8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 13:24:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xhjl9lX8klHfJKjkm3bZnJ6dXfJE0vHdEkbuwsfX1h7tHi2AKxTlLA77GYZNrJc+B7dN3YmP9/Lpo5bm8BS1Zgtk+DnaA4CGPEHDoXCwnM6pvIcSvPXc/kiss2DgOoNQMw/UW1vV4pWipjMddThf8PVTHkCmvMy5/X5xiikgGHouUC9zLmn2abgb9TO//lLjS624MRpoctJeSZvipIWKi2yG97+Nqk5FzYJ9tnWcFVbmApBef6OOHJXfkRyyGOvt+dcFSowhZk7Cvu2u0QC5QD3JiEsu3/Fk9HkCVu9yver5OSvhWjCuWIy6BY2OCYi1ZA3FzBNrfYaUPHWPUz0GMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZryPaoBHsTuauR1/aqTieX88yN1YCdFGWiNAanzArO4=;
 b=O5fRgPqn+VTUr0lWWdL3RgGtBjFKXVFbMt374IwZOVIYh5aSWiX9WhzQXQGEW8gAHvJIyzv+kJivS9iNulA05/Sucm42Cx78PkI2p1p66phmvwH7q1l3BQwhJVgd82Kc1OdeecOPSL0wD2wKQQs6YjJtaG/JUIiDNeFK7HPXXQkEeb+luShkhh/zI8AyoUtiaRk9L2gkr9ZyRjkymZ9lA/9EjOyR2UKklSw8UI8JUyB1YmfHdb/lZqHQBEtHcBS3T6ErkTDeJzuj/sl2XYVyJLA4P59vwKNZmaKxLC8RjJRu+2dIWvgjOMJN3VHnHSBPbYuH/TM6nf8OwfGEDewzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZryPaoBHsTuauR1/aqTieX88yN1YCdFGWiNAanzArO4=;
 b=MJ/W6FDCB2uu1hUh6odj9UQaPw6WVfBXKJWnNJwL6GF5U3/K8XxPWLzHCFK7djGjGzgfj3OrSw2OqBxzCrMZdM6dAhNMhzlfX3/UkII2QRaSlh+tOb7ObNqD1l0JvQY0hhVxDLOWFAER6nR6eEnmsWz/qwiBJeBpAeTojdl/gyE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.28; Mon, 3 Jun
 2024 13:24:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 13:24:43 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 0/2] Fix ADDR_CHANGE event handling for NFSD
Thread-Topic: [PATCH 0/2] Fix ADDR_CHANGE event handling for NFSD
Thread-Index: AQHas1y1k+uLMe5brEy9pY6Qb0VvIrG0HHwAgAHviIA=
Date: Mon, 3 Jun 2024 13:24:43 +0000
Message-ID: <63FE70AF-52BE-4C0C-8074-92B02F44BB1C@oracle.com>
References: <20240531131550.64044-4-cel@kernel.org>
 <5250bfd2-1268-4ab5-8429-92227a4a049b@grimberg.me>
In-Reply-To: <5250bfd2-1268-4ab5-8429-92227a4a049b@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4687:EE_
x-ms-office365-filtering-correlation-id: d1cd698b-5e49-4dc5-3936-08dc83d087da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NTNldEZDUDJyNDBHVEZKNU9NUGx1UEwwSXQ2cDdXdFdtZGpzVUFTbGxNMTZr?=
 =?utf-8?B?QlgrZElJZ2VvQWFaT1hrT0VlQ3RZMjZhQys1UXJoZ2ZuTmMxSzhVNTFPc3FS?=
 =?utf-8?B?WDV0d2FJMkVJQytZaVBpZ3pGSEQzR1YxTWxKMjFVZkRRVGtqNHFadUkwYTln?=
 =?utf-8?B?QzhsNnlHdkNTem44NDluUHRiZmhnNytwL0I4bXBuNXp1akx3RVhkQzNwZkM4?=
 =?utf-8?B?N2NXS0dHZjhhdHgxM1pxU1B3T2R1YzZvZFhOb0t1QlYzMUVWbVB0NkZGR0dW?=
 =?utf-8?B?bmdiM3lSYS9KNytKVjRXbjdDREEvRlRVd1g4YWVIaTFtRFh2am9ZcmZkMHpM?=
 =?utf-8?B?a0tYTlNvSEFJd0FEQ2kwdUlDSnZsNktjYWJwM2xpVEpMQnREUzFNYUJRNFlm?=
 =?utf-8?B?UmdURXF6a085L1owMXJ3UVE3Q1AxTXJWQk5GbE5xZjAvYW1PTW5oZkxTbXJY?=
 =?utf-8?B?Z09aNkljVDB3Wlo2NmVxQXBobm91WFlrVnpVM09hbmlsRHF4N2NXcEVsUEJ6?=
 =?utf-8?B?SjVjZE55NWVMSHJkY0V6RWFwQTRnTU5qQ2VYelRhbDd0UmdsQ0w0Z09xR1Zy?=
 =?utf-8?B?eDg3STlicG4vcWUrNnRadUhzbEhuczRsbDU3SVBTZG0yeDdOK0svdnJqTnpM?=
 =?utf-8?B?ZFA5QXhXWitXaWRQWXE4MG83TU9KM0xyTkhaWjlzUHN4NjE5WXZSZDVHSUM5?=
 =?utf-8?B?TE1qalpBWTlHNy9BbGlCRGZ0a21KQmRrOHpTNlNTcDczYnVla2syaGJBNkta?=
 =?utf-8?B?aFlFZTVEOU01bHZCdGhpUnlaekJ2NC9HbzRwWC9MWUNtUTRXRDlObWgxU2Q3?=
 =?utf-8?B?TnBzaklIOHpMUXFyVktzN2QwRWtQUEFLY0lGOUM2WGF2Y1dwUEp2QkM2RGtE?=
 =?utf-8?B?ak5IdXhmN2Z6RkhmNGsrdWhFRGczcVhSUlduL0g4MTM5MysvNFQ1NWtiMEcy?=
 =?utf-8?B?MUdyYlNCNDR3aUVzdzZ1UWRPVHNoUmFNTzUwZEFzMzFINmw5TUt1WllYUTYw?=
 =?utf-8?B?RjU2WngvM3FjN0Z3ZVhPYS9CV1FzQjhqbXRLRWJwZUZVZFJoK2h1WFZoejRa?=
 =?utf-8?B?dk5ManpsOEhYSTVuTSsvUTErMFNQNmZza0xtUjNrRkIwR3hhRHNoVWNKNzF4?=
 =?utf-8?B?OFNEdzFrbi9MUm1GbTdqa29GZW92RnJpYVhyeEVVZGVyUGJqQlVGQm1IbThW?=
 =?utf-8?B?Rkt3SndoODhiSE0zN2xVZmNCZXFEME9aQm96SExsMXU5bkFWc01aT083TlZw?=
 =?utf-8?B?MW1tTmVKVXdMYUJhVXZOaDdNY0UzWWgydGQxOHcwK3YxQ0pZY2RrUGhwVzhR?=
 =?utf-8?B?aW9Gbkpyd080RlJkazdoNGlRVkVHSXpLVTliOTFJQnBqVWRzTS94cm1TS00w?=
 =?utf-8?B?N1VrUzdic3g2MGxVejIrdFdBQzJCL3VZSFYvN1RMaTlWNjlsMWVaNTF3SDFH?=
 =?utf-8?B?QktnVWE2U05WbE1DY0xzTFMvQk9nWE9QVjc1QnFIWERtLytuU0hNL1hJYkNZ?=
 =?utf-8?B?K2hkMEJ4RnFHVnlKS2t5cDM5R1AvTVNWdkhmdTQ5S1l4Y3ZEbFVQV2p1SHdF?=
 =?utf-8?B?YmV4UHpxMEduaWI4aFpaOEU1bmFsazFiOGxWZVZlSFFwRXh4YjJ3UW9HanlZ?=
 =?utf-8?B?b0hCSm5WcDJZYVJaSXNOd2NmaFUydzFpU291ZlExTUN1SXhtMTBveGxkVGV6?=
 =?utf-8?B?Ri9maWxjbXMwY0pwU3ZQUEE1U1g2b1VSbVZZVnZHZVprTUlyWDVNbm5yUGtJ?=
 =?utf-8?B?SklmaWlLOXNJb3daZmluZUtQWTVqcnZ6VDRDSStIaXNMb2xUcFJzRDRjTksr?=
 =?utf-8?B?RklUelhwZGxkZXpZcjFNQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Znhrb25Handzc2IzUVlqMkdqTTRucWZYYUFVNUhqbUZRS1hFWTlyZXlXLzFw?=
 =?utf-8?B?UFN0c1p5Sm1Mc3RQUlhxaWJqLzNWVTVNZENYMXpSWnA4Z2xHUEFDcTFPWVB3?=
 =?utf-8?B?ZWFDQXptMFhCOEU1bFg1dUFCSXprdlczWUVPMHV0bWgvcUw5ZDMrdkhpbzY1?=
 =?utf-8?B?RU1TYVdnbFhjY1NNVVFMaVJyR0Qvemd3NzF4WHMzdUdqRUxCSHB2dkRtQ0Rm?=
 =?utf-8?B?Smk5V3pwRUs4Mk9nWW1CL3FIaUNwNG10aEtiek5kbE5Tc2JvMVU5YmFuckhS?=
 =?utf-8?B?bG5ydXVPa0tkcjNKR21LeGRvUkJYV1pnamJkeWlUYlc1MENjUGNrZFV1MGl6?=
 =?utf-8?B?cmwvVm9yQ1dYODNiV1pjT1lnY0VLaDBaZ1VVbmJqN1JCTW1la1c4T3Z3MHkv?=
 =?utf-8?B?dlFxOEZ2cVZ3RG1YdTkwQ2x0QklSRzBBcTdIdWw4MUVacm40ZUtjM2NTYVVv?=
 =?utf-8?B?cWRneTFHZm10eDhVSmRSRVZFK3NFeVM5WGpTT2oxQ1hZeUlWUDI3b3YyVHpr?=
 =?utf-8?B?dXhQSGJKRW9tU2tBNDdDUi9mSGVqaVdvUlI1azJsOVYxMUZqU2l3WUdUOXNC?=
 =?utf-8?B?OGN1TFhjT0RVOVBZRUhTak9CZjRaVnBlWldRYkoyb1FIaDVCVVFCclEwWUQr?=
 =?utf-8?B?ZElmSmI3UGpsdUE1akdzclhUTnZ3VEx5eW1hSFFId1BuM2JFVTZBNUVjSk1q?=
 =?utf-8?B?KzR0TFkwV3Q1U05WOGZZQURNSjB3OXA4SE8vMXY1SGZKT09JaFk2V3d1U3dX?=
 =?utf-8?B?d25JSERBM2h6MzNnOG1nVVJQMFI1V1Qzd3NLMnQrV2lZV3BiNEhlU2U1UHFp?=
 =?utf-8?B?ditDVk9WZThSUFZTQzhBZkl2MTU5N2NVekcvcHZaR3FyMW02eFJhZTMzRzh1?=
 =?utf-8?B?eFNkQ005eTJkaDdsL1dTRmRlVXRjZ3pqTUk0MVNVNEJmZ2NETDlMd21HOHF2?=
 =?utf-8?B?c0lmTzEvRFY5dkNmdlZrSHNiM21XUnErRmZqK1B1Rm9GL1dxeE9jY2xjVHVH?=
 =?utf-8?B?OG1VL1h1VWNWM2VhblJyZ2pCMHRPQW1BZXhOMVY1eVhOcWZIbC9LYW5EeFNh?=
 =?utf-8?B?eUc3VU9SZkllWFd2YThGZG1mSkVsOG8yTStvMkNzMzlpdzRGWHBhdDdXd3Rz?=
 =?utf-8?B?aDg5RHRCY1BwSEljU244djJlbEQ3QllLMHdzWmdMWGhCbmI1V295M2kvQlpu?=
 =?utf-8?B?MUZHYlBuSjhvUFdoQXFFTm1nYVlQdFZqM1JndGJnN0ZDSXI0UEtoS2x5S0ZZ?=
 =?utf-8?B?dlc5ZE5oTFRCMnhUdUUranllNkJXR29DcCtZQlZ0djRKa2dPNFFlbHowRHM5?=
 =?utf-8?B?cXkrZlN4dkxjc2NKZ1h3Z1lFVUhsTkFpOUsxTWU1MVEyVXBUOWFwaWI1dTlZ?=
 =?utf-8?B?NW95MkgwOEhBbzFtTGVJekk2K1lmYzhrN0kzbVNkdk9FS3hIMDE3RXRuc3Rz?=
 =?utf-8?B?aUZTTFRWVmtrKzlqV3FhdVNZUjRMdkZ0aXpRK2RXSjM2OEw1bS9DcEZmR1Q1?=
 =?utf-8?B?OWZJcmc2L1lCbm92Rm1FQStvYklMWm10TVBvZWdDSGtsZXFRZ3czZFhnNyt3?=
 =?utf-8?B?RnJ6aExpbXN0aUI3SCt1OGl4MUlsbWRvSlhtcFZWSUxIRDhoeHIzVFl6UUwy?=
 =?utf-8?B?SkpIWkU5YWxOeVduRU1aMlYxWFBvSnFqSVVpWjJIaWgxRnhRSDUzNTYrTXdi?=
 =?utf-8?B?TTQ4UGNzbGFRaHQzRlgwSXdFRkdNQ2V3bGk1bUhUc3d6NEJqV2FMblNNcVp6?=
 =?utf-8?B?MnNjL2Fjbm0zZ2w0QVF5czI0Z1NybzZ0YjFtSlFFNXBsWE9QQ1FZeUtkRjI3?=
 =?utf-8?B?SWIzN1djeEIwNlJid0dpZWVwQU1zaEF6NkVkdytkMzJKOERQbGxKV1ByY0dl?=
 =?utf-8?B?U2J0enM4NmRIOERibGp2R2kzZEZ3Z0J2dXNSS3lObmEzRUVSUVMrL1NMMG9V?=
 =?utf-8?B?a1NPMTZwU0VjYzRhWU9NQWtHTytiZ2xSZ0dmQ2Q0TGR3KzVpMnoxc3hGUms1?=
 =?utf-8?B?NnJFL0MyRHBRbkxvZDhOOWtUckx0SmpOSGpFRE1lenJOZW9pVXRyQXBnelhk?=
 =?utf-8?B?TDIrT0p2SUJqU2tCZkltZEcyalB0S3lCcmRHVEd6QkFkSjR0TDkzSXQ5VVFQ?=
 =?utf-8?B?Zi9qVDFrWTRscWtySnhSeXdZaUJidTRPZmYwWml3T21Udkowb2RDYlVNTVcv?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5E7617C56D6374E90C5A6635A6669E3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OONnQMzJgVYiBcvcJBjxUpDAqPER11N1I5bTfTJdQjOeBKM2rxp3rc4Gfc3cM7TSFh3X9OGKpFS+UgF8Hr7gdYRMFfp1c6a2LNo5HPhUNLRDQw30hqv5KPmOlGnULdvKn0hQnw6Wr0rutMYIK/VMUzXEARYvbZFlTDtCP3L3tT4BhBQldqLGm9OX5pIyw40ok81xJ+36ULaJGgjydtRNVEMe3Yiai9XTlYOLxQtnAGlxO8mgNDptJn01VL4l+Nh3fh0SjNWoG2uAKAEqCoxXoKJeXXyKzLkbvnt4pLRzcaIyHysSEequxSd9ufAwx1ZGDNIx5oI5vuxcMC5CL+tPxNn24Y0Ibagkhb2yF3WFD7b0sHsGJLyYVVT2ghLT4pPxfMP2FPH5Dqk1IMfk3H8dV+RrSiPv7wKREbwnkGswFBLcTheQSCWHRl+VDalot4x2QVYOD2T9Fq4YN6w6MQii3v/14a0thYFiHJaau2+iVquthWblfwD8hC1zA48DyFxtmE5fY+nodnQwMvYpROfjBvV69X12wNNXCta8NLVjnuU8yVMQCa65R02bBxXtu3oghWeu5BQ5sfaclTgjJHVP6fMkvlDXnmN3oVCrGGqsU+4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cd698b-5e49-4dc5-3936-08dc83d087da
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 13:24:43.5101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SIfz/P8Cd9lRrOwVjqfcT4Wj71zmVMeo+WiaLrWNQ8UxBUICIPAEZ+WeyBUcZ9g0jJAwFwXqzZwArm+35z3RAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_09,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406030112
X-Proofpoint-GUID: yM9UlzLyOKhI98j-KsiQLDQUuAwAi9dh
X-Proofpoint-ORIG-GUID: yM9UlzLyOKhI98j-KsiQLDQUuAwAi9dh

DQoNCj4gT24gSnVuIDIsIDIwMjQsIGF0IDM6NTDigK9BTSwgU2FnaSBHcmltYmVyZyA8c2FnaUBn
cmltYmVyZy5tZT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+IE9uIDMxLzA1LzIwMjQgMTY6MTUsIGNl
bEBrZXJuZWwub3JnIHdyb3RlOg0KPj4gRnJvbTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9y
YWNsZS5jb20+DQo+PiANCj4+IFNhZ2kgcmVjZW50bHkgcG9pbnRlZCBvdXQgdGhhdCB0aGUgQ00g
QUREUl9DSEFOR0UgZXZlbnQgaGFuZGxlciBpbg0KPj4gc3ZjcmRtYSBoYXMgYSBidWcgc2ltaWxh
ciB0byBvbmUgaGUgZml4ZWQgaW4gdGhlIE5WTWUgdGFyZ2V0LiBUaGlzDQo+PiBzZXJpZXMgYXR0
ZW1wdHMgdG8gYWRkcmVzcyB0aGF0IGlzc3VlLg0KPj4gDQo+PiBDaHVjayBMZXZlciAoMik6DQo+
PiAgIHN2Y3JkbWE6IFJlZmFjdG9yIHRoZSBjcmVhdGlvbiBvZiBsaXN0ZW5lciBDTUEgSUQNCj4+
ICAgc3ZjcmRtYTogSGFuZGxlIEFERFJfQ0hBTkdFIENNIGV2ZW50IHByb3Blcmx5DQo+PiANCj4+
ICBuZXQvc3VucnBjL3hwcnRyZG1hL3N2Y19yZG1hX3RyYW5zcG9ydC5jIHwgODMgKysrKysrKysr
KysrKysrKy0tLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDU1IGluc2VydGlvbnMoKyksIDI4
IGRlbGV0aW9ucygtKQ0KPj4gDQo+IA0KPiBMb29rcyBnb29kLCBGb3IgdGhlIHNlcmllczoNCj4g
DQo+IFJldmlld2VkLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KDQpUaGFu
ayB5b3UhIEFwcGxpZWQgdG8gbmZzZC1uZXh0IChmb3IgNi4xMSkuDQoNCg0KLS0NCkNodWNrIExl
dmVyDQoNCg0K

