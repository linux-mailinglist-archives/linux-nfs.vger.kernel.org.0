Return-Path: <linux-nfs+bounces-151-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A8E7FC90D
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 23:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31CB282884
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 22:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BC0481A9;
	Tue, 28 Nov 2023 22:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PNuFZBZg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="epgnkUAy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152651BE;
	Tue, 28 Nov 2023 14:05:52 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASI0u0J006993;
	Tue, 28 Nov 2023 22:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=KHnV32kv1NGiEzwuxwLKaOjKYmbEh1XgRnwWbwOIobg=;
 b=PNuFZBZglcni0dr+VjYO1kLUoTTC/OIcYWXA5o/BeAOJJPXW3MpIX2RLlKbEceVyTPRN
 Uw/nFuwbVoIcul9H9c+xPSsWKWVg9QF6tgyBno8+WAXgymjMNc+uYAxgziMqn94741LV
 AZO9ALJClk5zRoHZSOv3gWID/BYNIn5OcuiPYx6VDQmi8X6PfLLyxl0gigm8KVakQ8CR
 PmVE7rw432bdU1L8I+TGZnrJIPH7BJi07/nuE/iAbMybtC0FtfUVq5lqNLUg4YEymu0R
 jx+xK/lq2C6K4SEbywODQYvf92hpqthSPHVKdYELjSFiVuwVYitBnwO8vSrRhA9okvtl AA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7ucq08n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 22:05:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASKoxUr013572;
	Tue, 28 Nov 2023 22:05:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cdcawc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 22:05:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1tATnYnaRYcNNzxmH1LevIFUiG54RptSll4R4P6Mkk9qkzL44AXmjx4c7zv3pir7M3My1cG7oqVgfgJdRgKZmqGoG4sqnX0oVlhJwzPxQVEuqP96/IrN73DbEczKQEEHDoDFuLGKv8FQmlVXwSK7Jhc09OCbcH0rtjFT+Ra6yZLrIbcrJ/m/KSR3emb0003luRwPrcrZ67EAgYKLThFeTcEDCMdWUMb/SxEW+vFcGARVWMlxquGF3HQNgHaFJpCkTDLh9FQTKHN27+EN/9pGMhs3Z8fg/epfYPJq7qwRLXIIT8L8sIP8cyTC17/kMnd7dn7DqVaTaOUb0b0yOrXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHnV32kv1NGiEzwuxwLKaOjKYmbEh1XgRnwWbwOIobg=;
 b=PjxXF12dX3rmeVKY57f+PyO6S/LusQd5zuJXl8PoE2Ia4G/VPP7wt2voYPJPWdHRuX7zxhq84l6kqP3wKKgONwovYi43UjicPgqEM1qCmEoaOcFjsnqdqkI2L+/dk/YkCyPQN84GusrQFEJ0KKqUQ2IT203urF+fGSYOJ43lhkVjFL71DT5NJEPzA5/Ugmb50ptNagrNnDrnt9ubqrXIwNdee7S41hjv6UQUmSarwdUqyl9qRbi6C3dAtN5RvOcmnTbxcFmMBwFTaLpuQX8EcD9gBPstXe9rbNRTjc2mYp1NRb4EY9vRMZSm2EukKfOFhakiiwXqImqos4Q56gqbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHnV32kv1NGiEzwuxwLKaOjKYmbEh1XgRnwWbwOIobg=;
 b=epgnkUAyD4VJpKmQ+vVt/V1souIuqDihNFN2smRZLFglbZmgCCWue/QD7eUgBEM4tXd6ICZn5UihQqHegLKEX8nbXTpfO0C6VMQIkNqk+T1dlClCg8DDFWdf64otWfBcK5WzzUeJNQuZDMoITKCqgGuO34/vKM8xXFwGb7VYysc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7163.namprd10.prod.outlook.com (2603:10b6:610:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 22:05:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:05:45 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Chuck Lever <cel@kernel.org>
CC: linux-stable <stable@vger.kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] nfsd fixes for 6.6.y
Thread-Topic: [PATCH 0/2] nfsd fixes for 6.6.y
Thread-Index: AQHaIkYMHr3vA31dZ0a5c2mRFltZNbCQSXgA
Date: Tue, 28 Nov 2023 22:05:45 +0000
Message-ID: <E01AE605-9548-40AF-A72D-01D46B8A749E@oracle.com>
References: 
 <170120862772.1376.15036820033774301160.stgit@klimt.1015granger.net>
