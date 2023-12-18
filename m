Return-Path: <linux-nfs+bounces-694-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59CE817AC1
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 20:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5468A1F25BF8
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 19:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C27F1DDFC;
	Mon, 18 Dec 2023 19:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R8jVqGjz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HdPAvkzw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF1149899
	for <linux-nfs@vger.kernel.org>; Mon, 18 Dec 2023 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIHXtX3008581;
	Mon, 18 Dec 2023 19:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=DyaW7xlBMS/ahezv5TTGWyOg5Ix5mOF8XQC7wFPsRx4=;
 b=R8jVqGjzYuw/3lq+wWl6o/x5qUHTDVrvxT/gOmWxPr6b+wTczOTe6VHMCd0iwKUKQpTu
 snSXhiEdSPKjCFwF+vkZ4mvcWj/wLp/6hvgccDELp4ItKrIFc8K98HpXTiE93iuOGQqP
 c3kBB7ulx4rZxUnQ7vCw1Dur+gPWwV+TTHm2YNXmyRkmA8a0RgzP9IAVEKK6kUy5ExNk
 SSeptNTS9z0FNts9xqcT1ntNmXRiu7eL2lMpZMdb7dXNC4uuxoeqJXJlH65SbP38jFP1
 6oU0OxWEg8fUANGJXA/UZg1mgjehxgQlbJejXcy+zsjtrfsYAQ+6z4wTcNGTU/UZmDgm gw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12p444wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 19:11:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIHpauD030967;
	Mon, 18 Dec 2023 19:11:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bbqxpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 19:11:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/e4+Ul1p2o2Uc1SUfivJnRJRp4D6JV5oAeIvF+lDI4FmEXqM8aPylD3MoAZ7iRncAx8Uue7QO64ZQ+y4PMqoX2cwEeuamXCphea20PEoezBCfYJAwQalbHFqNnixVn4JTrDupPG/Ij5uTL9/imebmbtKCFi9tQrMasi+F5+G+n3Vry78pM9IvCljahwQs/Y1Qr+Ds/aPsrxmM5wu3sCp/fVYr45jzAcwUdNQbRwU/aPmbtogJmj0NQlBC3pcr3WdQugKFtxHINwT2o5p9c/12WxGXCb1ePRgcuHygkI1u3y3gxbHj3uMqHQnRXJ9lyfTWUQV6NSLAUFo3BaZaPBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyaW7xlBMS/ahezv5TTGWyOg5Ix5mOF8XQC7wFPsRx4=;
 b=GZX6R1RUQ03NjtAoo9j0AoRQHIkBjRmiMt/YBtZRJpkd5rzbWcU6PhZDXUjkrt42Sqb+yQSy98zO6XumcLcalxr1yCNbYASF/yliJbFsPEURTgQ4zF27z3aw/0N+THRxdRHw7us3+dVTLXLUzLqdYpGzw7bTTpzhl5mlP3sPk/BmDGz3QPBiIhes4OnoVVOLy4exgj6gp6pw5DrRLItGfKAUhTecvTNMjeoyRPCd9up4tSsK3ajoscr2JXUdV1Q603FbizEMdIFbW2bo2dGoEj/YX4Kl948e5CrfUawREEdnLcfXbX7UTzDpP9ljeqS9OUVmHdE+u2qW52YiKp+PXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyaW7xlBMS/ahezv5TTGWyOg5Ix5mOF8XQC7wFPsRx4=;
 b=HdPAvkzwNPgLw4mt2KNuBrVj2sBSoSS0RCa5ywR4Cuk5v+isbk2t+RrjvoNaOGnx2Ocas7HooQUwTveVZljoZmaVwWofopfzI91k2XWHATacccb3KDTpiwSF9WqSd/k7JRI+czQ9z0wayRqVt4kNBJNHtdnOoVFgZM2X2iECmVQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7577.namprd10.prod.outlook.com (2603:10b6:208:483::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Mon, 18 Dec
 2023 19:10:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 19:10:59 +0000
Date: Mon, 18 Dec 2023 14:10:57 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: dai.ngo@oracle.com
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org, linux-nfs@stwm.de
Subject: Re: [PATCH 3/3] NFSD: Fix server reboot hang problem when callback
 workqueue is stuck
Message-ID: <ZYCZQYK9jM2dhiag@tissot.1015granger.net>
References: <ZXyvCnEuV9L18JSS@tissot.1015granger.net>
 <195ba461-0908-4690-85a9-a9d12ffbad90@oracle.com>
 <ZXzIGmhDZp7v87aZ@tissot.1015granger.net>
 <aef15e6d-20c2-461d-816b-9b8bc07a9387@oracle.com>
 <ZXz7nxzlPfJ+06QI@tissot.1015granger.net>
 <1a988fe4-a64c-48c2-9c2c-add414294e07@oracle.com>
 <ZX0gOlqGbIES5RtB@tissot.1015granger.net>
 <88802128-3ae8-4f91-aeeb-69693b137981@oracle.com>
 <ZYBtEs7JfMCi0TCl@tissot.1015granger.net>
 <11b384fc-413b-45e8-8592-1f736de6a3de@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11b384fc-413b-45e8-8592-1f736de6a3de@oracle.com>
X-ClientProxiedBy: CH2PR05CA0018.namprd05.prod.outlook.com (2603:10b6:610::31)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 374f5b8d-74fc-49d9-1227-08dbfffd11f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ryotq2YBlBUuB+ipbombpflECQLbp4z3wEAOGdOwLib2VH8/GG8G+b3t1BHsWH4pjwY1TXWCsdUoyzBPfQrqnpBBm36rNcjwNupPItw/Uh90dFVPcli6mOg9lbyAeyZ5xF14mQP3d/Vy2dx6+IYtNfA1+OOmMGEPVgwGs0Xc2AqjPx/UetUsVriRbl8CUk7U+PRdrX+ux1cFSwc3gjXDG1IaJ6DzBpXadBeks5qks3Ydn0Bfw2Vn5UTpTj1BJnzdQFUYRYXaI4tNCh57Iz+pxsiRtUrYIcdzjfVPEkeAptwvPcrEgBeb8JitPNbbts3773hzHIuSusHfffh8IVJrEuPLjRwU7VDPedvIJmBtjVQRFbqCYDCUdwGVXs3juF5+TeWTlMMEB3GFz+LALSAPtoNPftUAWrVpCZTCGfISzuYP/+ecj12fedI1AkYYqipzdtVW2D5KvKEMNzzCJM0oabYbjFRipYTYVAPIqwqzNz/Q9RrUBUaLsyFxDfH27keAl+1E8MZOcQprWp0BVYUH1CFpuMTVA8dkN5Es7smqCV/Kjwuc2YDQ+JweClSuaI5N
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(34206002)(66556008)(66946007)(8676002)(8936002)(66476007)(478600001)(316002)(6636002)(4326008)(41300700001)(6486002)(5660300002)(6506007)(44832011)(86362001)(2906002)(38100700002)(6512007)(9686003)(53546011)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?maUBG6/hhgQok1EeYDzIZei6RkMl1I4Ms1mq/sjS6xagamOxZan7Uu942Ttf?=
 =?us-ascii?Q?mdYZxVnppbdeVXYlwBJGDuKamnHXVVPTFPRxHeQS0hMUVYGN9CkTtaW18JAf?=
 =?us-ascii?Q?85CjNUP4Y5+sO58hNAO8/dqv+jy8tUftVUBlWwyNKVem6JkvZdC7dvjvaLll?=
 =?us-ascii?Q?wVnq3e7lMl3w7LZZRk3osTSgSOrbBy4rMNr+YPM7c64ENAul9H7JQdyK60O5?=
 =?us-ascii?Q?Mu8EudxE+2MSKVh3a8/M1wu3pMdZOGw2cUTYhljJ+lUrvdg8vvfjng3IqDNd?=
 =?us-ascii?Q?mZsn5MqhgwEW0IELrCd47NGqnCTrc/zVy7T2oIY2F9yaFiAYovJ4SAD7e42b?=
 =?us-ascii?Q?OpvneH6OYRdd2D/C4p7nTnCiGoIE/I+xvZKKzfxg/wx19UmP876uVuW1Gjnj?=
 =?us-ascii?Q?ykqPz50VFICI6S8yAqLa5QMmgC7A4Itj4f5utcE2RJ/Hc87IEi9jJAb8au+d?=
 =?us-ascii?Q?NhBCBsU+DiuWQ6pzUm9whi2qwcOm0RHhJ3xqdYXqzJsHJ3hlNLZIevKuxNVI?=
 =?us-ascii?Q?xYBPgnIEhLK61YSK0H3Vesc8dmQ0/OWDIFLKVAYz1wkC3Hp5E2MCCWKdjpUr?=
 =?us-ascii?Q?klRJHYKoQ2TLRcAh6SE5PjVbBWQUn11W+F1qQ6ZQ2fXOL/wPOflBw/HgxsX0?=
 =?us-ascii?Q?lU/rbtymXzWYSVVRRJctik9dAYDsuO28rATqvhiYozaTmz06+ytJfW+LnCZN?=
 =?us-ascii?Q?lr7jYZQYUKUgHy1Ip7e7ehobOEn/w15zv4bJry8Opp7uh/ZFpxToSaajzs9H?=
 =?us-ascii?Q?SUmZdBxOhV9nnKC1V5QT+pw+EzYzINVrLMkonwZ/lIaYQp5DRQEp5NRlx3ci?=
 =?us-ascii?Q?OaNk/lo/dBDpQlQUkF51M/Zpu0MtekLuSu8oQc1P9PYw7NBUGbpTtPU8i57M?=
 =?us-ascii?Q?lFKZO2qILQre+JE7wrtFTkeDbiHFqS+WylrvxaKUbzu2rO38OMS6kZGXKKes?=
 =?us-ascii?Q?aDBk4APQl9obn2zdJGWmmMpoV7enpx8aDewbR03wjzYVT2GBeVuXfdoHc/mx?=
 =?us-ascii?Q?AsLSBjVCyjzIrv2zIX0Y8nOwW9SD6jtqxFX2yiww/cLlxpfuO3Apot2BqCHL?=
 =?us-ascii?Q?z1LktrT8QPCZ5a3acRUHlMdQ9UDdPYWegFg51ijq1NWAVHiLVKkChhYJrDcF?=
 =?us-ascii?Q?zoVDawGUBfxVVxicPObGVDdya480A+sjiXz1+LufkPXusa8wBwgeQS59UoyK?=
 =?us-ascii?Q?zh0hA2JsGIJIcD43V50uAbrxgjYcBIMFLKjZNzF9Hf6eT4obZvnRb+Rc1GRB?=
 =?us-ascii?Q?gHmB5CBOhGXzlp58hkHwPoVh6dri4iqrFkz92mAy7i0o6lkBDR1GfBJLgr7x?=
 =?us-ascii?Q?6XdTSUAV+Yhzrdg41p/4UDt8C+M5I0yHLbfQs9CXU40AEy0CrWsE/tq/Xz9N?=
 =?us-ascii?Q?CC7c2R8HYEvz5gIqwWtBS6Fy90ZPE01f+ez4vVIv6ZIk/Fb4mTDFXo2FpxU9?=
 =?us-ascii?Q?MgtCSsymU6WST4d3XiktFMhGcPAkWNeHnPEmKtQLkclBKMO1WS+nu+dygL2h?=
 =?us-ascii?Q?O4JdR7Wa9NRfwqkAIXAlWJ8H55pxEJapq1GHywZrbIMtZ7HM2IqVmC5toYW6?=
 =?us-ascii?Q?3eIxpF4LagLSRhcvTLCx2lQvV7fkQhuflwvdK/v0vuMyTuijcF9W23l8jAzE?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vZei7OdnYprUz4pyhl4gKCdbduh9SvQT8EDDCFLMJMJzp6PRWzcKyi2pMMTaXU+X8uZFUYBMSngNXSdur2rQlX3agOb+IbQX/5Yu+FrtQ393Ajl42EVdOhorxCHNEHk3rvRSRB//rjTTh6BsSAPOqbGsZaySf/Iqg3bmsgwof0Q11ePikvimZ8kWjO8xf8qcMjdMFlbYf5noSNL+zTod3PWIbjit86r2TKJNOUdqzaQfeDWC2J6C5QSnOMcD3YhiblFJul+0pMTBjP1AuZ3YiE92OwLSUjTG1dtUd6cd8XQ5+LmWU23p1bo7+orqHaxHoqQeK1VB5vxEUwhw8BWl/ScHou4p1D0RS3i9+Fe9TyfxxKAIehduIcHCmdEi9tZAVhSibC0UWKYR8GjUfFFLhHmalyo2GLrEJU08Sb+o2cQ5as469qSZl2aJ+IUoLTncocGE6hqkV96dgEI6SwT40dLhB8SbU4ZkTr/0qChtbhYwkuvuY+l1XJszT6nyRBuHYjBRC1CArRCxcf+uAwfggpZQtTefm9JGNSwUlC5smSPA4JOj6iYtGtyQjnr8XdyKZjlyqEXq89Vw2OvZ+avqCXuAtG2SdGERi6RkZHPtTV8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374f5b8d-74fc-49d9-1227-08dbfffd11f0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 19:10:59.7423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DX63wYbOd+rElhQ/NBp7ml/bqaiVtlo/BqkoEZSeT+xu7xraE5Cehw/0BMBJu0BfefamHn+kaIk73eXJVy7Gew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7577
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_12,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312180142
X-Proofpoint-GUID: wx64pCx-qYqdn6EPykBGa2NeIFyUf5lM
X-Proofpoint-ORIG-GUID: wx64pCx-qYqdn6EPykBGa2NeIFyUf5lM

On Mon, Dec 18, 2023 at 10:17:49AM -0800, dai.ngo@oracle.com wrote:
> 
> On 12/18/23 8:02 AM, Chuck Lever wrote:
> > On Sat, Dec 16, 2023 at 02:44:59PM -0800, dai.ngo@oracle.com wrote:
> > > On 12/15/23 7:57 PM, Chuck Lever wrote:
> > What we don't know is why the callback was lost.
> > 
> > - It could be that queue_work() returned false because of a bug.
> >    Note that there is a WARN_ON_ONCE() that fires in this case: if
> >    it fired several days before the hang, then we won't see any
> >    log messages for more recent misqueued work items.
> 
> The WARN_ON_ONCE came from nfsd_break_one_deleg which is a delegation
> recall and not from nfs4_cb_getattr. I suspect this is because of a
> possible bug in __break_lease as question for Jeff above.

OK, so there's no indication at all if nfsd4_run_cb() fails when
NFSD queues CB_GETATTR? No wonder it's a silent failure.


> > - It could be that nfsd4_run_cb_work() marked the backchannel down
> >    but somehow did not wake up any in-flight callback requests.
> > 
> > Let's get more details about what's going on.
> > 
> > 
> > > > I can add patches to nfsd-fixes to revert CB_GETATTR and let that
> > > > sit for a few days while we decide how to move forward.
> > > The simplest solution for this particular problem is to use wait with
> > > timeout.
> > The hard hang was due to an uninterruptible wait, which has now been
> > reverted.
> > 
> > Going forward, if there's no wait, there can be no timeout. The
> > only approach is to handle errors properly when dispatching a
> > callback.
> 
> not even wait for 30ms for well behave client, same as nfsd_wait_for_delegreturn?

30 milliseconds is acceptable. It's very brief and can never result
in a shutdown hang. I just don't want a long timeout.


-- 
Chuck Lever

