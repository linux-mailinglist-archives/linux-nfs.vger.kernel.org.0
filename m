Return-Path: <linux-nfs+bounces-777-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 411D781CB70
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Dec 2023 15:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B461F217A3
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Dec 2023 14:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C447A200D9;
	Fri, 22 Dec 2023 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FpM/7K1u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pktah21x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB20200BF
	for <linux-nfs@vger.kernel.org>; Fri, 22 Dec 2023 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BMDa7VN007396;
	Fri, 22 Dec 2023 14:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=22brQ0Y8d53dvth4tKKumaj2eriT6c/Spg7R1Ek9UL0=;
 b=FpM/7K1u5AMih/zA2lGmXieegmbM6JXqEWGAgd2m+lGUflf2NSNE0mftEOlfuF8gdM4A
 LCHVBS7ymmHA+l+3tqiByBlUcYoK6jxp4cFqiheX0VncF6643+KyFY6slhQpfvtHTABZ
 3guoDU9+XL0sWUXPzTdOcdWVM08KAg8eMGRMwNQnjkeqnqg6H7EmhNkIVzwmupABL1eX
 hfw7t/ZNCyYC118jbFmwfWwKAiadJeY7hPaJ0GnV4Tm/a3igXPcJoQgXVohHG2o7gMP0
 bDSDUkjxEiel0QirHqj1t1WMikJTwhsEM65Ctc2mdNSKG9Qvfj8v409CEXKoUMI0qYAe rA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v499qm340-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 14:39:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BME08fF035875;
	Fri, 22 Dec 2023 14:39:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12be3pyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 14:39:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHLR1FeMRB77PKDNypLDKdOs8YS9N4PvarO5hKN+a1nsDMkIBkF1H0XRBhAgDSwRjr8HbCNSJrrJNYzRLTLYVz49wUEMVQLaJFLcTn60OSPDskfaNC5i0wkFhR46awwE8YqF4lFToFqnCyoEH+HgUsMWZ+WEqy6nIlMoXJKpgCIET0C/rk1Vi1pzlojahxR9QW2VNV8OuJNb2rWZqmkjebHYSx2vDZlqzFFBDXKbFILET2YlF13+A6lb2qbTXxeesEoU0p8w9fNt80UgMOwaYwD4bADeTlwkS9EJ9pbrS6jkpuGlMOxSLmDqv/Kvcx9NTPGjBJRLdDwqZQJMiuS95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22brQ0Y8d53dvth4tKKumaj2eriT6c/Spg7R1Ek9UL0=;
 b=i5UbY/4saOyem8Upgz+k+FUqZlFJNIwN/aKOkWyBYXW4Qo+pviqSmeA2aunbdC2B9WgZ51x+wRLFaFo1fq5syqCFgou/M9A6DgLq08z1xYS0/PO9y9ufNGiPJeTghWtIlZbLo5y4c54Z4GWOBruQXnwfgCUXWFjr7T84h3E4crKHdlMjcT5diTR9BmrfWuti+Mqxi1HNFT1QPa0xdnRg7qoJ1FBEx1FrIJ5adkw+Wxjq//nrZyKDfvnV7evBI4PxDdpxm6setkEeyMfZK7oIY7bE/8gscGfHUnE1ZbClW4gbEl7qkU+rWI2a0FU2PLcrUPmb9bDnp2Bc3rIAzEhvXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22brQ0Y8d53dvth4tKKumaj2eriT6c/Spg7R1Ek9UL0=;
 b=pktah21xuTRm7AeIcnISfLY45iNxKAJkQa9HncMovfgrIiC9xRIOBJ5Y1YJ/e4YCPXzpko0PDVNUKB3PUSvsksil+24Jwyq2FpvZc7uRHCrFZm2Pdr01lsuCAgR17d4GRSA32Jl4vsBEWH7YE7iOO04w/NBIFm/Kme7iNUg5d0I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 14:39:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 14:39:28 +0000
Date: Fri, 22 Dec 2023 09:39:25 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: drop st_mutex and rp_mutex before calling
 move_to_close_lru()
