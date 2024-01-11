Return-Path: <linux-nfs+bounces-1040-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E00B82B28B
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 17:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC6C1C23311
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFED50241;
	Thu, 11 Jan 2024 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gTkkUij9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V9bZ1Web"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10684F61E
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BG7S6q027102;
	Thu, 11 Jan 2024 16:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=OnhlRzCt+r3rli6FxjfsOhugaaToyfvMAIeam1DIxHc=;
 b=gTkkUij9Ys/Qh1bC9pcPBNDUUVmIpdxRv+Ws9zKuHTwPfdFJrEETixLIqIwy300JmG2A
 11da/+9S0U8wpP/ejO7BrJoia7ODwuTrXvkc5yFVkqVy4tEHcTtv+mS9qiLyBHVSELP9
 QtA0kFI3GjUtR5FePD5rjJqJLmO0PP+aZO47HQLyMudCQVsUH7wavPD9HgEK43EU9SG/
 p2Kah14IpKGxDdjxB6GIB1uN6kzGfVIB1N+2XmshJpg+nTiAaw/BhkVdCYdSmpcA4VE7
 gZVnLC53IR5NeA7kR5QE7ErbTYn4rBhl+tBhXdUwfrmJQeXOsyIft0Ay9k4FJe5FbKYi Ig== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjkjt00n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 16:13:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40BF3xVm012167;
	Thu, 11 Jan 2024 16:13:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuwm63qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 16:13:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyTIltxoCD2g7BdIdY4u4v3RMp4xBeHiGjr0ujN16/0y7Ycg79QUoApBdu2Blu28d3SDAyGb4oJHnbKiPEUoTCZR4wH2xlKe36K3f6HvihpmlO9meOYKcBIeRyf62pSDsSxnaeGglGxEq2i/L7W9gfRZ+Rjv3GW3G7XIZj479qFfiR+bALWJexz5uWJVlw6c7Q3wuT7zcUSef7kPIBrtmxAJ+R0pjgoUbOjwk6aX/YCR7kDcoqfkLF9+Xqs2RV1uKHDdsHWSF2GxdQNA/5IvG7W/Y6vQd8evvdjNW6dSzRGkVw6reeoTXBveyY9tGxPcz4BL3OiS9fM3hPBeX3qWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnhlRzCt+r3rli6FxjfsOhugaaToyfvMAIeam1DIxHc=;
 b=icJ7xgiXYqhQh4BncvcEpG2QCqVAU1p1y5vY2ivUxRh/GirdzfccaMwZS7LiPBsUpIAU4rkCHzsIDOtzeAS50DDCh62/d65TI28VYKWzuZWiNVJ4aoqGuSvVIIR83uSXDoKYGYDOVXfDsGkj6tScBj2eU/z3rUClS7g43cZZyXInvfUCDz/4jUdQ8tw5tyVJ00Z/rOeM3Joy2p/Wz+/5apD/yzME6v2kJtMLJXnt1VdoxL7rPUMlZTxzuQwuvyff23us9jLsEVAKj4wV1y42IpCfc+GlEas0YYMXYYmG77USLwOfMt129cD1TSzy6VlAUPDy0vGNLCWlI6Y635yxDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnhlRzCt+r3rli6FxjfsOhugaaToyfvMAIeam1DIxHc=;
 b=V9bZ1WebPnalWAJo/P6ZJ1KX9/yMw3ChsE+LyJ5yJ/zLwjvXB7C3cplh5/0rwgZwBqhs9uV21DSv6B2zXhGirF4ZX20ntFERDjS6pCRsx/H1vhzBRmWncuIfO1cM913T875xQ2naJ2H0tEKhyTmK/BR8GJ6qpvAz2C7gv35j/a8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4356.namprd10.prod.outlook.com (2603:10b6:a03:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 16:13:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4027:2de1:2be4:d12e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4027:2de1:2be4:d12e%3]) with mapi id 15.20.7181.020; Thu, 11 Jan 2024
 16:13:01 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Martin Wege <martin.l.wege@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfs-utils&nfsd&autofs not supporting non-2049 TCP port numbers -
 Fwd: showmount -e with custom port number?
Thread-Topic: nfs-utils&nfsd&autofs not supporting non-2049 TCP port numbers -
 Fwd: showmount -e with custom port number?
