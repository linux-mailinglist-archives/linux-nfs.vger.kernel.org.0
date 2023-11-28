Return-Path: <linux-nfs+bounces-153-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9CF7FC91C
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 23:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A7B282AD7
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 22:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91931481B7;
	Tue, 28 Nov 2023 22:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wali6FtY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zqFnHo2j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F18FD42;
	Tue, 28 Nov 2023 14:10:33 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASI0u1v006991;
	Tue, 28 Nov 2023 22:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=a/MEBPqCatbBakupoURmnbmIa9iCpW0xcPobDDm2A8w=;
 b=Wali6FtYQdQ98TRIb03MssrT5vLpSZ9jEZo7CZvEvo0pnpjqEx83pflGPpTfAtbxhL+w
 tIP3kdGUb3r89p19Pt3QFry+h0upqgccJXSS+ZibvqkVpxrU0hxEdTP2AOoTsZJyyOwx
 GFU9tplWBwjYhaZ2ZeXnKTwD2AUxy5J6bliAd7hRhN0r1p8uPRQ+2GjiFhF6d5SjRSoi
 LDS29yaXe6DyPly08sSoUbGy5J+T69WqoswBTofZKf095dfTFhWrqdfAMrRwtIbw11Iu
 1BpUZOI9nljtN2LeVI7xm06xqHnE6+5uf1J4JkFn7D/ItUIhkB7/ah7v5jYimpGcjnku FQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7ucq0j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 22:10:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASKi6U4026973;
	Tue, 28 Nov 2023 22:10:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cdutp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 22:10:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXBnzaVEtEdaSpuQv1CUnIi0nJmduJHCsg/gJcQKuGgW2d1AmSNPMhAEjvMex8y3SDg+6ou3Ezi8Mx5Ru85eZHOMFZ6wg8lHehFaif34xoUEqo5tDiSSDEqfDFgb0+OmUFGSPAoCI5kD6huY+N721RLusa1nqVAnmzXXVQhSzZK2SXs99Gc2l6P190Sgzq6MG4a8YApkG2olrrv8pqLvfIQwuyH/MGIr5xIG0Up9v+LLY42CPRYdZV9mmbbfOEv8N0QFa6V7Wtcyn6ZTN7Lpu5rdmEXLHkisJaZm08tkK/qmGGOddJEe0Fp6ggIonB5Qw7S/tLwH7J5W7Y/Uf3G2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/MEBPqCatbBakupoURmnbmIa9iCpW0xcPobDDm2A8w=;
 b=UyrAsCDrbEnJ17BmI05fWyCC/3BfvObA/xPdIBMws4p8yFmE8M6+9MCK/SkZUZnORwHw3rPKPqiOv3pryYrzxqmgB7p4Yb07vpKcWDyIo9XO2piPvTowPUEEh3xJfOfOm6o/QkKvOZnC0lZOoO22lgBaNod8kyM7q/Yle5nUoyrBUW7ZtseJOR4ZrG3EsEFTZv78iu7W1SYYnCzyn0SAZXucCrZacx2VYAeh6UhutcpHjtR52RHNvLstWtcRR/HR1o7RElLpJFav+a6AzsJL40mzU3VOEbQnHFviCjNiwZLkSpXyGMjWfNjfqMi8bB6FJUeHVy8Yeyo2xli+4wOQ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/MEBPqCatbBakupoURmnbmIa9iCpW0xcPobDDm2A8w=;
 b=zqFnHo2jGPMv2Lyrqb6ahSSmXqt5BcVIUQagYvg+HItPEkLIvU45ZABqOZZOV890GVTCqpIAnHsmowyW/eNd4MF1/XxyJdJlZV5zKz6F94dGRpr7RpZIoAl71HXMs0YLF7+6RbweaP+8LNUaEt5F/R+T3GT/1IJq+w6DSN6BMOE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA3PR10MB7069.namprd10.prod.outlook.com (2603:10b6:806:315::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 22:10:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:10:20 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Chuck Lever <cel@kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] nfsd fixes for 6.1.y
Thread-Topic: [PATCH 0/2] nfsd fixes for 6.1.y
Thread-Index: AQHaIkZ1ZsrKBmyJQkOCLrKIfRhyGLCQSsEA
Date: Tue, 28 Nov 2023 22:10:20 +0000
Message-ID: <9ED5C123-EDAF-4254-97DD-54ABCFA00557@oracle.com>
References: 
 <170120886349.1725.10740679467794019580.stgit@klimt.1015granger.net>
In-Reply-To: 
 <170120886349.1725.10740679467794019580.stgit@klimt.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA3PR10MB7069:EE_
