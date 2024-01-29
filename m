Return-Path: <linux-nfs+bounces-1571-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C590840CBD
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 18:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804881C2353F
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 17:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E7D157031;
	Mon, 29 Jan 2024 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HCCMtJVs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eoKoH4ri"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC20157020;
	Mon, 29 Jan 2024 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547746; cv=fail; b=h8vRGVzMne908b+9HvTY3MNdBsyNBaAgxW7d0bIm53EDejqabkjvb0lpNe7uBFTYJi8tD69uS1QOZC0TVBkzuo9+YW+g40TdcqJ3w1vSDff9NLtvp/0ddsSjetieoB7cT9W9QwC8tCDMrDLskyG2ZIsxPeJVHn3GZIZMIGF4wXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547746; c=relaxed/simple;
	bh=ip4gvHM2fX+rGpGRXyw4kYoAIu+P/4nK+7T93RDl9qY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GWlVZQe8tivt+AECs1mYX8iYq6Hy0ztnVr87+rbgzwmMnvB1fb3HNh8zMmgVoZVvoKG5jL+uic78TS3BUbVWZGbZJAD5AkPMK39jg5PrOptES1rMkSSf17joBX2wpTsCJ+STkt7cmc8sfpE9Mckm93cy9sQon5OcMudc2K3P9as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HCCMtJVs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eoKoH4ri; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TGmvAB007080;
	Mon, 29 Jan 2024 17:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ip4gvHM2fX+rGpGRXyw4kYoAIu+P/4nK+7T93RDl9qY=;
 b=HCCMtJVsQm7JWV+p3A2AkJlZtbxlCmPCuTTuWy9qneJMG6iFCkXZttVqbbo6vJkzU1Vg
 Q4HQ9QQ70xq9QfIRL1H5ufNzHKaTHy4RH6ir5+jz/P0DpBXLl5Ww4PF7E00DM9h1AAUt
 H3bHPSEliIURN8gcnmHiOwyDRGt/lnoR2vdPPjqpjVTSOqraCemyVgyit7Tz4TllyeBb
 h2wRJkeAt/amOIcYAJmJPGFtdGSGT+E4UYrXuEv68uMFZ8KWz704X/FCROQD0xCcDC4U
 IwA6wVi5OSHSrW9w+oMKN/iNjaY8AfkBTyLx4VsUZ4RkprERfYAgEpjJR+dpOoiNvh1Y wA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm3vfrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 17:02:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TG0FbT035398;
	Mon, 29 Jan 2024 17:02:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9bwygy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 17:02:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbkaTD04jMql+N7O077O71FD0gzA6GB64kN6y6dG2+g6NC/JAN89Hj8/4WGnM/0CNSD5dr6zLCN/qGwig325y48gKMiSySVzWSh/RXmbQNvRuqVAro+LQBj1ZJesKmT1wDQhC3xEYqfMr9SNPjGJczQFNBAG+mQ3KtIpTaeXh7APWmJ9qSoye/6WLePa+ZCU8ow9oRToMRsfKhgQjOWL7WHG47l2WJtjZTWdR/h3+E1Gkgq+xssak5QoSCg5L44Th1WtjYDszkIRcX6ZHhIEl3Apy9Re7Zvos8M6FXy01Mhw2y806BC/K8tA/ksPo6uZf1OWFisdk596nxWRay16MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ip4gvHM2fX+rGpGRXyw4kYoAIu+P/4nK+7T93RDl9qY=;
 b=gY4hC0VcgzMd0/bTrCjN7x8ADEnpU4ew7B6TOF2NQ/gWIZ8M1l0Ho/HhLsZp0kfr5tlW9+MGG8OmgDJ/gB6ulJ3GJYAZuPc+NawA89lUfbvPcx+yJKjnexI5sbd6XWC/IU2hB5jsGA9XuJf7ZGL9YJQ/n2PVAX/h+LrPVxjez4BbvcLu+XPcHBDy7vnktV4iaZ69ZwA0ScYD6ZI7ivZ7FhLZ2XX+Fxk5QLEfS6ZdH9hTK4xK6qYoR4dzGiZEDu99AjQ9OE647DQw1Neo2uXe25GNEy/bSLxxhP7FBkB/MnTFL+CEh3zSdjSOZ2OAMCesVfP3KP9FxlSMzEh0oXTTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ip4gvHM2fX+rGpGRXyw4kYoAIu+P/4nK+7T93RDl9qY=;
 b=eoKoH4rilAPAA5dD1kuKbXsn+0v6liMWhoCMYdckpL9OsG5MBufUuiT4/9MTMTB612yiIuU8ydDMrydrX5ScJkbLTCyJNHTRtgHRz5gC3xUOs3rs86ZJphEpDS6Pv4LPGqOF3pUITz3BS0DgPE1BUtMff1l73V02AKI/Dy0q2iA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5572.namprd10.prod.outlook.com (2603:10b6:303:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 17:02:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%6]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 17:02:04 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
