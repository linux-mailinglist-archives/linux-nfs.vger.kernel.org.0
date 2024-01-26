Return-Path: <linux-nfs+bounces-1452-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E8883D2B9
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 03:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CCB283119
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 02:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AEF29AF;
	Fri, 26 Jan 2024 02:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MXjk7Ugs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UPxxBhSd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F328BFA
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 02:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706237278; cv=fail; b=P29Ddv6rlldCJv2l9lrSq4n84jU5YQtPYP1hUPq4AM0OpB9eCemfDYySmo1pmXEiSmUBSc+idjth6J1Bkqm1o0Gw6gGzbHsKQ9QWeFY7RGgmSx8s72wY9TdN7wXyIuipLZy5IdpGpIq1MZ7mtcBRD79lgTftCsKW5XbrpnSwL14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706237278; c=relaxed/simple;
	bh=1H+0upMi1ov51oC2l+mw6K9fjdyPogzCy9bfG/9GF78=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pErjNdkV1JA573hTgtHRbrMEJT4CFmE1/D/L1iA9/kM6o9iqmkDxvqEsyEdFqHOltKeCUUWPSxogHQPSTD9PF13fYt1gVnFHnJaV/L+ajN3AES/WlUk0kbOkjKzkzO2Kzrl9psj79pcjzSsahvVEJIlMXsqRs7bZq4CBIAmiMLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MXjk7Ugs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UPxxBhSd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PNAlH0009082;
	Fri, 26 Jan 2024 02:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=1H+0upMi1ov51oC2l+mw6K9fjdyPogzCy9bfG/9GF78=;
 b=MXjk7UgsbF/2AzpSIpE4jy+n6RgndrjRSaTZnUPNBtz9kYMKnI1UgZD0bZ2mKuSNwNje
 J9TKIRUos0p5mLXZHbsn/e+agcrmypvMfkb84UeVe/QPrmp9pmlIIPRW5DpS2vT7J9PY
 Xq+Jt9PediCKYQbv00QRCInzcy1ryXt/o0JmNIr2kiIJWvkD1XscH/brwXAtWVc21A5e
 7cUPoSDQ2WUErTZKKlE7K4GKhZabn4zYfNsgeIp6NdCJ5ZAAh5MWSvOQucSdgbGl2yWG
 5BjctMWZbHStvGsccDLp3t89cvmSzGNuWXdryAMWw7/rywwoR9ryoSc53elaZrpJTV4F 2w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7ap15mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 02:47:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40Q0O6Iv014338;
	Fri, 26 Jan 2024 02:47:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs375bn56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 02:47:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHP//TQLlF7qfgxXTZmPz3Yu8Lb7kRJFGoU2c1UmJwf9AqTGDLAYKmOSC2JslUJ6p5MknO6OI96wb/ldk80F6qlpjc4V1buD+g+oxiBCMjRC0QiMW9kPW4jj797TpTAdfRYIl2zhEUda+dBhISCo4Q0aJ1Jro8l+sMdNAEVj0jcl38dcT6cDL2Oi3VSLCcwjU2+CHYqY6nE8Dv+XZK7NG+0ib4Kx4odhgbpX99IU2jq1E16xGVY3iaNsqPswm8PP/DnyzJlkD76SVC+qgSoNBytfEt5VaAhL6dGO1ywgE8nuUmcl3Y3M/AQDEoq/WrPn5JjjboJIRwW+XCUSFsd8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1H+0upMi1ov51oC2l+mw6K9fjdyPogzCy9bfG/9GF78=;
 b=n0SnJivt8wN26wGTcH7KKTIKSHQTK29rY/5+NEm1IEcJ8Pc9zn7em/NHo/LVZKzrhZhJ/o6oyFdQbF4kwaVOs05eZlBu7kGNicYX/b5YKLcxq1itLjYvqKcpFMHs3Ig+mlFsm1JhK4p1nwG9k3zKvyd0C9T27m4VlSSdAonJgk4tIXVWRYJ+JWP+g3xrSmFeRRXq8MulW2duBOs+VgGvaKbkNsLv2yvSSJXBOvju15/g8r0QMgNz1qg4HhMAUFXSrQRA0jMMRwlNNVPoOhMzOK1LPXxpGt7GjTcCTradKFdDxMTToZclvzmYBwlLqaj69/SfeF4jGTbhEAwiODhFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1H+0upMi1ov51oC2l+mw6K9fjdyPogzCy9bfG/9GF78=;
 b=UPxxBhSdLS8CwZr+4udv05dfLqPJw/Cf4kBYUUkbJBxFWolCqJveobbw0tHr/0VoGP32tXLLXADwva1cTAtFdQOPdmNmFdBi6/H8ycLkCLnq6aq6+iJgADQtP0Ymvsg3idwe9aG5FWh+i75/HWIPDETFgmVbHRsfBK7Y9DahtDQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6547.namprd10.prod.outlook.com (2603:10b6:806:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Fri, 26 Jan
 2024 02:47:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%7]) with mapi id 15.20.7228.026; Fri, 26 Jan 2024
 02:47:35 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Dan Shelton <dan.f.shelton@gmail.com>
