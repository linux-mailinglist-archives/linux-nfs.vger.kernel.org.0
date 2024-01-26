Return-Path: <linux-nfs+bounces-1463-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5597983DB5E
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 14:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E30929422F
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 13:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DAE1B7F2;
	Fri, 26 Jan 2024 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TyW1rWFh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YCPpoiaf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654091BDFF;
	Fri, 26 Jan 2024 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277519; cv=fail; b=H2QEsb3+6iaRijmJLbOYIo2P3CtOjsGErroewCdwYGXWYm678kVEsoz3mfbnIWdx25CGSJSIiYoqqDMgnNijnzLC558ogbxhPDGGGJl4IDo9clICE8nOZrLIJRwatXHOhCtp3daVJOTF7Yqci4zy0HZZ7tfMeRxRM6tQRU8eVTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277519; c=relaxed/simple;
	bh=r/VcfnD6P5eOmPsC+1NpL0fFpyYXKhmEVyLCK78Xh3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uFxXnhhHeIlbUl2hp+aj32nTETQ2vcQjd43cAB2o+M/b5foFG5xaRK+61sPiC2Hwc3vnJievQH5KdvLpw22+4o1hwwUZw8luZt1+m83aedQG+SbGo6JEdzJwpnR8tKiQ1kPio1zgGTKUMxHGMa33AV+9QcwhXNy+Fb9Yl1fJhMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TyW1rWFh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YCPpoiaf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QD5gfK029444;
	Fri, 26 Jan 2024 13:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=r/VcfnD6P5eOmPsC+1NpL0fFpyYXKhmEVyLCK78Xh3U=;
 b=TyW1rWFh206gjc4BhyKAVUnwKhehON2Tr/P7z4T8kLWOSquvLr3h0MfQlJ46P5Y1LJs+
 ZkudxrcN/wMBhOVjpXL41/XY3xNlobl7AhCcKR1SjMp0Xha422Fzz93FbD8qsfyxzh9r
 e24Jw2mPwOQYIuBfECOAr1rPs+OhlLanrJAKFbPo1NE+zvvEZlxaWeGmRn1h5lT3vyiq
 /c0xWTQ+0skoLl2y5y/4q5UWcEQw8DyQ3o/quzmRfo/pS3VUQqUgsXsj8Jv6Mli+0+yP
 uN6UJoV2j6M5y/nuf4lTsFb77OW8lLrGtTcXlUpswrYDOzPIx1zhCzvMOrX3vsI0l+LV 9A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79ntca2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 13:58:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40QBY2TW011769;
	Fri, 26 Jan 2024 13:58:26 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs327ds62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 13:58:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSm/6ChrSELwJVF9HO0ZOVilNNVs75N9FfHvL/1VpoTDloi3c6BEY7Rxg56N93GhIynbgmPbLOnu9pTlhUFbB+OGov3V/+xUhJo7rSu0FkhQbhsBHt7WIQt3K/j1bBomozqfhsZq98r1vxhsMNfqDA63F3zY5eS7EI59r7aDR1eZVTY21I8CZe8hJUeZSn41irdqDSIvgqx18HI2VLno3b9JogbXxnMXSaHJJELbvC6+iSGhwWefkXhmfTjuS7GtQvdIN/h0zTdJluXOqgQxfqR9RM0FoGHl6WiYLuv+Ce5AMMaRav8qOKjq704jyWLkALas+AS2e8iciot+towNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/VcfnD6P5eOmPsC+1NpL0fFpyYXKhmEVyLCK78Xh3U=;
 b=k/fFVECMF1nVHvXheXwa0KObzM+iGTTdR99SfHGkDsyRXsZdl3X98GtaZEQFL7E2D8soGcs0IP/KkiQe0B2/beKW8Zcg7bjKOe9p/+0eKM3efsfNIIDZbm+yvV6a/2HTNHxb+UScZoCYRKaYij4EiryFKHYDEFnqiS7efOOYMVE13KGV/bLrEeplOvLlkETYmSFTcCL6C4J+5wt50Ktz1anCg21GglGeCIwWjQnSavq974bIs92C0AkV7EV/mTXQ2asdpEPmGPPZcbCzUaIIonIK48FkNvkQ5X1oyrB/6PV7FMfZKQWdpo7e+JRK9cVktNMzhRCsbYbDSiKZef+y0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/VcfnD6P5eOmPsC+1NpL0fFpyYXKhmEVyLCK78Xh3U=;
 b=YCPpoiafNKQTvpz7EfsyFkKA9+VylBmrcTenqwtcjwRjfy+OZJXvdSkXtlur2n0Q+gKFvtnlYg//XRPqM8etTXgACvtMhHzRQ/5JJ+p+/PPsSFUkffVFgkz6ywzVlsfc5K6WZ5ECiWGtckq5yiAVil0w5fw11vhBGpGyUugtfwU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7668.namprd10.prod.outlook.com (2603:10b6:208:492::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 13:58:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%6]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 13:58:24 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Lorenzo Bianconi
	<lorenzo.bianconi@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Simon Horman
	<horms@kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] NFSD: add write_ports to netlink command
