Return-Path: <linux-nfs+bounces-7652-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554479BB7E8
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 15:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC72D1F23AE5
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 14:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB3C2AEFE;
	Mon,  4 Nov 2024 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LbmGr8WM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QLRVGUeA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A681B3921
	for <linux-nfs@vger.kernel.org>; Mon,  4 Nov 2024 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730887; cv=fail; b=syQx7COtYsHyCZ0RjFgLgvr/74yk8AdCj3PQfwEPD2x3KwYJezN0NnsuGA1k6wbREEwbigGrXpAHTsnxYiZQu4lTQ6oued1kUyuSFzckZM/FgPCIXNQXSeWiHdnKdxj3C1Fp5ypCuOfefWeiEQ8a87jJaAkKd6OAKpQ2BiVtEgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730887; c=relaxed/simple;
	bh=I66tdwifpUls8jRs+/17lFTs3ntcLhQBPwGps3wgCHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nUpl//zRA6HgGIGmgEUneAOmoY2tT+VjDc2nw7uX3iGNrPtsdyiT/0HkY6t2HoczQOzSwpsXJm68MOxTCwmHBmHaaOedXgtPVJPprUO1KXe1s2ayDq7SP27nw+djzy0+SHCFo2jc/UxsTGlvSqn2RabnOciMiA2WWO/scO9rbms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LbmGr8WM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QLRVGUeA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4DNrYk030599;
	Mon, 4 Nov 2024 14:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=EfuuQhf/Kq7XOdAKQc
	n/Gd++nKNFVJsHcNF4SnWFVzs=; b=LbmGr8WMuNMXowCHpx+UvNBgw1pLbDOF5z
	eInsd17dgsdieEP8lcG7unU73wdzNA+fAOZWXGoaVFD3DCdy1R+5/3MCwl1ITElK
	T1wyTDvxIouUECs0OQjtYO6SGKImFpt+hxAwxvPA2zCe/f9Zn+fHlTWCEZsET4mx
	88oJMpImaYzoJVY5Ybdk8lOLpzHZoBQ56ib3uDaxKkJlur8/YBQQWAI6Scmy4phS
	5iVmkCKPByOEjQJpK4OCf+SljJeDAuUDKVYyZyuE3k/kfPSibHsF1gQ3laJfIL7W
	W7VUf4/6NWrnhCO9dOnrQGn2NWnEcTa8DsRWQs2Hqxspe+IXXWFw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ncmt2tv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 14:34:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4E139E005033;
	Mon, 4 Nov 2024 14:34:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42p8797q6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 14:34:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6Q8kdraaD11PFGj7bXPm7DXGRXlSeTG7IweDUGW5qgX7LEI4SlR5HQ3C9iN8Ip8a8k34NFl7d0zOn6ap+F3ZneGLkn8XCPlGCAv5JazSuZSQHBK6B0N3JhMWWtoVQmBmP27LOr0ym/wpGLGPHiDYEjO231sxIvvZhQ5pQmf4C6Lrbs3VrHDGSmFRxww5xsE3X0biYVXOhqTFr44YU4n8ddUQ4h0hYpkPu+voXvgBBZ7zgwGXh6eX0FBK8B6ntebrSM+SFmmCTl9muX8ToqUvN/0W8kMl+yzMTbrA3hM+tBDrAPAKBQFpj8hDJBH/6t3cGS++G1bALqUw9cXctA+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfuuQhf/Kq7XOdAKQcn/Gd++nKNFVJsHcNF4SnWFVzs=;
 b=qnruhTkA6ntc1BeC1XGXRe1IdFrx5gUeJMQ4U39BZy6SoSujzKBoNXD2V2lGWEmDZbLLUnLc1Pkfz9pVSuGeAaXDvHBUpsqUJPRM4SWSZBbMBEcXkuMVjzdJCBd1oLtd0VkKWwYd41+8jJ8HHc1BM6sx+3P0HCIojn5PCu8zJhbQ51XX2zeWfWGhC+uHF+0K7imojUevqT0+zFJy+VXGYHGJKZxfkYnJKdVQQIj8KunSGOJML7yE+4aztD8uFuZc4AsZEL8P8F7q+KfvvFvw8lVIzRMYIasT4hxqhuTyhKtl8+QdWOxIjqR1DgjT9q1SbaWq7mKPLM7bEo3x1Y75BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfuuQhf/Kq7XOdAKQcn/Gd++nKNFVJsHcNF4SnWFVzs=;
 b=QLRVGUeA4Ps8h/He2xmaEl1aphX7KMkJaGDgWvgKHKTZ57Ellj7Z6l1cKO3rdUYRwJwTyv/h49/TQ0KmyOmoLgh358eGK1j5df0FL6m3uIKgVXQ5BgyMInGeEwIBYXsQL5MkyczlYkk34QOXakIE/l7w+ttw/VseUs3JRSneZ+Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7445.namprd10.prod.outlook.com (2603:10b6:208:449::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 14:34:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 14:34:33 +0000
Date: Mon, 4 Nov 2024 09:34:29 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: cel@kernel.org, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH] NFSD: Fix READDIR on NFSv3 mounts of ext4 exports
Message-ID: <ZyjbdXeO88btmEcW@tissot.1015granger.net>
References: <20241103213731.85803-2-cel@kernel.org>
 <173068592763.81717.8053187930798590061@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173068592763.81717.8053187930798590061@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR19CA0030.namprd19.prod.outlook.com
 (2603:10b6:610:4d::40) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 4817efd8-e17b-4db0-f95f-08dcfcddcc73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aLI3AUBJXnu/7M6/yX/P06f3r0DXYbcIaDMVOv3bkhUlhLtOmge9O5spc37k?=
 =?us-ascii?Q?yEUJ4OtWHGOP+epJEmxvQygEU+6A3WovINIw0qYV9KwHII7+JsoBqwmrfKvL?=
 =?us-ascii?Q?ih94E9fCgK5qxqg/t4nHIAT2e8aLGGHtoQIH+JJafSJjvI/SNAACYeaxb/Ur?=
 =?us-ascii?Q?aZ92mQypJ4ZKP/RMH/Mkp/ze+Zir9ZZI3Z2nu6jeUVxNsceCkgFROwFhhkQm?=
 =?us-ascii?Q?ZARXzD1brMG41s0z/qxeIx3Ki7CuPFRauHIZQcWCc6wrkrC4UryFAP4ps8eh?=
 =?us-ascii?Q?Ij6MCusHGY754T4evvOhUrv8LCoGWraGagfkNmSe6MTFlqOCBSEZ8f+y507h?=
 =?us-ascii?Q?0Cekzw+wKC1c+jRzS1dFwwT42BeFYPAvpU3bgZXnrKnM5TaEt2aLL9EY3HBr?=
 =?us-ascii?Q?3hVyVNGj92/2BEJOXCilJ+KkNev/9XTEJTCbBCLFu6o41BZz0zR8EB58JWe/?=
 =?us-ascii?Q?W1HBZ2Evsi8I2f6fjzCt44NLcA2JqZj9R41QDO3q2NlbN/b/wchr+HZFV1PG?=
 =?us-ascii?Q?0pCgil/kqmd6cP5eUufmJ/ixbNTbd7Ch5SsGj653NTmsDk/g3rFzKCI4Nnr9?=
 =?us-ascii?Q?eSz+h6EhMpbOxYURvGFW0xqRPWDWeHAo4xAPXIoRxKNDeTsqwQU2Wk2VMd1+?=
 =?us-ascii?Q?4D6f4lw8ftKjP2qEjFRaEsi7fJVeYXtoAo7gld5c2DwS25jRj3Kh7gjmHp8k?=
 =?us-ascii?Q?Y8IKfQO3d3ejn0vRxtPAFyrDPm7TWGD5kzUtskPyyTLoZ6RJX0Js1YiujJH7?=
 =?us-ascii?Q?hFuDll5j+ZoIxBmB1q4V2nVl+cNZ1r9EZ/X+ejXc3yjbFolvvVpTLNoPfsjq?=
 =?us-ascii?Q?cWtW1H2phXqh4Ba2uAS9bHqJ9up7VMcRPkL+fmyTPSzElORpBxUrxdXeDmVf?=
 =?us-ascii?Q?zi+TnlPC6k490/49b4N0mWlXY+p0HsddE/nNW1Vh/nUBMHJHUHynn43pHL/v?=
 =?us-ascii?Q?gn2mo/kX9X2sKtZuvff4eY3iHogbZZsXYgMW38mXCaftvxu0VGHOchizQV56?=
 =?us-ascii?Q?TxYXuny4OmUeTyBkNPM+GOGVFlqzW5tAwyxydR4kOb670ZtP569M0s/EHdSN?=
 =?us-ascii?Q?aNjfGpiF2nTUX+Ha8clQsqataivkK3anfTwgSA7ZVsRuWgjNERgrw76S6VKQ?=
 =?us-ascii?Q?ef9+Rp1bG7IokDjgkJfVcDX87OfBS7QO8vyf9jHH2UGlBMmXEeC+/5Jg1Sow?=
 =?us-ascii?Q?SpvGbfTpTxuQRtGLQUw2/1Jtm5xgA6i2E3uOdpkB0VwwRxTBbhlU6KSWC+KF?=
 =?us-ascii?Q?etPA6/b5uTWR3a7uS7XZ04NdZhY712+8QrJ5wWrm2eOoACrKcRnDd85p+RIV?=
 =?us-ascii?Q?uUdZkOKmdHaCsMR/iK5KfIbE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K9KoH7Su+7ZMAw2ETWLdTnaonW4cQO/+H3FWhhfvpLxxxH6IeNY1lI3rbLb+?=
 =?us-ascii?Q?BxAh4pNkqV1Ks1tJBb+9wRdeX2dneJLtMBSdvObtIQmaZcv9jeQ4OzSGU3Gy?=
 =?us-ascii?Q?9fOlBLTx9NQcRoRnIgks8m10ff4ekiEqVvCVPo+yhQCWzMeQSGkl5BV/E3Cm?=
 =?us-ascii?Q?dZ8z6MSX6j9GqFS4fP3TR9aE73+RkkkZ113TDziqGHa7XATEaNsIk+zNwnyP?=
 =?us-ascii?Q?3XW2hd/Z/HVDVCJjFTthtCmx/e/P8iQxroEJqgq+KLqYKvZEH3ozZvJzOJCp?=
 =?us-ascii?Q?HZ9T1Dv62xrjt3i23ZSqJBu0JRPDSKpiYPzreO4jrBm91u/uI8F2l4Nl5F+t?=
 =?us-ascii?Q?2Gx24ds1wmuQmiz+mAiiPby8teat6nUM0xdCyhflmbv7hh+JHVrcrZwNcZAv?=
 =?us-ascii?Q?sTiYS18UhA2I3KQZ0/DLl3rwp4XzV0MJoANleYHbMgbfYpiICApC/vBSoLtV?=
 =?us-ascii?Q?3yl43jFjIqStY6rw85rfr0i1uGy/mXoHwAoZoPRKMDukWy6TCZ38P7Li9Jf3?=
 =?us-ascii?Q?QmLVYGoEkQc9o6/3Rc878abCR/NDKd4xDSor/+KiDqKIIBmPM9QRadODRhxC?=
 =?us-ascii?Q?SecTySe2qmVzI/c5MTErhd+EeGmjsdhF10klmbggB2ov6PNCGq2sICmFB72p?=
 =?us-ascii?Q?TtxtQWiUEwA0nAhCesgXDk2Fdn03jenEwCb2XbXIyTETkweA9fx0xCYb3W2T?=
 =?us-ascii?Q?KC4uopA4AxmR3wNMnxi4IQ0IG09Mah60JY5aWRGIAosAvK137jAednI88HNV?=
 =?us-ascii?Q?9MhiV/9+V32rwz2Hcx4KVIXxzvHutXt3tU/28Zatf8VNcXcGDS7nt9fF4PyA?=
 =?us-ascii?Q?TZj0jmPKMRWFg3nka+pQn/FA0k5CHiAF649+nYtwJHiHO1YoLlQYfDojTekg?=
 =?us-ascii?Q?xgpzAHglqs0q+Fu6jRFQoWbo+D6BJy2iyhh0FGhDvq+NvY/A8hfKOS+uhHNf?=
 =?us-ascii?Q?8yZ13aT/qrfJEcigjRk1TfpMVAMfNda1HYegFH6Vx+Vj8kDJst9h3R5Cicmf?=
 =?us-ascii?Q?zy0NXP+BQYMajNlhMylyZ88YRSjtB7KWLve5gnBmXLpwYilvjjjcu0FNEEq6?=
 =?us-ascii?Q?C8Tw8Vw9NFZ1oXhzdqCnssKJFRLcMKhcHp0dwMJ6prJj9+kFf1EoymLX499X?=
 =?us-ascii?Q?x3J30ryPo+KP8PInRe1CXAqo7G2tl3Rbt99cy3ofRlNP38OP40NtJpo1ZCKm?=
 =?us-ascii?Q?7+hIzuT99JU93lE4ZWyCoFpGc85AR11i/wOV+1yMgLNrTCcPKbRS4fO/oOlR?=
 =?us-ascii?Q?YXCVWhkJlRH5AJ+6erVYmc1bfY9FtVTnYTwrKLeNcA2jX+EhVlVu+WjbTyYD?=
 =?us-ascii?Q?7Y4JAl+GAHGp0E18D+VtMMTI6B4dHoYPz2/e0T5GS4gXMbSexWmjiob/WBfx?=
 =?us-ascii?Q?MNIjrI06uc0fN3m/TOmgruA6fX6YnY94TIn/n3JRujMOoMmY3bSBsnyDYFTk?=
 =?us-ascii?Q?NLjkZFAZSvGT4u3D/YPejulCeQpQ9lHUCKn0LHNxB8gMHApRVtq4Pa9EaDBP?=
 =?us-ascii?Q?Uy8xWIM8ZUmx2VCObzi5rsLgA1n78Q9mjIK90s+c2jbxcH0A5AoH4m4iTERe?=
 =?us-ascii?Q?NswdO5G/1mH8fsxp8P1sfMxHRCTnZCM0yFRwu/fG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hxM3Ix7Bx303j9VfNPbkckaaOaaXoJWgT6cjsU243ZhLJHoON1H8Ofw98zdXaKarlY6f2/vCVCoOmiX/ZlVPz58GzFVlnpDcYMnnfE5RVHYr4Z3SRxspyaJNBPiqpFsgY4hl6tvJuRxQXCEa6Z8fd+tY2/1go91Lvs4bQ2h8yy+sDn7cA+VMqeLi92sPV39p6fqfnJpY1mnI8BJez1Gg6Ea7X/no/YlfDwYKtJ9VsNC44yZ/Daxudv6gZa7+gqS1UW7tutQsIhuxcQSlg1ZWtaOjFcjvRb8Ht04+5lA1MmRb0JL0XocJvLo2Q1UofbHg2IpB9UkXszmI65yuUdGN6gFAn1zwrxvSaJ2VwNQP+gzkoFQo8NSo3NEjgWFADg/GDrubPCIvJdZc3KtU4grz845E39BzKLKzjnJs7Fl+ODwUT58hJ11pds2mUPLPc8gGIZTw7lq8/xgcQjcqVNkBUgwKx0l3RP35IFA192Flvsw8M3OZXTzGInfvLSY5ii52T1XU4zfrCtjxcMIjBk+rJ1AQ5SJQPdvGCFbRSoHhPgzPKkNUfYeH7j6Fj6gQBqbJJzyRiRJnFl3fHMhPQXsIyUIcJY3+kKJN9I48i65gmXo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4817efd8-e17b-4db0-f95f-08dcfcddcc73
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 14:34:32.9752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9Uf4Z/taMpkAh27F7aoqnoZ8EBqLHPWavtvnLRoFoawCjssbgP2+zRbJzr5dEnJE6BGGJgKM94NDQcU9hdGRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7445
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_12,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411040126
X-Proofpoint-GUID: paeVaQK2Z7N81zXAm-hRmJAKdYLTyRPR
X-Proofpoint-ORIG-GUID: paeVaQK2Z7N81zXAm-hRmJAKdYLTyRPR

