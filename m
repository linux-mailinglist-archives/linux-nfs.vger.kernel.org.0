Return-Path: <linux-nfs+bounces-12446-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65582AD92A6
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 18:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60516189C52E
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 16:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7DD1FECBD;
	Fri, 13 Jun 2025 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H48xlt34";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CNYlpAdS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966C11FBE9B;
	Fri, 13 Jun 2025 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749831176; cv=fail; b=Lqm61BKabcjEFN58zrGt9jq0U8hk0tL4RVjz9FYrzxf94SzRpC69Co34m9lLakEB2BC0ipU5lWhA8q+C7kXyBAWLTh2yP6Ia4BEjqqRMuRUmdKVCcEg0vcgQH70L6PULVnOwGa0Txu937fAv++zrrMxndEl5wN54XjM4gsJ6ro4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749831176; c=relaxed/simple;
	bh=TSWgI4uFS2t1ih4ByzCSwUudWC5K72jOnPsFRz+B5dc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qtnqFN9QApKX0RdtPM+RSYiOSAkdVZR9cAFbEO2IUFFYS3VU/hv+zg/wRWCuP7CeFfF+NRcpU/WCSdkmpD9fiy6a6sy52WGHwEKvaa7/tO6zbzYGKBr2vfI0Qhd8AiypqGmbAcyHVSrg00yu/UUfNEVeowgQfH/dRY8gdUxFCf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H48xlt34; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CNYlpAdS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DCteP9020285;
	Fri, 13 Jun 2025 16:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=j7zANVhmqSn34Y+vJl5qz1Gl5gKLqMU0N3pXjVs/DNg=; b=
	H48xlt34stBIYTqw/+sK5uBx7r42kRoVaGDt3hfZ4+PP5THzsk9lMMMj0p0fS5TU
	HXyqIeochmpLXiFlFOh8Dvy5QazKAOgyenDibSKmcoAenGETOtkjk5APLDMX8Fvn
	Ivjl1xmveOqN5Ug0NXLVIjlR+vPfDqtUAD+buZ00EmZpVVKwrX+mwEWvpsHBcO/b
	Dh3XiJScTDrVvpAfpLFknrtJFlH9F3aDlSJPrVT8qwOASzy652E/NWMa2Ahf882U
	I2XJakxJfZ7svRHrPZnY76io+xMJ90B47Ni3uqecsPp6gJKXZTXo20b7tE2K6XmE
	8lwFQMeiVCAjsfmb4WUohw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474bufbstc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 16:12:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55DEOw22009293;
	Fri, 13 Jun 2025 16:12:42 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvdta4a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 16:12:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2U1ah2nkWhP6MAMaLq3xP1DlQyiG2aeNp03hA0A4rLxL+e+CFvf0ZjLfs6Q33CGOhGUDXOonQxzhOTNh12SaqynAAEWWSSfD56CuRPt+Q1Nyav44sp0Z6uQPUxs8UFNC0Im2EDpG9BVAooiqzJaMijSp+UYUZOV3r4ENah8P9Kt4VEUShc2gMFhWAw3H1AjWKQDMXTlvTBhruztS3H76FwdE8XI+0mKUV7kFyDqAhRlSJ54hasHDs72pBMOpCTHOYeMXz9FXWdbQVcFtgAXQuX0iSRcbKBrxAJR5S1VOQkK3aXZTUBYmEdPIj0mEAIQ7phFsKvlxKqWJT+SKQ/EJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7zANVhmqSn34Y+vJl5qz1Gl5gKLqMU0N3pXjVs/DNg=;
 b=dgbJSak8tD67kzM+SoFrSmvZDMWb2htKLCTY7xuGsObM4C6i4Na9TER9I1d+PLH5gtu/V0IapAtiXbFivrsy1Oq2SbIaAMkayn8EhgbwDWsmXyser24QV7s4shunU+8TBAVwo7LP1AoVpsSXOmijQyGAPtPWX1+acxqLpqPeemk7qTH5YysgQZFFMgj3C1Hn8gc9EhXTislhaEwR4keqZzQe3SW2DNyd9KH8p/DFZ4DncVYU6lobIj1uCEwkzn5TKJA8w7ERSCCjqhf17I8PxvFz5o6/uPFlFF7zro6fVpFYjRSba5xzz7YZoaLO+sUZQUMoqXV6PBK3sNGJiDMS2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7zANVhmqSn34Y+vJl5qz1Gl5gKLqMU0N3pXjVs/DNg=;
 b=CNYlpAdSeZywjE/AICv/tlLV4vufEjMzFQcdxTALr5TRbfeAb8z52dWY2zhdELsBjHs81CDnDMJQPxYdxNz0JDy7jT96amCX3aupKn+5FV8539xH09CuLiTO+b02o3AcLNY6GGWNHFPpk7pJmBNa6F9LFZJlX0yR6Bem3hYgC3Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6139.namprd10.prod.outlook.com (2603:10b6:208:3ba::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 16:12:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 16:12:39 +0000
Message-ID: <a2d2ba07-8a00-4173-8283-6054362388e2@oracle.com>
Date: Fri, 13 Jun 2025 12:12:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: Implement large extent array support in pNFS
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Evtushenko <koevtushenko@yandex.com>
References: <20250610011818.3232-1-sergeybashirov@gmail.com>
 <1da1e7db-c091-44b0-b466-cb8aaa6431ff@oracle.com>
 <xr7sopuwurexwjcvcm2iaikv7yax45ryqxdpjyipcv7obph62i@xbdkqwznujsn>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <xr7sopuwurexwjcvcm2iaikv7yax45ryqxdpjyipcv7obph62i@xbdkqwznujsn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0007.namprd15.prod.outlook.com
 (2603:10b6:610:51::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BL3PR10MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa14306-2111-4042-6a2c-08ddaa951e7d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?T3BXM2pSa1IvbEJQNkw0KzVqK2JySmNIRkFLVTFTanUva3hnUHBKRnVTd0cv?=
 =?utf-8?B?bFlrS1dabjBnakZsMmhDV0cvZmxsbERzWDFOME12QWpLQWNRK2tMWUNJcDhY?=
 =?utf-8?B?UWlPT251cGt5NzlOYjJqM0tadzk0ZCtjdEhzMUZIUmZPQzg0UWJYV3ZURGZL?=
 =?utf-8?B?UEVScytoQ0FXcDl5UTFwSnRNdFBuWlF3bEFCY3V4ZGpkck51dWdpNkxmUEFo?=
 =?utf-8?B?SDNvbGVHRHZUZlpMck84Sm4xcG5kUkJucm1jR3VBdnNoMW90Q3U4M2F2OU5P?=
 =?utf-8?B?STFkTFVCMUhwd2VjVE1EMmg4Y0g2YXBBS0NtVDB6blF2ZDRvNEdOSnZpdVpn?=
 =?utf-8?B?WmUwT2hJRDFoVmpvb1Urb09kNis3cUhMdE9YM0I2em80cTJpaFR3dFVjdnFi?=
 =?utf-8?B?ajFtMkRJQ1NkYmJsTlk4UUhGcW5selJYRzlpdlg2enYwWDA0WUNaMnAyckdD?=
 =?utf-8?B?SmhDM1lJdlFxblZDVjF2SUlRY1krUENTL29la0l3bWFrWGVYcnk2ZExnNTA4?=
 =?utf-8?B?YzBKSW9yRE9waFgxRjVpeUhlRW4zOGg2M1N3UjhvSjIxSDdodXZIVTNVL2JS?=
 =?utf-8?B?d2Y0R1ZPUUhISDQ2SlAyUGs3Yk40ekVxOHZ5WmI1Vk5FODZhMnBORmphSUsy?=
 =?utf-8?B?ZGFTV0ZlUXFPZzVld2c2STMzWWFvckg0bmtJZENEYjIxOFlURTVpbElQNERt?=
 =?utf-8?B?OEo5bldvL3A3YTB6QnRIYUhSeFJiQ0hRa1RuZDB6Y1JLRENVR2ZPTjlRYmZO?=
 =?utf-8?B?ODFKQlhVSGJUM3FybnBlM0hkOGNBK1MxemJRc1NrZzI0R2plejlkKzJjNzdM?=
 =?utf-8?B?c0ZMQ2Zoa3I5a0g3eDg4dEFHS0x5ZnduWmZiQm9tQlM3aEE0b1NMaElPZ0ln?=
 =?utf-8?B?dyswek1WTDlSTzk5Vy85bDZzeUNJdWJxQklIS0N3cXV0eTJ2aFY4L1JpLy9I?=
 =?utf-8?B?d2lSUUl5MzhrZnBJa1Z4NHZuOStIdW95YXhjZlQvaFNNdHJUM2Uva3JScndK?=
 =?utf-8?B?WkYxSTM4WlZoMzU2eUpsMDNMYTh3OEFYaC8zeTdJN05WRVA4QWlkWGdrLzVs?=
 =?utf-8?B?OGpVRXVEQ0hnb1FtQzExRHpPOHN2ai9SMHV2UHR6SzJ0a29yUHV1NWU3MHdN?=
 =?utf-8?B?WCsvT3JNVDR6OUtRcGF2ZnZaNmpjV2k4a1JlVWdmMlVnVnJjQk1jUkl6Ukwr?=
 =?utf-8?B?RU1GMi9KOHBiV2ZjRG5sMmVuNWZrNkJFNVQ4Wm5HdUhRUlZOVEFjNWkyVVZt?=
 =?utf-8?B?b1B1ZzJESjRPckNQQWF3R2U5QmEvM1hCa2pOanl2Tkg0bHpvSVpZVUlnSnFZ?=
 =?utf-8?B?S2tWYzRGaHFpcE1Yayt2bWladk16M1AwaFRCMmhsZWsyMmYrbmlCNlozVXZ6?=
 =?utf-8?B?Z2ZEK1k3aTl5ZDVITHR6STdDWVJiVVdmd0JhVHhzMzhkZWYrMGJSeW1HNzQ1?=
 =?utf-8?B?WnlDSzhNL0haM3RzaWFIQnErS0tRUFhKa3drQnBIVk8xeGk4citGbVdaZ0xZ?=
 =?utf-8?B?MmZNYkRjNStrUlpsc05YQk1Qa1VybFZScGt3MnVWTUE4bGVDRytXRHhyaCtx?=
 =?utf-8?B?QmJnQldsYnBNaFNZVVg5anZROEJJWERMN1ZTSzhuZUJsWk8zYys0Myt0cUcx?=
 =?utf-8?B?TSsxYjcvMzlOZnpURGd0V2xlU0l2dFlmUkwyTzB2c0ZLb0JyVytTem16OVdV?=
 =?utf-8?B?Z1BJbVlsNTZpeWY1K2ZVaDRWUDRrZUNUa0dPdU03YnM5QWFuZmJpK2NvcG1W?=
 =?utf-8?B?RlRhTG1RTUJhRWUxd0srWWY2bU93aVY4OW5oa2lya3FDUStNMTJhTVlMeVll?=
 =?utf-8?B?SXZtUXhyZ1hwc3dlV0c2bWlSNGQ1a2RzS1JkeGtHcGtuQ25WdUp3YXUxbjl5?=
 =?utf-8?B?QUJUL2VMK21YcDR1ci9NTlhOUkpNenFkaHAwZXV4ZnZqQkZtcWkzUlliVjht?=
 =?utf-8?Q?fveaA5d4sKY=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VzRBb1VlS1Q5Wk5mT3Q0c09NTmltKzZ2SWJSaGl2UHQza0hEQTFmVFU3SzZp?=
 =?utf-8?B?ODQ1TlY4NVZHYlQ1KzJlSENKUytMR21hTWZTbnBLcHg2RzgzMytIMi95bURr?=
 =?utf-8?B?MWZhVXl2RHZ6bnJSd1g1RjBwakMyR016R0g4YmtYSElOcFF2RFV6L04rVVBG?=
 =?utf-8?B?Z2VLRDU2dmVzNlplSVB0M09sMWxpSlFiMFhYUm9qLzdreWZMTHFLUXJOdFlZ?=
 =?utf-8?B?MWZYaG45VVdPdTNPRnhWOC9DMjRqaTVybndHLzJCVVlXSUhKalg3WXoySkhr?=
 =?utf-8?B?SzNNazRYMnNSb2lJb3F5Mk16V2FlYTlKL2JtWG5qMG11Skg1Qm5vT3lNaGov?=
 =?utf-8?B?cVJQYjNVNlIrWEM5TW40OUk5S0tuOFVxNHdKRTRZcjBuVENIQk1sNjVka05l?=
 =?utf-8?B?M0Y0Zmw0M2VGcktoRzZUZHVZRklGaXR2cVB0VWpKczFBQ3RXdXlRRUgwUlNJ?=
 =?utf-8?B?clMvaW43TkFseWVCZXVpSjZENzJrYTNTcFYwVDB6RXRtSlk4RzYrK0FKWTBY?=
 =?utf-8?B?RzJSREtSbmlGc3V4RXU0eEl6VWlMMHhzSHhzaDhOcGh4Y05NUlhYM2ZHd0xa?=
 =?utf-8?B?R2FkVEJzWVM5YysyM3ZnbU1mWXNzSU16WkxSZk1pU3pkemxEUnBjdE0rWU5M?=
 =?utf-8?B?UnM3L1lJaUo4YStnMURhdlpmYUxycXcyNFRQTlFtb2NobnNNMVpYRFhVSkZ1?=
 =?utf-8?B?YktQRTBjdVJ4WGhvRThTclhsV3ZYNDZnaEhqVVhJak1JdUcvYnQyWWVZVVFw?=
 =?utf-8?B?YVJXSy9YNXhPZTRsU2FaQ2xmNjU0YzVGL1REVGR3MWU2OERjNUxJazcwRFV1?=
 =?utf-8?B?Z1ZsN0ZtVTRLQTdCZlpRWWVBeWd0RTF1NTNTRGtEaUl3TTFPamdpNGt3OXdO?=
 =?utf-8?B?dmM3S2NxYTR6RkFwdFZGMHBwRkF3UGpHKzJYT2lNM1JzRVRkd0lxaDBKSVZk?=
 =?utf-8?B?blNBcWE3NDZpSTJEZ0s5NW1qVU40Qnh1NWhYdFE4TWh5c08zem5zK2ZlaFVx?=
 =?utf-8?B?b3p0ODd4cFBtRWNHeXdjcDRkQkQvQWpUbFd4V1ArQW1SelpZck5kTlZDV0xT?=
 =?utf-8?B?b0RLOGFRVE02TUthSDBYcmljOVhLSXZuYUFtQmlJUGtCcEF4ZzVTVGhjOTJL?=
 =?utf-8?B?RnN1bldneUtKMHFUMkJOOGszZS9FRlBFTEhGdEpYaDIrNkU5ZE41RjVlWjRn?=
 =?utf-8?B?d29JbmNsdTI0TGd3QmF0WHJ0Ti9GOWo0Q01uMFYzQXo5amNRdDNNaEFkd253?=
 =?utf-8?B?R0ErYVc4K043Nnd6am1ndUVpQ1BHK0EvS0VuZXJRWUNSbE5NbjQzUGxvOC9I?=
 =?utf-8?B?N09hU3VQa1k2eUJ3ZUJidzc4TnJVWmVGRytUNWtNZXk0VG1wLzFIUU80R1hM?=
 =?utf-8?B?ZjNMc0JKKzg4UElLTWhzejJrcFFWbDNFTGhXRGE2eHpkN1JZSW5oMXNvcHhu?=
 =?utf-8?B?TzRtV2xQTi9WZDdVMU5VQWVXbGFuOXhPRWp0d1E4WFhJVTN6R0h3c1dWaGJJ?=
 =?utf-8?B?RC83UHFMc3owQ3lHZVRjYllJblpTSUtGZDRHNVVOVUtvcWlyenBzWVliNkZN?=
 =?utf-8?B?UzdzU3ZiKzFoY0hVTmY4WFpPbjNCZW8zQmN0UlZwM0ZKVlphRjkxRks0dmZ0?=
 =?utf-8?B?dGJHUU1za0FJZllXTUVDdVk3ejZ3V3hHQnpETUUxckU4RkdFQmFLSVY2Rnla?=
 =?utf-8?B?WWhyTkdZME1DVDE0Z2ZGekdVVjJkdjk3L1Y0ZkRzbVFzMVNicDZ0M3Y2YVhy?=
 =?utf-8?B?TytaR1FNNkY1aW41OVZLR2YxWmZ0TTc3OURaZWNwNUh3SnRDUGtURXRVUkZO?=
 =?utf-8?B?YUVURnVFVEh4ckNKTmVPdHlOVzdBWUppM0JzTTV1aFcvaHcybFJCV3pCZXJR?=
 =?utf-8?B?Q2NIaUppdW1Fa21ONVpvb1JSNmJ2aWdyNlhkaXZEY0MyUUYybURpWTFOMDlL?=
 =?utf-8?B?OFBhTTRySGdUM05UL0VqYXJsdDUrSG5tcm9GNFNUcFMvNHZtenBGcVVBdWlD?=
 =?utf-8?B?QmZxbFNoM2xZbXBrcmhwSWlsNjhudUNMNWtIZGZ4LzRpM3N5SUVscTVhTG9C?=
 =?utf-8?B?SkxoWUFodEF4dS9Ea0crR0tMbXpRTmM2aXcrU1hXbkpzNjhFL2ZDejlLYzhx?=
 =?utf-8?Q?ex9WLtBUVB3AaKiL4I3TmQJQ6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FhGTs8XDBy2nOWaq4TLbubx6iKVxFm5ohpdLpTObTDqoVAphEfOHhJmgg4hk1l0asAoNFgsPN6i3foUJQYsRdvEfPJ/rPIBZ2gO0EUvyn/4c64EQzH9ueEGlCBjOtYO7TlqvcUViXr4AQP7Fb+r+G50per1/icpWXp0KLzxtrvCgI6msQqE4E50asd9u95mmMQ0u5zhS3sQajnZMv7sXWNKq7wUhUQH0D9Oe6Fn9/G07PQkQVDSntg5RqPlPxJ9TpgNeFLCTx60d6uKtrsWS5V+FMN0mITm9XIMGJLB52vHapOuuFIQ02spStCqDFKd6vwN6vQ5FwZP33BNQ9DVStgqCqOUgpdjudMVCwfcU2eFJVckwyKgfe/4wfG/pt9huzUKQKcliI/p4IlNvu8fqXnBUsDRlj7aj1Zi8rLJmX2BtTMgOcMDKyFytte8lwiwtoDyDktHkMjGTzmb2Kd5fV9pjdkwTXErF3GyvGx8ogmtDc2ibDzgoyUaRmXUPVAqsZtnr9JQ2luFLnyGqxD95ksQkP7oIzFxmSMHWaFmvgp7oS4WR2DSf9XY+utGNleIsDcny034fj2CQzLCiInKFHs8wQ2aNvZyuhMuCS3sIMl4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa14306-2111-4042-6a2c-08ddaa951e7d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 16:12:39.7188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78/QEZKau61YnjBqHAii+g8IsHKkWFk9Qnagl4gP3PT0Z8nwPWCLXTn853u1N08hxpcbSmowGjwVRcG/2cf5nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=861 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506130117
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=684c4dfb b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=m3rFdQP4s53z1TlwNCAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-GUID: Kdtdi87HZtu3SRqmhiY3HofIsuo6h8Ky
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDExOCBTYWx0ZWRfX4ftnKUd5PBXU dQvxLvj1Ata42N3TzTzP2xIetCSRPYD5heAy9R8VPXnSAQRvhVzwH5O0gLCCnP9l21rCOdk69mn rQu6xwPW4oBocZ0IdoYXbhWrneDhJ3bXE/zZrTsa1Sby80/uEjbyUVwR+BWaTY5FJ6PlS4wxMIa
 f+WSE24sGuGJchMeOepECBoY5bDbqYDNge0F835GBMeWN+YaMS4iZcrCo3hnYvk9s+SZ8rMdyqV DZTjW076oabvswsAIrkgxg7fGeKrQEbrHYyAfc+BU6U7PDPS36YuR+dKqeQO4q6t65+oI/QogHL LB79xdlOy0FHvQTB7vRiBnNqXyYIB+3UV6hIKdTZ6swIg6Jwbe3tyujDWAoXeatHajhyUEFBKCC
 FDjlUH2QVEe92GZDhCeHXXH5KiMSBKbAk0JuzzRPOl5zr2wZnYiDeE8espIoV4EZnM4sfXjW
X-Proofpoint-ORIG-GUID: Kdtdi87HZtu3SRqmhiY3HofIsuo6h8Ky

On 6/13/25 8:01 AM, Sergey Bashirov wrote:
> On Tue, Jun 10, 2025 at 02:10:46PM -0400, Chuck Lever wrote:
>> On 6/9/25 9:18 PM, Sergey Bashirov wrote:
>>> +	xdr_init_decode(&xdr, buf, buf->head[0].iov_base, NULL);
>>> +	xdr_set_scratch_buffer(&xdr, scratch, sizeof(scratch));
>>
>> Consider using svcxdr_init_decode() instead.
> 
> I see that svcxdr_init_decode() does the same two steps. What I
> concerned about is that it takes the top-level svc_rqst struct
> and modifies it. Of course, we can pass rqstp from nfsd4_layoutcommit()
> to the layout driver callback. But then we would need to make a backup
> of the original xdr buffer and stream position, set up and initialize
> the xdr sub-buffer, and at the end restore back the original xdr stream.
> All these actions seem somewhat unnecessary and not so elegant to me.
> 
> Is it acceptable to keep the current solution in the patch or am I
> missing something?

At the very least, you will need to allocate a proper scratch buffer
and free it when the layout decode is complete if you do not use
svcxdr_init_decode().

IIUC nfsd4_layoutcommit() is called after the COMPOUND arguments have
been XDR decoded, and before the COMPOUND result is encoded. (I'm
guessing) it should be safe to use svcxdr_init_decode() in
nfsd4_layoutcommit(), but of course you should test first.

If it turns out not to be safe, you might just use the idea of
invoking alloc_page() and put_page() for the scratch buffer.


-- 
Chuck Lever

