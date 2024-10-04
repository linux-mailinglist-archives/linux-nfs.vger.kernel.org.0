Return-Path: <linux-nfs+bounces-6866-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A094A990A38
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Oct 2024 19:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C432818A8
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Oct 2024 17:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA931D9A6D;
	Fri,  4 Oct 2024 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SNAD6Ot6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EvUOcPeg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003141D9A5E
	for <linux-nfs@vger.kernel.org>; Fri,  4 Oct 2024 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063312; cv=fail; b=ApT2s8yLkIw9d1fMwUu1ZOO2FNeQ62VXmqUriGaZbYG5CyZUMVOUSArIr2xS7hFeejziA8GkJ8dJVsC4YYJLvlnuYe4V60prcrBG7hGsxVJvSURZfGBmmlz/DLp11Eaz0s+YXN4z54GYc/Xa0vo5qL78j0hRRvOrasD6DgnXXFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063312; c=relaxed/simple;
	bh=/w1kqsfd94Wzt/Lf6rme1D22GN0dDmFHgAPFakU2udo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MYaBhC4wA7Z7pXGsIP2t6Xgh1pVy8hEjdUafQI2Sfjcfd2zgcnupX0uJQ7sxsfoCi1PcxbmzFTATvLUrKv64Q90EboQWebcQx6vHx9ee7rV6P3TMhHJ4WV+84smK5oYrEVJZVwtj4kQWVdsm2KAky0Rve1A6mZpvzAL5lJsf0tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SNAD6Ot6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EvUOcPeg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494Gfwo5031820;
	Fri, 4 Oct 2024 17:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=1rwR2GlWZjip3Hs
	MPnkInS0KA2XaPyBnNIBW6/7n0Mg=; b=SNAD6Ot6W90QpPiekjOnApWLSSyDIP3
	Q3ZUeIWfAo63S1JkNntKdrQhCvQNhb0VQN1nr9tfaZf2nY6HShTNfBU4y6eYibVd
	/21Y0tzAdkRNzsgh7wVoPbtfE7Mqgni5UKvOsPzjitDwxG1Lp9uotx5EGb/nsgug
	hNBIdzxHdnO4zS9ZXyFltm8MWGecLpyV9G6eBUkdN95/BGqqN6Pkdd9Lcfx38qTo
	DEbKutu2vRlxQn9e/ZUqowlW/yJbccVsnoC1EWvfF0hyAvv1DgajIM2uhohhZSyA
	CzHvptc4KySBP0zijWijO20aTiZcitPkd0nQ6TYB6Qwype5kexKlhKQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204924gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:34:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494HEkje005903;
	Fri, 4 Oct 2024 17:34:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422056ueev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:34:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCbHyiudmJxN2LwNGFXWGKnn8lyjC/BUpWTCoVfj5hcX8uiZgbIjVNRg6mHAlzK7w9Z5k3VItholGYRVYmWeqRO2BYQ6fEbhMcUzTTl505E78Ucz+kNTUqOdYl+Q2NHX+kqOrubSMdj8REJS3wdYVBNcZvejcyNzuGNKLJyKE4MyS72HAT88ITCKSA3fZUy1iR17CwJ5AxbyjwA3WM8+KnLtq2V2/A8XLT3Iz7wEd7jxnGFRheP5lLUcga16MaQAbvLIGuELaDt4RBSh5Fv91qo2mLI6tm5QI7++bK6jP2fat/56HbjsoVq1k2cZcnYszoTbgKMYtaBr9wF/5obmeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rwR2GlWZjip3HsMPnkInS0KA2XaPyBnNIBW6/7n0Mg=;
 b=yBzj6guacm9Sq/kMQ8qTC6COOKG2zQgUbjfDMJvPCjiDnW9OmSdgpmIjAyaO99PsK1V1p6MehCQdzQZpwYiAociTXbyc7emNJ1DnLObZavOhricIAYehveGvTVnZmZdsD3tlqOEu1q3xldEoa1TPF8J98yH3TG5DPDSSASEZ6h5fHcGSusaXJq5ZvtLRAH2GdGoVaQTnLvbl1Q86H35Lfe5meft4DJmvVuTHoRTlTwIDOKGie4TRNvrseZmWMmqSNGNB1yvwM5sc/L6QDRC8u9CMZD6YF0I62KvXGjSA5zsoyxKh2ihNdqD1wxab+q2ka58B8ezQiBAFXk+e2ULUlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rwR2GlWZjip3HsMPnkInS0KA2XaPyBnNIBW6/7n0Mg=;
 b=EvUOcPegwnBznxvpkaejDIztHTt/Mm+YHWqngZV0juCZgvLzNygBkqAiUrEykIJ81HGiz4vO0qyzCWbmmOY3iniiNvxmBLZt3tl5sqXofinhIPDfKmeapA8DTQuCKTh96Oe9Diq9Ssvl7kCz1RRCXYzcsN/hAeOD+vg4eTq2B6w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5013.namprd10.prod.outlook.com (2603:10b6:408:120::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 17:34:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8026.019; Fri, 4 Oct 2024
 17:34:53 +0000
Date: Fri, 4 Oct 2024 13:34:49 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [6.12-rc2 v2 PATCH 3/7] nfsd/localio: fix nfsd_file tracepoints
 to handle NULL rqstp
Message-ID: <ZwAnOeId2oyUi8vn@tissot.1015granger.net>
References: <20241003193504.34640-1-snitzer@kernel.org>
 <20241003193504.34640-4-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003193504.34640-4-snitzer@kernel.org>
X-ClientProxiedBy: CH0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:610:b3::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: 825ccded-91b5-473e-c9b3-08dce49adadf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xZrbPzUITal88LHu/yQoAycXSyeD2XGL3ivNeKjfNaRfXkfywSymwhkcjPg9?=
 =?us-ascii?Q?W9kWP05w514rrrQwBePnyUudco8dwLyHjny7bLa//W41TwaD3BuiK2TChVAv?=
 =?us-ascii?Q?Dc9f+xuFeDw39YWmYVEXeEB2569wRAjf3KtcDvHAZat4riW7SgeUKr5bgPcY?=
 =?us-ascii?Q?PQA+0bImg7ePH9fz1wqvR/KZpvYgiJHuzfoxp2VahS+LoxLisuEIKyU/JeFl?=
 =?us-ascii?Q?+zYYls1q5uzNfSd7IGJJ7eomIixXJckVg8AlvkcpBMJqIcaoQwUoj8OvSUx0?=
 =?us-ascii?Q?MZJs5bul6teLBCrcsSoWyJy4EAHrlt6rcLOWRylTl1eOzmQ+iVYPnaIXFOcY?=
 =?us-ascii?Q?bPy1QxX6E8rEbBgaMufIH7FTd2fWWl1QaCXz/gsglbaQa68zXb3o+aNWbYiN?=
 =?us-ascii?Q?ViU4A0L+wK/oVehOXYwkvGbBtfYR7xaHC0zS+Cj0SVJMCQTSvTgv457RS+sC?=
 =?us-ascii?Q?PvLF5j5hpEROuPCiopoeLjMQvD8M4JaHgc2CyjZAvwoCzRVXy1/huhkzAQoC?=
 =?us-ascii?Q?qP75X+en0z3L48rHjTWAZonP7obn1tkYwgSEu9vHOxes+OVhujs7SGbCdZIW?=
 =?us-ascii?Q?/46V14r/CoXJUmFXjmraqLeQvqdhgGB5eTDmkAxIQXTPrQLwcuHNYoAlV2el?=
 =?us-ascii?Q?w4si6yVLlJtrHRF7bn0R+febOv09ykgqrHhsTYp4KuXOSUY4ABqgGmYtJEt9?=
 =?us-ascii?Q?E690W/TP9PVwkPcIAus9ZyeczDkkREU1v69rSmo4rGCPD7KICmnDl4fTbqsg?=
 =?us-ascii?Q?rWsBKfI2CSBXCnzF3pfaOoij7GLucLXuvOoclS6vgCS4FBlTQ3eg2gQIDkhN?=
 =?us-ascii?Q?NJcxdm7Qj9ILd6mgkkNR8r7HE8LA5knDw3bMLuKURT3BVtFLdc1MsInRQnCq?=
 =?us-ascii?Q?XpjFSulbV5MU+ieucynRUlc5pH0cB0Oj3ll8fFmCKIP0dEmGb8JCzJi0wzEk?=
 =?us-ascii?Q?3Ztqo5YZYyZ/Dr7HCbBZ2hdo440oflOMTH2p65FmeXTpkb6gRSCCmhktu5gL?=
 =?us-ascii?Q?XFJGMPwazgUEDqF0VG4bYLmIvuEuUyDtZVkni/Ji2WlAVbxA+P9AOr0q8Eqe?=
 =?us-ascii?Q?ud7fmj8gvITwaLAYyGfeUwv6l6qeKxXZ+TPF16/BWfoP7k5aO977hCbJ9VE7?=
 =?us-ascii?Q?g0NGswqkq0xvb5I4hamfNp6qt4ivJW6vp9JVtjnsyT5Mfr5+kYpWjzDceckD?=
 =?us-ascii?Q?HkQkwtG0FL2ygWeY/UychjeA11zHw6kTQ5t0JajL43f9jNMTXKhIzDVpWoP2?=
 =?us-ascii?Q?fmpIzkICcEWAGFqkIOAt7ugb6hGkkELV1n440lyTPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JTUvx5+1hsA8boEjnHJgpLGyXj/4pUUdJ5Uq8QD1c/1oR+VrjJR29Hniutdt?=
 =?us-ascii?Q?fDe8J8MgymcVxkUJX9X1Iy7+6mMDJciP+Uj5p/SJLmzGo6ckWST9OM7IGMuz?=
 =?us-ascii?Q?dj/w/K/ftO6XVuzQC/VC0WbGHAR5wPPVbBbZI1nXF42z3LgNzDVdIFEsesRQ?=
 =?us-ascii?Q?71qHE+6zthDiytSQIbtZg+RKbyasl6kPSIog3h1RYpgY/L7Bti+AQDVhuLkO?=
 =?us-ascii?Q?ZSDciWPFAtY71sdc/R0Dh+lQHlCB24ymWvXTiX/jKBvzbHIa46o6huyRvxpR?=
 =?us-ascii?Q?mAV7RwLDfK7y1CDdBHR99bf/Uw20Fu4NaSF+1eu9HcZRivNiSMKwHxKdQjim?=
 =?us-ascii?Q?6M7PMNq4VvJFQRoN416FzxTC/gC12KGECFgSdANTo632tKOvfpRBrrfflxgl?=
 =?us-ascii?Q?/o3oyNnjRKfVWXa1g1l+4GrTrbMM8wXjVAqWOSK04z6TQNVVHwXVMzfVOqIP?=
 =?us-ascii?Q?Of0vMsuf7l+7vc3Ym/eX6mmX82aqnuBq/kTbcr3/Kd7rw8EeQW2OYPxXDxJK?=
 =?us-ascii?Q?ZdDVt28+Y1JxarYbqjuGiIanpYBQKabqbouPMRxLU+bOoq64DSCtGKq6hAo3?=
 =?us-ascii?Q?E7VcpxD3fvxKhSvo9wDd775kPP309V+ahb3JxDWmSehy2yw76I/tTBTnIvAZ?=
 =?us-ascii?Q?nBpHYnL0jejPV56RtnYmDON8EezYQ/y3Ii9WErjf4cO3I4aTTJO/GRQ4V9ES?=
 =?us-ascii?Q?sFcOXJIz5Bb4+21Z424W9A1t97kjsvOScNV3z0BagFZHMpn4rhSATXwSJOX+?=
 =?us-ascii?Q?Zxr2q9AqqDH6ra+ioFSocbiAOqQNIM9JlY9tDrt/crMQt2hf1UvbNxnWyF0g?=
 =?us-ascii?Q?QJvealgJ3wjjq55cxn2lL7RXXiQdtm8Ygw7rCzeNwJoz9RT1gAZJIoDsEarI?=
 =?us-ascii?Q?OD0E+mtygt2u6qOMyzBZMnM5m2TEME056CL/t1mh/4dAXJGrvGfgQQVyXQtP?=
 =?us-ascii?Q?V5xH4HB3JTeEBH+Hqt61BHYKn6YDgCiBF4Vp16vKBkzEkkB4hiDKMAa2+quP?=
 =?us-ascii?Q?UkLGsxHNTGei4t8v6I3v0vkddJVjxT0rGUigOCAh6MC8gCyBB9nFJNlVcB9a?=
 =?us-ascii?Q?sQtpAtoN9O1uAwapN7Vr7qEhXT2DggNVGZmx0913S6newrl/VeMK9Ez+Xv+n?=
 =?us-ascii?Q?ziJSr27F/2XKoesgtNUwyGP6BM7pmwRWMuDdTX4rKeFPwiI7ri5sJDOwY5yf?=
 =?us-ascii?Q?LmwaZWEJY3jzSu7u1FTm/xcwD9T9SaA6SLkNSfCZOtp2R5om3olucN6eQeXP?=
 =?us-ascii?Q?7I7eEqI6YwNHRfYfDaF4ZqwBPpou8G/pvEIqBfRgKmk4Ak50F2XS2ybTvyW8?=
 =?us-ascii?Q?oxH/98pR9O4aM08N/psQmfqcA5rxoyB8oddkg9q3PeYxPhEDp519ic/FL2nc?=
 =?us-ascii?Q?dD6LfgC8R/X15/7zn4VtmJ90zWtEoNopfOQwWFa6hbTDtXQYB60OgHmr0fHb?=
 =?us-ascii?Q?4hy8nX2CUzsA9xYszTdgMdwTVyNNcTc/On91PnuIoVT8g1yX/uBOAVsyXUR0?=
 =?us-ascii?Q?EPZvtk+qXZfoGZRjNA0mbssL21GkI91rG59FfsOm7NxTDI2nw4w1Jk1iulrX?=
 =?us-ascii?Q?CrOdxvSpI5Syj27vK7TSNawhqzkdCHMzVTopAQTS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KItYPub4U8VrhqE48dWL9eVbYkkNH1SKHOmUAVEO5fMLXIXr3K2IWYNzmblvJZh+RoRsqb9n6ejuS3ham3HL89DcM6HTU9nPb6rChGUHA6/th58ysLPOvSSs+waGAxEACci2uFifwzNpHoFaSWzDHGRC0f77q9CR1rf6XAndS1SNiBLmPBubFbfz/ZHQXCTgYWxOpQr+STtZlGGYoWDrhpxhF2PgXex+8RfepGb92+sjvm6aOk/nn0N/Ka2NJXnOQzvbRTiZmoFJMBHpm0eFjwTUNVhNPP403FWwnBLMlvLqCyawFeJ9ST6ASlpfbUXkpKgaHbqGZ9VJsFapWZGSsn7LdgV/a+rywD3JVYNI3KjmKBmERY3kv0wEqBAMx3btS0Sl7a/MQfqpmpv1d4T9USrXpUk4WlHWnIzDyKTA3FKR8ppMJCwf/SS1OTc9+E01DWRSXALZqDhvYsGEiobMCWwjoAs56+HUdiyBmLEVUipTGdHrfr//67mF+5uF4K37Ma0+m3N8buw8Ox2MuSHsKmIFA8Z5s9ofOihnfDDj0BXhUs65ketUzMLLf1Q6dey8AuroyR2+/8xXdDgl4QXkkj/xBMp3Q6MMUqnITdKYkIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825ccded-91b5-473e-c9b3-08dce49adadf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 17:34:52.9607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCkaG5NGTRww6ONNOvnBIldgn9VjiIwlLfXJu+VJR8cIEwF5T8If+4BPYFl23/6IdRg/ue6CWFhJmNlYcvbUXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5013
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_14,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040120
X-Proofpoint-GUID: Uf-jDx1Lg6v_8BKyH9Ve_0nR-wsG02i5
X-Proofpoint-ORIG-GUID: Uf-jDx1Lg6v_8BKyH9Ve_0nR-wsG02i5

On Thu, Oct 03, 2024 at 03:35:00PM -0400, Mike Snitzer wrote:
> Otherwise nfsd_file_acquire, nfsd_file_insert_err, and
> nfsd_file_cons_err will hit a NULL pointer when they are enabled and
> LOCALIO used.
> 
> Example trace output (note xid is 0x0 and LOCALIO flag set):
>  nfsd_file_acquire: xid=0x0 inode=0000000069a1b2e7
>  may_flags=WRITE|LOCALIO ref=1 nf_flags=HASHED|GC nf_may=WRITE
>  nf_file=0000000070123234 status=0
> 
> Fixes: c63f0e48febf ("nfsd: add nfsd_file_acquire_local()")
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/trace.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index c625966cfcf3..b8470d4cbe99 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1113,7 +1113,7 @@ TRACE_EVENT(nfsd_file_acquire,
>  	),
>  
>  	TP_fast_assign(
> -		__entry->xid = be32_to_cpu(rqstp->rq_xid);
> +		__entry->xid = rqstp ? be32_to_cpu(rqstp->rq_xid) : 0;
>  		__entry->inode = inode;
>  		__entry->may_flags = may_flags;
>  		__entry->nf_ref = nf ? refcount_read(&nf->nf_ref) : 0;

A future auditor of this code might wonder why trace_nfsd_fh_verify()
takes this approach instead:

 197 TRACE_EVENT_CONDITION(nfsd_fh_verify,
 198         TP_PROTO(
 199                 const struct svc_rqst *rqstp,
 200                 const struct svc_fh *fhp,
 201                 umode_t type,
 202                 int access
 203         ),
 204         TP_ARGS(rqstp, fhp, type, access),
 205         TP_CONDITION(rqstp != NULL),

The answer is that trace_nfsd_fh_verify() uses @rqstp in its
TP_STRUCT__entry () clause. Thus the entire nfsd_fh_verify() trace
point has to be short-circuited if @rqstp is NULL.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> @@ -1147,7 +1147,7 @@ TRACE_EVENT(nfsd_file_insert_err,
>  		__field(long, error)
>  	),
>  	TP_fast_assign(
> -		__entry->xid = be32_to_cpu(rqstp->rq_xid);
> +		__entry->xid = rqstp ? be32_to_cpu(rqstp->rq_xid) : 0;
>  		__entry->inode = inode;
>  		__entry->may_flags = may_flags;
>  		__entry->error = error;
> @@ -1177,7 +1177,7 @@ TRACE_EVENT(nfsd_file_cons_err,
>  		__field(const void *, nf_file)
>  	),
>  	TP_fast_assign(
> -		__entry->xid = be32_to_cpu(rqstp->rq_xid);
> +		__entry->xid = rqstp ? be32_to_cpu(rqstp->rq_xid) : 0;
>  		__entry->inode = inode;
>  		__entry->may_flags = may_flags;
>  		__entry->nf_ref = refcount_read(&nf->nf_ref);
> -- 
> 2.44.0
> 

-- 
Chuck Lever

