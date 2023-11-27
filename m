Return-Path: <linux-nfs+bounces-101-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B447FA6E0
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 17:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0361A1C2094F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 16:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AF82CCB2;
	Mon, 27 Nov 2023 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TsS7jyuf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IDw2OVaF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962EB9B
	for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 08:51:13 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARFJ5hv020243;
	Mon, 27 Nov 2023 16:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=5Innxr1JvLasoEu3JVe1RLg5SAT/xQgC94qRINLIeik=;
 b=TsS7jyufFNC1b3vTLL3RU+8serelS8Veb6ZvcggwLhNVdnGeOHPXpR4qQ2Zu7Hf5mKd9
 Jx7lAGWv1OhaHC4AyAkbqR1hGN4aU+UzAjNQHb3Q7aivM456kahtrll0j0QNoEeied9F
 denl6824cDK6iuOkGi+Ig+52AuQOpyQVYogRkn9ggjOaey/hxDF20rvozGD1eAmMAxlB
 HRnUn/tFIeqp1JHicirVpaSQGeJ9tGR9Q9XRcX6pjT1QonQDa4PYtriqo1esSNceB2IZ
 50HE8DmWJTMLAz3tKpDS2L/znoqTBktp7KLR5hRLtDvxCVithHdVCon7NwJ4uCPPj5WT 9Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7beug8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 16:50:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARG7Fdu013344;
	Mon, 27 Nov 2023 16:50:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cbagta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 16:50:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPLNz7fNLjJ5c1A5UcESdMm9hoQLI/vKQzuxz0tsNQmiEmxO7qQiMFN+B68CuhNzqLeKaEkhSS+zGDRgAiwaTxESC1PtjFLC0gGTlG/IBiw4VmkfFqRSwF4YG6A1JGCIam4lcbS0WpVN5gkCo9PV4fw5pEL7Okn22zNXIc25cGS0CC4ENiiNP3RfMJMwVjGCE4mPM7dMYA8d25Hb5fLy6dguZ7Ehn0QzikpAEFTtnCglEJR9Tie3vlckWqvkcdBfUUUJdFrgmEhG4YxJxG1cDwSoris9UCf36L5LQkl6vHRltOxM9TJTXxE4bGrglonIRUNNoHNv0z5KRuwKauOGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Innxr1JvLasoEu3JVe1RLg5SAT/xQgC94qRINLIeik=;
 b=f35ZdxKZRExwmeKtn8tyogBvj4RR610KNld1gG7ekW0UyG3dO/KNTffJeCzB4Jq2OzX1CPsQvZWIvN0JRqlTYy5fL7zh6JdealcYR4tbkhrpYAsExY4/LrvfW7DWzSsMAupr20b8D4JYhmPRnl2W7WtRWEPUsfqrElnvwoPA7xYAO5qqwqiIhhZKgi+6A5sGj6cQwK4Ao++qtdrd/c3DCoe/tQc/GxUfJ1VZ31hXECmU5cog+uKGwtfnNbO74sd5UFTinxv4G+LHntBq9+3qu2D5w7sz/683DFK8cDjyCT8iyD2bpr20B2iWPxu3QM0ih6EYl9p7ycrB4g9VSpqEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Innxr1JvLasoEu3JVe1RLg5SAT/xQgC94qRINLIeik=;
 b=IDw2OVaFQMQfDvSzxi+TQVj9h34CwouAfiE0eLZY7a2saUzVF3qsUGI62D0cfm1K9BDM1G3tdr58jr/sEWcmr4gw5MuBjsILWuoorTBaiwFw0+nyTvmxOV5EYshwDLWC9+dOfowmqpJCRcDSZ4yWMimjffHVXVXEODcR8+OxrHI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB7048.namprd10.prod.outlook.com (2603:10b6:806:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 16:50:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 16:50:56 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, Tao Lyu <tao.lyu@epfl.ch>
CC: Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: Question about O_APPEND | O_DIRECT
Thread-Topic: Question about O_APPEND | O_DIRECT
Thread-Index: AQHaHjflhODFfyeMXUSkxSGiPt/2HLCLuRkAgAKTcNCAABbagIAAA+kA
Date: Mon, 27 Nov 2023 16:50:56 +0000
Message-ID: <7E2914D2-B9AB-4280-9A44-875DA8B58328@oracle.com>
References: <c609e5f9df75438dbfe3810859935d58@epfl.ch>
 <2d948b43fa625952e50589e4bedf9551df7ee112.camel@hammerspace.com>
 <7d2d17e4d3904d29b75fadcfd916b2a3@epfl.ch> <ZWTFn0/FtJ5WuQGc@infradead.org>
In-Reply-To: <ZWTFn0/FtJ5WuQGc@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB7048:EE_
x-ms-office365-filtering-correlation-id: fc3e0de8-0dae-4493-33d2-08dbef690684
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 WSf5LLUK+J7l35WNuaLp4QL8i6OXvxI4svvLL/MhLKmbPKfjYSCG3PakYC7aF+/uHbb+E3p3Ou6sPAYDsb9ZVe4/myW2AJhdilDGdlrc8ossLwlLeA9h08Akxctrc7Bo9WtXhuRWR/O6YEK3RuN8EhjeWgEycunCfzj/xop5TMbmilf+04Lxpcy2mVIf95NjUumDrVYxXDxShHw6uimVG8NY0W/m5UAeUIaJLZ3TuESby2jN0Fzof/lBIcbYRC8I0h1jdpdjqabTn783hMcFiWVm8ty2MsSV57yaVHNT6jPhHGN1M9Q+DOJ0ITNsdmcIAlMezQkPzQAJ52k2tLrkRDtPqaZ9AAiuun6Uitf7BIwE1356Vsk9nzDZel7ZMyh+laV5ocy+S8EUaARsfi8aBJA3rqsR++Bq9VTkeAQE3IqUNheX/fuOkfduJHyhK9/vVbzYfdmMlrhh9SkdiPi+mmpjQ22lUiC4zH4hDmsHmkse6ciXBEC2+aOeAakt/H03vU/MlpbOqr3YjjW9Hb/yP+cEl/thPotJtIGkZ3cn1ah5Lxcjt0kb5D89KJanzr25o/UL15+lBUhJyOAdmcQYy7g+cGVm8bJ+/tZ7zSAkfkcF9ok3AjnobkgP61KAi9hnkK9am6gYF3i/RoXNDddIcQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(136003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(41300700001)(36756003)(86362001)(33656002)(38070700009)(122000001)(83380400001)(5660300002)(26005)(2616005)(2906002)(6512007)(53546011)(6506007)(71200400001)(8676002)(4326008)(8936002)(478600001)(6486002)(66446008)(64756008)(54906003)(66946007)(76116006)(110136005)(91956017)(66476007)(66556008)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YVFZbGVwdlZuWWVnRTNRSWNMdzRuSDZORVdNNEwyaHFSYWlGZmpDK010aXhn?=
 =?utf-8?B?ZjdLeEZBVE5OVXNQd2haRXFiOU8rRkhlL0d5MkJOajkrL3FPNFczN1JtMDFX?=
 =?utf-8?B?cnhCc1dTc01pd2lBSDUyVFh2U29yRkdPenJ1b2pVTldFTkU1NUIreitXb2N0?=
 =?utf-8?B?VStsSkVkQ2xEaGpqOThHQzRCUnoxdW9sUmVmcHhGTlNLTnNYWjVEckthODdm?=
 =?utf-8?B?KzhoSEhSc2h0eWt6MVBXbnFFdCs1RG1PYzJ5Y2NMNExqcEt6QWNUbjBucFhr?=
 =?utf-8?B?cTlwSFppTm1kRzZTVUNHSVFNSW5TeHpTT1B1SU8rajhmTXhVU05udy9GWmFU?=
 =?utf-8?B?Sk1XNk9yOGp5TFhvdVAxblIxSXVtSUVldGlCWUpvQkJHUlJRNkxFNGFWejVT?=
 =?utf-8?B?cy95NVVuOXpLUEtLditOUmU1cHZ2Z1lTZ1pMc1Q2U3dqeXMwR05XMStIYU1I?=
 =?utf-8?B?ejRVRXVvTTd0M0k0LytCTkgxOXU0VTBLcENKejRrR3RYSmVmZ3pqMlhNVk1j?=
 =?utf-8?B?cmxTcGRBako2UElSVHJTMzFtTUMrbkwxSHNId1BNNjlPNWhOVmI5N2JKQ3pk?=
 =?utf-8?B?Z2lBUHJIaC9NMHlVRFJlSEJ1bnB1aWRaaE1USTIvckJuWHFuOUMrVkt5Wml5?=
 =?utf-8?B?THdOS1llTXNPQk00aTV3NkFJemxiN040cXYyMVpOamtRU3FYWEljbG5BcW5u?=
 =?utf-8?B?bVRzTVJjYkFtMEhWNldMckdwRlNSWDkwWngxbFRIV3p1UGJBSC9sSmxhOUpJ?=
 =?utf-8?B?R1NQWVN3bUhQSFVoeEoxZ01qUmlyRVlmOG5jZmN5Q0JMRFJSSWw4bDZtWXBY?=
 =?utf-8?B?eGZHWmlnTVJEb3VFRGtoajJaaFJUU3ZRTVI5R3pucDNFbm9LcE9PS2lqMjl1?=
 =?utf-8?B?OXV4eEhKanE1OGo4cGVuWkRVK0dYQVVsb3VDbVU1RitxM1pOaENaMWtnTnhP?=
 =?utf-8?B?UjRTL28yT1JkaWdvcXJBbXlxaHBCY1lmbjNBcEJmdjBYWFcxcCtmRkREQlYy?=
 =?utf-8?B?bXprd3hma3ZKQnRHdERYNE9BUXVBV1ArZlJJV2o2SFkyTi81eEFseXhVWU9p?=
 =?utf-8?B?SU15REppa2twdVVoR1BJeVlHRzVMWXlUbGxTa2srWHlnNnJ0OVMvMWU0blAw?=
 =?utf-8?B?dTBJVUltajFhUnE2d3RvWUQ1YjRKaUJvVTRJZFJrR1liMjdXbzlJVnBvaXVt?=
 =?utf-8?B?ZmxuRVhHVGkyLzNwdnVHNmsyWTZaYUEyNkFJNUZLTE9SSlV6NVhHV2Q3Y25v?=
 =?utf-8?B?UGhITzV2TTBNTVVEaW9DU0hUdTZVOTQ1dkM4N1B3SkY2QWJSd0hrdUoxbFRY?=
 =?utf-8?B?Tjk5YjFVanVhZzRjZFlLa01YU1MxQk82cUNDYWVCcHE1ZTRLci92eUJXMDgw?=
 =?utf-8?B?RmJhWTZyTlp1Z2RNSjdIc0FRbmVjK1cwdE1vR3A3c2dRWlYzd2MxSi9sMTNp?=
 =?utf-8?B?d0VKTnFWMmRrVlJLYlRQd0dWa1E3Y1ByV05aNXErVXlzNllnb1hKZit3K1Ur?=
 =?utf-8?B?RGJvT2VzTTg1bXcyQ3lSUUJnY1VoaGtJeUk4WkhmSllQVTA2elhBZXJoZktn?=
 =?utf-8?B?cVBNSCtkenE4bGVKdzh6YjFvUjBEcjJpSitaTmwwMmpLSTJYUlpWQ0N0bEEw?=
 =?utf-8?B?YStnVTJ0SFdTS0FPZEk1QlZaYzFjVDdCZ01EeGNVVy9iWU5GYVRRY1g0RjBF?=
 =?utf-8?B?dWo4UkJUYm5YUVBJaWYyRng0a2UydU90ODVudUNzcnJFUlFQWFFGVWtVUVlK?=
 =?utf-8?B?ZldNdVMwc0JIbXNPV1VWSWhXclIzc2VqdnYweGRaY0l2c3VEZGFFR3R6QzFs?=
 =?utf-8?B?QmcxbWZ1OFZpcWhPMmdmMFYzY1N3ZVh1b3hYN2dkR0EwNXdCODlNaGtBc1dh?=
 =?utf-8?B?Y1p1VVVtRWFsdFRHWW5FSGdnMFdudFRsTE5mYmxUV0p2OERmOHFmVDZXY2dl?=
 =?utf-8?B?bWRYZ20zZ3VuU0E4b1gzdVZ3YXVEdE9sWWhROEo4dDM5S2xrVlo4cXhnYnJi?=
 =?utf-8?B?MlNqdEVqL3QxRkxXbXZiNEl6cXdabjNXd0dzNU5xREJaL2NOSktsRVRJSXJw?=
 =?utf-8?B?YjY2U0hwTmNDOFVXQmVjNXhKYlN5NTBxeFhVNmIwUThSaitNRC9uRmIyVEs0?=
 =?utf-8?B?MFkrV1prYjU1K3A2YTNXUGtUQTRPUGp4YmZjZGY2MjYwZWdLUzhVREhURGpi?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <229E42A6CA9D5A49A00A871E2FE3EF28@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UrJW616BKKf9Edaf1ieQokkw47Rr1GUZsHOeLWHXDp2IO2zlW6iy5ArIS6jNf0b8FdPpIVW/GCA6E0rLim3C6NpPe5Vs5OqNkCedsHMi5bbFSUFbIOD1BkmMTaIEPROQDvSHosw2xf2IskDKh/EUoJXHbBrv3yIS174m4RtSOy3tvGvOAs2jjZ31JGlLWV0NiN8llgKwdGRzZgecIin7BgzODZ4CEkWbJR6/OQvsImfbje0hL5y8TzKZfzbC1Jg+/zGzIamqRXw1x2JexJ28cjKcliSGr8C/3VSGUQE6ty0nazNiHjg+CFQAF1kOxhDk1e6uNyxHzoob9+bKVZ4Bo0weFgI+5DGoet81dozGfGqCOWMRnmDUfeQ3MTXM/vf5qThGEz/5d2oefEw78ZoZCFu6wyJl26kzNNtnfin1PSghV0TvkbWuvZdAYVyyi+DN4Est1QlVfAC3banldZ64+SN8/6lmHFmDhYGOiHi7zhbGaooekiSHRMFkoF6pvFv+0X9qNRdUEX2Tbus4NhNVc6RmGGKHeulJDCdLFZ4NGec3yJ83jxotlh9Xk7m12sDqDC39KejIXPhAJ5V3B/HEO/KfD7at1J1n6iiw+TDxjJ9piQBH7nPC5kSRSPItsn/r6YBAK+rkFBB2/0eASgw6eqPzUGa3g+nprJsBSQ8ghJjuuTvWsmusENNPzdYPKPXSx1W5v8tl1PZtwLSTtUd5bvJKfkxP2PzQ0jhfaAKpZVSJCU5hop1mwxUnNqBRZ4OipjlfX05/zaz9VSe9B6jlovMiyWjpGv3MGuW79xgQs2RNAf6l/mpSyhOzh1xRqAgCZLTl0t0wNscg2iApbQG3PL4Y8WA7sb+6gljc0XxWwlg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3e0de8-0dae-4493-33d2-08dbef690684
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 16:50:56.2974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CoML2SqUDGouE2BE/JJgKqzkB3PyR+2krmEE330MhJc/kLs9MvM0xugew9hNzzouyF81Gxa/miq/NrKKYHQU7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_15,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=607
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311270116
X-Proofpoint-ORIG-GUID: fbyAI6-ggKonasi8nDix461En3ZdKhFP
X-Proofpoint-GUID: fbyAI6-ggKonasi8nDix461En3ZdKhFP

DQo+IE9uIE5vdiAyNywgMjAyMywgYXQgMTE6MzbigK9BTSwgQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBpbmZyYWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgTm92IDI3LCAyMDIzIGF0IDAz
OjI4OjE2UE0gKzAwMDAsIFRhbyBMeXUgd3JvdGU6DQo+PiANCj4+IE9fQVBQRU5EIHwgT19ESVJF
Q1QgY2FuIGJlIHVzZWQgdG8gYnlwYXNzIHRoZSBjbGllbnQgY2FjaGUgZm9yIG11bHRpcGxlIHRo
cmVhZHMgd3JpdGluZyBkYXRhIHdpdGhvdXQgY2FyaW5nIG9mIHRoZSBvcmRlcnMgKGUuZy4sIGxv
Z3MpLg0KPj4gDQo+PiBZZXMsIHRvIHN1cHBvcnQgT19BUFBFTkQgfCBPX0RJUkVDVCwgTkZTIG11
c3QgZmlyc3Qgc3VwcG9ydCBBUFBFTkQuDQo+PiBCdXQgdGhlIGtleSBwb2ludCBpcyB0aGF0IGxv
b2tzIGxpa2UgTkZTIGhhcyBzdXBwb3J0ZWQgT19BUFBFTkQgYWxyZWFkeS4NCj4+IEkgY2FuIHN1
Y2Nlc3NmdWxseSBvcGVuIGEgZmlsZSB3aXRoICJPX1JEV1J8T19BUFBFTkQiLg0KPj4gDQo+PiBN
eSBjb25mdXNpb24gaXMgd2h5IE5GUyBzdXBwb3J0cyBPX1JEV1IgYW5kIE9fQVBQRU5EIGluZGl2
aWR1YWxseSBidXQgZG9lcyBub3Qgc3VwcG9ydCB0aGlzIGNvbWJpbmF0aW9uLg0KDQpPX0RJUkVD
VCBpcyBzdXBwb3NlZCB0byBub3QgZGVwZW5kIG9uIGFueSBjYWNoZWQgaW5mb3JtYXRpb24sDQpp
bmNsdWRpbmcgdGhlIGZpbGUgc2l6ZSwgd2hpY2ggdGhlIGNsaWVudCBuZWVkcyB0byBrbm93IHRv
DQpmb3JtIGFuIE5GUyBXUklURSB3aXRoIHRoZSBjb3JyZWN0IG9mZnNldCB0byBlbnN1cmUgaXQg
aXMgYW4NCmFwcGVuZGluZyB3cml0ZS4NCg0KRmlsZSBzaXplcyBhcmUgbWFuYWdlZCBvbiB0aGUg
c2VydmVyLCBzbyB0aGUgc2VydmVyIG5lZWRzIHRvDQprbm93IHRoYXQgdGhlIGNsaWVudCBpcyBy
ZXF1ZXN0aW5nIGFuIGFwcGVuZGluZyB3cml0ZSBzbyBpdA0Ka25vd3Mgd2hlcmUgdG8gcHV0IHRo
ZSBwYXlsb2FkLg0KDQoNCj4gV2VsbCwgaXQgZG9lcyBzdXBwb3J0IE9fUkRXUnxPX0FQUEVORCwg
anVzdCBub3Qgd2l0aCBPX0RJUkVDVD8NCj4gDQo+IEJ0dywgSSB0aGluayBhbiBBUFBFTkQgb3Bl
cmF0aW9uIGluIE5GUyB3b3VsZCBiZSBhIHZlcnkgZ29vZCBpZGVhLCBhbmQNCj4gSSdkIGxvdmUg
dG8gd29yayB3aXRoIGludGVyZXN0ZWQgcGFydGllcyBpbiB0aGUgSUVURiBvbiBpdC4NCg0KWW91
IGNhbiB3cml0ZSBhbmQgc3VibWl0IGEgcGVyc29uYWwgZHJhZnQgdGhhdCBkZXNjcmliZXMgaXQ7
IGl0DQp3b3VsZG4ndCBuZWVkIHRvIGJlIG1vcmUgdGhhbiBhIGZldyBwYWdlcy4gVGhlIGhhcmQg
cGFydCBvZiB0aGF0DQp3b3VsZCBiZSBhY2N1bXVsYXRpbmcgdXNlIGNhc2UgZGVzY3JpcHRpb25z
Lg0KDQpJIHRoaW5rIHlvdSBjb3VsZCBjcmVhdGUgYSBwcm9vZiBvZiBjb25jZXB0IGJ5IGluY2x1
ZGluZyBhIFZFUklGWQ0Kb3BlcmF0aW9uIGluIGZyb250IG9mIHRoZSBXUklURSB0byBlbnN1cmUg
dGhlIFdSSVRFIG9jY3VycyBvbmx5DQppZiB0aGUgb2Zmc2V0IGFyZ3VtZW50IGluIHRoZSBXUklU
RSBhZ3JlZXMgd2l0aCB0aGUgZmlsZSdzIHNpemUNCm9uIHRoZSBzZXJ2ZXIuIElmIHRoZSBWRVJJ
RlkgZmFpbHMsIHRoZSBjbGllbnQgZ3JhYnMgdGhlIHVwZGF0ZWQNCmZpbGUgc2l6ZSBhbmQgdHJp
ZXMgYWdhaW4uDQoNCg0KPiBOb3QgdGhhdA0KPiB3ZSAoRGFtaWVuIHRvIGJlIHNwZWNpZmljKSBw
bGFuIHRvIGFkZCBzdXBwb3J0IHRvIExpbnV4IHRvIGFsc28gcmVwb3J0DQo+IHRoZSBhY3R1YWwg
b2Zmc2V0IGFuIE9fQVBQRU5EIHdyaXRlIHdyb3RlIHRvIHRocm91Z2ggaW9fdXJpbmcgYXMgd2UN
Cj4gaGF2ZSB2YXJpb3MgdXNlIGNhc2VzIGZvciBvdXQgb2YgcGxhY2Ugd3JpdGUgZGF0YSBzdG9y
ZXMgZm9yIHRoYXQuDQo+IEl0IHdvdWxkIGJlIGdyZWF0IHRvIGFsc28gc3VwcG9ydCB0aGF0IHBy
b2dyYW1taW5nIG1vZGVsIG92ZXIgTkZTLg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

