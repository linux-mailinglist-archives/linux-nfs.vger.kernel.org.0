Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7938070CB66
	for <lists+linux-nfs@lfdr.de>; Mon, 22 May 2023 22:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbjEVUmZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 May 2023 16:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbjEVUmY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 May 2023 16:42:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60338B7
        for <linux-nfs@vger.kernel.org>; Mon, 22 May 2023 13:42:06 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKOOHJ021249;
        Mon, 22 May 2023 20:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=hp9Ha/HL9EX7M5AuqbFHgUns4fn/OPfl/HVR2GO08wI=;
 b=MDB987zuIZAMf6Z9x8WHPPuDWircLUANRvQ+FDYajW42ajKbHwN4PjNxXR9rAIKQdZBf
 pHN1Xey3HxnN8avNCLzafN+DoDikx6He8Xto8rb0lwR5ajzrgmraZ04YsSWGW4YEV8dB
 ct6y9mUKmOsTbrQygPMse4SndLVtEv1sk/4T3G0LcjLf6ea7GpD2dZLOrp0v/72vaJN3
 +x1wYgP5p2+NfdGeB0BnkWU0ruZWxjqv3oo4Ggquba9HrZzssLSxLO5TkF1W3COatTRN
 ncB3AvmLL2jIcBaTbmeKImzzKD2MZnxx1XXshYg1YAy3zOqlUx6rVc/aELzpiEdzN4r6 Pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp5bknw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 20:41:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MJjkdG012972;
        Mon, 22 May 2023 20:41:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7dy3g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 20:41:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pv6xv9JQhSau+Y0/lBNNHcGlPt4qq/lDJA8qV7aX0dFm/18QN8sRjiaHjACtrKeocEZ6unNU099qN/TQDVh1bHs1pNbHNAVu2GaA+evVzW611GGtPSXHbQZoJwTH40QZk+Xr0uhkUzC+NodMqR+z5v8/1Qey8HLymjeVR3tqVVgPz6jZtZkN9XLlleFnyOUGKItyJWuWwRHFFL2gsyHMQNM9AQYgNRtl55M6JqrKavdL5KNqzOe9H8CMhdqEWudnOBqG2rpuVkvfuQBJpjJLjVUXimuKzBKFm8c62pWfdRIB8duTZMRuObG96aABVVtqCCBvcnaQw2PD0wQae9Y09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hp9Ha/HL9EX7M5AuqbFHgUns4fn/OPfl/HVR2GO08wI=;
 b=AbyvWjBCox7MvF2vwvXRZiZOgD1nX6CZwTLi4TwIOWwLcZ9UzEAp9nl4wsKkT7qEVkOotyEmxiJueBGVhWu/4dAratbb7zMyNb9w781Rv5nBo8yEQftxcT6ySOTIYSEavf2YJLYtZxnZoG9fVkQff+o/g2kdrcNwSGliGFxhiQr6ISHktSOLkQ743Qjp3pnt8dmymsOIgVCURU4ynuhUX0G6kgq5Ro0susbX+ZfjwICnMdpDkMdIy8qsw+WKDW20/GGNY4eYSIrpBUsB9IfKdenOEys7KqHCtxvG7/2bvkO2G2kzzE+3ktnXCrESfbImyJ7xJhl9IF4iVkbl8mXfpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp9Ha/HL9EX7M5AuqbFHgUns4fn/OPfl/HVR2GO08wI=;
 b=htB8PnEZX5z041pWmB+D+C6j5o1xIpaJuXzk3fZ64hUpB34Pk2vXBgZhAsprb6kTylThpkQjClZXXMThpMb9/ZPFzhyomZBlEP+pJbGchQNxvLojt2UyM/t5q3PevgJvzb4LSX8PHGc1qntsxeSkeZIgBaTNHT1ijkn9Ib918xk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4578.namprd10.prod.outlook.com (2603:10b6:303:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 20:41:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 20:41:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
CC:     Chuck Lever <cel@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-tls-handshake@lists.linux.dev" 
        <kernel-tls-handshake@lists.linux.dev>
Subject: Re: [PATCH RFC 04/12] SUNRPC: Refactor rpc_call_null_helper()
Thread-Topic: [PATCH RFC 04/12] SUNRPC: Refactor rpc_call_null_helper()
Thread-Index: AQHZiC5Fgfcz49ahCE6kQ/t0trhIHa9myY4AgAABtYA=
Date:   Mon, 22 May 2023 20:41:52 +0000
Message-ID: <C472D440-4400-4FB9-AE77-85766F34B80D@oracle.com>
References: <168426587118.74246.214357450560967997.stgit@oracle-102.nfsv4bat.org>
 <168426600329.74246.10545150506762914826.stgit@oracle-102.nfsv4bat.org>
 <CAFX2Jfk9up-eyLhe7s65E6+vBTjXrATREFoYJVkCBLAT_56o2g@mail.gmail.com>
In-Reply-To: <CAFX2Jfk9up-eyLhe7s65E6+vBTjXrATREFoYJVkCBLAT_56o2g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4578:EE_
x-ms-office365-filtering-correlation-id: 5f97a11d-2605-4b1e-aef5-08db5b04f93e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +3yYj6d8B3QM9CTOQ9z2upBkfwtUfJQTMt2m5eoLaIWbL58xyZGylFWoMnEt7FGXXzVIfqyO2liNt4i7sEhi5wn10AHu+Pz1MuiQZ4jZxdZC5r7ZySs8P+BSo0YoKpmJwl3X92Q/GrNDy3RWw06WfjWhNAJlSM5p4wI/50FqxM/JZltzEF1mlV1dG+9zVTULAX7kdHULsJFBLeN+u1thiGhVKd9rN3j8HPjlTVv2s+hxg+4Xt6q+5ycKthtPAcoFmhIClad8YuxvKLS+w8/rIdNoP6auPdxHJYhfl6FZ/sTCvPTeNiLsqsCI0SXQogEsbFEbz1wC/xUVu1PNw+UbFnnOqlEjuG2q1PeCebHrhrbcOsm9p6TRBeLnHnbBwVEkrn2YXoxkVW5FS+4XPAmixcrCgCyKPRacg/Wxz7waU1U67dGhHTD0E8FWjDQ123FGC3DTZXZNybKCKNIBeEkBtIrYV3Aju4g5lPv40YSHl7ZeWbdqlXh0GuKknYzU6+Aj57jGjRnizab0LRvUj434zMzY9dDYvkOQz2wOEBJks0eXTe2MV6zPa1X2Zx5SjbjDsql7VznQJZkjoIu+GPQsfc13Kj/FjseAfrDSw26N9tsDvITdeRJO/UMQmG/6HstI8OmarlglGBWCgSjfKvnAZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199021)(8936002)(8676002)(5660300002)(53546011)(186003)(83380400001)(6512007)(6506007)(26005)(2616005)(86362001)(122000001)(38100700002)(38070700005)(41300700001)(6486002)(71200400001)(33656002)(76116006)(66556008)(66476007)(66446008)(66946007)(64756008)(91956017)(316002)(6916009)(4326008)(36756003)(478600001)(54906003)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE8rc0ZWZWNLUjJmdkNaTHovTkVQUjlxbUNDRVZTclVHVVpGdHZmRlVNU0Rn?=
 =?utf-8?B?WkhKYnQxdHRVNEN5bkVyc2JwaVJaUjR0NnoyeWI5UTdFTU9vV2ZmVlRBeHpG?=
 =?utf-8?B?dnVhNEhGajc0REY1RjZBSnplYkwxMDlGWHFhM0RzUlNTM0tpRG1LZ2trV0p3?=
 =?utf-8?B?N28rUml4d0RGQTVDWDNzQjh2MHhEeHp3YU4vZ0k2MDhybU9BZExhQUhQR0x1?=
 =?utf-8?B?cm5xMEdlRGZhaTBOUXJaNkhOSVJhckpjUlUxbEtTZTFlK3E0dUdDTkl1TTFH?=
 =?utf-8?B?YnBEKzRaOHlJZjRQN3BaY092czE1Z01MVks1TnVhcnFsNW5GenNEUHcxdDU3?=
 =?utf-8?B?WFVQSDIzS05HaGFyeFcyOW54bnVSaDBYalgybk1POURVUGYvT2E1UjNkTnlN?=
 =?utf-8?B?QlV0T21IaE0zYkJvd3RtaDFXQTR5WkJVc2ZIY3NtVmVZZWkrWTRNYU93QmRj?=
 =?utf-8?B?bWN0OEJ5S2dTY1F2OVk3TkU4clZINllBM0o2SHZGVGdtdDNVSVZHclNEM25s?=
 =?utf-8?B?WTRJMVRvYWg3TVVJenJRRUYvN0l0UDhKZmQyb3JIelVxTXNpWTVZWkJYKzhG?=
 =?utf-8?B?UHFGbFpTNGF3dzdZWDd0b0VkYTJzcHF4RWFrZDBLUnVxekcyU3VGclgwZm9k?=
 =?utf-8?B?QTZRbDRsU2lEdUlWY2VQd1p0c1RUdmRvYlhpRUJma0VaVkJiWldIMHg2OWJN?=
 =?utf-8?B?UVc3L1pzZTBueDB2VnlUOFYrY3ppdDVtekpjbC9JVm9jWC9qaWx5SFV4Q1o1?=
 =?utf-8?B?NXRmSW1Fd2tNeXJ1d3pVSE96VmZVUnRPMFQ4RUcyRE81OVlEeHRBb0NYRVc5?=
 =?utf-8?B?OWxxWkg3SzVyRm5WZDlEUml4UUh2OVd1a014ZnZiL0tMM2N5NmRVVU9MMTBH?=
 =?utf-8?B?bi9UaUh5anNhUlJwelVSTTlIK3lheHVzRmtEYWtkd0dZY1Ura3RtN2xMeVRz?=
 =?utf-8?B?T1diaEJoVG1XSDdJd21xdk42ZmwzeWVBd0taSWNyRjJBRGVZaC80ZHRDSURn?=
 =?utf-8?B?d1REcHV3anE5OFdSZ2xEY1dCVEVRSHQ0RzF5VjdhWW9haGk4UFdQVkQveGNl?=
 =?utf-8?B?S0ZTWU5DTUpsWnZvcnhHMmhQWWRlT3pqVWgxczZPcEdSMEJOMFBORWZYd0Qv?=
 =?utf-8?B?Q3k5SVZraE1ucE5tNjRKOW9DNFlXSlcxRFAwcUVvM3Y5WnNVTTJhbVhISjdz?=
 =?utf-8?B?OWZST2cxM1BqNFJEL29jYWdKaDJ3a01iWENqSnM5dlZ6eTRScUJpSkJMMmx2?=
 =?utf-8?B?d1drTndiZjlRTHYvczhhejlnN3pFT1d4S1BnUTBKK0c3b1hod0U0MXVxekF4?=
 =?utf-8?B?aVdaRVlrenN1Ukx2R0p2aWR3MlRWcHhXTC9HcnRBK0tDb2lBQ2N3M2toRGd2?=
 =?utf-8?B?eUlIY1Z0VmtJbWxvU3JsbFFVREJ2QVBIcHQ1NHZPcVZaWUFJRFczS0tUOURO?=
 =?utf-8?B?d25pVzBTNHd1MW8rMTJhTVBRMksvTFR0NkhsVzcxYjFFak5qaS8ra3FIb0dF?=
 =?utf-8?B?aDFHaUlvcGJYa2htL2dpS1hGQWRmcElpVk1tRytLZ0FUSXZFaVEzeWYxTXho?=
 =?utf-8?B?aU1FZGZ0bUlnZUxJc2FmMXArRVh1YVdEd3VnbW9vSURITCtFWGRzR20zcWxU?=
 =?utf-8?B?OWhJQlgvaHhlRXI2aXpzRUhSNStrTnBjbTh3cDJVNEovYXNWMkJ4V2xGYnJG?=
 =?utf-8?B?Y3graEFiblBicWF3amRSVmJ2aTFmYzBRSE4ySHBhZkUyUWNybVhyZ0FZMm1W?=
 =?utf-8?B?NW9BcXhpamx3QjNwT2xYbXJmeWlnaGFsVnJHNWlGcXB6R0JKQXh1YTVsNlQ4?=
 =?utf-8?B?cmJOM1lZRGxKYWd0RFVuV21mSE51eTdFaERIWkFManRhTjc1WkdGbnZvQndw?=
 =?utf-8?B?b0VnWk0yUFV6bi9KUnU2eG0xY1IrVXRtK0c4cHlXMlZXUDUvdUFpSGt4djFL?=
 =?utf-8?B?UHc2OTZ0cFd5Y1JacXMrelovTUFVVDVUOHl0WjRYTDJSTEVCK0FTcnZtN0xa?=
 =?utf-8?B?MzVXSG5xS1EwbXNTbXZOMjY4cHFTZGIya2NudUw0M250K0lOb21CcVh0SXdG?=
 =?utf-8?B?U0l0bW5KYllRNDl3TjQ4bVdzYVY2SURkcTY3QTYrc2sxbXA1bHhIYzRHRFpX?=
 =?utf-8?B?OExTdmJhVnlTaW5tQVVyYU1sWmEwL25JWG1nZkwxYlg4dmI4c3kyMzdmdDlN?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A661A5A43B4A074CB5F0DE5573AC0745@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?b1pnL2I1RmdNZ1NnamdnMHVyeUg2bmhXVzZCZVArd1QxVDZJSUVaOVorb0FX?=
 =?utf-8?B?dC8xSUpicVRXVG5FZ08xalBhZ3kvNytwdlROSFlMcWxjaitVYmQ3NVR5VXh1?=
 =?utf-8?B?V1FlWHRSUS82SzRCUUVXQnpXMXBlVWsxL0c4UENIY09VZ3dXUkwvUXJpcHNR?=
 =?utf-8?B?NTNidFFUMVRLeExSSnAzZzJLb0dIV0x0QWtORW8rTno0VU1xa3JYVGRKNFEw?=
 =?utf-8?B?Z212TG5rczZKWFFqdWpOWWJVUjc3cFVXVjYzK1lKVDI0a1Zhd2tsVVQ2djZF?=
 =?utf-8?B?Z3UyMnNmNC9hYjkzMndYNmRnVjVIVi9RbkhXT3lZUzRKRDdDSExEL3RCUms4?=
 =?utf-8?B?QkdzQkRjdjQ1ZHRMOUJRRHp5VGNndGw1a3g1NEthaHFLQkI0aUxVbHpybFBO?=
 =?utf-8?B?VGdtSnFacml1U0tzUUNGb0hSRVNrbGg3QWdSOTQ4ZHhETmJWVUlTNEFZVlZT?=
 =?utf-8?B?Um8wT3pwaXdPaktScnBIRWpOV3MwcFpGOFpOQWxGWlVkVHRGZk1rZHBiNXZs?=
 =?utf-8?B?NHFxR1NkUGYwbDJQVHE2bkJ3QkF6cTZYRlRpYjUwbWVBTmFNSnk4TFEwbnFC?=
 =?utf-8?B?VVZPWG5vQlR6VnJ5K3hGYnI0a0Z3RFJrQnk2SUNKQVl5d2I5cnFJMFZJMWtL?=
 =?utf-8?B?SjUyd1BuZUNBMDlKNlVwU3Rua3RiMVZPZmZhd0tOVEQwV3YzcHVCa1JYaXB2?=
 =?utf-8?B?Yzlvdy9Tc2c4RDdQcjNsakpGczk0Wkc5SkplSzNHa3JyeGpjZzM0WTRwa3pX?=
 =?utf-8?B?ZG9QQWNvTkRMYTc4RUhnYTVtalBHdnRMU1FVMHhkTTE4NXVFbnBCTmY2bGhr?=
 =?utf-8?B?dUh1a1k3d0xqZWlLTnY2S2hVR0h2M0xsOGtycHNQYUtjbm0zUjRWT0RTOGZt?=
 =?utf-8?B?UmhwUm95UHNrSlBtcklTVzNNajdEdXRzNUpnM2pHc2NBMmUvbGkxTmMzVnJ2?=
 =?utf-8?B?TzBBVmJOWE9CTTVMWnFyVnhaNDM0Qm1qczdrK1NjMS95bVZXcmsvYTlySlFB?=
 =?utf-8?B?Q05mNUxvZ0JNeDNvR1h6ajFVSnZhTlo1Yjd0YThUOXk0ZmJLanNFZVpkL3Jw?=
 =?utf-8?B?THZwai80MWNrVk4yMXNyem9xMVFVREs4Z25OT25jY2g5OThXbktGNWRmMUh4?=
 =?utf-8?B?NUdjbGdoY2ZwRzFNL0lRVHNLelhMZ1lsOEZkNnVoRDBUZSsrYUZMUDNsS3Na?=
 =?utf-8?B?eG4venVEOGF4UEg1LzVsU0hWaVNGNWlhMFE2RUREbjhvK1YrTis0bnM2dmxC?=
 =?utf-8?Q?Iem1T3lecLJj47R?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f97a11d-2605-4b1e-aef5-08db5b04f93e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 20:41:52.2210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylM3WdC2H+9iplakklRe9/hkaIOcPep6G0wgqRdGO0z0opgiO6y55oAD4CF2rj3wlhjGV6BBy4CaNcsve02Hgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4578
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_15,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220175
X-Proofpoint-GUID: gZbvL6_4T94sYGj1Ai1246R86XRPCrJ6
X-Proofpoint-ORIG-GUID: gZbvL6_4T94sYGj1Ai1246R86XRPCrJ6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWF5IDIyLCAyMDIzLCBhdCA0OjM1IFBNLCBBbm5hIFNjaHVtYWtlciA8c2NodW1h
a2VyLmFubmFAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IEhpIENodWNrLA0KPiANCj4gT24gVHVl
LCBNYXkgMTYsIDIwMjMgYXQgMzo0MuKAr1BNIENodWNrIExldmVyIDxjZWxAa2VybmVsLm9yZz4g
d3JvdGU6DQo+PiANCj4+IEZyb206IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29t
Pg0KPj4gDQo+PiBJJ20gYWJvdXQgdG8gYWRkIGEgdXNlIGNhc2UgdGhhdCBkb2VzIG5vdCB3YW50
IFJQQ19UQVNLX05VTExDUkVEUy4NCj4+IFJlZmFjdG9yIHJwY19jYWxsX251bGxfaGVscGVyKCkg
c28gdGhhdCBjYWxsZXJzIHByb3ZpZGUgTlVMTENSRURTDQo+PiB3aGVuIHRoZXkgbmVlZCBpdC4N
Cj4+IA0KPj4gUmV2aWV3ZWQtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+
IC0tLQ0KPj4gbmV0L3N1bnJwYy9jbG50LmMgfCAgIDE2ICsrKysrKysrKy0tLS0tLS0NCj4+IDEg
ZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRp
ZmYgLS1naXQgYS9uZXQvc3VucnBjL2NsbnQuYyBiL25ldC9zdW5ycGMvY2xudC5jDQo+PiBpbmRl
eCA0Y2RiNTM5YjU4NTQuLjJkY2EwYWU0ODllYyAxMDA2NDQNCj4+IC0tLSBhL25ldC9zdW5ycGMv
Y2xudC5jDQo+PiArKysgYi9uZXQvc3VucnBjL2NsbnQuYw0KPj4gQEAgLTI4MTEsOCArMjgxMSw3
IEBAIHN0cnVjdCBycGNfdGFzayAqcnBjX2NhbGxfbnVsbF9oZWxwZXIoc3RydWN0IHJwY19jbG50
ICpjbG50LA0KPj4gICAgICAgICAgICAgICAgLnJwY19vcF9jcmVkID0gY3JlZCwNCj4+ICAgICAg
ICAgICAgICAgIC5jYWxsYmFja19vcHMgPSBvcHMgPzogJnJwY19udWxsX29wcywNCj4+ICAgICAg
ICAgICAgICAgIC5jYWxsYmFja19kYXRhID0gZGF0YSwNCj4+IC0gICAgICAgICAgICAgICAuZmxh
Z3MgPSBmbGFncyB8IFJQQ19UQVNLX1NPRlQgfCBSUENfVEFTS19TT0ZUQ09OTiB8DQo+PiAtICAg
ICAgICAgICAgICAgICAgICAgICAgUlBDX1RBU0tfTlVMTENSRURTLA0KPj4gKyAgICAgICAgICAg
ICAgIC5mbGFncyA9IGZsYWdzIHwgUlBDX1RBU0tfU09GVCB8IFJQQ19UQVNLX1NPRlRDT05OLA0K
Pj4gICAgICAgIH07DQo+PiANCj4+ICAgICAgICByZXR1cm4gcnBjX3J1bl90YXNrKCZ0YXNrX3Nl
dHVwX2RhdGEpOw0KPj4gQEAgLTI4MjAsNyArMjgxOSw4IEBAIHN0cnVjdCBycGNfdGFzayAqcnBj
X2NhbGxfbnVsbF9oZWxwZXIoc3RydWN0IHJwY19jbG50ICpjbG50LA0KPj4gDQo+PiBzdHJ1Y3Qg
cnBjX3Rhc2sgKnJwY19jYWxsX251bGwoc3RydWN0IHJwY19jbG50ICpjbG50LCBzdHJ1Y3QgcnBj
X2NyZWQgKmNyZWQsIGludCBmbGFncykNCj4+IHsNCj4+IC0gICAgICAgcmV0dXJuIHJwY19jYWxs
X251bGxfaGVscGVyKGNsbnQsIE5VTEwsIGNyZWQsIGZsYWdzLCBOVUxMLCBOVUxMKTsNCj4+ICsg
ICAgICAgcmV0dXJuIHJwY19jYWxsX251bGxfaGVscGVyKGNsbnQsIE5VTEwsIGNyZWQsIGZsYWdz
IHwgUlBDX1RBU0tfTlVMTENSRURTLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgTlVMTCwgTlVMTCk7DQo+PiB9DQo+PiBFWFBPUlRfU1lNQk9MX0dQTChycGNfY2FsbF9u
dWxsKTsNCj4gDQo+IEkgdGhpbmsgeW91IG1pc3NlZCB1cGRhdGluZyBycGNfcGluZygpIHJpZ2h0
IGJlbG93IHRoaXMgZnVuY3Rpb24gYXMNCj4gd2VsbCwgSSdtIHVuYWJsZSB0byBtb3VudCB3aXRo
b3V0IHRoZSBmbGFnLg0KDQpIcm0sIEkgaGF2ZW4ndCBzZWVuIHRoYXQgcHJvYmxlbS4gQnV0IEkg
Y2FuIHRha2UgYSBsb29rLg0KDQpUaGlzIHBhdGNoIGhhcyBiZWVuIGFyb3VuZCBmb3IgbW9yZSB0
aGFuIGEgeWVhci4gSSdtIHN1cmUgZm9yd2FyZA0KcG9ydGluZyBzbyBtYW55IHRpbWVzIGhhcyBs
ZWZ0IHNvbWUga3J1ZnQuDQoNCg0KPiBBbHRob3VnaCBJIGRvIHdvbmRlciBpZiBpdA0KPiB3b3Vs
ZCBiZSBlYXNpZXIgdG8gc2xpZ2h0bHkgcmVuYW1lIHJwY19jYWxsX251bGxfaGVscGVyKCksIGFu
ZCB0aGVuDQo+IGNyZWF0ZSBhIG5ldyBycGNfY2FsbF9udWxsX2hlbHBlcigpIHRoYXQgYXBwZW5k
cyB0aGUNCj4gUlBDX1RBU0tfTlVMTENSRURTIGZsYWcuIFRoZW4gd2UgZG9uJ3QgbmVlZCB0byB0
b3VjaCBjdXJyZW50IGNhbGxlcnMsDQo+IGFuZCB5b3VyIG5ldyB1c2UgY2FzZSBjb3VsZCBjYWxs
IHRoZSByZW5hbWVkIGZ1bmN0aW9uLg0KPiANCj4gV2hhdCBkbyB5b3UgdGhpbms/DQo+IEFubmEN
Cj4gDQo+PiANCj4+IEBAIC0yOTIwLDEyICsyOTIwLDEzIEBAIGludCBycGNfY2xudF90ZXN0X2Fu
ZF9hZGRfeHBydChzdHJ1Y3QgcnBjX2NsbnQgKmNsbnQsDQo+PiAgICAgICAgICAgICAgICBnb3Rv
IHN1Y2Nlc3M7DQo+PiAgICAgICAgfQ0KPj4gDQo+PiAtICAgICAgIHRhc2sgPSBycGNfY2FsbF9u
dWxsX2hlbHBlcihjbG50LCB4cHJ0LCBOVUxMLCBSUENfVEFTS19BU1lOQywNCj4+IC0gICAgICAg
ICAgICAgICAgICAgICAgICZycGNfY2JfYWRkX3hwcnRfY2FsbF9vcHMsIGRhdGEpOw0KPj4gKyAg
ICAgICB0YXNrID0gcnBjX2NhbGxfbnVsbF9oZWxwZXIoY2xudCwgeHBydCwgTlVMTCwNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJQQ19UQVNLX0FTWU5DIHwgUlBDX1RB
U0tfTlVMTENSRURTLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnJw
Y19jYl9hZGRfeHBydF9jYWxsX29wcywgZGF0YSk7DQo+PiAgICAgICAgaWYgKElTX0VSUih0YXNr
KSkNCj4+ICAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKHRhc2spOw0KPj4gLQ0KPj4gICAg
ICAgIGRhdGEtPnhwcy0+eHBzX251bmlxdWVfZGVzdGFkZHJfeHBydHMrKzsNCj4+ICsNCj4+ICAg
ICAgICBycGNfcHV0X3Rhc2sodGFzayk7DQo+PiBzdWNjZXNzOg0KPj4gICAgICAgIHJldHVybiAx
Ow0KPj4gQEAgLTI5NDAsNyArMjk0MSw4IEBAIHN0YXRpYyBpbnQgcnBjX2NsbnRfYWRkX3hwcnRf
aGVscGVyKHN0cnVjdCBycGNfY2xudCAqY2xudCwNCj4+ICAgICAgICBpbnQgc3RhdHVzID0gLUVB
RERSSU5VU0U7DQo+PiANCj4+ICAgICAgICAvKiBUZXN0IHRoZSBjb25uZWN0aW9uICovDQo+PiAt
ICAgICAgIHRhc2sgPSBycGNfY2FsbF9udWxsX2hlbHBlcihjbG50LCB4cHJ0LCBOVUxMLCAwLCBO
VUxMLCBOVUxMKTsNCj4+ICsgICAgICAgdGFzayA9IHJwY19jYWxsX251bGxfaGVscGVyKGNsbnQs
IHhwcnQsIE5VTEwsIFJQQ19UQVNLX05VTExDUkVEUywNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIE5VTEwsIE5VTEwpOw0KPj4gICAgICAgIGlmIChJU19FUlIodGFzaykp
DQo+PiAgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUih0YXNrKTsNCg0KDQotLQ0KQ2h1Y2sg
TGV2ZXINCg0KDQo=
