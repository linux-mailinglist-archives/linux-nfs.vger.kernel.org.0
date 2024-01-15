Return-Path: <linux-nfs+bounces-1085-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2DD82DB31
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jan 2024 15:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D40F1C21AF0
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jan 2024 14:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E032417591;
	Mon, 15 Jan 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dmEZ9Ikh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bxgNaoii"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21AE17586;
	Mon, 15 Jan 2024 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40F9Dtif005110;
	Mon, 15 Jan 2024 14:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=yiasczbZxccF39D9hjFClAHrUgsE4TfZLI84Bou5K18=;
 b=dmEZ9Ikh2BrOhiqRXim55aBvtp4mWfB9PYk5cHLaAG8EIds76ITYj7nImtHDZKhXv/Ek
 S11ERTPjNwICw7gFXKNOO4IE5kfWJfHEzB8hrXThzntgtpdSqPureIiPczlyi4F3JSpt
 /dDCk02osZE1SX8rU4iFviuIBR8/7PLUUBYxuClPc6wXv1jx6URedzlxUrk7q/zDeRDn
 EsfHoMyklT7b4s+IpYQXBUt7qerpFzHgRZ4wqRHV44mkZVfXZJed83lsKZUggPMTPP4r
 tOu/kgm/fGt2E5ybfm7cupz+CznN4M/yMUnOnXMniDS/kkK3bcJWmmpgGZpIrFRakm3E ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkjjeagvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 14:23:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40FE26WK025679;
	Mon, 15 Jan 2024 14:23:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgy675sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 14:23:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5JzhELF0P84U6ob2d1UpJ4yMhSvhzumxG7CwSy66EiTJzKiAesONsSopetr7HW3x6aGn6nYxARid8wwLf72gwwcNQ9k18jEN9Uq2jVLUrvFz0YKf0/1TFKZK1mmmp2UMm4pMyEMlL/rVPiNxKPgHAvKD+qvsmv1elLJosVPflNrVmh++r3D1usSrZtnJKXa+OVgMJD9SBnFenTdizyLut1dEfON/U0OvcwJKc3FQLtiA59UOy4vlPbYqk8fYQQXZb7HDHGjSJ723LRGstDBhOUQ7n62RZ1kGLc4Qwu48OqsMC8BqbBb/YILe5PWE2+gerdsoO7jQV4fMaL6kjxxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiasczbZxccF39D9hjFClAHrUgsE4TfZLI84Bou5K18=;
 b=XmaA7+MB5IA01LtV6avO/q85KmaS3vr2JARSPfhZ6MdDmRUiIyG/tdl8gcJ9D5k8pOU4QpVSxXmNwOP7rtAJs/VBVY00OZNyBcH4j5rpOnKIbabq57y5IKuLPvFO79ju6uYoUCxkSifLIIvonP6XGOpK1ZmyxXl3cLeu6gYrOD6msVRm95YWuO+vpG2uE0aXq8dLqEtmNVnfd+qeBdiqC33QwqLEbVQ1ADCiaUdwZZlmngqht8GVWXwjgCUGLMdzN4e6otRD6i9mwV5kE6KruBPsLxbgI1jWlubLSMdiuTiZOpVpSgoxaD0hMH2iLvuljhJ4GH0AUXgMGlG6xuJadg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiasczbZxccF39D9hjFClAHrUgsE4TfZLI84Bou5K18=;
 b=bxgNaoiiUhZkKsEqic8uqn/zTaEMWmGyUxMRCE7d4Bu08zq0Pmuh9qObjFtinW8LpIogwc0gnzIBzrbsxcJ4LLduvyJirXadzf5r6u3aHNK6Ic1UNoQ6jNPRYh7LpnHX9tYyiMi7q+26Pu9ChYOLlqSHKgrcdroGi+Tmev+MKmM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5873.namprd10.prod.outlook.com (2603:10b6:303:19b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 14:23:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7602:61fe:ec7f:2d6f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7602:61fe:ec7f:2d6f%5]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 14:23:19 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Simon Horman <horms@kernel.org>, Zhipeng Lu <alexious@zju.edu.cn>
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
	<pabeni@redhat.com>, Simo Sorce <simo@redhat.com>,
        Steve Dickson
	<steved@redhat.com>, Kevin Coffman <kwc@citi.umich.edu>,
        Linux NFS Mailing
 List <linux-nfs@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]"
	<netdev@vger.kernel.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] SUNRPC: fix a memleak in gss_import_v2_context
