Return-Path: <linux-nfs+bounces-353-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4823D80640B
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 02:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96AE7B20F86
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 01:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76999A56;
	Wed,  6 Dec 2023 01:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B28QJz/i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xbhrovC4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06385196
	for <linux-nfs@vger.kernel.org>; Tue,  5 Dec 2023 17:24:36 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5NW1j3024963;
	Wed, 6 Dec 2023 01:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=pP4zw3Ie0sND1zv1XhxgPZjHsW6ex/q/Z81vZXUd7C0=;
 b=B28QJz/iTN3dVkCcLLGJc6NnVo+/L5UZgFoB3ejVTLbikDeBxI/ewIYFgqPSb3WLWpqL
 etdPS6ZPufbAhif8NmHPGla2Km9Kw5mCibhK3QB+tLf65lkn49e6/ERlUN3Uh50Na74A
 C9ndmKiE75Ep0ledeVhIjE4jnWnkILoSsRdetrqbhy84FT6xnQ3xjyG/2iPby7uGoUC+
 r31lyrKTlPxvDYS9eRsruKgrxRULdIcHUWTV4Udr9nPDVgrFBzzsPhCf/tTDBgXfzik1
 X+OiyUWUSQ/e3Q/RfD2Kw2/kUHuHo08GY1x3/Exumz8xWsZXU4aAsJsGFSzdTX+SiUG0 Hg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdmbg3ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Dec 2023 01:24:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B605lGs032860;
	Wed, 6 Dec 2023 01:24:26 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3utan8b2ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Dec 2023 01:24:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nod7NcIDvNsCncg4SB+yze/9wEF8RdJy97WtqSz3bidBVHVz+jQVHsmCikgGkRw6hP8vG3YdoAvpSpDt4EPAf3cVGuZKZvqRHC3fATRzydSYWnyQW0t7g9b91kWd0njSUWVybAKVuV5hTTSpreYTygtc+v3DfMGwkkOEdCUWbmun4ArbstF+pAwKkdqmmfyK54bwcI4tvBWVDiNGjhyCx5tme0By7ys5/ZVcVnEBzKppaT9ecpdqd609hCU5x73uzZwX10clXHR+2T8JYGOYmzyM4cucm7BKu0lkGtHixOvLAzGQhUEabjuZZQwMxIpZpjQUtNf3rmoR3TvRhHUa7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pP4zw3Ie0sND1zv1XhxgPZjHsW6ex/q/Z81vZXUd7C0=;
 b=avY9/mAvYsuR+3cdpw2c3vVus3sExiE1ft5fOnRQeglBSFShvOKUUSCX3Q/fs7jKvabd+zF1abM7znerkEKh/H/NanLUwEXBvagRSXlYNJc786fYgBsRPnqCce7yxMKLFX1/gRW9nJcyPM5eBmnwOhOjVly16ffK3BcR2yEKVCLh3wXCtFD2TKHN8hhNuPd3wntspXJ0HraMhnC1AEtnstg2Nbrex2hMX8rKdnL1BUR72AFxPHFWHnnKcmGmJObJ0yx8QS9Z+y4d1YX9Zh8IoyMvcPcWeQg9Nqmk2Dm25ibqpOIuk69VmihrtWdYHQPpA9lBXsBLCTmsgPz3zV0FvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP4zw3Ie0sND1zv1XhxgPZjHsW6ex/q/Z81vZXUd7C0=;
 b=xbhrovC4VuCi+k+5vZglmkgKwFh19rZPjPrs6z9rQE8YHILOhPM3XL7eHzhwytYUklBsnmkZL/VftdP8DWM51qTxKL41H+AhGup02m3G43XYBpDZue/4RLCI3YiURg0rSpgeP5tDTa5uglf2V3khCr5yMfH2R/RTqCGWMXwHX90=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5883.namprd10.prod.outlook.com (2603:10b6:303:18f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 01:24:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 01:24:24 +0000
Date: Tue, 5 Dec 2023 20:24:21 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <kolga@netapp.com>, Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: changes to struct rpc_gss_sec
Message-ID: <ZW/NRYp4IkWRORzo@tissot.1015granger.net>
References: <97AE695C-8F9F-4E9C-9460-427C284FBD32@oracle.com>
 <CAN-5tyHxvTevgM38q94W4e+rBzYu7tWqDHVMNcFQ5GT3uNArCw@mail.gmail.com>
 <6F0CCBAF-29E1-4720-A7DC-9F43751B56E7@oracle.com>
 <CAN-5tyGqSXyeu+LXWVu_J=A8CLW01c2wDKSfBeqFaaWLxnOAyw@mail.gmail.com>
 <ZWU/BvRX6BcnSQPj@tissot.1015granger.net>
 <CAN-5tyHi8app4K9aRj1paF=zG6PHLs3w8=C6iH4mZgduxvaAbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN-5tyHi8app4K9aRj1paF=zG6PHLs3w8=C6iH4mZgduxvaAbA@mail.gmail.com>
X-ClientProxiedBy: CH0PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:610:cd::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d875f4-38a3-4833-b77e-08dbf5fa1495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	S7LjNKShX6OjxU7CjxPgXGXKALzRKgz3nDckxmKQ8pGSWdYrGdsITFZKxCZYtaIDwZaQbe7DL1CPOBSO3D7sX1GhrkUHDqfPIFpdzuWTD8c4Ett5gdK7rW4aYfF9gm4Nhor8F5o3vTH3/fGzbt/ibhfGFj14LqvfbwGpBf9Fn/PlgccAcGevmudMDtng7Q1OQslRJPhyx8PR0H/O3q5R/Ww2Pvbhk1HyVmULRQfgaJhCX0c4EgXxxe9lLPNyhFov257CAEFqsLRkUQWFVbbiiKWgfmuEHCGzzBF+jr7ZDal0BRLQse5l+KD2aPv7N6QFZsqYEGlDpI+u6ldfCOrV8rwEspzh18WuEBg7Msa6nlbIB188rhwE8OHa6ymtc6bm4KB5vWOg3iBAy9CgiPmlK+c5u0Zs97JHOqwMG6afJzSMy31A4Eu04/AKW0UKTWBCOTRl1tGkNvvnolpTgOwbCyAU1ITZJmeZRTdMocTs/EtfI3p0iufQ/5tveAJu9ABFHMBYFBpjLNQKImwtPhz+stIfPiLUDP4yAvAaU3+IQ/1WZdwCnEoNdNST6TOHQHmU
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2906002)(5660300002)(6666004)(53546011)(9686003)(38100700002)(26005)(6506007)(6512007)(478600001)(66556008)(6486002)(66476007)(41300700001)(66946007)(54906003)(8676002)(44832011)(4326008)(8936002)(6916009)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eElQQzNVRDFlcGRtNWpaV1hDT0tOcFk1cTNqNzhUWWEvQ2l4dFdPeElKSVpk?=
 =?utf-8?B?UGxza0o3dHJwV2NxRU5tenJEVEtreHFKemkxbVIyQlFCYVpRdlFHZzQwUTJT?=
 =?utf-8?B?WGg0SkRHcjg3cVNsNlpGM0FOT3dhRTBhNy9rc3NteXVRNkJScEtVWE1XMkt6?=
 =?utf-8?B?ZHdhRGZzNkJlanRWclpoSVlOaTVoTkc0VUpOQy9yc3VDTTZENU1Xd2RXREpC?=
 =?utf-8?B?OVUxUy9SazlUV0VCSUVYQlFOTkZOeWoxa3k0SnBVR2cwWjJweTJndEJXcXZ4?=
 =?utf-8?B?UDNiNStGKzBWQkdYWDJyektaaXVSYlVaWktqUUdvZXpnblBWanJuM2xEdUlY?=
 =?utf-8?B?a3NWeTZBaEVjTkpIa25rZlplUEtRRjU5aFRNa29HeWpOaDAwaWg2WWpZMUE1?=
 =?utf-8?B?V1lDWjduZmxzUk9wd081SXUrRGtlRFZ1TCtxdGdFM3F1ekZUZjUrbG5lblBQ?=
 =?utf-8?B?WUNHNElDR2hnQmxzckZEM1NqNk5SeXo4clYveE4vYjJ0UHdPVFVhVUJKbHQ1?=
 =?utf-8?B?aWhHeVBmcm5vaEt0R3E5OUVjRlVxdjdWTjRTak1mWEZ1dXhVME5vYUxnT3ZV?=
 =?utf-8?B?NnJyT3RKcHJQcDN5VFR2VkhiMm1CUkd3M2ZyUHVYbDlIKzU1OVJSUEVrNzRQ?=
 =?utf-8?B?WVJwSGprWElmdHUyUTcyK3BnZmlFZ25sUFNvaHM3eW5ieWJYS0x3bHYvdkE2?=
 =?utf-8?B?ZUZvK0xyMmdpYTV0L2VGTVBVTXVCY29mQ3BFakUvcHJuVjV3KzgvaVlQcklh?=
 =?utf-8?B?azZVcjdhME92TVVHQWMwT2gyQXhISmVrRzg2U0sraHBwYXpxdzBEdDVKazJN?=
 =?utf-8?B?SFJMS0t5RnVHNC96SmxVUEd6S3hXY09IeUdOT2MrZDFwQ2tYNVpRVVBpRzMr?=
 =?utf-8?B?aCtieFU5RTBuOS8yZGZ1WEVoYzJKOEN1aUI3VTJ1ZEQrcnRwWXJlWEJMVER5?=
 =?utf-8?B?WGtUTnBxbDYyUTQ1dXRnSmMxSEtFalhkQkE0Q1hPUTM5TSs0TFRtWSs3UUVZ?=
 =?utf-8?B?ZU5EUUtmaS9PWHlDVUNDcmRYY2RnUHI3UGxwWW9wWE9GV09GUFNYZWVqVG1Y?=
 =?utf-8?B?bVptVTNFdW5DbVRuRWt0MEtQOFdaRkNFOVlrbTdOa0haRHRsQ2hYYkEveWVH?=
 =?utf-8?B?Ym5mMGpQZTlVNDJLN1l6V2ZETHk2UG53NStVY0tVb3NDNmRPKzFuMmJVdnpL?=
 =?utf-8?B?Q3VvdEw1Y2RYdWkyazVBTi96YjR0YTV4NnNZVitXVkxRdkxxQjJybTZ3d3cr?=
 =?utf-8?B?dFU4NVNpaTBTRzFFV1AxWTBPeFVmQTB4SGVzWnpNNDZ2WFc2cnNSYjhtRjUv?=
 =?utf-8?B?OHR5S3lqSXpONXNNTnVMU3JBeWU3b0VOcEh4alQzaWZmcTVXVC96MWVBczhK?=
 =?utf-8?B?ZWQ5Zk1tZUZhanI3bnRTelhLQVFDbGJQcnBBdjJXOER3V2JCZEE1V3RKa0ZD?=
 =?utf-8?B?V3gxa2gxVEV2cGNvTWVmaUk5bjIwT0l4WFNHdE12ZDlvcjAwWWZGaVBmS1E0?=
 =?utf-8?B?S2dwcXFzWHczNFh6RStnb0Z0YlppK3BDSnl2bFdSa0Q4bSsxalI4b2djRUhl?=
 =?utf-8?B?OFd6QmJSZkhhRkNBQjh6a25PNmJMNWs2R1l1WHdCMVJtQW1rYjRBVGlTcUhP?=
 =?utf-8?B?QTlJdGVQTzFYc3l3T1BCVXhUMDI2bU00bW1UMzdWU0pWdGxxNnczOWcrWTRS?=
 =?utf-8?B?U2N6WVdUR3AxNXB4ZUwxaElZNm1FSEZKajhwRUw5eU9UV2hVY1hGaCtQYVFX?=
 =?utf-8?B?cGJKaTg1aTUxdTE2OUd1NFUvdnVTbVlHUVB3TGNtNjF6UGtHKzltUXVIb0xi?=
 =?utf-8?B?ZG5tdThYYUVodS9ISzh2OElvY0h1cHFWT0ZEZmFDY1ZoRHIwbTlXc1BNdkRL?=
 =?utf-8?B?YldKRkYyNlJYSVFLNS9JZUJkSThVL2tnSDdEYlFyR0EzbG5LcE9PcGZERmZ0?=
 =?utf-8?B?SUtSbUFCOFBYTlVPM2w3TFZNU1ZreDVyVmI4QStTZHdKQmxUT3NFVEZsRDMw?=
 =?utf-8?B?V1pwQWxNaGF6QmlxZjd2aGpiUWozVUtjTHd4Vmo5ZUtML0k3eU5lQjlTZ2NC?=
 =?utf-8?B?S0UwRVdFY29hbysvU0E0YlpmWmNxczhkUkxueDNmWXQ3Z2oxN3RiTStaUDc3?=
 =?utf-8?B?cHFJMlNxNWdOSjU3NjhlTlZaZFVPWHhOdEIvSDNjamIzUTdUUmxpaDZUTHZZ?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TJxdLWLBeVs0ZHF85wW3r2Vc9xiAl06gl1JLNZj4vFvrcZJcxStGeXRoUCQlJlCghjfkpTyN92yW/IBU4mYB902qX6mhHJxo3hFjLWobu0kSPcDjZQTai172zCANWR5u3K94bW819BaIPOd+6OfAE8fngs11avr6LANqpYRp7jE+cKCwOFFCMy64THaBI+BK570c/TaupZQHoiHPdNWQI+w+7ow8POHupjHB32xihy7xMq0pVT33NTwQ0x7OY4C0toMNAs51vdSXRCyc66hAjHPYqY4O5X2PVpPM0+9cj/IriUYMD+9oRPji/z+lxUkv60Zm8WrlSQeI1EcYpbtX6fWBJ/vTMkxLPUJuSiWRCUAarX2ijQKy5xrn+FvBA3MhFK8Qcz5AmfOUG/4UwKyIiUHUSq31rUCquJxmJar4trWImpOa8tf/zm5RVvU1zCxvGGpIDfCPbUUpf0nICKBu6vwKgidmvEKD7CX55nRI/b3F93jUjZtiupqxdxJQx4+xJ/oInb4NLR8cAVDHboPqql3m/J49WcVVynK5dceinGXXViqlQJXS9mOVc5OPGtuMQjmE2BoNcUFOVnOGpp38CX5lFsC/qa8GeYqwGXQLlA4hP+B0P0I4bO1VVCHNcFyOC1JOGc2wXaP7ElL6Q9O9uX2nZiqQK27fuG40G8fHUD5QPzAbHp5eA0fL2m1zhIGcvltbcCCJ/9skmCZqXPNRE50fezaOVLHb2OVU/yjN5Vo3yFDEAXI+Aj8WNlWqQ1YbgHDGx7pCZhAip0BwwqmXitfUoGwQrgYRHCIKfz1BNvXWjyu4qJUkGhZ4cU32hn0Z3zC0+2eS9augEsEnnQ95fd8gok4/cC+Da9M4DxxhCz0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d875f4-38a3-4833-b77e-08dbf5fa1495
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 01:24:24.1174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXKjf5ZTTMRpOIrfkMk5ZB7LSkBLSyexKCwZWqf9o6qseO+JhNxaxU3AEbapr5B8YZb0j1wl8jaQtRR2Al4vcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5883
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_01,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060010
X-Proofpoint-ORIG-GUID: og7yE7kWZzlv6xq30wsZFS0g70n7W2WT
X-Proofpoint-GUID: og7yE7kWZzlv6xq30wsZFS0g70n7W2WT