CC: Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton
	<jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Implement NFSv4 TLS support with /usr/bin/openssl s_client?
Thread-Topic: Implement NFSv4 TLS support with /usr/bin/openssl s_client?
Thread-Index: AQHaTzVH7PZF8oybT0WXTmp4HnCNmbDq/kmAgAAJdoCAAEFQgIAAHIKA
Date: Fri, 26 Jan 2024 02:47:35 +0000
Message-ID: <4BBD3BC4-68A6-42C7-974D-DD98B09B7859@oracle.com>
References: 
 <CAAvCNcBMY1mrgEgy4APSiFXDP5u=64YXNjiHHjh8RscPsB3row@mail.gmail.com>
 <b25436fa457256f0f409fbc33f60c13e8ab6af12.camel@kernel.org>
 <96A320F4-AFC1-4DD9-8D5D-784F13DE94D4@redhat.com>
 <CAAvCNcBjuTLwsLb7nQxaS_O8PVLGPxk=6y2Wj8rp3se0+YxvPQ@mail.gmail.com>
In-Reply-To: 
 <CAAvCNcBjuTLwsLb7nQxaS_O8PVLGPxk=6y2Wj8rp3se0+YxvPQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6547:EE_
x-ms-office365-filtering-correlation-id: 079ccc0d-1954-417b-930e-08dc1e1926f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 0FA/xkfhlh+mHbIXBsmZKNoLXpYuwqu2ODDVjvbcwzCzCDdVZkL8l9IRVprS1aGaP6mPI4ZioejWT+0+ciDK3jAjP/31ctlllk7uuB/QJBt8VdVnx8mI9Tu1s9zLIwTZFPARcCEnv7hgLoHpgUtnWUeMj0FbEy3i6nDgV8t8aEQeXc0/VZjDKz81b3Vll5oEjqm6us5ohPfuYl5ys97j+czFAJx9d/H4tDmxjuPm10qZjkkz7GHfuakGa60QaDcrrumceT2cYeQRRgG0kkgYaBLIqrxsg8SXgGjmKtUDheolx7S0Wj2T18o25RTYHX5k18fgSCP3f3yy6dxma0VK55X1ZhPgucFCIBsn3yhHs/e5WyUOiol7w+TrA9GgalzSCm+LuzT4WquAaSurzlGNV4TES+9us71m9Eg/uLmDir/7exesMQwbjHEvWOWbfJcpWtn8hURl98qmOnwz1QBg8nw1DCvFEM22F78uEXgeee4NFU9owaql/+Oi2aquB3f/tPONsieJB5UDgzBWZZTl1+VE88O2ShoylLQqvB6WjQJROBiE/0Fmid3qbp2fN3OsotWpww57jdewymPybV726/7wy2Cze31dsu4LuA++B61dYJmCVtY8VaWb+XVvM9J82yv+zoWHm06N4EWH7mvsvw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(83380400001)(2616005)(966005)(66556008)(6486002)(6512007)(6506007)(122000001)(91956017)(38100700002)(2906002)(4326008)(6916009)(5660300002)(8676002)(8936002)(66476007)(64756008)(53546011)(54906003)(66946007)(66446008)(478600001)(76116006)(316002)(71200400001)(26005)(86362001)(33656002)(36756003)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Y09ySGNvT2xkQTY3MWVmNmlIei9KTmxjMi9GTE5qWEFGdnV1cXI2UEdpK1R5?=
 =?utf-8?B?RkZscnZvK1N2UENZdEg2L0NUUWVqVlNyaTJCV1JqbHI0UVVSZnltdUl3MVRm?=
 =?utf-8?B?OUJOeElDVXRxSHJhMkF1ZS9hVnFNNUdyeDNpNXJsMnBESVlWcFd4cHN6M1Vp?=
 =?utf-8?B?Sk1FQmw2R2ZyMnJnT1ErQlNCeHlzOXNkT0puUFdtdVRUWC9QdzdnZXdmVXNh?=
 =?utf-8?B?Nnc1NkR6d0lXaEFPMW9hMHNNQlBNNTljRmFvbWhWclRGZ1MrWmhKRmVraFFo?=
 =?utf-8?B?L0xnbkFJYkQwRVZNNWcrR1hOM2RzSWRvNlIyZmc0RDFVZ0RYdjNUNGVVclVv?=
 =?utf-8?B?QmtKUTl6ZGZzcjR3K3A2Vm5oZEsxWVYzTFFvb3lUeE9JcVljWXpQb3NBamtZ?=
 =?utf-8?B?bkY3dVdlRlBVZklCbXpqQnYrdW5xVzZIZTl6OE9mT0hHNnZ3amZTUDIxNTNJ?=
 =?utf-8?B?cU0xa1ZhUzR3eXYzRzJvRldqRE4xM0MxcGJGQS9HbVQ1cTYvaHprU1I5bWV3?=
 =?utf-8?B?R1c5TXBLMXo1SHc5UzJ5YjVpSXFPV1ByaS9ZenpnbVNNbmdTeXFlblVBdEJH?=
 =?utf-8?B?c0IzNWJmUzJ1bTF3eThRemx1Z2REeStmTFNiU2RaMU05b0pHd1VFZFdFRUJu?=
 =?utf-8?B?Q29yREpxMGx5SGVpNTl2ZHUvMzJWZjRCS2pPM1IxaGMyMlNWR2RiWGFQVS9N?=
 =?utf-8?B?RmhhM3h4SFUvZUwvSFJadHdrNEttQU9mNFUvdlNHbC92clI2Smptc3MxL2dL?=
 =?utf-8?B?SkZvNDNkM3ZON1BvV1lPN0dSejZNTzcybUZLeXZLeDJ3RFNBR2FaaUVZQnZh?=
 =?utf-8?B?R2VxcGRBWFdWZmhnU2Nqc1g5d01hUUliWE9jNG81Z1JacUhoeTFzdWFUQVhM?=
 =?utf-8?B?c24zem9ZMHJnN3Y3cW9TUmRSVEJ2QkREaUNCVFpSeW9jRGdnQ3J6ZnhmL3Qy?=
 =?utf-8?B?NUpHakFLMGJuMnNic0h5djhmL3F3eHhuSHZ3aTkyci84RmRESlB0empCVXZr?=
 =?utf-8?B?Yy9ySzZLUXdueDlxSUpWcmN6MlFhWi9IR2kxRVJvZmg2MVZZc3JER0g5d1Vh?=
 =?utf-8?B?KzZHbEpZZmw2V3h0clBrN3dONnVOdVFrWC9pTGZQV2FmSzd3aEFvcDZVRk1y?=
 =?utf-8?B?bCtRZDZ5ZUJNeDdXMWs3cnN4bWgzTXMwakljVHhRU2FrdW0xTU14eTVYQ0Jl?=
 =?utf-8?B?RTc5aVJzd0Z4VmdHYWhIdVZxa05lMjV6TmdZN3VIZzk3QjFiMnZxNk9La0Vs?=
 =?utf-8?B?VjM5NHlmcVE2eWVCRjZxVG1JREUvYlAvU0ZCVllPc29FM01RNWVsaDMxY080?=
 =?utf-8?B?RGV6VjU3eVZkWlgxdFMxOSt1TTN3Zk85N3greFZVTElZNmhDNU93dTJnbmVK?=
 =?utf-8?B?K3pTamN6VFUrWDlTUTVsRmc5NHNuSWZtU2thak5Wa3ljcHozQi95Nlk3dXBp?=
 =?utf-8?B?bFRJTmZESjgyTVVVVUQ2UjVicFNucmJhKytoVFJham5LZGxiTXM3TFNKU0Jh?=
 =?utf-8?B?N2JOUTJ6TVpDV0RIWEEwVzBIVm1LMERRWVhjaTE2UVhjbHh1d0QwN1gwTUs1?=
 =?utf-8?B?UW1qdHhrTXUyWm1nanhpTm5mMlhndkpPM1hPRGtlOG5wNStjaWI5QURKOHV4?=
 =?utf-8?B?THloQXFvNTJXUGN6YnBsNHFwUFRpV00yOHFPN2VndkFWWlIzSm0vWlB2Z3Rl?=
 =?utf-8?B?dGNmSnV1QktxV3NDSGNnUFovWFZISHBLSENFMVdHT3pEc1pWTlRGRmZ3YXF4?=
 =?utf-8?B?b0tXTUE1QWZvT2JiM3gyRERYK2RTTG1Zb1diNUdFWFdnemdqaUhVQ3VMVkZD?=
 =?utf-8?B?dmloZ3FDRkVKdnhPL09VQXJGMmI3RjZuVmRQMEkrQktTZUwzNUJyQkRURU5t?=
 =?utf-8?B?aStrcmtXZ3RVYzZra3VWd05VUkJjdXU2OHpFbjZQcmFTSUIvTGhMVnhLMDJi?=
 =?utf-8?B?Y2lmb2QxTEhpdWtaejNvUU9oSnJmL1RqTVFkZmFYZDJNK0VxWGNiWjYycFlD?=
 =?utf-8?B?Q3c2SHA1a1M4Y3ZWQ1ZUaGRKWldMVU53QlhRNGZnSlBPQmU0TjFjZ1pxWllx?=
 =?utf-8?B?ZUUyb1g4SCt2a0RQeC9FR0Fub2daM3dldXI3TS9GYjdOK3dZcXFFN2t4cjBl?=
 =?utf-8?B?NXpmaHBZNHpvUmcxQytjN0RVZkZKRmErN2hlMDkwWDRKdXJNVEtVekorY2s4?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9980A90E6A65024E93A598FCA6DC467C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UyVyMLl5VE6uZKL+kYfupsFUhYwza9xVgpg23mbrELBSyF4JYbLJFUYNqR+cQlSNsZTct+CjgGAS/FKV+y2/xBHvRQwmuGNLQ/TQAY2Z9kXprgDQwZwyIt2AHXoKssujtmDSm4K5b42qmfxgFnetteSViC55qquBHumAwxmngOhIY1MCsQryLUWah8b2e/Ur7Yz5QjEMmaomxeRfoyrqDZaR9TU68ko6S9rpwLr5RtEu8rWW3nx47Ch2wJ2Up9tLsfIzxC3P1D1Z+sjKFq6mq3i8upzUnOu5/yr7jaKi7aKBg4yc+qHIy2McAwYEyBYSH1m7hnSdYsDIqsC7d4WZdL5Tn1gv/XnRGJJWrgAa9g73jI7dc19Zk6SgAW68BvHOxDyZ0nivGA3+dDP8fskazUd/Gun6WhNOxQqdyD7OqOl2GMlawMtaz/7eJ+6ai5udm2IeJhz+NhnHUIB+VDR9vcC18DIMpBXKnEM8IoPr6QHa4Xq6mjY81H9pDwuFi9YJErtqzS2e2X+vw1Hc7n6kzAW/3RVq+vCO/zKso2bsWLqw2q5t6zaXQuI6SvSUe6pDc7m/EA53sF1IrxQ/JmJU90vRUvjwOw+jfww6dpBWuKI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079ccc0d-1954-417b-930e-08dc1e1926f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 02:47:35.5756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3LatsuN3r54OyStZJ1U+atockoLdSm43zSAblvIeKNthuhMZs7D9Qgy989hOwl3aF8XY+JntGVEb9Dw14bv0ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260019
