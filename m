Return-Path: <linux-nfs+bounces-14606-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08299B8BA9E
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Sep 2025 02:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C777E518E
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Sep 2025 00:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305463C1F;
	Sat, 20 Sep 2025 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PDJmL1TN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021133.outbound.protection.outlook.com [52.101.62.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26D54409
	for <linux-nfs@vger.kernel.org>; Sat, 20 Sep 2025 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758326832; cv=fail; b=KS/2PXKAHLRjO4x9DqK8C+xGt1GUt5Oc7LGwhc5u5UnGGfJ+kWTa/Xms8PbGiUbJM7nOfrCv3pcDD1TKvAYVxq5Ovf16NlIaKMHiG+xynfSnMl7jY77ptsTp0hWn8ER1/K4AFL1cPnQUpyynV2h6HysWUitOIMVQUKpv+dBFwFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758326832; c=relaxed/simple;
	bh=7PaYRatIgHecRYbAUWukx7n5kyB3sD2MltEBGd+UGCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H34NYtWcrsX+0xUwpMhZqotnOExyYongDBifhj64Xj9uDw0J0Ue6s2Edb3PDjgGFbZIyx/85/9Q/TbTHMiQ1AlAYkFVUV18kHha4OfQbIFyR6D/5keZqqW+bnKr6E6IhySaelPdismOVssaT5fFcUKBJctFfmuAu7oln8TsTl4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PDJmL1TN; arc=fail smtp.client-ip=52.101.62.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFkQc2bBk3cvzh2aTt0PEtnN+q4rlFB7WUHq/GSF3cQhE26FmfvdB1QAeFa20Z/exvRWPgpK10VzQiOSFaZiM611UfuB9U4WR3eok158MOSFTtGvlBKQauhVf8oV5f4D//SlGwS3/lfFZ0LQCY5M+DSDXK40x4pteahOFg7ahAS9wKmeSQqfOwR84MABtVFYBXfh4WYDERdUk1Hpokkb5lmDqMiSz0gNq/yJ+m7haoQQFNGi1qgWGgZf/8t/v6HSKD9m9iL1vbAtU6GPPzgAYeGgTSakuJEBm+cxBYktNGs6d4Ev88RYU0rtXjs8R0WdlbpdBB3ZJsBvxuTgTO/zbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyJ9VDWMadYFh8hPobJ9k0cfyb/PlUldSVZ8eNW447Y=;
 b=hws+SH8TSdPkYEJLHIHVgYO7Q5YwaIQBJKpiAMI2BI7rt+7AQHGQ9AYW65AoquHW1c9fzZ59QZLuj1zaBvupplcFWru1ADJKk0yAyUnc3NbqBRCoBmDhr3awHuXVure34k/22DiuztReR5Is1ca85oDsWNDqUiDVqZ/vli8hR4GyW7bf5YRj4q1EpDMyVj+wgx+cX6ImqrjTmqBOk2CvMLBOW5e/flyXfsSmwt+Xed7IZ+dpPyOLOuWpqxTIKiiguXxAPkrn/ef+MPh+Z2/wvGyPksj/eDgF/CnoEIzYD8O2LwXRDVU5IS8uP70LVhYkRaYT/KvFfFX7P3OKiRS+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyJ9VDWMadYFh8hPobJ9k0cfyb/PlUldSVZ8eNW447Y=;
 b=PDJmL1TN3l8R76xSObVVgc1NIZ5HEWI6pC8Ay8125XcHvSGZGNBuwrcnjZxKBnjDPbW9VSOZXc1D51v8Eb3fRDQQvgfum3IQslTDBy7jJgjDctzHeS23l8FmDhihegewcwS4hW4YbbbBp0C0rlNd/BS+m1NNpyxQOaRd4OOpQOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from CH0PR13MB5236.namprd13.prod.outlook.com (2603:10b6:610:f4::15)
 by IA1PR13MB7374.namprd13.prod.outlook.com (2603:10b6:208:59f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Sat, 20 Sep
 2025 00:07:06 +0000
Received: from CH0PR13MB5236.namprd13.prod.outlook.com
 ([fe80::d42e:55a2:2232:6f17]) by CH0PR13MB5236.namprd13.prod.outlook.com
 ([fe80::d42e:55a2:2232:6f17%3]) with mapi id 15.20.9137.015; Sat, 20 Sep 2025
 00:07:06 +0000
Date: Fri, 19 Sep 2025 20:07:01 -0400
From: Mike Snitzer <snitzer@hammerspace.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 2/7] nfs/localio: avoid issuing misaligned IO using
 O_DIRECT
Message-ID: <aM3wJaW3_RwcmJip@hammerspace.com>
References: <20250919143631.44851-1-snitzer@kernel.org>
 <20250919143631.44851-3-snitzer@kernel.org>
 <2416a8b9683a37eeb7b29a6c0fb32b5cded4fe64.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2416a8b9683a37eeb7b29a6c0fb32b5cded4fe64.camel@kernel.org>
X-ClientProxiedBy: MN0P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::27) To CH0PR13MB5236.namprd13.prod.outlook.com
 (2603:10b6:610:f4::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR13MB5236:EE_|IA1PR13MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: de94a476-7036-4a9c-0418-08ddf7d9a233
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+VGdXQsuhki2/2fwgAoSkFzP5B9rVwrQt97oqYvpjKbpuLEloWvVCcJLZxN8?=
 =?us-ascii?Q?oNlZI2R2TJbjEsELI2VqFFZgiSuKHcf71/xfEHRZ0eA+RMx+QG3LotXIFMgN?=
 =?us-ascii?Q?HO6Ss1mzwaa2dHUhXBlg0k/FIeNXS73T/k7emn+vhhZE0GkgpWNXnk7rYGLN?=
 =?us-ascii?Q?bmMg0U3lAKcRKt2lh+alYBp+7YRl7KlQoa88eBQ6+k+0+c8+CNaxn9uNnHCI?=
 =?us-ascii?Q?sSeOxF39t8Evo96eRYa9We2LDIPNuD1ErJQjhtWSMPHNyY/VdRi3SuZzvKuO?=
 =?us-ascii?Q?rwZX4MtsC+NRuYC2Y4vdSjnx4LwVw5iMnwO83WsY1XTpixJEKDRQhob1C2FB?=
 =?us-ascii?Q?tiR1Yl6mAQMBcTwRy9d0WpRdJFqykUn23viK6xvlDCKbvNtqnPjzrrM+jqSe?=
 =?us-ascii?Q?PYLQVlnoPQV+kaHw7rpNoLXiZ3E+iIggyvlBOdREsG1eZH2TuvRMYsiZ6mrs?=
 =?us-ascii?Q?rXLnIWGa+Fu0G1Jyysd9qtA8CCvO8MxGp+FU39POTp6fS2I2/BQb7CUX3dNG?=
 =?us-ascii?Q?0/9kawIdB4qrZuBZ6piDfWD7LsG94LU73IYxBnSw/E2jvG3AMjMOmlkc6g1t?=
 =?us-ascii?Q?1g9x7IlZ4qFHcn9Lei7Zi24pQ6hAwqQ8dnFkE/Y+mGJ3VTw4qzjykeputnx0?=
 =?us-ascii?Q?psSvNvn5QnXeLqPK9UF0NsNesQt+sw/quXpZVC/N2cIPfeFzvLSNWCciNgqS?=
 =?us-ascii?Q?qb8IYa6cJTHxiTkQOyufvRUZj8NomRpqqW7dHYo7llB/5OwBjEbCjQxEa0e6?=
 =?us-ascii?Q?k/H6tlIXO6pKu2YJeK9a9IxYXa0DpCZ/lXjSi7Svi/grDb0MaeOf1O/BSrYT?=
 =?us-ascii?Q?gs0x8MuozP9xa7llT0wCeidYJLmLSzgezrqfnbql471qHmAjKv+H09jHkBxk?=
 =?us-ascii?Q?SG6wtTVn043tgTu/WgaUy5j7R329WWmpEx6Imt2XJx8ZZ60CJPlw3qxD+HzK?=
 =?us-ascii?Q?+TiKPrrZa5i0ZWarGME7vKOYe6efwpvNDstCJx+zl8NsO9L6/ATY2/PW1cwB?=
 =?us-ascii?Q?lvFZdG3aQkhvKFEDPGIqaPdzmgDaqdKQJ0OPEeLwKRRl/F1ZDuy05HL7zWQS?=
 =?us-ascii?Q?aMDKl5UPLAPFJ8YkgbwqIkb8Z2iXgpvvmIr1PrpmwEWHWF3d4ybXtyLeuxZz?=
 =?us-ascii?Q?DbRy5EPyj4IMcxNucgyGHYAUMkHY4cfam4xfpt4Zy9DspazaM7JlKGQhjRyT?=
 =?us-ascii?Q?SCqVIgP3jOnSngtQftQDM7OwDN6yTUK1Z1Q/wC9NQOwDYygYhVc7NimQMcI9?=
 =?us-ascii?Q?LdqZHlt/rFqu99xWq8Z1sO5gLH6r9cSA8VL6KLLAjU2L0jHQNzYl80i0S3YC?=
 =?us-ascii?Q?hKJ3tQtHwj3FE+3g9vGJMkL2EUDuCrIqEdP8g29wqPFlP2WyOKvIqUFFDdU8?=
 =?us-ascii?Q?3n1eAfBR/H07W3lMyEgwRfENJBdAg8r5wShR/8kphQc3dhch3UaVAI0chx8g?=
 =?us-ascii?Q?vV5/40YzveU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5236.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fGxTX2BLApmmSAifeeZzp/bTpX8cdzDeEfzHwHFsEPvWaTIibe5rEWO7ynT+?=
 =?us-ascii?Q?MG4NgG7XRHdnnlXXoKkPBm6ryH7iLVLvvfaBxng4kri9RsVGyWgabcBjVQLm?=
 =?us-ascii?Q?D+ipxQ50XMhsA/ffx3fj+nbeDhUKwEgojXcb9OsYF1PwbSv2SfWzUhvVNxZp?=
 =?us-ascii?Q?1VSOjB1TLvWCIUywA6NjNyJO8LY1IK/tC1+eSfjht/eVvwuVHZJmO0B1drR/?=
 =?us-ascii?Q?B/TdJ7BQamwdeDDT9JPNrYahK4OUY2Bkge75rsBpzt5ZPVEY88M3sGEbeCek?=
 =?us-ascii?Q?Y3ZefD/fzbuvrT1bGGWyO2tZbzly/UGRAnHOF06zzE5u1yYxMYmOfv3aoVGf?=
 =?us-ascii?Q?xGC3kP/HgntOnn6CDc/sHxJZ+vEtHTZdOuENVZSXCY8AbkLCEKXml4GIbmaU?=
 =?us-ascii?Q?zFN+TxAme7xIhXEoJ4/Zm8/cFq7JEFMVjZXRMqIiWURUPKL4482MBsvDPD+q?=
 =?us-ascii?Q?AFjmcfDhoHM5Ns+mvuzy2vkoooX7RT2Pyw9D8BazE3HLrsnoZGseWXE1+pIi?=
 =?us-ascii?Q?rIXcDWgE2O/7UW0nd1eoXQnOR5OAwnUfrghlvUB2BToUpq296CwkJzQE45VJ?=
 =?us-ascii?Q?pqLSGgl9O/+/6+XwjNKpMKONocPRUt637mmncys0dX8VLR/SIv+A4Cu5rTAH?=
 =?us-ascii?Q?2QvJYa8PxReLCBDlXAqKTmYc5b5LAss6vVkbV4KnMZU0Wol0XMW6D+hEhBBX?=
 =?us-ascii?Q?hRzMA2K9tflnoDAyNV3izOLCa8fYCaX7UUF8tKJoSk1fHB1d8dBwlk66UcBm?=
 =?us-ascii?Q?Oemhi+1Sp8oCxvzuP9nPK8CC67PiL07SNnCCy3hQcA45XuOx4tAeg3xETZ7Q?=
 =?us-ascii?Q?saF4YfFZt4LFhhB+cR52bk7mk1ZznKj4QtQ2ra9zSBDVkjyNNDXDzAGLz1dl?=
 =?us-ascii?Q?odCqTBHpcmyk6e6U+aHfqaq+LAn7ONzMoRnbzhkiFjFJUV6f+ziFBDY9b86O?=
 =?us-ascii?Q?/yDeAZk/eQBy5xyyzrptXi4b9mbKAt2yrmFJdKTMV0RatlIBaXBRjUGhDByQ?=
 =?us-ascii?Q?lS9DyQrWBmrsfcWPCfYcwWPbbMIZ4kiIRZcv21zNb49S08m1UxfGcTPIWFti?=
 =?us-ascii?Q?2A5VcpEpzgMarwtbsHOYs8B1jzwXeU+wob/3kOWjASeOsvtNNhQJWrXLFYZe?=
 =?us-ascii?Q?i+0v0dSUij1M6fQZGOoDONi/G8LapiREHrD8bvtwGyTzNDqCTV95gWJEbQj3?=
 =?us-ascii?Q?dUGDNqklqICeIbXyH089OY4lViuAlQZJNMz6mLiOaTUnOdIC+5pR/Ea6SfE7?=
 =?us-ascii?Q?Dss4kxIzqSwn/bkOZR/gFad94CLJZNbNI3FgHR2SGz/FlXBJdtjMQ9gOU6EU?=
 =?us-ascii?Q?gUiAZKIxarDyhWihpxgLIcqfd3XAKzUHOdS7gQP+fVWdaEBc3AeSgb46HItq?=
 =?us-ascii?Q?tEgqqrFlYocQl95a3PBFevz4WdlyQgd2qczT3BN2T1w1SBAVLG9H23EwdcJp?=
 =?us-ascii?Q?WcMFdqI/pbcVVqhPtc5PeXCre0Okv3d4eWJLoZK04Xakb014qLkKKmarM8ib?=
 =?us-ascii?Q?k7TaAHm7ZzRiG9QkPyFe6iDe+Aqkgjjm1ql7XvsqZJbJKCJxKAyEkXTJ35ZZ?=
 =?us-ascii?Q?bmsEYoTr9ZFggqp319ay37dSFrxqdfYOUNPfifA5jEmIQHaO4BZh8V/PQhiD?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de94a476-7036-4a9c-0418-08ddf7d9a233
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5236.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2025 00:07:06.1307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcWIsWflpKDlY0hADbLvbZrYp9Zp0LGCkHYGBwobwqtJegoEF/Sq/veVpXdnw/T6P0P03VwwqJYcX8mPVPO4ly9711Z1M3PXgZjzQLlLmxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR13MB7374

On Fri, Sep 19, 2025 at 01:34:09PM -0400, Jeff Layton wrote:
> On Fri, 2025-09-19 at 10:36 -0400, Mike Snitzer wrote:
> > Add nfsd_file_dio_alignment and use it to avoid issuing misaligned IO
> > using O_DIRECT. Any misaligned DIO falls back to using buffered IO.
> > 
> > Because misaligned DIO is now handled safely, remove the nfs modparam
> > 'localio_O_DIRECT_semantics' that was added to require users opt-in to
> > the requirement that all O_DIRECT be properly DIO-aligned.
> > 
> > Also, introduce nfs_iov_iter_aligned_bvec() which is a variant of
> > iov_iter_aligned_bvec() that also verifies the offset associated with
> > an iov_iter is DIO-aligned.  NOTE: in a parallel effort,
> > iov_iter_aligned_bvec() is being removed along with
> > iov_iter_is_aligned().
> > 
> > Lastly, add pr_info_ratelimited if underlying filesystem returns
> > -EINVAL because it was made to try O_DIRECT for IO that is not
> > DIO-aligned (shouldn't happen, so its best to be louder if it does).
> > 
> > Fixes: 3feec68563d ("nfs/localio: add direct IO enablement with sync and async IO support")
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfs/localio.c           | 65 ++++++++++++++++++++++++++++++++------
> >  fs/nfsd/localio.c          | 11 +++++++
> >  include/linux/nfslocalio.h |  2 ++
> >  3 files changed, 68 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> > index 42ea50d42c995..b165922e5cb65 100644
> > --- a/fs/nfs/localio.c
> > +++ b/fs/nfs/localio.c
> > @@ -49,11 +49,6 @@ struct nfs_local_fsync_ctx {
> >  static bool localio_enabled __read_mostly = true;
> >  module_param(localio_enabled, bool, 0644);
> >  
> > -static bool localio_O_DIRECT_semantics __read_mostly = false;
> > -module_param(localio_O_DIRECT_semantics, bool, 0644);
> > -MODULE_PARM_DESC(localio_O_DIRECT_semantics,
> > -		 "LOCALIO will use O_DIRECT semantics to filesystem.");
> > -
> 
> Given how new this is, do we want to completely eliminate control by
> the admin? It might be better to just flip the default first. At least
> then if someone hits an issue with this the still have the ability to
> turn it off?

Sorry for the long response:

I think you'll find localio_O_DIRECT_semantics doesn't do what you
think, not sure.  It wasn't actually making misaligned DIO safe, it
avoided the issue simply by disallowing DIO to be used by LOCALIO.

localio_O_DIRECT_semantics defaulted to N, which caused all DIO
handled by LOCALIO to use buffered IO. So an alias for it could've
been "localio_O_DIRECT_support_that_will_EINVAL_if_not_DIO_aligned",
and we trust you are fine with misaligned DIO making XFS or ext4
return -EINVAL otherwise.

But if an admin used Y to opt-in to make use of DIO with LOCALIO, we'd
allow them to expose themselves to -EINVAL errors that should no
longer happen with this patch applied.

The localio_O_DIRECT_semantics modparam was added precisely because
there wasn't any LOCALIO code handling misaligned DIO.

So by now removing this modparam I'm saying: LOCALIO has misaligned
DIO support and will fallback to buffered IO as needed, so no need to
force a user to set localio_O_DIRECT_semantics=Y anymore.

But, say we kept it, it'd take work for localio_O_DIRECT_semantics=Y
to support DIO but then disable the new LOCALIO default of handling
misaligned DIO.

I really would like to avoid the extra branch needed to even check
that.  The point of this effort is to make sure LOCALIO's DIO handling
works and is as efficient as possible.

If there is some hypothetical problem with LOCALIO's new ODIRECT
handling code (after this or all patches in this series applied) then:
1) a code change is needed
2) simply disabling LOCALIO entirely is probably the best thing to do
   (using nfs.ko modparam localio_enabled=N) if you cannot stop your
   application from using the O_DIRECT open flag.

> >  static inline bool nfs_client_is_local(const struct nfs_client *clp)
> >  {
> >  	return !!rcu_access_pointer(clp->cl_uuid.net);
> > @@ -322,12 +317,9 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
> >  		return NULL;
> >  	}
> >  
> > -	if (localio_O_DIRECT_semantics &&
> > -	    test_bit(NFS_IOHDR_ODIRECT, &hdr->flags)) {
> > -		iocb->kiocb.ki_filp = file;
> > +	init_sync_kiocb(&iocb->kiocb, file);
> > +	if (test_bit(NFS_IOHDR_ODIRECT, &hdr->flags))
> >  		iocb->kiocb.ki_flags = IOCB_DIRECT;
> > -	} else
> > -		init_sync_kiocb(&iocb->kiocb, file);
> >  
> >  	iocb->kiocb.ki_pos = hdr->args.offset;
> >  	iocb->hdr = hdr;
> > @@ -337,6 +329,30 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
> >  	return iocb;
> >  }
> >  
> > +static bool nfs_iov_iter_aligned_bvec(const struct iov_iter *i,
> > +		loff_t offset, unsigned int addr_mask, unsigned int len_mask)
> > +{
> > +	const struct bio_vec *bvec = i->bvec;
> > +	size_t skip = i->iov_offset;
> > +	size_t size = i->count;
> > +
> > +	if ((offset | size) & len_mask)
> > +		return false;
> > +	do {
> > +		size_t len = bvec->bv_len;
> > +
> > +		if (len > size)
> > +			len = size;
> > +		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
> > +			return false;
> > +		bvec++;
> > +		size -= len;
> > +		skip = 0;
> > +	} while (size);
> > +
> > +	return true;
> > +}
> > +
> >  static void
> >  nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
> >  {
> > @@ -346,6 +362,25 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
> >  		      hdr->args.count + hdr->args.pgbase);
> >  	if (hdr->args.pgbase != 0)
> >  		iov_iter_advance(i, hdr->args.pgbase);
> > +
> > +	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> > +		u32 nf_dio_mem_align, nf_dio_offset_align, nf_dio_read_offset_align;
> > +		/* Verify the IO is DIO-aligned as required */
> > +		nfs_to->nfsd_file_dio_alignment(iocb->localio, &nf_dio_mem_align,
> > +						&nf_dio_offset_align,
> > +						&nf_dio_read_offset_align);
> > +		if (dir == READ)
> > +			nf_dio_offset_align = nf_dio_read_offset_align;
> > +
> > +		if (nf_dio_mem_align && nf_dio_offset_align &&
> > +		    nfs_iov_iter_aligned_bvec(i, hdr->args.offset,
> > +					      nf_dio_mem_align - 1,
> > +					      nf_dio_offset_align - 1))
> > +			return; /* is DIO-aligned */
> > +
> > +		/* Fallback to using buffered for this misaligned IO */
> > +		iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
> > +	}
> >  }
> >  
> >  static void
> > @@ -406,6 +441,11 @@ nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
> >  	struct nfs_pgio_header *hdr = iocb->hdr;
> >  	struct file *filp = iocb->kiocb.ki_filp;
> >  
> > +	if ((iocb->kiocb.ki_flags & IOCB_DIRECT) && status == -EINVAL) {
> > +		/* Underlying FS will return -EINVAL if misaligned DIO is attempted. */
> > +		pr_info_ratelimited("nfs: Unexpected direct I/O read alignment failure\n");
> 
> nit: these pr_info messages could be more useful. Maybe print the
> device+inode numbers, and info about the I/O that was attempted?

I followed what Chuck established in nfsd_direct_read(), see:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=kernel-6.12.24/nfsd-testing-snitm&id=962238b5d62714d1580bcae616956ad4afe57088

But that overly generic pr_info offers a major clue that it
makes sense to enable the "nfs_local_dio_misaligned" tracepoint that I
added to provide logging in Patch 6 of this patchset.

> 
> > +	}
> > +
> >  	nfs_local_pgio_done(hdr, status);
> >  
> >  	/*
> > @@ -598,6 +638,11 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
> >  
> >  	dprintk("%s: wrote %ld bytes.\n", __func__, status > 0 ? status : 0);
> >  
> > +	if ((iocb->kiocb.ki_flags & IOCB_DIRECT) && status == -EINVAL) {
> > +		/* Underlying FS will return -EINVAL if misaligned DIO is attempted. */
> > +		pr_info_ratelimited("nfs: Unexpected direct I/O write alignment failure\n");
> > +	}
> > +
> >  	/* Handle short writes as if they are ENOSPC */
> >  	if (status > 0 && status < hdr->args.count) {
> >  		hdr->mds_offset += status;
> > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > index 269fa9391dc46..be710d809a3ba 100644
> > --- a/fs/nfsd/localio.c
> > +++ b/fs/nfsd/localio.c
> > @@ -117,12 +117,23 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
> >  	return localio;
> >  }
> >  
> > +static void nfsd_file_dio_alignment(struct nfsd_file *nf,
> > +				    u32 *nf_dio_mem_align,
> > +				    u32 *nf_dio_offset_align,
> > +				    u32 *nf_dio_read_offset_align)
> > +{
> > +	*nf_dio_mem_align = nf->nf_dio_mem_align;
> > +	*nf_dio_offset_align = nf->nf_dio_offset_align;
> > +	*nf_dio_read_offset_align = nf->nf_dio_read_offset_align;
> > +}
> > +
> >  static const struct nfsd_localio_operations nfsd_localio_ops = {
> >  	.nfsd_net_try_get  = nfsd_net_try_get,
> >  	.nfsd_net_put  = nfsd_net_put,
> >  	.nfsd_open_local_fh = nfsd_open_local_fh,
> >  	.nfsd_file_put_local = nfsd_file_put_local,
> >  	.nfsd_file_file = nfsd_file_file,
> > +	.nfsd_file_dio_alignment = nfsd_file_dio_alignment,
> >  };
> >  
> >  void nfsd_localio_ops_init(void)
> > diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> > index 59ea90bd136b6..3d91043254e64 100644
> > --- a/include/linux/nfslocalio.h
> > +++ b/include/linux/nfslocalio.h
> > @@ -64,6 +64,8 @@ struct nfsd_localio_operations {
> >  						const fmode_t);
> >  	struct net *(*nfsd_file_put_local)(struct nfsd_file __rcu **);
> >  	struct file *(*nfsd_file_file)(struct nfsd_file *);
> > +	void (*nfsd_file_dio_alignment)(struct nfsd_file *,
> > +					u32 *, u32 *, u32 *);
> >  } ____cacheline_aligned;
> >  
> >  extern void nfsd_localio_ops_init(void);
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

