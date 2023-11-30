Return-Path: <linux-nfs+bounces-216-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2EE7FF590
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 17:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5CE1F20F68
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 16:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F3B54FAF;
	Thu, 30 Nov 2023 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pc342Whg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uBDdy1xk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025E7D40;
	Thu, 30 Nov 2023 08:29:52 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUG1HbX015181;
	Thu, 30 Nov 2023 16:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=8V3bWAk1xgc6fg+Dn14IHLoWH1hndPpzQH2KgEY4g+E=;
 b=Pc342WhgXwF+liFIzenz6TbxgdyDG+718FluIM75DwsAHoO85DfI5alczCVWI++HBUqN
 hx4ygRj5Jj9NYAszzWThTjQe9IB4xws3rsrkRPKdokhRLNs1zLdsaZlbOf3u1NQji6Dt
 XdSh0FvQfkI/9jTZbI2Nl2bOSqOL7g4Sukt/4auxjXvY1n2fpN1JWoO2sgVHvjmv12Yw
 IzNr9lGr2IUgdv23+krZLMtZ/1QAuMj+SA6K1gHGOOFRgwKEVQD3NBO6+8gmZzOnSAqG
 bDeQcEmk9oRxgYJT+zZi37/4TBRgX/bidIk+NbTR3qiuWlN81ALHZ8lXc9HjrABp4Zcs 5A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3upwhtr377-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 16:29:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUG2Ltw009288;
	Thu, 30 Nov 2023 16:29:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7caakkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 16:29:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gw9S+YmBgGYhGcTXuQXVH7t1Dpe7LlFvmKSyMeAeLJHosNQVw3g8KOmnuxNMjW5Aq/SB36PPfqi3+ma5h/MjzwLkhISXzvduBjK1tsqk939rvkVMP/ozptQsLEmpCmIc0EZHCkHv0k2RwMJQ94Npza6tSoReNld1SrnUNWWPX8TDpAFGXUcH307rhdrOAf69f5p41lTRIXopKL9W9VBKHg+uaLGOPZ68NU13l9IZzC3pZnXf9x2O6KRumRuks6aXKPkDlebK+Yk0KoOQmV7j31tbxUB5sF5jRx2KaOr1+Agyq+ON7X+vW6tnC2IZ3GCqo4NO1UBKT8DkVlsgOfJFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRUyjc2sKtzINDsFEIIq2silJoxUJP4B7HAffNSrSM8=;
 b=hiFY4zxe0ie8/4rid3mQeBSiHZnYKwdc4IjpCu/rbVvSN4ERuqmIxL/kN3sUkU1dEMAoyr9DRmKjn2bYmGh3cbrI0mopWZ5Hd4ISabbmYLlmqhYyt34nwF7HFYFkRgLaYMyVF9XHU/icV9BIf77m15ohUoVeYIJ9g7PUyAs+fOs4ROq5XJ2mfKrCm/P3nwObSgTj/G3kj6U0TZvQMIB6NzPe3jnubsbpwYSHk1htWcbET45OY5TRkJ75J8BrmghluTmDl2UsQeH6YDAORElDCv3zU0mv/Bn//s2gplQk+T4MtTApaFPz6Fg5OFQR+ky2DUa0XtXZddLkVu5sZMd/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRUyjc2sKtzINDsFEIIq2silJoxUJP4B7HAffNSrSM8=;
 b=uBDdy1xkTGb9BVyuujbsoAtjmnsbQ2Q3dP0GRu29fyTL1PKCUDgBjR8T2QJOdeEf3L3f6fRoHvKDO4ikjyaoxG71NgSPo0jE7TP6uJASEUzmh2yaKSL68aNldWn5V0qSR1whIvA1W9mfxxckG5tr/C+U+bR3NtdrLuYTObc64Rk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5028.namprd10.prod.outlook.com (2603:10b6:208:307::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 16:29:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 16:29:33 +0000
Date: Thu, 30 Nov 2023 11:29:30 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        lorenzo.bianconi@redhat.com, neilb@suse.de, netdev@vger.kernel.org,
        kuba@kernel.org
Subject: Re: [PATCH v5 2/3] NFSD: convert write_version to netlink command
Message-ID: <ZWi4am03iXb6LY01@tissot.1015granger.net>
References: <cover.1701277475.git.lorenzo@kernel.org>
 <8b47d2e3f704066204149653fd1bd86a64188f61.1701277475.git.lorenzo@kernel.org>
 <88d91863e36a1e36f7770aa8a7f42853250e3d55.camel@kernel.org>
 <ZWi0OkrOsv8j6ev3@tissot.1015granger.net>
 <ZWi3kO5nOXqzC5mS@lore-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWi3kO5nOXqzC5mS@lore-desk>
X-ClientProxiedBy: CH0PR03CA0387.namprd03.prod.outlook.com
 (2603:10b6:610:119::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: ce809e2e-2466-48f1-8f11-08dbf1c188db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qWCJ3N3vW1ptlxlQPNn7SrmzrjHy5z6c02O9MVFgVvYtk43GeaIgj4O5wTNMtZUCc9gZl1bJNMxeNlt9MVntkBe6X8a/k2tyfKog6gPec83KD9hxTBjdYWtx8BkeFPrH05y9wgmZJwhvMnAMsyvcxnvCYF3to0ixmF8qmTbuB06o4r5Sorz07oRV6M/CZYsq9UWvb9HWgQ0WIFMhnodu0maBIg3cl3ZFov+KmfrbC/V5ugPEY452L2JWn/rDyOqliijhRTJG4RyPxoJLndX5/1slpcc1fG9jQ86X1PV4T4F2fNSjtm4Iydbragbxpfb3OtH29G/5xf/GWil2aULysxDdJoEgEhC1iInxUptLmBGKFl0U0MF/RN7o3faICF3/plBcwYsZ/L561MYOdhopizBsRKHl8VMjfeSP1jCN8Wx1M/SYVD7YGGK54xQt84pT16KNLf2RNt91MOwG4x7bQ53lM3yyK/rzbP6Aa48VLzvBanYkGrcf0JJ9DirjLkRMD1+LSTSkUwFYWWUrrHjmcxcQotLi9owDsntOWN76vkBBKmGTpTtq66gmfeWGZGS4XaiMSf0QXoqpDPWWdvFp/kQzM5oQRRTghdiU1wKiDzc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(9686003)(478600001)(26005)(6512007)(38100700002)(86362001)(8936002)(5660300002)(2906002)(44832011)(6506007)(4001150100001)(8676002)(83380400001)(30864003)(41300700001)(316002)(4326008)(6916009)(66946007)(66556008)(66476007)(6486002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?52xxCfVef1S9nTXcE93KUqmCII+nSV7RzIjDPznkPACX+NUWGgVcazrsUE?=
 =?iso-8859-1?Q?hgGUrUSwS9lsHhaEaa1CBpJL4F9Gj6BbmwSff6zrgT6STiamiFWskCHlAq?=
 =?iso-8859-1?Q?aj1rVDMHAdpxUDzIt4JAbN7oFd7sXLaac5oCqiOdomUwS6LAsLJwceKga4?=
 =?iso-8859-1?Q?YwzNDW22k+pPQLG28fztWEsa0qC9IUWdxG1K/yrz6eTmDfImGsrsfPniiL?=
 =?iso-8859-1?Q?/G7WoBcb63uckq2xC0GZWVcMnLUB9FUFWni240ZDnTF+j3Lk9BCRxGfiun?=
 =?iso-8859-1?Q?b6kbogS7BfEHWqKSdcHTWFW6oyQjcPfbp1VoplvCSpB3E1uRv3ALFeelHA?=
 =?iso-8859-1?Q?72h4Sj2CuY70m+udNE5YsB9JMqvHhcFauf5bOVVm+I/sP8OQzj87925LtJ?=
 =?iso-8859-1?Q?cggB4Mszao6b9ixLRzFBKm/j5S0w++EZyB02kMXXlwYF2ioNrFn7EosZzl?=
 =?iso-8859-1?Q?TKJEuTyx3d76DO9YB6QojAcnlKTMpqncebTnz9r0Nl8iwF0lvrvI3tPGyu?=
 =?iso-8859-1?Q?7cPO9Y+IEd3xDwJIwXf6FriROrpinG7EUXlvPdXmOd/SpppDnKf/fKpuWI?=
 =?iso-8859-1?Q?nFD0E0H9hdGUJELeDQiAQZcPSwH5+8SzBY26fceHla6NzFS3+uZRnDQwKS?=
 =?iso-8859-1?Q?SDwVxG86Ebn9I6JcWKyIVhAJ+fp8CDUxF2xHKgIDzeeqrhODcA3SLKCL1n?=
 =?iso-8859-1?Q?Oj7ZD2h1mXt10SL2j3WNsnG9Tqe4crM0m3CI0ic2ZzKMAFgXM6HUOaXvrc?=
 =?iso-8859-1?Q?sI0+hZ7Ujl3orKlXtPn6nJ83UMO54lip5RaTCjzuKH7uOpRXKP/pJTQLEI?=
 =?iso-8859-1?Q?Hzx08PNNacXuia/3ycdHlVtZgpfa79y9Sca4SnpEnPchOsoz5TlR3VK4wI?=
 =?iso-8859-1?Q?3iqvyIhN8UkWCqxo517IHGUC6T82YVp6hKSLb4dNzcEskqOgZsrBCZU5Qy?=
 =?iso-8859-1?Q?6d/CHnaS9ltmWJSu30S2x+7SGenDZCJGe6dhOtxekNgX9gxnt3aw53c5Eh?=
 =?iso-8859-1?Q?tpIuvriJJ/YNczHlmaVa2VyKVgyYAcCrHKO93ErnKXps3SwpPOatv/cF2C?=
 =?iso-8859-1?Q?lMenHLpkGaQdYzyixCrSUBhgeFUZgKki26cNqstjpLvyUmns9BEZ8dTIsd?=
 =?iso-8859-1?Q?QmFwscaPLxkOWnge8MpH59BhWcf2juQ0TLEMTikbS5vQR8YfCdhHmWc+e5?=
 =?iso-8859-1?Q?o/J7KmKQcDVJM8jhxfoaTcjKNi6FeRl9A6YXCgshuCgITi0rqJbmw+aKrJ?=
 =?iso-8859-1?Q?CMHMMoMy/2N5O/AB9yoOt2dz9+HEuVrouBkkXE38thAJwzz1j6b1UGqixv?=
 =?iso-8859-1?Q?EhK4CQeTsqbUp8Nb0Ipyd5v0dcT6rph0gik/ZOyhosHYNLWIONs0/NJgQA?=
 =?iso-8859-1?Q?0t2S5h2svc4g3RCOOtScMjHazhkyKeKAwWGAJ3w13O4DREAXcVi9q3RW4w?=
 =?iso-8859-1?Q?KixT91VnDn3S9tnsgZX6E46aDgNzoRmyhU4/l4CQBiogjZf25Wnd41A1nl?=
 =?iso-8859-1?Q?lX+rhSD4xAr1++PqdDNTikA6h8LATS14T//FHyCISlV9pWmW8S9gdT1qz8?=
 =?iso-8859-1?Q?+fUuPFjE8SzKSeqJ6NalOMh1ag+5NrqLrn+gSu60uAgNejtPaNd6e9Wp2c?=
 =?iso-8859-1?Q?FAV9E7fGEonquL7/BtS6B7xjGr/YhX9RaRKJymIJNxK9fTTjVvoKHHZw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lnNESbaF/a2B/zqk2O15VTI1LIF81YOnW4KrjaKtLcRKozmFLorsPiyXsmPyutd2cQJTBevi8zOwzxoT/6KXg9FQ0Y3B1Z0fAtK8b0swkXxGJQsdk9jSGFvPPyqhwKuwo8rWcH2O6v6gRf/CKPWDYCvVb1/q3HCJAHFkm02RY5ZikyokyUNCM5lQYS6CXNuIIoXsHc45Da8mxKXW4YHY5bmUyljF5xqUZhcKL1kWd261CMllk5KY4n3CpNY/5Z5d0oVdCG5SeVdyw4uhkgPSfPfV+nH3+yCLGRjxZ0VsjKwL3Dz2tf7QLVrPNgiKuckmPm4gWhPjqSLJ60HIz7or+Pszy77fWq+QcskJ17If5hAu+KjypnvLSB4RtflE6XCOyxSl3EfRx90SkondlhqTWxkdYDXY4YU/WhHfYNe1rRP17P6Jc2QHe2jGL89ewVguKRY2b5Gn0ur769Po2si6imqfyAYRoy06zgJCQcCo8nLdQCAlWD6E7J9N743OcZpG0n3xM2JlcL3RoR++H/JyxvdNbph11huMwiFUz81oRxVSAnWmEq8wB1MW21fQK1l5NDLUYkRTaL3JvP3RnZZbaZ1DbgDroRlHsLPLHan3YxpbM5/Sl7KGD2aP6vEOAXFz0n0IjLzyxKQnWaAmpISmvO8pPPVrTmZSo0bfCWk+ir3kchTPxAPzRqwddi4yRP+9PVHo1EOQkiuIkwHwTEcek2zUL5GBWeckLeKtIUlg+S538ad4I7beS2LJhE9hkjMn/pWSgHa221lMHGnXf2BwpaUpdSdjjWjw3zJwPM9nTPxPevuoayDYX0CwFHbnz4CNb5orJ/EVrBRQPpgSHB9Q9g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce809e2e-2466-48f1-8f11-08dbf1c188db
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 16:29:33.1494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1IwQa+N735WkdXoz4YbrnaB3BVWOJK0ZL+mvkqs/Ajn7QS5s1/XXoxh0e0lFgUCHD5sf5LgUBE0743n3MKGFLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5028
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_16,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300120
X-Proofpoint-GUID: BEix5QH9UIJXOkgEbwdd5dNQlujt4pQK
X-Proofpoint-ORIG-GUID: BEix5QH9UIJXOkgEbwdd5dNQlujt4pQK

On Thu, Nov 30, 2023 at 05:25:52PM +0100, Lorenzo Bianconi wrote:
> > On Wed, Nov 29, 2023 at 01:23:37PM -0500, Jeff Layton wrote:
> > > On Wed, 2023-11-29 at 18:12 +0100, Lorenzo Bianconi wrote:
> > > > Introduce write_version netlink command similar to the ones available
> > > > through the procfs.
> > > > 
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >  Documentation/netlink/specs/nfsd.yaml |  32 ++++++++
> > > >  fs/nfsd/netlink.c                     |  19 +++++
> > > >  fs/nfsd/netlink.h                     |   3 +
> > > >  fs/nfsd/nfsctl.c                      | 105 ++++++++++++++++++++++++++
> > > >  include/uapi/linux/nfsd_netlink.h     |  11 +++
> > > >  tools/net/ynl/generated/nfsd-user.c   |  81 ++++++++++++++++++++
> > > >  tools/net/ynl/generated/nfsd-user.h   |  55 ++++++++++++++
> > > >  7 files changed, 306 insertions(+)
> > > > 
> > > > diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
> > > > index c92e1425d316..6c5e42bb20f6 100644
> > > > --- a/Documentation/netlink/specs/nfsd.yaml
> > > > +++ b/Documentation/netlink/specs/nfsd.yaml
> > > > @@ -68,6 +68,18 @@ attribute-sets:
> > > >        -
> > > >          name: threads
> > > >          type: u32
> > > > +  -
> > > > +    name: server-version
> > > > +    attributes:
> > > > +      -
> > > > +        name: major
> > > > +        type: u32
> > > > +      -
> > > > +        name: minor
> > > > +        type: u32
> > > > +      -
> > > > +        name: status
> > > > +        type: u8
> > > >  
> > > >  operations:
> > > >    list:
> > > > @@ -110,3 +122,23 @@ operations:
> > > >          reply:
> > > >            attributes:
> > > >              - threads
> > > > +    -
> > > > +      name: version-set
> > > > +      doc: enable/disable server version
> > > > +      attribute-set: server-version
> > > > +      flags: [ admin-perm ]
> > > > +      do:
> > > > +        request:
> > > > +          attributes:
> > > > +            - major
> > > > +            - minor
> > > > +            - status
> > > > +    -
> > > > +      name: version-get
> > > > +      doc: dump server versions
> > > > +      attribute-set: server-version
> > > > +      dump:
> > > > +        reply:
> > > > +          attributes:
> > > > +            - major
> > > > +            - minor
> > > > diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> > > > index 1a59a8e6c7e2..0608a7bd193b 100644
> > > > --- a/fs/nfsd/netlink.c
> > > > +++ b/fs/nfsd/netlink.c
> > > > @@ -15,6 +15,13 @@ static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_WORKER_T
> > > >  	[NFSD_A_SERVER_WORKER_THREADS] = { .type = NLA_U32, },
> > > >  };
> > > >  
> > > > +/* NFSD_CMD_VERSION_SET - do */
> > > > +static const struct nla_policy nfsd_version_set_nl_policy[NFSD_A_SERVER_VERSION_STATUS + 1] = {
> > > > +	[NFSD_A_SERVER_VERSION_MAJOR] = { .type = NLA_U32, },
> > > > +	[NFSD_A_SERVER_VERSION_MINOR] = { .type = NLA_U32, },
> > > > +	[NFSD_A_SERVER_VERSION_STATUS] = { .type = NLA_U8, },
> > > > +};
> > > > +
> > > >  /* Ops table for nfsd */
> > > >  static const struct genl_split_ops nfsd_nl_ops[] = {
> > > >  	{
> > > > @@ -36,6 +43,18 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
> > > >  		.doit	= nfsd_nl_threads_get_doit,
> > > >  		.flags	= GENL_CMD_CAP_DO,
> > > >  	},
> > > > +	{
> > > > +		.cmd		= NFSD_CMD_VERSION_SET,
> > > > +		.doit		= nfsd_nl_version_set_doit,
> > > > +		.policy		= nfsd_version_set_nl_policy,
> > > > +		.maxattr	= NFSD_A_SERVER_VERSION_STATUS,
> > > > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > > +	},
> > > > +	{
> > > > +		.cmd	= NFSD_CMD_VERSION_GET,
> > > > +		.dumpit	= nfsd_nl_version_get_dumpit,
> > > > +		.flags	= GENL_CMD_CAP_DUMP,
> > > > +	},
> > > >  };
> > > >  
> > > >  struct genl_family nfsd_nl_family __ro_after_init = {
> > > > diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> > > > index 4137fac477e4..7d203cec08e4 100644
> > > > --- a/fs/nfsd/netlink.h
> > > > +++ b/fs/nfsd/netlink.h
> > > > @@ -18,6 +18,9 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> > > >  				  struct netlink_callback *cb);
> > > >  int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info);
> > > >  int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info);
> > > > +int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info);
> > > > +int nfsd_nl_version_get_dumpit(struct sk_buff *skb,
> > > > +			       struct netlink_callback *cb);
> > > >  
> > > >  extern struct genl_family nfsd_nl_family;
> > > >  
> > > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > > index 130b3d937a79..f04430f79687 100644
> > > > --- a/fs/nfsd/nfsctl.c
> > > > +++ b/fs/nfsd/nfsctl.c
> > > > @@ -1757,6 +1757,111 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
> > > >  	return err;
> > > >  }
> > > >  
> > > > +/**
> > > > + * nfsd_nl_version_set_doit - enable/disable the provided nfs server version
> > > > + * @skb: reply buffer
> > > > + * @info: netlink metadata and command arguments
> > > > + *
> > > > + * Return 0 on success or a negative errno.
> > > > + */
> > > > +int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info)
> > > > +{
> > > > +	struct nfsd_net *nn = net_generic(genl_info_net(info), nfsd_net_id);
> > > > +	enum vers_op cmd;
> > > > +	u32 major, minor;
> > > > +	u8 status;
> > > > +	int ret;
> > > > +
> > > > +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_VERSION_MAJOR) ||
> > > > +	    GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_VERSION_MINOR) ||
> > > > +	    GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_VERSION_STATUS))
> > > > +		return -EINVAL;
> > > > +
> > > > +	major = nla_get_u32(info->attrs[NFSD_A_SERVER_VERSION_MAJOR]);
> > > > +	minor = nla_get_u32(info->attrs[NFSD_A_SERVER_VERSION_MINOR]);
> > > > +
> > > > +	status = nla_get_u32(info->attrs[NFSD_A_SERVER_VERSION_STATUS]);
> > > > +	cmd = !!status ? NFSD_SET : NFSD_CLEAR;
> > > > +
> > > > +	mutex_lock(&nfsd_mutex);
> > > > +	switch (major) {
> > > > +	case 4:
> > > > +		ret = nfsd_minorversion(nn, minor, cmd);
> > > > +		break;
> > > > +	case 2:
> > > > +	case 3:
> > > > +		if (!minor) {
> > > > +			ret = nfsd_vers(nn, major, cmd);
> > > > +			break;
> > > > +		}
> > > > +		fallthrough;
> > > > +	default:
> > > > +		ret = -EINVAL;
> > > > +		break;
> > > > +	}
> > > > +	mutex_unlock(&nfsd_mutex);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +/**
> > > > + * nfsd_nl_version_get_doit - Handle verion_get dumpit
> > > > + * @skb: reply buffer
> > > > + * @cb: netlink metadata and command arguments
> > > > + *
> > > > + * Returns the size of the reply or a negative errno.
> > > > + */
> > > > +int nfsd_nl_version_get_dumpit(struct sk_buff *skb,
> > > > +			       struct netlink_callback *cb)
> > > > +{
> > > > +	struct nfsd_net *nn = net_generic(sock_net(skb->sk), nfsd_net_id);
> > > > +	int i, ret = -ENOMEM;
> > > > +
> > > > +	mutex_lock(&nfsd_mutex);
> > > > +
> > > > +	for (i = 2; i <= 4; i++) {
> > > > +		int j;
> > > > +
> > > > +		if (i < cb->args[0]) /* already consumed */
> > > > +			continue;
> > > > +
> > > > +		if (!nfsd_vers(nn, i, NFSD_AVAIL))
> > > > +			continue;
> > > > +
> > > > +		for (j = 0; j <= NFSD_SUPPORTED_MINOR_VERSION; j++) {
> > > > +			void *hdr;
> > > > +
> > > > +			if (!nfsd_vers(nn, i, NFSD_TEST))
> > > > +				continue;
> > > > +
> > > > +			/* NFSv{2,3} does not support minor numbers */
> > > > +			if (i < 4 && j)
> > > > +				continue;
> > > > +
> > > > +			if (i == 4 && !nfsd_minorversion(nn, j, NFSD_TEST))
> > > > +				continue;
> > > > +
> > > > +			hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
> > > > +					  cb->nlh->nlmsg_seq, &nfsd_nl_family,
> > > > +					  0, NFSD_CMD_VERSION_GET);
> > > > +			if (!hdr)
> > > > +				goto out;
> > > > +
> > > > +			if (nla_put_u32(skb, NFSD_A_SERVER_VERSION_MAJOR, i) ||
> > > > +			    nla_put_u32(skb, NFSD_A_SERVER_VERSION_MINOR, j))
> > > > +				goto out;
> > > > +
> > > > +			genlmsg_end(skb, hdr);
> > > > +		}
> > > > +	}
> > > > +	cb->args[0] = i;
> > > > +	ret = skb->len;
> > > > +out:
> > > > +	mutex_unlock(&nfsd_mutex);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > >  /**
> > > >   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
> > > >   * @net: a freshly-created network namespace
> > > > diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
> > > > index 1b6fe1f9ed0e..1b3340f31baa 100644
> > > > --- a/include/uapi/linux/nfsd_netlink.h
> > > > +++ b/include/uapi/linux/nfsd_netlink.h
> > > > @@ -36,10 +36,21 @@ enum {
> > > >  	NFSD_A_SERVER_WORKER_MAX = (__NFSD_A_SERVER_WORKER_MAX - 1)
> > > >  };
> > > >  
> > > > +enum {
> > > > +	NFSD_A_SERVER_VERSION_MAJOR = 1,
> > > > +	NFSD_A_SERVER_VERSION_MINOR,
> > > > +	NFSD_A_SERVER_VERSION_STATUS,
> > > > +
> > > > +	__NFSD_A_SERVER_VERSION_MAX,
> > > > +	NFSD_A_SERVER_VERSION_MAX = (__NFSD_A_SERVER_VERSION_MAX - 1)
> > > > +};
> > > > +
> > > >  enum {
> > > >  	NFSD_CMD_RPC_STATUS_GET = 1,
> > > >  	NFSD_CMD_THREADS_SET,
> > > >  	NFSD_CMD_THREADS_GET,
> > > > +	NFSD_CMD_VERSION_SET,
> > > > +	NFSD_CMD_VERSION_GET,
> > > >  
> > > >  	__NFSD_CMD_MAX,
> > > >  	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
> > > > diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/generated/nfsd-user.c
> > > > index 9768328a7751..4cb71c3cd18d 100644
> > > > --- a/tools/net/ynl/generated/nfsd-user.c
> > > > +++ b/tools/net/ynl/generated/nfsd-user.c
> > > > @@ -17,6 +17,8 @@ static const char * const nfsd_op_strmap[] = {
> > > >  	[NFSD_CMD_RPC_STATUS_GET] = "rpc-status-get",
> > > >  	[NFSD_CMD_THREADS_SET] = "threads-set",
> > > >  	[NFSD_CMD_THREADS_GET] = "threads-get",
> > > > +	[NFSD_CMD_VERSION_SET] = "version-set",
> > > > +	[NFSD_CMD_VERSION_GET] = "version-get",
> > > >  };
> > > >  
> > > >  const char *nfsd_op_str(int op)
> > > > @@ -58,6 +60,17 @@ struct ynl_policy_nest nfsd_server_worker_nest = {
> > > >  	.table = nfsd_server_worker_policy,
> > > >  };
> > > >  
> > > > +struct ynl_policy_attr nfsd_server_version_policy[NFSD_A_SERVER_VERSION_MAX + 1] = {
> > > > +	[NFSD_A_SERVER_VERSION_MAJOR] = { .name = "major", .type = YNL_PT_U32, },
> > > > +	[NFSD_A_SERVER_VERSION_MINOR] = { .name = "minor", .type = YNL_PT_U32, },
> > > > +	[NFSD_A_SERVER_VERSION_STATUS] = { .name = "status", .type = YNL_PT_U8, },
> > > > +};
> > > > +
> > > > +struct ynl_policy_nest nfsd_server_version_nest = {
> > > > +	.max_attr = NFSD_A_SERVER_VERSION_MAX,
> > > > +	.table = nfsd_server_version_policy,
> > > > +};
> > > > +
> > > >  /* Common nested types */
> > > >  /* ============== NFSD_CMD_RPC_STATUS_GET ============== */
> > > >  /* NFSD_CMD_RPC_STATUS_GET - dump */
> > > > @@ -290,6 +303,74 @@ struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys)
> > > >  	return NULL;
> > > >  }
> > > >  
> > > > +/* ============== NFSD_CMD_VERSION_SET ============== */
> > > > +/* NFSD_CMD_VERSION_SET - do */
> > > > +void nfsd_version_set_req_free(struct nfsd_version_set_req *req)
> > > > +{
> > > > +	free(req);
> > > > +}
> > > > +
> > > > +int nfsd_version_set(struct ynl_sock *ys, struct nfsd_version_set_req *req)
> > > > +{
> > > > +	struct nlmsghdr *nlh;
> > > > +	int err;
> > > > +
> > > > +	nlh = ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_VERSION_SET, 1);
> > > > +	ys->req_policy = &nfsd_server_version_nest;
> > > > +
> > > > +	if (req->_present.major)
> > > > +		mnl_attr_put_u32(nlh, NFSD_A_SERVER_VERSION_MAJOR, req->major);
> > > > +	if (req->_present.minor)
> > > > +		mnl_attr_put_u32(nlh, NFSD_A_SERVER_VERSION_MINOR, req->minor);
> > > > +	if (req->_present.status)
> > > > +		mnl_attr_put_u8(nlh, NFSD_A_SERVER_VERSION_STATUS, req->status);
> > > > +
> > > > +	err = ynl_exec(ys, nlh, NULL);
> > > > +	if (err < 0)
> > > > +		return -1;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +/* ============== NFSD_CMD_VERSION_GET ============== */
> > > > +/* NFSD_CMD_VERSION_GET - dump */
> > > > +void nfsd_version_get_list_free(struct nfsd_version_get_list *rsp)
> > > > +{
> > > > +	struct nfsd_version_get_list *next = rsp;
> > > > +
> > > > +	while ((void *)next != YNL_LIST_END) {
> > > > +		rsp = next;
> > > > +		next = rsp->next;
> > > > +
> > > > +		free(rsp);
> > > > +	}
> > > > +}
> > > > +
> > > > +struct nfsd_version_get_list *nfsd_version_get_dump(struct ynl_sock *ys)
> > > > +{
> > > > +	struct ynl_dump_state yds = {};
> > > > +	struct nlmsghdr *nlh;
> > > > +	int err;
> > > > +
> > > > +	yds.ys = ys;
> > > > +	yds.alloc_sz = sizeof(struct nfsd_version_get_list);
> > > > +	yds.cb = nfsd_version_get_rsp_parse;
> > > > +	yds.rsp_cmd = NFSD_CMD_VERSION_GET;
> > > > +	yds.rsp_policy = &nfsd_server_version_nest;
> > > > +
> > > > +	nlh = ynl_gemsg_start_dump(ys, ys->family_id, NFSD_CMD_VERSION_GET, 1);
> > > > +
> > > > +	err = ynl_exec_dump(ys, nlh, &yds);
> > > > +	if (err < 0)
> > > > +		goto free_list;
> > > > +
> > > > +	return yds.first;
> > > > +
> > > > +free_list:
> > > > +	nfsd_version_get_list_free(yds.first);
> > > > +	return NULL;
> > > > +}
> > > > +
> > > >  const struct ynl_family ynl_nfsd_family =  {
> > > >  	.name		= "nfsd",
> > > >  };
> > > > diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/generated/nfsd-user.h
> > > > index e162a4f20d91..e61c5a9e46fb 100644
> > > > --- a/tools/net/ynl/generated/nfsd-user.h
> > > > +++ b/tools/net/ynl/generated/nfsd-user.h
> > > > @@ -111,4 +111,59 @@ void nfsd_threads_get_rsp_free(struct nfsd_threads_get_rsp *rsp);
> > > >   */
> > > >  struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys);
> > > >  
> > > > +/* ============== NFSD_CMD_VERSION_SET ============== */
> > > > +/* NFSD_CMD_VERSION_SET - do */
> > > > +struct nfsd_version_set_req {
> > > > +	struct {
> > > > +		__u32 major:1;
> > > > +		__u32 minor:1;
> > > > +		__u32 status:1;
> > > > +	} _present;
> > > > +
> > > > +	__u32 major;
> > > > +	__u32 minor;
> > > > +	__u8 status;
> > > > +};
> > > > +
> > > 
> > > This more or less mirrors how the "versions" file works today, but that
> > > interface is quite klunky.  We don't have a use case that requires that
> > > we do this piecemeal like this. I think we'd be better served with a
> > > more declarative interface that reconfigures the supported versions in
> > > one shot:
> > > 
> > > Instead of having "major,minor,status" and potentially having to call
> > > this command several times from userland, it seems like it would be
> > > nicer to just have userland send down a list "major,minor" that should
> > > be enabled, and then just let the kernel figure out whether to enable or
> > > disable each. An empty list could mean "disable everything".
> > > 
> > > That's simpler to reason out as an interface from userland too. Trying
> > > to keep track of the enabled and disabled versions and twiddle it is
> > > really tricky in rpc.nfsd today.
> > 
> > Jeff and Lorenzo, this sounds to me like a useful and narrow
> > improvement to this interface, one that should be implemented as
> > part of this patch series.
> 
> ack, I am fine with it, I will work on patch 2/3 and 3/3.
> @Chuck: am I suppose to respin patch 1/3 too?