CC: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna
 Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]"
	<netdev@vger.kernel.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Alexander Aring <aahringo@redhat.com>
Subject: Re: [PATCH] sunrpc: fix assignment of to_retries in svc_process_bc
Thread-Topic: [PATCH] sunrpc: fix assignment of to_retries in svc_process_bc
Thread-Index: AQHaUtJM1QSrjYxmB0ONPOC4M70BBbDxAXoAgAAAxgCAAAEwgIAAAKKA
Date: Mon, 29 Jan 2024 17:02:04 +0000
Message-ID: <FF83118C-41C6-4D4F-B4D0-8567E2F68708@oracle.com>
References: <20240129-nfsd-fixes-v1-1-49a3a45bd750@kernel.org>
 <7E6930D1-14BC-4CBC-9833-531BF6F5D874@redhat.com>
 <C4D894E0-F9C9-4C31-BA49-05E942FE0A6A@oracle.com>
 <54456569-284D-4294-BD75-6AD3F68BB5A8@redhat.com>
In-Reply-To: <54456569-284D-4294-BD75-6AD3F68BB5A8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO6PR10MB5572:EE_
x-ms-office365-filtering-correlation-id: 9505e882-a275-4e6f-2e37-08dc20ec049c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Xfb/CO2avh360CPJgkUVCqzP2HQZYF9AWNWxYu7GNiJq44Y4GSEpkyeealQOjgbNfWFtkcnqsI8dWMP7VL/4rJAiUNJN18/5NBorpoUHgxWjHKThgpq2nFigpQwTdkDzkxprJ5k5P6eyOJpXSaryx6QBPBqp5+OCebHbDsDTz24RJi25jXprxUn9RkGo+zRLfiTfC6T7bPhRLyJOuBr/qovZkl3B4easjnMWGnXkILkv6COEEFaP5bfxk+xoF0KyuBhvJcL/aRFAsQTRr1A/1o6OKOJ6IRjAR93BBHn7yq7EaGwiS8G7j2jRAcsr8dLtZandHB/WrYfCeGu1a/ZR75nn/9jjMez1RHoEumL2Ep+FncuV5Of5PjftLqOc6xjd28yIqEstowez+cOZAscngDJVPhgvOsPBjlPCtQ40GNyqgpg6G3PE1FIfB9zX2fixkxUgjbUZ0nVbZjNoJ4yW4LIgYoDKbI2dIo3zmeIuQALLXPKev09KiDzmDPBe6IEQybyLiDa0SKa4Rbr7QZFqfL9z8RyWOgMDf2LgJcvB+repk7bx3Czr+GoK3jhSJLwthvqzCmEdraCBtw0bIlLhuQe+jGvRitXyVUIC1wN2na/IRgLDMKGN0INV2q18qEWcRLwhRtXeTsLBkifiiiPZyA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(53546011)(6512007)(6506007)(33656002)(478600001)(122000001)(38100700002)(316002)(4326008)(5660300002)(8676002)(41300700001)(8936002)(71200400001)(2616005)(4744005)(7416002)(6486002)(966005)(2906002)(66476007)(64756008)(54906003)(76116006)(6916009)(66446008)(66556008)(66946007)(26005)(36756003)(86362001)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TytqMGFtNmZNWlhYdS9hODgwcHFueFEyZzZzTkxNN1hBbFJYNUlUeXZ6dFdF?=
 =?utf-8?B?cVdvcldGNEl4eUU5YXNUVEZRYXBzZGdYelVMcXptU3ZtbWYxV1YycVM4cHN3?=
 =?utf-8?B?OG1wdnZMMFdsWTV2TzN3KzVNZkx5UUZ1MVNteVN3TDlkZW5IbS9hVkRJUHpX?=
 =?utf-8?B?Q1ZZR2ZHSmhEb3FsaWpkOGJTUnU1TjRQS3NSUGw1RzFwSHBtWk9VSmRJeDFM?=
 =?utf-8?B?YnNmZ3N2c3dLTnByMGdleWtOc05XYkxVNUw3RG05YUtKTHlmOVBvTng3UWRp?=
 =?utf-8?B?TDdVMkZsVm54Sk9uUEdsUlRnMU9OQ0hTbU1zRTUvRmZGaTJkaHk2dDV6R3lj?=
 =?utf-8?B?MWFQZXdFWDZDVGRTOUtoYmVOL1dZdWs3K25kcHJRSzJ4RzQxSTZ4eURseDZq?=
 =?utf-8?B?UmJma2s2QTNpNmpBM3QwUDBDYno5TEwzNmlYZVY4RVdrYjdWQWQ5dEZlMTFZ?=
 =?utf-8?B?UENVRWZhc0luL1FoYjNYT2RPOGlDMnlvUFBXUHNsaTV5NzZRMy9pQmVabXNW?=
 =?utf-8?B?SFBGODh1ZU9mSm80NzZqVGtKWFZhQ1Z1Q09wV1ZyQWt4M1JML2dTYTFQRldD?=
 =?utf-8?B?OVplMXdXMzFaSVlyYVdVWFhjMTExN3RrT2VhckZCczdhY2Vma2Z4NHpzRUJx?=
 =?utf-8?B?MzY5dlN2MFhycENWWnFhY0JUN1luZHZJdE9IeUJMUkJBemRCK2FDWkM0clcx?=
 =?utf-8?B?R0tEWklOazJDYlYwcGtSZmRYZFRzOVFvZGJ6bEQ5SkVEQTVQd2hIaTVXSEw3?=
 =?utf-8?B?UFlINWFCaU9xOElZVlFUbUFWc3A0bDZRN3R4UG1NQWlVUHFZSHA4QTZkTW1h?=
 =?utf-8?B?S0ZjN3pkRWFySEpEUkN0Y1Q0dGYrU2VxNTcvTndiQnhINEJBWlFsdjB4QW4w?=
 =?utf-8?B?SDBUU2Z2MXRjdmRRdXcxQnJJaEhFVU05Wlk5T1lhZEpCbGQ2S0tDbkovb2tU?=
 =?utf-8?B?b2tGbFFnd28yaWxQTHozUndvMUNiczJjNzk4SkR5VGYvYWloN015bGZ1eGRN?=
 =?utf-8?B?NkQ5SHZvMGhsU2ZUMzNHRmZaRUsydE8rdmpjRXFiM1Y5OGlFVS81MExhQzk5?=
 =?utf-8?B?ZklTc2hkUlk1VTVmS25DdnJxNFI2cCtLUlNGL2xDME1CWVg4dG80TXJMWjh4?=
 =?utf-8?B?ekRGMHRxV2lqa3FzL3V4M1Q0UTgxb0JLQ1BocTEwa2lBQlVZelpUMVFaL0Ir?=
 =?utf-8?B?Y0lncnVQK3gwcTBPdUVnRTh4L1JYbGxobk8vSGhSblBUVlNERzd3QXpzT0pl?=
 =?utf-8?B?V0g3ekpxSnBndzBKVHQxMy9UamllTGgrcmtUTlQvckR2aXFjVk9CTWgxR0JR?=
 =?utf-8?B?Z254RHE4ZWMxTnhwY3hySVZhbVJKMjhPK2hDWHp6Q3lreUNsamFJMm8xa2NT?=
 =?utf-8?B?Kzg0NHhZWFFGZUpqZGE0WWw1QlYrblE1dnVuM094TlN5d3ZxaWVBQlVSN094?=
 =?utf-8?B?VUFYQ2kraWZXajhXYzRlRHlrMklOMU9WZTdCZjNWQVBKYytTQ3JPZWFNckJh?=
 =?utf-8?B?TC9NdVI1dGQ5VUpBVGtveVlMcFozL1hRQk4zcXhhN1ZOVjQ1eVhWdnBaaDN2?=
 =?utf-8?B?cmFHL3hick13MU5UYzFKUXcvR2JCdTFQVVBVSmhpcEVvaGE5WDBiL3BUemM5?=
 =?utf-8?B?ZGFUUE1FYUVMK2pRVGhINjVQNDRMeDNOM3ZsdHdwY3ZEbUZkLzEyczVQYy9v?=
 =?utf-8?B?Y2srblFtRzhpdkxkNTBQZFl4WVl4dFRDU2U0M1hMaG5Rck1aUXI4VExhT0JQ?=
 =?utf-8?B?Nk5EakxSaGN1em04N3hUQlV4ekRwK0Fld0VodTlOa0p5eGMzYzlxb3UrcGZK?=
 =?utf-8?B?MVBEUUNrc2tMN0Ntd3praFdsbHZGbnc5c1I3NHBmNTFYRmlTbE1CRm1QVEp0?=
 =?utf-8?B?bENTVC9meThzV2RlWWVxOWZlUmdMUk5UTHh3bHRLMklRNXdqRVFGcEhIRWpy?=
 =?utf-8?B?QVVVSTlGRmo5MzAwVUZEd1pVU3BRQ2RsUjQ1QjA0ejVqdGc2NXZGK2Y3ejFL?=
 =?utf-8?B?cE5zNTZQNnFMNXVXNVdkZmtiQVFLTHdSem0ybndXNGhqZlFtcmc0aE1kVzY3?=
 =?utf-8?B?S2o4VWRLTkwxWXBaeHRNZXB5YlpURDRBTFhwZWtGcVY0a0Q5ZFhQWUYvb08x?=
 =?utf-8?B?YU5samJRZm11UjVHZENYcGhrS2pRcFFydHExSFVqUW1yYk90ZGxiaDRwZm8x?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33ACA40CD5DF644C845C6AC9633360C4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PX9fN0xaMukU1yJd4Q5jQnisoXKJkZyEdNKG2D27Qrbyf35wxGseGPL3wyuolaeOs5W+C3LvSTXNRz4WvYLC/nxvjyhcVp6US+y/Tyts4RS2CSQmKWmmNGVG6Q63PD1FJRPZUZEUl3ai2gTj79t3duUY12+RFfQ6LiwxQgkD7RmvirqO8FXPJsRoL64DzZG7znqxsc1HwAXN2vRDaUy87wQz0Dun3AUr06nVdqJnZd3kS+pylCsoh/zws91P/ExlzNx4k1KvWmcHXTsx95Xee4Y+syciO39sCfMzPHrhQrkkXSrYzLuha0Ait3ipHFazPPeTbt3J5uaKXACZbSimRhz59nhuM0GiNXsVfMpSM2BGSSQk0EhItxxz162Go0ig0pH7iDgRUme6hYkzJ34Ab364YnG0Y9DDljySohDWOOL3OaI1gyheML1BH7t41Iq8ooQU5Tr1UAEwW2C0oGbHnt54SAkCEFKEP3TItScLlnEjJE4sMhkvIfaSxYmmaONAzuFxaMnF972ZRQWANiEiRQCaZnKvTrNyxmXkjTRtVPGvoB/APKKHsV59m/kXZQeiJv7H0660VTzYORqLr5SWJtA3z14L3TEvwJmuxjI6QoY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9505e882-a275-4e6f-2e37-08dc20ec049c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 17:02:04.0993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3t7y0F5iiYr6/u5P5p7HB3d2imKXh+rvU6csrN2ZX7dHAX13CZFHLzfBukDwUAP2Thad0sCK5vVm+AcEzeMouA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_10,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290125