In-Reply-To: 
 <170120862772.1376.15036820033774301160.stgit@klimt.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7163:EE_
x-ms-office365-filtering-correlation-id: e9da0b32-b06f-429b-e294-08dbf05e2bdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 RE7MK/80Zw0/cN/1aoMKIh+aekZRpWLAJGH3nw48aQB3Mjyg5pAKuphGH7fn8fq+jCDi9pEA5FnSajMC2dyonia9J/z0Z2n8M3+f2/8S9UDpv3cF5gEF7YgiXi8pNxjltHuflA1oWXVCIab7Gz53wOXNEeIvjqhmayoekruQGYh1DDkpz1kixA8FpC08zSbbDd7kcQ+aVew4u2G3YX75VP7xBbHnl3RFs8R3cRZVTfYBv50srsC/MIRxCyjcmy1+gxVNfRjjwA79CnY33t2102MPTuBqtSPqfnMMzFMlkWiimUEXRvwxPWNgfq634LKmaR6uJJHoAUY3kIcro2ddx362BF6KM9hWcyFuO7GGK6HjtyCwcovNuhNREYPObPaUH6bG8RzSLsqJ59CHQ1T5bVh9qLVgdPGJUcqIZk2CUTUBjympqau60BDaETxEWcEyO2/xuVACxezB3T+q+XiBniQLpTi/FlC9gaupR5QCG23wmM8lDTXIcjuceY1CHUD3QjKP3hVHq3Lq4Kx42F5VSHlMJJKal2El8nbU9qqcrS27g0RAaDiPDisMkK9FjAMwywf08Gz0jOaA0AGvhh10nr+XKjf+RoCoKo+nqJl1wqELyaqioSRFORRbhjf13bDL+JkguvamBkkNLzfgwlw3TQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(41300700001)(36756003)(86362001)(38070700009)(122000001)(33656002)(4744005)(83380400001)(5660300002)(26005)(2906002)(2616005)(6512007)(53546011)(6506007)(8676002)(4326008)(71200400001)(8936002)(6486002)(478600001)(54906003)(66946007)(76116006)(64756008)(66556008)(91956017)(66476007)(66446008)(316002)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?M09EdnMzK09Yd2duWkU2K1pvdlpudXhhZ0RhSFN6a1Q3dHgxNU1MdEdBWXB4?=
 =?utf-8?B?T0l6RmRoTzRWbk5kZ2V3RnJOejM3Z0VjNlpBbmQ1TGZQaWRYZUE5S2pjaC9X?=
 =?utf-8?B?QWhCZEdHaW5qZ3hsbnpoaURiR0hEcFpKU2J3Tnh5eVRESzhNM2cyVS8zT1Rt?=
 =?utf-8?B?UURzcGxndFpSWTdDa08yVUpYdnBTRVNlbTJldE8vZUZMWTJDeXAyeE8xRld6?=
 =?utf-8?B?SWZhd1R3TDNRUWNzelNkRHdOSllmKzV0ZTlkRzJIRzkzeHNZOVhkLzczOWM3?=
 =?utf-8?B?R2p0VnFQMExpMmV2WkdReHpIVDRRMnpHdHUvaW1icWJsMk5TVTBya0dETVBJ?=
 =?utf-8?B?Tk9GcjdFWUNOOXBVS08va1dNR2JZVlZCbXJ1Rng3OTN5anlPeTZnUmRydnI2?=
 =?utf-8?B?ZzRKSkhaTE5ZbUFyRjhNblo4K2V0YnJUb0txSzdjVDZlSlRxRng4TEpLa3Vr?=
 =?utf-8?B?a0d0SEpubFByOG5KYnFCWm15QkhsbnBNVUJ4TnBIQmxqK0x2eVlqK2ltUHFw?=
 =?utf-8?B?S1R6UDZVUFB6UjBCS0x2emwxZ1JzVU9GQ213Rjg4N3R4VHE5dVVPL1dHUkNL?=
 =?utf-8?B?b083cklNUi84akpHZk1RcDg0cHoxajhoZ0VyejZUSktsNTF2aTVWL3BvM0tv?=
 =?utf-8?B?VmhMVTEvd2FRQkcwcEdRQmt2YmJBc2JadWFydDA2b3JpUFRsRWtwbEF0RkJ0?=
 =?utf-8?B?M1VhVk50dEJRUTQvai9OK2NjeDNPTjUyL3M2NGI1SWdYamY1SU0rcm9tUHdP?=
 =?utf-8?B?N2dna3NyK3pmUXIxREhYMW5IaHNCQVBUakpCcTdES0NqTXlCOVdMbW5vSzJx?=
 =?utf-8?B?QVYwYzhXd0g2QmdudWpUMEN0UzBYNlRIR2VjREJFQk1hdHdMekp0OHpQb052?=
 =?utf-8?B?SWVzTXZSR25uYkxKamsrcERBZnJpdkxjNWhSQ0diRmo0blFTdjlyWlBjdzRD?=
 =?utf-8?B?QUNUaU1nTy9xa3RFRklRR21uOVFEWlVCWW9VSG5NcDVKVmd2V0JxQ29DeE9v?=
 =?utf-8?B?S054TWNvVGNLZ1lwbWNRREV6M0FpM2cxQzc5QmU4VXBFbHgzKzZwbVBMV050?=
 =?utf-8?B?MDBSVW80QUV1MDlVMENUSzBTU0lzUXlCVHhyTVYrY3VQaHpPZVpLZ3VYRkhY?=
 =?utf-8?B?VXdGbmo3VW5raUNJendYREF6cGVMVjl6TTV0TE5PbmlndEs2dG5LbUtVQy9a?=
 =?utf-8?B?T0xIc0VsK0RiNzhDSnZSUGJGZDNRRnkrVHN3ZjFCSUZrOUdiOXdmZ2FEZk92?=
 =?utf-8?B?cXRLbHpuRERzMWRkS2dtdzFPU2ZMaGY1S2pBQXZKazVudEhVMDFNUDdsYVdD?=
 =?utf-8?B?QmdLaEh1bDJHRGhrblVGbitRNVlsbWwwVDlBTVFHb3FVSXZzR0Urcks3RzYx?=
 =?utf-8?B?Yi8xd0IxZ2Q4bG5tVk9wS1dNUng5S1lTSEUyd04rYTBoZTJoZlJReDNsSjE4?=
 =?utf-8?B?VjBORm5yZERIZ29BVHBKbEp3WEsyOVVodmtjcHVtS2ljcUZtaUNuOXBuNThD?=
 =?utf-8?B?dUNhNnZFeXJ0WllUNnpOVDFjaGQrQ1BNNWVvTlFaai9IKzR1VEhSejhWQm9K?=
 =?utf-8?B?QTlmbndTcVhxTUhyTUk4emdrU2RteWNUdjBJaUVSUFYxamtBUktvVGlhbm9w?=
 =?utf-8?B?NkxzTVZ1engrSFovMVBXVU9OQjdvN2puZlZwdzU1MXQ1OGd1VjBjSjJSVHVN?=
 =?utf-8?B?bjdWQytnb0FUWGF4TGNsR3Q3eGNLdHZ0WkVJY2xoeHpNc0JBQ0dUTkw1UzE4?=
 =?utf-8?B?SnBsVkg0R1k5QnluVk5iWXhLaHJlZmJNQU5PcW5PWXJqbEFpVDVsY2xmRnhO?=
 =?utf-8?B?b2N4and6RjNrN1ViaEFld1cwUTdGNERuTEtKVVRtRHVqbHZpRy9kcXpiY1Rq?=
 =?utf-8?B?dlpINHJteVBSTGZsU2lxbWVUdmpIaXRzMUNWOXJsOEdrN29QNFNBaEQybEhY?=
 =?utf-8?B?bHpOSGEvWjBFU2RQcEhvTWpUdGVGb2tRSmYxbGtqRHJlVVJPS0wyWmhBdmJ1?=
 =?utf-8?B?c2lvcXExbmpwT01mOXBsQ3FOc2JRcEpJcXMyUjdCbzN1TGtHeVJvT2J4TGlk?=
 =?utf-8?B?eklFMDNZajVQNWJZQ0dLMWFGOUI3WEFaT3dERklMci84UkJXTUNwd1BTcVZk?=
 =?utf-8?B?S21OVkNqVnpLOFlHZHBkR0xmbzR3bVMwOTJDSmZEZ3lqSnpRbENNcnFaM1JM?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02E26451944D6445B717D195B7B169BA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dZx6RvLJUKLspg1FT4pCZB0s1OxYiBCP55s1OD+ht4I6RhQ+EOhcAZJC7H/BqyXuSV113xJyPsEF1TpEztAMvC8g25q/qpzzQ9wWQ8TyRQqTpEpncTQzv+fhb0/ekgg8uFakGSLp/60p+TRtc8qCK2pFo71oLn9rvbqzN32R995hEdzYLN1I5x0nQiyRoZQmbfZIwsNAE18vcpjE52QRdxcqIO9yMIIRwYGOl8utjo/iUKHDy2Vsi4Wr34KI/y5RbxhiQBxKf+yWuLqFh+5Uhc3SBilip/ZOh4wQ6VrKwmcFLxyuEaMEWh/qAb20ALL8PYMzbZex3vciMEizzB4HtUoAM+QqprEcbPnsr72+SWQn/BB0SVzF9+UJJRvhlZ3oEraPUgFfu/EsWYrZqLS+i4iXPCFZfhhrDFiLPNMZ1/zsJVhKrrNx9AZ5lLmduVigpbYZqo24tlZ9uQn+UIjEcUwqGa5ZLkj0qKOJzd85BF7csPdj226NsKpJxD8RvGgsOPdxgOEy5oVzoDvOBRELrujBAuPQQiEsjcWdYM21BQbxh3S5Wl5sx39vcx7vkEMKZ0ruf8sUgfAaDdBTEEFLYGWPXKEhJfcoLKCgmPWl4Dw1s4Gaep+/oxL0Uov4tzS712P4x82kr1XiBtU63d0qAf0AOP/unOUGBYMtSw95aLnewx8qw+d1PffFT+d3zyJi3tIupdMP4R0YiofQ0YisrUPSQoo13K7pD6qbmxyRepoJcnrFtr/93Djx/Fe79IxEBrHDEYGKXXdvyFL1N+UHA9ki4pbIR0KlYh9bgHFLS0o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9da0b32-b06f-429b-e294-08dbf05e2bdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 22:05:45.2865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hv3M74BgHOTCTTYsLQpE1xoDzBe4Drf2DjVfsISZCZjexd5E7wzETJNjMNAUUajxIH+D4P2soRQ8pC+JIBThgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_24,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=705
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311280175
X-Proofpoint-GUID: 3T3U5xonr-xIxbM-YYK9ZsYwlJ51-2H-
X-Proofpoint-ORIG-GUID: 3T3U5xonr-xIxbM-YYK9ZsYwlJ51-2H-

