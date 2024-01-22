Return-Path: <linux-nfs+bounces-1283-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911A68377CC
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 00:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA971C22329
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 23:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6874D5AB;
	Mon, 22 Jan 2024 23:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gdC5Knwp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B+JVVL2r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C80F4B5A6
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 23:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705967104; cv=fail; b=AlR3eeldcwW8wl/8/PJLSLVm3vks/+k5ZVCpBZ7vgoSj4sr/LyCAkyAmoIzGU3CDiHuqk+yc+npLgd09KDjHWiKIZpU9z+lehuMdRu0Sr0ODWeMNnEDYX46EY8FqONbBcDHzuRF2/r9/mK5NCIDM038bizCowmAoA7tA25XGXus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705967104; c=relaxed/simple;
	bh=sPqmsb5Gr1YMpA2gmqAefBewLtD1iX+uFydB5dgDZq0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sWFn3SwHIfNRxh3QyiDAJInMVeXE6M67oSfybPj8t5gZna+fBhgDWBmcn9lsshShkHnu15z1TjdeD/oDj6VBaCfuft3DpD5zNc0+ZsBjdiz6/+GB3cwudw567VrgJSEU7OIiv74y6N3IAZCIaoxj4g92VpwAl+DQmUWOLUfMbQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gdC5Knwp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B+JVVL2r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MMoiOc026568;
	Mon, 22 Jan 2024 23:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=sPqmsb5Gr1YMpA2gmqAefBewLtD1iX+uFydB5dgDZq0=;
 b=gdC5Knwp8cz/7xwcPOe34L1udYPdmrAtHvp/rlNZiVOxZ8o2SMsHoLYy2lVMtR8MbysA
 nx/Qx55z6yczeB2haKxvTX+3aqa/aRVM6fiHthvbMyRq0E1ZzcOlf5pAd/D59jpbb6B3
 5eihb8FL3XLWHkuCrzrUvBJGEk100nvzdhxDvul2g1aWTyfQ5VpnQSEPpwlE9hyjOCAD
 TOi/+upNbbNsQkEkWdtYZLOxisx04obRj5NMCKGzgbwoO71GpeA5NI7GuTKE5GD9D338
 B3POXfYLKwjdZrAcz7qclruEx2/T7oohNHKq6d+hy9mQSp30Qt8qGGf2C9QiXPMBJf+U SQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cwcwvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 23:44:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40MN1HKi033584;
	Mon, 22 Jan 2024 23:44:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs370f944-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 23:44:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAU/bUJR1WtYXZwNqDZrnBwZxBgvjQRDqrt9JOZGqgsV90/RxLzzwPQRA6e4dHuqEwATs29D+2HsbJ3tVHfIBRR4l7sLSuy2hTLd5Pj1vKfGXOmA/ZSw1sZ1WTBKYmVxDQTBYdJI1soQLYHmzmskp/8FW/ZTbLTGvIjXLu80nH4hxkCYyp/E0mAoQPoqO4wvlFKDmJd5yceh7ZY8PtX9m1bpA+XNuyolczngAzGc3w5YPLDkX8wSbfPPQIqfcT5jYhMfPqWSeXobgJ6/E5AdSyuGvV61yt26WGBjJ5n7Yk7Eb/BnsZ5jQpuOhZlUAB6uNN7m84i7mkpXgiplXWJi3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPqmsb5Gr1YMpA2gmqAefBewLtD1iX+uFydB5dgDZq0=;
 b=hD2jrBlirIHF3d7XJXx6SnstTdIzneGYGV5wlFIW3b+BIotQjQ/LV42G70+TN1kftEUD/5U+OGsPgzNnfy7GtDKA3JFe61Qkwk2khjiTuoFgWx7YryOea6my5vk/JdINM6/BTCoPaqVMJOYRm2jx6+fDSoDLdaZkyzj/fp8ZaUj2xN3dpUiWtLUspD/4f8+h9JN5cMxziW/71alfQpfJ4yRadS9VVbDVzp6+6zhunFyc91kIDZZccoKez40mxFwaW3RjbhVXZYpbs0u+zCvEU0r5H5UeRtF+1yqpdeK1zN87mlEPaM78Z4pSgL2oieccioMjWUnmtvcv0hBofYcHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPqmsb5Gr1YMpA2gmqAefBewLtD1iX+uFydB5dgDZq0=;
 b=B+JVVL2rBstk8XPF/fWKq0lYO0+8O5ljaA4C8j5ewpe23WG+V41Etqk8s9o5OlxaDqOSMSGan1t6HLOpqNLpvIBxsvrhRiO8YPhp6E1F6fScBcXcujXlkeiKl8FEj4tXC9TQoGRgL1/eq1uzRR/yKPWKT/jmXF2R5eDouTL8j4k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4206.namprd10.prod.outlook.com (2603:10b6:208:1df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 23:44:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%6]) with mapi id 15.20.7202.035; Mon, 22 Jan 2024
 23:44:49 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        Olga
 Kornievskaia <kolga@netapp.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix RELEASE_LOCKOWNER
