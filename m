Return-Path: <linux-nfs+bounces-92-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A007FA5E6
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 17:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4699528143E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 16:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A632C35F03;
	Mon, 27 Nov 2023 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AEP3l9zO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KEYiN5Ti"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC6DBF
	for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 08:14:09 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARFL9Iv005604;
	Mon, 27 Nov 2023 16:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BNbFW25TdL2Wv7UH3bnbacQ193WTrbwjqBZvACJ9BDo=;
 b=AEP3l9zOxXUXm5HsiBzxQ9pn3BXRBFFHMkfjgylIh+mybV4ZUO8iVajz+tXJiPO4s8fx
 jTXHvldCi1G9l9qrmNIh5SCwwNqnY88y/VdmMcYoE6Lx3cktvEts8oRByKqu1j6Z6epv
 y4xcrWu+2hpVt6GH4J4V+MvAGC9OeuFWdSwkVbXNhuT+FltJSWQlCw0Nc4aSct/bi572
 ipGF5jOZY1VKgt+pIVspJ78M2h2zf/xK2bTQ3pM8hy/fJYTYWiz0fjPPpMOsUWU90zmr
 6MoHXh2+E6FDdM1XpM3oWEuK1+/Q4kxMxpGEHDajVbgf0r+cD0p4mjPv7+ws7+M5n84I ow== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk8tbua5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 16:14:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARG5teZ012761;
	Mon, 27 Nov 2023 16:14:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c5s93a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 16:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIzU+m5Egpueo1CWK+LkowrmaryBzXNNOTHkbvRuDV5MF7CKX/T6CSsU10ifHJDx343H/0qKFoHEkKL1Ye4TIILq5hHqkkUOxKXetGG3l47at//Us7P+td6gEAF3IXEOIW505gmeJB4p8a25pSMnLqk0YEVSXm9Wo7gCFytxDe4y2YrLmcSzhAH7OTtIZ9ETeAcNRC4IntF4QHCLIH25/puixGwl+Y6J8omEaV7ZzJ0I0Fch6oxFUchQa4AqHOke+T408t339VNlfiERmdtP/2hgC2cTcq/ThS+RCQq18Vp+4tGjYq8CYJ7X5DldFn6JIjGaChZcwLDMTc1CdR7Mmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNbFW25TdL2Wv7UH3bnbacQ193WTrbwjqBZvACJ9BDo=;
 b=Ek9kI38X7IHPDca8Uhc4jugWbTGVPGuwSXlk4JZtCnktDiohzYzwPudwuhzK7sE+dIzh8mEXL/JZQrdetzkh0Uhy2+9yVNAAECgGlAo4U6elZQx6AU9Kc3sKvzWD9RIVRZwmitXyI2trO+VStj4rSnFW/a7e5dB0x1bCKjbS5ZlrhNdM1rQyZO8gwETzZz+gkWsM4KBVKRumLt60uxYZ7eZ/KM/8uVVDMxC95//domQf6BsHj8ayphvOf9c3+jNUXHBhGCxkGqJUQFo5EFPr5P7dtx/2QsOlwyx6pgMWKYZgT+E6WYczcm5HmacoHOKEtK/R+YpOHBwFSw98c5A/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNbFW25TdL2Wv7UH3bnbacQ193WTrbwjqBZvACJ9BDo=;
 b=KEYiN5TiCVGJfoSzi8uA2GvcpMMSXHTdyVcMO1eNt8vV+bKKnlmZ9n9iYyWojARHPml/oK4ysn+OiIZnBDEJf30DLvDF93yF/nZrgTZZQPLf6y6jg/kmul4xPDpRq8lIzpw+W6CtXXgdYSR7aK4SYUL40JqfLvdGuN4uTYdr2/A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7286.namprd10.prod.outlook.com (2603:10b6:208:3ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 16:14:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 16:14:04 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] Eliminate the RQ_SPLICE_OK flag