Thread-Topic: [PATCH v6 3/3] NFSD: add write_ports to netlink command
Thread-Index: 
 AQHaS8bpZ9RzO76t8E+mXe8FqSN12LDl2fGAgACEPYCAABdWAIAAuIYAgAAV2ICAACKWgIAAEuAAgAFFH4CAABm8AIAAKhqAgAImIICAAP9uAA==
Date: Fri, 26 Jan 2024 13:58:24 +0000
Message-ID: <B85C6ED2-E2F6-4224-883A-E7DAB54EFF09@oracle.com>
References: <cover.1705771400.git.lorenzo@kernel.org>
 <f7c42dae2b232b3b06e54ceb3f00725893973e02.1705771400.git.lorenzo@kernel.org>
 <9e3ae337dcf168c60c4cfd51aa0b2fc7b24bcbfb.camel@kernel.org>
 <170595930799.23031.17998490973211605470@noble.neil.brown.name>
 <Za7zHvPJdei/vWm4@tissot.1015granger.net> <Za-N6BxOMXTGyxmW@lore-desk>
 <85b02061798a1b750a87b0302681b86651d0c7a3.camel@kernel.org>
 <Za-9P0NjlIsc1PcE@lore-desk>
 <3f035d3bc494ec03b83ae237e407c42f2ddc4c53.camel@kernel.org>
 <ZbDdzwvP6-O2zosC@lore-desk>
 <8fabd83caa0d44369853a4040a89c069f9b0f935.camel@kernel.org>
 <917EC07C-C9D9-4CF2-9ACB-DCA2676DFF67@oracle.com>
 <170622264103.21664.16941742935452333478@noble.neil.brown.name>