X-Proofpoint-GUID: blLG44DCf1cvZ0tySuqyIcpyNlJKZrK6
X-Proofpoint-ORIG-GUID: blLG44DCf1cvZ0tySuqyIcpyNlJKZrK6

DQoNCj4gT24gSmFuIDI5LCAyMDI0LCBhdCAxMTo1OeKAr0FNLCBCZW5qYW1pbiBDb2RkaW5ndG9u
IDxiY29kZGluZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIDI5IEphbiAyMDI0LCBhdCAx
MTo1NSwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPiANCj4+PiBPbiBKYW4gMjksIDIwMjQsIGF0
IDExOjUy4oCvQU0sIEJlbmphbWluIENvZGRpbmd0b24gPGJjb2RkaW5nQHJlZGhhdC5jb20+IHdy
b3RlOg0KPj4+IA0KPj4+IE9uIDI5IEphbiAyMDI0LCBhdCAxMTo0MywgSmVmZiBMYXl0b24gd3Jv
dGU6DQo+Pj4gDQo+Pj4+IEFsZXggcmVwb3J0ZWQgc2VlaW5nIHRoaXM6DQo+Pj4+IA0KPj4+PiAg
IFsgICAxOC4yMzgyNjZdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPj4+
PiAuLi4NCj4+PiANCj4+PiBUaGlzIG9uZSBnb3QgZml4ZWQgYWxyZWFkeSwganVzdCB3YWl0aW5n
IGZvciBhIG1haW50YWluZXIgdG8gc2VuZCBpdCBhbG9uZzoNCj4+PiANCj4+PiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1uZnMvMjAyNDAxMjMwNTM1MDkuMzU5MjY1My0xLXNhbWFzdGgu
bm9yd2F5LmFuYW5kYUBvcmFjbGUuY29tLw0KPj4gDQo+PiBBaC4gVGhhdCB0b3VjaGVzIG5ldC9z
dW5ycGMvc3ZjLmMsIGJ1dCBpdCB3YXMgc2VudCB0byB0aGUgY2xpZW50IG1haW50YWluZXJzLg0K
Pj4gDQo+PiBEbyB5b3Ugd2FudCBtZSB0byB0YWtlIGl0IHRocm91Z2ggdGhlIG5mc2QgdHJlZT8N
Cj4gDQo+IE9oIHllYWggaWYgeW91IGxpa2UsIG5vdCBzdXJlIGhvdyB5b3Ugd2FudCB0byBzb3J0
IGl0IGJldHdlZW4gdGhlIGJlY2F1c2UNCj4gZXZlbiB0aG91Z2ggaXRzIGluIHN2Yy5jLCBpdHMg
YSBjbGllbnQgZml4OyB0aGlzIGNvZGUgaXMgc3BlY2lmaWMgZm9yIHRoZQ0KPiBjbGllbnQncyBi
YWNrY2hhbm5lbC4NCg0KSSdsbCBhZGQgdG8gbmZzZC1maXhlcy4NCg0KDQo+IE5vdGUgdGhlIHZl
cnNpb24gb24gdGhpcyB0aHJlYWQgbWlzc2VzIHRoZSAybmQgdHlwby4NCg0KQWNrLg0KDQoNCi0t
DQpDaHVjayBMZXZlcg0KDQoNCg==

