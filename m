Return-Path: <linux-nfs+bounces-505-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8329280EE5B
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Dec 2023 15:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37029B20CF1
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Dec 2023 14:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD7973166;
	Tue, 12 Dec 2023 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SnSQ7xQa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PNW5PRbw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA6B10D;
	Tue, 12 Dec 2023 06:06:00 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCDijOZ020785;
	Tue, 12 Dec 2023 14:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=1+juYWvyL7MNas3z0pfjsxUyCZ3f5nu9zcOSffVZhik=;
 b=SnSQ7xQaBtM57W2NEGDYH1vovQDakfiu8aKg48yf5vGnSOtXLHkKC3ZvoNMdzoJrN2H/
 uO6mVPA4Y/KJTaVtEhjYmwHYyisLiXlxISgOUGwQwMStA77+CFQCUwOHDWmV6Ly4ORzL
 8UzSKV/ZKwGGQMxUdJZ3Y6+znhtBn4Ra8+9jCW0N7sFP4MmXrEnX9c1PHyiMIFjK1WQP
 y/cxMsLacAA6WXvHQ9RYqapJTmd5x47WtgJ70Yac1aasUJstt16yLAHBIz1IywVWr41h
 R0CopQ1tirhtt8A/8Knf0naTJqrkC24Ea1w/o1yjAuZv6HBn/jQXrw/PzPIO7g1sK0SO Vg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvf5c5p7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 14:05:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCDxgGY012806;
	Tue, 12 Dec 2023 14:05:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6mnm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 14:05:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1qR7m85Sa3zpAEUtjHCvOFSAXCDGIFibdRrnObRBuL8IJnBXtoVjpZu0ExUvLQt49wQJqZVIE0Wrg1WSouMwnHyZE3osbs4F7iuVRq+RX7imi05NaF0HabBIcpm8hyBwfe8hPL9SPJYkSL92DdGA2XfAavpSr50BGNJoyT2B42C8obPUSmnP5gwZqJCC+zZBKKzstLrJRJDvcidqhgViUzHz23lCOZ4LCT7/92OVNMC4B2Q39Wldb1KavW5tlArBNAydnyjPxji05NunWBLO+BtG3dY3KDx7iYomCt5MUaXEQc9BPOX6MnFY/P9iWuG0wDSSGHV7tVsdmLOwbeeeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+juYWvyL7MNas3z0pfjsxUyCZ3f5nu9zcOSffVZhik=;
 b=dwyVGKL2XHZMa0oUSfgsKtn7xcANXd7Nt8P37EsVtcMYPDw4N0CmBcyTElD74yRFCJ+QH8e8ufLTF8mO28pZPD9e6pakvlKBHWjhq0tOyAB3sjBlmaSc3uDify8MsVV1cNbQdU1xu2sHJsAqHf1ocHh6rgeMR9OL6+1LOdm7Am09og04+Zl5hSlj3uFXiYRFLBJxjH8wwG+aEP/O+gOIg1b9u1tibyWrCfAuKpVrHz8YyZrvD18mp13lGs9aYL2IFk3xeRBDuKpTIgOBikxfOY0n9kGHL4L89G4VSz5e5HSel0Ad8xQ02MWjzoFHXEuiDzjiUr6I8QdFDkjsPex4Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+juYWvyL7MNas3z0pfjsxUyCZ3f5nu9zcOSffVZhik=;
 b=PNW5PRbweOhPdGPT48Pb5aTVyuIabUlkhqnjTluWb70QFyfPEfER9jkCAkXmQhsFjgM62/C5hqXV3E50WPZ70GxesAdiS0qwungSF+GH6WyxV/XdMNogzU5ibPd6VnzwSE2tNuxXu8EIX6zbkgNiRYpuW1oYOxtGwKac0YDk/Cw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4444.namprd10.prod.outlook.com (2603:10b6:806:11f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 14:05:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 14:05:46 +0000
Date: Tue, 12 Dec 2023 09:05:43 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>
Cc: Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhi Li <yieli@redhat.com>
Subject: Re: [PATCH] nfsd: properly tear down server when write_ports fails
Message-ID: <ZXhot6zUt6G1xaos@tissot.1015granger.net>
References: <20231211-nfsd-fixes-v1-1-c87a802f4977@kernel.org>
 <170233558429.12910.17902271117186364002@noble.neil.brown.name>
 <a2b59634a697ae07a315d6f663afaff5cd5bf375.camel@kernel.org>
 <ZXhlNtQ9o+howGbH@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXhlNtQ9o+howGbH@tissot.1015granger.net>
X-ClientProxiedBy: CH0PR03CA0393.namprd03.prod.outlook.com
 (2603:10b6:610:11b::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e0b59d-6ad0-49f0-3da5-08dbfb1b6ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XIr41XMUqKORwoVz3B59Epb0xxNMzrIt42kuKXkrMfP5sih2q1OLFQM+v1whLhhr0zwXs3Tfn6n1XXnVShpxxIvBjj9Zhoo5wT4Jb9Ax0mL6B7pxB02sgn5nXCXrb8gHF/YjzzVmNfNPDDarnLMsadzgGDxtaK63vh0JX0naQobH76gYy8t9TLlsvGDbK/4G01T3truL02rx9im/1Wui/wFxPho0F0S1C0UEixlxXBg4vff5+dbs2Lkc4Z+WzyIwN+iVB9f0yJd3in4dRLsuqfaeuChcINCtyblEc5iapi5zkunNVod5rc7K8J6M7vAI+hdpntPnS0+t4CDzYx5ySxu9Pze67ZwddWvNvWIo0E2atOhIY3zyfaTseWaiNnGFoMky4mn7MPCh1vfgBXQwG3XSjwQUJ9aqIZfUSYoXIxm+JUCJVKNYWK6nCFeKYfbJ660j5kwzb61HAeotnmSlmRF6Oc2P04SJcVxtaPvIBYiJmc7CIZzPg3gyDjLt+s/mSekQbeEuq8OrpDTWZWfrcUSSD6d980QcP+zg70vs3nxsYhTFEfEgTjVSv+6zLSQhSVV2viQAMHHQyz7ojOK0bw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(6506007)(6512007)(9686003)(44832011)(8676002)(5660300002)(4326008)(8936002)(41300700001)(4001150100001)(2906002)(966005)(6486002)(478600001)(26005)(110136005)(38100700002)(316002)(6666004)(66946007)(54906003)(66476007)(66556008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PUnwLMWZsESROWvtNnuoodxCOHPmkwzOnCWcGGm6sf0d3l/OqC9fRD4hX6sC?=
 =?us-ascii?Q?RSWtIqSw7JvsvX1feERxOcr1JFZBd+V+TFZaWnZtiUS2wg67+Fh/Y4V1TFj+?=
 =?us-ascii?Q?7e23NfCC0mC+EVo6XQx/KKph2C4JUR7+CQMTbP4vmfqnFsyWvsWy5mNKjkZp?=
 =?us-ascii?Q?Ocr12Vs9UZ9TncOlXFS71NuwbscQwKu/3nBvbArlKtRoLh9BOJ3ZDMyecVC4?=
 =?us-ascii?Q?2i+fGdgdp9C9GogDuK3UK9/JIcDH4/PMmvkETjJuxd8yKSSsWndeixcGHkhm?=
 =?us-ascii?Q?Ytej5QFUMz5UxsONl9AB5TVWuhfvJlqKRAOoz879frlqj5yc9ldKg1oxOF6p?=
 =?us-ascii?Q?8N/eEkWGDgf3lvQk3nYkmkzOa4uCM4tTHrExB4Xmj6k5mDVk6aReyLEaD1TG?=
 =?us-ascii?Q?RSAZJkeSdI+46UEMWXYUuaAxMn60OOMKbak5n35GqOdvp4RCzDran24aaGIy?=
 =?us-ascii?Q?Ulsszymh3RuG7xuaJC2O9Fr++yRjiORNZZTcYu5OrS0+bP2qQCRAoDjmPJBi?=
 =?us-ascii?Q?kFdOz7AhJz56oO6Hlvod/07+iVAFpUewF+kibrM4MJDl+5Y6ZH+HGSDd6gjx?=
 =?us-ascii?Q?BPN94DCHmNhCJTOFV0WXv3PXCQc4UkUoxw94i5gGNowLzUFqi9o5b6/uxkMT?=
 =?us-ascii?Q?XqNwEFxy8qbBkx/NEFXChG1s7l5pe5TDmb4IfkWPW+8Zqz0ydRs9o1tkoOTz?=
 =?us-ascii?Q?afGtQIOZ93lfW5p+oJLHKEAQ4Oxsbi1+VXSzF+P6egHZn/moxkq73zfjBUky?=
 =?us-ascii?Q?D7MoRxZr/V8OW9jlEwJWoogy/3X1/lc2ZcDN7FEFDQ4zJ5R5Pypy/L7ob1Em?=
 =?us-ascii?Q?qqrNyYKwbc4N9GyOpnKv6ZMOGiyhAZyNcbK32Yf2qUhNYRlAXX/NZIjKP9U7?=
 =?us-ascii?Q?Xbv8eb0/Wog7Ioc0EAIyqSifyefKb/Hascr6tjrnGZz3bAeKEk0AIOWWij7K?=
 =?us-ascii?Q?b64YNWTmz1QbQAiRxKx+8JgpoXcTgEf/BA5W8aheWc2rYDzguzobI49ugnlA?=
 =?us-ascii?Q?G87qI96vk2xt85rLCRQ3QBBOCobT8QIQoqepeCfsFxy56sGiytMavQTlGJ7R?=
 =?us-ascii?Q?rAogFfPFZA4pxNd/4kROd4+Eki+cpPWszMXpjs3rUXU2/TnjffsHa6cVu7I/?=
 =?us-ascii?Q?pOhyqErtHIxruvksdfJpnCqXr/u/BKVhmHIfLcyb9HwdJwtgz3bhuejNHXXO?=
 =?us-ascii?Q?EMRFze/l5M1i6vm088p7CpUBOcgQBUT+ygy5Q0bZ1QTY+02L30y7nCEeQUqD?=
 =?us-ascii?Q?15bN+mfu2XeIfjP18OTqVGF5ud+L0SzGZI4QQKzUjkUfIv87TS33jQWPgW8+?=
 =?us-ascii?Q?+hAnorLUuGroXdBxwxt/QZu59MCh7u/NCk6YslZdHhK6gMBgP9TDAxfqzeDi?=
 =?us-ascii?Q?ULCp7AHLilyrl4TTOR1ufMbt56kz3RC/jxQjmXSb9PKKs05LBcvKxx/jcKRO?=
 =?us-ascii?Q?UvUGZKdyh/4FNfcvX5lctKtwNKBztMYF4APa4G7/XZm6F2t/+l6v211wtfcK?=
 =?us-ascii?Q?YNSzxtbvTo+ZBzuLPtqEqwnj7ZBytaw+/bM9CiJfJlamQZuim/hOra0Kvkv8?=
 =?us-ascii?Q?GV7FSNENdOK2BnfUhZh1yfA2ZSq2d18HsxDuJUsYqI1GwG5nIdI8cDw7VIp3?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QNjl+h8jbyeFbl+Z2juqNHNofirwBGO3qVEcjizWErTvUe5wcCYCWc6QW981DhGm25BC1B5h6uZlVnpzjqCEcfiiMiC+hd/5NvlswaPyOtDMZeBNbKtzz2RKqnq0rFOno9Za5BA/EY2PKI3QdvoImuTP0KzdI/flBEFcVYzQVg/iYerKCx22st2LXfj/qRpjgWgYSgfJTv9yTGb8S3Lud1gBKM6/z/qd+iSiCxN2LHTBp1787RZ/EF/wVc80lwyDEEwZx6h2wpcfVnhHZZ8+FHq/AX8cYI78+duTZEcKawMuYIr0KMCqYk9F2GUGurqAgQOfAfCUpGoq244/bnOEehD0ZmiIRMmcjgQIs1Icl5PXf63GqVDobsUb7Dyod90I9LIYDSLuWdaSSOd5TZeN5VjNNTls1Qq6lFlLB02Si7IYXpmlFnIpfOF4Zpzv5nt2/aMj4zZMyATYJFKGY7jQg+lGUg9Qvm7Hsl1z4Zpimn2lHuNEPpY4O5kRUPy4qxowWCz+bicHC+lrvRw3HU/2QDcwOsfRyC9DuuhMKszA4uFsIW7mkUDIS2VvggjWuFLAoZVxL7iO6vaJa1D2t8e2j3T9quZz76UiWAMWD6Rt6qJTlz49sn3IogZRftlO1idYiYyKm/TPLd2qgKEi1WyVPf7z8+ks6E5ut65u/zCih1v1QFVUB1Zn8vKzRrf61pc0iAeFxX3mRGYXFLBpKglqCxKhqFpXFIN0htSn8lcvx5XOdDbnadYBj3F7enw+05FBQypxzU8TZ3KxFh06b5x9TCR4o/CfibaOzkm3uSuyNMsSLPm8zRxbJ6Mop13MYl9EajjSCmCS13Obj0Gwr8+dvnXsG/fhiAKYXH/haGk5A5IkBh7fc7OdRQ65zcwli2syJlbsqJLs/EhUdr5Gx9tuXg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e0b59d-6ad0-49f0-3da5-08dbfb1b6ff0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 14:05:46.5176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWFQ9qRAdRBsSC4G7tD/ECLMH9vB+IsHBesPNMbe+xntWLNhO+jH++5gcJYb4s2AbVa8ETQWrQpVC+NRVuscXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4444
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_07,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120107
X-Proofpoint-ORIG-GUID: tI4DgAjcx6FJQc_v511zv_-Mq0U1cGq-
X-Proofpoint-GUID: tI4DgAjcx6FJQc_v511zv_-Mq0U1cGq-

On Tue, Dec 12, 2023 at 08:50:46AM -0500, Chuck Lever wrote:
> On Mon, Dec 11, 2023 at 06:11:04PM -0500, Jeff Layton wrote:
> > On Tue, 2023-12-12 at 09:59 +1100, NeilBrown wrote:
> > > On Tue, 12 Dec 2023, Jeff Layton wrote:
> > > > When the initial write to the "portlist" file fails, we'll currently put
> > > > the reference to the nn->nfsd_serv, but leave the pointer intact. This
> > > > leads to a UAF if someone tries to write to "portlist" again.
> > > > 
> > > > Simple reproducer, from a host with nfsd shut down:
> > > > 
> > > >     # echo "foo 2049" > /proc/fs/nfsd/portlist
> > > >     # echo "foo 2049" > /proc/fs/nfsd/portlist
> > > > 
> > > > The kernel will oops on the second one when it trips over the dangling
> > > > nn->nfsd_serv pointer. There is a similar bug in __write_ports_addfd.
> > > > 
> > > > This patch fixes it by adding some extra logic to nfsd_put to ensure
> > > > that nfsd_last_thread is called prior to putting the reference when the
> > > > conditions are right.
> > > > 
> > > > Fixes: 9f28a971ee9f ("nfsd: separate nfsd_last_thread() from nfsd_put()")
> > > > Closes: https://issues.redhat.com/browse/RHEL-19081
> > > > Reported-by: Zhi Li <yieli@redhat.com>
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > > This should probably go to stable, but we'll need to backport for v6.6
> > > > since older kernels don't have nfsd_nl_rpc_status_get_done. We should
> > > > just be able to drop that hunk though.
> > > > ---
> > > >  fs/nfsd/nfsctl.c | 32 ++++++++++++++++++++++++++++----
> > > >  fs/nfsd/nfsd.h   |  8 +-------
> > > >  fs/nfsd/nfssvc.c |  2 +-
> > > >  3 files changed, 30 insertions(+), 12 deletions(-)
> > > 
> > > This is much the same as
> > > 
> > > https://lore.kernel.org/linux-nfs/20231030011247.9794-2-neilb@suse.de/
> > > 
> > > It seems that didn't land.  Maybe I dropped the ball...
> > 
> > Indeed it is. I thought the problem seemed familiar. Your set is
> > considerably more comprehensive. Looks like I even sent some Reviewed-
> > bys when you sent it.
> > 
> > Chuck, can we get these in or was there a problem with them?
> 
> Offhand, I'd say either I was waiting for some review comments
> to be addressed or the mail got lost (vger or Exchange or I
> accidentally deleted the series). I'll go take a look.

I reviewed the thread:

https://lore.kernel.org/linux-nfs/20231030011247.9794-1-neilb@suse.de/

From the looks of it, I was expecting Neil to address a couple of
review comments and repost. These are the two comments that stand
out to me now:

On 1/5:

> > Then let's add
> > 
> > Fixes: ec52361df99b ("SUNRPC: stop using ->sv_nrthreads as a refcount")
> > 
> > to this one, since it addresses a crasher seen in the wild.
> 
> Sounds good.
> 
> > > but it won't fix the hinky error cleanup in nfsd_svc. It looks like that
> > > does get fixed in patch #4 though, so I'm not too concerned.
> > 
> > Does that fix also need to be backported?
> 
> I think so, but we might want to split that out into a more targeted
> patch and apply it ahead of the rest of the series. Our QA folks seem to
> be able to hit the problem somehow, so it's likely to be triggered by
> people in the field too.

This last paragraph requests a bit of reorganization to enable an
easier backport.

And on 2/5:

> > > > +struct pool_private {
> > > > +	struct svc_serv *(*get_serv)(struct seq_file *, bool);
> > > 
> > > This bool is pretty ugly. I think I'd rather see two operations here
> > > (get_serv/put_serv). Also, this could use a kerneldoc comment.
> > 
> > I agree that bool is ugly, but two function pointers as function args
> > seemed ugly, and stashing them in 'struct svc_serv' seemed ugly.
> > So I picked one.  I'd be keen to find an approach that didn't require a
> > function pointer.
> > 
> > Maybe sunrpc could declare
> > 
> >    struct svc_ref {
> >          struct mutex mutex;
> >          struct svc_serv *serv;
> >    }
> > 
> > and nfsd could use one of those instead of nfsd_mutex and nfsd_serv, and
> > pass a pointer to it to the open function.
> > 
> > But then the mutex would have to be in the per-net structure.  And maybe
> > that isn't a bad idea, but it is a change...
> > 
> > I guess I could pass pointers to nfsd_mutex and nn->nfsd_serv to the
> > open function....
> > 
> > Any other ideas?
> 
> I think just passing two function pointers to svc_pool_stats_open, and
> storing them both in the serv is the best solution (for now). Like you
> said, there are no clean options here. That function only has one caller
> though, so at least the nastiness will be confined to that.
> 
> Moving the mutex to be per-net does make a lot of sense, but I think
> that's a separate project. If you decide to do that and it allows you to
> make a simpler interface for handling the get/put_serv pointers, then
> the interface can be reworked at that point.

The other requests I see in that thread have already been answered
adequately.


-- 
Chuck Lever

