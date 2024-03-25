Return-Path: <linux-nfs+bounces-2469-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 845C988B109
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 21:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7AE91C61568
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 20:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE5943AB2;
	Mon, 25 Mar 2024 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GNmBVJtB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z39Iw7u0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195424502E;
	Mon, 25 Mar 2024 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397499; cv=fail; b=n+UDLIWlWvuVANM3zFSdUNfcnt0xy2u3Q0METig3M9XXAOxBtQ47mSMkSeKs1YeylLezkkXTz3FMHsjbNI3HAVtJs/SyC39wxTSudn9z9mhQHQRiYvH193aG049HAqpBqz3bthcgsaPHIjynJlvx+s2i/ekqkvw9Of8Y8nbPGlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397499; c=relaxed/simple;
	bh=95hOL1FdDpjqG0bDTCW9zeq+v8yAw9/zAKx/Bf9+ClY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L8uFqAm1cmVbzhFzJIWjIa+qlNK+bOdwVh+vnUELEiOsYR+ATV3XiZxRV81xfwzRUMCFjADPDffL8EWtmd2SSRs8+0H+GV21HyUrc4CekvBV9e5nn6/bjtTNm4myGeVocsUjc/ENRIrbrg1P5V7c8EOK0Gue1pkml01aelOeODA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GNmBVJtB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z39Iw7u0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PHUhrX025664;
	Mon, 25 Mar 2024 20:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=95hOL1FdDpjqG0bDTCW9zeq+v8yAw9/zAKx/Bf9+ClY=;
 b=GNmBVJtBkAocTt2qkzVcBjfLwGUGY6yS1O2DYUq2/DnVO7JRZJyq8hnWkjRfFPfkw2Ly
 iVjlBqUV1u4fyvwrHXybpDYgzE53cbW9crQ7BvjBahszqDyjeuQwUGj17tJY9Dm/B/ln
 ppTNnwCVXuWHepW0of0EjoussE0cSf9tsxMB4eE0PtUlnm0mqVWbViIpQkNihVfq/Qo8
 Osv2We22+gCh/krRwWkxWeIZv5ovtgb8lXNnYr6WLeCEr0MPyV7+v5VDkTDB4lRHGGEh
 CPgruEpr7Y4bvpQveDC40Df6+7ndaYriy1OInwdFGIHRtpJ3SApfz3UU2MZc5RUrHr2T HQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x2s9gt1dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 20:11:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42PIKblu024409;
	Mon, 25 Mar 2024 20:11:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh68ssg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 20:11:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWhBC45pkddyB8/hlDkPEQfgLghNr01sAyyd//CctR64EI9t3cZh/di+u9ToFZn0vzsAZOyY12DQip/ZUDNlKVtuKGtmpEi9DLFr/rrUqpSnxH4yZjK67AX/q6e8/2ESXCL9/5GlEKdoHyq6tfCAdZV8U7pSJW9AW3qX/V46c/WBEUw8RJdskJAoxS2GojO8WkO3ufpdfZjz/1uqWS+s40eB5MY9hKZtZ/2CB0LRrG0R6zy6xHoLKTKwxb998bEivsauZcDiojFlZ5TyF6UyhEo+8pxppNBOGm/d34EEx8IhrqTM8eOlrsefi5h5mDNQCarDddVWoUT2LtigpcINgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95hOL1FdDpjqG0bDTCW9zeq+v8yAw9/zAKx/Bf9+ClY=;
 b=niFusG/5qYKVvnfITxAmf8qmHVZ3cCu71s7NRHQ0AlvOhyqufvmWb7vUF9fTmG8ucDLK4QFAsM3DIbCpMAqO2/UHuljpY0aMd3lNkHXk7imsnc/k3gkCQGC/02Mz2NKyp+4NBjxr+vnMWD9yJQWkRU3tqZAYgI08pzjDxu3xBVU15pJFd9U47YOK4btRRDj1y95hb+qxBEg2YrV6iSVBdm74QN5pHKZVn5p5tamvVMivQxdx0UgKkS4eAIPT9i2EbASragYD/z/OgovGM0tnL645DD3QrTuKVq5Uy19YNsaFHot5bhJRiKxvZliFgOlnyKFBIvHrUrxD6hMPXMjQrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95hOL1FdDpjqG0bDTCW9zeq+v8yAw9/zAKx/Bf9+ClY=;
 b=z39Iw7u0FAQiBWbBz4xTRj5uNEfkAV++T74efNZZkxDRRrgEAiN+3T/Mwy2fXACc7dp42AZ4Ew4TTFMK2fsxD3eLigCUatYZ3sa6KDpf14T6xgu49pC9Z29m6ewQO2aewHVROK+ky9deEe6m57AJ+/Bl5mOVhhkxeYYH9zotnKE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4680.namprd10.prod.outlook.com (2603:10b6:510:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 20:11:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 20:11:23 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jan Schunk <scpcom@gmx.de>
CC: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External] : nfsd: memory leak when client does many file
 operations