Message-ID: <ZYWfnV2bAeoIfKIp@tissot.1015granger.net>
References: <170320926037.11005.9834662167645370066@noble.neil.brown.name>
 <170321113026.11005.17173312563294650530@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170321113026.11005.17173312563294650530@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:610:32::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 6034eacc-fda6-42b7-4a60-08dc02fbcce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	E8WBUCOp+znfUsrABaafvl01wK1lPno6Qp5WFQe+5TrlOaDEN5vBTRarpj8K+q6dr7s3HwWpUm8deMQoyiszfzYfN2iLkS6yzX/tQsmvvGhNs1lLxJTEypBF2GtQmvN7zpvR/zOctbmNmr1l4J7ZChJ/MIf0pp8jtM7VAWWeaBmJthjSRZn/OO+mCMwf+LDSn/cQjeV7zxevdo7HwbtoRX5cEp2W+XWEPcz5yZReydhkwHayxIiw6LltIcxJOriApxc6EN1t6FJnjCdLzJTAzBnew9JHmN01z46/m2Ndf7cO/l4hBNc2tbNbhLDI2q2G8Zl4+U2rq7I3dcVstFZXJtGzXFUdqM57Clg4QXrqaunRo7jmAtbM8xgE2x0MMTnCT31ZvMSa2L3wyudAyhqigeqt/cfRpArCnr/2pkgSnD2B1zYiThv11ICdMut+wN5RFoz4e4+lsMzhu9xVxSGNCHurxn6w2kmhStw+Ypj5bs29pi7pyj41ISAgwRipGAstpOj5cR2S/hiFq1zd/YchTUFE25JJUsm0GTGjMxNUE0s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6512007)(38100700002)(83380400001)(86362001)(5660300002)(44832011)(41300700001)(6486002)(66476007)(54906003)(66946007)(4326008)(316002)(6916009)(8676002)(26005)(6506007)(9686003)(66556008)(478600001)(8936002)(2906002)(966005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hni1JBGxWgAGJwpeRCq5sA+3KBFnp4V70CFDD+SCp4UY1DxJJ45vw/asS3U+?=
 =?us-ascii?Q?jzgtcM+6CAsfgQ5Sz/Mo334gao9T+Xc/8jfjBTvCKus7d0PjBdYFDFTmIUCe?=
 =?us-ascii?Q?vna9j8daHWXinXpAHS8bT+gvpUSXUHF+Uq6R7sKVMZiDXbLv8Z6PntVpWxEm?=
 =?us-ascii?Q?YF/m0216TpUBuJOChYjKuEGikhwfEfFLkO1EU4tRDnOyZkHhk/232OzoB3Bp?=
 =?us-ascii?Q?9SoDCzjqc8qdDtE4ZrYxnlgEsloJaY+FiQkGMd2Xi3VH3HwKwtAfJ4Z7xNL7?=
 =?us-ascii?Q?oy7pbwU369xHxONdhDxHRyTwKi8KPl0NpuE3v3hcqq9/sijr46PfPzIrrFSu?=
 =?us-ascii?Q?GOSgnvRWmNMX5MJqDvm9HHjsQqj+bahnFNXR4JgSUZXpUZpC3vZifQFfJCa2?=
 =?us-ascii?Q?+wHiRSiwsva6KwvEcRTEicSYzjFDwjwQRm8IECK/3CJhHIZNStUXXUTizsjV?=
 =?us-ascii?Q?i/2+0Ka78N5mvhvzE/wrcTwroHFUSF9LS6b7gdUrzmAeFxEvlVdybvqMpIP1?=
 =?us-ascii?Q?8rMgJVNDznlF+Vryv1wo76EU+U3cjp8hFUwLxkVSCh9ctueYyG2e8hq5fVy+?=
 =?us-ascii?Q?Rs3udcSFnSbJ9TSmN6pnyDw17oteQUWM6FH5TzHR8d+BAn/rsaZZzyyFJt1R?=
 =?us-ascii?Q?7oM+hTWr90oDSEDTWcMnUIIZ6pm/Akc618Y4c6fWuuzdVBbaxtHLWDZ/dADP?=
 =?us-ascii?Q?II7MlJ7puU5vViG/t/4Wb6KTR0EZPbYGD5T922Da6Ky6b3MxjSQA4u1TCLu9?=
 =?us-ascii?Q?i+42kwCasRo4MLggBZBRVLkzKonAoGvbn5RpwbKuPud16gUemvmfOMqIXEZV?=
 =?us-ascii?Q?wqdF2EtUxqprXiBdKFjIGtbVwdp4gq3yK50ZKTttFExRCBPK3OHrM8LXZx7t?=
 =?us-ascii?Q?EzM5wSoLsrWnwij3c+kjg6KTVHzdcGYciLoHx5s2hCgQNr8rhshHHXHXNW8X?=
 =?us-ascii?Q?I9URkTElsMmVzuTzrQ4SOrbHkZbIN5nR/UObYfX7bqrFnOJaGOltJKnzHOHf?=
 =?us-ascii?Q?076vCq6ZhgLKdw2YXfspjMoHn+rQb5feV5ZprQcCxSw94Szq049Z8kuJ2K6H?=
 =?us-ascii?Q?gEcvFoSvwmEXhbPQy5X/l74Ac5d+OeN5wDxZCmJEGmvWvqLh5qeDbD4cC6Id?=
 =?us-ascii?Q?mre7xX6fYnAvmKAPBJgrS2jl9M18K63fw7vE4PDxELOfZyKq1j2w/YKE0+zw?=
 =?us-ascii?Q?uZza76FXBYANoMZlDrrxLYjdT2Slpa8fgAcq8WiTXLDsZMzbiSDCU8XuOzDn?=
 =?us-ascii?Q?8aa0dsnLar1f5N2+sdYTsKAR9Y419VEa0zm52YzJr2m9aqTH0lnsMxv6hLq7?=
 =?us-ascii?Q?XGuiPUpVjn+Q2NEECRjZf6QpZtX37x2lQaL/YCtWjd6DGTR/Grwde0ARVUV/?=
 =?us-ascii?Q?crphRjunuDm22htVJCkeKuQeEX9O3DzaN4ttarEiYYcyZFxJOFvu7nmOCtmt?=
 =?us-ascii?Q?DYSg8e2xRN7nZuyYjaZ0q/TE4P6VZYIVIHDBOoRfEeDoq4JYsVaveOoOGiGq?=
 =?us-ascii?Q?I7txll8CT3eWJZj9RsL0d1pIqC7v3p3ueXnfMYv5iP0c0E45bc2xUlOE/J8x?=
 =?us-ascii?Q?30mcp646+ttaiy3GAEA9oidLe7DgjonNiKOUml4WEbUSwlYrW4eCJ12EH/Ha?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DI6zx4HZ6kJ5IPYznbR3b+AlMq5jbJG50VZHSdIwtUxI8fBabJEQdl0iqZYGJ5UMmmpfNvOt5VpPn4nvTgsKvllf2tnrurEzoVFhTpenUJb4uZjZoz75tMjW0QS7f1o9Jv7z689hvyfPeg2vVddMtcN5mIhDMy2kZHZorC937ZRETEb/AJcdhLeWIz78KnrGc03P7HuQFYBFzx9ryzop1PgKbr0S7Mnf0OZ4YjOZcKg9QmhRQ9ttTR0JP4adgBIxe2Q3Y/eZgIK5zCWgw72Tw0ZPjQ7zSHmRTd4GuSpxjNpFH/FH2Z0bJ+et3mBf1Rd+cFslZgZ/5iFTihsgsTPEEqoM6M3T90xCcsyUq4qpR/wwIfBy6bUiqCNOHdFntaBgPzmmTwrXKf22a+ADRhAveHFm3xnKGonLq2nxhD17qBKa2MUhKeu987M8sCZkFrq2lpg8fYpLV/CUq6xT77WINrV1is+CGxK3WsXj7B55a4d+2DvQvDALTMT1e7RRkQMQdyc2bcJhKy13dZV9Ncd+oDGxJHEfvhMjRscwr6OXINWHjN6k1b+DzsIym4pBSaHCELBAF51+D+MC3gkt6pgrJIO5U8/8xBy5xVcK+oDIi9Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6034eacc-fda6-42b7-4a60-08dc02fbcce9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 14:39:27.9915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keNoFITZ6ACLymYF7QKubkOBdvXO0ChS7TLHTs1jG1zcix2qibbo1IEk+3w93S4IsLo2ytoGezGREMP6vplUkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5738
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-22_08,2023-12-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312220107
X-Proofpoint-GUID: UInXeygmh0JGEOjhzR-2DDUcsSozeFqu
X-Proofpoint-ORIG-GUID: UInXeygmh0JGEOjhzR-2DDUcsSozeFqu

On Fri, Dec 22, 2023 at 01:12:10PM +1100, NeilBrown wrote:
> 
> move_to_close_lru() is currently called with ->st_mutex and .rp_mutex held.
> This can lead to a deadlock as move_to_close_lru() waits for sc_count to
> drop to 2, and some threads holding a reference might be waiting for either
> mutex.  These references will never be dropped so sc_count will never
> reach 2.
> 
> There can be no harm in dropping ->st_mutex to before
> move_to_close_lru() because the only place that takes the mutex is
> nfsd4_lock_ol_stateid(), and it quickly aborts if sc_type is
> NFS4_CLOSED_STID, which it will be before move_to_close_lru() is called.
> 
> Similarly dropping .rp_mutex is safe after the state is closed and so
> no longer usable.  Another way to look at this is that nothing
> significant happens between when nfsd4_close() now calls
> nfsd4_cstate_clear_replay(), and where nfsd4_proc_compound calls
> nfsd4_cstate_clear_replay() a little later.
> 
> See also
>  https://lore.kernel.org/lkml/4dd1fe21e11344e5969bb112e954affb@jd.com/T/
> where this problem was raised but not successfully resolved.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Hi Neil-

I would like Jeff and Dai to have a look at this one too, since they
have both worked extensively in this area. But that means it will get
deferred to v6.9 (ie, after the holiday).

I've applied it to a private branch that I will pick up after the v6.8
merge window closes.


> ---
> 
> Sorry - I posted v1 a little hastily.  I need to drop rp_mutex as well
> to avoid the deadlock.  This also is safe.
> 
>  fs/nfsd/nfs4state.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 40415929e2ae..453714fbcd66 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7055,7 +7055,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
>  	return status;
>  }
>  
> -static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
> +static bool nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>  {
>  	struct nfs4_client *clp = s->st_stid.sc_client;
>  	bool unhashed;
> @@ -7072,11 +7072,11 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>  		list_for_each_entry(stp, &reaplist, st_locks)
>  			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
>  		free_ol_stateid_reaplist(&reaplist);
> +		return false;
>  	} else {
>  		spin_unlock(&clp->cl_lock);
>  		free_ol_stateid_reaplist(&reaplist);
> -		if (unhashed)
> -			move_to_close_lru(s, clp->net);
> +		return unhashed;
>  	}
>  }
>  
> @@ -7092,6 +7092,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	struct nfs4_ol_stateid *stp;
>  	struct net *net = SVC_NET(rqstp);
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	bool need_move_to_close_list;
>  
>  	dprintk("NFSD: nfsd4_close on file %pd\n", 
>  			cstate->current_fh.fh_dentry);
> @@ -7114,8 +7115,11 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	 */
>  	nfs4_inc_and_copy_stateid(&close->cl_stateid, &stp->st_stid);
>  
> -	nfsd4_close_open_stateid(stp);
> +	need_move_to_close_list = nfsd4_close_open_stateid(stp);
>  	mutex_unlock(&stp->st_mutex);
> +	nfsd4_cstate_clear_replay(cstate);
> +	if (need_move_to_close_list)
> +		move_to_close_lru(stp, net);
>  
>  	/* v4.1+ suggests that we send a special stateid in here, since the
>  	 * clients should just ignore this anyway. Since this is not useful
> -- 
> 2.43.0
> 

-- 
Chuck Lever

