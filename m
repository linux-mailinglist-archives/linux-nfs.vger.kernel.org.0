Return-Path: <linux-nfs+bounces-1062-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 950A282C5DF
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 20:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FEE828231C
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 19:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D1D15AF4;
	Fri, 12 Jan 2024 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A1foIYCt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dw1Dke3d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD80314F6D;
	Fri, 12 Jan 2024 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40CJK7Tv013252;
	Fri, 12 Jan 2024 19:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=soysQg38Atgs3WbFkBU82l36NmW1i5jdolt2TrdPjXc=;
 b=A1foIYCtzh0JgTAz7pLUhKrvVkBOTOIO0MZEVLcxdX8kQEMqxsG3aUoU2EYhD2hwWv/a
 3BtPoCVsYYb8vmlfiAnuf2xXfjsh7/6gga0aM0XpZvvaC9Fu9ssQun+e8f8peME4Wtlr
 mAwhJzKsccUhTfuP8o6De0kQS4rna5+KJIODYNAY/Eoey5vP5Boar2xMkb0o2dEM6AR1
 p5sIDRVA+YpGK2RHkk5YMHN3nbibo4itBPhXi4jMA1XLm5H7wDYbm109LO9ZEqxxkiM/
 JKWUADBUDSaTlLXTEOGVenapHqQ0opXvnS7RZm6k28uOyMN6MozbvokhS8bhrhzx5N/L 9g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vk9acr8t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 19:27:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40CJIVot012276;
	Fri, 12 Jan 2024 19:27:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuwnyab7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 19:27:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4yPIDI//NJS212dShEEreO+T0Hu9ABfzDwBzDHlJbgo/nqQcX1TuRfDXik4elIO7Et/ylnn4hKtnM/F9H1G8m80LW/kTRwPO5J1xyErgbnTIJ686HtNyaT/Ti6DCDBB/BMeLgkw8md1VOyX9hsqZPKVSNoNEpn89f11LXET22p/7T7zmXHE8yphZUmtIt3mCblzFLORo4EGSu6DDoyimAUIC0aVu7+PAvlawHb2wZwzoC5MMzmEAfeiV4ucCmbk3+9PtehAAKS4GQVERiMKEiSZMPhInPeTso+02ArnwTx/p2935LPSNWh4OKK/FTSQjy3fvkPPRwee+rC2nU9twg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soysQg38Atgs3WbFkBU82l36NmW1i5jdolt2TrdPjXc=;
 b=BmeapjFL9KKVLcup9K+Xjh0WT0YZzqaLHkPVkqbvGIJiAOtY1qsrsqbs8RNdR/qG3Kf0To3XLOmCrBVWV7WQYz/2+KobpvOFn8CtLrSOB0Beu7+eC+tGky8rZ2zkKtC0iwPQSgPuUIGpAiv28ohdZG2zlxAS6ViP67XpzOWIXDpNDibzylpD+fn9xAiFz6mECrJKJVDlfu3lujUmm2soFro0I8XQlYw5WPjQGyVt0APF1AREq52kQ3Fik3ZeCdE4bdERwa+inphGF4EyZtFP+nMrQ3VQVIuBPUbOfnpn1rIJirSA4pvQ4EM4q9FJdP24/xXk+rNyEJmxpaF0MkLglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soysQg38Atgs3WbFkBU82l36NmW1i5jdolt2TrdPjXc=;
 b=dw1Dke3dELr2Fpta5jYCHo9/UFP0kwnX/DWOTII6aAZ6FJh5Q3Spbac2rnm345TCWLntZIUQmrMqy6ieZNbS42+VDzpYQeWtHEygDmh5BzU00vxrufuGOsLaZJXpS/dTfZb00wFLwt/GaUVrIYuuQQiGwSs/DqFCRuFEgB1x0EM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7017.namprd10.prod.outlook.com (2603:10b6:8:14a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Fri, 12 Jan
 2024 19:27:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4027:2de1:2be4:d12e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4027:2de1:2be4:d12e%3]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 19:27:40 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Zhipeng Lu <alexious@zju.edu.cn>, Jeff Layton <jlayton@kernel.org>,
        Neil
 Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo
	<dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust
	<trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>,
        Simo Sorce <simo@redhat.com>, Steve Dickson
	<steved@redhat.com>,
        Kevin Coffman <kwc@citi.umich.edu>,
        Linux NFS Mailing
 List <linux-nfs@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] SUNRPC: fix a memleak in gss_import_v2_context
