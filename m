Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025683E4DFE
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 22:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbhHIUjS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 16:39:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10606 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233500AbhHIUjR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Aug 2021 16:39:17 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179Kb2Dh021684;
        Mon, 9 Aug 2021 20:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=awwVhi2dUABNNAqssgsF2UbIRaUVm9PVRs4zCv42nbc=;
 b=Chs9jhvI1piP/8zglsjjkcagre8dZ1VAWfaAE/VTszS79FGnXfaMrCr2gw8i5v8lUfok
 HR1+qDk6pbYXIBQpDmesg1NdRdd9cmG/OiXWk6nm1RbdwhC+jNuIfLA0aYfvnti8cumU
 Tk8pzZ/v7TVMnWSDwslnPB866e4QAcTClAg5VV25ij0n8d3CtIKuevXWlYs+f06HhF6i
 a39ltVK76bR0A6QKMgU6eaDC6dJfjw0QTJCr7pF+x7F9mAapMIymh4B1WUbEa1w/shAg
 2UppTjqhuncTIr8Ufn5xkwRZk+1d+/kugFBAvtwjM37modYK9oR+OM5vZxxL0ZKCFmzu 5A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=awwVhi2dUABNNAqssgsF2UbIRaUVm9PVRs4zCv42nbc=;
 b=iwMwnpMdzQJAVMt2jS12+Zkx+Fq3SUkwkRH4AYLXQ6dxM7mXUJE9nvPw1VKsE7NiIT+w
 SEona47Z7VcX4NqFmnSgx/zuFhTjGh4QfkHvM6kMJbZDl4bBcjNZyqDikdF4TOVNEDHJ
 8IRVGjMZCPlWg8yLFiJ+9LjydH70iTms9dwjBBjlZJ3L4J3WmD/fyk5+zPhRIS1uA6IC
 fYdKMBpra5hr5f7hYV2Oh320UYu6MQBSEUcD4bCAoGLTlYombW/x/lRlbaXyUaJ20zW2
 /cb3VkqQmxoYJ3aq3YRNiW6K2CU041xoJE2cTzz47VIe+dEOjLBqFMoyivb4BdXK4l3P XA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aaqmutbjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 20:38:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179KaK9B050531;
        Mon, 9 Aug 2021 20:38:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3020.oracle.com with ESMTP id 3a9vv3hwyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 20:38:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wa/QRR0/T2huhEjGPYagZFqlrt+zTpB3eRLvgEEhU22GTciyDQNYcxAazT5Qg9wfp5tRZjdq4GTpawwVLVuZdLGSSQi4trWhU5ftHZfnWKLd+8m2YLAb++mGQpUKfjG67gbfTl9xUqLZOYDsmzn3+86n+xGz4kkLGX2hlGaIOCs/o4C2zYvnNvTQLeSlufHj1mvMF5u0b4mWnPS9hzwzMBHpVZXi4qf1bMIwmocghdY8vFh3jImyd/blDvgVCNyh1hDEBAtCXdpXo4rcmBFu+Bg41R2F1vYMSwKq4mWYChVm731qDoEQjoKq/d5y84SH9RfyDJX4YzgEaWOMISr0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awwVhi2dUABNNAqssgsF2UbIRaUVm9PVRs4zCv42nbc=;
 b=NGmaJBYmTwa96gGQ9qwXylWPXWK2G5veUfCitt1XjpwcaNll93SxOkspAPl+OzQ53CGXASIBZOTeSohMRMD328P9ObDJ1rVR0PHEl35sIsCg0lD23oUmaOANsBrKAEIP3T5+htatPJAFgLjexT9VrAuFCllT4Jysrfi8Jx2imcaFEWS7U6dpUdsEebmp+C6fAHfZTi2CGQ0OlAKwJqofWVL9/TKzFy7WcIa5womSB/9VAUgsYUYDL8D3GGOB06eSSyfJYKHjqwrFrLQS4q3yTKzy+7W7nTDSU+xDeIaPFFMKGYIuBqDcC7QKYyzNMdRKfUQXKdDY6kJTdGCMSrpXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awwVhi2dUABNNAqssgsF2UbIRaUVm9PVRs4zCv42nbc=;
 b=Gf2wnSbinSm4VpXyun33cI2L3dZ9eFUyRSbiNVcXcF/rwPMtbvTRiSk7JjHDWDBgxVW20PznPCLXuCC6lou4yyvxxIQ0osXqtToQ4D383NrfwDo0sydxlwidIthRDfAwdBYt/iLLuY7yb9twSV/wMszwUqErgjzU5+G1Tzcb5og=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2517.namprd10.prod.outlook.com (2603:10b6:a02:b4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Mon, 9 Aug
 2021 20:38:51 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 20:38:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] Ensure RPC_TASK_NORTO is disabled for select
 operations
Thread-Topic: [PATCH v2 0/6] Ensure RPC_TASK_NORTO is disabled for select
 operations