Thread-Topic: [PATCH] nfsd: fix RELEASE_LOCKOWNER
Thread-Index: AQHaTOdBtLll/fA4n0ueXAr70m4RmrDl5I+AgAB9jYCAABWSgIAABNOAgAADnAA=
Date: Mon, 22 Jan 2024 23:44:49 +0000
Message-ID: <D841692A-1D9D-49F9-B497-AA40B975C5E9@oracle.com>
References: <170589589641.23031.16356786177193106749@noble.neil.brown.name>
 <Za57adpDbKJavMRO@tissot.1015granger.net>
 <170596063560.23031.1725209290511630080@noble.neil.brown.name>
 <3162C5BC-8E7C-4A9A-815C-09297B56FA17@oracle.com>
 <170596630337.23031.332959396445243083@noble.neil.brown.name>
In-Reply-To: <170596630337.23031.332959396445243083@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4206:EE_
x-ms-office365-filtering-correlation-id: 5bcb6cf6-07af-4d84-8047-08dc1ba41f20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 CckkYkDSVZlrBNfKVl1Yab7GLJWj29dwTBQTkdbQzgABh6XQfcuof+soKRZVqvfh5tjTllMAmYUtoDVbUa7Oq+5iuwTcVtV7o5TYxCkDXrsFx6Zyyldt3N6lFnjJ/GZL43t/yoGZYWASAf4Cn/4kIXarwanmnIkVfBxi/B0nZdR7lyJu5qBJv+N7Q9G6Uol65WYBLVXVIU/qFi4XG8D3do7WM+f+gDEylBDPoAClYkdRxe1+me8EqplUvKPMg6W+MwF0u4mMx/vBYpSI4qcorG6MKEnIv+kSlYXTTxyCmyDk2pei52G8/gWf7bz1ow7AWinidJYiObdXFq6igFv/kayuN3otWJgwOWTRQUpK+7KrHvFD1vHyppPtIAvob+HgENG4E+Re33RxiDLDyKhCErQb93+zr7/mf57P+rLoSyWzTWPaS8u8dumL9Dz/ijCmKfQF/CUsWr1Vzf+5Gbfdx/O9DE9XIWlJvic7VzRiCqAkv4Lg5Ha0tL2A8PfTg6PkNMtO4KE/4QiIi6j3kChHwi/X7Q9BNrWcUho/rFFJ61A1uONrl28HP4oXjyAx7hlfVTKrXSEp9NhX4uHHpRljC+4T43V7BDIFjXfjHg4JVOfpaBSXtu+8DK+xItDLp95LDsPvsYr7JYIwLO6iq7kavw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38070700009)(4326008)(2616005)(83380400001)(6486002)(8676002)(8936002)(5660300002)(6506007)(6512007)(53546011)(6916009)(91956017)(71200400001)(316002)(76116006)(66556008)(66476007)(64756008)(66946007)(478600001)(66446008)(54906003)(26005)(122000001)(38100700002)(36756003)(2906002)(41300700001)(86362001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SzVZNk83V1ZibFZZUVFsYUZLdHRCZjdSTjhlRmVhcThpNUN2TjdVcGxYeWkx?=
 =?utf-8?B?a0ZVTGVSSkFiNmZqalQxaUdDbzlVYUNqVUllRCt4a3dFWUxvaGQ0VWsvOWk4?=
 =?utf-8?B?WmRKMXNJS3REa25ZS0hQNTdsdnR1cWFWM3dTajU2V3NEeHVXbGsyWUJ1OWV4?=
 =?utf-8?B?Q1lWQnBVMDNZZk5CMGdMeE5PZWMxV1dLMjFLVG5FVVBRRFdvTTRuazFyWExH?=
 =?utf-8?B?c3haYjNSd25zRklKcTl4MVUzQk5rWlJFMkM3bjlkRFF5Sm9haDNyMHNLK2xV?=
 =?utf-8?B?OHF3Q042Uld1QjRFYno0UEEyMGFaVG0ySUpVcFU4Qy9sYVd3SUI3K0tyTU95?=
 =?utf-8?B?ek9BQ2l0ZkIwRU1hb29wamUrTjY1dEQ3ZVBLZEpFQ1FIdURCQ1BHc0FOdk16?=
 =?utf-8?B?S2c0RjUvL1JWWmpNWDIrVzYrazJ6d0lVMjdJMDF4NlNWdUVtVVFaRWQzbzU1?=
 =?utf-8?B?K3hzZjB1OEM4OTNoWGk0SHd1NzlUTGtVTk9LakhnWHkwU0poTFVPSVY1dy9l?=
 =?utf-8?B?cWh6U096SHlmUDlEWWJ0dEY4cG9uR2pXZWhQOVVFV0d2bWRNUkJySVJqbnJm?=
 =?utf-8?B?YjgxQThmMjJFMXRXNDk0UXpZRDNOV1lEKzJUVEp5eEhPbnYvVlVrYmFmWGUx?=
 =?utf-8?B?aGJVRlpKSXQ0c2U2NWp1M0F2OUhnQTRsTGE2N3lzRUpBV3BzWlZkODdqTkZo?=
 =?utf-8?B?c2RDcVBMU04xdGRGQjhhQ3BDVjhOSGRzZzF5cmkweDA5RElFS1BNbldhc0pj?=
 =?utf-8?B?L2tVNlV5LzBIN0FZaVNwSUdMakpSSWNKQndXY1ZBcmxoU1BURWxXN283VzlB?=
 =?utf-8?B?WkxtNDFYSjE0UkZFd25HMlZOZ1NVZk1ZemJyRmxQY3oyWmFsT2tudCs2L1pu?=
 =?utf-8?B?ZkdXRE5JWHdxM01sdVZLVmNsakRSR0hOUk9mZXZsUHlxRE9janlLRnFrRmJi?=
 =?utf-8?B?UGR3MkVhaEZCbmdFakpHVk5kTElFWG8zbXdpMUZOVkNpK3NlbGc0NVpSYW1L?=
 =?utf-8?B?ekN6ZHhvSXRmWTNzd0p1RGYzOUN1YUlCUE5vbEgyM1VGV3VFSXlNYTdFeENX?=
 =?utf-8?B?VmJpL2gwVjlxSlNsbFlFRkFUMDRYbVdibzI4WWw5OG9vUEVaY2lvcWNyWENQ?=
 =?utf-8?B?OUlscVV2YWM5NDFHY0lCMkh6Y1FzTkc2a3Q3RHhFRWtiSGVwdmxHUFdJVFpw?=
 =?utf-8?B?bUJ2NmJxZVpvL0s0azdPSnZ5TVJYTEIzRlFHL2hBZ21xdE5QN2N1TldqMmJO?=
 =?utf-8?B?NjN5OG9vOVNyODZQUEpQS1dCblJmZFh6b2EveGhqTlZDZDVqN05Ua1FEb1lB?=
 =?utf-8?B?Y3U2cHQ3VUdjUmRzSzdwQjhkRnNQak9TNGFrWVBBbDk2YUdndDgwUFlNWkhW?=
 =?utf-8?B?ODMwNGhyWmV1dnM1RnpFeVhHTHBvNURVS3h1dTlOMjR5M2RCdWpnUU9qL250?=
 =?utf-8?B?dGw0TTFoMS9sSzN4UlhSZmw4aUwvZXo5WGRIYkxVL29zNWhzYjkrQmhRUHpO?=
 =?utf-8?B?YXBSLzBCUHdWbFRjVmx1cFpIc21BdDZTQnJmQ0RxZ05iL0dqOTAwSkg5VW5o?=
 =?utf-8?B?NHBrTlVuUFArZkRSdlN3SHhxbXVFU2tHdDRzNk1uOEpkYXVDeW84Y1Q3L0Vp?=
 =?utf-8?B?aFdUZllPaFM0YjZjRnBRRFZod0V6RUYzZlJkYmRFTkxXRHlMMVZFZ1FiSmVN?=
 =?utf-8?B?eGNaZGk0aVk0bUFwWCt1Y1RGc2xZTmZza3N0b3krODdYTjJGbXVoK3RTaFNr?=
 =?utf-8?B?L1lBZk5qUGNhYlZrWDRvOEhJTHNneDNEWEFRN2l6VUxMa1NVYy90VlU1RmtS?=
 =?utf-8?B?dW1pMkYyMnJFSUhGRG9wSkNYQnE5eVBkVW1YQWdKSTh6V0RGRFpIWXZYL2J1?=
 =?utf-8?B?VGZwVUNheG9aM1RMNVpzVWlwaWRGTzlHakoxNkoyZEJtbGhTWlF1QTF0ZHR0?=
 =?utf-8?B?andJZW1UbktvM08yMXI4NjFDUDJIVncwK0hVUkNWbDFJK1FUSWlpM1o5Zkdi?=
 =?utf-8?B?R2JCTnVJa3BWeTloclFVZmo3Sm8vRXZoQTZtZ0FibU1zVzRpdXc3bDgzUkFZ?=
 =?utf-8?B?L2wwRDdvUEZQVWVsMFVvZ3ZDNWU5ckVIY2VZRzVadVRTY1NMZjVxRXhYRU54?=
 =?utf-8?B?RGFncUZ3ZklxaGp6dm5wSDRnRldFbWEybFpDVlhZNEd3aXRVbVR2QkZlb2p6?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D704EA2B49361149B4757F227DE1794D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AhDWJZt7bzqIqGJ3UB4THZQm4uCIXFde6K9sMWgyJj43WHKgMEcmrIhWZgnZ97qdthlcfAtm8YXyPVCYe6kUalKt2BIZqLwDRqerR/naUWBb10IMzqTc1boyl1o8iuTtc2N7SP/HxH2r83SLSXxwvhdUwB7RDjIOHkZQSqrZCnsA5fD89dbuG8HeIH14wTkpJ4nkVDqzDOpcNYgwwLWjwsznSs3K2OX+REpdg8PdeXf8cHS2GlpXnSSmiP9iEWjtFnU32ib0jA8mk0IJyOAxfKE2PwL57LhGZzasdBKgo8ZJfDQyzjCWha3eO+sb32GLIetR301Wq3JqGL+jT8+2sXsXy6kxUjL0Xxgf/B6BiEXc9tyes0SL9CDDL75gaZxP7IHy22sXo5YUJwPu1EpppX3ElcuhO0YigIi36uQiQwbQG0YFLSjuoVpy5D1j4muiU+Di3sccISrD01IkXrouB/yqu5QVyMX0/1io1daf23SlA1b9+7/yZNPklYWvpAvNdq0wpK3GLoM0ECmZkdmGvnXx8TVC4RKbUKX388Jp8UlHae2IxmgjlDchfx31mj9hVlsMBxJX40xCPqTGiO64mwtnoF3GFbWLpIKvfsB+ArQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcb6cf6-07af-4d84-8047-08dc1ba41f20
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 23:44:49.0494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Asixjb+0i1KIfSqmcFnt8KQl5fvU9mgIeXik7fT9bcsZqDxLkhpBr5vUTejnMEu9LFcx/9frBThWk//GU4pGtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220170
X-Proofpoint-ORIG-GUID: pU8yp0KOPEjOAYPvtrBofbCTP-mizd53
X-Proofpoint-GUID: pU8yp0KOPEjOAYPvtrBofbCTP-mizd53

DQoNCj4gT24gSmFuIDIyLCAyMDI0LCBhdCA2OjMx4oCvUE0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIDIzIEphbiAyMDI0LCBDaHVjayBMZXZlciBJSUkg
d3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEphbiAyMiwgMjAyNCwgYXQgNDo1N+KAr1BNLCBOZWls
QnJvd24gPG5laWxiQHN1c2UuZGU+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIFR1ZSwgMjMgSmFuIDIw
MjQsIENodWNrIExldmVyIHdyb3RlOg0KPj4+PiBPbiBNb24sIEphbiAyMiwgMjAyNCBhdCAwMjo1
ODoxNlBNICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IFRoZSB0ZXN0IG9u
IHNvX2NvdW50IGluIG5mc2Q0X3JlbGVhc2VfbG9ja293bmVyKCkgaXMgbm9uc2Vuc2UgYW5kDQo+
Pj4+PiBoYXJtZnVsLiAgUmV2ZXJ0IHRvIHVzaW5nIGNoZWNrX2Zvcl9sb2NrcygpLCBjaGFuZ2lu
ZyB0aGF0IHRvIG5vdCBzbGVlcC4NCj4+Pj4+IA0KPj4+Pj4gRmlyc3Q6IGhhcm1mdWwuDQo+Pj4+
PiBBcyBpcyBkb2N1bWVudGVkIGluIHRoZSBrZG9jIGNvbW1lbnQgZm9yIG5mc2Q0X3JlbGVhc2Vf
bG9ja293bmVyKCksIHRoZQ0KPj4+Pj4gdGVzdCBvbiBzb19jb3VudCBjYW4gdHJhbnNpZW50bHkg
cmV0dXJuIGEgZmFsc2UgcG9zaXRpdmUgcmVzdWx0aW5nIGluIGENCj4+Pj4+IHJldHVybiBvZiBO
RlM0RVJSX0xPQ0tTX0hFTEQgd2hlbiBpbiBmYWN0IG5vIGxvY2tzIGFyZSBoZWxkLiAgVGhpcyBp
cw0KPj4+Pj4gY2xlYXJseSBhIHByb3RvY29sIHZpb2xhdGlvbiBhbmQgd2l0aCB0aGUgTGludXgg
TkZTIGNsaWVudCBpdCBjYW4gY2F1c2UNCj4+Pj4+IGluY29ycmVjdCBiZWhhdmlvdXIuDQo+Pj4+
PiANCj4+Pj4+IElmIE5GUzRfUkVMRUFTRV9MT0NLT1dORVIgaXMgc2VudCB3aGlsZSBzb21lIG90
aGVyIHRocmVhZCBpcyBzdGlsbA0KPj4+Pj4gcHJvY2Vzc2luZyBhIExPQ0sgcmVxdWVzdCB3aGlj
aCBmYWlsZWQgYmVjYXVzZSwgYXQgdGhlIHRpbWUgdGhhdCByZXF1ZXN0DQo+Pj4+PiB3YXMgcmVj
ZWl2ZWQsIHRoZSBnaXZlbiBvd25lciBoZWxkIGEgY29uZmxpY3RpbmcgbG9jaywgdGhlbiB0aGUg
bmZzZA0KPj4+Pj4gdGhyZWFkIHByb2Nlc3NpbmcgdGhhdCBMT0NLIHJlcXVlc3QgY2FuIGhvbGQg
YSByZWZlcmVuY2UgKGNvbmZsb2NrKSB0bw0KPj4+Pj4gdGhlIGxvY2sgb3duZXIgdGhhdCBjYXVz
ZXMgbmZzZDRfcmVsZWFzZV9sb2Nrb3duZXIoKSB0byByZXR1cm4gYW4NCj4+Pj4+IGluY29ycmVj
dCBlcnJvci4NCj4+Pj4+IA0KPj4+Pj4gVGhlIExpbnV4IE5GUyBjbGllbnQgaWdub3JlcyB0aGF0
IE5GUzRFUlJfTE9DS1NfSEVMRCBlcnJvciBiZWNhdXNlIGl0DQo+Pj4+PiBuZXZlciBzZW5kcyBO
RlM0X1JFTEVBU0VfTE9DS09XTkVSIHdpdGhvdXQgZmlyc3QgcmVsZWFzaW5nIGFueSBsb2Nrcywg
c28NCj4+Pj4+IGl0IGtub3dzIHRoYXQgdGhlIGVycm9yIGlzIGltcG9zc2libGUuICBJdCBhc3N1
bWVzIHRoZSBsb2NrIG93bmVyIHdhcyBpbg0KPj4+Pj4gZmFjdCByZWxlYXNlZCBzbyBpdCBmZWVs
cyBmcmVlIHRvIHVzZSB0aGUgc2FtZSBsb2NrIG93bmVyIGlkZW50aWZpZXIgaW4NCj4+Pj4+IHNv
bWUgbGF0ZXIgbG9ja2luZyByZXF1ZXN0Lg0KPj4+Pj4gDQo+Pj4+PiBXaGVuIGl0IGRvZXMgcmV1
c2UgYSBsb2NrIG93bmVyIGlkZW50aWZpZXIgZm9yIHdoaWNoIGEgcHJldmlvdXMgUkVMRUFTRQ0K
Pj4+Pj4gZmFpbGVkLCBpdCB3aWxsIG5hdHVyYWxseSB1c2UgYSBsb2NrX3NlcWlkIG9mIHplcm8u
ICBIb3dldmVyIHRoZSBzZXJ2ZXIsDQo+Pj4+PiB3aGljaCBkaWRuJ3QgcmVsZWFzZSB0aGUgbG9j
ayBvd25lciwgd2lsbCBleHBlY3QgYSBsYXJnZXIgbG9ja19zZXFpZCBhbmQNCj4+Pj4+IHNvIHdp
bGwgcmVzcG9uZCB3aXRoIE5GUzRFUlJfQkFEX1NFUUlELg0KPj4+Pj4gDQo+Pj4+PiBTbyBjbGVh
cmx5IGl0IGlzIGhhcm1mdWwgdG8gYWxsb3cgYSBmYWxzZSBwb3NpdGl2ZSwgd2hpY2ggdGVzdGlu
Zw0KPj4+Pj4gc29fY291bnQgYWxsb3dzLg0KPj4+Pj4gDQo+Pj4+PiBUaGUgdGVzdCBpcyBub25z
ZW5zZSBiZWNhdXNlIC4uLiB3ZWxsLi4uIGl0IGRvZXNuJ3QgbWVhbiBhbnl0aGluZy4NCj4+Pj4+
IA0KPj4+Pj4gc29fY291bnQgaXMgdGhlIHN1bSBvZiB0aHJlZSBkaWZmZXJlbnQgY291bnRzLg0K
Pj4+Pj4gMS8gdGhlIHNldCBvZiBzdGF0ZXMgbGlzdGVkIG9uIHNvX3N0YXRlaWRzDQo+Pj4+PiAy
LyB0aGUgc2V0IG9mIGFjdGl2ZSB2ZnMgbG9ja3Mgb3duZWQgYnkgYW55IG9mIHRob3NlIHN0YXRl
cw0KPj4+Pj4gMy8gdmFyaW91cyB0cmFuc2llbnQgY291bnRzIHN1Y2ggYXMgZm9yIGNvbmZsaWN0
aW5nIGxvY2tzLg0KPj4+Pj4gDQo+Pj4+PiBXaGVuIGl0IGlzIHRlc3RlZCBhZ2FpbnN0ICcyJyBp
dCBpcyBjbGVhciB0aGF0IG9uZSBvZiB0aGVzZSBpcyB0aGUNCj4+Pj4+IHRyYW5zaWVudCByZWZl
cmVuY2Ugb2J0YWluZWQgYnkgZmluZF9sb2Nrb3duZXJfc3RyX2xvY2tlZCgpLiAgSXQgaXMgbm90
DQo+Pj4+PiBjbGVhciB3aGF0IHRoZSBvdGhlciBvbmUgaXMgZXhwZWN0ZWQgdG8gYmUuDQo+Pj4+
PiANCj4+Pj4+IEluIHByYWN0aWNlLCB0aGUgY291bnQgaXMgb2Z0ZW4gMiBiZWNhdXNlIHRoZXJl
IGlzIHByZWNpc2VseSBvbmUgc3RhdGUNCj4+Pj4+IG9uIHNvX3N0YXRlaWRzLiAgSWYgdGhlcmUg
d2VyZSBtb3JlLCB0aGlzIHdvdWxkIGZhaWwuDQo+Pj4+PiANCj4+Pj4+IEl0IG15IHRlc3Rpbmcg
SSBzZWUgdHdvIGNpcmN1bXN0YW5jZXMgd2hlbiBSRUxFQVNFX0xPQ0tPV05FUiBpcyBjYWxsZWQu
DQo+Pj4+PiBJbiBvbmUgY2FzZSwgQ0xPU0UgaXMgY2FsbGVkIGJlZm9yZSBSRUxFQVNFX0xPQ0tP
V05FUi4gIFRoYXQgcmVzdWx0cyBpbg0KPj4+Pj4gYWxsIHRoZSBsb2NrIHN0YXRlcyBiZWluZyBy
ZW1vdmVkLCBhbmQgc28gdGhlIGxvY2tvd25lciBiZWluZyBkaXNjYXJkZWQNCj4+Pj4+IChpdCBp
cyByZW1vdmVkIHdoZW4gdGhlcmUgYXJlIG5vIG1vcmUgcmVmZXJlbmNlcyB3aGljaCB1c3VhbGx5
IGhhcHBlbnMNCj4+Pj4+IHdoZW4gdGhlIGxvY2sgc3RhdGUgaXMgZGlzY2FyZGVkKS4gIFdoZW4g
bmZzZDRfcmVsZWFzZV9sb2Nrb3duZXIoKSBmaW5kcw0KPj4+Pj4gdGhhdCB0aGUgbG9jayBvd25l
ciBkb2Vzbid0IGV4aXN0LCBpdCByZXR1cm5zIHN1Y2Nlc3MuDQo+Pj4+PiANCj4+Pj4+IFRoZSBv
dGhlciBjYXNlIHNob3dzIGFuIHNvX2NvdW50IG9mICcyJyBhbmQgcHJlY2lzZWx5IG9uZSBzdGF0
ZSBsaXN0ZWQNCj4+Pj4+IGluIHNvX3N0YXRlaWQuICBJdCBhcHBlYXJzIHRoYXQgdGhlIExpbnV4
IGNsaWVudCB1c2VzIGEgc2VwYXJhdGUgbG9jaw0KPj4+Pj4gb3duZXIgZm9yIGVhY2ggZmlsZSBy
ZXN1bHRpbmcgaW4gb25lIGxvY2sgc3RhdGUgcGVyIGxvY2sgb3duZXIsIHNvIHRoaXMNCj4+Pj4+
IHRlc3Qgb24gJzInIGlzIHNhZmUuICBGb3IgYW5vdGhlciBjbGllbnQgaXQgbWlnaHQgbm90IGJl
IHNhZmUuDQo+Pj4+PiANCj4+Pj4+IFNvIHRoaXMgcGF0Y2ggY2hhbmdlcyBjaGVja19mb3JfbG9j
a3MoKSB0byB1c2UgdGhlIChuZXdpc2gpDQo+Pj4+PiBmaW5kX2FueV9maWxlX2xvY2tlZCgpIHNv
IHRoYXQgaXQgZG9lc24ndCB0YWtlIGEgcmVmZXJlbmNlIG9uIHRoZQ0KPj4+Pj4gbmZzNF9maWxl
IGFuZCBzbyBuZXZlciBjYWxscyBuZnNkX2ZpbGVfcHV0KCksIGFuZCBzbyBuZXZlciBzbGVlcHMu
DQo+Pj4+IA0KPj4+PiBNb3JlIHRvIHRoZSBwb2ludCwgZmluZF9hbnlfZmlsZV9sb2NrZWQoKSB3
YXMgYWRkZWQgYnkgY29tbWl0DQo+Pj4+IGUwYWE2NTEwNjhiZiAoIm5mc2Q6IGRvbid0IGNhbGwg
bmZzZF9maWxlX3B1dCBmcm9tIGNsaWVudCBzdGF0ZXMNCj4+Pj4gc2VxZmlsZSBkaXNwbGF5Iiks
IHdoaWNoIHdhcyBtZXJnZWQgc2V2ZXJhbCBtb250aHMgL2FmdGVyLyBjb21taXQNCj4+Pj4gY2Uz
YzRhZDdmNGNlICgiTkZTRDogRml4IHBvc3NpYmxlIHNsZWVwIGR1cmluZw0KPj4+PiBuZnNkNF9y
ZWxlYXNlX2xvY2tvd25lcigpIikuDQo+Pj4gDQo+Pj4gWWVzLiAgVG8gZmxlc2ggb3V0IHRoZSBo
aXN0b3J5Og0KPj4+IG5mc2RfZmlsZV9wdXQoKSB3YXMgYWRkZWQgaW4gdjUuNC4gIEluIGVhcmxp
ZXIga2VybmVscyBjaGVja19mb3JfbG9ja3MoKQ0KPj4+IHdvdWxkIG5ldmVyIHNsZWVwLiAgSG93
ZXZlciB0aGUgcHJvYmxlbSBwYXRjaCB3YXMgYmFja3BvcnRlZCA0LjksIDQuMTQsDQo+Pj4gYW5k
IDQuMTkgYW5kIHNob3VsZCBiZSByZXZlcnRlZC4NCj4+IA0KPj4gSSBkb24ndCBzZWUgIk5GU0Q6
IEZpeCBwb3NzaWJsZSBzbGVlcCBkdXJpbmcgbmZzZDRfcmVsZWFzZV9sb2Nrb3duZXIoKSINCj4+
IGluIGFueSBvZiB0aG9zZSBrZXJuZWxzLiBBbGwgYnV0IDQuMTkgYXJlIG5vdyBFT0wuDQo+IA0K
PiBJIGhhZG4ndCBjaGVja2VkIHdoaWNoIHdlcmUgRU9MLiAgVGhhbmtzIGZvciBmaW5kaW5nIHRo
ZSA0LjE5IHBhdGNoIGFuZA0KPiByZXF1ZXN0aW5nIGEgcmV2ZXJ0Lg0KPiANCj4+IA0KPj4gDQo+
Pj4gZmluZF9hbnlfZmlsZV9sb2NrZWQoKSB3YXMgYWRkZWQgaW4gdjYuMiBzbyB3aGVuIHRoaXMg
cGF0Y2ggaXMNCj4+PiBiYWNrcG9ydGVkIHRvIDUuNCwgNS4xMCwgNS4xNSwgNS4xNyAtIDYuMSBp
dCBuZWVkcyB0byBpbmNsdWRlDQo+Pj4gZmluZF9hbmRfZmlsZV9sb2NrZWQoKQ0KPj4gDQo+PiBJ
IHRoaW5rIEknZCByYXRoZXIgbGVhdmUgdGhvc2UgdW5wZXJ0dXJiZWQgdW50aWwgc29tZW9uZSBo
aXRzIGEgcmVhbA0KPj4gcHJvYmxlbS4gVW5sZXNzIHlvdSBoYXZlIGEgZGlzdHJpYnV0aW9uIGtl
cm5lbCB0aGF0IG5lZWRzIHRvIHNlZQ0KPj4gdGhpcyBmaXggaW4gb25lIG9mIHRoZSBMVFMga2Vy
bmVscz8gVGhlIHN1cHBvcnRlZCBzdGFibGUvTFRTIGtlcm5lbHMNCj4+IGFyZSA1LjQsIDUuMTAs
IDUuMTUsIGFuZCA2LjEuDQo+IA0KPiBXaHkgbm90IGZpeCB0aGUgYnVnPyAgSXQncyBhIHJlYWwg
YnVnIHRoYXQgYSByZWFsIGN1c3RvbWVyIHJlYWxseSBoaXQuDQoNClRoYXQncyB3aGF0IEknbSBh
c2tpbmcuIFdhcyB0aGVyZSBhIHJlYWwgY3VzdG9tZXIgaXNzdWU/IEJlY2F1c2UNCmNlM2M0YWQ3
ZjRjZSB3YXMgdGhlIHJlc3VsdCBvZiBhIG1pZ2h0X3NsZWVwIHNwbGF0LCBub3QgYW4gaXNzdWUN
CmluIHRoZSBmaWVsZC4NCg0KU2luY2UgdGhpcyBoaXQgYSByZWFsIHVzZXIsIGlzIHRoZXJlIGEg
QnVnTGluazogb3IgQ2xvc2VzOiB0YWcNCkkgY2FuIGFkZD8NCg0KDQo+IEkndmUgZml4ZWQgaXQg
aW4gYWxsIFNMRSBrZXJuZWxzIC0gd2UgZG9uJ3QgZGVwZW5kIG9uIExUUyB0aG91Z2ggd2UgZG8N
Cj4gbWFrZSB1c2Ugb2YgdGhlIHN0YWJsZSB0cmVlcyBpbiB2YXJpb3VzIHdheXMuDQo+IA0KPiBC
dXQgaXQncyB5b3VyIGNhbGwuDQoNCldlbGwsIGl0J3Mgbm90IG15IGNhbGwgd2hldGhlciBpdCdz
IGJhY2twb3J0ZWQuIEFueW9uZSBjYW4gYXNrLg0KSXQgL2lzLyBteSBjYWxsIGlmIEkgZG8gdGhl
IHdvcmsuDQoNCk1vc3RseSB0aGUgaXNzdWUgaXMgaGF2aW5nIHRoZSB0aW1lIHRvIG1hbmFnZSA1
LTYgc3RhYmxlDQprZXJuZWxzIGFzIHdlbGwgYXMgdXBzdHJlYW0gZGV2ZWxvcG1lbnQuIEknZCBs
aWtlIHRvIGVuc3VyZQ0KdGhhdCBhbnkgcGF0Y2hlcyBmb3Igd2hpY2ggd2UgbWFudWFsbHkgcmVx
dWVzdCBhIGJhY2twb3J0IGhhdmUNCmJlZW4gYXBwbGllZCBhbmQgdGVzdGVkIGJ5IHNvbWVvbmUg
d2l0aCBhIHJlYWwgTkZTIHJpZywgYW5kDQp0aGVyZSBpcyBhIHJlYWwgcHJvYmxlbSBnZXR0aW5n
IGFkZHJlc3NlZC4NCg0KSXQncyBnZXR0aW5nIGJldHRlciB3aXRoIGtkZXZvcHMuLi4gSSBjYW4g
Y2hlcnJ5IHBpY2sgYW55DQpyZWNlbnQga2VybmVsIGFuZCBydW4gaXQgdGhyb3VnaCBhIG51bWJl
ciBvZiB0ZXN0cyB3aXRob3V0DQpuZWVkaW5nIHRvIGhhbmQtaG9sZC4gSGF2ZW4ndCB0cmllZCB0
aGF0IHdpdGggdGhlIG9sZGVyIHN0YWJsZQ0Ka2VybmVscywgdGhvdWdoOyB0aG9zZSByZXF1aXJl
IG9sZGVyIGNvbXBpbGVycyBhbmQgd2hhdC1ub3QuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