DQoNCj4gT24gTm92IDI4LCAyMDIzLCBhdCA0OjU44oCvUE0sIENodWNrIExldmVyIDxjZWxAa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBCYWNrcG9ydCBvZiB1cHN0cmVhbSBmaXhlcyB0byBORlNE
J3MgZHVwbGljYXRlIHJlcGx5IGNhY2hlLiBUaGVzZQ0KPiBoYXZlIGJlZW4gaGFuZC1hcHBsaWVk
IGFuZCB0ZXN0ZWQgd2l0aCB0aGUgc2FtZSByZXByb2R1Y2VyIGFzIHdhcw0KPiB1c2VkIHRvIGNy
ZWF0ZSB0aGUgdXBzdHJlYW0gZml4ZXMuDQoNClRoZXNlIGFwcGxpZWQgd2l0aCBmdXp6IGFuZCBv
ZmZzZXQgYnV0IG5vIHJlamVjdGlvbi4NCg0KDQo+IC0tLQ0KPiANCj4gQ2h1Y2sgTGV2ZXIgKDIp
Og0KPiAgICAgIE5GU0Q6IEZpeCAic3RhcnQgb2YgTkZTIHJlcGx5IiBwb2ludGVyIHBhc3NlZCB0
byBuZnNkX2NhY2hlX3VwZGF0ZSgpDQo+ICAgICAgTkZTRDogRml4IGNoZWNrc3VtIG1pc21hdGNo
ZXMgaW4gdGhlIGR1cGxpY2F0ZSByZXBseSBjYWNoZQ0KPiANCj4gDQo+IGZzL25mc2QvY2FjaGUu
aCAgICB8ICA0ICstLQ0KPiBmcy9uZnNkL25mc2NhY2hlLmMgfCA2NCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+IGZzL25mc2QvbmZzc3ZjLmMgICB8IDE0
ICsrKysrKysrLS0NCj4gMyBmaWxlcyBjaGFuZ2VkLCA1NyBpbnNlcnRpb25zKCspLCAyNSBkZWxl
dGlvbnMoLSkNCj4gDQo+IC0tDQo+IENodWNrIExldmVyDQo+IA0KPiANCg0KLS0NCkNodWNrIExl
dmVyDQoNCg0K