Thread-Index: AQHXfWrpQ+V2VrMKW0eAjD9LScOT9qtrwdoAgAAAbgA=
Date:   Mon, 9 Aug 2021 20:38:51 +0000
Message-ID: <82A33007-6AE7-49BF-84CF-F960DA1548E3@oracle.com>
References: <162670594361.468132.16222376053830760696.stgit@manet.1015granger.net>
 <CAFX2Jf=PvvsU8p+3i3OdLOwRCWDedBKhbhnNOe-RyaXx5LWUow@mail.gmail.com>
In-Reply-To: <CAFX2Jf=PvvsU8p+3i3OdLOwRCWDedBKhbhnNOe-RyaXx5LWUow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e76716c1-aa9b-41a3-a058-08d95b75b264
x-ms-traffictypediagnostic: BYAPR10MB2517:
x-microsoft-antispam-prvs: <BYAPR10MB25178B5107B9DDEC93DA93DF93F69@BYAPR10MB2517.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ohP9N7mj6IqiYljaQEfihD5ZWxW3xx+Fi8/mL1SaHpuk8dENjV1XdRNutnkXkwb+G6mANGQL041eFQI0dDKyjPBLBxWy5xL1hnPxRMdSxdUTNYeNACaca4IWOTJx47VuYr1BL04d0ZQvOudpFHhhO3gp5GoRqvJgyKMBo0Ssk67zDxn7QfsxXZa6jiIQITxCpMy62e1itFvOV7/NBvViaGtBge0vRKvfGH5CHrZCReORQdCrM9DtfxE5M62ADj5YJwE1d5/7Vb0q8A0U0lUCTE87XWI/eH++33zS/MP9zA3LYANmvpZHTMz5KsTiV6hbECNC1DoXvCNUBNL9BPDyDTmrP+ChRed3Lmaer7VHonIY1XZ8j8CPA/HtUu5+1Fi7N3e+81XxuN18y758mfASz+N+y9B4DWN/GBiJiM+gBCODJRuLkMgZh+ZFD1Tv+9HewH2lV+3qoVUuGCAlCVhlDlKtobSI5cW/5eqlkk8G08YqvqlUp/P0fHoLArBBXFYnQG8gc6SwCePJpUoaTbWlAHCIzX8PmDvZ05m9BQQvJ/23eovcm3C82O3syHJoRD4/ZqEFjuknaIbO7TW9WQLyE6TAhUVozt1rW7z1PamVbywkg4Mm+SB2ffGGCkDoFx3XcC4UEtL7UGtSK/0CL5iDxW0D7j3kvPvmOGHTNoOSzKKuRER7CKaRQWf43PWhdF2O3dYUrjc1pbsJXAu/M4YnZf7+T3U7QQsouoD/dpxvRr4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(39860400002)(136003)(376002)(54906003)(2906002)(76116006)(91956017)(33656002)(6512007)(66446008)(64756008)(66476007)(66556008)(53546011)(2616005)(122000001)(66946007)(6506007)(38100700002)(38070700005)(5660300002)(6486002)(316002)(83380400001)(6916009)(478600001)(86362001)(8936002)(4326008)(26005)(36756003)(186003)(8676002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W3a5/GB/LIyjREYM1qA51zug6D+qVhbTxoJfHNX/VSD5M03feLLirRtf2Haf?=
 =?us-ascii?Q?afU3hzMRTXBm+IdgXKy1q5m/beYAzhYizUVNm/dj+KMDrpWKHv8odSBX74pa?=
 =?us-ascii?Q?ccmKggd+XvMaH7WGNExchILNTwKtq75lIqh7EZnQ9P9NGt3xg01m1lQNH2V1?=
 =?us-ascii?Q?e43SXOEAugWJcjZARfImetq5pUbgb6aOdt+ePgdZtcR8Ixy+PFOPZGRtQjrP?=
 =?us-ascii?Q?8sDG7l0Dct8ImRzvj4wkZsXm8WU/mbPCXQv3q0qITfAUd++DbFQVK+YMx8NT?=
 =?us-ascii?Q?AASrCXd+6Aa/kslyOixPWEBYSerf7QZcNTBysEfQMcIHpysu4NxVRqEaiP5y?=
 =?us-ascii?Q?gy8WaNuYek41eTQBVJ3qpQPD197HxRvx2QLli+RR5IFBXyFlrmaKX01kz1n1?=
 =?us-ascii?Q?tJ8PRsWFaBp0lYY1vh9z/CnWG7AFxjrAGpBzMFsYU8tvNKXPpETfLljWmg1Y?=
 =?us-ascii?Q?JcHgNHYsXP1SuGaIvvFE50OtDUGRR2OT+F09S9Py1kUP8O/AgQCIT1I9JQW4?=
 =?us-ascii?Q?iamLMhuj2lCOjVvd2Uikd0yWeXw3V6MUrCX/lfv1kuv3apS18eFpNQ2V+e1F?=
 =?us-ascii?Q?d2kUWHmOq04l/Z/P8v67at2KZjkIVYyKK4fC/BDtkWOE0N478MFI5rpGpEvf?=
 =?us-ascii?Q?Piba/HWzprCtZRqroUkKZ/GkcG0UrjAvfhcPVgyERwbzkj+DCocFUamoBYce?=
 =?us-ascii?Q?D8iXquxzsNW/zE71/vwjyE/9CHvJ0WOdQBmBdIh2Y0/yNwcyIXvOg5J9bNpg?=
 =?us-ascii?Q?lP/EyS5S+CtWlOrIdx2mx/yvGcr8DoF+D4/E2Zez7g2yRr2DHtcZlMDLCFh0?=
 =?us-ascii?Q?fLhz9Zb9f4/I8qiOvJut7+d9CvCdiN5/4Jgee8aAmFZD2hqguBHdrJ14fP7M?=
 =?us-ascii?Q?2AzixVBMiiMUq07uQS8Nnnsv1e9mOxT4ipY8pqGqpLZswX/R2y2jlyVOnf09?=
 =?us-ascii?Q?fPOGmOFhw/xbA/YNwfrA0zjD6MBUactf38KIDvOYeyhEZc1H+VKEvaEg/8tO?=
 =?us-ascii?Q?v4av4wFWe+KxRxRrpONgCnKqVcr9d/QMBGTeasiYZzELSzd3v0buepHLKdni?=
 =?us-ascii?Q?9bRbRMin7F9lvfz3n4GBGiuPEpkL4lmKpn9vOlVA3t2ySKBuCO0q+Gkrts0a?=
 =?us-ascii?Q?XN0pGdp4knVzrumDrp2rENNZsRsDlxxlKPG9cRvimb4tfZYrtlme9oKf+uno?=
 =?us-ascii?Q?HdCQNTqUQdJDsHsBQ0Ddr25RqJMp9HFZbsaXxiiyI4HgjsD87YnoPxDAqQAR?=
 =?us-ascii?Q?yEunKpJ83/H5fNn+HzpUeKkr+laig59pH8JyBPR+OC44X50HDpl9XDm9cdI9?=
 =?us-ascii?Q?f3bupai20CYRvHdP4sbkXkiyw8c2KHOQhj1BI1bR3Hi8Lw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <59E1E3378A9A614E9D93294D18A5984F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76716c1-aa9b-41a3-a058-08d95b75b264
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 20:38:51.0800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LLWIwiIUsdoPbYpLQwrU4egpEwCcY4RzDfb4hmZQJr90HD2aexcJuc0O78+V3WMLtM80L9LGyaY7emPlsyf5Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2517
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090146
X-Proofpoint-GUID: x17gGHJBMMkTEKgflweRuH_BjqdtHbHv
X-Proofpoint-ORIG-GUID: x17gGHJBMMkTEKgflweRuH_BjqdtHbHv
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 9, 2021, at 4:37 PM, Anna Schumaker <anna.schumaker@netapp.com> wr=
ote:
>=20
> Hi Chuck,
>=20
> On Mon, Jul 19, 2021 at 10:55 AM Chuck Lever <chuck.lever@oracle.com> wro=
te:
>>=20
>> This is a set of patches I've been toying with to get better
>> responsiveness from a client when a transport remains connected but
>> the server is not returning RPC replies.
>>=20
>> The approach I've taken is to disable RPC_TASK_NO_RETRANS_TIMEOUT
>> for a few particular operations to enable them to time out even
>> though the connection is still operational. It could be
>> appropriate to take this approach for any idempotent operation
>> that cannot be killed with a ^C.
>>=20
>> Changes since RFC:
>> - Dropped changes to async lease renewal and DESTROY_SESSION|CLIENTID
>> - Cleaned up some tracepoint issues I found along the way
>=20
> Is this the latest version of these patches? If so I can include them
> in my linux-next branch for 5.14.

AFAIR v2 is the latest, yes. Thanks!


> Thanks,
> Anna
>=20
>>=20
>> ---
>>=20
>> Chuck Lever (6):
>>      SUNRPC: Refactor rpc_ping()
>>      SUNRPC: Unset RPC_TASK_NO_RETRANS_TIMEOUT for NULL RPCs
>>      SUNRPC: Remove unneeded TRACE_DEFINE_ENUMs
>>      SUNRPC: Update trace flags
>>      SUNRPC: xprt_retransmit() displays the the NULL procedure incorrect=
ly
>>      SUNRPC: Record timeout value in xprt_retransmit tracepoint
>>=20
>>=20
>> include/trace/events/sunrpc.h | 51 ++++++++---------------------------
>> net/sunrpc/clnt.c             | 33 ++++++++++++++++-------
>> 2 files changed, 35 insertions(+), 49 deletions(-)
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