On Tue, Dec 05, 2023 at 03:43:16PM -0500, Olga Kornievskaia wrote:
> On Mon, Nov 27, 2023 at 8:15 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> > On Mon, Nov 27, 2023 at 11:42:08AM -1000, Olga Kornievskaia wrote:
> > > Hi Chuck,
> > >
> > > Given that rpc_gss_secreate() was written by you I hope you dont mind
> > > questions. I believe gssd can't use the new api because it is
> > > insufficient. Specifically, authgss_create_default() takes in a
> > > structure which is populated with the correct (kerberos) credential we
> > > need to be using for the gss context establishment.
> > > rpc_gss_seccreate() sets the sec.cred = GSS_C_NO_CREDENTIAL. If you
> > > believe I'm incorrect in my assessment that rpc_gss_secreate please
> > > let me know.
> >
> > Caller can pass its preferred credential in via the *req parameter
> > (parameter 6). Then rpc_gss_seccreate(3t) does this:
> >
> > 846         if (req) {
> > 847                 sec.req_flags = req->req_flags;
> > 848                 gd->time_req = req->time_req;
> > 849                 sec.cred = req->my_cred;
> > 850                 gd->icb = req->input_channel_bindings;
> > 851         }
> >
> > Wouldn't that work?
> 
> Actually this does not work. However, this does:
>         if (req) {
>                 sec.req_flags = req->req_flags;
>                 gd->time_req = req->time_req;
>                 gd->sec.cred = req->my_cred;
>                 gd->icb = req->input_channel_bindings;
>         }
> 
> Existing code is such that cred in gd->sec.cred is always null. I'm
> 100% certain of that but I can't explain why sec.cred=req->my_cred is
> not working. This is current code:
> in authgss_refresh()
> rpc_gss_sec:
>      mechanism_OID: { 1 2 134 72 134 247 18 1 2 2 }
>      qop: 0
>      service: 1
>      cred: (nil)
> 
> Fixed libtirpc code as above (or code using authgss_create_default()):
> in authgss_refresh()
> rpc_gss_sec:
>      mechanism_OID: { 1 2 134 72 134 247 18 1 2 2 }
>      qop: 0
>      service: 1
>      cred: 0xffff9002e000
> 
> If I were to fix the libtirpc this way, then I can use
> rpc_gss_seccreate from gssd and not use my previous changes. But it
> still requires changes to libtirpc. How is that not different from
> what's already there (as in committed)?

Very simple: The libtirpc implementation we use belongs to the Linux
community. The TI-RPC API that it implements does not; it's used in
several other OSes (including TI-RPC API implementations that appear
in other libraries on Linux), and it is publicly documented.

Thus we cannot alter the public structures and function synopses
unless all implementations do.

I need to audit the library code, but I think the direction of your
suggested fix to rpc_gss_seccreate(3t) is sensible.


-- 
Chuck Lever