Thread-Index: 
 AQHaQbEgd95pfR0KM0OZqULK9pLItLDO77KAgAEN8oCAApUkAIAAmDoAgAGRQYCAABJngA==
Date: Thu, 11 Jan 2024 16:13:01 +0000
Message-ID: <F40B2C8D-1967-4666-8990-A719DB889B19@oracle.com>
References: 
 <CALXu0UdFR7Xn51eKFUUi6a68wvDKc-RXz7F4LKyQgDptqfYbgw@mail.gmail.com>
 <CALXu0UfSJ0Qc3HOecf4pQ=VnEVqxRw6OGzNwhh9BUVYaHV7_oQ@mail.gmail.com>
 <ZZwJLb7j65QXR1+K@tissot.1015granger.net>
 <CALXu0UdJanF-_=3TzgzUskwh1RGPjw+LeZ0Cht+yP1aQgr8v+w@mail.gmail.com>
 <B5750E41-D130-44CF-8446-EC71BB149E7D@oracle.com>
 <CANH4o6Mr0UxFboUZE8QurghWDQmqHmFf6nstgdsi5BXeV-Z7dw@mail.gmail.com>
In-Reply-To: 
 <CANH4o6Mr0UxFboUZE8QurghWDQmqHmFf6nstgdsi5BXeV-Z7dw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4356:EE_