I assumed there might be minor changes to 1/3 after Jakub's second
review, so I have not applied it yet. You can resend all three to
me.


> Regards,
> Lorenzo
> 
> > 
> > Ditto for Jeff's review comment on 3/3.
> > 
> > 
> > > > +static inline struct nfsd_version_set_req *nfsd_version_set_req_alloc(void)
> > > > +{
> > > > +	return calloc(1, sizeof(struct nfsd_version_set_req));
> > > > +}
> > > > +void nfsd_version_set_req_free(struct nfsd_version_set_req *req);
> > > > +
> > > > +static inline void
> > > > +nfsd_version_set_req_set_major(struct nfsd_version_set_req *req, __u32 major)
> > > > +{
> > > > +	req->_present.major = 1;
> > > > +	req->major = major;
> > > > +}
> > > > +static inline void
> > > > +nfsd_version_set_req_set_minor(struct nfsd_version_set_req *req, __u32 minor)
> > > > +{
> > > > +	req->_present.minor = 1;
> > > > +	req->minor = minor;
> > > > +}
> > > > +static inline void
> > > > +nfsd_version_set_req_set_status(struct nfsd_version_set_req *req, __u8 status)
> > > > +{
> > > > +	req->_present.status = 1;
> > > > +	req->status = status;
> > > > +}
> > > > +
> > > > +/*
> > > > + * enable/disable server version
> > > > + */
> > > > +int nfsd_version_set(struct ynl_sock *ys, struct nfsd_version_set_req *req);
> > > > +
> > > > +/* ============== NFSD_CMD_VERSION_GET ============== */
> > > > +/* NFSD_CMD_VERSION_GET - dump */
> > > > +struct nfsd_version_get_list {
> > > > +	struct nfsd_version_get_list *next;
> > > > +	struct nfsd_version_get_rsp obj __attribute__ ((aligned (8)));
> > > > +};
> > > > +
> > > > +void nfsd_version_get_list_free(struct nfsd_version_get_list *rsp);
> > > > +
> > > > +struct nfsd_version_get_list *nfsd_version_get_dump(struct ynl_sock *ys);
> > > > +
> > > >  #endif /* _LINUX_NFSD_GEN_H */
> > > 
> > > -- 
> > > Jeff Layton <jlayton@kernel.org>
> > > 
> > 
> > -- 
> > Chuck Lever



-- 
Chuck Lever

