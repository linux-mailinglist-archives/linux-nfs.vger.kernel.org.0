Return-Path: <linux-nfs+bounces-11513-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D18AAC7AE
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350893A4FF1
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5716528003A;
	Tue,  6 May 2025 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YsmW5NTH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EPZlhkw1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887CB278751;
	Tue,  6 May 2025 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541078; cv=fail; b=YebVcfwG7NBhVbb0YvMAWsBf2cmiVRDbCx6l1iWKz//5hsIM0pD1TH4n3JhAA/How2jfA4JeEaGVTPJtovbLaao2t1GAkK8EYm2MCKJrwRuI+JdpexROr810pREINZlh1nKWVds6FFa9OPj7bCs+opvbIcj5LdQM1IsWxdBL88c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541078; c=relaxed/simple;
	bh=kHUNABJu62r66Qd9K/Gwa5vrukpaJAZPOy9/NyFmRgE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U6UuGecx1Vtm2AKVU8VywQoMEqArqzO4aZ2Fa6uNy0jvY7nPEX98AqA6keFOnBRjJz5BXkpTnTqpIU4u2ozHdR14rZw7Vbwk4CJvcCYhAqidfRYOGzaaZ8EjRJDn2+AFyzpVprMZ4SS/nF6b9HUymvjpl4qioNl2naDFQyZrTO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YsmW5NTH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EPZlhkw1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546EHcCe010466;
	Tue, 6 May 2025 14:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ULhwLRyJ5XEWla2H9SEcvEJwR+HCAOCGhADFp9qMYIM=; b=
	YsmW5NTH4vnbcNsiYzUTWt0IPTfCW83X/G/2gxQ54Wgiq8AHoCsMonU86PV7ZnZX
	54b0JYEh3wPvc9ikan6Qfu+GodsaWzZUB9+Ap9eKuCKL42wBHe6ACCDJ69k3sBrR
	KegBl3557eRUl3Tiq9Y90xkAYO6FvDIs+vaZSv24cSZpX5p/DsCBZ3VuzIWiHIyA
	kUuOfVCKpEU4zuddlxAMrk1Zo7xkQpIj5Fhv7RFXmWSTIPnjA1VTlkH9YliSnd/L
	teL6vYelk8BbzOnz2fiNoMsoq1frbBNWXtl2Tm3uX50kfqGwPEt+yjmTq/DIfN+k
	QAWNj9HfsbLFBdwuhNd6RQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fm25r00g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 14:17:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 546DKCd2035373;
	Tue, 6 May 2025 14:17:53 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010023.outbound.protection.outlook.com [40.93.12.23])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k9tska-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 14:17:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dy32Lu5lfdcv3/goACemeQYvGk1F6d41OGNr+JAJ/jfJlD1a4FWITBQeESIOUAFnuU79cOQb8m9CBNt/QLThzs3EoHC3BZuI6ehqaM9kJ6v5IcSgH6L0PLQKNv5lRkovHwHlcSTnufxFrBVY7ipPIXXHtDihn2deUxsXxP2AYP8EDd+ZBjUX6eVNe2sRd1dwe5SphYveirEm8nyLccgQK6LNg53aY7Q94A9Az6HwP4DpMHTn4kmJtCMlx6RLkwgIrFJY71+lCgNCYJVGektemneAJkFjNld3LYC48O8alimAe7rmZ/NkNMNahJKLlS/2ilE1kb97TnUmK8ekCB6faQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULhwLRyJ5XEWla2H9SEcvEJwR+HCAOCGhADFp9qMYIM=;
 b=IHcRjdvgTmO8X16dOhystIQWbwj/NWk/CsqHy1ZhQ0YiAIe9lbZzgeHBMw/16FlRWGbltLIjwwpBLEmmew4aKzn2L0+13P+u6OAfxjyH7UFl5qcvfSn0Amut+AUyQAtlKkhKGHIYExBkzbY4g17QcP0dVopPu/XDLrL2rplAZgSwiogqif4rSl5UIfMKaQdVWBYWdWn/hftaFZ+bLmOSQVwPQVv+/PS9silzTv21FbhEuBSvETIEXTK9jmDduL5YdbwdgRQ8Pcc2dug5xgzG0B12AOpBJ6b3cbIMlk5bsT/4Rr8ULoM38qM+nDL6k+srxw72vFmGJdr2Lb/4YDuhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULhwLRyJ5XEWla2H9SEcvEJwR+HCAOCGhADFp9qMYIM=;
 b=EPZlhkw1BE+byQ+kj91vpEXbOnV9HZ1i3K1S/iMCBt0zUkuby5kbfbeJcAm5TxR2gdmtkrYIup8Bp4L0Hm515L0b90FZr2veIlKI/Olu+bC04knwQ/3s5C1qNv0Kn+bJVdA318HIz/94QLIiPN/d0v8AL9o+QV7MN4XpQfJfBRA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7160.namprd10.prod.outlook.com (2603:10b6:208:409::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 14:17:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 14:17:50 +0000
Message-ID: <fb8862b6-97aa-43d0-882f-f0ab9f873e16@oracle.com>
Date: Tue, 6 May 2025 10:17:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
To: Christoph Hellwig <hch@infradead.org>
Cc: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-nvme@lists.infradead.org
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
 <63b16277-d651-4f37-9e32-965dc6d1e7b0@oracle.com>
 <aBoYDS84d8N5STLq@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aBoYDS84d8N5STLq@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:610:b0::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 7002be66-e849-4ba5-aae5-08dd8ca8c848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3BGN2RqclN6TTRKd3Zha3hPY3BDYTIwd3REMXMxaUFzeE5McUUvbGZ6bXFE?=
 =?utf-8?B?YVJOem43aTZMeEVNdDRNV1JDUHhjNkNXVE42MnA4S2d6Qk81emM5SjgyLzNK?=
 =?utf-8?B?MUhGMkpqYmZzUUlpWEd4WUwyUmUzNHBXclA2c3Q4Ymc5d0sySXFHWWdnOEtG?=
 =?utf-8?B?NWpzcUYvbjUwV0hTZjBFcWROQkJqWTZhUlNoWVEzUHhFSnlzRGJ0MkJicTBu?=
 =?utf-8?B?THVBaXUyK2ZiSXM3RHpDR0UwaEYrZTNqNmhPbU15bVZxb0dWMGNwV1RUS2Rl?=
 =?utf-8?B?MnNOcGViRjYzek9RZTRYeThiSGV5bHluMFZyV3ZZUnFuREFrNi9tQk94RnNQ?=
 =?utf-8?B?ZEd5SG9aaXg1YzBac05WR0x2d2ZJOHdCbDk0b21NNUR4MkNQNCtQTmtQcVZN?=
 =?utf-8?B?bVZ3M090Q0UwYXpPQnFaMjVVU1ZqRXhFclVoUmwwM2VQWk5TQ25TNEdzdDEv?=
 =?utf-8?B?dmQvNjFTK0lTQ2h6REF1Z2J6RndWQWgvWFFWRXF4U1JLejduaWwwZmsvdStk?=
 =?utf-8?B?NTl4QlVUQmpuSjEybms5WTUzUHRZcnl3VG9qVk5GVGFrbDE5c3l0UEphbmVz?=
 =?utf-8?B?YkxDcUZjVUE5KzhGc1FJdnlaNDc5QlZwOHF0cXhRaVlET1ptMVZVN3dmWnhR?=
 =?utf-8?B?YXNWaWJZTXRzMGM0TU9ycnpvVUV3R0YxU1djeHJTTEhheDd2cnk5YjFGNGFv?=
 =?utf-8?B?QXlzMjg0V3FaWUszVVFjUkthNE9CR2RMQ24wTXFack5Bdy9LSjAzclRxUWFE?=
 =?utf-8?B?MExuazJCUi82aDFkSlZkWFZwSWg3Q2lySE94TnZtMWhiZlhVNUxuelRvSzcw?=
 =?utf-8?B?UWFFY0dQaW9jS00rdFdJL1dMU0RXOFhaZDZNcTUydW92MWdrS3F3cnJ4Ylhl?=
 =?utf-8?B?Mk1DdjFBRTlUTmE1T0F0S2x6NCtYRWl4ckZCNE1ZRWZlcWVPZUx1WGl2c2VO?=
 =?utf-8?B?QnlyMlg2Rk1VaVRzN25ieThWOXJMdGRyai9XeEpUaE9mS0JCcFlhd2IzeTd4?=
 =?utf-8?B?TW5YTFRUYUYzL0VZNjEzTHpKeTlyUWU3c0J5QW15S0NRK21wWHdlVFRGRzJZ?=
 =?utf-8?B?ZFhUMWY4VDhmN2xHRW5sYjk0TFUxVEttT01nYzU0SnpudmYxZDlFY0hHRkZC?=
 =?utf-8?B?dnMwSnhML2tmbGNpTlFrRTd6RWdqcjhEbmdMWTBKN1JFMmVEUTN3eDF4czEy?=
 =?utf-8?B?NEhBblNKV0RTZWNIT0hCWVkvNlFlVHZoTjdNSVZZMWpjWEVyOEJHbU9JRlFM?=
 =?utf-8?B?SEFORDY2SlRiQ0QxdVYwcHYzdGVEL2RHQ2pldXBhakE3dXpFQ29NWUFQdTFn?=
 =?utf-8?B?bUV6N3Z6dCtJUERDTFpXenpRUlprbFF4SGplMDhmNzFGMTgzb1JhU2U3aUsx?=
 =?utf-8?B?enJmcXpHemd4c2w4OS8rVDhVS29IUHZPcVZIYWJnckdRYWJsblducXJXUWVD?=
 =?utf-8?B?ZnNtY0hocGt0cGg4TG1iQ3BvNkhWVGR2YXhrdDQ4a1M5RDlDZS9UajJxM2Ni?=
 =?utf-8?B?RVhLYUJxUlNyQUtjMmpzVnA1KzBjVzBrRWV4UVg0a3EzbldLTFN4MmhZN2Yv?=
 =?utf-8?B?RURYUXo4VVdpb3Fwem5kNTN4WEhUbXFFNFZJTGF2K1gyaUZmRnJxbmU0d2Rk?=
 =?utf-8?B?R015NytBUFl4dWpYUGM1V1NxcjNrT2l4bWJ1WXBhVVJ1QkFkL296K1NtOWtE?=
 =?utf-8?B?VDJoYWQ5d0MyREhneWl0SU1LUUxOOGFhNkZuLzJqYmdUdEtRK3NqVHNqM21G?=
 =?utf-8?B?ODBqYjFHWEsrK0IrQWw3NEZGOHdDVEVySTlOVldYUzlVcnRNWTZBTUZnYXA0?=
 =?utf-8?B?bnlCaWk3S3BpcEhuaVJna3V1UzRvd2xtWFJOTHJTSURiRUExZmVBMlgzUktp?=
 =?utf-8?B?VUFnbXBST2gxZUtDVmVaUnhYWVlPOVdXOU5JNEF2TXN3cDB3TVBBMVNkSjJM?=
 =?utf-8?Q?chZIBC19aho=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHQvaUl1L0VuUk5WbTlKNlRJTDhkNWVjUmhDSGdyNVlVdHVOK25LY3VIN2l6?=
 =?utf-8?B?VnM0dmlRUEMybGJGczlsZHkxWG5HOEhhdzRqR3MvYXViRkQrRVY5dmhkZjFS?=
 =?utf-8?B?dUg4OFpnWWtHRVJGc2lDUzN3c1p1NmoxWGs2RTdqUmYxTVM4UFpYNno1UzRG?=
 =?utf-8?B?ZkFmZmJmTFE5alZOZ2JCcWNvZFJVYmhGaUFUbFdyVzgrV3lheUZqMlkzb0JG?=
 =?utf-8?B?cXZSRnJCbFBqZnpCVVhjOG9iWFZsUnRoTjNGd3dxV3Z6YWVpSmI1MWlYUncx?=
 =?utf-8?B?WFRSUnNLbGhkSTlrazlnZWNFMytmQWRlcVUyZDBSM1Z4bGgweUhVVnNlK3ll?=
 =?utf-8?B?Ni9pWkFHQ0lzTndsQVpwUVlLTUwwOWxLWUQySGhyWDNoZGNJeDBCcVJCb1Uv?=
 =?utf-8?B?Ui9uVXpKRzVDQW4rRUxMRXdlbVQvVDBkdzJpVysvT0I5YkI0STRHRUN5cGk4?=
 =?utf-8?B?K1dqQTgveWdQRC96YUZmTG1OR01BUkE3aGxCSkFIZHRJZncyWjdITE1vUG9Q?=
 =?utf-8?B?WFdTZzMzZnpkNlNhZ0YyL3F3c083RTRlMjR1VjFuNkdiYVFjMVkrWFJCQ0pH?=
 =?utf-8?B?V29ETnVUb0JxSjFhVEZ2WnI2dng4Qko5QnJtMGc4ZnB1aXdZUWJpTWdCN25k?=
 =?utf-8?B?anBRTkdaVFhkem5MTGwzR0F1NjNlYjYzRzBIVldWQzRtTzhSUGk3QnYzOStp?=
 =?utf-8?B?eEE4SmVqd2liUmY5TzJVVWpLL0E3ZEVRWXh5aE40bkFLSkFPVndmU3Nwd2to?=
 =?utf-8?B?RFplakhsVlcwMzFSMWg3dmR0anhqWXZrS092ZUVOTmdRRTh2MWh0TSsyWmRq?=
 =?utf-8?B?UnB2TG1Td3lDQ0R4NE80cXBGRHFZVlIzb0VZOG9Lc0FrTFRiQnFsY1krZWo3?=
 =?utf-8?B?aHJxQWdtK1I3cFJXeTZPdndReWtxT0FXTUJJYVBSMFQzbHZ3emxKUEsyWWhp?=
 =?utf-8?B?NjJwTWhkWWhMOThDSGxtazRHeTRoY0xHeDhsVTMzNTl1cTY5Qjd6aExUYUhV?=
 =?utf-8?B?WGc4RkxGcWJFNlN0ZjlvYVF2WlEzNjF5bGFiRklMOExHTFhNTlV4K09DOWli?=
 =?utf-8?B?NldBTzkwa0RZU0crTDVOWW1CQWY3NUw2Tlg5cEMveHVUOFpHR2g1OXpSeXM4?=
 =?utf-8?B?WVpjVEJldlQyS1ZnRVh1VkFRL096RndRN0IxQXNGN2N4SmtRZlpCcVdlbmRC?=
 =?utf-8?B?WjZHanFTaTVjaEpCZ2lxWFhHbDQxR21rYlNMcXR3TXVzcHBjNDBNQ1Rwc0l0?=
 =?utf-8?B?V0RQTlFZdWpMZzZLY2NNa2xKaGJYdi83N0piNnhSbm92cHB4RTl3UG1GdWRo?=
 =?utf-8?B?Z0Rkdld1L05rcjJQdENzK2MxbXc1alBjYzhZYUFBRFhPU0h3b0pkS3U5bFJT?=
 =?utf-8?B?UTFZcGVmeC85WmxqYzNKS0cxak8remJvWUtET2Fzcmp2dHRWV2drTVdWTHBU?=
 =?utf-8?B?M04wUmF4TnZGdkRpaTYxajZ3Mzllb3JpS1hGSHJJSllXbVFUaExkRUNwZXNJ?=
 =?utf-8?B?ZG1OOWRxOXFFUGtvWXZpck9IZlo3blhXUFVSOHJuMW5aYXBnYjJtZUwzMjBh?=
 =?utf-8?B?SGJIUnI4SzhtMlhReFhKTkxCTlVTVjlicDhtU2pGK1ZlU0pyRkJ0ZzY0ejNW?=
 =?utf-8?B?LzFVOHFuZGJUWVlMR01tcmpWV1VGYzdYSElYOVN4N2RVekpHL21xbXBNb20x?=
 =?utf-8?B?NWRSZlZIYXc1a1ZoYk1lbWhJc25VanZrbzkyaGtkdGZtMFFobUNpd1BUZ0o3?=
 =?utf-8?B?V2pLR2ppS0lLcGZUNmhCcXdEMCtPZ20zNUV4QUNqTnB6MUpmMkgvSDVraUhD?=
 =?utf-8?B?NTJycG1tK2FlWkRCZjhNUUlSb0hJNnY1cFB3OFdPd0Zld1FXUG9mK0ZmWHV5?=
 =?utf-8?B?QmlpVUhIU2F6eVc3aERlWnd3SFhyQ1lYcjFNNW56bzhJODE5elZFdWwzcGY2?=
 =?utf-8?B?NGtMMkpBWTBzdUlib3BvVGJpTEI0QTFNdFd4M3ZVaTFCcWRZZFVFbHdsY0xJ?=
 =?utf-8?B?VUVOQkFaZDNlNHVTdklXZXI1SWhoaTQyUlFFTmplZTBTQTRpaTFFSEpEU051?=
 =?utf-8?B?d2V6WHA0OWFEaXc3TFMrMGhBQ1ZEbUt6Wm56ekFGTGNGYU9raGxsa3NLdkxo?=
 =?utf-8?Q?pyjK4ji+8l+ogCTKjd9c2S4JB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yHXDPEvqTY/jXECx2sMUKjkyGroJKzRfmAPsmnpOPHPXEvvEyYioWZTiT7GNP7RCSSbDrLYzZaKyUZlkFCpLVt+AwSMY+JPBc2K5YIZsyvvyesfymxIT7csVrMpitvzh8zQxNOFNFIXqVLjikXuWOf0GkT2vo3RK8XreEQ49lGMBlmy1c3/g1fS353oCPpM1NKM34ERqk/SPBJ0Loyflcz7OvwWCK1Q+7ptDIt56GU2cDfvQKgJ20JXB7RY30Ffscbwh8nvNhHQFLUSPwKmRcstcAzCCnREaL/lIuEYmCcRPdLYEEiP1d69Qd/66ylOVHzf93idSG0rqMzcBKY4b+tr9px66ps+XhMtJRHtoHXhDAh2/3aHohjc8E9KnMzNgWlYyXKkcxFTmLwd9iZnY/9sUIMUbqeq7BEszGF8464K3w9p66GTYHYRHO+aM7hNoZnU4Sgg7nNstXBTUF6P6ahh+57rCpSWJBzW7H6tbxlAKJW1bbaGfAsQZlz/VKt1klc9elemvpAZWyyvCCFxLrNivZda15gl5AVpcYr6vL3MBANH7rcu2H/Q8LPG/6Sk/yGD2aQ6r4X7LIcRLSc4Q+3sOFQNnkFxd2JmPYvS95vs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7002be66-e849-4ba5-aae5-08dd8ca8c848
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:17:50.0083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3B2pReFoy8twSwVAtSw2AMgSxorSuHpQaQFxI2Q0Ek8KgVqz1rIQRi54xAYW+yIvj8RizkYUV0VblX7oq01FpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7160
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060137
X-Authority-Analysis: v=2.4 cv=BLmzrEQG c=1 sm=1 tr=0 ts=681a1a12 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=hvIaHyXexjFy6F5-3xcA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEzOCBTYWx0ZWRfX/+/P7SIjZky9 j26P2DAZps/WV1Ffv7I31umLWPlxMwPSzRovMb8PJX4uYSIXjB4F4BSXAujf6UjFzQFFu/O9XI+ wviWHCtumwyebKH744HvMFlU/xOIpxrk/yxeu2mwJQ2nluTmFUrq4heRgSUP5NHVC9cH4tIG+cn
 87LKzUWB+gll6lThzJm44bz0sIPA5Uz3TulbiglhzorGIOxYP/pXQm0ck1S/qQTHQj+Ykxx7W8h Xhrd5ylFqXTsGIIHyAPgFe+V0pXh7rrU8cZvyFXuxDyxTwsEPzA7KDS3FqjS8WrfanvVUg1qsJr kIAXxttMGwuk2nmov+PYOPp9QFyQWJU9+1AGoCi5eiCw5yRCLQHMZq/KKmqHKljG+1x5G2Kwg4o
 /vBscfwcWLU4tRbD90QgdihBDt1QYIx9z8oOY1XvkgH72pJ7fXi823kXn3GzZlbKIov29hbW
X-Proofpoint-GUID: LTRlV-EY8PYVO4M0zkzvl3R313HsQYJn
X-Proofpoint-ORIG-GUID: LTRlV-EY8PYVO4M0zkzvl3R313HsQYJn

On 5/6/25 10:09 AM, Christoph Hellwig wrote:
> On Tue, May 06, 2025 at 09:42:29AM -0400, Chuck Lever wrote:
>> are very welcome. (But you do have to sign the Oracle Contributor's
>> Agreement, unfortunately, to get the patches into ktls-utils).
> 
> I guess we should just for it, which would also take care of the
> musl support?

My employer might not take kindly to that.

The "MUSL issue" isn't due to the OCA, directly. The developer got
agreement from his employer (WD) to sign, he just hasn't gotten around
to it.

Also, we've discussed forking before, but "just fork it" does need a
little more detail. Distributions consider oracle/ktls-utils the
official source code, and tlshd is a security facility, after all.

Let me discuss this with my boss.

-- 
Chuck Lever