x-ms-office365-filtering-correlation-id: e1e7cf01-1b0d-4e4f-1d24-08dc12c02f65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 kQj4LjYrPE7cSMuVh8Tg/fFo1Do3AjxvDZksXRAGFPF1M8aukWb8TdBvYK3mM2c9Vcr7Kmdyt3UIFNhbigJ4oVlCe31OsHXrPbZ9qUy5ADfqPa5w4JJjmytPqZ3GzGxnYURlMQo8mx0+oPwcqVCPyp7NqXLzUGcjg3r9iDH7Pqgn5a3ZcEKJuN1hltUKBcSAk+F4ZaZCmf4sPJvuukRvhLDxI7R8bsr3W4kQy+xJ1WsEGSPEK/X42iPUp4OrB4NUla4t1soIrb+/4nDJ3AA8gqlTqzWPiYDUhqYrX8fVrXpsjS1qsaXxggcvhpufhME/O25DtEj1I6O0787jRcyV73bxz0vt/6Zqy8VgFz3BKqYEmk0wuNjLv5D2vRcI7Pp7rylHcqC7aeNdbAMyW5qD1Qe+sD1vuIaiq71k81X6U+j5c/8gDVxeJCkKFaIVhWubaH+WQwibCXT044IkHwVjpaEgUWW0L2v8pAZ89rg2XdZZDF01UCyU83aDjJRD3/EAk3okaKgrG6pdDnGNtpxfvMeK+DMViYOVdXL2/+p/3L9Nkltm4hoIh89GXyhCoSSsKBwLxOeIJdVOrV1XXhKK+3vEjAkY26Jz0D0eGCBJ/UIVTYCrG8tol/ubDjD0p2DNWDqfjeSYj+MMsu0Ht2tmiQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(36756003)(4326008)(5660300002)(26005)(122000001)(2616005)(33656002)(8936002)(8676002)(41300700001)(2906002)(478600001)(86362001)(38100700002)(6506007)(6486002)(6512007)(66476007)(6916009)(316002)(66556008)(66446008)(64756008)(66946007)(91956017)(76116006)(83380400001)(53546011)(66899024)(38070700009)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?THB0NkJkSzhpUHJxNWsvN2dIeTRrcWZFRWxBLzZudlEzcUpiZGZBREFTWWJa?=
 =?utf-8?B?dmdTamxUNU5DZzVycy9RTDZ3NEFXOThPWmVUNTdJQ0IrbTlFV3RPZTF6Slo4?=
 =?utf-8?B?WllLZm5vWWdwbVh3MG1FRCt4TUljQXU4TU5aWXVDTjlZRVl5S25hTnA0VEVz?=
 =?utf-8?B?L1FCNWNYTnpqdk9kanBwSVpoOXdBMnBCTWZDRVR4ZFVqb29nMjFmL2pKTmpu?=
 =?utf-8?B?SlNrWGNRR1dNUTRPZVNabEtlUnBrS1RraW1BZHdBSEtCaWNqaU41VEozbXhs?=
 =?utf-8?B?eWsvZ0VVR0EzM0xrWC9TWFZYRzlDZTVDWVU4dFgycHFxQkE2Z3RKbDFSc28x?=
 =?utf-8?B?cUVIVlNQck40aGVXY3BBTmR5ZU00cjQ5WGcwQmRnYUg5MU1zTWh1dXZvVDg5?=
 =?utf-8?B?SGlYdWpWZUVBQ05vemswaUE4RnNjeXB4VEMxNkF3TVdQRVlkTGh0RUxoSnMw?=
 =?utf-8?B?R0RCZWpaaDhncmQ3aFljaEYxTzFUNkVFM1U0TU5TdGVkemRPQXN3Qllya2VB?=
 =?utf-8?B?K0hZK3lYSnBra0tpcWtqQU1rZWYxc21pQmdWdVdMQ2xSVE9OTzVvb0VNeUYr?=
 =?utf-8?B?R1B4NWxNN3BmM1RyUUZ6czVHQllhUDRGRk1KNkRjc3kxeXBTQUtPcStnalY4?=
 =?utf-8?B?NzlSemZmVFNCSmN3U2ROOVVIdmZPb2wrQlZHdHkvbFRDMVdSN1dmMmZqdGE3?=
 =?utf-8?B?VFBJc3ExU2Y4M21zQ1MyZWkxOXIzcGFQWHI1dzdYMk5qZkVDdURnbGM0WDVY?=
 =?utf-8?B?SlR4dWQxVTRQc2xhQlRZcTN1czRVL3pUYkE1VlNEWE5jdkVIWDRiUnUvN25H?=
 =?utf-8?B?TjkyN0o5TlNjamtLV2RoZERNeFdrMUlwOHhuWitRcnRKaFlJNXJDSG9DMWV5?=
 =?utf-8?B?WDFBR1AwVVN0b0JZaDdQMVQyZTk1VFFOcStnUzQraVRYbGthY3NDYnhHbkp2?=
 =?utf-8?B?NFR0UGdvd1VqT0hKS3dTZTFKengwSXhUWDRiZCtMeGtrVnFQcWphY2hGeS9n?=
 =?utf-8?B?YkJCOWM5U2hHM3pXTVdObC84U1M4Uk9pSDljMHZOZVZBSGYxZXRNTzlNY0dH?=
 =?utf-8?B?SzhnVHViWEZYOGZyN3laTzkxTzNsTEdxaXVlL1RtdkJ6dDhFUXNVcm0xMXN0?=
 =?utf-8?B?c002dS9NNSs4cWdYN0x3dlJOMGR0M3VGeWVxNzJOMnhmckNXTXVFcEIwMERU?=
 =?utf-8?B?SUNlbm9uY05TOXpFcmZTenRzekFZUkJqd0lyQlhaRUlKSWlRc2ZLSDZEam91?=
 =?utf-8?B?d3VBVmthb1FaTG9NRk94MWVpMFFkMUk1UkcveDkwSnhFc1dydy9qSWxMZzRt?=
 =?utf-8?B?NndOWG5hS01XWEoxZjNTSkNzNFJhU0VWUGNpbjBSUllpa1NhcTVxRHVGNFor?=
 =?utf-8?B?cW51L0F2UklaOU9Na2RPTGZ6ZjNFYTRMeFRxTFFPV3pDS1ZDNXVNenlIR1BY?=
 =?utf-8?B?T2tSbFVHWWMrRmpSNnIxWFdlY09za3B2L2ZNWTV3QXgrZFVWemVXUVQwcDNt?=
 =?utf-8?B?QVFMTTNMQk1KejQxRUdWS2F6eGJKRDRYZ2pUaGJlZlQ1Tld5aFB2OTZsL0JX?=
 =?utf-8?B?VHdVRFdqMk16MWFrSnZrbzJwc2lUZ21DWGNoYWJ4WERZeWk5YmpVc3hocE5m?=
 =?utf-8?B?TUJxUEhzV2psMm9hU3lCd0NUbS9qd2ZyZWxWWUJIeWE4WGhrZUQrclVJOXF4?=
 =?utf-8?B?YUI4MUp4Rm5vVEV6YTFhUnU5UUY3bFRTM3dOeTFnVGFKZmhXeGVYTEwvMUkx?=
 =?utf-8?B?SDFpZ3paVFBwNDNJUmxXemJHQUR2bDd2c1Z2VDFXZlVCRDNYaUlKR1I0SHR2?=
 =?utf-8?B?YTlFczN3TXZHK3VtbkxFSzFJWmowdTcxRk03NUpSRjd1MUxUQUZ5TmE2MTAy?=
 =?utf-8?B?WCtHVzByeUptamxHL21Sb0pPNEt2RHkyRmdYTWRKd0RSU2V5MWRVaGYxajJx?=
 =?utf-8?B?MTdlKzBuamg3OHJuOS9CMkVMK0grQk1kejFONFZvb2gxMTNGb1FwcXZJMnJr?=
 =?utf-8?B?b0s5bFBXVWZlRllLaHoyelI5WEdpczBEeHZLZDA0U2JnTk4zSEJSVGtqU3A0?=
 =?utf-8?B?Q25xclBrTGI3cFRTOVdGb1dtNS96NDdIb1NkcERCVGhVNStDL0trMGN6N1dl?=
 =?utf-8?B?N2Q0YlN5WFNzZS9hOEFyOVB2a2JHQWwrRE5hZXk4RUdXZDVEUGRBNGhESmdZ?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6467AABC9E13AF44B270A1B13DE24860@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KkpvccwxOJi4f/SpwMDX9AM2xPZbwPNg4dZJ7XX8//NFFGh8viV+zRr2u2u1/fEZ+3VEILo7sLEKKKIY60csfp8i046p6bD6EFk4cXHQYhKG1JOsZ1ch65UdqiOIpdigIVnz7LgEmU/nFmOGienxAWIxgRJaMGrO8adizcGSzQtRkdyJd/YtN2lxJ4YQzqc04pGnS0F1h9Q7EKK9kaVYtXXIJVK9L2nV3cc/1WKAYlCEHBtdGmNBRF4zEpPcHYL+gGz2fJ48i9OxfQDOUxqbs8RcYrXxeUxzhWI2sFMJz6wJk0zmdoTNF9B5zgHFBBas9OfvoH+UwE8I+H1zNhx8Z05qX2K8mXEn3fs5P25H/rP+Mf6gtIRPftOL0UTjOCZLoVAT31DEbLEAsnF7hWquBD9yYyedxVwIEYEiACokOwvd/1tQFPFaYKYR2vhLNh7tAN2kZUCV10XaUqC3elTEmr2Zx96eJyHAZeiIcriNZiiOUlxN5lUxcRjwjv6LErNYZZn6vRzZ/46t79jGwWy68RMwsuAGlSW0kUmkIlfSvmW8FdN/ncIkRUNiwp5YhhWFgtONJXYVAd79cjXtfoX7Nb4cJ+G00ZZfGs/yxJ5rQks=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e7cf01-1b0d-4e4f-1d24-08dc12c02f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 16:13:01.7824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UELruZAYRVr6HUgvaTJDHgspsDTqUcTbCFzLyRjGXzDJSY5ouUD/suVL0VxO5WDdxvB1A6q+l90ItFRqSUVNAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_09,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110127