Thread-Topic: [PATCH] [v2] SUNRPC: fix a memleak in gss_import_v2_context
Thread-Index: AQHaRTPnoXVylAI9zUS0n79WCePwLbDavBmAgAA2OYA=
Date: Mon, 15 Jan 2024 14:23:19 +0000
Message-ID: <35F4C7FB-3337-4894-8AA2-C1F4ADCD99C9@oracle.com>
References: <20240112084540.3729001-1-alexious@zju.edu.cn>
 <20240115110905.GR392144@kernel.org>
In-Reply-To: <20240115110905.GR392144@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW5PR10MB5873:EE_
x-ms-office365-filtering-correlation-id: bda383c4-fb43-4f74-6714-08dc15d585e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 SYSKMsFQrb7VcDGWGp/MBByVa0BmzDKwr+geFoH7Tgm0bSGXhn2rEjBTqzcqWeumYykEIpjo04dRD9Ae4PrUgE84jp/gzmcRH+DLlf70qrSUC0OMgGHF9J0AZaX9+zI9KI0rA1gBa/ykwjXK5oRVI4Z7HHewM7YjqWkUrLnXkv8YrY0xlxB1ckYLcE4O/uZXJCRdtOz9IlF1pw3qNDC5sYH79JMghENWn8w3FA8dpo8skxMk5TvhUeSQZDfYf0zpGyY68dQqZ6Jzbzuvfj0uJCNmjvtdsDykg6vAmPy8URtLvSQFgKrPfDTDMrWTnt1xC5OoJiwjkdUzSKaoOhBY76bHPYXTxbYQfenGxFMz/TmBAGUikBRFudT/EfeaVObC8TrK0xWpt1IASjtfy+SEcFjDLSYgqyZ35G2d0zX/WFEeXDpz+59kCc69+QwsEVoYU7jfQRQRZ8rn9fJps4UBouL6601gHFVTRuMj+4tWuJJ5D1mnAvpppVPSZe154eGIOUXMEj5IDuaG1CLwIF8dQJq8Fb1koOmH7Ly+FUHaHZYLvmqRsLUeDJDd7ZJ69zhyn1sSTTLGRNqNHMUvvPyvj4ImbcX+22yRtTX0Vw5YpmCWFqZbsr1bCCQuIw0/ivBEGF2q16/5e++PjeX6e2acng==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(36756003)(33656002)(38070700009)(8676002)(8936002)(4326008)(5660300002)(71200400001)(2616005)(26005)(38100700002)(122000001)(66946007)(76116006)(66476007)(66446008)(66556008)(64756008)(54906003)(316002)(110136005)(91956017)(2906002)(41300700001)(6486002)(7416002)(6512007)(6506007)(53546011)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aTBCdFZEV081MGR5MW5xa2pDNEFBYldub1hUNEpYUlpuMnM5TXpnVldTVU5Y?=
 =?utf-8?B?Ylhnd3BvUUdzcjYxYWdwa1oxdmxKR1cxVjkzL0dtSFh1RGp6bW9iQWV2dVZm?=
 =?utf-8?B?QWQ3eFZJVTVsYWxnN1YxNXFqdjcxNnMzLzR6MWMzNE1PM1VWakpYWHlWbzAw?=
 =?utf-8?B?V3RCOGxtNWxwbXVESnlsVUJpOEhTZjc1QjFJZmxTVE1VTTVsUFNHZzVSSC9u?=
 =?utf-8?B?UmZmd0VPdVYwY2FpakMwOUFMckpPSC9jaUkzRkhUZ0RKeWo5SVd0T0FkUTNN?=
 =?utf-8?B?OWJwamtrWnQ0TmNzRWpMcnpXQXU1cGhhZzJOa1hSSkFqdXBPYkxhdkRqUlpQ?=
 =?utf-8?B?ZjhXSHNOUkp3UzcyTnl4WmVoaTNkK2RESitON0h4UUp2WllPcU1ZNE1OTE53?=
 =?utf-8?B?eGx6SWFsV1dVM3NNTU9ScFlCbjZFbjhmaE9Mek82OHEreHVMMkRDUGs0ZEFi?=
 =?utf-8?B?bUQ5VWtQVklOY1ZzTzI3MUZPNVM1OWZWWFk1N0E1TEVmRmRxZlRDWGNkRmZV?=
 =?utf-8?B?YXo0UmhzdnRsOHhIOVZ1QUdNMUtMZWZTSGtJRUpWQWZ1R0phOVpDZklzZzIy?=
 =?utf-8?B?VHlwOUtBdzJVVWZ4Qk1vYjVhYlNKSUhtYXNZWjUyY1NCYm9nN3pqV2JwdDVT?=
 =?utf-8?B?Z1dnTXRWSzlUOURLc0Rrb0dsczJGU293N2l0dlJNV08xQTlBMXpvdmxSRDFk?=
 =?utf-8?B?TDNYdHJ6eWdBTEhnd1MvVUhlUi9JaGtJY3RDVVNmUER5SEtQdGdWUGk2eHk1?=
 =?utf-8?B?cnBLSHlvcmk0TFdqSHVIbStiYUtpOWQ3dEtHNExiVlY4dHNnbW51eFpXMGdV?=
 =?utf-8?B?VDYzaUlIbmxzL3hzeGs2SEN4UjkvTFlROWdmZ0g4ZTRsblVWWWQwdVhDRGw4?=
 =?utf-8?B?b2diamlreTIyTDVQOHdqVk1jZHRrdXEvTkV1OWxQZkJEcDNBU3lQMzU0Tkor?=
 =?utf-8?B?ay9jTzFOQ3ZVcFVyQkIwR1JFdDgvT1RmNmd3dFV1ZFBSR0QvVnptUmhhbDRv?=
 =?utf-8?B?Q2wrRTlZbkl3MWlLcHhvVFlvTFdLL3pseVhmUWlFbmtWTitHT2I5bHg2U3A5?=
 =?utf-8?B?c00yOU5vYW9DWXRnckJFTmp3ZlZGY0h3ZXJsd1lFdFNNbHRhUzU4bzVZUUJ6?=
 =?utf-8?B?QWovOW1rRUljSXhENDVQS3RybEgxby9NTyt6M1ZxT1llRXJ5K0NXRGtDOEFv?=
 =?utf-8?B?L1dtYktSd2NNSXpUSDNFeUV0bVU5bFU1WHB4aXlHbzBVTGwwMHJjNDNWNGo5?=
 =?utf-8?B?QU40YkVESzd6VEN2NTV2QnBHZUdGZEIvZEFYYWdHWWY2NisvMm82OVdlcjZB?=
 =?utf-8?B?T3hwcEhMNDVsUmpyUFlUNXVwaDVrOWhvU2xnZTB3NFQ5Sm1ROWRHMWJjRHBp?=
 =?utf-8?B?S1ZXNVRLYWMwWlJRK0hzWkMyZ0VpUmp6QVRoblVHMVcxNmVrM1VSQUdQZXV3?=
 =?utf-8?B?MGk2R0t1NzFqbzYxbVdDSVhVRjlJR2tOR1NCd1JSZjhiYzhnMlhkRGtxSXdY?=
 =?utf-8?B?YndWOHJldzVma2FvTGpiWjFUMXR6ZlY1WHcrdEtqYytMZWlHbGJFSXZpSno0?=
 =?utf-8?B?WFZzQnI1OGF6UUduRTlnSnlrRkREQnIzVkVzeHRKenpZNUVyYkZRQlhvek4y?=
 =?utf-8?B?UDYzSFR3ZFJFMFJvcEtGMkl0ak85d09ya2Z5MGJKWmRmM1dRSU43cEh0Vzh1?=
 =?utf-8?B?Y1NpbVZkNkYxOWZEbEZDeTlVWnMyWEw0NGRDcXFsRHJURFNRL0JHQWtxbG05?=
 =?utf-8?B?NmRsVVYzQVdzS0NXTVB3aUw1K3dFTEFpWDdCb3I0cUQ2TndXaHlyaFFkU2R2?=
 =?utf-8?B?YmNySHFaZiszNjNsT1RucVEyclBIb3lxcEdja2x1dm8veExNOVhzVWYzK2xG?=
 =?utf-8?B?b1puNVNxcU81N21DUTlETnpENkF4MnZ2MTdHMEhRcnB3OExwMzRreU9IY2hp?=
 =?utf-8?B?cmpmVVBoWHpvWUVScldBUFFSZ2hONHZtQWUyZVFrams0d2lqTERUNU9oUExR?=
 =?utf-8?B?V2JSVlhzSUhRUjRzVEdHazJXdHNaSUxtTFpOUHQrWk5CbjQ1MUF4VDRUajcx?=
 =?utf-8?B?VkFWSVhjYXJ5OXBCK3ZpV2x5SE1mbDJsbTdWRDJoS3BkL01WYXZnNDhMRis0?=
 =?utf-8?B?aUt3bGpNSFp3WDBXNFNIa0VlOEE5dnY5cDZRU25RbzYvemhvb2dWOStQWU9O?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2383F287749F0048B62F1318AF6276C9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	crpRrZ4oUjWSLVgyJLvxFxQ/aKM4FjPpr56bJqZuH07GUUTpSY42aG6Z+VJQoHPENoTCoA2T0pLoKlkPMJyZxg/ibT+hKL11yKq0diY7RbxHhQiHYqVij613zEuGxITYi3o6XhwYBI4k47jdbLe709bgZYfalud2NzfboSKlaqUerL6w+BlRhoXUf/iPNvbtFFoC5x5VotzU9rQJveaYfwvU+g/rAWPEEiTJGf7bKl0fiHZIN0bbyKik2t5b8/PmpkgivbYglF7+a9naOAaojKXITPT/uwT44bud8zZeO05VTfWvD6FFxm1RQUNUC2lJ0komDmL+flWlRnAQIrDsmEHRTPi3VWGdRhjTxBtW8wkzhwK66opSVHqSwpQyp7XZSPO7nxEdNGDLhZh6zqw8Mi08nyCB2RKET5VJyv3jamu/xBpqTtv3PdH0aM8SZpgQfnA8Tl7nWa4m2rCXlLaJvXn+fnxuZQ6CkHh9cdlC+d+osKg+uWGxpXjCMY4zHoiRlBxEFr0fIgvQy4ZNs2EEa/N015bX8+wtILbxX5G1hZReL3o47Q3h6SFEOvpmAsQMaGIdzjI9TOaBcvPMAw5WWf9vLtwuxAJP3to3oCuF8HY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda383c4-fb43-4f74-6714-08dc15d585e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 14:23:19.8278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eQdvYBd7OSQ2RimAAYkgp9HqBluxWLA6xPQpnjFeITZ0GnLHBejyfWXWbN5aunAlvpAVDg7wBXZtjV+HKA+fPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5873
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_09,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=936 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401150105
X-Proofpoint-ORIG-GUID: QkOo_uWoV7wzSqf7k9t7KoYqt8-Nrq1U
X-Proofpoint-GUID: QkOo_uWoV7wzSqf7k9t7KoYqt8-Nrq1U

