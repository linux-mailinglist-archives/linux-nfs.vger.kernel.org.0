Return-Path: <linux-nfs+bounces-3156-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3928BBCAE
	for <lists+linux-nfs@lfdr.de>; Sat,  4 May 2024 17:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9403FB2115F
	for <lists+linux-nfs@lfdr.de>; Sat,  4 May 2024 15:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC52A3EA76;
	Sat,  4 May 2024 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VGJMVSSW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oMVpRk4H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D93225D0;
	Sat,  4 May 2024 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714836207; cv=fail; b=N1XfzQuNy9PpWP9f6oRUOVVki07RCeWh8/xLeRwxQ99fRulXteuDiDJQSyjtcm/YIREqEoreYc3tYs7Q5oh/QvSEjKdDzYDyAb/gjKizITV6k0LuaE355ZixWRRyHS8mgELtFxqb4qZlTq8Oh3AJVq6VYuBPQ1cEl0QwtVZMbZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714836207; c=relaxed/simple;
	bh=ElAIRf8hqVSFiDIYdTLuRzPvPsGDKf8VxBv0SO5N2/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QXg1G2y+VYvhwlGU4e1aUiSbO64gMk8JOQJfY1w2PPo5eyh44Ixcjcpz9tY6abC2PtcWZ0JThppNB5CQ0jmrVwr5mTKqmhNaWyoVdqDlSFiG4z0qPB0APqm6jdrzps974mMtGjVVAB1Yo2QuoVmJ2tATNOIwWVV7OXcIjieTCoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VGJMVSSW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oMVpRk4H; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4447DxkK021639;
	Sat, 4 May 2024 15:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=xRyzXQhirvn+7C0FuwDEakupUGyUZXMTfyWikHJzhoM=;
 b=VGJMVSSWmGixNSv0WEJsNwa4aRlXB7i8qwW0iUcxYoWDH+NOUge4U687RXI27ExfCOLj
 A2P5B30AZhJwaSH7bCnsv2OGH0L8FE4M+ZwyNw0VodqHs19zBV3vy5NkNtL+WDTTvYBa
 C326sRBN+6zLqYqCQ89T3jifMtOH6gu1P/uLU4qVVN2qvfDq2T+z+aoMOnkBqj4dm+4F
 nnFFTcSxkaAApKCDs51sudkN35tmevKyRp3N32QsPN3kSlLSZs2aabmOpzwr1NhjIFKy
 KhUdyXw6e6Nyoy6Z2rNe2577keO3Pqcgys9oYqdXmSKyE9W9mPeGlqtnAEbQ3P78rWey vw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbt50f4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 May 2024 15:23:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 444CRAT6027644;
	Sat, 4 May 2024 15:23:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfbc9mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 May 2024 15:23:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6HB8S1vPoJNnYDSp+3aRI+D7ES8cn4KwRANN74dRyg3mgzgIZxGbB4C8x6G8MSuIOdXIRZCtfE8CsFLBnzV4ikD3gR1QbnZoTFFTR1FimBKgDA0cG0UfR6zT31/j6htztB4EOy2D9jI++dJ5RN/jNys7zMGZDpJlank3vFBTbPJNlyuhMxx4o6O1878mp3CLE/VdNla5iPQ6FqOxtCtT+U7SmHv3hxgezYDv/Jk2IxfjTq/rDPJNxWsQFhYBGwKKU7+KYRofo0okVmcFoUi3U/KDS4obO1eR6bJMruYjMPFDqE9BA/y+E1ULvtbJvc3FSibBNrDMbUgWin5FY5HaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRyzXQhirvn+7C0FuwDEakupUGyUZXMTfyWikHJzhoM=;
 b=XcHH+zY4ZiOEJmNCrINTno2wffWLmIOb1iH/CBfHZZMLVnJEh1BnOqs2X6qXjwf4ZEDxAz+rQZ4vPRhlAoGpDTTisZzWmiJrDZg2ihipG6dv7zO9hoyFFX1UgNGj+sDb+vvVBdFPIj+XbHwP87wSP3OD21GY5KhxTBjjQI1EIoQVuuaEApV/rnWLg9Ngpm0X+/JpM5jMuuN/BBdM5sO7EkGj86KeNH4uJZYQOveod7Y16ig5FoZvZuEqm7bFFjfORETtf9jH6AmZ5W4QrE2qdd1JQ6VLsJT4rHzCrNKoGP0eMlQMOn/C4V0dcIgHOhd+SYohTF74pDDexM3je9EYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRyzXQhirvn+7C0FuwDEakupUGyUZXMTfyWikHJzhoM=;
 b=oMVpRk4H+yQD3131cAe75Mv1RXtpg4BKurBal65GuQqMyzxAjC5F/lY0RCvn3DtraskeZCXoCmIDES5M3+uEh3C34q5ZhseJNsUxuvvID7f+FnISeiviWocJVQLISqdAI2K4HXsLM/DGPiurJgKxpmGpDPy5AUCbdPuaX6n43Dk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5628.namprd10.prod.outlook.com (2603:10b6:510:fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.38; Sat, 4 May
 2024 15:23:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.036; Sat, 4 May 2024
 15:23:06 +0000
Date: Sat, 4 May 2024 11:23:03 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, linux-nfs@vger.kernel.org, jlayton@kernel.org,
        neilb@suse.de, paul@paul-moore.com, omosnace@redhat.com,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3] nfsd: set security label during create operations