X-Proofpoint-GUID: h9rb_zC2e_JIr9aybaDJzAiTcNR35HYV
X-Proofpoint-ORIG-GUID: h9rb_zC2e_JIr9aybaDJzAiTcNR35HYV

DQoNCj4gT24gSmFuIDExLCAyMDI0LCBhdCAxMDowNuKAr0FNLCBNYXJ0aW4gV2VnZSA8bWFydGlu
Lmwud2VnZUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBKYW4gMTAsIDIwMjQgYXQg
NDoxMeKAr1BNIENodWNrIExldmVyIElJSSA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6
DQo+PiANCj4+IA0KPj4gSW4gbW9zdCBvZiB0aGVzZSBjYXNlcywgdGhlIHVzZSBvZiBhbHRlcm5h
dGUgcG9ydHMgaGFzIGJlZW4NCj4+IHN1cGVyY2VkZWQgaW4gdGhlIHBhc3QgMjAgeWVhcnMuDQo+
IA0KPiBGcm9tIGEgdmlld3BvaW50IG9mIHVuaXZlcnNpdHkgaG9zdGluZywgSFBDIGVudmlyb25t
ZW50cyBhbmQgcHJldHR5DQo+IG11Y2ggZXZlcnl0aGluZyBlbHNlIEkndmUgc2VlbiwgdGhhdCBz
dGF0ZW1lbnQgaXMgRkFSIGZyb20gcmVhbGl0eS4NCj4gVGhpcyBldmVuIGdldHMgd29yc2UgaW4g
R2VybWFueSwgRXVyb3BlIGFuZCBBc2lhIChub3QgVVMgb2YgY291cnNlLA0KPiB5b3UncmUgaG9n
Z2luZyBwdWJsaWMgSVB2NCBhZGRyZXNzZXMpLCB3aGVyZSB3ZSBoYXZlIElQdjQgYWRkcmVzcw0K
PiBzaG9ydGFnZSwgbG90cyBvZiBOQVQsIGFuZCBvbmx5IGEgc21hbGwgYW1vdW50IG9mIElQdjYg
KGV4Y2VwdCBBc2lhKS4NCj4gSW4gYWxsIHRoZXNlIHNjZW5hcmlvcyB5b3UgaGF2ZSBORlN2NCBj
b25uZWN0aW9ucyBhbGwgb3ZlciB0aGUgcG9ydA0KPiBudW1iZXJzLCBhbmQgbm90IG9ubHkgMjA0
OS4NCj4gDQo+IEFsc28sIHJlYWxpdHkgaXMsIHN0b3JhZ2UgdmlydHVhbGlzYXRpb24gZm9yIE5G
U3Y0IG9uIHRoZSBvdXRnb2luZw0KPiBzaWRlIGlzIHR5cGljYWxseSBkb25lIG9uIHRoZSBwb3J0
IGxldmVsLCBhbmQgbm90IElQIGFkZHJlc3MgbGV2ZWwsDQo+IGUuZy4gbWFueSBzZXJ2ZXJzIGJl
aGluZCBOQVQsIGFuZCBOQVQgdGhlbiB0cmFuc2xhdGVzIHRoZSBhY2Nlc3NlcyB0bw0KPiB0aGUg
TkZTdjQgc2VydmVyIGludG8gYSBzaW5nbGUgSVB2NCBhZGRyZXNzIHdpdGggZGlmZmVyZW50IHBv
cnRzDQo+IChiZWNhdXNlIG9mIGFkZHJlc3Mgc2hvcnRhZ2UpLiBBbmQgYmVjYXVzZSBvZiBjb252
ZW5pZW5jZSwgdGhlIE5GU3Y0DQo+IHNlcnZlcnMgc3RhcnQgd2l0aCB0aGUgc2FtZSBwb3J0IG51
bWJlciBhcyB1c2VkIGJ5IE5BVCBvbiB0aGUNCj4gb3V0c2lkZS4uLg0KPiANCj4gU2hvcnQ6IE5v
bi0yMDQ5IHBvcnQgbnVtYmVyIGFyZSB0aGUgbm90IGEgImNvcm5lciBjYXNlIg0KDQpXZWxsIHRo
YXQncyB2ZXJ5IG5pY2UsIGJ1dCB0aGlzIGlzIHRoZSBmaXJzdCBJJ3ZlIGhlYXJkIG9mIHRoZXNl
DQpyZXF1ZXN0cyBhbmQgdXNlIGNhc2VzLiBUZWxsaW5nIG1lIG15IGxpdmVkIGV4cGVyaWVuY2Ug
aXMgImZhcg0KZnJvbSByZWFsaXR5IiBpcyBub3QgYSBnb29kIHdheSB0byBnZXQgeW91ciBmZWF0
dXJlIGludG8gb3VyIGNvZGUNCmJhc2UuIEFuZCBpdCdzIHJlYWxseSBub3Qgb24gcG9pbnQsIHVu
bGVzcyB5b3VyIG9ubHkgcG9pbnQgaXMgdG8NCnRlbGwgbWUgaG93IHdyb25nIEkgYW0uDQoNCkkg
d2lsbCByZXBlYXQsIHlldCBhZ2FpbjoNCg0KYS4gTGludXggTkZTIC9kb2VzLyBzdXBwb3J0IGFs
dGVybmF0ZSBwb3J0cywgYnV0IHRoZXJlIGFyZSBidWdzDQoNCmIuIFdlIC9kby8gaGF2ZSBhIHBs
YW4gdG8gc3VwcG9ydCBhbHRlcm5hdGUgcG9ydHMgaW4gTkZTdjQNCiAgIHJlZmVycmFscw0KDQpj
LiBXZSBjdXJyZW50bHkgZG9uJ3QgaGF2ZSB0aGUgcmVzb3VyY2VzIHRvIGZvY3VzIG9uIHRoZSBw
YXJ0cw0KICAgb2YgdGhhdCB0aGF0IHdpbGwgYmUgYSBoZWF2eSBsaWZ0LiBCdXQgd2Ugd2lsbCBn
ZXQgdG8gaXQNCiAgIGV2ZW50dWFsbHkuDQoNCmQuIFRvIGdldCB5b3VyIG5lZWRzIHByaW9yaXRp
emVkLCBzZW5kIHBhdGNoZXMuDQoNCg0KWW91IGd1eXMgY2xlYXJseSBkbyBub3Qga25vdyB3aGF0
IGVsc2UgaXMgb24gb3VyIHBsYXRlLCBub3IgZG8NCnlvdSB1bmRlcnN0YW5kIGhvdyBmZXcgdGhl
cmUgYXJlIGluIHRoZSBMaW51eCBORlMgY29tbXVuaXR5LiBXZQ0KdGhpbmsgdGhhdCBnb29kIHNl
Y3VyaXR5LCBpbnRlcm9wZXJhYmlsaXR5LCBhbmQgcGVyZm9ybWFuY2UgYXJlDQp0aGUgdG9wIHBy
aW9yaXR5LCBhbmQgZGVhbGluZyB3aXRoIGJ1Z3MgYW5kIHJlZ3Jlc3Npb25zIGlzIHVwDQp0aGVy
ZSBhcyB3ZWxsLg0KDQpJZiB0aGlzIGZlYXR1cmUgaXMgaW1wb3J0YW50IHRvIHRoZSBIUEMgY29t
bXVuaXR5LCB0aGV5IHNob3VsZA0KZnVuZCBhIHNvZnR3YXJlIGNvbnN1bHRhbnQgdG8gaW1wbGVt
ZW50IHdoYXQgeW91IG5lZWQgYW5kIHdvcmsNCndpdGggdXMgdG8gbWVyZ2UgaXQuIFRoYXQgaXMg
dGhlIHdheSBvcGVuIHNvdXJjZSB3b3Jrcy4gVGhhdA0Ka2luZCBvZiB0ZWNobm9sb2d5IHRyYW5z
ZmVyIGhhcyB3b3JrZWQgZm9yIG1hbnkgbWFueSB5ZWFycy4NCg0KU2luY2UgdGhhdCBoYXMgbm90
IGhhcHBlbmVkIGluIHRoZSBwYXN0IHR3byBkZWNhZGVzLCBJIHRoaW5rIEkNCmFtIGNvcnJlY3Qg
dG8gYXNzdW1lIHRoYXQgYWx0ZXJuYXRlIHBvcnRzIGFyZSwgaW4gcmVhbGl0eSwNCndvcmtpbmcg
d2VsbCBlbm91Z2ggZm9yIHRoYXQgY29tbXVuaXR5IGFscmVhZHkuDQoNCklmIHlvdSdyZSBzaW1w
bHkgZ29pbmcgdG8gZGVtYW5kIHRoYXQgd2UgaW1wbGVtZW50IHlvdXIgZmF2b3JpdGUNCmZlYXR1
cmUgd2l0aG91dCBvZmZlcmluZyB1c2VyIHN0b3JpZXMgb3IgdXNlIGNhc2VzIG9yIHBhdGNoZXMg
b3INCmFueSBvdGhlciBjb250ZXh0IG9yIGhlbHAsIHRoZW4gd2Ugd2lsbCB0cmVhdCB5b3UgbGlr
ZSB0cm9sbHMuDQpCZWNhdXNlIGhvbmVzdGx5LCBndXlzLCB5b3UgYXJlIGFjdGluZyBsaWtlIHRy
b2xscy4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

