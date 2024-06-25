Return-Path: <linux-nfs+bounces-4296-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6277916A2B
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 16:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E8F1C21A3F
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 14:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E55B169AD0;
	Tue, 25 Jun 2024 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VjeiDONi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Puaqm02W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC6216ABF3
	for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2024 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325379; cv=fail; b=UwEHKmJDdSbVI5zyLmp5Q6vgjs1kF43MPwmljsA/Epy6bvADPHjXqTECljcE1V6PkPm001ZxEoqMlgp0l2s2ajMwJjXwd5bbJhR2qOl3Kcv3ptNMwmgVWAu1JJ+0b39kbClYJsxKDUwsm4f0+J0MU9Wr3J4Tu74YV8WojVQdx64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325379; c=relaxed/simple;
	bh=hLasps12aHb2m7AvaYVFegP5f4mj23R1fzizk4QM2BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WnhGtYdGnj+f2BGSITqKKe4xM2IpYTvP30CuF++eWbsUlYyXVCC6NstqJPj3g96l3AilqnQJV9E6O2ghTlarpSA4GmR8jL1fivNA84V3gWWYIr+jsw0KYDpdNXv0LnD49Yyk4fbVb4KIrGELjq+3WrFWFnnYxSe2teVHx+svOJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VjeiDONi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Puaqm02W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PD3XX9021031;
	Tue, 25 Jun 2024 14:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=QR39ejwC7zrNaRr
	mHHmerrVdFaUIibyK9edjjhDtn4A=; b=VjeiDONiSdLT7yPDe3811Cen+9oD1hA
	aCHBPE0o/Qmql1fmqAkJ2qAE49FUXrLUcmaLuUjcML/UcWHIklep3qelR0NqrSJD
	6awJFbuTmHNtPELlFhJzd2ewaX6iCkJ3YWGI6hDYtKfCNbgn4RHVcUcPSAtAQEG4
	3orln6FiwIxgSXEYw0KiPpyLQeT/7dQCt22Cs6LWROHgMdMxZDAn7bYQ4QHE77BP
	syzWHnmlCBPzbUVCBUoyIgOpppqA2TmXvo/dPXu/hm4y82W8SeQAwRyYaGQWV4+3
	NX6cAK4lnjczhZ9NwaOzRM7Dc9GCPrvlaFXgD8P18AHkbd5LSvxsDrA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhb0vc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 14:22:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PE7fHu021682;
	Tue, 25 Jun 2024 14:22:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yxys4j3g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 14:22:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+giZk40peTblhZoHKr4HnzSeUNUd1XqBCMzFIC8cs630fTVKsAWksBctzWpa7cQQZZVrHx07FgFZxiQ6hAhf2C6uoezd7mBs1Fnax50mwR4YhTe8WAQz0DRE3/6O8Uy+KlKOxBwluaMBW4d/jIhMfipHmWzqY9LO67FXwRY2ku6lKL8Su1DJ7u1zaEKUtWDGsAR1BFOJ02LWs3k84vLVj57YE8flJmj4jKAKYdlUL+XG2W7go2xkiHj8Ex1gs7RKfovcqMsxKob2w/YcmIkFMuX+4WfzzesKk2KyhwF0A9lh9T4tX++EqIME9Bxr5iD67t2WGjyt+eRGUAVt6iG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QR39ejwC7zrNaRrmHHmerrVdFaUIibyK9edjjhDtn4A=;
 b=mWIa7S3hf7SVxbAhlaRDRIgdedDQU90Ja3uLGoTwPXTIRCyfwYCTAaZDq3c0OB+SULASVbW6T+eqAxSokiK1DUswU6MSvtbaZgr1XrpBtDdav4akGmiAAVv0eR2DWeLVBa0B0wywQzKQPiVWSXcI8T3cND5kAjHKTctkfxjQmy1CWI+2UpMxEROrFymQzWTcFJO8e8S1n02QOy57vS4ajxw6q0uxcSQKjMBQn7A1Igg5ITSlG679i+VcYxIXd9WGa3qWGzhpZK8U/lzgDuuwC3Qu5lZJXXzX2Kg8uS6kLRwEucfFW6wbDELMQkLF+R8fwhX6NI7lmx/b/HkXj05Gew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QR39ejwC7zrNaRrmHHmerrVdFaUIibyK9edjjhDtn4A=;
 b=Puaqm02WfXhDCn5M0HfczAAnF49WNpX2T9759m3BKR42wI1/csNnyyYj0qlxE6bzoIzCrVXiA8kkJH5OhXVclOrwdz14x51RA0mxPoM/SP2ypBb7IMyLCqbviWBK96j00+aiKooNMSmhuVRhu7JHOnVYXjslYyQ2ruOg/VO8sw8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6781.namprd10.prod.outlook.com (2603:10b6:208:42b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 14:22:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 14:22:44 +0000
Date: Tue, 25 Jun 2024 10:22:40 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/2] nfsd: proper fix for NULL deref in
 svc_pool_stats_start()