Message-ID: <ZjZS19+6m2L7KkFy@tissot.1015granger.net>
References: <20240503130905.16823-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503130905.16823-1-stephen.smalley.work@gmail.com>
X-ClientProxiedBy: CH2PR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:610:5b::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf02ec9-ca17-4c20-334e-08dc6c4e190f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AaSj5OOWVSXhtPpRZyIbQqDlFW6H3AO3E96YGRoWOSW6cbnj9umwqqEAFrgD?=
 =?us-ascii?Q?n/fjlSU/kmOZCvHHCsOFGlQ96aV8Xn+V9SH+nSAlknVwdX/04ftxEtuWkj/D?=
 =?us-ascii?Q?NBDK1dqek/wb6QWVG6nTvSHl9bcEQmPsw6nqH7qG/MGfZIUj4+l7tuu7enMV?=
 =?us-ascii?Q?RuyxanmjlIzlP9+RN3qCwATOI7NBGP5g1eJ6lN2waNMJ5TEG2RZVYHL5Qwuz?=
 =?us-ascii?Q?ifLpFmJQIT1Vzx7DxjfjSDjZYWbbHzOSKshUERzQq+EARzOiZtbNtHG5Xg6B?=
 =?us-ascii?Q?zKtxu7PwElhvcNv9fuhoxNvED/XlRO8yp9RaSNq08f0F8lFPgXkEKcr14I0Q?=
 =?us-ascii?Q?+/qTDdfNxRNdPTxqKr9OO4jjZ5gqra5ZMJPWr3/eE7isR6V9lSq7CCfBrbxT?=
 =?us-ascii?Q?6CxvZkVDiTE/ofUHxu4u3y4hLYHPd23LLGwGcyDNe68IAt7TesEyvP6+rcwr?=
 =?us-ascii?Q?LDdteaYFUPj/ofo7phGbRMN51gCvZQDAdz7vRkMSbk9ZxhjzYDdB7eZm+LSZ?=
 =?us-ascii?Q?ytWhZQ12ux1BaycHl+7AihRRt5tWaXadhmVK7r6x6KyO+2aZnfkMBkRewQso?=
 =?us-ascii?Q?FD/3nKG2MB3DurpzD1ae//ypoiwUc00GBsauagOBn15/ASYonSoczEamqQw4?=
 =?us-ascii?Q?sYx6UayiREOlbqlkcGlkmlS2hKOIAgxz/a4qNmEDFcDQZQmnnZ9CpYvC14/H?=
 =?us-ascii?Q?cd2Hth+27ZDtjhjc9+YAT2XS3mxelwRiWh2iGvlTqDoLI9yNQVkRBN1GdeGt?=
 =?us-ascii?Q?AfK9tAc2Yt+9mS5OozWV/F9kdtyVA0DKREKRNfYuHfktuxnfJZHiKhcWFUqD?=
 =?us-ascii?Q?OG/72gxO2pee6VsaB9C90782CEMiLdmI6Wl0qarqS/5MtLtNg5LCdTYvEwvD?=
 =?us-ascii?Q?/FZ0JASdbxbpgdtGszb9my4uYTF84hJUjuzikrYKHI0fwH8gLFNJTKiarMxT?=
 =?us-ascii?Q?arLSS3OZYTzD3J/+t8QjRwNJsddb+7XX1sS1TUc9WnIVNzGpyCZhQ6dGY9HG?=
 =?us-ascii?Q?WhMzj07poRm4h4d2Bw/x+xuMDHCTDOlB/Q8Q/XFJybIQHssTvrRzZtiZfic3?=
 =?us-ascii?Q?V4wKHfOT8cpJisoBryrS/Rqm+0+kraWkVisHqY/SvJmyb9YRaH5Vg8Ikt//9?=
 =?us-ascii?Q?oLY7oYFaw8J2TcVdUYa+xHCPNYVySn0GjIFuIycbpdwMvTb/AzoqwS94Yqd2?=
 =?us-ascii?Q?2cZhlOOZChsTkbUQ79z1uDjF0jEnc1U66TrP69UixJN3CLQA8pYwNWNQLCk?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BHHnj+u1nO1h7kxXOXkJz7Sk2B5lqxi1ikkwoxnavEQZrVK6JC5LHpekW9UT?=
 =?us-ascii?Q?X+zKlvypxIfcw3k/aflgvQszzoynEGvmTX/zBFTa56uKf1vQnLxUH2Yjlkit?=
 =?us-ascii?Q?SCqfm46z+ad+arX82MsMrPPlzy5b61Y/emJDCw5oCdB09jNHMCxWWzTSHeTo?=
 =?us-ascii?Q?QzTxxWbgtCI7R6t3B/TGPIIjVU2av2UdQSxshDin6EVJuUwueAKMbDIyL9sY?=
 =?us-ascii?Q?qQAYoQJhVuI0iGu0ZQxSpoFIQyTukW1obem9bY1ZEIVeGYuXER2NRoJD1W2n?=
 =?us-ascii?Q?3HajARWSXp02lQJIEbJvngPduUU6zq5g1sk1D2nr7FSwLimuy02K1b2aVpTy?=
 =?us-ascii?Q?b3AfBoUXIZt4bLOMkqaHH4UZphQmcSi2Ali7xfW+F+g+7mcrtKuQiyAX9nTv?=
 =?us-ascii?Q?bKzlwzrVaR0JB2eHRQeLFNUMd+HfRNXeNAS3gfJBAwWplbh1gElx09cM7fEv?=
 =?us-ascii?Q?MmNUdbfYsdSaSWEZfL97n4ciazP9PJA5Y0k9zoFzXaHrbG7xL9JkhHwaX86y?=
 =?us-ascii?Q?iS4KndMWRC5ok8ZOTQGGBUFSfP/LTM0haL5Wl4Q+qOKrnpeMWkT3s8sLXRNN?=
 =?us-ascii?Q?fo7Xovbdz9u8gMPCU65GhxF+1p6VEeW4806ZLHk76UM9vmbfgnsMeUeJPMYi?=
 =?us-ascii?Q?aDP/0nWJosasnYQOROPnEygyub/p6y4JsIh7ll7/geslGJDHOZNBXCtTd48d?=
 =?us-ascii?Q?GQypByj4EPrptyp1H1GpGc5Fr9ZWFv5qcNcp3TADMJirFxjyyZZGDzNczEY3?=
 =?us-ascii?Q?E4gee5b3s1/TMFIURW8H3BhxCo301cQIo5j34XbIF13jBc868hJYPU+P4Nm7?=
 =?us-ascii?Q?MHACJ3l2rUQ8iLfgHtIr/Byto3CV0nJLSpgdHxd8qWh9/QSIkQG5CMETTqJk?=
 =?us-ascii?Q?3S/FElDwFqIjzgSTHgdH799a+8cX4lsbz0S9UeanEHtxkZsgkU07C3KCPxh8?=
 =?us-ascii?Q?SL+V2gx73xIn/AtHU6/GOOHh4Fzrins5ocWTL/OhOdihhAU2p3Sj/FGik1SU?=
 =?us-ascii?Q?r+oM1NODvXWACgqVwC4weeoD4inR4D4Fyk8ahveNKef7RjrBCBTpM+gTvP8O?=
 =?us-ascii?Q?rl5QTrCDI1Y0N3+QFlc1aG1RMxH4ZEFQysKT0p62fCg9CbJjumM7A3Gx8rEW?=
 =?us-ascii?Q?QGa7BjrJs1cfnsxZ3fz3J/aeAzJc57xPebdSbm/Qy45bgqmaCEAjKg9rxP+9?=
 =?us-ascii?Q?rSgjIEsSxVblsw0NrRUZ8rxK6VP3jilMajNFjxh2XF3npQ5b2+juNQRuxgot?=
 =?us-ascii?Q?KabrY5GwNPtDiHaPhlckBFo3qCTTwi/XGSExAGtOslUfZXmp9hHFlp+rkP/y?=
 =?us-ascii?Q?U2PSypD5Yyk4LeMD9m84jcCmZXxnfzQgKS/CG9Z3HoZWIR7TnImii03IdyX+?=
 =?us-ascii?Q?nyyinhXhaQdaLFMkOMJVuSr6N5PaXRBEpNj+uq3dkk0ZISrXMRmqMgFnDdBd?=
 =?us-ascii?Q?ryvCKpksfhfXEmpi4I6r8ck9x29Ok5xLI+Xk6ss7A8VCXQbdNk5aX600GTXA?=
 =?us-ascii?Q?4FxYJAVoVGV+QR0A/oQG9Wzr0hqqTeQ7zvYtGlKDF5XQErCR0y1zZfN+B2ZO?=
 =?us-ascii?Q?FeYYhpyzY33Z2vgSazWTvBEEDctw0q64yMrJIa/r4CS4/Nz2VHSU+m7ihtYp?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	x3+Ewa8Aj8Dxe0LVhtLMIpmW5dQ+9/PBr2okAjXYh9XJQbsF8gpn+CTC6XfZ4GMMJktU1NIzbTQQawRcFTwJbIjvUIPcVKaGwQuICxlvsHS6XWRiKsHJeOoAXDOsltwrCrpt7KF7EBEN3v//L7aawBdGocedncyQcwmInAvSu9K98OaHGR5AzsU4pMialaY4yEUqhVXUw2zbssfQyHfEJexl0Sb4hsQihBYB/VcS0scORROJJRi1VWzrPwA4QJOFHLXz6O62d44FJ+BvrTTZ4X+wyDEaKTPJcyxfETL7KLDT3qNSJhcgCp1wpeTq4p0y+df1F5UeuhLHLKnQUJAy7wzmrVcvxCWV1ulBmGTt77p0ayQHp+Hw/r2nl1oUPvnxBicrhi8C8k0Y8mFISc8IiZXUELIyE2X2buzg93R0XRv4MuupChiffFYFnDbYqaSCUsicdYqs/ZPZeF4NLROMqsw0iAxt9mc4HxLIVHAp4VnZvzChWz+TvL81o2qtwtbFQa/aUY8RjrddKJbq9pVgkQWsvelsZZSfSt+euMGFEJKob688zoTBb2jq+GQofPua5yMUbdJY76tCm/mUeQ11mv9TdMM70ALMNl0lfluqNBU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf02ec9-ca17-4c20-334e-08dc6c4e190f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 15:23:06.6393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qlC89bhxx9WZOkwOgPh7iKhfmFBqWHuW+gyypQ5sdr2B5EpP2d3Ok8BWn2IBQ7XJPBdQ9/T8xbjNWZZPKWsjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-04_11,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405040108
