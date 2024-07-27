Return-Path: <linux-nfs+bounces-5089-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEA493E01F
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 18:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9E0281D6D
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 16:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAADE16F0C5;
	Sat, 27 Jul 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bwU2H3sg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UrJSIUXS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EB51D52B
	for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722097532; cv=fail; b=Z5O6YSHULiLPqHFk0PVsIJfUFU6PMPKx90I6SF+j3QTK4GwToOKKL1/zRGKX5SbqCaBZOtAPtZDby3UeCePOtAqZ15Po19fl4AIsmXoGvyksA/LzqkMWqmrnIhJ3ofaK9gzRfS9JjdP7JBSG0i9VYmAO6+DK96YreOkufi4Wi1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722097532; c=relaxed/simple;
	bh=/yZdzRm9eKfTEwdDKAbLg9O6376p6xXR3VDqX9I+gt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FZt3zhq1leira3flm8mMw0rQFU8oOpQPbhd9EC5JvU8bZ/K2Tl4rCMcTtbYMXCKzDBf60k/ctWdqu6GeB5qUR8K3uG5ZyAZLYJisQNgnCFfY0yYXymxSpXHNahZoxMBepNrPknv1E8t9RxLR8dCtDMr9zmwztnVrjlM6NMWUMYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bwU2H3sg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UrJSIUXS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46RDC3VY028717;
	Sat, 27 Jul 2024 16:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=iSQmGpMxbO6y1Wu
	Xv1Q9yu3ZfLbRaZo68mZG/JQGFdg=; b=bwU2H3sg++au1cCpAEza+vzL4EADPoY
	9guhS8sMm/ETlIVORDTdKIiS3+d90K11Apr4KGEcjPUWnKPTrHlOqnN8QgEnHaz0
	nSDMCfSL4c16cx/iI1KfJ3OWwrYK7/ROZOXVg+lvVSWSqP1M6XNxUufVZStzQ+/7
	elof62qhus4eTQvWjIAQWEGdoqr+SQ//Adk9fvm1l0UUb4omx2V6IRtA6ciSvNr0
	DNmU/y6xYSMrRJz32mjDw5eFSZbzpsj7yqqX/MxNslatl8e3VVMF+0q/FfmVCGEx
	E+YqgqATh2BHX88pl6GyWYfnu47OFxTuiTRZ31d3BRMrRo7fRV7bJQA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqfy8f68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 16:25:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46RBe9sJ016146;
	Sat, 27 Jul 2024 16:25:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40mqb5cey1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 16:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNATjIzUSF+P3jipGEQKlnEtqPB3PaPMYkit7w/WFTluRAM4hbdi3XksknhLpmwrsbwDZyF3pQiTmmE/s/T9lLDQJj6Zu9gUPacpHGK5YsJ4S3cqIqX8Go61osdC8Y4PTqXZY61WrrIUVHOS9EQvuujGJIat8nYwf0m/XyOSGvwUKZjJEbO0vblkI/XWCggPk9G+UR1BCcP4TyMctB/bFs4Rh1Q7JtBJKbHe23/e0xjvJzyE3z9pvbwWBFQiPsZtOoOlD9Ne99uZCixQnKWWOF05BwUAO2YC0GjitVCeVgUJ+wJrBIuvBksLv99+Eqra7Ie8A24Rr1G0vZApD9lbXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSQmGpMxbO6y1WuXv1Q9yu3ZfLbRaZo68mZG/JQGFdg=;
 b=hduF6YOLyxdIWVdvoPBEQggO7rAeahhBY4l4fAok1ORIRMdnX1k7cesj2ayWJv85gv/+HI3hTeDUU2DrlfutzPzGqGpimgINAzqi6trpfXbz/e512R4/e442Jr6lb+l7rriLJrkwUVgKhhidbafvGsqMu7O2Q6CT8a2pjXiTr75ycIFk8/flvNbcULnOsMGfr62uieBLmmik16kBO0n8eanr0Q2mjdsnSEWOcJtCXYLsNdX34wZLyB4LRWnhdhit8M1kNZ5B+aBUAvoo+KdjCYm0sNwHwoyJ3l8ksLeIFXHgSkdRbEO5F8y37TzJ35PqCgETRohrNTpE0NF2xfWJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSQmGpMxbO6y1WuXv1Q9yu3ZfLbRaZo68mZG/JQGFdg=;
 b=UrJSIUXS0ew576z0SaIFlVsMYimGGkkb0MRqM01a2ba40MZ/NIvRA5C+CqC2WRwEiRaR0RYTV+HWC79dzbCVpjoCNYkitRP42j/5G/bLc9G9xw3Obup27VWfyh3kJzBSbJ5JXw5S6dcyrc0tpkLBbUPmAXvqSFh9HAJ4Fe77kzg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7346.namprd10.prod.outlook.com (2603:10b6:8:eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Sat, 27 Jul
 2024 16:25:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7807.025; Sat, 27 Jul 2024
 16:25:17 +0000
Date: Sat, 27 Jul 2024 12:25:13 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 3/6] nfsd: Move error code mapping to per-version xdr
 code.
