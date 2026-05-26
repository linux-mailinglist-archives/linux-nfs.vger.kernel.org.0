Return-Path: <linux-nfs+bounces-21991-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KILnBBIUFmojhQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21991-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 23:43:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E9D5DCD6A
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 23:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 338C6300DDE5
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 21:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88F43BF68D;
	Tue, 26 May 2026 21:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p7sHxJY3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rZAwcysj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4C5274B5F
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779831823; cv=fail; b=bNiMgfxkjwUghR1jaRVEwNsJrAY1MCS9YSfw7xC3yV2GJtaLH181E78zdeZSt15ioQYfmxb3U93D7L5v8Z/Z3W+IrBymddKrCiCvHziI3EeUcdr56YQMir6g6yiosE/ngRqE68yOko2XckPBdVdU59dbrSFceSLo19g5wTqlcQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779831823; c=relaxed/simple;
	bh=rzzUI0UrppHtyiDKybn0ZYRJbgOeQi3Gd+RwIEqCE3o=;
	h=Message-ID:Date:Cc:In-Reply-To:References:To:From:Subject:
	 Content-Type:MIME-Version; b=TPunVguvc42LI8jDE2UNG+Vxexj/8E4edXDmvg8I5VUPTFqlRBABfhaF2r/sTBgzkBe2mgmqsQtG3P5+k3Jl/0uDPB3qICedwimeix7EyndlteoIQtUUWcRRgfpOa0JXRICZY2tYN1oW29R66dugWnEXqbnlA6++31htS5ZInYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p7sHxJY3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rZAwcysj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QLBelb3566045;
	Tue, 26 May 2026 21:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hzrnWmrui+M1VtHhCNkC5Nc8pgLiHzBnk1nrMW2ZEDE=; b=
	p7sHxJY35Tv+D5hldLe5HbjKb81QnSwOR8AxWEQzrEO7cZfGJJcDWSJiJsW6zhNw
	8zo+hU8rpFIy8STa3Iq2GMjHtRbgS2pkGQzErIIykWdJ7WTXeCmfD4pDLaEoExdg
	xxp2Z4+LVHikIIQSF0wfN/bQ6uf7O9P7SiyDJoe1O2KF4qljvMDEjPulikYo5lan
	J+99ZGyUEpEbxw847w7hsh71fuftv06k9eJe5iA50e6Sbm/vRCw5kxU0Mg2pihli
	lOLM91blFUrGVb157/si8BXbTEHSnNozBxdoQM2EGtSLcGdvZ3WHSBqOIlre9IbI
	d7+nIQKwRrwIV4O3CASvfQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eb495mfx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 21:43:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64QLa6rP029977;
	Tue, 26 May 2026 21:43:28 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012048.outbound.protection.outlook.com [40.93.195.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4edjse1qjh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 21:43:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1L3VULIqHkl1UXCY+XHtSHrQSQNDJAH2EXz2p6+8eSQRDRqBIB9h4mNTtqrGUyeVdMSJ+w6/N3d+1qf8xRX07QgiOVE4e39/qC8uHzFQ7tu2QOAbFVv+4M83FrM/S5bA2qvEa4inmdpApmYrlPppR52yPLdV4vb8DeAX3mBSo8ftZQQh8z9YHVs3Lo3SwJpEcn0VvmEJFuEFt/pUszdN7o2RtQdBkTfDsmQh1+UD5Q5wUr4AL/xbdHxqt6qy/Gwu9t4CzTnaQVcVcHx1Z6t17yBkr1cUxruQoPRVLoL6YvQcXJiDuBJ8yAPojRCWtW69JYMOhzKFh+DWeV5CorRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzrnWmrui+M1VtHhCNkC5Nc8pgLiHzBnk1nrMW2ZEDE=;
 b=GvkyPYSm6y0BNTzLDpMtt4fLygJv9knR+dBK3ix+LFYy7u7TyKzMpYQoZprzKn/n+o/IqSP5bDwDbJzwjK3lbfozRZTmX8xd/pJa8RcgqKjDdaWTx3PNa6iD1wMDZK1AcXPY5Y+K337Cl86hE79Obaismb5jBErXo+0Os8zsvdpFPpn9oL3z1qpNbEKoPpFjquViJ/vyOLbF5iLFukvUObe+cn3CU7PBfC55HZDvtoB+FQaUgaqoUEhBhvXAb9nF5yl9ttSj1j0SjqlIBa+djNpMX6t0YlHWbi7ZE5G3mYGNF9FpgoLlrTQFD5Cq/HveKQBAeXYXb8ft2HFuGr0cSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzrnWmrui+M1VtHhCNkC5Nc8pgLiHzBnk1nrMW2ZEDE=;
 b=rZAwcysj1InOTZghGCUqq29Jc9VUf44gTdgcI3OoBo+3UFs3vwEiHM9TZYkU8a1mEWYrGQ6aEIaI1VMABPheX3Kzzmnhai58dcDca9povyVUCAF4TighEXhsW2ZHIoNoqwV/B5ERaNkZl7KenSVLRKb+z0hQEmOYPCbCBMzV3+w=
Received: from DS7PR10MB5151.namprd10.prod.outlook.com (2603:10b6:5:3a4::18)
 by SA1PR10MB6472.namprd10.prod.outlook.com (2603:10b6:806:29e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 21:43:24 +0000
Received: from DS7PR10MB5151.namprd10.prod.outlook.com
 ([fe80::4ae:1ca9:6ccd:7525]) by DS7PR10MB5151.namprd10.prod.outlook.com
 ([fe80::4ae:1ca9:6ccd:7525%6]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 21:43:24 +0000
Message-ID: <62a13421-2201-47be-8b3e-799b9e278e72@oracle.com>
Date: Tue, 26 May 2026 22:43:20 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        syzbot+60cfa08822470bbebe44@syzkaller.appspotmail.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Content-Language: en-GB
In-Reply-To: <20260421161126.129533-1-cel@kernel.org>
References: <20260421161126.129533-1-cel@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neilb@ownmail.net>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
From: Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
Subject: Re: [PATCH] sunrpc: prevent out-of-bounds read in __cache_seq_start()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0103.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::6) To DS7PR10MB5151.namprd10.prod.outlook.com
 (2603:10b6:5:3a4::18)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5151:EE_|SA1PR10MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: b0501596-6770-4be9-db13-08debb6fd016
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 LwyHx0rA5nH/IqjJ4Piku7wFVI91O/4aSooZ0Eaic7Zz0i27qC2k+nltXXe+RqelrpykvcgqbldoLjwCWxuMlGsxmWYAbQAqt9tYmN40NmxD633eqwiE7iALAhEt2HKVmO1HFYMKmSI5kpNVoy7ksO/syptMT0cNOZiUtvsc6sDEMkOhd9GV21HiU6XEKWai7Oe/MFmtfPe7V09fYvBTI33W6tGdhjzriT1ukF3zrf8NZ+7yzxrC56Z2eXnYeWl8fKJvRuaaKDjEWWb1oc5u5KfCZ+MWdei0H0wcl5ISuXwZjSee9A+sq4p/bka8M80VubYnCUlft9CZW/ArVqryBT4vYLg3ojkXx7VANZetH+goEdzHKJUc25OMludIaV1BHCdi0DCZ/2cj4z+vwz0e3FMliZmgUnlwMVwJk84k/qYZQs2ZdlFy0VrUwR+FqUPy2p30I5JE4BRu9f/AzwCHaMGmM8h0CEKx+UQ/DTuatW5wfZLR7EflxhM/c/0Bm5DL2n4i5R1f/rSRS0XdEKFuoRANPXPeSGt/wMVrvQGT6tQfKSWE9Qkn0u47BvSdlJ+HvMQVia6nqYXBmBBfe+AiHRjM2WY0DBoqWmYPbN0IIvcr6Yk9pdO+cfBJzHfzu+RGLA+ixyUevjT1/mV1A2q07g==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5151.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bnFpamNUSTc3V1lRcWlhY1FIQ3QxOTRjRFFmNnBjVWZzVDVLbkZDdzN2WGRS?=
 =?utf-8?B?Um8wWi9YdzJzMDRuSFhuNHRpY0FtekNKUURmUVVRR0tVL2kxUThVU25aQnNq?=
 =?utf-8?B?T2Y0bHYwVXEzNUh5ZDYrbnlnMmFacE9SOUhxV2xZWE83KysxTHJlQjNlSVZC?=
 =?utf-8?B?UmVVMFRQbTZQL3d0NXhLZUtJWXdmUnlpcHFSMGVLRmdWNmd1eEJaZDdSeThY?=
 =?utf-8?B?d2tmZ21QT1ltNGh1UzNxMEVMUElZZmg4Q2F6aStzNW5HNGZnRVdDYTRZQVZw?=
 =?utf-8?B?QnA3RjIvOC9rbUxEYldzNklTYVpGRlFKRkFqUnAybDdnUGtCUWtWUU4vVDZp?=
 =?utf-8?B?RW5vajV4Mk1qNTVGdy8vTEMyTUJpblg1d1BCVVJVaFFyRDl6a3dSWFpvYzBS?=
 =?utf-8?B?WEozS3FlQVlZVC83MWhtU0YzNzl3MDFVVXFkTkNRcUQ0Z0RxYWRwRm4wR1BK?=
 =?utf-8?B?Ukl2ZmdNckV1WW80cnFwR2NRbnk5Wk5SWkVhRWJaRFFJcnZ4M09Zb0xFbUxx?=
 =?utf-8?B?ODduRlhMWDF0YmdzbzBMbktUMDN6YUZpSSsxcCs5NXJkMTN1SFVsSmk4MEtl?=
 =?utf-8?B?UDUrT2pxYTB3TlJFT3VIcHdlVGZ2THZma2Q2VEVjcW1ZclNibTJ1M1o1Qk9t?=
 =?utf-8?B?akFaUTBvVEdFSlZZc2JCcytvRzg4bWQ0aW94NzByd3pNUzUvTWovZk5teE9D?=
 =?utf-8?B?TU9tb3MxaGgxQmlSQndIMUlqckFlQkFvNjZqa1F3SjFteG5vOGVJUFRYSlEv?=
 =?utf-8?B?bW9IZzIrL2JZVDRtRWxNL2hSa0JHamlvUFEwMHpLdjJ4NDhZajJsMVZRWkNs?=
 =?utf-8?B?eXRDemdWZWpxTFZiTFNaMEVHeGpjN1k0SnRiaTByTmpwNXByUHQ5OCs4c082?=
 =?utf-8?B?MllQVmdsZ25CUTYvb1h0cks5YVdKMWpXejVqeU83TXZUa1RrNThEL3hXUzZ6?=
 =?utf-8?B?NVBmUXVONHhURGVRSkoxRm5pS3htZEpxeEhJenI5eS9sY0Nab2RQbVg3SlMw?=
 =?utf-8?B?VUdPRHZsNy96SkNMSEJuN1pwSWxLV3lSbnVneFBjcUw1TEk1dFVwRUhWcEw0?=
 =?utf-8?B?WEd3ODcwN3pVNTlzeGdmMGl2TXdrWjVaQTlJWDJHTGJVZWRWdlZMTkNHU0Zl?=
 =?utf-8?B?MWp3RDJDdXYrOC9LT2lBQzcyNXJySlVFbUloN1hhckpTRHIxc0VIRUVlbXRt?=
 =?utf-8?B?d2NlQjQvSVVuZTRaZVJtVWNXU0lGa3BYYzlxc0wyWDlOamxxZitVTDdCWko0?=
 =?utf-8?B?dURxdDU2UExvMEV2QUZVZGhQSEQvZForVHlEMnZRcVdESk9ZaHhrUnVlUDhO?=
 =?utf-8?B?L0xId04vbDExRmw4aWZkS3hQVHlML3k5THZtTXYyNUxvbU82QXp3U0JZSWsz?=
 =?utf-8?B?U2VDWWpTbEY1bFpTVEUxOWxnUXUwUjBzNVBLdzE1T1JXVllzN3ZUSVRlZTBH?=
 =?utf-8?B?WWpNalpOZ1dVTGgvVlppK3JVcjk3MEJOa3R4TE15aHVHTUdqbnRFWmJIWCtG?=
 =?utf-8?B?OWVhUmw2RDg5M1YzL0cwck5HdjlwUG5Ob2tsSkI4NlJJTnBlS0pjYjdsSVZ3?=
 =?utf-8?B?MWoxTE92N1cyZ2djYlJZWGl3U0pMVldCL3dYYitPU1hPMUc1d3pXODZZUUJy?=
 =?utf-8?B?cUlaK1haS3NZL2UxVzIyZjAzeEhaeDJ5b0YzWThMK3BId0Y4VDI2OUo1d0p5?=
 =?utf-8?B?b1kzUitaRlo3cm9LRXVrUm5JRXV1bStvWEF0UmVhZUFxUnlPOWFWbG5VS25I?=
 =?utf-8?B?dWozazdRUk9rSWYzREREQzUycWJIK3dCbGVWdVQ4a1RGYkVyOW03QVhWcll4?=
 =?utf-8?B?U0FoVHNRVGFBY2hwUTdJM0ZDakRTSHVRenJYUE1HKy9rSEVVYjB5Ni9mczEv?=
 =?utf-8?B?ZWg3cHBCYkx2N2lRYk1rWjZPM3d0UEdKK1pGTytCSzVud0llN0dtTVdXRzRt?=
 =?utf-8?B?YndaTlhLQnEzb3IzTjJ3c2cwWGRtYjZQa0JOZ3pDS1E3dG8rRmFPZGtCSFAw?=
 =?utf-8?B?OWZ0UG5kYWJHcEhwNTFzQnNxS1l3d3Vrd2NJbVVQUlUvOFN6RDFUdWxaenMy?=
 =?utf-8?B?bXlnMXhEMWdFMlRJZGcvUWdrRWNDbHk5Nm0vQzQ0R1Y1cWZvbGtXR0xNMlRS?=
 =?utf-8?B?WTRRc2hGS3lvb29hUEoxNGd6eDRiMTg1U2l0OWxyTkJyS2VTQWtuNHAyRmFE?=
 =?utf-8?B?QUtrc1hxMXZMN1VTNDRTV3Nnc0ZHcG5ZeXE0SUxCL1c0aGMwOXpvbkpMZysr?=
 =?utf-8?B?Nm5iWEc0cWZKdTl0cGxJTVVUMHhhK2pCZ3hlMmJnNWpzQ0xOR0dBZiswekRJ?=
 =?utf-8?B?MHZTY1pISHpGQ3pzSlBOSWJNQUszeXpKWXJIakVqVXBxUmZ4TzJvQT09?=
X-Exchange-RoutingPolicyChecked:
	AyyB6T+zOqxMKuqEwEIBmzWtXiSq7Ick4wpThhyQ4kmUyIFHU1tQx8iJgukzDAnoqhW0hdICRVPSzE5zFD2Jky3WbBjByoWG9VkczpjN+/y7h9KysKJRXWLNtLS2/HXVqkxxi5NSYrJ/N01NC8jn1UzKMf7OOBnae5G6cy8BljyZ5f1qqTu4mtBkbzElIYrt4SDfLVf1TTF3ZYlCwnSL22927F6vY/g9iKneU3zoefJE5wJVwHBeeoMGAwTRcd4EJMvP3iHDm4cLgQEdFD74Gqb8stTCaMn+HfX8enz2+r6i+AdwjPveb1yElgiuJzsRIzwbTHshORWmUXPeO89Fbg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vSNdoYFbqmRmAUY4tmnDwOM+Ce5nZ0XBtt7VKaEApzPKHmtjDV9bQnvWbhRMZE6befVXukw0iTP1/ws2JCUxaVet44UNyKErRgSNbB3k6C5udnjmcqVeZngcY0Po6Tzk1AOuoarGucDbUKd86XzgWV7yds2EBFbrL7DT1AkDaHPopCyWFRvSU6bNuY1erdmxdHnysveio/ntui/eROJ6Zlty6rd6P/rLmOJtJBMTMpV/FMP0sTUh8sUoK4g2GoOV7HsfIC72v2A5bwBJQ7LYy8DOsnYGFvZFBPecEkFbFA//0ew+h0z6KdaoLTRsrT50Ay5U7ixwlNWT+PzwZMqpTXW8SjNtXu5zaAV7tZT+bzs05Lj1FW8qj902CbFZ8Ase1YX8eopTEdz/XpWBKTVprBUMp4BOELqsYrs9BeHmYUoC48Xzrb5UZpAoPPDKZ+iFOXb4mmEdGNfapCw/8lKndkK45jGpRBWtHm08XlXcNF9jAvEdlRdemb5sAuzm4dQqpaV4sAyqXrNfnj+wZRWxPLeY+2vWbAP/LAcbtGjoVqXod2XQqJvR7j45E+JclmoJgNdmznrf8Fxnqb6y3kAqg/Q9lU7mrpk2zZTsbWzqZhs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0501596-6770-4be9-db13-08debb6fd016
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5151.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 21:43:24.5320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRGvoZtOkcEvTAMQ+XuQ2R9sw3vxNOK1QmLbwKkmUtBD3c6e4quMRkuZBzgsD7sGfbXBydQtc1kUZvzbtnHjlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6472
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605260191
X-Proofpoint-GUID: hAqO8R-O0IsaDumqxw8Pu_vzFsXG3sdw
X-Proofpoint-ORIG-GUID: hAqO8R-O0IsaDumqxw8Pu_vzFsXG3sdw
X-Authority-Analysis: v=2.4 cv=Ld8MLDfi c=1 sm=1 tr=0 ts=6a161400 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=edf1wS77AAAA:8
 a=yPCof4ZbAAAA:8 a=hSkVLCK3AAAA:8 a=LI2J8b_XeJhtB52FKBgA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12300
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE5MiBTYWx0ZWRfX6IaxVkyuYL5T
 dacVRnNAYWtvbPzTwnrQ+KbCWVvV9DNVQFP8yESRNLiF9ubwLB+ZZ3CW4YSRyE8OGJeYWuRag1s
 xIsPxm7vJS3UcHCV+/+99KO+PpC2bfqMwYAdQdw+/cyRSLJumieN/giR1EdGdKFdGIK9ygeZctx
 KjJYadilPovCo3QCZ4w7122TBOa9ufY43y7uqFKHHdSoznt1+g5SVdSMhMEkZvDWE/WnTFBo+ED
 fRlaji3BuDSOf1J8n0meVdL1ERD7pDX7atG2vhxbJVcwX0Y4hrS7vLFXxzG8K5iqkbvtmnlASpj
 DFQwgv9B+i5FHSaEHjNGtodjGjz1YqY50wXmDnAW/QDFEgQoUPP2/TB7POCVXDn6O1wf/6v1694
 o7LU4EmdO/r7GwwhbW+0NQfbW59v83CtWTtClOE7WelmNZKUIgvx9T53OQX0rZZOxMSbLOpYzPS
 dV6IRP7K7gjU5WP3fABZjZ8oJ0X8Q+O3TwcIDWPI=
X-Spamd-Result: default: False [1.35 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21991-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,syzkaller.appspot.com:url,oracle.com:email,oracle.com:mid,oracle.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calum.mackay@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs,60cfa08822470bbebe44];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 66E9D5DCD6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Commit 7b546bd89975 ("sunrpc/cache: improve RCU safety in
> cache_list walking.") changed the tail of __cache_seq_start()
> to unconditionally store
> 
> 	*pos = ((long long)hash << 32) + 1
> 
> before returning, dropping a prior "hash >= cd->hash_size"
> guard. When the while loop exits because every remaining
> bucket was empty, hash equals cd->hash_size, so the stored
> *pos is one position past the table's last valid bucket.
> seq_read_iter() caches that index in m->index. A subsequent
> pread(2) at the same file offset skips traverse() and hands
> the stored index back to __cache_seq_start(), which decodes
> hash = cd->hash_size and dereferences
> cd->hash_table[cd->hash_size] -- one hlist_head past the end
> of the kzalloc'd table.
> 
> KASAN reports an eight-byte slab-out-of-bounds read at the
> tail of the 2048-byte hash_table allocation for the NFSD
> export cache (EXPORT_HASHMAX * sizeof(struct hlist_head) ==
> 256 * 8).
> 
> Reject an input hash that is out of range before touching the
> hash table. cache_seq_next() already bounds-checks its own
> loop; the start routine needs to be symmetric.
> 
> Reported-by: syzbot+60cfa08822470bbebe44@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=60cfa08822470bbebe44
> Fixes: 7b546bd89975 ("sunrpc/cache: improve RCU safety in cache_list walking.")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

This looks good to me, Chuck. Fixes the frequent sosreport crashes in 
cache_check_rcu we've been seeing, even with Erkun's revert applied.


Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Tested-by: Calum Mackay <calum.mackay@oracle.com>


thanks very much.

cheers,
c.




> ---
>  net/sunrpc/cache.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index 305c6e67f052..391037f15292 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -1352,6 +1352,9 @@ static void *__cache_seq_start(struct seq_file *m, loff_t *pos)
>  	hash = n >> 32;
>  	entry = n & ((1LL<<32) - 1);
>  
> +	if (hash >= cd->hash_size)
> +		return NULL;
> +
>  	hlist_for_each_entry_rcu(ch, &cd->hash_table[hash], cache_list)
>  		if (!entry--)
>  			return ch;
> -- 
> 2.53.0
> 


