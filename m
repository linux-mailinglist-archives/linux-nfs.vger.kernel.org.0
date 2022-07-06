Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B82569165
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 20:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiGFSKp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 14:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiGFSKo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 14:10:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFC928E28
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 11:10:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266GMoY1006158;
        Wed, 6 Jul 2022 18:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E0eCl5p8oMmUE2b9nYW2xbT/1x79hdPgOwqNYtzU0E8=;
 b=vuLsROyk7LfE63/25YSbVl+wWkDgme4ibXzSURL0JMbq7Q8v3h9vC2dsKgJ8EMC1J0Wp
 hGh65cY7ajCOaRXofQsTR9jM2x9eCaMmDSC1JsxQ67lAaRZq6Rvocxg39w2HIKKHtYPM
 vBeP1EoFGIDs/MdBopqFTIMsgwf2eM8OHQicF0iHdavRTdaWtCP1I/Deo3QiQVfTMGSy
 +G4uSUul5xYcZhP+jwd07k7I7qlehZdt9PCxTULsfRlaYxEVkyfTg37ZisYCXEXiCMi8
 gpXqhvIHAjSomtHnwT8Ou9Yq8qQzYNTYuKnavh6G4JonATzXPtyOGt0DWK+AjtB2kd1b 6g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubytv1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 18:10:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266HfJOe016468;
        Wed, 6 Jul 2022 18:10:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud61ag8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 18:10:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=croWnFkRbZVImkD2mgKtDp6x1bDtPF684+Z7PhWgIG9o9Oha2d8l5vdv0GIbcUiLsjn1D8+LjRtNb8jDZnqivQ6Eszc3fDwPfUuHuT2gB0BSmJnCdahxk41o/N3/GNdV9IVWT0BI6BDHhT6V0qLNk5FTCUxzU3pcQRmxWBg8vrAjlwBMPJKYiTixK340EC69gaRt1jVZe7u6NaLMUAwJvEZUl1ChUVus0EXEgG4fVBDWOph34TPTimwQ4vWolPsnAc87ylsC5mvDCP7RcBpjWJ9x4iyqVcKa3FkXelpVkazirAXDceIW1P+3P+mweQ/tbuuqpb9MeIJwOE+cQSARKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0eCl5p8oMmUE2b9nYW2xbT/1x79hdPgOwqNYtzU0E8=;
 b=hihUrBWok8ce62Pd0ai4sfkgSEsmGh11EKPEhG4RYrweyzJ70TcUzPE1kppJs6wHdemOeqEDAUzxOGkBiqSk3t6Ts4ntZF7JSpRGIl0np8P60yQthaCvxheSTxJQFImNY+YiLmuHqd480YeAuI2l7YF9B0glJrolpqzQ8eG327zIop2r4rh28WBw/kGw+0Algt4hAxSit5paOrMLPie8zifiizwP7c7HGvueYbm9apjrM9xCMIpMJ31PRwddi1ErrsMwdSz7deNPufEGTHO8aIbKwO23ht1kcM6FYnIQgfYL53Y6bkmUww8nhwY7WwMXBMzRxkEWpNPYzjiQugyRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0eCl5p8oMmUE2b9nYW2xbT/1x79hdPgOwqNYtzU0E8=;
 b=luELhzog8lC7CcYGpuL6XKclFHYrQshSMsk3DhUj4v6owNnHTohZrRai2/30nddUGSyxjz/MkiJ90W4Lwwpuodw3K7ykv880/qTuPrPOmexpNODAGberReTgw4xsqpbP/dRt2V1Bw9VLka7QPrzlBEI/9057Se6lL5VBS63L18A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MWHPR10MB1408.namprd10.prod.outlook.com (2603:10b6:300:1f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 18:10:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 18:10:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>
Subject: Re: [PATCH v2 03/15] SUNRPC: Replace dprintk() call site in
 xs_data_ready
Thread-Topic: [PATCH v2 03/15] SUNRPC: Replace dprintk() call site in
 xs_data_ready
Thread-Index: AQHYebVsA5QfjiQznUipQF2FW+UKja1xxaoAgAAOQYA=
Date:   Wed, 6 Jul 2022 18:10:27 +0000
Message-ID: <DAE78CB7-4A01-4DB7-8E7A-788A311C52A9@oracle.com>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
 <165452704802.1496.15626296214203899256.stgit@oracle-102.nfsv4.dev>
 <8d04a3f22e170e117cdc605037932f29f6408d6b.camel@kernel.org>
In-Reply-To: <8d04a3f22e170e117cdc605037932f29f6408d6b.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2520903c-6233-4dae-2d0c-08da5f7ace5e
x-ms-traffictypediagnostic: MWHPR10MB1408:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fQxhRsf7tJi0+u9ccabtNcCs4adbJZWUczWODnCGYot5nlqsqqVRLZWm6K9ir/DC3Nr2PM0JgeSau9i+QQAwLOo+hPMYi2K8Ay7O5hSxbCqYyobqnbwlngSYgcMln9CKpwOfccwzLjfe6qfR4879E2PJRA4qz8oF9K4VEO0SjDHOGM/5nnYgbyRkzIzhl+U7OITa5Gmo+vEy65DPd76blbsphSuQoM8mssL8KY44a7POqJ/U7BTmT48KAhI9QN06P322+o13XpUp3vW3Xh0T3A8FmCbOjkIsr6BoEBh8b7XEhIt8IhnVBBq0gNFjSSAShw2Y1biL1lETRga4wrU1QQM2JtGFE7to2E5XOyWycZfqm8Kaeu8XNaEmSmg8kSIO8rxr7hHyRM36o645Y37ozgO3dIXlPbWoegpmjqQdHaBGZZ0xunsW/PwpEex50HiDANZPODV4sEmYyCG+/8qQ3YLIAnB2K6mB2+B0fLKbgq0o+D072hzPavyR+ubdcMcCWr8/88DEs9XfIxaBVyAuiAvUyv3OfkW5es7Rptdx0L0wycytPHaLQUHS39oZ21n6ylppbkscBwJjEBoESm2E/5EOztIbCbGSYM9Ex5ZPC/ChCgZ13lKJgV1P913r3SEKat62Vi5gkvPk0ChF74mzrEPXaT7xF417ZASm/UJvfSl0QVVDbYgt/Iul3vMpxWCZs4RnwNnhu4M2jWn+3fRmnHRi/HZAta6tIHwL1o4BOFVzoIgC83+aTk33TsXwFqeb0dA+HRCtkm1DYl3ToqTzXTZhkF28cFCJA8xdt5RcN/9DNIcvWbgL6ONFxHlDkDNrOBlStL3++zbJ90IRa/F+glwHrzALCi3Dwau+8+Cl1tE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(136003)(39860400002)(366004)(8936002)(6512007)(8676002)(6486002)(38100700002)(33656002)(478600001)(76116006)(66946007)(64756008)(4326008)(66476007)(66556008)(5660300002)(86362001)(2616005)(71200400001)(91956017)(38070700005)(122000001)(26005)(186003)(53546011)(316002)(36756003)(6916009)(41300700001)(6506007)(2906002)(83380400001)(54906003)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1QOszDy+EjzJ/5UG5I5+jmNeFVnvJOzTHhaXIW1eDS2CmKi664+KQumsQi4y?=
 =?us-ascii?Q?Wfjfl6k/C9Hja6++dpamGjkqZUGCs/I3n/pK7nuWXkcpdl3O/xdOzvsx2zcr?=
 =?us-ascii?Q?pqmoPuFFOlvW4sNxctA70xZ3dsU9Si/lDhX5Bo9Z4Ue/jk9RjU4pbqM0DWCa?=
 =?us-ascii?Q?bkFR1PNSb2q/mQ1PBty6kJ8fzKfjWXQg3b8VscoYQcObri9P39ePABMIG8hA?=
 =?us-ascii?Q?gjS20gOzqC2f/5RGbPrAuBeaSXOSzGFKsqLzlk6Ve0O6NkHI53/wqpak1nXx?=
 =?us-ascii?Q?46lBFobU9kSIpFRJ/1JdbKtotjZI2ACOh/ignau1wyqirci0xlVtqYjvlHiZ?=
 =?us-ascii?Q?76Xeo/SGOYtjUm2quF6km2fOwDTcqXvwq3S9zqjyZIf0Gp5Y1YQcp/T+W08s?=
 =?us-ascii?Q?UevjA1zf/deRj5E83ILuKg53xIsEdZ370fWG9Oax1Ah5s+CbAVQbmE+OOVNP?=
 =?us-ascii?Q?yODGOHdj7jH+LrvOcgQ0gBct6W2cpQPugWA3HlIWWqrXqsoKuD54qeQq70H0?=
 =?us-ascii?Q?+fOgKf1iNfbdZ8HXxZQPLYaDHf4+AaCXwSDJ20/Nj+/x4JZ/DQ3mGgo2RfiV?=
 =?us-ascii?Q?h5+zllV8XkaPm2VwITUfOVZ+ajVOKPKZDxgfeXTag86WB5BOSCilRsDHhwFv?=
 =?us-ascii?Q?tHHjyGP7XzCgibuQdAbuNo46OAKz1Cf3GG4cbIc1FxdR8nKBC3HATQhDvGmI?=
 =?us-ascii?Q?b4qGTpQhtIRq7Uf8Wu8jAqSXdaH2LqVj5i5vbUPunk4WdCX6hHLQFMmZe/tS?=
 =?us-ascii?Q?7DHUougz0HBi4R0HJ9sGc2fBiOy+yMbs7RALD8MNEHvNDwYEKEbgIVWzJhfo?=
 =?us-ascii?Q?A96WOpUs+dVPkxcdCuXbDLJUL5VS7Ac9HFM0B/i0GoG991pLok5CKetx/sxk?=
 =?us-ascii?Q?iUgvjzTfuL/cF7R5i+oMJyJzYcfimlKe53F8XEKbk722rHeNsukiBbjXRadh?=
 =?us-ascii?Q?FUZGBGyVF6wwDMpJ3hVlmtBATyPLXuZvcynzT+aZs2KYcGzNh3WyEufXij7f?=
 =?us-ascii?Q?T0Rr3M/j5LknNgTptCCjzaM9vQFvvlsNWddLW9MeggCwAvOAZyZ84FwU9zsW?=
 =?us-ascii?Q?WpuVza0ylAwEG7jiKN602mQKsiiikEZmMvfSVzUk1q/krLz/XyIpqP8x4QyL?=
 =?us-ascii?Q?IwCey2XTSbBvVm7/CHMkMxN3/DI3Qu5ofoR2J/onIf5nNgK03oswuLk8+CPh?=
 =?us-ascii?Q?I8orlZlGz594AW8dUVsLHAok08bbE0EFtedjdobsV683oedVM8sVcyWhWh0d?=
 =?us-ascii?Q?vM076idc6E0XtJFydthnXyQme4J7Ki0YlTzHdyu8WwU9+5rU1SLhQuJd52BP?=
 =?us-ascii?Q?3msnt6Rb56SrOcY+LayoH0hfQpm1429WXXsDpF9INt/kpTBlvWuOT8LFDvyp?=
 =?us-ascii?Q?aOSVF0jl019qfkXzxkdkBbY7Idin0/DhVSu6HA+2cBuh/XvSI5R+lxDxNKQD?=
 =?us-ascii?Q?YK8p00oKi19UMnj9uUtrbLpGdNbihnIIclAb9ROx9KpvGLqG9YzeTwQE1SDW?=
 =?us-ascii?Q?MJm7jRS6V5jATwsZ8tc+3SFDdbIV3e6PON8eCEWYevixoKsqWF01/SvgsNl6?=
 =?us-ascii?Q?U4ahAjvBYk3Kf9Myt5WYSeInZj4dTZxQhXCkLI012xv4OcNbcXQcbKcqZ4lQ?=
 =?us-ascii?Q?jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B22FCEC951856D41AADE5A35A1A0CF35@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2520903c-6233-4dae-2d0c-08da5f7ace5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 18:10:27.9116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QR9r4yh1g2z3rF0axnzMM7cfbnAouXpQLa1FWYu2dhRON1UHP7m2sz4/+el/zX/NewaC0qtcC9Yh+xsDpHk6wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1408
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_09:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060071
X-Proofpoint-ORIG-GUID: 6MZVgldkHoDevzImwiENAGreCC_Hn0Zg
X-Proofpoint-GUID: 6MZVgldkHoDevzImwiENAGreCC_Hn0Zg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 6, 2022, at 1:19 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-06-06 at 10:50 -0400, Chuck Lever wrote:
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> include/trace/events/sunrpc.h | 20 ++++++++++++++++++++
>> net/sunrpc/xprtsock.c | 6 ++++--
>> 2 files changed, 24 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc=
.h
>> index 3995c58a1c51..a66aa1f59ed8 100644
>> --- a/include/trace/events/sunrpc.h
>> +++ b/include/trace/events/sunrpc.h
>> @@ -1266,6 +1266,26 @@ TRACE_EVENT(xprt_reserve,
>> 	)
>> );
>>=20
>> +TRACE_EVENT(xs_data_ready,
>> +	TP_PROTO(
>> +		const struct rpc_xprt *xprt
>> +	),
>> +
>> +	TP_ARGS(xprt),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(addr, xprt->address_strings[RPC_DISPLAY_ADDR])
>> +		__string(port, xprt->address_strings[RPC_DISPLAY_PORT])
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(addr, xprt->address_strings[RPC_DISPLAY_ADDR]);
>> +		__assign_str(port, xprt->address_strings[RPC_DISPLAY_PORT]);
>> +	),
>>=20
>>=20
>=20
> This tracepoint is likely to fire rather often when it's enabled. Would
> it be more efficient to store the addr and port as binary data instead?

