Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D248646797
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Dec 2022 04:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiLHDOG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Dec 2022 22:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLHDN7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Dec 2022 22:13:59 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2058.outbound.protection.outlook.com [40.107.113.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E929D89314
        for <linux-nfs@vger.kernel.org>; Wed,  7 Dec 2022 19:13:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ka4fGTCKmDb9b2r4XGqAeZW/jiEXTaXQo0DSSy7/VJcE4eA6rJd+tQQEbGd9W9eURg/kJ+LxFhQrkWumnKbwAp0rXhKwbbuU+6ZwIPVhfrB4g6foZy4VPpiUnn/g640oGM8TPHDlTj0PxfHVM84OSeMoL8zuKzEvN+++OsAnzSCgVN9UfZ+6KheUQMdmoYeAt175JDFzXfoGAZ5SeBsnUjMwgWn4EsgtgXXh9vYPYweq/rIe9ciZt+MyV1KVtOqRJyB9GlckX1SkU2Rc5kEtnX8rF+uDWn/0JT0ahjmedy5AVOVFN/HwZpqVzOu1CeNuhXnFP7kaHZkQQLRunQ9FZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STYxXmzVAEAX3OoUsV3CF7zi5H2ftY9fTvW9SG+Ywek=;
 b=koqGCTfgpI/C/Y8fmScfnSs0jfdTZWGFfz8epLskClYvttyQ2u5IaSLlnSLCTCnafKvRY7qZIWUQdPj7jienpy6LCZSy6viUjoa9jlI7iOFky0lkF/CxsZY/2+otHDbs8ZMeOJg6GVbmcsYb6t8U5y1oXZ9Y6Sef52ozmjWsLhrEkdS8Vypd6SItgoGassntNsa5qijUOSXT9nfpO3jN1wAXD6xTEie0u8LLKwp1WERKjShBToEpK9kZgYisGbsB2HqDxXFyc0ox6hYqt6LRBSAXjrgj/HhL4E7sI41rvaPpC4r7xjxmQAQLSAxrAEziYVQM9oQBEam/6Qp3+ZtFkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STYxXmzVAEAX3OoUsV3CF7zi5H2ftY9fTvW9SG+Ywek=;
 b=A+nA8Foqq0to5xEjqiUhgjqlUv/H8cjgkXpOS/zB82NhXhY8QytaJCPUVAbSxGgdy1pejotXahWhSJeo2wPoxm+Fbv4u14QN7S92hpNMaD8NR+Hqvm9R7BTMCm9AqfhlQ2Cd7N1kkGo1pOtZCs4HwvuLEfLiYX5tPVTsd4QGl6U=
Received: from TYAPR01MB4912.jpnprd01.prod.outlook.com (2603:1096:404:12c::17)
 by TYBPR01MB5310.jpnprd01.prod.outlook.com (2603:1096:404:8022::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 03:13:44 +0000
Received: from TYAPR01MB4912.jpnprd01.prod.outlook.com
 ([fe80::abe6:a95f:c66f:1c20]) by TYAPR01MB4912.jpnprd01.prod.outlook.com
 ([fe80::abe6:a95f:c66f:1c20%4]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 03:13:44 +0000
From:   =?iso-2022-jp?B?U0hJTUFNT1RPIEhJUk9TSEkoGyRCRWdLXCEhTTU7VhsoQik=?= 
        <h-shimamoto@nec.com>
To:     =?iso-2022-jp?B?U0hJTUFNT1RPIEhJUk9TSEkoGyRCRWdLXCEhTTU7VhsoQik=?= 
        <h-shimamoto@nec.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     minoura makoto <minoura@valinux.co.jp>
Subject: RE: [PATCH] SUNRPC: serialize gss upcalls for the same uid
Thread-Topic: [PATCH] SUNRPC: serialize gss upcalls for the same uid
Thread-Index: AQHZCfwg1B4nr+1+uk68l32Zh3LFZK5jUDqw
Date:   Thu, 8 Dec 2022 03:13:44 +0000
Message-ID: <TYAPR01MB491287D674889E7FB43D044FFF1D9@TYAPR01MB4912.jpnprd01.prod.outlook.com>
References: <20221207052341.3163040-1-h-shimamoto@nec.com>
In-Reply-To: <20221207052341.3163040-1-h-shimamoto@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB4912:EE_|TYBPR01MB5310:EE_
x-ms-office365-filtering-correlation-id: b261de09-591b-4d70-5bbe-08dad8ca3723
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yz5cFDgu/dmLGOR1fE96aiuUq4xCZLlcPGmkII3orBRScisC+2yiOmZJ/O2IWTQD9K/xWdvJvfifexY2/Ywa4jr4lNDUPU5ys1jNZ5jp6dylrPZ4s5EB0ef9ZAe1Cgg0BhyV4pU1n3J1yx9dA3BUcrBFZkrPVrRK1ElPRvXyM1QaW+urCqnYy3tIFleRxNAF7SpwuvZ0ZsCSgmttomp0vTBbckh7sN8twgT07dzAK1jTORpzfEOPdTey3E1dF2dfDuUb0cCd4wx3mpU1+4mY/XXeOtp9pPFtfjTXN91FTOH4GfM9h6ONtSsapo3O491xxsgu+uTnOOBZ6EcKQ8s9gKxSJmIdcL3IEV0lAQnJv2HdE8cM+BbdSwMFRKhNlog++fewkMR+vADGu9An11NtzLeucuJQN7piEcg5GeE7HZpuD1JPGGPngWe8Pv2lW+ZiTFL+K+oz5GOmoULj26oib9W1U91rZNXqkSQKtVVttY4cJNFrJhh1u2whMKSlLVFO0/d9qMFzgObnJ+uAemblPag0hi+ACOfNmWeD4u3qqu1K+47zNzZ31qqytBXKdXvx6LOSsDCKOrCwuwRSmImf7B5sy9JNvvA0VwYSUXWO7OFCSdUfUhfsH0LUGvTfEIgAMD2ab5BpBS0x5Wv9JAqQdTTTAMiRfOScLroitA9a9psnnEsFbE42cdGiKiAj+jbBftaO7E9SahpN3Ot5EeBAjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4912.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199015)(122000001)(83380400001)(8936002)(86362001)(82960400001)(2906002)(5660300002)(41300700001)(33656002)(38070700005)(4326008)(52536014)(186003)(26005)(6506007)(478600001)(7696005)(9686003)(64756008)(55236004)(55016003)(66946007)(8676002)(38100700002)(66556008)(66446008)(66476007)(110136005)(76116006)(316002)(71200400001)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?aUVMRG1BSEkvcWk4YVNLRCtEdzE1NGpLVG1WV05hME9pSlhqQk5kTnJP?=
 =?iso-2022-jp?B?cmN5d3FtaVdiWjdndHpVcU16UTN2VUNDMWxMNGtMKzFUZ2w4UVE5aDJy?=
 =?iso-2022-jp?B?RG0yQ2lLbGhLQk9Nd0RSY0srbG9EUWFCMTBLTkFaMkVoR1FzWGlTUCti?=
 =?iso-2022-jp?B?NW16OXVQeERGN1hjV3ZkRVhRUlNNR0g1dTl6cFo5Y05aWXZYZUQrbzVK?=
 =?iso-2022-jp?B?RFA3QklZU0xoWWo4MG5rL1l5eEd1dDUvMlRPMUJtL1dyOC8xWmE5VWxT?=
 =?iso-2022-jp?B?NzBhS0RHTkhTNWh2UE8wV2xEZHR3VGwvY2J4ZGZBTEQ0N1paZVVXcFhw?=
 =?iso-2022-jp?B?SElYVXV1VXo4VmVTME50dm14WUprbUd4ZHNtYlB2VEtlRVptd0ZiZHdv?=
 =?iso-2022-jp?B?cHJVbktoVjRTbTFzOGZ4UjhsM0pVK2ZxUjZEOXlNcHJVemFZb1pSVmw3?=
 =?iso-2022-jp?B?a3RYR0V0ZE1qM1lIRm43N1l4NmtyVmhhbVNTRHpnTUFNVSs3L2Rmdzk4?=
 =?iso-2022-jp?B?TXd0eHpJZ29XSWpuTTBweEhraGdpcDZ4Zms5NWxaYmYySlI4cVJVeFpv?=
 =?iso-2022-jp?B?aWp1N2lPWEFCbnNXRXVjZEhzVC9wTmxSemJkN3M1RW9QQVVhbitzMzg4?=
 =?iso-2022-jp?B?eTVRTzZDbnFsMTE4MmVxY3NqRExmQ0NNa3NHWUh1STJxU3I2ODE5UlU4?=
 =?iso-2022-jp?B?aWp5ZlVYWjYvbmpSdEs0TllDdGR2eWRlWWpzYy92Q3UreU5XanFJWFBt?=
 =?iso-2022-jp?B?WXVISjF2YmpYL0l6UHRTSktXNW1NcnE5L0lIY1F0M0xSV1p5T3RpQWhh?=
 =?iso-2022-jp?B?VVNsNkkwZ09BTFBNZUpjZkJsM0lRTUl2d2JvV0FIQ3d4TjdramcrWVVs?=
 =?iso-2022-jp?B?d2dlaStGSUJOSG1pRXFJSDRmd1I3ckF5T1lCZ0dDMEdXREhBelpLZ1VN?=
 =?iso-2022-jp?B?MHIyNWhwZk0zYXJPL3h0WGUyYjBzVWYzWXplc1d5SGZ4VHNvS09xaC9l?=
 =?iso-2022-jp?B?aVRla1VJR0pjU0VvYWRmSFRtdW82SHU0M2JxTGdJMklhRnp4QlR1WDRC?=
 =?iso-2022-jp?B?Z2pPemhjbmZkMGFLWmx6dStLeFMrdTBDRnNYTUlnSENWNnh6alN4Yy8z?=
 =?iso-2022-jp?B?dWsrdlZRRVZycFZUUTJNTUlCUmFNK0pxb1ZZVUlZUnhGcWlUb3M1aFo4?=
 =?iso-2022-jp?B?VmdpK296SmQrTUpOZ2xGZUhrbEg4WFNuSHMxMy9aMGhKbStmOEI5cUU0?=
 =?iso-2022-jp?B?T21GM3JKVUtVSHVOMDB6eE0zMlF1ZlNMNmRUMkxYOXlYQ0Yrc1ZGTjhF?=
 =?iso-2022-jp?B?bXAxNmJ3SVBEQ1Rya21HM3hDeFQ2U3Q1NzNDZmtlTkM1ZEo1MU9LZHo0?=
 =?iso-2022-jp?B?YWJsaC84eHFqQU84S0JYTHBPVXgvTWNFK1N6WC9ZRGpYODh6Vk1Mc3l5?=
 =?iso-2022-jp?B?VWtVc0hoZTRyZnpwcDJ3UkZTUTdCdEFhenVLZlRaTnpyb0NteWhEaFJB?=
 =?iso-2022-jp?B?aTNGYjRlaWdlWllVL3A4YzVFK0tBUUsyeGpPeDhrLzRFcWdDYktxZW5O?=
 =?iso-2022-jp?B?WGxCYm15MmV5UXlpVVYzUTl4UXZuWU92Zk5OQTNvY0FGRkZHQjBqaW51?=
 =?iso-2022-jp?B?a3RKODM4OWdYZlpBMTNlamVLdmNPWDMvcUhkL3NqMnNsNzJ3RnVpMmNu?=
 =?iso-2022-jp?B?anoxZy9sVDVVbVRVUHBsMVhESTNkek1TNVlsVWJFUDhtb1U0bnpNaFk2?=
 =?iso-2022-jp?B?d0NvRDFhTE4yckt6bGUyaVJiMzJVNnlzTW8rOSthd2d3VCtUZjBDaDdE?=
 =?iso-2022-jp?B?K0RPTjFoeVRnWTJ6Nm1vd2lEU0xJeE0rZldJeWkva201b2lwVVBvMDIv?=
 =?iso-2022-jp?B?RHpSdmNYTHZzbEZFTDlteVRKV0xmYmt2NVpTUDhPTHJWZm5kYUFJaUdr?=
 =?iso-2022-jp?B?Z09PYUY3Y284ZE5nSGNkeVhHTTNzMzA1czl2ei9wVVlOeFZSVTRDai93?=
 =?iso-2022-jp?B?cFBQRWRpV3JEeE14M1F5NzdsenlCWWxESDlPUlhMT0hjSVRRNjErYjRh?=
 =?iso-2022-jp?B?MFpSOWo4WG1wR0Y1b2l3c09Fby9DL3RRQnRIUVIycHRsYzQ2TlN2Z0Ev?=
 =?iso-2022-jp?B?ZVdKLzNIcW5Yd1BrMHE3SlRNTEFBc0xLNHFPSFF4TVlMQlBKeWIyT2JN?=
 =?iso-2022-jp?B?dEszY3pkYXFIa0RNaWsrT1FVUUZLTUpzdUtxS3I2MC9RQlRUSklGZTNo?=
 =?iso-2022-jp?B?d0hRbkNjVDFFajFhdEtZQVBYeC9RRzZxSXFKNU1kR0pQSUppMlI0VlhT?=
 =?iso-2022-jp?B?VGh1dg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB4912.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b261de09-591b-4d70-5bbe-08dad8ca3723
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 03:13:44.6247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3scw/xNoh8VQQDtbqbsvjJC/ldjXfXgJMYokkAPJe9rsoELeZ1o6d1brqaBMnYvnNW5TznHqbRGlEwjH0AR7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5310
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> Subject: [PATCH] SUNRPC: serialize gss upcalls for the same uid
>=20
> Commit 9130b8dbc6ac ("SUNRPC: allow for upcalls for the same uid
> but different gss service") introduced `auth` argument to
> __gss_find_upcall(), but in gss_pipe_downcall() it was left as NULL
> since it (and auth->service) was not (yet) determined.
>=20
> When multiple upcalls with the same uid and different service are
> ongoing, it could happen that __gss_find_upcall(), which returns the
> first match found in the pipe->in_downcall list, could not find the
> correct gss_msg corresponding to the downcall we are looking for due
> to two reasons:
>=20
> - the order of the msgs in pipe->in_downcall and those in pipe->pipe
>   (that is, the order of the upcalls sent to rpc.gssd) might be
>   different because pipe->lock is dropped between adding one to each
>   list.
> - rpc.gssd uses threads to write responses, which means we cannot
>   guarantee the order of responses.
>=20
> We could see mount.nfs process hung in D state with multiple mount.nfs
> are executed in parallel.  The call trace below is of CentOS 7.9
> kernel-3.10.0-1160.24.1.el7.x86_64 but we observed the same hang w/
> elrepo kernel-ml-6.0.7-1.el7.
>=20
> PID: 71258  TASK: ffff91ebd4be0000  CPU: 36  COMMAND: "mount.nfs"
>  #0 [ffff9203ca3234f8] __schedule at ffffffffa3b8899f
>  #1 [ffff9203ca323580] schedule at ffffffffa3b88eb9
>  #2 [ffff9203ca323590] gss_cred_init at ffffffffc0355818 [auth_rpcgss]
>  #3 [ffff9203ca323658] rpcauth_lookup_credcache at ffffffffc0421ebc [sunr=
pc]
>  #4 [ffff9203ca3236d8] gss_lookup_cred at ffffffffc0353633 [auth_rpcgss]
>  #5 [ffff9203ca3236e8] rpcauth_lookupcred at ffffffffc0421581 [sunrpc]
>  #6 [ffff9203ca323740] rpcauth_refreshcred at ffffffffc04223d3 [sunrpc]
>  #7 [ffff9203ca3237a0] call_refresh at ffffffffc04103dc [sunrpc]
>  #8 [ffff9203ca3237b8] __rpc_execute at ffffffffc041e1c9 [sunrpc]
>  #9 [ffff9203ca323820] rpc_execute at ffffffffc0420a48 [sunrpc]
>=20
> The scenario is like this. Let's say there are two upcalls for
> services A and B, A -> B in pipe->in_downcall, B -> A in pipe->pipe.
>=20
> When rpc.gssd reads pipe to get the upcall msg corresponding to
> service B from pipe->pipe and then writes the response, in
> gss_pipe_downcall the msg corresponding to service A will be picked
> because only uid is used to find the msg and it is before the one for
> B in pipe->in_downcall.  And the process waiting for the msg
> corresponding to service A will be woken up.
>=20
> Actual scheduing of that process might be after rpc.gssd processes the
> next msg.  In rpc_pipe_generic_upcall it clears msg->errno (for A).
> The process is scheduled to see gss_msg->ctx =3D=3D NULL and
> gss_msg->msg.errno =3D=3D 0, therefore it cannot break the loop in
> gss_create_upcall and is never woken up after that.
>=20
> This patch introduces wait and retry at gss_add_msg() to serialize
> when requests with the same uid but different service comes.
>=20
> Fixes: Commit 9130b8dbc6ac ("SUNRPC: allow for upcalls for the same uid b=
ut different gss service")
> Signed-off-by: Hiroshi Shimamoto <h-shimamoto@nec.com>
> Signed-off-by: minoura makoto <minoura@valinux.co.jp>
>=20
> ---
>  net/sunrpc/auth_gss/auth_gss.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gs=
s.c
> index 7bb247c51e2f..696f8c22c594 100644
> --- a/net/sunrpc/auth_gss/auth_gss.c
> +++ b/net/sunrpc/auth_gss/auth_gss.c
> @@ -296,14 +296,12 @@ gss_release_msg(struct gss_upcall_msg *gss_msg)
>  }
>=20
>  static struct gss_upcall_msg *
> -__gss_find_upcall(struct rpc_pipe *pipe, kuid_t uid, const struct gss_au=
th *auth)
> +__gss_find_upcall(struct rpc_pipe *pipe, kuid_t uid)
>  {
>  	struct gss_upcall_msg *pos;
>  	list_for_each_entry(pos, &pipe->in_downcall, list) {
>  		if (!uid_eq(pos->uid, uid))
>  			continue;
> -		if (auth && pos->auth->service !=3D auth->service)
> -			continue;
>  		refcount_inc(&pos->count);
>  		return pos;
>  	}
> @@ -319,14 +317,31 @@ gss_add_msg(struct gss_upcall_msg *gss_msg)
>  {
>  	struct rpc_pipe *pipe =3D gss_msg->pipe;
>  	struct gss_upcall_msg *old;
> +	DEFINE_WAIT(wait);
>=20
>  	spin_lock(&pipe->lock);
> -	old =3D __gss_find_upcall(pipe, gss_msg->uid, gss_msg->auth);
> +retry:
> +	old =3D __gss_find_upcall(pipe, gss_msg->uid);
>  	if (old =3D=3D NULL) {
>  		refcount_inc(&gss_msg->count);
>  		list_add(&gss_msg->list, &pipe->in_downcall);
> -	} else
> +	} else {
> +		if (old->auth->service !=3D gss_msg->auth->service) {
> +			prepare_to_wait(&old->waitqueue, &wait, TASK_KILLABLE);
> +			spin_unlock(&pipe->lock);
> +			if (fatal_signal_pending(current)) {
> +				finish_wait(&old->waitqueue, &wait);
> +				refcount_dec(&old->count);

Should we use gss_release_msg(old) ?
It might be the last decrement of the count and lead to resource leak.

Thanks,
Hiroshi

> +				return ERR_PTR(-ERESTARTSYS);
> +			}
> +			schedule();
> +			finish_wait(&old->waitqueue, &wait);
> +			gss_release_msg(old);
> +			spin_lock(&pipe->lock);
> +			goto retry;
> +		}
>  		gss_msg =3D old;
> +	}
>  	spin_unlock(&pipe->lock);
>  	return gss_msg;
>  }
> @@ -554,6 +569,10 @@ gss_setup_upcall(struct gss_auth *gss_auth, struct r=
pc_cred *cred)
>  	if (IS_ERR(gss_new))
>  		return gss_new;
>  	gss_msg =3D gss_add_msg(gss_new);
> +	if (IS_ERR(gss_msg)) {
> +		gss_release_msg(gss_new);
> +		return gss_msg;
> +	}
>  	if (gss_msg =3D=3D gss_new) {
>  		int res;
>  		refcount_inc(&gss_msg->count);
> @@ -732,7 +751,7 @@ gss_pipe_downcall(struct file *filp, const char __use=
r *src, size_t mlen)
>  	err =3D -ENOENT;
>  	/* Find a matching upcall */
>  	spin_lock(&pipe->lock);
> -	gss_msg =3D __gss_find_upcall(pipe, uid, NULL);
> +	gss_msg =3D __gss_find_upcall(pipe, uid);
>  	if (gss_msg =3D=3D NULL) {
>  		spin_unlock(&pipe->lock);
>  		goto err_put_ctx;
> --
> 2.25.1
