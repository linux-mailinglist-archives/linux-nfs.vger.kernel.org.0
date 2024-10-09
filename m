Return-Path: <linux-nfs+bounces-6994-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33882997923
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 01:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A4E1C21EDA
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 23:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A1A18A95A;
	Wed,  9 Oct 2024 23:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rk4K7BQL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dh3KiHPm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B584417DE2D;
	Wed,  9 Oct 2024 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516641; cv=fail; b=eSHTu71yagesvXp2Rd8M/lxBr7r0djd56mPTAozd6R4D+kEbj4E9NMw+IKZU55OSrDm4/s/vYIe4yW9p67k/G6Oe/dEZqdAMTmMfm/AMqwgIuOZPBG/z9JV6dRD1B/MxyGuRgZ3L8Fpe8RBVmRQZcQsrdP2PZQYsunE0a0FI8J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516641; c=relaxed/simple;
	bh=qWp7292p7cPxfXzYRwkn7WLOAc7dxCzjLlLNATRNyH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fm22TzZC9Y9mPRSkbT8Lt3HwGd79xRQ5D2Qbwd5B1e1/9vMdVIEFPWxv9i//wq3Hi4EWbbUixqs/h5SIjTfzwc92SJsM78ARaTFGivUHwyIloTDAGwmnDQxv23JaTIOhn/xF/yLFAXhsHFd58Y+VVHiNB739/k12rN1ulb38g+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rk4K7BQL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dh3KiHPm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499LtcEo026014;
	Wed, 9 Oct 2024 23:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Rlk2IebgrwOWpGM0B1
	X36hjh9OpXNGwh46R3obBvIlc=; b=Rk4K7BQLijhrRrmniTZhbviHLfKNo0Ka2y
	UVAh0Nax3gkj51JO7j0SLyiAVEOXcQQd8q0G38WxU9RCh3Uf+f7PPo+0ZVYyiCx7
	Z3h0zznI8VS/MQA2mQ7AaYpCnxByHfjKaI0IGQk7nRL0D1Pl1Y3K0UEgMLZrOkwK
	MDfQVEfdaDmwptp7OXxSygnRyArkyGHoQxD6G8PPhd88TC+hZ7evbw2bPWViSdtm
	b00LWDRmcg88DA8XhYAJjcJdkR57Z37g+9ogvqTwXtuY93SdmIL5tA9tAbM96TR1
	UBQHSWp4BJR1dEoHEVLUogcePlTVEShZA531eSjhn5/0HJecVSwQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300e1qtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 23:30:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499NKCMa019072;
	Wed, 9 Oct 2024 23:30:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwfkyhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 23:30:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaBDvyPgXL2vpOeteELVxj0FsavorK6I7gkGPoLap3VBqXtuiaRVSyYF3Ofs298ouwyrPnYZ/g/yQtQ0zkw0Gn43tuNc3NeFlRSnagUxUIkZG5GfC5vy3PntLZqVUdmr52+cshNZ7HYTGogMnsEEgci0aQ5Y63luLZDSfUtHHMbjfqF/WYGe+YcGbK51B9VpdMbVxK9kdaWHpbZdxlW+dQnMJiYCSOZHBc3MrMUp9ZRqXQs7LtZzhBWrNtnOpyFsBZSDzle/+FpDRAPAH4lQ12m2aLrPFMtslVZfPn0d/dUiWQkTFPkBbcO1jzbCfkPHYpb3Xo5+n2DKGV0pMeuSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rlk2IebgrwOWpGM0B1X36hjh9OpXNGwh46R3obBvIlc=;
 b=mJJcPpygYs7FHBdzNT7PuSeC1SjM+VPIB6KIMz9PsMSS3UYAveHKhQzzbkcNj++gWHPqpSp3F2XnUjztMCuxxcGMcCUwza3LNDOvbOowumvCtSgZsCvUi5kCYOl1iyMQ3tfnWUFMqs9pZuMuBloROwCKL3CMsBorQV4RWzMzd5TWfutZtk5AURv2bU//MahVKo/bYSWHMjkDyBfb+I8LermKORbKviWasZmWV+elk592AFx7WxAsHbaD+70SDMDjgglIRyy0ncagk+OSlMPCGWcTaB1aS/sS+2PI5o4na4HfZRq5xdRzQrjqHP6cOpjNdhjCt9WROOBrYzSOgy5apw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rlk2IebgrwOWpGM0B1X36hjh9OpXNGwh46R3obBvIlc=;
 b=Dh3KiHPme+nKJh/q9QtGu4VIfXX3sWrTiF+uhrSiIzmziQSeyJtR9znmds5rBXknEEbc40Ygo62hqAYBZ1JQnJUsUqoYJ0WMUhiEndScxTpnI0UwGLq8q+OppdBaGdDIl/6HDKEtkgHyw7a9JBFDGQO6UkJQNWiENCDeMjsgr8Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6827.namprd10.prod.outlook.com (2603:10b6:930:9e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 23:30:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 23:30:23 +0000
Date: Wed, 9 Oct 2024 19:30:19 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Fix NFSD_MAY_BYPASS_GSS and
 NFSD_MAY_BYPASS_GSS_ON_ROOT
Message-ID: <ZwcSC4ZWihv/PyV2@tissot.1015granger.net>
References: <>
 <Zwbfmf3L5XphaiGs@tissot.1015granger.net>
 <172850484738.444407.17004521090739639063@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172850484738.444407.17004521090739639063@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR15CA0004.namprd15.prod.outlook.com
 (2603:10b6:610:51::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0e6eb9-54bb-473d-e725-08dce8ba58bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/B0JM1g5XruFp3kj4zqxzCuoQ9r9rUdISpaYLkm/V0CcqfZAg4y5a4Jc51Mx?=
 =?us-ascii?Q?evG69RXF5movZubbL+DEjhnuejVbVq5oHAV9hX7s/rSwSmKqmD/F3R/vmKx4?=
 =?us-ascii?Q?Zf+MhOoYM+mLxk7QKaLJ/2y8K1Oe3jlJ7VgB2XrFjCO/tOizTGn+QHWx6Lla?=
 =?us-ascii?Q?WIbAnWFs6GY9+QxWyi8vj1gugA84jyNOektyWdg1quEIhQD2mplbUjmcaiIA?=
 =?us-ascii?Q?WUvy9gzZfxyGCP3LrGG/3udMGBAqa/bBMFEQShUHaiImukY0/lKz+3cdDsvq?=
 =?us-ascii?Q?gPfl7EDQGiWO35S7J8ZnIUJkuksERehZ6soR1knmRLrxePS7IMwfBc+addcn?=
 =?us-ascii?Q?78uQ5zMoSqgZ34m/z36LUTYHtzjhTzv9/paWe+etTF4Gre+ZOzKlarprEBQC?=
 =?us-ascii?Q?yXQDoPdSlp+DffWwuSgVHRqBPeAOqvFl8HwuZdG9SEQ0uN9CSddLgUjBIUaL?=
 =?us-ascii?Q?HLTYBSGycWZDXaHgvsG+Dwe2MEMGXt6RG0+pqGlsSE13/6gGscqoP6xP2Tar?=
 =?us-ascii?Q?DzdZTz88jtv3XXm1mrqzBzSFTMkg9eBXDKAgM3S00uSljSzo+sQNhZJpfyRH?=
 =?us-ascii?Q?dIu9olNrOU+bfAfiyLtPbjHslwdvXotpQ6PlZhaV87aVsbEsG4bhfa0p2uVE?=
 =?us-ascii?Q?iHXiCKLsENSZSE8nCqX07ufVotT+QeD7PdwxxFgMkhDQlfFwnwghXlswJDrl?=
 =?us-ascii?Q?M9lilutBshZ3hP9gR6FGtg2jKCGE1TVOx7w+uzhSnz4wdsHpqsbYeKlhQAJO?=
 =?us-ascii?Q?Cd3iJY9nApmvOW2x2xNuZ7Fs96v9MPEHvVodrLtVKyDXLeiZGd9byjjRWwJ8?=
 =?us-ascii?Q?3R+N179M21iQX2jizHLp+CR2kWOP9gkOmiMuRSI+iXEHwcbEIiH3UuRy5nfI?=
 =?us-ascii?Q?FWOxnpcL314kW3034zywlHIP5ScROvtSnmkZMY96CU3Hbmxjk7IJcUzydD2s?=
 =?us-ascii?Q?IXRgKcgZMJf1oTEKiHt4DYgiiWdf7FKz8wizQhYfcr/XpIgeTVxodUXu9jE2?=
 =?us-ascii?Q?xWkKAUwubRvEG6H1YxEZ9LVQlwj8AcN+c6Pe+XTgNL83NljrK0qTdg8P0Izw?=
 =?us-ascii?Q?PKX2l+Fn7/Hef77eOn/GqHmrcIEKNqZfmz4XL4SJwk2SO2ql0AYp5N9F/z8k?=
 =?us-ascii?Q?5AHfsc0JeCaqWU/Z8hugufSkowY5mLyf88BxaSYFIWplTbIjrhYXmSMNbWSI?=
 =?us-ascii?Q?fr4y+PtF874fxSPw4LI5ojxMQaEY0o91HJpYJ1y+gKoa4vqxNJBCyiU4bUEM?=
 =?us-ascii?Q?rmfl0JxFn0GaVzIkVhEwEB3IitHncD9RvQxg3jz79Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r92mntzduRQUL8SapvA1p0XK/l15ArItujx62HKdam/Shmddi2n09Mo9HPN7?=
 =?us-ascii?Q?4/+sZGgnI7kBcAxrWXVx0rY7TWeQ+5+YuiXKU5Z/F/bf89a3EX4BC6MYd2Ya?=
 =?us-ascii?Q?kqXVaBzvCU/mC4nOCnVkvkPSjfYsRmzPHi/8ACgkykNXIGJaXq7uc+XXTJRz?=
 =?us-ascii?Q?vgCGg+jrAYbtKjV4zNIkuUtfJrr+6libZUvs6apyovfNiaXDThE0KZSe7o1Y?=
 =?us-ascii?Q?tGV7US7QsHK8uPbrUE5DC1w6aOl88p9Lg+9r4tQM0sz1x7Ei6CIHsZ1qF92q?=
 =?us-ascii?Q?RZ6WUrcZtu+/X5N7YKUchbkZYehD5wvAPnkG7W9av1z1O6E+rgcUP8t7DFRy?=
 =?us-ascii?Q?1HSFJ7JII1MDYVBTPiyJ9e8dDobv2VzEYoBcBbb4x6Y5G1/mn9jomiSVY/Oi?=
 =?us-ascii?Q?vIXJnMSbyFJuxjWDJvAkajOMe4QUf9sH3LAWJdqgTYV8aWLzuxChnYi5+gha?=
 =?us-ascii?Q?EvnJhnOCFnpnlwgtPXk7cCoVus1FTHETI+VF1D1CrRy48u+aotSoDNyAZV2H?=
 =?us-ascii?Q?iUw3z6aAjgxa8v8Z8T2sH9AnLnX/xpIbN+u+jWtce4DQipLwnfVK/kQuGd4H?=
 =?us-ascii?Q?GGrrw4c+ceYSUN8oJD1QCHnMbNrZkPowiZ9nTX3/XXKVV/nKjqgSyVSV3CRc?=
 =?us-ascii?Q?1EMf0iov7/FtAIYMmICWRt8bEASDPwTqTjgxNLhDfYjzSANjc0/bpCytI04l?=
 =?us-ascii?Q?rd1XTz4eaF6rwXB4Xn6rbLJdpLNH9pzJKFwufJYlieE5uOKkgnNN9x9PLF3X?=
 =?us-ascii?Q?xaC0vPTN7ESmQ3+N+YvJeO0LOylOkFp6n1UMBtokbKNiWSNx9CWLKuQJpKLW?=
 =?us-ascii?Q?mBoYGR+oJvmvEzOG8dxbPBEtNmnho8eVEc8VOiP1oi+hkIRQwcHQ1n1kO+q5?=
 =?us-ascii?Q?aVCXAt7xPyDuSxPWxPD4thA7RzYTjQOJ/VXmH7LvS3uTYzZItnuE5ztdUwqx?=
 =?us-ascii?Q?nQ6CCZia1NHp8OdzW9gR9DIpkxHltsA+FPvQ48aQ60GZ/cAWeDUNExkiW5/c?=
 =?us-ascii?Q?2rmSpb0TnuG1J4ySnaYmUILdK3u25xKg1jKd2t8zDUtrdj6lk4wXk5UbddOv?=
 =?us-ascii?Q?uv/b1trtLHnZK9BMLMCcxe6XzrS+N7igpTRZejzGgnvkrJeRMkMuUYrZ236Q?=
 =?us-ascii?Q?NmaSuSjLsBZHnyfvscXFJgyqBQgo4Er2UkkQtfufx3/6C+h04fqd4VUyKjWx?=
 =?us-ascii?Q?FVlVUVtayZRVJ+6X1VSoF9uGK7/8YjPQo+hR5tfgnAWkC2uEDsl8ZAkIgeue?=
 =?us-ascii?Q?XySNbbR8M6QIFig8JpFb14G1zyXDFjoTyaJJHnXeuyr0x7quLVKndTVDzUDZ?=
 =?us-ascii?Q?VD9+U6q8Nee0er7/hJ8gK6AdxjChZEC7Awz29yiV/Y+Utm+1NLlHZgV2mMc3?=
 =?us-ascii?Q?RJwfukTGxDxLjMK0erVWucT8evxuQWC0zEi6148FMwNk8AMVvqvNhSBfLhuE?=
 =?us-ascii?Q?dnoZQPhPp9qhz7jJOMwo1v9+SPX3ivw71SPkaPh/vH+xfplsG2bE/9A5OmJI?=
 =?us-ascii?Q?td62V9yKwL64q8lxq9WNe5ihNAY184y/Z16zmQVeX1+VKuv6DMgDRvvPmX/A?=
 =?us-ascii?Q?lxgTAnFD9GfuoSREL3Zm1RtWfhYFKJX79nQGNqNSi2VNcOAGvecYSaQWK9fm?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	11zOJ+Qd08b00w1sNkWpVGRIH3j5ywcTHqw9kdJnaIH32q33rp93lpClV+JfDwQQ9xwdrDx8JVfUxDYIfXNqpfGjwn6TBcqLUwB0ThCITuySgyWjIknbiMiPHG4ytN3U2TUyM76dySnJXWxYTcS4kAu83Cdg5TcsClLqYdM78XrERkM9UaPOT1pVpHIN+OZsw5AV9UpfZuOXmmXqG5l6Jm6HYqxo3suajj4uTvwJqFYPEYNQniQgOAuRbFq319gma2je2q/fjlsiQvxmXyw3nQbtikHITGQGwCd1p+/XuJ3Y7scBnVrtvlOeDqzOXXEyJixkgQs3yrDiNlXYQP4WBx3hGJNx7lANLwivc+y2dDCnACCTN94WLiiUpGG8DFhJlsJh9HpZzSslg+P7HfLg+TZONbQOBQC4OjwIGtkatjQJyMHo2d1cpuWvnPUh4lSaJDeXWqLIj2xYEhtUfYRnZWyK2YKm+Gb8ba9VZoQH87LDXlbfcdeyk0eSs9MhhaIP1gaDMNHyxUNmeW6AhValwD+0yviEQefQxLY1ZRKyhgf+YM+bmLyILF1VqifpMyUjMVY+yZDNl/aC9wXi3BZmENVjreSlg0JnYq5FWtLBgcw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0e6eb9-54bb-473d-e725-08dce8ba58bf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 23:30:23.2634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBSXV4dAM1F4DAqM+28Jc4WTC34Np/0slLTLaWBs4vLWq29qDnDL+OBd3GsljjJaxzh0lCMfzrtN+lu5ighBGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6827
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_20,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=872 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090145
X-Proofpoint-GUID: Tthz1jUf05JzJcutLN7E8earoYdiQU4z
X-Proofpoint-ORIG-GUID: Tthz1jUf05JzJcutLN7E8earoYdiQU4z

On Thu, Oct 10, 2024 at 07:14:07AM +1100, NeilBrown wrote:
> On Thu, 10 Oct 2024, Chuck Lever wrote:
> > On Tue, Oct 08, 2024 at 05:47:55PM -0400, NeilBrown wrote:
> > > And NFSD_MAY_LOCK should be discarded, and nlm_fopen() should set
> > > NFSD_MAY_BYPASS_SEC.
> > 
> > 366         /*                                                                      
> > 367          * pseudoflavor restrictions are not enforced on NLM,                   
> > 
> > Wrt the mention of "NLM", nfsd4_lock() also sets NFSD_MAY_LOCK.
> 
> True, but it shouldn't.  NFSD_MAY_LOCK is only used to bypass the GSS
> requirement.  It must have been copied into nfsd4_lock() without a full
> understanding of its purpose.

nfsd4_lock()'s use of MAY_LOCK goes back before the git era, so it's
difficult to say with certainty.

I would like to keep such subtle changes bisectable. To me, it seems
like it would be a basic first step to change the fh_verify() call
in nfsd4_lock() to use (NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE)
instead of NFSD_MAY_LOCK, as a separate patch.


> > 368          * which clients virtually always use auth_sys for,                     
> > 369          * even while using RPCSEC_GSS for NFS.                                 
> > 370          */                                                                     
> > 371         if (access & NFSD_MAY_LOCK)                                             
> > 372                 goto skip_pseudoflavor_check;                                   
> > 373         if (access & NFSD_MAY_BYPASS_GSS)                                       
> > 374                 may_bypass_gss = true;
> > 375         /*                                                                      
> > 376          * Clients may expect to be able to use auth_sys during mount,          
> > 377          * even if they use gss for everything else; see section 2.3.2          
> > 378          * of rfc 2623.                                                         
> > 379          */                                                                     
> > 380         if (access & NFSD_MAY_BYPASS_GSS_ON_ROOT                                
> > 381                         && exp->ex_path.dentry == dentry)                       
> > 382                 may_bypass_gss = true;                                          
> > 383                                                                                 
> > 384         error = check_nfsd_access(exp, rqstp, may_bypass_gss);                  
> > 385         if (error)                                                              
> > 386                 goto out;                                                       
> > 387                                                                                 
> > 388 skip_pseudoflavor_check:                                                        
> > 389         /* Finally, check access permissions. */                                
> > 390         error = nfsd_permission(cred, exp, dentry, access);     
> > 
> > MAY_LOCK is checked in nfsd_permission() and __fh_verify().
> > 
> > But MAY_BYPASS_GSS is set in loads of places that use those two
> > functions. How can we be certain that the two flags are equivalent? 
> 
> We can be certain by looking at the effect.  Before a recent patch they
> both did "goto skip_pseudoflavor_check" and nothing else.

I'm still not convinced MAY_LOCK and MAY_BYPASS_GSS are 100%
equivalent.  nfsd_permission() checks for MAY_LOCK, but does not
check for MAY_BYPASS_GSS:

        if (acc & NFSD_MAY_LOCK) {
                /* If we cannot rely on authentication in NLM requests,
                 * just allow locks, otherwise require read permission, or
                 * ownership
                 */
                if (exp->ex_flags & NFSEXP_NOAUTHNLM)
                        return 0;
                else 
                        acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
        } 

The only consumer of MAY_BYPASS_GSS seems to be OP_PUTFH, now that
I'm looking closely for it. But I don't think we want the
no_auth_nlm export option to modify the way PUTFH behaves.


-- 
Chuck Lever

