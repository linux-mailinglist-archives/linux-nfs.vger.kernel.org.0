Return-Path: <linux-nfs+bounces-10365-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A311DA46214
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 15:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9793317810B
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 14:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F613209;
	Wed, 26 Feb 2025 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HypCt4It";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zEi+g1gL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425C2221703
	for <linux-nfs@vger.kernel.org>; Wed, 26 Feb 2025 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579370; cv=fail; b=p40gkQNcLPmCY/uLuuWNMbv3Lgd+yxHCWos124o0R5cl6wymuBrReWNBruBvuIEuTC1O/iH5Nw9vGE6nFf7SW/pgD57EkZy9m8CkhZj8eChG9qo+kW4RHM3OKETUO0wzCIt41dH6Zsl60qLb3LPIaQ2yo+HqRQx6mZbbKOqCE+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579370; c=relaxed/simple;
	bh=KZ3s7x//Go1Gg5B9M4sSZAQWlJUerO9EnD7Q2ycbz+o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YTdMj/6eZKj8Uq49v84H08wRW49PZGFI32Bihov0/ylkcpR3cwXuLavl0UnY84qG/F4ZGEx9W0ptkw4EdXXmTIdzifI2CWDKq5FjW51miowk9UTv7DUwRZ+bZ3laI7keSb8NifpYghFqkuWIA9nT5eIzDGICRectOfQ/kMhDsSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HypCt4It; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zEi+g1gL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QDtYbw025876;
	Wed, 26 Feb 2025 14:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=P1U+w4zDBNOHJFtsqSVr4VONM+OOvritn39zU46+DC0=; b=
	HypCt4ItvmWNhxZp8n9oZCbR25hkzp8zdPlfmTOVCD8ubXV/Nuckql5/YKTYgEB3
	2OgNj66jhOlvTDmyZ1SxwzFrB2/R1LwC0ePHVIvialUgFSfEdJyCGJDqawKjgYsi
	L+4EoioLLKVIv0G254V1Bxo30nUkTidXmeckHw5g8rnBlAE2vq7xmpAz2g2v2sVk
	cFlpKYVdDcsXqnT0BV37eR6huj4yO2mvNH2VyIcrPSQbfCGYuKvs/sucm5ZCShbO
	G7m+Fkm69aZIHVzjr05TuZjxxJspOBSwH3ChvPBdTagpl4Z7LdnJXol2JIxXLPnx
	tgGb/xbO4y4lIT1/1H+xoQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse1838-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 14:16:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QDQwGN024302;
	Wed, 26 Feb 2025 14:16:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51arm8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 14:16:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJ7HLdK8G3A3MTH2wIzSFalxKzobcaz3C1f2evUpfGY3hk9DDafO+XFIDA2CnjueOACX4qGjiEqsfhloPkKssbPLyi20aTU/g0dpKc5UYC79SEZzORqvVe5ijZSptG3vcm72AUfnUu9/T0yUK/n0GRqMQqsm8IRkRIz3CDB1xifmWErOnKhlnRuDPnwfJ+zTbPsUgacsriArBetZf9jdIfDjNMtSzA7PT0CZkj8ZtLvIzPXZnq+ezQArGKxSQw/5bOEAgf9eixCSM3pKzAAfOMazuJ36gRhajPg3FV+GQDa521gP5BEVt+2c9P4QoAvfJ82YQ5Ami8pjXQSN9Woshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1U+w4zDBNOHJFtsqSVr4VONM+OOvritn39zU46+DC0=;
 b=eLLr6IF5OMXsvnEFdpy7/wKfwljCsdgB0LMIUCwRN1IMhPRagGdBgJSic7mkdKWvLjEdEkmt4Mazery/l0SVQY4TnaO/RTYFywEwWYXsB7JySRgg3t6t4mWR6I+b+gxW3RYNIn2tepYR1OIrSKLq3QqUnvI3U8cjBsdWQbKiHw8mighiw+7q5+RkjuZTeJnIdOnKybbgCKH/jdhVr0RS+ClXLyLjO9Nxx446B25cyuieyZlCQ/TbzFTP1GE1ELJCI13y2DCTZY4tyGozl6NoW4OFTJq++VOwkrxxaGt5Jfz+6m9+sDlJP/DxCA/RbX73SJ9zsU0jnpfLWxB/dOMdrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1U+w4zDBNOHJFtsqSVr4VONM+OOvritn39zU46+DC0=;
 b=zEi+g1gLuBs1+/qmScp/ZZT5nZLTVgHHTv3OtQnaLdvWaejekpB7tOnTYSrBeeCr0UC6uJfyfcT9ylOL3W8y3Y1hwf3OQyb97koImBgzdH83ueXdqXPnlXLvWMpktiID5rXVqAW8E4O73APN/VlGFFW5XdviZRuKnBxCqU6/cF8=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by DS0PR10MB6102.namprd10.prod.outlook.com (2603:10b6:8:c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 14:15:59 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8489.019; Wed, 26 Feb 2025
 14:15:58 +0000
Message-ID: <86e92a5a-2dd4-4954-a0b1-1b61c10fe554@oracle.com>
Date: Wed, 26 Feb 2025 09:15:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nfsd: drop fh_update() from S_IFDIR branch of
 nfsd_create_locked()
To: NeilBrown <neilb@suse.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
References: <20250226062135.2043651-1-neilb@suse.de>
 <20250226062135.2043651-3-neilb@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250226062135.2043651-3-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::28) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|DS0PR10MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 57249749-e6d3-4560-37f1-08dd5670176d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1hYcDZHSFhnYytOcm1YaU5XM2dzMDRIQ0NvdVA1d0pwVFJRdmRzMGc4ZFFH?=
 =?utf-8?B?WkljK0lOMVJ4N0tLQzMwWEJocGxTZ3BRODY1TkJoa25ienRFd0lJY2pPV3h4?=
 =?utf-8?B?dDR3T1UyaWZ1N3lQYlZVUUVubDhXUE1wMEZ1T0NHWUI2WG4wRlNNRjhNWFpu?=
 =?utf-8?B?dlRScktCZG9qd2wySDNwc04xNkYzNUhpTHBPWVpZOTc1ZlBlcFVXWENuWnk4?=
 =?utf-8?B?VTQ1djRmRVp6VFFZb3RSNDNUcVI5bHJQTGJvN2ZWYUdJbFdYS2VYeDBEM29Q?=
 =?utf-8?B?VGpKNXh0RXp1amcvT05DeWhvK1NWUEhaMUU0TGR5ZXUxblkxU2tiQ2I2MWFz?=
 =?utf-8?B?THdBNXF3TVFFeHZNa1RaZWxLZ2xkVUNJc3ZGSTB5M25yamVXUmNXZkhBT2pQ?=
 =?utf-8?B?REZiSktOSlloamY4NkZLNnI0azJHUS90V0tKVnBCNE9JbEUyZ094ZVdZemZO?=
 =?utf-8?B?SG4vYlJndHVtMHpVVzk2S0xZb1kvK3p0SFJ1dWF5OVptQWkrQzdxUFFNbVZD?=
 =?utf-8?B?VmRaZ05FNER2U1BjQW0vOU5pSFNKYnNEV0pBNHJtTlgwdHFjYTUrOElKZWpO?=
 =?utf-8?B?bWNkaUFSQVZ4Y0wzUHlyRGlMV2E4bE9VRDVDbnVBNkMxbytRLzJNQ1ZibUQz?=
 =?utf-8?B?NnVpNU42UFdncUN5Zm9HNW8xZG9jaFRZVDJlazVVUmF1N01SRzQ2UlZXS3Yw?=
 =?utf-8?B?VzYrdHVpeHZhV0p5NUUyT0NrNzN4TUs4UFRuRFhCL2doMG1abTVBQUZYMHZ4?=
 =?utf-8?B?WjBvZXBCZExjbDZLcGxuTFBiVmhrY1k5SnR0UlBqWGdMMmUwMHFyckxCRlpj?=
 =?utf-8?B?Nk5TWUNKSjkyNEs0eVNXSzhlS0xhZDBLbHNMSlZOcmxZWVU5V3lMaU45OFhB?=
 =?utf-8?B?U1RLeXgyK0VLQVZNd3p6WkFTR1ZyYlJNN0hQeC85bmlrcC9aL2dQZmhDVWtP?=
 =?utf-8?B?cHBwTTZVaTYxOTIzUVVtNzdvRkVjTkdCWkNzUzlYdjVOMEVkU0ZGSTQ3ajQr?=
 =?utf-8?B?ZXRPVDQrOGZxM2lSaU9aWnZDRmVPOWpuL2hGSEJSU3JOcVROMmhmSnFZYWha?=
 =?utf-8?B?ZDA3M0JLZEJzc3NRN00rR1J6QTBPVDFFUjlYTFZScXRmK29ZQ2dqSEpsOThP?=
 =?utf-8?B?c3o5eURwMzk2ZmNQSE82WnBjSW92TzJnMG5iZmJhQVFmNGs3NnB3MVNWTnlY?=
 =?utf-8?B?SjFNdWFkdTEydVB6RDV3d0YvekI2dkFRTGEvcWhZcExHSDRQdUZ5NnRBNGVo?=
 =?utf-8?B?ZldFMzJMZEx5Sm83UnV0TjJyL2FpLzFUY25PQm4rL0FMblVCOGJkTHAzV00w?=
 =?utf-8?B?SWZrRURya1NvMmozbTQzKzExbSs5WFhvdlVBVWNYeFdzdXVyTlBQem5RZStF?=
 =?utf-8?B?ZW9zVjhaZStVcGlRZlZDWkVYUkxXZXhpckxjSHN0OElVcXF5Y2FzRERHNzdq?=
 =?utf-8?B?NWlKLzdYbHFBS0YwNzh0Zjl3Z3lZQmRSd2F2SklCKzRpcDdPdk8zUEVpWnhG?=
 =?utf-8?B?MGhSdjRDb0k1TzJrY21NanZIN3Z6Y2JyYk1NUUovM0hJVEduT0JhU0VBcVdH?=
 =?utf-8?B?bHMyN2orRDJDV2JhVDRqdEpSbTdKYVc0NG9xaURtUk5naVVJRjBmQzhHdDBa?=
 =?utf-8?B?YTlUYXoxMnBNL3FPOVBrQ3pOTW5DS2xqblduUXBTSFk0Rk56K3AyVW1Lc0pv?=
 =?utf-8?B?MldYVW5hTnprOWUwRmd2SGtBZVFncGxhczVQVDIzQ2RTK2FSVWtZeFg1YVc3?=
 =?utf-8?B?dXd2eEM0bElZUURYMUNuZExKZVNoTUE0OEVHcDVvcStnYm53dnFBSmx2YVo3?=
 =?utf-8?B?WW9vdXBhSEpJT082VXJvdkNXRHdwWFBKcUpYellweUJVc1d3dWlPL29xZEtC?=
 =?utf-8?Q?6A86xeaCnUG6B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFAybjNIUC9tOVYyWmtEdVZramV4WXFoUWl2TEh1Tlh4dnVhL3o2anpPS3Fo?=
 =?utf-8?B?YUlSVWlnRnZraDdZL1UvQkJrdU9oZUpSUDNRZFNtOVA5VTJWRDh6Nzc3bWUr?=
 =?utf-8?B?SGFYOXdWNUsxOC81ZktVZWxLR1g3K3lYajhMcDA1dXFIeHd3OVZZQk5tS2lw?=
 =?utf-8?B?UXpROGIySHJlSGVub21PWEQydlhVVDNvZndYdjFlTlJEUVpNeVdmaWFXUkU5?=
 =?utf-8?B?UG1WYkpZZ2hzbEo5SklmNmxSazhvQkN3NFNWL1VvNkNOanVOUk9ZMUl6eDQ4?=
 =?utf-8?B?VWVCMUNxcm1rODBGSDZudURyT2p2a3lzLzVZL3B6R0R2ZWMvemxPWWdzTG85?=
 =?utf-8?B?MEw2dHd5czQ5T28vSEVwZHh1UVJGL3JScjdQTE0zeU1FTllDR0VmTjA1c2F6?=
 =?utf-8?B?cDVwUUpJVk81TldYOVhkRkZaOVMvcTZTYXAyaWpjTDh2ZlJ2bGZzcHlSSkhH?=
 =?utf-8?B?RGNaQ29MWUp5bWRpL1E2dis1TFhlTnJkQlhJTHdFQlNuSU9zd3c3OVRjTXla?=
 =?utf-8?B?MG9ybGd3K0dsKzFBVEhoWWZhSk5UVU5rNGpkTFVLcXVwSVZtQU5ySEdVSFNJ?=
 =?utf-8?B?QUg3ckVEaTJSbGozN0tML1plUWttTWdocklsMFJQc3VGQWFscGRuNnVTcVBQ?=
 =?utf-8?B?NFU4MWhJYnR6UlpXNm1PUU9sRHZYL0JoVXRZbzRCZ29MTW50ckR5REJ4OC9j?=
 =?utf-8?B?NkNMNWdRYnZVb0RaVTVHYmQrcGVSOFJGYTBvREV0RG8yb01IdUsrR3NJQnFH?=
 =?utf-8?B?bDRoNHJ6ZXRZVnBCZ2hmaXhNT1BVczcvSEFzU0duaXdKY0VhdmxjK25GOEF6?=
 =?utf-8?B?akZDaDIwOVBQbVZHNEVzMWZrV3Q0MnJsYnlHY2c2Z1VsVjNaa0tHQVF3ZHZj?=
 =?utf-8?B?WXd6NjAycmNGMWFNdWxDMXlPZTAxZmVHY3BpY05OR2cwQ3dwZmxVSms1Tzlr?=
 =?utf-8?B?NThRbVh0U1JRMkRId0tSVkZWanFHOURld2VCQXdwRE0rWUpUQ0VYemNMek0z?=
 =?utf-8?B?QkdySkY3ME5kanRGcFNuYXdZOVhFQzRTck9VK0c3cmNHbkMvOUdIbnVuVGlE?=
 =?utf-8?B?VWlGeWlDeUdJZW9oc0ZwR2pnUk4vU2hKbDQzMHB1Wkw4U2Z5SU5FYXFyMDVB?=
 =?utf-8?B?d0V6Sk41ekZaMW5qSDFjbFpDMENKejNOc05qM2V3N25lTFNvdHNyU3NGUFov?=
 =?utf-8?B?Mjg3alpjcjkvMnREUk5UV1lscHRrQXUzeGkxTngwUlN4bzhjampuRU04NWdw?=
 =?utf-8?B?cFY4dGR0bGFLbVNhQzM0bjRhaG1zMXgwRGg3QkljYUZzUW9mZG9NTnF5TW9P?=
 =?utf-8?B?WlNQM2lNTk40T0ZxSlV1L0N6bkg4UTRUZ215b2dmTUlCUXA0NjVwNHVvcUZz?=
 =?utf-8?B?YTFQdHBIYm1YekZ5YlE1djJtZjZpRW0rQ2ZrV0ptR1Y5UXVCcTJFT3ZSY3FR?=
 =?utf-8?B?UjNEZ0x3MTJOTnhGVlRYWFp5Z0xkVmdQNXlpVU5LVEdMaXIyNUNpdGZKWFZF?=
 =?utf-8?B?T09GQTFqS3N0MUpCUDg4VVNrU0FwVlB1VDk2VC9oYnU3SGNvYzlhSXRFb0I5?=
 =?utf-8?B?SVR4SVNzOHFDZHdJQlJBdnJNdW41NGd1WUpNdWVZTmY4Y0ZXRjk2OG9NQU5X?=
 =?utf-8?B?R1ozbWdpMmNPTFpHRHhubHdSVUFXRnNRY09TR1czS3Y5OXBQZWtDRHprRC9s?=
 =?utf-8?B?WUEySmNCOGhMSVRqZ0ZBa013bWx3WGdCbmQvbDhpSlZUTXc1d0poL3ZqOTZt?=
 =?utf-8?B?UElGQ0RSOXh2WGZSSXBSaTVPUGtTRWpsVkl3SFFmMFlWdDZaTkt4NngydFM0?=
 =?utf-8?B?UU5ZUDB6TG90YStYVEJoVGQxUDJBekRGQW1nZHBjb2ZXSWxkWmNYKzZjV3hU?=
 =?utf-8?B?RndjbmZqSVdIWjBHNVRKb1N6eTZQVEU2R1JUalJCZzNIcjZNRU5zRTJCUENz?=
 =?utf-8?B?UTlkRGNTYi9na3NjckFHNnh1Ykd2VWJQeUZPZ1hiZWRpRnJwWmtlajA2MkJI?=
 =?utf-8?B?MjVvdC9MdU14dm5BNTVWR1N1cDZZcSt6MEVOL1pUQnczemNEOGpFUmE4Zlc2?=
 =?utf-8?B?NXRxSzNOOWdwbkVPa283TUw1aERkLzBqWlNWZmoxLzVXVkttcU8xOTU2OUVG?=
 =?utf-8?B?MUkvZjBGbTEzVmZ0cVVJdW9PM3k5ZnV2TWE0SkZPeWlYaDh3Mnk0cVRncnFH?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	19eX7UTF3DKdbK57KJ4wR0Ws5996BjZvsJ0OkOxeaPhjOHrn/acDebGL6KwBBwFUrSNXvKLGB3vheZicKw54hQwKBOI4JWt/VJmnvj5Io4DW4Ak4YIe5aB5uhJIJSSRJKzgJyAg3za3PomNJt6WV/r9v4MCGDElPGuuK1xWP5rHV7IR+GvC3U5tVIPIFeDJZumlo/DZKcntXu9FCnOn9OW5Xim7/2BNnds6BrgkKUq5atbFI8g6damOneeDYkO45RBj0YNG+U9Y3elJZ6T8P4Pv5d7LvclE+OHy6PYoUKpiZNBZg17fT5JGkrfZzd6sJByFu28YubFHkLdZXdvpYLm7wW4LULmMmUpOlESX1hR9Bbxln96bl3mUe3ZD0cLgMVU1q7xTyryizDaPy9wZHHsdFOSOMNY2hEiQOq8d04nc8DwtuwbP2Kqdqhb3le2OvmtUCA5GTG/V+Bmvx63K7nMXMJTxpUm7E0MMduZVbSN619nUgHADUUL284nEStZFhzE5rR5mkAe22ze0/a0GEakKoQdWXC1HvsLG+Gadf1D3xnNGi7ZmKDXP/zEpf5BpWh+fQKuoJ2xbpotTR49Jsuuk9ySTLpcG7ueRHjMuG7nc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57249749-e6d3-4560-37f1-08dd5670176d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 14:15:58.7570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zw6qmkEl9VXE/eIVNKDsf49FlfXTBD4nDd6+srm91aQVo3XkNIlS6Vk2kIwrDTRncPOb827oQSoQA1+bZJTGYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6102
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_03,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260113
X-Proofpoint-ORIG-GUID: SKWz6RG2-Nelgjurq6higKEzISveWmaA
X-Proofpoint-GUID: SKWz6RG2-Nelgjurq6higKEzISveWmaA

On 2/26/25 1:18 AM, NeilBrown wrote:
> nfsd_create_locked() doesn't need to explicitly call fh_update().
> On success (which is the only time that fh_update() matters at all),
> nfsd_create_setattr() will be called and it will call fh_update().
> 
> This extra call is not harmful, but is not necessary.
> > Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/vfs.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 29cb7b812d71..1035010f1198 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1505,11 +1505,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			}
>  			dput(resfhp->fh_dentry);
>  			resfhp->fh_dentry = dget(d);
> -			err = fh_update(resfhp);
>  			dput(dchild);
>  			dchild = d;
> -			if (err)
> -				goto out;
>  		}
>  		break;
>  	case S_IFCHR:

Thanks for splitting this out!

I was hoping to see a reference to commit 3819bb0d79f5 ("nfsd:
vfs_mkdir() might succeed leaving dentry negative unhashed") in the
patch description... but reviewers can figure that out themselves.

Acked-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