Thread-Topic: [PATCH v1 0/3] Eliminate the RQ_SPLICE_OK flag
Thread-Index: AQHaFjjzvQdnfwQlnUusWa/MZZQfLrCOMOyAgAA8EQA=
Date: Mon, 27 Nov 2023 16:14:04 +0000
Message-ID: <6579AC1B-B962-45DC-B863-9C7810B03674@oracle.com>
References: 
 <169988319025.6844.14300255016413760826.stgit@bazille.1015granger.net>
 <fc4f940398da439282eb508dafe9dfabc18f609c.camel@kernel.org>
In-Reply-To: <fc4f940398da439282eb508dafe9dfabc18f609c.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB7286:EE_
x-ms-office365-filtering-correlation-id: fde42b2f-9345-4e7a-de27-08dbef63e018
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 FFMdmORHkgrDwyMOr2LTyN1WLPAzahh/YE3DMgHXD3tSB+Ku7AnISCITwJkkLHZ7/dh8RT7lIwXlkrSyg9kw0TwgqIQg8bG/rSgr0ChbU6YfjlsYUQsOy6O+wp+IiHcUK9kls0zz/fRbKA2iePPpA3pDH3dXwXKZi0N2SP5rqB8QARb3MbE+bfJAyewJr6/x11T+8gJhRk4nCrYiEDNQy7pDiTE44c883dJFMm5hTB4OEX8ZNuOCY8H677MJ76sEC6S1fxoZ/RhFsQNdqnt31h+p6uBldJH9Jhd52uoFVKIw3vOek8+8CmXNMrq6oAQdYYlA6QPyJiA/wB0z1nI23/0OKQEyFuXkPbueNnG7SUY3rnVk++tEaDbZjN9IlAF6gUFa+cMs3MahUV56pi94MSFGUfPSF3FiumWrFJmpGdL5x3KdhJMUIlpJS6C/XEcQMdIkO9OI70IfC9lTz8emu8ATZ8ozBTIMnFkOl9aOC7s29rtkXO5AmH7zpNdhvd/f20lZ+3M1TWqPZzFOJ5Lwf+1aoHBVoQ0u6zCJvuu2DIhlDgGNNW0Q4WUlyRH1okvv9itx2YA3BPPVfAtu+L+WnBH8AYhA1Lpyv04FsnK494XiMCA/0lNSCFophSth46Xfki9KsyaPKrclvlXLcXlJmw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(83380400001)(38100700002)(122000001)(8936002)(4326008)(6506007)(8676002)(53546011)(6512007)(71200400001)(66446008)(66946007)(66556008)(66476007)(91956017)(6916009)(54906003)(64756008)(316002)(76116006)(5660300002)(6486002)(86362001)(478600001)(4001150100001)(2906002)(41300700001)(36756003)(33656002)(38070700009)(26005)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bzA1N005UmMwL2VyR1gzYUgybmpqczFUNXpmQ1UvQzZmTmFJL2VWNDk0eFh1?=
 =?utf-8?B?OE05QkJ2eGp2dE1SS3NUeTJKVGZaZTM3OWlXcmw5aXlydE5KaTd2dWZVMFph?=
 =?utf-8?B?TTNiZzB1WUc0ZkhNbW01ZzU3cDYvMFBYTGRtMXErN1NGYzJURTQ3aTNhSXdy?=
 =?utf-8?B?REFieEFIUmFLcHpaU2RIdWxsZ2NzMHYwUGhOSTRCTDd1MTU1NXVsUmxRdHVl?=
 =?utf-8?B?d09rNG9hcFhmaGVvN0ExdXo5NzlCU1hMTkQzWkRQeUZ5a2k3bGdZRTNLSCsw?=
 =?utf-8?B?VXRFcXl2TnVLU2lyYW5KUTErTGIxZCtKcG90TXBHYmQyQkd6bHBaMW1HMnBH?=
 =?utf-8?B?a1lMT3Y3SVBtK1I3dUpSbXBuTjlKOXg4ZGdpMzdvWGE4aDRxYUZQVFZZSUh0?=
 =?utf-8?B?U2RUTkRWalpEem9sbjZKZ2t6ZWNMcVNhZ0NwMHNURnpVckhTcWFjSGJQeVNx?=
 =?utf-8?B?dUxCd0t2TlU3MG5Rcis2d3Z5MmxVd3A5ZWY5OU5BN3BjOXpKUVFyemtHcnZQ?=
 =?utf-8?B?WDZtSU45YlcrVXNVQUgxL1RMT2c5S01nOUtHQkxpak83dUpOZ2N6L2pKMTQ0?=
 =?utf-8?B?Z0pXN3pLeEF0VDUwMG1qOUczNzRKMVNqVGJPakFvM251QkRxVEswRTRVaFZ5?=
 =?utf-8?B?U3pUVmVHMVFCbldlUWdWdGlvNHpBM1dVS0tpSERzTVJCd0JGSzFXeE0yMDRD?=
 =?utf-8?B?TGE0OUVwVTJRdkhYM1pabnFESE5XYmlzQ2I0b24xVWdQSklDYWNrVVpoRmtW?=
 =?utf-8?B?TEQ2SUR0ZkRtblFhQUtMaDVvMFAzZTFSRkR4VzVhYlpSRjJoQ1BORnl0ZGZh?=
 =?utf-8?B?OVExVVpEVElQRWlhbnNkaGVDVmtXeHltQ1BqVlZicmNody82UjluQzFoQUE0?=
 =?utf-8?B?OU8zMkJCdkp4QzBkOGVYYStsanhQVUNOejlBbE9FNnBMbkhPaG5lSEsyY0pm?=
 =?utf-8?B?d2wrWjg3b1lzVkpsSDYwNjMxRHdQQTNjcFNFQzVDdUI0Ty9iUGZaWWpZVU92?=
 =?utf-8?B?dkJaei8wYjZJU1l0M1gzS3lzemM0bG5uTXJUeGdtTm56cEZnVzRIZVB3NDNP?=
 =?utf-8?B?eS9vWE03d0xRQ0lGWmU2RFdBUmZudkNFdlg1YVBBeCtIUnJYRTdCalg0RnpY?=
 =?utf-8?B?bmR6M0pwSkhvckV3MFlVMlFndktJTy8vQ0FMeXRwRXQ1K1BIMWNBWHVtbzQr?=
 =?utf-8?B?UGlLbUd6WWNCM0d0M09TOTgzcTRlRWdBMGJRS29sU1NUNWkzKzI0dWY0eGtY?=
 =?utf-8?B?ZlZteEFlM0VITXVRSWJpQVpMRDk3VDV6OTBjck0xN1dXcFp2ZWNHeWYwUDRG?=
 =?utf-8?B?cVhzbFF2eEZTeCtEQWpkMlRBVXZoeVpnOUtQRGl1eG54Q1l6Q3RaODJRYWd2?=
 =?utf-8?B?K2pudVU2YnFaVms4VU4zNGRhN1V3cE5Xczh1MDJNalczenpLUWtCSkJ1M0Q0?=
 =?utf-8?B?MEd6K1lFUVRETjFuZ1Q2SG1UWFZSamhlSVhJbXo2K2RZT1VxZHZjYklmL2VO?=
 =?utf-8?B?YUl5ZzhrL3JIVzRDU255UWVzYTFVN1F0NFByWVFESytxWUdEQ01HcTlXN3Iy?=
 =?utf-8?B?WFIxYnB0aDB3dzlQdFlGVXBhVGFtWmU5emhiL1hTekxtNVptSE9kblpRYklu?=
 =?utf-8?B?eEpnNSs3aHFENllaRUlFcWlyWXIySHAyajQvVDJWcDdXRisvcDRQZlppSk5i?=
 =?utf-8?B?WDBrQlBMY2JJV0o2QVdrLzY2cWEvdlZUUGQwOVZBSHgyYnlSakNyUlpFSjJm?=
 =?utf-8?B?aWVKbHdPSjRrZy9PV3dXUUVreTU2MUc3Sm9qUFUvNVlFNWl1M3FDMjBraXMz?=
 =?utf-8?B?SXVJaFFPNUsrWGdNenhHVVpRRUwzZExGWVRhc1ZPZjQ3S3lySlNWSERIUGxM?=
 =?utf-8?B?Q01zVDlUdDd6aTM4YUM0ZkhiNkRPekMrVjI1bVVCanQ1NXlHUHpkTkR3N2lP?=
 =?utf-8?B?OUowTUJDSGlEV2tsVzkwaERaTWovUk9qMnIvWHJhRG55cWsyWWVsZjVXVTUr?=
 =?utf-8?B?aENzVUg3M0xyREZsRkFuUUZiQ21KUHVnbktjZVc5Z2REaE02MWlXcnhYSnFW?=
 =?utf-8?B?K0lPRjNSZURZNjB3bmUrNE9vZCtqa2pTeE1paElocHlHL25KUGd0S2NDVjNV?=
 =?utf-8?B?Z0lQd0ZveUlKdTZOVDZZZkI5d0hXOGtyV0tpSnBTZWtRa2d0bjBPOXBSNUh2?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3249B4BDE1FDF941BD470B520D87A279@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	B7gNHqMy3mGQb2+hZETewSQrImeLEUunsI0pLoid5P8LwqFblTwxOGv29MO6YXFaYMh7ilGSW8lbhS59Iek7Eno8O7zC2UVWD3fAuUwqMwHishZ7cMYImCGtya2/HD6q4mh8fxhbpEx9p6Vt+ccfnTZLAFbAv5MifhwwWCuD6gtRfZf3TWYihSzJ2tI8jNIBTs0xPIttu3jPX4D1bmX7XIPX0HByEgRjhcRwIKyvYeRZyyFkBlOqmR+17MGWn6pSvu26XxW/Acf8kzdRn+s5JOY4AtwcyyBUy6wAxqrL1BYYKDxt/RtniMWxXtSud9oSj6YsgzLKuEKh+uUy97t3qxLgWm9oizPy1hHGf7D0UFZEd5uAz3enMV+3GLcoBP5/eufX8xREhzewfi1wk4CM2kfZgjKxp17Ku8wT1pMPXT9iICxamW+hnlGw5MpOzuHuLPTwqicN+e1NdraUJ9Rl/YAguI7l5Yw2i/Mg19wldf+DdFlCc0Zjvrdz2Dzpyzdax50bmOpgD9hsNw+jLhB4iLp45bdIa0lnfYRiYNyv387E/h8GkoNFxsp39OH8giUraLCfcWLsTAavG4ZV+CRT5KJ4VHUMOxO8vUUNE8SH1Dd23nJ8o7uCtIGnH0WJyjpm+m2h5Qy+LGSQ9u60OeHL3MG3g7BBvpQ2VsoJ5kptHXn/8twrI3in0ZK5BYd6nQbNfezyLvd8h//7pOQM3BQJPtixcTSYgOaL1QAiFOFn1Jj4wp2rZlVi2q/Qne4MA7cifGydQrpVD38a/XS4Qa/KQqQK2Z1Iic4zkbb6/PUiEGg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde42b2f-9345-4e7a-de27-08dbef63e018
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 16:14:04.3476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s4GyWGanmtgXf09Ay6TNAZD27gIs302DFuR+Azd3GHykKYIFpBJeXG3KVMF8EWAHmv5CYAJYoqDfVFt8AYtD0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_14,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=994
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270112
X-Proofpoint-GUID: TWt3hSHvOtkTQ7ktMq9ZSraA_2XcPR92
X-Proofpoint-ORIG-GUID: TWt3hSHvOtkTQ7ktMq9ZSraA_2XcPR92