Message-ID: <ZqUfaXdZEN8jDVoN@tissot.1015granger.net>
References: <>
 <ZqPDW/dgEHKBGAUp@tissot.1015granger.net>
 <172203163250.18529.11813729769952524563@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172203163250.18529.11813729769952524563@noble.neil.brown.name>
X-ClientProxiedBy: CH5P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 008fa390-d314-422e-27d7-08dcae58b34a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+jETUHwQNehStaGz3M4yPI0QrimJm4QMOt9VlHTkZdpRvE++Z4uG1zLVogRc?=
 =?us-ascii?Q?T3oPsTa7VuFnsYCQp8p0/VjVbSFEEa3uPb4L87QzrN+QC8Fcf9h2L3bcc9eJ?=
 =?us-ascii?Q?Vn0ZplXOx8WDx7ic2uZH1Cm5hjQPtt8g9tB3Cp2wKuAM011sDxjMM+cowE/9?=
 =?us-ascii?Q?LXqilXjePXysqlbpfZXjAeAOW/fqyu1JXLfJYp8j1BR+zqAuO8vTYOWaiN9D?=
 =?us-ascii?Q?xyaKalQwinS5ys4C9Hui7nPTEvVEC2VQP8u2vvo/HlReReDbMKSxPI3ZHWma?=
 =?us-ascii?Q?O7QG7h3/KVwKU8IrXeztjLQTDoCeKgsxAuwuQIa7eWlA/RGYVHn/m6UVIDLU?=
 =?us-ascii?Q?7hRgbLcPHA15+QksJX5N0Fr3Ifr0MEUizyMaM8Ggg4LU2c9pL081ic19UIMx?=
 =?us-ascii?Q?W/H9PLlHn5c1Oni0g2JphYSU5vpNZEocg5RThyixs4b3ofgScNAQwHLIoRp4?=
 =?us-ascii?Q?iQVSvGtEIjKRSEsDsUYV7v9b/b6Wd/mSep51BlpwP4BEZzs3L7pNOpOZ/H+H?=
 =?us-ascii?Q?I9O0iHApon7lmGRNDQrqexNDnSbpYhJGoiMdGDYJ4SHpnTMffQjpqJv2AWOI?=
 =?us-ascii?Q?GQ+vE9rjwL2L+UDu90i48Ye9iObsceGTfZLdkmSOElHUqocyjDYbQ/89haii?=
 =?us-ascii?Q?0EiMLPWG01NnkE7YOhoRU9eNjtfM5p5I+72w4jEVIKB7GMUeHpowCUMpqpxv?=
 =?us-ascii?Q?X9vo3EhbIGwCyn+ZJmHEnKperjHJnmZ1o9Zg/aLUdpaZ8Ay6uRUPhHb3UQKh?=
 =?us-ascii?Q?FnGRiIt238v6b8NjW7qOHXfffwq00Ooackfb0DcBtDh5eRovrFcknlgteU7B?=
 =?us-ascii?Q?YdrsYwEaSVGrjG9kufx2jfHvCxh04VRT0OuUano+kcgMOhPEDg185ncC8VBN?=
 =?us-ascii?Q?RbZFJpRzytafu7hiEBUwVASXCWZOoIlg4WTX+zkl+6GBn/2hFmEU3kftZ5SS?=
 =?us-ascii?Q?dG0I6pC6/uKGGZ37V+WRVuwRTUCX3xA4oHHMRLvYyeyFm3+viz7QG2qXQLD4?=
 =?us-ascii?Q?q9Z6C3RE4nueGeVOysYRYeiAkscf/Q27a3HabCjGQcTGz46XWDjEN3B3oIdv?=
 =?us-ascii?Q?258m24qO58XuiyhzIv55FAOZmpiDt/9clITNoOJCrf/t8eYiqre8adksxSjL?=
 =?us-ascii?Q?KqgANf1TvwfhyRhL9wUF4athwy8zOVwQixQwcGyRMN+nEtkC02+d415DDonU?=
 =?us-ascii?Q?jeZEe7yfArGuj4psEIFoC45wMp1Yt15vWjZ9nh63D6AiI5gmudHHOxrhGNAw?=
 =?us-ascii?Q?tbJuOnzHQrOH1upIDAj2YY+hb3NhS++NEzKFL9rpLlxCP5uzZrgE0EF7a45a?=
 =?us-ascii?Q?XSSJl7X6qJ86dWARpXOBzaiQmY5hj7NgjQs6pQWw3r6rgA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QzAtTAkXqgpGdDs1WSd4EtVY3O6+HfVsJ8YCG72ufihD8+ke3ODNgEsDMoB2?=
 =?us-ascii?Q?mC2x8I+y8nW2HjQydWMSqFGohs78044ZyW1Ac79G/cqr467iV1Ybz4bt6Qzb?=
 =?us-ascii?Q?v4o1unhe900inr9Qtx613gAeJBMLF/YsybjE26+Px2Tuvq1AfDaloBOrxUHW?=
 =?us-ascii?Q?sedLWpYUk4MK6WQqpHi3hno1WLL4Snp6Iykq2XESsHgahW2hMhjfDXzCMEU7?=
 =?us-ascii?Q?qkvsNZ1JLqLfc/IdbDmOQV4l81stvSw0je7AqFTjJTJROjfNbZ5Q2IVqkCqy?=
 =?us-ascii?Q?vUPvrm7CgA4m3f8FLxnEMmw1RmUv75X4aFfUuFHChVtvTAXz6zS7KwekQgoI?=
 =?us-ascii?Q?IFW0pQTLHriDHlswc8CqqMYNWIYVaaudXIT156XqT77HUZNnPJ6uN5PIRzeD?=
 =?us-ascii?Q?qQZhYVmTI4o/DnPE8W8t+T8RDzk2+9W2xWQie4pSj0QEYx0bT/ziOf8mfxlg?=
 =?us-ascii?Q?sr434k1AjrMzb68lpGPgJwrXzSwLS4AcEmkq7MnZ0ZAvNYzUYZDFCvwrbci3?=
 =?us-ascii?Q?9iCBnyAE8pEH2Vr6kxaDOROQYH2BtTxlHPW4vsZeZ0FEbKmktSQgcuH1lWGA?=
 =?us-ascii?Q?L1mMGtBJ6mMzay80Omj3NJUZXc1iNTPoiUNnZuaFPIp2LPWOdkq5bK4lph7J?=
 =?us-ascii?Q?dNsolMfCvzQe44gxymtUDBlit0SUBHhToYwr1mylAcJbFhlXZZaKTw2CSvN6?=
 =?us-ascii?Q?rzpEV8m94kHlM0Vtjw55S1ZMmFyniI7MqT9D8E/KzrUTCyYOxg6dkK1bE4Ur?=
 =?us-ascii?Q?0qxaZ2S/Hq7uy3nE86ObS4a4adEGkKpWRQTbe5/DzZoBpbxxDTFm5plyhPKr?=
 =?us-ascii?Q?4GqMIsOGHQEhmycgTWT5xFDqL3Npz2BYYmx4NvEI/UZasbjbznvXKzOOhNBK?=
 =?us-ascii?Q?gx51x6/5VIgGr0+LgiSI6PxBMa494fg3545ZdFuN1fsfbwa94+0yBYqtV+r0?=
 =?us-ascii?Q?/F1tI8pTGjtd+4nT8Ui40osnMoPaBkyXkZ8SoJ+KZInZaqZOUAd7wQ6PJrWf?=
 =?us-ascii?Q?ae1Xe0JIh5DHx0wen3CfLcI6gosR8rFGFAiZKzly1EBXMUrDzTo4mHL+QuD7?=
 =?us-ascii?Q?FNSo8Jz19QvwC9fr8RF7wf8++kuGNbEba6G1apH0a80T1P1DnducKl2hu6/w?=
 =?us-ascii?Q?R2KqOetR34RAZslwBf/XGFD7hKmBO7dC5eNN4p5T4ANe8eaRgKuLLxQzzdi8?=
 =?us-ascii?Q?z4h4B60YrqZInzDVzvpD4w1VGZ+kxlztHmeN37TQq0LsyKe1xcr/5xoZqCVg?=
 =?us-ascii?Q?HEDgiV0K5Ofn4v1Rav7v65OkcfNi/FyptTVKU0jT1G3fXnMSZNM9M+c08/1i?=
 =?us-ascii?Q?nr9GrRZMqCnenBrZ/SFEK1tDpGRb4uHXOWcIw6iE/AreRc0P+J9JEyRTYqA9?=
 =?us-ascii?Q?qrUHx4clKtlYcGW5+yNl5dNJuXTAlKRbKBa9IWn+h6hgjWU029pbg9gGKnQQ?=
 =?us-ascii?Q?g8fRT59Z6vJ7Kuw+v1jO7bvVnNCF31T7gf/QqOjjTMqcEOrXcnX+sCrxXDxU?=
 =?us-ascii?Q?6ZtJoqkODPMONaqX51SnENzi9zbsMSpOLOT3iu40MKQFpShEUEHNeiRA1vxr?=
 =?us-ascii?Q?kL+56PaJayU3uQIZrR0wR7A3dioniYeUKMZ0adKk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T06epNewaLrpoELEA3bEhqvCLe6iZKIHCglYruFrCtkDLVoYizt6mag+BiSmf4yjU8or89RmhbtGAzZ421osGlaW/A+Zkn8FyXZ/QitZOgUClULTCes0C8blsF08u4RghNUSKKiLMcFtMqHMXTWXnRANe8FTLq5M8AK3gC7iSgsWwvUW7s3Jp7xxo+ukH0y8xiaRl+pD+Ygdcoj0X/lo68XMraac2OX/6/59GEiCr1Gxv+m8gpzhOY4a+8ogsP+3e8BGkNFwU5S35PQrV5hNVoGYSlKpyDhphxCNKJA2MKPCvTBUQR5V7RCLj7VLlkkbe71Hr5ayGf+68oNi+gZaoceEVu0SVVEG6vK0wjRYM0coM92NCi7dWTl246YmCuNXUGzhDdenORq1kJn+iFUDqzIivmq62N4FCmI25FP6rHLmWYCeEYA1K5scUNE7m7bOQK4PC+Gl/Eiexu/DnsfvsiDpnbRduEF8zWaLe4nTQWVzqg4lt9XFdaZ81rXqmW/0gN0rAoB5OZzt/3RGgK2xQuyfruXguoRFO73eokQkz6yk/esBDXEnt5CEmqEZFbo0L8XqlP0MUPhMnihCpkKYdeMLQQc54AtouHFyRz3LUOQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008fa390-d314-422e-27d7-08dcae58b34a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2024 16:25:17.0692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPNbrzqDuTupz/YqnV5fAN6uRyJZuQ2uZpLIS/7XfFP66YRi9uPFqAb9DRVTLl7gfBuhbDPJHslBuXxf407veg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7346
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_11,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407270112
X-Proofpoint-GUID: j8BRobcOra-m1aQyMdS-M47Fs7AX38Cn
X-Proofpoint-ORIG-GUID: j8BRobcOra-m1aQyMdS-M47Fs7AX38Cn

