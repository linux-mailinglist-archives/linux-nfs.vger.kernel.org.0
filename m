Return-Path: <linux-nfs+bounces-3002-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF988B22A0
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 15:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D961F227F9
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80AD1494CA;
	Thu, 25 Apr 2024 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vo/I+F4g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KEhio3zJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389BB1494BC
	for <linux-nfs@vger.kernel.org>; Thu, 25 Apr 2024 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051628; cv=fail; b=eVnAqcrdJcdhzxkgEGEqB4N9A9mpuLvbNqn/6+DdPxvLd5qhamoDE5OgwTqQBDMbFM3QXYy672zCRcuc9siXvYFayKsxugGWNzJOiiFX1z39AFHkC4mrCzd6zuv9mMpNU29fAKf+RW/6utacKZiIurP75bfOcSlvefJIonzPgKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051628; c=relaxed/simple;
	bh=G86PgpMRe3UhaDCtD85cRgKmxiDXAPsUEKlk9O+J5NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OFpubNtuPom/Drh/G51RC3g8Z39CYhN70PrrscC6PYrZno26tVYWc43Ql+G7jN37RS5NFExXeoyx9wvM2MheSJsk0MoCnVwXT5Y+t14klZyhRR3xy7xqyICTqtk7IrAjlfjBZfe+JXzrAw287EGQ277WrgwMj9+wzKRcXMUmMXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vo/I+F4g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KEhio3zJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43P8uGfV021313;
	Thu, 25 Apr 2024 13:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=ArcJw8u4mbZOa5+nyp2ahR0wXhaSrF0oBo9hJdcZOfk=;
 b=Vo/I+F4gT0r7L44ZpvyvAaf5q65A/5ucJVnPizQry5UIZx4lqWQ3oTWBNnWht4aKxL7I
 MrfdD1GiUQowZ+TxHvJt7TFiXn17U75JOU/IpwB3+x0FfJHc/1GoSSWmf4zMIJXMQESG
 EVtqazBrMYyC3k3mEx0fmswe9H9R2CkCJn8AES2ZHtC4do2dHwg853Y867uoW6/QFAOg
 zGt3pdugzVLolwTGlxTKNui5Is6T+INaQyU/B7zGrDHFA2NPAprfrYrkc1oOaI749IOr
 gD7fACnbNX5su5actZgThxfKQkM30cUObqGkNFcPDItpQcSKbTw2fzNUa3x8zWhxt/az Yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm68vk42v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 13:26:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43PBtY8U019693;
	Thu, 25 Apr 2024 13:26:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xpbf6bjrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 13:26:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfOnBMQ1rP4Ed8Bpa6WP2vxqojfU7YifeP8BXQQul9E5H8LOfV/+gbw+nAbzByHYgOgZ49V+fUvrK5N+CEIpKSoVGL1CTg0BNziMu+jMPOInuDEyVmLLEYD5mWZ0bPs2sLKCb2FMsXvTu+Tnmw2lv9N7aMcgGmMC0anCTzbUCXsw7VRoRsvHV8uvgtIdKlCcDIxRM0DMRm23B2KvWFneB2kpwJruC8lBsGO+2J0Jq0Ku1eExDI8LoqLsEAzqpFtN4um/p291LdIqIBghl8w+tkkI81E5myjEzr1DdvS8jtJ2EmLU2J/8WJP3b6D21OUKFM6h6qKoiiTiJ1tCLRqeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArcJw8u4mbZOa5+nyp2ahR0wXhaSrF0oBo9hJdcZOfk=;
 b=Q0I7T0WuzHKThM28WHJJuMvjcwJNaaQeWLUwv7IS8v5pizt1IsYlwmHJoH+LCjhN9Fz8IbHiV7wOFSrZMerMX1pO//6LA+u5kMxjtThHioghotX0ino9dz0326gN57suR8XrUw9Xn0/YZVEViCwT8rN6yWD878xV3IKZ9MaRMoihYkZWmBL4gR/M63C0wSTCNK/6GOh80VUU2kv0BtEbq5gNxeEkZBnIbdtfljGB0AlsrCjPrnyy0vt12j4K2xjDTpWaS+5yP/Ongx1nknYedgwvpRfZSXsecZVXMCEyEBSOxY5pcQVuojOUAu4N/l+OmlIdri8rIi69k6FDJCSgNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArcJw8u4mbZOa5+nyp2ahR0wXhaSrF0oBo9hJdcZOfk=;
 b=KEhio3zJArB2TPallyprlX4hgavZBjZcK5VX4Tell1FtOY752ubceHCIyElHT+uzyc0tzNHcyJYkiiy0IqkbYiFJlyWAJKjcIzkcffCaRzsdCF0laPucXgw6W+tgaN9KxWjt4DFqVG9oqq1mJFJyr0H50MCX1slQHRqZ5rsKlOQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5730.namprd10.prod.outlook.com (2603:10b6:510:148::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 13:26:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 13:26:51 +0000
Date: Thu, 25 Apr 2024 09:26:48 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>, Tom Talpey <tom@talpey.com>,
        Petr Vorel <pvorel@suse.cz>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: don't fail OP_SETCLIENTID when there are lots of
 clients.
Message-ID: <ZipaGCI3B0PX7mdm@tissot.1015granger.net>
References: <171382882695.7600.8486072164212452863@noble.neil.brown.name>
 <62B41B1D-0A9C-44B5-8EC3-962AC862EFB7@oracle.com>
 <171400371581.7600.11354407820942719081@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171400371581.7600.11354407820942719081@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR19CA0020.namprd19.prod.outlook.com
 (2603:10b6:610:4d::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5e99e0-b4e3-4ec1-6861-08dc652b5da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TmtaRkF0YUNwUjRCRC91dWJNQkdxY2U3bjZHWFk3alFYbDQ3SkIrQlliOXpB?=
 =?utf-8?B?cHNnOUpLRTRPc093Tm9LTG1RM1loaVRYQVYydTFGQ0RnbW5pb3ZwQ3UxdVBL?=
 =?utf-8?B?NkJrT2RBa3ZCOEFhSVltcmZ0ZDZyNTl2RXBYUlNiMFBUK3c0Y0lxb1FLa05t?=
 =?utf-8?B?eVNQSWFDQVdySVhad2VYb0hNYnpqdjZ1STlqREFwNFhSUVpqZjBDYWhIWWF6?=
 =?utf-8?B?WTJTZXI4VFpLeERMVVNCdDhNai91SUhiVHRnbUNmN0VoZUpCNkpoU3pERW1M?=
 =?utf-8?B?eWxpZEVXRHpDMW53M2ZTVGYwcjdYclozYi9oWkF0NzBZdDBrQ3FpRUhoWWlJ?=
 =?utf-8?B?VHNMbndMVFBWeEMrTUk2ZDJFc01TWFJReGxCUGZxaXpnTDNyOXl3QTZ6MDB6?=
 =?utf-8?B?UjdEOG9nOUlDbXRqQ3YwamVyMXl3Ykt0VHArdzRHS0c0cHBRYXFYb3lrK05I?=
 =?utf-8?B?TnJ0cCtVMThPaFZuR2JzV0FTTno1SDRSdnBhdVhPbnIwSzVHbHRqMlFjK2xY?=
 =?utf-8?B?ZmRETktPMC9PTEQ0ckNDcFJnQlNrdFQrYS9Fb25HRGh3QmlJMmRzNjN2R2l1?=
 =?utf-8?B?eStDK04xcUFVSkcxbkEreTUvbURUTWVEOW52YkhaT3ZjdTJMLytMWTQrbTJ0?=
 =?utf-8?B?RlNXSjhVVEd0ZnJyNzlsU1ZzUDcwVVpNbzBIcGVoYk1aczdiR2pCaTZRelF0?=
 =?utf-8?B?cURFYVFLSEp4cFhMbmZuWTZVWVV5M0hHNk4ydHRqaFBRRkdWcmpvSEpWd1F1?=
 =?utf-8?B?WjlTVWdwN2xiVGtrR3plcVg1b0lVL1R3OExhSi83TWp5WUF4cDMwNlgyY3p0?=
 =?utf-8?B?NHhPZm4rUE0wVTBpNURYbUxmbGhkUUpCVEtnV21JWXhRQ2QzWFZQNmhYQ0w0?=
 =?utf-8?B?UGYxYUNaQzh4Skh4Vk1pdHBYazdyWXo1MG9GaHVoajhhclUxWURCVVg1WFNt?=
 =?utf-8?B?Tmo3SzJyUUhpMmpvcVMvaEk3bUVWbzRPUUV1VUZ2c2t4VU9tTkRsaWhqbm5w?=
 =?utf-8?B?eHRXenAvYjR0MVA0Mm5Gc0xmRkdCVTlESGtkNjhwNVUxMW5XZVFmRkFtUHBh?=
 =?utf-8?B?U1NUS3hEM3R6S241Tk5nR3FCNzhGTnBFN2FNUGhnbEswMUdFSHJVczR3SXZl?=
 =?utf-8?B?TCtTbCt3VlJxMktld09qTG5mU0pBUjdhOURJb2l5TXB3U0VDTThvd1IwSjl4?=
 =?utf-8?B?ajRCWkNkOFVQVVFxZ0hBamRFK0s3WVNsb1Z4L0EzT001WG9FVGhpRFBrRkZn?=
 =?utf-8?B?Njd3cXozSzBHaUM3QlVMQzBPU1JHTlBLdG1VSkhDVFdxOGRwWmRkL2hHbDg5?=
 =?utf-8?B?MTVhUUp2MlhqS29QSTRuU0NDYkt4U2pIaWtZNW1WcE1ESGR3WlBlYWthbTcr?=
 =?utf-8?B?d1JoWG5YUjgzM0t4cnUwaXVYcWt3bEZJaC9HcGRnbW1DS3JiNkdvSVp3VVRz?=
 =?utf-8?B?K3lPbmtoMm54bnZqcGpTenU0RS9wN0E1N1lTNitMU2tYSDZtV2ZzOU9Qa3Ix?=
 =?utf-8?B?R1lxb3Z6RWY2V0NPMEN1eFAza3JpUFA5UTJSeVNIS25vbkQ2N3ZNWk5oaGlu?=
 =?utf-8?B?Y0ptTFA3akRYSmhRSVVZNU5pTGNyejBGUkpodktaL0I3a1pab3NwaDJLUzBL?=
 =?utf-8?B?QThrQjk5OFJxUTBLSk16ZG5BWHQySUcyMjlrdWRTc2hFNm9DT3ZQVHlua1VR?=
 =?utf-8?B?MjQwYW1iekc2M1hFa2FqWDRxK29tYVdWbkt3TWk3eGxGQ1V0aVIvVkJBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d2ZTcEFSbC9MMmpwZjFla1o4YnlPbE9RZm14Wk9CdlAxVW9HUmJrVW9zZjA2?=
 =?utf-8?B?R0lJS25SeTN0L09lNTdhWUhPaHp5MUZRclR0RFlIdW81OUhKSnBlUHFmUmRt?=
 =?utf-8?B?UXRXMTdlODU2QThFWWFWcysrekdMK08yWTZ6UVNnNGJnTlh5ME1naE5HNnNx?=
 =?utf-8?B?bGlvN0Z5ZFVlLzNENlorUHZIaUdxOXBCbE95MmJ0RzM5Tnp4S3kxdXhVanlQ?=
 =?utf-8?B?bXVlOXovckN6YlNuaSsySnFHUlpwelU2bFN2ZFR2Nk52U2ZyVExzS1RRZ0dn?=
 =?utf-8?B?WHVpQ0o5aEZlQVhmczEwaGdBM1RqZ1daeGRlbnM3WXNyTGhESDBUaDVwRWVo?=
 =?utf-8?B?QTNTdXRYMjJmOUtTZDg1TXdDWHZnTEp1OFpCRk53NjFSY1Fid2psZlNTZVp0?=
 =?utf-8?B?cEpBV3lEdWZKQ3BkeitmSTJWWlJYTnlGby9VWFlLOXVRc0x3TFlXNW5GNDg1?=
 =?utf-8?B?RDRhMVlNZ2E4QlVlcGJDKzZtbWNNdnRKMmRKbWYveEMvYjVhL21SczhyTExj?=
 =?utf-8?B?ejkyNXFaNXpqdTlWSHU2OGdZSm1oaWhSMDkzQnlPMW1YZFp0Y01rdEpjUkNs?=
 =?utf-8?B?K1VBaDJ5SkI2WGxDL08wdmtvbjVBY0t0c0p4UUlnd0w3Vm9sUFM4ZnpoZStS?=
 =?utf-8?B?ZnpvZlBGRkRqbjY2b1lzYmtEY29sUzlRMXpXeENWeVZKVHVDME50QWFnREFL?=
 =?utf-8?B?WDVpc0c3WjN0NEkwemdRektsSXFBSXViL0VRZ0trS0tEN3BDcG8veEMycGZp?=
 =?utf-8?B?aVY1OXM3RU9WUXNWREZjR2NkMWVnUDRrMUFxS0NMNTF2N2RqNDh6N1NQblQr?=
 =?utf-8?B?MTRHYkxDUUxxaDNiKzVUSVQ1YVlEelNsQXAwMzdWdEg2TVhxQWNud0doUjVW?=
 =?utf-8?B?R29pZm5oeUVJT2M2OENvYW5qSXpIOWtiVGZ3L1BDU2xvdjF3cU5ocjVyRFRz?=
 =?utf-8?B?OXlLSDRYdkliQ3hQSnY3WXpLR0tXOGplS2p1d0VDeU1nVHQvdXlEOGszakh4?=
 =?utf-8?B?amcvQ0JKd1lkUzl1VXoxNGZTS1JKY1JNMmlJUjRvYWg1MUtqd1BRajVSbCtI?=
 =?utf-8?B?TndHRE9SakxRYkkvemdKdVFTSnRzR3JQRjA1SnlKTU9lY0REQWpEVUJJVHhs?=
 =?utf-8?B?YjNyZU5IbmpaU3RPbFRxZUx0bDhuaW0zSGkvc2tNTUYrUUJjL3AwOUFkK1hl?=
 =?utf-8?B?ZnNJZWlGa1d3K3YyajhwNWVadHlSQ04waUFaZU1BeVREci85NFg2ZGlDbUdj?=
 =?utf-8?B?bHJndTBIdkxIdHZ5cUQ3UGJqMnFFY1dTWTloY0RWN3hpRE5TeHBvM1hoV3I4?=
 =?utf-8?B?dEpkektxRmd2VHpmVVVXRjlKR2hMZlJnRTBybnV4eDhQYkVic2w0UXdheTdM?=
 =?utf-8?B?czROUkRYa3VPNk9sVFU3ejlidkJoeHRBTmQ2Z3dzSkZDWjlrN2lNaXUvZy9B?=
 =?utf-8?B?aDBKWml6Z2RVMlNkN3VGVE81YnE5VGdZa0RNbndqSUhBUHA3SWJtWjNTdDVh?=
 =?utf-8?B?VDVuVENuQzlMaGkvRThpOHVoSzNDUFF6Y1VSdllzNm9YTjRpU2psMGQ4K2NS?=
 =?utf-8?B?ckhuT2J3b3c0ZGJqemQ5TjdWb3NGOGhFbXlNWmtsUzFldTVidU5pZHRhS0xQ?=
 =?utf-8?B?QlQxajZycjE4TkN1STJjc25jMVQ3eEptZnltOHQwSk5UL1hNa0wwYThMaEJq?=
 =?utf-8?B?aitlNmFPZy92dHZ2cWM2My9SMnhDVGhBRUlEc1BUaWNXN043aWJjdlNoa1RQ?=
 =?utf-8?B?RnZSNWFDSCtjVnZIeDk3aTJWNFdqcUpBVUJRR2FuQlkxWG1tOWduQ0tMMURC?=
 =?utf-8?B?bUV3RGhqVi9EWDYzR2wrekpsaElRWWlGaXZKaStFL1U2Q2Z4WDlSUEpXM3J5?=
 =?utf-8?B?eXh2MWlQN0c2Rm1vUEhTTkJrdnl2WVRJVXZyYXRJL29vNk5WeGxJM2d1REor?=
 =?utf-8?B?Z1d4SUs0WFNzdUk4ZDQ0M00vSE4zdjU5L2lUVU9hV2trTnVra1lPZFdMdVZw?=
 =?utf-8?B?SVVpRG9JaCt5Nk1pdEFDQzUrNmQ3azMwZDYvNm1xOHpVSFF1WTNNOEkxSVY5?=
 =?utf-8?B?VWZMcjduK2grMk5lQXJxL0tqejgrOVRrdTdhV01GTHhxYjBEdmZaVDJOaVB0?=
 =?utf-8?B?MUk1QjdmaUhjOTlDK3BWenpVZDBuK3czeWhPU0hXdXljaWtROE5GVlZ2YWo2?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qTgPRY71at6eexzrC2jEmoM9GkoQNtgbHuK/Y70xkeNidrmXVE6wC14Q3Yug7oWwAaEkWPFnVUzQBDJSOVnbDXbnph/kAFLE/BSlr+4FRPxIWley5yFyq/6xmKfpHqOVFYCh9klYc+PvYlHf/GlQ8vdxh/OmeFbIaD3dv+kkXNmarUTnpbFjCqZLTYzWZRS7J+vVJ7IW1ads1C2x9pbm8l31ag8dPA8PnW9ou2aLmlty5L+72tjkrI2d+eFd/232tGqb9oFyEtgz0N8M05K/98R0qJv+MAbfjg5Zom7GLYfwmi/0JqPDhSzZvlh2g+VlhbCWTVT7mLzorUP3LwFqqX76njGYtQLbW1zh0nfF8QXjVjrDWre6z+xxt/p+Qp0UTmxi2Z3OXyjSRDX40M5VravpuexePlrOxJb47d82Sw9Hz6Yy9qzoDYDeYZY+q8ZqjNFLLWaQmz5Rh1CWqAvLjyNqZzGPV/fbp7bkUbiLDGev3OEHekbE5x/82GbRdKFDjXSxUbD9ES4xe92wrNs/IP99nxv4wi+O7Q6Z8P+RlC85BjtGIZoAg6mhIKUh2R/Ud1cV/SG7vB6wL87TJK9gAJxNbs5iF01lkXI3/7xO5OI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5e99e0-b4e3-4ec1-6861-08dc652b5da5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 13:26:51.0308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hunOt+LX3Bcf+y1G9Z+Ivmk/CEvxMnXZwfERZlrsCeOfOcyPJNfc0/DK/kkusiWO+4QwgXyk1tQ3PrHZcMO/lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_13,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250097
X-Proofpoint-GUID: ouGf35BckZra6tFPDRogkAqCOXjE9Lox
X-Proofpoint-ORIG-GUID: ouGf35BckZra6tFPDRogkAqCOXjE9Lox

On Thu, Apr 25, 2024 at 10:08:35AM +1000, NeilBrown wrote:
> On Tue, 23 Apr 2024, Chuck Lever III wrote:
> > 
> > > On Apr 22, 2024, at 7:34 PM, NeilBrown <neilb@suse.de> wrote:
> > > 
> > > ﻿On Mon, 22 Apr 2024, Chuck Lever wrote:
> > >>> On Mon, Apr 22, 2024 at 12:09:19PM +1000, NeilBrown wrote:
> > >>> The calculation of how many clients the nfs server can manage is only an
> > >>> heuristic.  Triggering the laundromat to clean up old clients when we
> > >>> have more than the heuristic limit is valid, but refusing to create new
> > >>> clients is not.  Client creation should only fail if there really isn't
> > >>> enough memory available.
> > >>> 
> > >>> This is not known to have caused a problem is production use, but
> > >>> testing of lots of clients reports an error and it is not clear that
> > >>> this error is justified.
> > >> 
> > >> It is justified, see 4271c2c08875 ("NFSD: limit the number of v4
> > >> clients to 1024 per 1GB of system memory"). In cases like these,
> > >> the recourse is to add more memory to the test system.
> > > 
> > > Does each client really need 1MB?
> > > Obviously we don't want all memory to be used by client state....
> > > 
> > >> 
> > >> However, that commit claims that the client is told to retry; I
> > >> don't expect client creation to fail outright. Can you describe the
> > >> failure mode you see?
> > > 
> > > The failure mode is repeated client retries that never succeed.  I think
> > > an outright failure would be preferable - it would be more clear than
> > > memory must be added.
> > > 
> > > The server has N active clients and M courtesy clients.
> > > Triggering reclaim when N+M exceeds a limit and M>0 makes sense.
> > > A hard failure (NFS4ERR_RESOURCE) when N exceeds a limit makes sense.
> > > A soft failure (NFS4ERR_DELAY) while reclaim is running makes sense.
> > > 
> > > I don't think a retry while N exceeds the limit makes sense.
> > 
> > It’s not optimal, I agree.
> > 
> > NFSD has to limit the total number of active and courtesy
> > clients, because otherwise it would be subject to an easy
> > (d)DoS attack, which Dai demonstrated to me before I
> > accepted his patch. A malicious actor or broken clients
> > can continue to create leases on the server until it stops
> > responding.
> > 
> > I think failing outright would accomplish the mitigation
> > as well as delaying does, but delaying once or twice
> > gives some slack that allows a mount attempt to succeed
> > eventually even when the server temporarily exceeds the
> > maximum client count.
> 
> I doubt that the set of active clients is so dynamic that it is worth
> waiting in case some client goes away soon.  If we hit the limit then we
> probably already have more clients than we can reasonably handle and it
> is time to indicate failure.
> 
> > Also IMO there could be a rate-limited pr_warn on the
> > server that fires to indicate when a low-memory situation
> > has been reached.
> 
> Yes, server side warnings would be a good idea.
> 
> > The problem with NFS4ERR_RESOURCE, however, is that
> > NFSv4.1 and newer do not have that status code. All
> > versions of NFS have DELAY/JUKEBOX.
> 
> I didn't realise that.  Lots of code in nfs4xdr.c returns
> nfserr_resource.  For v4.1 it appears to get translated to
> nfserr_rep_too_big_too_cache or nfserr_rep_too_big, which might not
> always make sense.

Yes. It's confusing, but that's how NFSv4.1 support was grafted
into NFSD's XDR layer.


> > I recognize that you are tweaking only SETCLIENTID here,
> > but I think behavior should be consistent for all minor
> > versions of NFSv4.
> 
> I really want to change EXCHANGEID too.

IIRC, CREATE_SESSION can also fail based on the number of clients
and the server's physical memory configuration, so it needs some
attention as well.


> Maybe we should use NFS4ERR_SERVERFAULT.  It seems to be a
> catch-all for "some fatal error". The server has failed to
> allocate required resources.

We need to be aware of how clients might respond to whichever status
codes are chosen.

SETCLIENTID and SETCLIENTID_CONFIRM are permitted to return
NFS4ERR_RESOURCE, and these are implemented separately from their
NFSv4.1 equivalents. So perhaps they can return something saner
than SERVERFAULT.


-- 
Chuck Lever