Thread-Topic: [External] : nfsd: memory leak when client does many file
 operations
Thread-Index: AQHafvCbZLwyekZnbUWR/5F7PVBngw==
Date: Mon, 25 Mar 2024 20:11:23 +0000
Message-ID: <088D9CC3-C5B0-4646-A85D-B3B9ACE8C532@oracle.com>
References: 
 <trinity-068f55c9-6088-418d-bf3a-c2778a871e98-1711310237802@msvc-mesg-gmx120>
 <E3109CAA-8261-4F66-9D1B-3546E8B797DF@oracle.com>
 <trinity-bfafb9db-d64f-4cad-8cb1-40dac0a2c600-1711313314331@msvc-mesg-gmx105>
 <567BBF54-D104-432C-99C0-1A7EE7939090@oracle.com>
 <trinity-66047013-4d84-4eef-b5d3-d710fe6be805-1711316386382@msvc-mesg-gmx005>
 <6F16BCCE-3000-4BCB-A3B4-95B4767E3577@oracle.com>
 <trinity-ad0037c0-1060-4541-a8ca-15f826a5b5a2-1711396545958@msvc-mesg-gmx024>
In-Reply-To: 
 <trinity-ad0037c0-1060-4541-a8ca-15f826a5b5a2-1711396545958@msvc-mesg-gmx024>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4680:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 c1Ou0NP+z+3FIDu7a8eCZ/uCR4bDI94PQSsjj+xY1pLmLy1I6ZVKAy0ineAi4J8C2vY+Dg7qX4ILSDx0awDYwqSgxM23BWVT2okzJoS/zDlMR6HrzzcIlfpdgDOHw1eQ761KhyK6ioJCV3gicz9y8NfHnnM7uHc14ij/XDZzd+M4I+3D8a0oMvJIUzE9lIVuY0LsjVMiFZ9q9+DDXPzr0SE65rznYiCNdrcueAjQd7gDCDy9fbX+xLnRyCEAkcgvLpAhyEJLJK3NDJzsicSJmMBO/gmX1lFtyf4gfezeiBuY6dqU9SeJzMbDRdCcgz6h+gydUW5YB4Ek+SgBoMcXmhW8Q57taZtCxzuA9xYSIm8iwJuIdhUqUrJb4gyIbf5UAgHmPXV/6+hgVddYa2vmoh51AmlsbxH5DenCtLrJ+PW+J8FTVQcU5pp306/HXj7c6HCkEOzChF5QkaUCuJ/JhPjRtg0bsLGpLRDPEwxzL5ckT0NPd5sMgfr+ucS2D/4Nh1fLSyX1ZCptpGhrnJeRMt0yxN8BW7ZaN6hvksOMjPSWpNck88pLW/TIRk3yGxFjFVEKwmWNNvUA3iGlYRIQ0jp9EWTiuGPTU156OM65ThfSfORS0e2hF6ohoqkopqbGDLWFxA+UdT7VDA+6EPk/M3NNZTws0sZ1HNH57um5+Do=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QS9NN0cvNUw0RDBBRkNkakp1NDRaa3ZpZFZVbUFvbUdqZi81WktzUW1JbEx1?=
 =?utf-8?B?dXhKaHBrWm0yQVhHbVpOTEtOSi9NYWk5UEFJUXhZKy84cy9WRUdVdW5uRENa?=
 =?utf-8?B?ZTNuR05WTHcxclgxVmVMZk9ONnEyWExSd0lLanFzQVh3SC85MDJiZ01KNXZx?=
 =?utf-8?B?SUxBOTVBclZKWjdpa1hQNmgyNWlEeDV4cG5MS1VUYkN2L2JwNGZURzBTVDlv?=
 =?utf-8?B?dlNpRU04eUhycnVCNVpPL3NxVDBpa2tZcmpFSUdKTDNSVzF2MTNEZ2FQUERl?=
 =?utf-8?B?VCtIejc3ZVFvTWV2MVZCT0hvYnFwSXorcTF3OUdnZW1SM3VpelY2ejZQS0lI?=
 =?utf-8?B?NVROYWswQWFoL3JuWHA2T0xZajE3aXZBQUl2V3g4aDY5NTdralFST2tKLzdz?=
 =?utf-8?B?UGg5M1BRVS9DUFJONy9vTG9tMmpyc2Q1dWRpRUpLbXBxUERkdXFrTVExU1NY?=
 =?utf-8?B?bHdKS2JWNk1LWEszM3ZVb1J4eGMzOC8ra0ZZTS91VVFnTGhOU012VkdXN2ND?=
 =?utf-8?B?NDJXMVNNcTIwbkVLU1J0ZkJqTjMzSkMxMGEyNEhyNTJNTWhpTU4yY3lMbER6?=
 =?utf-8?B?eDVvOGN1VU1xdUxxNGxwcW15eVIvQnl6Mm1RZEpRVUQwbms2K1lVUFFKd3Fx?=
 =?utf-8?B?dzhzbHhWcEZPVTc4cFd4VjAxQldrZU41UmJ6OEM3QWZZVUw1SVdaeVRYcmlQ?=
 =?utf-8?B?TkdhTmFJZHFicHdnWkNpcm10SDNabE1uYU9LVU9ROHAzR1FZNWNHbmU3eW1J?=
 =?utf-8?B?NXJDR1R0OVFPMDJiSUUxdW5XckIvNENVVnBQaVczdSs2NGhzb1p2V2JuZ3gr?=
 =?utf-8?B?cm9hQXpGQUFmSHcxVnVObHV6QUNSSFFvU0JKSzRsVlVkdFhqY281V1VPWW1h?=
 =?utf-8?B?STV1b2MxOG5qUmg5NzkwUEpYcHExOVRtbldEdXZOVEoyUUxseGRGMnF2VkY5?=
 =?utf-8?B?N00rS3BWQjV6S0ZvWGJFN1NzLzBaV1ZLQnJlelVxeUVlSmhlaFJSQWRleXlX?=
 =?utf-8?B?L3htSks3aXp5Yk0wVUxMdlZ0RGFpTEZGN1NrZXpYV29GMEtrekp3RVlDSXg5?=
 =?utf-8?B?ODJCUXJ5K05SRmIvZ0QrYVRXZG5NWEVCY3N0MDlwZnpwNTZsb0FhNkdxK0p5?=
 =?utf-8?B?V3FEYzNDcEs3YTJNb3YrU0JrMmNNRVJPYThNRzBPZU9qL1JlSGk3NVpzTFIw?=
 =?utf-8?B?Z2tHanpNMzZaNmlQeG5pYmR2MGhvNURoamhmMnNNdnZuQWx0elVQQVRFa0dE?=
 =?utf-8?B?WjBLQnVtOEhyeTFYdC83MkJaQk1NbkZFcW5DRSttUDVHVGFjbWJLTFlKeGo2?=
 =?utf-8?B?YzF0K2IzaGovYTVudlBGdXV6elRCRytNWnR3V20vaFpTVW9EUWY3WGM1bXpM?=
 =?utf-8?B?eHFLakVlMFB4QlMwc09xMUtlOXpZenBtRFVGYlAyZitLZlV5YXNNcER6SjAy?=
 =?utf-8?B?clBZWlpDYmhVQlp2Yk40VGJOTXpCMVBrRzJjS29wSUVXay9xOUpiOHlScklu?=
 =?utf-8?B?QWlyWW4wRjdUV1N4UHUrVThlQWR5MDJpVXRTVm94MUZMTHBPUGoyRXU2OHVY?=
 =?utf-8?B?bmNxQVI4LzIxWUY0Y2R3WVVPYjlmV2JVOWdxSzhpbURUSTdtS01CTmJ0Y1Fj?=
 =?utf-8?B?T0hKcTk2dE4ra3MrZ2kyUWpmb0dZck91L294V1hqajA5MGZtdGdvcjQ1VkhJ?=
 =?utf-8?B?bzFhQkxBNmpNRjMxekJTVVQxVCs0TlRKbGp4cEV3QU9Ka203dXhEVTM4OGd6?=
 =?utf-8?B?eFZjY293bHlmYXloK2tDUUxmMGxTaWdWaUtIK0Y3SkhpR09JbVg1dWtrV3hF?=
 =?utf-8?B?RFFXQk4xTVF6NUhtRUZIZCsrRm9mZ3c0QmJBWXFhdjdobzJ4TlNUUnQ1dGZu?=
 =?utf-8?B?TDkwZUJrby85ZlAxWVRSbTRac01qYVNhV3Y1SzZaYTliZjYwYkNHampndXh1?=
 =?utf-8?B?NVhDdDZJMFNXRy9yNUw4MEpEOS9Ma3cwTG8wWGV3bmFCU2srTnA5V1BEajg5?=
 =?utf-8?B?MkVoemtGaTdLbjdMS2ZnK2szK3ZCMU9DcFZWOTd4cEg1TE8zUFZGakFOdTdX?=
 =?utf-8?B?SHBrbnIwTDJCaGxsaEh4cGVFclBRTnJMeU92dUxUSUswQVN6b1o3cy9sa0Vq?=
 =?utf-8?B?a0lnRFJ5Zlpzb1hqMXlUUWphd29CVFdVYVo4YlpLWEpTdGpXbWN4YVFxbjYy?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC08D5C8843D91459DF345336EF2640A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SuOj0Dd9Wv39xTXQacmeWtFPAjCjICNv8kQMAfcsHTIsrtM7PMhtoBW+nDrIQaHz+JL8lUtpguve5Ah6vi7h6kT6zuH0qtyLBzlP6vXj8vkhsbXQ3r0REo/aGDIjK73wd0o/Z/AQcWgMEqcZJ7D1mDozYnT/2XImYCDDR6YIwAsn9Bt0lqbVwzviWQkEXuQJF661rFNvZx61xEHNLymxfxKyyD0TgEfZtZz+IXFNyjLmxTT/2fv1UDcYBDPKgKd1ZYmKJaGZNShc/vShjk9jJPe+SuGVRh+fqqM/EeiO2amPKA6mbuIQr1+fvDg+OoG7kwJGBuZwQ8arkqRILhgEdV0+/h4wRD2zHSZnNGbYOb7csmO6YoOV39k6xDxz9roVNGvxQU7WdXRigmmo8rqNGJMbQu4v7QeElelnICTsJR4r1LatqwEoREfPNvER7SmdlmKybc171ElUF9ZLYHPf87TJqffzu9+D/DwsoshAlT6RlxI8bOLwZ3o0EKSydODJPuEvZLg3K+HqJsmKdu8pTXXznPoP6PsrI5iJGI9lVJSjpht4y/ecmW9zJy//LsfhAD+5wdWIAht6VxiRL0+8PKDGMRWIr6Pf4Gwu+VkDn/E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a59792a-3380-4462-8e50-08dc4d07be46
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 20:11:23.1900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0yDmdG1NaxR8JFF32XUXG1W265XdHePvJWrQOaQ+1dyoNEc+9aEBsbQF46IJNmMpYiSrLO/fTpa5eq5LUQAtow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_18,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250123
X-Proofpoint-GUID: gITzvji3jk6qRrri9GHe9suO2S_q3IKO
X-Proofpoint-ORIG-GUID: gITzvji3jk6qRrri9GHe9suO2S_q3IKO