In-Reply-To: <170622264103.21664.16941742935452333478@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB7668:EE_
x-ms-office365-filtering-correlation-id: 11dc7a12-4f0b-468b-55a0-08dc1e76dd56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 PWaoC2rWmiiyGJm1sGB/70pT2LNWM51uJTyzqwMOOJYWSc4bHmezClgs+AfOUMijqSg5pXvqDCeY0Pp7KEv3RF/gAf8s0bJYZWGQZIZkqbIU6LldAnJB6N1AtmdYZBtUd0uo65MMaBY/lfFlYvRuCcKhjXzn14RE8cvsNbC5Du9sWrjJMbgYPXQ+XUIMAzGGcaABuhQZfYYTxOR+X6C7+U0rfUmlond2u+TZKxk1CqXj+WTpDmDLAEPUsXjgFkz+vgbuQtINxfekAE6pcfEw9Y56rmeBQDkeE7aFkryfIno5atqNPuK+l6ibxibg/lDtkJ4XP0iYKaszShADgUHY9fk8ZqGmkdMrCOHZmCIE91zTRY2HZCuAl5GCaW2plOfhaEo0KGVU9BboLSFdM92AG4ge2ebnVlXiC4xvsJyVT14f2YhkSe0WgL45xBztZqYHiCfXRlPO5+N+bhfcsRvmGuD6hdcUQc6Gp2yTOvzDIGYbiWZWFgu8r+vVTA8Jic5hojbToA9l22tq/DPc25dLc+YRtlTGiyI7Z/23mTL1yegnS6/tRLRAZD4XRa7b+UF/Tfc8eqNQJhhcCHcZVsYvhZiY2Ti6d4AHuqQ50rLt1PbThblxpN2rEColeLA9fmkOZZmzET0Om+zfAKoP9wh1Tw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(66899024)(83380400001)(41300700001)(33656002)(36756003)(86362001)(38070700009)(38100700002)(6486002)(53546011)(122000001)(6506007)(26005)(6512007)(2616005)(6916009)(91956017)(5660300002)(66446008)(54906003)(71200400001)(66946007)(478600001)(64756008)(66556008)(66476007)(2906002)(76116006)(4326008)(8676002)(316002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SVBOekdoQ2FkeEU1aVFhaUx6ZzZxSjRJbU9wQjBMVXR3ZG9vc29kVGR2NHkv?=
 =?utf-8?B?ekR6TmJOSGpreTJ4TmNuZkZNQjZKL3Jpbis4SWd1V0lNV0JlZTZNTmo0Vy94?=
 =?utf-8?B?cnorUWlGYXR6TTIySnoxTElrZjNHc3M4RU5Ld0VWZHpDTGpTQVNER3M2MEVv?=
 =?utf-8?B?OWhOSGtOS0x4cUxHRmRHZEQ5bHJ0WXNweEs2YlFNQWZnUm5Kd3FCUXA2VE5U?=
 =?utf-8?B?RCtadDZENnpoT1JZY1F4VkN5UUVvbVBCZHF6eXVuSE4zRFZHaUk3QS9IcjZr?=
 =?utf-8?B?R2VxMUhrcUtMWnJuaEFWdFhadDBiOGdhUythcks3QUk0ei84RGVMdmlwTkdR?=
 =?utf-8?B?MjRRMkl1Z1BzZ2hBZWNMOFppYWFXOUlBbXFhNGlSb05hZXdGTGVaVm9WVDU2?=
 =?utf-8?B?Q2ZocThDU3JQaVNObmhOazlCZVVLUVMzYUsyUjljRUdDZjdzNVh1Q1JCcG9N?=
 =?utf-8?B?dVRIVEs2Qk4vUmV1MlBRYXd6VmQzalNycmMzd0hIekpxa2dzZGJiZmEyOXlH?=
 =?utf-8?B?WUJVZW9iKzVuL1RXeHpzbjl4TTJZSUZ1Y3FNNG5HeUxPenBOTDcyK3hXd3pJ?=
 =?utf-8?B?T3RrNS9FcXZyY29xUUJtd0wvS2FYMUFxRTZjUk83L3Nnc2Q3TU1pRDNQOVRO?=
 =?utf-8?B?dUV2UllqbVVpdk9GUGJ6aC9zVE9KOE1GRDByMndmeWQwdkdmU0w1YWxuY2Nr?=
 =?utf-8?B?b0JWQzcraHpsaW9scmY1T2phb0pUeUdYWWhPVGhFYlpOTmFYZ0hIaCtrMzVx?=
 =?utf-8?B?K0ptcjBXMEFaTnVNdnBRWXBaa0NSUFhBNG1kSmt4UW1yNDZ2ek9tVHNJMFdB?=
 =?utf-8?B?WElvSUk0SEFSU2ZuR2xSNmNCYVIrL1BZSlEvbDloSVBKdk1tcjF2b3hHS0R5?=
 =?utf-8?B?THl3WGRiYm82elFGV2gxNnZWTWV0L2hEWDR1WjNzcVZmYnVuS2RNalRHUCtS?=
 =?utf-8?B?MTdzdUNrS3c5OCtXMlRSdFVsYmRudUd5M08xWm5neHI3YjhUSHZPNTdMOXdV?=
 =?utf-8?B?Tzl2Y0JHR05tNjNWR0VoVjk5ejVLK3F2ekNaOUdwQUZzRU42aFg2MFlUTTBu?=
 =?utf-8?B?bUlzdnRjcUxUby9JOTI5c0UzVWJBODlnRCtaeWdHK1JBdlJJSzdHeGFHVVZY?=
 =?utf-8?B?VTBGWlVTOHgvZHpRaEFqYkFMbnBaWlkvaENMcTNyMzNmS0lhZHkydEREcFBW?=
 =?utf-8?B?NVc5ckloWWRWN1pMcnBEUVVGUDJMWVhEOWNOVmc4VSt3OEpxa29wSE5wLzB5?=
 =?utf-8?B?MnQ3cDRZcWV2KzZUZmk1Zm9NcS9Rek1mM0crM04rY2FTQ1NtK3pzNzRjZmFa?=
 =?utf-8?B?VTR0b3NqTGlEcVh4MVlWMXE5eHl4VzNtVkR4OWwwUTQ2eVJHK2VObS9UU3Bv?=
 =?utf-8?B?cENsMmhub3FWdlBuZTRydzFtQ2d1aU05QXREdkZrQS8yai9JZ0ZvSlR1V09n?=
 =?utf-8?B?WG94SjRPd1FJK3RGdGNkQXN4dXdEVnNBN2pMdmVWTmF5SmZCc3M0am5oTHdh?=
 =?utf-8?B?MGt1YTRlM3lOVUJrSy9UTXgycTBNNE5FczJKYW1pTkF6emZTVVlycTNGUnFZ?=
 =?utf-8?B?VFRtMFdkeXdRTFFCd1ljQ09EMWg3QVBRYVRESzZ4VVNuSnlVSDg2dFd5T1pU?=
 =?utf-8?B?WkFYOUEwSUJBL0dXcVc4T2krdGJEejB1N0NwZFhLcEJYUVVGSU14aEtJVk1J?=
 =?utf-8?B?bjZDSU1tekl0T011V1hQb2s2UUNhTkxYTHYzTFE3QldQNFg2dlBqOUwwaGs3?=
 =?utf-8?B?My8wK3NEaHNNb083NVhNMG9RdmZ0WStpTzVwSUhrY3BuaU9aMmU4SXJ4NU9i?=
 =?utf-8?B?NVZsVXZoOEZxbHJDZWVVTVdFcnRmR2hZUUw5cEZYVlczdndtNU1DNWxMUVht?=
 =?utf-8?B?emlNVm0rTlliOXdJa0hpWDFnakxYa3piSnR6cjFHZDZiYmNKVEF6a1Fna3R2?=
 =?utf-8?B?QWNqRjk2bkd1cXh3MGVGMnpieW5vOW4rRDJSanpTWm5DajRuMUZwSVlvNmlJ?=
 =?utf-8?B?V045STFYWHVXQ2J4bkpIV2lSYWI3K3BKNTJNWHdNMktwNGIxNXJ3TUd4YW5k?=
 =?utf-8?B?SStDRjVJU3k1QWkzNTAyOHpVV1d5Y29nL24yb3R6NGJVVHI2WVhrNVRralZk?=
 =?utf-8?B?OXdyTkxVZUl3dk1EQkdrN05Zb1FRREd3L0N1OW03c29JY0NEVVJBSjJpMmN3?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06D0A05B34E8A846A99756CFA6D39120@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VVtEqSmDNQQEtNsa9lbU1GsaeSnpnLPkZ3IpujcCAiiV12Tim76ikZh3Uhx2zXuQsZoN0J4u81SKZ23qZ5oLS3miUSFMvK2edHtZ2WTNZgSyUgEVa+cCG5C/ehsY96LHZNLxPIEM/IsuwJkSAI2f7tfhX36DzmGmZ3LbCXy/NUd1nR+63m22Ycf3Ci1oRPBVR1NjKzVb2Z087Rs7bN41LLg71n4dKudR5t7WaN/bsRkX1GgJ2oKItJSqSHdSLDpjuDoimITRMhFWbbuNxUfL/2tB/NpJL0GTSh6w+kSTROQoefp6ff1p/ZZLN2xvYLW+4AL7Vt2xIH4I2WaC7WokxlwJwHRUxWZYvf1/XlYr7pycC3F+VG/GI1TQArGAayc7SVw7qHN0ynyZKEoGAqii4izcEu8AbLNc5Bb9M8aaTHknZNCN99Q0NeknOZwzchKgiDaPCMmSxBXc9zbixFBFYJomEjgBVMu2JWbTErrO/uP1EcrAaH2LTZ0Kf8FeffcUk+s5D9Z1KIbdl7nw43DMWpF7vW6Jx0Y/yOJySWX2XmFmjGcrXqHP4h8oQ4GIgvshjh2Heg+vZljTBMfB0Kxm4irbGB4LRzOzCJ82R9n5EGk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dc7a12-4f0b-468b-55a0-08dc1e76dd56
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 13:58:24.7859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzTzXuDASmN1tf/KdIMtiWRTDQN33jIc0L5tMNuva6PjdFkIPkjEnELDU1mrYD24cAfDdaF67BSW09T/ZrwNMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=637 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260102
X-Proofpoint-GUID: YYT7tNc98wdKEuZmPqdAH89SSrarjRlY
X-Proofpoint-ORIG-GUID: YYT7tNc98wdKEuZmPqdAH89SSrarjRlY

DQoNCj4gT24gSmFuIDI1LCAyMDI0LCBhdCA1OjQ04oCvUE0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIDI1IEphbiAyMDI0LCBDaHVjayBMZXZlciBJSUkg
d3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEphbiAyNCwgMjAyNCwgYXQgNjoyNOKAr0FNLCBKZWZm
IExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4+PiANCj4+PiBPbiBXZWQsIDIw
MjQtMDEtMjQgYXQgMTA6NTIgKzAxMDAsIExvcmVuem8gQmlhbmNvbmkgd3JvdGU6DQo+Pj4+IFsu
Li5dDQo+Pj4+PiANCj4+Pj4+IFRoYXQncyBhIGdyZWF0IHF1ZXN0aW9uLiBXZSBkbyBuZWVkIHRv
IHByb3Blcmx5IHN1cHBvcnQgdGhlIC1IIG9wdGlvbiB0bw0KPj4+Pj4gcnBjLm5mc2QuIFdoYXQg
d2UgZG8gdG9kYXkgaXMgbG9vayB1cCB0aGUgaG9zdG5hbWUgb3IgYWRkcmVzcyB1c2luZw0KPj4+
Pj4gZ2V0YWRkcmluZm8sIGFuZCB0aGVuIG9wZW4gYSBsaXN0ZW5pbmcgc29ja2V0IGZvciB0aGF0
IGFkZHJlc3MgYW5kIHRoZW4NCj4+Pj4+IHBhc3MgdGhhdCBmZCBkb3duIHRvIHRoZSBrZXJuZWws
IHdoaWNoIEkgdGhpbmsgdGhlbiB0YWtlcyB0aGUgc29ja2V0IGFuZA0KPj4+Pj4gc3RpY2tzIGl0
IG9uIHN2X3Blcm1zb2Nrcy4NCj4+Pj4+IA0KPj4+Pj4gQWxsIG9mIHRoYXQgc2VlbXMgYSBiaXQg
a2x1bmt5LiBJZGVhbGx5LCBJJ2Qgc2F5IHRoZSBiZXN0IHRoaW5nIHdvdWxkIGJlDQo+Pj4+PiB0
byBhbGxvdyB1c2VybGFuZCB0byBwYXNzIHRoZSBzb2NrYWRkciB3ZSBsb29rIHVwIGRpcmVjdGx5
IHZpYSBuZXRsaW5rLA0KPj4+Pj4gYW5kIHRoZW4gbGV0IHRoZSBrZXJuZWwgb3BlbiB0aGUgc29j
a2V0LiBUaGF0IHdpbGwgcHJvYmFibHkgbWVhbg0KPj4+Pj4gcmVmYWN0b3Jpbmcgc29tZSBvZiB0
aGUgc3ZjX3hwcnRfY3JlYXRlIG1hY2hpbmVyeSB0byB0YWtlIGEgc29ja2FkZHIsDQo+Pj4+PiBi
dXQgSSBkb24ndCB0aGluayBpdCBsb29rcyB0b28gaGFyZCB0byBkby4NCj4+Pj4gDQo+Pj4+IERv
IHdlIGFscmVhZHkgaGF2ZSBhIHNwZWNpZmljIHVzZSBjYXNlIGZvciBpdD8gSSB0aGluayB3ZSBj
YW4gZXZlbiBhZGQgaXQNCj4+Pj4gbGF0ZXIgd2hlbiB3ZSBoYXZlIGEgZGVmaW5lZCB1c2UgY2Fz
ZSBmb3IgaXQgb24gdG9wIG9mIHRoZSBjdXJyZW50IHNlcmllcy4NCj4+Pj4gDQo+Pj4gDQo+Pj4g
WWVzOg0KPj4+IA0KPj4+IHJwYy5uZnNkIC1IIG1ha2VzIG5mc2QgbGlzdGVuIG9uIGEgcGFydGlj
dWxhciBhZGRyZXNzIGFuZCBwb3J0LiBCeQ0KPj4+IHBhc3NpbmcgZG93biB0aGUgc29ja2FkZHIg
aW5zdGVhZCBvZiBhbiBhbHJlYWR5LW9wZW5lZCBzb2NrZXQNCj4+PiBkZXNjcmlwdG9yLCB3ZSBj
YW4gYWNoaWV2ZSB0aGUgZ29hbCB3aXRob3V0IGhhdmluZyB0byBvcGVuIHNvY2tldHMgaW4NCj4+
PiB1c2VybGFuZC4NCj4+IA0KPj4gVGVhcmluZyBkb3duIGEgbGlzdGVuZXIgdGhhdCB3YXMgY3Jl
YXRlZCB0aGF0IHdheSB3b3VsZCBiZSBhDQo+PiB1c2UgY2FzZSBmb3I6DQo+IA0KPiBPbmx5IGlm
IGl0IHdhcyBhY3R1YWxseSB1c2VmdWwuDQo+IEhhdmUgeW91ICpldmVyKiB3YW50ZWQgdG8gZG8g
dGhhdD8gIE9yIGhlYXJkIGZyb20gYW55b25lIGVsc2Ugd2hvIGRpZD8NCg0KQW5vdGhlciBwb3Nz
aWJpbGl0eSBpcyByZW1vdmluZyBhIGxpc3RlbmVyIHdoZW4gdW5wbHVnZ2luZyBhDQpuZXR3b3Jr
IGRldmljZS4gVGhhdCBhbHNvIG1pZ2h0IGJlIGF1dG9tYXRpYyBhbHJlYWR5Lg0KDQpCdXQgaGV5
LCB3ZSBkb24ndCBoYXZlIHRoaXMga2luZCBvZiBhZG1pbmlzdHJhdGl2ZSBjYXBhYmlsaXR5DQp0
b2RheSwgc28gdGhlcmUncyBubyBuZWVkIHRvIGFkZCBpdCBpbiBhIGZpcnN0IHBhc3Mgb2YgdGhp
cw0KbmV3IGludGVyZmFjZSBlaXRoZXIuIEknbSBoYXBweSB0byB3YWl0IGFuZCBzZWUuDQoNCg0K
Pj4+IERvIHdlIGV2ZXIgd2FudC9uZWVkIHRvIHJlbW92ZSBsaXN0ZW5pbmcgc29ja2V0cz8NCj4+
PiBOb3JtYWwgcHJhY3RpY2Ugd2hlbiBtYWtpbmcgYW55IGNoYW5nZXMgaXMgdG8gc3RvcCBhbmQg
cmVzdGFydCB3aGVyZQ0KPj4+ICJzdG9wIiByZW1vdmVzIGFsbCBzb2NrZXRzLCB1bmV4cG9ydHMg
YWxsIGZpbGVzeXN0ZW1zLCBkaXNhYmxlcyBhbGwNCj4+PiB2ZXJzaW9ucy4NCg0KDQotLQ0KQ2h1
Y2sgTGV2ZXINCg0KDQo=

