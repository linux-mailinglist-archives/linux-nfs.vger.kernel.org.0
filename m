Return-Path: <linux-nfs+bounces-18704-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE3JAiVYg2mJlQMAu9opvQ
	(envelope-from <linux-nfs+bounces-18704-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 15:31:01 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DE5E71E6
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 15:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D6983009578
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 14:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E7013B293;
	Wed,  4 Feb 2026 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R94zzIXR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QgBCHS8Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E81125A9;
	Wed,  4 Feb 2026 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215456; cv=fail; b=nrVgkJGgMOBAmGf7pyhkj+gcCaMpggv/XPMPIiNI525MKoqApGFN3LiSdDl0ir1E4yiK7MEBQfbIFZ004bMYVDTFaVIHJVgc1I652724zFPngj3S1h7RMCc2hBn/PEWQhvO+RuP5xncVcaOc4kV2F/xBAqpjrVSsIn4oxzxxiPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215456; c=relaxed/simple;
	bh=+OqViIOSh4QdceP762yhAUEU0ywjgTMCPl7xCJe2rdI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dN6sIBtW4ra8M9sau00gvaw3KyfnlRg9ibxduDGleZD0jd2EBqIo42UDoufgpr+WJ4WKUrrG6b/nTOzSKw+k+tizkODJid9o1gcNn90XASCyKcDxa2jRjHQfjX78ctk8hsOjmirSZ87ooG1Q6eQC70uTIlkuvOLC9NzcRJSdYo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R94zzIXR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QgBCHS8Z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614DOEj72289898;
	Wed, 4 Feb 2026 14:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mC8l/AEDokEMCD2P/OoUpAqp9Y2Ryst5x+WC5KZxr2s=; b=
	R94zzIXROPSuZihrU7yb+wwCZlZFmpMadRZgrA9waAidOAOmBzlfaqaJgCAimMsf
	5VObhh4e2RODnLW3DquSELNtUQB6pM+jhO+cAhK5db4uR8z/g+uXiPeM+QpfJ3w7
	+S3ZBAy2OpIY0/oToVa3vdMiagGcH6aiOVAkVbT/gHVQ6AXfTFJg3Y0hoHew5SEB
	6lHeguibOKUe2VsvfCP38ns8I6hg1DlKu60MEF6AhYTSWsjwF0x5rjr54xknAe3L
	6kjwooicYIfK8BJ9z+CQQZFvQ//q3tKtgIwRFitwVikHn1A6KC8dViy8yp+F2Wz9
	3ufkjIgJ9c+Stw/Eaa+aVw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jm4sxnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 14:30:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 614Cf96K001225;
	Wed, 4 Feb 2026 14:30:35 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186bgbas-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 14:30:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHsMgM2/KW6w/KkgBtivhslEq3LEKFQv21DxN18icqOvlOeCrPCQAupZo2NNiRHSkESwvSn9ISqXNfg6r3WrB1ggeg8JvAwk0lEOTSK0ijJSgdIa4oGAarf+t9gHCbjk5udsnt69mXtwcsKEE8Kx+YFKHOBjujuxMibO3fU8lUuPYcRjJjV48lhFglHn0HSlCH/xDEa4nOPUwdfNxzWSbahwkhRR8zFqYFIrdySUW/6uNkKxzL34kvCXOF5VHwwpyizV1rRUuRkAFgXbnlo4M4KDGHKXRpjDmBFpABUs2lxcKMTrkqPegXcQthcgOHY9iVgHVZNPJy/sDWwk1GDZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mC8l/AEDokEMCD2P/OoUpAqp9Y2Ryst5x+WC5KZxr2s=;
 b=L7ZkR5/mJYakjz/N1xsPNL/uZK0pl6ktCI91Zw0C7f98gwX7iMoOxpiL6pqVP2ayAeKJBKnRPg2G/VNrkectV9AZb9srfJN4TWVwesDKVwYAKho8Wr7O7DkKuuZzV5cTmnYmkBh9hT5ULAFiN0am2j2OWvSADPSb9M0NuMbw5loW6jXlHBCTst/remJKkwn0IKoGZl15Ld6IkwxMx5XNBsQ4H81eS0Da5uoFPoVtWtOtGu1ICQUAWGkYFu4vrvKEPpDRMrzGmLBAHlvOzk0jh67jVG6uDade5tBLdXvyeRqB8cwyTkFogIXltVRtA9m8FIZd7zuwLSeh6MZUt68Tkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mC8l/AEDokEMCD2P/OoUpAqp9Y2Ryst5x+WC5KZxr2s=;
 b=QgBCHS8ZYjHxZydcGKKliDzU9k76clxufPwBrM5M3p07f/W7FzLuxchZmlh7mvit+bJgJATnKaBjO9z3gNQ9jIFFftt3Z6iREdgEf+/5Wr1h7bL1ITu8CuLDCQH53RGwZ70MkXszZGSq5w4Mkp/Uhx5BAAwp9plvJU+CpgZLEV8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH5PR10MB997741.namprd10.prod.outlook.com (2603:10b6:610:2ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 14:30:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9520.010; Wed, 4 Feb 2026
 14:30:30 +0000
Message-ID: <65f86149-eafe-4f83-ac18-f3aedd516152@oracle.com>
Date: Wed, 4 Feb 2026 09:30:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] sunrpc: Fix `make W=1` build issues
To: Jeff Layton <jlayton@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        NeilBrown <neil@brown.name>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        llvm@lists.linux.dev
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>
References: <20260204094500.2443455-1-andriy.shevchenko@linux.intel.com>
 <9859fe54fded87e720e375b1b267908437480f47.camel@kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <9859fe54fded87e720e375b1b267908437480f47.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0420.namprd03.prod.outlook.com
 (2603:10b6:610:11b::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH5PR10MB997741:EE_
X-MS-Office365-Filtering-Correlation-Id: 63dc4d78-90c6-4f6a-9d4e-08de63f9f2e8
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UGMzZFlGeTJIL012c05LRnV4YURrLytoOFp6THBFQ291VGYxd3RCUExBcjc0?=
 =?utf-8?B?UUpjU0tIZGFGRjBBeXA1M25xWUcrWkxkakQ4cTRkQkJTbW0yQU52M05ZcW5R?=
 =?utf-8?B?TU5vbE5ZNVBUejJlVmQvU1B1Sk0rOVVNNjZHK1VXQUdaVUpzaGZ5aVVtbW83?=
 =?utf-8?B?cnYzRnB3Mk1iRklzcnMxQWNlSG5xdEVISVB2SmlhTEZFZEhKWHRBSTM0U0dP?=
 =?utf-8?B?M0dMaU83Qko0L2pLbk0ydkY1b3MydUNnUTdVdVREaXVJN1QrdUtoWGI0YnVP?=
 =?utf-8?B?eVVzK2lPVjZUa0ZaUVZEaXdyM05yRWlvZWRrT0Q4NmFBWlRRY0d1MVJHaWNs?=
 =?utf-8?B?dUZwb093b0IveVJldUNBdWJpUnEzUDJoelpvQWd5c0dZREtBZVFsaXEzdlJ1?=
 =?utf-8?B?cGdoa0Z4SVk4aFFIQjRnY2dzckdGUFZ0QlJValB4WHJuTzVXSklScGZ2QnZq?=
 =?utf-8?B?UFFBaXdxYUpob3p4SG9QRDZyZlQ5S0pSQ2FNUWllVWRSanFUb3RxVEhMUUJp?=
 =?utf-8?B?a2RNVExNMC9YUWRVczlsVDBmOUV6Z0MrUzVueVNNQmtEa0pMYWxLbG5Fb3dH?=
 =?utf-8?B?UXg0Y0xTSGlUSlJDUWI3b2NYVkQxWGs4R2x3VUc0aldEWmtYNU5Xd3BKQ2hI?=
 =?utf-8?B?VHFIOEQ5bFA3eWxVUTcvM1FQTHRMQXNYN0MzRlVoOWJGZ1V0dHI5MmN2VjdX?=
 =?utf-8?B?WTd6U3poajdFTzZoYlhCOW9adlNhRjhiUUlSTHFyODFMTXRzUjNNMitvbDZ5?=
 =?utf-8?B?dm1VRXhySnpKUkxGNEIvSWhYUmhUcFg0VU5SaXE3N3VybFF6VVlCY3h3Q0tR?=
 =?utf-8?B?QWpzbFlZQlZOSHgweWR2dTNNWXovbzhNNnRQU2JyNkNGd2hid3R3d1F1d3J2?=
 =?utf-8?B?Q296TmxpTzRGZUxQSG4xdlFCZjBtSSszaGpQNFRFVmhscnVDWnAzaVdnR2lB?=
 =?utf-8?B?OWJxVXVEM1pFMk41ZTNLcis1UnNCU0kycmV2RU1CZUdsMEtZTFJIcmdoVmdF?=
 =?utf-8?B?S0ErMEU3T1R5dTlqV2d4QUIxQ0J0dEMzSDBTS09XNDhVb3VHRXdLU2pQV1BX?=
 =?utf-8?B?VkVsVTRGR1FhVzVjdVJUclc0WmpnSm1SV0VOVWlDdERsOGFUYzl6Qm02VWFy?=
 =?utf-8?B?dHFYWWE3cTJCeC9Vd1pZTUtQeUZkd1AzMnFiSE9HRGZpMm04VzF6QVpkRzNm?=
 =?utf-8?B?M2pzcGpPNlJ0TitnY28vQ1ludnllRisxMlUrMENDYVhUSTRxODd2a1FMN2t0?=
 =?utf-8?B?WmlOY3M2WU55Nnd3OVI0S3lJbnM3MG54ZndvNGoyTEJoZXZTai9Mb0NGWllP?=
 =?utf-8?B?OU9CQjY4ZktwclEveFBVM3hJblRIU2xiR1JneUpxR1FnamhWNkt1VFFBbkNE?=
 =?utf-8?B?RE51SStyMzRqY2xKRXo3d1Bhek02NjBiRHJIUm0xZ3J2ZkhUdTRnTWhPOGUv?=
 =?utf-8?B?dEhlL0pTMHlGdi9RWXppMXRydFZaQVduTFVpUWhXc2dCZHJhcEtDdEZoOFgy?=
 =?utf-8?B?WGsrOXl4SDI0U0pmMHQ0R2JqajlFQzZaRHVlOGR4QVBiTTM2WXNSU252V21m?=
 =?utf-8?B?SFhmMGJjUHUyNkFhdjNJb0g4RnY3azVPMUIza2JkRU05Y0xDTGVXVHlPdVFE?=
 =?utf-8?B?L0dXbU5sWjNhZVoyWlM1c3dvZ2FjZFMxMTArUjNhNkRyYnYxYzMxRDRVVkpQ?=
 =?utf-8?B?ZXB1OFhPd0NkbEs5T2VTejlQQXhXVUNlcHQ5Y21OUlNORmcxdkhuTmZDMU5B?=
 =?utf-8?B?L3FrVTdMMXBibE82UC9vWTdNdi9NWXVsNjhZekJ1S3VldUgzNTFvWHo4NEpx?=
 =?utf-8?B?T1h3Sy8zdzQyc0JrWkNzdktINitLeWxxL3pNL2h2bzhIUWg0OXVjZXFzTmZm?=
 =?utf-8?B?VjZnUlZkUWl2Ky9QRm5zZUZVY2VzMUZrMlJlK2QvUzBrRml5Y0JsRUFNbjA3?=
 =?utf-8?B?WmMwblh6ZTFkcWhMcWhJd1RBM2pncXYrT08ydjB2b0hXSndGdFNNL1JoeWc5?=
 =?utf-8?B?em5ZQzkvUHlXVHB4REw3OWllS2xmVTArbXppc0RhNHJqVUhLUEZScnh4b3RJ?=
 =?utf-8?B?aTNiTzRkV3RkNG0veDREVU1tVUJwOVoxQ1FCSStnWEQ3NGFndllTUWFhSnlM?=
 =?utf-8?Q?QoK8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dGlZUVF1VVB6QnNveUJKNEhobDM1RTJBaVY0NzdFZUdwRHlPeE55TVcxbHVO?=
 =?utf-8?B?ZUk0N0VYbFNhM2orQmVWN2NsODdBZDd6R3h6cWJtYWhVL1NVK0JPTGRNREhE?=
 =?utf-8?B?YlJCUzdFS3V1YTVmZFV1TEppN245RWo2dmF5Z3RXeEp1S3YzYXN4QU84NmpN?=
 =?utf-8?B?TElGVjYrTlU2Tk9iUThuY3FURmpmSkZNdEZvU1FsdWl2SEJiMUYyMDQrVDRy?=
 =?utf-8?B?dWJrTGhDOUExeG8vMkdYVFpZb2RsamlGZUJxL2N6RDl1Q2x3Z21wS0lMMUdH?=
 =?utf-8?B?NExLVkNMMTYrWmVaWVg0Slpld0I4N3h2cnNkMjdWWldkTStPNCtIWkM4dmdJ?=
 =?utf-8?B?a2RvUXpFQUFod0hESkt3c0hrWmUrYlVCVnVNWVpQcU5ldzgwMWJJR0FyZHls?=
 =?utf-8?B?SW8zT2YvSzVuY1d4cDJ5dGcyZDlhVGFKQXZVb21kYkNNWkZrNkg4ZWlSQnVT?=
 =?utf-8?B?U25aNGxjU1ZHQ1lQNkpabC9YTUdBSno1a053azBUd0FObTUzY0xEa3dDcTZt?=
 =?utf-8?B?N2VIZHRoakFIazBMd3FKQk1SZ3lsbE80SXZnSHowMy82M29SQ2s0eVFrTWpv?=
 =?utf-8?B?ZGkxUGFZY1JVTm5kVXBnNitIK3c4RXl5ZmhUNGF2OTExYnVKdSt1T3QwTmZI?=
 =?utf-8?B?Z3hLUWkxcFZBbmxxOFppUnpUVE9IUUFnYWNaUlgxdUVMajNhRTdRTXE2WUVY?=
 =?utf-8?B?WmdiTHVhUXpEM0grYUpjQ3BrVWI2RUkrZ2xVQ1RTNC9kV0grMjlIRFNVZ291?=
 =?utf-8?B?Y1V3aXVLTkRTYlMwM09wWGJkVmR1RTJtSHMvOVpBL29TbUQxTWZEeEpIVE5h?=
 =?utf-8?B?NUZoRzhXMW40ZVdQSy9OZXNNajFiOGRTZFhrclJ1c2ovV2VsMVVTdG83Wmdp?=
 =?utf-8?B?Z0ZkdzV5ajR2aEtmVDVyWFNDUEx4WlhGMVlwNFgwWmllS1ZKK00wSS9qTGpn?=
 =?utf-8?B?VlUzMmgzKzVpQmJmcGJmOGI4MDZvYkRxZ3pVbzRaT3Jaa2hnNDlCMmV6c29J?=
 =?utf-8?B?RlVOcmxKcjRMcXMxNkFhVkNRZVNhRGc4ZHlVWjZuUTBFWU43SzlJbDNiUEJE?=
 =?utf-8?B?anprQkxRdUtGUmt3eWxMeVUyb1hNUkZHck9nYUd0cE5uUjNNblVzOGgvalNI?=
 =?utf-8?B?VDZ2bXlDS1FxcG9ManhCdmdWa2NNOUJsRUVNWEFwWHQwRWE4QjlhcStFM3pM?=
 =?utf-8?B?ZmxuQ2RTK09SaGljWWJFa0ppbFJ5TCtVSjNoMHl5YTNOYVRjVUNldWs5b3V5?=
 =?utf-8?B?em1CQWFGT0ZsZlM4UUo4QVEwWUtteWxBR2pVU2tSZWdsRjZlS2o1THZyVWV1?=
 =?utf-8?B?cUJwNjhnYXQ3YUpTdU5BYlJhc3ZJczBra0ozR2pKT1NaVFJ0YktRU01Za3Iy?=
 =?utf-8?B?SEsvUHZwbFIvWmNrem5NSmkyZkhSK0YrNkJXNUkvNGlvQ3ZKTkZPQXJJcHBi?=
 =?utf-8?B?cGovWS92SDl6bWFiN1lmT0s2RkVGaDZEcE1GWVRudzdScXZWNUxyK2p6Y3ND?=
 =?utf-8?B?bzF1RDVybFRTcjlxdEpYZlB2d2cxSk44UGpEcjVON1V5SlBRdEtmM3lsT0Mr?=
 =?utf-8?B?eUtkK1BtT2pNQVN3QXBSa08ydDhYbWV4SXNOVlJqamdNUVV5VFcvczYyQmla?=
 =?utf-8?B?RnZlMFlHYW9ySHNJdDErbWhvM0M5OERneXJTNVdaR1BFa0F5aU02L3BySXYr?=
 =?utf-8?B?SHFENyt1eFVQWS9aWCtmTC9MdkRpRUlPTXQvVVA2OUVBSG5hbFg0akxBQmMr?=
 =?utf-8?B?Yk11R3hoQ2t1aFBMaXJSdUJ3OE5JdzVETUNZQTNrZytDMlZqLzRRZFY4SHpP?=
 =?utf-8?B?V2g0cFZQa2M4Rm84UkpMc2FyYXgvdzgvbHVBMFJYSHVSU2dxQ2N6SHJWR3hG?=
 =?utf-8?B?ZEJ4c3dnQThLYmRKd1phUUM1STJTSzhxRWptTHl5SHAxRUtoWURKdU9reE52?=
 =?utf-8?B?c3BQaUVYbjk0cTRkcjE2Y1hoR2VIUGRDdjlWVlYrK3BkTnMrUVIrSWdCclNM?=
 =?utf-8?B?NHZhQ0dpQU1FYjhSajhjNEtFd2ttOXlJT3lkQmpNMmc5dElrNXpmTm40ZUdn?=
 =?utf-8?B?ckFENE5IV0p3T2J1akwvQnFQTk0zL0pTQkVZekY4T1lsSFZOTTV6MWwyazdq?=
 =?utf-8?B?QThGM1ZGZkVpcXlHNGpCeUxBcitNVEJoYXh6OElDQUE0OHAzUFd1VE5xLzRx?=
 =?utf-8?B?UDlMcUFLckJaUnptRm91M0FzZm8wRUVsaEhiU2Q5ZkhZQWJ1RkNselNOa2xi?=
 =?utf-8?B?MC9OS2V1MDJQR2xETE5HUEpsVCtLQjZ2WHNDeENHaUdXTDEvRUJ4ODBJVU5Y?=
 =?utf-8?B?TlhqUmY1bjlGT1VzZkVGME9XaG1DZjlXZ0hRb25uRE9GNWN5SFp6QT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vzOQ1Jx/IJGh6iG0dpDmI26PCt4Y32gHzQGuKQswRd9x5pQoMYXO9hZz4YQRaQSSJiDmahFyCvoV/VelAAPPbVCyeqdxey80tCo0nW/N8IliPjR7qj5Tr5vou9jZaBjZpimD8Qje7SRUZphTY8w/j9S6wkA5ac2uOQikmqkxHK8/hPJswlK58/nKssoKd2qZ5JeWINzmP13z4C9keliq9bKFwvHxUBOquJIt4vgwyo2j7EkrCze5vwyQAmR7quxgZuf1sfqk1bza4yno+XkuIdohHI+Z7v3GO6G4f1LZ01ivqobtBhVgDmQT6DgaJPyRcQ17zhO+TtAdb+hdCBKPv+YxP3Kwttrdyw6RGNgj8kfCVCuU+JLp0meczGRELQVa+A9KGXDPnVv3fPBYxTDr5HG5E4wAfo2SJQYlxrxwjBg3R/XoN8XHgPhdq4KW2HuR6MCwvWhHSQYZVDcFJTV9kJmiu/2VhUWBLXjwMGEi8se9bwyNIuEoZUYLLmUnFLZSmc41moyoIg4AcI8kNv1OMtfnNHJcGy7f4D6PTHY5MtV23FKiW2qYCHrV/HyG1sROt+DhhYPy97hANh/LnUtAauqqbU867K6jUwBhGhbXhvA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63dc4d78-90c6-4f6a-9d4e-08de63f9f2e8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:30:30.7990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uOdiNVC32fu+pFv1nITWgnHra+yzPqRzdzs1VQYntBX2msO4P2PF5eMP5WdiAdD0FI/BMaAbymiXO6gLyoQQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR10MB997741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_04,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602040110
X-Authority-Analysis: v=2.4 cv=OuJCCi/t c=1 sm=1 tr=0 ts=6983580c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=76tJbeli2aJfUao-raEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDExMCBTYWx0ZWRfX2eMzrCE1/dBH
 Dex2B1KktAoL1MmGAdPDe8s8wMeSzU1xSYcTAygLr+uoqzZqyipPBNpKLRIDWz/kLMUYw2NMX1v
 Uqre5Q3FPCTwScf3ndlgUIHwgVZwr5coVdBswZF6fplUnifpVV8O1YUVsFb9c69VvIkY15PU1Oj
 nKuUvwkNNn5ChHmP2jQppl8o1ds1TaYhu0jNqz1mkl9/E2PtNMSNqxWrV1LnT4Q4tzGxGIL2n8Y
 WJZnDLD/p2hUHqa02C1hiVTw7CjOgBnLbwPwb9WxEpgqt6rHHXbvxk12IBIOcpNE4kIZCBGmyWl
 gVI9mOlq4GaZmLgVVnzTIlwSlmqd9OvOdVNkFmTqUJVCHMv4GCCF5dJ2vBgt8OtwTHWwanGdWWs
 TFhA4qChc3Lj5DUTsskHdKTKqAQP9Q1vVc4cQe5nl4lxa57K1tMPa+Sh0mcFeFjjM3+waZeXqzN
 SuygVFmq5QUOk5kGFEg==
X-Proofpoint-GUID: bMtGWTL1V8IvFrHPJwmiSMuz0NrS_-qx
X-Proofpoint-ORIG-GUID: bMtGWTL1V8IvFrHPJwmiSMuz0NrS_-qx
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18704-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,oracle.com,talpey.com,davemloft.net,google.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,oracle.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs,lkml];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 54DE5E71E6
X-Rspamd-Action: no action

On 2/4/26 9:28 AM, Jeff Layton wrote:
> On Wed, 2026-02-04 at 10:41 +0100, Andy Shevchenko wrote:
>> Compiler is not happy about unused variables (especially when
>> dprintk() call is defined as no-op). Here is the series to
>> address the issues.
>>
>> Changelog v2:
>> - added patch to kill RPC_IFDEBUG() macro (LKP, Geert)
>> - united separate patches in the series
>> - collected tags (Geert)
>>
>> v1: 20260204010402.2149563-1-andriy.shevchenko@linux.intel.com
>> v1: 20260204010415.2149607-1-andriy.shevchenko@linux.intel.com
>>
>> Andy Shevchenko (3):
>>   nfs/blocklayout: Fix compilation error (`make W=1`) in
>>     bl_write_pagelist()
>>   sunrpc: Kill RPC_IFDEBUG()
>>   sunrpc: Fix compilation error (`make W=1`) when dprintk() is no-op
>>
>>  fs/lockd/svclock.c                       |  5 +++++
>>  fs/nfs/blocklayout/blocklayout.c         |  4 +---
>>  fs/nfsd/nfsfh.c                          |  9 +++++---
>>  include/linux/sunrpc/debug.h             | 10 +++++----
>>  net/sunrpc/xprtrdma/svc_rdma_transport.c | 27 ++++++++++++------------
>>  5 files changed, 32 insertions(+), 23 deletions(-)
> 
> These all look like good changes to me. The first patch should go to
> Trond/Anna and Chuck will probably pick up the other two?

That's what I was thinking, as long as there aren't any dependencies
between 1/3 and the others.


> Reviewed-by: Jeff Layton <jlayton@kernel.org>


-- 
Chuck Lever