Yes, and it can use get_sockaddr() and friends for that. But those
patches were in flight when I wrote this one.


>> +
>> +	TP_printk("peer=3D[%s]:%s", __get_str(addr), __get_str(port))
>> +);
>> +
>> TRACE_EVENT(xs_stream_read_data,
>> 	TP_PROTO(struct rpc_xprt *xprt, ssize_t err, size_t total),
>>=20
>> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
>> index 650102a9c86a..73fab802996d 100644
>> --- a/net/sunrpc/xprtsock.c
>> +++ b/net/sunrpc/xprtsock.c
>> @@ -1378,7 +1378,7 @@ static void xs_udp_data_receive_workfn(struct work=
_struct *work)
>> }
>>=20
>> /**
>> - * xs_data_ready - "data ready" callback for UDP sockets
>> + * xs_data_ready - "data ready" callback for sockets
>> * @sk: socket with data to read
>> *
>> */
>> @@ -1386,11 +1386,13 @@ static void xs_data_ready(struct sock *sk)
>> {
>> 	struct rpc_xprt *xprt;
>>=20
>> -	dprintk("RPC: xs_data_ready...\n");
>> 	xprt =3D xprt_from_sock(sk);
>> 	if (xprt !=3D NULL) {
>> 		struct sock_xprt *transport =3D container_of(xprt,
>> 				struct sock_xprt, xprt);
>> +
>> +		trace_xs_data_ready(xprt);
>> +
>> 		transport->old_data_ready(sk);
>> 		/* Any data means we had a useful conversation, so
>> 		 * then we don't need to delay the next reconnect
>>=20
>>=20
>=20
> That dprintk was pretty worthless anyway. So the change seems fine to
> me.
>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