Thread-Topic: [PATCH] [v2] SUNRPC: fix a memleak in gss_import_v2_context
Thread-Index: AQHaRTPnoXVylAI9zUS0n79WCePwLbDWj6IAgAAAuYA=
Date: Fri, 12 Jan 2024 19:27:40 +0000
Message-ID: <824EC6A8-24EA-4998-B1CB-8E54FBB51129@oracle.com>
References: <20240112084540.3729001-1-alexious@zju.edu.cn>
 <20240112112454.0840bcf3@kernel.org>
In-Reply-To: <20240112112454.0840bcf3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB7017:EE_
x-ms-office365-filtering-correlation-id: adc89cad-2baa-4e64-2181-08dc13a48aa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 GZQKSHnD/QxulsHiwPYgCxbcvEP6lcFAYO0q2voLvOtazmmbcTFh7Kr7r4PqDdIDeBs6BHJCxCmscrqgcdO0gNJwjN5fsqpnGKWttrz/7gegM0aOhxk4S5CV5TmBigq0k3jYeHEfKCTBUL34mvL1mwkwu8lyjSwIhKIKTvZ9vI8TV8uIiwDlaeiLbvoHM1HNDxueZK4QGs8bjRRSsFxwQDQemOVM4nbgoyTHw71OcvoqBK041g2lNCBxJYDhtXu1HUAho0f1Hx/G1ZCYloyZm2REvsI8fQKl2HFw4UoxqKmyKv0hMOrcvjo5C+DW8HoLfKvawd5no+N/VeInx2PtZIfEDte9I4gZw5uYsdrDq4aMV6N45SFM7loxlIr5MIVFcrCwQSzNAF5BiGl3gzgUNmUZUnY2hp7u7Y3PSaPhgAzTybcq0krXCn0XPKslQIglEXnJTsMQwgW9YaroN6+Fqg1mIS8Jpbd2PJDYU49ogfmGqMSrE+qHUXdbZlR9xfMbI9AdW2dHmJksjo/PLpPKvuy0s3znjUUCIaFBhP5wgNMxB2HaoZO0g6Kl3MCyPY8a1dd8MzkXX+1vUklkCzuXvcKFfrEN7336cPGRy/wW1wXJ4Jlid0xCStcxT37wC+R03gYvMGhZwMobwX2s0jqeSw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(136003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(7416002)(4744005)(5660300002)(478600001)(8936002)(86362001)(6486002)(6506007)(2616005)(66946007)(38100700002)(66476007)(33656002)(6512007)(8676002)(64756008)(316002)(91956017)(71200400001)(76116006)(53546011)(54906003)(6916009)(66446008)(66556008)(122000001)(26005)(36756003)(41300700001)(38070700009)(4326008)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?a2FpSGNzT1ptVTBLalNraWJkcGlZdHljV0RzR01DMVF4WGd1YlpBWGxVUEhQ?=
 =?utf-8?B?ODFwZDZrS2hodmQvM2ZINUhNQnBReDNFWU5Pb1k0NDkwMGVsdFZXOUsyUXpq?=
 =?utf-8?B?K3VKOWRmNTB6cnRrMDl1TDFlRlNUbjJNWWNuU2UvM2VSSkQ2SHYrbG5LQWdk?=
 =?utf-8?B?S2R3azUyblFOeXljc1ZmVi9DTmRLYVNzaWcrSGlCVHBETkppbVBab25yYlpy?=
 =?utf-8?B?WXcvQk5DTG8wa3E3T0ZBS2dTb0pkRXpaN1JSNnlUMVROS2NLalJFMEcxZHlJ?=
 =?utf-8?B?VFRhaVR3K2E5UzZXUHhWa0xaTHZobjZFZVROTk4xRlZmeFdZbjZ6U3NiL3Bt?=
 =?utf-8?B?VkdPQ0xmQWhPamhacEVxdTRqSW5WUjAzSXpGTE9zditFT2UzVXhKWFluYXg1?=
 =?utf-8?B?U1NzQTc0U0x0L2UxdGNIWHhDblpRRUYyNmt6MlVpaDJjbktRMWh2c2NtQS9h?=
 =?utf-8?B?ZGhucm1acFZmVmdtMlFVNXFHQ3NGMkliYTNiQXVtUzB1blVkMjI1TW1jNzhB?=
 =?utf-8?B?NDNlTmk2SUREM2xyVGFSYmtBSnByZEVCUGFxTlc4QmhaS0M5cDJFMWFFcUVN?=
 =?utf-8?B?Y3dZejZzb1FFZjNJNGpCZDdibHJpV1F0dFg3ZTRmcUljUmFIODVCUnNod0ZN?=
 =?utf-8?B?bWVNWU0vRDNQU0p3aFg5RWNFcEpHYXprZDJOU0pJNGttU1RZSCtUK0RBVktX?=
 =?utf-8?B?WVFKTVpiNHVYOUlybU52UWVSSVFxd2RIUTA4QytxcWppZlJEdFIzQ0s3bmNK?=
 =?utf-8?B?TExjeDMyZDQ3NVV2bXZXZy9mMW1yS3FtVDFBQlgyV05qTzd1K2Q2YnpaTy91?=
 =?utf-8?B?SXAybGtRbW1LWnI0RTQ0T1dDbDhVa1BXU3JlakdZeXZIWXVjb2FrZVdxdDZp?=
 =?utf-8?B?ZUo5NXlFaXNtanFsdmV0cldZeEFwbDc2c0ZCZVZweXh1MDcwNTR0N05uaE9x?=
 =?utf-8?B?eFVQQlRVejRLMHByMHAxWnpNZGdKRGEycE80SXVyVzlsY0ltekxYZE15ZXF3?=
 =?utf-8?B?b2ZxSW9QYnY1YVVPWjBVQm16RmlHRVo1NnBROGpndkZMNVlaYUVmQmlnWDJh?=
 =?utf-8?B?cW1ocTFOQlp0c3U5VVNCNVJhakphSFFySEVCNzd1Tkc1am5ZaklpS3FLcTZK?=
 =?utf-8?B?Mk5VaXZ6OHNqMGQrOEFsMExHV0YvYnJBVmxkcE5hQzVueHRuMHdick51QWp2?=
 =?utf-8?B?a2xoNnBPelkzZlZjR1RsYjJ2L0cwRVZGQjk2bVZtWERJbURZYUhMaDZqaUds?=
 =?utf-8?B?a2N2TVU5WC9wNXBFNzFmd2R6b2VsTzdVOUhSZ2FZUk5VSmVUNWpLNnRSQnd2?=
 =?utf-8?B?SXpkNUlwbHZRbE1KQ0QzWURnM295SjhyeENRalpyaldYUDk5eFB4ZjFXR2RD?=
 =?utf-8?B?aEV0Nldtak5SZFF2d2pkSWlkaXlkcWlndVNoWkl2QWtCdEFndVVLbkZWVlQw?=
 =?utf-8?B?SDg0WmZWNitpR2EvK09FS0VXLzBNNktqRzRRcXI3ZXBrOUhPdDc3THBodEI2?=
 =?utf-8?B?NTNWeHNzVGJLckY5QVR2eHNkcVNaZFNLQ1YzRGVIYmFKcEE1TUxzV0RqbzdT?=
 =?utf-8?B?SEZRUkxpalN1RmJmREl1S1Ixd2ZtejZhYXUzUUJQVjBNMXBsNDZCSThXWWpo?=
 =?utf-8?B?VHY3SExBVENtMkFNWjd0M3MzNXNIUmtNc0ZVR3R1Y3hML29VSGxYWjJnalpl?=
 =?utf-8?B?aXhLMm1QaVJDaWZRUkF6ZDRLMS9qRGFoNGZjNHJxVDFVaUxMU0dYeGhWSWFH?=
 =?utf-8?B?TWxQS2RmS00wMFc1bDBoT2tBbmJsQ0M2R2VPOGZxQkxjR2lkVHMweDBjN05O?=
 =?utf-8?B?RzdYV0V1NnBPM2pYMnFaRUhFVHdJZnlqcDlybmhsTFZqYjczSTA2dnJqYzd4?=
 =?utf-8?B?MEozd3F0V251aWJhelVaVVN1ckt2QXpGcFcwbjFXT2c4bnZMTFUvSzNFVUtY?=
 =?utf-8?B?dzNVbnFLdExqSUhaNjVWZStEWWRtVDFxQ2tzbVlPQ0pIbC9VQjVYTXZOMkJj?=
 =?utf-8?B?R1NranZkRE9PWXFxWlJlclpjK2prM0lLOTEzdFg2ajVtYU80UDAxUGdVZ2xU?=
 =?utf-8?B?N1NuRldnT21mVkZ2eDBVUXJQeWJwbTcyNzlOclFESWJCNEtYaS9KN0s0aHVE?=
 =?utf-8?B?MjVqUy9jNzVCL3ZyZW5XT1hqTThIRVlPQzlSTHcvTnpHbDFaUExVbUVUd3lq?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AEA4A1657A053498CE84923EFBCF24F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ALo3pr89YHIqHIhktg9U5R13vOtxzOY8hq/JPV/S0gkg/LzxoxuBGiZlWnIryWsK0QfUd/79h02Jp6kV+5Fdw+/7WIYJVX2HUXMxRx9qDpYPcKXMJmUFisWwgF6dYszL3pAkS1CYvf31a+ZW2As4MtxbL2+CROp8a5TXhXY50ETRs8SUw0q4ep38nwCKRBoHCV0s+DlvFm7p/pThpaXsA0+OpR2lhp4MBLtEe3oe4cnVVfMErDAeDCgtmRL4qYH5vTf1lFSgRQsHQqcKilSffpVeFARVVGSySd59rymAyhsM1jH/SGoFSpAd/B7cRBH7zeqN8qVqQRjXUR0ZU0QHBMpMAuc6BdibeVGcAGy6CyLIKpHLnYOeWZaG01rGq+iOR+/J4zsPE67FmCBU/YxkWI8TGPNWctPhQpMMRuoCXlQw5G/uXK+s7+471hysKjl1L+Iryu4t/FwK1igERknn0cTdeBMk8LtpQ7SPy+NwMMTJvRZBJX1Qx0TOcp7zQcVUlXnUJ08B38BOqEqGZjI85II4fETcoQNVjWYg2SAcN+FvME7MOD8uhccc+77RAOtFbevXR7IEY3P1XeMa0tNwgtKK3+YjcYbtbJFc9k28PJk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc89cad-2baa-4e64-2181-08dc13a48aa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 19:27:40.0998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AtVyVJ2Oc0I2mgX691CS8jWUXBsYvtBa9mXM0bFHFXjIpAlP5PP+HbJTsTxD3Rh2hzc3E2hP6/G7vlafceINAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7017
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_10,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=867 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401120153
X-Proofpoint-GUID: oXwAOQ9di-f4gHG4hz-ma6ugP5hWu3a3
X-Proofpoint-ORIG-GUID: oXwAOQ9di-f4gHG4hz-ma6ugP5hWu3a3

DQoNCj4gT24gSmFuIDEyLCAyMDI0LCBhdCAyOjI04oCvUE0sIEpha3ViIEtpY2luc2tpIDxrdWJh
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCAxMiBKYW4gMjAyNCAxNjo0NTozOCAr
MDgwMCBaaGlwZW5nIEx1IHdyb3RlOg0KPj4gKyBpZiAocmV0KSB7DQo+PiArIHAgPSBFUlJfUFRS
KHJldCk7DQo+PiArIGdvdG8gb3V0X2ZyZWU7DQo+PiArIH07DQo+IA0KPiBjb2NjaSBzYXlzOg0K
PiANCj4gbmV0L3N1bnJwYy9hdXRoX2dzcy9nc3Nfa3JiNV9tZWNoLmM6NDU4OjItMzogVW5uZWVk
ZWQgc2VtaWNvbG9uDQoNCkkgcGxhbm5lZCB0byB0YWtlIHRoaXMgcGF0Y2ggdmlhIE5GU0QncyAi
Zm9yIHY2LjkiIGJyYW5jaC4NCkkgY2FuIHJlbW92ZSB0aGF0IHNlbWljb2xvbi4gVGhhbmtzIQ0K
DQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