X-Proofpoint-GUID: MiBZFdPVbksooXxWZCUN8ATBVlyEPGd8
X-Proofpoint-ORIG-GUID: MiBZFdPVbksooXxWZCUN8ATBVlyEPGd8

On Fri, May 03, 2024 at 09:09:06AM -0400, Stephen Smalley wrote:
> When security labeling is enabled, the client can pass a file security
> label as part of a create operation for the new file, similar to mode
> and other attributes. At present, the security label is received by nfsd
> and passed down to nfsd_create_setattr(), but nfsd_setattr() is never
> called and therefore the label is never set on the new file. This bug
> may have been introduced on or around commit d6a97d3f589a ("NFSD:
> add security label to struct nfsd_attrs"). Looking at nfsd_setattr()
> I am uncertain as to whether the same issue presents for
> file ACLs and therefore requires a similar fix for those.
> 
> An alternative approach would be to introduce a new LSM hook to set the
> "create SID" of the current task prior to the actual file creation, which
> would atomically label the new inode at creation time. This would be better
> for SELinux and a similar approach has been used previously
> (see security_dentry_create_files_as) but perhaps not usable by other LSMs.
> 
> Reproducer:
> 1. Install a Linux distro with SELinux - Fedora is easiest
> 2. git clone https://github.com/SELinuxProject/selinux-testsuite
> 3. Install the requisite dependencies per selinux-testsuite/README.md
> 4. Run something like the following script:
> MOUNT=$HOME/selinux-testsuite
> sudo systemctl start nfs-server
> sudo exportfs -o rw,no_root_squash,security_label localhost:$MOUNT
> sudo mkdir -p /mnt/selinux-testsuite
> sudo mount -t nfs -o vers=4.2 localhost:$MOUNT /mnt/selinux-testsuite
> pushd /mnt/selinux-testsuite/
> sudo make -C policy load
> pushd tests/filesystem
> sudo runcon -t test_filesystem_t ./create_file -f trans_test_file \
> 	-e test_filesystem_filetranscon_t -v
> sudo rm -f trans_test_file
> popd
> sudo make -C policy unload
> popd
> sudo umount /mnt/selinux-testsuite
> sudo exportfs -u localhost:$MOUNT
> sudo rmdir /mnt/selinux-testsuite
> sudo systemctl stop nfs-server
> 
> Expected output:
> <eliding noise from commands run prior to or after the test itself>
> Process context:
> 	unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
> Created file: trans_test_file
> File context: unconfined_u:object_r:test_filesystem_filetranscon_t:s0
> File context is correct
> 
> Actual output:
> <eliding noise from commands run prior to or after the test itself>
> Process context:
> 	unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
> Created file: trans_test_file
> File context: system_u:object_r:test_file_t:s0
> File context error, expected:
> 	test_filesystem_filetranscon_t
> got:
> 	test_file_t
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v3 removes the erroneous and unnecessary change to NFSv2 and updates the
> description to note the possible origin of the bug. I did not add a 
> Fixes tag however as I have not yet tried confirming that.
> 
>  fs/nfsd/vfs.c | 2 +-
>  fs/nfsd/vfs.h | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 2e41eb4c3cec..29b1f3613800 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1422,7 +1422,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	 * Callers expect new file metadata to be committed even
>  	 * if the attributes have not changed.
>  	 */
> -	if (iap->ia_valid)
> +	if (nfsd_attrs_valid(attrs))
>  		status = nfsd_setattr(rqstp, resfhp, attrs, NULL);
>  	else
>  		status = nfserrno(commit_metadata(resfhp));
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index c60fdb6200fd..57cd70062048 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -60,6 +60,14 @@ static inline void nfsd_attrs_free(struct nfsd_attrs *attrs)
>  	posix_acl_release(attrs->na_dpacl);
>  }
>  
> +static inline bool nfsd_attrs_valid(struct nfsd_attrs *attrs)
> +{
> +	struct iattr *iap = attrs->na_iattr;
> +
> +	return (iap->ia_valid || (attrs->na_seclabel &&
> +		attrs->na_seclabel->len));
> +}
> +
>  __be32		nfserrno (int errno);
>  int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
>  		                struct svc_export **expp);
> -- 
> 2.40.1
> 

Thanks, Stephen!  Applied to nfsd-next (for v6.10). Review comments
are still welcome.


-- 
Chuck Lever