x-ms-office365-filtering-correlation-id: e8b525c6-7177-447a-d389-08dbf05ecff5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ftWrnDiSKtXiCLAj4QBGzlO0c+DquRlqr/L9eCoxEQGAt2/6DAmugsFcrpNJTLiEIWS5hN1kBwerj1jxArBvYuqLg0vm8zjhIuyLpntfVN5gEMJqzjXrfB6OMrQ0xeqalJqcGKtvMSPITncosqEzkG/hfU8wIx3q4B0lQ5yrAsopX4C+cQ0qJDa37W8H6ov5JwrrPgRgP/Mi8JV6pcn1AAAmVOFFNUzOOCVGRvJvMxvq5lqNbkRtvaL7kyj+alY0eOT0XNgO6x42czw+MWSUdj2FEQnyML7OxgPlyzS49bvkWk1k1Oy2IBBSuBBxNWFggTMLcZ9EGcad8OKicrcqb/4TuI67fu6B1/Hx+P1fxgD7oXPIeJ6SKc5M6hwGEP7kfvVlDk2A/wg5w+1Mhc946XfqDM9b+bm358n5m1zQIHcFfoBVcJ0hxYqHKG4Cxx923oO9OqRPuUQPnT97Y9gd1xcQhrZeibQ1djE+RKaPnz7t3TpOhy6kkGj9A7s1Kc3vCdYGw712KvomdtJj4x9+d1cYRNjAePwlhwpmj/SozIRpTIeRZfdFvMkGkGoq6rGI3nzBkl3b013SD2kJqB7tDaELdV0Et+CG/qjNviyTIqxbkPaxfgB4Zs7Y7wjgPcz3bBG4Zk3MMG9dOcvkgX9UEQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(122000001)(6486002)(38100700002)(8676002)(41300700001)(478600001)(4326008)(36756003)(8936002)(54906003)(6916009)(64756008)(86362001)(91956017)(66446008)(316002)(76116006)(66476007)(66946007)(26005)(66556008)(2616005)(6506007)(83380400001)(33656002)(53546011)(71200400001)(6512007)(38070700009)(4744005)(2906002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bEtUN2hSYWNyV1dOVys3RXh2b1g1aEdRajFDQ25STjZDcktoZ09qOC9zTjZP?=
 =?utf-8?B?akhjakRWeGc5ZmRkcWVFWjF3L3lVdUpQN3haUytlUHMxQi85RFUwWXRYL0JY?=
 =?utf-8?B?SjJrZHNIdGZwT25jR0JJeG1FWUk3UVBkUXFQemNrUXpQNGg2UCtDMXVObmt2?=
 =?utf-8?B?eDRYWWpFUFFqUDRQT2VqYmhNRU1LMjZSdlNLRmt0bytlV2RNcGRNTUJiQVg5?=
 =?utf-8?B?aGNPZkZWck04NXdTSUY5SmpxVXpidm9Mc2orOGhZSHdTaGt5UWdYbWkxK0lB?=
 =?utf-8?B?ZEYrK1h4WWY1elREbFJ6K1UwbC84ZGhlb0NMUDlUT3ZnSEtkUGdtc21MSGNq?=
 =?utf-8?B?MXZCK2dwZ2ZwRDBEZThFdWJ4WmduRlJwVFNIdXlZRTRucnVIYzlWQ292dE5P?=
 =?utf-8?B?YW53OUx6eXZydkFKUEFTczFYdHlyL3UyWEExY0w1WWRkT0IxZktva0l3QWlB?=
 =?utf-8?B?cFBLNjRDR1J2cnFlSCs5L2VvMzl0eUZoaFdlUjQ2VGNMZjJBOEdaL0IvS09y?=
 =?utf-8?B?T01JL2l1TmZZbkNrNUh3NVMvb3Q1QTBKMDhKVzdZL1FLcGI2dTA5T3JvSHZ6?=
 =?utf-8?B?OUFXL3Z5QXdDOEJjMmluMENsdXYvV1NzMEhuM2ZCY2tNOEVQR2ZMOHBBcnZD?=
 =?utf-8?B?c3FzQXdNTjlCY0w0TE1CbzFmZXEwR1JpRnhjZHhTNm80WkZ2VFBaNWFNTTNS?=
 =?utf-8?B?c05Ma0VhV2Q1QjlDRmcxclRyUlRmc1VmUHpoOHRaOEt3SS9NWVhHeHUxMjNL?=
 =?utf-8?B?TVIvdmRTSVlPbVdRK3VId0dhZStGK1RrVTEzTlNKdWZncUtwaUcvTnBpcEk2?=
 =?utf-8?B?NDJYRHNaeVp3am9Lb0F4MWpPRnhCd3hvMVBxeWUvQ0JKT25sVTRLMGtoQlVm?=
 =?utf-8?B?SWtYQVNJbElNbDRxQlgvaUVNRzFHTml3aDhVbmVSTTBieGRBbDk2MkVuN0dG?=
 =?utf-8?B?eXJEQU1VN2ZYdWZ4Y2dvR2lVcHhVdGg4dHVoVXdzZDV2aWpxcGJVSmloRUkr?=
 =?utf-8?B?UVFVN290TTdvUVdoQk9haEtMd1JmZmQ3SjRaNCtoOXZxb3d0TGRza0JCOEll?=
 =?utf-8?B?VWozTnBHNmlPOGlMbHRnNkFEMmJsTHFFdEJlZHNEWlBXcHNNeFdGc2h1NWFS?=
 =?utf-8?B?WlFYeXZiUldKejVEVlFDQzZpajUwR1llSzJBQVoyVHVaY0d0OWIzeDIzYThJ?=
 =?utf-8?B?Tk9ycndzRjMxVXpIL2p1SnZiakhid2YwRE0rS1ZZa0NVUE15UlcvTWkrRndw?=
 =?utf-8?B?S2FIcHlCUWRJZFVvZFBacXk0TWJxWnlSMWJUbTdkclJ2RmhSSHoxKy9mVHc2?=
 =?utf-8?B?VzdkU1dPTjRnRXhkNjAwZEFISUVta0N5Y0RXaGF4dksxSytab3FRRnNOaEdl?=
 =?utf-8?B?Qmpwa0hWSlJDS0NPaGE5ZFFzQ0dQbzVZQmlTZVlyckhYV3FvYlBra2d2LzVW?=
 =?utf-8?B?ejd4NGhnYWFkK1V1bjFKYys5eXd0TTJnM2lIamc3UE5ubWVicEZmMTZJbHRI?=
 =?utf-8?B?T0QvNU45RmoyRzNYOGRGWVFvY2FQVld6eVo3R0VnbnU2TnVqRzZRMjJ4RG1I?=
 =?utf-8?B?OVppVFlmZUF6MGd3YklvNzRDWHBmT0NIWnpsVWJlSVp4Zm5NM0lVUkxiekJS?=
 =?utf-8?B?QWZJTWNyQkdvdCtTcURySjFZek5rcnBuVFZoTGFEQy9KVHJjaFErOTk4M0lF?=
 =?utf-8?B?SVFBZjR5a01CWWwzdTJnNyt2d09ieXZObWN0dDF6SmhjM0QyaktDZVVwOGdJ?=
 =?utf-8?B?NnYxR04rcjlQdmdwY2dPeWZCbXBzV3k4SnNFWHhzYmxYSGZRcm5yOHU5b1VZ?=
 =?utf-8?B?a1dUYlhtUURneHNGTy9kUnFxUzFkRlVETUhVZWtoVUo0WlpPM3l3Uk5GNkNy?=
 =?utf-8?B?SU9tM2ViVkpSZjVDTHhOZnRIQW94aEl6b1lvUmE3aXRvSjkraUk5NitQcE5C?=
 =?utf-8?B?cUQwTkhleDEvQUVzeWhnYXd0R3p2MmFNOHVSTEpacTVub09qNGdFaHpOMjB2?=
 =?utf-8?B?N1BVdWdoWk9Gb0p1RVhTSUtDZjVNcVNZM2tiaFpRWFg0QUIwTjB1dTNwQXdT?=
 =?utf-8?B?L2hlTWhPWnZTVW03Q3dVNlA0akpkcTQ2OWs0OUdkZFZwcWVqK1ZvREt0Umsy?=
 =?utf-8?B?cDA1dllnbVIyTjdmK0l5ZzJyNjZhbkZZdFhsdVFVWjYySHpza3IzTzh1Mlhm?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B2B38EACFA25643805621BD7B9B7E53@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pNLufwSnBc/sXigVDT8zQ2EXuSdADaZABxf9hjnV785rc9JA3YvyOIfm+PjPn9cUZGBayqgkpUIhhihY0EtZMHxzkYkPpJIRXnvap0sCHENkC4p/Vyn/d1iMwL6m6e2c9Yj7BEfZ1X0+T+Gk4ekdZj+HOsQ/RH7z+lC9APp/n+azl7dLmyKE0MDl933IXXS0sXZ/B1lEyB8JXDTcftCW/A/jRzUaEwH7ffeELNrpiwEXgv+0fKo6+rLOtkA/vjphAzjajIGG4YHkcxsf3hG2GKdLZggnWWRWbi7Gg+xeQBIvrFhfDskc5U/rTJ9vPTlABe7MZozXw/A74J1i61u3MnAnZ0Y3IK7mm6KwxClmIWHTxL7Eb3N0hGJrqd/1aK+RYz2vC360bf1FLPbrO9pj7uMVbpOrmzzqiYYbKXU0inng2oYaMHaTDlqPgoZ4DKPdPQ+q0eTMXHZdoYUD0B4zHYExU/yM+5jxUT5OeayoBY+TrvgCb4Q/iCgKI5LG/WFxrMo6w/5PGghYpKuwYY1nZQz/TfmQe4SFWHN9d3bV7BxyztC5hAms9lAUBRWcghzB9zvojB7NNnAIm7DN197stI8lM9fuB1nQTKjGzWl0w37q+mn9kkZo/GhtzwKhRvXbmIRn1hgPvlPXfrzPgAE/g7m1iPOpaKW1H0uISQki01aaRQec52WfJ0zWQpZCeEGg+qQdg6CrGYPyBcbOWRKgrFuSwMgh1uazu2DzB2ljd9ULbRhBXlx8upYFEOqxZAZG+XabZtEgMgKy4jM1BIWrB7hgOVX1LJ9RcJOUnRwS/Y0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b525c6-7177-447a-d389-08dbf05ecff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 22:10:20.8924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eMwyqsN2MRe4rGoOwRxvpGwO/HpR2BSt7vzj1kwRmy3U0GgjC0lt4jQ/HXFkHxfBdrbRBZHQL4988mdcOtzPCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7069
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_24,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=891 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280176
X-Proofpoint-GUID: byvPaa0vaLALgmRLUzTjmFeGreVKt5s_
X-Proofpoint-ORIG-GUID: byvPaa0vaLALgmRLUzTjmFeGreVKt5s_

DQoNCj4gT24gTm92IDI4LCAyMDIzLCBhdCA1OjAx4oCvUE0sIENodWNrIExldmVyIDxjZWxAa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBCYWNrcG9ydCBvZiB1cHN0cmVhbSBmaXhlcyB0byBORlNE
J3MgZHVwbGljYXRlIHJlcGx5IGNhY2hlLiBUaGVzZSANCj4gaGF2ZSBiZWVuIGhhbmQtYXBwbGll
ZCBhbmQgdGVzdGVkIHdpdGggdGhlIHNhbWUgcmVwcm9kdWNlciBhcyB3YXMgDQo+IHVzZWQgdG8g
Y3JlYXRlIHRoZSB1cHN0cmVhbSBmaXhlcy4NCg0KVGhlc2UgYXJlIHRoZSA2LjYueSBwYXRjaGVz
IHJld29ya2VkIHRvIGFwcGx5IG9uIDYuMS55LiBFbm91Z2gNCmhhcyBjaGFuZ2VkIHRoYXQgaXQg
d2FzIHNpZ25pZmljYW50bHkgbGVzcyB3b3JrIHRvIGhhbmQtYWRqdXN0DQp0aGVzZSByYXRoZXIg
dGhhbiByZS1hcHBseSB0aGUgYnVsayBvZiBORlNEIGFuZCBTVU5SUEMgcGF0Y2hlcw0KdGhhdCB3
ZXJlIG1lcmdlZCBiZXR3ZWVuIDYuMSBhbmQgNi41Lg0KDQoNCj4gLS0tDQo+IA0KPiBDaHVjayBM
ZXZlciAoMik6DQo+ICAgICAgTkZTRDogRml4ICJzdGFydCBvZiBORlMgcmVwbHkiIHBvaW50ZXIg
cGFzc2VkIHRvIG5mc2RfY2FjaGVfdXBkYXRlKCkNCj4gICAgICBORlNEOiBGaXggY2hlY2tzdW0g
bWlzbWF0Y2hlcyBpbiB0aGUgZHVwbGljYXRlIHJlcGx5IGNhY2hlDQo+IA0KPiANCj4gZnMvbmZz
ZC9jYWNoZS5oICAgIHwgIDMgKystDQo+IGZzL25mc2QvbmZzY2FjaGUuYyB8IDY1ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gZnMvbmZzZC9uZnNzdmMu
YyAgIHwgMTUgKysrKysrKysrLS0NCj4gMyBmaWxlcyBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCsp
LCAyNCBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+IENodWNrIExldmVyDQo+IA0KPiANCg0KLS0N
CkNodWNrIExldmVyDQoNCg0K

