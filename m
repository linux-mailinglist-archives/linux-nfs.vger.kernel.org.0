Return-Path: <linux-nfs+bounces-13374-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E44FFB18310
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 16:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D23B3AC447
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 14:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5AA231856;
	Fri,  1 Aug 2025 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PSIsFgI0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923282E371F;
	Fri,  1 Aug 2025 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754056868; cv=fail; b=JMkeYAZpIAneQoRHa0N2BomfBjr/HRNBOw4Cz11E69cew41j6nj8Hf7ao4s319jAjD9cLGkJFQ7gKzqolOJRIAedq6JWiUKKTjaZ5jdEWwlLKGqqBUlXBBnamLGaSm4LjIxuSW0FoEKFn6tUsExPvzfoVc2HYrqz4EY72Fh4Pg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754056868; c=relaxed/simple;
	bh=Rt/M3svWgTjCDi1RQUj3qb7LyI/mcYjTVEYAqEdno7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pxrx4VKWNY8p48d5jQlFYSzbDL2FESVRsm9ZuER5i6ERBo6Y4dZFuSy7dqEDZl1uQRpiGCvn5NAw0SeJY+zMA4yqHpmqII4pZ1sMxHG+dcsCA1ADiflLCMByrTVXfLcKazM/rq8FMk0doS+U6a8MagBjrc0AtOpH79XuYrZyl0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PSIsFgI0; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvoA4bhZeEZewlWFgKNhlpxMveYbfubxb7ReJq07qlOcWuUzvTCdbRVlK/TegWOdVgR0BMqGeRCJkdscK+jGvLFK8yjoVF3VcX63otoDEm1HBUAHYYV0SQvPHWuupCEW9jtYqcd/wYvOsf2OYVusE7X4rnYJgDu7iZCpvEes0fAHhTJqmgV8bOhU4JriwqITPM/cLh41kpFPQgXxZb0VHVt8rCJnXCwyJKYAvpo2TVca2pPufrXSb5qjlkqXOW4X0at/9ycfTIwLpaZUWaCbDaI4IGUMh4y+2xVVQcGga1dlw5FyZpNLrGWl80c2RKrg+UevQYeAjXXja4bZpupNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rt/M3svWgTjCDi1RQUj3qb7LyI/mcYjTVEYAqEdno7U=;
 b=DFwmKqIVQAfaxy2jycbo25zgkJj0nmdhN9X9fZ+IhE61s1J7/GBrGumkSVio5bhezuoSxe8hNIVvnVucHhrxJCqbgTTMySLXz3533rqAGVUnyAyiXo4KlTVoGreWrrSsctfD2KAt9ZPgyfaNt/UsvoBABI4sJWia/A45FipvRMpBXGciJ9Jd0nNAZ0gyARTS/sr44pxM3lPqWs137vzskWgHcRctA30o13NnVacCLrv9G023UbStODykWaAkW5WniMF32ydQ1VSN17kP5rS/PktR2qjtd+79zkNCvyj6DIlcxOdujsFAAJ9vk7DdLt2F79OzK5Mw8Difj19YdPUi5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rt/M3svWgTjCDi1RQUj3qb7LyI/mcYjTVEYAqEdno7U=;
 b=PSIsFgI01jAoPjZquNgONb4yDHpG2Knko8cNfxBOLSJsIHKiGgRA295ICK3zIPXHo0B4iKHnUEd/yEBobrmnAqfvhrT5ntL29zfkQLH9usVmDeUDM6ZqsEdehRVRQPguctFrIzBMLQwFMuuyZhpw38M2Wyv4lO5guZ1OGUBm0hBvGz3MrjSijFJ6bH8aBQPkCrl7jTzr6jGgm5cX6+koRdKpFUlW08PQLIqUbkEuKwvknAVbbA+tC74dcYUPUaTu1UtaYUXJWsa1hfO9fMBSf3OxUYHiRCfPXxzLAbJBGNhLSdB+x3KPxlu3JT5zr+tLvngwAKApxrfJFW8lalXQnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 14:01:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8989.011; Fri, 1 Aug 2025
 14:01:03 +0000
Date: Fri, 1 Aug 2025 11:00:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Tigran A . Aivazian" <aivazian.tigran@gmail.com>,
	Kees Cook <kees@kernel.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	David Woodhouse <dwmw2@infradead.org>,
	Dave Kleikamp <shaggy@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Bob Copeland <me@bobcopeland.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
	linux-aio@kvack.org, linux-unionfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-mm@kvack.org,
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
	jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH 00/10] convert the majority of file systems to
 mmap_prepare