DQoNCj4gT24gTm92IDI3LCAyMDIzLCBhdCA3OjM44oCvQU0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCAyMDIzLTExLTEzIGF0IDA4OjU0IC0w
NTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4+IFRoZSBzZXJ2ZXIncyBzcGxpY2UgcmVhZCBwYXRo
IGlzIHVzZWQgYnkgdGhlIG1ham9yaXR5IG9mIGV4cG9ydGVkDQo+PiBmaWxlc3lzdGVtcy4gQXQg
bGFzdCBtb250aCdzIGJha2UtYS10aG9uLCB3ZSB0b3NzZWQgYXJvdW5kIHNvbWUNCj4+IGlkZWFz
IGFib3V0IGhvdyB0byBpbXByb3ZlIGJlbmNobWFya2luZyBhbmQgdGVzdCBjb3ZlcmFnZSBvZiB0
aGUgTkZTDQo+PiBzZXJ2ZXIncyB2ZWN0b3JlZC1yZWFkIHBhdGgsIHdoaWNoIGlzIGEgZmFsbGJh
Y2suDQo+PiANCj4+IE9uZSB3YXkgdG8gZG8gdGhpcyB3b3VsZCBiZSB0byBleHBvc2UgYSBzd2l0
Y2ggdGhhdCBjYW4gYmUgc2V0IGJ5DQo+PiB0ZXN0IGhhcm5lc3NlcyB0byBkaXNhYmxlIHNwbGlj
ZSByZWFkcy4NCj4+IA0KPj4gQXMgYW4gaW5pdGlhbCBzdGVwLCBob2lzdCBSUV9TUExJQ0VfT0sg
b3V0IG9mIHRoZSBSUEMgbGF5ZXIuIExhdGVyLA0KPj4gSSdsbCBhZGQgYSBuZXRsaW5rIGNvbW1h
bmQgdG8gYXMgYSBzd2l0Y2ggYmV0d2VlbiAidXNlIHNwbGljZSBpZg0KPj4gcG9zc2libGUiIGFu
ZCAiYWx3YXlzIHVzZSB2ZWN0b3JlZCByZWFkcyIuIChJIGRvbid0IHdhbnQgdG8gY29sbGlkZQ0K
Pj4gd2l0aCB0aGUgd29yayBMb3JlbnpvIGlzIGRvaW5nKS4NCj4+IA0KPj4gLS0tDQo+PiANCj4+
IENodWNrIExldmVyICgzKToNCj4+ICAgICAgTkZTRDogUmVwbGFjZSBSUV9TUExJQ0VfT0sgaW4g
bmZzZF9yZWFkKCkNCj4+ICAgICAgTkZTRDogTW9kaWZ5IE5GU3Y0IHRvIHVzZSBuZnNkX3JlYWRf
c3BsaWNlX29rKCkNCj4+ICAgICAgU1VOUlBDOiBSZW1vdmUgUlFfU1BMSUNFX09LDQo+PiANCj4+
IA0KPj4gZnMvbmZzZC9uZnM0cHJvYy5jICAgICAgICAgICAgICAgIHwgIDcgKysrKystLQ0KPj4g
ZnMvbmZzZC9uZnM0eGRyLmMgICAgICAgICAgICAgICAgIHwgMTMgKysrKysrKystLS0tLQ0KPj4g
ZnMvbmZzZC92ZnMuYyAgICAgICAgICAgICAgICAgICAgIHwgMzAgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystDQo+PiBmcy9uZnNkL3Zmcy5oICAgICAgICAgICAgICAgICAgICAgfCAgMSAr
DQo+PiBmcy9uZnNkL3hkcjQuaCAgICAgICAgICAgICAgICAgICAgfCAgMSArDQo+PiBpbmNsdWRl
L2xpbnV4L3N1bnJwYy9zdmMuaCAgICAgICAgfCAgMiAtLQ0KPj4gaW5jbHVkZS90cmFjZS9ldmVu
dHMvc3VucnBjLmggICAgIHwgIDEgLQ0KPj4gbmV0L3N1bnJwYy9hdXRoX2dzcy9zdmNhdXRoX2dz
cy5jIHwgMTAgLS0tLS0tLS0tLQ0KPj4gbmV0L3N1bnJwYy9zdmMuYyAgICAgICAgICAgICAgICAg
IHwgIDIgLS0NCj4+IDkgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRp
b25zKC0pDQo+PiANCj4+IC0tDQo+PiBDaHVjayBMZXZlcg0KPj4gDQo+IA0KPiBOaWNlIGNsZWFu
dXANCj4gDQo+IFJldmlld2VkLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0K
DQpUaGFua3MhIFRoZXJlIGlzIGEgdjIsIGhvd2V2ZXIsIGJlY2F1c2UgdGhlIDAtZGF5IHJvYm90
DQpmbGFnZ2VkIGEgc2lnbmlmaWNhbnQgcHJvYmxlbSB3aXRoIHRoaXMgc2V0Lg0KDQotLQ0KQ2h1
Y2sgTGV2ZXINCg0KDQo=