DQoNCj4gT24gSmFuIDE1LCAyMDI0LCBhdCA2OjA54oCvQU0sIFNpbW9uIEhvcm1hbiA8aG9ybXNA
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIEphbiAxMiwgMjAyNCBhdCAwNDo0NToz
OFBNICswODAwLCBaaGlwZW5nIEx1IHdyb3RlOg0KPj4gVGhlIGN0eC0+bWVjaF91c2VkLmRhdGEg
YWxsb2NhdGVkIGJ5IGttZW1kdXAgaXMgbm90IGZyZWVkIGluIG5laXRoZXINCj4+IGdzc19pbXBv
cnRfdjJfY29udGV4dCBub3IgaXQgb25seSBjYWxsZXIgcmFkZW9uX2RyaXZlcl9vcGVuX2ttcy4N
Cj4gDQo+IFNob3VsZCByYWRlb25fZHJpdmVyX29wZW5fa21zIGJlIGdzc19rcmI1X2ltcG9ydF9z
ZWNfY29udGV4dD8NCj4gDQo+IEFsc28sIHBlcmhhcHMgaXQgaXMgdXNlZnVsIHRvIHdyaXRlIHNv
bWV0aGluZyBsaWtlIHRoaXM6DQo+IA0KPiAuLi4gZ3NzX2tyYjVfaW1wb3J0X3NlY19jb250ZXh0
LCB3aGljaCBmcmVlcyBjdHggb24gZXJyb3IuDQoNCklmIFpoaXBlbmcgYWdyZWVzIHRvIHRoaXMg
c3VnZ2VzdGlvbiwgSSBjYW4gY2hhbmdlIHRoZQ0KcGF0Y2ggZGVzY3JpcHRpb24gaW4gbXkgdHJl
ZS4gQSB2MyBpcyBub3QgbmVjZXNzYXJ5Lg0KDQoNCj4+IFRodXMsIHRoaXMgcGF0Y2ggcmVmb3Jt
IHRoZSBsYXN0IGNhbGwgb2YgZ3NzX2ltcG9ydF92Ml9jb250ZXh0IHRvIHRoZQ0KPj4gZ3NzX2ty
YjVfaW1wb3J0X2N0eF92MiwgcHJldmVudGluZyB0aGUgbWVtbGVhayB3aGlsZSBrZWVwcGluZyB0
aGUgcmV0dXJuDQo+PiBmb3JtYXRpb24uDQo+PiANCj4+IEZpeGVzOiA0N2Q4NDgwNzc2MjkgKCJn
c3Nfa3JiNTogaGFuZGxlIG5ldyBjb250ZXh0IGZvcm1hdCBmcm9tIGdzc2QiKQ0KPj4gU2lnbmVk
LW9mZi1ieTogWmhpcGVuZyBMdSA8YWxleGlvdXNAemp1LmVkdS5jbj4NCj4gDQo+IEhpIFpoaXBl
bmcgTHUsDQo+IA0KPiBPdGhlciB0aGFuIHRoZSBjb21tZW50IGFib3ZlLCBJIGFncmVlIHdpdGgg
eW91ciBhbmFseXNpcy4NCj4gQW5kIHRoYXQgYWx0aG91Z2ggdGhlIHByb2JsZW0gaGFzIGNoYW5n
ZWQgZm9ybSBzbGlnaHRseSwNCj4gaXQgd2FzIG9yaWdpbmFsbHkgaW50cm9kdWNlZCBieSB0aGUg
Y2l0ZWQgY29tbWl0Lg0KPiBJIGFsc28gYWdyZWUgdGhhdCB5b3VyIGZpeC4NCj4gDQo+IC4uLg0K
DQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

