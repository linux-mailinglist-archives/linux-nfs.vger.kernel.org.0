Return-Path: <linux-nfs+bounces-1726-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C79847FF2
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Feb 2024 04:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C6D2896BF
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Feb 2024 03:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D375DDCE;
	Sat,  3 Feb 2024 03:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xb7Olcb0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jE5xQd04"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A88EF51F;
	Sat,  3 Feb 2024 03:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706931831; cv=fail; b=nG7jgderj/tuB5SqdSXvcpAEEb8u5XeA9KRmOCLXZjgoT7teQJW0Jsf7xeVkCGAVSszQt8lKP3iIAbCCazX3zOLaOfAU0BiISImJnuiipYsHITKJ8/elvwEJD8wicS3ESqY56DyRAgjL6vlptMmz7UQzhGQo8/N+O6vZe4xr1Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706931831; c=relaxed/simple;
	bh=2NakcRcUvEu8nl9Z05Y43CLcjlHFCRXLqL9NqRpvc3k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hpxe/19P3Hu15H/PJ3Gn2KVDyE+KM/nzWXvfjyar3O1Si2BwqbSsD1PThmu+qz40cTJgDSElP1sitxen77mZnNAA9gRZvYknuSuha5UHRqHLCxXfuJqnxIX9wSHDc6YD6aA6hryvzFLkpnMTyS+5EOGw/nCpk66mDGCauw7nBTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xb7Olcb0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jE5xQd04; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 413267b0001489;
	Sat, 3 Feb 2024 03:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2NakcRcUvEu8nl9Z05Y43CLcjlHFCRXLqL9NqRpvc3k=;
 b=Xb7Olcb01TZBC8fbmyX8+jCdzqMn8uLT4jk0lVWR1dp2MtpnS2smuYa9KQNiI+aTJGM2
 Sz+04CDQFCooMCUy+oz9BALKJVxMJtqoSgoo6dD9rESN/HsyGMWCJ7hdPCDUKmjiNvb6
 aqRODrugkxOLigJ8o9J1zLiaQwaP0ks1xY3JcZO2GWJmVjICmQ7HfZjdZ6JAK+CoRYdY
 Cbiull5oehVqUbd8e8qKFEM5akTeJLsnsDYpls+/7L8EyVRO1kFFgPMkwUx7/AxrlBdx
 VEtNxMJS5t5YT6IPYg7dqLgkijqSszFi1LDOe/iSFdXWnro1KY7xv/6gXxfSsCW4Dehn RA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1cdcr2w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Feb 2024 03:43:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4131XTmR007103;
	Sat, 3 Feb 2024 03:43:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx3atrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Feb 2024 03:43:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwe9aYC80r7Ss0PRJ4JPMDPpBQw/Hmv5KxQ4TeRpG8pHKx9yo+v/cafkDB8VxIFXbXyv/KU5egtSAwpIfxPYZRbYMgBZLP/FQr4TMzJMsfbBg2mJkhB9mn11lTyJ+l3SduU3L8MaxWi2XF/XYOsj4RCLHDarQDl6gaSot/jSnCb8+yN6YyfRdI+vaRII4VxlafIcyelaU978kiGsEi1MDxFaDcWO8PQaPjT/Pjer5PDZOHM4jdzQdza2Fu+rRol61k56vCcJ7Cp1lGW0lukHA+cttZD6PiEnS5BKNdRl3TAl3HGCoS+meU2GC0v0F8THGHA5DuI1j2s1Y1J63SuIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NakcRcUvEu8nl9Z05Y43CLcjlHFCRXLqL9NqRpvc3k=;
 b=nkVcQh0Kr5MR+bcAOG4dLtgCzsr4sixZ5Jtn20+3a+5m9/9IF5Zj3PbOjO4+5SGwL/Im5XlUeooT+3V/CD1wuFy5NGa0YBoARHtUv1CIXsq2dEXJim+ZXBys64sW+qGA8QsoCIJqfobEn7n2BV7MkoKcVKQa3Sj2HVTZNxbQirz0cYrJZwbGVo8Wb/oofILXaDTcNfEQaB/+nCEXkGD7D/oyD54K2bpBkj/6afc/XQlVwcAS3ShDfpysZdjUO18Sd7x/ArgAEKvMwULdOob3wMXqAtCd7A7fYm2rEznL6r51PCz3R0p4E3XaY3qmWqje02kFH2VZLUVkUvbnwB6iww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NakcRcUvEu8nl9Z05Y43CLcjlHFCRXLqL9NqRpvc3k=;
 b=jE5xQd04mac9V3j+Jkb0JZic9YGY26/pAaczM+7uuRK1igHwDpEKVzBIr7JnuH8LHQWDiIZCZDhvLszc67C3VYuT2wMc/UQpdqOETWZXpvCoylL9bd2CNsnA0oRtHypE6JyI0S0Zp/9FG4aqpAJ4vLad1V81IzH8ZYl2+riYgJI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7262.namprd10.prod.outlook.com (2603:10b6:208:3f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Sat, 3 Feb
 2024 03:43:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.027; Sat, 3 Feb 2024
 03:43:35 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: linux-stable <stable@vger.kernel.org>, Chuck Lever <cel@kernel.org>,
        Linux
 NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Fix RELEASE_LOCKOWNER
Thread-Topic: [PATCH 0/3] Fix RELEASE_LOCKOWNER
Thread-Index: AQHaVUHX31DjrREGIECKix3zT1lNDrD2EGmAgAEIp4CAAKuTAIAANyGA
Date: Sat, 3 Feb 2024 03:43:35 +0000
Message-ID: <72D3277A-76B5-44DE-B03F-2E1F640C27E4@oracle.com>
References: 
 <170681433624.15250.5881267576986350500.stgit@klimt.1015granger.net>
 <170682628772.13976.3551007711597007133@noble.neil.brown.name>
 <FF7C90E0-251D-48D2-908B-E2145B0B9BAE@oracle.com>
 <170691996664.13976.18138125578593325497@noble.neil.brown.name>
In-Reply-To: <170691996664.13976.18138125578593325497@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB7262:EE_
x-ms-office365-filtering-correlation-id: cf6acc34-0338-4827-15dc-08dc246a4cff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7INbzkFjvac72dHW7iUmlmtikgjlvO6Hn6p+ctQJT6cV4DpmeVew7Hs3OLR0f45n6H32VGlc3FYh9lrsYE0gC3vRVanwcmRiLVZ83s+YhjSEsfmi+R7SfgeGtoBtj8aSKy3Z3QVWRFL17iupScA8JPFKLvZJtE0w1QZdRSqDI1HiKpi1xQsjwSPP8mGkiyi8lkOBuscSeTrJKTN9UGHXDFI/phuGWWXfqDaf9K3erRa4dTpEPy4QQ9WRtsedoL6dEL8GoVZcqvFUwvwO2WOXQBq2BTLt/ulGzbD208j9Vg0H/8DA/UCJoebOtbD3VrSceEy7r0QLXmeqnEaOMvJQzzT+F1T06XlcooKCcKkDZwU3UzGj3n3oT3avupAna8K6iLB++poXVnzbb0pfrrs1WFO5+ngM22VDMP6WgTypBvEAc3UXYrIBZkMdShvOi1HpbjntLOMig6maztHPqovbRStSpOhfTI5W+N/mqE4gXN3y6j4p9yiaf2bfmkkVZmyTN2bgmWD2AIRerhNKtYjg2vXybl9D11Ax8i8mK3BVJguqxn0Sl1GhZ/vNzZ9XDIrJSyseYHwe3qfNKgc4AB0bxnB3dw9dKNlBXbRvJqNm8ER9k+I1mB3m2+TEhyQv46n2s1nlDcMAQSAFeWJJc4fmCA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(2616005)(41300700001)(36756003)(38070700009)(316002)(6916009)(6512007)(966005)(6486002)(478600001)(6506007)(53546011)(83380400001)(71200400001)(38100700002)(122000001)(64756008)(54906003)(2906002)(5660300002)(33656002)(66446008)(66476007)(66556008)(66946007)(76116006)(86362001)(8676002)(8936002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OFZ5NmR5QlA0NTN2OXJrUnBQcXIzcDZXZ043UmNJbTZEVGNjclBXZ1R3TnVj?=
 =?utf-8?B?NlM4YnF3WFV0dlBxZkVwTzQycnlXYUxtNGNDbm5QQnYrdWNHWEtsVUE0RXBh?=
 =?utf-8?B?VWlZTlZDMTArbmIxVHhiemNvZFNobjRsSVFic1pvVTFSak1GT3N3eHpqRU41?=
 =?utf-8?B?THFkSmhTaGtETUxNVVQrY0hjVUxlU1MxbzBPblF2UWtTV1MzOGYvb1ZDZmZV?=
 =?utf-8?B?TFNqbEU0YkNzekFSU05BV2RWeU9oTmUybUZHM3JKbTFaa25ZS0ZXVU5udWpn?=
 =?utf-8?B?V0hOVWJnWHRTMnR6SDRkblZNa2Vjakhua3dVNnJNa25zellWSjVVQWM2QWxz?=
 =?utf-8?B?NHFLUWEyZW9nRGNwdzVpUHp0N0xqenlZQmFGTHFCMGJZbithZnJXTWJldkFX?=
 =?utf-8?B?Y1JWRGlacENOckJNUzdvYXQyZ1BrRU9QbE5NR3NJYy93aVVvT24xRWJCallw?=
 =?utf-8?B?Q0JoOWF4WjlDY3dhRVB0Y3VXRHBaNDVybUY0dHF3cGE0TkNaNHoweGhRUU5M?=
 =?utf-8?B?RnpycVJFcWpVU2RTbTJIQ0NFeEVidUF4UUh2WnZvd0JGbEpGNlhXN2pDQXVk?=
 =?utf-8?B?R3ZEVEJtejZDc29aRkp5Rlp6d25ydVhLeXJhSmhURW00ZVlSOUxrbXBmYU5B?=
 =?utf-8?B?QjM1S3ptNnpaUnhSM3gxQVVXSU02VXpQbHlHQzVCczJzbEYzc2Y4eXdycEtR?=
 =?utf-8?B?QjFnY1JHK3NuUnZ5emRqZ3dYb1BKQ0N3SXFmRVBTWnk1SWZ4K25BYU1xTHRP?=
 =?utf-8?B?dnQ1VlNlVjRmOGs1S0Y3RzVZR1UxQVE2UCtCZzdncmlkNWMyTzA1dFZwbmJZ?=
 =?utf-8?B?MHk1dFQ2RWkwWktVaHp2YTdoajAzeVc3NmExRm5pTUE5RFg5bkpWNDYxWEVR?=
 =?utf-8?B?NWtMTGRST01CSndQeVR4NVQ3elJKZ0lhQldXemhUWUZZVzJ0RUN0OWpjdlRL?=
 =?utf-8?B?T0tiWmpydUR3d2IrYjNuNXFUUjJIYUtodUdkY2dRdUhQU0svdVVJeTluOVRh?=
 =?utf-8?B?blREZk1zTDcyR2JuNzBnRitRNnhNbmsyUDh3NWlkbHp0UGt6bENCZ1dKL2NZ?=
 =?utf-8?B?UTFpVkFZdmRKODlCUllQNnBTaXJzV2h0Si93ZVJ6L2d0aGkxbi9jRlRZbHlU?=
 =?utf-8?B?VG1DYkNFL0ZFSEwzdWlocklVcHYxc0dmdkR2MmRlZjFrSzNQUFZIaUp2ZHk4?=
 =?utf-8?B?U3A4TEJIOWdLbXhwLzFxb2F4MnNCUW8yTjlXTzBYN1FYcWtKZ2RGQVh0VGNQ?=
 =?utf-8?B?VlpCaTRkUDUydHpWYXVFRnlLeStBYlkxMU9xU012V3NJeXM0TWs4T3hKYTZm?=
 =?utf-8?B?VHBpN3VDaFpIK1Z5WXc5RlY4VmFKQUs2dHhCaWVabncyc3FPM2hGKzhrSXZE?=
 =?utf-8?B?ZFpuUStxNWxwbzIrWkRCQUYzL2Y0bnhjR2FtSXZHK3FrQ2s0MG5NR0VCUHp2?=
 =?utf-8?B?QmtMOFJsVGhLdVFFTGxwanYrQTRqV3NsZktYRjB5UU1UdWRWTmJaUjNuTjdk?=
 =?utf-8?B?dXlOc1kxVDhBdy95VitPL0V5bEZBTG53TGRqa2trbnpvdTh4RVNMT01CcU9a?=
 =?utf-8?B?RmZQQVR4dmlDWkVRQVduVnVPaTJQTUhhZ1Z5TWZpTVFLOXBicms5N1BJTVBZ?=
 =?utf-8?B?d1dhV0d1T1VyOVlTbGUrWDBKcmg4SUtvTU1zOGcxOG5LblRtNGpTN3BrN0E2?=
 =?utf-8?B?SEVQS0FnVGJqa2lGNkFOdDJKdlRMUS9XUWlTWDVaVUxZV2lBVXhXSXA0OEFP?=
 =?utf-8?B?MTdINlRTUDFtaDlONVp1SHQxWGR6OUpIYkxEWXJsQmpIT2U5UVZKVzdQTHZV?=
 =?utf-8?B?OWY1TzIzb3Y5NmdhQVZUcGZyRUIydWEralpBU013d216VTRKZ0gxTk1QTVhu?=
 =?utf-8?B?YVdLdDQ0dG1Td08yTWtTc0NQS2pDNGd1RDlyMVZPTHVtS0xSQVJUS1NyeHpR?=
 =?utf-8?B?Ti9zdmlvUi83OVlhelA1dTgraTJWZWRTMldyeXZYRldkcTE0dHZxeFFsc3Yz?=
 =?utf-8?B?bnU5UVppM2tCSDRKSWRFUDJia3hSb283c0JESHFjSVNHUTZETWJMTHNxR0J5?=
 =?utf-8?B?N1R2amhORGcxTEhIcnA2b21mYVM2SHA1anFULzhxTytBQ1Z1TXJuTWhGN1ZP?=
 =?utf-8?B?QmRXU0ZQQXBydUt4Vk9YVkNCQjV3c1BrNEswSmVudUw5a0FGNlo2Y0diOEVY?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0E7367182B8204088E5F5D200410D11@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7uqGvA30Aai5cC+rDHzbmsz1m7p2+UtNMTuHBX2OZc0zWLgn83trgm1Lh0/1whfaOSRkcdUDr6ZmPvy++C7i4yb4ZudYdD8qmS/S/2V6zJxzaiBWeWux+3c0/vOw/RJMEyjrBWpqvkEfiKa+XRUEOJDKCJLJZTb2Vch0MO1nKXV502EXxAZxrItb7LgzU4zp8A0Xc1dWAx5iDLQdeEq8kztm5psyP1hZvCB/8thSorQZXLEghBrv/U8oY8DgLVFjZwRxh2Ln5iwSOZiF7LcxQ+e439VADpvgSnrCr21PdvEa+rv+NHbtabKmA7G0uU+Szt63eNef+aOs04bP5QW/ejw1WJx3rZukVic8gnFyZZBF5duZGxahngVU/SNeJDrO+pcsIpKK86iUEnh8GH6AukxZC/QUDMgkh8fvhljREzn0Ihir2l4ihwZoG1gDK9tBL6TKR1PUQtMpJRT+BM5KBzE2APFK6WktlPRZzOXdsDsDmFQ7/jqVB7v+GlFXcXrtMvx/A4up6AFSROu9dscCcylzTgad5B4fq87ho0O3ID3ZgLbGoBq/84hqcRXQfSthVO1DuhBbR8hJIsVRdXTohLuDOu8SAMkUnFx8FIFNnX4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6acc34-0338-4827-15dc-08dc246a4cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2024 03:43:35.6301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ug/vP1YnjzPjwAa3jEaVu9+KHO/pE+utUBTSvJOxSiL+nehd7YknuBz4BJ6IUyOdpzN9J8w1Y6xV/43224yhOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7262
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402030023
X-Proofpoint-GUID: qjGFR8dibs_4jIuA5nbDlaNcXbDq0uMU
X-Proofpoint-ORIG-GUID: qjGFR8dibs_4jIuA5nbDlaNcXbDq0uMU

DQoNCj4gT24gRmViIDIsIDIwMjQsIGF0IDc6MjbigK9QTSwgTmVpbEJyb3duIDxuZWlsYkBzdXNl
LmRlPiB3cm90ZToNCj4gDQo+IE9uIFNhdCwgMDMgRmViIDIwMjQsIENodWNrIExldmVyIElJSSB3
cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gRmViIDEsIDIwMjQsIGF0IDU6MjTigK9QTSwgTmVpbEJy
b3duIDxuZWlsYkBzdXNlLmRlPiB3cm90ZToNCj4+PiANCj4+PiBPbiBGcmksIDAyIEZlYiAyMDI0
LCBDaHVjayBMZXZlciB3cm90ZToNCj4+Pj4gUGFzc2VzIHB5bmZzLCBmc3Rlc3RzLCBhbmQgdGhl
IGdpdCByZWdyZXNzaW9uIHN1aXRlLiBQbGVhc2UgYXBwbHkNCj4+Pj4gdGhlc2UgdG8gb3JpZ2lu
L2xpbnV4LTUuNC55Lg0KPj4+IA0KPj4+IEkgc2hvdWxkIGhhdmUgbWVudGlvbmVkIHRoaXMgYSBk
YXkgb3IgdHdvIGFnbyBidXQgSSBoYWRuJ3QgcXVpdGUgbWFkZQ0KPj4+IGFsbCB0aGUgY29ubmVj
dGlvbiB5ZXQuLi4NCj4+PiANCj4+PiBUaGUgUkVMRUFTRV9MT0NLT1dORVIgYnVnIHdhcyBtYXNr
aW5nIGEgZG91YmxlLWZyZWUgYnVnIHRoYXQgd2FzIGZpeGVkDQo+Pj4gYnkNCj4+PiBDb21taXQg
NDc0NDZkNzRmMTcwICgibmZzZDQ6IGFkZCByZWZjb3VudCBmb3IgbmZzZDRfYmxvY2tlZF9sb2Nr
IikNCj4+PiB3aGljaCBsYW5kZWQgaW4gdjUuMTcgYW5kIHdhc24ndCBtYXJrZWQgYXMgYSBidWdm
aXgsIGFuZCBzbyBoYXMgbm90IGdvbmUgdG8NCj4+PiBzdGFibGUga2VybmVscy4NCj4+IA0KPj4g
VGhlbiwgaW5zdHJ1Y3Rpb25zIHRvIHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc6DQo+PiANCj4+IERv
IG5vdCBhcHBseSB0aGUgcGF0Y2hlcyBJIGp1c3Qgc2VudCBmb3IgNS4xNSwgNS4xMCwgYW5kIDUu
NC4gSSB3aWxsDQo+PiBhcHBseSA0NzQ0NmQ3NGYxNzAsIHJ1biB0aGUgdGVzdHMgYWdhaW4sIGFu
ZCByZXNlbmQuDQo+PiANCj4+IA0KPj4+IEFueSBrZXJuZWwgZWFybGllciB0aGFuIHY1LjE3IHRo
YXQgcmVjZWl2ZXMgdGhlIFJFTEVBU0VfTE9DS09XTkVSIGZpeA0KPj4+IGFsc28gbmVlZHMgdGhl
IG5mc2Q0X2Jsb2NrZWRfbG9jayBmaXguICBUaGVyZSBpcyBhIG1pbm9yIGZvbGxvdy11cCBmaXgN
Cj4+PiBmb3IgdGhhdCBuZnNkNF9ibG9ja2VkX2xvY2sgZml4IHdoaWNoIENodWNrIHF1ZXVlZCB5
ZXN0ZXJkYXkuDQo+Pj4gDQo+Pj4gVGhlIHByb2JsZW0gc2NlbmFyaW8gaXMgdGhhdCBhbiBuZnNk
NF9sb2NrKCkgY2FsbCBmaW5kcyBhIGNvbmZsaWN0aW5nDQo+Pj4gbG9jayBhbmQgc28gaGFzIGEg
cmVmZXJlbmNlIHRvIGEgcGFydGljdWxhciBuZnNkNF9ibG9ja2VkX2xvY2suICBBIGNvbmN1cnJl
bnQNCj4+PiBuZnNkNF9yZWFkX2xvY2tvd25lciBjYWxsIGZyZWVzIGFsbCB0aGUgbmZzZDRfYmxv
Y2tlZF9sb2NrcyBpbmNsdWRpbmcNCj4+PiB0aGUgb25lIGhlbGQgaW4gbmZzZDRfbG9jaygpLiAg
bmZzZDRfbG9jayB0aGVuIHRyaWVzIHRvIGZyZWUgdGhlDQo+Pj4gYmxvY2tlZF9sb2NrIGl0IGhh
cywgYW5kIHJlc3VsdHMgaW4gYSBkb3VibGUtZnJlZSBvciBhIHVzZS1hZnRlci1mcmVlLg0KPj4+
IA0KPj4+IEJlZm9yZSBlaXRoZXIgcGF0Y2ggaXMgYXBwbGllZCwgdGhlIGV4dHJhIHJlZmVyZW5j
ZSBvbiB0aGUgbG9jay1vd25lcg0KPj4+IHRoYW4gbmZzZDRfbG9jayBob2xkcyBjYXVzZXMgbmZz
ZDRfcmVhbGVhc2VfbG9ja293bmVyKCkgdG8gaW5jb3JyZWN0bHkNCj4+PiByZXR1cm4gYW4gZXJy
b3IgYW5kIE5PVCBmcmVlIHRoZSBibG9ja3NfbG9jay4NCj4+PiBXaXRoIG9ubHkgdGhlIFJFTEVB
U0VfTE9DS09XTkVSIGZpeCBhcHBsaWVkLCB0aGUgZG91YmxlLWZyZWUgaGFwcGVucy4NCj4+IA0K
Pj4gT3VyIHRlc3Qgc3VpdGUgY3VycmVudGx5IGRvZXMgbm90IGV4ZXJjaXNlIHRoaXMgdXNlIGNh
c2UsIGFwcGFyZW50bHkuDQo+PiBJIGRpZG4ndCBzZWUgYSBwcm9ibGVtIGxpa2UgdGhpcyBkdXJp
bmcgdGVzdGluZy4NCj4+IA0KPiANCj4gT3VyIE9wZW5RQSB0ZXN0aW5nIGZvdW5kIGl0IChhcyBk
aWQgb3VyIGN1c3RvbWVyIDotKS4NCj4gUXVvdGluZyBmcm9tIGEgYnVnemlsbGEgdGhhdCB1bmZv
cnR1bmF0ZWx5IGlzIG5vdCBwdWJsaWMgKHRob3VnaCBtaWdodA0KPiBub3QgYmUgYWNjZXNzaWJs
ZSB0byBhbnlvbmUgd2l0aCBhbiBhY2NvdW50KQ0KPiANCj4gaHR0cHM6Ly9idWd6aWxsYS5zdXNl
LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTIxOTM0OQ0KPiANCj4gICAgIExUUCB0ZXN0IG5mc2xvY2sw
MS5zaCByYW5kb21seSBmYWlscyBvbiB0aGUgbGF0ZXN0IFNMRS0xNVNQNCBhbmQNCj4gICAgIFNM
RS0xNVNQNSBLT1RELiAgVGhlIGZhaWx1cmVzIGFwcGVhciBvbmx5IHdoZW4gdGVzdGluZyBORlMg
cHJvdG9jb2wNCj4gICAgIHY0LjAsIG90aGVyIHZlcnNpb25zIGRvIG5vdCBzZWVtIHRvIGJlIGFm
ZmVjdGVkLiAgVGhlIHRlc3QgZWl0aGVyDQo+ICAgICBnZXRzIHN0dWNrIG9yIHNvbWV0aW1lcyB0
cmlnZ2VycyBrZXJuZWwgb29wcy4gIFRoZSBjb250ZW50cyBvZiB0aGUNCj4gICAgIGtlcm5lbCBi
YWNrdHJhY2UgdmFyeS4gIEFsbCBhcmNocyBhcHBlYXIgdG8gYmUgYWZmZWN0ZWQuIA0KPiANCj4g
RG9lcyB5b3VyIHRlc3Qgc3VpdGUgY292ZXIgdjQuMD8NCg0KcHluZnMgY292ZXJzIHY0LjAgYW5k
IHY0LjEuDQpJIHJhbiBmc3Rlc3RzIGFuZCB0aGUgZ2l0IHJlZ3Jlc3Npb24gc3VpdGUgd2l0aCBv
bmx5IE5GU3Y0LjAuDQoNCg0KPiBEb2VzIGl0IGluY2x1ZGUgTFRQID8NCg0Ka2Rldm9wcyBkb2Vz
bid0IGluY2x1ZGUgYW4gTFRQIHdvcmtmbG93IGF0IHRoaXMgdGltZS4NCg0KDQo+IFRoYW5rcywN
Cj4gTmVpbEJyb3duDQo+IA0KPiANCj4+IA0KPj4+IFdpdGggYm90aCBwYXRjaGVzIGFwcGxpZWQg
dGhlIHJlZmNvdW50IG9uIHRoZSBuZnNkNF9ibG9ja2VkX2xvY2sgcHJldmVudHMNCj4+PiB0aGUg
ZG91YmxlLWZyZWUuDQo+Pj4gDQo+Pj4gS2VybmVscyBiZWZvcmUgNC45IGFyZSAocHJvYmFibHkp
IG5vdCBhZmZlY3RlZCBhcyB0aGV5IGRpZG4ndCBoYXZlDQo+Pj4gZmluZF9vcl9hbGxvY2F0ZV9i
bG9jaygpIHdoaWNoIHRha2VzIHRoZSBzZWNvbmQgcmVmZXJlbmNlIHRvIGEgc2hhcmVkDQo+Pj4g
b2JqZWN0LiAgQnV0IHRoYXQgaXMgYW5jaWVudCBoaXN0b3J5IC0gdGhvc2Uga2VybmVscyBhcmUg
d2VsbCBwYXN0IEVPTC4NCj4+PiANCj4+PiBUaGFua3MsDQo+Pj4gTmVpbEJyb3duDQo+Pj4gDQo+
Pj4gDQo+Pj4+IA0KPj4+PiAtLS0NCj4+Pj4gDQo+Pj4+IENodWNrIExldmVyICgyKToNCj4+Pj4g
ICAgIE5GU0Q6IE1vZGVybml6ZSBuZnNkNF9yZWxlYXNlX2xvY2tvd25lcigpDQo+Pj4+ICAgICBO
RlNEOiBBZGQgZG9jdW1lbnRpbmcgY29tbWVudCBmb3IgbmZzZDRfcmVsZWFzZV9sb2Nrb3duZXIo
KQ0KPj4+PiANCj4+Pj4gTmVpbEJyb3duICgxKToNCj4+Pj4gICAgIG5mc2Q6IGZpeCBSRUxFQVNF
X0xPQ0tPV05FUg0KPj4+PiANCj4+Pj4gDQo+Pj4+IGZzL25mc2QvbmZzNHN0YXRlLmMgfCA2NSAr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+Pj4gMSBmaWxl
IGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygtKQ0KPj4+PiANCj4+Pj4g
LS0NCj4+Pj4gQ2h1Y2sgTGV2ZXINCj4+Pj4gDQo+Pj4+IA0KPj4+PiANCj4+PiANCj4+IA0KPj4g
LS0NCj4+IENodWNrIExldmVyDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