Message-ID: <ZnrSsPMDdygXC1U/@tissot.1015granger.net>
References: <20240624230734.17084-1-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624230734.17084-1-neilb@suse.de>
X-ClientProxiedBy: CH5PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 560da9f8-73b2-4e90-8d22-08dc9522477c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1WBOQAT+Yeo84fghrcH2khnn4uT9xcs4tO+pibvrEFFJivpGVwbOOw58J4YP?=
 =?us-ascii?Q?TvyfrSqT+A0o2MmVg88X41cJSPJvwU8uav4ApFT6kh+H1r5NwCO6ABqID64V?=
 =?us-ascii?Q?laJI9Sr9bce0aIea0YVi2ZO00KX1o6RIZwB4UmB0i2Zi3DdzfXMvsEx3jW+w?=
 =?us-ascii?Q?PRio1ZWu1GN8Nj3pSlYmNpBHJ0AE/ya7z8dqRlRojXrPKdnOLwJb16/XyQuC?=
 =?us-ascii?Q?qTY1AlJhxdUT+pXG1KGF+RUOhdP3TH72Mi2syAC/bh8JfL5CK8gbupAaBENa?=
 =?us-ascii?Q?kFRqXAwfDwHLSlx+VJO4biKQMKgmFQtqybIpmq+ts1QaMBbElsuJ/GoJ+GEb?=
 =?us-ascii?Q?3Trf9g3b+C3eDfzpp8udi+z5S/vNSdG6U/iN6URKPFImjfraPKJrXXgrLiP9?=
 =?us-ascii?Q?MgfnAyBFBUnoUyVxb0nDJQwTGXiu6FKwM+SIbjvPQmCrhnqU+LXd4yFmUpWB?=
 =?us-ascii?Q?qAa5xXe9IWuHNEikEUIpTvXiBSVLL9MN0kumSAdalsLpTbImo/NKz8Ex7ocq?=
 =?us-ascii?Q?ad+XdfbChBSjZOaGs6aClFamQOyVfqcpHZ4Isp+NuM184MKh34D7rYs1HJwr?=
 =?us-ascii?Q?Jzr8t7rqQMJYSjTftXAPkWjIXX/k4MVXsrLZl1+EZzc0BVOEYVkcfzY1WYPe?=
 =?us-ascii?Q?OtbLcZykhEncx0Dw0qG3D7H7hhhSSbyuqSgz/REEOoGa8wbeTBGkf5JEHO45?=
 =?us-ascii?Q?IVUxL7YfvMv+9MEhRgl9jJloKoG4T5EYXnQ+1hD4b/BwFLXE3qlHv0qOrVzs?=
 =?us-ascii?Q?k+f1oES+KsBtysDH/9lWZOGlom66lpmnlkRC+4WFYyOROTPYz1SNiXcpqUKr?=
 =?us-ascii?Q?aQhcTRZ8sAZNP4Ig43DRJBmI4xALA6Us0Z3I8Y7eKJw8RZNIZaYOZ2cM5d8Z?=
 =?us-ascii?Q?CzG9WJ271jUnUbINZlwP3G1CbsAociVfpyp3u4owARjWMx2rpyWDibR6yt9i?=
 =?us-ascii?Q?WEJ1Nvnxk/eHS5XHWGd6qtIjWx0WTuEEJkt7e71g/fUNqQF53jEpH9ecGji2?=
 =?us-ascii?Q?dY3h99ScSb5fYjkFbPS0n7HZbPRKg3vi/BjHD2avBc0ta45UNwpSvNdBJGOP?=
 =?us-ascii?Q?63cTnNPyZPnqy7NwvVckFeZxbbN1cBWjqF8ZUX4zF3Z5ncl7jDLH8ra6TFU7?=
 =?us-ascii?Q?nkdDcXwISXQY3ZM+ctY3MSDwNW+CREWCslorohdgs1pXQP+j+xotutWu2Ua9?=
 =?us-ascii?Q?VyaqySyF+qr4/d68P0r7Q/YoypapHGpI3J420/E0F/Sgf2z48pbhmDaAfO1l?=
 =?us-ascii?Q?ypBf8y+FzS6g6qP2qrMlYPDKfpU5828kcunmAXyNBjyxrIj3r85oEyKVnltT?=
 =?us-ascii?Q?yuRNty697Villfpbajqthdvg?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iVGkdrylPaWaPsLUg5ZW0soni0D1lsF5HKP0ThkdM3UXQfR3gWd53eJ8OwNF?=
 =?us-ascii?Q?37tuCExqr8P/3ui9t61eapY+osLd9brtME1kH+zspv2hf49tes1giZkCfhC3?=
 =?us-ascii?Q?eb+0QlprqI/g/RWelY5bYz5pA0JPnZurg5GfOqydOZrdRnXQ1KPuGMkiCITt?=
 =?us-ascii?Q?vrfieRuJyGYPCQH4ekalonaH6A7gEFmX95oYxcRAhi9k6/79LkhhQXoUNMdf?=
 =?us-ascii?Q?I4KPUdz774Wv1GxnOdEUBxVvrpn3+3VMPF3gVHyYuak3jWd4vGduNfQ8iFO4?=
 =?us-ascii?Q?MYxewVP/cjUK5YPStU2PgkCJulourG0rnj+QB4rx1oH3vxCacuAsIYosxKE0?=
 =?us-ascii?Q?bBFjQJ5hPw4DT0oktIpvZj7oh6DtmXVWaFfXqVUKnbrHE9lE6pZB4/vhWt8u?=
 =?us-ascii?Q?q7eRB5w1DJsjOLPeFBwRDd7cg0JzNq0GftI8q2gYYTANluoQgIYWGVF+mDyk?=
 =?us-ascii?Q?YGyn6/u5edBhy6ow0EU0Xv9CXIB4GGUJWfCC05UuEyAlcrs24hcG1qEGdcAS?=
 =?us-ascii?Q?K+Fh1JRvpBA4O5uSusU1hKQyj3MR2ESucyeKs/+mxBUQB53CGm65K8Oq96Ek?=
 =?us-ascii?Q?Za1r6NwgiYL5nEIb/VqFDsxL9nxsUJoR14KP4Md7AAlHTOG0N/2RLC9/3WbZ?=
 =?us-ascii?Q?4B4cqNKEiMeLdBZGCfZuJgj/+/k6lXsLzE4bLQwbRs8dKlmFyxiF45uyeoBL?=
 =?us-ascii?Q?BXUfekjXxim68euIs24EBaRYTNK03Cldzgp5C/6R2rvDYg0rK/cypB5k7FL+?=
 =?us-ascii?Q?GjObrqVRYN54yT+fdrCO/faZ0xe+PQ8Z/kW5inwXnMVbtsBF5xbe1Sooy8Ef?=
 =?us-ascii?Q?pDeXuNkzJb+7Zq5g7CDRzfXIOOCvvnX+mX8flJ3DEO1rdsfcwOy3aIMHiDJp?=
 =?us-ascii?Q?7jtshPZou6j/mLAYBKs79cf9k3HCvhC1eBcv62H8AoM5e97nwApl/ApR/sRv?=
 =?us-ascii?Q?HLbv8+2cBpVA5wRN1eK21sISaZFjFIbkdxtBDlPClJ0lpSYex/NPVZ1JrD+4?=
 =?us-ascii?Q?2U7x56wGRn67zRx98I1OaF0IU9cqPjV7x6cUndz2ZxQCim7DKmcNYy3KCCxZ?=
 =?us-ascii?Q?JQJv3jjhgp4quUPoAIHAVFJQTiKPvrB8/fdCptdfcFtdsxadMJYphi/wv48h?=
 =?us-ascii?Q?6RYvv+k57NoIW1k69hwFWsXWUsTJVYHU8Xkj9VEMQSq8iDr+48FKmcZkvsM3?=
 =?us-ascii?Q?MhJ6tNWrdKQrg0j2h8L5sso+pe60G82j5ovWi7/cOeqlAz4A3fsxR0JM0wmX?=
 =?us-ascii?Q?UnNyNJk5Ve8VnjxI/O8QqyKKjiGK+MxBYunTCIcShjt8hE8o4Mb/MUBdzrZt?=
 =?us-ascii?Q?74pOcbZ9c0bkiJpjmT/MamhRcc5ECEQ0w0xTE0YSktZk42de4T23TwJOsKzr?=
 =?us-ascii?Q?xdnvTGqfk+Y98LHzlDcEnw5TF9dW4/OGGWhSv209gHYv6nbn3uaYyGUiuWEA?=
 =?us-ascii?Q?X+VUFbOZwO5+WOc/TjnN4IBXJIx9Qhz+1xuB6fzWlMKvHfbmS0vrdztKMTVY?=
 =?us-ascii?Q?bkTqRRRQIDYSHDGz0mc2QBe3LgJYGh9Ul9q0TxqlsyMj7KWcU+LBAxkxLNSB?=
 =?us-ascii?Q?7egYktZguBDu/jiYsuB7FsGwqUVmJfS0WR9YJ18zVAgF1VyswWvhpvVWG3Y5?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3FgxfmyCN9zwCcJXCzVT2ueI/cMDwqeM1w6/CbYHgtA/txiIMw2Q7l2PgCTelvNtglifEY3KU61Qfd6scqLZ3fO89rHB9Ris1a16BzFwP6WWvnhOaiCGKUoKqiFgvgnFDqtm/5ssoIqobJAmVQjbArSFPXcSGtIZAN/Tfego4QKXuV+qijEkUJ5yzpdPgMdYRayjEs7QvgARV2DITDe4gpJa2mTmHx+lY2M2FcnnD92eFvRvlhyIpqe9ERELeQXy9E8MXVE7t9VicDyfx07YEtabU3bwQ8NXMzCCDKZ9T25Q6/LfMcz22xqvDlgsTiY278fvbHyg6ODSgbdp4Xh77jKBYF32exbj+f5Kb9XTMG30LzTSTR9qn16D2JNouq7wQTEko5hLlPXPuu3RgrjRIHU+WRCyavM2hKMtHFBFpw/qHQ/uTMpIFHs3QDZk84YsWhP7ZOj/oubYtiNa61ArmwYDc1f4uQHh3NufzMzdEDhY4rfT3eT6v4HcVUdo78U3R7MY/tcNG+XVifh0bkFO3ye3Dd3HX0HPh1kGiadMIYEE3+sneTubwYDumTLjr3BrsYhmROV4LWad/Jj0l6hltpultxz1vO2xIdxL+PrEN0M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560da9f8-73b2-4e90-8d22-08dc9522477c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 14:22:44.1238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BsR55tdrwDvqQiSgzpDCmin3K7XadJJc4Ib53kk6qvyzzsZk8/SvmGAWycMp/Z7ItkZD4Yc5CUgi5KZVclhKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_09,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=913
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406250106
X-Proofpoint-GUID: lVmoxVHY8-2h1YTrmlfhiIhPpS9sbwFv
X-Proofpoint-ORIG-GUID: lVmoxVHY8-2h1YTrmlfhiIhPpS9sbwFv

On Tue, Jun 25, 2024 at 09:04:55AM +1000, NeilBrown wrote:
> A recent patch attempted to fix a NULL pointer deref but introduced a
> different NULL pointer deref and a possible unbalance unlock.
> 
> This series fixes the bug correctly and reverts the faulty fix.
> 
> (Sorry for not reviewing this patch earlier)
> 
> NeilBrown
> 
>  [PATCH 1/2] nfsd: initialise nfsd_info.mutex early.
>  [PATCH 2/2] Revert "nfsd: fix oops when reading pool_stats before

Applied to nfsd-fixes (for 6.10-rc). Thanks!

-- 
Chuck Lever