X-Proofpoint-GUID: L19-YrPY01HqD4-2aMGLTuR9PU5fkKm9
X-Proofpoint-ORIG-GUID: L19-YrPY01HqD4-2aMGLTuR9PU5fkKm9

DQoNCj4gT24gSmFuIDI1LCAyMDI0LCBhdCA4OjA14oCvUE0sIERhbiBTaGVsdG9uIDxkYW4uZi5z
aGVsdG9uQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIDI1IEphbiAyMDI0IGF0IDIy
OjExLCBCZW5qYW1pbiBDb2RkaW5ndG9uIDxiY29kZGluZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4+
IA0KPj4gT24gMjUgSmFuIDIwMjQsIGF0IDE1OjM3LCBKZWZmIExheXRvbiB3cm90ZToNCj4+IA0K
Pj4+IE9uIFRodSwgMjAyNC0wMS0yNSBhdCAwMzoyMSArMDEwMCwgRGFuIFNoZWx0b24gd3JvdGU6
DQo+Pj4+IEhlbGxvIQ0KPj4+PiANCj4+Pj4gSXMgaXQgcG9zc2libGUgZm9yIGEgTkZTdjQgY2xp
ZW50IHRvIGltcGxlbWVudCBUTFMgc3VwcG9ydCB2aWENCj4+Pj4gL3Vzci9iaW4vb3BlbnNzbCBz
X2NsaWVudD8NCj4+Pj4gDQo+Pj4+IC91c3IvYmluL29wZW5zc2wgc19jbGllbnQgd291bGQgZG8g
dGhlIGNvbm5lY3Rpb24sIGFuZCBhIG5vcm1hbA0KPj4+PiBsaWJ0aXJwYyBjbGllbnQgd291bGQg
Y29ubmVjdCB0byB0aGUgb3RoZXIgc2lkZSBvZiBzX2NsaWVudC4NCj4+Pj4gDQo+Pj4+IERvZXMg
dGhhdCB3b3JrPw0KPj4+PiANCj4+Pj4gRGFuDQo+Pj4gDQo+Pj4gRG91YnRmdWwuIFJQQyBvdmVy
IFRMUyByZXF1aXJlcyBzb21lIGNsZWFydGV4dCBzZXR1cCBiZWZvcmUgVExTIGlzDQo+Pj4gbmVn
b3RpYXRlZC4gQXQgb25lIHRpbWUgQmVuIENvZGRpbmd0b24gaGFkIGEgcHJveHkgYmFzZWQgb24g
bmdpbnggdGhhdA0KPj4+IGNvdWxkIGhhbmRsZSB0aGUgVExTIG5lZ290aWF0aW9uLCBidXQgSSB0
aGluayB0aGF0IG1pZ2h0IGhhdmUgYmVlbiBiYXNlZA0KPj4+IG9uIGFuIGVhcmxpZXIgZHJhZnQg
b2YgdGhlIHNwZWMuIEl0IHdvdWxkIHByb2JhYmx5IG5lZWQgc29tZSB3b3JrIHRvIGJlDQo+Pj4g
YnJvdWdodCB1cCB0byB0aGUgc3RhdGUgb2YgdGhlIFJGQy4NCj4+IA0KPj4gWWVhaCwgaXRzJyBh
IGxpdHRsZSBiaXQgcm90dGVkLiAgV2Fzbid0IHN1cGVyIGZyZXNoIHRvIGJlZ2luIHdpdGgsIGJ1
dCBpdA0KPj4gZGlkIGhlbHAgYm9vdHN0cmFwIHNvbWUgaW1wbGVtZW50YXRpb24uDQo+PiANCj4+
IFlvdSBjb3VsZCBhbHNvIG1vZGlmeSBvcGVuc3NsIHRvIGJlIGF3YXJlIG9mIHRoZSBjbGVhciB0
ZXh0LCBzb21ldGhpbmcgbGlrZToNCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9iY29kZGluZy9vcGVu
c3NsL2NvbW1pdC85YmYyYzRkNjZlYWNjY2QzNTMwZmIyZjNhMGE2Yzg3ZDU4NzgzNDhjDQo+PiAN
Cj4+IC4uIGJ1dCBJIHRoaW5rIHlvdSdyZSBkZWZpbml0ZWx5IGluICJ3aGF0IGFyZSB5b3UgcmVh
bGx5IHRyeWluZyB0byBkbz8iIHRlcnJpdG9yeS4NCj4gDQo+IEZvciBleGFtcGxlIGxlZ2FjeSBO
RlN2NCBjbGllbnQgYWRkLW9uPyBZb3UgY2Fubm90IGV4cGVjdCB0aGF0DQo+IGV2ZXJ5b25lIGNh
biBvciB3aWxsIHVwZGF0ZSB0byB0aGUgbGF0ZXN0IGFuZCBncmVhdGVzdCB2ZXJzaW9uLCBzbw0K
PiBlaXRoZXIgeW91IGhhdmUgY2xpZW50cyB3aXRob3V0IFRMUywgd2hpY2ggaXMgYSBzZWN1cml0
eSByaXNrLCBvciBoYXZlDQo+IGEgd2F5IHRvIHJldHJvZml0IHRoZW0uDQoNClRoZSB3YXkgdGhh
dCByZXRyb2ZpdCBpcyBkb25lIHRvZGF5IGlzIHdpdGggYW4gc3NoIHR1bm5lbC4NClRoaXMgaXMg
YSBkZXNjcmlwdGlvbiBvZiBzdWNoIGEgbWVjaGFuaXNtOg0KDQpodHRwczovL3d3dy5saW51eGpv
dXJuYWwuY29tL2NvbnRlbnQvZW5jcnlwdGluZy1uZnN2NC1zdHVubmVsLXRscw0KDQpNYW55IGNs
b3VkIHByb3ZpZGVycyBpbnN0YWxsIHRvb2xpbmcgb24gdGhlaXIgY2xpZW50IGltYWdlcw0KdG8g
YnVpbGQgdGhhdCB0dW5uZWwgYW5kIHJlZGlyZWN0IE5GUyB0cmFmZmljIGxvY2FsbHkgaW50bw0K
dGhlIHR1bm5lbC4gSXQncyBnZW5lcmFsbHkgdHJhbnNwYXJlbnQgdG8gdGhlIGNsaWVudCdzIHVz
ZXJzLA0KZXhjZXB0IGZvciBpdHMgcGVyZm9ybWFuY2UgaW1wYWN0Lg0KDQooY2YuIEFtYXpvbiBF
RlMpDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