DQoNCj4gT24gTWFyIDI1LCAyMDI0LCBhdCAzOjU14oCvUE0sIEphbiBTY2h1bmsgPHNjcGNvbUBn
bXguZGU+IHdyb3RlOg0KPiANCj4gVGhlIFZNIGlzIG5vdyBydW5uaW5nIDIwIGhvdXJzIHdpdGgg
NTEyTUIgUkFNLCBubyBkZXNrdG9wLCB3aXRob3V0IHRoZSAibm9hdGltZSIgbW91bnQgb3B0aW9u
IGFuZCB3aXRob3V0IHRoZSAiYXN5bmMiIGV4cG9ydCBvcHRpb24uDQo+IA0KPiBDdXJyZW50bHkg
dGhlcmUgaXMgbm8gaXNzdWUsIGJ1dCB0aGUgbWVtb3J5IHVzYWdlIGlzIHN0aWxsIGNvbnRhbnRs
eSBncm93aW5nLiBJdCBtYXkganVzdCB0YWtlIGxvbmdlciBiZWZvcmUgc29tZXRoaW5nIGhhcHBl
bnMuDQo+IA0KPiB0b3AgLSAwMDo0OTo0OSB1cCAzIG1pbiwgIDEgdXNlciwgIGxvYWQgYXZlcmFn
ZTogMCwyMSwgMCwxOSwgMCwwOQ0KPiBUYXNrczogMTExIHRvdGFsLCAgIDEgcnVubmluZywgMTEw
IHNsZWVwaW5nLCAgIDAgc3RvcHBlZCwgICAwIHpvbWJpZQ0KPiAlQ1BVKHMpOiAgMCwyIHVzLCAg
MCwzIHN5LCAgMCwwIG5pLCA5OSw1IGlkLCAgMCwwIHdhLCAgMCwwIGhpLCAgMCwwIHNpLCAgMCww
IHN0IA0KPiBNaUIgU3BjaDogICAgNDY3LDAgdG90YWwsICAgIDMwMiwzIGZyZWUsICAgICA4OSwz
IHVzZWQsICAgICA4OCwxIGJ1ZmYvY2FjaGUgICAgIA0KPiBNaUIgU3dhcDogICAgOTc1LDAgdG90
YWwsICAgIDk3NSwwIGZyZWUsICAgICAgMCwwIHVzZWQuICAgIDM3Nyw3IGF2YWlsIFNwY2gNCj4g
DQo+IHRvcCAtIDE1OjA1OjM5IHVwIDE0OjE5LCAgMSB1c2VyLCAgbG9hZCBhdmVyYWdlOiAxLDg3
LCAxLDcyLCAxLDY1DQo+IFRhc2tzOiAxMDQgdG90YWwsICAgMSBydW5uaW5nLCAxMDMgc2xlZXBp
bmcsICAgMCBzdG9wcGVkLCAgIDAgem9tYmllDQo+ICVDUFUocyk6ICAwLDIgdXMsICA0LDkgc3ks
ICAwLDAgbmksIDUzLDMgaWQsIDM5LDAgd2EsICAwLDAgaGksICAyLDYgc2ksICAwLDAgc3QgDQo+
IE1pQiBTcGNoOiAgICA0NjcsMCB0b3RhbCwgICAgIDIxLDIgZnJlZSwgICAgMTQ3LDEgdXNlZCwg
ICAgMzEwLDkgYnVmZi9jYWNoZSAgICAgDQo+IE1pQiBTd2FwOiAgICA5NzUsMCB0b3RhbCwgICAg
OTUyLDkgZnJlZSwgICAgIDIyLDEgdXNlZC4gICAgMzE5LDkgYXZhaWwgU3BjaA0KPiANCj4gdG9w
IC0gMjA6NDg6MTYgdXAgMjA6MDEsICAxIHVzZXIsICBsb2FkIGF2ZXJhZ2U6IDUsMDIsIDIsNzIs
IDIsMDgNCj4gVGFza3M6IDEwNCB0b3RhbCwgICA1IHJ1bm5pbmcsICA5OSBzbGVlcGluZywgICAw
IHN0b3BwZWQsICAgMCB6b21iaWUNCj4gJUNQVShzKTogIDAsMiB1cywgNDYsNCBzeSwgIDAsMCBu
aSwgMTEsOSBpZCwgIDIsMyB3YSwgIDAsMCBoaSwgMzksMiBzaSwgIDAsMCBzdCANCj4gTWlCIFNw
Y2g6ICAgIDQ2NywwIHRvdGFsLCAgICAgMTYsOSBmcmVlLCAgICAxOTAsOCB1c2VkLCAgICAyNzEs
NiBidWZmL2NhY2hlICAgICANCj4gTWlCIFN3YXA6ICAgIDk3NSwwIHRvdGFsLCAgICA5NTIsOSBm
cmVlLCAgICAgMjIsMSB1c2VkLiAgICAyNzYsMiBhdmFpbCBTcGNoDQoNCkkgZG9uJ3Qgc2VlIGFu
eXRoaW5nIGluIHlvdXIgb3JpZ2luYWwgbWVtb3J5IGR1bXAgdGhhdA0KbWlnaHQgYWNjb3VudCBm
b3IgdGhpcy4gQnV0IEknbSBhdCBhIGxvc3MgYmVjYXVzZSBJJ20NCmEga2VybmVsIGRldmVsb3Bl
ciwgbm90IGEgc3VwcG9ydCBndXkgLS0gSSBkb24ndCBoYXZlDQphbnkgdG9vbHMgb3IgZXhwZXJ0
aXNlIHRoYXQgY2FuIHRyb3VibGVzaG9vdCBhIHN5c3RlbQ0Kd2l0aG91dCByZWJ1aWxkaW5nIGEg
a2VybmVsIHdpdGggaW5zdHJ1bWVudGF0aW9uLiBNeQ0KZmlyc3QgaW5zdGluY3QgaXMgdG8gdGVs
bCB5b3UgdG8gYmlzZWN0IGJldHdlZW4gdjYuMw0KYW5kIHY2LjQsIG9yIGF0IGxlYXN0IGVuYWJs
ZSBrbWVtbGVhaywgYnV0IEknbSBndWVzc2luZw0KeW91IGRvbid0IGJ1aWxkIHlvdXIgb3duIGtl
cm5lbHMuDQoNCk15IG9ubHkgcmVjb3Vyc2UgYXQgdGhpcyBwb2ludCB3b3VsZCBiZSB0byB0cnkg
dG8NCnJlcHJvZHVjZSBpdCBteXNlbGYsIGJ1dCB1bmZvcnR1bmF0ZWx5IEkndmUganVzdA0KdXBn
cmFkZWQgbXkgd2hvbGUgbGFiIHRvIEZlZG9yYSAzOSwgYW5kIHRoZXJlJ3MgYSBncnViDQpidWcg
dGhhdCBwcmV2ZW50cyBib290aW5nIGFueSBjdXN0b20tYnVpbHQga2VybmVsDQpvbiBteSBoYXJk
d2FyZS4NCg0KU28gSSdtIHN0dWNrIHVudGlsIEkgY2FuIG5haWwgdGhhdCBkb3duLiBBbnlvbmUg
ZWxzZQ0KY2FyZSB0byBoZWxwIG91dD8NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