On Sat, Jul 27, 2024 at 08:07:12AM +1000, NeilBrown wrote:
> On Sat, 27 Jul 2024, Chuck Lever wrote:
> > On Thu, Jul 25, 2024 at 10:21:32PM -0400, NeilBrown wrote:

> > > diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> > > index a7a07470c1f8..8d75759c600d 100644
> > > --- a/fs/nfsd/nfs3xdr.c
> > > +++ b/fs/nfsd/nfs3xdr.c
> > > @@ -111,6 +111,23 @@ svcxdr_encode_nfsstat3(struct xdr_stream *xdr, __be32 status)
> > >  {
> > >  	__be32 *p;
> > >  
> > > +	switch (status) {
> > > +	case nfserr_symlink_not_dir:
> > > +		status = nfserr_notdir;
> > > +		break;
> > > +	case nfserr_symlink:
> > > +	case nfserr_wrong_type:
> > > +		status = nfserr_inval;
> > > +		break;
> > > +	case nfserr_nofilehandle:
> > > +		status = nfserr_badhandle;
> > > +		break;
> > > +	case nfserr_wrongsec:
> > > +	case nfserr_file_open:
> > > +		status = nfserr_acces;
> > > +		break;
> > > +	}
> > > +
> > 
> > This is entirely the wrong place for this logic. It is specific to
> > symlinks, and it is not XDR layer functionality. I prefer to see
> > this moved to the proc functions that need it.
> 
> The logic in not specific to symlinks.  It is specific to RPC procedures
> which act on things that are not expected to be symlinks.  There are
> lots of procedures like that.

Fair enough.

IMO, it will help our review to see exactly which procedures are
impacted. That suggests to me that moving the impact into specific
procedures will also make the design less brittle overall, but
that's just intuition at this point.


> We could put the mapping in each .pc_func function, or between the
> proc->pc_func() call in nfsd_dispatch() and the following
> proc->pc_encode() call, or in each .pc_encode call.
> 
> Putting it in each .pc_func would mean changing the "return status;" at
> the end of each nfs3_proc_* function to "return map_status(status);"
> 
> Putting it between ->pc_func() and ->pc_encode() would mean defining a
> new ->pc_map_status() for each program/version and calling that.
> 
> Putting it in each .pc_encode is what I did.
> 
> It isn't clear to me that either of the first two are better than the
> third, but neither are terrible.  However the second wouldn't work for
> NFSv4.0 mapping (as individual ops need to be mapped).  But v4.0 needs
> special handling anyway.
> 
> Where would you prefer I put it?

My thought was to put the status code mapping in the proc->pc_func
calls themselves. It sounds like that will work for NFSv4 too.

If this arrangement is too ugly for words we can rethink.


> > The layering here is that XDR should handle only data serialization.
> > Transformations like this go upstairs in the proc layer. I know NFSD
> > doesn't always adhere to this layering model, very often out of
> > convenience, but I want new code to try to stick to a stricter
> > layering model.
> > 
> > Again, the reason for this is that eventually much of the existing
> > XDR code will be replaced by machine-generated code. Adding bespoke
> > bits of logic here makes the task of converting this code more
> > difficult.
> 
> I suspect it we won't be able to avoid the machine generated code
> occasionally calling bespoke code - but we won't know until we try.

I think there are lots of simple encode/decode functions that will
work fine immediately with generated code. There are some areas
that will need plenty of massage. There are some spots that won't
work at all. I'm not planning for perfect coverage ;-)

(And, like a duck, I mention this plan every so often while gliding
along smoothly, but my little webbed feet are paddling away
furiously under the water's surface working on this project. Stay
tuned.)


> > It's confusing to me that we're using the same naming scheme for
> > symbolic status codes defined by spec and the ones defined for
> > internal use only. It would be nice to rename these, say, with an
> > _INT_ or _INTL_ in their name somewhere.
> 
> Well the spec say v4 statuses start NFS4ERR_ but we don't follow that.
> It isn't clear to me that disambiguation the name would help.  At the
> point where the error is returned the important thing is what the error
> means, that that is spelt out in the text after nfserr_*.  At the point
> where the error is interpreted the meaning is obvious in the code.
> From the perspective of NFSv2, nfserr_xdev is an internal error code.
> From the perspective of NFSv3 it is not.  Should it have 'int'?]
> 
> But if you really want this and you can tell me exactly where you want
> the INT or INTL (and presumably int or intl for the be32 version) I'll do it.

Points taken. Let's postpone renaming for now. If the symbol naming
scheme is still vexing me in a few weeks, I will write a patch for
it.


> > A short comment that explains why these /internal/ error codes need
> > big-endian versions would be helpful to add. I assume it's because
> > they will be stored or returned via a __be32 result that actually
> > does sometimes carry an on-the-wire status code.
> 
> Yes exactly.  I'll add some text like that.

Thanks for your feedback.

-- 
Chuck Lever