On Mon, Nov 04, 2024 at 01:05:27PM +1100, NeilBrown wrote:
> On Mon, 04 Nov 2024, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > I noticed that recently, simple operations like "make" started
> > failing on NFSv3 mounts of ext4 exports. Network capture shows that
> > READDIRPLUS operated correctly but READDIR failed with
> > NFS3ERR_INVAL. The vfs_llseek() call returned EINVAL when it is
> > passed a non-zero starting directory cookie.
> > 
> > I bisected to commit c689bdd3bffa ("nfsd: further centralize
> > protocol version checks.").
> > 
> > Turns out that nfsd3_proc_readdir() does not call fh_verify() before
> > it calls nfsd_readdir(), so the new fhp->fh_64bit_cookies boolean is
> > not set properly. This leaves the NFSD_MAY_64BIT_COOKIE unset when
> > the directory is opened.
> > 
> > For ext4, this causes the wrong "max file size" value to be used
> > when sanity checking the incoming directory cookie (which is a seek
> > offset value).
> > 
> > Both NFSv2 and NFSv3 READDIR need to call fh_verify() now to ensure
> > the new boolean fields are properly initialized.
> > 
> > There is a risk that these procedures might now return a status code
> > that is not valid (by spec), or that operations that are currently
> > allowed might no longer be.
> 
> This seems like the wrong fix to me.

I agree that there is more than one alternative fix.

I chose this one because it's late in the cycle, and this fix seemed
least risky. I intended that further improvement would be done after
the v6.13-rc window closes.


> Why should nfsd4_proc_readdir()
> call fh_verify() when nfsd_readdir() already does that via 
> nfsd_open()??

NFSv4 COMPOUND processing calls fh_verify() already to verify the
current FH. So when nfsd4_encode_dirlist4() calls nfsd_readdir(),
that fhp is already instantiated properly.

nfsd3_proc_readdirplus() needs the fh_verify() call because it needs
to grab a handle on the FH's export to check the "nordplus" export
option. The fhp is instantiated before nfsd_readdir() is called.

So that double fh_verify() is already in the execution path of the
more complex READDIR operations. It doesn't seem harmful to add to
nfsd3_proc_readdir() -- but it's not terribly aesthetic.


> The only reason is to set NFSD_MAY_64BIT_COOKIE.
> 
> Let's just get rid of
> that flag instead and use fhp->fh_64bit_cookies directly.

64BIT_COOKIE doesn't seem to fit with the semantics of the other
MAY flags, so I like this clean-up.


> Like this:
> 
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index b8470d4cbe99..51b2074d92a5 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -86,7 +86,6 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
>  		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" },	\
>  		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
>  		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
> -		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" },	\
>  		{ NFSD_MAY_LOCALIO,		"LOCALIO" })
>  
>  TRACE_EVENT(nfsd_compound,
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 22325b590e17..a86b6f6a3b98 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -903,7 +903,7 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>  		goto out;
>  	}
>  
> -	if (may_flags & NFSD_MAY_64BIT_COOKIE)
> +	if (fhp->fh_64bit_cookies)
>  		file->f_mode |= FMODE_64BITHASH;
>  	else
>  		file->f_mode |= FMODE_32BITHASH;

Is there any reason this logic couldn't be moved out to
nfsd_readdir(), after the nfsd_open() call?


> @@ -2174,9 +2174,6 @@ nfsd_readdir(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t *offsetp,
>  	loff_t		offset = *offsetp;
>  	int             may_flags = NFSD_MAY_READ;
>  
> -	if (fhp->fh_64bit_cookies)
> -		may_flags |= NFSD_MAY_64BIT_COOKIE;
> -
>  	err = nfsd_open(rqstp, fhp, S_IFDIR, may_flags, &file);
>  	if (err)
>  		goto out;
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 3ff146522556..2ba4265a22a0 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -31,8 +31,6 @@
>  #define NFSD_MAY_BYPASS_GSS		0x400
>  #define NFSD_MAY_READ_IF_EXEC		0x800
>  
> -#define NFSD_MAY_64BIT_COOKIE		0x1000 /* 64 bit readdir cookies for >= NFSv3 */
> -
>  #define NFSD_MAY_LOCALIO		0x2000 /* for tracing, reflects when localio used */
>  
>  #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
> 
> 
> If you agree I can send that as a proper patch.

Yes, please send a proper patch. If it passes testing, I will drop
the RFC patch.


> Thanks,
> NeilBrown
> 
> 
> 
> > 
> > Fixes: c689bdd3bffa ("nfsd: further centralize protocol version checks.")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/nfs3proc.c | 6 ++++++
> >  fs/nfsd/nfsproc.c  | 8 +++++++-
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> > index dfcc957e460d..48bcdc96b867 100644
> > --- a/fs/nfsd/nfs3proc.c
> > +++ b/fs/nfsd/nfs3proc.c
> > @@ -592,6 +592,11 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
> >  	resp->cookie_offset = 0;
> >  	resp->rqstp = rqstp;
> >  	offset = argp->cookie;
> > +
> > +	resp->status = fh_verify(rqstp, &resp->fh, S_IFDIR, NFSD_MAY_NOP);
> > +	if (resp->status != nfs_ok)
> > +		goto out;
> > +
> >  	resp->status = nfsd_readdir(rqstp, &resp->fh, &offset,
> >  				    &resp->common, nfs3svc_encode_entry3);
> >  	memcpy(resp->verf, argp->verf, 8);
> > @@ -600,6 +605,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
> >  	/* Recycle only pages that were part of the reply */
> >  	rqstp->rq_next_page = resp->xdr.page_ptr + 1;
> >  
> > +out:
> >  	return rpc_success;
> >  }
> >  
> > diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> > index 97aab34593ef..ebe8fd3c9ddd 100644
> > --- a/fs/nfsd/nfsproc.c
> > +++ b/fs/nfsd/nfsproc.c
> > @@ -586,11 +586,17 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
> >  	resp->common.err = nfs_ok;
> >  	resp->cookie_offset = 0;
> >  	offset = argp->cookie;
> > +
> > +	resp->status = fh_verify(rqstp, &resp->fh, S_IFDIR, NFSD_MAY_NOP);
> > +	if (resp->status != nfs_ok)
> > +		goto out;
> > +
> >  	resp->status = nfsd_readdir(rqstp, &argp->fh, &offset,
> >  				    &resp->common, nfssvc_encode_entry);
> >  	nfssvc_encode_nfscookie(resp, offset);
> > -
> >  	fh_put(&argp->fh);
> > +
> > +out:
> >  	return rpc_success;
> >  }
> >  
> > -- 
> > 2.47.0
> > 
> > 
> 

-- 
Chuck Lever