Message-ID: <20250801140057.GA245321@nvidia.com>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: YT4PR01CA0309.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a3ddb5a-3da4-46ed-7081-08ddd103d741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DMrOhVjU67wzqjkrBUc9l9eVXkEZ0+/D6Wi4WgYPCAHr1F6rz2zgiUeXGuhh?=
 =?us-ascii?Q?bHKesdwGP7BfkcDiwsAkH3T+w3rmp9N3ZWFC1kdLPbxSNcnYf5VUvEHnh7TE?=
 =?us-ascii?Q?9Y+TlHJI2SwPFgZOwnRL4WyLGehRyzR6bbFctvy10Kj9/zv3R4PC1wljH9A4?=
 =?us-ascii?Q?Amoup3LHIIeDnaenxPkjvF5CInxyPKEFzxjFjHdIELeiIBn5m7L1bvjz/89h?=
 =?us-ascii?Q?2RXzyAH5ryUYaMWkugJAxd2ySRK/IHHiDQ8KrCw5TzhdXOzM8Bkt7Q2HVVpn?=
 =?us-ascii?Q?qfSgPDCZzk7gx3IS5jpAP+361fQXAeWZyleKcMgWnmIihBdjDBvojpTorAe5?=
 =?us-ascii?Q?Tbg9VanIquidVZhGiTXq44dV0rz7r+gR5o1X2KrIFsqzFRPZmHLU8uD4ZNHa?=
 =?us-ascii?Q?qb4E1xRp1Xy6aqRRSQKXUgNTOCNLMUV7kyVdZRw7v4LNuY3aerl+Kw91MRto?=
 =?us-ascii?Q?d8x7Loien8+rWr7ZpKFEgG9EPQRjKzOxGEOBH3q1/ADnpChf/J/ALHpgupwr?=
 =?us-ascii?Q?gtxsDVraxhsSBMKjrOdTSavEWWh7y25IMGatW4SEkXehRobKLPw9TvBCsilK?=
 =?us-ascii?Q?y4eyWGbX0HLhH2VnzHaKgL2wQbRhmDKJyNPvtJ8jK9IFqRPEpG1JdPZekpnY?=
 =?us-ascii?Q?QXxVD3ZlCGNQT3taJKfu39kNM9n8jyAUlB61ImhfZomlkhrwMqNHXn6hJN3K?=
 =?us-ascii?Q?OP4/+VxPYRS2JMlj0GMrf01sI3B4hVFMv+2dhNfK3rRMrnqGUkVj0FHUNB96?=
 =?us-ascii?Q?YfmgxXl2tMdQFLKSjnh+B7GSQ9gAgXQaY1Xl5H3t+IEIQzLqRY8FF4sayM7I?=
 =?us-ascii?Q?2VF88TGph2/KAy0m4CPHa7oPsmsB0MnT7qeUIPc7kvGE3NKAL8xxqp2PH/Sq?=
 =?us-ascii?Q?1XRbte2/cPyhzjaJw9ZlgiH1wzkyQ1kDU/nipov2OqdF4MfXsfoS9Q4sFiJk?=
 =?us-ascii?Q?xa6L3LvG9ddLYTuUmur48iWDbh29QRLydRa4qaxk1WWI5r02+VpP2CEs0mGA?=
 =?us-ascii?Q?4/zWDfh41yW+DaBP/XPXC4wnMZ2UKdkc1ErU8oEmp41pIahv/mdJsGDhsOq9?=
 =?us-ascii?Q?WMJnQQUxpXb3/63iOV3BpHmlQoAiuh9tGBmsj1P/lTfGm7V6HtYi5+Nyo1JP?=
 =?us-ascii?Q?2qGvOEmLML/LvHuZv96Jt2j+JgCTpjfcEM5UlkmlpUukzdhblM+jvFXyS9hM?=
 =?us-ascii?Q?rQbfi1l/Z2nHJ/Z1fX0kq+k/jvKnEN3d1EW7WmvOT678/Ji4AU+qC3WWLPBT?=
 =?us-ascii?Q?Yutos8uESA3nxgmWyC/GNUOfctZcUJd/pncGWvNKuLE3C/fmk43o5gQZf25B?=
 =?us-ascii?Q?4YJ/FqKVy2Ez858FWMmysXs65pJIV0C+0kL53MQdJgYP1Iw48KsQNj47t54O?=
 =?us-ascii?Q?lFur9zLzm046YuzNzltjtGpcPPA8QoMXoNGb3+Qpg4mVjNJj0OwXCXx5vM4W?=
 =?us-ascii?Q?+RVvMnyxndk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hMUddmTaRFMyCibocSP07+b0aOshRc7yYilKjp3lsq0fykw1laPZVO6k8zQu?=
 =?us-ascii?Q?c6t/gQfz8hbRNl3OHgEVXTh32pju69RvBLfR/qMDE0DivO8pTX5X7M243szv?=
 =?us-ascii?Q?0NX2W5X/NLHxpjI+ZkGVzA7SZduy+etTGDP3xE6ua5wWeu+g77ZjhPeEzv26?=
 =?us-ascii?Q?kQFe4bE6+CvCoqJLQHD3oyJa8rehLE24QnSt7J0HBLMt5mPo1OBmjDDTCg0w?=
 =?us-ascii?Q?T6YdCT756jetHbwwgYLoXGSnhNFAzU2qm1984hD6V5QfrrcGslkzkJ3fMBeZ?=
 =?us-ascii?Q?xOcXsrU/nuTAaxFPNGBjdhf1WQudbMkcmPDaWC3ov5qyVs7Wjptm2ZYfmnuE?=
 =?us-ascii?Q?GKpX7oAgaYMuOFV06PtuEYAINGsHroz6JxdOIZazEJ3NkuCQ5HCbb6qGAc+7?=
 =?us-ascii?Q?/uf5h+9dQcQ9LgWmStq0ZOqSfbC66S7+g4kT4mB9to/7SbjNeJdyme1lvija?=
 =?us-ascii?Q?IgJkuqhN74NBWBtH2dCZjAyR+ibySxUqXSf7jjffduu6uC97QZMY79G0nLvJ?=
 =?us-ascii?Q?/9JSPvqALPQrTOQY280DSA4XlV7rdtyPZNba7C9QZdkESSeZG8Pja9id+7BA?=
 =?us-ascii?Q?Hcm/Dqv4LcQM9S6A0Wx2tmQquVq4RSHcdPWLG4g8SvHynI53t5DvhxDM1Dd7?=
 =?us-ascii?Q?ziMu1MlBcgHjR/ArqiZfEdJYKNZZQIHF/dNn+0HXTnIxzCv+lIGVFz+HEGGE?=
 =?us-ascii?Q?gE4MGIrWBgVCO9GnPbSKFgxoXYzFJXCWOEFTVdI9wsJWrUSL+55NZqOv8Yn9?=
 =?us-ascii?Q?Dyn9V3+KSehwlKmt81uRf8X8bl71FlFTrAjxHY8SlJlKU0q+as5O1+nXYCif?=
 =?us-ascii?Q?ur4XydwYsZKJERViPy/hFYmva9zEQKu+owU4iQdJFCP5Ahw9SkV755TRvqHL?=
 =?us-ascii?Q?tmPpgWqZ45OpKHKnBKvnu4/ekzZugcjBBGDG+FXdyMeYfq4ordTBRf4LyO2e?=
 =?us-ascii?Q?0VnHgbTldQC/kdsZPQqN87yWhVJW6Ei6i27GJpUEcWRYE0ljaD40ctSR9QBs?=
 =?us-ascii?Q?n9Xdz6+Vdxsu/2LAOmH6PdxKh2kqRLP3o1tsYrluCFbt9NA/SlFmx1BYissW?=
 =?us-ascii?Q?fXrpphbLTATE/uRP09J7KXaBe6pH4ufBCY+nfLAoQGgpDXBG2hlxggI6yNZp?=
 =?us-ascii?Q?Moq/vpGehxuvG+z0XG/PjSgLuxkEXBiOIZwmwxVXqsajiqOuLqdmnsb+exlT?=
 =?us-ascii?Q?PmaQAv29yNUwOEnZlED2TnXqfcx0vFFCdLa027ivFdhSE1eIkpuLhmOs9CXC?=
 =?us-ascii?Q?TjjNWyCrqdiHR8/T1acCOyVxTpbLy4vwb4f56AGhSm6m+2KS9lACn39Uimyr?=
 =?us-ascii?Q?yP1MTkLn++HgbpLiGTKEXUi51EJlBawoxDu7teFGwVfNLFHe0bT4JWFrZJNl?=
 =?us-ascii?Q?tjz8Jz8dq/c04L7OxdP861fohdGcGPbgtZBU482FGgLgNP4lBc8B5T6QBt8H?=
 =?us-ascii?Q?EOov+HdqOKkWJlRMoqygvOsVRT0bEqDREWvDW/h1MigOEOsYvdZiT5vgpn5N?=
 =?us-ascii?Q?VIkDg9ZL8vHugqvs+2TLSY55LkvuTz7VPC56Dz9VRoXMKTX4nH4mFWESQ/Av?=
 =?us-ascii?Q?bPYSEl/ftfkJeJxkVwM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3ddb5a-3da4-46ed-7081-08ddd103d741
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 14:00:58.5324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v98ANgD/PTWLentAZ3Ru4Pk6xjLTn0ZKxMq/ka65h6zomjl8gbh+qcAlIi24SW3A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428

On Mon, Jun 16, 2025 at 08:33:19PM +0100, Lorenzo Stoakes wrote:

> The intent is to gradually deprecate f_op->mmap, and in that vein this
> series coverts the majority of file systems to using f_op->mmap_prepare.

I saw this on lwn and just wanted to give a little bit of thought on
this topic..

It looks to me like we need some more infrastructure to convert
anything that uses remap_pfn/etc in the mmap() callback

I would like to suggest we add a vma->prepopulate() callback which is
where the remap_pfn should go. Once the VMA is finalized and fully
operational the vma_ops have the opportunity to prepopulate any PTEs.

This could then actually be locked properly so it is safe with
concurrent unmap_mapping_range() (current mmap callback is not safe)

Jason

